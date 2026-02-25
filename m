Return-Path: <netdev+bounces-260968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DCQFMQAn2lAYgQAu9opvQ
	(envelope-from <netdev+bounces-260968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:01:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC90319878C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2060C30152FC
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A73D3D331D;
	Wed, 25 Feb 2026 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHdNK1Dz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E71F03DE
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772028089; cv=pass; b=uoTn7Pa1L4xKLLE0FO8HCV2bMJAEWaMz/mD2xd9JDPEh6pwuTX4QS4ZAsi9MHLr2SBWPaWi5g0Itd5u3Y0NpP615FY8xRhzENjPBGevQ+dyTw3O+zkvdDPsypDKns+2c57STFpkvcvSDAiVZWlisSQua4NCsJQMadpp6UtPc3Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772028089; c=relaxed/simple;
	bh=5Ju3OHVhNRhJLBEGBDX8Dh0cbgt/b4S0cI5EoETOJUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2iV3b+t2xkCdcwkza9xyDADom4VuqRKyA+ARIJ8qcfXLkHFfwOBbCXQbmzCBqj/CJQuK9UWMzFVRK2hJc515vaLDv0pdxFdDPPOrMYDLS+eIuOD+UvCxROblH8F1PhRZFvT4W6ghELhb08M7bPXYzsHlCDoSv+pIP/1rhXyC6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jHdNK1Dz; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9047e72201so990522866b.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 06:01:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772028086; cv=none;
        d=google.com; s=arc-20240605;
        b=VznS17QdH/upjyd2LyMEM2mciuuotkk8Fst4nY9rWzG1ACvFGG6GwK+0skxodSSbtN
         Tvwiard5V39KjZcyn9aPbT4G2zZgA3Ko0OXYB6TUG/YqeHl55BLcGsCrPUSf4abJMMcW
         aIE2C8/iJL+nJa2J377qcX28pUIPTmTSLQkKvUe/3i0SkvVtiFSJNwSdR12LG3M4hYBv
         pzby2TkejDj2HdoZGbkzv2sMfMKHusWqvWGEcWetAdq30yT1zSLeX1QKqX9WSD0eC6Sp
         s2ppV4MqFttUshTYzxL1zEz4ta62LOKgoLKVPIkQLQKLL1erK/lklK76F2R0ilsJ+62u
         hNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Vy6cNiKVqqdOzrXGU51JG+BLZ2VHPDg76L+Bf6A/K7w=;
        fh=QQ6RUWmd0XDyicqKNRKkmRM4bjkG1UegudntuwhBBDM=;
        b=GjjAqrCvub5vCXAz1vESraSS+A8LrJipt5qVvQENWNNBr+24lmxRfYtgnJvpJLcgpF
         990fjI0GlTlgPQIuskM/xjB32+A711NxSnnUYz/AknLSSVaPQdtF+jS9eWLGhn4tLoQ2
         fOWhIyrxzeKJ1Lk6TpLbb4zU8fzBHW7E8HV9N+6oJdHBBkYTOjPP66cnTV23FG9ESAes
         vwJaTVMx+TeqSfItq7QHJCyeZxbyftdEZ0YGzdjSV/35Got6rfDbsAHxiDKpZCH4U/c3
         U+Nw4aAojwhMfa6isM5O2cudTGW1IK1Pf+V2iXdLmzaIJSZkJHt95R0rOiJB0VaBagZL
         RAnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772028086; x=1772632886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy6cNiKVqqdOzrXGU51JG+BLZ2VHPDg76L+Bf6A/K7w=;
        b=jHdNK1Dziza9lJ6rugocpTGVZu/G3QSLFYrvyupXi/mIgIyldKtdPGj/zZiwE9RlgA
         5Veug2uCKJ70ahbrTzYODxc16HSLU4p2ca1FmK9pYEoToy3AJofN6PNjB3tw4QmUXr3V
         CEg8XRe62zw5EMgfrJGoHTM/iB2gMOw41WHryzUP6Ev5VIVfAxA/k0tZCeAyGJUKX9Jl
         yIpK8w8Vg/fLhtMzrEZVWg6taW+G3BNuytDf0czNjKg4B78rjh+ddsay3nF17+Tovq5O
         WIWDQ4wa9HvK94c3Fv0t+Fa7ndtJmOzEMw9xv6iwiM0FEHCg9SVzWKTkbqNxn+HAeiPW
         bXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772028086; x=1772632886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vy6cNiKVqqdOzrXGU51JG+BLZ2VHPDg76L+Bf6A/K7w=;
        b=DhbetONOM9+MvIalzIm/TIrZCL4a4MYDF7FLXgm1Jyor3d4G+uvt5BIBw+3hvN5rYn
         3/61F/1QBPHRPe/A3/DUmgtrtUx9d3sOpaedfIgiMUK2i8BFfPahygYEgLB7D+3BBQ90
         JOFObZbvX4LMSD7Xukz5Db9gLL8hWHRUf1xFCTVSL8Bd3WMgq1JjnTg81+ECqRom8KFe
         KAGuudgdH8Vd2IzYWJVii9Z/8hT1RiMqB3tcs8iz2KD3eZvg7M/bRlvdn5eAO3Mu8AMV
         VffU74ZvcAyXnTa/qv40cWO7cpdSWC5+q67l7uOFF4x4ljbWH6ZR8RR09S0Z1XpQGIuD
         BLCw==
X-Forwarded-Encrypted: i=1; AJvYcCWKj1V5hcLAaMIFUgb/LKOq9G8JwWeJoIAxaJSsh1zswpoHEHaPi6gnld/ScVYv0dsgC1q71/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG38p0DC6eof4RBk1vkgK5UmA8YB0GFikUtViN4DM9QATiNlZT
	k7x0h/8PxVxy0i0rYlIP7QmteRx32S1gx17MwY4LKvvYEbcpW0eR3UxlOhIYJgk04StqMu45R8S
	j/nASntR6S52fQssFi4V+x7O6+DMqd5/n9sqEM5tU0g==
X-Gm-Gg: ATEYQzxzkuG5bCoN+RV0nYiENuCGoHRmoOg970JEcU66kas4KPgLybOFXOIplnCs806
	Cv6hdAmhCoA2XTQ5uQD3o50HUJ0c53Ncf482yPKJ2St2Kc95Q4rQkedmxDWBG3Fy66khPBfmlSu
	ZLvddVzDIa8oMELM8hQmmhUJT2cOkGXAGCgyTFtOcelCb9rY9aleWEinPoxIrWN975mdcLYbL6q
	gpclksldpjD/vQFty2G7W8CdPdq+T1FRYXRKCFGSD12Sd5rsNnDFWtKji8NqptvQpuvULDPsuX4
	arFkmetDGr19RHl5E5bXO0SNJPEkZPM8ow==
X-Received: by 2002:a17:907:2d89:b0:b93:5297:b3a2 with SMTP id
 a640c23a62f3a-b935297b3bdmr8044466b.59.1772028085419; Wed, 25 Feb 2026
 06:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203161917.1666696-1-vincent.guittot@linaro.org>
 <20260203161917.1666696-2-vincent.guittot@linaro.org> <20260210004011.GA2188625-robh@kernel.org>
 <aY2rR3Hlm525kGUN@shell.armlinux.org.uk>
In-Reply-To: <aY2rR3Hlm525kGUN@shell.armlinux.org.uk>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Feb 2026 15:01:13 +0100
X-Gm-Features: AaiRm52xymbtUvdX0WARhHIKYaRvNgdQ5-vzrvF5qBi6nov6q2mJRcNPXMItfGk
Message-ID: <CAKfTPtBB6ZNde+-t7FKkf0F5Uvy0rDvebM_fsGTy9tk=CBq6Xg@mail.gmail.com>
Subject: Re: [PATCH 1/4 v2] dt-bindings: serdes: s32g: Add NXP serdes subsystem
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Rob Herring <robh@kernel.org>, vkoul@kernel.org, neil.armstrong@linaro.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, 
	s32@nxp.com, p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com, 
	Ionut.Vicovan@nxp.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	horms@kernel.org, Frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260968-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[armlinux.org.uk:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[linux.armlinux.org.uk:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:dkim,armlinux.org.uk:url,armlinux.org.uk:email]
X-Rspamd-Queue-Id: AC90319878C
X-Rspamd-Action: no action

Sorry for the delayed reply. Some days off kept me away from keyboard

On Thu, 12 Feb 2026 at 11:28, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Feb 09, 2026 at 06:40:11PM -0600, Rob Herring wrote:
> > On Tue, Feb 03, 2026 at 05:19:14PM +0100, Vincent Guittot wrote:
> > > +description: |
> > > +  The SerDes subsystem on S32G SoC Family includes two types of PHYs:
> > > +    - One PCIe PHY: Supports various PCIe operation modes
> > > +    - Two Ethernet Physical Coding Sublayer (XPCS) controllers
> > > +
> > > +  SerDes operation mode selects the enabled PHYs and speeds. Clock frequency
> > > +  must be adapted accordingly. Below table describes all possible operation
> > > +  modes.
> > > +
> > > +  Mode  PCIe       XPCS0           XPCS1           PHY clock       Description
> > > +                SGMII              SGMII             (MHz)
> > > +  -------------------------------------------------------------------------
> > > +  0        Gen3    N/A             N/A             100             Single PCIe
> > > +  1        Gen2    1.25Gbps        N/A             100             PCIe/SGMII
> > > +  2        Gen2    N/A             1.25Gbps        100             PCIe/SGMII
> > > +  3        N/A     1.25Gbps        1.25Gbps        100,125         SGMII
> > > +  4        N/A     3.125/1.25Gbps  3.125/1.25Gbps  125             SGMII
> > > +  5        Gen2    N/A             3.125Gbps       100             PCIe/SGMII
> >
> > Mixed tabs and spaces. Drop the tabs.
> >
> > What's not clear to me is do you have 2 or 4 lanes?
> >
> ...
> > > +  nxp,sys-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> >
> >        maximum: 5
> >
> > Though isn't this redundant with the child nodes? You could use the
> > standard 'phy-mode' property in each child.
>
> phy-mode is ethernet, but the above is more than just ethernet.
>
> I've been wondering why a generic PHY driver needs to know this via DT
> when the generic PHY API has:
>
> phy_set_mode() / phy_set_mode_ext()
>  - sets the type of the PHY and its submode (e.g. ethernet interface
>     mode)
> phy_set_speed()
> phy_set_bus_width()
>
> Surely these are sufficient to describe what mode is required from the
> generic PHY, and the generic PHY driver can figure out whether the
> mode is permitted from the above table, programming the PHY as
> desired.

For the lanes that output SGMII, we don't register a generic phy
driver but we provide the pcs with

pcs-handle = <&phy_xpcs0_0>;

>
> For Ethernet, we don't call the 3.125Gbps "SGMII" using that term. We
> use SGMII strictly for Cisco SGMII, which runs at 1.25Gbps. 3.125Gbps
> single-lane serdes ethernet is not able to use Cisco SGMII inband
> signalling because running the underlying data rate with 10 or 100
> symbol replications makes no sense. So we have decided to all this
> 2500BASE-X. If such a SerDes is connected to a SFP cage, then we
> support switching between 1.25Gbps and 3.125Gbps mode depending on
> the module inserted, which requires dynamic reconfiguration of the
> SerDes.

yes, I still have to figure out how to handle 3.125Gbps and 2500BASE-X mode

>
> What I'm saying is that describing a single mode covering several ports
> could make things difficult in the future, so make sure you think
> carefully.

The serdes mode (deciding wether to output pcie or ethernet for each
lane) has to be decided before de-asserting the reset of the HW IP so
we can't really make it dynamic



>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

