Return-Path: <netdev+bounces-161683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276C7A23483
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 20:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C41F1883FEA
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02F61F1532;
	Thu, 30 Jan 2025 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8mYwcv6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59071F0E23;
	Thu, 30 Jan 2025 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738264087; cv=none; b=g6LPWaF3z7iUZ6GDICk3tEePBNK0PdXGy24oI0x3itWbiQ62x/Xy2MZapqFT4nsg9pJ8pPFlCFuvmZBWnuhVyLUcmSaVhIzgqzidNDRJiyXqof4f8HiXN7zY6mPTGzVb7OJjd/0uXRtMfk8diT8n3vy5CIVHOvzQIU+Hu68VNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738264087; c=relaxed/simple;
	bh=U8YNvQ4vRtEyVzAT37cdv5Yl9B+ZaWpy+qr5C/+ZuwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=trl6Xn7VnsBXfUfDaNCemRvRzNm88QrYF4qNOpuNeckSMB10ASzFBQGIakAenF+O3XHY2zWKFpjgIVCjqUx7jk+Vo4kPANzYR4zEHHaDsgZHADGKMym8a7G0x12vOSUiAvMoLNaoYQEy5KzCgAqUvZyBm5Pdb3zuXwTAq5Y5Sks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8mYwcv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D502FC4CED2;
	Thu, 30 Jan 2025 19:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738264087;
	bh=U8YNvQ4vRtEyVzAT37cdv5Yl9B+ZaWpy+qr5C/+ZuwU=;
	h=From:To:Cc:Subject:Date:From;
	b=L8mYwcv65uUrY3MjjMAJ0/UvnX+YF/YgzZFLGs0TJwAKNSflfz4gdNABEyLFb513r
	 NefVeRw2lEJvDRJYl3K5vB0Y1v4Au2jQeK/HYVMmPe94MYhHlBExQi+802QbEfiE1a
	 nJpM/iqZrNiKmZSl8Pf6jcvuKv2uPS0W9TshgA+17rD5H+wJ0ifga8s7JiriL0jTNH
	 o9Bzzt7bXin+HbjdTGya9oRKx2J0puieiLio78Er3E2SY1A7alNkLlX4RC29PYng6v
	 bAmJ37D9OwcalxrDDfhPBW5j0JDtNLTz37TWVV72UAiea4mpENL+foqoRDLbOSbklh
	 MPqZMnlxRi3gg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.14-rc1
Date: Thu, 30 Jan 2025 11:08:06 -0800
Message-ID: <20250130190806.3217841-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 0ad9617c78acbc71373fb341a6f75d4012b01d69:

  Merge tag 'net-next-6.14' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-01-22 08:28:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.14-rc1

for you to fetch changes up to dfffaccffc53642b532c9942ade3535f25a8a8fb:

  Merge tag 'nf-25-01-30' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2025-01-30 09:01:00 -0800)

----------------------------------------------------------------
First batch of fixes for 6.14. Nothing really stands out,
but as usual there's a slight concentration of fixes for issues
added in the last two weeks before the MW, and driver bugs
from 6.13 which tend to get discovered upon wider distribution.

Including fixes from IPSec, netfilter and Bluetooth.

Current release - regressions:

 - net: revert RTNL changes in unregister_netdevice_many_notify()

 - Bluetooth: fix possible infinite recursion of btusb_reset

 - eth: adjust locking in some old drivers which protect their state
	with spinlocks to avoid sleeping in atomic; core protects
	netdev state with a mutex now

Previous releases - regressions:

 - eth: mlx5e: make sure we pass node ID, not CPU ID to kvzalloc_node()

 - eth: bgmac: reduce max frame size to support just 1500 bytes;
	the jumbo frame support would previously cause OOB writes,
	but now fails outright

 - mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted,
	avoid false detection of MPTCP blackholing

Previous releases - always broken:

 - mptcp: handle fastopen disconnect correctly

 - xfrm: make sure skb->sk is a full sock before accessing its fields

 - xfrm: fix taking a lock with preempt disabled for RT kernels

 - usb: ipheth: improve safety of packet metadata parsing; prevent
	potential OOB accesses

 - eth: renesas: fix missing rtnl lock in suspend/resume path

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexandre Cassen (1):
      xfrm: delete intermediate secpath entry in packet offload mode

Chenyuan Yang (1):
      net: davicom: fix UAF in dm9000_drv_remove

