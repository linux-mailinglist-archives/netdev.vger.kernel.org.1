Return-Path: <netdev+bounces-47070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 261207E7B3A
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DB61C20A8F
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECE113FE5;
	Fri, 10 Nov 2023 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUPT7zA7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F11134DF
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:16:24 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879BC27B3D
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:23 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc131e52f1so22968255ad.0
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699611382; x=1700216182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YUXjSQL75/qo4K29KturJ12RMBsS82DTP6+14IpWzw=;
        b=MUPT7zA7qVCV67TyVw37INpYHeqON0j0BULhH09OwdlQ7j8N+2ONU7BTx5x+OB0Q+/
         tdWX80r9s24gOfRRxKSdVM3364LF4O0+145wthCEKD4adlEd93WBVu83oGjRlMU/o/zf
         V1hz8vvvR13gg3il7EvARSutIrHToFd9D+Gy6ebyDMe9Wk2+rlEj5/wBJILSGMeUB6xQ
         vEGq0SZURH6bcvbPB8O7OHx7I/fMM1ej0KrGgszGkQRBnGv/a91NCO303rNe1wpXdhpx
         UZZZuQ/+rxAUIViY/Sxs1FOIcjEeuscjWveytyuLar6wH6I4vz5J/rLL9wDbvUpdqKS8
         nivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611382; x=1700216182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YUXjSQL75/qo4K29KturJ12RMBsS82DTP6+14IpWzw=;
        b=ZF2CG2XfGaAAw3X484lDARyta/F0iQt6P+dYVZaiNQcoNfRE8sF2EoJmTPUuicvJn/
         qeVWjTAGZm/OFRyhJFGzHzdtjHt+e9KLV+jIj31QYoWweSy9UyxFNB+o5e0p8KOyidKJ
         qEL+7NaM9C6e1ZKJHMfUQD8CWa/L33gBOJfTo9uPt1LiTkPEXGrL2md4M3Th3XZBWe2D
         IvgGNihOmfabDJ1tIaqX5sPCwhEy1vni41cnX2pnk3MX6eiW0yZ4fnMiLG/xmOod27vD
         FLRlO4JqanuVG2uWI8f1/IclAJn1JiEbROdv+XZqkYsGjoVftxTvzN6iWwIumfma9WNn
         7leQ==
X-Gm-Message-State: AOJu0YzI/znqVz3mImGVzN0YOx7tfZTILQUCn/c45q7ccISZ6YBleScK
	4/C+Ped+ggr5Io/oWtZuyA5NqNvEk8qTiw==
X-Google-Smtp-Source: AGHT+IEa/uzDJqMt28cr8GvooC8jrxkY3kXGLz1lSAJdmSWDo4OqdXFidMZ4d6xyxc8THB/EiW0WNA==
X-Received: by 2002:a17:90a:7c06:b0:283:7e0:2e51 with SMTP id v6-20020a17090a7c0600b0028307e02e51mr2793029pjf.0.1699611382592;
        Fri, 10 Nov 2023 02:16:22 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b0027d015c365csm1244631pjb.31.2023.11.10.02.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:16:22 -0800 (PST)
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
Subject: [RFC PATCHv3 net-next 06/10] docs: bridge: add VLAN doc
Date: Fri, 10 Nov 2023 18:15:43 +0800
Message-ID: <20231110101548.1900519-7-liuhangbin@gmail.com>
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

Add VLAN part for bridge document.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index e168f86ddd82..88dfc6eb0919 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -135,6 +135,35 @@ Proper configuration of STP parameters, such as the bridge priority, can
 influence which bridge becomes the Root Bridge. Careful configuration can
 optimize network performance and path selection.
 
+VLAN
+====
+
+A LAN (Local Area Network) is a network that covers a small geographic area,
+typically within a single building or a campus. LANs are used to connect
+computers, servers, printers, and other networked devices within a localized
+area. LANs can be wired (using Ethernet cables) or wireless (using Wi-Fi).
+
+A VLAN (Virtual Local Area Network) is a logical segmentation of a physical
+network into multiple isolated broadcast domains. VLANs are used to divide
+a single physical LAN into multiple virtual LANs, allowing different groups of
+devices to communicate as if they were on separate physical networks.
+
+Typically there are two VLAN implementations, IEEE 802.1Q and IEEE 802.1ad
+(also known as QinQ). IEEE 802.1Q is a standard for VLAN tagging in Ethernet
+networks. It allows network administrators to create logical VLANs on a
+physical network and tag Ethernet frames with VLAN information, which is
+called *VLAN-tagged frames*. IEEE 802.1ad, commonly known as QinQ or Double
+VLAN, is an extension of the IEEE 802.1Q standard. QinQ allows for the
+stacking of multiple VLAN tags within a single Ethernet frame. The Linux
+bridge supports both the IEEE 802.1Q and `802.1AD
+<https://lore.kernel.org/netdev/1402401565-15423-1-git-send-email-makita.toshiaki@lab.ntt.co.jp/>`_
+protocol for VLAN tagging.
+
+The `VLAN filtering <https://lore.kernel.org/netdev/1360792820-14116-1-git-send-email-vyasevic@redhat.com/>`_
+on bridge is disabled by default. After enabling VLAN
+filter on bridge, the bridge can handle VLAN-tagged frames and forward them
+to the appropriate destinations.
+
 FAQ
 ===
 
-- 
2.41.0


