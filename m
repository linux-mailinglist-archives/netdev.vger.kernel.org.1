Return-Path: <netdev+bounces-46370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BBF7E364B
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC921C20B6E
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67903FC1D;
	Tue,  7 Nov 2023 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O7Q5dbNY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD54D30A
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:06:13 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A492BE8
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:06:11 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso9174874a12.3
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 00:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699344370; x=1699949170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFfpucdTMFOCUhrnRBpfZGlldmu79VgbOj+QIwjR2pA=;
        b=O7Q5dbNYderP6+b0qcHXB7UTBEl2t1G8F86SNiOmgYJ7ZIo8BHikpPuNGsoM3OuBhX
         Bla3hg59FT73uiNwkM8OjhIbyOwcrs8izP3CuiVlHIzR0dpWfcA+zv3KTqHxLk75oV4W
         9o+MNy9z6JNtfSD3jQ+S8KzSkmq0e8v04etMRxoIs8ym2PZET6CtkiMxUGyXA0k59N/d
         bybqe9uvLkjOTTqDA4WzHTgjZ7hFXVffH+aCAQ2N9Xn5pBwHlmzM7WLYqvoFiLb6aQw8
         pD+0nIWMYIM5CiKqJGFSdTnPumk5+C7pHaNUodNc8rxRrXV/pwBxNjnnLs3ttthpbe0Y
         eE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344370; x=1699949170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFfpucdTMFOCUhrnRBpfZGlldmu79VgbOj+QIwjR2pA=;
        b=CW/2XKYQwESxZCZjSSLa23Xw6TBmSXJ9jasbHRVgkMRcJOWMffPP6jWgJtVV/HRd6d
         EchJO3GMqRQCJcEcHDjSeQo6h2xc8o1V23ASTSgXsmGJwJEpWzMQLAFGnvHSBYxIzsdo
         MzsTx2HiiXDEi4trEaDOMPZZs5ZwCSxMeGbTNosi/UNAmYFpqA5BWO7xrJJX/F80l/aG
         dx30b2jkfPjfwaVvH9ko/znGG/40xOs1z80v3HiutoUTgnI6m94sBGM2pGqmqFfWrzfr
         cq+DnnyZNjV1jq7DfydLOcCDRiyY1gCzArqJJt3YNeAucfNsqxbxivH8C6LvNvXNqyrr
         Ep9A==
X-Gm-Message-State: AOJu0YxJWIHaUMhJlPWWBHAA35dt8t5Z3Dumbnj6X1p0bAOxlsezOntE
	+GthvJYfIODZCOnjA4XVhaz7uOSc20MtQy3ohMA=
X-Google-Smtp-Source: AGHT+IEC8Vd0FU5ay8COyjfOpVTOfK1irm9ToJ2tiS2WMjEGR04VZPqiRMFUcVaAfXUXVdADRnYuOw==
X-Received: by 2002:a50:d693:0:b0:543:5b0b:8902 with SMTP id r19-20020a50d693000000b005435b0b8902mr19070175edi.24.1699344370024;
        Tue, 07 Nov 2023 00:06:10 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7d44d000000b00542df4a03d0sm5067764edr.16.2023.11.07.00.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:06:09 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v5 1/7] ip/ipnetns: move internals of get_netnsid_from_name() into namespace.c
Date: Tue,  7 Nov 2023 09:06:01 +0100
Message-ID: <20231107080607.190414-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107080607.190414-1-jiri@resnulli.us>
References: <20231107080607.190414-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In order to be able to reuse get_netnsid_from_name() function outside of
ip code, move the internals to lib/namespace.c to a new function called
netns_id_from_name().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v4->v5:
- added forgotten libnetlink.h include to silence dcb warning
v3->v4:
- removed namespace.h include
v2->v3:
- s/netns_netnsid_from_name/netns_id_from_name/
v1->v2:
- new patch
---
 include/namespace.h |  3 +++
 ip/ipnetns.c        | 45 +----------------------------------------
 lib/namespace.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/include/namespace.h b/include/namespace.h
index e47f9b5d49d1..2843f4bb5742 100644
--- a/include/namespace.h
+++ b/include/namespace.h
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <errno.h>
+#include <libnetlink.h>
 
 #ifndef NETNS_RUN_DIR
 #define NETNS_RUN_DIR "/var/run/netns"
