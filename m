Return-Path: <netdev+bounces-182007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 912F6A87513
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 02:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFE61890724
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F399442A92;
	Mon, 14 Apr 2025 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="arqgkP8G"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA148F66;
	Mon, 14 Apr 2025 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744591995; cv=none; b=X7fO8FRYeGCUx1fDY1FJq5nGlNSXFtY8zzbbqlj2UCsDOiXLhKvbm1NC8wYlOrxGTis4lBcQ0ZkSr5YHOVwdwbyXQC4LDKFyxNGzah1otwE4P6NeiGAPETqC6URb5BGKpInJx2hw25rF4Sjj9rb7pEQ219aFpWwdRyYu9syEHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744591995; c=relaxed/simple;
	bh=+5WPSOKOJAuhqeY5OauOEQzIL7JOqS8n+v93p05JEN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwprvaiPEjVNNTmvtXSJhH9Dwkqc4coOn7oaH7/H27dK7/PYLQ9avAYjBlMV2viTW2KJELA/ckPmH5+Qn8i/RtZj9uweSGu6lKlwmxvIIE6dmV6Lr7HD6S/HWMxAZ5+HIK+y4IvyBo2Zx9Ql7o6rZtqAzFbshVwJSiPQoAKwcHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=arqgkP8G; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=nnRMCG9EM/ZVIQjUHE38dkH+p4UxD53w3hZZ34V5yDk=; b=arqgkP8GSmokLyTn
	fX0tq6cVFBcOEaxDgcn+8++BmkCDqt5hVvHcDs2I7Tigy2IhmEErQDUBIDAUb3R2pwNwWYDlQDOmb
	TnEo7M2Sr+kNXNbLZl50sj2UMFWdqjfCEgDxJSUW1/uFggvA3EXaE3yAIP2g4bPh7q5ZABLyaHFfp
	VapJf6Nnt3ytwq9xjRtbys5rnnH8RUFb7t2l2BYNjBwIDLsHZkbCYaE2e5R3/lxUSZVpY8hZxRrQY
	4SbRCpbYfWnqeTGjJIOrMfxJIoOKhQvsLZv0nQfIzZ7IRJsZuyCnq32rKq+1gAQoS6Xo65ON36oYJ
	lpWn72TTucrLiAtxCw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u484R-00B6OC-05;
	Mon, 14 Apr 2025 00:53:07 +0000
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
Subject: [PATCH net-next 1/5] qed: Remove unused qed_memset_*ctx functions
Date: Mon, 14 Apr 2025 01:52:43 +0100
Message-ID: <20250414005247.341243-2-linux@treblig.org>
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

qed_memset_session_ctx() and qed_memset_task_ctx() were added in 2017
as part of
commit da09091732ae ("qed*: Utilize FW 8.33.1.0")

but have not been used.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/qlogic/qed/qed_hsi.h     | 24 ------------
 .../ethernet/qlogic/qed/qed_init_fw_funcs.c   | 38 -------------------
 2 files changed, 62 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
index ed1a84542ad2..3181fed1274e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -2694,30 +2694,6 @@ void qed_calc_session_ctx_validation(void *p_ctx_mem,
 void qed_calc_task_ctx_validation(void *p_ctx_mem,
 				  u16 ctx_size, u8 ctx_type, u32 tid);
 
-/**
- * qed_memset_session_ctx(): Memset session context to 0 while
- *                            preserving validation bytes.
- *
- * @p_ctx_mem: Pointer to context memory.
- * @ctx_size: Size to initialzie.
- * @ctx_type: Context type.
- *
- * Return: Void.
- */
-void qed_memset_session_ctx(void *p_ctx_mem, u32 ctx_size, u8 ctx_type);
-
-/**
- * qed_memset_task_ctx(): Memset task context to 0 while preserving
- *                        validation bytes.
- *
- * @p_ctx_mem: Pointer to context memory.
- * @ctx_size: size to initialzie.
- * @ctx_type: context type.
- *
- * Return: Void.
- */
-void qed_memset_task_ctx(void *p_ctx_mem, u32 ctx_size, u8 ctx_type);
-
 #define NUM_STORMS 6
 
 /**
diff --git a/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c b/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
index 407029a36fa1..4b9128c08ad3 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
@@ -1666,44 +1666,6 @@ void qed_calc_task_ctx_validation(void *p_ctx_mem,
 	*region1_val_ptr = qed_calc_cdu_validation_byte(ctx_type, 1, tid);
 }
 
-/* Memset session context to 0 while preserving validation bytes */
-void qed_memset_session_ctx(void *p_ctx_mem, u32 ctx_size, u8 ctx_type)
-{
-	u8 *x_val_ptr, *t_val_ptr, *u_val_ptr, *p_ctx;
-	u8 x_val, t_val, u_val;
-
-	p_ctx = (u8 * const)p_ctx_mem;
-	x_val_ptr = &p_ctx[con_region_offsets[0][ctx_type]];
-	t_val_ptr = &p_ctx[con_region_offsets[1][ctx_type]];
-	u_val_ptr = &p_ctx[con_region_offsets[2][ctx_type]];
-
-	x_val = *x_val_ptr;
-	t_val = *t_val_ptr;
-	u_val = *u_val_ptr;
-
-	memset(p_ctx, 0, ctx_size);
-
-	*x_val_ptr = x_val;
-	*t_val_ptr = t_val;
-	*u_val_ptr = u_val;
-}
-
-/* Memset task context to 0 while preserving validation bytes */
-void qed_memset_task_ctx(void *p_ctx_mem, u32 ctx_size, u8 ctx_type)
-{
-	u8 *p_ctx, *region1_val_ptr;
-	u8 region1_val;
-
-	p_ctx = (u8 * const)p_ctx_mem;
-	region1_val_ptr = &p_ctx[task_region_offsets[0][ctx_type]];
-
-	region1_val = *region1_val_ptr;
-
-	memset(p_ctx, 0, ctx_size);
-
-	*region1_val_ptr = region1_val;
-}
-
 /* Enable and configure context validation */
 void qed_enable_context_validation(struct qed_hwfn *p_hwfn,
 				   struct qed_ptt *p_ptt)
-- 
2.49.0


