Return-Path: <netdev+bounces-98961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DDD8D33BF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3AF1C21B8D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362716E89A;
	Wed, 29 May 2024 09:55:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7E16A379;
	Wed, 29 May 2024 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976559; cv=none; b=twTeqToEHl9gfn2UWQokaXOvw2bZD0HKkz9HV1lKTQFA77Qf3R1RUB84VyjFR1rGrqxQBmqZrzqWI56lpdSQwW3CovqupD9R6lLtqHUvmmzCRXouzi/eAAygfApfhIUVcAjX/J5jEUfUY2cEZLDCNg9TJB09VaaTSAOD6y99fC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976559; c=relaxed/simple;
	bh=aDoySUW0f6x8n5i6pbvRD7e32dK1WDjQkjJh3ud7g7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EQU6Szn6YtRt1IMBWrGMqqvXUEPMc+RSXwS7vgyPZ16+bT4uz6OcR9n5PRCSB7vM/ugvdiN0Kx9ZKEn/JI6pIvI9c7X+ZUf6+h4Xk6DCE6qWvw24MLAKiMn3jWVXAkYv2NUUhUmWdsBS4IZZmxTJY6ItAGSGavh/fD3RoJdd634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D170D1A15AB;
	Wed, 29 May 2024 11:55:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8111B1A13BE;
	Wed, 29 May 2024 11:55:55 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3D05B180222F;
	Wed, 29 May 2024 17:55:53 +0800 (+08)
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
Subject: [PATCH v3 0/2] Bluetooth: btnxpuart: Update firmware names
Date: Wed, 29 May 2024 15:23:45 +0530
Message-Id: <20240529095347.22186-1-neeraj.sanjaykale@nxp.com>
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
driver, and adds a new optional firmware-name device tree property to
override the firmware file names hardcoded in the driver. This will
allow user to continue using the older firmware files.

This change is necessary as newer firmware releases will have
standardized naming convention aligned across all newer and legacy
chipsets.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Neeraj Sanjay Kale (2):
  dt-bindings: net: bluetooth: nxp: Add firmware-name property
  Bluetooth: btnxpuart: Update firmware names

 .../net/bluetooth/nxp,88w8987-bt.yaml         |  4 +++
 drivers/bluetooth/btnxpuart.c                 | 28 +++++++++++--------
 2 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.34.1


