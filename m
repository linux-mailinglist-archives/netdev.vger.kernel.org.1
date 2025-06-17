Return-Path: <netdev+bounces-198787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672E5ADDD28
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 22:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C624A02A3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 20:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BBD25B69B;
	Tue, 17 Jun 2025 20:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpqcZRJ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70B2EFD89
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 20:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750191763; cv=none; b=C6RSJSb8qyLfV+Uj9VSU21P6WA1sm1wm35nrbUpLzhvJoJmht+sIaDI3+ReOAKp8BtgsRRW8wfZsEIQ9wKn47V2wNJGWdsOZRr3wgCZWupFwmtGoM+Asy+DDWZ3KmqaKv6q5gYzIO6GaNF0f8FAUtgj+QPG5NqJJlPAXy6Qd0lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750191763; c=relaxed/simple;
	bh=UiBjGlViAAV76dFRHYMW6Y7W0t0eHXto97lGr/l9lyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgWJ19JAHPDnlh/aWPwf254OjUnt4Mx6BzJpW2e7M3DWzEeWhy+BpA7NWX1xooLohPPMr95wAafFhNLd4/tP7MJHTQmt+dU81+SUyUIQP8db8+aZuLxitiIZh2dW1/Cl56mV4C8AuecojjObQugH03nWmhU54lMIo1qppI9ssFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpqcZRJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C53BC4CEED;
	Tue, 17 Jun 2025 20:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750191763;
	bh=UiBjGlViAAV76dFRHYMW6Y7W0t0eHXto97lGr/l9lyM=;
	h=From:To:Cc:Subject:Date:From;
	b=JpqcZRJ5Ew34biYuP6DmX5hA+5uy2dHsn4Zhpwh3MVB3YJ7pNxpvHxGADc7+q4/g/
	 ZDN4BkIuTaS52F+RakjBoGYyIUVySb9z/raULgAKRSmevFKQXexdBL9kxr6TgkptHB
	 KV82y/q7Y87Y5+sp7rp1P6uizTUQhFlicxU21LDzhPpXlnvgtH5iEDJvKvhj44bPXR
	 4LQVMkV7595VxV9WVZPRBNp8rYiLHngHy42Ssz/H0KmJ5BlylbMMVQ9HqLB5CNGE2c
	 07c+tywgjWoPdMnjAy6eDcWyLcKQ29f79Txe2RaXh4zHzwFSzMglDPtIUn4MeNFiUV
	 G0Vmdz2RMVwHg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	donald.hunter@gmail.com,
	kory.maincent@bootlin.com,
	sdf@fomichev.me
Subject: [PATCH net] net: ethtool: remove duplicate defines for family info
Date: Tue, 17 Jun 2025 13:22:40 -0700
Message-ID: <20250617202240.811179-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit under fixes switched to uAPI generation from the YAML
spec. A number of custom defines were left behind, mostly
for commands very hard to express in YAML spec.

Among what was left behind was the name and version of
the generic netlink family. Problem is that the codegen
always outputs those values so we ended up with a duplicated,
differently named set of defines.

Provide naming info in YAML and remove the incorrect defines.

Fixes: 8d0580c6ebdd ("ethtool: regenerate uapi header from the spec")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: donald.hunter@gmail.com
CC: kory.maincent@bootlin.com
CC: sdf@fomichev.me
---
 Documentation/netlink/specs/ethtool.yaml       | 3 +++
 include/uapi/linux/ethtool_netlink.h           | 4 ----
 include/uapi/linux/ethtool_netlink_generated.h | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 9f98715a6512..72a076b0e1b5 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -7,6 +7,9 @@ protocol: genetlink-legacy
 doc: Partial family for Ethtool Netlink.
 uapi-header: linux/ethtool_netlink_generated.h
 
+c-family-name: ethtool-genl-name
+c-version-name: ethtool-genl-version
+
 definitions:
   -
     name: udp-tunnel-type
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 9ff72cfb2e98..09a75bdb6560 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -208,10 +208,6 @@ enum {
 	ETHTOOL_A_STATS_PHY_MAX = (__ETHTOOL_A_STATS_PHY_CNT - 1)
 };
 
-/* generic netlink info */
-#define ETHTOOL_GENL_NAME "ethtool"
-#define ETHTOOL_GENL_VERSION 1
-
 #define ETHTOOL_MCGRP_MONITOR_NAME "monitor"
 
 #endif /* _UAPI_LINUX_ETHTOOL_NETLINK_H_ */
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 9a02f579de22..aa8ab5227c1e 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -6,8 +6,8 @@
 #ifndef _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H
 #define _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H
 
-#define ETHTOOL_FAMILY_NAME	"ethtool"
-#define ETHTOOL_FAMILY_VERSION	1
+#define ETHTOOL_GENL_NAME	"ethtool"
+#define ETHTOOL_GENL_VERSION	1
 
 enum {
 	ETHTOOL_UDP_TUNNEL_TYPE_VXLAN,
-- 
2.49.0


