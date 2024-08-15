Return-Path: <netdev+bounces-118892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 224C09536EA
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5391F225FB
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9741AAE1F;
	Thu, 15 Aug 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nilsfuhler.de header.i=@nilsfuhler.de header.b="gD4c3OTY"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744A17BEA5;
	Thu, 15 Aug 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735178; cv=none; b=BHsBqXCCo4zpzqeXVhF8NbhWv9Ks0s5iT8k9P62KXIQilU3EFL5SSoiGdP/naCgTZyg2/RPjd3ElSRr7gx9KV3q9lMMUqbPjEjssFl5oYPqBHL8eld8MYgsbbYAcVY45XocIQBlDDRAU6wyuBIr4vQXoXL8mQsDH/jSSGKtwinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735178; c=relaxed/simple;
	bh=00CNwtB+iUDN7Fy758tQ5jFKfPfLWx8oasWG9V+8sUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PjcGFIKRmk4oe9WtPJ8RK2Bjh7jJ6xxo10p0f6sE3I2lqHyFMapfDzdq8X8dJkBDaTm5oUDWypPlgBwDRsiK9C+OMO+oPSA8mWLKBM6cCifnt0UoT9vRU7eTwX6cAmgzzGBM/2q1GHbeDjJrhttOZP1Of6xmTrJzvOStNO8jneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nilsfuhler.de; spf=pass smtp.mailfrom=nilsfuhler.de; dkim=pass (2048-bit key) header.d=nilsfuhler.de header.i=@nilsfuhler.de header.b=gD4c3OTY; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nilsfuhler.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nilsfuhler.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wl81C3qxnz9t8n;
	Thu, 15 Aug 2024 17:19:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nilsfuhler.de;
	s=202311; t=1723735163;
	bh=00CNwtB+iUDN7Fy758tQ5jFKfPfLWx8oasWG9V+8sUA=;
	h=From:To:Cc:Subject:Date:From;
	b=gD4c3OTY86Wq1eTZj5ltMTlTTgpSv7FOdnYO3qOZcB1+5ZuOu68pSUturoZThSKTf
	 132QrnIGwiMbz6ReML1f6Pb0TCk5rSCJ+/TfpsH6o7r+GDXDbHelkbFgMe+QC9LKsT
	 YoZmWo9kOMM+EFva7b8FiQ6e26zN1ZEDdEUiJCK9rVOzHUU59WInc6q2N9Tla4y2U1
	 GR1nHj/wIvqNWuKfUsvBNmtdx6us4eQ4lXI6WkZBmvhx/0ATkY19en0whDjPMttUgd
	 4uMDAcI7eM2KHQn+gXu10BnsZAo4WzEMUXI4yR9qEG/ka2+JIc85K3dKRSfuHivTmP
	 f5flj5VgXXAIg==
From: Nils Fuhler <nils@nilsfuhler.de>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nils Fuhler <nils@nilsfuhler.de>
Subject: [PATCH v2] net: ip6: ndisc: fix incorrect forwarding of proxied ns packets
Date: Thu, 15 Aug 2024 17:18:10 +0200
Message-ID: <20240815151809.16820-2-nils@nilsfuhler.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Wl81C3qxnz9t8n

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
v1 -> v2: ensure that idev is not NULL

 net/ipv6/ip6_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index ab504d31f0cd..0356c8189e21 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -551,8 +551,8 @@ int ip6_forward(struct sk_buff *skb)
 		return -ETIMEDOUT;
 	}
 
-	/* XXX: idev->cnf.proxy_ndp? */
-	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
+	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
+	     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
 	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev, 0)) {
 		int proxied = ip6_forward_proxy_check(skb);
 		if (proxied > 0) {
-- 
2.39.2


