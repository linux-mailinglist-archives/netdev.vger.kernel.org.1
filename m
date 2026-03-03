Return-Path: <netdev+bounces-263247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ne+N033pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:59:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E5F1F1EA6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81FCF3198A0E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FCF47DD65;
	Tue,  3 Mar 2026 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j61tITwA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j61tITwA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544D47D94F
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549581; cv=none; b=px4a7rI6M6BShGU7IzzRdGIy4HgtNLow9dpOWGs39WPo0j9JAT6SdwXT8W4jxNTFYiAYOvZRjpz5rlOh03GHU/heqGkNfnBAAbSh6ZHAZuhFSOPyZc9kK4JpMPP4CSe89nnnAIg61ySADexvCHFHgx9zo3VCNT4rtADUTEAuTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549581; c=relaxed/simple;
	bh=n+qrbntEZHCcj+hFDxl5B5IlAY7k6qlt4lrmHo/04+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljerP0HUFv62uQ2Zo2OznJVO8KqZTVrDmAIkfOCD4x43+BmhoR+FbUMGxSmAocfYhjgF+hxSWrteCfFr36QrBpJGGuXFLAxGfn3OaqXCa27ZpNyBbMy1oXInqd+VoarRrRKma2xo15bis8ZlG1g3hCpc3W5rcOgBs+VqxFiBR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j61tITwA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j61tITwA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CAE53F915;
	Tue,  3 Mar 2026 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRCFBTbCIUI2AwpNK16vUiAWgPqlgBr6jZaCBMOtvy0=;
	b=j61tITwA3o4aTb40PFm9ECki1X7f+23KnO4DfudktG08EJ7RsLSyM1/xwKI7XiMCy+nnZH
	PUNMldd7c6T8a+TJQK01pE4dG382avFpIz4TV8bhUPZBiD0pZ2pYql6MI5ZRNftlUX4jM6
	MzwK3smMCJGRTZwUAJt9zvPYeKaVmwg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=j61tITwA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRCFBTbCIUI2AwpNK16vUiAWgPqlgBr6jZaCBMOtvy0=;
	b=j61tITwA3o4aTb40PFm9ECki1X7f+23KnO4DfudktG08EJ7RsLSyM1/xwKI7XiMCy+nnZH
	PUNMldd7c6T8a+TJQK01pE4dG382avFpIz4TV8bhUPZBiD0pZ2pYql6MI5ZRNftlUX4jM6
	MzwK3smMCJGRTZwUAJt9zvPYeKaVmwg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6BAB3EA72;
	Tue,  3 Mar 2026 14:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GOR4K8P1pmmPKQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 14:52:51 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv2 08/13] net: usb: usbnet: allow drivers to specify private space needed
Date: Tue,  3 Mar 2026 15:50:28 +0100
Message-ID: <20260303145242.1377514-8-oneukum@suse.com>
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
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 37E5F1F1EA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263247-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
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


