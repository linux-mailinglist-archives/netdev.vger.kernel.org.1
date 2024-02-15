Return-Path: <netdev+bounces-71959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C0A855AF8
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 08:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD58E28D123
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 07:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F4BA37;
	Thu, 15 Feb 2024 07:01:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19FAC127
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980499; cv=none; b=F3dcc6KnrzmftN/0nPJqDqbjdhiWqewVdibOXATeS2zpFUdHtRs53ruDxSgBtQ9N8RyJp73HjJqykBWnUVUxAa/ai29xMI8TidQD3efmQezfv2/9W7uom3b7gR92dYET64lIkGinNSvcBSBGcitPySW7/S1zKyc3X2gnlf4Mmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980499; c=relaxed/simple;
	bh=MFQj1JcV1Nn5HI9eVHEON0j1GNs6ssR7LSHkbbMCt2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHOpPMFjJ5ZeM+YXWnFZT99vmU5PrTe5hwwuilpobHUIUfUfp/u98C5VH3PuppYLpFH97AlJLNxI/Zy+PZi8M5vLpoc2Sx3jfvuUYWlyfwPqbXnLBdWcH59GS0DfyVck6exLychuvOwzm+I//vN3mDf/DxKYv/2VGDkawX61Ljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3d2cce1126so59623666b.2
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 23:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707980496; x=1708585296;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRjhCdJsI/DRtr+4eoGB54WCBZZHk7SY7wgG9EFZCjE=;
        b=QfCM8PmVMn64+oJQZMxM+ireaQvaXd7HLSi6vwHf3ShccNUxJrbI6bnETy7l4iKKjm
         Kl4mm5ugWpwXqB8ZJZNXkSx3I0bBaC5lBozBdToEmqTUoakpScRVLinkMck61Ttte03e
         CIdEOzLWXqmVs1G46LrVrN3YsAYLh+g7Rf2ngUEGuKvfw2pkQpBFeZ9mMJuQ1+fKE5lS
         jAYtjLBsCjV5NpSI+2GHOzZccW4KusdMOjoSUrt6mx45LoNnKNjdpWZYPct804+ERQM7
         XNLK11K5noTtWAnGYccHCQLX9pw7RQNVYZCEchln7EJFyX8Ah69KIMcZQFDKnqOKhzAW
         it0A==
X-Forwarded-Encrypted: i=1; AJvYcCW4R9Kl1L9MfQyR/VSshp+nDeNSP2RHV2lYAHKtkGcZBfKrbjPwLIBqR785cmUbUhb+nXl9/1BC0ZQT5mb8RM6lqfsa2zBs
X-Gm-Message-State: AOJu0Ywx7Shtc+Yvk7ZLlRhKAL1uvl0RuIdRviPkaIbei6so2uWfvrzk
	CLtslFBwtclLd+ibbyxX068zy7KozR2WVPJFR0Z0gzLhynWPbI5eOiJSF+jk8Lc=
X-Google-Smtp-Source: AGHT+IHveGS3w63L3+xeFKQLMRnqn5jueC2/go9JTt1gv7c5tHQGqVzCk+Kra02LsAJol/NB0gtQjw==
X-Received: by 2002:a17:906:1718:b0:a3c:e81a:9c35 with SMTP id c24-20020a170906171800b00a3ce81a9c35mr535532eje.73.1707980495732;
        Wed, 14 Feb 2024 23:01:35 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id wb4-20020a170907d50400b00a3cf4e8fdf5sm250735ejc.150.2024.02.14.23.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 23:01:34 -0800 (PST)
Message-ID: <485dbc5a-a04b-40c2-9481-955eaa5ce2e2@kernel.org>
Date: Thu, 15 Feb 2024 08:01:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: xgmac: use #define for string constants
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Serge Semin <fancer.lancer@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, Kernel Test Robot <lkp@intel.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20240208-xgmac-const-v1-1-e69a1eeabfc8@kernel.org>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240208-xgmac-const-v1-1-e69a1eeabfc8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08. 02. 24, 10:48, Simon Horman wrote:
> The cited commit introduces and uses the string constants dpp_tx_err and
> dpp_rx_err. These are assigned to constant fields of the array
> dwxgmac3_error_desc.
> 
> It has been reported that on GCC 6 and 7.5.0 this results in warnings
> such as:
> 
>    .../dwxgmac2_core.c:836:20: error: initialiser element is not constant
>     { true, "TDPES0", dpp_tx_err },
> 
> I have been able to reproduce this using: GCC 7.5.0, 8.4.0, 9.4.0 and 10.5.0.
> But not GCC 13.2.0.
> 
> So it seems this effects older compilers but not newer ones.
> As Jon points out in his report, the minimum compiler supported by
> the kernel is GCC 5.1, so it does seem that this ought to be fixed.
> 
> It is not clear to me what combination of 'const', if any, would address
> this problem.

You cannot make it more const than it is now ;). (You have a const 
pointer to const data already.)

> So this patch takes of using #defines for the string
> constants

That's indeed ugly. What about NOT creating a pointer to an array at 
all? See below.

> Compile tested only.
> 
> Fixes: 46eba193d04f ("net: stmmac: xgmac: fix handling of DPP safety error for DMA channels")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/netdev/c25eb595-8d91-40ea-9f52-efa15ebafdbc@nvidia.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402081135.lAxxBXHk-lkp@intel.com/
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 69 +++++++++++-----------
>   1 file changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 323c57f03c93..1af2f89a0504 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -830,41 +830,42 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
>   	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
>   };
>   
> -static const char * const dpp_rx_err = "Read Rx Descriptor Parity checker Error";
> -static const char * const dpp_tx_err = "Read Tx Descriptor Parity checker Error";

The usual (even documented, I believe) way to do this is:

static const char dpp_tx_err[] = "Read Tx Descriptor Parity checker Error";

Then keep:
{ true, "TDPES0", dpp_tx_err },

Doesn't it do the right job?

> +#define DPP_RX_ERR "Read Rx Descriptor Parity checker Error"
> +#define DPP_TX_ERR "Read Tx Descriptor Parity checker Error"

thanks,
-- 
js
suse labs


