Return-Path: <netdev+bounces-284544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNpIOrEy+mlXKgMAu9opvQ
	(envelope-from <netdev+bounces-284544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:10:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B554D2848
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E843330117EA
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE4F4A2E27;
	Tue,  5 May 2026 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="WZ3D8Zc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7464A2E13
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004652; cv=none; b=F/1+Oqf+kQDVQML2/vsPqsnvUzMjMt25bEHC4pnj+HaK1TiqmJk90HBkJsjy7gsUOZBh8sRxAnb8ghpmKe0UN9CACF6rrQyLr8tasWVyH1wk0fYzeD+68IcDcDf2whfDBmDpFbTqN0p+zeRHKtxmrtKCwxSQSV4kqqXwW/9cXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004652; c=relaxed/simple;
	bh=w9UcMhLhbZCgnxbCCuRa6knool1Ui/K5FQ8MLmhItXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CqCtE6pkq5N+KmvkQIoWB3K5+iwNQhhRDi5f9JjFYs7NvGBZsH9OSJ0J6sYuc6q/negn9l8ejFOkdhlER3xsbUx0GIbSf0hSbRBgkmd/5p0qaIWRhduqWyGQCJ3ZB5DHJ1k9FheLnvlrx+1Hb4EuqFXPeBebclOg5VnLXZmyHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=WZ3D8Zc6; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so4138356eec.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778004650; x=1778609450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G1mnF59M55VOMvghpS9JTzvOFDKUpRveiW72mobnymg=;
        b=WZ3D8Zc6pFVxAvCi/R1eMyD6jOK03mGdcqzH12FP7bkdpjAsNWmuY1B8SJ9kbIjUbd
         EGcYGKOeElaFSlU/g3PWTdXe71sSl7WqdDWrpP1o9wiqR9bONiZz5zZTQxipBfO09O5t
         QHRZSygjNER4FkAXWtsncnFYQ90A7gWs/2JrB3AV2lPmVW1m3I9GmBXgHlQLnXxq132h
         hvczHczX1zIaZJnlyJCiuk7OjI1sd/7+JbV5FHv6yn15Q6l+MH/tXD6+CFZbpFkyiuZB
         oRCFGES6YkQ4Nh7jJqCdzbVqqqGVtUNCDl2W0/az5hrNIRrXjMTc7S2ADqNtLLN22KUR
         4ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778004650; x=1778609450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1mnF59M55VOMvghpS9JTzvOFDKUpRveiW72mobnymg=;
        b=pY/cMq805vK87Z2R4S94UvP9azpgK30xorgjIgNI6TPFzKXSF+4sulczajiroff9Ui
         EqBe8ZhjwLhU2lihUkiBpqD6U6yrAyij3aq4px8kag1lWXfq0dBw0cP4VFmMEu/Bnr1A
         CYBUVk8z3zzuR7tnlG8YrbCLDXpZALe6cblyuGP0XaCj6sjQCTwEgy2NmTR6r163nfDK
         D+Bh8ZfoRDq8F/hdgDQWtfZmU8gHx8UhwiY3fHll9nRYa3T7YBeMjTjRdiKTnFcw85bh
         pSj8Boix5wZ2Nw1ITcUDXAi6aACu1fr7EK1jOnWFYEX471JBGeDH4WMPOp4UAEHIG9Pr
         SgvA==
X-Gm-Message-State: AOJu0Yw7DWH3VYTcLtzVFdaPaSX8xRa9vl4mQc3d/7kuyzOtTPv+ukL5
	YUfj5swakJSp3TUwi3sVvNmRBMFgu8cMe1DWBDKXbiUIzeLk2DVqHsgxsxJj3PAnQT0U58uOovA
	ZY6h1
X-Gm-Gg: AeBDiet2p2F/I0l7e0iUOapvZFSSw7NZvu99KnXvyzsuUeCNw7lu74S9iojuHlWxppi
	Do+DaRUxIH0fcQkKSEHalbghppYE2JRfYyWk/MsulrhjPOP/F6UxGiUl3vlViJSXeqwjmVw5yDS
	dd8RWholtZals3ilJTgSQyH3TYmH9K3bwA3hHn3ASGuOKiKanBF50M6uwXO//8OTC+2Wv8wAVm/
	Ps51HxbjO6A0YUq6oVTn2dr9AwgdQ97T/jT5/TkklrjxVp4AIF5X8UEmV0H2u8Uul/0L9th0cnD
	BOGKrQbkzaEMI2qJ9aQp7BfW+ymzqKkvAxqoRf653DfbWeHLA/VZAMKuqkJI9+BSwOlX9l2CTz6
	S40FiKZ04VL24VMHyfgTo2Ldyu24SVwFFc6+aFpoaoSBoIc9JoJpAjkwbaBK6JaBHF1T/c2ac9Q
	11uf7BUktIJxFrFB6r1zNHAIhqJniiOJTANm9MT5H6Wbg=
X-Received: by 2002:a05:693c:2c01:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-2f54b265a7dmr180703eec.23.1778004650162;
        Tue, 05 May 2026 11:10:50 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889cf53sm28344237eec.5.2026.05.05.11.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:10:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] rdama: sync kernel headers and fix build
