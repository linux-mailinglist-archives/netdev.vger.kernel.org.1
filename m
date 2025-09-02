Return-Path: <netdev+bounces-219108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF87B3FDE4
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A44C4E229D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61EF2F548D;
	Tue,  2 Sep 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b="Xz4fiA1q"
X-Original-To: netdev@vger.kernel.org
Received: from natrix.sarinay.com (natrix.sarinay.com [159.100.251.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23749634EC;
	Tue,  2 Sep 2025 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.251.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813046; cv=none; b=gPBUhSX9hLRuLdLwVvPzD8+V/PCJaKMbDRcsqSq8rtAyeLvz/T64mJD339ugTgsLgtKWe4b5gcbYuGDAOlAXY+bx8k4vZ+GNDWhXVqwxizWSuFmESDleJ80WCRDO60RkHF+atUZfeaVJ4Xgozg6uh/3j5d3cszvE7JaZJI297Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813046; c=relaxed/simple;
	bh=B95pJxg6nYYJMRoTZpucr9VJiYdNFISyUZJTvxVP1Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m3jlUWbYWNAlji7QetmJNEObCxp6VFYKy4gyh5PiZ6JKRGnDgLDdvIG88evTl6guhhg1gQlsrz+ONaOCW16dOSuhQIll2tiiV8OQeyozyDD0D/ksPM7VigCeQhncMEXUI4tf82GQgQ/GJxqp5TJyNxn1uKccr5k7FXaCqofXntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com; spf=pass smtp.mailfrom=sarinay.com; dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b=Xz4fiA1q; arc=none smtp.client-ip=159.100.251.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sarinay.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sarinay.com; s=2023;
	t=1756813037; bh=B95pJxg6nYYJMRoTZpucr9VJiYdNFISyUZJTvxVP1Gw=;
	h=From:To:Cc:Subject:Date;
	b=Xz4fiA1qvUNhXKXKiosCI/x+Und4Cqhoe8eCdOqtWSToNZSN+Q61T2OtjRMpqwYX7
	 vSXxomRoU3HmR15ZfEYGJBK28tIqt+c4KlMBjHILsdoa03gdM2v/ev4lRhrkzdT5NG
	 fW1snfg2PScupx7zDywo4jlSwZ2Mf/3lA+VyfMrEjn0pQknB9rrbrZ0P8hxfbTmJnO
	 i6CqwfMNWySbQrJhqeEfH/3aLs5H93pYlwGg7O4ukH1S2TpWCUW9j5G1Mhd+wfJpYC
	 xfPCKKtXCu24RMANptSG7ZXZI2/lbci11GhDrcdguEgmqzgA7PXhEFOo1C2sRHmiUP
	 FbtMX1Qg95Vhg==
From: =?UTF-8?q?Juraj=20=C5=A0arinay?= <juraj@sarinay.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Juraj=20=C5=A0arinay?= <juraj@sarinay.com>,
	krzk@kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de
Subject: [PATCH net-next v3] net: nfc: nci: Increase NCI_DATA_TIMEOUT to 3000 ms
Date: Tue,  2 Sep 2025 13:36:28 +0200
Message-ID: <20250902113630.62393-1-juraj@sarinay.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An exchange with a NFC target must complete within NCI_DATA_TIMEOUT.
A delay of 700 ms is not sufficient for cryptographic operations on smart
cards. CardOS 6.0 may need up to 1.3 seconds to perform 256-bit ECDH
or 3072-bit RSA. To prevent brute-force attacks, passports and similar
documents introduce even longer delays into access control protocols
(BAC/PACE).

The timeout should be higher, but not too much. The expiration allows
us to detect that a NFC target has disappeared.

Signed-off-by: Juraj Šarinay <juraj@sarinay.com>
---
v3:
  - introduce no parameter and raise the timeout unconditionally
v2: https://lore.kernel.org/netdev/20250825234354.855755-1-juraj@sarinay.com/
  - export nci_data_timeout to survive make allmodconfig
v1: https://lore.kernel.org/netdev/20250825134644.135448-1-juraj@sarinay.com/

 include/net/nfc/nci_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index e180bdf2f82b..664d5058e66e 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -52,7 +52,7 @@ enum nci_state {
 #define NCI_RF_DISC_SELECT_TIMEOUT		5000
 #define NCI_RF_DEACTIVATE_TIMEOUT		30000
 #define NCI_CMD_TIMEOUT				5000
-#define NCI_DATA_TIMEOUT			700
+#define NCI_DATA_TIMEOUT			3000
 
 struct nci_dev;
 
-- 
2.47.2


