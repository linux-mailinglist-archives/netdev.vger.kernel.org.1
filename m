Return-Path: <netdev+bounces-140965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA86E9B8E84
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CBB1C20F41
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C9A156220;
	Fri,  1 Nov 2024 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxqqZnd9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E5143C72;
	Fri,  1 Nov 2024 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455450; cv=none; b=MNCZU69LmAIQ9NyGuEaA1FaJaVj/OWhD8hYoS+UlXhYbsnimeLeMGfX1D/p558X2E3FZ1P1i7ZPa66hRDv5Jytc7S1+qby6bB5bcpBf1JIoKw3VGAWpZNV363drSMiZTv+fEjMKOJheHFGcLiFa+iaGewfeml8X6BgybG7bXkOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455450; c=relaxed/simple;
	bh=Rf8bkdBlxwr+7xHtx+gq94UWKa4xBxRh3LErQfhnuCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbpR56kEPhBH6DK4xTipjI2o5QLD83yD6VClG8m47IFXTC8LCZpytZnaWvdMh5zVw5r25HnDvrIHN5pLnVGmdQceQuzgTaENTbPT1pz02w4+ztUkVwBqk0xjEtqrZYgzEBJM0Rz/mgf7J9LAtqUWHsvjqEyGxEjNVS3a5tTyXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxqqZnd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED248C4CECD;
	Fri,  1 Nov 2024 10:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730455449;
	bh=Rf8bkdBlxwr+7xHtx+gq94UWKa4xBxRh3LErQfhnuCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxqqZnd9R34nT6j2WbLQ9Llzjrb28oDhV718cg1N6M9WqGXAdPRIQ/B3bYW8g8oaI
	 9EQprAApa5uc8pgkMNzzw+yuhaganwCOQ0PJXipRYGhm1AfaXeaDRx+QH8ZkbKZQfr
	 f1+fk666vIC8I5Fk5pmdzFnnV/EYzQw8r4aYkoO0GGCu5vGm1wzJkO5cJYa7UTSahg
	 ljgkwk2zKDqop6INAG6lXT7NdPUDKU9z4gAClARws8gRbtk0D8MAUlG01h138/Bcev
	 lRfqfp2XVcWbQxmXn+WUsdNxpFFrbWT09+1fYPncDr4yl7B8ZYGgzp0V/zykAjDzNO
	 Ywdg7zOT8oPhA==
Date: Fri, 1 Nov 2024 10:04:04 +0000
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [net-next PATCH v2 6/6] octeontx2-pf: CN20K mbox implementation
 between PF-VF
Message-ID: <20241101100404.GB1838431@kernel.org>
References: <20241022185410.4036100-1-saikrishnag@marvell.com>
 <20241022185410.4036100-7-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022185410.4036100-7-saikrishnag@marvell.com>

On Wed, Oct 23, 2024 at 12:24:10AM +0530, Sai Krishna wrote:
> This patch implements the CN20k MBOX communication between PF and
> it's VFs. CN20K silicon got extra interrupt of MBOX response for trigger
> interrupt. Also few of the CSR offsets got changed in CN20K against
> prior series of silicons.
> 
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 148a5c91af55..1a7920327fd5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -565,6 +565,23 @@ irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
>  	return IRQ_HANDLED;
>  }
>  
> +static void *cn20k_pfvf_mbox_alloc(struct otx2_nic *pf, int numvfs)
> +{
> +	struct qmem *mbox_addr;
> +	int err;
> +
> +	err = qmem_alloc(&pf->pdev->dev, &mbox_addr, numvfs, MBOX_SIZE);

Hi Sai and Sunil,

MBOX_SIZE is 0x10000 (i.e. 2^16).

But qmem_alloc() will assign this value to the entry_sz field of an
instance of struct qmem, whose type is u16. Thus the value will be
truncated to 0. I didn't dig further, but this doesn't seem desirable.

Flagged by Sparse on x86_64.

Also, not strictly related to this patchset: There Sparse flags
a handful of warnings in .../marvell/octeontx2/nic/otx2_pf.c,
which all seem to relate to __iomem annotations. It would be nice
to investigate and resolve those at some point.

> +	if (err) {
> +		dev_err(pf->dev, "qmem alloc fail\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	otx2_write64(pf, RVU_PF_VF_MBOX_ADDR, (u64)mbox_addr->iova);
> +	pf->pfvf_mbox_addr = mbox_addr;
> +
> +	return mbox_addr->base;
> +}
> +
>  static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
>  {
>  	void __iomem *hwbase;

...

