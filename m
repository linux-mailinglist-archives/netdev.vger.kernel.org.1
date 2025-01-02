Return-Path: <netdev+bounces-154745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D36A9FFA82
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC5A162A68
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A911B043A;
	Thu,  2 Jan 2025 14:37:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95121AC44D;
	Thu,  2 Jan 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735828622; cv=none; b=MLlkmWCNSDOhXeVADjDSs+yyZNhzA5uMb76Ad5MbuayhyeT1Y6uSPnI5fGanO1LZaxAqSADef/XzHuIZ1vEIq97Nnd5vh5k81RwC9qElDZ+idPf+ZM3IYFqJ/dFw/QjLeGTWlCg96fHytf2ICyL3uPYm7IOCLjOH1VfodlmJyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735828622; c=relaxed/simple;
	bh=e3WdMbk4f0C+q0LKQwl/eIkGmXomzYEMGA1cVWXzmqY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Om2ePhsUFiC4l4uRQu66pxkniYX4i27pwJZfOA+sbkOfhdqj8zQQAj86n/Eq4EhEK/Q+qlT5EynVZAxVGk4UuorgIGmqYP17J5oGwyIG4NowRWcxTCgfeGrnCC2kJcmfCEcxnlKDha2rpeopR7JnP1o9rnbZhayP1OCdZSW3PLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YP8Lb3czLz6K93n;
	Thu,  2 Jan 2025 22:32:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 53F091401F3;
	Thu,  2 Jan 2025 22:36:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 2 Jan
 2025 15:36:57 +0100
Date: Thu, 2 Jan 2025 14:36:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 03/27] cxl: add capabilities field to cxl_dev_state
 and cxl_port
Message-ID: <20250102143656.000061c9@huawei.com>
In-Reply-To: <20241230214445.27602-4-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
	<20241230214445.27602-4-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Dec 2024 21:44:21 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type2 devices have some Type3 functionalities as optional like an mbox
> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
> implements.
> 
> Add a new field to cxl_dev_state for keeping device capabilities as
> discovered during initialization. Add same field to cxl_port as registers
> discovery is also used during port initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
Comment in thread on v8.  I don't see a reason to have any specific
bitmap length - just use a final entry in the enum without a value set
to let us know how long it actually is.

Using the bit / bitmap functions should work fine without constraining
that to any particular value - also allowing for greater than 64 entries
with no need to fix up call sites etc.


> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 59cb35b40c7e..144ae9eb6253 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -4,6 +4,7 @@

> +enum cxl_dev_cap {
> +	/* capabilities from Component Registers */
> +	CXL_DEV_CAP_RAS,
> +	CXL_DEV_CAP_HDM,
> +	/* capabilities from Device Registers */
> +	CXL_DEV_CAP_DEV_STATUS,
> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
> +	CXL_DEV_CAP_MEMDEV,
> +	CXL_MAX_CAPS = 64
As in v8. I'm not seeing any reason for this.  If you need
a bitmap to be a particular number of unsigned longs, then that
code should be fixed. (only exception being compile time constant
bitmaps where this is tricky to do!)

Obviously I replied with that to v8 after you posted this
so time machines aside no way you could have acted on it yet.


Jonathan

> +};
> +
>  struct cxl_dev_state;
>  struct device;
>  


