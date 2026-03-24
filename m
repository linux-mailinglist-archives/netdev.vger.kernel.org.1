Return-Path: <netdev+bounces-270976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMxdCKdnwmmecAQAu9opvQ
	(envelope-from <netdev+bounces-270976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:29:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F2E306768
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87B3E30741F3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FBE382392;
	Tue, 24 Mar 2026 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="RM7R4tQr"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2D359A66;
	Tue, 24 Mar 2026 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347314; cv=none; b=VJoUAJzJVJb5/4p1PU85wdWnRdDMNdCXNtxbE+/QdANzNxfFLys/6Stca6mlPceP6O6hcoDWqXuyN5T+V1wZh+2oIA1h5juSmGtEd6ga58j8LHeu/v5+63ljbj4xQ3aZyS9SKiXniRUHw28NohoRBC1O7VipDRDUmnRzXbD7cTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347314; c=relaxed/simple;
	bh=EeWxqb0HgRENSXG2d8Fk2RYIq4kncRyI4/Iu6SENreg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUYyLcDG0CrLvFJYF0AGd4Oq3esyRgisFIIlZ25AFNvgtyY5ctTchUpLK+clNatKZv2g352G8BO7Sb/KkO5JnOrhX2PkS6fAt0czqTQOG8cK7FE72NeWF0EXW3AA0yGLz2kXC3fvJMs2n7S+Tb1vPf/hM7h9WnVS6mf1pmOWsCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=RM7R4tQr; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1774347297;
	bh=EeWxqb0HgRENSXG2d8Fk2RYIq4kncRyI4/Iu6SENreg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RM7R4tQri46kneVGg7+K2sNbwiOtJh+Yany9dmcKhLoJf52nTRyXCZUWuKx1wEwBU
	 aD3P0rpfqGS2eriGMQys7f/VbAkAArMFE6Wk6g5Nssf9y7T1y8b7UVWK4BGk/+KlQW
	 wi+9RO07qPOuv7I/xxaeR/83bB5qH35m6DHLUcPc=
Received: from [192.168.178.143] (p5dc880d2.dip0.t-ipconnect.de [93.200.128.210])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 62OAEtkX003138
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 11:14:56 +0100 (CET)
Message-ID: <0908392d-6314-4141-b908-6c9a880ba0a4@tu-dortmund.de>
Date: Tue, 24 Mar 2026 11:14:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
To: Jason Wang <jasowang@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mst@redhat.com, eperezma@redhat.com,
        leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
        tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-5-simon.schippers@tu-dortmund.de>
 <CACGkMEtN9XgYPGHQg4TEWEsa_UcMbcnzO=VaTFT=0Tn4BayMDw@mail.gmail.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <CACGkMEtN9XgYPGHQg4TEWEsa_UcMbcnzO=VaTFT=0Tn4BayMDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270976-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22F2E306768
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 02:47, Jason Wang wrote:
> On Thu, Mar 12, 2026 at 9:07 PM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
>>
>> This commit prevents tail-drop when a qdisc is present and the ptr_ring
>> becomes full. Once an entry is successfully produced and the ptr_ring
>> reaches capacity, the netdev queue is stopped instead of dropping
>> subsequent packets.
>>
>> If producing an entry fails anyways due to a race, tun_net_xmit returns
>> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
>> LLTX is enabled and the transmit path operates without the usual locking.
>>
>> The existing __tun_wake_queue() function wakes the netdev queue. Races
>> between this wakeup and the queue-stop logic could leave the queue
>> stopped indefinitely. To prevent this, a memory barrier is enforced
>> (as discussed in a similar implementation in [1]), followed by a recheck
>> that wakes the queue if space is already available.
>>
>> If no qdisc is present, the previous tail-drop behavior is preserved.
> 
> I wonder if we need a dedicated TUN flag to enable this. With this new
> flag, we can even prevent TUN from using noqueue (not sure if it's
> possible or not).
> 

Except of the slight regressions because of this patchset I do not see
a reason for such a flag.

I have never seen that the driver prevents noqueue. For example you can
set noqueue to your ethernet interface and under load you soon get 

net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
					     dev->name);

followed by a -ENETDOWN. And this is not prevented even though it is
clearly not something a user wants.

