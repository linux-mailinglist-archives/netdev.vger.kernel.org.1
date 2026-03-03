Return-Path: <netdev+bounces-263106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGG2DCawpmn9SgAAu9opvQ
	(envelope-from <netdev+bounces-263106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:55:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C00A21EC28D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C220B302D196
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D842338F64E;
	Tue,  3 Mar 2026 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ugVewTI/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FD326C38C;
	Tue,  3 Mar 2026 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772531747; cv=none; b=Iv7kvS528Y5pV5MHSUXCxloh9X2/LT4iN6wNaal4Pq8g/kM8jBqYtNh1s01kev1kGLQ0Sfej8WPumgwG2Arze6L2QLkJ4Tvu4PEN0z2Y6xdwSW1DZwyT5/mrO6xhH77ZzErrEDKjM6DtSIPcIuXC96N5SevY4gmlaPWZjREywjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772531747; c=relaxed/simple;
	bh=5mYgP7MCq3t7GFEy2zH6JXLXPeR993gJb7JLpeeamKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCbHpZGSRl7gp5cETkTFjbwe5Qd+WakIwk8sRP8KhHVTTppD9ohsEKwRMI9IxTULBS6m/MAVkz/yGNihJW+6rjKUHPoKaduN0Mip7CGYvSmTJC4d9AIireWxzQnU6Q9Fz7GusUo29uPVzVa+jyhNiVJu4RUejhZ23hpwLFvu2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ugVewTI/; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6235Oluc2293598;
	Tue, 3 Mar 2026 09:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=DqOO2wGFt2RybFRGv/jENUcONOXDPqu42Os+sn5ykQ8=; b=ugVe
	wTI/EtgE7BTjTWse2QmGTptVvKiT4/XCkEqAfZySxaQXbcBkwrMX3IR5k5EzGnbc
	CWZMDq0LEkfGKUkPDAU4q6x+jHew5os/Qq77KviEKjbpvjgp7WWyHtxoD/awrXyW
	IjshrkkSgWbDxasIR8oEwIw3AyUr4xSv14NJ+Q2hcsROI1bRJGl/qctIFILyDFtB
	0ZOYcXVsGk2coHZIwIfbGxa7uHEXQQwvruHt50JSKBnxZJdczUecwJxlrvhfwBZy
	8SKBKKOqdc1y5SUzMVje4HrmS11LQTBz2846lAp10fM5iEnicGasci1U6g6c7J0T
	sAlZzv5YFByYEZpYMA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cmbahrfr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 09:55:10 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Mar 2026 09:55:03 +0000
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add trampolines single and multi-level pointer params test coverage
Date: Tue, 3 Mar 2026 20:54:26 +1100
Message-ID: <20260303095427.38981-3-slava.imameev@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NCBTYWx0ZWRfX3U+fzu7rgFJX
 eGKUmZnNpREo/f9ioihLC5Ix1RicZnep1aYaMKtqvgqDy4MWGWET1nbYjAuAt25NpTUTg5hBv3p
 JX9uYvmhcKWG/3oVHMfhmdRCbEWh3LhdEuY7MDmVpDBP6oJvhH9HuaVafDbcitb4BgWYBOsS9ve
 wN5bFiAKk3ZAhP/FlsZcAo9B3u83IS/Z60HnwR8KIOKtCu6ma//rYbkHXpr9Ni0iP9xEWvtjDnX
 l8Fk96vflENyrbWJcD/7DRDB/8u+CUwKEaqcAxE3LD9aBg7k8jj3EGwgti+29z6erZPJi3PUJM/
 Sk8RoZtIvz3etLq7gh9XTw0SOEmhl2mINjiFK7nhwDLYC85icJBmXeV+vgx6osNAyeLiBzSGbDE
 lxPEGeudN4YZ+WjLinR9nPeF6I8qFnoikXAN17thDyUTK3JAUA57JjazsuwnAZLhc5d4aDHB+Sy
 uoHJQathEPMP3SLgWog==
X-Authority-Analysis: v=2.4 cv=UNbQ3Sfy c=1 sm=1 tr=0 ts=69a6affe cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=cP_1t_rwnGdk4pelfpcA:9
X-Proofpoint-GUID: E_1UoiyIPSoTocGCUr39LIzvAx5Lf01q
X-Proofpoint-ORIG-GUID: E_1UoiyIPSoTocGCUr39LIzvAx5Lf01q
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030074
X-Rspamd-Queue-Id: C00A21EC28D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263106-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,crowdstrike.com:dkim,crowdstrike.com:email,crowdstrike.com:mid]
X-Rspamd-Action: no action

Single and multi-level pointer params and return value test coverage
for BPF trampolines:
- fentry/fexit programs covering struct and void double/triple
  pointer parameters and return values
- verifier context tests covering pointers as parameters, these
  tests cover single and double pointers to int, enum 32 and 64,
  void, function, and double pointers to struct, triple pointers
  for void
- verifier context tests covering single and double pointers to
  float, to check proper error is returned as pointers to float
  are not supported
- verifier context tests covering pointers as return values
- verifier context tests for lsm to check trusted parameters
  handling
- verifier context tests covering out-of-bound access after cast
- verifier BPF helper tests to validate no change in verifier
  behavior

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
---
 net/bpf/test_run.c                            | 130 +++++
 .../prog_tests/fentry_fexit_multi_level_ptr.c | 206 +++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../progs/fentry_fexit_pptr_nullable_test.c   |  60 ++
 .../bpf/progs/fentry_fexit_pptr_test.c        |  67 +++
 .../bpf/progs/fentry_fexit_void_ppptr_test.c  |  38 ++
 .../bpf/progs/fentry_fexit_void_pptr_test.c   |  71 +++
 .../bpf/progs/verifier_ctx_ptr_param.c        | 523 ++++++++++++++++++
 8 files changed, 1097 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_fexit_multi_level_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_nullable_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_ppptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_pptr_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..73191c4a586e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -24,6 +24,8 @@
 #include <net/netdev_rx_queue.h>
 #include <net/xdp.h>
 #include <net/netfilter/nf_bpf_link.h>
+#include <linux/set_memory.h>
+#include <linux/string.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/bpf_test_run.h>
@@ -563,6 +565,96 @@ noinline int bpf_fentry_test10(const void *a)
 	return (long)a;
 }
 
