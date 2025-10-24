Return-Path: <netdev+bounces-232394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C43FAC05460
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 624004E66D2
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4800308F2A;
	Fri, 24 Oct 2025 09:12:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6BB2853F2
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297141; cv=none; b=W4asU+NXsaJstPu94wC4u3JsFQmDH6YSo2/Xe8IMxpXGh2eXtlv3ZG5On3Hg2yZ3UVOmZtoOJtUv1uNea94NP1GulXL2+pnymjdpzWfYZjvhqm9RBJ8LM7jrwngGtQhF2aqC8oht1ymSkhEZLjDEAekRkfXJvjSA69x+Y57kE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297141; c=relaxed/simple;
	bh=YBpFLegduXHDtjVMiRyVV4iUq0IemCd+1JYKeiK6uOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lj2pL+JZQAynz39iP6qKY1rkfOIChDC9b63FqRZvibatsceTmSoX6mLTGkxeUXBblcrcPfqZGJmNavHlUtziaGxIE7ORrGr+86ep/jHu4sT/L/gDOtlEYt9nTV8QGwZPRy1JZ7CvHfyBVDGfVIsBV7LFNgFCknfAwaHztAYcbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c5970781D8b076411bb4C554a3.dip0.t-ipconnect.de [IPv6:2003:c5:9707:81d8:b076:411b:b4c5:54a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 6BB12FA130;
	Fri, 24 Oct 2025 11:12:10 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/1] pull request: batman-adv 2025-10-24
Date: Fri, 24 Oct 2025 11:11:49 +0200
Message-ID: <20251024091150.231141-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub,

here is a bugfix for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit d69eb204c255c35abd9e8cb621484e8074c75eaa:

  Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-04 09:59:15 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20251024

for you to fetch changes up to f12b69d8f22824a07f17c1399c99757072de73e0:

  batman-adv: Release references to inactive interfaces (2025-09-27 19:59:49 +0200)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - release references to inactive interfaces, by Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (1):
      batman-adv: Release references to inactive interfaces

 net/batman-adv/originator.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

