Return-Path: <netdev+bounces-205302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C333CAFE2A5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18191C427F8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6282750EE;
	Wed,  9 Jul 2025 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="UA4mo3FY"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01323B63A
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049889; cv=none; b=kKuBnGTKwpztRHr6Eq/3vpGMLttvhECZkqQRv453mCmQHB2nnRqkUldHgKl6IcJdIMCqZ2i0FalJmAjP4+ItiLnO9BFkxR6u/oTFdUB9a4uxkl7oFZAojHas4AuGZv0eSUylJ2sXV6b9IVxFo8+GbmHd3tGvJ78347yYgUX9viI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049889; c=relaxed/simple;
	bh=BwFVz8vh7CbOYdMIh8YPUON/uj//ZtzyjkLecdsriu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=guXtXi/ZT+wYoQYzJdZTV51cnqv184Mvh3MmUTJr2YAjdzL108KvQ7VW3ZtO4DC69D4t1GpeMWOsb6U5iAYt29/atyhnJRaOFBSWNsbTTcDNFgvamZw1cZjRJaVl184lsMYiNHjFfBD33ZPN9DYAniQY+8Uz3o7zOd2nZPNcPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=UA4mo3FY; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752049879;
	bh=vYP0t9l8jlLdy4sXCnodhmCI+4WfH27HFLOTTZMrmZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UA4mo3FY7kzfkFzfRrDKdv/PXr2CTq83G6PXb9H1wcKNhQORfsg2RfzsuCSXH+ivN
	 7D2f9gf4d1r/SBPz4L75UryNVMqoKZgTh1mALyjwyiXOcKeCJXS8n5AxqYhMTczzV6
	 lHYxFM52i5+ULc6FNP0xe9mTWhiP/b1u9Gx5J4Jj9ZomaexAZuKOcx/m+gOmqJvexx
	 x0/VRHUlNITcejFj0x6SrWr+qWHvLKDxhFzfMk/gDqJZ//DGjDsCh/2sGKatrSjH+Z
	 ynjHlPr40ZZ6HO23Faz5vhkA3WDhgSbdCpeVR6S7zT2Pgu4wYI1hSJuL6vQBp+qSuf
	 rtuF8NiJ8gscQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id AB3006B15D; Wed,  9 Jul 2025 16:31:19 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Wed, 09 Jul 2025 16:31:02 +0800
Subject: [PATCH net-next v3 1/8] net: mctp: mctp_test_route_extaddr_input
 cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-mctp-bind-v3-1-eac98bbf5e95@codeconstruct.com.au>
References: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
In-Reply-To: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752049878; l=1495;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=BwFVz8vh7CbOYdMIh8YPUON/uj//ZtzyjkLecdsriu0=;
 b=lGXvvaxTNDN9CliBletpZ2dlN77QEG8yKbGIVV5fOmuumfKlIYnnm7vj1sGS/bDnCtJ2ZYwDq
 v4j49m3iamkCOLtTDiFzSCPPoiBQjZ4kwKJYTNXU25FzbAPMTL6J15o
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

The sock was not being released. Other than leaking, the stale socket
will conflict with subsequent bind() calls in unrelated MCTP tests.

Fixes: 11b67f6f22d6 ("net: mctp: test: Add extaddr routing output test")
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

---
Added in v3. The problem was introduced in current net-next so
this patch isn't needed in the stable tree.
---
 net/mctp/test/route-test.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 7a398f41b6216afef72adecf118199753ed1bfea..12811032a2696167b4f319cbc9c81fef4cb2d951 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -1164,8 +1164,6 @@ static void mctp_test_route_extaddr_input(struct kunit *test)
 	rc = mctp_dst_input(&dst, skb);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
-	mctp_test_dst_release(&dst, &tpq);
-
 	skb2 = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb2);
 	KUNIT_ASSERT_EQ(test, skb2->len, len);
@@ -1179,8 +1177,8 @@ static void mctp_test_route_extaddr_input(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, cb2->halen, sizeof(haddr));
 	KUNIT_EXPECT_MEMEQ(test, cb2->haddr, haddr, sizeof(haddr));
 
-	skb_free_datagram(sock->sk, skb2);
-	mctp_test_destroy_dev(dev);
+	kfree_skb(skb2);
+	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
 }
 
 static void mctp_test_route_gw_lookup(struct kunit *test)

-- 
2.43.0


