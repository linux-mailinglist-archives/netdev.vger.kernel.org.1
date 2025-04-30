Return-Path: <netdev+bounces-187128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47753AA51F4
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52FA4E67A4
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E099262D00;
	Wed, 30 Apr 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rYC39AJZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D760215764
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031645; cv=none; b=ZIwXZm4BPQxyS72viooU/N6dL7NBt3TRqb7yB8OMglHp4ueqDrypktegmG6jBz1woLjnhEpvjClO0YqmBEIGxGmtAUbHVmbIa9imcaoFZDhYcepyG0RDWECcS8VzEEqJKs3ipjCFEiJXdvVhYWof9idwwpdcLJlm/WY7C9RRb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031645; c=relaxed/simple;
	bh=IfgM/uLxdX5CQp7dELG+WtOzlDcVc+X80v20Oc/ErjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zk5XVDbWiajXDi9AHkdazfytgxfBeuWFeWVzlSBqwUyELMdrAb8vs15+nmJ7JMWf1Uv81nE2oyW5M7tG1FtDGmugPf58jNkrkqkD2VrNUbbFUT/XJssLmDoNt7sIrTh0rQDxt5DZmvfRbg52xOz36RasExKz/QNjGFy8opFiZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rYC39AJZ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4f6b9e1-d51a-49f9-9c75-57ef1ea7babf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746031641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/fXOf5SloRzjwxJRWDW2uwyBehwCby5djUgaR19Cck=;
	b=rYC39AJZx9GApNw6uqKxISioaiJdMd/QhObGJgtNhTaDO3VNUb6zAB6wLYORa3K4WA49TM
	coSOSC4XgNoWlmeX3PFeoaYP8DN5Gzvry9ArxqofhLD08ttNrBQvSp6KCW4AEb0de0Ol2P
	VDSvOj54YVcEik5V6HuIgZW0ECnaDUM=
Date: Wed, 30 Apr 2025 17:47:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4] bnxt_en: improve TX timestamping FIFO
 configuration
To: Taehee Yoo <ap420073@gmail.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250424125547.460632-1-vadfed@meta.com>
 <CAMArcTWDe2cd41=ub=zzvYifaYcYv-N-csxfqxUvejy_L0D6UQ@mail.gmail.com>
 <c9119edd-69d3-4b0e-a7b3-03417db5fed8@linux.dev>
 <CAMArcTXnZ-T6nsSyEtBLj+_SzMJhEz8R4g5HnR-ToFx8JPLngw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAMArcTXnZ-T6nsSyEtBLj+_SzMJhEz8R4g5HnR-ToFx8JPLngw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 30/04/2025 17:43, Taehee Yoo wrote:
