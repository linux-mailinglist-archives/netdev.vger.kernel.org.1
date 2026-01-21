Return-Path: <netdev+bounces-251996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HkLIFAZcWmodQAAu9opvQ
	(envelope-from <netdev+bounces-251996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:22:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E433F5B334
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACF75B05B45
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD28D3806D6;
	Wed, 21 Jan 2026 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFjVUj4H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7072FFFA5;
	Wed, 21 Jan 2026 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012472; cv=none; b=rPKsxcTBqcoafus/kMvQ61C6n+1of8lLloehXNF2pTpsgnOvXV7Yhjrgc34lKLvVesZRQiKz7DGirmepI+IT6kADmSZls/IEfBnoCxr99onaMtfIGCKeahKD85SnWpBg/EHPiM2Jo7DNPDGOA6JjDLukmxk40U+9OdICNIn9PtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012472; c=relaxed/simple;
	bh=NGyz5uwtzeGyvCVcwevBJVgXM2mV1JFZjaxPNVyzlf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fk3WwPSdJlkcEWHIUHAhJ8AMDQKqJ506rd5YszxFN9Q0dKHAFSlP8C1fnzQaJ5RrFHC5WQ2OJphDbJpzl6YAdQWHoB4zsd/XVMklnQnOfq+UUpRvHmhDOT18qsa44BYLfowEXjz4qZ0lndnjfcuuZfEFcQaftdrXQx3NSyClCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFjVUj4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97712C4CEF1;
	Wed, 21 Jan 2026 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769012471;
	bh=NGyz5uwtzeGyvCVcwevBJVgXM2mV1JFZjaxPNVyzlf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFjVUj4H0wsckTkiSoxCEJxs+g1YF+sMLWNTHKCN39KcZ9O/bqtqPigbyqBHcrl6N
	 3hG/VgHHw8puwjROLu4lRTxSQpWTe/Cjs6i2kC6GYqqS2VIZEymFmeLkboIuxnyf3F
	 K8OYBfpuLkC8lVrd1wruo+keYfzUfqkD6uccp+TGLQ6v31JrUFlzWilKaBFXtIu/lH
	 O664njCntVWQIdJx/nLzAbpY2KUQxxwCk4WVXgK3pINcQ96LXfWJrKZqg2kq38r4cC
	 /6L4R9+46JTP7u5WegP+KZCt3suZdhkwS3TzQeLvVmzX4tROTrrGM7V5HItgn6mKYb
	 kfuFuG65fgl5g==
Date: Wed, 21 Jan 2026 10:21:10 -0600
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yao Zi <ziyao@disroot.org>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: Add support for
 Spacemit K3 dwmac
Message-ID: <20260121162110.GA3314848-robh@kernel.org>
References: <20260121071315.940130-1-inochiama@gmail.com>
 <20260121071315.940130-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121071315.940130-2-inochiama@gmail.com>
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251996-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,disroot.org,cqsoftware.com.cn,nxp.com,bp.renesas.com,linux.intel.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E433F5B334
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 03:13:09PM +0800, Inochi Amaoto wrote:
> The GMAC IP on Spacemit K3 is almost a standard Synopsys DesignWare
> MAC (version 5.40a) with some extra clock.
> 
> Add necessary compatible string for this device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   3 +
>  .../bindings/net/spacemit,k3-dwmac.yaml       | 103 ++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index dd3c72e8363e..3c2c6cb6b10b 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -34,6 +34,7 @@ select:
>            - snps,dwmac-5.10a
>            - snps,dwmac-5.20
>            - snps,dwmac-5.30a
> +          - snps,dwmac-5.40a

You don't need this in select as the spacemit schema references this 
one.

>            - snps,dwxgmac
>            - snps,dwxgmac-2.10
>  
> @@ -108,6 +109,7 @@ properties:
>          - snps,dwmac-5.10a
>          - snps,dwmac-5.20
>          - snps,dwmac-5.30a
> +        - snps,dwmac-5.40a
>          - snps,dwxgmac
>          - snps,dwxgmac-2.10
>          - sophgo,sg2042-dwmac
> @@ -653,6 +655,7 @@ allOf:
>                  - snps,dwmac-5.10a
>                  - snps,dwmac-5.20
>                  - snps,dwmac-5.30a
> +                - snps,dwmac-5.40a
>                  - snps,dwxgmac
>                  - snps,dwxgmac-2.10
>                  - st,spear600-gmac
> diff --git a/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml b/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
> new file mode 100644
> index 000000000000..e69f3b60c51f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/spacemit,k3-dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spacemit K3 DWMAC glue layer
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@gmail.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: spacemit,k3-dwmac
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: spacemit,k3-dwmac
> +      - const: snps,dwmac-5.40a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: GMAC main clock
> +      - description: PTP clock
> +      - description: TX clock
> +
> +  clock-names:
> +    items:
> +      - const: stmmaceth
> +      - const: ptp_ref
> +      - const: tx
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: MAC interrupt
> +      - description: MAC wake interrupt
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: macirq
> +      - const: eth_wake_irq
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: stmmaceth
> +
> +  spacemit,apmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the syscon node which control the glue register
> +          - description: offset of the control register
> +          - description: offset of the dline register
> +

Drop blank line

> +    description:
> +      A phandle to syscon with offset to control registers for this MAC
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - resets
> +  - reset-names

spacemit,apmu is not required? Looks like the driver requires it.

> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    eth0: ethernet@cac80000 {

Drop unused label.

> +      compatible = "spacemit,k3-dwmac", "snps,dwmac-5.40a";
> +      reg = <0xcac80000 0x2000>;
> +      clocks = <&syscon_apmu 66>, <&syscon_apmu 68>,
> +               <&syscon_apmu 69>;
> +      clock-names = "stmmaceth", "ptp_ref", "tx";
> +      interrupts = <131 IRQ_TYPE_LEVEL_HIGH>, <276 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "macirq", "eth_wake_irq";
> +      phy-mode = "rgmii-id";
> +      phy-handle = <&phy0>;
> +      resets = <&syscon_apmu 67>;
> +      reset-names = "stmmaceth";
> +      spacemit,apmu = <&syscon_apmu 0x384 0x38c>;
> +    };
> +
> -- 
> 2.52.0
> 

