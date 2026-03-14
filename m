Return-Path: <netdev+bounces-267686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGupM/catWlZwgAAu9opvQ
	(envelope-from <netdev+bounces-267686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:23:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A0628C1C9
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD671305C6F2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4043264E2;
	Sat, 14 Mar 2026 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="G92QFbWG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A9D3033E3;
	Sat, 14 Mar 2026 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773476551; cv=none; b=ZGn7b78QCNkMiBicpCoM6By0c64E2/P/mw+DxdMZGsptoz83pDZLFEU9rRHg2/G9DuQs3/muzi4ZO66cGmzdm+aXR5fcTTv8C+ORv5fx59rCa1Qo2MuEYjenQgC8thLFQzbveukouPxC64U+2B6E1ltEC/w5YXPxn3kkfb6OB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773476551; c=relaxed/simple;
	bh=1zmQ8zQMj4MGfJJo7YfPo05bQHIBl28jvNdCXvqs8x0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFkuAFGkMrc/lMQWahTYDdPy9zW8zC6ynKIAWhVYyXJJgvliQcZ5owYYOUuSt/xnHY8KM+VDP3eEINHuuHJTAbwXGOIXDA+CUqqFSQs+jlWuMcNCmxlQGxNHBwXLhXmZgQMuBMMikzcXRKFvdFSzlcxJ7kFBiBf5M8neKN2Nu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=G92QFbWG; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62E5ccfv1296094;
	Sat, 14 Mar 2026 08:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=DuoEQ2pV/7yVh3IEgtmtI4tqjtw5lKwCATX4jI1eMJk=; b=G92Q
	FbWGUyeaAtrlNys5MsNK9voTKi1fHW7iCyUNu4PkGWvFU0DolXTbQLHIf7SE1rZv
	QFBYUvvwRB4Ks71UkfutkEuT1UxZBLZwRQr/QeLU3y/VfGuMq9DjcCdSYZmRp0MK
	w8XW1RjfNUKiZnC7v5eZtbmTtRmN0093tEdV0matNoPRaB+tDNNIRZXNWjpAeeqx
	zhGODtYeG+c4qxoSCofsmuQ5OG2XanNinWUj9l9y37+p0nG48zIfP6if74zvzD/5
	ZG0G64rTq6rwK9lR9POj4jMQMB8NHFYh6Vlu11GEjFJ7U3oB+AGplnN3mKnf0v1/
	OhfSfjxHM4q+2PZyTA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cw02m8jbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Mar 2026 08:21:53 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 14 Mar 2026 08:21:47 +0000
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
Subject: [PATCH bpf-next v6 1/2] bpf: Support pointer param types via SCALAR_VALUE for trampolines
Date: Sat, 14 Mar 2026 19:21:26 +1100
Message-ID: <20260314082127.7939-2-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260314082127.7939-1-slava.imameev@crowdstrike.com>
References: <20260314082127.7939-1-slava.imameev@crowdstrike.com>
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
X-Proofpoint-GUID: aWKXgUJwixLwsF0nrwHW4v5Qds_iaiM5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDA2MyBTYWx0ZWRfX7kEmr5OH01+P
 pGy0SMMMdgtncOUV6NF5WgCX/w/tU5jCIQ1D5uc86xysD54kdgTl3AXOY3mRILMvTBCpvo+Wp6W
 EJJmzegq9JgPO0z3kguOFufNAORaDvvLHniLAwxNbI4ih0PM71xyouH50+dlzwt4ZrA00cf1gL6
 9J5CK0ewF8mWjRqi4yULxeYy0uawdy8iEeWZ0DcRMG/GK5wj8hTWW3FNXGWpdXhfdF6iAdJR8ay
 oyYtYmWw9tcCpJfv5qPfomqDaaQLLh93meHCLrrc1Pmyxs9GpycA+zB+BnsDSU7bJyJvyGFqJmK
 TF+IEqcpCUdEOX/babsr21U1T484GdP6CGnGIv27uny7vOxM0ilIBEs8/EDdvjO+0PFKRuQVLpQ
 TAgEswMH/DCi2h5DrhMCU5yw0NLxpCx9hWiBSTl5idX/ZRAhgnGPHqJre1oaA5z3K3i9dyT6u6T
 ou/d/WRCqW3t3/2sHUg==
X-Proofpoint-ORIG-GUID: aWKXgUJwixLwsF0nrwHW4v5Qds_iaiM5
X-Authority-Analysis: v=2.4 cv=cKPtc1eN c=1 sm=1 tr=0 ts=69b51aa1 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=QHqYeUcJvB07a7jHZo8A:9
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11728
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140063
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
	TAGGED_FROM(0.00)[bounces-267686-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crowdstrike.com:dkim,crowdstrike.com:email,crowdstrike.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49A0628C1C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add BPF verifier support for single- and multi-level pointer
parameters and return values in BPF trampolines by treating these
parameters as SCALAR_VALUE.

This extends the existing support for int and void pointers that are
already treated as SCALAR_VALUE.

This provides consistent logic for single and multi-level pointers:
if a type is treated as SCALAR for a single-level pointer, the same
applies to multi-level pointers. The exception is pointer-to-struct,
which is currently PTR_TO_BTF_ID for single-level but treated as
scalar for multi-level pointers since the verifier lacks context
to infer the size of target memory regions.

Safety is ensured by existing BTF verification, which rejects invalid
pointer types at the BTF verification stage.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
---
 kernel/bpf/btf.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 09fcbb125155..524bb2d6d964 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6508,13 +6508,6 @@ struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
 		return prog->aux->attach_btf;
 }
 
-static bool is_void_or_int_ptr(struct btf *btf, const struct btf_type *t)
-{
-	/* skip modifiers */
-	t = btf_type_skip_modifiers(btf, t->type, NULL);
-	return btf_type_is_void(t) || btf_type_is_int(t);
-}
-
 u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
 		    int off)
 {
@@ -6903,10 +6896,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	}
 
 	/*
-	 * If it's a pointer to void, it's the same as scalar from the verifier
-	 * safety POV. Either way, no futher pointer walking is allowed.
+	 * If it's a single or multilevel pointer, except a pointer
+	 * to a structure, it's the same as scalar from the verifier
+	 * safety POV. Multilevel pointers to structures are treated as
+	 * scalars. The verifier lacks the context to infer the size of
+	 * their target memory regions. Either way, no further pointer
+	 * walking is allowed.
 	 */
-	if (is_void_or_int_ptr(btf, t))
+	if (!btf_type_is_struct_ptr(btf, t))
 		return true;
 
 	/* this is a pointer to another type */
-- 
2.34.1


