Return-Path: <netdev+bounces-157895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F5A0C38C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5483A5B9A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C891C8FD4;
	Mon, 13 Jan 2025 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="HUHoj8WK"
X-Original-To: netdev@vger.kernel.org
Received: from mx12lb.world4you.com (mx12lb.world4you.com [81.19.149.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CAE1B0F30
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736803225; cv=none; b=gUXSCZSgVXQurN4BUkRdk1bksHykVA4Z0EeNrWu6Em8rFP2eMy8mH78/XNrKUHR9gjWIgD8lOLOX9lJPU01CVw4d0u+L3TepF7j92nvKpPLk7JMaqjY6rr4YIjU5/l4j0j5BAo5wkVrDkBvwzkQ78KWoJPBs0Jmt7fLLVVnu4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736803225; c=relaxed/simple;
	bh=7e05fPjRAO7bKkqzOFLlNKCH6smtLJVOJBmu1EN3xDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=n+6kaz/peYAUfIolPhlgaR3ixZ5kfzUXP2hvtfWkpde37YknihiqSgx5ozDYrTZonjYM4Zi2hLCHRGv20HlzfMuZuN30oD/Da2e5b0sg5ds5czMOx3G0Kp+SE9ndisCmKWKFKzjsZnRejwXhdTzFVFSYR2gMVVmmmnerKxcPEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=HUHoj8WK; arc=none smtp.client-ip=81.19.149.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LVbLVDLaM1cX/Cde7QFhnig9GKYNFqB66qI6HFC2hKk=; b=HUHoj8WK+zt2VcVFGOjqxlOwTn
	FqDubrL6YJtwUQj38nSRA0sa/mdLIxrFyfYRjhocK6a3NvCh3gPoS6CH94sIumyv6dspfVgRt+ele
	4NxAHByiwu41+7CNtYouxTZXACxyBSktfJwx2NthizwR1NwtsLiQ6mIaJKxgS1Yow9dI=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx12lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tXR6n-000000002in-0ZVL;
	Mon, 13 Jan 2025 21:32:25 +0100
Message-ID: <91fc249e-c11a-47a1-aafe-fef833c3bafa@engleder-embedded.com>
Date: Mon, 13 Jan 2025 21:32:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tsnep: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>, magnus.karlsson@intel.com
References: <20250110223939.37490-1-gerhard@engleder-embedded.com>
 <Z4VwrhhXU4uKqYGR@LQ3V64L9R2>
Content-Language: en-US
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <Z4VwrhhXU4uKqYGR@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 13.01.25 20:59, Joe Damato wrote:
> On Fri, Jan 10, 2025 at 11:39:39PM +0100, Gerhard Engleder wrote:
>> Use netif_queue_set_napi() to link queues to NAPI instances so that they
>> can be queried with netlink.
>>
>> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>>                           --dump queue-get --json='{"ifindex": 11}'
>> [{'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'rx'},
>>   {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'rx'},
>>   {'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'tx'},
>>   {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'tx'}]
>>
>> Additionally use netif_napi_set_irq() to also provide NAPI interrupt
>> number to userspace.
>>
>> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>>                           --do napi-get --json='{"id": 9}'
>> {'defer-hard-irqs': 0,
>>   'gro-flush-timeout': 0,
>>   'id': 9,
>>   'ifindex': 11,
>>   'irq': 42,
>>   'irq-suspend-timeout': 0}
>>
>> Providing information about queues to userspace makes sense as APIs like
>> XSK provide queue specific access. Also XSK busy polling relies on
>> queues linked to NAPIs.
>>
>> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
>> ---
>>   drivers/net/ethernet/engleder/tsnep_main.c | 28 ++++++++++++++++++----
>>   1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
>> index 45b9f5780902..71e950e023dc 100644
>> --- a/drivers/net/ethernet/engleder/tsnep_main.c
>> +++ b/drivers/net/ethernet/engleder/tsnep_main.c
>> @@ -1984,23 +1984,41 @@ static int tsnep_queue_open(struct tsnep_adapter *adapter,
>>   
>>   static void tsnep_queue_enable(struct tsnep_queue *queue)
>>   {
>> +	struct tsnep_adapter *adapter = queue->adapter;
>> +
>> +	netif_napi_set_irq(&queue->napi, queue->irq);
>>   	napi_enable(&queue->napi);
>> -	tsnep_enable_irq(queue->adapter, queue->irq_mask);
>> +	tsnep_enable_irq(adapter, queue->irq_mask);
>>   
>> -	if (queue->tx)
>> +	if (queue->tx) {
>> +		netif_queue_set_napi(adapter->netdev, queue->tx->queue_index,
>> +				     NETDEV_QUEUE_TYPE_TX, &queue->napi);
>>   		tsnep_tx_enable(queue->tx);
>> +	}
>>   
>> -	if (queue->rx)
>> +	if (queue->rx) {
>> +		netif_queue_set_napi(adapter->netdev, queue->rx->queue_index,
>> +				     NETDEV_QUEUE_TYPE_RX, &queue->napi);
>>   		tsnep_rx_enable(queue->rx);
>> +	}
>>   }
>>   
>>   static void tsnep_queue_disable(struct tsnep_queue *queue)
> A>  {
>> -	if (queue->tx)
>> +	struct tsnep_adapter *adapter = queue->adapter;
>> +
>> +	if (queue->rx)
>> +		netif_queue_set_napi(adapter->netdev, queue->rx->queue_index,
>> +				     NETDEV_QUEUE_TYPE_RX, NULL);
>> +
>> +	if (queue->tx) {
>>   		tsnep_tx_disable(queue->tx, &queue->napi);
>> +		netif_queue_set_napi(adapter->netdev, queue->tx->queue_index,
>> +				     NETDEV_QUEUE_TYPE_TX, NULL);
>> +	}
>>   
>>   	napi_disable(&queue->napi);
>> -	tsnep_disable_irq(queue->adapter, queue->irq_mask);
>> +	tsnep_disable_irq(adapter, queue->irq_mask);
>>   
>>   	/* disable RX after NAPI polling has been disabled, because RX can be
>>   	 * enabled during NAPI polling
> 
> The changes generally look OK to me (it seems RTNL is held on all
> paths where this code can be called from as far as I can tell), but
> there was one thing that stood out to me.
> 
> AFAIU, drivers avoid marking XDP queues as NETDEV_QUEUE_TYPE_RX
> or NETDEV_QUEUE_TYPE_TX. I could be wrong, but that was my
> understanding and I submit patches to several drivers with this
> assumption.
> 
> For example, in commit b65969856d4f ("igc: Link queues to NAPI
> instances"), I unlinked/linked the NAPIs and queue IDs when XDP was
> enabled/disabled. Likewise, in commit 64b62146ba9e ("net/mlx4: link
> NAPI instances to queues and IRQs"), I avoided the XDP queues.
> 
> If drivers are to avoid marking XDP queues as NETDEV_QUEUE_TYPE_RX
> or NETDEV_QUEUE_TYPE_TX, perhaps tsnep needs to be modified
> similarly?

With 5ef44b3cb4 ("xsk: Bring back busy polling support") the linking of
the NAPIs is required for XDP/XSK. So it is strange to me if for XDP/XSK
the NAPIs should be unlinked. But I'm not an expert, so maybe there is
a reason why.

I added Magnus, maybe he knows if XSK queues shall still be linked to
NAPIs.

Gerhard

