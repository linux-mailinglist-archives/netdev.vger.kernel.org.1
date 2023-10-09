Return-Path: <netdev+bounces-39264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EDF7BE939
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A3028202B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D2A3B782;
	Mon,  9 Oct 2023 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSTsbPgW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EBF3AC23
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 18:28:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FF1B7
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696876082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9XW6ph3BbRHoQ33LKECupveYptvcVRGWd/vaH0q3ZA=;
	b=RSTsbPgWnxyDVpQbY5QOLedRBplCNMnt4oknu3Jir8KgyLHMA1MAxAaPj6Zl70FNVpvzFT
	NBIMGQT/wxM0fKwbeE2Ie0G5Sc/MU0/8h74+vUUrK4jX83Bsig47xJPgZ3Yc5asOPWWD28
	3djaeVb/BwEWG079nhB8sogtv4/ZAec=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-KRMEigrRNaybd73ZkOgfHg-1; Mon, 09 Oct 2023 14:28:01 -0400
X-MC-Unique: KRMEigrRNaybd73ZkOgfHg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5a22029070bso72680297b3.3
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 11:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876080; x=1697480880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9XW6ph3BbRHoQ33LKECupveYptvcVRGWd/vaH0q3ZA=;
        b=KVII2YdsDsjECG9sF/UZFhjZb1jYpPQBM9JV0k9iAVpzJKW5qpCzNxOidvY6nUmbl9
         nbCuqpp300pB6J2WHg/dngQYRaf8bba+FZXJZRSBSf+g9qu1H8dWzi8MOfgvmF06r/H8
         2jNzN/XsQAEYXg+ST6lb+uiupHjgvVN1oDOsUmvJMvHm5KSemImVH64DkZAYfiEO8J84
         0pFzO0ZD30WemxEUNKYGTfOxcdz002iNLUETF1u8GLQT9XEVnBf3jtpo1hUGoJFMf6ww
         nh3VY3aUCc/cCYKuMcxFiGyYZCci+98zHQcVlU8axVckvfWWoxGloi2OzXS65SQlB3cN
         fUtA==
X-Gm-Message-State: AOJu0YxXYWTm37n0iNYtZme23SlAtEgUB2A60ETN9L6LsLKy043NKspz
	c26RVL8BNB87dG5QFeGl4X+u1iCqoFZE0mmz6O+IQoZWCPNBBga0S8V1PViPfVf9e2akp2UYjpn
	CvyaQB12j5drxDlpj
X-Received: by 2002:a0d:ca4f:0:b0:5a7:ba54:af02 with SMTP id m76-20020a0dca4f000000b005a7ba54af02mr332360ywd.38.1696876080523;
        Mon, 09 Oct 2023 11:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcxS5YpO3dKoZVXEM2VQeGCGJDZeArO2JkqF1R76gqufaKuHfOqItVYTfBjdreY/kpKBferA==
X-Received: by 2002:a0d:ca4f:0:b0:5a7:ba54:af02 with SMTP id m76-20020a0dca4f000000b005a7ba54af02mr332350ywd.38.1696876080259;
        Mon, 09 Oct 2023 11:28:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s7-20020a817707000000b005707fb5110bsm3859204ywc.58.2023.10.09.11.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:27:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2DC07E5820D; Mon,  9 Oct 2023 20:27:57 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [RFC PATCH iproute2-next 1/5] ip: Mount netns in child process instead of from inside the new namespace
Date: Mon,  9 Oct 2023 20:27:49 +0200
Message-ID: <20231009182753.851551-2-toke@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009182753.851551-1-toke@redhat.com>
References: <20231009182753.851551-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Refactor the netns creation code so that we offload the mounting of the
namespace file to a child process instead of bind mounting from inside the newly
created namespace.

This is done in preparation for also persisting a mount namespace; the mount
namespace reference cannot be bind-mounted from inside that namespace itself, so
we need to mount that from a child process anyway. The child process
approach (as well as some of the helper functions used for it) is adapted from
the code in the unshare(1) utility that is part of util-linux.

No functional change is intended with this patch.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 ip/ipnetns.c | 184 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 130 insertions(+), 54 deletions(-)

diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 9d996832aef8..a05d84514326 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
 #define _ATFILE_SOURCE
 #include <sys/file.h>
 #include <sys/types.h>
