Return-Path: <netdev+bounces-181822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E63A86845
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C701BA649A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0847829C325;
	Fri, 11 Apr 2025 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fiXwQ/R4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ADC29B20D
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406993; cv=none; b=EQ8e7Q4c+/ftAL+pWZAwpBeys0d/RUukOZ7urJw3fRyd58UJiV03xmK42coiYooTSKA7JMy9X02+P0G42r98XW9+YHYP7JXHxn7nLugW3/dX/znnhdSaXMhtAJbmGHXPwJxa+bjkiqrW3g+567Cq6DbWPicBuSqRjZrfidrWm1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406993; c=relaxed/simple;
	bh=xGlmk+WcSn/rBCIknjQR4+iAPzxuubI4s2uuH8po28s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cszJs4kZWMFSC8by87WqN5G11XHh2B/MeTQ94HognP5dxmzNWgLQSQb2+HzgLJHnByK1w/cOU09QSZOqmxH47Up0WLjN8RxZAi3fvVwZhl+FltGMSUBd6lFFiz2uJwQJcYf7ihpjo5OvKAwi9wnhIgYjScypdQqYBjXHe0GWMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fiXwQ/R4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CGBJ6J9Ke4YhWqBt6NYgRofc9jx/kLx5Q4eLTh5q0D0=; b=fiXwQ/R4IIrqpeJ2q6+P3utjMy
	aqm8WtpK6zZ/jadpoOLKRgh3zZHb5pP0BME7hLOcrezdrfhu03AuKrAj2ahwZGrOsIoSyjFDkLGyt
	Rj0mj6T7A29X9GckDCvQoUYLdi3m3oCyoIXtFpFsDKDKxLddWgAr8bFfEJDCC0zZ5wMcWNTLXMufY
	E9utEORg1Ir+JJwyCaLEN2HS2tt3+JhvvilkSsFC8cn4JFACu9I/qaIDNNQgItj19L0S+4AVzW2er
	RBa7aN9+y9uzLQi+N3oWUJlqPDplY6Q5O9vKdKxhy8DKx/mQfEcckX5/o4AOqTF2dx/2YK6jP7CZG
	4p0W8dXg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54796)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3LwY-0003sn-0v;
	Fri, 11 Apr 2025 22:29:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3LwW-0004x6-0C;
	Fri, 11 Apr 2025 22:29:44 +0100
Date: Fri, 11 Apr 2025 22:29:43 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 1/5] net: mvpp2: add support for hardware
 timestamps
Message-ID: <Z_mJx1qqpYVngnTb@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
 <E1u3LtP-000COv-Ut@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u3LtP-000COv-Ut@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 11, 2025 at 10:26:31PM +0100, Russell King wrote:
> Add support for hardware timestamps in (e.g.) the PHY by calling
> skb_tx_timestamp() as close as reasonably possible to the point that
> the hardware is instructed to send the queued packets.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

This patch dates from prior to me joining Oracle, and is unchanged
apart from normal rebasing.

> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 416a926a8281..e3f8aa139d1e 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -4439,6 +4439,8 @@ static netdev_tx_t mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
>  		txq_pcpu->count += frags;
>  		aggr_txq->count += frags;
>  
> +		skb_tx_timestamp(skb);
> +
>  		/* Enable transmit */
>  		wmb();
>  		mvpp2_aggr_txq_pend_desc_add(port, frags);
> -- 
> 2.30.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

