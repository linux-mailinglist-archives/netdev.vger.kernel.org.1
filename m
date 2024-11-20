Return-Path: <netdev+bounces-146510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DE49D3CD0
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5BB1F23916
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8501AB6DA;
	Wed, 20 Nov 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A5JSmcLZ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01301AB53F;
	Wed, 20 Nov 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110773; cv=none; b=CxAIakwxMeJabIneus0r8ec/HTHwJak6w+cYOif3e1K4ZINzvnnH8tVv/HSLLO0V47JAoSbZ+AVKFtTMpNp2lLfxdFIFSjbD56WssXpUxLQVQ952c4NE9FsIHyasdpZj/iiEjCwP9ZC+vTq753HidV2PNBBytoyljJeHDy9Ynlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110773; c=relaxed/simple;
	bh=i7qRZuNcWTSiRas3p8j2IWgtJskY82Y1dAnmsyj+57g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiTGj8kD1yPAEzHvR9+VscPo278pAiQdpfdItid/ed4J5o0iM4c0FTattKc+dAkL4IUQIflow7ktBziw08KSMVEzt5O8E8hbdqj2sf+VQtwZQ/k2h84lXVwaWlCQGKSA5TDhyC7oXem9WY10fxoXuEBwkfez/CYp3Zh331h60r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A5JSmcLZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732110771; x=1763646771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i7qRZuNcWTSiRas3p8j2IWgtJskY82Y1dAnmsyj+57g=;
  b=A5JSmcLZHw7tOwu9rNr47aF+qEQTfzfEbYcckzYa2sasKDMdlddJBcSV
   hc4NdrcGVXFzlp+5hqE5THbnSVudXkEGBiBsgsgIu8sZRP21t2bAHfVOv
   jP7Q326B6+T4qvAz8jRJGRBmwZSPS+R59Lsf+WuXQkNTXO6Ic/vRueL1X
   N0hTyC0HNqTzq6UTnNMd0Z6vYzKNUfmIM3EgCuVc8PR+B7CA9FJzPT3CM
   +bVjS+WqfsuQRtCjRrLupAZSfiItSvnaUT9ulDBnszQd0VDGVdVYvgi1X
   GQ5IfvN/6lBsH7ggfFDL8O1OAzCcHihfUfEhuXN+Vq4piJAl9+vK+MogL
   g==;
X-CSE-ConnectionGUID: NYHd7BvaR3u+JsyGy7qN4A==
X-CSE-MsgGUID: /tgqWmmYS22xq3wZC6F1lA==
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="265723883"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2024 06:52:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Nov 2024 06:52:17 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 20 Nov 2024 06:52:07 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>
Subject: [PATCH net 2/2] net: ethernet: oa_tc6: fix tx skb race condition between reference pointers
Date: Wed, 20 Nov 2024 19:21:42 +0530
Message-ID: <20241120135142.586845-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120135142.586845-1-parthiban.veerasooran@microchip.com>
References: <20241120135142.586845-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There are two skb pointers to manage tx skb's enqueued from n/w stack.
waiting_tx_skb pointer points to the tx skb which needs to be processed
and ongoing_tx_skb pointer points to the tx skb which is being processed.

SPI thread prepares the tx data chunks from the tx skb pointed by the
ongoing_tx_skb pointer. When the tx skb pointed by the ongoing_tx_skb is
processed, the tx skb pointed by the waiting_tx_skb is assigned to
ongoing_tx_skb and the waiting_tx_skb pointer is assigned with NULL.
Whenever there is a new tx skb from n/w stack, it will be assigned to
waiting_tx_skb pointer if it is NULL. Enqueuing and processing of a tx skb
handled in two different threads.

Consider a scenario where the SPI thread processed an ongoing_tx_skb and
it assigns next tx skb from waiting_tx_skb pointer to ongoing_tx_skb
pointer without doing any NULL check. At this time, if the waiting_tx_skb
pointer is NULL then ongoing_tx_skb pointer is also assigned with NULL.
After that, if a new tx skb is assigned to waiting_tx_skb pointer by the
n/w stack and there is a chance to overwrite the tx skb pointer with NULL
in the SPI thread. Finally one of the tx skb will be left as unhandled,
resulting packet missing and memory leak.

To overcome the above issue, check waiting_tx_skb pointer is not NULL
along with ongoing_tx_skb pointer's NULL check before proceeding to assign
the tx skb from waiting_tx_skb pointer to ongoing_tx_skb pointer.

Fixes: 53fbde8ab21e ("net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 4c8b0ca922b7..e1e7c6e07966 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -1003,7 +1003,7 @@ static u16 oa_tc6_prepare_spi_tx_buf_for_tx_skbs(struct oa_tc6 *tc6)
 	 */
 	for (used_tx_credits = 0; used_tx_credits < tc6->tx_credits;
 	     used_tx_credits++) {
-		if (!tc6->ongoing_tx_skb) {
+		if (!tc6->ongoing_tx_skb && tc6->waiting_tx_skb) {
 			tc6->ongoing_tx_skb = tc6->waiting_tx_skb;
 			tc6->waiting_tx_skb = NULL;
 		}
-- 
2.34.1


