Return-Path: <netdev+bounces-267279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMB2Auh5s2kZXAAAu9opvQ
	(envelope-from <netdev+bounces-267279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:43:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A736427CDBA
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F8230B47A0
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A2346E71;
	Fri, 13 Mar 2026 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcgO7Owd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0512344044
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369828; cv=none; b=FqUYcF6Mq1CfFnsy164X6Cz6iF8AkR9w93g1ih6vckklYQvx5ROKBE1L2Jh6LKx14iM7ttCZSf+5AGH5bcDKHPUJodQVXTQWGg8OYwNFzor9V/0p4QRZZbZxiViPSBf0wcmVr2AuNekLJi5+XmE53wm1GiOiqLUFh8PVK3uA1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369828; c=relaxed/simple;
	bh=BvmSqdKL2mgHyEPzAmRBGH1hY2ITeXqKZPua1k6rWgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0qszZAHiWTetUVetsLQPcS/+O8uLEopxTJ2tSZUv9m9xqcRcDCbKxgZvq6Jt2YMuJtRYYvdpgZy/iULYrpVw40Ds3eQrqMscWZlvqVBW0uttVq2mSbgSRY780sIgY4nS2X1LC+CwHlMVTFsADA7am0u2QDzAQbNYrfQYvMyl4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcgO7Owd; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5094b54a250so12140671cf.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 19:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773369826; x=1773974626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9hCuzuHEN/sMOidNnhHLkJz/g4iSobaxo8mhYZkdNU=;
        b=YcgO7OwdSmT1lEE2QGd97QDP+xEYFgoLtIIqgs7H9tTtJEwhFR46mmXg6EQVrvbdr4
         mHL4DhGg504Y6zqkYbEUzhDov+JftRDWVoxlMoK0BkX2AzH83tSbCwcHTzK3MuGxR/gA
         TE20/wAKjpfjti6li10gtma1z5tge69nhxA5ARj6uAtpP1N5ukzyNly2RzYsBAFdY9Nm
         /p3pcz/PCqUGSdJp4cjETko2D6XnR/+jJ7RXqtdAXAKo6p/e/JDWPdlHrlWGKgQ8KYwI
         ztd3csBHmW8bcFCpQJp63YiQRi/FFFFeuHklzaH7WxFgaVorjpxEeIarZvzyq7DbjqDt
         +E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773369826; x=1773974626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9hCuzuHEN/sMOidNnhHLkJz/g4iSobaxo8mhYZkdNU=;
        b=nndmY1AOAxONo4tfemBTeDlZ7wTmBzUG719ukAVLPOqKFIi5kL67UKoI7na4GD0NN8
         8CZVUeuhqYZU4wL8AQgr/ZrNdPhjee2UH6YfZDZny0+fXzH3aVl5RZ+9UTevhm6v5u6L
         jqzLWJklX5SCdVmeQ1+nmCOmxOXZwAnmglfiJs+PkekGBvHeWY2x1ommgByWkCuoMO6A
         5Jbyro12UxBpHr26lp8rOcNcRsDyg3HzyzLKO3gOrzfvRE5okoRtMN/X46A0XQgXafjQ
         Cp0VYF0okRQuyW83AGzQOpc+rQZ7g7UN7j8Mzx7X6Ep1/qpbF0jhxGs88ij5TP0vGAZL
         lj1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr1eccnT5zMzpG6dy12P0/QmvVMuGvAUUvLPfOUYqqrmFTlQXvzGJh35qAk+RrVFN54NN1CWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRMkHbMm5bcJK0jSr7+AeZdh+G1hu+0fGcicNRi9Y7Paz4FC2
	oMvheUeEZvTk/39gnl6/kmj4YX30EkrHe8F8HyZKIVMxhnuxZymGRNXL
X-Gm-Gg: ATEYQzyhCxHhx3cDA/F/S71crzMcyLdnopREabD2z1go75NqyIPXg8Av2sT2WWX3Unh
	oBelGQzM7qfFBxDkUv75WD28TEyDLjcQwkNObshkdFcB0WfbHFOoSkU+2PJnUf6Fde1t8jYhQD4
	sUfniCDUs54JmZXHd/qzG+I0uJmXpQ4Z4N+UykCwrGu8aD1X4HfxSBbOjnqng1hHzwcCEV8RFql
	bck+QvQt50WHNMazuPIuphuzgkYjXt7uSneoaf+3rAHXFnKftoMFG1nPFmTYXecy2EdbWk5oXCG
	ji6cumtjFqDTFRxQr9S+UFMLUf0D1ttgMmQQV1fMpdxsD7D48B+7vFeDa2dHE6dsqa3f5UY/v1V
	dkcrPg/GqkM97rBbJl1RvJeOwazUXVavIyFaWVZQLCgka/xEXsbK2EQYM+wiUrYtt/3mTj5n4ip
	ae3SvaJ39/SsHp/0hSGZNXWRk=
X-Received: by 2002:ac8:5fcb:0:b0:509:329e:bd5 with SMTP id d75a77b69052e-50957b909c8mr24981181cf.3.1773369825770;
        Thu, 12 Mar 2026 19:43:45 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a0ea844sm53518871cf.17.2026.03.12.19.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 19:43:45 -0700 (PDT)
Date: Fri, 13 Mar 2026 10:43:05 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Yao Zi <me@ziyao.cc>, Yanteng Si <siyanteng@cqsoftware.com.cn>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Shangjuan Wei <weishangjuan@eswincomputing.com>, Boon Khai Ng <boon.khai.ng@altera.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v9 3/4] net: stmmac: Add glue layer for Spacemit
 K3 SoC
Message-ID: <abN5Xn5GCa_UqCbO@inochi.infowork>
References: <20260312012232.373713-1-inochiama@gmail.com>
 <20260312012232.373713-4-inochiama@gmail.com>
 <20260312193801.61c30de4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312193801.61c30de4@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267279-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,nxp.com,bp.renesas.com,bootlin.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A736427CDBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 07:38:01PM -0700, Jakub Kicinski wrote:
> Some nit picks only to be addressed in case the AI complaint on patch 1
> is legit..
> 
> On Thu, 12 Mar 2026 09:22:25 +0800 Inochi Amaoto wrote:
> > +config DWMAC_SPACEMIT
> > +	tristate "Spacemit dwmac support"
> > +	depends on OF && (ARCH_SPACEMIT || COMPILE_TEST)
> > +	select MFD_SYSCON
> > +	default m if ARCH_SPACEMIT
> 
> I know other STMMAC sub-drivers do it but isn't the defconfig for 
> the platform the right place to add this sort of default?
> 
> > +	apmu = syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
> > +						    "spacemit,apmu", 2,
> > +						    offset);
> > +	if (IS_ERR(apmu))
> > +		return dev_err_probe(dev, PTR_ERR(apmu),
> > +				"Failed to get apmu regmap\n");
> 
> looks mis-aligned 

Yes, that's true. I will fix this.

Regards,
Inochi

