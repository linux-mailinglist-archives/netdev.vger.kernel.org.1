Return-Path: <netdev+bounces-145719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7859D084F
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 05:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D5F281C02
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 04:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD9A76048;
	Mon, 18 Nov 2024 04:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="A9l9xZPH"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724F634;
	Mon, 18 Nov 2024 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902953; cv=none; b=S/Aydn5wEG63e3P3SJomEa0EI6ZMlDX9lIR5ngz1yzGgqxxszI8fZN5jbOux2EMCW9f62SDtczifPxUJ6JvMpzq6Ihp8Yrfv+ziH4ZPuOxn54+9CATFDcNMRd9gbGcWi+rQrHwCkQnw8bjoZC6rTe2eMmc3jTyiuERhnvLeFJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902953; c=relaxed/simple;
	bh=Xq1zDuxcmrgMpAytdrHyNRYCyDFnaBbZeSIWOsP4IRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fxps6SgErX/IkH3zaSiXdmrq56dC0J5smvvcsMU/FzSyQ3wiXsNUEaxwSY0clnCk8XX0cokZvA6AdW5ZSCFqu7URIdzIJIm5KndVWE/6GSUlHfj6La8siIdUZO+g4PKs2M6JIosuMb0dgf4TgWnL+ni4ACjgTHZtw+EbGTCuNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=A9l9xZPH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI48e362102555, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731902920; bh=Xq1zDuxcmrgMpAytdrHyNRYCyDFnaBbZeSIWOsP4IRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=A9l9xZPHOn4d3m3p9nCdZydpT0dv4Gk6gIJpsYQUQuA90LR7CpY86hyAwsEiJcGth
	 t8geQA2aXVXS8wlXLKpyxh5TY7qBuVCP0O8eK0qTnZk7o+xCbCLjuuJu42x9OnHeP8
	 Jtu79U0DqS6nMeoGEHb6aCWcS4DOpaLtJuEi/CTaQr5BmU0OTFG6okNCn+l28e6T4z
	 GthiHE/dLGlEGUZvssb2hll/X68JgTbgkPNlmxsDm/VqfyQtQuWxhL133dqw4pnFJy
	 kM/uAXQzQntJEpXvA2z5wAAFFW5D/qFKVxXmgl/ECL6ocKzKWzT0GQIi9euMp9/j15
	 rrW0qCgV/Sijw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI48e362102555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 12:08:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 12:08:40 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 12:08:40 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v3 0/4] Correcting switch hardware versions and reported speeds
Date: Mon, 18 Nov 2024 12:08:24 +0800
Message-ID: <20241118040828.454861-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

This patch set mainly involves correcting switch hardware versions and
reported speeds.
Details are as follows:
1. Refactor the rtase_check_mac_version_valid() function.
2. Correct the speed for RTL907XD-V1
3. Corrects error handling of the rtase_check_mac_version_valid()
4. Add defines for hardware version id

v1 -> v2:
- Add Fixes: tag.
- Add defines for hardware version id.
- Modify the error message for an invalid hardware version ID.

v2 -> v3:
- Remove the patch "Add support for RTL907XD-VA PCIe port".

Justin Lai (4):
  rtase: Refactor the rtase_check_mac_version_valid() function
  rtase: Correct the speed for RTL907XD-V1
  rtase: Corrects error handling of the rtase_check_mac_version_valid()
  rtase: Add defines for hardware version id

 drivers/net/ethernet/realtek/rtase/rtase.h    |  7 ++-
 .../net/ethernet/realtek/rtase/rtase_main.c   | 43 +++++++++++++------
 2 files changed, 36 insertions(+), 14 deletions(-)

-- 
2.34.1


