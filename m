Return-Path: <netdev+bounces-95626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D1D8C2DE0
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB87B2160C
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3161F367;
	Sat, 11 May 2024 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odV+x9jK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2B7366
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386483; cv=none; b=nb4ylWxhDVIuB826OOsTV/PsQ50y/tHpqYURvl+jX0XT9DY35UoBIj10p0KhV+bqLZ5AmbzcQ9QWaRSHrZGVDuoNDteImlJQe43xIEAoWSguUX4Np4lFHAjUAocz10WObLXzk1WluaIkOjlLeo0DR401inG/mxsMCIbHAw3322w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386483; c=relaxed/simple;
	bh=ISMuzUk9Df1j+AiztxJmdsdisOuoetbHh92EOHJ98C4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUibtP+OaaL16adqoz0xvtpQi6DEoyN1cFQrZWn1fy2/5RQ9IAzbXQpLCR4wG1G2OUwl+omwZV2ikfPWgRoKKQTRZnR19eKgWgQm7tqETWKK20spO2kwL4CcpUOILXn69EkjuoBBIssVjPRIZj+fYj0ByyLFxJPr+hOanTHXeRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odV+x9jK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD26C113CC;
	Sat, 11 May 2024 00:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715386482;
	bh=ISMuzUk9Df1j+AiztxJmdsdisOuoetbHh92EOHJ98C4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=odV+x9jKjywhcq1TDvlr0mMaGwaI6HLd39uhbgSgcHtsg17N43xWqdDqPl9yEpRkB
	 WzgvJddWF1hkPRYI8vUhvIQQ5khg7WHhFyHsqZZ4ucMM+KM6uW247247hX9amq1TwR
	 J97GFKwhLVkLrIGTc0jHpSGQEmupTLMajuUXe/JZMKoCfMbU4shZBirWMMiCu7aRVw
	 FYRysh88u/+xq/90ji65nhS6wQMfykZH6ej3/43s6Bqo7Um3jPnvczIoMNvX9jaESJ
	 bSlMCeTnhX4ZSc4N0mdF23t3zepLpY6a7WSz9a/nTkMaX8i80QKKZJ8m7ViyRE9A4U
	 R8dNb2JXFTtig==
Date: Fri, 10 May 2024 17:14:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Simon Horman <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Jaehee Park <jhpark1013@gmail.com>, Petr Machata <petrm@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, Davide Caratti <dcaratti@redhat.com>, Matthieu Baerts
 <matttbe@kernel.org>, netdev@vger.kernel.org
Subject: Re: [TEST] Flake report
Message-ID: <20240510171441.3a287dcd@kernel.org>
In-Reply-To: <20240510110243.08eed391@kernel.org>
References: <20240509160958.2987ef50@kernel.org>
	<20240510083551.GB16079@breakpoint.cc>
	<20240510074716.1bbb8de8@kernel.org>
	<20240510090336.54180074@kernel.org>
	<20240510164147.GE16079@breakpoint.cc>
	<20240510110243.08eed391@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 11:02:43 -0700 Jakub Kicinski wrote:
> > You need to add --enable-nftables for ebtables-nft, or you need to
> > use the old ebtables tree, i.e.:
> > https://git.netfilter.org/ebtables/
> > 
> > both should work.  
> 
> Picked the old tree. Let's see..

Looks like that worked!!

So the last fail we see for netfilter is nft-flowtable-sh with kernel
debug enabled:

https://netdev.bots.linux.dev/contest.html?executor=vmksft-nf-dbg&test=nft-flowtable-sh

