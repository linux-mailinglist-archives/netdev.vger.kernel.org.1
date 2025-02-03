Return-Path: <netdev+bounces-162208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D12F8A2633D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B1D188566E
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CDC1CAA87;
	Mon,  3 Feb 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="P12XajL/"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA2192B74;
	Mon,  3 Feb 2025 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609312; cv=none; b=fFUN71JyIIgcBFjudVgOsUs3fxdKlVlAKgjT1fkd33V3OKsSOt7k7+sF1IiCtbxUtU/zEZhgjRWVf5es++lfMA71149om+UBo/MxdWb8YLvI4bAdfV/F6hNRpGDgT0FjyzMDGC1rCxjBwaRwS/yMifXWdDB1dCZPqU+T+XDUHHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609312; c=relaxed/simple;
	bh=jHJiNTOghaJcsfWgqGiqFe6TF49153O2wgj+WCPt+Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqefm+FfizX1Z2ZE2epgz3M0if4+jghmCxk+lt97foE4dpkhhEs3ZV0zjlwZTF1u0rPtaJeUeFz/06jXd1DtUgugyJctg4FX/2x4AV7tSUphzE0A+W7NlWbkwpzB+zGZmIcQCwYYg9g5H4bUcygKAHTrT31g+2zDOQSHuvgWpM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=P12XajL/; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=crZwIZPhwBOH6mXJdKimuCTfVSYTTkH5F1qVpozDxDM=; b=P12XajL/oRwP2m7w
	EOX/p5dbtR7nO7qHg1aRoX4Y+M5CzDtVfGk4HMsHMAY3+gkEdy7FHqReBIpmsPLkf4sQeIGkt6SM1
	0c+LoV3jVUgDS+yqFsnC15ObbTrarQcZzilbUzVOKXNfA8ayjPE35NyxMSu8QCLfHbk5PU2Um3UOB
	bblHUZWu1J7qBELKlirRj5NHENBg5tHpHoXEwq97lxM2AxaJQ+kTK3XDVFbCAhFgqyHKjeMZM6uTc
	uZKBE6cYx5hCJW51rENEimxCdyk8gmrgAIQB9M3N3yq+r9W2YMyM/eQpfEswrta9EK6GwxC+Zi3BS
	JrKqqLk5KawlHQKuhA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tf1hW-00DM0O-1p;
	Mon, 03 Feb 2025 19:01:42 +0000
From: linux@treblig.org
To: idosch@nvidia.com,
	petrm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] mlxsw: spectrum_router: Remove unused functions
Date: Mon,  3 Feb 2025 19:01:41 +0000
Message-ID: <20250203190141.204951-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

