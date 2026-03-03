Return-Path: <netdev+bounces-263255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG46Leb3pmk7bgAAu9opvQ
	(envelope-from <netdev+bounces-263255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:01:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF091F1F27
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B797E314B6C9
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A18847DD6C;
	Tue,  3 Mar 2026 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XIVXFK8N";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XIVXFK8N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3269447CC8A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549612; cv=none; b=owJNRvfY9LsMdXIjV+6Xue8Z0XoyK/OToAdBDupVYNe/0np5HmJQ9/f/hzuYxKSydYix8mRvCOr1GUnkegwlrxmcKuAf5delMrMZ6HqCvlvfbQTeRtfqpuUI7zffck+UoXPjRDy2/ogkGFBn1bpSIDmnhK3sPeyqF2oL/fn7Md0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549612; c=relaxed/simple;
	bh=39LUWq4/wVA5QMbHVx/YW5S0o8yPzhP2B6uZHTD+tsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ospJ+AWKw4frcED2qXzuQvKOKkjhD3HK0TfOJ7jx2bHJmMdegnGxMCnYGYSTSz5NP0sUZENZrP4RfvjjsG93MSy4EsON+liJMTOUXoOdIbuYy22n2S+HRRjxORF+rUxDAIWV1QQxp/+rMV8Rafl8O+d9QnkNT61+IsOemgLmuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XIVXFK8N; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XIVXFK8N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E21E5BE1B;
	Tue,  3 Mar 2026 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2MUuyc1pGUVAFE0ilYhZv2KYBshTqF6eJ6skfWYg78=;
	b=XIVXFK8NzHFtiRJ3K7BZEAR0oOSZ8vY5fcsufeeCzNgXO1Ic1nRYeTmReP1/Dyy9zIU0Mq
	36TDSPv29ilAehcreG9CPDhAOPrOQ+0L6V8yqRrC10TD3WmOBCqHNqpoLV4ae12zkUdQWl
	fax52yOvWrA99+KN0OTjf+K0kt49EsM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2MUuyc1pGUVAFE0ilYhZv2KYBshTqF6eJ6skfWYg78=;
	b=XIVXFK8NzHFtiRJ3K7BZEAR0oOSZ8vY5fcsufeeCzNgXO1Ic1nRYeTmReP1/Dyy9zIU0Mq
	36TDSPv29ilAehcreG9CPDhAOPrOQ+0L6V8yqRrC10TD3WmOBCqHNqpoLV4ae12zkUdQWl
	fax52yOvWrA99+KN0OTjf+K0kt49EsM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A2C83EA6C;
	Tue,  3 Mar 2026 14:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0N4IEcT1pmmPKQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 14:52:52 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv2 11/13] net: usb: cdc_ncm: use dynamic private allocation
