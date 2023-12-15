Return-Path: <netdev+bounces-57771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C86F8140C9
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928C11F22FD5
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BA953A5;
	Fri, 15 Dec 2023 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeZ9OcYe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F585677
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28af0b2898aso153925a91.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702612229; x=1703217029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NripnaVZgCxYsaEzrPaC4viVBt/U/ENdgYp82A6bUPM=;
        b=YeZ9OcYefcRx9NhI6lI3x/8+i/OFbgTPSoIKjxzNaDtbh/4DwZnT2GVx8/VEMj/cNE
         ++VMm04z0Y2ouFzYy1RnpZVYQMLzdm6gbE6FlkryFB6t7X5aVxD6G7UmsUFm5Y7i4eAv
         DiT2xsiMYCUVpylT0lvlK1mYx9HozdLW5jfrHotn4e0Bjh5sLk5f/ya+fOLVq7V8x8/8
         NJBeTka95LABD9LJ11f/S0PHoj7CYsqEMaYUxyojnTEadFAdmZM4ux5gfPXXSV68qemL
         ihe8mBlzZejckcQDRKPlxd94SPfGsO1X8te98s1lJHqxqpO3N1PK322/+HOUobEW/gi4
         TL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702612229; x=1703217029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NripnaVZgCxYsaEzrPaC4viVBt/U/ENdgYp82A6bUPM=;
        b=SOCN0KGzVhfe7YyKIyXfykutPb5twcauvmLXB8z6sOWJpP+x7rRM54PmFthGZc5hVQ
         19YIui678bal9Ix6d8jHN/3QwVYBvlCAlozyazT5IZqdY8jT+7B1EobN89tOlp+i0mrj
         HiGHu+TEiNFEoxLUIXBVeN2IJuhg2QISWSDDcV8EQrw7mXPwgUUte5Ad1B9WseHvqS9c
         Ya15xqNRVZtKmnOmwNkJp3Cvj4KjsWzSpwBCsI5R67HEvCZbHQieNxIQqGruQhYNjQnv
         xiJt8SWy6Cy1aUM+T7lEUq9t6GtdT1fbnLogeSvarX/SjJNIaU/gAuBZdchqZoQWBXbq
         UEcQ==
X-Gm-Message-State: AOJu0YyCzseAYkMaXAdUfO2Gh9nTustGaD5QXF6uG/wqWxB4cCPZlt8f
	+f7dZd5avDt9zwwaFOHnDHJumTDm2lrylmixB+k=
X-Google-Smtp-Source: AGHT+IFJx+gCcYGss/cUbpCjbT0ACO+W8pgWhZQqP6XmG6dgrrlvIsEaGMSGGcXN6kaXiG5bQItwWQ==
X-Received: by 2002:a17:902:e807:b0:1d3:6ae0:4066 with SMTP id u7-20020a170902e80700b001d36ae04066mr2446041plg.119.1702612229519;
        Thu, 14 Dec 2023 19:50:29 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001d06ca51be3sm13124483plf.88.2023.12.14.19.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 19:50:29 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 1/3] tools: ynl-gen: use correct len for string and binary
Date: Fri, 15 Dec 2023 11:50:07 +0800
Message-ID: <20231215035009.498049-2-liuhangbin@gmail.com>
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

As the description of 'struct nla_policy', the len means the maximum length
of string, binary. Or minimum length of attribute payload for others.
But most time we only use it for string and binary.

On the other hand, the NLA_POLICY_{EXACT_LEN, MIN_LEN, MAX_LEN} should only
be used for binary only.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml      |  7 ++++--
 Documentation/netlink/genetlink-legacy.yaml |  7 ++++--
 Documentation/netlink/genetlink.yaml        |  7 ++++--
 Documentation/netlink/netlink-raw.yaml      |  7 ++++--
 include/net/netlink.h                       |  1 +
 tools/net/ynl/ynl-gen-c.py                  | 25 ++++++++++-----------
 6 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index c58f7153fcf8..66083cdbf43e 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -199,14 +199,17 @@ properties:
                   max:
                     description: Max value for an integer attribute.
                     $ref: '#/$defs/len-or-limit'
