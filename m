Return-Path: <netdev+bounces-98643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52FB8D1EF1
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA101F2307E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24AE16F82F;
	Tue, 28 May 2024 14:35:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924373475;
	Tue, 28 May 2024 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906954; cv=none; b=oXdTGc9OLKKyY+WfyoEj1Dj7JTSi1EAdWoxBmZXsQT62/ESEF/BRM11B94KP7o+SjDRjvUHqX5NuRj2gH62PXLOhyc3RWagJLXD+gnzZfPB1PBTj4dIX+vY5mxt/nN7o/BXCiJAM0KXBZRdI3sc9xfLA7Y2BRWh7N/PejjNzPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906954; c=relaxed/simple;
	bh=TcjJGgj/ZAn182/kwL2W+ibYc7LWR0ry8SN031CXI0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMyTS1xxaxuzBEafNPT5GkZj4oM2PycTQCa3rOnSmDVc/zKGejdevVvD8vJFrkC77MNw4gEtiawjJXuTLnGuWiE+KcCtVxA27zOWhiteGPI4kAOm0ZwsR/9vmILC3JKRGM/SEsMRwFdG97VGr+h4Jh+XR35QngDIzdBRnGljAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c07:2740:1619:be25:bafb:489])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 9517A7E0254;
	Tue, 28 May 2024 22:35:10 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: amadeus@jmu.edu.cn
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	johannes@sipsolutions.net,
	krzk+dt@kernel.org,
	netdev@vger.kernel.org,
	p.zabel@pengutronix.de,
	robh@kernel.org
Subject: [PATCH v2 0/1] dt-bindings: net: rfkill-gpio: document reset-gpios
Date: Tue, 28 May 2024 22:35:05 +0800
Message-Id: <20240528143505.1033662-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528143009.1033247-1-amadeus@jmu.edu.cn>
References: <20240528143009.1033247-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDH08fVkpKTxgaHUxPHklNTlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0xBSUxPS0FKTUpCQRkeSU5BGRodGUFPQ0JZV1kWGg8SFR0UWU
	FZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8fbfa0644603a2kunm9517a7e0254
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nz46CDo*NDNJCw1KF00SPjci
	OAkKCSFVSlVKTEpNQktNQkpKSU5DVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0xBSUxPS0FKTUpCQRkeSU5BGRodGUFPQ0JZV1kIAVlBSkpDSDcG

Changes in v2:
  Update commit message.
  Add new example for WWAN modem.

-- 
2.25.1