Date: Tue,  5 May 2026 11:10:44 -0700
Message-ID: <20260505181045.748088-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98B554D2848
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284544-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber.org:email,networkplumber-org.20251104.gappssmtp.com:dkim]

The upstream kernel removed the 'RES_' prefix from RDMA netlink
command and attribute names, but the rdma tool was still using
the old names, causing build failures.

Update all references to match the new kernel header names:
- RDMA_NLDEV_CMD_RES_FRMR_POOLS_* → RDMA_NLDEV_CMD_FRMR_POOLS_*
- RDMA_NLDEV_ATTR_RES_FRMR_POOL* → RDMA_NLDEV_ATTR_FRMR_POOL*
- RDMA_NLDEV_ATTR_FRMR_POOL_PINNED → RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES
- RDMA_NLDEV_ATTR_FRMR_POOL_AGING_PERIOD → RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD

  Fixes build error:
    res.h:203:26: error: 'RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET' undeclared

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 30 ++++----
 rdma/res-frmr-pools.c                 | 98 +++++++++++++--------------
 rdma/res.h                            |  2 +-
 3 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index 8709e558..4356ec4a 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -308,9 +308,9 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_MONITOR,
 
-	RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET, /* can dump */
+	RDMA_NLDEV_CMD_FRMR_POOLS_GET, /* can dump */
 
-	RDMA_NLDEV_CMD_RES_FRMR_POOLS_SET,
+	RDMA_NLDEV_CMD_FRMR_POOLS_SET,
 
 	RDMA_NLDEV_NUM_OPS
 };
