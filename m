Return-Path: <netdev+bounces-42933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B0B7D0B76
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37157B21689
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC3112E5A;
	Fri, 20 Oct 2023 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="khPqX554"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4511708
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:21:42 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E82173E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so768597a12.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697793683; x=1698398483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLQYDFYnkfDnMsyEb2aVy+hr0mSSzg7hqJKoYM6D6TQ=;
        b=khPqX554DScGxozjKX86GBYE8p+phJjnbLn+1470Z055ndh9rS6sJ0/wf0i4fpxULB
         vtGtffTozrIypQ/lfDd+bdcQz/zHl7MogRnGra1vAifwzBez1QKTTHKh7Z7+2qO0Ij50
         8hHiAzshnCEAQM2O/cd2tGpMk66izC8R/CaAdE/TDMi7a8TCZcxNMIjirZ2Yy6D5wlDs
         Kb4/4hBuMq5J77Z/yoVEWVEvcfKSBxZu8QYIX/OcvAMsXzALXj4/xam5jmTHj7FOUBTU
         V2NIBRdS1c+F0AkRmAkI6ViUPrtRDuqjRk8WuqpVzWYYcBPRXLOg52VQ7o79uFNucRWo
         nK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793683; x=1698398483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLQYDFYnkfDnMsyEb2aVy+hr0mSSzg7hqJKoYM6D6TQ=;
        b=SNdpJx1HsFgHpifntg5fU2F+/5qKZ/eyq6w+989z4RqtBkoCCS22LjRv98Ku1b4/TZ
         fuuan/ID9I6tXXy6tURH/iRez1JZBs71QsaYkggaxqC2kZZQrclMySz1zHSqIJLJWBWs
         RTTmgTiydDnzdDHNBBTezY3X+u6SJsLnz8FA60UOUvopR4JuFkiu5zwxl+ZJ5eGOmkys
         n0xNCw+2qhO6W3sQ170bJnvlZw/vchhF6n6ZEsOXvCSWu5EVrizOFfVpZCSUtrrnzl6S
         LY/aMSeiYyr2EWND6htPV/aJcX0gFdJyaCwmTWPklZzR/mJcdjGQveB3oYtDBboLwFAG
         9+Fw==
X-Gm-Message-State: AOJu0YzuwNDn/TUC5TFyigozHx2W4Lj6/abAOnyzIUyvo0Qnp33q4rSv
	2Sit5RlVAnuOY63hl8xFWxwv7H2V9B0+apsOM1c=
X-Google-Smtp-Source: AGHT+IHC6pHrI2+E462BAQOkgU6fgbhhmuIvj38skjNIgC1ddtTTpmqR+icOFCe8DyhjDky68e91wg==
X-Received: by 2002:a17:907:360a:b0:9c4:bb5f:970f with SMTP id bk10-20020a170907360a00b009c4bb5f970fmr770588ejc.32.1697793682739;
        Fri, 20 Oct 2023 02:21:22 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m16-20020a1709066d1000b009a1a5a7ebacsm1067905ejr.201.2023.10.20.02.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:21:22 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v2 02/10] tools: ynl-gen: introduce support for bitfield32 attribute type
Date: Fri, 20 Oct 2023 11:21:09 +0200
Message-ID: <20231020092117.622431-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020092117.622431-1-jiri@resnulli.us>
References: <20231020092117.622431-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Introduce support for attribute type bitfield32.
Note that since the generated code works with struct nla_bitfield32,
the generator adds netlink.h to the list of includes for userspace
headers in case any bitfield32 is present.

Note that this is added only to genetlink-legacy scheme as requested
by Jakub Kicinski.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- fixed a typo in patch description, removed "forgotten"
- added to Documentation of userspace-api
- converted to use _complex_member_type()
- removed from genetlink and genetlink-c schemes
- add netlink.h include conditionally
- added decoding and encoding to ynl.py
---
 Documentation/netlink/genetlink-legacy.yaml   |  4 +-
 .../netlink/genetlink-legacy.rst              |  2 +-
 tools/net/ynl/lib/ynl.c                       |  6 +++
 tools/net/ynl/lib/ynl.h                       |  1 +
 tools/net/ynl/lib/ynl.py                      | 13 +++++--
 tools/net/ynl/ynl-gen-c.py                    | 39 +++++++++++++++++++
 6 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 9194f3e223ef..f315902ae2fb 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -125,7 +125,7 @@ properties:
                 type: string
               type:
                 description: The netlink attribute type
-                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary ]
+                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary, bitfield32 ]
               len:
                 $ref: '#/$defs/len-or-define'
               byte-order:
@@ -192,7 +192,7 @@ properties:
                 type: string
               type: &attr-type
                 description: The netlink attribute type
-                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
+                enum: [ unused, pad, flag, binary, bitfield32, u8, u16, u32, u64, s32, s64,
                         string, nest, array-nest, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
index 0b3febd57ff5..70a77387f6c4 100644
--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
@@ -182,7 +182,7 @@ members
 
  - ``name`` - The attribute name of the struct member
  - ``type`` - One of the scalar types ``u8``, ``u16``, ``u32``, ``u64``, ``s8``,
-   ``s16``, ``s32``, ``s64``, ``string`` or ``binary``.
+   ``s16``, ``s32``, ``s64``, ``string``, ``binary`` or ``bitfield32``.
  - ``byte-order`` - ``big-endian`` or ``little-endian``
  - ``doc``, ``enum``, ``enum-as-flags``, ``display-hint`` - Same as for
    :ref:`attribute definitions <attribute_properties>`
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
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 28ac35008e65..73d284c34e7e 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -466,6 +466,8 @@ class YnlFamily(SpecFamily):
         elif attr['type'] in NlAttr.type_formats:
             format = NlAttr.get_format(attr['type'], attr.byte_order)
             attr_payload = format.pack(int(value))
+        elif attr['type'] in "bitfield32":
+            attr_payload = struct.pack("II", int(value["value"]), int(value["selector"]))
         else:
             raise Exception(f'Unknown type at {space} {name} {value} {attr["type"]}')
 
@@ -531,14 +533,19 @@ class YnlFamily(SpecFamily):
                 decoded = True
             elif attr_spec["type"] in NlAttr.type_formats:
                 decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
+                if 'enum' in attr_spec:
+                    decoded = self._decode_enum(decoded, attr_spec)
             elif attr_spec["type"] == 'array-nest':
                 decoded = self._decode_array_nest(attr, attr_spec)
+            elif attr_spec["type"] == 'bitfield32':
+                value, selector = struct.unpack("II", attr.raw)
+                if 'enum' in attr_spec:
+                    value = self._decode_enum(value, attr_spec)
+                    selector = self._decode_enum(selector, attr_spec)
+                decoded = {"value": value, "selector": selector}
             else:
                 raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
 
-            if 'enum' in attr_spec:
-                decoded = self._decode_enum(decoded, attr_spec)
-
             if not attr_spec.is_multi:
                 rsp[attr_spec['name']] = decoded
             elif attr_spec.name in rsp:
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 552ba49a444c..d72079e316e9 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -481,6 +481,31 @@ class TypeBinary(Type):
                 f'memcpy({member}, {self.c_name}, {presence}_len);']
 
 
+class TypeBitfield32(Type):
+    def _complex_member_type(self, ri):
+        return "struct nla_bitfield32"
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
@@ -783,6 +808,8 @@ class AttrSet(SpecAttrSet):
             t = TypeString(self.family, self, elem, value)
         elif elem['type'] == 'binary':
             t = TypeBinary(self.family, self, elem, value)
+        elif elem['type'] == 'bitfield32':
+            t = TypeBitfield32(self.family, self, elem, value)
         elif elem['type'] == 'nest':
             t = TypeNest(self.family, self, elem, value)
         elif elem['type'] == 'array-nest':
@@ -2414,6 +2441,16 @@ def render_user_family(family, cw, prototype):
     cw.block_end(line=';')
 
 
+def family_contains_bitfield32(family):
+    for _, attr_set in family.attr_sets.items():
+        if attr_set.subset_of:
+            continue
+        for _, attr in attr_set.items():
+            if attr.type == "bitfield32":
+                return True
+    return False
+
+
 def find_kernel_root(full_path):
     sub_path = ''
     while True:
@@ -2499,6 +2536,8 @@ def main():
         cw.p('#include <string.h>')
         if args.header:
             cw.p('#include <linux/types.h>')
+            if family_contains_bitfield32(parsed):
+                cw.p('#include <linux/netlink.h>')
         else:
             cw.p(f'#include "{parsed.name}-user.h"')
             cw.p('#include "ynl.h"')
-- 
2.41.0


