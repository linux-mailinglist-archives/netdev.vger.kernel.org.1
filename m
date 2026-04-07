Return-Path: <netdev+bounces-276108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GqfJxw91WlY3AcAu9opvQ
	(envelope-from <netdev+bounces-276108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:21:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 010DC3B24AD
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28EAD3009B28
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93808332EBB;
	Tue,  7 Apr 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlKBhjI0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA952D8DDB;
	Tue,  7 Apr 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582337; cv=none; b=g6VYhM+XFkFbsO0fzKPS4hla04VJNgBYthpxpHPbAbLgciqVuvI3QP+4gPGImXVIFZlkRrsMFibwao/KjIyaSWFbvgrBC5XxBerHTJunLGRfGCZTPXlAzknj0abwnWKJFP0yPgGNm4Kd1A2bX6fa0jeDUQIvA6xzCdCTZjXjk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582337; c=relaxed/simple;
	bh=m1m7h4QphIAQUyXPSQecb83YrVM+SkqzayDgGu1BM7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPEtl806d6kJcBQsX9oXZJdyfKP8fegG8gGK3gzysTLgdEaxXfzpPybf1fW+v6FohO0z/m0t8th9ReCje6JbyQ/gfCBTGc5rbWLLHX+1pqnnNgBTbw1CSSssAO08sJagPNGgRuprg0cmd0F9/d7YozkFSxJkyXQAm6tJGY/9UW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlKBhjI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEC4C19424;
	Tue,  7 Apr 2026 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775582337;
	bh=m1m7h4QphIAQUyXPSQecb83YrVM+SkqzayDgGu1BM7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlKBhjI0rZt+3tJZ7uqpZR330yZOC8A14QptAdoSyBzlR8G2UN3TxdH4t/s1uOCTS
	 gsFPdFUb00ihGPvMPlkCHf1wlo6Pna9jHxnX4jHUrVDGTRZi+ZvVWifEANRNd2lKNV
	 4SmC45spFfIKA1rNpLdHShPbpcmiaHQnW+6kk5OdjfcOfFmCOR9iBzae2crasrTcTu
	 8fhm3ihNW2BMN2DOVhTm5bBGMuw91S7Zms3j85p8zjF2fcRMjHj4rK+oer2Q01raGf
	 vXBDbKd8tU14jZPZOoGANlIta60OKUgY89nYT5g1bPyAQ4T6L67m8La88E60XoeVk4
	 b60UQcd0zqGRg==
Date: Tue, 7 Apr 2026 12:18:54 -0500
From: Rob Herring <robh@kernel.org>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/9] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
Message-ID: <20260407171854.GA2970003-robh@kernel.org>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-0-f7504e3b0681@microchip.com>
 <20260324-dsa_lan9645x_switch_driver_base-v2-2-f7504e3b0681@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324-dsa_lan9645x_switch_driver_base-v2-2-f7504e3b0681@microchip.com>
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
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276108-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email,0.0.0.7:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.3:email,0.0.0.2:email]
X-Rspamd-Queue-Id: 010DC3B24AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:46:45AM +0100, Jens Emil Schulz Østergaard wrote:
> Add bindings for LAN9645X switch. We use a fallback compatible for the
> smallest SKU microchip,lan96455s-switch.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> ---
> Changes in v2:
> - rename file to microchip,lan96455s-switch.yaml
> - remove led vendor property
> - add {rx,tx}-internal-delay-ps for rgmii delay
> - remove labels from example
> - remove container node from example
> ---
>  .../net/dsa/microchip,lan96455s-switch.yaml        | 119 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 120 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
> new file mode 100644
> index 000000000000..0282e25c05d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/microchip,lan96455s-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN9645x Ethernet switch
> +
> +maintainers:
> +  - Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> +
> +description: |

Don't need '|'

> +  The LAN9645x switch is a multi-port Gigabit AVB/TSN Ethernet switch with
> +  five integrated 10/100/1000Base-T PHYs. In addition to the integrated PHYs,
> +  it supports up to 2 RGMII/RMII, up to 2 BASE-X/SERDES/2.5GBASE-X and one
> +  Quad-SGMII interfaces.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - microchip,lan96455s-switch
> +      - items:
> +          - enum:
> +              - microchip,lan96455f-switch
> +              - microchip,lan96457f-switch
> +              - microchip,lan96459f-switch
> +              - microchip,lan96457s-switch
> +              - microchip,lan96459s-switch
> +          - const: microchip,lan96455s-switch
> +
> +  reg:
> +    maxItems: 1
> +
> +$ref: dsa.yaml#

Since you don't have any custom properties (just constraints), this ref 
should be "dsa.yaml#/$defs/ethernet-ports".

> +
> +patternProperties:
> +  "^(ethernet-)?ports$":

For a new binding, use the preferred name which is ethernet-ports. ports 
and port collide with the graph binding.

> +    type: object
> +    additionalProperties: true
> +    patternProperties:
> +      "^(ethernet-)?port@[0-8]$":

And 'ethernet-port'

> +        type: object
> +        description: Ethernet switch ports
> +
> +        $ref: dsa-port.yaml#
> +
> +        properties:
> +          rx-internal-delay-ps:
> +            const: 2000
> +
> +          tx-internal-delay-ps:
> +            const: 2000
> +
> +        unevaluatedProperties: false

Place this after the $ref.

> +
> +oneOf:
> +  - required:
> +      - ports
> +  - required:
> +      - ethernet-ports
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ethernet-switch@4000 {
> +        compatible = "microchip,lan96459f-switch", "microchip,lan96455s-switch";
> +        reg = <0x4000 0x244>;
> +
> +        ethernet-ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                phy-mode = "gmii";
> +                phy-handle = <&cuphy0>;
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +                phy-mode = "gmii";
> +                phy-handle = <&cuphy1>;
> +            };
> +
> +            port@2 {
> +                reg = <2>;
> +                phy-mode = "gmii";
> +                phy-handle = <&cuphy2>;
> +            };
> +
> +            port@3 {
> +                reg = <3>;
> +                phy-mode = "gmii";
> +                phy-handle = <&cuphy3>;
> +            };
> +
> +            port@7 {
> +                reg = <7>;
> +                phy-mode = "rgmii";
> +                ethernet = <&cpu_host_port>;
> +                rx-internal-delay-ps = <2000>;
> +                tx-internal-delay-ps = <2000>;
> +
> +                fixed-link {
> +                    speed = <1000>;
> +                    full-duplex;
> +                    pause;
> +                };
> +            };
> +        };
> +    };
> +...
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ae698067c41..8232da1b3951 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17278,6 +17278,7 @@ M:	Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
>  M:	UNGLinuxDriver@microchip.com
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
>  F:	include/linux/dsa/lan9645x.h
>  F:	net/dsa/tag_lan9645x.c
>  
> 
> -- 
> 2.52.0
> 

