Return-Path: <netdev+bounces-47067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CDD7E7B34
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE146281858
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD26113ADA;
	Fri, 10 Nov 2023 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XilChS5R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6AD13FE7
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:16:12 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C94F27B3D
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:11 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2809b4d648bso1679657a91.2
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699611370; x=1700216170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iu/XicMEh4XOAp+BOU3UzbdELMKrxAqCsG1rt/3Ub4=;
        b=XilChS5RXui8947sJL8qZb7bepoSh/M3UQYnRJ6WH5IK8zk6RMJLmdoRMKmL0Cfoy5
         Vr1I6XRwW3Gz0rVpnnDvjPBEG6Z5Y9eriz+pScA7ZB+CkkdqQ/SJIPDxwhgYOM39b3I9
         hpDEVhMoM/Sg5mquv3J1ziiovryNjiXGvjbJ6VlcOx7BpJDZcPupaePxU5ldfn3VcAxf
         HSDXlDau2zj79W80foKA2fV+I+kgmUbS5PgXVWt4TtonvsmzcJs0i2rvcFQZjqUU+EX6
         AAQv0fZXMR1s3CroHQCWkhVCXtpyMsyhyIVekvkakU4Tmv1JvKcbAFN5pvgBuONZd72G
         BI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611370; x=1700216170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iu/XicMEh4XOAp+BOU3UzbdELMKrxAqCsG1rt/3Ub4=;
        b=Po+VJHyYQzNGJxWy/eBk+r6BNlde9OQ4vZoAhEQ3DIbzldgmLW8xNcNFBG7BklFE95
         VvPUkL4ifAa9vEkUfLxBRYRXIBeNP4JcdCcEqBAeSZk5vRH+EsYHU0/JmLOStz9Jn1M+
         2xeGktedmt1ov8CSRbhEnKlTumpNomoM9FvgCZDLgpMoxg590CKzWEm6xE2tbrMlgtnv
         n5fh2WTuRijlecdIl7ZWHJgUbclUZTLD5JLyoQP7e0ZpOZt3fwy8vrwiQLrJR2A6sH/0
         Qs8sZKT5w7/C6JiwO+WHGiv1Q/UWEiWkM7QWfv/wRE72LVV34vavmW2EcnQxknEHS3AB
         PQ1g==
X-Gm-Message-State: AOJu0YxoYVb5MCUgDbMBUP0Yzyan/RcMmMi6f74260dEOHO0ttGdBTVN
	69T9qEAob1f5NbiGxzNu15Ta1XjV4GFtaQ==
X-Google-Smtp-Source: AGHT+IFZCNMCcC/VkoH2BgnXs8Ygoh83K/0H0MMsf4L+9nxPNrXCQH/U3EWMNQgdxwCmTE5p7XUcCA==
X-Received: by 2002:a17:90b:4a50:b0:27d:3439:c141 with SMTP id lb16-20020a17090b4a5000b0027d3439c141mr3778710pjb.39.1699611370360;
        Fri, 10 Nov 2023 02:16:10 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b0027d015c365csm1244631pjb.31.2023.11.10.02.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:16:09 -0800 (PST)
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
Subject: [RFC PATCHv3 net-next 03/10] net: bridge: add document for bridge sysfs attribute
Date: Fri, 10 Nov 2023 18:15:40 +0800
Message-ID: <20231110101548.1900519-4-liuhangbin@gmail.com>
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

Although the sysfs interface is deprecated and should not be extended
if new options are added. There are still users and admins use this
interface to config bridge options. It would help users to know what
the meaning of each field. Add correspond netlink enums (as we have
document for them) for bridge sysfs attributes, so we can use it in
Documentation/networking/bridge.rst.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_sysfs_br.c | 93 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index ea733542244c..148ecf5aafc6 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -933,6 +933,99 @@ static ssize_t vlan_stats_per_port_store(struct device *d,
 static DEVICE_ATTR_RW(vlan_stats_per_port);
 #endif
 
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


