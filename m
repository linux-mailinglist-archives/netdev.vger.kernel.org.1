Return-Path: <netdev+bounces-271926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNkkKizuxGnN5AQAu9opvQ
	(envelope-from <netdev+bounces-271926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:28:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF51331573
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 577ED304F903
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6033B9D92;
	Thu, 26 Mar 2026 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="g/H7YcTC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD8E3B7B8C;
	Thu, 26 Mar 2026 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513512; cv=none; b=sr3E6SGX+VL0kTafqWaKUA3XsXP8O+ML47ZecKaf3M0xns7+sQfOMMKe5GrhdwCp5VSoumVXfzMAnrLqSccswZz5Q7GblAFk6hOurjv74NjV3gWc/iY3/da2HAi2o4MofLDco0mz3He+3l2GWTe+IBvBCgQp9EeZMck7Zb6bA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513512; c=relaxed/simple;
	bh=bqNEZi7KXaqGSdp7GxsexJ0t3pL6f6U04Q3clmuAHDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FF4JDsaXW77aEOyYRZYJ2udrBb+ZG5HF/IvSJMGjkNbbniE2w/jHUMaQz+zlWpOGvkhRf3upIpaBnzyEk6Kge9oupZblyd+YJOk5V8pdzY8tufVXqviF3jFAJROMNY4G0mBVNIMYBEp2LYfi7o5Mrj8woI6/ZAxUjJhRBvhhv+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=g/H7YcTC; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q7BTWo146934;
	Thu, 26 Mar 2026 01:01:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=YihP5uoMBXp8CK6HT/U4fOj6W
	buwTBlX5NK1moO1flo=; b=g/H7YcTCMCCwcePnLrz0XeyyCvjUPegMJKj81bW6I
	IobEFFuKibubeTkOZBqJBEIYbznpsaEoB8YeJYtVnnTdx3x+gmsEj7GcfgtprvmH
	dTd5RcbX09N7lzgiybsq4i7/UCBe8wg/dHhldgESVed5a/zsCUCwWTHaTbeRfdMc
	S0DUrnl+nGFeYF3JQMW4sXuXxojtX1KU9OlBRftY8Xj06u1c3Sh3YYY4cJCmP8wk
	yBKwr8V7JnF9U8fBPO2/taqhwskk//FJ/+BrtYE1pSIMJ1cJV8f5adChFC6qstl0
	ZX7h0utn8uO3tlU1CwDCGSEAA1l+3GEFMQSxjCDlBCvsA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d420jmnbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 01:01:07 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 01:01:07 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 01:01:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Mar 2026 01:01:05 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 573213F7070;
	Thu, 26 Mar 2026 01:01:01 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linu Cherian
	<lcherian@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 1/4] octeontx2-af: npa: cn20k: Add NPA Halo support
Date: Thu, 26 Mar 2026 13:30:45 +0530
Message-ID: <1774512048-10740-2-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1774512048-10740-1-git-send-email-sbhatta@marvell.com>
References: <1774512048-10740-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TV5jnvzBcWK4jOCEoiPItm8jUzKvaCJl
X-Authority-Analysis: v=2.4 cv=ULDQ3Sfy c=1 sm=1 tr=0 ts=69c4e7c4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=uxznE0pqxfRCp5ADcogA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: TV5jnvzBcWK4jOCEoiPItm8jUzKvaCJl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA1NyBTYWx0ZWRfX90ErJ1P5q4vn
 3XVraOC2Jal6tw3j3jVe6kB3VKliELhFQPZh2zPinQiX0geVxPlMpACpLATHV3Jwh3IpQ1AI0QS
 THgqs7HSNwTgwY3TRZlRcHPUyaEZ8wu362flzqu9vdTjdIlH/RsimG6LK59wmViaiYPe/6YGY10
 Y4k5tJAzhUh6WgHUXGED0VCe8TpapdEoWfWnyzwEfsXqB7uqSrfDvXCEaB/DKKIH9xvfhttS9t6
 8W3rFMg5eQBzOLCiGAUc9+D5cz8t03HkKZa38yfY37S1BdmtAQRf1Zexqoi3T9LGgGafF6Ei4ym
 rb8SLrgfxmdNssPiDPVGqitA0H34EUlUOYx8JF6n4WQj9V3nd4eKnxkEOqTTEOCXcM1/b/1HocG
 rqUoAhgJBHP067gafzF6iBZM3OZ1IeXwmdV5cVNvz5Ci5lOHqRl+TkBS/mQXk5tCygAHPGB522N
 bHytepLOZ6h+pUg5azQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271926-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AEF51331573
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Linu Cherian <lcherian@marvell.com>

