Return-Path: <netdev+bounces-263248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOvcKQD2pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:53:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 265811F1D48
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DE8B302EA8C
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6D547DD53;
	Tue,  3 Mar 2026 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mh+Cl5Bb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cqP0N9UF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D247DD6B
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549587; cv=none; b=DlJe69aewTE3PNPdeXPr6nrI43bfFTtKBm9jfUkwC3qhVjWWtO5eHxQM0XbZFBQTWUrdou6wau8XcsHmxDzOvRIJ8/5m+kt5pTLpZbl+ZHuS3Iw3IVgL2jet/vnbj1XdiAoooruYQk/1L6JeX64oyxa/wkXgwFsUfoqAAySPwsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549587; c=relaxed/simple;
	bh=Ty+bt3DHtWxTOGpZD6KfZHK3GsAUR3f0B8WSx0HsVaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZysEuuxQKUq5ipmwcXiQMEahVdK6ba2CSdr6xFSk6IXySwXLLjzbdyl9zu8BcmP2gHftfT6RW4YkRSxa2V3YJxUgd4dRET3+pWiR0G2sWPdW/drPryuTQshgPD4+YPGAqok0Js1ZF2twTtVupf6BLn9HEovfPA3CiLZoFLZIodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mh+Cl5Bb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cqP0N9UF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 190EC5BE0E;
	Tue,  3 Mar 2026 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Za0JBcT5V6vBaHOpl5CMFbXKhHQ2OBmbH88+gHAsx7k=;
	b=Mh+Cl5BbVAHnUrhxKaXr7ruzsxlzEEytJZf2xaovyDJhS2BZBDxkrpqUhB4ABt2idvtkkR
	tuf399ED4hWDdvzn0OwMUek7bUs/73DG6OBUdI5GjzBm05M9Bse5SMveP1HHshLz7hsxId
	ecvSd0hri/3Xfe0FKFTLvjJXXPnikaI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cqP0N9UF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Za0JBcT5V6vBaHOpl5CMFbXKhHQ2OBmbH88+gHAsx7k=;
	b=cqP0N9UF0MZ35HnkkcHzMaRnS+5/sHzf2S17k8Hq8CKs8ui3WZhQildJJvONwKZZJ56Os3
	4q7lzX7zX66CSl0SkaemJdohpfsyrwgO7tOZp0NzpDnL3CdPFvwuf8116Jbri27bt52jdD
	vfvNepk0Q8XQuxgo7OZ6rEUpS2m78Jg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E98793EA6D;
	Tue,  3 Mar 2026 14:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ADTLN8L1pmmPKQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 14:52:50 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv2 03/13] net: usb: centralize usbnet_cdc_zte_rx_fixup in usbnet
Date: Tue,  3 Mar 2026 15:50:23 +0100
Message-ID: <20260303145242.1377514-3-oneukum@suse.com>
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
X-Rspamd-Queue-Id: 265811F1D48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263248-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
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
index 906584cd71a4..8a9e0d98d9c6 100644
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


