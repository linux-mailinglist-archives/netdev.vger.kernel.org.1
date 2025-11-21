Return-Path: <netdev+bounces-240679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C7C779E6
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 07:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3196734F285
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D778335099;
	Fri, 21 Nov 2025 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNHiwlwI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B009334C07;
	Fri, 21 Nov 2025 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708064; cv=none; b=jB9UAUt6NQYK621baryOiFsJAujosq/QHjo5vFhkjApVgqdqQweqQzdHWlWEAlwIuZsE8M2I+jBCrUP/uVmCwCt6iBu8plrL9vfBH2OB032r0NBtcbz9i+JfBMUCYSjTgivV8Qhgpv6B8Qk0FnflD1foU+HLa9VmRcMYl25z+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708064; c=relaxed/simple;
	bh=UoanuHaH3kDT9dVLP/jEcuIEoiZk2BFtm8HM/KO5F20=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwYZG9XU0kuEuQaigVi7a5ZioIcsWzl/DWYijQYjVZP1I4D79z/wfYYoYqnIZgzqIDgBdBwOYxkA4QoRZgzfx9lVAz0P56jXLM2MXzGqkHX8X89Zr+v7O4W6Dfl8frxc7mo9bl6K3a18dUg7KZkube9GTC+vHqBxhbWKXY3x+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNHiwlwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9383EC4CEFB;
	Fri, 21 Nov 2025 06:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763708063;
	bh=UoanuHaH3kDT9dVLP/jEcuIEoiZk2BFtm8HM/KO5F20=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fNHiwlwIBMtDe3DRlEaZMy1upZfs4R3lun+TfS2clY/Cul6iIC0Ih4hsF2l4ikNvH
	 IUKiOkv/L/zaSGpnZQVkc2+dDWvr8zhR9kCDF5K8uB2ytG3vIhdQAWyT/fAk5fD2uN
	 S1rXvho2CtS6a4jMo9TPxN45hYj/2g8uY+vPFHrvGbuZtfYSLHtD++MLbnC+jdITKg
	 pv69nmcON2R0LQj734sLg0xtdYFerrHsY5vd0Iv2XwV3YaPDuUL11SVoOqBAVuoKID
	 84xAy9cIWMomb0q6oP7sgWm4ViYfFXjuTx+LBefDwNNi0hWEO34djYOfJrVRwhvp4H
	 AmlTlCL4C0gdg==
Message-ID: <93fdd5d5ded2260c612875943adab8fcfffc3064.camel@kernel.org>
Subject: Re: [PATCH v21 08/23] cxl/sfc: Map cxl component regs
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, 
	netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, 	dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>, Edward Cree
 <ecree.xilinx@gmail.com>,  Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
Date: Thu, 20 Nov 2025 22:54:22 -0800
In-Reply-To: <20251119192236.2527305-9-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
	 <20251119192236.2527305-9-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
wrote:

Hi Alejandro,

