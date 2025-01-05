Return-Path: <netdev+bounces-155267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67DAA0193B
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 12:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C8A3A363D
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 11:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FB914AD29;
	Sun,  5 Jan 2025 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="giHzQki8"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596C148FF6;
	Sun,  5 Jan 2025 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736076618; cv=none; b=YV6aF8jq/ZVJ+QMjajh0bOYzdThT0i5NygdQhWUDHexC6wJjo9rmm10iEoAq69sVNvxO7E8hWf4zoqEZkO12AnuIUZevDmYnl356xqv9S3JGi5TS5Fzc5Ij1XG6OMbX+cJ0flh5OWJyMbnjjdLJldg3ybil6m2YtiHtBVis3tFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736076618; c=relaxed/simple;
	bh=yLbbSxJ8rOCZV34Ppdmdr/BcVBls3TYQ0BnZjPUlHaQ=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=ozbw4tcOJHGIHnga3TB2byYMPlY4uLp+oy6tsGRzCSNYNGO8F5pPsbrUtl47p/bc9oS8hI2ndOeCKFdtQTlVerRs6D2CiFbFrCZ5pXrhpjyP/VaYtMbMc/KeB0R6+/kjb6hdx5lHe5R/CEwOczhz4qAXnAdspz5PjEEep39yxcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=giHzQki8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1736076580; x=1736681380; i=frank-w@public-files.de;
	bh=yLbbSxJ8rOCZV34Ppdmdr/BcVBls3TYQ0BnZjPUlHaQ=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=giHzQki8mwpHL1X1Upv9XAD2p7y7qccymTqilRNIKRYCF2r7HH/RgxDfKQH0GtvP
	 Z5Cl1CIPWQoRf5+ahJGDl+GgsBg4BlcTQvnaeiQPkbnF10CTF5clv13vCJpsW46WF
	 +gRxRKAn+eNRuJTDt6R7axU1NQVqBXJL8j3J6ql7BcBDJJ96cAALj4RCoef2HdCGj
	 BwL3kcwfhItF2Fa8y5NU8bdI6NDLH+guPDGuqvomGCC0s1CjKamtWQY7KhYKbVgNr
	 IRWwtzhHKUEHTk80WLjsMCpOJw7wZEjeuLib9zOqQZi5/cOG1C9Cvt776I4r0+Ke/
	 mrE1r81U/K9b+GJKNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.79.38] ([80.245.79.38]) by
 trinity-msg-rest-gmx-gmx-live-548599f845-nqxpf (via HTTP); Sun, 5 Jan 2025
 11:29:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-80459cab-e571-4699-b3f0-d73a00fe0858-1736076576826@trinity-msg-rest-gmx-gmx-live-548599f845-nqxpf>
From: Frank Wunderlich <frank-w@public-files.de>
To: linux@armlinux.org.uk
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, chunfeng.yun@mediatek.com, vkoul@kernel.org,
 kishon@kernel.org, nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, lynxis@fe80.eu, dqfext@gmail.com,
 SkyLake.Huang@mediatek.com, p.zabel@pengutronix.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, daniel@makrotopia.org
Subject: Aw: Re: Aw: Re: [RFC PATCH net-next v3 3/8] net: pcs:
 pcs-mtk-lynxi: add platform driver for MT7988
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <Zv_9HuaHqtgIA4Et@shell.armlinux.org.uk>
Importance: normal
References: <cover.1702352117.git.daniel@makrotopia.org>
 <8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org>
 <ZXnV/Pk1PYxAm/jS@shell.armlinux.org.uk> <ZcLc7vJ4fPmRyuxn@makrotopia.org>
 <ZiaPHWXU-82QMrMt@makrotopia.org>
 <89bd21ac-78f3-4ee4-9899-83f03169e647@public-files.de>
 <trinity-af6fdd0b-b72c-42a9-bbae-af45c02f539f-1728051457848@3c-app-gmx-bs32>
 <Zv_9HuaHqtgIA4Et@shell.armlinux.org.uk>
