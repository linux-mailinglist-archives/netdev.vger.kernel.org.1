Return-Path: <netdev+bounces-182008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D472AA87515
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 02:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1399718906A0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F10D156236;
	Mon, 14 Apr 2025 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="l4HqNPD0"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9914B07A;
	Mon, 14 Apr 2025 00:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744592002; cv=none; b=AcZrBqMXC30qq8GBXqRdbhP7o64ns3z3EJxT6S8zDZ8hxSQL2EP61CGjl2sruuR2l01AM7Y+w0p4puYED9i71x/OJrgpy3CADsV2wANiSnpEHAKuYnwl5qMzJ+TJ7RsfuGco0FlwaV8/AW9xbokSH1gBdARUy86/yseBtmUx0rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744592002; c=relaxed/simple;
	bh=pr/yPxQHKZ5KHK6oqGF78AqmNyHBYY9Hga61WU9PcBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpM+BYVBNULXkqdoIe8I4jVP2pWwOb3bMRqLQMLqNdTk6LKgUiW6xBXIKQDUqClg17ALRitvvLO2iToDTGMSHmP8zI5z2iITPoMTCV1I1YVg5V5VEcn75RH/A12xg6Sq+U1LoYl/N3TJ+aA3DcQZNcEr9r5FyDJZ2yseuajuatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=l4HqNPD0; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Ec9EXE3QNJBExnlVHquaSThfwEN1yWp7OFB+KWM4m2o=; b=l4HqNPD00UBCO+8d
	UC/rEyWfR4w3I8muAK1YVGSNVTRwdK5Ag5YIB32bDINvjUgo3iqM1k9bBNx7S/UKSPYR4s+hwFHrG
	6OEIsz7NFWYWVxoLuVoJ7f9tojygf8hjxBdo9NU30ng6pvRd7N9VsNJwsqTJgV4geVCEiQVXvKf4S
	VhIrnFyHZzobcnEtF1UYtv87e4gMZ5r9Y62wa682J9ypBCu9m5sh5QfztjugzDpWTth2NZqnprjve
	ImlzsBEYlIp2h48xIFWZyYtmH9KMpITIgub/VwCHic78jIFO+xgDQdzHS1UpG0nLbhLNenSP/aCjS
	qcW+r4jUA/mlz73VWA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u484X-00B6OC-07;
	Mon, 14 Apr 2025 00:53:13 +0000
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
Subject: [PATCH net-next 2/5] qed: Remove unused qed_calc_*_ctx_validation functions
Date: Mon, 14 Apr 2025 01:52:44 +0100
Message-ID: <20250414005247.341243-3-linux@treblig.org>
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

qed_calc_session_ctx_validation() and qed_calc_task_ctx_validation()
were added as part of 2017's
commit da09091732ae ("qed*: Utilize FW 8.33.1.0")

but have remained unused.

Remove them.

This leaves; con_region_offsets[], task_region_offsets[],
cdu_crc8_table and qed_calc_cdu_validation_byte() unused.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/qlogic/qed/qed_hsi.h     |  28 -----
 .../ethernet/qlogic/qed/qed_init_fw_funcs.c   | 100 ------------------
 2 files changed, 128 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
index 3181fed1274e..10e355397cee 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -2666,34 +2666,6 @@ void qed_gft_config(struct qed_hwfn *p_hwfn,
 void qed_enable_context_validation(struct qed_hwfn *p_hwfn,
 				   struct qed_ptt *p_ptt);
 
-/**
- * qed_calc_session_ctx_validation(): Calcualte validation byte for
- *                                    session context.
- *
- * @p_ctx_mem: Pointer to context memory.
- * @ctx_size: Context size.
- * @ctx_type: Context type.
- * @cid: Context cid.
- *
- * Return: Void.
- */
-void qed_calc_session_ctx_validation(void *p_ctx_mem,
-				     u16 ctx_size, u8 ctx_type, u32 cid);
-
-/**
- * qed_calc_task_ctx_validation(): Calcualte validation byte for task
- *                                 context.
- *
- * @p_ctx_mem: Pointer to context memory.
- * @ctx_size: Context size.
- * @ctx_type: Context type.
- * @tid: Context tid.
- *
- * Return: Void.
- */
-void qed_calc_task_ctx_validation(void *p_ctx_mem,
-				  u16 ctx_size, u8 ctx_type, u32 tid);
-
 #define NUM_STORMS 6
 
 /**
diff --git a/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c b/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
index 4b9128c08ad3..aa20bb8caa9a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
@@ -18,16 +18,6 @@
 
 #define CDU_VALIDATION_DEFAULT_CFG CDU_CONTEXT_VALIDATION_DEFAULT_CFG
 
-static u16 con_region_offsets[3][NUM_OF_CONNECTION_TYPES] = {
-	{400, 336, 352, 368, 304, 384, 416, 352},	/* region 3 offsets */
-	{528, 496, 416, 512, 448, 512, 544, 480},	/* region 4 offsets */
-	{608, 544, 496, 576, 576, 592, 624, 560}	/* region 5 offsets */
-};
-
-static u16 task_region_offsets[1][NUM_OF_CONNECTION_TYPES] = {
-	{240, 240, 112, 0, 0, 0, 0, 96}	/* region 1 offsets */
-};
-
 /* General constants */
 #define QM_PQ_MEM_4KB(pq_size)	(pq_size ? DIV_ROUND_UP((pq_size + 1) *	\
 							QM_PQ_ELEMENT_SIZE, \
