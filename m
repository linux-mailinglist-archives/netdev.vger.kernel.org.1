Return-Path: <netdev+bounces-134987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A248899BBB8
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC251F214FD
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF77E1531F2;
	Sun, 13 Oct 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="q1FSoYVn"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4C14A0AA;
	Sun, 13 Oct 2024 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851927; cv=none; b=BSQIvu/ASWt2paXIeXm8V3jXQOJiXvMNgXwnOvWndoWkI61P1H+kAMxj26i8idIHa90t6eejW2/wnPJap6augFvZtUX1wUZhUqXl3m8o6soMaQprGv2+4LGKxOwDjx23eYdNVE3ckiN9qRt48cCqxkcrtLIJe3WG9AfMELO1DeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851927; c=relaxed/simple;
	bh=TIxQP5Qf4dF0rthcNEnMbCKB2xuY8ekbw61NFE9C49A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nohwtqIMd7N0El+WNY/nh249+x0u1lkgcpK7QaBGmTLg+fRT80eS2y86qQgLK9wHE49D3230DJllazxF2XmLD+z9vJaRxCOjl4MO8wHjgUrEOq4u6Eq6/Dnhw+YOirvl39pE02QCtqGQodx5RN2bOh0HV5lBycCb0KY0GDRNXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=q1FSoYVn; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=lK6RmXXkbNlWB6G+65qiaqQK1cRZEQZCtAEaguIjHEw=; b=q1FSoYVnMnD+YN6I
	FSGqWwmq8MWEUA4KjK9Sudcw+g3j/JZ8BCfS5hs18t8sFFzw4cp3xnmXcR7lIwWuDY8wcYDvVOlCs
	GmAfqSb11Dh5HXIR12Bke5FAmlHDxUDJ9yBjfYOE3kgrsw/Q5EYVj7LumiJ7Fh5kfhjzE8MqIukl3
	va6WfvfS+ZnNnSGWPcNMOxcZQ6l2o3iljJKkv39DPDmOn0Lk//an6A8fDUdBU2j9NAxg8scdl85/a
	lLskviXJmbsWnd4TVhYjHeJK4hdzu6f8vsZBA9UMEyPxIDE2RzMDYhs1jECm4B4aIvTdSl+9iwjiU
	d3pjhS6rv/iSclv/0w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t05MN-00AnUX-2I;
	Sun, 13 Oct 2024 20:38:39 +0000
From: linux@treblig.org
To: bharat@chelsio.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 4/6] cxgb4: Remove unused cxgb4_scsi_init
Date: Sun, 13 Oct 2024 21:38:29 +0100
Message-ID: <20241013203831.88051-5-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241013203831.88051-1-linux@treblig.org>
References: <20241013203831.88051-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cxgb4_iscsi_init() has been unused since 2016's commit
5999299f1ce9 ("cxgb3i,cxgb4i,libcxgbi: remove iSCSI DDP support")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 12 ------------
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h  |  2 --
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 2418645c8823..97a261d5357e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -2188,18 +2188,6 @@ void cxgb4_get_tcp_stats(struct pci_dev *pdev, struct tp_tcp_stats *v4,
 }
 EXPORT_SYMBOL(cxgb4_get_tcp_stats);
 
-void cxgb4_iscsi_init(struct net_device *dev, unsigned int tag_mask,
-		      const unsigned int *pgsz_order)
-{
-	struct adapter *adap = netdev2adap(dev);
-
-	t4_write_reg(adap, ULP_RX_ISCSI_TAGMASK_A, tag_mask);
-	t4_write_reg(adap, ULP_RX_ISCSI_PSZ_A, HPZ0_V(pgsz_order[0]) |
-		     HPZ1_V(pgsz_order[1]) | HPZ2_V(pgsz_order[2]) |
-		     HPZ3_V(pgsz_order[3]));
-}
-EXPORT_SYMBOL(cxgb4_iscsi_init);
-
 int cxgb4_flush_eq_cache(struct net_device *dev)
 {
 	struct adapter *adap = netdev2adap(dev);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
index d8cafaa7ddb4..d7713038386c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
@@ -518,8 +518,6 @@ unsigned int cxgb4_best_aligned_mtu(const unsigned short *mtus,
 				    unsigned int *mtu_idxp);
 void cxgb4_get_tcp_stats(struct pci_dev *pdev, struct tp_tcp_stats *v4,
 			 struct tp_tcp_stats *v6);
-void cxgb4_iscsi_init(struct net_device *dev, unsigned int tag_mask,
-		      const unsigned int *pgsz_order);
 struct sk_buff *cxgb4_pktgl_to_skb(const struct pkt_gl *gl,
 				   unsigned int skb_len, unsigned int pull_len);
 int cxgb4_sync_txq_pidx(struct net_device *dev, u16 qid, u16 pidx, u16 size);
-- 
2.47.0


