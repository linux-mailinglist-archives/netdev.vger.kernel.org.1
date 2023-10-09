Return-Path: <netdev+bounces-39266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB197BE93B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7331C20B8B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01CE3AC31;
	Mon,  9 Oct 2023 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/RTM4dz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172EA38BBD
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 18:28:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7549C9C
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696876091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTQXYJd8i3E7CzEfytGs5GOKAgtU9bg1Astb3Kifl9o=;
	b=B/RTM4dziSEtFgM+pf9Y7DBx3DqaY8rScpefUOpZIPs38sDCKKsCu7ujfJUov/QeSk9oKG
	e81Be4/eDNWSQaiR5hrjUskz5SOANAuZg8WAPhAjZVT/2EaprbRNC0oHE8H4EIGGGBfRL1
	pxXN2ZQUi797mRSXMJT7dNsxjjfaxQQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-GYV4EpolP1-mXu8iW8vWtw-1; Mon, 09 Oct 2023 14:28:00 -0400
X-MC-Unique: GYV4EpolP1-mXu8iW8vWtw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-59e8ebc0376so72488587b3.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 11:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876080; x=1697480880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTQXYJd8i3E7CzEfytGs5GOKAgtU9bg1Astb3Kifl9o=;
        b=TGmlCZHMKIxpXVc5BWUD2KtsgVjoQ6qQ+sVI+o217rMbtGkQjmVEgbU3UvmL2/uREr
         uGQN4UOLOD9F7mdlakt77HE7bhTbLht77BDa4nG6wP6+ZbSuLBgiVFPHbVZAM1nX5Euu
         nvp3Gx4dLEtDZxe1CJ1j+XTTpqTXLaxkb3aIVRucQWpkr3HA8Tx0wrvBC/VTiqzt+x8W
         q1v5FtTwKdV2+bj5wE5EfPFslG4SSrEXrKtVstH4cX2fof2kXOrIwGc9BTnB39eJaE4/
         9EfDfulfVI4vHCMqujX82HJuyIE1ln2IA8NCKS0qpV/7qyR61tK8xox+ZkedTkZEzkLM
         GL8w==
X-Gm-Message-State: AOJu0Yz1LXOKS/e/1qczbJ2Wi4qVearXUG5fcFFUHsaEIkW2Bz0nEe4W
	sxQ2Q/0X2F2WnnTzqgUf2VJ+usEkzLTpAl4cRLH4lOA9BbyBVZ9642KXU4KtrKLj86sDMh60+8F
	IhIaw2PLRbRPsFN0M
X-Received: by 2002:a0d:d808:0:b0:59b:d796:2a55 with SMTP id a8-20020a0dd808000000b0059bd7962a55mr19175708ywe.1.1696876079984;
        Mon, 09 Oct 2023 11:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTNj0AbK9ekwU00cCwK6y/Lj3Gh+lW9brvWZW0cVRJ/uvWejhGnnRItros79pLhQKtpdlApA==
X-Received: by 2002:a0d:d808:0:b0:59b:d796:2a55 with SMTP id a8-20020a0dd808000000b0059bd7962a55mr19175699ywe.1.1696876079736;
        Mon, 09 Oct 2023 11:27:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id k7-20020a0dc807000000b0057736c436f1sm3789582ywd.141.2023.10.09.11.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:27:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 358F6E58211; Mon,  9 Oct 2023 20:27:57 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [RFC PATCH iproute2-next 3/5] lib/namespace: Factor out code for reuse
Date: Mon,  9 Oct 2023 20:27:51 +0200
Message-ID: <20231009182753.851551-4-toke@redhat.com>
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

Factor out the code that switches namespaces and the code that sets up a new
mount namespace into utility functions that can be reused when we add mount
namespace pinning.

No functional change is intended with this patch.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/namespace.h |  1 +
 lib/namespace.c     | 73 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/include/namespace.h b/include/namespace.h
