Return-Path: <netdev+bounces-120825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF3F95AE60
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58511F21BD9
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC2213CAB0;
	Thu, 22 Aug 2024 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iVujkQzw"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8974613A244;
	Thu, 22 Aug 2024 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310233; cv=none; b=jp+YWH+aMfSz4Z6QaQL9OY5mdt108JlCwTKvxLN7/2NWvdc3ZxXYp8OAgdc+bDhI1D+9x++gnBwpfC6pHgQpZD1ZqlrEUCXKS8n6PaXPXMtXmHh+aBK36VJsVlzoqes+EqatDdtc+l8+dU3K6RTrqYoLsR+5OP1jpWqyH2HRpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310233; c=relaxed/simple;
	bh=VPDDM0layls9xmmc8uG/PyvPq/+sbEB17Yu9El5exD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvFSy6jl1tMRJC+KrUkCflz/WwdNGI5qGcO0DzV6DvHKkytwxQHrvQM1hbostkNHPfpU3//X7Cn1A3/6xK6CajsnHIYKsYnNmMAhlo5eQukksC1U/gybJA0Lm9VRAfRSLr4Xi45aevM46u/bFM2sfs+WsvSo0Nl6uzD6A07e2kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iVujkQzw; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id h1q1sdlp1jDE7h1q1sAMlK; Thu, 22 Aug 2024 09:02:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724310151;
	bh=2yXceyA2s1ttKyfSYyTV8Ma38g/C8rOkCLO1885tTkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iVujkQzwzTwC2rGGWdrAHwj9dIzSnFLAI8EY1GulxNqEewejVu0rUoeZyAZet9y1+
	 lQycjZJ0EWGdkH1Jx096cl/YXxJh3ZzuzUWnQ3qSGPnuQqfbR7u25K1wd88wfJ62sl
	 ftYJtTHWYv+QM2lGvQawkxWrsw9TQxY2/KgoSAcs0qoYgehQDPFP+71hQsUSDGpokM
	 QKlhRHNn8quPdz9+SCUh0KuvDZJ2KjkH2Qs2m349B/hWWZB21C73JuL+xS66qeXUz6
	 HGCdUStb8+2W8nbKWq8Mg0OgH3k2W2vcEiNJem+E5IrXwkMtx87VlSMgNHJNjCcIdL
	 qzexiO8PNZRNw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 22 Aug 2024 09:02:31 +0200
X-ME-IP: 90.11.132.44
Message-ID: <fb0ac894-9e84-4628-b4cd-88d594eba2c5@wanadoo.fr>
Date: Thu, 22 Aug 2024 09:02:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ne]t-next net: netlink: Remove the dump_cb_mutex field
 from struct netlink_sock
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org
References: <c15ce0806e0bed66342d80f36092c386c6148d00.1724309198.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <c15ce0806e0bed66342d80f36092c386c6148d00.1724309198.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/08/2024 à 08:48, Christophe JAILLET a écrit :
> Commit 5fbf57a937f4 ("net: netlink: remove the cb_mutex "injection" from
> netlink core") has removed the usage of the 'dump_cb_mutex' field from the
> struct netlink_sock.
> 
> Remove the field itself now. It saves a few bytes in the structure.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>   net/netlink/af_netlink.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
> index 9751e29d4bbb..5b0e4e62ab8b 100644
> --- a/net/netlink/af_netlink.h
> +++ b/net/netlink/af_netlink.h
> @@ -41,7 +41,6 @@ struct netlink_sock {
>   	struct netlink_callback	cb;
>   	struct mutex		nl_cb_mutex;
>   
> -	struct mutex		*dump_cb_mutex;
>   	void			(*netlink_rcv)(struct sk_buff *skb);
>   	int			(*netlink_bind)(struct net *net, int group);
>   	void			(*netlink_unbind)(struct net *net, int group);

Sorry for the broken subject, I'll resend.

CJ

