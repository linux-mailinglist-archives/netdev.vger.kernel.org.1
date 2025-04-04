Return-Path: <netdev+bounces-179340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDCFA7C0A2
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335613B032A
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF91EEA5F;
	Fri,  4 Apr 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ+3VBvi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7221DF962;
	Fri,  4 Apr 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743780898; cv=none; b=pitFCsHXAeP9IfAtJgEBX5yzvXMO4CupPGcbUkkK4ICei9B63V31gfXsbEVgLVqsDo3growwGqSVhlnN1h3iBpPmE0FbqWCswfDWUeE7N+jVh7CurRr7R7hcJW2I/k1mr8YDiUvpAWBnHFMbS6/sBNq8XSoYqwBY2VHUfSLpfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743780898; c=relaxed/simple;
	bh=3uEHTDw/3XQTvk2J7l7lzF2ck/KIJXYINF9455kJW4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cBxLAC/z/b9XkrwvNm8lfrK9xxSSypfANqxmzYigsVRzSu++0eIjR5F1sK805lDbIVAlqfWiMLHqiKubYW5SEc1vOQlkemKGGyEirWWblyTjrPzW7wzGHv3H50XbQ5XrN1Qow4QKb1u+6g6JznkDJkAn+aMlEbJZGfPdQMeZVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ+3VBvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EB4C4CEDD;
	Fri,  4 Apr 2025 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743780898;
	bh=3uEHTDw/3XQTvk2J7l7lzF2ck/KIJXYINF9455kJW4k=;
	h=From:To:Cc:Subject:Date:From;
	b=BQ+3VBvi0lUb6Zhss5tPGlGdCI3Qi1Ixml8RBcqZx8uWgME/WhpfM9LKwin0WpZEz
	 jMpt0b7kXnC2daSH8FjKzUq5yDkhRMPRB2xt1KABOL2UGOxJVS+9B9y4WpMuVfdCXZ
	 9ZUw8DHb0FcpKDhaYco4HtseMQvhyURLhJCHPFa88BOEUixbXaqqMlIsR5AygkCFy4
	 OSQnvk43JXNaQRG8yL472bNB+Hm2tW7RbKv8jBNNUWiwIZNBp5nsbfOUkfF2YzcOY4
	 9szCBFEIjIazJJ/RpCmMrU2aShnx9/w3NXZ+Zpgr8a7DGqTAcOmfRjM5jRNXLCy2WA
	 IHkT6Dj+uTTZw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.15-rc1
Date: Fri,  4 Apr 2025 08:34:57 -0700
Message-ID: <20250404153457.2339036-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit acc4d5ff0b61eb1715c498b6536c38c1feb7f3c1:

  Merge tag 'net-6.15-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-04-01 20:00:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc1

for you to fetch changes up to 94f68c0f99a548d33a102672690100bf76a7c460:

  selftests: net: amt: indicate progress in the stress test (2025-04-04 08:02:09 -0700)

----------------------------------------------------------------
Including fixes from netfilter.

Current release - regressions:

 - 4 fixes for the netdev per-instance locking

Current release - new code bugs:

 - consolidate more code between existing Rx zero-copy and uring so that
   the latter doesn't miss / have to duplicate the safety checks

Previous releases - regressions:

 - ipv6: fix omitted Netlink attributes when using SKIP_STATS

Previous releases - always broken:

 - net: fix geneve_opt length integer overflow

 - udp: fix multiple wrap arounds of sk->sk_rmem_alloc when it
   approaches INT_MAX

 - dsa: mvpp2: add a lock to avoid corruption of the shared TCAM

 - dsa: airoha: fix issues with traffic QoS configuration / offload,
   and flow table offload

Misc:

 - touch up the Netlink YAML specs of old families to make them usable
   for user space C codegen

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Antoine Tenart (1):
      net: decrease cached dst counters in dst_release

Cong Wang (2):
      net_sched: skbprio: Remove overly strict queue assertions
      selftests: tc-testing: Add TBF with SKBPRIO queue length corner case test

Dave Marquardt (1):
      net: ibmveth: make veth_pool_store stop hanging

David Oberhollenzer (1):
      net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer on destroy

David Wei (1):
      io_uring/zcrx: fix selftests w/ updated netdev Python helpers

