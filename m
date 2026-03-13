Return-Path: <netdev+bounces-267277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA0mIY54s2nDWwAAu9opvQ
	(envelope-from <netdev+bounces-267277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:38:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD4927CD52
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1279830325F1
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2CD346A13;
	Fri, 13 Mar 2026 02:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZmGErku"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E62E888C;
	Fri, 13 Mar 2026 02:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369484; cv=none; b=r0ed694OnDkf9OEHyaNG4nOZkCLr87wVVmQaNSVLEv3bnpyrzFqbSaRHyBprLcwxgp1ohSBfsIZAN4jRHHLRWEGeTPRlkpHyDf+kOmxoUekMormy5TReSvNfmwkqfRtiAEvGmiQuuC/3MvQUQSJS0KAn/0mSM6Tm1iJGHrqQnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369484; c=relaxed/simple;
	bh=cXgUEDCxpb0VJM5NocwDb3y+egwZEcpfq0JderV9xYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPkuoJSJKfRJSZA7FIqsk+rXtgO/qRTwHQ6HVKNZ7+AYGnX6Dhy49az/cz0coUwpRyBVOwQbx+3eTECncnfqNPe3XOodQ5MJXA6pVi1GgIM1txh50jxeC6kXzzQDxPmDRPZ929hx4v7JnOLKgy7nkbijaJ5HAOXas0umEvi2jHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZmGErku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268FAC116C6;
	Fri, 13 Mar 2026 02:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773369483;
	bh=cXgUEDCxpb0VJM5NocwDb3y+egwZEcpfq0JderV9xYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HZmGErkudO/UsvBnemx/cgWFLZAevqTXjslEtTDHabT3yxPJIFMTX6Q7ygD4VcNO9
	 d4ZrG9RBHupYbJglUOLEKhH2YmSgDCHSN2QxcrTxkBrQtKlHbhRQScs+xcc4HNr1O2
	 vFJOmjJnM5rvMY6e8TZt1hNTI4L3NKSELZNOW8mYvwSkU0Aeaz3X3qWVskEfm1g34d
	 9b+hsVvMuRKOnBDLs0BqDCDLy9059cwWrfQQ+eHylhVGC1K5uzQo76MwefIGxnnJkK
	 D1YY8jw3tzyoHrpIBmdtMloiXb1A+qepUI/C4U8QK4TVdj0CQnqkfoOboUxvVi6aJ+
	 byWPAXlZ+c2QQ==
Date: Thu, 12 Mar 2026 19:38:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan
 <dlan@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Richard Cochran
 <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Yao
 Zi <me@ziyao.cc>, Yanteng Si <siyanteng@cqsoftware.com.cn>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, Shangjuan
 Wei <weishangjuan@eswincomputing.com>, Boon Khai Ng
 <boon.khai.ng@altera.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu
 <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin
 Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v9 3/4] net: stmmac: Add glue layer for
 Spacemit K3 SoC
Message-ID: <20260312193801.61c30de4@kernel.org>
In-Reply-To: <20260312012232.373713-4-inochiama@gmail.com>
References: <20260312012232.373713-1-inochiama@gmail.com>
	<20260312012232.373713-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267277-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,nxp.com,bp.renesas.com,bootlin.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CD4927CD52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some nit picks only to be addressed in case the AI complaint on patch 1
is legit..

On Thu, 12 Mar 2026 09:22:25 +0800 Inochi Amaoto wrote:
> +config DWMAC_SPACEMIT
> +	tristate "Spacemit dwmac support"
> +	depends on OF && (ARCH_SPACEMIT || COMPILE_TEST)
> +	select MFD_SYSCON
> +	default m if ARCH_SPACEMIT

I know other STMMAC sub-drivers do it but isn't the defconfig for 
the platform the right place to add this sort of default?

> +	apmu = syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
> +						    "spacemit,apmu", 2,
> +						    offset);
> +	if (IS_ERR(apmu))
> +		return dev_err_probe(dev, PTR_ERR(apmu),
> +				"Failed to get apmu regmap\n");

looks mis-aligned 

