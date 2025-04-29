Return-Path: <netdev+bounces-186836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7EAAA1B68
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEA14C1B82
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 19:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB8E25E811;
	Tue, 29 Apr 2025 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHkJlQqn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BC125E804;
	Tue, 29 Apr 2025 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745955457; cv=none; b=hEW5joOXtRjNJohCmG1DolphzjuRW9Cn/ao8f5UaRULjU9H8b0YxG733caPiVPgzRJtr666dmwiOVRLURszmqBSbHOt0wrJMh0+R9SLb9QRqahjA1HsXc7ei+BAQFe0PJZK/GOInQA0tCk2ubp/pxtp40Zsh2X9weeCEWkE0b0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745955457; c=relaxed/simple;
	bh=bcQ6ggXhA+20+2g+Gt7SRLr81BmWL9xrtvyv2Yi0MD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLJ3qWzzhH8mRPpnVxsyIh19I85SR++ewtw4nT/NDMrrB3K6FoHm+vsk/sfddHrWS+cUr/74NeCozHZCP2PMn5clgMrlzAk/zMM314OSZDikan6Z3oXSXq22K8kwgnLPfzXEd8Ttj20tsDpv77bat6GCq3s/ApvDM/DXT08Hauk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHkJlQqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B56C4CEE3;
	Tue, 29 Apr 2025 19:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745955457;
	bh=bcQ6ggXhA+20+2g+Gt7SRLr81BmWL9xrtvyv2Yi0MD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XHkJlQqnYIK/+qsalZvV5OL0S81eZQrD8PyhqiaqaC3GmnvRoj59ljAoI8XNJ9Cbs
	 HhfyaP4LJnnp+Ip3B3b6h8KQS5ST8t8RZ8TA8gqCDi/MZdnF/ZgiSG5YlvNpyo3AOo
	 +A0eFL+gr/PKqsOtO80rootbYc2XDaXD45IXCBHZ9ezP5U47nruIKprotuEskagzn8
	 4k443WmCHNVVdIh296zkNlKLva4i8WI0ECxVlm757RG1nljk9VNqtFcE64XcEOxB8v
	 YsL4yyWyokUyuBZFngmZVpc8uzfuPOgCOmUQ1ouC4NRJroIS/tg49CwOQDhoGwEYXl
	 CKR1LoAU20kwg==
Date: Tue, 29 Apr 2025 20:37:32 +0100
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com,
	Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: Re: [PATCH net-next v2 3/5] amd-xgbe: add support for new XPCS
 routines
Message-ID: <20250429193732.GQ3339421@horms.kernel.org>
References: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
 <20250428150235.2938110-4-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428150235.2938110-4-Raju.Rangoju@amd.com>

On Mon, Apr 28, 2025 at 08:32:33PM +0530, Raju Rangoju wrote:
> Add the necessary support to enable Crater ethernet device. Since the
> BAR1 address cannot be used to access the XPCS registers on Crater, use
> the smn functions.
> 
> Some of the ethernet add-in-cards have dual PHY but share a single MDIO
> line (between the ports). In such cases, link inconsistencies are
> noticed during the heavy traffic and during reboot stress tests. Using
> smn calls helps avoid such race conditions.
> 
> Suggested-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
> - PCI config accesses can race with other drivers performing SMN accesses
>   so, fall back to AMD SMN API to avoid race.
> 
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 81 ++++++++++++++++++++++++
>  drivers/net/ethernet/amd/xgbe/xgbe-smn.h | 30 +++++++++
>  drivers/net/ethernet/amd/xgbe/xgbe.h     |  6 ++
>  3 files changed, 117 insertions(+)
>  create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index 765f20b24722..5f367922e705 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -14,6 +14,7 @@

Hi Raju,

I think you need the following about here:

#include <linux/pci.h>

To make sure that pci_err(), which is used elsewhere in this patch,
is always defined. Building allmodconfig for arm and arm64 shows
that, without this change, pci_err is not defined.

Alternatively, perhaps netdev_err can be used instead of pci_err().

>  
>  #include "xgbe.h"
>  #include "xgbe-common.h"
> +#include "xgbe-smn.h"
>  
>  static inline unsigned int xgbe_get_max_frame(struct xgbe_prv_data *pdata)
>  {
> @@ -1066,6 +1067,80 @@ static void xgbe_get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
>  	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>  }
>  
> +static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
> +				 int mmd_reg)
> +{
> +	unsigned int mmd_address, index, offset;
> +	int mmd_data;
> +	int ret;
> +
> +	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
> +
> +	xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
> +
> +	ret = amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);

nit: Please line wrap to 80 columns wide or less, as is still preferred for
     Networking code.  Likewise elsewhere in this patch.

     Flagged by checkpatch.pl --max-line-length=80

     Also, the inner parentheses seem to be unnecessary.

> +	if (ret)
> +		return ret;
> +
> +	ret = amd_smn_read(0, pdata->smn_base + offset, &mmd_data);
> +	if (ret)
> +		return ret;
> +
> +	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
> +				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
> +
> +	return mmd_data;
> +}
> +
> +static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
> +				   int mmd_reg, int mmd_data)
> +{
> +	unsigned int pci_mmd_data, hi_mask, lo_mask;
> +	unsigned int mmd_address, index, offset;
> +	struct pci_dev *dev;
> +	int ret;
> +
> +	dev = pdata->pcidev;
> +	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
> +
> +	xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
> +
> +	ret = amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
> +	if (ret) {
> +		pci_err(dev, "Failed to write data 0x%x\n", index);
> +		return;
> +	}
> +
> +	ret = amd_smn_read(0, pdata->smn_base + offset, &pci_mmd_data);
> +	if (ret) {
> +		pci_err(dev, "Failed to read data\n");
> +		return;
> +	}
> +
> +	if (offset % 4) {
> +		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data);
> +		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, pci_mmd_data);
> +	} else {
> +		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK,
> +				     FIELD_GET(XGBE_GEN_HI_MASK, pci_mmd_data));
> +		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
> +	}
> +
> +	pci_mmd_data = hi_mask | lo_mask;
> +
> +	ret = amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
> +	if (ret) {
> +		pci_err(dev, "Failed to write data 0x%x\n", index);
> +		return;
> +	}
> +
> +	ret = amd_smn_write(0, (pdata->smn_base + offset), pci_mmd_data);
> +	if (ret) {
> +		pci_err(dev, "Failed to write data 0x%x\n", pci_mmd_data);
> +		return;
> +	}
> +}

...

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-smn.h b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
> new file mode 100644
> index 000000000000..a1763aa648bd
> --- /dev/null
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)

Checkpatch says this should be:

/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause) */


> +/*
> + * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
> + * Copyright (c) 2014, Synopsys, Inc.
> + * All rights reserved
> + *
> + * Author: Raju Rangoju <Raju.Rangoju@amd.com>
> + */
> +
> +#ifndef __SMN_H__
> +#define __SMN_H__
> +
> +#ifdef CONFIG_AMD_NB
> +
> +#include <asm/amd_nb.h>
> +
> +#else
> +
> +static inline int amd_smn_write(u16 node, u32 address, u32 value)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int amd_smn_read(u16 node, u32 address, u32 *value)
> +{
> +	return -ENODEV;
> +}
> +
> +#endif
> +#endif

It feels a little odd to provide these dummy implementation here,
rather than where the real implementations are declared. But I do
see where you are coming from with this approach. And I guess it
is fine so long as this is the only user of this mechanism.

...

