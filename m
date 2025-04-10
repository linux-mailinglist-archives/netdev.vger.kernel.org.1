Return-Path: <netdev+bounces-181323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF54A8474C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1ECF1B62C13
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579391D7E35;
	Thu, 10 Apr 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tStl0jkV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B901D6DAA
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297455; cv=none; b=TmcfCrcFJ1IZjK4H54HlWoJ4GVD3RZKD44Pjzr6ponqkYNNdfuHDexPLRSbMnmsBtiKC2kLcJjmun711/DOQmJ+h9fq5AGUuycfN0y6STgW09W3Q94hrZe6Hx+skrWQ5wEWJ/WsoGi//1C5pPnnukzjzFyfnrKjz1QGOSk1GZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297455; c=relaxed/simple;
	bh=JkNy1eaImr7SJZ4TiY/LKYYOd+Ogb4G/HoOSLR6K4qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B34QEKkfwd8EdtNQG6A1TceNpr1fWIAUyJojd+OuZUR/6sxWe+JjrGXVyVrcZWlDrCEqKzpBkJlfvigSTR252QkEb3y2ghk+PpRFgCEC9L+pu9YS84eYZHB/Uyh9zhehw9OTOAlbBEvF6bs4IOOU4fk0GkyKG+74aahjPAQq+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tStl0jkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF64C4CEDD;
	Thu, 10 Apr 2025 15:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744297453;
	bh=JkNy1eaImr7SJZ4TiY/LKYYOd+Ogb4G/HoOSLR6K4qI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tStl0jkVlhzOnfqyplT51SMo26ljxz1l9jQeqktI5MDpXOu+GU4MS4F5JDcXMmvjw
	 y3GXHn44IskANwqkovHC9AbGrj6K++RfAdVXXkctQcsMHU6K/f3S6XZLVDK8uPR5/Q
	 JXTfHH33WY6h3TgFpZx25H/XIteCVCrBmjWEbopJFxjwGv9DOQ3LaROEsWMRy7xJac
	 E6ya78YCtq9xnH0UyUdSMnaSzJrCotkt5506zd5h9dpNlHiPch7Y3nctxx0nGe59d2
	 AezXlSs2EYYJMIEHipgigMT7vEE8xH/eJp7nSMN28glMOT0dmIC3vSB9u7U23tlKHj
	 Gqw6QzT+xwpGw==
Message-ID: <041b254d-30ed-4532-ab1a-45006a17597d@kernel.org>
Date: Thu, 10 Apr 2025 09:04:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: add exception routes to GC list in
 rt6_insert_exception
Content-Language: en-US
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kui-Feng Lee <thinker.li@gmail.com>
References: <837e7506ffb63f47faa2b05d9b85481aad28e1a4.1744134377.git.lucien.xin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <837e7506ffb63f47faa2b05d9b85481aad28e1a4.1744134377.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 11:46 AM, Xin Long wrote:
> Commit 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list
> of routes.") introduced a separated list for managing route expiration via
> the GC timer.
> 
> However, it missed adding exception routes (created by ip6_rt_update_pmtu()
> and rt6_do_redirect()) to this GC list. As a result, these exceptions were
> never considered for expiration and removal, leading to stale entries
> persisting in the routing table.
> 
> This patch fixes the issue by calling fib6_add_gc_list() in
> rt6_insert_exception(), ensuring that exception routes are properly tracked
> and garbage collected when expired.
> 
> Fixes: 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list of routes.")
> Reported-by: Jianlin Shi <jishi@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/ipv6/route.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index ab12b816ab94..99903c6a39fa 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -1771,6 +1771,7 @@ static int rt6_insert_exception(struct rt6_info *nrt,
>  	if (!err) {
>  		spin_lock_bh(&f6i->fib6_table->tb6_lock);
>  		fib6_update_sernum(net, f6i);
> +		fib6_add_gc_list(f6i);
>  		spin_unlock_bh(&f6i->fib6_table->tb6_lock);
>  		fib6_force_start_gc(net);
>  	}

Reviewed-by: David Ahern <dsahern@kernel.org>


