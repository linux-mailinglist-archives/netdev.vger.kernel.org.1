Return-Path: <netdev+bounces-32104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5E47923EA
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 17:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248E31C209F4
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4ADD531;
	Tue,  5 Sep 2023 15:25:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4CCD525
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 15:25:13 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AF8128
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cRVRGabOf5HK4uSykSyRB/9MKoHcxUzGxWI9tGmZQiA=; b=VkP/10KYOevqEjabGVs4oN3K2T
	vnKLvl9MCMmiL3ZgOvEHDELONfb4uJw49lIXSNxc/EKOD+NwnxDUMKzmXVuTkr8GRHFfm3CX3x60p
	vCkR3OrxmXpWh2XrpBGC4r627Gs8C03PCmU6ezWJ/4dqkX9J6MzAfjrKeEU5WrgZPgNdB5Jrrpzdn
	nD9rRE0i48vWFWDTsFzF7poUTFMPuUhlCmCCrT+n4YX1RE6mcuhJdcOJdv+1jccWYsEnM2KQnGjiY
	aNURuOXigqBQgYGjHg02vwyR1yAwqLYm7lgfr75kGEWJtX4MxvNGTpy+FiuxuHkF6N5zdH3f2cMS7
	pbgB2gdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40858)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qdXvH-00081E-2m;
	Tue, 05 Sep 2023 16:24:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qdXvF-0003nF-LD; Tue, 05 Sep 2023 16:24:57 +0100
Date: Tue, 5 Sep 2023 16:24:57 +0100
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
Message-ID: <ZPdISTBrrX345RCz@shell.armlinux.org.uk>
References: <aed0bc3b-2d48-2fd9-9587-5910ad68c180@gmail.com>
 <8e7e02d8-2b2a-8619-e607-fbac50706252@huawei.com>
 <fd08a80d-c70b-4943-8cca-b038f54f8eaa@lunn.ch>
 <29917acb-bd80-10e5-b1ae-c844ea0e9cbb@huawei.com>
 <ZPcxnHjDJIMe3xt5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="f4j4EWQpC9fDDtdz"
Content-Disposition: inline
In-Reply-To: <ZPcxnHjDJIMe3xt5@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--f4j4EWQpC9fDDtdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 05, 2023 at 02:48:13PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 05, 2023 at 04:49:31PM +0800, Jijie Shao wrote:
> > We note there are several times lock during phy_state_machine(). The first
> > is to handle phydev state. It's noting that a competition of phydev lock
> > happend again if phy_check_link_status() returns an error. Why we don't
> > held lock until changing state to PHY_ERROR if phy_check_link_status()
> > returns an error?
> 
> You are quite correct that isn't very good. We can easily get rid of
> some of this mess, but I don't think all which leaves it still open to
> the race you describe.
> 
> The problem is phy_suspend().
> 
> First, it calls phy_ethtool_get_wol() which takes the phydev lock. This
> can be dealt with if we save the state at probe time, and then update
> the state when phy_ethtool_set_wol() is called.
> 
> Second, phy_suspend() calls ->suspend without holding the phydev lock,
> and holding the lock while calling that may not be safe. Having had a
> brief look over the implementations (but not delving into any PTP
> function they may call) does seem to suggest that shouldn't be a big
> problem, but I don't know whether holding the phydev lock while calling
> PTP functions is likely to cause issues.
> 
> However, looking at that has lead me to the conclusion that there is a
> lot of duplication of WoL condition testing. phy_suspend() already
> avoids calling ->suspend() if either phy_ethtool_get_wol() indicates
> that WoL is enabled, or if the netdev says WoL is enabled.
> 
> Many of the ->suspend() implementations, for example,
> lan88xx_suspend(), dp83822_suspend(), etc test some kind of flag to
> determine whether WoL is enabled and thus seem to be re-implementing
> what phy_suspend() is already doing. I think there is scope to delete
> this code from several drivers.
> 
> The easy bits are the patches I've attached to this email. These
> won't on their own be sufficient to close the race you've identified
> due to the phy_suspend() issue, but are the best we can do until we
> can work out what to do about that.

Having looked deeper at this, I think there may be a solution. See
these follow-on patches.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--f4j4EWQpC9fDDtdz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0005-net-phy-move-phy_suspend-to-end-of-phy_state_machine.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Bcc: linux@mail.armlinux.org.uk
Subject: [PATCH net-next 5/8] net: phy: move phy_suspend() to end of
 phy_state_machine()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

