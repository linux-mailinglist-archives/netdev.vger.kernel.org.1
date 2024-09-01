Return-Path: <netdev+bounces-124008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88C967595
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 10:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BF21C2116F
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B335149C77;
	Sun,  1 Sep 2024 08:36:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-12.us.a.mail.aliyun.com (out198-12.us.a.mail.aliyun.com [47.90.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC21494CD;
	Sun,  1 Sep 2024 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725179772; cv=none; b=Tm/XbvF9rL31U+uC5O07eBi/cSxYq7QRALxTwEtXcjVWxCFFK5rVnIbB/o6ZNWyWTqCGDjbPeTPyfFNMHpQWiftFuEE14JBtOhPxKFv2SSBk1ZVfaEZCMq52qBSFE5/fcnzHQ0i7fQeb70YcnRmG/KttXCJ2KIPRWddBeVM3qYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725179772; c=relaxed/simple;
	bh=foAtiKWA9e8W0KnHoD7sncfm78qQLXDGGIfZJVK+Pqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iofr06U2Em/7lDqwYyCyT3PiuAdCDr7JVp9yKaNixKnn5mKvatjGTw2fsfAqF1TBkl1S6xqcWc8j50gBAcSv2B8wUeDrClCX8sJlgoSCdVb/N7xbrGG0YYHLZPGlvCxVcH5+FafxOlEZzNOPT4lYJaBxFRwzTXHURWvrasjXviI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.Z7fmmqR_1725179730)
          by smtp.aliyun-inc.com;
          Sun, 01 Sep 2024 16:35:50 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com,
	hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com,
	suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: [PATCH net-next v5 0/2] Add driver for Motorcomm yt8821 2.5G ethernet phy
Date: Sun,  1 Sep 2024 01:35:24 -0700
Message-Id: <20240901083526.163784-1-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

yt8521 and yt8531s as Gigabit transceiver use bit15:14(bit9 reserved
default 0) as phy speed mask, yt8821 as 2.5G transceiver uses bit9 bit15:14
as phy speed mask.

Be compatible to yt8821, reform phy speed mask and phy speed macro.

Based on update above, add yt8821 2.5G phy driver.

Frank Sae (2):
  net: phy: Optimize phy speed mask to be compatible to yt8821
  net: phy: Add driver for Motorcomm yt8821 2.5G ethernet phy

 drivers/net/phy/motorcomm.c | 684 +++++++++++++++++++++++++++++++++++-
 1 file changed, 672 insertions(+), 12 deletions(-)

-- 
2.34.1


