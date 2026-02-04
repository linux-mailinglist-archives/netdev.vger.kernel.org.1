Return-Path: <netdev+bounces-256555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGsiMLLDgmkpaAMAu9opvQ
	(envelope-from <netdev+bounces-256555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:57:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1955FE16FE
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D44CF3064643
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914CF2E22BA;
	Wed,  4 Feb 2026 03:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmO0cAEb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C71E25F9
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 03:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177414; cv=none; b=EPI1jiyxWNPqBW1d+9eH2WtBYFIWFjgwnTCczwX3nVN4A2US/lMe6Qrs6sdcAfLDpRpSU0mrAKDT2zsxZUdU4Zhw4xlVsFnKWz29obNZSOW/ofB9JC8+qwqLiLMHORwNrtoSw9ci1wbssFIu1aY1YduzsT8UejwOG9yOhDQyDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177414; c=relaxed/simple;
	bh=AGkaUKeA48k63GxPvSgLYxDOipDNRk5KS3ygY4PCKG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boOkDzp2TnROnchFmMxqeEh99P8o8E1T85IC9Z/tIP85POh1wMSurZ24YXq36HdLmkl67rbhMmrisv56f0RNwMtN6xVkIM8m3OdjEcEBFngSi3CIU6in/52ddyqt7FizDrbIpTfe92tPL40xubs5Inx4B1CucJ7VA/+h0+U0PZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmO0cAEb; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c531473fdcso830699485a.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 19:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770177412; x=1770782212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kCf4lzrMziBndOsmo8GuusOdBN8cx0cDMD3sdQZPXW0=;
        b=BmO0cAEbtwvKngu30nYUWhuu3aW14QnGxWrBCqzYBGToAW15+DBOKjBy4BzuJubv6s
         Bu0U3vuCvBKWik7uVuvyCOIFsz2RAY9W+UIj5KyLaYlKHO1UwzQC0NDjjtkIJ6PuWvsR
         95KppZttig5Kcd9D5MwUSyQmNRsTyxD4Tzo1iS3zPbGE4v5/9TeolRejz0yhs8v5hEjI
         6d02GWMSEq7X2aIVmvZpPXpvDxYoTd/SCbMPBYGDYCFv4PMAOiCX7hbypHHIjJog1UJz
         4Ep905TS7u4OoIcUOO1vuvaOFtiAk8ICAbbvhLRuIqCsXAH823A/5lA0Heq3to1t1pJj
         PZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770177412; x=1770782212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCf4lzrMziBndOsmo8GuusOdBN8cx0cDMD3sdQZPXW0=;
        b=TQzHLeU7i1imP18xRhXb4Het93n+knKsiTUa74+Q7jFH26G2Mv4NWKXeCU9KSgh4h2
         /S50bbntPFs2pi68vrXOFEO68X8iuAR4pqKaym7h0Wjtqd0kHjxCaI/7O7lwvwC63t8C
         sZ/X0itBU6cIbGNp3YVmLagoQY33VX6bLj0bH4IFiR00NFenHag2/s2oImC2O3N5gZXG
         M/NF8x9bluYPvEXVuDql4jBvFTL5fwOzTDbPI3HrcOdw7UtU8uToo57pUeXmwJ9wzlR9
         oYh1IpatDOSeUvgDeFM51UIQZ37zUAXWs2hXb/GWaot05CSDN+tKB3gad1q8OG30qD9C
         zS4A==
X-Forwarded-Encrypted: i=1; AJvYcCX+KMKqVKgOctQy9VSWWRwmqlN1esqornNEWsZ3X6P2MK7fo0rx9iyVYKMNSb7WfAbxHUqhjx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVJ/bn8h7AY0QO42R4UlNiIJudRbdoBaaj6n0aIYciaKkYI55
	FkXRwz57h0yfL0ICSxxPkBuAWuSKk/EB8ZcepnUankGQ1th1QNE/2f1dJgaIoHsG
X-Gm-Gg: AZuq6aJam+mDJER3P66FCNP15EmnGRQ9JJGtKDpDmEtcPjuxIT+z8PLEL31gLiBLcjR
	zSgfxaIRtfR9UvgSdkgzuejZp+wGfinPjdlmtd4FKGxjEosU0MsFLQ4xyCspRaK0+tfCGIzNa5j
	wJiawph9yiFXEdn9SIwyrnamw+e1L0GsTUaAhDwjRV9j2dO7Asqh9C/b8Xd6vEqw3zJqCuRLljG
	jGCWFPXiR/qbDOFwSN7K/v4ua6mGKHTvvl/H4l5UKGhM3Zd7k0vDfcwpESda+/E3k9D74yi02qH
	DRa2fjVPOHSl4uMgNdK40d2KOedk7g2IAwAa+bmRONPztypKjn9VwIf2h7/xyT1FOHsT+NPYB7k
	M8MTKpBGWfylctWX5NUBxLRmjMIljZe5U6SVz1GiDcdtwCPlUcMKqHGUGIZyXMVdc4dShKAjJaZ
	b2cpG9crV8k/g7Brab6TVA
X-Received: by 2002:a05:7301:7003:b0:2b7:32fe:4bbb with SMTP id 5a478bee46e88-2b832895197mr603971eec.11.1770171121283;
        Tue, 03 Feb 2026 18:12:01 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832fafc2fsm746589eec.24.2026.02.03.18.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:12:00 -0800 (PST)
Date: Wed, 4 Feb 2026 10:11:36 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yanteng Si <siyanteng@cqsoftware.com.cn>, 
	Yao Zi <ziyao@disroot.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Shangjuan Wei <weishangjuan@eswincomputing.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Zhi Li <lizhi2@eswincomputing.com>, 
	Boon Khai Ng <boon.khai.ng@altera.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: Add support for
 Spacemit K3 dwmac
Message-ID: <aYKqh7SmoHO83Avr@inochi.infowork>
References: <20260130022705.1059214-1-inochiama@gmail.com>
 <20260130022705.1059214-2-inochiama@gmail.com>
 <aYIyuulFADU_j3V0@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYIyuulFADU_j3V0@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-256555-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,cqsoftware.com.cn,disroot.org,bp.renesas.com,eswincomputing.com,bootlin.com,altera.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[inochi.infowork:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1955FE16FE
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 05:39:06PM +0000, Russell King (Oracle) wrote:
> On Fri, Jan 30, 2026 at 10:27:02AM +0800, Inochi Amaoto wrote:
> > +  clocks:
> > +    items:
> > +      - description: GMAC main clock
> 
> If you know what this is in terms of dwmac databook clock terms, it
> would be helpful to use it here. I suspect "application clock" would
> probably summarise it, that being the clock for the bus interfaces
> that dwmac provides to the host.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

That's a good point, In fact, I have no dwmac databook now. So if you
think it is fine, I will change this description to the "application
clock". Thanks.

Regards,
Inochi

