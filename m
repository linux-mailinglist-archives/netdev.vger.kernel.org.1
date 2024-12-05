Return-Path: <netdev+bounces-149406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C16A9E57F8
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747DD1883D98
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A8921A454;
	Thu,  5 Dec 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y47SDJ6l"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48D21A42A;
	Thu,  5 Dec 2024 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406945; cv=none; b=BtTOVmnRRRueHkjmlMZ6TUhdNfSP0lkRyrcM6PSBX2Hzj63NGYqDh61oQulcBmokcrf8wPfekdcSVRllCSmiBOweL5ZoEMhk0fSZG0eGcQSxr9gjiHzJ49QDZKFqpYU6kbLMJL+2+0L+alJZ0eESh52D7MceJNpkCiozFKGOdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406945; c=relaxed/simple;
	bh=0oKgcrkZi8Q7zAmrkKmMg4EAU89Jf7N07xhOp2/GiHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NN/k8+1Di8ZIKr7Zq3EkydezTDyHryAtwpltQqThBujRyDJQ6mCLl3kNIylLoLosfykX8X2gN9l/HeCv42f12QCbCoyHhI3k4hQ6/VebMbd7tnnr2R3uTTSZ/OjPf73o6ihqeJ73XVeDeZ/Z+9m2AaWQ253iVK/iV5ZYVSijNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y47SDJ6l; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733406944; x=1764942944;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0oKgcrkZi8Q7zAmrkKmMg4EAU89Jf7N07xhOp2/GiHA=;
  b=Y47SDJ6lsU+y3czO7ZaHKnKdMrShQicJZjpsaPedZlNLlsqUEhAk1wx7
   jxnhrUQ7F+0AelUMnvLydIF9C7pfsOZ/EGwr8sA7oXe7x5WkMfF1xCOoJ
   fxNaqKt231afrqiiroXU9gVYspGUxPk95z49Pkb4bPQ9P75+B+tt46f/Y
   aGvCtAU3aHCIs6+ouAXEgP3h1php1S9P3+c0yL57HjtX0BP4726LK2pJu
   ePyOCoomGxodWYi4zFCNiNH8YYiFFOHBl5ui+3nGEKQ4iIwmTSkUGnT+S
   epgTxqytPUlK20/MLDL7A+BPYvRJOaVFKNqLrCnV4vAv3y9rrfZTMK37m
   A==;
X-CSE-ConnectionGUID: 7ioOcpSzQfuJnUZ0WQ6I1Q==
X-CSE-MsgGUID: 6MGhBgw7Qlie2uWE/2VadQ==
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="34869392"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2024 06:55:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Dec 2024 06:55:33 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 5 Dec 2024 06:55:29 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Dec 2024 14:54:27 +0100
Subject: [PATCH net 4/5] net: sparx5: fix default value of monitor ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241205-sparx5-lan969x-misc-fixes-v1-4-575ff3d0b022@microchip.com>
References: <20241205-sparx5-lan969x-misc-fixes-v1-0-575ff3d0b022@microchip.com>
In-Reply-To: <20241205-sparx5-lan969x-misc-fixes-v1-0-575ff3d0b022@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <horatiu.vultur@microchip.com>,
	<arnd@arndb.de>, <jacob.e.keller@intel.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: Calvin Owens <calvin@wbinvd.org>, Muhammad Usama Anjum
	<Usama.Anjum@collabora.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

When doing port mirroring, the physical port to send the frame to, is
written to the FRMC_PORT_VAL field of the QFWD_FRAME_COPY_CFG register.
This field is 7 bits wide on sparx5 and 6 bits wide on lan969x, and has
a default value of 65 and 30, respectively (the number of front ports).

On mirror deletion, we set the default value of the monitor port to
65 for this field, in case no more ports exists for the mirror. Needless
to say, this will not fit the 6 bits on lan969x.

Fix this by correctly using the n_ports constant instead.

Fixes: 3f9e46347a46 ("net: sparx5: use SPX5_CONST for constants which already have a symbol")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
index 9806729e9c62..76097761fa97 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
@@ -12,7 +12,6 @@
 #define SPX5_MIRROR_DISABLED 0
 #define SPX5_MIRROR_EGRESS 1
 #define SPX5_MIRROR_INGRESS 2
-#define SPX5_MIRROR_MONITOR_PORT_DEFAULT 65
 #define SPX5_QFWD_MP_OFFSET 9 /* Mirror port offset in the QFWD register */
 
 /* Convert from bool ingress/egress to mirror direction */
@@ -200,7 +199,7 @@ void sparx5_mirror_del(struct sparx5_mall_entry *entry)
 
 	sparx5_mirror_monitor_set(sparx5,
 				  mirror_idx,
-				  SPX5_MIRROR_MONITOR_PORT_DEFAULT);
+				  sparx5->data->consts->n_ports);
 }
 
 void sparx5_mirror_stats(struct sparx5_mall_entry *entry,

-- 
2.34.1


