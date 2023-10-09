Return-Path: <netdev+bounces-39263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21B47BE938
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FD51C20BD2
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D183B285;
	Mon,  9 Oct 2023 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/oKi9+X"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4C538BBD
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 18:28:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B515AC
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696876082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYH9XfkihIXpLbV+51gJXEgU/bDFdcyGZt2r9bCG9Xw=;
	b=h/oKi9+XoGJQFfO2dfPjQZ8Rv8wSRJmU6GAJfixq8hs0YLsl//bCzxUQjhc//QyfliFFfo
	sZYhUNVdN5TX66prlJ1F9xAuk1m8mFRQ/+MHmrEafPpTo4y/eW5cCxy6rIa2vuFIfLqcyM
	d2SS25+7PQfdWQqqBjbqpM129GYh3GQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-8-hY48duMq2PUlj-1UPVNA-1; Mon, 09 Oct 2023 14:28:00 -0400
X-MC-Unique: 8-hY48duMq2PUlj-1UPVNA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a234ffeb90so74081167b3.3
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 11:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876080; x=1697480880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYH9XfkihIXpLbV+51gJXEgU/bDFdcyGZt2r9bCG9Xw=;
        b=iGSqwtE46uXPsnqWkJJykROmzNrdLOi7rXE28zqxVFihmYxiU6sHBoqoXf8vHpJZeE
         yMHHSHkt0ISJqZeP7g9briHShyh0XFglWADClCQ12n7oVXISqtTmQ5ialI6qBHQLBJAs
         NEoTg1OfFSVxlzBzzm8eMhtyNGnJM6MtEVq9l/K3HhwN9Bes1SKnCX0+m3y2+xBmFgnB
         ALVPFbOoayVXFcOResmhHPUoTc32CgaOYjQhq3G1Gqu6WyFpqTlVtalFc/x1yrzuM59U
         wyeE9DJUcqFcpjTYli2UsF0nWDZ5Ly3dm8I3fyqS04cIeMb8KaYTTlPdcpZA8f45vtL3
         dvCA==
X-Gm-Message-State: AOJu0YwBrARKZWGyqThwWNlXBFRXJqNAlWIF+BPO6ijtj/9+AoAfGgEc
	7W8UvbrskN/umK9h7Rm9iEBXnoLqtuYdf0O0120WMbiRBMPgqWYMxA5HcJroKtx4cvR1jVo8jCS
	AqxpB6fsp9OapVQbq
X-Received: by 2002:a0d:d785:0:b0:56c:e70b:b741 with SMTP id z127-20020a0dd785000000b0056ce70bb741mr16834881ywd.20.1696876080349;
        Mon, 09 Oct 2023 11:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV/UNn8eKeh/Ij0IuhQsYuvVMppjrCwc8tLc+/elkrb9XecCAykABhic9iVdMNI21PIDzW2w==
X-Received: by 2002:a0d:d785:0:b0:56c:e70b:b741 with SMTP id z127-20020a0dd785000000b0056ce70bb741mr16834864ywd.20.1696876080070;
        Mon, 09 Oct 2023 11:28:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l21-20020a81ad15000000b005a20ab8a184sm109092ywh.31.2023.10.09.11.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:27:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 32404E5820F; Mon,  9 Oct 2023 20:27:57 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [RFC PATCH iproute2-next 2/5] ip: Split out code creating namespace mount dir so it can be reused
Date: Mon,  9 Oct 2023 20:27:50 +0200
Message-ID: <20231009182753.851551-3-toke@redhat.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move the code creating the parent directory for namespace references into its
own function, so it can be reused for creating a separate directory to contain
mount namespace references.

No functional change is intended with this patch.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 ip/ipnetns.c | 127 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 58 deletions(-)

diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index a05d84514326..529790482683 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -758,13 +758,13 @@ static int netns_delete(int argc, char **argv)
 	return on_netns_del(argv[0], NULL);
 }
 