Christian Marangi (1):
      net: airoha: Fix wrong GDM4 register definition

Cosmin Ratiu (1):
      bonding: Correctly support GSO ESP offload

Dan Carpenter (1):
      NFC: nci: Add bounds checking in nci_hci_create_pipe()

David Howells (1):
      rxrpc, afs: Fix peer hash locking vs RCU callback

Dheeraj Reddy Jonnalagadda (1):
      net: fec: implement TSO descriptor cleanup

Dimitri Fedrau (1):
      net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios

Douglas Anderson (1):
      Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()

Emil Tantilov (2):
      idpf: add read memory barrier when checking descriptor done bit
      idpf: fix transaction timeouts on reset

Eric Dumazet (4):
      ipmr: do not call mr_mfc_uses_dev() for unres entries
      net: rose: fix timer races against user threads
      net: hsr: fix fill_frame_info() regression vs VLAN packets
      net: revert RTNL changes in unregister_netdevice_many_notify()

Fedor Pchelkin (1):
      Bluetooth: L2CAP: accept zero as a special value for MTU auto-selection

Florian Westphal (1):
      xfrm: state: fix out-of-bounds read during lookup

Foster Snowhill (7):
      usbnet: ipheth: fix possible overflow in DPE length check
      usbnet: ipheth: check that DPE points past NCM header
      usbnet: ipheth: use static NDP16 location in URB
      usbnet: ipheth: refactor NCM datagram loop
      usbnet: ipheth: break up NCM header size computation
      usbnet: ipheth: fix DPE OoB read
      usbnet: ipheth: document scope of NCM implementation

Gal Pressman (1):
      ethtool: Fix set RXNFC command with symmetric RSS hash

Harshit Mogalapalli (1):
      net: mvneta: fix locking in mvneta_cpu_online()

Hsin-chen Chuang (2):
      Bluetooth: Fix possible infinite recursion of btusb_reset
      Bluetooth: Add ABI doc for sysfs reset

Jakub Kicinski (20):
      selftests/net: packetdrill: more xfail changes (and a correction)
      net: netdevsim: try to close UDP port harness races
      tools: ynl: c: correct reverse decode of empty attrs
      eth: tg3: fix calling napi_enable() in atomic context
      eth: forcedeth: remove local wrappers for napi enable/disable
      eth: forcedeth: fix calling napi_enable() in atomic context
      eth: 8139too: fix calling napi_enable() in atomic context
      eth: niu: fix calling napi_enable() in atomic context
      eth: via-rhine: fix calling napi_enable() in atomic context
      wifi: mt76: move napi_enable() from under BH
      Merge branch 'eth-fix-calling-napi_enable-in-atomic-context'
      MAINTAINERS: add Paul Fertser as a NC-SI reviewer
      netdevsim: don't assume core pre-populates HDS params on GET
      net: page_pool: don't try to stash the napi id
      Merge branch 'mptcp-fixes-addressing-syzbot-reports'
      Merge tag 'ipsec-2025-01-27' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'vsock-transport-reassignment-and-error-handling-issues'
      MAINTAINERS: add Neal to TCP maintainers
      Merge tag 'nf-25-01-30' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Jamal Hadi Salim (1):
      net: sched: fix ets qdisc OOB Indexing

Jan Stancek (2):
      selftests: mptcp: extend CFLAGS to keep options from environment
      selftests: net/{lib,openvswitch}: extend CFLAGS to keep options from environment

Jian Shen (1):
      net: hns3: fix oops when unload drivers paralleling

Jianbo Liu (1):
      xfrm: replay: Fix the update of replay_esn->oseq_hi for GSO

Jon Maloy (1):
      tcp: correct handling of extreme memory squeeze

Khaled Elnaggar (1):
      documentation: networking: fix spelling mistakes

Kory Maincent (2):
      net: ravb: Fix missing rtnl lock in suspend/resume path
      net: sh_eth: Fix missing rtnl lock in suspend/resume path

Kunihiko Hayashi (3):
      net: stmmac: Limit the number of MTL queues to hardware capability
      net: stmmac: Limit FIFO size by hardware capability
      net: stmmac: Specify hardware capability value when FIFO size isn't specified

Manoj Vishwanathan (2):
      idpf: Acquire the lock before accessing the xn->salt
      idpf: add more info during virtchnl transaction timeout/salt mismatch

