Return-Path: <netdev+bounces-95397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA78C229E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29F91F21991
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3889116ABC3;
	Fri, 10 May 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbCNeM4P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227A135A63;
	Fri, 10 May 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338706; cv=none; b=Bpwqr9s7WPLyO9mTUAPlTf+0A7/U+qrayAzEnypD3+gE4aNEIJS79LFvvX5biS8QoY9G6v0b9Tb4MhRbk+S0lD5YfKlchF/GkhAYxStYHrJtHFO2rXibR69T+wjpWpXJ8SoOHe38Z5EKdnsHOmnKzi460SKQXVAnJhNJELIxacY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338706; c=relaxed/simple;
	bh=WGtE5WWpk/C1iE7KEMLqGKCNQCr1YROMZTc7+mCeVPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVnIQIWdH3hKhhkbjVbwb6yP1AYqZpGer+Kt611HD15MKrODKv9cO8ibrOR4QSp1aQPmnuUXsXV4IyrHRHhMb8VjR/HFcCkQ7lwMilm5HBEfihWuxHqRaZHf9n0WxW4UVg4jAw4Uvo8VHhaGi5fjLe97HHmgA218HjdGGVNRmig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbCNeM4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB0BC113CC;
	Fri, 10 May 2024 10:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715338705;
	bh=WGtE5WWpk/C1iE7KEMLqGKCNQCr1YROMZTc7+mCeVPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbCNeM4PSvPZ6TgJXun9VcmgdjTHxN2RNJ2s0SVwbgFfgEr9+dI3NksT3zI3e7Unx
	 OpkLXUeiUUMt60VM47bjs558cCbfK5398Ugd9nqQ23r8lE8f0quNB7wBpDMoLTgd+X
	 c9BZP98PE/15bZpKII9pShH2eZkLpoB0a9BFIY9ShG0A88hrcT0gTlFAhdjZ9Y0xgR
	 2G9Oq0ADFV9YKPhgUqTftCrA8Z3cptqIgmkT3tQ9+DZJNOlpc53Ld0YVENfPf8ZZdn
	 1HDANm8yy463kXg6e+RKXbLhEy+cmT1RioXrzwTtQxsl6VeFtIpQZFbcIIlNbR/zjB
	 MELTHDwNHCzmQ==
Date: Fri, 10 May 2024 11:58:20 +0100
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ciprian Regus <ciprian.regus@analog.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH net-next v1 1/1] net: ethernet: adi: adin1110: Replace
 linux/gpio.h by proper one
Message-ID: <20240510105820.GA2347895@kernel.org>
References: <20240508114519.972082-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508114519.972082-1-andriy.shevchenko@linux.intel.com>

+ Ciprian Regus and Yang Yingliang (via get_maintainer.pl)

On Wed, May 08, 2024 at 02:45:19PM +0300, Andy Shevchenko wrote:
> linux/gpio.h is deprecated and subject to remove.
> The driver doesn't use it directly, replace it
> with what is really being used.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/adi/adin1110.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
> index 8b4ef5121308..0713f1e2c7f3 100644
> --- a/drivers/net/ethernet/adi/adin1110.c
> +++ b/drivers/net/ethernet/adi/adin1110.c
> @@ -11,10 +11,10 @@
>  #include <linux/crc8.h>
>  #include <linux/etherdevice.h>
>  #include <linux/ethtool.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/if_bridge.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
> -#include <linux/gpio.h>
>  #include <linux/kernel.h>
>  #include <linux/mii.h>
>  #include <linux/module.h>
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 
> 

