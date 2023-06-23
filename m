Return-Path: <netdev+bounces-13520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3DF73BECD
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483B01C2103D
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F056610788;
	Fri, 23 Jun 2023 19:29:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E087101FC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0199C433CB;
	Fri, 23 Jun 2023 19:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548557;
	bh=XuuEFtPCzRB0txD69pRvJTvvGshaxQzao88XY/tszso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EK8AY7LiPa4QM8iA+84kAxgN0pBMBPP1oUCIwpC/0ao7i3FAIGGThak7uzN/kAV5x
	 yFd33AoIFele/UhH3vzvRWcsNj085NvB5QgHn3UOZDs9rx6oD7LdpLLXnquihXpXGc
	 DaK2NU9SPH4E5qMlmBa8gEacho8otcAmbQuUCVjki+h47z54vnJUt7f2qFn1nhyT3p
	 mkFeyMdIliR40yXpYDMb1NRxC6TPM6v4tnh066ltX7IQ+RxyZjdlf3qU336rLuEm8h
	 A6RuEkeUp7thJUq+Lgb6dhQTss2mtM5HNDXeiXAlDo5yXCRy8XTE7b0Th4kq1YK2KN
	 iLiotj0mc+Mvg==
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
Subject: [net-next V2 03/15] net/mlx5: Fix reserved at offset in hca_cap register
Date: Fri, 23 Jun 2023 12:28:55 -0700
Message-ID: <20230623192907.39033-4-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623192907.39033-1-saeed@kernel.org>
References: <20230623192907.39033-1-saeed@kernel.org>
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


