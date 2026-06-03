Return-Path: <netdev+bounces-294571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f7U+CGPIH2p5pwAAu9opvQ
	(envelope-from <netdev+bounces-294571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:23:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736C36349F2
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:23:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="aD/Cw4Bs";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294571-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294571-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A76E30C4198
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7D43812E5;
	Wed,  3 Jun 2026 06:20:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9940D3F8891
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:20:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467655; cv=none; b=RRITM7qg7li5pBZWoL6A+DA5ALp1Fe7EHIVnQ2USXmoS2LJGnq28pA1z79rL1+hpU5bRLo1eaPNN7vTOoRcBEKtb+uzxuAQXccxJK7TgPmLHgtWLNjTL9ZlKp0rsCEoZOOCrVKwx7t6Eo8ulHrgA8SzF3Tv218GmEzht2oCiMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467655; c=relaxed/simple;
	bh=RADVh8HcVjmyHbmZM3nuptZ7x3MlyEdWAI2ZwGzLeUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TuSec4aCXZ08zWtTFmEtGhSpApvoxFh1RiH0+rMnxKZWy/+asgqWYyaCWEyw9taNxW3RctQYbA9YLF3+gc/DwALQ2tAGzneftUqZ2CDfj4Ta6xnjKlR58EmD6LVXzn7EMNvZXBejb5ADOF+4tP2mYNxe5AkHw9+2A+79f2EBYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aD/Cw4Bs; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8cceb0317b3so80681746d6.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780467649; x=1781072449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4+cQwYOPyCpNW2zSi/QmQ32R3UUJytr3cfOXw5A+Qg=;
        b=aD/Cw4BsVAF98ZJtWrQghxmBehuBZIiajyCY5S1zVWkXbt3rer38Stqh6H+b3ad0th
         I1mHqE3nK83iwOsYeEHwIhWjSNPqrieHAPHWvDtnmLM4gwiojBiPdqHg8//RlPrSWjNy
         nOAy42CW8/vgm0/x31DUsQpJ+Y8e9aQjmotDtxdLFvlo7s9aqzYnKAO0GgJYSczzhuD2
         nr6wzcPb98eNxD82b5oZ1UrBNPDip/jMxKuTQd1lRknKIXdAox2sn+0K9wDxMe5tfD+j
         a042OQoEldunfZP9JgRNSmPZ22C2knGW6FygI10Vlk3fBP8RwYg4xvNTQRXxGFGmuesA
         XLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467649; x=1781072449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4+cQwYOPyCpNW2zSi/QmQ32R3UUJytr3cfOXw5A+Qg=;
        b=A00mJqbOU7RXwHEZZefwZPCh5JbLVZRBT7nc80MlKEMGMsA19dQ6TNStVTKu9nDjIl
         n0YAN3XLmrVu1XlAjxQCgoWbPjqBz3DHagB/UMwH4PrkR1YkRKbZHhOl2xI1MbKSJFzj
         zsUFG1BuznWMldoFbEMiXiEpZjsZu7KUhoEE5e6Q+fNxpNydiug6NS+o7E9NNoQbEUac
         2ksYdQEBsflD8LPtYHIdJLA3MNX4yeG2u4i0LWNBIPaGP4PPVBd4y/Uzfss8GrvMTNim
         BQlfd2Vq7nbweKXu/FeG8WIfCQS1ZkMWRsVnpveaEu+tMSekn03v29ZlrHO1X1drL8ZT
         PyBw==
X-Forwarded-Encrypted: i=1; AFNElJ8zhAx0Ajy/T4DzPFsTKQ+rCU4XW5xFvJocpEqXHbSCGINUjQgJzRKh295X6Z6gWDtOx7jFUH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7wav+4hkwkFuJ1FE2Y7cFk/STF63G466lB6TFNRaIHzr6QTU
	3HHNJTQijIhGlzIVyd6bw4D4V0AXHHPRG4BDX/IC2U6XQB9upLqV/V6qzNIobTo6Dn8YqfCFcXZ
	++Je6ptlia1fU6w==
X-Received: from qvvu16.prod.google.com ([2002:a05:6214:11b0:b0:8ce:aa21:b13f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5be5:0:b0:8ce:9e58:838f with SMTP id 6a1803df08f44-8cece0296ffmr25185896d6.33.1780467648478;
 Tue, 02 Jun 2026 23:20:48 -0700 (PDT)
Date: Wed,  3 Jun 2026 06:20:34 +0000
In-Reply-To: <20260603062043.3911278-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603062043.3911278-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603062043.3911278-3-edumazet@google.com>
Subject: [PATCH v2 net-next 02/11] bridge: add bridge_flags_bit enum
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294571-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 736C36349F2

We want to use atomic operations for lockless p->flags changes
and reads.

Add definitions for bits in addition of masks so that we can use
test_bit(), clear_bit() and set_bit() in subsequent patches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 include/linux/if_bridge.h | 78 ++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index ec9ffea1e46ede3762f108f6e7085ebb1bf1d2e1..75673b8bffcb8ad6396e6a05b8af8150208fb6fe 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -36,32 +36,60 @@ struct br_ip_list {
 	struct br_ip addr;
 };
 
-#define BR_HAIRPIN_MODE		BIT(0)
-#define BR_BPDU_GUARD		BIT(1)
-#define BR_ROOT_BLOCK		BIT(2)
-#define BR_MULTICAST_FAST_LEAVE	BIT(3)
-#define BR_ADMIN_COST		BIT(4)
-#define BR_LEARNING		BIT(5)
-#define BR_FLOOD		BIT(6)
+enum bridge_flags_bit {
+	BR_HAIRPIN_MODE_BIT,
+	BR_BPDU_GUARD_BIT,
+	BR_ROOT_BLOCK_BIT,
+	BR_MULTICAST_FAST_LEAVE_BIT,
+	BR_ADMIN_COST_BIT,
+	BR_LEARNING_BIT,
+	BR_FLOOD_BIT,
+	BR_PROMISC_BIT,
+	BR_PROXYARP_BIT,
+	BR_LEARNING_SYNC_BIT,
+	BR_PROXYARP_WIFI_BIT,
+	BR_MCAST_FLOOD_BIT,
+	BR_MULTICAST_TO_UNICAST_BIT,
+	BR_VLAN_TUNNEL_BIT,
+	BR_BCAST_FLOOD_BIT,
+	BR_NEIGH_SUPPRESS_BIT,
+	BR_ISOLATED_BIT,
+	BR_MRP_AWARE_BIT,
+	BR_MRP_LOST_CONT_BIT,
+	BR_MRP_LOST_IN_CONT_BIT,
+	BR_TX_FWD_OFFLOAD_BIT,
+	BR_PORT_LOCKED_BIT,
+	BR_PORT_MAB_BIT,
+	BR_NEIGH_VLAN_SUPPRESS_BIT,
+	BR_NEIGH_FORWARD_GRAT_BIT,
+};
+
+#define BR_HAIRPIN_MODE		BIT(BR_HAIRPIN_MODE_BIT)
+#define BR_BPDU_GUARD		BIT(BR_BPDU_GUARD_BIT)
+#define BR_ROOT_BLOCK		BIT(BR_ROOT_BLOCK_BIT)
+#define BR_MULTICAST_FAST_LEAVE	BIT(BR_MULTICAST_FAST_LEAVE_BIT)
+#define BR_ADMIN_COST		BIT(BR_ADMIN_COST_BIT)
+#define BR_LEARNING		BIT(BR_LEARNING_BIT)
+#define BR_FLOOD		BIT(BR_FLOOD_BIT)
 #define BR_AUTO_MASK		(BR_FLOOD | BR_LEARNING)
-#define BR_PROMISC		BIT(7)
-#define BR_PROXYARP		BIT(8)
-#define BR_LEARNING_SYNC	BIT(9)
-#define BR_PROXYARP_WIFI	BIT(10)
-#define BR_MCAST_FLOOD		BIT(11)
-#define BR_MULTICAST_TO_UNICAST	BIT(12)
-#define BR_VLAN_TUNNEL		BIT(13)
-#define BR_BCAST_FLOOD		BIT(14)
-#define BR_NEIGH_SUPPRESS	BIT(15)
-#define BR_ISOLATED		BIT(16)
-#define BR_MRP_AWARE		BIT(17)
-#define BR_MRP_LOST_CONT	BIT(18)
-#define BR_MRP_LOST_IN_CONT	BIT(19)
-#define BR_TX_FWD_OFFLOAD	BIT(20)
-#define BR_PORT_LOCKED		BIT(21)
-#define BR_PORT_MAB		BIT(22)
-#define BR_NEIGH_VLAN_SUPPRESS	BIT(23)
-#define BR_NEIGH_FORWARD_GRAT	BIT(24)
+#define BR_PROMISC		BIT(BR_PROMISC_BIT)
+#define BR_PROXYARP		BIT(BR_PROXYARP_BIT)
+#define BR_LEARNING_SYNC	BIT(BR_LEARNING_SYNC_BIT)
+#define BR_PROXYARP_WIFI	BIT(BR_PROXYARP_WIFI_BIT)
+#define BR_MCAST_FLOOD		BIT(BR_MCAST_FLOOD_BIT)
+#define BR_MULTICAST_TO_UNICAST	BIT(BR_MULTICAST_TO_UNICAST_BIT)
+#define BR_VLAN_TUNNEL		BIT(BR_VLAN_TUNNEL_BIT)
+#define BR_BCAST_FLOOD		BIT(BR_BCAST_FLOOD_BIT)
+#define BR_NEIGH_SUPPRESS	BIT(BR_NEIGH_SUPPRESS_BIT)
+#define BR_ISOLATED		BIT(BR_ISOLATED_BIT)
+#define BR_MRP_AWARE		BIT(BR_MRP_AWARE_BIT)
+#define BR_MRP_LOST_CONT	BIT(BR_MRP_LOST_CONT_BIT)
+#define BR_MRP_LOST_IN_CONT	BIT(BR_MRP_LOST_IN_CONT_BIT)
+#define BR_TX_FWD_OFFLOAD	BIT(BR_TX_FWD_OFFLOAD_BIT)
+#define BR_PORT_LOCKED		BIT(BR_PORT_LOCKED_BIT)
+#define BR_PORT_MAB		BIT(BR_PORT_MAB_BIT)
+#define BR_NEIGH_VLAN_SUPPRESS	BIT(BR_NEIGH_VLAN_SUPPRESS_BIT)
+#define BR_NEIGH_FORWARD_GRAT	BIT(BR_NEIGH_FORWARD_GRAT_BIT)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
-- 
2.54.0.1013.g208068f2d8-goog


