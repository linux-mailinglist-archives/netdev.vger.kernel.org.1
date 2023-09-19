Return-Path: <netdev+bounces-34946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85D07A61D0
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E8C1C20CA6
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896D231A81;
	Tue, 19 Sep 2023 11:56:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A054684
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:56:54 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BA4F4
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:56:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-403012f27e1so59766855e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695124611; x=1695729411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v1bi9Ax+r3HNBGakQouTlqyU8diAgcvaJU2xPHBrys=;
        b=D0sAeEMB2uZ8CkSHeb+RQ5KaDf32w8V3IfcBlLzvJye9Nu7VQf5omcLDe+n9YI5iDF
         Y9EOC6MQyRZacs0qPILbXZR98/QADo8x6uNGEu53pNxf5UM5ISyyqLcbPbe+Tgm9Hqzj
         5DDVLaPq8fO2bqYnlfZb60LvjZvRKgSAUGadUnbyGnmg3Z4spH4uxcTfLzBpmeggrZu5
         TxcNVu7qvRdT14XG3sW+eFZZImVDjDzLR9Dd9vyQEU+rGQgtGD+BuLtSyNEoSVxa0vEv
         2XbyHBH08IY45wS7rQ1Xc5CY7GvE6FCXW9AmCRyjgDppOEWEuo+lTiMSI5KJ4lPLYada
         cwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695124611; x=1695729411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4v1bi9Ax+r3HNBGakQouTlqyU8diAgcvaJU2xPHBrys=;
        b=u/BBqtDNTipmOqIBw/OITLWo0UvuT7MAMkTQkUQ1rbHK54CMnK6Pa+lZ4zfPU9S6in
         ocw2ZfuNRVXjbqLvFezTsC6rdwWOiu5x62Svpid2UExhvSsaFA+XcZDKArN8YjZXiTx+
         cncqu/X7e/5tKTeqiJJRfIrjR+Gc54TX8IAcXEtmxG2aIMO3gkGm5iA77/MTXsmvpu8G
         R03dv9ux/rcgeTQUb3FtX4G4l0Uv0VPuoh8x0P9gtJ+jSksFACjj9tM+m1/DMNhrUlg7
         myHyY2P+Zel9fL7VC/kZqxW5Gif0FegEt7FiqCikUExLkXrZR+WD+4rC+43e3RDVuEPP
         KwJQ==
X-Gm-Message-State: AOJu0YzjIDPOlp7ulV2Il/BwXJPIDhsMkWVqVQcn0xRFzV/KAJWylq64
	QZBuPjOLD6X2tNgGw6rIgeUFTiA9owQIeQUYtY4=
X-Google-Smtp-Source: AGHT+IEYmjqjEVm+Zw0g7BP199crX+SZ5vzrQ1bwoA1PCK7/ywj2SzWi1feE6akDq7eJ9UGPc1+7CQ==
X-Received: by 2002:a05:600c:2194:b0:3fe:f45:772d with SMTP id e20-20020a05600c219400b003fe0f45772dmr9112775wme.28.1695124611721;
        Tue, 19 Sep 2023 04:56:51 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g8-20020a7bc4c8000000b003ff013a4fd9sm14978718wmk.7.2023.09.19.04.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:56:50 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v2 2/5] ip/ipnetns: move internals of get_netnsid_from_name() into namespace.c
Date: Tue, 19 Sep 2023 13:56:41 +0200
Message-ID: <20230919115644.1157890-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919115644.1157890-1-jiri@resnulli.us>
References: <20230919115644.1157890-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

In order to be able to reuse get_netnsid_from_name() function outside of
ip code, move the internals to lib/namespace.c to a new function called
netns_netnsid_from_name().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 include/namespace.h |  4 ++++
 ip/ipnetns.c        | 45 +----------------------------------------
 lib/namespace.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/include/namespace.h b/include/namespace.h
index e47f9b5d49d1..f564a574d200 100644
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
 
+int netns_netnsid_from_name(struct rtnl_handle *rtnl, const char *name);
+
 #endif /* __NAMESPACE_H__ */
diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 9d996832aef8..642873432a4b 100644
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
+	return netns_netnsid_from_name(&rtnsh, name);
 }
 
 struct nsid_cache {
diff --git a/lib/namespace.c b/lib/namespace.c
index 1202fa85f97d..39981d835aa5 100644
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
+int netns_netnsid_from_name(struct rtnl_handle *rtnl, const char *name)
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


