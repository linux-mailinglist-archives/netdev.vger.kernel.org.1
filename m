Return-Path: <netdev+bounces-57829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C18144A6
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBEC28496F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3904318C19;
	Fri, 15 Dec 2023 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp6FGAdm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A319449;
	Fri, 15 Dec 2023 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3363aa1b7d2so335021f8f.0;
        Fri, 15 Dec 2023 01:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633058; x=1703237858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+aCLwBr0m3C/z+wlZGt5/g46Z2nMzvdw5Mc9YgGIA8=;
        b=Dp6FGAdm660PKr/Yz+FLKOP9s05h5Cnat4dsQnM6k+nS/G00gay0UyLGs55eWFs7hu
         okRRqvBvgthOLhtbOFwaj3cGylzo/nX8eDbww0Os3Ljsu5F5XCeEfqP+fXwu5z5dR70f
         X6aHM3Gb78IP7pwW0KwXjskrDy24WihAgpcfQEbUa4Ir/uT5+AcJPdSOyvSV0DNApNv8
         eJzJ0PCVGLygTRSJXKLXTK/aGmTNluRtEOGADgpzN1hkLqJKYtwx0EtNtE3/glkV0OoB
         hfAtvX6e5ufJN5HwdG4+5HOZS4TTSNPKYtM9xb4X7qMxr86S6PF9bvi+wXD0Igm6fpBB
         TXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633058; x=1703237858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+aCLwBr0m3C/z+wlZGt5/g46Z2nMzvdw5Mc9YgGIA8=;
        b=Nxg1lUxpzlT0NMeJlyk6IxuhpVY40ONz+jRcID6fnlRaYvQcfCkBO6nijjLnbutcPZ
         pglqop5Kp6hzBAMem4GrqywpGnqEx8PUNbySckrsWfPmUe/9yZX0231X5s46y4GbiBkY
         C37/hJR4Og31cmN2+a/VKqw6Nm29wH7Qv0cuiiv/xE2SDAH23KeL3v8udxgBDK3nwwYM
         5cfdq1RClRORIUEIyV77HlhSJ2SLWfpt0gwAUsqz1bKRVaJy7+i2rcz0/FT0dxcxQRlR
         miCsKK7S5iONLsW+sSx2hTTS8xwq+oo/hxvkxZOYYQvXKjJVbsVqs3XfPomThrzMa/51
         B/JQ==
X-Gm-Message-State: AOJu0YzfjLRgs0rXjr85nevq3qYyIOuAbvkGNJDZ7VPVe1QLQQgG0+DP
	yLVbnORnZLfUx11ZssHNUf4HMsj4YXpf2g==
X-Google-Smtp-Source: AGHT+IGBVtSo34bTk7Vj6cXVArOafPRlkYX4lE3XVXFjkJ0zYQxVm+iFQJTg7e1SMYTqUo9tWirgSg==
X-Received: by 2002:a05:600c:458d:b0:405:499a:7fc1 with SMTP id r13-20020a05600c458d00b00405499a7fc1mr3960228wmo.40.1702633057703;
        Fri, 15 Dec 2023 01:37:37 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:36 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v5 04/13] tools/net/ynl: Add 'sub-message' attribute decoding to ynl
Date: Fri, 15 Dec 2023 09:37:11 +0000
Message-ID: <20231215093720.18774-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215093720.18774-1-donald.hunter@gmail.com>
References: <20231215093720.18774-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the 'sub-message' attribute type in ynl.

Encode support is not yet implemented. Support for sub-message selectors
at a different nest level from the key attribute is not yet supported.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/nlspec.py | 55 +++++++++++++++++++++++++++++++++++++
 tools/net/ynl/lib/ynl.py    | 48 ++++++++++++++++++++++++++------
 2 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 92889298b197..44f13e383e8a 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -158,6 +158,9 @@ class SpecAttr(SpecElement):
         len           integer, optional byte length of binary types
         display_hint  string, hint to help choose format specifier
                       when displaying the value
+        sub_message   string, name of sub message type
+        selector      string, name of attribute used to select
+                      sub-message type
 
         is_auto_scalar bool, attr is a variable-size scalar
     """
@@ -173,6 +176,8 @@ class SpecAttr(SpecElement):
         self.byte_order = yaml.get('byte-order')
         self.len = yaml.get('len')
         self.display_hint = yaml.get('display-hint')
+        self.sub_message = yaml.get('sub-message')
+        self.selector = yaml.get('selector')
 
         self.is_auto_scalar = self.type == "sint" or self.type == "uint"
 
@@ -278,6 +283,47 @@ class SpecStruct(SpecElement):
         return self.members.items()
 
 
+class SpecSubMessage(SpecElement):
+    """ Netlink sub-message definition
+
+    Represents a set of sub-message formats for polymorphic nlattrs
+    that contain type-specific sub messages.
+
+    Attributes:
+        name     string, name of sub-message definition
+        formats  dict of sub-message formats indexed by match value
+    """
+    def __init__(self, family, yaml):
+        super().__init__(family, yaml)
+
+        self.formats = collections.OrderedDict()
+        for elem in self.yaml['formats']:
+            format = self.new_format(family, elem)
+            self.formats[format.value] = format
+
+    def new_format(self, family, format):
+        return SpecSubMessageFormat(family, format)
+
+
+class SpecSubMessageFormat(SpecElement):
+    """ Netlink sub-message definition
+
+    Represents a set of sub-message formats for polymorphic nlattrs
+    that contain type-specific sub messages.
+
+    Attributes:
+        value         attribute value to match against type selector
+        fixed_header  string, name of fixed header, or None
+        attr_set      string, name of attribute set, or None
+    """
+    def __init__(self, family, yaml):
+        super().__init__(family, yaml)
+
+        self.value = yaml.get('value')
+        self.fixed_header = yaml.get('fixed-header')
+        self.attr_set = yaml.get('attribute-set')
+
+
 class SpecOperation(SpecElement):
     """Netlink Operation
 
