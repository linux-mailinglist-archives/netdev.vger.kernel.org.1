Return-Path: <netdev+bounces-199563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D85DAE0B76
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 18:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF439188A240
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F692701A1;
	Thu, 19 Jun 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlh+WopV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D011712;
	Thu, 19 Jun 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750351255; cv=none; b=LOIIjJP0FznlSWOhlC2aX/W50/SP+M3iR2ZCZR4IdxzWyWHmfNnuTWabSkopUgVw4CSJb3KLvSbG1qAxoohby8APzrcKdG+mPMWE+Fjb9lD7xsKDk5eaDZUGZ1aRueyiuC5qvPIFCrDp6Uqbm2bOXDHt+9f/9AEn/psGEDP8904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750351255; c=relaxed/simple;
	bh=e6/OaL4553yoEyEI1YQCgcFaAg/t7h53fVGP1TzAl6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=krcYhj/uoA0LXdACIxZbWfjPU57ALWv16wSKeR1beiTiaZTtpGIvgaYdn2aq3nkHcaFRrnVx+smjWy+rWUYHeC2GQW302+q8UTpvDnNw2jU5X2Rhb7s4g+AOFi/hNKCW32f1clsR2cZM80htCKZmJt+SixQ9N3ZlR/oaqAue20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlh+WopV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57FBC4CEEA;
	Thu, 19 Jun 2025 16:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750351255;
	bh=e6/OaL4553yoEyEI1YQCgcFaAg/t7h53fVGP1TzAl6E=;
	h=From:To:Cc:Subject:Date:From;
	b=dlh+WopVa62wWGt18+OQnKD2UqAtSZ0rh/eJwlAKvQZgKk9BzxactlLQpLUXMEn8z
	 yMHJpgjS1J1Lgt2A68ZzrAXGCmMjwuW+Q1V6cGA/0g7S4Cb+lRv4kSFkGigZW9thE6
	 smS6GTKA55s/6QMLAvVRClEEBhfV6wv3B1Id6pWIDTyMfZMPpqc87ced4ai8XX1uoP
	 i9stn9V95kO45P36szIbPhpMEXq45oLzlxE0X0VuxeJP+smguyp75tDLTEbuHy7WxN
	 DZg8lkrAE0VrOmnsebI+4/yNt85wEN5DrKtpus1djee4/232CggNIwgbSUAcvCqNVi
	 sA4MT1DZ6lNxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.16-rc3
Date: Thu, 19 Jun 2025 09:40:54 -0700
Message-ID: <20250619164054.1217396-1-kuba@kernel.org>
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

The following changes since commit 27605c8c0f69e319df156b471974e4e223035378:

  Merge tag 'net-6.16-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-12 09:50:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc3

for you to fetch changes up to 16ef63acb784bd0951a08c6feb108d19d9488800:

  Merge branch 'net-airoha-improve-hwfd-buffer-descriptor-queues-setup' (2025-06-19 08:42:27 -0700)

----------------------------------------------------------------
Including fixes from wireless. The ath12k fix to avoid FW crashes
requires adding support for a number of new FW commands so
it's quite large in terms of LoC. The rest is relatively small.

Current release - fix to a fix:

 - ptp: fix breakage after ptp_vclock_in_use() rework

Current release - regressions:

 - openvswitch: allocate struct ovs_pcpu_storage dynamically, static
   allocation may exhaust module loader limit on smaller systems

Previous releases - regressions:

 - tcp: fix tcp_packet_delayed() for peers with no selective ACK support

Previous releases - always broken:

 - wifi: ath12k: don't activate more links than firmware supports

 - tcp: make sure sockets open via passive TFO have valid NAPI ID

 - eth: bnxt_en: update MRU and RSS table of RSS contexts on queue reset,
   prevent Rx queues from silently hanging after queue reset

 - NFC: uart: set tty->disc_data only in success path

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexey Kodanev (1):
      net: lan743x: fix potential out-of-bounds write in lan743x_ptp_io_event_clock_get()

