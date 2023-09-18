Return-Path: <netdev+bounces-34531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F597A47AA
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA88D28154F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678456AA4;
	Mon, 18 Sep 2023 10:54:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81E6FC3
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:54:51 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271F3188
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 03:54:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991c786369cso590158166b.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695034461; x=1695639261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvAKdPrFmWu5KYQYiGqglh6LusMwFEKr0TU1U+69is8=;
        b=dRf61l3V7p/d1qKEuXskPJcLyE2kdIiLl6pBwC4A7JPimPJvnLs0xIcXGPvZIqWZiq
         GYYqhkBFnDFazMr/lYyPCjR4BJDepmaF3NiOjCxkwMgbUOfisoQuMQyehQubdUMS7Enl
         58SamEYArnaHKP4po2HWiqx4ujh1vvfYxEB3Jue13WNvjnvFHgyp5ZLLESVopmP71Yob
         sGw304NrbZXAs0kFiMhdclvFks1IP0TQG9rquDNw1wkPXuVtwx5nsB+yoKM+GRbSBHi5
         2u5NDaMstn+gzwXja1yZ8Mnv+wpAjybsSjbBPyDS2YhVCJODIqmwUwehA3pFabrBgScn
         7ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695034461; x=1695639261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvAKdPrFmWu5KYQYiGqglh6LusMwFEKr0TU1U+69is8=;
        b=dI76Wz41rXJQsMkUjJwMye2ppAzcpV7CAqP7avyeitBMT9sTXN1R840uc5JJlqlgk7
         bhMfRDK9GT/n5N4TJ++VjW8fgOUEBjJXdgLvpar6u0gh1HDyVqRuHj91w29L46JQSF7k
         AHIxRX1J303CjJrnZi1UfJj8JnKskqxB/nxsRAQF2sPoc8bHmeC/LmPEUoIKilDjIYnk
         mqJbUsnp8hIlWIitcERNixcnPlydTE1bF8AGNuCEsEXEOBamQi7xpfG9IGrN3OVn4viT
         FF2aZLMKzCUuMJ9KVt8NSSPo6Ha333u65ZK+ymRPOt2NfuA9wYkXoS3yYeL/+rZ2Ve2g
         qlKQ==
X-Gm-Message-State: AOJu0YyY78m+EgUk1hq59agqhfZkLM29jHAZohbYIl4mulf0Cy/0lJQ+
	/VvnsJwBX7sYxmGBmZoe4HmT82XuLIjaWywBlyU=
X-Google-Smtp-Source: AGHT+IHf5xB7lISVdo/1SFGdn9z0VAAfMStmpbEooajetvSEXaZNGx1dZBimib/20hRzOvxMxJTVbA==
X-Received: by 2002:a17:906:329a:b0:9a9:e6c3:ad28 with SMTP id 26-20020a170906329a00b009a9e6c3ad28mr7796416ejw.69.1695034461461;
        Mon, 18 Sep 2023 03:54:21 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090629c300b009929d998abcsm6239020eje.209.2023.09.18.03.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 03:54:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next 2/4] devlink: introduce support for netns id for nested handle
Date: Mon, 18 Sep 2023 12:54:14 +0200
Message-ID: <20230918105416.1107260-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918105416.1107260-1-jiri@resnulli.us>
References: <20230918105416.1107260-1-jiri@resnulli.us>
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

Nested handle may contain DEVLINK_ATTR_NETNS_ID attribute that indicates
the network namespace where the nested devlink instance resides. Process
this converting to netns name if possible and print to user.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index d1795f616ca0..31dd29452c39 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -24,6 +24,7 @@
 #include <linux/genetlink.h>
 #include <linux/devlink.h>
 #include <linux/netlink.h>
+#include <linux/net_namespace.h>
 #include <libmnl/libmnl.h>
 #include <netinet/ether.h>
 #include <sys/select.h>
