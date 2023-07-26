Return-Path: <netdev+bounces-21169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E33762A27
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 06:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916E22819EE
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995E25250;
	Wed, 26 Jul 2023 04:14:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F525523F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 04:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855FCC433C8;
	Wed, 26 Jul 2023 04:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690344865;
	bh=JctyBO2YGDNHm6PyaYDElro5t1yWDJCFcyBIWaxzZLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CncVg9XCuOLZ7wI2l6fLx7/R1NMrNWelj3kUrm4rZfMdvSuTwYGpmTN0y1Zu76Tpr
	 dJyX+eas2yz+azx5J1DiGLD/3bB6EpoA+bs1CXtyZWZSHwI1h8n4RHNH5PGGL1d9Q5
	 T2iBMuuNuFzaUMc/KlkJndDN/KS81elqs8bqwYuCv9K9NEF+mrKiAj17s0Rpkfnnie
	 wvWtQAWMzY23+5E9xEP9DyL0tEiz1oissxpVF4jqf6M9qeEn5NjaAOJ+C71bfuDsO5
	 0pRboaWRg76D3OJMxx9u+wpH+7izUWI4pRmEPGyjqk7FbFQ7sJih9+6mq4x7rBlkG8
	 6UNFyA/sc9S1A==
Date: Tue, 25 Jul 2023 21:14:23 -0700
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
 Leroy <christophe.leroy@csgroup.eu>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 00/26] Add support for QMC HDLC, framer infrastruture
 and PEF2256 framer
Message-ID: <20230725211423.742f0a6a@kernel.org>
In-Reply-To: <20230725092417.43706-1-herve.codina@bootlin.com>
References: <20230725092417.43706-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 11:23:36 +0200 Herve Codina wrote:
> I have a system where I need to handle an HDLC interface and some audio
> data.

The new code must build cleanly with C=1 W=1, after every individual
patch.
-- 
pw-bot: cr

