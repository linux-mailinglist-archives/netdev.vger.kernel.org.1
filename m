Return-Path: <netdev+bounces-107324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B48F991A901
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2B81F21132
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2105195380;
	Thu, 27 Jun 2024 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX9xtFGa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA321946DC
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497879; cv=none; b=K0q8it4v+ghPPBC/ek0ejO14wonyXejIuNm6roVCKWujv52v4o1ODjkeFUYi51lvPgR1Fl0vsvGF42RWVtN88Usz5HoItMEisCeDP7v7I9PZCeg+aCIMVXyw2v2Lxk1xN2Eozfv6nuBYLGRN4a4hHfeLgAJwSSBrozMUy9ZuiW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497879; c=relaxed/simple;
	bh=/zLM4zGONvDlGfVwFRXxRQODmfBcy+xPhKfn+QOxD/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX1SxzPKGjsi+MxvHjc35UpLEcmQRYamtXkaaN4WKOOMEHCRmPbyTJVB3C1+0KYiL9rwH3ww0LBjt024MxHnNIaOZVrqUQ7AjO6Ax6smFOAR9CDs/4cPcyxS4sRhFLFe+gzKdK9MDhF2G2pbH1hCJGjFgWQW/F94ca2mUQJR4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX9xtFGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E4BC32786;
	Thu, 27 Jun 2024 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719497879;
	bh=/zLM4zGONvDlGfVwFRXxRQODmfBcy+xPhKfn+QOxD/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KX9xtFGavS/tfeI9Xf0TuU6XgqOgoprFz21MI4FO9q1Wx+o4mwFcAideh9Ic2kfrj
	 6btv5Slji9cF+VexNI+SD02ZpHUu78DU2gq/sDVQpDB3+2WC/2C/0Cj4DP7IZrRzLz
	 Nj9so3JpMH0TgVx87cvlU+sxto4B6AL85VNSVfTKaNLjzsRk5qb2SvbvcF/SRoNReE
	 zvTtpeJY2ir0eY5JNFg/LxIlfk7D4iw6gUxZLLWpJ4E6WAhw/1UURk29vAXQOAelhh
	 bElTySrghGD56VClDgRhHeSydKvJ4gMnLcJ7w/wfmOBQbI53ev+4EudcPFs0G6LDBS
	 z+jQg9S2I8qIA==
Date: Thu, 27 Jun 2024 15:17:55 +0100
From: Simon Horman <horms@kernel.org>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc: netdev@vger.kernel.org, Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] bna: adjust 'name' buf size of bna_tcb and bna_ccb
 structures
Message-ID: <20240627141755.GG3104@kernel.org>
References: <20240625191433.452508-1-aleksei.kodanev@bell-sw.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625191433.452508-1-aleksei.kodanev@bell-sw.com>

+ Eric Dumazet, Jakub Kicinski, Paolo Abeni

On Tue, Jun 25, 2024 at 07:14:33PM +0000, Alexey Kodanev wrote:
> To have enough space to write all possible sprintf() args. Currently
> 'name' size is 16, but the first '%s' specifier may already need at
> least 16 characters, since 'bnad->netdev->name' is used there.
> 
> For '%d' specifiers, assume that they require:
>  * 1 char for 'tx_id + tx_info->tcb[i]->id' sum, BNAD_MAX_TXQ_PER_TX is 8
>  * 2 chars for 'rx_id + rx_info->rx_ctrl[i].ccb->id', BNAD_MAX_RXP_PER_RX
>    is 16
> 
> And replace sprintf with snprintf.
> 
> Detected using the static analysis tool - Svace.
> 
> Fixes: 8b230ed8ec96 ("bna: Brocade 10Gb Ethernet device driver")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

Thanks Alexey,

I agree that this change is a nice improvement.  And I verified that gcc-13
W=1 builds on x86_64 report warnings regarding the issues addressed by this
patch: the warnings are resolved by this patch.

But I do also wonder if we should consider removing this driver.
I don't see any non-trivial updates to it since
commit d667f78514c6 ("bna: Add synchronization for tx ring.")
a bug fix from November 2016 which was included in v4.9.

Although, perhaps your patch indicates this driver is being used :)

On process:

When posting patches for net or net-next, please generate a CC list using
./scripts/get_maintainer.pl your.patch

This does not seem to be a bug fix in the sense that it doesn't seem
to resolve a problem that manifests itself. If so, it should be targeted
at net-next rather than net.

Link: https://docs.kernel.org/process/maintainer-netdev.html

...

> ---
>  drivers/net/ethernet/brocade/bna/bna_types.h |  2 +-
>  drivers/net/ethernet/brocade/bna/bnad.c      | 11 ++++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/brocade/bna/bna_types.h b/drivers/net/ethernet/brocade/bna/bna_types.h
> index a5ebd7110e07..986f43d27711 100644
> --- a/drivers/net/ethernet/brocade/bna/bna_types.h
> +++ b/drivers/net/ethernet/brocade/bna/bna_types.h
> @@ -416,7 +416,7 @@ struct bna_ib {
>  /* Tx object */
>  
>  /* Tx datapath control structure */
> -#define BNA_Q_NAME_SIZE		16
> +#define BNA_Q_NAME_SIZE		(IFNAMSIZ + 6)
>  struct bna_tcb {
>  	/* Fast path */
>  	void			**sw_qpt;
> diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
> index fe121d36112d..3313a0d84466 100644
> --- a/drivers/net/ethernet/brocade/bna/bnad.c
> +++ b/drivers/net/ethernet/brocade/bna/bnad.c
> @@ -1534,8 +1534,9 @@ bnad_tx_msix_register(struct bnad *bnad, struct bnad_tx_info *tx_info,
>  
>  	for (i = 0; i < num_txqs; i++) {
>  		vector_num = tx_info->tcb[i]->intr_vector;
> -		sprintf(tx_info->tcb[i]->name, "%s TXQ %d", bnad->netdev->name,
> -				tx_id + tx_info->tcb[i]->id);
> +		snprintf(tx_info->tcb[i]->name, BNA_Q_NAME_SIZE, "%s TXQ %d",
> +			 bnad->netdev->name,
> +			 tx_id + tx_info->tcb[i]->id);
>  		err = request_irq(bnad->msix_table[vector_num].vector,
>  				  (irq_handler_t)bnad_msix_tx, 0,
>  				  tx_info->tcb[i]->name,
> @@ -1585,9 +1586,9 @@ bnad_rx_msix_register(struct bnad *bnad, struct bnad_rx_info *rx_info,
>  
>  	for (i = 0; i < num_rxps; i++) {
>  		vector_num = rx_info->rx_ctrl[i].ccb->intr_vector;
> -		sprintf(rx_info->rx_ctrl[i].ccb->name, "%s CQ %d",
> -			bnad->netdev->name,
> -			rx_id + rx_info->rx_ctrl[i].ccb->id);
> +		snprintf(rx_info->rx_ctrl[i].ccb->name, BNA_Q_NAME_SIZE, "%s CQ %d",

nit: This line could be trivially line wrapped so that it is less than 80
     columns wide, which is still preferred for Networking code.

     Flagged by /scripts/checkpatch.pl --max-line-length=80

> +			 bnad->netdev->name,
> +			 rx_id + rx_info->rx_ctrl[i].ccb->id);
>  		err = request_irq(bnad->msix_table[vector_num].vector,
>  				  (irq_handler_t)bnad_msix_rx, 0,
>  				  rx_info->rx_ctrl[i].ccb->name,
> -- 
> 2.25.1
> 
> 

