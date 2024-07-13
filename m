Return-Path: <netdev+bounces-111178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8BC930300
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 03:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25071C21888
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B20D2FF;
	Sat, 13 Jul 2024 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNYcsn+E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBD2168A9;
	Sat, 13 Jul 2024 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833727; cv=none; b=iIAENMnm0QBYn3LUEOqEXtjjH5y+sLOmvdp1x/98tHHp9VjuK0KMW98CIh0oQ4Ryd1rA7o2SCBlX0Yj8aZ9HH+TiF9wHf7ndo+gWA8FBE+9KBMWQqAqCqt04lMgW6G0abIdOz2xAD8wEbDW21miSWCW8f97Z98fTNlLEjGOBz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833727; c=relaxed/simple;
	bh=ZplZcFQQhACVAehHShfXFFQ9wl/eljFn6N761AyGB3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u7V3Y3rPIupd0ILkdntQcl2IS51iAArIRqolDEZQ8NDp21EwCCTqs2s1Vqd2HmB89nGBMJCDdWCS4hDnFK0mLY+zSTQacU0Kregoc4g8dtVG/535Bpho+7jL+kQ3uB+G1NWoaBqNVG0Mc48u/xzFZQIztbRfGG2e4Y5+SEF/VRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNYcsn+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D74FC32782;
	Sat, 13 Jul 2024 01:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720833726;
	bh=ZplZcFQQhACVAehHShfXFFQ9wl/eljFn6N761AyGB3g=;
	h=From:To:Cc:Subject:Date:From;
	b=dNYcsn+ElWybb9Mc5w+T8YP6HuGeiabalkAPmQOP4SeOLaHk9mpp4Qc7EEVYicH08
	 /B5sAM0mdlZRqm5FL3vv3quAtKFJxez0kyxzAmpm9veVjb0b+kXPZj624wg8NVcIVG
	 t07S7hJsly8O2mttMvXz4C6vl+PCIkYGgPTzNsmdZM9C88nJdpv6rEgpOIjus43vYx
	 NEFIDx7KuuBSnIRk8z0hRyn2dVRAszxDOTNpOhNW3Gn/3SDgs5n2pyXiRQFIT3R1Gt
	 gFz3pYPbC4AKATE5649HBwEbLFDlRwxbmyLAYbLD0VzkIROaANXqxwYqz4ujdS1skw
	 89uVzUarPNGUg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.10-rc8 (follow up)
Date: Fri, 12 Jul 2024 18:22:05 -0700
Message-ID: <20240713012205.4143828-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

If you're planning to cut final on Friday please consider pulling
for the bnxt fix.

The following changes since commit 51df8e0cbaefd432f7029dde94e6c7e4e5b19465:

  Merge tag 'net-6.10-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-07-11 09:29:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc8-2

for you to fetch changes up to f7ce5eb2cb7993e4417642ac28713a063123461f:

  bnxt_en: Fix crash in bnxt_get_max_rss_ctx_ring() (2024-07-12 18:00:00 -0700)

----------------------------------------------------------------
A quick follow up to yesterday's PR. We got a regressions report for
the bnxt patch as soon as it got to your tree. The ethtool fix is also
good to have, although it's an older regression.

Current release - regressions:

 - eth: bnxt_en: fix crash in bnxt_get_max_rss_ctx_ring() on older HW
   when user tries to decrease the ring count

Previous releases - regressions:

 - ethtool: fix RSS setting, accept "no change" setting if the driver
   doesn't support the new features

 - eth: i40e: remove needless retries of NVM update, don't wait 20min
   when we know the firmware update won't succeed

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aleksandr Loktionov (1):
      i40e: fix: remove needless retries of NVM update

David S. Miller (1):
      Merge branch 'octeontx2-cpt-rss-cfg-fixes' into main

Kiran Kumar K (1):
      octeontx2-af: fix issue with IPv6 ext match for RSS

Michael Chan (1):
      bnxt_en: Fix crash in bnxt_get_max_rss_ctx_ring()

Michal Mazur (1):
      octeontx2-af: fix detection of IP layer

Nithin Dabilpuram (1):
      octeontx2-af: replace cpt slot with lf id on reg write

Saeed Mahameed (1):
      net: ethtool: Fix RSS setting

Satheesh Paul (1):
      octeontx2-af: fix issue with IPv4 match for RSS

Srujana Challa (1):
      octeontx2-af: fix a issue with cpt_lf_alloc mailbox

 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  3 +++
 drivers/net/ethernet/intel/i40e/i40e_adminq.h      |  4 ----
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |  8 ++++++--
 .../net/ethernet/marvell/octeontx2/af/rvu_cpt.c    | 23 +++++++++++++++-------
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    | 12 +++++++----
 net/ethtool/ioctl.c                                |  3 ++-
 7 files changed, 36 insertions(+), 19 deletions(-)

