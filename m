Return-Path: <netdev+bounces-248375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2372CD07800
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30AFB3017129
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054872EA48F;
	Fri,  9 Jan 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="Wpaw6G7/"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522872BEFE7;
	Fri,  9 Jan 2026 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767942282; cv=none; b=gtYJXwCrHrkBiAAY3kH877EWMjYGhRvG6OP74b8MU0JDhqcRgb0VbF5id/wb7+gfPIm0lC0ocQGcx8mkLWsPPUJ6oAogEJ4+Kz7zbaNNh/MeCkgMzKWsu0/EJtEXKmth29lqVx0OYiTz45xjR1R4UT1sOhDOjaj8hbMiB/9AKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767942282; c=relaxed/simple;
	bh=7bGxxODUayhFpFH7ufFTYiYf88UtsbWD3WqeYGG1Ask=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIA7oqbNwtG3KZtGmqKJ/M/8CCru4pnV4/6gbz6nUw3EtSg0QDN2AJ8dmx++hjiJfZGhrn5EzybFpghaN2dEsIXwIeLlJ5evOcqJZuomxLPbJkUZy+OkfQdoRO5VzropaxBwrsVXrBjMk2mqfTIAHXEYssrDpllPpi17PrgO8yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Wpaw6G7/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60974H2N02723801, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1767942257;
	bh=7g87re8t4MshgafsWCmjGFNSoUEW5ANnTwm1h447a7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Wpaw6G7/otS9Fgz9vpxITPfyICw/4PnDO9hfnMhtijsdQsYa/rJQfQojbPUPtwDSN
	 nb6NygYCkkgoaMQmMI+J9U//zz9isWJvPB8yk8M7WGUFEmSziBcXgthKi3vsbbmpW+
	 Xse25eHz+ALrhG1PoFXA6oviMBlGT5HQcyYltTdzts8+jTABfy9BozzGYW506LhBph
	 VXHW1njCEfoNzR3w/4xHtDHdIHmUJ8rVSHqkMzg/F3EaCdyX9WIlg6OA4pZh9nMbNF
	 vlWShU6hf2tow3jOL4GsfUTufj5fzXg2p6d/4zSDpwFeukk5DgaUbhnalCh79cG8C0
	 n2l3n2yDAxYIg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60974H2N02723801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Jan 2026 15:04:17 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 9 Jan 2026 15:04:17 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 9 Jan 2026 15:04:17 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v4 1/2] r8169: add DASH support for RTL8127AP
Date: Fri, 9 Jan 2026 15:04:14 +0800
Message-ID: <20260109070415.1115-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260109070415.1115-1-javen_xu@realsil.com.cn>
References: <20260109070415.1115-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This adds DASH support for chip RTL8127AP. Its mac version is
RTL_GIGA_MAC_VER_80 and revision id is 0x04. DASH is a standard for
remote management of network device, allowing out-of-band control.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 755083852eef..f9df6aadacce 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1513,6 +1513,10 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 		return RTL_DASH_EP;
 	case RTL_GIGA_MAC_VER_66:
 		return RTL_DASH_25_BP;
+	case RTL_GIGA_MAC_VER_80:
+		return (tp->pci_dev->revision == 0x04)
+			? RTL_DASH_25_BP
+			: RTL_DASH_NONE;
 	default:
 		return RTL_DASH_NONE;
 	}
-- 
2.43.0


