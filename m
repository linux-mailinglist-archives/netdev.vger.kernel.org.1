Return-Path: <netdev+bounces-30599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B457882C2
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F551C20F72
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A556D2EB;
	Fri, 25 Aug 2023 08:53:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1BD2E9
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:53:50 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47C81FD4
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so998255e87.3
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692953627; x=1693558427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsg1Dl28Trm7HwC5JE4oqtOd3hQO3PKwmc1tCz45ibM=;
        b=l/AoYbC/m2+aqet7vN1GSdKrqoyY8wT2bBZxoo8YIXIDK8G5j7d2n3kde9Bjh1FfvN
         nZoKPamlo+FCnKhpIs5ec7nQ+pcJJXi8hbwfU2v6LhAKK7Xf+UJVWzUx64fR9b1whgvc
         e9hbRr3pe/31EcDseYTtyBjW8NbTedu9msiyEZzSK7QBeXv+X/J/N3bALUKMBE1Gzw+n
         RRGV29Db9U4KTUyNDF/D4vhgxxsrj7W8zhY8A+YelAcN7vm7tIklCpD/Hkp4yXqAP4w/
         WD51yCLvpEdPyBgaXBqde6WPNEFr/V1Z/0ypvQSn+mQIoDfvGmVNQPUAEkFHfwCKS+jE
         Ui8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953627; x=1693558427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xsg1Dl28Trm7HwC5JE4oqtOd3hQO3PKwmc1tCz45ibM=;
        b=cH6BhpYwkIjv55ywWTA2Ij5Nmy9rZ8HhtcBAq4Vi1iwEwybPx8t8zN6MiGC8v9AzXH
         sTz58AZ6hmCgwnZwDlJr/e/i15h2+PL6rJF8xxDIKbNBfnDnIQoShoBDtTNQqsKbYOb+
         DWd+R7kKmtkbF0+GugzYs2qN3sOpYdjtF1OSxMYM8+BRDdzewEcIOMdsswE7n8EBgDMW
         sv1KTtL2rLSJMnh8LV3Q/m3xFKZeerCvnM7hiW7wnLou8SSdtFmd848DuyFu9OGgTvwI
         B4gMVLBww0pbEOOXnoyh+HVT1FEx0C12HhnIRGWS+W7bGt7v0d/fMDrQgZnmKjDrCYeo
         a7Pg==
X-Gm-Message-State: AOJu0YwnYnut2LtE6IMwF/ek6g9Z1v1idBrpfnpgULvHx+VTj+82eO3W
	OhHdkdljL+tk00OZxF9QhbrIVbNnDm4ne+KIOv4ygyWK
X-Google-Smtp-Source: AGHT+IHjFWDvIqMjQqZhgp6/AYj/xa79r9sji30xvdmgIkJqhejmWWYoUXlDiK3zLBrfJKeFeMBCPQ==
X-Received: by 2002:a05:6512:ac4:b0:4ff:8d7a:cb20 with SMTP id n4-20020a0565120ac400b004ff8d7acb20mr16734439lfu.63.1692953627179;
        Fri, 25 Aug 2023 01:53:47 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id a14-20020a5d508e000000b0031ad2f9269dsm1595640wrt.40.2023.08.25.01.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:53:46 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next 13/15] devlink: move tracepoint definitions into core.c
Date: Fri, 25 Aug 2023 10:53:19 +0200
Message-ID: <20230825085321.178134-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825085321.178134-1-jiri@resnulli.us>
References: <20230825085321.178134-1-jiri@resnulli.us>
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

Move remaining tracepoint definitions to most suitable file core.c.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/core.c     | 6 ++++++
 net/devlink/leftover.c | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index c23ebabadc52..6cec4afb01fb 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -5,9 +5,15 @@
  */
 
 #include <net/genetlink.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/devlink.h>
 
 #include "devl_internal.h"
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwmsg);
+EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwerr);
+EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
+
 DEFINE_XARRAY_FLAGS(devlinks, XA_FLAGS_ALLOC);
 
 void *devlink_priv(struct devlink *devlink)
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 98ccb3a8393d..a477cdbab940 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -28,15 +28,9 @@
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <net/devlink.h>
-#define CREATE_TRACE_POINTS
-#include <trace/events/devlink.h>
 
 #include "devl_internal.h"
 
-EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwmsg);
-EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwerr);
-EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
-
 const struct genl_small_ops devlink_nl_small_ops[40] = {
 	{
 		.cmd = DEVLINK_CMD_PORT_SET,
-- 
2.41.0


