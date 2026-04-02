Return-Path: <netdev+bounces-274748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN+wEIb5zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:19:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE538F214
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B708C306F2F2
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22D23F8DFE;
	Thu,  2 Apr 2026 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="G+xmNHLv"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D63F87ED;
	Thu,  2 Apr 2026 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171462; cv=none; b=T/yd07XI6Y5BC2D1sgx9qt2I+ONfLWmnRtWnViGItjq/QsZKlEhlKal6fa/vRtETTrnJzIyj1ne5JXtcMlKEcggJFh3ETVv2apsD3R6gClijSKXNqnXVbeKTAczwRb0DaOe41eiq8EcdDU3qNvvfy6eEig3ns4g2Y0PXf+XCEXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171462; c=relaxed/simple;
	bh=fLR7znhFxS/NkC3AdbBFih0JFnazWTTMbrtT+7W1sEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d98fMa86u7jJ3aoiTfz2SjbDB0n6anILq71Ea8Y1rY5wvViTtwV0PCY5ZaIPCXDSBvyoAO/sxsgPWZMQjhVIOkyeMm3tzC6ZIYFSp/iYlliV9jtrxnB5PEIedaSjJtsQ3KP2AgvLjtwGpGODQwvvzDhboYL9TiuNoLbxgpqwgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=G+xmNHLv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=c9PuvOC2DudnLdGYIA/8l8y16II3FppEhq2xCghE0Vo=; b=G+xmNHLvy8eq0Mxg7L5bjWBert
	HEtIXshBHUXmAPBXnEHjS9YOeckfziaA9MO/nL9oiCd9wAKllICPlbHeAc34IY+C8M39MpQEZU7or
	EX5EWPQ9jdHJ9xefBvyMhKbWpswrtKVQByovsDsLOmSt5PpnMx/QHabFl5k2JUklmw78ZJx6ECcW2
	rvy2FymnursQBGq//rzudiz1MePdvDxC1SfZZ3L4pRc59yUyaIS1nzzAhkNZhGNKNpRBlEmAdkx1H
	9R4pMeCFhi92drS2BuauHYRia2W9hMGOUjawl9JSQPZkyqQ/db4daEgX+euYn1zRIVDgKQRT7iQI/
	48T5akpA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w8RBI-0000lW-2u;
	Fri, 03 Apr 2026 01:10:33 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v11 00/14] netkit: Support for io_uring zero-copy and AF_XDP
Date: Fri,  3 Apr 2026 01:10:17 +0200
Message-ID: <20260402231031.447597-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27959/Thu Apr  2 08:25:45 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274748-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:dkim,iogearbox.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FEE538F214
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Containers use virtual netdevs to route traffic from a physical netdev
in the host namespace. They do not have access to the physical netdev
in the host and thus can't use memory providers or AF_XDP that require
reconfiguring/restarting queues in the physical netdev.

This patchset adds the concept of queue leasing to virtual netdevs that
allow containers to use memory providers and AF_XDP at native speed.
Leased queues are bound to a real queue in a physical netdev and act
as a proxy.

Memory providers and AF_XDP operations take an ifindex and queue id,
so containers would pass in an ifindex for a virtual netdev and a queue
id of a leased queue, which then gets proxied to the underlying real
queue.

We have implemented support for this concept in netkit and tested the
latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
(bnxt_en) 100G NICs. For more details see the individual patches.

v10->v11:
 - Fix missing mp_ops->uninstall upon unlease path (Gemini)
 - Fix dma device retrieval on tx queue when rx queue is leased (Gemini)
 - Rework ethtool channel checks to check rx/tx individually (Gemini)
 - The remainder of the Gemini findings were non-issues
 - Add more extensive net selftests around queue leasing corner cases
 - Rebase and retested everything with mlx5 + bnxt_en
