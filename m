Return-Path: <netdev+bounces-299877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dbbSDWFeMWq5iAUAu9opvQ
	(envelope-from <netdev+bounces-299877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:32:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C298690858
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:32:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=OyqOFUBc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299877-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299877-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93322304033A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32D53A1D01;
	Tue, 16 Jun 2026 14:29:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CDD37D107
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:29:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620198; cv=none; b=KbeseyGBJre44SxAe+Ai8XtY4uOlXdPGxiOJERS5mFmwwMY6q5XE0RNQheTNiJSvb+8w3NteqAz3k/Tq7prPLGf1siTxOP92iMrCz4aMJTk06KI6JvalFK47IFvGYJeGUPM+UiJQ7gABpIHtZHbeGHYEH3qnHP09j6Z3z+mNSdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620198; c=relaxed/simple;
	bh=y5brgVzambFq77rNajEP84tsgPPGdVJQYLBG6xf/O3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4o77KfeuGOUvL8jsdXJpXi1NUSvWoK7u0YH99gq8VZ2rZtfTBA+VBdSSFT7XkMKO8QlKaKzr15BmfkINX2tUEooOuiWSv05riT/6Km7q89XuaX/GxrrZNfxVZ2gyPz3F0kW7mjlVIdhVvTW6e6ID3jdW/QYyTbQnZFyaTuRrzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=OyqOFUBc; arc=none smtp.client-ip=195.121.94.184
X-KPN-MessageId: d4813a74-698f-11f1-afe8-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d4813a74-698f-11f1-afe8-005056994fde;
	Tue, 16 Jun 2026 16:29:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=mZF1xELyL4OHuYN/UOAekcjln1qmxPPpJjLiXZSBCIY=;
	b=OyqOFUBclroF9hMzcc9igiwPUjQSCba3ONkOLRepL+ndaMbpBEBx27LXut+Dm2dxJyIzIvc3FaVfU
	 Rz4tAdoqtE17wAnMZhPDYjqkKlHTQc3yjLH1mLBTc97Yc3EnfcFwdAbRjhx/XOG9KvXbOSiHSCh6pP
	 MFW8XCU9YRXa8orCuF8GQXNo41VegT/NEZ5x4FIPf0YsEiJt06etcAfT6HpmKMnAwljVLa8lRgd1yk
	 KNAyI47FkbPGYGV3OatUAQxyss+/3nbdTuIOm3xw7UFyFFS2/Hr76hhH+zzuWJznGadmJONGzhryUN
	 ovM7JvETFm4rVBzn5pyydXpANWdzTcA==
X-KPN-MID: 33|19VPXMto9QkPKYl6+jpgM7bzP6+xdkOrd36QMApV0jESrOYX4vepQFlQbE3eqh3
 va2d9cCTSJsNsgBXXbwI3vJHHk6TVQqrpbzIRt3Vps2I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|aeWtTqRTO1vN/JWMaR/qQPH5O3Xl6yt3iQjF3r3afvEpjGaB/X1XYojnLEIESLp
 KbZnvdGlEEGxlBBgc+NYNUA==
Received: from daedalus.home (unknown [178.230.193.174])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id d4052995-698f-11f1-a77e-00505699772e;
	Tue, 16 Jun 2026 16:29:48 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: brauner@kernel.org,
	cyphar@cyphar.com,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: [PATCH v2 4/4] selftest: Add tests for useful handling of LSM denials on SCM_RIGHTS
Date: Tue, 16 Jun 2026 16:30:04 +0200
Message-ID: <20260616143020.3458085-4-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616143020.3458085-1-jkoolstra@xs4all.nl>
References: <20260616143020.3458085-1-jkoolstra@xs4all.nl>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-299877-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:shuah@kernel.org,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-fsdevel@vger.kernel.org,m:jkoolstra@xs4all.nl,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid,xs4all.nl:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C298690858

Tests SCM_RIGHTS fd passing on a socket with the new socket option
SO_RIGHTS_NOTRUNC turned on.

The test uses the following Smack labels:

   "Sender"   - label for the sending process
   "Receiver" - label for the receiving process
   "SecretX"   - labels for the files being passed

Socket communication (Sender <-> Receiver) is always allowed.
The tests control whether Receiver can access "SecretX"-labeled fds.
When the LSM blocks an fd, we should see a sentinel that corresponds to
the error returned by the LSM, such as -EACCES.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 tools/testing/selftests/Makefile              |   1 +
 .../net/af_unix/scm_rights_denial/.gitignore  |   2 +
 .../net/af_unix/scm_rights_denial/Makefile    |  13 ++
 .../net/af_unix/scm_rights_denial/helper.h    |  38 ++++
 .../net/af_unix/scm_rights_denial/receiver.c  | 195 ++++++++++++++++++
 .../scm_rights_denial/scm_rights_denial.sh    | 171 +++++++++++++++
 .../net/af_unix/scm_rights_denial/sender.c    | 126 +++++++++++
 7 files changed, 546 insertions(+)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial/.gitignore
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial/Makefile
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial/helper.h
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial/receiver.c
 create mode 100755 tools/testing/selftests/net/af_unix/scm_rights_denial/scm_rights_denial.sh
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial/sender.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8d4db2241cc2..7ff876692267 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -74,6 +74,7 @@ TARGETS += mseal_system_mappings
 TARGETS += nci
 TARGETS += net
 TARGETS += net/af_unix
+TARGETS += net/af_unix/scm_rights_denial
 TARGETS += net/can
 TARGETS += net/forwarding
 TARGETS += net/hsr
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial/.gitignore b/tools/testing/selftests/net/af_unix/scm_rights_denial/.gitignore
new file mode 100644
index 000000000000..5a1c58ff005f
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial/.gitignore
@@ -0,0 +1,2 @@
+sender
+receiver
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial/Makefile b/tools/testing/selftests/net/af_unix/scm_rights_denial/Makefile
new file mode 100644
index 000000000000..03eb6d1427d7
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+top_srcdir := ../../../../../..
+include $(top_srcdir)/scripts/Makefile.compiler
+
+cc-option = $(call __cc-option, $(CC),,$(1),$(2))
+
+CFLAGS += $(KHDR_INCLUDES) -Wall $(call cc-option,-Wflex-array-member-not-at-end)
+
+TEST_PROGS := scm_rights_denial.sh
+
+TEST_GEN_FILES := sender receiver
+
+include ../../../lib.mk
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial/helper.h b/tools/testing/selftests/net/af_unix/scm_rights_denial/helper.h
new file mode 100644
index 000000000000..2ecdf2b8b973
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial/helper.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
+#include <fcntl.h>
+
+#ifndef SO_RIGHTS_NOTRUNC
+#define SO_RIGHTS_NOTRUNC 85
+#endif
+
+#define CMSG_IS_SCM_RIGHTS(cmsg) ({		\
+	typeof(cmsg) _cmsg = (cmsg);		\
+	_cmsg &&				\
+	_cmsg->cmsg_level == SOL_SOCKET &&	\
+	_cmsg->cmsg_type == SCM_RIGHTS;		\
+})
+
+#define MIN(a, b) ({ \
+	typeof(a) _a = (a); \
+	typeof(b) _b = (b); \
+	_a < _b ? _a : _b; \
+})
+
+#define MAX_FDS 10
+
+static inline int read_current_label(char *label, size_t size)
+{
+	int fd = open("/proc/self/attr/current", O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	ssize_t r = read(fd, label, size - 1);
+	close(fd);
+	if (r < 0)
+		return r;
+
+	label[r] = '\0';
+
+	return 0;
+}
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial/receiver.c b/tools/testing/selftests/net/af_unix/scm_rights_denial/receiver.c
new file mode 100644
index 000000000000..a9bd49a6e214
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial/receiver.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * receiver.c - Receive a file descriptor over a Unix domain socket via SCM_RIGHTS
+ *
+ * Usage: ./receiver <socket_path>
+ *
+ * Listens on the given Unix socket path, accepts a connection, and
+ * attempts to receive file descriptors via SCM_RIGHTS. Reports
+ * whether the fds were delivered or blocked.
+ *
+ * Used for testing LSM (Smack) blocking of fd passing.
+ */
+
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <sys/xattr.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+
+#include "helper.h"
+
+#define RECV_LOG(fmt, ...) printf("receiver: " fmt, ##__VA_ARGS__)
+#define RECV_ERR(fmt, ...) fprintf(stderr, "receiver: " fmt, ##__VA_ARGS__)
+
+static int recv_fds(int sock, int *fds)
+{
+	char buf[1];
+	char ctrl[CMSG_SPACE(MAX_FDS * sizeof(int))];
+
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len  = sizeof(buf),
+	};
+	struct msghdr msg = {
+		.msg_iov        = &iov,
+		.msg_iovlen     = 1,
+		.msg_control    = ctrl,
+		.msg_controllen = sizeof(ctrl),
+	};
+
+	ssize_t bytes_read = recvmsg(sock, &msg, 0);
+	if (bytes_read < 0) {
+		perror("receiver: recvmsg");
+		return -1;
+	}
+	if (bytes_read == 0) {
+		RECV_ERR("connection closed, no data received\n");
+		return -1;
+	}
+
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+	if (!CMSG_IS_SCM_RIGHTS(cmsg)) {
+		RECV_ERR("no SCM_RIGHTS in control message\n");
+		return -1;
+	}
+
+	int num_fd_slots = (cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
+	memcpy(fds, CMSG_DATA(cmsg), num_fd_slots  * sizeof(int));
+
+	RECV_LOG("got %d fd slot(s):", num_fd_slots);
+	for (int i = 0; i < num_fd_slots ; i++) {
+		if (fds[i] < 0)
+			printf(" %s", strerrorname_np(-fds[i]));
+		else
+			printf(" %d", fds[i]);
+	}
+	putchar('\n');
+
+	return num_fd_slots;
+}
+
+static inline int print_current_label(void)
+{
+	char label[256];
+	if (!read_current_label(label, sizeof(label))) {
+		RECV_LOG("running with Smack label '%s'\n", label);
+		return 0;
+	}
+	return -1;
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s <socket_path>\n", argv[0]);
+		return -1;
+	}
+
+	if (print_current_label()) {
+		RECV_ERR("cannot read process Smack label");
+		return -1;
+	}
+
+	int listen_sock = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (listen_sock < 0) {
+		perror("receiver: socket");
+		return -1;
+	}
+
+	struct sockaddr_un addr = {};
+	addr.sun_family = AF_UNIX;
+	strncpy(addr.sun_path, argv[1], sizeof(addr.sun_path) - 1);
+
+	/* Remove any stale socket file */
+	unlink(argv[1]);
+
+	if (bind(listen_sock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		perror("receiver: bind");
+		return -1;
+	}
+
+	if (listen(listen_sock, 1) < 0) {
+		perror("receiver: listen");
+		return -1;
+	}
+
+	RECV_LOG("listening on '%s'\n", argv[1]);
+
+	int conn_sock = accept(listen_sock, NULL, NULL);
+	if (conn_sock < 0) {
+		perror("receiver: accept");
+		return -1;
+	}
+
+	RECV_LOG("connection accepted\n");
+
+	int one = 1;
+	if (setsockopt(conn_sock, SOL_SOCKET, SO_RIGHTS_NOTRUNC,
+		       &one, sizeof(one)) < 0) {
+		perror("receiver: setsockopt(SO_RIGHTS_NOTRUNC)");
+		goto out_sock;
+	}
+
+	/* Try to receive the fds */
+	int fds[MAX_FDS];
+	int num_fds = recv_fds(conn_sock, fds);
+	if (num_fds < 0)
+		goto out_sock;
+
+	/* Try to use the received fds -- read and print their contents */
+	RECV_LOG("attempting to read from received fds...\n");
+	int i;
+	for (i = 0; i < num_fds; ++i) {
+		char readbuf[256];
+
+		if (fds[i] < 0) {
+			RECV_LOG("fd in position %i blocked\n", i);
+			continue;
+		} else if (fds[i] == 0) {
+			RECV_LOG("bad fd in position %i\n", i);
+			goto out_recv;
+		}
+
+		ssize_t n = read(fds[i], readbuf, sizeof(readbuf) - 1);
+		if (n < 0) {
+			perror("receiver: read from received fd");
+			goto out_recv;
+		}
+
+		readbuf[n] = '\0';
+		RECV_LOG("read %zd bytes from fd at position %i: '%s'\n", n, i, readbuf);
+	}
+
+	RECV_LOG("final result:\n");
+	for (int j = 0; j < num_fds; ++j) {
+		if (fds[j] < 0) {
+			printf("BLOCKED");
+		} else {
+			printf("PASSED");
+			close(fds[j]);
+		}
+		putchar(' ');
+	}
+
+	close(conn_sock);
+	close(listen_sock);
+	unlink(argv[1]);
+	return 0;
+
+out_recv:
+	for (int j = 0; j < num_fds; ++j) {
+		if (fds[j] > 0)
+			close(fds[j]);
+	}
+
+out_sock:
+	close(conn_sock);
+	close(listen_sock);
+	unlink(argv[1]);
+	return -1;
+}
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial/scm_rights_denial.sh b/tools/testing/selftests/net/af_unix/scm_rights_denial/scm_rights_denial.sh
new file mode 100755
index 000000000000..9d7d4530cadd
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial/scm_rights_denial.sh
@@ -0,0 +1,171 @@
+# SPDX-License-Identifier: GPL-2.0
+
+#
+# test_scm_rights_smack.sh - Test SCM_RIGHTS fd passing using Smack LSM blocking
+#
+# Must be run as root on a kernel with Smack enabled (security=smack).
+# Requires: capsh (libcap), setfattr/getfattr (attr)
+#
+# We use the following Smack labels:
+#   "Sender"   - label for the sending process
+#   "Receiver" - label for the receiving process
+#   "SecretX"   - labels for the files being passed
+#
+# Socket communication (Sender <-> Receiver) is always allowed.
+# The tests control whether Receiver can access "SecretX"-labeled fds.
+#
+
+set -e
+
+readonly SENDER="./sender"
+readonly RECEIVER="./receiver"
+
+readonly TESTDIR="$(mktemp -d)"
+readonly SOCK="$TESTDIR/scm_test.sock"
+readonly TESTFILE1="$TESTDIR/secret_1"
+readonly TESTFILE2="$TESTDIR/secret_2"
+
+trap 'rm -rf "$TESTDIR"' EXIT
+
+run_tests() {
+
+	preflight
+	setup
+
+	run_test "TEST 1" \
+		"Receiver should NOT have access to Secret1." \
+		"Receiver Secret1 ---
+Receiver Secret2 ---" \
+		"$TESTFILE1" \
+		"BLOCKED"
+
+	run_test "TEST 2" \
+		"Receiver should have access to Secret1." \
+		"Receiver Secret1 r--
+Receiver Secret2 ---" \
+		"$TESTFILE1" \
+		"PASSED"
+
+	run_test "TEST 3" \
+		"Receiver should have access to Secret2, but NOT Secret1." \
+		"Receiver Secret1 ---
+Receiver Secret2 r--" \
+		"$TESTFILE1 $TESTFILE2" \
+		"BLOCKED PASSED"
+}
+
+run_test() {
+	local name="$1"
+	local description="$2"
+	local rules="$3"
+	local files="$4"
+	local expected="$5"
+
+	echo ""
+	echo "$name: $description"
+	echo "Rules:"
+	echo "$rules"
+	echo "Expected: $expected"
+	echo ""
+
+	while IFS= read -r rule; do
+		[ -n "$rule" ] && echo "$rule" > /sys/fs/smackfs/load2
+	done <<< "$rules"
+
+	local output status last_line
+	output=$(send_fds "$SOCK" $files)
+	status=$?
+	echo "$output"
+	last_line=$(echo "$output" | tail -n 1 | xargs)
+
+	if [ "$status" -ne 0 ]; then
+		echo "TEST FAILED: receiver returned $status"
+		return 1
+	fi
+
+	if [[ "$last_line" == "$expected" ]]; then
+		echo "TEST PASSED: outcome was $expected as expected"
+		return 0
+	else
+		echo "TEST FAILED: expected $expected, got '$last_line'"
+		return 1
+	fi
+}
+
+setup() {
+
+	printf "Secret 1" > "$TESTFILE1"
+	printf "Secret 2" > "$TESTFILE2"
+
+	setfattr -n security.SMACK64 -v "Secret1" "$TESTFILE1"
+	setfattr -n security.SMACK64 -v "Secret2" "$TESTFILE2"
+	setfattr -n security.SMACK64 -v "Tmp" /tmp
+	setfattr -n security.SMACK64 -v "Tmp" "$TESTDIR"
+
+	echo "Sender	Receiver	-w-" > /sys/fs/smackfs/load2
+	echo "Receiver	Sender		-w-" > /sys/fs/smackfs/load2
+	echo "Sender	Tmp 		rwx" > /sys/fs/smackfs/load2
+	echo "Receiver	Tmp		rwx" > /sys/fs/smackfs/load2
+	echo "Sender	Secret1		r--" > /sys/fs/smackfs/load2
+	echo "Sender	Secret2		r--" > /sys/fs/smackfs/load2
+}
+
+send_fds() {
+
+	local sk="$1"
+	shift
+	local files="$*"
+
+	(
+	    echo "Receiver" > /proc/self/attr/current
+	    exec capsh --drop=cap_mac_override,cap_mac_admin -- -c "$RECEIVER $sk"
+	) &
+	local recv_pid=$!
+	sleep 1
+
+	(
+	    echo "Sender" > /proc/self/attr/current
+	    exec capsh --drop=cap_mac_override,cap_mac_admin -- -c "$SENDER $sk $files"
+	) || true
+
+	local recv_status=0
+	wait "$recv_pid" || recv_status=$?
+
+	if [ "$recv_status" -ne 0 ]; then
+	    echo "receiver exited with $recv_status"
+	fi
+	return "$recv_status"
+}
+
+preflight() {
+
+	if [ "$(id -u)" -ne 0 ]; then
+	    echo "ERROR: must be run as root"
+	    exit 1
+	fi
+
+	if ! grep -q smack /sys/kernel/security/lsm 2>/dev/null; then
+	    echo "ERROR: Smack is not active"
+	    echo "  Check: cat /sys/kernel/security/lsm"
+	    echo "  Boot with: security=smack"
+	    exit 1
+	fi
+
+	if ! mountpoint -q /sys/fs/smackfs 2>/dev/null; then
+	    echo "Mounting smackfs..."
+	    mount -t smackfs smackfs /sys/fs/smackfs
+	fi
+
+	if ! command -v capsh &>/dev/null; then
+	    echo "ERROR: capsh not found (install libcap)"
+	    exit 1
+	fi
+
+	if [ ! -x "$SENDER" ] || [ ! -x "$RECEIVER" ]; then
+	    echo "ERROR: $SENDER / $RECEIVER not built (run 'make' first)"
+	    exit 1
+	fi
+
+}
+
+run_tests
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial/sender.c b/tools/testing/selftests/net/af_unix/scm_rights_denial/sender.c
new file mode 100644
index 000000000000..b1c76d23b8bd
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial/sender.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * sender.c - Send file descriptors over a Unix domain socket via SCM_RIGHTS
+ *
+ * Usage: ./sender <socket_path> <file_to_send> [<file_to_send>...]
+ *
+ * Opens the specified files and sends their fds to a receiver connected
+ * on the given Unix socket path. Used for testing LSM blocking of fd
+ * passing.
+ */
+
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdio.h>
+#include <fcntl.h>
+
+#include "helper.h"
+
+#define SEND_LOG(fmt, ...) fprintf(stdout, "sender: " fmt, ##__VA_ARGS__)
+#define SEND_ERR(fmt, ...) fprintf(stderr, "sender: " fmt, ##__VA_ARGS__)
+
+static int send_fds(int sock, int *fds, int num_fds)
+{
+	if (num_fds > MAX_FDS)
+		return -1;
+
+	char buf[1] = { 'X' };
+	char ctrl[CMSG_SPACE(MAX_FDS * sizeof(int))] = { 0 };
+
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len  = sizeof(buf),
+	};
+	struct msghdr msg = {
+		.msg_iov        = &iov,
+		.msg_iovlen     = 1,
+		.msg_control    = ctrl,
+		.msg_controllen = CMSG_SPACE(num_fds * sizeof(int)),
+	};
+
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type  = SCM_RIGHTS;
+	cmsg->cmsg_len   = CMSG_LEN(num_fds * sizeof(int));
+	memcpy(CMSG_DATA(cmsg), fds, num_fds * sizeof(int));
+
+	ssize_t bytes_send = sendmsg(sock, &msg, 0);
+	if (bytes_send < 0) {
+		perror("sender: sendmsg");
+		return -1;
+	}
+
+	return 0;
+}
+
+static inline int print_current_label(void)
+{
+	char label[256];
+	if (!read_current_label(label, sizeof(label))) {
+		SEND_LOG("running with Smack label '%s'\n", label);
+		return 0;
+	}
+	return -1;
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc < 3 || argc > 2 + MAX_FDS) {
+		fprintf(stderr, "Usage: %s <socket_path> <file_to_send> [<file_to_send>...]\\n",
+			argv[0]);
+		fprintf(stderr, "Up to a maximum of %d files", MAX_FDS);
+		return -1;
+	}
+
+	if (print_current_label()) {
+		SEND_ERR("cannot read process Smack label");
+		return -1;
+	}
+
+	int sock = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (sock < 0) {
+		perror("sender: socket");
+		return -1;
+	}
+
+	struct sockaddr_un addr = {};
+	addr.sun_family = AF_UNIX;
+	strncpy(addr.sun_path, argv[1], sizeof(addr.sun_path) - 1);
+
+	if (connect(sock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		perror("sender: connect");
+		goto out_sock;
+	}
+
+	SEND_LOG("connected to '%s'\n", argv[1]);
+
+	int num_files = argc - 2;
+	int fds[MAX_FDS];
+	int i;
+	for (i = 0; i < num_files; i++) {
+		fds[i] = open(argv[2 + i], O_RDONLY);
+		if (fds[i] < 0) {
+			perror("sender: open file");
+			goto out_opened;
+		}
+		SEND_LOG("opened '%s' as fd %d\n", argv[2 + i], fds[i]);
+	}
+
+	if (send_fds(sock, fds, num_files) < 0)
+		goto out_opened;
+
+	SEND_LOG("fds successfully sent:");
+	for (int j = 0; j < num_files; j++)
+		printf(" %d", fds[j]);
+	putchar('\n');
+
+out_opened:
+	for (int j = 0; j < i; j++)
+		close(fds[j]);
+out_sock:
+	close(sock);
+	return -1;
+}
-- 
2.54.0


