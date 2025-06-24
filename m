Return-Path: <netdev+bounces-200694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA44AE68DF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBB93BFDDA
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816BB2D1319;
	Tue, 24 Jun 2025 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMywfl4P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DE2C15B9
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775331; cv=none; b=rai71VdXhI11slxZnBzPWihkYvL7wVkpLNfd/0wcDltk4QxeKEzRoYQvr88Qvx8yfi4fa5r57jtTfcMcgxrNf+snq2fjHeZbTaiwdpqw8CAkX2evi9Ty8t9Gh4VIqapGNq2yFyW+/BiplE/w+yrB4NgCVuQpmCm+PuRWqUYtXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775331; c=relaxed/simple;
	bh=/gHFyS12grPDXDT0GihMo+sB/uoIb6UMTV2SHmJ0aVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3CxvlaQsVKUV0hgvFG7t58QWetnd2qVWpFggoW1JL1Pu8ubfU9PXIbn+oFRcd02rSH1ov//md9V1ZBWjCnUlgVhrn6x3KSsixMDMwkDtVsBlBFNiWR2OlmSJUFHDeZAmtsB1zAxFrsujmMCj+qWSn/2lAtA8vd1ZoCX78oG8v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMywfl4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3A0C4CEF0;
	Tue, 24 Jun 2025 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750775330;
	bh=/gHFyS12grPDXDT0GihMo+sB/uoIb6UMTV2SHmJ0aVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMywfl4PH6gkVWlUE2nXJ7j69cTSPMazOMlSVht6xnyB88qgAVSZDsieayakUQRdk
	 2qkfyDwmS+cFacrw3z8qzfnDvQvqZ9UKMLLwSGYsx3NfwUtScFUDehB6ijYhE/JceW
	 HNALasUUgLzNmH5//ZkpzVdEmscEEKM3ReUJrByiaLOYBnaVFCXbLc4vQrY21dSsZh
	 RUCYfy/R4xcKoD1VzqMcW31hDUjU1pX9OX4fVZ90mZjzLoJnnK0ZhE0BKFOfOHMPw5
	 Ef3TWyKz8uWIKOsar7rLy+Wo0yZest7SbnpnM5LUhxf1WsHOhqBSuYFI1jRyNcNG3u
	 HTOqkzE2N1VmQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	mohsin.bashr@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] eth: fbnic: fix stampinn typo in a comment
Date: Tue, 24 Jun 2025 07:28:31 -0700
Message-ID: <20250624142834.3275164-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624142834.3275164-1-kuba@kernel.org>
References: <20250624142834.3275164-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo:
 stampinn -> stamping

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index a3dc85d3838b..805a31cd94b5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -66,7 +66,7 @@ struct fbnic_net {
 	struct fbnic_queue_stats rx_stats;
 	u64 link_down_events;
 
-	/* Time stampinn filter config */
+	/* Time stamping filter config */
 	struct kernel_hwtstamp_config hwtstamp_config;
 };
 
-- 
2.49.0


