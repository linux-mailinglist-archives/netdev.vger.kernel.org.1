Return-Path: <netdev+bounces-259164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO1xIz/qlGm7IwIAu9opvQ
	(envelope-from <netdev+bounces-259164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:22:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC74E1516BD
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99104304C138
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14987308F2E;
	Tue, 17 Feb 2026 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="sX4Pawn0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E44E3148C1;
	Tue, 17 Feb 2026 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366938; cv=none; b=t7YHPQW3SB3zOmiNT2mYwC7mIOHORVoeVRd6H/oswC4olh/gS3FOF3h2Q+7WviQW3fhPHhRZCXuMZVrZ3LWIG3o8RJgJrUeAa/M3IeAzASh4sins10NZ+K6OokHkYELyCRaSC94XC7OdLXW9z3OM+bz6zmeWs1fMguB0FD34prI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366938; c=relaxed/simple;
	bh=+f6vWP5n2iuxcVn5Eb+A0Ae7lVjiuQzxuG5d1Mepuo4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cRTThXpCXpjc0iIJuTh/3T66wHFo6KIeIVwz0biinN5GQGMydvU8vgfN93DY6bReellChTA13Efv3MnjfYddRWCFj/7dbdCxEPfHvkdJEmuTKX6FfBuKMZ+AtM1BXLD3qNbq5CY+zvd08NcEuXFeTjDBFySFn9zfwZg57D/I8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=sX4Pawn0; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HLM4vQ2984819;
	Tue, 17 Feb 2026 22:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=lsPWRwvi1Apst
	YXAnabIsBrC5j/PcBe1u4Orn/wFF6Q=; b=sX4Pawn0kMR1OqkajuDkDUj0trYLu
	gGeWdTV7ql88Tv2rNORLt6t9PfdQEowJToNDyS6TnBKuOZQYGru1x7Ntms28X5TL
	6y09pAlMes5pEO3VAsuSYZ+6BZG8YW3ukja6nNfNIelyX3OtwL3Vgw92XyGEd4p1
	fFvLrIGM04fX2hEQqjui/IuhXtRpm0EBX83pQ8vdwwwWTBCAqzZymNRy2Dxqqamu
	KT+uyqDXNxogTn2XXIvPcNKUW9pfwdMrEV2hVzGdhM5AlX3hD6NjRMdl1VteV9W1
	MUiqSHr/hgknYf/4VLGIioahEZWTCF52PAnPwsnbLXEstRIoHG8GbHbzA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cd06c85dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 22:14:39 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 22:14:33 +0000
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
Subject: [PATCH bpf-next v2 0/2] bpf: Add multi-level pointer parameter support for trampolines
Date: Wed, 18 Feb 2026 09:13:55 +1100
Message-ID: <20260217221357.18215-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
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
X-Authority-Analysis: v=2.4 cv=UfxciaSN c=1 sm=1 tr=0 ts=6994e84f cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Vjdy_2d24l28D3FOwqMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE4MyBTYWx0ZWRfXz9H+wj+U8lhW
 wCVAE7kqOmZZ9eMLjmZsbVgRQJEjbwWZGKiQp7jopI1qARLY8P45CnS4xuf8UPvDNN93ZiA/c/j
 48d+U5D0sNpXjT+Hi+8ESYoWzGteI+XWOAIkc4oBmywQ97zUR4H5mcr+Zmhnh4Ru03A8dQwusfA
 dM6/mrlu5YXbNHTU6t7lGXapBxO58bSecjTpr/ohE4ZfROPwAqmVppIZijTjG4VJvbvKvNtgawu
 GZJD/guwi/rvUsQxejgGM19CXirIrIneIVz4GwCvVcWXioemYB7zALIHqzaabfuqYNuzC+xfSP7
 cAFe++6xFGsVorDf80sxBSmeGcbfAb2u8XVMPCvPJvVONHMduLAC9lJ8wZfz5gZ1OXVH891psgq
 E3wsScGEILORbrNO/vMD0tTIV5JYmHJSEC4J47jqtAKLWOWlq10A2a24ZD5obu9f4oS1rWiTQTc
 yEg/4ZFQVD4e/rtwlUg==
X-Proofpoint-GUID: d7PcW570uhuaLRhdCZMMygrt5v40S1Jh
X-Proofpoint-ORIG-GUID: d7PcW570uhuaLRhdCZMMygrt5v40S1Jh
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11704
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170183
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-259164-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,crowdstrike.com:mid,crowdstrike.com:dkim]
X-Rspamd-Queue-Id: EC74E1516BD
X-Rspamd-Action: no action

