Return-Path: <netdev+bounces-306952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /qESKSymU2pWcwMAu9opvQ
	(envelope-from <netdev+bounces-306952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 16:35:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C01C744FF8
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 16:35:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HsT6GE5s;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306952-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306952-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ADF630073E3
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332152580F2;
	Sun, 12 Jul 2026 14:35:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6F2149DF1;
	Sun, 12 Jul 2026 14:35:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783866922; cv=none; b=l+fcwl1fxMANtqu/ZQ843SNHT5pFdt8p9Q4OEKF/aKpmWlTBDW/d+rO9RNnXxlkC+22lX0USliE30IUG8iC+2UpXnPrQv1Y1Y/W1Vkj5DJ2g+cd9TGCfkp6cwNyhWnXGAOGmjE35dLeyKx6N6MC/8JvREBJK/XIgkeS0zhHgTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783866922; c=relaxed/simple;
	bh=Uf5O0b+6iCsQ99EePPkjf+L/CmQ7N9Ld8f7WkqKW6vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlygRZFe3TmaFSEDlrC3Q1aPfkVY0CdfAwnDHPYKl3ZFPlK+keQyaTY7UYeP5Ff6LrxPjX7fOXL4bWgof4HGBjOdSfb6kqAKnRQoKbQr4OPbPLVq5hSschWnfUNYQxZ0rmVN/jwkS/42AZllax1qXygRC3JH0GwIo6MhDMVVJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsT6GE5s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F021F000E9;
	Sun, 12 Jul 2026 14:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783866920;
	bh=7RWLP70+Lk7x6klHiPJCyXJm7RPKA7hKo0HmQbHzxBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HsT6GE5sB5DUFUCMRQkNuUttWd6ae45mL6NHMgYoLcwatlYsmmGzSSeuoN4SwpbrE
	 IT+svOg66VoMcq0agaiYVBUdh4MfFXYOqG05kS1le79jwP59Yp4T9iaTG5i20I3ixs
	 Hnaszlbs0H7ItxEj9ncxu9i5jFuSIos3/5l4v5CEhE9QKMDMsdmHvd6+AkQabYVoni
	 F2sHw1IjVBiS1c2Mb+vSl2dUIp0tOfGAOoxZl9wRxT+a0tQMz+q9AStLX47/3AFeM6
	 nbh+DJ3IHV9Gjuc0EqmNRToJTUwUNzS5FF7T/QznODpqDSXOU9y+wPKhxceobGSCG2
	 V9B0EoktaUhwQ==
Date: Sun, 12 Jul 2026 16:35:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: clk: sun60i-a733-ccu: Add allwinner
 A733 support
Message-ID: <20260712-sexy-polar-cuckoo-cefee4@quoll>
References: <20260711-a733-clk-v2-0-974d188cbe0c@pigmoral.tech>
 <20260711-a733-clk-v2-1-974d188cbe0c@pigmoral.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260711-a733-clk-v2-1-974d188cbe0c@pigmoral.tech>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:junhui.liu@pigmoral.tech,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:netdev@vger.kernel.org,m:jbrunet@baylibre.com,m:krzk@kernel.org,m:conor@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306952-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,sholland.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,pigmoral.tech:email,quoll:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C01C744FF8

On Sat, Jul 11, 2026 at 04:10:27PM +0800, Junhui Liu wrote:
> +properties:
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +

Please order according to DTS coding style. compatible is ALWAYS the
first, then reg. Then name ordering, so reset-cells go to the end.


> +  compatible:
> +    enum:
> +      - allwinner,sun60i-a733-ccu
> +      - allwinner,sun60i-a733-r-ccu
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 4
> +    maxItems: 7
> +
> +  clock-names:
> +    minItems: 4
> +    maxItems: 7
> +
> +required:
> +  - "#clock-cells"
> +  - "#reset-cells"

As well.

> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - allwinner,sun60i-a733-ccu
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: High Frequency Oscillator (19.2MHz, 24MHz, or 26MHz)
> +            - description: Low Frequency Oscillator (usually at 32kHz)
> +            - description: Internal Oscillator
> +            - description: Low Frequency Oscillator fanout
> +
> +        clock-names:
> +          items:
> +            - const: hosc
> +            - const: losc
> +            - const: iosc
> +            - const: losc-fanout
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - allwinner,sun60i-a733-r-ccu
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: High Frequency Oscillator (19.2MHz, 24MHz, or 26MHz)
> +            - description: Low Frequency Oscillator (usually at 32kHz)
> +            - description: Internal Oscillator
> +            - description: System 24MHz Clock
> +            - description: Peripherals PLL 0 (200 MHz output)
> +            - description: Peripherals PLL 0 (300 MHz output)
> +            - description: Peripherals PLL 1 (300 MHz output)
> +
> +        clock-names:
> +          items:
> +            - const: hosc
> +            - const: losc
> +            - const: iosc
> +            - const: sys-24m
> +            - const: pll-periph0-200m
> +            - const: pll-periph0-300m
> +            - const: pll-periph1-300m
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@2002000 {
> +      compatible = "allwinner,sun60i-a733-ccu";
> +      reg = <0x02002000 0x2000>;
> +      clocks = <&osc>, <&rtc 0>, <&rtc 2>, <&rtc 1>;
> +      clock-names = "hosc", "losc", "iosc", "losc-fanout";
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/sun60i-a733-ccu.h b/include/dt-bindings/clock/sun60i-a733-ccu.h
> new file mode 100644
> index 000000000000..6742070e3086
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun60i-a733-ccu.h

Filename must match compatible.

> @@ -0,0 +1,290 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */

Why different license than the binding?

> +/*
> + * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>

...

> +#define CLK_BUS_DSC		257
> +#define CLK_CSI_MASTER0		258
> +#define CLK_CSI_MASTER1		259
> +#define CLK_CSI_MASTER2		260
> +#define CLK_CSI			261
> +#define CLK_BUS_CSI		262
> +#define CLK_ISP			263
> +#define CLK_RES_DCAP_24M	264
> +#define CLK_APB2JTAG		265
> +#define CLK_FANOUT_24M		266
> +#define CLK_FANOUT_12M		267
> +#define CLK_FANOUT_16M		268
> +#define CLK_FANOUT_25M		269
> +#define CLK_FANOUT_27M		270
> +#define CLK_FANOUT_PCLK		271
> +#define CLK_FANOUT0		272
> +#define CLK_FANOUT1		273
> +#define CLK_FANOUT2		274
> +#define CLK_FANOUT3		275
> +
> +#endif /* _DT_BINDINGS_CLK_SUN60I_A733_CCU_H_ */
> diff --git a/include/dt-bindings/clock/sun60i-a733-r-ccu.h b/include/dt-bindings/clock/sun60i-a733-r-ccu.h
> new file mode 100644
> index 000000000000..1d3845b483bf
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun60i-a733-r-ccu.h

Here as well and so on (other places as well).

Best regards,
Krzysztof


