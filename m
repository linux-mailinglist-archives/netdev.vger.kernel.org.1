Return-Path: <netdev+bounces-306979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qndlCqzrU2rhgAMAu9opvQ
	(envelope-from <netdev+bounces-306979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:31:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE73745C38
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:31:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=qo+rb81T;
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306979-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306979-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 950963006397
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 19:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7483B71A1;
	Sun, 12 Jul 2026 19:29:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5123B47CA
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 19:29:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884560; cv=none; b=epDGdlgepc3S0glVk9SbwwGuYAPOkPDf+vmzjxFhw9fVYlcwLqrKEsJD+48KNv6zaxo9q4nyH9+n7WmFbEvs1kbnaEQNjB3p5tnKpYGXT8AebKbif6pFeO81JGxXWIRgFXfZXMWnwDL0qoGbZDZE3wewnpX+vWLz/ewLghv+1ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884560; c=relaxed/simple;
	bh=XHMuebYMDE2zzCjQFdsX95/uaswpEPC90O4vAxeBb5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMFIfX69aeNok29YuZlMf54s3rj3T+dWQlZfINyax78AGm5z+sAuI2mxEtqxflT9B2jF01xAPrZzyAPRAhfSnQ1kLl4mjJOTjpOb6zlHcmxnazVgAifOIOAdvrU4Rz7ntMGERoy+GydjnaiTJpIf6WhL94plie2e+qY4jJvbgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=qo+rb81T; arc=none smtp.client-ip=195.121.94.184
X-KPN-MessageId: f9160ab9-7e27-11f1-a59f-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f9160ab9-7e27-11f1-a59f-005056994fde;
	Sun, 12 Jul 2026 21:29:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=IsKD/gs8IXHiatP/vMKAcAxR/5yaXOivhFB8vtSUSTc=;
	b=qo+rb81T5KwzK/VfqCCsbRYH37g5mzD1X0NLkLT9/sWldJ6LWOO8mnbcqjRuH5eIHG/uXSo4py6e/
	 9BCCkCe5KVruqiLUfNV8LlFqUBNi/jIfC1VgCqXQYxQdpwkRvpIa1CculLOGm5A7LrtaFTaH1tsc2M
	 hi0SZr+ucscelO82nV6zYLmhUViMvg2ljIDRz027RcDsR6bOWPtrJnQdDHbDABSXx6Qg24HLFxnc3Y
	 +2MgMe3bessbKOHxUwNHUGnZhuropyOaOmchabypiFh2JvbTDiIv1uXiYpgBQaVgmuCuP0pODrB1zw
	 jMPDzNOmagRDSSFiW1qed3Cm3lXxnxg==
X-KPN-MID: 33|8Y1Jad/S6DZgaGjPq0rLrP6+7VwycBE0/CzINa4P908phdBoulpXSaiKUDUYVQc
 2G2IcPkwwJ3uTpUiZnMPOIA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6qjR8TQeKZ5/loBxW6q/REu1IKiGcUHsGHtkiJ0I4pcTVVXM690JVRbdMUL/yBK
 upDT/Mg3PkajZV1G+UXvFGg==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f8d4259c-7e27-11f1-8dcc-00505699d6e5;
	Sun, 12 Jul 2026 21:29:17 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [net-next v5 4/4] selftest: Add tests for useful handling of LSM denials on SCM_RIGHTS
Date: Sun, 12 Jul 2026 21:29:58 +0200
Message-ID: <20260712192958.1631672-5-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712192958.1631672-1-jkoolstra@xs4all.nl>
References: <20260712192958.1631672-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-306979-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jkoolstra@xs4all.nl,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,xs4all.nl:from_mime,xs4all.nl:email,xs4all.nl:mid,xs4all.nl:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EE73745C38

Tests SCM_RIGHTS fd passing on a socket with the new socket option
SO_RIGHTS_NOTRUNC turned on. To hook into the security_file_receive()
call, BPF is used. The BPF program shares a hashmap with userspace that
lists the inos to be blocked (of the receiver tgid).

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 .../testing/selftests/net/af_unix/.gitignore  |   2 +
 tools/testing/selftests/net/af_unix/Makefile  |   8 +
 tools/testing/selftests/net/af_unix/config    |   7 +
 .../net/af_unix/scm_rights_denial_lsm.bpf.c   |  36 +++
 .../net/af_unix/scm_rights_denial_lsm.c       | 285 ++++++++++++++++++
 5 files changed, 338 insertions(+)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c

diff --git a/tools/testing/selftests/net/af_unix/.gitignore b/tools/testing/selftests/net/af_unix/.gitignore
index 240b26740c9e..5034482f8864 100644
--- a/tools/testing/selftests/net/af_unix/.gitignore
+++ b/tools/testing/selftests/net/af_unix/.gitignore
@@ -3,6 +3,8 @@ msg_oob
 scm_inq
 scm_pidfd
 scm_rights
+scm_rights_denial_lsm
+scm_rights_denial_lsm.bpf.o
 so_peek_off
 unix_connect
 unix_connreset
diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 4c0375e28bbe..594cd26ec398 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -11,9 +11,17 @@ TEST_GEN_PROGS := \
 	scm_inq \
 	scm_pidfd \
 	scm_rights \
+	scm_rights_denial_lsm \
 	so_peek_off \
 	unix_connect \
 	unix_connreset \
 # end of TEST_GEN_PROGS
 
+TEST_GEN_FILES := scm_rights_denial_lsm.bpf.o
+
 include ../../lib.mk
+include ../bpf.mk
+
+$(OUTPUT)/scm_rights_denial_lsm: $(BPFOBJ)
+$(OUTPUT)/scm_rights_denial_lsm: CFLAGS += -I$(SCRATCH_DIR)/include
+$(OUTPUT)/scm_rights_denial_lsm: LDLIBS += -lelf -lz
diff --git a/tools/testing/selftests/net/af_unix/config b/tools/testing/selftests/net/af_unix/config
index b5429c15a53c..acec3f94937e 100644
--- a/tools/testing/selftests/net/af_unix/config
+++ b/tools/testing/selftests/net/af_unix/config
@@ -1,3 +1,10 @@
 CONFIG_AF_UNIX_OOB=y
 CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
+CONFIG_BPF=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_EVENTS=y
+CONFIG_BPF_JIT=y
+CONFIG_SECURITY=y
+CONFIG_BPF_LSM=y
+CONFIG_DEBUG_INFO_BTF=y
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
new file mode 100644
index 000000000000..4f2414465bfd
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct inode {
+	unsigned long i_ino;
+} __attribute__((preserve_access_index));
+
+struct file {
+	struct inode *f_inode;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 16);
+	__type(key, __u64);	/* inode number */
+	__type(value, __u32);	/* tgid of the receiver being tested */
+} denied_inodes SEC(".maps");
+
+SEC("lsm/file_receive")
+int BPF_PROG(scm_rights_deny, struct file *file)
+{
+	__u32 tgid = bpf_get_current_pid_tgid() >> 32;
+	__u64 ino = file->f_inode->i_ino;
+	__u32 *owner;
+
+	owner = bpf_map_lookup_elem(&denied_inodes, &ino);
+	if (owner && *owner == tgid)
+		return -EPERM;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c
new file mode 100644
index 000000000000..941b7decf798
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "kselftest_harness.h"
+
+#ifndef SO_RIGHTS_NOTRUNC
+#define SO_RIGHTS_NOTRUNC 85
+#endif
+
+#define NR_FILES 2
+
+/* Per-file content, so a received fd can be matched to the file sent */
+#define SECRET(n) "secret %d", (n)
+
+/* Indices into the socketpair */
+#define SK_SENDER 0
+#define SK_RECEIVER 1
+
+FIXTURE(scm_rights_denial_bpf)
+{
+	struct bpf_object *obj;
+	struct bpf_link *link;
+	int map_fd;
+	int sk[2];
+	int files[NR_FILES];
+	__u64 inos[NR_FILES];
+	char paths[NR_FILES][64];
+};
+
+FIXTURE_VARIANT(scm_rights_denial_bpf)
+{
+	int sock_type;
+};
+
+FIXTURE_VARIANT_ADD(scm_rights_denial_bpf, stream)
+{
+	.sock_type = SOCK_STREAM,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights_denial_bpf, dgram)
+{
+	.sock_type = SOCK_DGRAM,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights_denial_bpf, seqpacket)
+{
+	.sock_type = SOCK_SEQPACKET,
+};
+
+FIXTURE_SETUP(scm_rights_denial_bpf)
+{
+	struct bpf_program *prog;
+	char lsms[256] = {};
+	int i, fd;
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+
+	fd = open("/sys/kernel/security/lsm", O_RDONLY);
+	ASSERT_GE(fd, 0);
+	ASSERT_LT(0, read(fd, lsms, sizeof(lsms) - 1));
+	close(fd);
+
+	if (!strstr(lsms, "bpf"))
+		SKIP(return, "BPF LSM not active (boot with lsm=...,bpf)");
+
+	self->obj = bpf_object__open_file("scm_rights_denial_lsm.bpf.o", NULL);
+	ASSERT_NE(NULL, self->obj);
+	ASSERT_EQ(0, bpf_object__load(self->obj));
+
+	prog = bpf_object__find_program_by_name(self->obj, "scm_rights_deny");
+	ASSERT_NE(NULL, prog);
+
+	self->link = bpf_program__attach_lsm(prog);
+	ASSERT_NE(NULL, self->link);
+
+	self->map_fd = bpf_object__find_map_fd_by_name(self->obj,
+						       "denied_inodes");
+	ASSERT_GE(self->map_fd, 0);
+
+	ASSERT_EQ(0, socketpair(AF_UNIX, variant->sock_type, 0, self->sk));
+
+	for (i = 0; i < NR_FILES; i++) {
+		struct stat st;
+
+		snprintf(self->paths[i], sizeof(self->paths[i]),
+			 "/tmp/scm_rights_denial_bpf.%d.XXXXXX", i);
+		self->files[i] = mkstemp(self->paths[i]);
+		ASSERT_GE(self->files[i], 0);
+
+		ASSERT_LT(0, dprintf(self->files[i], SECRET(i)));
+
+		ASSERT_EQ(0, fstat(self->files[i], &st));
+		self->inos[i] = st.st_ino;
+	}
+}
+
+FIXTURE_TEARDOWN(scm_rights_denial_bpf)
+{
+	bpf_link__destroy(self->link);
+	bpf_object__close(self->obj);
+
+	for (int i = 0; i < NR_FILES; i++) {
+		if (self->files[i] >= 0) {
+			close(self->files[i]);
+			unlink(self->paths[i]);
+		}
+	}
+
+	close(self->sk[SK_SENDER]);
+	close(self->sk[SK_RECEIVER]);
+}
+
+static int deny_inode(int map_fd, __u64 ino)
+{
+	__u32 tgid = getpid();
+
+	return bpf_map_update_elem(map_fd, &ino, &tgid, BPF_ANY);
+}
+
+static int set_notrunc(int sk)
+{
+	int one = 1;
+
+	return setsockopt(sk, SOL_SOCKET, SO_RIGHTS_NOTRUNC,
+			  &one, sizeof(one));
+}
+
+static int send_fds(int sk, int *fds, int n)
+{
+	char ctrl[CMSG_SPACE(NR_FILES * sizeof(int))] = {};
+	char data = 'x';
+	struct iovec iov = {
+		.iov_base = &data,
+		.iov_len = sizeof(data),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = ctrl,
+		.msg_controllen = CMSG_SPACE(n * sizeof(int)),
+	};
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(n * sizeof(int));
+	memcpy(CMSG_DATA(cmsg), fds, n * sizeof(int));
+
+	return sendmsg(sk, &msg, 0);
+}
+
+static int recv_fd_slots(int sk, int *slots, int *msg_flags)
+{
+	int nr_slots;
+	char ctrl[CMSG_SPACE(NR_FILES * sizeof(int))];
+	char data;
+	struct iovec iov = {
+		.iov_base = &data,
+		.iov_len = sizeof(data),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = ctrl,
+		.msg_controllen = sizeof(ctrl),
+	};
+	struct cmsghdr *cmsg;
+
+	if (recvmsg(sk, &msg, 0) < 0)
+		return -1;
+
+	*msg_flags = msg.msg_flags;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (!cmsg)
+		return 0;
+
+	nr_slots = (cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
+	memcpy(slots, CMSG_DATA(cmsg), nr_slots * sizeof(int));
+
+	return nr_slots;
+}
+
+/* Prove a received fd works by reading back the file's content. */
+static int check_secret(int fd, int idx)
+{
+	char want[32], got[32] = {};
+
+	snprintf(want, sizeof(want), SECRET(idx));
+	if (pread(fd, got, sizeof(got) - 1, 0) < 0)
+		return -1;
+
+	return strcmp(want, got);
+}
+
+TEST_F(scm_rights_denial_bpf, all_allowed)
+{
+	int slots[NR_FILES], nr_slots, flags, i;
+
+	ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
+	ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
+	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
+
+	ASSERT_EQ(NR_FILES, nr_slots);
+	EXPECT_EQ(0, flags & MSG_CTRUNC);
+
+	for (i = 0; i < NR_FILES; i++) {
+		ASSERT_GE(slots[i], 0);
+		EXPECT_EQ(0, check_secret(slots[i], i));
+		close(slots[i]);
+	}
+}
+
+TEST_F(scm_rights_denial_bpf, first_denied)
+{
+	int slots[NR_FILES], nr_slots, flags;
+
+	ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[0]));
+
+	ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
+	ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
+	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
+
+	ASSERT_EQ(NR_FILES, nr_slots);
+	EXPECT_EQ(0, flags & MSG_CTRUNC);
+	EXPECT_EQ(-EPERM, slots[0]);
+
+	ASSERT_GE(slots[1], 0);
+	EXPECT_EQ(0, check_secret(slots[1], 1));
+	close(slots[1]);
+}
+
+TEST_F(scm_rights_denial_bpf, all_denied)
+{
+	int slots[NR_FILES], nr_slots, flags, i;
+
+	for (i = 0; i < NR_FILES; i++)
+		ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[i]));
+
+	ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
+	ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
+	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
+
+	ASSERT_EQ(NR_FILES, nr_slots);
+	EXPECT_EQ(0, flags & MSG_CTRUNC);
+
+	for (i = 0; i < NR_FILES; i++)
+		EXPECT_EQ(-EPERM, slots[i]);
+}
+
+TEST_F(scm_rights_denial_bpf, denied_without_notrunc)
+{
+	int slots[NR_FILES], nr_slots, flags;
+
+	/*
+	 * Baseline behaviour without SO_RIGHTS_NOTRUNC: the fd array is
+	 * truncated at the first denied fd and MSG_CTRUNC is set.
+	 */
+	ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[1]));
+
+	ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
+	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
+
+	ASSERT_EQ(1, nr_slots);
+	EXPECT_NE(0, flags & MSG_CTRUNC);
+
+	ASSERT_GE(slots[0], 0);
+	EXPECT_EQ(0, check_secret(slots[0], 0));
+	close(slots[0]);
+}
+
+TEST_HARNESS_MAIN
-- 
2.55.0


