Return-Path: <netdev+bounces-235507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF305C31A38
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8B918C0514
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7610A329E7B;
	Tue,  4 Nov 2025 14:51:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9B32ED42
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267871; cv=none; b=pByCW/60di8rxI1MRoyZQFB5NiEgN9tPckpvhNALURzF0x7M0zcZBSe7hyzl3QXlwxjqHfzk2kGMBPfZ434DIVkswn9OehDuWo7mRRC8aKgcjn2Kllm27B02zyOe3YmIeCfgSYSyM10L59zPrX+YhlxucUid0J4pYokvWrIekvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267871; c=relaxed/simple;
	bh=vSsU8R6+JJQC3xq1SqnIBwsMsiR3D6O+gz/JCD15/kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhmeQmDGzTTS+7t8mK4e6hLtBFL6WrFreMRUqg+ce0MSDsm4yza9/WgOO27oG0QPqGu5ufvyMzLZZYujMA1fOE6jUdfHJyUi35g/5D9BYqowJtX0Q0x7NoGM8EGsE5KnpANW3DwzBEqbI9ZThyNWhlBNR3lMqkvaxZTFK4R9JPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from rtr-guestwired.meeting.ietf.org ([31.133.144.1] helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1vGILE-000000009AI-0D2W;
	Tue, 04 Nov 2025 15:49:00 +0100
Received: from equinox by alea with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1vGIKo-0000000057e-37qV;
	Tue, 04 Nov 2025 09:48:34 -0500
From: David Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: David Lamparter <equinox@diac24.net>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>
Subject: [RESEND PATCH net-next v2 4/4] net/ipv6: drop ip6_route_get_saddr
Date: Tue,  4 Nov 2025 09:48:22 -0500
Message-ID: <20251104144824.19648-5-equinox@diac24.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251104144824.19648-1-equinox@diac24.net>
References: <20251104144824.19648-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's no longer used anywhere.

Signed-off-by: David Lamparter <equinox@diac24.net>
---
 include/net/ip6_route.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 7c5512baa4b2..3b64c30fd882 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -125,32 +125,6 @@ void rt6_flush_exceptions(struct fib6_info *f6i);
 void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
 			unsigned long now);
 
-static inline int ip6_route_get_saddr(struct net *net, struct fib6_info *f6i,
-				      const struct in6_addr *daddr,
-				      unsigned int prefs, int l3mdev_index,
-				      struct in6_addr *saddr)
-{
-	struct net_device *l3mdev;
-	struct net_device *dev;
-	bool same_vrf;
-	int err = 0;
-
-	rcu_read_lock();
-
-	l3mdev = dev_get_by_index_rcu(net, l3mdev_index);
-	if (!f6i || !f6i->fib6_prefsrc.plen || l3mdev)
-		dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
-	same_vrf = !l3mdev || l3mdev_master_dev_rcu(dev) == l3mdev;
-	if (f6i && f6i->fib6_prefsrc.plen && same_vrf)
-		*saddr = f6i->fib6_prefsrc.addr;
-	else
-		err = ipv6_dev_get_saddr(net, same_vrf ? dev : l3mdev, daddr, prefs, saddr);
-
-	rcu_read_unlock();
-
-	return err;
-}
-
 struct rt6_info *rt6_lookup(struct net *net, const struct in6_addr *daddr,
 			    const struct in6_addr *saddr, int oif,
 			    const struct sk_buff *skb, int flags);
-- 
2.50.1


