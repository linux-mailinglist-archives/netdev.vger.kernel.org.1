Return-Path: <netdev+bounces-69861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AE084CD1C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FB72869FB
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DFD7C0AB;
	Wed,  7 Feb 2024 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lzRmuCHH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F57E76F
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317107; cv=none; b=kHQ8uk3gBmCwHGBnw2qUykb9jMKZDApsMVp3wVa634IdeTbxBtiAfctUn3em2Xx+0hrtXG4aA/ty0QAIId89uDUIrluAQj7PjrXzaTGFKhPeFXHRKjNISJlswOwW/lGIIGX2crVrz0qorVeL547nLg+HWViKD6p7kCz800WW4PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317107; c=relaxed/simple;
	bh=q8jDyRmKbTii/oLJ2WetHtI+x/SSG/53uGzxq2XL3Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJUC6kRsdFgwV2ocqUvBQJCEDsjAct4usc+cq3KcTOEtc/7uY9x5sFQtFemSzpbQnL2sZaB75uXfx+vir5/UAzOxCXu+rnNrT0oSWkG8KkultJjE51EQIK2GPvDlOpjcpCvnTfbUhMvWkV/IX8DieNMTY5soIJKa/Yu16Vw5OY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lzRmuCHH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=OaDyFGTBmW8TYo26UkjMw5f5pDRDa7VcA9uT14YqIdA=; b=lz
	RmuCHHjcdqj9N6kND3ESObO/i+mhnzCyS8D2Lz9bnoQR/UEe7RdPFHKjGOdwMCR13sHhePofzWdqM
	vCI5zta3o+BX8aFkUT5xMnZBts50RGXPoU8FzrmbFbzs4U/tx3ccCFHqv+AW4t2v8m5PVd70h6C8A
	j+HS07nmLWdfVx8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXjAW-007E5g-3Q; Wed, 07 Feb 2024 15:44:56 +0100
Date: Wed, 7 Feb 2024 15:44:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH resubmit] net: fec: Add ECR bit macros, fix
 FEC_ECR_EN1588 being cleared on link-down
Message-ID: <8c0e21da-4f6a-4a42-90c0-011b226ffae7@lunn.ch>
References: <20240207123610.16337-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207123610.16337-1-csokas.bence@prolan.hu>

On Wed, Feb 07, 2024 at 01:36:11PM +0100, Csókás Bence wrote:
> FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
> makes all 1588 functionality shut down on link-down. However, some
> functionality needs to be retained (e.g. PPS) even without link.

This is the second version of the patch, so the subject should say v2
within the [PATCH ].

Is this fixing a regression, or did it never work correctly?

> Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 63707e065141..652251e48ad4 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -273,8 +273,11 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
>  #define FEC_MMFR_TA		(2 << 16)
>  #define FEC_MMFR_DATA(v)	(v & 0xffff)
>  /* FEC ECR bits definition */
> -#define FEC_ECR_MAGICEN		(1 << 2)
> -#define FEC_ECR_SLEEP		(1 << 3)
> +#define FEC_ECR_RESET   BIT(0)
> +#define FEC_ECR_ETHEREN BIT(1)
> +#define FEC_ECR_MAGICEN BIT(2)
> +#define FEC_ECR_SLEEP   BIT(3)
> +#define FEC_ECR_EN1588  BIT(4)

There was a request to keep the indentation the same. So the BIT()
need moving right.

>  
>  #define FEC_MII_TIMEOUT		30000 /* us */
>  
> @@ -1213,7 +1216,7 @@ fec_restart(struct net_device *ndev)
>  	}
>  
>  	if (fep->bufdesc_ex)
> -		ecntl |= (1 << 4);
> +		ecntl |= FEC_ECR_EN1588;

Please could you split this into two patches. The first patch
introduced the new #defines, and uses them in the existing code. That
should be obviously correct. And a second patch adding the new
functionality, with a good commit message explaining the change,
particularly the Why?

>  
>  	if (fep->quirks & FEC_QUIRK_DELAYED_CLKS_SUPPORT &&
>  	    fep->rgmii_txc_dly)
> @@ -1314,6 +1317,7 @@ fec_stop(struct net_device *ndev)
>  	struct fec_enet_private *fep = netdev_priv(ndev);
>  	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
>  	u32 val;
> +	u32 ecntl = 0;

Reverse Christmas tree, as pointed out in your first version of the
patch.

Thanks
    Andrew

---
pw-bot: cr

