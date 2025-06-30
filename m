Return-Path: <netdev+bounces-202553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F3AEE437
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549B21BC04A6
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBFA292B2C;
	Mon, 30 Jun 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1b5G12s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB82E6D2C
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299804; cv=none; b=QfulSB6LrcTVC+BDVbFfFkQ/3/RXzR/2nQuU5t7ajFWw/re16Eg7Pnng4DO8A3k+6VSEK7THCxof2BRiqmhy+rW3U5pi6JSRo+xMTqEZOJ9pWapa1iP+EwwW6sEph0128g2+tu/+83lco+IHJeachLvarORhQ/O5VHqoCJtbS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299804; c=relaxed/simple;
	bh=H3ilVKcuOK7n7L69aSi30BR2lcZlbwLhQrJghnb5gY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUdsYSI/kSa4CnntSWrsvQ+3z3vHNFgtBqpOsS/MnGHB99xJbfTqQ+qjTTdjf1UFLF+bfWp4qccb9wjp4MCeE1ScQijM9E6hi5e4W7JvUH4qMPsrkh4cuGmNyy2MlmwEdFF1is9A9pobpUVoLH6FOCgPaHZijie4d3wAjt7IboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1b5G12s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4310FC4CEF2;
	Mon, 30 Jun 2025 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751299804;
	bh=H3ilVKcuOK7n7L69aSi30BR2lcZlbwLhQrJghnb5gY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1b5G12s+pWYnJ8GRUnHWc72eFWrfHeaRnfpFd3pvdzxCi5H3Fht5KwqbWDMeyzfc
	 aF4obyWFIfBEo+yKp11KXCnMA9+XYk+m8XJLUpCEP1W9w6mnF55suznUBGvbFGSsL0
	 6L5a8L6IAhl8ZYhUZ/5P5BwfQQXOjKHBQlJyMubv54jrNg2JAT2BCPQygcaOm8yGoB
	 dsMQOsAG7x/nBWhFyNot66uqncOPd5T4wE2AImjmTz3uWeLk9DMNNUzdyTfIreAzII
	 hrOlLlWHa8xMx0M0DHgfGfdjPYCY5hqgPT0iF3KE2YWUDIYOkshFkBcLkXc/R29fXn
	 dBsLBuJU2q3pQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	bbhushan2@marvell.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] net: ethtool: reduce indent for _rxfh_context ops
Date: Mon, 30 Jun 2025 09:09:53 -0700
Message-ID: <20250630160953.1093267-6-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630160953.1093267-1-kuba@kernel.org>
References: <20250630160953.1093267-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we don't have the compat code we can reduce the indent
a little. No functional changes.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/ioctl.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 17dbda6afd96..fcd2a9a20527 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1668,25 +1668,20 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	rxfh_dev.rss_context = rxfh.rss_context;
 	rxfh_dev.input_xfrm = rxfh.input_xfrm;
 
-	if (rxfh.rss_context) {
-		if (create) {
-			ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev,
-						       extack);
-			/* Make sure driver populates defaults */
-			WARN_ON_ONCE(!ret && !rxfh_dev.key &&
-				     ops->rxfh_per_ctx_key &&
-				     !memchr_inv(ethtool_rxfh_context_key(ctx),
-						 0, ctx->key_size));
-		} else if (rxfh_dev.rss_delete) {
-			ret = ops->remove_rxfh_context(dev, ctx,
-						       rxfh.rss_context,
-						       extack);
-		} else {
-			ret = ops->modify_rxfh_context(dev, ctx, &rxfh_dev,
-						       extack);
-		}
-	} else {
+	if (!rxfh.rss_context) {
 		ret = ops->set_rxfh(dev, &rxfh_dev, extack);
+	} else if (create) {
+		ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev, extack);
+		/* Make sure driver populates defaults */
+		WARN_ON_ONCE(!ret && !rxfh_dev.key &&
+			     ops->rxfh_per_ctx_key &&
+			     !memchr_inv(ethtool_rxfh_context_key(ctx),
+					 0, ctx->key_size));
+	} else if (rxfh_dev.rss_delete) {
+		ret = ops->remove_rxfh_context(dev, ctx,
+					       rxfh.rss_context, extack);
+	} else {
+		ret = ops->modify_rxfh_context(dev, ctx, &rxfh_dev, extack);
 	}
 	if (ret) {
 		if (create) {
-- 
2.50.0


