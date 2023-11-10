Return-Path: <netdev+bounces-47071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F247E7B3F
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68999B20B19
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FFA13AED;
	Fri, 10 Nov 2023 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWfVVfJB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE313FE6
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:16:28 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD1127B3D
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:27 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so1644108b3a.3
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699611386; x=1700216186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlYhocWc8bFOSx5GVul6Jouf/5+cjWsgGhm8vCIaY7w=;
        b=FWfVVfJB2I49cujzegD462yCZVL3gUEjZG8vpbeOmBl9si7NOMZAGwydyh2a53v0z7
         zGT0Q87Ku4dr8RR3vckFx/SmbyS5G3+W/y11H7WzB4uYEfSH0s+zl96l6+/WqXCKWL8/
         UZGw5A/BFWSngnj2v66LLTCx/GzMMKSegllelm509Ev2PkrgcXtoWqykQSS9T7iUsDU8
         7b3gKMp+sKH0pxj33VxpmbBB9wx+VnCKhvQ+wINU6/zj4oAeIGptQU6nqmJk2H+4eEcl
         +xn4uQFZefj72PN/ZC6hpBwO1HIPCEGFHxnYKboJVnQR0S64lGSAd3uj5B6aGOK06C5+
         UE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611386; x=1700216186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlYhocWc8bFOSx5GVul6Jouf/5+cjWsgGhm8vCIaY7w=;
        b=PD/iEl7qsbR/OWnMdHwKOxWjPXyQZ20gCG0f3v9x+qcQ9BfnaBmD0LdQmij93+ly3y
         2Vjp6FJE8S0ZPOpIJoB5XeqPJNV3vCsNYZG81yv9wNK8wlPqCaxQGxkKwWzWaj6rZ4LR
         b6hV25lgSiDa7RuB6TTfNZykpRKLRssfh19/uCGrfsd/sHR8uqbh5BI0Cnhf0RBlWV+w
         uHW8xUZoC3kxmOgl7JN7o9/Yjkz97xN9TENwxGN7pthpzDWZN0ZS3fZHV9QsWdggIt7f
         wpxhyHISgLrHY8zbi9yr6j0dV9FanGMPuZcL2qddH7/dlQmgUR6j0vouQ/ugnILtGiRc
         qfkg==
X-Gm-Message-State: AOJu0YyyjfGHexz6m8Z4yCoSqrxd2FDmxZZ98Plo0w7t5bfPIh14Uvov
	7SWzET2YqL8Wrdog2CosMNSiMEQyVlK9AQ==
X-Google-Smtp-Source: AGHT+IG2tlFgC9vtRpUWIXkiMxcrgcSo34L+CqKUP7vvP4DLnGh3resbPCn40gbxpvash49LsMR3sw==
X-Received: by 2002:a05:6a20:3956:b0:17a:eddb:ac65 with SMTP id r22-20020a056a20395600b0017aeddbac65mr8069418pzg.9.1699611386642;
        Fri, 10 Nov 2023 02:16:26 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b0027d015c365csm1244631pjb.31.2023.11.10.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:16:26 -0800 (PST)
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
Subject: [RFC PATCHv3 net-next 07/10] docs: bridge: add multicast doc
Date: Fri, 10 Nov 2023 18:15:44 +0800
Message-ID: <20231110101548.1900519-8-liuhangbin@gmail.com>
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

Add multicast part for bridge document.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 55 +++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 88dfc6eb0919..1fe645c9543d 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -164,6 +164,61 @@ on bridge is disabled by default. After enabling VLAN
 filter on bridge, the bridge can handle VLAN-tagged frames and forward them
 to the appropriate destinations.
 
+Multicast
+=========
+
+The Linux bridge driver has multicast support allowing it to process Internet
+Group Management Protocol (IGMP) or Multicast Listener Discovery (MLD)
+messages, and to efficiently forward multicast data packets. The bridge
+driver support IGMPv2/IGMPv3 and MLDv1/MLDv2.
+
+Multicast snooping
+------------------
+
+Multicast snooping is a networking technology that allows network switches
+to intelligently manage multicast traffic within a local area network (LAN).
+
+The switch maintains a multicast group table, which records the association
+between multicast group addresses and the ports where hosts have joined these
+groups. The group table is dynamically updated based on the IGMP/MLD messages
+received. With the multicast group information gathered through snooping, the
+switch optimizes the forwarding of multicast traffic. Instead of blindly
+broadcasting the multicast traffic to all ports, it sends the multicast
+traffic based on the destination MAC address only to ports which have joined
+the respective destination multicast group.
+
+When created, the Linux bridge devices have multicast snooping enabled by
+default. It maintains a Multicast forwarding database (MDB) which keeps track
+of port and group relationships.
+
+IGMPv3/MLDv2 ETH support
+------------------------
+
+The Linux bridge supports IGMPv3/MLDv2 ETH (Explicit Tracking of Hosts), which
+was added by `474ddb37fa3a ("net: bridge: multicast: add EHT allow/block handling")
+<https://lore.kernel.org/netdev/20210120145203.1109140-1-razor@blackwall.org/>`_
+
+The explicit tracking of hosts enables the device to keep track of each
+individual host that is joined to a particular group or channel. The main
+benefit of the explicit tracking of hosts in IGMP is to allow minimal leave
+latencies when a host leaves a multicast group or channel.
+
+The length of time between a host wanting to leave and a device stopping
+traffic forwarding is called the IGMP leave latency. A device configured
+with IGMPv3 or MLDv2 and explicit tracking can immediately stop forwarding
+traffic if the last host to request to receive traffic from the device
+indicates that it no longer wants to receive traffic. The leave latency
+is thus bound only by the packet transmission latencies in the multiaccess
+network and the processing time in the device.
+
+Other multicast features
+------------------------
+The Linux bridge also supports `per-VLAN multicast snooping
+<https://lore.kernel.org/netdev/20210719170637.435541-1-razor@blackwall.org/>`_,
+which is disabled by default but can be enabled. And `Multicast Router Discovery
+<https://lore.kernel.org/netdev/20190121062628.2710-1-linus.luessing@c0d3.blue/>`_,
+which help identify the location of multicast routers.
+
 FAQ
 ===
 
-- 
2.41.0


