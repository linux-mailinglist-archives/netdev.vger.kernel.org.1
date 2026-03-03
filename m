Return-Path: <netdev+bounces-263257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFvALa32pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:56:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B202F1F1DF6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 098A6303C13B
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0180547DF82;
	Tue,  3 Mar 2026 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J9LMoIDl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J9LMoIDl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96947DF93
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549623; cv=none; b=KcrgKhYeEprRes7gsvq5MBUUxmSAV4rs0db+qgrAGOpst2AOXGyf9+O02vAkLeCnNkNNxinU+IciMsUJ8TfNvpreiXV6ZulmsU3pufBxZAsDkI9+ACGasGHA+xTW7DItRpJvltzMYoXek9MWNzUdtORLo49bY9O7gRuS/Eli9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549623; c=relaxed/simple;
	bh=zD24tLTP4QUBH0urVpUKd1ffJKBg2uLO3C/BaLEjZuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NG5Rz8MDMQUBk+RnjctAP4naaZuJOH+jWetvgVbw6UILAQI/mm0BVYddZyZExBdf6F7BWdC8Jy+gNtNF9V5i4V3ADXov4CcsJhROBbG0OGbOis2dyJ1fqgEVfLIz2DbN+w/N1Ux3Qlfski1t567SuQodVE3kUdr61YaP4QY06Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J9LMoIDl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J9LMoIDl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB5D75BE1D;
	Tue,  3 Mar 2026 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3fZEIP/fQo/jCjy7skvEr1bGevSMpa1F4rw0PnR6Xc=;
	b=J9LMoIDluBY4lkX5vbwGSI9QveEDaxzriflLOGUy91wK4kkbpUkado/hohX1fPXQYC4Ll4
	2W31F36/WZxWHZF1ajrKMwhIU9XGYeHat6IrTe58aLw6zO8V6uL98eVpD1v1c72qex1aWK
	s8cPLGGMZvTNBTSOXIipjZ8fMYHa9N8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=J9LMoIDl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3fZEIP/fQo/jCjy7skvEr1bGevSMpa1F4rw0PnR6Xc=;
	b=J9LMoIDluBY4lkX5vbwGSI9QveEDaxzriflLOGUy91wK4kkbpUkado/hohX1fPXQYC4Ll4
	2W31F36/WZxWHZF1ajrKMwhIU9XGYeHat6IrTe58aLw6zO8V6uL98eVpD1v1c72qex1aWK
	s8cPLGGMZvTNBTSOXIipjZ8fMYHa9N8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D0CC3EA6C;
	Tue,  3 Mar 2026 14:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sC5HJcT1pmmPKQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 14:52:52 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv2 13/13] net: usb: lg-vl600: use dynamic private allocation
Date: Tue,  3 Mar 2026 15:50:33 +0100
Message-ID: <20260303145242.1377514-13-oneukum@suse.com>
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
X-Rspamd-Queue-Id: B202F1F1DF6
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
	TAGGED_FROM(0.00)[bounces-263257-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

The old style private room was too small for lg-vl600
With dynamic allocation that factor is gone.
Remove handling private allocations in the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/lg-vl600.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/usb/lg-vl600.c b/drivers/net/usb/lg-vl600.c
index c4ad2d9f6f4f..02949e78e5d6 100644
--- a/drivers/net/usb/lg-vl600.c
+++ b/drivers/net/usb/lg-vl600.c
@@ -56,18 +56,10 @@ struct vl600_state {
 static int vl600_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int ret;
-	struct vl600_state *s = kzalloc_obj(struct vl600_state);
-
-	if (!s)
-		return -ENOMEM;
 
 	ret = usbnet_cdc_bind(dev, intf);
-	if (ret) {
-		kfree(s);
+	if (ret)
 		return ret;
-	}
-
-	dev->driver_priv = s;
 
 	/* ARP packets don't go through, but they're also of no use.  The
 	 * subnet has only two hosts anyway: us and the gateway / DHCP
@@ -85,10 +77,9 @@ static int vl600_bind(struct usbnet *dev, struct usb_interface *intf)
 
 static void vl600_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct vl600_state *s = dev->driver_priv;
+	struct vl600_state *s = usbnet_priv(dev);
 
 	dev_kfree_skb(s->current_rx_buf);
-	kfree(s);
 
 	return usbnet_cdc_unbind(dev, intf);
 }
@@ -101,7 +92,7 @@ static int vl600_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	int packet_len, count;
 	struct sk_buff *buf = skb;
 	struct sk_buff *clone;
-	struct vl600_state *s = dev->driver_priv;
+	struct vl600_state *s = usbnet_priv(dev);
 
 	/* Frame lengths are generally 4B multiplies but every couple of
 	 * hours there's an odd number of bytes sized yet correct frame,
@@ -306,6 +297,7 @@ static const struct driver_info	vl600_info = {
 	.status		= usbnet_cdc_status,
 	.rx_fixup	= vl600_rx_fixup,
 	.tx_fixup	= vl600_tx_fixup,
+	.required_room	= sizeof(struct vl600_state),
 };
 
 static const struct usb_device_id products[] = {
-- 
2.53.0


