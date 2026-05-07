Return-Path: <netdev+bounces-285253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF3GBPxw/GmkQAAAu9opvQ
	(envelope-from <netdev+bounces-285253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:01:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EC04E7286
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DC253034D7F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C93EF0AF;
	Thu,  7 May 2026 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dA4RCFVK"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3B3E92BF;
	Thu,  7 May 2026 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151524; cv=none; b=ZiBbs/c0j2zxTwKHu8+FUKMGTZhp+zjo5KfHcAQF53Ykm/9TfL/4GQFxLmFfmeq3n1v2X+cmk4Al9N2KbEdSdtrSGuI2sVaWepoW3NxlrzfRHce3MgQtWFsf5D+uHaGUKhvAgBTGaSvGy0DMLyLUALLIhH9ZwzZqk4ztFfpfC58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151524; c=relaxed/simple;
	bh=l18IGkzGKUG05f5QZQid8OMan7Jey+HSy4shswzlQO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFBwIeT5t9yfHhh7HFGvLj/AOX2kee+IhVeqf1WeKepgu32tRdA/EYKRswUB7IyJf/iQInjHGzbmvkG7VcNMj2h7sDzOaFU7J/ZajfFkwxuoxybHkmM4wmrgzPDDU+QGEGJ7sjX61NBmuLffFVfRCLWtoAHQZW84dlMS3jAxwkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dA4RCFVK; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=8MF4f0bUeK5/+4FQOcifNfCRHuJo7/exyM7nIjJOTI0=; b=dA4RCFVK8vwrGxosswytdt8yVx
	tGtYiShl/FoauJR31PE+rDndukvsLbsSwrRUkm1WIiGW/5ujRI+3t93YAyqNkJCI7/dOkjPx1YkcU
	FA71jewEA6hIAqIjWUFbxKtFC62bd72Sz4m8bsUgrOOMWdFwaV+cV0F0szhKiQIRUUIBqcd4Ee4s6
	aMFImpO9fF+KHM7y03vjOJCRdxYn0ghgvn3lWVpz9ATO6oSSqH3cV1L0+K5lx5k9IyMzOTZ8eAegp
	Pw4gUBJQHPblQXcdxznUt2jjU+kRLZiTwksyx3nEAY0ghmBYX7/k0N0qBbFDiLYTbxxhk/HAQE/zZ
	7CiwJSAg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKwQv-004Job-0l;
	Thu, 07 May 2026 10:58:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 07 May 2026 03:57:54 -0700
Subject: [PATCH net-next v2 5/5] selftests: net: getsockopt_iter: cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-getsock_two-v2-5-5873111d9c12@debian.org>
References: <20260507-getsock_two-v2-0-5873111d9c12@debian.org>
In-Reply-To: <20260507-getsock_two-v2-0-5873111d9c12@debian.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, Martin Schiller <ms@dev.tdt.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=7235; i=leitao@debian.org;
 h=from:subject:message-id; bh=l18IGkzGKUG05f5QZQid8OMan7Jey+HSy4shswzlQO4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/HAwhrfvgmmY2faAwRXUM+RTtqagW8egcMBoM
 bSNwPd0S5uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafxwMAAKCRA1o5Of/Hh3
 bbmsD/4rl/NIg1L4BK66/k1oS5ZySRtEAE1DxNa5dsRE7xC7fxNyG6BVbCo1koI344Df6qe4Fr6
 GaXIWi4QouQgj09hglpTi2e0Gtr+XM4UDu4acZ5lkC05m7CBcO+VC2R9ADovQpc7j27edI02IQ+
 /hKyyVCYblOweqC5bHPr+qIbQ69EjSPWpz+ampRkUUJLTJqkwEInlaUZuXeYBkfZVSfM6t4J1a3
 HO/6Fvs2DPRWZpOJlm5qgzTmuXEp5etebT9CpcY+Pe2mDlVXolpbF+X1OqycimtaoJhLzSHdEbl
 NNNuVGvuSLMcBHVu0Y8CpbDiw4kJ3nKCXJ82uYgO571RsWNcfC1IRlax1FOpK000f8neKiDyXYS
 eRurPtIofxkbgshhchTDoeDGjFpn9X9tboHMPX12iW6kX4aZZtewifd0vsV/lvAaNT17fk/m/Pa
 3mLgtQE0SZ94E6vzFa9p7nalCYvGXw1daaPWQ5MqoT15Kjt/pFXgCZbvHjqq8wHL5vj4g6lr0W6
 dL5cPJFdo1I43Uhs67rPiCBUbbSmCL4PS5x1cDhOeP9UM+Mte3rTT/s/dEomOmo2ft/ZBqcc5EP
 RKTL7xEBnalP1ejf2F3f/fKV6fBLOoWDZTW0GMbRYXUSi56fTuLJPemx9OdDdQIGYMIt7i6GQa1
 D4kMxg6ADXWliBA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: F2EC04E7286
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285253-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[debian.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[bobbyeshleman.meta.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Action: no action

Apply two cleanups suggested by Stanislav and bobby on the original
selftest series:

- Reorder local variable declarations into reverse christmas-tree
  order (longest line first). Because that ordering puts socklen_t
  optlen before the variable whose size it stores, the
  "optlen = sizeof(...)" initializer is moved out of the declaration
  to a plain assignment in the test body, as Stanislav suggested.

- Add ASSERT_EQ(optlen, ...) on every error path so the value the
  kernel writes back to the userspace optlen is pinned down even
  when the syscall returns -1. With do_sock_getsockopt() now writing
  opt->optlen back to userspace unconditionally, asserting that the
  netlink/vsock error paths leave the original input length untouched
  guards against future regressions.

Bobby Eshleman pointed out that
SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW/OLD return a sock_timeval-shaped
payload (16 bytes on 64-bit), which is wider than the u64 case
already covered. Add four tests that exercise this path:

- connect_timeout_new_exact         exact-size buffer
- connect_timeout_new_oversize_clamped  oversize buffer, clamped
- connect_timeout_new_undersize     undersize -> -EINVAL, optlen
                                    untouched
- connect_timeout_old_exact         exact-size buffer for OLD optname

Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Suggested-by: Bobby Eshleman <bobbyeshleman@meta.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/getsockopt_iter.c | 109 +++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
index 179f9e84926fd..209569354d0e3 100644
--- a/tools/testing/selftests/net/getsockopt_iter.c
+++ b/tools/testing/selftests/net/getsockopt_iter.c
@@ -22,6 +22,7 @@
 #include <unistd.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
+#include <linux/time_types.h>
 #include <linux/vm_sockets.h>
 #include <sys/socket.h>
 #include "kselftest_harness.h"
@@ -61,8 +62,10 @@ FIXTURE_TEARDOWN(netlink)
 
 TEST_F(netlink, pktinfo_exact)
 {
+	socklen_t optlen;
 	int val = -1;
-	socklen_t optlen = sizeof(val);
+
+	optlen = sizeof(val);
 
 	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
 				&val, &optlen));
@@ -73,7 +76,9 @@ TEST_F(netlink, pktinfo_exact)
 TEST_F(netlink, pktinfo_oversize_clamped)
 {
 	char buf[16] = {};
-	socklen_t optlen = sizeof(buf);
+	socklen_t optlen;
+
+	optlen = sizeof(buf);
 
 	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
 				buf, &optlen));
@@ -83,11 +88,14 @@ TEST_F(netlink, pktinfo_oversize_clamped)
 TEST_F(netlink, pktinfo_undersize)
 {
 	char buf[2] = {};
-	socklen_t optlen = sizeof(buf);
+	socklen_t optlen;
+
+	optlen = sizeof(buf);
 
 	ASSERT_EQ(-1, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
 				 buf, &optlen));
 	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(sizeof(buf), optlen);
 }
 
 TEST_F(netlink, list_memberships_size_discovery)
