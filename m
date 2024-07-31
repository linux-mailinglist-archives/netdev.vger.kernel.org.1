Return-Path: <netdev+bounces-114544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A2942DBD
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A0BB213AA
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A4E1AE85B;
	Wed, 31 Jul 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gGHe2T9n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF31AD416;
	Wed, 31 Jul 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427624; cv=none; b=tjesQgWtsLH4AqPsVYuMQuFBLxHSibrIj4BzZnrURTk2hioyFpXiuacnnyb4fnbcCYv0TJ/YTko/HjjwHWdADnzEMMhyF3T06ToIr5xxgK8j07Ddr8ZMpt4FwJpBgc46dD9W0K1G5D7ewFz8F7Xb0egwX8MECGd7CmrGol/+X9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427624; c=relaxed/simple;
	bh=8ZwwicN0f1utYiHwu9duh66IA9U3WSjNKvKYBLjXBYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlyunJZXS5WUZ45r/9gi6aEaTqN6ZsPosSEsJ3V420tCL/ZKHSPEi5VFcI50ciS5CvvoLfajtU/RDiuL+eHq+qr+dhztZCEzM5ZUgRDbE1hxD+sEzmzZ6sKo3AOmQUnLu+u37wLRNJEhhYBQyfmH0a1XE6BF+7OAzclGx3x+h5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gGHe2T9n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3c+TGYxN3nHuViQsTaOkw7Vvw2f0tV0QCp+u/9EpqjE=; b=gGHe2T9nxQIWeqyFSZoJ7rYuv0
	20Q9bH6tYKSHF3NMUoh5kqhmm/lTRqVpfMIPb1YKXSYQyXmdc/r08ESgUY/K+djKAfY4wwqwH8Y1J
	YwDMmHqBVA4FoDtE+gr4RtEuYlMsxiBf1xOpdGYdetzmx0EQLF0GEaOUEMdNY+B29J2s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZ86Z-003fbn-Gr; Wed, 31 Jul 2024 14:06:55 +0200
Date: Wed, 31 Jul 2024 14:06:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michal.simek@amd.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH net-next v2 4/4] net: axienet: remove unnecessary
 parentheses
Message-ID: <d73ee99f-db14-4d93-a96a-75ecc8068014@lunn.ch>
References: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1722417367-4113948-5-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722417367-4113948-5-git-send-email-radhey.shyam.pandey@amd.com>

On Wed, Jul 31, 2024 at 02:46:07PM +0530, Radhey Shyam Pandey wrote:
> Remove unnecessary parentheses around 'ndev->mtu
> <= XAE_JUMBO_MTU' and 'ndev->mtu > XAE_MTU'. Reported
> by checkpatch.
> 
> CHECK: Unnecessary parentheses around 'ndev->mtu > XAE_MTU'
> +       if ((ndev->mtu > XAE_MTU) &&
> +           (ndev->mtu <= XAE_JUMBO_MTU)) {
> 
> CHECK: Unnecessary parentheses around 'ndev->mtu <= XAE_JUMBO_MTU'
> +       if ((ndev->mtu > XAE_MTU) &&
> +           (ndev->mtu <= XAE_JUMBO_MTU)) {
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

