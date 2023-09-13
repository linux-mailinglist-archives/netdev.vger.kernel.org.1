Return-Path: <netdev+bounces-33460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0DA79E09B
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E2A281B02
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B602918C34;
	Wed, 13 Sep 2023 07:13:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A718C22
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:13:03 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B443D1728
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:13:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401f68602a8so70190085e9.3
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589181; x=1695193981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8ziZqPNFzCo0A/K8YJyf25Kw4mrfTiAr0OWYfFnf4A=;
        b=FtPTmgE1SrXOrzWya43pLqMwiYHqbkFOVMSWfxDv1bDVyVjN+PKOlO2hGZfh1PYa2N
         WR/HHoWP/piXIpJNM/vUibYatdwjXBNXg7r6NTXa1REv5a73xXuitRoqjwyITA7dPGbN
         DRN1V8q9Hm809FJEo/deRJd2OTab6DJ5g/qwsZsVfkTxF79XdoB9O+EusgJ+si8fufYO
         6SM71Lb9KlVG30rgIiccPIW/rWtrin/JoufaZYhSIGiAbj08/WwwOH03b6KzlLb+vhmN
         dA10SdVT3xgPZBrjNKUcZCx0pKcxlUsizEBgxrih7VMfekBN3z0FpzRnJezCT5zQefRF
         WTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589181; x=1695193981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8ziZqPNFzCo0A/K8YJyf25Kw4mrfTiAr0OWYfFnf4A=;
        b=DFdFWMgdO8D5jYCVUpf+u4Y2Nxv8koujrue/P5B0N2W54VC2ahZA1qBwUxgv+I9wY1
         gT9tNruwd0m6w2dcBvbVLq+QFBD3BFOYQB6BjwPu7Fw9+OW8j6PwAuXzfRNzO029Ikgd
         eQpv+lg+pLPoWUxwvZJj2RnSghLJbE7u2fiywMpQ2TNvzHsFxr7pYwh6LTKcy+EtJ4Cy
         TR+wU/2WgBPyOYxdzb+T02NvavvpGMqxdLHxyPJSO2j53kQEzP4hIVfWPZ9o2TqQaJa3
         pJX2XnRh21RPq5azN20CakMKMM5Jh4ar25BzNSSJXoEMPHZJfW+H6TE7BNZeJVCudeVM
         t2YA==
X-Gm-Message-State: AOJu0Yz3XTvxco/57UkWdxAJ6WYZSuOROtozfIkbn2vO56FGvDs0KKjP
	VerwYGLvu2FVktdsF0yrB/VxqgfiKkdtXx7FLLs=
X-Google-Smtp-Source: AGHT+IEPyJ+Xq23VL7wKfNE4KR2dpfA9us2ADwQNId/OMbHy3H5wzv+Ji43/HvBCvWCgZ8OuJJkllA==
X-Received: by 2002:a05:600c:1e1d:b0:401:cdc1:ac82 with SMTP id ay29-20020a05600c1e1d00b00401cdc1ac82mr1251221wmb.9.1694589181260;
        Wed, 13 Sep 2023 00:13:01 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c021800b003fefe70ec9csm1134194wmi.10.2023.09.13.00.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:13:00 -0700 (PDT)
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
Subject: [patch net-next v2 09/12] net/mlx5: SF, Implement peer devlink set for SF representor devlink port
Date: Wed, 13 Sep 2023 09:12:40 +0200
Message-ID: <20230913071243.930265-10-jiri@resnulli.us>
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

Benefit from the existence of internal mlx5 notifier and extend it by
event MLX5_DRIVER_EVENT_SF_PEER_DEVLINK. Use this event from SF
auxiliary device probe/remove functions to pass the registered SF
devlink instance to the SF representor.

Process the new event in SF representor code and call
devl_port_fn_devlink_set() to do the assignments. Implement this in work
to avoid possible deadlock when probe/remove function of SF may be
called with devlink instance lock held during devlink reload.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- rebased on top of net-next
- removed work code as devl_port_fn_devlink_set() could be called
  without instance lock
- propagate return code newly returned by devl_port_fn_devlink_set()
---
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.h  |  6 ++++
 .../mellanox/mlx5/core/sf/dev/driver.c        | 26 ++++++++++++++
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  | 34 +++++++++++++++++++
 include/linux/mlx5/device.h                   |  1 +
 4 files changed, 67 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.h
index 2a66a427ef15..b99131e95e37 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.h
@@ -19,6 +19,12 @@ struct mlx5_sf_dev {
 	u16 fn_id;
 };
 
