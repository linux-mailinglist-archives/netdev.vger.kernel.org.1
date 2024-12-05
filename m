Return-Path: <netdev+bounces-149404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296A29E57F3
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826401884179
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56936218EBA;
	Thu,  5 Dec 2024 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O0HsD87X"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E155219A9A;
	Thu,  5 Dec 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406943; cv=none; b=D/hJnBVb4jFDPYU4XDO6IhvaFXsEpqVDZ50Q4p7HYgxj9toqvGLR/Otr/GBi0x9AFoGsDhDQM0dtRiEkaNEpC2nsp0PcZ35l/IF9SD/fVzZ7FF8Bs2BmyfA4zsIUmyiON68VHLvFjSyybAnbVBWkcz7B3+gT5WhdncTRsFlMaqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406943; c=relaxed/simple;
	bh=PGYbsklcZxbQKe46gCtSJ/T9MPciNf2YV+Mvvz1GowY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nDBG7JWp/psj3ra7VoOBYwTS8rxNIJVAt+nSu6QJTY3/mF82BrhaeGunWBkaTsNjbYMyGMF1uKCCKe0B1bOr2rhe0expdzuzaIpFIh4jwlg39VX3/PEuDfG7ZB3P7nU6OLTIw0wBlOxDCEPIlcyfOtaG5c05SdqdqFDuPZg8qis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O0HsD87X; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733406941; x=1764942941;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PGYbsklcZxbQKe46gCtSJ/T9MPciNf2YV+Mvvz1GowY=;
  b=O0HsD87XFlR+ycE0TS1/EDL0m6F739Sn5xGtntf2RPwMzhi+0AD9FMAv
   aDW3D3VO1MA3nrjemOTFrcMTkBQAFWsboq+3HxWn5RHV2ZNnKXSXzRIjQ
   g5qNW6TQPXg/0pLub1cFF6R+w1RMLGznAFFJwwvXhqHz2hTY1XVyG7OMK
   0KexHOGxLQUPuQcq3umIvf1iDLmfwd8A1bEkLO8meud/IPSi9A+DOkmNL
   fIIlwBPVv7vZujI9uNdTp9QF6c+Kr4oxeZVLUsNQLyMq+xVQpBTVufXpB
   6SynNWTBzek1vYhP76Mx6pcIS8VMpUPp/IodYNhZdr4SrRFGosNmmtWQp
   Q==;
X-CSE-ConnectionGUID: 7ioOcpSzQfuJnUZ0WQ6I1Q==
X-CSE-MsgGUID: qF9MfwCwSdCrE3fz2fX5Pw==
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="34869386"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2024 06:55:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Dec 2024 06:55:26 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 5 Dec 2024 06:55:22 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Dec 2024 14:54:25 +0100
Subject: [PATCH net 2/5] net: lan969x: fix the use of spin_lock in PTP
 handler
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241205-sparx5-lan969x-misc-fixes-v1-2-575ff3d0b022@microchip.com>
References: <20241205-sparx5-lan969x-misc-fixes-v1-0-575ff3d0b022@microchip.com>
In-Reply-To: <20241205-sparx5-lan969x-misc-fixes-v1-0-575ff3d0b022@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <horatiu.vultur@microchip.com>,
	<arnd@arndb.de>, <jacob.e.keller@intel.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: Calvin Owens <calvin@wbinvd.org>, Muhammad Usama Anjum
	<Usama.Anjum@collabora.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

We are mixing the use of spin_lock() and spin_lock_irqsave() functions
in the PTP handler of lan969x. Fix this by correctly using the _irqsave
variants.

Fixes: 24fe83541755 ("net: lan969x: add PTP handler function")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

[1]: https://lore.kernel.org/netdev/20241024-sparx5-lan969x-switch-driver-2-v2-10-a0b5fae88a0f@microchip.com/
---
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
index 67463d41d10e..c2afa2176b08 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
@@ -273,9 +273,9 @@ static irqreturn_t lan969x_ptp_irq_handler(int irq, void *args)
 		if (WARN_ON(!skb_match))
 			continue;
 
-		spin_lock(&sparx5->ptp_ts_id_lock);
+		spin_lock_irqsave(&sparx5->ptp_ts_id_lock, flags);
 		sparx5->ptp_skbs--;
-		spin_unlock(&sparx5->ptp_ts_id_lock);
+		spin_unlock_irqrestore(&sparx5->ptp_ts_id_lock, flags);
 
 		/* Get the h/w timestamp */
 		sparx5_get_hwtimestamp(sparx5, &ts, delay);

-- 
2.34.1


