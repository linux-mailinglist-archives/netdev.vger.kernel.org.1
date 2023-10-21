Return-Path: <netdev+bounces-43225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852727D1CCF
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E507EB21671
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06890101C0;
	Sat, 21 Oct 2023 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZCmUkQap"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0233FDF63
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:27:23 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33C01A8
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso2530794a12.0
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697887636; x=1698492436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pn8Mh21iLYyfQ3CUekBWSZCY1YIavb/sx5nkVkuFy5c=;
        b=ZCmUkQapG+ffc4FTurbuY/vkBPr1DF34ouDJqbLMk9FpRNgU8ffwOvsfXxf2ZFw9w4
         W4qDOTqhWShePnCsQRDw9txlRdM2Muz2mT/I9jtZu5NzTszYmvnyqSqhZDTCIcN53OCe
         WyBJ4bQ/jcDZPsqdbxapD5gQyJc5jvlmvSg36rEVNh7Ha+9stV2iIqx3GmuXONniaXPZ
         nYL+McwWp2Sf9smVff/NBGHlyzh8t3N+NTgI1YGED+a7Tl7tXTdr90dsNwOun2L/9KgO
         lBaEXKckk51jzbUxtPw8SeZ48xaz0LQ7Ao6Txc0Q3x0WRRGLHA99BcbAgQyLo27KnTJ2
         Jxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697887636; x=1698492436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn8Mh21iLYyfQ3CUekBWSZCY1YIavb/sx5nkVkuFy5c=;
        b=h9U5zPkorw17glmap+vSMvMEkQw/GPPX8fLOYkCDDjPn15L0IzPG7gBKC4n0SNy208
         AvQH/2ZN46PskNfIzMScbtCU5yC3D5HtBVhxBBhk7SscrfsiTtidCUE5oTR26Bk6uSyV
         ZV3/GZBsxHyXCikGv0JIWV9gHJPdeY/8DNYeMvo5ARI7cB1ZmKUbqOsS6FZXhMmTLCsW
         lZZ1tEQ+UMyu5hlqRIuYrTx6DgXhUz3nIaJmvJx28T/+s4mk2DSJe6oqZnf7JZ6nr+b3
         TGYsO3JuhzrVgDbvXlkXIQbRhwSwG+we8H5q1TZVuesakDN/UF4zVvtWCgH990WmfNBd
         UA0g==
X-Gm-Message-State: AOJu0YxRLQ7k3Wo4nN1MiwaJBYvzBPtQ3iGYgC0uKDZ/l6PZW3qGVKA/
	bDsvJmOYNabgUaiB4/IK0maAtyLW8tRupG7HY/o=
X-Google-Smtp-Source: AGHT+IGohhR1MCCMRy6vCLfKYqRJw54HdT62PKtmMpv28usscM2115jsHrOV5AAMjvidMZrRddGiaQ==
X-Received: by 2002:a17:907:a089:b0:9b2:a7db:9662 with SMTP id hu9-20020a170907a08900b009b2a7db9662mr3530606ejc.12.1697887636230;
        Sat, 21 Oct 2023 04:27:16 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n27-20020a170906119b00b009ae587ce133sm3454635eja.188.2023.10.21.04.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:27:15 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v3 02/10] tools: ynl-gen: introduce support for bitfield32 attribute type
Date: Sat, 21 Oct 2023 13:27:03 +0200
Message-ID: <20231021112711.660606-3-jiri@resnulli.us>
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

Introduce support for attribute type bitfield32.
Note that since the generated code works with struct nla_bitfield32,
the generator adds netlink.h to the list of includes for userspace
headers in case any bitfield32 is present.

Note that this is added only to genetlink-legacy scheme as requested
by Jakub Kicinski.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- rebased upon uint/sint addition patch
- removed bitfield32 from definitions section
v1->v2:
- fixed a typo in patch description, removed "forgotten"
- added to Documentation of userspace-api
- converted to use _complex_member_type()
- removed from genetlink and genetlink-c schemes
- add netlink.h include conditionally
- added decoding and encoding to ynl.py
---
 Documentation/netlink/genetlink-legacy.yaml   |  2 +-
 .../netlink/genetlink-legacy.rst              |  2 +-
 tools/net/ynl/lib/ynl.c                       |  6 +++
 tools/net/ynl/lib/ynl.h                       |  1 +
 tools/net/ynl/lib/ynl.py                      | 13 +++++--
 tools/net/ynl/ynl-gen-c.py                    | 39 +++++++++++++++++++
 6 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 923de0ff1a9e..565bf615b501 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -192,7 +192,7 @@ properties:
                 type: string
               type: &attr-type
                 description: The netlink attribute type
-                enum: [ unused, pad, flag, binary,
+                enum: [ unused, pad, flag, binary, bitfield32,
                         uint, sint, u8, u16, u32, u64, s32, s64,
                         string, nest, array-nest, nest-type-value ]
               doc:
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
index 350ddc247450..830d25097009 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -379,6 +379,12 @@ int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
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
index 87b4dad832f0..c883e4747cfa 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -135,6 +135,7 @@ enum ynl_policy_type {
 	YNL_PT_U64,
 	YNL_PT_UINT,
 	YNL_PT_NUL_STR,
+	YNL_PT_BITFIELD32,
 };
 
 struct ynl_policy_attr {
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 3b36553a66cc..b1da4aea9336 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -478,6 +478,8 @@ class YnlFamily(SpecFamily):
         elif attr['type'] in NlAttr.type_formats:
             format = NlAttr.get_format(attr['type'], attr.byte_order)
             attr_payload = format.pack(int(value))
+        elif attr['type'] in "bitfield32":
+            attr_payload = struct.pack("II", int(value["value"]), int(value["selector"]))
         else:
             raise Exception(f'Unknown type at {space} {name} {value} {attr["type"]}')
 
@@ -545,14 +547,19 @@ class YnlFamily(SpecFamily):
                 decoded = attr.as_auto_scalar(attr_spec['type'], attr_spec.byte_order)
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
index a9e8898c9386..7d6c318397be 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -488,6 +488,31 @@ class TypeBinary(Type):
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
@@ -786,6 +811,8 @@ class AttrSet(SpecAttrSet):
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


