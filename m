Return-Path: <netdev+bounces-43227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520BF7D1CD1
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A6B21552
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54591DF63;
	Sat, 21 Oct 2023 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hLQ3iCUR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7CFC13
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:27:25 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC22D67
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9becde9ea7bso592374466b.0
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697887638; x=1698492438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZshBnGVoh1JZ8w5Eh4vOVzn5wmfkWpBLxOOGKLNfaB4=;
        b=hLQ3iCURLUVFfXGBCL/RXOb9FgdaDjy8IfaEG1y10r7utWyQp3B4zfv/zjddO69+4P
         DSGHUbWfkaO56Hqgc1nDbG5ThPnB84DwHBJ0c+gEcuukvWdyU6YTs829UKBCKRV7TLfx
         RQKEgSyOJxgoph5kC5Si+Vzelxil4XeISrXQqUCChvwsIERFETozNA+Egj5M58/kfsMR
         zMJ1855WGhMZ0VgBYu9UY+WE7DwOodceJpHsYsFtVne7DkQ83Lorm0r7hauqtD77gLIz
         x9d8G5M77fD+wj35TuaukpI0MamzSB7ZtOvGH2qqxF4JMCJDJnUZHS9hdEJ5BB6RNIfh
         70OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697887638; x=1698492438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZshBnGVoh1JZ8w5Eh4vOVzn5wmfkWpBLxOOGKLNfaB4=;
        b=sjoia9m3qCjRmLk5wbU5Ff5OhjtKSU5CetzZaoNCNLoAFWEMqHyBrVmbHmGecsQAI4
         xCLUAGK0Agb9yrhnLIeTo8lxI4EPE1Ax9Qvf45//k8gSx62MsC7eZdX0S4FXCrimD9TD
         OrSFVYAKMTtNqJDXNCRF2h86JoDRmua7/eVguwUenXdxhtCax3xpDKwd26VU95VfSBkp
         S6tUXA9phA/Dy32QpXzsTeDeB/o9YC7CKGQE2wYeerOkE7wv8YZK0O61AEBTAL0JbHV+
         x9nHQPR7Xh1SLkftn5/ihiNZIdPiW6tWiJwe0AXTyaQgn1Rg1Baotsgydu8ZKNlsWLZs
         J6hw==
X-Gm-Message-State: AOJu0YzhHw4wtV8ia2AehzoecXn9FpUtvPrTn3I3A17+fNanXJCsKTrL
	0pl4+BsiK3DCR7ryLZEnt78vJ50XrG4tDDKEJW8=
X-Google-Smtp-Source: AGHT+IH3JW+y99LZzJKc54b/nh2rXkXnSPocWGvxDsfiqjwr0uvOhvxsJtKco7qhuCfQphw0xiJirA==
X-Received: by 2002:a17:906:fe06:b0:9a9:f042:deb9 with SMTP id wy6-20020a170906fe0600b009a9f042deb9mr4069595ejb.19.1697887637996;
        Sat, 21 Oct 2023 04:27:17 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709064e4300b0099b76c3041csm3469473ejw.7.2023.10.21.04.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:27:17 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v3 03/10] tools: ynl-gen: render rsp_parse() helpers if cmd has only dump op
Date: Sat, 21 Oct 2023 13:27:04 +0200
Message-ID: <20231021112711.660606-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231021112711.660606-1-jiri@resnulli.us>
References: <20231021112711.660606-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Due to the check in RenderInfo class constructor, type_consistent
flag is set to False to avoid rendering the same response parsing
helper for do and dump ops. However, in case there is no do, the helper
needs to be rendered for dump op. So split check to achieve that.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 tools/net/ynl/ynl-gen-c.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 7d6c318397be..ed35a307c960 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1112,10 +1112,13 @@ class RenderInfo:
 
         # 'do' and 'dump' response parsing is identical
         self.type_consistent = True
-        if op_mode != 'do' and 'dump' in op and 'do' in op:
-            if ('reply' in op['do']) != ('reply' in op["dump"]):
-                self.type_consistent = False
-            elif 'reply' in op['do'] and op["do"]["reply"] != op["dump"]["reply"]:
+        if op_mode != 'do' and 'dump' in op:
+            if 'do' in op:
+                if ('reply' in op['do']) != ('reply' in op["dump"]):
+                    self.type_consistent = False
+                elif 'reply' in op['do'] and op["do"]["reply"] != op["dump"]["reply"]:
+                    self.type_consistent = False
+            else:
                 self.type_consistent = False
 
         self.attr_set = attr_set
-- 
2.41.0


