Return-Path: <netdev+bounces-89635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838948AAFCD
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 15:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411DC2824E8
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E643512CDBF;
	Fri, 19 Apr 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ8+Jb59"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A80A59
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534871; cv=none; b=caHNz2bddcK/IEc3OfgA8+iD6zRK8ZcMGs/gAY4ERJ5xv7TNJyT9p30bSPl3hte/leO9MNSb2RW+TDYsfA/+2FFxB1K6gyM3kOHmw8LNL2fHbVxJ6ubUj6bP3VAPRZqKgaQ0EfUtS7uV7R6MKng9b4noxe9Ws8X4nMoOyDmU/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534871; c=relaxed/simple;
	bh=OzMRWBNo7YdxJfApr3lYhVNbuE/9Y2hLwnq4sc4mhUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkDQNLcGDlPjdnDO6VPuQM/wKjFwoyxLirrYuomMIjAcGFSp8BtG75RCc24eWGbGW2VrxGrQoHk5t++/UKjrTAzBV3of4Lhwf3FWLA28MaT1uJttGIbZbYOpYbkYOiwkYl+uY3Mc9L5faUYI7JPGZxzic9GO3tfOxyA/hP/jXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ8+Jb59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDD7C2BD10;
	Fri, 19 Apr 2024 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713534871;
	bh=OzMRWBNo7YdxJfApr3lYhVNbuE/9Y2hLwnq4sc4mhUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cZ8+Jb59UMmrqX3TWyE1sHKT79qGxHbE72DvQX1xi3i9ASui2KXsYx/jDBNX4WpXi
	 G7jQCJMqdgaN5W00ERcYJvgMezuBV/hfg64XWk+vpvS33RbNPLf4b9t0SYMMUBRPQe
	 bPeRxf3mLDboz4nBRciNB1OKyHe8QbXzWTezsLQdO9olK0nrrbfT4JDbXLCq508lby
	 /a/qUT47FvEglb5kMeiNB9mu9rcyeVhpijj3IGHknGnPs33hMn2UM9oqoW/WC6oPrF
	 0tXmBf3DhBC4xLVVvA/8Nc+IYuVHMvTLUHRRDz784SCwxoH0asGZU2fJXq5FUXhlyw
	 JGTXYy2bD3edA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 19 Apr 2024 14:54:17 +0100
Subject: [PATCH net-next 1/4] net: lan743x: Correct spelling in comments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-lan743x-confirm-v1-1-2a087617a3e5@kernel.org>
References: <20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org>
In-Reply-To: <20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org>
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