Date: Sun, 5 Jan 2025 11:29:40 +0000
Sensitivity: Normal
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:cPQBleyjsF3yVX6DIROFzgJoSZ9+njddCvA1Zg7Q0R7NQ3dqksbmDt8KviNuosx6RZ3R7
 ZmKOd3Nxj7ouB2aML4I7GDumerwX9UpoEH2jmlzOqRGe6hH7yHOlD6OHk8Q/+wvf7PqpwaBjkm0/
 OTvI4KebYTP3IfIxkFVmiFzwAJ724X8J5wmwp7wVttDfaSCIw+Vuhe0R2CxsJQlmmBI+LfzU4VUF
 GTp2GZLQnn3BRGh+pJbUurUUP92izBY7teDFQ5DvC/Ux8hYb2dqx18+y2FAhkWy90nIJb/pjRfgN
 ntMvlyZUag83U3fB2L+QStyIoMPNMzrNgKN3Kd3FB4zuHwHAx2gBK1Zn0WwVtXb7mE=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i8+cRb5wjRU=;tWzo9G7VqNUGJNBYvFdykWxunF4
 qcUYRTAgNtkuNzjEZbxWZYdTk2FXK+/bm8WeM+rQ4PvNgb2xROin0VDwLRqA3IcdsdQ6WHqk5
 quD0Bzg1/xxsmCzgQ4V5usPTXEudYQhbZbjofMbHikFi2u5Dn2eunjeeP7OPGX5drWKFHRhQ/
 V0I5egqb/CFj1a3N2iPBcycKJ2S2y8+CRY32m+IAQODjhyJAaEO8eu+3OWoXBllehnQUmYN2A
 WBb+LHQ4OJrAwOxbbXvBy1o8KKo1V9auiPHii+38kOQnZRaNIdOoVaG9ts3aZmR9CRhVQ2FTr
 sHCGuXBtlgter6DQIMYC3mJTCSGuYQQLbbwaobvivJPnV6bk27Sxm7Kwt1IwJjIFIxXTI/CkI
 Z1SGjkIzfN3uYXT9mOgyw6sqJZCECObxtBmnYSxzw6eCqqildFPm0i/PVVjRZQH6nw/ckKBOr
 7w/f4GujwrLbAmLmTP8TFjk+bjLbeH1bCeIdqfwxDfRLsiZBQsyqeC/NlqtdEa7RqRhYBqU9y
 DwEPyFI0y62+Ljqc1nJJtgG8sjBGbKWaRRmu9Gfku0ZRKKGFGbb9SDbM6SqqbvGjjsrbI6xaD
 DoJePLR5fiLfEvncocIrtEnCqi2U08eikELOBwpAbHrtRn+mmPlL5vK9e63hhX/TVhfjU/kXa
 ZgQrAQta2XzbdY62Uj5EowS8zRVwTLnj2cetG5VbHrCjfhSC8J5Jj1Slq/BFqa/vhjPhhgpZP
 ll/EPQm6/XNinwPcLaer24ocz5rC/A8X82hQGmqniM0q63BF0+m2Thws2vLOIb8SvR3R2ID3K
 RMUQevL0/fJOjuKBno0bmq8d4vqygfL7EzRErAZZDI3dDLydUO5ihSX0urwfxH3zYQcrsybTG
 AJheBTIfNPDoMCBhPkB+GWMa4/G05mQgCws8=
Content-Transfer-Encoding: quoted-printable

Hi Russel,

> Gesendet: Freitag, 4. Oktober 2024 um 16:35
> Von: "Russell King (Oracle)" <linux@armlinux.org.uk>
> Betreff: Re: Aw: Re: [RFC PATCH net-next v3 3/8] net: pcs: pcs-mtk-lynxi=
: add platform driver for MT7988
>
> Hi Frank,
>
> Sorry, but I've not been able to look at this, and I've completely lost
> all context now. I was diverted onto a high priority work issue for a
> while (was it from April to end of June) so didn't have much time
> available for mainline work. I then had a much needed holiday (three
> weeks) in July. I then had a clear week where I did look at mainline.
> Since then, I've had two cataract operations that have made being on the
> computer somewhat difficult, and it is only recently that I'm
> effectively "back" after what is approximately six months of not having
> a lot of bandwidth. I've seen the cataract consultant this morning, and
> just found out that my optometrist appointment for Tuesday is too soon
> after the cataract operation, and needs to be moved two weeks. The
> optometrist doesn't have availability then, so it's going to be another
> four weeks. FFS... I wish I'd known, then I could've made an
> arrangement with the optometrist months ago for the correct date.

How are you? I hope you're feeling better now....
I see you were more active on the Mailinglist in last time :)

> Now, XPCS has introduced a hack in a similar way to what you're trying
> to do, but I wasn't able to review it, so it went in. We're heading
> towards the situation where every PCS driver is going to have its own
> way to look up a PCS registered as a device. This is not going to scale.
>
> We need something better than this - and at the moment that's all I can
> say because I haven't given it any more thought beyond that so far.

Have you found some time (and were you able) to look a bit into this ([1])=
?

How would be the right way here? Daniel posted generic infrastructure for =
standalone
pcs drivers [2] similar to phy to have a generic base which all drivers ca=
n use and
which can be extended if needed.

There was some discussion about how pcs should handle if the underlaying d=
evice is removed...
unlikely on SoC, but possible on external bus devices like mdio or pcie. I=
mho this could be
a callback in common code handled by vendor driver (query information from=
 mac driver or for
SoC simply return fixed value).

How should the subsystems talk with each other (callbacks, shared memory, =
...)?

DT maintainers want to avoid syscon compatibles which are widely used for =
nodes representing only
a register range that is used from different subsystems. As we are current=
ly upstreaming mt7988
(e.g. ethernet), there are some of these "devices" which currently have no=
 own driver and only
handled by syscon driver to get the regmap. Should we really write differe=
nt drivers with additional
compatibles (duplicate code!) only to handle exchange of the regmap betwee=
n subsystems? For mt7988
which can have up to 7 syscon devices it is maybe better to have substruct=
ures like phy, pcs and so on
packed into an own driver to have a better overview in devicetree. But for=
 some functional blocks
imho it makes not much sense (when really only a regmap has to be exchange=
d between different devices).

Daniel needs an answer to his questions in [1] (and [2]) on how to proceed=
. So please help to get the
pcs-part into the right shape.

regards Frank

[1] https://patchwork.kernel.org/project/netdevbpf/patch/8aa905080bdb67608=
75d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org/
[2] https://patchwork.kernel.org/project/netdevbpf/patch/ba4e359584a6b3bc4=
b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org/

