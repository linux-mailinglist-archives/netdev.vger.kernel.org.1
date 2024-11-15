Return-Path: <netdev+bounces-145282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD46B9CE083
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB3828C562
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B85D1D4333;
	Fri, 15 Nov 2024 13:44:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED601D433C
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678260; cv=none; b=UertwVy6kYYfnvPSEpMcLMLmcxTBYMCdO+zw9k9BNgb0LWNyr6zbAPQWXXR3jRvcTWP3jiDUCeuhIWiQgnfMLNGi3+MBJqL9nghbMe+dIjpZa9JkQJJ+F4boQ6eorrAeeR/qDkEOlizmeBZBsrlHkjhjmmZv0NN2cv1ccN17pW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678260; c=relaxed/simple;
	bh=UhBEdOSui9VyyiYzOcamZHyoZCLsv43+dZ9dHKwhbNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQcJy7TC8nmBbB3HiVDWV8ka/cw4+zBhga0B7VhAKNd+cj/BYeL7B5ou3jDejlFofqpz+taFWy2qSOpTVAtynR10akpRlt7viY0KkZ066DHFBZ/DexSgzFXWAzkWZ4zvMmyZzSzG1ymuTNX/cQWj3BK1yV/ud7I/3IDxdIb5P4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8244661E5FE05;
	Fri, 15 Nov 2024 14:43:45 +0100 (CET)
Message-ID: <4aa6f9f2-e3d9-4255-a964-c03d611d848e@molgen.mpg.de>
Date: Fri, 15 Nov 2024 14:43:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 01/10] idpf: initial PTP support
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-2-milena.olech@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241113154616.2493297-2-milena.olech@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Milena,


Thank you for your patch. It’d be great if you used a statement for the 
summary/title by adding a verb (in imperative mood):

idpf: Add initial PTP support

Am 13.11.24 um 16:46 schrieb Milena Olech:
> PTP feature is supported if the VIRTCHNL2_CAP_PTP is negotiated during the
> capabilities recognition. Initial PTP support includes PTP initialization
> and registration of the clock.

Maybe mention/paste the new debug messages, and document on what device 
you tested it?


Kind regards,

Paul


> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/Kconfig       |  1 +
>   drivers/net/ethernet/intel/idpf/Makefile      |  1 +
>   drivers/net/ethernet/intel/idpf/idpf.h        |  3 +
>   drivers/net/ethernet/intel/idpf/idpf_main.c   |  4 +
>   drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 89 +++++++++++++++++++
>   drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 32 +++++++
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  9 +-
>   7 files changed, 138 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
> 
> diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
> index 1addd663acad..2c359a8551c7 100644
> --- a/drivers/net/ethernet/intel/idpf/Kconfig
> +++ b/drivers/net/ethernet/intel/idpf/Kconfig
> @@ -4,6 +4,7 @@
>   config IDPF
>   	tristate "Intel(R) Infrastructure Data Path Function Support"
>   	depends on PCI_MSI
> +	depends on PTP_1588_CLOCK_OPTIONAL
>   	select DIMLIB
>   	select LIBETH
>   	help
> diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
> index 2ce01a0b5898..1f38a9d7125c 100644
> --- a/drivers/net/ethernet/intel/idpf/Makefile
> +++ b/drivers/net/ethernet/intel/idpf/Makefile
> @@ -17,3 +17,4 @@ idpf-y := \
>   	idpf_vf_dev.o
>   
>   idpf-$(CONFIG_IDPF_SINGLEQ)	+= idpf_singleq_txrx.o
> +idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_ptp.o
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 66544faab710..2e8b14dd9d96 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -530,6 +530,7 @@ struct idpf_vc_xn_manager;
>    * @vector_lock: Lock to protect vector distribution
>    * @queue_lock: Lock to protect queue distribution
>    * @vc_buf_lock: Lock to protect virtchnl buffer
> + * @ptp: Storage for PTP-related data
>    */
>   struct idpf_adapter {
>   	struct pci_dev *pdev;
> @@ -587,6 +588,8 @@ struct idpf_adapter {
>   	struct mutex vector_lock;
>   	struct mutex queue_lock;
>   	struct mutex vc_buf_lock;
> +
> +	struct idpf_ptp *ptp;
>   };
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index db476b3314c8..22d9e2646444 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -163,6 +163,10 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		goto err_free;
>   	}
>   
> +	err = pci_enable_ptm(pdev, NULL);
> +	if (err)
> +		pci_dbg(pdev, "PCIe PTM is not supported by PCIe bus/controller\n");
> +
>   	/* set up for high or low dma */
>   	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>   	if (err) {
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> new file mode 100644
> index 000000000000..1ac6367f5989
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 Intel Corporation */
> +
> +#include "idpf.h"
> +#include "idpf_ptp.h"
> +
> +/**
> + * idpf_ptp_create_clock - Create PTP clock device for userspace
> + * @adapter: Driver specific private structure
> + *
> + * This function creates a new PTP clock device.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int idpf_ptp_create_clock(const struct idpf_adapter *adapter)
> +{
> +	struct ptp_clock *clock;
> +
> +	/* Attempt to register the clock before enabling the hardware. */
> +	clock = ptp_clock_register(&adapter->ptp->info,
> +				   &adapter->pdev->dev);
> +	if (IS_ERR(clock)) {
> +		pci_err(adapter->pdev, "PTP clock creation failed: %pe\n", clock);
> +		return PTR_ERR(clock);
> +	}
> +
> +	adapter->ptp->clock = clock;
> +
> +	return 0;
> +}
> +
> +/**
> + * idpf_ptp_init - Initialize PTP hardware clock support
> + * @adapter: Driver specific private structure
> + *
> + * Set up the device for interacting with the PTP hardware clock for all
> + * functions. Function will allocate and register a ptp_clock with the
> + * PTP_1588_CLOCK infrastructure.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int idpf_ptp_init(struct idpf_adapter *adapter)
> +{
> +	int err;
> +
> +	if (!idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_PTP)) {
> +		pci_dbg(adapter->pdev, "PTP capability is not detected\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	adapter->ptp = kzalloc(sizeof(*adapter->ptp), GFP_KERNEL);
> +	if (!adapter->ptp)
> +		return -ENOMEM;
> +
> +	/* add a back pointer to adapter */
> +	adapter->ptp->adapter = adapter;
> +
> +	err = idpf_ptp_create_clock(adapter);
> +	if (err)
> +		goto free_ptp;
> +
> +	pci_dbg(adapter->pdev, "PTP init successful\n");
> +
> +	return 0;
> +
> +free_ptp:
> +	kfree(adapter->ptp);
> +	adapter->ptp = NULL;
> +
> +	return err;
> +}
> +
> +/**
> + * idpf_ptp_release - Clear PTP hardware clock support
> + * @adapter: Driver specific private structure
> + */
> +void idpf_ptp_release(struct idpf_adapter *adapter)
> +{
> +	struct idpf_ptp *ptp = adapter->ptp;
> +
> +	if (!ptp)
> +		return;
> +
> +	if (ptp->clock)
> +		ptp_clock_unregister(ptp->clock);
> +
> +	kfree(ptp);
> +	adapter->ptp = NULL;
> +}
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
> new file mode 100644
> index 000000000000..cb19988ca60f
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2024 Intel Corporation */
> +
> +#ifndef _IDPF_PTP_H
> +#define _IDPF_PTP_H
> +
> +#include <linux/ptp_clock_kernel.h>
> +
> +/**
> + * struct idpf_ptp - PTP parameters
> + * @info: structure defining PTP hardware capabilities
> + * @clock: pointer to registered PTP clock device
> + * @adapter: back pointer to the adapter
> + */
> +struct idpf_ptp {
> +	struct ptp_clock_info info;
> +	struct ptp_clock *clock;
> +	struct idpf_adapter *adapter;
> +};
> +
> +#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
> +int idpf_ptp_init(struct idpf_adapter *adapter);
> +void idpf_ptp_release(struct idpf_adapter *adapter);
> +#else /* CONFIG_PTP_1588_CLOCK */
> +static inline int idpf_ptp_init(struct idpf_adapter *adpater)
> +{
> +	return 0;
> +}
> +
> +static inline void idpf_ptp_release(struct idpf_adapter *adpater) { }
> +#endif /* CONFIG_PTP_1588_CLOCK */
> +#endif /* _IDPF_PTP_H */
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index d46c95f91b0d..c73c38511ea3 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -5,6 +5,7 @@
>   
>   #include "idpf.h"
>   #include "idpf_virtchnl.h"
> +#include "idpf_ptp.h"
>   
>   #define IDPF_VC_XN_MIN_TIMEOUT_MSEC	2000
>   #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
> @@ -896,7 +897,8 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
>   			    VIRTCHNL2_CAP_MACFILTER		|
>   			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
>   			    VIRTCHNL2_CAP_PROMISC		|
> -			    VIRTCHNL2_CAP_LOOPBACK);
> +			    VIRTCHNL2_CAP_LOOPBACK		|
> +			    VIRTCHNL2_CAP_PTP);
>   
>   	xn_params.vc_op = VIRTCHNL2_OP_GET_CAPS;
>   	xn_params.send_buf.iov_base = &caps;
> @@ -3025,6 +3027,10 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
>   		goto err_intr_req;
>   	}
>   
> +	err = idpf_ptp_init(adapter);
> +	if (err)
> +		pci_err(adapter->pdev, "PTP init failed, err=%pe\n", ERR_PTR(err));
> +
>   	idpf_init_avail_queues(adapter);
>   
>   	/* Skew the delay for init tasks for each function based on fn number
> @@ -3080,6 +3086,7 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
>   	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
>   		return;
>   
> +	idpf_ptp_release(adapter);
>   	idpf_deinit_task(adapter);
>   	idpf_intr_rel(adapter);
>   	idpf_vc_xn_shutdown(adapter->vcxn_mngr);

