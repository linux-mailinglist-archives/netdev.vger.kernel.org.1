Return-Path: <netdev+bounces-236986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EFCC42D16
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 13:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0682188DED8
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2624DD13;
	Sat,  8 Nov 2025 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s4Kn5aYp"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2EA1C4A13
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762605840; cv=none; b=AOMmarelebQl3ieWyQtCPU6rcgWACfQ3OuuN5pEKtawa1kDiKjq5QlWAgN8MIj+z9aZ+plvnztj3o+iB2KJE2O3bX1pMKY8nSYIJOSQI0ENb+xtyQBvezg2Bo8sZGYDzkDXtVvn3V1X4zLu4H6F9naL5+azQl/bs2+2EF813RAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762605840; c=relaxed/simple;
	bh=K4PJ9R5wTIALHM/Tc4CAxvgVd76srTdgYSWo6X6IaWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sd6210zEzjepQvj8KFarSj0+hU4pP3vPoirJnxsY3KqkVBbJjAaPf/5l0aflZJdYPLihbzt5r3KfHt5vayJty9hFoUIP8hWFYd3gTT/pvshf88x7sT5K0KRAMc4rfgdShgPpX4IHelitFUJXjOlxh5qkDsWzxheWkB9+kdNSOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s4Kn5aYp; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <01dbac10-fbe3-4211-bf8a-eb622df81f64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762605836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35uag0c9PWa/OKnCcOpk+fDDvnpbD7zK/Uw+nebBTCg=;
	b=s4Kn5aYpn1DdwSUx3iZ3/x50wYtOwzI9ftteXiF7NCmo4jBky5JwoeeNE30/0YcnhWMbTk
	knboaXFaMMnrh5k3jg+Ptw1ML5pf3kLVmMAetcXFfuWOJ3np8nSW/YwG1ae44v1I7v0GRI
	ldD55Lu1nzHtKpVPBUthiO+SCcJuyR8=
Date: Sat, 8 Nov 2025 12:43:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: netcp: ethss: Fix type of first parameter
 in hwtstamp stubs
To: Nathan Chancellor <nathan@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev
References: <20251107-netcp_ethss-fix-cpts-stubs-clang-wifpts-v1-1-a80a30c429a8@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251107-netcp_ethss-fix-cpts-stubs-clang-wifpts-v1-1-a80a30c429a8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/11/2025 03:19, Nathan Chancellor wrote:
> When building with -Wincompatible-function-pointer-types-strict, a
> warning designed to catch control flow integrity violations at compile
> time, there are several instances in netcp_ethss.c when CONFIG_TI_CPTS
> is not set:
> 
>    drivers/net/ethernet/ti/netcp_ethss.c:3831:18: warning: incompatible function pointer types initializing 'int (*)(void *, struct kernel_hwtstamp_config *)' with an expression of type 'int (struct gbe_intf *, struct kernel_hwtstamp_config *)' [-Wincompatible-function-pointer-types-strict]
>     3831 |         .hwtstamp_get   = gbe_hwtstamp_get,
>          |                           ^~~~~~~~~~~~~~~~
>    drivers/net/ethernet/ti/netcp_ethss.c:3832:18: warning: incompatible function pointer types initializing 'int (*)(void *, struct kernel_hwtstamp_config *, struct netlink_ext_ack *)' with an expression of type 'int (struct gbe_intf *, struct kernel_hwtstamp_config *, struct netlink_ext_ack *)' [-Wincompatible-function-pointer-types-strict]
>     3832 |         .hwtstamp_set   = gbe_hwtstamp_set,
>          |                           ^~~~~~~~~~~~~~~~
>    drivers/net/ethernet/ti/netcp_ethss.c:3850:18: warning: incompatible function pointer types initializing 'int (*)(void *, struct kernel_hwtstamp_config *)' with an expression of type 'int (struct gbe_intf *, struct kernel_hwtstamp_config *)' [-Wincompatible-function-pointer-types-strict]
>     3850 |         .hwtstamp_get   = gbe_hwtstamp_get,
>          |                           ^~~~~~~~~~~~~~~~
>    drivers/net/ethernet/ti/netcp_ethss.c:3851:18: warning: incompatible function pointer types initializing 'int (*)(void *, struct kernel_hwtstamp_config *, struct netlink_ext_ack *)' with an expression of type 'int (struct gbe_intf *, struct kernel_hwtstamp_config *, struct netlink_ext_ack *)' [-Wincompatible-function-pointer-types-strict]
>     3851 |         .hwtstamp_set   = gbe_hwtstamp_set,
>          |                           ^~~~~~~~~~~~~~~~
> 
> While 'void *' and 'struct gbe_intf *' are ABI compatible, hence no
> regular warning from -Wincompatible-function-pointer-types, the mismatch
> will trigger a kCFI violation when gbe_hwtstamp_get() or
> gbe_hwtstamp_set() are called indirectly. The types were updated for the
> CONFIG_TI_CPTS=y implementations but not the CONFIG_TI_CPTS=n ones.
> 
> Update the type of the first parameter in the CONFIG_TI_CPTS=n stubs to
> resolve the warning/CFI violation.
> 
> Fixes: 3f02b8272557 ("ti: netcp: convert to ndo_hwtstamp callbacks")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/net/ethernet/ti/netcp_ethss.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
> index 0ae44112812c..4f6cc6cd1f03 100644
> --- a/drivers/net/ethernet/ti/netcp_ethss.c
> +++ b/drivers/net/ethernet/ti/netcp_ethss.c
> @@ -2755,13 +2755,13 @@ static inline void gbe_unregister_cpts(struct gbe_priv *gbe_dev)
>   {
>   }
>   
> -static inline int gbe_hwtstamp_get(struct gbe_intf *gbe_intf,
> +static inline int gbe_hwtstamp_get(void *intf_priv,
>   				   struct kernel_hwtstamp_config *cfg)
>   {
>   	return -EOPNOTSUPP;
>   }
>   
> -static inline int gbe_hwtstamp_set(struct gbe_intf *gbe_intf,
> +static inline int gbe_hwtstamp_set(void *intf_priv,
>   				   struct kernel_hwtstamp_config *cfg,
>   				   struct netlink_ext_ack *extack)
>   {
> 

Fair, netcp_module expects 'void *' type of the first parameter.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

