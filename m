Return-Path: <netdev+bounces-85121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ACF8998C0
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 11:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513D81C211B8
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 09:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE10A15FA94;
	Fri,  5 Apr 2024 09:01:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493F13D290;
	Fri,  5 Apr 2024 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307702; cv=none; b=NcZSwXFMJaNib9xJCFf6fao2jODsQkX7LWrzTtQphzlilzZanmjeSCKSbNufXsxGFhWubt2pso0spuT5vGH9WVGOCDs1GHeh8LSH7YfiiPZMdXaVQdDS3pKgH/6L+a+MBfZs1VRMLiRp+mgeFocJU9RQXwnKX/uLDCQ3HiJp0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307702; c=relaxed/simple;
	bh=Arbd1dU+oKhXEOc9cMwtiEtnyOFvgRBXk0QGc+5f+Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CvEL1/oYTAdn8+TMKF9yjZVdBzlbNAz9hD5ftRYAZcpBWuDOtmTcjcR8Fky4ybfC8IzzjuZp9HAV4yHhb3rToL3aYiPuelgBP66ZfBnS22zT6CRFqt1z8eoCQhVjOAf+kfC+7n6KuIvHq3HgE1D1hf88yGdx1Y/+ENopOEacusk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9830F2018F8;
	Fri,  5 Apr 2024 11:01:33 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 363DF2018DF;
	Fri,  5 Apr 2024 11:01:33 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1A288181D0E4;
	Fri,  5 Apr 2024 17:01:31 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
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
Subject: [PATCH v1 0/2] Bluetooth: btnxpuart: Update firmware names
Date: Fri,  5 Apr 2024 14:31:16 +0530
Message-Id: <20240405090118.582310-1-neeraj.sanjaykale@nxp.com>
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
  dt-bindings: net: bluetooth: btnxpuart: Add firmware-name property
  Bluetooth: btnxpuart: Update firmware names

 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml       |  8 ++++++++
 drivers/bluetooth/btnxpuart.c                        | 12 +++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.34.1


