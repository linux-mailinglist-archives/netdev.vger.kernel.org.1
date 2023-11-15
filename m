Return-Path: <netdev+bounces-48150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7367ECA37
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81E9280F30
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C256364A3;
	Wed, 15 Nov 2023 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E6A1BC
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:05:30 -0800 (PST)
Received: from kero.packetmixer.de (p200300fa2706340047Bd8a14b9C54dBB.dip0.t-ipconnect.de [IPv6:2003:fa:2706:3400:47bd:8a14:b9c5:4dbb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 8356DFB5F7;
	Wed, 15 Nov 2023 18:59:41 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/6] pull request for net-next: batman-adv 2023-11-15
Date: Wed, 15 Nov 2023 18:59:26 +0100
Message-Id: <20231115175932.127605-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jakub, hi David,

here is a feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 89cdf9d556016a54ff6ddd62324aa5ec790c05cc:

  Merge tag 'net-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-11-09 17:09:35 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20231115

for you to fetch changes up to c3ed16a64c0b0a5b116c9753bf48496d49daffb5:

  batman-adv: Switch to linux/array_size.h (2023-11-14 08:16:34 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Implement new multicast packet type, including its transmission,
   forwarding and parsing, by Linus Lüssing (3 patches)

 - Switch to new headers for sprintf and array size,
   by Sven Eckelmann (2 patches)

----------------------------------------------------------------
Linus Lüssing (3):
      batman-adv: mcast: implement multicast packet reception and forwarding
      batman-adv: mcast: implement multicast packet generation
      batman-adv: mcast: shrink tracker packet after scrubbing

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (2):
      batman-adv: Switch to linux/sprintf.h
      batman-adv: Switch to linux/array_size.h

 include/uapi/linux/batadv_packet.h     |   45 +-
 net/batman-adv/Makefile                |    1 +
 net/batman-adv/bridge_loop_avoidance.c |    2 +-
 net/batman-adv/fragmentation.c         |    8 +-
 net/batman-adv/gateway_client.c        |    2 +-
 net/batman-adv/main.c                  |    5 +-
 net/batman-adv/main.h                  |    2 +-
 net/batman-adv/multicast.c             |  129 +++-
 net/batman-adv/multicast.h             |   30 +-
 net/batman-adv/multicast_forw.c        | 1178 ++++++++++++++++++++++++++++++++
 net/batman-adv/netlink.c               |    2 +-
 net/batman-adv/originator.c            |   28 +
 net/batman-adv/originator.h            |    3 +
 net/batman-adv/routing.c               |   70 ++
 net/batman-adv/routing.h               |   11 +
 net/batman-adv/soft-interface.c        |   18 +-
 net/batman-adv/types.h                 |   70 ++
 17 files changed, 1572 insertions(+), 32 deletions(-)
 create mode 100644 net/batman-adv/multicast_forw.c

