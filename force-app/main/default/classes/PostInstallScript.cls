global class PostInstallScript implements InstallHandler {
    global void onInstall(InstallContext context) {
        // Run specific logic only on fresh install or specific upgrades
        if (context.previousVersion() == null) {
            placeholderPostInstallActions();
        }
    }

    private void placeholderPostInstallActions() {
        System.debug('Placeholder Post Install Actions...');
    }
}