+                  len:
+                    description: Max length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
                   max-len:
-                    description: Max length for a string or a binary attribute.
+                    description: Max length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
                   exact-len:
-                    description: Exact length for a string or a binary attribute.
+                    description: Exact length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
               display-hint: &display-hint
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 938703088306..9a9ab7468469 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -242,14 +242,17 @@ properties:
                   max:
                     description: Max value for an integer attribute.
                     $ref: '#/$defs/len-or-limit'
+                  len:
+                    description: Max length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
                   max-len:
-                    description: Max length for a string or a binary attribute.
+                    description: Max length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
                   exact-len:
-                    description: Exact length for a string or a binary attribute.
+                    description: Exact length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
               display-hint: *display-hint
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 3283bf458ff1..9be071a622cf 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -166,14 +166,17 @@ properties:
                   max:
                     description: Max value for an integer attribute.
                     $ref: '#/$defs/len-or-limit'
+                  len:
+                    description: Max length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
                   max-len:
-                    description: Max length for a string or a binary attribute.
+                    description: Max length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
                   exact-len:
-                    description: Exact length for a string or a binary attribute.
+                    description: Exact length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
               display-hint: &display-hint
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index ad5395040765..2c393b234511 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -241,14 +241,17 @@ properties:
                   min:
                     description: Min value for an integer attribute.
                     type: integer
+                  len:
+                    description: Max length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
                   max-len:
-                    description: Max length for a string or a binary attribute.
+                    description: Max length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
                   exact-len:
-                    description: Exact length for a string or a binary attribute.
+                    description: Exact length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
               display-hint: *display-hint
diff --git a/include/net/netlink.h b/include/net/netlink.h
index 28039e57070a..e7f6e22282d3 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -464,6 +464,7 @@ struct nla_policy {
 	.max = _len						\
 }
 #define NLA_POLICY_MIN_LEN(_len)	NLA_POLICY_MIN(NLA_BINARY, _len)
+#define NLA_POLICY_MAX_LEN(_len)	NLA_POLICY_MAX(NLA_BINARY, _len)
 
 /**
  * struct nl_info - netlink source information
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 7fc1aa788f6f..88a2048d668d 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -427,13 +427,10 @@ class TypeString(Type):
         return f'.type = YNL_PT_NUL_STR, '
 
     def _attr_policy(self, policy):
-        if 'exact-len' in self.checks:
-            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.checks['exact-len']) + ')'
-        else:
-            mem = '{ .type = ' + policy
-            if 'max-len' in self.checks:
-                mem += ', .len = ' + str(self.get_limit('max-len'))
-            mem += ', }'
+        mem = '{ .type = ' + policy
+        if 'len' in self.checks:
+            mem += ', .len = ' + str(self.get_limit('len'))
+        mem += ', }'
         return mem
 
     def attr_policy(self, cw):
@@ -481,13 +478,15 @@ class TypeBinary(Type):
     def _attr_policy(self, policy):
         if 'exact-len' in self.checks:
             mem = 'NLA_POLICY_EXACT_LEN(' + str(self.checks['exact-len']) + ')'
+        elif 'max-len' in self.checks:
+            mem = 'NLA_POLICY_MAX_LEN(' + str(self.checks['max-len']) + ')'
+        elif 'min-len' in self.checks:
+            mem = 'NLA_POLICY_MIN_LEN(' + str(self.checks['min-len']) + ')'
         else:
-            mem = '{ '
-            if len(self.checks) == 1 and 'min-len' in self.checks:
-                mem += '.len = ' + str(self.get_limit('min-len'))
-            elif len(self.checks) == 0:
-                mem += '.type = NLA_BINARY'
-            else:
+            mem = '{ .type = ' + policy
+            if len(self.checks) == 1 and 'len' in self.checks:
+                mem += '.len = ' + str(self.get_limit('len'))
+            elif len(self.checks) > 1:
                 raise Exception('One or more of binary type checks not implemented, yet')
             mem += ', }'
         return mem
-- 
2.43.0


