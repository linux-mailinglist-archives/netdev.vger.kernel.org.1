Return-Path: <netdev+bounces-154725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9229FF981
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448491883608
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766201AF0C5;
	Thu,  2 Jan 2025 12:49:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942A191F60;
	Thu,  2 Jan 2025 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735822191; cv=none; b=CYWV3GFb7s7ijv615TN9UAGv+R4RyOiZZPYIwSfDiCxOkZQiQN0U2PvR0yuhVH27avmEONA625aUMmH3Hg4VBRzSlTkRSY35xswbZXYYFh3u+eRXzOdv95vpEed2QXcj4syq+M1m+uYNdYNAGIilGPbgCg+LPaqleme6Nka0JoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735822191; c=relaxed/simple;
	bh=stvNx4Z9HnQEe7rq9Fe5iB1tRD0lGnZuUmQbZmTWdzA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKEDJuBuk6CqHT0xIcQr16u8OAk6PA5C6a8JNc1KzCPDnpZ1POWJgFSSUnX9NouDFCpVColaTfYisgtO5ElDVdZh82zNWKmwU8+DbTgEGeLqJK6H5SwQlZmiC2utmZ7l8ZK13RtQNdfdceNraId9rR7PPO+MQqZIVSSJDt+zIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YP62x2LGqz6K6Wl;
	Thu,  2 Jan 2025 20:48:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 09C72140A9C;
	Thu,  2 Jan 2025 20:49:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 2 Jan
 2025 13:49:45 +0100
Date: Thu, 2 Jan 2025 12:49:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v8 03/27] cxl: add capabilities field to cxl_dev_state
 and cxl_port
Message-ID: <20250102124944.0000260e@huawei.com>
In-Reply-To: <81786f5a-42b0-2e5a-c2d6-bfd93b366d97@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-4-alejandro.lucero-palau@amd.com>
	<20241224170855.0000295c@huawei.com>
	<81786f5a-42b0-2e5a-c2d6-bfd93b366d97@amd.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)


> >> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> >> index 19e5d883557a..f656fcd4945f 100644
> >> --- a/include/cxl/cxl.h
> >> +++ b/include/cxl/cxl.h
> >> @@ -12,6 +12,25 @@ enum cxl_resource {
> >>   	CXL_RES_PMEM,
> >>   };
> >>   
> >> +/* Capabilities as defined for:
> >> + *
> >> + *	Component Registers (Table 8-22 CXL 3.1 specification)
> >> + *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
> >> + *
> >> + * and currently being used for kernel CXL support.
> >> + */
> >> +
> >> +enum cxl_dev_cap {
> >> +	/* capabilities from Component Registers */
> >> +	CXL_DEV_CAP_RAS,
> >> +	CXL_DEV_CAP_HDM,
> >> +	/* capabilities from Device Registers */
> >> +	CXL_DEV_CAP_DEV_STATUS,
> >> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
> >> +	CXL_DEV_CAP_MEMDEV,
> >> +	CXL_MAX_CAPS = 64  
> > Why set it to 64?  All the bitmaps etc will autosize so
> > you just need to ensure you use correct set_bit() and test_bit()
> > that are happy dealing with bitmaps of multiple longs.
> >  
> 
> Initially it was set to 32, but DECLARE_BITMAP uses unsigned long, so 
> for initializing/zeroing the locally allocated bitmap in some functions, 
> bitmap_clear had to use sizeof for the size, and I was suggested to 
> define CXL_MAX_CAPS to 64 and use it instead, what seems cleaner.

It should never have been using sizeof() once it was a bitmap.
Just clear what is actually used and make sure no code assumes
any particular length of bitmap.  Then you will never have
to deal with changing it.

Then CXL_MAX_CAP just becomes last entry in this enum.

The only time this is becomes tricky with bitmaps is if you need
to set a bits in a constant bitmap as then you can't use the
set/get functions and have to assume something about the length.

Don't think that applies here.

Jonathan

 
> 
> 
> >> +};
> >> +
> >>   struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> >>   
> >>   void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);  


