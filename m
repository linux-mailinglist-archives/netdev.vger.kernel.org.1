Return-Path: <netdev+bounces-26443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD30777C96
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9531C215FC
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5951120CA5;
	Thu, 10 Aug 2023 15:48:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61320C94
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C91C433C7;
	Thu, 10 Aug 2023 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691682480;
	bh=IhSS+Gzq9OcK1ql5cyEbAn3ygO8llggcsc2KQLqvMkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HKVJBPVILtGjaC3mXfV61EVcGPf6DXaqle9TFghct4pX5yjDFaMFifWcgHnrtNkZX
	 uu4crxxP79VILE2yvP8vZF1+6OnXPjZh+P03ynl7KcwkhiIK4A0GGfNpJuHWMClxEM
	 gF1EhHXmuYlAoiqNfthZPiWy6pTBeDKmoayE0/7uIin6fDsKDxEYodpYlustac55bi
	 kTAgiWH6fJRR/Emv6fJkjLX9krk9TbhSzrZDyL917VRz1CcFgJD0KqnS8BYI8Kj+7n
	 BII24XVDFE5B3Y/CpH1l5HWyBVYR6TeXUIqucIVz4+3EJuMsvoSoyvW0/3OodMlpsM
	 OgjGTfouHcUlw==
Date: Thu, 10 Aug 2023 08:47:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang
 Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Randy Dunlap <rdunlap@infradead.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 00/28] Add support for QMC HDLC, framer infrastruture
 and PEF2256 framer
Message-ID: <20230810084758.2adbfeb8@kernel.org>
In-Reply-To: <20230809132757.2470544-1-herve.codina@bootlin.com>
References: <20230809132757.2470544-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Aug 2023 15:27:27 +0200 Herve Codina wrote:
> The series contains the full story and detailed modifications.
> If needed, the series can be split and/or commmits can be squashed.
> Let me know.

Are there any dependencies in one of the -next trees?
As it the series doesn't seem to build on top of net-next 
with allmodconfig.

