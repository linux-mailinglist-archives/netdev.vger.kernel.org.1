Return-Path: <netdev+bounces-131745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E898F690
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108051C22C8E
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D78B1AC8B9;
	Thu,  3 Oct 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RcPTq1p3"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-76.smtpout.orange.fr [80.12.242.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19351AB536;
	Thu,  3 Oct 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981672; cv=none; b=MTuWHzgSekeMb9w7wmJObLvbNmq9lHs2mV5UDYLEVcQCLcDzBnI4UEegj8oMktj5cQyuJnJE9mP4f3WWxgLkE6PgoCx1mzv3zNQe8tgnZ1VpcXs1EBTdltvaaR2DfZ6cD41R43xaRXI/b6Dy4Jw9HwrT1hGMvx1RHKxa+GEEMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981672; c=relaxed/simple;
	bh=/cj7PUciJXZ34k47vGyZUDVp6egyvPLvBLDTholTqpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Om22MIkdDI7hDBi4vULhH6DdC7mGdarGTq7WZ1NlTUtqoSMySxRBRGrhgetE5ohtAzk6YVJuLDSzxFPITr8xsYKYvO1xtE/i4rfZE8/4r2sWvnbNXyd57c0Yhaco0kbMM2iIBtHJ84hVGmx9u8YrJbIbUebtrch5JEVBODJh4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RcPTq1p3; arc=none smtp.client-ip=80.12.242.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id wQwxsRi2Zp9C3wQwxsQKiJ; Thu, 03 Oct 2024 20:53:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727981601;
	bh=xMiEBxIdNs7LudG+UJ24JK1bTvo4wJM890kDuVjvitg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RcPTq1p3GpocvLc/crHw117+6Mb9NF0DBeFvg5xn2xRT72ihleA1PFcPevMvAdl2p
	 88JO8aTVMtwndFANKYJd01L7hmJFFKoH7SNfywwG7tMbF/HHAXZWxHlNb01KZuUjGm
	 hbwdtRZK3Zj1xe2Z5Ec5d6MIwi81lgmzt0Bm3IJEeOBIOZ2KiEG1wzYrjYttAigp7A
	 p7uJ+hVNSDRsaIuhUK29O/EvhfiJhNt+4ELD2DwNXSoDRHGJGK/zbW7EaI47jxOvIg
	 6SyQjlKt2wa5BCXlL108EBy/VGSVq4Kjl7xC0k4V+fgWRvWvV4v8neEs5yQEPz+qKZ
	 qOgi2Zf4TGIyw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 03 Oct 2024 20:53:21 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lennart Franzen <lennart@lfdomain.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: ethernet: adi: adin1110: Fix some error handling path in adin1110_read_fifo()
Date: Thu,  3 Oct 2024 20:53:15 +0200
Message-ID: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If 'frame_size' is too small or if 'round_len' is an error code, it is
likely that an error code should be returned to the caller.

Actually, 'ret' is likely to be 0, so if one of these sanity checks fails,
'success' is returned.

Return -EINVAL instead.

Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative.
If returning 0 is what was intended, then an explicit 0 would be better.
---
 drivers/net/ethernet/adi/adin1110.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 3431a7e62b0d..c04036b687dd 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -318,11 +318,11 @@ static int adin1110_read_fifo(struct adin1110_port_priv *port_priv)
 	 * from the  ADIN1110 frame header.
 	 */
 	if (frame_size < ADIN1110_FRAME_HEADER_LEN + ADIN1110_FEC_LEN)
-		return ret;
+		return -EINVAL;
 
 	round_len = adin1110_round_len(frame_size);
 	if (round_len < 0)
-		return ret;
+		return -EINVAL;
 
 	frame_size_no_fcs = frame_size - ADIN1110_FRAME_HEADER_LEN - ADIN1110_FEC_LEN;
 	memset(priv->data, 0, ADIN1110_RD_HEADER_LEN);
-- 
2.46.2


