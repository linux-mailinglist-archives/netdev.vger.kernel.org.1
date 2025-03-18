Return-Path: <netdev+bounces-175597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0301AA6694A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 06:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B0917131D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 05:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E9A1C700A;
	Tue, 18 Mar 2025 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="g8hzK3zY"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB23191F72
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742275788; cv=none; b=c3AXPy+vzU4pn0ALvd9Um5/RDCqowFuaGgYgZkgBg/OggwNZU7i3IrDHExVweDKGvwembo5qXPFegwc3x6HUGNLnUB72dfuynVV+05/ew6452yIL4gCl0dOpnKrlUO9j/bpTVTBdIeITQqu//FKk8fCFE6ZKIilpg0Jt3WgOMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742275788; c=relaxed/simple;
	bh=fOt9AsM/WePUYDu8lKnr1Kils8pGcgwokvxrq6ROSVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohe3mRcr6UJzcNFFSV3DlSMItFUyaDTRHBoRCog6mLA1gpjbBQHfKEd6wX454n6C+yfwdsYl5m9InsYBtMfIosRqh6Bm8rtnArfJ5pW25XvIBEza9nsYIAnH92VtvjpXw6WHckUKJTuB9Fb0Uz2Zozw9kwuCPu8SzHCWcQ1pbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=g8hzK3zY; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [10.56.8.249] (nat64-68.meeting.ietf.org [31.130.238.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 502B4200E2A5;
	Tue, 18 Mar 2025 06:29:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 502B4200E2A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1742275774;
	bh=PlKN0Oru+Ri+M+3INL/xJ3sZArAnuMPdbx+sv6kO1gg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g8hzK3zYuBDPitPoouX1rlNImKWbdTq9HtFO5IErIHDXE84bnWk91t+zlAyhCxNX3
	 wh71t6gdPMzKM0seeg9Iwq9ROaCewIfnmcYmEHMevszT+Q3huSqWYjF5+U4HEc12om
	 1wXQ+9Lvka1Gq8iPqAvFaD2s40JGTJqTU7lw/ihD/tHOFKm43U7awJSU+nnUqN33kB
	 dN0ceyBwiREAecOe9lsEWzvQr0NAj9dfgkvVZ+G6+iSrPmFoWNMCmXOHPUKx1ytyZM
	 NL+wxLN97Ky95BvSAZXe/xGz7eAjKarUzbSKL5bNiJd/g5ytFWj2rh6gpAwcb+4VbB
	 7jH/UHMU2WZ/A==
Message-ID: <c2fb553a-1bb3-46b6-91de-da7f185020a3@uliege.be>
Date: Tue, 18 Mar 2025 06:29:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: lwtunnel: fix recursion loops
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
References: <20250312103246.16206-1-justin.iurman@uliege.be>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250312103246.16206-1-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 11:32, Justin Iurman wrote:
> Different kind of loops in most of lwtunnel users were fixed by some
> recent patches. This patch acts as a parachute, catch all solution, by
> detecting any use cases with recursion and taking care of them (e.g., a
> loop between routes). This is applied to lwtunnel_input(),
> lwtunnel_output(), and lwtunnel_xmit().
> 
> Fixes: ffce41962ef6 ("lwtunnel: support dst output redirect function")
> Fixes: 2536862311d2 ("lwt: Add support to redirect dst.input")
> Fixes: 14972cbd34ff ("net: lwtunnel: Handle fragmentation")
> Closes: https://lore.kernel.org/netdev/2bc9e2079e864a9290561894d2a602d6@akamai.com/
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Andrea Mayer <andrea.mayer@uniroma2.it>
> Cc: Stefano Salsano <stefano.salsano@uniroma2.it>
> Cc: Ahmed Abdelsalam <ahabdels.dev@gmail.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>   net/core/lwtunnel.c | 65 ++++++++++++++++++++++++++++++++++++---------
>   net/core/lwtunnel.h | 42 +++++++++++++++++++++++++++++
>   2 files changed, 95 insertions(+), 12 deletions(-)
>   create mode 100644 net/core/lwtunnel.h

Just for clarity, you can ignore this patch. It is now included in a 
series [1] (see patch #1 of the series) and has been modified based on 
feedback received in this thread.

Thanks!

   [1] 
https://lore.kernel.org/all/20250314120048.12569-1-justin.iurman@uliege.be/

