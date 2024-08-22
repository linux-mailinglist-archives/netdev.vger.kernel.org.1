Return-Path: <netdev+bounces-120946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C495B425
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DB91C21A2C
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D41C93CE;
	Thu, 22 Aug 2024 11:47:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64117A584;
	Thu, 22 Aug 2024 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327254; cv=none; b=APCz9srk8Mm61w+2N2VyFVLwtZ2C/uTUQlNjAX5M9u+aRcmKHxgehvv+hSJu1aYRXM4jWL5f3PtaLTUCKfap+acM26V4cgvN7+o8FD8howEKxKuhxT4WjGBG1EE111wJ+fknK9SU+7J9GSaRNbd//hdXMGAE4y2TX+xLdt1ygvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327254; c=relaxed/simple;
	bh=OddzTRJ6KYhMHOsFtdHhKMp1e60oA1jkYdLPFeuLcyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c4uNPqSizUpQwD8mam9muDD+0hneQFx3NHocvy3fZbjouu5wp+0Egai6idSEuzYa7eQF8MBSJojLuFr847K7dGvZ2aoUWuqH6j/dJ8TBnpddvSb6d7mGcOl4oxNejuNKTt39VoTjDplWJOkqoSx1/rOUeK/sGNgonXyw3LmrNyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.Z-MS8cd_1724327227)
          by smtp.aliyun-inc.com;
          Thu, 22 Aug 2024 19:47:18 +0800
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
Subject: [PATCH net-next v3 0/2] Add driver for Motorcomm yt8821 2.5G ethernet phy
Date: Thu, 22 Aug 2024 04:46:59 -0700
Message-Id: <20240822114701.61967-1-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.25.1
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

 drivers/net/phy/motorcomm.c | 681 +++++++++++++++++++++++++++++++++++-
 1 file changed, 669 insertions(+), 12 deletions(-)

-- 
2.25.1


