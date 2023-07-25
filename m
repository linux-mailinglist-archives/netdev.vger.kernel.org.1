Return-Path: <netdev+bounces-20919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01A3761E5B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1141C20835
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4759A24194;
	Tue, 25 Jul 2023 16:22:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D01F173
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:22:27 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063DC11A
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:22:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso9031350e87.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690302144; x=1690906944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zyc3EzLwdqsgpDl0SBwuT9+P2kLO2TC+IUifZiduORo=;
        b=D3WjX9FrH4YhuwHOqUsWcAjdA/eJTGz7HCXrXMtc9YoZU5r8gDWf6+w7dzouv6v0JM
         oK0N4BtW0EZRd1cA1RTU9pyahAZG1x6Q9Y6NMhX7nwi7MsA2iS53D9jbtEPC7vw5jOoh
         92e3jJlxIjvvJ8YoDr5oqv/bIa69Vb3SrMmRuiBCbJlGikYH6AF9+hLj3M9rotMCojHD
         OK5Q6GfPPnfwUmXCUTZ3lu2f9AuMTvgcfNwDd7s1fYIn8X/IzH/prJTQu9D7neBNUmjl
         4daCXqaovQzz9GHAd0iKjJ2IdQ++xKJnX91zXrY45Sl4BNUQFu6OgDXhpk/y3ktIVt5E
         91IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690302144; x=1690906944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zyc3EzLwdqsgpDl0SBwuT9+P2kLO2TC+IUifZiduORo=;
        b=GBwn3e8OLNF7BkKmTwMWmb/Lk6IorC6PDx9KZJQPg/Fuejkbe3BWFOSgBY8diQVkM7
         iXGgU8o1yQgsBefetD70s4z8kvoqL9I+gvPDUk8gUW1G1BEn87UJPZoVuW9dr6MFWxpZ
         s4k7NrjpS99a4FMYIKT5RF0UbX42yCgCrtCKV60rbVEJrOKxk6FypcRlv7/CQ3LvDcEs
         d8czOFwBf5oXko6GrNfpdTTOXf7xHKy0lo5zrnRraCM2YeMgAqU1Dv/XA/4IV7DMkuIz
         7S90EkLE0WjY1dZGFK7P/2yzI+KwIAsgZUdnHIpk4CB4euArQ2uMtSuucsW1ggsXKaOd
         p5Eg==
X-Gm-Message-State: ABy/qLYUtbuWiIZaFYz+p4k4RA31tLizQVpDThzoyxqRhzQA201Wj38c
	qRzRdmkM0/QXXbkr4dMuisNm40AiWg5TfGEL
X-Google-Smtp-Source: APBJJlGJY3xYNwFXqqaRJSd36zr3iNFaWCo2DYiJFuglqReoJGELeeltzWu7fi+EkN+GhfZGPToSXg==
X-Received: by 2002:a05:6512:250a:b0:4f8:69f8:47a0 with SMTP id be10-20020a056512250a00b004f869f847a0mr9066974lfb.29.1690302143595;
        Tue, 25 Jul 2023 09:22:23 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:255e:7dc3:bcb1:e213])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c294300b003fc01f7a42dsm13661303wmd.8.2023.07.25.09.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:22:23 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 3/3] doc/netlink: Add specs for addr and route rtnetlink message types
Date: Tue, 25 Jul 2023 17:22:05 +0100
Message-ID: <20230725162205.27526-4-donald.hunter@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add netlink-raw specs for the following rtnetlink messages:
 - newaddr, deladdr, getaddr (dump)
 - getroute (dump)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_addr.yaml  | 179 ++++++++++++++++++++
 Documentation/netlink/specs/rt_route.yaml | 192 ++++++++++++++++++++++
 2 files changed, 371 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_addr.yaml
 create mode 100644 Documentation/netlink/specs/rt_route.yaml

diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
new file mode 100644
index 000000000000..f97ae7c35e44
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
+            - index
+        reply:
+          value: 20
+          attributes: *ifaddr-all
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-ipv4-ifaddr
+      id: 5
+    -
+      name: rtnlgrp-ipv6-ifaddr
+      id: 9
diff --git a/Documentation/netlink/specs/rt_route.yaml b/Documentation/netlink/specs/rt_route.yaml
new file mode 100644
index 000000000000..882af9b50bd4
--- /dev/null
+++ b/Documentation/netlink/specs/rt_route.yaml
@@ -0,0 +1,192 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: rt-route
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  Route configuration over rtnetlink.
+
+definitions:
+  -
+    name: rtm-type
+    name-prefix: rtn-
+    type: enum
+    entries:
+      - unspec
+      - unicast
+      - local
+      - broadcast
+      - anycast
+      - multicast
+      - blackhole
+      - unreachable
+      - prohibit
+      - throw
+      - nat
+      - xresolve
+  -
+    name: rtmsg
+    type: struct
+    members:
+      -
+        name: rtm-family
+        type: u8
+      -
+        name: rtm-dst-len
+        type: u8
+      -
+        name: rtm-src-len
+        type: u8
+      -
+        name: rtm-tos
+        type: u8
+      -
+        name: rtm-table
+        type: u8
+      -
+        name: rtm-protocol
+        type: u8
+      -
+        name: rtm-scope
+        type: u8
+      -
+        name: rtm-type
+        type: u8
+        enum: rtm-type
+      -
+        name: rtm-flags
+        type: u32
+  -
+    name: rta-cacheinfo
+    type: struct
+    members:
+      -
+        name: rta-clntref
+        type: u32
+      -
+        name: rta-lastuse
+        type: u32
+      -
+        name: rta-expires
+        type: u32
+      -
+        name: rta-error
+        type: u32
+      -
+        name: rta-used
+        type: u32
+
+attribute-sets:
+  -
+    name: route-attrs
+    attributes:
+      -
+        name: rta-dst
+        type: binary
+        display-hint: ipv4
+      -
+        name: rta-src
+        type: binary
+        display-hint: ipv4
+      -
+        name: rta-iif
+        type: u32
+      -
+        name: rta-oif
+        type: u32
+      -
+        name: rta-gateway
+        type: binary
+        display-hint: ipv4
+      -
+        name: rta-priority
+        type: binary
+      -
+        name: rta-prefsrc
+        type: binary
+        display-hint: ipv4
+      -
+        name: rta-metrics
+        type: binary
+      -
+        name: rta-multipath
+        type: binary
+      -
+        name: rta-protoinfo
+        type: binary
+      -
+        name: rta-flow
+        type: u32
+      -
+        name: rta-cacheinfo
+        type: binary
+        struct: rta-cacheinfo
+      -
+        name: rta-session
+        type: binary
+      -
+        name: rta-mp-algo
+        type: binary
+      -
+        name: rta-table
+        type: u32
+      -
+        name: rta-mark
+        type: binary
+      -
+        name: rta-mfc-stats
+        type: binary
+      -
+        name: rta-via
+        type: binary
+      -
+        name: rta-newdst
+        type: binary
+      -
+        name: rta-pref
+        type: binary
+      -
+        name: rta-encap-type
+        type: binary
+      -
+        name: rta-encap
+        type: binary
+      -
+        name: rta-expires
+        type: binary
+      -
+        name: rta-pad
+        type: binary
+      -
+        name: rta-uid
+        type: binary
+      -
+        name: rta-ttl-propagate
+        type: binary
+      -
+        name: rta-ip-proto
+        type: binary
+      -
+        name: rta-sport
+        type: binary
+      -
+        name: rta-dport
+        type: binary
+      -
+        name: rta-nh-id
+        type: binary
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: getroute
+      doc: Dump route information.
+      attribute-set: route-attrs
+      fixed-header: rtmsg
+      dump:
+        request:
+          value: 26
+        reply:
+          value: 24
-- 
2.41.0


