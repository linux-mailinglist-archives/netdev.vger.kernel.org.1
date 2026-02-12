Return-Path: <netdev+bounces-258512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPTAI9BBjmltBQEAu9opvQ
	(envelope-from <netdev+bounces-258512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:10:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FA813124B
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BBE307AA54
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8248C2D94B5;
	Thu, 12 Feb 2026 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKedIuS7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1A1DB125
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770930634; cv=none; b=SYG2/qNG1spFee6J8xsjn58Dl+n8n741RXddomCiPb9EHyRkuYpOT/X208T+49f+vc3mSsBv+9nyGROwqWyc3Mce+dfhJBJBOnxYBASIYKkQh4srL/8KOzgo+b9gxfxiBpwodQRbLUVk74rd77QjMugoKBDItPggwfL95ysBvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770930634; c=relaxed/simple;
	bh=mvdPPd9MTlAzGcEDHBnGOWpQp3W0SRG282ox6GhN6yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVZ29jNkD7pj2SaSgwX0QmZV7fVNFZdQBeHdhzq70st48a95J74iJ6GRZ8y64NJAaL2XH/s7jvy/Pl2HR+zO+CRXDclT20/+nrRBEph8qhXcGZ27cZcR7fQtYWy8GNVOHdFxPYMXPGqBjcH0FkM7UJcKlTdkcaH2UNtShGhNF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKedIuS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E266C2BCAF
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 21:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770930634;
	bh=mvdPPd9MTlAzGcEDHBnGOWpQp3W0SRG282ox6GhN6yU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MKedIuS7UHjUhPjWdfzeH7gPRKU9MGbhvFeNiyA4RcYeeFQjbnJ2z68IdbptFVcxS
	 Hftd1/ErHqlf6F1LHtuf3bP31mAy6nscejBalABRjCZKIDmhWUFI1LIDpWNA8p0LFq
	 jXxV1TPNwC2eQdhcjjP9vrht2WKzaRRnZL1sk6+G563h7bUBu3MRe7nsaEI9YFLwM2
	 2/217ZxlFyDOqe2kmSMZf2GkOpJSMKGi2/es+J/b9YUsxmD4tPlzB8nmvaYVsRLiPl
	 KDYDkaGYXDg4gIY0qg3Si7ap1P1O3BN+evLrMc9IWrM7y856l7oosyY5oDgaHCJIaG
	 P7CxikvdtY8sg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8f8d80faebso205715766b.1
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 13:10:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdmDQE9O14ebC5WsR5g/dATbkEvhNGEEP3TvZnr2lCbSG+Ia/V+OUqvU6IdNyNLCX9oVsQ84U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8r5bZFhhxnHjG4YCeaE7o9o7esvs9+HXknKUregJIH5E0pHJ
	5UIaOkhfmYZH2CbSo6OyOUAYXYX4Tj2f/CHTcRZFE+4XUQilDFM/N9FVSHIKIm1KOSW+Ym1fi5C
	rNmf29qdoEj/dZ3+XUdDdBcCGvH/kgA==
X-Received: by 2002:a17:907:72d2:b0:b73:37aa:87c0 with SMTP id
 a640c23a62f3a-b8f9069c11fmr208094466b.23.1770930632527; Thu, 12 Feb 2026
 13:10:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203161917.1666696-1-vincent.guittot@linaro.org>
 <20260203161917.1666696-2-vincent.guittot@linaro.org> <20260210004011.GA2188625-robh@kernel.org>
 <CAKfTPtA299R7yn3r=tCqhhP_tK3E_UpGSMrDLyRP4Ccwt1m58g@mail.gmail.com>
In-Reply-To: <CAKfTPtA299R7yn3r=tCqhhP_tK3E_UpGSMrDLyRP4Ccwt1m58g@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 12 Feb 2026 15:10:20 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+SswpTjQShfkdhVwL_k8gJ_5+NrecPCUiFR52UB5zNMA@mail.gmail.com>
X-Gm-Features: AZwV_QjelX9NLva1DLDx_tMGAWuQk_3-b-qqDMfkQH9yt3x_72JwdyevIvbKnTI
Message-ID: <CAL_Jsq+SswpTjQShfkdhVwL_k8gJ_5+NrecPCUiFR52UB5zNMA@mail.gmail.com>
Subject: Re: [PATCH 1/4 v2] dt-bindings: serdes: s32g: Add NXP serdes subsystem
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com, 
	p.zabel@pengutronix.de, linux@armlinux.org.uk, ghennadi.procopciuc@nxp.com, 
	Ionut.Vicovan@nxp.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	horms@kernel.org, Frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258512-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:email,devicetree.org:url,0.0.0.0:email]
