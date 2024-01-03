Return-Path: <netdev+bounces-61216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B79822E3F
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C751C2360C
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15419199BC;
	Wed,  3 Jan 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Zs0K0cAK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A119BB9
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3366e78d872so10071921f8f.3
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 05:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704288523; x=1704893323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcA4jVJYDBfmk+eqKjn4n+DKnfGhrfHTR6Of6MZRBlM=;
        b=Zs0K0cAKIWy4Sn132bdB0Uw3C43ktgJiytJKfD2k3MGnNAyoPqmWFSJdqu8NabP9Qy
         CE7dhWMvV8Padq+8Ke8IBssGU2/ITZyZV69gHWXBwuxGwBZpiVPQwTHm5troY88hv5EU
         Bz3Lb4McUyIV26tBHBIRbHR/uZccdd7pA4BRQQdcDhfwZVa7mDsnn2g6OoTa5F0uRhJl
         JCOHXonQDCG7tMtEjwLnCt8dSzz2kt3hcrFlX4zJgVVcmCAcaqWDIG6uN82ayZ/8iF/W
         RvwUrmcVxeepBIFcsmgF+dlSIER0B4R7ru9OVVregKQ09gNtY8iyUHnwFmD4Ol5Qq6uc
         UFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704288523; x=1704893323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcA4jVJYDBfmk+eqKjn4n+DKnfGhrfHTR6Of6MZRBlM=;
        b=R8+Gpedd8ByRqDp/9DdRuvnJiIKjVvlM6SLuk7atTVrWtk32HyJLqcUwgkNOP4vZbX
         sg6vvE3U4mqHl7T0YZJrg0PXB5IrBNW1kvRPGzF5l+s5RQuknh5OUX8UEq51s0rfResk
         QAn5b0udrWHQMM3bDpk7oVMNt0zsgo0VmhyVUbmWRCrubaPzFbxT72mnUiKdAnX6lVDy
         oDHvM+OOOIg4XkftMGgsXMbMo3416MHZ1U58e4nfTRWbcHoxtKtj52BT640PTds+a9YJ
         6H228UZr+ZK89mTSET7/nUAPD2m5CqRFLzxwyRvT1MIExhcI0mLxAgAj1IdGExIePzZr
         zFSQ==
X-Gm-Message-State: AOJu0YwrntoHIaw3O8a0tJmzrLCVLuNkVuxJPvsjTuW/wt3NmHa0jbid
	qahtQxO3YKoW4x8MXF/Lf62tiNLopc1GpL/RkQOnKQOaQuFTAQ==
X-Google-Smtp-Source: AGHT+IHb3eW0L8dNvs1YZHn9sgD7NDWsWoPiANXKvyN24ld/aPMQo3j1GD43Udbes8fap46S1Nb9KA==
X-Received: by 2002:a05:6000:1565:b0:336:c32e:5aec with SMTP id 5-20020a056000156500b00336c32e5aecmr3747303wrz.211.1704288522905;
        Wed, 03 Jan 2024 05:28:42 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b0033725783839sm12581365wrr.110.2024.01.03.05.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:28:42 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	michal.michalik@intel.com,
	rrameshbabu@nvidia.com
Subject: [patch net-next 2/3] net/mlx5: DPLL, Use struct to get values from mlx5_dpll_synce_status_get()
Date: Wed,  3 Jan 2024 14:28:37 +0100
Message-ID: <20240103132838.1501801-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103132838.1501801-1-jiri@resnulli.us>
References: <20240103132838.1501801-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of passing separate args, introduce
struct mlx5_dpll_synce_status to hold the values obtained by
mlx5_dpll_synce_status_get().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 63 +++++++++----------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index a7ffd61fe248..dbe09d2f2069 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -36,11 +36,15 @@ static int mlx5_dpll_clock_id_get(struct mlx5_core_dev *mdev, u64 *clock_id)
 	return 0;
 }
 
+struct mlx5_dpll_synce_status {
+	enum mlx5_msees_admin_status admin_status;
+	enum mlx5_msees_oper_status oper_status;
+	bool ho_acq;
+};
+
 static int
 mlx5_dpll_synce_status_get(struct mlx5_core_dev *mdev,
-			   enum mlx5_msees_admin_status *admin_status,
-			   enum mlx5_msees_oper_status *oper_status,
-			   bool *ho_acq)
+			   struct mlx5_dpll_synce_status *synce_status)
 {
 	u32 out[MLX5_ST_SZ_DW(msees_reg)] = {};
 	u32 in[MLX5_ST_SZ_DW(msees_reg)] = {};
@@ -50,11 +54,9 @@ mlx5_dpll_synce_status_get(struct mlx5_core_dev *mdev,
 				   MLX5_REG_MSEES, 0, 0);
 	if (err)
 		return err;
-	if (admin_status)
-		*admin_status = MLX5_GET(msees_reg, out, admin_status);
-	*oper_status = MLX5_GET(msees_reg, out, oper_status);
-	if (ho_acq)
-		*ho_acq = MLX5_GET(msees_reg, out, ho_acq);
+	synce_status->admin_status = MLX5_GET(msees_reg, out, admin_status);
+	synce_status->oper_status = MLX5_GET(msees_reg, out, oper_status);
+	synce_status->ho_acq = MLX5_GET(msees_reg, out, ho_acq);
 	return 0;
 }
 
