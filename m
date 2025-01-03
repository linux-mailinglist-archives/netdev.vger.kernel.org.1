Return-Path: <netdev+bounces-154962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A2BA00809
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3DC188180D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9311D131E;
	Fri,  3 Jan 2025 10:47:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF201D4609;
	Fri,  3 Jan 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735901251; cv=none; b=MbAlBo66EGjxXo3p47Rhduyhff4cbmzOYc+Fi9TuuwQQ/COlAD8pNZK0taZbEPtWBFU44ILN7fb1vStZv7LbaJG+533lQN952xMeEguz+RNa59aXHM8PHEcorOwAQy3CC+Ku2k96BZaeDzGqgCukSTI/bYTe1nfaV70ij1YGBYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735901251; c=relaxed/simple;
	bh=oQDxuRLXtK+AxARyuFCYlhLb97y2OYHLgPoaku9P428=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gk3jqSZZIpjPs9npHb6M0sZRiqPjAWQzdMsWOLtr0tc/DGS/NHCzYhYz6cZ8thgHq3ndd4qu4ZvX94w8s0KTmR0XDpbQv7rj49nGp3N2H/NvKU7m3dMZc9Mp7tXHIVQ4cLlft56dLAIIddwU2DqvAUjowP/Ro38soXzTAR8oggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YPgC60D7mz6K60p;
	Fri,  3 Jan 2025 18:42:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 57DC8140257;
	Fri,  3 Jan 2025 18:47:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 3 Jan
 2025 11:47:18 +0100
Date: Fri, 3 Jan 2025 10:47:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v8 03/27] cxl: add capabilities field to cxl_dev_state
 and cxl_port
Message-ID: <20250103104717.00002554@huawei.com>
In-Reply-To: <04a40923-d3ca-1b4a-7c05-2eedea707818@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-4-alejandro.lucero-palau@amd.com>
	<20241224170855.0000295c@huawei.com>
	<81786f5a-42b0-2e5a-c2d6-bfd93b366d97@amd.com>
	<20250102124944.0000260e@huawei.com>
	<04a40923-d3ca-1b4a-7c05-2eedea707818@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 3 Jan 2025 07:16:51 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 1/2/25 12:49, Jonathan Cameron wrote:
> >>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> >>>> index 19e5d883557a..f656fcd4945f 100644
> >>>> --- a/include/cxl/cxl.h
> >>>> +++ b/include/cxl/cxl.h
> >>>> @@ -12,6 +12,25 @@ enum cxl_resource {
> >>>>    	CXL_RES_PMEM,
> >>>>    };
> >>>>    
> >>>> +/* Capabilities as defined for:
> >>>> + *
> >>>> + *	Component Registers (Table 8-22 CXL 3.1 specification)
> >>>> + *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
> >>>> + *
> >>>> + * and currently being used for kernel CXL support.
> >>>> + */
> >>>> +
> >>>> +enum cxl_dev_cap {
> >>>> +	/* capabilities from Component Registers */
> >>>> +	CXL_DEV_CAP_RAS,
> >>>> +	CXL_DEV_CAP_HDM,
> >>>> +	/* capabilities from Device Registers */
> >>>> +	CXL_DEV_CAP_DEV_STATUS,
> >>>> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
> >>>> +	CXL_DEV_CAP_MEMDEV,
> >>>> +	CXL_MAX_CAPS = 64  
> >>> Why set it to 64?  All the bitmaps etc will autosize so
> >>> you just need to ensure you use correct set_bit() and test_bit()
> >>> that are happy dealing with bitmaps of multiple longs.
> >>>     
> >> Initially it was set to 32, but DECLARE_BITMAP uses unsigned long, so
> >> for initializing/zeroing the locally allocated bitmap in some functions,
> >> bitmap_clear had to use sizeof for the size, and I was suggested to
> >> define CXL_MAX_CAPS to 64 and use it instead, what seems cleaner.  
> > It should never have been using sizeof() once it was a bitmap.
> > Just clear what is actually used and make sure no code assumes
> > any particular length of bitmap.  Then you will never have
> > to deal with changing it.  
> 
> 
> The problem I had was to zeroing a locally allocated bitmap for avoiding 
> random bits set by the previous use of that memory.
> 
> The macros/functions like bitmap_clear or bitmap_zero require a start 
> and a number of bits, and I did not find any other way than using sizeof.

CXL_MAX_CAPS is fine, but set it to 5 (automatically by making it last
element in enum), not 64 which is made up value and gains you nothing that
I can see.   As you can see in the bitmap_zero implementation:

static __always_inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
{
	unsigned int len = bitmap_size(nbits);

	if (small_const_nbits(nbits))
		*dst = 0;
	else
		memset(dst, 0, len);
}

If it fits in an unsigned long it will just do *dst = 0
which is what we want, but if the bitmap grows in future it will just
do the right thing.

No need for a magic 64 or anything else.

Jonathan

> 
> I was not happy with it, although it was fine for current needs of a 
> bitmap not bigger than unsigned long size. But I was told to use the 
> CXL_MAX_CAPS as currently implemented for using that for the zeroing.
> 
> 
> >
> > Then CXL_MAX_CAP just becomes last entry in this enum.
> >
> > The only time this is becomes tricky with bitmaps is if you need
> > to set a bits in a constant bitmap as then you can't use the
> > set/get functions and have to assume something about the length.
> >
> > Don't think that applies here.
> >
> > Jonathan
> >
> >     
> >>  
> >>>> +};
> >>>> +
> >>>>    struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> >>>>    
> >>>>    void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);  


