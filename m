Return-Path: <netdev+bounces-175773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1EFA67721
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80817ACE02
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCA720E710;
	Tue, 18 Mar 2025 15:00:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773B20E034
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310051; cv=none; b=uptkKsSnbKkbv++PDKaQ6GO1rhZG1cR+Tcr1LZEgkB0I01sZlUysC/SK+XSExY1eLSQ2k+jYEvS00Q15sh6b8s+SNAXL97yTz8R261MooDv4r3JICe+WrhOodGTmpXFINE5sQ2ibOm2nOFl+I3Pg0UGeke/Ib4zdRm3KU2qU4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310051; c=relaxed/simple;
	bh=JWBthlJdSUQ0ig3fMPAMN8QayF88ZJDcW/XQofraKm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OlEta3snR+YyBYbs48B+3kgnuDx/soFKzlXZuKPgC2iR7u+BhRXTo8P41BkV01Rn8/5ONPAgk4AHRJekVYyyZ1gIcJ7jr/G2E9BIiyeXROZHlv7iG8FnCJKEch7zLsu1hWvxRmwKVZZd/TjRSpl456nhlJZmtdYh7KIapFG0ryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C5973197D81320d84731f3581A.dip0.t-ipconnect.de [IPv6:2003:c5:9731:97d8:1320:d847:31f3:581a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C7F02FA131;
	Tue, 18 Mar 2025 16:00:37 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	pabeni@redhat.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/1] ] pull request: batman-adv 2025-03-18
Date: Tue, 18 Mar 2025 16:00:34 +0100
Message-Id: <20250318150035.35356-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub,

here is a bugfix for batman-adv which we would like to have integrated into net.

Please note that this pull request supersedes the pull request from
2025-03-13, as Paolo mentioned that there were some issues pulling due
to too many patches added from my end.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit f4c9c2cc827d803159730b1da813a0c595969831:

  batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1() (2025-01-28 22:06:56 +0100)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250318

for you to fetch changes up to 548b0c5de7619ef53bbde5590700693f2f6d2a56:

  batman-adv: Ignore own maximum aggregation size during RX (2025-02-08 19:24:33 +0100)

----------------------------------------------------------------
Here is batman-adv bugfix:

- Ignore own maximum aggregation size during RX, Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (1):
      batman-adv: Ignore own maximum aggregation size during RX

 net/batman-adv/bat_iv_ogm.c | 3 +--
 net/batman-adv/bat_v_ogm.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