+struct bpf_fentry_test_pptr_t {
+	u32 value1;
+	u32 value2;
+};
+
+noinline int bpf_fentry_test11_pptr_nullable(struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	if (!pptr__nullable)
+		return -1;
+
+	return (*pptr__nullable)->value1;
+}
+
+noinline u32 **bpf_fentry_test12_pptr(u32 id, u32 **pptr)
+{
+	barrier_data(&id);
+	barrier_data(&pptr);
+	return pptr;
+}
+
+noinline u8 bpf_fentry_test13_pptr(void **pptr)
+{
+	void *ptr;
+
+	return copy_from_kernel_nofault(&ptr, pptr, sizeof(pptr)) == 0;
+}
+
+/* Test the verifier can handle multi-level pointer types with qualifiers. */
+noinline void ***bpf_fentry_test14_ppptr(void **volatile *const ppptr)
+{
+	barrier_data(&ppptr);
+	return (void ***)ppptr;
+}
+
+enum fentry_test_enum32;
+
+noinline void bpf_fentry_test15_penum32(enum fentry_test_enum32 *pe)
+{
+}
+
+enum fentry_test_enum64 {
+	TEST_ENUM64 = 0xffffffffFFFFFFFFULL
+};
+
+noinline void bpf_fentry_test15_penum64(enum fentry_test_enum64 *pe)
+{
+}
+
+noinline void bpf_fentry_test16_ppenum32(enum fentry_test_enum32 **ppe)
+{
+}
+
+noinline void bpf_fentry_test16_ppenum64(enum fentry_test_enum64 **ppe)
+{
+}
+
+noinline void bpf_fentry_test17_pfunc(void (*pf)(void))
+{
+}
+
+noinline void bpf_fentry_test18_ppfunc(void (**ppf)(void))
+{
+}
+
+noinline void bpf_fentry_test19_pfloat(float *pff)
+{
+}
+
+noinline void bpf_fentry_test20_ppfloat(float **ppff)
+{
+}
+
+noinline void bpf_fentry_test21_pchar(char *pc)
+{
+}
+
+noinline void bpf_fentry_test22_ppchar(char **ppc)
+{
+}
+
+noinline char **bpf_fentry_test23_ret_ppchar(void)
+{
+	return (char **)NULL;
+}
+
+noinline struct file **bpf_fentry_test24_ret_ppfile(void **a)
+{
+	return (struct file **)NULL;
+}
+
 noinline void bpf_fentry_test_sinfo(struct skb_shared_info *sinfo)
 {
 }
@@ -670,20 +762,58 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 	return data;
 }
 
