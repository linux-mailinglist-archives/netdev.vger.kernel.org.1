Return-Path: <netdev+bounces-187774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2ECAA9982
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D367E17D145
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068621FC0FE;
	Mon,  5 May 2025 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fQnHuZum"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D1E1F582C;
	Mon,  5 May 2025 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463396; cv=none; b=RHXgXpIuGbkgZZwYJzuWr4ReFD5vWA+M/otzEmPQTsmnbEZn9uHJHy9H3K4saNz52DGVnnSaxvsaKcihunHheLp58jX1Z0UC3RcTTn9fJ80RbdnQ3+ySjgzpa79576t772gNlofGgm3vvp4/buSsRZkZ20Z+g7RzQ3g+S0uXURI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463396; c=relaxed/simple;
	bh=iusOOjruwYY0cj893U40aBJkYw6OvfktZxxkNF2KiJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDxsRpHbj/Z2mY2HZ/lgnaO0jw0sTNyfj9UVHDesdCl+PSh/vP4y0t1jmiUzbGhXiy1k1kLfeuCr5jMD7aKEEFIIK5AqjhgUXvO+e1Ghoxtbe2PWg79ZtpL7K9TwdQfEPBaP9NH662k4wBVhG/6Toljuc+DPOLTDeO9G6QogCxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fQnHuZum; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=R38+9FFEzIX1X2Mle5QSWjPU0quacBXrx9buQ+zcKnU=; b=fQnHuZumblFZCEaHY6biHy9g5U
	v6+OTVxSYFgqeQyttfUTLNlt03/pABBRsWFyUc3ykjbj7ii/XK7ZS8uZe8YcABnnJUY4jEiwE4e2m
	D5+KCjkv9Xwi4kBWGrdFyyzPWJlyspEylaSCcvQrpiN9O0xAv7+68N9KK3MgDKeRtoXI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uByuJ-00BcEE-K4; Mon, 05 May 2025 18:43:07 +0200
Date: Mon, 5 May 2025 18:43:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: vertexcom: mse102x: Return code for
 mse102x_rx_pkt_spi
Message-ID: <3b9d36a7-c2fd-4d37-ba33-fc13121d92e6@lunn.ch>
References: <20250505142427.9601-1-wahrenst@gmx.net>
 <20250505142427.9601-5-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505142427.9601-5-wahrenst@gmx.net>

On Mon, May 05, 2025 at 04:24:26PM +0200, Stefan Wahren wrote:
> The interrupt handler mse102x_irq always returns IRQ_HANDLED even
> in case the SPI interrupt is not handled. In order to solve this,
> let mse102x_rx_pkt_spi return the proper return code.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/net/ethernet/vertexcom/mse102x.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethernet/vertexcom/mse102x.c
> index 204ce8bdbaf8..aeef144d0051 100644
> --- a/drivers/net/ethernet/vertexcom/mse102x.c
> +++ b/drivers/net/ethernet/vertexcom/mse102x.c
> @@ -303,7 +303,7 @@ static void mse102x_dump_packet(const char *msg, int len, const char *data)
>  		       data, len, true);
>  }
>  
> -static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
> +static irqreturn_t mse102x_rx_pkt_spi(struct mse102x_net *mse)
>  {
>  	struct sk_buff *skb;
>  	unsigned int rxalign;
> @@ -324,7 +324,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
>  		mse102x_tx_cmd_spi(mse, CMD_CTR);
>  		ret = mse102x_rx_cmd_spi(mse, (u8 *)&rx);
>  		if (ret)
> -			return;
> +			return IRQ_NONE;
>  
>  		cmd_resp = be16_to_cpu(rx);
>  		if ((cmd_resp & CMD_MASK) != CMD_RTS) {
> @@ -357,7 +357,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
>  	rxalign = ALIGN(rxlen + DET_SOF_LEN + DET_DFT_LEN, 4);
>  	skb = netdev_alloc_skb_ip_align(mse->ndev, rxalign);
>  	if (!skb)
> -		return;
> +		return IRQ_NONE;

This is not my understanding of IRQ_NONE. To me, IRQ_NONE means the
driver has read the interrupt status register and determined that this
device did not generate the interrupt. It is probably some other
device which is sharing the interrupt.

       Andrew

