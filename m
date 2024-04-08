Return-Path: <netdev+bounces-85776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5DD89C1A6
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF3B1C21622
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9221D77F11;
	Mon,  8 Apr 2024 13:18:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876EB7FBBC
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582336; cv=none; b=PA72ykjvT9LFX/NY1KxspaljofbI3ZOrIX1CboUotmJn97zphf0Ei6NAgnYqUr8pkfEQOyq4qsfRI2wsT8zzKYfVkybad3moNcv5UOIQ7ojLNlNrAMlqUyX6DaTPCVvYuXWvBHzRTxm+yo+qVSpM80I0iv0wuoEIlCe49VJhhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582336; c=relaxed/simple;
	bh=1Bo6ojBgi/lqEbbKTmThh71N5IusHEBeQN7J0pisNos=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jr/5CofZunWNVcUPW4Im2edTo7oZtD1NAQ3wy7nTysnFr3QMe2z5BbUgo0ESbGjJOC0nX6IXAKQ5x+mzt88jvYp6IwqVl9JxE7O4W4kKrKxRygRzyqzrNYVHlSU7+tzqNDPtecRnd6TbNDthIWtWhkbjZaQl7+pcjh5tzCYxc+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A9C224000A;
	Mon,  8 Apr 2024 13:18:51 +0000 (UTC)
Message-ID: <281c9e36-6a83-488e-b104-09d80aef83fc@ovn.org>
Date: Mon, 8 Apr 2024 15:19:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 cmi@nvidia.com, yotam.gi@gmail.com, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org
Subject: Re: [RFC net-next v2 3/5] net: psample: add user cookie
Content-Language: en-US
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
References: <20240408125753.470419-1-amorenoz@redhat.com>
 <20240408125753.470419-4-amorenoz@redhat.com>
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmP+Y/MFCQjFXhAACgkQuffsd8gpv5Yg
 OA//eEakvE7xTHNIMdLW5r3XnWSEY44dFDEWTLnS7FbZLLHxPNFXN0GSAA8ZsJ3fE26O5Pxe
 EEFTf7R/W6hHcSXNK4c6S8wR4CkTJC3XOFJchXCdgSc7xS040fLZwGBuO55WT2ZhQvZj1PzT
 8Fco8QKvUXr07saHUaYk2Lv2mRhEPP9zsyy7C2T9zUzG04a3SGdP55tB5Adi0r/Ea+6VJoLI
 ctN8OaF6BwXpag8s76WAyDx8uCCNBF3cnNkQrCsfKrSE2jrvrJBmvlR3/lJ0OYv6bbzfkKvo
 0W383EdxevzAO6OBaI2w+wxBK92SMKQB3R0ZI8/gqCokrAFKI7gtnyPGEKz6jtvLgS3PeOtf
 5D7PTz+76F/X6rJGTOxR3bup+w1bP/TPHEPa2s7RyJISC07XDe24n9ZUlpG5ijRvfjbCCHb6
 pOEijIj2evcIsniTKER2pL+nkYtx0bp7dZEK1trbcfglzte31ZSOsfme74u5HDxq8/rUHT01
 51k/vvUAZ1KOdkPrVEl56AYUEsFLlwF1/j9mkd7rUyY3ZV6oyqxV1NKQw4qnO83XiaiVjQus
 K96X5Ea+XoNEjV4RdxTxOXdDcXqXtDJBC6fmNPzj4QcxxyzxQUVHJv67kJOkF4E+tJza+dNs
 8SF0LHnPfHaSPBFrc7yQI9vpk1XBxQWhw6oJgy3OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Y/5kJAUJCMVeQQAKCRC59+x3yCm/lpF7D/9Lolx00uxqXz2vt/u9flvQvLsOWa+UBmWPGX9u
 oWhQ26GjtbVvIf6SECcnNWlu/y+MHhmYkz+h2VLhWYVGJ0q03XkktFCNwUvHp3bTXG3IcPIC
 eDJUVMMIHXFp7TcuRJhrGqnlzqKverlY6+2CqtCpGMEmPVahMDGunwqFfG65QubZySCHVYvX
 T9SNga0Ay/L71+eVwcuGChGyxEWhVkpMVK5cSWVzZe7C+gb6N1aTNrhu2dhpgcwe1Xsg4dYv
 dYzTNu19FRpfc+nVRdVnOto8won1SHGgYSVJA+QPv1x8lMYqKESOHAFE/DJJKU8MRkCeSfqs
 izFVqTxTk3VXOCMUR4t2cbZ9E7Qb/ZZigmmSgilSrOPgDO5TtT811SzheAN0PvgT+L1Gsztc
 Q3BvfofFv3OLF778JyVfpXRHsn9rFqxG/QYWMqJWi+vdPJ5RhDl1QUEFyH7ok/ZY60/85FW3
 o9OQwoMf2+pKNG3J+EMuU4g4ZHGzxI0isyww7PpEHx6sxFEvMhsOp7qnjPsQUcnGIIiqKlTj
 H7i86580VndsKrRK99zJrm4s9Tg/7OFP1SpVvNvSM4TRXSzVF25WVfLgeloN1yHC5Wsqk33X
 XNtNovqA0TLFjhfyyetBsIOgpGakgBNieC9GnY7tC3AG+BqG5jnVuGqSTO+iM/d+lsoa+w==
