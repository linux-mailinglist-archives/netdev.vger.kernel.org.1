Return-Path: <netdev+bounces-44705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C57D94E7
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301E828241B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBD618031;
	Fri, 27 Oct 2023 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gQ3lu4w7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B51799B
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:14:14 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4BD1A5
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so3875375a12.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698401648; x=1699006448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcI5z2eI3kUBo0BHAkZY7kIa+FkgUkPSSF4raygR3z8=;
        b=gQ3lu4w7SrC4UeqNjlr1sbySzGu8d5y2tdccbPJoxgG4bVY5DmeKXe/prZKDH41v60
         lVLEddEmpSygurov3mrj0ehd6JAsZxssNioeojv6zkHpUx2AfRfbchj3m81BnNuokLaH
         bhShOsZor6ie+sfoTOoDqLHT4vt22v1aBSYIs8neYmsllV7TOHqzHK7vT+BJiEmugF4W
         koXYu9b0hIDVtyfhlnhlyAIzeTX3oTQF9vjJ7gH8spMr9CLEVu221dTPbTK8pVe++r/p
         imv2xuZVkac2qrYpLSVf8nmdrj2+KgFoTB8nM1P+vq3pH4NrBLvUDxyPepELUH/P26qL
         SnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401648; x=1699006448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcI5z2eI3kUBo0BHAkZY7kIa+FkgUkPSSF4raygR3z8=;
        b=S8gQAdXwpekGeBxkXBnGR6x8A9ncE3JqtmJrWHoivUs0uZ39+mVtXp4OrnsWqV3EQ0
         5XVqByOKewP8+wrsulRFmZ6oFPxuYaBwDtpw93ECogzNoS/fLH3wwWBtOtO90wugQbGm
         ShnSxFkd024bDdA0Iyn5a9IZHXw4JRZxirx0R7nDpm/C1f3kFmO4LeqjJqg8puDvLDyY
         WP+o/jKxtsW4tkLa9dDtD/9bMSi5CbSJWBdVVWKLBl/Rnl87duiSqWD5PH/xB+WFjTXi
         NtCGfUjQAirh84vswwje2DgpMY4NGPtL+JEu7+uRTAyP3Cn4btEpvCFhSmqmGPr2a04p
         hElA==
X-Gm-Message-State: AOJu0Yw7b8ybzLcC9WTlDZWpb1+k37KZ9WQhELlQ3Ma17atgeE0Ze5jB
	TlfamFDr0LGMmiF8b3nLexwG7hG6XaYatpRPxUDDVw==
X-Google-Smtp-Source: AGHT+IFKFqOgHq8UMxwaKe62NCvEyEKbUoQRgNDzbQE5jgxQzwT+XKr4eDAgA8d8HawvqFiqqw6YLw==
X-Received: by 2002:a05:6402:2314:b0:53d:bf72:d586 with SMTP id l20-20020a056402231400b0053dbf72d586mr4449279eda.16.1698401648091;
        Fri, 27 Oct 2023 03:14:08 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b1-20020a056402138100b0054026e95beesm984266edv.76.2023.10.27.03.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:14:07 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch net-next v4 1/7] ip/ipnetns: move internals of get_netnsid_from_name() into namespace.c
Date: Fri, 27 Oct 2023 12:13:57 +0200
Message-ID: <20231027101403.958745-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027101403.958745-1-jiri@resnulli.us>
References: <20231027101403.958745-1-jiri@resnulli.us>
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
v3->v4:
- removed namespace.h include
v2->v3:
- s/netns_netnsid_from_name/netns_id_from_name/
v1->v2:
- new patch
---
 include/namespace.h |  2 ++
 ip/ipnetns.c        | 45 +----------------------------------------
 lib/namespace.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/include/namespace.h b/include/namespace.h
index e47f9b5d49d1..6483630b8082 100644
--- a/include/namespace.h
+++ b/include/namespace.h
@@ -58,4 +58,6 @@ struct netns_func {
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