@@ -590,19 +590,19 @@ enum rdma_nldev_attr {
 	/*
 	 * FRMR Pools attributes
 	 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOLS,			/* nested table */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_ENTRY,		/* nested table */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY,		/* nested table */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS,		/* u8 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS, /* u64 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE,	/* u64 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE,		/* u64 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,	/* u32 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,		/* u32 */
-	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY, /* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOLS,		/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY,	/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY,		/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS,	/* u8 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
 
 	/*
 	 * Always the end
diff --git a/rdma/res-frmr-pools.c b/rdma/res-frmr-pools.c
index abcd2188..d5faa5c1 100644
--- a/rdma/res-frmr-pools.c
+++ b/rdma/res-frmr-pools.c
@@ -80,83 +80,83 @@ static int res_frmr_pools_line(struct rd *rd, const char *name, int idx,
 	char key_str[FRMR_POOL_KEY_MAX_LEN];
 	struct frmr_pool_key key = { 0 };
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY]) {
+	if (nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_KEY]) {
 		if (mnl_attr_parse_nested(
-			    nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY],
+			    nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_KEY],
 			    rd_attr_cb, key_tb) != MNL_CB_OK)
 			return MNL_CB_ERROR;
 
-		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS])
+		if (key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS])
 			key.ats = mnl_attr_get_u8(
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS]);
-		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS])
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]);
+		if (key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS])
 			key.access_flags = mnl_attr_get_u32(
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS]);
-		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY])
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS]);
+		if (key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY])
 			key.vendor_key = mnl_attr_get_u64(
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY]);
-		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY]);
+		if (key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
 			key.num_dma_blocks = mnl_attr_get_u64(
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
-		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY])
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+		if (key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY])
 			kernel_vendor_key = mnl_attr_get_u64(
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY]);
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY]);
 
 		if (rd_is_filtered_attr(
 			    rd, "ats", key.ats,
-			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS]))
+			    key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]))
 			goto out;
 
 		if (rd_is_filtered_attr(
 			    rd, "access_flags", key.access_flags,
-			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS]))
+			    key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS]))
 			goto out;
 
 		if (rd_is_filtered_attr(
 			    rd, "vendor_key", key.vendor_key,
-			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY]))
+			    key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY]))
 			goto out;
 
 		if (rd_is_filtered_attr(
 			    rd, "num_dma_blocks", key.num_dma_blocks,
-			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS]))
+			    key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]))
 			goto out;
 	}
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES])
+	if (nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES])
 		queue_handles = mnl_attr_get_u32(
-			nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES]);
+			nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES]);
 	if (rd_is_filtered_attr(
 		    rd, "queue", queue_handles,
-		    nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES]))
+		    nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES]))
 		goto out;
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE])
+	if (nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE])
 		in_use = mnl_attr_get_u64(
-			nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE]);
+			nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]);
 	if (rd_is_filtered_attr(rd, "in_use", in_use,
-				nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE]))
+				nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]))
 		goto out;
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE])
+	if (nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE])
 		max_in_use = mnl_attr_get_u64(
-			nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE]);
+			nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]);
 	if (rd_is_filtered_attr(
 		    rd, "max_in_use", max_in_use,
-		    nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE]))
+		    nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]))
 		goto out;
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED])
+	if (nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES])
 		pinned_handles = mnl_attr_get_u32(
-			nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED]);
+			nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES]);
 	if (rd_is_filtered_attr(rd, "pinned", pinned_handles,
-				nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED]))
+				nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES]))
 		goto out;
 
 	open_json_object(NULL);
 	print_dev(idx, name);
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY]) {
+	if (nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_KEY]) {
 		snprintf(key_str, sizeof(key_str),
 			 "%" PRIx64 ":%" PRIx64 ":%x:%s",
 			 key.vendor_key, key.num_dma_blocks,
@@ -166,30 +166,30 @@ static int res_frmr_pools_line(struct rd *rd, const char *name, int idx,
 		if (rd->show_details) {
 			res_print_u32(
 				"ats", key.ats,
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS]);
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]);
 			res_print_u32(
 				"access_flags", key.access_flags,
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS]);
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS]);
 			res_print_u64(
 				"vendor_key", key.vendor_key,
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY]);
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY]);
 			res_print_u64(
 				"num_dma_blocks", key.num_dma_blocks,
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
 			res_print_u64(
 				"kernel_vendor_key", kernel_vendor_key,
-				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY]);
+				key_tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY]);
 		}
 	}
 
 	res_print_u32("queue", queue_handles,
-		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES]);
+		      nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES]);
 	res_print_u64("in_use", in_use,
-		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE]);
+		      nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]);
 	res_print_u64("max_in_use", max_in_use,
-		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE]);
+		      nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]);
 	res_print_u32("pinned", pinned_handles,
-		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED]);
+		      nla_line[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES]);
 
 	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
 	close_json_object();
@@ -215,12 +215,12 @@ int res_frmr_pools_parse_cb(const struct nlmsghdr *nlh, void *data)
 
 	mnl_attr_parse(nlh, 0, rd_attr_cb, tb);
 	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX] || !tb[RDMA_NLDEV_ATTR_DEV_NAME] ||
-	    !tb[RDMA_NLDEV_ATTR_RES_FRMR_POOLS])
+	    !tb[RDMA_NLDEV_ATTR_FRMR_POOLS])
 		return MNL_CB_ERROR;
 
 	name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);
 	idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
-	nla_table = tb[RDMA_NLDEV_ATTR_RES_FRMR_POOLS];
+	nla_table = tb[RDMA_NLDEV_ATTR_FRMR_POOLS];
 
 	mnl_attr_for_each_nested(nla_entry, nla_table) {
 		struct nlattr *nla_line[RDMA_NLDEV_ATTR_MAX] = {};
@@ -256,10 +256,10 @@ static int res_frmr_pools_one_set_aging(struct rd *rd)
 		return -EINVAL;
 	}
 
-	rd_prepare_msg(rd, RDMA_NLDEV_CMD_RES_FRMR_POOLS_SET, &seq,
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_FRMR_POOLS_SET, &seq,
 		       (NLM_F_REQUEST | NLM_F_ACK));
 	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX, rd->dev_idx);
-	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,
 			 aging_period);
 
 	return rd_sendrecv_msg(rd, seq);
@@ -294,24 +294,24 @@ static int res_frmr_pools_one_set_pinned(struct rd *rd)
 		return -EINVAL;
 	}
 
-	rd_prepare_msg(rd, RDMA_NLDEV_CMD_RES_FRMR_POOLS_SET, &seq,
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_FRMR_POOLS_SET, &seq,
 		       (NLM_F_REQUEST | NLM_F_ACK));
 	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX, rd->dev_idx);
 
-	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,
 			 pinned_value);
 
 	key_attr =
-		mnl_attr_nest_start(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY);
-	mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS,
+		mnl_attr_nest_start(rd->nlh, RDMA_NLDEV_ATTR_FRMR_POOL_KEY);
+	mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS,
 			pool_key.ats);
 	mnl_attr_put_u32(rd->nlh,
-			 RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS,
+			 RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,
 			 pool_key.access_flags);
-	mnl_attr_put_u64(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY,
+	mnl_attr_put_u64(rd->nlh, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,
 			 pool_key.vendor_key);
 	mnl_attr_put_u64(rd->nlh,
-			 RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS,
+			 RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,
 			 pool_key.num_dma_blocks);
 	mnl_attr_nest_end(rd->nlh, key_attr);
 
diff --git a/rdma/res.h b/rdma/res.h
index 8d7b4a0b..1f71115b 100644
--- a/rdma/res.h
+++ b/rdma/res.h
@@ -200,7 +200,7 @@ struct filters frmr_pools_valid_filters[MAX_NUMBER_OF_FILTERS] = {
 	{ .name = "pinned", .is_number = true },
 };
 
-RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
+RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_FRMR_POOLS_GET,
 	 frmr_pools_valid_filters, true, 0);
 
 int res_frmr_pools_set(struct rd *rd);
-- 
2.53.0


