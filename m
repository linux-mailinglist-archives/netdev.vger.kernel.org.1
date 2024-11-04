Return-Path: <netdev+bounces-141398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074AF9BAC16
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 06:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3ADA1F211B8
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 05:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08ED17FAC2;
	Mon,  4 Nov 2024 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uBn1lVBk"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F94501A;
	Mon,  4 Nov 2024 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730698557; cv=none; b=Dvr6FQ1Pw4kSGVoKlU8XdljH/E96TmrCWl+IOmYjykY6xUuzDP8ttZUMRo4gmbQjgvyx2qvfUVJ0rbSAGwb1TMRIsyCLnt2NG1iTDtWEmg2Mr/2QLDDjLe5aTQSxXZ3B7jkLLRwaWGInW0ed8e3PeYy7oCjaUoAC6/8m9ZPbHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730698557; c=relaxed/simple;
	bh=+VX/Oiw5W46/PGALbZeMkp1/TGJN/RYXjeM0o2OZ0gg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=c9AQdyLnYTHY2LyXdPFfBgIGqQfGFQwrc9amwbUtdaS5/Dj944zgOlYALiR4/Ix95jGTZS6I9mCHTDiEllmsCI83Xdl5rVXP3IHM3fwh8/93KWLIgNrkqpauXdJJCgR6u/gRN0KEga0Yb4h8CwndNL6zahtSqnkkXcPVo7AX48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uBn1lVBk; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730698546; h=Message-ID:Subject:Date:From:To;
	bh=j4U3gdu7FRXfq+K0kfikfSREVeUUEhxJFR0a5tFt+kA=;
	b=uBn1lVBkjn5LTji5uk81HiLewddxDIScdj1IGYcPCe8Q1QLzU1GgtTQWMTRd6O8c0w3N06veqcVh02gSUI/XoB7CxvC3nWJ7wonm4Ru/2HVe3Kl4PU3OQuEpWDc3pm9eE/grQZrvUS9+2nosVO8TaxZsXbPbofp9+FSeooyl3Lw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIalYbK_1730698545 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 13:35:45 +0800
Message-ID: <1730698521.639766-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RESEND net-next] net: tcp: replace the document for "lsndtime" in tcp_sock
Date: Mon, 4 Nov 2024 13:35:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: dsahern@kernel.org,
 kuba@kernel.org,
 weiwan@google.com,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Menglong Dong <dongml2@chinatelecom.cn>,
 edumazet@google.com,
 lixiaoyan@google.com
References: <20241030113108.2277758-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241030113108.2277758-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 30 Oct 2024 19:31:08 +0800, Menglong Dong <menglong8.dong@gmail.com> wrote:
> The document for "lsndtime" in struct tcp_sock is placed in the wrong
> place, so let's replace it in the proper place.
>
> Fixes: d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>  include/linux/tcp.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6a5e08b937b3..f88daaa76d83 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -200,7 +200,6 @@ struct tcp_sock {
>
>  	/* TX read-mostly hotpath cache lines */
>  	__cacheline_group_begin(tcp_sock_read_tx);
> -	/* timestamp of last sent data packet (for restart window) */
>  	u32	max_window;	/* Maximal window ever seen from peer	*/
>  	u32	rcv_ssthresh;	/* Current window clamp			*/
>  	u32	reordering;	/* Packet reordering metric.		*/
> @@ -263,7 +262,7 @@ struct tcp_sock {
>  	u32	chrono_stat[3];	/* Time in jiffies for chrono_stat stats */
>  	u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
>  	u32	pushed_seq;	/* Last pushed seq, required to talk to windows */
> -	u32	lsndtime;
> +	u32	lsndtime;	/* timestamp of last sent data packet (for restart window) */
>  	u32	mdev_us;	/* medium deviation			*/
>  	u32	rtt_seq;	/* sequence number to update rttvar	*/
>  	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
> --
> 2.39.5
>
>

