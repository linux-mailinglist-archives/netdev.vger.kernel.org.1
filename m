Return-Path: <netdev+bounces-263634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDa4Huzip2mrlAAAu9opvQ
	(envelope-from <netdev+bounces-263634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:44:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B9A1FBCAA
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C63A9300720D
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0083264F8;
	Wed,  4 Mar 2026 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h14YwVVE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B661034D385;
	Wed,  4 Mar 2026 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610263; cv=none; b=MKUlglDYcoTPXjZHO/wKMfhhwb9vbqLd6NLPENGXYP0eFusUaMUTyt+RtyU0bYK43NJ9c2GezzQNd1AsvVNfsq5bsw1HhUR9hgLCQGsh4PvEoDPvvYIJJU+vN/mUpBUJLyAotkSluT8X/ktavskwYS6Dgu0CDdmhPUEYtStGeoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610263; c=relaxed/simple;
	bh=Us0KGNplk7HG7Fg83BdG+51O34emtOY7P1nZiiQ0jEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suREU+sPpHI9wDQS0PAs7oXoYAbkT7svPjomiOMenhHxiFHed07KG9Gbnd0XX+ZliMTUyHrVBN1JWAhGLpTYL8CzrQQEQmj/NLvbaZAjrlw1qMhevpI0yU//7XyKi9rKm/Jbj1vUEVWNIa1pBoAl8ti8y+7cTSamwkgypvjENww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h14YwVVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F04C19423;
	Wed,  4 Mar 2026 07:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772610263;
	bh=Us0KGNplk7HG7Fg83BdG+51O34emtOY7P1nZiiQ0jEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h14YwVVE6Wj9ayUYI7MGAZoootsuGQ+RsRUIvXmDBYdBvhOGLpsE4P9nw/2i1qmGz
	 N+VqJuvhpyVsQ3BBLC2IEcy35P7Ad/6xl3kwoDp9ofcfS11K9avXjLWOkOANI4AyWf
	 zJ01vAyxeRvijBP0ed+iFx0t37A5i0q2Lmim14MvcdRkXdKvcAWbmi9LfC7HaHHuYd
	 7/rzk8X8A68rxJ7EIcgY3aUvzucihf1RDs3lmV/JqqF5wBtjK2XgakMOwBQlEsoHdv
	 /MYd0/fycri9g3fr899YtXuwAMjsl3gXw7WHMGy5a5R7snhJZXIh3OvT7FPtFg0fkX
	 B6OXkr5jGjEcQ==
Date: Wed, 4 Mar 2026 08:44:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, 
	wens@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <20260304-hot-sponge-of-emphasis-6864db@quoll>
References: <20260303061525.846-1-lizhi2@eswincomputing.com>
 <20260303061637.872-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303061637.872-1-lizhi2@eswincomputing.com>
X-Rspamd-Queue-Id: 82B9A1FBCAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263634-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,eswincomputing.com,einfochips.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	RCPT_COUNT_TWELVE(0.00)[28];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 02:16:37PM +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> The second Ethernet controller (eth1) on the EIC7700 SoC may experience
> RX data sampling issues at high speed due to EIC7700-specific receive
> clock to data skew at the MAC input.
> 
> On the EIC7700 SoC, the second Ethernet controller (eth1) requires
> inversion of the internal RGMII receive clock in order to meet RX data
> sampling timing at high speed.
> 
> Describe this SoC-specific difference by introducing a distinct compatible
> string for MAC instances that require internal clock inversion, allowing the
> driver to select the appropriate configuration without relying on per-board
> vendor-specific properties.

Pointless description/paragrapgh. Your explanation why adding a
compatible is "because I need compatible". That's completely redundant.

Explain what is special about this MAC instance, what's different in its
programming model or other characteristics that you claim it is a
different device.

> 
> The rx-internal-delay-ps and tx-internal-delay-ps properties now use
> minimum and maximum constraints to reflect the actual hardware delay
> range (0-2540 ps) applied in 20 ps steps. This relaxes the binding
> validation compared to the previous enum-based definition and avoids
> regressions for existing DTBs while keeping the same hardware limits.
> 
> Treat the RX/TX internal delay properties as optional, board-specific
> tuning knobs and remove them from the example to avoid encouraging
> their use.
> 
> In addition, the binding now includes additional background information
> about the HSP CSR registers accessed by the MAC. The TXD and RXD delay
> control registers are included so the driver can explicitly clear any
> residual configuration left by the bootloader. Background reference for
> the High-Speed Subsystem and HSP CSR block is available in Chapter 10
> ("High-Speed Interface") of the EIC7700X SoC Technical Reference Manual,
> Part 4 (EIC7700X_SoC_Technical_Reference_Manual_Part4.pdf):
> https://github.com/eswincomputing/EIC7700X-SoC-Technical-Reference-Manual/releases
> 
> There are currently no in-tree users of the EIC7700 Ethernet driver, so
> these changes are safe.
> 
> Fixes: 888bd0eca93c ("dt-bindings: ethernet: eswin: Document for EIC7700 SoC")
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> ---
>  .../bindings/net/eswin,eic7700-eth.yaml       | 75 +++++++++++++++----
>  1 file changed, 59 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> index 91e8cd1db67b..22d1cecea07e 100644
> --- a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> +++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> @@ -20,6 +20,7 @@ select:
>        contains:
>          enum:
>            - eswin,eic7700-qos-eth
> +          - eswin,eic7700-qos-eth-clk-inversion
>    required:
>      - compatible
>  
> @@ -28,9 +29,13 @@ allOf:
>  
>  properties:
>    compatible:
> -    items:
> -      - const: eswin,eic7700-qos-eth
> -      - const: snps,dwmac-5.20
> +    oneOf:
> +      - items:
> +          - const: eswin,eic7700-qos-eth
> +          - const: snps,dwmac-5.20
> +      - items:
> +          - const: eswin,eic7700-qos-eth-clk-inversion

So just enum for both entries?

Anyway, that's the same device, so you do not get two compatibles. This
should be a property. Which property not sure, maybe all this was
discussed already.


> +          - const: snps,dwmac-5.20
>  
>    reg:
>      maxItems: 1
> @@ -63,16 +68,29 @@ properties:
>        - const: stmmaceth
>  
>    rx-internal-delay-ps:
> -    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> +    minimum: 0
> +    maximum: 2540
> +    multipleOf: 20
>  
>    tx-internal-delay-ps:
> -    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> +    minimum: 0
> +    maximum: 2540
> +    multipleOf: 20
>  
>    eswin,hsp-sp-csr:
>      description:
>        HSP CSR is to control and get status of different high-speed peripherals
>        (such as Ethernet, USB, SATA, etc.) via register, which can tune
>        board-level's parameters of PHY, etc.
> +
> +      Additional background information about the High-Speed Subsystem
> +      and the HSP CSR block is available in Chapter 10 ("High-Speed Interface")
> +      of the EIC7700X SoC Technical Reference Manual, Part 4
> +      (EIC7700X_SoC_Technical_Reference_Manual_Part4.pdf). The manual is
> +      publicly available at
> +      https://github.com/eswincomputing/EIC7700X-SoC-Technical-Reference-Manual/releases
> +
> +      This reference is provided for background information only.
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        - items:
> @@ -81,7 +99,9 @@ properties:
>                           or external clock selection
>            - description: Offset of AXI clock controller Low-Power request
>                           register
> +          - description: Offset of register controlling TXD delay
>            - description: Offset of register controlling TX/RX clock delay
> +          - description: Offset of register controlling RXD delay

As pointed out, you cannot change the order and there is no reason for
doing this explained in commit msg.

Best regards,
Krzysztof


