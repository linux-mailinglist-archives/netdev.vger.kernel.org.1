Return-Path: <netdev+bounces-183424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5585A90A08
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2CB44542B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F1B21771A;
	Wed, 16 Apr 2025 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wYBT/o8r"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F7217673
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824933; cv=none; b=EjJ+9aCqBj52M3oVfA8m79eFRMTGSlQ+ORDS/Rg6pe3K4FZdyZQiR/NGw37Za8K1Z/fYHbdjGLlLPghGDZ3yUFn6WcG1pktngZf9Ve+6oqPrZTtD7Kx/fIL3N2iuwLlG734ocSemiUCm1N3CUKAV6UGWQAWRUmdGCwvRoijX/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824933; c=relaxed/simple;
	bh=XemuQ0eRYtJvp1uNfDhM3a9CJEZdGiJRLjgEQiFS+k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clYvgyQaWjKznujeoK2+UBjgGvsQT0ZR3ckJ/p/XSyezOIGfX1bmks0vPEoKP5zufXqhhHE6ZUxyxLrue+3+/dI20Y1LJS1JXuFTwlulSQSnQW0pF2jQY/0I8UmWvFeutUeV7cPcEVHOBlIT0jAFgPVDODbMnI9wNhPyg69uEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wYBT/o8r; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d39958c8-4f2f-4aa9-94db-e1f5c3a6b615@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744824926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vptg2Zk8dWJzsw7advTS99WGzx63RloJ7VvDovrVzGs=;
	b=wYBT/o8rP+HQp69Ha/VhiCl/WEYhOCY3043CuZnDCF+zzF8jsGrDaWOoeTC1fA2oJeCo4L
	2cbTk4GCM0ueouyQt5GuEQM9WEK9H6f1/GgRgjLwIBw9vKWM7ST0ssmR3Uy4kohbOf89vr
	UXu+Q0odAEOSIDvCklVU0ltC2J1y2FA=
Date: Wed, 16 Apr 2025 18:35:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] bnxt_en: improve TX timestamping FIFO configuration
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski
 <kuba@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
References: <20250416150057.3904571-1-vadfed@meta.com>
 <CACKFLin8=vm8MBBFpFgJv2Jw4Vn_m43cvXZUEMTfhgFnjZ+m1w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CACKFLin8=vm8MBBFpFgJv2Jw4Vn_m43cvXZUEMTfhgFnjZ+m1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 16/04/2025 18:03, Michael Chan wrote:
> On Wed, Apr 16, 2025 at 8:01 AM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> Reconfiguration of netdev may trigger close/open procedure which can
>> break FIFO status by adjusting the amount of empty slots for TX
>> timestamps. But it is not really needed because timestamps for the
>> packets sent over the wire still can be retrieved. On the other side,
>> during netdev close procedure any skbs waiting for TX timestamps can be
>> leaked because there is no cleaning procedure called. Free skbs waiting
>> for TX timestamps when closing netdev.
>>
>> Fixes: 8aa2a79e9b95 ("bnxt_en: Increase the max total outstanding PTP TX packets to 4")
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  4 ++--
>>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 23 +++++++++++++++++++
>>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  1 +
>>   3 files changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index c8e3468eee61..45d178586316 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -3517,6 +3517,8 @@ static void bnxt_free_skbs(struct bnxt *bp)
>>   {
>>          bnxt_free_tx_skbs(bp);
>>          bnxt_free_rx_skbs(bp);
>> +       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
>> +               bnxt_ptp_free_txts_skbs(bp->ptp_cfg);
> 
> Since these are TX SKBs, it's slightly more logical if we put this in
> bnxt_free_tx_skbs().

Do you mean to move this chunk to bnxt_free_tx_skbs() ?
I put it here because the driver has 3 different FIFOs to keep SKBs,
and it's logical to move PTP FIFO free function out of TX part..
But have no strong opinion.

>>   }
>>
>>   static void bnxt_init_ctx_mem(struct bnxt_ctx_mem_type *ctxm, void *p, int len)
> 
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> index 2d4e19b96ee7..39dc4f1f651a 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> @@ -794,6 +794,29 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
>>          return HZ;
>>   }
>>
>> +void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp)
>> +{
>> +       struct bnxt_ptp_tx_req *txts_req;
>> +       u16 cons = ptp->txts_cons;
>> +
>> +       /* make sure ptp aux worker finished with
>> +        * possible BNXT_STATE_OPEN set
>> +        */
>> +       ptp_cancel_worker_sync(ptp->ptp_clock);
>> +
>> +       spin_lock_bh(&ptp->ptp_tx_lock);
> 
> I think the spinlock is not needed because bnxt_tx_disable() should
> have been called already in the close path.

Hmm ... ok, yeah, TX won't be woken up at that moment. I'll remove it.

> 
>> +       ptp->tx_avail = BNXT_MAX_TX_TS;
>> +       while (cons != ptp->txts_prod) {
>> +               txts_req = &ptp->txts_req[cons];
>> +               if (!IS_ERR_OR_NULL(txts_req->tx_skb))
>> +                       dev_kfree_skb_any(txts_req->tx_skb);
>> +               cons = NEXT_TXTS(cons);
> 
> I think we can remove the similar code we have in bnxt_ptp_clear().
> We should always go through this path before bnxt_ptp_clear().

The difference with bnxt_ptp_clear() code is that this one clears SKBs
waiting in the queue according to consumer/producer pointers while
bnxt_ptp_clear() iterates over all slots, a bit more on safe side. 
Should I adjust this part to check all slots before removing
bnxt_ptp_clear() FIFO manipulations?

I believe in the normal way of things there should be no need to iterate
over all slots, but maybe you think of some conditions when we have to
check all slots?

> 
> Thanks for the patch.


