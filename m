Return-Path: <netdev+bounces-164493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26773A2E001
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 19:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4D71882DD3
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124A1D934D;
	Sun,  9 Feb 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="aOs0nG8i"
X-Original-To: netdev@vger.kernel.org
Received: from mx10lb.world4you.com (mx10lb.world4you.com [81.19.149.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10B1DE88B
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739126725; cv=none; b=pu2+WkDALR8Zpx7yWZnR3kdnomPvkZJcXw4vTT9x/WB2HylTkLPAUKdU36WuI/GwiiBiqsvEchTucWVeeo/jJVPY58gazblf1hssyT5LeTgO4jiOriPidrOYKf335hstYdZVn3toNgupZEOeKBV2PHAM3xO4tc0H/nlyqAqu4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739126725; c=relaxed/simple;
	bh=2WrSbi+Uo3ib6BNjbcYeSbgwXEfdCjTNB0zOjZTqknw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNqE6sO+f7yomtLck4y6R3otCOloYA0SWbFRqDyE9KLVUwKD+K6fSdmKQ7JeQtyXy3ot9Me7VpOZxmGJXzfWmlJc1gyD61u5FI7wibC5LXamYQVTwSEJnr0MHiUXRVBG9PAVXeW+XQIp8bUH0+HvvSqGOuRMhfGbsTyI/cQz8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=aOs0nG8i; arc=none smtp.client-ip=81.19.149.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lJ0M1krCmi4eiwYD2F8NcoMHdmDqLxf3C+ZCd5NYc0s=; b=aOs0nG8iCgPhMu0X6frAFmWxgo
	jsVXpuqyarFrlcNmBJ6SKf/ou9ZIxO7C0PifSq/w29e5FuYue0zFLiuDsGlb1kG0RZzSbWfH6798Y
	FatCS9D7J9ysG95zHe4VmgErCeP4NPLAAxEd9yOPXj+FdJ3kx5hhQGzMOYXeVqzydv/o=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx10lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1thC1d-000000006NR-3bxU;
	Sun, 09 Feb 2025 19:27:26 +0100
Message-ID: <3a94fc8d-b2de-4ccf-be41-dc9c1aed26fd@engleder-embedded.com>
Date: Sun, 9 Feb 2025 19:27:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: freescale: ucc_geth: remove unused
 PHY_INIT_TIMEOUT and PHY_CHANGE_TIME
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Simon Horman <horms@kernel.org>
References: <62e9429b-57e0-42ec-96a5-6a89553f441d@gmail.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <62e9429b-57e0-42ec-96a5-6a89553f441d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 09.02.25 13:27, Heiner Kallweit wrote:
> Both definitions are unused. Last users have been removed with:
> 
> 1577ecef7666 ("netdev: Merge UCC and gianfar MDIO bus drivers")
> 728de4c927a3 ("ucc_geth: migrate ucc_geth to phylib")
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/ethernet/freescale/ucc_geth.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.h b/drivers/net/ethernet/freescale/ucc_geth.h
> index 38789faae..84f92f638 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.h
> +++ b/drivers/net/ethernet/freescale/ucc_geth.h
> @@ -890,8 +890,6 @@ struct ucc_geth_hardware_statistics {
>   							   addresses */
>   
>   #define TX_TIMEOUT                              (1*HZ)
> -#define PHY_INIT_TIMEOUT                        100000
> -#define PHY_CHANGE_TIME                         2
>   
>   /* Fast Ethernet (10/100 Mbps) */
>   #define UCC_GETH_URFS_INIT                      512	/* Rx virtual FIFO size

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

