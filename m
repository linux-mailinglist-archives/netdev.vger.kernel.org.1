Return-Path: <netdev+bounces-118457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27544951AE5
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F981F23387
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 12:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511D515C9;
	Wed, 14 Aug 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nilsfuhler.de header.i=@nilsfuhler.de header.b="Y+aNAJRp"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162DE1109;
	Wed, 14 Aug 2024 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638715; cv=none; b=fBrTNPxzzzbQ4Vdrajc5phW5AG8J0RD5EPug3hN/91x39yBZR98AYSoSYfOj+7GD6+oTdwkQjmV3yKrotTYM4eqy4vkrEbOmnI1QYM9eoD4ZcYcU7V+4qMac0VHV3F4DDsA4Zozlvd1+hk9sNHeV1kGFwo5POBvJ4/Es/RXZMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638715; c=relaxed/simple;
	bh=Ua5nAcxp6Xb6AyQthGzIxbqt/XHREtinCmdqANSz7a0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jn6O4/pGY/BXanbYS4zl676P7hyOgdMCuuqBfAykxhhgbWZveU5zbE1FYCyzryYZHG88Z7TbWzYUMl0GDmMzM3O40EHwPg8JWL7mryjFpsUJ68obJ+LIJ3qsLaQrMmeJ7Tx07QNB5tKIY2HZ50cMFw8c0iryw4AyVffQmDWbySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nilsfuhler.de; spf=pass smtp.mailfrom=nilsfuhler.de; dkim=pass (2048-bit key) header.d=nilsfuhler.de header.i=@nilsfuhler.de header.b=Y+aNAJRp; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nilsfuhler.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nilsfuhler.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WkSL55Tcwz9sc4;
	Wed, 14 Aug 2024 14:31:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nilsfuhler.de;
	s=202311; t=1723638696;
	bh=Ua5nAcxp6Xb6AyQthGzIxbqt/XHREtinCmdqANSz7a0=;
	h=From:To:Cc:Subject:Date:From;
	b=Y+aNAJRpjL658YyhdhfAIKsU/daD4+TBqlCe1ssuv3pVmtWCN+Flw9Kch+vTxChBT
	 F/7G5iQa1qq4lI2eouZISFyMn2uI9tKFdlqXjxqz+zsmVU963DxENnn3TJTLh0lmB3
	 jEFmDJFzp108j/QnEAzb3ufj+w+lZbVNiPbiUdaWgMrPNPRjDSxz11+wG48HelxBQ5
	 Xb9jXICDWSUKeeaU5d3he6/v0KWxbV+vXwOj+rXqEIMtZbhaOtTpgcsFXQJXfOp27h
	 b0ae7azI/0A7Mb3eTvrMDp3z2c3M4S1JUkwK+aBG5HbSmTwdWnJBooM8SsZdJn6xCO
	 39ldc9U4+LPjQ==
From: Nils Fuhler <nils@nilsfuhler.de>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nils Fuhler <nils@nilsfuhler.de>
Subject: [PATCH] net: ip6: ndisc: fix incorrect forwarding of proxied ns packets
Date: Wed, 14 Aug 2024 14:31:06 +0200
Message-ID: <20240814123105.8474-2-nils@nilsfuhler.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enabling proxy_ndp per interface instead of globally, neighbor
solicitation packets sent to proxied global unicast addresses are
forwarded instead of generating a neighbor advertisement. When
proxy_ndp is enabled globally, these packets generate na responses as
expected.

This patch fixes this behaviour. When an ns packet is sent to a
proxied unicast address, it generates an na response regardless
whether proxy_ndp is enabled per interface or globally.

Signed-off-by: Nils Fuhler <nils@nilsfuhler.de>
---
 net/ipv6/ip6_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index ab504d31f0cd..13eaacc5a747 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -551,8 +551,8 @@ int ip6_forward(struct sk_buff *skb)
 		return -ETIMEDOUT;
 	}
 
-	/* XXX: idev->cnf.proxy_ndp? */
-	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
+	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
+	     READ_ONCE(idev->cnf.proxy_ndp)) &&
 	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev, 0)) {
 		int proxied = ip6_forward_proxy_check(skb);
 		if (proxied > 0) {
-- 
2.39.2


