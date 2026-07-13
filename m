Return-Path: <netdev+bounces-307256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YN/eGe0eVWrLkAAAu9opvQ
	(envelope-from <netdev+bounces-307256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:22:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6842774DF9D
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:22:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h6CPcYBE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307256-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307256-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9891630055D5
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A513451BB;
	Mon, 13 Jul 2026 17:22:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33CF233927;
	Mon, 13 Jul 2026 17:22:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963367; cv=none; b=aBYUYSePecM2Pio8kcI71b99VF9U56Ui4LX8HbhFxBhTvzQKWeda0UpPJutGBbxq+1IRsk08f2sU1hg4zXYBmMQCyjHgS9jtH2rZRCR7Jv6/ikgLrh7aD6wJBvEvqwghxc2pV98zw0JUFFhADFkTEaQaF+WdZGXTIdLxmqTUKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963367; c=relaxed/simple;
	bh=g+vhJSXwVVp0B1AdYaIbya2zpO3k0rRRtdsZQVc4uGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP6wV6tuQkMKFh0l0uCZ8ybzwRzds/P39q88Q1V0QNggX1i33VsicLD0cbdbdJ8X5ejP2XVI4k9jzvsR/WIPmzL2Trz0Qv1mIdsJZTXp0vojWD2+hKP56WzhajCXl2iTq55B82XWCCCNw8fNtLpehpJpM+duoQaBYkEmFNRy1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6CPcYBE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B021F000E9;
	Mon, 13 Jul 2026 17:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783963365;
	bh=f64DKGw4L3GDO0y6c1glEqqaBeuOQTvvXS+WHu+RmSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h6CPcYBEwzndAd4AElnUwOJ+aRCrfdQChsIzSoUabA2Q9F80bser4Hq3iV3Qbj+vI
	 scEj+k2pGVCVW6g8EpC5VYaBtp8B30P7l5LQqVcrfh8o2DZWjAZijXG/otMyINVy9C
	 7/LEVdBLZwzuh9WJYvHPPiths1qRMRDIIqB6QBITIX/5uGeb0g+Uw7f1HzU/Ci/PCT
	 5Q+Z1AIuMGldFG0CJ51pm/8OB5v+mHMCIqyquFqBTZyaD7HqznDUHwM3AgE32iDCqT
	 +vMAnFCo5jgWJdATx3NNiCinDdg1u2Aq+Ux74jcwO5EgubulQUe6DMIlhRq077mJjC
	 X17gg5E8u5JPg==
Date: Mon, 13 Jul 2026 12:22:44 -0500
From: Rob Herring <robh@kernel.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: add DAPU Telecom
 DAP8211R(I) PHY binding
Message-ID: <20260713172244.GA2381778-robh@kernel.org>
References: <20260713131223.279555-1-a.shimko.dev@gmail.com>
 <20260713131223.279555-2-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713131223.279555-2-a.shimko.dev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307256-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:a.shimko.dev@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:ashimkodev@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6842774DF9D

On Mon, Jul 13, 2026 at 04:12:22PM +0300, Artem Shimko wrote:
> Add device tree binding documentation for the DAPU Telecom DAP8211R(I)
> Gigabit Ethernet PHY.
> 
> The PHY supports TX and RX clock delays in 150 ps steps from 0 to 2250 ps,
> with a default of 1950 ps if not specified. The tx-inverted-clk flag
> provides a vendor-specific extension for boards where PCB trace length or
> MAC requirements necessitate 180-degree clock phase shift.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
> ---
>  .../bindings/net/dapu,dap8211r.yaml           | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml b/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
> new file mode 100644
> index 000000000000..208a82f779d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dapu,dap8211r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY
> +
> +maintainers:
> +  - Artem Shimko <a.shimko.dev@gmail.com>
> +
> +description: |
> +  The DAP8211R(I) is a Gigabit Ethernet PHY with RGMII interface,
> +  supporting IEEE 802.3az Energy Efficient Ethernet, IEEE 1588 SyncE,
> +  and an internal packet generator for diagnostics.
> +
> +  Specifications:
> +    - 10BASE-Te, 100BASE-TX, 1000BASE-T
> +    - RGMII with configurable TX/RX clock delays (150 ps steps, 0-2250 ps)
> +    - IEEE 802.3az-2010 Energy Efficient Ethernet
> +    - IEEE 1588 SyncE support
> +    - Internal packet generator and checker for link diagnostics
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +properties:
> +  compatible:
> +    const: ethernet-phy-id0008.011b
> +
> +  reg:
> +    maxItems: 1
> +
> +  rx-internal-delay-ps:
> +    description:
> +      RGMII RX clock delay in picoseconds. The PHY supports 150 ps steps
> +      from 0 to 2250 ps. If not specified, defaults to 1950 ps. If the
> +      requested value does not exactly match a supported step, the driver
> +      selects the nearest supported value and issues a warning.
> +    enum: [0, 150, 300, 450, 600, 750, 900, 1050, 1200, 1350, 1500,
> +           1650, 1800, 1950, 2100, 2250]
> +    default: 1950
> +
> +  tx-internal-delay-ps:
> +    description:
> +      RGMII TX clock delay in picoseconds. The PHY supports 150 ps steps
> +      from 0 to 2250 ps. If not specified, defaults to 1950 ps. If the
> +      requested value does not exactly match a supported step, the driver
> +      selects the nearest supported value and issues a warning.
> +    enum: [0, 150, 300, 450, 600, 750, 900, 1050, 1200, 1350, 1500,
> +           1650, 1800, 1950, 2100, 2250]

This would also work:

multipleOf: 150
maximum: 2250

> +    default: 1950
> +
> +  tx-inverted-clk:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present, the RGMII TX clock to the MAC is inverted (180 degree
> +      phase shift relative to the data lines). This is a vendor-specific
> +      extension for boards where PCB trace length or MAC requirements
> +      necessitate clock inversion. Only use this property after hardware
> +      signal integrity validation.
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy@1 {
> +            compatible = "ethernet-phy-ieee802.3-c22";
> +            reg = <1>;
> +            rx-internal-delay-ps = <1050>;
> +            tx-internal-delay-ps = <1150>;
> +            tx-inverted-clk;
> +        };
> +    };
> \ No newline at end of file

With this fixed,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

