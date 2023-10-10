Return-Path: <netdev+bounces-39518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B82E7BF93C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586BC1C20D80
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4CA182A7;
	Tue, 10 Oct 2023 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ezQ602Qx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07988182C5
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:08:37 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E394
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so9839651a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696936114; x=1697540914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W4MR3pQt3kSN0Rv63RLuIeSWWf6L0vQMffRfE+zgIE=;
        b=ezQ602Qx6oq/bryWy7Pf4a3M1oEuZR+A4oGN2SbR73JR1fYXjqd+6FIl57RP3DQ3BL
         exRa/ymzQTTVF3Uu5e6fAU4N13r8Je8vmL/xe4ncN2GDPzY432FX4xcuJxfA4u+CtWlr
         6u6GwCl2F6HyniHVHhK0Iu5EPpJ4t8gobWotYbmL83RfqnsPjPNNYzpV8vvNjiCgPoxL
         s4zK1c6NQQ+XxbyJ/RIyrVWLQiSUHyFi8wlb7Eu4xmZrG6LB8DAmKq7N8eIJrPJKBJfy
         b6739xc8JL1+ilaNKRuptlWvhKwD+iDzCIWW5ba6pUvc9pkisUSMJb+Jiwdf71Rj/I4M
         TpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936114; x=1697540914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0W4MR3pQt3kSN0Rv63RLuIeSWWf6L0vQMffRfE+zgIE=;
        b=ZIhxoo2BpWLwHOw6b1nw1cBEgkiyHxzJbKWsvUn00uUBLU6z7nBasiO8Wk1g8KO/cL
         5LP4fgNDeZ6ljUn/1Ee6ILGevrHEMtOpSVayP2dW6fHJiWiDkMLks3w/YsuZuspZp/Cd
         tiBoSaI/PguR1LYZcFgTGz1m7pRC70DpSIbqM5BPWKaeEAEyDTpDfFhi6p2Pjm7esbEd
         VfZOVIL6eMIm9wWYJKxIXx4JZBWlG6M9OrIUBgtHyMeo1x93Pt75hO4QlQXiiTpvu1IQ
         nzgAPBstmFTJi+/EQ5zLp/DbVuAe6oYkkHxjtAU8vV5dY502JIofHtHZfcdNEFhVWZTN
         CnaA==
X-Gm-Message-State: AOJu0YwsnYl3lt4cP6Mla/+b/3TKAyTPiOcpu/9QITCrDsa2bJNWxapA
	vqKdP/4EZgh3dxKRmVrnuCwvhfAJq1uB1IW4Bc8=
X-Google-Smtp-Source: AGHT+IGgqkwSCy1UY4rVLazvV/33gYRJV40S4EI8Ra5z2gsDFYiiWEH+fKTNHuMpV7D6U3wFoEKrSg==
X-Received: by 2002:aa7:da83:0:b0:533:d81b:36d5 with SMTP id q3-20020aa7da83000000b00533d81b36d5mr15410732eds.15.1696936114380;
        Tue, 10 Oct 2023 04:08:34 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id a23-20020a50ff17000000b005342fa19070sm7489876edu.89.2023.10.10.04.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:08:33 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next 02/10] tools: ynl-gen: introduce support for bitfield32 attribute type
Date: Tue, 10 Oct 2023 13:08:21 +0200
Message-ID: <20231010110828.200709-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010110828.200709-1-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Introduce support for forgotten attribute type bitfield32.
Note that since the generated code works with struct nla_bitfiel32,
the generator adds netlink.h to the list of includes for userspace
headers. Regenerate the headers.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/genetlink-c.yaml      |  2 +-
 Documentation/netlink/genetlink-legacy.yaml |  4 +--
 Documentation/netlink/genetlink.yaml        |  2 +-
 tools/net/ynl/generated/devlink-user.h      |  1 +
 tools/net/ynl/generated/ethtool-user.h      |  1 +
 tools/net/ynl/generated/fou-user.h          |  1 +
 tools/net/ynl/generated/handshake-user.h    |  1 +
 tools/net/ynl/generated/netdev-user.h       |  1 +
 tools/net/ynl/lib/ynl.c                     |  6 ++++
 tools/net/ynl/lib/ynl.h                     |  1 +
 tools/net/ynl/ynl-gen-c.py                  | 31 +++++++++++++++++++++
 11 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index f9366aaddd21..8192b87b3046 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -144,7 +144,7 @@ properties:
               name:
                 type: string
               type: &attr-type
-                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
+                enum: [ unused, pad, flag, binary, bitfield32, u8, u16, u32, u64, s32, s64,
                         string, nest, array-nest, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index a6a490333a1a..8b867b5b9966 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -120,7 +120,7 @@ properties:
                 type: string
               type:
                 description: The netlink attribute type
-                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary ]
+                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary, bitfield32 ]
               len:
                 $ref: '#/$defs/len-or-define'
               byte-order:
@@ -187,7 +187,7 @@ properties:
                 type: string
               type: &attr-type
                 description: The netlink attribute type