>>
>> Benchmarks:
>> The benchmarks show a slight regression in raw transmission performance,
>> though no packets are lost anymore.
>>
>> The previously introduced threshold to only wake after the queue stopped
>> and half of the ring was consumed showed to be a descent choice:
>> Waking the queue whenever a consume made space in the ring strongly
>> degrades performance for tap, while waking only when the ring is empty
>> is too late and also hurts throughput for tap & tap+vhost-net.
>> Other ratios (3/4, 7/8) showed similar results (not shown here), so
>> 1/2 was chosen for the sake of simplicity for both tun/tap and
>> tun/tap+vhost-net.
>>
>> Test setup:
>> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
>> Average over 20 runs @ 100,000,000 packets. SRSO and spectre v2
>> mitigations disabled.
>>
>> Note for tap+vhost-net:
>> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
>> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
>>
>> +--------------------------+--------------+----------------+----------+
>> | 1 thread                 | Stock        | Patched with   | diff     |
>> | sending                  |              | fq_codel qdisc |          |
>> +------------+-------------+--------------+----------------+----------+
>> | TAP        | Transmitted | 1.151 Mpps   | 1.139 Mpps     | -1.1%    |
>> |            +-------------+--------------+----------------+----------+
>> |            | Lost/s      | 3.606 Mpps   | 0 pps          |          |
>> +------------+-------------+--------------+----------------+----------+
>> | TAP        | Transmitted | 3.948 Mpps   | 3.738 Mpps     | -5.3%    |
>> |            +-------------+--------------+----------------+----------+
>> | +vhost-net | Lost/s      | 496.5 Kpps   | 0 pps          |          |
>> +------------+-------------+--------------+----------------+----------+
>>
>> +--------------------------+--------------+----------------+----------+
>> | 2 threads                | Stock        | Patched with   | diff     |
>> | sending                  |              | fq_codel qdisc |          |
>> +------------+-------------+--------------+----------------+----------+
>> | TAP        | Transmitted | 1.133 Mpps   | 1.109 Mpps     | -2.1%    |
>> |            +-------------+--------------+----------------+----------+
>> |            | Lost/s      | 8.269 Mpps   | 0 pps          |          |
>> +------------+-------------+--------------+----------------+----------+
>> | TAP        | Transmitted | 3.820 Mpps   | 3.513 Mpps     | -8.0%    |
>> |            +-------------+--------------+----------------+----------+
>> | +vhost-net | Lost/s      | 4.961 Mpps   | 0 pps          |          |
>> +------------+-------------+--------------+----------------+----------+
>>
>> [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.org/
>>
>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>> ---
>>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
>>  1 file changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index b86582cc6cb6..9b7daec69acd 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>>         struct netdev_queue *queue;
>>         struct tun_file *tfile;
>>         int len = skb->len;
>> +       bool qdisc_present;
>> +       int ret;
>>
>>         rcu_read_lock();
>>         tfile = rcu_dereference(tun->tfiles[txq]);
>> @@ -1063,13 +1065,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>>
>>         nf_reset_ct(skb);
>>
>> -       if (ptr_ring_produce(&tfile->tx_ring, skb)) {
>> +       queue = netdev_get_tx_queue(dev, txq);
>> +       qdisc_present = !qdisc_txq_has_no_queue(queue);
>> +
>> +       spin_lock(&tfile->tx_ring.producer_lock);
>> +       ret = __ptr_ring_produce(&tfile->tx_ring, skb);
>> +       if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
> 
> So, it's possible that the administrator is switching between noqueue
> and another qdisc. So ptr_ring_produce() can fail here, do we need to
> check that or not?
> 

Do you mean that? My thoughts:

Switching from noqueue to some qdisc can cause a 

net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
					     dev->name);

followed by a return of -ENETDOWN in __dev_queue_xmit().
This is because tun_net_xmit detects some qdisc with 

qdisc_present = !qdisc_txq_has_no_queue(queue);

and returns NETDEV_TX_BUSY even though __dev_queue_xmit() did still
detect noqueue.

I am not sure how to solve this/if this has to be solved.
I do not see a proper way to avoid parallel execution of ndo_start_xmit
and a qdisc change (dev_graft_qdisc only takes qdisc_skb_head lock).

And from my understanding the veth implementation faces the same issue.


Switching from some qdisc to noqueue is no problem I think.

>> +               netif_tx_stop_queue(queue);
>> +               /* Avoid races with queue wake-ups in __tun_wake_queue by
>> +                * waking if space is available in a re-check.
>> +                * The barrier makes sure that the stop is visible before
>> +                * we re-check.
>> +                */
>> +               smp_mb__after_atomic();
> 
> Let's document which barrier is paired with this.
> 

I am basically copying the (old) logic of veth [1] proposed by
Jakub Kicinski. I must admit I am not 100% sure what it pairs with.

[1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.org/

>> +               if (!__ptr_ring_produce_peek(&tfile->tx_ring))
>> +                       netif_tx_wake_queue(queue);
>> +       }
>> +       spin_unlock(&tfile->tx_ring.producer_lock);
>> +
>> +       if (ret) {
>> +               /* If a qdisc is attached to our virtual device,
>> +                * returning NETDEV_TX_BUSY is allowed.
>> +                */
>> +               if (qdisc_present) {
>> +                       rcu_read_unlock();
>> +                       return NETDEV_TX_BUSY;
>> +               }
>>                 drop_reason = SKB_DROP_REASON_FULL_RING;
>>                 goto drop;
>>         }
>>
>>         /* dev->lltx requires to do our own update of trans_start */
>> -       queue = netdev_get_tx_queue(dev, txq);
>>         txq_trans_cond_update(queue);
>>
>>         /* Notify and wake up reader process */
>> --
>> 2.43.0
>>
> 
> Thanks
> 

