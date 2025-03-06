Return-Path: <netdev+bounces-172321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7330AA54379
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C003B18952F1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 07:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A371A76DE;
	Thu,  6 Mar 2025 07:16:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E31DC9BB
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245363; cv=none; b=lSGs13s6AnoVflLBmsoCk5zw+Uod+Vvqlb0J1m26OSZsX5iCYcaQABfvZl2tom7xCGxLjP3fnzpiaP8YLxVsqJqio5S+FEJqhw0s76nCO+ap4goC7NgfknwJ3bWLw62LTQUpGuWqPPIJXyjgWwny5avWiyO2KfqcsoZ6uXzj790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245363; c=relaxed/simple;
	bh=wGfAs74KCaUlJxPiFDfFiHceEtknho+iBeYZPc/m/SM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP6xO1sc4L/XL9OYq3fZ8UNCM+HpypGoELwN+8jizK5jQw+J8YAZU7h4iFdGTVvHY8J0V9GgzBGy1LXxXpaj2BbpcZU9OqBC4G8shozlFnI9Zk8t5uQr84LH/S2s5uLcXDQnpSnxlqXwFnAndzDAosRJZ4SdaONfiR/FtlR2MEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id cef8990e-fa5a-11ef-8397-005056bdd08f;
	Thu, 06 Mar 2025 09:15:42 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 6 Mar 2025 09:15:39 +0200
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v9 5/6] net: stmmac: configure SerDes according
 to the interface mode
Message-ID: <Z8lLm9Ze9VAx3cE_@surfacebook.localdomain>
References: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
 <20250227121522.1802832-6-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227121522.1802832-6-yong.liang.choong@linux.intel.com>

Thu, Feb 27, 2025 at 08:15:21PM +0800, Choong Yong Liang kirjoitti:
> Intel platform will configure the SerDes through PMC API based on the
> provided interface mode.

> This patch adds several new functions below:-
> - intel_tsn_lane_is_available(): This new function reads FIA lane
>   ownership registers and common lane registers through IPC commands
>   to know which lane the mGbE port is assigned to.
> - intel_mac_finish(): To configure the SerDes based on the assigned
>   lane and latest interface mode, it sends IPC command to the PMC through
>   PMC driver/API. The PMC acts as a proxy for R/W on behalf of the driver.
> - intel_set_reg_access(): Set the register access to the available TSN
>   interface.

...

> config DWMAC_INTEL

>  	default X86
>  	depends on X86 && STMMAC_ETH && PCI
>  	depends on COMMON_CLK
> +	depends on ACPI

Stray and unexplained change. Please, fix it. We don't need the dependencies
which are not realised in the compile time.

-- 
With Best Regards,
Andy Shevchenko



