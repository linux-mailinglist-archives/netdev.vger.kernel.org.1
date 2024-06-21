Return-Path: <netdev+bounces-105733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E75912842
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC9E1C20B15
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC3208CE;
	Fri, 21 Jun 2024 14:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5535B2940F
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981123; cv=none; b=gG5CwAcZWxotqY4uj0t9HUT+oeCTJRb28ZbwgCj4ke00lMoe/Aginzo/+B/cL7VRehR9oAVeBPHW7llJsYszfeEqLnh4zyAOB7hl1ha9Qpin1NLtlnt2gToXbdXtpLCd95NqiD0Whqj1MFS76WEAH1x6bEcSwuyd+XDoazRESiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981123; c=relaxed/simple;
	bh=kt4kSbiRFJ4bY0GKilYy95w5JquD0kEyOtnNFE/A95A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Alk0SGqgeZw666dcAUnex8piRABqmBU4iuP/92AWBpflcM84rBSPgVvhjdx3QmJJ81rQqVkTJQ7U5pPN07du6C3XEVRuoPItAIluQoqC2AYi2mXeicxofBw6wKnvvacuS+t/bVXAI1vy1XRcy1f/MYiodHCawwUu3d/ek6GHSTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C5970FcFD871714591023Aa0Cd.dip0.t-ipconnect.de [IPv6:2003:c5:970f:cfd8:7171:4591:23a:a0cd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 3D1A8FA131;
	Fri, 21 Jun 2024 16:39:22 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/2] pull request for net: batman-adv 2024-06-21
Date: Fri, 21 Jun 2024 16:39:13 +0200
Message-Id: <20240621143915.49137-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub,

here are two bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20240621

for you to fetch changes up to 6bfff3582416b2f809e6b08c6e9d57b18086bdbd:

  Revert "batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks" (2024-06-12 20:18:00 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

- Don't accept TT entries for out-of-spec VIDs, by Sven Eckelmann

- Revert "batman-adv: prefer kfree_rcu() over call_rcu() with free-only
  callbacks", by Linus Lüssing

----------------------------------------------------------------
Linus Lüssing (1):
      Revert "batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks"

Sven Eckelmann (1):
      batman-adv: Don't accept TT entries for out-of-spec VIDs

 net/batman-adv/originator.c        | 27 ++++++++++++++++++++++
 net/batman-adv/translation-table.c | 47 +++++++++++++++++++++++++++++++++++---
 2 files changed, 71 insertions(+), 3 deletions(-)

