Return-Path: <netdev+bounces-276557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADt1GJ5b1mmNEggAu9opvQ
	(envelope-from <netdev+bounces-276557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:43:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D71DE3BD19E
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D3C0304F7E9
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636733CF677;
	Wed,  8 Apr 2026 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt3bC8Xe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF613B27D9;
	Wed,  8 Apr 2026 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655814; cv=none; b=dK1VT9tMO02jnbn3i1b34a6m3AB6E3ML1N8eA1tCOuEFau7KLTUVzo7qpU711DKPFHjs5frQzgGfrY1YkIeBZhnUp5C7PJiWEDFjNLZfIIFHTOAScVtFLwjiXYhsOvroHlV+vUot3qlZcUgqGvAiEx8fCbUio7LpZnkYuJ793VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655814; c=relaxed/simple;
	bh=Jnf+ozIJ0XTw1JCMnYaJZUZHhfGsLNJN8+qXwRREUr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAKFIWtoAJmpHSmN2UAFTfshG47CPXx+xkxG/TbafaPt74CgrvMKcVEcPfgLiFh9vDhjjcmn4CDAXlWfibLICYphOzDBQlINZZmctHELb0Ybe6M3GIRn5yieN63gvMP9s+NTRb4kk2a3TBY+BXq4kIlhDKKRX5W7/JJ08QFSwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt3bC8Xe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10FEC19421;
	Wed,  8 Apr 2026 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775655813;
	bh=Jnf+ozIJ0XTw1JCMnYaJZUZHhfGsLNJN8+qXwRREUr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mt3bC8Xe9YNXi3EsiPIIrgv1kM+5SxXDvsMb9MUTEOGB3pT07SjJYGbg9+3EoDK1j
	 vKdq+5bCpanKobBYgd/O41JfRtzIxnnxjZ+u76vIZnvcYXJd1BCeU9JjjwYZevpHJp
	 rCjgAuUQl1uVWtuiIKsPteMb8rQhG2JjkFSUHfqzX4mafdhXqtJFeN+XldMJd0keDJ
	 fPcUqM25T50HfFxuR68n0h7bi9HqtKYa5jcJ43na8sX3duRMt8BmntVQPT8mwJb2Jg
	 LGGfYOvAw8/wkpAO5CNSVSYHBvve9NR+cSpXeQ3zJwNhldH0IC4E5lq2EXOt0v3qq8
	 4e8sJieQoD/WA==
Date: Wed, 8 Apr 2026 08:43:31 -0500
From: Rob Herring <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, f.fainelli@gmail.com, frank.li@nxp.com,
	chleroy@kernel.org, horms@kernel.org, linux@armlinux.org.uk,
	andrew@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 02/14] dt-bindings: net: dsa: add NETC switch
Message-ID: <20260408134331.GA1954185-robh@kernel.org>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
 <20260331113025.1566878-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331113025.1566878-3-wei.fang@nxp.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-276557-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.3:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.2:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devicetree.org:url,0.0.0.0:email,0.0.0.1:email,nxp.com:email]
X-Rspamd-Queue-Id: D71DE3BD19E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 07:30:13PM +0800, Wei Fang wrote:
> Add bindings for NETC switch. This switch is a PCIe function of NETC IP,
> it supports advanced QoS with 8 traffic classes and 4 drop resilience
> levels, and a full range of TSN standards capabilities. The switch CPU
> port connects to an internal ENETC port, which is also a PCIe function
> of NETC IP. So these two ports use a light-weight "pseudo MAC" instead
> of a back-to-back MAC, because the "pseudo MAC" provides the delineation
> between switch and ENETC, this translates to lower power (less logic and
> memory) and lower delay (as there is no serialization delay across this
> link).
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/net/dsa/nxp,netc-switch.yaml     | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> new file mode 100644
> index 000000000000..5577f3ef987f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/nxp,netc-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NETC Switch family
> +
> +description: >
> +  The NETC presents itself as a multi-function PCIe Root Complex Integrated
> +  Endpoint (RCiEP) and provides full 802.1Q Ethernet switch functionality,
> +  advanced QoS with 8 traffic classes and 4 drop resilience levels, and a
> +  full range of TSN standards capabilities.
> +
> +  The CPU port of the switch connects to an internal ENETC. The switch and
> +  the internal ENETC are fully integrated into the NETC IP, a back-to-back
> +  MAC is not required. Instead, a light-weight "pseudo MAC" provides the
> +  delineation between the switch and ENETC. This translates to lower power
> +  (less logic and memory) and lower delay (as there is no serialization
> +  delay across this link).
> +
> +maintainers:
> +  - Wei Fang <wei.fang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1131,eef2
> +
> +  reg:
> +    maxItems: 1
> +
> +  dsa,member:
> +    description: >
> +      The property indicates DSA cluster and switch index. For NETC switch,
> +      the valid range of the switch index is 1 ~ 7, the index is reflected
> +      in the switch tag as an indication of the switch ID where the frame
> +      originated. The value 0 is reserved for ENETC VEPA switch, whose ID
> +      is hardwired to zero.
> +
> +$ref: dsa.yaml#

Move this under the 'allOf' so all $ref's are together.

> +
> +patternProperties:
> +  "^(ethernet-)?ports$":

'ethernet-ports' for new bindings.

> +    type: object
> +    additionalProperties: true
> +    patternProperties:
> +      "^(ethernet-)?port@[0-9a-f]$":

And 'ethernet-port'

> +        type: object
> +
> +        $ref: dsa-port.yaml#
> +
> +        properties:
> +          clocks:
> +            items:
> +              - description: MAC transmit/receive reference clock.
> +
> +          clock-names:
> +            items:
> +              - const: ref
> +
> +          mdio:
> +            $ref: /schemas/net/mdio.yaml#
> +            unevaluatedProperties: false
> +            description:
> +              Optional child node for switch port, otherwise use NETC EMDIO.
> +
> +        unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - dsa,member
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-device.yaml
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        ethernet-switch@0,2 {
> +            compatible = "pci1131,eef2";
> +            reg = <0x200 0 0 0 0>;
> +            dsa,member = <0 1>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_switch>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    phy-handle = <&ethphy0>;
> +                    phy-mode = "mii";
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    phy-handle = <&ethphy1>;
> +                    phy-mode = "mii";
> +                };
> +
> +                port@2 {
> +                    reg = <2>;
> +                    clocks = <&scmi_clk 103>;
> +                    clock-names = "ref";
> +                    phy-handle = <&ethphy2>;
> +                    phy-mode = "rgmii-id";
> +                };
> +
> +                port@3 {
> +                    reg = <3>;
> +                    ethernet = <&enetc3>;
> +                    phy-mode = "internal";
> +
> +                    fixed-link {
> +                        speed = <2500>;
> +                        full-duplex;
> +                        pause;
> +                    };
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 

