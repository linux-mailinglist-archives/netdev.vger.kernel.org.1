Return-Path: <netdev+bounces-189162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EF0AB0E45
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDF417BA4D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102FD2749EA;
	Fri,  9 May 2025 09:10:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286502750E5
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781809; cv=none; b=N5qaJ1Urv9tWq78spfl4iiZIWzsoA6g6VHr1G2nMsTbVUOzd3hnMe+5y06mVRHpLwgRzwhk/7QXLOgBHnCJx2g94xcj83fMySTxBFaiLGy98QZifp5YGR9rlvG52GYJmoff2HEdMOsyMXMrdtWh64V/o/Y7RaDGYL9umhqyxjBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781809; c=relaxed/simple;
	bh=RRNnRMaDuFOb7wv20wlx6U6Do4EaxhKupytQlhQVfxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=niIp+WloqM2tCorUd0kYvALU8ckcO1FuBKAKFANxRLJ0I7EoaXn+uEgPeQrMQPiIbIJ+I1Dktv9AzAFP8YTMWG+Gt87E4bprhV3pGSU2QxfpPwZsclPiBlCZv+rCH3QP33Xnx479wk+qK5osgAjYxyic1BNl9gA4WB4+nOnAOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c59736C7D829705D90AB67a755.dip0.t-ipconnect.de [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 2E792FA131;
	Fri,  9 May 2025 11:02:48 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/1] pull request: batman-adv 2025-05-09
Date: Fri,  9 May 2025 11:02:39 +0200
Message-Id: <20250509090240.107796-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub,

here is a bugfix for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 61f96e684edd28ca40555ec49ea1555df31ba619:

  Merge tag 'net-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-04-04 09:15:35 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250509

for you to fetch changes up to 8772cc49e0b8ab782e475ce5ef659eedab601a09:

  batman-adv: fix duplicate MAC address check (2025-04-16 20:52:33 +0200)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - fix duplicate MAC address check, by Matthias Schiffer

----------------------------------------------------------------
Matthias Schiffer (1):
      batman-adv: fix duplicate MAC address check

 net/batman-adv/hard-interface.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

