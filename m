Return-Path: <netdev+bounces-44244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 426AA7D745D
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D02B20CA9
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B90931A71;
	Wed, 25 Oct 2023 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNjzDaSG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC15130FBF;
	Wed, 25 Oct 2023 19:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A68C433C7;
	Wed, 25 Oct 2023 19:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698262338;
	bh=ZEC6SiD956fvl4s5yXxFlRFIaaeMysUnrTT9R0rL6uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NNjzDaSGX6Xm/ojy0S9ANDFMlr6eKMq9gQjnX+RSpD7B6pmXp9N1HZQcj7PnMXOaI
	 FPlk4cYKswApKmXKwZtFkLHe8Wd/MGYdolE+3ljriPunliyXP8I6vwS6kAryW675n0
	 w/YJ6ecaLbusz7GPBlZLWXa9nVVhQt+FCaqUj3I0522oj4hgjjsfiT7CU/6YwIxKv6
	 OBBMTyKRN8L2N3992/sREdR/vhMVZ/pCX7XS1EACF7/FZ1FaIqIV7XziFecwMyGOws
	 k2n7E3UYYAEQWd4eT7A7Ot5Gnu5jV3LmcJLia/oW/bjKXaWWcLXjfbX3XZgi/vuvgS
	 jaj/Vm8Qz315A==
Date: Wed, 25 Oct 2023 12:32:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li Yang <leoyang.li@nxp.com>
Cc: Herve Codina <herve.codina@bootlin.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang
 Zhao <qiang.zhao@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Nicolin Chen
 <nicoleotsuka@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Simon
 Horman <horms@kernel.org>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 00/30] Add support for QMC HDLC, framer
 infrastructure and PEF2256 framer
Message-ID: <20231025123215.5caca7d4@kernel.org>
In-Reply-To: <20231025170051.27dc83ea@bootlin.com>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
	<20231013164647.7855f09a@kernel.org>
	<20231025170051.27dc83ea@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 17:00:51 +0200 Herve Codina wrote:
> > Which way will those patches go? Via some FSL SoC tree?  
> 
> This series seems mature now.
> What is the plan next in order to have it applied ?
> 
> Don't hesitate to tell me if you prefer split series.

FWIW we are happy to take the drivers/net/ parts if there is no hard
dependency. But there's no point taking that unless the SoC bits
also go in for 6.7.

Li Yang, what are your expectations WRT merging this series?

