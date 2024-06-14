Return-Path: <netdev+bounces-103523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B114C9086C3
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9F828200F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06570191498;
	Fri, 14 Jun 2024 08:51:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D871862AB;
	Fri, 14 Jun 2024 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355118; cv=none; b=GbMDKmaJglB3Yl1UkSxx1MqneUsBCekebspUdDm3B0gL8dlUJiC5AHw4aU6ARszBzD992XiETT47ah+n3YxxbJ29HKUmYOpURtCaGrkkEyRY7N4C6+FemZkuql/RXJ15pzaXliMsBHTr7DiB3RAE/vrdM1w2OUjvxRkBaGwuLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355118; c=relaxed/simple;
	bh=gFKMi3s/e8oMFghn3K8Wry1XOr6K09n48jOSof5nN04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T3qqlN9W+tdq+3r9UIyYuHX2Hm/lMETjA/83ktTjOTl95ZLbN2GJTZPJeGVS0eDEIgWuDe6XyRnHVHAZcNFfakbXtEKI1wJMGL6diGOkGEYi7IaLSWfkJ426Y30iTElxMm+UNmzbBE70oZYpqfqxP4StzQpvabZ6XPV/o5NU4+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D7D13201773;
	Fri, 14 Jun 2024 10:51:54 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 63161201743;
	Fri, 14 Jun 2024 10:51:54 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AAAFF180222A;
	Fri, 14 Jun 2024 16:51:51 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v4 0/2] Bluetooth: btnxpuart: Update firmware names
Date: Fri, 14 Jun 2024 14:19:39 +0530
Message-Id: <20240614084941.6832-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This patch series updates the BT firmware file names in BTNXPUART
driver, while maintaining backward compatibility by requesting old
firmware file name if new firmware file not found.

A new optional firmware-name device tree property has been added to help
override the firmware file names hardcoded in the driver.

This change is necessary as newer firmware releases will have
standardized naming convention aligned across all newer and legacy
chipsets.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Neeraj Sanjay Kale (2):
  dt-bindings: net: bluetooth: nxp: Add firmware-name property
  Bluetooth: btnxpuart: Update firmware names

 .../net/bluetooth/nxp,88w8987-bt.yaml         |  4 ++
 drivers/bluetooth/btnxpuart.c                 | 67 ++++++++++++++-----
 2 files changed, 54 insertions(+), 17 deletions(-)

-- 
2.34.1


