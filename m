Return-Path: <netdev+bounces-247461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1C6CFAF54
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8891C3045F65
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989AA1F3BAC;
	Tue,  6 Jan 2026 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mbQzOL++"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265A72621
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731505; cv=none; b=S6oz0u8Ya24xf11LL0vSQWiaOwKpOoErFJS5TCkQ5OmqsvlnktO4zqzUZlUQn1YgPQXAp03C0JihSMhG+izPJT/SReS714bIeEZFfBOKH/Aok7X+jCbeO1MkCTidQVEtSsWkpsRZ+FK3g2jCr/SXs6rfHX5wVTvdBZuNm2wRK3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731505; c=relaxed/simple;
	bh=ZKt+h1bP57gDqcH6NSaKGNa767uIrCVh/t0sLWVH17A=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=n7k+y0CxCm0muQC0UwBsL0tn5E30NiSZOQ1AVcW66pXHMgdKpnWt79XuYE6ECenoawdtnVCR2j44MBY6R1mlr+cXhfeVCTBOLkMAeLMGVXGq7iuGkTGUK5j3snAyRLtYAH+QmjO9HwH6Lrt0gpStUUSeB/X9bo/ZMrVmleAe2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mbQzOL++; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DlaMolTnmoyru2QWdXRs/qQwh1y0/qtF6ho6FZ81efs=; b=mbQzOL++6Ez8wbDG1fxNOXfnlk
	oPzSrgGTbcAfbSKJVoNjVY7wSS07aObSS550BIzvcuijXY1XURfMPVrj3F2JiTx3nsrRAnkoMyU8K
	rRe4Oayy32lS+q+EwHIGBPWH8zdVOD9OG4n03TqPRfn6lst68qSInJrXOwr19j+g2aOmqq32umtgz
	w1yEs6iX/DvTDbLQEVOhTcdxHGtuOVcX6aOQtvUD0N4Bt0MrzFgaHii1K6kCDZPZft6k+BYcHHQ3d
	PnjU5SBCTh5jerAGZ10dBUMVzS1MVhNSlsSLr5ZUJDtOh4T9JJfoMRTvlL5ne8QxhQ3/8GiyFvF8C
	+deBSzkw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38080 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vdDiH-0000000011N-1Uek;
	Tue, 06 Jan 2026 20:31:33 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vdDiF-00000002E1d-30rR;
	Tue, 06 Jan 2026 20:31:31 +0000
In-Reply-To: <aV1w9yxPwL990yZJ@shell.armlinux.org.uk>
References: <aV1w9yxPwL990yZJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/9] net: stmmac: descs: fix buffer 1 off-by-one
 error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vdDiF-00000002E1d-30rR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 06 Jan 2026 20:31:31 +0000

norm_set_tx_desc_len_on_ring() incorrectly tests the buffer length,
leading to a length of 2048 being squeezed into a bitfield covering
bits 10:0 - which results in the buffer 1 size being zero.

If this field is zero, buffer 1 is ignored, and thus is equivalent
to transmitting a zero length buffer.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/descs_com.h   | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/descs_com.h b/drivers/net/ethernet/stmicro/stmmac/descs_com.h
index 40f7f2da9c5e..cb3bfc1571f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/descs_com.h
+++ b/drivers/net/ethernet/stmicro/stmmac/descs_com.h
@@ -39,15 +39,19 @@ static inline void enh_desc_end_tx_desc_on_ring(struct dma_desc *p, int end)
 		p->des0 &= cpu_to_le32(~ETDES0_END_RING);
 }
 
+/* The maximum buffer 1 size is 8KiB - 1. However, we limit to 4KiB. */
 static inline void enh_set_tx_desc_len_on_ring(struct dma_desc *p, int len)
 {
-	if (unlikely(len > BUF_SIZE_4KiB)) {
-		p->des1 |= cpu_to_le32((((len - BUF_SIZE_4KiB)
+	unsigned int buffer1_max_length = BUF_SIZE_4KiB;
+
+	if (unlikely(len > buffer1_max_length)) {
+		p->des1 |= cpu_to_le32((((len - buffer1_max_length)
 					<< ETDES1_BUFFER2_SIZE_SHIFT)
-			    & ETDES1_BUFFER2_SIZE_MASK) | (BUF_SIZE_4KiB
+			    & ETDES1_BUFFER2_SIZE_MASK) | (buffer1_max_length
 			    & ETDES1_BUFFER1_SIZE_MASK));
-	} else
+	} else {
 		p->des1 |= cpu_to_le32((len & ETDES1_BUFFER1_SIZE_MASK));
+	}
 }
 
 /* Normal descriptors */
@@ -73,16 +77,20 @@ static inline void ndesc_end_tx_desc_on_ring(struct dma_desc *p, int end)
 		p->des1 &= cpu_to_le32(~TDES1_END_RING);
 }
 
+/* The maximum buffer 1 size is 2KiB - 1, limited by the mask width */
 static inline void norm_set_tx_desc_len_on_ring(struct dma_desc *p, int len)
 {
-	if (unlikely(len > BUF_SIZE_2KiB)) {
-		unsigned int buffer1 = (BUF_SIZE_2KiB - 1)
-					& TDES1_BUFFER1_SIZE_MASK;
-		p->des1 |= cpu_to_le32((((len - buffer1)
+	unsigned int buffer1_max_length = BUF_SIZE_2KiB - 1;
+
+	if (unlikely(len > buffer1_max_length)) {
+		unsigned int buffer1 = buffer1_max_length &
+				       TDES1_BUFFER1_SIZE_MASK;
+		p->des1 |= cpu_to_le32((((len - buffer1_max_length)
 					<< TDES1_BUFFER2_SIZE_SHIFT)
 				& TDES1_BUFFER2_SIZE_MASK) | buffer1);
-	} else
+	} else {
 		p->des1 |= cpu_to_le32((len & TDES1_BUFFER1_SIZE_MASK));
+	}
 }
 
 /* Specific functions used for Chain mode */
-- 
2.47.3


