Return-Path: <netdev+bounces-284649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id t4YgD/Ob+mkMQQMAu9opvQ
	(envelope-from <netdev+bounces-284649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:40:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F18144D555E
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 216EC301134D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6E32367B5;
	Wed,  6 May 2026 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klOQOt2N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A11DDC35;
	Wed,  6 May 2026 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031598; cv=none; b=P6UxwH/akfwjnyZ5ztg3kCDL8q1RuzRL02Hv5Sne11zFhGV7DwVjufax4v1jC79IJ9v6wGv+EHIkddMwnSPgs/I42OSQcp2jEVksWSMYfGWGUdNgsepZi9SzyVvgdvtgJCDd8sCMOUiYN+DN2Hf3YyXH/j+Mj4uVTGtH+aOc1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031598; c=relaxed/simple;
	bh=BQGZdCiy+9qafvvSVj/35RG8W5+zNt4H+FEsf2+QNls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKJhVlh8EFZ5ETjFlMOylTfHDL2ABgYC6niJB2GKELcYDbFiqnrXKVzEwmTVvNI16GeGt7A9yyfcOxXkhimriYoN2Qa/2pHa6yEbUc9sxfQvTUdxN06pfN3UeDt+E3MlgiCW4ukwAGRZ/nZJ4vu0tGVfigiIhV/8ikMGTI2/DIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klOQOt2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F8CC2BCB4;
	Wed,  6 May 2026 01:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778031598;
	bh=BQGZdCiy+9qafvvSVj/35RG8W5+zNt4H+FEsf2+QNls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klOQOt2NUUs42giQpZN3e4ABXa1zImNPX/S6H1xIAAmewWJu76pU4sX0fY9k4W3Zt
	 GuNTqj3vjzb/XIIM8S0P89eaMB+60Ivi4RG6rNiDrLS5fYjWZcoMhFtod1FiDyz5Xw
	 LL+q6J2JW0SFKtqLJkaEQXDzI7IPLkh2LZkdaESJ2lJPj+8E9hygIH8yGh2FceQA/p
	 2FSOsa78m0QsDvi8+MzN5KJAyBra8DD13IfEEW8d8s9U6ZlwsL9ME2/Tw8pdaDV4bn
	 TqDBzm3jwYWVh6NiMLtGLQZhisZKEO2fVVCA5ttj6r1kodNjnol1ZUU3uHyn+9VH52
	 /A+/7hc5CZ+/Q==
Date: Tue, 5 May 2026 20:39:55 -0500
From: Rob Herring <robh@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: joey@tinyisr.com, netdev@vger.kernel.org, horms@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, andrew@lunn.ch, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH net-next v3 1/4] dt-bindings: net: dsa: add MT7628 ESW
Message-ID: <20260506013955.GA267946-robh@kernel.org>
References: <20260428185510.261521-2-joey@tinyisr.com>
 <20260430235621.3080081-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430235621.3080081-1-kuba@kernel.org>
