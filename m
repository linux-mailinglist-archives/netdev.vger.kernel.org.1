Return-Path: <netdev+bounces-57830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7358144A9
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08871F23597
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CC919454;
	Fri, 15 Dec 2023 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISevEh6a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA06C199C5;
	Fri, 15 Dec 2023 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso4459875e9.1;
        Fri, 15 Dec 2023 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633059; x=1703237859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBJWPLgDnYXFvz9MbO1O2sFqnvPghUqYEUSL1A5OaXs=;
        b=ISevEh6amgEVfZGSgB2HcmRO/96qDPO08YfzP1dim2NUruY1czNCxtYTkzuonbP4Mf
         vt13LogI5lO7bX6L+QmfRr0HlORwG4lKw82dcrPT0z9FuM64H03UDc07b4e5C1U3HqWT
         3BRmiLPR6Vq2yGUUeWM+FtRGDWOQdFr6w7vhn1XLEaqFskecKgrXK95JhNk5fycVja01
         s4MGtgtzbfSkUfZmVKYSt8Ru0E9xiq4oz3+hYUqdPip2wGm9ofhW6ee1dlN5k6qbuUTD
         I0cezGP7lvvTwJbQfktptort4uJabI0CoS9Cd23gZTK2cI3fWOu+u5PA0FoPA9bQVEZc
         hYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633059; x=1703237859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBJWPLgDnYXFvz9MbO1O2sFqnvPghUqYEUSL1A5OaXs=;
        b=hyuW13fr3pPOl04H9gSH8gGvUt95nigXP2Vsrvi1Pn7zSIDnJODf34oE8XdUMpN19h
         TLN5u+pLCtac6ieJEemye0qw/lTEHb8hGj53ixRBDxpbN8YWJY8OpkBSXcDEfGBve3G2
         guTXtbA/fZGuAK0B7PWUXW/xKzXUwxkv19q1YKQLZ/780yo2pIn+5RIfRJpt536ap5mu
         2lirv0KxL86bIZk2KzMNcoGjAKLk+Drq+nPRfW3WxQrH5/hB3gA+057kyDzIUEeqRwpQ
         C8R/7XmPgtfUTQ/1bIeWIC1anV4rXmS2mejDH5ySKBj4x2qfMjCTrFt+uEzZSzHQT+BE
         kRrA==
X-Gm-Message-State: AOJu0YzndDPB61erqWtlMiTK1uAFzSXpMj1R2hLcbivZ+GsgG/yZWJw4
	F2NW2V34vlAeMdHwdIe/oElBAtSaM969iA==
X-Google-Smtp-Source: AGHT+IFF9uBENTdy24/hbaNaX6lhKuv0dmYRBkw4QA8+vV4Mtzpemwa277Uvc+a6i3xJ9bxKs3vE4A==
X-Received: by 2002:a05:600c:6020:b0:40c:1e00:cfcc with SMTP id az32-20020a05600c602000b0040c1e00cfccmr6306832wmb.97.1702633059204;
        Fri, 15 Dec 2023 01:37:39 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:38 -0800 (PST)
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
Subject: [PATCH net-next v5 05/13] tools/net/ynl: Add binary and pad support to structs for tc
Date: Fri, 15 Dec 2023 09:37:12 +0000
Message-ID: <20231215093720.18774-6-donald.hunter@gmail.com>
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

The tc netlink-raw family needs binary and pad types for several
qopt C structs. Add support for them to ynl.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index a69fb0c9f728..61d672c57fb0 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -670,8 +670,11 @@ class YnlFamily(SpecFamily):
             fixed_header_members = self.consts[name].members
             size = 0
             for m in fixed_header_members:
-                format = NlAttr.get_format(m.type, m.byte_order)
-                size += format.size
+                if m.type in ['pad', 'binary']:
+                    size += m.len
+                else:
+                    format = NlAttr.get_format(m.type, m.byte_order)
+                    size += format.size
             return size
         else:
             return 0
@@ -681,12 +684,20 @@ class YnlFamily(SpecFamily):
         fixed_header_attrs = dict()
         offset = 0
         for m in fixed_header_members:
-            format = NlAttr.get_format(m.type, m.byte_order)
-            [ value ] = format.unpack_from(msg.raw, offset)
-            offset += format.size
-            if m.enum:
-                value = self._decode_enum(value, m)
-            fixed_header_attrs[m.name] = value
+            value = None
+            if m.type == 'pad':
+                offset += m.len
+            elif m.type == 'binary':
+                value = msg.raw[offset : offset + m.len]
+                offset += m.len
+            else:
+                format = NlAttr.get_format(m.type, m.byte_order)
+                [ value ] = format.unpack_from(msg.raw, offset)
+                offset += format.size
+            if value is not None:
+                if m.enum:
+                    value = self._decode_enum(value, m)
+                fixed_header_attrs[m.name] = value
         return fixed_header_attrs
 
     def handle_ntf(self, decoded):
@@ -753,8 +764,13 @@ class YnlFamily(SpecFamily):
             fixed_header_members = self.consts[op.fixed_header].members
             for m in fixed_header_members:
                 value = vals.pop(m.name) if m.name in vals else 0
-                format = NlAttr.get_format(m.type, m.byte_order)
-                msg += format.pack(value)
+                if m.type == 'pad':
+                    msg += bytearray(m.len)
+                elif m.type == 'binary':
+                    msg += bytes.fromhex(value)
+                else:
+                    format = NlAttr.get_format(m.type, m.byte_order)
+                    msg += format.pack(value)
         for name, value in vals.items():
             msg += self._add_attr(op.attr_set.name, name, value)
         msg = _genl_msg_finalize(msg)
-- 
2.42.0


