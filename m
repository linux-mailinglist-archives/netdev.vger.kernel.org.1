Return-Path: <netdev+bounces-159062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D57A14443
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F151188E006
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C3F23F287;
	Thu, 16 Jan 2025 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJg9A5yk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F2B236ED4
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064551; cv=none; b=qriuIa/Yga6NDXX3iaW/sk2s23am+AjtGCtaLVCoMQDA99EeV1xSAtLUrCcjJGeGeJ3gI7WJxdwJzkpj0v9rBGnCiPIHECjZf3H5HSyeQPyNfGqKRHuwz3dA2qNJzO2HHTUb3ZUJ57Q37JmC+2KDlIt0LYknP5LQmn8w0qbZ2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064551; c=relaxed/simple;
	bh=hReaaEVazhIHcUoBuTktGZRTmQPX7aSOAiWApkLHko8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnLVBjOdiPY3N1qQzwtfnUMPn+FJtzjJ+pm1SV5UmfVVsbtBDq+uK/uGTavfMAUDes4i0Ug7qY5xyslPKZtDI0afb37Y+j7NlREIh1CXOJ0nLrdiksIgPtNvqEV7CFeAGAuYDBfxQtH2qBtzI4N8Y/VKeOWIL1PIDji4H0GhTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJg9A5yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BF4C4CEDD;
	Thu, 16 Jan 2025 21:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737064551;
	bh=hReaaEVazhIHcUoBuTktGZRTmQPX7aSOAiWApkLHko8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJg9A5ykSab2J6r9CMDOoQ86f5ud8D41Fu2cxxDc9H0dyw8g+PLcP+KTpUebk5+ym
	 ddJZU2PD2bFQPFRZKvkVerIMPRrBGcM8cnnhIXRfNghqpp/kLHx3dLRKvAywgrVCPr
	 I7MBfpavUSx6nto9qDXytcjUkzzTb0kzSrdvEkKR7mRylQ7AzAB5iSlN3JCt2RMToG
	 PSTWqTZXUwOV3TSTJwtGSgiZOLb1vdjaKRFaeiMfftq1cOGUFxbIEHZWvJtAtuyDbv
	 vVYOs+YLNiq8Ub3gxIeYCifDnap5T8e0XwLA/fLiqmNjXN3oCWYKtVIUlFWptOTWS3
	 z1ADsiSoylo9A==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next 01/11] net: Kconfig NET_DEVMEM selects GENERIC_ALLOCATOR
Date: Thu, 16 Jan 2025 13:55:19 -0800
Message-ID: <20250116215530.158886-2-saeed@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116215530.158886-1-saeed@kernel.org>
References: <20250116215530.158886-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

GENERIC_ALLOCATOR is a non-prompt kconfig, meaning users can't enable it
selectively. All kconfig users of GENERIC_ALLOCATOR select it, except of
NET_DEVMEM which only depends on it, there is no easy way to turn
GENERIC_ALLOCATOR on unless we select other unnecessary configs that
will select it.

Instead of depending on it, select it when NET_DEVMEM is enabled.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/Kconfig b/net/Kconfig
index c3fca69a7c83..4c18dd416a50 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -68,8 +68,8 @@ config SKB_EXTENSIONS
 
 config NET_DEVMEM
 	def_bool y
+	select GENERIC_ALLOCATOR
 	depends on DMA_SHARED_BUFFER
-	depends on GENERIC_ALLOCATOR
 	depends on PAGE_POOL
 
 config NET_SHAPER
-- 
2.48.0


