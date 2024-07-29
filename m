Return-Path: <netdev+bounces-113826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 718DF9400B0
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD0BB20CF4
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E08F18E74C;
	Mon, 29 Jul 2024 21:58:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB612FB37
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290293; cv=none; b=MvojcQ5hKajnTdeR0fDwMy8we8jKoTT2/9D7nqkbi0a+ETJx84WDtyoMeIef6jy2JTMJ2EuFl0URsEPhb3gW4MnkwauHz86Kl5xDquX9KRs8hX0uZm3J+vQpfHArTBpqPfeyo+Sr/piIBNHlCF12wNPgNqyGuClK03qT4OP4vSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290293; c=relaxed/simple;
	bh=3c4FsYKMN0Xyqx5JYtxPy9gBbU1UZAVbEdZF2wnH7/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOW+a7206JvNzH7dz73yCPIleekZFohuPNnHhZKuu+mEnDhqObIXxJSI14TyFxCtyEUsdx5eiHZ2Cq0PEmMhjV6nhzoVtUMFBkyH3FWOoA8r4F1yrA5XSEcGz2BwteY2R9bgPT6sLyywQeyM7dORFgaghY9+t8/Kawq1h6tdmDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cdadce1a57so2392142a91.2
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 14:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290291; x=1722895091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwRZ8z7gkSXpUPrBBibHWTINGU1+zgF+gKsbTKwQoHc=;
        b=MJIAHEtckro2KhCKzpAAIMK/vZKmCpTeZxncSaek+9hU80mIZ59ytnG84Y3q9ZkV3V
         mfQvFA5dzauJb7f8qGtnyhwoOs2f64TH9c652sblH9DaR1yDo9HjSt2riBXKl5o/ADxz
         4k7wcZD6IzwRII+ipR+81B6fUx2RRCHEoV+U1H5MBOqdDVI5LVN1zcVsoEUAtuL9ywXi
         T4TgRaE9bmQOVZIa7fVdEvyC5Fd2LoeQa7sehiS9Yd3h9jb/flP4k4zF3444/1WWBYRj
         441HrhyW2S2fQkxXmWWDgFfx7CGPa8Nu4AKheFh80cP0fieXUxVylIO8xRyJqweud4an
         xhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM2KPsU3lQMzQAYmZ/iDuEikQqsdScjDccxG8tUdkUeYCXQmqlI+D5MPfoY3c66454XHq3GhZya7BD2kpRyJXvMlJEBawt
X-Gm-Message-State: AOJu0Yx/wGpoUbR6z6/gMPA+xa7reJxkU3EXnhkX4t8aKsfy4AeZGF9N
	2JoeVgtKjmsyat6zEZ+m0aZ09gKMlbnIEalKCLUbbXe0O8qyAcM=
X-Google-Smtp-Source: AGHT+IGCTRVKp/pjF6toiWdQY0RigpIjn7+ozWxkjxuua9rUKBM4k06Qg5RcrWCvdaXsrPLzfiUUJQ==
X-Received: by 2002:a17:90b:314a:b0:2c8:53be:fa21 with SMTP id 98e67ed59e1d1-2cf7e606d1amr7063018a91.34.1722290290727;
        Mon, 29 Jul 2024 14:58:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28e43df5sm9075647a91.55.2024.07.29.14.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:58:10 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:58:09 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next] selftests: net: ksft: print more of the stack
 for checks
Message-ID: <ZqgQcXq0SlgkjU9C@mini-arch>
References: <20240729204536.3637577-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240729204536.3637577-1-kuba@kernel.org>

On 07/29, Jakub Kicinski wrote:
> Print more stack frames and the failing line when check fails.
> This helps when tests use helpers to do the checks.
> 
> Before:
> 
>   # At ./ksft/drivers/net/hw/rss_ctx.py line 92:
>   # Check failed 1037698 >= 396893.0 traffic on other queues:[344612, 462380, 233020, 449174, 342298]
>   not ok 8 rss_ctx.test_rss_context_queue_reconfigure
> 
> After:
> 
>   # Check| At ./ksft/drivers/net/hw/rss_ctx.py, line 387, in test_rss_context_queue_reconfigure:
>   # Check|     test_rss_queue_reconfigure(cfg, main_ctx=False)
>   # Check| At ./ksft/drivers/net/hw/rss_ctx.py, line 230, in test_rss_queue_reconfigure:
>   # Check|     _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
>   # Check| At ./ksft/drivers/net/hw/rss_ctx.py, line 92, in _send_traffic_check:
>   # Check|     ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
>   # Check failed 1045235 >= 405823.5 traffic on other queues (context 1)':[460068, 351995, 565970, 351579, 127270]
>   not ok 8 rss_ctx.test_rss_context_queue_reconfigure
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

> ---
> CC: shuah@kernel.org
> CC: petrm@nvidia.com
> ---
>  tools/testing/selftests/net/lib/py/ksft.py | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index f26c20df9db4..c2356e07c34c 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -32,8 +32,16 @@ KSFT_RESULT_ALL = True
>      global KSFT_RESULT
>      KSFT_RESULT = False
>  
> -    frame = inspect.stack()[2]
> -    ksft_pr("At " + frame.filename + " line " + str(frame.lineno) + ":")
> +    stack = inspect.stack()
> +    started = False

[..]

> +    for i in reversed(range(2, len(stack))):
> +        frame = stack[i]

optional more python-y way might be:

for frame in reversed(stack[2:]):
	xxx

