Return-Path: <netdev+bounces-219995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDE6B44201
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4881BC4F25
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5212C1595;
	Thu,  4 Sep 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie6a77vf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617EB286426;
	Thu,  4 Sep 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001783; cv=none; b=Iufa/QBcHX+SUJLi+I4bN5aMWguXK4ZmAidNJxgaBswNKW8srO2MrnE5cZNv88JrR14tEVtAHfXbBl+kACKY6O7vtiHZFAGzKuV9msvBcoj0/K2U9JPw/73S1EHpUzNQjzRKI8QBHMrHs2a7cIx+pLB1yX5V3dpCzcVD3Tap8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001783; c=relaxed/simple;
	bh=TenZFDl1fP03GOEayZNK8u5iDEN9dJ/DGI5jmc9gK8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccIRlmw+2Uxls5pzWDjWA9fLCv5u/INC6y8wBXO0+rJQIFTMbE2/2SRWXPIbAk2N29QYZbJwqXtBxvGn1773Ha/MmcrcR5cmDXIuCt+4cE5EucCHrESnpEtL3vUndJVzM19E9pS06ifMfpv0ULnBNCDA9UfRYNkbrUTwAOSU6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie6a77vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB18C4CEF1;
	Thu,  4 Sep 2025 16:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757001783;
	bh=TenZFDl1fP03GOEayZNK8u5iDEN9dJ/DGI5jmc9gK8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ie6a77vfe+eGDZBk/e9rreg2KsksttxfzJVc4u7iFWDeoypwL2xkiuQNlpg2fexPh
	 60YemD6+3d2gHI6QT2mYbBpKsLyPrK+RLSfmesgALG3KezXFDPupSdWANB6rgn+ZGh
	 8fzzcZLeGenbdsjV2NxgD2CXREYqKmmEJAGfzawX6eQw2RFxtD5xdwGaMUT6dk/BFA
	 eGBEYxaRapvSixT9zBNQOlmQA5bFPtECZli+YmnheJ5tJQQste0acj2zcJ2gCUsnLy
	 BjW8q9lwnqaiLKjdxOlBrhXhkuxd2jaRifzJULXMyQVK2La5GbVJk4CWpoeneKibsJ
	 PMWgjPxXbfvGA==
Date: Thu, 4 Sep 2025 09:03:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>
Cc: davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] ipv6: Check AF_UNSPEC in ip6_route_multipath_add()
Message-ID: <20250904090301.552ef178@kernel.org>
In-Reply-To: <20250804204233.1332529-1-maksimilijan.marosevic@proton.me>
References: <20250804204233.1332529-1-maksimilijan.marosevic@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Aug 2025 20:42:53 +0000 Maksimilijan Marosevic wrote:
> This check was removed in commit e6f497955fb6 ("ipv6: Check GATEWAY
> in rtm_to_fib6_multipath_config().") as part of rt6_qualify_for ecmp().
> The author correctly recognises that rt6_qualify_for_ecmp() returns
> false if fb_nh_gw_family is set to AF_UNSPEC, but then mistakes
> AF_UNSPEC for AF_INET6 when reasoning that the check is unnecessary.
> This means certain malformed entries don't get caught in
> ip6_route_multipath_add().
> 
> This patch reintroduces the AF_UNSPEC check while respecting changes
> of the initial patch.

Hi Maksimilijan!

Are you planning to repost this with a test?
If not I suppose we can enlist the author of the commit to help with
the selftest..

