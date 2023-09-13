Return-Path: <netdev+bounces-33461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E9779E09F
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAA21C20C7C
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372AA18C22;
	Wed, 13 Sep 2023 07:13:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552A19BB4
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:13:05 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFA11728
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:13:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31f7400cb74so5567037f8f.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589183; x=1695193983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FITgGfcIW2lUxPsg1hCS5wkFztspz19RNuZ48xXFM9U=;
        b=KdWql8jMOmuo5y0K152JAfEugoV8ksZhB1v4cEVDzcrkzV0pFhWsm6PcoGOJZcljyP
         9O39OFY8fRwN2B9DmjvwK3nhFqIPzVx7k1R/QGpzCWMIwMDEhqFuift+0At8w9Enptew
         Kq4qrqxq/PLW1tG6g7y6nxzUzSXK8jNsbu/I1oME/XRNLjj/OCbCLI/v8rLM2+JSvrvk
         6eB10nxsaOIMnEMACEvJp/OCoyuhIugth/bPKUZzJOeODWBR430cx1r8bN97JS/QAnCL
         kXsq0/MHZZnjVGXf8OIv/1mL5dHZaPjIFdpolGSk9SHKPg1/asNOLYBXSeNF2LXwidH2
         FpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589183; x=1695193983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FITgGfcIW2lUxPsg1hCS5wkFztspz19RNuZ48xXFM9U=;
        b=BlHjA2b+XNDMcisbLcIOQGeypw+U08vGXkcnDXZ3Z4HNspxO9wwjUf1c08xJPiXLiP
         BJgF1W+rFpAUpR/sKD1UcJ9Hf/RGEQvQ3YOLFKEDVI6yADfBvNnBgar/DZZplve/rYdv
         Le9V9cxnSOhaA9MU8AbyGsWpkvJOwKQfeqc24Y9CNUbyXJURss869D8T4rEHouE0Bo+j
         NCUYQdyMOrahG2qBQZe+UUTUWFTlCDcMRpv8ti8Rdh/goN6xef2c/Hik18WlkHZ7c6Py
         DgRq5UEqbDZAAbWF7VO6+RCucFtslbWPpc92cbw6qEEkQvzEwsXWEQ3EpSjDT5Wbp3pZ
         7ZcQ==
X-Gm-Message-State: AOJu0YxdQaE4q7fKFjk/birBI5Gjcc95RI1PqLG4Zt9VQTybtomzR6Av
	fn1KliskOfjfKo0dqe8ugyuMmHmrBzbmGfpGS8o=
X-Google-Smtp-Source: AGHT+IHjLhkrBJB/tSi5FRW3QQOGbacgY1x6sjSOC3QjTL7tKXbSfHl0CGO/uqwVh/K6skLKltKTDw==
X-Received: by 2002:adf:e350:0:b0:31a:d7ce:927a with SMTP id n16-20020adfe350000000b0031ad7ce927amr1219703wrj.3.1694589182860;
        Wed, 13 Sep 2023 00:13:02 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q28-20020a056000137c00b0031989784d96sm14693616wrz.76.2023.09.13.00.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:13:02 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	idosch@nvidia.com,
	petrm@nvidia.com,
	jacob.e.keller@intel.com,
	moshe@nvidia.com,
	shayd@nvidia.com,
	saeedm@nvidia.com,
	horms@kernel.org
Subject: [patch net-next v2 10/12] devlink: convert linecard nested devlink to new rel infrastructure
Date: Wed, 13 Sep 2023 09:12:41 +0200
Message-ID: <20230913071243.930265-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913071243.930265-1-jiri@resnulli.us>
References: <20230913071243.930265-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Benefit from the newly introduced rel infrastructure, treat the linecard
nested devlink instances in the same way as port function instances.
Convert the code to use the rel infrastructure.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 .../mellanox/mlxsw/core_linecard_dev.c        |  9 ++--
 include/net/devlink.h                         |  4 +-
 net/devlink/linecard.c                        | 47 ++++++++++++++-----
 3 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c b/drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c
index af37e650a8ad..e8d6fe35bf36 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c
@@ -132,6 +132,7 @@ static int mlxsw_linecard_bdev_probe(struct auxiliary_device *adev,
 	struct mlxsw_linecard *linecard = linecard_bdev->linecard;
 	struct mlxsw_linecard_dev *linecard_dev;
 	struct devlink *devlink;
+	int err;
 
 	devlink = devlink_alloc(&mlxsw_linecard_dev_devlink_ops,
 				sizeof(*linecard_dev), &adev->dev);
@@ -141,8 +142,12 @@ static int mlxsw_linecard_bdev_probe(struct auxiliary_device *adev,
 	linecard_dev->linecard = linecard_bdev->linecard;
 	linecard_bdev->linecard_dev = linecard_dev;
 
+	err = devlink_linecard_nested_dl_set(linecard->devlink_linecard, devlink);
+	if (err) {
+		devlink_free(devlink);
+		return err;
+	}
 	devlink_register(devlink);
-	devlink_linecard_nested_dl_set(linecard->devlink_linecard, devlink);
 	return 0;
 }
 
@@ -151,9 +156,7 @@ static void mlxsw_linecard_bdev_remove(struct auxiliary_device *adev)
 	struct mlxsw_linecard_bdev *linecard_bdev =
 			container_of(adev, struct mlxsw_linecard_bdev, adev);
 	struct devlink *devlink = priv_to_devlink(linecard_bdev->linecard_dev);
-	struct mlxsw_linecard *linecard = linecard_bdev->linecard;
 
-	devlink_linecard_nested_dl_set(linecard->devlink_linecard, NULL);
 	devlink_unregister(devlink);
 	devlink_free(devlink);
 }
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 2655ab6101ec..0dfcd7d7fa18 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1720,8 +1720,8 @@ void devlink_linecard_provision_clear(struct devlink_linecard *linecard);
 void devlink_linecard_provision_fail(struct devlink_linecard *linecard);
 void devlink_linecard_activate(struct devlink_linecard *linecard);
 void devlink_linecard_deactivate(struct devlink_linecard *linecard);
