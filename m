Return-Path: <netdev+bounces-270085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ4GD8fIvWkrBgMAu9opvQ
	(envelope-from <netdev+bounces-270085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:23:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE52E1BA4
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A05E3305615E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C6F3783D6;
	Fri, 20 Mar 2026 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GW7zfhYT"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96635C1BD;
	Fri, 20 Mar 2026 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045128; cv=none; b=ED8Z6Ot9dlMc0yF+Lck8ZY3Kej2FRO0fPM50WPdI6EzrNOMCR2lIDCRat31bM6nUfD5zMSbZKI3gXEKFTqSTpmeTTlq8XkObGtMJcwb8KBnJZfjvDD+6Q6y/Ew0n4uMUnCwlSevEnAPZBqc/GDtqy71rrFy1rIgTnL1m6afheYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045128; c=relaxed/simple;
	bh=duKDrdaUD7kdWenvnTaCUO6crov8sD3zDKFakwuTr6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZosGYZDwxoJ4imhl+iTeueTECI/g4ibA5Xiv3MVT1on6cSU9N+8m2IMJGCRzAKIb5STnm2I1zspycH1fkBJ4l9PCKJcri2lji2G0LvFmHcneyYaLuK2eASg3uIKs9IUhwV3ecY3Q0ce7NDN7uMJaz8OesTxEovMz8qeSpPHwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GW7zfhYT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=a3dH48CigsTd1gEHVBsWj7RR4AE3Cuv26Us2mCDFL0E=; b=GW7zfhYTjzIa1NyUjHXQR/Td0x
	M6iPzedPuiSckJEhl55ce6OoyrEhD7SjAXG3L8T94+/tOXs5t3iczekuTwCdLHMSDX0IE4S8sFS4K
	45o30l9nS367CjmQnbN09DkgY9MN7Z43W/DzB6iIwwr5m3DC9DhFEB2ALYJURHfRTZ5MI3IiCLoJw
	5khaNDo5T9OQC26cUdXQypahKNMJEOXSBop/K7x5jghEuNR3KUZrgwsZDMEP5lFY/pWK/yoacHTXz
	RKCa0EhYHOeXmpJ0iCrB1yPwfhqhOlSXPn59+lt98ZVRCaI7JVaOpkl4wPM70iDaDsqk9iGHKMrxC
	1SPtykSg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w3iAZ-000Gyp-2v;
	Fri, 20 Mar 2026 23:18:16 +0100
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
Subject: [PATCH net-next v9 00/14] netkit: Support for io_uring zero-copy and AF_XDP
Date: Fri, 20 Mar 2026 23:18:00 +0100
Message-ID: <20260320221814.236775-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27946/Fri Mar 20 07:24:31 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270085-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:mid]
X-Rspamd-Queue-Id: BFBE52E1BA4
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
   xs->queue_id could be from a TX queue (AI review bot)
 - Fix up exception path in queue leasing selftest (AI review bot)
 - Rebase and retested everything with mlx5 + bnxt_en
v5->v6:
 - Fix nest_queue test in netdev_nl_queue_fill_one (Jakub/AI review bot)
 - Fix netdev notifier locking leak (Jakub/AI review bot)
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
  selftests/net: Add queue lease tests

 Documentation/netlink/specs/netdev.yaml       |  46 ++
 Documentation/networking/netdevices.rst       |   6 +
 drivers/net/netkit.c                          | 372 +++++++++--
 include/linux/netdevice.h                     |  11 +-
 include/net/netdev_queues.h                   |  21 +-
 include/net/netdev_rx_queue.h                 |  29 +-
 include/net/page_pool/memory_provider.h       |   8 +-
 include/net/xdp_sock_drv.h                    |   2 +-
 include/uapi/linux/if_link.h                  |   6 +
 include/uapi/linux/netdev.h                   |  11 +
 io_uring/zcrx.c                               |   9 +-
 net/core/dev.c                                |  13 +
 net/core/dev.h                                |   7 +
 net/core/devmem.c                             |   6 +-
 net/core/netdev-genl-gen.c                    |  20 +
 net/core/netdev-genl-gen.h                    |   2 +
 net/core/netdev-genl.c                        | 232 ++++++-
 net/core/netdev_queues.c                      |  95 ++-
 net/core/netdev_rx_queue.c                    | 194 +++++-
 net/ethtool/channels.c                        |  12 +-
 net/ethtool/ioctl.c                           |   9 +-
 net/xdp/xsk.c                                 |  79 ++-
 tools/include/uapi/linux/netdev.h             |  11 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   4 +-
 .../selftests/drivers/net/hw/nk_qlease.py     | 614 ++++++++++++++++++
 26 files changed, 1675 insertions(+), 145 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_qlease.py

-- 
2.43.0


