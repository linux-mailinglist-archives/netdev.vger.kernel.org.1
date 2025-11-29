Return-Path: <netdev+bounces-242705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FF4C93DCE
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 13:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF2A3A732E
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 12:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13592E7621;
	Sat, 29 Nov 2025 12:51:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E4224B0D
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764420679; cv=none; b=CHfyn8zLG1UvvDl7gCX5/FLJ8lXgyBJ6MduqCzyRbXdzD+d4umr2rBP2K55IW6sXg4+j9iKei1oAV+xIuDafjKImWf84pNkLVsGf4hbCa66KnYFCnjyNusrQ7xFc7sWz7O80GTSOjL+NktfFLDnUXEwvppiFXZB700V8adZZQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764420679; c=relaxed/simple;
	bh=Br1PUhhCGZwVAJyARzUtSoJjIuARDeAWz6+3V7hfIRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYnfEVSlCqegSRqPRAx5i37cDXD0RQQxnmXHH/xKP4CFtHAkv6VwM/mx/zbZ2gbKj+1FPUBvhejse99+DQP4wYHpLXf/3/hdu1SC/2a1z62HCAt0+gK7gPlYf/s0DyR6LBfIgRbNKCO6068Z58+K74iHMVtB/KBAiD5TIy3QnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vPKPn-0006Qm-Gm; Sat, 29 Nov 2025 13:51:03 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vPKPm-0037TO-0l;
	Sat, 29 Nov 2025 13:51:02 +0100
Received: from blackshift.org (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 55FB04AAB46;
	Sat, 29 Nov 2025 12:50:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/1] pull-request: can-next 2025-11-29
Date: Sat, 29 Nov 2025 13:47:18 +0100
Message-ID: <20251129125036.467177-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hello netdev-team,

this is a pull request of 1 patch for net-next/main.

The patch is by Oliver Hartkopp and fixes the compilation of the
CAN_RAW protocol if the CAN driver infrastructure is not enabled.

This problem was introduced in the current development cycle of
net-next.

regards,
Marc

---

The following changes since commit ff736a286116d462a4067ba258fa351bc0b4ed80:

  net: ipconfig: Replace strncpy with strscpy in ic_proto_name (2025-11-28 20:19:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.19-20251129

for you to fetch changes up to cb2dc6d2869a4fb7ef8d792a81a74bc6f0958a72:

  can: Kconfig: select CAN driver infrastructure by default (2025-11-29 13:37:12 +0100)

----------------------------------------------------------------
linux-can-next-for-6.19-20251129

----------------------------------------------------------------
Oliver Hartkopp (1):
      can: Kconfig: select CAN driver infrastructure by default

 include/linux/can/dev.h | 7 +++++++
 net/can/Kconfig         | 1 +
 2 files changed, 8 insertions(+)

