Return-Path: <netdev+bounces-60379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F01181EEBF
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 13:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6171C21917
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 12:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BC6446B3;
	Wed, 27 Dec 2023 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmWdgOCa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF53446C1
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e77a2805fso2026865e87.1
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 04:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703678777; x=1704283577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMXhA6iMvwdxSlfP+s4xKOqOWvyvf6LAvfPz5JsZpg0=;
        b=dmWdgOCaSe6bMKdGwOOXXkLsH+eaTchMrLfyn0bbAxbILV2tfU7OSujxhI86M1wAW9
         gzp6olJ5aR9P58VwL6DsRwjtVqWTkegGZyQbKDRUpytKOoBOaliGtZMyB3cPSGgFVeuh
         H37VIFu9U+hrBGf67fL34LbQBb8vBdJPh9JWrDyLlDoEY8YjkF1vjcoDAbNjvetcgwV/
         /8SwCkmua19S9sSeVFLXsn2WP74u0N9IaGXDyuBnr+SLg4c+DX9DH/s0lyaSDI1EZTTu
         LAjv4PQV2/plGHCj5DQimXu0x+i0VQDFM6eyaGyi+N0EsBvHKtJfFsp4Pby04Y1M9huR
         B2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703678777; x=1704283577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMXhA6iMvwdxSlfP+s4xKOqOWvyvf6LAvfPz5JsZpg0=;
        b=exQqeMQP1YdkNRBSdcIMoonVzfD/QJZr6PbKbr2bt/qN65GX2W6ojLitUuC6ljJSKQ
         /4M4VASFYlQmJTGbVUn9el1F27rxG0jhi9Bf3ByFvKo0z+Hpzg1YgUwFQozSCIzTmrVB
         WF05gS6u7Jtz14VZtAXkCqqGhV+a/RlqOTrsBplAt0+6o2LKdkcAbuF6G2SxMrAJf9sO
         aOaXGQu5BXbBfuxOOHaPOry1+KWg0MTqVk4ty3/FETaxMVVOWXJb0LnPcHhW6kuPrwuE
         ss44LKSwGQ1QDa65vgPSpFrUSVgw3De38NtRAIcS8vuOEpVzPHGhY83FEnNp5TtG+oc0
         TUsw==
X-Gm-Message-State: AOJu0YwART9VqHTmSjvQY0W7l+Ah0DbQgcCNa1kFkZ3W3DCXYI61guAg
	R+BK3Rzqz/baqqxIPeqG94W9+uR09xU=
X-Google-Smtp-Source: AGHT+IFnwxLyffHNyS2+uV2g7f0cxGR/vUD+cHhLqNuv7aSMSzuxRl9GeYfEeZtYG3WWc4/CiVI20w==
X-Received: by 2002:a19:8c49:0:b0:50e:34a1:faf5 with SMTP id i9-20020a198c49000000b0050e34a1faf5mr2167569lfj.144.1703678776397;
        Wed, 27 Dec 2023 04:06:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:a317:e44b:d780:613:a70:2e46:83ae])
        by smtp.gmail.com with ESMTPSA id be44-20020a056512252c00b0050e78f5178asm1081319lfb.262.2023.12.27.04.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 04:06:15 -0800 (PST)
From: Adrian Cinal <adriancinal1@gmail.com>
To: netdev@vger.kernel.org
Cc: opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Adrian Cinal <adriancinal1@gmail.com>
Subject: [PATCH v2] net: bcmgenet: Fix FCS generation for fragmented skbuffs
Date: Wed, 27 Dec 2023 13:04:54 +0100
Message-ID: <20231227120601.735527-1-adriancinal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <55c522f9-503e-4adf-84cc-1ccc1fb45a9b@broadcom.com>
References: <55c522f9-503e-4adf-84cc-1ccc1fb45a9b@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flag DMA_TX_APPEND_CRC was written to the first (instead of the last)
DMA descriptor in the TX path, with each descriptor corresponding to a
single skbuff fragment (or the skbuff head). This led to packets with no
FCS appearing on the wire if the kernel allocated the packet in fragments,
which would always happen when using PACKET_MMAP/TPACKET
(cf. tpacket_fill_skb() in af_packet.c).

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
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


