Return-Path: <netdev+bounces-29790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BF9784AC8
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 21:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80932810DB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A971D20189;
	Tue, 22 Aug 2023 19:43:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664520187
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 19:43:43 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C6ECED;
	Tue, 22 Aug 2023 12:43:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fee17aebc8so34443545e9.0;
        Tue, 22 Aug 2023 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733411; x=1693338211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9giu89+wgHbHNVQm+RKegumN6DWtd1x2b537mYhQcs=;
        b=mKWZhvz1wMld5I9InIT24wCS4iKgE6rq2uMZxEl9PIXpYdwdLFYvCtGeVNAEnFi9lE
         2vAMtPouZRfcZiMZz3vofxyA6g5cccd5DE4fre7lzVu7we3orNy+6JRx8tkR13s8hdtw
         ZZU5klTj1T/9Pj26K6FKkxczPP4epbb+kGwYmr1qm1bSh6A7QA6lINkY4sHzGrGGGRSy
         HMNADhQZrGopxNtXnoQWrxfthIP3nZ65PIbfK5ctLMQYcXUuJsBntxRLHi4szxEO8V+U
         Yyp8KXIJ+c2nPqY+6hQL5NQKm6FK/XS5eFfV0eXYwKzDP37vN+F1X2QA9hmGWS7jSYvL
         XVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733411; x=1693338211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9giu89+wgHbHNVQm+RKegumN6DWtd1x2b537mYhQcs=;
        b=WmtfRe6Vu118+d9H2cpXkxcWbJTlgjRoIzPPUt+pKPyO5H6JXcMBbos4CYNEQWgC7d
         JLsGXAeSr8N60WVIKq5I/JyovdPwWGBcwkxntL2/4M+ezboCgfRI1gupUMDydF7EB8nv
         B4s10tJ52uN+XbQmrFm32XfSdYG6WSDVxzb27loIF/5H9SRAfwrcJUujbhF9tO0GFi9+
         MLBXaNqSOQJf61pASf8zAMqXZyl/7cAJeK/ywPDzGZxRC8UQU2a398lE3iMIhO3zqj8w
         Txa/hm2CCDxm5c4ZYtZUzJCpWTrVhEiYq2sbTLUwSTs60dlLtrVfK4qUp1hslvET78B3
         rxJg==
X-Gm-Message-State: AOJu0Yz308gEhkqzb6rjEgAXt7KD7LK5YjLRLQ6AYeqUlT73BCtuXiF4
	K2wu6eLTjq7YfSMW4NiRg4hvLDvNrCvOHg==
X-Google-Smtp-Source: AGHT+IFPdvFC9og1ZMS9hYzylXWThsh2RuOAKq+r3EyWEBcTVhDanMeYyuve7ffKjuW8CeJRMwR/Lg==
X-Received: by 2002:a5d:6a8b:0:b0:319:7c7d:8d9 with SMTP id s11-20020a5d6a8b000000b003197c7d08d9mr7944705wru.42.1692733410774;
        Tue, 22 Aug 2023 12:43:30 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:3060:22e2:2970:3dc3])
        by smtp.gmail.com with ESMTPSA id f8-20020adfdb48000000b0031934b035d2sm16846067wrj.52.2023.08.22.12.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:43:30 -0700 (PDT)
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
Subject: [PATCH net-next v3 11/12] doc/netlink: Add spec for rt link messages
Date: Tue, 22 Aug 2023 20:43:03 +0100
Message-ID: <20230822194304.87488-12-donald.hunter@gmail.com>
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

Add schema for rt link with support for newlink, dellink, getlink,
setlink and getstats.