-void devlink_linecard_nested_dl_set(struct devlink_linecard *linecard,
-				    struct devlink *nested_devlink);
+int devlink_linecard_nested_dl_set(struct devlink_linecard *linecard,
+				   struct devlink *nested_devlink);
 int devl_sb_register(struct devlink *devlink, unsigned int sb_index,
 		     u32 size, u16 ingress_pools_count,
 		     u16 egress_pools_count, u16 ingress_tc_count,
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index 36170f466878..9ff1813f88c5 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -17,7 +17,7 @@ struct devlink_linecard {
 	const char *type;
 	struct devlink_linecard_type *types;
 	unsigned int types_count;
-	struct devlink *nested_devlink;
+	u32 rel_index;
 };
 
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard)
@@ -112,10 +112,10 @@ static int devlink_nl_linecard_fill(struct sk_buff *msg,
 		nla_nest_end(msg, attr);
 	}
 
-	if (linecard->nested_devlink &&
-	    devlink_nl_put_nested_handle(msg, devlink_net(devlink),
-					 linecard->nested_devlink,
-					 DEVLINK_ATTR_NESTED_DEVLINK))
+	if (devlink_rel_devlink_handle_put(msg, devlink,
+					   linecard->rel_index,
+					   DEVLINK_ATTR_NESTED_DEVLINK,
+					   NULL))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
@@ -524,7 +524,6 @@ EXPORT_SYMBOL_GPL(devlink_linecard_provision_set);
 void devlink_linecard_provision_clear(struct devlink_linecard *linecard)
 {
 	mutex_lock(&linecard->state_lock);
-	WARN_ON(linecard->nested_devlink);
 	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
 	linecard->type = NULL;
 	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
@@ -543,7 +542,6 @@ EXPORT_SYMBOL_GPL(devlink_linecard_provision_clear);
 void devlink_linecard_provision_fail(struct devlink_linecard *linecard)
 {
 	mutex_lock(&linecard->state_lock);
-	WARN_ON(linecard->nested_devlink);
 	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONING_FAILED;
 	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
 	mutex_unlock(&linecard->state_lock);
@@ -591,6 +589,27 @@ void devlink_linecard_deactivate(struct devlink_linecard *linecard)
 }
 EXPORT_SYMBOL_GPL(devlink_linecard_deactivate);
 
+static void devlink_linecard_rel_notify_cb(struct devlink *devlink,
+					   u32 linecard_index)
+{
+	struct devlink_linecard *linecard;
+
+	linecard = devlink_linecard_get_by_index(devlink, linecard_index);
+	if (!linecard)
+		return;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+}
+
+static void devlink_linecard_rel_cleanup_cb(struct devlink *devlink,
+					    u32 linecard_index, u32 rel_index)
+{
+	struct devlink_linecard *linecard;
+
+	linecard = devlink_linecard_get_by_index(devlink, linecard_index);
+	if (linecard && linecard->rel_index == rel_index)
+		linecard->rel_index = 0;
+}
+
 /**
  *	devlink_linecard_nested_dl_set - Attach/detach nested devlink
  *					 instance to linecard.
@@ -598,12 +617,14 @@ EXPORT_SYMBOL_GPL(devlink_linecard_deactivate);
  *	@linecard: devlink linecard
  *	@nested_devlink: devlink instance to attach or NULL to detach
  */
-void devlink_linecard_nested_dl_set(struct devlink_linecard *linecard,
-				    struct devlink *nested_devlink)
+int devlink_linecard_nested_dl_set(struct devlink_linecard *linecard,
+				   struct devlink *nested_devlink)
 {
-	mutex_lock(&linecard->state_lock);
-	linecard->nested_devlink = nested_devlink;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
+	return devlink_rel_nested_in_add(&linecard->rel_index,
+					 linecard->devlink->index,
+					 linecard->index,
+					 devlink_linecard_rel_notify_cb,
+					 devlink_linecard_rel_cleanup_cb,
+					 nested_devlink);
 }
 EXPORT_SYMBOL_GPL(devlink_linecard_nested_dl_set);
-- 
2.41.0


