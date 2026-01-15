Return-Path: <netdev+bounces-250282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC505D27638
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E95E032394DC
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F1B3AA1A8;
	Thu, 15 Jan 2026 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV+1yj+o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45544C81;
	Thu, 15 Jan 2026 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498623; cv=none; b=jxA54EHkTISMIuAIH52Ou51NqDQV2Z2buCDqWtlsRKhgCH8HCSzYt487SyqYE8nDzoZKCh+za/J/fqT1iJ064pFMPluIgJB6rDxuDOP2imv+IdIE0/YuRU7SMFH7JBnk9kT5khqKqd8tmTkvOqbl23qtX/gPcmqQ7LF5w7yLM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498623; c=relaxed/simple;
	bh=7dtxLIwdJn4CWNO7qgXOLkKRkgzWHxgwNlC41RergPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In0Wk6thgPv14pu8V5W+q5yhC2mDTH/lqakyGHpCjI6RaFd3u3oFHTFnRjk0vz5/vObncXmAzLHiH28M259QKx+xmv7LVpMTzQcL+yYnWLvBP4USEh+Fc1FJgU0J1r36KaUimW5H5d092kfO/FipN3OvRK1lhlGbEUC3fJDdD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV+1yj+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F204C116D0;
	Thu, 15 Jan 2026 17:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768498623;
	bh=7dtxLIwdJn4CWNO7qgXOLkKRkgzWHxgwNlC41RergPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hV+1yj+oW2PVe01Ss9+NKu0GcUtuPnVN7VQsUKPhWkEi/z2BDpNzQte7aBetvB1+p
	 CmoLEIAMpWEQN1Wxz2kPNg79is6+jGAYrpd5NvRKDIkZesF0AobpT/0NlA8FlDDfUt
	 ozwXRLgiDT7QzX3BtpJ1nYigcdHubHLvPr65QrvpBrBf1SgPF2ktaXpg+pHMm01Z7H
	 GeB91FfGd+3sP09kL7f9UcS8X87dM9WoG22bNCtHyDCYWZUEGbN1ij293KW8HMAUP/
	 eG2Cb9fAqXJFf2tSdUFfh3QcjDaXHVhT6pZJxiZxAmaTP0wisai9m90a4yyyg2++Qb
	 78iWcX+q09QIg==
Date: Thu, 15 Jan 2026 17:36:59 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH net-next] net: usb: sr9700: fix byte numbering in comments
Message-ID: <aWklu0EwMbINC6T0@horms.kernel.org>
References: <20260113075327.85435-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113075327.85435-1-enelsonmoore@gmail.com>

On Mon, Jan 12, 2026 at 11:53:21PM -0800, Ethan Nelson-Moore wrote:
> The comments describing the RX/TX headers and status response use
> a combination of 0- and 1-based indexing, leading to confusion. Correct
> the numbering and make it consistent. Also fix a typo "pm" for "pn".
> 
> This issue also existed in dm9601 and was fixed in commit 61189c78bda8
> ("dm9601: trivial comment fixes").
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Thanks,

I agree this is consistent with the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

Context left below for the benefit of Peter who I've added to the CC list.

> ---
>  drivers/net/usb/sr9700.c | 42 ++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
> index 820c4c506979..bd90ac40acdd 100644
> --- a/drivers/net/usb/sr9700.c
> +++ b/drivers/net/usb/sr9700.c
> @@ -391,20 +391,20 @@ static int sr9700_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
>  	int len;
>  
>  	/* skb content (packets) format :
> -	 *                    p0            p1            p2    ......    pm
> +	 *                    p1            p2            p3    ......    pn
>  	 *                 /      \
>  	 *            /                \
>  	 *        /                            \
>  	 *  /                                        \
> -	 * p0b0 p0b1 p0b2 p0b3 ...... p0b(n-4) p0b(n-3)...p0bn
> +	 * p1b1 p1b2 p1b3 p1b4 ...... p1b(n-4) p1b(n-3)...p1bn
>  	 *
> -	 * p0 : packet 0
> -	 * p0b0 : packet 0 byte 0
> +	 * p1 : packet 1
> +	 * p1b1 : packet 1 byte 1
>  	 *
> -	 * b0: rx status
> -	 * b1: packet length (incl crc) low
> -	 * b2: packet length (incl crc) high
> -	 * b3..n-4: packet data
> +	 * b1: rx status
> +	 * b2: packet length (incl crc) low
> +	 * b3: packet length (incl crc) high
> +	 * b4..n-4: packet data
>  	 * bn-3..bn: ethernet packet crc
>  	 */
>  	if (unlikely(skb->len < SR_RX_OVERHEAD)) {
> @@ -452,12 +452,12 @@ static struct sk_buff *sr9700_tx_fixup(struct usbnet *dev, struct sk_buff *skb,
>  
>  	/* SR9700 can only send out one ethernet packet at once.
>  	 *
> -	 * b0 b1 b2 b3 ...... b(n-4) b(n-3)...bn
> +	 * b1 b2 b3 b4 ...... b(n-4) b(n-3)...bn
>  	 *
> -	 * b0: rx status
> -	 * b1: packet length (incl crc) low
> -	 * b2: packet length (incl crc) high
> -	 * b3..n-4: packet data
> +	 * b1: rx status
> +	 * b2: packet length (incl crc) low
> +	 * b3: packet length (incl crc) high
> +	 * b4..n-4: packet data
>  	 * bn-3..bn: ethernet packet crc
>  	 */
>  
> @@ -488,14 +488,14 @@ static void sr9700_status(struct usbnet *dev, struct urb *urb)
>  	u8 *buf;
>  
>  	/* format:
> -	   b0: net status
> -	   b1: tx status 1
> -	   b2: tx status 2
> -	   b3: rx status
> -	   b4: rx overflow
> -	   b5: rx count
> -	   b6: tx count
> -	   b7: gpr
> +	   b1: net status
> +	   b2: tx status 1
> +	   b3: tx status 2
> +	   b4: rx status
> +	   b5: rx overflow
> +	   b6: rx count
> +	   b7: tx count
> +	   b8: gpr
>  	*/
>  
>  	if (urb->actual_length < 8)
> -- 
> 2.43.0
> 
> 

