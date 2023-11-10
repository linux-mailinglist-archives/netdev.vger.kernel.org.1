Return-Path: <netdev+bounces-47069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5277E7B38
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324271C20EC2
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB8E13ADA;
	Fri, 10 Nov 2023 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVgCfzDJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3DA13FFF
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:16:22 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E559D27B3F
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:19 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28003daaaa6so1630826a91.0
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699611378; x=1700216178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h38H0mJZ2F6o36bbQbxRN2ee8icupz6sPpnBbZTOYdQ=;
        b=SVgCfzDJt7fKMBPBILaCj3e7knThCB+o6aUss5LbIbjoiHDBEn4HQ/DOUW83guUNVo
         CVVvl00GSevO4ljzlxomu0HX5l4jNNYa97Z153CT8PXJCmww4ssU/q2ArdkHp7BWC82I
         x2QmKlYqu2UXVkmu6sETbOUYdKrd5UCYQVWFuELsLQBmrD9nYyS7E6Eyl6rdMZD4wPQH
         /W5l1WVYVxrsGIVVf4K69b5beeCHUpFQuIM9RxJKXL9gR5Uf4fs/WsG7VNOwKbdi/x0Y
         zgehK/iA7exXz6VlMAhdiRZ53gowAhcHnbGwEw1/qRxOG133RJDiXMYDKA91C9GVzH4T
         CJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611378; x=1700216178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h38H0mJZ2F6o36bbQbxRN2ee8icupz6sPpnBbZTOYdQ=;
        b=GZQSvaeUZJcvSFMBk+jhBY0uE1ScMRjVdFXSkp8zQ4G5wZK+6nvTGxnrhjwbv++Oad
         jNji2rPTeGQZym1cIIQyYVOTjfdZCXHb171OmNn8t03iLlvK+nqKMR3yfKuuVhRw/0KA
         1W27qu1b2B/gG8xgcYAesNXzt20gUGarlUcJn5TOuvo4kC1psqnK1T7vHD7w3VEYCrga
         hAvkMA5O2qvipUo19YzYX93S2DVLam+yHhBkO9XXOq0aqxQGwvoxyOm4ftiDjg4leIgT
         oLPSigwsB4QuDZ61jxzNJO8wSMtgFaooJxCyoAqKgVwJkzDz/CXd/vHt5iUhuChtdS/v
         t5zQ==
X-Gm-Message-State: AOJu0YyW3pi56RDDaTxoKt1kIt50+7MzMYAV3sUIHkxom/XWClX5cCDw
	7h+2StPoPAQ6N9gwr3fnUuyBmjvbDcXLjQ==
X-Google-Smtp-Source: AGHT+IGKlc3FlfmMscR8OSxdURlYXPqqLK5iAS204zg8PHC6rQloTXp/eKxPJ9GAMoYEDO9HvZ1sqg==
X-Received: by 2002:a17:90b:4f86:b0:27d:b87b:a9d4 with SMTP id qe6-20020a17090b4f8600b0027db87ba9d4mr4218357pjb.7.1699611378541;
        Fri, 10 Nov 2023 02:16:18 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b0027d015c365csm1244631pjb.31.2023.11.10.02.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:16:17 -0800 (PST)
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
Subject: [RFC PATCHv3 net-next 05/10] docs: bridge: add STP doc
Date: Fri, 10 Nov 2023 18:15:42 +0800
Message-ID: <20231110101548.1900519-6-liuhangbin@gmail.com>
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

Add STP part for bridge document.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 85 +++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index d06c51960f45..e168f86ddd82 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -50,6 +50,91 @@ options are added.
 .. kernel-doc:: net/bridge/br_sysfs_br.c
    :doc: The sysfs bridge attrs
 
