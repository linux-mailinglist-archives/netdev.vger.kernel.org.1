Return-Path: <netdev+bounces-146508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD74B9D3CBF
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715722831D3
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB481A7AFD;
	Wed, 20 Nov 2024 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HZCiPOaG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEFE19F471;
	Wed, 20 Nov 2024 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110732; cv=none; b=uRmbcKF/1VBhr5a4MRM28LJBdYKqj4PXC38P4ePFws7CM5Rj/RFQGPc8lplVLZyqKlicY1vSebgvST0SlibbH8DEpsRjoGivkrqMRD8zVlaDhWXTNTqVbN+tgQEO6sF5PzLeHTNEjX3srJbfrxy2YOBT7VWw0hRFSh/4W6aJ/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110732; c=relaxed/simple;
	bh=PU4nYu20AwjCRBz/lnaLHXVqfi0S4/VHlVP+jTFs28E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ETY34jKTquSpjRlLo2yVdE7nmeDBmmspS0uOhwcexWbBDOnFfrMQQOT1gRobOv7AoyQqjKoo+n39cs9U9Z0WbIC5mBBzakBkyuqGIAwkdkSGushS/xfNA02twYHacXT9GML5jjYJvYoK4kE4lRVBtH8seJoMKwPpzxdKX+RgeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HZCiPOaG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732110730; x=1763646730;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PU4nYu20AwjCRBz/lnaLHXVqfi0S4/VHlVP+jTFs28E=;
  b=HZCiPOaGV5u5wYp3s13XxDdAIWN471JLxOivyXMYe32doT+VbDRNDHJC
   bqTuOol46/8rMbHe2YnVIVCu+O8vBsfrrUrxclK8TN9e3w9GLEvn7yPBV
   PaNlDyQJ8ldp1+zR9WKVAx8ZnIijXa0MUqUwvK3yJtdcn2OD2Ioq6mGwS
   7gQosu8eeAHfdOmF9kG5VCPShNECwtoFjONJdLhOuaGcECVX2oyHY4yNa
   DU4EVbe3z4/oWgijFhHWQV2En8KWtBItjfgF7nujty+4mzmJL+Gu98vTI
   lnyI8LxNptuyBwUWpjjEf3RHXnZQ8yOstDhQviVJ0QOBn4fYQXKgJHP9j
   A==;
X-CSE-ConnectionGUID: s676mMNXQSWPZ8VgzXR3Jw==
X-CSE-MsgGUID: HDYxI2gsT6ypLFMmWKa93g==
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="38128115"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2024 06:52:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Nov 2024 06:51:56 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 20 Nov 2024 06:51:45 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>
Subject: [PATCH net 0/2] Fixes on the OPEN Alliance TC6 10BASE-T1x MAC-PHY support generic lib
Date: Wed, 20 Nov 2024 19:21:40 +0530
Message-ID: <20241120135142.586845-1-parthiban.veerasooran@microchip.com>
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


Parthiban Veerasooran (2):
  net: ethernet: oa_tc6: fix infinite loop error when tx credits becomes
    0
  net: ethernet: oa_tc6: fix tx skb race condition between reference
    pointers

 drivers/net/ethernet/oa_tc6.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)


base-commit: dd7207838d38780b51e4690ee508ab2d5057e099
-- 
2.34.1


