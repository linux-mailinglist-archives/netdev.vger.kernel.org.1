Return-Path: <netdev+bounces-52147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E107FD959
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D95B21363
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1B1315A6;
	Wed, 29 Nov 2023 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pC64L9Hw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4E1DD
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:29:04 -0800 (PST)
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3A50C3FA57
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701268135;
	bh=vWP9CYe3KKvgAhmJq37cx8p7ADw60XqsLAUIuzsXUeA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=pC64L9Hw6264WxHpJlohOKlZ/CrcSaEa9+xaUIgV9rfy8pbUPFUqyiJxhsswXPeo/
	 Hxia9iIEqW5VyEZJItYfCEu+jZif6rXqUGDb99eooJLizR4WGUTDv4JOWuh8TA6tiw
	 H0GIfIHgI5P18V4NUwRSgF31pbfuRAA2JHgg4f0ThRBRieBaxkQ0vp84igsHldvO+3
	 EPl38bn97dhZbsTzC3lqTyUxqUXaR55A1vwAoJbREhC8QTYi2pCObqn54koxOmovPy
	 vVbYmxuCPNxQyhXAnusi1Xgm+Y8tiVzhMJBAi+spAWZZFavGJmliAZxPsheyp+wB7L
	 J+SAF3XDBFJEw==
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-67a238351b7so59105206d6.2
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701268131; x=1701872931;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWP9CYe3KKvgAhmJq37cx8p7ADw60XqsLAUIuzsXUeA=;
        b=A6SdVp1cwbeaFMY6HuND4hPXTtY6qsc7m7fKnpNnvevOCex2Y6ORqc+T7fjrokKSCm
         vVWbwk0/Dgp8zfYxPrhmzDMrr1DJzKtSQBWvPycjcx6VQHf3HPxSBfttX+/eceKjvN56
         4oiWyuFPmzvUABWhPhnpiplH5Br9VqnyywyF993LQZ1Ks6PE+Q3Q5H5AdTOTAY7bcfs4
         artRhJMwMPHkSHM4vGcu+hALclp2iQ4eJIcN7WU29TubIX4rlopOEv4s46fbOnUhcmCB
         ixmrHbn7V/w444USirY4oz8ar9MUDaTHZTDrnYQ2/Sw3TLGw1eDbZmZeEKyB7ZEV87PI
         3WNA==
X-Gm-Message-State: AOJu0YxDVyD8Lh/kpQrALSJh+QUa7m9lbuTCbazSuVDR382ZBK7RWQ8N
	VU3i1HgieFylu2s9sg/FA6uv7NxU1z9w9GtBX+rBk2qdeLpRH6ypCmF1ZvTLy8J065y9BfsYvNj
	jsspiQFeNzESyxVBgBXMpLqa40P1IxWRXSWyDiGWOBgCmuJlmvg==
X-Received: by 2002:ad4:5042:0:b0:67a:674:ed88 with SMTP id m2-20020ad45042000000b0067a0674ed88mr19792170qvq.28.1701268131051;
        Wed, 29 Nov 2023 06:28:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEONtigUGKk4Y3Xk0mTpJLPt7Y7eqdmWiLh7OaZgii+ClWP4Bwqi3efc7dvejFZ/cmdUo7bZdxEtkDa6yrOEjc=
X-Received: by 2002:ad4:5042:0:b0:67a:674:ed88 with SMTP id
 m2-20020ad45042000000b0067a0674ed88mr19792134qvq.28.1701268130726; Wed, 29
 Nov 2023 06:28:50 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Nov 2023 15:28:50 +0100
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <5395f3ce-f9ec-474b-b145-5f62a3b7c4fc@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
 <CAJM55Z9e=vjGKNnmURN15mvXo2bVd3igBA-3puF9q7eh5hiP+A@mail.gmail.com>
 <2f06ce36-0dc1-495e-b6a6-318951a53e8d@collabora.com> <CAJM55Z8vkMbqXY5sS2o4cLi8ow-JQTcXU9=uYMBSykwd4ppExw@mail.gmail.com>
 <054bbf2a-e7ba-40bf-8f8b-f0e0e9b396c6@collabora.com> <CAJM55Z9+j6CmfjNkPLCk1DR3EBuEMspsRtNvygDbPWJDCytQpw@mail.gmail.com>
 <5395f3ce-f9ec-474b-b145-5f62a3b7c4fc@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 29 Nov 2023 15:28:50 +0100
Message-ID: <CAJM55Z-ff8btSQwJcWViUKLTJ8F2C_b70AaKJMwxgxZurUyGBA@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive:
 beaglev-starlight: Enable gmac
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Samin Guo <samin.guo@starfivetech.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

