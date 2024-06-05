Return-Path: <netdev+bounces-101134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BA48FD6FA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B53A2848DC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D8615884E;
	Wed,  5 Jun 2024 20:02:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E93157E6F
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617762; cv=none; b=Cr7MI95/IQY6vNc5wq/pHpz4VDFusPRkl3HLKgcYwVr1EsKyYAD228VWc0NsqbbaSwTsH2pGo9Iqta3OjPcn45GtmBY7V12KI5QTZMKgPqhxKWuuI0h1Wzh2nkYvjHlyLhvIwia+CZ37+knHHKW7ZNsiUm8RFtbfmgV6CnGIlB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617762; c=relaxed/simple;
	bh=/JxVIqbBvUpTaJFuPe7/jHaCJTckHhCxw2OwzeQBwwg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0tU8zrkfZlYcjksaDgqLePPGy1dGBS4ENp1D+odWyhXIa3PsxrYSyaHig5+TBiLI0jKTlJan9mIKX0nA9MWul2b2hv94T7EepK0+NYnttlpBavB4sEVhDR5cqfyaWopPCK1Sikm86QRYp/ulcqtQKLT3JnBNq1zE7w5vZvxEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 8aaa2179-2376-11ef-80de-005056bdfda7;
	Wed, 05 Jun 2024 23:02:32 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 5 Jun 2024 23:02:30 +0300
To: Herve Codina <herve.codina@bootlin.com>
Cc: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 09/19] irqdomain: Add missing parameter descriptions
 in docs
Message-ID: <ZmDEVoC9NUh7Gg7k@surfacebook.localdomain>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-10-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527161450.326615-10-herve.codina@bootlin.com>

Mon, May 27, 2024 at 06:14:36PM +0200, Herve Codina kirjoitti:
> During compilation, several warning of the following form were raised:
>   Function parameter or struct member 'x' not described in 'yyy'
> 
> Add the missing function parameter descriptions.

...

>  /**
>   * irq_domain_translate_onecell() - Generic translate for direct one cell
>   * bindings
> + * @d:		Interrupt domain involved in the translation
> + * @fwspec:	The firmware interrupt specifier to translate
> + * @out_hwirq:	Pointer to storage for the hardware interrupt number
> + * @out_type:	Pointer to storage for the interrupt type

(kernel-doc perhaps will complain on something missing here)

>   */
>  int irq_domain_translate_onecell(struct irq_domain *d,

You can go further and run

	scripts/kernel-doc -v -none -Wall ...

against this file and fix more issues, like I believe in the above excerpt.

-- 
With Best Regards,
Andy Shevchenko



