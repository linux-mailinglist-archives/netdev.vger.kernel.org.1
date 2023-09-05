Return-Path: <netdev+bounces-32092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3676792327
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 15:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A622811B4
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7E2D51D;
	Tue,  5 Sep 2023 13:48:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62034D517
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 13:48:31 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F716191
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=18jntY8SRDdOKiJZsjQk5aSWqdopr2e4UMzV5sK8Pvs=; b=QQMIPSehMIVy0GUK4dzzZwb1Tt
	So00TgDx7244R3beSmoVrm/TbSidcmlJ3k+UNbSQzoytTkvR1csi1T6p5Svsz2HZV/fEByCFiFaKq
	tRv95n0fDE9lWCwoWHO7ODaRnUpgYUWk8aELWwgINLgfn16KA/pPb8VqEI0mlmCwF+3C5SSnTmfsu
	kjiQGFynajpFUFJlSpafCMLE6kcWijlMAf0OymOHJDCV/ei7ltCcxI0ytIbxrzvfOCoojSCu7Jf7q
	vy5rbE7RIgG8O2qRkG+JWUha9ncaqxWoHOSWJWq+419vilrZKCl4qwm0YRRIYh5r64GN2huc0QDJF
	F90b/CVA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53228)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qdWPf-0007vH-2g;
	Tue, 05 Sep 2023 14:48:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qdWPc-0003jQ-UP; Tue, 05 Sep 2023 14:48:12 +0100
Date: Tue, 5 Sep 2023 14:48:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Andrew Lunn <andrew@lunn.ch>, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	"shenjian15@huawei.com" <shenjian15@huawei.com>,
	"liuyonglong@huawei.com" <liuyonglong@huawei.com>,
	wangjie125@huawei.com, chenhao418@huawei.com,
	Hao Lan <lanhao@huawei.com>,
	"wangpeiyang1@huawei.com" <wangpeiyang1@huawei.com>
Subject: Re: [PATCH net-next] net: phy: avoid kernel warning dump when
 stopping an errored PHY
Message-ID: <ZPcxnHjDJIMe3xt5@shell.armlinux.org.uk>
References: <aed0bc3b-2d48-2fd9-9587-5910ad68c180@gmail.com>
 <8e7e02d8-2b2a-8619-e607-fbac50706252@huawei.com>
 <fd08a80d-c70b-4943-8cca-b038f54f8eaa@lunn.ch>
 <29917acb-bd80-10e5-b1ae-c844ea0e9cbb@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Y86eQW0HPYCMXbQD"
Content-Disposition: inline
In-Reply-To: <29917acb-bd80-10e5-b1ae-c844ea0e9cbb@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--Y86eQW0HPYCMXbQD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 05, 2023 at 04:49:31PM +0800, Jijie Shao wrote:
> We note there are several times lock during phy_state_machine(). The first
> is to handle phydev state. It's noting that a competition of phydev lock
> happend again if phy_check_link_status() returns an error. Why we don't
> held lock until changing state to PHY_ERROR if phy_check_link_status()
> returns an error?

You are quite correct that isn't very good. We can easily get rid of
some of this mess, but I don't think all which leaves it still open to
the race you describe.

The problem is phy_suspend().

First, it calls phy_ethtool_get_wol() which takes the phydev lock. This
can be dealt with if we save the state at probe time, and then update
the state when phy_ethtool_set_wol() is called.

Second, phy_suspend() calls ->suspend without holding the phydev lock,
and holding the lock while calling that may not be safe. Having had a
brief look over the implementations (but not delving into any PTP
function they may call) does seem to suggest that shouldn't be a big
problem, but I don't know whether holding the phydev lock while calling
PTP functions is likely to cause issues.

However, looking at that has lead me to the conclusion that there is a
lot of duplication of WoL condition testing. phy_suspend() already
avoids calling ->suspend() if either phy_ethtool_get_wol() indicates
that WoL is enabled, or if the netdev says WoL is enabled.

Many of the ->suspend() implementations, for example,
lan88xx_suspend(), dp83822_suspend(), etc test some kind of flag to
determine whether WoL is enabled and thus seem to be re-implementing
what phy_suspend() is already doing. I think there is scope to delete
this code from several drivers.

The easy bits are the patches I've attached to this email. These
won't on their own be sufficient to close the race you've identified
due to the phy_suspend() issue, but are the best we can do until we
can work out what to do about that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--Y86eQW0HPYCMXbQD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-phy-always-call-phy_process_state_change-under-l.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next 1/3] net: phy: always call phy_process_state_change()
 under lock

phy_stop() calls phy_process_state_change() while holding the phydev
lock, so also arrange for phy_state_machine() to do the same, so that
this function is called with consistent locking.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index df54c137c5f5..1e5218935eb3 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1506,6 +1506,7 @@ void phy_state_machine(struct work_struct *work)
 	if (err < 0)
 		phy_error_precise(phydev, func, err);
 
+	mutex_lock(&phydev->lock);
 	phy_process_state_change(phydev, old_state);
 
 	/* Only re-schedule a PHY state machine change if we are polling the
@@ -1516,7 +1517,6 @@ void phy_state_machine(struct work_struct *work)
 	 * state machine would be pointless and possibly error prone when
 	 * called from phy_disconnect() synchronously.
 	 */
-	mutex_lock(&phydev->lock);
 	if (phy_polling_mode(phydev) && phy_is_started(phydev))
 		phy_queue_state_machine(phydev, PHY_STATE_TIME);
 	mutex_unlock(&phydev->lock);
-- 
2.30.2


--Y86eQW0HPYCMXbQD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-net-phy-call-phy_error_precise-while-holding-the-loc.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next 2/3] net: phy: call phy_error_precise() while holding
 the lock

