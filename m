Return-Path: <netdev+bounces-43800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D11997D4D3C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129521C20C19
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD02628F;
	Tue, 24 Oct 2023 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZiLKlpUb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE426286
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:04:17 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8DBDC
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so622734766b.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698141854; x=1698746654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81SBX46mZgSFAffJdzM0cdJyxil5JN/2dUrVLPqnkFY=;
        b=ZiLKlpUbLi+hovxx9oJX0PwVw8FX/IohJye4RIx9mx+pmvwStIsMdtK4LyYwqSu9d8
         6OtB3eted9jUjgSTQkjGUBFgXk8A//DTUn3NIj4l60P69qbQoVWZQdfzxdASI1nTyU5p
         zLA9HY/Q1wOFybx0A5+fF6Jhite6KBSup4+E0HcD+agr+Ji42lUIYSS4nVSuBUZK+VnQ
         I/3c3dRtS4wMTZDB4WmjoDXoeUn/n4q0HrN4VP33c9cqrGiEdLXIWAiGjYTUqGvCYKff
         GOxlNT9C5TP+PfmXr7r5b3m5t6oMAuFhf6xAIXEj9Rbu6BQiKAaOw2t9nuZqb2L2hngc
         +D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141854; x=1698746654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81SBX46mZgSFAffJdzM0cdJyxil5JN/2dUrVLPqnkFY=;
        b=P+IK7w6ZyGy1YTmIq4GqpVbd1vbJ4F/mO+rSZZOLWvW6NixUKtUWJRdeplEJEHGiFd
         EgYGz1R9/bSD6TYWONr1Pzp3IJXO1ysqmNlhkjlwsCLsdfUXKy5aNN3WF13NuRufZtrT
         3ZgJugWjjJPdK3HlGaq7eWdxjAtKGgyhvpU65Pi6VCv2qa5yV8AcrNS3zs/79YPTUSJf
         K51iin73bCoSlauruPrp3q8yVnGW0LUdyzXPOUPXzY4WnmXdInWAlu4yjDvuDCxXTGIF
         qBgnaLvCWzHD4qeiyqe8h0pSsGPfrJahxcvaMHq4B07m/DQRByMq/YvaS5e862yg+wzb
         4hhQ==
X-Gm-Message-State: AOJu0Yxqqc2qYVg7i109UshAbVoaAcu8xWL8QNLDxn65YMjZ2L8GjsMt
	J1VtnmSSaq76rGaDS4oR6WwsABfZIfXBMJn04FjEaw==
X-Google-Smtp-Source: AGHT+IF0sWV1p08fSU6+zDSEsz/vu0zhBPsv+SbMY818HYxWCFWz5VtQebnr5Db7RWbBKe0j0YFuRA==
X-Received: by 2002:a17:907:84d:b0:9c5:1100:9b8c with SMTP id ww13-20020a170907084d00b009c511009b8cmr8739438ejb.56.1698141853978;
        Tue, 24 Oct 2023 03:04:13 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709066bc700b009b9f87b34b6sm7983398ejs.189.2023.10.24.03.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:04:13 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v3 5/6] devlink: print nested handle for port function
Date: Tue, 24 Oct 2023 12:04:02 +0200
Message-ID: <20231024100403.762862-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024100403.762862-1-jiri@resnulli.us>
References: <20231024100403.762862-1-jiri@resnulli.us>
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
index 7ba2d0dcac72..90e8872b07ef 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -772,6 +772,7 @@ static const enum mnl_attr_data_type
 devlink_function_policy[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR ] = MNL_TYPE_BINARY,
 	[DEVLINK_PORT_FN_ATTR_STATE] = MNL_TYPE_U8,
+	[DEVLINK_PORT_FN_ATTR_DEVLINK] = MNL_TYPE_NESTED,
 };
 
 static int function_attr_cb(const struct nlattr *attr, void *data)
@@ -2895,6 +2896,22 @@ static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
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
@@ -4837,6 +4854,9 @@ static void pr_out_port_function(struct dl *dl, struct nlattr **tb_port)
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


