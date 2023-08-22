Return-Path: <netdev+bounces-29785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754D2784ABF
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 21:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037312810C0
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6134CF7;
	Tue, 22 Aug 2023 19:43:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B334CCB
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 19:43:32 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B1E40;
	Tue, 22 Aug 2023 12:43:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d20548adso4133553f8f.0;
        Tue, 22 Aug 2023 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733406; x=1693338206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U5t/bm9eLBDk+V/3Le/LavN1ryWDTR0S3SbPHS6Ocs=;
        b=JmsulrqYBUNYK13CLXzRigRyF2lwnJ6iMYZ+3OTqDzQDa3gUazWe3dh5WHAB4SNESN
         Zq24Xx5MVqxHCgiDhMx5quhSqy9+WBo5rC/Tbs/rDDXV8Qe+4Y7vgQbTqYySxfCzKKeU
         StwZClVKiU0Km3u0yX1iXqoGuZT+XZvOvByEWp7dwkZwTzK3A4BF/awxzEQxfQnEabZn
         7DkcEvW5UHX0ZeReK+qhTXX6AOscK27DHdX+lnqcoODn98UQoKjKDtNTOiVM43cyD8wW
         ZTyPcdCFlDMlWg9mVDXpUQxm//yiMYFIbSsvc0Pta7/251la28Bb7MqRTSFWXdfdSG56
         MxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733406; x=1693338206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U5t/bm9eLBDk+V/3Le/LavN1ryWDTR0S3SbPHS6Ocs=;
        b=TJk1wag23DqiaLzjEpqaDeLC/WPoGh/kRhYjVN0iOTvv27bTwCUAtVIkZJPta7xaVN
         w7jvjAYddDmouBKo61Jcwt52VZS4/kiV6FcXfQWmEUPbu1D8sxZ006g3JBr8dNfGYwrJ
         36op7vpqH7HM/5qzCcuV152JsVX5xhL9nb6C+FvWZl88gY/YXR4EwWEddYQjCZPoue7e
         nFDxkF9p3oU4Sl26MY1EJOOkrNEbDivzi4H9UsGl/AlU3Xn4hflc6e23EPoaepRS5ZXT
         0YGM8f6U0/cOeel7UwZ8pRiBMLBSnOM4Zz8zjhBJDCAC+MQRYyg9guiPOj6p9BfAe99B
         6s2A==
X-Gm-Message-State: AOJu0YwnErRR7r3hbgEpnxJy5dwIPNagohBLK+0kOynAzz41o0OHXlVb
	k8JHEzSG10EwB5xLiNRzqcpVffm00BJ2+w==
X-Google-Smtp-Source: AGHT+IErZbUiZBKwC8mPP+n9itqe2ws0M191st5/n2dO6LFmB0RU9dxiqNOJp+wg4Cl1sdJshSSagg==
X-Received: by 2002:a5d:494c:0:b0:319:68ba:7c8e with SMTP id r12-20020a5d494c000000b0031968ba7c8emr7510796wrs.38.1692733406152;
        Tue, 22 Aug 2023 12:43:26 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:3060:22e2:2970:3dc3])
        by smtp.gmail.com with ESMTPSA id f8-20020adfdb48000000b0031934b035d2sm16846067wrj.52.2023.08.22.12.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:43:25 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 07/12] tools/net/ynl: Add support for netlink-raw families
Date: Tue, 22 Aug 2023 20:42:59 +0100
Message-ID: <20230822194304.87488-8-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822194304.87488-1-donald.hunter@gmail.com>
References: <20230822194304.87488-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Refactor the ynl code to encapsulate protocol specifics into
NetlinkProtocol and GenlProtocol.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 122 ++++++++++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 33 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 1d1bc712456e..8ea055c56381 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -25,6 +25,7 @@ class Netlink:
     NETLINK_ADD_MEMBERSHIP = 1
     NETLINK_CAP_ACK = 10
     NETLINK_EXT_ACK = 11
+    NETLINK_GET_STRICT_CHK = 12
 
     # Netlink message
     NLMSG_ERROR = 2
