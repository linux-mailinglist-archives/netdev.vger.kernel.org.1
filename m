Return-Path: <netdev+bounces-54900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3EA808E73
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50561F21024
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BDB48CD7;
	Thu,  7 Dec 2023 17:18:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669661716;
	Thu,  7 Dec 2023 09:18:00 -0800 (PST)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rBI0L-00045r-2T;
	Thu, 07 Dec 2023 17:17:42 +0000
Date: Thu, 7 Dec 2023 17:17:38 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	"Garmin.Chang" <Garmin.Chang@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	James Liao <jamesjj.liao@mediatek.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: clock: mediatek: add clock
 controllers of MT7988
Message-ID: <ZXH-Mq_DlW5Oodwt@makrotopia.org>
References: <23bc89d407e7797e97b703fa939b43bfe79296ce.1701823757.git.daniel@makrotopia.org>
 <def05aac79ddff872d3e56698b736cb445f14116.1701823757.git.daniel@makrotopia.org>
 <3e72bff6-9f4d-4cd4-845e-b065f1233ec6@collabora.com>
 <ZXBs9GOOOlZrMuSW@makrotopia.org>
 <64ee48fc-4f77-48cc-b235-c9fb2b10afc4@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ee48fc-4f77-48cc-b235-c9fb2b10afc4@linaro.org>

On Thu, Dec 07, 2023 at 06:03:44PM +0100, Krzysztof Kozlowski wrote:
> On 06/12/2023 13:45, Daniel Golle wrote:
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - const: mediatek,mt7988-ethwarp
> >>> +      - const: syscon
> >>> +      - const: simple-mfd
> >>
> >> No, this is not a mfd, I say.
> >>
> >> Prove me wrong! :-)
> > 
> > https://github.com/dangowrt/linux/blob/mt7988-for-next/arch/arm64/boot/dts/mediatek/mt7988a.dtsi#L564
> > 
> > The 'simple-mfd' compatible is required to have the Linux
> > kernel probe drivers for sub-nodes -- several drivers will act on
> > the different aspects of the circuit exposed at this memory range.
> > From what I understand, this is the definition of a MFD.
> 
> We know what is MFD, so no need to teach us. We expect you to look at
> this. You do not have subnodes, so MFD is pointless. Showing DTSI means
> nothing except that you did not test your bindings.

Sorry, I simply wasn't aware that this is what I'm being asked for.
Is the device a MFD? - Yes it is.

In this case the child node would be a 'ti,syscon-reset' which doesn't
have YAML bindings. Should I include it as object without $ref or do I
need to convert ti,syscon-reset.txt to yaml first, and then reference
it as child node in the MFD?

