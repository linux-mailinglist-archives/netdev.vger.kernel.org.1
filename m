Return-Path: <netdev+bounces-203133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5E5AF08FA
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA5C4E3695
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACD91DEFDB;
	Wed,  2 Jul 2025 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L50Xe4+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473471DED42
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425613; cv=none; b=NLRH4LaNyB1kLW0Lm+mJAma5FyWPQpq0PRlE7lgFtQgcgBRQsA8yovHETMk9iFJRlfhSEEI2WSBcYQn8gKpwJEgznEPSMpQbhqd4ygm7X1GmRJPM5eo/NUGzxUGQsgv8Z99YY94zMd+O7im0OF26MW5M9OK6hSlq8s3vakFuv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425613; c=relaxed/simple;
	bh=nUzDqed4EgDbLiB0xx+JLNmAhTy6L194y8iKhE3MiN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgsDaCJW79x8nZkLtbQHFXNUNlgSBU4bSP0ORxQF7S3L9pJDJ2YwkRSQ8nTw2Le7l+81YcIAtRlIf8aUyS400Y2PQYG4v0pBMz+3MKZgFs+0lga04qPTgtPsuy39k7ETLwLCaRi44z+eKRQRVrgj3BcrjIJ0LtzZygxpgYdylOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L50Xe4+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB505C4CEEB;
	Wed,  2 Jul 2025 03:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425613;
	bh=nUzDqed4EgDbLiB0xx+JLNmAhTy6L194y8iKhE3MiN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L50Xe4+MendN+VUnqUlqC36xUQj1GljRaR8qcyrej1Wglmx8UC+URlVgDzSV1nxgO
	 tGxCWlW66SvO15kfBWvc+F7mlmifO+DEELBrgfAdPbn1gWuPk180/ixnhgSzkIUUeU
	 /dEyhgxAVphOzmYB7nC+IEDNvMntn9RM/kvj0DyzU3sCVimtPK7og4i1qkJ1PlvWPN
	 WERGu0pgKheabl55ZS+QoaA6hd1sHTPGcr0se0+m2cVheN23p6nkJ0hF9Mtc4UZ46O
	 ryBbqp68Kf25SjSU5Ft7gwK4W92k4Db39KRBlDuh2QMBqvjCkyuPFEaDXcE0EogAQm
	 ZRdtR8rBnOASg==
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
Subject: [PATCH net-next v2 5/5] net: ethtool: reduce indent for _rxfh_context ops
Date: Tue,  1 Jul 2025 20:06:06 -0700
Message-ID: <20250702030606.1776293-6-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702030606.1776293-1-kuba@kernel.org>
References: <20250702030606.1776293-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we don't have the compat code we can reduce the indent
a little. No functional changes.

Reviewed-by: Gal Pressman <gal@nvidia.com>
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


