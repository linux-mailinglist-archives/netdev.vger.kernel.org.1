Return-Path: <netdev+bounces-205871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C61B00950
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B1F1C420A5
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 16:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BFB2F0C5D;
	Thu, 10 Jul 2025 16:55:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF7285062
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166514; cv=none; b=MgES2ba0EysnWww5J272V1dcYiS6BoHVulO6JIzsDtuxxhXsTdOLg35zKT1T3jVm2Es8xU9hAvGf130UT2nO4jiZRMdjw8rJcFXf8rU29NSgT9JWjkIgLoVVEEmEp/hN5Rvx+DKofNRy9RbsZU8aX653sdr7/mVGEFdvdf+HATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166514; c=relaxed/simple;
	bh=0VRLLynpmPOKnZIjQ/vLvyyD7wR/Byscb3f3t6IIpyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MT8vy2zty3Z+7WbjRiVmfr6U8ynRHNBgCwRgHyixWjOhXTUdvJL7GecIhfjQYPOyoCJrKxNrOLILVUnsowgFDcLFJRtIBCH0HTCT7ixNmLQzAPoF87EGAtYTeD1IHIFTI1tvzewloNs6orRp9qiU0Ak5I893qLZIZioLbZ9G4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300fa271BaC80353e86dE392BA4Af.dip0.t-ipconnect.de [IPv6:2003:fa:271b:ac80:353e:86de:392b:a4af])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C0CCAFA022;
	Thu, 10 Jul 2025 18:45:09 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 0/2] pull request for net-next: batman-adv 2025-07-10
Date: Thu, 10 Jul 2025 18:44:59 +0200
Message-Id: <20250710164501.153872-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub, hi David,

here is a small cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 90b83efa6701656e02c86e7df2cb1765ea602d07:

  Merge tag 'bpf-next-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next (2025-05-28 15:52:42 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20250710

for you to fetch changes up to 7dc284702bcd065a822a4c0bdbca09a08de5a654:

  batman-adv: store hard_iface as iflink private data (2025-05-31 10:41:11 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - batman-adv: store hard_iface as iflink private data,
   by Matthias Schiffer

----------------------------------------------------------------
Matthias Schiffer (1):
      batman-adv: store hard_iface as iflink private data

Simon Wunderlich (1):
      batman-adv: Start new development cycle

 net/batman-adv/bat_algo.c       |  1 +
 net/batman-adv/bat_algo.h       |  2 --
 net/batman-adv/bat_iv_ogm.c     | 25 ++++++++-----------------
 net/batman-adv/bat_v.c          |  6 ++----
 net/batman-adv/bat_v_elp.c      |  8 ++------
 net/batman-adv/bat_v_ogm.c      | 14 ++++----------
 net/batman-adv/hard-interface.c | 39 ++++++++++++++-------------------------
 net/batman-adv/main.c           |  7 ++-----
 net/batman-adv/main.h           |  2 +-
 net/batman-adv/mesh-interface.c |  6 +++---
 net/batman-adv/multicast.c      |  6 ++----
 net/batman-adv/netlink.c        |  7 ++-----
 net/batman-adv/originator.c     |  7 ++-----
 net/batman-adv/send.c           |  7 ++-----
 14 files changed, 45 insertions(+), 92 deletions(-)

