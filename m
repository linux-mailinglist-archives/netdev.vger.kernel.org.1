Return-Path: <netdev+bounces-166513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FD0A36422
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF8E7A1F1B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DC2267AF4;
	Fri, 14 Feb 2025 17:11:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F372C267AEB;
	Fri, 14 Feb 2025 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553114; cv=none; b=utfUPFDChG8XRTDMempbdMSVw6Yp444vdTvt4BwfyFuK4gCbjn++EVuBJaRVKRNL1gFpaGNPUZPRHzXVR1sjNT7GEcFU3WwIxLekytTj7G1iMshbaV7fcrQZjlRauK8syu6WjIhLCERpfPrvVc6IWuulGKyjAY0ENYocMV86w2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553114; c=relaxed/simple;
	bh=tFtajQ7qfY4tGxTTxjGWzke6jRM704zzilRu3asAwzA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5GJEMLgs/v7HPMxa4ux1fclS7mqd4k1PDZm92dUxAIP1QGesv/VsEGH8TYTMViMDk0gS9jVMzG+lIPSFp+8zuOJwtLLx5o6M2eKCmaaQHeg1TO3dsRJ7xc35n861h1DZ/wXa2MvrnulvwC1YPwuG/w1SpM4L+lgqGR6Msnx17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvdnY2RxVz67YpK;
	Sat, 15 Feb 2025 01:09:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CF8AA14038F;
	Sat, 15 Feb 2025 01:11:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 18:11:49 +0100
Date: Fri, 14 Feb 2025 17:11:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v10 03/26] cxl: move pci generic code
Message-ID: <20250214171147.00007e5f@huawei.com>
In-Reply-To: <16f4a5de-2f54-4367-9e14-b7a617468353@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
	<20250205151950.25268-4-alucerop@amd.com>
	<67a3d931816f_2ee27529462@iweiny-mobl.notmuch>
	<16f4a5de-2f54-4367-9e14-b7a617468353@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 6 Feb 2025 17:49:00 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 2/5/25 21:33, Ira Weiny wrote:
> > alucerop@ wrote:  
> >> From: Alejandro Lucero <alucerop@amd.com>  
> > [snip]
> >  
> >> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> >> index ad63560caa2c..e6178aa341b2 100644
> >> --- a/include/cxl/pci.h
> >> +++ b/include/cxl/pci.h
> >> @@ -1,8 +1,21 @@
> >>   /* SPDX-License-Identifier: GPL-2.0-only */
> >>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> >>   
> >> -#ifndef __CXL_ACCEL_PCI_H
> >> -#define __CXL_ACCEL_PCI_H
> >> +#ifndef __LINUX_CXL_PCI_H
> >> +#define __LINUX_CXL_PCI_H  
> > Nit: I'd just use __LINUX_CXL_PCI_H in the previous patch.  
> 
> 
> Dan suggested this change.
Would be odd if he meant in this patch....

Definitely no benefit in doing it here rather that when you
create the file in patch 1 that I can see.

J

> 
> 
> > Ira
> >
> > [snip]  
> 
> 


