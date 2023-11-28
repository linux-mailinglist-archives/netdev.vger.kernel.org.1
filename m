Return-Path: <netdev+bounces-51664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E861D7FB9E2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 13:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CE91C20E1D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC074F8A8;
	Tue, 28 Nov 2023 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HIdGdYur"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EFE183
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 04:08:23 -0800 (PST)
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D272544434
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701173301;
	bh=iOZrwSPmspp94JeIuHB4gK1Gx/cQjCpWhXKzSprsIjI=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HIdGdYurwvY4jLzjhJ5FG3GlajPU4BhpSs13VcRRfDnBRdy5qBzXacJu4SeeEje37
	 3/tPWTxTdQ4kP5lS8lgzbsqUdogzvw0k87bBb1fbuAKhu6mzXj2R5dq9L0rAWRnfbU
	 T+tLmc9NF5OOoymiSZ9F58B5l4SLJbkWo+ogKIc001zuZOsU83BEEjRQ3+AgYdiVXw
	 6bAQi/Fn7oK6xXOc/saZ2PrZdCTU7K1df/WT7BuN6xoBEucInMaB09YfDuj0ItiPNf
	 Og3+vA1Ix0WZ3qhxtAz23OX4jRSkVnBqo5xwBN1nRUlTBtFEqVtxSs1zYPbbPXTnw8
	 yBxIJakdNVv8Q==
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67a3bbd9510so26280806d6.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 04:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701173300; x=1701778100;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOZrwSPmspp94JeIuHB4gK1Gx/cQjCpWhXKzSprsIjI=;
        b=WH7okAVusDhwb17CNRBRyt/W4VJWEhDsiLvONazKxysq5xg6f7CWRCTh7bN9GQXPLM
         cr30cm0vZaW9Tp6In0MFESWcxSpjeHMDdTYlEEqeHNH/jLHos4xDm7wtDl6iiew9HtTU
         7IfnQ8NTGC96BIsdAjGEK1tOd6xX8v0s82OAuATcOr58GRPfJfL67yiEA+kqQmsJJ4up
         kJsFCtDVflNaY9l8r3q5EjgGo4tR8dzGsSNfL8+WClqfwUMbZjAW7aFRFOAllvU/SdmA
         bt5wNNG1LQBtMXIxgozUx2lDzS74Yc/LOj+452KFPOmXEKOkoYR8GlOv41z0XleySbS/
         ps9g==
X-Gm-Message-State: AOJu0YzsqUyj1agwpVBGDg9US8F/b8y4VZei5B9RJhnMLlVEShYgLHIg
	Ia+jOCI3WmzeqE+EYa2y9Hb6rNn19av6uwE7h6g20fU/YHPGXEm68IBBh88hAaOtyPalYnK9j53
	22dPOWg+DUtnYHcIPlU5wRvLZQDBdHIzBJi03cKvHrgsCdc3Zxg==
X-Received: by 2002:a0c:c788:0:b0:67a:4bb0:693a with SMTP id k8-20020a0cc788000000b0067a4bb0693amr5088407qvj.55.1701173299942;
        Tue, 28 Nov 2023 04:08:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBEBEjzW+Uph8+AZgkvAUsq8GnJE2nUXrDjraYHJF2flj0Zg8LkQf+0YqL9hF83A1yoS4DqWVvh0w1JaGFdxE=
X-Received: by 2002:a0c:c788:0:b0:67a:4bb0:693a with SMTP id
 k8-20020a0cc788000000b0067a4bb0693amr5088373qvj.55.1701173299631; Tue, 28 Nov
 2023 04:08:19 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Nov 2023 13:08:18 +0100
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <2f06ce36-0dc1-495e-b6a6-318951a53e8d@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
 <CAJM55Z9e=vjGKNnmURN15mvXo2bVd3igBA-3puF9q7eh5hiP+A@mail.gmail.com> <2f06ce36-0dc1-495e-b6a6-318951a53e8d@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 28 Nov 2023 13:08:18 +0100
Message-ID: <CAJM55Z8vkMbqXY5sS2o4cLi8ow-JQTcXU9=uYMBSykwd4ppExw@mail.gmail.com>
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
> On 11/26/23 23:10, Emil Renner Berthing wrote:
> > Cristian Ciocaltea wrote:
> >> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
> >> RGMII-ID.
> >>
> >> TODO: Verify if manual adjustment of the RX internal delay is needed. If
> >> yes, add the mdio & phy sub-nodes.
> >
> > Sorry for being late here. I've tested that removing the mdio and phy nodes on
> > the the Starlight board works fine, but the rx-internal-delay-ps = <900>
> > property not needed on any of my VisionFive V1 boards either.
>
> No problem, thanks a lot for taking the time to help with the testing!
>
> > So I wonder why you need that on your board
>
> I noticed you have a patch 70ca054e82b5 ("net: phy: motorcomm: Disable
> rgmii rx delay") in your tree, hence I you please confirm the tests were
> done with that commit reverted?
>
> > Also in the driver patch you add support for phy-mode = "rgmii-txid", but here
> > you still set it to "rgmii-id", so which is it?
>
> Please try with "rgmii-id" first. I added "rgmii-txid" to have a
> fallback solution in case the former cannot be used.

Ah, I see. Sorry I should have read up on the whole thread. Yes, the Starlight
board with the Microchip phy works with "rgmii-id" as is. And you're right,
with "rgmii-id" my VF1 needs the rx-internal-delay-ps = <900> property too.

>
> > You've alse removed the phy reset gpio on the Starlight board:
> >
> >   snps,reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>
> >
> > Why?
>
> I missed this in v1 as the gmac handling was done exclusively in
> jh7100-common. Thanks for noticing!
>
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> >> index 7cda3a89020a..d3f4c99d98da 100644
> >> --- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> >> +++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> >> @@ -11,3 +11,8 @@ / {
> >>  	model = "BeagleV Starlight Beta";
> >>  	compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
> >>  };
> >> +
> >> +&gmac {
> >> +	phy-mode = "rgmii-id";
> >> +	status = "okay";
> >> +};
> >
> > Lastly the phy-mode and status are the same for the VF1 and Starlight boards,
> > so why can't these be set in the jh7100-common.dtsi?
>
> I wasn't sure "rgmii-id" can be used for both boards and I didn't want
> to unconditionally enable gmac on Starlight before getting a
> confirmation that this actually works.
>
> If there is no way to make it working with "rgmii-id" (w/ or w/o
> adjusting rx-internal-delay-ps), than we should switch to "rgmii-txid".

Yeah, I don't exactly know the difference, but both boards seem to work fine
with "rgmii-id", so if that is somehow better and/or more correct let's just go
with that.

Thanks!
/Emil

>
> Thanks,
> Cristian

