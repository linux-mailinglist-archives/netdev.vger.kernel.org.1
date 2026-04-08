Return-Path: <netdev+bounces-276554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOSuBgZW1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:20:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6EA3BCBCF
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A37C301C312
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006132AAD6;
	Wed,  8 Apr 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OCtiDWmP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CFB303A32;
	Wed,  8 Apr 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654353; cv=none; b=o9oowxDKbekUzMXSZThR12XO0dx41AHVrMIMKyfPt4wUMMj0Y/QFPLDOR7OG4lgzA0Gw9sRpGiCLTE5knTfEDxZnaFl0gOT2c9ni8kcbfIz/8utZZnryNMliYruwjiz12XhjShS2ZcPQw0yxjFUNtk8u0GpWV+Q6WHXH6I85Q+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654353; c=relaxed/simple;
	bh=0xJPrIYk+dEMlDe20IZ8luaPU6s+W98NxVlVd1v92SI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKsQmdxhZJrw4hlTN75lBNfR+pYjg9/NwLW4mbnWa7MbbGZYU5SeEHnPFCaMyMYtoOpE1cUCdeh6hL0Hx7MI7yNbrlhwgW0feryETeWo9S3XTq7ZW2C65XcE1FR3tN8RsoyhBJ/BCPTs/BjxlC9O1owkHBsFhUeZaQLevRtkeZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OCtiDWmP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775654352; x=1807190352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0xJPrIYk+dEMlDe20IZ8luaPU6s+W98NxVlVd1v92SI=;
  b=OCtiDWmPFpdmOujN816xSo3M+5gSiOSDI6dYLaJdcVoNgR/h7vbLnfj9
   O34+8KhIramD5i1WsWYhqXbDjSj+sPERY2kAM9DWRJNcxKC3bcIO9ejc1
   yQ3Fd3D4JcdqYoSkaMTSsqHbUui8qn9jyOt5i6WeBI/rBY2r02lDxNWhR
   188Q7mIUsEyLIAxDIq+vfestCatPElZiueMcj5aJBt4LtOssb5BH6unCS
   Wxcw04TuZXjKYuxvgyVa6ZNCL7jlE6oRn7ITbOvsb3pLtXv+BJTmJB+EQ
   GBlbfy5Ru1kUJATkk11vhUhiOMYjjIq1S9DnrgKVYasEhwb4jBL+9j5mf
   w==;
X-CSE-ConnectionGUID: F85s2Dh/QnqfFBKL8yl1pw==
X-CSE-MsgGUID: wg0Xm70fS9mad/dfT0Gckw==
X-IronPort-AV: E=Sophos;i="6.23,167,1770620400"; 
   d="scan'208";a="223083078"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:19:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 8 Apr 2026 06:18:59 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 8 Apr 2026 06:18:59 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: <MameMaria.Mbaye@microchip.com>, Charles Perry
	<charles.perry@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 3/3] net: phy: add a PHY write barrier when disabling interrupts
Date: Wed, 8 Apr 2026 06:18:16 -0700
Message-ID: <20260408131821.1145334-4-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260408131821.1145334-1-charles.perry@microchip.com>
References: <20260408131821.1145334-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276554-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Queue-Id: 1F6EA3BCBCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MDIO bus controllers are not required to wait for write transactions to
complete before returning as synchronization is often achieved by polling
status bits.

This can cause issues when disabling interrupts since an interrupt could
fire before the interrupt handler is unregistered and there's no status
bit to poll.

Add a phy_write_barrier() function and use it in phy_disable_interrupts()
to fix this issue. The write barrier just reads an MII register and
discards the value, which is enough to guarantee that previous writes have
completed.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---

Notes:
    Changes in v5:
      - Support the case where the MDIO controller only supports C45
    	(Russell, Andrew)
      - Make the return type of phy_write_barrier() void
    
    Changes in v4:
      - Add this patch (Russell, Andrew)

 drivers/net/phy/phy.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 13dd1691886d..b21ff204c0dc 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1368,14 +1368,37 @@ void phy_error(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_error);
 
+/**
+ * phy_write_barrier - ensure the last write completed for this PHY device
+ * @phydev: target phy_device struct
+ *
+ * MDIO bus controllers are not required to wait for write transactions to
+ * complete before returning. Calling this function ensures that the previous
+ * write has completed.
+ */
+static void phy_write_barrier(struct phy_device *phydev)
+{
+	if (mdiobus_read(phydev->mdio.bus, phydev->mdio.addr, MII_PHYSID1) ==
+	    -EOPNOTSUPP)
+		mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
+				 MDIO_MMD_PMAPMD, MII_PHYSID1);
+}
+
 /**
  * phy_disable_interrupts - Disable the PHY interrupts from the PHY side
  * @phydev: target phy_device struct
  */
 int phy_disable_interrupts(struct phy_device *phydev)
 {
+	int err;
+
 	/* Disable PHY interrupts */
-	return phy_config_interrupt(phydev, PHY_INTERRUPT_DISABLED);
+	err = phy_config_interrupt(phydev, PHY_INTERRUPT_DISABLED);
+	if (err)
+		return err;
+
+	phy_write_barrier(phydev);
+	return 0;
 }
 
 /**
-- 
2.47.3