Baochen Qiang (10):
      wifi: ath12k: parse and save hardware mode info from WMI_SERVICE_READY_EXT_EVENTID event for later use
      wifi: ath12k: parse and save sbs_lower_band_end_freq from WMI_SERVICE_READY_EXT2_EVENTID event
      wifi: ath12k: update freq range for each hardware mode
      wifi: ath12k: support WMI_MLO_LINK_SET_ACTIVE_CMDID command
      wifi: ath12k: update link active in case two links fall on the same MAC
      wifi: ath12k: don't activate more links than firmware supports
      wifi: ath12k: fix documentation on firmware stats
      wifi: ath12k: avoid burning CPU while waiting for firmware stats
      wifi: ath12k: don't use static variables in ath12k_wmi_fw_stats_process()
      wifi: ath12k: don't wait when there is no vdev started

Bjorn Andersson (1):
      wifi: ath12k: Avoid CPU busy-wait by handling VDEV_STAT and BCN_STAT

Brett Creeley (1):
      ionic: Prevent driver/fw getting out of sync on devcmd(s)

Brett Werling (1):
      can: tcan4x5x: fix power regulator retrieval during probe

Colin Ian King (1):
      wifi: iwlwifi: Fix incorrect logic on cmd_ver range checking

David Thompson (1):
      mlxbf_gige: return EPROBE_DEFER if PHY IRQ is not available

David Wei (4):
      selftests: netdevsim: improve lib.sh include in peer.sh
      selftests: net: add passive TFO test binary
      selftests: net: add test for passive TFO socket NAPI ID
      tcp: fix passive TFO socket having invalid NAPI ID

Dmitry Antipov (1):
      wifi: carl9170: do not ping device which has failed to load firmware

Eric Dumazet (2):
      net: atm: add lec_mutex
      net: atm: fix /proc/net/atm/lec handling

Grzegorz Nitka (1):
      ice: fix eswitch code memory leak in reset scenario

Haixia Qu (1):
      tipc: fix null-ptr-deref when acquiring remote ip of ethernet bearer

Hariprasad Kelam (1):
      Octeontx2-pf: Fix Backpresure configuration

Heiner Kallweit (1):
      net: ftgmac100: select FIXED_PHY

Hyunwoo Kim (1):
      net/sched: fix use-after-free in taprio_dev_notifier

Jakub Kicinski (12):
      Merge tag 'linux-can-fixes-for-6.16-20250617' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'bnxt_en-bug-fixes'
      Merge branch 'ptp_vclock-fixes'
      Merge branch 'atm-fix-uninit-and-mem-accounting-leak-in-vcc_sendmsg'
      net: ethtool: remove duplicate defines for family info
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'net-fix-passive-tfo-socket-having-invalid-napi-id'
      eth: fbnic: avoid double free when failing to DMA-map FW msg
      Merge branch 'with-a-mutex'
      tools: ynl: fix mixing ops and notifications on one socket
      Merge tag 'wireless-2025-06-18' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'net-airoha-improve-hwfd-buffer-descriptor-queues-setup'

Johannes Berg (7):
      wifi: remove zero-length arrays
      wifi: mac80211: drop invalid source address OCB frames
      wifi: mac80211: don't WARN for late channel/color switch
      wifi: ath6kl: remove WARN on bad firmware input
      Merge tag 'ath-current-20250617' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: iwlwifi: dvm: restore n_no_reclaim_cmds setting
      Merge tag 'iwlwifi-fixes-2025-06-18' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Kalesh AP (1):
      bnxt_en: Fix double invocation of bnxt_ulp_stop()/bnxt_ulp_start()

Krishna Kumar (1):
      net: ice: Perform accurate aRFS flow match

Krzysztof Kozlowski (1):
      NFC: nci: uart: Set tty->disc_data only in success path

Kuniyuki Iwashima (4):
      mpls: Use rcu_dereference_rtnl() in mpls_route_input_rcu().
      atm: atmtcp: Free invalid length skb in atmtcp_c_send().
      atm: Revert atm_account_tx() if copy_from_iter_full() fails.
      calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().

Lorenzo Bianconi (3):
      net: airoha: Always check return value from airoha_ppe_foe_get_entry()
      net: airoha: Compute number of descriptors according to reserved memory size
      net: airoha: Differentiate hwfd buffer size for QDMA0 and QDMA1

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix packet handling for XDP_TX

Mina Almasry (1):
      net: netmem: fix skb_ensure_writable with unreadable skbs

Miri Korenblit (1):
      wifi: iwlwifi: restore missing initialization of async_handlers_list (again)

Neal Cardwell (1):
      tcp: fix tcp_packet_delayed() for tcp_is_non_sack_preventing_reopen() behavior

