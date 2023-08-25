Return-Path: <netdev+bounces-30671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8AE7887CC
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 14:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B11281779
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540FACA5B;
	Fri, 25 Aug 2023 12:51:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710EC8E4
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 12:51:07 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6F91FD3;
	Fri, 25 Aug 2023 05:51:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a3ec08d93so1315967a12.2;
        Fri, 25 Aug 2023 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692967864; x=1693572664;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3veK2GLQgAEyb3AnmI5hfEQQ/nHn4wGQ/Gz5qedNjzc=;
        b=KSo8N+C+lT7gjxgt0QTTjqKba1nHMTCn1/CGila3+nU74bsq8Mv6iojbozL1LzafRO
         HbNxYDtICoE/zeuDbr3nMaxFW+kuVan4FsyeYpnq7csAxY+ehTqGlOT1r2S+RxnSJuvW
         1h01y2SOlnmEIve/pzqc/ryEofvuHkItUkJtK2Nejr7X6tgg6V4U6tsgkUsNxh3Vi/+9
         5KRsQEgtWX7ET07xI6y3yidv18lx4tSB+VXp6yBbjp/hL3U4Vk0TL4ag489Wv0ilPvcF
         O4UpoOIaQzEF91IGN7YOUGH4lnvh6A+3OcN0KF57mGNTZJq4nOxfiy/Eh5FxaGo0YGQV
         lv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692967864; x=1693572664;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3veK2GLQgAEyb3AnmI5hfEQQ/nHn4wGQ/Gz5qedNjzc=;
        b=H2muq5KYl5miHpIMoqf0tQY+12fHnNSj2IYQP+0GJkCpueL7T4L/4y2heNGuaVDl+w
         iRR9SoeO41vPagVkcYi9n4+OeXnuNt8RXpELy7/QpdVt0724jkJV84ZGRV14IKUR1Xf+
         U2gtp3cGhLUbk7S66h0fS+ycSctgAT3vwFi6/NH2plitQ1ovvltNN9v8M8YRU8nkdIer
         msM9CSXjY5i6Rn4+uWuUV3TCaOWfE5rtcYhFdBirHiHBNpbKIJxyLKAH6r+e9AuNY9wu
         WgBkOoowaxwjL+RHD6hsAAkyY7svJDHR3tuKDuc5tusG2wXOtOiEmDn/3s5fiS5jU9gM
         i8iw==
X-Gm-Message-State: AOJu0YyPl1LQIJOFhRnncsfLF2LhqVqOdw+HZmZloAJ+72R7v8dvf8cS
	E1tYomqxWGv5/4E7IhI6P5v0Vto2nrU=
X-Google-Smtp-Source: AGHT+IFI3Q0yMaKg4B5UwItri9FXog9d/RAogfgWy6j5YJ81cfmiJjeVJZgZiaF2B4L1kKoLDFNrjg==
X-Received: by 2002:a17:906:7395:b0:9a1:b5fc:8c5f with SMTP id f21-20020a170906739500b009a1b5fc8c5fmr9538341ejl.49.1692967864276;
        Fri, 25 Aug 2023 05:51:04 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:98c5:e120:ff1e:7709])
        by smtp.gmail.com with ESMTPSA id ck16-20020a170906c45000b00992b8d56f3asm922571ejb.105.2023.08.25.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:51:03 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] net/mlx5: fix config name in Kconfig parameter documentation
Date: Fri, 25 Aug 2023 14:51:00 +0200
Message-Id: <20230825125100.26453-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Commit a12ba19269d7 ("net/mlx5: Update Kconfig parameter documentation")
adds documentation on Kconfig options for the mlx5 driver. It refers to the
config MLX5_EN_MACSEC for MACSec offloading, but the config is actually
called MLX5_MACSEC.

Fix the reference to the right config name in the documentation.

Fixes: a12ba19269d7 ("net/mlx5: Update Kconfig parameter documentation")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Saeed, please pick this quick fix to the documentation.

 .../device_drivers/ethernet/mellanox/mlx5/kconfig.rst           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
index 0a42c3395ffa..20d3b7e87049 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
@@ -67,7 +67,7 @@ Enabling the driver and kconfig options
 |    Enables :ref:`IPSec XFRM cryptography-offload acceleration <xfrm_device>`.
 
 
-**CONFIG_MLX5_EN_MACSEC=(y/n)**
+**CONFIG_MLX5_MACSEC=(y/n)**
 
 |    Build support for MACsec cryptography-offload acceleration in the NIC.
 
-- 
2.17.1


