Return-Path: <netdev+bounces-240490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEA7C757C6
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB17B4E19CB
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC2D36BCF5;
	Thu, 20 Nov 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJhcQAmq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1DA36BCD2;
	Thu, 20 Nov 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657239; cv=none; b=cdt06CcFuku2lN9iG27ENYQCsYI5fCZG1QKXooASu5T5+N/JKyYtwARjijPSqaTqkDNXZu5P92JW7WmzKUl5wjAsv/+p6E9l/hmSTTpMWIdM7/eXyShUB+SbZRX6yHSOMvsdtd0ymHozl6D2aPew3lxalPiy2vx0B6Y/Tk6RTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657239; c=relaxed/simple;
	bh=LjuhgqD9n1j5hJRaIAx2AOc3Lan7soWPzgEKsEeP9xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cd2/hFIrkmKdPHAPneCQrw+wgPC7A0fInOEyEalG/DP0GFe3MBBKUzCEmkEevWRrg3UgvcGWLbY5XoXkW73joAjXzsFjR21nAKjFyMgULtL8KLf3VMYSY9OuacQLvdaydkRVijEKD9dSmLCjcXu3VXRtLdH9zDZLrvRbunR4ctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJhcQAmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BFFC116D0;
	Thu, 20 Nov 2025 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763657238;
	bh=LjuhgqD9n1j5hJRaIAx2AOc3Lan7soWPzgEKsEeP9xo=;
	h=From:To:Cc:Subject:Date:From;
	b=kJhcQAmqK5cpcyO9O+UmHns33ot68M04DtL1LIo0r3ARCVCQYEZEIfhv+cGenbzYx
	 b/cassYzBqOFeRCh5YewXdIZi2IM9ialMvKu0iR2VZTOYua9dstBDjl3BH30CKYJyn
	 9mAhEN72tvyA9SMLV6F4n0h9Qqfz1NxByp/E47cOID79cp+AH3hn0f4on4FKGIAHCI
	 YBF+Aubx/IuBWksJz0qA0+Rwp1k5oIGq66S4kKd7xPMOI1qWS3kw7QZtUyC/B2Qohm
	 YHI0QffkvLY7YwE+L0o0mI1lc0Tf+h7CrWUPHAWzCtEXO1euAT6uKeARLwUGBQwKas
	 6mIWZ4JGXdQuA==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.18-rc7
Date: Thu, 20 Nov 2025 08:47:17 -0800
Message-ID: <20251120164717.3974032-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

No known regressions or ongoing investigations.

The following changes since commit d0309c054362a235077327b46f727bc48878a3bc:

  Merge tag 'net-6.18-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-13 11:20:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.18-rc7

for you to fetch changes up to 002541ef650b742a198e4be363881439bb9d86b4:

  vsock: Ignore signal/timeout on connect() if already established (2025-11-20 07:40:06 -0800)

----------------------------------------------------------------
Including fixes from IPsec and wireless.

Previous releases - regressions:

 - prevent NULL deref in generic_hwtstamp_ioctl_lower(),
   newer APIs don't populate all the pointers in the request

 - phylink: add missing supported link modes for the fixed-link

 - mptcp: fix false positive warning in mptcp_pm_nl_rm_addr

Previous releases - always broken:

 - openvswitch: remove never-working support for setting NSH fields

 - xfrm: number of fixes for error paths of xfrm_state creation/
   modification/deletion

 - xfrm: fixes for offload
   - fix the determination of the protocol of the inner packet
   - don't push locally generated packets directly to L2 tunnel
     mode offloading, they still need processing from the standard
     xfrm path

 - mptcp: fix a couple of corner cases in fallback and fastclose
   handling

 - wifi: rtw89: hw_scan: prevent connections from getting stuck,
   work around apparent bug in FW by tweaking messages we send

 - af_unix: fix duplicate data if PEEK w/ peek_offset needs to wait

 - veth: more robust handing of race to avoid txq getting stuck

 - eth: ps3_gelic_net: handle skb allocation failures

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aleksei Nikiforov (1):
      s390/ctcm: Fix double-kfree

Andrey Vatoropin (1):
      be2net: pass wrb_params in case of OS2BMC

Baruch Siach (1):
      MAINTAINERS: Remove eth bridge website

Bitterblue Smith (1):
      wifi: rtw89: hw_scan: Don't let the operating channel be last

David Bauer (1):
      l2tp: reset skb control buffer on xmit

Emil Tantilov (1):
      idpf: fix possible vport_config NULL pointer deref in remove

Eric Dumazet (2):
      mptcp: fix race condition in mptcp_schedule_work()
      mptcp: fix a race in mptcp_pm_del_add_timer()

Florian Fuchs (1):
      net: ps3_gelic_net: handle skb allocation failures

Gang Yan (2):
      mptcp: fix address removal logic in mptcp_pm_nl_rm_addr
      selftests: mptcp: add a check for 'add_addr_accepted'

Grzegorz Nitka (1):
      ice: fix PTP cleanup on driver removal in error path

Ido Schimmel (1):
      selftests: net: lib: Do not overwrite error messages

Ilya Maximets (1):
      net: openvswitch: remove never-working support for setting nsh fields

Jakub Kicinski (4):
      Merge tag 'ipsec-2025-11-18' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge branch 'af_unix-fix-so_peek_off-bug-in-unix_stream_read_generic'
      Merge branch 'mptcp-misc-fixes-for-v6-18-rc7'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Jesper Dangaard Brouer (1):
      veth: more robust handing of race to avoid txq getting stuck

