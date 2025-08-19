Return-Path: <netdev+bounces-214977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7162B2C67A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2376188A437
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C46343D73;
	Tue, 19 Aug 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ar+pJ5rp"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7A34321E
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611962; cv=none; b=dCZgBy+mPJB2jZgh5JQLgw0bWthQCf5L5z4zP5EdJyBshnmqxUNXVTQvukbM9hm4bublC00ycyoTz/N7FFYWGsb+iVxpQCHrgObLPgg4g94/S1DStLd5QhxhT6h8eDZlUl1HJi+gbiepkSthJeMEE/PJm2ZOqZrnTIlXaQWAr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611962; c=relaxed/simple;
	bh=Szn3Y6AMPK50aULs7Wlbsj0z61OPOFi2aKHKUZhTJtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6IF6wYSvUzEifMiu/nC11nbbtg1M+A10gy+bOxoKfg73zUZRkWmO1eGPXoa2Fw0JGr3QS3Pu1M2IL1mTbsH4mfluXnRe/LRyi1dQBzascMTAhNGiyK77K5wOJtwjsdsDq0Wy84vzvdma6bgRCjk8hixOfQKpYnNSphHgJZIa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ar+pJ5rp; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d4a84d76-8982-4a9d-a383-2e2d4d66550a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755611955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CeRHv9dJ0yAy5sI3HR6ZowOM/hpbkUM1vk+TTh1pOvk=;
	b=ar+pJ5rpIlmZzzG/tk8atTNL52LbMuto6tyXaRDSIM1DF0dpkCH90AfIsAh1kgnQ+9lulm
	qHL/Gda2Pxt/fYM7jE0TmGGIB9wH0Ds3Zdm0hnxn9sFdjmbqgFDEHGwQNVj1rhmo3/LPWN
	7BpPySIVwhXqh39sgmH2qtLmCpoHTlQ=
Date: Tue, 19 Aug 2025 14:59:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/5] net: rnpgbe: Add n500/n210 chip support
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-3-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250818112856.1446278-3-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/08/2025 12:28, Dong Yibo wrote:
> Initialize n500/n210 chip bar resource map and
> dma, eth, mbx ... info for future use.
> 
[...]

> +struct mucse_hw {
> +	void __iomem *hw_addr;
> +	void __iomem *ring_msix_base;
> +	struct pci_dev *pdev;
> +	enum rnpgbe_hw_type hw_type;
> +	struct mucse_dma_info dma;
> +	struct mucse_eth_info eth;
> +	struct mucse_mac_info mac;
> +	struct mucse_mbx_info mbx;
> +	u32 usecstocount;

What is this field for? You don't use it anywhere in the patchset apart
from initialization. Maybe it's better to introduce it once it's used?
Together with the defines of values for this field...

