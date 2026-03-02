Return-Path: <netdev+bounces-262523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMp4En8vpWkZ5QUAu9opvQ
	(envelope-from <netdev+bounces-262523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:34:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A7D1D37D8
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C7773030EC4
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 06:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01F2328616;
	Mon,  2 Mar 2026 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="w5pFi7YW"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64C430BAC;
	Mon,  2 Mar 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772433184; cv=none; b=i6XX0wAYmmhbLOWdAnw2XwfHTx3I411tm1vd/JAD+kweCgu0VJHVAAlp7OugGDdkWXCyHXWwiNjN7h5WYrUzI2GkfS5Mhq84w7KATvwPOqP9JI6eKF1y37NzJzlNcxjDKmSsded3fF7X3lWZL21asXSQ6bpv73aYdXnEzLKbHWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772433184; c=relaxed/simple;
	bh=QY/yBHcbyE+BX8N8npu0WQnoaNx6ROcCqLwZsh7C5vI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OswNlDz6pWKLFt1RLgCopyguVEzCyswIl1tvZ5vi23M/rRoj8C236WBZs4f758xKhBAuhLJYkTPKG/fTiltz+QmbSIyohh0lzostz+4Fu/s/W1gRoA9+uGa36+pm0k4yhcCIADSAHsjpxPCfgrdI1Ir3GxA3XWUEMkpGN+jYqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=w5pFi7YW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6226WWvpC2520774, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1772433152;
	bh=b7+Sppr22ISpwXZ1gUoe2uKBFl3jh9IbKdbre7frfKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=w5pFi7YWMEG/YXtocKws8UxXYbL04LOdX/zjE/jW+9bBEAJvRD5/d+fYfDdro/fB4
	 WILMJHBV1kz9FuJ9FnAX5CQDTU5cv6hG+xeMokWdpqoXXDW3YR4vm8fi3K5k1cR9/j
	 a7OwsiNye4FOPm3FuFBryM/CkHZA8LobxAA5cR7TYiaLEOx8FPBn/XCqtXzaicdxVA
	 b5URa5nnAN3WmfwSB+4TU8imNuMJvBZQQi4T8mORP3B4wKoA6Wpn0ktQpJsxCFIFt7
	 aAorRk3NOUBsAXWweFSPchz2lBMYr5sDf5TAE8MDbe0CgEWJtkQC3ztIQbbWqpVzKe
	 MMSuyINu4HGJw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6226WWvpC2520774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Mar 2026 14:32:32 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 2 Mar 2026 14:32:32 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 2 Mar 2026 14:32:32 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 3/4] r8169: move DECLARE_RTL_COND()
Date: Mon, 2 Mar 2026 14:32:13 +0800
Message-ID: <20260302063215.1790-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260302063215.1790-1-javen_xu@realsil.com.cn>
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-262523-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:email]
X-Rspamd-Queue-Id: B4A7D1D37D8
X-Rspamd-Action: no action

From: Javen Xu <javen_xu@realsil.com.cn>

There is no functional change. Moving DECLARE_RTL_COND() for the next
patch 4/4.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index a5c0d3995328..787859b0ab68 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1052,6 +1052,11 @@ DECLARE_RTL_COND(rtl_eriar_cond)
 	return RTL_R32(tp, ERIAR) & ERIAR_FLAG;
 }
 
+DECLARE_RTL_COND(rtl_csiar_cond)
+{
+	return RTL_R32(tp, CSIAR) & CSIAR_FLAG;
+}
+
 static void _rtl_eri_write(struct rtl8169_private *tp, int addr, u32 mask,
 			   u32 val, int type)
 {
@@ -2927,11 +2932,6 @@ static void rtl_set_rx_mode(struct net_device *dev)
 	RTL_W32(tp, RxConfig, (tmp & ~RX_CONFIG_ACCEPT_OK_MASK) | rx_mode);
 }
 
-DECLARE_RTL_COND(rtl_csiar_cond)
-{
-	return RTL_R32(tp, CSIAR) & CSIAR_FLAG;
-}
-
 static void rtl_csi_write(struct rtl8169_private *tp, int addr, int value)
 {
 	u32 func = PCI_FUNC(tp->pci_dev->devfn);
-- 
2.43.0


