Return-Path: <netdev+bounces-208093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E4B09CA7
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 09:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E57218848FC
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 07:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D5B1DA10B;
	Fri, 18 Jul 2025 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8NOLv7E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926779C0;
	Fri, 18 Jul 2025 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823912; cv=none; b=Zei2br5cyC3WmuYs/leLf3T8QYj38/fYApFE7MI6b/zbJGygulLFxXIHY9M6NdsvWFh4boAUA5TUc5Bo37R1Yr0zuAfbKKHLXFkE9j4TIKuwv9Uy68dTszl7PaOoxRGZCXdrfA4ZoFzkjYnFhIptinnX6jAg2Mw+70PypmYjLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823912; c=relaxed/simple;
	bh=RMpcHzOlUiFuGazOqug/knnPjjcejahQDCwoNIIB3FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekAsPz32Rs/ql+dZ78yigBqiJD/SrgDNQR1GSXrtl3nFeOUdvvM76vT6AhIsn5KKKvjboLVwUSuYQOj52jx/kI9HTuQ0SwqiwuH5NsdmJWMiTwt5/y846VnixPlotMfJGGoLqXuYsLW3MSEtJgAKde2DcBkMVuUoFaSAMVyaAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8NOLv7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235D4C4CEED;
	Fri, 18 Jul 2025 07:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752823906;
	bh=RMpcHzOlUiFuGazOqug/knnPjjcejahQDCwoNIIB3FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8NOLv7E/J9ssXZwkjHgw5Nu4wg9DW2kRWb9Fy7WjRccK4U720RHQ4GCihoOtubEY
	 m5LCtHekMjJkgQ9/D/vBZeZVzuJFIJRHrPmI4Vph1wjVUKDMIjCY87EqeqZhXLKOTj
	 fD99dJgs4T7HuhKr/Pm5sI+ns0STDMh2/hy9IrvSwzqK7IdfuK0kmvi1P4p4VXfemk
	 xuzYveH2IPh7N9hnirbbzjR852/+BnyDYwdridTY4LO6qqxs7i77XmU/C4qOTkNhgo
	 oN3aFNm+RPcriIPcOV+zh3yoDeySxb8x1sGL1+vTVW3JieLZybkYw7EhSgOaW695wd
	 PS5zBDtLq7dzw==
Date: Fri, 18 Jul 2025 08:31:41 +0100
From: Simon Horman <horms@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, razor@blackwall.org,
	idosch@nvidia.com, petrm@nvidia.com, menglong8.dong@gmail.com,
	daniel@iogearbox.net, martin.lau@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] net: geneve: enable binding geneve
 sockets to local addresses
Message-ID: <20250718073141.GG27043@horms.kernel.org>
References: <20250717115412.11424-1-richardbgobert@gmail.com>
 <20250717115412.11424-5-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115412.11424-5-richardbgobert@gmail.com>

On Thu, Jul 17, 2025 at 01:54:12PM +0200, Richard Gobert wrote:

...

> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c

...

>  static struct geneve_sock *geneve_find_sock(struct geneve_net *gn,
>  					    sa_family_t family,
> -					    __be16 dst_port)
> +					    __be16 dst_port,
> +						union geneve_addr *saddr)
>  {
>  	struct geneve_sock *gs;
>  
>  	list_for_each_entry(gs, &gn->sock_list, list) {
> -		if (inet_sk(gs->sock->sk)->inet_sport == dst_port &&
> +		struct sock *sk = gs->sock->sk;
> +		struct inet_sock *inet = inet_sk(sk);
> +
> +		if (family == AF_INET &&
> +		    inet->inet_rcv_saddr != saddr->sin.sin_addr.s_addr)
> +			continue;
> +
> +		else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
> +				       &saddr->sin6.sin6_addr) != 0)
> +			continue;

Hi Richard,

Unfortunately this fails to build when CONFIG_IPV6 is not set.

  .../geneve.c:685:31: error: no member named 'skc_v6_rcv_saddr' in 'struct sock_common'; did you mean 'skc_rcv_saddr'?
    685 |                 else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
        |                                             ^
  ./include/net/sock.h:385:37: note: expanded from macro 'sk_v6_rcv_saddr'
    385 | #define sk_v6_rcv_saddr __sk_common.skc_v6_rcv_saddr
        |                                     ^
  ./include/net/sock.h:155:11: note: 'skc_rcv_saddr' declared here
    155 |                         __be32  skc_rcv_saddr;
        |                                 ^

> +
> +		if (inet->inet_sport == dst_port &&
>  		    geneve_get_sk_family(gs) == family) {
>  			return gs;
>  		}

...

-- 
pw-bot: changes-requested