X-Rspamd-Queue-Id: D6FA813124B
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 1:17=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 10 Feb 2026 at 01:40, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Feb 03, 2026 at 05:19:14PM +0100, Vincent Guittot wrote:
> > > Describe the serdes subsystem available on the S32G platforms.
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  .../bindings/phy/nxp,s32g-serdes.yaml         | 154 ++++++++++++++++=
++
> > >  1 file changed, 154 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/nxp,s32g-se=
rdes.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.ya=
ml b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> > > new file mode 100644
> > > index 000000000000..fad34bee2a4f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> > > @@ -0,0 +1,154 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/phy/nxp,s32g-serdes.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NXP S32G2xxx/S32G3xxx SerDes PHY subsystem
> > > +
> > > +maintainers:
> > > +  - Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > > +
> > > +description: |
> > > +  The SerDes subsystem on S32G SoC Family includes two types of PHYs=
:
> > > +    - One PCIe PHY: Supports various PCIe operation modes
> > > +    - Two Ethernet Physical Coding Sublayer (XPCS) controllers
> > > +
> > > +  SerDes operation mode selects the enabled PHYs and speeds. Clock f=
requency
> > > +  must be adapted accordingly. Below table describes all possible op=
eration
> > > +  modes.
> > > +
> > > +  Mode  PCIe XPCS0           XPCS1           PHY clock       Descrip=
tion
> > > +                SGMII                SGMII             (MHz)
> > > +  ------------------------------------------------------------------=
-------
> > > +  0  Gen3    N/A             N/A             100             Single =
PCIe
> > > +  1  Gen2    1.25Gbps        N/A             100             PCIe/SG=
MII
> > > +  2  Gen2    N/A             1.25Gbps        100             PCIe/SG=
MII
> > > +  3  N/A     1.25Gbps        1.25Gbps        100,125         SGMII
> > > +  4  N/A     3.125/1.25Gbps  3.125/1.25Gbps  125             SGMII
> > > +  5  Gen2    N/A             3.125Gbps       100             PCIe/SG=
MII
> >
> > Mixed tabs and spaces. Drop the tabs.
>
> okay
>
> >
> > What's not clear to me is do you have 2 or 4 lanes?
>
> 2 lanes per serdes
> as an example mode 0 is one PCIe x2 lane
> and mode 1 is one PCIe x1 and one xpcs0/SGMII on lane 1
> or mode 3 is one  xpcs0/SGMII on lane 0 and one xpcs1/SGMII on lane 1

Still confused. So 2 total lanes?

>
> >
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - enum:
> > > +          - nxp,s32g2-serdes
> > > +      - items:
> > > +          - const: nxp,s32g3-serdes
> > > +          - const: nxp,s32g2-serdes
> > > +
> > > +  reg:
> > > +    maxItems: 4
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: ss_pcie
> > > +      - const: pcie_phy
> > > +      - const: xpcs0
> > > +      - const: xpcs1
> > > +
> > > +  clocks:
> > > +    minItems: 4
> > > +    maxItems: 5
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: axi
> > > +      - const: aux
> > > +      - const: apb
> > > +      - const: ref
> > > +      - const: ext
> > > +    minItems: 4
> > > +
> > > +  resets:
> > > +    maxItems: 2
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: serdes
> > > +      - const: pcie
> > > +
> > > +  nxp,sys-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> >
> >        maximum: 5
> >
> > Though isn't this redundant with the child nodes? You could use the
> > standard 'phy-mode' property in each child.
>
> not really because we can have mode 1 but only a node to describe
> lane0 for PCIe x1 if the lane 1 is not used
>
> >
> > > +    description: |
> > > +      SerDes operational mode. See above table for possible values.
> > > +
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > > +patternProperties:
> > > +  '^serdes[0,1]_lane@[0,1]$':
> >
> > Do you need to support serdes0_lane@0 and serdes1_lane@0 (or similar
> > with "@1")? That's illegal as you have 2 nodes with the same address.
>
> okay, we can find other naming
>
> >
> > > +    description:
> > > +      Describe a serdes lane.
> > > +    type: object
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        enum:
> > > +          - nxp,s32g2-serdes-pcie-phy
> > > +          - nxp,s32g2-serdes-xpcs
> >
> > Seems like phy-mode would be sufficient. Are these separate blocks from
> > the parent?
>
> Isn't phy-mode only for ethernet phy ?

Sorry, it is "phy-type" that I was thinking about. That takes the
types defined in dt-bindings/phy/phy.h. The type can be defined either
in "phy-type" or in the phy cells if the type is per identifier.

Really, Given each lane doesn't have any of its own resources, I'd
probably get rid of the child nodes and put the type into the phy
cells. Then you'd have something like this:

// PCIE on lanes 0 and 1 (mode 0)
pcie {
  phys =3D <&phy 0 PHY_TYPE_PCIE>, <&phy 1 PHY_TYPE_PCIE>;
};

// PCIE on lane 0 (mode 1)
pcie {
  phys =3D <&phy 0 PHY_TYPE_PCIE>;
};
// Ethernet on lane 1
ethernet {
  phys =3D <&phy 1 PHY_TYPE_SGMII>;
};

I perhaps don't have the cells right if it is more than just lane 0
and lane 1, but you can put anything there you want. The cell
definition is provider specific.

If you need to get the overall system wide configuration, that can be
done. It's not terribly efficient, but you can iterate all 'phys'
nodes in the DT, find the ones for your provider (&phy) and examine
the cell values.

Rob