v9->v10:
 - Fix netkit selftest ruff checks (Jakub)
 - Pass in net arg in netdev_put_lock (Gemini)
 - Make the ethtool channel busy checks direction-aware (Gemini)
 - Fix list corruption in netkit_check_lease_unregister (Gemini)
 - Fix netkit_set_headroom in single device mode (Gemini)
 - Fix xsk_clear_pool_at_qid bounds to use num_{rx,tx}_queues (Gemini)
 - Fix netkit xsk teardown state checks (Gemini)
 - The remainder of the Gemini findings were non-issues
 - Rebase and retested everything with mlx5 + bnxt_en
v8->v9:
 - Use ynl --family netdev in commit desc (Jakub)
 - Update docs and comments about locking (Jakub)
 - Propagate extack to the driver in ndo_queue_create (Jakub)
 - Move function to net/core/dev.h core where possible (Jakub)
 - Add comment about lease in netdev_rx_queue struct (Jakub)
 - Add min: 0 check to netns id in policy (Jakub)
 - Drop ifindex == ifindex_lease test in netdev_nl_queue_create_doit (Jakub)
 - Detailed extack errors in netkit's ndo_queue_create (Jakub)
 - Refactor lease dump into own function in netdev_nl_queue_fill_one (Jakub)
 - Dump mp and xsk info for both queues in netdev_nl_queue_fill_one (Jakub)
 - Replace the net_ prefix with netif_ for net_mp_{open,close}_rxq (Jakub)
 - Remove ifq_idx naming cleanup from net_mp_{open,close}_rxq (Jakub)
 - Rework the mp entry points to have explicit code that deals with
   the lease (Jakub)
 - Fix locking in netdev_queue_get_dma_dev (Jakub)
 - Remove unneeded carrier flap in netkit_queue_create (Jakub)
 - Drop base net selftests that were already merged
 - Add more nekit queue leasing coverage of base functionality (Jakub)
 - Remove any mp leftovers upon unlease found via test cases
 - Rebase and retested everything with mlx5 + bnxt_en
v7->v8:
 - Rework and refactor net_mp_{open,close}_rxq patch (Jakub)
 - Moved queue lease netlink command from env into test (Jakub)
 - Support netns_id also in queue create call and not only dump
 - Rebase and retested everything with mlx5 + bnxt_en
v6->v7:
 - Add xsk_dev_queue_valid real_num_rx_queues check given bound
   xs->queue_id could be from a TX queue (Claude)
 - Fix up exception path in queue leasing selftest (Claude)
 - Rebase and retested everything with mlx5 + bnxt_en
v5->v6:
 - Fix nest_queue test in netdev_nl_queue_fill_one (Jakub/Claude)
 - Fix netdev notifier locking leak (Jakub/Claude)
 - Drop NETREG_UNREGISTERING WARN_ON_ONCE to avoid confusion (Stan)
 - Remove slipped-in .gitignore cruft in net selftest (Stan)
 - Fix Pylint warnings in net selftest (Jakub)
 - Rebase and retested everything with mlx5 + bnxt_en
v4->v5:
 - Rework of the core API into queue-create op (Jakub)
 - Rename from queue peering to queue leasing (Jakub)
 - Add net selftests for queue leasing (Stan, Jakub)
 - Move netkit_queue_get_dma_dev into core (Jakub)
 - Dropped netkit_get_channels (Jakub)
 - Moved ndo_queue_create back to return index or error (Jakub)
 - Inline __netdev_rx_queue_{peer,unpeer} helpers (Jakub)
 - Adding helpers in patches where they are used (Jakub)
 - Undo inline for netdev_put_lock (Jakub)
 - Factoring out checks whether device can lease (Jakub)
 - Fix up return codes in netdev_nl_bind_queue_doit (Jakub)
 - Reject when AF_XDP or mp already bound (Jakub)
 - Switch some error cases to NL_SET_BAD_ATTR() (Jakub)
 - Rebase and retested everything with mlx5 + bnxt_en
v3->v4:
 - ndo_queue_create store dst queue via arg (Nikolay)
 - Small nits like a spelling issue + rev xmas (Nikolay)
 - admin-perm flag in bind-queue spec (Jakub)
 - Fix potential ABBA deadlock situation in bind (Jakub, Paolo, Stan)
 - Add a peer dev_tracker to not reuse the sysfs one (Jakub)
 - New patch (12/14) to handle the underlying device going away (Jakub)
 - Improve commit message on queue-get (Jakub)
 - Do not expose phys dev info from container on queue-get (Jakub)
 - Add netif_put_rx_queue_peer_locked to simplify code (Stan)
 - Rework xsk handling to simplify the code and drop a few patches
 - Rebase and retested everything with mlx5 + bnxt_en
