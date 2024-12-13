Return-Path: <netdev+bounces-151746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A479F0C46
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E5516983C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2BC1D8DFB;
	Fri, 13 Dec 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HrlF9JAY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A438DC0;
	Fri, 13 Dec 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093150; cv=none; b=H0g0aZoN86U/uhmSUQJ84v6+BfYdyLQTOBEZ70jUZxCZVd7grxKb0zPJ3RYjLSRNeGHjfupXag2BL9j4b61WncgQtfPuzT1qoCQK/v3aIL64B0w8VvWrGq1f3OCLB3yAe599MMRiA1zBHm9OTDB/4YmmhKZnaDcP9lzYEkzlQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093150; c=relaxed/simple;
	bh=n3Kwco+VC0Wx1VAHaTK3mzvPDxUFFtXgicaqkiGL3ys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WsdHy1/2vUtjhA6Kuwa5zmvuRSzsR/oM8Qn6FjJjHn0aq+/KmagPpSRwL5IGK0Q6gNqhsTXd0mTt8wHcrH1jJqZ3lLyxztDN5+hFhoGcxqAvSD/rwv5hRgIcah3Q0GVFVG6cTcg9VWlrU3cxJp7xoAxaHMhzwtO6ZX4bQ05+MVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HrlF9JAY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734093149; x=1765629149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n3Kwco+VC0Wx1VAHaTK3mzvPDxUFFtXgicaqkiGL3ys=;
  b=HrlF9JAYxtSB3vgKICnzQbJ5TSmWfGIeDiqUoUFbBqpzfcpQsj9YiTjy
   ssRf3lt076i4tafWnrL/1B0Y2JkOlhirIsZMhKGyDg2ZhjvGatSyT2gMj
   eC0O3thB3K85iVpS2L1s+FX+09Tz/H3jgBQkhidBlsuY8WJr9jXEQ+Jzf
   dgsb8DSiQ7B0JbPrchYnQzNt8+sbl2MwdNJ8rkejC3re7CEwbnqFVTGha
   ingOnfzQMfZZay1lbP/c4MhY5jzQda+jMXdvmbNDcAjyOGyNl8Cdz0097
   F5bpcjqHgBuWnF/+dJ8wf+CTqxWqoCdTuDqlhRCo5NB711lHGaPs4Mpy2
   w==;
X-CSE-ConnectionGUID: T4iONzRASJC/nLtS7vBTbg==
X-CSE-MsgGUID: Bt6f2nQJQ4uzOVKSYyZBgA==
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="35183034"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 05:32:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Dec 2024 05:32:09 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Dec 2024 05:32:06 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <parthiban.veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: [PATCH net v4 0/2] Fixes on the OPEN Alliance TC6 10BASE-T1x MAC-PHY support generic lib
Date: Fri, 13 Dec 2024 18:01:57 +0530
Message-ID: <20241213123159.439739-1-parthiban.veerasooran@microchip.com>
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

v4:
- Replaced mutex with spin_lock_bh() variants as the start_xmit runs in
  BH/softirq context which can't take sleeping locks.


Parthiban Veerasooran (2):
  net: ethernet: oa_tc6: fix infinite loop error when tx credits becomes
    0
  net: ethernet: oa_tc6: fix tx skb race condition between reference
    pointers

 drivers/net/ethernet/oa_tc6.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)


base-commit: 2c27c7663390d28bc71e97500eb68e0ce2a7223f
-- 
2.34.1


