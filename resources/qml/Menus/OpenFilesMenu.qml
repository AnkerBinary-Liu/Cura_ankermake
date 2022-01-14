// Copyright (c) 2022 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.2
import QtQuick.Controls 2.1

import UM 1.6 as UM
import Cura 1.0 as Cura

import "../Dialogs"

UM.Menu
{
    id: openFilesMenu
    title: catalog.i18nc("@title:menu menubar:file", "Open File(s)...")

    Instantiator
    {
        id: fileProviders
        model: CuraApplication.getFileProviderModel()
        Cura.MenuItem
        {
            text:
            {
                return model.displayText;
            }
            onTriggered:
            {
                if (model.index == 0)  // The 0th element is the "From Disk" option, which should activate the open local file dialog
                {
                    Cura.Actions.open.trigger()
                }
                else
                {
                    CuraApplication.getFileProviderModel().trigger(model.name);
                }
            }
            // Unassign the shortcuts when the submenu is invisible (i.e. when there is only one file provider) to avoid ambiguous shortcuts.
            // When there is a single file provider, the openAction is assigned with the Ctrl+O shortcut instead.
            shortcut: openFilesMenu.visible ? model.shortcut : ""
            visible: openFilesMenu.visible
        }
        onObjectAdded: openFilesMenu.insertItem(index, object)
        onObjectRemoved: openFilesMenu.removeItem(object)
    }
}
