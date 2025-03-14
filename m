Return-Path: <netdev+bounces-174808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFADEA60A17
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 08:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6C218989B6
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 07:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D01519B0;
	Fri, 14 Mar 2025 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="K6+c3l39"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C06E4D8D1;
	Fri, 14 Mar 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741937613; cv=none; b=DUtu5PtLQtdmJoVEnrbXFU5oqsQz63SdWZu25IxLZGWH+WZz7t5bi76GM6HdxZw5rdVGoIN8jhzd3qpO1BgGfP3GeI3NdAmX4SLxpzIDe5/59+8v7e3Xr1T9Gf1vvQgFQ087iYcBOL9APpGei4spEnpa35Ne8tkNoD6HQHbDER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741937613; c=relaxed/simple;
	bh=KJeojQ6lr9L3jbzA7XJUUNU5rNHf03mXs3rQI8LO/Hw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IUVfUU0h9As1zZz45JZ0Qay4+UoOsDyP6U0eO/17zYFnL2FKeetHPwbF6JAFiJtp83kFyGiekeRnB0EDEEYJCW6I1+cTDn90rPtPEi7bj5HWZn6r3dMdC4NxK+gay77Pvir+BFRxVcZKQrJE5SYmq+PvN0PbQQLBF6BLpk4hty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=K6+c3l39; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52E7WtKaA2697697, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741937575; bh=KJeojQ6lr9L3jbzA7XJUUNU5rNHf03mXs3rQI8LO/Hw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=K6+c3l39a+7pyGHEtF5YTLe3VjmNVJCgzi//5LK9ncFOxFyKBKzZLijX18gugzu8h
	 Yed/SMR7jfHpPpL84jfmvWvwgJfJIOJU9ZL+YO5JKT6iAKmIc0F3skYgd6jabY9J2g
	 P0o+01+Q54oc2wAAuca1vYC2e+YlYfRUtOh3NQOUwQWSD2r3+rI+GVBFrTL6NmhAGp
	 jFis/hz7Bc11d4Uck2VY1dvn6VobXH9djdiJnss2ydLG2qp78jSTEd2JOZLh66rYhI
	 kn0LeRTSIA/X/fyzigeXZAFTnL2CXGoWMpLSS8cebOiU4gorJ6xT/lqJnJNcgj0n8S
	 G+5CFFHyvzymw==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52E7WtKaA2697697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Mar 2025 15:32:55 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 14 Mar 2025 15:32:53 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Mar 2025 15:32:53 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next 0/2] r8169: enable more devices ASPM, LTR support
Date: Fri, 14 Mar 2025 15:32:37 +0800
Message-ID: <20250314073239.10656-1-hau@realtek.com>
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


