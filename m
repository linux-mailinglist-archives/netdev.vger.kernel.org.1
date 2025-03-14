Return-Path: <netdev+bounces-174810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E11C6A60A2A
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 08:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB633189B347
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 07:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D448A186E56;
	Fri, 14 Mar 2025 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DxMsLu96"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10604158870;
	Fri, 14 Mar 2025 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938119; cv=none; b=UFAt8xBvbSB5DNBjsTOiK/sP3b684HW6OsxI8tBWEuIOQggGzzfxN9epA1ywR8hcpX+jDFoZ5DRn+vkuo3Ic0MHwKgQrjj6B6mtlwoLskyhh3Uyk80E7LHfSHDoKhfrU0xTBDBkYjaf4fsylZDeMeft38o5U1Jz3YmgN3qZNEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938119; c=relaxed/simple;
	bh=KJeojQ6lr9L3jbzA7XJUUNU5rNHf03mXs3rQI8LO/Hw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JhXojDJdT9OxwcswC2ihfouz3pOk4PRtp7N+lsvWeDkKoCmtdU+dRHsSqDDOje6XzL2wrvfwSrszsT3rBrvk/UxfcpgOSxq1iiJbAFt1jB2nM12mzP+ropg0lnckOP3TbLRiQXvXJS4rg2Vo2JLpQPvIihVONVxwBblWeamFkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DxMsLu96; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52E7faTI32708338, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741938096; bh=KJeojQ6lr9L3jbzA7XJUUNU5rNHf03mXs3rQI8LO/Hw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=DxMsLu96lp1hj97AKk1QsXrgxDSqMmEysRRRV5H5OdhHVgWcfYZcjnax6VwHpBUPa
	 0chf/qM4CqqWhGrPTbqetoAkDYay3/iVcfLP1doQYoJvkx2j4fXqPKauIIxDue5svY
	 rFo9zdWsl9YnyXrtmycc4jwP4qqSSyCbzJGu2vieyKHvzZDykJEyT2vNG85xPq2o1C
	 /m3HJZcJJ4v8u6DWh2SdkfnQ+48V48XWgGDzIF3O/zycG5WjzndzvAm0eafstaNRi1
	 LlvyfJZGAtKioi9hcI3equmn5raOwXH8meNf7osYzWW1HFVv0VBUgWF4byjxL9jKC1
	 Zq9OFKAawz8KQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52E7faTI32708338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Mar 2025 15:41:36 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 14 Mar 2025 15:41:34 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Mar 2025 15:41:34 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next 0/2] r8169: enable more devices ASPM, LTR support
Date: Fri, 14 Mar 2025 15:41:27 +0800
Message-ID: <20250314074129.2682-1-hau@realtek.com>
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


