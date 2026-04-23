Return-Path: <netdev+bounces-280649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAGAJUnO6Wm9kgIAu9opvQ
	(envelope-from <netdev+bounces-280649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:46:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE4744E1F0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 835503027B5F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382530BF67;
	Thu, 23 Apr 2026 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="TRx9zNhB"
X-Original-To: netdev@vger.kernel.org
Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F5130C63A;
	Thu, 23 Apr 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930231; cv=none; b=kEnJT2ziC5s7G42AlnsIV8vw9KUj+rHloqWFCUxR2FFsbssjGPezD8cjjGFEa6jxv8EmWbrqNyhXVG8cUPtPxWfZkPDLpIxpwLNa3X8c2rK9SLs3NVZ6/O5p4og7ye6P2TH3OJ4EzD1zne5srw0zChZIgFVHttF2XHkGhurYPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930231; c=relaxed/simple;
	bh=P+vxiwOcKxAiKsT7+7OxCqfy8g+9CM/8eAsl7KYas3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtC9A6V+ykh4BNvtL9TG5EfQVlCX1HVzMBG3AJUlY6gjx8skHUC5jS368mHXfAVvO2YyaF9/eQuwcCA2hd1n9TJmnJ5vXO3yYQhg76JHKwK9ITHge24wWCgciz8HJB5zQSdtjrAKvY+8jYgTcG5nlXRtwH1tAff3AmO2bdVHlQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=TRx9zNhB; arc=none smtp.client-ip=178.154.239.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward206b.mail.yandex.net (Yandex) with ESMTPS id 0032A8156B;
	Thu, 23 Apr 2026 10:37:19 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2a2c:0:640:49cf:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id EB58EC00B2;
	Thu, 23 Apr 2026 10:37:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp) with ESMTPSA id 8bONsJ0R3qM0-eRRRhrMu;
	Thu, 23 Apr 2026 10:37:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1776929830; bh=wRLZkxFG2PlbFAjzQxBRAMljhGrOcvfkXIl4TIN3Ymg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=TRx9zNhBWGLCDmAKVOOq96F8N2Q0AbnwjFR1Bj6Pq91TULHcWn619p+tZzIWOygA9
	 9n7qEUbZrpefIJ7Iz7RlruH6lr3hyf/RBuKXXcsanjsa3xL4EcbaxoDBupa1g+xRTe
	 MiByypAX0uoAXGaJObFzJRvTQ1YHmssM/RjJLdW0=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [RFC PATCH] net: skb: on zero-copy formatted output to skb
Date: Thu, 23 Apr 2026 10:36:38 +0300
Message-ID: <20260423073638.778334-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yandex.ru];
	TAGGED_FROM(0.00)[bounces-280649-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmantipov@yandex.ru,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[yandex.ru:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AE4744E1F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some code, most notably the Bluetooth drivers, uses something like
the following:

char buf[80];
snprintf(buf, sizeof(buf), "Driver: %s\n", driver_name);
skb_put_data(skb, buf, strlen(buf));

This looks suboptimal at least because:

1) It yields in BUG() just in case the developer underestimates
   the size of an skb being used;
2) It requires extra data copy from an external buffer;
3) It uses 'strlen()' redundantly because actual data length
   is calculated by 'snprintf()' itself.

So introduce 'skb_printf()' which aims to address all of these
issues. As usual, thoughts and comments are highly appreciated.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b..fb4ef55a8f86 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4292,6 +4292,7 @@ int skb_mpls_update_lse(struct sk_buff *skb, __be32 mpls_lse);
 int skb_mpls_dec_ttl(struct sk_buff *skb);
 struct sk_buff *pskb_extract(struct sk_buff *skb, int off, int to_copy,
 			     gfp_t gfp);
+int skb_printf(struct sk_buff *skb, const char *fmt, ...);
 
 static inline int memcpy_from_msg(void *data, struct msghdr *msg, int len)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7dad68e3b518..051ab4f28c75 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6992,6 +6992,24 @@ struct sk_buff *pskb_extract(struct sk_buff *skb, int off,
 }
 EXPORT_SYMBOL(pskb_extract);
 
+int skb_printf(struct sk_buff *skb, const char *fmt, ...)
+{
+	int len, size = skb_availroom(skb);
+	va_list args;
+
+	va_start(args, fmt);
+	len = vsnprintf(skb_tail_pointer(skb), size, fmt, args);
+	va_end(args);
+
+	if (unlikely(len >= size))
+		return -ENOSPC;
+
+	skb->tail += len;
+	skb->len += len;
+	return len;
+}
+EXPORT_SYMBOL(skb_printf);
+
 /**
  * skb_condense - try to get rid of fragments/frag_list if possible
  * @skb: buffer
-- 
2.53.0


