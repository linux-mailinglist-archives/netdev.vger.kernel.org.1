Return-Path: <netdev+bounces-31580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6085F78EE78
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F4B28158D
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABCB11739;
	Thu, 31 Aug 2023 13:22:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA151172B
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:22:38 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0781CEB
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3ff7d73a6feso7338015e9.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693488155; x=1694092955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNGjPi8Kz3iWxuqrnIa6y+7h6yi5Yp1+x9gNKGAxkDk=;
        b=AN9HIyke08Tr9OifM9Gn8TOkBwe5yPsclZngGODBnhq4+UuflpbDFcIADjt33oHAWo
         vz5tLQvOo/V+9HkVTiPcwsNrlK8TeZ+Qvqdopa/ylc36cqLyz74vWSq9xr/AOrVJLv5V
         rBIGdrs+fU2CWwbK/iJuP4dwdz+ve5JwlsAAqrNN+RAiqUq16/9t5kMya1BbV+6DUrZV
         XW2KIprNM3kwfl0hAxch7ST1XKHyv1ytKS4oPhTyd2JuM1Lj6Y79Oj9YnRiaGwsZMuG7
         1+xIfFY2vI/f1UgxHwY+yIuOHWgJLweK2VmLcVFAvA8K9gbgvdqNOWTYSGNx/1CfKa8a
         Nb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693488155; x=1694092955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNGjPi8Kz3iWxuqrnIa6y+7h6yi5Yp1+x9gNKGAxkDk=;
        b=EnQUkwXi3b24NAHiMMzN5IxzeE7lAabXtACBFYVU9qzYa/geuMUmkC2eg7hTKwXFqs
         mStO65JKAQc2qU6UD6g0n9EvBq6vfJSQomypFEfXXkQyOqGSSYbtk70xQ92mMwyEUZKK
         TiwP6t2hnpUfMNYrjf9YO4JgdaeRyiTe4WiRbCPf7FoGvg0z/vA8vNDrAvw9zbyW4rdT
         aHsUzO09mj1Gqcxk38ymaNbrqKhNKOlR+cRhjsOvKdxXiV2A81cQ+1agRlw8w9mNXE/7
         r5ctlQtH2yCH/T67fQd+Le8/GJxV60F+mg+x3FY5mZKomC3T5UMDHj4BM5hyHMlfvq1O
         TmnQ==
X-Gm-Message-State: AOJu0YygKPvng14b6pHIQpxHEmAHEYYolxsmv0BB/sN3VwksxKtwDjXv
	uYybb+xCZi8FS2yd4ZSYy8iaIRtUyUsVK10EszY=
X-Google-Smtp-Source: AGHT+IEWA4SZ02tkNm/xGuUUWeoNYfBL+JiuaQjw00f4DRehp//L26ZwswRjwWRy+7s2bknIyRNnEA==
X-Received: by 2002:a05:600c:3798:b0:3f5:fff8:d4f3 with SMTP id o24-20020a05600c379800b003f5fff8d4f3mr4177435wmr.7.1693488155246;
        Thu, 31 Aug 2023 06:22:35 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003feae747ff2sm5191368wmh.35.2023.08.31.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:22:34 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next 2/6] devlink: make parsing of handle non-destructive to argv
Date: Thu, 31 Aug 2023 15:22:25 +0200
Message-ID: <20230831132229.471693-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831132229.471693-1-jiri@resnulli.us>
References: <20230831132229.471693-1-jiri@resnulli.us>
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

Currently, handle parsing is destructive as the "\0" string ends are
being put in certain positions during parsing. That prevents it from
being used repeatedly. This is problematic with the follow-up patch
implementing dry-parsing. Fix by making a copy of handle argv during
parsing.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 713ac1f201e2..e7b5b788863a 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -378,6 +378,7 @@ struct dl {
 	struct list_head ifname_map_list;
 	int argc;
 	char **argv;
+	char *handle_argv;
 	bool no_nice_names;
 	struct dl_opts opts;
 	bool json_output;
@@ -1066,9 +1067,8 @@ static int __dl_argv_handle(char *str, char **p_bus_name, char **p_dev_name)
 	return 0;
 }
 
