Return-Path: <netdev+bounces-115560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B04947006
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 19:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AFE281278
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEFD12FB1B;
	Sun,  4 Aug 2024 17:22:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1331DFE8;
	Sun,  4 Aug 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722792160; cv=none; b=CgB8Js3ASODzfbcGi5uCSV4OMjHXdxQQtRZW+hjGUe25T4Q2vMJDW7FnY2Y9A0qvfRO4d6v4u8lPddRzNrV/to/BceyjvgTO6M8NPmDspb6bTCbQ0wU7M3pieO049USeAkg3WZvRjYO8ZyFUxg4CHAQYznkikuhvzy1UsCvtVko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722792160; c=relaxed/simple;
	bh=QrQqf+Z8HKaEv5NUMe2EBKwkcN/Y4NxdavW8jtXmG4o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSPQQggPSXZDK0ABxikNwvK2XuJeXSNW1Vtis5ojF5deEa7pfxEZCxInXLNTNFURv3G1qSUYyCc+NO1ZSmLv86F15+OUk7B10Jfy2u8lKVma7nEJnhhSHnijY3tDK5dbRh7tvWfnmL7npP62lbWVcfk2UsCamUHp2Vrh/zjnzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcRCB5qQyz6K5Yp;
	Mon,  5 Aug 2024 01:19:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BBBA1400C9;
	Mon,  5 Aug 2024 01:22:36 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 18:22:35 +0100
Date: Sun, 4 Aug 2024 18:22:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 04/15] cxl: add capabilities field to cxl_dev_state
Message-ID: <20240804182232.000014b8@Huawei.com>
In-Reply-To: <20240715172835.24757-5-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-5-alejandro.lucero-palau@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jul 2024 18:28:24 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type2 devices have some Type3 functionalities as optional like an mbox
> or an hdm decoder, and CXL core needs a way to know what a CXL accelerator
> implements.
> 
> Add a new field for keeping device capabilities to be initialised by
> Type2 drivers. Advertise all those capabilities for Type3.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
In general seems a reasonable approach, so just minor comments.

> ---
>  drivers/cxl/core/mbox.c            |  1 +
>  drivers/cxl/core/memdev.c          |  4 +++-
>  drivers/cxl/core/port.c            |  2 +-
>  drivers/cxl/core/regs.c            | 11 ++++++-----
>  drivers/cxl/cxl.h                  |  2 +-
>  drivers/cxl/cxlmem.h               |  4 ++++
>  drivers/cxl/pci.c                  | 15 +++++++++------
>  drivers/net/ethernet/sfc/efx_cxl.c |  3 ++-
>  include/linux/cxl_accel_mem.h      |  5 ++++-
>  9 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..2ba7d36e3f38 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1424,6 +1424,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->cxlds.reg_map.host = dev;
>  	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> +	mds->cxlds.capabilities = CXL_DRIVER_CAP_HDM | CXL_DRIVER_CAP_MBOX;

Add a reference for this perhaps.  Make it clear that a type3 device must
support mailbox and hdm by pointing at requirement for the various structures
in a spec reference.

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index af8169ccdbc0..8f2a820bd92d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -405,6 +405,9 @@ struct cxl_dpa_perf {
>  	int qos_class;
>  };
>  
> +#define CXL_DRIVER_CAP_HDM	0x1
> +#define CXL_DRIVER_CAP_MBOX	0x2
> +
Enum and BIT() for the defines.  Avoids someone in future
thinking they can define 0x3 to be something.

Definitely only one definition as well. Seems reasonable for
this to be CXL wide.


>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -438,6 +441,7 @@ struct cxl_dev_state {
>  	struct resource ram_res;
>  	u64 serial;
>  	enum cxl_devtype type;
> +	uint8_t capabilities;
>  };


