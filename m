Return-Path: <netdev+bounces-215479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB12B2EBED
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BB81BA83B4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B12D877F;
	Thu, 21 Aug 2025 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n770zwqp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F710154423;
	Thu, 21 Aug 2025 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755746962; cv=none; b=UzmTAn8aO3PKl/qPimXmfB5JqfGzFXIMRC743UVCyTrinUc8bGPNazQfVstlfiJv6Gxqhf3Zm5fDwo4+jGPKfo2NQ34HDYD5vP5Xtx13sNl/PdVOsusw2nkMC+FLGCnonspg7Tl8PDNTt8A6zU2rtD2Jm7BG5hVJ7rkoiJmIeDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755746962; c=relaxed/simple;
	bh=o/6DwDIBIQ99ty/EvsXfHyYUXQzK7nE+7rAwt9N+GAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTmyv+6vHYIrQwzl5gt85ICT/dFhSt7+m3HNgeAMijUaIzPN6yh8TluBxD/IGscnX4I6GsPjBjGnNg0KHgGJa+DmrgcHya+At4sYa3W/NuVaGqdR2LiOjc0oCNZ31Y37882on9EOrQmbyO123nsoSltYaEZbyKoZ2aczL5XgcDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n770zwqp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JMKhB6kyFAD9gcjFCdXdpxoe38SI+rRjE5ZThTi319s=; b=n770zwqpcYGva4kIGC9MvrAH9x
	+5ktFCSgT07R4ixJ3NKUvx9y/UevpOX+abIC6IRqYMnKms6kNJ0/n4YbGH0ZlUp3w/mo69W9ayb10
	tGccdhSOuI9KS7j6KmdHzkW8zmUMsryCLkBj0dsXkvRucc0KS+MuEjORdemT9CFs/wLw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uovz8-005P7g-5F; Thu, 21 Aug 2025 05:29:06 +0200
Date: Thu, 21 Aug 2025 05:29:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: Re: [PATCH net-next] net: fec: add the Jumbo frame support
Message-ID: <2aecd34f-259f-4660-9df7-3d7a320b51d1@lunn.ch>
References: <20250820222308.994949-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820222308.994949-1-shenwei.wang@nxp.com>

On Wed, Aug 20, 2025 at 05:23:08PM -0500, Shenwei Wang wrote:
> Certain i.MX SoCs, such as i.MX8QM and i.MX8QXP, feature enhanced
> FEC hardware that supports Ethernet Jumbo frames with packet sizes
> up to 16K bytes.
> 
> When Jumbo frames are enabled, the TX FIFO may not be large enough
> to hold an entire frame. To accommodate this, the FIFO should be
> configured to operate in cut-through mode, which allows transmission
> to begin once the FIFO reaches a certain threshold.

Please could you break this patch up into smaller parts, doing
refactoring before adding jumbo support.

>  fec_restart(struct net_device *ndev)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> -	u32 rcntl = OPT_FRAME_SIZE | FEC_RCR_MII;
> +	u32 rcntl = FEC_RCR_MII;
>  	u32 ecntl = FEC_ECR_ETHEREN;
>  
> +	rcntl |= (fep->max_buf_size << 16);
>  	if (fep->bufdesc_ex)
>  		fec_ptp_save_state(fep);
>  
> @@ -1191,7 +1199,7 @@ fec_restart(struct net_device *ndev)
>  		else
>  			val &= ~FEC_RACC_OPTIONS;
>  		writel(val, fep->hwp + FEC_RACC);
> -		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
> +		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
>  	}
>  #endif
>  
> @@ -1278,8 +1286,16 @@ fec_restart(struct net_device *ndev)
>  	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
>  		/* enable ENET endian swap */
>  		ecntl |= FEC_ECR_BYTESWP;
> -		/* enable ENET store and forward mode */
> -		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
> +
> +		/* When Jumbo Frame is enabled, the FIFO may not be large enough
> +		 * to hold an entire frame. In this case, configure the interface
> +		 * to operate in cut-through mode, triggered by the FIFO threshold.
> +		 * Otherwise, enable the ENET store-and-forward mode.
> +		 */
> +		if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
> +			writel(0xF, fep->hwp + FEC_X_WMRK);
> +		else
> +			writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
>  	}
>  
>  	if (fep->bufdesc_ex)

Part of why i ask for this to be broken up is that OPT_FRAME_SIZE has
just disappeared. It has not moved into an if/else, just gone.

#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
    defined(CONFIG_ARM64)
#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
#else
#define	OPT_FRAME_SIZE	0
#endif

and

 * 2048 byte skbufs are allocated. However, alignment requirements
 * varies between FEC variants. Worst case is 64, so round down by 64.
 */
#define PKT_MAXBUF_SIZE		(round_down(2048 - 64, 64))

It is unclear to me where all this alignment code has gone. And does
jumbo have the same alignment issues?

A smaller patch just refactoring this bit of code can have a good
commit message explaining what is going on. Some for other parts of
the code. You want lots if small, obviously correct, well described
patches which are easy to review.

    Andrew

---
pw-bot: cr

