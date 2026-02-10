Return-Path: <netdev+bounces-258111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F7yJZVLi2mWTwAAu9opvQ
	(envelope-from <netdev+bounces-258111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:15:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6BF11C622
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB173300D576
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66083815E5;
	Tue, 10 Feb 2026 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fyuCSM0N";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H4sUSQRV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCDB3806C9
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736480; cv=none; b=qs3oImepTRi6GFEn2BS1+1RuSfhfH5HObs+QgDFs6LRdZkFUv5cCRR+fpZqkuTxz+CfJAxu8wfnMJuCIsiW7+KZVu56TsuWEltO4pQ3kXGvpJZKZh8710m7Rdh8EmLAdPho9qm8Gacbgss6kvsafEiTdtFTW/B4srER2yIE3YNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736480; c=relaxed/simple;
	bh=JGEi3Xd4aBzP/A2oI0zlfKoTGrhTQmRD7csDsgPdU8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZ6qwvIOJqL+TcGptFcj2moSawpyhm04DkphA+Rm7RnWVNcwsVXdz7F6vJIFuYDsM6n9lfDYpeU2UbZmtOnpWQjJdIyE0TciHtQlIPH0q+Vkik+4gcg1BUuCJmB1zQXzfyVUXj0A7K0GY9Prr0TFsWBrGXUQbk+Q1POGSrZHLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fyuCSM0N; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H4sUSQRV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D394B3E716;
	Tue, 10 Feb 2026 15:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770736466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/y6ktXAkd0ketftyLK+b8UQyajWxYJ++UECEWbY9jJc=;
	b=fyuCSM0NH9onyhlrDmHfpeXnI4g/co1rz/FphHixnU+O+URDA55XHWp2wX8z7SYg+5UfeT
	G2JEjUrlkQLKkc9Yhgq0JL+aC7MKlDmaH9P19G4vqc30+V5kchJVq7CjLCnzkLO28V6wGU
	Ec7d5G9nXn2BTkIQcumpXhWotO8zVH8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770736461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/y6ktXAkd0ketftyLK+b8UQyajWxYJ++UECEWbY9jJc=;
	b=H4sUSQRVaCYZS5EJOV9gwLPgw+rB9NaT4v+NNLKi46vxkI8BghSVYGqCMNr3qYOnb7wQag
	qyzUalmfUGKGaiPT2mHV2KEjAsvtqsSpe8Pby5rFqGCmaG4yOcLB9GGkrEc6z4kHJ782T+
	xhVlzll5+Ynnh4j9cv78mIxdfTv+IbQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D96D3EA64;
	Tue, 10 Feb 2026 15:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GJhKGU1Li2lmVgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 10 Feb 2026 15:14:21 +0000
From: Oliver Neukum <oneukum@suse.com>
To: netdev@vger.kernel.org,
	hayeswang@realtek.com,
	bjorn@mork.no,
	o.rempel@pengutronix.de
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFC net-next 1/3] net: usb: divorce private data and cdc state in usbnet
Date: Tue, 10 Feb 2026 16:11:12 +0100
Message-ID: <20260210151416.42254-2-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210151416.42254-1-oneukum@suse.com>
References: <20260210151416.42254-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258111-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C6BF11C622
X-Rspamd-Action: no action

