Return-Path: <netdev+bounces-174814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB800A60A5A
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 08:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285D017E5E2
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 07:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C24618A6DE;
	Fri, 14 Mar 2025 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="A3i4uvUM"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17815A843;
	Fri, 14 Mar 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938640; cv=none; b=UF3ETKs3o0JO/Hjnkz3dmySiQzbuRbNdYKFX6MpX6WjRjRVPeABI21qWHB5+yjEJeq5rDURJhP3wueYZmlpbsCfVG2r/1dvZ2ddEVT0F6D1637fDPO/o5exDSscSJaWxBMXSkc/THscGKqSxo1l3C1aS+G8Y9DfdCY+9SVLXzv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938640; c=relaxed/simple;
	bh=KJeojQ6lr9L3jbzA7XJUUNU5rNHf03mXs3rQI8LO/Hw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Aafu0tb5kU3WLUkzToVT6dvHgoV2fPPgNgFkO4Z0dy/lz4WXkGDhEaPB4w9UoRvwCvH7sma2zV41kGbbimJGVOHQceHImGBkGUiliztKXXX7ihOVP7uB5jrR/aJpvaTEaOgC2c45BIhKSppaztPQXb2VrhzD66oS3wIBBCnMFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=A3i4uvUM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52E7oHIt92715778, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741938617; bh=KJeojQ6lr9L3jbzA7XJUUNU5rNHf03mXs3rQI8LO/Hw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=A3i4uvUMAHIWzMIMxSUW8bv+ZOUBUmAV7nsveVEugAmTdBotwyPQ4hKElnWWCif53
	 2ZEWqsgdm5hdLdiLDwGYMlmZTRP6OOyy+KL+EmvKOgmnnepCnPd8tM1Yy6vlQ1fATI
	 yi5EVLd+ezFn2bdSyofq9xa3R8JWJzPLN6IR91QyIpO/fImYPOcfFN5nk2DZ4ZJvMc
	 CzgX5wnnxYfhx2VHtelW361Il6c4U9kG2NbRX0Tbh8SepbqxDU9buMUExqEANvgnLS
	 xGUG4+yy+lHCwGhbyax5ujrfEgwH7qsS+pyLIc25cSyZyJVThhV8cIZkySwXFkIRZk
	 Pf+d/mfj6oYXA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52E7oHIt92715778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Mar 2025 15:50:17 +0800
Received: from RSEXDAG02.realsil.com.cn (172.29.17.196) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 14 Mar 2025 15:50:16 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXDAG02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Mar 2025 15:50:16 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Mar 2025 15:50:16 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next 0/2] r8169: enable more devices ASPM, LTR support
Date: Fri, 14 Mar 2025 15:50:11 +0800
Message-ID: <20250314075013.3391-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series of patches will enable more devices ASPM support and fix a
RTL8126 cannot enter L1 substate issue when ASPM is enabled.

ChunHao Lin (2):
  r8169: enable RTL8168H/RTL8168EP/RTL8168FP ASPM support
  r8169: disable RTL8126 ZRX-DC timeout

 drivers/net/ethernet/realtek/r8169_main.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.43.0


