Return-Path: <netdev+bounces-38562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6CA7BB6DE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFC11C20A29
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B4C1CAAA;
	Fri,  6 Oct 2023 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oGGsFxLR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB26F1CA8C
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:44:44 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA6E4
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 04:44:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso3633822a12.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 04:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696592680; x=1697197480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii4gxHizNkBKZ7JHXJWQQOBCTacf6Nj1CsOMRBtICuI=;
        b=oGGsFxLRm5kJ96u+/LspXw+nOinUK5y3Xn+I/5zu3GzsQmk1SD0kZAiO6o6+UDWrfz
         M5q050bYqVPMK3a6DiWR0zln2tTAxu/LQoXsAJt15zePU+uyWXfvvKvhL5Tne1RrTBRq
         R7Ps1MlPL2uHxvWQrWlJsJLLl1rSeZQ7/joiGHvsOgcT7hlP1dHX0y6orMtgTds6jpFN
         5iML8uGrOHB7K6Fxexh4JoZYr+Vn5/di1NsKMNYaQ7mGCyIBUT5WQG5ny4lUyDkc2//+
         rEo9XGiBWoNBP5jc5vLn5Du4iPpvvGJW5QzlJ8CRzvyQuezNZcyYsG1iITrEj92PMOvN
         yuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696592680; x=1697197480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ii4gxHizNkBKZ7JHXJWQQOBCTacf6Nj1CsOMRBtICuI=;
        b=gPFDH+yWob1TGeVhMVs6Dy1/kzcOlZrkSd+0sun3Cf+WazD1skLN8Yk+aKOSkeODuu
         Kd3z/yueX6pvspMRL19EbNEvl2Sg5kIlD6cMO2EEv4fECna8YfmHIwJ2cJR6abM2gTdi
         ZmOctUE9WXdDQJzwwsjiTvVCOyK/yzA4Qq6jYGgYfbgR0HTqjf2cvvunYeQx9D+1unBQ
         MKeUSoVpJf/6eSfCGm4Zv1VSFmn9hWgvb7U5n1U55jUvcu0oRNuM/+cSd/FuHxitXDQU
         yXjmi/gu51qLCuZLUKzCNFv1nlu6IvxI26IuIeX/iTzci2Nfsi4q31LfCPjOdohOcoDJ
         rUVA==
X-Gm-Message-State: AOJu0YwRffm6Ir6d3LA/1hmNAFIluN5M6ybgbh7tGPK5gSXPQG2bU+7g
	RGMRk8aaWtDxquLRABG3VHUk/jUaj96hyhOcGwAiXw==
X-Google-Smtp-Source: AGHT+IGRgNwBRasyhyRxhEvi0biaAyYPA5KZjZxubzlGvRCw6zBX7ZyUue9DLNb7LmESA27oeFpqAQ==
X-Received: by 2002:a05:6402:1257:b0:52b:c980:43f3 with SMTP id l23-20020a056402125700b0052bc98043f3mr7185868edw.28.1696592680295;
        Fri, 06 Oct 2023 04:44:40 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id bm15-20020a0564020b0f00b005346925a474sm2471948edb.43.2023.10.06.04.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:44:39 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	donald.hunter@gmail.com
Subject: [patch net-next v3 1/2] tools: ynl-gen: lift type requirement for attribute subsets
Date: Fri,  6 Oct 2023 13:44:35 +0200
Message-ID: <20231006114436.1725425-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006114436.1725425-1-jiri@resnulli.us>
References: <20231006114436.1725425-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

In case an attribute is used in a subset, the type has to be currently
specified. As the attribute is already defined in the original set, this
is a redundant information in yaml file, moreover, may lead to
inconsistencies.

Example:
attribute-sets:
    ...
    name: pin
    enum-name: dpll_a_pin
    attributes:
      ...
      -
        name: parent-id
        type: u32
      ...
  -
    name: pin-parent-device
    subset-of: pin
    attributes:
      -
        name: parent-id
        type: u32             <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

Remove the requirement from schema files to specify the "type" for
attribute subsets.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- handled in schema instead of py file
---
 Documentation/netlink/genetlink-c.yaml      | 14 +++++++++++++-
 Documentation/netlink/genetlink-legacy.yaml | 14 +++++++++++++-
 Documentation/netlink/genetlink.yaml        | 14 +++++++++++++-
 Documentation/netlink/netlink-raw.yaml      | 14 +++++++++++++-
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 9806c44f604c..32736b2d8ae8 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -142,7 +142,7 @@ properties:
           type: array
           items:
             type: object
-            required: [ name, type ]
+            required: [ name ]
             additionalProperties: False
             properties:
               name:
@@ -215,6 +215,18 @@ properties:
           not:
             required: [ name-prefix ]
 
+      # type property is only required if not in subset definition
+      if:
+        properties:
+          subset-of:
+            not:
+              type: string
+      then:
+        properties:
+          attributes:
+            items:
+              required: [ type ]
+
   operations:
     description: Operations supported by the protocol.
     type: object
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 12a0a045605d..25fe1379b180 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -180,7 +180,7 @@ properties:
           type: array
           items:
             type: object
-            required: [ name, type ]
+            required: [ name ]
             additionalProperties: False
             properties:
               name:
@@ -254,6 +254,18 @@ properties:
           not:
             required: [ name-prefix ]
 
+      # type property is only required if not in subset definition
+      if:
+        properties:
+          subset-of:
+            not:
+              type: string
+      then:
+        properties:
+          attributes:
+            items:
+              required: [ type ]
+
   operations:
     description: Operations supported by the protocol.
     type: object
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 3d338c48bf21..6ea1c947ce51 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -115,7 +115,7 @@ properties:
           type: array
           items:
             type: object
-            required: [ name, type ]
+            required: [ name ]
             additionalProperties: False
             properties:
               name:
@@ -184,6 +184,18 @@ properties:
           not:
             required: [ name-prefix ]
 
+      # type property is only required if not in subset definition
+      if:
+        properties:
+          subset-of:
+            not:
+              type: string
+      then:
+        properties:
+          attributes:
+            items:
+              required: [ type ]
+
   operations:
     description: Operations supported by the protocol.
     type: object
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 896797876414..d976851b80f8 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -187,7 +187,7 @@ properties:
           type: array
           items:
             type: object
-            required: [ name, type ]
+            required: [ name ]
             additionalProperties: False
             properties:
               name:
@@ -261,6 +261,18 @@ properties:
           not:
             required: [ name-prefix ]
 
+      # type property is only required if not in subset definition
+      if:
+        properties:
+          subset-of:
+            not:
+              type: string
+      then:
+        properties:
+          attributes:
+            items:
+              required: [ type ]
+
   operations:
     description: Operations supported by the protocol.
     type: object
-- 
2.41.0


