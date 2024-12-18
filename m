Return-Path: <netdev+bounces-152775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7AC9F5BF6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644FF188D63F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0728313BC0E;
	Wed, 18 Dec 2024 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="BPcmxBVN"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7DB12EBDB;
	Wed, 18 Dec 2024 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483478; cv=none; b=BtLWKaOC+DwUdO4/cxQWtaXC8PEAddLoQUVgWuKglWLkUqosv+NO093kdLh+U4dvAz7y3Q+JRJqnHLxxR/nESuEtyIhHhFYL//TO/xFjNjm4H/wUg5Pyc/DGU4dHHROAyLOTxu5Myw0WVfVi9dOigPbkV9KM9f0SvxcsTmY+aw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483478; c=relaxed/simple;
	bh=CqkBsnJWVJ6v3xHtWBdh1evnMof6Xc/jHXMPt5/M4f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuoR8+QH+lqMh0JA6WhPbKyUBNyWMiEKFWlGEqClclzrcG2VQxQLzWqUUznIkxuhOwbC/iYOapx/LB6kAVrUY6zCIEbOP422LpsvET9Qj+6GeZP7CIoNzHSuwxkLXkCcC46WJ1bk5csT5RbNImAb9VupIWPHitLjc/KOMt56qUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=BPcmxBVN; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=8gNGHdKfnZSCbNaYqe0r2Lu7FPBTr8il/pusjuH3EkA=; b=BPcmxBVN2C0BdATz
	vicuizi41rKPVhLcXR6pVSEsl5gw4MyGCj4GbO31OyuuU+PGDcgBY6JYZTjIPaDOVBzIYIeR0m+rT
	2BqhthxxfsFdzG4NOHhc+tuda6LmKIP/1gNBko/CxXCdgM2YaelqNkBNyp0VtQr4aU0apm/8G5Dcx
	rE5qE8Dq2aiptQE4kDgw4lwYWAKRpoKBKOgqQW609YIP3da58Tz6sDRy10Y4pWBypkA4zdaihnIvi
	Bn3ybfdPcZbFLAkFtA4PdAAx0yMuzuxw7xB6fORSm/WVmiL32NDm0QD+XlJXhYf9SnnoX4V+y6MoA
	42Cd27L0n7ESTIV48w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tNiNY-005zvH-0X;
	Wed, 18 Dec 2024 00:57:32 +0000
From: linux@treblig.org
To: salil.mehta@huawei.com,
	shenjian15@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 2/3] net: hisilicon: hns: Remove unused hns_rcb_start
Date: Wed, 18 Dec 2024 00:57:28 +0000
Message-ID: <20241218005729.244987-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218005729.244987-1-linux@treblig.org>
References: <20241218005729.244987-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

hns_rcb_start() has been unused since 2016's
commit 454784d85de3 ("net: hns: delete redundancy ring enable operations")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c | 5 -----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
index 46af467aa596..635b3a95dd82 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -195,11 +195,6 @@ void hns_rcb_ring_enable_hw(struct hnae_queue *q, u32 val)
 	dsaf_write_dev(q, RCB_RING_PREFETCH_EN_REG, !!val);
 }
 
-void hns_rcb_start(struct hnae_queue *q, u32 val)
-{
-	hns_rcb_ring_enable_hw(q, val);
-}
-
 /**
  *hns_rcb_common_init_commit_hw - make rcb common init completed
  *@rcb_common: rcb common device
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
index 0f4cc184ef39..68f81547dfb4 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
@@ -116,7 +116,6 @@ int hns_rcb_buf_size2type(u32 buf_size);
 int hns_rcb_common_get_cfg(struct dsaf_device *dsaf_dev, int comm_index);
 void hns_rcb_common_free_cfg(struct dsaf_device *dsaf_dev, u32 comm_index);
 int hns_rcb_common_init_hw(struct rcb_common_cb *rcb_common);
-void hns_rcb_start(struct hnae_queue *q, u32 val);
 int hns_rcb_get_cfg(struct rcb_common_cb *rcb_common);
 void hns_rcb_get_queue_mode(enum dsaf_mode dsaf_mode,
 			    u16 *max_vfn, u16 *max_q_per_vf);
-- 
2.47.1


