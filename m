Return-Path: <netdev+bounces-56907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C024B811448
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECA92828C2
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F172E832;
	Wed, 13 Dec 2023 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raDR3LMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A4310C
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 06:09:02 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3363e9240b4so341266f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 06:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702476541; x=1703081341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKQmsgK550fGD+FPkX8U9qIfMTPKfTZB/dYSgLKLhHI=;
        b=raDR3LMQD2Yc+pWuvi6DVStJgdBYhKRHCQ0uii1O7MQSKC8Pm5qjpupa0X1KOIHl2B
         dT1mIqsvJJ3CKmX7J59jjDSV6W7xIPmX2RoM7J6cOJ8Prs1jh+R3tNwAX1P3GI3O74tL
         phAKfYogQbwiZ/UmxP3DRj+90EOnpgGlHjDfX70KFQWXtBiVUVnGZBzZHYjeGSL978NZ
         AtiTI3HTN1S3PKz1yvUHkEwWeT2yc7H+qzgkq1ndk2r37KxY7WGt+BgOWl9NKfM2mF9M
         xFy+d98N5vMuZ8ZgL3lLDFVbJQTs3nQ8U7VbaIvIsgS3AXR/1g5xlYkpoNaOwNOE5YME
         hSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476541; x=1703081341;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKQmsgK550fGD+FPkX8U9qIfMTPKfTZB/dYSgLKLhHI=;
        b=KAOqxlxB2dnRlKyAk80JgCUdGscJFKOIqgiyuZ/AjsbzX7U47mx5d/J049pIro2eLP
         9nzLem6o3+wQ26SV26ZvITDtMGoAY1vUj+9jKW0DtBGl4SjYYPdJi6bWHZnkJjw9+TG5
         xkPFtCwY4P4Bch5oPcp3MQxoeb8lrXZpYiY8DRYtISx9kayYkDnZCOgOV3foNoYDwu4k
         5S/2V+1KQceO2gU3pwaxqmbqFrf5JgG2cEEidXvFnSbFuCqAg7NnaXrwvpoVmssGi/aA
         p8pGp/1VU9C4cwSs+cc4U5vcRsiuCex7NYImA6wID7jR1Dencde1B72E9qoBq1ZpxFI1
         3Bzw==
X-Gm-Message-State: AOJu0Ywk6ihUMhYjeGvMd271ziXY4g2vyFaCErp11h1kLLPYum8VsT4H
	uycx2tHQIS8fiViHPdqsquPsGw==
X-Google-Smtp-Source: AGHT+IHjUazdmDWYtmZHjBl/MNYaHkCncmuiI4Qik4o/6nTaZ1Cz/zKroUpSSvwn0aRFyAT+imvrQg==
X-Received: by 2002:a5d:6d4a:0:b0:336:1d85:a87 with SMTP id k10-20020a5d6d4a000000b003361d850a87mr2669412wri.12.1702476541132;
        Wed, 13 Dec 2023 06:09:01 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id b18-20020adfe652000000b003333f5f5fd7sm13472171wrn.31.2023.12.13.06.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:09:00 -0800 (PST)
Date: Wed, 13 Dec 2023 17:08:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chris Mi <cmi@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net 2/2] net/mlx5e: Fix error codes in alloc_branch_attr()
Message-ID: <3504e359-aed9-421b-b2f1-e0f7b4769132@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133f4081-6f34-4e3b-b4b5-bacd76961376@moroto.mountain>
X-Mailer: git-send-email haha only kidding

Set the error code if set_branch_dest_ft() fails.

Fixes: ccbe33003b10 ("net/mlx5e: TC, Don't offload post action rule if not supported")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 85cdba226eac..5775699e1d3e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3778,7 +3778,8 @@ alloc_branch_attr(struct mlx5e_tc_flow *flow,
 		break;
 	case FLOW_ACTION_ACCEPT:
 	case FLOW_ACTION_PIPE:
-		if (set_branch_dest_ft(flow->priv, attr))
+		err = set_branch_dest_ft(flow->priv, attr);
+		if (err)
 			goto out_err;
 		break;
 	case FLOW_ACTION_JUMP:
@@ -3788,7 +3789,8 @@ alloc_branch_attr(struct mlx5e_tc_flow *flow,
 			goto out_err;
 		}
 		*jump_count = cond->extval;
-		if (set_branch_dest_ft(flow->priv, attr))
+		err = set_branch_dest_ft(flow->priv, attr);
+		if (err)
 			goto out_err;
 		break;
 	default:
-- 
2.42.0


