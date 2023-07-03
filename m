Return-Path: <netdev+bounces-15157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D289745FC4
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7671C209C3
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7656E100B0;
	Mon,  3 Jul 2023 15:25:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38AF9D5
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 15:25:04 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF28E44
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:25:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc0981756so43824595e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688397898; x=1690989898;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOoo0U993ZoETiAnjj1BgJ2aAKdPK1rKF3JmUFNH4F8=;
        b=SBu2AN5iPi5C4xwUtf3Cp/Uywi3LQXjo5gem4+0Em9+EZbabNQKtjrmrItUAk0ZtgD
         k1X5en/dc37ynzZ8bKzaHOJNkYdLk6wEXLHQwRd33TuYagKmENDbFOfw+Tpl00s7mSjn
         HV84Qhox5TmY0ADs1wxtTeb0j3i56ADMzzLAqGvpMC13tHII4MDFY+YVwdoSvho/dUMq
         xM5c7Jk6M+T7laeyuGsBzv6sXplvu7oLqQCa3bQJD2Hp+wQbG6LSf/IP0rNe2cEvRNXN
         0pDGFpHqJCNI/cu9lupYv4zZrgD9wQGRBraOGl6o7ZppOp0iYWYAvagGlunfP2HntOoN
         sVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688397898; x=1690989898;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOoo0U993ZoETiAnjj1BgJ2aAKdPK1rKF3JmUFNH4F8=;
        b=TTASudJRNE/FqUUCqkAJ30pFPwKACDgS4nxXCo8M/6UTi1qN0YLV/Q/FuX8klQeAAQ
         fNDTpBwdO+ZNRVNyZ20p5vppbiSySbkJoWdaw0vEl+E92kZsjBJnY+zj383iI1o2Fpt1
         HGsGP++1sn04owE8rupuDl2y7kQjajH9L9PpH939ocPiEljmHG0UBkzKHgzjaN7zNpGX
         6h/JTJnajvE56eaX7dRA12RZI9PEbbC+ggJNOB13TV6ZTVZt3Fz0emyirW4IR7A/4K6K
         43KCFTpfT+f2EGsnzWtQJlehQz+YRMPEfOSGVUpx8FE6i5rTtoXoy+DD+n/S+Rmx81Mh
         hlEQ==
X-Gm-Message-State: AC+VfDz4yVkiEwEWFeZh0xBmu19QWyO27JMA2becoEnp7mscREtPS+Hv
	U7ZwcBpzP6eMjMLE3+0l+v7UJQ==
X-Google-Smtp-Source: ACHHUZ5eKWRvf+MaKiAVRiNcRmJgJgV0QDRgJsVkcwqbUi1kCfnmwE27UxBo5TK2vTBqvNvRmWy6kw==
X-Received: by 2002:a7b:ce0a:0:b0:3fb:b1fd:4172 with SMTP id m10-20020a7bce0a000000b003fbb1fd4172mr8046842wmc.22.1688397898719;
        Mon, 03 Jul 2023 08:24:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d58e3000000b00314329f7d8asm4571482wrd.29.2023.07.03.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:24:56 -0700 (PDT)
Date: Mon, 3 Jul 2023 18:24:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] mlxsw: spectrum_router: Fix an IS_ERR() vs NULL check
Message-ID: <16334acc-dc95-45be-bc12-53b2a60d9a59@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The mlxsw_sp_crif_alloc() function returns NULL on error.  It doesn't
return error pointers.  Fix the check.

Fixes: 78126cfd5dc9 ("mlxsw: spectrum_router: Maintain CRIF for fallback loopback RIF")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Applies to net.

 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 445ba7fe3c40..b32adf277a22 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -10794,8 +10794,8 @@ static int mlxsw_sp_lb_rif_init(struct mlxsw_sp *mlxsw_sp,
 	int err;
 
 	router->lb_crif = mlxsw_sp_crif_alloc(NULL);
-	if (IS_ERR(router->lb_crif))
-		return PTR_ERR(router->lb_crif);
+	if (!router->lb_crif)
+		return -ENOMEM;
 
 	/* Create a generic loopback RIF associated with the main table
 	 * (default VRF). Any table can be used, but the main table exists
-- 
2.39.2


