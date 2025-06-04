Return-Path: <netdev+bounces-195069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9D8ACDC2C
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 12:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C84177D65
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 10:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D293928E5E6;
	Wed,  4 Jun 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="q6ZoxAlo"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A7428DB55;
	Wed,  4 Jun 2025 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749034376; cv=pass; b=jjZq/cjerStY6zPuhWrs0VkEAiwJGPEQ21DieEQF0MxUC7S7K8fn4Pkjb3CjhR6esJpnHUw43sdrYs6r/tjp9i1PRuuxs6K9NjMGC7YBjpcbQAa8xhbbf2iCyimwB+ryZhwrw4cJnppXmRuNcTBWH7dAeWi1RhaBlP2O9ouSs1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749034376; c=relaxed/simple;
	bh=nR/LHrJoVGLjUqxTxpxdGWVYuwJ60L9TMZkpjlQV3HU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mh2reNUvupCg5AkxeWOhFV/1R+YW26jfDEwVdZnErCAiPOOJLWnOIbhMYY72M4NYOhgbA/YXIr0sbL2bOSMkp43oPZPhdI7jRugzzdFvxqkAPzvrpcUi7dh/pvCoi0eBwNF6V45KzzW+r/oZT9/gOCDz1iVU1QmaeUgeMmsMLY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=q6ZoxAlo; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1749034338; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R9riRJJ/sv0Li6EH/rmyeFTBjxmehFkTOcdm/E4NPApNXOdsYR7YpxJTG0PGcoIvpI81suJ/DDlgY8V/LbwEq2n4Sxq7xjLMeCcAd1jS6UafGGlDgjTDBRQsMXESuz/fgZgYhXVFc9BZ0kkb+lxDDOOazoW7HCWHyiUkr1LsmQI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749034338; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nR/LHrJoVGLjUqxTxpxdGWVYuwJ60L9TMZkpjlQV3HU=; 
	b=VdugbJyo72ec55W7FAszckRO4ct43KCenjwfrqSIsXYuQZeNq9dziF3kLwIicqrLWHEDHug3lkiHAxWrFlB1uC3XJB/V9mdz4D1P2yvqSWJE3kNcrkyPmZF6009kYcvsp14/XjjxpDsgQ77wf/r2frv6NsZ/Gg7G161l9ffj1iI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749034338;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=nR/LHrJoVGLjUqxTxpxdGWVYuwJ60L9TMZkpjlQV3HU=;
	b=q6ZoxAlo0pMnzbwoQgrVifuA8LaCYqMPMU37ajb8OV4pViUxjKqzlsNOrnnZORpH
	3DCGJavzD22yErAxviuOOIq6yHS23jVyPoZtnYT9nytiERNlbiHSj6/AuBvPa3h5SMt
	qogWNA/MkHTz0uK4F0tZeq4dkBVOgPX6BnjXvRFzGp/HyUPvV1G9Z3TjsAhhUWa/Eb6
	QE0NqDPGaJvhhlZ82O3NNSM67QN5MMtJtWiD91m2ilaYlwsBw9LNJL2qj1F56CMxArI
	x/18oDNlreHUcxfhk9FRV9ktxg+33ZNVe1n4tTTS4rdfGi6Drch7rSChpj/FuVQd6So
	03N4qU1Aig==
Received: by mx.zohomail.com with SMTPS id 1749034336346498.96758739824725;
	Wed, 4 Jun 2025 03:52:16 -0700 (PDT)
Message-ID: <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
From: Icenowy Zheng <uwu@icenowy.me>
To: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chaoyi Chen
 <chaoyi.chen@rock-chips.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 04 Jun 2025 18:52:06 +0800
In-Reply-To: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-04-30=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 11:21 -0500=EF=BC=
=8CAndrew Lunn=E5=86=99=E9=81=93=EF=BC=9A
> Device Tree and Ethernet MAC driver writers often misunderstand RGMII
> delays. Rewrite the Normative section in terms of the PCB, is the PCB
> adding the 2ns delay. This meaning was previous implied by the
> definition, but often wrongly interpreted due to the ambiguous
> wording
> and looking at the definition from the wrong perspective. The new
> definition concentrates clearly on the hardware, and should be less
> ambiguous.
>=20
> Add an Informative section to the end of the binding describing in
> detail what the four RGMII delays mean. This expands on just the PCB
> meaning, adding in the implications for the MAC and PHY.
>=20
> Additionally, when the MAC or PHY needs to add a delay, which is
> software configuration, describe how Linux does this, in the hope of
> reducing errors. Make it clear other users of device tree binding may
> implement the software configuration in other ways while still
> conforming to the binding.

Sorry for my late disturbance (so late that this patch is already
included in released version), but I have some questions about this...

