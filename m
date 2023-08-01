Return-Path: <netdev+bounces-23260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CBA76B736
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BBA2812E6
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E31A253C6;
	Tue,  1 Aug 2023 14:19:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C522F1F
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:19:19 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF14DDC
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:19:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9338e4695so86177091fa.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690899556; x=1691504356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXfqsWwmlx+pFgclSFxLHhMMMMln1w8ULlY47AReg4A=;
        b=fnU7bHXu5glFx93mxIEv1ybBDetC8RS+LeZ7CuJH8JHU1zvTKly0H6rPXkKrB4ioWm
         k2ZYOzRIbTu2oWxZoKjeVaT2yPVV9i2WsIU8KUWrnSegIXvTNtbEr/HyJM+ryYUHgxZY
         yAR9zuJ3LYTrRASfVzlZHbgpmdhXvBYg0faklWTjHMODka6zrXFYUlGhZrc2mIoGfQYz
         m2bEMaJBi2p5sdPV4HtAIdHGrDyphHDTvFUFViqxyVn1W2/mdBIaWLu8O1N8UUCgxyHa
         1IdXJxHW/4EeQmI9kHI8Gh8D3JhfTzGWnM2PAm8BYfdpzQyfY3DTHlrSaLBxPcWrcNXk
         pNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899556; x=1691504356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXfqsWwmlx+pFgclSFxLHhMMMMln1w8ULlY47AReg4A=;
        b=h742noRvrvz35nliA5WBhjEPkG/oQzc0RhLs/ekq14Cr6fHv4QyaO53EGt0iCffRzE
         HzQ8lP/YpCcnuiASWBfg0ZaSgXdz9/LvUP4vHJL9Tnw9864IQ/CrxH+Lm+qM/bIiUJYT
         m46N1Czt411MluZnaei7DvG60Qsyxh1Tq9z90eYipKAPC8UByhJh9MkXidMrhseyfRb8
         P2RiJLKwnivKXXP0mGHXusEvbKoCc8ef4n1eEkmZrgp9w4Pa7JWOl9wuCVoFtJ2vVLkk
         Lhd/Zd8uZ9aHLn3vmjAG2qRvJYfTUaDSRKK2nJG9Dw6yHL2LiXQCEsKdbrIwQDPc4MW1
         414A==
X-Gm-Message-State: ABy/qLZ+OEREiudoEdi8UOwN7qeUM9dpIRk8nMnseiFiHVlkl5Dfj15L
	3X2C3BplHJ/Y3eF4L8XZYIAGRqJ6czLq5dXrkMnSjQ==
X-Google-Smtp-Source: APBJJlHZpdZGwEL6jrgS+ghjoL/j/0eC8488ud1K/dgEVQENmkHSw/XEnPXzU0GwlayM+VIQJxBSMQ==
X-Received: by 2002:a05:651c:cf:b0:2b9:b067:9559 with SMTP id 15-20020a05651c00cf00b002b9b0679559mr2530721ljr.23.1690899555903;
        Tue, 01 Aug 2023 07:19:15 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id t25-20020a1709066bd900b00977c7566ccbsm7613167ejs.164.2023.08.01.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:19:15 -0700 (PDT)
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
Subject: [patch net-next 4/8] devlink: add split ops generated according to spec
Date: Tue,  1 Aug 2023 16:19:03 +0200
Message-ID: <20230801141907.816280-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801141907.816280-1-jiri@resnulli.us>
References: <20230801141907.816280-1-jiri@resnulli.us>
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

Improve the existing devlink spec in order to serve as a source fot
generation of valid devlink split ops for the existing commands.
Add the generated sources.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 14 +++++-
 net/devlink/Makefile                     |  2 +-
 net/devlink/netlink_gen.c                | 59 ++++++++++++++++++++++++
 net/devlink/netlink_gen.h                | 33 +++++++++++++
 4 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100644 net/devlink/netlink_gen.c
 create mode 100644 net/devlink/netlink_gen.h

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 5d46ca966979..f6df0b3fd502 100644
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
@@ -189,12 +194,17 @@ operations:
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
-        reply:
+        reply: &info-get-reply
           value: 51
           attributes:
             - bus-name
@@ -204,3 +214,5 @@ operations:
             - info-version-fixed
             - info-version-running
             - info-version-stored
+      dump:
+        reply: *info-get-reply
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
index 000000000000..0091edc73a7a
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
+const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
+/* DEVLINK_CMD_INFO_GET - do */
+const struct nla_policy devlink_info_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
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
+		.validate	= GENL_DONT_VALIDATE_DUMP_STRICT | GENL_DONT_VALIDATE_DUMP,
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
+		.validate	= GENL_DONT_VALIDATE_DUMP_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.dumpit		= devlink_nl_info_get_dumpit,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+};
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
new file mode 100644
index 000000000000..b209869de83f
--- /dev/null
+++ b/net/devlink/netlink_gen.h
@@ -0,0 +1,33 @@
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
+extern const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1];
+
+extern const struct nla_policy devlink_info_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1];
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


