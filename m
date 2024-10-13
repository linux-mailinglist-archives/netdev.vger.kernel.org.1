Return-Path: <netdev+bounces-134990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F8599BBC0
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3EE5B20DA5
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00536156C69;
	Sun, 13 Oct 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="KfabtnhZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBB14F9E2;
	Sun, 13 Oct 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851929; cv=none; b=WXSgC8TK/LrWq7XQ9tK7+IQcNrP9a19e8lOGK8Durwn1w5SS0UFigVafs1uZAxSp3c807aFh46qyK2tvYwbGT8VMmNRg6NJDQEb1GIo9RHCWwN4VLNhz/2sWNK9ZBYeqH+ayE50JSdnETIPS+lOVgtHZKeNkzn3V03y0lrG2Dnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851929; c=relaxed/simple;
	bh=RlpXOidSIkDtXwfikagOesfLxTriDN+l1/Ar8iVwTQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtFmR/qjv30bLwpdKO/Tlfr0xSzrqgNh4V9Kx+EumizdRJ1xscyzwav95+X1vyPLHNUa0ihef80jOJCDonDuzA/x4orNvnCHId3m/zrafLUQ3XESQ3mfmYEh/EaeBHCSh0SL3uQKlKU2vOh8zX9fTJ+C1TNCPSYwkYC+D4z2uJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=KfabtnhZ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=NZNaeQVpUHOr17M4VqCALkPHgzs8AAqDAyl+ctHVJo8=; b=KfabtnhZLzFOCW1g
	6qVeF5hwO2Iu+fOSkrU4Rrk6AKOFKzXb9k+Z/7pgZ5OCw3znfqcIT0iyHh1Ym86+mFYuDbcs2Y3ar
	wGiGInJw4eQryqfmqT0AXPcYl3X93brjfQ09703GLmFaJN0aBYE/vtJIv4owzQn35m9rS+aiG5q3B
	wcZlt2AgYoB6hkKtrIe8A74fvcypgOukBWHNHJ0AEm/NxvpXFi6d7dk1N79zvQEQqS2oHMjbSjidK
	y5nT59IXDixE/716GKIM6TYsU05rS5ebET7vD/J0wZjw5BkfTae747IR6AuLG2ipJUEjMH2gHFrIW
	G+XZMxj8m+u2EEKOJA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t05MP-00AnUX-0p;
	Sun, 13 Oct 2024 20:38:41 +0000
From: linux@treblig.org
To: bharat@chelsio.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 6/6] cxgb4: Remove unused t4_free_ofld_rxqs
Date: Sun, 13 Oct 2024 21:38:31 +0100
Message-ID: <20241013203831.88051-7-linux@treblig.org>
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

t4_free_ofld_rxqs() has been unused since
commit 0fbc81b3ad51 ("chcr/cxgb4i/cxgbit/RDMA/cxgb4: Allocate resources
dynamically for all cxgb4 ULD's")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h |  1 -
 drivers/net/ethernet/chelsio/cxgb4/sge.c   | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 1c302dfd6503..75bd69ff61a8 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1608,7 +1608,6 @@ void t4_os_portmod_changed(struct adapter *adap, int port_id);
 void t4_os_link_changed(struct adapter *adap, int port_id, int link_stat);
 
 void t4_free_sge_resources(struct adapter *adap);
-void t4_free_ofld_rxqs(struct adapter *adap, int n, struct sge_ofld_rxq *q);
 irq_handler_t t4_intr_handler(struct adapter *adap);
 netdev_tx_t t4_start_xmit(struct sk_buff *skb, struct net_device *dev);
 int cxgb4_selftest_lb_pkt(struct net_device *netdev);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index de52bcb884c4..a7d76a8ed050 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -4874,22 +4874,6 @@ void free_rspq_fl(struct adapter *adap, struct sge_rspq *rq,
 	}
 }
 
-/**
- *      t4_free_ofld_rxqs - free a block of consecutive Rx queues
- *      @adap: the adapter
- *      @n: number of queues
- *      @q: pointer to first queue
- *
- *      Release the resources of a consecutive block of offload Rx queues.
- */
-void t4_free_ofld_rxqs(struct adapter *adap, int n, struct sge_ofld_rxq *q)
-{
-	for ( ; n; n--, q++)
-		if (q->rspq.desc)
-			free_rspq_fl(adap, &q->rspq,
-				     q->fl.size ? &q->fl : NULL);
-}
-
 void t4_sge_free_ethofld_txq(struct adapter *adap, struct sge_eohw_txq *txq)
 {
 	if (txq->q.desc) {
-- 
2.47.0


