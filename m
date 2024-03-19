Return-Path: <netdev+bounces-80683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6814C8805C1
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 21:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9985B1C221A8
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 20:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC1F39FFB;
	Tue, 19 Mar 2024 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=terma.com header.i=@terma.com header.b="ba/Q5BZ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out6.electric.net (smtp-out6.electric.net [192.162.217.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473FE59B77
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.162.217.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878412; cv=none; b=FsTsPQfUP4Sc2lIBc1K6+QXDtLHCNGpISYVE/1t3PyTD++cyzjjG+QNjonrLjKTQDIi9opJ8nMvUbv7G5efmKwkufpdxnYVBsAsl3r04ucWg1ScjXrAKmtq99bIlM75FCOuDknWZxAMPhGEmWpAZA3KFjcw7bJHmt0KPafSQ0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878412; c=relaxed/simple;
	bh=C1uWuJz8EAcKg/XdvZRyMPLOQNuunVsQDACOstE+4hE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EU+N6afxcWvE6vD6cAAtNDRVUDW95Enq5F8Nz6D8xHrQdauixfOg1/QuCe17KmGnvfUAgCLjpr0LNljEdLxRd79+HC3vkHCCUmPDQgwRWdbt2XRUu0rq8UyEv8Zbc51SvSd5LWMEIiC6dFfZJ7acXVS5ngS912wTxkRijbw1t3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=terma.com; spf=pass smtp.mailfrom=terma.com; dkim=pass (2048-bit key) header.d=terma.com header.i=@terma.com header.b=ba/Q5BZ2; arc=none smtp.client-ip=192.162.217.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=terma.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=terma.com
Received: from 1rmfOp-0000m0-Vz by out6b.electric.net with emc1-ok (Exim 4.96.1)
	(envelope-from <chr@terma.com>)
	id 1rmfOr-0000oY-Tx;
	Tue, 19 Mar 2024 12:45:29 -0700
Received: by emcmailer; Tue, 19 Mar 2024 12:45:29 -0700
Received: from [193.163.1.101] (helo=EXCH09.terma.com)
	by out6b.electric.net with esmtpsa  (TLS1.2) tls TLS_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.1)
	(envelope-from <chr@terma.com>)
	id 1rmfOp-0000m0-Vz;
	Tue, 19 Mar 2024 12:45:27 -0700
Received: from EXCH09.terma.com (10.12.2.69) by EXCH09.terma.com (10.12.2.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Mar
 2024 20:45:26 +0100
Received: from EXCH09.terma.com ([fe80::d8f4:f3a1:6899:e2da]) by
 EXCH09.terma.com ([fe80::d8f4:f3a1:6899:e2da%17]) with mapi id
 15.01.2507.034; Tue, 19 Mar 2024 20:45:26 +0100
From: Claus Hansen Ries <chr@terma.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
Subject: [PATCH] net: ll_temac: platform_get_resource replaced by wrong
 function
Thread-Topic: [PATCH] net: ll_temac: platform_get_resource replaced by wrong
 function
Thread-Index: Adp6NO47DhzC33LDRRqZX1YF4VLPmA==
Date: Tue, 19 Mar 2024 19:45:26 +0000
Message-ID: <41c3ea1df1af4f03b2c66728af6812fb@terma.com>
Accept-Language: en-150, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authenticated: smtp.out@terma.com
X-Outbound-IP: 193.163.1.101
X-Env-From: chr@terma.com
X-Proto: esmtpsa
X-Revdns: r2d2.lystrup.terma.com
X-HELO: EXCH09.terma.com
X-TLS: TLS1.2:AES256-GCM-SHA384:256
X-Authenticated_ID: smtp.out@terma.com
X-VIPRE-Scanners:virus_bd;virus_clamav;
X-PolicySMART: 6001202, 19049467
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=terma.com; s=mailanyone20180424;h=MIME-Version:Message-ID:Date:To:From; bh=kZa7KLA5YNfgR4Nf3z2GDy99fgmLIZF1RGuBT77pG1Y=;b=ba/Q5BZ2MC4W0ZIwif+jGNcheSmi43Qo7M697sy7tqznEWqWTw1DSZboHftJQIQbkSGRioAToK32aNP7BkNKCfZXUMpHeduk7PZNOVBRGdrdsDvojwec0q2ALOqrzafnZtaSGK/R9CeqSiBmw4QOx1ZneuAP8+/MGvCQ3D+Fht6//BJDvh6gxTnomhvJeShrwC2zBJ0hy+EalqfQQz/aaZ/TnrAoEFu3f9JRMURy6TyrG8QQcFGoV4sV4n6zeRdpwS24mUSuavfzTvRZy4Cx4E1pq2ryWqxaXKe0GJ3m4ffnmDK+j6OnUdza2c96JIN/tOvWVQdNoOcCBfCE7FeIDQ==;
X-PolicySMART: 6001202, 19049467

From: Claus Hansen ries <chr@terma.com>

devm_platform_ioremap_resource_byname is called using 0 as name, which even=
tually=20
ends up in platform_get_resource_byname, where it causes a null pointer in =
strcmp.

                if (type =3D=3D resource_type(r) && !strcmp(r->name, name))

The correct function is devm_platform_ioremap_resource.

Fixes: bd69058 ("net: ll_temac: Use devm_platform_ioremap_resource_byname()=
")
Signed-off-by: Claus H. Ries <chr@terma.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethe=
rnet/xilinx/ll_temac_main.c
index 9df39cf8b097..1072e2210aed 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1443,7 +1443,7 @@ static int temac_probe(struct platform_device *pdev)
        }
          /* map device registers */
-       lp->regs =3D devm_platform_ioremap_resource_byname(pdev, 0);
+       lp->regs =3D devm_platform_ioremap_resource(pdev, 0);
        if (IS_ERR(lp->regs)) {
                dev_err(&pdev->dev, "could not map TEMAC registers\n");
                return -ENOMEM;

base-commit: d95fcdf4961d27a3d17e5c7728367197adc89b8d
--  2.39.3 (Apple Git-146)



