Return-Path: <netdev+bounces-254885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDd6B8Sie2kVHgIAu9opvQ
	(envelope-from <netdev+bounces-254885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:11:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 517F1B36AC
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BA963028EE6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49842356A2A;
	Thu, 29 Jan 2026 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyhDE2IP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC933A030;
	Thu, 29 Jan 2026 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710255; cv=none; b=XFlqSAF4//HSd0eRrtmG/0cLqA8OeFoxCUG4yrKrAqoo3l6qAtw0qBeknWZi4mCvBcQjJBWyZhKg5GiwYwgv6psV4m1t+GRjoUwXqf5yeQroR+0M2J6iwypzPMYWX9P+HD01ytCQCYnGOEfj/+zDUis8l8U8oM6SoZLCaD/0RVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710255; c=relaxed/simple;
	bh=gj6Kch/gDkrYPm7SM9ELLrMVc5N6rJh2Q7URFp3VW/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7QvZ0m/aTmTqVg9k5lxAaMYk/X9Vr03p4JTJTo3hY6RqWRwcQx8HCbVBlfL4U0s3QxTHcJB6SzqqqsQL5nWyVFuOh/SOyGFGYCYUhJGa8amMTa2joldi5NoM/Ywz2wh/ASbquaU4njbhCVsXrojts/5PHlM9mRWxrK+FnA5DLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyhDE2IP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF603C4CEF7;
	Thu, 29 Jan 2026 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769710254;
	bh=gj6Kch/gDkrYPm7SM9ELLrMVc5N6rJh2Q7URFp3VW/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YyhDE2IPcS/cAQR0wIW11PJgANDsZsHaTeJR/n/efou4KjLS7ZC0L67E9POaW8nZH
	 Pgk91Z/PT8X2DZ2gguN1Mql6a1WjpwUGS/ByFge7TOAbl24d1wI1Ygj1wdoPvHO/n9
	 PS+5BRI/5d469v+b4HQRDtDuUYhEKCZUEYutq4mVGVKBS2XBwmRsRCR+SgHxfg/W1m
	 o5rrJ7pnvCaldVc+GVhVHZYn5Vp4qzPBjjT4/r8Gp0R8LPhP0AsQN2qorFbKBRv5sn
	 dkGt1BnfOgyxetysIdqvGFVPOFZl1VX6qOIwM0tVreljqGk91mfmu+DdZyRxA8lTgs
	 5eU/eot4xT2oQ==
Date: Thu, 29 Jan 2026 12:10:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 net-next 09/15] dt-bindings: net: dsa: sja1105:
 document the PCS nodes
Message-ID: <176971025335.1390033.17907150388219680260.robh@kernel.org>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-10-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122105654.105600-10-vladimir.oltean@nxp.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,bootlin.com,redhat.com,lunn.ch,gmail.com,linux.intel.com,kernel.org,armlinux.org.uk,vger.kernel.org,trustnetic.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-254885-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.10.201.184:email,0.10.197.208:email,0.10.205.160:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.10.193.232:email,0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 517F1B36AC
X-Rspamd-Action: no action


On Thu, 22 Jan 2026 12:56:48 +0200, Vladimir Oltean wrote:
> Some (not all) use cases are in dire need of describing the XPCS blocks
> embedded in the NXP SJA1105 and SJA1110 switches in the device tree.
> The use case driving this effort is specifying custom 'rx-polarity' or
> 'tx-polarity' property values.
> 
> These PCS blocks follow the same bindings as the other instances which
> are memory-mapped using an APB3 or MCI interface.
> 
> Since the SJA1105 applies the
> Documentation/devicetree/bindings/net/ethernet-switch.yaml schema
> directly on the SPI device OF node, its bindings are incompatible with
> describing address space regions where sub-devices like the XPCS exist.
> Namely, ethernet-switch.yaml wants #address-cells and #size-cells = <0>
> to satisfy the unit-address-less '^(ethernet-)?ports$' child node.
> But the XPCS sub-devices want their unit address to be the start
> of their "reg" region in the switch address space, and that
> requires #address-cells and #size-cells = <1>.
> 
> If the SPI device OF node had an MFD-style schema, i.e. "(1)" from here:
> https://lore.kernel.org/netdev/20260109121432.lu2o22iijd4i57qq@skbuf/
> things would have been simpler. But that ship has sailed and we need to
> continue supporting the direction in which the SJA1105 bindings have
> started already.
> 
> The retrofit-ready compromise solution is for the ethernet-switch to
> define a custom "regs" sub-node with #address-cells and #size-cells = <1>,
> and this will hold any memory-mapped sub-devices, like the XPCS in this
> case.
> 
> This solution could have been used for the "nxp,sja1110-base-t1-mdio"
> and "nxp,sja1110-base-tx-mdio" sub-devices too (although that ship has
> also sailed), and is further extensible for other SJA1110 sub-devices
> not yet supported (GPIO controller, cascaded IRQ controller).
> 
> Document the XPCS integration-specific compatible string, positioning in
> the switch's "regs" subnode, and the pcs-handle to them.
> 
> The "type: object" addition in the ethernet-port node is to suppress
> a dt_binding_check warning that states "node schemas must have a type
> or $ref". Rob Herring explains why this started being required just now:
> https://lore.kernel.org/netdev/20251120173012.GA1563834-robh@kernel.org/
> 
> Because the regs and ethernet-pcs nodes are optional, I don't want to
> pollute the example with them. However, I think I can add them to the
> commit message:
> 
> compatible = "nxp,sja1105s";
> ...
> regs {
> 	#address-cells = <0x01>;
> 	#size-cells = <0x01>;
> 
> 	ethernet-pcs@0 {
> 		compatible = "nxp,sja1105-pcs";
> 		reg = <0x00 0x800000>;
> 		reg-names = "direct";
> 		reg-io-width = <0x04>;
> 		tx-polarity = <PHY_POL_INVERTED>;
> 	};
> };
> 
> compatible = "nxp,sja1110a";
> ...
> regs {
> 	#address-cells = <0x01>;
> 	#size-cells = <0x01>;
> 
> 	ethernet-pcs@705000 {
> 		compatible = "nxp,sja1110-pcs";
> 		reg = <0x705000 0x1000>;
> 		reg-names = "indirect";
> 		reg-io-width = <0x04>;
> 		tx-polarity = <PHY_POL_NORMAL>;
> 	};
> 
> 	ethernet-pcs@706000 {
> 		compatible = "nxp,sja1110-pcs";
> 		reg = <0x706000 0x1000>;
> 		reg-names = "indirect";
> 		reg-io-width = <0x04>;
> 		tx-polarity = <PHY_POL_NORMAL>;
> 	};
> 
> 	ethernet-pcs@707000 {
> 		compatible = "nxp,sja1110-pcs";
> 		reg = <0x707000 0x1000>;
> 		reg-names = "indirect";
> 		reg-io-width = <0x04>;
> 		tx-polarity = <PHY_POL_NORMAL>;
> 	};
> 
> 	ethernet-pcs@708000 {
> 		compatible = "nxp,sja1110-pcs";
> 		reg = <0x708000 0x1000>;
> 		reg-names = "indirect";
> 		reg-io-width = <0x04>;
> 		tx-polarity = <PHY_POL_NORMAL>;
> 	};
> };
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: rewrite commit message
> 
>  .../bindings/net/dsa/nxp,sja1105.yaml         | 27 +++++++++++++++++++
>  .../bindings/net/pcs/snps,dw-xpcs.yaml        |  8 ++++++
>  2 files changed, 35 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