>=20
> Fixes: 9d3de3c58347 ("dt-bindings: net: Add YAML schemas for the
> generic Ethernet options")
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> Reword Normative section
> manor->manner
> add when using phylib/phylink
> request details in the commit message and .dts comments
> clarify PHY -internal-delay-ps values being depending on rgmii-X
> mode.
> Link to v1:
> https://lore.kernel.org/r/20250429-v6-15-rc3-net-rgmii-delays-v1-1-f52664=
945741@lunn.ch
> ---
> =C2=A0.../bindings/net/ethernet-controller.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 97
> ++++++++++++++++++++--
> =C2=A01 file changed, 90 insertions(+), 7 deletions(-)
>=20
>=20
> ---
> base-commit: d4cb1ecc22908ef46f2885ee2978a4f22e90f365
> change-id: 20250429-v6-15-rc3-net-rgmii-delays-8a00c4788fa7
>=20
> Best regards,
>=20
> diff --git a/Documentation/devicetree/bindings/net/ethernet-
> controller.yaml b/Documentation/devicetree/bindings/net/ethernet-
> controller.yaml
> index
> 45819b2358002bc75e876eddb4b2ca18017c04bd..a2d4c626f659a57fc7dcd39301f
> 322c28afed69d 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -74,19 +74,17 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rev-rmii
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - moca
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # RX and TX delays are added by the MAC w=
hen required
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # RX and TX delays are provided by the PC=
B. See below

This really sounds like a breaking change that changes the meaning of
the definition of this item instead of simply rewording.

Everything written according to the original description is broken by
this change.

In addition, considering this is set as a property of the MAC device
tree node, it's more natural to represents the perspective of MAC,
instead of only describing what's on the PCB.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rgmii
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # RGMII with internal RX and TX delays pr=
ovided by the PHY,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # the MAC should not add the RX or TX del=
ays in this case
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # RX and TX delays are not provided by th=
e PCB. This is the
> most
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # frequent case. See below
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rgmii-id
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # RGMII with internal RX delay provided b=
y the PHY, the MAC
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # should not add an RX delay in this case
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # TX delay is provided by the PCB. See be=
low
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rgmii-rxid
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # RGMII with internal TX delay provided b=
y the PHY, the MAC
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # should not add an TX delay in this case
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # RX delay is provided by the PCB. See be=
low
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rgmii-txid
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rtbi
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - smii
> @@ -286,4 +284,89 @@ allOf:
> =C2=A0
> =C2=A0additionalProperties: true
> =C2=A0
> +# Informative
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +#
> +# 'phy-modes' & 'phy-connection-type' properties 'rgmii', 'rgmii-
> id',
> +# 'rgmii-rxid', and 'rgmii-txid' are frequently used wrongly by
> +# developers. This informative section clarifies their usage.
> +#
> +# The RGMII specification requires a 2ns delay between the data and
> +# clock signals on the RGMII bus. How this delay is implemented is
> not
> +# specified.
> +#
> +# One option is to make the clock traces on the PCB longer than the
> +# data traces. A sufficiently difference in length can provide the
> 2ns
> +# delay. If both the RX and TX delays are implemented in this
> manner,
> +# 'rgmii' should be used, so indicating the PCB adds the delays.
> +#
> +# If the PCB does not add these delays via extra long traces,
> +# 'rgmii-id' should be used. Here, 'id' refers to 'internal delay',
> +# where either the MAC or PHY adds the delay.
> +#
> +# If only one of the two delays are implemented via extra long clock
> +# lines, either 'rgmii-rxid' or 'rgmii-txid' should be used,
> +# indicating the MAC or PHY should implement one of the delays
> +# internally, while the PCB implements the other delay.
> +#
> +# Device Tree describes hardware, and in this case, it describes the
> +# PCB between the MAC and the PHY, if the PCB implements delays or
> +# not.
> +#
> +# In practice, very few PCBs make use of extra long clock lines.
> Hence
> +# any RGMII phy mode other than 'rgmii-id' is probably wrong, and is
> +# unlikely to be accepted during review without details provided in
> +# the commit description and comments in the .dts file.
> +#
> +# When the PCB does not implement the delays, the MAC or PHY must.=C2=A0
> As
> +# such, this is software configuration, and so not described in
> Device
> +# Tree.

Usually, in this case, this isn't pure software configuration but
already described as '?x-internal-delay-ps' (or in some legacy cases,
'vendor,?x-delay-ps') property in the MAC.

> +#
> +# The following describes how Linux implements the configuration of
> +# the MAC and PHY to add these delays when the PCB does not. As
> stated
> +# above, developers often get this wrong, and the aim of this
> section
> +# is reduce the frequency of these errors by Linux developers. Other
> +# users of the Device Tree may implement it differently, and still
> be
> +# consistent with both the normative and informative description
> +# above.
> +#
> +# By default in Linux, when using phylib/phylink, the MAC is
> expected
> +# to read the 'phy-mode' from Device Tree, not implement any delays,
> +# and pass the value to the PHY. The PHY will then implement delays
> as
> +# specified by the 'phy-mode'. The PHY should always be reconfigured
> +# to implement the needed delays, replacing any setting performed by
> +# strapping or the bootloader, etc.
> +#
> +# Experience to date is that all PHYs which implement RGMII also
> +# implement the ability to add or not add the needed delays. Hence
> +# this default is expected to work in all cases. Ignoring this
> default
> +# is likely to be questioned by Reviews, and require a strong
> argument
> +# to be accepted.

Although these PHYs are able to implement (or not to implement) the
delay, it's not promised that this could be overriden by the kernel
instead of being set up as strap pins.

Take Realtek GbE PHYs, which I am most familiar with, as examples. The
Linux realtek netphy driver supports overriding delay configuration
only for RTL8211E/F. From Internet, RTL8211B/C/E/F datasheets could be
found. All of them contain RXDLY/TXDLY strap pins, but neither of them
mention any register to config the delays, which means that on
RTL8211B/C there's no known way to override them (the only known , and
on RTL8211E/F the way to override them are undocumented registers from
unknown origin (which means no support from Realtek themselves are
available). I do partly participate a dramatic case about RTL8211E:
there were some Pine A64+ boards with broken RTL8211E that have some
delay-chain related issues, and Pine64 only got magic numbers from
Realtek to fix them (the magic numbers happen to match current RTL8211E
delay configuration code in realtek driver and show that RXDLY is
overriden to disabled).

In addition, the Linux kernel contains a "Generic PHY" driver for any
802.1 c22 PHYs to work, without setting any delays. With this driver
it's impossible to let the PHY "always be reconfigured", and
enabling/disabling the PHY-specific driver may lead to behavior change
(when enabling the specific driver, the configuration is overriden;
when disabling it, the strap pin configuration is used). Well
personally I think the driver should give out a warning when it can
read out strip pin status and it does not match the DT configuration).

