Return-Path: <netdev+bounces-115565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8E5947036
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF881B20CA2
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E875E2E3EB;
	Sun,  4 Aug 2024 17:58:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91521350;
	Sun,  4 Aug 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722794285; cv=none; b=DODjk+mpG4zgUklY7ySv5XvvO4nZI253s+A2jQMffArXt2p/egzmt7HC5h085wVXtyXmK7/cOgB60hVKlK4kRO/dTZM6fHT/fh9f+E4Hg1M3rTNLZzd75gA0U8kwjq8jkPXf0FhXKPqY1BsGNFRX6PFp2zh8zOEKaKR74jVAB2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722794285; c=relaxed/simple;
	bh=AUydgLzX4wrEYlmW4Nj/M7tFG2nFIcDBwEsx4AF4238=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X18Q73OPFudWKN1dlY7x3Ab6yBJBZi+N0otCg0dm4Y0Hy+oSDk49eBVo6SC+I3XRLVAxxDHTB11OBokhY6lNrpKASXgIyyP7CNQTFT27z1hBbqKX54ETmeOm/mE473Obs/gPjS6unB78kevYVg9HV6YjDlR8NkGHBqn9LO7h6bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcS033K4Zz687SH;
	Mon,  5 Aug 2024 01:55:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 66690140133;
	Mon,  5 Aug 2024 01:58:00 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 18:57:59 +0100
Date: Sun, 4 Aug 2024 18:57:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
Message-ID: <20240804185756.000046c5@Huawei.com>
In-Reply-To: <20240715172835.24757-10-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-10-alejandro.lucero-palau@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jul 2024 18:28:29 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
>=20
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is create equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
>=20
> Wrap all of those concerns into an API that retrieves a root decoder
> (platform CXL window) that fits the specified constraints and the
> capacity available for a new region.
>=20
> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.866342598=
7110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m6fbe775541da3cd477d65fa95c8a=
cdc347345b4f
>=20
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>

Hi.

This seems a lot more complex than an accelerator would need.
If plan is to use this in the type3 driver as well, I'd like to
see that done as a precursor to the main series.
If it only matters to accelerator drivers (as in type 3 I think
we make this a userspace problem), then limit the code to handle
interleave ways =3D=3D 1 only.  Maybe we will care about higher interleave
in the long run, but do you have a multihead accelerator today?

Jonathan

> ---
>  drivers/cxl/core/region.c          | 161 +++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h                  |   3 +
>  drivers/cxl/cxlmem.h               |   5 +
>  drivers/net/ethernet/sfc/efx_cxl.c |  14 +++
>  include/linux/cxl_accel_mem.h      |   9 ++
>  5 files changed, 192 insertions(+)
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 538ebd5a64fd..ca464bfef77b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -702,6 +702,167 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
> =20
> +
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx =3D data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +	int found;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd =3D to_cxl_root_decoder(dev);
> +	cxld =3D &cxlrd->cxlsd.cxld;
> +	if ((cxld->flags & ctx->flags) !=3D ctx->flags) {
> +		dev_dbg(dev, "find_max_hpa, flags not matching: %08lx vs %08lx\n",
> +			      cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	/* A Host bridge could have more interleave ways than an
> +	 * endpoint, couldn=B4t it?

EP interleave ways is about working out how the full HPA address (it's
all sent over the wire) is modified to get to the DPA.  So it needs
to know what the overall interleave is.  Host bridge can't interleave
and then have the EP not know about it.  If there are switch HDM decoders
in the path, the host bridge interleave may be less than that the EP needs
to deal with.

Does an accelerator actually cope with interleave? Is aim here to ensure
that IW is never anything other than 1?  Or is this meant to have
more general use? I guess it is meant to. In which case, I'd like to
see this used in the type3 driver as well.

> +	 *
> +	 * What does interleave ways mean here in terms of the requestor?
> +	 * Why the FFMWS has 0 interleave ways but root port has 1?

FFMWS?

> +	 */
> +	if (cxld->interleave_ways !=3D ctx->interleave_ways) {
> +		dev_dbg(dev, "find_max_hpa, interleave_ways  not matching\n");
> +		return 0;
> +	}
> +
> +	cxlsd =3D &cxlrd->cxlsd;
> +
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	found =3D 0;
> +	for (int i =3D 0; i < ctx->interleave_ways; i++)
> +		for (int j =3D 0; j < ctx->interleave_ways; j++)
> +			if (ctx->host_bridges[i] =3D=3D
> +					cxlsd->target[j]->dport_dev) {
> +				found++;
> +				break;
> +			}
> +
> +	if (found !=3D ctx->interleave_ways) {
> +		dev_dbg(dev, "find_max_hpa, no interleave_ways found\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	max =3D 0;
> +	res =3D cxlrd->res->child;
> +	if (!res)
> +		max =3D resource_size(cxlrd->res);
> +	else
> +		max =3D 0;
> +
> +	for (prev =3D NULL; res; prev =3D res, res =3D res->sibling) {
> +		struct resource *next =3D res->sibling;
> +		resource_size_t free =3D 0;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free =3D res->start - cxlrd->res->start;
> +			max =3D max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free =3D res->start - prev->end + 1;
> +			max =3D max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free =3D next->start - res->end + 1;
> +			max =3D max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free =3D cxlrd->res->end + 1 - res->end + 1;
> +			max =3D max(free, max);
> +		}
> +	}
> +
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(CXLRD_DEV(ctx->cxlrd));
> +		get_device(CXLRD_DEV(cxlrd));
> +		ctx->cxlrd =3D cxlrd;
> +		ctx->max_hpa =3D max;
> +		dev_info(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);

dev_dbg()

> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per co=
nstraints
> + * @endpoint: an endpoint that is mapped by the returned decoder
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs H=
DM-D[B]
> + * @max: output parameter of bytes available in the returned decoder

@available_size
or something along those lines. I'd expect max to be the end address of the=
 available
region

> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available =
(@max)'
> + * is a point in time snapshot. If by the time the caller goes to use th=
is root
> + * decoder's capacity the capacity is reduced then caller needs to loop =
and
> + * retry.
> + *
> + * The returned root decoder has an elevated reference count that needs =
to be
> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root de=
coder
> + * does not race.
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max)
> +{
> +
> +	struct cxlrd_max_context ctx =3D {
> +		.host_bridges =3D &endpoint->host_bridge,
> +		.interleave_ways =3D interleave_ways,
> +		.flags =3D flags,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_root *root;
> +
> +	if (!is_cxl_endpoint(endpoint)) {
> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	root =3D find_cxl_root(endpoint);
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n"=
);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port =3D &root->port;
> +	down_read(&cxl_region_rwsem);
> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +	up_read(&cxl_region_rwsem);
> +	put_device(&root_port->dev);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max =3D ctx.max_hpa;

Rename max_hpa to available_hpa.

> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
> +
> +


