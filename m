Return-Path: <netdev+bounces-229263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBE9BD9EE2
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F37D502D49
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3EC315D47;
	Tue, 14 Oct 2025 14:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF21314D1F
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451034; cv=none; b=r7hRkiGWJk+BaRzIHTUBSpOVWT+FJbgsQs0UoK+jqm+5DYe5qlrAbxc5swxqp1P99MQVtlZgPVNghROUqqixdGaYh1dDbmNBfwv3xkk32EVsH2UeArkCvk+YYTVv7jU5J0W6c2GBOzeP65NPR/aRneUj4ZoMtcMxaHuSuGkpiP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451034; c=relaxed/simple;
	bh=WKHVSqC33oDJZ1LHGZ1FtHI86lXopX31clBfEzUHW1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9nd70+Qqr/sFvfIsvbAfpTImyXzRf/8CVttuWKH47/2a6xfG3NDdKuXR+FIGU06bh/qiSW+uIKwUtOvT5EWYX8QSNz+sfHEkQd6WBUhs4qgTmvU5VEWFXkAIr31yIdnB+gCtMXc/qv94LMCiw51oOcGf2foO/WWAESu0lO67Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8fjK-0008IM-UN; Tue, 14 Oct 2025 16:10:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8fjK-003ZQA-2B;
	Tue, 14 Oct 2025 16:10:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5F9E6485F1C;
	Tue, 14 Oct 2025 14:10:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 08/10] can: remove false statement about 1:1 mapping between DLC and length
Date: Tue, 14 Oct 2025 14:17:55 +0200
Message-ID: <20251014122140.990472-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122140.990472-1-mkl@pengutronix.de>
References: <20251014122140.990472-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

The CAN-FD section of can.rst still states that there is a 1:1 mapping
between the Classical CAN DLC and its length. This is only true for
the DLC values up to 8. Beyond that point, the length remains at 8.

For reference, the mapping between the CAN DLC and the length is given
in below table [1]:

	 DLC value	CBFF and CEFF	FBFF and FEFF
	 [decimal]	    [byte]	    [byte]
	----------------------------------------------
		 0		 0		 0
		 1		 1		 1
		 2		 2		 2
		 3		 3		 3
		 4		 4		 4
		 5		 5		 5
		 6		 6		 6
		 7		 7		 7
		 8		 8		 8
		 9		 8		12
		10		 8		16
		11		 8		20
		12		 8		24
		13		 8		32
		14		 8		48
		15		 8		64

Remove the erroneous statement. Instead just state that the length of
a Classical CAN frame ranges from 0 to 8.

[1] ISO 11898-1:2024, Table 5 -- DLC: coding of the four LSB

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20251013-can-fd-doc-v2-1-5d53bdc8f2ad@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/can.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 7650c4b5be5f..ccd321d29a8a 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1398,10 +1398,9 @@ second bit timing has to be specified in order to enable the CAN FD bitrate.
 Additionally CAN FD capable CAN controllers support up to 64 bytes of
 payload. The representation of this length in can_frame.len and
 canfd_frame.len for userspace applications and inside the Linux network
-layer is a plain value from 0 .. 64 instead of the CAN 'data length code'.
-The data length code was a 1:1 mapping to the payload length in the Classical
-CAN frames anyway. The payload length to the bus-relevant DLC mapping is
-only performed inside the CAN drivers, preferably with the helper
+layer is a plain value from 0 .. 64 instead of the Classical CAN length
+which ranges from 0 to 8. The payload length to the bus-relevant DLC mapping
+is only performed inside the CAN drivers, preferably with the helper
 functions can_fd_dlc2len() and can_fd_len2dlc().
 
 The CAN netdevice driver capabilities can be distinguished by the network
-- 
2.51.0