-                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
+                enum: [ unused, pad, flag, binary, bitfield32, u8, u16, u32, u64, s32, s64,
                         string, nest, array-nest, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 2b788e607a14..5cde1b030e8e 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -117,7 +117,7 @@ properties:
               name:
                 type: string
               type: &attr-type
-                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
+                enum: [ unused, pad, flag, binary, bitfield32, u8, u16, u32, u64, s32, s64,
                         string, nest, array-nest, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
index 4b686d147613..a490466fb98a 100644
--- a/tools/net/ynl/generated/devlink-user.h
+++ b/tools/net/ynl/generated/devlink-user.h
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/types.h>
+#include <linux/netlink.h>
 #include <linux/devlink.h>
 
 struct ynl_sock;
diff --git a/tools/net/ynl/generated/ethtool-user.h b/tools/net/ynl/generated/ethtool-user.h
index ddc1a5209992..f7bce36f8485 100644
--- a/tools/net/ynl/generated/ethtool-user.h
+++ b/tools/net/ynl/generated/ethtool-user.h
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/types.h>
+#include <linux/netlink.h>
 #include <linux/ethtool.h>
 
 struct ynl_sock;
diff --git a/tools/net/ynl/generated/fou-user.h b/tools/net/ynl/generated/fou-user.h
index a8f860892540..2ae6d1b66393 100644
--- a/tools/net/ynl/generated/fou-user.h
+++ b/tools/net/ynl/generated/fou-user.h
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/types.h>
+#include <linux/netlink.h>
 #include <linux/fou.h>
 
 struct ynl_sock;
diff --git a/tools/net/ynl/generated/handshake-user.h b/tools/net/ynl/generated/handshake-user.h
index 2b34acc608de..1007f8db5c5e 100644
--- a/tools/net/ynl/generated/handshake-user.h
+++ b/tools/net/ynl/generated/handshake-user.h
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/types.h>
+#include <linux/netlink.h>
 #include <linux/handshake.h>
 
 struct ynl_sock;
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index b4351ff34595..d6ffc0c8ccf4 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/types.h>
+#include <linux/netlink.h>
 #include <linux/netdev.h>
 
 struct ynl_sock;
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 514e0d69e731..4a94ef092b6e 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -373,6 +373,12 @@ int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
 		yerr(yarg->ys, YNL_ERROR_ATTR_INVALID,
 		     "Invalid attribute (string %s)", policy->name);
 		return -1;
+	case YNL_PT_BITFIELD32:
+		if (len == sizeof(struct nla_bitfield32))
+			break;
+		yerr(yarg->ys, YNL_ERROR_ATTR_INVALID,
+		     "Invalid attribute (bitfield32 %s)", policy->name);
+		return -1;
 	default:
 		yerr(yarg->ys, YNL_ERROR_ATTR_INVALID,
 		     "Invalid attribute (unknown %s)", policy->name);
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index 9eafa3552c16..813b26a08145 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -134,6 +134,7 @@ enum ynl_policy_type {
 	YNL_PT_U32,
 	YNL_PT_U64,
 	YNL_PT_NUL_STR,
+	YNL_PT_BITFIELD32,
 };
 
 struct ynl_policy_attr {
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index f125b5f704ba..27bbe376054d 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -433,6 +433,34 @@ class TypeBinary(Type):
                 f'memcpy({member}, {self.c_name}, {presence}_len);']
 
 
+class TypeBitfield32(Type):
+    def arg_member(self, ri):
+        return [f"const struct nla_bitfield32 *{self.c_name}"]
+
+    def struct_member(self, ri):
+        ri.cw.p(f"struct nla_bitfield32 {self.c_name};")
+
+    def _attr_typol(self):
+        return f'.type = YNL_PT_BITFIELD32, '
+
+    def _attr_policy(self, policy):
+        if not 'enum' in self.attr:
+            raise Exception('Enum required for bitfield32 attr')
+        enum = self.family.consts[self.attr['enum']]
+        mask = enum.get_mask(as_flags=True)
+        return f"NLA_POLICY_BITFIELD32({mask})"
+
+    def attr_put(self, ri, var):
+        line = f"mnl_attr_put(nlh, {self.enum_name}, sizeof(struct nla_bitfield32), &{var}->{self.c_name})"
+        self._attr_put_line(ri, var, line)
+
+    def _attr_get(self, ri, var):
+        return f"memcpy(&{var}->{self.c_name}, mnl_attr_get_payload(attr), sizeof(struct nla_bitfield32));", None, None
+
+    def _setter_lines(self, ri, member, presence):
+        return [f"memcpy(&{member}, {self.c_name}, sizeof(struct nla_bitfield32));"]
+
+
 class TypeNest(Type):
     def _complex_member_type(self, ri):
         return self.nested_struct_type
@@ -735,6 +763,8 @@ class AttrSet(SpecAttrSet):
             t = TypeString(self.family, self, elem, value)
         elif elem['type'] == 'binary':
             t = TypeBinary(self.family, self, elem, value)
+        elif elem['type'] == 'bitfield32':
+            t = TypeBitfield32(self.family, self, elem, value)
         elif elem['type'] == 'nest':
             t = TypeNest(self.family, self, elem, value)
         elif elem['type'] == 'array-nest':
@@ -2406,6 +2436,7 @@ def main():
         cw.p('#include <string.h>')
         if args.header:
             cw.p('#include <linux/types.h>')
+            cw.p('#include <linux/netlink.h>')
         else:
             cw.p(f'#include "{parsed.name}-user.h"')
             cw.p('#include "ynl.h"')
-- 
2.41.0


