Return-Path: <netdev+bounces-267685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBcCJccatWlZwgAAu9opvQ
	(envelope-from <netdev+bounces-267685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:22:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC8E28C19B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACD5E3031AFE
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 08:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78192F6192;
	Sat, 14 Mar 2026 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="UgcW2mB2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701262D0C84;
	Sat, 14 Mar 2026 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773476547; cv=none; b=J8R0wnS/CfdR00Gs/DRuigqZqpHETtMWypasp3ZTB32NK7emO/MRAV1n5Jal4pzJNIM6NhvKmnLqQkqHttkD3uXktEJDHj4OY33cgZ+EgntM4+BNXzpKA67hxleVBwtEgaXo6qVmfD+OzCeGMRK90UpAvP28hdXCcBglqbHCu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773476547; c=relaxed/simple;
	bh=P3ABxIPOf8zEAcTu57EZzEy3wSIYoWqvCkG1xqKEDBs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ibhWfHdjQthprIoR5lTMzwWdWaF1K7G5bQWXZk61yQJClTmn85PYeCHw4J1Ropj/SgWqd6c3WoZpDgasUHJhnbX3gEkp505yLBxGgcBoDTcWZkSbrizLCn52QkKndYvwV97BNwFL3GIBxPKaWx/nHeI4qNnZaDpuvqCV/0BXKdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=UgcW2mB2; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62E5U9VR3221722;
	Sat, 14 Mar 2026 08:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=1WM0f1XuPWzaX
	N1uWAgzme+jqDwi39J4zu7whwSSBk0=; b=UgcW2mB2EGuF93T+CgkfGfh7siBjQ
	VeF0x3UTO7jRc+wc2zUPOz0949d/L7PF4n4M/Y6JBF49G7gYnJQ++56tg6hjkT4N
	EgvZUfjQYvVWA3YlHhE+ZdoPAv2coqVcFAtGvwA4Rj3FPySTclSKvpNzjtffEeP1
	ArM88Vo+3M0dUOWd7vdEl9CVeUHfZDr0JQB/FlSlXpT2uophp/cS5KoJInaEfztM
	TqsTH5fN55UnfTXTvCXWyq+ib8VZyAoCy0dqwGrK3paq4LDlMRyQCOSxtMiKKFNV
	qpX65E2d+dKgryHLp70y6qxHDiu/G3aifQzk9aeQe873PEgn5G+iym51w==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cw08eghfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Mar 2026 08:21:47 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 14 Mar 2026 08:21:41 +0000
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
Subject: [PATCH bpf-next v6 0/2] bpf: Add multi-level pointer parameter support for trampolines
Date: Sat, 14 Mar 2026 19:21:25 +1100
Message-ID: <20260314082127.7939-1-slava.imameev@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: H_scvHAuH3d5ptBRvBYBdodjvZsBY8RV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDA2MyBTYWx0ZWRfX2fH0IAyNojsJ
 qCc+hTsFLfbL4SY6AQBb05ArwA0rCP5PB0InmurjgyfEogHgvhNTwsfo20FPryMbKpoXvhn7FRo
 Ieei8lIuNNlDSVcTGJe1i4uCvAxqgvEZiffKShEnIMg3mmwx+Nunn774BCfXqYfY6OFUvk6LDUa
 BQe/j3jfIMBZmLQjkn8lEuS48j8n28083NGS07NvvbJgwFj++WJA+zsxBe3IXst5wDKuf5kRLXH
 I4m7B22ETSXCHJUI234KvGF9xb/6HxBifgfLqBFICLjJgt/4gYhyI6ueqy+IiqvN25KV/sl4UOW
 a0O3Lgi2dNnX1foPa5HCFkxLameseeW5Kz90027/chjM9CL2ovFPPzVcANLGS8iOWx1z4mm5g9A
 fkwQyzO5+uQUtWjOxX3/HphwfBRPLLi0A2mCSMxza9fVB3CnrR5UiRhD6YIbuMMNd8bRKzgZAvB
 SnCrJ1PfXSbOFjyvjmw==
X-Authority-Analysis: v=2.4 cv=fsfRpV4f c=1 sm=1 tr=0 ts=69b51a9b cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=g1g6oSFQjXiNt9peMvgA:9
X-Proofpoint-GUID: H_scvHAuH3d5ptBRvBYBdodjvZsBY8RV
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11728
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
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
	TAGGED_FROM(0.00)[bounces-267685-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,crowdstrike.com:dkim,crowdstrike.com:mid]
X-Rspamd-Queue-Id: 3FC8E28C19B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is v6 of a series adding support for new pointer types for
trampoline parameters.

Originally, only support for multi-level pointers was proposed.
As suggested during review, it was extended to single-level pointers.
During discussion, it was proposed to add support for any single or
multi-level pointer type that is not a single-level pointer to a
structure, with the condition if (!btf_type_is_struct(t)). The safety
of this condition is based on BTF data verification performed for
modules and programs, and vmlinux BTF being trusted to not contain
invalid types, so it is not possible for invalid types, like
PTR->DATASEC, PTR->FUNC, PTR->VAR and corresponding multi-level
pointers, to reach btf_ctx_access.

These changes appear to be a safe extension since any future support
for arrays and output values would require annotation (similar to
Microsoft SAL), which differentiates between current unannotated
scalar cases and new annotated cases.

This series adds BPF verifier support for single- and multi-level
pointer parameters and return values in BPF trampolines. The
implementation treats these parameters as SCALAR_VALUE.

This is consistent with existing pointers to int and void that are
already treated as SCALAR.

This provides consistent logic for single- and multi-level pointers:
if the type is treated as SCALAR for a single-level pointer, the
same applies to multi-level pointers, except for pointers to structs
which are currently PTR_TO_BTF_ID. However, in the case of
multi-level pointers, they are treated as scalar since the verifier
lacks the context to infer the size of their target memory regions.

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

The bpf_core_cast macro can be used for deeper level dereferences.

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
v4 -> v5:
* As suggested, extended support to single-level pointers and
covered all supported valid pointer (single- and multi-level) types
with a wider condition if (!btf_type_is_struct(t)).
* As requested, simplified tests by keeping only tests that check
the verifier log for scalar().
v5 -> v6:
* Fixed the test message based on the bot's feedback.

Slava Imameev (2):
  bpf: Support pointer param types via SCALAR_VALUE for trampolines
  selftests/bpf: Add trampolines single and multi-level pointer params
    test coverage

 kernel/bpf/btf.c                              | 17 ++---
 net/bpf/test_run.c                            | 17 +++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_ctx_ptr_param.c        | 68 +++++++++++++++++++
 4 files changed, 94 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c

-- 
2.34.1


