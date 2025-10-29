Return-Path: <netdev+bounces-233716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9753DC17840
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0EA406FF0
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5B4230D1E;
	Wed, 29 Oct 2025 00:17:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26384212550;
	Wed, 29 Oct 2025 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697047; cv=none; b=KNeaAxIWg80PAQ8XHnXJfv9+gZo7N7DfhRJ1+dbDn6t3qdWN6gMAjE6Rddavc+yqdHqmP0swFZpj1dyl2OGA54225ylsUdICAF6A+SSXetqp0COZPmgOtvTcD3zcvAZ6sk/Aq6aC3IG+nenXRim4jgHBnLR6WXKJo5HKwst7Ug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697047; c=relaxed/simple;
	bh=9qhvYaWZnj8DF0ebDBa8YXKdXmS2sYbWsC7Me4xCd2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1hQMvUW/rW3nuueX1rhVlesz2B5k/Ea0l1jL+hAcFT2OPzXnIGGSXPYb8591gUECEFkR7S+d0sZ6rbgv2hoiHDdVJWXNGzaOJ9NpAAIWhUGhT3U3PESEeY3aU3Q2ymn4p+WwsQAVmGdSpU/EyvWqc12l1/mLc1Tevzx0aSz+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDtsQ-000000004As-0Dgc;
	Wed, 29 Oct 2025 00:17:22 +0000
Date: Wed, 29 Oct 2025 00:17:18 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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
Subject: [PATCH net-next v4 05/12] net: dsa: lantiq_gswip: define and use
 GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID
Message-ID: <7d1a0368e95da42999af379d90de5d791283d24e.1761693288.git.daniel@makrotopia.org>
References: <cover.1761693288.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761693288.git.daniel@makrotopia.org>

When adding FDB entries to the MAC bridge table on GSWIP 2.2 or later it
is needed to set an (undocumented) bit to mark the entry as valid. If this
bit isn't set for entries in the MAC bridge table, then those entries won't
be considered as valid MAC addresses.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4: keep previous behavior for GSWIP 2.1 and earlier

 drivers/net/dsa/lantiq/lantiq_gswip.h        | 1 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 56de869fc472..42000954d842 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -224,6 +224,7 @@
 #define  GSWIP_TABLE_MAC_BRIDGE_KEY3_FID	GENMASK(5, 0)	/* Filtering identifier */
 #define  GSWIP_TABLE_MAC_BRIDGE_VAL0_PORT	GENMASK(7, 4)	/* Port on learned entries */
 #define  GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC	BIT(0)		/* Static, non-aging entry */
+#define  GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID	BIT(1)		/* Valid bit */
 
 #define XRX200_GPHY_FW_ALIGN	(16 * 1024)
 
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index 0ac87eb23bb5..ff2cdb230e2c 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -1149,7 +1149,12 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
 	mac_bridge.key[2] = addr[1] | (addr[0] << 8);
 	mac_bridge.key[3] = FIELD_PREP(GSWIP_TABLE_MAC_BRIDGE_KEY3_FID, fid);
 	mac_bridge.val[0] = add ? BIT(port) : 0; /* port map */
-	mac_bridge.val[1] = GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC;
+	if (GSWIP_VERSION_GE(priv, GSWIP_VERSION_2_2_ETC))
+		mac_bridge.val[1] = add ? (GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC |
+					   GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID) : 0;
+	else
+		mac_bridge.val[1] = GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC;
+
 	mac_bridge.valid = add;
 
 	err = gswip_pce_table_entry_write(priv, &mac_bridge);
-- 
2.51.1