This patch adds BPF verifier support for multi-level pointer parameters
and return values in BPF trampolines. The implementation treats these
parameters as PTR_TO_MEM with read-only semantics, applying either
untrusted or trusted access patterns while honoring __nullable
annotations. Runtime safety is ensured through existing exception
handling mechanisms for untrusted memory reads, with the verifier
enforcing bounds checking and null validation. The series includes
selftests covering double and triple pointer arguments across
fentry/fexit/lsm programs and verifier context validation.

Background:

Prior to these changes, accessing multi-level pointer parameters or
return values through BPF trampoline context arrays resulted in
verification failures in btf_ctx_access, producing errors such as:

func '%s' arg%d type %s is not a struct

For example, consider a BPF program that logs an input parameter of type
struct posix_acl **:

SEC("fentry/__posix_acl_chmod")
int BPF_PROG(trace_posix_acl_chmod, struct posix_acl **ppacl, gfp_t gfp,
             umode_t mode)
{
    bpf_printk("__posix_acl_chmod ppacl = %px\n", ppacl);
    return 0;
}

This program failed BPF verification with the following error:

libbpf: prog 'trace_posix_acl_chmod': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; int BPF_PROG(trace_posix_acl_chmod, struct posix_acl **ppacl,
gfp_t gfp, umode_t mode) @ posix_acl_monitor.bpf.c:23
0: (79) r6 = *(u64 *)(r1 +16)         ; R1=ctx() R6_w=scalar()
1: (79) r1 = *(u64 *)(r1 +0)
func '__posix_acl_chmod' arg0 type PTR is not a struct
invalid bpf_context access off=0 size=8
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
-- END PROG LOAD LOG --

The common workaround involved using helper functions to fetch parameter
values by passing the address of the context array entry:

SEC("fentry/__posix_acl_chmod")
int BPF_PROG(trace_posix_acl_chmod, struct posix_acl **ppacl, gfp_t gfp,
             umode_t mode)
{
    struct posix_acl **p;
    bpf_probe_read_kernel(&p, sizeof(ppacl), &ctx[0]);
    bpf_printk("__posix_acl_chmod before %px\n", p);
    return 0;
}

This approach introduced helper call overhead and created inconsistency
with parameter access patterns.

Improvements:

With this patch, trampoline programs can directly read parameters and
dereference memory using load instructions, eliminating helper call
overhead and ensuring consistent parameter handling. For example, the
following helper call sequence:

{
    struct posix_acl **pp;
    struct posix_acl *p;
    bpf_probe_read_kernel(&pp, sizeof(pp), &ctx[0]);
    bpf_probe_read_kernel(&p, sizeof(p), pp);
    ...
}

can be replaced by two load instructions implementing a single C
statement:

{
    struct posix_acl *p = *ppacl;
    ...
}

Design Rationale: PTR_TO_MEM vs SCALAR

The verifier assigns SCALAR type to single-level pointers (void*, int*).
For multi-level pointers, I selected PTR_TO_MEM to enable memory access
through a single load instruction for the first level of dereference,
with subsequent dereferences becoming SCALAR. This design eliminates
helper call for parameter dereference, replacing it with a load
instruction (e.g., void* ptr = *pptr).

Access safety is maintained through existing verify-time checks,
exception handling, and kernel virtual address range boundary checks:
- User-mode memory address access is prevented by runtime virtual
  address range checks for untrusted PTR_TO_MEM
- Invalid kernel address space accesses are intercepted by the
  exception handler for untrusted PTR_TO_MEM
- Trusted PTR_TO_MEM access safety is maintained at verify time

v1 -> v2: corrected maintainer's email

Slava Imameev (2):
  bpf: Support multi-level pointer params via PTR_TO_MEM for trampolines
  selftests/bpf: Add trampolines multi-level pointer params test
    coverage

 include/linux/bpf.h                           |   3 +-
 kernel/bpf/btf.c                              |  54 ++-
 kernel/bpf/verifier.c                         |   4 +-
 net/bpf/test_run.c                            | 128 ++++++
 .../prog_tests/fentry_fexit_multi_level_ptr.c | 204 +++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../progs/fentry_fexit_pptr_nullable_test.c   |  52 +++
 .../bpf/progs/fentry_fexit_pptr_test.c        |  60 +++
 .../bpf/progs/fentry_fexit_void_ppptr_test.c  |  31 ++
 .../bpf/progs/fentry_fexit_void_pptr_test.c   |  64 +++
 .../bpf/progs/verifier_ctx_multilevel_ptr.c   | 429 ++++++++++++++++++
 11 files changed, 1021 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_fexit_multi_level_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_nullable_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_ppptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_pptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_multilevel_ptr.c

-- 
2.50.1 (Apple Git-155)


