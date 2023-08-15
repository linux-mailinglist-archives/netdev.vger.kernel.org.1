Return-Path: <netdev+bounces-27697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4A977CE7A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A69281440
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C29D13AE7;
	Tue, 15 Aug 2023 14:52:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FCC14270
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 14:52:09 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B219BF
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:52:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so54896515e9.2
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692111121; x=1692715921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7StQvKqkD/ig3WWtJjQD+rWxMN/0SjBGTnb9BrUQXs=;
        b=UHfb9+xtlzdV/7pP80ZydLcMitH1rFnlv3QPLPf6RhH3vB9/OwAQPTxi2jBNDv90IM
         dbIPnCVFoeZ+CjZsQjO05Q9vq9kGwTYvn7L8A++yyxyGcGnRlHCgm3Qe7ryo+3Tk3qaY
         SW4QtRxE6bpxSLrBBQ0vegvZofpZEbARTSoqIlXL2yiqNi7a0WSwjlcIstGtkHL/U5gT
         VDvaMonUnlO/qpcv2F4wpr2p/4oBrI7A5/Qo3xsvYW+gYaZxRVrEyO1VkDQwN7BvyYPZ
         DtpY2aLDte+6ORe6Y8yz7dMCKY9hXIyK0D8oWQWEKB8J0fQosbBULScSpkwX7MyU32oe
         0xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692111121; x=1692715921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7StQvKqkD/ig3WWtJjQD+rWxMN/0SjBGTnb9BrUQXs=;
        b=ipRVHzjU9WYtJK6zAM68YcOfof9V5Grf5AdS2vGPu000VZtya1wkWq1WM1skt/B3if
         IqswaY+Bkp5M2v0L+ezqXqHlGql6dooTyTgLQ/ro12Zuhec7M7fj7rVv1bKvaX3cV4lv
         OV1LKgJOtnjAu3Mf6gw3AgEM3943SuKEWzhsNNlh1te7viz9M8Q91F1IAuyiDvveefW1
         lb54aSPR+rl5bbftAG2FQJhcCcPojMe86wMguuOtrYnI6EZ/lD2RwqHNteXqM2NCHxHO
         Yh9+fz0mu5vvnCFJQxmp9VsVEWF4XlT9sCpUhbVjh0jYqp8ZtJODB1KUB/kSKcfnR7nW
         /VEg==
X-Gm-Message-State: AOJu0YxyTUjVsPDsbf4LrKJDDav88OmKRrr2o+VHcGAoXaBWa0Ma8T9O
	eSWrlpdvqhzykK2akdRhgbdfDhzIGoHkk30EfoFABBHg
X-Google-Smtp-Source: AGHT+IH8qwweIIa6kGpsITVVxAczYdG8ux6KM2OO6dFLTZbUR5a3BB/p5ispFfTUgx6Rx0dJKi+RKQ==
X-Received: by 2002:adf:ef02:0:b0:317:3c89:7f03 with SMTP id e2-20020adfef02000000b003173c897f03mr10002815wro.5.1692111120736;
        Tue, 15 Aug 2023 07:52:00 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id t25-20020a1c7719000000b003fe4ca8decdsm21022031wmi.31.2023.08.15.07.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:52:00 -0700 (PDT)
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
Subject: [patch net-next 2/4] net/mlx5: Lift reload limitation when SFs are present
Date: Tue, 15 Aug 2023 16:51:53 +0200
Message-ID: <20230815145155.1946926-3-jiri@resnulli.us>
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
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Historically, the shared devlink_mutex prevented devlink instances from
being registered/unregistered during another devlink instance reload
operation. However, devlink_muxex is gone for some time now, this
limitation is no longer needed. Lift it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 3d82ec890666..6eea65686c14 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -138,7 +138,6 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	struct pci_dev *pdev = dev->pdev;
-	bool sf_dev_allocated;
 	int ret = 0;
 
 	if (mlx5_dev_is_lightweight(dev)) {
@@ -148,16 +147,6 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 		return 0;
 	}
 
-	sf_dev_allocated = mlx5_sf_dev_allocated(dev);
-	if (sf_dev_allocated) {
-		/* Reload results in deleting SF device which further results in
-		 * unregistering devlink instance while holding devlink_mutext.
-		 * Hence, do not support reload.
-		 */
-		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported when SFs are allocated");
-		return -EOPNOTSUPP;
-	}
-
 	if (mlx5_lag_is_active(dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported in Lag mode");
 		return -EOPNOTSUPP;
-- 
2.41.0


