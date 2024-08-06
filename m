Return-Path: <netdev+bounces-116133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A4894932F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459CE1C21C63
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743A61D47D1;
	Tue,  6 Aug 2024 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HiTu6bys"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF21BE875
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954898; cv=none; b=h+YqiClLHyZTVRvzZRfhs6a0CpiqEaOzaMfOA3mQbxn1DRkHKDBGaCLmo7gFAiXhtjX2N3AFx50ssnAMku87yVzyvfkGMt4pGjozZ35hyLi3/b5xEhDyR0aZC0upUv5ojM93DSNDIa3pD9xT0JwwuSfPmaKN6MftKzhXIHHglgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954898; c=relaxed/simple;
	bh=yUUWnROm3mCAZpy7+Gd2lIerK1GenBdD6Pb4PPzTBKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faLF8Udlget+U1aFuYK9PncA2xSnvHKhN2L7TmRnBLAfV/Z6SPBMREUu5m7u5Qy7WTRZ0sT8jw0Qzg49m7XTL41sdYetFiafrdWLA99EYotHx/kMJcg5buadR0N2U8uDj4gzFI6GREugo9dOHM5DSrOMtMmVrNRb4/BYwz15KD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HiTu6bys; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722954897; x=1754490897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUUWnROm3mCAZpy7+Gd2lIerK1GenBdD6Pb4PPzTBKU=;
  b=HiTu6bysczUDdf2ce4AXQY6XcsfKdhVHxexQdG0PiEo8S13iFpeCxapS
   jbKWY+xzpzfdeIRYZZuJPcvwdxC1cWBLPWjO2DoQFSWsUimK9/6WWEj54
   99WF5B1V7v3kwMYqgtBTo39UCM3PYYgPpPb5H2V4niPUzSVNtkgB/F3wF
   mSB04QX/NQ932guhoLGNkVtE+FNMkG0fTaudBeoOKTU+eI4AX10ACex4B
   NaexQpDED3r2A17qMI8rBRi672JpjQIWdprzwj6CjVKNaMIw7gdu3HwI5
   zbtFC0Hi/xinQBn0lOsGwosMmvT6NHhqkTILfF37iekcpNgre+dfRGKMW
   w==;
X-CSE-ConnectionGUID: ZbhIs4HERLil7bU7jHmaOw==
X-CSE-MsgGUID: S2elkq92RXCCnjL2tYHz1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38428626"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38428626"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:34:57 -0700
X-CSE-ConnectionGUID: KZU1tXN7SAaroKVl6Tp8Rw==
X-CSE-MsgGUID: cBI7KZiMQ/6r4PpIgpinvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56502675"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2024 07:34:51 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E475F2FC42;
	Tue,  6 Aug 2024 15:34:49 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net-next 5/5] mlxsw: spectrum_kvdl: combine devlink resource occupation getters
Date: Tue,  6 Aug 2024 16:33:07 +0200
Message-Id: <20240806143307.14839-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combine spectrum1 kvdl devlink resource occupation getters into one.

Thanks to previous commit of the series we could easily embed more than
just a single pointer into devlink resource.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  5 ++
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  3 +-
 .../ethernet/mellanox/mlxsw/spectrum1_kvdl.c  | 80 ++++++++-----------
 3 files changed, 41 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 8d3c61287696..91fe5fffa675 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -836,6 +836,11 @@ int mlxsw_sp_kvdl_alloc_count_query(struct mlxsw_sp *mlxsw_sp,
 				    unsigned int *p_alloc_count);
 
 /* spectrum1_kvdl.c */
+struct mlxsw_sp1_kvdl_occ_ctx {
+	struct mlxsw_sp1_kvdl *kvdl;
+	int first_part_id;
+	bool count_all_parts;
+};
 extern const struct mlxsw_sp_kvdl_ops mlxsw_sp1_kvdl_ops;
 int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core);
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 2730ae3d8fe6..3bda2b2d16f9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3669,7 +3669,8 @@ static int mlxsw_sp1_resources_kvd_register(struct mlxsw_core *mlxsw_core)
 				     linear_size,
 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
 				     MLXSW_SP_RESOURCE_KVD,
-				     &linear_size_params, sizeof(void *));
+				     &linear_size_params,
+				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
index ee5f12746371..a8bf052adf31 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
@@ -292,68 +292,53 @@ static u64 mlxsw_sp1_kvdl_part_occ(struct mlxsw_sp1_kvdl_part *part)
 
 static u64 mlxsw_sp1_kvdl_occ_get(void *priv)
 {
-	const struct mlxsw_sp1_kvdl *kvdl = priv;
+	struct mlxsw_sp1_kvdl_occ_ctx *ctx = priv;
+	bool cnt_all = ctx->count_all_parts;
+	int beg, end;
 	u64 occ = 0;
-	int i;
 
-	for (i = 0; i < MLXSW_SP1_KVDL_PARTS_INFO_LEN; i++)
-		occ += mlxsw_sp1_kvdl_part_occ(kvdl->parts[i]);
+	beg = cnt_all ? 0 : ctx->first_part_id,
+	end = cnt_all ? MLXSW_SP1_KVDL_PARTS_INFO_LEN : beg + 1;
+	for (int i = beg; i < end; i++)
+		occ += mlxsw_sp1_kvdl_part_occ(ctx->kvdl->parts[i]);
 
 	return occ;
 }
 
