Return-Path: <netdev+bounces-155046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81865A00C97
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 18:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54931884951
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C31FBE80;
	Fri,  3 Jan 2025 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng7rSTTZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9441FBCBC;
	Fri,  3 Jan 2025 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735924553; cv=none; b=hdqHCU6gQdmfWQVpoLxfGFWwkN8Z3OB+JjKzHQ90P7dKbeRkfbDBA1H/VoK9/VvkF75AUqbwsbwh+YnK016dCY5YHwnhViTrzkacrIN73Gki+Qpg9FDfW/8SPyk5G1noG5wRcbF58+YoEf7Q26hpYLSdJtw9HPpNLqLI2lqMCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735924553; c=relaxed/simple;
	bh=1xaZ/HoKwNxkYbBELe1SwciNzC6LqSOWXHUeDPaQihw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iRKzl3p+RqVpnAsOysQ7C3gnOI6/b/3q6ECII4kw6HCR+xHLwwxYL91NbhsWhbTgkRVyxdhDsdOy6ELZonI/17Fet5d0bf0zehdU2fIXWjW7NsgXuH+kZtlwC0xc+KKdl4BErhXEzv8NDDt1rCy20a0hg41z/fADnADnIwMbg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng7rSTTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BE0C4CECE;
	Fri,  3 Jan 2025 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735924552;
	bh=1xaZ/HoKwNxkYbBELe1SwciNzC6LqSOWXHUeDPaQihw=;
	h=From:To:Cc:Subject:Date:From;
	b=Ng7rSTTZUDc7LK0Mv8+oEMehXAX3Yv6kUKJOysSCy6LcREwpwKkwPITivv/5bPsXj
	 T5LmV1fHi3R6FSmdh+pfQLO6XTCt530b7OWfydiKuqSHJPJYU534MI047F0VPCopEf
	 4PDXISMJH9VPh7jrjlJGFM1CAJ+uIPkLcZUy73C+bts3ivBZpnqycVlXjhScWuG+92
	 sHJmdbSehxIvGmhgvNGMdkrA7pdiXv/40p0wgh9TD4XLw6PlKdGTqnvxeLZB7lwVCh
	 GPuKuCYb68RZpQMPM+Dv3mIrfQCO1Ifux3FJczt0C8Px+PfTfu1VzqFMaVYQdhgwbO
	 H2vPXDfNDS/ag==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.13-rc6
Date: Fri,  3 Jan 2025 09:15:51 -0800
Message-ID: <20250103171551.2999961-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

Happy New Year!

The following changes since commit 8faabc041a001140564f718dabe37753e88b37fa:

  Merge tag 'net-6.13-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-12-19 09:19:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc6

for you to fetch changes up to ce21419b55d8671b886ae780ef15734843a6f668:

  Merge branch 'net-iep-clock-module-fixes' (2025-01-03 11:54:06 +0000)

----------------------------------------------------------------
Nothing major here. Over the last two weeks we gathered only around
two-thirds of our normal weekly fix count, but delaying sending these
until -rc7 seemed like a really bad idea.

AFAIK we have no bugs under investigation. One or two reverts for
stuff for which we haven't gotten a proper fix will likely come in
the next PR.

Including fixes from wireles and netfilter.

Current release - fix to a fix:

 - netfilter: nft_set_hash: unaligned atomic read on struct nft_set_ext

 - eth: gve: trigger RX NAPI instead of TX NAPI in gve_xsk_wakeup

Previous releases - regressions:

 - net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets

 - mptcp:
   - fix sleeping rcvmsg sleeping forever after bad recvbuffer adjust
   - fix TCP options overflow
   - prevent excessive coalescing on receive, fix throughput

 - net: fix memory leak in tcp_conn_request() if map insertion fails

 - wifi: cw1200: fix potential NULL dereference after conversion
   to GPIO descriptors

 - phy: micrel: dynamically control external clock of KSZ PHY,
   fix suspend behavior

