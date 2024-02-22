Return-Path: <netdev+bounces-73890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B3085F1A3
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 07:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14FA283FE5
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 06:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1041FBF4;
	Thu, 22 Feb 2024 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ePb7Nmjd"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30415D533
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708584657; cv=none; b=GKmzRz5rzAmehfZNI8qJzLQIvedRu1MzS9HKZAXShruvUCRBYsqQ2JawmWYBcVkxQXq8bSQLEqAgzNdo4fnPtB7c5GAIzApF6mkxJ7P/moGiqBCDRbMQ/0uVR5FLVDMNlwEOuf3N+9VKI0yFRmsircdu7II1QuyDMLjXEzLrexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708584657; c=relaxed/simple;
	bh=0xxE3F/mYwSwLijt4vxq2fO3ErCRmB5dUhH1uF1yhfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqedXLZvNxRjv55dJEe2qAXdJR9M3MTSbV3Ef+kn7V1QACm9KBK+D3XpKwNS7WD35PC8g06NaWYL3+oGvza71G0qPBcszYfV51dElV0XnuMe9VMWK+32u2MuMfdRbr5Lb8b3eaiRezFC84r+tYXHTWhHkfkkuwXuopZhwaHZTe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ePb7Nmjd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=BpvOMzy9ulC+09MeE8dtVU205P+hnczqUIcLjP1sEAc=; b=ePb7NmjdTof88AD4C557Y8s1E6
	nMYQHhmw1/yyLWaHGWz7n0DhlxQsmLy2f2rmXBs+8+1oIw0Ok4fL1ft7dMr4wQEpKFzE21fl/MR2p
	CxBcR0d0jL+3yNzXnQSH043qMIccCsPyZNwQPkZnY56fgzM8s+73f8BBLAS2iIpOg+JM0Gw8XY+Mk
	vaVvVI9WbFMc/2FfnmgAaBeEsdCvjw42rSxmKMbEVY+zu5xJuaTtB+ie/PDy0HqqX38gib3roCaUY
	JFZz+1UVIfggyrtR6zYC9oXobnOihdQS93Q2yta9TgM9oT9rF26+C7mQp05pTBBtS7tjbTCEOKgAv
	vh2rcPVg==;
Received: from 124x35x135x198.ap124.ftth.ucom.ne.jp ([124.35.135.198] helo=[192.168.2.109])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd2uw-00000002qhp-27nM;
	Thu, 22 Feb 2024 06:50:50 +0000
Message-ID: <5548b3f0-437c-4792-ad6a-d08ffe1ba873@infradead.org>
Date: Thu, 22 Feb 2024 15:50:44 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ps3/gelic: minor Kernel Doc corrections
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20240221-ps3-gelic-kdoc-v1-1-7629216d1340@kernel.org>
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <20240221-ps3-gelic-kdoc-v1-1-7629216d1340@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

On 2/22/24 02:46, Simon Horman wrote:
> * Update the Kernel Doc for gelic_descr_set_tx_cmdstat()
>   and gelic_net_setup_netdev() so that documented name
>   and the actual name of the function match.
> 
> * Move define of GELIC_ALIGN() so that it is no longer
>   between gelic_alloc_card_net() and it's Kernel Doc.
> 
> * Document netdev parameter of gelic_alloc_card_net()
>   in a way consistent to the documentation of other netdev parameters
>   in this file.
> 
> Addresses the following warnings flagged by ./scripts/kernel-doc -none:
> 
>   .../ps3_gelic_net.c:711: warning: expecting prototype for gelic_net_set_txdescr_cmdstat(). Prototype was for gelic_descr_set_tx_cmdstat() instead
>   .../ps3_gelic_net.c:1474: warning: expecting prototype for gelic_ether_setup_netdev(). Prototype was for gelic_net_setup_netdev() instead
>   .../ps3_gelic_net.c:1528: warning: expecting prototype for gelic_alloc_card_net(). Prototype was for GELIC_ALIGN() instead
>   .../ps3_gelic_net.c:1531: warning: Function parameter or struct member 'netdev' not described in 'gelic_alloc_card_net'
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> index d5b75af163d3..12b96ca66877 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> @@ -698,7 +698,7 @@ gelic_card_get_next_tx_descr(struct gelic_card *card)
>  }
>  
>  /**
> - * gelic_net_set_txdescr_cmdstat - sets the tx descriptor command field
> + * gelic_descr_set_tx_cmdstat - sets the tx descriptor command field
>   * @descr: descriptor structure to fill out
>   * @skb: packet to consider
>   *
> @@ -1461,7 +1461,7 @@ static void gelic_ether_setup_netdev_ops(struct net_device *netdev,
>  }
>  
>  /**
> - * gelic_ether_setup_netdev - initialization of net_device
> + * gelic_net_setup_netdev - initialization of net_device
>   * @netdev: net_device structure
>   * @card: card structure
>   *
> @@ -1518,14 +1518,16 @@ int gelic_net_setup_netdev(struct net_device *netdev, struct gelic_card *card)
>  	return 0;
>  }
>  
> +#define GELIC_ALIGN (32)
> +
>  /**
>   * gelic_alloc_card_net - allocates net_device and card structure
> + * @netdev: interface device structure
>   *
>   * returns the card structure or NULL in case of errors
>   *
>   * the card and net_device structures are linked to each other
>   */
> -#define GELIC_ALIGN (32)
>  static struct gelic_card *gelic_alloc_card_net(struct net_device **netdev)
>  {
>  	struct gelic_card *card;
> 

Looks good.  Thanks for taking care of it.

Acked-by: Geoff Levand <geoff@infradead.org>