> From: Alejandro Lucero <alucerop@amd.com>
>=20
> Export cxl core functions for a Type2 driver being able to discover
> and
> map the device component registers.
>=20
> Use it in sfc driver cxl initialization.
>=20
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
> =C2=A0drivers/cxl/core/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/cxl/core/pci_drv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/cxl/core/port.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/cxl/core/regs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/cxl/cxl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ------
> =C2=A0drivers/cxl/cxlpci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ----------
> =C2=A0drivers/net/ethernet/sfc/efx_cxl.c | 35
> ++++++++++++++++++++++++++++++
> =C2=A0include/cxl/cxl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 19 +++++++++++++++=
+
> =C2=A0include/cxl/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++++++++++=
+++
> =C2=A09 files changed, 79 insertions(+), 19 deletions(-)
> =C2=A0create mode 100644 include/cxl/pci.h
>=20
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 566d57ba0579..90a0763e72c4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -6,6 +6,7 @@
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/pci.h>
> =C2=A0#include <linux/pci-doe.h>
> +#include <cxl/pci.h>
> =C2=A0#include <linux/aer.h>
> =C2=A0#include <cxlpci.h>
> =C2=A0#include <cxlmem.h>
> diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
> index a35e746e6303..4c767e2471b8 100644
> --- a/drivers/cxl/core/pci_drv.c
> +++ b/drivers/cxl/core/pci_drv.c
> @@ -11,6 +11,7 @@
> =C2=A0#include <linux/pci.h>
> =C2=A0#include <linux/aer.h>
> =C2=A0#include <linux/io.h>
> +#include <cxl/pci.h>
> =C2=A0#include <cxl/mailbox.h>
> =C2=A0#include <cxl/cxl.h>
> =C2=A0#include "cxlmem.h"
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d19ebf052d76..7c828c75e7b8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -11,6 +11,7 @@
> =C2=A0#include <linux/idr.h>
> =C2=A0#include <linux/node.h>
> =C2=A0#include <cxl/einj.h>
> +#include <cxl/pci.h>
> =C2=A0#include <cxlmem.h>
> =C2=A0#include <cxlpci.h>
> =C2=A0#include <cxl.h>
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index fc7fbd4f39d2..dcf444f1fe48 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -4,6 +4,7 @@
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/pci.h>
> +#include <cxl/pci.h>
> =C2=A0#include <cxlmem.h>
> =C2=A0#include <cxlpci.h>
> =C2=A0#include <pmu.h>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 536c9d99e0e6..d7ddca6f7115 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -39,10 +39,6 @@ extern const struct nvdimm_security_ops
> *cxl_security_ops;
> =C2=A0#define=C2=A0=C2=A0 CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
> =C2=A0#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
> =C2=A0
> -#define=C2=A0=C2=A0 CXL_CM_CAP_CAP_ID_RAS 0x2
> -#define=C2=A0=C2=A0 CXL_CM_CAP_CAP_ID_HDM 0x5
> -#define=C2=A0=C2=A0 CXL_CM_CAP_CAP_HDM_VERSION 1
> -
> =C2=A0/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability
> Structure */
> =C2=A0#define CXL_HDM_DECODER_CAP_OFFSET 0x0
> =C2=A0#define=C2=A0=C2=A0 CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> @@ -206,9 +202,6 @@ void cxl_probe_component_regs(struct device *dev,
> void __iomem *base,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cxl_component_reg_map *map=
);
> =C2=A0void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> =C2=A0			=C2=A0=C2=A0 struct cxl_device_reg_map *map);
> -int cxl_map_component_regs(const struct cxl_register_map *map,
> -			=C2=A0=C2=A0 struct cxl_component_regs *regs,
> -			=C2=A0=C2=A0 unsigned long map_mask);
> =C2=A0int cxl_map_device_regs(const struct cxl_register_map *map,
> =C2=A0			struct cxl_device_regs *regs);
> =C2=A0int cxl_map_pmu_regs(struct cxl_register_map *map, struct
> cxl_pmu_regs *regs);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 24aba9ff6d2e..53760ce31af8 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -13,16 +13,6 @@
> =C2=A0 */
> =C2=A0#define CXL_PCI_DEFAULT_MAX_VECTORS 16
> =C2=A0
> -/* Register Block Identifier (RBI) */
> -enum cxl_regloc_type {
> -	CXL_REGLOC_RBI_EMPTY =3D 0,
> -	CXL_REGLOC_RBI_COMPONENT,
> -	CXL_REGLOC_RBI_VIRT,
> -	CXL_REGLOC_RBI_MEMDEV,
> -	CXL_REGLOC_RBI_PMU,
> -	CXL_REGLOC_RBI_TYPES
> -};
> -
> =C2=A0/*
> =C2=A0 * Table Access DOE, CDAT Read Entry Response
> =C2=A0 *
> @@ -100,6 +90,4 @@ static inline void
> cxl_uport_init_ras_reporting(struct cxl_port *port,
> =C2=A0						struct device *host)
> { }
> =C2=A0#endif
> =C2=A0
> -int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type
> type,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cxl_register_map *map);
> =C2=A0#endif /* __CXL_PCI_H__ */
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
> b/drivers/net/ethernet/sfc/efx_cxl.c
> index 8e0481d8dced..34126bc4826c 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -7,6 +7,8 @@
> =C2=A0
> =C2=A0#include <linux/pci.h>
> =C2=A0
> +#include <cxl/cxl.h>
> +#include <cxl/pci.h>
> =C2=A0#include "net_driver.h"
> =C2=A0#include "efx_cxl.h"
> =C2=A0
> @@ -18,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> =C2=A0	struct pci_dev *pci_dev =3D efx->pci_dev;
> =C2=A0	struct efx_cxl *cxl;
> =C2=A0	u16 dvsec;
> +	int rc;
> =C2=A0
> =C2=A0	probe_data->cxl_pio_initialised =3D false;
> =C2=A0
> @@ -44,6 +47,38 @@ int efx_cxl_init(struct efx_probe_data
> *probe_data)
> =C2=A0	if (!cxl)
> =C2=A0		return -ENOMEM;
> =C2=A0
> +	rc =3D cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxl->cxlds.reg_map);
> +	if (rc) {
> +		pci_err(pci_dev, "No component registers\n");
> +		return rc;
> +	}
> +
> +	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
> +		pci_err(pci_dev, "Expected HDM component register
> not found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!cxl->cxlds.reg_map.component_map.ras.valid) {
> +		pci_err(pci_dev, "Expected RAS component register
> not found\n");
> +		return -ENODEV;
> +	}
> +
> +	rc =3D cxl_map_component_regs(&cxl->cxlds.reg_map,
> +				=C2=A0=C2=A0=C2=A0 &cxl->cxlds.regs.component,
> +				=C2=A0=C2=A0=C2=A0 BIT(CXL_CM_CAP_CAP_ID_RAS));

I'm going to reiterate a previous concern here with this.  When all of
this was in the CXL core, the CXL core owned whatever BAR these
registers were in in its entirety.  Now with a Type2 device, splitting
this out has implications.

The cxl_map_component_regs() is going to try and map the register map
you request as a reserved resource, which will fail if this Type2
driver has the BAR mapped (which basically all of these drivers do).

I think it's worth either a big comment or something explicit in the
patch description that calls this limitation or restriction out. =C2=A0
Hardware designers will be caught off-guard if they design their
hardware where the CXL component regs are in a BAR shared by other
register maps in their devices.  If they land the CXL regs in the
middle of that BAR, they will have to do some serious gymnastics in the
drivers to map pieces of their BAR to allow the kernel to map the
component regs.  OR...they can have some breadcrumbs to try and design
the HW where the CXL component regs are at the very beginning or very
end of their BAR.  That way drivers have an easier way to reserve a
subset of a contiguous BAR, and allow the kernel to grab the remainder
for CXL access and management.

I think this is a pretty serious implication that I don't see a way
around.  But letting a HW designer fall into this hole and realize they
can only fix it with a horrible set of driver hacks, or a silicon
respin, really sucks.

Cheers,
-PJ

> +	if (rc) {
> +		pci_err(pci_dev, "Failed to map RAS capability.\n");
> +		return rc;
> +	}
> +
> +	/*
> +	 * Set media ready explicitly as there are neither mailbox
> for checking
> +	 * this state nor the CXL register involved, both not
> mandatory for
> +	 * type2.
> +	 */
> +	cxl->cxlds.media_ready =3D true;
> +
> =C2=A0	probe_data->cxl =3D cxl;
> =C2=A0
> =C2=A0	return 0;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 13d448686189..7f2e23bce1f7 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -70,6 +70,10 @@ struct cxl_regs {
> =C2=A0	);
> =C2=A0};
> =C2=A0
> +#define=C2=A0=C2=A0 CXL_CM_CAP_CAP_ID_RAS 0x2
> +#define=C2=A0=C2=A0 CXL_CM_CAP_CAP_ID_HDM 0x5
> +#define=C2=A0=C2=A0 CXL_CM_CAP_CAP_HDM_VERSION 1
> +
> =C2=A0struct cxl_reg_map {
> =C2=A0	bool valid;
> =C2=A0	int id;
> @@ -223,4 +227,19 @@ struct cxl_dev_state
> *_devm_cxl_dev_state_create(struct device *dev,
> =C2=A0		(drv_struct *)_devm_cxl_dev_state_create(parent,
> type, serial, dvsec,	\
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> sizeof(drv_struct), mbox);	\
> =C2=A0	})
> +
> +/**
> + * cxl_map_component_regs - map cxl component registers
> + *
> + * @map: cxl register map to update with the mappings
> + * @regs: cxl component registers to work with
> + * @map_mask: cxl component regs to map
> + *
> + * Returns integer: success (0) or error (-ENOMEM)
> + *
> + * Made public for Type2 driver support.
> + */
> +int cxl_map_component_regs(const struct cxl_register_map *map,
> +			=C2=A0=C2=A0 struct cxl_component_regs *regs,
> +			=C2=A0=C2=A0 unsigned long map_mask);
> =C2=A0#endif /* __CXL_CXL_H__ */
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 000000000000..a172439f08c6
> --- /dev/null
> +++ b/include/cxl/pci.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +
> +#ifndef __CXL_CXL_PCI_H__
> +#define __CXL_CXL_PCI_H__
> +
> +/* Register Block Identifier (RBI) */
> +enum cxl_regloc_type {
> +	CXL_REGLOC_RBI_EMPTY =3D 0,
> +	CXL_REGLOC_RBI_COMPONENT,
> +	CXL_REGLOC_RBI_VIRT,
> +	CXL_REGLOC_RBI_MEMDEV,
> +	CXL_REGLOC_RBI_PMU,
> +	CXL_REGLOC_RBI_TYPES
> +};
> +
> +struct cxl_register_map;
> +
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type
> type,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cxl_register_map *map);
> +#endif

