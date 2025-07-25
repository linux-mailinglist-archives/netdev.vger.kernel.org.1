Return-Path: <netdev+bounces-209958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FD1B11824
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 07:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D883BFAE2
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 05:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6909626C3A4;
	Fri, 25 Jul 2025 05:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QMzrh37c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JkWZZxG2"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3D26561D;
	Fri, 25 Jul 2025 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753422990; cv=none; b=q4Theu2bYmCMamLjMyWjk0b6DvKPQYRk9FnlVQdf50nL0V8BCdaIVhuIkKihyWDzFSSSbNPa7nOmK+YPBSkoojnE7TpFmb+/r/RV9hHT4IuuQuPSUM3SraQ5HGHtJNsWRef34HorHcP3qKP3bJwAwkofV35rafOnG5PNGdC4Hzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753422990; c=relaxed/simple;
	bh=aftgpZUtG78IvXtSG5GdtBg/76t2L9VYjMcPIBMDlfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLz4AonIc4aPwNLbBsIK+tH4X3M6x59iYRbpshVTGrZvWrvOEDr/RxonZsBsI9wD9bM/eL7ZLLu2rsZ2gBOxyhjFbkbGVnXckfycEi+pC1M6OnJm1Qo1+/NiTV1frteecFNkJvLuVpCoHES1qJgkwCvrvQiBVxlLf7u61Bfp1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QMzrh37c; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=JkWZZxG2 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753422986; x=1784958986;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HCqBVfkbtfgHbH3XYzoIfUBaFkPKTk3hdAJqmbyqywg=;
  b=QMzrh37c9c1e22isRWicLJl3wSW6Gl9RDkr/vlIpbZVTsQMXy6KbHVsk
   5SAuG2FjAqm+bE7redByYExeRbgNEZZHPMHpE1DbLFVaRVdCwUHiPGhV1
   /AP420SmVdFSwmQ+wJxztiFE/rTeq5HXeAKnbqCBtIYZADPA1j1R3lCgG
   IyHbtUc2AoCsHeQwXzFr46JO324AL5JqT2WuLOCbgLCX6wgBYdrHgzQOl
   +rbDjbTBcajyPBnV879egGYwRGZFkkaXObaX5kdlrVESxk3LGFylhHsVH
   EfQdU0khVP2kZlvr9N0VJgJhQphEEurz96tokqWszdkhccQTvU6Q9PJqC
   w==;
X-CSE-ConnectionGUID: jnU3cw0zRGWbn06g3PNZBA==
X-CSE-MsgGUID: vvzNxAPwRVOdoe2VCmYCIA==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45412543"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 07:56:23 +0200
X-CheckPoint: {68831C87-42-FE216C80-D1ADDD01}
X-MAIL-CPID: 57E789A37BD89319EDBA5199F119E77E_4
X-Control-Analysis: str=0001.0A00210C.68831C43.0079,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20454173583;
	Fri, 25 Jul 2025 07:56:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753422979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HCqBVfkbtfgHbH3XYzoIfUBaFkPKTk3hdAJqmbyqywg=;
	b=JkWZZxG2NGbxawmu9Xk6SPqimAGhZmBEqumzWjgD9WY7F/6jexV97ES8yWud1xEhLmXzzW
	ZoXu9sAHYGW3A+PIcjBSRulpV47Juy0PrRZRzJ5pMFNuxLznhgZNiZdfW9wazZ3FT/1CEs
	jKrkg3zwo/kbVDzkM+kgJAdXZfg9+Jq7kDfcVz6UPsWarKqg+bX4N1IvhT0um2sA95ix5l
	mZAu7rsFRn4LBZ+OFsoOYDZ2HSsbzSRAv7STuu75P5Hcfor3k9bb8jMavGkUQ4GiTm2/ua
	+G84ZlrD3+fl5tJkYS/Njj8I1s31c7sqGhZ1C75nPpancWSt1x7Dd2kJskwXZA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] net: fsl_pq_mdio: use dev_err_probe
Date: Fri, 25 Jul 2025 07:56:13 +0200
Message-ID: <20250725055615.259945-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Silence deferred probes using dev_err_probe(). This can happen when
the ethernet PHY uses an IRQ line attached to a i2c GPIO expander. If the
i2c bus is not yet ready, a probe deferral can occur.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 56d2f79fb7e32..577f9b1780ad6 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -491,8 +491,8 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 
 	err = of_mdiobus_register(new_bus, np);
 	if (err) {
-		dev_err(&pdev->dev, "cannot register %s as MDIO bus\n",
-			new_bus->name);
+		dev_err_probe(&pdev->dev, err, "cannot register %s as MDIO bus\n",
+			      new_bus->name);
 		goto error;
 	}
 
-- 
2.43.0


