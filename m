Return-Path: <netdev+bounces-267363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJIVNHPfs2ktcQAAu9opvQ
	(envelope-from <netdev+bounces-267363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:57:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 349F3280F81
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9C273184003
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835E36E498;
	Fri, 13 Mar 2026 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="OMNpQkwC"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6333264D6;
	Fri, 13 Mar 2026 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395408; cv=none; b=CNrXLYp981Op0F9bkYEMGgj9zc9QQxnmNnZaZIFUvf/nRQPl6UzH13u8138r4I14UAIdzj/INv2mdEmmmGVnDC4hwePJ2YjRSMtRD3fLJbg9ZlpGxYKbqehhnghBtCOMMPZ2Fja42eUBU3IGeUG2/3q2lv77es08eCocyBghc+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395408; c=relaxed/simple;
	bh=tFQgdc80rAuDAMnBzKCEKzlfOFzWgq6dQy3cxW2TMxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEbKZCUNBvjw0fDWAWCHPNla6X5ZlrLGLbtv5rCl7tPXDVPHWbRNlUB7D9XqvFquDbUOdYkmhYhiHDKxWIrdie5OhkWyIqELWRSg0Cc4+B7phJpDSre3MdpwdL7HCA31+qz7O56UKpuLI3uOCfinwbQw9PbwyiDfDV/ymOLgZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=OMNpQkwC; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1773395395;
	bh=tFQgdc80rAuDAMnBzKCEKzlfOFzWgq6dQy3cxW2TMxA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OMNpQkwCRub2O+8NxAEAkm6K7lSYQcGGtktppHh1lnJWwuWu4CEFtbvYDnVdv0N5n
	 YE1gQ7o0cCagcz00cz/1Y0Xf7XOGjk3TeysXP5IXPOzh54TYjwVaI+tfydM7zUr4LL
	 ZWR2asJmhgs8qNTawNkRUJtazc2bCp9fJbFn/sZg=
Received: from [129.217.186.154] ([129.217.186.154])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 62D9nrRW010579
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 10:49:53 +0100 (CET)
Message-ID: <a12fd0e3-40e9-4da7-9bdb-ae5d30e118b8@tu-dortmund.de>
Date: Fri, 13 Mar 2026 10:49:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/4] tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
        leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
        tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312095457-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260312095457-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267363-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:dkim,tu-dortmund.de:mid,tu-dortmund.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stackexchange.com:url]
X-Rspamd-Queue-Id: 349F3280F81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 14:55, Michael S. Tsirkin wrote:
> On Thu, Mar 12, 2026 at 02:06:35PM +0100, Simon Schippers wrote:
>> This patch series deals with tun/tap & vhost-net which drop incoming
>> SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
>> patch series, the associated netdev queue is stopped - but only when a
>> qdisc is attached. If no qdisc is present the existing behavior is
>> preserved. This patch series touches tun/tap and vhost-net, as they
>> share common logic and must be updated together. Modifying only one of
>> them would break the other.
>>
>> By applying proper backpressure, this change allows the connected qdisc to 
>> operate correctly, as reported in [1], and significantly improves
>> performance in real-world scenarios, as demonstrated in our paper [2]. For 
>> example, we observed a 36% TCP throughput improvement for an OpenVPN 
>> connection between Germany and the USA.
>>
>> Synthetic pktgen benchmarks indicate a slight regression.
>> Pktgen benchmarks are provided per commit, with the final commit showing
>> the overall performance.
>>
>> Thanks!
> 
> I posted a minor nit on patch 2.
> 
> Otherwise LGTM:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> thanks for the work!

Thanks!

Should I do a new version for the minor nit?

And how about the ptr_ring race:
I see there is a seperate discussion for that now. [1]
Should I wait for that?

Before sending a potential new version I would of course wait for
Jason's take.

[1] Link: https://lore.kernel.org/netdev/CANn89iJLC9p+N=Rqtuj7ZuPRdpSGCATCtZdz1Vi9mbzf3ATekQ@mail.gmail.com/

