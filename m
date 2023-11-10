Return-Path: <netdev+bounces-47073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFFF7E7B45
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C622818A4
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B203134DF;
	Fri, 10 Nov 2023 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0rGncLY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1E13AED
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:16:36 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1A186AD
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ccbb7f79cdso15738315ad.3
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699611395; x=1700216195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgXzwv45DXqIjIa1iLwDoPoHFYa3u1erq+7g3zqSByw=;
        b=J0rGncLY2yqxsHTRRSdpRkOproBR3RM2J5RvUByRJJer5Q+yoJpgrsz5Is2T5HdAL3
         lWvFJxeD6H3QAxnD9n8V3VEP8pRRSp+AeRxugJ4LJQhEsg77NSfNFqOasTD4zgzoexO+
         Uni+RHRtxmAlyDwsU9VEPl0FxnvZ2lNiuZ+12/wiKWtJKXum9v2n5uPgoB5XT2ZFmQOf
         FxPEHfVS8wBhcNx3Bfe+sUN7Ht72i8zCo3ywuK/RoKB4rKHcAaA5WZh60dd3Wc5Nf1XY
         xkuFBdAZmR1I4Xof85u3sdQquuaOMxAGlQVp/fMLEVpVHtUR8iQudTdZnaOO9ftJicc9
         G5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611395; x=1700216195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgXzwv45DXqIjIa1iLwDoPoHFYa3u1erq+7g3zqSByw=;
        b=BJw7w0r6QjITLfK+cBP5Dr1jq5RiGYemenD0xlx0ITXvACKZp76Sy8kFfMdPALPeUX
         kBfOd77vlYJQ2gaPdSic2PMUDnTQlvEAinF1N4DybSQFqkpEKwlA+jzF/1qYaUjcblrD
         zvjArzN0NDfnrgXLJKtcrFlHxn3IYfpXfjMEMt58aH2dZXwDN6s6mrjpFEb/wZvskyiE
         l5l+rMm+EdXU/n+SmwXhIavFjE2TecDdDf6ZN/YXwfvPM8udap0Ur9EgFL7F7jubPp0l
         /NWjZAaycpAcGSG15Kl1YoG0kBe+5vII3X3mV12lLGk++k88dzO7M5MKtx/MqrnGH5Pe
         DOQg==
X-Gm-Message-State: AOJu0YwcV0wG0PhxrjtAyXBTU40NSDznYAlrRIHW4z/GpkLAlukBwSkB
	t85t3GIgqDet0kyWX6q3w9ET3xoaBsrnVA==
X-Google-Smtp-Source: AGHT+IEipp5smOXO7sdtdo6mrg7+nefauUOuV77yHew8vZqFqiGp6b8LyplUAD5TD9GeBLkAAcwDpg==
X-Received: by 2002:a17:90a:e7c7:b0:281:1c2e:9e6a with SMTP id kb7-20020a17090ae7c700b002811c2e9e6amr3835979pjb.39.1699611394744;
        Fri, 10 Nov 2023 02:16:34 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b0027d015c365csm1244631pjb.31.2023.11.10.02.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:16:34 -0800 (PST)
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
Subject: [RFC PATCHv3 net-next 09/10] docs: bridge: add netfilter doc
Date: Fri, 10 Nov 2023 18:15:46 +0800
Message-ID: <20231110101548.1900519-10-liuhangbin@gmail.com>
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

Add netfilter part for bridge document.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 4ff1e4ab6dd5..7f63d21c9f46 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -237,6 +237,42 @@ kernel.
 
 Please see the :ref:`switchdev` document for more deatils.
 
+Netfilter
+=========
+
+The bridge netfilter module is a legacy feature that allows to filter bridged
+packets with iptables and ip6tables. Its use is discouraged. Users should
+consider using nftables for packet filtering.
+
+The older ebtables tool is more feature-limited compared to nftables, but
+just like nftables it doesn't need this module either to function.
+
+The br_netfilter module intercepts packets entering the bridge, performs
+minimal sanity tests on ipv4 and ipv6 packets and then pretends that
+these packets are being routed, not bridged. br_netfilter then calls
+the ip and ipv6 netfilter hooks from the bridge layer, i.e. ip(6)tables
+rulesets will also see these packets.
+
+br_netfilter is also the reason for the iptables *physdev* match:
+This match is the only way to reliably tell routed and bridged packets
+apart in an iptables ruleset.
+
+Note that ebtables and nftables will work fine without the br_netfilter module.
+iptables/ip6tables/arptables do not work for bridged traffic because they
+plug in the routing stack. nftables rules in ip/ip6/inet/arp families won't
+see traffic that is forwarded by a bridge either, but thats very much how it
+should be.
+
+Historically the feature set of ebtables was very limited (it still is),
+this module was added to pretend packets are routed and invoke the ipv4/ipv6
+netfilter hooks from the bridge so users had access to the more feature-rich
+iptables matching capabilities (including conntrack). nftables doesn't have
+this limitation, pretty much all features work regardless of the protocol family.
+
+So, br_netfilter is only needed if users, for some reason, need to use
+ip(6)tables to filter packets forwarded by the bridge, or NAT bridged
+traffic. For pure link layer filtering, this module isn't needed.
+
 FAQ
 ===
 
-- 
2.41.0


