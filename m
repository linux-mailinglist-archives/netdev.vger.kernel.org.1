Return-Path: <netdev+bounces-234286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC2C1ECDE
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 08:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24499188AE2D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7964C337681;
	Thu, 30 Oct 2025 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NFQa9raw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1018A2DF710;
	Thu, 30 Oct 2025 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809910; cv=none; b=ioQqJ0W8CBN+BxoQTegJsDOqywQLjjCQ8+JQMC0hEJkfX28hoA+kZ8SN4rP5gZag5JuDyAZ4JZdbZcWje+eYVksYbUQ81KMj+/kt4EkpHsnCCAYtPVBknq5LimUVEidEN37dz1EiWpuZyFRNFImdnaHtx1s25HOgk8SA/fn6FV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809910; c=relaxed/simple;
	bh=dLE70Vb7ALl+7w9D13VKYrToxonM3UZ+Iq+NTt2I2zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW8QhDDP6FN/AP4kDjjbEgPgZ4sZZzah8CVnpuggKzfVMi0GrIkxV45gaQBHRMp5qBqJervF59yR7A4bKEr6PgB3+qP3kh+HqWMcbOOF84zmNw8nTzHuixUS4WWgD9Y2JOSfHNYNIJjVQzgEResUl71iVoTScEcTyo5d3xPtDT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NFQa9raw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C71F41A178F;
	Thu, 30 Oct 2025 07:38:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8A6886068C;
	Thu, 30 Oct 2025 07:38:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBD5D117FDA39;
	Thu, 30 Oct 2025 08:38:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761809902; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=PQ79r995lrIt1vl1eAOi6ClCmWaLJS9lKpg7n7yo+7E=;
	b=NFQa9rawQavfjzTLyyQ/Y0W+PMKaWgvzn9L9RhvvAHFzCf9Pt80fJTBxc0NGK7DXKca4ER
	oW9Z+VETAQJ5x9/ZRMYfm77dyHEBBzqStxjHtB8G/wdr+zwk/qwo9/ExJFYTLoiyidJPNe
	KreJ2ai4gjuoJzCetoYuz1bHPZHsfjBgj51Wnfaa/BpPGgv7VCs3uYMk0xBngf+zmqs3Kn
	CK4pBpnGydgYFRMmA7DDVGucOO48KxOBIYkAwRhYcsIFf9BQZruNNCLnxNb64brCOoig0g
	pcfySQcPOA7YwXDQOnFe7H21OgD2mtEcuYP12CdvgxK3z7WZvuDa/Zb0YFxdDQ==
Message-ID: <da8d9585-d464-4611-98c0-a10d84874297@bootlin.com>
Date: Thu, 30 Oct 2025 08:38:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: loongson: Use generic PCI
 suspend/resume routines
To: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yanteng Si <si.yanteng@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Philipp Stanner <phasta@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Qunqin Zhao <zhaoqunqin@loongson.cn>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Furong Xu <0x1207@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030041916.19905-1-ziyao@disroot.org>
 <20251030041916.19905-3-ziyao@disroot.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251030041916.19905-3-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 30/10/2025 05:19, Yao Zi wrote:
> Convert glue driver for Loongson DWMAC controller to use the generic
> platform suspend/resume routines for PCI controllers, instead of
> implementing its own one.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  1 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 36 ++-----------------
>  2 files changed, 4 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 598bc56edd8d..4b6911c62e6f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -373,6 +373,7 @@ config DWMAC_LOONGSON
>  	default MACH_LOONGSON64
>  	depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI
>  	depends on COMMON_CLK
> +	depends on STMMAC_LIBPCI

If we go with a dedicated module for this, "select STMMAC_LIBPCI" would
make more sense here I think. The same applies for the next patch.

Maxime


