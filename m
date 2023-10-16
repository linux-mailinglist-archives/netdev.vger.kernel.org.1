Return-Path: <netdev+bounces-41258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6395D7CA633
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD651C208EE
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388D520B16;
	Mon, 16 Oct 2023 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="j60lycTO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC72BF4E5
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:02:36 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A588583
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:02:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9be7e3fa1daso309189766b.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697454152; x=1698058952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2s4irllAw5wL2KJjp/hI8Dn/T6i4YEdKEe+FKiiZQc8=;
        b=j60lycTOJHYSZww2hDJsmasQ43m8UKjCGSTYc3/Sb9rcU0Er/TgdRLfv+zOnFnQktK
         5QlqGfaFulQmpWfmdAWtcmOslSJdPwxpP11RXRS6XvK2HBOSgkKP3/ZahzNAx6Ym3AQe
         uTeGWkxBcGysVfo7M/urKlii2q17iKMTqYaoJWA0znzObE9bajF/atOVY6VeXIjwyEUU
         jXQG1TRGdlxXWvDJ+KkwYmMAs45cx6vztir5Df8sLNgNBsPwCxqLhCNzZMJubb/fnFYJ
         wgU7G6BEVSWvfbf6LVX8DxEYrKk9Wx0g/l/NYesEoddBrER5jYlMLBj8y8PpjG4Rt2WO
         1zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697454152; x=1698058952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2s4irllAw5wL2KJjp/hI8Dn/T6i4YEdKEe+FKiiZQc8=;
        b=nztaqi3s35e0iuMaHOT+iRQMRM1mliVZUGvqDxpO+gSSnqbdfwnN+LP7N/7zheU79O
         44g1mZtLd9UH8vFM2EQeBbMxAa2rC5QHTb2VSMx8UIOhVGWCjhygpoSCx+uMmNqRhYHt
         Rsfm3GRiWOYt8RSIGcrF5UkwfvWyy3Tuc38+Xaug7H77X2Lr+7rMWqLx4le2y1z2/0IR
         2/PEjDrwVd8ypz0B5UwdT/cZiGKqeN1BWZ48qpY7jbq5e4T/8thVDVIEVTRv1H42V4zy
         IvliYCZQliTItHJmvmoteflRJFRK1aBW3Lu1gBTuRndeg2zYiGFlw1lmYoK8bDOxttud
         pxgA==
X-Gm-Message-State: AOJu0YypqnLCJuhnkdjAHMoOOfPHn5655h+1fkvSPOIM5MONxrzyddiQ
	PVPVlScouB2ykgbmDFVZrFFvGoZX390sFhzc6nNKcQ==
X-Google-Smtp-Source: AGHT+IENVIWALorQH2OiWDOyz6WsAFNSeJhdx8Z42lccMnmxYZ37bFZlBbqNKz8wWcSK0rdGo15NgQ==
X-Received: by 2002:a17:907:d1b:b0:9c2:4d0a:c568 with SMTP id gn27-20020a1709070d1b00b009c24d0ac568mr3927885ejc.64.1697454151865;
        Mon, 16 Oct 2023 04:02:31 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709062b4a00b009ad7fc17b2asm3841145ejg.224.2023.10.16.04.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:02:25 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v2] tools: ynl: introduce option to process unknown attributes or types
Date: Mon, 16 Oct 2023 13:02:22 +0200
Message-ID: <20231016110222.465453-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
v1->v2:
- changed to process unknown attributes and type instead of ignoring them
---
 tools/net/ynl/cli.py     |  3 ++-
 tools/net/ynl/lib/ynl.py | 32 +++++++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 6 deletions(-)

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
index 13c4b019a881..fe63e66694bb 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -403,11 +403,24 @@ class GenlProtocol(NetlinkProtocol):
 #
 
 
+class FakeSpecAttr:
+    def __init__(self, name):
+        self.dict = {"name": name, "type": None}
+        self.is_multi = False
+
+    def __getitem__(self, key):
+        return self.dict[key]
+
+    def __contains__(self, key):
+        return key in self.dict
+
+
 class YnlFamily(SpecFamily):
-    def __init__(self, def_path, schema=None):
+    def __init__(self, def_path, schema=None, process_unknown=False):
         super().__init__(def_path, schema)
 
         self.include_raw = False
+        self.process_unknown = process_unknown
 
         try:
             if self.proto == "netlink-raw":
@@ -513,13 +526,16 @@ class YnlFamily(SpecFamily):
         return decoded
 
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
+                attr_spec = FakeSpecAttr(str(attr.type))
             if attr_spec["type"] == 'nest':
                 subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'])
                 decoded = subdict
@@ -534,7 +550,13 @@ class YnlFamily(SpecFamily):
             elif attr_spec["type"] == 'array-nest':
                 decoded = self._decode_array_nest(attr, attr_spec)
             else:
-                raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
+                if not self.process_unknown:
+                    raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
+                if attr._type & Netlink.NLA_F_NESTED:
+                    subdict = self._decode(NlAttrs(attr.raw), None)
+                    decoded = subdict
+                else:
+                    decoded = attr.as_bin()
 
             if 'enum' in attr_spec:
                 decoded = self._decode_enum(decoded, attr_spec)
-- 
2.41.0


