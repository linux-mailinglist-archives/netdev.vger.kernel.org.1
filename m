Return-Path: <netdev+bounces-92650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7B68B830D
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6441F23A4B
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4F71C0DD1;
	Tue, 30 Apr 2024 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8kzJTBG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E701C0DC7
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520134; cv=none; b=qUESrbXSAAFmkYhaADx1nIuuGO3n9UsVz4hP3rFHTO6jiYyVxihmVLdjoJfXYGStDKGTfLW1tSuSIjE7V7oHnIK77G++2RpFMpQAWCAKcYu9DQn55GWUVaOvJSkdSiAvFwYj+fxtSm+uZoBBjJL5DjBDKjLXL3HWy2inBO6gn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520134; c=relaxed/simple;
	bh=nNgYk+Hrla2ptRJq0Zg2+g/EnAYzLRALG7lt4BI6WYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5NIti4oYIUXtEw2OAh4pAtDuTx+yMYWZckVlfX8bb7hbPAuHTjCp5QoW1Ij4jDCxA7PicYP1YLm3VKB6ASZCBXDkrxHWO4zdzV5xAkAafWALqfGPFaPNZrdcZmEn/QKVXRahniMXcBXJahOQtDb6lafwJgymFzRY0bsZoHIIbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8kzJTBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30CAC2BBFC;
	Tue, 30 Apr 2024 23:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714520134;
	bh=nNgYk+Hrla2ptRJq0Zg2+g/EnAYzLRALG7lt4BI6WYI=;
	h=From:To:Cc:Subject:Date:From;
	b=k8kzJTBGLT1DfySyV4G4cPXnzicUgR4RqKX9A2YUAdfzEeHxzA9kvHtKjQgKYYYLt
	 ADkgAtBhI/PYiY37umrBgFDSOs1ZucCJyRYCTIe0aA/SuDMP/huKAQXxuLLQ7GMRkf
	 /rMIVSnpJfdxZYinQdzDBcWmldvHll9zy+K8nlT1vARwAt8Q8Z81Gbv/2burHKsV6s
	 OkQR25q/RYzCexpBf4n1JyM8mxUVffvhQGDh7YUplj4m2y2FPebyGbh+g4grzVtd3J
	 sR95OqGA6SxeGOCmdZg6ac6wyPVYt3VeHcMPt4/1rFeVPd4zTVGmXqOveT+AdXN6Va
	 5+QCuN0ttGU+Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	christopher.lee@cspi.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: mark MYRICOM MYRI-10G as Orphan
Date: Tue, 30 Apr 2024 16:35:32 -0700
Message-ID: <20240430233532.1356982-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chris's email address bounces and lore hasn't seen an email
from anyone with his name for almost a decade.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c5e216e22766..fa7cf5807dc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15189,9 +15189,8 @@ F:	drivers/scsi/myrb.*
 F:	drivers/scsi/myrs.*
 
 MYRICOM MYRI-10G 10GbE DRIVER (MYRI10GE)
-M:	Chris Lee <christopher.lee@cspi.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Orphan
 W:	https://www.cspi.com/ethernet-products/support/downloads/
 F:	drivers/net/ethernet/myricom/myri10ge/
 
-- 
2.44.0


