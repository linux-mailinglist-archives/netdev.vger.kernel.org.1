Return-Path: <netdev+bounces-189840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 731B4AB3DC1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8337161E00
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C656F24DFED;
	Mon, 12 May 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZtcm0Ri"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCB246768
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067857; cv=none; b=IIvWou74WwwVGHHECIk594avUaTMMD3n2tWXFU2TbAcwXtAWn1t2t9Sm78gPeGx4dLA6JQOmpZu03vapGIfrgkd1tQ8m90fNOPBPyA50z+8IdF2lbEQVwQLgLVjSn2vLTL/R82wglkdlRMkydy9PXMG57JtgxDseUfMDwmlWClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067857; c=relaxed/simple;
	bh=r5v3ana5WMmi48l7ra/A2/znuDGHAIJEO2qZ1UVLBC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkPt1BLBBwfJjznM6VAivErgoPLQxfNOpPOW7WsN31t/o/eT4S4CvKZh/nzENsTt7dku2wGKygkLUnotGa9wLIg16qKOqFKp0Av3DHdqiqgiTSBcY1I2swnamTLSa8Vrk81nePmmumuXQXGVwvDAmNFJG27xUcVUKYdmLUrXTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZtcm0Ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0060AC4CEE7;
	Mon, 12 May 2025 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747067857;
	bh=r5v3ana5WMmi48l7ra/A2/znuDGHAIJEO2qZ1UVLBC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZtcm0RiXRgZIFCvI6EUHqfTdHnd2bn4I88noehdo+PjDj27+b7yRQ6mm4kUyM6si
	 iRDejVvFgNDhWypwJYIeG5TuNJKsswzuI5HGo6Zsd6uir5kEN2aRfO7mG8N4q4i0AG
	 eq/cvEBD+oNUgBl5dOnCqE+0mM1Pc2GKNaF4l23gcS8UZCIbyKWjwUMjzE0YQ+4lKg
	 b7BCNbnXjKvJeE8Udy48Vq6LKGG4Uw3xGwUOAyJRQAcjYS5jZW30foWrPalpGaSa3d
	 iPgyDYqHN2AnWxRwM+Tvczjtx2esfuoAn7lv5ftbwWbgoXH0F4eP8VYhGFsBsLDIkt
	 vDYGUsBsxF1DA==
Date: Mon, 12 May 2025 17:37:32 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	bbhushan2@marvell.com, jerinj@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next v2 PATCH 2/2] octeontx2-pf: macsec: Get MACSEC
 capability flag from AF
Message-ID: <20250512163732.GS3339421@horms.kernel.org>
References: <1746969767-13129-1-git-send-email-sbhatta@marvell.com>
 <1746969767-13129-3-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746969767-13129-3-git-send-email-sbhatta@marvell.com>

On Sun, May 11, 2025 at 06:52:47PM +0530, Subbaraya Sundeep wrote:
> The presence of MACSEC block is currently figured out based
> on the running silicon variant. This may not be correct all
> the times since the MACSEC block can be fused out. Hence get
> the macsec info from AF via mailbox.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 7e3ddb0..7d0e39d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -631,9 +631,6 @@ static inline void otx2_setup_dev_hw_settings(struct otx2_nic *pfvf)
>  		__set_bit(CN10K_PTP_ONESTEP, &hw->cap_flag);
>  		__set_bit(QOS_CIR_PIR_SUPPORT, &hw->cap_flag);
>  	}
> -
> -	if (is_dev_cn10kb(pfvf->pdev))
> -		__set_bit(CN10K_HW_MACSEC, &hw->cap_flag);
>  }
>  
>  /* Register read/write APIs */
> @@ -1043,6 +1040,7 @@ void otx2_disable_napi(struct otx2_nic *pf);
>  irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq);
>  int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura);
>  int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx);
> +int otx2_set_hw_capabilities(struct otx2_nic *pfvf);
>  
>  /* RSS configuration APIs*/
>  int otx2_rss_init(struct otx2_nic *pfvf);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 0aee8e3..a8ad4a2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -3126,6 +3126,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (err)
>  		goto err_ptp_destroy;
>  
> +	otx2_set_hw_capabilities(pf);
> +
>  	err = cn10k_mcs_init(pf);
>  	if (err)
>  		goto err_del_mcam_entries;

Hi Subbaraya,

If I read things correctly otx2_setup_dev_hw_settings() is called
for both representors and non-representors, while otx2_probe is
only called for non-representors.

If so, my question is if this patch changes behaviour for representors.
And, again if so, if that is intentional.

