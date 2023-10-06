Return-Path: <netdev+bounces-38469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15417BB13F
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 07:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166CE1C20945
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 05:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102C546AC;
	Fri,  6 Oct 2023 05:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b="gVjdEc2z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A83233
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 05:37:42 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C101B6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 22:37:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690d8c05784so1473171b3a.2
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 22:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=extrahop.com; s=google; t=1696570659; x=1697175459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vej1ehtR35S7UxvFXgxX5bZsKSjPT18mM1qf+cTWtaI=;
        b=gVjdEc2z67ExW4+AkHY8gLoycWpJE96/cqryfA4Jj0QNVhg6QC09aYf1jgGFpITrOA
         ZIpARezb6ZpyGhS3J1LmE9Y5y00bib7mhl6ihIbUfArlcS3e4SroV/TBcpb5iT34gPWe
         EPK+huV56y0hqOSh9T3aIfrwMxAgSi+1ZNddcPQcNAsxP+HHxKwYypNsSwVGy3luvJ2i
         kMZa98+ZEijt4a1eUr1l5akRHalf83GDTSmm4P/IkceupPFxcigCPKSpR46hlLi26HOb
         pjQ1XOqiq9xvOUNFVvD95ewzonrMX3U2sZI4lm87VawdfJpcxNxh/Q0DvAOmLZZwXpQI
         8Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696570659; x=1697175459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vej1ehtR35S7UxvFXgxX5bZsKSjPT18mM1qf+cTWtaI=;
        b=D3TovcWVYev0jxRxwm+zXKgKYY4Qg1GAKsLDPx5ON+DCV0LzULFvqBzDH3S/Ju2cWL
         hcY+PjACrlAnFxBIWyJXxI+RunUBJuzOnb1bt2ig5n3LXx/VutGX3xCK8U9mzIaqs02Z
         n1JzvHP7Tnx8JADqJg5uEdvWXQ6XB7rAddU7+HQZcNr+uT9qVnAh5d24td0gSa579v49
         Tk8WE+ouMPIKVfV8o1zJk8qt6AwVsONY9okmTVpUz82J1Q/6ansWVJYU1YcinIkxI0DA
         Ic5TDDUYUY7mL7PiwG/WTwzZl15HrkonSiI4XZiOzV4BNxrHCptW5v/EON575VXiqmB0
         MVOg==
X-Gm-Message-State: AOJu0YzUeyBvl0gap/AnHkL6jVhktnn05Mu2AojU6mJo1g5t+3PMKqGY
	pRh0w3VRCIL4elez21IJtX7Tgorwqf4FnqLbiXTzZA==
X-Google-Smtp-Source: AGHT+IEhhpx7ItaQSqAf/Pm1ZBK3zGtoT55D1UAyMmuA6F3DxODRnWvDdlOFJqII58nuKLNVa1QKyA==
X-Received: by 2002:a05:6a20:8f28:b0:16b:fe93:8da9 with SMTP id b40-20020a056a208f2800b0016bfe938da9mr223236pzk.61.1696570659241;
        Thu, 05 Oct 2023 22:37:39 -0700 (PDT)
Received: from seattlite.sea.i.extrahop.com ([65.155.239.27])
        by smtp.gmail.com with ESMTPSA id k22-20020aa78216000000b0069337938be8sm545666pfi.110.2023.10.05.22.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 22:37:38 -0700 (PDT)
From: Will Mortensen <will@extrahop.com>
To: netdev@vger.kernel.org
Cc: Will Mortensen <will@extrahop.com>,
	Charlotte Tan <charlotte@extrahop.com>,
	Adham Faris <afaris@nvidia.com>,
	Aya Levin <ayal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH] net/mlx5e: Again mutually exclude RX-FCS and RX-port-timestamp
Date: Thu,  5 Oct 2023 22:37:06 -0700
Message-Id: <20231006053706.514618-1-will@extrahop.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 1e66220948df8 ("net/mlx5e: Update rx ring hw mtu upon each rx-fcs
flag change") seems to have accidentally inverted the logic added in
commit 0bc73ad46a76 ("net/mlx5e: Mutually exclude RX-FCS and
RX-port-timestamp").

The impact of this is a little unclear since it seems the FCS scattered
with RX-FCS is (usually?) correct regardless.

Fixes: 1e66220948df8 ("net/mlx5e: Update rx ring hw mtu upon each rx-fcs flag change")
Tested-by: Charlotte Tan <charlotte@extrahop.com>
Reviewed-by: Charlotte Tan <charlotte@extrahop.com>
Cc: Adham Faris <afaris@nvidia.com>
Cc: Aya Levin <ayal@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Moshe Shemesh <moshe@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Will Mortensen <will@extrahop.com>
---
For what it's worth, regardless of this change the PCMR register behaves
unexpectedly in our testing on NICs where rx_ts_over_crc_cap is 1 (i.e.
where rx_ts_over_crc is supported), such as ConnectX-7 running firmware
28.37.1014. For example, fcs_chk is always 0, and rx_ts_over_crc can
never be set to 1 after being set to 0. On ConnectX-5, where
rx_ts_over_crc_cap is 0, fcs_chk behaves as expected.

We'll probably be opening a support case about that after we test more,
but I mention it here because it makes FCS-related testing confusing.

 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a2ae791538ed..acb40770cf0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3952,13 +3952,14 @@ static int set_feature_rx_fcs(struct net_device *netdev, bool enable)
 	struct mlx5e_channels *chs = &priv->channels;
 	struct mlx5e_params new_params;
 	int err;
+	bool rx_ts_over_crc = !enable;
 
 	mutex_lock(&priv->state_lock);
 
 	new_params = chs->params;
 	new_params.scatter_fcs_en = enable;
 	err = mlx5e_safe_switch_params(priv, &new_params, mlx5e_set_rx_port_ts_wrap,
-				       &new_params.scatter_fcs_en, true);
+				       &rx_ts_over_crc, true);
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
-- 
2.34.1


