Return-Path: <netdev+bounces-34999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9257A667E
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14D7281EFC
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962933715D;
	Tue, 19 Sep 2023 14:21:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7A1FAA
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:21:46 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27750B8
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:21:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32155a45957so1980415f8f.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695133301; x=1695738101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJGMiysx/JfRAL6iX46WM7AExnXBLd3c6bT4aLtreL4=;
        b=MTHr4gzj/701kE/m/m343/p70qUa2f/7L1HapT5HdqCC8EyNNDzTAIXT7gS5FuIgEo
         iorFMMziRAtbV6o0mfWwt4VOlgbB1IeGuBVc5yeaHu5RnwHpDZ2aRROJqQ1uex19MOH9
         9kh55BPlHkmWJvYjVyVJyxcxal/7tWd/opqmNoyL9t3Xqd58YCyHl/QweBy0OregCMH8
         jBXQCwnEFZlxAbwxO4Ca4iEwHfH90yOpwwPP59yRgojfesHEsGMqxsNphzN86QSo+Z7T
         fFT3j6j6LBOyiEX3v4rX6M+o78+jSsqZl9/DwZtF3mx9sGiImRtAG64VmyhzZ5CO8JFm
         Bx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695133301; x=1695738101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJGMiysx/JfRAL6iX46WM7AExnXBLd3c6bT4aLtreL4=;
        b=nzek5nNIrkPuB9SYF6cJmjP0MgsVwEPCxpf+TDya54nKmfim26H4bXiA/Q0pcZyIUM
         8fLa0E2PyGhA/gaAroVyfm6dJpTNam9K1opoy1TjOAPOtKroKLiRY18So/nbj6OdbUcN
         E8d+kzUyWHmf7cfpptT4xbTZYN5C4b16s+gbZIIMsYEGu3ZKT4xVQhZpf6mbZKFjEyif
         p43ptABDy9EVznh0ZPi5VenxHN6YH/lqJzqyAPZxKL0SVpDiB4eNsJOLE2C6XrtMVylw
         W+qUxriJ8v9o2vyJGL55VgsF/YaS3iNCjXL/en0LyVcPHvckcZrumENhqncooAZ5GwaN
         1X9A==
X-Gm-Message-State: AOJu0YxSkoh4Vgtti1UTtnYcEMJX7mGKQRd92mPQMqhGKE+RJxCKkzoL
	uunGeoANsLhbKpFlG4Va7xRXVJa5o+OrdnGSNqY=
X-Google-Smtp-Source: AGHT+IFZww+99LiqYaFHaXnT4kMy1dhMAiggqBi3uCsB3VqghJzSpovZ5HhcR+WkuArAAe6lcI5PpQ==
X-Received: by 2002:adf:a4c9:0:b0:31f:f9aa:a456 with SMTP id h9-20020adfa4c9000000b0031ff9aaa456mr9767527wrb.2.1695133301430;
        Tue, 19 Sep 2023 07:21:41 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d62c9000000b00317afc7949csm15708239wrv.50.2023.09.19.07.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:21:40 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next] tools: ynl-gen: lift type requirement for attribute subsets
Date: Tue, 19 Sep 2023 16:21:39 +0200
Message-ID: <20230919142139.1167653-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
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

Remove the requirement from schema files to specify the "type" and add
check and bail out if "type" is not set.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/genetlink-c.yaml      | 2 +-
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 Documentation/netlink/genetlink.yaml        | 2 +-
 Documentation/netlink/netlink-raw.yaml      | 2 +-
 tools/net/ynl/ynl-gen-c.py                  | 2 ++
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 9806c44f604c..80d8aa2708c5 100644
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
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 12a0a045605d..2a21aae525a4 100644
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
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 3d338c48bf21..9e8354f80466 100644
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
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 896797876414..9aeb64b27ada 100644
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
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 897af958cee8..b378412a9d7a 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -723,6 +723,8 @@ class AttrSet(SpecAttrSet):
             self.c_name = ''
 
     def new_attr(self, elem, value):
+        if 'type' not in elem:
+            raise Exception(f"Type has to be set for attribute {elem['name']}")
         if elem['type'] in scalars:
             t = TypeScalar(self.family, self, elem, value)
         elif elem['type'] == 'unused':
-- 
2.41.0