@@ -365,6 +411,7 @@ class SpecFamily(SpecElement):
 
         attr_sets  dict of attribute sets
         msgs       dict of all messages (index by name)
+        sub_msgs   dict of all sub messages (index by name)
         ops        dict of all valid requests / responses
         ntfs       dict of all async events
         consts     dict of all constants/enums
@@ -405,6 +452,7 @@ class SpecFamily(SpecElement):
             jsonschema.validate(self.yaml, schema)
 
         self.attr_sets = collections.OrderedDict()
+        self.sub_msgs = collections.OrderedDict()
         self.msgs = collections.OrderedDict()
         self.req_by_value = collections.OrderedDict()
         self.rsp_by_value = collections.OrderedDict()
@@ -441,6 +489,9 @@ class SpecFamily(SpecElement):
     def new_struct(self, elem):
         return SpecStruct(self, elem)
 
+    def new_sub_message(self, elem):
+        return SpecSubMessage(self, elem);
+
     def new_operation(self, elem, req_val, rsp_val):
         return SpecOperation(self, elem, req_val, rsp_val)
 
@@ -529,6 +580,10 @@ class SpecFamily(SpecElement):
             attr_set = self.new_attr_set(elem)
             self.attr_sets[elem['name']] = attr_set
 
+        for elem in self.yaml.get('sub-messages', []):
+            sub_message = self.new_sub_message(elem)
+            self.sub_msgs[sub_message.name] = sub_message
+
         if self.msg_id_model == 'unified':
             self._dictify_ops_unified()
         elif self.msg_id_model == 'directional':
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 5c48f0c9713c..a69fb0c9f728 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -170,10 +170,9 @@ class NlAttr:
 
 
 class NlAttrs:
-    def __init__(self, msg):
+    def __init__(self, msg, offset=0):
         self.attrs = []
 
-        offset = 0
         while offset < len(msg):
             attr = NlAttr(msg, offset)
             offset += attr.full_len
@@ -371,8 +370,8 @@ class NetlinkProtocol:
         fixed_header_size = 0
         if ynl:
             op = ynl.rsp_by_value[msg.cmd()]
-            fixed_header_size = ynl._fixed_header_size(op)
-        msg.raw_attrs = NlAttrs(msg.raw[fixed_header_size:])
+            fixed_header_size = ynl._fixed_header_size(op.fixed_header)
+        msg.raw_attrs = NlAttrs(msg.raw, fixed_header_size)
         return msg
 
     def get_mcast_id(self, mcast_name, mcast_groups):
@@ -549,6 +548,37 @@ class YnlFamily(SpecFamily):
         else:
             rsp[name] = [decoded]
 
+    def _resolve_selector(self, attr_spec, vals):
+        sub_msg = attr_spec.sub_message
+        if sub_msg not in self.sub_msgs:
+            raise Exception(f"No sub-message spec named {sub_msg} for {attr_spec.name}")
+        sub_msg_spec = self.sub_msgs[sub_msg]
+
+        selector = attr_spec.selector
+        if selector not in vals:
+            raise Exception(f"There is no value for {selector} to resolve '{attr_spec.name}'")
+        value = vals[selector]
+        if value not in sub_msg_spec.formats:
+            raise Exception(f"No message format for '{value}' in sub-message spec '{sub_msg}'")
+
+        spec = sub_msg_spec.formats[value]
+        return spec
+
+    def _decode_sub_msg(self, attr, attr_spec, rsp):
+        msg_format = self._resolve_selector(attr_spec, rsp)
+        decoded = {}
+        offset = 0
+        if msg_format.fixed_header:
+            decoded.update(self._decode_fixed_header(attr, msg_format.fixed_header));
+            offset = self._fixed_header_size(msg_format.fixed_header)
+        if msg_format.attr_set:
+            if msg_format.attr_set in self.attr_sets:
+                subdict = self._decode(NlAttrs(attr.raw, offset), msg_format.attr_set)
+                decoded.update(subdict)
+            else:
+                raise Exception(f"Unknown attribute-set '{attr_space}' when decoding '{attr_spec.name}'")
+        return decoded
+
     def _decode(self, attrs, space):
         if space:
             attr_space = self.attr_sets[space]
@@ -586,6 +616,8 @@ class YnlFamily(SpecFamily):
                     value = self._decode_enum(value, attr_spec)
                     selector = self._decode_enum(selector, attr_spec)
                 decoded = {"value": value, "selector": selector}
+            elif attr_spec["type"] == 'sub-message':
+                decoded = self._decode_sub_msg(attr, attr_spec, rsp)
             else:
                 if not self.process_unknown:
                     raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
@@ -626,16 +658,16 @@ class YnlFamily(SpecFamily):
             return
 
         msg = self.nlproto.decode(self, NlMsg(request, 0, op.attr_set))
-        offset = 20 + self._fixed_header_size(op)
+        offset = 20 + self._fixed_header_size(op.fixed_header)
         path = self._decode_extack_path(msg.raw_attrs, op.attr_set, offset,
                                         extack['bad-attr-offs'])
         if path:
             del extack['bad-attr-offs']
             extack['bad-attr'] = path
 
-    def _fixed_header_size(self, op):
-        if op.fixed_header:
-            fixed_header_members = self.consts[op.fixed_header].members
+    def _fixed_header_size(self, name):
+        if name:
+            fixed_header_members = self.consts[name].members
             size = 0
             for m in fixed_header_members:
                 format = NlAttr.get_format(m.type, m.byte_order)
-- 
2.42.0


