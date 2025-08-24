Return-Path: <netdev+bounces-216268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B3EB32DBC
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF0F2051D1
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 06:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD70A23909C;
	Sun, 24 Aug 2025 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zRzQdU/E"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9200239096
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756016104; cv=none; b=XHwtX8dFhMKMZKvqBczkGvIupGf6RhgjOi+R8dgnD61UYin7vZW1yfyncNVALl88Ltn1YFvFPV3CBiO96S6qj/kc1zg6sXriXsrZxxIxyWJ8wUKgqxEhLdhJcLET34fZMW9NJ3HG/qSWVGL2xOXhMi3FDLo0QPkzzRa+Hpvfgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756016104; c=relaxed/simple;
	bh=srH1x9KNu8l1CGBeEE7UbpLM86BA98PxH1AmzKrI43w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bldzzQF9m9tehNNfMrkhTh49jLe0nO5VhgD5iUZxGuzNDpsaUEkI+9LHgoM6pxNVmUVsQp0oJF1uCTrE8S+QFFp2TdyOZ9eYnqlv07PuNIaezYbEaEkiI4tIdFGDa+piA+ek9WcsMi1/qVvcHSygQvX6WvlcQLv7ZKk8CGnrr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zRzQdU/E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XJNcRjw5toGkbDMbVP0D+FBSoxAKho17jgy82++k1Xw=; b=zRzQdU/ElHgDkQb/6td8iVgBxb
	Hyew4QJUr+v3M4NGpFQT1qnb7wngqSWRm+Cq/sl3UKgjvMdkfgPJjZMPypDUXhrBOFzYaihOaOeeW
	qugmI0ZH7FmBj+73ljS/5Km2eN7UKpkuTtClcyVnJXVUrR+Et7qcSCpVJJ1sfx66rZ+J+l0hhqdXU
	WWTA2emDMJOAzZNpaT7WwQVys3eK2zDPXIdmcFAw2O7JVsUlb+/SEIv6uoQjeI8zQL/1Lf1lp5wzo
	DMqog+DtwaSucqUzROuIdjHcg47SN1cGZnzRePV6XId49A5qBiDcSSGiBC9cZeu0/ShMUFU/6FRtb
	5NEJQQJw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uq40G-00000005lAr-3R3b;
	Sun, 24 Aug 2025 06:14:56 +0000
Message-ID: <277661e8-dd75-475e-b798-b384a66c7a93@infradead.org>
Date: Sat, 23 Aug 2025 23:14:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: fix stmmac_simple_pm_ops build
 errors
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <E1uojpo-00BMoL-4W@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <E1uojpo-00BMoL-4W@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/25 7:30 AM, Russell King (Oracle) wrote:
> The kernel test robot reports that various drivers have an undefined
> reference to stmmac_simple_pm_ops. This is caused by
> EXPORT_SYMBOL_GPL_SIMPLE_DEV_PM_OPS() defining the struct as static
> and omitting the export when CONFIG_PM=n, unlike DEFINE_SIMPLE_PM_OPS()
> which still defines the struct non-static.
> 
> Switch to using DEFINE_SIMPLE_PM_OPS() + EXPORT_SYMBOL_GPL(), which
> means we always define stmmac_simple_pm_ops, and it will always be
> visible for dwmac-* to reference whether modular or built-in.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508132051.a7hJXkrd-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202508132158.dEwQdick-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202508140029.V6tDuUxc-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202508161406.RwQuZBkA-lkp@intel.com/
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a55e43804670..fa3d26c28502 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8024,8 +8024,9 @@ int stmmac_resume(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(stmmac_resume);
>  
> -EXPORT_GPL_SIMPLE_DEV_PM_OPS(stmmac_simple_pm_ops, stmmac_suspend,
> -			     stmmac_resume);
> +/* This is not the same as EXPORT_GPL_SIMPLE_DEV_PM_OPS() when CONFIG_PM=n */
> +DEFINE_SIMPLE_DEV_PM_OPS(stmmac_simple_pm_ops, stmmac_suspend, stmmac_resume);
> +EXPORT_SYMBOL_GPL(stmmac_simple_pm_ops);
>  
>  #ifndef MODULE
>  static int __init stmmac_cmdline_opt(char *str)

-- 
~Randy

