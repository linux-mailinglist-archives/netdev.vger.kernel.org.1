Return-Path: <netdev+bounces-44710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C447D94ED
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F24B21500
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249418AE4;
	Fri, 27 Oct 2023 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dp7QUkX0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B8182BB
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:14:19 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AB31AC
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso266868366b.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698401656; x=1699006456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/tu5XWHHR8usb5Jk8v5P3g4yLTlyEOFPX8/M/aZHvs=;
        b=dp7QUkX0FwHzkhbyKlAwAtXIgbnXH6o1ehQu/MaCcuum4ciQXqedSA8MmjhmJ4/lW7
         aVA9KcqBlHxUdY67p+Jk/NDrbOFrrzKRC90WhotXSW+iGNbSPMK4set+7I9Gq8N+dIa+
         65hfrGJ+3ECyy2ZpxuGGN/ufcxg6VH30VvtHqDF9T5twrq5Bhd1LuO0LojXKXUsUxFr4
         1lOnkNP55lnA4XdYteaEJTb8soDH975pvAHR6Prv3DHUkCbDFYyiXMJDTnpARrf118u2
         ZLbG7BA7dDWNYnKDu5LRnIwCWRLTM7JiJeIjvhgCTxmSe4/BiGbruuMriHnJ7fR57M32
         AMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401656; x=1699006456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/tu5XWHHR8usb5Jk8v5P3g4yLTlyEOFPX8/M/aZHvs=;
        b=igfjTMj09Brg7M460pgmUSiaUjOUhMjjda6bMBevJU3mW0WiBoa1dNMXCUKXt+ZXNd
         sM+lKvQAxiAOWt0u/EdVcvZGyE5Ib9Ix4yFyMjdJTLu5dnFs/4qtK/Gcri9RDs6DRAr4
         LNuwT4xSO7sI6e/2U/Ttt54aTjZhOZbhcdWxiaMynHZysbswirqopgXTb6CjPWjnS6lN
         zfsNGGycFI/4oueyzplKMB1WEF+zWN0OAFjdkC0hSezEDUdQ2HdcD8ngMUKuqeHeyQ7l
         QkEk5OBm6p1f2NvaLSfrSVW9jybL7mqA08rJ6F4Ak9jdZfpBquz/VcKvfe7kOJcDMFYm
         cR+g==
X-Gm-Message-State: AOJu0Yxb5gBxgcEW/WF9a9XFQQ/qP92cP5AFVPPKFO8+TkK5Rnqpb8OJ
	tbcW/wmYFti+Rkkv2QWXUprsUxNAvLUesrp9k9xX/Q==
X-Google-Smtp-Source: AGHT+IFrp+nR/Itr9VaIcjK2yyMjgJCNyY6AH0G6u9MOqOBDS6VAk0xjpgqMQaBzUoDj70dHzbsygA==
X-Received: by 2002:a17:907:3ea9:b0:9c5:45f8:c529 with SMTP id hs41-20020a1709073ea900b009c545f8c529mr2076606ejc.20.1698401656430;
        Fri, 27 Oct 2023 03:14:16 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id cw23-20020a170906c79700b009c3828fec06sm943856ejb.81.2023.10.27.03.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:14:15 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch net-next v4 6/7] devlink: print nested handle for port function
Date: Fri, 27 Oct 2023 12:14:02 +0200
Message-ID: <20231027101403.958745-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027101403.958745-1-jiri@resnulli.us>
References: <20231027101403.958745-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

If port function contains nested handle attribute, print it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- rebased on top of new patch "devlink: extend pr_out_nested_handle() to
  print object"
---
 devlink/devlink.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index f276026b9ba7..ae31e7cf34e3 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -772,6 +772,7 @@ static const enum mnl_attr_data_type
 devlink_function_policy[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR ] = MNL_TYPE_BINARY,
 	[DEVLINK_PORT_FN_ATTR_STATE] = MNL_TYPE_U8,
+	[DEVLINK_PORT_FN_ATTR_DEVLINK] = MNL_TYPE_NESTED,
 };
 
 static int function_attr_cb(const struct nlattr *attr, void *data)
@@ -2896,6 +2897,22 @@ static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
 	__pr_out_nested_handle(NULL, nla_nested_dl, false);
 }
 
+static void pr_out_nested_handle_obj(struct dl *dl,
+				     struct nlattr *nla_nested_dl,
+				     bool obj_start, bool obj_end)
+{
+	if (obj_start) {
+		pr_out_object_start(dl, "nested_devlink");
+		check_indent_newline(dl);
+	}
+	__pr_out_nested_handle(dl, nla_nested_dl, true);
+	if (obj_end) {
+		if (!dl->json_output)
+			__pr_out_indent_dec();
+		pr_out_object_end(dl);
+	}
+}
+
 static bool cmp_arr_last_port_handle(struct dl *dl, const char *bus_name,
 				     const char *dev_name, uint32_t port_index)
 {
@@ -4839,6 +4856,9 @@ static void pr_out_port_function(struct dl *dl, struct nlattr **tb_port)
 				     port_fn_caps->value & DEVLINK_PORT_FN_CAP_IPSEC_PACKET ?
 				     "enable" : "disable");
 	}
+	if (tb[DEVLINK_PORT_FN_ATTR_DEVLINK])
+		pr_out_nested_handle_obj(dl, tb[DEVLINK_PORT_FN_ATTR_DEVLINK],
+					 true, true);
 
 	if (!dl->json_output)
 		__pr_out_indent_dec();
-- 
2.41.0


