Return-Path: <netdev+bounces-273785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOXpIh9VzGn/SQYAu9opvQ
	(envelope-from <netdev+bounces-273785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:13:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA148372A3F
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD56F3017781
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F5C45BD6F;
	Tue, 31 Mar 2026 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SGfw6gqt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60E41B3925
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998718; cv=none; b=HgmEtoNyHomDoMNaQz22NgnQgGHPSNc+I4cLaHd5P8vj89xLFdvsBPxyk1UDR7VwMrxM86i9X+4BdTZaXiMUlueNvi0QAWrHMnUsnG7VxhVxuMiu9LFSHc1L93HOMWwFJVx0SsSMVslaM7Qt0kvA/gv0wq/Jo0CxCZteH5UDIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998718; c=relaxed/simple;
	bh=PVlPRh5TYw4BSlObIDlpyebfwvWaSErDbMBcPYybLn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNls9WTJsiBuTNf50RUUZNYKNi6qr/CfSp+iWBa3r9GkoAtAOROK0zx08I+PNW8K7lu2gydLKZ8QVu1cw4HVQYs9c4qP0r/5ZNT5S+YQeyQUHf1QaKByWZVA0D9mSDfRVy9Kv+TNcb6fn+/eMqV4ldlVIPMm4afsjt9Gt2GLd8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SGfw6gqt; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8cfc497a604so794279385a.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998716; x=1775603516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+292+7ei8RLO+M8ttdUkvIS2jfSX5sAXFpLc1Xt0dM=;
        b=dqBWWRJePZj2ViT5WVcNk6EhSufnqgMCvoTm61NLr8EufAp1ujy8ZU1vrHIQdkmkuf
         bi24VGe7TwzzI5RhFd2offHo0oMkbEKFTMulCFMr3DNSic6EphPjK5m56ghMd3PdV9ra
         VuoR1+1uLKxGmt9/DUI4OELmMlKn5BT/Ll32UeUiIySD5OiseMOdoznI4mCK/5S5j/dT
         zU9nmFGDPxIFpYCJbf0H+3JgFGEOgaDCGmVKz4aEdd9b+De+JFHSOGtAwCFPcPmPVJbF
         B0em5/97X7mwVrRt6cZcWwlvhxif7FRuKx3kXzmcqs0CvijrglAzS1Dy62xh0rMR5hw9
         jMpA==
X-Gm-Message-State: AOJu0YxRW28e3bwKMjEJQMAXezPDh2oxFuhWb96dIA9mLYnGa6mTB4sH
	1UK4g7mGGaGBdjvPnq8KL64FwJaHEgrlZLy/reBrVVkavNoUu3KAUDqzvQ/e3iNZJnxYwji4Rcd
	6IXJgiQTXM6xL6ti80KJ4ZNg09T+cHH8bI2j5ARxr0BeIPPhXF1rRIoMb1xYMKgGI2VxdwfoUtg
	6L2BtMEaM/bAG2PP0WUHvCYbJwNi7ks9j6kj3dMMn9L4izzl6o9d5u+UMbKSB7FtKefQr+v0HJg
	0nrT74MEQ==
X-Gm-Gg: ATEYQzzKrEf5DTwGYg0wmyNrGP9+LE9j5btARg4oW6QACjzpXdwWhcbLL3ofTEzsk47
	IHMuQ+YVpCYPrafQTVwXca0erB+S8KuN2NgPfRagrbMc01rGG3LGVarN0Uc4uy7MfDWFmjEAd9Y
	oS9WcvhWNSqS7ql3ZUeyRntQzQUP40q1hlJ15FEHeu6OD+2okKDQyHiCeWsKqu6XgWi0pVAwCaY
	TTRMb7n+KaLErPnIl/hCnefIvBWaWg/QMqUC70WYHe1nh0Ae8wNU9dwm5y/65rJ9qB3nA3C5c9i
	LeUWCjRhheXDaDBsKXFA/tgEA9lTfuDuU/Lj0wdn37Hns7Exy/S0Qc5haB9J2B1zumtpF9VWnXR
	jjxBEtkKWajyJHy9FD6pnA4udqkecL0w0+dxbqk+jue4R41c9bFTu80MhMYCvb99NODnuK3aTu7
	/CEas=
X-Received: by 2002:a05:620a:4514:b0:8cf:c4d7:df9 with SMTP id af79cd13be357-8d1b5c5ca36mr272474685a.64.1774998715632;
        Tue, 31 Mar 2026 16:11:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8d027fc3ca2sm130021585a.3.2026.03.31.16.11.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2026 16:11:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c7f2b72c91so11644133eec.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774998714; x=1775603514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+292+7ei8RLO+M8ttdUkvIS2jfSX5sAXFpLc1Xt0dM=;
        b=SGfw6gqtxD1G29jPsLZk7Anlil2VtkX5y/MwcziIK690iWnsb6hxo4oJR2M3cdx0HX
         b6CpgInzCYxMnruHypwCAW/hc1QJKIbDcZoEtpPgfZkx1zlm/dTKqb7f5GooJtSTeOq8
         YzGh7HucMzjy/BUoXwRgaOawsBZN2dzDUqehU=
X-Received: by 2002:a05:7300:a498:b0:2be:6f30:f2f9 with SMTP id 5a478bee46e88-2c9328ac279mr669590eec.26.1774998713924;
        Tue, 31 Mar 2026 16:11:53 -0700 (PDT)
X-Received: by 2002:a05:7300:a498:b0:2be:6f30:f2f9 with SMTP id 5a478bee46e88-2c9328ac279mr669576eec.26.1774998713363;
        Tue, 31 Mar 2026 16:11:53 -0700 (PDT)
Received: from [10.14.5.163] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b399bsm11012359eec.17.2026.03.31.16.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 16:11:52 -0700 (PDT)
Message-ID: <8c187325-16ff-4944-bf27-b340ac7f92f9@broadcom.com>
Date: Tue, 31 Mar 2026 16:11:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bcmgenet: fix leaking free_bds
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 opendmb@gmail.com, nb@tipi-net.de
References: <20260326184529.1393438-1-justin.chen@brodcom.com>
 <20260326184529.1393438-2-justin.chen@brodcom.com>
 <20260327211127.7e9317b3@kernel.org>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260327211127.7e9317b3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com,tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-273785-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EA148372A3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/27/26 9:11 PM, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 11:45:28 -0700 justin.chen@broadcom.com wrote:
>> From: Justin Chen <justin.chen@broadcom.com>
>>
>> While reclaiming the tx queue we fast forward the write pointer to
>> drop any data in flight. These dropped frames are not added back
>> to the pool of free bds. We also need to tell the netdev that we
>> are dropping said data.
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index 482a31e7b72b..3e1fc3bb8297 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> @@ -1985,6 +1985,7 @@ static unsigned int bcmgenet_tx_reclaim(struct net_device *dev,
>>   		drop = (ring->prod_index - ring->c_index) & DMA_C_INDEX_MASK;
>>   		released += drop;
>>   		ring->prod_index = ring->c_index & DMA_C_INDEX_MASK;
>> +		ring->free_bds += drop;
>>   		while (drop--) {
>>   			cb_ptr = bcmgenet_put_txcb(priv, ring);
>>   			skb = cb_ptr->skb;
>> @@ -1996,6 +1997,7 @@ static unsigned int bcmgenet_tx_reclaim(struct net_device *dev,
>>   		}
>>   		if (skb)
>>   			dev_consume_skb_any(skb);
>> +		netdev_tx_reset_queue(netdev_get_tx_queue(dev, ring->index));
>>   		bcmgenet_tdma_ring_writel(priv, ring->index,
>>   					  ring->prod_index, TDMA_PROD_INDEX);
>>   		wr_ptr = ring->write_ptr * WORDS_PER_BD(priv);
> 
> AI says you may be off by one here?
> 
>    Does this loop miss the oldest dropped descriptor and leak its SKB and
>    DMA mapping?
> 
>    Since bcmgenet_get_txcb() increments write_ptr after a transmission,
>    write_ptr always points to the next available empty slot.
> 
>    When this loops backwards drop times, the first iteration retrieves that
>    empty descriptor (where cb->skb is NULL), and the loop will finish before
>    reaching the oldest uncompleted descriptor at c_index.
> 
>    When write_ptr is rolled back to c_index, won't subsequent transmissions
>    overwrite the descriptor at c_index and permanently leak the unmapped DMA
>    buffer and SKB memory?

Ack. Looks like this is another bug. Yes, it causes an off-by-one in 
this case, but also in the xmit error path case. So I think this 
warrants another commit. Will submit v3 with this as another bug fix.

Thanks,
Justin

