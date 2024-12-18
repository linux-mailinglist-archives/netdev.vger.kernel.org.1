Return-Path: <netdev+bounces-152789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7189F5C93
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67BD7A3123
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC1842048;
	Wed, 18 Dec 2024 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vfUdYyxV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1499D35949;
	Wed, 18 Dec 2024 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487387; cv=none; b=tJ+TBqnQ1H8n8UwTEGmwKSg4TYdSt3WyIdxZVhQFRml7iGbTic7CxLfjJfqmROGB18H1EkjI6kBRIU1p9IYWffHYM0dKn0/G99g3AEPWz0/SnIo5RRKYJdoRiWqiXbnkrDKr4xpuTFurS1BhZd077J6DIdKfBpEvy0ThI1z1auc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487387; c=relaxed/simple;
	bh=HAtYs3MF1wJUkdpO3eJfhaiHw6b5wiDYENS5w99Au6U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VAOAD7+qDg8NSvuS3/eBf68GdXdQKkkClXlTYZStLIhVFfQQsRnzbDYxAG+ZIehIAFQLWL49kCwuUQs3EZslq1qTYuEHelt9yr03IpVFSLDKYiilTslzLcLLgHLp4VEfv4Wr12Rspspfn8UtlzA1ROxVNupKeQzaj7wuZlNXXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vfUdYyxV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734487385; x=1766023385;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HAtYs3MF1wJUkdpO3eJfhaiHw6b5wiDYENS5w99Au6U=;
  b=vfUdYyxVZI3iKY+9Z2nf4nN4We3syEDPvGCam5o225pWTdmY2pB8AiB6
   LO9aQZcfMMJH9Xj/lM4xCJKEJ5IT/sMkW2bEIhoJTGrPM5FbN3dynaKvb
   m95rE3+7QST1RhVPCHFB20NauO/pdLQM26G52Wpgas88yXN/6rojxVeEu
   HHBzaqi5XzrFFcubnbVcQFEbs8PihZPWT5CqXO7ErE5o1Ze1x1WNOajGe
   JJo39Dica3GUHRyoNXfM2aVHTvNVMh8XgxM7+ZqvB0/ld1PdWAkB8hZI+
   fzraWZlug51O/Oq6u3wBCh/ydP6q+ucZWYpK0BKV0m9JZW02Zu4X4IFwu
   g==;
X-CSE-ConnectionGUID: ISTjjhv+RS2GzfsLd7mNTQ==
X-CSE-MsgGUID: 99bQNMvxRfaIOPiZi+Vu8A==
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="203135192"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2024 19:03:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Dec 2024 19:02:23 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 17 Dec 2024 19:02:23 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
	<arun.ramadoss@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net 0/2] net: dsa: microchip: Fix set_ageing_time function for KSZ9477 and LAN937X switches
Date: Tue, 17 Dec 2024 18:02:22 -0800
Message-ID: <20241218020224.70590-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The aging count is not a simple number that is broken into two parts and
programmed into 2 registers.  These patches correct the programming for
KSZ9477 and LAN937X switches.

Tristram Ha (2):
  net: dsa: microchip: Fix KSZ9477 set_ageing_time function
  net: dsa: microchip: Fix LAN937X set_ageing_time function

 drivers/net/dsa/microchip/ksz9477.c      | 47 +++++++++++++-----
 drivers/net/dsa/microchip/ksz9477_reg.h  |  4 +-
 drivers/net/dsa/microchip/lan937x_main.c | 62 ++++++++++++++++++++++--
 drivers/net/dsa/microchip/lan937x_reg.h  |  9 ++--
 4 files changed, 102 insertions(+), 20 deletions(-)

-- 
2.34.1


