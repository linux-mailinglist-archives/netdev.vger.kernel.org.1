Return-Path: <netdev+bounces-23682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BF976D1C2
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787EC281C16
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AC9D514;
	Wed,  2 Aug 2023 15:21:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7FD527
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:21:23 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E7A4EE7
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:20:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe2bc2702cso16626395e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690989637; x=1691594437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SObDBYoFomzzFPqCkfSUruqmSzpgvk3HNcTMlAHGFyM=;
        b=KuQz4A93OEex6sM+NiAtOJFDKhEGnB4QFjTeQ4JY30EP9XfsgbO02IGcBe3v8dmtz6
         lWtGaQsgUFKeixtQG7+oCxSOh7OfdKCtz4U9e9hvRKD4zDYjQQ/nvOsgaKQJzRB2f02Z
         ULqLX3Du6XGyCEsbYhSlA4nzUhm7BpH3YyAyMwRHqIQnPUM3r+EjJ3O09Rj0er/s3Xkp
         jDQiXYMP8uskWLYUJppXYWb613SdSEiT97FwD7BqcHcvW9yhcvWPqwuZzQgxJVODX0R+
         wg4PZPMDXwBZ1jatqVOKOdbkpP3s6ZILblpWDB+B5aj8H3jz0B/rD3/GcxGxMSjp/HsP
         mL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989637; x=1691594437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SObDBYoFomzzFPqCkfSUruqmSzpgvk3HNcTMlAHGFyM=;
        b=SeAJnf90X+U2ZzTVhNIwg/bBK6lR/4TAyh6JQhS4AM77etq3iCxLWqAXkM+w09hDU/
         E9MaJ6jcSGucQECRoZyyQtb4hyZ6V9FnP484CWq5ZQOLXaXs0c9Pp3q7NlpxciNdEUDz
         5E29ixxExsUQn49hp4IZXadYonJGDNKfBV7VgoMYJTF8k6CBnddoly3OBVoG3xdjwvpf
         tf/BoXnBDYVFxsRWvW/9xs58CEeHzsWOxPK2o4lXEveIk0QelaGV9HfxUPcHd6XCyfIh
         ZM7CPKF3omlH+3+4yoLMr6Vp0BrRRfbSf3kOrVl1WMzoORLvY8P49qGvC4yT5QNIfHh8
         ZZCw==
X-Gm-Message-State: ABy/qLbSehBCk9o6NKa5clwD9OcznejMlX/P2tlZddANjPYYIRDT15f1
	TOJ62IY9TclJM1b8/x3S35d8chdGqt8FC308mQOQDg==
X-Google-Smtp-Source: APBJJlFlNAxoAwn/VVMy85QJQwMmYqCn0x5B/7Gcm/Anjmix8XJ2Ikv0NKVfT3iiqO7YkMgJ6GwFlQ==
X-Received: by 2002:a1c:f211:0:b0:3f4:d18f:b2fb with SMTP id s17-20020a1cf211000000b003f4d18fb2fbmr5374093wmc.8.1690989637224;
        Wed, 02 Aug 2023 08:20:37 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id t22-20020a7bc3d6000000b003fe1ddd6ac0sm1963792wmj.35.2023.08.02.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:20:36 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next v2 07/11] devlink: add split ops generated according to spec
Date: Wed,  2 Aug 2023 17:20:19 +0200
Message-ID: <20230802152023.941837-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802152023.941837-1-jiri@resnulli.us>
References: <20230802152023.941837-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Improve the existing devlink spec in order to serve as a source for
generation of valid devlink split ops for the existing commands.
Add the generated sources.

Node that the policies are narrowed down only to the attributes that
are actually parsed. The dont-validate-strict parsing policy makes sure
that other possibly passed garbage attributes from userspace are
ignored during validation.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- fixed "for" typo
- added note to patch description about narrowing down the policy
- moved info-get dump op addition to a separate patch
- regenerated files according to static policies change
---
 Documentation/netlink/specs/devlink.yaml | 10 ++++
 net/devlink/Makefile                     |  2 +-
 net/devlink/netlink_gen.c                | 59 ++++++++++++++++++++++++
 net/devlink/netlink_gen.h                | 29 ++++++++++++
 4 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 net/devlink/netlink_gen.c
 create mode 100644 net/devlink/netlink_gen.h

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 12699b7ce292..f6df0b3fd502 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -165,8 +165,13 @@ operations:
       name: get
       doc: Get devlink instances.
       attribute-set: devlink
+      dont-validate:
+        - strict
+        - dump
 
       do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
         request:
           value: 1
           attributes: &dev-id-attrs
@@ -189,8 +194,13 @@ operations:
       name: info-get
       doc: Get device information, like driver name, hardware and firmware versions etc.
       attribute-set: devlink
+      dont-validate:
+        - strict
+        - dump
 
       do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
         request:
           value: 51
           attributes: *dev-id-attrs
diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index ef91a76646a3..a087af581847 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := leftover.o core.o netlink.o dev.o health.o
+obj-y := leftover.o core.o netlink.o netlink_gen.o dev.o health.o
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
new file mode 100644
index 000000000000..32d8cbed0c30
--- /dev/null
+++ b/net/devlink/netlink_gen.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/devlink.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "netlink_gen.h"
+
+#include <uapi/linux/devlink.h>
+
+/* DEVLINK_CMD_GET - do */
+static const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
+/* DEVLINK_CMD_INFO_GET - do */
+static const struct nla_policy devlink_info_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
+/* Ops table for devlink */
+const struct genl_split_ops devlink_nl_ops[4] = {
+	{
+		.cmd		= DEVLINK_CMD_GET,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.pre_doit	= devlink_nl_pre_doit,
+		.doit		= devlink_nl_get_doit,
+		.post_doit	= devlink_nl_post_doit,
+		.policy		= devlink_get_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DEVLINK_CMD_GET,
+		.validate	= GENL_DONT_VALIDATE_DUMP,
+		.dumpit		= devlink_nl_get_dumpit,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DEVLINK_CMD_INFO_GET,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.pre_doit	= devlink_nl_pre_doit,
+		.doit		= devlink_nl_info_get_doit,
+		.post_doit	= devlink_nl_post_doit,
+		.policy		= devlink_info_get_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DEVLINK_CMD_INFO_GET,
+		.validate	= GENL_DONT_VALIDATE_DUMP,
+		.dumpit		= devlink_nl_info_get_dumpit,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+};
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
new file mode 100644
index 000000000000..11980e04a718
--- /dev/null
+++ b/net/devlink/netlink_gen.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/devlink.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_DEVLINK_GEN_H
+#define _LINUX_DEVLINK_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/devlink.h>
+
+/* Ops table for devlink */
+extern const struct genl_split_ops devlink_nl_ops[4];
+
+int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+			struct genl_info *info);
+void
+devlink_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		     struct genl_info *info);
+
+int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int devlink_nl_info_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_info_get_dumpit(struct sk_buff *skb,
+			       struct netlink_callback *cb);
+
+#endif /* _LINUX_DEVLINK_GEN_H */
-- 
2.41.0


