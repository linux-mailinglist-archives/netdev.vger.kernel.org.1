Return-Path: <netdev+bounces-67915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEE18455F5
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150B928E106
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85C15B992;
	Thu,  1 Feb 2024 11:08:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8815B978
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785682; cv=none; b=VHBFUuMG3e9WflXZvu/+WBjJNSushXYW1Rl24v7cT4/mDMimkdvP1peiQZqoxRBH/4Y/kwUse3161aRkRj+f29Ydu8OD8vlHSf9qgSh3j3vgJxdWwkZ5RUbKldZGekro0QG/gcKSzApA+cnph8k+0Gr3fSGeZt6tRAdKcUSq40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785682; c=relaxed/simple;
	bh=J9PCK7bKS/auqgXv4qThuIfm8kFLzhM6grgYG8p4t9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iPay+I/R+Dw8Z8200q+vKTq+TsVTC9gWYq9qIaJZzpn+pF2wGutiTKbovuUf8hjjqYJ48CeS7Qrdi0gHTzQCxjsQ5uL6OorXm35G34JQS3cmubPdW/xCHuEumObTQGHWQtYm3eUPZNL6O1a55kDHBzgUIh+BE01uHKZrhXR0G4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C59712C7d8D89318FB9D63B559.dip0.t-ipconnect.de [IPv6:2003:c5:9712:c7d8:d893:18fb:9d63:b559])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 42AD0FA9B1;
	Thu,  1 Feb 2024 12:07:58 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/4] pull request for net-next: batman-adv 2024-02-01
Date: Thu,  1 Feb 2024 12:07:52 +0100
Message-Id: <20240201110756.29728-1-sw@simonwunderlich.de>
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

here is a cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20240201

for you to fetch changes up to db60ad8b21cee0394cb0a1092d9f9190d310562c:

  batman-adv: Drop usage of export.h (2024-01-27 09:13:59 +0100)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Improve error handling in DAT and uevent generator,
   by Markus Elfring (2 patches)

 - Drop usage of export.h, by Sven Eckelmann

----------------------------------------------------------------
Markus Elfring (2):
      batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()
      batman-adv: Improve exception handling in batadv_throw_uevent()

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (1):
      batman-adv: Drop usage of export.h

 net/batman-adv/distributed-arp-table.c |  3 +--
 net/batman-adv/main.c                  | 14 ++++++++------
 net/batman-adv/main.h                  |  2 +-
 net/batman-adv/netlink.c               |  1 -
 4 files changed, 10 insertions(+), 10 deletions(-)

