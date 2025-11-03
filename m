Return-Path: <netdev+bounces-234967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A3FC2A5E7
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 08:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F390D3AC954
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 07:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659FE2C11DD;
	Mon,  3 Nov 2025 07:39:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB82C08D0;
	Mon,  3 Nov 2025 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155587; cv=none; b=pDDPWcLPhU6cH0TmHL4K/WWfRXo2jwFixzV5rQ8pUjaHg+vcbwGe5i9+UDg/8ghnTU1bDREC7hHh7zb3cSuy9wuM6gRdgzrGAq/8r0ItmOx3JZI9RqyvidmxY6BozgxQrENEmADfmP9ezKKtohLYn4km4WQQs8pPOmzzDX8wYZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155587; c=relaxed/simple;
	bh=K+lA41x5DitnWJV0QR7dvh8A8xDGnA4qbW5y81EFvPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EWgKS5ZqcBxxxgpTU+u4m+zWJppHxEfUU6LA+Mo55xGtlR0mgusPEMOXsUnF3Ek0/ZU+ibkqvcqA3YVdJy9hWU+d0dNnNGCpsP9KCeH9D9Xa8MsexuT+An5hJufzC2G2DJGz7T7W1tdXAWTS59469fVZCrzoMuelkq+/4DhDjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 15:39:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 15:39:31 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 3 Nov 2025 15:39:17 +0800
Subject: [PATCH net-next v3 2/4] ARM: dts: aspeed-g6: Add ethernet alise
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251103-rgmii_delay_2600-v3-2-e2af2656f7d7@aspeedtech.com>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
In-Reply-To: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762155571; l=772;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=K+lA41x5DitnWJV0QR7dvh8A8xDGnA4qbW5y81EFvPQ=;
 b=m0RI1d6GHfXKir20yR72B2X9RyMjrez/e3doka6ugD+gQWdxw80MR8blx4QzFEmNQW9/N0TWW
 R0Jj8dSlViACFq6BGfKQuE5EpDnPtyRwDP2jylOoeHMtZgiqa1wEA9b
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

For RGMII delay configuration, MAC0 and MAC1 use register SCU0x340,
while MAC2 and MAC3 use SCU0x350.
The Ethernet aliases are added to help identify the corresponding
MAC index.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index f8662c8ac089..03ad566a4ce8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -40,6 +40,10 @@ aliases {
 		mdio1 = &mdio1;
 		mdio2 = &mdio2;
 		mdio3 = &mdio3;
+		ethernet0 = &mac0;
+		ethernet1 = &mac1;
+		ethernet2 = &mac2;
+		ethernet3 = &mac3;
 	};
 
 

-- 
2.34.1


