Return-Path: <netdev+bounces-296634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Efv9J/HhJmpQmQIAu9opvQ
	(envelope-from <netdev+bounces-296634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:38:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C73C6582D8
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:38:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openvpn.net header.s=google header.b="VYtil/0R";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296634-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296634-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=openvpn.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E48230CCF09
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9EB3CCA12;
	Mon,  8 Jun 2026 15:08:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62913C7E1D
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:08:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931285; cv=none; b=jDf8tEHKkATehdiRtEeeO4/Nlvi2ynRzPotN+tfopJ2mfFFVxhK1QwCo+qVvO6fPDPth8aAEZSSOKCsGR0s0kjGMaAdqqgNzPvX63rYTm4mMjrHgGS09Z6fJedzbJw5giz59dBbXXWzBjjuBtac8osNn+DnucJFET3oQxO4u16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931285; c=relaxed/simple;
	bh=TME3hBeO2sV19LuopQPAXfkUqb6J+OT/a/RHnD0Yo58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nl6Ya2XVYZdTNmtUPSbxSuKpc0SRPemdmPP8KDO3nxs/qblls2A+MN6u+R7/zasex0ZGQhCRvlYQ/tKgV6+pwKoWAPobHgltxnlRRGc2HBr/J9KaaCqNwqJsHkpJi54CJQscUeIfS59xsElGTbF9z0dFeeZmsTWf5rz9uBoDYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VYtil/0R; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b12270b3so26755075e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1780931282; x=1781536082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ARGB/fd7lJFaxUybSqs1NUj8RsjUxwRDSARI5MDr3Y=;
        b=VYtil/0R3QaaEJc8YgivjYybqKPiyWqCBuPmWNZtfq+zxKxp/3zxiBYZyFnHJLnrKB
         SUppJszYCFH5oZfmOZIUvq7SYju7BSfVrFkrtltOOAFe9YmGhvK3J+LLTMHaJRoq9Gja
         Kpv0oXZs+9ce/g2u2z0fwXx1FL0mt2lGSJ+63EGntGwduLR4jxoY/XCx6UsZf0kUUoFo
         mnydRmI4gADq3pXTo0rs3/qdzDHHglwFX4ERBHWXZD4riEmGKY29geSUyIkWyThmhHiu
         BqyFdNqtlUfaaJ0IdsGV+PQgq2Mpt0aSOzWV0fPtf3CrfWunFpW8eZgCl+WrByfXVA2W
         S02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931282; x=1781536082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ARGB/fd7lJFaxUybSqs1NUj8RsjUxwRDSARI5MDr3Y=;
        b=oCdkVB6sDy6x7a5NhJEnXB1w/9etrrywqW2+WmWIsNDVmi/mnL5vwCSR1nDhShKS5I
         lDUtmNn6/7slCYhidim31E93WJr6AuHtejmAndQKtICv8bkUR7sBq/nxmcm2n3lUmlv7
         YCTUifL4R3qS3Hg2ocSOS8jeKQ4N4EyoIVl5POjN6vMBZDAwRmIgitk3ym6G2syZV9gD
         Q+DFaA8JXyYtVA+x+9dKF5p+v3ownW8+1CDTsxMmL3cmkBrIuf9EeRVcSz4tSvdK+Phe
         DZAU6H6n6exIm0QnQ/eUtiXILGsohIFiKoE+NqAqQLxeRzsUFzWO70ksWjjhCQUOBOBu
         BeKQ==
X-Gm-Message-State: AOJu0YyAXGDJAVc/x5bPXNj4pNhykUzta0lBJQWfQgokbEneekHLb1Zt
	jk9165D1yV0sdqxcH4k5TAS2AIIYgjFtcqgHLZ0/KjI7bbJMa+OjfuwdOf7qcz8BNDrOXE91Hr5
	zofaeZ6beTqNgkakOfH92UFF2sGrtaj+FiNhucNXxHKLGLYbavTQcTKU80sAEh7VmcGs=
X-Gm-Gg: Acq92OHxPGYJpem0ZZkqBnbpzyMlu1ujgvxPJKTokV34pXiVsIcr01wMwBY/PK+BaUL
	uWDN8NESHsF+pM9nvhfQBqL9heZAgTaz7IE0LgWXyrI64kh0yk/LukNCPxRJ8KeVYXcouX/FgJi
	HA5cmuTNf0l07mUt0uCpR9S0Vsg2x4h6m4PKjcGyAJvsVC/sJ3qcr6HjXDPhHOUrzslPdYpZjgv
	c0nC8+Q4tDKsE8e6hSCmOA31wp74wclFc40rfV0wDHF3y944sGo1f9YxZDuEgWh4liWFCNTBoOh
	2P8QJSGrkqEqtF9qRRyY23uI2dE4wpkPaVxtXi1tbWgS+oXmVChuBjiLtuXKeU2PShFz2uZZMmo
	LKYD8ik6YEVrBOfRKKNtGFON9RVYGG67njSX9RwI9MuNw4RTiSoFOIaQKu3UuwXmUf6lQok0kAA
	MemUmm4FVy5NdLaDNRQS2waXI719fpHHeaamAEj0JsfRBaUJkX5tHkMU1iFA==
X-Received: by 2002:a05:600d:8653:10b0:490:d079:2919 with SMTP id 5b1f17b1804b1-490d0792a47mr36956875e9.14.1780931282036;
        Mon, 08 Jun 2026 08:08:02 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:7e36:aaf2:5280:7b3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm390659705e9.5.2026.06.08.08.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:08:01 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Marco Baffo <marco@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 6/6] ovpn: use monotonic clock for peer keepalive timeouts
