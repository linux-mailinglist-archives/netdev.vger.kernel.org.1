Return-Path: <netdev+bounces-47066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3887E7B33
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE371C20AAF
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B5913ADB;
	Fri, 10 Nov 2023 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edn46S15"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88713AE3
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:16:09 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9814A27B3A
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:07 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c115026985so1927846b3a.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699611366; x=1700216166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sAiLIgT4qi4t1bVCW7qCl8HWX6A6KvoLcdNT6YyDaE=;
        b=edn46S152MfqIIkQVJ/oJmrfvixSVNqjwioU+GS/HnAjvgMHp2FScC0EzGVvriiEY4
         XD+Uo1XJuX7x2MmHQ5O9veORmKmflfgSWmSo9n9RQks3qMuwycwTsYlAFaPtMpA6g3aV
         Fel5jTkcHWk/OznfYJh5OvtMYd0o/xFNg+IoSHfeJRaGVq660PVDL9MMuitEvN+RxQqo
         UKd/iTpDofeHrA0X7IzYJD4Fjwe9mXTD+2ssENk/PcvktvAyms3XbcHf2SbQI2QdQUty
         NXXCLIOWzKWD3SC35RS2B0mAxkkqUH8G9zSV+RGRITrNgR/GvzNT81ZeJgtYPHxNKenJ
         u38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611366; x=1700216166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sAiLIgT4qi4t1bVCW7qCl8HWX6A6KvoLcdNT6YyDaE=;
        b=hAhEnEMw0FAtW/7swOty0CPuHC6JcQtjXjkuleAPtHiLOoH5WMKMPNi50I2WnI2/uy
         YXnHpYAinWn3BWxaXDgVcElnzuJQo1yQSfGlyQoSTqT2mHQ05s+GkKByB8p+aprrzUWg
         pSSMA9jPwxIwOZW4uGpISicLU+xjTtOB+5BYiVqH54DXZfHhGBeSY5Z1vRZG0QVBj5kE
         uveuV9cwiTPj/KsJ6b1OeRPvwYZrnOjJmS5u6Y8H9hmdVtrGMFMR0/Bde0tIeb+E0Fpd
         DCYYRIgMaV1e19w+B8pFEDk2Qix18ugq0sHQr4+5REgVgwRVz7g4f5UVdWnjQFHjIq6Q
         tLbQ==
X-Gm-Message-State: AOJu0YycP78IdXE/he4ltyOcfTYEKLh7eH/a43J+oWer/q97mKKxK4m5
	/vOqSylbNLDIJ27I11dWQ6KlxdzejTcY7Q==
X-Google-Smtp-Source: AGHT+IF1b5cA+n17w6IQlUG0HI7T8uI+7ynFe8cY4UjXyuGFaIVvIbbT7K4MwTbGbM6E87zg34dSrA==
X-Received: by 2002:a05:6a20:432c:b0:181:16dc:d1ae with SMTP id h44-20020a056a20432c00b0018116dcd1aemr8792079pzk.48.1699611366298;
        Fri, 10 Nov 2023 02:16:06 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b0027d015c365csm1244631pjb.31.2023.11.10.02.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:16:05 -0800 (PST)
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
	Florian Westphal <fw@strlen.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCHv3 net-next 02/10] net: bridge: add document for IFLA_BRPORT enum
Date: Fri, 10 Nov 2023 18:15:39 +0800
Message-ID: <20231110101548.1900519-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110101548.1900519-1-liuhangbin@gmail.com>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add document for IFLA_BRPORT enum so we can use it in
Documentation/networking/bridge.rst.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/uapi/linux/if_link.h | 227 +++++++++++++++++++++++++++++++++++
 1 file changed, 227 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 32d6980b78d1..a196a6e4dafb 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -792,11 +792,238 @@ struct ifla_bridge_id {
 	__u8	addr[6]; /* ETH_ALEN */
 };
 
+/**
+ * DOC: The bridge mode enum defination
+ *
+ * @BRIDGE_MODE_HAIRPIN
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
+ * DOC: The bridge port enum defination
+ *
+ * @IFLA_BRPORT_STATE
+ *   The operation state of the port. Except state 0 (disable STP or BPDU
+ *   filter feature), this is primarily used by user space STP/RSTP
+ *   implementation.
+ *
+ *     * 0 - port is in STP *DISABLED* state. Make this port completely
+ *       inactive for STP. This is also called BPDU filter and could be used
+ *       to disable STP on an untrusted port, like a leaf virtual devices.
+ *       The traffic forwarding is also stopped on this port.
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
+ *   Configure the port's multicast router presence. A port with
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
+ *   are interested in unicast and signaled this via IGMP/MLD reports previously.
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
+ *
+ * @IFLA_BRPORT_BCAST_FLOOD
+ *   Controls flooding of broadcast traffic on the given port. By default
+ *   this flag is on.
+ *
+ * @IFLA_BRPORT_GROUP_FWD_MASK
+ *   Set the group forward mask. This is a bitmask that is applied to
+ *   decide whether to forward incoming frames destined to link-local
+ *   addresses. The addresses of the form are 01:80:C2:00:00:0X (defaults
+ *   to 0, which means the bridge does not forward any link-local frames
+ *   coming on this port).
+ *
+ * @IFLA_BRPORT_NEIGH_SUPPRESS
+ *   Controls whether neighbor discovery (arp and nd) proxy and suppression
+ *   is enabled on the port. By default this flag is off.
+ *
+ * @IFLA_BRPORT_ISOLATED
+ *   Controls whether a given port will be isolated, which means it will be
+ *   able to communicate with non-isolated ports only. By default this
+ *   flag is off.
+ *
+ * @IFLA_BRPORT_BACKUP_PORT
+ *   Set a backup port. If the port loses carrier all traffic will be
+ *   redirected to the configured backup port. Set the value to 0 to disable
+ *   it.
+ *
+ * @IFLA_BRPORT_MRP_RING_OPEN
+ *
+ * @IFLA_BRPORT_MRP_IN_OPEN
+ *
+ * @IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT
+ *   The number of per-port EHT hosts limit. The default value is 512.
+ *   Setting to 0 is not allowed.
+ *
+ * @IFLA_BRPORT_MCAST_EHT_HOSTS_CNT
+ *   The current number of tracked hosts, read only.
+ *
+ * @IFLA_BRPORT_LOCKED
+ *   Controls whether a port will be locked, meaning that hosts behind the
+ *   port will not be able to communicate through the port unless an FDB
+ *   entry with the units MAC address is in the FDB. The common use case is that
+ *   hosts are allowed access through authentication with the IEEE 802.1X
+ *   protocol or based on whitelists. By default this flag is off.
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
+ *   limit to 0 disables the limit. The default value is 0.
+ *
+ * @IFLA_BRPORT_NEIGH_VLAN_SUPPRESS
+ *   Controls whether neighbor discovery (arp and nd) proxy and suppression is
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
-- 
2.41.0


