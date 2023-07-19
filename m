Return-Path: <netdev+bounces-19265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F63D75A0D5
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD631281B09
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227182514D;
	Wed, 19 Jul 2023 21:55:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C420D22EF1
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A022C433C9;
	Wed, 19 Jul 2023 21:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689803748;
	bh=pkUJ9QknpHULZVZcp8D9JqCbZ6N2TitJflc1Z3PXKSs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kpXB2lmdfnDWm/Gm+SRsLxwy+2zj/tNeojULasgHOsJqO+/ZeM/aHwo9UNSs1BkRf
	 8Fewn3kF6F+I0cbXe8wQgZb31DxA2w/A+fqddSc051fyAP4OtPacBwadviuEK9pyKL
	 Ok6IMkHjxRnQtu2ywiShsBgqBnQrG7s/s7c2exJvS1Tam+GqORCUO3Xs+s1YwH1jeO
	 wLOqn9nPWQsTVQ80QGFkKw8hp7zt3jzJGHxiEr8k2KV8n7/oae3DPoPhCEc7G9nKIh
	 VRUMeuefngsW8bIPg1kuCnN3qPMkktBbbgOOHy82n3WD0AbfplqBZaH5acL6vmKVDj
	 dnrVEye/wo3DA==
Message-ID: <59fd7be902941bb55a162a0edc4e2809.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-2-fb6ab3dea87c@linaro.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org> <20230630-topic-oxnas-upstream-remove-v2-2-fb6ab3dea87c@linaro.org>
Subject: Re: [PATCH v2 02/15] dt-bindings: clk: oxnas: remove obsolete bindings
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-oxnas@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Marc Zyngier <maz@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Neil Armstrong <neil.armstrong@linaro.org>, Paolo Abeni <pabeni@redhat.com>, Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vignesh Raghavendra <vigneshr@ti.com>
Date: Wed, 19 Jul 2023 14:55:45 -0700
User-Agent: alot/0.10

Quoting Neil Armstrong (2023-06-30 09:58:27)
> Due to lack of maintenance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove the
> OX810 and OX820 clock bindings.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Applied to clk-next

