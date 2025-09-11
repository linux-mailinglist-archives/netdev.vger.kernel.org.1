Return-Path: <netdev+bounces-222171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A5B535CE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020ED1CC49B1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467E834DCE1;
	Thu, 11 Sep 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="luusbQob"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCAD34AAF0
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601355; cv=none; b=Dr7Jw8K4h3ObywcONXekjVdYhwwpKZvIb200YX33Lwb07sLthgRmRoESTwUY0Z5sCSf+UJF8ddHHrxXLCEVLOm3+ToDKVviCn36Jgp5eZ+uz8Vz/zXPqISQ9wTwcrDyBzHxpluUsP2+7i39oX15tW0jsElDUSWvidRLlFQklUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601355; c=relaxed/simple;
	bh=OZSFRR3m0RcZ0aCctV8DPRcpigMznLiN+vHi2hm6xfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8D/g87fEvJ8YSVWDM2ipBwS808fly5do37GKC2VvcBc/uo9Oi+RxhUidrjzaMnbmwD20ijNUs3EMueXqxXxKuwqfuvaCox4nzRmCaFp+PGnrNdlqjfCZNXQumlHf9gVe3/i35nHCFwsag0DR9/T0/6/j0NAMINA8+d0JxYYYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=luusbQob; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca3b4343-f538-4db9-90be-fc9aa2854263@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757601341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXjkB0t5I8EFqUaQRQVUcc6w6ST88EZ7TlVvOqu4u8w=;
	b=luusbQobTnOdzoitzZymP78lbIeTEczsiQ+GuglI0b3NFVMvWV8RI40NM0UoKFe5x2ZElJ
	L2Lr1EguHLWVck8EJLOeIcxx8MWsNrw0+EYRaAtBv1bQcZDt8TSAZ6tGSrAdfFRfViy+BI
	aEcLqUfmXWmKMZ9KcGILYzNXB+clV7E=
Date: Thu, 11 Sep 2025 10:35:37 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] net: xilinx: axienet: Fix kernel-doc warning
 for axienet_free_tx_chain return value
To: Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com, radhey.shyam.pandey@amd.com,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, harini.katakam@amd.com
References: <20250911072815.3119843-1-suraj.gupta2@amd.com>
 <20250911072815.3119843-2-suraj.gupta2@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250911072815.3119843-2-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/11/25 03:28, Suraj Gupta wrote:
> Add proper "Return:" section in axienet_free_tx_chain() description.
> The return value description was present in the function description
> but not in the standardized format.
> Move the return value description from the main description to a separate
> "Return:" section to follow Linux kernel documentation standards.
> 
> Fixes below kernel-doc warning:
> warning: No description found for return value of 'axienet_free_tx_chain'
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index ec6d47dc984a..0cf776153508 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -773,7 +773,8 @@ static int axienet_device_reset(struct net_device *ndev)
>   *
>   * Would either be called after a successful transmit operation, or after
>   * there was an error when setting up the chain.
> - * Returns the number of packets handled.
> + *
> + * Return: The number of packets handled.
>   */
>  static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>  				 int nr_bds, bool force, u32 *sizep, int budget)

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

