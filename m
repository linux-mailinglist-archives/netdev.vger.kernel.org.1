Return-Path: <netdev+bounces-40379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29B67C6FFB
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 16:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBEA1C20CA5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E4230D15;
	Thu, 12 Oct 2023 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FkevI9Ca"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE82E659
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:04:44 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E649B8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 07:04:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5347e657a11so1646440a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697119481; x=1697724281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4PI1IGuQDaVrghEOjc0F3JLyx+Om4QiBxZwlz4Mta8=;
        b=FkevI9CaWPd/Wu/sFWr30bokoalXJFti0hLfx8feu4GY4GO+jNNGEZ9EvsQUXQOUzw
         Y2lATenbGVp0G4iIrgV/ifh1kIrhkv1WlQLBZBKYkWZlkS5icotcG8YHylmlxY3ZoC70
         obMABAwOrFOYB1UKchEESnwh2+pUQXNBiCVcbMPXv+O5FywvemrLDPYSE5jVDIlmoUrs
         BX29OAQVS3Wqm88Ih1H5AxA9sadCqXllDyBHKzdIdXhm7vEyrXpWV9kQIFVkbFwHtdlK
         R93c4tcjNoS3YDKuVTyDqpzm99dU1jjlQsTnpTlnpJNisgNyE4rlAwbbRUV38hOIVBNY
         +Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697119481; x=1697724281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4PI1IGuQDaVrghEOjc0F3JLyx+Om4QiBxZwlz4Mta8=;
        b=D7LZ83385DHWuWkcTr6w8haleh/6bAQ79Z8KBuCRzBHtRnCEFvGJukzDbKxczmginu
         rHfkyDIko3177+wGCe2FxT9o7zeuSBAyQCD0qvyYli/CrBzz1dHFKbE6hQQHh8ygeWc+
         hsLbdkQALhAiLlICSY4+7uHiKrhcIr2AB1j08w+ki2CMlQHd844PNwZ2qANFTeGPJ7LT
         tkVlfO6xRPCj7P6laqVe4WVxUpPx77/zRAvdsdi2fQkEjdu0qW7BiCfoxTyyqXVnlnmA
         QRQfGLtUYkOgF71pnoy6KwNLv+LXulcOGJHZd+RW2JDyXuCWMYjFMaLDHTMy9nshsTgi
         hWAw==
X-Gm-Message-State: AOJu0YyIgZhpS35K6qlo/2z8ZY17dmfL1Mkl8g2q8crJLAQkJRzo/yfk
	iFZYwsXK+cwXw/OxIO03f6AVHKTj2L7hvKifVbc=
X-Google-Smtp-Source: AGHT+IEW8iIWKn2KP9bkllJ+LoakS47pHPshmV3rpCOHjWcEZMOtRAE9XbFWJAYopplY8lKsJs+gVQ==
X-Received: by 2002:a17:906:1052:b0:9ba:3caf:999e with SMTP id j18-20020a170906105200b009ba3caf999emr6588845ejj.52.1697119480620;
        Thu, 12 Oct 2023 07:04:40 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id rn4-20020a170906d92400b0099bc038eb2bsm11062599ejb.58.2023.10.12.07.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 07:04:39 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next] tools: ynl: introduce option to ignore unknown attributes or types
Date: Thu, 12 Oct 2023 16:04:38 +0200
Message-ID: <20231012140438.306857-1-jiri@resnulli.us>
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

Introduce a command line option "ignore-unknown" and pass it down to
YnlFamily class constructor to allow user to get at least the part
of the message containing known attributes.

$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do trap-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "trap-name": "source_mac_is_multicast"}' --ignore-unknown
{'bus-name': 'netdevsim',
 'dev-name': 'netdevsim1',
 'trap-action': 'drop',
 'trap-group-name': 'l2_drops',
 'trap-name': 'source_mac_is_multicast'}

Do the same for unknown attribute types.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/cli.py     | 3 ++-
 tools/net/ynl/lib/ynl.py | 7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index 564ecf07cd2c..36fa0b2a8944 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -27,6 +27,7 @@ def main():
                         const=Netlink.NLM_F_CREATE)
     parser.add_argument('--append', dest='flags', action='append_const',
                         const=Netlink.NLM_F_APPEND)
+    parser.add_argument('--ignore-unknown', action=argparse.BooleanOptionalAction)
     args = parser.parse_args()
 
     if args.no_schema:
@@ -36,7 +37,7 @@ def main():
     if args.json_text:
         attrs = json.loads(args.json_text)
 
-    ynl = YnlFamily(args.spec, args.schema)
+    ynl = YnlFamily(args.spec, args.schema, args.ignore_unknown)
 
     if args.ntf:
         ynl.ntf_subscribe(args.ntf)
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 13c4b019a881..fdec6e4f8061 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -404,10 +404,11 @@ class GenlProtocol(NetlinkProtocol):
 
 
 class YnlFamily(SpecFamily):
-    def __init__(self, def_path, schema=None):
+    def __init__(self, def_path, schema=None, ignore_unknown=False):
         super().__init__(def_path, schema)
 
         self.include_raw = False
+        self.ignore_unknown = ignore_unknown
 
         try:
             if self.proto == "netlink-raw":
@@ -519,6 +520,8 @@ class YnlFamily(SpecFamily):
             try:
                 attr_spec = attr_space.attrs_by_val[attr.type]
             except KeyError:
+                if self.ignore_unknown:
+                    continue
                 raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
             if attr_spec["type"] == 'nest':
                 subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'])
@@ -534,6 +537,8 @@ class YnlFamily(SpecFamily):
             elif attr_spec["type"] == 'array-nest':
                 decoded = self._decode_array_nest(attr, attr_spec)
             else:
+                if self.ignore_unknown:
+                    continue
                 raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
 
             if 'enum' in attr_spec:
-- 
2.41.0


