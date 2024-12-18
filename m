Return-Path: <netdev+bounces-153067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480BD9F6B3E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98005163184
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08B31F63E0;
	Wed, 18 Dec 2024 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="I8ZKXlxu"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B31F63C0;
	Wed, 18 Dec 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539651; cv=none; b=Y3mJlAl+bZf2qe0SaFD1dVEq5gF1fhw69prhOCFqZAGhBA4hl52Lt3n1qx6C4t2Cc5lo7034qjZB4wzBb+l+u/0RQbbdrVbXGrJLOg3qJ7J/eYUWoWVtGQ4PQAsoLPscUkW6f6PThMvKILDD0XouKYwndWht7iLt/JJcwm6SVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539651; c=relaxed/simple;
	bh=J/gv98AFGa2eJeKTC1qfwhXH3mf8xf2xnKZas02Hcrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4bzfEksOox+C0zvfXUCioERF1bVF4IhipPYan6NPlnMYgepQseHthI3yySJ/rH08YO6eKfrcaOqr6dxWDAx+MWQtG+xjJWeT3ImLfI6JsBhUxlK15og6vy+qYCayADF33VtHkNARKyFh0k0wF1In7JM3ni2fTmTRXtVY8uWGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=I8ZKXlxu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ZjeajG0PZVXWz7g8v/NltxZHFFLN4CNSsjhUcWVcAGA=; b=I8ZKXlxu30x7UvVd
	NOE7+t22oAPTmVKmhcGXqghCQaLEOkDHSC7cPLBk6MzsQsHygAqG+RSqjXi3R/kMCaUxykXDoEU6H
	3C1G1k4ajvLmUPcPyTLDeIwiE7maIbmq8i8vIhZZKxG4fiqv/jgGVIxhenDeuy5YW0GuLye7LA3hR
	0P7bJE+sndI+dNdamzoCQ/UO2Q6lpMpzHIV2KARDoYFUdE3FTfXEjyQEwkXkdnCeoSqtdKXnwtHly
	tjWoI7h0rp5HfW4YPR/KMSQtQvd+xT2lb/VVXQHyaD+oCsbrKWmj4BpXTtTktlh4utaBn9HIZcfhO
	bGpKTZOhNrdui+8kAQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tNwzZ-0068f8-09;
	Wed, 18 Dec 2024 16:33:45 +0000
From: linux@treblig.org
To: salil.mehta@huawei.com,
	shenjian15@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next v2 2/4] net: hisilicon: hns: Remove unused hns_rcb_start
Date: Wed, 18 Dec 2024 16:33:39 +0000
Message-ID: <20241218163341.40297-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218163341.40297-1-linux@treblig.org>
References: <20241218163341.40297-1-linux@treblig.org>
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
Reviewed-by: Jijie Shao<shaojijie@huawei.com>
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


