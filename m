Return-Path: <netdev+bounces-291656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB6VEGl6FWrHVAcAu9opvQ
	(envelope-from <netdev+bounces-291656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:48:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D500E5D45F6
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90E86300D4EA
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F153DDDB4;
	Tue, 26 May 2026 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bxpX6bPU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FE3DD856;
	Tue, 26 May 2026 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792482; cv=none; b=f2XIZq864Efotv0+nK8GJq9+J36klthWnj5aXiy+OSWVuV1fmgp5+OKuscCLPCGiprPLPXvlyG1rXVm9pHdyZ0EhYDeO9ptsVpdUYQvJ4LV5DakTbV/pMweyZwvjuq6rdWfQpyeSsto9IKrFKLdtqeuxqDd2ZfZoOj3rhjo5SEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792482; c=relaxed/simple;
	bh=AxBR4ImyWIfpmueRBJLJnmZwuLmvl0HB6U1QhXKmIwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cmt8+a+O9lAKLpYprm62fqbthMg9i362V7Vlkkq5VbcZ2BLGKMVGYUsGYl2kBRiu0CfbREYw+RRwLEmXL4TS8PNLrpnocjjobhGsDf94J630ned64gtg3kK+HllR2hsu+T6ajVg81xE8z9cUpmQJAOrvUndWTFj4m+1+FGCKMsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bxpX6bPU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QAlMtJ1342135;
	Tue, 26 May 2026 03:47:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=i3UrjkfyGNkDqgrlMrOlrsYZJ
	KWtNS0AMhzA5iG9zQc=; b=bxpX6bPUMTM+dnN3Zq/42hLsrxorcu0mzBnnWtkyG
	AsM9iKvBkEvOir8aAG7CKcxaoVVoOTPJsomr9o/zNtalD+fkatXZrwbKq5E8FZlP
	V5gp5YNwaDvuIZ23TVyMNRw8ZN2pRFfMO21+FiUSvkZ2jvH+PrlQ+NAJIWa5mggL
	ZkS7cnJLBhpsF8Y6wVjYZwKpcFvH5dinW5nrKSXaAA4qVqHiJlR4WWwnkduIbztv
	UV7CLZ7vxFc5QqbqPzLVp8INrti67+DudNZMGCctq5EI2kVSRoXei5cPpTJzDIVt
	37v2B/Hm1UXO2WF4ZjIFhIlCF/SiXZeKwCtPJ9CrzF6KQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ebbrf7ung-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 03:47:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 26 May 2026 03:47:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 26 May 2026 03:47:37 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 2A5243F7052;
	Tue, 26 May 2026 03:47:33 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net-next PATCH v6 1/5] octeontx2-af: Simplify NPA context writing and reading
Date: Tue, 26 May 2026 16:17:23 +0530
Message-ID: <1779792447-5593-2-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1779792447-5593-1-git-send-email-sbhatta@marvell.com>
References: <1779792447-5593-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=epTvCIpX c=1 sm=1 tr=0 ts=6a157a4a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=Hh8S9ZQ4bCWoy7TokGkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: zplzl9E80eg9ytQhxjXTTtfDCIrDue6C
X-Proofpoint-GUID: zplzl9E80eg9ytQhxjXTTtfDCIrDue6C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5MyBTYWx0ZWRfX7I21BPtOu3hl
 BepsBA7Jg/Cj53y8mn0ZNMQSP3NWJ+fA51z2dDp0JHpYILvHcwUAMQOXUx4nJFPunTZfNrHBXjR
 HLUeMj7tWNJhWL4VuUj/GIbYETaSR/OA4z6J6VLJ0xCyz53TsOTMBBmCCCjgzDNBhQEhTVLjK9F
 tMqEWksm/3Fc3p46WWPyLp4IqCurtqLJkjKm0SfPNku1GGXRhTgBrX6bxy6zUCiiwsB3/5sSM40
 Khkgsc5QfXJP0gK6+n4Wp9o0jKDG7GVnLhsxCVAp0rWfXdTXOcgTG+fk/XsZpDgKhDTPh5WrgT7
 qZJQaii0UJrTueFowrajQiW8z5+fWOy/toqXY7yT+QeAPyucRziwpZkOs4jgDAJdZTY46DzDstg
 I/il4HhqrLz05hLTS8gGPxnR6zygzNfx9fsbhF7im2tnqXy/mdVmhSBjl49ftMRsSZza7YBHrJt
 LPc192AadeC3XkZU4AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291656-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.995];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D500E5D45F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplify NPA context reading and writing by using hardware