+#define CONSUME(val) do { \
+	typeof(val) __var = (val); \
+	__asm__ __volatile__("" : "+r" (__var)); \
+	(void)__var; \
+} while (0)
+
 int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 			      const union bpf_attr *kattr,
 			      union bpf_attr __user *uattr)
 {
 	struct bpf_fentry_test_t arg = {};
+	struct bpf_fentry_test_pptr_t ts = { .value1 = 1979, .value2 = 2026 };
+	struct bpf_fentry_test_pptr_t *ptr = &ts;
+	u32 *u32_ptr = (u32 *)29;
 	u16 side_effect = 0, ret = 0;
 	int b = 2, err = -EFAULT;
 	u32 retval = 0;
+	const char *attach_name;
 
 	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
+	attach_name = prog->aux->attach_func_name;
+	if (!attach_name)
+		attach_name = "!";
+
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
+		if (!strcmp(attach_name, "bpf_fentry_test11_pptr_nullable")) {
+			/* valid kernel pointer, valid pointer after dereference */
+			CONSUME(bpf_fentry_test11_pptr_nullable(&ptr));
+			break;
+		} else if (!strcmp(attach_name, "bpf_fentry_test12_pptr")) {
+			/* valid kernel pointer, user pointer after dereference */
+			CONSUME(bpf_fentry_test12_pptr(0, &u32_ptr));
+			/* user address on most systems */
+			CONSUME(bpf_fentry_test12_pptr(1, (u32 **)17));
+			break;
+		} else if (!strcmp(attach_name, "bpf_fentry_test13_pptr")) {
+			/* should trigger extable on most systems */
+			CONSUME(bpf_fentry_test13_pptr((void **)~(1ull << 30)));
+			/* user address on most systems */
+			CONSUME(bpf_fentry_test13_pptr((void **)19));
+			/* kernel address at top 4KB, invalid */
+			CONSUME(bpf_fentry_test13_pptr(ERR_PTR(-ENOMEM)));
+			break;
+		} else if (!strcmp(attach_name, "bpf_fentry_test14_ppptr")) {
+			/* kernel address at top 4KB, invalid */
+			CONSUME(bpf_fentry_test14_ppptr(ERR_PTR(-ENOMEM)));
+			break;
+		}
+		fallthrough;
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
 		if (bpf_fentry_test1(1) != 2 ||
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_fexit_multi_level_ptr.c b/tools/testing/selftests/bpf/prog_tests/fentry_fexit_multi_level_ptr.c
new file mode 100644
index 000000000000..07e8b142dd87
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_fexit_multi_level_ptr.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 CrowdStrike, Inc. */
+#include <test_progs.h>
+#include "fentry_fexit_pptr_nullable_test.skel.h"
+#include "fentry_fexit_pptr_test.skel.h"
+#include "fentry_fexit_void_pptr_test.skel.h"
+#include "fentry_fexit_void_ppptr_test.skel.h"
+
+static void test_fentry_fexit_pptr_nullable(void)
+{
+	struct fentry_fexit_pptr_nullable_test *skel = NULL;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = fentry_fexit_pptr_nullable_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_fexit_pptr_nullable_test__open_and_load"))
+		return;
+
+	err = fentry_fexit_pptr_nullable_test__attach(skel);
+	if (!ASSERT_OK(err, "fentry_fexit_pptr_nullable_test__attach"))
+		goto cleanup;
+
+	/* Trigger fentry/fexit programs. */
+	prog_fd = bpf_program__fd(skel->progs.test_fentry_pptr_nullable);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run retval");
+
+	/* Verify fentry was called and captured the correct value. */
+	ASSERT_EQ(skel->bss->fentry_called, 1, "fentry_called");
+	ASSERT_EQ(skel->bss->fentry_ptr_field_value1, 1979, "fentry_ptr_field_value1");
+	ASSERT_EQ(skel->bss->fentry_ptr_field_value2, 2026, "fentry_ptr_field_value2");
+
+	/* Verify fexit captured correct values and return code. */
+	ASSERT_EQ(skel->bss->fexit_called, 1, "fexit_called");
+	ASSERT_EQ(skel->bss->fexit_ptr_field_value1, 1979, "fexit_ptr_field_value1");
+	ASSERT_EQ(skel->bss->fexit_ptr_field_value2, 2026, "fexit_ptr_field_value2");
+	ASSERT_EQ(skel->bss->fexit_retval, 1979, "fexit_retval");
+
+cleanup:
+	fentry_fexit_pptr_nullable_test__destroy(skel);
+}
+
+static void test_fentry_fexit_pptr(void)
+{
+	struct fentry_fexit_pptr_test *skel = NULL;
+	int err, prog_fd, i;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = fentry_fexit_pptr_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_fexit_pptr_test__open_and_load"))
+		return;
+
+	/* Poison some values which should be modified by BPF programs. */
+	for (i = 0; i < ARRAY_SIZE(skel->bss->telemetry); ++i) {
+		skel->bss->telemetry[i].id = 30;
+		skel->bss->telemetry[i].fentry_pptr = 31;
+		skel->bss->telemetry[i].fentry_ptr = 32;
+		skel->bss->telemetry[i].fexit_pptr = 33;
+		skel->bss->telemetry[i].fexit_ptr = 34;
+		skel->bss->telemetry[i].fexit_ret_pptr = 35;
+		skel->bss->telemetry[i].fexit_ret_ptr = 36;
+	}
+
+	err = fentry_fexit_pptr_test__attach(skel);
+	if (!ASSERT_OK(err, "fentry_fexit_pptr_test__attach"))
+		goto cleanup;
+
+	/* Trigger fentry/fexit programs */
+	prog_fd = bpf_program__fd(skel->progs.test_fentry_pptr);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run retval");
+
+	for (i = 0; i < ARRAY_SIZE(skel->bss->telemetry); ++i) {
+		ASSERT_TRUE(skel->bss->telemetry[i].id == 0 ||
+			skel->bss->telemetry[i].id == 1, "id");
+		if (skel->bss->telemetry[i].id == 0) {
+			/* Verify fentry captured the correct value. */
+			ASSERT_EQ(skel->bss->telemetry[i].fentry_called, 1, "fentry_called");
+			ASSERT_EQ(skel->bss->telemetry[i].fentry_ptr, (u64)29, "fentry_ptr");
+
+			/* Verify fexit captured correct values and return address. */
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_called, 1, "fexit_called");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_pptr,
+				skel->bss->telemetry[i].fentry_pptr, "fexit_pptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ptr, (u64)29, "fexit_ptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ret_pptr,
+				skel->bss->telemetry[i].fentry_pptr, "fexit_ret_pptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ret_ptr, (u64)29, "fexit_ret_ptr");
+		} else if (skel->bss->telemetry[i].id == 1) {
+			/* Verify fentry captured the correct value */
+			ASSERT_EQ(skel->bss->telemetry[i].fentry_called, 1, "fentry_called");
+			ASSERT_EQ(skel->bss->telemetry[i].fentry_pptr, 17, "fentry_pptr");
+
+			/*
+			 * Verify fexit captured correct values and return address,
+			 * fentry_ptr value depends on kernel address space layout
+			 * and a mapped page presence at NULL.
+			 */
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_called, 1, "fexit_called");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_pptr, 17, "fexit_pptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ptr,
+				skel->bss->telemetry[i].fentry_ptr, "fexit_ptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ret_pptr, 17, "fexit_ret_pptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ret_ptr,
+				skel->bss->telemetry[i].fentry_ptr, "fexit_ret_ptr");
+		}
+	}
+
+cleanup:
+	fentry_fexit_pptr_test__destroy(skel);
+}
+
+static void test_fentry_fexit_void_pptr(void)
+{
+	struct fentry_fexit_void_pptr_test *skel = NULL;
+	int err, prog_fd, i;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = fentry_fexit_void_pptr_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_fexit_void_pptr_test__open_and_load"))
+		return;
+
+	/* Poison some values which should be modified by BPF programs. */
+	for (i = 0; i < ARRAY_SIZE(skel->bss->telemetry); ++i) {
+		skel->bss->telemetry[i].fentry_pptr = 30;
+		skel->bss->telemetry[i].fentry_ptr = 31;
+		skel->bss->telemetry[i].fexit_pptr = 32;
+		skel->bss->telemetry[i].fexit_ptr = 33;
+	}
+
+	err = fentry_fexit_void_pptr_test__attach(skel);
+	if (!ASSERT_OK(err, "fentry_fexit_void_pptr_test__attach"))
+		goto cleanup;
+
+	/* Trigger fentry/fexit programs. */
+	prog_fd = bpf_program__fd(skel->progs.test_fentry_void_pptr);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run retval");
+	for (i = 0; i < ARRAY_SIZE(skel->bss->telemetry); ++i) {
+		ASSERT_EQ(skel->bss->telemetry[i].fentry_called, 1, "fentry_called");
+		ASSERT_EQ(skel->bss->telemetry[i].fexit_called, 1, "fexit_called");
+		ASSERT_EQ(skel->bss->telemetry[i].fentry_pptr, skel->bss->telemetry[i].fexit_pptr,
+			"fentry_pptr == fexit_pptr");
+		ASSERT_EQ(skel->bss->telemetry[i].fexit_ptr, skel->bss->telemetry[i].fentry_ptr,
+			"fexit_ptr");
+		ASSERT_EQ(skel->bss->telemetry[i].fentry_pptr_addr_valid,
+			skel->bss->telemetry[i].fexit_pptr_addr_valid, "fexit_pptr_addr_valid");
+		if (!skel->bss->telemetry[i].fentry_pptr_addr_valid) {
+			/* Should be set to 0 by kernel address boundary checks or an exception handler. */
+			ASSERT_EQ(skel->bss->telemetry[i].fentry_ptr, 0, "fentry_ptr");
+			ASSERT_EQ(skel->bss->telemetry[i].fexit_ptr, 0, "fexit_ptr");
+		}
+	}
+cleanup:
+	fentry_fexit_void_pptr_test__destroy(skel);
+}
+
+static void test_fentry_fexit_void_ppptr(void)
+{
+	struct fentry_fexit_void_ppptr_test *skel = NULL;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = fentry_fexit_void_ppptr_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_fexit_void_ppptr_test__open_and_load"))
+		return;
+
+	/* Poison some values which should be modified by BPF programs */
+	skel->bss->fentry_pptr = 31;
+
+	err = fentry_fexit_void_ppptr_test__attach(skel);
+	if (!ASSERT_OK(err, "fentry_fexit_void_ppptr_test__attach"))
+		goto cleanup;
+
+	/* Trigger fentry/fexit programs */
+	prog_fd = bpf_program__fd(skel->progs.test_fentry_void_ppptr);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run retval");
+
+	/* Verify invalid memory access results in zeroed register */
+	ASSERT_EQ(skel->bss->fentry_called, 1, "fentry_called");
+	ASSERT_EQ(skel->bss->fentry_pptr, 0, "fentry_pptr");
+
+	/* Verify fexit captured correct values and return value */
+	ASSERT_EQ(skel->bss->fexit_called, 1, "fexit_called");
+	ASSERT_EQ(skel->bss->fexit_retval, (u64)ERR_PTR(-ENOMEM), "fexit_retval");
+
+cleanup:
+	fentry_fexit_void_ppptr_test__destroy(skel);
+}
+
+void test_fentry_fexit_multi_level_ptr(void)
+{
+	if (test__start_subtest("pptr_nullable"))
+		test_fentry_fexit_pptr_nullable();
+	if (test__start_subtest("pptr"))
+		test_fentry_fexit_pptr();
+	if (test__start_subtest("void_pptr"))
+		test_fentry_fexit_void_pptr();
+	if (test__start_subtest("void_ppptr"))
+		test_fentry_fexit_void_ppptr();
+}
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
diff --git a/tools/testing/selftests/bpf/progs/fentry_fexit_pptr_nullable_test.c b/tools/testing/selftests/bpf/progs/fentry_fexit_pptr_nullable_test.c
new file mode 100644
index 000000000000..03c8e30d5303
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_fexit_pptr_nullable_test.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 CrowdStrike, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct bpf_fentry_test_pptr_t {
+	__u32 value1;
+	__u32 value2;
+};
+
+/*
+ * Workaround for a bug in LLVM:
+ * fatal error: error in backend: Empty type name for BTF_TYPE_ID_REMOTE reloc
+ */
+typedef struct bpf_fentry_test_pptr_t *bpf_fentry_test_pptr_p;
+
+__u32 fentry_called = 0;
+__u32 fentry_ptr_field_value1 = 0;
+__u32 fentry_ptr_field_value2 = 0;
+__u32 fexit_called = 0;
+__u32 fexit_ptr_field_value1 = 0;
+__u32 fexit_ptr_field_value2 = 0;
+__u32 fexit_retval = 0;
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+int BPF_PROG(test_fentry_pptr_nullable,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	struct bpf_fentry_test_pptr_t *ptr;
+
+	fentry_called = 1;
+	/* For scalars, the verifier does not enforce NULL pointer checks. */
+	ptr = *bpf_core_cast(pptr__nullable, bpf_fentry_test_pptr_p);
+	bpf_probe_read_kernel(&fentry_ptr_field_value1,
+		sizeof(fentry_ptr_field_value1), &ptr->value1);
+	bpf_probe_read_kernel(&fentry_ptr_field_value2,
+		sizeof(fentry_ptr_field_value2), &ptr->value2);
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test11_pptr_nullable")
+int BPF_PROG(test_fexit_pptr_nullable,
+	struct bpf_fentry_test_pptr_t **pptr__nullable, int ret)
+{
+	struct bpf_fentry_test_pptr_t **pptr;
+	struct bpf_fentry_test_pptr_t *ptr;
+
+	fexit_called = 1;
+	fexit_retval = ret;
+	/* For scalars, the verifier does not enforce NULL pointer checks. */
+	pptr = bpf_core_cast(pptr__nullable, bpf_fentry_test_pptr_p);
+	ptr = bpf_core_cast((*pptr), struct bpf_fentry_test_pptr_t);
+	fexit_ptr_field_value1 = ptr->value1;
+	fexit_ptr_field_value2 = ptr->value2;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_fexit_pptr_test.c b/tools/testing/selftests/bpf/progs/fentry_fexit_pptr_test.c
new file mode 100644
index 000000000000..77c5c09d7117
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_fexit_pptr_test.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 CrowdStrike, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define TELEMETRY_COUNT 2
+
+struct {
+	__u32 id;
+	__u32 fentry_called;
+	__u32 fexit_called;
+	__u64 fentry_pptr;
+	__u64 fentry_ptr;
+	__u64 fexit_pptr;
+	__u64 fexit_ptr;
+	__u64 fexit_ret_pptr;
+	__u64 fexit_ret_ptr;
+} telemetry[TELEMETRY_COUNT];
+
+volatile unsigned int current_index = 0;
+
+/*
+ * Workaround for a bug in LLVM:
+ * fatal error: error in backend: Empty type name for BTF_TYPE_ID_REMOTE reloc
+ */
+typedef __u32 *__u32_p;
+
+SEC("fentry/bpf_fentry_test12_pptr")
+int BPF_PROG(test_fentry_pptr, __u32 id, __u32 **pptr)
+{
+	void *ptr;
+	unsigned int i = current_index;
+
+	if (i >= TELEMETRY_COUNT)
+		return 0;
+
+	if (bpf_probe_read_kernel(&ptr, sizeof(ptr), pptr) != 0)
+		ptr = NULL;
+
+	telemetry[i].id = id;
+	telemetry[i].fentry_called = 1;
+	telemetry[i].fentry_pptr = (__u64)pptr;
+	telemetry[i].fentry_ptr = (__u64)ptr;
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test12_pptr")
+int BPF_PROG(test_fexit_pptr, __u32 id, __u32 **pptr, __u32 **ret)
+{
+	unsigned int i = current_index;
+
+	if (i >= TELEMETRY_COUNT)
+		return 0;
+
+	telemetry[i].fexit_called = 1;
+	telemetry[i].fexit_pptr = (__u64)pptr;
+	telemetry[i].fexit_ptr = (__u64)*bpf_core_cast(pptr, __u32_p);
+	telemetry[i].fexit_ret_pptr = (__u64)ret;
+	telemetry[i].fexit_ret_ptr = ret ? (__u64)*bpf_core_cast(ret, __u32_p) : 0;
+
+	current_index = i + 1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_fexit_void_ppptr_test.c b/tools/testing/selftests/bpf/progs/fentry_fexit_void_ppptr_test.c
new file mode 100644
index 000000000000..15e908f0a1ed
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_fexit_void_ppptr_test.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 CrowdStrike, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u32 fentry_called = 0;
+__u32 fexit_called = 0;
+__u64 fentry_pptr = 0;
+__u64 fexit_retval = 0;
+
+typedef void **volatile *const ppvpc_t;
+
+/*
+ * Workaround for a bug in LLVM:
+ * fatal error: error in backend: Empty type name for BTF_TYPE_ID_REMOTE reloc
+ */
+typedef void **void_pp;
+
+SEC("fentry/bpf_fentry_test14_ppptr")
+int BPF_PROG(test_fentry_void_ppptr, ppvpc_t ppptr)
+{
+	fentry_called = 1;
+	/* Invalid memory access is fixed by boundary checks or exception handler */
+	fentry_pptr = (__u64)*bpf_core_cast((void ***)ppptr, void_pp);
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test14_ppptr")
+int BPF_PROG(test_fexit_void_ppptr, ppvpc_t ppptr, void ***ret)
+{
+	fexit_called = 1;
+	fexit_retval = ret ? (__u64)ret : 0;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_fexit_void_pptr_test.c b/tools/testing/selftests/bpf/progs/fentry_fexit_void_pptr_test.c
new file mode 100644
index 000000000000..588050b9607d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_fexit_void_pptr_test.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 CrowdStrike, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define TELEMETRY_COUNT 3
+
+struct {
+	__u32 fentry_called;
+	__u32 fexit_called;
+	__u32 fentry_pptr_addr_valid;
+	__u32 fexit_pptr_addr_valid;
+	__u64 fentry_pptr;
+	__u64 fentry_ptr;
+	__u64 fexit_pptr;
+	__u64 fexit_ptr;
+} telemetry[TELEMETRY_COUNT];
+
+volatile unsigned int current_index = 0;
+
+/*
+ * Workaround for a bug in LLVM:
+ * fatal error: error in backend: Empty type name for BTF_TYPE_ID_REMOTE reloc
+ */
+typedef void *void_p;
+
+SEC("fentry/bpf_fentry_test13_pptr")
+int BPF_PROG(test_fentry_void_pptr, void **pptr)
+{
+	void *ptr;
+	unsigned int i = current_index;
+
+	if (i >= TELEMETRY_COUNT)
+		return 0;
+
+	telemetry[i].fentry_pptr_addr_valid =
+		(bpf_probe_read_kernel(&ptr, sizeof(ptr), pptr) == 0);
+	if (!telemetry[i].fentry_pptr_addr_valid)
+		ptr = NULL;
+
+	telemetry[i].fentry_called = 1;
+	telemetry[i].fentry_pptr = (__u64)pptr;
+	telemetry[i].fentry_ptr = (__u64)ptr;
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test13_pptr")
+int BPF_PROG(test_fexit_void_pptr, void **pptr, __u8 ret)
+{
+	unsigned int i = current_index;
+
+	if (i >= TELEMETRY_COUNT)
+		return 0;
+
+	telemetry[i].fexit_called = 1;
+	telemetry[i].fexit_pptr = (__u64)pptr;
+	telemetry[i].fexit_pptr_addr_valid = ret;
+
+	/*
+	 * For invalid addresses, the destination register for *dptr is set
+	 * to 0 by the BPF exception handler, JIT address range check, or
+	 * the BPF interpreter.
+	 */
+	telemetry[i].fexit_ptr = (__u64)*bpf_core_cast(pptr, void_p);
+	current_index = i + 1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c b/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c
new file mode 100644
index 000000000000..5465b8a406c0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c
@@ -0,0 +1,523 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verifier tests for single- and multi-level pointer parameter handling
+ * Copyright (c) 2026 CrowdStrike, Inc.
+ */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+#define VALID_CTX_ACCESS(section, name, ctx_offset) \
+SEC(section) \
+__description(section " - valid ctx access at offset " #ctx_offset) \
+__success __retval(0) \
+__naked void name##_ctx_at_##ctx_offset##_valid(void) \
+{ \
+	asm volatile ("				\
+	r2 = *(u64 *)(r1 + " #ctx_offset " );		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all); \
+}
+
+#define INVALID_CTX_ACCESS(section, name, desc, errmsg, ctx_offset) \
+SEC(section) \
+__description(desc) \
+__failure __msg(errmsg) \
+__naked void name##_ctx_at_##ctx_offset##_invalid(void) \
+{ \
+	asm volatile ("				\
+	r2 = *(u64 *)(r1 + " #ctx_offset ");		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all); \
+}
+
+#define INVALID_LOAD_OFFSET(section, name, size, offset, ctx_offset) \
+SEC(section) \
+__description(section " - ctx offset " #ctx_offset ", invalid load at offset " #offset " with scalar") \
+__failure __msg("R2 invalid mem access 'scalar'") \
+__naked void name##_load_at_##offset##_with_scalar(void) \
+{ \
+	asm volatile ("				\
+	r2 = *(u64 *)(r1 + " #ctx_offset ");		\
+	r3 = *(u" #size "*)(r2 + " #offset ");		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all); \
+}
+
+#define INVALID_LOAD(section, name, size, ctx_offset) \
+	INVALID_LOAD_OFFSET(section, name, size, 0, ctx_offset)
+
+#define INVALID_LOAD_NEG_OFFSET(section, name, size, offset, ctx_offset) \
+SEC(section) \
+__description(section " - ctx offset " #ctx_offset ", invalid load at negative offset " #offset " with scalar") \
+__failure __msg("R2 invalid mem access 'scalar'") \
+__naked void name##_load_at_neg_##offset##_with_scalar(void) \
+{ \
+	asm volatile ("				\
+	r2 = *(u64 *)(r1 + " #ctx_offset ");		\
+	r3 = *(u" #size "*)(r2 - " #offset ");		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all); \
+}
+
+#define INVALID_STORE_OFFSET(section, name, size, offset, ctx_offset) \
+SEC(section) \
+__description(section " - ctx offset " #ctx_offset ", invalid store " #size " at offset " #offset " with scalar") \
+__failure __msg("R2 invalid mem access 'scalar'") \
+__naked void name##_store##size##_at_##offset##_with_scalar(void) \
+{ \
+	asm volatile ("				\
+	r2 = *(u64 *)(r1 + " #ctx_offset ");		\
+	*(u" #size "*)(r2 + " #offset ") = 1;		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all); \
+}
+
+#define INVALID_STORE(section, name, size, ctx_offset) \
+	INVALID_STORE_OFFSET(section, name, size, 0, ctx_offset)
+
+#define INVALID_STORE_NEG_OFFSET(section, name, size, offset, ctx_offset) \
+SEC(section) \
+__description(section " - ctx offset " #ctx_offset ", invalid store " #size " at negative offset " #offset " with scalar") \
+__failure __msg("R2 invalid mem access 'scalar'") \
+__naked void name##_store##size##_at_neg_##offset##_with_scalar(void) \
+{ \
+	asm volatile ("				\
+	r2 = *(u64 *)(r1 + "#ctx_offset ");		\
+	*(u" #size "*)(r2 - " #offset ") = 1;		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all); \
+}
+
+/* Double nullable pointer to struct */
+VALID_CTX_ACCESS("fentry/bpf_fentry_test11_pptr_nullable", bpf_fentry_pptr_nullable, 0)
+VALID_CTX_ACCESS("fexit/bpf_fentry_test11_pptr_nullable", bpf_fexit_pptr_nullable, 0)
+INVALID_LOAD("fentry/bpf_fentry_test11_pptr_nullable", bpf_fentry_pptr_nullable, 64, 0)
+INVALID_LOAD_OFFSET("fentry/bpf_fentry_test11_pptr_nullable", bpf_fentry_pptr_nullable, 64, 128, 0)
+INVALID_LOAD_NEG_OFFSET("fentry/bpf_fentry_test11_pptr_nullable", bpf_fentry_pptr_nullable, 64, 128, 0)
+INVALID_STORE("fentry/bpf_fentry_test11_pptr_nullable", bpf_fentry_pptr_nullable, 8, 0)
+INVALID_STORE("fentry/bpf_fentry_test11_pptr_nullable", bpf_fentry_pptr_nullable, 16, 0)
+INVALID_STORE("fentry/bpf_fentry_test11_pptr_nullable", bpf_fentry_pptr_nullable, 32, 0)
+INVALID_STORE("fentry/bpf_fentry_test11_pptr_nullable", bpf_fentry_pptr_nullable, 64, 0)
+INVALID_STORE_OFFSET("fentry/bpf_fentry_test11_pptr_nullable", bpf_fentry_pptr_nullable, 64, 128, 0)
+INVALID_STORE_NEG_OFFSET("fentry/bpf_fentry_test11_pptr_nullable", bpf_fentry_pptr_nullable, 64, 128, 0)
+
+/* Double pointer parameter to u32 at offset 8 in ctx */
+VALID_CTX_ACCESS("fentry/bpf_fentry_test12_pptr", bpf_fentry_test12_pptr, 8)
+VALID_CTX_ACCESS("fexit/bpf_fentry_test12_pptr", bpf_fexit_test12_pptr, 8)
+INVALID_LOAD("fentry/bpf_fentry_test12_pptr", bpf_fentry_test12_pptr, 64, 8)
+INVALID_LOAD_OFFSET("fentry/bpf_fentry_test12_pptr", bpf_fentry_test12_pptr, 64, 64, 8)
+INVALID_LOAD_NEG_OFFSET("fentry/bpf_fentry_test12_pptr", bpf_fentry_test12_pptr, 64, 64, 8)
+INVALID_STORE("fentry/bpf_fentry_test12_pptr", bpf_fentry_test12_pptr, 64, 8)
+INVALID_STORE_OFFSET("fentry/bpf_fentry_test12_pptr", bpf_fentry_test12_pptr, 64, 128, 8)
+INVALID_STORE_NEG_OFFSET("fentry/bpf_fentry_test12_pptr", bpf_fentry_test12_pptr, 64, 128, 8)
+
+/* Triple pointer to void with modifiers */
+VALID_CTX_ACCESS("fentry/bpf_fentry_test14_ppptr", bpf_fentry_ppptr, 0)
+VALID_CTX_ACCESS("fexit/bpf_fentry_test14_ppptr", bpf_fexit_ppptr, 0)
+INVALID_LOAD("fentry/bpf_fentry_test14_ppptr", bpf_fentry_ppptr, 64, 0)
+INVALID_STORE("fentry/bpf_fentry_test14_ppptr", bpf_fentry_ppptr, 64, 0)
+
+/* Trusted double pointer to void */
+SEC("lsm/sb_eat_lsm_opts")
+__description("lsm/sb_eat_lsm_opts double pointer parameter trusted - valid ctx access")
+__success
+__naked void sb_eat_lsm_opts_trusted_valid_ctx_access(void)
+{
+	asm volatile ("				\
+	/* load double pointer - SCALAR_VALUE */\
+	r2 = *(u64 *)(r1 + 8);		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/sb_eat_lsm_opts")
+__description("lsm/sb_eat_lsm_opts double pointer parameter trusted - invalid load with scalar")
+__failure __msg("R2 invalid mem access 'scalar'")
+__naked void sb_eat_lsm_opts_trusted_load_with_scalar(void)
+{
+	asm volatile ("				\
+	/* load double pointer - SCALAR_VALUE */\
+	r2 = *(u64 *)(r1 + 8);		\
+	r3 = *(u64 *)(r2 + 0);		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/sb_eat_lsm_opts")
+__description("lsm/sb_eat_lsm_opts double pointer parameter trusted - invalid store with scalar")
+__failure __msg("R2 invalid mem access 'scalar'")
+__naked void sb_eat_lsm_opts_trusted_store_with_scalar(void)
+{
+	asm volatile ("				\
+	/* load double pointer - SCALAR_VALUE */\
+	r2 = *(u64 *)(r1 + 8);		\
+	*(u64 *)(r2 + 0) = 1;		\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+struct bpf_fentry_test_pptr_t;
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter - bpf helpers with nullable var")
+__success __retval(0)
+int BPF_PROG(ctx_double_ptr_nullable_var_access_bpf_helpers,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	/* Check compatibility with BPF helpers; NULL checks should not be required. */
+	void *ptr;
+
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), pptr__nullable);
+	return 0;
+}
+
+/*
+ * Workaround for a bug in LLVM:
+ * fatal error: error in backend: Empty type name for BTF_TYPE_ID_REMOTE reloc
+ */
+typedef __u32 *__u32_p;
+
+/*
+ * Workaround for:
+ * kfunc bpf_rdonly_cast type ID argument must be of a struct or void
+ */
+struct __u32_wrap {
+	__u32 v;
+};
+
+SEC("fexit/bpf_fentry_test12_pptr")
+__description("fexit/double pointer return value - valid dereference of return val")
+__success __retval(0)
+int BPF_PROG(ctx_double_ptr_return_access, __u32 id,
+	__u32 **pptr, __u32 **ret)
+{
+	__u32 **ppu32;
+	struct __u32_wrap *pu32;
+	ppu32 = bpf_core_cast(ret, __u32_p);
+	pu32 = bpf_core_cast(ppu32, struct __u32_wrap);
+	bpf_printk("%d", pu32->v);
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test12_pptr")
+__description("fexit/double pointer parameter - bpf helpers with return val")
+__success __retval(0)
+int BPF_PROG(ctx_double_ptr_return_access_bpf_helpers, __u32 id,
+	__u32 **pptr, __u32 **ret)
+{
+	/* Check compatibility with BPF helpers */
+	void *ptr;
+
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), pptr);
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), ret);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter - bpf helpers with nullable var, direct ctx pointer")
+__success __retval(0)
+int BPF_PROG(ctx_double_ptr_nullable_var_access_bpf_helpers_ctx,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	/*
+	 * Check compatibility with BPF helpers
+	 * NULL checks should not be required.
+	 */
+	void *ptr;
+
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), &ctx[0] /*pptr__nullable*/);
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test12_pptr")
+__description("fexit/double pointer parameter - bpf helpers with return val, direct ctx pointer")
+__success __retval(0)
+int BPF_PROG(ctx_double_ptr_return_access_bpf_helpers_ctx, __u32 id,
+	__u32 **pptr, __u32 **ret)
+{
+	/* Check compatibility with BPF helpers */
+	void *ptr;
+
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), &ctx[1] /*pptr*/);
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), &ctx[2] /*ret*/);
+	return 0;
+}
+
+struct bpf_fentry_test_pptr_t {
+	__u32 value1;
+	__u32 value2;
+};
+
+/*
+ * Workaround for a bug in LLVM:
+ * fatal error: error in backend: Empty type name for BTF_TYPE_ID_REMOTE reloc
+ */
+typedef struct bpf_fentry_test_pptr_t *bpf_fentry_test_pptr_p;
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter - dereference followed by valid load of field 1")
+__success __retval(0)
+int BPF_PROG(ctx_double_ptr_deref_with_field_1_load,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	struct bpf_fentry_test_pptr_t **pptr;
+	struct bpf_fentry_test_pptr_t *ptr;
+
+	pptr = bpf_core_cast(pptr__nullable, bpf_fentry_test_pptr_p);
+	ptr = bpf_core_cast((*pptr), struct bpf_fentry_test_pptr_t);
+	bpf_printk("%d", ptr->value1);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter - dereference followed by valid load of field 2")
+__success __retval(0)
+int BPF_PROG(ctx_double_ptr_deref_with_field_2_load,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	struct bpf_fentry_test_pptr_t **pptr;
+	struct bpf_fentry_test_pptr_t *ptr;
+
+	pptr = bpf_core_cast(pptr__nullable, bpf_fentry_test_pptr_p);
+	ptr = bpf_core_cast((*pptr), struct bpf_fentry_test_pptr_t);
+	bpf_printk("%d", ptr->value2);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter - dereference followed by invalid out-of-bounds offset load")
+__failure __msg("access beyond struct bpf_fentry_test_pptr_t at off 128 size 4")
+int BPF_PROG(ctx_double_ptr_deref_with_load_by_positive_out_of_bound_offset,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	struct bpf_fentry_test_pptr_t **pptr;
+	struct bpf_fentry_test_pptr_t *ptr;
+	__u32 value;
+
+	pptr = bpf_core_cast(pptr__nullable, bpf_fentry_test_pptr_p);
+	ptr = bpf_core_cast((*pptr), struct bpf_fentry_test_pptr_t);
+
+	asm volatile ("					\
+		r2 = %1;					\
+		/* Load with out-of-bounds offset */\
+		%0 = *(u32 *)(r2 + 0x80)	\
+		" : "=r" (value) : "r" (ptr) : "r2");
+
+	bpf_printk("%d", value);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter - dereference followed by invalid out-of-bounds offset load")
+__failure __msg("R2 is ptr_bpf_fentry_test_pptr_t invalid negative access: off=-128")
+int BPF_PROG(ctx_double_ptr_deref_with_load_by_negative_out_of_bound_offset,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	struct bpf_fentry_test_pptr_t **pptr;
+	struct bpf_fentry_test_pptr_t *ptr;
+	__u32 value;
+
+	pptr = bpf_core_cast(pptr__nullable, bpf_fentry_test_pptr_p);
+	ptr = bpf_core_cast((*pptr), struct bpf_fentry_test_pptr_t);
+
+	asm volatile ("					\
+		r2 = %1;					\
+		/* Load with out-of-bounds offset */\
+		%0 = *(u32 *)(r2 - 0x80);	\
+		" : "=r" (value) : "r" (ptr) : "r2");
+
+	bpf_printk("%d", value);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter - dereference followed by invalid store to field 1")
+__failure __msg("only read is supported")
+int BPF_PROG(ctx_double_ptr_deref_with_field_1_modification,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	struct bpf_fentry_test_pptr_t **pptr;
+	struct bpf_fentry_test_pptr_t *ptr;
+
+	pptr = bpf_core_cast(pptr__nullable, bpf_fentry_test_pptr_p);
+	ptr = bpf_core_cast((*pptr), struct bpf_fentry_test_pptr_t);
+
+	asm volatile ("					\
+		/* Load immediate 1 into w2 */\
+		w2 = 1;						\
+		/* Store to ptr->value1 */	\
+		*(u32 *)(%0 + 0) = r2;		\
+		" :: "r" (ptr) : "r2");
+
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter - dereference followed by invalid store to field 2")
+__failure __msg("only read is supported")
+int BPF_PROG(ctx_double_ptr_deref_with_field_2_modification,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	struct bpf_fentry_test_pptr_t **pptr;
+	struct bpf_fentry_test_pptr_t *ptr;
+
+	pptr = bpf_core_cast(pptr__nullable, bpf_fentry_test_pptr_p);
+	ptr = bpf_core_cast((*pptr), struct bpf_fentry_test_pptr_t);
+
+	asm volatile ("					\
+		/* Load immediate 2 into w2 */\
+		w2 = 2;						\
+		/* Store to ptr->value2 */	\
+		*(u32 *)(%0 + 4) = r2;		\
+		" :: "r" (ptr) : "r2");
+
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter - dereference followed by invalid store to positive offset beyond struct boundaries")
+__failure __msg("only read is supported")
+int BPF_PROG(ctx_double_ptr_deref_with_store_by_positive_invalid_offset,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	struct bpf_fentry_test_pptr_t **pptr;
+	struct bpf_fentry_test_pptr_t *ptr;
+
+	pptr = bpf_core_cast(pptr__nullable, bpf_fentry_test_pptr_p);
+	ptr = bpf_core_cast((*pptr), struct bpf_fentry_test_pptr_t);
+
+	asm volatile ("					\
+		r3 = %0;					\
+		/* Load immediate 3 into w2 */\
+		w2 = 3;						\
+		/* Store with offset outside struct size */	\
+		*(u32 *)(r3 + 0x80) = r2;		\
+		" :: "r" (ptr) : "r2", "r3");
+
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test11_pptr_nullable")
+__description("fentry/double pointer parameter - dereference followed by invalid store to negative offset beyond struct boundaries")
+__failure __msg("R3 is ptr_bpf_fentry_test_pptr_t invalid negative access: off=-128")
+int BPF_PROG(ctx_double_ptr_deref_with_store_by_negative_invalid_offset,
+	struct bpf_fentry_test_pptr_t **pptr__nullable)
+{
+	struct bpf_fentry_test_pptr_t **pptr;
+	struct bpf_fentry_test_pptr_t *ptr;
+
+	pptr = bpf_core_cast(pptr__nullable, bpf_fentry_test_pptr_p);
+	ptr = bpf_core_cast((*pptr), struct bpf_fentry_test_pptr_t);
+
+	asm volatile ("					\
+		r3 = %0;					\
+		/* Load immediate 3 into w2 */\
+		w2 = 3;						\
+		/* Store with offset outside struct size */	\
+		*(u32 *)(r3 - 0x80) = r2;		\
+		" :: "r" (ptr) : "r2", "r3");
+
+	return 0;
+}
+
+/* Pointer to enum 32 */
+VALID_CTX_ACCESS("fentry/bpf_fentry_test15_penum32", bpf_fentry_penum32, 0)
+INVALID_LOAD("fentry/bpf_fentry_test15_penum32", bpf_fentry_penum32, 32, 0)
+VALID_CTX_ACCESS("fexit/bpf_fentry_test15_penum32", bpf_fexit_penum32, 0)
+INVALID_LOAD("fexit/bpf_fentry_test15_penum32", bpf_fexit_penum32, 32, 0)
+INVALID_LOAD_OFFSET("fentry/bpf_fentry_test15_penum32", bpf_fentry_penum32, 8, 1, 0)
+INVALID_STORE("fentry/bpf_fentry_test15_penum32", bpf_fentry_penum32, 8, 0)
+INVALID_STORE("fentry/bpf_fentry_test15_penum32", bpf_fentry_penum32, 32, 0)
+INVALID_STORE("fentry/bpf_fentry_test15_penum32", bpf_fentry_penum32, 64, 0)
+INVALID_STORE_OFFSET("fentry/bpf_fentry_test15_penum32", bpf_fentry_penum32, 8, 1, 0)
+INVALID_STORE_NEG_OFFSET("fentry/bpf_fentry_test15_penum32", bpf_fentry_penum32, 8, 1, 0)
+
+/* Pointer to enum 64 */
+VALID_CTX_ACCESS("fentry/bpf_fentry_test15_penum64", bpf_fentry_penum64, 0)
+INVALID_LOAD("fentry/bpf_fentry_test15_penum64", bpf_fentry_penum64, 64, 0)
+VALID_CTX_ACCESS("fexit/bpf_fentry_test15_penum64", bpf_fexit_penum64, 0)
+INVALID_LOAD("fexit/bpf_fentry_test15_penum64", bpf_fexit_penum64, 64, 0)
+
+/* Double pointer to enum 32 */
+VALID_CTX_ACCESS("fentry/bpf_fentry_test16_ppenum32", bpf_fentry_ppenum32, 0)
+INVALID_LOAD("fentry/bpf_fentry_test16_ppenum32", bpf_fentry_ppenum32, 8, 0)
+
+/* Double pointer to enum 64 */
+VALID_CTX_ACCESS("fentry/bpf_fentry_test16_ppenum64", bpf_fentry_ppenum64, 0)
+INVALID_LOAD("fentry/bpf_fentry_test16_ppenum64", bpf_fentry_ppenum64, 64, 0)
+
+/* Pointer to function */
+VALID_CTX_ACCESS("fentry/bpf_fentry_test17_pfunc", bpf_fentry_pfunc, 0)
+INVALID_LOAD("fentry/bpf_fentry_test17_pfunc", bpf_fentry_pfunc, 8, 0)
+
+/* Double pointer to function */
+VALID_CTX_ACCESS("fentry/bpf_fentry_test18_ppfunc", bpf_fentry_ppfunc, 0)
+INVALID_LOAD("fentry/bpf_fentry_test18_ppfunc", bpf_fentry_ppfunc, 8, 0)
+
+/* Pointer to float */
+INVALID_CTX_ACCESS("fentry/bpf_fentry_test19_pfloat", bpf_fentry_float,
+	"fentry/pointer to float - invalid ctx access",
+	"func 'bpf_fentry_test19_pfloat' arg0 type FLOAT is not a struct", 0)
+
+/* Double pointer to float */
+INVALID_CTX_ACCESS("fentry/bpf_fentry_test20_ppfloat", bpf_fentry_pfloat,
+	"fentry/double pointer to float - invalid ctx access",
+	"func 'bpf_fentry_test20_ppfloat' arg0 type PTR is not a struct", 0)
+
+/* Pointer to char */
+VALID_CTX_ACCESS("fentry/bpf_fentry_test21_pchar", bpf_fentry_pchar, 0)
+INVALID_LOAD("fentry/bpf_fentry_test21_pchar", bpf_fentry_pchar, 64, 0)
+INVALID_STORE("fentry/bpf_fentry_test21_pchar", bpf_fentry_pchar, 8, 0)
+INVALID_STORE("fentry/bpf_fentry_test21_pchar", bpf_fentry_pchar, 16, 0)
+INVALID_STORE("fentry/bpf_fentry_test21_pchar", bpf_fentry_pchar, 32, 0)
+INVALID_STORE("fentry/bpf_fentry_test21_pchar", bpf_fentry_pchar, 64, 0)
+
+/* Double pointer to char */
+VALID_CTX_ACCESS("fentry/bpf_fentry_test22_ppchar", bpf_fentry_ppchar, 0)
+INVALID_LOAD("fentry/bpf_fentry_test22_ppchar", bpf_fentry_ppchar, 64, 0)
+INVALID_STORE("fentry/bpf_fentry_test22_ppchar", bpf_fentry_ppchar, 8, 0)
+INVALID_STORE_OFFSET("fentry/bpf_fentry_test22_ppchar", bpf_fentry_ppchar, 8, 1, 0)
+INVALID_STORE("fentry/bpf_fentry_test22_ppchar", bpf_fentry_ppchar, 16, 0)
+INVALID_STORE("fentry/bpf_fentry_test22_ppchar", bpf_fentry_ppchar, 32, 0)
+INVALID_STORE("fentry/bpf_fentry_test22_ppchar", bpf_fentry_ppchar, 64, 0)
+
+/* Double pointer to char as return value */
+INVALID_CTX_ACCESS("fentry/bpf_fentry_test23_ret_ppchar", bpf_fentry_ret_ppchar,
+	"fentry/bpf_fentry_test23_ret_ppchar - invalid ctx access for nonexisting prameter",
+	"func 'bpf_fentry_test23_ret_ppchar' doesn't have 1-th argument", 0)
+VALID_CTX_ACCESS("fexit/bpf_fentry_test23_ret_ppchar", bpf_fexit_ret_ppchar, 0)
+INVALID_LOAD("fexit/bpf_fentry_test23_ret_ppchar", bpf_fexit_ret_ppchar, 8, 0)
+INVALID_LOAD_OFFSET("fexit/bpf_fentry_test23_ret_ppchar", bpf_fexit_ret_ppchar, 8, 1, 0)
+INVALID_LOAD_NEG_OFFSET("fexit/bpf_fentry_test23_ret_ppchar", bpf_fexit_ret_ppchar, 8, 1, 0)
+INVALID_STORE("fexit/bpf_fentry_test23_ret_ppchar", bpf_fexit_ret_ppchar, 8, 0)
+INVALID_STORE_OFFSET("fexit/bpf_fentry_test23_ret_ppchar", bpf_fexit_ret_ppchar, 8, 1, 0)
+INVALID_STORE_NEG_OFFSET("fexit/bpf_fentry_test23_ret_ppchar", bpf_fexit_ret_ppchar, 8, 1, 0)
+
+/* Double pointer to struct file as return value, double pointer to void as input */
+VALID_CTX_ACCESS("fentry/bpf_fentry_test24_ret_ppfile", bpf_fenty_ret_ppfile, 0)
+INVALID_CTX_ACCESS("fentry/bpf_fentry_test24_ret_ppfile", bpf_fenty_ret_ppfile,
+	"fentry/bpf_fentry_test24_ret_ppfile - invalid ctx access for nonexisting prameter",
+	"func 'bpf_fentry_test24_ret_ppfile' doesn't have 2-th argument", 8)
+VALID_CTX_ACCESS("fexit/bpf_fentry_test24_ret_ppfile", bpf_fexit_ret_ppfile, 0)
+VALID_CTX_ACCESS("fexit/bpf_fentry_test24_ret_ppfile", bpf_fexit_ret_ppfile, 8)
+INVALID_LOAD("fexit/bpf_fentry_test24_ret_ppfile", bpf_fexit_ret_ppfile, 8, 8)
+INVALID_LOAD_OFFSET("fexit/bpf_fentry_test24_ret_ppfile", bpf_fexit_ret_ppfile, 8, 1, 8)
+INVALID_LOAD_NEG_OFFSET("fexit/bpf_fentry_test24_ret_ppfile", bpf_fexit_ret_ppfile, 8, 1, 8)
+INVALID_STORE("fexit/bpf_fentry_test24_ret_ppfile", bpf_fexit_ret_ppfile, 8, 8)
+INVALID_STORE_OFFSET("fexit/bpf_fentry_test24_ret_ppfile", bpf_fexit_ret_ppfile, 8, 1, 8)
+INVALID_STORE_NEG_OFFSET("fexit/bpf_fentry_test24_ret_ppfile", bpf_fexit_ret_ppfile, 8, 1, 8)
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


