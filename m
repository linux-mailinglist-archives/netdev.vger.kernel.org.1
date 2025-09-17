Return-Path: <netdev+bounces-223992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F113CB7CCBF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9A23B5AB1
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00783431FA;
	Wed, 17 Sep 2025 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="w2d+UD3e"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E62DF712;
	Wed, 17 Sep 2025 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109841; cv=none; b=C2GCOBfWV3dYcalzI0L0yOwR06efb/6G/JOmoRNy6+/vPi+jOlrnVORZT3soT232N6OH5qtIFdK3pFDWN+taOH6FOSEX+IGerUnf6UfgkIEHuVhjLROe0N734wri6LJM5gE7yp2uTpIHTc9BhRKJu9g6p66q4R8nS3ejw/434cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109841; c=relaxed/simple;
	bh=BmWJ8dm6tF3d7RA48fjDGm1mzg7DGhaw55N9cwl8YL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=o7+ufEGfZu1l9pgeFe9ctf20+iOIDGCTbio0ld/8+/e3UYWtqZ8tExyimu0T45/mX4yoAJTYcvH/kYmgRtAoACcOVNJkX6cSVmR1w20V03VQRxSEQHVASi6E/cthukYu+B0ycXzZNIlDAvHhhIwDOoEltKSoCetR5+/OuTtN/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=w2d+UD3e; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758109840; x=1789645840;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=BmWJ8dm6tF3d7RA48fjDGm1mzg7DGhaw55N9cwl8YL8=;
  b=w2d+UD3egGEyXlAYgYf6eVUJhXWxUDR1ncwsxlWdnAp93fsxQ35iq1E+
   JZxEjPROr1YPikVOtGAvSKWt3nSryI4iBVkkNB7HgA9vIHSyldMgOW5ov
   SPhYtE0AkstilIko22tlSBTpPEbXw5dkG6ONhwa97bharfObHPsYn/R8W
   esEXl+L6TuIYkw42YMDg657ieU5O1w1a6YCIAyU9feJr5hFe2ZMouTKPg
   wN3PqviwSbVzjb98DShTbwWE7AkuCni8u5Oq720gy5IQHEbHS9eT+oEvm
   JoZFTtCBvHTTH3h0G+1pYIrPSaG6eDb/FBX5qMxNKtFGYOf6cbEAyBRBg
   w==;
X-CSE-ConnectionGUID: xPqELcc0QeOcVfzESf+PTg==
X-CSE-MsgGUID: lC9pw1FtSr+km1Jn39f1Nw==
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="47157749"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 04:50:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 17 Sep 2025 04:50:23 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 17 Sep 2025 04:50:20 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 17 Sep 2025 13:49:43 +0200
Subject: [PATCH net-next] net: sparx5/lan969x: Add support for ethtool
 pause parameters
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250917-802-3x-pause-v1-1-3d1565a68a96@microchip.com>
X-B4-Tracking: v=1; b=H4sIAFagymgC/x2MQQ6DMAwEv4J8rqXEUVToV6oeDJjiQ12UQBUJ8
 fcGjqPdmR2yJJUMj2aHJD/N+rUK/tbAMLO9BXWsDOQous7fsXWEoeDCWxb0HY1TbCOFEKAqS5J
 Jy5V7gsmKJmWFV116rvc+sQ3zmfuwGhzHHyPOYGR/AAAA
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Russell King
	<linux@armlinux.org.uk>
CC: <jacob.e.keller@intel.com>, Robert Marko <robert.marko@sartura.hr>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

Implement get_pauseparam() and set_pauseparam() ethtool operations for
Sparx5 ports.  This allows users to query and configure IEEE 802.3x
pause frame settings via:

ethtool -a ethX
ethtool -A ethX rx on|off tx on|off autoneg on|off

The driver delegates pause parameter handling to phylink through
phylink_ethtool_get_pauseparam() and phylink_ethtool_set_pauseparam().

The underlying configuration of pause frame generation and reception is
already implemented in the driver; this patch only wires it up to the
standard ethtool interface, making the feature accessible to userspace.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index 832f4ae57c83..049541eeaae0 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -1212,6 +1212,22 @@ static int sparx5_get_ts_info(struct net_device *dev,
 	return 0;
 }
 
+static void sparx5_get_pauseparam(struct net_device *dev,
+				  struct ethtool_pauseparam *pause)
+{
+	struct sparx5_port *port = netdev_priv(dev);
+
+	phylink_ethtool_get_pauseparam(port->phylink, pause);
+}
+
+static int sparx5_set_pauseparam(struct net_device *dev,
+				 struct ethtool_pauseparam *pause)
+{
+	struct sparx5_port *port = netdev_priv(dev);
+
+	return phylink_ethtool_set_pauseparam(port->phylink, pause);
+}
+
 const struct ethtool_ops sparx5_ethtool_ops = {
 	.get_sset_count         = sparx5_get_sset_count,
 	.get_strings            = sparx5_get_sset_strings,
@@ -1224,6 +1240,8 @@ const struct ethtool_ops sparx5_ethtool_ops = {
 	.get_eth_ctrl_stats     = sparx5_get_eth_mac_ctrl_stats,
 	.get_rmon_stats         = sparx5_get_eth_rmon_stats,
 	.get_ts_info            = sparx5_get_ts_info,
+	.get_pauseparam         = sparx5_get_pauseparam,
+	.set_pauseparam         = sparx5_set_pauseparam,
 };
 
 int sparx_stats_init(struct sparx5 *sparx5)

---
base-commit: 5e87fdc37f8dc619549d49ba5c951b369ce7c136
change-id: 20250917-802-3x-pause-192df5852333

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


