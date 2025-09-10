Return-Path: <netdev+bounces-221768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C0B51D47
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387E3189734B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E9125B687;
	Wed, 10 Sep 2025 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gyr2TIz7"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22402246796
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520989; cv=none; b=MNTivuOefN9+DtaYAd+lLk8T663EJPs5bGGylAcypCsFU4Wr3mYZNqduEu+kTFB83qwQoHWm4CuxNYf2bmZtRIW8B6I3bWNSOjlZ7o6pxWEEtk/Hg1KLCbi+UMIWGBwq1pfpzTIRraH0W653v3Q6vTcnbxONUJIMYxQ/qoKQrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520989; c=relaxed/simple;
	bh=MErv7ofNJvs2O2HyYXqdJGh01YPQd2InhldhO81ZjVI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=knuB3vLBJu1jSbv1wkH2jKupxXSvW06EGaV3E8A80THgVL3b61SZSdV0DYvmvT1yQe4W4YA2kH/V0Cq6PoWKX0rCH39H+NV5+a+HmMvfbGd18VP319nnC3N8jlAK9G/mqCcESNR5Me3pkjcTEoOKbpqTndDXOCKIu07Wgr0OZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gyr2TIz7; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 24B8B4E40BB5;
	Wed, 10 Sep 2025 16:16:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11643606D4;
	Wed, 10 Sep 2025 16:16:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7BC49102F28EB;
	Wed, 10 Sep 2025 18:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757520982; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=E0APalsRu/zy6XFrd8Z66ktVEZmFwpkka305wRfKLmY=;
	b=gyr2TIz7PJf5tUr1jy8ZxhE8/qurylPahZ3BUp+dI5+7B3FC//K/B7fflvrcCuYcN66q2+
	upMK0YCNAWowIB//uiyWZ7de/gg0EgtTwtGDQnesJaYbMZAn6Qd6K5nMvVMsS5b4EaVn94
	wbFqUspV9n+gDvTuT1Z1kjpBz7adunhrCjxCydGrMbQ5jJxybFiax5cbvuTnVeQTjxTkU9
	fJX502c091Dax5uIAJT4FNwjOZ3n9ra3XFIy1XJPc0zu2uefTmZYe5zh2v/18USEPtR5oZ
	OT0pFJd9UnLiKSgBh6kJ/mLON/XMv7ZbFLw9JJ1kHWa9YOT4P8rTeoVNXz8Paw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net v5 0/5] net: macb: various fixes
Date: Wed, 10 Sep 2025 18:15:29 +0200
Message-Id: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACGkwWgC/22NSw7CIBRFt9K8sRi+tjhyH8ZBiw9LYsFAQzQNe
 5cwsonD+zn3bpAwOkxw7jaImF1ywVehDh2YefQPJO5eNXDKFR3oQJbRTMS6NyaC3KqeImNcMqj
 AK2ILav8KHle4VXN2aQ3x0w6yaNG/rSwIJXSwzJpJsV7byxTC+nT+aMLShrL8gTndwbLCXBiht
 eSaneQeLqV8AaP8UfLoAAAA
X-Change-ID: 20250808-macb-fixes-e2f570e11241
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Fix a few disparate topics in MACB:

[PATCH net v5 0/5] net: macb: various fixes
[PATCH net v5 1/5] dt-bindings: net: cdns,macb: allow tsu_clk without tx_clk
[PATCH net v5 2/5] net: macb: remove illusion about TBQPH/RBQPH being per-queue
[PATCH net v5 3/5] net: macb: move ring size computation to functions
[PATCH net v5 4/5] net: macb: single dma_alloc_coherent() for DMA descriptors
[PATCH net v5 5/5] net: macb: avoid dealing with endianness in macb_set_hwaddr()

Patch 3/5 is a rework that simplifies patch 4/5. It is the only non-fix.

