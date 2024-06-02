Return-Path: <netdev+bounces-99985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EE78D7623
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F1A1C20C8C
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D9F4085D;
	Sun,  2 Jun 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FM1O1hTM"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-208.smtpout.orange.fr [193.252.23.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53444366;
	Sun,  2 Jun 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717337955; cv=none; b=lCla5qBpR+4OX5STzl/C7p7FvhQXnPKugyjF1LWa6p2RxFfvzS3HvHC/HWSFnoB7caD/HRbYN8mguewOva98R7PbGn9J2xLOl9rwQTw54f5TmTD+ZAD0uTUAcHrQcZBkC1rKcKHkuDbnJtnrpnaN56X5x6VLVhxJIL/hi9HSBMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717337955; c=relaxed/simple;
	bh=/ie5zhTuzVnG6guZfln69UgguCT3/wECkJkH3j8zbpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ba34cMqCRhJY+KUHm6tYy93yFwLqsM9xe+wCznovdmE8/cmnI+JYMfbglL0QflDZAOOVpODAxuascq/EPxTG/pvGL0CKIfdxmoOvM+LejQVjhTnmbHRgzCvic4bqhAtNXa26xft2qtr+DUV5Q6J3cfRN1hgcvHw2RW9UPnomPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=FM1O1hTM; arc=none smtp.client-ip=193.252.23.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id Dm2ns8x2vLmxrDm34sLKU9; Sun, 02 Jun 2024 16:19:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1717337942;
	bh=8DCrRJgxsQW+5+97dKa8ee3w1WqnGfGM17kPgJs0kHQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FM1O1hTM4WFxAG79oe1B7VmaCBJfo7x0hhU2ROmG5cyAqvPfzGfh46VLnVHeII7tj
	 cIY7TAldPUG3qnbl3Wrv32zSOljsiR0BiJEYsAmXFwxYEkxg58neQsVKkSmOOnAL+x
	 BNLzJmLKi0e21ihiR7TAzIpG24KV13eUnJAn0DVGTM9O+HYl90/vp3WfpZkOJBNpiK
	 YS0qUpnZoUT7JvIzhvQ01INDqU038cGhcqRUFPMvxcreeUwixpkvntsGxTc5JcBaIv
	 2VrPmEIDp1eh1NmcvbloUjVf1QRC6hp6WkYMuRCOYMXLS2+/UeiKa7crSP46kYbPnp
	 cK/knB7LyZQxw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Jun 2024 16:19:02 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: idosch@nvidia.com,
	petrm@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2 net-next] mlxsw: spectrum_router: Constify struct devlink_dpipe_table_ops
Date: Sun,  2 Jun 2024 16:18:53 +0200
Message-ID: <6d79c82023fd7e3c4b2da6ac92ecf478366e8dca.1717337525.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>
References: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct devlink_dpipe_table_ops' are not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  15557	    712	      0	  16269	   3f8d	drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  15789	    488	      0	  16277	   3f95	drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
index ca80af06465f..fa6eddd27ecf 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
@@ -283,7 +283,7 @@ static u64 mlxsw_sp_dpipe_table_erif_size_get(void *priv)
 	return MLXSW_CORE_RES_GET(mlxsw_sp->core, MAX_RIFS);
 }
 
-static struct devlink_dpipe_table_ops mlxsw_sp_erif_ops = {
+static const struct devlink_dpipe_table_ops mlxsw_sp_erif_ops = {
 	.matches_dump = mlxsw_sp_dpipe_table_erif_matches_dump,
 	.actions_dump = mlxsw_sp_dpipe_table_erif_actions_dump,
 	.entries_dump = mlxsw_sp_dpipe_table_erif_entries_dump,
@@ -734,7 +734,7 @@ static u64 mlxsw_sp_dpipe_table_host4_size_get(void *priv)
 	return mlxsw_sp_dpipe_table_host_size_get(mlxsw_sp, AF_INET);
 }
 
-static struct devlink_dpipe_table_ops mlxsw_sp_host4_ops = {
+static const struct devlink_dpipe_table_ops mlxsw_sp_host4_ops = {
 	.matches_dump = mlxsw_sp_dpipe_table_host4_matches_dump,
 	.actions_dump = mlxsw_sp_dpipe_table_host_actions_dump,
 	.entries_dump = mlxsw_sp_dpipe_table_host4_entries_dump,
@@ -811,7 +811,7 @@ static u64 mlxsw_sp_dpipe_table_host6_size_get(void *priv)
 	return mlxsw_sp_dpipe_table_host_size_get(mlxsw_sp, AF_INET6);
 }
 
-static struct devlink_dpipe_table_ops mlxsw_sp_host6_ops = {
+static const struct devlink_dpipe_table_ops mlxsw_sp_host6_ops = {
 	.matches_dump = mlxsw_sp_dpipe_table_host6_matches_dump,
 	.actions_dump = mlxsw_sp_dpipe_table_host_actions_dump,
 	.entries_dump = mlxsw_sp_dpipe_table_host6_entries_dump,
@@ -1230,7 +1230,7 @@ mlxsw_sp_dpipe_table_adj_size_get(void *priv)
 	return size;
 }
 
-static struct devlink_dpipe_table_ops mlxsw_sp_dpipe_table_adj_ops = {
+static const struct devlink_dpipe_table_ops mlxsw_sp_dpipe_table_adj_ops = {
 	.matches_dump = mlxsw_sp_dpipe_table_adj_matches_dump,
 	.actions_dump = mlxsw_sp_dpipe_table_adj_actions_dump,
 	.entries_dump = mlxsw_sp_dpipe_table_adj_entries_dump,
-- 
2.45.1


