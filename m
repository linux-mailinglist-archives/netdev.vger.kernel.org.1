Return-Path: <netdev+bounces-216400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D1B33693
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765EF2023CD
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37130283FDB;
	Mon, 25 Aug 2025 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N0PvfNjG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE72283FD9;
	Mon, 25 Aug 2025 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756103927; cv=none; b=tHENHI670epTKqMZfao6NymAs538s2oUTs7ejO9ojmA5zf+A29XsQHHw1qj1ALx1adrV9nbAk83uJa0WA8vFPBCEl4MrKR6rBgTMSgRE3YnJtTOXyuFMGwIEk9L3rHZ9ZP8OELN9RJkAbcjPMOvaYwy6QQbtnhcEVqIO0webjVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756103927; c=relaxed/simple;
	bh=3tGtu8VNlLJFicxBfQA5qSZT4Z7vtCq0urWfwZk/tD0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YOgsSmNfUxMgt3wdeR9rffXmKVtjmku5Gnc+SELai2TGTosplM+/ZTipSsICjO9RrlPisnx7htc/SYQvhruqIO0MCJZMzhMJlHDvv3nO4QKMrPPP7pG2cuQUxJbUOpb6YToquTSmAO0QmIt+xhXHw/iHZ1r1hh+POWR9CqNTvos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N0PvfNjG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756103926; x=1787639926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3tGtu8VNlLJFicxBfQA5qSZT4Z7vtCq0urWfwZk/tD0=;
  b=N0PvfNjGFGW5vWbhGCSobHByemcBOM/IqIM+yn2Dqe3d8vGzdy7n1XQi
   n75nBSxxHGvzCEg6/i3e4AvDAwwUA08j9VMVj+2ucWv+b37TZECVllODF
   1vKUXEBiSROwY+uSaT7j4/zb6RqnaC9auUHlqLzHZXufZSV38eeeKYQrU
   hM0uycP05cjqlWhmVhBJDg2pKaVS5vjbU6CZwe9YBkaq2W8FMpfMLtRoC
   lUnLtb9ApKXhCUr/Iz3hjSP5X0WJvtXnENNDR7UeGJBVodiDQACLtAnsg
   2I+EpV61V0chdWuCNLHbheYTYxtO9x4rxZQpgdTRMoKSVuS/DWyXmZKkf
   A==;
X-CSE-ConnectionGUID: S3yVFIolTS6rQW1/Z9824Q==
X-CSE-MsgGUID: MRhdVPd+QqeoQzMBjRclDQ==
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="276991584"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2025 23:38:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 24 Aug 2025 23:38:16 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sun, 24 Aug 2025 23:38:14 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 0/2] net: phy: micrel: Add PTP support for lan8842
Date: Mon, 25 Aug 2025 08:31:34 +0200
Message-ID: <20250825063136.2884640-1-horatiu.vultur@microchip.com>
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

v1->v2:
- use reverse x-mas notation
- replace hardcoded value with define

Horatiu Vultur (2):
  net: phy: micrel: Introduce function __lan8814_ptp_probe_once
  net: phy: micrel: Add PTP support for lan8842

 drivers/net/phy/micrel.c | 111 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 5 deletions(-)

-- 
2.34.1


