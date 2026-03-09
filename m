Return-Path: <netdev+bounces-265648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJLfKgj9rmkxLQIAu9opvQ
	(envelope-from <netdev+bounces-265648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:02:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A929423D464
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55B6E3033E75
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706953EBF24;
	Mon,  9 Mar 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kRpB4Ied";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kRpB4Ied"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694393E8C6F
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075421; cv=none; b=LXwoJ5yMwo5iBdCpFzZWHWQYoyiCS/KYshjbKklwmWovEF7bwL+KYHJboT7K41xzuCuSTsFt8VS4PSzJdzs0FLKnvHB3Yi8tY5yzwD74MlttvKP+mpdrVFKk2sqkuB/H2aDDdXUx78L8RFUYNXdWBiaZH4VFhtzDCK+QMLFc3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075421; c=relaxed/simple;
	bh=n+qrbntEZHCcj+hFDxl5B5IlAY7k6qlt4lrmHo/04+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLeu29QIV2j4wJokR19ZPzj9EEpMScscs5Vt0rqM6FIsyo7TbHlyksoyt8uCCzcyqBCM1sdZbwXXtyi+SLakX5ioZdzalMkEaH5X0ZX9292W2WQzDFi8ScaiweSwnJefi5PA0YzH78Sag+WuVhMUwUw3tMh9U0NxL8vXpRw7F+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kRpB4Ied; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kRpB4Ied; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEFE54D24F;
	Mon,  9 Mar 2026 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRCFBTbCIUI2AwpNK16vUiAWgPqlgBr6jZaCBMOtvy0=;
	b=kRpB4Iedm9QtuqZHxRGfomMTjoqu+5Zsf2zBWcBc64cx2jjrsS8xHufjhIFr3YLSPYuQy1
	MLfgvWYnc2BlDFCt6zNJrOf3M9VBL5V0O41aV+T64WO8M7MAmDEJ86r2CpcOeICl97cqld
	ypplbsLmdDzpUiTiPJcYWcDknJT+gsU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kRpB4Ied
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRCFBTbCIUI2AwpNK16vUiAWgPqlgBr6jZaCBMOtvy0=;
	b=kRpB4Iedm9QtuqZHxRGfomMTjoqu+5Zsf2zBWcBc64cx2jjrsS8xHufjhIFr3YLSPYuQy1
	MLfgvWYnc2BlDFCt6zNJrOf3M9VBL5V0O41aV+T64WO8M7MAmDEJ86r2CpcOeICl97cqld
	ypplbsLmdDzpUiTiPJcYWcDknJT+gsU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D7E23EFD8;
	Mon,  9 Mar 2026 16:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6PR0Ibj7rmlXZAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 09 Mar 2026 16:56:24 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv3 08/13] net: usb: usbnet: allow drivers to specify private space needed
Date: Mon,  9 Mar 2026 17:53:31 +0100
Message-ID: <20260309165614.861929-8-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309165614.861929-1-oneukum@suse.com>
References: <20260309165614.861929-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: A929423D464
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265648-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.983];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

usbnet has been providing a fixed space of unsigned long[5]
for minidrivers. This has led to various constructions in drivers
this is not enough space for.
Allow minidrivers to tell usbnet how much they need by means
of struct driver_info. For backwards compatibility zero
is taken to mean enough space for unsigned long[5]

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/qmi_wwan.c   | 3 ---
 drivers/net/usb/sierra_net.c | 3 ---
 drivers/net/usb/usbnet.c     | 5 ++++-
 include/linux/usb/usbnet.h   | 6 +++++-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 3a4985b582cb..fc2591ccb682 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -753,9 +753,6 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
 	struct qmi_wwan_state *info = (void *)&dev->data;
 	struct usb_cdc_parsed_header hdr;
 
-	BUILD_BUG_ON((sizeof(((struct usbnet *)0)->data) <
-		      sizeof(struct qmi_wwan_state)));
-
 	/* set up initial state */
 	info->control = intf;
 	info->data = intf;
diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index 4d3ed642b3e7..5a32796a7a89 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -855,9 +855,6 @@ static struct sk_buff *sierra_net_tx_fixup(struct usbnet *dev,
 	u16 len;
 	bool need_tail;
 
-	BUILD_BUG_ON(sizeof_field(struct usbnet, data)
-				< sizeof(struct cdc_state));
-
 	dev_dbg(&dev->udev->dev, "%s", __func__);
 	if (priv->link_up && check_ethip_packet(skb, dev) && is_ip(skb)) {
 		/* enough head room as is? */
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 8a9e0d98d9c6..b3cc3428b342 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1734,6 +1734,7 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 	int				status;
 	const char			*name;
 	struct usb_driver 	*driver = to_usb_driver(udev->dev.driver);
+	unsigned int extra;
 
 	/* usbnet already took usb runtime pm, so have to enable the feature
 	 * for usb interface, otherwise usb_autopm_get_interface may return
@@ -1756,7 +1757,9 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 	status = -ENOMEM;
 
 	// set up our own records
-	net = alloc_etherdev(sizeof(*dev));
+	extra = info->required_room ?
+		info->required_room : 5 * sizeof(unsigned long);
+	net = alloc_etherdev(sizeof(*dev) + extra);
 	if (!net)
 		goto out;
 
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index 766862427620..41582346360f 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -50,7 +50,6 @@ struct usbnet {
 	struct net_device	*net;
 	int			msg_enable;
 	struct cdc_state	cdc;		/* too common to leave out*/
-	unsigned long		data[5];
 	u32			xid;
 	u32			hard_mtu;	/* count any extra framing */
 	size_t			rx_urb_size;	/* size for rx urbs */
@@ -93,6 +92,8 @@ struct usbnet {
  * that must be broken
  */
 #		define EVENT_UNPLUG		31
+
+	DECLARE_FLEX_ARRAY(unsigned long, data);
 };
 
 static inline bool usbnet_going_away(struct usbnet *ubn)
@@ -142,6 +143,9 @@ struct driver_info {
 #define FLAG_RX_ASSEMBLE	0x4000	/* rx packets may span >1 frames */
 #define FLAG_NOARP		0x8000	/* device can't do ARP */
 
+	/* tells us how much private space is need in the descriptor */
+	unsigned int	required_room;
+
 	/* init device ... can sleep, or cause probe() failure */
 	int	(*bind)(struct usbnet *, struct usb_interface *);
 
-- 
2.53.0


