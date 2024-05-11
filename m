Return-Path: <netdev+bounces-95640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC38C2E91
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0642849C4
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC921172C;
	Sat, 11 May 2024 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUG+gy2F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4C1078B
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392134; cv=none; b=p6cNDChz+q/RSf+SV94gjMz73O2h5+3KSPd231kOpdvHwWDIApdpyZ3aL0pFFSeZMu5hCzEE1iR36Hj/alr4NytGAR4TffBvKteHLh0Ek+WCEQT33B7hu+5zSFyn3cnBLckKbwllohYumr/e7nzCYyw6o+AcgtUGPvwyQAryvWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392134; c=relaxed/simple;
	bh=XmgtFidj70yv3nMrZc5YwRi607wJf2Ht6Rw7HXO9MMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnFKydhZ4DzmxVJ9vyRSjApg7L0aJM1dIkKA8/fNpRQH7BdWUZyj0I1r0am5pBKqFDDkx5CDH5SV7R1LcksMvXmOaI4qI4e0GcceLOJ9OjPG7VYlSjFGRjH+Qoujbb48BtidHK5Szsx1c/Zx8wzrWRMJMmRrZO765Ofvmv1oD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUG+gy2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2C2C113CC;
	Sat, 11 May 2024 01:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715392134;
	bh=XmgtFidj70yv3nMrZc5YwRi607wJf2Ht6Rw7HXO9MMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YUG+gy2F/8jf5R9vM1PNz31r+JsWDCUWsyVj7AFrPqLsTaWTULbbP+jGOP/zsWMvj
	 xNMzgo2EEvg+SdasNXNNAeMz4XD+aZ06Mgm+35TaTMZbJarLwSjh28cfnWShbHySKX
	 XxR94NB432eWolViy/1YFqzcfpjQ1Q9c5tdzk4j9NAm1587CcWzdO07fpdzb0wzgIH
	 zjvyplTZkLKnHYqzxxSR03SaG1m6gne7LOcPE8wl9My0w16hcslrlgZ948gqmU4Pdd
	 ZfxFfCMtNusuMuuTVovm5wC+EybK6NePdHaFmIx3O3cDCi9XFTQzoWEU+j/v5R/sPn
	 a1hAsVr7uDZ+Q==
Message-ID: <7a599e1b-3622-4474-a2c6-d292027ede88@kernel.org>
Date: Fri, 10 May 2024 19:48:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 1/3] ipv6: sr: add missing seg6_local_exit
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vasiliy Kovalev <kovalev@altlinux.org>,
 Sabrina Dubroca <sd@queasysnail.net>, Guillaume Nault <gnault@redhat.com>,
 Simon Horman <horms@kernel.org>, David Lebrun <david.lebrun@uclouvain.be>
References: <20240509131812.1662197-1-liuhangbin@gmail.com>
 <20240509131812.1662197-2-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240509131812.1662197-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/24 7:18 AM, Hangbin Liu wrote:
> Currently, we only call seg6_local_exit() in seg6_init() if
> seg6_local_init() failed. But forgot to call it in seg6_exit().
> 
> Fixes: d1df6fd8a1d2 ("ipv6: sr: define core operations for seg6local lightweight tunnel")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/ipv6/seg6.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


