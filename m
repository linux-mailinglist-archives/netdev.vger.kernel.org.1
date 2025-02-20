Return-Path: <netdev+bounces-168184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629E8A3DF05
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A787A68E6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7A1FDE26;
	Thu, 20 Feb 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="L+MOj3l2"
X-Original-To: netdev@vger.kernel.org
Received: from lf-2-14.ptr.blmpb.com (lf-2-14.ptr.blmpb.com [101.36.218.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262A1D63F8
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065954; cv=none; b=akx7dSS4wZij5Bz/CHZfUVwgghWZP7r0DkrLNKTVYj8tvROwqgqsM06mAqmmo+X4KhCr/0q7hJ+uwUJP1c52QsuWKZI1xMEgVKHM6ISw27pViudtqzbyqkwo0UxGUzqS4ewG3OJvr602FhLABSFWuAyHlDbUeF3nLX1wSebqvm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065954; c=relaxed/simple;
	bh=he4hTAhgWTx+ZA/FodsXqZ4aec2FmWw1LRB1Ynk+NN0=;
	h=To:Subject:Date:Content-Type:Cc:References:From:Message-Id:
	 Mime-Version:In-Reply-To; b=Ibu5UAJ7DB9tLeboy7mGBbRWVX+ALumz4wyqsmRou5zRBqyzTuUJErMGiQtuJRZGr093vKAM4obIcRsn8kLzenJ8UTfXs9e51ByvHZnt8756NAWPnBOnp7gugjqU+n4AwVk8n1B8RjUDyh0v57BllHet8XdPVWdN4gr3lvPAiwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=L+MOj3l2; arc=none smtp.client-ip=101.36.218.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740065732; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=NpGrn8aOytrn4CUUrmEk7SJeydb2UnWKWO7oO73J2f0=;
 b=L+MOj3l28bVsAFlkQt2xPwBLd8Nk05hw549bYC/JBG65T+Z7ZR8OOCn2CCWirBlxJ3VUMp
 YXLJsxGT735eeKM8dviSaDgif7jujPGl24ZCeJv51y2FPha+BVFAhCumFhivWex95gNBfD
 aDt9XlNuXNasiVO/TWvQxbYA2BtQ06ePcu0MeA1qepn2xy1RlN+i0vyRD0BE3L0tedwgk3
 2BIhJ7KnRSQYww48xl8+dHvDDWWUuew5KmKNTN39mizkBJj0vxDsfNPGFb7Cj/AoXJpTOV
 u+8Ng4ymHLihH3CZWjGiRzQanzqxf0hEV4fySa0H3A+P+GFo4Gdr1nSD69/Hvw==
To: "Simon Horman" <horms@kernel.org>
Subject: Re: [PATCH v4 05/14] net-next/yunsilicon: Add eq and alloc
Date: Thu, 20 Feb 2025 23:35:26 +0800
Content-Type: text/plain; charset=UTF-8
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>
X-Lms-Return-Path: <lba+267b74bc2+0b1e84+vger.kernel.org+tianx@yunsilicon.com>
References: <20250213091402.2067626-1-tianx@yunsilicon.com> <20250213091412.2067626-6-tianx@yunsilicon.com> <20250218171036.GB1615191@kernel.org>
User-Agent: Mozilla Thunderbird
From: "tianx" <tianx@yunsilicon.com>
Message-Id: <b0adf539-8104-452d-ba34-14a120602bd5@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20250218171036.GB1615191@kernel.org>
X-Original-From: tianx <tianx@yunsilicon.com>
Received: from [127.0.0.1] ([183.193.164.49]) by smtp.feishu.cn with ESMTPS; Thu, 20 Feb 2025 23:35:29 +0800

On 2025/2/19 1:10, Simon Horman wrote:
> On Thu, Feb 13, 2025 at 05:14:14PM +0800, Xin Tian wrote:
>> Add eq management and buffer alloc apis
>>
>> Signed-off-by: Xin Tian<tianx@yunsilicon.com>
>> Signed-off-by: Honggang Wei<weihg@yunsilicon.com>
> ...
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> ...
>
>> +struct xsc_eq_table {
>> +	void __iomem	       *update_ci;
>> +	void __iomem	       *update_arm_ci;
>> +	struct list_head       comp_eqs_list;
> nit: The indentation of the member names above seems inconsistent
>       with what is below.
got it
>> +	struct xsc_eq		pages_eq;
>> +	struct xsc_eq		async_eq;
>> +	struct xsc_eq		cmd_eq;
>> +	int			num_comp_vectors;
>> +	int			eq_vec_comp_base;
>> +	/* protect EQs list
>> +	 */
>> +	spinlock_t		lock;
>> +};
> ...
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
> ...
>
>> +/* Handling for queue buffers -- we allocate a bunch of memory and
>> + * register it in a memory region at HCA virtual address 0.  If the
>> + * requested size is > max_direct, we split the allocation into
>> + * multiple pages, so we don't require too much contiguous memory.
>> + */
> I can't help but think there is an existing API to handle this.
failed to find one
>> +int xsc_buf_alloc(struct xsc_core_device *xdev, int size, int max_direct,
> I think unsigned long would be slightly better types for size and max_direct.
yes, will modify
>> +		  struct xsc_buf *buf)
>> +{
>> +	dma_addr_t t;
>> +
>> +	buf->size = size;
>> +	if (size <= max_direct) {
>> +		buf->nbufs        = 1;
>> +		buf->npages       = 1;
>> +		buf->page_shift   = get_order(size) + PAGE_SHIFT;
>> +		buf->direct.buf   = dma_alloc_coherent(&xdev->pdev->dev,
>> +						       size,
>> +						       &t,
>> +						       GFP_KERNEL | __GFP_ZERO);
>> +		if (!buf->direct.buf)
>> +			return -ENOMEM;
>> +
>> +		buf->direct.map = t;
>> +
>> +		while (t & ((1 << buf->page_shift) - 1)) {
> I think GENMASK() can be used here.
ok
>> +			--buf->page_shift;
>> +			buf->npages *= 2;
>> +		}
>> +	} else {
>> +		int i;
>> +
>> +		buf->direct.buf  = NULL;
>> +		buf->nbufs       = (size + PAGE_SIZE - 1) / PAGE_SIZE;
> I think this is open-coding DIV_ROUND_UP
right, I'll change
>> +		buf->npages      = buf->nbufs;
>> +		buf->page_shift  = PAGE_SHIFT;
>> +		buf->page_list   = kcalloc(buf->nbufs, sizeof(*buf->page_list),
>> +					   GFP_KERNEL);
>> +		if (!buf->page_list)
>> +			return -ENOMEM;
>> +
>> +		for (i = 0; i < buf->nbufs; i++) {
>> +			buf->page_list[i].buf =
>> +				dma_alloc_coherent(&xdev->pdev->dev, PAGE_SIZE,
>> +						   &t, GFP_KERNEL | __GFP_ZERO);
>> +			if (!buf->page_list[i].buf)
>> +				goto err_free;
>> +
>> +			buf->page_list[i].map = t;
>> +		}
>> +
>> +		if (BITS_PER_LONG == 64) {
>> +			struct page **pages;
>> +
>> +			pages = kmalloc_array(buf->nbufs, sizeof(*pages),
>> +					      GFP_KERNEL);
>> +			if (!pages)
>> +				goto err_free;
>> +			for (i = 0; i < buf->nbufs; i++) {
>> +				void *addr = buf->page_list[i].buf;
>> +
>> +				if (is_vmalloc_addr(addr))
>> +					pages[i] = vmalloc_to_page(addr);
>> +				else
>> +					pages[i] = virt_to_page(addr);
>> +			}
>> +			buf->direct.buf = vmap(pages, buf->nbufs,
>> +					       VM_MAP, PAGE_KERNEL);
>> +			kfree(pages);
>> +			if (!buf->direct.buf)
>> +				goto err_free;
>> +		}
> I think some explanation is warranted of why the above is relevant
> only when BITS_PER_LONG == 64.
Some strange historical reasons, and no need for the check now. I'll 
clean this up
>> +	}
>> +
>> +	return 0;
>> +
>> +err_free:
>> +	xsc_buf_free(xdev, buf);
>> +
>> +	return -ENOMEM;
>> +}
> ...
>
>> +void xsc_fill_page_array(struct xsc_buf *buf, __be64 *pas, int npages)
> As per my comment on unsigned long in my response to another patch,
> I think npages can be unsigned long.
ok
>> +{
>> +	int shift = PAGE_SHIFT - PAGE_SHIFT_4K;
>> +	int mask = (1 << shift) - 1;
> Likewise, I think that mask should be an unsigned long.
> Or, both shift and mask could be #defines, as they are compile-time
> constants.
>
> Also, mask can be generated using GENMASK, e.g.
>
> #define XSC_PAGE_ARRAY_MASK GENMASK(PAGE_SHIFT, PAGE_SHIFT_4K)
> #define XSC_PAGE_ARRAY_SHIFT (PAGE_SHIFT - PAGE_SHIFT_4K)
>
> And I note, in the (common) case of 4k pages, that both shift and mask are 0.

Thank you for the suggestion, but that's not quite the case here. The 
|shift| and |mask| are not used to extract fields from data. Instead, 
they are part of a calculation. In |xsc_buf_alloc|, we allocate the 
buffer based on the system's page size. However, in this function, we 
need to break each page in the |buflist| into 4KB chunks, populate the 
|pas| array with the corresponding DMA addresses, and then map them to 
hardware.

The |shift| is calculated as |PAGE_SHIFT - PAGE_SHIFT_4K|, allowing us 
to convert the 4KB chunk index (|i|) to the corresponding page index in 
|buflist| with |i >> shift|. The |i & mask| gives us the offset of the 
current 4KB chunk within the page, and by applying |((i & mask) << 
PAGE_SHIFT_4K)|, we can compute the offset of that chunk within the page.

I hope this makes things clearer!

>> +	u64 addr;
>> +	int i;
>> +
>> +	for (i = 0; i < npages; i++) {
>> +		if (buf->nbufs == 1)
>> +			addr = buf->direct.map + (i << PAGE_SHIFT_4K);
>> +		else
>> +			addr = buf->page_list[i >> shift].map
>> +			       + ((i & mask) << PAGE_SHIFT_4K);
> The like above is open-coding FIELD_PREP().
> However, I don't think it can be used here as
> the compiler complains very loudly because the mask is 0.

>> +
>> +		pas[i] = cpu_to_be64(addr);
>> +	}
>> +}
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
> ...
>
>> +static void eq_update_ci(struct xsc_eq *eq, int arm)
>> +{
>> +	struct xsc_eq_doorbell db = {0};
>> +
>> +	db.data0 = XSC_SET_FIELD(cpu_to_le32(eq->cons_index),
>> +				 XSC_EQ_DB_NEXT_CID) |
>> +		   XSC_SET_FIELD(cpu_to_le32(eq->eqn), XSC_EQ_DB_EQ_ID);
> Each of the two uses of XSC_SET_FIELD() are passed a little-endian value
> and a host-byte order mask. This does not seem correct as it seems
> they byte order should be consistent.
>> +	if (arm)
>> +		db.data0 |= XSC_EQ_DB_ARM;
> Likewise, here data0 is little-endian while XSC_EQ_DB_ARM is host
> byte-order.
>
>> +	writel(db.data0, XSC_REG_ADDR(eq->dev, eq->doorbell));
> And here, db.data0 is little-endian, but writel expects a host-byte order
> value (which it converts to little-endian).
>
> I didn't dig deeper but it seems to me that it would be easier to change
> the type of data0 to host byte-order and drop the use of cpu_to_le32()
> above.
>
> Issues flagged by Sparse.
>
>> +	/* We still want ordering, just not swabbing, so add a barrier */
>> +	mb();
>> +}
> ...
>
>> +static int xsc_eq_int(struct xsc_core_device *xdev, struct xsc_eq *eq)
>> +{
>> +	u32 cqn, qpn, queue_id;
>> +	struct xsc_eqe *eqe;
>> +	int eqes_found = 0;
>> +	int set_ci = 0;
>> +
>> +	while ((eqe = next_eqe_sw(eq))) {
>> +		/* Make sure we read EQ entry contents after we've
>> +		 * checked the ownership bit.
>> +		 */
>> +		rmb();
>> +		switch (eqe->type) {
>> +		case XSC_EVENT_TYPE_COMP:
>> +		case XSC_EVENT_TYPE_INTERNAL_ERROR:
>> +			/* eqe is changing */
>> +			queue_id = le16_to_cpu(XSC_GET_FIELD(eqe->queue_id_data,
>> +							     XSC_EQE_QUEUE_ID));
> Similarly, here XSC_GET_FIELD() is passed a little-endian value and a host
> byte-order mask, which is inconsistent.
>
> Perhaps this should be (completely untested!):
>
> 			queue_id = XSC_GET_FIELD(le16_to_cpu(eqe->queue_id_data),
> 						 XSC_EQE_QUEUE_ID);
>
> Likewise for the two uses of XSC_GET_FIELD below.

I have noticed the sparse check warnings on Patchwork, and I will 
address all the related issues in the next version.

> And perhaps queue_id could be renamed, say to q_id, to make things a bit
> more succinct.
>
>> +			cqn = queue_id;
> I'm unsure why both cqn and queue_id are needed.
The |queue_id| is indeed a bit redundant, and I will remove it.
>> +			xsc_cq_completion(xdev, cqn);
>> +			break;
>> +
>> +		case XSC_EVENT_TYPE_CQ_ERROR:
>> +			queue_id = le16_to_cpu(XSC_GET_FIELD(eqe->queue_id_data,
>> +							     XSC_EQE_QUEUE_ID));
>> +			cqn = queue_id;
>> +			xsc_eq_cq_event(xdev, cqn, eqe->type);
>> +			break;
>> +		case XSC_EVENT_TYPE_WQ_CATAS_ERROR:
>> +		case XSC_EVENT_TYPE_WQ_INVAL_REQ_ERROR:
>> +		case XSC_EVENT_TYPE_WQ_ACCESS_ERROR:
>> +			queue_id = le16_to_cpu(XSC_GET_FIELD(eqe->queue_id_data,
>> +							     XSC_EQE_QUEUE_ID));
>> +			qpn = queue_id;
>> +			xsc_qp_event(xdev, qpn, eqe->type);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +
>> +		++eq->cons_index;
>> +		eqes_found = 1;
>> +		++set_ci;
>> +
>> +		/* The HCA will think the queue has overflowed if we
>> +		 * don't tell it we've been processing events.  We
>> +		 * create our EQs with XSC_NUM_SPARE_EQE extra
>> +		 * entries, so we must update our consumer index at
>> +		 * least that often.
>> +		 */
>> +		if (unlikely(set_ci >= XSC_NUM_SPARE_EQE)) {
>> +			eq_update_ci(eq, 0);
>> +			set_ci = 0;
>> +		}
>> +	}
>> +
>> +	eq_update_ci(eq, 1);
>> +
>> +	return eqes_found;
>> +}
> ...

