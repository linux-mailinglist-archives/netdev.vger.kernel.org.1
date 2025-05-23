Return-Path: <netdev+bounces-192978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D32AC1EC9
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0D83BEACE
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6032266B77;
	Fri, 23 May 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="a89jG/QS"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B623F27B;
	Fri, 23 May 2025 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747989335; cv=none; b=r4pmshwfBpclYCFHOX9oIjiRn9d8b+sbysOddimupXv/dnCXfqubwycmlvVr5szCBjT6GLHfgqoYRvg+cSys6CIZy5UHPRwznqVVnqIyvN8Mqn1lMjLAIFKNR4jnnCtjf7PHYqx1Nc2fLNyobo6rXEqVHSWdyhzVacM0sLzm8TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747989335; c=relaxed/simple;
	bh=iEx80n8fgG/89TBgoMUIAJYHS9tPKdASg/vwQc+vbVg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ud0eJzOSRhM5jfjvCIDb28Xrfh5n1r5mSkFWtT2PlR6wZRr5PSbe6roRQMu9dwzHVF15P9eDvQBRnNPlkj+thv8ds+aZhAsC91KFrXA5idAMRMqQ7kjEweyF3uvDBviUm4PNI9599rN4HGm9URfIaY20/bPoLQzkkqYCdQvDxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=a89jG/QS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747989335; x=1779525335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iEx80n8fgG/89TBgoMUIAJYHS9tPKdASg/vwQc+vbVg=;
  b=a89jG/QSoR8iNavr92Q0uJKr2LxOlTKYsfjppzX3CM6WHYNURqGEydJZ
   0cPhhsz3K7tiKtbf9ALezvkYZp33DPEfTCi7aLzbEjkyX+bled1PUZiDY
   mgGAhuf465vUELrbUsnzpc0jwDXe9+Ewj90+yO8ka6JNZG3PTaMw7aqcG
   gfpaZ5uWxq4FSaOwTPENLvXD/Hc7O1Kuo7itP4meu9EdVZp60zKLyjeRD
   lNZq6oGVZyJX+XuPlo6ug+UWw7BUcADDRtnO2iH6kUHt/GFD89j1zLQMS
   dBKGWvNb5HB/oBE0IRMTwNA+QgiohAlUPBhx1hYyeIzXAb1Vt24j8nSUm
   Q==;
X-CSE-ConnectionGUID: rV4OX+4HSQ+r696EVeXuxw==
X-CSE-MsgGUID: jK41x6mXQJmu38my/w8XNA==
X-IronPort-AV: E=Sophos;i="6.15,308,1739862000"; 
   d="scan'208";a="41989874"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2025 01:34:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 23 May 2025 01:34:28 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 23 May 2025 01:34:25 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <kory.maincent@bootlin.com>,
	<wintera@linux.ibm.com>, <viro@zeniv.linux.org.uk>,
	<quentin.schulz@bootlin.com>, <atenart@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] net: phy: mscc: Stop clearing the the UDPv4 checksum for L2 frames
Date: Fri, 23 May 2025 10:27:16 +0200
Message-ID: <20250523082716.2935895-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

We have noticed that when PHY timestamping is enabled, L2 frames seems
to be modified by changing two 2 bytes with a value of 0. The place were
these 2 bytes seems to be random(or I couldn't find a pattern).  In most
of the cases the userspace can ignore these frames but if for example
those 2 bytes are in the correction field there is nothing to do.  This
seems to happen when configuring the HW for IPv4 even that the flow is
not enabled.
These 2 bytes correspond to the UDPv4 checksum and once we don't enable
clearing the checksum when using L2 frames then the frame doesn't seem
to be changed anymore.

Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/mscc/mscc_ptp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 6f96f2679f0bf..6b800081eed52 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -946,7 +946,9 @@ static int vsc85xx_ip1_conf(struct phy_device *phydev, enum ts_blk blk,
 	/* UDP checksum offset in IPv4 packet
 	 * according to: https://tools.ietf.org/html/rfc768
 	 */
-	val |= IP1_NXT_PROT_UDP_CHKSUM_OFF(26) | IP1_NXT_PROT_UDP_CHKSUM_CLEAR;
+	val |= IP1_NXT_PROT_UDP_CHKSUM_OFF(26);
+	if (enable)
+		val |= IP1_NXT_PROT_UDP_CHKSUM_CLEAR;
 	vsc85xx_ts_write_csr(phydev, blk, MSCC_ANA_IP1_NXT_PROT_UDP_CHKSUM,
 			     val);
 
-- 
2.34.1


