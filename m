Return-Path: <netdev+bounces-98000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE658CE84C
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 17:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CE1281963
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D65412E1CD;
	Fri, 24 May 2024 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IQvJheCf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECFF12CD81;
	Fri, 24 May 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566056; cv=none; b=CEvp3yhqlkNrGndsAmUfUvSFBqxjHWkR5xXnHgB1wSz1Vm5gXuJcHotZpVFD/Z4ceUEYLi+ARBb8MR+bllDg7oEmdDg0mM3WZQ8za5vV1Q26JZzZZIyRh7TRLoLCh6SQdfMN1GaM6Hpm1w4lztv/lg6FxvKju4zvZ9n7ivQ2pY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566056; c=relaxed/simple;
	bh=+Pq8Ay0wvcb7Etnygr3YARipsS/gX3bUE7ZtLQZNb+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvB8dIz/I6lK28J6ty99SxHDx+cJ0K9pkxjjyidrNelt9dfMMEuhhH5Ol8N0iWuAbOJRv553SjhK5/GtSINELqnqPTi9pF5uU0nf1FzWQ/xNS+XPV63HLwBYjTxL0v9px0xgarAqxkrPSL9mQy5KydJS+QxXcEH1lOydJ1Y0zA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IQvJheCf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MV8cl0rOGCTFcJnTsA5zvFiTquGTr/gV2k/m7gDsWG4=; b=IQvJheCf08SL2R5FzIUr3qIfsc
	IzMIZ0eIwz7vKm8f4p86ki3xUrLeYmy/XCtrU95+Ch702s+sxm1aRpBcOqCCE8wo1tTN6k2GzaeC4
	r4n1v+rd40kqOqWXg5XHy+dsYG6keBnzRs5Xsc2H8T+r9x68fWuDfzYnEAJiUSKZXAd8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sAXF3-00Fxnh-Rc; Fri, 24 May 2024 17:54:01 +0200
Date: Fri, 24 May 2024 17:54:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net v3 PATCH] net:fec: Add fec_enet_deinit()
Message-ID: <9eb45fe8-a0df-4b5d-88a3-ed61f9e320f1@lunn.ch>
References: <20240524050528.4115581-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524050528.4115581-1-xiaolei.wang@windriver.com>

On Fri, May 24, 2024 at 01:05:28PM +0800, Xiaolei Wang wrote:
> When fec_probe() fails or fec_drv_remove() needs to release the
> fec queue and remove a NAPI context, therefore add a function
> corresponding to fec_enet_init() and call fec_enet_deinit() which
> does the opposite to release memory and remove a NAPI context.
> 
> Fixes: 59d0f7465644 ("net: fec: init multi queue date structure")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> ---
> v1 -> v2
>  - Add fec_enet_free_queue() in fec_drv_remove()
> v2 -> v3
>  - Add fec_enet_deinit()
> 
>  drivers/net/ethernet/freescale/fec_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index a72d8a2eb0b3..881ece735dcf 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -4130,6 +4130,14 @@ static int fec_enet_init(struct net_device *ndev)
>  	return ret;
>  }
>  
> +static void fec_enet_deinit(struct net_device *ndev)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +
> +	netif_napi_del(&fep->napi);
> +	fec_enet_free_queue(ndev);
> +}

That is much better, and using the correct structure helped you find
other bug....

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