@@ -722,6 +723,7 @@ static const enum mnl_attr_data_type devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_LINECARD_SUPPORTED_TYPES] = MNL_TYPE_NESTED,
 	[DEVLINK_ATTR_NESTED_DEVLINK] = MNL_TYPE_NESTED,
 	[DEVLINK_ATTR_SELFTESTS] = MNL_TYPE_NESTED,
+	[DEVLINK_ATTR_NETNS_ID] = MNL_TYPE_U32,
 };
 
 static const enum mnl_attr_data_type
@@ -2723,6 +2725,85 @@ static bool should_arr_last_handle_end(struct dl *dl, const char *bus_name,
 	       !cmp_arr_last_handle(dl, bus_name, dev_name);
 }
 
+static int32_t netns_id_by_name(const char *name)
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
+	int ret = NETNSA_NSID_NOT_ASSIGNED;
+	struct rtattr *tb[NETNSA_MAX + 1];
+	struct nlmsghdr *n = NULL;
+	struct rtnl_handle rth;
+	struct rtgenmsg *rtg;
+	int len;
+	int fd;
+
+	fd = netns_get_fd(name);
+	if (fd < 0)
+		return ret;
+
+	if (rtnl_open(&rth, 0) < 0)
+		return ret;
+
+	addattr32(&req.n, sizeof(req), NETNSA_FD, fd);
+	if (rtnl_talk(&rth, &req.n, &n) < 0)
+		goto out;
+
+	if (n->nlmsg_type == NLMSG_ERROR)
+		goto out;
+
+	rtg = NLMSG_DATA(n);
+	len = n->nlmsg_len;
+
+	len -= NLMSG_SPACE(sizeof(*rtg));
+	if (len < 0)
+		goto out;
+
+	parse_rtattr(tb, NETNSA_MAX, NETNS_RTA(rtg), len);
+	if (tb[NETNSA_NSID])
+		ret = rta_getattr_s32(tb[NETNSA_NSID]);
+
+out:
+	free(n);
+	rtnl_close(&rth);
+	close(fd);
+	return ret;
+}
+
+struct netns_name_by_id_ctx {
+	int32_t id;
+	char *name;
+};
+
+static int nesns_name_by_id_func(char *nsname, void *arg)
+{
+	struct netns_name_by_id_ctx *ctx = arg;
+	int32_t ret;
+
+	ret = netns_id_by_name(nsname);
+	if (ret < 0 || ret != ctx->id)
+		return 0;
+	ctx->name = strdup(nsname);
+	return 1;
+}
+
+static char *netns_name_by_id(int32_t id)
+{
+	struct netns_name_by_id_ctx ctx = {
+		.id = id,
+	};
+
+	netns_foreach(nesns_name_by_id_func, &ctx);
+	return ctx.name;
+}
+
 static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
 {
 	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
@@ -2740,6 +2821,30 @@ static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
 	sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
 		mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
 	print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
+
+	if (tb[DEVLINK_ATTR_NETNS_ID]) {
+		int32_t id = mnl_attr_get_u32(tb[DEVLINK_ATTR_NETNS_ID]);
+
+		if (id >= 0) {
+			char *name = netns_name_by_id(id);
+
+			if (name) {
+				print_string(PRINT_ANY,
+					     "nested_devlink_netns",
+					     " nested_devlink_netns %s", name);
+				free(name);
+			} else {
+				print_int(PRINT_ANY,
+					  "nested_devlink_netnsid",
+					  " nested_devlink_netnsid %d", id);
+			}
+		} else {
+			print_string(PRINT_FP, NULL,
+				     " nested_devlink_netnsid %s", "unknown");
+			print_int(PRINT_JSON,
+				  "nested_devlink_netnsid", NULL, id);
+		}
+	}
 }
 
 static void __pr_out_handle_start(struct dl *dl, struct nlattr **tb,
-- 
2.41.0


