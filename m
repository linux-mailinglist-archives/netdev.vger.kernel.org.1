Return-Path: <netdev+bounces-227373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BD7BAD413
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 16:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A30F482865
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C946C3043C8;
	Tue, 30 Sep 2025 14:47:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8BE2032D;
	Tue, 30 Sep 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243646; cv=none; b=KS+Fewb6Ditpk5qlKpb78KAlm4yfpsOj6k+XQLAtpb9fP9UfhEY7qM6Pfd3aC7WqKYEnyCs0jasSecpINLqYYUx5qb5j2Tf8t4swp6u8LZq/JX2VcGuiwmhZbrJ0IBePLz2c6/PIvrwybhjQjH32RAN4a4FKo0VKYvNOJobcu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243646; c=relaxed/simple;
	bh=wBn3HeWAMo8n4FTUS1A7CqoJBnLIN4H3P06LOhms7Zg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Afxx+RbwueTla+BCb3tj3KoO4WPfmn76iz5lrfpquIvnuZVfwDtYs0vZm0ffdcqADP0mVfsoxw/yp4RbariSrdtQfRu5nvGGPP/fvVLIU56F+bS5wqcbudf3Lew2w+5oukFtkbB0mdOjm8QnXciT0Rdv4BWz+PMUC7khMDC7GcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cbgmv0x63z6M4mZ;
	Tue, 30 Sep 2025 22:44:15 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E4061402F5;
	Tue, 30 Sep 2025 22:47:22 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 30 Sep
 2025 15:47:21 +0100
Date: Tue, 30 Sep 2025 15:47:19 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v18 09/20] cxl: Define a driver interface for HPA free
 space enumeration
Message-ID: <20250930154719.000000fd@huawei.com>
In-Reply-To: <989dd1bf-adcd-4bd4-82fc-0497d615667a@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	<20250918091746.2034285-10-alejandro.lucero-palau@amd.com>
	<20250918153503.00004800@huawei.com>
	<989dd1bf-adcd-4bd4-82fc-0497d615667a@amd.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 24 Sep 2025 17:16:14 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 9/18/25 15:35, Jonathan Cameron wrote:
> > On Thu, 18 Sep 2025 10:17:35 +0100
> > <alejandro.lucero-palau@amd.com> wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> CXL region creation involves allocating capacity from Device Physical Address
> >> (DPA) and assigning it to decode a given Host Physical Address (HPA). Before
> >> determining how much DPA to allocate the amount of available HPA must be
> >> determined. Also, not all HPA is created equal, some HPA targets RAM, some
> >> targets PMEM, some is prepared for device-memory flows like HDM-D and HDM-DB,
> >> and some is HDM-H (host-only).
> >>
> >> In order to support Type2 CXL devices, wrap all of those concerns into
> >> an API that retrieves a root decoder (platform CXL window) that fits the
> >> specified constraints and the capacity available for a new region.
> >>
> >> Add a complementary function for releasing the reference to such root
> >> decoder.
> >>
> >> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > Either I was half asleep or a few things have snuck in.
> >
> > See below.
> >  
> >> +
> >> +/**
> >> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> >> + * @endpoint: the endpoint requiring the HPA  
> > The parameter seems to have changed.  Make sure to point scripts/kernel-doc at each
> > file to check for stuff like this.  
> 
> 
> OK.
> 
> 
> >  
> >> + * @interleave_ways: number of entries in @host_bridges
> >> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
> >> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> >> + *		      returned decoder
> >> + *
> >> + * Returns a pointer to a struct cxl_root_decoder
> >> + *
> >> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> >> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> >> + * caller goes to use this root decoder's capacity the capacity is reduced then
> >> + * caller needs to loop and retry.
> >> + *
> >> + * The returned root decoder has an elevated reference count that needs to be
> >> + * put with cxl_put_root_decoder(cxlrd).
> >> + */
> >> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> >> +					       int interleave_ways,
> >> +					       unsigned long flags,
> >> +					       resource_size_t *max_avail_contig)
> >> +{
> >> +	struct cxl_root *root __free(put_cxl_root) = NULL;  
> > Nope to this.  See the stuff in cleanup.h on why not.  
> 
> 
> I guess you mean to declare the pointer later on when assigned to the 
> object instead of a default NULL, as you point out later.

yes.

> 
> After reading the cleanup file, it is not clear to me if this is really 
> needed since there is no lock involved in that example for a potential bug.
> 

Do it anyway. It's not about bugs today, but about fragile code patterns that
may break later without it being obvious.

> 
> >> +	struct cxl_port *endpoint = cxlmd->endpoint;
> >> +	struct cxlrd_max_context ctx = {
> >> +		.host_bridges = &endpoint->host_bridge,
> >> +		.flags = flags,
> >> +	};
> >> +	struct cxl_port *root_port;
> >> +
> >> +	if (!endpoint) {
> >> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
> >> +		return ERR_PTR(-ENXIO);
> >> +	}
> >> +
> >> +	root  = find_cxl_root(endpoint);  
> > extra space, but should be
> > 	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> > anyway.
> >  



