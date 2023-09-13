Return-Path: <netdev+bounces-33499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B838679E3B1
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B807B1C20D89
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631BE1DDE2;
	Wed, 13 Sep 2023 09:29:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525001DDCF
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:29:10 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB019DD
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:29:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c1e780aa95so45722285ad.3
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694597349; x=1695202149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yxc1kezsbQhdOsDeD0k4/6ZVbrNk/m8GV17oLl0hH0A=;
        b=qPToGfR+3db9A6BHHr+OC6TYkirPfPCQpNqBY2w1BTd1N8TM/EZG/IsvMwEQKmbZy+
         uZxepVWYpi6laMHV0NqGjNoJeayM3iW9P3rNPYjVIjx/jE3lXspVKPzwgAuYGsbx/8OT
         EtPnHWHYQmKMwfaEfRwI5zn0tZYej1WUWIvhl6l9rhRU4Qd94sUmIFIHliaID0uz1W9F
         t52LT3mP+DUWd7O5WVZUWjer7U6CyUGz+z7SfuibZjs77cv3cCUAPeQV9PPc73Ub3sRE
         MiefKzNiPtLwo513poCgmof5YtudjCNHPOfoon85PBhgj8urBMTofiHw9ZJvyjty6a4Y
         ciGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694597349; x=1695202149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yxc1kezsbQhdOsDeD0k4/6ZVbrNk/m8GV17oLl0hH0A=;
        b=rcgLGgiP48aH1cjNIrbQWAudUl7rVePbWi/lXcj0E/TYwnXNTZ3sV0EReVYUf81eE+
         hwDaUfMvTOwA7o63TFYGnrH0jsbzwzS5MwNyk8BCF+Xn94FWxyLIe/LWaUTwrZPI/6la
         /Eez1Op1zo5H+L8XKxeHeVPZJz7qYnSfBbYmWX0R0YjDosKB8T6YdjHhL3bauLVJ9Hmc
         RVKLXUhbbAURv+oauA2NdpaG/m5b0tl35YRUzt4UfAx1Kmc6hyQkWj6qdZzkyysw3WNh
         r9yzvDLPXB4x69pdZxncED5jbu+kYkDkYH5XnpGhMaY/KFrmIJSADJUbPs08E9bYdu0j
         gDwA==
X-Gm-Message-State: AOJu0YyMQ0emlac7XQ2twlj0aUZgAGndMlJ5pC5FArjusKev8ceKhaqB
	fDrl3SrXVKuHzyhUEI8yxAb2Y2pZ4MLBe/ie
X-Google-Smtp-Source: AGHT+IGhoMysYZou19LCRWF7jNpBklda5JOjguC6Srcwc4GfQGI/PQ7IaSadDwaq/O+p2Rhax6WzWw==
X-Received: by 2002:a17:902:c24c:b0:1bf:5df2:8e97 with SMTP id 12-20020a170902c24c00b001bf5df28e97mr2173185plg.4.1694597348724;
        Wed, 13 Sep 2023 02:29:08 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001bbb1eec92esm9951481plg.281.2023.09.13.02.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:29:08 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC Draft PATCH net-next] Doc: update bridge doc
Date: Wed, 13 Sep 2023 17:28:53 +0800
Message-ID: <20230913092854.1027336-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913092854.1027336-1-liuhangbin@gmail.com>
References: <20230913092854.1027336-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an example of bridge doc update. In this example I use the
sphinx identifier to insert the structure description in the doc.

I plan to copy all the iproute2 bridge related man docs first.
Please tell me if other doc I need to add.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst |  85 ++++++++++--
 include/uapi/linux/if_bridge.h      |  24 ++++
 include/uapi/linux/if_link.h        | 194 ++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index c859f3c1636e..7a877c304478 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -4,18 +4,83 @@
 Ethernet Bridging
 =================
 
-In order to use the Ethernet bridging functionality, you'll need the
-userspace tools.
+Introduction
+============
 
-Documentation for Linux bridging is on:
-   https://wiki.linuxfoundation.org/networking/bridge
+A bridge is a way to connect two Ethernet segments together in a protocol
+independent way. Packets are forwarded based on Ethernet address, rather
+than IP address (like a router). Since forwarding is done at Layer 2, all
+protocols can go transparently through a bridge.
 
-The bridge-utilities are maintained at:
-   git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/bridge-utils.git
+Bridge internals
+================
 
