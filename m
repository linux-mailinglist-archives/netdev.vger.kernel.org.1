Return-Path: <netdev+bounces-149245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD79E4E34
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7625D284B54
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6AB1AD9F9;
	Thu,  5 Dec 2024 07:26:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2C17CA17;
	Thu,  5 Dec 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383561; cv=none; b=NhcdxvXXiGvvFaDlw+weJ7wX45qyVepdkidNzUIVeMC+Dj9BLVDENUcWxSKkKqc7pF03fr6ZLCyKsonXJ5/ip5MeQceAqVjtCaHFmimjmVrqbPs7pf6GPvilENNBYXj7td4KWVIwQj9IynMFXnDnborjnECxSYl4j+qOkJh8prs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383561; c=relaxed/simple;
	bh=uLqV/mASobHzVYQQqiUKRDUQqJOd/bhXHsXwED0T4nE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XuKghFDS9iSdMRW1YwTesONSOqz2AMW5jWjLksT8J6YC2ERGJ2ncsQhq++tXbtp6nzX0lTLyJJvX+USANdmoKYDxP7flhdZO2mcZVeG6VbxtLAX25+Z8znoo6ZByvaR1biGV+F5viK8AEqQ8k9r221J0f2tvqnnV6DAOhInZoH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 5 Dec
 2024 15:20:48 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 5 Dec 2024 15:20:48 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v4 0/7] Add Aspeed G7 FTGMAC100 support
Date: Thu, 5 Dec 2024 15:20:41 +0800
Message-ID: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The Aspeed 7th generation SoC features three FTGMAC100.
The main difference from the previous generation is that the
FTGMAC100 adds support for 64-bit DMA capability. Another change
is that the RMII/RGMII pin strap configuration is changed to be set
in the bit 20 fo register 0x50.

Jacky Chou (7):
  dt-bindings: net: ftgmac100: support for AST2700
  net: faraday: Add ARM64 in FTGMAC100 for AST2700
  net: ftgmac100: Add reset toggling for Aspeed SOCs
  net: ftgmac100: Add support for AST2700
  net: ftgmac100: add pin strap configuration for AST2700
  net: ftgmac100: Add 64-bit DMA support for AST2700
  net: ftgmac100: remove extra newline symbols

 .../bindings/net/faraday,ftgmac100.yaml       | 17 ++++-
 drivers/net/ethernet/faraday/Kconfig          |  7 +-
 drivers/net/ethernet/faraday/ftgmac100.c      | 75 +++++++++++++++----
 drivers/net/ethernet/faraday/ftgmac100.h      | 10 +++
 4 files changed, 88 insertions(+), 21 deletions(-)

---
 v2:
  - Separate old patch to multiple patch
  - Add more commit information in all patches
  - Add error handling in ftgmac100.
 v3:
  - Move reset function to normal probe procedure
  - Move dma set mask to normal probe procedure
 v4:
  - Add more information in commit messages
  - Add resets property in ftgmac100 yaml
  - Remove more print log from reset flow in ftgmac100 driver
-- 
2.25.1


