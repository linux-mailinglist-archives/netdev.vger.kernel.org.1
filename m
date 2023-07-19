Return-Path: <netdev+bounces-19264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C127B75A0D3
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9241C211B2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFAC25148;
	Wed, 19 Jul 2023 21:55:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D922EF1
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39491C433C7;
	Wed, 19 Jul 2023 21:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689803735;
	bh=LZGTzFpSHfpTcvbThJ8bOlUPyqc49MIpWv26NdWHD/0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=K+6JiuEzRS0YoJ/68ES/WWbnnDYk1c6OFzTPqUKDYEQ+wscgxicKF3dTRUB9nOdyV
	 3m8Uo6XLeEvf9fdNr+lBBVjIbWueYOEF5if2vWaPkqtY6fkp11jR+1XfSMvZ7cOBci
	 fTkVYanYbzaCNGOUmOVm3khxSF6V4qaTOomUypN2bKbxidZiDRKJOh4j8OXUcp6dqi
	 l3oWPATq6xkuZhcLNfc6UF0l/tFJ2gZ2OL/quQqgE88J0+F4FVGV74fClFR58l5KH0
	 v2mx7qhd/sLgZWGLQ292okszTzmPxar44Z+5GZN2yQO3B4M61ROEPj25iT/IcDKEbf
	 gjS6CiFvrmgBA==
Message-ID: <a7f78b4e812a4cd6ea4b61ef4ebc5f19.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-1-fb6ab3dea87c@linaro.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org> <20230630-topic-oxnas-upstream-remove-v2-1-fb6ab3dea87c@linaro.org>
Subject: Re: [PATCH v2 01/15] clk: oxnas: remove obsolete clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-oxnas@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Marc Zyngier <maz@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Neil Armstrong <neil.armstrong@linaro.org>, Paolo Abeni <pabeni@redhat.com>, Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vignesh Raghavendra <vigneshr@ti.com>
Date: Wed, 19 Jul 2023 14:55:33 -0700
User-Agent: alot/0.10

Quoting Neil Armstrong (2023-06-30 09:58:26)
> Due to lack of maintenance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove support
> for OX810 and OX820 clock driver.
>=20
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Applied to clk-next

