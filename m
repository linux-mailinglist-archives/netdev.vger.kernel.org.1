Return-Path: <netdev+bounces-31942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC907919DB
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 16:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662E8280FD9
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59409947A;
	Mon,  4 Sep 2023 14:43:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430CD3D99
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 14:43:06 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7A4CFB
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 07:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=welucMj1JvFpQXIGunXlCzG+IBK4R7CCiFpcLkwZp0o=; b=KATD3L451JtggqjwyNgUqqNNF0
	MDiWwHjP7G7cLyQvGeW0a+/lR2fi5pOZS4kzkstQT+Tna78+iwf3qUtg+KD4txfXJ7ONDZznOsfpW
	45n+rfqdQNX0l0sab912sT8bocm8Xn+ycYGw4BfFW3I83gVJJgKtKC+baaDvbtuiF+Dz4ssGO68TY
	nfyb8bI3KOHucAfkPJlClhBNhJoyRzWwl7QayY/4ZsZU60cEKn6IQResyLqDnehIQKKCan20w4QzN
	mmcyWuddV+iCyBSvRlFSdAVQ054Zh4n4sASw0qjDaZRhrPj9gTobcRS61X/dAM63gICfhFFprHZVA
	tx7AfAKw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38654)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qdAn0-0006vy-0D;
	Mon, 04 Sep 2023 15:42:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qdAmw-0002cs-QZ; Mon, 04 Sep 2023 15:42:50 +0100
Date: Mon, 4 Sep 2023 15:42:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jijie Shao <shaojijie@huawei.com>
Cc: f.fainelli@gmail.com, Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
	edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	"shenjian15@huawei.com" <shenjian15@huawei.com>,
	"liuyonglong@huawei.com" <liuyonglong@huawei.com>,
	wangjie125@huawei.com, chenhao418@huawei.com,
	Hao Lan <lanhao@huawei.com>,
	"wangpeiyang1@huawei.com" <wangpeiyang1@huawei.com>
Subject: Re: [PATCH net-next] net: phy: avoid kernel warning dump when
 stopping an errored PHY
Message-ID: <ZPXs6i2S8GSCpVOV@shell.armlinux.org.uk>
References: <aed0bc3b-2d48-2fd9-9587-5910ad68c180@gmail.com>
 <8e7e02d8-2b2a-8619-e607-fbac50706252@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e7e02d8-2b2a-8619-e607-fbac50706252@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 05:50:32PM +0800, Jijie Shao wrote:
> Hi all,
> We encountered an issue when resetting our netdevice recently, it seems
> related to this patch.
> 
> During our process, we stop phy first and call phy_start() later.
> phy_check_link_status returns error because it read mdio failed. The
> reason why it happened is that the cmdq is unusable when we reset and we
> can't access to mdio.

Are you suggesting that the sequence is:

phy_stop();
reset netdev
phy_start();

?

Is the reason for doing this because you've already detected an issue
with the hardware, and you're trying to recover it - and before you've
called phy_stop() the hardware is already dead?

If that is the case, I'm not really sure what you expect to happen
here. You've identified a race where the state machine is running in
unison with phy_stop(), but in this circumstance it is also possible
that the state machine could complete executing and have called
phy_error_precise() before phy_stop() has even been called. In that
case, you'll still get a warning-splat on the console from
phy_error_precise().

The only difference is that phy_stop() won't warn.

That all said, this is obviously buggy, because phy_stop() has set
the phydev state to PHY_HALTED and the state machine has unexpectedly
changed its state.

I wonder whether we should be tracking the phy_start/stop state
separately, since we've had issues with phy_stop() warning when an
error has occurred (see commit 59088b5a946e).

Maybe something like this (untested)?

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index df54c137c5f5..d57f6de8a562 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -810,7 +810,8 @@ int phy_start_cable_test(struct phy_device *phydev,
 		goto out;
 	}
 
