Return-Path: <netdev+bounces-199487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E076AE07ED
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E81317A4E25
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF87246760;
	Thu, 19 Jun 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="av4+OmRD"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD923506B
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341170; cv=none; b=sG2yeqsbzLexg6gwGlKj78mcAaIFkf7pzZeJ8Fs97bxpl4Nd3nhV8EA+Nr8Rw7D4byVd/Wg3keSkh3Xn3zu6FVfNGizBRh4Ycs3yWZNFjThh5sKG3Q0/303d80VBSSF69ikBBM3F/d4wqvgvxUs9mzCA0gNJdKtfb/niP/H2lac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341170; c=relaxed/simple;
	bh=KlWCnrG2pcFyN2r4WxhaR37seXMfDMA5dGyqsjtIJgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D514U4OJW+mthndfeexDp3R7aAZcMFkLw14lsLUJJ1vN3FHJH2YSGuuscYtT/DLzOYAqhM1z2YLdNyThfG8ryh+dyYTMc3BbCymakndmIhCkqRdpWV30dQYokOQdU+/WflYgitFFU+cU4X2HYCTFHlAdRAlCC2xBRD0pBJNnrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=av4+OmRD; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b66ab3f7-1445-48e2-b98b-7c148a2d3458@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750341162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7YslRkGDK06+xxHmYFyQDvRKh94OPt/kpw2EYZpHxg=;
	b=av4+OmRDusRAU3qoIwLrvCo2cha8e4GoKjxIO/QbieREwXv3XQeDOAaBm3mteisQaAyrwk
	6EozMhcF6MxlgIHLaRVX2WKut+QcV6+z6MKbHyWT2BpxIMpwjS4x7obbrRvgDODR8nQ6y8
	JrzkjfPbjpQenc5ejBgOFQ5lYYTuxVU=
Date: Thu, 19 Jun 2025 14:52:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next, 08/10] bng_en: Add irq allocation support
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com,
 Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
 <20250618144743.843815-9-vikas.gupta@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250618144743.843815-9-vikas.gupta@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/06/2025 15:47, Vikas Gupta wrote:
> Add irq allocation functions. This will help
> to allocate IRQs to both netdev and RoCE aux devices.
> 
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnge/bnge.h     |  3 +
>   .../net/ethernet/broadcom/bnge/bnge_resc.c    | 69 +++++++++++++++++++
>   .../net/ethernet/broadcom/bnge/bnge_resc.h    | 13 ++++
>   3 files changed, 85 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
> index b58d8fc6f258..3c161b1a9b62 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
> @@ -172,6 +172,9 @@ struct bnge_dev {
>   #define BNGE_SUPPORTS_TPA(bd)	((bd)->max_tpa_v2)
>   
>   	u8                      num_tc;
> +
> +	struct bnge_irq		*irq_tbl;
> +	u16			irqs_acquired;
>   };
>   
>   static inline bool bnge_is_roce_en(struct bnge_dev *bd)
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> index 68e094474822..84f91e05a2b0 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> @@ -326,3 +326,72 @@ int bnge_reserve_rings(struct bnge_dev *bd)
>   
>   	return rc;
>   }
> +
> +int bnge_alloc_irqs(struct bnge_dev *bd)
> +{
> +	u16 aux_msix, tx_cp, num_entries;
> +	u16 irqs_demand, max, min = 1;
> +	int i, rc = 0;

This assignment is not needed. Error paths re-assign proper error code
while normal flow re-assigns rc to the return value of
bnge_adjust_rings()

> +
> +	irqs_demand = bnge_nqs_demand(bd);
> +	max = bnge_get_max_func_irqs(bd);
> +	if (irqs_demand > max)
> +		irqs_demand = max;
> +
> +	if (!(bd->flags & BNGE_EN_SHARED_CHNL))
> +		min = 2;
> +
> +	irqs_demand = pci_alloc_irq_vectors(bd->pdev, min, irqs_demand,
> +					    PCI_IRQ_MSIX);
> +	aux_msix = bnge_aux_get_msix(bd);
> +	if (irqs_demand < 0 || irqs_demand < aux_msix) {
> +		rc = -ENODEV;
> +		goto err_free_irqs;
> +	}
> +
> +	num_entries = irqs_demand;
> +	if (pci_msix_can_alloc_dyn(bd->pdev))
> +		num_entries = max;
> +	bd->irq_tbl = kcalloc(num_entries, sizeof(*bd->irq_tbl), GFP_KERNEL);
> +	if (!bd->irq_tbl) {
> +		rc = -ENOMEM;
> +		goto err_free_irqs;
> +	}
> +
> +	for (i = 0; i < irqs_demand; i++)
> +		bd->irq_tbl[i].vector = pci_irq_vector(bd->pdev, i);
> +
> +	bd->irqs_acquired = irqs_demand;
> +	/* Reduce rings based upon num of vectors allocated.
> +	 * We dont need to consider NQs as they have been calculated
> +	 * and must be more than irqs_demand.
> +	 */
> +	rc = bnge_adjust_rings(bd, &bd->rx_nr_rings,
> +			       &bd->tx_nr_rings,
> +			       irqs_demand - aux_msix, min == 1);
> +	if (rc)
> +		goto err_free_irqs;
> +
> +	tx_cp = bnge_num_tx_to_cp(bd, bd->tx_nr_rings);
> +	bd->nq_nr_rings = (min == 1) ?
> +		max_t(u16, tx_cp, bd->rx_nr_rings) :
> +		tx_cp + bd->rx_nr_rings;
> +
> +	/* Readjust tx_nr_rings_per_tc */
> +	if (!bd->num_tc)
> +		bd->tx_nr_rings_per_tc = bd->tx_nr_rings;
> +
> +	return 0;
> +
> +err_free_irqs:
> +	dev_err(bd->dev, "Failed to allocate IRQs err = %d\n", rc);
> +	bnge_free_irqs(bd);
> +	return rc;
> +}

[...]

