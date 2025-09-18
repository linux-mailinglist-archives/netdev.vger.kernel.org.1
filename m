Return-Path: <netdev+bounces-224505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0AAB85B10
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC7C1886A2F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2DD30CB22;
	Thu, 18 Sep 2025 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVZP6BhK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B2A1F0994;
	Thu, 18 Sep 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209740; cv=none; b=jLJBI75yzUnMwgLUAl146xj+PeDX/MgdNXK1UMtkZrV8X0QLXD7P8yM36uJG73aUAeSr/kMM0IrTvfNJ4unsS+FCoha7ziqy69hly9sBMRK2QFsSl/CUySdPAehNeynehTXQwsDDV0v6nZ34fPqDPb4NuOAscdAJwjFfjEexkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209740; c=relaxed/simple;
	bh=ItneshBHTo73uksILGzox6w7ktfwro4yKIHbl6tbLGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DrxI79S8XgRh2mo58JDXaRoCL1hQDXcUHzSuR+CB4KQNL1VoeJPy3cTwyAU2HAQzfpeoMneBg7srM4yqJglMXBdShx5Q2HwcxIKg6bCYR6d41+9KxMe1FwTb0ax1/29QFLXLWsMRBtkkokKq74hR/vaWvm/iE9a5UmnIhhm9aBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVZP6BhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E1FC4CEE7;
	Thu, 18 Sep 2025 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758209739;
	bh=ItneshBHTo73uksILGzox6w7ktfwro4yKIHbl6tbLGA=;
	h=From:To:Cc:Subject:Date:From;
	b=JVZP6BhKLrdHtia6Gm9rcWS2D95EklTxoLevU+AtFXPkWi82Hnqj3DHI+6VG17LSr
	 sguC9OLcTUaJFJSOHjJ8Nk/DImD8+PUh4mYrtkPXb9UbJ8AjoLGsAcUNDKqVft+L9Z
	 Dm/miV3dZf/Ct9bA2Q2iVFhoGlgXzCI8rW8rPmLDr00FtSpmCUMFsea9nycb425TjE
	 gDNIhp2TIIMeo13JBLa5gCjrbduErzqbcccz9jWsp2YmSwv9aVXq4mhlL7NA9i4OoT
	 ZIvUbx9eXjdJnrDL0eu4TWEI6XV6gt8UvsxZ7XxqwNprPxvNFWDldQN1thZrgYUY7Z
	 PwM2aIVVMmbuQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.17-rc7
Date: Thu, 18 Sep 2025 08:35:38 -0700
Message-ID: <20250918153538.192731-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit db87bd2ad1f736c2f7ab231f9b40c885934f6b2c:

  Merge tag 'net-6.17-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-11 08:54:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc7

for you to fetch changes up to f8b4687151021db61841af983f1cb7be6915d4ef:

  octeontx2-pf: Fix use-after-free bugs in otx2_sync_tstamp() (2025-09-18 07:47:18 -0700)

----------------------------------------------------------------
Including fixes from wireless. No known regressions at this point.

Current release - fix to a fix:

 - eth: Revert "net/mlx5e: Update and set Xon/Xoff upon port speed set"

 - wifi: iwlwifi: pcie: fix byte count table for 7000/8000 devices

 - net: clear sk->sk_ino in sk_set_socket(sk, NULL), fix CRIU

Previous releases - regressions:

 - eth: ice: fix Rx page leak on multi-buffer frames

 - bonding: set random address only when slaves already exist

 - rxrpc: fix untrusted unsigned subtract

 - eth: mlx5: don't return mlx5_link_info table when speed is unknown

Previous releases - always broken:

 - tls: make sure to abort the stream if headers are bogus

 - tcp: fix null-deref when using TCP-AO with TCP_REPAIR

 - dpll: fix skipping last entry in clock quality level reporting

 - eth: qed: don't collect too many protection override GRC elements,
   fix memory corruption

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexey Nepomnyashih (1):
      net: liquidio: fix overflow in octeon_init_instr_queue()