CN20K silicon implements unified aura and pool context
type called Halo for better resource usage. Add support to
handle Halo context type operations.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c | 27 +++++++
 .../marvell/octeontx2/af/cn20k/struct.h       | 81 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  6 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   | 63 +++++++++++++--
 .../marvell/octeontx2/af/rvu_struct.h         |  1 +
 6 files changed, 173 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
index fe8f926c8b75..c963f43dc7b0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
@@ -19,3 +19,30 @@ int rvu_mbox_handler_npa_cn20k_aq_enq(struct rvu *rvu,
 				   (struct npa_aq_enq_rsp *)rsp);
 }
 EXPORT_SYMBOL(rvu_mbox_handler_npa_cn20k_aq_enq);
+
+int rvu_npa_halo_hwctx_disable(struct npa_aq_enq_req *req)
+{
+	struct npa_cn20k_aq_enq_req *hreq;
+
+	hreq = (struct npa_cn20k_aq_enq_req *)req;
+
+	hreq->halo.bp_ena_0 = 0;
+	hreq->halo.bp_ena_1 = 0;
+	hreq->halo.bp_ena_2 = 0;
+	hreq->halo.bp_ena_3 = 0;
+	hreq->halo.bp_ena_4 = 0;
+	hreq->halo.bp_ena_5 = 0;
+	hreq->halo.bp_ena_6 = 0;
+	hreq->halo.bp_ena_7 = 0;
+
+	hreq->halo_mask.bp_ena_0 = 1;
+	hreq->halo_mask.bp_ena_1 = 1;
+	hreq->halo_mask.bp_ena_2 = 1;
+	hreq->halo_mask.bp_ena_3 = 1;
+	hreq->halo_mask.bp_ena_4 = 1;
+	hreq->halo_mask.bp_ena_5 = 1;
+	hreq->halo_mask.bp_ena_6 = 1;
+	hreq->halo_mask.bp_ena_7 = 1;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
index 763f6cabd7c2..2364bafd329d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
@@ -377,4 +377,85 @@ struct npa_cn20k_pool_s {
 
 static_assert(sizeof(struct npa_cn20k_pool_s) == NIX_MAX_CTX_SIZE);
 
+struct npa_cn20k_halo_s {
+	u64 stack_base                  : 64;
+	u64 ena                         :  1;
+	u64 nat_align                   :  1;
+	u64 reserved_66_67              :  2;
+	u64 stack_caching               :  1;
+	u64 reserved_69_71              :  3;
+	u64 aura_drop_ena               :  1;
+	u64 reserved_73_79              :  7;
+	u64 aura_drop                   :  8;
+	u64 buf_offset                  : 12;
+	u64 reserved_100_103            :  4;
+	u64 buf_size                    : 12;
+	u64 reserved_116_119            :  4;
+	u64 ref_cnt_prof                :  3;
+	u64 reserved_123_127            :  5;
+	u64 stack_max_pages             : 32;
+	u64 stack_pages                 : 32;
+	u64 bp_0                        :  7;
+	u64 bp_1                        :  7;
+	u64 bp_2                        :  7;
+	u64 bp_3                        :  7;
+	u64 bp_4                        :  7;
+	u64 bp_5                        :  7;
+	u64 bp_6                        :  7;
+	u64 bp_7                        :  7;
+	u64 bp_ena_0                    :  1;
+	u64 bp_ena_1                    :  1;
+	u64 bp_ena_2                    :  1;
+	u64 bp_ena_3                    :  1;
+	u64 bp_ena_4                    :  1;
+	u64 bp_ena_5                    :  1;
+	u64 bp_ena_6                    :  1;
+	u64 bp_ena_7                    :  1;
+	u64 stack_offset                :  4;
+	u64 reserved_260_263            :  4;
+	u64 shift                       :  6;
+	u64 reserved_270_271            :  2;
+	u64 avg_level                   :  8;
+	u64 avg_con                     :  9;
+	u64 fc_ena                      :  1;
+	u64 fc_stype                    :  2;
+	u64 fc_hyst_bits                :  4;
+	u64 fc_up_crossing              :  1;
+	u64 reserved_297_299            :  3;
+	u64 update_time                 : 16;
+	u64 reserved_316_319            :  4;
+	u64 fc_addr                     : 64;
+	u64 ptr_start                   : 64;
+	u64 ptr_end                     : 64;
+	u64 bpid_0                      : 12;
+	u64 reserved_524_535            : 12;
+	u64 err_int                     :  8;
+	u64 err_int_ena                 :  8;
+	u64 thresh_int                  :  1;
+	u64 thresh_int_ena              :  1;
+	u64 thresh_up                   :  1;
+	u64 reserved_555                :  1;
+	u64 thresh_qint_idx             :  7;
+	u64 reserved_563                :  1;
+	u64 err_qint_idx                :  7;
+	u64 reserved_571_575            :  5;
+	u64 thresh                      : 36;
+	u64 reserved_612_615            :  4;
+	u64 fc_msh_dst                  : 11;
+	u64 reserved_627_630            :  4;
+	u64 op_dpc_ena                  :  1;
+	u64 op_dpc_set                  :  5;
+	u64 reserved_637_637            :  1;
+	u64 stream_ctx                  :  1;
+	u64 unified_ctx                 :  1;
+	u64 reserved_640_703            : 64;
+	u64 reserved_704_767            : 64;
+	u64 reserved_768_831            : 64;
+	u64 reserved_832_895            : 64;
+	u64 reserved_896_959            : 64;
+	u64 reserved_960_1023           : 64;
+};
+
+static_assert(sizeof(struct npa_cn20k_halo_s) == NIX_MAX_CTX_SIZE);
+
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index dc42c81c0942..4a97bd93d882 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -884,6 +884,8 @@ struct npa_cn20k_aq_enq_req {
 		struct npa_cn20k_aura_s aura;
 		/* Valid when op == WRITE/INIT and ctype == POOL */
 		struct npa_cn20k_pool_s pool;
+		/* Valid when op == WRITE/INIT and ctype == HALO */
+		struct npa_cn20k_halo_s halo;
 	};
 	/* Mask data when op == WRITE (1=write, 0=don't write) */
 	union {
@@ -891,6 +893,8 @@ struct npa_cn20k_aq_enq_req {
 		struct npa_cn20k_aura_s aura_mask;
 		/* Valid when op == WRITE and ctype == POOL */
 		struct npa_cn20k_pool_s pool_mask;
+		/* Valid when op == WRITE/INIT and ctype == HALO */
+		struct npa_cn20k_halo_s halo_mask;
 	};
 };
 
@@ -901,6 +905,8 @@ struct npa_cn20k_aq_enq_rsp {
 		struct npa_cn20k_aura_s aura;
 		/* Valid when op == READ and ctype == POOL */
 		struct npa_cn20k_pool_s pool;
+		/* Valid when op == READ and ctype == HALO */
+		struct npa_cn20k_halo_s halo;
 	};
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a466181cf908..36a71d32b894 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -261,6 +261,7 @@ struct rvu_pfvf {
 	struct qmem	*pool_ctx;
 	struct qmem	*npa_qints_ctx;
 	unsigned long	*aura_bmap;
+	unsigned long	*halo_bmap; /* Aura and Halo are mutually exclusive */
 	unsigned long	*pool_bmap;
 
 	/* NIX contexts */
@@ -1008,6 +1009,7 @@ void rvu_npa_freemem(struct rvu *rvu);
 void rvu_npa_lf_teardown(struct rvu *rvu, u16 pcifunc, int npalf);
 int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 			struct npa_aq_enq_rsp *rsp);
+int rvu_npa_halo_hwctx_disable(struct npa_aq_enq_req *req);
 
 /* NIX APIs */
 bool is_nixlf_attached(struct rvu *rvu, u16 pcifunc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
index e2a33e46b48a..809386c6bcba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
@@ -12,6 +12,11 @@
 #include "rvu_reg.h"
 #include "rvu.h"
 
+static bool npa_ctype_invalid(struct rvu *rvu, int ctype)
+{
+	return !is_cn20k(rvu->pdev) && ctype == NPA_AQ_CTYPE_HALO;
+}
+
 static int npa_aq_enqueue_wait(struct rvu *rvu, struct rvu_block *block,
 			       struct npa_aq_inst_s *inst)
 {
@@ -72,13 +77,19 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 	bool ena;
 
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
-	if (!pfvf->aura_ctx || req->aura_id >= pfvf->aura_ctx->qsize)
+	if (!pfvf->aura_ctx || req->aura_id >= pfvf->aura_ctx->qsize ||
+	    npa_ctype_invalid(rvu, req->ctype))
 		return NPA_AF_ERR_AQ_ENQUEUE;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, pcifunc);
 	if (!pfvf->npalf || blkaddr < 0)
 		return NPA_AF_ERR_AF_LF_INVALID;
 
+	/* Ensure halo bitmap is exclusive to halo ctype */
+	if (is_cn20k(rvu->pdev) && req->ctype != NPA_AQ_CTYPE_HALO &&
+	    test_bit(req->aura_id, pfvf->halo_bmap))
+		return NPA_AF_ERR_AQ_ENQUEUE;
+
 	block = &hw->block[blkaddr];
 	aq = block->aq;
 	if (!aq) {
@@ -119,7 +130,7 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 			memcpy(mask, &req->aura_mask,
 			       sizeof(struct npa_aura_s));
 			memcpy(ctx, &req->aura, sizeof(struct npa_aura_s));
-		} else {
+		} else { /* Applies to pool and halo since size is same */
 			memcpy(mask, &req->pool_mask,
 			       sizeof(struct npa_pool_s));
 			memcpy(ctx, &req->pool, sizeof(struct npa_pool_s));
@@ -135,7 +146,7 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 			req->aura.pool_addr = pfvf->pool_ctx->iova +
 			(req->aura.pool_addr * pfvf->pool_ctx->entry_sz);
 			memcpy(ctx, &req->aura, sizeof(struct npa_aura_s));
-		} else { /* POOL's context */
+		} else { /* Applies to pool and halo since size is same */
 			memcpy(ctx, &req->pool, sizeof(struct npa_pool_s));
 		}
 		break;
@@ -176,6 +187,20 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 		}
 	}
 
+	if (req->ctype == NPA_AQ_CTYPE_HALO) {
+		if (req->op == NPA_AQ_INSTOP_INIT && req->aura.ena)
+			__set_bit(req->aura_id, pfvf->halo_bmap);
+		if (req->op == NPA_AQ_INSTOP_WRITE) {
+			ena = (req->aura.ena & req->aura_mask.ena) |
+				(test_bit(req->aura_id, pfvf->halo_bmap) &
+				~req->aura_mask.ena);
+			if (ena)
+				__set_bit(req->aura_id, pfvf->halo_bmap);
+			else
+				__clear_bit(req->aura_id, pfvf->halo_bmap);
+		}
+	}
+
 	/* Set pool bitmap if pool hw context is enabled */
 	if (req->ctype == NPA_AQ_CTYPE_POOL) {
 		if (req->op == NPA_AQ_INSTOP_INIT && req->pool.ena)
@@ -198,7 +223,7 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 			if (req->ctype == NPA_AQ_CTYPE_AURA)
 				memcpy(&rsp->aura, ctx,
 				       sizeof(struct npa_aura_s));
-			else
+			else /* Applies to pool and halo since size is same */
 				memcpy(&rsp->pool, ctx,
 				       sizeof(struct npa_pool_s));
 		}
@@ -210,12 +235,14 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 static int npa_lf_hwctx_disable(struct rvu *rvu, struct hwctx_disable_req *req)
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
+	const char *context = "Unknown";
 	struct npa_aq_enq_req aq_req;
 	unsigned long *bmap;
 	int id, cnt = 0;
 	int err = 0, rc;
 
-	if (!pfvf->pool_ctx || !pfvf->aura_ctx)
+	if (!pfvf->pool_ctx || !pfvf->aura_ctx ||
+	    npa_ctype_invalid(rvu, req->ctype))
 		return NPA_AF_ERR_AQ_ENQUEUE;
 
 	memset(&aq_req, 0, sizeof(struct npa_aq_enq_req));
@@ -226,6 +253,7 @@ static int npa_lf_hwctx_disable(struct rvu *rvu, struct hwctx_disable_req *req)
 		aq_req.pool_mask.ena = 1;
 		cnt = pfvf->pool_ctx->qsize;
 		bmap = pfvf->pool_bmap;
+		context = "Pool";
 	} else if (req->ctype == NPA_AQ_CTYPE_AURA) {
 		aq_req.aura.ena = 0;
 		aq_req.aura_mask.ena = 1;
@@ -233,6 +261,14 @@ static int npa_lf_hwctx_disable(struct rvu *rvu, struct hwctx_disable_req *req)
 		aq_req.aura_mask.bp_ena = 1;
 		cnt = pfvf->aura_ctx->qsize;
 		bmap = pfvf->aura_bmap;
+		context = "Aura";
+	} else if (req->ctype == NPA_AQ_CTYPE_HALO) {
+		aq_req.aura.ena = 0;
+		aq_req.aura_mask.ena = 1;
+		rvu_npa_halo_hwctx_disable(&aq_req);
+		cnt = pfvf->aura_ctx->qsize;
+		bmap = pfvf->halo_bmap;
+		context = "Halo";
 	}
 
 	aq_req.ctype = req->ctype;
