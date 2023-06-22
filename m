Return-Path: <netdev+bounces-12917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E831D73970B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54102807AC
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E3F18002;
	Thu, 22 Jun 2023 05:48:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E79418010
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A303C433C8;
	Thu, 22 Jun 2023 05:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687412882;
	bh=TpW3DD+tbX2KtI+8ko7C3YXrkZdAuQAwkvkJAGVFRec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nqkw0HBhC49cUqXfWaEqXe3A7KBhtWLyLtivPxk54xPcbkRrA5U1yhPr3LzNdJ93S
	 5gdKST14tWq+G1+5E9EazwjvGfMR/06Rvq55+N/7M0F4S6o1UYwCOuBM1H6/ykdVUE
	 kZzhev5e77viRaAXvODWJO17vFCiCy46kjihEiTQH7ADHdxKAWCun6mIMKLtsYL34s
	 VNpy8dWUbfHY3Yf0eYqmk4OzK5C/0IhICyIpC1V89TOnCLD/mY4FDKgc+SMe8HnBpQ
	 yW4rCPD+g2AuICt3JTk+9dZC0zV3FqdQ5c+GYoBvMMpKYchDjPLedsIjiBxJv5Xuo8
	 DXVav1UFrmbCQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 13/15] net/mlx5: Remove redundant is_mdev_switchdev_mode() check from is_ib_rep_supported()
Date: Wed, 21 Jun 2023 22:47:33 -0700
Message-ID: <20230622054735.46790-14-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622054735.46790-1-saeed@kernel.org>
References: <20230622054735.46790-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

is_mdev_switchdev_mode() check is done in is_eth_rep_supported().
Function is_ib_rep_supported() calls is_eth_rep_supported().
Remove the redundant check from it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 3b1e925f16d2..edb06fb9bbc5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -151,9 +151,6 @@ static bool is_ib_rep_supported(struct mlx5_core_dev *dev)
 	if (!is_eth_rep_supported(dev))
 		return false;
 
-	if (!is_mdev_switchdev_mode(dev))
-		return false;
-
 	if (mlx5_core_mp_enabled(dev))
 		return false;
 
-- 
2.41.0


