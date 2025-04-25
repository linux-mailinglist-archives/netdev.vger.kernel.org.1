Return-Path: <netdev+bounces-185807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01917A9BC7C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 03:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D56F1B87F9A
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3254B17C98;
	Fri, 25 Apr 2025 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgjk0bVl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4E38F6F
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745545723; cv=none; b=VEAvAcgwXKl/39Dwy+MqTOYbUpEZ54gCdDQJtHKRoKytROabWsUMJUIYGavBtXlpw3yn+CwzVkM4iNFEtpV9WoT8z+13nx9BSiunBT7y+dEfrKgRJMh35+26Wfb4pNsNIJdXl5L2xrf5klDjbL2nyq16P0F9mf/eVRGl3KNNUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745545723; c=relaxed/simple;
	bh=tXRP/fVRKQ1cXyDd1+y3rd/maRtIwsdaor4NGzb58jI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHuAoOVZSoSY5gSUVvEtEAS5bVe0xtvvwRpIt7Y0RgJ6Hh1tdtBJ8GH83SS23GUJGvCb5siIOjDbG8AJfsdqwlIfhwg1sDObyAz27HbbqKuPLaj284dtFp3HWckFtyNDnTzfvjvc5/FrR4J3CqUh501eNKbLA744iLJb4nVYulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgjk0bVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD08DC4CEE3;
	Fri, 25 Apr 2025 01:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745545722;
	bh=tXRP/fVRKQ1cXyDd1+y3rd/maRtIwsdaor4NGzb58jI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kgjk0bVlW9kDkT3BhZW1VdDz/Sni2EAADeuPiSvz3oha714LfOoIbMTnA4eQUsp78
	 KPrmBPiI7ZeYEK897cCgiu1Z0SbnGAtmsjjXn7Nf5XIP2QZ7v2OaZgUvzHCJ5pE93I
	 5qYsSsyq0EqfHgrFrvuUDZN9+BGIsvCCjlLukgeWZaXlPxBriAHPP8i/39glM9C22s
	 LI0JywH+geG9cO0BQRDeX4zCJJjN/cC4Q2MSzLgv0ruBU6+TWgDOw63QB8jmiy53/E
	 0sVmZBCr/I5H8nQiSd7rsBY0FZjARPkfxSEPHO5yknMqRVJjP8mDcL/7chl5dP9h8U
	 /Fx/XZ8r/5ipw==
Date: Thu, 24 Apr 2025 18:48:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Xin Tian" <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>,
 <weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>,
 <horms@kernel.org>, <parthiban.veerasooran@microchip.com>,
 <masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
 <geert+renesas@glider.be>, <geert@linux-m68k.org>
Subject: Re: [PATCH net-next v11 14/14] xsc: add ndo_get_stats64
Message-ID: <20250424184840.064657da@kernel.org>
In-Reply-To: <20250423104000.2513425-15-tianx@yunsilicon.com>
References: <20250423103923.2513425-1-tianx@yunsilicon.com>
	<20250423104000.2513425-15-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 18:40:01 +0800 Xin Tian wrote:
> @@ -242,11 +243,13 @@ static uint32_t xsc_eth_xmit_frame(struct sk_buff *skb,
>  		mss       = skb_shinfo(skb)->gso_size;
>  		ihs       = xsc_tx_get_gso_ihs(sq, skb);
>  		num_bytes = skb->len;
> +		stats->packets += skb_shinfo(skb)->gso_segs;
>  	} else {
>  		opcode    = XSC_OPCODE_RAW;
>  		mss       = 0;
>  		ihs       = 0;
>  		num_bytes = skb->len;
> +		stats->packets++;
>  	}
>  
>  	/*linear data in skb*/
> @@ -284,10 +287,12 @@ static uint32_t xsc_eth_xmit_frame(struct sk_buff *skb,
>  
>  	xsc_txwqe_complete(sq, skb, opcode, ds_cnt, num_wqebbs, num_bytes,
>  			   num_dma, wi);
> +	stats->bytes     += num_bytes;

For TSO packets this doesn't look right. You should count the length
after TSO, IOW the number of bytes that will reach the wire.

Also you should use helpers from include/linux/u64_stats_sync.h
to make sure there are no races when accessing the statistics