Date: Mon,  8 Jun 2026 17:07:37 +0200
Message-ID: <20260608150741.3320919-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608150741.3320919-1-antonio@openvpn.net>
References: <20260608150741.3320919-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296634-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:marco@mandelbit.com,m:sd@queasysnail.net,m:ralf@mandelbit.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:antonio@openvpn.net,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,keepalive_work.work:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C73C6582D8

From: Marco Baffo <marco@mandelbit.com>

Replace ktime_get_real_seconds() with the monotonic ktime_get_boottime_seconds()
to ensure the keepalive mechanism is robust against system clock modifications.

Right now, the driver uses ktime_get_real_seconds() to track peer timeouts,
relying on the system wall-clock.

An administrative time adjustment or an NTP sync that steps the clock forward
can cause `now' to instantly exceed `last_recv + timeout'.

When this occurs, the driver artificially expires healthy peers. Depending on
the OpenVPN user-space configuration, this triggers a premature tunnel restart
(if --keepalive or --ping-restart is used) or a complete disconnection of the
client (if --ping-exit is used).

Fixes: 3ecfd9349f40 ("ovpn: implement keepalive mechanism")
Signed-off-by: Marco Baffo <marco@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   | 4 ++--
 drivers/net/ovpn/peer.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index a6b777a9c2d9..9a66d693039a 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -142,7 +142,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	}
 
 	/* keep track of last received authenticated packet for keepalive */
-	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
+	WRITE_ONCE(peer->last_recv, ktime_get_boottime_seconds());
 
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
@@ -294,7 +294,7 @@ void ovpn_encrypt_post(void *data, int ret)
 
 	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
 	/* keep track of last sent packet for keepalive */
-	WRITE_ONCE(peer->last_sent, ktime_get_real_seconds());
+	WRITE_ONCE(peer->last_sent, ktime_get_boottime_seconds());
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err_unlock:
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 8fdbb5050690..a21d02ac715e 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -45,7 +45,7 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
  */
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
 {
-	time64_t now = ktime_get_real_seconds();
+	time64_t now = ktime_get_boottime_seconds();
 
 	netdev_dbg(peer->ovpn->dev,
 		   "scheduling keepalive for peer %u: interval=%u timeout=%u\n",
@@ -1359,7 +1359,7 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
 {
 	struct ovpn_priv *ovpn = container_of(work, struct ovpn_priv,
 					      keepalive_work.work);
-	time64_t next_run = 0, now = ktime_get_real_seconds();
+	time64_t next_run = 0, now = ktime_get_boottime_seconds();
 	LLIST_HEAD(release_list);
 
 	spin_lock_bh(&ovpn->lock);
-- 
2.53.0


