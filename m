Return-Path: <netdev+bounces-160448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C667AA19C18
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 02:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6CE1613FB
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 01:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5638417543;
	Thu, 23 Jan 2025 01:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="EvntECA7"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4647AD2C;
	Thu, 23 Jan 2025 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737594532; cv=none; b=FTSakx+NzfrRTFvHu7hUbmxY/ChlNy3NTdgYaTJFGQoDTp56wTQyCoigTtC8k4bQQbNPsHuNANCGMJV5ZG+aqUHnS04yJ+t6NSCuW5/qi0BRxybeIixjdsTAVKUGTizomx5HgERZbg+Nc0OGFJq3D6wn5wM63LUKa/xZtEKg0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737594532; c=relaxed/simple;
	bh=vrGeK9eKM5y4A49fxklQUPVMz48WJsb26/C6pFSQ7pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPFA8N6TwUsdrjnGbB74gJahFXhQ7ZAh9iik/U6veu3RzpvvWbrVEH5O0nxB5aprOK0KwYa225qHA6/foufuWpNBz5iMALBONvyK6AXTn/ituU+kaLFC+w6up48POOuXi8UmavY36lPlboZLjfnOs7O55mVnpYMK8WzZewWu1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=EvntECA7; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=wB81n6oSTbz6J9TSleHKqe5fhhF32VEaXct/T2R8+Jk=; b=EvntECA7qRP7XFPn
	UhZ6U31R/8RjVUUjXdu2sLkU5ALwOvsrViFNKKI/FgnJfyQyw6gUKatV3sRDjOoBZi8leTLhUlMTz
	uN+R+CeoSpxZxIeGQoa+g0ZGvQ+qGTIabSQZLPm3maVUjPhWTBupdteMG+ZcA2JyqYDzDfkEAfWv8
	OrcEUn/QzXAR8GD9yr/dNi6cZhhYLaPpV7wIbiS9g6cwwT4hMsjkC0BGjadEEGh8k8Uaxx+XkYrnt
	Ey98cFp9YXYKFfRjQzO0kev73cFvi2PwXQaoqOFbRQ1z9980q2wKNQwqoGkAdcAG492qijoHMELJb
	VqIG1rY66MKMX8e8EQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tali5-00Bb86-1P;
	Thu, 23 Jan 2025 01:08:41 +0000
From: linux@treblig.org
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [RFC net-next] cavium/liquidio: Remove unused lio_get_device_id
Date: Thu, 23 Jan 2025 01:08:39 +0000
Message-ID: <20250123010839.270610-1-linux@treblig.org>
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


