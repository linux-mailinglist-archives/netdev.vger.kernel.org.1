Return-Path: <netdev+bounces-119114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ADB954183
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812AF286A03
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD3975817;
	Fri, 16 Aug 2024 06:10:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93981741;
	Fri, 16 Aug 2024 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788621; cv=none; b=URCY78xlmqpzdXC5M20CzHDNaCZHkxxwoiEN2p9uV3Ty0zdYacGldR+D4/CXGB3pErHXa+H/x8jhOk33ug4NvPGQVPZAZTHv/zDl8aHfxi8GsMuudA8Qlh4G8VglQYZ6cS1I0pjyD6QgQ+85CZtdmrJI9Ikp+Y8+VFUfFZsshnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788621; c=relaxed/simple;
	bh=WCZ0VPZmzft7dgXDPQZ/7MWqy5F2cmcms4XEO5DF0Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iemjkgLgOd8Bbuvgcdx2jPwfMsZYJd0tj7C2CQEqwqWQGUDHuMB5mw8sIiYQt/o5ZjMLlcFkC8QKCh7e04eMH7BGOCmYyANbjUx9OzoyvGEa03WUmX6bPAdOuZ0CowxYYv7G5z/tPceaQ19O3/dHaQpQteanC2uD/7t88aAQxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.YtTOKJz_1723788598)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 14:10:11 +0800
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
Subject: [PATCH net-next v2 0/2] Add driver for Motorcomm yt8821 2.5G ethernet phy
Date: Thu, 15 Aug 2024 23:09:53 -0700
Message-Id: <20240816060955.47076-1-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

yt8521 and yt8531s as Gigabit transiver use bit15:14(bit9 reserved default
0) as phy speed mask, yt8821 as 2.5G transiver uses bit9 bit15:14 as phy
speed mask.

Be compatible to yt8821, reform phy speed mask and phy speed macro.

Based on update above, add yt8821 2.5G phy driver.

Frank Sae (2):
  net: phy: Optimize phy speed mask to be compatible to yt8821
  net: phy: Add driver for Motorcomm yt8821 2.5G ethernet phy

 drivers/net/phy/motorcomm.c | 693 +++++++++++++++++++++++++++++++++++-
 1 file changed, 681 insertions(+), 12 deletions(-)

-- 
2.25.1


