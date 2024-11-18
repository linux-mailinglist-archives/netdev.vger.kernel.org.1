Return-Path: <netdev+bounces-145725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D109D0929
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E025281B58
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8D213D24E;
	Mon, 18 Nov 2024 06:02:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A319DDC5;
	Mon, 18 Nov 2024 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909742; cv=none; b=pIKFJRFkHtvKUCzrbNZTyZXq4HrjHO05qBBpC83yp63oCLyFSHHAIHqABD/MXgPnEP1UXGVYp/Up4Sx05RrKE0wmqyiT7WjeOIY5csattFqH7od0WbhcmyS9A1bPRK9K4/cf0vyAhEk09Xu+i/WeCxc+n+IP9dxpF1cK7Vlngkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909742; c=relaxed/simple;
	bh=mV2Fw0s0s7zRUsA2l2ArvwPcdIvoHsKnoT2XCOIGHwg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lEWWu6j6reYgkgP5a98njrOL1L8n5UpN7DAzvfOFUtFllV/5L/PtsHOvZ4HETVP4RA15GcCP46c+zCR4NdEJXkQYSkQXVIANMfUxrkl7l0w+6aplYxdSivy5v4pQjongdk5reO1o5FELsA/vSGQnUlh2R4qto5LkSM2BeolLR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 18 Nov
 2024 14:02:07 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Nov 2024 14:02:07 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [net-next v2 0/7] Add Aspeed G7 FTGMAC100 support
Date: Mon, 18 Nov 2024 14:02:00 +0800
Message-ID: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
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

 .../bindings/net/faraday,ftgmac100.yaml       |  3 +-
 drivers/net/ethernet/faraday/Kconfig          |  5 +-
 drivers/net/ethernet/faraday/ftgmac100.c      | 80 +++++++++++++++----
 drivers/net/ethernet/faraday/ftgmac100.h      | 10 +++
 4 files changed, 78 insertions(+), 20 deletions(-)

---
 v2:
  - Separate old patch to multiple patch
  - Add more commit information in all patches
  - Add error handling in ftgmac100.
-- 
2.25.1


