Return-Path: <netdev+bounces-140939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55D59B8BC7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 08:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807561F228FB
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 07:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64008155757;
	Fri,  1 Nov 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X/LEM9qj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7815359A;
	Fri,  1 Nov 2024 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445014; cv=none; b=arT6xPW/wcLZTkcmWU1MChNWdhC2KxJ6HAtlvfhkC/ZKT0S2qQKpHljDepntIzkR2zL/+8lVwq9g1ufSLlFMwpoq5X68pIBtPil2GL69rxT6n2YnoF9OjtRkvBRx6oHQXX2qkyem+sqpNRDzEaQmb9mwyBzAZXUVkmiJgSkySD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445014; c=relaxed/simple;
	bh=qo3EIWZzPe6jD1iFKFUqHh6rrb9GVbIt3i3my3FIISw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZE5mVlgFZ23OH4FeZU/HQttQCUFywhw24TZuZCs7m6DDIOyWhaeC5WC1zizEwTV+4qdFWTzNqAvHXrvJTuxvN+uxB2TZ35Y6sBPYvf09IaRdnu0OLlIa8wNc1vQjYlEERCtJgPe7JtZmvaUuIq7hXlD7V7F0O9JZPuXdVBj+kEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X/LEM9qj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730445012; x=1761981012;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qo3EIWZzPe6jD1iFKFUqHh6rrb9GVbIt3i3my3FIISw=;
  b=X/LEM9qjJ8p7awe89lT0CGrNpusMkE2MzKiJ5pEfVUpS9KcpOyfbXGWI
   IJibjoGEX9ms/8cyikdF9UQna0OuNhjJS9yvgTLISVRyX9etUC2XD1KFM
   TnVGV+kLjZ15SQuADVwxP5b+bo9nVUkRPxRjEtXzM+BB+yMdUh+yrGfEw
   sQ3GeBPj1yEDgf74MuLxpaRfomfes6Bb03zsRdMwhpFiWrGYLyJ9H+qJs
   8VMkJioliCYQDGr0gAb+kdCFmvdx7dh2HbJRycrGiA/OoDWvYESLgJA+B
   mWTp7zEL/SKNOz0A/Z7mQbDDsQBnodyDgB7Ueh1Uj3wYj6qCieDnD5wBf
   g==;
X-CSE-ConnectionGUID: cK9dq03ZTAa62dxLS6SkZA==
X-CSE-MsgGUID: VKcxEam4TJ2pSH5+vhY3Sg==
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="33754105"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2024 00:10:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Nov 2024 00:10:02 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 1 Nov 2024 00:10:00 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 1 Nov 2024 08:09:10 +0100
Subject: [PATCH net-next 4/6] net: sparx5: execute sparx5_vcap_init() on
 lan969x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20241101-sparx5-lan969x-switch-driver-3-v1-4-3c76f22f4bfa@microchip.com>
References: <20241101-sparx5-lan969x-switch-driver-3-v1-0-3c76f22f4bfa@microchip.com>
In-Reply-To: <20241101-sparx5-lan969x-switch-driver-3-v1-0-3c76f22f4bfa@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>, <christophe.jaillet@wanadoo.fr>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

The is_sparx5() check was introduced in an earlier series, to make sure
the sparx5_vcap_init() was not executed on lan969x, as it was not
implemented there yet. Now that it is, remove that check.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index bac87e885bf1..2f1013f870fb 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -770,12 +770,10 @@ static int sparx5_start(struct sparx5 *sparx5)
 	if (err)
 		return err;
 
-	if (is_sparx5(sparx5)) {
-		err = sparx5_vcap_init(sparx5);
-		if (err) {
-			sparx5_unregister_notifier_blocks(sparx5);
-			return err;
-		}
+	err = sparx5_vcap_init(sparx5);
+	if (err) {
+		sparx5_unregister_notifier_blocks(sparx5);
+		return err;
 	}
 
 	/* Start Frame DMA with fallback to register based INJ/XTR */

-- 
2.34.1


