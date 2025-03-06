Return-Path: <netdev+bounces-172472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B9A54E42
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4281D16FC10
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A1E1898EA;
	Thu,  6 Mar 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OurPDtG6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C5188A0E
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272716; cv=none; b=i56vbIFts0+4LX3bhy9FXE0xYw5R0WZUas2pp1tDBUAStWyrmPV75j6vyBeP4vvzukXrziJYyNRd8Ko7toARBGYjazq4RKsHuK1tXa7c6cOEgJBeYJ9tG0nYw4zIw0OI/YeKT+lvBNyktKGZw7DEBBTDMezuGWSVBm7yPkKTBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272716; c=relaxed/simple;
	bh=JTgCyyrqu8MN8EaBaASssQ2pauu6sHFnFw2ePSYtcUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dh6egKoNLlNksLNePVGki8BquJDfPtGi6r/2sBFgE8p3BoRQVKZxPJWpnT9nFJPJbjhRRI/PhqMpfWcEfFP+06L0b139fvBaU4Cf9Qr0yAEWNwEtF4MDI8SI255gsNBDOlyZSTaRf3LMYk3Oyot+YG9n0QLCb0pEzIAanpCGohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OurPDtG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15B8C4CEE0;
	Thu,  6 Mar 2025 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741272716;
	bh=JTgCyyrqu8MN8EaBaASssQ2pauu6sHFnFw2ePSYtcUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OurPDtG6SCXRu3jfNpyk04/L8YXZibegY45QnRBZUUsVPp1bGNRovmlKFKe+dDhjM
	 +0ctyjbxOvf/fSXKDARfml7UstOLIAaVn0q1L5/I/wfjh/mOdx1EDu5h+rDv1iQhoO
	 9hnn7To4IKak5rzPkLDLDvgrYOz50uYE2rfcornvEXnE4VIgJssfht5qU63z91V8Hr
	 BPKOHr5wHuXEFQb44SzKiD4OKRs5+2pvruvIg+jFamQbSMARN7NL59wMtv2x2T9tsP
	 pgKEG1iI0lP3PLt0eYfiLjQMZHF2qkvlmDQ6voybkQ7FVTTU6RzgmnwDOoNB9MvsgX
	 8IZ89wJZRDTrQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] eth: fbnic: fix typo in compile assert
Date: Thu,  6 Mar 2025 06:51:49 -0800
Message-ID: <20250306145150.1757263-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306145150.1757263-1-kuba@kernel.org>
References: <20250306145150.1757263-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should be validating the Rx count on the Rx struct,
not the Tx struct. There is no real change here, rx_stats
and tx_stats are instances of the same struct.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 2d2d41c6891b..ac11389a764c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1221,7 +1221,7 @@ void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
 	fbn->rx_stats.rx.csum_complete += stats->rx.csum_complete;
 	fbn->rx_stats.rx.csum_none += stats->rx.csum_none;
 	/* Remember to add new stats here */
-	BUILD_BUG_ON(sizeof(fbn->tx_stats.rx) / 8 != 3);
+	BUILD_BUG_ON(sizeof(fbn->rx_stats.rx) / 8 != 3);
 }
 
 void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
-- 
2.48.1


