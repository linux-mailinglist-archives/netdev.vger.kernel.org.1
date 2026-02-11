Return-Path: <netdev+bounces-258257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKDEIHBejGllmAAAu9opvQ
	(envelope-from <netdev+bounces-258257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:48:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2264123974
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E55B30160E6
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125E0367F2A;
	Wed, 11 Feb 2026 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IFY6H37I";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IFY6H37I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2006331A5C
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806633; cv=none; b=pPB5iEGalKG7zyxb2mSMt6ZJxJvqvWywfXHA6yS3fvta1SUzrmaI13zxrTRUqmSi7TcZLwJiPwSQyvvOkiq8r0yHSSJ3OX2ByiBUubrgKn6W2UB9o4UdcZXo1a1HWlggKdrKwfBxsIUGSWHGRx/5E0/GnYYSEcsfJSnkXdt0LFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806633; c=relaxed/simple;
	bh=2SPrEjztAiE4ZQ1mZUKBelM8f8ZdDkemfRZHR6m+8Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPWP+R7DX9eQC7mhLj2+DybeaYuYOO7y0t0gwkC3tOFIB9LkQMGvO/JMag0tJWxPvNxeGFrWeNh5IoTUE72EVhTyYTAFHV2LgQ/0Zi3rpTbKkGFQUYDiAlyL/ohliZo1cNVCTP7Cif5fo/MQpuuBb1aaKC3k1eEYhWpIDJws1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IFY6H37I; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IFY6H37I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A0425BD99;
	Wed, 11 Feb 2026 10:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770806630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZGpvM0peuzeiYPnO1LaXQPHJJFg4/BPg1q3EFci7PQ=;
	b=IFY6H37IqZ5te5dee7JGUyguQgdiWjf74oG+N5As7jYnNAnzTts31CINpy0oyY6ViZBvjM
	xUDbniqAQ9r5RyHOmLg+JBxM6bJQNyvSvnw6wQRGWVZI8K3Ebq7oneg5CuidgnnNmjCXde
	qiJNDm5MRoR+ohowJ1aiMtV3N8Bpi/Q=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770806630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZGpvM0peuzeiYPnO1LaXQPHJJFg4/BPg1q3EFci7PQ=;
	b=IFY6H37IqZ5te5dee7JGUyguQgdiWjf74oG+N5As7jYnNAnzTts31CINpy0oyY6ViZBvjM
	xUDbniqAQ9r5RyHOmLg+JBxM6bJQNyvSvnw6wQRGWVZI8K3Ebq7oneg5CuidgnnNmjCXde
	qiJNDm5MRoR+ohowJ1aiMtV3N8Bpi/Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E29413EA65;
	Wed, 11 Feb 2026 10:43:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6DkqNmVdjGmMcwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 11 Feb 2026 10:43:49 +0000
From: Oliver Neukum <oneukum@suse.com>
To: bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFC net-next 2/2] net: usb: centralize usbnet_cdc_zte_rx_fixup in usbnet
Date: Wed, 11 Feb 2026 11:43:16 +0100
Message-ID: <20260211104317.84089-2-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211104317.84089-1-oneukum@suse.com>
References: <20260211104317.84089-1-oneukum@suse.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258257-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2264123974
X-Rspamd-Action: no action

This helper is used by multiple drivers using usbnet.
It is better to be provided by usbnet than one of them.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/cdc_ether.c | 19 -------------------
 drivers/net/usb/usbnet.c    | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 3149fa2b6ac1..505a653d9482 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -398,25 +398,6 @@ static int usbnet_cdc_zte_bind(struct usbnet *dev, struct usb_interface *intf)
 	return status;
 }
 
-/* Make sure packets have correct destination MAC address
- *
- * A firmware bug observed on some devices (ZTE MF823/831/910) is that the
- * device sends packets with a static, bogus, random MAC address (event if
- * device MAC address has been updated). Always set MAC address to that of the
- * device.
- */
-int usbnet_cdc_zte_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
-{
-	if (skb->len < ETH_HLEN || !(skb->data[0] & 0x02))
-		return 1;
-
-	skb_reset_mac_header(skb);
-	ether_addr_copy(eth_hdr(skb)->h_dest, dev->net->dev_addr);
-
-	return 1;
-}
-EXPORT_SYMBOL_GPL(usbnet_cdc_zte_rx_fixup);
-
 /* Ensure correct link state
  *
  * Some devices (ZTE MF823/831/910) export two carrier on notifications when
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 09905d07f10f..974c6204cef9 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -2346,6 +2346,25 @@ void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
 	}
 }
 EXPORT_SYMBOL_GPL(usbnet_cdc_status);
+
+/* Make sure packets have correct destination MAC address
+ *
+ * A firmware bug observed on some devices (ZTE MF823/831/910) is that the
+ * device sends packets with a static, bogus, random MAC address (event if
+ * device MAC address has been updated). Always set MAC address to that of the
+ * device.
+ */
+int usbnet_cdc_zte_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
+{
+	if (skb->len < ETH_HLEN || !(skb->data[0] & 0x02))
+		return 1;
+
+	skb_reset_mac_header(skb);
+	ether_addr_copy(eth_hdr(skb)->h_dest, dev->net->dev_addr);
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(usbnet_cdc_zte_rx_fixup);
 /*-------------------------------------------------------------------------*/
 
 static int __init usbnet_init(void)
-- 
2.53.0


