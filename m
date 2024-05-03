Return-Path: <netdev+bounces-93365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB14D8BB4DD
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44767B21B3C
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E87266D4;
	Fri,  3 May 2024 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8uCDzk7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B1220B0F;
	Fri,  3 May 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768299; cv=none; b=b5Fc2G81+F1csprH4H3/N+uFwJI+4N27U3QYdGmqEaS2XlL9sAT3jF+1EyTrunVRRutTbBchVbLN8UJ+1bc+6muyaNVH60nZJPQ+dMRC9hZa7+H/tyyEjnM1ZpU9is7bGOQdrEYew3CDUs0KO1NP9flpFQHEPOCUJsi8wRe2HvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768299; c=relaxed/simple;
	bh=bQv0f4/wzs5hDrGBpr/rtiheHbS4IDq6X15ct59uLMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IzeVEcE39G4ZGGTSlO3zIl9XG8hK2uZyMHFhSlol3Ns4vkKn4AJsoTCpjKN3ZLdVlzdazuva7n/0ho3eQwOsszvgDNyCRpIa44JQbr/WIizeIbWSBLMi/srOfmOwlPo8M/YHxlUsWggM5RSikdF6YUuU1gy+dJk8u6LmgWsAryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8uCDzk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41BAC4AF1A;
	Fri,  3 May 2024 20:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714768298;
	bh=bQv0f4/wzs5hDrGBpr/rtiheHbS4IDq6X15ct59uLMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U8uCDzk765l9Ygwhh4btegniTw/2GDkgNCwi9kH6oLQFWjaWY6nrvwk6pN0kHFNCx
	 e3yLKgz1UMaOW5IU2MgluEUUa3AvYuhngG5l3L/mtnegSRkYCvSGpKaiXgq003HTxX
	 Cr3Fk7tJTGq0phClxANEG0e1EGtFu904s10Urb/LbAP98Fq4/7zZ94RgHHk2NiKD4G
	 Vow/jW4TnI+nk1So5E9WaMNOTCbamXFJFumhQX9oPcm9CXZ1yqOyNBt+RGU7Sp/hSy
	 zns3HEqyuKXA1vn5vlqtykLHAlUWf9FNJ36lbzXLszuCm0H7eaGm2uGTN7plItx8LT
	 i8hx/m4BLZaFA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 03 May 2024 21:31:26 +0100
Subject: [PATCH net-next 1/2] gve: Avoid unnecessary use of comma operator
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-gve-comma-v1-1-b50f965694ef@kernel.org>
References: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
In-Reply-To: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
 netdev@vger.kernel.org, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.12.3

Although it does not seem to have any untoward side-effects,
the use of ';' to separate to assignments seems more appropriate than ','.

Flagged by clang-18 -Wcomma

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index b2b619aa2310..8d49462170a3 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -649,9 +649,9 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
 			GVE_RAW_ADDRESSING_QPL_ID : rx->data.qpl->id;
 
 		cmd.create_rx_queue.rx_desc_ring_addr =
-			cpu_to_be64(rx->desc.bus),
+			cpu_to_be64(rx->desc.bus);
 		cmd.create_rx_queue.rx_data_ring_addr =
-			cpu_to_be64(rx->data.data_bus),
+			cpu_to_be64(rx->data.data_bus);
 		cmd.create_rx_queue.index = cpu_to_be32(queue_index);
 		cmd.create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
 		cmd.create_rx_queue.packet_buffer_size = cpu_to_be16(rx->packet_buffer_size);

-- 
2.43.0


