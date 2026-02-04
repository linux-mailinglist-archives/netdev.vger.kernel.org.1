Return-Path: <netdev+bounces-256735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CcsgH6Jmg2ntmQMAu9opvQ
	(envelope-from <netdev+bounces-256735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:32:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F139AE8D3F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97D92306EECA
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BC2421EE7;
	Wed,  4 Feb 2026 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYi7SXQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1972423A83
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218411; cv=none; b=BVV7vmvnjQa4jRjNkO6xItE8eR1Rl9qOSHP19S+q4OV6FerWIuHjzZNSqEkRJcLtLfYRUZvL3tVcBe0eYeU82SVR09gbwRVR//RVVlin3sykd6aSlZ2MtjUMhX+fp5A3fD7TxJPv23V08WUwvOyb8m+g3Bl84T76PeSrVM0R3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218411; c=relaxed/simple;
	bh=O7q+/ocoPKxpBqhj5gve6uGx9W66E5Yd2InVodGU6/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J0hsv2A7mFAidg5Bdl2VVndu8NQTX4QBPQfQHHEhcZqp8lz9lE49/sbc5RWjZY5lhz7ZRaH5fT1UWoQL+cucAvV4M3zC/pVZg2lr4mQ/S1CNdYiPtAW4NPfWZbAqZ5LIOAR9Mh+IBNZGp3o441xd+wOl9ZqNhEwehl2n/3Yam7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYi7SXQ9; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c710439535so553076685a.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 07:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770218410; x=1770823210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoAu+Vz+Fjbs8dvMYtpoxIVXzmZB3ySWB8LK5IhrZLo=;
        b=KYi7SXQ9vkSuw4xbn4zoHf2klW9tG2eiHr3cEZ1MhI8BwzzHMkxaOPCyf3fSPUHzSr
         dPyjGY7Tl7vhjz3YL5Qp42JIhgNd2IqFWPK0acCCF994tlxy3AZvwxNFv6TmOClSewED
         CRMlXJodAoY9Cw+MB8OHvyGYLqnFEPEBbw4wrrOMhF6Yjg9IcBkiiIBZMWvnMTL9RsZD
         ye8bQx3ACHdAIKJCmAvgIRYOJ3G6cMrKokJcEnD/yDkBWDmzniXGCYfuqYJXaakwgFxz
         tys+1euKmwRag02ZhBEhgUZjI6AtJ863ma6Mc351/5IUMTX+sTyRsNeHQg0+S5qgDqOz
         bQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770218410; x=1770823210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EoAu+Vz+Fjbs8dvMYtpoxIVXzmZB3ySWB8LK5IhrZLo=;
        b=WGGDQjOyty47oqnvdhZ404KMthR9gwPAoxywNseGVYL4xPfWqD3J7vo68JdKzOfKje
         LhwEXYBxadaTo8hIIU6zdUOSW3INMiYYEkNPtcdUI5P3Smcv1C46CAGv0vvG2sivRp1x
         Xi2ki4NhyFFa38IcBe4w4dDlaTuhW+0vkbAfoakViOTIi3DfEupGCTRYVX5IsD5YbZBI
         Lg2frUlWnlQyC+LPepQTvWhp7v18bCHOxrKimsZHsNdjNTAGSpF1DNOYkFzPPOGSIbFL
         16XDV7/qeeQa8uvCor9q7XP1an312UnkB9xopAZqUDQljHEcfqeu7sjsLfOn+uhIl2jP
         VRTg==
X-Gm-Message-State: AOJu0YyjIxXreWg3H3fmm+b1lIuZMS5G9S6vmJQB6L7ihDb0zGsx1ei8
	bSoIrFo0i4RIV0RdHhqVdGWzzWBlJ2m+GPswscyWjIc+4gDlxvy6bC3h
X-Gm-Gg: AZuq6aKhA3nL4aZ+2sHrPiq4jxBHMkCx6D/LxAgNrLuNR29kH1+sC+Npk4PdvPEGzJH
	eaUdVJkKA+1+KDn2aGc+2pRU/IA5i5FFqZe2hWvIaUP4umTUUMglNDS7FgyS192gU2Eq5u7u0yX
	M/WRyreWj9SjPtQH5V7x98ES0yawHMKbdi8lu4p+0JRBsqS14hlH/Y72LII/+IvbqVulrpDr8Vg
	4X0+mwtsBaf2yyPCKaPYFuf1LFk3amXSEv3QUPRfos1e4yJEChl4ife4ARhRUPg/mB3ss0IhW5B
	gGpdpt3vIcqWV6xm09JAr97XiN0xLIanwrXccC/1eKIif1duuOHCS12QIzB+DziDg+IMh7C9nk0
	E2owDlNHzPCPA8whp+YDKW2NdSrX6jjl5bwQZP0laDuR5N/XQx0O9pYafr1msfsaAMtLamnBaH/
	fvmp91KXCM
X-Received: by 2002:a05:620a:3720:b0:8c6:e0c5:7bc0 with SMTP id af79cd13be357-8ca2f85d142mr416777885a.36.1770218410430;
        Wed, 04 Feb 2026 07:20:10 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:51::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc4b861csm2599617d50.7.2026.02.04.07.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:20:09 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 04 Feb 2026 07:20:06 -0800
Subject: [PATCH net-next 2/9] psp: move code from psp_sock_assoc_set_tx()
 into helper functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-psp-v1-2-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
In-Reply-To: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256735-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F139AE8D3F
X-Rspamd-Action: no action

This commit is a pure refactor. Its purpose is to lift code that needs
to be called from both initial tx establishment and tx rekeying into
dedicated functions.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/psp/psp_sock.c | 94 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 36 deletions(-)

diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index 3a8abd023f99..9b0ecce8350f 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -187,12 +187,67 @@ static int psp_sock_recv_queue_check(struct sock *sk, struct psp_assoc *pas)
 	return 0;
 }
 
