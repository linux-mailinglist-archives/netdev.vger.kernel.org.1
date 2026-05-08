Return-Path: <netdev+bounces-285892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAshCzn9/WkdlgAAu9opvQ
	(envelope-from <netdev+bounces-285892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:11:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 928C24F8642
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E28863060CE6
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83493FB7DE;
	Fri,  8 May 2026 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="RNV4/rNb"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F03FA5EA;
	Fri,  8 May 2026 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253076; cv=none; b=d21l9MWL7OAiYMeQNR/j08itSHeTARuOpm3g7FNd5+Ww7tGyS32FutI8cYabrUapxmV0/1TqS69qlW+/1lQFKcZtV4J/MnIXLmYlHg9apy9lt98x4nXxO2GCq94dROxrEl2f9sVfUzfJ/LBYlaCtSDCJs7OTbG3sdtxAv7YoiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253076; c=relaxed/simple;
	bh=MqzQxEdQpPZnkazea6jCXWZj8oS14iC+9splSC0hwOY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DvUCTdS2czK1wu00sGU/wnqHMNEz11oFYEEp0pQ/ZF2bXCB0chNmqNoPU05myoXnXRcrcrB2C5Er6MddrSz7HfUeCdRL9xSd8RWjiV6BgX8YPgONdEArWPPb1veu4vUY6gR6OOJ8+CEsTZ4+6dsUp/9vZMEjDdQ2nKecWuVLPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=RNV4/rNb; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778253063;
	bh=MqzQxEdQpPZnkazea6jCXWZj8oS14iC+9splSC0hwOY=;
	h=From:To:Subject:Date;
	b=RNV4/rNb1oz6nTE7zh7rPon9iWVHWcDs+NDywvEqmHZso1AtEyAdjaYknpPBZH7hF
	 kkSQ9JcZvzj+GZoGQnxsKEeZ+mrI2X6ioehf7rmeR9KveHcupPDTmoj1bjzJgBpCIm
	 GumksXJdHGH2aUxx9fhRl6eCtb8ti1bTOYIAsDDo=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.131])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 648FB26s013311
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 8 May 2026 17:11:02 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v11 0/4] tun/tap & vhost-net: apply qdisc backpressure on full ptr_ring to reduce TX drops
Date: Fri,  8 May 2026 17:10:44 +0200
Message-ID: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 928C24F8642
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-285892-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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

Synthetic pktgen benchmarks indicate a slight regression, and packet
loss is reduced to near zero. Pktgen benchmarks are provided per commit,
with the final commit showing the overall performance.

Thanks!

[1] Link: https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
[2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf

---
Changelog:
v11:
- Renamed __ptr_ring_produce_peek() to __ptr_ring_check_produce()
  (Sashiko)
- Add return code -EINVAL to __ptr_ring_check_produce() which lets
  tun_net_xmit() stop the queue only on -ENOSPC. (MST)
- Resolve race on tfile->queue_index by locking tx_ring.consumer_lock
  in __tun_detach(). (Sashiko)
- Wake the queue in tun_queue_resize() to avoid possible stalls.
- Other minor adjustments & reran the benchmarks.

v10: https://lore.kernel.org/netdev/20260506141033.180450-1-simon.schippers@tu-dortmund.de/
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

...

---

Simon Schippers (4):
  tun/tap: add ptr_ring consume helper with netdev queue wakeup
  vhost-net: wake queue of tun/tap after ptr_ring consume
  ptr_ring: move free-space check into separate helper
  tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present

 drivers/net/tun.c        | 121 +++++++++++++++++++++++++++++++++++----
 drivers/vhost/net.c      |  21 +++++--
 include/linux/if_tun.h   |   3 +
 include/linux/ptr_ring.h |  20 ++++++-
 4 files changed, 146 insertions(+), 19 deletions(-)

-- 
2.43.0


