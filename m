Return-Path: <netdev+bounces-263256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB8FMOb3pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:01:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2C51F1F28
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03DEA31A900A
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A762B47DD65;
	Tue,  3 Mar 2026 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U2drvnmL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U2drvnmL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0A47CC8A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549618; cv=none; b=F8truNxmlrDP934PupGk93nZAPXGkAqnMHiKl81Q/CVvfyuctWl1rzk4RjcgZp+yMAlfqMU3jze9xFV1PgRQkYBdgFfDcbsCUdlOPumoQrg18j6eDyQX1ZIepdm6JAwywGVlllqXVp5u6LmLZ7SJ4a6z3w7Vys064jTOWI9nuH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549618; c=relaxed/simple;
	bh=Qk0wqQ25gzMOj0PsbOdB7eKxBIVmw+5oVZuPEg8P4ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGHuDsEIPDytJ1iFpxmIl01inIeuj/zS9EMyWL9QRqmC4ud2T3nxMr86fEm9b8hmzgbs6REr4I9F+0lSX78ucZXiurFhtMA9dvOgbzP+6ZCwFsVfa1nzTcgMlweFBm5JLvRm4UesXAE+gN3j4q54zge1VCdwjxhfhX0HhgKjkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U2drvnmL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U2drvnmL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 983195BE1C;
	Tue,  3 Mar 2026 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRPjYXz0Q7h/sXX3IBje00pdLmd5LIVSd8zrGG4A7qs=;
	b=U2drvnmLMSk3hPfPaA8mJPLcKDfNHKjPSkg4qAhMmvJqI4guDycQR7UTtr+6owC00H+nZk
	t4C4I1O8TX+AJVg+ynu1jRplQBJ1t3RyeedDhNke6M8GKP8+xiA+DbTpjeSbNAcc1JQY8j
	9Ar7XyKjtxx1lIbhqMSxIW1X74mcVMI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRPjYXz0Q7h/sXX3IBje00pdLmd5LIVSd8zrGG4A7qs=;
	b=U2drvnmLMSk3hPfPaA8mJPLcKDfNHKjPSkg4qAhMmvJqI4guDycQR7UTtr+6owC00H+nZk
	t4C4I1O8TX+AJVg+ynu1jRplQBJ1t3RyeedDhNke6M8GKP8+xiA+DbTpjeSbNAcc1JQY8j
	9Ar7XyKjtxx1lIbhqMSxIW1X74mcVMI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74AA33EA69;
	Tue,  3 Mar 2026 14:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8JV3G8T1pmmPKQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 14:52:52 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv2 12/13] net: usb: smsc95xx: use dynamic private allocation
Date: Tue,  3 Mar 2026 15:50:32 +0100
Message-ID: <20260303145242.1377514-12-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303145242.1377514-1-oneukum@suse.com>
References: <20260303145242.1377514-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 4F2C51F1F28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263256-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The old style private room was too small for smsc95xx
With dynamic allocation that factor is gone.
Remove handling private allocations in the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/smsc95xx.c | 65 ++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 42e4048b574b..447c0c6bbd11 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -84,7 +84,7 @@ MODULE_PARM_DESC(turbo_mode, "Enable multiple frames per Rx transaction");
 static int __must_check smsc95xx_read_reg(struct usbnet *dev, u32 index,
 					  u32 *data)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 buf;
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, void *, u16);
@@ -115,7 +115,7 @@ static int __must_check smsc95xx_read_reg(struct usbnet *dev, u32 index,
 static int __must_check smsc95xx_write_reg(struct usbnet *dev, u32 index,
 					   u32 data)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 buf;
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, const void *, u16);
@@ -265,7 +265,7 @@ static int smsc95xx_mdiobus_reset(struct mii_bus *bus)
 	int ret;
 
 	dev = bus->priv;
-	pdata = dev->driver_priv;
+	pdata = usbnet_priv(dev);
 
 	if (pdata->is_internal_phy)
 		return 0;
@@ -481,7 +481,7 @@ static unsigned int smsc95xx_hash(char addr[ETH_ALEN])
 static void smsc95xx_set_multicast(struct net_device *netdev)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	unsigned long flags;
 	int ret;
 
