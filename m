Return-Path: <netdev+bounces-100566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574AC8FB34A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849931C22CAF
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BAF1474B3;
	Tue,  4 Jun 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="n/eR2sNT"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C097146A74
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506939; cv=none; b=pWfhaZjgb/vcIBV6EFeZ9XfnbWnXAvfP25J9kO82gEtp57VIff6uP1Iwaa3MrnprQZ2EgnCEeAZ/NJlNH2j1GTFIteTBD1cqPvrmBUjLlkvUr4TGkZI4c7TVonS6dkLA27uljCFxCEDbhLo0zJsNLHbvjNelRm9Cvf5Z9RVnuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506939; c=relaxed/simple;
	bh=NUfirnAzHuSC6GjuRr39bgT7xFG/QnrzxnLmvJJpzEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VdK/L1lHY87QZminXw8EIVdRpoF14bIVPIkMcnhMsZAZhL/MlBtL+apTBhAMwdg0qe+1xkR9L8baabL8rLPk/rhb2sxrif3RqoI64/PP+ONXUSk+PAgoQu9ha0tdctuFdeK4YkZwIr6LHmdQFZsBOwXK+ntBfjwgRjyPTsHtrY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=n/eR2sNT; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240604131529f0d150c1680d941d65
        for <netdev@vger.kernel.org>;
        Tue, 04 Jun 2024 15:15:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Oycy2PZfe8iU4x5Oth2BIpAhAkhezYYXv0lKcaObIIg=;
 b=n/eR2sNT+W1oDB/e0jyP+97LceQIaFcmOPdHGnWYavgNmbRbQEdrcKUBwKTMZvVV2hM+FW
 TyOS4SNAlRcQG7VwSPc2n/bSXDPrkEZPyt9Ee6FFmVsi8XU4ZOxIkQUaeCpRgcpvPtCfUJal
 Vo0Z/N2v8uqvp7RgDNFQ0Wt0Jil4A=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Tue, 04 Jun 2024 14:15:12 +0100
Subject: [PATCH net-next v2 3/3] arm64: dts: ti: iot2050: Add IEP
 interrupts for SR1.0 devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-iep-v2-3-ea8e1c0a5686@siemens.com>
References: <20240604-iep-v2-0-ea8e1c0a5686@siemens.com>
In-Reply-To: <20240604-iep-v2-0-ea8e1c0a5686@siemens.com>
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717506924; l=952;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=NUfirnAzHuSC6GjuRr39bgT7xFG/QnrzxnLmvJJpzEw=;
 b=Goo/o35dVq5niSmgs0VgH+yriNbL58uYmxRxJ9zJSsOhfY3NVfs6u4gIJGSuO6J51/EIhEzQg
 1Svl+frgbRNA2AH2THO9ZGi8P2oJqpOsjncNkovvmX6NbrLjAYKVMI2
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Add the interrupts needed for PTP Hardware Clock support via IEP
in SR1.0 devices.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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
2.45.2