@@ -105,7 +113,9 @@ TEST_F(netlink, list_memberships_size_discovery)
 TEST_F(netlink, list_memberships_full_read)
 {
 	__u32 buf[64] = {};
-	socklen_t optlen = sizeof(buf);
+	socklen_t optlen;
+
+	optlen = sizeof(buf);
 
 	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK,
 				NETLINK_LIST_MEMBERSHIPS,
@@ -117,22 +127,28 @@ TEST_F(netlink, list_memberships_full_read)
 
 TEST_F(netlink, bad_level)
 {
+	socklen_t optlen;
 	int val;
-	socklen_t optlen = sizeof(val);
+
+	optlen = sizeof(val);
 
 	ASSERT_EQ(-1, getsockopt(self->fd, SOL_SOCKET + 1, NETLINK_PKTINFO,
 				 &val, &optlen));
 	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(val), optlen);
 }
 
 TEST_F(netlink, bad_optname)
 {
+	socklen_t optlen;
 	int val;
-	socklen_t optlen = sizeof(val);
+
+	optlen = sizeof(val);
 
 	ASSERT_EQ(-1, getsockopt(self->fd, SOL_NETLINK, 0x7fff,
 				 &val, &optlen));
 	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(val), optlen);
 }
 
 /* ---------- vsock ---------- */
