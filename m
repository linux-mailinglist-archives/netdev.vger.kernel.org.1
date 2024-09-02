Return-Path: <netdev+bounces-124266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B84D968C03
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE3F1C21D66
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6F01A264E;
	Mon,  2 Sep 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hKfkZEdk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132483BB50
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294418; cv=none; b=uYiVxJFuq5kgGQ7vPZVfhgV82rIW0pDRGX119/qYU7JX0oG21QnATQbUTuN5+nTedVdkkaBIt2LVQ5Ix5NKnPwkWIBYt4f2S8tcCC5oT8Ojvi2J8z9J1BG9bFgtYWRXcK/vo97clPNXBaUFxehhZjs252d8TqWYIwL1f40OWlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294418; c=relaxed/simple;
	bh=Heukh7LhictrGmIFpYqxMzZni3Ph0e7CbjfU3y/yKB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eY9X50Zh7E5oeQF26IB/HsACfX6Oqf36oo9qKeaOqk2DOIZ4zKrQlzusLTpJcshtYhszZ21bKJpp+MVM341o89JHPj+rjmJQOoAGEkdjr2VhXjVooOhBThZvcAer62t8eOsfsd4iZHujqakE6WqBTSD4oAMVi0dukxyYf4g13EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hKfkZEdk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=axXTUPZ2v79+27rJnp78ThKOCjNdw/HoYnqwbwCnml0=; b=hKfkZEdkV/gcBWjOHfQSiZCj3I
	xM77CyfN87N5Lr8rNRY4BwSOwRkBCDcfx8bopEL1+GLGMTs7GBIDPKUJL9BFRQmFGtAeHUWHiZ/q0
	2rGlmTzKlWDKkL32EJUtXFJIgDGzco3p9Paf2dKBbKnkkAMOAZFY4hfHxnG/Kq8hFT6Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sl9t0-006KA7-Tl; Mon, 02 Sep 2024 18:26:38 +0200
Date: Mon, 2 Sep 2024 18:26:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: lan743x: Use NSEC_PER_SEC macro
Message-ID: <aa679b67-6580-4426-9edb-d0f5365ae3e9@lunn.ch>
References: <20240902071841.3519866-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902071841.3519866-1-ruanjinjie@huawei.com>

On Mon, Sep 02, 2024 at 03:18:41PM +0800, Jinjie Ruan wrote:
> 1000000000L is number of ns per second, use NSEC_PER_SEC macro to replace
> it to make it more readable.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
> index dcea6652d56d..9c2ec293c163 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ptp.c
> +++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
> @@ -409,7 +409,7 @@ static int lan743x_ptpci_settime64(struct ptp_clock_info *ptpci,
>  				   ts->tv_sec);
>  			return -ERANGE;
>  		}
> -		if (ts->tv_nsec >= 1000000000L ||
> +		if (ts->tv_nsec >= NSEC_PER_SEC ||
>  		    ts->tv_nsec < 0) {
>  			netif_warn(adapter, drv, adapter->netdev,
>  				   "ts->tv_nsec out of range, %ld\n",

https://elixir.bootlin.com/linux/v6.10.7/source/include/linux/time64.h#L92

/*
 * Returns true if the timespec64 is norm, false if denorm:
 */
static inline bool timespec64_valid(const struct timespec64 *ts)
{
        /* Dates before 1970 are bogus */
        if (ts->tv_sec < 0)
                return false;
        /* Can't have more nanoseconds then a second */
        if ((unsigned long)ts->tv_nsec >= NSEC_PER_SEC)
                return false;
        return true;
}

And the next question is, why is the driver checking this? It would
make more sense that the PTP core checked this before calling
ptp->info->settime64()

	Andrew

