Return-Path: <netdev+bounces-259155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGRzH23klGnhIgIAu9opvQ
	(envelope-from <netdev+bounces-259155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:58:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A53151386
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97F38301DF4F
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358330AD06;
	Tue, 17 Feb 2026 21:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="mLaaq3S/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C23090E4;
	Tue, 17 Feb 2026 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365482; cv=none; b=tPJlRO/8y1LuU7ToVi99sdKW/iipTyGffFe4GGFmOqMzmcHRgt4z1cVKeW4T+LY6AAPA6yItmv55RZe/0x+WPG1WoVH9RlC1SqgvvcfQ1cAobxSLjGqfau8JI6NxjHT2C1twiX1lQxBx+uMKKfba9ADiynuVPMZqrFnDPedt4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365482; c=relaxed/simple;
	bh=heKb6MrFAu3tIgBtbRbmX+zvHl1ztoqxBVo9HgIEXu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0tbl3w2mL7+eXSVIlWOdXmhzrNfnzRX3/x0clDetR5QnBC1nYhBJgblj9TELf3L7CWHa+M7aKWMRk3cewW3ZEY4nz+4zfuITgvlpIvffuyY5m9On41uPYPL11UXzPXV5SanxirzAdo9NOpIbUoLAxPXd5zVgzJY/Dz+Hwa6VWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=mLaaq3S/; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HK0ssQ2661410;
	Tue, 17 Feb 2026 21:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=67nrQyy018UcYBfpBBJaDTXp+rfIoPYxntW71kQV9Bg=; b=mLaa
	q3S/o+8k8yC1L3hY1YZoLMTLt4xUzml9NJsCUl//D8Ml4R9OUyme00XqhxHaHc+l
	swPC/rnANlY3+C1wrOvR1npYgIENtrnTuOfqRXtHJabPkk7Uur4Y0nTdKbCuuXRB
	rQp9bdawK4gBbnCXOCgLrAtDLRiIlPfBjs9Dqsfr+CDOGXgxcdi4tgcdsypRzBOQ
	Dd70X4v+9JTZ3VOV1iLJeFQhgZtEQToIetkDY7KTQgGK7uqfwVO46mVlat+2jQvj
	qasxGXKUuuEyUaXNdkKPE/vPxwtQH7CBahg6slk+IKWConYE170O1ge+Az0935Zw
	GdqhoYTEH0hoqZRGdw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cb6v0hame-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 21:45:55 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 21:45:49 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <sast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC: <sartin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
        <jolsa@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-open-source@crowdstrike.com>,
        Slava Imameev
	<slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next 1/2] bpf: Support multi-level pointer params via PTR_TO_MEM for trampolines
Date: Wed, 18 Feb 2026 08:45:32 +1100
Message-ID: <20260217214533.17776-2-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260217214533.17776-1-slava.imameev@crowdstrike.com>
References: <20260217214533.17776-1-slava.imameev@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: cz0KxEb7LKONrF9PvWx6V_ksS6aaONtj
X-Proofpoint-GUID: cz0KxEb7LKONrF9PvWx6V_ksS6aaONtj
X-Authority-Analysis: v=2.4 cv=VNPQXtPX c=1 sm=1 tr=0 ts=6994e194 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pl6vuDidAAAA:8
 a=YxQJZ6zyij23mKzqByIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE3OSBTYWx0ZWRfXyC1fMcfvQJ8+
 zjWMKSVHiSxYUVACufzXE1SIDFwKZyDxOOEJrxWzCkg+sc7NfPa26xlsjRm5L/qA2lP0HN/YWvP
 +TdMEJv93F+xvIJ2De/r7S2B98GrktIp+uoZ7vXgXoS72TKyuORhbhS8p1hAhRfpptXi0RHz5p1
 onWwmlNUQfFqnNcUOml6m1qJhuNmYrOPaOXCjzOhi0PMndVGja91RVEWb8JafDyeVLIfCC5S+RG
 nMa1m9qJjNd2ETJJnPLhQQAQaOo5+79yHTnc6JBuSUhYnyRHSbITcL41zhhyrjFGyHdwfvYNJFF
 4pavJBQ1XK9NtvH9jIw9PwtGpO2W45gYyYVT4uztUz0AzIyY/kVHn/v0YIj3ObAnFJtoff5jtDe
 0GJ4eAkw9Er/eya/8sAEvmH2Qtb/JH54u5tZLVLpM96h0rH5epMZ/YKH0Dn7y9QPJS0bm+45EXI
 aYyVOp04P7K19NMjIpQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11704
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170179
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-259155-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,crowdstrike.com:mid,crowdstrike.com:dkim,crowdstrike.com:email]
X-Rspamd-Queue-Id: 39A53151386
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


