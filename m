Return-Path: <netdev+bounces-305863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H8ReFdBuTmqFMgIAu9opvQ
	(envelope-from <netdev+bounces-305863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:37:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F7B7281E5
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:37:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-dortmund.de header.s=unimail header.b=eqdssayO;
	dmarc=pass (policy=none) header.from=tu-dortmund.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305863-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305863-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 234D730EE8F6
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEA43A6B81;
	Wed,  8 Jul 2026 15:15:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5E35E92F;
	Wed,  8 Jul 2026 15:15:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523750; cv=none; b=ssv8MFkeZZs6mgZ9bUPTUhwLw7/bFbuRGkxj3XmbR7qCaPxdM7Q/WaTsYqThMuvJhW+iOmnc35TTLs1XA8ABt96sw2MfJkni76PLN08zMwWPgi9g0IDiHPJ4JfwTZewxnjkGyKkQu0c9XV0ESRrxo6mhXM9cVFYTJBIZTMPdTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523750; c=relaxed/simple;
	bh=Z/M4qo4aKet++ZcdMmdrhg8tuZe93BjhicMEfgYQ8Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFT0k7tFrv53WZff5ZDo6W+YUE2fmspQ1KfEChtZP2uE1mIGEHqZZBNFdKn6zaNjvi/o629ClhdhjXwF7NLBXPBWcHd+kG7P2vdfA7GzVoF6WjR52nrerPq4/hlWlPoOSbly/u+7zay6nvtt/l9ctqjmnqNDnYJw1QMlC6SA4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=eqdssayO; arc=none smtp.client-ip=129.217.128.51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1783523541;
	bh=JUDy9KU7vJOTJs+mWZpY03LuKhL3NZcOljSDWdfTCWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eqdssayOH+/cStC+U/0yFHImlwHFTayvhMtscaSSyYc/avX8xY2PRMifV/gj/+FWF
	 9+HjBhXrw8IHgPVt+ms0Eza6uSxiyjVRcQvexIdn/2cjCv4zxsUQfV9hYPf8jJROwr
	 S07ZOTA1Nug4/AHiMhghK71Y2nyvh0cLHrZV+WUw=
Received: from [129.217.186.105] ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 668FCKJF013807
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 8 Jul 2026 17:12:20 +0200 (CEST)
Message-ID: <c743935b-7b6f-49f4-b1dd-3fe1cc528464@tu-dortmund.de>
Date: Wed, 8 Jul 2026 17:12:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
To: Brett A C Sheffield <bacs@librecast.net>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
 <akt_Q7kdR3Zb8_GZ@karahi.librecast.net>
 <20260706091706-mutt-send-email-mst@kernel.org>
 <2728c540-2e76-4e06-9064-ed1dff071cbe@tu-dortmund.de>
 <akvhhy_JpH64KrcL@karahi.librecast.net>
 <0d28fdc4-3c03-48d6-bd59-e59f7a01f4b6@tu-dortmund.de>
 <ak1cIAwQzKS35x0m@karahi.librecast.net>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <ak1cIAwQzKS35x0m@karahi.librecast.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305863-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:bacs@librecast.net,m:mst@redhat.com,m:willemdebruijn.kernel@gmail.com,m:jasowangio@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew+netdev@lunn.ch,m:tim.gebauer@tu-dortmund.de,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lwn.net,linuxfoundation.org,lunn.ch,tu-dortmund.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tu-dortmund.de:from_mime,tu-dortmund.de:dkim,tu-dortmund.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3F7B7281E5

On 7/7/26 22:05, Brett A C Sheffield wrote:
> On 2026-07-07 08:52, Simon Schippers wrote:
>> Brett, can you try the two attached patches here with iperf3?
>> I think testing with 8 and 16 threads is enough, so where there is a
>> regression.
>>
>> The two patches are about time when to wake:
>> Currently we wake after consuming half the internal ring buffer.
>> One of the attached patches wakes after 2 cachelines (128 of 1000
>> packets) and the other one just wakes once the ring buffer is empty.
>>
>> This would really help :)
> 
> Sure...
> 
> 

The reverted results for reference:
7.2.0-rc1 reverted:

