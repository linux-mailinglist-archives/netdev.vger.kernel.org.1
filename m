Return-Path: <netdev+bounces-263104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLsiKeewpmn9SgAAu9opvQ
	(envelope-from <netdev+bounces-263104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:59:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E351EC305
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33CCA30DE19C
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982F38F646;
	Tue,  3 Mar 2026 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ACqEVtHd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF738C42E;
	Tue,  3 Mar 2026 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772531727; cv=none; b=qQgg/cWCFzGjNuCeBCwuySFgg1+KW7FZB065AQqh7MmbKZ3Q3zTWsdClnFx/oMW19zneDTEeQraCtrDFxp44i9+Mk9wF6KDaNRXUlPXbk5IZnwyCS4rL+MWWp9jKreap/fiE8AMVMG3efFiFWUWNMAM4s6haLh1JVCF2YONjoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772531727; c=relaxed/simple;
	bh=S9/Qs/sGuV7SVQT+vu0p0WWQgUDurNzDlIBBmNi9YxE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uczdBW/AYHZB/NDhhoaIVgEMtkhiqtRDRClQKxafGPf83PwfxorPZxGxLGZn27m7HulUQm/qNmYMSDDqFSbrCDsO7qESfOUAyKI2J+tcda0hVC7jgV8C4CU9ZME1zveFzBSlwq4ibnEuSBcIXx/UPa/Ka61uaZFqqx+vDuca6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ACqEVtHd; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6236Fln6763086;
	Tue, 3 Mar 2026 09:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=pEQplKdtBIj4L
	2qCzOsTZaemiKLyoExlh7izHFHAaPA=; b=ACqEVtHdoD5lOcBFDY1Jof73RQBi3
	lAEmOvP+pcr/09Vo65qxrfzdDtrA+kjeOL1cuz4JjAzU+CqdnIJFVnVUKINmUTFO
	KAlqD/ODuCCkyMfxN7SEMwf9noeLH+YSraZ2S8QRwJAq2ieSK+OnMcWFOBn9V0GU
	RlhPpkp20oN7ml35az2i6xPVqnLPWn+VNxpbEXg+brcnMt1BZH7dR8GImRRvXinX
	ILBKBIiGXm3CTNNwy/DuqqD2/CjZ/fJef+k+DY2fZTPMishqtGl8S8Lo1Drs+Tag
	9gFoptef8m91XaqBl+HoPSfZ5huBueXMRGh+Mq+DYIM9nJFvZvf2Ed10w==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cmbkwghre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 09:54:52 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Mar 2026 09:54:46 +0000
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
Subject: [PATCH bpf-next v4 0/2] bpf: Add multi-level pointer parameter support for trampolines
Date: Tue, 3 Mar 2026 20:54:24 +1100
Message-ID: <20260303095427.38981-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NCBTYWx0ZWRfXxY268R9C+SJq
 1OAXTXlvoAuXVTOFTi8wItSUQ4ZOwpRuiR93ziYyX7csprx3/RgJlB9GGPZl7ZZEIKrmpVYfV9l
 u31Toksi2hsOuSku1i+3Kfbs7QCfLds2p/cGCcmq9wwUqArzKHHl99IOQ04DVnw6pf7a4q7GaQG
 mwPH/wQlBJpJ6HpnHiu2NL55x976ojpx3oe11qGbFT5Yj0PWEroXtKhPYcX7wZuuHOOu2jgTGUv
 YETstq3pWzEVbPdOFojEXvOtpRRV/2YWdrzR0Tb2Q7F/0sq6SAlJF6b2quPOHQkGQ7hMxSk7ukU
 3rrw9ITRQVnCwcGEaO4XZ8672wKpBbS+kOOH6gjjQvtDX/mcq3szSWQcE+BoMpr3A+kcvSor0L8
 ZIQA6Q60hp6X6yDi1A+fnFF8sek3nDJSCJR83KTQhvgkF5B+t68fQP90SsIwUe2gFUwSavjky7Y
 QBYgWlGiMnkP2yhp1zg==
X-Authority-Analysis: v=2.4 cv=M4RA6iws c=1 sm=1 tr=0 ts=69a6afec cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=WyMQw0lqGAoaf0B3nNEA:9
X-Proofpoint-GUID: kpgBTCyi04zBQ_oWrgCk_pfDUy0shKcz
X-Proofpoint-ORIG-GUID: kpgBTCyi04zBQ_oWrgCk_pfDUy0shKcz
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030074
X-Rspamd-Queue-Id: 09E351EC305
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
	TAGGED_FROM(0.00)[bounces-263104-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,crowdstrike.com:dkim,crowdstrike.com:mid]
X-Rspamd-Action: no action

This is v4 of a series adding support for new pointer types for
trampoline parameters.

Originally, only support for multi-level pointers was proposed.
As suggested during review, it was extended to some single level
pointers. During discussion, it was proposed to add support for any
pointer type that is not a pointer to structure, with a condition
like if (!btf_type_is_struct(t)), but I found this might not be
compatible with some cases, e.g., some tests failed. Though this
depended on the exact place the check is done - if the check is
moved before the exit from btf_ctx_access, tests are passed. Anyway,
this looked like an extension which might conflict with future
changes for some types falling in the !btf_type_is_struct(t) case.
Instead, I used explicit type checks to add support only for single
and multi-level pointer types that are not supported but can be
supported with scalar. This is a cautious approach which can be
verified with explicit tests for each type.

These changes appear to be a safe extension since any future support
for arrays and output values would require annotation (similar to
Microsoft SAL), which differentiates between current unannotated
scalar cases and new annotated cases.

This series adds BPF verifier support for single- and multi-level
pointer parameters and return values in BPF trampolines. The
implementation treats these parameters as SCALAR_VALUE.

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

Background:

Prior to these changes, accessing multi-level pointer parameters or
return values through BPF trampoline context arrays resulted in
verification failures in btf_ctx_access, producing errors such as:

func '%s' arg%d type %s is not a struct

For example, consider a BPF program that logs an input parameter of
type struct posix_acl **:

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

The common workaround involved using helper functions to fetch
parameter values by passing the address of the context array entry:

SEC("fentry/__posix_acl_chmod")
int BPF_PROG(trace_posix_acl_chmod, struct posix_acl **ppacl, gfp_t gfp,
             umode_t mode)
{
    struct posix_acl **pp;
    bpf_probe_read_kernel(&pp, sizeof(ppacl), &ctx[0]);
    bpf_printk("__posix_acl_chmod %px\n", pp);
    return 0;
}

This approach introduced helper call overhead and created
inconsistency with parameter access patterns.

Improvements:

With this patch, trampoline programs can directly access multi-level
pointer parameters, eliminating helper call overhead and explicit ctx
access while ensuring consistent parameter handling. For example, the
following ctx access with a helper call:

SEC("fentry/__posix_acl_chmod")
int BPF_PROG(trace_posix_acl_chmod, struct posix_acl **ppacl, gfp_t gfp,
             umode_t mode)
{
    struct posix_acl **pp;
    bpf_probe_read_kernel(&pp, sizeof(pp), &ctx[0]);
    bpf_printk("__posix_acl_chmod %px\n", pp);
    ...
}

is replaced by a load instruction:

SEC("fentry/__posix_acl_chmod")
int BPF_PROG(trace_posix_acl_chmod, struct posix_acl **ppacl, gfp_t gfp,
             umode_t mode)
{
    bpf_printk("__posix_acl_chmod %px\n", ppacl);
    ...
}

The bpf_core_cast macro can be used for deeper level dereferences,
as illustrated in the tests added by this patch.

v1 -> v2:
* corrected maintainer's email
v2 -> v3:
* Addressed reviewers' feedback:
	* Changed the register type from PTR_TO_MEM to SCALAR_VALUE.
	* Modified tests to accommodate SCALAR_VALUE handling.
* Fixed a compilation error for loongarch
	* https://lore.kernel.org/oe-kbuild-all/202602181710.tEK6nOl6-lkp@intel.com/
* Addressed AI bot review
	* Added a commentary to address a NULL pointer case
	* Removed WARN_ON
	* Fixed a commentary
v3 -> v4:
* Added more consistent support for single and multi-level pointers
as suggested by reviewers.
	* added single level pointers to enum 32 and 64
	* added single level pointers to functions
	* harmonized support for single and multi-level pointer types
	* added new tests to support the above changes
* Removed create_bad_kaddr that allocated and invalidated kernel VA
for tests, and replaced it with hardcoded values similar to
bpf_testmod_return_ptr as suggested by reviewers.

Slava Imameev (2):
  bpf: Support new pointer param types via SCALAR_VALUE for trampolines
  selftests/bpf: Add trampolines single and multi-level pointer params
    test coverage

 kernel/bpf/btf.c                              |  31 +-
 net/bpf/test_run.c                            | 130 +++++
 .../prog_tests/fentry_fexit_multi_level_ptr.c | 206 +++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../progs/fentry_fexit_pptr_nullable_test.c   |  60 ++
 .../bpf/progs/fentry_fexit_pptr_test.c        |  67 +++
 .../bpf/progs/fentry_fexit_void_ppptr_test.c  |  38 ++
 .../bpf/progs/fentry_fexit_void_pptr_test.c   |  71 +++
 .../bpf/progs/verifier_ctx_ptr_param.c        | 523 ++++++++++++++++++
 9 files changed, 1120 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_fexit_multi_level_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_nullable_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_ppptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_pptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c

-- 
2.34.1


