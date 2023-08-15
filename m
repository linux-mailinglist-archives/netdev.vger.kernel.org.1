Return-Path: <netdev+bounces-27699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3A77CE82
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295C21C20D91
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC913AEF;
	Tue, 15 Aug 2023 14:52:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C914AA4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 14:52:15 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432561737
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:52:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso83467851fa.0
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692111124; x=1692715924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Qjd/sm0WDyLfJrhyXPh4PnDUSuxLyKwf3hwfnGNrmA=;
        b=gBtkVkvAE0RSZER36vp9fogxMRc14mwbUOnvLuAuUv561YS5Cvh9c6+KbXoPAep+EM
         bb214gKYblEETKbsE8sRvdTmWAa4Yzmc3kXaEf/HZH8YmEapkRJPK9ob0/YhK+1maJxp
         pYcbKo0Nxft+VvRCUcGbXV2t02FzYWxrh8yDTFCQkyoSG+6VZ3BFnvCNjzcZ/ViJA7jG
         VPfw8FG7lT9BoVhEW3VQNjWHp5YWRIfxn57x5FI3V/oDeRsieCxNSV8XjqoXFFoC1JJ6
         om0b+k0UX1oAcbRLdK1Jjew2+w8kwD3DuahQ0FXUDmCl1DCiTYsQ8rxJyAp/NfqJEewN
         aRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692111124; x=1692715924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Qjd/sm0WDyLfJrhyXPh4PnDUSuxLyKwf3hwfnGNrmA=;
        b=iMx8WtyavLz5PUVUgvUtAUEASDBXs82GvmoQ0xF+Shoa0hYSZyjOKePz2i6QfdGAZU
         2V/Xklg65dfsQo7gge93netmqQk3aUVebXgKMvTjaRq753AuYv4ezjT0pCixZjSInppL
         L93SCJ+LzV9+y1xJRvCW2K0eOadtQ8JW77lquaDNrXLbF7+1lFODyzDQr3xJvN1APi+G
         UEeVoqk6xuTz8j8nzoM6MKhNWcktskReq+9kIm93pISNbSTEgUF8rQi2DfzYrjefb7ku
         pbqaH+xaicIiha1BJNxmM9Pmv78uR/McrW5yc/lrVr6uwZFmNboNfHENEEK0Au2MQXc3
         dvgg==
X-Gm-Message-State: AOJu0YxtQw1JgwEJyOo4AOWhvLvEqGExLut7g5M8Y0RUA5hYUTKmr49K
	WF7JeaZzYGUKkTpqbtaCt09UE5Uo0dIMqlV8gXtNM+2f
X-Google-Smtp-Source: AGHT+IFGbh3ABAoKUgySJhmA4aSYKebk+o4rkZN7OO20eNVciU/Naj9yfgoQ4qZ3NFFaWvyqB3T5hQ==
X-Received: by 2002:a2e:9642:0:b0:2b8:39e4:2e2c with SMTP id z2-20020a2e9642000000b002b839e42e2cmr9333494ljh.1.1692111124361;
        Tue, 15 Aug 2023 07:52:04 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003fd2d33ea53sm17896347wmj.14.2023.08.15.07.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:52:03 -0700 (PDT)
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
Subject: [patch net-next 4/4] net/mlx5: SF, Implement peer devlink set for SF representor devlink port
Date: Tue, 15 Aug 2023 16:51:55 +0200
Message-ID: <20230815145155.1946926-5-jiri@resnulli.us>
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
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.h  |  5 ++
 .../mellanox/mlx5/core/sf/dev/driver.c        | 14 ++++
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  | 75 +++++++++++++++++++
 include/linux/mlx5/device.h                   |  1 +
 4 files changed, 95 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.h
index 2a66a427ef15..c2e3277a418a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.h
@@ -19,6 +19,11 @@ struct mlx5_sf_dev {
 	u16 fn_id;
 };
 
