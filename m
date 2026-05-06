Return-Path: <netdev+bounces-284866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J+YGn9O+2nWYwMAu9opvQ
	(envelope-from <netdev+bounces-284866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:21:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C42774DC0A2
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28EE3314BF1D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B8F495511;
	Wed,  6 May 2026 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="YV6alcRe"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAEF49250A;
	Wed,  6 May 2026 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076665; cv=none; b=A61BVBHhVT5YeTyr+IlLAeHBXvvZXVub9VuelEoX2/OfJ1bQaltgpspA9BwzQTEUBW/5uf7uyYulBIuyFDR6XKYA8gijqyazglK4gK/l0BdXBVP06DN0Krh8du8wSfpBL3dwOp6k9Ymnt5xpEoLiWT+ZxTtClJH00m/7dcWdK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076665; c=relaxed/simple;
	bh=r8p5W7qbxBo0/uZ/PrMp5hVGOK/fQsEKSIG/bXh1ess=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IWmdalrhiGMrhqvoiVkzXHqYZx/uKQF/23bbmGKAeu/ADbhFv/GeJV60scqC15WJfRKaBJFEO8OrX04sn/T8A1yrZnrLLvE4JlSHGxWN/k1NRYuH5kAl4gDou4aLCDEgetl/w3LpM6RVCuDj1q4EU9b7d5asUMnrAaIOAFQy23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=YV6alcRe; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778076651;
	bh=r8p5W7qbxBo0/uZ/PrMp5hVGOK/fQsEKSIG/bXh1ess=;
	h=From:To:Subject:Date;
	b=YV6alcReD/u7aSsKPGCVVWGjZO8FF/vLAyTfA4Zs5Dtv+0+BbcDdmjUpAexOHrRkx
	 G+uMAR/sOAF3nB+pIAuJfyxmLvf+UoTPSaTycgLBnjp7DmqiK2t1DueM2E7wByf28G
	 VMYRbGK0/sNEY3mtenyIEecCwaT2BHKD6m6gW5IM=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.46])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 646EAnWW015408
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 6 May 2026 16:10:49 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v10 0/4] tun/tap & vhost-net: apply qdisc backpressure on full ptr_ring to reduce TX drops
Date: Wed,  6 May 2026 16:10:29 +0200
Message-ID: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C42774DC0A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-284866-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stackexchange.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tu-dortmund.de:url,tu-dortmund.de:dkim,tu-dortmund.de:mid]

This patch series deals with tun/tap & vhost-net which drop incoming
SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
patch series, the associated netdev queue is stopped - but only when a
qdisc is attached. If no qdisc is present the existing behavior is
preserved. The XDP transmit path is not affected. This patch series
touches tun/tap and vhost-net, as they share common logic and must be
updated together. Modifying only one of them would break the other.

By applying proper backpressure, this change allows the connected qdisc to 
operate correctly, as reported in [1], and significantly improves
performance in real-world scenarios, as demonstrated in our paper [2]. For 
example, we observed a 36% TCP throughput improvement for an OpenVPN 
connection between Germany and the USA.

Synthetic pktgen benchmarks indicate a slight regression, but packet loss
no longer occurs. Pktgen benchmarks are provided per commit, with the final
commit showing the overall performance.

Thanks!

[1] Link: https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
[2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf

---
Changelog:
v10:
- Changed the term "Transmitted" to "Received" in the benchmarks,
  as correctly pointed out by MST, and reran the benchmarks.

Addressed the Sashiko AI review:
- Avoid a data race on tfile->cons_cnt by always locking.
- Correctly count the number of consumed packets for vhost-net.
- Corrected a typo in the commit message of commit 3.
- Added a missing barrier on the consumer side.
--> The barriers now follow the "store buffering" principle.
- No longer return NETDEV_TX_BUSY at all, because it is unsafe.
--> Result: There are still a few drops with multiple senders, which
            would be avoided by disabling LLTX.

V9: https://lore.kernel.org/netdev/20260428123859.19578-1-simon.schippers@tu-dortmund.de/
- Addressed minor nit by MST in patches 1 and 2.
- Rebased patch 3 because of commit d748047
  ("ptr_ring: disable KCSAN warnings").
- Documented the pair of the smp_mb__after_atomic() in tun_net_xmit()
  with tun_ring_consume().
  --> It simply pairs with the test_and_clear_bit() inside of
      netif_wake_subqueue().
- Use 1 ptr_ring consumer spinlock instead of 2.
- Ran pktgen benchmarks with pg_set SHARED for 50 iterations on
  latest kernel
  --> No significant performance difference noticed

V8: https://lore.kernel.org/netdev/20260312130639.138988-1-simon.schippers@tu-dortmund.de/
- Drop code changes in drivers/net/tap.c; The code there deals with
  ipvtap/macvtap which are unrelated to the goal of this patch series
  and I did not realize that before
-> Greatly simplified logic, 4 instead of 9 commits
-> No more duplicated logics and distinction in vhost required
- Only wake after the queue stopped and half of the ring was consumed
  as suggested by MST
-> Performance improvements for TAP, but still slightly slower
- Better benchmarking with pinned threads, XDP drop program for
  tap+vhost-net and disabling CPU mitigations (and newer Ryzen 5 5600X
  processor) as suggested by Jason Wang

V7: https://lore.kernel.org/netdev/20260107210448.37851-1-simon.schippers@tu-dortmund.de/
- Switch to an approach similar to veth (excluding the recently fixed 
variant), as suggested by MST, with minor adjustments discussed in V6
- Rename the cover-letter title
- Add multithreaded pktgen and iperf3 benchmarks, as suggested by Jason 
Wang
- Rework __ptr_ring_consume_created_space() so it can also be used after 
batched consume

V6: https://lore.kernel.org/netdev/20251120152914.1127975-1-simon.schippers@tu-dortmund.de/
General:
- Major adjustments to the descriptions. Special thanks to Jon Kohler!
- Fix git bisect by moving most logic into dedicated functions and only 
start using them in patch 7.
- Moved the main logic of the coupled producer and consumer into a single 
patch to avoid a chicken-and-egg dependency between commits :-)
- Rebased to 6.18-rc5 and ran benchmarks again that now also include lost 
packets (previously I missed a 0, so all benchmark results were higher by 
factor 10...).
- Also include the benchmark in patch 7.

