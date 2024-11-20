Return-Path: <netdev+bounces-146409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E8D9D34B5
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D37D286FE6
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC80F15B543;
	Wed, 20 Nov 2024 07:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1E15B12A;
	Wed, 20 Nov 2024 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089022; cv=none; b=MGiwonRY2IutxGVU5iIi+ct1DXgohro2mMaNWn4tdbt8uul79vdYWmAOuzvsl5Q825bJkMfixFtYKUCqa7oAa0u+o6wLMlSGDdAYbUn2XbiOskiOOxp1E6X6fpO3itbbHN0QDBYpUNxxVVAqANJOxJ8ubg+8cd2J+45TPn3PdfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089022; c=relaxed/simple;
	bh=1MDz2swxiH3wuRRjdrXydgCHo6PxaFIb7Xswd2lDdMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sgb5x4Ug2pAO8s5cq4HJP4v2Fap+3vK49Q5ge5La6N0ld5il5PYFs8xyltWTg6i6wMZhJ3n50f2RA84ejj+zfCqQFlnpnuEAPaW+nT67aGxek8tBh64VSVJk+qjdJq+2nbWYFFG66vlsvLenza7v0PF4oj+wIIx0i5mztaV71Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 20 Nov
 2024 15:50:17 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 20 Nov 2024 15:50:17 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v3 0/7] Add Aspeed G7 FTGMAC100 support
Date: Wed, 20 Nov 2024 15:50:10 +0800
Message-ID: <20241120075017.2590228-1-jacky_chou@aspeedtech.com>
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
 drivers/net/ethernet/faraday/ftgmac100.c      | 77 +++++++++++++++----
 drivers/net/ethernet/faraday/ftgmac100.h      | 10 +++
 4 files changed, 75 insertions(+), 20 deletions(-)

---
 v2:
  - Separate old patch to multiple patch
  - Add more commit information in all patches
  - Add error handling in ftgmac100.
 v3:
  - Move reset function to normal probe procedure
  - Move dma set mask to normal probe procedure
-- 
2.25.1


