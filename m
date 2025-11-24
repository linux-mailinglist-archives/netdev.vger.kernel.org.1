Return-Path: <netdev+bounces-241116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4E6C7F6C1
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 09:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E3F3A62A6
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FB52F1FC3;
	Mon, 24 Nov 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngOTgT0b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A482EFDBF;
	Mon, 24 Nov 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974107; cv=none; b=LcSz7D8BZ15A3b9xI9GdPNwp623b7rsfPoo3MaSmdoeh6hBZwJr7DZ3L+k4WyXw5XOpSFC9QDyPrldTdUxXqep9CiLyuMrJKo8LM6abxb2KDg0o7/+Lvt4sSXfZ0K32dscws0Vtu36yWIcIHO7hGBxQ05xnGA3totKEoOMealuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974107; c=relaxed/simple;
	bh=MZ9Xkt07I8vhrJpfDzWnGEgNkwbTf/2C68251v3ZzsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7e36bCkDaaLR8q/5RHZpeR3CLN5jLl3pCRTLMv58Ezy6Izh5M4UZ0WL1u9g0Uv95M8GzrjOWILmioUhWE/h6OQ5rngywSpsIDg7VZv753DpcuPt0IA8sPTMgC3zfz0sPkgWWTdqauJAstDAw2wKobmT7Qt00Ef3sCVvJI9wKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngOTgT0b; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763974105; x=1795510105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MZ9Xkt07I8vhrJpfDzWnGEgNkwbTf/2C68251v3ZzsM=;
  b=ngOTgT0bUxJG4z9fTRqpTEDH6Og5287EiwsteJ18qbAw0ErEWru5dUeK
   9ISbtvEL8WW+w0npdGkcXnr/OXTBXjuSTt20pnHfjRT0TN/YMzR7DjNZk
   x7CSV3TaJRUNvloV128fdYp+xyJKfNV/lv7MYD/C+EQHkSSkL4d8h+Sh+
   t+e2NKDHPhPZCg3MDR+cQw4avmY+UC4xQKE1wqOjcI6wbaXIuREQNW6ha
   3EVctz5cCbhA/rleMz8pAVHNsaoo7Z06OThV9SRBy7AQ6S60NE/FNk701
   jL421prTydzLxGKUPR4JQxp/cN1cqDenyO20697K9AOQw6Zm8KR8mtcW6
   w==;
X-CSE-ConnectionGUID: bIjvclWoRVWtU6mcVeLlGg==
X-CSE-MsgGUID: Yloa1Bk/R3CrP/SEUd0ZSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="83583717"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="83583717"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 00:48:22 -0800
X-CSE-ConnectionGUID: 2eM2GYBZQY6D9xGpIega0A==
X-CSE-MsgGUID: qjbD/GX4TNGr2JFQ8fhIMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="192068188"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 24 Nov 2025 00:48:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id DD0F39B; Mon, 24 Nov 2025 09:48:17 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 4/4] ptp: ocp: Reuse META's PCI vendor ID
Date: Mon, 24 Nov 2025 09:45:48 +0100
Message-ID: <20251124084816.205035-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251124084816.205035-1-andriy.shevchenko@linux.intel.com>
References: <20251124084816.205035-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The META's PCI vendor ID is listed already in the pci_ids.h.
Reuse it here.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 63c73a5909f2..65fe05cac8c4 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -25,8 +25,7 @@
 #include <linux/crc16.h>
 #include <linux/dpll.h>
 
-#define PCI_VENDOR_ID_FACEBOOK			0x1d9b
-#define PCI_DEVICE_ID_FACEBOOK_TIMECARD		0x0400
+#define PCI_DEVICE_ID_META_TIMECARD		0x0400
 
 #define PCI_VENDOR_ID_CELESTICA			0x18d4
 #define PCI_DEVICE_ID_CELESTICA_TIMECARD	0x1008
@@ -1030,7 +1029,7 @@ static struct ocp_resource ocp_adva_resource[] = {
 };
 
 static const struct pci_device_id ptp_ocp_pcidev_id[] = {
-	{ PCI_DEVICE_DATA(FACEBOOK, TIMECARD, &ocp_fb_resource) },
+	{ PCI_DEVICE_DATA(META, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(OROLIA, ARTCARD, &ocp_art_resource) },
 	{ PCI_DEVICE_DATA(ADVA, TIMECARD, &ocp_adva_resource) },
-- 
2.50.1


