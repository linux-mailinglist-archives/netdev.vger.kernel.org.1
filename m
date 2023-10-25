Return-Path: <netdev+bounces-44129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7C27D67AD
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 11:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA242811D9
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8721123775;
	Wed, 25 Oct 2023 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="euGAgP2P"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F8224F1
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 09:57:44 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED21DE
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 02:57:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32daeed7771so3598298f8f.3
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698227859; x=1698832659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S4ZtsZSf8iGAkU9Y47c3kfbQ9My3LTOwyo7xGwJRRCU=;
        b=euGAgP2PjaBUpgr0wWfl5Ia2Z3WlqAk7ZWxcwVUbXum/1xhgkrfYC03ggc3wXuCVfm
         5P2+XGwaJicYK0tg8z0bOC8FIIHxMxKodKk7pVt0LEvR+E93WAavWwynLLGiUA6MA4qp
         TXeh+uC/x9n215Mh8BSZjDvqAPXi5kEY5MUyGdNrdXmLQcJMTgKUrjamkThQ3kn1O2nT
         ulvGJkIpRsQrQsNdxCB4imNujhXLV21KZWBzwXTH6xBirGkaxiMbNCkuMR3kM8bCWBI9
         cYw59PvYWD6GsHi5y8zpat7lAoWybb1cksVCSZaDOo0+wAKDnrWg2/Uh9CVIFbS0isla
         M7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698227859; x=1698832659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4ZtsZSf8iGAkU9Y47c3kfbQ9My3LTOwyo7xGwJRRCU=;
        b=wRxMPymlnXaJsm4ggxorM4N888/Pz3FR5Me75SQu7FiQV9553Cb1JVynAixxSu5U1e
         AJpO5BCMQvgmHkILTQtomV2PhW+JXqs6NlP/JzfI028ghvU2sY+oXKFhS5GjDwqDJrG+
         xU6xvJeFyKPL2lbKQo8hVKyQSJtZctqahZyt+7gP/q2rFcS9u9DfsIY2ebKfe44fMM/2
         je1DnwSyqFEpavODLanH7r1ku34KsqJBQyB/XxwRPweX9EVgLww5a2jZAhT/7FLJSDBv
         isCf5k+CPOTyAGCXbHvuC49P9lOzHUuvRlo8b7yHIrYiOOwnmpviK3GXvJQrrcBFuFLS
         4d+w==
X-Gm-Message-State: AOJu0YwnQIjR8n2MPXhS3+/p9O+lQNuF9DrfsyZ0JAi66fNIn1agk1wz
	s4rbJlgN2Le7KWWa5Gkhn2kO/LyuIq9XzB4LjOA=
X-Google-Smtp-Source: AGHT+IEw9joUPi6CRAEAaVR92Z+TJ8tGxxznfQ0jOm8gb+rX4GksugltqiQRMb3skya+70CtfmW6EA==
X-Received: by 2002:a5d:6310:0:b0:32d:a236:b6f4 with SMTP id i16-20020a5d6310000000b0032da236b6f4mr12506630wru.50.1698227858841;
        Wed, 25 Oct 2023 02:57:38 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f9-20020adff449000000b0032d81837433sm11712727wrp.30.2023.10.25.02.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:57:38 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v3] tools: ynl: introduce option to process unknown attributes or types
Date: Wed, 25 Oct 2023 11:57:36 +0200
Message-ID: <20231025095736.801231-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In case the kernel sends message back containing attribute not defined
in family spec, following exception is raised to the user:

$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do trap-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "trap-name": "source_mac_is_multicast"}'
Traceback (most recent call last):
  File "/home/jiri/work/linux/tools/net/ynl/lib/ynl.py", line 521, in _decode
    attr_spec = attr_space.attrs_by_val[attr.type]
                ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
KeyError: 132

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/jiri/work/linux/./tools/net/ynl/cli.py", line 61, in <module>
    main()
  File "/home/jiri/work/linux/./tools/net/ynl/cli.py", line 49, in main
    reply = ynl.do(args.do, attrs, args.flags)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/jiri/work/linux/tools/net/ynl/lib/ynl.py", line 731, in do
    return self._op(method, vals, flags)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/jiri/work/linux/tools/net/ynl/lib/ynl.py", line 719, in _op
    rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/jiri/work/linux/tools/net/ynl/lib/ynl.py", line 525, in _decode
    raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
Exception: Space 'devlink' has no attribute with value '132'

Introduce a command line option "process-unknown" and pass it down to
YnlFamily class constructor to allow user to process unknown
attributes and types and print them as binaries.

