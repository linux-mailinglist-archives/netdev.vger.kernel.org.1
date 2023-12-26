Return-Path: <netdev+bounces-60312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5C581E8B0
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 18:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D3AB212C3
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 17:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7EB4F898;
	Tue, 26 Dec 2023 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuUSPQAH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26B4F88A
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso9773708a12.0
        for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 09:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703611166; x=1704215966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cNRnoVrMkoQBB0HmwKYFDAXC+uG7H0fkQhDIVcstezY=;
        b=EuUSPQAHWvJfvR0l4XziJuwPVV13nK/hCM/xCUJA+8Co8oPCCplAjte5jWPUBZZQF6
         Qo3PzZswNLd3HoA8wLEJNsLMiSRHojmWYtvDcCx1aYhqo0eDpX86LnbKO3heoDeXseel
         EGkchcUAu4IwF8AB30rg08yfPGUBUofGr8Mm74r/W4OCkHfxbz84fp4VWhuyvfTaa4SQ
         /PHV3BqC5ZYNj7bbapY0R2CIlj43tJpvOv2R4FRc1u2K9Tym0etefHyVKO5Ntnh/hExJ
         UDXJjR2GiFANotwljtV30/2hECZQp/I4AEGI0HfZJViGiKHM0m5gcYeqntloXH3aKGmq
         VHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703611166; x=1704215966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNRnoVrMkoQBB0HmwKYFDAXC+uG7H0fkQhDIVcstezY=;
        b=TAQT4XI5TcClrUFSkFZ5KI+3bm6Jdx4aBKihzWHBxuIPegULbaW4gWePhIxovjj0W1
         o3AjJ5schihglFCg8QRaGU4hZPeO5H92xvgc0uPbyKvhfGPU4UmgUybubeh7flba3+q5
         5P9to3x6okAtR6JyS2H9jHVSUIAKFQvsz6jSsVopDyGa12GTJTO4JM0TrO8ZCpcarqDO
         O5n4ntjLqdw44KoJtRSqpLn5NKtoJ97o7e/0nVhu7nQCllcJTlmDLk+/T5KgIGc3AAT0
         1H/BtJo0MIlwhWBfb7L4u3AZYJ6MS6v8UfaGe5xM5ACaN1egk4ZVxZc6R01UjZUYIqPe
         7aKw==
X-Gm-Message-State: AOJu0YxD7z3ItCya6fTYOhrKHIEX5BDH/t3nHnT43/W2Pthsve2cjqgm
	fioSDXJqMuC9rvQomkKWr7s4NEQFduNnFhdRvYw=
X-Google-Smtp-Source: AGHT+IE8xEC/rQFcsOA0WvGLGwQvi9vtvfEbech1WGvCPIds+wJc5UpyBsyKcNlu0BWRHcw109oMPQ==
X-Received: by 2002:a17:907:6d1f:b0:a26:8978:6f53 with SMTP id sa31-20020a1709076d1f00b00a2689786f53mr10569086ejc.30.1703611165765;
        Tue, 26 Dec 2023 09:19:25 -0800 (PST)
Received: from adrian-gl659se.home (ara36.neoplus.adsl.tpnet.pl. [83.26.186.36])
        by smtp.gmail.com with ESMTPSA id lj3-20020a170906f9c300b00a26a80ac5fasm5428408ejb.120.2023.12.26.09.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 09:19:25 -0800 (PST)
From: Adrian Cinal <adriancinal1@gmail.com>
To: netdev@vger.kernel.org
Cc: opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Adrian Cinal <adriancinal1@gmail.com>
Subject: [PATCH] net: bcmgenet: Fix FCS generation for fragmented skbuffs
Date: Tue, 26 Dec 2023 18:19:07 +0100
Message-ID: <20231226171907.651412-1-adriancinal1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flag DMA_TX_APPEND_CRC was written to the first (instead of the last)
DMA descriptor in the TX path, with each descriptor corresponding to a
single skbuff fragment (or the skbuff head). This lead to packets with no
FCS appearing on the wire if the kernel allocated the packet in fragments,
which would always happen when using PACKET_MMAP/TPACKET
(cf. tpacket_fill_skb() in af_packet.c).

Signed-off-by: Adrian Cinal <adriancinal1@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 1174684a7f23..df4b0e557c76 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2137,16 +2137,16 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		len_stat = (size << DMA_BUFLENGTH_SHIFT) |
 			   (priv->hw_params->qtag_mask << DMA_TX_QTAG_SHIFT);
 
-		/* Note: if we ever change from DMA_TX_APPEND_CRC below we
-		 * will need to restore software padding of "runt" packets
-		 */
 		if (!i) {
-			len_stat |= DMA_TX_APPEND_CRC | DMA_SOP;
+			len_stat |= DMA_SOP;
 			if (skb->ip_summed == CHECKSUM_PARTIAL)
 				len_stat |= DMA_TX_DO_CSUM;
 		}
+		/* Note: if we ever change from DMA_TX_APPEND_CRC below we
+		 * will need to restore software padding of "runt" packets
+		 */
 		if (i == nr_frags)
-			len_stat |= DMA_EOP;
+			len_stat |= DMA_TX_APPEND_CRC | DMA_EOP;
 
 		dmadesc_set(priv, tx_cb_ptr->bd_addr, mapping, len_stat);
 	}
-- 
2.43.0


