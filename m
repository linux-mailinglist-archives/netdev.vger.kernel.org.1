Return-Path: <netdev+bounces-182009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C0A87516
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 02:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A1518906A0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D058E70825;
	Mon, 14 Apr 2025 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Uucgo6y0"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F743151;
	Mon, 14 Apr 2025 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744592009; cv=none; b=lknntkvpIRy2IndguZXRW9Sss4jIKd2zw+B5jSp0BjkhwHtII/+71RhANDNnWy33fRxY/80Wgwb/PBK6hHxgHWbQspaXMeW1LNPwKCeWWugOGukRPZp6bUnMorpz3+AL5FqksZoi/+/1dvevISYocdt2Hyf0OZEXhtFGXKmo014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744592009; c=relaxed/simple;
	bh=aCj8JqX/4cv0NRJgoZbH5rGUNTJaBLRzzQHov4BFfn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsuuSin4/ugMhk2nnIqCxCLTB/MZ7Qqh5EguJBzSf1QVh7jrH8vaZMs4ArfwazyKAZ4xqD4EO8sLZWRFU1Cm37LlBDuczAAlX+aSo2dSLp6ST0UmaJVEf2kQ16GqPveq2rvjdXUcNE0UaWX28Li0o6PX44PxSOsUFrouBXCVOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Uucgo6y0; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=9ysz9tg4GbGM8KCco0QGfv3y00KLcOekLNUM3KT5ywc=; b=Uucgo6y0ISNqLZ+F
	wFc+VsaWuSGrtE+jXe5HSvMfsdZhAP4VQvBaEUSfjnTljlciFjGcDmD/jdev1+prUZe3GO9Qed4HA
	Db91CExcrABiegcWLsCN+EmskTK8qvrAv4Oi/0hC9nCfly5Mxl5gKybafhDVFpOCF555IMYZrjsdS
	zLYzGyuC511hsNJ4JXpQzsKirlIZcre85fbrvnNCosMheI67bvBiXUGdU7Ki+UUlwGIgkJEBPF0I0
	1eCHyvO5f7qgOsCJzkQm9L+Lyj0cSn+Lua3Pum9KqL3/LBMhFNLr1W4QsqATqNn/d+GMACSBX3NGL
	If5Jfgz96LAGICLLwg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u484e-00B6OC-07;
	Mon, 14 Apr 2025 00:53:20 +0000
From: linux@treblig.org
To: manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 3/5] qed: Remove unused qed_ptt_invalidate
Date: Mon, 14 Apr 2025 01:52:45 +0100
Message-ID: <20250414005247.341243-4-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414005247.341243-1-linux@treblig.org>
References: <20250414005247.341243-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

qed_ptt_invalidate() was added in 2015 as part of
commit fe56b9e6a8d9 ("qed: Add module with basic common support")
but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/qlogic/qed/qed_hw.c | 11 -----------
 drivers/net/ethernet/qlogic/qed/qed_hw.h |  9 ---------
 2 files changed, 20 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_hw.c b/drivers/net/ethernet/qlogic/qed/qed_hw.c
index 9e5f0dbc8a07..9907973399dc 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hw.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_hw.c
@@ -69,17 +69,6 @@ int qed_ptt_pool_alloc(struct qed_hwfn *p_hwfn)
 	return 0;
 }
 
-void qed_ptt_invalidate(struct qed_hwfn *p_hwfn)
-{
-	struct qed_ptt *p_ptt;
-	int i;
-
-	for (i = 0; i < PXP_EXTERNAL_BAR_PF_WINDOW_NUM; i++) {
-		p_ptt = &p_hwfn->p_ptt_pool->ptts[i];
-		p_ptt->pxp.offset = QED_BAR_INVALID_OFFSET;
-	}
-}
-
 void qed_ptt_pool_free(struct qed_hwfn *p_hwfn)
 {
 	kfree(p_hwfn->p_ptt_pool);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_hw.h b/drivers/net/ethernet/qlogic/qed/qed_hw.h
index e535983ce21b..3c98f58a184f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hw.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hw.h
@@ -61,15 +61,6 @@ enum _dmae_cmd_crc_mask {
  */
 void qed_gtt_init(struct qed_hwfn *p_hwfn);
 
-/**
- * qed_ptt_invalidate(): Forces all ptt entries to be re-configured
- *
- * @p_hwfn: HW device data.
- *
- * Return: Void.
- */
-void qed_ptt_invalidate(struct qed_hwfn *p_hwfn);
-
 /**
  * qed_ptt_pool_alloc(): Allocate and initialize PTT pool.
  *
-- 
2.49.0


