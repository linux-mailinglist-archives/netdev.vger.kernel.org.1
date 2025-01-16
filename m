Return-Path: <netdev+bounces-158850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC9EA13854
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901573A4878
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1A1DE2D5;
	Thu, 16 Jan 2025 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoK9KqFj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23AB1DE3AA
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024844; cv=none; b=GzZ/79w8y043wHUm73PVXic6oZ8a/rNrytY+X/m0CJsdJmTrBNggj/DOnBTNIsZS8+VfUJAcYYIJYmBagrKL3vtRJTr0HRFFQoy6URGIp92iY1DPy3u2tmE/yyIrMqXw+BwqF0Th0aRj3X3/q/4iOlAGn2f+aivwcfIenGfsyT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024844; c=relaxed/simple;
	bh=7OQjQY/y3s2g2bsGhd2aRjByTpAq0hp9uBB/TENh0/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USHXbu0x+GN5GmekXlJmQGo5dwbTit9TbPCsfrvIMA44SOM+zUcLj8ZK+huuOwFgViwJqSr3GuXq3EzyMIkwrHRZpkmS6RsKC6KWqLlGYXrR3IXqM/rna6AX5+cd8AHWG+g0fTwlwmd0XkDW/n1yXPKRPau8Lih4ohJel+yfWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoK9KqFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FECC4CED6;
	Thu, 16 Jan 2025 10:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737024843;
	bh=7OQjQY/y3s2g2bsGhd2aRjByTpAq0hp9uBB/TENh0/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoK9KqFjH62ByaJwiiVbPSuUb32r6LPYpxzocPiNP643QUiYJcgjjT7p1MRoeQCmg
	 +y0LtIAInDJg1OIIzMMLilvDknrvB3pBI2KzS+qp0S8X60Z57eB4CBVgQ6Zopk+Prl
	 5DoeAQmTMWm8nMi0uKmMGne/8XpSm2FQdZCmRmq3ggySlMDoMV10ADuCpVIVH2Ow21
	 pvneZJ1gq+xGTb3ufXSTb/adQAGeFyia7qZbUa5szvvu1gtmMByzMNuGVg4ixYYhUC
	 ToRfoheriSrriX+lwIvUehn7S5M+tudyO1rShL4V4RV3Ebk6nRtX8FaYyxbsjQdnXb
	 3i1Ft/JM9EHrw==
Date: Thu, 16 Jan 2025 10:53:58 +0000
From: Simon Horman <horms@kernel.org>
To: tianx <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com
Subject: Re: [PATCH v3 01/14] net-next/yunsilicon: Add xsc driver basic
 framework
Message-ID: <20250116105358.GA6206@kernel.org>
References: <20250115102242.3541496-1-tianx@yunsilicon.com>
 <20250115102242.3541496-2-tianx@yunsilicon.com>
 <20250115160412.GQ5497@kernel.org>
 <a1951ab6-3ef1-441f-877f-ae2ca7c8f1c5@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1951ab6-3ef1-441f-877f-ae2ca7c8f1c5@yunsilicon.com>

On Thu, Jan 16, 2025 at 04:04:47PM +0800, tianx wrote:
> On 2025/1/16 0:04, Simon Horman wrote:
> > On Wed, Jan 15, 2025 at 06:22:44PM +0800, Xin Tian wrote:
> >> Add yunsilicon xsc driver basic framework, including xsc_pci driver
> >> and xsc_eth driver
> >>
> >> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> >> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> >> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> >> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> >> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> > ...
> >
> >> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> >> new file mode 100644
> >> index 000000000..709270df8
> >> --- /dev/null
> >> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> >> @@ -0,0 +1,9 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> >> +# All rights reserved.
> >> +
> >> +ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
> >> +
> >> +obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
> >> +
> >> +xsc_pci-y := main.o
> >> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> >> new file mode 100644
> >> index 000000000..4859be58f
> >> --- /dev/null
> >> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> >> @@ -0,0 +1,251 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> >> + * All rights reserved.
> >> + */
> >> +
> >> +#include "common/xsc_core.h"
> > Hi Xin Tian, all,
> >
> > Sorry for not noticing this before sending my previous email.
> >
> > Please consider a relative include like the following,
> > rather than the above combined with a -I directive in the Makefile.
> >
> > #include "../common/xsc_core.h"
> >
> > This is common practice in Networking code.
> > And, for one thing, allows the following to work:
> >
> > make drivers/net/ethernet/yunsilicon/xsc/pci/main.o
> 
> Hi, Simon
> 
> I don't fully understand the benefit of using relative includes in this case,
> as|"make drivers/net/ethernet/yunsilicon/xsc/pci/main.o|" already works with the current setup.

Thanks Xin Tian,

Sorry about this. There was an error on my part in exercising this yesterday.

I agree that the above make invocation does indeed work. And I do not have
a strong objection to the current #include scheme at this time.

