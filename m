Return-Path: <netdev+bounces-199967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BFBAE293E
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 15:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812123BB024
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8A129405;
	Sat, 21 Jun 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4VNiUgg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610411CA9
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750514081; cv=none; b=IfwwZRGJKMcLRQt3Je3gUag5S9kyhfBez7zaxKagm84wVpiRQ+HKanKMfZYU0uGWnuBIEZh9I4y5YvhkqXoM2yROfuCR6CiQjerTlc0pg8J/MbvAzr12nOXl34y8aDpMbrDcJSNXbfsX6ct39ZbsDY4UjPaWTjb0kZPjLyfXgTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750514081; c=relaxed/simple;
	bh=IhBCh3jzVkyHGguOy0m0b5o6epznS982pQ0OuAHNRBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAuhKK93A28cLc8PqxQ/W/u/nQdHtHSEr3ttBv51wOdklCCX4GWZ1+yoCd1e26PCdEqwEFvK+nc/IYpJNWfgYSPvdo3BwJ8G6BzluHVRxExfFW4godiYGwGfVaHi7XynUYPA367G85Ea315YLbd7GW5V2tP/jmj86YkA4Gae/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4VNiUgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82770C4CEE7;
	Sat, 21 Jun 2025 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750514080;
	bh=IhBCh3jzVkyHGguOy0m0b5o6epznS982pQ0OuAHNRBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m4VNiUggVcJDJ6sDi/u2ZeIHIk7vwHOb54e9N8+k1G1MiR/Z8E3VSQLiTrkEohJLb
	 zkNAKtazZ0Xc+ABqqjyffZk8lzLMcHeLKv8SqJAtqoDohnoljxPezYkM/pR7uNc7Bk
	 wheZTXlk4sSELDCwIZn6YF1QHDXb7hrIr3EivoJi2LhQX9+EbQ67WXJSh+E1f9EeFa
	 ILMNinBa0/4IgQQAKe82c/RTGdNFL2tyagFTfkion+iaSRYMqarEK2mu7hTe+oOrBg
	 vOuZ6hQzzF/YqgP2Selos3h8qWLSrMheUR6yCi6Z4B+wm8J/7tbWjtkNI3PxvlG4v4
	 pb5+jwAKufn2g==
Date: Sat, 21 Jun 2025 06:54:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ip6_tunnel: enable to change proto of fb
 tunnels
Message-ID: <20250621065439.0fd2b6f6@kernel.org>
In-Reply-To: <27a87dd2-7ffe-4b4e-8001-ca0abe412b3e@6wind.com>
References: <20250617160126.1093435-1-nicolas.dichtel@6wind.com>
	<20250619155220.3577a32a@kernel.org>
	<27a87dd2-7ffe-4b4e-8001-ca0abe412b3e@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 10:14:26 +0200 Nicolas Dichtel wrote:
> > Hm, I guess its in line with old school netlink behavior where we'd
> > just toss unsupported attributes on the floor. But I wonder whether
> > it'd be better to explicitly reject other attrs?  
> 
> I tried to find a (simple) way to be strict but, by default 'ip link' dumps all
> attributes and put them back in the message it sends.
> Ie, with the command 'ip link set ip6tnl0 type ip6tnl mode any' all IFLA_IPTUN_*
> attributes are set (to their current value) and only IFLA_IPTUN_PROTO has
> another value.

Ah damn.

> > Shouldn't be too painful with just one allowed:
> > 
> > 	if (!data[IFLA_IPTUN_PROTO])
> > 		goto ..
> > 
> > 	ip6_tnl_netlink_parms(data, &p);
> > 
> > 	data[IFLA_IPTUN_PROTO] = NULL;
> > 	if (memchr_inv(data, 0, sizeof() * ARRAY_SIZE(ip6_tnl_policy)))
> > 		goto ...  
> > > 	ip6_tnl0_update(netdev_priv(ip6n->fb_tnl_dev), &p);  
> > 
> > WDYT?  
> I already tried something similar, but it broke the 'ip link' command for the
> reason explained above.
> I was wondering if it's worth putting a lot of code to cover this case.
> Any thoughts?

Yes, commit message and/or even a one-line comment in the code?

