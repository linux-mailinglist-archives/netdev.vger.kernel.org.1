Return-Path: <netdev+bounces-39265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EAA7BE93A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A67281DB4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395903B78A;
	Mon,  9 Oct 2023 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0KtZr6r"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389303AC2E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 18:28:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1F2B4
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696876083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orRdjx9+852xXN15Pq+UxCnXmyKpm9bkQ+d1p7lpjng=;
	b=T0KtZr6r/S0IrG/9660ELnmdzSaSGgSTAnPvd6mIlW62behyTpbQpQhDHTkJhL1ENe5QPM
	yTpoRZgX0ef2FlPpO7ZfbeuhdbplNSua7i5HpTU+LYxwr2vMx5USdBCa+/x6SPWmQk5yXf
	SDcFKrFeiFYRsti3ovSIja3C+3liul8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-aZSMa4bjPs6wyfcDQrlO3g-1; Mon, 09 Oct 2023 14:28:01 -0400
X-MC-Unique: aZSMa4bjPs6wyfcDQrlO3g-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5a7b3ae01c0so5348097b3.3
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 11:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876081; x=1697480881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orRdjx9+852xXN15Pq+UxCnXmyKpm9bkQ+d1p7lpjng=;
        b=eAYq4USABUzxAa4KSCz1ZyXxUCfr/KTzRh3f2exeS2hP1ccR1NOCoA4WcuzxukEc4R
         eJ5xUNaaIZJNP7gGhgTafU7/Ib6m9o03S/vfLcG93RtsjMXaC4Zf6feJqX5lPNkxhIfn
         mvCt+xFxRyrpmBWRfBHBcHyKXgPiq5/uIcOoHzoS2AYruXVusC2mfG4JEsF+EI86kBYd
         KXdFZCo/fox/fozAbd9GOxy57dXJHI0PA3874y+2moxbfHkhXlxy2Ysv1dfjKm9bvFxL
         /O8BjllQdHCHEfmRw2yDOcHrfBSLScX6OSXYZHLqoGigqD17wXN2tq77oEiF9hq68bca
         zRZQ==
X-Gm-Message-State: AOJu0YwedvmulS5KExMdMSnTzthyunXBMYrwWRvuyEfu3TIMqMsXB4W2
	+FcciYMiIqk4Jh13tXxngcIpzakzRsqh6G9iRc+y4Po9pURFS8+k/o7UvJJpDL/VC72h7cE6tnY
	PkVUBvaD0PWw8f5uy
X-Received: by 2002:a81:af45:0:b0:5a7:af72:ad6a with SMTP id x5-20020a81af45000000b005a7af72ad6amr1206458ywj.43.1696876080706;
        Mon, 09 Oct 2023 11:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqQkRil3E/g24y0JCveVG3AFiR7tPLbgTXUf2PC6SmFpxG5LDDJCmsMZWiLrqDuZykceEHnw==
X-Received: by 2002:a81:af45:0:b0:5a7:af72:ad6a with SMTP id x5-20020a81af45000000b005a7af72ad6amr1206445ywj.43.1696876080450;
        Mon, 09 Oct 2023 11:28:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u206-20020a8147d7000000b0059b4e981fe6sm3796511ywa.102.2023.10.09.11.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:27:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 385A0E58213; Mon,  9 Oct 2023 20:27:57 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [RFC PATCH iproute2-next 4/5] ip: Also create and persist mount namespace when creating netns
Date: Mon,  9 Oct 2023 20:27:52 +0200
Message-ID: <20231009182753.851551-5-toke@redhat.com>
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

When creating a new network namespace, persist not only the network namespace
reference itself, but also create and persist a new mount namespace that is
paired with the network namespace. This means that multiple subsequent
invocations of 'ip netns exec' will reuse the same mount namespace instead of
creating a new namespace on every entry, as was the behaviour before this patch.

