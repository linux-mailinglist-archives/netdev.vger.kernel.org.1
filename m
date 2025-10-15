Return-Path: <netdev+bounces-229806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C1DBE0F01
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A7718866AD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A34307AEB;
	Wed, 15 Oct 2025 22:32:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0B19F48D;
	Wed, 15 Oct 2025 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567545; cv=none; b=WVfXZj+l8BPFVx8wa9560Z1NhiWpgpDBDH6LTPeKZxKNYTLcobGS0IGwp6L7oQKXobjzGuA3J81EV8ATOcbH4uB40WrY+Z6s4m8ZEEeI7RUOKreS3MOowYeajBY1TevMjUHbrCJkiQ1aKZCrx+l5D0xFxjMgM5Xjls1wN9uItS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567545; c=relaxed/simple;
	bh=U9blwsk4OVt9UrRakM3tsBcbBMnypAVW5Y1XkJY1u5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHzA5/xYfWJ/p1hD4BElxf3qnd3/Rs6ALAnRqSlPkGBEda+dV3+Ky4t7vIoaBqAi4I98fmV4bOmVuDby8Qu0sNV+oFNJaX2T8A9sqg8PAX/heqWrRrmsfIud9Py3LxrgRI/cCxiqWlgIZgvEV1M8aaKizrRW8vjeAIBnfkzD9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9A2c-000000006Ub-3iD1;
	Wed, 15 Oct 2025 22:32:18 +0000
Date: Wed, 15 Oct 2025 23:32:15 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next 02/11] net: dsa: lantiq_gswip: define VLAN ID 0
 constant
Message-ID: <e8862239d0bb727723cf60947d2262473b46c96d.1760566491.git.daniel@makrotopia.org>
References: <cover.1760566491.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760566491.git.daniel@makrotopia.org>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This patch adds an explicit definition for VID 0 to the Lantiq GSWIP DSA
driver, clarifying its special meaning.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 12 +++++++-----
 drivers/net/dsa/lantiq/lantiq_gswip.h |  2 ++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 91755a5972fa..9526317443a1 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -432,7 +432,7 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
 
 	vlan_active.index = port + 1;
 	vlan_active.table = GSWIP_TABLE_ACTIVE_VLAN;
-	vlan_active.key[0] = 0; /* vid */
+	vlan_active.key[0] = GSWIP_VLAN_UNAWARE_PVID;
 	vlan_active.val[0] = port + 1 /* fid */;
 	vlan_active.valid = add;
 	err = gswip_pce_table_entry_write(priv, &vlan_active);
@@ -446,7 +446,7 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
 
 	vlan_mapping.index = port + 1;
 	vlan_mapping.table = GSWIP_TABLE_VLAN_MAPPING;
-	vlan_mapping.val[0] = 0 /* vid */;
+	vlan_mapping.val[0] = GSWIP_VLAN_UNAWARE_PVID;
 	vlan_mapping.val[1] = BIT(port) | dsa_cpu_ports(priv->ds);
 	vlan_mapping.val[2] = 0;
 	err = gswip_pce_table_entry_write(priv, &vlan_mapping);
@@ -772,7 +772,8 @@ static int gswip_vlan_add_unaware(struct gswip_priv *priv,
 	 * entry in a free slot and prepare the VLAN mapping table entry.
 	 */
 	if (idx == -1) {
-		idx = gswip_vlan_active_create(priv, bridge, -1, 0);
+		idx = gswip_vlan_active_create(priv, bridge, -1,
+					       GSWIP_VLAN_UNAWARE_PVID);
 		if (idx < 0)
 			return idx;
 		active_vlan_created = true;
@@ -780,7 +781,7 @@ static int gswip_vlan_add_unaware(struct gswip_priv *priv,
 		vlan_mapping.index = idx;
 		vlan_mapping.table = GSWIP_TABLE_VLAN_MAPPING;
 		/* VLAN ID byte, maps to the VLAN ID of vlan active table */
-		vlan_mapping.val[0] = 0;
+		vlan_mapping.val[0] = GSWIP_VLAN_UNAWARE_PVID;
 	} else {
 		/* Read the existing VLAN mapping entry from the switch */
 		vlan_mapping.index = idx;
@@ -977,7 +978,8 @@ static void gswip_port_bridge_leave(struct dsa_switch *ds, int port,
 	 * specific bridges. No bridge is configured here.
 	 */
 	if (!br_vlan_enabled(br))
-		gswip_vlan_remove(priv, br, port, 0, true, false);
+		gswip_vlan_remove(priv, br, port, GSWIP_VLAN_UNAWARE_PVID, true,
+				  false);
 }
 
 static int gswip_port_vlan_prepare(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 2df9c8e8cfd0..6aae1ff2f130 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -222,6 +222,8 @@
  */
 #define GSWIP_MAX_PACKET_LENGTH	2400
 
+#define GSWIP_VLAN_UNAWARE_PVID	0
+
 struct gswip_pce_microcode {
 	u16 val_3;
 	u16 val_2;
-- 
2.51.0