@@ -58,4 +59,6 @@ struct netns_func {
 	void *arg;
 };
 
+int netns_id_from_name(struct rtnl_handle *rtnl, const char *name);
+
 #endif /* __NAMESPACE_H__ */
diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 9d996832aef8..0ae46a874a0c 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -105,52 +105,9 @@ static int ipnetns_have_nsid(void)
 
 int get_netnsid_from_name(const char *name)
 {
-	struct {
-		struct nlmsghdr n;
-		struct rtgenmsg g;
-		char            buf[1024];
-	} req = {
-		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct rtgenmsg)),
-		.n.nlmsg_flags = NLM_F_REQUEST,
-		.n.nlmsg_type = RTM_GETNSID,
-		.g.rtgen_family = AF_UNSPEC,
-	};
-	struct nlmsghdr *answer;
-	struct rtattr *tb[NETNSA_MAX + 1];
-	struct rtgenmsg *rthdr;
-	int len, fd, ret = -1;
-
 	netns_nsid_socket_init();
 
-	fd = netns_get_fd(name);
-	if (fd < 0)
-		return fd;
-
-	addattr32(&req.n, 1024, NETNSA_FD, fd);
-	if (rtnl_talk(&rtnsh, &req.n, &answer) < 0) {
-		close(fd);
-		return -2;
-	}
-	close(fd);
-
-	/* Validate message and parse attributes */
-	if (answer->nlmsg_type == NLMSG_ERROR)
-		goto out;
-
-	rthdr = NLMSG_DATA(answer);
-	len = answer->nlmsg_len - NLMSG_SPACE(sizeof(*rthdr));
-	if (len < 0)
-		goto out;
-
-	parse_rtattr(tb, NETNSA_MAX, NETNS_RTA(rthdr), len);
-
-	if (tb[NETNSA_NSID]) {
-		ret = rta_getattr_s32(tb[NETNSA_NSID]);
-	}
-
-out:
-	free(answer);
-	return ret;
+	return netns_id_from_name(&rtnsh, name);
 }
 
 struct nsid_cache {
diff --git a/lib/namespace.c b/lib/namespace.c
index 1202fa85f97d..f03f4bbabceb 100644
--- a/lib/namespace.c
+++ b/lib/namespace.c
@@ -7,9 +7,11 @@
 #include <fcntl.h>
 #include <dirent.h>
 #include <limits.h>
+#include <linux/net_namespace.h>
 
 #include "utils.h"
 #include "namespace.h"
+#include "libnetlink.h"
 
 static void bind_etc(const char *name)
 {
@@ -139,3 +141,50 @@ int netns_foreach(int (*func)(char *nsname, void *arg), void *arg)
 	closedir(dir);
 	return 0;
 }
+
+int netns_id_from_name(struct rtnl_handle *rtnl, const char *name)
+{
+	struct {
+		struct nlmsghdr n;
+		struct rtgenmsg g;
+		char            buf[1024];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct rtgenmsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_GETNSID,
+		.g.rtgen_family = AF_UNSPEC,
+	};
+	struct nlmsghdr *answer;
+	struct rtattr *tb[NETNSA_MAX + 1];
+	struct rtgenmsg *rthdr;
+	int len, fd, ret = -1;
+
+	fd = netns_get_fd(name);
+	if (fd < 0)
+		return fd;
+
+	addattr32(&req.n, 1024, NETNSA_FD, fd);
+	if (rtnl_talk(rtnl, &req.n, &answer) < 0) {
+		close(fd);
+		return -2;
+	}
+	close(fd);
+
+	/* Validate message and parse attributes */
+	if (answer->nlmsg_type == NLMSG_ERROR)
+		goto out;
+
+	rthdr = NLMSG_DATA(answer);
+	len = answer->nlmsg_len - NLMSG_SPACE(sizeof(*rthdr));
+	if (len < 0)
+		goto out;
+
+	parse_rtattr(tb, NETNSA_MAX, NETNS_RTA(rthdr), len);
+
+	if (tb[NETNSA_NSID])
+		ret = rta_getattr_s32(tb[NETNSA_NSID]);
+
+out:
+	free(answer);
+	return ret;
+}
-- 
2.41.0


