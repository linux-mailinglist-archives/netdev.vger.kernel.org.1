Return-Path: <netdev+bounces-178617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9C9A77DAA
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F10716426B
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143712046BF;
	Tue,  1 Apr 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w1HMinGr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35A202F90;
	Tue,  1 Apr 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517611; cv=none; b=P8g2zN9aUEKDToZYmVOoz5NDLrTOyNRMnHh7woJrHdiI6GCjBu9yRAlerHPM0fe+54hxzn/hnBO3VjaYN+deXyp1HsjVAOG0OS2nSXeyjrvZlfJ4tBhOgnS8T2qXrqAJ1kSCmTjFomRHjj+3suCJJEYt4rO+xsuqLy0rVOj1+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517611; c=relaxed/simple;
	bh=3q+4yBpWMs18uCb9ElAcLNLMXOmLGv8K/NRxHjVPnwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsrptVffLQiIxfTpsiialPFxIKutRH6wpK2a+1J/J7VHHcbyVHwOSho8pyTbsWho/Qmn2BBgC9PzTJZg1kEbO+iTSCvXD0bK2sfSlhkINisCmFTn+ARCl3HV3WFWxfViGxGHYP/zJMJ/htNCvhNV2+jlDYssHwKlHRqYRV1oxUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w1HMinGr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/MiDSMXmSkUozSptENcrOEkA6Nl8T9COvZLyxjyLAcs=; b=w1HMinGrdUa2sUmccFf4UKSXn2
	UDB1RtzMqivkTW8LrZ3DXO9FBSi9OZ7Gz2hI1TBru91x+9wodVm1r98BuidYCys2oyJMY1wpmNpfg
	HcIOTp3y5/0gpuLuBLDqFPJFNX/5PYXYZj/8hVv4XVse315Vi3PgM2vxdz+1KSgclyVA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tzcZL-007goa-Ne; Tue, 01 Apr 2025 16:26:23 +0200
Date: Tue, 1 Apr 2025 16:26:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: steve@snewbury.org.uk
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppp: Pass PPP Kconfig defines through to the CPP
Message-ID: <b5e6d8a2-df18-4e64-938e-39e73d1214f9@lunn.ch>
References: <20250331194918.385248-1-steve@snewbury.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331194918.385248-1-steve@snewbury.org.uk>

On Mon, Mar 31, 2025 at 08:49:16PM +0100, steve@snewbury.org.uk wrote:
> From: Steven Newbury <steve@snewbury.org.uk>
> 
> It seems for a very long time the conditional code in ppp_generic.c for PPP_MULTILINK
> and PPP_FILTER hasn't been compiled!  I do wonder whether anybody actually still uses
> these options!
> ---
>  drivers/net/ppp/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ppp/Makefile b/drivers/net/ppp/Makefile
> index 16c457d6b324..9d12915e4ac5 100644
> --- a/drivers/net/ppp/Makefile
> +++ b/drivers/net/ppp/Makefile
> @@ -12,3 +12,10 @@ obj-$(CONFIG_PPP_SYNC_TTY) += ppp_synctty.o
>  obj-$(CONFIG_PPPOE) += pppox.o pppoe.o
>  obj-$(CONFIG_PPPOL2TP) += pppox.o
>  obj-$(CONFIG_PPTP) += pppox.o pptp.o
> +
> +ifdef CONFIG_PPP_MULTILINK
> +ccflags-y += -DCONFIG_PPP_MULTILINK
> +endif
> +ifdef CONFIG_PPP_FILTER
> +ccflags-y += -DCONFIG_PPP_FILTER
> +endif

That looks very odd. I don't see many other instances for Makefiles
doing this. Please add a bigger explanation of why this is needed, and
why the usual Kconfig mechanism don't work.

    Andrew

---
pw-bot: cr

