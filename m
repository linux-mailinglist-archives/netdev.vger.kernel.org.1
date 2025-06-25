Return-Path: <netdev+bounces-201186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F74AE859C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6031881500
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D569182D7;
	Wed, 25 Jun 2025 14:06:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93022255E23;
	Wed, 25 Jun 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860396; cv=none; b=uuwRGT0w0OCn+PzqeqxFHY0BtdThJZSG0vm7zixU5bZ+66U12u3QGlfGb8tRFn7swX/bTV2xOLSMvWv03TuUZ+wstlGfmoS5DMsN3B43c1PKQpUpQWKatVGB+ul9w9/KxfuogTbEWqge9q3R+Hg1EMregjttUJR3J4MawUWiUZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860396; c=relaxed/simple;
	bh=NE4fqSIymjHCZabj1K/ABKFeJ5/0uIE3iWcOgWDS2ZA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLLXM/HhtIy8/d7j2xAAAgzEkb+/PjSNa4uzAx/98wMOftdxPkDMv63PfsC5Li4QClJOJgIHETQsdNsv0QPeW93TzPjLqqMOc2OshjttWRyMuW2PX3w2mYhFFbWBLjs9b4bK6BNZ3rW1oBEKMYgobVtYABa2sLzXjaxXiDG3Jqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bS3T974c6z6K9CG;
	Wed, 25 Jun 2025 22:03:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DB45114027A;
	Wed, 25 Jun 2025 22:06:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:30 +0200
Date: Wed, 25 Jun 2025 15:06:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: Re: [PATCH v17 01/22] cxl: Add type2 device basic support
Message-ID: <20250625150628.00002255@huawei.com>
In-Reply-To: <20250624141355.269056-2-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-2-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 15:13:34 +0100
<alejandro.lucero-palau@amd.com> wrote:

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
Hi Alejandro,

A few really minor comments inline.

> ---
>  drivers/cxl/core/mbox.c      |  12 +-
>  drivers/cxl/core/memdev.c    |  32 +++++
>  drivers/cxl/core/pci.c       |   1 +
>  drivers/cxl/core/regs.c      |   1 +
>  drivers/cxl/cxl.h            |  97 +--------------
>  drivers/cxl/cxlmem.h         |  85 +------------
>  drivers/cxl/cxlpci.h         |  21 ----
>  drivers/cxl/pci.c            |  17 +--
>  include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
>  include/cxl/pci.h            |  23 ++++
>  tools/testing/cxl/test/mem.c |   3 +-
>  11 files changed, 303 insertions(+), 215 deletions(-)
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d72764056ce6..d78f6039f997 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1484,23 +1484,21 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>  
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec)
>  {
>  	struct cxl_memdev_state *mds;
>  	int rc;
>  
> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> +	mds = devm_cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial,
> +					dvsec, struct cxl_memdev_state, cxlds,
> +					true);


> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 3ec6b906371b..9cc4337cacfb 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -7,6 +7,7 @@
>  #include <linux/cdev.h>
>  #include <linux/uuid.h>
>  #include <linux/node.h>

Is node still used in here?  If the includes was just for
struct access_coordinates then that is now gone from this file.

> +#include <cxl/cxl.h>
>  #include <cxl/event.h>
>  #include <cxl/mailbox.h>
>  #include "cxl.h"
> @@ -357,87 +358,6 @@ struct cxl_security_state {
>  	struct kernfs_node *sanitize_node;
>  };

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 785aa2af5eaa..0d3c67867965 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c

> @@ -924,19 +927,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return rc;
>  	pci_set_master(pdev);
>  
> -	mds = cxl_memdev_state_create(&pdev->dev);
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		dev_warn(&pdev->dev,
> +			 "Device DVSEC not present, skip CXL.mem init\n");

Could use pci_warn(pdev, "..."); Not particularly important.

> +
> +	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);

Jonathan


