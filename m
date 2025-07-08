Return-Path: <netdev+bounces-205008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F6AFCDB3
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA6E7A7DAC
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF8F2DFF1D;
	Tue,  8 Jul 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u6eO9xcf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6852D2DAFCC;
	Tue,  8 Jul 2025 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985221; cv=none; b=SAwB7aRPVDj5TO4pMO0LxSWSBIxf5dTGC0HYp+fK2XNRiFn3A/9uOJYYWW+m3jA2kikCgbyS0XWLspsPVdD5+zgcT1UmlB3zj4eZU9ccx5NHRU8BMGKcowWd0mdMQEySTvWQfz/IjHJLDhtL7V7ZhMSmLuZtcLRXr1ba0Q+BOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985221; c=relaxed/simple;
	bh=3XrEcxV9R9YR0M0lRSTBHME+sP4TmaTv2G0TNp4On1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfEm9ukitUEB378N8/BLt0jJGjP+UfDMyhme1YQY88gSJhiCB7+VZkUY+4v6b0xEtccnAblX0YRQ2DFmquuaxIpNm8S+AxJAg534Pl43/Y8kHGgBxvhQT7ly4Wvj6M9JIBvGZdlr2awxzhRiR0lBEzoRzNZ1GrJL4MUDXPf+FzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u6eO9xcf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qt1Dm8hg4+cw50oWqi6P/j/pVrWP76gL+389q1zKEUU=; b=u6eO9xcfoR44wPODuVnEoYieT0
	bDjS4u8R883wqyvoMQS+55McSgo4HVBObJERb0b4TBsGKInZFzuQBNGEgC+l1xMmgA3JpVpcxDxlk
	E0U96Y8eatK3qtYsdFTmChtEPdd/43tPoMkQbN8NTotXCf8pSWfjbMrgw8Z/M47d4Hxg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ9Ny-000pU8-Du; Tue, 08 Jul 2025 16:33:30 +0200
Date: Tue, 8 Jul 2025 16:33:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	arnd@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/11] net: hns3: clean up the build warning in
 debugfs by use seq file
Message-ID: <0531ff61-c88a-4029-92f1-fe463e973cb7@lunn.ch>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
 <20250708130029.1310872-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708130029.1310872-3-shaojijie@huawei.com>

On Tue, Jul 08, 2025 at 09:00:20PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Arnd reported that there are two build warning for on-stasck
> buffer oversize. As Arnd's suggestion, using seq file way
> to avoid the stack buffer or kmalloc buffer allocating.
> 
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Closes: https://lore.kernel.org/all/20250610092113.2639248-1-arnd@kernel.org/
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

