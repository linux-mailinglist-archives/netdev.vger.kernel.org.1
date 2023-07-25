Return-Path: <netdev+bounces-20920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4004F761E5F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634221C208F5
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E12419D;
	Tue, 25 Jul 2023 16:22:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7B1F173
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:22:30 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D0B97
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:22:25 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbea147034so46622975e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690302143; x=1690906943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2aU+fhNmlYn4kumEMT5OQAqPy+r27FthMMMPBnNHC0=;
        b=K7LwJImhlxM7wWeCubGhtEp8saGLcBVgQxmKioQwPQS9jQ4gWZ2QFBh+vzkzdgD325
         wGZZNXma4Gpoh83VpUiq7oJrwkaC0SIakH4r8qm/Ak7EK77tcFScLoJWN474z67zmWYp
         33Tx44nQOYv4u6eqxkCKq0shdS1qPhppnH0ytUL5Nwt8/lSbah7FXz8dU0cNTzFksazl
         QzZMwfp+8iNSvSF8I09Eec3cWCYP82NOyH6RlLax5vrJf8Bszy/CfDovsqwKuTcahXft
         EzYOjdf9gjT08O/tqqZSvld1zZ0zJqOPgZbLbISuQPL4L7SdiLayR0v87gBYsI+HhhnW
         K+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690302143; x=1690906943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2aU+fhNmlYn4kumEMT5OQAqPy+r27FthMMMPBnNHC0=;
        b=eRXXUsB7yFehkKzxpC38z3SE8HvcfC8b1UecuYudU3VLHXBR8gj0q26LWWgn3sbI9P
         C+PdD9OsRJ+3S+qXIOObDzpQnp1LYO2y/OQKMVrljJy7si4F9Q2wBMy6ysZaCzVmG8Dx
         d3xefXI+Ktxd+LpU/2VP03pz1xq5m1jyePVE2EdmAKfcbKmgx7Aud/mOHGNwc9RjzrtS
         nUMjjeOD4Jfnpu5Sifh+CCjMz+m8TsOZxvR4fndX+/2cmMpn3LH8wNmaNd/Dy/OJ2vx/
         9spHJOsIVfmbxdc6EvUwCTHjGHGH83HF6g3WODleRgX9cs/VJBQwSCgOOYRa8UjgQmvL
         o45w==
X-Gm-Message-State: ABy/qLYaQrkcVQCPrBos+ooOi8WgUQ9cttOJjz9Hc+tXhXWBaHl67zpT
	/atjClpw8bk8jqLZN8u/9ZPinTfUM7nRXQ23
X-Google-Smtp-Source: APBJJlGbq2jHbJp3lDvVYlHSXTJph+2HubPDLzcH8KG3tsFgFHY7apSOpu+9qayL4NkhltSqczpW/g==
X-Received: by 2002:a7b:ce0e:0:b0:3fa:934c:8360 with SMTP id m14-20020a7bce0e000000b003fa934c8360mr8924900wmc.8.1690302142579;
        Tue, 25 Jul 2023 09:22:22 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:255e:7dc3:bcb1:e213])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c294300b003fc01f7a42dsm13661303wmd.8.2023.07.25.09.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:22:21 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 2/3] tools/net/ynl: Add support for netlink-raw families
Date: Tue, 25 Jul 2023 17:22:04 +0100
Message-ID: <20230725162205.27526-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725162205.27526-1-donald.hunter@gmail.com>
References: <20230725162205.27526-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Refactor the ynl code to encapsulate protocol-family specifics into
NetlinkProtocolFamily and GenlProtocolFamily.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/nlspec.py |  25 +++++
 tools/net/ynl/lib/ynl.py    | 185 +++++++++++++++++++++++++-----------
 2 files changed, 156 insertions(+), 54 deletions(-)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 0ff0d18666b2..6072c9f35223 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -322,6 +322,20 @@ class SpecOperation(SpecElement):
             self.attr_set = self.family.attr_sets[attr_set_name]
 
 
+class SpecMcastGroup(SpecElement):
+    """Netlink Multicast Group
+
+    Information about a multicast group.
+
+    Attributes:
+        id        numerical id of this multicast group for netlink-raw
+        yaml      raw spec as loaded from the spec file
+    """
+    def __init__(self, family, yaml):
+        super().__init__(family, yaml)
+        self.id = self.yaml.get('id')
+
+
 class SpecFamily(SpecElement):
     """ Netlink Family Spec class.
 
@@ -343,6 +357,7 @@ class SpecFamily(SpecElement):
         ntfs       dict of all async events
         consts     dict of all constants/enums
         fixed_header  string, optional name of family default fixed header struct
+        mcast_groups  dict of all multicast groups (index by name)
     """
     def __init__(self, spec_path, schema_path=None, exclude_ops=None):
         with open(spec_path, "r") as stream:
