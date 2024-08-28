Return-Path: <netdev+bounces-122686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7A2962313
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291501C23EAD
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7171607B6;
	Wed, 28 Aug 2024 09:11:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B615A87B;
	Wed, 28 Aug 2024 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836267; cv=none; b=fYumptNZv/jqsbvefkaxGwGBwLigAdBoJwFTakbwx5xzNYsRGQFf6zdd0B1+LgqZLSaoCc7hLj4gLQzGKUmgcPHw2DXq/iIxkdAVtocW9+J2rPOYxcWiCY4VwUuHg1XxGipwWpBW7fPObMAVv5bO6dsXr7yA0ectPPZ1S6UKE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836267; c=relaxed/simple;
	bh=3fPFb4xaosvpvkadNW55xaKQpQyQAknzqWRoAkQOP3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ipUv8SgzjVVGR7vy0NYiCMwe6OLyL3XHP66koE/9jCNbasK7sBLSv2T4y2Fgu93GrvDp7gMGXoA/2L76u5dILT+q9CuGfp4ypYKln7kAuXkIYIwRlu//gPv65Wxjo6+g5Q7bhb4MDz9o4iRPksrErkbmGfdS8Z5BrIrKQa+C/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.Z4YaRMW_1724836252)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 17:10:55 +0800
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
Subject: [PATCH net-next v4 0/2] Add driver for Motorcomm yt8821 2.5G ethernet phy
Date: Wed, 28 Aug 2024 02:10:45 -0700
Message-Id: <20240828091047.6415-1-Frank.Sae@motor-comm.com>
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

 drivers/net/phy/motorcomm.c | 675 +++++++++++++++++++++++++++++++++++-
 1 file changed, 663 insertions(+), 12 deletions(-)

-- 
2.34.1


