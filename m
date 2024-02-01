Return-Path: <netdev+bounces-67922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24A84560B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC54B213A4
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF36D15D5BE;
	Thu,  1 Feb 2024 11:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E1B15CD4F
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785828; cv=none; b=gOSXkT/AvBkomwV9B+rEYyYeIXlmtWgF+p9YN+n+TNnucAvzPoNg6W3d/40Qr+n5VFGjzbfeITtLsJ3QSQBLaNZqmk/rDdxCLKNlsVkKw7R/tMOx1Io2gJb+cFzt3ov3d5q6FWMQwD1O9z7+jAetOmDPJKvq2/qVxl4m8KawZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785828; c=relaxed/simple;
	bh=TdvRguEtsJmq0YYY7WJKxmSPI/K3KqQyHKzfYsmYynM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V3LqZL7aY/vAP7kYjoEqnsOZ04TEbQewSgtOcaZrpfyNIgEXZjcrZe9KAeZZ+Dpf4VCaHH7xQI/DoLE1UXN3UwvJMkYwb3TTBvUWcvWjtjgyPL1OwT/1WNh8/qYy3ZzjPPMyMPdX49cm6oXDCqRaaPTt8RTSq8BeR0XHK6KfQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c59712C7d8D89318FB9D63B559.dip0.t-ipconnect.de [IPv6:2003:c5:9712:c7d8:d893:18fb:9d63:b559])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 1B9D7FA2D7;
	Thu,  1 Feb 2024 12:01:15 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/2] pull request for net: batman-adv 2024-02-01
Date: Thu,  1 Feb 2024 12:01:08 +0100
Message-Id: <20240201110110.29129-1-sw@simonwunderlich.de>
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

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20240201

for you to fetch changes up to 0a186b49bba596b81de5a686ce5bfc9cd48ab3ef:

  batman-adv: mcast: fix memory leak on deleting a batman-adv interface (2024-01-27 09:13:39 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - fix a timeout issue and a memory leak in batman-adv multicast,
   by Linus Lüssing (2 patches)

----------------------------------------------------------------
Linus Lüssing (2):
      batman-adv: mcast: fix mcast packet type counter on timeouted nodes
      batman-adv: mcast: fix memory leak on deleting a batman-adv interface

 net/batman-adv/multicast.c | 3 +++
 1 file changed, 3 insertions(+)