X-Rspamd-Queue-Id: F18144D555E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[tinyisr.com,vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-284649-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.5:email,0.154.68.48:email,0.0.0.7:email,0.0.0.6:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tinyisr.com:email,devicetree.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 04:56:21PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "Since Andrew requested some changes already here is the
> AI review to look thru as well (could be false positives)."
> ---
> Subject: dt-bindings: net: dsa: add MT7628 ESW
> 
> This patch adds a new YAML device tree binding for the Embedded Switch
> block found in the MediaTek MT7628 SoC. The binding describes a five
> port switch with integrated 10/100 PHYs plus an internally connected
> 1G CPU port, together with reset lines and an optional MDIO subnode.
> 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
> > new file mode 100644
> > index 000000000000..a9db9057ee54
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/dsa/mediatek,mt7628-esw.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mediatek MT7628 Embedded Ethernet Switch
> > +
> > +maintainers:
> > +  - Joris Vaisvila <joey@tinyisr.com>
> 
> This isn't a bug, but the maintainers list only contains the submitter
> at an unrelated domain. Existing in-tree MediaTek DSA bindings such as
> Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml list
> multiple MediaTek or long-standing MediaTek-community maintainers.
> 
> For an official MediaTek SoC's built-in switch IP, would it make sense
> to CC or co-list a MediaTek networking maintainer (Sean Wang, Landen
> Chao, Daniel Golle, ...) so the hardware description can be
> corroborated and the binding ABI has long-term stewardship?
> 
> > +
> > +description:
> > +  The MT7628 SoC's built-in Ethernet Switch is a five port switch with
> > +  integrated 10/100 PHYs. The switch registers are directly mapped in the SoC's
> > +  memory. The switch has an internally connected 1G CPU port and 5 user ports
> > +  connected to the built-in Fast Ethernet PHYs.
> 
> Is the description internally consistent?
> 
> The first sentence says "a five port switch with integrated 10/100
> PHYs", but the following sentences describe "an internally connected
> 1G CPU port and 5 user ports", which is six ports in total. The
> example below also enumerates six ports (reg = 0..4 and 6).
> 
> Could this be reworded as e.g. "5 user ports plus 1 internal CPU
> port" to avoid the ambiguity?
> 
> Separately, there is no justification in the commit message or
> binding for the absence of a clocks property. MT7628 peripherals are
> typically gated by syscon clock outputs (see
> arch/mips/boot/dts/ralink/mt7628a.dtsi), and
> drivers/net/ethernet/mediatek/mtk_eth_soc.c already treats "esw" as a
> named clock.
> 
> The MT7628 ESW driver added alongside this binding deliberately does
> not call any clk_* API, which is a valid design choice if the esw
> gate is always on after reset. Since DT bindings are ABI, though,
> adding a clocks property later would be a backward-incompatible
> change.
> 
> Could the commit message explain why no clocks property is needed, or
> alternatively could clocks/clock-names be described in the binding
> now even if the initial driver ignores them?
> 
> > +
> > +unevaluatedProperties: false
> > +
> > +allOf:
> > +  - $ref: dsa.yaml#/$defs/ethernet-ports
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt7628-esw
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    items:
> > +      - description: internal switch block reset
> > +      - description: internal phy package reset
> > +
> > +  reset-names:
> > +    items:
> > +      - const: esw
> > +      - const: ephy
> > +
> > +  mdio:
> > +    $ref: /schemas/net/mdio.yaml#
> > +    unevaluatedProperties: false
> 
> The mdio subnode is referenced here and is actually consumed by the
> driver (drivers/net/dsa/mt7628.c mt7628_setup_internal_mdio() calls
> of_get_available_child_by_name(..., "mdio") and
> devm_of_mdiobus_register()), but the binding provides no description
> of when or why a user would populate it.
> 
> Given the top-level description says the PHYs are "integrated" and
> "internally connected", when should an mdio subnode be present? Is an
> external MDIO master ever supported?
> 
> A short description attached to the mdio property would make the
> intent clear to DT authors.
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - resets
> > +  - reset-names
> > +  - ethernet-ports
> 
> Should the valid port reg values be constrained here?
> 
> The MT7628 ESW has a fixed, well-known set of valid port indices
> (0..4 for user ports and 6 for the CPU, with port 5 not existing).
> See mt7628_phylink_get_caps() in drivers/net/dsa/mt7628.c, which
> explicitly comments that "port 5 does not exist on MT7628".
> 
> As written the schema accepts ethernet-port@5 or ethernet-port@7 at
> dt_binding_check time, even though the driver will silently ignore
> them. Would adding a reg enum constraint on the ethernet-port
> children (e.g. via patternProperties, or an override of the
> $defs/ethernet-ports reg) catch these mistakes at schema-validation
> time?
> 
> > +
> > +examples:
> > +  - |
> > +    switch0: switch@10110000 {

This label is unused and should be dropped.

> > +        compatible = "mediatek,mt7628-esw";
> > +
> > +        reg = <0x10110000 0x8000>;
> > +
> > +        resets = <&sysc 23>, <&sysc 24>;
> > +        reset-names = "esw", "ephy";
> > +
> > +        ethernet-ports {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> [ ... ]
> > +            ethernet-port@6 {
> > +                reg = <6>;
> > +                phy-mode = "internal";
> > +                ethernet = <&ethernet>;
> 
> The example references an undefined phandle here: ethernet-port@6
> uses ethernet = <&ethernet> but no node labelled "ethernet" is defined
> in the example snippet.
> 
> Other DSA binding examples in Documentation/devicetree/bindings/net/dsa/
> typically either provide a minimal stub for referenced phandles inside
> the example or use a reg-based reference. Will dt_binding_check emit a
> warning about the unresolved phandle as written?

No, example phandles don't have to resolve to a provider and we 
actively don't want providers in the examples. 

Rob

