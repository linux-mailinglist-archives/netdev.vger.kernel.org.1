Return-Path: <netdev+bounces-25413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8693773E78
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E843E1C20BA6
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F4414A86;
	Tue,  8 Aug 2023 16:30:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E771989B
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:30:45 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063EED4BE3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:30:28 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-99c93638322so3638666b.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691512208; x=1692117008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rboElf/BVI2bc3A5WovY2cK4t5A5anr+6YjghXJ6T/I=;
        b=a90BiLmFG3sYlSbJ++1THe2SrdqdmA8ilBdv2KVlcSCjxlI3DXPatsDo0Zp8GbhdT2
         qla6QAHyD8VyFS8Bk2YEqoil8xRt/6cx/sAvm91FWSUOoTR9U84eLkCFWMLBGDBRcvZY
         5wNd0o5UHBOmEqNmz8i721wVvCBhACmcincl+b++1VDEMq6RgFCS5PLSbh2nHDVn1GJH
         iPGe2sayjU2nar90NW6Gw4nV0zbopflab+iYnV+OBbcoFfU4qXa/j1a2MxQ1ydPgtpzN
         e/XfQ2RYWAeBjvHzkVanmkQtkgFmv9fGQRNVVtFSgdbsobY0Fi6JcBEiQ8sVxg+kbjuL
         0WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512208; x=1692117008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rboElf/BVI2bc3A5WovY2cK4t5A5anr+6YjghXJ6T/I=;
        b=FM9+lWmAeQyYEXTlTk1r1Y92DooNeVgQosX4RLK2git6hAM/yzKPu1rW05IawoXkt+
         JuASbE4xsybBKT0Co0iKgms+Zumdb1wjVVrlGNGEeWu7SNRlWsTxi+Mn82080k4QQn2P
         SEyTM5lcmPupJ5wskMF+xOOOlIEPP/QG+oUBlklMlyFzMiKCGv9EzXMmiqzTahRsxs3g
         IAdMXp47aMzuZkvrO2U6s7gY1RTL3WEYQ+Etc80XosGbnXg9wqAxe3MK53YCtJl2ypuf
         pTmv/S1ZdQRvyqvTgFp9Zn4WLO9W+DoBLWsnTcVbaK1R1fx+fRobNnrjxvqN8SXzSBok
         OG8A==
X-Gm-Message-State: AOJu0YxP9sVJuLQxNX8fJCldMVK84wvybBbRPbmu4ydtRN3Xw5815bck
	c8triMAXAYhcTRJDcNU0uD3NDH29Vs5gianhVhhJgZW01i4=
X-Google-Smtp-Source: AGHT+IG8QmO1vMNrgxAHbE9HRffpYK/5oXTWBdoPWU3/u5EHF1MovgR+2EUUpq/0rKo2JilVYz98Zg==
X-Received: by 2002:a5d:6ac5:0:b0:317:6570:afec with SMTP id u5-20020a5d6ac5000000b003176570afecmr7711119wrw.3.1691485426111;
        Tue, 08 Aug 2023 02:03:46 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d5483000000b0030ae53550f5sm12916742wrv.51.2023.08.08.02.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:03:45 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next] ynl-gen-c.py: avoid rendering empty validate field
Date: Tue,  8 Aug 2023 11:03:44 +0200
Message-ID: <20230808090344.1368874-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

When dont-validate flags are filtered out for do/dump op, the list may
be empty. In that case, avoid rendering the validate field.

Fixes: fa8ba3502ade ("ynl-gen-c.py: render netlink policies static for split ops")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/ynl-gen-c.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index e64311331726..6b9d9380a6ab 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2000,9 +2000,10 @@ def print_kernel_op_table(family, cw):
                             continue
                         dont_validate.append(x)
 
-                    members.append(('validate',
-                                    ' | '.join([c_upper('genl-dont-validate-' + x)
-                                                for x in dont_validate])), )
+                    if dont_validate:
+                        members.append(('validate',
+                                        ' | '.join([c_upper('genl-dont-validate-' + x)
+                                                    for x in dont_validate])), )
                 name = c_lower(f"{family.name}-nl-{op_name}-{op_mode}it")
                 if 'pre' in op[op_mode]:
                     members.append((cb_names[op_mode]['pre'], c_lower(op[op_mode]['pre'])))
-- 
2.41.0


