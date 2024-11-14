Return-Path: <netdev+bounces-144867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED22F9C8978
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F392815D6
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7161F9AA3;
	Thu, 14 Nov 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FBj5E0ZJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86B18BC2C;
	Thu, 14 Nov 2024 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585879; cv=none; b=j0PSSAoQW//odsARuoWioj/5oo45xZXa8uCWP7m+FijNOFzkOMHY6q+KRTeW9RvaBHXPZBVLQFI744azyjIOgVSZkssEaEQTo5OAVAKG+eqEsRy3ZWvdaTzfbdQ+waKKBZ3y/dLwXlhhGnF06G04SJCNgNwkB9Xzbzc+Tx+7SLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585879; c=relaxed/simple;
	bh=1+Oht9w0/FE5QsO5SJj/3YQM87Ar4+UOgH2AsGDK5/4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V7cQ+Bw9LJqITC8rpoYIG/xu4ZJ++Mv4HplxmoZFApF6M6mFFReM6ielhry5bC4rfRfhQ/kIVYyvt8tr7ccwL6oXKaow6yo6sIYEr1XIJllYbGR0CMNeJ+9v8QYUpbuFGGqqnoIgklnwytB2U++iXTctO/VBz0RnF4Fn3q254sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FBj5E0ZJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731585878; x=1763121878;
  h=from:to:subject:date:message-id:mime-version;
  bh=1+Oht9w0/FE5QsO5SJj/3YQM87Ar4+UOgH2AsGDK5/4=;
  b=FBj5E0ZJv9+37GtlfTlezMP/DtqsmFy2nlh+0LJP9bBJluFR6a46z/Wf
   6v2bAq+oA4zUzQK1vcK/E2WNd5Z7tSqFJp/s8F+5uQ++9JgKz+qiwzSMQ
   4WI9x3VoL/JZ1BNL1Ab6v8pMgxH3cPYmyTmqf778RQzpUN2snLpgxUC8k
   mgMsEVh+T9K51OFNoON10LDN3GAj3xB6f3fFI//BHPm1mrBE5kInTPyD3
   zW/tt/gpoaMBQOLptptdwubW+EzeUvKEVGjhZlNI0G/prK1ZKyM0S6NtT
   aY0I7qFgoAKIxFW8RvVCVArV2TM+4OrnR580PIMWWFsOKfHR7uZX3/sLr
   g==;
X-CSE-ConnectionGUID: zl8u+YR3TAunldWusYHTGA==
X-CSE-MsgGUID: WcQPf7jDSK6TXCGDuP7Tpg==
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="37842596"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2024 05:04:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Nov 2024 05:03:34 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 14 Nov 2024 05:03:30 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v4 0/5] Add ptp library for Microchip phys
Date: Thu, 14 Nov 2024 17:34:50 +0530
Message-ID: <20241114120455.5413-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds support of ptp library in Microchip phys

Divya Koppera (5):
  net: phy: microchip_ptp : Add header file for Microchip ptp library
  net: phy: microchip_ptp : Add ptp library for Microchip phys
  net: phy: Kconfig: Add ptp library support and 1588 optional flag in
    Microchip phys
  net: phy: Makefile: Add makefile support for ptp in Microchip phys
  net: phy: microchip_t1 : Add initialization of ptp for lan887x

 drivers/net/phy/Kconfig         |   9 +-
 drivers/net/phy/Makefile        |   1 +
 drivers/net/phy/microchip_ptp.c | 997 ++++++++++++++++++++++++++++++++
 drivers/net/phy/microchip_ptp.h | 216 +++++++
 drivers/net/phy/microchip_t1.c  |  40 +-
 5 files changed, 1259 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/phy/microchip_ptp.c
 create mode 100644 drivers/net/phy/microchip_ptp.h

-- 
2.17.1


