Return-Path: <netdev+bounces-260413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n0p9MvFpnWnhPwQAu9opvQ
	(envelope-from <netdev+bounces-260413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:05:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AB51843B2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15E8830157CE
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD296366815;
	Tue, 24 Feb 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sRC5H0LG"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC60369988;
	Tue, 24 Feb 2026 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923781; cv=none; b=XiOjHxtkOs/rMRY8ov3beoASnwvZzk4BwW9IaEz3UuVG506E4pkbyT7QCiPrQ6l6B6z1OX/VDqHKewfk5wKDDpvja3+gyZI8HKwGkmZAzRnsbtTual8b2nasPBChYzJrXJUGW2+tjTjtOtmQNWVOAwSXJm9NfJ4PfPfYV+rV4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923781; c=relaxed/simple;
	bh=zjABH1ckk5UotRBeSwprouItHny2+6mfl/LIVpNVRKQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IjahqkvYa5t6SUkAXtOm2Hkvu49aQMtRPI74nN19ybwaToXpEbHbqCTs5P2Fu70j/n2t4I3jU+s6EbYgiDgqp2DI7W02nrgr9F2Dy8v7gARuXfHqUbUFgKVSn8A0zbmI9DlHW2cI1dEGdQKS/ZOMpAW5JTomqz8H6EixeT0uCIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sRC5H0LG; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uR/K6DkGMPMKDk7dAD5TcQSdvUxeahKqFkeUtPw8HHU=;
	b=sRC5H0LGs3hd9eYdOOHLeVARyp4gL0PpqjKTQnfiwXMPaXCPOv1rGaKrgeDZsWMdEiJH63kz1
	n7YvrFWAegCibXff6jCv+2YosrUmMyO2T06ggvnTqpTE9KLv73TIu9xfdoIW7kI2NwhxPN4OMMV
	A7ytFpws8LCLpRSoRRKHWoU=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fKs7h3snyz1prKq;
	Tue, 24 Feb 2026 16:58:08 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2247C40569;
	Tue, 24 Feb 2026 17:02:57 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 17:02:56 +0800
Message-ID: <58a37819-78ef-44c0-8e85-fce42ac569af@huawei.com>
Date: Tue, 24 Feb 2026 17:02:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<da.anzani@gmail.com>, <sean@ashe.io>, <mproche@gmail.com>
Subject: Re: [PATCH] vmxnet3: Suppress page allocation warning for massive Rx
 Data ring
To: Aaron Tomlin <atomlin@atomlin.com>, <ronak.doshi@broadcom.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
References: <20260223145604.4042568-1-atomlin@atomlin.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260223145604.4042568-1-atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260413-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[huawei.com,broadcom.com,vger.kernel.org,gmail.com,ashe.io];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 46AB51843B2
X-Rspamd-Action: no action


on 2026/2/23 22:56, Aaron Tomlin wrote:
> The vmxnet3 driver supports an Rx Data ring (rx-mini) to optimise the
> processing of small packets. The size of this ring's DMA-coherent memory
> allocation is determined by the product of the primary Rx ring size and
> the data ring descriptor size:
>
>      sz = rq->rx_ring[0].size * rq->data_ring.desc_size;
>
> When a user configures the maximum supported parameters via ethtool
> (rx_ring[0].size = 4096, data_ring.desc_size = 2048), the required
> contiguous memory allocation reaches 8 MB (8,388,608 bytes).
>
> In environments lacking Contiguous Memory Allocator (CMA),
> dma_alloc_coherent() falls back to the standard zone buddy allocator. An
> 8 MB allocation translates to a page order of 11, which strictly exceeds
> the default MAX_PAGE_ORDER (10) on most architectures.
>
> Consequently, __alloc_pages_noprof() catches the oversize request and
> triggers a loud kernel warning stack trace:
>
>      WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)
>
> This warning is unnecessary and alarming to system administrators because
> the vmxnet3 driver already handles this allocation failure gracefully.
> If dma_alloc_coherent() returns NULL, the driver safely disables the
> Rx Data ring (adapter->rxdataring_enabled = false) and falls back to
> standard, streaming DMA packet processing.
>
> To resolve this, append the __GFP_NOWARN flag to the dma_alloc_coherent()
> gfp_mask. This instructs the page allocator to silently fail the
> allocation if it exceeds order limits or memory is too fragmented,
> preventing the spurious warning stack trace.

This seems to be a suitable solution.
I see many drivers appending the __GFP_NOWARN flag to the dma_alloc_coherent() gfp_mask.

Reviewed-by: Jijie Shao <shaojijie@huawei.com>

>
> Furthermore, enhance the subsequent netdev_err() fallback message to
> include the requested allocation size. This provides critical debugging
> context to the administrator (e.g., revealing that an 8 MB allocation
> was attempted and failed) without making hardcoded assumptions about
> the state of the system's configurations.
>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>   drivers/net/vmxnet3/vmxnet3_drv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
> index 0572f6a9bdb6..0d43210de625 100644
> --- a/drivers/net/vmxnet3/vmxnet3_drv.c
> +++ b/drivers/net/vmxnet3/vmxnet3_drv.c
> @@ -2268,10 +2268,10 @@ vmxnet3_rq_create(struct vmxnet3_rx_queue *rq, struct vmxnet3_adapter *adapter)
>   		rq->data_ring.base =
>   			dma_alloc_coherent(&adapter->pdev->dev, sz,
>   					   &rq->data_ring.basePA,
> -					   GFP_KERNEL);
> +					   GFP_KERNEL | __GFP_NOWARN);
>   		if (!rq->data_ring.base) {
>   			netdev_err(adapter->netdev,
> -				   "rx data ring will be disabled\n");
> +				   "Failed to allocate %zu bytes, rx data ring will be disabled\n", sz);

Here, it seems more appropriate to use "failed to".

>   			adapter->rxdataring_enabled = false;
>   		}
>   	} else {