+struct mlx5_sf_peer_devlink_event_info {
+	u16 fn_id;
+	struct devlink *devlink;
+};
+
 void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev);
 void mlx5_sf_dev_table_destroy(struct mlx5_core_dev *dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index 8fe82f1191bb..7e45b338eb54 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -8,6 +8,18 @@
 #include "dev.h"
 #include "devlink.h"
 
+static void mlx5_core_peer_devlink_set(struct mlx5_sf_dev *sf_dev, struct devlink *devlink)
+{
+	struct mlx5_sf_peer_devlink_event_info event_info = {
+		.fn_id = sf_dev->fn_id,
+		.devlink = devlink,
+	};
+
+	mlx5_blocking_notifier_call_chain(sf_dev->parent_mdev,
+					  MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
+					  &event_info);
+}
+
 static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxiliary_device_id *id)
 {
 	struct mlx5_sf_dev *sf_dev = container_of(adev, struct mlx5_sf_dev, adev);
@@ -55,6 +67,7 @@ static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxilia
 		goto init_one_err;
 	}
 	devlink_register(devlink);
+	mlx5_core_peer_devlink_set(sf_dev, devlink);
 	return 0;
 
 init_one_err:
@@ -72,6 +85,7 @@ static void mlx5_sf_dev_remove(struct auxiliary_device *adev)
 	struct devlink *devlink = priv_to_devlink(sf_dev->mdev);
 
 	mlx5_drain_health_wq(sf_dev->mdev);
