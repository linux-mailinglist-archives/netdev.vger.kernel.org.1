Return-Path: <netdev+bounces-275463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5MzpBTOM0mlWYwcAu9opvQ
	(envelope-from <netdev+bounces-275463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 18:22:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E40C39EF9D
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 18:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D81D730062E7
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E52030DEA2;
	Sun,  5 Apr 2026 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS2o+W5v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE042236FD
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775406125; cv=none; b=SzzZD3J1l1m3Y5pFCQ2LrB6/I4gJpezMT9LPKIzfh/uEFZRALr2MCn3FOvNzlu4gGD70tnxytL0Akjd4guwIJ9nXXosZoXV2tnLncyYxcSAUAO8RbC0+m9kDgNAqm1emPn2KO3BZx/toGmNeuD5qWTDkFPZe/lzlXMv8s8WVQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775406125; c=relaxed/simple;
	bh=ylqc1Z+WnkL1YOTwQmLtca92Iqc4oYB3aGbw+qaTpTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TcvDcgcr3TUh+QpzGa0Oop3BzOHLiUrCirAnGRTMdBcDoFmr0CQIsRvINtvlEVCSnpkdNeccNjlVHD6snCUZlHG/RxEXcx3OqvByN2zZ2RbihZmGtPrby4cbHIiLWCog+FafA+BaqE+us5aPmQeRgjiJgAGoviVzb/guTMpsOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS2o+W5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876C9C116C6;
	Sun,  5 Apr 2026 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775406125;
	bh=ylqc1Z+WnkL1YOTwQmLtca92Iqc4oYB3aGbw+qaTpTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NS2o+W5vKqabx850tRI6Z5t+zSPVrGT8/IdIGiofCm06Va1nysQ1/jQ9R+FpFvPM8
	 +Qw6/lheV9wJ//bL9VFb1Yq0sytkodDNJ8e1er3eodpXqednxyi+b980PqUT8kQKQG
	 MGH1nURJ8GJHW1Fe242gDD5rbwGylqjN4+Fw3lIxVrpZNc9YFpHL0Z2QQKXzLQn8Vv
	 yuvf+xvpePuAlSZYvZnO+az3Emv/G83cJd0p6xY5UpI6lnJm4qUSOKrfqvNZEmOGWU
	 cTF7cSeRmu1yBByTHrWDG1jWkEb57v56kQKGE6WaByit6SkFu0OSHeunD/j0VxNhGM
	 wZ8T80nJkFlUw==
Message-ID: <61f982d5-c10c-49c1-8acf-5dedb9d384e0@kernel.org>
Date: Sun, 5 Apr 2026 10:22:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: l3mdev: Ignore non-L3 uppers in
 l3mdev_fib_table_rcu
Content-Language: en-US
To: Ao Zhou <n05ec@lzu.edu.cn>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Haoze Xie <royenheart@gmail.com>
References: <cover.1775062214.git.royenheart@gmail.com>
 <b3b88cddc7e79d4b43756b26ae5db965678f3ba9.1775062214.git.royenheart@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <b3b88cddc7e79d4b43756b26ae5db965678f3ba9.1775062214.git.royenheart@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275463-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,mellanox.com:email]
X-Rspamd-Queue-Id: 5E40C39EF9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/4/26 5:52 AM, Ao Zhou wrote:
> From: Haoze Xie <royenheart@gmail.com>
> 
> l3mdev_fib_table_rcu() assumes that any upper device observed for
> an IFF_L3MDEV_SLAVE device is an L3 master and dereferences
> master->l3mdev_ops unconditionally.
> 
> VRF slave setup sets IFF_L3MDEV_SLAVE before the upper link is fully
> switched, so readers can transiently observe a non-L3 upper such as a
> bridge and follow a NULL l3mdev_ops pointer. Require the current upper
> to still be an L3 master before consulting its FIB table.
> 
> Fixes: fee6d4c777a1 ("net: Add netif_is_l3_slave")

Fixes should be:

commit fdeea7be88b12742bfd50d9e19a06c0d2e702400
Author: Ido Schimmel <idosch@mellanox.com>
Date:   Thu Mar 16 09:08:15 2017 +0100

    net: vrf: Set slave's private flag before linking


> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
> ---
>  net/l3mdev/l3mdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/l3mdev/l3mdev.c b/net/l3mdev/l3mdev.c
> index 5432a5f2dfc8..b8a3030cb2c4 100644
> --- a/net/l3mdev/l3mdev.c
> +++ b/net/l3mdev/l3mdev.c
> @@ -177,7 +177,7 @@ u32 l3mdev_fib_table_rcu(const struct net_device *dev)
>  		const struct net_device *master;
> 
>  		master = netdev_master_upper_dev_get_rcu(_dev);
> -		if (master &&
> +		if (master && netif_is_l3_master(master) &&

Reviewed-by: David Ahern <dsahern@kernel.org>



