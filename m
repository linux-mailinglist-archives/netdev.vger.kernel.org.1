Return-Path: <netdev+bounces-17451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3530E751A9C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D811C212DC
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B16135;
	Thu, 13 Jul 2023 07:59:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8006133
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:59:46 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F663A96;
	Thu, 13 Jul 2023 00:59:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0898640003;
	Thu, 13 Jul 2023 07:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1689235159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ns0g2x/HP1fLB+xSQBeMwCrjXfs2Pl1Rj64uL455UgE=;
	b=EldaKwafz3O/wp0uatKayVJ96yu26PsAdFvBGj0+bcjNbmPvmYTzOBBZp97PX+ginQDyNb
	Ir5iLYF/wI12ZM9iyNDeVFSY4xO9GqlPxA8ZtwgzNl3Rx8dz7D3uOGwtlJPSN8OY5saRP4
	SK8PXkrOQzYkf3DmNi7XNPRwEn9+8mZJPGIuLWRn3Wxa00EpzGkcGbAeOjlsDcZH0eNlb0
	HyAPWrQpPsJQwSiTSzbHOqWXsP8JZJOOtF2LGOCpkjT1jilP6XvaK48kVDi0QgeA3VNDt6
	Ry9wPnR3AXn7DGDDWz+IIX71OAbsUsR9heCmTECyR7xNIj/dPSh3hp66QCUrxw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-oxnas@groups.io,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v2 05/15] nand: oxnas_nand: remove obsolete raw nand driver
Date: Thu, 13 Jul 2023 09:59:13 +0200
Message-Id: <20230713075913.486714-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <20230630-topic-oxnas-upstream-remove-v2-5-fb6ab3dea87c@linaro.org>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ecdaf0ee79156ce0c103cc1a7e38634fa0de6a5a'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-06-30 at 16:58:30 UTC, Neil Armstrong wrote:
> Due to lack of maintenance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove support
> for OX810 and OX820 nand.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