maximum context size instead of using individual sizes of
each context type.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   | 20 ++++++++-----------
 .../marvell/octeontx2/af/rvu_struct.h         |  6 ++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
index e2a33e46b48a..df783c4e5d75 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
@@ -116,13 +116,11 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 	case NPA_AQ_INSTOP_WRITE:
 		/* Copy context and write mask */
 		if (req->ctype == NPA_AQ_CTYPE_AURA) {
-			memcpy(mask, &req->aura_mask,
-			       sizeof(struct npa_aura_s));
-			memcpy(ctx, &req->aura, sizeof(struct npa_aura_s));
+			memcpy(mask, &req->aura_mask, NIX_MAX_CTX_SIZE);
+			memcpy(ctx, &req->aura, NIX_MAX_CTX_SIZE);
 		} else {
-			memcpy(mask, &req->pool_mask,
-			       sizeof(struct npa_pool_s));
-			memcpy(ctx, &req->pool, sizeof(struct npa_pool_s));
+			memcpy(mask, &req->pool_mask, NIX_MAX_CTX_SIZE);
+			memcpy(ctx, &req->pool, NIX_MAX_CTX_SIZE);
 		}
 		break;
 	case NPA_AQ_INSTOP_INIT:
@@ -134,9 +132,9 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 			/* Set pool's context address */
 			req->aura.pool_addr = pfvf->pool_ctx->iova +
 			(req->aura.pool_addr * pfvf->pool_ctx->entry_sz);
-			memcpy(ctx, &req->aura, sizeof(struct npa_aura_s));
+			memcpy(ctx, &req->aura, NIX_MAX_CTX_SIZE);
 		} else { /* POOL's context */
-			memcpy(ctx, &req->pool, sizeof(struct npa_pool_s));
+			memcpy(ctx, &req->pool, NIX_MAX_CTX_SIZE);
 		}
 		break;
 	case NPA_AQ_INSTOP_NOP:
@@ -196,11 +194,9 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 		/* Copy read context into mailbox */
 		if (req->op == NPA_AQ_INSTOP_READ) {
 			if (req->ctype == NPA_AQ_CTYPE_AURA)
-				memcpy(&rsp->aura, ctx,
-				       sizeof(struct npa_aura_s));
+				memcpy(&rsp->aura, ctx, NIX_MAX_CTX_SIZE);
 			else
-				memcpy(&rsp->pool, ctx,
-				       sizeof(struct npa_pool_s));
+				memcpy(&rsp->pool, ctx, NIX_MAX_CTX_SIZE);
 		}
 	}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index 8e868f815de1..1e51ed197b29 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -227,8 +227,12 @@ struct npa_aura_s {
 	u64 fc_msh_dst            : 11;
 	u64 reserved_435_447      : 13;
 	u64 reserved_448_511;		/* W7 */
+	/* Ensure all context sizes are 128 bytes */
+	u64 padding[8];
 };
 
+static_assert(sizeof(struct npa_aura_s) == NIX_MAX_CTX_SIZE);
+
 struct npa_pool_s {
 	u64 stack_base;			/* W0 */
 	u64 ena                   : 1;
@@ -285,6 +289,8 @@ struct npa_pool_s {
 	u64 reserved_960_1023;		/* W15 */
 };
 
+static_assert(sizeof(struct npa_pool_s) == NIX_MAX_CTX_SIZE);
+
 /* NIX admin queue completion status */
 enum nix_aq_comp {
 	NIX_AQ_COMP_NOTDONE        = 0x0,
-- 
2.48.1