Move the call to phy_suspend() to the end of phy_state_machine() after
we release the lock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 2324544aae0d..010e54d7ccb2 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1494,15 +1494,11 @@ void phy_state_machine(struct work_struct *work)
 		func = &_phy_start_aneg;
 	}
 
-	mutex_unlock(&phydev->lock);
-
-	if (do_suspend)
-		phy_suspend(phydev);
-
-	if (err == -ENODEV)
+	if (err == -ENODEV) {
+		mutex_unlock(&phydev->lock);
 		return;
+	}
 
-	mutex_lock(&phydev->lock);
 	if (err < 0)
 		phy_error_precise(phydev, func, err);
 
@@ -1519,6 +1515,9 @@ void phy_state_machine(struct work_struct *work)
 	if (phy_polling_mode(phydev) && phy_is_started(phydev))
 		phy_queue_state_machine(phydev, PHY_STATE_TIME);
 	mutex_unlock(&phydev->lock);
+
+	if (do_suspend)
+		phy_suspend(phydev);
 }
 
 /**
-- 
2.30.2


--f4j4EWQpC9fDDtdz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0006-net-phy-move-phy_state_machine.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Bcc: linux@mail.armlinux.org.uk
Subject: [PATCH net-next 6/8] net: phy: move phy_state_machine()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

Move phy_state_machine() before phy_stop() to avoid subsequent patches
introducing forward references.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 152 +++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 010e54d7ccb2..508a5434684a 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1353,82 +1353,6 @@ void phy_free_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_free_interrupt);
 
-/**
- * phy_stop - Bring down the PHY link, and stop checking the status
- * @phydev: target phy_device struct
- */
-void phy_stop(struct phy_device *phydev)
-{
-	struct net_device *dev = phydev->attached_dev;
-	enum phy_state old_state;
-
-	if (!phy_is_started(phydev) && phydev->state != PHY_DOWN &&
-	    phydev->state != PHY_ERROR) {
-		WARN(1, "called from state %s\n",
-		     phy_state_to_str(phydev->state));
-		return;
-	}
-
-	mutex_lock(&phydev->lock);
-	old_state = phydev->state;
-
-	if (phydev->state == PHY_CABLETEST) {
-		phy_abort_cable_test(phydev);
-		netif_testing_off(dev);
-	}
-
-	if (phydev->sfp_bus)
-		sfp_upstream_stop(phydev->sfp_bus);
-
-	phydev->state = PHY_HALTED;
-	phy_process_state_change(phydev, old_state);
-
-	mutex_unlock(&phydev->lock);
-
-	phy_state_machine(&phydev->state_queue.work);
-	phy_stop_machine(phydev);
-
-	/* Cannot call flush_scheduled_work() here as desired because
-	 * of rtnl_lock(), but PHY_HALTED shall guarantee irq handler
-	 * will not reenable interrupts.
-	 */
-}
-EXPORT_SYMBOL(phy_stop);
-
-/**
- * phy_start - start or restart a PHY device
- * @phydev: target phy_device struct
- *
- * Description: Indicates the attached device's readiness to
- *   handle PHY-related work.  Used during startup to start the
- *   PHY, and after a call to phy_stop() to resume operation.
- *   Also used to indicate the MDIO bus has cleared an error
- *   condition.
- */
-void phy_start(struct phy_device *phydev)
-{
-	mutex_lock(&phydev->lock);
-
-	if (phydev->state != PHY_READY && phydev->state != PHY_HALTED) {
-		WARN(1, "called from state %s\n",
-		     phy_state_to_str(phydev->state));
-		goto out;
-	}
-
-	if (phydev->sfp_bus)
-		sfp_upstream_start(phydev->sfp_bus);
-
-	/* if phy was suspended, bring the physical link up again */
-	__phy_resume(phydev);
-
-	phydev->state = PHY_UP;
-
-	phy_start_machine(phydev);
-out:
-	mutex_unlock(&phydev->lock);
-}
-EXPORT_SYMBOL(phy_start);
-
 /**
  * phy_state_machine - Handle the state machine
  * @work: work_struct that describes the work to be done
@@ -1520,6 +1444,82 @@ void phy_state_machine(struct work_struct *work)
 		phy_suspend(phydev);
 }
 
+/**
+ * phy_stop - Bring down the PHY link, and stop checking the status
+ * @phydev: target phy_device struct
+ */
+void phy_stop(struct phy_device *phydev)
+{
+	struct net_device *dev = phydev->attached_dev;
+	enum phy_state old_state;
+
+	if (!phy_is_started(phydev) && phydev->state != PHY_DOWN &&
+	    phydev->state != PHY_ERROR) {
+		WARN(1, "called from state %s\n",
+		     phy_state_to_str(phydev->state));
+		return;
+	}
+
+	mutex_lock(&phydev->lock);
+	old_state = phydev->state;
+
+	if (phydev->state == PHY_CABLETEST) {
+		phy_abort_cable_test(phydev);
+		netif_testing_off(dev);
+	}
+
+	if (phydev->sfp_bus)
+		sfp_upstream_stop(phydev->sfp_bus);
+
+	phydev->state = PHY_HALTED;
+	phy_process_state_change(phydev, old_state);
+
+	mutex_unlock(&phydev->lock);
+
+	phy_state_machine(&phydev->state_queue.work);
+	phy_stop_machine(phydev);
+
+	/* Cannot call flush_scheduled_work() here as desired because
+	 * of rtnl_lock(), but PHY_HALTED shall guarantee irq handler
+	 * will not reenable interrupts.
+	 */
+}
+EXPORT_SYMBOL(phy_stop);
+
+/**
+ * phy_start - start or restart a PHY device
+ * @phydev: target phy_device struct
+ *
+ * Description: Indicates the attached device's readiness to
+ *   handle PHY-related work.  Used during startup to start the
+ *   PHY, and after a call to phy_stop() to resume operation.
+ *   Also used to indicate the MDIO bus has cleared an error
+ *   condition.
+ */
+void phy_start(struct phy_device *phydev)
+{
+	mutex_lock(&phydev->lock);
+
+	if (phydev->state != PHY_READY && phydev->state != PHY_HALTED) {
+		WARN(1, "called from state %s\n",
+		     phy_state_to_str(phydev->state));
+		goto out;
+	}
+
+	if (phydev->sfp_bus)
+		sfp_upstream_start(phydev->sfp_bus);
+
+	/* if phy was suspended, bring the physical link up again */
+	__phy_resume(phydev);
+
+	phydev->state = PHY_UP;
+
+	phy_start_machine(phydev);
+out:
+	mutex_unlock(&phydev->lock);
+}
+EXPORT_SYMBOL(phy_start);
+
 /**
  * phy_mac_interrupt - MAC says the link has changed
  * @phydev: phy_device struct with changed link
-- 
2.30.2


--f4j4EWQpC9fDDtdz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0007-net-phy-split-locked-and-unlocked-section-of-phy_sta.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Bcc: linux@mail.armlinux.org.uk
Subject: [PATCH net-next 7/8] net: phy: split locked and unlocked section of
 phy_state_machine()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

Split out the locked and unlocked sections of phy_state_machine() into
two separate functions which can be called inside the phydev lock and
outside the phydev lock as appropriate.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 68 ++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 508a5434684a..b63d9f9320d7 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1353,33 +1353,27 @@ void phy_free_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_free_interrupt);
 
-/**
- * phy_state_machine - Handle the state machine
- * @work: work_struct that describes the work to be done
- */
-void phy_state_machine(struct work_struct *work)
+enum phy_state_work {
+	PHY_STATE_WORK_NONE,
+	PHY_STATE_WORK_ANEG,
+	PHY_STATE_WORK_SUSPEND,
+};
+
+static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
 {
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct phy_device *phydev =
-			container_of(dwork, struct phy_device, state_queue);
+	enum phy_state_work state_work = PHY_STATE_WORK_NONE;
 	struct net_device *dev = phydev->attached_dev;
-	bool needs_aneg = false, do_suspend = false;
-	enum phy_state old_state;
+	enum phy_state old_state = phydev->state;
 	const void *func = NULL;
 	bool finished = false;
 	int err = 0;
 
-	mutex_lock(&phydev->lock);
-
-	old_state = phydev->state;
-
 	switch (phydev->state) {
 	case PHY_DOWN:
 	case PHY_READY:
 		break;
 	case PHY_UP:
-		needs_aneg = true;
-
+		state_work = PHY_STATE_WORK_ANEG;
 		break;
 	case PHY_NOLINK:
 	case PHY_RUNNING:
@@ -1391,7 +1385,7 @@ void phy_state_machine(struct work_struct *work)
 		if (err) {
 			phy_abort_cable_test(phydev);
 			netif_testing_off(dev);
-			needs_aneg = true;
+			state_work = PHY_STATE_WORK_ANEG;
 			phydev->state = PHY_UP;
 			break;
 		}
@@ -1399,7 +1393,7 @@ void phy_state_machine(struct work_struct *work)
 		if (finished) {
 			ethnl_cable_test_finished(phydev);
 			netif_testing_off(dev);
-			needs_aneg = true;
+			state_work = PHY_STATE_WORK_ANEG;
 			phydev->state = PHY_UP;
 		}
 		break;
@@ -1409,19 +1403,17 @@ void phy_state_machine(struct work_struct *work)
 			phydev->link = 0;
 			phy_link_down(phydev);
 		}
-		do_suspend = true;
+		state_work = PHY_STATE_WORK_SUSPEND;
 		break;
 	}
 
