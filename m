Return-Path: <netdev+bounces-168670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D413A40217
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 22:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A553819E0B96
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB992500BC;
	Fri, 21 Feb 2025 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="nt0T5aVr"
X-Original-To: netdev@vger.kernel.org
Received: from mx05lb.world4you.com (mx05lb.world4you.com [81.19.149.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62620126A
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173897; cv=none; b=RyfpSTgPazD8NXhaYCAGugx3rgi3cIcQ2Efyo3R7HQhmrATEUPSNxCH8fvnEWr8l1M9tEOsef7rrrt4p/aDk4eM+Kw+AnAj/o4VQMa+ZiH5NhEmDCFw3l3HFJBiCVuUAVXnQ9Vs9JEhoURfLd+ugN8/Vm7msh2QtuIV1WQ+91ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173897; c=relaxed/simple;
	bh=wvqqBv509HUVFGKSrh7GrXTgsDZFkiTG/jGpuhkg8RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXq0lqvM0AAJ7qT3/1l3n0/goLSC/J/Mc7izXayFhnV3weocYI6UKPDeEBtjbl95HW/NeoRdGHehnFyJAVSfq4MKvKBHzqP1t9xwcvH0hFHCIQkacWNYcq+qtJYCAc4FJ9ngVkoFWQwHDYWzy06lIgR47bt+kJzARb/3SqSC3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=nt0T5aVr; arc=none smtp.client-ip=81.19.149.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WdGqhkPLGeXyzSF+S9zMNj28hQnPuTzhWHkYI+NlaBs=; b=nt0T5aVriYwQV3L7s/ko7Jka5b
	LkEVN+y2Mnb04D7EgH82bdVsNqQXtG/luJROC0pPW70yO6qJ/oVx7dus2Ny7eWNjllIYGHRliB6Ok
	I+/Ihz514ypExXwcOVpnX3mjzDFl5OyWX7v663/bzK79nzq4lYqJ8nw0xxCBC/CYDWrI=;
Received: from [88.117.55.1] (helo=[10.0.0.160])
	by mx05lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tlaJT-000000003KM-14pK;
	Fri, 21 Feb 2025 22:11:59 +0100
Message-ID: <daab23b7-7841-407b-8c93-b801d6182cc1@engleder-embedded.com>
Date: Fri, 21 Feb 2025 22:11:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: skb: free up one bit in tx_flags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, kerneljasonxing@gmail.com, pav@iki.fi,
 vinicius.gomes@intel.com, anthony.l.nguyen@intel.com,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org
References: <20250221035938.2891898-1-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250221035938.2891898-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 21.02.25 04:58, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The linked series wants to add skb tx completion timestamps.
> That needs a bit in skb_shared_info.tx_flags, but all are in use.
> 
> A per-skb bit is only needed for features that are configured on a
> per packet basis. Per socket features can be read from sk->sk_tsflags.
> 
> Per packet tsflags can be set in sendmsg using cmsg, but only those in
> SOF_TIMESTAMPING_TX_RECORD_MASK.
> 
> Per packet tsflags can also be set without cmsg by sandwiching a
> send inbetween two setsockopts:
> 
>      val |= SOF_TIMESTAMPING_$FEATURE;
>      setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &val, sizeof(val));
>      write(fd, buf, sz);
>      val &= ~SOF_TIMESTAMPING_$FEATURE;
>      setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &val, sizeof(val));
> 
> Changing a datapath test from skb_shinfo(skb)->tx_flags to
> skb->sk->sk_tsflags can change behavior in that case, as the tx_flags
> is written before the second setsockopt updates sk_tsflags.
> 
> Therefore, only bits can be reclaimed that cannot be set by cmsg and
> are also highly unlikely to be used to target individual packets
> otherwise.
> 
> Free up the bit currently used for SKBTX_HW_TSTAMP_USE_CYCLES. This
> selects between clock and free running counter source for HW TX
> timestamps. It is probable that all packets of the same socket will
> always use the same source.

For separate ptp4l instances with separate clocks this should be true.

> Link: https://lore.kernel.org/netdev/cover.1739988644.git.pav@iki.fi/
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>   drivers/net/ethernet/engleder/tsnep_main.c |  4 ++--
>   drivers/net/ethernet/intel/igc/igc_main.c  |  3 ++-
>   include/linux/skbuff.h                     |  5 ++---
>   net/socket.c                               | 11 +----------
>   4 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
> index 0d030cb0b21c..3de4cb06e266 100644
> --- a/drivers/net/ethernet/engleder/tsnep_main.c
> +++ b/drivers/net/ethernet/engleder/tsnep_main.c
> @@ -852,8 +852,8 @@ static bool tsnep_tx_poll(struct tsnep_tx *tx, int napi_budget)
>   			struct skb_shared_hwtstamps hwtstamps;
>   			u64 timestamp;
>   
> -			if (skb_shinfo(entry->skb)->tx_flags &
> -			    SKBTX_HW_TSTAMP_USE_CYCLES)
> +			if (entry->skb->sk &&
> +			    READ_ONCE(entry->skb->sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC)
>   				timestamp =
>   					__le64_to_cpu(entry->desc_wb->counter);
>   			else
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 84307bb7313e..0c4216a4552b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1650,7 +1650,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>   		if (igc_request_tx_tstamp(adapter, skb, &tstamp_flags)) {
>   			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
>   			tx_flags |= IGC_TX_FLAGS_TSTAMP | tstamp_flags;
> -			if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_USE_CYCLES)
> +			if (skb->sk &&
> +			    READ_ONCE(skb->sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC)
>   				tx_flags |= IGC_TX_FLAGS_TSTAMP_TIMER_1;
>   		} else {
>   			adapter->tx_hwtstamp_skipped++;
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..a65b2b08f994 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -478,8 +478,8 @@ enum {
>   	/* device driver is going to provide hardware time stamp */
>   	SKBTX_IN_PROGRESS = 1 << 2,
>   
> -	/* generate hardware time stamp based on cycles if supported */
> -	SKBTX_HW_TSTAMP_USE_CYCLES = 1 << 3,
> +	/* reserved */
> +	SKBTX_RESERVED = 1 << 3,
>   
>   	/* generate wifi status information (where possible) */
>   	SKBTX_WIFI_STATUS = 1 << 4,
> @@ -494,7 +494,6 @@ enum {
>   #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
>   				 SKBTX_SCHED_TSTAMP)
>   #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
> -				 SKBTX_HW_TSTAMP_USE_CYCLES | \
>   				 SKBTX_ANY_SW_TSTAMP)
>   
>   /* Definitions for flags in struct skb_shared_info */
> diff --git a/net/socket.c b/net/socket.c
> index 28bae5a94234..2e3e69710ea4 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -680,18 +680,9 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
>   {
>   	u8 flags = *tx_flags;
>   
> -	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
> +	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE)
>   		flags |= SKBTX_HW_TSTAMP;
>   
> -		/* PTP hardware clocks can provide a free running cycle counter
> -		 * as a time base for virtual clocks. Tell driver to use the
> -		 * free running cycle counter for timestamp if socket is bound
> -		 * to virtual clock.
> -		 */
> -		if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
> -			flags |= SKBTX_HW_TSTAMP_USE_CYCLES;
> -	}
> -
>   	if (tsflags & SOF_TIMESTAMPING_TX_SOFTWARE)
>   		flags |= SKBTX_SW_TSTAMP;
>   

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

