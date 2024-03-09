Return-Path: <netdev+bounces-78980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE4E87733B
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 19:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F7D1F212A5
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 18:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347BB29CEF;
	Sat,  9 Mar 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI2sfifc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101F0286BD
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710008556; cv=none; b=E8WIcYNe8HY9gfqynS0GiDxrVxglXG0ez5tE7HkIL3uXL0mTkdUTMUF9P12TkvtDJeQ/4JNjF9kccLwqwcDnGY3C2HqJl+AK4kxhC6h6QuF5qx7w1yuWLMRRwafF2pvdgyrMQSCdUugLXq72glZ0oTMxRyfpjILnJ0v6/guAlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710008556; c=relaxed/simple;
	bh=UcLjrHznQDc/v++sABBhqIj8K7M1EL8zElQoxSgVHQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SunlkRMEF/I90UnwUtAnoD9xvJm4fzJ9+B+SBwxTIVtrBdKscqyE2ABgb8aOeASPs/mf0IEYXyGCiz+80vHOFeQyDGP+8Gwtvd54mTFLAp/rNYbA9f8kjfjgeqrwqAifa7TgIAagwUb8xgQhl8kykrTl5UTjxloPy93e7yc7brQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI2sfifc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E37EC433F1;
	Sat,  9 Mar 2024 18:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710008555;
	bh=UcLjrHznQDc/v++sABBhqIj8K7M1EL8zElQoxSgVHQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BI2sfifcLoKsSu8wml2S9VvHbXANSSTv0PoUtLQa9r0JNVGZS9vRObSFvGU08M9Hs
	 aaHdLHe0clDAVOnR/LRvsmgHkwSnXmPsKs1d7AAI+nPMmW6Eeym7NhOutj3GTnrdrs
	 zHcdcjwPiqC93L/ykiYcMuCY/z3nDVGKMHjgFBW0a8m1j+Bl8H+kttY3uQSAUCZ5/L
	 VrhHSeohSJQUcE+nzbJrntEkd4KKA3yX1SqvXBT5WDdItz4LwE5VXEhXYWUIBdJuKp
	 R7J4A/X9VlRNVVmqr4GAaoe+2JxpcDjEjNy3rTu6kEm5ddZg5fCgDOn1bi0bChKPpr
	 JYSp6TkdHR2Dg==
Message-ID: <cd48d41f-b9ee-4906-a806-760284a3eeb4@kernel.org>
Date: Sat, 9 Mar 2024 11:22:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ss: fix the compiler warning
Content-Language: en-US
To: Denis Kirjanov <kirjanov@gmail.com>, stephen@networkplumber.org
Cc: netdev@vger.kernel.org, Denis Kirjanov <dkirjanov@suse.de>
References: <20240307105327.2559-1-dkirjanov@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240307105327.2559-1-dkirjanov@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/24 3:53 AM, Denis Kirjanov wrote:
> the patch fixes the following compiler warning:
> 
> ss.c:1064:53: warning: format string is not a string literal [-Wformat-nonliteral]
>         len = vsnprintf(pos, buf_chunk_avail(buffer.tail), fmt, _args);
>                                                            ^~~
> 1 warning generated.
>     LINK     ss
> 
> Fixes: e3ecf0485 ("ss: pretty-print BPF socket-local storage")
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  misc/ss.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/misc/ss.c b/misc/ss.c
> index 87008d7c..038905f3 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -1042,6 +1042,7 @@ static int buf_update(int len)
>  }
>  
>  /* Append content to buffer as part of the current field */
> +__attribute__((format(printf, 1, 0)))
>  static void vout(const char *fmt, va_list args)
>  {
>  	struct column *f = current_field;

The error message does not align with the change - and it does not fix
the warning.

pw-bot: cr

