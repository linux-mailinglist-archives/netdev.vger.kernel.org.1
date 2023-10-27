Return-Path: <netdev+bounces-44662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33517D8F8D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 09:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B4C282121
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 07:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB216B662;
	Fri, 27 Oct 2023 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN7krZ2H"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C43FDC
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 07:18:58 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E01AC
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 00:18:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ca052ec63bso15626845ad.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698391133; x=1698995933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4pKes2b+7YPcwtL4VA6A/cgyH7ZP8u5/AnM/aWBGG/0=;
        b=dN7krZ2HL0JU8wF7AUnmsFUecELhrFerx6gb2pyjm5dj5RXQT3bxDjAChU5/1VqVHQ
         w+QBfWGc1p+mBuvX1GUcCU3Y0Pd9fW7BQ3zGKcGiKapFB7H6qGVyexqeuQxNCFZxGVyG
         Osf4suBzHDFcaUhjQsExvfEubAQmgN5c55CYv0XFFgHgFLUHvxTEeX/eVGHUi9WF6dE2
         x1X5q5vESFszHDQZll1Ueg2DeDhKyzeXUNYYwBs/gHO7cNlbLQHUdu9yz2hcooorfDbe
         84aBhlZyNTXviPLHzcsf6/ULmFrYM6sY83gtApo3mERvjk7s1i4fxB0RnbO9kxvgJqJV
         zUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698391133; x=1698995933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pKes2b+7YPcwtL4VA6A/cgyH7ZP8u5/AnM/aWBGG/0=;
        b=ppWgEQ6QZitDjPuV+QPblYiu1hJjikQn8UaeheynW2BjqYfyKWjISz7ex0Aq5TyFui
         ZwNAckKYsOGPsoDCt3C773x97Yh3CExCWSRSOqMA66AKG3yZRsICIMnKl8FYOHeTfyhD
         MmOEBH6fpnpEIjIFLu03rwoJD4gcIWjI6a87jf5kx9/NQgBDS7Z3sX27PsG1JUNMfNko
         CaTZB/CVUzYJ5c974f/ZIVdK3JAuem37x+f9JcGKgy6isbUjg28gE5JRORF8qpHgqdmB
         fzxyAKznmmuM/Rsz541VfUVLNsbScWPjToJxOl7eZM1vSshCcmfWhlQ8dxvefpk5OVX6
         lXLQ==
X-Gm-Message-State: AOJu0Yx8wwIJ46gudj0vWQbNwa8KytqsfMOwv+03Wg7fA6ecLmxdTLy0
	WcE8FZOXDM2LSoSqTfmo9AMEgx5UDBLGbA==
X-Google-Smtp-Source: AGHT+IFvvV4jDihD8iYVnDJX9Wikvp5z+Yu1qs0gAkhpxgoYV1Hv4RuHKs4LQbqb1jpLUmI9zDK+DA==
X-Received: by 2002:a17:902:d4cf:b0:1c5:ec97:1718 with SMTP id o15-20020a170902d4cf00b001c5ec971718mr2251072plg.6.1698391132609;
        Fri, 27 Oct 2023 00:18:52 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001c5fc11c085sm823851pll.264.2023.10.27.00.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 00:18:51 -0700 (PDT)
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
Subject: [RFC Draft PATCHv2 net-next] Doc: update bridge doc
Date: Fri, 27 Oct 2023 15:18:42 +0800
Message-ID: <20231027071842.2705262-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current bridge kernel doc is too old. It only pointed to the
linuxfoundation wiki page which lacks of the new features.

Here let's start the new bridge document and put all the bridge info
so new developers and users could catch up the last bridge status soon.

In this patch, I copied and modifed most of the bridge description from iproute2.
But the Bridge internals part is incomplete as there are too much
attributes while I'm not very familiar. So I only added 2 identifiers as
example. Some part of the documents are generated by ChatGPT as I'm not
good at summarizing.

As a draft patch, please tell me what other part I need to add or
update. Thanks!

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: Drop the python tool that generate iproute man page from kernel doc
---
 Documentation/networking/bridge.rst | 205 ++++++++++++-
 include/uapi/linux/if_bridge.h      |  24 ++
 include/uapi/linux/if_link.h        | 454 ++++++++++++++++++++++++++++
 net/bridge/br_sysfs_br.c            |  94 ++++++
 4 files changed, 767 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index c859f3c1636e..b36bd737c05e 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -4,18 +4,203 @@
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
+Here are the core structs of bridge code.
 
