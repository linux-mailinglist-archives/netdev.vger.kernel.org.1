Return-Path: <netdev+bounces-27805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B5277D389
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1DA281566
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEFB198AD;
	Tue, 15 Aug 2023 19:43:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B41AA70
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 19:43:44 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D7D10C1;
	Tue, 15 Aug 2023 12:43:43 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff882397ecso1356417e87.3;
        Tue, 15 Aug 2023 12:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692128620; x=1692733420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLnNqJMl/isE73N1mbjQXGEF/pmHif2ExuIghaJq2uU=;
        b=E4+EyGTgk55Ar+/aND32Egi/A6TLfOSqpz+0MIVtzXHpSm5PzXmP9l3Si6nqdyOsKK
         KiZNxtoeVQzdrwpSa9H+2cafKa1nTuRdGVCsJlw/WoRK8+Wq8DO6PI8vswJpDfXAfUij
         J/h9rS/E12dc61HzBgdVSjjUKfsUeC5fmgeQEktIQzedYV2Zk+Yg4VD2t6sJYfSv5+D2
         xHSUe5ET3DfAZd6PmmFsFqimM6mvkxFmVhzKc+eIFsfV4nHsHWgVFB/IcLsVaknoOT89
         P0KfGY08qVJBTmfce37f9QdFhl0OC6r7p3nIrTkNDrTtQI/7SNIIGJvSxvzb6qZfREU5
         ucBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128620; x=1692733420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLnNqJMl/isE73N1mbjQXGEF/pmHif2ExuIghaJq2uU=;
        b=SQukz78zEcIYK4FzVFZ1f4u44vpy3NvUsb1K07SQtNMAylfeBFhnfjg9NcyMWJc8pZ
         1wsMWpw+O/e7mM5OZDit1v1RBQ3nyeiuj5SyxqWsEeGI/zmkekpbn0p2JXrQqIodP5to
         2ZBY2E9STF0oXswIzBi/cHbQvkk0fn7FBd/ECPOZAfVWAZS9ls/VjZ4BnRCqs+zmm4HG
         1b/j1B3azD3s5wOx6wU9ewYzWJX45IF+YvQ1OwMAcLfKjkywKLimJR5VRqbHIaiEibpX
         ate5LvPQaq5MoCqOi7zIOgqvbxW+ZCCHjXj3qpNOoiUJuiLN18IWcuZSu7vTZRSaBtlC
         rpQQ==
X-Gm-Message-State: AOJu0YxkhrNFsV6EYQkDVJC/6QWOdgoQzPrujhLluEEG5ZMVr9g/vbHb
	OH5SwHZcV6AoSLp/Ibgg91xb0CBUmtEkxjNb
X-Google-Smtp-Source: AGHT+IE/RtXNaazgveIWWB1QqfU3PBMO+3SgcBve1Hu2CgMQ8U7BQMDMUCdmYTJ1YwXRprZ+3EfK2w==
X-Received: by 2002:ac2:5fd1:0:b0:4f7:6775:2a66 with SMTP id q17-20020ac25fd1000000b004f767752a66mr7256085lfg.53.1692128620327;
        Tue, 15 Aug 2023 12:43:40 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9934:e2f7:cd0e:75a6])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d6610000000b003179d5aee67sm18814892wru.94.2023.08.15.12.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 12:43:39 -0700 (PDT)
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
Subject: [PATCH net-next v2 08/10] doc/netlink: Add spec for rt addr messages
Date: Tue, 15 Aug 2023 20:42:52 +0100
Message-ID: <20230815194254.89570-9-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815194254.89570-1-donald.hunter@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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


