Return-Path: <netdev+bounces-238053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B988C5391D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 18:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2393A501939
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D520033D6F8;
	Wed, 12 Nov 2025 15:52:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5270345CCE;
	Wed, 12 Nov 2025 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962762; cv=none; b=ScKHj0MBMcA0OYDV1P1aiG4fmWjlsXAX50Y1p0dbMsku1xGFPvKZqeT2fH19vV4a6ZxoLgnSlIC9NkbdkKLYrwX7SDzp8RbyPDn/l5WNgFrH33AuYxR9ZXcSiJX3SaWCLMa8LEpis18qIVgALMCPQ+/fOch9Da5mhwfuR3nzEWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962762; c=relaxed/simple;
	bh=tJQmVMBzXqzfy2F5Zr9Z3nKiABV7RFJ9zHRHQMzsY8I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsHmwmFjd0m8Lk90t4LxAfOdCQ4XnbT4Iz38qVDOb8tsYsmoA/cHRUsMfK2pVViJTFOEiyOKYZR5sM56I9W10oxMWVaVNgn6tz2cvyCjKhsGt6GtnPFHw6AHm6Db0J94Oh3yVHFwOjaWJhV3IrJ5qaHjrgZ6exQfdxnguelcoyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d67FK5GtFzJ46dm;
	Wed, 12 Nov 2025 23:52:05 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FAF414038F;
	Wed, 12 Nov 2025 23:52:38 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 15:52:37 +0000
Date: Wed, 12 Nov 2025 15:52:36 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v20 07/22] cxl/sfc: Map cxl component regs
Message-ID: <20251112155236.00006e84@huawei.com>
In-Reply-To: <20251112154504.00007eb8@huawei.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
	<20251110153657.2706192-8-alejandro.lucero-palau@amd.com>
	<20251112154504.00007eb8@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 12 Nov 2025 15:45:04 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Mon, 10 Nov 2025 15:36:42 +0000
> alejandro.lucero-palau@amd.com wrote:
> 
> > From: Alejandro Lucero <alucerop@amd.com>
> > 
> > Export cxl core functions for a Type2 driver being able to discover and
> > map the device component registers.
> > 
> > Use it in sfc driver cxl initialization.
> > 
> > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>  
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > ---  
> Side note that it would be really handy when we are down to this last
> version or so before merge to have a short change log in each patch
> (here under the ---)  Saves a bunch of reviewer time checking back on what
> we need to look out for when it might be trivial:
> such as the patch description change in this one
Oops. Replied to wrong patch.  This was meant to be on 08.