-If you still have questions, don't hesitate to post to the mailing list 
-(more info https://lists.linux-foundation.org/mailman/listinfo/bridge).
+.. kernel-doc:: include/uapi/linux/if_bridge.h
+   :identifiers: __bridge_info
 
+.. kernel-doc:: include/uapi/linux/if_bridge.h
+   :identifiers: __port_info
+
+Bridge uAPI
+===========
+
+The Linux bridge uAPI are exported via the netlink interface. Here are
+all the bridge and bridge port netlink attribute definations.
+
+Bridge netlink attributes
+-------------------------
+
+.. kernel-doc:: include/uapi/linux/if_link.h
+   :doc: The bridge emum defination
+
+Bridge port netlink attributes
+------------------------------
+
+.. kernel-doc:: include/uapi/linux/if_link.h
+   :doc: The bridge port emum defination
+
+Bridge sysfs
+------------
+
+All the sysfs parameters are also exported via the bridge netlink API.
+Here you can find the explanation based on the correspond netlink attributes.
+
+.. kernel-doc:: net/bridge/br_sysfs_br.c
+   :doc: The sysfs bridge attrs
+
+STP
+===
+
+The STP (Spanning Tree Protocol) function in a Linux bridge is a critical
+feature that helps prevent loops in Ethernet networks by identifying and
+disabling redundant links within a network. The primary purpose of STP is
+to ensure network reliability and redundancy while preventing broadcast
+storms and other undesirable network behaviors. In a Linux bridge context,
+STP is crucial for network stability and availability.
+
+STP is a Layer 2 protocol that operates at the Data Link Layer of the OSI
+model. It was originally developed as IEEE 802.1D and has since evolved into
+multiple versions, including Rapid Spanning Tree Protocol (RSTP) and
+Multiple Spanning Tree Protocol (MSTP). The Linux bridge typically support
+the original Spanning Tree Protocol (STP) and Rapid Spanning Tree Protocol
+(RSTP), but not MSTP.
+
+Bridge Ports and STP States
+---------------------------
+
+In the context of STP, bridge ports can be in one of the following states:
+  * Blocking: The port is disabled for data traffic and only listens to
+    BPDUs (Bridge Protocol Data Units) from other devices to determine the
+    network topology.
+  * Listening: The port begins to participate in the STP process and listens
+    for BPDUs.
+  * Learning: The port continues to listen to BPDUs and begins to learn MAC
+    addresses from incoming frames but does not forward data frames.
+  * Forwarding: The port is fully operational and forwards both BPDUs and
+    data frames.
+  * Disabled: The port is administratively disabled and does not participate
+    in the STP process.
+
+Root Bridge and Convergence
+---------------------------
+
+Within a network, one bridge is elected as the "Root Bridge." All other
+bridges participate in STP to determine the shortest path to the Root Bridge.
+
+STP ensures network convergence by calculating the shortest path and disabling
+redundant links. When network topology changes occur (e.g., a link failure),
+STP recalculates the network topology to restore connectivity while avoiding loops.
+
+Proper configuration of STP parameters, such as the bridge priority, can
+influence which bridge becomes the Root Bridge. Careful configuration can
+optimize network performance and path selection.
+
+Multicast
+=========
+
+The multicast functionality in a Linux bridge refers to the ability of the
+bridge to efficiently forward multicast traffic, such as Internet Group
+Management Protocol (IGMP) or Multicast Listener Discovery (MLD) messages,
+and multicast data packets within a local network segment. This is an
+important capability in environments where applications or services rely
+on multicast communication.
+
+By default, Linux bridges are capable of forwarding multicast traffic.
+The bridge acts as a Layer 2 (Data Link Layer) device and forwards multicast
+packets to all bridge ports (except the source port) within the same VLAN.
+
+After enable multicast snooping, the Linux bridge can filter multicast
+traffic based on the destination MAC address, making it more efficient in
+forwarding multicast frames. It maintains a Multicast Filtering Database (MFD)
+that records which multicast groups are associated with each bridge port.
+Multicast traffic is forwarded only to ports with associated group
+memberships.
+
+VLAN
+====
+
+VLAN (Virtual LAN) functionality can be integrated with the Linux bridge to
+provide a way to manage and segregate network traffic into different virtual
+LANs within a single physical network infrastructure. This integration allows
+for greater flexibility in network configuration and traffic isolation.
+
+After enable VLAN filter on bridge, the bridge can handle VLAN-tagged frames
+and forward them to the appropriate destinations based on the VLAN tag.
+
+The Linux bridge supports the IEEE 802.1Q and 802.1AD protocol for VLAN
+tagging.
+
+Switchdev
+=========
+
+Linux Bridge Switchdev is a feature in the Linux kernel that extends the
+capabilities of the traditional Linux bridge to work more efficiently with
+hardware switches that support switchdev. This technology is particularly
+useful in data center and networking environments where high-performance
+and low-latency packet forwarding is essential.
+
+With Linux Bridge Switchdev, certain networking functions like forwarding,
+filtering, and learning of Ethernet frames can be offloaded to the hardware
+switch. This offloading reduces the burden on the Linux kernel and CPU,
+leading to improved network performance and lower latency.
+
+To use Linux Bridge Switchdev, you need hardware switches that support the
+switchdev interface. This means that the switch hardware needs to have the
+necessary drivers and functionality to work in conjunction with the Linux
+kernel.
+
+Netfilter
+=========
+
+The bridge netfilter module allows packet filtering and firewall functionality
+on bridge interfaces. As the Linux bridge, which traditionally operates at
+Layer 2 and connects multiple network interfaces or segments, doesn't have
+built-in packet filtering capabilities.
+
+With bridge netfilter, you can define rules to filter or manipulate Ethernet
+frames as they traverse the bridge. These rules are typically based on
+Ethernet frame attributes such as MAC addresses, VLAN tags, and more.
+You can use the *ebtables* or *nftables* tools to create and manage these
+rules. *ebtables* is a tool specifically designed for managing Ethernet frame
+filtering rules, while *nftables* is a more versatile framework for managing
+rules that can also be used for bridge filtering.
+
+The bridge netfilter is commonly used in scenarios where you want to apply
+security policies to the traffic at the data link layer. This can be useful
+for segmenting and securing networks, enforcing access control policies,
+and isolating different parts of a network.
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
index f95326fce6bb..63e39de1055b 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -52,6 +52,19 @@
 #define BR_STATE_FORWARDING 3
 #define BR_STATE_BLOCKING 4
 
+/**
+ * struct __bridge_info - the bridge information
+ *
+ * @designated_root: Designated bridge's root bridge identifier
+ *
+ * @bridge_id: Current bridge identifier
+ *
+ * @root_path_cost: The cost of bridge root path
+ *
+ * @max_age: The hello packet timeout
+ *
+ * @hello_time: The time in seconds between hello packets sent by the bridge
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
+ * @designated_root: Designated bridge's root bridge identifier
+ *
+ * @designated_bridge: Designated bridge's identifier
+ *
+ * @port_id: Current port id
+ *
+ * @designated_port: Designated port number
+ */
 struct __port_info {
 	__u64 designated_root;
 	__u64 designated_bridge;
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index fac351a93aed..6adc0c70e345 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -461,6 +461,238 @@ enum in6_addr_gen_mode {
 
 /* Bridge section */
 
+/**
+ * DOC: The bridge emum defination
+ *
+ * @IFLA_BR_FORWARD_DELAY
+ *   The bridge forwarding delay in seconds, ie the time spent in LISTENING
+ *   state (before moving to LEARNING) and in LEARNING state (before moving
+ *   to FORWARDING). Only relevant if STP is enabled.
+ *
+ *   The valid values are between 2 and 30. The default value is 15.
+ *
+ * @IFLA_BR_HELLO_TIME
+ *   The time in seconds between hello packets sent by the bridge,
+ *   when it is a root bridge or a designated bridges. Only relevant if
+ *   STP is enabled.
+ *
+ *   The valid values are between 1 and 10. The default value is 2.
+ *
+ * @IFLA_BR_MAX_AGE
+ *   The hello packet timeout, ie the time in seconds until another
+ *   bridge in the spanning tree is assumed to be dead, after reception of
+ *   its last hello message. Only relevant if STP is enabled.
+ *
+ *   The valid values are between 6 and 40. The default value is 20.
+ *
+ * @IFLA_BR_AGEING_TIME
+ *   Configure the bridge's FDB entries ageing time, ie the number of
+ *   seconds a MAC address will be kept in the FDB after a packet has been
+ *   received from that address. after this time has passed, entries are
+ *   cleaned up. Allow values outside the 802.1 standard specification for
+ *   special cases:
+ *
+ *     * 0 - entry never ages (all permanent)
+ *     * 1 - entry disappears (no persistence)
+ *
+ *   The default value is 300.
+ *
+ * @IFLA_BR_STP_STATE
+ *   Turn spanning tree protocol on (*IFLA_BR_STP_STATE* > 0) or off
+ *   (*IFLA_BR_STP_STATE* == 0) for this bridge.
+ *
+ * @IFLA_BR_PRIORITY
+ *   set this bridge's spanning tree priority, used during STP root bridge
+ *   election.
+ *
+ *   The valid values are between 0 and 65535.
+ *
+ * @IFLA_BR_VLAN_FILTERING
+ *   Turn VLAN filtering on (*IFLA_BR_VLAN_FILTERING* > 0) or off
+ *   (*IFLA_BR_VLAN_FILTERING* == 0). When disabled, the bridge will not
+ *   consider the VLAN tag when handling packets.
+ *
+ * @IFLA_BR_VLAN_PROTOCOL
+ *   Set the protocol used for VLAN filtering.
+ *
+ *   The valid values are 0x8100(802.1Q) or 0x88A8(802.1AD).
+ *
+ * @IFLA_BR_GROUP_FWD_MASK
+ *   The group forward mask. This is the bitmask that is applied to
+ *   decide whether to forward incoming frames destined to link-local
+ *   addresses, ie addresses of the form 01:80:C2:00:00:0X (defaults to 0,
+ *   ie the bridge does not forward any linklocal frames coming on this port).
+ *
+ * @IFLA_BR_ROOT_ID
+ *   The bridge root id, only readable from kernel.
+ *
+ * @IFLA_BR_BRIDGE_ID
+ *   The bridge id, only readable from kernel.
+ *
+ * @IFLA_BR_ROOT_PORT
+ *   The bridge root port, only readable from kernel.
+ *
+ * @IFLA_BR_ROOT_PATH_COST
+ *   The bridge root path cost, only readable from kernel.
+ *
+ * @IFLA_BR_TOPOLOGY_CHANGE
+ *   The bridge topology change, only readable from kernel.
+ *
+ * @IFLA_BR_TOPOLOGY_CHANGE_DETECTED
+ *   The bridge topology change detected, only readable from kernel.
+ *
+ * @IFLA_BR_HELLO_TIMER
+ *   The bridge hello timer, only readable from kernel.
+ *
+ * @IFLA_BR_TCN_TIMER
+ *   The bridge tcn timer, only readable from kernel.
+ *
+ * @IFLA_BR_TOPOLOGY_CHANGE_TIMER
+ *   The bridge topology change timer, only readable from kernel.
+ *
+ * @IFLA_BR_GC_TIMER
+ *   The bridge gc timer, only readable from kernel.
+ *
+ * @IFLA_BR_GROUP_ADDR
+ *   set the MAC address of the multicast group this bridge uses for STP.
+ *   The address must be a link-local address in standard Ethernet MAC address
+ *   format, ie an address of the form 01:80:C2:00:00:0X, with X in [0, 4..f].
+ *
+ * @IFLA_BR_FDB_FLUSH
+ *   Flush bridge's fdb dynamic entries.
+ *
+ * @IFLA_BR_MCAST_ROUTER
+ *   Set bridge's multicast router if IGMP snooping is enabled.
+ *   The valid values are:
+ *
+ *     * 0 - disabled.
+ *     * 1 - automatic (queried).
+ *     * 2 - permanently enabled.
+ *
+ * @IFLA_BR_MCAST_SNOOPING
+ *   Turn multicast snooping on (*IFLA_BR_MCAST_SNOOPING* > 0) or off
+ *   (*IFLA_BR_MCAST_SNOOPING* == 0). Default is on.
+ *
+ * @IFLA_BR_MCAST_QUERY_USE_IFADDR
+ *   whether to use the bridge's own IP address as source address for IGMP
+ *   queries (*IFLA_BR_MCAST_QUERY_USE_IFADDR* > 0) or the default of 0.0.0.0
+ *   (*IFLA_BR_MCAST_QUERY_USE_IFADDR* == 0).
+ *
+ * @IFLA_BR_MCAST_QUERIER
+ *   Enable (*IFLA_BR_MULTICAST_QUERIER* > 0) or disable
+ *   (*IFLA_BR_MULTICAST_QUERIER* == 0) IGMP querier, ie sending of multicast
+ *   queries by the bridge.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_MCAST_HASH_ELASTICITY
+ *   Set multicast database hash elasticity, ie the maximum chain length in
+ *   the multicast hash table.
+ *
+ *   The default value is 4.
+ *
+ * @IFLA_BR_MCAST_HASH_MAX
+ *   Set maximum size of multicast hash table
+ *
+ *   The default value is 512, value must be a power of 2.
+ *
+ * @IFLA_BR_MCAST_LAST_MEMBER_CNT
+ *   Set multicast last member count, ie the number of queries the bridge
+ *   will send before stopping forwarding a multicast group after a "leave"
+ *   message has been received.
+ *
+ *   The default value is 2.
+ *
+ * @IFLA_BR_MCAST_STARTUP_QUERY_CNT
+ *   Set the number of IGMP queries to send during startup phase.
+ *
+ *   The default value is 2.
+ *
+ * @IFLA_BR_MCAST_LAST_MEMBER_INTVL
+ *   The interval between queries to find remaining members of a group, after
+ *   a "leave" message is received.
+ *
+ *   The default value is 1.
+ *
+ * @IFLA_BR_MCAST_MEMBERSHIP_INTVL
+ *   The interval after which the bridge will leave a group, if no membership
+ *   reports for this group are received.
+ *
+ *   The default value is 260.
+ *
+ * @IFLA_BR_MCAST_QUERIER_INTVL
+ *   The interval between queries sent by other routers. if no queries are
+ *   seen after this delay has passed, the bridge will start to send its own
+ *   queries (as if **IFLA_BR_MCAST_QUERIER_INTVL** was enabled).
+ *
+ *   The default value is 255.
+ *
+ * @IFLA_BR_MCAST_QUERY_INTVL
+ *   The interval between queries sent by the bridge after the end of the
+ *   startup phase.
+ *
+ *   The default value is 125.
+ *
+ * @IFLA_BR_MCAST_QUERY_RESPONSE_INTVL
+ *   The Max Response Time/Maximum Response Delay for IGMP/MLD queries
+ *   sent by the bridge.
+ *
+ *   The default value is 10.
+ *
+ * @IFLA_BR_MCAST_STARTUP_QUERY_INTVL
+ *   The interval between queries in the startup phase.
+ *
+ *   The default value is 125 / 4.
+ *
+ * @IFLA_BR_NF_CALL_IPTABLES
+ *   Enable (*NF_CALL_IPTABLES* > 0) or disable (*NF_CALL_IPTABLES* == 0)
+ *   iptables hooks on the bridge.
+ *
+ * @IFLA_BR_NF_CALL_IP6TABLES
+ *   Enable (*NF_CALL_IP6TABLES* > 0) or disable (*NF_CALL_IP6TABLES* == 0)
+ *   ip6tables hooks on the bridge.
+ *
+ * @IFLA_BR_NF_CALL_ARPTABLES
+ *   Enable (*NF_CALL_ARPTABLES* > 0) or disable (*NF_CALL_ARPTABLES* == 0)
+ *   arptables hooks on the bridge.
+ *
+ * @IFLA_BR_VLAN_DEFAULT_PVID
+ *   The default PVID (native/untagged VLAN ID) for this bridge.
+ *
+ * @IFLA_BR_PAD
+ *   Bridge attribute padding type for netlink message.
+ *
+ * @IFLA_BR_VLAN_STATS_ENABLED
+ *   Enable (*IFLA_BR_VLAN_STATS_ENABLED* == 1) or disable
+ *   (*IFLA_BR_VLAN_STATS_ENABLED* == 0) per-VLAN stats accounting.
+ *
+ * @IFLA_BR_MCAST_STATS_ENABLED
+ *   Enable (*IFLA_BR_MCAST_STATS_ENABLED* > 0) or disable
+ *   (*IFLA_BR_MCAST_STATS_ENABLED* == 0) multicast (IGMP/MLD) stats
+ *   accounting.
+ *
+ * @IFLA_BR_MCAST_IGMP_VERSION
+ *   Set the IGMP version.
+ *
+ *   The valid values are 2 and 3. The default value is 2.
+ *
+ * @IFLA_BR_MCAST_MLD_VERSION
+ *   Set the MLD version.
+ *
+ *   The valid values are 1 and 2. The default value is 1.
+ *
+ * @IFLA_BR_VLAN_STATS_PER_PORT
+ *   Enable (*IFLA_BR_VLAN_STATS_PER_PORT* == 1) or disable
+ *   (*IFLA_BR_VLAN_STATS_PER_PORT* == 0) per-VLAN per-port stats accounting.
+ *   Can be changed only when there are no port VLANs configured.
+ *
+ * @IFLA_BR_MULTI_BOOLOPT
+ *   Bridge multi bool options, need combine with enum br_boolopt_id.
+ *
+ * @IFLA_BR_MCAST_QUERIER_STATE
+ *   Bridge mcast querier states, only readable from kernel.
+ */
+
 enum {
 	IFLA_BR_UNSPEC,
 	IFLA_BR_FORWARD_DELAY,
@@ -520,11 +752,233 @@ struct ifla_bridge_id {
 	__u8	addr[6]; /* ETH_ALEN */
 };
 
+/**
+ * BRIDGE_MODE_HAIRPIN
+ *   Controls whether traffic may be send back out of the port on which it
+ *   was received. This option is also called reflective relay mode, and is
+ *   used to support basic VEPA (Virtual Ethernet Port Aggregator)
+ *   capabilities. By default, this flag is turned off and the bridge will
+ *   not forward traffic back out of the receiving port.
+ */
+
 enum {
 	BRIDGE_MODE_UNSPEC,
 	BRIDGE_MODE_HAIRPIN,
 };
 
+/**
+ * DOC: The bridge port emum defination
+ *
+ * @IFLA_BRPORT_STATE
+ *   The operation state of the port. Except state 0 (disable STP or BPDU
+ *   filter feature), this is primarily used by user space STP/RSTP
+ *   implementation.
+ *
+ *     * 0 - port is in STP *DISABLED* state. Make this port completely
+ *       inactive for STP. This is also called BPDU filter and could be used
+ *       to disable STP on an untrusted port, like a leaf virtual devices.
+ *     * 1 - port is in STP *LISTENING* state. Only valid if STP is enabled
+ *       on the bridge. In this state the port listens for STP BPDUs and
+ *       drops all other traffic frames.
+ *     * 2 - port is in STP *LEARNING* state. Only valid if STP is enabled on
+ *       the bridge. In this state the port will accept traffic only for the
+ *       purpose of updating MAC address tables.
+ *     * 3 - port is in STP *FORWARDING* state. Port is fully active.
+ *     * 4 - port is in STP *BLOCKING* state. Only valid if STP is enabled on
+ *       the bridge. This state is used during the STP election process.
+ *       In this state, port will only process STP BPDUs.
+ *
+ * @IFLA_BRPORT_PRIORITY
+ *   The STP port priority. The valid values are between 0 and 255.
+ *
+ * @IFLA_BRPORT_COST
+ *   The STP path cost of the port. The valid values are between 1 and 65535.
+ *
+ * @IFLA_BRPORT_MODE
+ *   Set the bridge port mode. See *BRIDGE_MODE_HAIRPIN* for more details.
+ *
+ * @IFLA_BRPORT_GUARD
+ *   Controls whether STP BPDUs will be processed by the bridge port. By
+ *   default, the flag is turned off allowed BPDU processing. Turning this
+ *   flag on will disables the bridge port if a STP BPDU packet is received.
+ *
+ *   If running Spanning Tree on bridge, hostile devices on the network may
+ *   send BPDU on a port and cause network failure. Setting *guard on* will
+ *   detect and stop this by disabling the port. The port will be restarted
+ *   if link is brought down, or removed and reattached.
+ *
+ * @IFLA_BRPORT_PROTECT
+ *   Controls whether a given port is allowed to become root port or not.
+ *   Only used when STP is enabled on the bridge. By default the flag is off.
+ *
+ *   This feature is also called root port guard. If BPDU is received from a
+ *   leaf (edge) port, it should not be elected as root port. This could
+ *   be used if using STP on a bridge and the downstream bridges are not fully
+ *   trusted; this prevents a hostile guest from rerouting traffic.
+ *
+ * @IFLA_BRPORT_FAST_LEAVE
+ *   This flag allows the bridge to immediately stop multicast traffic on a
+ *   port that receives IGMP Leave message. It is only used with IGMP snooping
+ *   is enabled on the bridge. By default the flag is off.
+ *
+ * @IFLA_BRPORT_LEARNING
+ *   Controls whether a given port will learn MAC addresses from received
+ *   traffic or not. If learning if off, the bridge will end up flooding any
+ *   traffic for which it has no FDB entry. By default this flag is on.
+ *
+ * @IFLA_BRPORT_UNICAST_FLOOD
+ *   Controls whether unicast traffic for which there is no FDB entry will
+ *   be flooded towards this given port. By default this flag is on.
+ *
+ * @IFLA_BRPORT_PROXYARP
+ *   Enable proxy ARP on this port.
+ *
+ * @IFLA_BRPORT_LEARNING_SYNC
+ *   Controls whether a given port will sync MAC addresses learned on device
+ *   port to bridge FDB.
+ *
+ * @IFLA_BRPORT_PROXYARP_WIFI
+ *   Enable proxy ARP on this port which meets extended requirements by
+ *   IEEE 802.11 and Hotspot 2.0 specifications.
+ *
+ * @IFLA_BRPORT_ROOT_ID
+ *
+ * @IFLA_BRPORT_BRIDGE_ID
+ *
+ * @IFLA_BRPORT_DESIGNATED_PORT
+ *
+ * @IFLA_BRPORT_DESIGNATED_COST
+ *
+ * @IFLA_BRPORT_ID
+ *
+ * @IFLA_BRPORT_NO
+ *
+ * @IFLA_BRPORT_TOPOLOGY_CHANGE_ACK
+ *
+ * @IFLA_BRPORT_CONFIG_PENDING
+ *
+ * @IFLA_BRPORT_MESSAGE_AGE_TIMER
+ *
+ * @IFLA_BRPORT_FORWARD_DELAY_TIMER
+ *
+ * @IFLA_BRPORT_HOLD_TIMER
+ *
+ * @IFLA_BRPORT_FLUSH
+ *   Flush bridge ports' fdb dynamic entries.
+ *
+ * @IFLA_BRPORT_MULTICAST_ROUTER
+ *   Configure this port for having multicast routers attached. A port with
+ *   a multicast router will receive all multicast traffic.
+ *   The valid values are:
+ *
+ *     * 0 disable multicast routers on this port
+ *     * 1 let the system detect the presence of routers (default)
+ *     * 2 permanently enable multicast traffic forwarding on this port
+ *     * 3 enable multicast routers temporarily on this port, not depending
+ *         on incoming queries.
+ *
+ * @IFLA_BRPORT_PAD
+ *
+ * @IFLA_BRPORT_MCAST_FLOOD
+ *   Controls whether a given port will flood multicast traffic for which
+ *   there is no MDB entry. By default this flag is on.
+ *
+ * @IFLA_BRPORT_MCAST_TO_UCAST
+ *   Controls whether a given port will replicate packets using unicast
+ *   instead of multicast. By default this flag is off.
+ *
+ *   This is done by copying the packet per host and changing the multicast
+ *   destination MAC to a unicast one accordingly.
+ *
+ *   *mcast_to_unicast* works on top of the multicast snooping feature of the
+ *   bridge. Which means unicast copies are only delivered to hosts which
+ *   are interested in it and signalized this via IGMP/MLD reports previously.
+ *
+ *   This feature is intended for interface types which have a more reliable
+ *   and/or efficient way to deliver unicast packets than broadcast ones
+ *   (e.g. WiFi).
+ *
+ *   However, it should only be enabled on interfaces where no IGMPv2/MLDv1
+ *   report suppression takes place. IGMP/MLD report suppression issue is
+ *   usually overcome by the network daemon (supplicant) enabling AP isolation
+ *   and by that separating all STAs.
+ *
+ *   Delivery of STA-to-STA IP multicast is made possible again by enabling
+ *   and utilizing the bridge hairpin mode, which considers the incoming port
+ *   as a potential outgoing port, too (see *BRIDGE_MODE_HAIRPIN* option).
+ *   Hairpin mode is performed after multicast snooping, therefore leading
+ *   to only deliver reports to STAs running a multicast router.
+ *
+ * @IFLA_BRPORT_VLAN_TUNNEL
+ *   Controls whether vlan to tunnel mapping is enabled on the port.
+ *   By default this flag is off.
+*
+ * @IFLA_BRPORT_BCAST_FLOOD
+ *   Controls flooding of broadcast traffic on the given port. By default
+ *   this flag is on.
+ *
+ * @IFLA_BRPORT_GROUP_FWD_MASK
+ *   Set the group forward mask. This is the bitmask that is applied to
+ *   decide whether to forward incoming frames destined to link-local
+ *   addresses, ie addresses of the form 01:80:C2:00:00:0X (defaults to 0,
+ *   ie the bridge does not forward any linklocal frames coming on this port).
+ *
+ * @IFLA_BRPORT_NEIGH_SUPPRESS
+ *   Controls whether neigh discovery (arp and nd) proxy and suppression
+ *   is enabled on the port. By default this flag is off.
+ *
+ * @IFLA_BRPORT_ISOLATED
+ *   Controls whether a given port will be isolated, which means it will be
+ *   able to communicate with non-isolated ports only. By default this
+ *   flag is off.
+ *
+ * @IFLA_BRPORT_BACKUP_PORT
+ *   Enable or disable the port backup. If the port loses carrier all
+ *   traffic will be redirected to the configured backup port.
+ *
+ * @IFLA_BRPORT_MRP_RING_OPEN
+ *
+ * @IFLA_BRPORT_MRP_IN_OPEN
+ *
+ * @IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT
+ *
+ * @IFLA_BRPORT_MCAST_EHT_HOSTS_CNT
+ *
+ * @IFLA_BRPORT_LOCKED
+ *   Controls whether a port will be locked, meaning that hosts behind the
+ *   port will not be able to communicate through the port unless an FDB
+ *   entry with the units MAC address is in the FDB. The common use is that
+ *   hosts are allowed access through authentication with the IEEE 802.1X
+ *   protocol or based on whitelists or like setups. By default this flag is
+ *   off.
+ *
+ * @IFLA_BRPORT_MAB
+ *
+ * @IFLA_BRPORT_MCAST_N_GROUPS
+ *
+ * @IFLA_BRPORT_MCAST_MAX_GROUPS
+ *   Sets the maximum number of MDB entries that can be registered for a
+ *   given port. Attempts to register more MDB entries at the port than this
+ *   limit allows will be rejected, whether they are done through netlink
+ *   (e.g. the bridge tool), or IGMP or MLD membership reports. Setting a
+ *   limit to 0 has the effect of disabling the limit.
+ *
+ *   The default value is 0.
+ *
+ * @IFLA_BRPORT_NEIGH_VLAN_SUPPRESS
+ *   Controls whether neigh discovery (arp and nd) proxy and suppression is
+ *   enabled for a given VLAN on a given port. By default this flag is off.
+ *
+ *   Note that this option only takes effect when *IFLA_BRPORT_NEIGH_SUPPRESS*
+ *   is enabled for a given port.
+ *
+ * @IFLA_BRPORT_BACKUP_NHID
+ *   The FDB nexthop object ID to attach to packets being redirected to a
+ *   backup port that has VLAN tunnel mapping enabled (via the
+ *   *IFLA_BRPORT_VLAN_TUNNEL* option). Setting a value of 0 (default) has
+ *   the effect of not attaching any ID.
+ */
+
 enum {
 	IFLA_BRPORT_UNSPEC,
 	IFLA_BRPORT_STATE,	/* Spanning tree state     */
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index ea733542244c..b43492789c44 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -933,6 +933,100 @@ static ssize_t vlan_stats_per_port_store(struct device *d,
 static DEVICE_ATTR_RW(vlan_stats_per_port);
 #endif
 
+
+/**
+ * DOC: The sysfs bridge attrs
+ *
+ * @forward_delay: IFLA_BR_FORWARD_DELAY
+ *
+ * @hello_time: IFLA_BR_HELLO_TIME
+ *
+ * @max_age: IFLA_BR_MAX_AGE
+ *
+ * @ageing_time: IFLA_BR_AGEING_TIME
+ *
+ * @stp_state: IFLA_BR_STP_STATE
+ *
+ * @group_fwd_mask: IFLA_BR_GROUP_FWD_MASK
+ *
+ * @priority: IFLA_BR_PRIORITY
+ *
+ * @bridge_id: IFLA_BR_BRIDGE_ID
+ *
+ * @root_id: IFLA_BR_ROOT_ID
+ *
+ * @root_path_cost: IFLA_BR_ROOT_PATH_COST
+ *
+ * @root_port: IFLA_BR_ROOT_PORT
+ *
+ * @topology_change: IFLA_BR_TOPOLOGY_CHANGE
+ *
+ * @topology_change_detected: IFLA_BR_TOPOLOGY_CHANGE_DETECTED
+ *
+ * @hello_timer: IFLA_BR_HELLO_TIMER
+ *
+ * @tcn_timer: IFLA_BR_TCN_TIMER
+ *
+ * @topology_change_timer: IFLA_BR_TOPOLOGY_CHANGE_TIMER
+ *
+ * @gc_timer: IFLA_BR_GC_TIMER
+ *
+ * @group_addr: IFLA_BR_GROUP_ADDR
+ *
+ * @flush: IFLA_BR_FDB_FLUSH
+ *
+ * @no_linklocal_learn: BR_BOOLOPT_NO_LL_LEARN
+ *
+ * @multicast_router: IFLA_BR_MCAST_ROUTER
+ *
+ * @multicast_snooping: IFLA_BR_MCAST_SNOOPING
+ *
+ * @multicast_querier: IFLA_BR_MCAST_QUERIER
+ *
+ * @multicast_query_use_ifaddr: IFLA_BR_MCAST_QUERY_USE_IFADDR
+ *
+ * @hash_elasticity: IFLA_BR_MCAST_HASH_ELASTICITY
+ *
+ * @hash_max: IFLA_BR_MCAST_HASH_MAX
+ *
+ * @multicast_last_member_count: IFLA_BR_MCAST_LAST_MEMBER_CNT
+ *
+ * @multicast_startup_query_count: IFLA_BR_MCAST_STARTUP_QUERY_CNT
+ *
+ * @multicast_last_member_interval: IFLA_BR_MCAST_LAST_MEMBER_INTVL
+ *
+ * @multicast_membership_interval: IFLA_BR_MCAST_MEMBERSHIP_INTVL
+ *
+ * @multicast_querier_interval: IFLA_BR_MCAST_QUERIER_INTVL
+ *
+ * @multicast_query_interval: IFLA_BR_MCAST_QUERY_INTVL
+ *
+ * @multicast_query_response_interval: IFLA_BR_MCAST_QUERY_RESPONSE_INTVL
+ *
+ * @multicast_startup_query_interval: IFLA_BR_MCAST_STARTUP_QUERY_INTVL
+ *
+ * @multicast_stats_enabled: IFLA_BR_MCAST_STATS_ENABLED
+ *
+ * @multicast_igmp_version: IFLA_BR_MCAST_IGMP_VERSION
+ *
+ * @multicast_mld_version: IFLA_BR_MCAST_MLD_VERSION
+ *
+ * @nf_call_iptables: IFLA_BR_NF_CALL_IPTABLES
+ *
+ * @nf_call_ip6tables: IFLA_BR_NF_CALL_IP6TABLES
+ *
+ * @nf_call_arptables: IFLA_BR_NF_CALL_ARPTABLES
+ *
+ * @vlan_filtering: IFLA_BR_VLAN_FILTERING
+ *
+ * @vlan_protocol: IFLA_BR_VLAN_PROTOCOL
+ *
+ * @default_pvid: IFLA_BR_VLAN_DEFAULT_PVID
+ *
+ * @vlan_stats_enabled: IFLA_BR_VLAN_STATS_ENABLED
+ *
+ * @vlan_stats_per_port: IFLA_BR_VLAN_STATS_PER_PORT
+ */
 static struct attribute *bridge_attrs[] = {
 	&dev_attr_forward_delay.attr,
 	&dev_attr_hello_time.attr,
-- 
2.41.0


