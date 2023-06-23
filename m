Return-Path: <netdev+bounces-13543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0859573BF65
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 22:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC9D1C2134E
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 20:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AD510965;
	Fri, 23 Jun 2023 20:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E59211C82
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 20:20:32 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC6E135
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:20:30 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4008dbf2ef4so4057931cf.1
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687551629; x=1690143629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glYCMtFlMW1OMcQ0oi9WvgXo6oKCKLuP/+3Vbg0ZNmg=;
        b=rR+dI3A3RojMOCPpW578d60JUmIZzFFmaZ83xqTAHiXvSiA6IkYswck5wBhSfV8KkS
         tmod4tlaLOjqW8beGKtEsv2c4YOLWESCbr2E1+bLvODhZTNYQ+3C9OTZjw7yLmze+AsW
         BoXcz7wqs046uSvhm9PDr8Mkyqr4jO6tvaqYHaVlxCl3WD6r440/X8ht4198AJfMl/mD
         gR5N+tXVgDKr0hBMd22Qch6vO7iqagTc9a9rWoz7wO8w40GM9ypvYuJNDed8t6a3EHuu
         ea1iVoIHJcNDg0pC/1jwI7JbSXGK1fuq70cHzOfi9bmNOe5lwzQMSssZWwOy5yTyZPTv
         MePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687551629; x=1690143629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glYCMtFlMW1OMcQ0oi9WvgXo6oKCKLuP/+3Vbg0ZNmg=;
        b=XEVmiQpUPs826BYWc3ukcOODsSfuEtiavrMDUDLQdMU2qcjIDlwsBqnyXejUEY0LjU
         lFyV6iM+OhsApl1kPCjovauXK+4Ls/Mp+59wu3ppW5Eosn1LVwEkeb89TUWAUxtGxufU
         PaaELEYhm6XG4jRlk3Ro7o27a4x2vf43UPFCAIfmRpUyUuGbNa+Gj51J+f6/6OGN98xE
         XNNDvQmr30yX2g04mUG/eje7PBnBXcd4T4jkxfrTqfyDEqZr8fxxyCMJBiTDmmzLxi4L
         YQLErJBw6lja28AC0fBcg95qQRjmFcGGTxUIdeMKNS+X8gUwIGpaEyHKmkyc8BmYttFc
         +k/Q==
X-Gm-Message-State: AC+VfDzJ2Kv4BiEO11ttMkeH/Oh3/SsiElN9FM8i4b3RhO/iTh2gaIvu
	K32xvOsnybRKyPp2MP6kNnMY/EBj7mOzww==
X-Google-Smtp-Source: ACHHUZ4OP1M2US5XwSadRP7ZtAm0ik4mt3ZHXML2Xc9FNd07/NQDNIKCe9obmK0pzjy84H0ZgF9Jkw==
X-Received: by 2002:ac8:5f46:0:b0:3f5:2177:eca0 with SMTP id y6-20020ac85f46000000b003f52177eca0mr23374619qta.5.1687551629348;
        Fri, 23 Jun 2023 13:20:29 -0700 (PDT)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id d24-20020ac84e38000000b003ff0d00a71esm2274152qtw.13.2023.06.23.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:20:28 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 2/3] tools: ynl: add display-hint support to ynl
Date: Fri, 23 Jun 2023 21:19:27 +0100
Message-Id: <20230623201928.14275-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230623201928.14275-1-donald.hunter@gmail.com>
References: <20230623201928.14275-1-donald.hunter@gmail.com>
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

Add support to the ynl tool for rendering output based on display-hint
properties.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/nlspec.py | 10 ++++++++++
 tools/net/ynl/lib/ynl.py    | 34 +++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 1ba572cae27b..0ff0d18666b2 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -154,6 +154,9 @@ class SpecAttr(SpecElement):
         is_multi      bool, attr may repeat multiple times
         struct_name   string, name of struct definition
         sub_type      string, name of sub type
