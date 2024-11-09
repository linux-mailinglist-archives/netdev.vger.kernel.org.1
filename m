Return-Path: <netdev+bounces-143478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4149D9C295B
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 02:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729F01C21876
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 01:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C7D286A8;
	Sat,  9 Nov 2024 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d5xQJdrK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961EDC8FF;
	Sat,  9 Nov 2024 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731117417; cv=none; b=tsE9R2+h/wKDq5BN789Zi3cD72LveDJNlWkrMz+Fu9xgQ23cYsCf6keBRzW90SXRHWj5DLfvFPWKohVx4ax4kiDERj5GSfiA0/axxUH2mJjSW0yxnnwal6B25B9g/a2RmtkU6KUzr9LutJPueizkFgqXdsX8sdysCsjqeyb9zVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731117417; c=relaxed/simple;
	bh=AWPqbOO0+t8R3A7scf6Z0vPzZdC3RCpRKm8ZnKPpomg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HbuQiolwQYEkMv7E5hxG2FAzhhEkQR1lzzUqI2dAZL0f7/1lfYqQdCfcD/G3/2Nf7v5BTmWbQQ8BU2PZPMQuzkkTIXWTf0VVgHHUOtga85WvMC48euP8C+hvZZzIYP5oS1f4K+fs0ucPZOnVnkTYRXDLIe4KQNJa3BWZfCyoHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d5xQJdrK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731117415; x=1762653415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AWPqbOO0+t8R3A7scf6Z0vPzZdC3RCpRKm8ZnKPpomg=;
  b=d5xQJdrKSY6H/D+RJOB4Zv89kl9OHke48ms54cbjqtpR1rpCm6f4/Hng
   eA+8gnkm2nurU7oDLiGbrc1XEuLmZF9kqA1hvd7mlHYDfdKuwF2iR9yhF
   hSQApsPWRJnXwjFCz8SMnLVtdBR27SvzYXKtCorbv9HD0j5s1dR3bZD/8
   fq60t0HZ8bFLay6oUjlD7rWQ/8YSkh618fLvQTJ6zr8TyDGnRT0mmX/vU
   CvhFgPvTDeeqHUtiqKoMA9htMTJn6DrJyBuJKKhq7+DbESxQHYNBfA97A
   X/7Ipp7kSUy1/oA2fKEPmqvuaCKT/mTSdxTyjHFyGM2D9x8Jy31zO9Hmf
   g==;
X-CSE-ConnectionGUID: 5vaTV7aQT/yecz//2xjQUw==
X-CSE-MsgGUID: ZdOyrHF+Tbmo3CFPNLhYeA==
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="37590946"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2024 18:56:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Nov 2024 18:56:33 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Nov 2024 18:56:33 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next 0/2] net: dsa: microchip: Add SGMII port support to KSZ9477 switch
Date: Fri, 8 Nov 2024 17:56:31 -0800
Message-ID: <20241109015633.82638-1-Tristram.Ha@microchip.com>
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

This series of patches is to add SGMII port support to KSZ9477 switch.

This one replaces the one submitted before with added PCS driver to use
with SFP cage.

Tristram Ha (2):
  dt-bindings: net: dsa: microchip: Add SGMII port support to KSZ9477
    switch
  net: dsa: microchip: Add SGMII port support to KSZ9477 switch

 .../bindings/net/dsa/microchip,ksz.yaml       |   7 +
 drivers/net/dsa/microchip/ksz9477.c           | 450 +++++++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h           |   7 +-
 drivers/net/dsa/microchip/ksz9477_reg.h       |   6 +
 drivers/net/dsa/microchip/ksz_common.c        |  94 +++-
 drivers/net/dsa/microchip/ksz_common.h        |  21 +
 6 files changed, 578 insertions(+), 7 deletions(-)

-- 
2.34.1


