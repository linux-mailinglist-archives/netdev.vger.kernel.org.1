Return-Path: <netdev+bounces-199561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABB5AE0B57
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 18:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AD61BC7208
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A281E28BA82;
	Thu, 19 Jun 2025 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a6M1Y00M"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3DA28A72D;
	Thu, 19 Jun 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750350387; cv=none; b=kA50Ot3xOmMa1QAvd6dHj1SsL12x49PUatzWAWUMA6g1+SoYh6V1RSA1BZW0y+ATdnfwxKUrfrGxRmdTByNLiiEOG4Iis7BEmbGv558+s5gPFHXqTNvduySHIgTTOIoSP4ge/p+fI0j5MMg/2KRlOWPtSUI8ZF3N5TkrFXFN9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750350387; c=relaxed/simple;
	bh=YW1WRtOgjjKeZYoFpv7wK+mazkH76ZKwJg9fzRFuC5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=doftRYf/2mjK2FmFWFvbMJotwI8wltbfxPEAEpmi+nHJUsBoWuvEiqIrnni9G39VhuLbLpEoviUQkRS25EdNZJ8lHDY3FRXKb8kK0igNogr/6HxiQOHEu/h5b2rGGB1IXNdirdiE7NyGbd2nRoh5Kss5foK1pO5ticcwTV6f3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a6M1Y00M; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D5211FD32;
	Thu, 19 Jun 2025 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750350376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AyfZRBcndJNymTCun1FzXaI9H1cKammKl6UraztpG8E=;
	b=a6M1Y00M/vorSU8AoR+SinbMnXrby7rSrDc1gIRp/XvYOQU8V+Q5YJqSnUNLVhQ64HrGn0
	Xew0RWTOdCV3tPIUlS09V908Br3jehGuY5l9IoGHH9Se63DlhOQ/23PlHv9WXQ9VDTAhFL
	vyBhrHzHMYNiyL8gTScMtMngawumi8s5T9PmrJnLNDeREvKzXw8fVMhXGxSgDcZSk9FKXl
	LVQG0yMucqtTw9Fp9DqrhsOW9s9QqH4CxQvQiMcM8zoU6pMu2VeBKapL/y3cZPSs+n3q9s
	t5W/WO+BDARF5gkvtP0iDz41laTe0VTPK7Yv73MovfJduR16C6mJbNemiFWJ/Q==
From: Kory Maincent <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	kernel test robot <lkp@intel.com>,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] ethtool: pse-pd: Add missing linux/export.h include
Date: Thu, 19 Jun 2025 18:25:47 +0200
Message-ID: <20250619162547.1989468-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheplefhhefhgeevtedutdekudegjedvhffffefhhfdtgfefteduvdehgeetgedtvdelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddrrddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdpr
 hgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

Fix missing linux/export.h header include in net/ethtool/pse-pd.c to resolve
build warning reported by the kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506200024.T3O0FWeR-lkp@intel.com/
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 net/ethtool/pse-pd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 6c536dfe52da..24def9c9dd54 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -11,6 +11,7 @@
 #include "netlink.h"
 #include <linux/ethtool_netlink.h>
 #include <linux/ethtool.h>
+#include <linux/export.h>
 #include <linux/phy.h>
 
 struct pse_req_info {
-- 
2.43.0


