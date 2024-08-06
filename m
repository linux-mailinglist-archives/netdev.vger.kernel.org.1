Return-Path: <netdev+bounces-116050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D3948DA6
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292D728686C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFF11C0DF8;
	Tue,  6 Aug 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QD8D8fdP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78547143C4B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943708; cv=none; b=R/fsoQ3WDOfuOwjP5HgfX67lMicRxepaKbdX+UBedk/tqvglP+Ct0FPODKBcgXaytN2n+f0fgA8t9TqKph7VwCMJiXEGdNJEBPxXWeBtOmAcHU800jKCWNU6jUwjYbSDUWddrG8xfndkkoXf35M/9M/uY5w7AB8FCYHlaX/XFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943708; c=relaxed/simple;
	bh=GNo212OhHHM1QHqeWV2l/rtVgumgmKcMOqzTffSp0Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H66zqrLAYQRu4dMH/Y1XPXyejCZZoK/J2Nqy6gDNLM/7YsHvu3padp1nO5NuwfvFp1BUUsfCYeXf4RdKiMiQLo8stebuP2Oy7AIOsIj0agkoEZ0d4MC7SH55u7rG8Cu83bd+AYWOZQVC74pHtTynV/ISR/HhGdm/KjhOZ+hx/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QD8D8fdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24BEC32786;
	Tue,  6 Aug 2024 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943708;
	bh=GNo212OhHHM1QHqeWV2l/rtVgumgmKcMOqzTffSp0Hg=;
	h=From:Date:Subject:To:Cc:From;
	b=QD8D8fdPJX7RKQvPvMu7zPni5itXM/8sQ9fetfYvOqeMKSRX935+qIrYRV3JlraR3
	 KiFjA9S862wNDEtbZH9JqThIwhSltKwi48w7i4Z87cII8QlUuMSONqEheb2Ie5+QFt
	 gSFkiYtBiY13+z+ddWHm2oISUFqEPG8dDqOiy0Vryfm/1SIscpKR//pC6BvrThISZO
	 ujRhKPmMlhKpVJt60KO1d18vXlXZM1SrLLyiq7Nn5ujK0isS8tSzgytJlJy3ugEKvZ
	 is5MtdRYQgAwj5pfc0+BVI1wmI4J+jpwYCGepe1mL/9e63wVe6MC4rNN9KLCpuYCwV
	 uN5V0lbWQqwcQ==
From: Simon Horman <horms@kernel.org>
Date: Tue, 06 Aug 2024 12:28:24 +0100
Subject: [PATCH net-next] net: mvpp2: Increase size of queue_name buffer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-mvpp2-namelen-v1-1-6dc773653f2f@kernel.org>
X-B4-Tracking: v=1; b=H4sIANcIsmYC/x3MQQqDMBBG4avIrB2IIYr0KuIiJr92oE5DIiKId
 2/o8lu8d1NBFhR6NTdlnFLkqxVd21B4e93AEqvJGuvMaAbez5Qsq9/xgTJCHENYeh+do9qkjFW
 u/28ixcGK66D5eX7Y7sctaQAAAA==
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Increase size of queue_name buffer from 30 to 31 to accommodate
the largest string written to it. This avoids truncation in
the possibly unlikely case where the string is name is the
maximum size.

Flagged by gcc-14:

  .../mvpp2_main.c: In function 'mvpp2_probe':
  .../mvpp2_main.c:7636:32: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
   7636 |                  "stats-wq-%s%s", netdev_name(priv->port_list[0]->dev),
        |                                ^
  .../mvpp2_main.c:7635:9: note: 'snprintf' output between 10 and 31 bytes into a destination of size 30
   7635 |         snprintf(priv->queue_name, sizeof(priv->queue_name),
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   7636 |                  "stats-wq-%s%s", netdev_name(priv->port_list[0]->dev),
        |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   7637 |                  priv->port_count > 1 ? "+" : "");
        |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit 118d6298f6f0 ("net: mvpp2: add ethtool GOP statistics").
I am not flagging this as a bug as I am not aware that it is one.

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index e809f91c08fb..9e02e4367bec 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -1088,7 +1088,7 @@ struct mvpp2 {
 	unsigned int max_port_rxqs;
 
 	/* Workqueue to gather hardware statistics */
-	char queue_name[30];
+	char queue_name[31];
 	struct workqueue_struct *stats_queue;
 
 	/* Debugfs root entry */


