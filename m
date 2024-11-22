Return-Path: <netdev+bounces-146784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142BF9D5D2F
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 11:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD69428347F
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CAF1DE3DC;
	Fri, 22 Nov 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VIiyaJQD"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86221D9A49;
	Fri, 22 Nov 2024 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270931; cv=none; b=rXFSxoqumSwk/x3iB1fFbGyMP1P66SrS2ENFBl4eeXpN0804G4iMEmPt6M2HRLvNl7uFiIoIAP+cB8Kj5Hex3RT8J6zeGIB0tCewKaEUK4mZ63+QZdTqrSp+aOeUd3h4eoWVEf8+WOKcnTcgm03INZzkgCx3jgmhC3lZIDIa9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270931; c=relaxed/simple;
	bh=/9SiDo6HS5MF/i33YWfRt3gDB2izJSFFxg/H/XkcXJI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o/F9/BgaRyJmI6WHcLyQrOt1I82euKl07lpvhOOXK7dpUq1JyqnyHMA2o9q7IvrPLHEWwt0SgUFMRc2llVkyVnpV4yzbdcPhy7fUHP4HdTJ83dbu/qmSg3LsYklLnVFbVltMXBzdKt3qrDQE/V7SB8wnC37AJx8FtHT9gqd1xvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VIiyaJQD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732270929; x=1763806929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/9SiDo6HS5MF/i33YWfRt3gDB2izJSFFxg/H/XkcXJI=;
  b=VIiyaJQDK1SyCSaWk/ZaWeWAiZRPQ3cf4qzBKauFgzY1WG0t9lfIc0BN
   EE1PI2sz5BraseUjhhWE+IMaUJFBG2dUD4pjZs5tMt69NljJ3lQsVHBEV
   esg1BMbrvVtpZOzHx9+GQETxos+Fvs0ruojRphaMWiV957YkiaSnjyXG+
   GOUx3gZHw/QCbSPsMPe6djQiNxQiCOr3gNkr2Z3ROOs2CA1WWFIQDkB59
   K3vB6pRM2ST4OgOMuG63HnM9F4zFE4UYOXOWD3iQ67wZyc24M9Sayr4EU
   vLBWklczwZu2ATSATSqxCuDecbKsR/1sAUCAPRD6fRDcvC7IUOxtKWQmq
   Q==;
X-CSE-ConnectionGUID: MRSRvnTqSAqJLUuhxew2Xw==
X-CSE-MsgGUID: cl79eNAPTe2pDQUF7/Iy8A==
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="38251709"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Nov 2024 03:22:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Nov 2024 03:21:42 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 22 Nov 2024 03:21:39 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <parthiban.veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: [PATCH net v2 0/2] Fixes on the OPEN Alliance TC6 10BASE-T1x MAC-PHY support generic lib
Date: Fri, 22 Nov 2024 15:51:33 +0530
Message-ID: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
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


Parthiban Veerasooran (2):
  net: ethernet: oa_tc6: fix infinite loop error when tx credits becomes
    0
  net: ethernet: oa_tc6: fix tx skb race condition between reference
    pointers

 drivers/net/ethernet/oa_tc6.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)


base-commit: fcc79e1714e8c2b8e216dc3149812edd37884eef
-- 
2.34.1


