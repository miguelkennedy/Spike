package ui.screens
{
	import flash.system.System;
	
	import feathers.controls.DragGesture;
	import feathers.controls.Label;
	import feathers.themes.BaseMaterialDeepGreyAmberMobileTheme;
	import feathers.themes.MaterialDeepGreyAmberMobileThemeIcons;
	
	import model.ModelLocator;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	import ui.AppInterface;
	import ui.screens.display.LayoutFactory;
	import ui.screens.display.settings.share.AppBadgeSettingsList;
	import ui.screens.display.settings.share.DexcomSettingsList;
	import ui.screens.display.settings.share.HealthkitSettingsList;
	import ui.screens.display.settings.share.NightscoutSettingsList;
	import ui.screens.display.settings.share.NotificationSettingsList;
	
	import utilities.Constants;
	
	[ResourceBundle("sharesettingsscreen")]

	public class ShareSettingsScreen extends BaseSubScreen
	{
		/* Display Objects */
		private var healthkitSettings:HealthkitSettingsList;
		private var dexcomSettings:DexcomSettingsList;
		private var nightscoutSettings:NightscoutSettingsList;
		private var healthkitLabel:Label;
		private var dexcomLabel:Label;
		private var nightscoutLabel:Label;
		private var notificationsLabel:Label;
		private var notificationSettings:NotificationSettingsList;
		private var appBadgeLabel:Label;
		private var appBadgeSettings:AppBadgeSettingsList;
		
		public function ShareSettingsScreen() 
		{
			super();
			
			setupHeader();	
		}
		override protected function initialize():void 
		{
			super.initialize();
			
			setupContent();
			adjustMainMenu();
		}
		
		/**
		 * Functionality
		 */
		private function setupHeader():void
		{
			/* Set Header Title */
			title = ModelLocator.resourceManagerInstance.getString('sharesettingsscreen','share_settings_title');
			
			/* Set Header Icon */
			icon = getScreenIcon(MaterialDeepGreyAmberMobileThemeIcons.shareTexture);
			iconContainer = new <DisplayObject>[icon];
			headerProperties.rightItems = iconContainer;
		}
		
		private function setupContent():void
		{
			//Deactivate menu drag gesture 
			AppInterface.instance.drawers.openGesture = DragGesture.NONE;
			
			//Notifications Section Label
			notificationsLabel = LayoutFactory.createSectionLabel(ModelLocator.resourceManagerInstance.getString('sharesettingsscreen','bg_notifications_section_label'), false);
			screenRenderer.addChild(notificationsLabel);
			
			//Notification Settings
			notificationSettings = new NotificationSettingsList();
			screenRenderer.addChild(notificationSettings);
			
			//App Badge Section Label
			appBadgeLabel = LayoutFactory.createSectionLabel(ModelLocator.resourceManagerInstance.getString('sharesettingsscreen','bg_app_badge_section_label'), true);
			screenRenderer.addChild(appBadgeLabel);
			
			//App Badge Settings
			appBadgeSettings = new AppBadgeSettingsList();
			screenRenderer.addChild(appBadgeSettings);
			
			//Healthkit Section Label
			healthkitLabel = LayoutFactory.createSectionLabel(ModelLocator.resourceManagerInstance.getString('sharesettingsscreen','healthkit_section_label'), true);
			screenRenderer.addChild(healthkitLabel);
			
			//Healthkit Settings
			healthkitSettings = new HealthkitSettingsList();
			screenRenderer.addChild(healthkitSettings);
			
			//Dexcom Section Label
			dexcomLabel = LayoutFactory.createSectionLabel(ModelLocator.resourceManagerInstance.getString('sharesettingsscreen','dexcom_share_section_label'), true);
			screenRenderer.addChild(dexcomLabel);
			
			//Dexcom Settings
			dexcomSettings = new DexcomSettingsList();
			screenRenderer.addChild(dexcomSettings);
			
			//Nightscout Section Label
			nightscoutLabel = LayoutFactory.createSectionLabel(ModelLocator.resourceManagerInstance.getString('sharesettingsscreen','nightscout_section_label'), true);
			screenRenderer.addChild(nightscoutLabel);
			
			//Nightscout Settings
			nightscoutSettings = new NightscoutSettingsList();
			screenRenderer.addChild(nightscoutSettings);
		}
		
		private function adjustMainMenu():void
		{
			AppInterface.instance.menu.selectedIndex = 3;
		}
		
		/**
		 * Event Handlers
		 */
		override protected function onBackButtonTriggered(event:Event):void
		{
			//Save Settings
			if (notificationSettings.needsSave)
				notificationSettings.save();
			if (appBadgeSettings.needsSave)
				appBadgeSettings.save();
			if (healthkitSettings.needsSave)
				healthkitSettings.save();
			if (dexcomSettings.needsSave)
				dexcomSettings.save();nightscoutSettings
			if (nightscoutSettings.needsSave)
				nightscoutSettings.save();
			
			//Activate menu drag gesture
			AppInterface.instance.drawers.openGesture = DragGesture.EDGE;
			
			//Pop Screen
			dispatchEventWith(Event.COMPLETE);
		}
		
		/**
		 * Utility
		 */
		override public function dispose():void
		{
			if (healthkitSettings != null)
			{
				healthkitSettings.dispose();
				healthkitSettings = null;
			}
			
			if (dexcomSettings != null)
			{
				dexcomSettings.dispose();
				dexcomSettings = null;
			}
			
			if (nightscoutSettings != null)
			{
				nightscoutSettings.dispose();
				nightscoutSettings = null;
			}
			
			if (dexcomLabel != null)
			{
				dexcomLabel.dispose();
				dexcomLabel = null;
			}
			
			if (nightscoutLabel != null)
			{
				nightscoutLabel.dispose();
				nightscoutLabel = null;
			}
			
			if (notificationSettings != null)
			{
				notificationSettings.dispose();
				notificationSettings = null;
			}
			
			if (notificationsLabel != null)
			{
				notificationsLabel.dispose();
				notificationsLabel = null;
			}
			
			if (appBadgeLabel != null)
			{
				appBadgeLabel.dispose();
				appBadgeLabel = null;
			}
			
			if (appBadgeSettings != null)
			{
				appBadgeSettings.dispose();
				appBadgeSettings = null;
			}
			
			super.dispose();
			
			System.pauseForGCIfCollectionImminent(0);
		}
		
		override protected function draw():void 
		{
			super.draw();
			icon.x = Constants.stageWidth - icon.width - BaseMaterialDeepGreyAmberMobileTheme.defaultPanelPadding;
		}
	}
}