v2->v3:
 - Use netdev_ops_assert_locked instead of netdev_assert_locked (syzbot)
 - Add missing netdev_lockdep_set_classes in netkit
v1->v2:
 - Removed bind sample ynl code (Stan)
 - Reworked netdev locking to have consistent order (Stan, Kuba)
 - Return 'not supported' in API patch (Stan)
 - Improved ynl documentation (Kuba)
 - Added 'max: s32-max' in ynl spec for ifindex (Kuba)
 - Added also queue type in ynl to have user specify rx to make
   it obvious (Kuba)
 - Use of netdev_hold (Kuba)
 - Avoid static inlines from another header (Kuba)
 - Squashed some commits (Kuba, Stan)
 - Removed ndo_{peer,unpeer}_queues callback and simplified
   code (Kuba)
 - Improved commit messages (Toke, Kuba, Stan, zf)
 - Got rid of locking genl_sk_priv_get (Stan)
 - Removed af_xdp cleanup churn (Maciej)
 - Added netdev locking asserts (Stan)
 - Reject ethtool ioctl path queue resizing (Kuba)
 - Added kdoc for ndo_queue_create (Stan)
 - Uninvert logic in netkit single dev mode (Jordan)
 - Added binding support for multiple queues

Daniel Borkmann (10):
  net: Add queue-create operation
  net: Implement netdev_nl_queue_create_doit
  net: Add lease info to queue-get response
  net, ethtool: Disallow leased real rxqs to be resized
  net: Slightly simplify net_mp_{open,close}_rxq
  xsk: Extend xsk_rcv_check validation
  xsk: Proxy pool management for leased queues
  netkit: Add single device mode for netkit
  netkit: Add netkit notifier to check for unregistering devices
  netkit: Add xsk support for af_xdp applications

David Wei (4):
  net: Proxy netif_mp_{open,close}_rxq for leased queues
  net: Proxy netdev_queue_get_dma_dev for leased queues
  netkit: Implement rtnl_link_ops->alloc and ndo_queue_create
  selftests/net: Add queue leasing tests with netkit

 Documentation/netlink/specs/netdev.yaml       |   46 +
 Documentation/netlink/specs/rt-link.yaml      |   11 +
 Documentation/networking/netdevices.rst       |    6 +
 drivers/net/netkit.c                          |  412 ++++-
 include/linux/netdevice.h                     |   11 +-
 include/net/netdev_queues.h                   |   23 +-
 include/net/netdev_rx_queue.h                 |   29 +-
 include/net/page_pool/memory_provider.h       |    8 +-
 include/uapi/linux/if_link.h                  |    6 +
 include/uapi/linux/netdev.h                   |   11 +
 io_uring/zcrx.c                               |   12 +-
 net/core/dev.c                                |   18 +-
 net/core/dev.h                                |   12 +
 net/core/devmem.c                             |    6 +-
 net/core/netdev-genl-gen.c                    |   20 +
 net/core/netdev-genl-gen.h                    |    2 +
 net/core/netdev-genl.c                        |  238 ++-
 net/core/netdev_queues.c                      |  103 +-
 net/core/netdev_rx_queue.c                    |  205 ++-
 net/ethtool/channels.c                        |   28 +-
 net/ethtool/ioctl.c                           |   21 +-
 net/xdp/xsk.c                                 |   76 +-
 tools/include/uapi/linux/netdev.h             |   11 +
 .../testing/selftests/drivers/net/hw/Makefile |    1 +
 .../drivers/net/hw/lib/py/__init__.py         |    4 +-
 .../selftests/drivers/net/hw/nk_qlease.py     | 1407 +++++++++++++++++
 26 files changed, 2558 insertions(+), 169 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_qlease.py

-- 
2.43.0


