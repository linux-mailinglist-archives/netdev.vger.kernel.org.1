Return-Path: <netdev+bounces-163913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9FEA2C02B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC70C16714C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FCD1DE3DB;
	Fri,  7 Feb 2025 10:05:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D21DDC20
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922713; cv=none; b=GVYf89xHL8FcLI/bRyHzW9l+cDiMdT8b6NHFEXVs1Xa2xNLpGHL7AkivKuyKH2rftJJJfaaojOUk/QboDhOhEA2pBGSJZfHDWG/+o9DaTljDwdcsurAH+Xh5sinpT7vQYSSdzIIYiwG2tHGOU58kRzpsQXwJPjOgh0HVE6wWZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922713; c=relaxed/simple;
	bh=ARQ2LPlewTvSq87iQ3DTr9iBM71o4EWfMdjoS6/jOxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QuRjOkpk2+eEgx5PkpGcaKJmw5jMYJfKdP+2WS3n42P5kAyfDs1vk1FhympkYC8Y4STZZLx4S5Ko8JFskcxtl5Rl6xQKF3Acvs74xtSgaOGAOIon/kHhB9UX3xYw/SuvjEzeI77PIEDAJePfmqRQgmp52xN3Wf5+hLwUbqXqhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C59725EFD8c202009b11b64500.dip0.t-ipconnect.de [IPv6:2003:c5:9725:efd8:c202:9b:11b6:4500])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id EBBB8FA132;
	Fri,  7 Feb 2025 10:58:28 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/4] pull request for net: batman-adv 2025-02-07
Date: Fri,  7 Feb 2025 10:58:19 +0100
Message-Id: <20250207095823.26043-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub,

here are a few bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit fff8f17c1a6fc802ca23bbd3a276abfde8cc58e6:

  batman-adv: Do not let TT changes list grows indefinitely (2024-12-05 22:38:26 +0100)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250207

for you to fetch changes up to f4c9c2cc827d803159730b1da813a0c595969831:

  batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1() (2025-01-28 22:06:56 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - Fix panic during interface removal in BATMAN V, by Andy Strohman

 - Cleanup BATMAN V/ELP metric handling, by Sven Eckelmann (2 patches)

 - Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1(),
   by Remi Pommarel

----------------------------------------------------------------
Andy Strohman (1):
      batman-adv: fix panic during interface removal

Remi Pommarel (1):
      batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1()

Sven Eckelmann (2):
      batman-adv: Ignore neighbor throughput metrics in error case
      batman-adv: Drop unmanaged ELP metric worker

 net/batman-adv/bat_v.c             |   2 -
 net/batman-adv/bat_v_elp.c         | 122 ++++++++++++++++++++++++++-----------
 net/batman-adv/bat_v_elp.h         |   2 -
 net/batman-adv/translation-table.c |  12 ++--
 net/batman-adv/types.h             |   3 -
 5 files changed, 91 insertions(+), 50 deletions(-)

