Return-Path: <netdev+bounces-188580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48417AAD7BD
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 09:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E038B1C21017
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6DA218AB0;
	Wed,  7 May 2025 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="W5kX3QR/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LTq8UZlV"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4210218EA7;
	Wed,  7 May 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602283; cv=none; b=TLkqzDkqW9yRBODYHebZ8wCFwo1fOuMnsgvzI/7azOmatkUeXsHP5u33qWbr0ED+dsJta3BJ8jRd9dlwMhecTMGIfAIxqIVuzIW6KHabsVTI2s0jPxoCxpqCS3efyowN9Cl4Zxw3q5dEBiVWvcvREdSDNoKy/5iGmUaVWhcOiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602283; c=relaxed/simple;
	bh=VWhFCEKBlYPvVmXxGPORHIv2v+R/1XdmuxGyr+PQ0qQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJYg9HmXWC/wEd2chBmTMUd+7RBCR02d/AzPAuoT4m5CDwWkMT3ie+2Ky1HY2ojuG3Bd1fuQ5TXolhGK825UyiQsAX2jwPG61eoj7sAsK/XoNbhMMXiAoHKVVrHVxIdymc1/WrCSeR79wBZXXeTojmoOxXShN0oMQHHGpJHp56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=W5kX3QR/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=LTq8UZlV reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1746602278; x=1778138278;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yO+Y4MhfNMTUTZ9pr07tDPzmHjO2gBX5GG9mTUVcafw=;
  b=W5kX3QR/Sjhk9Rn4d1YCLOTxUNVE+lKl5uSKogMKFbESRdxxqzaSPF6L
   WttKesgQMFLRySFUvYCNzBbH6RwYu2jUVMoGk2LZvJHixcdLkAiwy3Bco
   DWFx3ZAki0H0jxBg3tH3/rbrpx0YUJIfD4joNkQNRhRKsN9Bfuhs3/5BJ
   iEo1eHYYbJOLuo6gVtj7+V9Lo1nHfHmXvmDKk7a2hDd4vB8N2GyJSuKl5
   AXSeOo4Mvcgx7zQj9rhz6kl+k6LH0PZHaWEHBjwf34uOz0zc4VAWy3sO+
   lk8lACdkrUZGcV596Awx+drBjV++wCLolZslBqyipwj/aZVqsQCy7knCk
   Q==;
X-CSE-ConnectionGUID: pwzCt8fvQrOPNNrfTlkzSg==
X-CSE-MsgGUID: qTsi4wciQUOIHKpUN3sWQQ==
X-IronPort-AV: E=Sophos;i="6.15,268,1739833200"; 
   d="scan'208";a="43925685"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 May 2025 09:17:54 +0200
X-CheckPoint: {681B0922-12-DF3E87D0-C74668F0}
X-MAIL-CPID: 98CBDFF57298EA6F096723B4CE803A74_0
X-Control-Analysis: str=0001.0A006377.681B0922.006E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 40E38160A0E;
	Wed,  7 May 2025 09:17:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1746602270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yO+Y4MhfNMTUTZ9pr07tDPzmHjO2gBX5GG9mTUVcafw=;
	b=LTq8UZlVY6QvnKnpaf07I2dsJ1jWTxn24Swr6QW+EHp3Z1qnL1zo6uq/yszH7qLELl08N6
	K3LtnAoGvE7IHu30Z4RnmQKO0WYXm4xVlYmBhdv3olpB+SVH8kob7nz0sYzXcVM/Hbgh4e
	vulnM+hKvEzCsPx1n9/+xL3e7vX4RObxNDcEiekNPejXy4YHxP+s1PpYIPdeVVfmEn866W
	mZ0NLr5CxtsWQrtMOwcRyDWcq9/UmaSc/2rflwHXlkOig7zITky0qIBs3lLGCO5xxJCnlR
	hPAHjSLbn+/LzFuG0BdxQjp81oDCURcIPDqZxESUay1zQBCGMyNpOX6E/On6mg==
Message-ID: <271c15a45f41a110416f65d1f8a44b896aa01e33.camel@ew.tq-group.com>
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chaoyi Chen
 <chaoyi.chen@rock-chips.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>,  Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 07 May 2025 09:17:45 +0200
In-Reply-To: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 2025-04-30 at 11:21 -0500, Andrew Lunn wrote:
> ********************
> Achtung externe E-Mail: =C3=96ffnen Sie Anh=C3=A4nge und Links nur, wenn =
Sie wissen, dass diese aus einer sicheren Quelle stammen und sicher sind. L=
eiten Sie die E-Mail im Zweifelsfall zur Pr=C3=BCfung an den IT-Helpdesk we=
iter.
> Attention external email: Open attachments and links only if you know tha=
t they are from a secure source and are safe. In doubt forward the email to=
 the IT-Helpdesk to check it.