Previous releases - always broken:

 - af_packet: fix VLAN handling with MSG_PEEK

 - net: restrict SO_REUSEPORT to inet sockets

 - netdev-genl: avoid empty messages in NAPI get

 - dsa: microchip: fix set_ageing_time function on KSZ9477 and LAN937X

 - eth: gve: XDP fixes around transmit, queue wakeup etc.

 - eth: ti: icssg-prueth: fix firmware load sequence to prevent time
   jump which breaks timesync related operations

Misc:

 - netlink: specs: mptcp: add missing attr and improve documentation

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Antonio Pastor (1):
      net: llc: reset skb->transport_header

David S. Miller (2):
      Merge branch 'gve-xdp-fixes'
      Merge branch 'net-iep-clock-module-fixes'

Dragos Tatulea (1):
      net/mlx5e: macsec: Maintain TX SA from encoding_sa

Emmanuel Grumbach (1):
      wifi: iwlwifi: fix CRF name for Bz

Eric Dumazet (4):
      net: restrict SO_REUSEPORT to inet sockets
      af_packet: fix vlan_get_tci() vs MSG_PEEK
      af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK
      ila: serialize calls to nf_register_net_hooks()

Ilya Shchipletsov (1):
      netrom: check buffer length before accessing it

Jakub Kicinski (8):
      Merge branch 'net-dsa-microchip-fix-set_ageing_time-function-for-ksz9477-and-lan937x-switches'
      Merge tag 'wireless-2024-12-19' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      netdev-genl: avoid empty messages in napi get
      selftests: drv-net: test empty queue and NAPI responses in netlink
      Merge branch 'mlx5-misc-fixes-2024-12-20'
      Merge branch 'netlink-specs-mptcp-fixes-for-some-descriptions'
      Merge tag 'nf-24-12-25' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'mptcp-rx-path-fixes'

Jeff Johnson (1):
      MAINTAINERS: wifi: ath: add Jeff Johnson as maintainer

Jianbo Liu (2):
      net/mlx5e: Skip restore TC rules for vport rep without loaded flag
      net/mlx5e: Keep netdev when leave switchdev for devlink set legacy only

Jinjian Song (1):
      net: wwan: t7xx: Fix FSM command timeout issue

Joe Hattori (2):
      net: stmmac: restructure the error path of stmmac_probe_config_dt()
      net: mv643xx_eth: fix an OF node reference leak

Joshua Washington (6):
      gve: clean XDP queues in gve_tx_stop_ring_gqi
      gve: guard XDP xmit NDO on existence of xdp queues
      gve: guard XSK operations on the existence of queues
      gve: process XSK TX descriptors as part of RX NAPI
      gve: fix XDP allocation path in edge cases
      gve: trigger RX NAPI instead of TX NAPI in gve_xsk_wakeup

Kees Cook (1):
      wifi: iwlwifi: mvm: Fix __counted_by usage in cfg80211_wowlan_nd_*

Kory Maincent (1):
      net: pse-pd: tps23881: Fix power on/off issue

Liang Jie (1):
      net: sfc: Correct key_len for efx_tc_ct_zone_ht_params

Linus Walleij (1):
      wifi: cw1200: Fix potential NULL dereference

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix firmware load sequence.

Maciej S. Szmigiero (1):
      net: wwan: iosm: Properly check for valid exec stage in ipc_mmio_init()

Matthieu Baerts (NGI0) (3):
      netlink: specs: mptcp: add missing 'server-side' attr
      netlink: specs: mptcp: clearly mention attributes
      netlink: specs: mptcp: fix missing doc

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during iep_init

Mohsin Bashir (1):
      eth: fbnic: fix csr boundary for RPM RAM section

Nikolay Kuratov (1):
      net/sctp: Prevent autoclose integer overflow in sctp_association_init()

Pablo Neira Ayuso (1):
      netfilter: nft_set_hash: unaligned atomic read on struct nft_set_ext

Paolo Abeni (4):
      mptcp: fix TCP options overflow.
      mptcp: fix recvbuffer adjust on sleeping rcvmsg
      mptcp: don't always assume copied data in mptcp_cleanup_rbuf()
      mptcp: prevent excessive coalescing on receive