-static int dl_argv_handle(struct dl *dl, char **p_bus_name, char **p_dev_name)
+static int dl_argv_handle(char *str, char **p_bus_name, char **p_dev_name)
 {
-	char *str = dl_argv_next(dl);
 	int err;
 
 	err = ident_str_validate(str, 1);
@@ -1121,10 +1121,9 @@ static int __dl_argv_handle_port_ifname(struct dl *dl, char *str,
 	return 0;
 }
 
-static int dl_argv_handle_port(struct dl *dl, char **p_bus_name,
+static int dl_argv_handle_port(struct dl *dl, char *str, char **p_bus_name,
 			       char **p_dev_name, uint32_t *p_port_index)
 {
-	char *str = dl_argv_next(dl);
 	unsigned int slash_count;
 
 	if (!str) {
@@ -1146,11 +1145,10 @@ static int dl_argv_handle_port(struct dl *dl, char **p_bus_name,
 	}
 }
 
-static int dl_argv_handle_both(struct dl *dl, char **p_bus_name,
+static int dl_argv_handle_both(struct dl *dl, char *str, char **p_bus_name,
 			       char **p_dev_name, uint32_t *p_port_index,
 			       uint64_t *p_handle_bit)
 {
-	char *str = dl_argv_next(dl);
 	unsigned int slash_count;
 	int err;
 
@@ -1199,10 +1197,9 @@ static int __dl_argv_handle_name(char *str, char **p_bus_name,
 	return str_split_by_char(handlestr, p_bus_name, p_dev_name, '/');
 }
 
-static int dl_argv_handle_region(struct dl *dl, char **p_bus_name,
+static int dl_argv_handle_region(char *str, char **p_bus_name,
 				 char **p_dev_name, char **p_region)
 {
-	char *str = dl_argv_next(dl);
 	int err;
 
 	err = ident_str_validate(str, 2);
@@ -1218,10 +1215,9 @@ static int dl_argv_handle_region(struct dl *dl, char **p_bus_name,
 }
 
 
-static int dl_argv_handle_rate_node(struct dl *dl, char **p_bus_name,
+static int dl_argv_handle_rate_node(char *str, char **p_bus_name,
 				    char **p_dev_name, char **p_node)
 {
-	char *str = dl_argv_next(dl);
 	int err;
 
 	err = ident_str_validate(str, 2);
@@ -1244,11 +1240,10 @@ static int dl_argv_handle_rate_node(struct dl *dl, char **p_bus_name,
 	return err;
 }
 
-static int dl_argv_handle_rate(struct dl *dl, char **p_bus_name,
+static int dl_argv_handle_rate(char *str, char **p_bus_name,
 			       char **p_dev_name, uint32_t *p_port_index,
 			       char **p_node_name, uint64_t *p_handle_bit)
 {
-	char *str = dl_argv_next(dl);
 	char *identifier;
 	int err;
 
@@ -1698,14 +1693,24 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 {
 	struct dl_opts *opts = &dl->opts;
 	uint64_t o_all = o_required | o_optional;
+	char *str = dl_argv_next(dl);
 	uint64_t o_found = 0;
 	int err;
 
+	if (str) {
+		str = strdup(str);
+		if (!str)
+			return -ENOMEM;
+		free(dl->handle_argv);
+		dl->handle_argv = str;
+	}
+
 	if (o_required & DL_OPT_HANDLE && o_required & DL_OPT_HANDLEP) {
 		uint64_t handle_bit;
 
-		err = dl_argv_handle_both(dl, &opts->bus_name, &opts->dev_name,
-					  &opts->port_index, &handle_bit);
+		err = dl_argv_handle_both(dl, str, &opts->bus_name,
+					  &opts->dev_name, &opts->port_index,
+					  &handle_bit);
 		if (err)
 			return err;
 		o_required &= ~(DL_OPT_HANDLE | DL_OPT_HANDLEP) | handle_bit;
@@ -1714,7 +1719,7 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 		   o_required & DL_OPT_PORT_FN_RATE_NODE_NAME) {
 		uint64_t handle_bit;
 
-		err = dl_argv_handle_rate(dl, &opts->bus_name, &opts->dev_name,
+		err = dl_argv_handle_rate(str, &opts->bus_name, &opts->dev_name,
 					  &opts->port_index,
 					  &opts->rate_node_name,
 					  &handle_bit);
@@ -1724,25 +1729,25 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			handle_bit;
 		o_found |= handle_bit;
 	} else if (o_required & DL_OPT_HANDLE) {
-		err = dl_argv_handle(dl, &opts->bus_name, &opts->dev_name);
+		err = dl_argv_handle(str, &opts->bus_name, &opts->dev_name);
 		if (err)
 			return err;
 		o_found |= DL_OPT_HANDLE;
 	} else if (o_required & DL_OPT_HANDLEP) {
-		err = dl_argv_handle_port(dl, &opts->bus_name, &opts->dev_name,
-					  &opts->port_index);
+		err = dl_argv_handle_port(dl, str, &opts->bus_name,
+					  &opts->dev_name, &opts->port_index);
 		if (err)
 			return err;
 		o_found |= DL_OPT_HANDLEP;
 	} else if (o_required & DL_OPT_HANDLE_REGION) {
-		err = dl_argv_handle_region(dl, &opts->bus_name,
+		err = dl_argv_handle_region(str, &opts->bus_name,
 					    &opts->dev_name,
 					    &opts->region_name);
 		if (err)
 			return err;
 		o_found |= DL_OPT_HANDLE_REGION;
 	} else if (o_required & DL_OPT_PORT_FN_RATE_NODE_NAME) {
-		err = dl_argv_handle_rate_node(dl, &opts->bus_name,
+		err = dl_argv_handle_rate_node(str, &opts->bus_name,
 					       &opts->dev_name,
 					       &opts->rate_node_name);
 		if (err)
@@ -9902,6 +9907,7 @@ static struct dl *dl_alloc(void)
 
 static void dl_free(struct dl *dl)
 {
+	free(dl->handle_argv);
 	free(dl);
 }
 
-- 
2.41.0


