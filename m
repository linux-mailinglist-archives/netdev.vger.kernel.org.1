Return-Path: <netdev+bounces-123196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F6896409F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723592834C1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476DB18C02F;
	Thu, 29 Aug 2024 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kZ/EL1fj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265EE148838;
	Thu, 29 Aug 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925263; cv=none; b=o7fij5EbFXbnLovHUz/vs4VPkIU9Mpz5GFKZ64yi0KQGfY5oC5e2YNpVGh8ghgK+dU/FYshKW6bNwsgxJ7qnY1zD+DLHdM0I0q9suKr2s2lxd15EiFgIdtFjGZwaqPlFq5qAAAXTPfeHbGAYZ61i/1V55L5phX4hT5GLiIYdz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925263; c=relaxed/simple;
	bh=Gk17cpiqIhML5adE8yFx9OsBS/qqAMi2cjj/Day63Xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=VJtO7LDN+u3ANVTyuRiTC9MWa7iEriMdkOrrBlypqBq8rX4jH9Xn3JTHiJlw2wmChjyklvmCMZq7UO5NNeR6mY9u43wEgxhQGB4NoCczW8tbFvn3AOcfMXc8Ka8BunSvpf7mrfs27vLbo6lqw6BOe9jbc6cWwJah6ZgUnY5U6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kZ/EL1fj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724925261; x=1756461261;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Gk17cpiqIhML5adE8yFx9OsBS/qqAMi2cjj/Day63Xg=;
  b=kZ/EL1fjw0i/UennDpGt46+6WZmRMcAKov3og4/NGlOjrPq33WYmkRlZ
   fOyEXu2g1QtaNzMz+8c4ZJnN4rCbsXu/5Ew+QPAFsjswibIUu1fIK/Hig
   Ov9iLykUuDg2fBldxKWUww7NnpXEad5IPMzFXk4oRuS4wPkpFKBkunD2M
   v/UJccjZpc9R8lveV4dF7d+0Ef84FPMsmRQW92B/CgucROTSkHPQVSNl8
   zRsC0j7oIA5PRwPyv+bhqVd4P9Z769r34sdNFHAQdFyYK08wAaRLqFtYY
   XksJne9SduCoB+mQF50XZ88dSDy6Hk8h1JoxsZzop/r/0bI8TYTt9rjom
   A==;
X-CSE-ConnectionGUID: G6KB1Yj2TT6z492XstGQ6w==
X-CSE-MsgGUID: Yzs25oY3SjaweLI6DgflTw==
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="31043205"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2024 02:54:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Aug 2024 02:53:35 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 29 Aug 2024 02:53:32 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Thu, 29 Aug 2024 11:52:54 +0200
Subject: [PATCH net] net: microchip: vcap: Fix use-after-free error in
 kunit test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240829-fix_use_after_free-v1-1-1507e307507f@microchip.com>
X-B4-Tracking: v=1; b=H4sIAPVE0GYC/x2MQQqDMBQFrxL+uoEkSlCvIiXY9EX/JsqPiiDev
 aHLgZm5qUAYhQZ1k+DkwmuuYF+K4jLlGZq/lckZ15rOeZ34CkdBmNIOCUkAjU/TRhO9t66nGm6
 Cav2nI2Xs9H6eHyZ5qfhpAAAA
To: Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
CC: Steen Hegelund <steen.hegelund@microchip.com>, Dan Carpenter
	<error27@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

This is a clear use-after-free error. We remove it, and rely on checking
the return code of vcap_del_rule.

Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/kernel-janitors/7bffefc6-219a-4f71-baa0-ad4526e5c198@kili.mountain/
Fixes: c956b9b318d9 ("net: microchip: sparx5: Adding KUNIT tests of key/action values in VCAP API")
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index 51d9423b08a6..f2a5a36fdacd 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -1442,18 +1442,8 @@ static void vcap_api_encode_rule_test(struct kunit *test)
 	vcap_enable_lookups(&test_vctrl, &test_netdev, 0, 0,
 			    rule->cookie, false);
 
-	vcap_free_rule(rule);
-
-	/* Check that the rule has been freed: tricky to access since this
-	 * memory should not be accessible anymore
-	 */
-	KUNIT_EXPECT_PTR_NE(test, NULL, rule);
-	ret = list_empty(&rule->keyfields);
-	KUNIT_EXPECT_EQ(test, true, ret);
-	ret = list_empty(&rule->actionfields);
-	KUNIT_EXPECT_EQ(test, true, ret);
-
-	vcap_del_rule(&test_vctrl, &test_netdev, id);
+	ret = vcap_del_rule(&test_vctrl, &test_netdev, id);
+	KUNIT_EXPECT_EQ(test, 0, ret);
 }
 
 static void vcap_api_set_rule_counter_test(struct kunit *test)

---
base-commit: 4186c8d9e6af57bab0687b299df10ebd47534a0a
change-id: 20240826-fix_use_after_free-eb34c0c66129

Best regards,
-- 
Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>


