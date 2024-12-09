Return-Path: <netdev+bounces-150268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC709E9B6F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265E31887B00
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073B6139D1E;
	Mon,  9 Dec 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EsCwYiJj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39197146A68;
	Mon,  9 Dec 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761221; cv=none; b=VvQsS6TC5blfE/vNCHTBifxuKQCuA0sOB631oEUAYEPdI5v1oh2Nu8dRJd35jdQ1qEIdpLKMw4UwKDkwje+KtaMr12lTwYg5xOLngFx+7B5d3K83yw3NlYGmsHHQ1uK1N0Zx4kqhwoxUJ6GTceAp/Gy+dB/o8SdXfK2NAvjUH+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761221; c=relaxed/simple;
	bh=TfXoil+XL4I73hSqSJfQnpvLiXJRQCeNll6RI5p8uos=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ub6sXjQ8fuv9k4AFXNrtFSRByKiC2KfQedo8cOjxbtNokxJqycRJde1b6NEXoHYf5mghc/yVRbW7PjoaXFJJnOIIfnU6g6EgO8yEd300OBRN+ow8I1gvglFPlK3DMKb6q03iNM8AJkdBfiB991in2h9oiKBkQXI1hCn9qpIg+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EsCwYiJj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733761220; x=1765297220;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TfXoil+XL4I73hSqSJfQnpvLiXJRQCeNll6RI5p8uos=;
  b=EsCwYiJjdFmsIBsuycRNA1FZeAhFHvKa0fDFNozIjhAuXBqLlHpMkNkL
   ZeM6tvOVp1CMLMiWjYbQPQ703HclkhtzIJzT6Bejm2vxycKWPJmtHRE+g
   A1zSRc5Q49L+N3qaS+Xq0DtsEy9mp4VXIzrd7vr5TBkEGF1xksYhEbd4V
   KvwFA9h6hheZMBq1Dh4diFO70pE9dfNzprb50hnQHiZ5MeOrQxHiE8+gP
   X8PeLxNdSito52HxhcbiMP1iXnU2p2zoV3z5oRWwPen9+X7Z+nNq5DSV8
   u6sMdnBPxfqOxkKqkxIYtaa5Kyk6pyocKjx5JcvB0zuJNgdiDaNPMV2rG
   g==;
X-CSE-ConnectionGUID: kihm+9ylQgCISWmyE4OjDw==
X-CSE-MsgGUID: A6OUF8/QTcGdsH9S0iRxsg==
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34998231"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2024 09:20:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Dec 2024 09:20:05 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Dec 2024 09:20:02 -0700
From: Tarun Alle <Tarun.Alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/2] Add auto-negotiation support for LAN887x T1 phy
Date: Mon, 9 Dec 2024 21:44:25 +0530
Message-ID: <20241209161427.3580256-1-Tarun.Alle@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Adds support for auto-negotiation and also phy library changes
for auto-negotiation.

Tarun Alle (2):
  net: phy: phy-c45: Auto-negotiation changes for T1 phy in phy library
  net: phy: microchip_t1: Auto-negotiation support for LAN887x T1 phy

 drivers/net/phy/microchip_t1.c | 147 +++++++++++++++++++++++++++------
 drivers/net/phy/phy-c45.c      |  36 +++++---
 2 files changed, 147 insertions(+), 36 deletions(-)

-- 
2.34.1


