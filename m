Return-Path: <netdev+bounces-141220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6428E9BA10C
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BC4282571
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FC1AAE10;
	Sat,  2 Nov 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="RLu5GH46"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476861A3042;
	Sat,  2 Nov 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560596; cv=none; b=B51kpwzyl2vrHN3AsAx10/Lm3fDnCewL88d1h81WEvalvVVFVkPGJZOUdugXOdPAe7ifVGuZxyTkQsW9yMVuiSmg1biXzfFV7C8409UVlhD6peHlUngfm/GiMQqU8ijBXKr+s2bJEXvmH6kdHmcvm6gzw8xU1F+NhxBzn6FfKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560596; c=relaxed/simple;
	bh=UbSuWf/19x4OB+7U6UWVKjmJ/GhijPEV35fpBLAfWE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJNpH2RjC5PD3XMl7z0RFG6JDHwg9FwvAhxlu+mr3aU5GWfVe8cgBkE7x/EmkM1k6fdCuENBChgngSbbvfmryUH3dqpmfhqGTp+hsV4x5xiMtfAJKZ1X4NOHRPvR/Q796f9uVVl6TEJl5NUyxHxV+n/+MNTdurdpqiZ/zByy9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=RLu5GH46; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=dUtivoqZwwFukVSbC82sMbINKjtK80TVINmS0LRQqkE=; b=RLu5GH462blDqwHS
	qcUjLm/DLdD7m0rcfLbMOgSRXIMate/HAg+rwrXqQAB8ztFKyuNvT9QpfM0MnEvfu/89KahzNo3Bd
	FKetWzYoveUQPKgyH3KJ0Kel03J+FbwokQObdfTdeZ0O8ldFWD/oJgQ2jvjmODZurfmJkj1xi3edn
	+qa2KSQdFAjYugWd4g0MFPQg5IYMd/Ozt/GSvFKBSWwrZDhH99R/m56jpipsfdOgIilrx/WvqbOb2
	H9Kj81BbQeAR/G00rZlxVwjp8PT4oy3EdERXdqT4u2MTT8Z1Xv17MSBELME/XVgpPs8nLbQx7uFL+
	qAWWXbAe2hTgm7GWUQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7FrZ-00F6WZ-0X;
	Sat, 02 Nov 2024 15:16:29 +0000
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
Subject: [PATCH net-next 3/4] sfc: Remove unused mcdi functions
Date: Sat,  2 Nov 2024 15:16:24 +0000
Message-ID: <20241102151625.39535-4-linux@treblig.org>
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

efx_mcdi_flush_rxqs(), efx_mcdi_rpc_async_quiet(),
efx_mcdi_rpc_finish_quiet(), and efx_mcdi_wol_filter_get_magic()
are unused.
I think these are fall out from the split into Siena
that happened in
commit 4d49e5cd4b09 ("sfc/siena: Rename functions in mcdi headers to avoid
conflicts with sfc")
and
commit d48523cb88e0 ("sfc: Copy shared files needed for Siena (part 2)")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/sfc/mcdi.c | 76 ---------------------------------
 drivers/net/ethernet/sfc/mcdi.h | 10 -----
 2 files changed, 86 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
index 76578502226e..d461b1a6ce81 100644
--- a/drivers/net/ethernet/sfc/mcdi.c
+++ b/drivers/net/ethernet/sfc/mcdi.c
@@ -1051,15 +1051,6 @@ efx_mcdi_rpc_async(struct efx_nic *efx, unsigned int cmd,
 				   cookie, false);
 }
 
-int efx_mcdi_rpc_async_quiet(struct efx_nic *efx, unsigned int cmd,
-			     const efx_dword_t *inbuf, size_t inlen,
-			     size_t outlen, efx_mcdi_async_completer *complete,
-			     unsigned long cookie)
-{
-	return _efx_mcdi_rpc_async(efx, cmd, inbuf, inlen, outlen, complete,
-				   cookie, true);
-}
-
 int efx_mcdi_rpc_finish(struct efx_nic *efx, unsigned cmd, size_t inlen,
 			efx_dword_t *outbuf, size_t outlen,
 			size_t *outlen_actual)
@@ -1068,14 +1059,6 @@ int efx_mcdi_rpc_finish(struct efx_nic *efx, unsigned cmd, size_t inlen,
 				    outlen_actual, false, NULL, NULL);
 }
 
-int efx_mcdi_rpc_finish_quiet(struct efx_nic *efx, unsigned cmd, size_t inlen,
-			      efx_dword_t *outbuf, size_t outlen,
-			      size_t *outlen_actual)
-{
-	return _efx_mcdi_rpc_finish(efx, cmd, inlen, outbuf, outlen,
-				    outlen_actual, true, NULL, NULL);
-}
-
 void efx_mcdi_display_error(struct efx_nic *efx, unsigned cmd,
 			    size_t inlen, efx_dword_t *outbuf,
 			    size_t outlen, int rc)
@@ -1982,33 +1965,6 @@ efx_mcdi_wol_filter_set_magic(struct efx_nic *efx,  const u8 *mac, int *id_out)
 }
 
 