> ********************
>=20
> Device Tree and Ethernet MAC driver writers often misunderstand RGMII
> delays. Rewrite the Normative section in terms of the PCB, is the PCB
> adding the 2ns delay. This meaning was previous implied by the
> definition, but often wrongly interpreted due to the ambiguous wording
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
>=20
> Fixes: 9d3de3c58347 ("dt-bindings: net: Add YAML schemas for the generic =
Ethernet options")
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> Changes in v2:
> Reword Normative section
> manor->manner
> add when using phylib/phylink
> request details in the commit message and .dts comments
> clarify PHY -internal-delay-ps values being depending on rgmii-X mode.
> Link to v1: https://lore.kernel.org/r/20250429-v6-15-rc3-net-rgmii-delays=
-v1-1-f52664945741@lunn.ch
> ---
>  .../bindings/net/ethernet-controller.yaml          | 97 ++++++++++++++++=
++++--
>  1 file changed, 90 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.ya=
ml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 45819b2358002bc75e876eddb4b2ca18017c04bd..a2d4c626f659a57fc7dcd3930=
1f322c28afed69d 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -74,19 +74,17 @@ properties:
>        - rev-rmii
>        - moca
> =20
> -      # RX and TX delays are added by the MAC when required
> +      # RX and TX delays are provided by the PCB. See below
>        - rgmii
> =20
> -      # RGMII with internal RX and TX delays provided by the PHY,
> -      # the MAC should not add the RX or TX delays in this case
> +      # RX and TX delays are not provided by the PCB. This is the most
> +      # frequent case. See below
>        - rgmii-id
> =20
> -      # RGMII with internal RX delay provided by the PHY, the MAC
> -      # should not add an RX delay in this case
> +      # TX delay is provided by the PCB. See below
>        - rgmii-rxid
> =20
> -      # RGMII with internal TX delay provided by the PHY, the MAC
> -      # should not add an TX delay in this case
> +      # RX delay is provided by the PCB. See below
>        - rgmii-txid
>        - rtbi
>        - smii
> @@ -286,4 +284,89 @@ allOf:
> =20
>  additionalProperties: true
> =20
> +# Informative
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +#
> +# 'phy-modes' & 'phy-connection-type' properties 'rgmii', 'rgmii-id',
> +# 'rgmii-rxid', and 'rgmii-txid' are frequently used wrongly by
> +# developers. This informative section clarifies their usage.
> +#
> +# The RGMII specification requires a 2ns delay between the data and
> +# clock signals on the RGMII bus. How this delay is implemented is not
> +# specified.
> +#
> +# One option is to make the clock traces on the PCB longer than the
> +# data traces. A sufficiently difference in length can provide the 2ns
> +# delay. If both the RX and TX delays are implemented in this manner,
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
> +# In practice, very few PCBs make use of extra long clock lines. Hence
> +# any RGMII phy mode other than 'rgmii-id' is probably wrong, and is
> +# unlikely to be accepted during review without details provided in
> +# the commit description and comments in the .dts file.
> +#
> +# When the PCB does not implement the delays, the MAC or PHY must.  As
> +# such, this is software configuration, and so not described in Device
> +# Tree.
> +#
> +# The following describes how Linux implements the configuration of
> +# the MAC and PHY to add these delays when the PCB does not. As stated
> +# above, developers often get this wrong, and the aim of this section
> +# is reduce the frequency of these errors by Linux developers. Other
> +# users of the Device Tree may implement it differently, and still be
> +# consistent with both the normative and informative description
> +# above.
> +#
> +# By default in Linux, when using phylib/phylink, the MAC is expected
> +# to read the 'phy-mode' from Device Tree, not implement any delays,
> +# and pass the value to the PHY. The PHY will then implement delays as
> +# specified by the 'phy-mode'. The PHY should always be reconfigured
> +# to implement the needed delays, replacing any setting performed by
> +# strapping or the bootloader, etc.
> +#
> +# Experience to date is that all PHYs which implement RGMII also
> +# implement the ability to add or not add the needed delays. Hence
> +# this default is expected to work in all cases. Ignoring this default
> +# is likely to be questioned by Reviews, and require a strong argument
> +# to be accepted.
> +#
> +# There are a small number of cases where the MAC has hard coded
> +# delays which cannot be disabled. The 'phy-mode' only describes the
> +# PCB.  The inability to disable the delays in the MAC does not change
> +# the meaning of 'phy-mode'. It does however mean that a 'phy-mode' of
> +# 'rgmii' is now invalid, it cannot be supported, since both the PCB
> +# and the MAC and PHY adding delays cannot result in a functional
> +# link. Thus the MAC should report a fatal error for any modes which
> +# cannot be supported. When the MAC implements the delay, it must
> +# ensure that the PHY does not also implement the same delay. So it
> +# must modify the phy-mode it passes to the PHY, removing the delay it
> +# has added. Failure to remove the delay will result in a
> +# non-functioning link.
> +#
> +# Sometimes there is a need to fine tune the delays. Often the MAC or
> +# PHY can perform this fine tuning. In the MAC node, the Device Tree
> +# properties 'rx-internal-delay-ps' and 'tx-internal-delay-ps' should
> +# be used to indicate fine tuning performed by the MAC. The values
> +# expected here are small. A value of 2000ps, i.e 2ns, and a phy-mode
> +# of 'rgmii' will not be accepted by Reviewers.
> +#
> +# If the PHY is to perform fine tuning, the properties
> +# 'rx-internal-delay-ps' and 'tx-internal-delay-ps' in the PHY node
> +# should be used. When the PHY is implementing delays, e.g. 'rgmii-id'
> +# these properties should have a value near to 2000ps. If the PCB is
> +# implementing delays, e.g. 'rgmii', a small value can be used to fine
> +# tune the delay added by the PCB.

Sorry for not having a look at this earlier, I got busy with something else=
.

This section doesn't really make sense to me. It is described what values
*-internal-delay-ps should have /when the PHY is implementing delays/ - but=
 at
the same time the above description leaves it open whether the MAC or the P=
HY
should implement the delays in rgmii-id mode, so the finetuning setting wou=
ld
break the delays completely if another OS decides to have the MAC instead o=
f the
PHY add the delay by default.

Best,
Matthias


>  ...
>=20
> ---
> base-commit: d4cb1ecc22908ef46f2885ee2978a4f22e90f365
> change-id: 20250429-v6-15-rc3-net-rgmii-delays-8a00c4788fa7
>=20
> Best regards,

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