-Additionally, the iproute2 utilities can be used to configure
-bridge devices.
+.. kernel-doc:: include/uapi/linux/if_bridge.h
+   :identifiers: __bridge_info
 
-If you still have questions, don't hesitate to post to the mailing list 
-(more info https://lists.linux-foundation.org/mailman/listinfo/bridge).
+.. kernel-doc:: include/uapi/linux/if_bridge.h
+   :identifiers: __port_info
+
+Bridge uAPI
+===========
+
+Bridge netlink attributes
+-------------------------
+
+.. kernel-doc:: include/uapi/linux/if_link.h
+   :doc: The bridge emum defination
+
+Bridge sysfs
+------------
+
+Most of them are same with netlink attributes. What about the read only
+parameters like gc_timer, tcn_timer? Should we doc them?
+
+STP
+===
+
+Multicast
+=========
+
+VLAN
+====
+
+Switchdev
+=========
+
+Netfilter
+=========
+
+FAQ
+===
+
+What does a bridge do?
+----------------------
+
+A bridge transparently relays traffic between multiple network interfaces.
+In plain English this means that a bridge connects two or more physical
+Ethernets together to form one bigger (logical) Ethernet.
+
+Is it protocol independent?
+---------------------------
+
+Yes. The bridge knows nothing about protocols, it only sees Ethernet frames.
+As such, the bridging functionality is protocol independent, and there should
+be no trouble relaying IPX, NetBEUI, IP, IPv6, etc.
+
+Contact Info
+============
+
+The code is currently maintained by Roopa Prabhu <roopa@nvidia.com> and
+Nikolay Aleksandrov <razor@blackwall.org>. Bridge bugs and enhancements
+are discussed on the linux-netdev mailing list netdev@vger.kernel.org and
+bridge@lists.linux-foundation.org.
+
+The list is open to anyone interested: http://vger.kernel.org/vger-lists.html#netdev
+
+External Links
+==============
+
+The old Documentation for Linux bridging is on:
+https://wiki.linuxfoundation.org/networking/bridge
 
diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index f95326fce6bb..7e8ee14afc3a 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -52,6 +52,19 @@
 #define BR_STATE_FORWARDING 3
 #define BR_STATE_BLOCKING 4
 
+/**
+ * struct __bridge_info - the bridge information
+ *
+ * @designated_root: designated root
+ *
+ * @bridge_id: bridge id
+ *
+ * @root_path_cost: root path cost
+ *
+ * @max_age: max age
+ *
+ * @hello_time: hello time
+ */
 struct __bridge_info {
 	__u64 designated_root;
 	__u64 bridge_id;
@@ -74,6 +87,17 @@ struct __bridge_info {
 	__u32 gc_timer_value;
 };
 
+/**
+ * struct __port_info - the bridge port information
+ *
+ * @designated_root: designated root
+ *
+ * @designated_bridge: designated bridge
+ *
+ * @port_id: port id
+ *
+ * @designated_port: designated port
+ */
 struct __port_info {
 	__u64 designated_root;
 	__u64 designated_bridge;
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index ce3117df9cec..277855ccad1e 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -461,6 +461,200 @@ enum in6_addr_gen_mode {
 
 /* Bridge section */
 
+/**
+ * DOC: The bridge emum defination
+ *
+ * @IFLA_BR_FORWARD_DELAY:
+ *   set the forwarding delay in seconds, ie the time spent in LISTENING
+ *   state (before moving to LEARNING) and in LEARNING state (before moving
+ *   to FORWARDING). Only relevant if STP is enabled. Valid values are
+ *   between 2 and 30.
+ *
+ * @IFLA_BR_HELLO_TIME:
+ *   set the time in seconds between hello packets sent by the bridge,
+ *   when it is a root bridge or a designated bridges. Only relevant if
+ *   STP is enabled. Valid values are between 1 and 10.
+ *
+ * @IFLA_BR_MAX_AGE:
+ *   set the hello packet timeout, ie the time in seconds until another
+ *   bridge in the spanning tree is assumed to be dead, after reception of
+ *   its last hello message. Only relevant if STP is enabled. Valid values
+ *   are between 6 and 40.
+ *
+ * @IFLA_BR_AGEING_TIME:
+ *   configure the bridge's FDB entries ageing time, ie the number of
+ *   seconds a MAC address will be kept in the FDB after a packet has been
+ *   received from that address. after this time has passed, entries are
+ *   cleaned up.
+ *
+ * @IFLA_BR_STP_STATE:
+ *   turn spanning tree protocol on (*IFLA_BR_STP_STATE* > 0) or off
+ *   (*IFLA_BR_STP_STATE* == 0). for this bridge.
+ *
+ * @IFLA_BR_PRIORITY:
+ *   set this bridge's spanning tree priority, used during STP root bridge
+ *   election.  *IFLA_BR_PRIORITY* is a 16bit unsigned integer.
+ *
+ * @IFLA_BR_VLAN_FILTERING:
+ *   turn VLAN filtering on (*IFLA_BR_VLAN_FILTERING* > 0) or off
+ *   (*IFLA_BR_VLAN_FILTERING* == 0). When disabled, the bridge will not
+ *   consider the VLAN tag when handling packets.
+ *
+ * @IFLA_BR_VLAN_PROTOCOL:
+ *   set the protocol used for VLAN filtering.
+ *
+ * @IFLA_BR_GROUP_FWD_MASK:
+ *   set the group forward mask. This is the bitmask that is applied to
+ *   decide whether to forward incoming frames destined to link-local
+ *   addresses, ie addresses of the form 01:80:C2:00:00:0X (defaults to 0,
+ *   ie the bridge does not forward any linklocal frames coming on this port).
+ *
+ * @IFLA_BR_ROOT_ID:
+ *   Bridge root id.
+ *
+ * @IFLA_BR_BRIDGE_ID:
+ *   Bridge id.
+ *
+ * @IFLA_BR_ROOT_PORT:
+ *   Bridge root port.
+ *
+ * @IFLA_BR_ROOT_PATH_COST:
+ *   Bridge path cost.
+ *
+ * @IFLA_BR_TOPOLOGY_CHANGE:
+ *   Bridge topology change.
+ *
+ * @IFLA_BR_TOPOLOGY_CHANGE_DETECTED:
+ *   Bridge topology change detected.
+ *
+ * @IFLA_BR_HELLO_TIMER:
+ *   Bridge hello timer.
+ *
+ * @IFLA_BR_TCN_TIMER:
+ *   Bridge TCN timer.
+*
+ * @IFLA_BR_TOPOLOGY_CHANGE_TIMER:
+ *   Bridge topology change timer.
+ *
+ * @IFLA_BR_GC_TIMER:
+ *   Bridge gc timer.
+ *
+ * @IFLA_BR_GROUP_ADDR:
+ *   set the MAC address of the multicast group this bridge uses for STP.
+ *   The address must be a link-local address in standard Ethernet MAC address
+ *   format, ie an address of the form 01:80:C2:00:00:0X, with X in [0, 4..f].
+ *
+ * @IFLA_BR_FDB_FLUSH:
+ *   Bridge FDB flush.
+ *
+ * @IFLA_BR_MCAST_ROUTER:
+ *   set bridge's multicast router if IGMP snooping is enabled.
+ *   *IFLA_BR_MCAST_ROUTER* is an integer value having the following meaning:
+ *
+ *     * **0** - disabled.
+ *     * **1** - automatic (queried).
+ *     * **2** - permanently enabled.
+ *
+ * @IFLA_BR_MCAST_SNOOPING:
+ *   turn multicast snooping on (*IFLA_BR_MCAST_SNOOPING* > 0) or off
+ *   (*IFLA_BR_MCAST_SNOOPING* == 0).
+ *
+ * @IFLA_BR_MCAST_QUERY_USE_IFADDR:
+ *   whether to use the bridge's own IP address as source address for IGMP
+ *   queries (*IFLA_BR_MCAST_QUERY_USE_IFADDR* > 0) or the default of 0.0.0.0
+ *   (*IFLA_BR_MCAST_QUERY_USE_IFADDR* == 0).
+ *
+ * @IFLA_BR_MCAST_QUERIER:
+ *   enable (*IFLA_BR_MULTICAST_QUERIER* > 0) or disable
+ *   (*IFLA_BR_MULTICAST_QUERIER* == 0) IGMP querier, ie sending of multicast
+ *   queries by the bridge (default: disabled).
+ *
+ * @IFLA_BR_MCAST_HASH_ELASTICITY:
+ *   set multicast database hash elasticity, ie the maximum chain length in
+ *   the multicast hash table (defaults to 4).
+ *
+ * @IFLA_BR_MCAST_HASH_MAX:
+ *   set maximum size of multicast hash table (defaults to 512, value must
+ *   be a power of 2).
+ *
+ * @IFLA_BR_MCAST_LAST_MEMBER_CNT:
+ *   set multicast last member count, ie the number of queries the bridge
+ *   will send before stopping forwarding a multicast group after a "leave"
+ *   message has been received (defaults to 2).
+ *
+ * @IFLA_BR_MCAST_STARTUP_QUERY_CNT:
+ *   set the number of IGMP queries to send during startup phase (defaults
+ *   to 2).
+ *
+ * @IFLA_BR_MCAST_LAST_MEMBER_INTVL:
+ *   interval between queries to find remaining members of a group, after
+ *   a "leave" message is received.
+ *
+ * @IFLA_BR_MCAST_MEMBERSHIP_INTVL:
+ *   delay after which the bridge will leave a group, if no membership
+ *   reports for this group are received.
+ *
+ * @IFLA_BR_MCAST_QUERIER_INTVL:
+ *   interval between queries sent by other routers. if no queries are seen
+ *   after this delay has passed, the bridge will start to send its own
+ *   queries (as if **IFLA_BR_MCAST_QUERIER_INTVL** was enabled).
+ *
+ * @IFLA_BR_MCAST_QUERY_INTVL:
+ *   interval between queries sent by the bridge after the end of the
+ *   startup phase.
+ *
+ * @IFLA_BR_MCAST_QUERY_RESPONSE_INTVL:
+ *   set the Max Response Time/Maximum Response Delay for IGMP/MLD queries
+ *   sent by the bridge.
+ *
+ * @IFLA_BR_MCAST_STARTUP_QUERY_INTVL:
+ *   interval between queries in the startup phase.
+ *
+ * @IFLA_BR_NF_CALL_IPTABLES:
+ *   enable (*NF_CALL_IPTABLES* > 0) or disable (*NF_CALL_IPTABLES* == 0)
+ *   iptables hooks on the bridge.
+ *
+ * @IFLA_BR_NF_CALL_IP6TABLES:
+ *   enable (*NF_CALL_IP6TABLES* > 0) or disable (*NF_CALL_IP6TABLES* == 0)
+ *   ip6tables hooks on the bridge.
+ *
+ * @IFLA_BR_NF_CALL_ARPTABLES:
+ *   enable (*NF_CALL_ARPTABLES* > 0) or disable (*NF_CALL_ARPTABLES* == 0)
+ *   arptables hooks on the bridge.
+ *
+ * @IFLA_BR_VLAN_DEFAULT_PVID:
+ *   set the default PVID (native/untagged VLAN ID) for this bridge.
+ *
+ * @IFLA_BR_PAD:
+ *   Bridge attr PAD
+ *
+ * @IFLA_BR_VLAN_STATS_ENABLED:
+ *   enable (*IFLA_BR_VLAN_STATS_ENABLED* == 1) or disable
+ *   (*IFLA_BR_VLAN_STATS_ENABLED* == 0) per-VLAN stats accounting.
+ *
+ * @IFLA_BR_MCAST_STATS_ENABLED:
+ *   enable (*IFLA_BR_MCAST_STATS_ENABLED* > 0) or disable
+ *   (*IFLA_BR_MCAST_STATS_ENABLED* == 0) multicast (IGMP/MLD) stats
+ *   accounting.
+ *
+ * @IFLA_BR_MCAST_IGMP_VERSION:
+ *   set the IGMP version.
+ *
+ * @IFLA_BR_MCAST_MLD_VERSION:
+ *   set the MLD version.
+ *
+ * @IFLA_BR_VLAN_STATS_PER_PORT:
+ *   enable (*IFLA_BR_VLAN_STATS_PER_PORT* == 1) or disable
+ *   (*IFLA_BR_VLAN_STATS_PER_PORT* == 0) per-VLAN per-port stats accounting.
+ *   Can be changed only when there are no port VLANs configured.
+ *
+ * @IFLA_BR_MULTI_BOOLOPT:
+ *   Bridge multi bool options.
+ *
+ * @IFLA_BR_MCAST_QUERIER_STATE:
+ *   Bridge mcast querier state.
+ */
+
 enum {
 	IFLA_BR_UNSPEC,
 	IFLA_BR_FORWARD_DELAY,
-- 
2.41.0


