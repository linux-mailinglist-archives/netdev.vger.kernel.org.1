Return-Path: <netdev+bounces-134695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 133E299AD70
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806721F26994
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C501CFEDB;
	Fri, 11 Oct 2024 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="YPkKh6jD"
X-Original-To: netdev@vger.kernel.org
Received: from mx12lb.world4you.com (mx12lb.world4you.com [81.19.149.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8A19CC10;
	Fri, 11 Oct 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728678171; cv=none; b=GkcyuhNJ8IUCzTXagb+vzyGrf2WqiRafZ1TKJ7G0u9jZcK7ScOdYCPUt1FJUzVVKdKXriGcHYwejsZimfTvBTJydBeygsUradTmPmwuFTOTpNCgDHft9s9Tt3JrfszWMJJS4aQ11A9pGnWKvYbgnglVLMlPhSoRi+X6A1gnWYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728678171; c=relaxed/simple;
	bh=o1p6HdCwRmUApb9tNgiNyyuEvJ6xeYq9HvMsLZaqAos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWgGZVdaGm9G8IrfZNq7QUHsq6BKzTez/EF9ov0Zn6ihgxihB1TFm79n/INH1MT1W2m16wLCgnHp2hdLG2gTLFiY6Rwqsoyr/pVYmjZhHuJsJ2//TWHXeINED6ze0LlGqojUsacBlD7p2MVlCGgA0/qKNg6MveDP0LlE7CPu36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=YPkKh6jD; arc=none smtp.client-ip=81.19.149.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=frOywx17qU6KIQhhbQbd1Vff42g33lh7MMg5mhNFEr4=; b=YPkKh6jDH3Sew7LE48SUPEltn1
	fMMuIqoTpQmtmbdS452mGvlUVEmvr1Lsea058neLWe/hKDoND86Put4u5Iv/T77Jef0PJEcchjVsy
	h6jtyxy9Cc/Ie4L90sRI9aiYBdCi4qBoMFSPVgTS4Dyyavxh7AKFmVpubODfxZuMvH28=;
Received: from [88.117.56.173] (helo=[10.0.0.160])
	by mx12lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1szM9w-000000004O1-0hQf;
	Fri, 11 Oct 2024 22:22:48 +0200
Message-ID: <4f41c73a-019f-498d-a2d2-413848511882@engleder-embedded.com>
Date: Fri, 11 Oct 2024 22:22:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mvneta: use ethtool_puts
Content-Language: en-US
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20241011195955.7065-1-rosenp@gmail.com>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20241011195955.7065-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes



On 11.10.24 21:59, Rosen Penev wrote:
> Allows simplifying get_strings and avoids manual pointer manipulation.
> 
> Tested on Turris Omnia.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/ethernet/marvell/mvneta.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index fcd89c67094f..7bb781fb93b5 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -4795,11 +4795,9 @@ static void mvneta_ethtool_get_strings(struct net_device *netdev, u32 sset,
>   		int i;
>   
>   		for (i = 0; i < ARRAY_SIZE(mvneta_statistics); i++)
> -			memcpy(data + i * ETH_GSTRING_LEN,
> -			       mvneta_statistics[i].name, ETH_GSTRING_LEN);
> +			ethtool_puts(&data, mvneta_statistics[i].name);
>   
>   		if (!pp->bm_priv) {
> -			data += ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

