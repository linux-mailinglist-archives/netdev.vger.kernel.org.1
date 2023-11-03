Return-Path: <netdev+bounces-45862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFE57DFF33
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 07:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093C11F2215A
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 06:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E41A2D608;
	Fri,  3 Nov 2023 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JkOnr0cF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8D17CA
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 06:36:30 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932D61B9
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 23:36:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991c786369cso260271166b.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698993384; x=1699598184; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3T+yLx+4ogAE3gIeP8EgVVgsRa9BX/dyzs2Dpc0BF4o=;
        b=JkOnr0cFHdtxVfiQRmuxWT3PRSUHv/Xdd7Ev/MwY9X+mstwSESg4VqwgoG5WZ5VAVA
         zmKu0fgaZlLyFDiEELknQaS7z1nws46byvs+hvpKiLPpeQXxQ0hAXsC/dw/zPUIBlElP
         YYr/5/d6xbMXHKO3oikJSyw/7eQ8T0GuzSohbrWESXKYU+iI2n0mjtCKDjhcrRhlpAoR
         zYqatuTdbKY8A76VDdZulGVTeODlazqynwIGMpt6Qx/AfEUckmB5zk8oEGwwxnocuSrK
         Fjc6Q6+xhYcwPOGambMI5jdp5UT6XN6ghYK1pVCexE1P/jB+rU4a8IkDQP64rA+8oWTL
         wwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698993384; x=1699598184;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3T+yLx+4ogAE3gIeP8EgVVgsRa9BX/dyzs2Dpc0BF4o=;
        b=Yqdznpw9Ik8rcWCIsrxpMOCMnZgCZmOkDc+WzMv8GI5keWR9noW1bfLnsI8PyUsndj
         crpWoFAn4Ssnt8J64rGphaHctHVbHST3uLPIh6h0zBdw42rAqiZLDT4URfP/+ab+eQ1i
         XlauxvxOqsp429BjW/XSTVD6WHZCJ72qHXIL/ykWUyreFu32MSmHcp4dIkqe/T1lQw9+
         B2OqyBPJP6V39K8mspdJMqVqu8pdwt/pov+4nync0uUyR6xf0fdB/pdhpLVdyEqm62kw
         frpUV/vxk1JCTepGZvHyskB/ukwh1ZX2Kil6kWRROfy/TcPCfrH4nJS301n/NBEF43HC
         rwhg==
X-Gm-Message-State: AOJu0YxpdNSHI6GB8kUPi0BVb/AThCNgtlixbD9O69yiEIDJysq/N7C5
	TDVGZTVH9xT+Wm9GqDeGY5NjAQ==
X-Google-Smtp-Source: AGHT+IEIZwpXows9kDY2z3asR0pXuUZWwTLFQ4ciJzI6HwkQ9NLgBbUfSMO6/4CkCnV3aEALCj5gCg==
X-Received: by 2002:a17:906:6a23:b0:9bf:2f84:5de7 with SMTP id qw35-20020a1709066a2300b009bf2f845de7mr6147260ejc.4.1698993383852;
        Thu, 02 Nov 2023 23:36:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090646cb00b009d0be9be6e2sm537198ejs.43.2023.11.02.23.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 23:36:23 -0700 (PDT)
Date: Fri, 3 Nov 2023 09:36:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eli Cohen <elic@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] net/mlx5: Fix a NULL vs IS_ERR() check
Message-ID: <4ee5fbea-7807-42dd-a9b8-738ac23249d0@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The mlx5_esw_offloads_devlink_port() function returns error pointers, not
NULL.

Fixes: 7bef147a6ab6 ("net/mlx5: Don't skip vport check")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I *think* these normally go through the mellanox tree and not net.

 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 693e55b010d9..5c569d4bfd00 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1493,7 +1493,7 @@ mlx5e_vport_vf_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 
 	dl_port = mlx5_esw_offloads_devlink_port(dev->priv.eswitch,
 						 rpriv->rep->vport);
-	if (dl_port) {
+	if (!IS_ERR(dl_port)) {
 		SET_NETDEV_DEVLINK_PORT(netdev, dl_port);
 		mlx5e_rep_vnic_reporter_create(priv, dl_port);
 	}
-- 
2.42.0


