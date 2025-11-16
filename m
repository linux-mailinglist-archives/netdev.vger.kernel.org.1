Return-Path: <netdev+bounces-238917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 221BDC6110B
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 08:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1A8D324254
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 07:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C029C28031D;
	Sun, 16 Nov 2025 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TqVJ6aWk"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858923536B
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763277003; cv=none; b=C0g9S4uzknRGuiTJI68sOectZ7aZlRZ3i/ecZhswKnRRyTfBoPkjdKYOJ7i0C9abQovzS4p0IkshN+VoseklwlsewHDt9ne540KD/s4DUeGO8GcwzlXx1oyFUeSRr7913V5c+LD382nsM418kwpGVaPM7/OmeUUyckOESnVaCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763277003; c=relaxed/simple;
	bh=a48zBVsnwv9QtJ9yzhk5MtozyhxaoiRiHJQL/5qg69k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MiDV5pOVHS8VNgb8K1W2SJ2ZnAIOsdajygrSUcb+gFiDMXz5KzjNSh8e/uloPVNDPhOzD0AIMbhx1JnvKyGK+osToTgPtR8PWTTlgPtciah5YrSuVuBvEpJHCsqp76HOHHK/xKl6ZolHg+bfRKCYo0uFSJDK11m6jILwkL7Zxyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TqVJ6aWk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9cjBfxYYAvq28gwpWwQp57+T2A4SVx+qTyS2xNX4cbU=; b=TqVJ6aWkczzLNoofduX5orNx86
	4iG546yaS51s3dSqTjRj1+OHOcspW4XQH20ChXBtB7fz0YIVr0C4b+I0R7zPuUKSrW5fmYUXznSqi
	LqDTBG7bfkILDVQmJVMR8xV0Kd4oEQLzI/l5Gm2H2gNiLSfZZLYyb1SSkLe7vGMV0qmUnjsAddbtf
	xlGFxevnaqnPJGb2u7PgtaGeaNZkUEsWSuZbdtEg2MsL0EP7mp1ULXLTU9riNA515/9QxXHm0/UxG
	iqiAHQB+q80tFW0jbHfjjaFfBIRNg2TP04kN6uStxPGyGkVqGQw+8AXIbfqGDbnjR/UgAb9HYYw2K
	wiQcZJVQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKWtc-0000000EQjr-1Rxj;
	Sun, 16 Nov 2025 07:10:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] NFC: mei_phy: fix kernel-doc warnings
Date: Sat, 15 Nov 2025 23:09:59 -0800
Message-ID: <20251116070959.85055-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings in mei_phy.h to avoid build warnings and to
improve and documentation:

mei_phy.h:15: warning: missing initial short description on line:
 * struct nfc_mei_phy
mei_phy.h:19: warning: bad line:

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/nfc/mei_phy.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20251114.orig/drivers/nfc/mei_phy.h
+++ linux-next-20251114/drivers/nfc/mei_phy.h
@@ -12,11 +12,11 @@
 #define MEI_NFC_MAX_HCI_PAYLOAD 300
 
 /**
- * struct nfc_mei_phy
+ * struct nfc_mei_phy - NFC description of the MEI PHY and interface functions
  *
  * @cldev: mei client device
  * @hdev:   nfc hci device
-
+ *
  * @send_wq: send completion wait queue
  * @fw_ivn: NFC Interface Version Number
  * @vendor_id: NFC manufacturer ID

