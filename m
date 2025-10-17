Return-Path: <netdev+bounces-230595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB31BEBB6E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BD11AE22D6
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9A5233155;
	Fri, 17 Oct 2025 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="XQLLbQxe"
X-Original-To: netdev@vger.kernel.org
Received: from mx11lb.world4you.com (mx11lb.world4you.com [81.19.149.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FB354AC1
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733815; cv=none; b=OiKQ89hNl0S3758F9AJ1mDKvCPLKeaOC8Dyo7hGA/s01DzX6d+ohPKH1p2z9kyUG2IJ5fVU15Zgk2xvjXAUvMupLPb+oKfCXL6qQMjq25X95V9WCVwz3LFoPv6v1hIaZe9b0jrFaQq/JYunbIJFWeA1bt5tVfYMtM4oAbMi+DHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733815; c=relaxed/simple;
	bh=l4zb+HSB6EF4BzL70idqYRc4N2ZjEhF6sbpqP5/Buu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mN+2zjo2SglKs4k8kz//blCzHYLLpAv4KJG9Hr9iZxGQUbnJFn8FprGXJBhhUj5GTIlj6QAEEM6ERx1g0I+qbyyIAVVuZ5NP7G6c7gvu5778IWfoEtyTBW0mdjC85KmY0A3Vy3AYVCJgzGm1veVxVGJyW8I973EGAX3BIITNNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=XQLLbQxe; arc=none smtp.client-ip=81.19.149.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Poi/ra3FzfJB89NpP5j1a5aOZV3g5KpAabWQh6MeD3s=; b=XQLLbQxeBSKHloOqhpOEUyRBUt
	Go1zfFqhOwo/ytLx0Q9kfvDNy3N7Bvt2b32lvt4vJ2kSbpkBqdaI3iYQV0EJL1VWql75J6jkTgfxC
	CssF55RlLEqwbGOmlMoM9/NN9C0aJfYW/9qobKQ0sa8YsSWdbKV2WjwkA83N1y6JW7Qs=;
Received: from [93.82.65.102] (helo=[10.0.0.160])
	by mx11lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1v9rIQ-000000008TX-43oP;
	Fri, 17 Oct 2025 22:43:31 +0200
Message-ID: <f807acdf-51f1-432f-8dc5-7d783c04f83a@engleder-embedded.com>
Date: Fri, 17 Oct 2025 22:43:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: loop: use new helper
 fixed_phy_register_100fd
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Vladimir Oltean <olteanv@gmail.com>
References: <d6598983-83b1-4e1c-b621-8976520869c7@gmail.com>
 <7fbb5ab7-f77c-4e13-8607-fe4572f1d302@gmail.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <7fbb5ab7-f77c-4e13-8607-fe4572f1d302@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 17.10.25 22:14, Heiner Kallweit wrote:
> Use new helper fixed_phy_register_100fd() to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/dsa/dsa_loop.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
> index 650d93226..4a416f271 100644
> --- a/drivers/net/dsa/dsa_loop.c
> +++ b/drivers/net/dsa/dsa_loop.c
> @@ -441,11 +441,6 @@ static int __init dsa_loop_create_switch_mdiodev(void)
>   
>   static int __init dsa_loop_init(void)
>   {
> -	struct fixed_phy_status status = {
> -		.link = 1,
> -		.speed = SPEED_100,
> -		.duplex = DUPLEX_FULL,
> -	};
>   	unsigned int i;
>   	int ret;
>   
> @@ -454,7 +449,7 @@ static int __init dsa_loop_init(void)
>   		return ret;
>   
>   	for (i = 0; i < NUM_FIXED_PHYS; i++)
> -		phydevs[i] = fixed_phy_register(&status, NULL);
> +		phydevs[i] = fixed_phy_register_100fd();
>   
>   	ret = mdio_driver_register(&dsa_loop_drv);
>   	if (ret) {

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

