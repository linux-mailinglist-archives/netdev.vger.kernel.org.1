Return-Path: <netdev+bounces-246674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 348A5CF0317
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 18:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E20C30072A3
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7DF2116F6;
	Sat,  3 Jan 2026 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="la7LvKEW"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C503A1E67
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767459763; cv=none; b=LYX071M4HPWF+MrR5aAIWa1Jg3KdV+hpdYW8WkhkuOHh8QdnWQeouFwZjkhyAXJJ2gCWISe5M8saJ+EBy7xlqhLJrDtSgj8ZKbaX9Iah9arflYY+2LacP3RqzfgO9xY5cCsDns4X1v9FDhaILUPLC67/+iiAE9xSkBQQJF4MwAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767459763; c=relaxed/simple;
	bh=wCInvB0nFRA02bCTSYvUQ9grPKVybSLTnogISAAmX00=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u9aV/ylVdBI3IU6HxxQS23KBV5iv4ZpUEEDyAapuy0mJcYEF8d58N8pZffJMNVMtqr1teuE/a+LZK6lqO1ACTkw4Lqp+O+6wgl1ZK1kOMJTPKPL21D8KDySnfFeGvP44pVjTPscusZlGul/A2vrBL3egPBbhncRNHNnMxmTDJjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=la7LvKEW; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [100.117.229.183] (194-45-38-75.mobile.kpn.net [194.45.38.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 225FE200BE61;
	Sat,  3 Jan 2026 17:56:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 225FE200BE61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1767459374;
	bh=FrfuEYhZZr6kIb1LHk/Pki8Sp16IEVJaEp2fECVhnFk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=la7LvKEWIllsPn7BQ+wT4WOzlDrlZQo+/yeOu5oyBwp4kW9+saZNbYxafduJkuQD6
	 dUwDJivQjd4ZX9epBdrRFq2OXn0nzmaZ742MvhmuUcYgEVes+DXuuIOzeeB/e/wLUp
	 P6kHlOBWbuKQJGWjAJUaiPRZrMGRZfugFqrasJhaK18nHH4GdP20rJ9S1mQR2N5Q0Y
	 NJizMIe7hdm81rQPRczeFQBqHgSMsMab3qV4MGDCVIAxqeOsADUWyxhCuQ40Yz6s4u
	 +G8C+K76Gq5nhXoX6iPUvM8yWAcwg4cKekcaTIzhIJNdJQz7OH4hhGFnIR+E0mxQvR
	 Rem+wduUo/ADw==
Message-ID: <6b089826-3e98-4da4-9915-20cc2034abc7@uliege.be>
Date: Sat, 3 Jan 2026 17:56:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: Update email address for Justin Iurman
To: Justin Iurman <justin.iurman@gmail.com>, netdev@vger.kernel.org
References: <20260103165331.20120-1-justin.iurman@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20260103165331.20120-1-justin.iurman@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/26 17:53, Justin Iurman wrote:
> Due to a change of employer, I'll be using a permanent and personal
> email address.
> 
> Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
> ---
> Cc: Justin Iurman <justin.iurman@uliege.be>
> ---
>   .mailmap    | 1 +
>   MAINTAINERS | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 7a6110d0e46d..7354436a19c0 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -416,6 +416,7 @@ Juha Yrjola <at solidboot.com>
>   Juha Yrjola <juha.yrjola@nokia.com>
>   Juha Yrjola <juha.yrjola@solidboot.com>
>   Julien Thierry <julien.thierry.kdev@gmail.com> <julien.thierry@arm.com>
> +Justin Iurman <justin.iurman@gmail.com> <justin.iurman@uliege.be>
>   Iskren Chernev <me@iskren.info> <iskren.chernev@gmail.com>
>   Kalle Valo <kvalo@kernel.org> <kvalo@codeaurora.org>
>   Kalle Valo <kvalo@kernel.org> <quic_kvalo@quicinc.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 765ad2daa218..410fd1f199f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18283,7 +18283,7 @@ X:	net/wireless/
>   X:	tools/testing/selftests/net/can/
>   
>   NETWORKING [IOAM]
> -M:	Justin Iurman <justin.iurman@uliege.be>
> +M:	Justin Iurman <justin.iurman@gmail.com>
>   S:	Maintained
>   F:	Documentation/networking/ioam6*
>   F:	include/linux/ioam6*

Acked-by: Justin Iurman <justin.iurman@uliege.be>

