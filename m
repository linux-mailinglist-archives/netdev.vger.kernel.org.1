Return-Path: <netdev+bounces-182010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63DBA8751A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 02:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49C43B30A6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA59817A2FF;
	Mon, 14 Apr 2025 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="AwjNVKmR"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E17F43151;
	Mon, 14 Apr 2025 00:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744592014; cv=none; b=PpXTlRVybzfnd9sOu8OOTmFAgd5yvVPmMxHnbYvfAHonVSokwuZ9Eu7sQOd2ZhnRpx2MGeMobVDqduXQJ/S3Z7wL1yNsKbsRmo6dMFqxjzTg+K8i3Y0lfZRDPUoKZtd/yefZDIIKWKQWIsjod/t0iTq3QCZbPN5G19xVQKzYwvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744592014; c=relaxed/simple;
	bh=0dJx6qQvfNfojFk9k0f2kBRjXKUDS5dJir18HdeA+f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHOEXaRpxzLl+JXFlDRPzYXB7IiRWRTBSGg+66nsjGpxs1+qCdsNbkAvVkBNH10Xg2UDXgR1BiJ2I3afUxUJke7yRDdXQdRpvGRrWsoduFCs3wAErmGaYHIXGkhTjUjBwDdAOTuS2pijYG4GLG4EvwFrk3nQa+ezzW+MlQo/3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=AwjNVKmR; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ujec2vqyglbO8Jqq7vIM4fTyJ4h9Dn2I/69u+5A4eWE=; b=AwjNVKmRkbYiphu2
	boT0z7OygsP+cRUo7vYGKSIlMeoHm1iznE3GqiE6KIEAoV1CjCaf1osPYCbMVboQPZjqQF3iWlzob
	OiefUUB2zeTaH/gVQ5HB7lSpYdmucqJIVSMAg75hC/oUKgsUMypnuLyrY0355g3OjmtcwwVAAq+KY
	WXGGTbU+SYu2m6KEVl+z+91c3FRmNf/bt/1WPYy+ztxSEEh1nLQLBhlVvWbQzKzEug3Ct5jFA8fTA
	E7BNDCmL2JQQQ1JQCiswcKgX5v1pL4Q4kq+W35EJKWB6SfUCPTyCX0P6QTA6kG8Bxks3mp0gS4fb7
	WeGEaT9Jo4uGginpoA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u484k-00B6OC-0v;
	Mon, 14 Apr 2025 00:53:26 +0000
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
Subject: [PATCH net-next 4/5] qed: Remove unused qed_print_mcp_trace_*
Date: Mon, 14 Apr 2025 01:52:46 +0100
Message-ID: <20250414005247.341243-5-linux@treblig.org>
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

While most of the trace code is reachable by other routes
(I think mostly via the qed_features_lookup[] array), there
are a couple of unused wrappers.

qed_print_mcp_trace_line() and qed_print_mcp_trace_results_cont()
were added in 2018 as part of
commit a3f723079df8 ("qed*: Utilize FW 8.37.7.0")
but have remained unused.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dbg_hsi.h | 31 -------------------
 drivers/net/ethernet/qlogic/qed/qed_debug.c   | 25 ---------------
 2 files changed, 56 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dbg_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_dbg_hsi.h
index f6cd1b3efdfd..27e91d0d39f8 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dbg_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_dbg_hsi.h
@@ -1304,37 +1304,6 @@ enum dbg_status qed_print_mcp_trace_results(struct qed_hwfn *p_hwfn,
 					    u32 num_dumped_dwords,
 					    char *results_buf);
 
-/**
- * qed_print_mcp_trace_results_cont(): Prints MCP Trace results, and
- * keeps the MCP trace meta data allocated, to support continuous MCP Trace
- * parsing. After the continuous parsing ends, mcp_trace_free_meta_data should
- * be called to free the meta data.
- *
- * @p_hwfn: HW device data.
- * @dump_buf: MVP trace dump buffer, starting from the header.
- * @results_buf: Buffer for printing the mcp trace results.
- *
- * Return: Error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_print_mcp_trace_results_cont(struct qed_hwfn *p_hwfn,
-						 u32 *dump_buf,
-						 char *results_buf);
-
-/**
- * qed_print_mcp_trace_line(): Prints MCP Trace results for a single line
- *
- * @p_hwfn: HW device data.
- * @dump_buf: MCP trace dump buffer, starting from the header.
- * @num_dumped_bytes: Number of bytes that were dumped.
- * @results_buf: Buffer for printing the mcp trace results.
- *
- * Return: Error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_print_mcp_trace_line(struct qed_hwfn *p_hwfn,
-					 u8 *dump_buf,
-					 u32 num_dumped_bytes,
-					 char *results_buf);
-
 /**
  * qed_mcp_trace_free_meta_data(): Frees the MCP Trace meta data.
  * Should be called after continuous MCP Trace parsing.
diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index 464a72afb758..9c3d3dd2f847 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -7614,31 +7614,6 @@ enum dbg_status qed_print_mcp_trace_results(struct qed_hwfn *p_hwfn,
 					results_buf, &parsed_buf_size, true);
 }
 
-enum dbg_status qed_print_mcp_trace_results_cont(struct qed_hwfn *p_hwfn,
-						 u32 *dump_buf,
-						 char *results_buf)
-{
-	u32 parsed_buf_size;
-
-	return qed_parse_mcp_trace_dump(p_hwfn, dump_buf, results_buf,
-					&parsed_buf_size, false);
-}
-
-enum dbg_status qed_print_mcp_trace_line(struct qed_hwfn *p_hwfn,
-					 u8 *dump_buf,
-					 u32 num_dumped_bytes,
-					 char *results_buf)
-{
-	u32 parsed_results_bytes;
-
-	return qed_parse_mcp_trace_buf(p_hwfn,
-				       dump_buf,
-				       num_dumped_bytes,
-				       0,
-				       num_dumped_bytes,
-				       results_buf, &parsed_results_bytes);
-}
-
 /* Frees the specified MCP Trace meta data */
 void qed_mcp_trace_free_meta_data(struct qed_hwfn *p_hwfn)
 {
-- 
2.49.0