-	if (needs_aneg) {
+	if (state_work == PHY_STATE_WORK_ANEG) {
 		err = _phy_start_aneg(phydev);
 		func = &_phy_start_aneg;
 	}
 
-	if (err == -ENODEV) {
-		mutex_unlock(&phydev->lock);
-		return;
-	}
+	if (err == -ENODEV)
+		return state_work;
 
 	if (err < 0)
 		phy_error_precise(phydev, func, err);
@@ -1438,12 +1430,36 @@ void phy_state_machine(struct work_struct *work)
 	 */
 	if (phy_polling_mode(phydev) && phy_is_started(phydev))
 		phy_queue_state_machine(phydev, PHY_STATE_TIME);
-	mutex_unlock(&phydev->lock);
 
-	if (do_suspend)
+	return state_work;
+}
+
+/* unlocked part of the PHY state machine */
+static void _phy_state_machine_post_work(struct phy_device *phydev,
+					 enum phy_state_work state_work)
+{
+	if (state_work == PHY_STATE_WORK_SUSPEND)
 		phy_suspend(phydev);
 }
 
+/**
+ * phy_state_machine - Handle the state machine
+ * @work: work_struct that describes the work to be done
+ */
+void phy_state_machine(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct phy_device *phydev =
+			container_of(dwork, struct phy_device, state_queue);
+	enum phy_state_work state_work;
+
+	mutex_lock(&phydev->lock);
+	state_work = _phy_state_machine(phydev);
+	mutex_unlock(&phydev->lock);
+
+	_phy_state_machine_post_work(phydev, state_work);
+}
+
 /**
  * phy_stop - Bring down the PHY link, and stop checking the status
  * @phydev: target phy_device struct
-- 
2.30.2


--f4j4EWQpC9fDDtdz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0008-net-phy-convert-phy_stop-to-use-split-state-machine.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Bcc: linux@mail.armlinux.org.uk
Subject: [PATCH net-next 8/8] net: phy: convert phy_stop() to use split state
 machine
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

Convert phy_stop() to use the new locked-section and unlocked-section
parts of the PHY state machine.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index b63d9f9320d7..5a5156f9788b 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1467,6 +1467,7 @@ void phy_state_machine(struct work_struct *work)
 void phy_stop(struct phy_device *phydev)
 {
 	struct net_device *dev = phydev->attached_dev;
+	enum phy_state_work state_work;
 	enum phy_state old_state;
 
 	if (!phy_is_started(phydev) && phydev->state != PHY_DOWN &&
@@ -1490,9 +1491,10 @@ void phy_stop(struct phy_device *phydev)
 	phydev->state = PHY_HALTED;
 	phy_process_state_change(phydev, old_state);
 
+	state_work = _phy_state_machine(phydev);
 	mutex_unlock(&phydev->lock);
 
-	phy_state_machine(&phydev->state_queue.work);
+	_phy_state_machine_post_work(phydev, state_work);
 	phy_stop_machine(phydev);
 
 	/* Cannot call flush_scheduled_work() here as desired because
-- 
2.30.2


--f4j4EWQpC9fDDtdz--

