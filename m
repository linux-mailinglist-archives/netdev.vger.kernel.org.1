Return-Path: <netdev+bounces-229295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 496BDBDA60D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 548B6502EC2
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9F02FFFBE;
	Tue, 14 Oct 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sZKWoSnr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8812FFDF9;
	Tue, 14 Oct 2025 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455544; cv=none; b=UxmRma1nqIrNkU8Yj0U4fZmblInoplg//I3+39uPaYKkKIeZl6WjBRXTCpB4JM/n/fEkXb08ULgJ4ZHb1jq/YW/kOCTuzxUQ423u1nxc1gpTUd8uJ1g46tDmgeRVs/VTkJzGKaPIwUk3n+X2usKtxPtGqzKw0fqNkCQ7wTJuhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455544; c=relaxed/simple;
	bh=krvauSEhJ1khgpbOy1S/5kMw6skc96mbQJbK77h4jIc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EofC3Ia2I81jXqGhsQfLZuj52aDcq4nBgL7DaSyC1+qLDNZsX30XBDJiqjaWuKYtt4HkOFoDzAsqdOtQuZjcd6It+X3bb7Ap0tKeRx5XfFfLPAxMMlUMVo9o0lJOccBuBd+x1UiJ8dobEwEu9E3TymMSwinJvddIjGmuJMV9Uro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sZKWoSnr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5C832C09F95;
	Tue, 14 Oct 2025 15:25:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 537DE606EC;
	Tue, 14 Oct 2025 15:25:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FDB8102F226E;
	Tue, 14 Oct 2025 17:25:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455538; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=8btb3cYWBCi2fD6kO9Qe/Zw0nyJJHpRTiZ2PSM3h1jo=;
	b=sZKWoSnrDq4Y2e3rUgqskKukJEB+clPsD6+pUzG934MwjHnqCwDrYRENiH/cLmi4tMAyE/
	eF/IxBktLq+/PJXyfcaH8XCqPYdQ+AYFiuqjjcSyD8LqQWvqH3NLMIP5Ls3uGZEOkWx5O0
	74Uxb3NV9iv1Frb8QURozRVPvCx78CDI4gTg/rNjCE5dN2OymAtMMvK+n3iwyaL+OuvRZq
	UBlcmWJDR8w2fgzzRGRMzQD5uXdSu3x31cXDmrD1VPe9wpASfFcr8BGS/v4PcNIPALXn0x
	/6gxX4xo0Igy7vB2JfLtN+hWstQxRtZeNg1uGmC/Jil7l6jbbXCWuKK5zPknrw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next 00/15] net: macb: various cleanups
Date: Tue, 14 Oct 2025 17:25:01 +0200
Message-Id: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE1r7mgC/x3MQQqDMBBG4avIrDtgQm2LV5EukvG3HaijJFoE8
 e4Gl9/ivZ0ykiJTW+2U8NeskxW4W0XyDfYBa19MvvaNq92dxyCR5Ydg68xe8Iyv6CDNg0oyJwy
 6XbuODAsbtoXex3ECPD1YEWgAAAA=
X-Change-ID: 20251014-macb-cleanup-2ce7b8b1ec56
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Andrew Lunn <andrew@lunn.ch>, Sean Anderson <sean.anderson@linux.dev>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Fix many oddities inside the MACB driver. They accumulated in my
work-in-progress branch while working on MACB/GEM EyeQ5 support.

Part of this series has been seen on the lkml in March then June.
See below for a semblance of a changelog.

The initial goal was to post them alongside EyeQ5 support, but that
makes for too big of a series. It'll come afterwards, with new
features (interrupt coalescing, ethtool .set_channels() and XDP mostly).

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20250627-macb-v2-0-ff8207d0bb77@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes since June V2:
 - Six patches are straight copies:
   dt-bindings: net: cdns,macb: sort compatibles
   net: macb: use BIT() macro for capability definitions
   net: macb: Remove local variables clk_init and init in macb_probe()
   net: macb: drop macb_config NULL checking
   net: macb: introduce DMA descriptor helpers (is 64bit? is PTP?)
   net: macb: sort #includes
 - The "introduce DMA descriptor helpers" patch was split in two:
   net: macb: simplify macb_dma_desc_get_size()
   net: macb: introduce DMA descriptor helpers (is 64bit? is PTP?)
 - Three patches come from Sean's feedback:
   net: macb: remove gap in MACB_CAPS_* flags
   net: macb: simplify macb_adj_dma_desc_idx()
   net: macb: move bp->hw_dma_cap flags to bp->caps
 - Take 1x Reviewed-by: Krzysztof Kozlowski
 - Take 3x Reviewed-by: Sean Anderson
 - Link: https://lore.kernel.org/lkml/20250627-macb-v2-0-ff8207d0bb77@bootlin.com/

---
Théo Lebrun (15):
      dt-bindings: net: cdns,macb: sort compatibles
      net: macb: use BIT() macro for capability definitions
      net: macb: remove gap in MACB_CAPS_* flags
      net: macb: Remove local variables clk_init and init in macb_probe()
      net: macb: drop macb_config NULL checking
      net: macb: simplify macb_dma_desc_get_size()
      net: macb: simplify macb_adj_dma_desc_idx()
      net: macb: move bp->hw_dma_cap flags to bp->caps
      net: macb: introduce DMA descriptor helpers (is 64bit? is PTP?)
      net: macb: remove bp->queue_mask
      net: macb: replace min() with umin() calls
      net: macb: drop `entry` local variable in macb_tx_map()
      net: macb: drop `count` local variable in macb_tx_map()
      net: macb: apply reverse christmas tree in macb_tx_map()
      net: macb: sort #includes

 .../devicetree/bindings/net/cdns,macb.yaml         |   8 +-
 drivers/net/ethernet/cadence/macb.h                |  71 +++---
 drivers/net/ethernet/cadence/macb_main.c           | 257 +++++++++------------
 drivers/net/ethernet/cadence/macb_ptp.c            |  16 +-
 4 files changed, 151 insertions(+), 201 deletions(-)
---
base-commit: 6a445aebc188bdb9a82519c5fe64eb92b1d025b9
change-id: 20251014-macb-cleanup-2ce7b8b1ec56

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


