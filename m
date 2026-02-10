Return-Path: <netdev+bounces-258108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COdbBW1Li2mWTwAAu9opvQ
	(envelope-from <netdev+bounces-258108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:14:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22F11C5FA
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DDF63015A57
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BC137FF50;
	Tue, 10 Feb 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hufls1m0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hufls1m0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B08632B
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736466; cv=none; b=tqG3R13UGfAso+7L9iRr3V6aLCSdpCBwPKLEG3LvY7jY/5jo4pJZCOzes7RfcRp7n/CVgK00vXr6pGTLYlwbJvso54w+K/CRy4kdrPeuriUMW2i8hPx1lafpk7TJt5+8A7/QQGdZQkqFnEdaocBrNMpsAY2gLpJ9L9ba85jOk4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736466; c=relaxed/simple;
	bh=kkCHI6vScb6nONPv6oAijeAiEvgROjBdMopB0TCHVO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zu2mxijdmnE+67NgAtWngLTjoomHF3vBVFTdMkl0r7KnUcc9qYTihNvxo47XQ7DEJFa71VLjL+nEmcdPp8A0uWG4MrYIdUVJbKrE0bCENHWxIk2F7NIswRnLoaBzR19iovcGKx6nFZQGuogMpxtd9lF2qGe+k4XQ3cXlBBmb434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hufls1m0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hufls1m0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 799B23E717;
	Tue, 10 Feb 2026 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770736462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlcibLCcJ/Rmq52drHSHRVGXGc2H4Hl/15gD4WCsZOQ=;
	b=Hufls1m08QEHxruXNwUrn/10Y0EX3t/RuevgqpcX0yzu+Y+zF6oTHqxL35G9/VjfwQTPJN
	NseMAezOJb6B0USLdfCx2AAu61OebmSOVAE1uZfG+MTXQkfVBsK0FIFxE42pyRTfvU7gYG
	6FIvjoyqgcIjKGNCqM2q57wzAH9zHtc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Hufls1m0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770736462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlcibLCcJ/Rmq52drHSHRVGXGc2H4Hl/15gD4WCsZOQ=;
	b=Hufls1m08QEHxruXNwUrn/10Y0EX3t/RuevgqpcX0yzu+Y+zF6oTHqxL35G9/VjfwQTPJN
	NseMAezOJb6B0USLdfCx2AAu61OebmSOVAE1uZfG+MTXQkfVBsK0FIFxE42pyRTfvU7gYG
	6FIvjoyqgcIjKGNCqM2q57wzAH9zHtc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08A643EA65;
	Tue, 10 Feb 2026 15:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oAFTOE1Li2lmVgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 10 Feb 2026 15:14:21 +0000
From: Oliver Neukum <oneukum@suse.com>
To: netdev@vger.kernel.org,
	hayeswang@realtek.com,
	bjorn@mork.no,
	o.rempel@pengutronix.de
Cc: Oliver Neukum <oneukum@suse.com>,
	Oliver Neukum <oneukum@suse.de>
Subject: [RFC net-next 2/3] net: usb: usbnet: switch to dynamic allocation of private data
Date: Tue, 10 Feb 2026 16:11:13 +0100
Message-ID: <20260210151416.42254-3-oneukum@suse.com>
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
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258108-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.de:email]
X-Rspamd-Queue-Id: AB22F11C5FA
X-Rspamd-Action: no action

usbnet used an unsigned long[5] scratchpad space for private
use of subdrivers. That is inelegant and not enough space
for some drivers. Switch to letting drivers specify how much
room they need in their driver_info.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/net/usb/ax88172a.c   |  1 +
 drivers/net/usb/cdc_mbim.c   |  4 ++
 drivers/net/usb/cdc_ncm.c    | 82 +++++++++++++++++-------------------
 drivers/net/usb/sierra_net.c | 21 +++------
 drivers/net/usb/smsc75xx.c   |  4 +-
 drivers/net/usb/usbnet.c     |  2 +-
 include/linux/usb/usbnet.h   |  5 ++-
 7 files changed, 56 insertions(+), 63 deletions(-)

diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index 1694d6ca2b7b..34884805730d 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -355,4 +355,5 @@ const struct driver_info ax88172a_info = {
 		 FLAG_MULTI_PACKET,
 	.rx_fixup = ax88172a_rx_fixup,
 	.tx_fixup = asix_tx_fixup,
+	.required_room = sizeof(struct ax88172a_private),
 };
diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index f08f0fc3a8c1..08ea101feb6a 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -557,6 +557,7 @@ static const struct driver_info cdc_mbim_info = {
 	.manage_power = cdc_mbim_manage_power,
 	.rx_fixup = cdc_mbim_rx_fixup,
 	.tx_fixup = cdc_mbim_tx_fixup,
+	.required_room = sizeof(struct cdc_mbim_state),
 };
 
 /* MBIM and NCM devices should not need a ZLP after NTBs with
@@ -581,6 +582,7 @@ static const struct driver_info cdc_mbim_info_zlp = {
 	.manage_power = cdc_mbim_manage_power,
 	.rx_fixup = cdc_mbim_rx_fixup,
 	.tx_fixup = cdc_mbim_tx_fixup,
+	.required_room = sizeof(struct cdc_mbim_state),
 };
 
 /* The spefication explicitly allows NDPs to be placed anywhere in the
@@ -601,6 +603,7 @@ static const struct driver_info cdc_mbim_info_ndp_to_end = {
 	.rx_fixup = cdc_mbim_rx_fixup,
 	.tx_fixup = cdc_mbim_tx_fixup,
 	.data = CDC_NCM_FLAG_NDP_TO_END,
+	.required_room = sizeof(struct cdc_mbim_state),
 };
 
 /* Some modems (e.g. Telit LE922A6) do not work properly with altsetting
@@ -616,6 +619,7 @@ static const struct driver_info cdc_mbim_info_avoid_altsetting_toggle = {
 	.rx_fixup = cdc_mbim_rx_fixup,
 	.tx_fixup = cdc_mbim_tx_fixup,
 	.data = CDC_MBIM_FLAG_AVOID_ALTSETTING_TOGGLE,
+	.required_room = sizeof(struct cdc_mbim_state),
 };
 
 static const struct usb_device_id mbim_devs[] = {
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index d0d13b2d52e6..7a14900b64c4 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -107,7 +107,7 @@ static void cdc_ncm_get_ethtool_stats(struct net_device *netdev,
 				    u64 *data)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	int i;
 	char *p = NULL;
 
@@ -149,7 +149,7 @@ static const struct ethtool_ops cdc_ncm_ethtool_ops = {
 
 static u32 cdc_ncm_check_rx_max(struct usbnet *dev, u32 new_rx)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	u32 val, max, min;
 
 	/* clamp new_rx to sane values */
@@ -172,7 +172,7 @@ static u32 cdc_ncm_check_rx_max(struct usbnet *dev, u32 new_rx)
 
 static u32 cdc_ncm_check_tx_max(struct usbnet *dev, u32 new_tx)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	u32 val, max, min;
 
 	/* clamp new_tx to sane values */
@@ -202,7 +202,7 @@ static ssize_t min_tx_pkt_show(struct device *d,
 			       struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 
 	return sprintf(buf, "%u\n", ctx->min_tx_pkt);
 }
@@ -211,7 +211,7 @@ static ssize_t rx_max_show(struct device *d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 
 	return sprintf(buf, "%u\n", ctx->rx_max);
 }
@@ -220,7 +220,7 @@ static ssize_t tx_max_show(struct device *d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 
 	return sprintf(buf, "%u\n", ctx->tx_max);
 }
@@ -229,7 +229,7 @@ static ssize_t tx_timer_usecs_show(struct device *d,
 				   struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 
 	return sprintf(buf, "%u\n", ctx->timer_interval / (u32)NSEC_PER_USEC);
 }
