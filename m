Return-Path: <netdev+bounces-169283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11A8A4331B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0143C3A90C2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 02:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34B1CAB3;
	Tue, 25 Feb 2025 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="KfnjNFpl"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-52.ptr.blmpb.com (va-2-52.ptr.blmpb.com [209.127.231.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F664433D1
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450885; cv=none; b=WWRnbbVo4uKPhN0GcN6JA8/ALx7ryXzu8RSbXEZaY9uNUYcc9454Rr3RQrVc7EKwCbeEg70HQ57CVaj3kPVcZWUTPwr2GcQTyPajRdMdch9lfX1u5UnEo1SsBPesCHMUXnyFWmF7/hO9GJZQOo4+ZhzWu7BAKIjeA24gVrvSQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450885; c=relaxed/simple;
	bh=vtWe8La/5sR1aKe+brYkhc81Uw7Zs3bXUpbCsjEXqAY=;
	h=To:Date:References:In-Reply-To:From:Message-Id:Content-Type:Cc:
	 Subject:Mime-Version; b=VUrtNRAvI+qRQickgT6iW3laeIWbVLN8XF1it1M7J0eJWEQD6CrQD3sQFJejDkSs55Yi5hYr2MDJyP4kAZO1jMDlxl/Yu58Hk2/La817kfSPaxwB5FIsMWJpppITHPIr/iCJcPaff2JyANOnVEdaAW5zS/v+gVhZXam2nlGjz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=KfnjNFpl; arc=none smtp.client-ip=209.127.231.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740450869; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=nJ3rL96eWpm3FW2wAvIwiJyEXvFF6g+f2WIdIeJVNiQ=;
 b=KfnjNFplGXJx2vtQiYKxphQHQHS3VQTO/ZJZsAWkVfWQs0rqRv4uLz3BTJuk9+pqe6NIql
 H0e3qa/N8xlCBq/M6V4mrRAUHVEXicW8OGs3bok3XuVFqDBqldpFskkepOdT7QqStyhIXU
 EmiC2Rlih4sMdrK8xwHX5oKVpHFfKed0smBH5osBistMG2IWXjaoWj6M5vfelQ6Nxs+wNZ
 jmAderKZBPw+eg14mMZcRwxz0Can4fj8//4ZKoJsfNtVOlDOy3Rls6vo8T/88eGDpjdalC
 MGlstYhSMGJuC9D24xLXpmynFs3ZE6Ja4B8EU6wmUfwRo/cND5gyjP/13ORUfA==
To: "Simon Horman" <horms@kernel.org>
Date: Tue, 25 Feb 2025 10:34:24 +0800
References: <20250213091402.2067626-1-tianx@yunsilicon.com> <20250213091412.2067626-6-tianx@yunsilicon.com> <20250218171036.GB1615191@kernel.org> <b0adf539-8104-452d-ba34-14a120602bd5@yunsilicon.com> <20250224185817.GH1615191@kernel.org>
In-Reply-To: <20250224185817.GH1615191@kernel.org>
User-Agent: Mozilla Thunderbird
From: "Xin Tian" <tianx@yunsilicon.com>
Message-Id: <9b96cab4-e433-4752-a668-1d8ff262be2a@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>
Subject: Re: [PATCH v4 05/14] net-next/yunsilicon: Add eq and alloc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+267bd2c33+3014ca+vger.kernel.org+tianx@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Tue, 25 Feb 2025 10:34:26 +0800

On 2025/2/25 2:58, Simon Horman wrote:
> On Thu, Feb 20, 2025 at 11:35:26PM +0800, tianx wrote:
>> On 2025/2/19 1:10, Simon Horman wrote:
>>> On Thu, Feb 13, 2025 at 05:14:14PM +0800, Xin Tian wrote:
> ...
>
>>>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
>>> ...
>>>
>>>> +/* Handling for queue buffers -- we allocate a bunch of memory and
>>>> + * register it in a memory region at HCA virtual address 0.  If the
>>>> + * requested size is > max_direct, we split the allocation into
>>>> + * multiple pages, so we don't require too much contiguous memory.
>>>> + */
>>> I can't help but think there is an existing API to handle this.
>> failed to find one
> Yes, me neither.
>
>>>> +int xsc_buf_alloc(struct xsc_core_device *xdev, int size, int max_direct,
>>> I think unsigned long would be slightly better types for size and max_direct.
>> yes, will modify
>>>> +		  struct xsc_buf *buf)
>>>> +{
>>>> +	dma_addr_t t;
>>>> +
>>>> +	buf->size = size;
>>>> +	if (size <= max_direct) {
>>>> +		buf->nbufs        = 1;
>>>> +		buf->npages       = 1;
>>>> +		buf->page_shift   = get_order(size) + PAGE_SHIFT;
>>>> +		buf->direct.buf   = dma_alloc_coherent(&xdev->pdev->dev,
>>>> +						       size,
>>>> +						       &t,
>>>> +						       GFP_KERNEL | __GFP_ZERO);
>>>> +		if (!buf->direct.buf)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		buf->direct.map = t;
>>>> +
>>>> +		while (t & ((1 << buf->page_shift) - 1)) {
>>> I think GENMASK() can be used here.
>> ok
>>>> +			--buf->page_shift;
>>>> +			buf->npages *= 2;
>>>> +		}
>>>> +	} else {
>>>> +		int i;
>>>> +
>>>> +		buf->direct.buf  = NULL;
>>>> +		buf->nbufs       = (size + PAGE_SIZE - 1) / PAGE_SIZE;
>>> I think this is open-coding DIV_ROUND_UP
>> right, I'll change
>>>> +		buf->npages      = buf->nbufs;
>>>> +		buf->page_shift  = PAGE_SHIFT;
>>>> +		buf->page_list   = kcalloc(buf->nbufs, sizeof(*buf->page_list),
>>>> +					   GFP_KERNEL);
>>>> +		if (!buf->page_list)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		for (i = 0; i < buf->nbufs; i++) {
>>>> +			buf->page_list[i].buf =
>>>> +				dma_alloc_coherent(&xdev->pdev->dev, PAGE_SIZE,
>>>> +						   &t, GFP_KERNEL | __GFP_ZERO);
>>>> +			if (!buf->page_list[i].buf)
>>>> +				goto err_free;
>>>> +
>>>> +			buf->page_list[i].map = t;
>>>> +		}
>>>> +
>>>> +		if (BITS_PER_LONG == 64) {
>>>> +			struct page **pages;
>>>> +
>>>> +			pages = kmalloc_array(buf->nbufs, sizeof(*pages),
>>>> +					      GFP_KERNEL);
>>>> +			if (!pages)
>>>> +				goto err_free;
>>>> +			for (i = 0; i < buf->nbufs; i++) {
>>>> +				void *addr = buf->page_list[i].buf;
>>>> +
>>>> +				if (is_vmalloc_addr(addr))
>>>> +					pages[i] = vmalloc_to_page(addr);
>>>> +				else
>>>> +					pages[i] = virt_to_page(addr);
>>>> +			}
>>>> +			buf->direct.buf = vmap(pages, buf->nbufs,
>>>> +					       VM_MAP, PAGE_KERNEL);
>>>> +			kfree(pages);
>>>> +			if (!buf->direct.buf)
>>>> +				goto err_free;
>>>> +		}
>>> I think some explanation is warranted of why the above is relevant
>>> only when BITS_PER_LONG == 64.
>> Some strange historical reasons, and no need for the check now. I'll
>> clean this up
> Thanks.
>
> If you do need 64bit only logic, then perhaps it can be moved to a
> separate function. It could guard code using something like this.
>
> int some_func(struct xsc_buf *buf)
> {
> 	if (!IS_ENABLED(CONFIG_64BIT))
> 		return 0;
>
> 	...
> }
>
> Or if that is not possible, something like this:
>
> #ifdef CONFIG_64BIT
> int some_func(struct xsc_buf *buf)
> {
> 	...
> }
> #else /* CONFIG_64BIT */
> int some_func(struct xsc_buf *buf) { return 0; }
> #fi /* CONFIG_64BIT */
>
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +
>>>> +err_free:
>>>> +	xsc_buf_free(xdev, buf);
>>>> +
>>>> +	return -ENOMEM;
>>>> +}
>>> ...
>>>
>>>> +void xsc_fill_page_array(struct xsc_buf *buf, __be64 *pas, int npages)
>>> As per my comment on unsigned long in my response to another patch,
>>> I think npages can be unsigned long.
>> ok
>>>> +{
>>>> +	int shift = PAGE_SHIFT - PAGE_SHIFT_4K;
>>>> +	int mask = (1 << shift) - 1;
>>> Likewise, I think that mask should be an unsigned long.
>>> Or, both shift and mask could be #defines, as they are compile-time
>>> constants.
>>>
>>> Also, mask can be generated using GENMASK, e.g.
>>>
>>> #define XSC_PAGE_ARRAY_MASK GENMASK(PAGE_SHIFT, PAGE_SHIFT_4K)
>>> #define XSC_PAGE_ARRAY_SHIFT (PAGE_SHIFT - PAGE_SHIFT_4K)
>>>
>>> And I note, in the (common) case of 4k pages, that both shift and mask are 0.
>> Thank you for the suggestion, but that's not quite the case here. The
>> |shift| and |mask| are not used to extract fields from data. Instead,
>> they are part of a calculation. In |xsc_buf_alloc|, we allocate the
>> buffer based on the system's page size. However, in this function, we
>> need to break each page in the |buflist| into 4KB chunks, populate the
>> |pas| array with the corresponding DMA addresses, and then map them to
>> hardware.
>>
>> The |shift| is calculated as |PAGE_SHIFT - PAGE_SHIFT_4K|, allowing us
>> to convert the 4KB chunk index (|i|) to the corresponding page index in
>> |buflist| with |i >> shift|. The |i & mask| gives us the offset of the
>> current 4KB chunk within the page, and by applying |((i & mask) <<
>> PAGE_SHIFT_4K)|, we can compute the offset of that chunk within the page.
>>
>> I hope this makes things clearer!
> Thanks, that is clear.
>
> I do still think that the shift and mask could
> be compile-time constants rather than local variables.
> And it does seem to me that GENMASK can be used to generate the mask.

Hi, Simon,

Assuming we use GENMASK, the mask should be defined as GENMASK(shift - 
1, 0).

When the system page size is 4K, shift will be 0, which will cause an error.


>
> ...

