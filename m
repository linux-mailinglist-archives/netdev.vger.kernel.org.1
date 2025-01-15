Return-Path: <netdev+bounces-158566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2029AA1281C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36C61686A8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D2615D5C5;
	Wed, 15 Jan 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl9NFeay"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BFD146D40
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736957057; cv=none; b=Z6SO0umXQdBSoRHwq/Sb5lqWqz07X2cgkFajUfai9FnkTG58k+CR7JyJWL/eF1qx0oQlc7ehHIwXePWrwu/U+ExT7l8D4M8R/XkcrsF3ITtxPmUcefdjEbgeEkx/vIQ1iVkRQsRyp9bf2VRC5g9eEIRo+UD2aumWM/cXdai0+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736957057; c=relaxed/simple;
	bh=/z+vshHkUCa0xGVrz2Tvu1ucLgu2PBf9Xol9/J4uAls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgkXQNbJOeGwHS/e6H1jvGQVmn9JKa8s0wnp9xa45OjyEX0PQMnLl3Z9uXRngqPB/HdLhO0sFe8RZHACpbjH2aXDBG8v9W6T3jcALsT1VbFM68yAaubGCSvGc2XhGN+E+3WganjmIOmjcjW4C76KP6T1MbhzSX5w668RkonzF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl9NFeay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A7CC4CEE1;
	Wed, 15 Jan 2025 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736957056;
	bh=/z+vshHkUCa0xGVrz2Tvu1ucLgu2PBf9Xol9/J4uAls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cl9NFeayWTSU0+idOw39zTbjHttDHtro0v7uU0L9OBIi3tkNVJ0EgcENDrE5vAJ3/
	 UFWQEOyzN47FJFJloPpA4FEEJHZBYiUtDSF8F1j3bBdXXigl041LyiYtJlU3wU5jn0
	 24Y0zCCd86Prkznez+kn76HCuEvPLV9fKHWqLKr8lpqbCkhIPSc1xar1+HoX7rJFoj
	 ehZfhioRQJBXiwQBlmev2KT9VE0Staer1PuwWEuhSPxY34DknPVIB2SgwZceHG9h62
	 ezB51WmRvlGpLbK5Tv9vAwGM2vI3hgPv1PdjQ6IAYS1a0vDGrMwM30ZhfxUAEONhnP
	 1zM9dg99cIqhA==
Date: Wed, 15 Jan 2025 16:04:12 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com
Subject: Re: [PATCH v3 01/14] net-next/yunsilicon: Add xsc driver basic
 framework
Message-ID: <20250115160412.GQ5497@kernel.org>
References: <20250115102242.3541496-1-tianx@yunsilicon.com>
 <20250115102242.3541496-2-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115102242.3541496-2-tianx@yunsilicon.com>

On Wed, Jan 15, 2025 at 06:22:44PM +0800, Xin Tian wrote:
> Add yunsilicon xsc driver basic framework, including xsc_pci driver
> and xsc_eth driver
> 
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> new file mode 100644
> index 000000000..709270df8
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
> +
> +obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
> +
> +xsc_pci-y := main.o
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> new file mode 100644
> index 000000000..4859be58f
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#include "common/xsc_core.h"

Hi Xin Tian, all,

Sorry for not noticing this before sending my previous email.

Please consider a relative include like the following,
rather than the above combined with a -I directive in the Makefile.

#include "../common/xsc_core.h"

This is common practice in Networking code.
And, for one thing, allows the following to work:

make drivers/net/ethernet/yunsilicon/xsc/pci/main.o

...