In-Reply-To: <20240408125753.470419-4-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org

[copying my previous reply since this version actually has netdev@ in Cc]

On 4/8/24 14:57, Adrian Moreno wrote:
> Add a user cookie to the sample metadata so that sample emitters can
> provide more contextual information to samples.
> 
> If present, send the user cookie in a new attribute:
> PSAMPLE_ATTR_USER_COOKIE.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  include/net/psample.h        |  2 ++
>  include/uapi/linux/psample.h |  1 +
>  net/psample/psample.c        | 12 +++++++++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/psample.h b/include/net/psample.h
> index 0509d2d6be67..2503ab3c92a5 100644
> --- a/include/net/psample.h
> +++ b/include/net/psample.h
> @@ -25,6 +25,8 @@ struct psample_metadata {
>  	   out_tc_occ_valid:1,
>  	   latency_valid:1,
>  	   unused:5;
> +	u8 *user_cookie;

The code doesn't take ownership of this data.  It should probably
be a const pointer in this case.

This should also allow us to avoid a double copy first to the
psample_metadata and then to netlink skb, as users will know that
it is a const pointer and so they can hand the data directly.

> +	u32 user_cookie_len;
>  };
>  
>  struct psample_group *psample_group_get(struct net *net, u32 group_num);
> diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
> index 5e0305b1520d..1f61fd7ef7fd 100644
> --- a/include/uapi/linux/psample.h
> +++ b/include/uapi/linux/psample.h
> @@ -19,6 +19,7 @@ enum {
>  	PSAMPLE_ATTR_LATENCY,		/* u64, nanoseconds */
>  	PSAMPLE_ATTR_TIMESTAMP,		/* u64, nanoseconds */
>  	PSAMPLE_ATTR_PROTO,		/* u16 */
> +	PSAMPLE_ATTR_USER_COOKIE,

A comment would be nice.

>  
>  	__PSAMPLE_ATTR_MAX
>  };
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index a0cef63dfdec..9fdb88e01f21 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -497,7 +497,8 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>  		   nla_total_size(sizeof(u32)) +	/* group_num */
>  		   nla_total_size(sizeof(u32)) +	/* seq */
>  		   nla_total_size_64bit(sizeof(u64)) +	/* timestamp */
> -		   nla_total_size(sizeof(u16));		/* protocol */
> +		   nla_total_size(sizeof(u16)) +	/* protocol */
> +		   nla_total_size(md->user_cookie_len);	/* user_cookie */
>  
>  #ifdef CONFIG_INET
>  	tun_info = skb_tunnel_info(skb);
> @@ -596,6 +597,15 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>  			goto error;
>  	}
>  #endif
> +	if (md->user_cookie && md->user_cookie_len) {
> +		int nla_len = nla_total_size(md->user_cookie_len);
> +		struct nlattr *nla;
> +
> +		nla = skb_put(nl_skb, nla_len);
> +		nla->nla_type = PSAMPLE_ATTR_USER_COOKIE;
> +		nla->nla_len = nla_attr_size(md->user_cookie_len);
> +		memcpy(nla_data(nla), md->user_cookie, md->user_cookie_len);
> +	}
>  
>  	genlmsg_end(nl_skb, data);
>  	psample_nl_obj_desc_init(&desc, group->group_num);


