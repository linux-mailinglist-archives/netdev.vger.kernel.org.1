Return-Path: <netdev+bounces-162201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 790BBA26295
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94C71884366
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769C51465BA;
	Mon,  3 Feb 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="n3LaZN3Z"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F77013212A;
	Mon,  3 Feb 2025 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738607635; cv=none; b=SNEFKZ5k1cR27GGp/wDwKrHjiyLORYSM887LjUpqt0gbkVej4vzlTmQ4fSKall8IllgYWY9tA4AJbO/DerrjKVKeQ+ofm8GOpM5YnT+EGwvPQc/49KF838s7sAtyy8huyClF/sjRQebdUpF2+8Igy+9DfQ8cuzIR1pU/i4loQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738607635; c=relaxed/simple;
	bh=Qv/oA1NGqm3eNS3fmvEshfrAJP0CchhzemG1BbiJx+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpxA+zUnL1mLjnBNgGEyqVvt+VOr5sSVeCfxucRHPW6yYH2KyajqBf6r4zx1F0Xx8ag6sSot8Q6W+R+LGfhAqcG7ueQs99qLNs+M3NPRKhoS6fyHYyGKP4FLHMQ8cH+s248OWXvSoEbdkzcTFbixs3f7jNpLfHPpNqvEIyq+zfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=n3LaZN3Z; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=1jgkRuEtsRrFHms0bbp4Vipk3ibC4Od1v2ikll/s3rM=; b=n3LaZN3ZhlpxdzX0
	oazk7LTtlzI+nrDaU8GYyFBOm7AjuRhurj8v2LPgcif3kaLG1kmfb2Hpjpt+3OeuT6usBkDW2aNuC
	97NDrQBEPD2CMNNOKov/49Nt++wf0GFMmwSYnnSWAp5sMzWhY9NmkYsFoB6yMQ+NwYQOxxFoydD1X
	iTqtRQxkLX9ZeHE5ACldFS32cIlqmT+EPeVDEfqezuxzleZFB/2IX1WeBI4f0wFNlB4NI339eybYf
	FRIDeP5FVxBp4IonBMiU+xta/TjVyP7nhR9QFnDlSPTOBsYKyDul6vO9oBar2LqUEI/1bJ1QcdbOp
	ukWpicfPZH/bUgbFkg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tf1GS-00DLY3-0Z;
	Mon, 03 Feb 2025 18:33:44 +0000
From: linux@treblig.org
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] cavium/liquidio: Remove unused lio_get_device_id
Date: Mon,  3 Feb 2025 18:33:43 +0000
Message-ID: <20250203183343.193691-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

lio_get_device_id() has been unused since 2018's
commit 64fecd3ec512 ("liquidio: remove obsolete functions and data
structures")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/cavium/liquidio/octeon_device.c | 16 ----------------
 .../net/ethernet/cavium/liquidio/octeon_device.h |  7 -------
 2 files changed, 23 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.c b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
index 6b6cb73482d7..1753bb87dfbd 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
@@ -1433,22 +1433,6 @@ int octeon_wait_for_ddr_init(struct octeon_device *oct, u32 *timeout)
 }
 EXPORT_SYMBOL_GPL(octeon_wait_for_ddr_init);
 
-/* Get the octeon id assigned to the octeon device passed as argument.
- *  This function is exported to other modules.
- *  @param dev - octeon device pointer passed as a void *.
- *  @return octeon device id
- */
-int lio_get_device_id(void *dev)
-{
-	struct octeon_device *octeon_dev = (struct octeon_device *)dev;
-	u32 i;
-
-	for (i = 0; i < MAX_OCTEON_DEVICES; i++)
-		if (octeon_device[i] == octeon_dev)
-			return octeon_dev->octeon_id;
-	return -1;
-}
-
 void lio_enable_irq(struct octeon_droq *droq, struct octeon_instr_queue *iq)
 {
 	u64 instr_cnt;
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.h b/drivers/net/ethernet/cavium/liquidio/octeon_device.h
index d26364c2ac81..19344b21f8fb 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_device.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_device.h
@@ -705,13 +705,6 @@ octeon_get_dispatch(struct octeon_device *octeon_dev, u16 opcode,
  */
 struct octeon_device *lio_get_device(u32 octeon_id);
 
-/** Get the octeon id assigned to the octeon device passed as argument.
- *  This function is exported to other modules.
- *  @param dev - octeon device pointer passed as a void *.
- *  @return octeon device id
- */
-int lio_get_device_id(void *dev);
-
 /** Read windowed register.
  *  @param  oct   -  pointer to the Octeon device.
  *  @param  addr  -  Address of the register to read.
-- 
2.48.1


