Return-Path: <netdev+bounces-23981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBB176E689
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7D01C2144F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6061918AFC;
	Thu,  3 Aug 2023 11:13:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DFD18C07
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:13:53 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3696EA
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:13:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98377c5d53eso116647066b.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061228; x=1691666028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgMU1yzae+eZsxN9OmMX2LlMkJLp377FcEFSc7ndUY4=;
        b=RUsTGIyj0lpOY54vIDhfIFe1XXNN4TlmBDue7rTZWHF7t3/afIBvzWGEAmIkvw297q
         LGXlv1X6LSfKhTvaLNHQm+0JgoBBAQ+6NzUgc3WPpWSN2lf0Rr1QJBwkEujmj21FyOq+
         Q79sxGjRTbLrLhkqU9Jl9Bu0Rs6htOfBOsCLF9WYjIMMLD8cPBkXRwoqDu3WHriWXgUa
         7/plD0xgVa/PfDBLDvW2k+7onAHscMgI1KuqpFLHGo+ozX5Z9lTbUa2epcKShLV6UxAq
         yihAuZGP0LOElx6UoLdinNsZOpZjiBvPR6Yn1ELpVU/tm8sJJD4C8erOvXX6qpNRynVg
         NC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061228; x=1691666028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgMU1yzae+eZsxN9OmMX2LlMkJLp377FcEFSc7ndUY4=;
        b=I1yUnePrT8l1dG8waZ2X7GdMkm9WZeRzJy8cdiLOcR56DTjBx8NiJ4y7H3Jb86cRLm
         sjEvyxeUBGmupGNOgmorCrevubaMjHlR9zQ7IivtTC+lU/1jl3re2na5IqiHE96aDBpy
         A6LCt5kYBRXHxJbhAiMI5c6qEgZ0xrjbFaWUcZjBiP6L2xuE2Wn9HUlj3d0IyBgXiIwq
         Fsw3rUfHl2TN6ZOG3ltcdriUTOWiIZq/YpODP0PLhYXiaTIVIHV/hPd+LdZgnYW2fBda
         QMvGrGiJv/paSHTEiXXXnOE/6F6W2gvgG5ODf+FBMm10G/o+jb4VHePxFIcU7PdPOtJ0
         sO+A==
X-Gm-Message-State: ABy/qLaH4WEwKK15l3Z652IYjU1mKMcPNkNYs5LeIC7EQs6fduvbYX/n
	e8uS0t5WdFWP+K2n5IvOmew8C8TcDSsILxeM6BWp6g==
X-Google-Smtp-Source: APBJJlH5zWdVn74PkMJXTo+L+lxCagAkG83pl499njPo1MPJ9KQKSLqYeKa9Dm06x7HCa1Ri4oGN4A==
X-Received: by 2002:a17:907:2cd1:b0:99b:4908:1a6d with SMTP id hg17-20020a1709072cd100b0099b49081a6dmr6922991ejc.52.1691061228150;
        Thu, 03 Aug 2023 04:13:48 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709063c0800b0099bcbaa242asm10441322ejg.9.2023.08.03.04.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:47 -0700 (PDT)
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
Subject: [patch net-next v3 04/12] ynl-gen-c.py: render netlink policies static for split ops
Date: Thu,  3 Aug 2023 13:13:32 +0200
Message-ID: <20230803111340.1074067-5-jiri@resnulli.us>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

When policies are rendered for split ops, they are consumed in the same
file. No need to expose them for user outside, make them static.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 tools/net/ynl/ynl-gen-c.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 2ea6af892b68..e64311331726 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1843,13 +1843,13 @@ def print_ntf_type_free(ri):
 
 
 def print_req_policy_fwd(cw, struct, ri=None, terminate=True):
-    if terminate and ri and kernel_can_gen_family_struct(struct.family):
+    if terminate and ri and policy_should_be_static(struct.family):
         return
 
     if terminate:
         prefix = 'extern '
     else:
-        if kernel_can_gen_family_struct(struct.family) and ri:
+        if ri and policy_should_be_static(struct.family):
             prefix = 'static '
         else:
             prefix = ''
@@ -1877,6 +1877,10 @@ def kernel_can_gen_family_struct(family):
     return family.proto == 'genetlink'
 
 
+def policy_should_be_static(family):
+    return family.kernel_policy == 'split' or kernel_can_gen_family_struct(family)
+
+
 def print_kernel_op_table_fwd(family, cw, terminate):
     exported = not kernel_can_gen_family_struct(family)
 
-- 
2.41.0


