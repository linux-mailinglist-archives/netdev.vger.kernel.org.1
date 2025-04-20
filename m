Return-Path: <netdev+bounces-184311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24206A949F2
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 00:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95EB188F9E6
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 22:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49A91DE2A8;
	Sun, 20 Apr 2025 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="onyA6ZPs"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595131C32FF;
	Sun, 20 Apr 2025 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745189903; cv=none; b=sksZa0kRBcrc3tTSWcPilFvYbQQltypv2yd0tTovt9pT+SAZ6xW8bEfB/vEaN32Nni58rMhukw3FcYxoPerN1702uOP5qzjdIpi4iGqhWI4MVFPR/r4RNa2KKN8T+WlPx1NQoVOGtlrwKXB0IC7BH3ssYl2D0QfZwu++4uG0mWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745189903; c=relaxed/simple;
	bh=TGYsg8T9IxytUJmZ8NmLekC2PutGncKpJkybFu6URAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSoo0+PQseIapCAA+dj0yY1anjbkje0eLjWMibA/XxBCj1tQ0/RQwrE7NWvPzerT0FyDd+9xiOlP5z11+02lcGxpLM1x6uLsZy9JfvGgf128NqfTimziGLk2+9lfb7NvllpjP369h7HMmCPcbI/NyWEXlpYJpCH4qCYqE7Y2zaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=onyA6ZPs; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=UxuZeOAuf/uA+MsuktlNcc8dMKqdg7ZjhUUABHvRYQA=; b=onyA6ZPsEgQwM0FP
	vl7ElQ7R+oRyV4qtLDoflL8M7FmPj/Gia/g5RFXLoCVL2BcFp/h3Hzg0Jt/E4oqUA0hkvvPg8RuL6
	ouIk/8rRBPvLR5S96uU6gWBduoTrnknQTnoGr1iEqe6PhWz1tPIhroFys34L3OxQQgvg5T4C8Ar9q
	9amudde943ynllXbQgSqU/mIlKB61AEsgFmFttBubjMGSoi7/52xdcnbr8rp0yJf8aVx5fbKiis22
	biqVgpG7gLeOQwIbiFhnwEAw67yehbVROyogUAHbycaGdB6uMC3n7g5bC4RYoRUNuJaiFabELNn7u
	9tR12RGyNhmjFA6vPQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u6dc2-00CkWa-25;
	Sun, 20 Apr 2025 22:58:10 +0000
From: linux@treblig.org
To: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	jerinj@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] octeontx2-af: Remove unused rvu_npc_enable_bcast_entry
Date: Sun, 20 Apr 2025 23:58:10 +0100
Message-ID: <20250420225810.171852-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of rvu_npc_enable_bcast_entry() was removed in 2021 by
commit 967db3529eca ("octeontx2-af: add support for multicast/promisc
packet replication feature")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h    |  2 --
 .../ethernet/marvell/octeontx2/af/rvu_npc.c    | 18 ------------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 60f085b00a8c..147d7f5c1fcc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -969,8 +969,6 @@ void rvu_npc_enable_promisc_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 				  bool enable);
 void rvu_npc_install_bcast_match_entry(struct rvu *rvu, u16 pcifunc,
 				       int nixlf, u64 chan);
-void rvu_npc_enable_bcast_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
-				bool enable);
 void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 				    u64 chan);
 void rvu_npc_enable_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 821fe242f821..6296a3cdabbb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -820,24 +820,6 @@ void rvu_npc_install_bcast_match_entry(struct rvu *rvu, u16 pcifunc,
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
 
-void rvu_npc_enable_bcast_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
-				bool enable)
-{
-	struct npc_mcam *mcam = &rvu->hw->mcam;
-	int blkaddr, index;
-
-	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
-	if (blkaddr < 0)
-		return;
-
-	/* Get 'pcifunc' of PF device */
-	pcifunc = pcifunc & ~RVU_PFVF_FUNC_MASK;
-
-	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
-					 NIXLF_BCAST_ENTRY);
-	npc_enable_mcam_entry(rvu, mcam, blkaddr, index, enable);
-}
-
 void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 				    u64 chan)
 {
-- 
2.49.0


