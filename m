Return-Path: <netdev+bounces-90998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8BD8B0DF8
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924471C2194B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7043E15FCF9;
	Wed, 24 Apr 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbdIyNNr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54415ECC1
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972023; cv=none; b=vDhSOSFn9WpcKkyRgL4wgsIEF/B6DWXI/fS9BadqkjDLwa/8G+8yWICpn+CousCUOR8oaa3B7WFJLq9OJ1kOXN6GUAuMX4ytsj291wIwxlCk76aPbYFDsCwGE5IvYN8m0W82wnqhEgei2m97j5OBRLivO/5QGtDefB00IBJ9Hlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972023; c=relaxed/simple;
	bh=OzMRWBNo7YdxJfApr3lYhVNbuE/9Y2hLwnq4sc4mhUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oq1/4xcVagr3OuhiZPSCrs+dJ3NJG1bSlcXhLPpR6LFv16s7izu17uOmqtX+K3BCujhqkvyBx5fgBkXLJas1z1rbofo1+u9CmZU3UogXKNeUO440MyoWIcVBaduhjCKfgWm2ohAoVha5Ju4NhJDYNBT3wuQpoUny59/ortr72uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbdIyNNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405CEC2BD10;
	Wed, 24 Apr 2024 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972022;
	bh=OzMRWBNo7YdxJfApr3lYhVNbuE/9Y2hLwnq4sc4mhUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PbdIyNNrTuvghwSb4KM23J7zlW6+4/Q+hO8mzVuOGhYnS1roLl0bKsTqS5q/CMETA
	 Nw6AqwIgxa39rnHzYk2gQdPHvHDm/1uzwfijSBfM2238wAlljML+N0BXrRb2FjjCLF
	 4DnwXPncIGVNPLmLKuUiM8nGlM3XVcfnaVa1P4sA4pG/66uJWKRDNp9mpb3MNzWEUW
	 K/aaFEnxp55OapPidZV+cdrgLpTTVkv9TMNKQD0zfGaydKTP0FbiVWKo59ZcOcRQrr
	 rnJhS0Nu5mBpK3VGimbHZrHGtucWAcy28c63kR1VvvvoVxE7O4i1jc3AJHG6DGTofH
	 SD9ANtOFPjyvQ==
From: Simon Horman <horms@kernel.org>
Date: Wed, 24 Apr 2024 16:13:23 +0100
Subject: [PATCH net-next v2 1/4] net: lan743x: Correct spelling in comments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-lan743x-confirm-v2-1-f0480542e39f@kernel.org>
References: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
In-Reply-To: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.12.3

Correct spelling in comments, as flagged by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 4 ++--
 drivers/net/ethernet/microchip/lan743x_ptp.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index d37a49cd5c69..cee47729d022 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -803,7 +803,7 @@ static int lan743x_mdiobus_read_c22(struct mii_bus *bus, int phy_id, int index)
 	u32 val, mii_access;
 	int ret;
 
-	/* comfirm MII not busy */
+	/* confirm MII not busy */
 	ret = lan743x_mac_mii_wait_till_not_busy(adapter);
 	if (ret < 0)
 		return ret;
@@ -868,7 +868,7 @@ static int lan743x_mdiobus_read_c45(struct mii_bus *bus, int phy_id,
 	u32 mmd_access;
 	int ret;
 
-	/* comfirm MII not busy */
+	/* confirm MII not busy */
 	ret = lan743x_mac_mii_wait_till_not_busy(adapter);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index 2801f08bf1c9..80d9680b3830 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -555,7 +555,7 @@ static int lan743x_ptp_perout(struct lan743x_adapter *adapter, int on,
 			if (half == wf_high) {
 				/* It's 50% match. Use the toggle option */
 				pulse_width = PTP_GENERAL_CONFIG_CLOCK_EVENT_TOGGLE_;
-				/* In this case, devide period value by 2 */
+				/* In this case, divide period value by 2 */
 				ts_period = ns_to_timespec64(div_s64(period64, 2));
 				period_sec = ts_period.tv_sec;
 				period_nsec = ts_period.tv_nsec;

-- 
2.43.0


