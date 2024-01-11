Return-Path: <netdev+bounces-63133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4BD82B535
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2717B2181E
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A2C55C0E;
	Thu, 11 Jan 2024 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lumyx8O6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829E537F1
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A21C433C7;
	Thu, 11 Jan 2024 19:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705001346;
	bh=L3phcoB8PcuJwTt74QFRriQQzAaICY6FDBRQ9xXTIV8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Lumyx8O6XsZpxwwNdQ1wFrOsEOJp2SkgMkTV2nBN3H6wg6aZaq+wO/1MjyqYVHYbs
	 SSomohbsqf8FdTvscQst2/u3WGsi4RmJF3zZmvnGLUVEYxovwtNHts40Z1GhEyUeV2
	 owXnZj6a39GZCE+S9V7SJDouCuMUJSG4GM26iwGMaIuAH3xT1CCGR07FTAOsysfxsM
	 QN3u3duTZkmGufPWhj2RjflEtiFzMizDz9cvQZI0FPdHN8+L7k+dFy63E7zS2kv0e+
	 73p2RZveZ+PV4F+rReZE6MWT65MkiyPfbu9wfMLyHE73Un4zktFsharIl5BYnfOQrb
	 L7/JKIU8HfDBQ==
Message-ID: <0ada2b0d-59b3-40b3-98bc-4c5ef621270a@kernel.org>
Date: Thu, 11 Jan 2024 12:29:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] man: drop references to ifconfig
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20240111174734.46091-1-stephen@networkplumber.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240111174734.46091-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 10:47 AM, Stephen Hemminger wrote:
> The documentation does not need to have any references to the
> legacy command ifconfig.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  man/man8/tc-bfifo.8      | 2 --
>  man/man8/tc-pfifo_fast.8 | 2 --
>  2 files changed, 4 deletions(-)
> 

fo.8
> index 3e290322f603..bc05ef4d8bb6 100644
> --- a/man/man8/tc-bfifo.8
> +++ b/man/man8/tc-bfifo.8
> @@ -37,8 +37,6 @@ If the list is too long, no further packets are allowed on. This is called 'tail
>  limit
>  Maximum queue size. Specified in bytes for bfifo, in packets for pfifo. For pfifo, defaults
>  to the interface txqueuelen, as specified with
> -.BR ifconfig (8)
> -or
>  .BR ip (8).
>  The range for this parameter is [0, UINT32_MAX].
>  
> diff --git a/man/man8/tc-pfifo_fast.8 b/man/man8/tc-pfifo_fast.8
> index baf34b1df089..09bceb78bab3 100644
> --- a/man/man8/tc-pfifo_fast.8
> +++ b/man/man8/tc-pfifo_fast.8
> @@ -27,8 +27,6 @@ have traffic, higher bands are never dequeued. This can be used to
>  prioritize interactive traffic or penalize 'lowest cost' traffic.
>  
>  Each band can be txqueuelen packets long, as configured with
> -.BR ifconfig (8)
> -or
>  .BR ip (8).
>  Additional packets coming in are not enqueued but are instead dropped.
>  

There is another reference in the man page as well.

