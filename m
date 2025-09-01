Return-Path: <netdev+bounces-218837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D230B3EC27
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BEA44450A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7BD306486;
	Mon,  1 Sep 2025 16:25:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A24224B1F
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743913; cv=none; b=SWSCL2YWH1hDQx6WYflim6UevzMKy1VntOZY80PgAz8b5xSq1vCDITwyAEYz95OCdomg4emyWvQDuEciDL4QTu5EaGGGxv3My85KP1NY/pAq4pVYkmP8YmX8CPF4fZUL3t5nI4+4JnFyYTWu6Lq03gTABkmoBC3lOQ5Crw+K4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743913; c=relaxed/simple;
	bh=917c45RCaMmB+8dKcjjeMtjVQVXQpRZf6sNBsnEnrIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kI/Fy0V28vjwxKPHfzMI97/eIUFnhcg3KdUb92xir/n8nOfgIBAfSnBKPxiGjAyt9KmlX0p4ee1mHKiD/H0xy9imfRl+UC/H+8gxu/wc/BOAVqjBIk0W5IHAbnDCm+7qd3mKVRphFGgksqnksYdd3ccDD4mUCLXJB9DbYzOhWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c59705add84F8b09D1D73C2E85.dip0.t-ipconnect.de [IPv6:2003:c5:9705:add8:4f8b:9d1:d73c:2e85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 52666FA12C;
	Mon,  1 Sep 2025 18:15:52 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/1] pull request: batman-adv 2025-09-01
Date: Mon,  1 Sep 2025 18:15:45 +0200
Message-ID: <20250901161546.1463690-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.2
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

The following changes since commit 6439a0e64c355d2e375bd094f365d56ce81faba3:

  Merge tag 'net-6.17-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-08-21 13:51:15 -0400)

are available in the Git repository at:

  git+ssh://git@open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250901

for you to fetch changes up to d77b6ff0ce35a6d0b0b7b9581bc3f76d041d4087:

  batman-adv: fix OOB read/write in network-coding decode (2025-08-31 17:01:35 +0200)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - fix OOB read/write in network-coding decode, by Stanislav Fort

----------------------------------------------------------------
Stanislav Fort (1):
      batman-adv: fix OOB read/write in network-coding decode

 net/batman-adv/network-coding.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

