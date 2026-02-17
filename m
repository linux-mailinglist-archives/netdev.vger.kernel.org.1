Return-Path: <netdev+bounces-259162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNVSC4PolGmjIgIAu9opvQ
	(envelope-from <netdev+bounces-259162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:15:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD286151605
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 873233040FB3
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780AB30C36C;
	Tue, 17 Feb 2026 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="mUISRKdo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC22F60CB;
	Tue, 17 Feb 2026 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366525; cv=none; b=AxxrdcUyMTcF4qnb/4dFGpdGQAd+VVtbqgbJbfZ//zkPJAroNtV5h/zr0U3scSm6wLS1ZzvmdVViXdGiwKGi7pMB8soaMexQ46kD0hXd87oDze7VujMvnaQvSThJUfWQhFPgpUMC1sClm9EazFCe1Ie+W9x0mLRJODnz/4tW/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366525; c=relaxed/simple;
	bh=heKb6MrFAu3tIgBtbRbmX+zvHl1ztoqxBVo9HgIEXu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBLHLiXe11I16grHD2wQ/bjWy9PqNPCbIDoF6gL1ey0KfaX7E93SvZPUxyPUcK7ihQuaphc7FF3F2oUv+pU5+7WEEhrVvUYywSRBd2J/s3rGT7zJ+FToKldaN04Rm84eCN4Erf/q7+nk33H9rdfwIRQ1a+WQt55mXHjInLc7X/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=mUISRKdo; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HKj3OR1425520;
	Tue, 17 Feb 2026 22:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=67nrQyy018UcYBfpBBJaDTXp+rfIoPYxntW71kQV9Bg=; b=mUIS
	RKdoHRuY8GfSTGWUmLGONyCEhpunq04J+6CpAI4ohzjBo94NwG+JV7+q5xOwtDlb
	zfKzm28RXakY+orMG9JWAIFHvjjrtBqRnFS6qrIvpgy5NzElA7flVkR6mj5gplYv
	SHKEKPuiKm8Y3m3NnqRM9mbKk712qhgOWqoJOcrgiUxyL4Whiyt7y2nhAPlk2MpO
	KTGGWLJVAO2Z4OU7drIFw7vvLsEyMRgELvdEDBOvVRcalfPsgaIX2zHpo/zVsM18
	3Z57yFwhsJ9Swgme1L5vesl2Nu9hyWT/iT3uAxXA8eubdW51oKMo3M4R+EMfZHZC
	d/O4Nigec1yVGdVtcQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ccyn38901-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 22:14:48 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 22:14:42 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
        <jolsa@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-open-source@crowdstrike.com>,
        Slava Imameev
	<slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Support multi-level pointer params via PTR_TO_MEM for trampolines
Date: Wed, 18 Feb 2026 09:13:56 +1100
Message-ID: <20260217221357.18215-2-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260217221357.18215-1-slava.imameev@crowdstrike.com>
References: <20260217221357.18215-1-slava.imameev@crowdstrike.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH016.crowdstrike.sys (10.100.11.68) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: oBoKmURo78jGNU5xJfUUy8ZVnDqzxetF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE4MyBTYWx0ZWRfX98Q/fmcJ60F/
 gAuML1B/x2agSJ9MrGAkQuRVLmI1MJR2UUls47KhpR9d/L8bdDTqlUTfOsvXdYb3oTCQbE9TnhC
 lfzLdxEiy738mnYx+eYYV0R0BZ5I7/hOdgKvLXPjVk4O9VTLMO1UJ/WjVH2f+4+inCdhmIR8Jbj
 KQBloJyvL680NNvrjRrW2BxQl0Y7kuYiLNtvBfGdyscXoqCq66xriISbKRYEIzsgPvYutU5lhLQ
 zxlER+4Xkd5nrSeW4YOrzHzHhM6C/9SyOtUmGtlzLSrOH7TldQq2H0kVkMtpCia1Dct3DxZC09R
 IjuoumeYTKbqSg+auGll3DkpB9Xs3q8Oxq5ooafH8Dx+1c9g6iI5x+WjfvgX0J1mvS+YCTOY8fr
 eZXcSDtUc5n5UsVfye14Qj18xsa849bpG2bVeNJy5ss0QETcuTxN94bRp6JtvEskYLVyvbQ6Q8A
 7KZ1J4WvOTaetiDVJaA==
X-Authority-Analysis: v=2.4 cv=bOMb4f+Z c=1 sm=1 tr=0 ts=6994e858 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pl6vuDidAAAA:8
 a=YxQJZ6zyij23mKzqByIA:9
X-Proofpoint-GUID: oBoKmURo78jGNU5xJfUUy8ZVnDqzxetF
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11704
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1011 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170183
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-259162-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,crowdstrike.com:mid,crowdstrike.com:dkim,crowdstrike.com:email]
X-Rspamd-Queue-Id: BD286151605
X-Rspamd-Action: no action

