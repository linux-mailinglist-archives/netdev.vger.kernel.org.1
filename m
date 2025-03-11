Return-Path: <netdev+bounces-173723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EEFA5B5D5
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 02:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F2D3AF3AE
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 01:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE861E2848;
	Tue, 11 Mar 2025 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BpdnCQpA"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3237E1E2307
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656119; cv=none; b=dikxPv1i1922RBZ/AmqRFyIn40y0onTNABgNz5G00qGRh0HVsDtLgECoVbLSIco95uiLXutz+TCe0nWR474FRyD/Pud7csRt/xW/WVapum9IdMFdv3SSzZ1I8sWz3m2+CWGHaWcoE/OyGknPlqIdTIqCIDFzrl53j+X+0DVe9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656119; c=relaxed/simple;
	bh=EUGqV0G491GWJeCOTd0RFHA4weNlDWPwrkIQc4cKo3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxwTLIxExW1ycmAE22KGiNZk0SPWOBvXMQh0rCwzHbmUJFq1Ol19rAbllhLbJfuYtJW9a6WrPUMmIZuJRvTXHdTtAUNcAJJagWi+3OrliTSptJl11kKCeZ41vaSdr63/2n0az633zyYYAyp2q1ODn0WErazZ4rFsCp6nTp0mTE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BpdnCQpA; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4c5e97c4-2311-4a4f-9340-5e4a1c7d0e2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741656114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/oKuWS1FmY1E5I2+b2wmmKxZQHFp68NZ3i/2VIRw+Y=;
	b=BpdnCQpA4tk0CL7LSsulB9048RbjcgNLdQ7nuQMyJvwQMlR/I5K6+L7xnqQM4Nm3NUJT6Y
	GIyyfqNbOKvR1ubEEGI/BpGuhmxF8XOvrkt5i/h9yMx2IYOj2XlevmtfL1wQYpjwVeHEGk
	Iw1zNcKDqPPKMWevU87ttfxASgEcNMA=
Date: Mon, 10 Mar 2025 18:21:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/5] tcp: bpf: support bpf_getsockopt for
 TCP_BPF_DELACK_MAX
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 kuniyu@amazon.com, ncardwell@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250309123004.85612-1-kerneljasonxing@gmail.com>
 <20250309123004.85612-3-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250309123004.85612-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/9/25 5:30 AM, Jason Xing wrote:
> Support bpf_getsockopt if application tries to know what the delayed ack
> max time is.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   net/core/filter.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 31aef259e104..5564917e0c6d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5415,6 +5415,17 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
>   		if (*optlen < 1)
>   			return -EINVAL;
>   		break;
> +	case TCP_BPF_DELACK_MAX:
> +		if (*optlen != sizeof(int))
> +			return -EINVAL;
> +		if (getopt) {
> +			int delack_max = inet_csk(sk)->icsk_delack_max;
> +			int delack_max_us = jiffies_to_usecs(delack_max);
> +
> +			memcpy(optval, &delack_max_us, *optlen);
> +			return 0;
> +		}
> +		return bpf_sol_tcp_setsockopt(sk, optname, optval, *optlen);

There are three TCP_BPF_* specific optnames supported by bpf_getsockopt now.
Please take this chance to create a bpf_sol_tcp_getsockopt and refactor the 
existing bpf_getsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS) support into it also. The new 
bpf_sol_tcp_getsockopt can reject the TCP_BPF_IW and TCP_BPF_SNDCWND_CLAMP.