@@ -246,8 +282,7 @@ static int npa_lf_hwctx_disable(struct rvu *rvu, struct hwctx_disable_req *req)
 		if (rc) {
 			err = rc;
 			dev_err(rvu->dev, "Failed to disable %s:%d context\n",
-				(req->ctype == NPA_AQ_CTYPE_AURA) ?
-				"Aura" : "Pool", id);
+				context, id);
 		}
 	}
 
@@ -311,6 +346,9 @@ static void npa_ctx_free(struct rvu *rvu, struct rvu_pfvf *pfvf)
 	kfree(pfvf->aura_bmap);
 	pfvf->aura_bmap = NULL;
 
+	kfree(pfvf->halo_bmap);
+	pfvf->halo_bmap = NULL;
+
 	qmem_free(rvu->dev, pfvf->aura_ctx);
 	pfvf->aura_ctx = NULL;
 
@@ -374,6 +412,13 @@ int rvu_mbox_handler_npa_lf_alloc(struct rvu *rvu,
 	if (!pfvf->aura_bmap)
 		goto free_mem;
 
+	if (is_cn20k(rvu->pdev)) {
+		pfvf->halo_bmap = kcalloc(NPA_AURA_COUNT(req->aura_sz),
+					  sizeof(long), GFP_KERNEL);
+		if (!pfvf->halo_bmap)
+			goto free_mem;
+	}
+
 	/* Alloc memory for pool HW contexts */
 	hwctx_size = 1UL << ((ctx_cfg >> 4) & 0xF);
 	err = qmem_alloc(rvu->dev, &pfvf->pool_ctx, req->nr_pools, hwctx_size);
@@ -562,6 +607,10 @@ void rvu_npa_lf_teardown(struct rvu *rvu, u16 pcifunc, int npalf)
 	ctx_req.ctype = NPA_AQ_CTYPE_AURA;
 	npa_lf_hwctx_disable(rvu, &ctx_req);
 
+	/* Disable all Halos */
+	ctx_req.ctype = NPA_AQ_CTYPE_HALO;
+	npa_lf_hwctx_disable(rvu, &ctx_req);
+
 	npa_ctx_free(rvu, pfvf);
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index 8e868f815de1..d37cf2cf0fee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -130,6 +130,7 @@ enum npa_aq_comp {
 enum npa_aq_ctype {
 	NPA_AQ_CTYPE_AURA = 0x0,
 	NPA_AQ_CTYPE_POOL = 0x1,
+	NPA_AQ_CTYPE_HALO = 0x2,
 };
 
 /* NPA admin queue instruction opcodes */
-- 
2.48.1


