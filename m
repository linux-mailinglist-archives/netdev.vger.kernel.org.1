Return-Path: <netdev+bounces-174651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59F6A5FB2D
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF137A744C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5308A269AF4;
	Thu, 13 Mar 2025 16:17:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64D82690D1
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882670; cv=none; b=rxdF6g7KOd23j4M4Dasq0mTX7JOnQLfEBWVRDuuBkY6YIohHlEryJQbGM86BKhOYy4QTK3N7dy3ICgJz3P938yEah7avy/FCPyPmR62gF4/ffXwg75avoYXGoUj8tTA0Mw6PkmdTV5XaFrYE5Q3c4gW0kzFI1EZWOgr24F0sPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882670; c=relaxed/simple;
	bh=ogVHrmBVFw6XB95Z0eR0e4UKzAity8+FrwULH8OhRzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HDG2qY7WsoIHV4K22sJi7ZF1kOZaehr56mA88Xnp6uRTNrhdqSiW+2IvgC+bmHgFTSTgSy+tCjlpbBZwTLfVGzffMvJa0ZFdN3IaQxo1wBfqxgFfiF+4TxJMJZx1pMeErqxgDdnKtzwM1SGQi7R0ptU93GeL0TnvyM+skiurMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300fA272413901A38A4bc9c0De305.dip0.t-ipconnect.de [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 6041AFA131;
	Thu, 13 Mar 2025 17:17:40 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/5] pull request for net: batman-adv 2025-03-13
Date: Thu, 13 Mar 2025 17:17:33 +0100
Message-Id: <20250313161738.71299-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub,

here are some bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit fff8f17c1a6fc802ca23bbd3a276abfde8cc58e6:

  batman-adv: Do not let TT changes list grows indefinitely (2024-12-05 22:38:26 +0100)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250313

for you to fetch changes up to 548b0c5de7619ef53bbde5590700693f2f6d2a56:

  batman-adv: Ignore own maximum aggregation size during RX (2025-02-08 19:24:33 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

- fix panic during interface removal, by Andy Strohman

- Ignore neighbor throughput metrics in error case, by Sven Eckelmann

- Drop unmanaged ELP metric worker, by Sven Eckelmann

- Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1(), by Remi Pommarel

- Ignore own maximum aggregation size during RX, Sven Eckelmann

----------------------------------------------------------------
Andy Strohman (1):
      batman-adv: fix panic during interface removal

Remi Pommarel (1):
      batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1()

Sven Eckelmann (3):
      batman-adv: Ignore neighbor throughput metrics in error case
      batman-adv: Drop unmanaged ELP metric worker
      batman-adv: Ignore own maximum aggregation size during RX

 net/batman-adv/bat_iv_ogm.c        |   3 +-
 net/batman-adv/bat_v.c             |   2 -
 net/batman-adv/bat_v_elp.c         | 122 ++++++++++++++++++++++++++-----------
 net/batman-adv/bat_v_elp.h         |   2 -
 net/batman-adv/bat_v_ogm.c         |   3 +-
 net/batman-adv/translation-table.c |  12 ++--
 net/batman-adv/types.h             |   3 -
 7 files changed, 93 insertions(+), 54 deletions(-)

