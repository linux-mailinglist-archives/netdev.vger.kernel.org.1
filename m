Return-Path: <netdev+bounces-135447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F183699DF85
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B4E1F23D13
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F6A1AC450;
	Tue, 15 Oct 2024 07:45:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1B1A3042
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978343; cv=none; b=SmZBH5H9AwczFG8Uk7VHnvP2s0x62RFswqF9Nan65epP0PslyZC0qgxVDkZPXFxL3Zz8EulnRMr4idNT1f+M5NHiNEcrLghiJnOBtMTD1phjwUoT7Tb6BHiieuLLi/grFlEqDPv5pTKhx7VcMLWyffKAxntHL7BdWiScmBye83Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978343; c=relaxed/simple;
	bh=DvKq+Cyf7kTlEJh4q2lvQLXEAEdu92AR3KohhYEC8j0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DeGYuAUhEoRYhiFj6mWTol66awZ51eaKHsFcN9vNLGpo7qRh2+d2Z8y+gACU1aUvR5siKGsO5HZCT+KIjZU8tpWAxY/klOFp0Ph4jbNGls0O64MxRxDDmT58PkGPIL1m4L7qV8OPaQCuFPN4T8da6Pv0Pn+eb5waRPNA5a1c0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p5480b09e.dip0.t-ipconnect.de [84.128.176.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id EB5E3FA132;
	Tue, 15 Oct 2024 09:39:47 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/4] pull request for net-next: batman-adv 2024-10-15
Date: Tue, 15 Oct 2024 09:39:42 +0200
Message-Id: <20241015073946.46613-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub, hi David,

here is a feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20241015

for you to fetch changes up to 356c81b6c494a359ed6e25087931acc78c518fb9:

  batman-adv: replace call_rcu by kfree_rcu for simple kmem_cache_free callback (2024-10-14 09:08:39 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Add flex array to struct batadv_tvlv_tt_data, by Erick Archer

 - Use string choice helper to print booleans, by Sven Eckelmann

 - replace call_rcu by kfree_rcu for simple kmem_cache_free callback,
   by Julia Lawall

----------------------------------------------------------------
Erick Archer (1):
      batman-adv: Add flex array to struct batadv_tvlv_tt_data

Julia Lawall (1):
      batman-adv: replace call_rcu by kfree_rcu for simple kmem_cache_free callback

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (1):
      batman-adv: Use string choice helper to print booleans

 include/uapi/linux/batadv_packet.h     | 29 +++++-----
 net/batman-adv/bat_iv_ogm.c            |  4 +-
 net/batman-adv/bridge_loop_avoidance.c |  8 +--
 net/batman-adv/main.h                  |  2 +-
 net/batman-adv/translation-table.c     | 96 ++++++++--------------------------
 5 files changed, 46 insertions(+), 93 deletions(-)