-int efx_mcdi_wol_filter_get_magic(struct efx_nic *efx, int *id_out)
-{
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_WOL_FILTER_GET_OUT_LEN);
-	size_t outlen;
-	int rc;
-
-	rc = efx_mcdi_rpc(efx, MC_CMD_WOL_FILTER_GET, NULL, 0,
-			  outbuf, sizeof(outbuf), &outlen);
-	if (rc)
-		goto fail;
-
-	if (outlen < MC_CMD_WOL_FILTER_GET_OUT_LEN) {
-		rc = -EIO;
-		goto fail;
-	}
-
-	*id_out = (int)MCDI_DWORD(outbuf, WOL_FILTER_GET_OUT_FILTER_ID);
-
-	return 0;
-
-fail:
-	*id_out = -1;
-	netif_err(efx, hw, efx->net_dev, "%s: failed rc=%d\n", __func__, rc);
-	return rc;
-}
-
-
 int efx_mcdi_wol_filter_remove(struct efx_nic *efx, int id)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_WOL_FILTER_REMOVE_IN_LEN);
@@ -2021,38 +1977,6 @@ int efx_mcdi_wol_filter_remove(struct efx_nic *efx, int id)
 	return rc;
 }
 
-int efx_mcdi_flush_rxqs(struct efx_nic *efx)
-{
-	struct efx_channel *channel;
-	struct efx_rx_queue *rx_queue;
-	MCDI_DECLARE_BUF(inbuf,
-			 MC_CMD_FLUSH_RX_QUEUES_IN_LEN(EFX_MAX_CHANNELS));
-	int rc, count;
-
-	BUILD_BUG_ON(EFX_MAX_CHANNELS >
-		     MC_CMD_FLUSH_RX_QUEUES_IN_QID_OFST_MAXNUM);
-
-	count = 0;
-	efx_for_each_channel(channel, efx) {
-		efx_for_each_channel_rx_queue(rx_queue, channel) {
-			if (rx_queue->flush_pending) {
-				rx_queue->flush_pending = false;
-				atomic_dec(&efx->rxq_flush_pending);
-				MCDI_SET_ARRAY_DWORD(
-					inbuf, FLUSH_RX_QUEUES_IN_QID_OFST,
-					count, efx_rx_queue_index(rx_queue));
-				count++;
-			}
-		}
-	}
-
-	rc = efx_mcdi_rpc(efx, MC_CMD_FLUSH_RX_QUEUES, inbuf,
-			  MC_CMD_FLUSH_RX_QUEUES_IN_LEN(count), NULL, 0, NULL);
-	WARN_ON(rc < 0);
-
-	return rc;
-}
-
 int efx_mcdi_wol_filter_reset(struct efx_nic *efx)
 {
 	int rc;
diff --git a/drivers/net/ethernet/sfc/mcdi.h b/drivers/net/ethernet/sfc/mcdi.h
index ea612c619874..cdb17d7c147f 100644
--- a/drivers/net/ethernet/sfc/mcdi.h
+++ b/drivers/net/ethernet/sfc/mcdi.h
@@ -155,9 +155,6 @@ int efx_mcdi_rpc_start(struct efx_nic *efx, unsigned cmd,
 int efx_mcdi_rpc_finish(struct efx_nic *efx, unsigned cmd, size_t inlen,
 			efx_dword_t *outbuf, size_t outlen,
 			size_t *outlen_actual);
-int efx_mcdi_rpc_finish_quiet(struct efx_nic *efx, unsigned cmd,
-			      size_t inlen, efx_dword_t *outbuf,
-			      size_t outlen, size_t *outlen_actual);
 
 typedef void efx_mcdi_async_completer(struct efx_nic *efx,
 				      unsigned long cookie, int rc,
@@ -167,11 +164,6 @@ int efx_mcdi_rpc_async(struct efx_nic *efx, unsigned int cmd,
 		       const efx_dword_t *inbuf, size_t inlen, size_t outlen,
 		       efx_mcdi_async_completer *complete,
 		       unsigned long cookie);
-int efx_mcdi_rpc_async_quiet(struct efx_nic *efx, unsigned int cmd,
-			     const efx_dword_t *inbuf, size_t inlen,
-			     size_t outlen,
-			     efx_mcdi_async_completer *complete,
-			     unsigned long cookie);
 
 void efx_mcdi_display_error(struct efx_nic *efx, unsigned cmd,
 			    size_t inlen, efx_dword_t *outbuf,
@@ -410,10 +402,8 @@ int efx_mcdi_handle_assertion(struct efx_nic *efx);
 int efx_mcdi_set_id_led(struct efx_nic *efx, enum efx_led_mode mode);
 int efx_mcdi_wol_filter_set_magic(struct efx_nic *efx, const u8 *mac,
 				  int *id_out);
-int efx_mcdi_wol_filter_get_magic(struct efx_nic *efx, int *id_out);
 int efx_mcdi_wol_filter_remove(struct efx_nic *efx, int id);
 int efx_mcdi_wol_filter_reset(struct efx_nic *efx);
-int efx_mcdi_flush_rxqs(struct efx_nic *efx);
 void efx_mcdi_process_link_change(struct efx_nic *efx, efx_qword_t *ev);
 void efx_mcdi_mac_start_stats(struct efx_nic *efx);
 void efx_mcdi_mac_stop_stats(struct efx_nic *efx);
-- 
2.47.0


