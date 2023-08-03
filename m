Return-Path: <netdev+bounces-24085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E861376EB83
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32782811A5
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB96D1F95B;
	Thu,  3 Aug 2023 14:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9473D8E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 14:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57476C433C9;
	Thu,  3 Aug 2023 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691071258;
	bh=/foCZRvvss/yRAsl+5zHrD+NgMyBF8g5MMVUgnFuFzk=;
	h=From:Subject:To:Cc:Date:From;
	b=WQ+gDcd4l+uKiataaEKvh3VbEboegMLZcbemrMa1ewyc+wAvKHsVQD2XUB3c62XGg
	 EcCbp4y/yYGdz128x6xGsi/8lTyMreMZ+ZhOfxgBS6xVaMED10YE0kk93Dg/6OoyEV
	 Ds9ENWPY5RRfmXSQKTCcDMPgiEYq0AS5SJ81ww3UC3zblHzl1167+GSwhKVvU8bQRs
	 X9LQBGrOx837f2pmNluIpKbE37KDclscsy7o7iKTZgpZ3hhFDhkeOaXzzANtY9kByA
	 hpiiNjDsBR2ZgkUiV9RrpaYFIeGZH0wKrq9GMiB6ECgAFCY8hBCJgcwPh645cYuYIM
	 Ri+bKvs0JwAcw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2023-08-03
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20230803140058.57476C433C9@smtp.kernel.org>
Date: Thu,  3 Aug 2023 14:00:58 +0000 (UTC)

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit ac528649f7c63bc233cc0d33cff11f767cc666e3:

  Merge branch 'net-support-stp-on-bridge-in-non-root-netns' (2023-07-20 10:46:33 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2023-08-03

for you to fetch changes up to 16e455a465fca91907af0108f3d013150386df30:

  wifi: brcmfmac: Fix field-spanning write in brcmf_scan_params_v2_to_v1() (2023-08-02 13:34:16 +0300)

----------------------------------------------------------------
wireless fixes for v6.5

We did some house cleaning in MAINTAINERS file so several patches
about that. Few regressions fixed and also fix some recently enabled
memcpy() warnings. Only small commits and nothing special standing
out.

----------------------------------------------------------------
Brian Norris (1):
      MAINTAINERS: Update mwifiex maintainer list

Hans de Goede (1):
      wifi: brcmfmac: Fix field-spanning write in brcmf_scan_params_v2_to_v1()

Ilan Peer (1):
      wifi: cfg80211: Fix return value in scan logic

Kalle Valo (12):
      Revert "wifi: ath11k: Enable threaded NAPI"
      Revert "wifi: ath6k: silence false positive -Wno-dangling-pointer warning on GCC 12"
      MAINTAINERS: wifi: rtw88: change Ping as the maintainer
      MAINTAINERS: wifi: atmel: mark as orphan
      MAINTAINERS: wifi: mark cw1200 as orphan
      MAINTAINERS: wifi: mark ar5523 as orphan
      MAINTAINERS: wifi: mark rndis_wlan as orphan
      MAINTAINERS: wifi: mark wl3501 as orphan
      MAINTAINERS: wifi: mark zd1211rw as orphan
      MAINTAINERS: wifi: mark b43 as orphan
      MAINTAINERS: wifi: mark mlw8k as orphan
      MAINTAINERS: add Jeff as ath10k, ath11k and ath12k maintainer

Kees Cook (1):
      wifi: ray_cs: Replace 1-element array with flexible array

Paul Fertser (1):
      wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)

 MAINTAINERS                                        | 36 +++++++++-------------
 drivers/net/wireless/ath/ath11k/ahb.c              |  1 -
 drivers/net/wireless/ath/ath11k/pcic.c             |  1 -
 drivers/net/wireless/ath/ath6kl/Makefile           |  5 ---
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |  7 ++++-
 drivers/net/wireless/legacy/rayctl.h               |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c |  6 ++--
 net/wireless/scan.c                                |  2 +-
 8 files changed, 25 insertions(+), 35 deletions(-)