The DT binding (and phylib) currently also lacks any way to describe
"respect the hardware strapping delay configuration of PHY".

> +#
> +# There are a small number of cases where the MAC has hard coded
> +# delays which cannot be disabled. The 'phy-mode' only describes the
> +# PCB.=C2=A0 The inability to disable the delays in the MAC does not
> change
> +# the meaning of 'phy-mode'. It does however mean that a 'phy-mode'
> of
> +# 'rgmii' is now invalid, it cannot be supported, since both the PCB
> +# and the MAC and PHY adding delays cannot result in a functional
> +# link. Thus the MAC should report a fatal error for any modes which

Considering compatibilty, should this be just a warning (which usually
means a wrong phy-mode setup) instead of a fatal error?

> +# cannot be supported. When the MAC implements the delay, it must
> +# ensure that the PHY does not also implement the same delay. So it
> +# must modify the phy-mode it passes to the PHY, removing the delay
> it
> +# has added. Failure to remove the delay will result in a
> +# non-functioning link.

In case of the MAC implementing a '?x-internal-delay-ps' property, when
should the MAC stripping delays from phy-mode? Should the phy-mode be
changed when MAC delaying 100ps? Should it be changed when MAC delaying
1000ps? And if the PHY could be reprogrammed to do the delay and the
property contains a big value that is higher than 2000ps, should the
software switch to do the delay in PHY and decrease the MAC side delay
by 2000ps?

Besides this, do we have any existing MAC driver that implements
stripping the delay from passing to PHY? How should we maintain
compatibilty between a DT that does not consider MAC driver delay
stripping and a driver that considers this? DTs are expected to be
backward compatible, and if this problem could not be solved, we can
never implement this intended MAC delay stripping.

My personal idea here, which reflects the current practice of most
drivers/DTs I read and leads to no known breaking change, is to make
the "phy-mode" property of the MAC node represents how the MAC expects
external components (PCB+PHY), and, assuming no significant PCB delay,
just pass this value to PHY instead. The MAC side delay shouldn't be
considered and represented in this property, but extra properties, like
'?x-internal-delay-ps' should be used instead.

> +#
> +# Sometimes there is a need to fine tune the delays. Often the MAC
> or
> +# PHY can perform this fine tuning. In the MAC node, the Device Tree
> +# properties 'rx-internal-delay-ps' and 'tx-internal-delay-ps'
> should
> +# be used to indicate fine tuning performed by the MAC. The values
> +# expected here are small. A value of 2000ps, i.e 2ns, and a phy-
> mode
> +# of 'rgmii' will not be accepted by Reviewers.

BTW the MAC might be very powerful on introducing delays, e.g. it can
have delay lines on data pins in addition to clock pins (in case of
data pins are delayed, this could be considered as a "negative clock
delay"), or some hardware might be able to do per-data-pin data delay
(to compensate HW trace length inconsistency). Should these be
considered by the standard binding, or should these be left to vendored
properties?

> +#
> +# If the PHY is to perform fine tuning, the properties
> +# 'rx-internal-delay-ps' and 'tx-internal-delay-ps' in the PHY node
> +# should be used. When the PHY is implementing delays, e.g. 'rgmii-
> id'
> +# these properties should have a value near to 2000ps. If the PCB is
> +# implementing delays, e.g. 'rgmii', a small value can be used to
> fine
> +# tune the delay added by the PCB.
> =C2=A0...


