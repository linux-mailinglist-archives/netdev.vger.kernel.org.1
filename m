Return-Path: <netdev+bounces-143481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DC79C2965
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 02:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE38285134
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 01:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8593C463;
	Sat,  9 Nov 2024 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Qpd52F66"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21832209B;
	Sat,  9 Nov 2024 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731117475; cv=none; b=Iv+chyp4eadIkY44g6YQD6C7fhxNeivWqT+xi+bWs+f/Npr/CjrHPmXmnbU5ZOzGHbbmV74geVsNHYpkZg3MuyH2Bq0z58/sEtAZI0aRAQvSDSiMRrRcsvC2N0ODh0aU5F64lBJSSgjB5XUFPO+Oqvx8hMag8UwpvsTg0xc9i5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731117475; c=relaxed/simple;
	bh=lyyyFQ7YgsB7WhCcFmHjZCzirTtLOdOwq99ChQguXtM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CY7t6petPwj6odshsNOoZ5QsCvA4LC7nfWm/r53Ucq6KW5NdAweaud6rIZbHS0cnj5QgsLPVnUw4PcrDGl0E0N8ioC8Ur6wNP0j1FIqA5Eld7sadzVVKJMeYNnmuWZ6IAfW9AiVBfiXRENRsrUPk9wDjojFdzoSt7d8JUUV8tpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Qpd52F66; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731117473; x=1762653473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lyyyFQ7YgsB7WhCcFmHjZCzirTtLOdOwq99ChQguXtM=;
  b=Qpd52F66wVHW8n+Wts7rJLv0kgIN6XHHMH98qY5QNu+8m5bvrvuveKg/
   Lpa1bZ6JXFz6YwWgGpGccBGY/MkqRbk2GA21BrSpwwr8HgvkvSkKHAZrO
   LQ6H3xKeeET8BWn/J321EV6jkgE8ynJnq4ZGx8sj4zAUhqbtq8ByyOOqn
   YUOMnFiJXC7+/g0E3CH0ZCdzgC2Xrb0+/jfa9G91eP6jcVXSI/Fu8d2eC
   vt1bYbETteASQTmWdaKd2piUpCGAFcA0H5Vpf9gC82EDLT1nCH/ZqDeXh
   nIM+nbsD+2hYyZ6OFqYpVQNaBTCmu3C0X1PZrclXuN00T3jCyqzTqvPFB
   Q==;
X-CSE-ConnectionGUID: pTvoazo0Qby90C19TFh6kw==
X-CSE-MsgGUID: hn8/KB7aTBuTpMIAEpPJFg==
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="33824494"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2024 18:57:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Nov 2024 18:57:06 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Nov 2024 18:57:05 -0700
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
Subject: [PATCH net-next 0/2] net: dsa: microchip: Add LAN9646 switch support
Date: Fri, 8 Nov 2024 17:57:03 -0800
Message-ID: <20241109015705.82685-1-Tristram.Ha@microchip.com>
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

This series of patches is to add LAN9646 switch support to the KSZ DSA
driver.

Tristram Ha (2):
  dt-bindings: net: dsa: microchip: Add LAN9646 switch support
  net: dsa: microchip: Add LAN9646 switch support to KSZ DSA driver

 .../bindings/net/dsa/microchip,ksz.yaml       |  1 +
 drivers/net/dsa/microchip/ksz9477.c           |  4 ++
 drivers/net/dsa/microchip/ksz9477_i2c.c       | 14 +++++-
 drivers/net/dsa/microchip/ksz_common.c        | 50 ++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h        |  1 +
 drivers/net/dsa/microchip/ksz_spi.c           |  7 +++
 include/linux/platform_data/microchip-ksz.h   |  1 +
 7 files changed, 75 insertions(+), 3 deletions(-)

-- 
2.34.1