+        len           integer, optional byte length of binary types
+        display_hint  string, hint to help choose format specifier
+                      when displaying the value
     """
     def __init__(self, family, attr_set, yaml, value):
         super().__init__(family, yaml)
@@ -164,6 +167,8 @@ class SpecAttr(SpecElement):
         self.struct_name = yaml.get('struct')
         self.sub_type = yaml.get('sub-type')
         self.byte_order = yaml.get('byte-order')
+        self.len = yaml.get('len')
+        self.display_hint = yaml.get('display-hint')
 
 
 class SpecAttrSet(SpecElement):
@@ -229,12 +234,17 @@ class SpecStructMember(SpecElement):
         type        string, type of the member attribute
         byte_order  string or None for native byte order
         enum        string, name of the enum definition
+        len         integer, optional byte length of binary types
+        display_hint  string, hint to help choose format specifier
+                      when displaying the value
     """
     def __init__(self, family, yaml):
         super().__init__(family, yaml)
         self.type = yaml['type']
         self.byte_order = yaml.get('byte-order')
         self.enum = yaml.get('enum')
+        self.len = yaml.get('len')
+        self.display_hint = yaml.get('display-hint')
 
 
 class SpecStruct(SpecElement):
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 3b343d6cbbc0..1b3a36fbb1c3 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -8,6 +8,8 @@ import socket
 import struct
 from struct import Struct
 import yaml
+import ipaddress
+import uuid
 
 from .nlspec import SpecFamily
 
@@ -105,6 +107,20 @@ class NlAttr:
                 else format.little
         return format.native
 
+    @classmethod
+    def formatted_string(cls, raw, display_hint):
+        if display_hint == 'mac':
+            formatted = ':'.join('%02x' % b for b in raw)
+        elif display_hint == 'hex':
+            formatted = bytes.hex(raw, ' ')
+        elif display_hint in [ 'ipv4', 'ipv6' ]:
+            formatted = format(ipaddress.ip_address(raw))
+        elif display_hint == 'uuid':
+            formatted = str(uuid.UUID(bytes=raw))
+        else:
+            formatted = raw
+        return formatted
+
     def as_scalar(self, attr_type, byte_order=None):
         format = self.get_format(attr_type, byte_order)
         return format.unpack(self.raw)[0]
@@ -124,10 +140,16 @@ class NlAttr:
         offset = 0
         for m in members:
             # TODO: handle non-scalar members
-            format = self.get_format(m.type, m.byte_order)
-            decoded = format.unpack_from(self.raw, offset)
-            offset += format.size
-            value[m.name] = decoded[0]
+            if m.type == 'binary':
+                decoded = self.raw[offset:offset+m['len']]
+                offset += m['len']
+            elif m.type in NlAttr.type_formats:
+                format = self.get_format(m.type, m.byte_order)
+                [ decoded ] = format.unpack_from(self.raw, offset)
+                offset += format.size
+            if m.display_hint:
+                decoded = self.formatted_string(decoded, m.display_hint)
+            value[m.name] = decoded
         return value
 
     def __repr__(self):
@@ -385,7 +407,7 @@ class YnlFamily(SpecFamily):
         elif attr["type"] == 'string':
             attr_payload = str(value).encode('ascii') + b'\x00'
         elif attr["type"] == 'binary':
-            attr_payload = value
+            attr_payload = bytes.fromhex(value)
         elif attr['type'] in NlAttr.type_formats:
             format = NlAttr.get_format(attr['type'], attr.byte_order)
             attr_payload = format.pack(int(value))
@@ -421,6 +443,8 @@ class YnlFamily(SpecFamily):
             decoded = attr.as_c_array(attr_spec.sub_type)
         else:
             decoded = attr.as_bin()
+            if attr_spec.display_hint:
+                decoded = NlAttr.formatted_string(decoded, attr_spec.display_hint)
         return decoded
 
     def _decode(self, attrs, space):
-- 
2.39.0


