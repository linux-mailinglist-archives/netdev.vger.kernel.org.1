Return-Path: <netdev+bounces-271903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH4rDObixGnz4gQAu9opvQ
	(envelope-from <netdev+bounces-271903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:40:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DF13308B0
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22CB3301A31B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123543B19A1;
	Thu, 26 Mar 2026 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="flLHb/rT"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F137B3F9;
	Thu, 26 Mar 2026 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774510810; cv=none; b=lzkBwwqSJoI4tsQk/je+TpR7H2yjtdD5tCiAEwR26SASpRsV87Nn0XbLO7c5FsfX+Tyg/NMFff6RLqtTsmToT746X4msv2g8JT4wEcp9CfIKtPM+s30vUq54BiX9vCTECWIrw4pHolygJ0Fg6WWwNNkePzenUzfktso/HtMXIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774510810; c=relaxed/simple;
	bh=EvM7NQx5GjHWorWcY08ZjKEINGW3WusH6PLz+Tn+ASo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iELAlXn2tP3teQ0Za6A116D1F5vM2YzbneSPy7T+VXoaemp3Yi6o40KlWB5w4qq2QLV0ALLoydePefH8ooN/FtCaNz0nYaQtFlMRL69q8TQ0jgRcLtFpkmdf8kyLGwV3mqX2WnMMuR0Zf779s6ahZXh9cU+zolYP7Cas6P/BqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=flLHb/rT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62Q7dYeA51073983, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774510774; bh=PgmCrJ+9O3Y+5rUuYewSMg060W75OZyNCU653i4Ir5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=flLHb/rTMF/ong+kSJxqeNF4v8gsOmpTQrUU+fj9NE9OXZ/j1eodVCbfqp42dTDIc
	 PlUE/7UtXW507q4ihQ76H+6Lp3agG5kB5QGLN2ZVuTNpJmnssvFJI/gQA16UpQyu3u
	 FJql5U4Qee+d4Fm7ay8CSYkM4DXUVOUnNpcNnu4EzGiHKBqWoslxyaZusvDAGlx2Q5
	 E2ieY9AIAF1IJohLhSOD89GNnvzQNSzfGZ3urqb3qgJh8VUhIkoLx+hW1Thh3IMH0r
	 kE5HzZcRBuEMqvAWO7vpAz+Bodj15hReBUwiAQImuQppmMTcdmIzpU8fFqQCOZnRR6
	 UhYe9AJV/EfYA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62Q7dYeA51073983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 15:39:34 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Mar 2026 15:39:34 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Mar 2026 15:39:34 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Thu, 26 Mar 2026 15:39:34 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
        Chih Kai Hsu
	<hsu.chih.kai@realtek.com>
Subject: [PATCH net-next v4 1/3] r8152: fix incorrect register write to USB_UPHY_XTAL
Date: Thu, 26 Mar 2026 15:39:23 +0800
Message-ID: <20260326073925.32976-454-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326073925.32976-453-nic_swsd@realtek.com>
References: <20260326073925.32976-453-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hsu.chih.kai@realtek.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271903-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B5DF13308B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The old code used ocp_write_byte() to clear the OOBS_POLLING bit
(BIT(8)) in the USB_UPHY_XTAL register, but this doesn't correctly
clear a bit in the upper byte of the 16-bit register.

Fix this by using ocp_write_word() instead.

Fixes: 195aae321c82 ("r8152: support new chips")
Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 3b6d4252d34c..bef0611e7ef0 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3892,7 +3892,7 @@ static void r8156_ups_en(struct r8152 *tp, bool enable)
 		case RTL_VER_15:
 			ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_UPHY_XTAL);
 			ocp_data &= ~OOBS_POLLING;
-			ocp_write_byte(tp, MCU_TYPE_USB, USB_UPHY_XTAL, ocp_data);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_UPHY_XTAL, ocp_data);
 			break;
 		default:
 			break;
-- 
2.34.1


