Return-Path: <netdev+bounces-174667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3422AA5FC69
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618461888127
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA51FBEA8;
	Thu, 13 Mar 2025 16:45:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA00149C7D
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884326; cv=none; b=Tm0k6UPD0EZ6mwTywe1bd6rVOTAMKHqqXhv4DsQsI/+dw6w/nlGgntBMhsWqFsFBIRjREht5+csTGzIYUVBcgXnZVNhT16UlWKHw9pQx97U6aAgJwTkTJIELrowgOUEsp8Ort6q0WtxwPxop4nPHAH5h+7GFoIK7v/1m7E50xyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884326; c=relaxed/simple;
	bh=kYTuXnwCwrvKv+G9nZ1fm7UxX2IqgXqp11z+SCkDJYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CteGeyh9PtSGI2CT3lm0EMK5eqKEv598j6zRB6Ycr/YTVunP9KKL92xo1fvTlj8jnkbBjK4cDxIsr/151VBt4OS2rjsgB7Yf5QgzKcOSbO6XjkdN1hDcDl+kuFa5F+aLDpQliwJIHC+aPxW2D9qjBwRKbJbdzkExaIqW/ximAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300Fa272413901A38A4BC9c0De305.dip0.t-ipconnect.de [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C6D42FA131;
	Thu, 13 Mar 2025 17:45:22 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 00/10] pull request for net-next: batman-adv 2025-03-13
Date: Thu, 13 Mar 2025 17:45:09 +0100
Message-Id: <20250313164519.72808-1-sw@simonwunderlich.de>
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

The following changes since commit b66e19dcf684b21b6d3a1844807bd1df97ad197a:

  Merge branch 'mctp-add-mctp-over-usb-hardware-transport-binding' (2025-02-21 16:45:26 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20250313

for you to fetch changes up to 7cfb32456ed82cd548114234ec275d57d4f7554e:

  batman-adv: add missing newlines for log macros (2025-02-23 11:18:36 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - drop batadv_priv_debug_log struct, by Sven Eckelmann

 - adopt netdev_hold() / netdev_put(), by Eric Dumazet

 - add support for jumbo frames, by Sven Eckelmann

 - use consistent name for mesh interface, by Sven Eckelmann

 - cleanup B.A.T.M.A.N. IV OGM aggregation handling,
   by Sven Eckelmann (4 patches)

 - add missing newlines for log macros, by Sven Eckelmann

----------------------------------------------------------------
Eric Dumazet (1):
      batman-adv: adopt netdev_hold() / netdev_put()

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (8):
      batman-adv: Drop batadv_priv_debug_log struct
      batman-adv: Add support for jumbo frames
      batman-adv: Use consistent name for mesh interface
      batman-adv: Limit number of aggregated packets directly
      batman-adv: Switch to bitmap helper for aggregation handling
      batman-adv: Use actual packet count for aggregated packets
      batman-adv: Limit aggregation size to outgoing MTU
      batman-adv: add missing newlines for log macros

 Documentation/networking/batman-adv.rst            |   2 +-
 include/uapi/linux/batman_adv.h                    |  18 +-
 net/batman-adv/Makefile                            |   2 +-
 net/batman-adv/bat_algo.c                          |   8 +-
 net/batman-adv/bat_iv_ogm.c                        | 105 ++++++-----
 net/batman-adv/bat_v.c                             |  28 +--
 net/batman-adv/bat_v_elp.c                         |  16 +-
 net/batman-adv/bat_v_ogm.c                         |  42 ++---
 net/batman-adv/bitarray.c                          |   2 +-
 net/batman-adv/bridge_loop_avoidance.c             | 106 +++++------
 net/batman-adv/distributed-arp-table.c             |  68 +++----
 net/batman-adv/distributed-arp-table.h             |   4 +-
 net/batman-adv/fragmentation.c                     |   2 +-
 net/batman-adv/gateway_client.c                    |  38 ++--
 net/batman-adv/gateway_common.c                    |   8 +-
 net/batman-adv/hard-interface.c                    | 158 ++++++++--------
 net/batman-adv/hard-interface.h                    |  12 +-
 net/batman-adv/log.c                               |   2 +-
 net/batman-adv/log.h                               |  10 +-
 net/batman-adv/main.c                              |  42 ++---
 net/batman-adv/main.h                              |  24 +--
 .../{soft-interface.c => mesh-interface.c}         | 197 ++++++++++----------
 .../{soft-interface.h => mesh-interface.h}         |  22 +--
 net/batman-adv/multicast.c                         | 182 +++++++++----------
 net/batman-adv/multicast_forw.c                    |  30 ++--
 net/batman-adv/netlink.c                           | 180 +++++++++----------
 net/batman-adv/netlink.h                           |   2 +-
 net/batman-adv/network-coding.c                    |  64 +++----
 net/batman-adv/originator.c                        |  58 +++---
 net/batman-adv/routing.c                           |  42 ++---
 net/batman-adv/send.c                              |  36 ++--
 net/batman-adv/send.h                              |   4 +-
 net/batman-adv/tp_meter.c                          |  30 ++--
 net/batman-adv/trace.h                             |   2 +-
 net/batman-adv/translation-table.c                 | 198 ++++++++++-----------
 net/batman-adv/translation-table.h                 |   4 +-
 net/batman-adv/tvlv.c                              |  26 +--
 net/batman-adv/types.h                             |  78 +++-----
 38 files changed, 917 insertions(+), 935 deletions(-)
 rename net/batman-adv/{soft-interface.c => mesh-interface.c} (84%)
 rename net/batman-adv/{soft-interface.h => mesh-interface.h} (50%)

