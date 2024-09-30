Return-Path: <netdev+bounces-130296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0D989FC0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE01A283C61
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1FC18CC1E;
	Mon, 30 Sep 2024 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FUggaXbt"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5783A18BB8E
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693312; cv=none; b=EyTsCF9iVcdrvFfgMsGFqAS4bPz0o+tMw77tFuAR5Bb0Z12Hly+MciKdI6UJLyJ4bPnjMQhIIZ34BAWLKq+xVgPsN8zrN6phZ3JtHJwklATU0mCN2FkPv4sYCFD5wXvICrkjnu7WBbU7YoGwYn6bdi272LcB0qqmmy5M0oeTcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693312; c=relaxed/simple;
	bh=pTTsDdJpawm7RUI6Os1ekom1s4CMeJGlLCrPhMweBec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeUq9qonza+DHtdPVzNJlqlcOUBrXmct/6qVZWRCAb5JQ21Kow3d4aZ4RKeJkd+godyaHPnbmUwdgUObGer3gOekzGoiopAQ5UCYyuRWI9jCV0C0HATz9nLQYDrWBoZgmwZUPkk0qvzOub7uXaPfpCsg0NLyTI8K9lNAjJyWx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FUggaXbt; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <79998b2c-0ca7-4180-9d7c-1d6af96dd4cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727693308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uI3q9iZONyR3+TXhKk4RxBiCA8aB7WahldqlcK77CDU=;
	b=FUggaXbtP8c8W/TKD2wvj5E6ejxOCJmYa3rwmlcptblG8CCoQfLuhvU+ioQPg/HXq/fuDn
	CXQpnFmbgtUZU05WT0ROVuF2rA2xCfYvYI2TpcHuawuzYoOEw/Xqt+v7Ai2SxbMHs7X4VF
	H9E/VHY0I8gkdVYTqnPEQfnb22joc94=
Date: Mon, 30 Sep 2024 11:48:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/3] net-timestamp: add strict check when setting
 tx flags
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, shuah@kernel.org, willemb@google.com
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-2-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240930092416.80830-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/09/2024 10:24, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Even though this case is unlikely to happen, we have to avoid such
> a case occurring at an earlier point: the sk_rmem_alloc could get
> increased because of inserting more and more skbs into the errqueue
> when calling __skb_complete_tx_timestamp(). This bad case would stop
> the socket transmitting soon.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   net/core/sock.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index fe87f9bd8f16..4bddd6f62e4f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -905,6 +905,10 @@ int sock_set_timestamping(struct sock *sk, int optname,
>   	if (val & ~SOF_TIMESTAMPING_MASK)
>   		return -EINVAL;
>   
> +	if (val & SOF_TIMESTAMPING_TX_RECORD_MASK &&
> +	    !(val & SOF_TIMESTAMPING_SOFTWARE))
> +		return -EINVAL;

SOF_TIMESTAMPING_TX_RECORD_MASK contains SOF_TIMESTAMPING_TX_HARDWARE.
That means that there will be no option to enable HW TX timestamping
without enabling software timestamping. I believe this is wrong
restriction.

> +
>   	if (val & SOF_TIMESTAMPING_OPT_ID_TCP &&
>   	    !(val & SOF_TIMESTAMPING_OPT_ID))
>   		return -EINVAL;