Pending series on MACB are: (1) many cleanup patches and (2) patches for
EyeQ5 support. Those will be sent targeting net-next/main once this
series lands there, aiming to minimise merge conflicts. Old version of
those patches are visible in the V2 revision [0].

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20250627-macb-v2-0-ff8207d0bb77@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v5:
- Fix hwaddr endianness patch following comment by Russell [2].
  [2]: https://lore.kernel.org/lkml/DCKQTNSCJD5Q.BKVVU59U0MU@bootlin.com/
- Take 4 Acked-by: Nicolas Ferre.
- Take Tested-by: Nicolas Ferre.
- Link to v4: https://lore.kernel.org/r/20250820-macb-fixes-v4-0-23c399429164@bootlin.com

Changes in v4:
- Drop 11 patches that are only cleanups. That includes the
  RBOF/skb_reserve() patch that, after discussion with Sean [1], has
  had its Fixes trailer dropped. "move ring size computation to
  functions" is the only non-fix patch that is kept, as it is depended
  upon by further patches. Dropped patches:
    dt-bindings: net: cdns,macb: sort compatibles
    net: macb: match skb_reserve(skb, NET_IP_ALIGN) with HW alignment
    net: macb: use BIT() macro for capability definitions
    net: macb: remove gap in MACB_CAPS_* flags
    net: macb: Remove local variables clk_init and init in macb_probe()
    net: macb: drop macb_config NULL checking
    net: macb: simplify macb_dma_desc_get_size()
    net: macb: simplify macb_adj_dma_desc_idx()
    net: macb: move bp->hw_dma_cap flags to bp->caps
    net: macb: introduce DMA descriptor helpers (is 64bit? is PTP?)
    net: macb: sort #includes
  [1]: https://lore.kernel.org/lkml/d4bead1c-697a-46d8-ba9c-64292fccb19f@linux.dev/
- Wrap code to 80 chars.
- Link to v3: https://lore.kernel.org/r/20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com

Changes in v3:
- Cover letter: drop addresses that reject emails:
  cyrille.pitchen@atmel.com
  hskinnemoen@atmel.com
  jeff@garzik.org
  rafalo@cadence.com
- dt-bindings: Take 2x Reviewed-by Krzysztof.
- dt-bindings: add Fixes trailer to "allow tsu_clk without tx_clk"
  patch, to highlight we are not introducing new behavior.
- Reorder commits; move fixes first followed by cleanup patches.
- Drop all EyeQ5 related commits.
- New commit: "remove gap in MACB_CAPS_* flags".
- New commit: "move ring size computation to functions".
- New commit: "move bp->hw_dma_cap flags to bp->caps".
- Rename introduced helpers macb_dma_is_64b() to macb_dma64() and,
  macb_dma_is_ptp() to macb_dma_ptp().
- Rename MACB_CAPS_RSC_CAPABLE -> MACB_CAPS_RSC.
- Fix commit message typos: "maxime" -> "maximise", etc.
- Take 7x Reviewed-by: Sean Anderson.
- Add details to some commit messages.
- Link to v2: https://lore.kernel.org/r/20250627-macb-v2-0-ff8207d0bb77@bootlin.com

---
Théo Lebrun (5):
      dt-bindings: net: cdns,macb: allow tsu_clk without tx_clk
      net: macb: remove illusion about TBQPH/RBQPH being per-queue
      net: macb: move ring size computation to functions
      net: macb: single dma_alloc_coherent() for DMA descriptors
      net: macb: avoid dealing with endianness in macb_set_hwaddr()

 .../devicetree/bindings/net/cdns,macb.yaml         |   2 +-
 drivers/net/ethernet/cadence/macb.h                |   4 -
 drivers/net/ethernet/cadence/macb_main.c           | 140 ++++++++++-----------
 3 files changed, 69 insertions(+), 77 deletions(-)
---
base-commit: 03605e0fae3948824b613bfb31bcf420b89c89c7
change-id: 20250808-macb-fixes-e2f570e11241

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