-	if (phydev->state < PHY_UP ||
+	if (phydev->oper_state != PHY_OPER_STARTED ||
+	    phydev->state < PHY_UP ||
 	    phydev->state > PHY_CABLETEST) {
 		NL_SET_ERR_MSG(extack,
 			       "PHY not configured. Try setting interface up");
@@ -881,7 +882,8 @@ int phy_start_cable_test_tdr(struct phy_device *phydev,
 		goto out;
 	}
 
-	if (phydev->state < PHY_UP ||
+	if (phydev->oper_state != PHY_OPER_STARTED ||
+	    phydev->state < PHY_UP ||
 	    phydev->state > PHY_CABLETEST) {
 		NL_SET_ERR_MSG(extack,
 			       "PHY not configured. Try setting interface up");
@@ -1364,10 +1366,8 @@ void phy_stop(struct phy_device *phydev)
 	struct net_device *dev = phydev->attached_dev;
 	enum phy_state old_state;
 
-	if (!phy_is_started(phydev) && phydev->state != PHY_DOWN &&
-	    phydev->state != PHY_ERROR) {
-		WARN(1, "called from state %s\n",
-		     phy_state_to_str(phydev->state));
+	if (phydev->oper_state != PHY_OPER_STARTED) {
+		WARN(1, "called when not started\n");
 		return;
 	}
 
@@ -1382,6 +1382,7 @@ void phy_stop(struct phy_device *phydev)
 	if (phydev->sfp_bus)
 		sfp_upstream_stop(phydev->sfp_bus);
 
+	phydev->oper_state = PHY_OPER_STOPPED;
 	phydev->state = PHY_HALTED;
 	phy_process_state_change(phydev, old_state);
 
@@ -1411,9 +1412,8 @@ void phy_start(struct phy_device *phydev)
 {
 	mutex_lock(&phydev->lock);
 
-	if (phydev->state != PHY_READY && phydev->state != PHY_HALTED) {
-		WARN(1, "called from state %s\n",
-		     phy_state_to_str(phydev->state));
+	if (phydev->oper_state != PHY_OPER_STOPPED) {
+		WARN(1, "called when not stopped\n");
 		goto out;
 	}
 
@@ -1423,6 +1423,7 @@ void phy_start(struct phy_device *phydev)
 	/* if phy was suspended, bring the physical link up again */
 	__phy_resume(phydev);
 
+	phydev->oper_state = PHY_OPER_STARTED;
 	phydev->state = PHY_UP;
 
 	phy_start_machine(phydev);
@@ -1442,14 +1443,18 @@ void phy_state_machine(struct work_struct *work)
 			container_of(dwork, struct phy_device, state_queue);
 	struct net_device *dev = phydev->attached_dev;
 	bool needs_aneg = false, do_suspend = false;
-	enum phy_state old_state;
+	enum phy_state old_state, state;
 	const void *func = NULL;
 	bool finished = false;
 	int err = 0;
 
 	mutex_lock(&phydev->lock);
 
-	old_state = phydev->state;
+	state = old_state = phydev->state;
+
+	/* If the PHY is stopped, then force state to halted. */
+	if (phydev->oper_state == PHY_OPER_STOPPED)
+		state = PHY_HALTED;
 
 	switch (phydev->state) {
 	case PHY_DOWN:
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5dcab361a220..b128d903adb3 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -519,6 +519,11 @@ enum phy_state {
 	PHY_CABLETEST,
 };
 
+enum phy_oper_state {
+	PHY_OPER_STOPPED,
+	PHY_OPER_STARTED,
+};
+
 #define MDIO_MMD_NUM 32
 
 /**
@@ -670,6 +675,7 @@ struct phy_device {
 	int rate_matching;
 
 	enum phy_state state;
+	enum phy_oper_state oper_state;
 
 	u32 dev_flags;
 
@@ -1221,7 +1227,8 @@ int phy_speed_down_core(struct phy_device *phydev);
  */
 static inline bool phy_is_started(struct phy_device *phydev)
 {
-	return phydev->state >= PHY_UP;
+	return phydev->oper_state == PHY_OPER_STARTED &&
+	       phydev->state >= PHY_UP;
 }
 
 void phy_resolve_aneg_pause(struct phy_device *phydev);
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

