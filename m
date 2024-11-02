Return-Path: <netdev+bounces-141219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8D99BA10B
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC159282257
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C721AAE02;
	Sat,  2 Nov 2024 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="W1Pmg7SI"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476DC1A7265;
	Sat,  2 Nov 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560596; cv=none; b=F8xFBWLEOreKHahj0F1BKMRD4AHcmOe6GNdeCGoIk5JKHGVRvbAqjXYnT30CHEgUC23aSI+PuTLKGDn3yVcTVqFwm9JbGZFOmznXyCCWavDuhsXJKdbieO+uxgOwVrZOkTF2GoIiLLFiXdFGM9CTFmOLXDAHSB7mYkSoEirGrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560596; c=relaxed/simple;
	bh=ismdhQXZqtsAzCfsgCUNETEB4Kp9hChjSPzQENdWxiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUIELObnW8kR02WUl104W9x72jFuCHZOxjvPIKCpzCD/rwLDnTTDyRUgcg0qfS0zxaj8RTu5Hm1tjpYd2PI+8YxzeiFTs3zPGlUZw83rVEwQa5Du4HjtwzcKn/qOhzfp4Im+n/CAkKl+citrZQbtwtvM/K9DETUdTUht3MhTHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=W1Pmg7SI; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Nuv+TxgokZxTw9uZP/+ccKYFiCzIeGgDiET1ELK1MqA=; b=W1Pmg7SImM1V/5Wp
	R1qIoS5oxfybQusUK1Lcr/RWOfImQtM76SvHXtNpw5akxtyxfpQ98c8jK2pm3e3Rzte8652B8AMNM
	UBaqO6iN+oVbTXahuDv3DBOSiO640lmxVlYd0P1buf2ni6JNEhRfVcaZiI0l3YtW59nmOnL72WQuW
	fVx4U2xlwTousYqlM7sQB1XnCODjhl4oLqKJgq292i19f87dRrxK2W1Dmly0eU+e9brihuFEemImS
	A1sbLOXWweIHr6uQQ4RnXof/1LV+kAlNHfkb1D3eGPzz1758oI7+tIXac6UlkdTZPjXXdIn+cmjGU
	ZbEvUfUQXMs7/VnGwQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7FrY-00F6WZ-19;
	Sat, 02 Nov 2024 15:16:28 +0000
From: linux@treblig.org
To: ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 2/4] sfc: Remove unused efx_mae_mport_vf
Date: Sat,  2 Nov 2024 15:16:23 +0000
Message-ID: <20241102151625.39535-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102151625.39535-1-linux@treblig.org>
References: <20241102151625.39535-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

efx_mae_mport_vf() has been unused since
commit 5227adff37af ("sfc: add mport lookup based on driver's mport data")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/sfc/mae.c | 11 -----------
 drivers/net/ethernet/sfc/mae.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 10709d828a63..50f097487b14 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -76,17 +76,6 @@ void efx_mae_mport_uplink(struct efx_nic *efx __always_unused, u32 *out)
 	*out = EFX_DWORD_VAL(mport);
 }
 
-void efx_mae_mport_vf(struct efx_nic *efx __always_unused, u32 vf_id, u32 *out)
-{
-	efx_dword_t mport;
-
-	EFX_POPULATE_DWORD_3(mport,
-			     MAE_MPORT_SELECTOR_TYPE, MAE_MPORT_SELECTOR_TYPE_FUNC,
-			     MAE_MPORT_SELECTOR_FUNC_PF_ID, MAE_MPORT_SELECTOR_FUNC_PF_ID_CALLER,
-			     MAE_MPORT_SELECTOR_FUNC_VF_ID, vf_id);
-	*out = EFX_DWORD_VAL(mport);
-}
-
 /* Constructs an mport selector from an mport ID, because they're not the same */
 void efx_mae_mport_mport(struct efx_nic *efx __always_unused, u32 mport_id, u32 *out)
 {
diff --git a/drivers/net/ethernet/sfc/mae.h b/drivers/net/ethernet/sfc/mae.h
index 8df30bc4f3ba..db79912c86d8 100644
--- a/drivers/net/ethernet/sfc/mae.h
+++ b/drivers/net/ethernet/sfc/mae.h
@@ -23,7 +23,6 @@ int efx_mae_free_mport(struct efx_nic *efx, u32 id);
 
 void efx_mae_mport_wire(struct efx_nic *efx, u32 *out);
 void efx_mae_mport_uplink(struct efx_nic *efx, u32 *out);
-void efx_mae_mport_vf(struct efx_nic *efx, u32 vf_id, u32 *out);
 void efx_mae_mport_mport(struct efx_nic *efx, u32 mport_id, u32 *out);
 
 int efx_mae_lookup_mport(struct efx_nic *efx, u32 selector, u32 *id);
-- 
2.47.0


