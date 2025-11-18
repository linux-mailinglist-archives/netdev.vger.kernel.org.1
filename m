Return-Path: <netdev+bounces-239567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06532C69CA4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 182ED3526D4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5944E35F8C1;
	Tue, 18 Nov 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="C5PA66UR"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3935B125;
	Tue, 18 Nov 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474353; cv=none; b=C+8azI59Y6Bj5cjfDWG3No1E+d3E0ww8liuGwMDmeWER7eqU3rlvEyG0QYk40+nTq4CaXDSjmfsXdBT4u04CgN+7nzgyVEQ44y4lQolj2p7e/2Uf4cygHtKh/sXrNoPnkzr6MAgOXpufRf7sJ45GQIK3C9hjaRVc3RixUAd2kJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474353; c=relaxed/simple;
	bh=/kfyfjuQ5n0IH/aYEemxpYHUmdsZlDBfDSs5LLqcHqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qq6fPvNPYs3z/LOQeQQiuV6k8oGXAfDfRR4pX1S10hDY9cTkFJSgpwYZ+sAEM7IsNrmUJVqkNk1olVrc71x/RTG94Fz69icEW3WVtj2Gibni4jK2ermOBNSkU1P+jiZDzQzbrOM68hC4micTPRg165aYPwma7FlVZSqPS0Ylm+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=C5PA66UR; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B3849A0AF4;
	Tue, 18 Nov 2025 14:58:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=gN2mY/hU1/7FlAUcf4fk0TAUShm1I90RcvBTt7uJC6g=; b=
	C5PA66URIGzu0hBicZa6CwAlmRw7eShlCi3aYhUnxrMswUP62piep3KpnnwdEE24
	7AEtRa31uUiYJcH0W4Fdh96PEoWJY2/p0DVbQ5ZLTi4YEJcgVQkjOyV7B7nS2S7j
	WW5yqLERoyKvKa+aF8MNBusR+f2VXM0S3tsuv/6KuzVTn86fy/7CEvxcq9NZztE+
	XeNQYC27BQ4u2hmofBR/EfsdgD3uBW2mKpCli8LVxoZ2LD640XiDcub6iHp1S1/D
	Sz/f+BwsP7Qwwul2boFmXA3Y+VXiS3R4wtO2A6w/gm0qxqbqzmaKXzuB2c1CRjTa
	vfawa+jeH/O84kMNWg2Xim+KfXjEg88Ryizzihmy7q8Nqf33W7I7frcIzmmNM+/D
	6obAgmCPiJc7EuwHwoTYBgD7sCXEJt09rnt81MmzdkONWlyc27l5jg6OV00s4X3Y
	fJCYypjSWvnoFTkfL6Ryvt6oWrFHLucUgm1giT4rIRDmKOA10j7Q5rShfdpe27gk
	B5Dcu4Lcc2jW4cOiviXW460sB7q5d76EWpY57RRkHlJhmLGclciNSH5esZ3Iyhrx
	9VrJVlpsrg1b2x81dZmWagLiXDpzCum33FYpl29Z3BamKJV1zXIl1N4Pv9xH/NNH
	plA57vBNRl2DHSP6y74zCuPA1jVtBzZX5/8TBB5zA58=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v3 0/3] net: mdio: improve reset handling of mdio devices
Date: Tue, 18 Nov 2025 14:58:51 +0100
Message-ID: <cover.1763473655.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763474336;VERSION=8002;MC=2401629834;ID=69548;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F617266

This patchset refactors and slightly improves the reset handling of
`mdio_device`.

The patches were split from a larger series, discussed previously in the
links below.

The difference between v2 and v3, is that the helper function declarations
have been moved to a new header file: drivers/net/phy/mdio-private.h
See links for the previous versions, and for the now separate leak fix.

Link: https://lore.kernel.org/all/cover.1761732347.git.buday.csaba@prolan.hu/
Link: https://lore.kernel.org/all/cover.1761909948.git.buday.csaba@prolan.hu/
Link: https://lore.kernel.org/all/4b419377f8dd7d2f63f919d0f74a336c734f8fff.1762584481.git.buday.csaba@prolan.hu/
Link: https://lore.kernel.org/all/cover.1763371003.git.buday.csaba@prolan.hu/

Buday Csaba (3):
  net: mdio: move device reset functions to mdio_device.c
  net: mdio: common handling of phy device reset properties
  net: mdio: improve reset handling in mdio_device.c

 drivers/net/mdio/fwnode_mdio.c |  5 ----
 drivers/net/phy/mdio-private.h | 11 +++++++
 drivers/net/phy/mdio_bus.c     | 40 ++-----------------------
 drivers/net/phy/mdio_device.c  | 54 ++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 42 deletions(-)
 create mode 100644 drivers/net/phy/mdio-private.h


base-commit: c9dfb92de0738eb7fe6a591ad1642333793e8b6e
-- 
2.39.5



