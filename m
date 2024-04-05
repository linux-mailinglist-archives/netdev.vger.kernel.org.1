Return-Path: <netdev+bounces-85116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D406899859
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00DF9B21E41
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C210314262B;
	Fri,  5 Apr 2024 08:45:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BCA15F319
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306758; cv=none; b=hBDWUx1agcSVeN3ZqyHr0iE4m/VHZsxufCww6xgpBft+1VEwDO9xjBqXo4naCZbSpcDeUZwyJMGxM4MqavulLx44bv45lmAMxJSETwXaSeUjmZ6W/pcnZlXT1P9LNReQk85WYAbz/W9T6HvGBIzryvnMwE2rUPHm7v8qjhjOIhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306758; c=relaxed/simple;
	bh=hSB671cdWp2nwapExrJKnRmvIkPScV3NbMV/Kz4NSzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LhqjQ1+hPGzgCsm6IQh82I4qEJEdE5JPpn0cayJWtoJ6YJwXoeK7nMKYDYOTWVKdMVGXH04fljYUMQ0x3oJNJ2J7T6ATy7hlu0qXh+tpvFu0wkGRZHnqv8RDfDfgG0IGTcCQnNOd4tpnWYHQN4Ih/MBcp6RXSxPgDMo19GqqcGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p5de1fdf8.dip0.t-ipconnect.de [93.225.253.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id E1622FA100;
	Fri,  5 Apr 2024 10:45:54 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/3] pull request for net-next: batman-adv 2024-04-05
Date: Fri,  5 Apr 2024 10:45:46 +0200
Message-Id: <20240405084549.20003-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
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

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20240405

for you to fetch changes up to 40dc8ab605894acae1473e434944924a22cfaaa0:

  batman-adv: bypass empty buckets in batadv_purge_orig_ref() (2024-03-31 10:13:36 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - prefer kfree_rcu() over call_rcu() with free-only callbacks,
   by Dmitry Antipov

 - bypass empty buckets in batadv_purge_orig_ref(), by Eric Dumazet

----------------------------------------------------------------
Dmitry Antipov (1):
      batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks

Eric Dumazet (1):
      batman-adv: bypass empty buckets in batadv_purge_orig_ref()

Simon Wunderlich (1):
      batman-adv: Start new development cycle

 net/batman-adv/main.h              |  2 +-
 net/batman-adv/originator.c        |  2 ++
 net/batman-adv/translation-table.c | 47 +++-----------------------------------
 3 files changed, 6 insertions(+), 45 deletions(-)

