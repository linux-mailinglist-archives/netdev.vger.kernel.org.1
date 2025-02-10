Return-Path: <netdev+bounces-164912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749BBA2F97E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3292188AC72
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE07A25C71A;
	Mon, 10 Feb 2025 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtLPbktc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B3E25C6E1;
	Mon, 10 Feb 2025 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217104; cv=none; b=a3ROb1T0bySczBcNrEk+xVtpQEMsQ717Z0mEx9KqClWzluQqJl3TZ8f/r8hytFKr2CEmsPx1AiSxC8MtXkzI34sEge1r6EbsTDXr4LCeOPV67b2Qr0JuOgVfAnIFBQIPCN+rtS+c8xr680sUeKxSM+mlE6ktB05g09qJRvNMao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217104; c=relaxed/simple;
	bh=/Lz9SdWmlOP5n1NM2uaK+bs9RSTIt5+jzROq4ANRSJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1tf3sIPsS6RZDeqPLV4txuWQSwUvCaCTjYMZI0d8TMqoD2UGK8gRbfKpatNaknFOMaYTOHBej8PyIEKlNvjzPY0YiYBSmUnZND8N4KVWzRvM3CWVHEvf0Pu1M8Uje7hg2k8gMv6dKCMFKAVO5j0FtX2zg4yvoxhk6ofVXMHf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtLPbktc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A19C4CED1;
	Mon, 10 Feb 2025 19:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217103;
	bh=/Lz9SdWmlOP5n1NM2uaK+bs9RSTIt5+jzROq4ANRSJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtLPbktcq1EzzRNUVqFgjo6C3PaZ0e7aZMo7uucM2Wkg0n0GFytPnBZrawt6WHnFq
	 gbxbG0cIvbifUPEc6K3D8ZgkGPjK74HMIimcFxDNhQzuXM7X6Ub0nfT+6SPBao3eQO
	 U607cySMZIw1ooz5XNzTUHxBiEmBhDWvV+NvnET4kYb8A9f6S4Dm6PMSZVlbGTUlSK
	 SWb7smxD2+4Xr6MRLr3mpSCBkutevpMf5vfSaz31DRKsskBs5E7w5FvS0tnyAIvxkX
	 5Er0wMN0uJXnAt1gjn4TVSzxbe0N9YMZ3FOSyUikuncbH3EOp2tH+AtJ77bJB/i95q
	 W9hXEd8ujLoGw==
Date: Mon, 10 Feb 2025 19:51:39 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 09/15] mptcp: pm: make three pm wrappers
 static
Message-ID: <20250210195139.GW554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-9-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-9-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:27PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Three netlink functions:
> 
> 	mptcp_pm_nl_get_addr_doit()
> 	mptcp_pm_nl_get_addr_dumpit()
> 	mptcp_pm_nl_set_flags_doit()
> 
> are generic, implemented for each PM, in-kernel PM and userspace PM. It's
> clearer to move them from pm_netlink.c to pm.c.
> 
> And the linked three path manager wrappers
> 
> 	mptcp_pm_get_addr()
> 	mptcp_pm_dump_addr()
> 	mptcp_pm_set_flags()
> 
> can be changed as static functions, no need to export them in protocol.h.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