@@ -239,7 +239,7 @@ static ssize_t min_tx_pkt_store(struct device *d,
 				const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	unsigned long val;
 
 	/* no need to restrict values - anything from 0 to infinity is OK */
@@ -255,7 +255,7 @@ static ssize_t rx_max_store(struct device *d,
 			    const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	unsigned long val;
 
 	if (kstrtoul(buf, 0, &val) || cdc_ncm_check_rx_max(dev, val) != val)
@@ -270,7 +270,7 @@ static ssize_t tx_max_store(struct device *d,
 			    const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	unsigned long val;
 
 	if (kstrtoul(buf, 0, &val) || cdc_ncm_check_tx_max(dev, val) != val)
@@ -285,7 +285,7 @@ static ssize_t tx_timer_usecs_store(struct device *d,
 				    const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	ssize_t ret;
 	unsigned long val;
 
@@ -311,7 +311,7 @@ static DEVICE_ATTR_RW(tx_timer_usecs);
 static ssize_t ndp_to_end_show(struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 
 	return sprintf(buf, "%c\n", ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END ? 'Y' : 'N');
 }
@@ -319,7 +319,7 @@ static ssize_t ndp_to_end_show(struct device *d, struct device_attribute *attr,
 static ssize_t ndp_to_end_store(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	bool enable;
 
 	if (kstrtobool(buf, &enable))
@@ -361,7 +361,7 @@ static DEVICE_ATTR_RW(ndp_to_end);
 static ssize_t cdc_ncm_show_##name(struct device *d, struct device_attribute *attr, char *buf) \
 { \
 	struct usbnet *dev = netdev_priv(to_net_dev(d)); \
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0]; \
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private; \
 	return sprintf(buf, format "\n", tocpu(ctx->ncm_parm.name));	\
 } \
 static DEVICE_ATTR(name, 0444, cdc_ncm_show_##name, NULL)
@@ -404,7 +404,7 @@ static const struct attribute_group cdc_ncm_sysfs_attr_group = {
 /* handle rx_max and tx_max changes */
 static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	u32 val;
 
@@ -476,7 +476,7 @@ static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
 /* helpers for NCM and MBIM differences */
 static u8 cdc_ncm_flags(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 
 	if (cdc_ncm_comm_intf_is_mbim(dev->intf->cur_altsetting) && ctx->mbim_desc)
 		return ctx->mbim_desc->bmNetworkCapabilities;
@@ -501,7 +501,7 @@ static u32 cdc_ncm_min_dgram_size(struct usbnet *dev)
 
 static u32 cdc_ncm_max_dgram_size(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 
 	if (cdc_ncm_comm_intf_is_mbim(dev->intf->cur_altsetting) && ctx->mbim_desc)
 		return le16_to_cpu(ctx->mbim_desc->wMaxSegmentSize);
@@ -515,7 +515,7 @@ static u32 cdc_ncm_max_dgram_size(struct usbnet *dev)
  */
 static int cdc_ncm_init(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	int err;
 
@@ -608,7 +608,7 @@ static int cdc_ncm_init(struct usbnet *dev)
 /* set a new max datagram size */
 static void cdc_ncm_set_dgram_size(struct usbnet *dev, int new_size)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	__le16 max_datagram_size;
 	u16 mbim_mtu;
@@ -656,7 +656,7 @@ static void cdc_ncm_set_dgram_size(struct usbnet *dev, int new_size)
 
 static void cdc_ncm_fix_modulus(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	u32 val;
 
 	/*
@@ -700,7 +700,7 @@ static void cdc_ncm_fix_modulus(struct usbnet *dev)
 
 static int cdc_ncm_setup(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	u32 def_rx, def_tx;
 
 	/* be conservative when selecting initial buffer size to
@@ -769,9 +769,6 @@ cdc_ncm_find_endpoints(struct usbnet *dev, struct usb_interface *intf)
 
 static void cdc_ncm_free(struct cdc_ncm_ctx *ctx)
 {
-	if (ctx == NULL)
-		return;
-
 	if (ctx->tx_rem_skb != NULL) {
 		dev_kfree_skb_any(ctx->tx_rem_skb);
 		ctx->tx_rem_skb = NULL;
@@ -782,12 +779,13 @@ static void cdc_ncm_free(struct cdc_ncm_ctx *ctx)
 		ctx->tx_curr_skb = NULL;
 	}
 
-	if (ctx->is_ndp16)
+	if (ctx->is_ndp16) {
 		kfree(ctx->delayed_ndp16);
-	else
+		ctx->delayed_ndp16 = NULL;
+	} else {
 		kfree(ctx->delayed_ndp32);
-
-	kfree(ctx);
+		ctx->delayed_ndp32 = NULL;
+	}
 }
 
 /* we need to override the usbnet change_mtu ndo for two reasons:
@@ -819,7 +817,7 @@ static const struct net_device_ops cdc_ncm_netdev_ops = {
 
 int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_altsetting, int drvflags)
 {
-	struct cdc_ncm_ctx *ctx;
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	struct usb_driver *driver;
 	u8 *buf;
 	int len;
@@ -827,10 +825,6 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	u8 iface_no;
 	struct usb_cdc_parsed_header hdr;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
-
 	ctx->dev = dev;
 
 	hrtimer_setup(&ctx->tx_timer, &cdc_ncm_tx_timer_cb, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
@@ -838,9 +832,6 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	atomic_set(&ctx->stop, 0);
 	spin_lock_init(&ctx->mtx);
 
-	/* store ctx pointer in device data field */
-	dev->private[0] = (unsigned long)ctx;
-
 	/* only the control interface can be successfully probed */
 	ctx->control = intf;
 
@@ -988,8 +979,7 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	if (ctx->data != ctx->control)
 		usb_driver_release_interface(driver, ctx->data);
 error:
-	cdc_ncm_free((struct cdc_ncm_ctx *)dev->private[0]);
-	dev->private[0] = 0;
+	cdc_ncm_free((struct cdc_ncm_ctx *)dev->private);
 	dev_info(&intf->dev, "bind() failure\n");
 	return -ENODEV;
 }
@@ -997,7 +987,7 @@ EXPORT_SYMBOL_GPL(cdc_ncm_bind_common);
 
 void cdc_ncm_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	struct usb_driver *driver = driver_of(intf);
 
 	if (ctx == NULL)
@@ -1203,7 +1193,7 @@ static struct usb_cdc_ncm_ndp32 *cdc_ncm_ndp32(struct cdc_ncm_ctx *ctx, struct s
 struct sk_buff *
 cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	union {
 		struct usb_cdc_ncm_nth16 *nth16;
 		struct usb_cdc_ncm_nth32 *nth32;
@@ -1523,7 +1513,7 @@ struct sk_buff *
 cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 {
 	struct sk_buff *skb_out;
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 
 	/*
 	 * The Ethernet API we are using does not support transmitting
@@ -1725,7 +1715,7 @@ EXPORT_SYMBOL_GPL(cdc_ncm_rx_verify_ndp32);
 int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 {
 	struct sk_buff *skb;
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 	unsigned int len;
 	int nframes;
 	int x;
@@ -1904,7 +1894,7 @@ static void cdc_ncm_status(struct usbnet *dev, struct urb *urb)
 
 static void cdc_ncm_update_filter(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
+	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;
 
 	if (ctx->filtering_supported)
 		usbnet_cdc_update_filter(dev);
@@ -1921,6 +1911,7 @@ static const struct driver_info cdc_ncm_info = {
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
 	.set_rx_mode = cdc_ncm_update_filter,
+	.required_room = sizeof(struct cdc_ncm_ctx),
 };
 
 /* Same as cdc_ncm_info, but with FLAG_SEND_ZLP  */
@@ -1935,6 +1926,7 @@ static const struct driver_info cdc_ncm_zlp_info = {
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
 	.set_rx_mode = cdc_ncm_update_filter,
+	.required_room = sizeof(struct cdc_ncm_ctx),
 };
 
 /* Same as cdc_ncm_info, but with FLAG_SEND_ZLP */
@@ -1949,6 +1941,7 @@ static const struct driver_info apple_tethering_interface_info = {
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
 	.set_rx_mode = usbnet_cdc_update_filter,
+	.required_room = sizeof(struct cdc_ncm_ctx),
 };
 
 /* Same as apple_tethering_interface_info, but without FLAG_LINK_INTR */
@@ -1963,6 +1956,7 @@ static const struct driver_info apple_private_interface_info = {
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
 	.set_rx_mode = usbnet_cdc_update_filter,
+	.required_room = sizeof(struct cdc_ncm_ctx),
 };
 
 /* Same as cdc_ncm_info, but with FLAG_WWAN */
@@ -1977,6 +1971,7 @@ static const struct driver_info wwan_info = {
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
 	.set_rx_mode = cdc_ncm_update_filter,
+	.required_room = sizeof(struct cdc_ncm_ctx),
 };
 
 /* Same as wwan_info, but with FLAG_NOARP  */
@@ -1991,6 +1986,7 @@ static const struct driver_info wwan_noarp_info = {
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
 	.set_rx_mode = cdc_ncm_update_filter,
+	.required_room = sizeof(struct cdc_ncm_ctx),
 };
 
 static const struct usb_device_id cdc_devs[] = {
diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index beb56bf6b96b..7b15b89aa62b 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -190,14 +190,7 @@ static const struct net_device_ops sierra_net_device_ops = {
 /* get private data associated with passed in usbnet device */
 static inline struct sierra_net_data *sierra_net_get_private(struct usbnet *dev)
 {
-	return (struct sierra_net_data *)dev->private[0];
-}
-
-/* set private data associated with passed in usbnet device */
-static inline void sierra_net_set_private(struct usbnet *dev,
-			struct sierra_net_data *priv)
-{
-	dev->private[0] = (unsigned long)priv;
+	return (struct sierra_net_data *)dev->private;
 }
 
 /* is packet IPv4/IPv6 */
@@ -653,7 +646,7 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8	numendpoints;
 	u16	fwattr = 0;
 	int	status;
-	struct sierra_net_data *priv;
+	struct sierra_net_data *priv = (struct sierra_net_data *)dev->private;
 	static const u8 sync_tmplate[sizeof(priv->sync_msg)] = {
 		0x00, 0x00, SIERRA_NET_HIP_MSYNC_ID, 0x00};
 	static const u8 shdwn_tmplate[sizeof(priv->shdwn_msg)] = {
@@ -682,11 +675,8 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 		dev_err(&dev->udev->dev, "No status endpoint found");
 		return -ENODEV;
 	}
-	/* Initialize sierra private data */
-	priv = kzalloc(sizeof *priv, GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
 
+	/* Initialize sierra private data */
 	priv->usbnet = dev;
 	priv->ifnum = ifacenum;
 	dev->net->netdev_ops = &sierra_net_device_ops;
@@ -718,8 +708,6 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 	dev->net->ethtool_ops = &sierra_net_ethtool_ops;
 	netif_carrier_off(dev->net);
 
-	sierra_net_set_private(dev, priv);
-
 	priv->kevent_flags = 0;
 
 	/* Use the shared workqueue */
@@ -764,7 +752,7 @@ static void sierra_net_unbind(struct usbnet *dev, struct usb_interface *intf)
 
 	usbnet_status_stop(dev);
 
-	sierra_net_set_private(dev, NULL);
+	memset(dev->private, 0, sizeof(struct sierra_net_data));
 	kfree(priv);
 }
 
@@ -905,6 +893,7 @@ static const struct driver_info sierra_net_info_direct_ip = {
 	.status = sierra_net_status,
 	.rx_fixup = sierra_net_rx_fixup,
 	.tx_fixup = sierra_net_tx_fixup,
+	.required_room = sizeof(struct sierra_net_data),
 };
 
 static int
diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index a28d30a1da4a..46cd806954de 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -1500,7 +1500,7 @@ static int smsc75xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	cancel_work_sync(&pdata->set_multicast);
 free_pdata:
 	kfree(pdata);
-	memset(dev->private, 0, sizeof(dev->private));
+	memset(dev->private, 0, sizeof(struct smsc75xx_priv *));
 	return ret;
 }
 
@@ -1511,7 +1511,7 @@ static void smsc75xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 		cancel_work_sync(&pdata->set_multicast);
 		netif_dbg(dev, ifdown, dev->net, "free pdata\n");
 		kfree(pdata);
-		memset(dev->private, 0, sizeof(dev->private));
+		memset(dev->private, 0, sizeof(struct smsc75xx_priv *));
 	}
 }
 
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 974c6204cef9..e1733a3612c6 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1756,7 +1756,7 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 	status = -ENOMEM;
 
 	// set up our own records
-	net = alloc_etherdev(sizeof(*dev));
+	net = alloc_etherdev(sizeof(*dev) + info->required_room);
 	if (!net)
 		goto out;
 
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index 94be042b7a35..ba45a3e2be6a 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -96,7 +96,7 @@ struct usbnet {
  * that must be broken
  */
 #		define EVENT_UNPLUG		31
-	unsigned long		private[5];
+	DECLARE_FLEX_ARRAY(u8, private);
 };
 
 static inline bool usbnet_going_away(struct usbnet *ubn)
@@ -146,6 +146,9 @@ struct driver_info {
 #define FLAG_RX_ASSEMBLE	0x4000	/* rx packets may span >1 frames */
 #define FLAG_NOARP		0x8000	/* device can't do ARP */
 
+	/* tells us how much private space is need in the descriptor */
+	unsigned int		required_room;
+
 	/* init device ... can sleep, or cause probe() failure */
 	int	(*bind)(struct usbnet *, struct usb_interface *);
 
-- 
2.53.0


