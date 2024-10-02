Return-Path: <netdev+bounces-131134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28E598CDD3
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D49B1F226DE
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 07:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416C4155735;
	Wed,  2 Oct 2024 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A+064Tfg"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4612D517;
	Wed,  2 Oct 2024 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854671; cv=none; b=AHul/fz6zW15YsbQBJxndCMcTKQPvgq+a7bUi+byHjd5/P9knoUWiB4+Cdc9F1yte9C8bCTputDpwdugcqbElvdjjm7bs4+UX7SZ1WrIqMN53MnPjBvDSNbqX7Zr4LaPn1J8uDWB+is6nS+wXGMd5eB+sMK/T+zNRcFhPozYDaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854671; c=relaxed/simple;
	bh=WJDXLihwEt5Fn8KRMQVtpsVtQyCTZzy/CXej5tha83s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7jtgxHa7U2Wicr9LuHoWc7MoEE+xKF30g9Ee4WATuk2CBpAuUaGGNCIS9EHSqKQAPfYntLJO7LGvKMBEUaPPSGKBREwna3UnyldX9llIs39ZZaABtJnpc0Ic+EHTrE0T07rXLdEC6HS4qQQzpkomS53ukxHBK7C5oGG2Yw4n7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A+064Tfg; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BCF38E0008;
	Wed,  2 Oct 2024 07:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727854657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lByhxrRqD4ymTprjjNv5qEv5Ejf4B1h8Q4fRhWuLTBI=;
	b=A+064TfggQbsU27miSn/QxgXl2o5fXk+MvFPWH65hti4emQI6pih+BkIv7YpGfRrqsILiB
	sgfZvyU1LKc563fTlDSCENgkKTSLHXUe6XhJPuulvQrGo2U75MQviW0cMuMRqlPDIUUNP+
	K3ycFhjKBkNt5ujFAjfx9bGMrsiaotkbyrETwywe4iqGP/+sfx9Ke4KYGA0dc/Ko9Puu0P
	Veo5jrUCUnaQjPDNH6ULU7G0YvdRNhtuiiSdT5ARMysxQEV0ANhLpKlyMP+MvVOr9mPnF4
	qizY03AS0hwYay94OCE1TZr+ExSg0/LSDDDRvQszXESa+e9tI8tBzcSX3qznvQ==
Date: Wed, 2 Oct 2024 09:37:36 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com
Subject: Re: [PATCH net-next 5/6] net: gianfar: use devm for request_irq
Message-ID: <20241002093736.43af4008@fedora.home>
In-Reply-To: <20241001212204.308758-6-rosenp@gmail.com>
References: <20241001212204.308758-1-rosenp@gmail.com>
	<20241001212204.308758-6-rosenp@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Rosen,

On Tue,  1 Oct 2024 14:22:03 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/freescale/gianfar.c | 67 +++++++-----------------
>  1 file changed, 18 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index 07936dccc389..78fdab3c6f77 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -2769,13 +2769,6 @@ static void gfar_netpoll(struct net_device *dev)
>  }
>  #endif
>  
> -static void free_grp_irqs(struct gfar_priv_grp *grp)
> -{
> -	free_irq(gfar_irq(grp, TX)->irq, grp);
> -	free_irq(gfar_irq(grp, RX)->irq, grp);
> -	free_irq(gfar_irq(grp, ER)->irq, grp);
> -}
> -
>  static int register_grp_irqs(struct gfar_priv_grp *grp)
>  {
>  	struct gfar_private *priv = grp->priv;
> @@ -2789,80 +2782,58 @@ static int register_grp_irqs(struct gfar_priv_grp *grp)
>  		/* Install our interrupt handlers for Error,
>  		 * Transmit, and Receive
>  		 */
> -		err = request_irq(gfar_irq(grp, ER)->irq, gfar_error, 0,
> -				  gfar_irq(grp, ER)->name, grp);
> +		err = devm_request_irq(priv->dev, gfar_irq(grp, ER)->irq,
> +				       gfar_error, 0, gfar_irq(grp, ER)->name,
> +				       grp);

This is called during open/close, so the lifetime of the irqs
isn't tied to the struct device, devm won't apply here. If you
open/close/re-open the device, you'll request the same irq multiple
times.

Maxime