@@ -539,7 +539,7 @@ static void smsc95xx_set_multicast(struct net_device *netdev)
 
 static int smsc95xx_phy_update_flowcontrol(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 flow = 0, afc_cfg;
 
 	int ret = smsc95xx_read_reg(dev, AFC_CFG, &afc_cfg);
@@ -584,7 +584,7 @@ static int smsc95xx_phy_update_flowcontrol(struct usbnet *dev)
 
 static void smsc95xx_mac_update_fullduplex(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	unsigned long flags;
 	int ret;
 
@@ -613,7 +613,7 @@ static void smsc95xx_mac_update_fullduplex(struct usbnet *dev)
 
 static void smsc95xx_status(struct usbnet *dev, struct urb *urb)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	unsigned long flags;
 	u32 intdata;
 
@@ -730,7 +730,7 @@ static void smsc95xx_ethtool_get_wol(struct net_device *net,
 				     struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 
 	wolinfo->supported = SUPPORTED_WAKE;
 	wolinfo->wolopts = pdata->wolopts;
@@ -740,7 +740,7 @@ static int smsc95xx_ethtool_set_wol(struct net_device *net,
 				    struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	int ret;
 
 	if (wolinfo->wolopts & ~SUPPORTED_WAKE)
@@ -788,7 +788,7 @@ static void smsc95xx_get_pauseparam(struct net_device *ndev,
 	struct usbnet *dev;
 
 	dev = netdev_priv(ndev);
-	pdata = dev->driver_priv;
+	pdata = usbnet_priv(dev);
 
 	pause->autoneg = pdata->pause_autoneg;
 	pause->rx_pause = pdata->pause_rx;
@@ -804,7 +804,7 @@ static int smsc95xx_set_pauseparam(struct net_device *ndev,
 	struct usbnet *dev;
 
 	dev = netdev_priv(ndev);
-	pdata = dev->driver_priv;
+	pdata = usbnet_priv(dev);
 	phydev = ndev->phydev;
 
 	if (!phydev)
@@ -898,7 +898,7 @@ static int smsc95xx_set_mac_address(struct usbnet *dev)
 /* starts the TX path */
 static int smsc95xx_start_tx_path(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	unsigned long flags;
 	int ret;
 
@@ -918,7 +918,7 @@ static int smsc95xx_start_tx_path(struct usbnet *dev)
 /* Starts the Receive path */
 static int smsc95xx_start_rx_path(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&pdata->mac_cr_lock, flags);
@@ -930,7 +930,7 @@ static int smsc95xx_start_rx_path(struct usbnet *dev)
 
 static int smsc95xx_reset(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 read_buf, burst_cap;
 	int ret = 0, timeout;
 
@@ -1157,12 +1157,6 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 		return ret;
 	}
 
-	pdata = kzalloc_obj(*pdata);
-	if (!pdata)
-		return -ENOMEM;
-
-	dev->driver_priv = pdata;
-
 	spin_lock_init(&pdata->mac_cr_lock);
 
 	/* LAN95xx devices do not alter the computed checksum of 0 to 0xffff.
@@ -1185,14 +1179,14 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	/* Init all registers */
 	ret = smsc95xx_reset(dev);
 	if (ret)
-		goto free_pdata;
+		goto bail_out;
 
 	/* create irq domain for use by PHY driver and GPIO consumers */
 	usb_make_path(dev->udev, usb_path, sizeof(usb_path));
 	pdata->irqfwnode = irq_domain_alloc_named_fwnode(usb_path);
 	if (!pdata->irqfwnode) {
 		ret = -ENOMEM;
-		goto free_pdata;
+		goto bail_out;
 	}
 
 	pdata->irqdomain = irq_domain_create_linear(pdata->irqfwnode,
@@ -1309,14 +1303,13 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 free_irqfwnode:
 	irq_domain_free_fwnode(pdata->irqfwnode);
 
-free_pdata:
-	kfree(pdata);
+bail_out:
 	return ret;
 }
 
 static void smsc95xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 
 	phy_disconnect(dev->net->phydev);
 	mdiobus_unregister(pdata->mdiobus);
@@ -1324,8 +1317,6 @@ static void smsc95xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 	irq_dispose_mapping(irq_find_mapping(pdata->irqdomain, PHY_HWIRQ));
 	irq_domain_remove(pdata->irqdomain);
 	irq_domain_free_fwnode(pdata->irqfwnode);
-	netif_dbg(dev, ifdown, dev->net, "free pdata\n");
-	kfree(pdata);
 }
 
 static int smsc95xx_start_phy(struct usbnet *dev)
@@ -1350,7 +1341,7 @@ static u32 smsc_crc(const u8 *buffer, size_t len, int filter)
 
 static int smsc95xx_link_ok(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	int ret;
 
 	/* first, a dummy read, needed to latch some MII phys */
@@ -1367,7 +1358,7 @@ static int smsc95xx_link_ok(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend0(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 val;
 	int ret;
 
@@ -1406,7 +1397,7 @@ static int smsc95xx_enter_suspend0(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend1(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	int ret, phy_id = pdata->phydev->mdio.addr;
 	u32 val;
 
@@ -1453,7 +1444,7 @@ static int smsc95xx_enter_suspend1(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend2(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 val;
 	int ret;
 
@@ -1475,7 +1466,7 @@ static int smsc95xx_enter_suspend2(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend3(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 val;
 	int ret;
 
@@ -1514,7 +1505,7 @@ static int smsc95xx_enter_suspend3(struct usbnet *dev)
 
 static int smsc95xx_autosuspend(struct usbnet *dev, u32 link_up)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 
 	if (!netif_running(dev->net)) {
 		/* interface is ifconfig down so fully power down hw */
@@ -1544,7 +1535,7 @@ static int smsc95xx_autosuspend(struct usbnet *dev, u32 link_up)
 static int smsc95xx_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 val, link_up;
 	int ret;
 
@@ -1805,7 +1796,7 @@ static int smsc95xx_resume(struct usb_interface *intf)
 	u32 val;
 
 	BUG_ON(!dev);
-	pdata = dev->driver_priv;
+	pdata = usbnet_priv(dev);
 	suspend_flags = pdata->suspend_flags;
 
 	netdev_dbg(dev->net, "resume suspend_flags=0x%02x\n", suspend_flags);
@@ -1854,7 +1845,7 @@ static int smsc95xx_resume(struct usb_interface *intf)
 static int smsc95xx_reset_resume(struct usb_interface *intf)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	int ret;
 
 	pdata->pm_task = current;
@@ -2038,7 +2029,7 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 
 static int smsc95xx_manage_power(struct usbnet *dev, int on)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 
 	dev->intf->needs_remote_wakeup = on;
 
-- 
2.53.0