@@ -228,6 +229,9 @@ class NlMsg:
                             desc += f" ({spec['doc']})"
                         self.extack['miss-type'] = desc
 
+    def cmd(self):
+        return self.nl_type
+
     def __repr__(self):
         msg = f"nl_len = {self.nl_len} ({len(self.raw)}) nl_flags = 0x{self.nl_flags:x} nl_type = {self.nl_type}\n"
         if self.error:
@@ -322,6 +326,9 @@ class GenlMsg:
         self.genl_cmd, self.genl_version, _ = struct.unpack_from("BBH", nl_msg.raw, 0)
         self.raw = nl_msg.raw[4:]
 
+    def cmd(self):
+        return self.genl_cmd
+
     def __repr__(self):
         msg = repr(self.nl)
         msg += f"\tgenl_cmd = {self.genl_cmd} genl_ver = {self.genl_version}\n"
@@ -330,9 +337,40 @@ class GenlMsg:
         return msg
 
 
-class GenlFamily:
-    def __init__(self, family_name):
+class NetlinkProtocol:
+    def __init__(self, family_name, proto_num):
         self.family_name = family_name
+        self.proto_num = proto_num
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
+    def _decode(self, nl_msg):
+        return nl_msg
+
+    def decode(self, ynl, nl_msg):
+        msg = self._decode(nl_msg)
+        fixed_header_size = 0
+        if ynl:
+            op = ynl.rsp_by_value[msg.cmd()]
+            fixed_header_size = ynl._fixed_header_size(op)
+        msg.raw_attrs = NlAttrs(msg.raw[fixed_header_size:])
+        return msg
+
+    def get_mcast_id(self, mcast_name, mcast_groups):
+        if mcast_name not in mcast_groups:
+            raise Exception(f'Multicast group "{mcast_name}" not present in the spec')
+        return mcast_groups[mcast_name].value
+
+class GenlProtocol(NetlinkProtocol):
+    def __init__(self, family_name):
+        super().__init__(family_name, Netlink.NETLINK_GENERIC)
 
         global genl_family_name_to_id
         if genl_family_name_to_id is None:
@@ -341,6 +379,18 @@ class GenlFamily:
         self.genl_family = genl_family_name_to_id[family_name]
         self.family_id = genl_family_name_to_id[family_name]['id']
 
+    def message(self, flags, command, version, seq=None):
+        nlmsg = self._message(self.family_id, flags, seq)
+        genlmsg = struct.pack("BBH", command, version, 0)
+        return nlmsg + genlmsg
+
+    def _decode(self, nl_msg):
+        return GenlMsg(nl_msg)
+
+    def get_mcast_id(self, mcast_name, mcast_groups):
+        if mcast_name not in self.genl_family['mcast']:
+            raise Exception(f'Multicast group "{mcast_name}" not present in the family')
+        return self.genl_family['mcast'][mcast_name]
 
 #
 # YNL implementation details.
@@ -353,9 +403,19 @@ class YnlFamily(SpecFamily):
 
         self.include_raw = False
 
-        self.sock = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, Netlink.NETLINK_GENERIC)
+        try:
+            if self.proto == "netlink-raw":
+                self.nlproto = NetlinkProtocol(self.yaml['name'],
+                                               self.yaml['protonum'])
+            else:
+                self.nlproto = GenlProtocol(self.yaml['name'])
+        except KeyError:
+            raise Exception(f"Family '{self.yaml['name']}' not supported by the kernel")
+
+        self.sock = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, self.nlproto.proto_num)
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_CAP_ACK, 1)
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_EXT_ACK, 1)
+        self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_GET_STRICT_CHK, 1)
 
         self.async_msg_ids = set()
         self.async_msg_queue = []
@@ -368,18 +428,12 @@ class YnlFamily(SpecFamily):
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
+        mcast_id = self.nlproto.get_mcast_id(mcast_name, self.mcast_groups)
         self.sock.bind((0, 0))
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
-                             self.family.genl_family['mcast'][mcast_name])
+                             mcast_id)
 
     def _add_attr(self, space, name, value):
         try:
@@ -500,11 +554,9 @@ class YnlFamily(SpecFamily):
         if 'bad-attr-offs' not in extack:
             return
 
