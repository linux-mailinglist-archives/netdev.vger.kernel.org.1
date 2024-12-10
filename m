Return-Path: <netdev+bounces-150661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650639EB233
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87A82838F3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31691A9B47;
	Tue, 10 Dec 2024 13:50:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BD51E515
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838638; cv=none; b=Y45W/BL1sB5a2sffS45JUZ6JVVH2yrXRzoBtkhJkOxzFVSsbp0lH8f1pb1sSIppythMns8KVYGzhNofgLxDwtgg5K+7an6Gg8yQLfBsxrJXNsyE2ng5bWvrAUH7oenD9wKz1nKf7VrBZHHNqQZHanjUpWsin/ADZWz2HUgB8NJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838638; c=relaxed/simple;
	bh=RUrJrZOD3JEna0Dj84G/DazUjZDeo2XlRhQ3SYw3M1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DWDvy1B7JiUW8jGyW5Gv0COYo2coiyABYyUzqC81lCGsFKWUIepCGmcc0pF5UCD61ISiB3NxU4H8sPS/qheC++ld3UZqpLLnE+2KP2SDaRvJibDJiZXurORHLWo5JStY5wAlH9J8DeVua3HBHgWzouXO/KRWMY4hK6dj7x1Zoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C5971b44D83038C7ecB8E2Ed5c.dip0.t-ipconnect.de [IPv6:2003:c5:971b:44d8:3038:c7ec:b8e2:ed5c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 13250FA132;
	Tue, 10 Dec 2024 14:50:28 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/3] pull request for net: batman-adv 2024-12-10
Date: Tue, 10 Dec 2024 14:50:21 +0100
Message-Id: <20241210135024.39068-1-sw@simonwunderlich.de>
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

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20241210

for you to fetch changes up to fff8f17c1a6fc802ca23bbd3a276abfde8cc58e6:

  batman-adv: Do not let TT changes list grows indefinitely (2024-12-05 22:38:26 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - fix TT unitialized data and size limit issues, by Remi Pommarel
  (3 patches)

----------------------------------------------------------------
Remi Pommarel (3):
      batman-adv: Do not send uninitialized TT changes
      batman-adv: Remove uninitialized data in full table TT response
      batman-adv: Do not let TT changes list grows indefinitely

 net/batman-adv/translation-table.c | 58 ++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 18 deletions(-)

