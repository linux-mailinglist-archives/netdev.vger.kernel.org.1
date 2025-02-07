Return-Path: <netdev+bounces-163794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A9A2B934
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B681887EEC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453216DEB3;
	Fri,  7 Feb 2025 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="a4vaGSdv"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F03149C4A;
	Fri,  7 Feb 2025 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738896254; cv=none; b=Zv7MzUn/av8Ooojhlh9Jik/Av40yqhERIfVJPWnkkAtUtfMM537z9XUfdkz7p/LU254z6dNg/CWc7Xik4W30iaHk9gAKA1s3IQ9Gk91cbdd7X5Jc+BJN9ElVoME4XSASnz/Zmg9WUsuqz4QXLbL7ur9nQEKjSU4mq+ZShW5nli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738896254; c=relaxed/simple;
	bh=VbPngllkP6TXRFEyarsd6ZxTYcW9ZU4pMNo2V2PKJ4s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T3t7q6sCfXFu+3c0SD3iSte6oWeuPB1TZgLbKeoOlz1kAYVA9fMpRoQ9WtuknMr1xUcU4KOuQikGaztKuGQJapn+opJeCnqIzUcwr4bVcxEYmporxTk43oZeLERF8hFBSpV7LTpr6EjUqcEEvBLBrsHUH0IQvApP0TQ7op6O/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=a4vaGSdv; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738896252; x=1770432252;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VbPngllkP6TXRFEyarsd6ZxTYcW9ZU4pMNo2V2PKJ4s=;
  b=a4vaGSdvJ/nXf5+sGi2xoSt0UAHTGKm17cSEERjJZL2M/qsh0Cx4vMCG
   vzBRuGO378fiQ1aW60nRwImNX0YTmbYyDkfOjgutIo8TW1muJ69rNcVeY
   RBwaZZdEXtzPIBB1LqEvG6Cy6QPuj0Z3rSoKmfkH0nK8OzUSI07Ns4d9d
   aZ4GiBzJ+ipBZdOJ4WcW+EMCj2Ome04t/wgx7wJZr23zGryfmlhnZ9dTk
   XrT9hPIRHRwweYVL3vFrxCHyIjV+wWr9obEtMI+qStKLxxBZyDDdAXVWV
   C0zEmpf/PrtBcvvZsrhUFraLVdODWQR2SnKrt+MQMC/BCo10N0CzhMc1w
   w==;
X-CSE-ConnectionGUID: jwTuGLRpSWGwq6CvVvRIVQ==
X-CSE-MsgGUID: SwF/xYKvRsitL+oqQZ5Bmw==
X-IronPort-AV: E=Sophos;i="6.13,266,1732604400"; 
   d="scan'208";a="41415873"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2025 19:44:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Feb 2025 19:43:08 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 6 Feb 2025 19:43:08 -0700
From: <Tristram.Ha@microchip.com>
To: Russell King <linux@armlinux.org.uk>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH RFC net-next v2 0/3] Add SGMII port support to KSZ9477 switch
Date: Thu, 6 Feb 2025 18:43:13 -0800
Message-ID: <20250207024316.25334-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The KSZ9477 switch DSA driver uses XPCS driver to operate its SGMII
port.  After the previous XPCS driver updates are added the XPCS patch
can be used to activate DW_XPCS_SGMII_MODE_MAC_MANUAL for KSZ9477.

The KSZ9477 driver will generate a special value for PMA device ids to
activate the new code.

This will require the previous 4 patches from Russell King about
"net: xpcs: cleanups and partial support for KSZ9477."

Tristram Ha (3):
  net: pcs: xpcs: Activate DW_XPCS_SGMII_MODE_MAC_MANUAL for KSZ9477
  net: dsa: microchip: Add SGMII port support to KSZ9477 switch
  net: dsa: microchip: Add SGMII port support to KSZ9477 switch

 drivers/net/dsa/microchip/Kconfig      |  1 +
 drivers/net/dsa/microchip/ksz9477.c    | 98 +++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h    |  4 +-
 drivers/net/dsa/microchip/ksz_common.c | 36 ++++++++--
 drivers/net/dsa/microchip/ksz_common.h | 22 +++++-
 drivers/net/pcs/pcs-xpcs.c             |  2 +
 include/linux/pcs/pcs-xpcs.h           |  1 +
 7 files changed, 157 insertions(+), 7 deletions(-)

-- 
2.34.1


