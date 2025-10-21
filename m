Return-Path: <netdev+bounces-231415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 957D3BF9211
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B3C19A6BA9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463F2FE596;
	Tue, 21 Oct 2025 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="c5X6C4u0"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19F52E9ECB;
	Tue, 21 Oct 2025 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086677; cv=none; b=PTaRznad4aA79g5hdazzZYiXg5QsILFSwOet1Dyrmr2nyJRGe7G4PzIrUSx+T1aO9tiVEbMQV/Uqob5/b5WdkMOUF7iqmLNPda3MB1l5yKs4sGnzD32asG6EZpNsP0ZM7ieW9wxVucOKJv0B6SrVj+Ms2/61GmBA1Sejl+XKkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086677; c=relaxed/simple;
	bh=m8JQpCLIYjZnGCEwjSkp6XzEFqYautr1lIFN/m8hMzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJLevTFPeX3LQGGpCznfFPOBkRO6kjsBATwAzfpbiKcyEsk84Hfu6VFEBdqgOtmbcjyfhWDCdhkUHlWToTce9KQd5ew7XtyWO213pCDZcIJg7y1re79DJJ1f9r5Q8wQhN0oOap0s3YLK5FQUpGzDtnDSetBj3aAoZ8JSe9z5rbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=c5X6C4u0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=OE1/poLOBpssLfVKi6tvWS54f0LMjEaMWJ/83vjq+V4=; b=c5X6C4u0uKTb6j/SKDLaDajGeq
	vUUJ2o5P8eNs65B+zwcNo8VZT8OAlUlSePJv189L6Hy63lD8akphVZXwIpscqUcJqWBKasBGsNsOI
	f1b9VkTClwxsKpvXhX6PAaNKI54EGhjNgysA1WKZ2KcDuj2CfIdVGtr/xOnwcmsDCm56iu2s6n3ti
	JJ+jIhmUnQnlxKZ4ujuuRnYmhm2udH59ldEfpNY7CdSuDbWCYzpMbEXyrUpCEeiM+L0OmDm3hhRXz
	9Gq98b+YEDgD2cBKs9vD3FX6X4RtDMvk2Fwm6v2zpP3IMOXZnAWYEBOc/Ly9c0gsDeqRklUKEIVFc
	FPDICgNA==;
Received: from i53875b19.versanet.de ([83.135.91.25] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBL5a-0006q7-SV; Wed, 22 Oct 2025 00:44:22 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] DWMAC support for Rockchip RK3506
Date: Wed, 22 Oct 2025 00:43:53 +0200
Message-ID: <20251021224357.195015-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some cleanups to the DT binding for Rockchip variants of the dwmac
and adding the RK3506 support on top.

As well as the driver-glue needed for setting up the correct RMII
speed seitings.

David Wu (1):
  ethernet: stmmac: dwmac-rk: Add RK3506 GMAC support

Heiko Stuebner (3):
  dt-bindings: net: snps,dwmac: move rk3399 line to its correct position
  dt-bindings: net: snps,dwmac: Sync list of Rockchip compatibles
  dt-bindings: net: rockchip-dwmac: Add compatible string for RK3506

 .../bindings/net/rockchip-dwmac.yaml          |  3 +
 .../devicetree/bindings/net/snps,dwmac.yaml   |  6 +-
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 79 +++++++++++++++++++
 3 files changed, 87 insertions(+), 1 deletion(-)

-- 
2.47.2


