Return-Path: <netdev+bounces-140998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2249B9063
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0147D1F21B81
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD02D189B8E;
	Fri,  1 Nov 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bfByT3EY"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9A14D70F;
	Fri,  1 Nov 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461233; cv=none; b=uM0S4NVwbhCgt/sSy4dRQdQEVMeN0LxLZ2hq/ScxN3ZaBCvHvZDSVEZ/3ODRyaMZCg24OsHJf+C7B7GIYn8pJVDr4Au/ifzF6xoKBsZVC/8cxohHSZEsjNagQONQYXV0Bn5MuabLwEQVMW3YcMn71UZbn84f2U/JWdc/45Qv3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461233; c=relaxed/simple;
	bh=EGnG8YIZ3TbdeIj0SmSB76LzvhTrWTGf/9ipMBy8rcs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xb0gmTZTwwT4FlaaVJuw5zhVV++HH/OIZfShweX15EGYWYavvnRJ3I85GjxsJM4vS05tAxlEPeuHhnUW5Hjfg/oJfhHSq1i+QVZiNSuoXC04BFgaVaG1ANRP9MHYQ26Lk8z1Rs7R6/OzX4I/ejQLKVDnGbmp/KZx2hGTA9J+B0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bfByT3EY; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730461222; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=coRNU/UTIDa1xjoprsTUFhGyNTaVF8uITF01dD1IjgI=;
	b=bfByT3EYYVUYyy5GDFl73FEBLFE13h20D4WoerI+afw3KPm/pE4v7HGvuVuVh7xIc+Hyjy/2eW8wu4u/Cqv+/liMc9p4/02LZkGtTZWbzaH/kJOJB18o3Km6dAKMUCaKf5Yiy92+ZHSmRkejJNIcOwhGLf5eVb5u4B/Yq6uNWbU=
Received: from 30.221.128.127(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIRlRKc_1730461220 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Nov 2024 19:40:22 +0800
Message-ID: <33862f10-726d-49d3-8f86-ccef1f6792e7@linux.alibaba.com>
Date: Fri, 1 Nov 2024 19:40:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 4/4] ipv6/udp: Add 4-tuple hash for connected
 socket
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 horms@kernel.org, antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241031124550.20227-1-lulie@linux.alibaba.com>
 <20241031124550.20227-5-lulie@linux.alibaba.com>
In-Reply-To: <20241031124550.20227-5-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/31 20:45, Philo Lu wrote:
> Implement ipv6 udp hash4 like that in ipv4. The major difference is that
> the hash value should be calculated with udp6_ehashfn(). Besides,
> ipv4-mapped ipv6 address is handled before hash() and rehash().
> 
> Core procedures of hash/unhash/rehash are same as ipv4, and udpv4 and
> udpv6 share the same udptable, so some functions in ipv4 hash4 can also
> be shared.
> 
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
> Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
> Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
> ---
>   net/ipv6/udp.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 1ea99d704e31..64f13f258fca 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -110,8 +110,17 @@ void udp_v6_rehash(struct sock *sk)
>   	u16 new_hash = ipv6_portaddr_hash(sock_net(sk),
>   					  &sk->sk_v6_rcv_saddr,
>   					  inet_sk(sk)->inet_num);
> +	u16 new_hash4;
>   
> -	udp_lib_rehash(sk, new_hash, 0); /* 4-tuple hash not implemented */
> +	if (ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)) {
> +		new_hash4 = udp_ehashfn(sock_net(sk), sk->sk_rcv_saddr, sk->sk_num,
> +					sk->sk_daddr, sk->sk_dport);

Just found udp_ehashfn() used here results in an build error of 
undefined function.

I think the `ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)` branch can be 
moved into udp_lib_rehash() to fix the issue. So in the worst case, we 
need to calculate the newhash4 twice in ipv6 hash4 rehash, one in 
udp_v6_rehash() and the other in udp_lib_rehash().

> +	} else {
> +		new_hash4 = udp6_ehashfn(sock_net(sk), &sk->sk_v6_rcv_saddr, sk->sk_num,
> +					 &sk->sk_v6_daddr, sk->sk_dport);
> +	}
> +
> +	udp_lib_rehash(sk, new_hash, new_hash4);
>   }
>   

-- 
Philo


