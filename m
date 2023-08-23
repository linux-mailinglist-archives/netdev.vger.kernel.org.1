Return-Path: <netdev+bounces-29992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7306D7856F1
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39881C20C90
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1BBC141;
	Wed, 23 Aug 2023 11:42:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA98C120
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:42:24 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC538E5D;
	Wed, 23 Aug 2023 04:42:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so51988705e9.2;
        Wed, 23 Aug 2023 04:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692790941; x=1693395741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMuGyBGwOFR2Dl4/VsqtMGb9yINdqL6Q/X3v/ZGykPE=;
        b=DMQA56NCAzomOOmFIoTtXnZRZ81b2Lf8N3Z+8cJ+0BxG+i7cKiv8e37uWkQD21Z2SS
         Yps9QTCtgFcnexagBRplhM6bVvqgmDEEc9o+vrMjN9ElAuGRLJEpTAMXt33ZcpxScwac
         6l/75UZ1w3K/XppJcFfwfX0kR306Y9/X5/JaZ/2wuX/D+Z/FGW13WGgy+R+EwmWPd73A
         Ev4Z2aCkETk7E/QT7SB8R2kqLvFW3iR8crjkx1mtr+2AImDAeoSvXiWD1jVwV4LZihsN
         HM6UPLN7LscxLEuuFZQOx+pxflbvCVNWX7TaKEZIcHhSWH13hIsdNbQRSw4oTSo68YxG
         c7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692790941; x=1693395741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMuGyBGwOFR2Dl4/VsqtMGb9yINdqL6Q/X3v/ZGykPE=;
        b=KdsxmY8+hkS0H9N3O+EjQwZ6eoM6Aat+O5yuJwpujG4+rcDVMqulromKGwCHPTVeC3
         Nrc66EWXv0VMJqQB4F4QHSPQtVI7l/EqaCugyvFTW/RYzgssM6SLhEnBb8o0GLGJFPZE
         KytTD6PyGpp8z6maesezjTWnAaOrS/LwV5OaHBU3K1auvveMUCiQ+50pa1EIeea2tTJP
         XxSivAFBHeeZlzUEdz5Dd3sned7Bxn27v9EGbRFrT/ZRaV+hEHLmfGB7zyfCujtXV3Uq
         0jCJ34vywKOHdWN3Wp+8sdz/bfWDuxYyNdxYNct57jEV8MKWmE+nXU1cyEXwl+UWkXl5
         yx8Q==
X-Gm-Message-State: AOJu0Yzfc/Wycj6kPZaAIV/lD3WK7N4z29jfBueFIrEy/r177pJeZQfe
	EQUp7TeSPq2YFXL035omNKNkwhhvRBHvsg==
X-Google-Smtp-Source: AGHT+IGJrD0XXF9AjUW0qK+opk0Hp4bo3j/crRYDjsqGAuemkM1YcRXYal5jaUg9Y9YoR5HDKwpoUw==
X-Received: by 2002:a05:600c:2307:b0:3fd:2996:9d88 with SMTP id 7-20020a05600c230700b003fd29969d88mr9731523wmo.25.1692790940973;
        Wed, 23 Aug 2023 04:42:20 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:e4cf:1132:7b40:4262])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003fed9b1a1f4sm559508wms.1.2023.08.23.04.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:42:20 -0700 (PDT)
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
Subject: [PATCH net-next v4 06/12] tools/net/ynl: Fix extack parsing with fixed header genlmsg
Date: Wed, 23 Aug 2023 12:41:55 +0100
Message-ID: <20230823114202.5862-7-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823114202.5862-1-donald.hunter@gmail.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
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

Move decode_fixed_header into YnlFamily and add a _fixed_header_size
method to allow extack decoding to skip the fixed header.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 65 ++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 6951bcc7efdc..1d1bc712456e 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -293,7 +293,7 @@ def _genl_load_families():
 
                 gm = GenlMsg(nl_msg)
                 fam = dict()
-                for attr in gm.raw_attrs:
+                for attr in NlAttrs(gm.raw):
                     if attr.type == Netlink.CTRL_ATTR_FAMILY_ID:
                         fam['id'] = attr.as_scalar('u16')
                     elif attr.type == Netlink.CTRL_ATTR_FAMILY_NAME:
