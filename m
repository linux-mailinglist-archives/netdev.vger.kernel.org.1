Return-Path: <netdev+bounces-222169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B689B535B2
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B840B3B4B5B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF65633CEAA;
	Thu, 11 Sep 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oaC8OiDI"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49633A004;
	Thu, 11 Sep 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601332; cv=none; b=RtCK1pOA43Gr+yYF6ANjisymhIaidFeoqoGVn86K1LUszspuhcuCN+CRCglR6gkK2dwSwyJrcBD5MNIESthS2ukLGf6L1013WixzLeLOp1LjWOMdf04s4uSZfAa70SS7o/1rVvM9Z9evU7ZJB/YcApCLuqFvLrm9+HBM11Afslk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601332; c=relaxed/simple;
	bh=c7JCd04MwdS7CUE2Fo15MvufZX7mN9AXA6y5tx0jPAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qpr+9hhy7rwkLZnbBGATS0/cuLk5VPTXAOwKGFL1vqzsJ3dQHoduD2O1dYtNiJdSAPPP70a0zuWp6lDCmETwosv32pJ4L7oiQ+G9g0qymcpA7WCGKJ5T/OecxPSazQmKiMyrasf+qYfJipcM1YX8urBefygpAYKyQyJv/uLAX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oaC8OiDI; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0dc424bf-c19b-4eeb-82db-88bff4f85d46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757601328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37t0QPtyu/XvIalXZWt6PWI4bvROoJUZ3WeQvV5JNsU=;
	b=oaC8OiDIhGEaAAekyBYHmzL+501l+czft7xmdUJGAyUMLfPFEsD/2qKIsZwmQR2JWpta6v
	5WYqyYOZD8HjDasYlBQkI3L3l3iVDmF4rWUPqBeUaiG+TwnPF+TNxjruTdEI1TlxXKGa5Z
	VDt6kjHfL6UPggzWsyCfCkcAfMrzwB4=
Date: Thu, 11 Sep 2025 10:35:22 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] net: xilinx: axienet: Add inline comment for
 stats_lock mutex definition
To: Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com, radhey.shyam.pandey@amd.com,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, harini.katakam@amd.com
References: <20250911072815.3119843-1-suraj.gupta2@amd.com>
 <20250911072815.3119843-3-suraj.gupta2@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250911072815.3119843-3-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/11/25 03:28, Suraj Gupta wrote:
> Add inline comment to document the purpose of the stats_lock mutex in
> the axienet_local structure. This mutex protects the hw_stats_seqcount
> sequence counter used for hardware statistics synchronization.
> 
> Fixes checkpatch warning:
> CHECK: struct mutex definition without comment
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 5ff742103beb..99b9c27bbd60 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -598,7 +598,7 @@ struct axienet_local {
>  
>  	u64 hw_stat_base[STAT_COUNT];
>  	u32 hw_last_counter[STAT_COUNT];
> -	seqcount_mutex_t hw_stats_seqcount;
> +	seqcount_mutex_t hw_stats_seqcount; /* Lock for hardware statistics */
>  	struct mutex stats_lock;
>  	struct delayed_work stats_work;
>  	bool reset_in_progress;

NAK. This is already documented in the kernel-doc comment.