+struct mlx5_sf_peer_devlink_event_ctx {
+	u16 fn_id;
+	struct devlink *devlink;
+	int err;
+};
+
 void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev);
 void mlx5_sf_dev_table_destroy(struct mlx5_core_dev *dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index 8fe82f1191bb..169c2c68ed5c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -8,6 +8,20 @@
 #include "dev.h"
 #include "devlink.h"
 
+static int mlx5_core_peer_devlink_set(struct mlx5_sf_dev *sf_dev, struct devlink *devlink)
+{
+	struct mlx5_sf_peer_devlink_event_ctx event_ctx = {
+		.fn_id = sf_dev->fn_id,
+		.devlink = devlink,
+	};
+	int ret;
+
+	ret = mlx5_blocking_notifier_call_chain(sf_dev->parent_mdev,
+						MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
+						&event_ctx);
+	return ret == NOTIFY_OK ? event_ctx.err : 0;
+}
+
 static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxiliary_device_id *id)
 {
 	struct mlx5_sf_dev *sf_dev = container_of(adev, struct mlx5_sf_dev, adev);
@@ -54,9 +68,21 @@ static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxilia
 		mlx5_core_warn(mdev, "mlx5_init_one err=%d\n", err);
 		goto init_one_err;
 	}
+
+	err = mlx5_core_peer_devlink_set(sf_dev, devlink);
+	if (err) {
+		mlx5_core_warn(mdev, "mlx5_core_peer_devlink_set err=%d\n", err);
+		goto peer_devlink_set_err;
+	}
+
 	devlink_register(devlink);
 	return 0;
 
+peer_devlink_set_err:
+	if (mlx5_dev_is_lightweight(sf_dev->mdev))
+		mlx5_uninit_one_light(sf_dev->mdev);
+	else
+		mlx5_uninit_one(sf_dev->mdev);
 init_one_err:
 	iounmap(mdev->iseg);
 remap_err:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index e34a8f88c518..964a5b1876f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -28,6 +28,7 @@ struct mlx5_sf_table {
 	struct mutex sf_state_lock; /* Serializes sf state among user cmds & vhca event handler. */
 	struct notifier_block esw_nb;
 	struct notifier_block vhca_nb;
+	struct notifier_block mdev_nb;
 };
 
 static struct mlx5_sf *
@@ -511,6 +512,35 @@ static int mlx5_sf_esw_event(struct notifier_block *nb, unsigned long event, voi
 	return 0;
 }
 
+static int mlx5_sf_mdev_event(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct mlx5_sf_table *table = container_of(nb, struct mlx5_sf_table, mdev_nb);
+	struct mlx5_sf_peer_devlink_event_ctx *event_ctx = data;
+	int ret = NOTIFY_DONE;
+	struct mlx5_sf *sf;
+
+	if (event != MLX5_DRIVER_EVENT_SF_PEER_DEVLINK)
+		return NOTIFY_DONE;
+
+	table = mlx5_sf_table_try_get(table->dev);
+	if (!table)
+		return NOTIFY_DONE;
+
+	mutex_lock(&table->sf_state_lock);
+	sf = mlx5_sf_lookup_by_function_id(table, event_ctx->fn_id);
+	if (!sf)
+		goto out;
+
+	event_ctx->err = devl_port_fn_devlink_set(&sf->dl_port.dl_port,
+						  event_ctx->devlink);
+
+	ret = NOTIFY_OK;
+out:
+	mutex_unlock(&table->sf_state_lock);
+	mlx5_sf_table_put(table);
+	return ret;
+}
+
 static bool mlx5_sf_table_supported(const struct mlx5_core_dev *dev)
 {
 	return dev->priv.eswitch && MLX5_ESWITCH_MANAGER(dev) &&
@@ -544,6 +574,9 @@ int mlx5_sf_table_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto vhca_err;
 
+	table->mdev_nb.notifier_call = mlx5_sf_mdev_event;
+	mlx5_blocking_notifier_register(dev, &table->mdev_nb);
+
 	return 0;
 
 vhca_err:
@@ -562,6 +595,7 @@ void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
 	if (!table)
 		return;
 
+	mlx5_blocking_notifier_unregister(dev, &table->mdev_nb);
 	mlx5_vhca_event_notifier_unregister(table->dev, &table->vhca_nb);
 	mlx5_esw_event_notifier_unregister(dev->priv.eswitch, &table->esw_nb);
 	WARN_ON(refcount_read(&table->refcount));
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 4d5be378fa8c..8fbe22de16ef 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -366,6 +366,7 @@ enum mlx5_driver_event {
 	MLX5_DRIVER_EVENT_UPLINK_NETDEV,
 	MLX5_DRIVER_EVENT_MACSEC_SA_ADDED,
 	MLX5_DRIVER_EVENT_MACSEC_SA_DELETED,
+	MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
 };
 
 enum {
-- 
2.41.0


