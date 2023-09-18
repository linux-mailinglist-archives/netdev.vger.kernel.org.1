Return-Path: <netdev+bounces-34532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B887A47AC
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526801C2099C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2EB1C2AC;
	Mon, 18 Sep 2023 10:54:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B614AB3
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:54:54 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D5C129
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 03:54:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so538610166b.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695034463; x=1695639263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKd06wBuxPIH0zq8nwAImCSv1mwa2d7HOT+ZZ81oxZQ=;
        b=gINrMPpaLXJWiVUh5m+9sC36fvA7HviLBDhIc0bQgIN4qU4/BPWwEXFMpwi2rIGGyL
         Avn2RPwCeHCycaZ1rtU4KDV+ViCSJwlziChEaZFC/BsbU9inzPUf/Q8ds94KoBdhVO9h
         g6xjK7tA/Ua/qYG7San9Dd7AFCFniRCH+je/fMRloV4TiTknCC4hPOjc26JMtCo5dC9E
         y3r9Pay2w+lvWER+ws7KBN4T9PKMIeWbkwVoDgT6CwqNCueh7H9gSA/upgaDHnLK3l22
         wMdRnZR7uBJO8s43Ko/KsAZAqVBMUKid2KxCDECHPhgtiEKqKlmX912IpYhFWTayUrjm
         g4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695034463; x=1695639263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKd06wBuxPIH0zq8nwAImCSv1mwa2d7HOT+ZZ81oxZQ=;
        b=dqgvLHW3/6fscaEMBFOcoWDb8jc7P78957os0VLtM5fxui7JTdtwmVa2OwyQbqJ1cH
         rdxCKpxz6IObi8v4FY4ztTnWE8za99IzyuMoyEIjQQsgvFrQFD9QpIrjdzbPKF8Ejbfj
         GiE3ycpssoJFhFFM4DGrtqfVx9N2rqsmdZYbUVOZJ/o7+c1b6PTSQ2vRLtmZ/LvFZ1SS
         2pvb5/lvqdPfG5oA/cGmP7E5o5GqGcCB/o2iQWC2EpzEK0BK5Ibli6pi8x06KuAWI5FY
         BoIl/teysvrWjh12Ph9dBcpmedpdXuO5KF2S9IjZd+7dClsdThZjq5T9LDGwsCmNU/w0
         b7PA==
X-Gm-Message-State: AOJu0YxdAeIrQVxFJgpdLnVIYSoR9WiONL6+VqOAE6ByVjCWgGXn+p0r
	i8DylTpR6Pv+ynm4zE1WzkQtLZM1NzJ7nZ/r7as=
X-Google-Smtp-Source: AGHT+IHbmK7PmlWEZGUuKIqXF1NL/Q/8wqB8riFsOVMRiGKzCQjQENJ8ISDjYQxb8XvRRWcoZvqINw==
X-Received: by 2002:a17:907:75cd:b0:9a9:dfbe:ca98 with SMTP id jl13-20020a17090775cd00b009a9dfbeca98mr7442942ejc.7.1695034462988;
        Mon, 18 Sep 2023 03:54:22 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id qb18-20020a1709077e9200b009adc5802d08sm5346503ejc.190.2023.09.18.03.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 03:54:22 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next 3/4] devlink: print nested handle for port function
Date: Mon, 18 Sep 2023 12:54:15 +0200
Message-ID: <20230918105416.1107260-4-jiri@resnulli.us>
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

If port function contains nested handle attribute, print it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 31dd29452c39..8ea7b268c63c 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -772,6 +772,7 @@ static const enum mnl_attr_data_type
 devlink_function_policy[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR ] = MNL_TYPE_BINARY,
 	[DEVLINK_PORT_FN_ATTR_STATE] = MNL_TYPE_U8,
+	[DEVLINK_PORT_FN_ATTR_DEVLINK] = MNL_TYPE_NESTED,
 };
 
 static int function_attr_cb(const struct nlattr *attr, void *data)
@@ -4875,6 +4876,8 @@ static void pr_out_port_function(struct dl *dl, struct nlattr **tb_port)
 				     port_fn_caps->value & DEVLINK_PORT_FN_CAP_MIGRATABLE ?
 				     "enable" : "disable");
 	}
+	if (tb[DEVLINK_PORT_FN_ATTR_DEVLINK])
+		pr_out_nested_handle(tb[DEVLINK_PORT_FN_ATTR_DEVLINK]);
 
 	if (!dl->json_output)
 		__pr_out_indent_dec();
-- 
2.41.0


