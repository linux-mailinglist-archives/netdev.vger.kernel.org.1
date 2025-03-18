Return-Path: <netdev+bounces-175618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF8EA66E74
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A701758DD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870AB1FFC47;
	Tue, 18 Mar 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ijJUJkWP"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6E71A262A;
	Tue, 18 Mar 2025 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287064; cv=none; b=YQRthzT2N4nzUDg3GGgpNqkcAI+uTbHZCtdr2WlfOWRiaQw7o7g5QW6fENpYZ3HNIX1RTo7lOuTxL86U4OZrdcfGEb+/E5UiPgwVLPECFWVaR5SPL1+nWvAQmXh/MdtSTbC12kgFdVsuR08FqtvMGYy+aGgf2kbQ5f4M2cup6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287064; c=relaxed/simple;
	bh=iDHSJrRMpJCglksEroC9F2aKcUHY9EStjzQR8fDaTqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dPG+OCYt6Ltc55I4y7QDskN+uZhxU1R4z7RYyRgRTWrKPNszigUI0OYpX6xSAuoJpjjLaAx1FjbWTPO5WRnSt+VnCiswqYyFmgVR6pZpZtU7bySu8v9YchmRH/0foTSfuAACRGXYwQw4pF2V4Cm5PmkMV9dpBwPkCNvKHDgjWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ijJUJkWP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52I8bMyH52588602, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742287043; bh=iDHSJrRMpJCglksEroC9F2aKcUHY9EStjzQR8fDaTqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ijJUJkWPIov7InuEl8QcwPhHdVV8KMRjAlJDA/WD5eJf0WhaUYdBMdHXj/uADvh9R
	 dXS0CmYTTgkj1e9jjX5xG48F4Ew0+ldRJk3wKKqLeTc2t8nQYlULHhXUYddXNqGMR0
	 FgS/W1GUlVTYb0eLN43gj/vW9Gcy6wybue2IgOcscCeQcq4mImhPWPro+PUhxoR/uH
	 4W2eYdehx2ZvGdw+/S68b0+0MyobzJS73CMaj5AFm9OiQW3Z23F1dFyZ4tHzYI+YO8
	 ASLif1sJNbRO9tDi5EfQn0cqDqjUfkjnblnskSmJlqqed9W+8SCQR/HGs4wo3maWwH
	 4dS8ZqwJ8rnfA==
Received: from RSEXH36502.realsil.com.cn (doc.realsil.com.cn[172.29.17.3])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52I8bMyH52588602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Tue, 18 Mar 2025 16:37:23 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXH36502.realsil.com.cn (172.29.17.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 18 Mar 2025 16:37:22 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 18 Mar 2025 16:37:22 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next v3 0/2] r8169: enable more devices ASPM support
Date: Tue, 18 Mar 2025 16:37:19 +0800
Message-ID: <20250318083721.4127-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series of patches will enable more devices ASPM support.
It also fix a RTL8126 cannot enter L1 substate issue when ASPM is
enabled.


V2 -> V3: Fix code format issue.
V1 -> V2: Add name for pcie extended config space 0x890 and bit 0.

ChunHao Lin (2):
  r8169: enable RTL8168H/RTL8168EP/RTL8168FP ASPM support
  r8169: disable RTL8126 ZRX-DC timeout

 drivers/net/ethernet/realtek/r8169_main.c | 29 ++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

--
2.43.0


