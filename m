Return-Path: <netdev+bounces-228106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7985BC1776
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C960C4F6372
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 13:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BED52E06ED;
	Tue,  7 Oct 2025 13:18:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BCE2D9497;
	Tue,  7 Oct 2025 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843110; cv=none; b=sOUNj8b+ChkisQcm10hOVKEIFUPZg0q3ukpnCvCZzsH9xdxDJDQttBVN19x+xxu8YyD7zqrDaYZAS9LX3kQRWG4S7MhG+iKGsGW7pn7CQj8P0cUHt7GzqDbdr7tP/wI9V1cGdLwIuH/Q3mee9pWXEadBVLzVdgtaDtkchheMQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843110; c=relaxed/simple;
	bh=aNbJPL3hpTBT3yM+t3L339P23LGEzpupNi1afteC9HY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxhIN9ZGyEkzjwIARNX+A035OqYmX8O2dy0Uc4AIfG151fFVnpVcg6Vo3H5bF999n3AdaujV6Cfqjal0CiHQm5opE8M0WCS9g2azbrUT2MfCx+/7Ms211cp+E80jVyDOiMa8BxMRhumZIlJkx5chwK5McSP8SWkuOxSvqThFrWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgxTl0YF5z6L4vw;
	Tue,  7 Oct 2025 21:15:55 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 17C6E1402EF;
	Tue,  7 Oct 2025 21:18:25 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Oct
 2025 14:18:24 +0100
Date: Tue, 7 Oct 2025 14:18:22 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v19 07/22] cxl: allow Type2 drivers to map cxl component
 regs
Message-ID: <20251007141822.00001c4a@huawei.com>
In-Reply-To: <20251006100130.2623388-8-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
	<20251006100130.2623388-8-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 6 Oct 2025 11:01:15 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
I'd amend the patch title to 
	cxl/sfc: Map CXL component regs.

And talk about exports in the description.

Other options are fine but the patch title should indicate
this is being used by the sfc driver.

> Export cxl core functions for a Type2 driver being able to discover and
> map the device component registers.
> 
> Use it in sfc driver cxl initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/pci.c             |  1 +
>  drivers/cxl/core/port.c            |  1 +
>  drivers/cxl/core/regs.c            |  1 +
>  drivers/cxl/cxl.h                  |  7 ------
>  drivers/cxl/cxlpci.h               | 12 ----------
>  drivers/cxl/pci.c                  |  1 +
>  drivers/net/ethernet/sfc/efx_cxl.c | 35 ++++++++++++++++++++++++++++++
>  include/cxl/cxl.h                  | 19 ++++++++++++++++
>  include/cxl/pci.h                  | 21 ++++++++++++++++++
>  9 files changed, 79 insertions(+), 19 deletions(-)
>  create mode 100644 include/cxl/pci.h


