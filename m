Return-Path: <netdev+bounces-187675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18397AA8D26
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCE11894A9F
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F731DB92E;
	Mon,  5 May 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYegBjov"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E53B666
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430682; cv=none; b=Ou6MYpgr2T9JmvSJWAcuK37Jx82enY1Xg4B9zvf9L04upa2JihBsGpKum5JvEaSxEz/1GL8uMBR2kRZ15mA3ifO6GH63fioDxKi0fq0tiQWN3E84Mit+jQgYaKx2AVgzBfqvpXWlKPjceAVj6MDgdYGLlu2mCOHq/kMSY3aQils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430682; c=relaxed/simple;
	bh=2uDNcz0G+JX8Ma00dP8M3gndw4Mzn9q2R1pev1GhmhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNExnuqV/2n5gqract/lvSrHNPqtRFTCN7JDXNKkMu7A6mFDdIdw1qODYBUqgJManBJygC0mcUEEDU8oszvJ7wIU6fwkR1PzJEsbtBrpjRncYeM/t2GhtzPZ3Taqb9irheNVzEKVm3KROXThQRXLCu9+yH30eRYppBPYR2V3vt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYegBjov; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C918114019B;
	Mon,  5 May 2025 03:37:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 03:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746430677; x=1746517077; bh=du2vpO7hjKWM7SE+9iZhDkcRSMRhuUZyJE9
	Gsb37pGY=; b=gYegBjovA9myZLczG5JWeovDXB/iPm5+0ux5bAeDHrgkSep8vch
	ds5+DgCwfmNBUQ1Bu8WcfoFEXB0R9v+Q0kTkQEOEeBTP3W+A4LhKRwAng8GyMtXw
	CQQWgxSB5meWDz4zilyx9fRI3BqP7dvLtWb0VYGb4qO0/awThnlSQqq27N54Uox8
	KOOwJPw/iux+mLUZZeuswuq/L/TJyjvyzem41+jFESF9NqEGFK1iuhbhbctaXmr5
	0NNb6/FwiydpZbDiNAnpIbf/MH5U8vPlAKTDGofSbEWitIfFNx81Z+DJ+riyyOlF
	hdPLGhxUz92Fdyf+YC5w5zCHhap30neYA8Q==
X-ME-Sender: <xms:1WoYaOtXfs8w--0ppeVbLyxCrRdhiO0GGbSvhOS0xTj7j2f9eYG20Q>
    <xme:1WoYaDetYvpC7YUBUwVsPx48rZnuixyQvZxrFvF3JJIjS6mHOWYOhe9yzzhqZhcCF
    YTCjwfipjGbrUs>
X-ME-Received: <xmr:1WoYaJyCt5sHnRWGQSgeJNRko1fBvkOTRpnRNfa_hLRfdtPOXQcO5lFuyHU7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedthedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifedu
    ieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgnhgruhhlthesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsg
    gvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughs
    rghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnthhonhhiohesmhgrnh
    guvghlsghithdrtghomh
X-ME-Proxy: <xmx:1WoYaJMwLiF3DEOywBh_dzZTgkouiZBazqyxDX4Yycrr7xYSGerpPQ>
    <xmx:1WoYaO-EFh6XgQp_utdAOG5UFE3uxuwrlF1HsFhrOvwB7pMJXsd3zw>
    <xmx:1WoYaBXwP1oxfq3b_l4holp0sz9Zt03hQ-Bxp3VmvundE9FSGdS-LQ>
    <xmx:1WoYaHeo5dqZqhF5NpTFgIyVwut3W6LYhA-SdI8QcvE02EUYqonbfA>
    <xmx:1WoYaJfwA6FE3wUKh2XsUe1iyw8RLbhHTPr5Q0bi7iSI0kW068FmpmUC>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 03:37:56 -0400 (EDT)
Date: Mon, 5 May 2025 10:37:54 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net 1/2] gre: Fix again IPv6 link-local address
 generation.
Message-ID: <aBhq0mP-SDV1n5Kz@shredder>
References: <cover.1746225213.git.gnault@redhat.com>
 <a88cc5c4811af36007645d610c95102dccb360a6.1746225214.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a88cc5c4811af36007645d610c95102dccb360a6.1746225214.git.gnault@redhat.com>

On Sat, May 03, 2025 at 12:57:52AM +0200, Guillaume Nault wrote:
> Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
> devices in most cases and fall back to using add_v4_addrs() only in
> case the GRE configuration is incompatible with addrconf_addr_gen().
> 
> GRE used to use addrconf_addr_gen() until commit e5dd729460ca ("ip/ip6_gre:
> use the same logic as SIT interfaces when computing v6LL address")
> restricted this use to gretap and ip6gretap devices, and created
> add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.
> 
> The original problem came when commit 9af28511be10 ("addrconf: refuse
> isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
> addr parameter was 0. The commit says that this would create an invalid
> address, however, I couldn't find any RFC saying that the generated
> interface identifier would be wrong. Anyway, since gre over IPv4
> devices pass their local tunnel address to __ipv6_isatap_ifid(), that
> commit broke their IPv6 link-local address generation when the local
> address was unspecified.
> 
> Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
> interfaces when computing v6LL address") tried to fix that case by
> defining add_v4_addrs() and calling it to generate the IPv6 link-local
> address instead of using addrconf_addr_gen() (apart for gretap and
> ip6gretap devices, which would still use the regular
> addrconf_addr_gen(), since they have a MAC address).
> 
> That broke several use cases because add_v4_addrs() isn't properly
> integrated into the rest of IPv6 Neighbor Discovery code. Several of
> these shortcomings have been fixed over time, but add_v4_addrs()
> remains broken on several aspects. In particular, it doesn't send any
> Router Sollicitations, so the SLAAC process doesn't start until the
> interface receives a Router Advertisement. Also, add_v4_addrs() mostly
> ignores the address generation mode of the interface
> (/proc/sys/net/ipv6/conf/*/addr_gen_mode), thus breaking the
> IN6_ADDR_GEN_MODE_RANDOM and IN6_ADDR_GEN_MODE_STABLE_PRIVACY cases.
> 
> Fix the situation by using add_v4_addrs() only in the specific scenario
> where the normal method would fail. That is, for interfaces that have
> all of the following characteristics:
> 
>   * run over IPv4,
>   * transport IP packets directly, not Ethernet (that is, not gretap
>     interfaces),
>   * tunnel endpoint is INADDR_ANY (that is, 0),
>   * device address generation mode is EUI64.
> 
> In all other cases, revert back to the regular addrconf_addr_gen().
> 
> Also, remove the special case for ip6gre interfaces in add_v4_addrs(),
> since ip6gre devices now always use addrconf_addr_gen() instead.
> 
> Note:
>   This patch was originally applied as commit 183185a18ff9 ("gre: Fix
>   IPv6 link-local address generation."). However, it was then reverted
>   by commit fc486c2d060f ("Revert "gre: Fix IPv6 link-local address
>   generation."") because it uncovered another bug that ended up
>   breaking net/forwarding/ip6gre_custom_multipath_hash.sh. That other
>   bug has now been fixed by commit 4d0ab3a6885e ("ipv6: Start path
>   selection from the first nexthop"). Therefore we can now revive this
>   GRE patch (no changes since original commit 183185a18ff9 ("gre: Fix
>   IPv6 link-local address generation.").
> 
> Fixes: e5dd729460ca ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL address")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

