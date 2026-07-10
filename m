Return-Path: <netdev+bounces-306694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kgwJDOxiUWq3DgMAu9opvQ
	(envelope-from <netdev+bounces-306694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:23:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E1473ECD2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:23:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jWn1bSXJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306694-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306694-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0C0F3008457
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31B3B71C9;
	Fri, 10 Jul 2026 21:23:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B543B635A;
	Fri, 10 Jul 2026 21:23:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718626; cv=none; b=RtaFkE6nOrVdB1A1xIt/OfC5fXbsxOGXteMu85LaBG5yI6/XVrZ3FcliFuD+vxlNEgqsxiDgt1tR3b9/K9h0JYOvQ8qCuiqdfsxSnkCUC+wUZ5GTzp6EA/buofh3fMkj1hbmclrOOhs7j4l0UPeCfRpL+/FTIhK8ZmGcl3aPuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718626; c=relaxed/simple;
	bh=+VN4renEdc2d/0bLepWBjVDrddFRQmfQpMaTvR57hEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGNOH5uMbieAYl3IDR8qhGm+vszlc0QiNC8RAOYyEMttzvhABrCvmldfTCpDke3nRbSK4B9nkiWrhXZLydl+sl4eEE4lygMr063c4whTbK6tNqpk6V8o93t3MygE17GszpVuR1GB15+LH6Pt5jsNDEsaknuKHl7yx/ZquOWTXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWn1bSXJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645351F000E9;
	Fri, 10 Jul 2026 21:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783718625;
	bh=3Vpd1ysaO1UoALGaiGz3UnmHGdjhUtw80tYrdFEd//8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jWn1bSXJGBgR/PMhevp19UNRRDpEkdALV+CKLK4NwSjWi9EEw7HmiPUUt8m66gHj8
	 ed3uIgOOaOM29jJ39Bgr16kpGWy/zyZEBu5FvN8yn8Z8ha1yzM/+pOOtAe43HEpAm2
	 tbfzYDY0v0fC0LESy8B9pt2KZy3Xh8XsCLuzyslmLMyqclxPxn+jMsm2Eoor4wmUa9
	 Iu8b/prblcTcFK63wg4qjW3qXSRMmoMojXKd6Z9rJ9Z4xfBZLq7mUP6RnL1ylT7KPx
	 jKHusINy126UId6PJA0puehAeMDCVsUs8Mf/8YM53MVP2Iw5PmnX6aIa7imq1yiOKN
	 Wgjm27KFFMmWw==
Date: Fri, 10 Jul 2026 16:23:44 -0500
From: Rob Herring <robh@kernel.org>
To: Mikhail Lukianchikov <avermoal@gmail.com>
Cc: Rengarajan.S@microchip.com, andrew+netdev@lunn.ch, conor+dt@kernel.org,
	davem@davemloft.net, devicetree@vger.kernel.org,
	edumazet@google.com, krzk+dt@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v2] dt-bindings: net: microchip,lan78xx: convert to DT
 schema
Message-ID: <20260710212344.GA1351459-robh@kernel.org>
References: <20260709181724.24682-2-avermoal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709181724.24682-2-avermoal@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:avermoal@gmail.com,m:Rengarajan.S@microchip.com,m:andrew+netdev@lunn.ch,m:conor+dt@kernel.org,m:davem@davemloft.net,m:devicetree@vger.kernel.org,m:edumazet@google.com,m:krzk+dt@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306694-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37E1473ECD2

On Fri, Jul 10, 2026 at 12:17:25AM +0600, Mikhail Lukianchikov wrote:
> Convert the Microchip LAN78xx family (LAN7800, LAN7801, LAN7850) binding
> documentation from plain text to DT schema.
> 
> The conversion adds proper validation for the 'microchip,led-modes'
> property inside the MDIO node and updates the MAINTAINERS entry.
> 
> Signed-off-by: Mikhail Lukianchikov <avermoal@gmail.com>
> ---
> Changes in v2:
>  - Rename file to microchip,lan7800.yaml.
>  - Keeps only one maintainer.
>  - Code style fixed.
>  - Example fixed, remove usb-port@1 node.
>  - Move patternProperties for PHY inside mdio node to fix validation. (suggested by sashiko-bot)
> 
> Link to v1: https://lore.kernel.org/netdev/20260707165840.107409-1-avermoal@gmail.com
> 
>  .../bindings/net/microchip,lan7800.yaml       | 105 ++++++++++++++++++
>  .../bindings/net/microchip,lan78xx.txt        |  53 ---------
>  MAINTAINERS                                   |   3 +-
>  3 files changed, 106 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan7800.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan7800.yaml b/Documentation/devicetree/bindings/net/microchip,lan7800.yaml
> new file mode 100644
> index 000000000000..289980c23181
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,lan7800.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/microchip,lan7800.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN7800/LAN7801/LAN7850 Gigabit Ethernet controller
> +
> +maintainers:
> +  - Rengarajan Sundararajan <Rengarajan.S@microchip.com>
> +
> +description:
> +  The LAN7800/LAN7801/LAN7850 devices are usually configured by
> +  programming their OTP or with an external EEPROM, but some
> +  platforms (e.g. Raspberry Pi 3 B+) have neither. The Device Tree
> +  properties, if present, override the OTP and EEPROM.
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
> +
> +  reg:
> +    maxItems: 1
> +    description: USB port number
> +
> +  local-mac-address:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 6
> +    maxItems: 6
> +    description:
> +      MAC address to use if not stored in OTP or EEPROM. If present,
> +      overrides OTP/EEPROM.
> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +
> +    patternProperties:
> +      "^ethernet-phy(@[0-9a-f]+)?$":
> +        type: object

Is there some reason standard phy properties are not valid here? If not, 
then add:

	   $ref: /schemas/net/ethernet-phy.yaml#
           unevaluatedProperties: false

> +        description: |
> +          PHY node for the embedded or external PHY. The PHY address is
> +          given by the 'reg' property.

Drop. That's true for every MDIO bus.

> +
> +        properties:
> +          reg:
> +            maxItems: 1
> +            description: PHY address.
> +
> +          microchip,led-modes:
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            minItems: 1
> +            maxItems: 4
> +            description:
> +              Array of LED mode values for each of up to 4 LEDs.
> +              Omitted LEDs are turned off. Allowed values are defined
> +              in include/dt-bindings/net/microchip-lan78xx.h.
> +
> +        required:
> +          - reg
> +
> +        additionalProperties: false
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

Drop root node.

> +        usb {
> +            compatible = "usb-host";

Drop fake compatibles.

> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ethernet@1 {
> +                compatible = "usb424,7800";
> +                reg = <1>;
> +                local-mac-address = [00 11 22 33 44 55];
> +
> +                mdio {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                    ethernet-phy@1 {
> +                        reg = <1>;
> +                        microchip,led-modes = <
> +                            LAN78XX_LINK_1000_ACTIVITY
> +                            LAN78XX_LINK_10_100_ACTIVITY
> +                        >;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...

