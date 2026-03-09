Return-Path: <netdev+bounces-265652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHbMAqP8rmkxLQIAu9opvQ
	(envelope-from <netdev+bounces-265652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:00:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FF823D3E2
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE837303B184
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A93E9F9E;
	Mon,  9 Mar 2026 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S8n5nLiY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S8n5nLiY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070D63ED13B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075446; cv=none; b=lQy+xwMBzb4Ll/HqEDjUpDwFri7Y65tjFC0WWyXZbRfhSE0rWrrb1j0ppZrcOOb+Xo/N5O91OMlpKZRnx+scPEhdyrAcYMKZH9s1OWPqk6AAhkFlm0BloRhYogimVDU2R0D22FlWgQiAc1AcVpsviLKhKJvx8z5wNZqnBcQC0Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075446; c=relaxed/simple;
	bh=zD24tLTP4QUBH0urVpUKd1ffJKBg2uLO3C/BaLEjZuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6LHY3SwVuHWhxMBtpjuhvCtKdj9TPAu/5gn32vAEXp9c/6eT1uQPpC8xkpy1aLAIQomYlyG/c1uLtQhQ5Al0lqRvnWAggCT8uwotgfzYqlB9HSHK47TXX4QvZn04LjXQBETaJdH5L8gPnAMVNzBRR7f4ZLNr7bYuvDgeb3Hbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S8n5nLiY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S8n5nLiY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75FCB4D253;
	Mon,  9 Mar 2026 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3fZEIP/fQo/jCjy7skvEr1bGevSMpa1F4rw0PnR6Xc=;
	b=S8n5nLiYXUYejQ9WNg2mrbaHFOH0O2XhuWDYmOOgISI2AsshBEdnM0wiobj+xIEh5KfCSq
	oFuIGbjdBTCoqHkRuFRT2G9L0LfWTcquddw0WjJ38eTCDoE7dT9A00kYeVAv3edwGzMN5/
	QVnylQAWBfE+m2Pq3BdWl3Y69d1K3Ow=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=S8n5nLiY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3fZEIP/fQo/jCjy7skvEr1bGevSMpa1F4rw0PnR6Xc=;
	b=S8n5nLiYXUYejQ9WNg2mrbaHFOH0O2XhuWDYmOOgISI2AsshBEdnM0wiobj+xIEh5KfCSq
	oFuIGbjdBTCoqHkRuFRT2G9L0LfWTcquddw0WjJ38eTCDoE7dT9A00kYeVAv3edwGzMN5/
	QVnylQAWBfE+m2Pq3BdWl3Y69d1K3Ow=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5533D3EFDA;
	Mon,  9 Mar 2026 16:56:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sC6zE7n7rmlXZAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 09 Mar 2026 16:56:25 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv3 13/13] net: usb: lg-vl600: use dynamic private allocation
Date: Mon,  9 Mar 2026 17:53:36 +0100
Message-ID: <20260309165614.861929-13-oneukum@suse.com>
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
X-Rspamd-Queue-Id: A7FF823D3E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265652-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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