+STP
+===
+
+The STP (Spanning Tree Protocol) implementation in the Linux bridge driver
+is a critical feature that helps prevent loops and broadcast storms in
+Ethernet networks by identifying and disabling redundant links. In a Linux
+bridge context, STP is crucial for network stability and availability.
+
+STP is a Layer 2 protocol that operates at the Data Link Layer of the OSI
+model. It was originally developed as IEEE 802.1D and has since evolved into
+multiple versions, including Rapid Spanning Tree Protocol (RSTP) and
+`Multiple Spanning Tree Protocol (MSTP)
+<https://lore.kernel.org/netdev/20220316150857.2442916-1-tobias@waldekranz.com/>`_.
+
+Bridge Ports and STP States
+---------------------------
+
+In the context of STP, bridge ports can be in one of the following states:
+  * Blocking: The port is disabled for data traffic and only listens for
+    BPDUs (Bridge Protocol Data Units) from other devices to determine the
+    network topology.
+  * Listening: The port begins to participate in the STP process and listens
+    for BPDUs.
+  * Learning: The port continues to listen for BPDUs and begins to learn MAC
+    addresses from incoming frames but does not forward data frames.
+  * Forwarding: The port is fully operational and forwards both BPDUs and
+    data frames.
+  * Disabled: The port is administratively disabled and does not participate
+    in the STP process. The data frames forwarding are also disabled.
+
+Root Bridge and Convergence
+---------------------------
+
+In the context of networking and Ethernet bridging in Linux, the root bridge
+is a designated switch in a bridged network that serves as a reference point
+for the spanning tree algorithm to create a loop-free topology.
+
+Here's how the STP works and root bridge is chosen:
+  1. Bridge Priority: Each bridge running a spanning tree protocol, has a
+     configurable Bridge Priority value. The lower the value, the higher the
+     priority. By default, the Bridge Priority is set to a standard value
+     (e.g., 32768).
+  2. Bridge ID: The Bridge ID is composed of two components: Bridge Priority
+     and the MAC address of the bridge. It uniquely identifies each bridge
+     in the network. The Bridge ID is used to compare the priorities of
+     different bridges.
+  3. Bridge Election: When the network starts, all bridges initially assume
+     that they are the root bridge. They start advertising Bridge Protocol
+     Data Units (BPDU) to their neighbors, containing their Bridge ID and
+     other information.
+  4. BPDU Comparison: Bridges exchange BPDUs to determine the root bridge.
+     Each bridge examines the received BPDUs, including the Bridge Priority
+     and Bridge ID, to determine if it should adjust its own priorities.
+     The bridge with the lowest Bridge ID will become the root bridge.
+  5. Root Bridge Announcement: Once the root bridge is determined, it sends
+     BPDUs with information about the root bridge to all other bridges in the
+     network. This information is used by other bridges to calculate the
+     shortest path to the root bridge and, in doing so, create a loop-free
+     topology.
+  6. Forwarding Ports: After the root bridge is selected and the spanning tree
+     topology is established, each bridge determines which of its ports should
+     be in the forwarding state (used for data traffic) and which should be in
+     the blocking state (used to prevent loops). The root bridge's ports are
+     all in the forwarding state. while other bridges have some ports in the
+     blocking state to avoid loops.
+  7. Root Ports: After the root bridge is selected and the spanning tree
+     topology is established, each non-root bridge processes incoming
+     BPDUs and determines which of its ports provides the shortest path to the
+     root bridge based on the information in the received BPDUs. This port is
+     designated as the root port. And it is in the Forwarding state, allowing
+     it to actively forward network traffic.
+  8. Designated ports: A designated port is the port through which the non-root
+     bridge will forward traffic towards the designated segment. Designated ports
+     are placed in the Forwarding state. All other ports on the non-root
+     bridge that are not designated for specific segments are placed in the
+     Blocking state to prevent network loops.
+
+STP ensures network convergence by calculating the shortest path and disabling
+redundant links. When network topology changes occur (e.g., a link failure),
+STP recalculates the network topology to restore connectivity while avoiding loops.
+
+Proper configuration of STP parameters, such as the bridge priority, can
+influence which bridge becomes the Root Bridge. Careful configuration can
+optimize network performance and path selection.
+
 FAQ
 ===
 
-- 
2.41.0


