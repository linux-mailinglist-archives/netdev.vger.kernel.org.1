Return-Path: <netdev+bounces-40690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22197C856A
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72EB4B20B45
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B2617740;
	Fri, 13 Oct 2023 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tDZPaNpT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412CA15EB4
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:10:46 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8260BE
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:44 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4054f790190so23311925e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697199043; x=1697803843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXSuLugNfkeM0OlmIJX1tWHroCO72P+V4QE7EVi+a2E=;
        b=tDZPaNpTbvUZb+8xBgXOkjd7yDqQ2sBOqyzj7KPv/4Pm3hTryCjgM3RMZ+Y9qtoycl
         qf5LY7dokAj7e4FZX47vkk3K5H1J5rCvfykGaKkvcXWREqB4vKCusCDy+9y0b1/RCSMc
         J6oqIBNTbO57yhaMa2kNCKjQagd1pOIV4jWzpwazvGWbdclT4zLDWAy+9qFbQKkiT7pn
         5sdroKMDjaSwWaURl7YOqW04oxen+Z6gVhUkUHFaSI9qaF9TWQun86LETsktTdoMRHnZ
         TZIv0JX6vZsTzwspZS+psasCDOuSwBjDNo8b8ivKXTgq/v56CZV9Y/4Ex+OU8uaPSXxS
         K6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199043; x=1697803843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXSuLugNfkeM0OlmIJX1tWHroCO72P+V4QE7EVi+a2E=;
        b=PrHRuBxW1inkt0CvOD5AaORPBo4AVGp0pac3eUgNRHDAnKQ965DxLy4Zi9Me5RuM2+
         p4xw6suWMe1PI+cXQW/72wauYU8aAQuPLzpUTD4DowvXxdm31UqRPog8dIPkEkACGIww
         vWBttDY6VLuU2KpAztdRZ4XEx/5SSfHHLzq64Om+vWZg5J4lXPgteou2ZTlus+TwrQnf
         2E2k0zMAB22uVYjndYOeKmNcz/3GkLxwRUBtPDYixyCm6X6kIawMLzRZom+XO7FmJtfo
         HvyDYyP271l5QqF69GcGt9DLdNSC1+AbI86VUnjHxVabju7fQeSZCJaaIx1ymHXcQU2n
         EUzg==
X-Gm-Message-State: AOJu0YwpVge+4tIXy0qD4qQimBl1Gfr+1w4Kt3GiSk2jiZMRjnmcUZUI
	dCwXlaX8tvnD4xaHulzl8RVbDx7n8r/0+7WL6sI=
X-Google-Smtp-Source: AGHT+IEeda9rrgeXXOzXP13TbNgNFq/sydyNmXcPrjgy8JUZnNOY1SaIKc/+Txgg8FbLdTxBruH44Q==
X-Received: by 2002:a7b:ca57:0:b0:405:34e4:14cf with SMTP id m23-20020a7bca57000000b0040534e414cfmr24086982wml.4.1697199043329;
        Fri, 13 Oct 2023 05:10:43 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c469300b00407752f5ab6sm1100441wmo.6.2023.10.13.05.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:10:42 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v3 7/7] devlink: document devlink_rel_nested_in_notify() function
Date: Fri, 13 Oct 2023 14:10:29 +0200
Message-ID: <20231013121029.353351-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013121029.353351-1-jiri@resnulli.us>
References: <20231013121029.353351-1-jiri@resnulli.us>
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

Add a documentation for devlink_rel_nested_in_notify() describing the
devlink instance locking consequences.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 655903ddbdfd..6984877e9f10 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -168,6 +168,20 @@ int devlink_rel_nested_in_add(u32 *rel_index, u32 devlink_index,
 	return 0;
 }
 
+/**
+ * devlink_rel_nested_in_notify - Notify the object this devlink
+ *				  instance is nested in.
+ * @devlink: devlink
+ *
+ * This is called upon network namespace change of devlink instance.
+ * In case this devlink instance is nested in another devlink object,
+ * a notification of a change of this object should be sent
+ * over netlink. The parent devlink instance lock needs to be
+ * taken during the notification preparation.
+ * However, since the devlink lock of nested instance is held here,
+ * we would end with wrong devlink instance lock ordering and
+ * deadlock. Therefore the work is utilized to avoid that.
+ */
 void devlink_rel_nested_in_notify(struct devlink *devlink)
 {
 	struct devlink_rel *rel = devlink->rel;
-- 
2.41.0