threads 1
[  5]   0.00-10.00  sec  15.3 GBytes  13.1 Gbits/sec  368            sender
[  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver

threads 2
[SUM]   0.00-10.00  sec  15.9 GBytes  13.7 Gbits/sec  1567             sender
[SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver

threads 4
[SUM]   0.00-10.00  sec  16.5 GBytes  14.1 Gbits/sec  6701             sender
[SUM]   0.00-10.00  sec  8.00 GBytes  6.87 Gbits/sec                  receiver

threads 8
[SUM]   0.00-10.00  sec  16.2 GBytes  14.0 Gbits/sec  19319             sender
[SUM]   0.00-10.00  sec  15.7 GBytes  13.5 Gbits/sec                  receiver

threads 16
[SUM]   0.00-10.00  sec  14.4 GBytes  12.4 Gbits/sec  43593             sender
[SUM]   0.00-10.00  sec  14.4 GBytes  12.4 Gbits/sec                  receiver


> 7.2.0-rc2 (unpatched)
> 
> threads 1
> [  5]   0.00-10.00  sec  20.4 GBytes  17.5 Gbits/sec    0            sender
> [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
> 
> threads 2
> [SUM]   0.00-10.00  sec  12.7 GBytes  10.9 Gbits/sec    0             sender
> [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
> 
> threads 8
> [SUM]   0.00-10.00  sec  11.5 GBytes  9.85 Gbits/sec    0             sender
> [SUM]   0.00-10.01  sec  11.4 GBytes  9.83 Gbits/sec                  receiver
> 
> threads 16
> [SUM]   0.00-10.00  sec  11.6 GBytes  9.95 Gbits/sec    0             sender
> [SUM]   0.00-10.01  sec  11.5 GBytes  9.91 Gbits/sec                  receiver
> 
> 
> 7.2.0-rc2 with 0001-tun-set-waking-threshold-to-ptr_ring_empty.patch
> 
> threads 1
> [  5]   0.00-10.00  sec  19.6 GBytes  16.8 Gbits/sec    0            sender
> [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
> 
> threads 2
> [SUM]   0.00-10.00  sec  11.1 GBytes  9.50 Gbits/sec    0             sender
> [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
> 
> threads 8
> [SUM]   0.00-10.00  sec  10.8 GBytes  9.25 Gbits/sec    0             sender
> [SUM]   0.00-10.01  sec  10.7 GBytes  9.23 Gbits/sec                  receiver
> 
> threads 16
> [SUM]   0.00-10.00  sec  10.9 GBytes  9.34 Gbits/sec    0             sender
> [SUM]   0.00-10.01  sec  10.8 GBytes  9.30 Gbits/sec                  receiver
> 
> 
> 7.2.0-rc2 with 0001-tun-set-waking-threshold-to-tx_ring.batch.patch
> 
> threads 1
> [  5]   0.00-10.00  sec  19.6 GBytes  16.9 Gbits/sec    2            sender
> [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
> 
> threads 2
> [SUM]   0.00-10.00  sec  13.9 GBytes  11.9 Gbits/sec    0             sender
> [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
> 
> threads 8
> [SUM]   0.00-10.00  sec  12.7 GBytes  10.9 Gbits/sec    0             sender
> [SUM]   0.00-10.01  sec  12.3 GBytes  10.6 Gbits/sec                  receiver
> 
> threads 16
> [SUM]   0.00-10.00  sec  12.5 GBytes  10.7 Gbits/sec    0             sender
> [SUM]   0.00-10.00  sec  12.4 GBytes  10.7 Gbits/sec                  receiver
> 
> 
> 
> HTH,
> 
> 
> Brett

Thank you again!

These results show that waking earlier performs better in this case:
For 8 threads we get 10.6 Gbit/s instead of 9.83 Gbit/s when waking early
but we are still *far* from the 13.5 Gbit/s when we revert everything
(see above I pasted the reverted results there).

So I come to the conclusion:

1. Waking earlier/later will not fix the performance issues. It may
   improve the performance slightly.
   Apart from that we introduce smp_mb__after_atomic() for the re-check
   on producer side (noop on x86) and a full smp_mb() for the re-check on
   consumer side.
   Nothing else stands out to me apart from the overheads of
   netif_tx_stop_queue() and netif_tx_wake_queue(). But we must use
   those 2 functions one way or another.

2. Users may depend on the dropping. Without backpressure tun/tap acts
   like a pfifo qdisc which tail-drops. Some users may require this.

--> I would merge this opt-in patchset, it should be fine (it is not
    flagged by Sashiko anymore btw). I would not be mad if it would not
    get merged but I am out of ideas on how to improve.

Thanks,
Simon


