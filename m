Return-Path: <netdev+bounces-168335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA03DA3E95D
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A1E165FF8
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FA9EEBA;
	Fri, 21 Feb 2025 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsdfKd0X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33013AD5A
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099016; cv=none; b=luQR2OOWnw8FR/Jg6bbzipNbogdrT1YGMcI//05mk2FS4/ny2gn+3dbrsff57phycrKQxfM1QUTR7qZEFk+bDxLyTYfRoVZTpPaTf+baCmS7uG/r7YL++qx81Iop2GPKddPouXTy0m2wnmlbqXJIomrCBikML3Y5iPvBITAhNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099016; c=relaxed/simple;
	bh=s/y4NLp0AL8/n6sGwT4BJDb8crJOE6F2MLtXjsGG2Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZcUugSxd5NDEo7A+xMdfJ3CHX/VXvAP50JZWcMSAiqj6zrGm7rZBMX+le2gHcLmaxF7k/P7TG/cj/1D4PHcLYmHzU/sUmKPKWYysKRLyR+kLq+gQ4crETntwdIC28bGDIaPygJyNneS1tupqZsNoXzc35/r/LciQ3ETwGd+KrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsdfKd0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486CCC4CED1;
	Fri, 21 Feb 2025 00:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740099014;
	bh=s/y4NLp0AL8/n6sGwT4BJDb8crJOE6F2MLtXjsGG2Hc=;
	h=From:To:Cc:Subject:Date:From;
	b=BsdfKd0Xjx8v2JCrC1VG4xChTgghDxwGlB09XIRK2Kq2B0TSB44faoOF7eusijKPp
	 /sUNFC8n5VERsKd0KiD0k6PGXxZ3eyqcXU87JKkT+mtadGaMuKUTGedW1okfDc+yga
	 caHEj8KSmApOk6NbQpLwZEB9WHhIOPS0d3OTZ639eAo36zc/TWqNil6unCbFwgufRE
	 RKZgLVKdpuT1mli5T2xriFGlzsb5vwiuu2mSKq1BhXZpaqtcR/7hMXVEPAXwJwYMjH
	 kIeyY+4m50Yl8B77DxwGE29W53ibmGJBoZQUsC7Av2w5I7ZATky12ze0W9R9EnbMFS
	 KLFjpdLoZbV2A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	linux@armlinux.org.uk,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2] MAINTAINERS: fix DWMAC S32 entry
Date: Thu, 20 Feb 2025 16:50:12 -0800
Message-ID: <20250221005012.1051897-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using L: with more than a bare email address causes getmaintainer.pl
to be unable to parse the entry. Fix this by doing as other entries
that use this email address and convert it to an R: entry.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Commit message stolen from Russell:
https://lore.kernel.org/E1tkJow-004Nfn-Cs@rmk-PC.armlinux.org.uk
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b0cd54818bb3..298c29b7019c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2877,7 +2877,7 @@ F:	drivers/pinctrl/nxp/
 
 ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
 M:	Jan Petrous <jan.petrous@oss.nxp.com>
-L:	NXP S32 Linux Team <s32@nxp.com>
+R:	s32@nxp.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
-- 
2.48.1


