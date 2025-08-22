Return-Path: <netdev+bounces-215979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ABEB313A3
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B204B016C2
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46CC2F3C37;
	Fri, 22 Aug 2025 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aKEa4vT5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40732EF65A
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855083; cv=none; b=o1tvYZ19QqQQMymDyzq4zu+a0CStp2Oq2PEuSbdhrYVscR77rUuMO44QmUXRz2LsWwgklgDKHOxx3oTCAEYXGCu5alIz3gtLKPyCUx5dJExTpyWITH22LYgOzUg+qCjoxX2Dka/ckJBfSe3UDtJlZL2uQgefHlnvxApWilUOkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855083; c=relaxed/simple;
	bh=N3NJ5tDeDCi3vhISESZJkIN7qYp9IUb8LelWUgmInQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ICIf+1xcWg5iNASjiwCSAnH/0hE3qP+/ts2xSNN5fv6vTMvRYxNg8EXhzRzH9z43W0BTGyh48I882Zv/kG2VVFdGPKmhWiJflDzeu4RMK3ZU5L/53YJT2jOqmK2n4Cel6zzdFLAUuSU1NHM63AhH9bZqbwFAj0619d8cuPdJ2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aKEa4vT5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755855074; x=1787391074;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N3NJ5tDeDCi3vhISESZJkIN7qYp9IUb8LelWUgmInQM=;
  b=aKEa4vT5x5FxUUBuuYnhZANZsb0BjpfdtEA4Spj9jKWLOTkcg8USRJ0J
   7mGXC0eOU4koS2yJY2g+1n90UiyaJSIn0hXLZ7W/XDT7nmd7Ov2Gi1J5v
   Im+PSk19/a5J9pl/0YYCd1JDrct7ShUhUZlmE/d42uQid8egNnJcpmWLy
   OXcKM4RLHIA48dzsOjf8es5OugQ6Lbf2ctfITNUjgz4tx4j45VpormeCT
   3HhDXb7fvLk3n466jzXqhIyc644PUGlo1JhcJvqShnvkotxlYSGV6frS0
   w1ah2P2GpFj4YznSucOYxMpx5XZx1kni+4yvcCoTiUQtBljuFD38XL1bd
   w==;
X-CSE-ConnectionGUID: TnN8egzkSSO68KFi/UIkZw==
X-CSE-MsgGUID: SDJ+zHwnRWmAKjcc0kjqKQ==
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="212950473"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2025 02:31:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 22 Aug 2025 02:30:44 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 22 Aug 2025 02:30:42 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next 0/2] net: phy: micrel: Add PTP support for lan8842
Date: Fri, 22 Aug 2025 11:27:12 +0200
Message-ID: <20250822092714.2554262-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The PTP block in lan8842 is the same as lan8814 so reuse all these
functions.  The first patch of the series just does cosmetic changes such
that lan8842 can reuse the function lan8814_ptp_probe. There should not be
any functional changes here. While the second patch adds the PTP support
to lan8842.

Horatiu Vultur (2):
  net: phy: micrel: Introduce function __lan8814_ptp_probe_once
  net: phy: micrel: Add PTP support for lan8842

 drivers/net/phy/micrel.c | 107 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 5 deletions(-)

-- 
2.34.1


