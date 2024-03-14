Return-Path: <netdev+bounces-79874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DB387BD25
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8799A1C20DC0
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA545C60D;
	Thu, 14 Mar 2024 12:59:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D559B52
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421181; cv=none; b=Zx8w7sJlOgrZHzSWNhA6Ut59kFBzAlv8asviZHHIAFi9O+MjuybJ4zUjO9aI3LaKbr/KWG5p07h38LElN5FTdE5jkCKtp4CeLG5NZe5V2BP4avvUrHcV0TdkNB0X8CZTTPz4uWRVrJJwPnG79CFvoj/3WppqDSXMWO3I3T7lcEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421181; c=relaxed/simple;
	bh=+rms/kDuBhqMXLB59rkkrFsOGlIT7MHKNI5aQZCTr58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxG59SEPXGq8p87lZWh8Lq1S39LsFyEZMI81SVF0qT5k5X6+ZwBNGHkMGjkbmi50DdBCh1S4mn5rfSupj/PkyLON+CiKeET0D10gWbPKnWWjypGwHe/Y8v19LAJrVhm5idaICnUUA3jF5YePAPZpH093qaYDeq5ejKAduip/zzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a44ad785a44so102434866b.3
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 05:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710421178; x=1711025978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gR7GidsHLbJVyHyYsUnJOzOAfP+erQYrxOLCy0B/Mg=;
        b=XeLrBjp+xSpZY7Ok6VOFIRbpG/usCjIU6C1j4/yR/xDHDfn2eNB1AyjRHae/DZ8I8z
         dk0fNr/LC4kqbEKUiSMo1XEUH9bjM5svbvDqXzdut5+245VPh1IcgJ6upgTWl9mt8Q7C
         Kxxj9YoxakfINmIKO4cCUr9rMLOStPgaaoEfSrUSxdQPwks4nG4//ngK9JTpbFJSa46L
         xFDaPqDwNuTC+FTtycv9zMEeZ8Lq54PNva/evmbmU/SubJLOOAXn97z6ShY3O3tAUiGX
         fsCbAPwdt9J8ema37aRGLHTwrjQRmguBzogis9z0a/K12vmskeKQb0rgF8biW3aRoFhk
         P1ug==
X-Gm-Message-State: AOJu0Yw18bahM//OINOQpqjWsG36OIj7iyTvfHa0pFQAUbBY36adZQ96
	TtcseVB2t1HqPAphtM3OFUmIdzbJsEw+a9u9v7flVRMcZW65NftJ
X-Google-Smtp-Source: AGHT+IGctERA3zI9AeJZv6wj96wN1XiRaAASBOiQQ3kzpsL2k0N9sKJ4KVDVJz7qbXbaDaWC+XSLfw==
X-Received: by 2002:a17:906:1519:b0:a3d:656a:4700 with SMTP id b25-20020a170906151900b00a3d656a4700mr1038679ejd.71.1710421178219;
        Thu, 14 Mar 2024 05:59:38 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906bc4b00b00a4671d37717sm603225ejv.52.2024.03.14.05.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 05:59:37 -0700 (PDT)
Date: Thu, 14 Mar 2024 05:59:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net] hsr: Handle failures in module init
Message-ID: <ZfL0t5v3szkhEhiN@gmail.com>
References: <0b718dd6cc28d09fd2478d8debdfc0a6755a8895.1710410183.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b718dd6cc28d09fd2478d8debdfc0a6755a8895.1710410183.git.fmaurer@redhat.com>

On Thu, Mar 14, 2024 at 11:10:52AM +0100, Felix Maurer wrote:
> A failure during registration of the netdev notifier was not handled at
> all. A failure during netlink initialization did not unregister the netdev
> notifier.
> 
> Handle failures of netdev notifier registration and netlink initialization.
> Both functions should only return negative values on failure and thereby
> lead to the hsr module not being loaded.
> 
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> ---
>  net/hsr/hsr_main.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
> index cb83c8feb746..1c4a5b678688 100644
> --- a/net/hsr/hsr_main.c
> +++ b/net/hsr/hsr_main.c
> @@ -148,14 +148,24 @@ static struct notifier_block hsr_nb = {
>  
>  static int __init hsr_init(void)
>  {
> -	int res;
> +	int err;
>  
>  	BUILD_BUG_ON(sizeof(struct hsr_tag) != HSR_HLEN);
>  
> -	register_netdevice_notifier(&hsr_nb);
> -	res = hsr_netlink_init();
> +	err = register_netdevice_notifier(&hsr_nb);
> +	if (err)
> +		goto out;

Can't you just 'return err' here? And avoid the `out` label below?

> +
> +	err = hsr_netlink_init();
> +	if (err)
> +		goto cleanup;

Same here, you can do something like the following and remove the
all the labels below, making the function a bit clearer.

	if (err) {
		unregister_netdevice_notifier(&hsr_nb);
		return err;
	}