@@ -317,23 +317,10 @@ def _genl_load_families():
 
 
 class GenlMsg:
-    def __init__(self, nl_msg, fixed_header_members=[]):
+    def __init__(self, nl_msg):
         self.nl = nl_msg
-
-        self.hdr = nl_msg.raw[0:4]
-        offset = 4
-
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
-        self.raw_attrs = NlAttrs(self.raw)
+        self.genl_cmd, self.genl_version, _ = struct.unpack_from("BBH", nl_msg.raw, 0)
+        self.raw = nl_msg.raw[4:]
 
     def __repr__(self):
         msg = repr(self.nl)
@@ -509,17 +496,44 @@ class YnlFamily(SpecFamily):
 
         return None
 
-    def _decode_extack(self, request, attr_space, extack):
+    def _decode_extack(self, request, op, extack):
         if 'bad-attr-offs' not in extack:
             return
 
-        genl_req = GenlMsg(NlMsg(request, 0, attr_space=attr_space))
-        path = self._decode_extack_path(genl_req.raw_attrs, attr_space,
-                                        20, extack['bad-attr-offs'])
+        genl_req = GenlMsg(NlMsg(request, 0, op.attr_set))
+        fixed_header_size = self._fixed_header_size(op)
+        offset = 20 + fixed_header_size
+        path = self._decode_extack_path(NlAttrs(genl_req.raw[fixed_header_size:]),
+                                        op.attr_set, offset,
+                                        extack['bad-attr-offs'])
         if path:
             del extack['bad-attr-offs']
             extack['bad-attr'] = path
 
+    def _fixed_header_size(self, op):
+        if op.fixed_header:
+            fixed_header_members = self.consts[op.fixed_header].members
+            size = 0
+            for m in fixed_header_members:
+                format = NlAttr.get_format(m.type, m.byte_order)
+                size += format.size
+            return size
+        else:
+            return 0
+
+    def _decode_fixed_header(self, msg, name):
+        fixed_header_members = self.consts[name].members
+        fixed_header_attrs = dict()
+        offset = 0
+        for m in fixed_header_members:
+            format = NlAttr.get_format(m.type, m.byte_order)
+            [ value ] = format.unpack_from(msg.raw, offset)
+            offset += format.size
+            if m.enum:
+                value = self._decode_enum(value, m)
+            fixed_header_attrs[m.name] = value
+        return fixed_header_attrs
+
     def handle_ntf(self, nl_msg, genl_msg):
         msg = dict()
         if self.include_raw:
@@ -594,7 +608,7 @@ class YnlFamily(SpecFamily):
             nms = NlMsgs(reply, attr_space=op.attr_set)
             for nl_msg in nms:
                 if nl_msg.extack:
-                    self._decode_extack(msg, op.attr_set, nl_msg.extack)
+                    self._decode_extack(msg, op, nl_msg.extack)
 
                 if nl_msg.error:
                     raise NlError(nl_msg)
@@ -605,7 +619,7 @@ class YnlFamily(SpecFamily):
                     done = True
                     break
 
-                gm = GenlMsg(nl_msg, fixed_header_members)
+                gm = GenlMsg(nl_msg)
                 # Check if this is a reply to our request
                 if nl_msg.nl_seq != req_seq or gm.genl_cmd != op.rsp_value:
                     if gm.genl_cmd in self.async_msg_ids:
@@ -615,8 +629,9 @@ class YnlFamily(SpecFamily):
                         print('Unexpected message: ' + repr(gm))
                         continue
 
-                rsp_msg = self._decode(gm.raw_attrs, op.attr_set.name)
-                rsp_msg.update(gm.fixed_header_attrs)
+                rsp_msg = self._decode(NlAttrs(gm.raw), op.attr_set.name)
+                if op.fixed_header:
+                    rsp_msg.update(self._decode_fixed_header(gm, op.fixed_header))
                 rsp.append(rsp_msg)
 
         if not rsp:
-- 
2.41.0


