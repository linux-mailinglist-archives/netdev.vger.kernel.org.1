Return-Path: <netdev+bounces-148984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B869E3BA2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63BE4B2ECA2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31971DF745;
	Wed,  4 Dec 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CUvdaZZV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6B1DC182;
	Wed,  4 Dec 2024 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319368; cv=none; b=gttZXvdS8bqATvspPuYqYs3bmen9Fgbyvg6xjO7nCMxrXAj/DS5tViMnqXwxolwmQQez1oSkg8hTtEqccUIhrXjNMwC54Yp7YuwPSPUn4K/p1+usVhUhFNp6LltLnhqFZnrkhtz3LWrA32RBeipA/4zb2PyZDMNlU9/QNLZEMT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319368; c=relaxed/simple;
	bh=UgXVV6RLZ12V1O6hvyVUVDCgJcOXxL/7UflkUTNl2tY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oVGZdFEiyPAG3NUb9ieUFEKJNBHz6F+HAnNMeFZ034XOeAP/pPsJP6Prv2V2aiuho9gHl1gisATwI7AkNsW1yPPl7zUL9RzELbvJpI/FfRkPX8E9XUCzVAGo44vHMcVtxh8/J4+oLHfSg9t8f4wdnjO1bLXdL2N+D3HxGZB017I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CUvdaZZV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733319367; x=1764855367;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UgXVV6RLZ12V1O6hvyVUVDCgJcOXxL/7UflkUTNl2tY=;
  b=CUvdaZZVCDSVUlDGi9GrYY4jGTHpUba6DKZQKzsBJr2GR/Lq0ZKzIKuA
   F8yaGqcTNEc6BGPf10/xhXqdpR/wgirYP3nSL2jXF03B2drsdUK/X2Ryu
   6cmvGOI+zGD+3RkDEqQrXp9ZeSpo2OSaN1wk6JRBFbc6Y+Xg8/igfkF53
   nKYmhOAIbDTM8VKR5ld3TO2GsB3vpX6h6gM4f00r+ZbotODU7Z3qia6c4
   iSDuVIKoBMg0pdNdRnnGJ4592QEw+C/bqSeogxrJyv5Cz5Yd7v6LOEulM
   9Nr+YdzQ8LKSNOtGJ4WBReL0YaUNDO/qsC1zwmoXUUSZ8z4NwByhHhJep
   g==;
X-CSE-ConnectionGUID: rlrAe6FFQQitUQtWMxh7nA==
X-CSE-MsgGUID: o9tbbCM4SGq3h+dZB4QYzA==
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="266321980"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 06:36:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 4 Dec 2024 06:35:25 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 4 Dec 2024 06:35:22 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <parthiban.veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: [PATCH net v3 0/2] Fixes on the OPEN Alliance TC6 10BASE-T1x MAC-PHY support generic lib
Date: Wed, 4 Dec 2024 19:05:16 +0530
Message-ID: <20241204133518.581207-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series contain the below fixes.

- Infinite loop error when tx credits becomes 0.
- Race condition between tx skb reference pointers.

v2:
- Added mutex lock to protect tx skb reference handling.

v3:
- Added mutex protection in assigning new tx skb to waiting_tx_skb
  pointer.
- Explained the possible scenario for the race condition with the time
  diagram in the commit message.


Parthiban Veerasooran (2):
  net: ethernet: oa_tc6: fix infinite loop error when tx credits becomes
    0
  net: ethernet: oa_tc6: fix tx skb race condition between reference
    pointers

 drivers/net/ethernet/oa_tc6.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)


base-commit: bb18265c3aba92b91a1355609769f3e967b65dee
-- 
2.34.1


