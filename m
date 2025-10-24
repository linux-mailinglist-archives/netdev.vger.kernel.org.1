Return-Path: <netdev+bounces-232400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C726EC054EB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CAD1892D09
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C6309DC1;
	Fri, 24 Oct 2025 09:23:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39F1D2F42
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297811; cv=none; b=GHLF4ewMW57VHKeGwYIV0ZUx/rLqHW2AWmIwQjl3CUqgE7YPtzCsQx63eeIiulsbjzz9ARHoTbOTNOa/JC3t80LCxGy9pqC+r2mOy1cQ/pue2vQn6Y4he5Pc/C1uP3ME7p3OqeAUKdW82Hyz6dfr4S38e5B31a2aVkEfTVxhMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297811; c=relaxed/simple;
	bh=IOMwPQ/P8GO6oYlAgJcOXLdUnKoy86QeNU+ZFOPxPV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4ayJwupUyosdyV5WKFNUWZKU/4osrpnrfhlrhqYs6Uzi/Fb7wZJnBewC5yQ4HeqR5ydZuXNmkqh5x9bDPcZ3C5iFVdHmNxHfFJ5LLBIFTjeC43ODO8bV7pGtEXY8IGeBymEGX/zucxavFezqWNVeaU/5zLKrssEYtaAlXecsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C5970781D8b076411BB4c554a3.dip0.t-ipconnect.de [IPv6:2003:c5:9707:81d8:b076:411b:b4c5:54a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id DD7F7FA130;
	Fri, 24 Oct 2025 11:23:27 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 0/2] pull request for net-next: batman-adv 2025-10-24
Date: Fri, 24 Oct 2025 11:23:13 +0200
Message-ID: <20251024092315.232636-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub, hi David,

here is a cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20251024

for you to fetch changes up to ed5730f3f733659a4a023a5f1e767365fe341648:

  batman-adv: use skb_crc32c() instead of skb_seq_read() (2025-10-17 16:30:43 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - use skb_crc32c() instead of skb_seq_read(), by Sven Eckelmann

----------------------------------------------------------------
Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (1):
      batman-adv: use skb_crc32c() instead of skb_seq_read()

 net/batman-adv/Kconfig                 |  1 +
 net/batman-adv/bridge_loop_avoidance.c | 51 ++++++----------------------------
 net/batman-adv/main.h                  |  2 +-
 net/batman-adv/types.h                 |  2 +-
 4 files changed, 11 insertions(+), 45 deletions(-)

