Return-Path: <netdev+bounces-150906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C009EC099
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A01169534
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F18C5672;
	Wed, 11 Dec 2024 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jroSMsnP"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4CA10A3E;
	Wed, 11 Dec 2024 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876381; cv=none; b=nyulSW+94Q8LW6X1ec+Rg6Tud27KF4TWqzc8wMcqtNoSaInlGFOry0eB+wk1pcplLJCJleRgkqmxVAbnJWUYue7OXAWkpMNQSjMT4/Q1RJekklY09LCDaTCvCkkutjLKfeVEKIbSBlEb4Gwt8qBXweOTkmVN6aPRQ0UV9sXzFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876381; c=relaxed/simple;
	bh=HTAmNFE3ZOktqaS7Zef0Avhslg/Cf3+5WSXYHPVehCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVslroXTIRfToIWOO8zhEY81pxzC2qI6M3dc9LBI6cnc4khLFZI/Zqzlsq7D5+H7BUL3CGDROIWsFSJi9R03JTofPu8bgVwTeALRsYLiokGAKDrx8Zp8G2/aAmr4n/wrp4KTcTVkYsNnwAQacUiFISea18D1e4PbTSDd+UVBpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jroSMsnP; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=eRCoVqRYb+rcP/0YVRkGDnmWTuf9gOXvCLMoBU51x1s=; b=jroSMsnPZKMkPx5k
	2YZjGgHt42aaN0PCEPtVBBuFzH6GWJuBWXmmxkTmUTfevH1mxBSmpiajf4hUlmjQtlFhezUs0+g/S
	xef0r5miZbN1uz51Je00gTxQMx1DinP8AD+s0zkI7QHerrvOUWSAJN1xZ96toW5jMFj/qmn741zp0
	iTnG+sbBVZvvT6/qy7M1CaT1tmLnR100Gq7Me0IvoGn6Fwv2KpSQOlQKeaO3JYTvG3IFukPJQTK1C
	lUTHSNZyJod1QQRy8gkQkL2L6YTdwJxto/uUA2ZMPHo9gMl7nCEXLUDMGUbYMt5juO+RH/YWd5ELA
	UK+kARPMbDirxwUeYw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tLARt-004dta-1w;
	Wed, 11 Dec 2024 00:19:29 +0000
From: linux@treblig.org
To: jeroendb@google.com,
	pkaligineedi@google.com,
	shailend@google.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] gve: Remove unused gve_adminq_set_mtu
Date: Wed, 11 Dec 2024 00:19:27 +0000
Message-ID: <20241211001927.253161-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of gve_adminq_set_mtu() was removed by
commit 37149e9374bf ("gve: Implement packet continuation for RX.")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 14 --------------
 drivers/net/ethernet/google/gve/gve_adminq.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 060e0e674938..aa7d723011d0 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1128,20 +1128,6 @@ int gve_adminq_unregister_page_list(struct gve_priv *priv, u32 page_list_id)
 	return gve_adminq_execute_cmd(priv, &cmd);
 }
 
-int gve_adminq_set_mtu(struct gve_priv *priv, u64 mtu)
-{
-	union gve_adminq_command cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.opcode = cpu_to_be32(GVE_ADMINQ_SET_DRIVER_PARAMETER);
-	cmd.set_driver_param = (struct gve_adminq_set_driver_parameter) {
-		.parameter_type = cpu_to_be32(GVE_SET_PARAM_MTU),
-		.parameter_value = cpu_to_be64(mtu),
-	};
-
-	return gve_adminq_execute_cmd(priv, &cmd);
-}
-
 int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
 			    dma_addr_t stats_report_addr, u64 interval)
 {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 863683de9694..228217458275 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -612,7 +612,6 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 queue_id);
 int gve_adminq_register_page_list(struct gve_priv *priv,
 				  struct gve_queue_page_list *qpl);
 int gve_adminq_unregister_page_list(struct gve_priv *priv, u32 page_list_id);
-int gve_adminq_set_mtu(struct gve_priv *priv, u64 mtu);
 int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
 			    dma_addr_t stats_report_addr, u64 interval);
 int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
-- 
2.47.1


