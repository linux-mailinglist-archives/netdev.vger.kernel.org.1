Return-Path: <netdev+bounces-160884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F043A1BFFD
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 01:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83833ABBD7
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 00:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A84A3C;
	Sat, 25 Jan 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tIOqiZoD"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122F4C9D
	for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737766231; cv=none; b=tDimx48g+CrC7fCJ49gCsA/pkfp/ddUiT62wJ7OAsPG3/dCMSOk3oc5uCRMWIa9IsiEcwowyVnESudjhOigbo+zWUizOUb/pFH50IEUVhS7CP1iG6AiMqwJ9OtbkklCCON7bt9Y4HJfvcT9AxeZCqDswzvE1XzDMBvE1OeNHpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737766231; c=relaxed/simple;
	bh=W+/Qkxvsd12qGED3PV9EzhIhxy6YwqeUfZNXFKj97EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHz1POr5xWTww3Fk2t2CIGXBUBf1o2LPSY97yQ/pr9sj59/DYHEALIh4j2kEwbFnwHRGs56ZLGi8q8UnBE6UtLP1qo7RPx4V2pyfF/FpoCl1tR0Z1pFxpihtltmEiOLGS908Fk0yBwoh7lr0aEqNhksebHXUM1v24E4eJ+6SHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tIOqiZoD; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <db1c1edc-f02f-4755-9b6d-b1c1e9b90564@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737766218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NV3UHs4dTXjAxDpWIcFruzRrKCKLaiux4KC7HnciucM=;
	b=tIOqiZoD5inMEGdXt53ropaggj9x63rISa4uq6VF85TRfHPs7Igoxrmkk37NyDLYPBBPrH
	XZYbYgVqg5w+NG9Fu0at4XONoxkNzXvc2gNbeKUjNs2Z+28acISBawBtWd07ioJxargsXp
	8SpeS9Acs5mmFw7crshBa6rarid13dA=
Date: Fri, 24 Jan 2025 16:50:09 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 11/13] net-timestamp: add a new callback
 in tcp_tx_timestamp()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-12-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250121012901.87763-12-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/20/25 5:28 PM, Jason Xing wrote:
> Introduce the callback to correlate tcp_sendmsg timestamp with other
> three points (SND/SW/ACK). We can let bpf trace the beginning of
> tcp_sendmsg_locked() and fetch the socket addr, so that in
> tcp_tx_timestamp() we can correlate the tskey with the socket addr.
> It is accurate since they are under the protect of socket lock.
> More details can be found in the selftest.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/uapi/linux/bpf.h       | 3 +++
>   net/ipv4/tcp.c                 | 1 +
>   tools/include/uapi/linux/bpf.h | 3 +++
>   3 files changed, 7 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3b9bfc88345c..55c74fa18163 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7042,6 +7042,9 @@ enum {
>   					 * feature is on. It indicates the
>   					 * recorded timestamp.
>   					 */
> +	BPF_SOCK_OPS_TS_TCP_SND_CB,	/* Called when every tcp_sendmsg
> +					 * syscall is triggered
> +					 */

I recall we agreed in v5 to adjust the "TCP_" naming part because it will be 
used in UDP also. Like completely remove the "TCP_" from the name?

>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0a41006b10d1..49e489c346ea 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -500,6 +500,7 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>   		tcb->txstamp_ack_bpf = 1;
>   		shinfo->tx_flags |= SKBTX_BPF;
>   		shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> +		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_TCP_SND_CB);
>   	}
>   }
>   
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index b463aa9c27da..38fc04a7ac20 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7035,6 +7035,9 @@ enum {
>   					 * feature is on. It indicates the
>   					 * recorded timestamp.
>   					 */
> +	BPF_SOCK_OPS_TS_TCP_SND_CB,	/* Called when every tcp_sendmsg
> +					 * syscall is triggered
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect


