Return-Path: <netdev+bounces-283220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLRfCaHM9GkDFAIAu9opvQ
	(envelope-from <netdev+bounces-283220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:54:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16E4ADBF3
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54ED3300644F
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA853D1CA4;
	Fri,  1 May 2026 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="fFCZZBaM"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76443D171E;
	Fri,  1 May 2026 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650805; cv=none; b=MsfhqGJeEWRVmWavwjvCV+QlVf0ulWZQNGVivQtCYeIDfKG84vD4qFW1z9iEpPUYbPX4SQrEWieXnCwf3ayiwwHnrl/o35kYT9yTG5H+2an7E+oL5AA4eiL6YAh0A89g0Eo7XNUcDE7CHcBC1XrlE1+y7Pe8D0LCWRnV4Xe2QFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650805; c=relaxed/simple;
	bh=FNs5J5Ppb9l1ztLphXVsPoaZSfqh9Dqf/9mSZ8ms9Cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MRlRBO4qbFDwxjUA9j8FZsMFAzoZpcAjvyrDV6vUV2Ry0JSAhjmZFq9o41WlR/LyCF+ZowIq32NCxJmQuTWF1pPRjJg+L3+ADiIfqci9vYn/z2P3nbXGiulNJvCx6kQVehyGFDYSO1E27wq/KshNjhJtFEDT4ime9dqJnR2GXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fFCZZBaM; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=+4lpJ9L4N91jikzY7fBps/QDWvLq2JJ9buQYKU46m78=; b=fFCZZBaM+1hmr4K4Gb5kLz0Lnt
	LA2RWmIuC7GVr229/QCKKXCCRTmZaWiRfEpI6UuIn5k7ZZdXh2rMW3+tmwlipnxtOCTecFAnxGUkw
	5CoB9REOEMxXOzzvDtSFi/wmmIaV4zrUQub+BdvlUs3AhpOvLttOEfofcmD3LxMv9GgH99ZdTTlSe
	rYgtjZQfdPo11ZDoCNtHhtLsacPPnFDBFh4dmf9JC57XwGWAroDZifIfmQXwpGZ1ooKYZFPI/OyzY
	Hl2qFLDRKxzcam0PVl+XaUW2kHKgmXvudjnsSYi3RbcdjLstT0FQQWdYP6R6eCnc+ahv5sMdg3qGB
	vT9YMy/g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wIqB7-008gYH-0i;
	Fri, 01 May 2026 15:53:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 01 May 2026 08:52:53 -0700
Subject: [PATCH net-next 3/3] net: selftests: add getsockopt_iter
 regression tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-getsock_one-v1-3-810ce23ea70e@debian.org>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
In-Reply-To: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=6606; i=leitao@debian.org;
 h=from:subject:message-id; bh=FNs5J5Ppb9l1ztLphXVsPoaZSfqh9Dqf/9mSZ8ms9Cw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp9MxewrftFm0LPPjxpzSxjMAg7cM99UVVX2RVP
 u1UFEqZZ1uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafTMXgAKCRA1o5Of/Hh3
 bejJD/9XqoP3ZXB/ndTEWq2fefaiWFjV05H4/wfeVb+oqfCIZ/JNGoAVZ4b5WbWekt09dB3Dvp3
 SJeCOa2t36EEDxyiMyZcvYfJ/iVc6kKqKPO98RH+mQXqxxV+PHyDb5EeHiHZBHdxN0zSQpm32Xe
 9v74nag1d94PzXeRRcv+ZoGnu19btB4N+ciNG3EmlcveZ9asTJAkPSAQfJa0X3gF09CIczNvNYR
 wRSg2l80UB9sqaxCYqqcx0sG+aq8izvVHBrGaFFWlPaIKwDKP+2Pkb++pL5L+5NzSnPkpGW1sqZ
 ByjuqwE4g43bBpXQorzyLxEb0P/wRiI/cb3kCb5heb6gv5nogr55qRpLsnzpD1WeTSYiP97o8ot
 kC2UEpxAe+yfrYyGNyPAHSvFqogI54fkQRXRazld6mwYtucA2onWT5X/pGxuB0A83ls4HCSVjXv
 VxY51VGMOaEGg0ES0qsxAeCHA2ajcB1syA9QXlkHYnqea53PPsqcc/rMd4uWB/moNEixDt4FXXw
 DgM8uLX+PhjBr/nwzHm4jrKmOawt68MyF2OIOpy+/xjNcivbS+bx4djlsY2muoS7CmnT2h656nF
 21Ji4pSTDmmK5A7glsUlCVYoRtPY2mFeWqndulCI5+ymAhyiB10kARen1LoOt64WEkFX6zDuKFK
 pzdKEUYnnR4iRwQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: BA16E4ADBF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283220-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Add a single kselftest covering the proto_ops getsockopt_iter
conversions for AF_NETLINK and AF_VSOCK, using one fixture per protocol:

netlink:

NETLINK_PKTINFO covers the flag-style int path (exact size, oversize
clamp, undersize -EINVAL); NETLINK_LIST_MEMBERSHIPS covers the
size-discovery path that always reports the required buffer length back
via optlen, even when the user buffer is too small to receive any group
bits.

vsock:
SO_VM_SOCKETS_BUFFER_SIZE covers the u64 path (exact size, oversize
clamp, undersize -EINVAL).

Each fixture also exercises an unknown optname and a bogus level so
the returned-length / errno semantics preserved by the sockopt_t
conversion are pinned down.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/getsockopt_iter.c | 213 ++++++++++++++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a275ed5840265..baa30287cf222 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -176,6 +176,7 @@ TEST_GEN_PROGS := \
 	bind_timewait \
 	bind_wildcard \
 	epoll_busy_poll \
+	getsockopt_iter \
 	icmp_rfc4884 \
 	ipv6_fragmentation \
 	proc_net_pktgen \
diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
new file mode 100644
index 0000000000000..179f9e84926fd
--- /dev/null
+++ b/tools/testing/selftests/net/getsockopt_iter.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Quick test for getsockopt{_iter} tests.
+ *
+ * Each fixture targets one converted protocol and pins down the
+ * returned-length / errno semantics across buffer-size variations,
+ * an unknown optname and a bogus level.
+ *
+ * - netlink: NETLINK_PKTINFO covers the flag-style int path; the
+ *   NETLINK_LIST_MEMBERSHIPS cases cover the size-discovery path
+ *   that always reports the required buffer length back via optlen,
+ *   even when the user buffer is too small to receive any group bits.
+ * - vsock:   SO_VM_SOCKETS_BUFFER_SIZE covers the u64 path.
+ *
+ * Author: Breno Leitao <leitao@debian.org>
+ */
+
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/vm_sockets.h>
+#include <sys/socket.h>
+#include "kselftest_harness.h"
+
+#ifndef AF_VSOCK
+#define AF_VSOCK 40
+#endif
+
+/* ---------- netlink ---------- */
+
+FIXTURE(netlink)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(netlink)
+{
+	int group = RTNLGRP_LINK;
+
+	self->fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	if (self->fd < 0)
+		SKIP(return, "AF_NETLINK socket: %s", strerror(errno));
+
+	/* Joining a multicast group grows nlk->ngroups so the
+	 * NETLINK_LIST_MEMBERSHIPS path has a non-zero size to report.
+	 */
+	if (setsockopt(self->fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
+		       &group, sizeof(group)) < 0)
+		SKIP(return, "NETLINK_ADD_MEMBERSHIP: %s", strerror(errno));
+}
+
+FIXTURE_TEARDOWN(netlink)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+TEST_F(netlink, pktinfo_exact)
+{
+	int val = -1;
+	socklen_t optlen = sizeof(val);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
+				&val, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+	ASSERT_TRUE(val == 0 || val == 1);
+}
+
+TEST_F(netlink, pktinfo_oversize_clamped)
+{
+	char buf[16] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
+				buf, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+}
+
+TEST_F(netlink, pktinfo_undersize)
+{
+	char buf[2] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
+				 buf, &optlen));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST_F(netlink, list_memberships_size_discovery)
+{
+	socklen_t optlen = 0;
+	char dummy;
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK,
+				NETLINK_LIST_MEMBERSHIPS,
+				&dummy, &optlen));
+	ASSERT_GT(optlen, 0);
+	ASSERT_EQ(0, optlen % sizeof(__u32));
+}
+
+TEST_F(netlink, list_memberships_full_read)
+{
+	__u32 buf[64] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK,
+				NETLINK_LIST_MEMBERSHIPS,
+				buf, &optlen));
+	ASSERT_GT(optlen, 0);
+	ASSERT_LE(optlen, sizeof(buf));
+	ASSERT_EQ(0, optlen % sizeof(__u32));
+}
+
+TEST_F(netlink, bad_level)
+{
+	int val;
+	socklen_t optlen = sizeof(val);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_SOCKET + 1, NETLINK_PKTINFO,
+				 &val, &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+}
+
+TEST_F(netlink, bad_optname)
+{
+	int val;
+	socklen_t optlen = sizeof(val);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_NETLINK, 0x7fff,
+				 &val, &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+}
+
+/* ---------- vsock ---------- */
+
+FIXTURE(vsock)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(vsock)
+{
+	self->fd = socket(AF_VSOCK, SOCK_STREAM, 0);
+	if (self->fd < 0)
+		SKIP(return, "AF_VSOCK socket: %s", strerror(errno));
+}
+
+FIXTURE_TEARDOWN(vsock)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+TEST_F(vsock, buffer_size_exact)
+{
+	uint64_t val = 0;
+	socklen_t optlen = sizeof(val);
+
+	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
+				SO_VM_SOCKETS_BUFFER_SIZE,
+				&val, &optlen));
+	ASSERT_EQ(sizeof(uint64_t), optlen);
+	ASSERT_GT(val, 0);
+}
+
+TEST_F(vsock, buffer_size_oversize_clamped)
+{
+	char buf[16] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
+				SO_VM_SOCKETS_BUFFER_SIZE,
+				buf, &optlen));
+	ASSERT_EQ(sizeof(uint64_t), optlen);
+}
+
+TEST_F(vsock, buffer_size_undersize)
+{
+	char buf[4] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, AF_VSOCK,
+				 SO_VM_SOCKETS_BUFFER_SIZE,
+				 buf, &optlen));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST_F(vsock, bad_level)
+{
+	uint64_t val;
+	socklen_t optlen = sizeof(val);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_SOCKET + 1,
+				 SO_VM_SOCKETS_BUFFER_SIZE,
+				 &val, &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+}
+
+TEST_F(vsock, bad_optname)
+{
+	uint64_t val;
+	socklen_t optlen = sizeof(val);
+
+	ASSERT_EQ(-1, getsockopt(self->fd, AF_VSOCK, 0x7fff,
+				 &val, &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+}
+
+TEST_HARNESS_MAIN

-- 
2.52.0