@@ -157,8 +173,10 @@ FIXTURE_TEARDOWN(vsock)
 
 TEST_F(vsock, buffer_size_exact)
 {
+	socklen_t optlen;
 	uint64_t val = 0;
-	socklen_t optlen = sizeof(val);
+
+	optlen = sizeof(val);
 
 	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
 				SO_VM_SOCKETS_BUFFER_SIZE,
@@ -170,7 +188,9 @@ TEST_F(vsock, buffer_size_exact)
 TEST_F(vsock, buffer_size_oversize_clamped)
 {
 	char buf[16] = {};
-	socklen_t optlen = sizeof(buf);
+	socklen_t optlen;
+
+	optlen = sizeof(buf);
 
 	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
 				SO_VM_SOCKETS_BUFFER_SIZE,
@@ -181,33 +201,100 @@ TEST_F(vsock, buffer_size_oversize_clamped)
 TEST_F(vsock, buffer_size_undersize)
 {
 	char buf[4] = {};
-	socklen_t optlen = sizeof(buf);
+	socklen_t optlen;
+
+	optlen = sizeof(buf);
 
 	ASSERT_EQ(-1, getsockopt(self->fd, AF_VSOCK,
 				 SO_VM_SOCKETS_BUFFER_SIZE,
 				 buf, &optlen));
 	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(sizeof(buf), optlen);
 }
 
 TEST_F(vsock, bad_level)
 {
+	socklen_t optlen;
 	uint64_t val;
-	socklen_t optlen = sizeof(val);
+
+	optlen = sizeof(val);
 
 	ASSERT_EQ(-1, getsockopt(self->fd, SOL_SOCKET + 1,
 				 SO_VM_SOCKETS_BUFFER_SIZE,
 				 &val, &optlen));
 	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(val), optlen);
 }
 
 TEST_F(vsock, bad_optname)
 {
+	socklen_t optlen;
 	uint64_t val;
-	socklen_t optlen = sizeof(val);
+
+	optlen = sizeof(val);
 
 	ASSERT_EQ(-1, getsockopt(self->fd, AF_VSOCK, 0x7fff,
 				 &val, &optlen));
 	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(val), optlen);
+}
+
+/* SO_VM_SOCKETS_CONNECT_TIMEOUT_{NEW,OLD} return a sock_timeval-shaped
+ * payload, which is wider than u64 on 64-bit. They exercise the path
+ * where the protocol's reported lv (16 bytes) is larger than the
+ * common 8-byte u64 case covered above.
+ */
+TEST_F(vsock, connect_timeout_new_exact)
+{
+	struct __kernel_sock_timeval tv = {};
+	socklen_t optlen;
+
+	optlen = sizeof(tv);
+
+	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
+				SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW,
+				&tv, &optlen));
+	ASSERT_EQ(sizeof(tv), optlen);
+}
+
+TEST_F(vsock, connect_timeout_new_oversize_clamped)
+{
+	char buf[sizeof(struct __kernel_sock_timeval) * 2] = {};
+	socklen_t optlen;
+
+	optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
+				SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW,
+				buf, &optlen));
+	ASSERT_EQ(sizeof(struct __kernel_sock_timeval), optlen);
+}
+
+TEST_F(vsock, connect_timeout_new_undersize)
+{
+	socklen_t optlen;
+	uint64_t val;
+
+	optlen = sizeof(val);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, AF_VSOCK,
+				 SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW,
+				 &val, &optlen));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(sizeof(val), optlen);
+}
+
+TEST_F(vsock, connect_timeout_old_exact)
+{
+	struct __kernel_old_timeval tv = {};
+	socklen_t optlen;
+
+	optlen = sizeof(tv);
+
+	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
+				SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD,
+				&tv, &optlen));
+	ASSERT_EQ(sizeof(tv), optlen);
 }
 
 TEST_HARNESS_MAIN

-- 
2.52.0


