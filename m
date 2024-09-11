Return-Path: <netdev+bounces-127550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E76975B8F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C381F23405
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D6D1BBBD5;
	Wed, 11 Sep 2024 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi9U1fMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD718DF73
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085886; cv=none; b=bRm73+x+gMB8JWjgipHlOoSQuf8aXOpFDR/AlXHxrG5gJghiMS6k5Qop6DoDoP825EGMqwm79cOelOPJB/Je1zqpZkSoqhHQoBvkbuLUIhvevCCNc7egAGc915yeEig7YhlMC7OJhwWxost0sthK9k5isb/lMh7B00AqPcD1CJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085886; c=relaxed/simple;
	bh=CiLBG8leecpTvBllNpaSUxnrWZ52mCRJY4uAArwNdzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSyA/iNaEiJzf29VKBxevznrs5wJhKsvlbFpXuMOYZRNkxM+lt9DsdenN0EPpU3S2mINCLWoGnVoh5hUUvkCDJq49HS+j8owJVnrUXAZOlp5hR4/7wrIPv+YDtJjyb5r/9mueKCTe3sCp/1k+wkDXPS04pH/OHZmDJirDtFNi7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi9U1fMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38536C4CEC0;
	Wed, 11 Sep 2024 20:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085886;
	bh=CiLBG8leecpTvBllNpaSUxnrWZ52mCRJY4uAArwNdzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xi9U1fMwDzmRPEl1naN6hQ9anVzieJrNLnB695NLDlDZcf4kAJi970+M1O4d4sVzC
	 PA7rgGEhJakUyujK3M/6oP6O53N4gYoW3dhELs5lTPjrJyS3YBcqX2DKFYEaq/86GZ
	 PZ7XKvAKxNYnYFUmCrn/9WeSkzMlhlZKHf7y7LNLPMD770iF83Csljl3D29UUvacis
	 u0ecREQSy2Ixg17ioJsEzpBnZONbsyOgVDWFbLS5IUQXfU5y0WZFrLI9hQurNHoV4V
	 h8vofrRQE0pFDDFC/0nLdYR4mabHDnoq1/tFWX0XT3twSs5gPOqjYFZRvQOllvzcGP
	 B/zkGhHEEU3aQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [net-next 06/15] net/mlx5: fs, remove unused member
Date: Wed, 11 Sep 2024 13:17:48 -0700
Message-ID: <20240911201757.1505453-7-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Bloch <mbloch@nvidia.com>

Counter is in struct fte, remove it.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 6201647d6156..5eacf64232f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -241,7 +241,6 @@ struct fs_fte {
 	struct mlx5_flow_context	flow_context;
 	struct mlx5_flow_act		action;
 	enum fs_fte_status		status;
-	struct mlx5_fc			*counter;
 	struct rhash_head		hash;
 	int				modify_mask;
 };
-- 
2.46.0


