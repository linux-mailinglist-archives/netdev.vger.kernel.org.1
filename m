Return-Path: <netdev+bounces-140969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E489B8EEE
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5B9EB2285C
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383281586F2;
	Fri,  1 Nov 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtZ6MkSZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B817C222;
	Fri,  1 Nov 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456334; cv=none; b=tDoHtde3OAb4O7OeLcVcf/PMjArXAKpHXJ614eUgA9nmRjNF0fudgUv3pEpspErGP17bwpDRc4yDF3gvOXjZe5CrTV4xuaiazv2Ns40UC1QChZacnq190yYdV+0oBo50bf4+bemOiZPT6sHVuYzYkoas7Ukdo4cnvCRoiIX/Ss8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456334; c=relaxed/simple;
	bh=91HgHQdlPnl+2yxTwemtCDmPgHq5QCFAF7klqhPUruA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLfBCyPjFtnDnnuPNMl2fbDfaQrQBfOpbxh4k0SJUQyyAP8T+jKTXOzJGiLbspjtsW1IlzDDYmR47jS5xh30EBkVZ3UZ9or4XcdsInOydJV7ot7BP/bkErfUaTLZEFoS7YwaPSI0NZvWlH4VTCjIJrsJO9u2JRQLEkMlIDO4u+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtZ6MkSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB439C4CECD;
	Fri,  1 Nov 2024 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730456333;
	bh=91HgHQdlPnl+2yxTwemtCDmPgHq5QCFAF7klqhPUruA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtZ6MkSZVdauJn/wXdDeAebAty2cy/vcp9hKTYFfLK5NRIPUZ4noA+OemEj2+OPMp
	 KGVlE/rKwatybahr0FOxDeHoSEjoAqZRg0ATTi97tSt00+heSV5YviNqB6tIkHmgWG
	 uDTu41SnM5icx5xLv+ZO+goRcrcHDGDasHjRf70zfAbRmkg7GMMKUm8bNyJVPG8Gtc
	 mprGF+cnTedUdYr28/tyck8b4/x0bjzZShE9ZVmb1uyZ+9Jnsi6RczSX9aAUiHntc0
	 Bzp50QcRDaK7f1RSr27T6gub0DgqbcMBn9wToDJV5jyEVzPjHFq/i4i0NeY57QRw39
	 Gz4UD0tcxbhWA==
Date: Fri, 1 Nov 2024 10:18:48 +0000
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [net-next PATCH v2 3/6] octeontx2-af: CN20k mbox to support AF
 REQ/ACK functionality
Message-ID: <20241101101848.GD1838431@kernel.org>
References: <20241022185410.4036100-1-saikrishnag@marvell.com>
 <20241022185410.4036100-4-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022185410.4036100-4-saikrishnag@marvell.com>

On Wed, Oct 23, 2024 at 12:24:07AM +0530, Sai Krishna wrote:
> This implementation uses separate trigger interrupts for request,
> response MBOX messages against using trigger message data in CN10K.
> This patch adds support for basic mbox implementation for CN20K
> from AF side.
> 
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>

...

>  #endif /* CN20K_API_H */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
> index 0e128013a03f..0c1ea6923043 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
> @@ -13,6 +13,137 @@
>  #include "reg.h"
>  #include "api.h"
>  
> +/* CN20K mbox PFx => AF irq handler */
> +static irqreturn_t cn20k_mbox_pf_common_intr_handler(int irq, void *rvu_irq)
> +{
> +	struct rvu_irq_data *rvu_irq_data = (struct rvu_irq_data *)rvu_irq;

Hi Sunil and Sai,

A minor nit from my side: I general there is no need to explicitly cast a
pointer to or from void *, and in Networking code it is preferred not to.

	struct rvu_irq_data *rvu_irq_data = rvu_irq;

> +	struct rvu *rvu = rvu_irq_data->rvu;
> +	u64 intr;
> +

...

