Return-Path: <netdev+bounces-32162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466C793250
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 01:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CB91C20959
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 23:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9DF101E6;
	Tue,  5 Sep 2023 23:15:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0B101E3
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 23:15:49 +0000 (UTC)
Received: from out-224.mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAFE199;
	Tue,  5 Sep 2023 16:15:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1693955745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D2FPcQErshs4neWBv0GJQwsUJ0sNwOZwOWcL1QTkHiU=;
	b=pKEFyUpvyndg11JUWXB7DM5ejZKm8naVU4OCa+6/Wf4T2hWwbVEtTZ0dKj8b0kyC8wXI3W
	KweQzg8UfOrKJhUaMzO3T4ox+0s12mbZ8C+mNbOrPj8NHI+vyUnmh0jV7GiO+kvSMQYiVU
	Tq3meJwnnMIB02l1d99bAuaABeeeSvTOuOgf4Y3JtqwU6vNGcB++5Z4ZYSPTkge2bpkLSO
	tRZKrtPAcdp7c0Oub4tF21uqXmdWetZUE+CQEu6DRdBWL8Zs5/4R+WK+m9YbpriKWTQVxk
	EfIE2hcgppl9m4aVikaTd6F72mDCRYLIS6ABcUTrSyWbJjsvfqt3uMiVGggC3g==
From: John Watts <contact@jookia.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Watts <contact@jookia.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set
Date: Wed,  6 Sep 2023 09:13:43 +1000
Message-ID: <20230905231342.2042759-2-contact@jookia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When adding the RISCV option I didn't gate it behind ARCH_SUNXI.
As a result this option shows up with Allwinner support isn't enabled.
Fix that by requiring ARCH_SUNXI to be set if RISCV is set.

Fixes: 8abb95250ae6 ("can: sun4i_can: Add support for the Allwinner D1")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/linux-sunxi/CAMuHMdV2m54UAH0X2dG7stEg=grFihrdsz4+o7=_DpBMhjTbkw@mail.gmail.com/
Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 649453a3c858..f8cde9f9f554 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -190,7 +190,7 @@ config CAN_SLCAN
 
 config CAN_SUN4I
 	tristate "Allwinner A10 CAN controller"
-	depends on MACH_SUN4I || MACH_SUN7I || RISCV || COMPILE_TEST
+	depends on MACH_SUN4I || MACH_SUN7I || (RISCV && ARCH_SUNXI) || COMPILE_TEST
 	help
 	  Say Y here if you want to use CAN controller found on Allwinner
 	  A10/A20/D1 SoCs.
-- 
2.42.0


