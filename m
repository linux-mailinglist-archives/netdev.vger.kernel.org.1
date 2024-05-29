Return-Path: <netdev+bounces-99119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98EC8D3BD5
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CB11C23533
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941B619066D;
	Wed, 29 May 2024 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="V4InFzGM"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5D1836FE
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998746; cv=none; b=U4cRW1KQBI3zDZxTCpIk9FhATk+g6Bw2xmoBVNh0pYmcOkOaOVDJYEXmO9WSjoVz9icXNbwvlHI4daMMbhcykskACbNZWyN4m98+gHUmb/XAns1bhb09v2YEvf25Ky6mDSoF3YKR8GQ5VfTF5H+JwrE7fiMlzQxG8EGWzTPJABY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998746; c=relaxed/simple;
	bh=g50rqN+Tm9GE6hG8Rzf5OPuU0+TursRCfv71e/S09L4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HpIlZp3f1GWL+Ab17CnfA8oypmBMF/fte5/3vUZry0vTkKFGo4Mq+HWFsM4TcsVuYc8WC5sbiiluX64fks/WAFFNethtTfwALOnpVJrFqHRS1QcTYDPbOYfOb1k+RFkCS6xpfQSZGL8znA7Zbiq/iGvE4M61ZFRLAI1W7Oaz8O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=V4InFzGM; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202405291605377dedeaa73032ebe4a7
        for <netdev@vger.kernel.org>;
        Wed, 29 May 2024 18:05:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TfT54JdgHXhlK7CXHcRDEC9PIR72E7rEaipmJkiIs44=;
 b=V4InFzGM6fHhEJITpqcpNZGvhk9K3K7gs7ZRbL5vIuMhrPl1qMqwDPZEkf3s1cSNoAokoE
 P47WRciE+iHMbzCPxhpwRY169po2/TCQEqBN2lcZnSfJbqzVWPFNuFh42RmnVfh9UIfn1wTt
 bYtCaEpUx31XTjjZfvRZQRHf4eLgA=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Wed, 29 May 2024 17:05:12 +0100
Subject: [PATCH 3/3] arm64: dts: ti: iot2050: Add IEP interrupts for SR1.0
 devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-iep-v1-3-7273c07592d3@siemens.com>
References: <20240529-iep-v1-0-7273c07592d3@siemens.com>
In-Reply-To: <20240529-iep-v1-0-7273c07592d3@siemens.com>
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716998732; l=898;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=g50rqN+Tm9GE6hG8Rzf5OPuU0+TursRCfv71e/S09L4=;
 b=ez+4KvjIglEVGUOcGVJpiCU75C2K3vojXCXuTE5agPXOB+rX2WZPnCQbyEwHMu3xw/SpOgjYH
 gC6UVyDC2BTDubP2XHfryyKEg9o11nCbYkvJkFd1fr3Ks3GpVU8XWB2
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Add the interrupts needed for PTP Hardware Clock support via IEP
in SR1.0 devices.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
index ef7897763ef8..0a29ed172215 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
@@ -73,3 +73,15 @@ &icssg0_eth {
 		    "rx0", "rx1",
 		    "rxmgm0", "rxmgm1";
 };
+
+&icssg0_iep0 {
+	interrupt-parent = <&icssg0_intc>;
+	interrupts = <7 7 7>;
+	interrupt-names = "iep_cap_cmp";
+};
+
+&icssg0_iep1 {
+	interrupt-parent = <&icssg0_intc>;
+	interrupts = <56 8 8>;
+	interrupt-names = "iep_cap_cmp";
+};

-- 
2.45.1