-static int create_netns_dir(void)
+static int ensure_dir(const char *path)
 {
 	/* Create the base netns directory if it doesn't exist */
-	if (mkdir(NETNS_RUN_DIR, S_IRWXU|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH)) {
+	if (mkdir(path, S_IRWXU|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH)) {
 		if (errno != EEXIST) {
 			fprintf(stderr, "mkdir %s failed: %s\n",
-				NETNS_RUN_DIR, strerror(errno));
+				path, strerror(errno));
 			return -1;
 		}
 	}
@@ -899,53 +899,15 @@ static pid_t bind_ns_files_from_child(const char *ns_name, pid_t target_pid,
 	exit(EXIT_SUCCESS);
 }
 
-static int netns_add(int argc, char **argv, bool create)
+static int prepare_ns_mount_dir(const char *target_dir, int mount_flag)
 {
-	/* This function creates a new network namespace and
-	 * a new mount namespace and bind them into a well known
-	 * location in the filesystem based on the name provided.
-	 *
-	 * If create is true, a new namespace will be created,
-	 * otherwise an existing one will be attached to the file.
-	 *
-	 * The mount namespace is created so that any necessary
-	 * userspace tweaks like remounting /sys, or bind mounting
-	 * a new /etc/resolv.conf can be shared between users.
-	 */
-	const char *name;
-	pid_t pid, child;
-	int event_fd;
+	int made_dir_mount = 0;
 	int lock;
-	int made_netns_run_dir_mount = 0;
 
-	if (create) {
-		if (argc < 1) {
-			fprintf(stderr, "No netns name specified\n");
-			return -1;
-		}
-		pid = getpid();
-	} else {
-		if (argc < 2) {
-			fprintf(stderr, "No netns name and PID specified\n");
-			return -1;
-		}
-
-		if (get_s32(&pid, argv[1], 0) || !pid) {
-			fprintf(stderr, "Invalid PID: %s\n", argv[1]);
-			return -1;
-		}
-	}
-	name = argv[0];
-
-	if (create_netns_dir())
+	if (ensure_dir(target_dir))
 		return -1;
 
-	/* Make it possible for network namespace mounts to propagate between
-	 * mount namespaces.  This makes it likely that a unmounting a network
-	 * namespace file in one namespace will unmount the network namespace
-	 * file in all namespaces allowing the network namespace to be freed
-	 * sooner.
-	 * These setup steps need to happen only once, as if multiple ip processes
+	/* These setup steps need to happen only once, as if multiple ip processes
 	 * try to attempt the same operation at the same time, the mountpoints will
 	 * be recursively created multiple times, eventually causing the system
 	 * to lock up. For example, this has been observed when multiple netns
@@ -955,23 +917,23 @@ static int netns_add(int argc, char **argv, bool create)
 	 * this cannot happen, but proceed nonetheless if it cannot happen for any
 	 * reason.
 	 */
-	lock = open(NETNS_RUN_DIR, O_RDONLY|O_DIRECTORY, 0);
+	lock = open(target_dir, O_RDONLY|O_DIRECTORY, 0);
 	if (lock < 0) {
-		fprintf(stderr, "Cannot open netns runtime directory \"%s\": %s\n",
-			NETNS_RUN_DIR, strerror(errno));
+		fprintf(stderr, "Cannot open ns runtime directory \"%s\": %s\n",
+			target_dir, strerror(errno));
 		return -1;
 	}
 	if (flock(lock, LOCK_EX) < 0) {
-		fprintf(stderr, "Warning: could not flock netns runtime directory \"%s\": %s\n",
-			NETNS_RUN_DIR, strerror(errno));
+		fprintf(stderr, "Warning: could not flock ns runtime directory \"%s\": %s\n",
+			target_dir, strerror(errno));
 		close(lock);
 		lock = -1;
 	}
-	while (mount("", NETNS_RUN_DIR, "none", MS_SHARED | MS_REC, NULL)) {
+	while (mount("", target_dir, "none", mount_flag | MS_REC, NULL)) {
 		/* Fail unless we need to make the mount point */
-		if (errno != EINVAL || made_netns_run_dir_mount) {
+		if (errno != EINVAL || made_dir_mount) {
 			fprintf(stderr, "mount --make-shared %s failed: %s\n",
-				NETNS_RUN_DIR, strerror(errno));
+				target_dir, strerror(errno));
 			if (lock != -1) {
 				flock(lock, LOCK_UN);
 				close(lock);
@@ -979,23 +941,72 @@ static int netns_add(int argc, char **argv, bool create)
 			return -1;
 		}
 
-		/* Upgrade NETNS_RUN_DIR to a mount point */
-		if (mount(NETNS_RUN_DIR, NETNS_RUN_DIR, "none", MS_BIND | MS_REC, NULL)) {
+		/* Upgrade target directory to a mount point */
+		if (mount(target_dir, target_dir, "none", MS_BIND | MS_REC, NULL)) {
 			fprintf(stderr, "mount --bind %s %s failed: %s\n",
-				NETNS_RUN_DIR, NETNS_RUN_DIR, strerror(errno));
+				target_dir, target_dir, strerror(errno));
 			if (lock != -1) {
 				flock(lock, LOCK_UN);
 				close(lock);
 			}
 			return -1;
 		}
-		made_netns_run_dir_mount = 1;
+		made_dir_mount = 1;
 	}
 	if (lock != -1) {
 		flock(lock, LOCK_UN);
 		close(lock);
 	}
 
+	return 0;
+}
+
+static int netns_add(int argc, char **argv, bool create)
+{
+	/* This function creates a new network namespace and
+	 * a new mount namespace and bind them into a well known
+	 * location in the filesystem based on the name provided.
+	 *
+	 * If create is true, a new namespace will be created,
+	 * otherwise an existing one will be attached to the file.
+	 *
+	 * The mount namespace is created so that any necessary
+	 * userspace tweaks like remounting /sys, or bind mounting
+	 * a new /etc/resolv.conf can be shared between users.
+	 */
+	const char *name;
+	pid_t pid, child;
+	int event_fd;
+
+	if (create) {
+		if (argc < 1) {
+			fprintf(stderr, "No netns name specified\n");
+			return -1;
+		}
+		pid = getpid();
+	} else {
+		if (argc < 2) {
+			fprintf(stderr, "No netns name and PID specified\n");
+			return -1;
+		}
+
+		if (get_s32(&pid, argv[1], 0) || !pid) {
+			fprintf(stderr, "Invalid PID: %s\n", argv[1]);
+			return -1;
+		}
+	}
+	name = argv[0];
+
+	/* Pass the MS_SHARED flag to the mount of the network namespace
+	 * directory to make it possible for network namespace mounts to
+	 * propagate between mount namespaces. This makes it likely that a
+	 * unmounting a network namespace file in one namespace will unmount the
+	 * network namespace file in all namespaces allowing the network
+	 * namespace to be freed sooner.
+	 */
+	if (prepare_ns_mount_dir(NETNS_RUN_DIR, MS_SHARED))
+		return -1;
+
 	child = bind_ns_files_from_child(name, pid, &event_fd);
 	if (child < 0)
 		exit(EXIT_FAILURE);
@@ -1079,7 +1090,7 @@ static int netns_monitor(int argc, char **argv)
 		return -1;
 	}
 
-	if (create_netns_dir())
+	if (ensure_dir(NETNS_RUN_DIR))
 		return -1;
 
 	if (inotify_add_watch(fd, NETNS_RUN_DIR, IN_CREATE | IN_DELETE) < 0) {
-- 
2.42.0


