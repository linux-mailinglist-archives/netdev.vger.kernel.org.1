Return-Path: <netdev+bounces-240055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AFAC70007
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F651504D61
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C81B36E55F;
	Wed, 19 Nov 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dHGZhpUr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920836E546
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567878; cv=none; b=E09ves3ku8zc3xzkuXX3XjjUD5lMUlgAa7Sn+aQtOnY+WT2we28UkCt2H8jLl5K3iN+zU7Nzp/P5GfxS69NjVsQNwAZTOim0N90FkrCbatyKV7abBIJNxhFjOBCPVvetcdFM6E93+At3AHoe+Dgkqu7eI3Lf8tedw35jnjzAFOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567878; c=relaxed/simple;
	bh=JXMPvu/J4g8fmYDP1TB+ZNrorTpX3IoJnMErkAbn9m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUmIM4DDmV9XzbVZ0O5hNZiAOueehwnpbG8DDVd1fQrQKvtLD/ZKlXfAmLUOAqdRbOlW0x1biLkkKlle6hDBbttxhwhifLVVHP9CzaN9F7xL6BxJE4W8LZqMy5MqFAInFX6qZcN58zUt82fOLuOapWo8yDs9qfTfNljD95C5sh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dHGZhpUr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F3B4DC1118D;
	Wed, 19 Nov 2025 15:57:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1DE3160699;
	Wed, 19 Nov 2025 15:57:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77732103719E4;
	Wed, 19 Nov 2025 16:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763567871; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FQuh6VmaD93GvvXK5c4xgLR0ZzMDhEwGj0WmLsCnIN8=;
	b=dHGZhpUrZgi42dyqEhybjEegv6IaaMxibHfTTXQW7iH2qRs/rle+ULMC+CEEWAPFtAI1gA
	+5XfHJGdD/5mmJD8Gf/2HnFufqxYAYAe9DHWfi5A8Gl1cWpJCwFML67yJp+zQKZZBuW42S
	PZ45DjIbcmTQrRnIGapS3it8IgDzjEFXgE+f/uUzZOOc7Pydy7RnFI3vRdh5AyXMevWKxi
	LmwboiRg293CzWz4c5YVEh1st/PEiWFUpOGbYl+KHM3Ehjz6woZPd0x6XwkEZJytO/lbgl
	gocNJVu3Ohyfcy3OUIgEcDCCNocXZucnjElO3VCQ9xIyS3edrwVULW3pLLPSjQ==
Message-ID: <0ca796b8-2add-4101-a3d5-cd7135662938@bootlin.com>
Date: Wed, 19 Nov 2025 16:57:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] amd-xgbe: let the MAC manage PHY PM
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251119093124.548566-1-Raju.Rangoju@amd.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251119093124.548566-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Raju,

On 19/11/2025 10:31, Raju Rangoju wrote:
> Use the MAC managed PM flag to indicate that MAC driver takes care of
> suspending/resuming the PHY, and reset it when the device is brought up.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 3 +++
>  drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index f3adf29b222b..1c03fb138ce6 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -1266,6 +1266,9 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
>  
>  	clear_bit(XGBE_STOPPED, &pdata->dev_state);
>  
> +	/* Reset the phy settings */
> +	xgbe_phy_reset(pdata);
> +

At a first glance, this looks like 2 different things, so maybe 2
different patches ?

That said, with this change does it still make sense to call
xgbe_phy_reset() in xgbe_open() ?

With this patch we have :

xgpe_open() {

  xgbe_phy_reset();

  xgbe_start() {
    xgbe_phy_reset(); /* again */
  }
}

Can you remove the first call in .ndo_open ?

Maxime