@@ -7,6 +8,7 @@
 #include <sys/inotify.h>
 #include <sys/mount.h>
 #include <sys/syscall.h>
+#include <sys/eventfd.h>
 #include <stdio.h>
 #include <string.h>
 #include <sched.h>
@@ -25,6 +27,9 @@
 #include "namespace.h"
 #include "json_print.h"
 
+/* synchronize parent and child by pipe */
+#define PIPE_SYNC_BYTE	0x06
+
 static int usage(void)
 {
 	fprintf(stderr,
@@ -46,7 +51,6 @@ static int usage(void)
 static struct rtnl_handle rtnsh = { .fd = -1 };
 
 static int have_rtnl_getnsid = -1;
-static int saved_netns = -1;
 static struct link_filter filter;
 
 static int ipnetns_accept_msg(struct rtnl_ctrl_data *ctrl,
@@ -768,31 +772,131 @@ static int create_netns_dir(void)
 	return 0;
 }
 
-/* Obtain a FD for the current namespace, so we can reenter it later */
-static void netns_save(void)
+/**
+ * waitchild() - Wait for a process to exit successfully
+ * @pid: PID of the process to wait for
+ *
+ * Wait for a process to exit successfully and return its exit status.
+ */
+static int waitchild(int pid)
 {
-	if (saved_netns != -1)
-		return;
+	int rc, status;
+
+	do {
+		rc = waitpid(pid, &status, 0);
+		if (rc < 0) {
+			if (errno == EINTR)
+				continue;
+			return -errno;
+		}
+		if (WIFEXITED(status) &&
+		    WEXITSTATUS(status) != EXIT_SUCCESS)
+			return WEXITSTATUS(status);
+	} while (rc < 0);
 
-	saved_netns = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
-	if (saved_netns == -1) {
-		perror("Cannot open init namespace");
-		exit(1);
+	return 0;
+}
+
+/**
+ * sync_with_child() - Tell our child we're ready and wait for it to exit
+ * @pid: The pid of our child
+ * @fd: A file descriptor created with eventfd()
+ *
+ * This tells a child created with fork_and_wait() that we are ready for it to
+ * continue. Once we have done that, wait for our child to exit.
+ */
+static int sync_with_child(pid_t pid, int fd)
+{
+	uint64_t ch = PIPE_SYNC_BYTE;
+
+	write(fd, &ch, sizeof(ch));
+	close(fd);
+
+	return waitchild(pid);
+}
+
+/**
+ * fork_and_wait() - Fork and wait to be sync'd with
+ * @fd - A file descriptor created with eventfd() which should be passed to
+ *       sync_with_child()
+ *
+ * This creates an eventfd and forks. The parent process returns immediately,
+ * but the child waits for a %PIPE_SYNC_BYTE on the eventfd before returning.
+ * This allows the parent to perform some tasks before the child starts its
+ * work. The parent should call sync_with_child() once it is ready for the
+ * child to continue.
+ *
+ * Return: The pid from fork()
+ */
+static pid_t fork_and_wait(int *fd)
+{
+	uint64_t ch;
+	pid_t pid;
+
+	*fd = eventfd(0, 0);
+	if (*fd < 0) {
+		fprintf(stderr, "eventfd failed: %s\n", strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		fprintf(stderr, "fork failed: %s\n", strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	if (!pid) {
+		/* wait for the our parent to tell us to continue */
+		if (read(*fd, (char *)&ch, sizeof(ch)) != sizeof(ch) ||
+		    ch != PIPE_SYNC_BYTE) {
+			fprintf(stderr, "failed to read eventfd\n");
+			exit(EXIT_FAILURE);
+		}
+		close(*fd);
 	}
+
+	return pid;
 }
 
-static void netns_restore(void)
+static int bind_ns_file(const char *parent, const char *nsfile,
+			const char *ns_name, pid_t target_pid)
 {
-	if (saved_netns == -1)
-		return;
+	char ns_path[PATH_MAX], proc_path[PATH_MAX];
+	int fd;
 
-	if (setns(saved_netns, CLONE_NEWNET)) {
-		perror("setns");
-		exit(1);
+	snprintf(ns_path, sizeof(ns_path), "%s/%s", parent, ns_name);
+	snprintf(proc_path, sizeof(proc_path), "/proc/%d/ns/%s", target_pid, nsfile);
+
+	/* Create the filesystem state */
+	fd = open(ns_path, O_RDONLY|O_CREAT|O_EXCL, 0);
+	if (fd < 0) {
+		fprintf(stderr, "Cannot create namespace file \"%s\": %s\n",
+			ns_path, strerror(errno));
+		return -1;
 	}
+	close(fd);
 
-	close(saved_netns);
-	saved_netns = -1;
+	if (mount(proc_path, ns_path, "none", MS_BIND, NULL) < 0) {
+		fprintf(stderr, "Bind %s -> %s failed: %s\n", proc_path,
+			ns_path, strerror(errno));
+		unlink(ns_path);
+		return -1;
+	}
+	return 0;
+}
+
+static pid_t bind_ns_files_from_child(const char *ns_name, pid_t target_pid,
+				      int *fd)
+{
+	pid_t child;
+
+	child = fork_and_wait(fd);
+	if (child)
+		return child;
+
+	if (bind_ns_file(NETNS_RUN_DIR, "net", ns_name, target_pid))
+		exit(EXIT_FAILURE);
+	exit(EXIT_SUCCESS);
 }
 
 static int netns_add(int argc, char **argv, bool create)
@@ -808,10 +912,9 @@ static int netns_add(int argc, char **argv, bool create)
 	 * userspace tweaks like remounting /sys, or bind mounting
 	 * a new /etc/resolv.conf can be shared between users.
 	 */
-	char netns_path[PATH_MAX], proc_path[PATH_MAX];
 	const char *name;
-	pid_t pid;
-	int fd;
+	pid_t pid, child;
+	int event_fd;
 	int lock;
 	int made_netns_run_dir_mount = 0;
 
@@ -820,6 +923,7 @@ static int netns_add(int argc, char **argv, bool create)
 			fprintf(stderr, "No netns name specified\n");
 			return -1;
 		}
+		pid = getpid();
 	} else {
 		if (argc < 2) {
 			fprintf(stderr, "No netns name and PID specified\n");
@@ -833,8 +937,6 @@ static int netns_add(int argc, char **argv, bool create)
 	}
 	name = argv[0];
 
-	snprintf(netns_path, sizeof(netns_path), "%s/%s", NETNS_RUN_DIR, name);
-
 	if (create_netns_dir())
 		return -1;
 
@@ -894,46 +996,20 @@ static int netns_add(int argc, char **argv, bool create)
 		close(lock);
 	}
 
-	/* Create the filesystem state */
-	fd = open(netns_path, O_RDONLY|O_CREAT|O_EXCL, 0);
-	if (fd < 0) {
-		fprintf(stderr, "Cannot create namespace file \"%s\": %s\n",
-			netns_path, strerror(errno));
-		return -1;
-	}
-	close(fd);
+	child = bind_ns_files_from_child(name, pid, &event_fd);
+	if (child < 0)
+		exit(EXIT_FAILURE);
 
 	if (create) {
-		netns_save();
 		if (unshare(CLONE_NEWNET) < 0) {
 			fprintf(stderr, "Failed to create a new network namespace \"%s\": %s\n",
 				name, strerror(errno));
-			goto out_delete;
+			close(event_fd);
+			exit(EXIT_FAILURE);
 		}
-
-		strcpy(proc_path, "/proc/self/ns/net");
-	} else {
-		snprintf(proc_path, sizeof(proc_path), "/proc/%d/ns/net", pid);
-	}
-
-	/* Bind the netns last so I can watch for it */
-	if (mount(proc_path, netns_path, "none", MS_BIND, NULL) < 0) {
-		fprintf(stderr, "Bind %s -> %s failed: %s\n",
-			proc_path, netns_path, strerror(errno));
-		goto out_delete;
 	}
-	netns_restore();
 
-	return 0;
-out_delete:
-	if (create) {
-		netns_restore();
-		netns_delete(argc, argv);
-	} else if (unlink(netns_path) < 0) {
-		fprintf(stderr, "Cannot remove namespace file \"%s\": %s\n",
-			netns_path, strerror(errno));
-	}
-	return -1;
+	return sync_with_child(child, event_fd);
 }
 
 int set_netnsid_from_name(const char *name, int nsid)
-- 
2.42.0


