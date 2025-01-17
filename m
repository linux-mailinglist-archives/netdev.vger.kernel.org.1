Return-Path: <netdev+bounces-159286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C0A14F8E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8A81886490
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA231FF7A0;
	Fri, 17 Jan 2025 12:45:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3421FF613
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117921; cv=none; b=Hw7t4S1CoWBOjOcN4fL44A1PQlfqU/gYQtAFC+gWxhoojrPsQgXnvltS/Fz9ss7uw2OdqXU5y1XUPCgCn0ZEfz3KFNuX28G+rHj8E0rNBdUvMwnJLzoK9amMQLrL8kR9rDrRT+bUEZHJWJ12xmc2i/yhwR1zCeFEKyvEd6ISu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117921; c=relaxed/simple;
	bh=J+dn9aHKrhoCr4DdYHM82yHAN3zBtT6kKWCOpLRyc7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bgXCAh+fPY9k14ptvN2ntMUr9rllZEf/aeScVSaDfktlU07lU7RpWAe+OGjKKhfx3zAcT3B97UwaxPpg345liLLCbIzIJTiitgwClhRRv+BMSMB+3gtDrnWi+IeYsTiajSSDD7UcPpyrbkcTieYWKthhO3hOr/0wEXfsU+gW+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c5973c90d8A96DD71A2E03F697.dip0.t-ipconnect.de [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 8733DFA132;
	Fri, 17 Jan 2025 13:39:23 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 00/10] pull request for net-next: batman-adv 2025-01-17
Date: Fri, 17 Jan 2025 13:39:00 +0100
Message-Id: <20250117123910.219278-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jakub, hi David,

here is a cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20250117

for you to fetch changes up to 6ecc4fd6c2f43862c5e3b280cf419f0131e45c97:

  batman-adv: netlink: reduce duplicate code by returning interfaces (2025-01-17 13:36:01 +0100)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Reorder includes for distributed-arp-table.c, by Sven Eckelmann

 - Fix translation table change handling, by Remi Pommarel (2 patches)

 - Map VID 0 to untagged TT VLAN, by Sven Eckelmann

 - Update MAINTAINERS/mailmap e-mail addresses, by the respective authors
   (4 patches)

 - netlink: reduce duplicate code by returning interfaces,
   by Linus Lüssing

----------------------------------------------------------------
Antonio Quartulli (1):
      MAINTAINERS: mailmap: add entries for Antonio Quartulli

Linus Lüssing (1):
      batman-adv: netlink: reduce duplicate code by returning interfaces

Marek Lindner (1):
      MAINTAINERS: update email address of Marek Linder

Remi Pommarel (2):
      batman-adv: Remove atomic usage for tt.local_changes
      batman-adv: Don't keep redundant TT change events

Simon Wunderlich (2):
      batman-adv: Start new development cycle
      mailmap: add entries for Simon Wunderlich

Sven Eckelmann (3):
      batman-adv: Reorder includes for distributed-arp-table.c
      batman-adv: Map VID 0 to untagged TT VLAN
      mailmap: add entries for Sven Eckelmann

 .mailmap                                |  19 +++++
 Documentation/networking/batman-adv.rst |   2 +-
 MAINTAINERS                             |   4 +-
 net/batman-adv/bridge_loop_avoidance.c  |  33 ++------
 net/batman-adv/distributed-arp-table.c  |  20 ++---
 net/batman-adv/gateway_client.c         |  18 +---
 net/batman-adv/main.c                   |   7 ++
 net/batman-adv/main.h                   |   4 +-
 net/batman-adv/multicast.c              |  17 +---
 net/batman-adv/netlink.c                | 146 ++++++++++++++++++++++----------
 net/batman-adv/netlink.h                |   5 +-
 net/batman-adv/originator.c             | 116 +++++++++----------------
 net/batman-adv/soft-interface.c         |  16 +++-
 net/batman-adv/translation-table.c      |  92 ++++++++------------
 net/batman-adv/types.h                  |   4 +-
 15 files changed, 251 insertions(+), 252 deletions(-)