Producer:
- Move logic into the new helper tun_ring_produce()
- Added a smp_rmb() paired with the consumer, ensuring freed space of the 
consumer is visible
- Assume that ptr_ring is not full when __ptr_ring_full_next() is called

Consumer:
- Use an unpaired smp_rmb() instead of barrier() to ensure that the 
netdev_tx_queue_stopped() call completes before discarding
- Also wake the netdev queue if it was stopped before discarding and then 
becomes empty
-> Fixes race with producer as identified by MST in V5
-> Waking the netdev queues upon resize is not required anymore
- Use __ptr_ring_consume_created_space() instead of messing with ptr_ring 
internals
-> Batched consume now just calls 
__tun_ring_consume()/__tap_ring_consume() in a loop
- Added an smp_wmb() before waking the netdev queue which is paired with 
the smp_rmb() discussed above

V5: https://lore.kernel.org/netdev/20250922221553.47802-1-simon.schippers@tu-dortmund.de/T/#u
- Stop the netdev queue prior to producing the final fitting ptr_ring entry
-> Ensures the consumer has the latest netdev queue state, making it safe 
to wake the queue
-> Resolves an issue in vhost-net where the netdev queue could remain 
stopped despite being empty
-> For TUN/TAP, the netdev queue no longer needs to be woken in the 
blocking loop
-> Introduces new helpers __ptr_ring_full_next and 
__ptr_ring_will_invalidate for this purpose
- vhost-net now uses wrappers of TUN/TAP for ptr_ring consumption rather 
than maintaining its own rx_ring pointer

V4: https://lore.kernel.org/netdev/20250902080957.47265-1-simon.schippers@tu-dortmund.de/T/#u
- Target net-next instead of net
- Changed to patch series instead of single patch
- Changed to new title from old title
"TUN/TAP: Improving throughput and latency by avoiding SKB drops"
- Wake netdev queue with new helpers wake_netdev_queue when there is any 
spare capacity in the ptr_ring instead of waiting for it to be empty
- Use tun_file instead of tun_struct in tun_ring_recv as a more consistent 
logic
- Use smp_wmb() and smp_rmb() barrier pair, which avoids any packet drops 
that happened rarely before
- Use safer logic for vhost-net using RCU read locks to access TUN/TAP data

V3: https://lore.kernel.org/netdev/20250825211832.84901-1-simon.schippers@tu-dortmund.de/T/#u
- Added support for TAP and TAP+vhost-net.

V2: https://lore.kernel.org/netdev/20250811220430.14063-1-simon.schippers@tu-dortmund.de/T/#u
- Removed NETDEV_TX_BUSY return case in tun_net_xmit and removed 
unnecessary netif_tx_wake_queue in tun_ring_recv.

V1: https://lore.kernel.org/netdev/20250808153721.261334-1-simon.schippers@tu-dortmund.de/T/#u
---

Simon Schippers (4):
  tun/tap: add ptr_ring consume helper with netdev queue wakeup
  vhost-net: wake queue of tun/tap after ptr_ring consume
  ptr_ring: move free-space check into separate helper
  tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present

 drivers/net/tun.c        | 102 ++++++++++++++++++++++++++++++++++++---
 drivers/vhost/net.c      |  21 +++++---
 include/linux/if_tun.h   |   3 ++
 include/linux/ptr_ring.h |  17 ++++++-
 4 files changed, 129 insertions(+), 14 deletions(-)

-- 
2.43.0


