Return-Path: <netdev+bounces-57772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939DA8140CA
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E552CB22387
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F556AA1;
	Fri, 15 Dec 2023 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciln9y+L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AA63B3
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35d699ec3caso1173095ab.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702612231; x=1703217031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ebRYn80GeI0I+Bf9371cquYVsJoASn0dK7Bgzmo/CE=;
        b=ciln9y+LtJWH4dGvpMGhKFEeYq3h15FOmhCw/H/3SqZjiqdbxu2sB40rN0vwAEqpbe
         tJAy18SAxPNqv+mxQqJ+eda/DqEZoGfCqEOVn5nw62MLy69Fm7NsbMrSZyHZ+RaBn/A3
         96UsSCxB8Hn+MEt2SEx1SyvgUAhuYWROCG1dsbrY068Wxvt4ckF+05o1ni487+7ytHAP
         G2BwUculh3uR+NjEgxkAcOC6hOiJAc6QRvKS8I5M0W6LDOpR2lYasCEBXz3nchwONUMV
         zF0BeQUYW+b7YZ/r34uYZ7nx59KsTByCmgRi+38A74OJU6BJhbBUrTbHIPaPYYDdWQgP
         8k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702612231; x=1703217031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ebRYn80GeI0I+Bf9371cquYVsJoASn0dK7Bgzmo/CE=;
        b=NE+pze6hXKVTdc+B4oM53HaIbUg/SipjaFr8GvVw92KQlUv5tnakRXDHTDsya6Myyi
         Z93vn5kt7g5GL5wCNnh0aPJrDfiOSKWvNJcYMIykroiJmX4cEZdFy2NoOG4UV2fUqIum
         eDfSDpSvDHPhy+RkrLisyVODmZ+tiLZxJuQRsayBJ7m4yQlxK75g3OlNcpwtgwCS3VzO
         UL9JbM8hh/Ns+FNVtPQpp46J1j4il6xfZP4qqHsJb8qswyLPNCsAHyzTpfxl906mWYsm
         PxdGX9fOu7Edu5tHf+ARnGaSuBG98kweIfYv8iX7Vgor2MF6wKbir0FXBBdP7E6YwOmd
         lUQQ==
X-Gm-Message-State: AOJu0Yyq/ZhTPeBvQJhblyK8K0qifL3xDCj30RFh7w/c1rPRP/5t8anF
	DIdvVxClge1WjLEFS3Vt6O25Gdj1rFQoFCQWMSc=
X-Google-Smtp-Source: AGHT+IF1+FUYoF3/g/4J2FuUD5pQwkTcD3G4WdvQ9pTx1y9dSwDt2VJiC/AxlSFaEyNLg6qh7LUSyg==
X-Received: by 2002:a05:6e02:2167:b0:35d:55d7:6c96 with SMTP id s7-20020a056e02216700b0035d55d76c96mr15476334ilv.12.1702612231564;
        Thu, 14 Dec 2023 19:50:31 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001d06ca51be3sm13124483plf.88.2023.12.14.19.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 19:50:31 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 2/3] tools: ynl-gen: support using defines in checks
Date: Fri, 15 Dec 2023 11:50:08 +0800
Message-ID: <20231215035009.498049-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215035009.498049-1-liuhangbin@gmail.com>
References: <20231215035009.498049-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support using defines in checks so we don't need to use hard code
number for the string, binary length.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml      | 2 +-
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 Documentation/netlink/genetlink.yaml        | 2 +-
 Documentation/netlink/netlink-raw.yaml      | 2 +-
 tools/net/ynl/ynl-gen-c.py                  | 7 +++++++
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 66083cdbf43e..82a891e6ed68 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -11,7 +11,7 @@ $defs:
     minimum: 0
   len-or-define:
     type: [ string, integer ]
-    pattern: ^[0-9A-Za-z_]+( - 1)?$
+    pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
     # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 9a9ab7468469..28317b1818ad 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -11,7 +11,7 @@ $defs:
     minimum: 0
   len-or-define:
     type: [ string, integer ]
-    pattern: ^[0-9A-Za-z_]+( - 1)?$
+    pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
     # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 9be071a622cf..813cd4eb47df 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -11,7 +11,7 @@ $defs:
     minimum: 0
   len-or-define:
     type: [ string, integer ]
-    pattern: ^[0-9A-Za-z_]+( - 1)?$
+    pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
     # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 2c393b234511..d59670743d10 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -11,7 +11,7 @@ $defs:
     minimum: 0
   len-or-define:
     type: [ string, integer ]
-    pattern: ^[0-9A-Za-z_]+( - 1)?$
+    pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
 
 # Schema for specs
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 88a2048d668d..fba65ba2c716 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -85,9 +85,16 @@ class Type(SpecAttr):
         delattr(self, "enum_name")
 
     def get_limit(self, limit, default=None):
+        defines = []
+        for const in self.family['definitions']:
+            if const['type'] == 'const':
+                defines.append(const['name'])
+
         value = self.checks.get(limit, default)
         if value is None:
             return value
+        elif value in defines:
+            return c_upper(f"{self.family['name']}-{value}")
         if not isinstance(value, int):
             value = limit_to_number(value)
         return value
-- 
2.43.0


