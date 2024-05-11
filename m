Return-Path: <netdev+bounces-95680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890028C2FF0
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 08:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB2C1F22CE4
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 06:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF59D27A;
	Sat, 11 May 2024 06:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CC1C2FD
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715410224; cv=none; b=fxB/YMvHVn8sVfczH7Wej9nP9NBS10iLuwbMm2MN+Xk8JGYb0lJNrrFLGKrM4AoxkYa+gZUq7hx4YbRSEwCpr+BkRzLpeI0eraKZjULRgfu2qrkyt0SD6CBxZTN5TCoT5ft1HEdJ/p+7GGQirJ96lQtWvCNOXOjxswfQ/w9s0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715410224; c=relaxed/simple;
	bh=4EeXPkw9b3PyURqE69hG6Okyj1vluYDywdgpt+bAYms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABCFNvvD04H8WYM3JsJt2QAndJS4NR8eWsq6+dC1lW1SK+amVHxqwh3djHOuq4lG3GsmtOEJxWYIiXROHiGvFpbbZMDl44ye6fnIYFKRQOKAnF4Mo+x2gNov4LLBC96/N6JVulAuOFVgQxnQIc21uHhWUwRw1TmSTptFGQ/2SFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1s5gYj-0003qH-Fk; Sat, 11 May 2024 08:50:17 +0200
Date: Sat, 11 May 2024 08:50:17 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Simon Horman <horms@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>, Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org
Subject: Re: [TEST] Flake report
Message-ID: <20240511065017.GA31232@breakpoint.cc>
References: <20240509160958.2987ef50@kernel.org>
 <20240510083551.GB16079@breakpoint.cc>
 <20240510074716.1bbb8de8@kernel.org>
 <20240510090336.54180074@kernel.org>
 <20240510164147.GE16079@breakpoint.cc>
 <20240510110243.08eed391@kernel.org>
 <20240510171441.3a287dcd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510171441.3a287dcd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Jakub Kicinski <kuba@kernel.org> wrote:
> > Picked the old tree. Let's see..
> 
> Looks like that worked!!

Great, thanks a lot!

> So the last fail we see for netfilter is nft-flowtable-sh with kernel
> debug enabled:
> 
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-nf-dbg&test=nft-flowtable-sh

I'd guess socat gets killed off before it hits EOF, I sent a patch to bump the
timeout to 1m. Lets see if thats enough to make it fly.

