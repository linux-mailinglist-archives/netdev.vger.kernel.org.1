Return-Path: <netdev+bounces-128449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF349798C1
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 22:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BA32828A2
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D87A4962B;
	Sun, 15 Sep 2024 20:49:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9599F22334;
	Sun, 15 Sep 2024 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433354; cv=none; b=mA77WeWiYqCWYkllioI3N75sngcxw6/hhpq/yvjvRUtJQw6H/QqbZswSFuuJjdsRWBdcXgOnpte8yD6F0YE8dr34ZVZgP8ncYXiKoiXDV5allzLgTRU06lS4AOCDmfBSzBJZE91QRxC1xgEVRHH9DwDZcg6tccOrs61MJDOQlBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433354; c=relaxed/simple;
	bh=pRUWPlbKaBehw1VLQ2POHoovZvfEvbXmdL8rl0LpaMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoUS20Y1CRsbC3QJHO59rz4Obch7PPfeukJTdAAmjtMWX0GnuZ2OoQVeBRtCGrBf5vk8v4aDEmRa1Q+sEzngulEJIDBAgsiH80wDPgwOBP3mKSBC8EriRvV9eF9V9f4GnDUt5PGJlfgILFpkv4fI24F/3I3+LluYFE7LjWsP414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=55984 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1spwB5-00EHBb-Pi; Sun, 15 Sep 2024 22:49:05 +0200
Date: Sun, 15 Sep 2024 22:49:02 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] netfilter: nf_reject_ipv6: fix
 nf_reject_ip6_tcphdr_put()
Message-ID: <ZudIPqfHhozANZkc@calendula>
References: <20240913170615.3670897-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913170615.3670897-1-edumazet@google.com>
X-Spam-Score: -1.8 (-)

On Fri, Sep 13, 2024 at 05:06:15PM +0000, Eric Dumazet wrote:
> syzbot reported that nf_reject_ip6_tcphdr_put() was possibly sending
> garbage on the four reserved tcp bits (th->res1)
> 
> Use skb_put_zero() to clear the whole TCP header,
> as done in nf_reject_ip_tcphdr_put()

Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks.

