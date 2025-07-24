Return-Path: <netdev+bounces-209753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B518B10B38
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5134C3AF578
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068462D781A;
	Thu, 24 Jul 2025 13:19:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770282D641F
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363154; cv=none; b=iPHB665Mvyb5DTgcm3mmLbaDguzn0rWPhtCgMztHqbpeRrSkBOuSmYu4tOhjoX10O9nsRPMcfJlGWx2nsCZtxLgbCvwgJpiHBYWS7yf7mM0KsAUEvujBdrNlj7WFWSaeAX74dhMpbCSKuLp6ocYp06z1ivfQApmUHsZyAym80Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363154; c=relaxed/simple;
	bh=sVF3PskIaqMM40MJxlrFCOv/lJnVkhMJTY2xR+4eF0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOx+F9XnvFHIS9qL23t4lH4DwwXMO36jDFxgp1yWjT6VVM8/KdoW+2RkpjNMsotLogVlj3g0GlZR+oCfBSwaPVhrNbNIcS/e3mP5aQfgHSfNQM/Gb+jpIDD5hFBUMtiX3Hs/HG3XdZk8CCF32vPAS0PVTnmR+WiC5egzBkenwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [31.130.238.14] (helo=alea.q.nox.tf)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1uevqp-00000002yTS-2Tzt;
	Thu, 24 Jul 2025 15:19:11 +0200
Received: from equinox by alea.q.nox.tf with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1uevqR-000000008NQ-0JIR;
	Thu, 24 Jul 2025 15:18:47 +0200
From: David Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Lamparter <equinox@diac24.net>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>
Subject: [PATCH net-next 4/4] net/ipv6: drop ip6_route_get_saddr
Date: Thu, 24 Jul 2025 15:18:25 +0200
Message-ID: <20250724131828.32155-5-equinox@diac24.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724131828.32155-1-equinox@diac24.net>
References: <20250724131828.32155-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's no longer used anywhere.

Signed-off-by: David Lamparter <equinox@diac24.net>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Patrick Rohr <prohr@google.com>
---
 include/net/ip6_route.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 9255f21818ee..6c52cabedbf6 100644
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
2.47.2


