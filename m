Return-Path: <netdev+bounces-167259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B7A39701
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3090B189770D
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACA323237C;
	Tue, 18 Feb 2025 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oyu9hqIW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B06622FF40;
	Tue, 18 Feb 2025 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870620; cv=none; b=XToINF326iWNoSvwS6L4mp9FpZA2ObRT97ysSwVbkG0w2b73GvtgoWw9u1teL2nFMuCC4Hoy4V4SL+elSmvlB5GOPgjRtoevFNcOMED7DY2xmb8EPpCmt0z9Qn8MjN5GLQgpnGbBy/qDbztGSWF5LwpN+xnRLzkZ1fxLpSuWCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870620; c=relaxed/simple;
	bh=UX5PPI+ChEl3/dXxiilQBrO0SX7D3M0HfvISNEr9kMQ=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Wq0foSizQ9t4Z2NPo4nXMlxSMO1Am80Wq7hrKRLsio0XWD3997OO0epbLosCoUn+32Ni9W2/TUXH7+PFGzMD3cvYejaEVMRNpai6YO8hJkTBsEIT5zmjD4E6ZmRSyuojzoF/kHGrZLZ2xBFz5B3aV0D7WIXcldaBH4kIVqFmnDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oyu9hqIW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GQMYg3y3odG51dQXDSWjPv/U6qwQ6HTUOxMrmwG2YjQ=; b=oyu9hqIWz9IMHn3HJeJT0q4Kv1
	qIKBVutjUxgzxpE9yAVmM8yGlSb3Bk/Luh8O24lNlresxN+hsAHzMiXedWvG7XCKRS8kt7CAjgRxZ
	LJdZUXf3t/b1zSD2XWKS1ktCdFO0KyZHYZ/Zob/RPGT3wlRQOquyCOqTbAo1V1f1mg/gMiMt7ZyhX
	pprZH7EYHeCyEqoDAEmKTeHQWIME9VKXh8MP8x5419kWIatS/MwTB6mVW2L9OEugPh85N6fjHXTbg
	KTWzZlAzqrdhRF5c4sr4ZziC/rwzVIpoAy012g3Pyyc3UKBYxMGWxtXQ7NqHofF7cMg2lZ/ASel63
	TJnqYBLA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55628 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tkJpG-0001JE-0B;
	Tue, 18 Feb 2025 09:23:34 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tkJow-004Nfn-Cs; Tue, 18 Feb 2025 09:23:14 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Jan Petrous <jan.petrous@oss.nxp.com>
Cc: NXP S32 Linux Team <s32@nxp.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: fix DWMAC S32 entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tkJow-004Nfn-Cs@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 18 Feb 2025 09:23:14 +0000

Using L: with more than a bare email address causes getmaintainer.pl
to be unable to parse the entry. Fix this by doing as other entries
that use this email address and convert it to an R: entry.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index de81a3d68396..7da5d2df1b45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2877,7 +2877,7 @@ F:	drivers/pinctrl/nxp/
 
 ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
 M:	Jan Petrous <jan.petrous@oss.nxp.com>
-L:	NXP S32 Linux Team <s32@nxp.com>
+R:	NXP S32 Linux Team <s32@nxp.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
-- 
2.30.2


