Return-Path: <netdev+bounces-34948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4797A61D3
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97A728189F
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C794684;
	Tue, 19 Sep 2023 11:57:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8A15BE
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:56:58 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E08EF3
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:56:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so63075865e9.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695124616; x=1695729416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hHBZOs2rf1I/VMlyQcfPqiLybJTaYIhu/DVUyX2Ryg=;
        b=atzk5gQ4AjYrp00gyt24xAKa8PwShm7wgah8eOxBujL438EFbXxYV0VghEM+igGffU
         RiDyEh6QYbC12NsBdl2eNtHSJCEqLXWbwzEjhBHX6i9ZQtYdGonxRj+GfhTjzJdRZxjc
         3C1kB6RN2BE0PmkKcxpFjxx8cXgIKYV2nKQOXwh0LRZAyEdMvmClJ4GMGP1nZZckgqEd
         bERD48sXdnrvL0ZO4B84wlDcK/GiRsBO/eSUfBm2nGv0vFsiZUToUm79f3I2DMPdNXK1
         v909lXDy4HoHgHhB9sOBECzeHileIYJijDerarWl/nKn66QsSGA83T2vIuEO900NDo+n
         FlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695124616; x=1695729416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hHBZOs2rf1I/VMlyQcfPqiLybJTaYIhu/DVUyX2Ryg=;
        b=n1yMp6pgT6lnSX/tLJ2lR0RCQJwDKdRl3YRKFP5Fab9g7WB5w+XyaEIqk5wi86bBMJ
         d2ceq3keObSUaLmf+Vv/QPc7Tr925B+kUYQHJAyMhBIG1qhGqpeHu+w6e1T9bKBQWufB
         cXsBzYDbM8xOhDQCrjELTrbfRbz8VKjaNkwnrLsPgOQAuOo4ICD5fgf/2bH5JbZT28d+
         fuE0V0XvueYdfvcEf8UFKSZMizxbRDMZaNWEz8O2gBNQmNBK8/CGLl6FGB6Vo9h0CqoL
         v+qMvVfL7WYBmcCli2kWARQGCPzPlJlVLjxdIKppqesmXZ8+lbX9/uk7038XtgoMnJYt
         YHQQ==
X-Gm-Message-State: AOJu0YzxZ6Tt4+yoNuXzExDgdiTt9G5+NzE71iyyTKkSj8oVfmrm6osR
	wb0bBUGHfUbG9+XJi8pP3ACQigIFcGdV1jhYo1I=
X-Google-Smtp-Source: AGHT+IEVZ+kXQOgV7hpXTpISZp+PVU4vCGR2hMmYiFnP15akH53v5zbSS/KIJoWVUmOrwlkkhgXmFg==
X-Received: by 2002:a05:600c:3b97:b0:405:1c14:9227 with SMTP id n23-20020a05600c3b9700b004051c149227mr807279wms.33.1695124616119;
        Tue, 19 Sep 2023 04:56:56 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t7-20020a1c7707000000b003fedcd02e2asm15100502wmi.35.2023.09.19.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:56:55 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v2 4/5] devlink: print nested handle for port function
Date: Tue, 19 Sep 2023 13:56:43 +0200
Message-ID: <20230919115644.1157890-5-jiri@resnulli.us>
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

If port function contains nested handle attribute, print it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index cf5d466bfc9d..b30e4fd8e282 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -772,6 +772,7 @@ static const enum mnl_attr_data_type
 devlink_function_policy[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR ] = MNL_TYPE_BINARY,
 	[DEVLINK_PORT_FN_ATTR_STATE] = MNL_TYPE_U8,
+	[DEVLINK_PORT_FN_ATTR_DEVLINK] = MNL_TYPE_NESTED,
 };
 
 static int function_attr_cb(const struct nlattr *attr, void *data)
@@ -4830,6 +4831,8 @@ static void pr_out_port_function(struct dl *dl, struct nlattr **tb_port)
 				     port_fn_caps->value & DEVLINK_PORT_FN_CAP_MIGRATABLE ?
 				     "enable" : "disable");
 	}
+	if (tb[DEVLINK_PORT_FN_ATTR_DEVLINK])
+		pr_out_nested_handle(tb[DEVLINK_PORT_FN_ATTR_DEVLINK]);
 
 	if (!dl->json_output)
 		__pr_out_indent_dec();
-- 
2.41.0