Pascal Hambourg (1):
      sky2: Add device ID 11ab:4373 for Marvell 88E8075

Shahar Shitrit (1):
      net/mlx5: DR, select MSIX vector 0 for completion queue creation

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw: default to round-robin for host port receive

Tristram Ha (2):
      net: dsa: microchip: Fix KSZ9477 set_ageing_time function
      net: dsa: microchip: Fix LAN937X set_ageing_time function

Vitalii Mordan (1):
      eth: bcmsysport: fix call balance of priv->clk handling routines

Vladimir Oltean (1):
      selftests: net: local_termination: require mausezahn

Wang Liang (1):
      net: fix memory leak in tcp_conn_request()

Wei Fang (1):
      net: phy: micrel: Dynamically control external clock of KSZ PHY

Willem de Bruijn (1):
      net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets

Xiao Liang (1):
      net: Fix netns for ip_tunnel_init_flow()

 Documentation/netlink/specs/mptcp_pm.yaml          |  60 ++---
 MAINTAINERS                                        |   1 +
 drivers/net/dsa/microchip/ksz9477.c                |  47 +++-
 drivers/net/dsa/microchip/ksz9477_reg.h            |   4 +-
 drivers/net/dsa/microchip/lan937x_main.c           |  62 ++++-
 drivers/net/dsa/microchip/lan937x_reg.h            |   9 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |  21 +-
 drivers/net/ethernet/google/gve/gve.h              |   1 +
 drivers/net/ethernet/google/gve/gve_main.c         |  63 +++--
 drivers/net/ethernet/google/gve/gve_tx.c           |  46 ++--
 drivers/net/ethernet/marvell/mv643xx_eth.c         |  14 +-
 drivers/net/ethernet/marvell/sky2.c                |   1 +
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  19 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  15 ++
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   3 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   5 +-
 .../mellanox/mlx5/core/steering/sws/dr_send.c      |   4 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    |   3 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.c        |   2 +-
 drivers/net/ethernet/sfc/tc_conntrack.c            |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  43 ++--
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   2 +-
 drivers/net/ethernet/ti/icssg/icss_iep.c           |   8 +
 drivers/net/ethernet/ti/icssg/icssg_common.c       |  25 --
 drivers/net/ethernet/ti/icssg/icssg_config.c       |  41 ++-
 drivers/net/ethernet/ti/icssg/icssg_config.h       |   1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       | 281 ++++++++++++++-------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |   5 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   |  24 +-
 drivers/net/phy/micrel.c                           | 114 ++++++++-
 drivers/net/pse-pd/tps23881.c                      |  16 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  14 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  41 ++-
 drivers/net/wireless/st/cw1200/cw1200_spi.c        |   2 +-
 drivers/net/wwan/iosm/iosm_ipc_mmio.c              |   2 +-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c         |  26 +-
 drivers/net/wwan/t7xx/t7xx_state_monitor.h         |   5 +-
 include/linux/if_vlan.h                            |  16 +-
 include/linux/mlx5/driver.h                        |   1 +
 include/net/netfilter/nf_tables.h                  |   7 +-
 include/uapi/linux/mptcp_pm.h                      |  50 ++--
 net/core/dev.c                                     |   4 +-
 net/core/netdev-genl.c                             |   6 +-
 net/core/sock.c                                    |   5 +-
 net/ipv4/ip_tunnel.c                               |   6 +-
 net/ipv4/tcp_input.c                               |   1 +
 net/ipv6/ila/ila_xlat.c                            |  16 +-
 net/llc/llc_input.c                                |   2 +-
 net/mptcp/options.c                                |   7 +
 net/mptcp/protocol.c                               |  23 +-
 net/netrom/nr_route.c                              |   6 +
 net/packet/af_packet.c                             |  28 +-
 net/sctp/associola.c                               |   3 +-
 tools/testing/selftests/drivers/net/queues.py      |  28 +-
 .../selftests/net/forwarding/local_termination.sh  |   1 -
 59 files changed, 861 insertions(+), 393 deletions(-)

