Return-Path: <netdev+bounces-96191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192518C49E0
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66AC282842
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EED284E08;
	Mon, 13 May 2024 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsK17zj5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C784DF4;
	Mon, 13 May 2024 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641592; cv=none; b=jBooi63ojAe5PacdiG2xMXkJXn/DeztiEJBc6SGhgOsNbOKzDw/wx1iwQ9mEJFn1AHiGvvwHkMVcnEhmYRO5hqf1UIsuSgFIkgOIMciUaomeIx9tai/TQju7ASNkgVgnY460CCKjYvo9txAGE0yPDteiOrmcpst4++BEOVYxVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641592; c=relaxed/simple;
	bh=e8N7D1BpfBQnynMsqmyyIUHaGcH8BKYPBKZbu2NtRRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrV0tT+cmCLbKJNVzk2OY5LvtPqMSHEox8NlM+Ou6aFcLzLa/lcMWPPK1XlPr5X+zRisNihrFcbJjZHcDh5hvkN841rH7HnLa0YJCInEEqcMd0kAM7iX76rukLIUgYWwd9C16agz8HeW0QiuTLZnY9lC275ugoWS7PnJ5Pi2BAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsK17zj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A042C113CC;
	Mon, 13 May 2024 23:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715641591;
	bh=e8N7D1BpfBQnynMsqmyyIUHaGcH8BKYPBKZbu2NtRRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TsK17zj55pMffE9DVaKJikVTL8MIFp/VJO2w3ud043/vmOr07OHMzDwdWxmM/YxwD
	 dgRIMAPWBX26BPYGKvPI23NCos0Q6RhvPMp2+oBG/gM/5qUGj71VOi64jmBOQoaILJ
	 yh+LsO93S124rBA0PHyhn2pGPmwNJUS2ZcoFxQvJ70VRtZEcQ7IppH0pI6WaIzqPTb
	 SIkxCmZhKqHEZABjaE5UE8lNne4Sh2lKdLA4vjjvF1yPZaTjGjUKJoa8FqpNwgxZVs
	 umjuRdO6+/6ybDFGmCDt99cVwfVs99PFp/ZOsdd/HbbSA7l6iiEdRzIRRaODu87zRl
	 2lFksnHjU9ViA==
Date: Mon, 13 May 2024 16:06:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian
 Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Detal <gregory.detal@gmail.com>
Subject: Re: [PATCH net-next 0/8] mptcp: small improvements, fix and
 clean-ups
Message-ID: <20240513160630.545c3024@kernel.org>
In-Reply-To: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 13:18:30 +0200 Matthieu Baerts (NGI0) wrote:
> This series contain mostly unrelated patches:
> 
> - The two first patches can be seen as "fixes". They are part of this
>   series for -next because it looks like the last batch of fixes for
>   v6.9 has already been sent. These fixes are not urgent, so they can
>   wait if an unlikely v6.9-rc8 is published. About the two patches:
>     - Patch 1 fixes getsockopt(SO_KEEPALIVE) support on MPTCP sockets
>     - Patch 2 makes sure the full TCP keep-alive feature is supported,
>       not just SO_KEEPALIVE.
> 
> - Patch 3 is a small optimisation when getsockopt(MPTCP_INFO) is used
>   without buffer, just to check if MPTCP is still being used: no
>   fallback to TCP.
> 
> - Patch 4 adds net.mptcp.available_schedulers sysctl knob to list packet
>   schedulers, similar to net.ipv4.tcp_available_congestion_control.
> 
> - Patch 5 and 6 fix CheckPatch warnings: "prefer strscpy over strcpy"
>   and "else is not generally useful after a break or return".
> 
> - Patch 7 and 8 remove and add header includes to avoid unused ones, and
>   add missing ones to be self-contained.

Seems to conflict with:
https://lore.kernel.org/all/20240509-upstream-net-next-20240509-mptcp-tcp_is_mptcp-v1-1-f846df999202@kernel.org/
-- 
pw-bot: cr

