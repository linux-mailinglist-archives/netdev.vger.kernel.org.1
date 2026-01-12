Return-Path: <netdev+bounces-248870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F3AD10619
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C90B1309306E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 02:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8273090EE;
	Mon, 12 Jan 2026 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="haOItRVo"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE371A9F84;
	Mon, 12 Jan 2026 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768185992; cv=none; b=BGGEQ/EFdgZn4V/Q2lS+V2DEAnHqXagPaONMCP1l0WQAK55kL/Rz7W6ycsrFqPCqFdj3Kc6mNjekkdR736UFnAHmZk7rQ9DJViJ4iMlIAzMVtyz7xDnMoh0WCxJ/OJyqC60aJI6jALiUXUsNtJHtGz72Uj+kckQgUZIriErILo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768185992; c=relaxed/simple;
	bh=7bGxxODUayhFpFH7ufFTYiYf88UtsbWD3WqeYGG1Ask=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9VZTU2am7mfq1gXa1myQH8qmPF9Fy9ezXND7KDVu+7tluwQkf7nhIoxeeO1bU3wSSmzu5Km7GbFjmxZuwQaqPXUMYEiqu3KGAXxh71K2yUDvfFSK2xy4A/IZmT9V5T9+Ijz/k9nCbE94S1snfrc55WXo2n4i2DHP2cALDqitYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=haOItRVo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60C2jhCY34128682, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1768185943;
	bh=7g87re8t4MshgafsWCmjGFNSoUEW5ANnTwm1h447a7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=haOItRVox9cn5Snz8dM/rQ3FKPsDcInx8EYNYG/Y5NfVYqXQnJdRSqM7IY4XnDUut
	 UALYBGpWPct0o32RH3MOkiVmWFvjy6OIPUTabA28cP8ZDWYEIbF5EV6nP5JAJonr41
	 xyGuFlnnNKTn+zfl5J0f2Hg+fREyY7r08EzSqy8Nw34S/+idN/ZgQSQox10z+zJ0rq
	 LzogqDLjQfWZ53Rwy4xOGrhtVrhK09fexagLntrqQ0d3hCTHuUcoCSb67LnIgaEBWt
	 zg+sA9nawYLvdXdzZSlrLXMcoZQ8Z06xxuqA4eo0fMK0GmJlWlN4M2xODRjihtrPgD
	 /vXvQADt7UbKw==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60C2jhCY34128682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Jan 2026 10:45:43 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 12 Jan 2026 10:45:43 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 12 Jan 2026 10:45:43 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 1/3] r8169: add DASH support for RTL8127AP
Date: Mon, 12 Jan 2026 10:45:39 +0800
Message-ID: <20260112024541.1847-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260112024541.1847-1-javen_xu@realsil.com.cn>
References: <20260112024541.1847-1-javen_xu@realsil.com.cn>
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