+static int
+psp_pas_set_tx_key(struct psp_dev *psd, struct psp_assoc *pas,
+		   struct psp_key_parsed *key, struct netlink_ext_ack *extack)
+{
+	struct psp_assoc *dummy;
+	int rc;
+
+	/* Pass a fake association to drivers to make sure they don't
+	 * try to store pointers to it. For re-keying we'll need to
+	 * re-allocate the assoc structures.
+	 */
+	dummy = psp_assoc_dummy(pas);
+	if (!dummy)
+		return -ENOMEM;
+
+	memcpy(&dummy->tx, key, sizeof(*key));
+	rc = psp_dev_tx_key_add(psd, dummy, extack);
+	if (rc)
+		goto exit_free_dummy;
+
+	memcpy(pas->drv_data, dummy->drv_data, psd->caps->assoc_drv_spc);
+	memcpy(&pas->tx, key, sizeof(*key));
+
+exit_free_dummy:
+	kfree(dummy);
+	return rc;
+}
+
+static int
+psp_sock_set_tx_key(struct sock *sk, struct psp_dev *psd, struct psp_assoc *pas,
+		    struct psp_key_parsed *key, struct netlink_ext_ack *extack)
+{
+	struct inet_connection_sock *icsk;
+	int err;
+
+	err = psp_sock_recv_queue_check(sk, pas);
+	if (err) {
+		NL_SET_ERR_MSG(extack, "Socket has incompatible segments already in the recv queue");
+		return err;
+	}
+
+	err = psp_pas_set_tx_key(psd, pas, key, extack);
+	if (err)
+		return err;
+
+	WRITE_ONCE(sk->sk_validate_xmit_skb, psp_validate_xmit);
+	tcp_write_collapse_fence(sk);
+	pas->upgrade_seq = tcp_sk(sk)->rcv_nxt;
+
+	icsk = inet_csk(sk);
+	icsk->icsk_ext_hdr_len += psp_sk_overhead(sk);
+	icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
+
+	return err;
+}
+
 int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 			  u32 version, struct psp_key_parsed *key,
 			  struct netlink_ext_ack *extack)
 {
-	struct inet_connection_sock *icsk;
-	struct psp_assoc *pas, *dummy;
+	struct psp_assoc *pas;
 	int err;
 
 	lock_sock(sk);
@@ -220,40 +275,7 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 		goto exit_unlock;
 	}
 
-	err = psp_sock_recv_queue_check(sk, pas);
-	if (err) {
-		NL_SET_ERR_MSG(extack, "Socket has incompatible segments already in the recv queue");
-		goto exit_unlock;
-	}
-
-	/* Pass a fake association to drivers to make sure they don't
-	 * try to store pointers to it. For re-keying we'll need to
-	 * re-allocate the assoc structures.
-	 */
-	dummy = psp_assoc_dummy(pas);
-	if (!dummy) {
-		err = -ENOMEM;
-		goto exit_unlock;
-	}
-
-	memcpy(&dummy->tx, key, sizeof(*key));
-	err = psp_dev_tx_key_add(psd, dummy, extack);
-	if (err)
-		goto exit_free_dummy;
-
-	memcpy(pas->drv_data, dummy->drv_data, psd->caps->assoc_drv_spc);
-	memcpy(&pas->tx, key, sizeof(*key));
-
-	WRITE_ONCE(sk->sk_validate_xmit_skb, psp_validate_xmit);
-	tcp_write_collapse_fence(sk);
-	pas->upgrade_seq = tcp_sk(sk)->rcv_nxt;
-
-	icsk = inet_csk(sk);
-	icsk->icsk_ext_hdr_len += psp_sk_overhead(sk);
-	icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
-
-exit_free_dummy:
-	kfree(dummy);
+	err = psp_sock_set_tx_key(sk, psd, pas, key, extack);
 exit_unlock:
 	release_sock(sk);
 	return err;

-- 
2.47.3