Marco Leogrande (1):
      idpf: convert workqueues to unbound

Mateusz Polchlopek (1):
      ice: remove invalid parameter of equalizer

Matthieu Baerts (NGI0) (3):
      mptcp: pm: only set fullmesh for subflow endp
      mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted
      doc: mptcp: sysctl: blackhole_timeout is per-netns

Michal Luczaj (6):
      vsock: Keep the binding until socket destruction
      vsock: Allow retrying on connect() failure
      vsock/test: Introduce vsock_bind()
      vsock/test: Introduce vsock_connect_fd()
      vsock/test: Add test for UAF due to socket unbinding
      vsock/test: Add test for connect() retries

Michal Swiatkowski (1):
      iavf: allow changing VLAN state without calling PF

Milos Reljin (1):
      net: phy: c45-tjaxx: add delay between MDIO write and read in soft_reset

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix glitches seen in dual A2DP streaming

Nikita Zhandarovich (1):
      net: usb: rtl8150: enable basic endpoint checking

Pablo Neira Ayuso (1):
      netfilter: nf_tables: reject mismatching sum of field_len with set key length

Paolo Abeni (7):
      mptcp: consolidate suboption status
      mptcp: handle fastopen disconnect correctly
      Merge branch 'usbnet-ipheth-prevent-oob-reads-of-ndp16'
      Merge branch 'limit-devicetree-parameters-to-hardware-capability'
      Merge tag 'for-net-2025-01-29' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'fix-missing-rtnl-lock-in-suspend-path'
      Merge branch 'mptcp-blackhole-only-if-1st-syn-retrans-w-o-mpc-is-accepted'

Paul Fertser (2):
      net/ncsi: wait for the last response to Deselect Package before configuring channel
      net/ncsi: use dev_set_mac_address() for Get MC MAC Address handling

Przemek Kitszel (1):
      ice: fix ice_parser_rt::bst_key array size

Rafał Miłecki (1):
      bgmac: reduce max frame size to support just MTU 1500

Sebastian Sewior (1):
      xfrm: Don't disable preemption while looking up cache state.

Shigeru Yoshida (1):
      vxlan: Fix uninit-value in vxlan_vnifilter_dump()

Stanislav Fomichev (1):
      net/mlx5e: add missing cpu_to_node to kvzalloc_node in mlx5e_open_xdpredirect_sq

Steffen Klassert (1):
      xfrm: Fix the usage of skb->sk

Thomas Weißschuh (2):
      ptp: Ensure info->enable callback is always set
      ptp: Properly handle compat ioctls

Toke Høiland-Jørgensen (2):
      net: xdp: Disallow attaching device-bound programs in generic mode
      selftests/net: Add test for loading devbound XDP program in generic mode

Yijie Yang (1):
      dt-bindings: net: qcom,ethqos: Correct fallback compatible for qcom,qcs615-ethqos