Move the locking out of phy_error_precise() and to its only call site,
merging with the locked region that has already been taken.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 1e5218935eb3..990d387b31bd 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1231,9 +1231,7 @@ static void phy_error_precise(struct phy_device *phydev,
 			      const void *func, int err)
 {
 	WARN(1, "%pS: returned: %d\n", func, err);
-	mutex_lock(&phydev->lock);
 	phy_process_error(phydev);
-	mutex_unlock(&phydev->lock);
 }
 
 /**
@@ -1503,10 +1501,10 @@ void phy_state_machine(struct work_struct *work)
 	if (err == -ENODEV)
 		return;
 
+	mutex_lock(&phydev->lock);
 	if (err < 0)
 		phy_error_precise(phydev, func, err);
 
-	mutex_lock(&phydev->lock);
 	phy_process_state_change(phydev, old_state);
 
 	/* Only re-schedule a PHY state machine change if we are polling the
-- 
2.30.2


--Y86eQW0HPYCMXbQD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-net-phy-move-call-to-start-aneg.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next 3/3] net: phy: move call to start aneg

Move the call to start auto-negotiation inside the lock in the PHYLIB
state machine, calling the locked variant _phy_start_aneg(). This
avoids unnecessarily releasing and re-acquiring the lock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 990d387b31bd..5bb33af2a4cb 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1489,14 +1489,15 @@ void phy_state_machine(struct work_struct *work)
 		break;
 	}
 
+	if (needs_aneg) {
+		err = _phy_start_aneg(phydev);
+		func = &_phy_start_aneg;
+	}
+
 	mutex_unlock(&phydev->lock);
 
-	if (needs_aneg) {
-		err = phy_start_aneg(phydev);
-		func = &phy_start_aneg;
-	} else if (do_suspend) {
+	if (do_suspend)
 		phy_suspend(phydev);
-	}
 
 	if (err == -ENODEV)
 		return;
-- 
2.30.2


--Y86eQW0HPYCMXbQD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0004-net-phy-track-PHY-WoL-enable-state.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next 4/4] net: phy: track PHY WoL enable state

Track the PHY Wake-on-LAN enable state so we don't need to call
phy_ethtool_get_wol() in phy_suspend(), thus taking the phydev lock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c        | 10 ++++++++++
 drivers/net/phy/phy_device.c | 17 ++++++++++++++---
 include/linux/phy.h          |  2 ++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 5bb33af2a4cb..2324544aae0d 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1644,11 +1644,21 @@ EXPORT_SYMBOL(phy_ethtool_set_eee);
  */
 int phy_ethtool_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
 {
+	struct ethtool_wolinfo w = { .cmd = ETHTOOL_GWOL };
 	int ret;
 
 	if (phydev->drv && phydev->drv->set_wol) {
 		mutex_lock(&phydev->lock);
 		ret = phydev->drv->set_wol(phydev, wol);
+
+		/* Read back the WoL enabled state for the PHY and update
+		 * our saved state.
+		 */
+		if (phydev->drv->get_wol) {
+			phydev->drv->get_wol(phydev, &w);
+			phydev->phy_wol_enabled = w.wolopts;
+		}
+
 		mutex_unlock(&phydev->lock);
 
 		return ret;
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..c874c1ec5ada 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1850,7 +1850,6 @@ EXPORT_SYMBOL(phy_detach);
 
 int phy_suspend(struct phy_device *phydev)
 {
-	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
 	struct net_device *netdev = phydev->attached_dev;
 	struct phy_driver *phydrv = phydev->drv;
 	int ret;
@@ -1858,8 +1857,9 @@ int phy_suspend(struct phy_device *phydev)
 	if (phydev->suspended)
 		return 0;
 
-	phy_ethtool_get_wol(phydev, &wol);
-	phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
+	phydev->wol_enabled = phydev->phy_wol_enabled ||
+			      (netdev && netdev->wol_enabled);
+
 	/* If the device has WOL enabled, we cannot suspend the PHY */
 	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
 		return -EBUSY;
@@ -3251,6 +3251,14 @@ struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_get_phy_node);
 
+static void phy_update_wol_state(struct phy_device *phydev)
+{
+	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
+
+	phy_ethtool_get_wol(phydev, &wol);
+	phydev->phy_wol_enabled = wol.wolopts;
+}
+
 /**
  * phy_probe - probe and init a PHY device
  * @dev: device to probe and init
@@ -3364,6 +3372,9 @@ static int phy_probe(struct device *dev)
 	/* Set the state to READY by default */
 	phydev->state = PHY_READY;
 
+	/* Initialise phydev->wol_enabled state */
+	phy_update_wol_state(phydev);
+
 	/* Get the LEDs from the device tree, and instantiate standard
 	 * LEDs for them.
 	 */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5dcab361a220..514c1d077bb9 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -557,6 +557,7 @@ struct macsec_ops;
  * @downshifted_rate: Set true if link speed has been downshifted.
  * @is_on_sfp_module: Set true if PHY is located on an SFP module.
  * @mac_managed_pm: Set true if MAC driver takes of suspending/resuming PHY
+ * @phy_wol_enabled: Set to true if the PHY has Wake-on-Lan enabled.
  * @wol_enabled: Set to true if the PHY or the attached MAC have Wake-on-LAN
  * 		 enabled.
  * @state: State of the PHY for management purposes
@@ -655,6 +656,7 @@ struct phy_device {
 	unsigned downshifted_rate:1;
 	unsigned is_on_sfp_module:1;
 	unsigned mac_managed_pm:1;
+	unsigned phy_wol_enabled:1;
 	unsigned wol_enabled:1;
 
 	unsigned autoneg:1;
-- 
2.30.2


--Y86eQW0HPYCMXbQD--

