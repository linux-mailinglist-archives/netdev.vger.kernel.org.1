Return-Path: <netdev+bounces-143479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 106FF9C295F
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 02:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BF91F23024
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 01:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E586B4DA03;
	Sat,  9 Nov 2024 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lvHPVGA+"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033F288B5;
	Sat,  9 Nov 2024 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731117418; cv=none; b=oouVp9LZ0mFiF1QUQnPZ63MYJtslNjaOXgGINnVOB5+IxUGIYieFz8oXU/uVeYIzVPlzR2G8x7Lc5z5gOnPBc+JNvW7lbeoLolENe8hBnbFw2NkdYLl2aRG2E5JvUbxxv0NP3u27SGSIbpNpWNNyqo1ep+VGtwqHdQ7UaN15KNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731117418; c=relaxed/simple;
	bh=zUbPNdwGiqM74GCWEkpJdusBYkhdUF6eElER7RMKAYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBoiiZsr2aAKFoUEbGDoZVIB0RXKyum1hnBA1aO4W02Gh+VXydh8Rvb3aLh9rd5kYnQCb6iTOLkxI0lDxEJdaO67Qjcr/gVvGRbyNZbtO4PvpKwbNK6MSmjcSCvIJuyamJ9aMDi3c+8RloD26cl4LPq2R3xm59xAyrOO3VgUeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lvHPVGA+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731117417; x=1762653417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zUbPNdwGiqM74GCWEkpJdusBYkhdUF6eElER7RMKAYU=;
  b=lvHPVGA+ZQMC3TivACPKh5Cyhk34tPEj7EWUQYHtaCDqepV3SojpCMwJ
   nYH/aGCCUZYzTew3lKatCTkyxVmzqCmuj1++wI+J5JQ8psOskDfyqN7Ur
   0m27FSot3ZYT3XdRPlpIKQfOn1cOuT1U1vqIyFuBTzC59s5FOqLF5P/0S
   PkKObGWJ4ioxDAxO0Lup8bw8/M/TWWKI8KKdNj00aopA8pITejrlabdSO
   EKIMBhEcnQ5Fra5fbcu8L27oUtw4g5EHgOt8xkzrVtFWtlzf4mtGaCv3r
   KcpLuY73DdrnWhnGMzQl3I2RUHDFfw8XfhmVkjgwAhqaJogc/h9PSutwv
   w==;
X-CSE-ConnectionGUID: 5vaTV7aQT/yecz//2xjQUw==
X-CSE-MsgGUID: DfknxtyNRHmQe5WYd7dvtg==
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="37590950"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2024 18:56:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Nov 2024 18:56:34 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Nov 2024 18:56:34 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: Add SGMII port support to KSZ9477 switch
Date: Fri, 8 Nov 2024 17:56:32 -0800
Message-ID: <20241109015633.82638-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109015633.82638-1-Tristram.Ha@microchip.com>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

Update the KSZ9477 switch example to use SFP cage for SGMII support.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 30c0c3e6f37a..e989723f5ad6 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -180,6 +180,13 @@ examples:
                         full-duplex;
                     };
                 };
+                port@6 {
+                    reg = <6>;
+                    label = "lan6";
+                    phy-mode = "sgmii";
+                    sfp = <&sfp>;
+                    managed = "in-band-status";
+                };
             };
         };
 
-- 
2.34.1


