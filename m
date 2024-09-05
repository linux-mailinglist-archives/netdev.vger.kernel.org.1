Return-Path: <netdev+bounces-125513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8765B96D777
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C58283872
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3025199235;
	Thu,  5 Sep 2024 11:48:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8A2F44;
	Thu,  5 Sep 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536884; cv=none; b=pR3N4AeDlVA2OXrqiko+CyCcuVIAq7h7JD8iyigNyPZY61BHpvJMEwct0wd1kCZjouaNqnL4PFQ4OH7L6M32sj441yJeii6+LJbYsu8JM3178Z2z6etzfA21T2jL1PcK8gdwnjqjRYhq96VoRz6eX11RdqP/iigBwTiSnL80YsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536884; c=relaxed/simple;
	bh=IGlaXL9pdUF232isK/TwzmFs7vaFG6Z1BrlqY92RrIE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bdQDXx2WaN1M5qpBPjNAFLHuNxj2ZOEig91PECXmI35E0ElC9MMYX6q4qO7RVfK3C8HodQa3OOpwml4IjfC4MMoAm8ykYCGW4DoSPq372ijhwzCsp1bkdx+ZDuofOpDY5+3oLtbV4fBjylL1rUQybop6cpKhqd8VXaaU2iocXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 5 Sep
 2024 19:47:54 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 5 Sep 2024 19:47:54 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH 0/2] net: mdio: Add ASPEED AST2700 MDIO compatible
Date: Thu, 5 Sep 2024 19:47:52 +0800
Message-ID: <20240905114754.519609-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a new compatible to dt-binding and mdio driver for ASPEED
AST2700 MDIO.

Jacky Chou (2):
  dt-bindings: net: aspeed: Add binding for ASPEED AST2700 MDIO
  net: mdio: aspeed: Add AST2700 support

 .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml          | 4 +++-
 drivers/net/mdio/mdio-aspeed.c                                | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.25.1