Pavan Chebbi (2):
      bnxt_en: Add a helper function to configure MRU and RSS
      bnxt_en: Update MRU and RSS table of RSS contexts on queue reset

Pei Xiao (1):
      wifi: iwlwifi: cfg: Limit cb_size to valid range

Sebastian Andrzej Siewior (1):
      openvswitch: Allocate struct ovs_pcpu_storage dynamically

Shannon Nelson (1):
      MAINTAINERS: Remove Shannon Nelson from MAINTAINERS file

Simon Horman (1):
      pldmfw: Select CRC32 when PLDMFW is selected

Vitaly Lifshits (1):
      e1000e: set fixed clock frequency indication for Nahum 11 and Nahum 13

Vladimir Oltean (2):
      ptp: fix breakage after ptp_vclock_in_use() rework
      ptp: allow reading of currently dialed frequency to succeed on free-running clocks

 .mailmap                                           |   7 +-
 Documentation/netlink/specs/ethtool.yaml           |   3 +
 MAINTAINERS                                        |   5 +-
 drivers/atm/atmtcp.c                               |   4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   9 +-
 drivers/net/ethernet/airoha/airoha_eth.c           |  27 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  87 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |  24 +-
 drivers/net/ethernet/faraday/Kconfig               |   1 +
 drivers/net/ethernet/intel/e1000e/netdev.c         |  14 +-
 drivers/net/ethernet/intel/e1000e/ptp.c            |   8 +-
 drivers/net/ethernet/intel/ice/ice_arfs.c          |  48 ++
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   4 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |   6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |   5 +-
 drivers/net/ethernet/microchip/lan743x_ptp.h       |   4 +-
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c       |  19 +-
 drivers/net/wireless/ath/ath12k/core.c             |   4 +-
 drivers/net/wireless/ath/ath12k/core.h             |  10 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |  58 --
 drivers/net/wireless/ath/ath12k/debugfs.h          |   7 -
 drivers/net/wireless/ath/ath12k/mac.c              | 394 +++++++++-
 drivers/net/wireless/ath/ath12k/mac.h              |   2 +
 drivers/net/wireless/ath/ath12k/wmi.c              | 829 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h              | 180 ++++-
 drivers/net/wireless/ath/ath6kl/bmi.c              |   4 +-
 drivers/net/wireless/ath/carl9170/usb.c            |  19 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   1 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |  11 +-
 drivers/ptp/ptp_clock.c                            |   3 +-
 drivers/ptp/ptp_private.h                          |  22 +-
 include/linux/atmdev.h                             |   6 +
 include/linux/ieee80211.h                          |  18 +-
 include/uapi/linux/ethtool_netlink.h               |   4 -
 include/uapi/linux/ethtool_netlink_generated.h     |   4 +-
 lib/Kconfig                                        |   1 +
 net/atm/common.c                                   |   1 +
 net/atm/lec.c                                      |  12 +-
 net/atm/raw.c                                      |   2 +-
 net/core/skbuff.c                                  |   3 -
 net/ipv4/tcp_fastopen.c                            |   3 +
 net/ipv4/tcp_input.c                               |  35 +-
 net/ipv6/calipso.c                                 |   8 +
 net/mac80211/debug.h                               |   5 +-
 net/mac80211/rx.c                                  |   4 +
 net/mac80211/tx.c                                  |  29 +-
 net/mpls/af_mpls.c                                 |   4 +-
 net/nfc/nci/uart.c                                 |   8 +-
 net/openvswitch/actions.c                          |  23 +-
 net/openvswitch/datapath.c                         |  42 +-
 net/openvswitch/datapath.h                         |   3 +-
 net/sched/sch_taprio.c                             |   6 +-
 net/tipc/udp_media.c                               |   4 +-
 tools/net/ynl/pyynl/lib/ynl.py                     |  28 +-
 .../selftests/drivers/net/netdevsim/peer.sh        |   3 +-
 tools/testing/selftests/net/.gitignore             |   1 +
 tools/testing/selftests/net/Makefile               |   2 +
 tools/testing/selftests/net/tfo.c                  | 171 +++++
 tools/testing/selftests/net/tfo_passive.sh         | 112 +++
 64 files changed, 2090 insertions(+), 287 deletions(-)
 create mode 100644 tools/testing/selftests/net/tfo.c
 create mode 100755 tools/testing/selftests/net/tfo_passive.sh

