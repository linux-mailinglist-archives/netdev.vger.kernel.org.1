Return-Path: <netdev+bounces-276119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DYCKTpB1Wk73gcAu9opvQ
	(envelope-from <netdev+bounces-276119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:39:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A8A3B2764
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 995BE30B3D16
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE8234677D;
	Tue,  7 Apr 2026 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="wedQrprH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E5346AED
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583257; cv=none; b=WPatwb4NKssmI6SxGNNVRTgU+5GV8dXE8waTuk1QmynKYOEQ7dYiCCbEp2L0THV0lVhAR5i/AYd3b5/eEUairA2FeC+Oh7hrJfkLJzTP2QhEeIR8NMf93eP3PEZg74mldz0oMNIHZlQMsGkf6UABDy9rTZEFBVrspNPxeMbZuY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583257; c=relaxed/simple;
	bh=49rLF/YBNEUCeYVeJWjXgLmxLuVnEU/ezTyuBvpuM1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCVdwr2phyv8dOAwaFdvGtSJRHkOK/J6lYdO00fwbO6wZD80+v3Yd7u89JC2yicfBQIyTRBj9kmbSQqonYbXOVVe8JaapEfR+cyfN7n8lvNWXE5rqIQQ7LwJheoj7PZ2O54XuhnPofRhTPiD2AzVL/ebzJd8AkqeGbABsIaBsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=wedQrprH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ad135063so22132745e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1775583252; x=1776188052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=919jjFlaCHTMwo0h9h3Y9/l6qcyBw44BcNrC4KE19v0=;
        b=wedQrprHHwcNovSptaGYLlfpkyGDb4ysuRu/32URjXt3agm2jqjYSH+3SK38vffzRx
         7G315Ooc6oyjCJ6jAHLSxaepj02uyZ6Vwlk07jqWZPnn9brBlFJjdVxTm2ZAq+2hFmUs
         Q90I2SY3R0gCbsprwS9C4e8rrCyMirAGOdzMLJG9PHF2b+VyGjXuT65umA0YiXFCzqhE
         8yT59h04Csqk/1+HJQMH0fC/c/jdrs0ixir5Eewi/FffcZQopcM50KZfFi93osy6v5S6
         LNsS8y5+VFKoJJSvFfYzyjo2/T72kZWH7HLNqyVQCQs1w0mhPa+UPIEOWBSHx+JhF1uJ
         341g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583252; x=1776188052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=919jjFlaCHTMwo0h9h3Y9/l6qcyBw44BcNrC4KE19v0=;
        b=qjz7sgCvTmaT0stB/HGO7Zz2vB0Wjiu8ugvUKj3eOpz0BUl+BmfshBWHGeLNzz7GAc
         iX55SjbIJRS7IwfcaBAAe0rCugiOJoWky0rdXfU1uZRnKpXR29+AS1pdVx+B10hvQyH6
         uynx8kWpFeb6daQiHTA3ijMwp8296gIGwzu8ZRBD59xGz5A7dwnbGGpDm7bscu7H7dy6
         T5DCGeTKZnrj5dSepBdsP9jNfspigWL2gxMLtrJ/h+/p7pkKOUJrcYy3WpBXPxP7l8Ji
         6I8sxGAfYPfQOdDLZJI9Oab3DIqTq80bzPiJMURrZDBSl+NeXa8Y0pXquhaMG9rhR8fm
         rWnw==
X-Forwarded-Encrypted: i=1; AJvYcCUGouDSh5ilLrvJmK8dFsqhREuW90Uzu020Fzs4a+16CiSXcdIK3GNwGZ5wEt5+aP3PruJhu9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj12WWdvOwZNAoKIRY9eEIp6CPWahjHt7Py+h2wiv6Drc9YoJQ
	o9+SygLfXRFYCgpMTHi8u1B4Dah4InJ21TFmGeCarymnE/N/Vv6rh37wysI/4CFgwEc=
X-Gm-Gg: AeBDietUufszc7Ux7eD8pQlpJZHSAsVpEdRxEpF9hmQHtgGwrCxEBxN9rPtEZDBeJH+
	Gh/ICF9TMAQOJD8tFCb3ylbP15ahQR5bwhG3o3IaT7TyADGhWLs5fIadsh3705onSV198wnlddH
	eLRQ4JanQQjGZHhogD5FGzyB/yds7j49D1Z3Ymeor91SAYJBMInuHooD8a5RH6QUx1riOgUsR97
	bEvNsqkHvM6N5HMl25IWq/QQKFwkDW5gc5F8+XOLGm5ciB3kTeIksO1Z/aK+CnnCDmSsTqkOFf6
	Tb7YqYRC8vCTAmOwfPT6ize8Ll/hwh/vIur9WB5B5DcWRZ+N8CD8shNzjVRbChMqO2FNASKoyh6
	/Tjq0j461DWvxBGGrIriDYqJ2B6NfdWaG8vNH9VdfHpaH+M3+5FxVCDPJzihF1Ap+DE0R4nP/Xs
	MK7CX3xe7QF3ApgIB25kGtBBaOTYA5AmWR4JoIj+svENqQR+rMEv7YmnlmIErN1Wn5ercIP48Y4
	8QeAhM8A4UV6YV+qNTaTA==
X-Received: by 2002:a05:600c:8216:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-488ac0175camr137617515e9.5.1775583252301;
        Tue, 07 Apr 2026 10:34:12 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c4e930c7sm6667275e9.6.2026.04.07.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:34:11 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Date: Tue,  7 Apr 2026 19:33:54 +0200
Message-ID: <20260407173356.873887-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[linbit-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276119-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linbit-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linbit.com:email,linbit.com:mid,attr.name:url,linbit-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06A8A3B2764
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a "emit-structs" option to the genetlink-legacy spec.

Enabling "emit-structs" adds struct declarations for nested attribute
sets to the generated kernel headers.

It also adds some useful serialization helpers:
  - from_attrs() with 'required' attribute enforcement
  - to_skb() for struct-to-netlink serialization
  - set_defaults() driven by the 'default' YAML key

The motivation is to replace the existing deprecated genl_magic system.
Some genl_magic features are dropped entirely because they had no
significant users, some are carried over to YNL (the genetlink-legacy
spec).

The new flags in the genetlink-legacy spec that are required for
existing consumers to keep working are:

  "default": a literal value or C define that sets the default value
  for an attribute, consumed by set_defaults().

  "required": if true, from_attrs() returns an error when this
  attribute is missing from the request message.

  "nla-policy-type": can be used to override the NLA type used in
  policy arrays. This is needed when the semantic type differs from
  the wire type for backward compatibility: genl_magic maps s32 fields
  to NLA_U32/nla_get_u32, and existing userspace might depend on this
  encoding. The immediate motivation is DRBD, whose genl spec
  definition predates the addition of signed types in genl. However,
  this is a generic issue that potentially affects multiple families:
  for example, nftables has NFTA_HOOK_PRIORITY as s32 in the spec but
  NLA_U32 in the actual kernel policy.

All new properties are backward-compatible; existing specs that do not
use them are unaffected.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 Documentation/netlink/genetlink-legacy.yaml |  23 ++
 tools/net/ynl/pyynl/ynl_gen_c.py            | 293 +++++++++++++++++++-
 2 files changed, 313 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 66fb8653a344..8e87e1c7915e 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -270,6 +270,23 @@ properties:
                       For string attributes, do not check whether attribute
                       contains the terminating null character.
                     type: boolean
+              default:
+                description: |
+                  Default value expression (C macro or literal) for this attribute.
+                  Used to generate set_defaults() initialization functions.
+                type: [ string, integer ]
+              required:
+                description: |
+                  If true, from_attrs() returns an error when this attribute is
+                  missing from the request message.
+                type: boolean
+              nla-policy-type:
+                description: |
+                  Override the NLA type used in kernel policy arrays. Use this when
+                  the semantic type differs from the wire type for backward compat
+                  (e.g., s32 fields that must use NLA_U32 on the wire because
+                  userspace predates NLA_S32 support).
+                enum: [ u8, u16, u32, u64, s8, s16, s32, s64 ]
               sub-type: *attr-type
               display-hint: *display-hint
               # Start genetlink-c
@@ -471,3 +488,9 @@ properties:
           to store the socket state. The type / structure is internal
           to the kernel, and is not defined in the spec.
         type: string
+      emit-structs:
+        description: |
+          Generate C struct declarations and serialization helpers
+          (from_attrs, to_skb, set_defaults) in the kernel header
+          and source.
+        type: boolean
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 0e1e486c1185..fc20b05f1c95 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -225,10 +225,11 @@ class Type(SpecAttr):
         return '{ .type = ' + policy + ', }'
 
     def attr_policy(self, cw):
-        policy = f'NLA_{c_upper(self.type)}'
+        policy_type = self.attr.get('nla-policy-type', self.type)
+        policy = f'NLA_{c_upper(policy_type)}'
         if self.attr.get('byte-order') == 'big-endian':
-            if self.type in {'u16', 'u32'}:
-                policy = f'NLA_BE{self.type[1:]}'
+            if policy_type in {'u16', 'u32'}:
+                policy = f'NLA_BE{policy_type[1:]}'
 
         spec = self._attr_policy(policy)
         cw.p(f"\t[{self.enum_name}] = {spec},")
@@ -3415,6 +3416,255 @@ def find_kernel_root(full_path):
             return full_path, sub_path[:-1]
 
 
+def _struct_c_type(attr_type):
+    """Map YNL attribute type to C type for struct field declarations."""
+    type_map = {
+        'u8': 'unsigned char', 'u16': '__u16', 'u32': '__u32', 'u64': '__u64',
+        's8': '__s8', 's16': '__s16', 's32': '__s32', 's64': '__s64',
+    }
+    return type_map.get(attr_type)
+
+
+def _nested_attr_sets(family):
+    """Yield (name, attr_set) for non-root attr-sets in spec order.
+
+    The root attr-set (same name as family) contains nest-type attributes
+    that point to the nested sets.  Only the nested sets have scalar/array
+    fields that translate to struct members.
+    """
+    root_name = family['name']
+    for name, attr_set in family.attr_sets.items():
+        if name == root_name or attr_set.subset_of:
+            continue
+        yield name, attr_set
+
+
+def render_struct_decl(family, cw):
+    """Generate C struct declarations from nested attribute sets."""
+    for set_name, attr_set in _nested_attr_sets(family):
+        s_name = c_lower(set_name)
+        cw.p(f"struct {s_name} {{")
+        for _, attr in attr_set.items():
+            c_name = c_lower(attr.name)
+            c_type = _struct_c_type(attr['type'])
+            if c_type:
+                cw.p(f"\t{c_type} {c_name};")
+            elif attr['type'] in ('string', 'binary'):
+                maxlen = attr.get('checks', {}).get('max-len', 0)
+                cw.p(f"\tchar {c_name}[{maxlen}];")
+                cw.p(f"\t__u32 {c_name}_len;")
+        cw.p('};')
+        cw.nl()
+
+
+def _nla_get_fn(attr_type):
+    """Return the nla_get function name for a scalar type."""
+    fn_map = {
+        'u8': 'nla_get_u8', 'u16': 'nla_get_u16',
+        'u32': 'nla_get_u32', 'u64': 'nla_get_u64',
+        's8': 'nla_get_s8', 's16': 'nla_get_s16',
+        's32': 'nla_get_s32', 's64': 'nla_get_s64',
+    }
+    return fn_map.get(attr_type)
+
+
+def _nla_put_fn(attr_type):
+    """Return (function_name, extra_args) for a scalar nla_put."""
+    fn_map = {
+        'u8':  ('nla_put_u8', ''),
+        'u16': ('nla_put_u16', ''),
+        'u32': ('nla_put_u32', ''),
+        'u64': ('nla_put_u64_64bit', ', 0'),
+        's8':  ('nla_put_s8', ''),
+        's16': ('nla_put_s16', ''),
+        's32': ('nla_put_s32', ''),
+        's64': ('nla_put_s64', ''),
+    }
+    return fn_map.get(attr_type)
+
+
+def render_from_attrs(family, cw):
+    """Generate from_attrs() deserialization functions."""
+    root_set = family.attr_sets.get(family['name'])
+
+    for set_name, attr_set in _nested_attr_sets(family):
+        s_name = c_lower(set_name)
+        struct = family.pure_nested_structs.get(set_name)
+        if not struct or not struct.request:
+            continue
+        tla_name = None
+        if root_set:
+            for _, tla_attr in root_set.items():
+                if tla_attr.attr.get('nested-attributes') == set_name:
+                    tla_name = tla_attr.enum_name
+                    break
+        if tla_name is None:
+            continue
+
+        policy_name = f"{struct.render_name}_nl_policy"
+        max_attr = struct.attr_max_val.enum_name
+        cw.p(f"static int __{s_name}_from_attrs(struct {s_name} *s,")
+        cw.p(f"\t\tstruct nlattr ***ret_nested_attribute_table,")
+        cw.p(f"\t\tstruct genl_info *info)")
+        cw.block_start()
+        cw.p(f"const int maxtype = {max_attr};")
+        cw.p(f"struct nlattr *tla = info->attrs[{tla_name}];")
+        cw.p('struct nlattr **ntb;')
+        cw.p('struct nlattr *nla;')
+        cw.p('int err = 0;')
+        cw.nl()
+        cw.p('if (ret_nested_attribute_table)')
+        cw.p('*ret_nested_attribute_table = NULL;')
+        cw.p('if (!tla)')
+        cw.p('return -ENOMSG;')
+        cw.p(f"ntb = kcalloc({max_attr} + 1, sizeof(*ntb), GFP_KERNEL);")
+        cw.p('if (!ntb)')
+        cw.p('return -ENOMEM;')
+        cw.p(f"err = nla_parse_nested_deprecated(ntb, maxtype, tla, {policy_name}, NULL);")
+        cw.p('if (err)')
+        cw.p('goto out;')
+        cw.nl()
+
+        for _, attr in attr_set.items():
+            c_name = c_lower(attr.name)
+            is_required = attr.attr.get('required', False)
+            get_fn = _nla_get_fn(attr['type'])
+
+            cw.p(f"nla = ntb[{attr.enum_name}];")
+            if is_required:
+                cw.block_start(line='if (nla)')
+                if get_fn:
+                    cw.p('if (s)')
+                    cw.p(f"s->{c_name} = {get_fn}(nla);")
+                elif attr['type'] == 'string':
+                    maxlen = attr.get('checks', {}).get('max-len', 0)
+                    cw.p('if (s)')
+                    cw.p(f"s->{c_name}_len = nla_strscpy(s->{c_name}, nla, {maxlen});")
+                elif attr['type'] == 'binary':
+                    maxlen = attr.get('checks', {}).get('max-len', 0)
+                    cw.p('if (s)')
+                    cw.p(f"s->{c_name}_len = nla_memcpy(s->{c_name}, nla, {maxlen});")
+                cw.block_end()
+                cw.block_start(line='else')
+                cw.p(f'pr_info("<< missing required attr: {c_name}\\n");')
+                cw.p('err = -ENOMSG;')
+                cw.block_end()
+            else:
+                if get_fn:
+                    cw.p('if (nla && s)')
+                    cw.p(f"s->{c_name} = {get_fn}(nla);")
+                elif attr['type'] == 'string':
+                    maxlen = attr.get('checks', {}).get('max-len', 0)
+                    cw.p('if (nla && s)')
+                    cw.p(f"s->{c_name}_len = nla_strscpy(s->{c_name}, nla, {maxlen});")
+                elif attr['type'] == 'binary':
+                    maxlen = attr.get('checks', {}).get('max-len', 0)
+                    cw.p('if (nla && s)')
+                    cw.p(f"s->{c_name}_len = nla_memcpy(s->{c_name}, nla, {maxlen});")
+            cw.nl()
+
+        cw.p('out:')
+        cw.p('if (ret_nested_attribute_table && (!err || err == -ENOMSG))')
+        cw.p('*ret_nested_attribute_table = ntb;')
+        cw.p('else')
+        cw.p('kfree(ntb);')
+        cw.p('return err;')
+        cw.block_end()
+        cw.nl()
+
+        cw.p(f"int {s_name}_from_attrs(struct {s_name} *s,")
+        cw.p(f"\t\t\t\tstruct genl_info *info)")
+        cw.block_start()
+        cw.p(f"return __{s_name}_from_attrs(s, NULL, info);")
+        cw.block_end()
+        cw.nl()
+
+        cw.p(f"int {s_name}_ntb_from_attrs(")
+        cw.p(f"\t\t\tstruct nlattr ***ret_nested_attribute_table,")
+        cw.p(f"\t\t\tstruct genl_info *info)")
+        cw.block_start()
+        cw.p(f"return __{s_name}_from_attrs(NULL, ret_nested_attribute_table, info);")
+        cw.block_end()
+        cw.nl()
+
+
+def render_to_skb(family, cw):
+    """Generate to_skb() serialization functions."""
+    root_set = family.attr_sets.get(family['name'])
+
+    for set_name, attr_set in _nested_attr_sets(family):
+        s_name = c_lower(set_name)
+        tla_name = None
+        if root_set:
+            for _, tla_attr in root_set.items():
+                if tla_attr.attr.get('nested-attributes') == set_name:
+                    tla_name = tla_attr.enum_name
+                    break
+        if tla_name is None:
+            continue
+
+        cw.p(f"int {s_name}_to_skb(struct sk_buff *skb, struct {s_name} *s)")
+        cw.block_start()
+        cw.p(f"struct nlattr *tla = nla_nest_start(skb, {tla_name});")
+        cw.nl()
+        cw.p('if (!tla)')
+        cw.p('goto nla_put_failure;')
+        cw.nl()
+
+        for _, attr in attr_set.items():
+            c_name = c_lower(attr.name)
+            put = _nla_put_fn(attr['type'])
+
+            if put:
+                fn, extra = put
+                cw.p(f"if ({fn}(skb, {attr.enum_name}, s->{c_name}{extra}))")
+                cw.p('goto nla_put_failure;')
+            elif attr['type'] in ('string', 'binary'):
+                maxlen = attr.get('checks', {}).get('max-len', 0)
+                nul_adj = f" + (s->{c_name}_len < {maxlen})" if attr['type'] == 'string' else ''
+                cw.p(f"if (nla_put(skb, {attr.enum_name}, min_t(int, {maxlen},")
+                cw.p(f"\t\ts->{c_name}_len{nul_adj}), s->{c_name}))")
+                cw.p('goto nla_put_failure;', add_ind=1)
+
+        cw.nl()
+        cw.p('nla_nest_end(skb, tla);')
+        cw.p('return 0;')
+        cw.nl()
+        cw.p('nla_put_failure:')
+        cw.p('if (tla)')
+        cw.p('nla_nest_cancel(skb, tla);')
+        cw.p('return -EMSGSIZE;')
+        cw.block_end()
+        cw.nl()
+
+
+def render_set_defaults(family, cw):
+    """Generate set_defaults() initialization functions."""
+    for set_name, attr_set in _nested_attr_sets(family):
+        s_name = c_lower(set_name)
+        has_defaults = any(
+            'default' in attr.attr for _, attr in attr_set.items()
+        )
+        if not has_defaults:
+            continue
+
+        cw.p(f"void set_{s_name}_defaults(struct {s_name} *x)")
+        cw.block_start()
+        for _, attr in attr_set.items():
+            c_name = c_lower(attr.name)
+            default = attr.attr.get('default')
+            if default is None:
+                continue
+
+            if attr['type'] in ('string', 'binary'):
+                cw.p(f"memset(x->{c_name}, 0, sizeof(x->{c_name}));")
+                cw.p(f"x->{c_name}_len = 0;")
+            else:
+                cw.p(f"x->{c_name} = {default};")
+        cw.block_end()
+        cw.nl()
+
+
 def main():
     parser = argparse.ArgumentParser(description='Netlink simple parsing generator')
     parser.add_argument('--mode', dest='mode', type=str, required=True,
@@ -3487,6 +3737,9 @@ def main():
         cw.p('#include <net/genetlink.h>')
         cw.nl()
         if not args.header:
+            if parsed.kernel_family.get('emit-structs'):
+                cw.p('#include <linux/kernel.h>')
+                cw.p('#include <linux/slab.h>')
             if args.out_file:
                 cw.p(f'#include "{hdr_file}"')
             cw.nl()
@@ -3555,6 +3808,31 @@ def main():
             print_kernel_op_table_hdr(parsed, cw)
             print_kernel_mcgrp_hdr(parsed, cw)
             print_kernel_family_struct_hdr(parsed, cw)
+
+            if parsed.kernel_family.get('emit-structs'):
+                cw.nl()
+                render_struct_decl(parsed, cw)
+                # Function prototypes
+                root_set = parsed.attr_sets.get(parsed['name'])
+                for set_name, attr_set in _nested_attr_sets(parsed):
+                    s_name = c_lower(set_name)
+                    struct = parsed.pure_nested_structs.get(set_name)
+                    has_tla = False
+                    if root_set:
+                        for _, tla_attr in root_set.items():
+                            if tla_attr.attr.get('nested-attributes') == set_name:
+                                has_tla = True
+                                break
+                    if not has_tla:
+                        continue
+                    if struct and struct.request:
+                        cw.p(f"int {s_name}_from_attrs(struct {s_name} *s, struct genl_info *info);")
+                        cw.p(f"int {s_name}_ntb_from_attrs(struct nlattr ***ret_nested_attribute_table, struct genl_info *info);")
+                    cw.p(f"int {s_name}_to_skb(struct sk_buff *skb, struct {s_name} *s);")
+                    has_defaults = any('default' in a.attr for _, a in attr_set.items())
+                    if has_defaults:
+                        cw.p(f"void set_{s_name}_defaults(struct {s_name} *x);")
+                    cw.nl()
         else:
             print_kernel_policy_ranges(parsed, cw)
             print_kernel_policy_sparse_enum_validates(parsed, cw)
@@ -3588,6 +3866,15 @@ def main():
             print_kernel_mcgrp_src(parsed, cw)
             print_kernel_family_struct_src(parsed, cw)
 
+            if parsed.kernel_family.get('emit-structs'):
+                cw.nl()
+                render_from_attrs(parsed, cw)
+                render_to_skb(parsed, cw)
+                render_set_defaults(parsed, cw)
+                if cw._block_end:
+                    cw._block_end = False
+                    cw._out.write('}\n')
+
     if args.mode == "user":
         if args.header:
             cw.p('/* Enums */')
-- 
2.53.0


