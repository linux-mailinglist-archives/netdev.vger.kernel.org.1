Return-Path: <netdev+bounces-121255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF595C5DB
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFAD284311
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 06:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB7D80631;
	Fri, 23 Aug 2024 06:54:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAC853E15
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396047; cv=none; b=SCyUbwjRtBlnGZyJ/SzfXRgXMbhWvCxleuQIFi+r0GPgHxKZrioenTQ6w9AsJXPwTozE2+vvuNtzkrAMSmIdwESdJo08zvAcRHynpwox+hls+ZsXMpdm8QIhMyuAnuq4Ir3z4pyYfwUa/d4naqEdtgENwBVek92tpXObEQeH1II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396047; c=relaxed/simple;
	bh=8cCu8HNwGC02T0/SH+DiYoW1KpkL7pVgu7ck335uNUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iF5/X7G3zDFF2FTfDA1D5ofALktDr1hLVAn6vv7bD5JWerDCw3fR+Ps2F2c26KjbQeeDcapgjKrv1K5t/y67P9IIJbxItlZwzx2uFfk4B1Q/4w8SMEmI6/XGvMX2nt9HlF3sxAlsi69qQWH21920jmuZ88HazXTc5iFRSTvY2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WqrJv265Sz20mQ4;
	Fri, 23 Aug 2024 14:49:19 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id F38EF1A016C;
	Fri, 23 Aug 2024 14:54:02 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 14:54:02 +0800
Message-ID: <e771d82b-81d7-43c2-bc16-280598cc1c9a@huawei.com>
Date: Fri, 23 Aug 2024 14:54:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/2] net/ipv4: fix macro definition
 sk_for_each_bound_bhash
To: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>
References: <20240823070042.3327342-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240823070042.3327342-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Sorry, wrong subject, just ignore this.

Thanks,
Hongbo

On 2024/8/23 15:00, Hongbo Li wrote:
> The macro sk_for_each_bound_bhash accepts a parameter
> __sk, but it was not used, rather the sk2 is directly
> used, so we replace the sk2 with __sk in macro.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   net/ipv4/inet_connection_sock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 64d07b842e73..ce4d77f49243 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -236,7 +236,7 @@ static bool inet_bhash2_conflict(const struct sock *sk,
>   
>   #define sk_for_each_bound_bhash(__sk, __tb2, __tb)			\
>   	hlist_for_each_entry(__tb2, &(__tb)->bhash2, bhash_node)	\
> -		sk_for_each_bound(sk2, &(__tb2)->owners)
> +		sk_for_each_bound((__sk), &(__tb2)->owners)
>   
>   /* This should be called only when the tb and tb2 hashbuckets' locks are held */
>   static int inet_csk_bind_conflict(const struct sock *sk,