The persistent mount namespace has the benefit that any new mounts created
inside the namespace will persist. Most notably, this is useful when using bpffs
instances along with 'ip netns', as these were previously transient to a single
'ip netns' invocation.

To preserve backwards compatibility, when changing namespaces we will fall back
to the old behaviour of creating a new mount namespace when switching netns, if
we can't find a persisted namespace to enter. This can happen if the netns
instance was created with a previous version of iproute2 that doesn't persist
the mount namespace.

One caveat of the mount namespace persistence is that we can't make the
containing directory mount shared, the way we do with the netns mounts. This
means that if 'ip netns del' is invoked *inside* a namespace created with 'ip
netns', the mount namespace reference will not be deleted and will stick around
in the original mount namespace where it was created. This is unavoidable
because it is not possible to create a bind-mounted reference to a mount
namespace inside that same mount namespace (as that would create a circular
reference).

In such a situation, we may end up with the network namespace reference being
removed but the mount namespace reference sticking around (the same thing can
happen if 'ip netns del' is executed with an older version of iproute2). In this
situation, a subsequent 'ip netns add' with the same namespace name will end up
reusing the old mount namespace reference.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 Makefile        |  2 ++
 ip/ipnetns.c    | 64 +++++++++++++++++++++++++++++++++++++++++++------
 lib/namespace.c |  8 ++++++-
 3 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 5c559c8dc805..aeb1ddc53c6a 100644
--- a/Makefile
+++ b/Makefile
@@ -19,6 +19,7 @@ SBINDIR?=/sbin
 CONF_ETC_DIR?=/etc/iproute2
 CONF_USR_DIR?=$(LIBDIR)/iproute2
 NETNS_RUN_DIR?=/var/run/netns
+MNTNS_RUN_DIR?=/var/run/netns-mnt
 NETNS_ETC_DIR?=/etc/netns
 DATADIR?=$(PREFIX)/share
 HDRDIR?=$(PREFIX)/include/iproute2
@@ -41,6 +42,7 @@ endif
 DEFINES+=-DCONF_USR_DIR=\"$(CONF_USR_DIR)\" \
          -DCONF_ETC_DIR=\"$(CONF_ETC_DIR)\" \
          -DNETNS_RUN_DIR=\"$(NETNS_RUN_DIR)\" \
+         -DMNTNS_RUN_DIR=\"$(MNTNS_RUN_DIR)\" \
          -DNETNS_ETC_DIR=\"$(NETNS_ETC_DIR)\" \
          -DCONF_COLOR=$(CONF_COLOR)
 
diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 529790482683..551819577755 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -733,13 +733,24 @@ static int netns_identify(int argc, char **argv)
 
 static int on_netns_del(char *nsname, void *arg)
 {
-	char netns_path[PATH_MAX];
+	char ns_path[PATH_MAX];
+	struct stat st;
+
+	snprintf(ns_path, sizeof(ns_path), "%s/%s", MNTNS_RUN_DIR, nsname);
+	if (!stat(ns_path, &st)) { /* may not exist if created by old iproute2 */
+		umount2(ns_path, MNT_DETACH);
+		if (unlink(ns_path) < 0) {
+			fprintf(stderr, "Cannot remove namespace file \"%s\": %s\n",
+				ns_path, strerror(errno));
+			return -1;
+		}
+	}
 
-	snprintf(netns_path, sizeof(netns_path), "%s/%s", NETNS_RUN_DIR, nsname);
-	umount2(netns_path, MNT_DETACH);
-	if (unlink(netns_path) < 0) {
+	snprintf(ns_path, sizeof(ns_path), "%s/%s", NETNS_RUN_DIR, nsname);
+	umount2(ns_path, MNT_DETACH);
+	if (unlink(ns_path) < 0) {
 		fprintf(stderr, "Cannot remove namespace file \"%s\": %s\n",
-			netns_path, strerror(errno));
+			ns_path, strerror(errno));
 		return -1;
 	}
 	return 0;
@@ -885,17 +896,46 @@ static int bind_ns_file(const char *parent, const char *nsfile,
 	return 0;
 }
 
+static ino_t get_mnt_ino(pid_t pid)
+{
+	char path[PATH_MAX];
+	struct stat st;
+
+	snprintf(path, sizeof(path), "/proc/%u/ns/mnt", (unsigned) pid);
+
+	if (stat(path, &st) != 0) {
+		fprintf(stderr, "stat of %s failed: %s\n",
+			path, strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+	return st.st_ino;
+}
+
 static pid_t bind_ns_files_from_child(const char *ns_name, pid_t target_pid,
 				      int *fd)
 {
+	ino_t mnt_ino;
 	pid_t child;
 
+	mnt_ino = get_mnt_ino(getpid());
+
 	child = fork_and_wait(fd);
 	if (child)
 		return child;
 
 	if (bind_ns_file(NETNS_RUN_DIR, "net", ns_name, target_pid))
 		exit(EXIT_FAILURE);
+
+	/* We can only bind the mount namespace reference if the target pid is
+	 * actually in a different mount namespace than ourselves. We ignore any
+	 * errors in creating the mount namespace reference because an old
+	 * namespace mount may be present if a network namespace with the same
+	 * name was previously removed by an older version of iproute2; in this
+	 * case that old reference will just be reused.
+	 */
+	if (mnt_ino != get_mnt_ino(target_pid))
+		bind_ns_file(MNTNS_RUN_DIR, "mnt", ns_name, target_pid);
+
 	exit(EXIT_SUCCESS);
 }
 
@@ -1003,8 +1043,13 @@ static int netns_add(int argc, char **argv, bool create)
 	 * unmounting a network namespace file in one namespace will unmount the
 	 * network namespace file in all namespaces allowing the network
 	 * namespace to be freed sooner.
+	 *
+	 * The mount namespace directory cannot be shared because it's not
+	 * possible to mount references to a mount namespace inside that
+	 * namespace itself.
 	 */
-	if (prepare_ns_mount_dir(NETNS_RUN_DIR, MS_SHARED))
+	if (prepare_ns_mount_dir(NETNS_RUN_DIR, MS_SHARED) ||
+	    prepare_ns_mount_dir(MNTNS_RUN_DIR, MS_SLAVE))
 		return -1;
 
 	child = bind_ns_files_from_child(name, pid, &event_fd);
@@ -1012,12 +1057,17 @@ static int netns_add(int argc, char **argv, bool create)
 		exit(EXIT_FAILURE);
 
 	if (create) {
-		if (unshare(CLONE_NEWNET) < 0) {
+		if (unshare(CLONE_NEWNET | CLONE_NEWNS) < 0) {
 			fprintf(stderr, "Failed to create a new network namespace \"%s\": %s\n",
 				name, strerror(errno));
 			close(event_fd);
 			exit(EXIT_FAILURE);
 		}
+
+		if (prepare_mountns(name, false)) {
+			close(event_fd);
+			exit(EXIT_FAILURE);
+		}
 	}
 
 	return sync_with_child(child, event_fd);
diff --git a/lib/namespace.c b/lib/namespace.c
index 5e310762f34b..5f2449fb0003 100644
--- a/lib/namespace.c
+++ b/lib/namespace.c
@@ -127,7 +127,13 @@ int netns_switch(char *name)
 	if (switch_ns(NETNS_RUN_DIR, name, CLONE_NEWNET))
 		return -1;
 
-	return prepare_mountns(name, true);
+	/* Try to enter an existing persisted mount namespace. If this fails,
+	 * preserve the old behaviour of creating a new namespace on entry.
+	 */
+	if (switch_ns(MNTNS_RUN_DIR, name, CLONE_NEWNS))
+		return prepare_mountns(name, true);
+
+	return 0;
 }
 
 int netns_get_fd(const char *name)
-- 
2.42.0


