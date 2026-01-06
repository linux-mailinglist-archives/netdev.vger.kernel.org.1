Return-Path: <netdev+bounces-247323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A88CF7528
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 09:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F355E30DE5AF
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 08:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA330CD9E;
	Tue,  6 Jan 2026 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="XfttRoGb"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70230BBBD;
	Tue,  6 Jan 2026 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767688273; cv=none; b=dmBF1QVYpD+V3h2VEOl2RDQktXn8Mm76BaSjsriRMSwyzSOteTlviwRLH79PdNvvAcVUxF+zIUVxBc0qEKFkrjsDtJT08k5vxWQiulGl0GHvEcrD2LJw1x9Q/G43u6bSRKGsZN/dcZXegjPpmz8zNGt56mXCXpii8QMKK8Mz2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767688273; c=relaxed/simple;
	bh=7bGxxODUayhFpFH7ufFTYiYf88UtsbWD3WqeYGG1Ask=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8/9b+X71+SWFneAOGC65C+S7UXx5t3ANxe6oqF5AhFWWMl+xNBW2R/UJs0/XgKk+yHV5SXvUKT8NVMJx1QzDpL+P7ovp9oVA3eit5ehgJ/fhdTsEqd1ziLUJkytQPKLGlts+1sE52awaCaz/BY1kEhHESgVEJDoS0LSDFt/Caw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=XfttRoGb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6068UUAp8438982, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1767688231;
	bh=7g87re8t4MshgafsWCmjGFNSoUEW5ANnTwm1h447a7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XfttRoGb9Xg0pWsdHxbutfanvJOv6q4dIl3MA/dyvyAcjbdKOsafwrcWlNhqEzWOV
	 NphymtUJlvv8qHlCl0yhznpoU/gzIO+UJ2S9i2M7Xn+DyQoTdFEhVVzD51Ex4ScxXF
	 VEIq7jV76vAOk2h6ut1QH1+eeyTyzhJlB0YM+nXmn3NFug3KvOEVRgaBgfTVyWYGHp
	 XXdAAb9QZVKdc+fVoNZF6BjicygQ0jx10gZ3zVXS+d6K1dQPnGId6CB6JyuOvYaEEd
	 1PUxXkGGYctTSZzz/S29C8lDvqhL3RUpHnE+9S0HhGXmiEi3vDUiuxuOujLRje4T9x
	 j19gML4gAaNjg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6068UUAp8438982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Jan 2026 16:30:31 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 6 Jan 2026 16:30:30 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 6 Jan 2026 16:30:30 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next 1/2] r8169: add DASH support for RTL8127AP
Date: Tue, 6 Jan 2026 16:30:11 +0800
Message-ID: <20260106083012.164-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260106083012.164-1-javen_xu@realsil.com.cn>
References: <20260106083012.164-1-javen_xu@realsil.com.cn>
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


