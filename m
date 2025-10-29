Return-Path: <netdev+bounces-233732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB27C17BCC
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EFDE345654
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A82D8779;
	Wed, 29 Oct 2025 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFrNnVXJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D422D8776
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699874; cv=none; b=DymOc9wA7yjDLILD4noz/8LNYhDAJ8P/t1xkzeRi5AOzacFLVMdXpx+I0XkJ9YU0d70n5Zuho6S7Ik0+Z8fEOuvVoN68nJu2tZ9EkWsUeJ/D/32Q8bmeLQWbbAjrSEBD26gVXBYsKRGGjJTRasRxq6n6Og1p6JgqBKtjrKPjYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699874; c=relaxed/simple;
	bh=J9S/qscLncVf1Xlng6xbYrG4fn8k4DU9Pt7yZ+Dsz2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3lUq9TlvwUpEW09eYLt9q4BM9qmk2QADp0tCf2FHM9G5JWEJ/9J0++UPyFqH0dS3Z30e9uqCIPwgvNpXLW0kJY6BGKXY5ZuBe8pGk8owvJwrGNoSdo+Y/iG9/iIuSirSdHi+BkaclO5KL4bYVcTQoKTj0u+TrwgVup3cPmiahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFrNnVXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649CAC4CEFD;
	Wed, 29 Oct 2025 01:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699874;
	bh=J9S/qscLncVf1Xlng6xbYrG4fn8k4DU9Pt7yZ+Dsz2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UFrNnVXJigx7HMVzxmEuE8iQxHj6zlNfMGu8wE22Kk0L42vWXRW9kHPypdDH9zsqA
	 a8bFvugVHP1+MOn9pVbimpOmGktyrz/IkMeP9H1VSjbiUFJG8noUTJw04OSQHU21Bw
	 duckwdaQeVpY1qCrnvDQmdxppj3vBIlsyIWQvjQPcuInI4F/i5DID/chZzg3hHk028
	 BYHwHrYMXJ/myBazgQSi3gCHZdN1utQbU7n9GQd+yM82I75AoxsPjtDSACPNsPIaZZ
	 BJieK2fj57KdCj8SNd990Jm/35wAcyKBguj3tbNFjwTqfxNhXVCcuV9kiQ6gszQDdD
	 SLKkYhNQxcMRw==
Date: Tue, 28 Oct 2025 18:04:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <edumazet@google.com>, <horms@kernel.org>, <dsahern@kernel.org>,
 <petrm@nvidia.com>, <willemb@google.com>, <daniel@iogearbox.net>,
 <fw@strlen.de>, <ishaangandhi@gmail.com>, <rbonica@juniper.net>,
 <tom@herbertland.com>, Justin Iurman <justin.iurman@uliege.be>
Subject: Re: [PATCH net-next v2 0/3] icmp: Add RFC 5837 support
Message-ID: <20251028180432.7f73ef56@kernel.org>
In-Reply-To: <20251027082232.232571-1-idosch@nvidia.com>
References: <20251027082232.232571-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 10:22:29 +0200 Ido Schimmel wrote:
> This patchset extends certain ICMP error messages (e.g., "Time
> Exceeded") with incoming interface information in accordance with RFC
> 5837 [1]. This is required for more meaningful traceroute results in
> unnumbered networks. Like other ICMP settings, the feature is controlled
> via a per-{netns, address family} sysctl. The interface and the
> implementation are designed to support more ICMP extensions.

Is there supposed to be any relation between the ICMP message attrs 
and what's provided via IOAM? For interface ID in IOAM we have
the ioam6_id attr instead of ifindex.

Would it make sense to add some info about relation to IOAM to the
commit msg (or even docs?). Or is it obvious to folks more familiar
with IP RFCs than I am?

cc: Justin

