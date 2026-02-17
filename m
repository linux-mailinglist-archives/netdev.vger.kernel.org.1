Return-Path: <netdev+bounces-259156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMU4MMbklGmjIgIAu9opvQ
	(envelope-from <netdev+bounces-259156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:59:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6189F1513C1
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A12BE30071FB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF86E307492;
	Tue, 17 Feb 2026 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="SjNchY2C"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127528DF2D;
	Tue, 17 Feb 2026 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365568; cv=none; b=uVHDIG1NVAGh9YVNnyzgOzucPcv2Lc24ZpxyUgR3OQ01WaJR0KEeZACN5P4GdjIxw6G80VaqwWKG01IJwy+uOwNrU/iW/0q7xa1CDQLxqb7AW6jM/wuBVSuDjfGBFDyiI28cTSeElJlWDjRAsImrRNsJth0GkfGtnk7q3HhOm00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365568; c=relaxed/simple;
	bh=oHQfNcmSigVL9TWDHkhIvPAWNge36mHKajCj47NCyOw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rOl/S/Dv9fk7tUYfVfZ1kfOUZi+Q9WwM2WgFQS04Mx43JpoCVbKNm6KnOExXfaIyFrtp4yXU/KVNzW5qMQj6lC/MK7IarJffjaQwcO9TKNmTfHSJwFg/GnyG8pXzrhFoLslUixtMVGjcL7JsWvHTqMhNtEru87vxdr4kGB8CWOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=SjNchY2C; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HKj3KU1425520;
	Tue, 17 Feb 2026 21:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=KfwHpjImdoj0z
	fEWGV80PU5OuIazRwyLrYpTlBXks+c=; b=SjNchY2CYOKMLgzMd2xVhP33JBjjg
	TUWNfA9M9crkB74UT1BjMoDRR+RLcFNIg+inCJKLDYG2CkH6NdNVb2ImTVYI8yqk
	e/ln2R//CNAUey84y5AZG0ae1guErYKn6bImMg+2+e8fjc/yWd68jjRJIy3wTQTU
	lpC3UNOSt2v3JW9+8jnlUF1QuAKbmercMUO8lejAM/BIjLx1ZeY4JLa+NrxY3joi
	nPUJJrotu+74TIBeNZtL5g8/oNHNsw4kl9QYC7pi/wBRrXezzigKUtCKmpbVcqnx
	Ks1fJfQrxkcTpZ/c7ViZslszMh8dU4wDm+755pUcFm19+xWhM6DiNVpGw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ccyn38657-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 21:45:48 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 21:45:42 +0000
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
Subject: [PATCH bpf-next 0/2] bpf: Add multi-level pointer parameter support for trampolines
Date: Wed, 18 Feb 2026 08:45:31 +1100
Message-ID: <20260217214533.17776-1-slava.imameev@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: k3eqfDwWqaL0Vl_VLkwlriYtsRUYyLAH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE3OSBTYWx0ZWRfX6kzIylWzRPZf
 xbRDzycFl7hXyrEKODwAgZ3aQN0ZY5oMlc30RBgxhIcKioJza1CnVdPYK3/axtEoUE/aRyl6rVk
 EFLhFeyyYEebyiPBSTmrLXvhm4eYP9HYUXy2akEWTEIdS8nyQso7frygJJejBkt24T7s22Na8r9
 JhrfS+DDWyuEk75I4kR2TaEquTQxXtXIGQ+5Dy2/B5zmo5E+SpxJnAscoL8UVtePTMkiU7naBEX
 ps5hWwx7tgpYAHaBqUFZOkEuLQ69twks4/pzmzR24NuXOSsKGtG9gMN1ryPC5x3a3zw2IqpjemI
 V8zdlQGKZGRHKzVDYEcFISHomUZY35abfxgp05/lSug6h6CKx86IbNobUGuQZRjlCd/jJlVjEJr
 bvlHebjlTq3RCMwBt5NOd+cWYls4arQmZjUgAfBEj1B7H/oTlbU1/r8Uz1WG9jRMxPfnQzQuWQC
 ooGS0dZ79a8RBrRk4YQ==
X-Authority-Analysis: v=2.4 cv=bOMb4f+Z c=1 sm=1 tr=0 ts=6994e18c cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Vjdy_2d24l28D3FOwqMA:9
X-Proofpoint-GUID: k3eqfDwWqaL0Vl_VLkwlriYtsRUYyLAH
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11704
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1011 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170179
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-259156-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crowdstrike.com:mid,crowdstrike.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6189F1513C1
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