Jiaming Zhang (1):
      net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()

Jianbo Liu (3):
      xfrm: Check inner packet family directly from skb_dst
      xfrm: Determine inner GSO type from packet inner protocol
      xfrm: Prevent locally generated packets from direct output in tunnel mode

Johannes Berg (1):
      Merge tag 'rtw-2025-11-20' of https://github.com/pkshih/rtw

Kuniyuki Iwashima (2):
      af_unix: Read sk_peek_offset() again after sleeping in unix_stream_read_generic().
      selftest: af_unix: Add test for SO_PEEK_OFF.

Lorenzo Bianconi (1):
      net: airoha: Do not loopback traffic to GDM2 if it is available on the device

Matthieu Baerts (NGI0) (3):
      selftests: mptcp: join: fastclose: remove flaky marks
      selftests: mptcp: join: endpoints: longer timeout
      selftests: mptcp: join: userspace: longer timeout

Michal Luczaj (1):
      vsock: Ignore signal/timeout on connect() if already established

Oleksij Rempel (1):
      net: dsa: microchip: lan937x: Fix RGMII delay tuning

Paolo Abeni (7):
      mptcp: fix ack generation for fallback msk
      mptcp: avoid unneeded subflow-level drops
      mptcp: fix premature close in case of fallback
      mptcp: do not fallback when OoO is present
      mptcp: decouple mptcp fastclose from tcp close
      mptcp: fix duplicate reset on fastclose
      Merge tag 'wireless-2025-11-20' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Pavel Zhigulin (3):
      net: dsa: hellcreek: fix missing error handling in LED registration
      net: mlxsw: linecards: fix missing error check in mlxsw_linecard_devlink_info_get()
      net: qlogic/qede: fix potential out-of-bounds read in qede_tpa_cont() and qede_tpa_end()

Pradyumn Rahar (1):
      net/mlx5: Clean up only new IRQ glue on request_irq() failure

Sabrina Dubroca (6):
      xfrm: drop SA reference in xfrm_state_update if dir doesn't match
      xfrm: also call xfrm_state_delete_tunnel at destroy time for states that were never added
      xfrm: make state as DEAD before final put when migrate fails
      xfrm: call xfrm_dev_state_delete when xfrm_state_migrate fails to add the state
      xfrm: set err and extack on failure to create pcpu SA
      xfrm: check all hash buckets for leftover states during netns deletion

Shay Drory (1):
      devlink: rate: Unset parent pointer in devl_rate_nodes_destroy

Wei Fang (1):
      net: phylink: add missing supported link modes for the fixed-link

Zilin Guan (2):
      mlxsw: spectrum: Fix memory leak in mlxsw_sp_flower_stats()
      xfrm: fix memory leak in xfrm_add_acquire()

 MAINTAINERS                                        |   1 -
 drivers/net/dsa/hirschmann/hellcreek_ptp.c         |  14 +-
 drivers/net/dsa/microchip/lan937x_main.c           |   1 +
 drivers/net/ethernet/airoha/airoha_ppe.c           |   2 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   7 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  22 ++-
 drivers/net/ethernet/intel/idpf/idpf_main.c        |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   6 +-
 .../net/ethernet/mellanox/mlxsw/core_linecards.c   |   2 +
 .../net/ethernet/mellanox/mlxsw/spectrum_flower.c  |   6 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |   5 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c       |  45 ++++--
 drivers/net/ethernet/toshiba/ps3_gelic_net.h       |   1 +
 drivers/net/phy/phylink.c                          |   3 +
 drivers/net/veth.c                                 |  38 ++---
 drivers/net/wireless/realtek/rtw89/fw.c            |   7 +
 drivers/s390/net/ctcm_mpc.c                        |   1 -
 include/net/xfrm.h                                 |   3 +-
 net/core/dev_ioctl.c                               |   3 +
 net/devlink/rate.c                                 |   4 +-
 net/ipv4/esp4_offload.c                            |   6 +-
 net/ipv6/esp6_offload.c                            |   6 +-
 net/l2tp/l2tp_core.c                               |   6 +-
 net/mptcp/options.c                                |  54 ++++++-
 net/mptcp/pm.c                                     |  20 ++-
 net/mptcp/pm_kernel.c                              |   2 +-
 net/mptcp/protocol.c                               |  78 ++++++----
 net/mptcp/protocol.h                               |   3 +-
 net/openvswitch/actions.c                          |  68 +--------
 net/openvswitch/flow_netlink.c                     |  64 +-------
 net/openvswitch/flow_netlink.h                     |   2 -
 net/unix/af_unix.c                                 |   3 +-
 net/vmw_vsock/af_vsock.c                           |  40 +++--
 net/xfrm/xfrm_device.c                             |   2 +-
 net/xfrm/xfrm_output.c                             |   8 +-
 net/xfrm/xfrm_state.c                              |  30 +++-
 net/xfrm/xfrm_user.c                               |   8 +-
 tools/testing/selftests/net/.gitignore             |   1 +
 tools/testing/selftests/net/af_unix/Makefile       |   1 +
 tools/testing/selftests/net/af_unix/so_peek_off.c  | 162 +++++++++++++++++++++
 .../selftests/net/forwarding/lib_sh_test.sh        |   7 +
 tools/testing/selftests/net/lib.sh                 |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  27 ++--
 43 files changed, 521 insertions(+), 252 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/so_peek_off.c

