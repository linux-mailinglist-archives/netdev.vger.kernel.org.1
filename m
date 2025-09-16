Return-Path: <netdev+bounces-223512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08923B59643
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4962C17F937
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2B430C606;
	Tue, 16 Sep 2025 12:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA5F298991
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025956; cv=none; b=Yy919nojQpycpwNBbhCqHgYTagocBuKzQSyEukVxyy2cFOaP0npFb2Z2P8um9QtcV7CSheqN4JIhvy9pvXENjFpy/++6w64n92ruZISszGNRRM+dZ2HOxDGggvinq1AF9p6SCv9gbvq8w1UqtNXSo0Ya9fNryV2iG8qtWliUf0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025956; c=relaxed/simple;
	bh=Agg8jwj0yNz4U+D1vkGqSfDDpA4p1Dso+0TsUn5IHJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ACzcqbshkVqfla1AGb2pA2zR7FlKDJzUdJKuzAjCxNH0oXPmdrivE2BTCJNzaTJFZcH7Yq4uiBynGS33V8TtX7GuvhUDJEr/fV0ojuH3AuG2QdBCBpXR2P2Vc8zQGdpR1xCvE3EnF+nnyReOLhUWNZnJ+DT5lEONDXocuYbHZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c5972536D8604E0A64d0d3AAD8.dip0.t-ipconnect.de [IPv6:2003:c5:9725:36d8:604e:a64:d0d3:aad8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id D79CDFA12C;
	Tue, 16 Sep 2025 14:24:48 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 0/4] pull request for net-next: batman-adv 2025-09-16
Date: Tue, 16 Sep 2025 14:24:37 +0200
Message-ID: <20250916122441.89246-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
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

This time we use a https pull request link as we have turned off our
public git protocol server - sorry for the hiccup last time, I hope
everything is smooth now.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit d69eb204c255c35abd9e8cb621484e8074c75eaa:

  Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-04 09:59:15 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20250916

for you to fetch changes up to 629a2b18e8729497eeac5b63e575e0961ca3a4ab:

  batman-adv: remove includes for extern declarations (2025-09-05 15:11:02 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Remove network coding support, by Sven Eckelmann (2 patches)

 - remove includes for extern declarations, by Sven Eckelmann

----------------------------------------------------------------
Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (3):
      batman-adv: remove network coding support
      batman-adv: keep skb crc32 helper local in BLA
      batman-adv: remove includes for extern declarations

 net/batman-adv/Kconfig                 |   13 -
 net/batman-adv/Makefile                |    1 -
 net/batman-adv/bat_iv_ogm.c            |    5 -
 net/batman-adv/bridge_loop_avoidance.c |   34 +
 net/batman-adv/hard-interface.c        |    1 +
 net/batman-adv/hard-interface.h        |    1 -
 net/batman-adv/log.h                   |    3 -
 net/batman-adv/main.c                  |   50 -
 net/batman-adv/main.h                  |    5 +-
 net/batman-adv/mesh-interface.c        |   15 +-
 net/batman-adv/mesh-interface.h        |    1 -
 net/batman-adv/netlink.c               |   17 -
 net/batman-adv/netlink.h               |    1 -
 net/batman-adv/network-coding.c        | 1878 --------------------------------
 net/batman-adv/network-coding.h        |  106 --
 net/batman-adv/originator.c            |    6 -
 net/batman-adv/routing.c               |    9 +-
 net/batman-adv/send.c                  |   16 +-
 net/batman-adv/translation-table.c     |    4 +-
 net/batman-adv/types.h                 |  216 ----
 20 files changed, 41 insertions(+), 2341 deletions(-)
 delete mode 100644 net/batman-adv/network-coding.c
 delete mode 100644 net/batman-adv/network-coding.h

