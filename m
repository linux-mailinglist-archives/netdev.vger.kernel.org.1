Return-Path: <netdev+bounces-34947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839F37A61D1
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F024281849
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1E833996;
	Tue, 19 Sep 2023 11:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE5B4684
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:56:57 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78151E3
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:56:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso63413645e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695124614; x=1695729414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GINydlvgKxtCz7GPVUksnC/Rw9cajTwwmUDJjZKOa1w=;
        b=UttJQnsxwbparp8/FjEgkCF5aeUuoW93GpzGYg6eH6H2MjF1n3en387T4b8k+y5GDa
         roUAcdfb7Q+OeDn+kFOhAdkfXVPaqYyurQszCiqhTibf9UThpa0/FK60wzJZPfteDnXh
         4W3VnzDreNBL7FBzc0j9Q04HMYG30N30CC98uSQaSxgcIZM4e4T1zArQbINmgTiotaOE
         KcrJl190F75s7JcX2xedZocuFdK9xD9v4dtoTrAt0YRgCtwkYWCuLAv2MW11MSJtuBS8
         4MIncUNqVugy6YAABhGOxQMnbMMnJaJFKG+Gh6FzMLwi6L5KfHHi0kJI2yKk9fAo3EAs
         0SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695124614; x=1695729414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GINydlvgKxtCz7GPVUksnC/Rw9cajTwwmUDJjZKOa1w=;
        b=wC5CczWVjRXUHpqTmmJBfyrAPh/9BVSZKBFg4z6uwyZxth+HPrUAEgwwCYxQ8rAyJ7
         FZoG0zLDTL48jKKa0b9OePZ8dZbw00GpPpnWfjca8F/XnPqYwag5kD74WiML83SpvcGC
         JmzcabvwgSEyu6LxCCxlhLtgaCqNuUp6GFs+EaoJ1VOpuFZ5d8WvHc9blfizjVqpu4UZ
         plHE//1dXJSPDpGM8GYh6a0FLznciBnPawg2NBIyD9QWF9EbO8q3tO7/6KdOZ0MNe1UO
         FE3/ZSI/QGnORPkj7cAdhv7inIVqZcllsa4fTHX6w/MVRz71Hf3V5wKqtDIgGmcqboq+
         6R8w==
X-Gm-Message-State: AOJu0Yzy668xMhM5K8LSY3ki4Z0xIPmbSgfISZebofrm9BILKmEF4Y9x
	p1yzHD+kUdb8bRRnmdaQHTDKKPwDnmWbNuIuQVg=
X-Google-Smtp-Source: AGHT+IEH+fsE9Vh/4YUzGD6NtFhwfSFaSY7nxTIBcshnhGywjTvyw7QEBHNxbM8+Ocq0QDNj+2jHqA==
X-Received: by 2002:adf:f3c6:0:b0:31f:e980:df87 with SMTP id g6-20020adff3c6000000b0031fe980df87mr9765890wrp.38.1695124614000;
        Tue, 19 Sep 2023 04:56:54 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v3-20020adff683000000b0031980294e9fsm3346564wrp.116.2023.09.19.04.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:56:53 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v2 3/5] devlink: introduce support for netns id for nested handle
Date: Tue, 19 Sep 2023 13:56:42 +0200
Message-ID: <20230919115644.1157890-4-jiri@resnulli.us>
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

Nested handle may contain DEVLINK_ATTR_NETNS_ID attribute that indicates
the network namespace where the nested devlink instance resides. Process
this converting to netns name if possible and print to user.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- use previously introduced netns_netnsid_from_name() instead of code
  duplication for the same function.
- s/nesns_name_by_id_func/netns_name_by_id_func/
---
 devlink/devlink.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index d1795f616ca0..cf5d466bfc9d 100644
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
@@ -2723,6 +2725,40 @@ static bool should_arr_last_handle_end(struct dl *dl, const char *bus_name,
 	       !cmp_arr_last_handle(dl, bus_name, dev_name);
 }
 
+struct netns_name_by_id_ctx {
+	int32_t id;
+	char *name;
+	struct rtnl_handle *rth;
+};
+
+static int netns_name_by_id_func(char *nsname, void *arg)
+{
+	struct netns_name_by_id_ctx *ctx = arg;
+	int32_t ret;
+
+	ret = netns_netnsid_from_name(ctx->rth, nsname);
+	if (ret < 0 || ret != ctx->id)
+		return 0;
+	ctx->name = strdup(nsname);
+	return 1;
+}
+
+static char *netns_name_by_id(int32_t id)
+{
+	struct rtnl_handle rth;
+	struct netns_name_by_id_ctx ctx = {
+		.id = id,
+		.rth = &rth,
+	};
+
+	if (rtnl_open(&rth, 0) < 0)
+		return NULL;
+	netns_foreach(netns_name_by_id_func, &ctx);
+	rtnl_close(&rth);
+
+	return ctx.name;
+}
+
 static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
 {
 	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
@@ -2740,6 +2776,30 @@ static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
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


