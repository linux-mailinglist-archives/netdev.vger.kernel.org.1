Return-Path: <netdev+bounces-262973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOQJKB81pmlJMQAAu9opvQ
	(envelope-from <netdev+bounces-262973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:10:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B331E7893
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EBA8308DD89
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E7B21D3E2;
	Tue,  3 Mar 2026 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3oNN+tQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B05218ACC
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500057; cv=none; b=Nlu5a7tbkWD8prtaiiC7PjGuoWatvUM4fc+9DYVNB0uc5cmU7OnKmIWywdszZFaVFUxprWxAGTdqKtI8EvYmqKe45ROEQkOv3z3JPVGO9sVEOgfl0+DBUYE4xl/U62BTS1A/PhRBkd4blbHtKDvojLfn+P7o4SE/h8S7KAF3aP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500057; c=relaxed/simple;
	bh=WG/CCCMPf++INnbCtqPPU9okZXL2wSwLvCkTTgXeBP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IslOq8SkC6M0vEul7oCeeoP8F0VvJrEY0tXz5YvWYmKfwdU/qUYATbqzUG5GlmfG7cukmI4FTvaM2Mjdb8syHsOjfDWNJggCTjdpDN8NxRNjClSJvIPdU8Kqdkhq/BVCR/UXByIif+48icNN0rikAKBBi4PIbUtk9dpuuuRx3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3oNN+tQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c6e1e748dc1so1724069a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 17:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772500056; x=1773104856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvu4CKE+k1dKhf/6IPTDYQpL3MikIJGAowExFNxiKNs=;
        b=f3oNN+tQa95JOG4EZWcOu+XCXh2DRPUB11FNc/hbw+Zv5pEdLUGksGdDGmQ82EXo+u
         H8zE8rYbtCy+uZh6HypTfVsWpKQ3GbFI4MLACWF5u9CC8n8DwgJ+WQU2l1oQQ/RjL+Ey
         RjQYju3qXI+M7MUa70fWO6xuI4KjoOcBXsXc2pvHPguf+ysa0471W3WSlyt/Tjqm1TRj
         pV80BS+Vu99p1bvU7doF9rx/Sb99ef3jmrBj/p/lLyWfIdHmzBI+M0xkRGe5WIPEZkCF
         FBeIv750WHLExKR8bdpTYEhPBJFv6TkIeCAJfASI1WPordAo0uN/xDzRpQ5QO/YaPSa6
         gLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772500056; x=1773104856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvu4CKE+k1dKhf/6IPTDYQpL3MikIJGAowExFNxiKNs=;
        b=RHeee/ibpjy1M0PYrTqdlFjxKA++uprzQ09XsTVRVHPnVWy8x4JlEA0+MXHaorXrLS
         eRgKwL4fIpF9da9x2Oi8pJvdFMqepE4TR1BxcMa34Bk2YIVVIeX0sFA9yW3jcViJ/bon
         u44VoGygtv5mxt8D8VUMjkZiITZvStr+pq1RNsvBTcsl0VLgVU4pHJWPdXcQvdOEAkU5
         4F5MGsl+Uh3jPgphVcFOj/HUg5nR3xPGyRzMo+b+RNMXoYKNuCNvgd/OV2G+Qu0qFHcY
         c4hYF9RYhTVgHPbTGz/2VCHKffwmDpwMXqCFamZjD4z+JDsoeBlfQseu2URmwH4p0YD/
         AWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpZfKCyhkZvUzxrvA71dViTRBZ+OHlGSGBc2dhsSCVdvDEBrsUjxX6ndkief5A5cC4MJcl1Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcqFy7nxXNtmWpwFP+A1RWkTzEOjCk/8Q8Xa2j4IeaL7W7auct
	PQyH9O5OSrELS+FpMoLiQcoUlX74Q2kgfjAJ0HNvvvXIwnue68e51Mky
X-Gm-Gg: ATEYQzyfwMWL8bIeDCLT4R/BCBFjZY5o7QbqARUbLwG/M/U8owe+SkIk/LqwdJgGSLW
	MpCHinvRvQDI2JL/Qpj0zfVGvOyTnBVi+QJfAMhUQIdaNGv2vbbRtx89CPTU/woF6GqvK6hNGD7
	ogzhrqEdh3o3S1rSFbsbzCg8NHXM+c8LhGlYEn9dvBwEFoNX3uK2zCGHsI/o8ICyo5Pu6wnv4vs
	K5muNwYvVrv2/rSkg7v7T7AUYcJtpQrz430k2X8Yvt2x8BeuW5enCNv+t3GsG8Ry4LeezmTC0YG
	stgc3WuJrzsBJncKieI4q2d88pDZVWfo7GCI21Zy+ehJRGWwN87bBgwCm8wJP5sOuTscnVJfVTM
	vUbLpTfXZ4BDNClcbN5J/ESOKEsTB1epz8kCOeH66pPdcY/iNq2i90ONFvjLI08dhd/H65fpTb1
	fzG2ujPbHKciFNRxOwrEAjdg==
X-Received: by 2002:a17:903:4765:b0:2aa:d2f4:9c11 with SMTP id d9443c01a7336-2ae60c60e17mr3650915ad.5.1772500056123;
        Mon, 02 Mar 2026 17:07:36 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6fe4f3sm146608315ad.91.2026.03.02.17.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:07:35 -0800 (PST)
Date: Tue, 3 Mar 2026 09:07:08 +0800
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
	Choong Yong Liang <yong.liang.choong@linux.intel.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Shangjuan Wei <weishangjuan@eswincomputing.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Boon Khai Ng <boon.khai.ng@altera.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: Add glue layer for Spacemit
 K3 SoC
Message-ID: <aaY0KeKuFwM-5wuS@inochi.infowork>
References: <20260227075718.2243818-1-inochiama@gmail.com>
 <20260227075718.2243818-4-inochiama@gmail.com>
 <20260228131845.70421792@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228131845.70421792@kernel.org>
X-Rspamd-Queue-Id: 45B331E7893
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262973-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,linux.intel.com,bp.renesas.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,inochi.infowork:mid]
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 01:18:45PM -0800, Jakub Kicinski wrote:
> On Fri, 27 Feb 2026 15:57:17 +0800 Inochi Amaoto wrote:
> > The ethernet controller on Spacemit K3 SoC is Synopsys DesignWare
> > MAC (version 5.40a), with the following special points:
> > 1. The rate of the tx clock line is auto changed when the mac speed
> >    rate is changed, and no need for changing the input tx clock.
> > 2. This controller require a extra syscon device to configure the
> >    interface type, enable wake up interrupt and delay configuration
> >    if needed.
> 
> checkpatch says:
> 
> ERROR: "foo* bar" should be "foo *bar"
> #110: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c:45:
> +static int spacemit_dwmac_set_delay(struct spacmit_dwmac* dwmac,
> 
> ERROR: "foo* bar" should be "foo *bar"
> #148: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c:83:
> +static int spacemit_dwmac_fix_delay(struct spacmit_dwmac* dwmac,
> 
> WARNING: line length of 99 exceeds 80 columns
> #243: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c:178:
> +	apmu = syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node, "spacemit,apmu", 2, offset);
> -- 
> pw-bot: cr

Thanks, I have updated a new version.

Regards,
Inochi

