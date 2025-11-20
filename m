Return-Path: <netdev+bounces-240366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F658C73D52
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 182F4304F4
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1229D2727EE;
	Thu, 20 Nov 2025 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N5DlF3fz"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF9B2FD1B9;
	Thu, 20 Nov 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639602; cv=none; b=NO1o2sCxRPrJVjw7YTQGQ3gqwvHSaqAgp0uNxUj8nIW/v+NszvWBrBpL7F7tLoSs0borgzripqHTpREP5+exfKJhuz/4MkhahZZ5zir1CXbL79qupuAM323e34dILEr2NZ+OYSZ3IRMThJBrSQyvJoYf0OCMpDQQuql/kPxoAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639602; c=relaxed/simple;
	bh=2aEtqVtnhhNYp29lCAJcQY1w52LRSC5n/qmKVhVyk7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aN83dQZADx08Ne9T1rMx/zLor98RTzl7SIIq2rhrXcBK28Get5YhBwYvyobHFEOZE3bWydphvvB7r5JcMuSnq4Htwe8HNkSjGeGa3S08mgymASV+jFo8XrdwM5qTe2ER9sq9V3z1PifLL8F1X21fK3UCGZpodqXRTkuefvYpiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N5DlF3fz; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jo
	bMWD91by5uhDYoqh/KCiL5hqPFwNPSpc8S2TG7LwE=; b=N5DlF3fzBh1aInjDoH
	CXeDjKwJowSJRDUJ2zugc2ImDzWaBYTMz+49beAqR1lmjmWBzxLiJ3SAO/JFHATo
	hRY1X+4CX9MML8s9s8SsLGR9db81/3g83PweQig0yfKy3z+UiFNC8U3xpQFzyi6/
	ZdlFMFxAVGTvKgX1Pe6+W5lCg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnaqbxAB9px6_ZBQ--.2298S2;
	Thu, 20 Nov 2025 19:52:20 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] net: wwan: t7xx: Make local function static
Date: Thu, 20 Nov 2025 19:52:08 +0800
Message-Id: <20251120115208.345578-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnaqbxAB9px6_ZBQ--.2298S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4UGrWkuw4DJw17CryrCrg_yoW8CF4kpa
	1UAF12k39Yyw4Duw4UJrWIyFnxJw1Iv3y09ryftw1rWF93ArW5AF1q9FW3Ar43A3srWF1f
	ArWUt39xCF18CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pisa93UUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRsMZGke-YpS-QAAsF

This function was used in t7xx_hif_cldma.c only. Make it static
as it should be.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c | 2 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
index 97163e1e5783..bd16788882f0 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -899,7 +899,7 @@ static void t7xx_cldma_hw_start_send(struct cldma_ctrl *md_ctrl, int qno,
  * @queue: CLDMA queue.
  * @recv_skb: Receiving skb callback.
  */
-void t7xx_cldma_set_recv_skb(struct cldma_queue *queue,
+static void t7xx_cldma_set_recv_skb(struct cldma_queue *queue,
 			     int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb))
 {
 	queue->recv_skb = recv_skb;
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
index f2d9941be9c8..9d0107e18a7b 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
@@ -126,8 +126,6 @@ void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl, enum cldma_cfg cfg_id);
 void t7xx_cldma_start(struct cldma_ctrl *md_ctrl);
 int t7xx_cldma_stop(struct cldma_ctrl *md_ctrl);
 void t7xx_cldma_reset(struct cldma_ctrl *md_ctrl);
-void t7xx_cldma_set_recv_skb(struct cldma_queue *queue,
-			     int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb));
 int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_buff *skb);
 void t7xx_cldma_stop_all_qs(struct cldma_ctrl *md_ctrl, enum mtk_txrx tx_rx);
 void t7xx_cldma_clear_all_qs(struct cldma_ctrl *md_ctrl, enum mtk_txrx tx_rx);
-- 
2.25.1


