Return-Path: <netdev+bounces-155037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 363F8A00BF8
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 17:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7366F1883DF7
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B1A1FAC54;
	Fri,  3 Jan 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QKkMte/r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0BB192B88;
	Fri,  3 Jan 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921247; cv=none; b=HobN7Mrpdhn7fDSKNjE0ixtYUubDEwAY3gDCo9X4sYBcGIQey2k9owzmwnqCG8s3n8gq2/qYcmH/PYkG1FV4fZD1aO761IMbrQo/+vuAbex2Jn4i74yxN8cH/Q3J3aeZRFiwgYcTONzpq/qseioS8RyonS0OHkxxY5XSMDYwGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921247; c=relaxed/simple;
	bh=s/azmUCMfyDwbtYMhSXYBEe/qseumADYqEPrgpJX78A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2ZMhOyQ1Cd8Y8fHOt/gOajUPNXEhjVSERgt/yp1eMt3mW4aMy7LvwX6bjpCFkfxzcdl6Pxo0brEIrQz8g/uO4h4vvCKbvi9rMljqGMnR1r++xGAeFi517+xAVyL0rxGJ2GwQqQvuyWx9qstakc3qd6havT30vCG+Tfachqt1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QKkMte/r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B2WYsGMPQpFANCHXxl2mkfQyQ24a8EKaADn28F99e5I=; b=QKkMte/rHHfXcBmU0nceXRubrn
	iQeMg4csyJfv3OOg9qe1ys9p6TcH3O+Uf7s16qM+6WDAiPySZIRXwyfDVd+723zmFSHs2cCwFF1NX
	kycyeuUZRyJC6CiabE2wIamZg+SUnhNRrzGWcz+ye5LemvpCn9yPnrtYm+GrJjRGMyYU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTkPb-0015Hv-95; Fri, 03 Jan 2025 17:20:35 +0100
Date: Fri, 3 Jan 2025 17:20:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net-next 01/13] net: enetc: add initial netc-lib driver
 to support NTMP
Message-ID: <829ccd93-8b4e-4dd9-bd15-58d345797aca@lunn.ch>
References: <20250103060610.2233908-1-wei.fang@nxp.com>
 <20250103060610.2233908-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103060610.2233908-2-wei.fang@nxp.com>

> +#define NTMP_FILL_CRD(crd, tblv, qa, ua) \
> +({ \
> +	typeof(crd) _crd = (crd); \
> +	(_crd)->update_act = cpu_to_le16(ua); \
> +	(_crd)->tblv_qact = NTMP_TBLV_QACT(tblv, qa); \
> +})
> +
> +#define NTMP_FILL_CRD_EID(req, tblv, qa, ua, eid) \
> +({ \
> +	typeof(req) _req = (req); \
> +	NTMP_FILL_CRD(&(_req)->crd, tblv, qa, ua); \
> +	(_req)->entry_id = cpu_to_le32(eid); \
> +})


These are pretty complex for #defines. Can they be made into
functions? That will get you type checking, finding bugs where
parameters are swapped.

> +int netc_setup_cbdr(struct device *dev, int cbd_num,
> +		    struct netc_cbdr_regs *regs,
> +		    struct netc_cbdr *cbdr)
> +{
> +	int size;
> +
> +	size = cbd_num * sizeof(union netc_cbd) + NTMP_BASE_ADDR_ALIGN;
> +
> +	cbdr->addr_base = dma_alloc_coherent(dev, size, &cbdr->dma_base,
> +					     GFP_KERNEL);
> +	if (!cbdr->addr_base)
> +		return -ENOMEM;
> +
> +	cbdr->dma_size = size;
> +	cbdr->bd_num = cbd_num;
> +	cbdr->regs = *regs;
> +
> +	/* The base address of the Control BD Ring must be 128 bytes aligned */
> +	cbdr->dma_base_align =  ALIGN(cbdr->dma_base,  NTMP_BASE_ADDR_ALIGN);
> +	cbdr->addr_base_align = PTR_ALIGN(cbdr->addr_base,
> +					  NTMP_BASE_ADDR_ALIGN);
> +
> +	cbdr->next_to_clean = 0;
> +	cbdr->next_to_use = 0;
> +	spin_lock_init(&cbdr->ring_lock);
> +
> +	/* Step 1: Configure the base address of the Control BD Ring */
> +	netc_write(cbdr->regs.bar0, lower_32_bits(cbdr->dma_base_align));
> +	netc_write(cbdr->regs.bar1, upper_32_bits(cbdr->dma_base_align));
> +
> +	/* Step 2: Configure the producer index register */
> +	netc_write(cbdr->regs.pir, cbdr->next_to_clean);
> +
> +	/* Step 3: Configure the consumer index register */
> +	netc_write(cbdr->regs.cir, cbdr->next_to_use);
> +
> +	/* Step4: Configure the number of BDs of the Control BD Ring */
> +	netc_write(cbdr->regs.lenr, cbdr->bd_num);
> +
> +	/* Step 5: Enable the Control BD Ring */
> +	netc_write(cbdr->regs.mr, NETC_CBDR_MR_EN);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(netc_setup_cbdr);

I assume there is a version 3 in development, which will need a
different library, or at least different symbols. Maybe you should
think about the naming issues now?

> diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
> new file mode 100644
> index 000000000000..7cf322a1c8e3
> --- /dev/null
> +++ b/include/linux/fsl/ntmp.h
> @@ -0,0 +1,178 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/* Copyright 2025 NXP */
> +#ifndef __NETC_NTMP_H
> +#define __NETC_NTMP_H

Does this header need to be global? What else will use it outside of
drivers/net/ethernet/freescale/enetc?

	Andrew

