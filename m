Return-Path: <netdev+bounces-271172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGeLHHO9wmlflQQAu9opvQ
	(envelope-from <netdev+bounces-271172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:36:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6BE319184
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1435D30A8F16
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C933F20F9;
	Tue, 24 Mar 2026 16:29:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557DE3EFD10;
	Tue, 24 Mar 2026 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369755; cv=none; b=p1Pk793a4VzhlTaR500F4nVXqp5yS7ym6dojmgaGY4ewDRdwNdz7+M/eD+pF5XpwocgH0Iv4n1HtFWKnp5bYCjmQS5hCJXVca68TPrNJZy6msT3key7EFRv7wTuu2gBxdGCuTpaWKcHzhHXTln0nw9R8A66NMOTTRtpDh/dkEs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369755; c=relaxed/simple;
	bh=9i5+r43wgot8rXeHaRRN5+iMmydF3Di4i8lu7zeai6A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0rVhPzvcIl8x8SxreXZcVWy+jx2eUEDE2wZEWqCztw2NMn8f3TTkTVO2j1CT9r8V1twGIdnVRpwEvdpvzbDkY3JcOZ2ON+Ske9PR/ByOLrN7L4GPYWwvyG37PefYYh+CkVD9my0D9wz+KtSCII+NJAyXc4NEFiuKbOFmjQfgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgFpX28JdzHnGjJ;
	Wed, 25 Mar 2026 00:28:36 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id F0D5E4058B;
	Wed, 25 Mar 2026 00:29:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Mar
 2026 16:29:09 +0000
Date: Tue, 24 Mar 2026 16:29:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, Alejandro Lucero <alucerop@amd.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v24 01/11] sfc: add cxl support
Message-ID: <20260324162907.00000c84@huawei.com>
In-Reply-To: <20260323113117.2352709-2-alejandro.lucero-palau@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
	<20260323113117.2352709-2-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,amd.com,davemloft.net,kernel.org,redhat.com,google.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271172-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,amd.com:email,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: AD6BE319184
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 11:31:07 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Hi Alejandro,

Been a while since I looked at this, so I may well repeat earlier discussions!

One really minor thing inline.

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> new file mode 100644
> index 000000000000..8e0481d8dced
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + *
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/pci.h>
> +
> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> +
> +int efx_cxl_init(struct efx_probe_data *probe_data)
> +{
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl;
> +	u16 dvsec;
> +
> +	probe_data->cxl_pio_initialised = false;
> +
> +	/* Is the device configured with and using CXL? */
> +	if (!pcie_is_cxl(pci_dev))
> +		return 0;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec) {
> +		pci_err(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");

Trivial but if we are returning zero is it always an error?
Maybe pci_info() more appropriate?

> +		return 0;
> +	}
> +
> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
> +
> +	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
> +	 * specifying no mbox available.
> +	 */
> +	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
> +					pci_dev->dev.id, dvsec, struct efx_cxl,


