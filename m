Return-Path: <netdev+bounces-45816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 644297DFBFD
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 22:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E553FB21245
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 21:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4DA219F2;
	Thu,  2 Nov 2023 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ACcOyb09"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E121352
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 21:29:03 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA6FB
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 14:28:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so903373f8f.0
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1698960537; x=1699565337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iua5Jf4w2aPkGUT6ZYfn5135LKa6jvUzYk+QYd96iAo=;
        b=ACcOyb09kadakdfaR2Jt8myKwuUzzxFWcIQsnAlFiUk02sJtjHfiuwEptWyYksZ1NI
         TEGirq1DahyeDCQfUmHPBe55cV9vuuvTEwrZiuSHG9NmELiEhLmj/RMVDdYEMAhAmV/b
         KJOqhE80zaNIMM19nnBns37JWA+2D0qNZlPaOhrVbU2TvbBSY+ymNuzKyhsjUA0CFVMp
         /0fVAJ97hko9R76ExOefPx1lInMG1GENzrUHzKFrkicC0jIyG/0yRlx4qW4Ob242qFwz
         vlRQK46hPgkUubPpva4Mq0kIA8YpZkql1km5aZvCzr99yBAQjZ+Us6Yn8sZKYqItlyah
         Frmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698960537; x=1699565337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iua5Jf4w2aPkGUT6ZYfn5135LKa6jvUzYk+QYd96iAo=;
        b=DdhN7/O+U1ARxxxbSFGDpLYE5drDy74FrvQPXlaPjfyeQmyRb/ATrqcBBdtCYRBvxg
         obiaKy46+CV6IWCLchDeeHtI6m+9RTSB+fjGcE/a2gpHSXwF56RUsCpFOHkb9SFq0lCF
         NR865KcWg8P+uy7Aqsu1MbpGF3loHHVqSyVwIdAfTeCGZ7BDGllvCCmpoQmSOMAblI5u
         TFy0vlWNWQ2BrMpCQDGQi8UVtpXGKJQTh2KTesMOplKH9rzqxL6Ovbkv/TfHgaCg5aqZ
         d7DoKfP0X0hMKi38FVR6hZBWjg8QTvxV88d/6t2aT7NTTKPziZ8UxXx2KeRw+VD2Krjh
         wxGg==
X-Gm-Message-State: AOJu0Yzzaa1f0Kj9e9OqN/D8dp9OGqmST6C3df1e2aaqfgTLRrEQM0R8
	y8t0ce3SxSsCXcBaCftxNjOSUA==
X-Google-Smtp-Source: AGHT+IG9CsLKu1reqX2cp1KbUjSXGG+J1RREPKRuiFApJnUDD2dR/yfavmA9wJ1y/jJuCXGwxI/MYQ==
X-Received: by 2002:a5d:6d06:0:b0:32f:8b51:3708 with SMTP id e6-20020a5d6d06000000b0032f8b513708mr906683wrq.2.1698960536724;
        Thu, 02 Nov 2023 14:28:56 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0031984b370f2sm307562wrt.47.2023.11.02.14.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 14:28:56 -0700 (PDT)
Message-ID: <559ac473-b771-4936-8afc-62ae39ec540b@arista.com>
Date: Thu, 2 Nov 2023 21:28:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] tcp: Fix SYN option room calculation for TCP-AO.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Salam Noureddine <noureddine@arista.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>
References: <20231102210548.94361-1-kuniyu@amazon.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20231102210548.94361-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/23 21:05, Kuniyuki Iwashima wrote:
> When building SYN packet in tcp_syn_options(), MSS, TS, WS, and
> SACKPERM are used without checking the remaining bytes in the
> options area.
> 
> To keep that logic as is, we limit the TCP-AO MAC length in
> tcp_ao_parse_crypto().  Currently, the limit is calculated as below.
> 
>   MAX_TCP_OPTION_SPACE - TCPOLEN_TSTAMP_ALIGNED
>                        - TCPOLEN_WSCALE_ALIGNED
>                        - TCPOLEN_SACKPERM_ALIGNED
> 
> This looks confusing as (1) we pack SACKPERM into the leading
> 2-bytes of the aligned 12-bytes of TS and (2) TCPOLEN_MSS_ALIGNED
> is not used.  Fortunately, the calculated limit is not wrong as
> TCPOLEN_SACKPERM_ALIGNED and TCPOLEN_MSS_ALIGNED are the same value.
> 
> However, we should use the proper constant in the formula.
> 
>   MAX_TCP_OPTION_SPACE - TCPOLEN_MSS_ALIGNED
>                        - TCPOLEN_TSTAMP_ALIGNED
>                        - TCPOLEN_WSCALE_ALIGNED
> 
> Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Sharp eye!
Thanks for the patch and adjusting the comment.

Reviewed-by: Dmitry Safonov <dima@arista.com>

> ---
>  net/ipv4/tcp_ao.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index ef5472ed6158..7696417d0640 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -1315,7 +1315,8 @@ static int tcp_ao_parse_crypto(struct tcp_ao_add *cmd, struct tcp_ao_key *key)
>  	key->maclen = cmd->maclen ?: 12; /* 12 is the default in RFC5925 */
>  
>  	/* Check: maclen + tcp-ao header <= (MAX_TCP_OPTION_SPACE - mss
> -	 *					- tstamp - wscale - sackperm),
> +	 *					- tstamp (including sackperm)
> +	 *					- wscale),
>  	 * see tcp_syn_options(), tcp_synack_options(), commit 33ad798c924b.
>  	 *
>  	 * In order to allow D-SACK with TCP-AO, the header size should be:
> @@ -1342,9 +1343,9 @@ static int tcp_ao_parse_crypto(struct tcp_ao_add *cmd, struct tcp_ao_key *key)
>  	 * large to leave sufficient option space.
>  	 */
>  	syn_tcp_option_space = MAX_TCP_OPTION_SPACE;
> +	syn_tcp_option_space -= TCPOLEN_MSS_ALIGNED;
>  	syn_tcp_option_space -= TCPOLEN_TSTAMP_ALIGNED;
>  	syn_tcp_option_space -= TCPOLEN_WSCALE_ALIGNED;
> -	syn_tcp_option_space -= TCPOLEN_SACKPERM_ALIGNED;
>  	if (tcp_ao_len(key) > syn_tcp_option_space) {
>  		err = -EMSGSIZE;
>  		goto err_kfree;

Thanks,
             Dmitry


