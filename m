Return-Path: <netdev+bounces-152902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA489F6428
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6687118956E3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780D319CC02;
	Wed, 18 Dec 2024 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="WYtlsU6r"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5019C54B
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519347; cv=none; b=fMebKC7fn01sfv6F/2l5K/82sx6CAqqmBNNHIR65ZDdCFMJSGIcoztxMVFGUEstblOSsEoquHbflD/+i4soEtHSWqm5sLhK8z0svHgshea/yY/qjgk3Wkkn29CQMhQ1BuLT6LPp95mzQFYiaKtdviRNVNAiEWI/qRXSkwAyqvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519347; c=relaxed/simple;
	bh=qfvV5uD2ko+tS3uQ13fN/EA2UBlJV6eb1fA4Gnngjtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgKyAMKmhdlMS3PlNON06dkR6OTgnRGePD3VlmB/rYuRXO+mD7j7nyF58YmdbSeiU2s1CTAMc+Z+01NY+kg9ECgRbs4aL34sPIH8HJl5jj7AGLq/OtBdAfEu+VWAoHmRFkd2yAdR3vWof3jLqDGmWtJRH/62HguXWHmn+Zb2Hos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=WYtlsU6r; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1734519338;
	bh=x2T0i0fMAP+syHBsxpReRreQwOUGgQx/r6av0OknGag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYtlsU6rrHaH/FMTfEbB3PpEjneHZ99JBI76qhq0ND7aYlSsxIu6+Ri1/oQRPQoM3
	 2F1R+RR2uPZOffBrSk85pKZ6VMy8Fd2VwL/ihYeNoD+fT1tl5NwyET9scVYEO9mbA8
	 6xQRTGp5TQTawgCh9MXnrp5sBbj1qasP+ZiIlu3g40Dyi9yFkuhXYnRnd4V7zCQBEB
	 I5ghPgLxXEF/wFXHnwIX3QGObA+rMNl7Ja1tGBpXJmL6IW4udSmebzhyc72AMXBtpJ
	 7iTNrs6nCI/9Yxuz6a25QZEKNJ9fEJEtrgnPALQiSfyqXVTrddAeUQppzI3MK8M+fn
	 GlLNZ/zZXnz1A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YCrF623RFz4xfj;
	Wed, 18 Dec 2024 21:55:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <arnd@arndb.de>,
	<jk@ozlabs.org>,
	<segher@kernel.crashing.org>,
	netdev@vger.kernel.org
Subject: [PATCH v2 25/25] net: toshiba: Remove reference to PPC_IBM_CELL_BLADE
Date: Wed, 18 Dec 2024 21:55:13 +1100
Message-ID: <20241218105523.416573-25-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105523.416573-1-mpe@ellerman.id.au>
References: <20241218105523.416573-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a reference to PPC_IBM_CELL_BLADE which has been removed.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
v2: Unchanged.

Cc: netdev@vger.kernel.org

 drivers/net/ethernet/toshiba/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/toshiba/Kconfig b/drivers/net/ethernet/toshiba/Kconfig
index 2b1081598284..b1e27e3b99eb 100644
--- a/drivers/net/ethernet/toshiba/Kconfig
+++ b/drivers/net/ethernet/toshiba/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_TOSHIBA
 	bool "Toshiba devices"
 	default y
-	depends on PCI && (PPC_IBM_CELL_BLADE || MIPS) || PPC_PS3
+	depends on PCI && MIPS || PPC_PS3
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
-- 
2.47.1


