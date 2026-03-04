Return-Path: <netdev+bounces-263951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEmULkhsqGn9uQAAu9opvQ
	(envelope-from <netdev+bounces-263951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:30:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C282052C6
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 212FF302CB25
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0D83BA230;
	Wed,  4 Mar 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="txABvsT4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F533B8BC3;
	Wed,  4 Mar 2026 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645441; cv=none; b=DMc7po5tc3yDdaV5MGyPNPIOhKwiVDOB3RWRm8uODN6ot3e4brFm8vvELQFz6rNfmtxMdGaIQS9smFGsJRJfFfPCEHQHatiE+LRIZWsydnRKb6u6YAkBbXGleNrGqyo4vhiEmcDsHzuqbo/fk18x15/J0mkn+M4yJNG1MojKDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645441; c=relaxed/simple;
	bh=CFI9GKBR9RuSggzML04/u23K7gpL0wipmvs3f69Qrcs=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=sP3GnqwSE2jgthxCINHm83uXWVHLFZ6dcWNeX3iSLYHTBFZdaHEq3K+DFouypXYWNJiBj2j25sXxS2tt4ei1+j+w4VneMs3/9WKvDw9dIbNAVee4SmtUpxijrQ0dBDXlxpDeraxpr8A8S83KoIJT19aXFFeCvdIWFDd5ii7/MTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=txABvsT4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zq3t4y+JHUnldmHeRMefRzwDeV3bsW0GylV8rXRJEg8=; b=txABvsT4jhw4KFAgfzBSIVbjf2
	Cpj2TZf+CDkCLVtZEG4mHVfspQY5VSPi0Xx0v8/peeJpor+oCJYa2p97rT3bNdvlS2C+4mkw0JHCV
	0JkXW7xRYMPRkcFOlLGoagCjggFd78FJMFPKwrb8IDRuTX4YJR4XUDQ196vqDTEQAhsO3yFJgBKsG
	QHKAfaA2wUiaNG+gJPltskLA4054dNANHT8FXLO2R58OQnTU2uKOVw6FD1ATGyVCljMKdj6Zf8m/L
	vCEokSvl6nnDTb+gf18dI7dlCUp7k7yao7+TSI5sIlXQJRQSLiDAgaN+AO9wpdtIwH38cJ6/+pzEg
	jVawEX/w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45000 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vxq3M-000000006q6-3NH7;
	Wed, 04 Mar 2026 17:30:32 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vxq3L-0000000BsQm-4C8v;
	Wed, 04 Mar 2026 17:30:32 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: mark unimplemented AXI snps,kbbe
 snps,mb and snps,rb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vxq3L-0000000BsQm-4C8v@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 04 Mar 2026 17:30:32 +0000
X-Rspamd-Queue-Id: 95C282052C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263951-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.281];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Action: no action

Mark the AXI snps,kbbe snps,mb and snps,rb properties as not
implemented. These were introduced by commit afea03656add ("stmmac:
rework DMA bus setting and introduce new platform AXI structure").
While stmmac has code to parse these properties and save their values,
these are written to write-only struct members - no code in stmmac
has ever read their value. Hence, these properties have been non-
functional from day one.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 38bc34dc4f09..45dba6533458 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -202,11 +202,11 @@ title: Synopsys DesignWare MAC
         * snps,xit_frm, unlock on WoL
         * snps,wr_osr_lmt, max write outstanding req. limit
         * snps,rd_osr_lmt, max read outstanding req. limit
-        * snps,kbbe, do not cross 1KiB boundary.
+        * snps,kbbe, do not cross 1KiB boundary (not implemented)
         * snps,blen, this is a vector of supported burst length.
         * snps,fb, fixed-burst
-        * snps,mb, mixed-burst
-        * snps,rb, rebuild INCRx Burst
+        * snps,mb, mixed-burst (not implemented)
+        * snps,rb, rebuild INCRx Burst (not implemented)
 
   snps,mtl-rx-config:
     $ref: /schemas/types.yaml#/definitions/phandle
-- 
2.47.3


