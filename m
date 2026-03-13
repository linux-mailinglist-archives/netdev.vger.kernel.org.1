Return-Path: <netdev+bounces-267445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHb1Ai0LtGlvfwAAu9opvQ
	(envelope-from <netdev+bounces-267445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:03:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E86283629
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8775307A3CE
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F85238D27;
	Fri, 13 Mar 2026 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="KakmyC2t"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF3127456;
	Fri, 13 Mar 2026 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407001; cv=none; b=qJNDBrjd48ubhNZcq3K6cuzkv6aS0svplqcKdMxhRcRHemDEMt0FfWgBbWiV1vrjvbv/H0cs9NW0hko4etnQREUEeKs18kispXDEAogRIxWkQ/ekdqQYGXlZFqKVZmbHZCxJHiT0PAivP5TSvhd4Rs5zHWkGpiUhaCDM0S/dI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407001; c=relaxed/simple;
	bh=5mNoHIACtt9SZgMP0Y+R8drx7nGYHYBDolSvg789j/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I37GHqCGXjUz3/UuMyYEReVttcS+cmmx0SzpSbVasyswOWyBPLOylqBLNq+ECPaPn7ACd4JKPuzXU8kxsQ3KanE4JnMxlTp4THO3OG4jqnO6MiZ+2TQoJLDWfrSxP6lPYoPbb6+bYAxzD4JY4npslKq9P99TpWt7LOeluwWu1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=KakmyC2t; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D92K5O1066675;
	Fri, 13 Mar 2026 13:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=MR9Y7/vrxBVXCj8cRh5AdHsWfo3OwqgvnazIkEnjRPg=; b=Kakm
	yC2t2grpA9wMPTmgl8NL+Gn9DMYc4Fad54Gia79BXTwMybx9qnio5FuNjWP64M7v
	Qt6fB5yYAdxGOTgzA/h6FdUV0xSrXmPDxUQFJpC0G6+OBAwD+FtLsINZ1/torboy
	gcmtnCEZ1SAaBK/q0Z+cq7x3ax8iLP4Ab54Bww7MByCNogqjqd10Vwg2I6Lfp6TT
	Y2CGMuZ82TBr0n4km9Z7mLO+hmKJ+Kn5UIRPSD6Q0uKwiyiSnvECZNYuBc4Pv6Ot
	/LiRkQuDjmaQOHptI1VEbai17UtjRyho2X+IW14mLSgJy5s5ICnRrx2+e4/+CnxX
	85Hr6pKRtTvhNPFVJg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cuh5y7jdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 13:02:41 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Mar 2026 13:02:35 +0000
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
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add trampolines single and multi-level pointer params test coverage
Date: Sat, 14 Mar 2026 00:02:20 +1100
Message-ID: <20260313130220.18590-3-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260313130220.18590-1-slava.imameev@crowdstrike.com>
References: <20260313130220.18590-1-slava.imameev@crowdstrike.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwMyBTYWx0ZWRfX58nb4hHpLRYZ
 tP3s2Bl4m1zW0Ohbf6mNL4r+5np5oYt2/y6TIi1N09uE/BqTD1YOIV0LKLohOo6Utqvf8B4je61
 NwKXzeY3JLQOtoFci22QW4YJCfUiskx/J/GiEeuE/O2rDZlSUPyR6RpCAoJVRHxKw2u6G3ZIHaZ
 Sc70Z1PAfdfDV7xBA8MTF2CyIlVF5epDv7uZ1YlgcZ+rCZqfFXidok49UeMpsZLhxRn3h7/rCvg
 YjmZfjeE6rFW0NLneF/hFGd6zYKeGZSzENkEPYg5iXKAonn5LpFwWHtwHxOK+iDAB+6MYARFNga
 hZVeDiZBK9QxpP5GqrvXTlla6PSEEuKMUJVIYlKxbYZJa6QXFLwkGYiVKPqkFKjtqMvcX9KgoOx
 ohRik9pbD0jNP1ezEoRA/l0aLy2+g10Ie1flilV3Lu5tm1Dbx0VsFwOBww4i4N1QhI81/ZqZdB7
 ShLy9jtCuiQX8yLq4wQ==
X-Proofpoint-ORIG-GUID: bv9DVZeJD2XCzeXFu_iwq4DoWGE8bglk
X-Authority-Analysis: v=2.4 cv=Mt1fKmae c=1 sm=1 tr=0 ts=69b40af1 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=Vh-PTBDqdCVuQZtVsP0A:9
X-Proofpoint-GUID: bv9DVZeJD2XCzeXFu_iwq4DoWGE8bglk
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11728
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130103
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
	TAGGED_FROM(0.00)[bounces-267445-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A2E86283629
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add single and multi-level pointer parameters and return value test
coverage for BPF trampolines. Includes verifier tests for single and
multi-level pointers. The tests check verifier logs for pointers
inferred as scalar() type.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
---
 net/bpf/test_run.c                            | 17 +++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_ctx_ptr_param.c        | 68 +++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 56bc8dc1e281..14c4814a7dab 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -567,6 +567,23 @@ noinline void bpf_fentry_test_sinfo(struct skb_shared_info *sinfo)
 {
 }
 
+noinline void bpf_fentry_test_ppvoid(void **pp)
+{
+}
+
+noinline void bpf_fentry_test_pppvoid(void ***ppp)
+{
+}
+
+noinline void bpf_fentry_test_ppfile(struct file **ppf)
+{
+}
+
+noinline struct file **bpf_fexit_test_ret_ppfile(void)
+{
+	return (struct file **)NULL;
+}
+
 __bpf_kfunc int bpf_modify_return_test(int a, int *b)
 {
 	*b += 1;
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8cdfd74c95d7..bcf01cb4cfe4 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -115,6 +115,7 @@
 #include "verifier_lsm.skel.h"
 #include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
+#include "verifier_ctx_ptr_param.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -259,6 +260,7 @@ void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
 void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
+void test_verifier_ctx_ptr_param(void)       { RUN(verifier_ctx_ptr_param); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c b/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c
new file mode 100644
index 000000000000..b507dc850543
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verifier tests for single- and multi-level pointer parameter handling
+ * Copyright (c) 2026 CrowdStrike, Inc.
+ */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+SEC("fentry/bpf_fentry_test_ppvoid")
+__description("fentry/void**: void ** inferred as scalar")
+__success __retval(0)
+__log_level(2)
+__msg("R1=ctx() R2=scalar()")
+__naked void fentry_ppvoid_as_scalar(void)
+{
+    asm volatile ("					\
+	r2 = *(u64 *)(r1 + 0);	\
+	r0 = 0;	\
+	exit;	\
+	" ::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test_pppvoid")
+__description("fentry/void***: void *** inferred as scalar")
+__success __retval(0)
+__log_level(2)
+__msg("R1=ctx() R2=scalar()")
+__naked void fentry_pppvoid_as_scalar(void)
+{
+    asm volatile ("					\
+	r2 = *(u64 *)(r1 + 0);	\
+	r0 = 0;	\
+	exit;	\
+	" ::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test_ppfile")
+__description("fentry/struct file***: struct file *** inferred as scalar")
+__success __retval(0)
+__log_level(2)
+__msg("R1=ctx() R2=scalar()")
+__naked void fentry_ppfile_as_scalar(void)
+{
+    asm volatile ("					\
+	r2 = *(u64 *)(r1 + 0);	\
+	r0 = 0;	\
+	exit;	\
+	" ::: __clobber_all);
+}
+
+SEC("fexit/bpf_fexit_test_ret_ppfile")
+__description("fexit/return struct file**: returned struct file ** inferred as scalar")
+__success __retval(0)
+__log_level(2)
+__msg("R1=ctx() R2=scalar()")
+__naked void fexit_ppfile_as_scalar(void)
+{
+    asm volatile ("					\
+	r2 = *(u64 *)(r1 + 0);	\
+	r0 = 0;	\
+	exit;	\
+	" ::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