Date: Tue,  3 Mar 2026 15:50:31 +0100
Message-ID: <20260303145242.1377514-11-oneukum@suse.com>
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
X-Rspamd-Queue-Id: 5FF091F1F27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263255-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[oneukum.suse.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

The old style private room was too small for cdc_ncm.
With dynamic allocation that factor is gone.
Remove handling private allocations in the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/cdc_ncm.c | 78 +++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 44 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 7057c6c0cfc6..91da42a778f4 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -107,7 +107,7 @@ static void cdc_ncm_get_ethtool_stats(struct net_device *netdev,
 				    u64 *data)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	int i;
 	char *p = NULL;
 
@@ -149,7 +149,7 @@ static const struct ethtool_ops cdc_ncm_ethtool_ops = {
 
 static u32 cdc_ncm_check_rx_max(struct usbnet *dev, u32 new_rx)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	u32 val, max, min;
 
 	/* clamp new_rx to sane values */
@@ -172,7 +172,7 @@ static u32 cdc_ncm_check_rx_max(struct usbnet *dev, u32 new_rx)
 
 static u32 cdc_ncm_check_tx_max(struct usbnet *dev, u32 new_tx)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	u32 val, max, min;
 
 	/* clamp new_tx to sane values */
@@ -202,7 +202,7 @@ static ssize_t min_tx_pkt_show(struct device *d,
 			       struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 
 	return sprintf(buf, "%u\n", ctx->min_tx_pkt);
 }
@@ -211,7 +211,7 @@ static ssize_t rx_max_show(struct device *d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 
 	return sprintf(buf, "%u\n", ctx->rx_max);
 }
@@ -220,7 +220,7 @@ static ssize_t tx_max_show(struct device *d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 
 	return sprintf(buf, "%u\n", ctx->tx_max);
 }
@@ -229,7 +229,7 @@ static ssize_t tx_timer_usecs_show(struct device *d,
 				   struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 
 	return sprintf(buf, "%u\n", ctx->timer_interval / (u32)NSEC_PER_USEC);
 }
@@ -239,7 +239,7 @@ static ssize_t min_tx_pkt_store(struct device *d,
 				const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	unsigned long val;
 
 	/* no need to restrict values - anything from 0 to infinity is OK */
@@ -255,7 +255,7 @@ static ssize_t rx_max_store(struct device *d,
 			    const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	unsigned long val;
 
 	if (kstrtoul(buf, 0, &val) || cdc_ncm_check_rx_max(dev, val) != val)
@@ -270,7 +270,7 @@ static ssize_t tx_max_store(struct device *d,
 			    const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	unsigned long val;
 
 	if (kstrtoul(buf, 0, &val) || cdc_ncm_check_tx_max(dev, val) != val)
@@ -285,7 +285,7 @@ static ssize_t tx_timer_usecs_store(struct device *d,
 				    const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	ssize_t ret;
 	unsigned long val;
 
@@ -311,7 +311,7 @@ static DEVICE_ATTR_RW(tx_timer_usecs);
 static ssize_t ndp_to_end_show(struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 
 	return sprintf(buf, "%c\n", ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END ? 'Y' : 'N');
 }
@@ -319,7 +319,7 @@ static ssize_t ndp_to_end_show(struct device *d, struct device_attribute *attr,
 static ssize_t ndp_to_end_store(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	bool enable;
 
 	if (kstrtobool(buf, &enable))
@@ -361,7 +361,7 @@ static DEVICE_ATTR_RW(ndp_to_end);
 static ssize_t cdc_ncm_show_##name(struct device *d, struct device_attribute *attr, char *buf) \
 { \
 	struct usbnet *dev = netdev_priv(to_net_dev(d)); \
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0]; \
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev); \
 	return sprintf(buf, format "\n", tocpu(ctx->ncm_parm.name));	\
 } \
 static DEVICE_ATTR(name, 0444, cdc_ncm_show_##name, NULL)
@@ -404,7 +404,7 @@ static const struct attribute_group cdc_ncm_sysfs_attr_group = {
 /* handle rx_max and tx_max changes */
 static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	u32 val;
 
@@ -476,7 +476,7 @@ static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
 /* helpers for NCM and MBIM differences */
 static u8 cdc_ncm_flags(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 
 	if (cdc_ncm_comm_intf_is_mbim(dev->intf->cur_altsetting) && ctx->mbim_desc)
 		return ctx->mbim_desc->bmNetworkCapabilities;
@@ -501,7 +501,7 @@ static u32 cdc_ncm_min_dgram_size(struct usbnet *dev)
 
 static u32 cdc_ncm_max_dgram_size(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 
 	if (cdc_ncm_comm_intf_is_mbim(dev->intf->cur_altsetting) && ctx->mbim_desc)
 		return le16_to_cpu(ctx->mbim_desc->wMaxSegmentSize);
@@ -515,7 +515,7 @@ static u32 cdc_ncm_max_dgram_size(struct usbnet *dev)
  */
 static int cdc_ncm_init(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	int err;
 
@@ -608,7 +608,7 @@ static int cdc_ncm_init(struct usbnet *dev)
 /* set a new max datagram size */
 static void cdc_ncm_set_dgram_size(struct usbnet *dev, int new_size)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	__le16 max_datagram_size;
 	u16 mbim_mtu;
@@ -656,7 +656,7 @@ static void cdc_ncm_set_dgram_size(struct usbnet *dev, int new_size)
 
 static void cdc_ncm_fix_modulus(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	u32 val;
 
 	/*
@@ -700,7 +700,7 @@ static void cdc_ncm_fix_modulus(struct usbnet *dev)
 
 static int cdc_ncm_setup(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
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
@@ -786,8 +783,6 @@ static void cdc_ncm_free(struct cdc_ncm_ctx *ctx)
 		kfree(ctx->delayed_ndp16);
 	else
 		kfree(ctx->delayed_ndp32);
-
-	kfree(ctx);
 }
 
 /* we need to override the usbnet change_mtu ndo for two reasons:
@@ -819,7 +814,7 @@ static const struct net_device_ops cdc_ncm_netdev_ops = {
 
 int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_altsetting, int drvflags)
 {
-	struct cdc_ncm_ctx *ctx;
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	struct usb_driver *driver;
 	u8 *buf;
 	int len;
@@ -827,10 +822,6 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	u8 iface_no;
 	struct usb_cdc_parsed_header hdr;
 
-	ctx = kzalloc_obj(*ctx);
-	if (!ctx)
-		return -ENOMEM;
-
 	ctx->dev = dev;
 
 	hrtimer_setup(&ctx->tx_timer, &cdc_ncm_tx_timer_cb, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
@@ -838,9 +829,6 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	atomic_set(&ctx->stop, 0);
 	spin_lock_init(&ctx->mtx);
 
-	/* store ctx pointer in device data field */
-	dev->data[0] = (unsigned long)ctx;
-
 	/* only the control interface can be successfully probed */
 	ctx->control = intf;
 
@@ -988,8 +976,7 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	if (ctx->data != ctx->control)
 		usb_driver_release_interface(driver, ctx->data);
 error:
-	cdc_ncm_free((struct cdc_ncm_ctx *)dev->data[0]);
-	dev->data[0] = 0;
+	cdc_ncm_free(usbnet_priv(dev));
 	dev_info(&intf->dev, "bind() failure\n");
 	return -ENODEV;
 }
@@ -997,12 +984,9 @@ EXPORT_SYMBOL_GPL(cdc_ncm_bind_common);
 
 void cdc_ncm_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	struct usb_driver *driver = driver_of(intf);
 
-	if (ctx == NULL)
-		return;		/* no setup */
-
 	atomic_set(&ctx->stop, 1);
 
 	hrtimer_cancel(&ctx->tx_timer);
@@ -1203,7 +1187,7 @@ static struct usb_cdc_ncm_ndp32 *cdc_ncm_ndp32(struct cdc_ncm_ctx *ctx, struct s
 struct sk_buff *
 cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	union {
 		struct usb_cdc_ncm_nth16 *nth16;
 		struct usb_cdc_ncm_nth32 *nth32;
@@ -1523,7 +1507,7 @@ struct sk_buff *
 cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 {
 	struct sk_buff *skb_out;
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 
 	/*
 	 * The Ethernet API we are using does not support transmitting
@@ -1725,7 +1709,7 @@ EXPORT_SYMBOL_GPL(cdc_ncm_rx_verify_ndp32);
 int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 {
 	struct sk_buff *skb;
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 	unsigned int len;
 	int nframes;
 	int x;
@@ -1904,7 +1888,7 @@ static void cdc_ncm_status(struct usbnet *dev, struct urb *urb)
 
 static void cdc_ncm_update_filter(struct usbnet *dev)
 {
-	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx = usbnet_priv(dev);
 
 	if (ctx->filtering_supported)
 		usbnet_cdc_update_filter(dev);
@@ -1921,6 +1905,7 @@ static const struct driver_info cdc_ncm_info = {
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
 	.set_rx_mode = cdc_ncm_update_filter,
+	.required_room = sizeof(struct cdc_ncm_ctx),
 };
 
 /* Same as cdc_ncm_info, but with FLAG_SEND_ZLP  */
@@ -1935,6 +1920,7 @@ static const struct driver_info cdc_ncm_zlp_info = {
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
 	.set_rx_mode = cdc_ncm_update_filter,
+	.required_room = sizeof(struct cdc_ncm_ctx),
 };
 
 /* Same as cdc_ncm_info, but with FLAG_SEND_ZLP */
@@ -1949,6 +1935,7 @@ static const struct driver_info apple_tethering_interface_info = {
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
 	.set_rx_mode = usbnet_cdc_update_filter,
+	.required_room = sizeof(struct cdc_ncm_ctx),
 };
 
 /* Same as apple_tethering_interface_info, but without FLAG_LINK_INTR */
@@ -1963,6 +1950,7 @@ static const struct driver_info apple_private_interface_info = {
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
 	.set_rx_mode = usbnet_cdc_update_filter,
+	.required_room = sizeof(struct cdc_ncm_ctx),
 };
 
 /* Same as cdc_ncm_info, but with FLAG_WWAN */
@@ -1977,6 +1965,7 @@ static const struct driver_info wwan_info = {
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
 	.set_rx_mode = cdc_ncm_update_filter,
+	.required_room = sizeof(struct cdc_ncm_ctx),
 };
 
 /* Same as wwan_info, but with FLAG_NOARP  */
@@ -1991,6 +1980,7 @@ static const struct driver_info wwan_noarp_info = {
 	.rx_fixup = cdc_ncm_rx_fixup,
 	.tx_fixup = cdc_ncm_tx_fixup,
 	.set_rx_mode = cdc_ncm_update_filter,
+	.required_room = sizeof(struct cdc_ncm_ctx),
 };
 
 static const struct usb_device_id cdc_devs[] = {
-- 
2.53.0


