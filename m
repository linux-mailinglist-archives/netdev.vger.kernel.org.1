Return-Path: <netdev+bounces-189164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A180DAB0E4E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7323B9E31D3
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734F4275852;
	Fri,  9 May 2025 09:10:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8C73477
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781846; cv=none; b=S9BJb5nL5JWRs0CKH02pqmoNr4LmAugvMjhuXJ0ax0J02Vvdh+5a2gNUhzVK3iclDSxozT1ZPJLo9+uzmibBNJlWDu7PuKdZYUm+q5Sb16L5glYqtY38YBxrKTuoj1JdI9geAe6Qacn6NjNm5n7pOiXfl+2EYAxSWS9vBFZOm2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781846; c=relaxed/simple;
	bh=viSzsAjrFyumtuOspHhw2kFwySDNxMnGIfy8wK1NRyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IkbyFfmynuiXR59luvp0S7jtj9sKIQlO62jiF+lPkt383AmDh0Kq+RoviHAR8KeT4Mi6qo2NaYc1NofhfTpnsg0Jt9+JeRGfevl1SE5Pem1om72d/XpqASFq3nY3GeLy2lkXExlT7dJn6f4bCdAHcyRguKR1x31t1BlxhVnD6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c59736c7D829705d90aB67A755.dip0.t-ipconnect.de [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 8272DFA131;
	Fri,  9 May 2025 11:10:42 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 0/5] pull request for net-next: batman-adv 2025-05-09
Date: Fri,  9 May 2025 11:10:36 +0200
Message-Id: <20250509091041.108416-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
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

The following changes since commit 61f96e684edd28ca40555ec49ea1555df31ba619:

  Merge tag 'net-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-04-04 09:15:35 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20250509

for you to fetch changes up to 4e1ccc8e52e5eb3a072d7e4faecd80c6f326bfd2:

  batman-adv: Drop unused net_namespace.h include (2025-04-13 11:11:33 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - constify and move broadcast addr definition, Matthias Schiffer

 - remove start/stop queue function for mesh-iface, by Antonio Quartulli

 - switch to crc32 header for crc32c, by Sven Eckelmann

 - drop unused net_namespace.h include, by Sven Eckelmann

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: no need to start/stop queue on mesh-iface

Matthias Schiffer (1):
      batman-adv: constify and move broadcast addr definition

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (2):
      batman-adv: Switch to crc32 header for crc32c
      batman-adv: Drop unused net_namespace.h include

 net/batman-adv/main.c              |  4 +---
 net/batman-adv/main.h              |  3 +--
 net/batman-adv/mesh-interface.c    | 15 ---------------
 net/batman-adv/send.c              |  4 +++-
 net/batman-adv/translation-table.c |  2 +-
 5 files changed, 6 insertions(+), 22 deletions(-)