-        genl_req = GenlMsg(NlMsg(request, 0, op.attr_set))
-        fixed_header_size = self._fixed_header_size(op)
-        offset = 20 + fixed_header_size
-        path = self._decode_extack_path(NlAttrs(genl_req.raw[fixed_header_size:]),
-                                        op.attr_set, offset,
+        msg = self.nlproto.decode(self, NlMsg(request, 0, op.attr_set))
+        offset = 20 + self._fixed_header_size(op)
+        path = self._decode_extack_path(msg.raw_attrs, op.attr_set, offset,
                                         extack['bad-attr-offs'])
         if path:
             del extack['bad-attr-offs']
@@ -534,14 +586,17 @@ class YnlFamily(SpecFamily):
             fixed_header_attrs[m.name] = value
         return fixed_header_attrs
 
-    def handle_ntf(self, nl_msg, genl_msg):
+    def handle_ntf(self, decoded):
         msg = dict()
         if self.include_raw:
-            msg['nlmsg'] = nl_msg
-            msg['genlmsg'] = genl_msg
-        op = self.rsp_by_value[genl_msg.genl_cmd]
+            msg['raw'] = decoded
+        op = self.rsp_by_value[decoded.cmd()]
+        attrs = self._decode(decoded.raw_attrs, op.attr_set.name)
+        if op.fixed_header:
+            attrs.update(self._decode_fixed_header(gm, op.fixed_header))
+
         msg['name'] = op['name']
-        msg['msg'] = self._decode(genl_msg.raw_attrs, op.attr_set.name)
+        msg['msg'] = attrs
         self.async_msg_queue.append(msg)
 
     def check_ntf(self):
@@ -561,12 +616,12 @@ class YnlFamily(SpecFamily):
                     print("Netlink done while checking for ntf!?")
                     continue
 
-                gm = GenlMsg(nl_msg)
-                if gm.genl_cmd not in self.async_msg_ids:
-                    print("Unexpected msg id done while checking for ntf", gm)
+                decoded = self.nlproto.decode(self, nl_msg)
+                if decoded.cmd() not in self.async_msg_ids:
+                    print("Unexpected msg id done while checking for ntf", decoded)
                     continue
 
-                self.handle_ntf(nl_msg, gm)
+                self.handle_ntf(decoded)
 
     def operation_do_attributes(self, name):
       """
@@ -587,7 +642,7 @@ class YnlFamily(SpecFamily):
             nl_flags |= Netlink.NLM_F_DUMP
 
         req_seq = random.randint(1024, 65535)
-        msg = _genl_msg(self.family.family_id, nl_flags, op.req_value, 1, req_seq)
+        msg = self.nlproto.message(nl_flags, op.req_value, 1, req_seq)
         fixed_header_members = []
         if op.fixed_header:
             fixed_header_members = self.consts[op.fixed_header].members
@@ -619,19 +674,20 @@ class YnlFamily(SpecFamily):
                     done = True
                     break
 
-                gm = GenlMsg(nl_msg)
+                decoded = self.nlproto.decode(self, nl_msg)
+
                 # Check if this is a reply to our request
-                if nl_msg.nl_seq != req_seq or gm.genl_cmd != op.rsp_value:
-                    if gm.genl_cmd in self.async_msg_ids:
-                        self.handle_ntf(nl_msg, gm)
+                if nl_msg.nl_seq != req_seq or decoded.cmd() != op.rsp_value:
+                    if decoded.cmd() in self.async_msg_ids:
+                        self.handle_ntf(decoded)
                         continue
                     else:
-                        print('Unexpected message: ' + repr(gm))
+                        print('Unexpected message: ' + repr(decoded))
                         continue
 
-                rsp_msg = self._decode(NlAttrs(gm.raw), op.attr_set.name)
+                rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
                 if op.fixed_header:
-                    rsp_msg.update(self._decode_fixed_header(gm, op.fixed_header))
+                    rsp_msg.update(self._decode_fixed_header(decoded, op.fixed_header))
                 rsp.append(rsp_msg)
 
         if not rsp:
-- 
2.41.0


