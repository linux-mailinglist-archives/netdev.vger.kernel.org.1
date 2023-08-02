Return-Path: <netdev+bounces-23681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C912D76D1C1
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6BD1C21337
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24CDD52F;
	Wed,  2 Aug 2023 15:21:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580DD514
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:21:21 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619454EE3
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:20:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-3175d5ca8dbso6180335f8f.2
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690989635; x=1691594435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjXfH+A0B1Bx2EXBFqrsTnqeGAmKJdYOCJ870ddFWlM=;
        b=OJyCO89dG/jp45Eq1pxH6DcPys4ZnVsuIKAU3XnjshBMgBa3rN2EjukAfrOqrGAmMr
         cZ522drGTmp+qx6DHgb58ER/vfVjLP0wNQCeSjdTMatq9Iy9LU5sw9/cuuP8jQ+Z9VOB
         tE0oPyNJ6foMZxkD2bCejdNhjQBnU1rwYeOLFxYNaFsCig+N1oUfkG+Zu0SR9pV1T7h2
         6sVJDBzAWRfuIM9FTFVbzpU13ONd8ProlnbQOujV5Z3eT5WuWDLOPMyK3Cyzu0rkqSZZ
         7PlClFW1lg7rcT9f/oPyrcAIdTm5UEQArdN5j3WKrKF/8MAARyyp9giP7RvBGzetLwO4
         FOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989635; x=1691594435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjXfH+A0B1Bx2EXBFqrsTnqeGAmKJdYOCJ870ddFWlM=;
        b=OO/uk5H/44K7Ch+FkKnWUTQ8XticyUu4VhrUvqtP4hcUT95bjuxIEj0K3bIYsHsaIv
         XXV3DCsESE558kSm4Tetv9vo765KSwM4vIxm6FXgmGF6KoIOJ2wtB/0t7N3jBneyfa8N
         BKbZGMFCTG6TIChUAtgD+wDHDdVRQZi4zWqKZxRmZ7lxLo36Xo+5CxIwXIeD3sQ+v3km
         AlYlmAx7kkuITMB6cvLJRdgp09xveB+znbqj7GJOLq0wl3Iw/Z2E8dEiBkWoUI6TGaxe
         org7HshXBasd6DPrRSo10KRrCQtl8Ut/hJKukcdOSGj9tAqtqdsMu/v2bFZx19OXcOdH
         eXQw==
X-Gm-Message-State: ABy/qLb1fmu2/qZZyg/WiKCOwcdtcJFeZWpWgR2PD2rnhKVS6Ew5hZZj
	UYaIYBHuGtVT4hY8GC7N0UBRnnqyJkoCkFETHPbLrGCX
X-Google-Smtp-Source: APBJJlFJnopw3C35I/Oe/BrmU97jjNMYQZ4vUNvyDbSnsmaYAjxs/0v7Xmqqw/DUzm8a/D93Ygr/gw==
X-Received: by 2002:adf:f44c:0:b0:317:3f64:4901 with SMTP id f12-20020adff44c000000b003173f644901mr4922330wrp.41.1690989635711;
        Wed, 02 Aug 2023 08:20:35 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id z17-20020adfec91000000b003179d7ed4f3sm11017711wrn.12.2023.08.02.08.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:20:35 -0700 (PDT)
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
Subject: [patch net-next v2 06/11] netlink: specs: devlink: add info-get dump op
Date: Wed,  2 Aug 2023 17:20:18 +0200
Message-ID: <20230802152023.941837-7-jiri@resnulli.us>
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

Add missing dump op for info-get command and re-generate related
devlink-user.[ch] code.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch, spec split from the next one, adding forgotten changes
  in devlink-user.[ch] code
---
 Documentation/netlink/specs/devlink.yaml |  4 +-
 tools/net/ynl/generated/devlink-user.c   | 53 ++++++++++++++++++++++++
 tools/net/ynl/generated/devlink-user.h   | 10 +++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 5d46ca966979..12699b7ce292 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -194,7 +194,7 @@ operations:
         request:
           value: 51
           attributes: *dev-id-attrs
-        reply:
+        reply: &info-get-reply
           value: 51
           attributes:
             - bus-name
@@ -204,3 +204,5 @@ operations:
             - info-version-fixed
             - info-version-running
             - info-version-stored
+      dump:
+        reply: *info-get-reply
diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index 939bd45feaca..8492789433b9 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -716,6 +716,59 @@ devlink_info_get(struct ynl_sock *ys, struct devlink_info_get_req *req)
 	return NULL;
 }
 
+/* DEVLINK_CMD_INFO_GET - dump */
+void devlink_info_get_list_free(struct devlink_info_get_list *rsp)
+{
+	struct devlink_info_get_list *next = rsp;
+
+	while ((void *)next != YNL_LIST_END) {
+		unsigned int i;
+
+		rsp = next;
+		next = rsp->next;
+
+		free(rsp->obj.bus_name);
+		free(rsp->obj.dev_name);
+		free(rsp->obj.info_driver_name);
+		free(rsp->obj.info_serial_number);
+		for (i = 0; i < rsp->obj.n_info_version_fixed; i++)
+			devlink_dl_info_version_free(&rsp->obj.info_version_fixed[i]);
+		free(rsp->obj.info_version_fixed);
+		for (i = 0; i < rsp->obj.n_info_version_running; i++)
+			devlink_dl_info_version_free(&rsp->obj.info_version_running[i]);
+		free(rsp->obj.info_version_running);
+		for (i = 0; i < rsp->obj.n_info_version_stored; i++)
+			devlink_dl_info_version_free(&rsp->obj.info_version_stored[i]);
+		free(rsp->obj.info_version_stored);
+		free(rsp);
+	}
+}
+
+struct devlink_info_get_list *devlink_info_get_dump(struct ynl_sock *ys)
+{
+	struct ynl_dump_state yds = {};
+	struct nlmsghdr *nlh;
+	int err;
+
+	yds.ys = ys;
+	yds.alloc_sz = sizeof(struct devlink_info_get_list);
+	yds.cb = devlink_info_get_rsp_parse;
+	yds.rsp_cmd = DEVLINK_CMD_INFO_GET;
+	yds.rsp_policy = &devlink_nest;
+
+	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_INFO_GET, 1);
+
+	err = ynl_exec_dump(ys, nlh, &yds);
+	if (err < 0)
+		goto free_list;
+
+	return yds.first;
+
+free_list:
+	devlink_info_get_list_free(yds.first);
+	return NULL;
+}
+
 const struct ynl_family ynl_devlink_family =  {
 	.name		= "devlink",
 };
diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
index a008b99b6e24..af65e2f2f529 100644
--- a/tools/net/ynl/generated/devlink-user.h
+++ b/tools/net/ynl/generated/devlink-user.h
@@ -207,4 +207,14 @@ void devlink_info_get_rsp_free(struct devlink_info_get_rsp *rsp);
 struct devlink_info_get_rsp *
 devlink_info_get(struct ynl_sock *ys, struct devlink_info_get_req *req);
 
+/* DEVLINK_CMD_INFO_GET - dump */
+struct devlink_info_get_list {
+	struct devlink_info_get_list *next;
+	struct devlink_info_get_rsp obj __attribute__ ((aligned (8)));
+};
+
+void devlink_info_get_list_free(struct devlink_info_get_list *rsp);
+
+struct devlink_info_get_list *devlink_info_get_dump(struct ynl_sock *ys);
+
 #endif /* _LINUX_DEVLINK_GEN_H */
-- 
2.41.0


