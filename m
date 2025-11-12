Return-Path: <netdev+bounces-238041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D5C53479
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5039C625BEC
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA62269811;
	Wed, 12 Nov 2025 15:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A87F301033;
	Wed, 12 Nov 2025 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961622; cv=none; b=eQiLnlAEGdsQgxWhx7cIQOsCGFJf5+xet09Lbj+95AXXEfqEzCNYm1tEARNuCCQyaDXhhJZu9x2H/5jYrn4RUEhj3EK02qwzTgXgA6Jfa2VKYhIXOdvDRq1mHIs6cEpWt6oz/R23v9YJLIBrQDwaOayCOwEprPcpCXg0Vm6ksps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961622; c=relaxed/simple;
	bh=HI3eCi1JvGJlHpKpgnqDyPjCMMeri77ni9tLhmKxALM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agp3ymtzYATwkmytolXILttuwfSh8NNbyhwJapAqiP1JgBYQsMqiKRJ99dL5C37tZlr9Rn2XNGXZzt8mf0B1NGJlZ6QN3Col0W1ChzOqgyI1yh95zvTRuMKvppert2jbTDrkpYTpEq9+t0YsZ4WOSsQ3ThKu27TEuoezcXJOA1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d66qd2jXGzHnGh0;
	Wed, 12 Nov 2025 23:33:17 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A53071402CB;
	Wed, 12 Nov 2025 23:33:36 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 15:33:35 +0000
Date: Wed, 12 Nov 2025 15:33:34 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v20 04/22] cxl: Add type2 device basic support
Message-ID: <20251112153334.00000ea2@huawei.com>
In-Reply-To: <20251110153657.2706192-5-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
	<20251110153657.2706192-5-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 10 Nov 2025 15:36:39 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Use same new initialization with the type3 pci driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
One minor thing that's probably a merge conflict gone slightly wrong
or something like that. After this patch you end up with two
CXL_NR_PARTITIONS_MAX defines.

> ---
>  drivers/cxl/core/mbox.c      |  12 +-
>  drivers/cxl/core/memdev.c    |  32 +++++
>  drivers/cxl/core/pci_drv.c   |  15 +--
>  drivers/cxl/cxl.h            |  97 +--------------
>  drivers/cxl/cxlmem.h         |  85 +------------
>  include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
>  tools/testing/cxl/test/mem.c |   3 +-
>  7 files changed, 276 insertions(+), 194 deletions(-)
>  create mode 100644 include/cxl/cxl.h
> 

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> new file mode 100644
> index 000000000000..13d448686189
> --- /dev/null
> +++ b/include/cxl/cxl.h
> @@ -0,0 +1,226 @@



> +#define CXL_NR_PARTITIONS_MAX 2
Adds a definition but doesn't remove the one in driver/cxl/cxlmem.h
That seems odd.