@@ -1576,96 +1566,6 @@ void qed_gft_config(struct qed_hwfn *p_hwfn,
 	qed_wr(p_hwfn, p_ptt, PRS_REG_SEARCH_GFT, 1);
 }
 
-DECLARE_CRC8_TABLE(cdu_crc8_table);
-
-/* Calculate and return CDU validation byte per connection type/region/cid */
-static u8 qed_calc_cdu_validation_byte(u8 conn_type, u8 region, u32 cid)
-{
-	const u8 validation_cfg = CDU_VALIDATION_DEFAULT_CFG;
-	u8 crc, validation_byte = 0;
-	static u8 crc8_table_valid; /* automatically initialized to 0 */
-	u32 validation_string = 0;
-	__be32 data_to_crc;
-
-	if (!crc8_table_valid) {
-		crc8_populate_msb(cdu_crc8_table, 0x07);
-		crc8_table_valid = 1;
-	}
-
-	/* The CRC is calculated on the String-to-compress:
-	 * [31:8]  = {CID[31:20],CID[11:0]}
-	 * [7:4]   = Region
-	 * [3:0]   = Type
-	 */
-	if ((validation_cfg >> CDU_CONTEXT_VALIDATION_CFG_USE_CID) & 1)
-		validation_string |= (cid & 0xFFF00000) | ((cid & 0xFFF) << 8);
-
-	if ((validation_cfg >> CDU_CONTEXT_VALIDATION_CFG_USE_REGION) & 1)
-		validation_string |= ((region & 0xF) << 4);
-
-	if ((validation_cfg >> CDU_CONTEXT_VALIDATION_CFG_USE_TYPE) & 1)
-		validation_string |= (conn_type & 0xF);
-
-	/* Convert to big-endian and calculate CRC8 */
-	data_to_crc = cpu_to_be32(validation_string);
-	crc = crc8(cdu_crc8_table, (u8 *)&data_to_crc, sizeof(data_to_crc),
-		   CRC8_INIT_VALUE);
-
-	/* The validation byte [7:0] is composed:
-	 * for type A validation
-	 * [7]          = active configuration bit
-	 * [6:0]        = crc[6:0]
-	 *
-	 * for type B validation
-	 * [7]          = active configuration bit
-	 * [6:3]        = connection_type[3:0]
-	 * [2:0]        = crc[2:0]
-	 */
-	validation_byte |=
-	    ((validation_cfg >>
-	      CDU_CONTEXT_VALIDATION_CFG_USE_ACTIVE) & 1) << 7;
-
-	if ((validation_cfg >>
-	     CDU_CONTEXT_VALIDATION_CFG_VALIDATION_TYPE_SHIFT) & 1)
-		validation_byte |= ((conn_type & 0xF) << 3) | (crc & 0x7);
-	else
-		validation_byte |= crc & 0x7F;
-
-	return validation_byte;
-}
-
-/* Calcualte and set validation bytes for session context */
-void qed_calc_session_ctx_validation(void *p_ctx_mem,
-				     u16 ctx_size, u8 ctx_type, u32 cid)
-{
-	u8 *x_val_ptr, *t_val_ptr, *u_val_ptr, *p_ctx;
-
-	p_ctx = (u8 * const)p_ctx_mem;
-	x_val_ptr = &p_ctx[con_region_offsets[0][ctx_type]];
-	t_val_ptr = &p_ctx[con_region_offsets[1][ctx_type]];
-	u_val_ptr = &p_ctx[con_region_offsets[2][ctx_type]];
-
-	memset(p_ctx, 0, ctx_size);
-
-	*x_val_ptr = qed_calc_cdu_validation_byte(ctx_type, 3, cid);
-	*t_val_ptr = qed_calc_cdu_validation_byte(ctx_type, 4, cid);
-	*u_val_ptr = qed_calc_cdu_validation_byte(ctx_type, 5, cid);
-}
-
-/* Calcualte and set validation bytes for task context */
-void qed_calc_task_ctx_validation(void *p_ctx_mem,
-				  u16 ctx_size, u8 ctx_type, u32 tid)
-{
-	u8 *p_ctx, *region1_val_ptr;
-
-	p_ctx = (u8 * const)p_ctx_mem;
-	region1_val_ptr = &p_ctx[task_region_offsets[0][ctx_type]];
-
-	memset(p_ctx, 0, ctx_size);
-
-	*region1_val_ptr = qed_calc_cdu_validation_byte(ctx_type, 1, tid);
-}
-
 /* Enable and configure context validation */
 void qed_enable_context_validation(struct qed_hwfn *p_hwfn,
 				   struct qed_ptt *p_ptt)
-- 
2.49.0