+	mlx5_core_peer_devlink_set(sf_dev, NULL);
 	devlink_unregister(devlink);
 	if (mlx5_dev_is_lightweight(sf_dev->mdev))
 		mlx5_uninit_one_light(sf_dev->mdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 6a3fa30b2bf2..06753032a9f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -18,6 +18,10 @@ struct mlx5_sf {
 	u16 id;
 	u16 hw_fn_id;
 	u16 hw_state;
+	struct mlx5_core_dev *dev;
+	struct work_struct peer_devlink_set_work;
+	bool peer_devlink_set_work_disabled;
+	struct devlink *peer_devlink;
 };
 
 struct mlx5_sf_table {
@@ -28,6 +32,7 @@ struct mlx5_sf_table {
 	struct mutex sf_state_lock; /* Serializes sf state among user cmds & vhca event handler. */
 	struct notifier_block esw_nb;
 	struct notifier_block vhca_nb;
+	struct notifier_block mdev_nb;
 };
 
 static struct mlx5_sf *
@@ -59,6 +64,36 @@ static void mlx5_sf_id_erase(struct mlx5_sf_table *table, struct mlx5_sf *sf)
 	xa_erase(&table->port_indices, sf->port_index);
 }
 
+static void mlx5_sf_peer_devlink_set_work_flush(struct mlx5_sf *sf)
+{
+	flush_work(&sf->peer_devlink_set_work);
+}
+
+static void mlx5_sf_peer_devlink_set_work_queue(struct mlx5_sf *sf)
+{
+	if (sf->peer_devlink_set_work_disabled)
+		return;
+	mlx5_events_work_enqueue(sf->dev, &sf->peer_devlink_set_work);
+}
+
+static void mlx5_sf_peer_devlink_set_work_disable(struct mlx5_sf *sf)
+{
+	sf->peer_devlink_set_work_disabled = true;
+	cancel_work_sync(&sf->peer_devlink_set_work);
+}
+
+static void mlx5_sf_peer_devlink_set_work(struct work_struct *work)
+{
+	struct mlx5_sf *sf = container_of(work, struct mlx5_sf, peer_devlink_set_work);
+
+	if (!devl_trylock(sf->dl_port.devlink)) {
+		mlx5_sf_peer_devlink_set_work_queue(sf);
+		return;
+	}
+	devl_port_fn_devlink_set(&sf->dl_port, sf->peer_devlink);
+	devl_unlock(sf->dl_port.devlink);
+}
+
 static struct mlx5_sf *
 mlx5_sf_alloc(struct mlx5_sf_table *table, struct mlx5_eswitch *esw,
 	      u32 controller, u32 sfnum, struct netlink_ext_ack *extack)
@@ -93,6 +128,9 @@ mlx5_sf_alloc(struct mlx5_sf_table *table, struct mlx5_eswitch *esw,
 	sf->hw_state = MLX5_VHCA_STATE_ALLOCATED;
 	sf->controller = controller;
 
+	sf->dev = table->dev;
+	INIT_WORK(&sf->peer_devlink_set_work, &mlx5_sf_peer_devlink_set_work);
+
 	err = mlx5_sf_id_insert(table, sf);
 	if (err)
 		goto insert_err;
@@ -296,6 +334,7 @@ static int mlx5_sf_add(struct mlx5_core_dev *dev, struct mlx5_sf_table *table,
 						new_attr->controller, new_attr->sfnum);
 	if (err)
 		goto esw_err;
+
 	*dl_port = &sf->dl_port;
 	trace_mlx5_sf_add(dev, sf->port_index, sf->controller, sf->hw_fn_id, new_attr->sfnum);
 	return 0;
@@ -400,6 +439,7 @@ int mlx5_devlink_sf_port_del(struct devlink *devlink,
 		goto sf_err;
 	}
 
+	mlx5_sf_peer_devlink_set_work_disable(sf);
 	mlx5_esw_offloads_sf_vport_disable(esw, sf->hw_fn_id);
 	mlx5_sf_id_erase(table, sf);
 
@@ -472,6 +512,7 @@ static void mlx5_sf_deactivate_all(struct mlx5_sf_table *table)
 	 * arrive. It is safe to destroy all user created SFs.
 	 */
 	xa_for_each(&table->port_indices, index, sf) {
+		mlx5_sf_peer_devlink_set_work_disable(sf);
 		mlx5_esw_offloads_sf_vport_disable(esw, sf->hw_fn_id);
 		mlx5_sf_id_erase(table, sf);
 		mlx5_sf_dealloc(table, sf);
@@ -511,6 +552,36 @@ static int mlx5_sf_esw_event(struct notifier_block *nb, unsigned long event, voi
 	return 0;
 }
 
+static int mlx5_sf_mdev_event(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct mlx5_sf_table *table = container_of(nb, struct mlx5_sf_table, mdev_nb);
+	struct mlx5_sf_peer_devlink_event_info *event_info = data;
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
+	sf = mlx5_sf_lookup_by_function_id(table, event_info->fn_id);
+	if (!sf)
+		goto out;
+
+	mlx5_sf_peer_devlink_set_work_flush(sf);
+	sf->peer_devlink = event_info->devlink;
+	mlx5_sf_peer_devlink_set_work_queue(sf);
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
@@ -544,6 +615,9 @@ int mlx5_sf_table_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto vhca_err;
 
+	table->mdev_nb.notifier_call = mlx5_sf_mdev_event;
+	mlx5_blocking_notifier_register(dev, &table->mdev_nb);
+
 	return 0;
 
 vhca_err:
@@ -562,6 +636,7 @@ void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
 	if (!table)
 		return;
 
+	mlx5_blocking_notifier_unregister(dev, &table->mdev_nb);
 	mlx5_vhca_event_notifier_unregister(table->dev, &table->vhca_nb);
 	mlx5_esw_event_notifier_unregister(dev->priv.eswitch, &table->esw_nb);
 	WARN_ON(refcount_read(&table->refcount));
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 80cc12a9a531..2473743f36b2 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -364,6 +364,7 @@ enum mlx5_event {
 enum mlx5_driver_event {
 	MLX5_DRIVER_EVENT_TYPE_TRAP = 0,
 	MLX5_DRIVER_EVENT_UPLINK_NETDEV,
+	MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
 };
 
 enum {
-- 
2.41.0


