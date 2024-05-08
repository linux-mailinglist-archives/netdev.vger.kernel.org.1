Return-Path: <netdev+bounces-94458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5809E8BF88D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0531F251E5
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB2654661;
	Wed,  8 May 2024 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUswpbGn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E535338F;
	Wed,  8 May 2024 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157149; cv=none; b=XTFHVfyjXGg+lbngLoRkEiXg8nFGletFpdaxE3vLsKBh4Rzl+2VfwJ8uqvZwvYd6uisNtlhOLDiNotf1z6aTBD+jF6yTstDvK8pzx+0JTY9JqQqh0uTnqNp56YbXSIHaF5ufJmIFGI77fhnQRjPWAiOGUMsyVBOSovKxPyyRnWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157149; c=relaxed/simple;
	bh=9/WyMlWkQBFeE2qmBcCTNpJ2EP/82n/ky5rxLOzKHGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDvUiON3YR9En0b7qiyVRjUkWFlH2L3G0KMMe8ARhRTBVkATLLpAgaO+sOVQwq+IGI/8rfzp19Mk6Vmh770wEBOVAiPtyP+2hpjVEEcsa7gfrzRr7CB7DWYCOgM54TfuvvjTisr4DWEbgM+0xI5UfRIn4yPjL59cnyARCc8/FVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUswpbGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09333C4AF17;
	Wed,  8 May 2024 08:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715157148;
	bh=9/WyMlWkQBFeE2qmBcCTNpJ2EP/82n/ky5rxLOzKHGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pUswpbGnFHDksaMNgHEprhbdWIW2ahtaSGXrEuVmhoi3Re5bdRuOEPbDixokDt+Eg
	 R4JjhFMAgy3pELks6L2+MNnclR1x1BZWdjMpg6lEeW/7+n0S0FNtxfPmGfTynfWO/m
	 zp5o3qwKFn2EQiNZHCxM/tU5Gzi8/9FhMa3Srk95v8ER7B5InYvgIctgFzdE9p/AKR
	 iz2d/ySLKKert5pEW8Rzb49ni9VWgI4e7gILDeR+FlZI8GdMLlu5VBS7RYczwOGOxo
	 h3ehBadxknjEMUthxDzjoHFct59iiTqrSlCCUfpNwSKv6pgBF2Nrgm2iH3xtX9rcy5
	 89W3mc534ShQw==
From: Simon Horman <horms@kernel.org>
Date: Wed, 08 May 2024 09:32:19 +0100
Subject: [PATCH net-next v2 1/2] gve: Avoid unnecessary use of comma
 operator
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-gve-comma-v2-1-1ac919225f13@kernel.org>
References: <20240508-gve-comma-v2-0-1ac919225f13@kernel.org>
In-Reply-To: <20240508-gve-comma-v2-0-1ac919225f13@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
 netdev@vger.kernel.org, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.12.3

Although it does not seem to have any untoward side-effects,
the use of ';' to separate to assignments seems more appropriate than ','.

Flagged by clang-18 -Wcomma

No functional change intended.
Compile tested only.

Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 3df8243680d9..8ca0def176ef 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -650,9 +650,9 @@ static void gve_adminq_get_create_rx_queue_cmd(struct gve_priv *priv,
 			GVE_RAW_ADDRESSING_QPL_ID : rx->data.qpl->id;
 
 		cmd->create_rx_queue.rx_desc_ring_addr =
-			cpu_to_be64(rx->desc.bus),
+			cpu_to_be64(rx->desc.bus);
 		cmd->create_rx_queue.rx_data_ring_addr =
-			cpu_to_be64(rx->data.data_bus),
+			cpu_to_be64(rx->data.data_bus);
 		cmd->create_rx_queue.index = cpu_to_be32(queue_index);
 		cmd->create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
 		cmd->create_rx_queue.packet_buffer_size = cpu_to_be16(rx->packet_buffer_size);

-- 
2.43.0


