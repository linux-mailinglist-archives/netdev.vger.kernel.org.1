Return-Path: <netdev+bounces-137306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706389A5504
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B91282735
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0695F18B09;
	Sun, 20 Oct 2024 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sgjrc6t2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A4C1370
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729441113; cv=none; b=kpbwhDbFUmEj0vn7WUrEcyfpx+AsHxMPHfod8fZ7CtObMlXbw8alWhdtsGoc9iOkBeqZ13Yqx3j6ub9blZT9Ni+xRU+h1FW9RxVSpw5YcbaMfvCDeLVU/wqh1PVooGTAcw9N4jYrdgzIvxgvhGqn0j7Pf9TaBsKshSip8f7shGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729441113; c=relaxed/simple;
	bh=G96NFldaxUZ3YqxkigJfNNoC0NbHr20TqINXuLrzlec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtuZhRinGlBt7/+a6uadXWUM/Zoe5crZYqtZeRB8UAznJt+LNhkzn6V4IgpuerFqoC3Aj5u4n5y+grnaG7Fcxb37sz2/g1MzMqmn9J/uBunZLGlxi/9qaYESPGzxOnQUi1ifaZJOL9UepNte7NzyJvJJw8xFFcMxx81DPipMWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sgjrc6t2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E46C4CEC6;
	Sun, 20 Oct 2024 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729441113;
	bh=G96NFldaxUZ3YqxkigJfNNoC0NbHr20TqINXuLrzlec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sgjrc6t2a4/5LMNFMT7Cqvq30xTkN7XCsQK7jp6icKmGGZo+26azKaY7MQ/xk22v3
	 r2e0wM7U0J9N35ECuFqGWmuvLiQDLTuci0CHGN5Iejl6MD8kvSV/vObZezIbzK03nx
	 50fKvtM+l9PxoVWkJ+Bpr3KcuPDmX9kkTMi8dLu3hGLY54JYpMe2QvOuQdmwwgCIk5
	 pgaE1j5j1a5CEaR1pf9RcIO0FALCW58IQZhtMI4Hh0W1mRfS4yaWNKGoMXYfwznGtA
	 ye95HgAGws3rQVcspNBqkcAU5O2IoP/MbMywWzeYwIMNACWr5BLBoeEkwt3H3oTsw4
	 +5BRHmrp8T2+Q==
Message-ID: <38811a75-ae98-48e7-96c0-bb1a39a0d722@kernel.org>
Date: Sun, 20 Oct 2024 10:18:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] tcp: add a common helper to debug the
 underlying issue
Content-Language: en-US
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241020145029.27725-1-kerneljasonxing@gmail.com>
 <20241020145029.27725-2-kerneljasonxing@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241020145029.27725-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/24 8:50 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Following the commit c8770db2d544 ("tcp: check skb is non-NULL
> in tcp_rto_delta_us()"), we decided to add a helper so that it's
> easier to get verbose warning on either cases.
> 
> Link: https://lore.kernel.org/all/5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com/
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> ---
>  include/net/tcp.h | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 739a9fb83d0c..cac7bbff61ce 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2430,6 +2430,22 @@ void tcp_plb_update_state(const struct sock *sk, struct tcp_plb_state *plb,
>  void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb);
>  void tcp_plb_update_state_upon_rto(struct sock *sk, struct tcp_plb_state *plb);
>  
> +static inline void tcp_warn_once(const struct sock *sk, bool cond, const char *str)
> +{
> +	WARN_ONCE(cond,
> +		  "%s"
> +		  "out:%u sacked:%u lost:%u retrans:%u "
> +		  "tlp_high_seq:%u sk_state:%u ca_state:%u "
> +		  "advmss:%u mss_cache:%u pmtu:%u\n",

format lines should not be split across lines. Yes, I realize the
existing code is, but since you are moving it and making changes to it
this can be fixed as well.



