Return-Path: <netdev+bounces-227522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E35BB20E9
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 01:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB6F4A34DB
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 23:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193D128CF77;
	Wed,  1 Oct 2025 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMsvBx1z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CB14A4CC;
	Wed,  1 Oct 2025 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759360809; cv=none; b=RetvPbJofJZl5u8rv337WaunOeHQnABZ6zQOKsynCy4ExirMAqNVZiPoXR0ZYohBtvCGgQPm2Jx6lfHLzPZe6nHIxdsK3vwD4odYp3zwqEdAo6l7qSm8jBIuz+U3I3cIIfQdyu+pOjyKQoAN0dZ7JLYNk1sFLQtbr3V5gZyr8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759360809; c=relaxed/simple;
	bh=1GotudXstGA6zlJ85YQoNZ4muGKnPBNPB0SVxS5tmGA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eJ+USwOB6GiMiHEsxOrE9INOEb7Y44ag7BPdis2eIPCdeGDWGYEfC48euGwkAaFhZ4OBAeaf850T9i40e4cfRa3lFxVu4Q9kqucCmgo9yqgcr7x/l9UUbrqzk5x3EFm9u6OVRoYp/P9DliYmWb3Au1XgXPy3/tlMVwRxk/QYB4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMsvBx1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5416BC4CEF1;
	Wed,  1 Oct 2025 23:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759360808;
	bh=1GotudXstGA6zlJ85YQoNZ4muGKnPBNPB0SVxS5tmGA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TMsvBx1zw8c0vUhktb1+ePWueMRT9RZ+iQ9Ie8ghxMNhunrqXrYhb7zQHXm8j2t0c
	 ROIMzaLkiX4eevBQnGralHbk9Q7k6tVhDg33uSlHBEM+xPW1rmKekGyt/sbuncFulO
	 tDzFBI2zzBvhGbYCWqS/3JL7W+HN2bncnSXlWH5lgevOr0C/M8qK92iDdxXLhdz7S8
	 Y+8CTlOyfEIJRFsJX3SW6g8ady6w26VblsxLbXxbXl9asTpfDyjudzixcNVwq8WCg3
	 Oai2aRhp954AwnAjpTN8fRgonrDmTwe4tv6UYGW9w0gqk4F/VfI/mq33pYqe7Yfkck
	 QTjI2BiIuxUsg==
Message-ID: <8b6d2a9dfafe1cbf4311efe157f50e8f21702d04.camel@kernel.org>
Subject: Re: [PATCH v18 04/20] cxl: allow Type2 drivers to map cxl component
 regs
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, 
	netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, 	dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	 <Jonathan.Cameron@huawei.com>
Date: Wed, 01 Oct 2025 16:20:07 -0700
In-Reply-To: <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	 <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alejandro,

On Thu, 2025-09-18 at 10:17 +0100, alejandro.lucero-palau@amd.com
wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>=20
> Export cxl core functions for a Type2 driver being able to discover
> and
> map the device component registers.
>=20
> Use it in sfc driver cxl initialization.
>=20
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> =C2=A0drivers/cxl/core/port.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/cxl/cxl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 -------
> =C2=A0drivers/cxl/cxlpci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 -----------
> =C2=A0drivers/net/ethernet/sfc/efx_cxl.c | 33
> ++++++++++++++++++++++++++++++
> =C2=A0include/cxl/cxl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 +++++++++++++++=
+++
> =C2=A0include/cxl/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++++++++++
> =C2=A06 files changed, 69 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index bb326dc95d5f..240c3c5bcdc8 100644
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
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index e197c36c7525..793d4dfe51a2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -38,10 +38,6 @@ extern const struct nvdimm_security_ops
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
> @@ -205,9 +201,6 @@ void cxl_probe_component_regs(struct device *dev,
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
> index 4b11757a46ab..2247823acf6f 100644
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
> @@ -90,6 +80,4 @@ struct cxl_dev_state;
> =C2=A0int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm
> *cxlhdm,
> =C2=A0			struct cxl_endpoint_dvsec_info *info);
> =C2=A0void read_cdat_data(struct cxl_port *port);
> -int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type
> type,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cxl_register_map *map);
> =C2=A0#endif /* __CXL_PCI_H__ */
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
> b/drivers/net/ethernet/sfc/efx_cxl.c
> index 56d148318636..cdfbe546d8d8 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -5,6 +5,7 @@
> =C2=A0 * Copyright (C) 2025, Advanced Micro Devices, Inc.
> =C2=A0 */
> =C2=A0
> +#include <cxl/cxl.h>
> =C2=A0#include <cxl/pci.h>
> =C2=A0#include <linux/pci.h>
> =C2=A0
> @@ -19,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> =C2=A0	struct pci_dev *pci_dev =3D efx->pci_dev;
> =C2=A0	struct efx_cxl *cxl;
> =C2=A0	u16 dvsec;
> +	int rc;
> =C2=A0
> =C2=A0	probe_data->cxl_pio_initialised =3D false;
> =C2=A0
> @@ -45,6 +47,37 @@ int efx_cxl_init(struct efx_probe_data
> *probe_data)
> =C2=A0	if (!cxl)
> =C2=A0		return -ENOMEM;
> =C2=A0
> +	rc =3D cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxl->cxlds.reg_map);
> +	if (rc) {
> +		dev_err(&pci_dev->dev, "No component registers
> (err=3D%d)\n", rc);
> +		return rc;
> +	}
> +
> +	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
> +		dev_err(&pci_dev->dev, "Expected HDM component
> register not found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!cxl->cxlds.reg_map.component_map.ras.valid)
> +		return dev_err_probe(&pci_dev->dev, -ENODEV,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Expected RAS component
> register not found\n");
> +
> +	rc =3D cxl_map_component_regs(&cxl->cxlds.reg_map,
> +				=C2=A0=C2=A0=C2=A0 &cxl->cxlds.regs.component,
> +				=C2=A0=C2=A0=C2=A0 BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc) {
> +		dev_err(&pci_dev->dev, "Failed to map RAS
> capability.\n");
> +		return rc;
> +	}

I've finally made some serious headway integrating v17 into my
environment to better comment on this flow.

I'm running into what I'm seeing as a fundamental issue of resource
ownership between a device driver, and the CXL driver core.  I'm having
a hard time trying to resolve this.

If I do the above and call cxl_map_component_regs() with a valid CAP_ID
(RAS, HDM, etc.), that eventually calls devm_cxl_iomap_block() from
inside the CXL core drivers.  That calls devm_request_mem_region(), and
this is where things get interesting.

If my device happens to land the CXL component registers inside of a
BAR that has other items needed by my Type 2 device's driver, then we
have a conflict.  My driver and the CXL core drivers cannot hold the
same regions mapped.  i.e. I can't call pci_request_region() on my BAR,
and then call the above.  One loses, and then we all lose.

Curious if you have any ideas how we can improve this?

Cheers,
-PJ