@@ -384,6 +399,7 @@ class SpecFamily(SpecElement):
         self.ops = collections.OrderedDict()
         self.ntfs = collections.OrderedDict()
         self.consts = collections.OrderedDict()
+        self.mcast_groups = collections.OrderedDict()
 
         last_exception = None
         while len(self._resolution_list) > 0:
@@ -416,6 +432,9 @@ class SpecFamily(SpecElement):
     def new_operation(self, elem, req_val, rsp_val):
         return SpecOperation(self, elem, req_val, rsp_val)
 
+    def new_mcast_group(self, elem):
+        return SpecMcastGroup(self, elem)
+
     def add_unresolved(self, elem):
         self._resolution_list.append(elem)
 
@@ -512,3 +531,9 @@ class SpecFamily(SpecElement):
                 self.ops[op.name] = op
             elif op.is_async:
                 self.ntfs[op.name] = op
+
+        mcgs = self.yaml.get('mcast-groups')
+        if mcgs:
+            for elem in mcgs['list']:
+                mcg = self.new_mcast_group(elem)
+                self.mcast_groups[elem['name']] = mcg
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 3e2ade2194cd..7e877c43e10f 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -25,6 +25,7 @@ class Netlink:
     NETLINK_ADD_MEMBERSHIP = 1
     NETLINK_CAP_ACK = 10
     NETLINK_EXT_ACK = 11
+    NETLINK_GET_STRICT_CHK = 12
 
     # Netlink message
     NLMSG_ERROR = 2
@@ -153,6 +154,21 @@ class NlAttr:
             value[m.name] = decoded
         return value
 
+    @classmethod
+    def decode_enum(cls, raw, attr_spec, consts):
+        enum = consts[attr_spec['enum']]
+        if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
+            i = 0
+            value = set()
+            while raw:
+                if raw & 1:
+                    value.add(enum.entries_by_val[i].name)
+                raw >>= 1
+                i += 1
+        else:
+            value = enum.entries_by_val[raw].name
+        return value
+
     def __repr__(self):
         return f"[type:{self.type} len:{self._len}] {self.raw}"
 
@@ -190,6 +206,7 @@ class NlMsg:
 
         self.error = 0
         self.done = 0
+        self.fixed_header_attrs = []
 
         extack_off = None
         if self.nl_type == Netlink.NLMSG_ERROR:
@@ -229,6 +246,24 @@ class NlMsg:
                             desc += f" ({spec['doc']})"
                         self.extack['miss-type'] = desc
 
+    def decode_fixed_header(self, consts, op):
+        fixed_header_members = consts[op.fixed_header].members
+        self.fixed_header_attrs = dict()
+        offset = 0
+        for m in fixed_header_members:
+            format = NlAttr.get_format(m.type, m.byte_order)
+            [ value ] = format.unpack_from(self.raw, offset)
+            offset += format.size
+
+            if m.enum:
+                value = NlAttr.decode_enum(value, m, consts)
+
+            self.fixed_header_attrs[m.name] = value
+        self.raw = self.raw[offset:]
+
+    def cmd(self):
+        return self.nl_type
+
     def __repr__(self):
         msg = f"nl_len = {self.nl_len} ({len(self.raw)}) nl_flags = 0x{self.nl_flags:x} nl_type = {self.nl_type}\n"
         if self.error:
@@ -318,23 +353,21 @@ def _genl_load_families():
 
 
 class GenlMsg:
-    def __init__(self, nl_msg, fixed_header_members=[]):
-        self.nl = nl_msg
+    def __init__(self, nl_msg, ynl=None):
+        self.genl_cmd, self.genl_version, _ = struct.unpack_from("BBH", nl_msg.raw, 0)
+        nl_msg.raw = nl_msg.raw[4:]
 
-        self.hdr = nl_msg.raw[0:4]
-        offset = 4
+        if ynl:
+            op = ynl.rsp_by_value[self.genl_cmd]
+            if op.fixed_header:
+                nl_msg.decode_fixed_header(ynl.consts, op)
 
-        self.genl_cmd, self.genl_version, _ = struct.unpack("BBH", self.hdr)
-
-        self.fixed_header_attrs = dict()
-        for m in fixed_header_members:
-            format = NlAttr.get_format(m.type, m.byte_order)
-            decoded = format.unpack_from(nl_msg.raw, offset)
-            offset += format.size
-            self.fixed_header_attrs[m.name] = decoded[0]
-
-        self.raw = nl_msg.raw[offset:]
+        self.raw = nl_msg.raw
         self.raw_attrs = NlAttrs(self.raw)
