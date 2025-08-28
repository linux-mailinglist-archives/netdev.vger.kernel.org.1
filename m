Return-Path: <netdev+bounces-217584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7C8B391D5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A3864E18A8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD64A266F00;
	Thu, 28 Aug 2025 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="peYwDduM"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C11244677
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349230; cv=none; b=l00rF/IWc9mWUDe+46mAze3emEwCKiNBgmLMFHq8gunrcSrU3jowidn6gjqSIJNiE4IUk1eafLurExW+b678KV2xooB/CDkELO+21Z0YADuEoYGrXl9WyVJUqU8A4kczG4otklbzz4JG63m3CQdeN8GJD/giOjLNTUIgxyTPz5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349230; c=relaxed/simple;
	bh=R5yzaulN+F7O8ACEE6XDwApit0JGc1W2RHdS2L87GE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DgRlp5815PHqdKF9da4VJAkHR9v61gp6Mqtr1r/bJkzWBr0QfXyN3ET/awW81v6SLhhZmapvmiFxBxIMlRoy7wQYhasVVwrPqWiy3PAwbhF7aWp/4vPTaNrM/GP/3sIwYAtdOJFPkGFBYxthurD1cJ4cj2FEj5KQDXSYSyUzm7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=peYwDduM; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b197403-4f7c-4d59-a2b0-79027ae26a5e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756349217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFY+u5oJVJUNGk86fO8X+WKbtH6SUno0sQHgRZyxGYA=;
	b=peYwDduMcRXioSdBNFTdiVEMxoSWUycok7UJWfcFMxb3P9AVU8p4QxWE+LqNHwqvPLaDJg
	v39XMOWWqhHjB6LA6aqm5DiwttEHIgiicRM14sNYRS3yorMncGNuDuId7BAT5ifbMS6u0s
	6ZkqU3PaOhKDGmh+71/LGR04Sk/L9x8=
Date: Wed, 27 Aug 2025 19:46:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net/mlx4: Remove redundant ternary operators
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:MELLANOX MLX4 core VPI driver" <netdev@vger.kernel.org>,
 "open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250827121503.497138-1-liaoyuanhong@vivo.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250827121503.497138-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/8/27 5:15, Liao Yuanhong 写道:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>   drivers/net/ethernet/mellanox/mlx4/port.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
> index e3d0b13c1610..5abdb1363ccc 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/port.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/port.c
> @@ -156,7 +156,7 @@ static bool mlx4_need_mf_bond(struct mlx4_dev *dev)
>   	mlx4_foreach_port(i, dev, MLX4_PORT_TYPE_ETH)
>   		++num_eth_ports;
>   
> -	return (num_eth_ports ==  2) ? true : false;
> +	return num_eth_ports == 2;

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   }
>   
>   int __mlx4_register_mac(struct mlx4_dev *dev, u8 port, u64 mac)


