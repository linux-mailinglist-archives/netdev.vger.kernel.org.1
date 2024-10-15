Return-Path: <netdev+bounces-135893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B3599FA18
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 23:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A4D1C239FD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB37201007;
	Tue, 15 Oct 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zz03j93X"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EEF2003A5
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027987; cv=none; b=FswvabtnKKyQX/qll6/6La4rOviU6Qs1Q2/UQ+OjOdC0JhFm6xISvTTMn5MuzL4OToBZintsug3V28YwzP+0P5xPnVk8SMIfQ1XCkHb7Snt6vWMiihYN2XKogiQO6ngQ3xE+7dMMj8OFWkaxgij4ABcZq2XdNuImVcrBD4Pr4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027987; c=relaxed/simple;
	bh=D1xkNIugMy9A+dWe9zR2/JgNAUd2uFqxaC1ZCtFt8Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptkbEJ/6ZXVDxWIYhXFl/XAobQXThxN56yNq2i4INt5Q+2HAQWFgE3jg6AKQmdLckm2op2MZHKiG4bxBpKVf6DJbfgZpTm3IX6V4F/KJue/+o7wlGrvzv59t6we8cKl0F0DB7AWBjto5883EqP4mE7sic0Zmz6vGbr5JDmccH4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zz03j93X; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cb96b56a-0c00-4f57-b4b5-8a7e00065cdc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729027983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHHsPT/dmwMnFNlCEp8lZGleNTv4acen2Vdv9lmwsHA=;
	b=Zz03j93Xy43gsKw2Um30eJYrBn9mkJpdEXvFCNEnaEUsUp5mm/OdXtRrqGrG77XK2kZjqY
	sRRj22CHMYO9XaXZGHACWZkiglA6gGnu3Jg7ccokSlOp4J8ywP1bhIT6C749hu+UwWxbs9
	WPq6QFK+Ppumy29C1VwU+uu/RwHNs4s=
Date: Tue, 15 Oct 2024 14:32:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 02/12] net-timestamp: open gate for
 bpf_setsockopt
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-3-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241012040651.95616-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/11/24 9:06 PM, Jason Xing wrote:
>   static int sol_socket_sockopt(struct sock *sk, int optname,
>   			      char *optval, int *optlen,
>   			      bool getopt)
>   {
> +	struct so_timestamping ts;
> +	int ret = 0;
> +
>   	switch (optname) {
>   	case SO_REUSEADDR:
>   	case SO_SNDBUF:
> @@ -5225,6 +5245,13 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
>   		break;
>   	case SO_BINDTODEVICE:
>   		break;
> +	case SO_TIMESTAMPING_NEW:
> +	case SO_TIMESTAMPING_OLD:

How about remove the "_OLD" support ?


