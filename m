Return-Path: <netdev+bounces-43796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997E87D4D37
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 023F6B20F3B
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD03250F5;
	Tue, 24 Oct 2023 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oleDd+hb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F6250ED
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:04:10 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094ADEA
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9bf0ac97fdeso604641266b.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698141847; x=1698746647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2yDAqtESHRIhVQtHN6xfONaeCRWGymWxnQhzScD7Z0=;
        b=oleDd+hb20Rlad+Ik6GEsHRz7Oe47FR9NpUfqFpFHZmMPI1VR3vGYU1dq9L/MgVLDq
         /tjfRGiPpU9G0s4B5pDjdVRfsEWdZTsIYzeI7Bdet5PZaKLEivCcJi9mKicBDTWzvVaL
         7iX/LQGkm7BvQ/KRtsdKxACoTz9khoAKX+/SlNN5iffE8MTu6NZ1y2rODDjzIu0/e+lB
         klQZsBU2I643uNLzDPfOLOuGqYyqMyEH+CXlZ5OhFLK7EIczHBBIxfN8M4md/6bYAzJq
         iyXHs6sUiCbCJF82nsqDnGcFXv8rKF/v/ERE4SvaJ0CHgJztGSxegx2V7w83DJNZBnxW
         VZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141847; x=1698746647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2yDAqtESHRIhVQtHN6xfONaeCRWGymWxnQhzScD7Z0=;
        b=R5xdF053ay4/GN9KKFuLsUVf9BdZQplwq7AQngFzodKhIYm2MgJkKGaAnDOJPFxe/K
         hDgvSAW1sMwnKSo1hzrgwGRHAoAn0QvL/Ircv6QwFuDus2Thh91vdUDGptQka8iX81KB
         KdKcgkHPiqEiPYYX/sj76zh64AFATCC1F7QPZAKxbAFBJAMZk1O/pzaPPc0PBvqSlsJ1
         BrqOhiav54gqHsETWWD0kjsaOtRRDTgQTiDTZZ/k+i4zJQtiksuM2TUK+3azIjRyEDIp
         faENkZXMYXrCZ7d6xOOwo6rJZgfaukDT6JSUu45CItZtU0wM4vbmIOWqJneQK4ShBUHE
         IuRw==
X-Gm-Message-State: AOJu0Yx/ploLSk/hB7OZTN/CAbdu6k8YVagMmEpad3XUhud4QOEjpeL5
	9zTnMxP5lWy2uOYg+mwESzUsUZwzluCIqt7C3AE9lw==
X-Google-Smtp-Source: AGHT+IFrGbtmSzRXwwnu/RnChI3fdR6JyvWoGdAgWPAV4MfdlJOYj6C807TjSOyU5ei6wZCyKCgmRQ==
X-Received: by 2002:a17:906:ef0e:b0:9be:834a:f80b with SMTP id f14-20020a170906ef0e00b009be834af80bmr8775123ejs.75.1698141847299;
        Tue, 24 Oct 2023 03:04:07 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906171a00b009c921a8aae2sm4128236eje.7.2023.10.24.03.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:04:06 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v3 1/6] ip/ipnetns: move internals of get_netnsid_from_name() into namespace.c
Date: Tue, 24 Oct 2023 12:03:58 +0200
Message-ID: <20231024100403.762862-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024100403.762862-1-jiri@resnulli.us>
References: <20231024100403.762862-1-jiri@resnulli.us>
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
v2->v3:
- s/netns_netnsid_from_name/netns_id_from_name/
v1->v2:
- new patch
---
 include/namespace.h |  4 ++++
 ip/ipnetns.c        | 45 +----------------------------------------
 lib/namespace.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/include/namespace.h b/include/namespace.h
index e47f9b5d49d1..e860a4b8ee5b 100644
--- a/include/namespace.h
+++ b/include/namespace.h
@@ -8,6 +8,8 @@
 #include <sys/syscall.h>
 #include <errno.h>
 
+#include "namespace.h"
+
 #ifndef NETNS_RUN_DIR
 #define NETNS_RUN_DIR "/var/run/netns"
 #endif
@@ -58,4 +60,6 @@ struct netns_func {
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


