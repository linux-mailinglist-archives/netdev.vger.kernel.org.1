Return-Path: <netdev+bounces-287978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EfvHvjVBWrxbwIAu9opvQ
	(envelope-from <netdev+bounces-287978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:02:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9532D542B5C
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 167C53004622
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EAF3FA5D6;
	Thu, 14 May 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6invqMj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70A3F7AA5;
	Thu, 14 May 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767293; cv=none; b=sh95G1TgktMNM7YqQg2vRQS78IUrAr6A4WydRFBrszdGwYFbSXtQi1pnIbaNMnxUg3GzmyqL6PkS4K0pomhTjVDCQBRN8wJa/NHcChPoTzcC0YDNC+YcxIHC8qHz7wWMWzsotcdokHvL/6nN0mOcB6kcFUlkYLWNy5AuxeH8f40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767293; c=relaxed/simple;
	bh=c7NzlGc2Oa8BkxrzwZWZKrQ6FyrgJTWKz6ir2QBJXRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BULnkcFagX9yTuHA7akl8+FTwiIeQHnIND2tR1aUwIpSFXX2hiWgt1epQEGWUQzboZqZef30Faz5NhUqjawydRreHnkdrclveq6mZXhzOfr+GNbczNxK2cMlViO1vVnSo5ncsXQxEfVOkCV0cz3AwzmSgVfCocq60q3SLEbVqI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6invqMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078B5C2BCB3;
	Thu, 14 May 2026 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767293;
	bh=c7NzlGc2Oa8BkxrzwZWZKrQ6FyrgJTWKz6ir2QBJXRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6invqMjY+PGy270uP9TV40zDHyH23UF+ovuq+zYQqNiU4YMZVAqRCU5bq8KPEmw6
	 zfuPLzUHJuhhpjAI0DYU8LF+zv5DlMHgYWZNGARHlpER27ETGKdSzWY41lcLM00CSN
	 tNFmnByX66E31B7ns4Cq+q8q2FuOVEB9wQs6myX7tVGmm+mb9s3cz5h9DLHnPvomEv
	 dI1DEpWMrJf6xrLAnwPaL+xFOV+pWiiSXglJ7BHyCb3AcHIXkfJP2A8qa0CuctK8Vz
	 fhAILwQNw7EKTvDtd/02mbr6mqsVMIcBfrSmBIG9yxPWcui3FjmLyaGqm8vIFuAued
	 1iwb9gjxir+Ow==
Date: Thu, 14 May 2026 09:01:30 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 01/12] dt-bindings: net: airoha: Add EN7581
 ethernet-ports properties
Message-ID: <20260514140130.GA257001-robh@kernel.org>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
 <20260511-airoha-eth-multi-serdes-v6-1-c899462c4f75@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-airoha-eth-multi-serdes-v6-1-c899462c4f75@kernel.org>
X-Rspamd-Queue-Id: 9532D542B5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-287978-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.4:email];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RSPAMD_EMAILBL_FAIL(0.00)[ethernet.0.0.0.1:query timed out,lorenzo.kernel.org:query timed out];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0.0.0.1:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 12:49:27PM +0200, Lorenzo Bianconi wrote:
> EN7581 and AN7583 SoCs support connecting multiple external SerDes to GDM3
> or GDM4 ports via a hw arbiter that manages the traffic in a TDM manner.
> As a result multiple net_devices can connect to the same GDM{3,4} port
> and there is a theoretical "1:n" relation between GDM ports and
> net_devices.
> Introduce the ethernet-port property in order to model a given net_device
> that is connected via the external arbiter to the GDM{3,4} port (that
> is represented by the ethernet property. Please note GDM1 or GDM2 does not
> support the connection with the external arbiter and are represented
> by ethernet property.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-eth.yaml | 64 +++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> index fbe2ddcdd909..642f300c0945 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> @@ -130,6 +130,50 @@ patternProperties:
>          maximum: 4
>          description: GMAC port identifier
>  
> +      '#address-cells':
> +        const: 1

blank line

> +      '#size-cells':
> +        const: 0
> +
> +    allOf:
> +      - if:
> +          properties:
> +            reg:
> +              contains:
> +                items:
> +                  - enum:
> +                      - 3
> +                      - 4
> +        then:
> +          properties:
> +            '#address-cells':
> +              const: 1
> +            '#size-cells':
> +              const: 0

Why do you have these twice? Drop this one.

> +
> +          patternProperties:
> +            "^ethernet-port@[0-5]$":
> +              type: object
> +              unevaluatedProperties: false
> +              $ref: ethernet-controller.yaml#
> +              description: External ethernet port ID available on the GDM port
> +
> +              properties:
> +                compatible:
> +                  const: airoha,eth-port
> +
> +                reg:
> +                  maxItems: 1

Instead, 'maximum: 5'.

> +                  description: External ethernet port identifier
> +
> +              required:
> +                - reg
> +                - compatible
> +
> +          required:
> +            - "#address-cells"
> +            - "#size-cells"
> +
>      required:
>        - reg
>        - compatible
> @@ -191,9 +235,27 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        mac: ethernet@1 {
> +        mac1: ethernet@1 {

Just drop unused labels.

>            compatible = "airoha,eth-mac";
>            reg = <1>;
>          };
> +
> +        mac4: ethernet@4 {
> +          compatible = "airoha,eth-mac";
> +          reg = <4>;
> +
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          ethernet-port@0 {
> +            compatible = "airoha,eth-port";
> +            reg = <0>;
> +          };
> +
> +          ethernet-port@1 {
> +            compatible = "airoha,eth-port";
> +            reg = <1>;
> +          };
> +        };
>        };
>      };
> 
> -- 
> 2.54.0
> 