+        self.fixed_header_attrs = nl_msg.fixed_header_attrs
+
+    def cmd(self):
+        return self.genl_cmd
 
     def __repr__(self):
         msg = repr(self.nl)
@@ -344,9 +377,35 @@ class GenlMsg:
         return msg
 
 
-class GenlFamily:
-    def __init__(self, family_name):
+class NetlinkProtocolFamily:
+    def __init__(self, family_name, proto_num):
         self.family_name = family_name
+        self.proto = proto_num
+
+    def _message(self, nl_type, nl_flags, seq=None):
+        if seq is None:
+            seq = random.randint(1, 1024)
+        nlmsg = struct.pack("HHII", nl_type, nl_flags, seq, 0)
+        return nlmsg
+
+    def message(self, flags, command, version, seq=None):
+        return self._message(command, flags, seq)
+
+    def decode(self, ynl, nl_msg):
+        op = ynl.rsp_by_value[nl_msg.nl_type]
+        if op.fixed_header:
+            nl_msg.decode_fixed_header(ynl.consts, op)
+        nl_msg.raw_attrs = NlAttrs(nl_msg.raw)
+        return nl_msg
+
+    def get_mcast_id(self, mcast_name, mcast_groups):
+        if mcast_name not in mcast_groups:
+            raise Exception(f'Multicast group "{mcast_name}" not present in the spec')
+        return mcast_groups[mcast_name].id
+
+class GenlProtocolFamily(NetlinkProtocolFamily):
+    def __init__(self, family_name):
+        super().__init__(family_name, Netlink.NETLINK_GENERIC)
 
         global genl_family_name_to_id
         if genl_family_name_to_id is None:
@@ -355,6 +414,18 @@ class GenlFamily:
         self.genl_family = genl_family_name_to_id[family_name]
         self.family_id = genl_family_name_to_id[family_name]['id']
 
+    def message(self, flags, command, version, seq=None):
+        nlmsg = self._message(self.family_id, flags, seq)
+        genlmsg = struct.pack("BBH", command, version, 0)
+        return nlmsg + genlmsg
+
+    def decode(self, ynl, nl_msg):
+        return GenlMsg(nl_msg, ynl)
+
+    def get_mcast_id(self, mcast_name, mcast_groups):
+        if mcast_name not in self.genl_family['mcast']:
+            raise Exception(f'Multicast group "{mcast_name}" not present in the family')
+        return self.genl_family['mcast'][mcast_name]
 
 #
 # YNL implementation details.
@@ -367,9 +438,19 @@ class YnlFamily(SpecFamily):
 
         self.include_raw = False
 
-        self.sock = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, Netlink.NETLINK_GENERIC)
+        try:
+            if self.proto == "netlink-raw":
+                self.family = NetlinkProtocolFamily(self.yaml['name'],
+                                                    self.yaml['protonum'])
+            else:
+                self.family = GenlProtocolFamily(self.yaml['name'])
+        except KeyError:
+            raise Exception(f"Family '{self.yaml['name']}' not supported by the kernel")
+
+        self.sock = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, self.family.proto)
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_CAP_ACK, 1)
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_EXT_ACK, 1)
+        self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_GET_STRICT_CHK, 1)
 
         self.async_msg_ids = set()
         self.async_msg_queue = []
@@ -382,18 +463,12 @@ class YnlFamily(SpecFamily):
             bound_f = functools.partial(self._op, op_name)
             setattr(self, op.ident_name, bound_f)
 
-        try:
-            self.family = GenlFamily(self.yaml['name'])
-        except KeyError:
-            raise Exception(f"Family '{self.yaml['name']}' not supported by the kernel")
 
     def ntf_subscribe(self, mcast_name):
-        if mcast_name not in self.family.genl_family['mcast']:
-            raise Exception(f'Multicast group "{mcast_name}" not present in the family')
-
+        mcast_id = self.family.get_mcast_id(mcast_name, self.mcast_groups)
         self.sock.bind((0, 0))
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
-                             self.family.genl_family['mcast'][mcast_name])
+                             mcast_id)
 
     def _add_attr(self, space, name, value):
         attr = self.attr_sets[space][name]
@@ -419,23 +494,12 @@ class YnlFamily(SpecFamily):
         return struct.pack('HH', len(attr_payload) + 4, nl_type) + attr_payload + pad
 
     def _decode_enum(self, raw, attr_spec):
