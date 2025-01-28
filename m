Return-Path: <netdev+bounces-161252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9AA20359
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 04:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59021886F82
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 03:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A41DA4E;
	Tue, 28 Jan 2025 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zRrHcH3N"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8586AA7;
	Tue, 28 Jan 2025 03:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738035179; cv=none; b=ICV0Dj4ClqYU7kusrwVBtc7HGNQ1PTH/SAUZISM9/40DHrW4SIuebEZsT/DnFq9lQr6ehelb8DZP66jbHmf4yZhEknj9Kc2glCxs3u3GymbTtuTQ6PO6VJwQEY9zdGQ8JSIbBk6TXwIcUf4oViHiVhtLNX2nK+NRzB3LYyIN6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738035179; c=relaxed/simple;
	bh=SMnbSJ/GwFixCB+O/WJHKlJaqhfQ9qXsQyOSgWcVtbM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e1QqW66PLzxxObH9yxM8ZS7Xh1Op4k3gp1p8c5SXA2KFURyP8q6nc1Htmt3l+MC5HqRKNxizmHZ8mABljd0aYNmZS9tinv9v/iOunN71ElGmgh5hNeZ/FhGuXyyJvlvMOH3qIuY8gokimWkq0sZr9lqwQ+PSeg48a7ll6yMQmU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zRrHcH3N; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738035177; x=1769571177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SMnbSJ/GwFixCB+O/WJHKlJaqhfQ9qXsQyOSgWcVtbM=;
  b=zRrHcH3NVVa7qObKdjsxrmUSdvIonNpkFW2/IDu9gJbPPf99e/H9HcMe
   r78H+BhFaY/4YNeuR4j9T0HnVJYoB2yN8hkLGn2ushPSIhel4I8Gtxkng
   dfUEAAphLLN3ask96fjCkwsUvJ3V1nLdesVCqJT4qQF8E8/p7L+Hyo9Df
   hsdthiCdI6Ah9ruomBvb554tk1dBEE+FXs7TAjAZ70cLv6VNjGoq5uGTt
   A5QiDNtexq/V1I0Cko5HWRLrzAgFLz0fnqbgT8lpylWkC9qobM3MyKW+Q
   8uhu6jhWAbmZQw9piPSFERPadUoliYY/FkT/AM6t4bquUX9nxQI10Lz1Y
   A==;
X-CSE-ConnectionGUID: YiGSDTCPSFu7LwZMtoWv2g==
X-CSE-MsgGUID: 0pe3QvznSw+oQtZ7+w0ojg==
X-IronPort-AV: E=Sophos;i="6.13,240,1732604400"; 
   d="scan'208";a="204506388"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2025 20:32:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 Jan 2025 20:32:15 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 27 Jan 2025 20:32:14 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH RFC net-next 0/2] Add SGMII port support to KSZ9477 switch
Date: Mon, 27 Jan 2025 19:32:24 -0800
Message-ID: <20250128033226.70866-1-Tristram.Ha@microchip.com>
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

This patch is to add SGMII port support to KSZ9477 switch.  It was
recommended to use the XPCS driver in the kernel as the SGMII
implementation uses Synopsys DesignWare IP.  However, that driver does
not work for KSZ9477 in some cases, so it is necessary to modify that
driver.

As there is no way to know whether the new code breaks other
implementations a new field is added to differentiate the new KSZ9477
specific code.  If in future the new code is tested to be compatible
then it can be updated.

Because of that it will require somebody to verify the new code in
different DesignWare implementations.

Tristram Ha (2):
  net: pcs: xpcs: Add special code to operate in Microchip KSZ9477
    switch
  net: dsa: microchip: Add SGMII port support to KSZ9477 switch

 drivers/net/dsa/microchip/ksz9477.c    | 116 ++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h    |   4 +-
 drivers/net/dsa/microchip/ksz_common.c |  37 +++++++-
 drivers/net/dsa/microchip/ksz_common.h |  23 ++++-
 drivers/net/pcs/pcs-xpcs.c             |  52 ++++++++++-
 drivers/net/pcs/pcs-xpcs.h             |   2 +
 include/linux/pcs/pcs-xpcs.h           |   6 ++
 7 files changed, 231 insertions(+), 9 deletions(-)

-- 
2.34.1