Cristian Ciocaltea wrote:
> On 11/28/23 18:09, Emil Renner Berthing wrote:
> > Cristian Ciocaltea wrote:
> >> On 11/28/23 14:08, Emil Renner Berthing wrote:
> >>> Cristian Ciocaltea wrote:
> >>>> On 11/26/23 23:10, Emil Renner Berthing wrote:
> >>>>> Cristian Ciocaltea wrote:
> >>>>>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
> >>>>>> RGMII-ID.
> >>>>>>
> >>>>>> TODO: Verify if manual adjustment of the RX internal delay is needed. If
> >>>>>> yes, add the mdio & phy sub-nodes.
> >>>>>
> >>>>> Sorry for being late here. I've tested that removing the mdio and phy nodes on
> >>>>> the the Starlight board works fine, but the rx-internal-delay-ps = <900>
> >>>>> property not needed on any of my VisionFive V1 boards either.
> >>>>
> >>>> No problem, thanks a lot for taking the time to help with the testing!
> >>>>
> >>>>> So I wonder why you need that on your board
> >>>>
> >>>> I noticed you have a patch 70ca054e82b5 ("net: phy: motorcomm: Disable
> >>>> rgmii rx delay") in your tree, hence I you please confirm the tests were
> >>>> done with that commit reverted?
> >>>>
> >>>>> Also in the driver patch you add support for phy-mode = "rgmii-txid", but here
> >>>>> you still set it to "rgmii-id", so which is it?
> >>>>
> >>>> Please try with "rgmii-id" first. I added "rgmii-txid" to have a
> >>>> fallback solution in case the former cannot be used.
> >>>
> >>> Ah, I see. Sorry I should have read up on the whole thread. Yes, the Starlight
> >>> board with the Microchip phy works with "rgmii-id" as is. And you're right,
> >>> with "rgmii-id" my VF1 needs the rx-internal-delay-ps = <900> property too.
> >>
> >> That's great, we have now a pretty clear indication that this uncommon behavior
> >> stems from the Motorcomm PHY, and *not* from GMAC.
> >>
> >>>>
> >>>>> You've alse removed the phy reset gpio on the Starlight board:
> >>>>>
> >>>>>   snps,reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>
> >>>>>
> >>>>> Why?
> >>>>
> >>>> I missed this in v1 as the gmac handling was done exclusively in
> >>>> jh7100-common. Thanks for noticing!
> >>>>
> >>>>>>
> >>>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >>>>>> ---
> >>>>>>  arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts | 5 +++++
> >>>>>>  1 file changed, 5 insertions(+)
> >>>>>>
> >>>>>> diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> >>>>>> index 7cda3a89020a..d3f4c99d98da 100644
> >>>>>> --- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> >>>>>> +++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> >>>>>> @@ -11,3 +11,8 @@ / {
> >>>>>>  	model = "BeagleV Starlight Beta";
> >>>>>>  	compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
> >>>>>>  };
> >>>>>> +
> >>>>>> +&gmac {
> >>>>>> +	phy-mode = "rgmii-id";
> >>>>>> +	status = "okay";
> >>>>>> +};
> >>>>>
> >>>>> Lastly the phy-mode and status are the same for the VF1 and Starlight boards,
> >>>>> so why can't these be set in the jh7100-common.dtsi?
> >>>>
> >>>> I wasn't sure "rgmii-id" can be used for both boards and I didn't want
> >>>> to unconditionally enable gmac on Starlight before getting a
> >>>> confirmation that this actually works.
> >>>>
> >>>> If there is no way to make it working with "rgmii-id" (w/ or w/o
> >>>> adjusting rx-internal-delay-ps), than we should switch to "rgmii-txid".
> >>>
> >>> Yeah, I don't exactly know the difference, but both boards seem to work fine
> >>> with "rgmii-id", so if that is somehow better and/or more correct let's just go
> >>> with that.
> >>
> >> As Andrew already pointed out, going with "rgmii-id" would be the recommended
> >> approach, as this passes the responsibility of adding both TX and RX delays to
> >> the PHY.  "rgmii-txid" requires the MAC to handle the RX delay, which might
> >> break the boards having a conformant (aka well-behaving) PHY.  For some reason
> >> the Microchip PHY seems to work fine in both cases, but that's most likely an
> >> exception, as other PHYs might expose a totally different and undesired
> >> behavior.
> >>
> >> I will prepare a v3 soon, and will drop the patches you have already submitted
> >> as part of [1].
> >
> > Sounds good. Then what's missing for ethernet to work is just the clock patches:
> > https://github.com/esmil/linux/commit/b5abe1cb3815765739aff7949deed6f65b952c4a
> > https://github.com/esmil/linux/commit/3a7a423b15a9f796586cbbdc37010d2b83ff2367
> >
> > You can either include those as part of your patch series enabling ethernet, or
> > they can be submitted separately with the audio clocks. Either way is
> > fine by me.
>
> I can cherry-pick them, but so far I couldn't identify any networking
> related issues if those patches are not applied. Could it be something
> specific to Starlight board only?

No, it's the same for both boards. The dwmac-starfive driver adjusts
the tx clock:

1000Mbit -> 125MHz
 100Mbit ->  25MHz
  10Mbit -> 2.5MHz

The tx clock is given in the device tree as the gmac_tx_inv clock which derives
from either the gmac_root_div or gmac_rmii_ref external clock like this:

gmac_rmii_ref (external) -> gmac_rmii_txclk     \
gmac_root_div  (500MHz)  -> gmac_gtxclk (div N) -> gmac_tx (mux) -> gmac_tx_inv

..where N defaults to 4 and the gmac_tx mux defaults to the gmac_gtxclk, so
the gmac_tx_inv clock defaults to 125MHz suitable for 1000Mbit connections.
See /sys/kernel/debug/clk/clk_summary for another overview.

When the dwmac_starfive driver request to change gmac_tx_inv to 25MHz the clock
framework will that it has the CLK_SET_RATE_PARENT flag set, so it will try
the gmac_tx clock next. This is a mux that can choose either the
125MHz gmac_gtxclk
or the external gmac_rmii_txclk which defaults to 0MHz in the current
device trees,
so the request cannot be met.

That's why we need to set the CLK_SET_RATE_PARENT (and CLK_SET_RATE_NO_REPARENT)
flags on the gmac_tx clock so the clock framework again goes to try setting the
gmac_gtxclk to 25MHz, which it can because it's a divider and setting N=20
does the trick.

On your board you can manually force a 100Mbit connection with
ethtool -s eth0 speed 100

That fails on my boards without those two patches.
/Emil

> >>
> >> Thanks again for your support,
> >> Cristian
> >>
> >> [1]: https://lore.kernel.org/all/20231126232746.264302-1-emil.renner.berthing@canonical.com/

