Return-Path: <netdev+bounces-115004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79705944E1B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8A31C25967
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971681A3BDD;
	Thu,  1 Aug 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ZOR+U+F8"
X-Original-To: netdev@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2101A3BC7
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522790; cv=none; b=ewkhtfgkn919VzRX6C+nW0ffptQ9nZGrBa8e4LAfjOJ65JSUgTl5K09D7F5Iz77zhXgHjrbEa0iXFBjc8ensLVlN7prSedOassHs8h5/eqZHqm+MRtx3ioy3prvvPB7sC2lbdyDeY0hH/tuKYU40i0tYVb/nl2vpf3vagCRPw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522790; c=relaxed/simple;
	bh=K4vKgbesCOprKbM8PqvHz/1gjH/Rm/+LsMw268Uh4wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uz8kFzp2KNU3Xzdd7eu3Z8VjkyBEE0JSpjvNmpUXJFXyG0OSneqNonOUb//Kvd3O3hlhDaI+j0nV4b/MZEzBtq3MvLS1DMwEmzjGbdz+gHsLQnHSN/I86lC/fueJ1SWd7XJGMrYlAUa4O/LssdP0cQeXxgi21n8LxVWke/ZZLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ZOR+U+F8; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id ZSbNsQK9sjnP5ZWrcsgKqh; Thu, 01 Aug 2024 14:33:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ZWrasdNmgeieBZWrbsF0JC; Thu, 01 Aug 2024 14:33:07 +0000
X-Authority-Analysis: v=2.4 cv=BoBWwpX5 c=1 sm=1 tr=0 ts=66ab9ca3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=vaJtXVxTAAAA:8 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=1_7KGQLcpcYysvMIg0QA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=buJP51TR1BpY-zbLSsyS:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/RwJck33CeFAo9e2n03ywz6fQ8bsGaOQf8tJj7CTEqA=; b=ZOR+U+F89Edznhn5tyuYm87DrG
	R3REdGTb5bv1+upeltoBGW/peYHkc/YJmL7J7dafq2CoHhBcDIVETc/L6ZU5GnBw+YTR1cHLcndqW
	EKZghMMbJx9bIe6UD4Ns19mKS42FPHkH7Juzl5/bSALoOShsUj9y/CZ8kLxbBVoVgbGhxlUIP8TQa
	oFtioD89PU6671ow7omz0xZX62WKIQV8Tr3r9dLN9CCfty32QedUC227uasaLLTYtq1r7tmUFc6Xi
	AdrtKjr1+06Goma2twcTZcOYoWCxJ2wUYXgkOt2sSqkIwDc/iJJOecHLYK1To5T3bvjX+S3YI1N09
	9vcpUhjA==;
Received: from [201.172.173.139] (port=51584 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sZWrZ-002UZN-1v;
	Thu, 01 Aug 2024 09:33:06 -0500
Message-ID: <b6b0970d-08cd-4de0-9ae5-f3824b9071ca@embeddedor.com>
Date: Thu, 1 Aug 2024 08:32:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: core: annotate socks of struct sock_reuseport
 with __counted_by
To: Dmitry Antipov <dmantipov@yandex.ru>, Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Kees Cook <kees@kernel.org>, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240801142311.42837-1-dmantipov@yandex.ru>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240801142311.42837-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sZWrZ-002UZN-1v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:51584
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEJijX1vsxchYXUguMl8W+PWq4bMM3uxY/6WhPf4KCRu2N7CbSZuGvN8OVRBQixSZQu46nPFyGZMf55z2hMoql/Mow+injIRkpBTOYPgW8nNbjEGD4yh
 QOgv26cZ3unMc1mfMnwshgzXElpaW4c21gtgfZGviZhtIsIG30soqguaFg0nN1NR3AtkrTSwEGIIja8H8YZpnBWhGd+F02qn0bA=



On 01/08/24 08:23, Dmitry Antipov wrote:
> According to '__reuseport_alloc()', annotate flexible array member
> 'sock' of 'struct sock_reuseport' with '__counted_by()' and use
> convenient 'struct_size()' to simplify the math used in 'kzalloc()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
> v3: one more style nit (Jakub)
>      https://lore.kernel.org/netdev/20240731165029.5f4b4e60@kernel.org
> v2: style (Jakub), title and commit message (Gustavo) adjustments
>      https://lore.kernel.org/netdev/20240730170142.32a6e9aa@kernel.org
>      https://lore.kernel.org/netdev/c815078e-67f9-4235-b66c-29f8bdd1a9e0@embeddedor.com
> ---
>   include/net/sock_reuseport.h | 2 +-
>   net/core/sock_reuseport.c    | 5 ++---
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/sock_reuseport.h b/include/net/sock_reuseport.h
> index 6ec140b0a61b..6e4faf3ee76f 100644
> --- a/include/net/sock_reuseport.h
> +++ b/include/net/sock_reuseport.h
> @@ -26,7 +26,7 @@ struct sock_reuseport {
>   	unsigned int		bind_inany:1;
>   	unsigned int		has_conns:1;
>   	struct bpf_prog __rcu	*prog;		/* optional BPF sock selector */
> -	struct sock		*socks[];	/* array of sock pointers */
> +	struct sock		*socks[] __counted_by(max_socks);
>   };
>   
>   extern int reuseport_alloc(struct sock *sk, bool bind_inany);
> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index 5a165286e4d8..4211710393a8 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -173,10 +173,9 @@ static bool __reuseport_detach_closed_sock(struct sock *sk,
>   
>   static struct sock_reuseport *__reuseport_alloc(unsigned int max_socks)
>   {
> -	unsigned int size = sizeof(struct sock_reuseport) +
> -		      sizeof(struct sock *) * max_socks;
> -	struct sock_reuseport *reuse = kzalloc(size, GFP_ATOMIC);
> +	struct sock_reuseport *reuse;
>   
> +	reuse = kzalloc(struct_size(reuse, socks, max_socks), GFP_ATOMIC);
>   	if (!reuse)
>   		return NULL;
>   

