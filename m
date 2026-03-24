Return-Path: <netdev+bounces-270973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHujE4VjwmmecAQAu9opvQ
	(envelope-from <netdev+bounces-270973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:12:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCF9306489
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AED73074ACE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F593E0251;
	Tue, 24 Mar 2026 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eqYYP+b/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97E3E1227;
	Tue, 24 Mar 2026 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346752; cv=none; b=uh3pnYJJdO4nc4TREFYD8yBCXGYPA1M+iPEawDtyyFid9DaBclEb0JBqF2jewsHNiYOe8yN55kM6OHyrAxwqwD5edtJ9E3N8X2lgQtqefHrfqIJwlM7zlizqQfTRrH2elAFxecsez1E7QWePUGBHWTDXJER5Uy+872c6/hJveUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346752; c=relaxed/simple;
	bh=Rxl+j1eXd8eBQifAUiZKWhUnXXEBR5WmORrN6AM458M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=HvHUuo02InzAzZ4IP8nbZZfv/hF2g8fT1kxIa6nWyy1NQEQpZzXIIfqoi8bFyopOXTocFyWTz7BEadOVUAmPe5Zc347lU/ApbiJMv/yQIhmYujTjvexNquzSvWaq0XikmsncS/n9+xJsyex4O4/2UdbOtI74b9hDQZz7x+uYbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eqYYP+b/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tNCimm8lH9Nrd7S3bDMk3xh5Mpeyo9AVVd49TpvZ0+U=; b=eqYYP+b/qK4tA94P9WJPWHW9tP
	j6cFfPGVoVTPfzTJP9T6B5f5x207aeF1LWNdobuh0k4rf9v2LVyB0LPV/f5dEoR5j9yzGSOt+FQWX
	uxqou2VWkTHtUdXBHX/DUd3FG8WJuoJr515XfareNkQ+MUDtn0CFaTbBWRsk2F+kqZRXCpbebcEGS
	TQ+sAKL/deq7lPhVemu7Ji3YR8eoP8/z3Eq2xYKbggmUjz4c3foCo8qf4o6Pmwy+5UBxaU3aN2/tp
	BHRLTcQn66EDvy2v2MfyjPKENP1XckCo4btANKkgseF2zEWmdXnJUxpuwn6h/NFHrJU0Sx+ISHvAb
	EVFVrPuA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58192 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w4ydu-000000001lY-3fSG;
	Tue, 24 Mar 2026 10:05:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w4ydt-0000000Dlph-3WvI;
	Tue, 24 Mar 2026 10:05:45 +0000
In-Reply-To: <acJh4z3pRKkeaFbR@shell.armlinux.org.uk>
References: <acJh4z3pRKkeaFbR@shell.armlinux.org.uk>
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
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH net-next 2/2] dt-bindings: remove unimplemented AXI snps,kbbe
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
Message-Id: <E1w4ydt-0000000Dlph-3WvI@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 24 Mar 2026 10:05:45 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270973-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: DCCF9306489
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the AXI snps,kbbe snps,mb and snps,rb properties as they have
not been used, and although the driver parses these, the code hasn't
ever used the parsed result. This parsing has now been removed.

These were introduced by commit afea03656add ("stmmac: rework DMA bus
setting and introduce new platform AXI structure").

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../devicetree/bindings/net/snps,dwmac.yaml    | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 98ebb6276bc6..6d4afd824418 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -203,11 +203,8 @@ title: Synopsys DesignWare MAC
         * snps,xit_frm, unlock on WoL
         * snps,wr_osr_lmt, max write outstanding req. limit
         * snps,rd_osr_lmt, max read outstanding req. limit
-        * snps,kbbe, do not cross 1KiB boundary.
         * snps,blen, this is a vector of supported burst length.
         * snps,fb, fixed-burst
-        * snps,mb, mixed-burst
-        * snps,rb, rebuild INCRx Burst
 
   snps,mtl-rx-config:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -587,11 +584,6 @@ title: Synopsys DesignWare MAC
         description:
           max read outstanding req. limit
 
-      snps,kbbe:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          do not cross 1KiB boundary.
-
       snps,blen:
         $ref: /schemas/types.yaml#/definitions/uint32-array
         description:
@@ -604,16 +596,6 @@ title: Synopsys DesignWare MAC
         description:
           fixed-burst
 
-      snps,mb:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          mixed-burst
-
-      snps,rb:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          rebuild INCRx Burst
-
 required:
   - compatible
   - reg
-- 
2.47.3


