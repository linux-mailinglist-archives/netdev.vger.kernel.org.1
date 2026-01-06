Return-Path: <netdev+bounces-247321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B78CF751F
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 09:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 716D3309954A
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 08:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18282BB1D;
	Tue,  6 Jan 2026 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="miaC7nzf"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92B308F07;
	Tue,  6 Jan 2026 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767688270; cv=none; b=cF/sPl591yyPqWp80VazRmeEDVafh//5PJ1VxYJ5RHc+EuenZQRIJqmyJkjdqqi4lFWeSdTfR6Jj5s9wAyoF2TE89wv+9X0wjzJJOFnx/Q/7YyPcb2E+lBFZYk9/NVaUw2Q0KiZeseaopd7/FMCoGL3CclmscOSAnKeHM/nrXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767688270; c=relaxed/simple;
	bh=YwdknpfxRtXxMbFu3DPmeeUbBuxaSXsoUtHvKlcrPrY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lFZeYUuy+UtS21oZGU6Q3KuOe1hVPo658BXnu5MuET+ndJhFW2nz/0Lsg6I4vxo1ZvC0wGizEoENF08OZTQIkSTJmG72/UJD0cBR/wgeykHvzL9xmTM/DZlXueI3gxtF7HhithWBrph/AS1aTvBdhzD6a8fVGMc+mv0jMxEznYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=miaC7nzf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6068UPEG0438956, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1767688226;
	bh=oZuOgxs1dvnRd9pTzNGyu/BsE5XtqxNNHyfwvuclAic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=miaC7nzfYJ3JqSGyJx/xbU5FCCwWi3Js3/SxesedJ51zjDfRV+5zYUy+7OjCzcltk
	 nMFdkoUs40KYI3MMefmqjcTwbsAlu1rX4C0sNsEtJQHb/Q2SysV6npkg6f0kCaC8CL
	 iyGi9LMJ+A1GKvzlXrK/Fom7RWxL7N3BJKsJ8WabQ7XCziDHUPmUZgILzIiXfw0FIU
	 YVrLcpwagHAvXuLDPeQliElL9SC83+v/7PkxR9uBEXWtNmXfIBHOdvtOP14Lm5bmue
	 OoDqBqQhfPQvj0EgxrrgYgfAATsRb2B46l7hdlaNyeOXmijGQJL0+xtywUJrMKD16O
	 e4uIVWXQZjbVw==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6068UPEG0438956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Jan 2026 16:30:26 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 6 Jan 2026 16:30:25 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 6 Jan 2026 16:30:25 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next 0/2] r8169: add dash and LTR support
Date: Tue, 6 Jan 2026 16:30:10 +0800
Message-ID: <20260106083012.164-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This series patch adds dash support for RTL8127AP and LTR support for
RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127.

Javen Xu (2):
  r8169: add DASH support for RTL8127AP
  r8169: enable LTR support

 drivers/net/ethernet/realtek/r8169_main.c | 102 ++++++++++++++++++++++
 1 file changed, 102 insertions(+)

-- 
2.43.0


