Return-Path: <netdev+bounces-87693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D468A41D0
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 12:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041711C20927
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 10:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C692421D;
	Sun, 14 Apr 2024 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stxe4gOX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0B2374C
	for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713090222; cv=none; b=LXU2/Wsy415kIEgNl8p6SQkRnjZEyljQY5Zzm7TRbpGfgAgNqq9GD8tTHvaiinB7rqNlI7Ggv6AF9baIZPU0C1llRBO9k6XNZDKlELYQKb1tU2sbEFYKTYF2Z/QMvB1zvuVw47OWy8ru8KRQcnp4BxrUaeJytwCz8KOgnJH/W4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713090222; c=relaxed/simple;
	bh=5J8J24Fz3CGOJ2aTUHoGjLvyTOXGaJMxfYbRTUIb6tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lONuESvllHj7+dmQI/zfB6ulaV+QZrDUuzZQSu3B/pgoE8FnuNq3+iErlTfgODkDZTZSViCpaiXfaOlASBsGy3r9UnoDSjRQN2OP8cWU1m4b0x4vW1Ku0PgkKVDCGuUKgEF0QluNXTeHqE8sTtlGCzE/Wx6Xdkvu1OeQoz6LHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stxe4gOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5733CC072AA;
	Sun, 14 Apr 2024 10:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713090221;
	bh=5J8J24Fz3CGOJ2aTUHoGjLvyTOXGaJMxfYbRTUIb6tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Stxe4gOX+xRA7JIsYK6zCoc3gp2cbeGety3cxqAVTC4XrRWHuEQFgeZdd4u28X/G+
	 1vv7askv5w705+Ke5qXTBJf57xVQScmmb9F0fk6cPPU5uYuRpycrRU/FS4Lof1Pt7r
	 QrgqNswVYVJKtennOPOziADNwPqjthjYyraqk4XkexCtBJ3Us8UZlIgapV4El7yeek
	 hhJ1/2Mdqnd+bqi76eaDYbSoOBdmGSGf+wG7QRo7vRFrAV5Unkqq6/9G/HzCy/rVkN
	 IWfaAwYvPSeIrie6J5xrH2w8M04XeCYWXWlYDuTSqqAGX3MUtqHfy48xKU/bjeViL/
	 WtkM9yNSVJ1HA==
Date: Sun, 14 Apr 2024 11:23:37 +0100
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
	mmc@linux.ibm.com
Subject: Re: [PATCH net-next] ibmvnic: Return error code on TX scrq flush fail
Message-ID: <20240414102337.GA645060@kernel.org>
References: <20240411203435.228559-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411203435.228559-1-nnac123@linux.ibm.com>

On Thu, Apr 11, 2024 at 03:34:35PM -0500, Nick Child wrote:
> In ibmvnic_xmit() if ibmvnic_tx_scrq_flush() returns H_CLOSED then
> it will inform upper level networking functions to disable tx
> queues. H_CLOSED signals that the connection with the vnic server is
> down and a transport event is expected to recover the device.
> 
> Previously, ibmvnic_tx_scrq_flush() was hard-coded to return success.
> Therefore, the queues would remain active until ibmvnic_cleanup() is
> called within do_reset().
> 
> The problem is that do_reset() depends on the RTNL lock. If several
> ibmvnic devices are resetting then there can be a long wait time until
> the last device can grab the lock. During this time the tx/rx queues
> still appear active to upper level functions.
> 
> FYI, we do make a call to netif_carrier_off() outside the RTNL lock but
> its calls to dev_deactivate() are also dependent on the RTNL lock.
> 
> As a result, large amounts of retransmissions were observed in a short
> period of time, eventually leading to ETIMEOUT. This was specifically
> seen with HNV devices, likely because of even more RTNL dependencies.
> 
> Therefore, ensure the return code of ibmvnic_tx_scrq_flush() is
> propagated to the xmit function to allow for an earlier (and lock-less)
> response to a transport event.
> 
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 30c47b8470ad..f5177f370354 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -2371,7 +2371,7 @@ static int ibmvnic_tx_scrq_flush(struct ibmvnic_adapter *adapter,
>  		ibmvnic_tx_scrq_clean_buffer(adapter, tx_scrq);
>  	else
>  		ind_bufp->index = 0;
> -	return 0;
> +	return rc;
>  }
>  
>  static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)

Hi Nick,

I notice that some, but not all, cases the return value of
ibmvnic_tx_scrq_flush() is not checked. Should that also be
addressed?

