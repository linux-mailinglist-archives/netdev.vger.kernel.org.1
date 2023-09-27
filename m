Return-Path: <netdev+bounces-36510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF6B7B0136
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 3E9641C20856
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DD1241F8;
	Wed, 27 Sep 2023 10:03:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C160533F1
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 10:03:43 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762BEF3;
	Wed, 27 Sep 2023 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=4pd2/n2780eiJB/dOK5SpuCHwElxjpXPNMC83G98Ob0=; t=1695809021; x=1697018621; 
	b=gQfhHEAXomVuxB6e+irlQeKb85cSt44kvK63AQXPMF8/0legt1Fg8+HYdZi8Flu5uSTgvpaPNQm
	4MgnVcoFx1NyQflJgfdqgby0DBHtLOxfhlC+5sC3zHsrUf+9LIq4c+dCBH3EqdOd3Quj0MYzwV4K+
	ALe+F4moCOBDAjEQW4WZm+2OSwTjhKgoEvqkQUuudBtKi/rA9VaKJVEU2fFhpMZgaTDz2IssMIuLN
	tbUSXhCwV2OIO119h53TAavJU4IUBK60aaGwADM3LOgMEDZuwb0labvzPOhJm4HLUa0DIhyvJjbax
	XuU0zo5GUJvtQU6t0NULeMs+VkQswu4tV/jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qlROM-007TqW-2D;
	Wed, 27 Sep 2023 12:03:38 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2023-09-27
Date: Wed, 27 Sep 2023 11:58:36 +0200
Message-ID: <20230927095835.25803-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Here's a first wireless fixes pull request for the 6.6 cycle.
There are quite a number of fixes here.

Note that this has conflicts with wireless-next, which I guess
then Stephen will report between net and wireless-next after
this is pulled, rather than between wireless and wireless-next.

I'm planning to merge wireless back into wireless-next once you
pull it into net (just to make sure we don't have to respin)
and resolve most of the conflicts, which will likely only leave
a fairly trivial conflict in a staging driver when pulling it
(wireless-next) into net-next, I can send that with a resolution
attached.

Please pull and let me know if there's any problem.

Thanks,
johannes



The following changes since commit bd6c11bc43c496cddfc6cf603b5d45365606dbd5:

  Merge tag 'net-next-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2023-08-29 11:33:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2023-09-27

for you to fetch changes up to 22061bfc57fe08c77141dc876b4af75603c4d61d:

  wifi: iwlwifi: mvm: Fix incorrect usage of scan API (2023-09-27 11:46:30 +0200)

----------------------------------------------------------------
Quite a collection of fixes this time, really too many
to list individually. Many stack fixes, even rfkill
(found by simulation and the new eevdf scheduler)!

Also a bigger maintainers file cleanup, to remove old
and redundant information.

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: cfg80211: validate AP phy operation before starting it

Arnd Bergmann (1):
      wifi: iwlwifi: dbg_ini: fix structure packing

Ben Greear (1):
      wifi: iwlwifi: Ensure ack flag is properly cleared.

Benjamin Berg (2):
      wifi: cfg80211: avoid leaking stack data into trace
      wifi: mac80211: Create resources for disabled links

Christophe JAILLET (1):
      wifi: iwlwifi: mvm: Fix a memory corruption issue

Felix Fietkau (2):
      wifi: mac80211: fix mesh id corruption on 32 bit systems
      wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

Gregory Greenman (1):
      iwlwifi: mvm: handle PS changes in vif_cfg_changed

Gustavo A. R. Silva (3):
      wifi: mwifiex: Fix tlv_buf_left calculation
      wifi: mwifiex: Replace one-element array with flexible-array member in struct mwifiex_ie_types_rxba_sync
      wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len

Ilan Peer (2):
      wifi: cfg80211: Fix 6GHz scan configuration
      wifi: iwlwifi: mvm: Fix incorrect usage of scan API

Jeff Johnson (1):
      MAINTAINERS: wifi: ath12k: add wiki link

Johannes Berg (6):
      wifi: cfg80211: fix cqm_config access race
      wifi: cfg80211: add missing kernel-doc for cqm_rssi_work
      rfkill: sync before userspace visibility/changes
      wifi: mac80211: fix potential key use-after-free
      wifi: mac80211: fix potential key leak
      wifi: mac80211: work around Cisco AP 9115 VHT MPDU length

Juerg Haefliger (1):
      wifi: brcmfmac: Replace 1-element arrays with flexible arrays

Kalle Valo (5):
      MAINTAINERS: wifi: remove generic wiki links from drivers
      MAINTAINERS: wifi: rtlwifi: remove git tree
      MAINTAINERS: wifi: rtl8xxxu: remove git tree
      MAINTAINERS: wifi: wl12xx: remove git tree
      MAINTAINERS: wifi: hostap: remove maintainer and web page

Lorenzo Bianconi (1):
      wifi: mt76: fix lock dependency problem for wed_lock

Pin-yen Lin (1):
      wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Sascha Hauer (1):
      wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM

Wen Gong (2):
      wifi: cfg80211/mac80211: hold link BSSes when assoc fails for MLO connection
      wifi: mac80211: allow transmitting EAPOL frames with tainted key

 MAINTAINERS                                        |  10 +-
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |   9 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  | 115 ++++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   3 +
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |  22 +++-
 drivers/net/wireless/marvell/mwifiex/fw.h          |   2 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  16 +--
 drivers/net/wireless/mediatek/mt76/dma.c           |   8 +-
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.c    |   7 --
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |  13 ++-
 drivers/net/wireless/realtek/rtw88/rtw8723d.h      |   1 +
 include/net/cfg80211.h                             |   6 +-
 net/mac80211/cfg.c                                 |   6 +-
 net/mac80211/ibss.c                                |   2 +-
 net/mac80211/ieee80211_i.h                         |   3 +-
 net/mac80211/key.c                                 |  22 ++--
 net/mac80211/mesh.c                                |   8 +-
 net/mac80211/mesh_plink.c                          |   2 +-
 net/mac80211/mlme.c                                |  45 ++++++--
 net/mac80211/tx.c                                  |   3 +-
 net/mac80211/vht.c                                 |  16 ++-
 net/rfkill/core.c                                  |  32 ++++--
 net/wireless/core.c                                |  14 +--
 net/wireless/core.h                                |   7 +-
 net/wireless/mlme.c                                |   3 +-
 net/wireless/nl80211.c                             | 116 +++++++++++++++------
 net/wireless/scan.c                                |   4 +
 30 files changed, 331 insertions(+), 174 deletions(-)


