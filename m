Return-Path: <netdev+bounces-307434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iy51AV4hVmqHzgAAu9opvQ
	(envelope-from <netdev+bounces-307434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:45:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63897754085
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:45:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=N854Dr6o;
	dkim=pass header.d=suse.com header.s=susede1 header.b=N854Dr6o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307434-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307434-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53F513044090
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD8738911E;
	Tue, 14 Jul 2026 11:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3E238399B
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:44:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029476; cv=none; b=ie+7VWG4yP72zpNLII021Mfn4iFqjrhDNJDBLs1OG71BFRoaRRUw+ypHtHKz4sHfK+yG6tIMGHxVavoJN8N7FmVXT2PdD+u9uP9ENx9N+DEql4VXblqHCLiCDgqM13pKkQJIg53dpVvXgphCVLSx0l9oe5LQnY0HVrY8Lu4X2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029476; c=relaxed/simple;
	bh=qkVecHnPWlWrvxbn1jGLFA7r3ztwnh+Ads2uXugq55w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECpJVcCtZEP3bODax2JC5FM3VuwxO+k4puj600ziZfo4wcW6mkPovNiQM0Af8MU0B+Sbgq/9IGY3GWGZxwuF7xDhbrTq6nPVnXDasnfpg4UJZ5vU048Jvq8Ez7FRMyJuWHU79dqtbMIFnNhKxkTAJ1UOjS7MyfBBVW41E3Ikjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N854Dr6o; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N854Dr6o; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47D1577E2D;
	Tue, 14 Jul 2026 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7SG94XJgSPoCBr54IEe+BPhmsgEhA3JqMHwvfzdzbg=;
	b=N854Dr6o2Yhyy1zvz+jutTIowJDzFloCqjrFekHuzhCVRaJYjGzKVmyxjNX+zhz7aw/yFZ
	MoR5c6kXSrOlY5E9YjrnJEILsTKlD/kpyRS2h47hyjzqZ3qas4UNRTSKszXaQWYIhkx00A
	dBnPpU2KcATat23URvoOcbLSe2OGSRM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7SG94XJgSPoCBr54IEe+BPhmsgEhA3JqMHwvfzdzbg=;
	b=N854Dr6o2Yhyy1zvz+jutTIowJDzFloCqjrFekHuzhCVRaJYjGzKVmyxjNX+zhz7aw/yFZ
	MoR5c6kXSrOlY5E9YjrnJEILsTKlD/kpyRS2h47hyjzqZ3qas4UNRTSKszXaQWYIhkx00A
	dBnPpU2KcATat23URvoOcbLSe2OGSRM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11776779AF;
	Tue, 14 Jul 2026 11:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gLIuAyAhVmp+cwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 14 Jul 2026 11:44:32 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	manuelebner@mailbox.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv3 net-next 2/9] net: usb: centralize usbnet_cdc_zte_rx_fixup in usbnet
Date: Tue, 14 Jul 2026 13:44:22 +0200
Message-ID: <20260714114429.1073434-2-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714114429.1073434-1-oneukum@suse.com>
References: <20260714114429.1073434-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307434-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:manuelebner@mailbox.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oneukum@suse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:from_mime,suse.com:mid,suse.com:email,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63897754085

This helper is used by multiple drivers using usbnet.
It is better to be provided by usbnet than one of them.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---

v2:
- spelling issues
- issue with lost synchronization with SPLIT packets

 drivers/net/usb/cdc_ether.c | 19 -------------------
 drivers/net/usb/usbnet.c    | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index b4df32e18461..e688fb99c61d 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -404,25 +404,6 @@ static int usbnet_cdc_zte_bind(struct usbnet *dev, struct usb_interface *intf)
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
index 21c55d70f27c..14e9f1b1e0a2 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -2350,6 +2350,25 @@ void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
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
2.54.0