Debin Zhu (1):
      netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets

Dmitry Safonov (1):
      net/selftests: Add loopback link local route for self-connect

Edward Cree (1):
      sfc: fix NULL dereferences in ef100_process_design_param()

Emil Tantilov (1):
      idpf: fix adapter NULL pointer dereference on reboot

Eric Dumazet (1):
      sctp: add mutual exclusion in proc_sctp_do_udp_port()

Fernando Fernandez Mancera (1):
      ipv6: fix omitted netlink attributes when using RTEXT_FILTER_SKIP_STATS

Florian Westphal (1):
      netfilter: nf_tables: don't unregister hook when table is dormant

Greg Thelen (1):
      eth: mlx4: select PAGE_POOL

Guillaume Nault (1):
      tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().

Henry Martin (1):
      arcnet: Add NULL check in com20020pci_probe()

Ido Schimmel (2):
      ipv6: Start path selection from the first nexthop
      ipv6: Do not consider link down nexthops in path selection

Jakub Kicinski (16):
      Merge branch 'net_sched-skbprio-remove-overly-strict-queue-assertions'
      MAINTAINERS: update Open vSwitch maintainers
      Merge branch 'udp-fix-two-integer-overflows-when-sk-sk_rcvbuf-is-close-to-int_max'
      Merge branch 'net-hold-instance-lock-during-netdev_up-register'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'nf-25-04-03' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'ipv6-multipath-routing-fixes'
      net: move mp dev config validation to __net_mp_open_rxq()
      net: avoid false positive warnings in __net_mp_close_rxq()
      Merge branch 'net-make-memory-provider-install-close-paths-more-common'
      netlink: specs: rt_addr: fix the spec format / schema failures
      netlink: specs: rt_addr: fix get multi command name
      netlink: specs: rt_addr: pull the ifa- prefix out of the names
      netlink: specs: rt_route: pull the ifa- prefix out of the names
      Merge branch 'netlink-specs-rt_addr-fix-problems-revealed-by-c-codegen'
      selftests: net: amt: indicate progress in the stress test

Joe Damato (1):
      igc: Fix XSK queue NAPI ID mapping

Joshua Washington (1):
      gve: handle overflow when reporting TX consumed descriptors

Kuniyuki Iwashima (3):
      rtnetlink: Use register_pernet_subsys() in rtnl_net_debug_init().
      udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
      udp: Fix memory accounting leak.

Lin Ma (2):
      netfilter: nft_tunnel: fix geneve_opt type confusion addition
      net: fix geneve_opt length integer overflow

Loic Poulain (1):
      MAINTAINERS: Update Loic Poulain's email address

Lorenzo Bianconi (4):
      net: airoha: Fix qid report in airoha_tc_get_htb_get_leaf_queue()
      net: airoha: Fix ETS priomap validation
      net: airoha: Validate egress gdm port in airoha_ppe_foe_entry_prepare()
      net: octeontx2: Handle XDP_ABORTED and XDP invalid as XDP_DROP

Pablo Neira Ayuso (1):
      netfilter: nft_set_hash: GC reaps elements with conncount for dynamic sets only

Pedro Tammela (1):
      selftests: tc-testing: fix nat regex matching

Piotr Kwapulinski (1):
      ixgbe: fix media type detection for E610 device

Stanislav Fomichev (9):
      bpf: add missing ops lock around dev_xdp_attach_link
      net: switch to netif_disable_lro in inetdev_init
      net: hold instance lock during NETDEV_REGISTER/UP
      net: use netif_disable_lro in ipv6_add_dev
      net: rename rtnl_net_debug to lock_debug
      netdevsim: add dummy device notifiers
      net: dummy: request ops lock
      docs: net: document netdev notifier expectations
      selftests: net: use netdevsim in netns test

Stefano Garzarella (1):
      vsock: avoid timeout during connect() if the socket is closing

Taehee Yoo (1):
      eth: bnxt: fix deadlock in the mgmt_ops

Tobias Waldekranz (1):
      net: mvpp2: Prevent parser TCAM memory corruption

Vitaly Lifshits (1):
      e1000e: change k1 configuration on MTP and later platforms

Ying Lu (1):
      usbnet:fix NPE during rx_complete