mlxsw_sp_ipip_lb_ul_vr_id() has been unused since 2020's
commit acde33bf7319 ("mlxsw: spectrum_router: Reduce
mlxsw_sp_ipip_fib_entry_op_gre4()")

mlxsw_sp_rif_exists() has been unused since 2023's
commit 49c3a615d382 ("mlxsw: spectrum_router: Replay MACVLANs when RIF is
made")

mlxsw_sp_rif_vid() has been unused since 2023's
commit a5b52692e693 ("mlxsw: spectrum_switchdev: Manage RIFs on PVID
change")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  3 --
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 48 -------------------
 .../ethernet/mellanox/mlxsw/spectrum_router.h |  1 -
 3 files changed, 52 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index b10f80fc651b..fa7082ee5183 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -754,9 +754,6 @@ void
 mlxsw_sp_port_vlan_router_leave(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan);
 void mlxsw_sp_rif_destroy_by_dev(struct mlxsw_sp *mlxsw_sp,
 				 struct net_device *dev);
-bool mlxsw_sp_rif_exists(struct mlxsw_sp *mlxsw_sp,
-			 const struct net_device *dev);
-u16 mlxsw_sp_rif_vid(struct mlxsw_sp *mlxsw_sp, const struct net_device *dev);
 u16 mlxsw_sp_router_port(const struct mlxsw_sp *mlxsw_sp);
 int mlxsw_sp_router_nve_promote_decap(struct mlxsw_sp *mlxsw_sp, u32 ul_tb_id,
 				      enum mlxsw_sp_l3proto ul_proto,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 7d6d859cef3f..464821dd492d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -8184,41 +8184,6 @@ mlxsw_sp_rif_find_by_dev(const struct mlxsw_sp *mlxsw_sp,
 	return NULL;
 }
 
-bool mlxsw_sp_rif_exists(struct mlxsw_sp *mlxsw_sp,
-			 const struct net_device *dev)
-{
-	struct mlxsw_sp_rif *rif;
-
-	mutex_lock(&mlxsw_sp->router->lock);
-	rif = mlxsw_sp_rif_find_by_dev(mlxsw_sp, dev);
-	mutex_unlock(&mlxsw_sp->router->lock);
-
-	return rif;
-}
-
-u16 mlxsw_sp_rif_vid(struct mlxsw_sp *mlxsw_sp, const struct net_device *dev)
-{
-	struct mlxsw_sp_rif *rif;
-	u16 vid = 0;
-
-	mutex_lock(&mlxsw_sp->router->lock);
-	rif = mlxsw_sp_rif_find_by_dev(mlxsw_sp, dev);
-	if (!rif)
-		goto out;
-
-	/* We only return the VID for VLAN RIFs. Otherwise we return an
-	 * invalid value (0).
-	 */
-	if (rif->ops->type != MLXSW_SP_RIF_TYPE_VLAN)
-		goto out;
-
-	vid = mlxsw_sp_fid_8021q_vid(rif->fid);
-
-out:
-	mutex_unlock(&mlxsw_sp->router->lock);
-	return vid;
-}
-
 static int mlxsw_sp_router_rif_disable(struct mlxsw_sp *mlxsw_sp, u16 rif)
 {
 	char ritr_pl[MLXSW_REG_RITR_LEN];
@@ -8417,19 +8382,6 @@ u16 mlxsw_sp_ipip_lb_rif_index(const struct mlxsw_sp_rif_ipip_lb *lb_rif)
 	return lb_rif->common.rif_index;
 }
 
-u16 mlxsw_sp_ipip_lb_ul_vr_id(const struct mlxsw_sp_rif_ipip_lb *lb_rif)
-{
-	struct net_device *dev = mlxsw_sp_rif_dev(&lb_rif->common);
-	u32 ul_tb_id = mlxsw_sp_ipip_dev_ul_tb_id(dev);
-	struct mlxsw_sp_vr *ul_vr;
-
-	ul_vr = mlxsw_sp_vr_get(lb_rif->common.mlxsw_sp, ul_tb_id, NULL);
-	if (WARN_ON(IS_ERR(ul_vr)))
-		return 0;
-
-	return ul_vr->id;
-}
-
 u16 mlxsw_sp_ipip_lb_ul_rif_id(const struct mlxsw_sp_rif_ipip_lb *lb_rif)
 {
 	return lb_rif->ul_rif_id;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
index 0432c7cc6b07..313efab5c324 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
@@ -90,7 +90,6 @@ struct mlxsw_sp_ipip_entry;
 struct mlxsw_sp_rif *mlxsw_sp_rif_by_index(const struct mlxsw_sp *mlxsw_sp,
 					   u16 rif_index);
 u16 mlxsw_sp_ipip_lb_rif_index(const struct mlxsw_sp_rif_ipip_lb *rif);
-u16 mlxsw_sp_ipip_lb_ul_vr_id(const struct mlxsw_sp_rif_ipip_lb *rif);
 u16 mlxsw_sp_ipip_lb_ul_rif_id(const struct mlxsw_sp_rif_ipip_lb *lb_rif);
 u32 mlxsw_sp_ipip_dev_ul_tb_id(const struct net_device *ol_dev);
 int mlxsw_sp_rif_dev_ifindex(const struct mlxsw_sp_rif *rif);
-- 
2.48.1


