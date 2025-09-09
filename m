Return-Path: <netdev+bounces-221425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A52FB507B6
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A221462F6E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6143225D540;
	Tue,  9 Sep 2025 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjE/MaW/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE60258CE5;
	Tue,  9 Sep 2025 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452097; cv=none; b=PV8jAH5DAtxy7Zwk/ykxcfbxpWPOplq3b9gGl31gnHNEqU4izuw3qGGIanXh4e8aKJ0TuGzImQkVCAdx5f0GVazPxkGGRoDhrlZtgX49M/lY+WPUSSzemeP57GEgX9a+BbTJdeTmB3pJ0wt6V26ulD+dQyFlfUo5QSi/JsRLCeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452097; c=relaxed/simple;
	bh=OFKJuB4qhb72Tb7eguFu89zqSqIfei935QOv2NR1tqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bVCEL/bHdUT2nRWNIR4zApl53lH6jSqtuJziHagS9Y8yq9HxREngpUOLVwxMZ3I2YUZXcfMoV7tezBx6PR/kRE02KcDqikwU2XYRhWHpqYmdsyK5h7F7FxEtn2rQarJlVfMA7mEE/OFHp+sOXv1tKAAnZXcniN/q0FrFpKbJspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjE/MaW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C8EC4CEF8;
	Tue,  9 Sep 2025 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757452095;
	bh=OFKJuB4qhb72Tb7eguFu89zqSqIfei935QOv2NR1tqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MjE/MaW/EN968at9C91a0gw1HFvGMECjA8d3wCyPotQ3xrKenA+DWMue+uCRiz+7r
	 JYABpjsEl9Be/vhjo6TLScQuCV+YBZ4HEEF5A/XvyThhZ38SZxnwUsX7HQaUoNUt6d
	 jQDS1FOWkdVmKm5LciYJYRBnewQlqAV7a6BRkys4gozt0oSTW1XIz6gji5fu1AATXM
	 BvMe2TLgE6dpcVHVmAz6fMf+y7w0/C2U9ppp+Kyp/NNcfGyBEy/3CXFuuRdaPtbTER
	 2zvWCZhnLAPqlUCF7CCXEYptYJeOgN/kJ6wz7gldLxXaeaQu9RqeftGgIbkACJQ/eH
	 xk2lvoycBK4ig==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 23:07:50 +0200
Subject: [PATCH net-next 4/8] tools: ynl: remove f-string without any
 placeholders
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-net-next-ynl-ruff-v1-4-238c2bccdd99@kernel.org>
References: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
In-Reply-To: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6713; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OFKJuB4qhb72Tb7eguFu89zqSqIfei935QOv2NR1tqA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOTDc8NV3ZmvtCiXR++JnY7ItHSjmWiCx56ub0KiH1X
 6nKytXRHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMplWFkmDRzSkmP4L7KvfkX
 /0ZuNLDd0Ljd7pvQ0uPnC5dPfLty0wpGhrOL07R9RI1PCDLJKW2ZdeZDjbfbnsol4s9PqEUc2W7
 zhwkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'f-strings' without any placeholders don't need to be marked as such
according to Ruff. This 'f' can be safely removed.

This is linked to Ruff error F541 [1]:

  f-strings are a convenient way to format strings, but they are not
  necessary if there are no placeholder expressions to format. In this
  case, a regular string should be used instead, as an f-string without
  placeholders can be confusing for readers, who may expect such a
  placeholder to be present.

Link: https://docs.astral.sh/ruff/rules/f-string-missing-placeholders/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/net/ynl/pyynl/ethtool.py   | 10 +++++-----
 tools/net/ynl/pyynl/ynl_gen_c.py | 22 +++++++++++-----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/pyynl/ethtool.py
index ef2cbad41f9bdd4e22c1be956326417c9ee23109..c1cd088c050cd52ee379ed4682fff856b9b3b3be 100755
--- a/tools/net/ynl/pyynl/ethtool.py
+++ b/tools/net/ynl/pyynl/ethtool.py
@@ -254,14 +254,14 @@ def main():
         reply = dumpit(ynl, args, 'channels-get')
         print(f'Channel parameters for {args.device}:')
 
-        print(f'Pre-set maximums:')
+        print('Pre-set maximums:')
         print_field(reply,
             ('rx-max', 'RX'),
             ('tx-max', 'TX'),
             ('other-max', 'Other'),
             ('combined-max', 'Combined'))
 