-static u64 mlxsw_sp1_kvdl_single_occ_get(void *priv)
-{
-	const struct mlxsw_sp1_kvdl *kvdl = priv;
-	struct mlxsw_sp1_kvdl_part *part;
-
-	part = kvdl->parts[MLXSW_SP1_KVDL_PART_ID_SINGLE];
-	return mlxsw_sp1_kvdl_part_occ(part);
-}
-
-static u64 mlxsw_sp1_kvdl_chunks_occ_get(void *priv)
-{
-	const struct mlxsw_sp1_kvdl *kvdl = priv;
-	struct mlxsw_sp1_kvdl_part *part;
-
-	part = kvdl->parts[MLXSW_SP1_KVDL_PART_ID_CHUNKS];
-	return mlxsw_sp1_kvdl_part_occ(part);
-}
-
-static u64 mlxsw_sp1_kvdl_large_chunks_occ_get(void *priv)
-{
-	const struct mlxsw_sp1_kvdl *kvdl = priv;
-	struct mlxsw_sp1_kvdl_part *part;
-
-	part = kvdl->parts[MLXSW_SP1_KVDL_PART_ID_LARGE_CHUNKS];
-	return mlxsw_sp1_kvdl_part_occ(part);
-}
-
 static int mlxsw_sp1_kvdl_init(struct mlxsw_sp *mlxsw_sp, void *priv)
 {
 	struct devlink *devlink = priv_to_devlink(mlxsw_sp->core);
-	struct mlxsw_sp1_kvdl *kvdl = priv;
+	struct mlxsw_sp1_kvdl_occ_ctx ctx = { priv };
 	int err;
 
-	err = mlxsw_sp1_kvdl_parts_init(mlxsw_sp, kvdl);
+	err = mlxsw_sp1_kvdl_parts_init(mlxsw_sp, ctx.kvdl);
 	if (err)
 		return err;
-	devl_resource_occ_get_register(devlink,
-				       MLXSW_SP_RESOURCE_KVD_LINEAR,
-				       mlxsw_sp1_kvdl_occ_get,
-				       &kvdl, sizeof(kvdl));
+
+	ctx.first_part_id = MLXSW_SP1_KVDL_PART_ID_SINGLE;
 	devl_resource_occ_get_register(devlink,
 				       MLXSW_SP_RESOURCE_KVD_LINEAR_SINGLE,
-				       mlxsw_sp1_kvdl_single_occ_get,
-				       &kvdl, sizeof(kvdl));
+				       mlxsw_sp1_kvdl_occ_get,
+				       &ctx, sizeof(ctx));
+
+	ctx.first_part_id = MLXSW_SP1_KVDL_PART_ID_CHUNKS;
 	devl_resource_occ_get_register(devlink,
 				       MLXSW_SP_RESOURCE_KVD_LINEAR_CHUNKS,
-				       mlxsw_sp1_kvdl_chunks_occ_get,
-				       &kvdl, sizeof(kvdl));
+				       mlxsw_sp1_kvdl_occ_get,
+				       &ctx, sizeof(ctx));
+
+	ctx.first_part_id = MLXSW_SP1_KVDL_PART_ID_LARGE_CHUNKS;
 	devl_resource_occ_get_register(devlink,
 				       MLXSW_SP_RESOURCE_KVD_LINEAR_LARGE_CHUNKS,
-				       mlxsw_sp1_kvdl_large_chunks_occ_get,
-				       &kvdl, sizeof(kvdl));
+				       mlxsw_sp1_kvdl_occ_get,
+				       &ctx, sizeof(ctx));
+
+	ctx.count_all_parts = true;
+	devl_resource_occ_get_register(devlink,
+				       MLXSW_SP_RESOURCE_KVD_LINEAR,
+				       mlxsw_sp1_kvdl_occ_get,
+				       &ctx, sizeof(ctx));
+
 	return 0;
 }
 
@@ -400,7 +385,8 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
 				     MLXSW_SP1_KVDL_SINGLE_SIZE,
 				     MLXSW_SP_RESOURCE_KVD_LINEAR_SINGLE,
 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
-				     &size_params, sizeof(void *));
+				     &size_params,
+				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
 	if (err)
 		return err;
 
@@ -411,7 +397,8 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
 				     MLXSW_SP1_KVDL_CHUNKS_SIZE,
 				     MLXSW_SP_RESOURCE_KVD_LINEAR_CHUNKS,
 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
-				     &size_params, sizeof(void *));
+				     &size_params,
+				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
 	if (err)
 		return err;
 
@@ -422,6 +409,7 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
 				     MLXSW_SP1_KVDL_LARGE_CHUNKS_SIZE,
 				     MLXSW_SP_RESOURCE_KVD_LINEAR_LARGE_CHUNKS,
 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
-				     &size_params, sizeof(void *));
+				     &size_params,
+				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
 	return err;
 }
-- 
2.39.3