谢致邦 (XIE Zhibang) (1):
      net: the appletalk subsystem no longer uses ndo_do_ioctl

 Documentation/ABI/stable/sysfs-class-bluetooth     |   9 ++
 .../devicetree/bindings/net/qcom,ethqos.yaml       |   8 +-
 Documentation/networking/can.rst                   |   4 +-
 Documentation/networking/mptcp-sysctl.rst          |   2 +-
 Documentation/networking/napi.rst                  |   2 +-
 MAINTAINERS                                        |   3 +
 drivers/bluetooth/btnxpuart.c                      |   3 +-
 drivers/bluetooth/btusb.c                          |  12 +-
 drivers/net/bonding/bond_main.c                    |  19 ++--
 drivers/net/ethernet/broadcom/bgmac.h              |   3 +-
 drivers/net/ethernet/broadcom/tg3.c                |  35 +++++-
 drivers/net/ethernet/davicom/dm9000.c              |   3 +-
 drivers/net/ethernet/freescale/fec_main.c          |  31 +++++-
 drivers/net/ethernet/hisilicon/hns3/hnae3.c        |  15 +++
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   2 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   2 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   2 +
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  19 +++-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.h       |   1 -
 drivers/net/ethernet/intel/ice/ice_parser.h        |   6 +-
 drivers/net/ethernet/intel/ice/ice_parser_rt.c     |  12 +-
 drivers/net/ethernet/intel/idpf/idpf_controlq.c    |   6 +
 drivers/net/ethernet/intel/idpf/idpf_main.c        |  15 ++-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |  25 ++++-
 drivers/net/ethernet/marvell/mvneta.c              |   1 +
 drivers/net/ethernet/mediatek/airoha_eth.c         |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   2 +-
 drivers/net/ethernet/nvidia/forcedeth.c            |  32 ++----
 drivers/net/ethernet/realtek/8139too.c             |   4 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  22 ++--
 drivers/net/ethernet/renesas/sh_eth.c              |   4 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  57 +++++++---
 drivers/net/ethernet/sun/niu.c                     |  10 +-
 drivers/net/ethernet/via/via-rhine.c               |  11 +-
 drivers/net/netdevsim/ethtool.c                    |   2 +-
 drivers/net/netdevsim/netdevsim.h                  |   1 +
 drivers/net/netdevsim/udp_tunnels.c                |  23 ++--
 drivers/net/phy/marvell-88q2xxx.c                  |  33 ++++--
 drivers/net/phy/nxp-c45-tja11xx.c                  |   2 +
 drivers/net/usb/ipheth.c                           |  69 ++++++++----
 drivers/net/usb/rtl8150.c                          |  22 ++++
 drivers/net/vxlan/vxlan_vnifilter.c                |   5 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c    |   8 +-
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c    |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c    |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |  17 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   7 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |   7 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  12 +-
 drivers/ptp/ptp_chardev.c                          |   4 +
 drivers/ptp/ptp_clock.c                            |   8 ++
 include/linux/netdevice.h                          |   4 +-
 include/net/page_pool/types.h                      |   1 -
 include/net/xfrm.h                                 |  16 ++-
 net/bluetooth/l2cap_sock.c                         |   4 +-
 net/core/dev.c                                     |  39 ++-----
 net/core/page_pool.c                               |   2 +
 net/core/page_pool_priv.h                          |   2 +
 net/core/page_pool_user.c                          |  15 ++-
 net/ethtool/ioctl.c                                |   2 +-
 net/hsr/hsr_forward.c                              |   7 +-
 net/ipv4/esp4.c                                    |   2 +-
 net/ipv4/ipmr_base.c                               |   3 -
 net/ipv4/tcp_output.c                              |   9 +-
 net/ipv6/esp6.c                                    |   2 +-
 net/ipv6/xfrm6_output.c                            |   4 +-
 net/mptcp/ctrl.c                                   |   4 +-
 net/mptcp/options.c                                |  13 +--
 net/mptcp/pm_netlink.c                             |   3 +-
 net/mptcp/protocol.c                               |   4 +-
 net/mptcp/protocol.h                               |  30 ++---
 net/ncsi/ncsi-manage.c                             |  13 ++-
 net/ncsi/ncsi-rsp.c                                |  18 ++-
 net/netfilter/nf_tables_api.c                      |   8 +-
 net/nfc/nci/hci.c                                  |   2 +
 net/rose/rose_timer.c                              |  15 +++
 net/rxrpc/peer_event.c                             |  16 +--
 net/rxrpc/peer_object.c                            |  12 +-
 net/sched/sch_ets.c                                |   2 +
 net/vmw_vsock/af_vsock.c                           |  13 ++-
 net/xfrm/xfrm_interface_core.c                     |   2 +-
 net/xfrm/xfrm_output.c                             |   7 +-
 net/xfrm/xfrm_policy.c                             |   2 +-
 net/xfrm/xfrm_replay.c                             |  10 +-
 net/xfrm/xfrm_state.c                              |  93 ++++++++++++----
 tools/net/ynl/lib/ynl.c                            |   2 +-
 .../drivers/net/netdevsim/udp_tunnel_nic.sh        |  16 +--
 tools/testing/selftests/net/bpf_offload.py         |  14 ++-
 tools/testing/selftests/net/lib/Makefile           |   2 +-
 tools/testing/selftests/net/mptcp/Makefile         |   2 +-
 tools/testing/selftests/net/openvswitch/Makefile   |   2 +-
 .../selftests/net/packetdrill/ksft_runner.sh       |   4 +-
 tools/testing/vsock/util.c                         |  88 ++++++---------
 tools/testing/vsock/util.h                         |   2 +
 tools/testing/vsock/vsock_test.c                   | 122 ++++++++++++++++++---
 103 files changed, 877 insertions(+), 420 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-class-bluetooth