> On Wed, Apr 30, 2025 at 11:55 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 30/04/2025 13:59, Taehee Yoo wrote:
>>> On Thu, Apr 24, 2025 at 10:11 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>>>
>>>
>>> Hi Vadim,
>>> Thanks for this work!
>>>
>>>> Reconfiguration of netdev may trigger close/open procedure which can
>>>> break FIFO status by adjusting the amount of empty slots for TX
>>>> timestamps. But it is not really needed because timestamps for the
>>>> packets sent over the wire still can be retrieved. On the other side,
>>>> during netdev close procedure any skbs waiting for TX timestamps can be
>>>> leaked because there is no cleaning procedure called. Free skbs waiting
>>>> for TX timestamps when closing netdev.
>>>>
>>>> Fixes: 8aa2a79e9b95 ("bnxt_en: Increase the max total outstanding PTP TX packets to 4")
>>>> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
>>>> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
>>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>>> ---
>>>> v3 -> v4:
>>>> * actually remove leftover unused variable in bnxt_ptp_clear()
>>>> (v3 was not committed before preparing unfortunately)
>>>> v2 -> v3:
>>>> * remove leftover unused variable in bnxt_ptp_clear()
>>>> v1 -> v2:
>>>> * move clearing of TS skbs to bnxt_free_tx_skbs
>>>> * remove spinlock as no TX is possible after bnxt_tx_disable()
>>>> * remove extra FIFO clearing in bnxt_ptp_clear()
>>>> ---
>>>>    drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++--
>>>>    drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 29 ++++++++++++++-----
>>>>    drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  1 +
>>>>    3 files changed, 25 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>>> index c8e3468eee61..2c8e2c19d854 100644
>>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>>> @@ -3414,6 +3414,9 @@ static void bnxt_free_tx_skbs(struct bnxt *bp)
>>>>
>>>>                   bnxt_free_one_tx_ring_skbs(bp, txr, i);
>>>>           }
>>>> +
>>>> +       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
>>>> +               bnxt_ptp_free_txts_skbs(bp->ptp_cfg);
>>>>    }
>>>>
>>>>    static void bnxt_free_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
>>>> @@ -12797,8 +12800,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
>>>>           /* VF-reps may need to be re-opened after the PF is re-opened */
>>>>           if (BNXT_PF(bp))
>>>>                   bnxt_vf_reps_open(bp);
>>>> -       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
>>>> -               WRITE_ONCE(bp->ptp_cfg->tx_avail, BNXT_MAX_TX_TS);
>>>>           bnxt_ptp_init_rtc(bp, true);
>>>>           bnxt_ptp_cfg_tstamp_filters(bp);
>>>>           if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
>>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>>>> index 2d4e19b96ee7..0669d43472f5 100644
>>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>>>> @@ -794,6 +794,27 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
>>>>           return HZ;
>>>>    }
>>>>
>>>> +void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp)
>>>> +{
>>>> +       struct bnxt_ptp_tx_req *txts_req;
>>>> +       u16 cons = ptp->txts_cons;
>>>> +
>>>> +       /* make sure ptp aux worker finished with
>>>> +        * possible BNXT_STATE_OPEN set
>>>> +        */
>>>> +       ptp_cancel_worker_sync(ptp->ptp_clock);
>>>> +
>>>> +       ptp->tx_avail = BNXT_MAX_TX_TS;
>>>> +       while (cons != ptp->txts_prod) {
>>>> +               txts_req = &ptp->txts_req[cons];
>>>> +               if (!IS_ERR_OR_NULL(txts_req->tx_skb))
>>>> +                       dev_kfree_skb_any(txts_req->tx_skb);
>>>> +               cons = NEXT_TXTS(cons);
>>>> +       }
>>>> +       ptp->txts_cons = cons;
>>>> +       ptp_schedule_worker(ptp->ptp_clock, 0);
>>>> +}
>>>> +
>>>>    int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod)
>>>>    {
>>>>           spin_lock_bh(&ptp->ptp_tx_lock);
>>>> @@ -1105,7 +1126,6 @@ int bnxt_ptp_init(struct bnxt *bp)
>>>>    void bnxt_ptp_clear(struct bnxt *bp)
>>>>    {
>>>>           struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
>>>> -       int i;
>>>>
>>>>           if (!ptp)
>>>>                   return;
>>>> @@ -1117,12 +1137,5 @@ void bnxt_ptp_clear(struct bnxt *bp)
>>>>           kfree(ptp->ptp_info.pin_config);
>>>>           ptp->ptp_info.pin_config = NULL;
>>>>
>>>> -       for (i = 0; i < BNXT_MAX_TX_TS; i++) {
>>>> -               if (ptp->txts_req[i].tx_skb) {
>>>> -                       dev_kfree_skb_any(ptp->txts_req[i].tx_skb);
>>>> -                       ptp->txts_req[i].tx_skb = NULL;
>>>> -               }
>>>> -       }
>>>> -
>>>>           bnxt_unmap_ptp_regs(bp);
>>>>    }
>>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
>>>> index a95f05e9c579..0481161d26ef 100644
>>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
>>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
>>>> @@ -162,6 +162,7 @@ int bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp);
>>>>    void bnxt_ptp_reapply_pps(struct bnxt *bp);
>>>>    int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr);
>>>>    int bnxt_hwtstamp_get(struct net_device *dev, struct ifreq *ifr);
>>>> +void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp);
>>>>    int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod);
>>>>    void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb, u16 prod);
>>>>    int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts);
>>>> --
>>>> 2.47.1
>>>>
>>>>
>>>
>>> I’ve encountered a kernel panic that I think is related to this patch.
>>> Could you please investigate it?
>>>
>>> Reproducer:
>>>       ip link set $interface up
>>>       modprobe -rv bnxt_en
>>>
>>
>> Hi Taehee!
>>
>> Yeah, looks like there are some issues on the remove path.
>> Could you please test the diff which may fix the problem:
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index 78e496b0ec26..86a5de44b6f3 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -16006,8 +16006,8 @@ static void bnxt_remove_one(struct pci_dev *pdev)
>>
>>           bnxt_rdma_aux_device_del(bp);
>>
>> -       bnxt_ptp_clear(bp);
>>           unregister_netdev(dev);
>> +       bnxt_ptp_clear(bp);
>>
>>           bnxt_rdma_aux_device_uninit(bp);
>>
> 
> Thanks! It seems to fix the issue.
> The above reproducer can't reproduce a kernel panic.

Great, thanks, I'll post a proper patch soon

