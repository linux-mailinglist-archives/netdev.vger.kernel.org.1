Return-Path: <netdev+bounces-23987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C776E696
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646351C2152D
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D1018C05;
	Thu,  3 Aug 2023 11:13:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED61DDFD
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:13:58 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D46EA
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:13:57 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-99bf1f632b8so125112166b.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061235; x=1691666035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjXfH+A0B1Bx2EXBFqrsTnqeGAmKJdYOCJ870ddFWlM=;
        b=QnuAj4p6o3ULtv73aEVNMrbBTx1qAUskvBfSOJBP9odukSxoADiDfcD692nK7NQPS8
         q2gkjZH7Y5yV4UF7nlWAQqkCQ0KgY8cg6NnxOReTEf4rrUrQ1fnEcKvq4heEdkJ4/+zZ
         LoxSI3jemIdEa+KXB32OoD99w/4m2XpFbL3vjxu2o7s4wfZ5UkmXo1GTMO+RP34szJOc
         UMeMQwcEy344SxEYz2vKSiBT+5iyRYkTt1hP4M/93Pj3CyfyO0bcKc/9E6+Srs9jACE6
         he5mEo1NPPf6vhg/A/MiMzrsgbHWJRhIwxrnT0ZCqx6BQyyMvO5UymJDIfn7Yme8K3/q
         XzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061235; x=1691666035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjXfH+A0B1Bx2EXBFqrsTnqeGAmKJdYOCJ870ddFWlM=;
        b=djd9nwixlGk9wVJ3cSnfGzCHSuhwvpQrlf1HuhGDHW+1z4/POjTzgb2pVQUbqZYp1T
         dZbzRWiZRpOyFFNm/NEo1JPy5GuWJ7vE22hhy1YJ1sv8HFWjGr9uW6nNuGsF/SO1tYW2
         eYgHH0S/GoA27syV3Htow0BI2i+WCtY0lO/RJ1QuEE7YyyFw4Ai5k/LUaCDoHsrWRMKD
         7QBQvWXAqPhgSsHfXG7NxLqfPy+pk14qu4S/Hh4i1bDbUqq5hs6AkWyk5sW60u4mmpTP
         agEca7w1/aOtO8wuDmr8WQouORmpbrCoi8Ai/KrtymQEM9/mexIDOhjZsJwyRaZS08vW
         JoWw==
X-Gm-Message-State: ABy/qLYQnGUZ1kV3VEkMSHImeaGy1Rz4mvjEATX0fSPFnQwdW/FjOY0d
	4XSyYUGkkQJIT4qxkyYRsufZLIB9XuYQ5YAEZCtbexk3
X-Google-Smtp-Source: APBJJlFMPyNoqEvyxQPKCrRtoTAqi7HxD1UmyxbFvHrYeAw563lrPbEGTR+/zNU0+ASJTNVwq++eMA==
X-Received: by 2002:a17:906:5da5:b0:99b:e5c3:2e45 with SMTP id n5-20020a1709065da500b0099be5c32e45mr6464351ejv.28.1691061235735;
        Thu, 03 Aug 2023 04:13:55 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id pw3-20020a17090720a300b00987e2f84768sm10308464ejb.0.2023.08.03.04.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:55 -0700 (PDT)
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
Subject: [patch net-next v3 09/12] netlink: specs: devlink: add info-get dump op
Date: Thu,  3 Aug 2023 13:13:37 +0200
Message-ID: <20230803111340.1074067-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803111340.1074067-1-jiri@resnulli.us>
References: <20230803111340.1074067-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
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