index e47f9b5d49d1..b694a12e8397 100644
--- a/include/namespace.h
+++ b/include/namespace.h
@@ -49,6 +49,7 @@ static inline int setns(int fd, int nstype)
 }
 #endif /* HAVE_SETNS */
 
+int prepare_mountns(const char *name, bool do_unshare);
 int netns_switch(char *netns);
 int netns_get_fd(const char *netns);
 int netns_foreach(int (*func)(char *nsname, void *arg), void *arg);
diff --git a/lib/namespace.c b/lib/namespace.c
index 1202fa85f97d..5e310762f34b 100644
--- a/lib/namespace.c
+++ b/lib/namespace.c
@@ -11,6 +11,25 @@
 #include "utils.h"
 #include "namespace.h"
 
+static struct namespace_typename {
+	int		type;		/* CLONE_NEW* */
+	const char	*name;		/* <type> */
+} namespace_names[] = {
+	{ .type = CLONE_NEWNET,   .name = "network"  },
+	{ .type = CLONE_NEWNS,    .name = "mount"  },
+	{ .name = NULL }
+};
+
+static const char *ns_typename(int nstype)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(namespace_names); i++)
+		if (namespace_names[i].type == nstype)
+			return namespace_names[i].name;
+	return NULL;
+}
+
 static void bind_etc(const char *name)
 {
 	char etc_netns_path[sizeof(NETNS_ETC_DIR) + NAME_MAX];
@@ -42,30 +61,12 @@ static void bind_etc(const char *name)
 	closedir(dir);
 }
 
-int netns_switch(char *name)
+int prepare_mountns(const char *name, bool do_unshare)
 {
-	char net_path[PATH_MAX];
-	int netns;
 	unsigned long mountflags = 0;
 	struct statvfs fsstat;
 
-	snprintf(net_path, sizeof(net_path), "%s/%s", NETNS_RUN_DIR, name);
-	netns = open(net_path, O_RDONLY | O_CLOEXEC);
-	if (netns < 0) {
-		fprintf(stderr, "Cannot open network namespace \"%s\": %s\n",
-			name, strerror(errno));
-		return -1;
-	}
-
-	if (setns(netns, CLONE_NEWNET) < 0) {
-		fprintf(stderr, "setting the network namespace \"%s\" failed: %s\n",
-			name, strerror(errno));
-		close(netns);
-		return -1;
-	}
-	close(netns);
-
-	if (unshare(CLONE_NEWNS) < 0) {
+	if (do_unshare && unshare(CLONE_NEWNS) < 0) {
 		fprintf(stderr, "unshare failed: %s\n", strerror(errno));
 		return -1;
 	}
@@ -97,6 +98,38 @@ int netns_switch(char *name)
 	return 0;
 }
 
+static int switch_ns(const char *parent_dir, const char *name, int nstype)
+{
+	char ns_path[PATH_MAX];
+	int ns_fd;
+
+	snprintf(ns_path, sizeof(ns_path), "%s/%s", parent_dir, name);
+	ns_fd = open(ns_path, O_RDONLY | O_CLOEXEC);
+	if (ns_fd < 0) {
+		fprintf(stderr, "Cannot open %s namespace \"%s\": %s\n",
+			ns_typename(nstype), name, strerror(errno));
+		return -1;
+	}
+
+	if (setns(ns_fd, nstype) < 0) {
+		fprintf(stderr, "setting the %s namespace \"%s\" failed: %s\n",
+			ns_typename(nstype), name, strerror(errno));
+		close(ns_fd);
+		return -1;
+	}
+	close(ns_fd);
+	return 0;
+}
+
+int netns_switch(char *name)
+{
+
+	if (switch_ns(NETNS_RUN_DIR, name, CLONE_NEWNET))
+		return -1;
+
+	return prepare_mountns(name, true);
+}
+
 int netns_get_fd(const char *name)
 {
 	char pathbuf[PATH_MAX];
-- 
2.42.0


