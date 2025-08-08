Return-Path: <netdev+bounces-212241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8108B1ED54
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DDC18C628A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7044288537;
	Fri,  8 Aug 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OtkOfjxM"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE34287261;
	Fri,  8 Aug 2025 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671970; cv=none; b=k5tr4icQ9YRdMXDLhCR+VkEkFZSdPDiL4hN+AcdySarA81lGr7QNPk/5NkwWvzmOByzRvkrbgCA4yN/CfeehD5ea0wmmWKNu2xJbHlE3qbTX1yPECWyBHxjyJHK66PpnIU6l86pZhBW5InQN8l6f05DZ3MifxJrpQItgKKxbw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671970; c=relaxed/simple;
	bh=rMsoi5mfktawmpI2lbQpgzcCmgRk/g03ItpHigR35UI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLcFyRCBsHMndYif/b5Wzfu8gGvJFPOpdp1s5JTLNrPhJ6PCMz/uamlq88BDoX5uByuRawUPI2KpkFGf+0ogWalaNP1f4JvJ0IzAjp3BdrqQ/hZOiGEzdT5jO4ncHBnWdtc+dlk9zktMNL4LGBIxQ89PW3c4UnxjYH8wqbWp18Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OtkOfjxM; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20071442E6;
	Fri,  8 Aug 2025 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754671966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OreZDvz6ibiPbiu0BQwWWeRO7Y+zotRHbq2CtSZ8DRk=;
	b=OtkOfjxMDg+9KQVXzDhSH03Wk/ZxogyIsDUgmoZLylnpaJn4I/272EmDVEmDPRJlhlDpts
	gi/kao33ZtdABaKElHA2EGB0G0xu7EI4C8DZpHcMKkvwa9QYhpeA0veQBHSVZgwRjcCm4B
	WJ2Tv1xOrG7OtkYgJjSmo4izp7wdVxdJD1qOkAphHgfVJFTyBHQgbVO7x7BxIlaEciZTkD
	tCBQu/rIIN0RQUnHXX8ZoXiNninpcnZmklxZDhmU2WZItqhbABV757kyeYCaBSX6qi7ZAE
	NKrXQocchSGMYEA8le+lBYee20RkCwprsWRsbZ3nwwft2a9AlRYXzghnhYxd2g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Aug 2025 18:52:41 +0200
Subject: [PATCH net v3 09/16] net: macb: remove gap in MACB_CAPS_* flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-macb-fixes-v3-9-08f1fcb5179f@bootlin.com>
References: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
In-Reply-To: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepvfhhrohoucfnvggsrhhunhcuoehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelvefhkeeufedvkefghefhgfdukeejlefgtdehtdeivddtteetgedvieelieeuhfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgupdhhvghloheplgduledvrdduieekrddutddrvddvudgnpdhmrghilhhfrhhomhepthhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshdrfhgvrhhrvgesmhhitghrohgthhhiphdrtghom
 hdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: theo.lebrun@bootlin.com

MACB_CAPS_* are bit constants that get used in bp->caps. They occupy
bits 0..12 + 24..31. Remove 13..23 gap by moving bits 24..31 to 13..19.

Occupation bitfields:

   31  29  27  25  23  21  19  17  15  13  11  09  07  05  03  01
     30  28  26  24  22  20  18  16  14  12  10  08  06  04  02  00
   -- Before ------------------------------------------------------
    1 1 1 1 1 1 1 1                       1 1 1 1 1 1 1 1 1 1 1 1 1
                    0 0 0 0 0 0 0 0 0 0 0
   -- After -------------------------------------------------------
                          1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
    0 0 0 0 0 0 0 0 0 0 0

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 082b7df54cc1075d89293f390184e77bee65db61..c5ab35f4ab493196b5fa9a8046a6c8edf7c82727 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -740,14 +740,14 @@
 #define MACB_CAPS_NEED_TSUCLK			BIT(10)
 #define MACB_CAPS_QUEUE_DISABLE			BIT(11)
 #define MACB_CAPS_RSC				BIT(12)
-#define MACB_CAPS_PCS				BIT(24)
-#define MACB_CAPS_HIGH_SPEED			BIT(25)
-#define MACB_CAPS_CLK_HW_CHG			BIT(26)
-#define MACB_CAPS_MACB_IS_EMAC			BIT(27)
-#define MACB_CAPS_FIFO_MODE			BIT(28)
-#define MACB_CAPS_GIGABIT_MODE_AVAILABLE	BIT(29)
-#define MACB_CAPS_SG_DISABLED			BIT(30)
-#define MACB_CAPS_MACB_IS_GEM			BIT(31)
+#define MACB_CAPS_PCS				BIT(13)
+#define MACB_CAPS_HIGH_SPEED			BIT(14)
+#define MACB_CAPS_CLK_HW_CHG			BIT(15)
+#define MACB_CAPS_MACB_IS_EMAC			BIT(16)
+#define MACB_CAPS_FIFO_MODE			BIT(17)
+#define MACB_CAPS_GIGABIT_MODE_AVAILABLE	BIT(18)
+#define MACB_CAPS_SG_DISABLED			BIT(19)
+#define MACB_CAPS_MACB_IS_GEM			BIT(20)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01

-- 
2.50.1


