Return-Path: <netdev+bounces-182011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9887DA8751D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 02:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E68C7A7B72
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435B15B115;
	Mon, 14 Apr 2025 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="QaCb4klh"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA77483;
	Mon, 14 Apr 2025 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744592025; cv=none; b=rk6rLT7LP9tfM/P2EOHf/2M67ZYPH458iKjiy+8eJKrTNED+c70Bvu+0+2CnN2cfgYDBRMJUBZnhq0xHKuboLz2Xf4f3k7Dnzjnv/9aKsXU4LtWLnB7GrfbXuonn0/H+zgeTujjsPCWAj66XSVLMZ2em5v+yuyqEK9rxdVDv3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744592025; c=relaxed/simple;
	bh=5LgjGmbeAbyuA2oxz2CuckC0PL4cwfnn4oCcCSDAWbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfIDfjNyrcEbJCwBCo8zLNwQ6Jh8K9S4SB/0geRpZLO/ZXqSmnPtEihlfTtltoWSR/z0mpgNx0eeJVu1TbnCxukRD+Hc2Dvj0/FtvUF+2Qj1RtTFhqN+Tl2SfF4zG21YgYu0PHgtOVuLafoaP4qGO2EpkqmtON5vvWa1saN6cl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=QaCb4klh; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=mszcztkCsSN4S8dihwOkYEm86zUy3fblRN6AQg5iZjc=; b=QaCb4klhndz5FV7G
	1pIlPPczQCCeSw2dygHuHhKZwde2vrH+tflAJXmvQsO0NtgEuRuUreicjxdCR0AtzKmHtP0bd3FB/
	aOI2S9Tq9AHAhulRVthZ0YkXgRw0p4nIt8/wGlS05cBWahJyWXDfvn3iedzuNlrCMxrYuhkwKUXBo
	dsjwF1C+VyvEuyLK+L22QCj0BG+EglMJEx9mpo4mGf4vafI9jLjYU5fD4yuty04UjhfhlB3QX1BMg
	GX3UcS98+WTAjJDMzSavQHk4+9CUgJmDE8JerjNJCevVcaLQaxqQd9V45h+rkeVl3GOODRLw/u+pH
	im4b45DzDWiRsgyCHw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u484u-00B6OC-2j;
	Mon, 14 Apr 2025 00:53:36 +0000
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
Subject: [PATCH net-next 5/5] qed: Remove unused qed_db_recovery_dp
Date: Mon, 14 Apr 2025 01:52:47 +0100
Message-ID: <20250414005247.341243-6-linux@treblig.org>
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

qed_db_recovery_dp() was added in 2018 as part of
commit 36907cd5cd72 ("qed: Add doorbell overflow recovery mechanism")
but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/qlogic/qed/qed.h     |  1 -
 drivers/net/ethernet/qlogic/qed/qed_dev.c | 19 -------------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed.h b/drivers/net/ethernet/qlogic/qed/qed.h
index b7def3b54937..016b575861b9 100644
--- a/drivers/net/ethernet/qlogic/qed/qed.h
+++ b/drivers/net/ethernet/qlogic/qed/qed.h
@@ -939,7 +939,6 @@ u16 qed_get_cm_pq_idx_ofld_mtc(struct qed_hwfn *p_hwfn, u8 tc);
 u16 qed_get_cm_pq_idx_llt_mtc(struct qed_hwfn *p_hwfn, u8 tc);
 
 /* doorbell recovery mechanism */
-void qed_db_recovery_dp(struct qed_hwfn *p_hwfn);
 void qed_db_recovery_execute(struct qed_hwfn *p_hwfn);
 bool qed_edpm_enabled(struct qed_hwfn *p_hwfn);
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 86a93cac2647..9659ce5b0712 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -255,25 +255,6 @@ static void qed_db_recovery_teardown(struct qed_hwfn *p_hwfn)
 	p_hwfn->db_recovery_info.db_recovery_counter = 0;
 }
 
-/* Print the content of the doorbell recovery mechanism */
-void qed_db_recovery_dp(struct qed_hwfn *p_hwfn)
-{
-	struct qed_db_recovery_entry *db_entry = NULL;
-
-	DP_NOTICE(p_hwfn,
-		  "Displaying doorbell recovery database. Counter was %d\n",
-		  p_hwfn->db_recovery_info.db_recovery_counter);
-
-	/* Protect the list */
-	spin_lock_bh(&p_hwfn->db_recovery_info.lock);
-	list_for_each_entry(db_entry,
-			    &p_hwfn->db_recovery_info.list, list_entry) {
-		qed_db_recovery_dp_entry(p_hwfn, db_entry, "Printing");
-	}
-
-	spin_unlock_bh(&p_hwfn->db_recovery_info.lock);
-}
-
 /* Ring the doorbell of a single doorbell recovery entry */
 static void qed_db_recovery_ring(struct qed_hwfn *p_hwfn,
 				 struct qed_db_recovery_entry *db_entry)
-- 
2.49.0