-        enum = self.consts[attr_spec['enum']]
-        if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
-            i = 0
-            value = set()
-            while raw:
-                if raw & 1:
-                    value.add(enum.entries_by_val[i].name)
-                raw >>= 1
-                i += 1
-        else:
-            value = enum.entries_by_val[raw].name
-        return value
+        return NlAttr.decode_enum(raw, attr_spec, self.consts)
 
     def _decode_binary(self, attr, attr_spec):
         if attr_spec.struct_name:
             members = self.consts[attr_spec.struct_name]
-            decoded = attr.as_struct(members)
+            decoded = attr.as_struct(members, self.consts)
             for m in members:
                 if m.enum:
                      decoded[m.name] = self._decode_enum(decoded[m.name], m)
@@ -451,12 +515,21 @@ class YnlFamily(SpecFamily):
         attr_space = self.attr_sets[space]
         rsp = dict()
         for attr in attrs:
-            attr_spec = attr_space.attrs_by_val[attr.type]
+            try:
+                attr_spec = attr_space.attrs_by_val[attr.type]
+            except KeyError:
+                print(f"No attribute spec for {attr.type} in attribute space {space}, skipping.")
+                continue
+
             if attr_spec["type"] == 'nest':
                 subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'])
                 decoded = subdict
             elif attr_spec["type"] == 'string':
-                decoded = attr.as_strz()
+                try:
+                    decoded = attr.as_strz()
+                except UnicodeDecodeError:
+                    print(f"Failed to decode string {attr_spec['name']}, skipping")
+                    continue
             elif attr_spec["type"] == 'binary':
                 decoded = self._decode_binary(attr, attr_spec)
             elif attr_spec["type"] == 'flag':
@@ -517,9 +590,12 @@ class YnlFamily(SpecFamily):
         if self.include_raw:
             msg['nlmsg'] = nl_msg
             msg['genlmsg'] = genl_msg
-        op = self.rsp_by_value[genl_msg.genl_cmd]
+        op = self.rsp_by_value[genl_msg.cmd()]
+        decoded = self._decode(genl_msg.raw_attrs, op.attr_set.name)
+        decoded.update(genl_msg.fixed_header_attrs)
+
         msg['name'] = op['name']
-        msg['msg'] = self._decode(genl_msg.raw_attrs, op.attr_set.name)
+        msg['msg'] = decoded
         self.async_msg_queue.append(msg)
 
     def check_ntf(self):
@@ -539,12 +615,12 @@ class YnlFamily(SpecFamily):
                     print("Netlink done while checking for ntf!?")
                     continue
 
-                gm = GenlMsg(nl_msg)
-                if gm.genl_cmd not in self.async_msg_ids:
-                    print("Unexpected msg id done while checking for ntf", gm)
+                decoded = self.family.decode(self, nl_msg)
+                if decoded.cmd() not in self.async_msg_ids:
+                    print("Unexpected msg id done while checking for ntf", decoded)
                     continue
 
-                self.handle_ntf(nl_msg, gm)
+                self.handle_ntf(nl_msg, decoded)
 
     def operation_do_attributes(self, name):
       """
@@ -565,7 +641,7 @@ class YnlFamily(SpecFamily):
             nl_flags |= Netlink.NLM_F_DUMP
 
         req_seq = random.randint(1024, 65535)
-        msg = _genl_msg(self.family.family_id, nl_flags, op.req_value, 1, req_seq)
+        msg = self.family.message(nl_flags, op.req_value, 1, req_seq)
         fixed_header_members = []
         if op.fixed_header:
             fixed_header_members = self.consts[op.fixed_header].members
@@ -597,18 +673,19 @@ class YnlFamily(SpecFamily):
                     done = True
                     break
 
-                gm = GenlMsg(nl_msg, fixed_header_members)
+                decoded = self.family.decode(self, nl_msg)
+
                 # Check if this is a reply to our request
-                if nl_msg.nl_seq != req_seq or gm.genl_cmd != op.rsp_value:
-                    if gm.genl_cmd in self.async_msg_ids:
-                        self.handle_ntf(nl_msg, gm)
+                if nl_msg.nl_seq != req_seq or decoded.cmd() != op.rsp_value:
+                    if decoded.cmd() in self.async_msg_ids:
+                        self.handle_ntf(nl_msg, decoded)
                         continue
                     else:
-                        print('Unexpected message: ' + repr(gm))
+                        print('Unexpected message: ' + repr(decoded))
                         continue
 
-                rsp_msg = self._decode(gm.raw_attrs, op.attr_set.name)
-                rsp_msg.update(gm.fixed_header_attrs)
+                rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
+                rsp_msg.update(decoded.fixed_header_attrs)
                 rsp.append(rsp_msg)
 
         if not rsp:
-- 
2.41.0


