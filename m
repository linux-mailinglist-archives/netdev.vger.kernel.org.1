Return-Path: <netdev+bounces-145580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EC79CFF7C
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 16:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04135285643
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 15:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9327715;
	Sat, 16 Nov 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="JE12Z8Tv"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527528684;
	Sat, 16 Nov 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731770814; cv=none; b=XeftW6rK6LkAvAeleBb5XdWw8C5nQyqeTpM7Xmtq/WGxvuVtv2uqU5tpaXOkvwpFGPbk+RrobuVBuKC8xRNB2MTCqRwqumbGfEPWKE3o6v285THxqc5M4e5epea2Zotb1ff7t16eEnr33QAZLbinZ65aDnysYlKrj0hE6xC4U9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731770814; c=relaxed/simple;
	bh=OjtWOJClRyjyY6rtcalAVPwyUkkjRtC6wA8XkUtWSW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mK8c1BMbgJZpZJABRbsHj9Lviq49JroUi0Nvnr7sClZ+Rw2QYjry189BuphyubO0+Wk5FAa4mtrOLDSShWL1YwPgyabSAQFToFikwRFDjKJeU6jMBXr4W2woHx25AQTE9EnmpuVe7RWsOiFJOLcghcvciwL4JAZpENhYQTOeA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=JE12Z8Tv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=8UBSZ3CPERXQL7PUxz+usY7jAyaOeTmlOGtmJcYuGPE=; b=JE12Z8Tv5u09jay1
	O0F0oPywQ839bNZBNDiDekmsC4wd4mqVF2lEVamfq9ZpOBJ5vEBNFzwQGtcocDd92FdRRnZljS/R/
	n6WEN3GuwhAZOpSGm8/mH1CD3p1TkG7OFBWdG3Rvi9essrSeDrdDyI9JCLq1U0XT8rny0wENS/6bi
	wy1oLKjPU1VYgII8fZ4zrBY0+IgrSjbnfAkFhJ7i7LtV0X0DPQgf4IeIBgxd7iGYdw6Vbh4/adr7B
	lgK7wDboya8De/Nu/Xl7Qpp9ECYew39LPJYMhtz0H0GvNOs62huVdSXR5XO4I3LrxXeWsYCk86dr6
	O7dP5f43psbY1YZtiw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tCKhB-000IUT-1s;
	Sat, 16 Nov 2024 15:26:45 +0000
From: linux@treblig.org
To: dmichail@fungible.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net/fungible: Remove unused fun_create_queue
Date: Sat, 16 Nov 2024 15:26:44 +0000
Message-ID: <20241116152644.96423-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

fun_create_queue was added in 2022 by
commit e1ffcc66818f ("net/fungible: Add service module for Fungible
drivers")
but hasn't been used.

Remove it.

Also remove the static helper functions it was the only user of.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../net/ethernet/fungible/funcore/fun_queue.c | 65 -------------------
 .../net/ethernet/fungible/funcore/fun_queue.h |  1 -
 2 files changed, 66 deletions(-)

diff --git a/drivers/net/ethernet/fungible/funcore/fun_queue.c b/drivers/net/ethernet/fungible/funcore/fun_queue.c
index 8ab9f68434f5..d07ee3e4f52a 100644
--- a/drivers/net/ethernet/fungible/funcore/fun_queue.c
+++ b/drivers/net/ethernet/fungible/funcore/fun_queue.c
@@ -482,43 +482,6 @@ struct fun_queue *fun_alloc_queue(struct fun_dev *fdev, int qid,
 	return NULL;
 }
 
-/* Create a funq's CQ on the device. */
-static int fun_create_cq(struct fun_queue *funq)
-{
-	struct fun_dev *fdev = funq->fdev;
-	unsigned int rqid;
-	int rc;
-
-	rqid = funq->cq_flags & FUN_ADMIN_EPCQ_CREATE_FLAG_RQ ?
-		funq->rqid : FUN_HCI_ID_INVALID;
-	rc = fun_cq_create(fdev, funq->cq_flags, funq->cqid, rqid,
-			   funq->cqe_size_log2, funq->cq_depth,
-			   funq->cq_dma_addr, 0, 0, funq->cq_intcoal_nentries,
-			   funq->cq_intcoal_usec, funq->cq_vector, 0, 0,
-			   &funq->cqid, &funq->cq_db);
-	if (!rc)
-		dev_dbg(fdev->dev, "created CQ %u\n", funq->cqid);
-
-	return rc;
-}
-
-/* Create a funq's SQ on the device. */
-static int fun_create_sq(struct fun_queue *funq)
-{
-	struct fun_dev *fdev = funq->fdev;
-	int rc;
-
-	rc = fun_sq_create(fdev, funq->sq_flags, funq->sqid, funq->cqid,
-			   funq->sqe_size_log2, funq->sq_depth,
-			   funq->sq_dma_addr, funq->sq_intcoal_nentries,
-			   funq->sq_intcoal_usec, funq->cq_vector, 0, 0,
-			   0, &funq->sqid, &funq->sq_db);
-	if (!rc)
-		dev_dbg(fdev->dev, "created SQ %u\n", funq->sqid);
-
-	return rc;
-}
-
 /* Create a funq's RQ on the device. */
 int fun_create_rq(struct fun_queue *funq)
 {
@@ -561,34 +524,6 @@ int fun_request_irq(struct fun_queue *funq, const char *devname,
 	return rc;
 }
 
-/* Create all component queues of a funq  on the device. */
-int fun_create_queue(struct fun_queue *funq)
-{
-	int rc;
-
-	rc = fun_create_cq(funq);
-	if (rc)
-		return rc;
-
-	if (funq->rq_depth) {
-		rc = fun_create_rq(funq);
-		if (rc)
-			goto release_cq;
-	}
-
-	rc = fun_create_sq(funq);
-	if (rc)
-		goto release_rq;
-
-	return 0;
-
-release_rq:
-	fun_destroy_sq(funq->fdev, funq->rqid);
-release_cq:
-	fun_destroy_cq(funq->fdev, funq->cqid);
-	return rc;
-}
-
 void fun_free_irq(struct fun_queue *funq)
 {
 	if (funq->irq_handler) {
diff --git a/drivers/net/ethernet/fungible/funcore/fun_queue.h b/drivers/net/ethernet/fungible/funcore/fun_queue.h
index 7fb53d0ae8b0..2d966afb187a 100644
--- a/drivers/net/ethernet/fungible/funcore/fun_queue.h
+++ b/drivers/net/ethernet/fungible/funcore/fun_queue.h
@@ -163,7 +163,6 @@ static inline void fun_set_cq_callback(struct fun_queue *funq, cq_callback_t cb,
 }
 
 int fun_create_rq(struct fun_queue *funq);
-int fun_create_queue(struct fun_queue *funq);
 
 void fun_free_irq(struct fun_queue *funq);
 int fun_request_irq(struct fun_queue *funq, const char *devname,
-- 
2.47.0


