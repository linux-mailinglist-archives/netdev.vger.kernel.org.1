Return-Path: <netdev+bounces-86421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0F089EC2E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22D21F2255F
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528713D2B1;
	Wed, 10 Apr 2024 07:35:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15713D2A0
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734506; cv=none; b=p5M4BRHQbWs54G2SqevHKkSntvSo5A7Jw4sVU3ZcYSsuDCUbmuR/q0O9wr1DNZMmSXCS3CZ9ueXG74MTYEbCONzwTbpWou4Z9wamKpJFqLe1ZIBddMZ0+6qqZc1WIvOGAvyReksFyy0k9+DafVGTnfdmMwmZc0pTLrmO7me/5S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734506; c=relaxed/simple;
	bh=gROKBkMa0ThexFE+zSeTQYHlPSPQGkYJ0/VJWbgMt9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sDnVlsrkrwZF/WrTiKjJA7fudlQN1URQn5B8tt/ncdvIcK9BpCJhoZV+324Ra5jyVUgMsD5Bm0D3D4i/8VgrEcawTPAIs426Wwt1vPw41AHt8XVUCpPWWq6hWwpV/UKTZd+AUSpz8K4VN4xbf5nZ3Y/Nufb2uCz8mPQQxTi8yDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00041S-OD; Wed, 10 Apr 2024 09:35:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00BS0z-13; Wed, 10 Apr 2024 09:35:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU1-00HQ6I-33;
	Wed, 10 Apr 2024 09:35:01 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de,
	Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH net-next 0/5] ptp: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 09:34:49 +0200
Message-ID: <cover.1712734365.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=gROKBkMa0ThexFE+zSeTQYHlPSPQGkYJ0/VJWbgMt9I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFkEa1OENiFx3nu3eIywrBneG2+nWTwfDrc5Qz SNKv/XkO2GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhZBGgAKCRCPgPtYfRL+ TmJiB/0WWoW2e67iiVO9cK3kw/sDxwxxlOpVKYnb2HMXlfqOYuNGDj9hf7HfPCD8M6iPnrhP5M7 MzZCn64Y1HJ52bsOH7zfEFgCZbaLLfRU7l8FMPRIdV07/9B/hzFzxWQOFz4RhLRhEn8LgRfkAYu o6zi8fKVnDTeIRV6pEYboILneMEVmpZ/jYR7EMwsA2tp+KtzNqNALEI24bP6EI3d6Hp215yoo8/ 41z2MpchYKLahBowqLoMN0GPysiSn1WDvnNbPu9iIPXF3spjFy+L7PGKEw8fQmus8MduP+gw0We 9zxHCEyWPhe3bVVp85daYU5ytNgWW1dBP1/SSrYP9QIFmklU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/ptp/ to not use
struct platform_device::remove() any more. See commit 5c5a7680e67b
("platform: Provide a remove callback that returns no value") for an
extended explanation and the eventual goal.

All conversations are trivial, because the driver's .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches, so they can be
applied independently if needed. This is merge window material.

Best regards
Uwe

Uwe Kleine-König (5):
  ptp: ptp_clockmatrix: Convert to platform remove callback returning
    void
  ptp: ptp_dte: Convert to platform remove callback returning void
  ptp: ptp_idt82p33: Convert to platform remove callback returning void
  ptp: ptp_ines: Convert to platform remove callback returning void
  ptp: ptp_qoriq: Convert to platform remove callback returning void

 drivers/ptp/ptp_clockmatrix.c | 6 ++----
 drivers/ptp/ptp_dte.c         | 6 ++----
 drivers/ptp/ptp_idt82p33.c    | 6 ++----
 drivers/ptp/ptp_ines.c        | 5 ++---
 drivers/ptp/ptp_qoriq.c       | 5 ++---
 5 files changed, 10 insertions(+), 18 deletions(-)

base-commit: 6ebf211bb11dfc004a2ff73a9de5386fa309c430
-- 
2.43.0


