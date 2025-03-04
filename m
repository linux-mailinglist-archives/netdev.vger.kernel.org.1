Return-Path: <netdev+bounces-171811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34421A4EC6B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7353318848A6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE9C1F4276;
	Tue,  4 Mar 2025 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aq0.de header.i=@aq0.de header.b="UBnMvt9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail.aq0.de (mail.aq0.de [168.119.229.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F142E337A
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.229.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114015; cv=none; b=KaIBV6lCCKBKy+apzXfPwYyi6vXUXOt0fY7GoCAqXuZjLoVxCUAFgikgLP/v4LYkvSNT5Wa/WGH5MD4LTsSs2RKJO/0BUakKbEVkDMKmLICNy61b1xkbTHu8P0HzyLpjzJJtkM65rYuEjvn9LY3hHhPDxsu3Gxbn7k+uTq2XNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114015; c=relaxed/simple;
	bh=zrQG6fY1dBLYUEBrDOSXu7MOjtnt9HcLcA++oYQbleA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrddmBddTZ93xo2B/WHQvPoCX0oPf7r0Y/d0jaiLR2xGpXiUIUNx7AxP7VNXqNLrJ4nyEOki4ecyxEvwYdiZyWEcBkJW4xUAGlzP9325zZM61rAMETUwzqND1csKcenuSX9tLtrPy0wVc0qS1zlgdWc2OYbN/+++D72MusN0s78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aq0.de; spf=pass smtp.mailfrom=aq0.de; dkim=pass (1024-bit key) header.d=aq0.de header.i=@aq0.de header.b=UBnMvt9n; arc=none smtp.client-ip=168.119.229.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aq0.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aq0.de
From: Janik Haag <janik@aq0.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aq0.de; s=mail;
	t=1741113511; bh=9FZ7c8b5hBpGryEYuH8OUYr9oR18zEee7tad0kegjK4=;
	h=From:To:Cc:Subject:Date;
	b=UBnMvt9neTCtg/IZpzWCwm1Jiljbq5nrEX3JjCEyW56fbGHkof3EHmW049JmceogE
	 ud2BYMk5vOGi6ktpXmHsOuz2X++k/fT7WlmBKEUFkJbOn5D1c41kThnbgJFpmAKnKX
	 VrqT47JH6Ayi6grEOhGZGhjRLnynynZaIYgo4/Uk=
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	Janik Haag <janik@aq0.de>
Subject: [PATCH] net: liquidio: fix typo
Date: Tue,  4 Mar 2025 19:16:52 +0100
Message-ID: <20250304181651.1123778-2-janik@aq0.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Linux maintainers, this is my first patch, hope everything is
correct.

While reading through some pcie realted code I notice this small
spelling mistake of doorbell registers.
I added Dave in the TO field since they signed-off on by far the most
commits touching this file.

With kind regards,
Janik Haag

Signed-off-by: Janik Haag <janik@aq0.de>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 9ad49aea2673..5f3d39e2ceca 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -373,7 +373,7 @@ static void cn23xx_pf_setup_global_output_regs(struct octeon_device *oct)
 	/** Setting the water mark level for pko back pressure **/
 	writeq(0x40, (u8 *)oct->mmio[0].hw_addr + CN23XX_SLI_OQ_WMARK);
 
-	/** Disabling setting OQs in reset when ring has no dorebells
+	/** Disabling setting OQs in reset when ring has no doorbells
 	 * enabling this will cause of head of line blocking
 	 */
 	/* Do it only for pass1.1. and pass1.2 */

base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
-- 
2.48.1