This allows use of cdc helpers together with private dara.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/asix_common.c    |  4 +--
 drivers/net/usb/asix_devices.c   | 18 +++++-----
 drivers/net/usb/ax88172a.c       |  2 +-
 drivers/net/usb/ax88179_178a.c   |  2 +-
 drivers/net/usb/cdc_ether.c      | 12 ++-----
 drivers/net/usb/cdc_mbim.c       | 18 +++++-----
 drivers/net/usb/cdc_ncm.c        | 58 ++++++++++++++++----------------
 drivers/net/usb/cx82310_eth.c    |  6 ++--
 drivers/net/usb/dm9601.c         |  2 +-
 drivers/net/usb/huawei_cdc_ncm.c | 10 +++---
 drivers/net/usb/mcs7830.c        |  2 +-
 drivers/net/usb/net1080.c        |  2 +-
 drivers/net/usb/qmi_wwan.c       | 33 +++++++++---------
 drivers/net/usb/rndis_host.c     |  6 ++--
 drivers/net/usb/sierra_net.c     |  7 ++--
 drivers/net/usb/smsc75xx.c       | 40 +++++++++++-----------
 drivers/net/usb/sr9700.c         |  1 +
 drivers/net/usb/sr9800.c         | 10 +++---
 include/linux/usb/usbnet.h       | 27 ++++++++-------
 19 files changed, 125 insertions(+), 135 deletions(-)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 4f03f4e57655..d97a1920cb6e 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -441,7 +441,7 @@ int asix_write_gpio(struct usbnet *dev, u16 value, int sleep, int in_pm)
 void asix_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = (struct asix_data *)&dev->private;
 	u16 rx_ctl = AX_DEFAULT_RX_CTL;
 
 	if (net->flags & IFF_PROMISC) {
@@ -734,7 +734,7 @@ int asix_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
 int asix_set_mac_address(struct net_device *net, void *p)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = (struct asix_data *)&dev->private;
 	struct sockaddr *addr = p;
 
 	if (netif_running(net))
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 7eb6e86adb16..5100e0b31f1f 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -118,7 +118,7 @@ static const struct ethtool_ops ax88172_ethtool_ops = {
 static void ax88172_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = (struct asix_data *)&dev->private;
 	u8 rx_ctl = 0x8c;
 
 	if (net->flags & IFF_PROMISC) {
@@ -129,7 +129,7 @@ static void ax88172_set_multicast(struct net_device *net)
 	} else if (netdev_mc_empty(net)) {
 		/* just broadcast and directed */
 	} else {
-		/* We use the 20 byte dev->data
+		/* We use the 20 byte dev->private
 		 * for our 8 byte filter buffer
 		 * to avoid allocating memory that
 		 * is tricky to free later */
@@ -331,7 +331,7 @@ static const struct ethtool_ops ax88772_ethtool_ops = {
 
 static int ax88772_reset(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = (struct asix_data *)&dev->private;
 	struct asix_common_private *priv = dev->driver_priv;
 	int ret;
 
@@ -361,7 +361,7 @@ static int ax88772_reset(struct usbnet *dev)
 
 static int ax88772_hw_reset(struct usbnet *dev, int in_pm)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = (struct asix_data *)&dev->private;
 	struct asix_common_private *priv = dev->driver_priv;
 	u16 rx_ctl;
 	int ret;
@@ -455,7 +455,7 @@ static int ax88772_hw_reset(struct usbnet *dev, int in_pm)
 
 static int ax88772a_hw_reset(struct usbnet *dev, int in_pm)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = (struct asix_data *)&dev->private;
 	struct asix_common_private *priv = dev->driver_priv;
 	u16 rx_ctl, phy14h, phy15h, phy16h;
 	int ret;
@@ -987,7 +987,7 @@ static const struct ethtool_ops ax88178_ethtool_ops = {
 
 static int marvell_phy_init(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = (struct asix_data *)&dev->private;
 	u16 reg;
 
 	netdev_dbg(dev->net, "marvell_phy_init()\n");
@@ -1018,7 +1018,7 @@ static int marvell_phy_init(struct usbnet *dev)
 
 static int rtl8211cl_phy_init(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = (struct asix_data *)&dev->private;
 
 	netdev_dbg(dev->net, "rtl8211cl_phy_init()\n");
 
@@ -1065,7 +1065,7 @@ static int marvell_led_status(struct usbnet *dev, u16 speed)
 
 static int ax88178_reset(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = (struct asix_data *)&dev->private;
 	int ret;
 	__le16 eeprom;
 	u8 status;
@@ -1163,7 +1163,7 @@ static int ax88178_link_reset(struct usbnet *dev)
 {
 	u16 mode;
 	struct ethtool_cmd ecmd = { .cmd = ETHTOOL_GSET };
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = (struct asix_data *)&dev->private;
 	u32 speed;
 
 	netdev_dbg(dev->net, "ax88178_link_reset()\n");
diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index 3100fbe153c0..1694d6ca2b7b 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -260,7 +260,7 @@ static void ax88172a_unbind(struct usbnet *dev, struct usb_interface *intf)
 
 static int ax88172a_reset(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = (struct asix_data *)&dev->private;
 	struct ax88172a_private *priv = dev->driver_priv;
 	int ret;
 	u16 rx_ctl;
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 0e9ae89b840e..df7e3f1c3672 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -868,7 +868,7 @@ static void ax88179_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
 	struct ax88179_data *data = dev->driver_priv;
-	u8 *m_filter = ((u8 *)dev->data);
+	u8 *m_filter = ((u8 *)dev->private);
 
 	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
 
diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 505a653d9482..dafc2462be98 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -85,16 +85,13 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8				*buf = intf->cur_altsetting->extra;
 	int				len = intf->cur_altsetting->extralen;
 	struct usb_interface_descriptor	*d;
-	struct cdc_state		*info = (void *) &dev->data;
+	struct cdc_state		*info = &dev->cdc;
 	int				status;
 	int				rndis;
 	bool				android_rndis_quirk = false;
 	struct usb_driver		*driver = driver_of(intf);
 	struct usb_cdc_parsed_header header;
 
-	if (sizeof(dev->data) < sizeof(*info))
-		return -EDOM;
-
 	/* expect strict spec conformance for the descriptors, but
 	 * cope with firmware which stores them in the wrong place
 	 */
@@ -330,7 +327,7 @@ EXPORT_SYMBOL_GPL(usbnet_ether_cdc_bind);
 
 void usbnet_cdc_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_state		*info = (void *) &dev->data;
+	struct cdc_state		*info = &dev->cdc;
 	struct usb_driver		*driver = driver_of(intf);
 
 	/* combined interface - nothing  to do */
@@ -368,10 +365,7 @@ EXPORT_SYMBOL_GPL(usbnet_cdc_unbind);
 int usbnet_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int				status;
-	struct cdc_state		*info = (void *) &dev->data;
-
-	BUILD_BUG_ON((sizeof(((struct usbnet *)0)->data)
-			< sizeof(struct cdc_state)));
+	struct cdc_state		*info = &dev->cdc;
 
 	status = usbnet_ether_cdc_bind(dev, intf);
 	if (status < 0)
diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index dbf01210b0e7..f08f0fc3a8c1 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -43,7 +43,7 @@ enum cdc_mbim_flags {
 /* using a counter to merge subdriver requests with our own into a combined state */
 static int cdc_mbim_manage_power(struct usbnet *dev, int on)
 {
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = (void *)&dev->private;
 	int rv = 0;
 
 	dev_dbg(&dev->intf->dev, "%s() pmcount=%d, on=%d\n", __func__, atomic_read(&info->pmcount), on);
@@ -72,7 +72,7 @@ static int cdc_mbim_wdm_manage_power(struct usb_interface *intf, int status)
 static int cdc_mbim_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = (void *)&dev->private;
 
 	/* creation of this VLAN is a request to tag IP session 0 */
 	if (vid == MBIM_IPS0_VID)
@@ -86,7 +86,7 @@ static int cdc_mbim_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 static int cdc_mbim_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = (void *)&dev->private;
 
 	/* this is a request for an untagged IP session 0 */
 	if (vid == MBIM_IPS0_VID)
@@ -143,7 +143,7 @@ static int cdc_mbim_bind(struct usbnet *dev, struct usb_interface *intf)
 	struct usb_driver *subdriver = ERR_PTR(-ENODEV);
 	int ret = -ENODEV;
 	u8 data_altsetting = 1;
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = (void *)&dev->private;
 
 	/* should we change control altsetting on a NCM/MBIM function? */
 	if (cdc_ncm_select_altsetting(intf) == CDC_NCM_COMM_ALTSETTING_MBIM) {
@@ -195,7 +195,7 @@ static int cdc_mbim_bind(struct usbnet *dev, struct usb_interface *intf)
 
 static void cdc_mbim_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = (void *)&dev->private;
 	struct cdc_ncm_ctx *ctx = info->ctx;
 
 	/* disconnect subdriver from control interface */
@@ -221,7 +221,7 @@ static bool is_ip_proto(__be16 proto)
 static struct sk_buff *cdc_mbim_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 {
 	struct sk_buff *skb_out;
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = (void *)&dev->private;
 	struct cdc_ncm_ctx *ctx = info->ctx;
 	__le32 sign = cpu_to_le32(USB_CDC_MBIM_NDP16_IPS_SIGN);
 	u16 tci = 0;
@@ -411,7 +411,7 @@ static struct sk_buff *cdc_mbim_process_dgram(struct usbnet *dev, u8 *buf, size_
 static int cdc_mbim_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 {
 	struct sk_buff *skb;
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = (void *)&dev->private;
 	struct cdc_ncm_ctx *ctx = info->ctx;
 	int len;
 	int nframes;
@@ -506,7 +506,7 @@ static int cdc_mbim_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	int ret = -ENODEV;
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = (void *)&dev->private;
 	struct cdc_ncm_ctx *ctx = info->ctx;
 
 	if (!ctx)
@@ -534,7 +534,7 @@ static int cdc_mbim_resume(struct usb_interface *intf)
 {
 	int  ret = 0;
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = (void *)&dev->private;
 	struct cdc_ncm_ctx *ctx = info->ctx;
 	bool callsub = (intf == ctx->control && info->subdriver && info->subdriver->resume);
 
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5d123df0a866..d0d13b2d52e6 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -107,7 +107,7 @@ static void cdc_ncm_get_ethtool_stats(struct net_device *netdev,
 				    u64 *data)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	int i;
 	char *p = NULL;
 
@@ -149,7 +149,7 @@ static const struct ethtool_ops cdc_ncm_ethtool_ops = {
 
 static u32 cdc_ncm_check_rx_max(struct usbnet *dev, u32 new_rx)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	u32 val, max, min;
 
 	/* clamp new_rx to sane values */
@@ -172,7 +172,7 @@ static u32 cdc_ncm_check_rx_max(struct usbnet *dev, u32 new_rx)
 
 static u32 cdc_ncm_check_tx_max(struct usbnet *dev, u32 new_tx)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	u32 val, max, min;
 
 	/* clamp new_tx to sane values */
@@ -202,7 +202,7 @@ static ssize_t min_tx_pkt_show(struct device *d,
 			       struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 
 	return sprintf(buf, "%u\n", ctx->min_tx_pkt);
 }
@@ -211,7 +211,7 @@ static ssize_t rx_max_show(struct device *d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 
 	return sprintf(buf, "%u\n", ctx->rx_max);
 }
@@ -220,7 +220,7 @@ static ssize_t tx_max_show(struct device *d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 
 	return sprintf(buf, "%u\n", ctx->tx_max);
 }
@@ -229,7 +229,7 @@ static ssize_t tx_timer_usecs_show(struct device *d,
 				   struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 
 	return sprintf(buf, "%u\n", ctx->timer_interval / (u32)NSEC_PER_USEC);
 }
@@ -239,7 +239,7 @@ static ssize_t min_tx_pkt_store(struct device *d,
 				const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	unsigned long val;
 
 	/* no need to restrict values - anything from 0 to infinity is OK */
@@ -255,7 +255,7 @@ static ssize_t rx_max_store(struct device *d,
 			    const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	unsigned long val;
 
 	if (kstrtoul(buf, 0, &val) || cdc_ncm_check_rx_max(dev, val) != val)
@@ -270,7 +270,7 @@ static ssize_t tx_max_store(struct device *d,
 			    const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	unsigned long val;
 
 	if (kstrtoul(buf, 0, &val) || cdc_ncm_check_tx_max(dev, val) != val)
@@ -285,7 +285,7 @@ static ssize_t tx_timer_usecs_store(struct device *d,
 				    const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	ssize_t ret;
 	unsigned long val;
 
@@ -311,7 +311,7 @@ static DEVICE_ATTR_RW(tx_timer_usecs);
 static ssize_t ndp_to_end_show(struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 
 	return sprintf(buf, "%c\n", ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END ? 'Y' : 'N');
 }
@@ -319,7 +319,7 @@ static ssize_t ndp_to_end_show(struct device *d, struct device_attribute *attr,
 static ssize_t ndp_to_end_store(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	bool enable;
 
 	if (kstrtobool(buf, &enable))
@@ -361,7 +361,7 @@ static DEVICE_ATTR_RW(ndp_to_end);
 static ssize_t cdc_ncm_show_##name(struct device *d, struct device_attribute *attr, char *buf) \
 { \
 	struct usbnet *dev = netdev_priv(to_net_dev(d)); \
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0]; \
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0]; \
 	return sprintf(buf, format "\n", tocpu(ctx->ncm_parm.name));	\
 } \
 static DEVICE_ATTR(name, 0444, cdc_ncm_show_##name, NULL)
@@ -404,7 +404,7 @@ static const struct attribute_group cdc_ncm_sysfs_attr_group = {
 /* handle rx_max and tx_max changes */
 static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	u32 val;
 
@@ -476,7 +476,7 @@ static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
 /* helpers for NCM and MBIM differences */
 static u8 cdc_ncm_flags(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 
 	if (cdc_ncm_comm_intf_is_mbim(dev->intf->cur_altsetting) && ctx->mbim_desc)
 		return ctx->mbim_desc->bmNetworkCapabilities;
@@ -501,7 +501,7 @@ static u32 cdc_ncm_min_dgram_size(struct usbnet *dev)
 
 static u32 cdc_ncm_max_dgram_size(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 
 	if (cdc_ncm_comm_intf_is_mbim(dev->intf->cur_altsetting) && ctx->mbim_desc)
 		return le16_to_cpu(ctx->mbim_desc->wMaxSegmentSize);
@@ -515,7 +515,7 @@ static u32 cdc_ncm_max_dgram_size(struct usbnet *dev)
  */
 static int cdc_ncm_init(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	int err;
 
@@ -608,7 +608,7 @@ static int cdc_ncm_init(struct usbnet *dev)
 /* set a new max datagram size */
 static void cdc_ncm_set_dgram_size(struct usbnet *dev, int new_size)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	__le16 max_datagram_size;
 	u16 mbim_mtu;
@@ -656,7 +656,7 @@ static void cdc_ncm_set_dgram_size(struct usbnet *dev, int new_size)
 
 static void cdc_ncm_fix_modulus(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	u32 val;
 
 	/*
@@ -700,7 +700,7 @@ static void cdc_ncm_fix_modulus(struct usbnet *dev)
 
 static int cdc_ncm_setup(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	u32 def_rx, def_tx;
 
 	/* be conservative when selecting initial buffer size to
@@ -839,7 +839,7 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	spin_lock_init(&ctx->mtx);
 
 	/* store ctx pointer in device data field */
-	dev->data[0] = (unsigned long)ctx;
+	dev->private[0] = (unsigned long)ctx;
 
 	/* only the control interface can be successfully probed */
 	ctx->control = intf;
@@ -988,8 +988,8 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	if (ctx->data != ctx->control)
 		usb_driver_release_interface(driver, ctx->data);
 error:
-	cdc_ncm_free((struct cdc_ncm_ctx *)dev->data[0]);
-	dev->data[0] = 0;
+	cdc_ncm_free((struct cdc_ncm_ctx *)dev->private[0]);
+	dev->private[0] = 0;
 	dev_info(&intf->dev, "bind() failure\n");
 	return -ENODEV;
 }
@@ -997,7 +997,7 @@ EXPORT_SYMBOL_GPL(cdc_ncm_bind_common);
 
 void cdc_ncm_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	struct usb_driver *driver = driver_of(intf);
 
 	if (ctx == NULL)
@@ -1203,7 +1203,7 @@ static struct usb_cdc_ncm_ndp32 *cdc_ncm_ndp32(struct cdc_ncm_ctx *ctx, struct s
 struct sk_buff *
 cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	union {
 		struct usb_cdc_ncm_nth16 *nth16;
 		struct usb_cdc_ncm_nth32 *nth32;
@@ -1523,7 +1523,7 @@ struct sk_buff *
 cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 {
 	struct sk_buff *skb_out;
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 
 	/*
 	 * The Ethernet API we are using does not support transmitting
@@ -1725,7 +1725,7 @@ EXPORT_SYMBOL_GPL(cdc_ncm_rx_verify_ndp32);
 int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 {
 	struct sk_buff *skb;
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 	unsigned int len;
 	int nframes;
 	int x;
@@ -1904,7 +1904,7 @@ static void cdc_ncm_status(struct usbnet *dev, struct urb *urb)
 
 static void cdc_ncm_update_filter(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
 
 	if (ctx->filtering_supported)
 		usbnet_cdc_update_filter(dev);
diff --git a/drivers/net/usb/cx82310_eth.c b/drivers/net/usb/cx82310_eth.c
index 79a47e2fd437..ebbaee0575a8 100644
--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -134,9 +134,9 @@ static void cx82310_reenable_work(struct work_struct *work)
 	cx82310_enable_ethernet(priv->dev);
 }
 
-#define partial_len	data[0]		/* length of partial packet data */
-#define partial_rem	data[1]		/* remaining (missing) data length */
-#define partial_data	data[2]		/* partial packet data */
+#define partial_len	private[0]		/* length of partial packet data */
+#define partial_rem	private[1]		/* remaining (missing) data length */
+#define partial_data	private[2]		/* partial packet data */
 
 static int cx82310_bind(struct usbnet *dev, struct usb_interface *intf)
 {
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index c8e0f8868210..ad2b21ac2326 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -276,7 +276,7 @@ static void dm9601_set_multicast(struct net_device *net)
 	struct usbnet *dev = netdev_priv(net);
 	/* We use the 20 byte dev->data for our 8 byte filter buffer
 	 * to avoid allocating memory that is tricky to free later */
-	u8 *hashes = (u8 *) & dev->data;
+	u8 *hashes = (u8 *) & dev->private;
 	u8 rx_ctl = 0x31;
 
 	memset(hashes, 0x00, DM_MCAST_SIZE);
diff --git a/drivers/net/usb/huawei_cdc_ncm.c b/drivers/net/usb/huawei_cdc_ncm.c
index 849b77330bf2..a10066ab13ad 100644
--- a/drivers/net/usb/huawei_cdc_ncm.c
+++ b/drivers/net/usb/huawei_cdc_ncm.c
@@ -36,7 +36,7 @@ struct huawei_cdc_ncm_state {
 
 static int huawei_cdc_ncm_manage_power(struct usbnet *usbnet_dev, int on)
 {
-	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->data;
+	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->private;
 	int rv;
 
 	if ((on && atomic_add_return(1, &drvstate->pmcount) == 1) ||
@@ -68,7 +68,7 @@ static int huawei_cdc_ncm_bind(struct usbnet *usbnet_dev,
 	struct cdc_ncm_ctx *ctx;
 	struct usb_driver *subdriver = ERR_PTR(-ENODEV);
 	int ret;
-	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->data;
+	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->private;
 	int drvflags = 0;
 
 	/* altsetting should always be 1 for NCM devices - so we hard-coded
@@ -116,7 +116,7 @@ static int huawei_cdc_ncm_bind(struct usbnet *usbnet_dev,
 static void huawei_cdc_ncm_unbind(struct usbnet *usbnet_dev,
 				  struct usb_interface *intf)
 {
-	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->data;
+	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->private;
 	struct cdc_ncm_ctx *ctx = drvstate->ctx;
 
 	if (drvstate->subdriver && drvstate->subdriver->disconnect)
@@ -131,7 +131,7 @@ static int huawei_cdc_ncm_suspend(struct usb_interface *intf,
 {
 	int ret = 0;
 	struct usbnet *usbnet_dev = usb_get_intfdata(intf);
-	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->data;
+	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->private;
 	struct cdc_ncm_ctx *ctx = drvstate->ctx;
 
 	if (ctx == NULL) {
@@ -158,7 +158,7 @@ static int huawei_cdc_ncm_resume(struct usb_interface *intf)
 {
 	int ret = 0;
 	struct usbnet *usbnet_dev = usb_get_intfdata(intf);
-	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->data;
+	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->private;
 	bool callsub;
 	struct cdc_ncm_ctx *ctx = drvstate->ctx;
 
diff --git a/drivers/net/usb/mcs7830.c b/drivers/net/usb/mcs7830.c
index d6698f30218d..b30fa2856f9e 100644
--- a/drivers/net/usb/mcs7830.c
+++ b/drivers/net/usb/mcs7830.c
@@ -327,7 +327,7 @@ static void mcs7830_mdio_write(struct net_device *netdev, int phy_id,
 
 static inline struct mcs7830_data *mcs7830_get_data(struct usbnet *dev)
 {
-	return (struct mcs7830_data *)&dev->data;
+	return (struct mcs7830_data *)&dev->private;
 }
 
 static void mcs7830_hif_update_multicast_hash(struct usbnet *dev)
diff --git a/drivers/net/usb/net1080.c b/drivers/net/usb/net1080.c
index 5d4a1fd2b524..344dc770620f 100644
--- a/drivers/net/usb/net1080.c
+++ b/drivers/net/usb/net1080.c
@@ -26,7 +26,7 @@
  * Used in (some) LapLink cables
  */
 
-#define frame_errors	data[1]
+#define frame_errors	private[1]
 
 /*
  * NetChip framing of ethernet packets, supporting additional error
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 3a4985b582cb..19a62622aa79 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -306,7 +306,7 @@ static void qmimux_unregister_device(struct net_device *dev,
 static void qmi_wwan_netdev_setup(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = (void *)&dev->private;
 
 	if (info->flags & QMI_WWAN_FLAG_RAWIP) {
 		net->header_ops      = NULL;  /* No header */
@@ -332,7 +332,7 @@ static void qmi_wwan_netdev_setup(struct net_device *net)
 static ssize_t raw_ip_show(struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = (void *)&dev->private;
 
 	return sprintf(buf, "%c\n", info->flags & QMI_WWAN_FLAG_RAWIP ? 'Y' : 'N');
 }
@@ -340,7 +340,7 @@ static ssize_t raw_ip_show(struct device *d, struct device_attribute *attr, char
 static ssize_t raw_ip_store(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = (void *)&dev->private;
 	bool enable;
 	int ret;
 
@@ -409,7 +409,7 @@ static ssize_t add_mux_show(struct device *d, struct device_attribute *attr, cha
 static ssize_t add_mux_store(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = (void *)&dev->private;
 	u8 mux_id;
 	int ret;
 
@@ -447,7 +447,7 @@ static ssize_t del_mux_show(struct device *d, struct device_attribute *attr, cha
 static ssize_t del_mux_store(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = (void *)&dev->private;
 	struct net_device *del_dev;
 	u8 mux_id;
 	int ret = 0;
@@ -480,7 +480,7 @@ static ssize_t pass_through_show(struct device *d,
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
 	struct qmi_wwan_state *info;
 
-	info = (void *)&dev->data;
+	info = (void *)&dev->private;
 	return sprintf(buf, "%c\n",
 		       info->flags & QMI_WWAN_FLAG_PASS_THROUGH ? 'Y' : 'N');
 }
@@ -496,7 +496,7 @@ static ssize_t pass_through_store(struct device *d,
 	if (kstrtobool(buf, &enable))
 		return -EINVAL;
 
-	info = (void *)&dev->data;
+	info = (void *)&dev->private;
 
 	/* no change? */
 	if (enable == (info->flags & QMI_WWAN_FLAG_PASS_THROUGH))
@@ -562,7 +562,7 @@ static const u8 buggy_fw_addr[ETH_ALEN] = {0x00, 0xa0, 0xc6, 0x00, 0x00, 0x00};
  */
 static int qmi_wwan_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 {
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = (void *)&dev->private;
 	bool rawip = info->flags & QMI_WWAN_FLAG_RAWIP;
 	__be16 proto;
 
@@ -653,7 +653,7 @@ static const struct net_device_ops qmi_wwan_netdev_ops = {
  */
 static int qmi_wwan_manage_power(struct usbnet *dev, int on)
 {
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = (void *)&dev->private;
 	int rv;
 
 	dev_dbg(&dev->intf->dev, "%s() pmcount=%d, on=%d\n", __func__,
@@ -687,7 +687,7 @@ static int qmi_wwan_register_subdriver(struct usbnet *dev)
 {
 	int rv;
 	struct usb_driver *subdriver = NULL;
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = (void *)&dev->private;
 
 	/* collect bulk endpoints */
 	rv = usbnet_get_endpoints(dev, info->data);
@@ -750,12 +750,9 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
 	struct usb_cdc_union_desc *cdc_union;
 	struct usb_cdc_ether_desc *cdc_ether;
 	struct usb_driver *driver = driver_of(intf);
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = (void *)&dev->private;
 	struct usb_cdc_parsed_header hdr;
 
-	BUILD_BUG_ON((sizeof(((struct usbnet *)0)->data) <
-		      sizeof(struct qmi_wwan_state)));
-
 	/* set up initial state */
 	info->control = intf;
 	info->data = intf;
@@ -848,7 +845,7 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
 
 static void qmi_wwan_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = (void *)&dev->private;
 	struct usb_driver *driver = driver_of(intf);
 	struct usb_interface *other;
 
@@ -887,7 +884,7 @@ static void qmi_wwan_unbind(struct usbnet *dev, struct usb_interface *intf)
 static int qmi_wwan_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = (void *)&dev->private;
 	int ret;
 
 	/* Both usbnet_suspend() and subdriver->suspend() MUST return 0
@@ -910,7 +907,7 @@ static int qmi_wwan_suspend(struct usb_interface *intf, pm_message_t message)
 static int qmi_wwan_resume(struct usb_interface *intf)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct qmi_wwan_state *info = (void *)&dev->data;
+	struct qmi_wwan_state *info = (void *)&dev->private;
 	int ret = 0;
 	bool callsub = (intf == info->control && info->subdriver &&
 			info->subdriver->resume);
@@ -1584,7 +1581,7 @@ static void qmi_wwan_disconnect(struct usb_interface *intf)
 	/* called twice if separate control and data intf */
 	if (!dev)
 		return;
-	info = (void *)&dev->data;
+	info = (void *)&dev->private;
 	if (info->flags & QMI_WWAN_FLAG_MUX) {
 		if (!rtnl_trylock()) {
 			restart_syscall();
diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 7b3739b29c8f..6aed29dfa021 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -57,7 +57,7 @@ EXPORT_SYMBOL_GPL(rndis_status);
 static void rndis_msg_indicate(struct usbnet *dev, struct rndis_indicate *msg,
 				int buflen)
 {
-	struct cdc_state *info = (void *)&dev->data;
+	struct cdc_state *info = &dev->cdc;
 	struct device *udev = &info->control->dev;
 
 	if (dev->driver_info->indication) {
@@ -90,7 +90,7 @@ static void rndis_msg_indicate(struct usbnet *dev, struct rndis_indicate *msg,
  */
 int rndis_command(struct usbnet *dev, struct rndis_msg_hdr *buf, int buflen)
 {
-	struct cdc_state	*info = (void *) &dev->data;
+	struct cdc_state	*info = &dev->cdc;
 	struct usb_cdc_notification notification;
 	int			master_ifnum;
 	int			retval;
@@ -290,7 +290,7 @@ generic_rndis_bind(struct usbnet *dev, struct usb_interface *intf, int flags)
 {
 	int			retval;
 	struct net_device	*net = dev->net;
-	struct cdc_state	*info = (void *) &dev->data;
+	struct cdc_state	*info = &dev->cdc;
 	union {
 		void			*buf;
 		struct rndis_msg_hdr	*header;
diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index 3ca60ebdd468..beb56bf6b96b 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -190,14 +190,14 @@ static const struct net_device_ops sierra_net_device_ops = {
 /* get private data associated with passed in usbnet device */
 static inline struct sierra_net_data *sierra_net_get_private(struct usbnet *dev)
 {
-	return (struct sierra_net_data *)dev->data[0];
+	return (struct sierra_net_data *)dev->private[0];
 }
 
 /* set private data associated with passed in usbnet device */
 static inline void sierra_net_set_private(struct usbnet *dev,
 			struct sierra_net_data *priv)
 {
-	dev->data[0] = (unsigned long)priv;
+	dev->private[0] = (unsigned long)priv;
 }
 
 /* is packet IPv4/IPv6 */
@@ -855,9 +855,6 @@ static struct sk_buff *sierra_net_tx_fixup(struct usbnet *dev,
 	u16 len;
 	bool need_tail;
 
-	BUILD_BUG_ON(sizeof_field(struct usbnet, data)
-				< sizeof(struct cdc_state));
-
 	dev_dbg(&dev->udev->dev, "%s", __func__);
 	if (priv->link_up && check_ethip_packet(skb, dev) && is_ip(skb)) {
 		/* enough head room as is? */
diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 1a61a8bcf5d3..a28d30a1da4a 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -453,7 +453,7 @@ static int smsc75xx_dataport_wait_not_busy(struct usbnet *dev)
 static int smsc75xx_dataport_write(struct usbnet *dev, u32 ram_select, u32 addr,
 				   u32 length, u32 *buf)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 	u32 dp_sel;
 	int i, ret;
 
@@ -537,7 +537,7 @@ static void smsc75xx_deferred_multicast_write(struct work_struct *param)
 static void smsc75xx_set_multicast(struct net_device *netdev)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 	unsigned long flags;
 	int i;
 
@@ -701,7 +701,7 @@ static void smsc75xx_ethtool_get_wol(struct net_device *net,
 				     struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 
 	wolinfo->supported = SUPPORTED_WAKE;
 	wolinfo->wolopts = pdata->wolopts;
@@ -711,7 +711,7 @@ static int smsc75xx_ethtool_set_wol(struct net_device *net,
 				    struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 	int ret;
 
 	if (wolinfo->wolopts & ~SUPPORTED_WAKE)
@@ -931,7 +931,7 @@ static int smsc75xx_set_features(struct net_device *netdev,
 	netdev_features_t features)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 	unsigned long flags;
 	int ret;
 
@@ -1037,7 +1037,7 @@ static int smsc75xx_phy_gig_workaround(struct usbnet *dev)
 
 static int smsc75xx_reset(struct usbnet *dev)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 	u32 buf;
 	int ret = 0, timeout;
 
@@ -1449,13 +1449,13 @@ static int smsc75xx_bind(struct usbnet *dev, struct usb_interface *intf)
 		netdev_warn(dev->net, "usbnet_get_endpoints failed: %d\n", ret);
 		return ret;
 	}
-
-	dev->data[0] = (unsigned long)kzalloc(sizeof(struct smsc75xx_priv),
-					      GFP_KERNEL);
-
-	pdata = (struct smsc75xx_priv *)(dev->data[0]);
+//FIXME
+	pdata = (struct smsc75xx_priv *)kzalloc(sizeof(struct smsc75xx_priv),
+			GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
+	dev->private[0] = (unsigned long)pdata;
+
 
 	pdata->dev = dev;
 
@@ -1500,18 +1500,18 @@ static int smsc75xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	cancel_work_sync(&pdata->set_multicast);
 free_pdata:
 	kfree(pdata);
-	dev->data[0] = 0;
+	memset(dev->private, 0, sizeof(dev->private));
 	return ret;
 }
 
 static void smsc75xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 	if (pdata) {
 		cancel_work_sync(&pdata->set_multicast);
 		netif_dbg(dev, ifdown, dev->net, "free pdata\n");
 		kfree(pdata);
-		dev->data[0] = 0;
+		memset(dev->private, 0, sizeof(dev->private));
 	}
 }
 
@@ -1562,7 +1562,7 @@ static int smsc75xx_write_wuff(struct usbnet *dev, int filter, u32 wuf_cfg,
 
 static int smsc75xx_enter_suspend0(struct usbnet *dev)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 	u32 val;
 	int ret;
 
@@ -1588,7 +1588,7 @@ static int smsc75xx_enter_suspend0(struct usbnet *dev)
 
 static int smsc75xx_enter_suspend1(struct usbnet *dev)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 	u32 val;
 	int ret;
 
@@ -1624,7 +1624,7 @@ static int smsc75xx_enter_suspend1(struct usbnet *dev)
 
 static int smsc75xx_enter_suspend2(struct usbnet *dev)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 	u32 val;
 	int ret;
 
@@ -1650,7 +1650,7 @@ static int smsc75xx_enter_suspend2(struct usbnet *dev)
 
 static int smsc75xx_enter_suspend3(struct usbnet *dev)
 {
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 	u32 val;
 	int ret;
 
@@ -1785,7 +1785,7 @@ static int smsc75xx_autosuspend(struct usbnet *dev, u32 link_up)
 static int smsc75xx_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 	u32 val, link_up;
 	int ret;
 
@@ -2086,7 +2086,7 @@ static int smsc75xx_suspend(struct usb_interface *intf, pm_message_t message)
 static int smsc75xx_resume(struct usb_interface *intf)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
+	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->private);
 	u8 suspend_flags = pdata->suspend_flags;
 	int ret;
 	u32 val;
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 937e6fef3ac6..cf68064bf7cc 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -230,6 +230,7 @@ static const struct ethtool_ops sr9700_ethtool_ops = {
 static void sr9700_set_multicast(struct net_device *netdev)
 {
 	struct usbnet *dev = netdev_priv(netdev);
+
 	/* rx_ctl setting : enable, disable_long, disable_crc */
 	u8 rx_ctl = RCR_RXEN | RCR_DIS_CRC | RCR_DIS_LONG;
 
diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 6fd33a5b2279..4dad51e2bf53 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -295,7 +295,7 @@ static int sr_write_gpio(struct usbnet *dev, u16 value, int sleep)
 static void sr_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct sr_data *data = (struct sr_data *)&dev->data;
+	struct sr_data *data = (struct sr_data *)&dev->private;
 	u16 rx_ctl = SR_DEFAULT_RX_CTL;
 
 	if (net->flags & IFF_PROMISC) {
@@ -438,7 +438,7 @@ sr_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 static int sr_get_eeprom_len(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct sr_data *data = (struct sr_data *)&dev->data;
+	struct sr_data *data = (struct sr_data *)&dev->private;
 
 	return data->eeprom_len;
 }
@@ -472,7 +472,7 @@ static int sr_get_eeprom(struct net_device *net,
 static int sr_set_mac_address(struct net_device *net, void *p)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct sr_data *data = (struct sr_data *)&dev->data;
+	struct sr_data *data = (struct sr_data *)&dev->private;
 	struct sockaddr *addr = p;
 
 	if (netif_running(net))
@@ -574,7 +574,7 @@ static int sr9800_set_default_mode(struct usbnet *dev)
 
 static int sr9800_reset(struct usbnet *dev)
 {
-	struct sr_data *data = (struct sr_data *)&dev->data;
+	struct sr_data *data = (struct sr_data *)&dev->private;
 	int ret, embd_phy;
 	u16 rx_ctl;
 
@@ -705,7 +705,7 @@ static int sr9800_phy_powerup(struct usbnet *dev)
 
 static int sr9800_bind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct sr_data *data = (struct sr_data *)&dev->data;
+	struct sr_data *data = (struct sr_data *)&dev->private;
 	u16 led01_mux, led23_mux;
 	int ret, embd_phy;
 	u8 addr[ETH_ALEN];
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index 602de719454a..94be042b7a35 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -16,6 +16,18 @@
 #include <linux/usb.h>
 #include <linux/spinlock.h>
 
+/* Drivers that reuse some of the standard USB CDC infrastructure
+ * (notably, using multiple interfaces according to the CDC
+ * union descriptor) get some helper code.
+ */
+struct cdc_state {
+        struct usb_cdc_header_desc      *header;
+        struct usb_cdc_union_desc       *u;
+        struct usb_cdc_ether_desc       *ether;
+        struct usb_interface            *control;
+        struct usb_interface            *data;
+};
+
 /* interface from usbnet core to each USB networking link we handle */
 struct usbnet {
 	/* housekeeping */
@@ -41,7 +53,7 @@ struct usbnet {
 	/* protocol/interface state */
 	struct net_device	*net;
 	int			msg_enable;
-	unsigned long		data[5];
+	struct cdc_state	cdc;		/* too common to leave out*/
 	u32			xid;
 	u32			hard_mtu;	/* count any extra framing */
 	size_t			rx_urb_size;	/* size for rx urbs */
@@ -84,6 +96,7 @@ struct usbnet {
  * that must be broken
  */
 #		define EVENT_UNPLUG		31
+	unsigned long		private[5];
 };
 
 static inline bool usbnet_going_away(struct usbnet *ubn)
@@ -206,18 +219,6 @@ extern int usbnet_write_cmd_nopm(struct usbnet *dev, u8 cmd, u8 reqtype,
 extern int usbnet_write_cmd_async(struct usbnet *dev, u8 cmd, u8 reqtype,
 		    u16 value, u16 index, const void *data, u16 size);
 
-/* Drivers that reuse some of the standard USB CDC infrastructure
- * (notably, using multiple interfaces according to the CDC
- * union descriptor) get some helper code.
- */
-struct cdc_state {
-	struct usb_cdc_header_desc	*header;
-	struct usb_cdc_union_desc	*u;
-	struct usb_cdc_ether_desc	*ether;
-	struct usb_interface		*control;
-	struct usb_interface		*data;
-};
-
 extern void usbnet_cdc_update_filter(struct usbnet *dev);
 extern int usbnet_generic_cdc_bind(struct usbnet *, struct usb_interface *);
 extern int usbnet_ether_cdc_bind(struct usbnet *dev, struct usb_interface *intf);
-- 
2.53.0


