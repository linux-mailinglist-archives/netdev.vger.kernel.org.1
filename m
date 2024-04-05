Return-Path: <netdev+bounces-85093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDBB89966B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 09:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D991C21298
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 07:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15B72E84E;
	Fri,  5 Apr 2024 07:21:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3052C1B8
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301670; cv=none; b=Oo9XFRXI+UuV5ikrpbTkgC0otLLbUZ41mRya2uYh4t+ApRsr9KMcwH/YRKqoRw6pOrNHauj/rmTIUGQAI8wsvamUg2T43PCjjGTAaxbhpdGXSfNH+8c8Wfuh2t9LOq96pj71Smw6zF33LlVv5YbrQM8w486kGAKFqNxJ43xkhGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301670; c=relaxed/simple;
	bh=rq0ub4HQWbS8WRYOtmnvbSqcOyc5iY6cPnnlDfYTMfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u73C8nwBIJPRedqF6Izc9fBhKeYs2WAO5iVwQUVnaxNMVJ4+SjPBmBELRIWYxNoBc6lagCA3Bc2O8attCa+fulSBiHcC9KpRNDOlZkaiaRkAtYJ1Yr24+IjunWb8NI8EwOtFTFEQI8xG+FNiJW6ld70rsHucc38/lnLy2B2SLA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsdsU-0002so-2H; Fri, 05 Apr 2024 09:20:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsdsS-00AWlk-VL; Fri, 05 Apr 2024 09:20:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsdsS-00FNeT-2q;
	Fri, 05 Apr 2024 09:20:44 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Li Yang <leoyang.li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Zhang Wei <zw@zh-kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] MAINTAINERS: Drop Li Yang as their email address stopped working
Date: Fri,  5 Apr 2024 09:20:41 +0200
Message-ID: <20240405072042.697182-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=rq0ub4HQWbS8WRYOtmnvbSqcOyc5iY6cPnnlDfYTMfY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmD6ZKkY6yppGrhNNyOtWlNH+4elKIHpdGAEr5v tStHRrc2RuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZg+mSgAKCRCPgPtYfRL+ TsouB/47cqGkwC5L5mRT5uk5aAdbTfA7NN4ZTXF31ggFYif4zOhNk8lB2NZ3sV+ZCEMsrhJGQ1W 0qiy1Ak+QnRSVm96815mssAhzxCJwRqoBjEutLPScymOxs+/UwHn+tCnFP1MtdXOXD06Ku2VBFW OsQZOiaIdqiCahqDK4m0l/AR1MkEmVRFO1o3rgBlYWZlUlKQiJpxXsVPEwHQuUyvnFnfBMARMpu lG6OI1Dz/hBSHifIc2YNmkmFPSpDoe3G0PQjzIfLBjCr1fuvsnNS1NIhwCSHG70iCJlU7rVqPap AznBlkkLLwJFbPSLW+liIiMfw+DCkSPQStmpHQkvMRB3no4r
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

When sending a patch to (among others) Li Yang the nxp MTA replied that
the address doesn't exist and so the mail couldn't be delivered. The
error code was 550, so at least technically that's not a temporal issue.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I added the affected maintainers and lists to Cc:, maybe someone there
knows if this issue is only temporal?

@Greg: Given that I noticed the non-existing address when sending an usb
patch, I suggest you care for application of this patch (iff it should
be applied now). If Li Yang disappeared indeed, I'd prefer to drop the
contact from MAINTAINERS early to not give wrong expectations to
contributors.

Best regards
Uwe

 MAINTAINERS | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..be19aad15045 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2191,7 +2191,6 @@ N:	mxs
 
 ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE
 M:	Shawn Guo <shawnguo@kernel.org>
-M:	Li Yang <leoyang.li@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
@@ -8523,7 +8522,6 @@ S:	Maintained
 F:	drivers/video/fbdev/fsl-diu-fb.*
 
 FREESCALE DMA DRIVER
-M:	Li Yang <leoyang.li@nxp.com>
 M:	Zhang Wei <zw@zh-kernel.org>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
@@ -8688,10 +8686,9 @@ F:	drivers/soc/fsl/qe/tsa.h
 F:	include/dt-bindings/soc/cpm1-fsl,tsa.h
 
 FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
-M:	Li Yang <leoyang.li@nxp.com>
 L:	netdev@vger.kernel.org
 L:	linuxppc-dev@lists.ozlabs.org
-S:	Maintained
+S:	Orphan
 F:	drivers/net/ethernet/freescale/ucc_geth*
 
 FREESCALE QUICC ENGINE UCC HDLC DRIVER
@@ -8708,10 +8705,9 @@ S:	Maintained
 F:	drivers/tty/serial/ucc_uart.c
 
 FREESCALE SOC DRIVERS
-M:	Li Yang <leoyang.li@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
 F:	Documentation/devicetree/bindings/soc/fsl/
 F:	drivers/soc/fsl/
@@ -8745,10 +8741,9 @@ F:	Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
 F:	sound/soc/fsl/fsl_qmc_audio.c
 
 FREESCALE USB PERIPHERAL DRIVERS
-M:	Li Yang <leoyang.li@nxp.com>
 L:	linux-usb@vger.kernel.org
 L:	linuxppc-dev@lists.ozlabs.org
-S:	Maintained
+S:	Orphan
 F:	drivers/usb/gadget/udc/fsl*
 
 FREESCALE USB PHY DRIVER

base-commit: c85af715cac0a951eea97393378e84bb49384734
-- 
2.43.0