-        print(f'Current hardware settings:')
+        print('Current hardware settings:')
         print_field(reply,
             ('rx-count', 'RX'),
             ('tx-count', 'TX'),
@@ -275,14 +275,14 @@ def main():
 
         print(f'Ring parameters for {args.device}:')
 
-        print(f'Pre-set maximums:')
+        print('Pre-set maximums:')
         print_field(reply,
             ('rx-max', 'RX'),
             ('rx-mini-max', 'RX Mini'),
             ('rx-jumbo-max', 'RX Jumbo'),
             ('tx-max', 'TX'))
 
-        print(f'Current hardware settings:')
+        print('Current hardware settings:')
         print_field(reply,
             ('rx', 'RX'),
             ('rx-mini', 'RX Mini'),
@@ -297,7 +297,7 @@ def main():
         return
 
     if args.statistics:
-        print(f'NIC statistics:')
+        print('NIC statistics:')
 
         # TODO: pass id?
         strset = dumpit(ynl, args, 'strset-get')
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 957fae8e27ede6fcd51fb2a98d356a6d67d0352e..8e95c5bb139921f38f374d2c652844c7f4e96a9b 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -485,7 +485,7 @@ class TypeString(Type):
         ri.cw.p(f"char *{self.c_name};")
 
     def _attr_typol(self):
-        typol = f'.type = YNL_PT_NUL_STR, '
+        typol = '.type = YNL_PT_NUL_STR, '
         if self.is_selector:
             typol += '.is_selector = 1, '
         return typol
@@ -539,7 +539,7 @@ class TypeBinary(Type):
         ri.cw.p(f"void *{self.c_name};")
 
     def _attr_typol(self):
-        return f'.type = YNL_PT_BINARY,'
+        return '.type = YNL_PT_BINARY,'
 
     def _attr_policy(self, policy):
         if len(self.checks) == 0:
@@ -636,7 +636,7 @@ class TypeBitfield32(Type):
         return "struct nla_bitfield32"
 
     def _attr_typol(self):
-        return f'.type = YNL_PT_BITFIELD32, '
+        return '.type = YNL_PT_BITFIELD32, '
 
     def _attr_policy(self, policy):
         if not 'enum' in self.attr:
@@ -909,7 +909,7 @@ class TypeSubMessage(TypeNest):
         else:
             sel_var = f"{var}->{sel}"
         get_lines = [f'if (!{sel_var})',
-                     f'return ynl_submsg_failed(yarg, "%s", "%s");' %
+                     'return ynl_submsg_failed(yarg, "%s", "%s");' %
                         (self.name, self['selector']),
                     f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",
                      "return YNL_PARSE_CB_ERROR;"]
@@ -1563,7 +1563,7 @@ class RenderInfo:
                 if family.is_classic():
                     self.fixed_hdr_len = f"sizeof(struct {c_lower(fixed_hdr)})"
                 else:
-                    raise Exception(f"Per-op fixed header not supported, yet")
+                    raise Exception("Per-op fixed header not supported, yet")
 
 
         # 'do' and 'dump' response parsing is identical
@@ -2099,7 +2099,7 @@ def _multi_parse(ri, struct, init_lines, local_vars):
             if ri.family.is_classic():
                 iter_line = f"ynl_attr_for_each(attr, nlh, sizeof({struct.fixed_header}))"
             else:
-                raise Exception(f"Per-op fixed header not supported, yet")
+                raise Exception("Per-op fixed header not supported, yet")
 
     array_nests = set()
     multi_attrs = set()
@@ -2502,7 +2502,7 @@ def print_free_prototype(ri, direction, suffix=';'):
 
 def print_nlflags_set(ri, direction):
     name = op_prefix(ri, direction)
-    ri.cw.write_func_prot(f'static inline void', f"{name}_set_nlflags",
+    ri.cw.write_func_prot('static inline void', f"{name}_set_nlflags",
                           [f"struct {name} *req", "__u16 nl_flags"])
     ri.cw.block_start()
     ri.cw.p('req->_nlmsg_flags = nl_flags;')
@@ -2533,7 +2533,7 @@ def _print_type(ri, direction, struct):
             line = attr.presence_member(ri.ku_space, type_filter)
             if line:
                 if not meta_started:
-                    ri.cw.block_start(line=f"struct")
+                    ri.cw.block_start(line="struct")
                     meta_started = True
                 ri.cw.p(line)
         if meta_started:
@@ -2697,7 +2697,7 @@ def print_dump_type_free(ri):
     ri.cw.nl()
 
     _free_type_members(ri, 'rsp', ri.struct['reply'], ref='obj.')
-    ri.cw.p(f'free(rsp);')
+    ri.cw.p('free(rsp);')
     ri.cw.block_end()
     ri.cw.block_end()
     ri.cw.nl()
@@ -2708,7 +2708,7 @@ def print_ntf_type_free(ri):
     ri.cw.block_start()
     _free_type_members_iter(ri, ri.struct['reply'])
     _free_type_members(ri, 'rsp', ri.struct['reply'], ref='obj.')
-    ri.cw.p(f'free(rsp);')
+    ri.cw.p('free(rsp);')
     ri.cw.block_end()
     ri.cw.nl()
 
@@ -3322,7 +3322,7 @@ def render_user_family(family, cw, prototype):
     cw.block_start(f'{symbol} = ')
     cw.p(f'.name\t\t= "{family.c_name}",')
     if family.is_classic():
-        cw.p(f'.is_classic\t= true,')
+        cw.p('.is_classic\t= true,')
         cw.p(f'.classic_id\t= {family.get("protonum")},')
     if family.is_classic():
         if family.fixed_header:

-- 
2.51.0


