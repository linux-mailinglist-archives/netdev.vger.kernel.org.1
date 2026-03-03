Return-Path: <netdev+bounces-263105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAuLKP2wpmn9SgAAu9opvQ
	(envelope-from <netdev+bounces-263105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:59:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E61E1EC333
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A02BF3119C9C
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA439020D;
	Tue,  3 Mar 2026 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="fvDp4hUN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6538E5E1;
	Tue,  3 Mar 2026 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772531728; cv=none; b=kOOSkR/7r3DARre0CWFjFgtsL2J5mKN5xjzcJ19D9IYWq0ibwmtMAXBDoVv+x2pafcm2LfEb40VbP4HVhkmfwxJOS8e/V+KOAhnr6f61vGgIwdPOWUQeyWcmydCCUnLIhESowlh5VR3lEqvx6flKopLoYALd0ZdTVKwT9+IIsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772531728; c=relaxed/simple;
	bh=aqLH8ocFhLDoUC00qHQd8qXLp0Xqn9DcMC526wnNjk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogTpo0sYkl7F3grHo7V6HMRG/8SK9MF59cswftIWb3C6Wrs90dAzbATmiUyC7MQK8Xsenq5bbcdfL7Aq2Q42OAnBYqgpF1sPLnEKNtX83OWIEaIGn4tFIX3lSxDAsZMJV2ETqPE/I3Z0mI7YPLB4lbp8HIHUhskqrajblBSuhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=fvDp4hUN; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6238pZ8f1450669;
	Tue, 3 Mar 2026 09:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=5qWweZGuFK4Q+FGMJ9P7zInqyh1a5ID4/GIO0LCzeic=; b=fvDp
	4hUNzx7629VOsolYTkUqF8eLft6IDcF/mNbGZMFD5zif+cMvJV5f48ZbCU4Sl/sf
	mqaT6fwgBlw5pHJJhRb34hsuzTVqD4iyyIwyxWTioaXkQD9BwGOysqu4Hi8FsdyJ
	c1rUvatE8C5o5WfHEQevSuHd7MROJb37qnSIYfejMzx5Jbo6RpjjuxnYvc7x6wGc
	KJMzFGTCjeAzLF8Vyc34gUtvasOizAra76rWeGoJ23zqS/WLJv+8oL2KCcj/lXjb
	rlBzQC+DBmrNtjclI11KV0uek1LUM14wVweWd5PnDaQlA9Fji+l+2R3jgOEgl/H1
	ViT2bgSMNVYy9maEug==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cmcu98e08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 09:55:00 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Mar 2026 09:54:54 +0000
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
Subject: [PATCH bpf-next v4 1/2] bpf: Support new pointer param types via SCALAR_VALUE for trampolines
Date: Tue, 3 Mar 2026 20:54:25 +1100
Message-ID: <20260303095427.38981-2-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303095427.38981-1-slava.imameev@crowdstrike.com>
References: <20260303095427.38981-1-slava.imameev@crowdstrike.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH010.crowdstrike.sys (10.100.11.80) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NCBTYWx0ZWRfX7l2zm/hqM996
 QyEywVFOWOXb9HFk2D0OFV4OL+YOOzS37f6Phhf0fnDIXUGeZSFRXeRjdvYYJGq/KdXA5WwUkSk
 vS/JTu+u7DztEEKUBkH6HtlM0eiChQKb5Z6gMrSoeGyPcpab4Kb7OzEfkOSyjQ1Sst5FBXYIYq4
 QPU+pLnemBdY4KPEqsKwPuanB8sOfydzDMjC+qJHwoirp2JQvaGz89KDetusEw4sazaWx/jgv2B
 pJ6DXG8N9KzHZTcK5p2P64uKNdKUVVLZRYa6zmTSxPKsBSd2Vq5GqixEKJxa35kJlGzPOsWXMlf
 CUj1qK/Z9peXlMkgTcY8RYsRQKxH0U9vv0XpZIYjc51UyuVq8+jz4O6tbh1TQhJqiXZbHyxmmfM
 5KZ6u4oyt0KAqdhP+jfHCbn0zFeQWlQ25lZC0jiVnCboxKFWgaC9xPBFspPfjkU398RCnqXePCt
 Vq9Hf4Sqk9xRlvzP46g==
X-Proofpoint-GUID: VG-09MfEDo6rg4eSuLoV0EYeFDsWgFva
X-Proofpoint-ORIG-GUID: VG-09MfEDo6rg4eSuLoV0EYeFDsWgFva
X-Authority-Analysis: v=2.4 cv=Nr/cssdJ c=1 sm=1 tr=0 ts=69a6aff4 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=pl6vuDidAAAA:8
 a=meFQ9lGWdDfeh2_n-QAA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030074
X-Rspamd-Queue-Id: 4E61E1EC333
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263105-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crowdstrike.com:dkim,crowdstrike.com:email,crowdstrike.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add BPF verifier support for single- and multi-level pointer
parameters and return values in BPF trampolines. The implementation
treats these parameters as SCALAR_VALUE.

The following new single level pointer support is added:
- pointers to enum, 32 and 64
- pointers to functions

The following multi-level pointer support is added:
- multi-level pointers to int
- multi-level pointers to void
- multi-level pointers to enum, 32 and 64
- multi-level pointers to function
- multi-level pointers to structure

This is consistent with the existing pointers to int and void
already treated as SCALAR.

This provides consistent logic for single and multi-level pointers
- if the type is treated as SCALAR for a single level pointer, the
same is applicable for multi-level pointers, except the pointer to
struct which is currently PTR_TO_BTF_ID, but in case of multi-level
pointer it is treated as scalar as the verifier lacks the context
to infer the size of their target memory regions.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
---
 kernel/bpf/btf.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..c2d06d2597d6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6508,11 +6508,30 @@ struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
 		return prog->aux->attach_btf;
 }
 
-static bool is_void_or_int_ptr(struct btf *btf, const struct btf_type *t)
+static bool is_ptr_treated_as_scalar(const struct btf *btf,
+	const struct btf_type *t)
 {
-	/* skip modifiers */
+	int depth = 1;
+
+	WARN_ON(!btf_type_is_ptr(t));
+
 	t = btf_type_skip_modifiers(btf, t->type, NULL);
-	return btf_type_is_void(t) || btf_type_is_int(t);
+	while (btf_type_is_ptr(t) && depth < MAX_RESOLVE_DEPTH) {
+		depth += 1;
+		t = btf_type_skip_modifiers(btf, t->type, NULL);
+	}
+
+	/*
+	 * If it's a single or multilevel pointer to void, int, enum,
+	 * or function, it's the same as scalar from the verifier
+	 * safety POV. Multilevel pointers to structures are treated as
+	 * scalars. The verifier lacks the context to infer the size of
+	 * their target memory regions. Either way, no further pointer
+	 * walking is allowed.
+	 */
+	return btf_type_is_void(t) || btf_type_is_int(t) ||
+		   btf_is_any_enum(t) || btf_type_is_func_proto(t) ||
+		   (btf_type_is_struct(t) && depth > 1);
 }
 
 u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
@@ -6902,11 +6921,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		}
 	}
 
-	/*
-	 * If it's a pointer to void, it's the same as scalar from the verifier
-	 * safety POV. Either way, no futher pointer walking is allowed.
-	 */
-	if (is_void_or_int_ptr(btf, t))
+	if (is_ptr_treated_as_scalar(btf, t))
 		return true;
 
 	/* this is a pointer to another type */
-- 
2.34.1