$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do trap-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "trap-name": "source_mac_is_multicast"}' --process-unknown
{'129': {'0': b'\x00\x00\x00\x00\x00\x00\x00\x00',
         '1': b'\x00\x00\x00\x00\x00\x00\x00\x00',
         '2': b'(\x00\x00\x00\x00\x00\x00\x00'},
 '132': b'\x00',
 '133': b'',
 '134': {'0': b''},
 'bus-name': 'netdevsim',
 'dev-name': 'netdevsim1',
 'trap-action': 'drop',
 'trap-group-name': 'l2_drops',
 'trap-name': 'source_mac_is_multicast'}

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- rebased on top of previous patchset and recent net-next
- removed fake attr spec class
- introduced "attr.is_nest" and using it instead of direct access
  to "attr._type"
- pushed out rsp value addition into separate helper and sanitize
  the unknown attr is possibly multi-value there
- pushed out unknown attr decode into separate helper
v1->v2:
- changed to process unknown attributes and type instead of ignoring them
---
 tools/net/ynl/cli.py     |  3 ++-
 tools/net/ynl/lib/ynl.py | 47 ++++++++++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index 564ecf07cd2c..2ad9ec0f5545 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -27,6 +27,7 @@ def main():
                         const=Netlink.NLM_F_CREATE)
     parser.add_argument('--append', dest='flags', action='append_const',
                         const=Netlink.NLM_F_APPEND)
+    parser.add_argument('--process-unknown', action=argparse.BooleanOptionalAction)
     args = parser.parse_args()
 
     if args.no_schema:
@@ -36,7 +37,7 @@ def main():
     if args.json_text:
         attrs = json.loads(args.json_text)
 
-    ynl = YnlFamily(args.spec, args.schema)
+    ynl = YnlFamily(args.spec, args.schema, args.process_unknown)
 
     if args.ntf:
         ynl.ntf_subscribe(args.ntf)
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index b1da4aea9336..9e4ac9575313 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -100,6 +100,7 @@ class NlAttr:
     def __init__(self, raw, offset):
         self._len, self._type = struct.unpack("HH", raw[offset:offset + 4])
         self.type = self._type & ~Netlink.NLA_TYPE_MASK
+        self.is_nest = self._type & Netlink.NLA_F_NESTED
         self.payload_len = self._len
         self.full_len = (self.payload_len + 3) & ~3
         self.raw = raw[offset + 4:offset + self.payload_len]
@@ -411,10 +412,11 @@ class GenlProtocol(NetlinkProtocol):
 
 
 class YnlFamily(SpecFamily):
-    def __init__(self, def_path, schema=None):
+    def __init__(self, def_path, schema=None, process_unknown=False):
         super().__init__(def_path, schema)
 
         self.include_raw = False
+        self.process_unknown = process_unknown
 
         try:
             if self.proto == "netlink-raw":
@@ -526,14 +528,40 @@ class YnlFamily(SpecFamily):
             decoded.append({ item.type: subattrs })
         return decoded
 
+    def _decode_unknown(self, attr):
+        if attr.is_nest:
+            return self._decode(NlAttrs(attr.raw), None)
+        else:
+            return attr.as_bin()
+
+    def _rsp_add(self, rsp, name, is_multi, decoded):
+        if is_multi == None:
+            if name in rsp and type(rsp[name]) is not list:
+                rsp[name] = [rsp[name]]
+                is_multi = True
+            else:
+                is_multi = False
+
+        if not is_multi:
+            rsp[name] = decoded
+        elif name in rsp:
+            rsp[name].append(decoded)
+        else:
+            rsp[name] = [decoded]
+
     def _decode(self, attrs, space):
-        attr_space = self.attr_sets[space]
+        if space:
+            attr_space = self.attr_sets[space]
         rsp = dict()
         for attr in attrs:
             try:
                 attr_spec = attr_space.attrs_by_val[attr.type]
-            except KeyError:
-                raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
+            except (KeyError, UnboundLocalError):
+                if not self.process_unknown:
+                    raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
+                self._rsp_add(rsp, str(attr.type), None, self._decode_unknown(attr))
+                continue
+
             if attr_spec["type"] == 'nest':
                 subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'])
                 decoded = subdict
@@ -558,14 +586,11 @@ class YnlFamily(SpecFamily):
                     selector = self._decode_enum(selector, attr_spec)
                 decoded = {"value": value, "selector": selector}
             else:
-                raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
+                if not self.process_unknown:
+                    raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
+                decoded = self._decode_unknown(attr)
 
-            if not attr_spec.is_multi:
-                rsp[attr_spec['name']] = decoded
-            elif attr_spec.name in rsp:
-                rsp[attr_spec.name].append(decoded)
-            else:
-                rsp[attr_spec.name] = [decoded]
+            self._rsp_add(rsp, attr_spec["name"], attr_spec.is_multi, decoded)
 
         return rsp
 
-- 
2.41.0


