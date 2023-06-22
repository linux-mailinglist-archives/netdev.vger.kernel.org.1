Return-Path: <netdev+bounces-12907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9897396F6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058AF1C209D3
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBCB539E;
	Thu, 22 Jun 2023 05:47:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0E522B
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530C2C433C8;
	Thu, 22 Jun 2023 05:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687412869;
	bh=XuuEFtPCzRB0txD69pRvJTvvGshaxQzao88XY/tszso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JD66o/fQLNcavL542byK98MRpJIy+WDJiJEiVzHzfIU72dRG0e8A6h8P/Y4IHmtq+
	 c85SkqefWj3Z2Hxs7BD4zAYXo4XNCHv/1MX/HoIKttHMW+Z38/1kBiFL0hBOtxZaFo
	 0K3MIJoYoFrrm+Lcm7ne4y8xyxuk1+3eHXpD+94LQalwUNcDkeuYbz47dqSfd5fUGG
	 +4BpBcBlIzRnSmcfRseC+rsYxXZN+lbVBqFJRAYkcHH1Ipwz+e52YO2Dlt98ulD/mv
	 /LBdIUnnrEN9n7DJOwH8s63U2vqYpYPDkUexATzpFGgFfPa/qGSQEfb4983RN4nhuF
	 NknNfcvazmF8w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Lama Kayal <lkayal@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net-next 03/15] net/mlx5: Fix reserved at offset in hca_cap register
Date: Wed, 21 Jun 2023 22:47:23 -0700
Message-ID: <20230622054735.46790-4-saeed@kernel.org>
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

From: Lama Kayal <lkayal@nvidia.com>

A member of struct mlx5_ifc_cmd_hca_cap_bits has been mistakenly
assigned the wrong reserved_at offset value. Correct it to align to the
right value, thus avoid future miscalculation.

Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 354c7e326eab..33344a71c3e3 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1710,9 +1710,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         regexp_params[0x1];
 	u8         uar_sz[0x6];
 	u8         port_selection_cap[0x1];
-	u8         reserved_at_248[0x1];
+	u8         reserved_at_251[0x1];
 	u8         umem_uid_0[0x1];
-	u8         reserved_at_250[0x5];
+	u8         reserved_at_253[0x5];
 	u8         log_pg_sz[0x8];
 
 	u8         bf[0x1];
-- 
2.41.0


