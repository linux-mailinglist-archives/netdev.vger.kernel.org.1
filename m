Return-Path: <netdev+bounces-305764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MtJSGRouTmr/EgIAu9opvQ
	(envelope-from <netdev+bounces-305764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:01:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 860657249C7
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:01:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jXP0cTh7;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305764-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305764-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A742E30D84AD
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D406B400DE1;
	Wed,  8 Jul 2026 10:56:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2E425CCB;
	Wed,  8 Jul 2026 10:56:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508173; cv=none; b=bKVNWpZlQqNXX8cQJLgG0llXaaACeq5KLZVQfE68If2ei3QknvX7Z83LojMQvVDhIcE4AaxWnBdRhvfOp1+vFpLt5FCi3TdNyLc+8ZTeCI1PxubipzBRdcAOWxnNCS7AOKqoi5Egv5BP9KmlKNkk+Z3tsoJprS3PQuvKhO6ZYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508173; c=relaxed/simple;
	bh=aOVJdv1u/8St0FjT9BGxdCg4gHdYSbuUsEmv+23i/7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWn+8OMtaOlpOLlo3Noy1MLJCGf5+cHdlDeWv8uM0hf/ToJw7IgaSSCrdrHxjKzEMMxdcISqmLNNUCNdBI8zyfXZ4TL07yi1+QfsKNATz0FPE8YTb1+lkvYihnyNAOqfNCGloIz+MQEYBWpawKB0KBBn+zZTc3tiTOMPeg4+lKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXP0cTh7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD88B1F000E9;
	Wed,  8 Jul 2026 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783508166;
	bh=qfv7NHEZROLc4ny4kch2W339mc8lcjfZtZAX5Iqn7VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jXP0cTh7ufw0koNao5auuHSOFneiEm+vZjfQQ8k9mJxGp8ye17YT8Mal47a5UgXPL
	 MUuKS5XiMdIxAk87ExUMJsTTQIos5sOrWzP6/khedZbFYW3ZYNjTx+VXYuf8Fo1ARs
	 NDfiMBDZ7Q+PXRhO/OgE7bf8WTeVwlJTwTTFYxlmRd4ZgZARoOh8OyBKoE0O8M1MtX
	 TT/63MVqwAacs8k7th8hAJy6dgeJqzUmbf3/HZ2ItaYwjitLlCZtXrg+SOHo7OBToZ
	 zNrh8sS0GsR4prkSnhU+MpANu+pyMN+dJuUlLaBspk1MaTpQKUopZIXI13WBWJVHu5
	 Q7HSAi/+D4P7Q==
Date: Wed, 8 Jul 2026 12:56:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mikhail Lukianchikov <avermoal@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>, UNGLinuxDriver <UNGLinuxDriver@microchip.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: convert microchip,lan78xx.txt to YAML
 schema
Message-ID: <20260708-tireless-pillbug-from-eldorado-5c17f9@quoll>
References: <20260707165840.107409-1-avermoal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707165840.107409-1-avermoal@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:avermoal@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305764-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,quoll:mid,bootlin.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 860657249C7

On Tue, Jul 07, 2026 at 10:58:40PM +0600, Mikhail Lukianchikov wrote:
> Convert the Microchip LAN78xx family (LAN7800, LAN7801, LAN7850) binding
> documentation from plain text to DT schema format using YAML.

Subject: there is no YAML schema

https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> 
> The conversion was validated with 'make dt_binding_check'

Drop, irrelevant and not even true. There is no point in writing in
commit msg that you performed the absolute minimal expected build
testing. It is expected.


> 
> Signed-off-by: Mikhail Lukianchikov <avermoal@gmail.com>

...

You left stale maintainer entry. Checkpatch told you that, no? Did you
run checkpatch?

If this is your first contribution then you need to read carefully
guidelines how to contribute and then actually follow these guidelines.
What does evry guideline speak about? Checkpatch.

> diff --git a/Documentation/devicetree/bindings/net/microchip,lan78xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan78xx.yaml
> new file mode 100644
> index 000000000000..743667c1e761
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,lan78xx.yaml


microchip,lan7800.yaml

> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/microchip,lan78xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN78xx Gigabit Ethernet controller
> +
> +maintainers:
> +  - Rengarajan Sundararajan <Rengarajan.S@microchip.com>
> +  - UNGLinuxDriver <UNGLinuxDriver@microchip.com>

Drop last email.

> +
> +description:
> +  The LAN78XX devices are usually configured by programming their OTP or with
> +  an external EEPROM, but some platforms (e.g. Raspberry Pi 3 B+) have neither.
> +  The Device Tree properties, if present, override the OTP and EEPROM.
> +
> +allOf:
> +  - $ref: /schemas/usb/usb-device.yaml#
> +  - $ref: /schemas/net/ethernet-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - usb424,7800
> +      - usb424,7801
> +      - usb424,7850

Odd format. Missing blank lines. Look at existing code to understand how
this is supposed to look like.

> +  reg:
> +    maxItems: 1
> +    description: USB port number
> +  local-mac-address:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 6
> +    maxItems: 6
> +    description:
> +      MAC address to use if not stored in OTP or EEPROM. If present,
> +      overrides OTP/EEPROM.
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +
> +patternProperties:
> +  "^ethernet-phy(@[0-9a-f]+)?$":
> +    type: object
> +    description: |
> +      PHY node for the embedded or external PHY. The PHY address is
> +      given by the 'reg' property.
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description: PHY address.
> +      microchip,led-modes:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 1
> +        maxItems: 4
> +        description:
> +          Array of LED mode values for each of up to 4 LEDs.
> +          Omitted LEDs are turned off. Allowed values are defined
> +          in include/dt-bindings/net/microchip-lan78xx.h.
> +    required:
> +      - reg
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/net/microchip-lan78xx.h>
> +    / {
> +        usb: usb {
> +            compatible = "usb-host";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +        };
> +    };
> +    &usb {

Drop all this, irrelevant and not even close to expected style.

> +        usb-port@1 {
> +            compatible = "usb424,2514";

Drop node

> +            reg = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            usb-port@1 {
> +                compatible = "usb424,2514";

Drop node, not relevant to this binding.

Again, look at other bindings to understand what to write. Or read
DTS101 slides.

> +                reg = <1>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;

Best regards,
Krzysztof