Zdenek Bouska (1):
      igc: Fix TX drops in XDP ZC

 CREDITS                                            |   4 +
 Documentation/netlink/specs/rt_addr.yaml           |  42 +++--
 Documentation/netlink/specs/rt_route.yaml          | 180 +++++++++---------
 Documentation/networking/netdevices.rst            |  23 +++
 MAINTAINERS                                        |  10 +-
 drivers/net/arcnet/com20020-pci.c                  |  17 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  11 +-
 drivers/net/dsa/mv88e6xxx/phy.c                    |   3 +
 drivers/net/dummy.c                                |   1 +
 drivers/net/ethernet/airoha/airoha_eth.c           |  31 +++-
 drivers/net/ethernet/airoha/airoha_eth.h           |   3 +
 drivers/net/ethernet/airoha/airoha_ppe.c           |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   6 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c      |   4 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |  39 ++--
 drivers/net/ethernet/intel/e1000e/defines.h        |   3 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  80 +++++++-
 drivers/net/ethernet/intel/e1000e/ich8lan.h        |   4 +
 drivers/net/ethernet/intel/idpf/idpf_main.c        |   6 +-
 drivers/net/ethernet/intel/igc/igc.h               |   2 -
 drivers/net/ethernet/intel/igc/igc_main.c          |   6 +-
 drivers/net/ethernet/intel/igc/igc_xdp.c           |   2 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      |   4 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |   3 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   3 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c     | 201 ++++++++++++++-------
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   9 +-
 drivers/net/ethernet/mellanox/mlx4/Kconfig         |   1 +
 drivers/net/ethernet/sfc/ef100_netdev.c            |   6 +-
 drivers/net/ethernet/sfc/ef100_nic.c               |  47 +++--
 drivers/net/netdevsim/netdev.c                     |  13 ++
 drivers/net/netdevsim/netdevsim.h                  |   3 +
 drivers/net/usb/usbnet.c                           |   6 +-
 include/linux/netdevice.h                          |   2 +-
 include/net/ip.h                                   |  16 +-
 include/net/netdev_lock.h                          |   3 +
 include/net/page_pool/memory_provider.h            |   6 +
 net/core/Makefile                                  |   2 +-
 net/core/dev.c                                     |  15 +-
 net/core/dev_api.c                                 |   8 +-
 net/core/devmem.c                                  |  64 ++-----
 net/core/dst.c                                     |   8 +
 net/core/{rtnl_net_debug.c => lock_debug.c}        |  16 +-
 net/core/netdev-genl.c                             |   6 -
 net/core/netdev_rx_queue.c                         |  53 ++++--
 net/core/rtnetlink.c                               |   8 +-
 net/ipv4/devinet.c                                 |   2 +-
 net/ipv4/ip_tunnel_core.c                          |   4 +-
 net/ipv4/udp.c                                     |  42 +++--
 net/ipv6/addrconf.c                                |  52 ++++--
 net/ipv6/calipso.c                                 |  21 ++-
 net/ipv6/route.c                                   |  42 ++++-
 net/netfilter/nf_tables_api.c                      |   4 +-
 net/netfilter/nft_set_hash.c                       |   3 +-
 net/netfilter/nft_tunnel.c                         |   6 +-
 net/openvswitch/actions.c                          |   6 -
 net/sched/act_tunnel_key.c                         |   2 +-
 net/sched/cls_flower.c                             |   2 +-
 net/sched/sch_skbprio.c                            |   3 -
 net/sctp/sysctl.c                                  |   4 +
 net/vmw_vsock/af_vsock.c                           |   6 +-
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py |   8 +-
 tools/testing/selftests/net/amt.sh                 |  20 +-
 tools/testing/selftests/net/lib.sh                 |  25 +++
 tools/testing/selftests/net/netns-name.sh          |  13 +-
 tools/testing/selftests/net/rtnetlink.py           |   4 +-
 tools/testing/selftests/net/tcp_ao/self-connect.c  |   3 +
 .../selftests/tc-testing/tc-tests/actions/nat.json |  14 +-
 .../tc-testing/tc-tests/infra/qdiscs.json          |  34 +++-
 69 files changed, 865 insertions(+), 443 deletions(-)
 rename net/core/{rtnl_net_debug.c => lock_debug.c} (87%)