@@ -74,14 +76,14 @@ mlx5_dpll_synce_status_set(struct mlx5_core_dev *mdev,
 }
 
 static enum dpll_lock_status
-mlx5_dpll_lock_status_get(enum mlx5_msees_oper_status oper_status, bool ho_acq)
+mlx5_dpll_lock_status_get(struct mlx5_dpll_synce_status *synce_status)
 {
-	switch (oper_status) {
+	switch (synce_status->oper_status) {
 	case MLX5_MSEES_OPER_STATUS_SELF_TRACK:
 		fallthrough;
 	case MLX5_MSEES_OPER_STATUS_OTHER_TRACK:
-		return ho_acq ? DPLL_LOCK_STATUS_LOCKED_HO_ACQ :
-				DPLL_LOCK_STATUS_LOCKED;
+		return synce_status->ho_acq ? DPLL_LOCK_STATUS_LOCKED_HO_ACQ :
+					      DPLL_LOCK_STATUS_LOCKED;
 	case MLX5_MSEES_OPER_STATUS_HOLDOVER:
 		fallthrough;
 	case MLX5_MSEES_OPER_STATUS_FAIL_HOLDOVER:
@@ -92,12 +94,11 @@ mlx5_dpll_lock_status_get(enum mlx5_msees_oper_status oper_status, bool ho_acq)
 }
 
 static enum dpll_pin_state
-mlx5_dpll_pin_state_get(enum mlx5_msees_admin_status admin_status,
-			enum mlx5_msees_oper_status oper_status)
+mlx5_dpll_pin_state_get(struct mlx5_dpll_synce_status *synce_status)
 {
-	return (admin_status == MLX5_MSEES_ADMIN_STATUS_TRACK &&
-		(oper_status == MLX5_MSEES_OPER_STATUS_SELF_TRACK ||
-		 oper_status == MLX5_MSEES_OPER_STATUS_OTHER_TRACK)) ?
+	return (synce_status->admin_status == MLX5_MSEES_ADMIN_STATUS_TRACK &&
+		(synce_status->oper_status == MLX5_MSEES_OPER_STATUS_SELF_TRACK ||
+		 synce_status->oper_status == MLX5_MSEES_OPER_STATUS_OTHER_TRACK)) ?
 	       DPLL_PIN_STATE_CONNECTED : DPLL_PIN_STATE_DISCONNECTED;
 }
 
@@ -106,17 +107,14 @@ static int mlx5_dpll_device_lock_status_get(const struct dpll_device *dpll,
 					    enum dpll_lock_status *status,
 					    struct netlink_ext_ack *extack)
 {
-	enum mlx5_msees_oper_status oper_status;
+	struct mlx5_dpll_synce_status synce_status;
 	struct mlx5_dpll *mdpll = priv;
-	bool ho_acq;
 	int err;
 
-	err = mlx5_dpll_synce_status_get(mdpll->mdev, NULL,
-					 &oper_status, &ho_acq);
+	err = mlx5_dpll_synce_status_get(mdpll->mdev, &synce_status);
 	if (err)
 		return err;
-
-	*status = mlx5_dpll_lock_status_get(oper_status, ho_acq);
+	*status = mlx5_dpll_lock_status_get(&synce_status);
 	return 0;
 }
 
@@ -151,16 +149,14 @@ static int mlx5_dpll_state_on_dpll_get(const struct dpll_pin *pin,
 				       enum dpll_pin_state *state,
 				       struct netlink_ext_ack *extack)
 {
-	enum mlx5_msees_admin_status admin_status;
-	enum mlx5_msees_oper_status oper_status;
+	struct mlx5_dpll_synce_status synce_status;
 	struct mlx5_dpll *mdpll = pin_priv;
 	int err;
 
-	err = mlx5_dpll_synce_status_get(mdpll->mdev, &admin_status,
-					 &oper_status, NULL);
+	err = mlx5_dpll_synce_status_get(mdpll->mdev, &synce_status);
 	if (err)
 		return err;
-	*state = mlx5_dpll_pin_state_get(admin_status, oper_status);
+	*state = mlx5_dpll_pin_state_get(&synce_status);
 	return 0;
 }
 
@@ -202,19 +198,16 @@ static void mlx5_dpll_periodic_work(struct work_struct *work)
 {
 	struct mlx5_dpll *mdpll = container_of(work, struct mlx5_dpll,
 					       work.work);
-	enum mlx5_msees_admin_status admin_status;
-	enum mlx5_msees_oper_status oper_status;
+	struct mlx5_dpll_synce_status synce_status;
 	enum dpll_lock_status lock_status;
 	enum dpll_pin_state pin_state;
-	bool ho_acq;
 	int err;
 
-	err = mlx5_dpll_synce_status_get(mdpll->mdev, &admin_status,
-					 &oper_status, &ho_acq);
+	err = mlx5_dpll_synce_status_get(mdpll->mdev, &synce_status);
 	if (err)
 		goto err_out;
-	lock_status = mlx5_dpll_lock_status_get(oper_status, ho_acq);
-	pin_state = mlx5_dpll_pin_state_get(admin_status, oper_status);
+	lock_status = mlx5_dpll_lock_status_get(&synce_status);
+	pin_state = mlx5_dpll_pin_state_get(&synce_status);
 
 	if (!mdpll->last.valid)
 		goto invalid_out;
-- 
2.43.0


