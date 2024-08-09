Return-Path: <netdev+bounces-117043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19F94C7B7
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 02:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1355C1F25682
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 00:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9620B2907;
	Fri,  9 Aug 2024 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hBh9GhVx"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C42581;
	Fri,  9 Aug 2024 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164225; cv=none; b=r73HTHSlz3SjbFZwl1VpDWGKDz9MMpSp83fv3VxnqgejFdnbk+DB3J1Ev5kY2NlacJTx0xlnIDnw/jAzBz5WTBLhRIXThkNhu4irYOwQwh/rI+kVAmEMLfAiyERg2VvuYfjN9PLICumVRC6r5eJeunAIJ3Pq3Kl9AM9KNCZLP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164225; c=relaxed/simple;
	bh=QBUgzL2iucKl1TnT6FfATwz95F4EDBQ7+96Hm7lyJUw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VlrsinV2N+PUbIM48e5/Z8nDeMWjG736Vfyhv5aVrBi5gOzi/1VukMS84weUuFcuAZyE7D6lnhYkaoytBOGDGUoxYGYgZurpRYlF9pf6r4ePOSuQ9LvuZWq5/pUq/ecXmmqlDXQosnJUWN3tb1rT2x8ug6rMeczeR3BJI2BtOYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hBh9GhVx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723164223; x=1754700223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QBUgzL2iucKl1TnT6FfATwz95F4EDBQ7+96Hm7lyJUw=;
  b=hBh9GhVxKU9L03RJD3R5HioOanoj4k/hMNQRUi2eb7CHjj7KhuWzRUsg
   Vhr7QYh81cNEIMRZ32EtNyVEk6yUpmBMhrBnRHSXzUkcvPcLdnY7t0kf0
   /8lBmxWNSeo3wOa9rOKg4jeSWij6pT362K1id43Pmuo0kVoLRbz4ZaBFk
   B0f/cFYixxc1m+J2gSy8AEab50W5+/YGVXIsl8Mlvqze4wYdD2Rdjddc0
   8daLYu2ClpL/fjodujQGWQduir4DFBRcod3zXMpCuCXSFONLa7sSiBNXG
   fOhlumJQcHYQa8lnXomdquHrRZN4ixW1BVgwxk5OtlY//7vIU36Dohkhn
   A==;
X-CSE-ConnectionGUID: +8j0qFodS5iV1GC4lWtiSA==
X-CSE-MsgGUID: jw+k7P0ST9irEpusffZIVw==
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="30947688"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2024 17:43:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Aug 2024 17:43:11 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 8 Aug 2024 17:43:10 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next v2 0/2] net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
Date: Thu, 8 Aug 2024 17:43:08 -0700
Message-ID: <20240809004310.239242-1-Tristram.Ha@microchip.com>
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

This series of patches is to add KSZ8895/KSZ8864 switch support to the
KSZ DSA driver.

v2
- Add maintainers for devicetree

Tristram Ha (2):
  dt-bindings: net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
  net: dsa: microchip: Add KSZ8895/KSZ8864 switch support

 .../bindings/net/dsa/microchip,ksz.yaml       |   2 +
 drivers/net/dsa/microchip/ksz8795.c           |  16 ++-
 drivers/net/dsa/microchip/ksz_common.c        | 130 +++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h        |  20 ++-
 drivers/net/dsa/microchip/ksz_spi.c           |  15 +-
 include/linux/platform_data/microchip-ksz.h   |   2 +
 6 files changed, 172 insertions(+), 13 deletions(-)

-- 
2.34.1