> 
> 
>> [1] Link: https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
>> [2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
>> [3] Link: https://lore.kernel.org/r/174549940981.608169.4363875844729313831.stgit@firesoul
>> [4] Link: https://lore.kernel.org/r/176295323282.307447.14790015927673763094.stgit@firesoul
>>
>> ---
>> Changelog:
>> V8:
>> - Drop code changes in drivers/net/tap.c; The code there deals with
>>   ipvtap/macvtap which are unrelated to the goal of this patch series
>>   and I did not realize that before
>> -> Greatly simplified logic, 4 instead of 9 commits
>> -> No more duplicated logics and distinction in vhost required
>> - Only wake after the queue stopped and half of the ring was consumed
>>   as suggested by MST
>> -> Performance improvements for TAP, but still slightly slower
>> - Better benchmarking with pinned threads, XDP drop program for
>>   tap+vhost-net and disabling CPU mitigations (and newer Ryzen 5 5600X
>>   processor) as suggested by Jason Wang
>>
>> V7: https://lore.kernel.org/netdev/20260107210448.37851-1-simon.schippers@tu-dortmund.de/
>> - Switch to an approach similar to veth [3] (excluding the recently fixed 
>> variant [4]), as suggested by MST, with minor adjustments discussed in V6
>> - Rename the cover-letter title
>> - Add multithreaded pktgen and iperf3 benchmarks, as suggested by Jason 
>> Wang
>> - Rework __ptr_ring_consume_created_space() so it can also be used after 
>> batched consume
>>
>> V6: https://lore.kernel.org/netdev/20251120152914.1127975-1-simon.schippers@tu-dortmund.de/
>> General:
>> - Major adjustments to the descriptions. Special thanks to Jon Kohler!
>> - Fix git bisect by moving most logic into dedicated functions and only 
>> start using them in patch 7.
>> - Moved the main logic of the coupled producer and consumer into a single 
>> patch to avoid a chicken-and-egg dependency between commits :-)
>> - Rebased to 6.18-rc5 and ran benchmarks again that now also include lost 
>> packets (previously I missed a 0, so all benchmark results were higher by 
>> factor 10...).
>> - Also include the benchmark in patch 7.
>>
>> Producer:
>> - Move logic into the new helper tun_ring_produce()
>> - Added a smp_rmb() paired with the consumer, ensuring freed space of the 
>> consumer is visible
>> - Assume that ptr_ring is not full when __ptr_ring_full_next() is called
>>
>> Consumer:
>> - Use an unpaired smp_rmb() instead of barrier() to ensure that the 
>> netdev_tx_queue_stopped() call completes before discarding
>> - Also wake the netdev queue if it was stopped before discarding and then 
>> becomes empty
>> -> Fixes race with producer as identified by MST in V5
>> -> Waking the netdev queues upon resize is not required anymore
>> - Use __ptr_ring_consume_created_space() instead of messing with ptr_ring 
>> internals
>> -> Batched consume now just calls 
>> __tun_ring_consume()/__tap_ring_consume() in a loop
>> - Added an smp_wmb() before waking the netdev queue which is paired with 
>> the smp_rmb() discussed above
>>
>> V5: https://lore.kernel.org/netdev/20250922221553.47802-1-simon.schippers@tu-dortmund.de/T/#u
>> - Stop the netdev queue prior to producing the final fitting ptr_ring entry
>> -> Ensures the consumer has the latest netdev queue state, making it safe 
>> to wake the queue
>> -> Resolves an issue in vhost-net where the netdev queue could remain 
>> stopped despite being empty
>> -> For TUN/TAP, the netdev queue no longer needs to be woken in the 
>> blocking loop
>> -> Introduces new helpers __ptr_ring_full_next and 
>> __ptr_ring_will_invalidate for this purpose
>> - vhost-net now uses wrappers of TUN/TAP for ptr_ring consumption rather 
>> than maintaining its own rx_ring pointer
>>
>> V4: https://lore.kernel.org/netdev/20250902080957.47265-1-simon.schippers@tu-dortmund.de/T/#u
>> - Target net-next instead of net
>> - Changed to patch series instead of single patch
>> - Changed to new title from old title
>> "TUN/TAP: Improving throughput and latency by avoiding SKB drops"
>> - Wake netdev queue with new helpers wake_netdev_queue when there is any 
>> spare capacity in the ptr_ring instead of waiting for it to be empty
>> - Use tun_file instead of tun_struct in tun_ring_recv as a more consistent 
>> logic
>> - Use smp_wmb() and smp_rmb() barrier pair, which avoids any packet drops 
>> that happened rarely before
>> - Use safer logic for vhost-net using RCU read locks to access TUN/TAP data
>>
>> V3: https://lore.kernel.org/netdev/20250825211832.84901-1-simon.schippers@tu-dortmund.de/T/#u
>> - Added support for TAP and TAP+vhost-net.
>>
>> V2: https://lore.kernel.org/netdev/20250811220430.14063-1-simon.schippers@tu-dortmund.de/T/#u
>> - Removed NETDEV_TX_BUSY return case in tun_net_xmit and removed 
>> unnecessary netif_tx_wake_queue in tun_ring_recv.
>>
>> V1: https://lore.kernel.org/netdev/20250808153721.261334-1-simon.schippers@tu-dortmund.de/T/#u
>> ---
>>
>> Simon Schippers (4):
>>   tun/tap: add ptr_ring consume helper with netdev queue wakeup
>>   vhost-net: wake queue of tun/tap after ptr_ring consume
>>   ptr_ring: move free-space check into separate helper
>>   tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
>>
>>  drivers/net/tun.c        | 91 +++++++++++++++++++++++++++++++++++++---
>>  drivers/vhost/net.c      | 15 +++++--
>>  include/linux/if_tun.h   |  3 ++
>>  include/linux/ptr_ring.h | 14 ++++++-
>>  4 files changed, 111 insertions(+), 12 deletions(-)
>>
>> -- 
>> 2.43.0
> 

