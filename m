Return-Path: <netdev+bounces-29788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C19784AC5
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 21:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBCE1C20B8A
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8E93D38D;
	Tue, 22 Aug 2023 19:43:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5B34CCB
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 19:43:38 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84047E4E;
	Tue, 22 Aug 2023 12:43:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31ad9155414so4269070f8f.3;
        Tue, 22 Aug 2023 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733409; x=1693338209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLnNqJMl/isE73N1mbjQXGEF/pmHif2ExuIghaJq2uU=;
        b=b2I2t38u38UuiatS4oQvqwT/BnU/YLZSOzMcFv1G5JY9JTURkb5V+7om6QgXiJtf1x
         ZsStJIGXOXiSpwdj4M8BQ7yFxYbpFZa1e/wkFl6LPyblJtzn3dsjQRpgsde+g31YtLhm
         Vv0kZtv4lI+ZStMdbFRkmd/6E79as+FpK0UMFBKMkb6v04lGrNG56PAyMYJJTN4Ls8wm
         8TAhljxEy70IIHKHsdksDRDi1bRKVBmTPFPK2TOrup1W1E1B4TsR5uDt4yx3dJDxhcEz
         CW8u2JYB0hdZyvfsY5wK9qyoyD5D4hElXjVjwZZ/Zo+fzX+aQw1AluEtqhj6SZnAr17Y
         Uthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733409; x=1693338209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLnNqJMl/isE73N1mbjQXGEF/pmHif2ExuIghaJq2uU=;
        b=CVNVKO4Ed+J9JTYAhGkuwxq2AazaGEPgFcS/h82n7h6K+6fFoksaXVAlBtGDVeQE07
         6vphOPg/5sXXjWwUJInJCC2fkOA6CCWka436ApD8ibB9RY2pZzz33/HNPOfzQE+etrA7
         WW0kLz/9ZNctU4uiKVhcBJ8xLnA1Wc/E8Ew4ln60qrXUipIAJeJuqO8nw8RlyMwDaVPF
         L+wOABgTW/irTq5lc3gWpwGLJW21bxBP7Cm4tcjG55psCfVTwZRjo321WonIH4LywWfe
         mKpm/DQlYP24eHNBMBsnFJQGijkZbNitFl6oYVgRkJuz+apWeQTXqmcjJAJZLEsG387b
         zJTA==
X-Gm-Message-State: AOJu0YyXxHZNtSwf8hpGd/lLXAMVXKGkGTVpdd1gz5SKueYt7FWe5vEL
	+cs3B9xPcACbCRQVpdaVGFknqzLZ3K/Y7w==
X-Google-Smtp-Source: AGHT+IEIJ9M3OFqaGnYgcndEF2niSEuLfuh1cWevGDH5pmZarZR31ICBPpgaKKDWoASMOyLuuA3bbw==
X-Received: by 2002:adf:ea81:0:b0:319:67da:ed68 with SMTP id s1-20020adfea81000000b0031967daed68mr8346380wrm.7.1692733409537;
        Tue, 22 Aug 2023 12:43:29 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:3060:22e2:2970:3dc3])
        by smtp.gmail.com with ESMTPSA id f8-20020adfdb48000000b0031934b035d2sm16846067wrj.52.2023.08.22.12.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:43:29 -0700 (PDT)
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
Subject: [PATCH net-next v3 10/12] doc/netlink: Add spec for rt addr messages
Date: Tue, 22 Aug 2023 20:43:02 +0100
Message-ID: <20230822194304.87488-11-donald.hunter@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add schema for rt addr with support for:
     - newaddr, deladdr, getaddr (dump)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_addr.yaml | 179 +++++++++++++++++++++++
 1 file changed, 179 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_addr.yaml

diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
new file mode 100644
index 000000000000..cbee1cedb177
--- /dev/null
+++ b/Documentation/netlink/specs/rt_addr.yaml
@@ -0,0 +1,179 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: rt-addr
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  Address configuration over rtnetlink.
+
+definitions:
+  -
+    name: ifaddrmsg
+    type: struct
+    members:
+      -
+        name: ifa-family
+        type: u8
+      -
+        name: ifa-prefixlen
+        type: u8
+      -
+        name: ifa-flags
+        type: u8
+        enum: ifa-flags
+        enum-as-flags: true
+      -
+        name: ifa-scope
+        type: u8
+      -
+        name: ifa-index
+        type: u32
+  -
+    name: ifa-cacheinfo
+    type: struct
+    members:
+      -
+        name: ifa-prefered
+        type: u32
+      -
+        name: ifa-valid
+        type: u32
+      -
+        name: cstamp
+        type: u32
+      -
+        name: tstamp
+        type: u32
+
+  -
+    name: ifa-flags
+    type: flags
+    entries:
+      -
+        name: secondary
+      -
+        name: nodad
+      -
+        name: optimistic
+      -
+        name: dadfailed
+      -
+        name: homeaddress
+      -
+        name: deprecated
+      -
+        name: tentative
+      -
+        name: permanent
+      -
+        name: managetempaddr
+      -
+        name: noprefixroute
+      -
+        name: mcautojoin
+      -
+        name: stable-privacy
+
+attribute-sets:
+  -
+    name: addr-attrs
+    attributes:
+      -
+        name: ifa-address
+        type: binary
+        display-hint: ipv4
+      -
+        name: ifa-local
+        type: binary
+        display-hint: ipv4
+      -
+        name: ifa-label
+        type: string
+      -
+        name: ifa-broadcast
+        type: binary
+        display-hint: ipv4
+      -
+        name: ifa-anycast
+        type: binary
+      -
+        name: ifa-cacheinfo
+        type: binary
+        struct: ifa-cacheinfo
+      -
+        name: ifa-multicast
+        type: binary
+      -
+        name: ifa-flags
+        type: u32
+        enum: ifa-flags
+        enum-as-flags: true
+      -
+        name: ifa-rt-priority
+        type: u32
+      -
+        name: ifa-target-netnsid
+        type: binary
+      -
+        name: ifa-proto
+        type: u8
+
+
+operations:
+  fixed-header: ifaddrmsg
+  enum-model: directional
+  list:
+    -
+      name: newaddr
+      doc: Add new address
+      attribute-set: addr-attrs
+      do:
+        request:
+          value: 20
+          attributes: &ifaddr-all
+            - ifa-family
+            - ifa-flags
+            - ifa-prefixlen
+            - ifa-scope
+            - ifa-index
+            - ifa-address
+            - ifa-label
+            - ifa-local
+            - ifa-cacheinfo
+    -
+      name: deladdr
+      doc: Remove address
+      attribute-set: addr-attrs
+      do:
+        request:
+          value: 21
+          attributes:
+            - ifa-family
+            - ifa-flags
+            - ifa-prefixlen
+            - ifa-scope
+            - ifa-index
+            - ifa-address
+            - ifa-local
+    -
+      name: getaddr
+      doc: Dump address information.
+      attribute-set: addr-attrs
+      dump:
+        request:
+          value: 22
+          attributes:
+            - ifa-index
+        reply:
+          value: 20
+          attributes: *ifaddr-all
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-ipv4-ifaddr
+      value: 5
+    -
+      name: rtnlgrp-ipv6-ifaddr
+      value: 9
-- 
2.41.0


