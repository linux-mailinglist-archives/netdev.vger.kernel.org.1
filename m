Return-Path: <netdev+bounces-168061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C843CA3D402
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8AA7A79BF
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19B1EB9FD;
	Thu, 20 Feb 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="GpR3eduV"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-44.ptr.blmpb.com (va-2-44.ptr.blmpb.com [209.127.231.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB57179A7
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041923; cv=none; b=uTUX9gd8q7kCaxrljlqetdIZ9jiAGnO3iu0V63XU5yA08U3NAdpFFAQCQNbiQq/NchKTAiAN+MjoUNKp7cAmYtUW1V6M9S/cFHdkmghQfb1pVQ1gDW+1aCyIIMY0qOIgH7zqicxm0WL6W/Y7aMTJG/JhEN9es5GB3vre/wV6GR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041923; c=relaxed/simple;
	bh=ZeRhDPr+7INqjOTZvLDT5xceuifZ4AX1MsVLWP28Dpg=;
	h=In-Reply-To:Mime-Version:References:Date:Message-Id:From:Subject:
	 To:Content-Type:Cc; b=s5c/ybCzElrdxqgYMvStZe1Z/H+iu2POBbiJ7lHSGuMOQCNncZ3+VE1tx1rqD9XagDscT5edcqNeVheBfwOJ3sVaMOcUKLVO5v7unTc20ivZeKvDpgwCBtRdbhbH/YJ77LyG2KPb0QTq2s3lyd5tAhP068UnXqW6GwWWpkYUTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=GpR3eduV; arc=none smtp.client-ip=209.127.231.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740041904; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=zKzz/mNfZSGm9WmkaKbCfXgZrSogtjs+ag2dfjHvdYs=;
 b=GpR3eduVJV39NK4gIFwIIJHdRqicg4v/3ccfkooZCsq/+pe/gxvZ4QxrabkKJLIXOBJ3D2
 tRbR3mAaLB2F9gTtL8G/GOXGq//pcXPkwfoDcnOq2UtxKj72Bftsc50WhOe24+uQIctbMy
 a+f+SeHBsD0aNlqM08igr/woKTNOhFXahLCYQ5jP5eh4v0sfaIUY2DRJViutNoZpc1Z01S
 01FdXq1hwlGGa8gxlKCGCBrEnX7IiyCbvcNDzzo3lE+vzSXJuv9kcHQGLeXET64RdLb3vh
 MDiv7Yn9miuOwbZpjOUK902q6ZjggOarrvwQF3yFFMZ+wayABsbI3GT3JYDcmQ==
In-Reply-To: <20250218163122.GA1615191@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213091402.2067626-1-tianx@yunsilicon.com> <20250213091410.2067626-5-tianx@yunsilicon.com> <20250218163122.GA1615191@kernel.org>
Date: Thu, 20 Feb 2025 16:58:21 +0800
Message-Id: <13847c17-9c71-42ef-a1dd-31ef29caabf5@yunsilicon.com>
From: "tianx" <tianx@yunsilicon.com>
Subject: Re: [PATCH v4 04/14] net-next/yunsilicon: Add qp and cq management
X-Lms-Return-Path: <lba+267b6eeae+18afc5+vger.kernel.org+tianx@yunsilicon.com>
To: "Simon Horman" <horms@kernel.org>
X-Original-From: tianx <tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Thu, 20 Feb 2025 16:58:21 +0800
Content-Type: text/plain; charset=UTF-8
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>
Content-Transfer-Encoding: 7bit

[PATCH v4 04/14] net-next/yunsilicon: Add qp and cq management

On 2025/2/19 0:31, Simon Horman wrote:
> On Thu, Feb 13, 2025 at 05:14:11PM +0800, Xin Tian wrote:
>> Add qp(queue pair) and cq(completion queue) resource management APIs
>>
>> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
>> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> Some general remark regarding this patchset:
>
> 1. "xsc" is probably a more appropriate prefix than "net-next/yunsilicon"
>     in the patch subjects: it seems to be the name of the driver, and
>     conveniently is nice and short.
> 2. Please provide more descriptive patch descriptions, ideally
>     explaining why changes are being made. As this is a new driver
>     I think it is appropriate for the "why" to to describe how
>     the patches fill-out the driver, leading to something users
>     can use.
>
> ...
OK, I will change subjects and add more descriptions in next version
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> index 4c8b26660..4e19b0989 100644
>> --- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> @@ -29,6 +29,14 @@
>>   
>>   #define XSC_REG_ADDR(dev, offset)	\
>>   	(((dev)->bar) + ((offset) - 0xA0000000))
>> +#define XSC_SET_FIELD(value, field)	\
>> +	(((value) << field ## _SHIFT) & field ## _MASK)
>> +#define XSC_GET_FIELD(word, field)	\
>> +	(((word)  & field ## _MASK) >> field ## _SHIFT)
> I did not try, but I expect that if you express XSC_SET_FIELD() and
> XSC_GET_FIELD() in terms of FIELD_PREP() and FIELD_GET() then the _SHIFT
> part disappears. And, ideally, the corresponding _SHIFT defines don't need
> to be defined.
You're right, with FIELD_PREP and FIELD_GET, there's no need to add 
XSC_SET_FIELD and XSC_GET_FIELD anymore. Thanks a lot!
>> +
>> +enum {
>> +	XSC_MAX_EQ_NAME	= 20
>> +};
>>   
>>   enum {
>>   	XSC_MAX_PORTS	= 2,
>> @@ -44,6 +52,147 @@ enum {
>>   	XSC_MAX_UUARS		= XSC_MAX_UAR_PAGES * XSC_BF_REGS_PER_PAGE,
>>   };
>>   
>> +// alloc
>> +struct xsc_buf_list {
>> +	void		       *buf;
>> +	dma_addr_t		map;
>> +};
>> +
>> +struct xsc_buf {
>> +	struct xsc_buf_list	direct;
>> +	struct xsc_buf_list	*page_list;
>> +	int			nbufs;
>> +	int			npages;
>> +	int			page_shift;
>> +	int			size;
> Looking over the way the fields are used in this patchset
> I think that unsigned long would be slightly better types
> for nbufs, npages, and size.
>
> And more generally, I think it would be nice to use unsigned
> types throughout this patchset for, in structure members, function
> parameters, and local variables, to hold unsigned values.
>
> And likewise to use unsigned long (instead of unsigned int) as
> appropriate, e.g. the size parameter of xsc_buf_alloc() which
> is passed to get_order() in a subsequent patch in this series.
Sure, I will change these.
>> +};
>> +
>> +struct xsc_frag_buf {
>> +	struct xsc_buf_list	*frags;
>> +	int			npages;
>> +	int			size;
>> +	u8			page_shift;
>> +};
>> +
>> +struct xsc_frag_buf_ctrl {
>> +	struct xsc_buf_list	*frags;
>> +	u32			sz_m1;
>> +	u16			frag_sz_m1;
>> +	u16			strides_offset;
>> +	u8			log_sz;
>> +	u8			log_stride;
>> +	u8			log_frag_strides;
>> +};
> ...

