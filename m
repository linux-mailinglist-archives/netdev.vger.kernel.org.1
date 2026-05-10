Return-Path: <netdev+bounces-286328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nejWMcmwAGrALgEAu9opvQ
	(envelope-from <netdev+bounces-286328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:22:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3165C505150
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2700530048D1
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D0A39FCDD;
	Sun, 10 May 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="LSZ4ZHk3"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DA35AC1E;
	Sun, 10 May 2026 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778430151; cv=none; b=Wyx6+/O1/SnnUXWg4JrWhPk+qLXn+x2xjx+PpyC2e0vDi0nS/RyGU8zFlpCjwLyYYXIHnFyI3T4gpFaunYKa45knjWB4p34UGyNXnQRIMX98G11knnFGP7pJVV/m4eSxCHj0myDGdCDKEJbe3Ugrrbj3NfMheO2Xqr3h8vzJV4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778430151; c=relaxed/simple;
	bh=225NIPFzoqq6Y2+knWmT1b7bP1CaGKjulY7fohGaF7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFifbpaWf0ky3WPyws16eNEvYDVoajh7/lFg2joJUIsc05zoJZdYgL9XIwB/j2pVF4reR+BfSjOUO9mzcu2AY9JzpT0z49lk+q67JtgzZq5Lrcz6bq5Nbfnsy31JRavUez9Wr0KAcxBba0xPdus0cmWXvEha3ssiNveWkSLDH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=LSZ4ZHk3; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778430137;
	bh=225NIPFzoqq6Y2+knWmT1b7bP1CaGKjulY7fohGaF7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LSZ4ZHk3jRhyHmk6tz4/ILPlfdqVhmeZ2ZlKKZc3qQ3l5ro6SO3+0GoiMahtSUdym
	 22fPKVg4eFHDOYPa8NONq3LEr3PeB/nByWEjPWmgevxD4RDlZXCbcvePIgO97UGwOa
	 m3ietLQ1d1gFqIu/PAYPVAkaqzRFiFOB6fjpQ4dg=
Received: from [192.168.178.127] (pd9eaa57d.dip0.t-ipconnect.de [217.234.165.125])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 64AGMFV0015200
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 18:22:16 +0200 (CEST)
Message-ID: <5f39493e-b2f0-446b-9896-98a074f5ed6b@tu-dortmund.de>
Date: Sun, 10 May 2026 18:22:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 1/4] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
        leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
        tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
 <20260509183518-mutt-send-email-mst@kernel.org>
 <a14b700a-94e8-44c0-bde0-d8307761c0f1@tu-dortmund.de>
 <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>
 <20260510094020-mutt-send-email-mst@kernel.org>
 <e5d69f44-4483-49f3-b7fc-aca2cdb24792@tu-dortmund.de>
 <20260510114401-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260510114401-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3165C505150
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286328-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:mid,tu-dortmund.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/10/26 17:44, Michael S. Tsirkin wrote:
> On Sun, May 10, 2026 at 04:01:39PM +0200, Simon Schippers wrote:
>> On 5/10/26 15:40, Michael S. Tsirkin wrote:
>>> On Sun, May 10, 2026 at 10:55:34AM +0200, Simon Schippers wrote:
>>>> On 5/10/26 09:03, Simon Schippers wrote:
>>>>> On 5/10/26 00:44, Michael S. Tsirkin wrote:
>>>>>> On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
>>>>>>> On 5/8/26 17:10, Simon Schippers wrote:
>>>>>>>> +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
>>>>>>>>  {
>>>>>>>>  	void *ptr;
>>>>>>>>  
>>>>>>>> -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
>>>>>>>> +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
>>>>>>>>  		tun_ptr_free(ptr);
>>>>>>>>  
>>>>>>>>  	skb_queue_purge(&tfile->sk.sk_write_queue);
>>>>>>>
>>>>>>> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
>>>>>>> operates on a tfile that is being torn down. Its queue_index is no
>>>>>>> longer valid. After the swap in __tun_detach(), it points to the
>>>>>>> netdev subqueue of a different tfile.
>>>>>>> --> We should not wake there.
>>>>>>
>>>>>> Does it not exactly point at ntfile which is what we want to wake?
>>>>>>
>>>>>
>>>>> I see your point. But calling tun_ring_consume() as done here is
>>>>> wrong, because it does not wake if the tx_ring of the tfile 
>>>>> (that is currently torn down) is empty. We could change
>>>>> tun_ring_consume() to call __tun_wake_queue()
>>>>> with consumed=0 if !ptr but I think this would slow down the consumer
>>>>> path.
>>>>>
>>>>
>>>> My statement is wrong:
>>>> There is no way that the tx_ring is empty and the queue is stopped
>>>> at the same time. So we do not need to touch tun_ring_consume() and
>>>> this works just fine.
>>>>
>>>>>>
>>>>>>> I will swap tun_ring_consume() with ptr_ring_consume() again and
>>>>>>> submit a v12 :)
>>>>>>
>>>>>> If so then maybe
>>>>>> netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));
>>>>>>
>>>>>
>>>>> But we should only do this if there is space in the ntfile.
>>>>> My approach:
>>>>>
>>>>> @@ -586,12 +588,18 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
>>>>>  		BUG_ON(index >= tun->numqueues);
>>>>>  
>>>>>  		rcu_assign_pointer(tun->tfiles[index],
>>>>>  				   tun->tfiles[tun->numqueues - 1]);
>>>>>  		ntfile = rtnl_dereference(tun->tfiles[index]);
>>>>> +		spin_lock(&ntfile->tx_ring.consumer_lock);
>>>>>  		ntfile->queue_index = index;
>>>>>  		ntfile->xdp_rxq.queue_index = index;
>>>>> +		ntfile->cons_cnt = 0;
>>>>> +		if (__ptr_ring_empty(&ntfile->tx_ring)) {
>>>>> +			netif_wake_subqueue(tun->dev, index);
>>>>> +		}
>>>>> +		spin_unlock(&ntfile->tx_ring.consumer_lock);
>>>>>  		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
>>>>>  				   NULL);
>>>>>
>>>>> ntfile->cons_cnt is unvalid, because the new queue might not be stopped.
>>>>> That is the reason why I reset it to 0.
>>>>
>>>> However, I still prefer this approach because the code is easier to
>>>> understand.
>>>
>>>
>>> So do you want me to finish review of this one and ack, or want to
>>> post v12?
>>>
>>
>> I will post a v12 with the proposed changes for patch 1.
>> No other changes.
>>
>> Thanks!
> 
> actually can you clarify? why only when ntfile ring is empty?
> 

This avoids waking when ntfile->tx_ring is full. We can not use 
__ptr_ring_can_produce() with consumer locks, therefore I chose
__ptr_ring_empty() instead.

If there are any elements in ntfile->tx_ring we do not have to wake.
This will be done by the consumer in tun_ring_consume() &
__tun_wake_queue() after consuming those elements.