Anderson Nascimento (1):
      net/tcp: Fix a NULL pointer dereference when using TCP-AO with TCP_REPAIR

Cosmin Ratiu (1):
      devlink rate: Remove unnecessary 'static' from a couple places

David Howells (2):
      rxrpc: Fix unhandled errors in rxgk_verify_packet_integrity()
      rxrpc: Fix untrusted unsigned subtract

Denis Kirjanov (1):
      MAINTAINERS: update sundance entry

Duoming Zhou (2):
      cnic: Fix use-after-free bugs in cnic_delete_task
      octeontx2-pf: Fix use-after-free bugs in otx2_sync_tstamp()

Eric Dumazet (1):
      net: clear sk->sk_ino in sk_set_socket(sk, NULL)

Geliang Tang (1):
      selftests: mptcp: sockopt: fix error messages

Hangbin Liu (4):
      bonding: set random address only when slaves already exist
      selftests: bonding: add fail_over_mac testing
      bonding: don't set oif to bond dev when getting NS target destination
      selftests: bonding: add vlan over bond testing

Hans de Goede (1):
      net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer

Håkon Bugge (1):
      rds: ib: Increment i_fastreg_wrs before bailing out

Ilya Maximets (2):
      net: dst_metadata: fix IP_DF bit not extracted from tunnel headers
      selftests: openvswitch: add a simple test for tunnel metadata

Ioana Ciornei (1):
      dpaa2-switch: fix buffer pool seeding for control traffic

Ivan Vecera (1):
      dpll: fix clock quality level reporting

Jacob Keller (1):
      ice: fix Rx page leak on multi-buffer frames

Jakub Kicinski (10):
      Merge branch 'net-dst_metadata-fix-df-flag-extraction-on-tunnel-rx'
      Merge branch 'selftests-mptcp-avoid-spurious-errors-on-tcp-disconnect'
      Merge branch 'mptcp-pm-nl-announce-deny-join-id0-flag'
      MAINTAINERS: make the DPLL entry cover drivers
      Merge branch 'mlx5e-misc-fixes-2025-09-15'
      Merge branch 'tcp-clear-tcp_sk-sk-fastopen_rsk-in-tcp_disconnect'
      Merge tag 'wireless-2025-09-17' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      tls: make sure to abort the stream if headers are bogus
      selftests: tls: test skb copy under mem pressure and OOB

Jamie Bainbridge (1):
      qed: Don't collect too many protection override GRC elements

Jedrzej Jagielski (2):
      ixgbe: initialize aci.lock before it's used
      ixgbe: destroy aci.lock later within ixgbe_remove path

Jianbo Liu (1):
      net/mlx5e: Harden uplink netdev access against device unbind

Johannes Berg (2):
      wifi: iwlwifi: pcie: fix byte count table for some devices
      Merge tag 'iwlwifi-fixes-2025-09-15' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Kamal Heib (1):
      octeon_ep: Validate the VF ID

Kohei Enju (1):
      igc: don't fail igc_probe() on LED setup error

Kuniyuki Iwashima (2):
      tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().
      selftest: packetdrill: Add tcp_fastopen_server_reset-after-disconnect.pkt.

Lama Kayal (1):
      net/mlx5e: Add a miss level for ipsec crypto offload

Li Tian (1):
      net/mlx5: Not returning mlx5_link_info table when speed is unknown

Maciej Fijalkowski (1):
      i40e: remove redundant memory barrier when cleaning Tx descs

Matthieu Baerts (NGI0) (9):
      mptcp: propagate shutdown to subflows when possible
      selftests: mptcp: connect: catch IO errors on listen side
      selftests: mptcp: avoid spurious errors on TCP disconnect
      selftests: mptcp: print trailing bytes with od
      selftests: mptcp: connect: print pcap prefix
      mptcp: set remote_deny_join_id0 on SYN recv
      mptcp: pm: nl: announce deny-join-id0 flag
      selftests: mptcp: userspace pm: validate deny-join-id0 flag
      mptcp: tfo: record 'deny join id0' info

