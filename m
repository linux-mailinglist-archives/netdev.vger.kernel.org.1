Return-Path: <netdev+bounces-28234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585A677EB45
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891DF1C2123B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E191ADD4;
	Wed, 16 Aug 2023 21:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6F1ADEC
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0423C433BB;
	Wed, 16 Aug 2023 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219664;
	bh=ITeW/DrgoN4KqWImStr2hyRkxD/UhmDxlkmgmrdgIA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SpKXP2/aSnnVMyqDqbNMsm7cf92hxR3sY0idtRpPjMoUCmRImo16RJNxFHVNUqRgB
	 65iyo0t9xCd7K7tVeF7JR/HMmN2wfYy8JNzxEB8fuuWscLtHiRWnec7E1KvV/+uXK7
	 niyjQiHNLcoQONbNDjCvTkcjkc58zFlHXbi1chrGjx6WepSDJkB/9bMnzO5AItmXBA
	 ostx5yEB6eOlI8olP5uZ3JyPJ7bPw+9/W+vwB2WTh0QzaqGjjVoBF1XsN0cK0m+qAZ
	 Vh3j+jbJOKQSgP721jO6SQ9Mzc0CuT9uo/qZxQuUtPI8kF+gAl1KUSIwkkkt2icV3o
	 b82gQYFcSN6lw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next 08/15] net/mlx5: Remove health syndrome enum duplication
Date: Wed, 16 Aug 2023 14:00:42 -0700
Message-ID: <20230816210049.54733-9-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816210049.54733-1-saeed@kernel.org>
References: <20230816210049.54733-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gal Pressman <gal@nvidia.com>

Health syndrome enum values were duplicated in mlx5_ifc and health.c,
the correct place for them is mlx5_ifc.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/health.c  | 36 ++++++-------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 187cb2c464f8..2fb2598b775e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -49,20 +49,6 @@ enum {
 	MAX_MISSES			= 3,
 };
 
-enum {
-	MLX5_HEALTH_SYNDR_FW_ERR		= 0x1,
-	MLX5_HEALTH_SYNDR_IRISC_ERR		= 0x7,
-	MLX5_HEALTH_SYNDR_HW_UNRECOVERABLE_ERR	= 0x8,
-	MLX5_HEALTH_SYNDR_CRC_ERR		= 0x9,
-	MLX5_HEALTH_SYNDR_FETCH_PCI_ERR		= 0xa,
-	MLX5_HEALTH_SYNDR_HW_FTL_ERR		= 0xb,
-	MLX5_HEALTH_SYNDR_ASYNC_EQ_OVERRUN_ERR	= 0xc,
-	MLX5_HEALTH_SYNDR_EQ_ERR		= 0xd,
-	MLX5_HEALTH_SYNDR_EQ_INV		= 0xe,
-	MLX5_HEALTH_SYNDR_FFSER_ERR		= 0xf,
-	MLX5_HEALTH_SYNDR_HIGH_TEMP		= 0x10
-};
-
 enum {
 	MLX5_DROP_HEALTH_WORK,
 };
@@ -357,27 +343,27 @@ static int mlx5_health_try_recover(struct mlx5_core_dev *dev)
 static const char *hsynd_str(u8 synd)
 {
 	switch (synd) {
-	case MLX5_HEALTH_SYNDR_FW_ERR:
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_FW_INTERNAL_ERR:
 		return "firmware internal error";
-	case MLX5_HEALTH_SYNDR_IRISC_ERR:
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_DEAD_IRISC:
 		return "irisc not responding";
-	case MLX5_HEALTH_SYNDR_HW_UNRECOVERABLE_ERR:
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_HW_FATAL_ERR:
 		return "unrecoverable hardware error";
-	case MLX5_HEALTH_SYNDR_CRC_ERR:
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_FW_CRC_ERR:
 		return "firmware CRC error";
-	case MLX5_HEALTH_SYNDR_FETCH_PCI_ERR:
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_ICM_FETCH_PCI_ERR:
 		return "ICM fetch PCI error";
-	case MLX5_HEALTH_SYNDR_HW_FTL_ERR:
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_ICM_PAGE_ERR:
 		return "HW fatal error\n";
-	case MLX5_HEALTH_SYNDR_ASYNC_EQ_OVERRUN_ERR:
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_ASYNCHRONOUS_EQ_BUF_OVERRUN:
 		return "async EQ buffer overrun";
-	case MLX5_HEALTH_SYNDR_EQ_ERR:
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_EQ_IN_ERR:
 		return "EQ error";
-	case MLX5_HEALTH_SYNDR_EQ_INV:
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_EQ_INV:
 		return "Invalid EQ referenced";
-	case MLX5_HEALTH_SYNDR_FFSER_ERR:
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_FFSER_ERR:
 		return "FFSER error";
-	case MLX5_HEALTH_SYNDR_HIGH_TEMP:
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_HIGH_TEMP_ERR:
 		return "High temperature";
 	default:
 		return "unrecognized error";
-- 
2.41.0


