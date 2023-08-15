Return-Path: <netdev+bounces-27696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6247977CE79
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD432814F2
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BCA13AFD;
	Tue, 15 Aug 2023 14:52:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA413AE1
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 14:52:05 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205719A4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:52:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so51362515e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692111119; x=1692715919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQjn1wcD2TcMPnivS8Au5P/abNagCYVuKRHkyUuFKlE=;
        b=c1IelibR2BsXg7VepaxkJ0k2E7iAr9O/B+LCW8sGbPcbGFuC3yFX8KBE2NO97JJbFH
         8YOo3q6WfJTbddobuMwpKsIZlCAR3HP+HyZEqM1weQcqRbNibIeTm5zxT/PNEPfkLXn/
         Ge8YVZQ2xEcl1F2pbLm41llTeC1BQrQxml+AJ/5n9MUvMp9OVkdupDffMSdkT7qwY7GT
         qk1FzgMXskCi1/GNnjfjsBUN9zZySUggYENUiGviwviE+Qkak7XkRDc8whOCIBJPJRGn
         NRQOLwMpq5hGEEDOYPCTDKqNUZYx7dzonIYqbxzgvtx5CzFt3WfZcA/NIY1n+R875xIX
         TU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692111119; x=1692715919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQjn1wcD2TcMPnivS8Au5P/abNagCYVuKRHkyUuFKlE=;
        b=avpNROsKrlS0JbBKc6oYlTaO5fGVd6BF6OYiyF0F+Kj1pgeor2a0PrzGgfqlg6uVnO
         zMm1jaksRi0EFasGt8JmfU3RnVb3axh9GkSbSyHDgiZC5MoL9yOrV9WQhiiCxWp4REPe
         7WLrrzadIveGXgAQJOhPQl2ZxbOi8Ec4wrNbcUz+ER+vy2+v1OsiwcP7+ovsAckTOgir
         qDW7KIndl1EyRK+ffjUq3J8CPVqhi/XJ1DELuZPZ2c7mUFLc20j4CNv1fNPOdc7+cKU7
         A6cmpgaVQCnBJFQyALZNlxK/Ug9Dyung1du6X/NhoyO2+D4YpjPzspZ3CJ0NT1l0JyeR
         fuIg==
X-Gm-Message-State: AOJu0YxZAt7utgXRRnO6kHkoyOgg1Blaj65qcOlntBK58XyFWuW+nwZk
	BI7PJsbCT5e9FJZ5gBdbgI9ooI83wVjCNIcNLrgSJUWc
X-Google-Smtp-Source: AGHT+IFHX/MPMYp5wXbRO7XttS2jZ5d2+GqaXfanJ94kFOldhDgG4+Alvrd6MGicEzKs6jrwU7xYyw==
X-Received: by 2002:a05:600c:ac4:b0:3f5:146a:c79d with SMTP id c4-20020a05600c0ac400b003f5146ac79dmr10108489wmr.15.1692111119129;
        Tue, 15 Aug 2023 07:51:59 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id z15-20020a1c4c0f000000b003fc0505be19sm18070055wmf.37.2023.08.15.07.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:51:58 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	shayd@nvidia.com,
	leon@kernel.org
Subject: [patch net-next 1/4] net/mlx5: Disable eswitch as the first thing in mlx5_unload()
Date: Tue, 15 Aug 2023 16:51:52 +0200
Message-ID: <20230815145155.1946926-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815145155.1946926-1-jiri@resnulli.us>
References: <20230815145155.1946926-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

The eswitch disable call does removal of all representors. Do that
before clearing the SF device table and maintain the same flow as during
SF devlink port removal, where the representor is remove before
the actual SF is removed.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index f4fe06a5042e..4d36066e2f7a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1406,9 +1406,9 @@ static int mlx5_load(struct mlx5_core_dev *dev)
 
 static void mlx5_unload(struct mlx5_core_dev *dev)
 {
+	mlx5_eswitch_disable(dev->priv.eswitch);
 	mlx5_devlink_traps_unregister(priv_to_devlink(dev));
 	mlx5_sf_dev_table_destroy(dev);
-	mlx5_eswitch_disable(dev->priv.eswitch);
 	mlx5_sriov_detach(dev);
 	mlx5_lag_remove_mdev(dev);
 	mlx5_ec_cleanup(dev);
-- 
2.41.0