For example, offload stats can be fetched like this:

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/rt_link.yaml \
    --dump getstats --json '{ "filter-mask": 8 }'

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_link.yaml | 1376 ++++++++++++++++++++++
 1 file changed, 1376 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_link.yaml

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
new file mode 100644
index 000000000000..a823f45fcfc8
--- /dev/null
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -0,0 +1,1376 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: rt-link
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  Link configuration over rtnetlink.
+
+definitions:
+  -
+    name: ifinfo-flags
+    type: flags
+    entries:
+      -
+        name: up
+      -
+        name: broadcast
+      -
+        name: debug
+      -
+        name: loopback
+      -
+        name: point-to-point
+      -
+        name: no-trailers
+      -
+        name: running
+      -
+        name: no-arp
+      -
+        name: promisc
+      -
+        name: all-multi
+      -
+        name: master
+      -
+        name: slave
+      -
+        name: multicast
+      -
+        name: portsel
+      -
+        name: auto-media
+      -
+        name: dynamic
+      -
+        name: lower-up
+      -
+        name: dormant
+      -
+        name: echo
+
+  -
+    name: rtgenmsg
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+  -
+    name: ifinfomsg
+    type: struct
+    members:
+      -
+        name: ifi-family
+        type: u8
+      -
+        name: padding
+        type: u8
+      -
+        name: ifi-type
+        type: u16
+      -
+        name: ifi-index
+        type: s32
+      -
+        name: ifi-flags
+        type: u32
+        enum: ifinfo-flags
+        enum-as-flags: true
+      -
+        name: ifi-change
+        type: u32
+  -
+    name: ifla-cacheinfo
+    type: struct
+    members:
+      -
+        name: max-reasm-len
+        type: u32
+      -
+        name: tstamp
+        type: u32
+      -
+        name: reachable-time
+        type: s32
+      -
+        name: retrans-time
+        type: u32
+  -
+    name: rtnl-link-stats
+    type: struct
+    members:
+      -
+        name: rx-packets
+        type: u32
+      -
+        name: tx-packets
+        type: u32
+      -
+        name: rx-bytes
+        type: u32
+      -
+        name: tx-bytes
+        type: u32
+      -
+        name: rx-errors
+        type: u32
+      -
+        name: tx-errors
+        type: u32
+      -
+        name: rx-dropped
+        type: u32
+      -
+        name: tx-dropped
+        type: u32
+      -
+        name: multicast
+        type: u32
+      -
+        name: collisions
+        type: u32
+      -
+        name: rx-length-errors
+        type: u32
+      -
+        name: rx-over-errors
+        type: u32
+      -
+        name: rx-crc-errors
+        type: u32
+      -
+        name: rx-frame-errors
+        type: u32
+      -
+        name: rx-fifo-errors
+        type: u32
+      -
+        name: rx-missed-errors
+        type: u32
+      -
+        name: tx-aborted-errors
+        type: u32
+      -
+        name: tx-carrier-errors
+        type: u32
+      -
+        name: tx-fifo-errors
+        type: u32
+      -
+        name: tx-heartbeat-errors
+        type: u32
+      -
+        name: tx-window-errors
+        type: u32
+      -
+        name: rx-compressed
+        type: u32
+      -
+        name: tx-compressed
+        type: u32
+      -
+        name: rx-nohandler
+        type: u32
+  -
+    name: rtnl-link-stats64
+    type: struct
+    members:
+      -
+        name: rx-packets
+        type: u64
+      -
+        name: tx-packets
+        type: u64
+      -
+        name: rx-bytes
+        type: u64
+      -
+        name: tx-bytes
+        type: u64
+      -
+        name: rx-errors
+        type: u64
+      -
+        name: tx-errors
+        type: u64
+      -
+        name: rx-dropped
+        type: u64
+      -
+        name: tx-dropped
+        type: u64
+      -
+        name: multicast
+        type: u64
+      -
+        name: collisions
+        type: u64
+      -
+        name: rx-length-errors
+        type: u64
+      -
+        name: rx-over-errors
+        type: u64
+      -
+        name: rx-crc-errors
+        type: u64
+      -
+        name: rx-frame-errors
+        type: u64
+      -
+        name: rx-fifo-errors
+        type: u64
+      -
+        name: rx-missed-errors
+        type: u64
+      -
+        name: tx-aborted-errors
+        type: u64
+      -
+        name: tx-carrier-errors
+        type: u64
+      -
+        name: tx-fifo-errors
+        type: u64
+      -
+        name: tx-heartbeat-errors
+        type: u64
+      -
+        name: tx-window-errors
+        type: u64
+      -
+        name: rx-compressed
+        type: u64
+      -
+        name: tx-compressed
+        type: u64
+      -
+        name: rx-nohandler
+        type: u64
+      -
+        name: rx-otherhost-dropped
+        type: u64
+  -
+    name: rtnl-link-ifmap
+    type: struct
+    members:
+      -
+        name: mem-start
+        type: u64
+      -
+        name: mem-end
+        type: u64
+      -
+        name: base-addr
+        type: u64
+      -
+        name: irq
+        type: u16
+      -
+        name: dma
+        type: u8
+      -
+        name: port
+        type: u8
+  -
+    name: ipv4-devconf
+    type: struct
+    members:
+      -
+        name: forwarding
+        type: u32
+      -
+        name: mc-forwarding
+        type: u32
+      -
+        name: proxy-arp
+        type: u32
+      -
+        name: accept-redirects
+        type: u32
+      -
+        name: secure-redirects
+        type: u32
+      -
+        name: send-redirects
+        type: u32
+      -
+        name: shared-media
+        type: u32
+      -
+        name: rp-filter
+        type: u32
+      -
+        name: accept-source-route
+        type: u32
+      -
+        name: bootp-relay
+        type: u32
+      -
+        name: log-martians
+        type: u32
+      -
+        name: tag
+        type: u32
+      -
+        name: arpfilter
+        type: u32
+      -
+        name: medium-id
+        type: u32
+      -
+        name: noxfrm
+        type: u32
+      -
+        name: nopolicy
+        type: u32
+      -
+        name: force-igmp-version
+        type: u32
+      -
+        name: arp-announce
+        type: u32
+      -
+        name: arp-ignore
+        type: u32
+      -
+        name: promote-secondaries
+        type: u32
+      -
+        name: arp-accept
+        type: u32
+      -
+        name: arp-notify
+        type: u32
+      -
+        name: accept-local
+        type: u32
+      -
+        name: src-vmark
+        type: u32
+      -
+        name: proxy-arp-pvlan
+        type: u32
+      -
+        name: route-localnet
+        type: u32
+      -
+        name: igmpv2-unsolicited-report-interval
+        type: u32
+      -
+        name: igmpv3-unsolicited-report-interval
+        type: u32
+      -
+        name: ignore-routes-with-linkdown
+        type: u32
+      -
+        name: drop-unicast-in-l2-multicast
+        type: u32
+      -
+        name: drop-gratuitous-arp
+        type: u32
+      -
+        name: bc-forwarding
+        type: u32
+      -
+        name: arp-evict-nocarrier
+        type: u32
+  -
+    name: ipv6-devconf
+    type: struct
+    members:
+      -
+        name: forwarding
+        type: u32
+      -
+        name: hoplimit
+        type: u32
+      -
+        name: mtu6
+        type: u32
+      -
+        name: accept-ra
+        type: u32
+      -
+        name: accept-redirects
+        type: u32
+      -
+        name: autoconf
+        type: u32
+      -
+        name: dad-transmits
+        type: u32
+      -
+        name: rtr-solicits
+        type: u32
+      -
+        name: rtr-solicit-interval
+        type: u32
+      -
+        name: rtr-solicit-delay
+        type: u32
+      -
+        name: use-tempaddr
+        type: u32
+      -
+        name: temp-valid-lft
+        type: u32
+      -
+        name: temp-prefered-lft
+        type: u32
+      -
+        name: regen-max-retry
+        type: u32
+      -
+        name: max-desync-factor
+        type: u32
+      -
+        name: max-addresses
+        type: u32
+      -
+        name: force-mld-version
+        type: u32
+      -
+        name: accept-ra-defrtr
+        type: u32
+      -
+        name: accept-ra-pinfo
+        type: u32
+      -
+        name: accept-ra-rtr-pref
+        type: u32
+      -
+        name: rtr-probe-interval
+        type: u32
+      -
+        name: accept-ra-rt-info-max-plen
+        type: u32
+      -
+        name: proxy-ndp
+        type: u32
+      -
+        name: optimistic-dad
+        type: u32
+      -
+        name: accept-source-route
+        type: u32
+      -
+        name: mc-forwarding
+        type: u32
+      -
+        name: disable-ipv6
+        type: u32
+      -
+        name: accept-dad
+        type: u32
+      -
+        name: force-tllao
+        type: u32
+      -
+        name: ndisc-notify
+        type: u32
+      -
+        name: mldv1-unsolicited-report-interval
+        type: u32
+      -
+        name: mldv2-unsolicited-report-interval
+        type: u32
+      -
+        name: suppress-frag-ndisc
+        type: u32
+      -
+        name: accept-ra-from-local
+        type: u32
+      -
+        name: use-optimistic
+        type: u32
+      -
+        name: accept-ra-mtu
+        type: u32
+      -
+        name: stable-secret
+        type: u32
+      -
+        name: use-oif-addrs-only
+        type: u32
+      -
+        name: accept-ra-min-hop-limit
+        type: u32
+      -
+        name: ignore-routes-with-linkdown
+        type: u32
+      -
+        name: drop-unicast-in-l2-multicast
+        type: u32
+      -
+        name: drop-unsolicited-na
+        type: u32
+      -
+        name: keep-addr-on-down
+        type: u32
+      -
+        name: rtr-solicit-max-interval
+        type: u32
+      -
+        name: seg6-enabled
+        type: u32
+      -
+        name: seg6-require-hmac
+        type: u32
+      -
+        name: enhanced-dad
+        type: u32
+      -
+        name: addr-gen-mode
+        type: u32
+      -
+        name: disable-policy
+        type: u32
+      -
+        name: accept-ra-rt-info-min-plen
+        type: u32
+      -
+        name: ndisc-tclass
+        type: u32
+      -
+        name: rpl-seg-enabled
+        type: u32
+      -
+        name: ra-defrtr-metric
+        type: u32
+      -
+        name: ioam6-enabled
+        type: u32
+      -
+        name: ioam6-id
+        type: u32
+      -
+        name: ioam6-id-wide
+        type: u32
+      -
+        name: ndisc-evict-nocarrier
+        type: u32
+      -
+        name: accept-untracked-na
+        type: u32
+  -
+    name: ifla-icmp6-stats
+    type: struct
+    members:
+      -
+        name: inmsgs
+        type: u64
+      -
+        name: inerrors
+        type: u64
+      -
+        name: outmsgs
+        type: u64
+      -
+        name: outerrors
+        type: u64
+      -
+        name: csumerrors
+        type: u64
+      -
+        name: ratelimithost
+        type: u64
+  -
+    name: ifla-inet6-stats
+    type: struct
+    members:
+      -
+        name: inpkts
+        type: u64
+      -
+        name: inoctets
+        type: u64
+      -
+        name: indelivers
+        type: u64
+      -
+        name: outforwdatagrams
+        type: u64
+      -
+        name: outpkts
+        type: u64
+      -
+        name: outoctets
+        type: u64
+      -
+        name: inhdrerrors
+        type: u64
+      -
+        name: intoobigerrors
+        type: u64
+      -
+        name: innoroutes
+        type: u64
+      -
+        name: inaddrerrors
+        type: u64
+      -
+        name: inunknownprotos
+        type: u64
+      -
+        name: intruncatedpkts
+        type: u64
+      -
+        name: indiscards
+        type: u64
+      -
+        name: outdiscards
+        type: u64
+      -
+        name: outnoroutes
+        type: u64
+      -
+        name: reasmtimeout
+        type: u64
+      -
+        name: reasmreqds
+        type: u64
+      -
+        name: reasmoks
+        type: u64
+      -
+        name: reasmfails
+        type: u64
+      -
+        name: fragoks
+        type: u64
+      -
+        name: fragfails
+        type: u64
+      -
+        name: fragcreates
+        type: u64
+      -
+        name: inmcastpkts
+        type: u64
+      -
+        name: outmcastpkts
+        type: u64
+      -
+        name: inbcastpkts
+        type: u64
+      -
+        name: outbcastpkts
+        type: u64
+      -
+        name: inmcastoctets
+        type: u64
+      -
+        name: outmcastoctets
+        type: u64
+      -
+        name: inbcastoctets
+        type: u64
+      -
+        name: outbcastoctets
+        type: u64
+      -
+        name: csumerrors
+        type: u64
+      -
+        name: noectpkts
+        type: u64
+      -
+        name: ect1-pkts
+        type: u64
+      -
+        name: ect0-pkts
+        type: u64
+      -
+        name: cepkts
+        type: u64
+      -
+        name: reasm-overlaps
+        type: u64
+  - name: br-boolopt-multi
+    type: struct
+    members:
+      -
+        name: optval
+        type: u32
+      -
+        name: optmask
+        type: u32
+  -
+    name: if_stats_msg
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+      -
+        name: pad1
+        type: u8
+      -
+        name: pad2
+        type: u16
+      -
+        name: ifindex
+        type: u32
+      -
+        name: filter-mask
+        type: u32
+
+
+attribute-sets:
+  -
+    name: link-attrs
+    name-prefix: ifla-
+    attributes:
+      -
+        name: address
+        type: binary
+        display-hint: mac
+        value: 1
+      -
+        name: broadcast
+        type: binary
+        display-hint: mac
+        value: 2
+      -
+        name: ifname
+        type: string
+        value: 3
+      -
+        name: mtu
+        type: u32
+        value: 4
+      -
+        name: link
+        type: u32
+        value: 5
+      -
+        name: qdisc
+        type: string
+        value: 6
+      -
+        name: stats
+        type: binary
+        value: 7
+        struct: rtnl-link-stats
+      -
+        name: cost
+        type: string
+        value: 8
+      -
+        name: priority
+        type: string
+        value: 9
+      -
+        name: master
+        type: u32
+        value: 10
+      -
+        name: wireless
+        type: string
+        value: 11
+      -
+        name: protinfo
+        type: string
+        value: 12
+      -
+        name: txqlen
+        type: u32
+        value: 13
+      -
+        name: map
+        type: binary
+        value: 14
+        struct: rtnl-link-ifmap
+      -
+        name: weight
+        type: u32
+        value: 15
+      -
+        name: operstate
+        type: u8
+        value: 16
+      -
+        name: linkmode
+        type: u8
+        value: 17
+      -
+        name: linkinfo
+        type: nest
+        value: 18
+        nested-attributes: linkinfo-attrs
+      -
+        name: net-ns-pid
+        type: u32
+        value: 19
+      -
+        name: ifalias
+        type: string
+        value: 20
+      -
+        name: num-vf
+        type: u32
+        value: 21
+      -
+        name: vfinfo-list
+        type: nest
+        value: 22
+        nested-attributes: vfinfo-attrs
+      -
+        name: stats64
+        type: binary
+        value: 23
+        struct: rtnl-link-stats64
+      -
+        name: vf-ports
+        type: nest
+        value: 24
+        nested-attributes: vf-ports-attrs
+      -
+        name: port-self
+        type: nest
+        value: 25
+        nested-attributes: port-self-attrs
+      -
+        name: af-spec
+        type: nest
+        value: 26
+        nested-attributes: af-spec-attrs
+      -
+        name: group
+        type: u32
+        value: 27
+      -
+        name: net-ns-fd
+        type: u32
+        value: 28
+      -
+        name: ext-mask
+        type: u32
+        value: 29
+      -
+        name: promiscuity
+        type: u32
+        value: 30
+      -
+        name: num-tx-queues
+        type: u32
+        value: 31
+      -
+        name: num-rx-queues
+        type: u32
+        value: 32
+      -
+        name: carrier
+        type: u8
+        value: 33
+      -
+        name: phys-port-id
+        type: binary
+        value: 34
+      -
+        name: carrier-changes
+        type: u32
+        value: 35
+      -
+        name: phys-switch-id
+        type: binary
+        value: 36
+      -
+        name: link-netnsid
+        type: s32
+        value: 37
+      -
+        name: phys-port-name
+        type: string
+        value: 38
+      -
+        name: proto-down
+        type: u8
+        value: 39
+      -
+        name: gso-max-segs
+        type: u32
+        value: 40
+      -
+        name: gso-max-size
+        type: u32
+        value: 41
+      -
+        name: pad
+        type: string
+        value: 42
+      -
+        name: xdp
+        type: nest
+        value: 43
+        nested-attributes: xdp-attrs
+      -
+        name: event
+        type: u32
+        value: 44
+      -
+        name: new-netnsid
+        type: s32
+        value: 45
+      -
+        name: if-netnsid
+        type: s32
+        value: 46
+      -
+        name: target-netnsid
+        type: s32
+        value: 46
+      -
+        name: carrier-up-count
+        type: u32
+        value: 47
+      -
+        name: carrier-down-count
+        type: u32
+        value: 48
+      -
+        name: new-ifindex
+        type: s32
+        value: 49
+      -
+        name: min-mtu
+        type: u32
+        value: 50
+      -
+        name: max-mtu
+        type: u32
+        value: 51
+      -
+        name: prop-list
+        type: nest
+        nested-attributes: link-attrs
+        value: 52
+      -
+        name: alt-ifname
+        type: string
+        multi-attr: true
+        value: 53
+      -
+        name: perm-address
+        type: binary
+        display-hint: mac
+        value: 54
+      -
+        name: proto-down-reason
+        type: string
+        value: 55
+      -
+        name: parent-dev-name
+        type: string
+        value: 56
+      -
+        name: parent-dev-bus-name
+        type: string
+        value: 57
+      -
+        name: gro-max-size
+        type: u32
+        value: 58
+      -
+        name: tso-max-size
+        type: u32
+        value: 59
+      -
+        name: tso-max-segs
+        type: u32
+        value: 60
+      -
+        name: allmulti
+        type: u32
+      -
+        name: devlink-port
+        type: binary
+      -
+        name: gso-ipv4-max-size
+        type: u32
+      -
+        name: gro-ipv4-max-size
+        type: u32
+  -
+    name: af-spec-attrs
+    attributes:
+      -
+        name: "inet"
+        type: nest
+        value: 2
+        nested-attributes: ifla-attrs
+      -
+        name: "inet6"
+        type: nest
+        value: 10
+        nested-attributes: ifla6-attrs
+      -
+        name: "mctp"
+        type: nest
+        value: 45
+        nested-attributes: mctp-attrs
+  -
+    name: vfinfo-attrs
+    attributes: []
+  -
+    name: vf-ports-attrs
+    attributes: []
+  -
+    name: port-self-attrs
+    attributes: []
+  -
+    name: linkinfo-attrs
+    attributes:
+      -
+        name: kind
+        type: string
+      -
+        name: data
+        type: binary
+        nested-attributes: linkinfo-bridge-attrs
+      -
+        name: xstats
+        type: binary
+      -
+        name: slave-kind
+        type: string
+      -
+        name: slave-data
+        type: nest
+        nested-attributes: linkinfo-slave-data-attrs
+  -
+    name: linkinfo-bridge-attrs
+    attributes:
+      -
+        name: forward-delay
+        type: u32
+      -
+        name: hello-time
+        type: u32
+      -
+        name: max-age
+        type: u32
+      -
+        name: ageing-time
+        type: u32
+      -
+        name: stp-state
+        type: u32
+      -
+        name: priority
+        type: u16
+      -
+        name: vlan-filtering
+        type: u8
+      -
+        name: vlan-protocol
+        type: u16
+      -
+        name: group-fwd-mask
+        type: u16
+      -
+        name: root-id
+        type: binary
+      -
+        name: bridge-id
+        type: binary
+      -
+        name: root-port
+        type: u16
+      -
+        name: root-path-cost
+        type: u32
+      -
+        name: topology-change
+        type: u8
+      -
+        name: topology-change-detected
+        type: u8
+      -
+        name: hello-timer
+        type: u64
+      -
+        name: tcn-timer
+        type: u64
+      -
+        name: topology-change-timer
+        type: u64
+      -
+        name: gc-timer
+        type: u64
+      -
+        name: group-addr
+        type: binary
+      -
+        name: fdb-flush
+        type: binary
+      -
+        name: mcast-router
+        type: u8
+      -
+        name: mcast-snooping
+        type: u8
+      -
+        name: mcast-query-use-ifaddr
+        type: u8
+      -
+        name: mcast-querier
+        type: u8
+      -
+        name: mcast-hash-elasticity
+        type: u32
+      -
+        name: mcast-hash-max
+        type: u32
+      -
+        name: mcast-last-member-cnt
+        type: u32
+      -
+        name: mcast-startup-query-cnt
+        type: u32
+      -
+        name: mcast-last-member-intvl
+        type: u64
+      -
+        name: mcast-membership-intvl
+        type: u64
+      -
+        name: mcast-querier-intvl
+        type: u64
+      -
+        name: mcast-query-intvl
+        type: u64
+      -
+        name: mcast-query-response-intvl
+        type: u64
+      -
+        name: mcast-startup-query-intvl
+        type: u64
+      -
+        name: nf-call-iptables
+        type: u8
+      -
+        name: nf-call-ip6-tables
+        type: u8
+      -
+        name: nf-call-arptables
+        type: u8
+      -
+        name: vlan-default-pvid
+        type: u16
+      -
+        name: pad
+        type: u32
+      -
+        name: vlan-stats-enabled
+        type: u8
+      -
+        name: mcast-stats-enabled
+        type: u8
+      -
+        name: mcast-igmp-version
+        type: u8
+      -
+        name: mcast-mld-version
+        type: u8
+      -
+        name: vlan-stats-per-port
+        type: u8
+      -
+        name: multi-boolopt
+        type: binary
+        struct: br-boolopt-multi
+      -
+        name: mcast-querier-state
+        type: binary
+  -
+    name: linkinfo-slave-data-attrs
+    attributes: []
+  -
+    name: xdp-attrs
+    attributes:
+      -
+        name: fd
+        type: s32
+      -
+        name: attached
+        type: u8
+      -
+        name: flags
+        type: u32
+      -
+        name: prog-id
+        type: u32
+      -
+        name: drv-prog-id
+        type: u32
+      -
+        name: skb-prog-id
+        type: u32
+      -
+        name: hw-prog-id
+        type: u32
+      -
+        name: expected-fd
+        type: s32
+  -
+    name: ifla-attrs
+    attributes:
+      -
+        name: conf
+        type: binary
+        struct: ipv4-devconf
+  -
+    name: ifla6-attrs
+    attributes:
+      -
+        name: flags
+        type: u32
+      -
+        name: conf
+        type: binary
+        struct: ipv6-devconf
+      -
+        name: stats
+        type: binary
+        struct: ifla-inet6-stats
+      -
+        name: mcast
+        type: binary
+      -
+        name: cacheinfo
+        type: binary
+        struct: ifla-cacheinfo
+      -
+        name: icmp6-stats
+        type: binary
+        struct: ifla-icmp6-stats
+      -
+        name: token
+        type: binary
+      -
+        name: addr-gen-mode
+        type: u8
+      -
+        name: ra-mtu
+        type: u32
+  -
+    name: mctp-attrs
+    attributes:
+      -
+        name: mctp-net
+        type: u32
+  -
+    name: stats-attrs
+    name-prefix: ifla-stats-
+    attributes:
+      -
+        name: link-64
+        type: binary
+        struct: rtnl-link-stats64
+      -
+        name: link-xstats
+        type: binary
+      -
+        name: link-xstats-slave
+        type: binary
+      -
+        name: link-offload-xstats
+        type: nest
+        nested-attributes: link-offload-xstats
+      -
+        name: af-spec
+        type: binary
+  -
+    name: link-offload-xstats
+    attributes:
+      -
+        name: cpu-hit
+        type: binary
+      -
+        name: hw-s-info
+        type: array-nest
+        nested-attributes: hw-s-info-one
+      -
+        name: l3-stats
+        type: binary
+  -
+    name: hw-s-info-one
+    attributes:
+      -
+        name: request
+        type: u8
+      -
+        name: used
+        type: u8
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: newlink
+      doc: Create a new link.
+      attribute-set: link-attrs
+      fixed-header: ifinfomsg
+      do:
+        request:
+          value: 16
+          attributes:
+            - ifi-index
+    -
+      name: dellink
+      doc: Delete an existing link.
+      attribute-set: link-attrs
+      fixed-header: ifinfomsg
+      do:
+        request:
+          value: 16
+          attributes:
+            - ifi-index
+    -
+      name: getlink
+      doc: Get / dump information about a link.
+      attribute-set: link-attrs
+      fixed-header: ifinfomsg
+      do:
+        request:
+          value: 18
+          attributes:
+            - ifi-index
+        reply:
+          value: 16
+          attributes:
+            - ifi-index
+    -
+      name: setlink
+      doc: Set information about a link.
+      value: 19
+      attribute-set: link-attrs
+      fixed-header: ifinfomsg
+      do:
+        request:
+          attributes:
+            - ifname
+    -
+      name: getstats
+      doc: Get / dump link stats.
+      attribute-set: stats-attrs
+      fixed-header: if_stats_msg
+      dump:
+        request:
+          value: 94
+          attributes:
+            - ifindex
+        reply:
+          value: 92
+
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-link
+      value: 1
-- 
2.41.0


