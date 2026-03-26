Return-Path: <netdev+bounces-271791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KL6K7aMxGlr0QQAu9opvQ
	(envelope-from <netdev+bounces-271791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:32:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E132A32DE99
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D68AF301731F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 01:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7582338E10C;
	Thu, 26 Mar 2026 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSIl7tbq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184D364EBC;
	Thu, 26 Mar 2026 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774488749; cv=none; b=Kan3BkZgNmF7wKGi1IYc+/xyUXD0yfJSTcNx0YNBRm4BoTvNAJ0EczzMPLKT6vNCWDHXqU7CD7tJo/aBN8NMXGKq3dRWQdyQXWCM3scb5VxzICNUe1AH6YiL+fd/0f6Q1S4WG+3V8N4FopxaeZL2k2BnqtQrgzfhoZIiYhJqDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774488749; c=relaxed/simple;
	bh=0o/KA3E1AVUpDoF3loQgLJ2Dd3NgNwTXagLGMlM09+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaA77szGqXaBpkEGXXV0NseXBZDkOje8ZUX5C3j03Xri1DqkXaSyhwbo41tmiRSp9vmg67Nu+yg/ljcAvm9nf8vyW87DgFBGd3B2tKH2yFTCQflHFz253PfGniBoho6n4+JUDW1bJwEhlceheC5+VlgHLRWXc4PvP7Q8TCY7Fss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSIl7tbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7056DC4CEF7;
	Thu, 26 Mar 2026 01:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774488748;
	bh=0o/KA3E1AVUpDoF3loQgLJ2Dd3NgNwTXagLGMlM09+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSIl7tbqONjJj7zMpBL8xMchY9Pbb+/FZLZrvaFtvnpxH67zSvr5snK9HHwXQIqt+
	 CKZG087S7ntuKqygpTEw2nB5n2N4iB5kWaPGfYk2u1pLLaYMC7NOXdfplZ2Z08DZMU
	 dc79KrRW+i77gFtxDc0KWT1Pw/9+Fyec5bGAzjqFOaNxKcB3eM+r85Rk1LkWYGJOmq
	 sceFbrG3YYD/dqFUKRBV1n2Ta5vG6hcbhjGQVs6gZ8Gd/4wBduKucCuTdlW6O39DCo
	 X1fXixIrbgZLDWfSVI8wWBMfSVyFMg6+d0CDyMn2W+aEqwR/0ZyCDxFHXA4VFIUPKS
	 GknV1m6WTIIoQ==
Date: Thu, 26 Mar 2026 09:32:26 +0800
From: Yixun Lan <dlan@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5] riscv: dts: spacemit: Add ethernet device for K3
Message-ID: <20260326013226-GKC777612@kernel.org>
References: <20260324063714.750428-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324063714.750428-1-inochiama@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271791-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,gentoo.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E132A32DE99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Inochi,

Can you rebase the patch on top of spacemit DT branch, it would ease my
life to merge it, as I see some conflicts..

https://github.com/spacemit-com/linux/tree/k1/dt-for-next

Also one comment below.. Please check

On 14:37 Tue 24 Mar     , Inochi Amaoto wrote:
> Add all ethernet device nodes for K3 SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
> Require the following patch series:
> 1. Basic DT device patch
> https://lore.kernel.org/spacemit/20260304-01-dts-uart-full-v1-0-50a0aa53a245@kernel.org
> 2. Ethernet driver patch
> https://lore.kernel.org/spacemit/20260316010041.164360-1-inochiama@gmail.com
> 
> Changed from v4:
> 1. Fix pinctrl pin name
> 2. Remove alias for disabled node
> 
> Changed from v3:
> 1. Separate the pin as RGMII pin and INT pin.
> 2. Add comment for pin usage.
> 3. Rename the ethernet pinctrl node to address it is RGMII node.
> 
> Changed from v2:
> 1. keep aliases in alphabetical order.
> 
> Changed from v1:
> 1. remove interrupt-parents property
> 2. add aliases for ethernet node
> ---
..
> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
> index 6cc31e94c13a..4c0cc135dc09 100644
> --- a/arch/riscv/boot/dts/spacemit/k3.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> @@ -5,6 +5,7 @@
>   */
> 
>  #include <dt-bindings/clock/spacemit,k3-clocks.h>
> +#include <dt-bindings/reset/spacemit,k3-resets.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> 
>  /dts-v1/;
> @@ -437,6 +438,109 @@ soc: soc {
>  		dma-noncoherent;
>  		ranges;
> 
> +		gmac_axi_setup: stmmac-axi-config {
> +			snps,wr_osr_lmt = <0xf>;
> +			snps,rd_osr_lmt = <0xf>;
> +			/* max axi burst len is 256 */
> +			snps,blen = <256 128 64 32 16 0 0>;
> +		};
I've got a DT complaint, can you take a look? probably put it inside
ethernet node? although will duplicate a little bit in several nodes..

arch/riscv/boot/dts/spacemit/k3.dtsi:441.37-446.5: Warning (simple_bus_reg): /soc/stmmac-axi-config: missing or empty reg/ranges property


-- 
Yixun Lan (dlan)