Remy D. Farley (1):
      doc/netlink: Fix typos in operation attributes

Russell King (Oracle) (1):
      net: ethtool: handle EOPNOTSUPP from ethtool get_ts_info() method

Samiullah Khawaja (1):
      net: Use NAPI_* in test_bit when stopping napi kthread

Sathesh B Edara (1):
      octeon_ep: fix VF MAC address lifecycle handling

Tariq Toukan (1):
      Revert "net/mlx5e: Update and set Xon/Xoff upon port speed set"

Yeounsu Moon (1):
      net: natsemi: fix `rx_dropped` double accounting on `netif_rx()` failure

 Documentation/netlink/specs/conntrack.yaml         |   9 +-
 Documentation/netlink/specs/mptcp_pm.yaml          |   4 +-
 MAINTAINERS                                        |   4 +-
 drivers/dpll/dpll_netlink.c                        |   4 +-
 drivers/net/bonding/bond_main.c                    |   2 +-
 drivers/net/ethernet/broadcom/cnic.c               |   3 +-
 .../net/ethernet/cavium/liquidio/request_manager.c |   2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   3 -
 drivers/net/ethernet/intel/ice/ice_txrx.c          |  80 ++++-----
 drivers/net/ethernet/intel/ice/ice_txrx.h          |   1 -
 drivers/net/ethernet/intel/igc/igc.h               |   1 +
 drivers/net/ethernet/intel/igc/igc_main.c          |  12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  22 +--
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |  16 ++
 .../ethernet/marvell/octeon_ep/octep_pfvf_mbox.c   |   3 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_ptp.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |   1 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |   1 +
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   2 -
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  27 ++-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h |  15 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |   6 +-
 drivers/net/ethernet/natsemi/ns83820.c             |  13 +-
 drivers/net/ethernet/qlogic/qed/qed_debug.c        |   7 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c    |   2 +-
 include/linux/mlx5/driver.h                        |   1 +
 include/net/dst_metadata.h                         |  11 +-
 include/net/sock.h                                 |   5 +-
 include/uapi/linux/mptcp.h                         |   2 +
 include/uapi/linux/mptcp_pm.h                      |   4 +-
 net/core/dev.c                                     |   2 +-
 net/devlink/rate.c                                 |   4 +-
 net/ethtool/common.c                               |   4 +-
 net/ipv4/tcp.c                                     |   5 +
 net/ipv4/tcp_ao.c                                  |   4 +-
 net/mptcp/options.c                                |   6 +-
 net/mptcp/pm_netlink.c                             |   7 +
 net/mptcp/protocol.c                               |  16 ++
 net/mptcp/subflow.c                                |   4 +
 net/rds/ib_frmr.c                                  |  20 ++-
 net/rfkill/rfkill-gpio.c                           |   4 +-
 net/rxrpc/rxgk.c                                   |  18 +-
 net/rxrpc/rxgk_app.c                               |  29 ++-
 net/rxrpc/rxgk_common.h                            |  14 +-
 net/tls/tls.h                                      |   1 +
 net/tls/tls_strp.c                                 |  14 +-
 net/tls/tls_sw.c                                   |   3 +-
 .../selftests/drivers/net/bonding/bond_options.sh  | 197 ++++++++++++++++++++-
 .../drivers/net/bonding/bond_topo_2d1c.sh          |   3 +
 .../drivers/net/bonding/bond_topo_3d1c.sh          |   2 +
 tools/testing/selftests/drivers/net/bonding/config |   1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |  11 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   6 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c  |  16 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c      |   7 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  14 +-
 .../selftests/net/openvswitch/openvswitch.sh       |  88 ++++++++-
 .../tcp_fastopen_server_reset-after-disconnect.pkt |  26 +++
 tools/testing/selftests/net/tls.c                  |  16 ++
 64 files changed, 640 insertions(+), 179 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-disconnect.pkt