Add BPF verifier support for multi-level pointer parameters and return
values in BPF trampolines. The implementation treats these parameters as
PTR_TO_MEM with read-only semantics, applying either untrusted or trusted
access patterns while honoring __nullable annotations. Runtime safety is
ensured through existing exception handling mechanisms for untrusted
memory reads, with the verifier enforcing bounds checking and null
validation.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
---
 include/linux/bpf.h   |  3 ++-
 kernel/bpf/btf.c      | 54 ++++++++++++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c |  4 +++-
 3 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cd9b96434904..6dd6a85cf13a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1052,7 +1052,8 @@ struct bpf_insn_access_aux {
 			struct btf *btf;
 			u32 btf_id;
 			u32 ref_obj_id;
-		};
+		}; /* base type PTR_TO_BTF_ID */
+		u32 mem_size; /* base type PTR_TO_MEM */
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
 	bool is_retval; /* is accessing function return value ? */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7708958e3fb8..7b7cb30cdc98 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -760,6 +760,21 @@ const struct btf_type *btf_type_resolve_func_ptr(const struct btf *btf,
 	return NULL;
 }
 
+static bool is_multilevel_ptr(const struct btf *btf, const struct btf_type *t)
+{
+	u32 depth = 0;
+
+	if (!btf_type_is_ptr(t))
+		return false;
+
+	do {
+		depth += 1;
+		t = btf_type_skip_modifiers(btf, t->type, NULL);
+	} while (btf_type_is_ptr(t) && depth < 2);
+
+	return depth > 1;
+}
+
 /* Types that act only as a source, not sink or intermediate
  * type when resolving.
  */
@@ -6790,6 +6805,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	const char *tag_value;
 	u32 nr_args, arg;
 	int i, ret;
+	bool trusted, nullable;
 
 	if (off % 8) {
 		bpf_log(log, "func '%s' offset %d is not multiple of 8\n",
@@ -6927,12 +6943,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		}
 	}
 
-	info->reg_type = PTR_TO_BTF_ID;
-	if (prog_args_trusted(prog))
-		info->reg_type |= PTR_TRUSTED;
-
-	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
-		info->reg_type |= PTR_MAYBE_NULL;
+	trusted = prog_args_trusted(prog);
+	nullable = btf_param_match_suffix(btf, &args[arg], "__nullable");
 
 	if (prog->expected_attach_type == BPF_TRACE_RAW_TP) {
 		struct btf *btf = prog->aux->attach_btf;
@@ -6953,7 +6965,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			if (strcmp(tname, raw_tp_null_args[i].func))
 				continue;
 			if (raw_tp_null_args[i].mask & (0x1ULL << (arg * 4)))
-				info->reg_type |= PTR_MAYBE_NULL;
+				nullable = true;
 			/* Is the current arg IS_ERR? */
 			if (raw_tp_null_args[i].mask & (0x2ULL << (arg * 4)))
 				ptr_err_raw_tp = true;
@@ -6964,9 +6976,35 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		 * argument as PTR_MAYBE_NULL.
 		 */
 		if (i == ARRAY_SIZE(raw_tp_null_args) && btf_is_module(btf))
-			info->reg_type |= PTR_MAYBE_NULL;
+			nullable = true;
 	}
 
+	if (is_multilevel_ptr(btf, t)) {
+		/* If it can be IS_ERR at runtime, mark as scalar. */
+		if (ptr_err_raw_tp) {
+			bpf_log(log, "marking func '%s' pointer arg%d as scalar as it may encode error",
+				tname, arg);
+			info->reg_type = SCALAR_VALUE;
+		} else {
+			info->reg_type = PTR_TO_MEM | MEM_RDONLY;
+			if (!trusted)
+				info->reg_type |= PTR_UNTRUSTED;
+			/* for return value be conservative and mark it nullable */
+			if (nullable || arg == nr_args)
+				info->reg_type |= PTR_MAYBE_NULL;
+			/* this is a pointer to another pointer */
+			info->mem_size = sizeof(void *);
+		}
+		return true;
+	}
+
+	info->reg_type = PTR_TO_BTF_ID;
+	if (trusted)
+		info->reg_type |= PTR_TRUSTED;
+
+	if (nullable)
+		info->reg_type |= PTR_MAYBE_NULL;
+
 	if (tgt_prog) {
 		enum bpf_prog_type tgt_type;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0162f946032f..5de56336e169 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6311,7 +6311,7 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 					off);
 				return -EACCES;
 			}
-		} else {
+		} else if (base_type(info->reg_type) != PTR_TO_MEM) {
 			env->insn_aux_data[insn_idx].ctx_field_size = info->ctx_field_size;
 		}
 		/* remember the offset of last byte accessed in ctx */
@@ -7771,6 +7771,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 					regs[value_regno].btf = info.btf;
 					regs[value_regno].btf_id = info.btf_id;
 					regs[value_regno].ref_obj_id = info.ref_obj_id;
+				} else if (base_type(info.reg_type) == PTR_TO_MEM) {
+					regs[value_regno].mem_size = info.mem_size;
 				}
 			}
 			regs[value_regno].type = info.reg_type;
-- 
2.50.1 (Apple Git-155)


