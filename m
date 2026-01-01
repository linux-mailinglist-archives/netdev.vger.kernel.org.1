Return-Path: <netdev+bounces-246490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FD1CED24D
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 17:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D9AD30021EB
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C57A2750ED;
	Thu,  1 Jan 2026 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="VyhkyaMP";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="VyhkyaMP"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022085.outbound.protection.outlook.com [52.101.66.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD638238C3A;
	Thu,  1 Jan 2026 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.85
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767283563; cv=fail; b=Yd5W8kqq84kQQHD6iESC4Pr03IVUnK41UPPib2wpF5Qs0qhgUSNx0f52tyydSjqscgOStk/mdacIJf9NdX00MXU1us1wr62wKiSePiTsZV3ZuCa0V00+w76ptcWPLn1AyWePRwkaqLHgVZuF5Gpfy+KpA0UHFiD06flk3V3O1h4=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767283563; c=relaxed/simple;
	bh=6D6EFoWu1aNmoJRqOEDYFY01dCm8k/FFMwlYUO26JkU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uUei86qmr07bRbSnY1sKCcP29EVyVMAD7mdCe4yOf6+oGKZvXgjqbPGtohKrthiP31AHvB/Lpgm51zVAXifuZJc48qP9QjzTkROmxSI608Ic2WofFvHEnKLVuVIz2IzACI8qUtT7wQ4HB+1FdnRJkRepoZHWVzI3chX2QH3h/Sc=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=VyhkyaMP; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=VyhkyaMP; arc=fail smtp.client-ip=52.101.66.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GF3W18ZYsIRIu5YTYs7ABBj0zIIK/lLrBpIhwFj7yCYEy4xchKA57SJKeSHawDwO3gk3xzsD+fyNTl8DGnFjbSsLv7gnwEwJtNhAp5K/VvNjyppJpP5RUgmySgSplYNC8HxFkGncnG/TZpLWWIESLHWlwhEr0B0Sb1prxp2sLCkGTALfYfI+ClwSeLz6lOqNJCG6L3pyKUn2TAIBAr3tQgThHTlerWyLnr4JcYK5KEXQ7j4749kt7q1jXwCWQhOHwrRHilwDVp86mllao5pfDC9IzZubJVqpMCjJdSUJcdNn7ihAYQ62s2qXi4bFmb5Q/5C76njqabqxeqjYvL9yuQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dRaC2ASYR39P8HEqaWP/XRtATwa7+F7T19UYtxvUyo=;
 b=vbuQRRZlB2DQEWyO3ChbJ6/vHG3mmYUESvBfEyZHaqdl2l9Ru2AxtUShqWImOyD5F10/g97u1590uA1licgK3BqO+ZvcRF4bT6VhBprMFAGfHSjXYwdYVJ4OIqV4wjkgW4DU1n8F1m3j2Ct74xqFV8a8O3HUCqHndYqrq3bZjJyOyMuwprzH7ZqlbAXEVEYV8bKVQj/o+IFJQknwx1zElpmXHxyaYjJ9RqxDyQS0btsxJBmLSWl4npWsV4eq8kMYymSE/Sl4+PMoXZWrOZxbKIZ1izt+aiIaDG1nSJcy7yD2TxPzoFTYNY3rn1l+N+Cw9TKCMOX3xbT5BVb36VBKeQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dRaC2ASYR39P8HEqaWP/XRtATwa7+F7T19UYtxvUyo=;
 b=VyhkyaMPOkyNshpHS7mL/J8dtKrKF41TMJb2Q87fvfvexG3ekbmD0EEX/gAOWnDdFKBKC4QHNLbtsKKKWzOXz0CGU823CgsHzorldAtv+pmXXSY9xsKimItebRnDtxWKQBFenLDQcF8mkipwgz8E0qLHN3M55dqxoUlWSD+aa4A=
Received: from AS4P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::17)
 by VE1PR04MB7325.eurprd04.prod.outlook.com (2603:10a6:800:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:05:57 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:20b:5de:cafe::fa) by AS4P190CA0005.outlook.office365.com
 (2603:10a6:20b:5de::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Thu, 1
 Jan 2026 16:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Thu, 1 Jan 2026 16:05:56 +0000
Received: from emails-39759-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-24.eu-west-1.compute.internal [10.20.5.24])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 76861809E9;
	Thu,  1 Jan 2026 16:05:56 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1767283556; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=5dRaC2ASYR39P8HEqaWP/XRtATwa7+F7T19UYtxvUyo=;
 b=hJ/BgN0WPVskSoK0ZXksp4RSY1uKDKEEi9xBCwENZwWK6yTuTHJaEcyuWDlSL361qGUNe
 soJGvgCQfLl1LKc0lxZ6OTPOzm5G5Y1/W54LrwimdQb3tOjM+fTbqN/3sMKUsYFG3gPivT4
 2gDzjY0X0d+Jf5azvqht6Uckrj3q6KQ=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1767283556;
 b=ER7/An+OiG79vVUvwwMo7UU4rUmQ68qRgknp60EWTi8DrFouZCKZhIIwj4Iz0otzGa9yt
 msea2VlSxcTM51ggcvQYJWlUapsMSTcmTs4h7NdmQnG3b1NvSyF8LAzcFHTZRf73I+f23Ry
 C8IVpx+m07I/TjeP3wNKt17tXaqqa80=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaSl8/KSYoHUhzUhtGSBBDStYbm8NE7ynIcn2oGKXZFEJCoswLIoM9jSz/JDmMUhSuJD4fTC1baUzuRTU03BDFbAOhkgaRHQZRaPtrdTOnN+SXqLNUoiwNkN15VChOx1E+ZRgAOnpVSQ33WcGfGFkIZifdVGMdgioh9mNPhJQKYtVvUc1bNsx5ApBTX6GC180mkC8OlnqBaU/oWYiuRC5rXxReeyRbKThH04Gk8TdfNw38mTLGNK7Jd0HQ2rjn7UMeMb3KonQ4wwmSnoONwn6zRXWOq2kp7MOjB1qJytL9j8wrzbNkwgQhqU4TPG0/zFLm1jIlPwOIgAqdk9WjIqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dRaC2ASYR39P8HEqaWP/XRtATwa7+F7T19UYtxvUyo=;
 b=N4D07KJiufZEIBJlc2gj2SKRvxnKqIRrkITOqws/yRPu+bbS2TUsTcYvVtFCpM5/VHXqH+lmROOudEokYNrWUJV9DPc3+lJPZODNXQSYevE7meTeTOUOP4cZoRd0GbErj/FOQY1ePKI1VxjYzKLLihisvSBfb64i0soWCSTbkuPShWrGWpGw5LG1pIajXN/fsecszudv48reqs4lwpxtP1EY/6WatnO5pUa831Nhst+2eXbbg9gYS4AVqW1GxmNjHsP+6d6TS0TYxn0Z+ILZCFy20iZnDgaJJL9832C++1TfXpkUrO/F24tGvcOJkowcMOPoURM4mFCzsd8ab7/gGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dRaC2ASYR39P8HEqaWP/XRtATwa7+F7T19UYtxvUyo=;
 b=VyhkyaMPOkyNshpHS7mL/J8dtKrKF41TMJb2Q87fvfvexG3ekbmD0EEX/gAOWnDdFKBKC4QHNLbtsKKKWzOXz0CGU823CgsHzorldAtv+pmXXSY9xsKimItebRnDtxWKQBFenLDQcF8mkipwgz8E0qLHN3M55dqxoUlWSD+aa4A=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:05:47 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9456.013; Thu, 1 Jan 2026
 16:05:47 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 01 Jan 2026 18:05:38 +0200
Subject: [PATCH RFC net-next v2 1/2] net: phy: marvell: 88e1111: define
 gigabit features
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-cisco-1g-sfp-phy-features-v2-1-47781d9e7747@solid-run.com>
References: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
In-Reply-To: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Josua Mayer <josua@solid-run.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PAXPR04MB8286:EE_|AMS0EPF00000193:EE_|VE1PR04MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0a54ab-f1b5-43ea-5355-08de494fa5f8
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VkJqdEtQRUg5dGFqYWhsblZ6d2twNFdhUGpERjJwaHZZNEdyWTB1UFV2cC9P?=
 =?utf-8?B?TWo3bitrTUEvWk1hb2I1dmE0eG4vd0dqWmRJVkpTbTFZSE9tbDljVWlyVEps?=
 =?utf-8?B?dTQ5c21pbDlXZFRJQmU0N2xOcUh3eVJYb1YxWENON2luL3pnejBZTmMrekQ5?=
 =?utf-8?B?TUE2T3Izd1BnYnp1aVhiL0NxeFJGb2M5NUhvWC9RWmUrTDFmS0U5MnNzWVha?=
 =?utf-8?B?dE1jZG0zcDVnMzVEc1pQTGo2cEREU0t3ZmFNZjgrV05Kc1dqdkxZMmNHRHhj?=
 =?utf-8?B?ZU41VEJvVUhVSHNLWWpid3RpYUNjLzkwckFiK256L1Jla2RwbGd4QllTd2Ft?=
 =?utf-8?B?Mjl2ZTBRbnVROFBqVTFRa1YzZlFSbUphYXYzdTZNMzZkVjVpVDI4UVU4T1JY?=
 =?utf-8?B?bENEanlyUm9VMG9xNWpIYndyaHF6YlpyellKVC9UcFFUNEk2K3BBbnVZb0NZ?=
 =?utf-8?B?QXhWNCtSWWlnaVc4VFJEZmFWV0R4UEFNMVlJUTE5ZENBSHpjZWhPV0ErNFlu?=
 =?utf-8?B?QTRIQWZqbkRoZjUveHBCRkErUWVFZkVBZm80UVZxQkFNZ25qY2g1WE1ML3BU?=
 =?utf-8?B?YVd3RXFWRzI3bHVvcndFamdhQ2JKekN2TjcrNVhYa2YybCt3ay8wdnhvS0V1?=
 =?utf-8?B?cXdJc2xLZWNJUTI5RW1qZXVtWnFNbVcxMmtWSlhmeTNyallFMkg4MFd1dWlS?=
 =?utf-8?B?M1RKYkFoWUJhZUdyNUh0OS9oUG0xenYyMERNWmR1R3BaaHQ0QXgzMDZNSlEx?=
 =?utf-8?B?NHVjYmNuOE5kOUE5RWhNQ1o5TnpSQmJsRmg3clRLRFF1enFMMkh1YjQ1b1Z0?=
 =?utf-8?B?elVPT3p2ZWQvWnU3Ym5zYWdIMU1Yb1hnVkZMWkFiTlk2aW5heXVGT0V0SnVG?=
 =?utf-8?B?U0pBaitSc01YUTltSzRCU0ZWN0JvY0hCUHhQY241M3gydFk0OHBONVF5SlF2?=
 =?utf-8?B?QjNvUFR1NVFaaXlqdDRzVmJhRWVLWjV2YS9lVjV4TXIwUlpsYk9aUXoxRmVt?=
 =?utf-8?B?dFhPK0RDdGdac21LRWQzV0IwcnJUM2E4NXV6TXZiRFh1dWh4MjNhYmlNeEVw?=
 =?utf-8?B?dDhKVjBZUlZ5cXg3YlBqQmUyMFIrWUd5RExUZ2dleGNWVFFPWVQ3aTBTK0t3?=
 =?utf-8?B?SDdyL2VWaWdFNkNPY2VKdy9nbGhUcnlLcFNSeW4wM1dpb0w3M2dybXBxTnNm?=
 =?utf-8?B?QVRZWHYvakgzVUtxbEc4eFhqZkdHM3RRVlpwWGN4Ull1a2kzZDFVQzZTQmNV?=
 =?utf-8?B?MVgrZGhWaHErUlB5V25pcUYwenNkR1hkaE5wSStYWHdORlkrVC9LMDk2N1Zy?=
 =?utf-8?B?bENQNUxtQW5IVFBkV28zblRvbzc4RUZnbWR6MUIzeHZrQlFZalZMNjcrUE1y?=
 =?utf-8?B?MVVUWStHYjRLbi9NUWppekZpVFZtbDdtYlVFZWpiMUJDQWxZZ1R0K1lkanQ2?=
 =?utf-8?B?YWFGMDVIZ3dsOGZuMVNlQndhS0dVRW5qaWc0QmxyUmViTnZKVnU4YlVrbVlV?=
 =?utf-8?B?SlBZNlJJYmxZV1p5N1AzMjR0L3NzTHNhMmhQNjkydmJlV2lZSGQ4YURjb25H?=
 =?utf-8?B?RnJLQVhUb1A2REtSZHJzaXZ4WVRoMkpFRHR2djRQbHVIb1QxKzRXd1g3T3NQ?=
 =?utf-8?B?S2hUT0tLU2REWVBUU2kyc0w3VlVra0Uwai9IcXVoUURZZDU4dXlaZVJkTFkx?=
 =?utf-8?B?ZTRiSElUeVNLbFdYWWNHdjFyUXltL1BtWXppN1NUN2p6UU1ZNDBGbWF6WGhr?=
 =?utf-8?B?UTJjSXZCWGMzMXhZbTdZMWZ4K1V0dGwraTQ1VmxSc2F3alJma204STFQb0ln?=
 =?utf-8?B?WUNRdGdnRkVZejJtL2lVeTBmNG9CQ2VrR0NwL3dmRWlHVkhIU2duWkF3VHdz?=
 =?utf-8?B?N3pLSVE4NW9Lbml5NWhPZ09SRGRtZExFc2dLYWtieWh3Q0pJQmxnVEF4WS9i?=
 =?utf-8?B?K0FJdW1IWW04amlqekxtRjdqYTdrZ3JYNVBnaUEyRUlvWHJvZ1hVUzdVVWJJ?=
 =?utf-8?B?RXRQeUNjRnRJMUozUUFlM3NvWEhLM3QwWUh2bWx4MGV1anZ0K2dYdXlQNUFl?=
 =?utf-8?Q?Jzb9Wn?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: b9114ff4c8d143ecb73651d538f1ee2f:solidrun,office365_emails,sent,inline:d76a6378bbacbe1cb435616c853d49de
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ee169fa9-0c36-46b2-244f-08de494fa05c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|7416014|35042699022|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWdROHdpemptR2xEQ2Y2ajBLQmQweGJjeXlmL09BdkJWSE1hbWgzS0FpdlRw?=
 =?utf-8?B?VE5ZQnkvK3B2VUVvUmlMYW16QVd2aTFPRFBvODY5enhKNC9kTllZYzVtTXZm?=
 =?utf-8?B?d29IUEQwcnpYQmZYS1FkQ3FBb2hORkNsaFRPN1NJR3BLTE90SlQvblNuYlk4?=
 =?utf-8?B?eWtjU2NpK1VJQWhUbWM0VmJ6U05ZdjFOa05GUnZzTWtYYmdIVUZSZUpwQytS?=
 =?utf-8?B?TlNBejlzRkFEMWtiWW1BcFhXREtzMzJhckJjMzQ4UTV0SlJZNG4rQkpJUGUy?=
 =?utf-8?B?TnV5ejk4Z1JDSTg1djJSNGVvWkUwT0p3VmgwRkMxVzZrd0xpdS9ma2pma0dG?=
 =?utf-8?B?NzRheWRTNUxGdTlEMHlINm1WSWtOaFlTWkJ6Q1NCdzA5eFVOci94V3NSZVo5?=
 =?utf-8?B?MUs3TXd2UlFtNVJRUDZBWjAvelFqUVFvaEtwNWlQSitzcjBqRmU0cG9jZE1x?=
 =?utf-8?B?ZE13L3JOLzFVMmNUeHpoMDg1Vno0M0JRSzVZNTJRazZ5NERiVjBDakdzWmZK?=
 =?utf-8?B?bmNBcWJZV0pYaUNhN2tyOVRFZUEwbHAxc3o3TVVTQ2c4V1l6bDREN0VNV0xt?=
 =?utf-8?B?cTM0WFY4ZitqYlN6NmNBdVl2N0tzc1F6TUVxL2FYVEJneHFtYTdjUEh3MFdU?=
 =?utf-8?B?TlI1WDBOUUtPVEQ3VURFR1VSLzRGZW9ZK0U1NnhVazJ0WHZOL05LYjhtVXp4?=
 =?utf-8?B?SzkyL3Vva1dBb3NKVUJmUXhzOE9mN25sOHh6alQxTHd4RXEvek9mdytaUUNX?=
 =?utf-8?B?b0gzV3J0WUR6Tk9aeTE2NHNZVE02ZWNrZ1hCSkpSRENBZG1aWi9FeXkzOWlG?=
 =?utf-8?B?ZlR4RVpKSXp1Qy9zSm4vc0N0dWlUV1h3K1hOWW1ITjg5Rjd5QTkrME1aTkhq?=
 =?utf-8?B?c0V4N3hjSUlxeFZ5R0g2MDU5c0NOQjl4UFNSbmhtcDZsU3BLQXFjUGNadVIy?=
 =?utf-8?B?V3ZvdHdFZjMvbm9KWUhPTkJucmhKcWdscFJmSy9VUm54VFpFR0lSZHJwbFl2?=
 =?utf-8?B?Y3JOT0VTcXdCZFVwTmp3bUE3VWtRZU1yZjF1dDNFa3M5OUJqUW1JTlc4RU1N?=
 =?utf-8?B?U3ZlYUtpY2tnd0ZhNzJIRzRsZFYvbzBMQnNkOGtvWEpYTGhDSDFKZ3ZPNDZq?=
 =?utf-8?B?NUZicEIzSG5Yb1U1bmNrK3IzWHNDWWw5dkZEbWwxSjhlRkh5Q1VDR21FNDQv?=
 =?utf-8?B?YnA5Q1BCMVZsZVY0Z2VyeUZhcFh3aHN0cWpHMVRpRG9sWXIyV2R2WThKcTdN?=
 =?utf-8?B?aVZwbG03Q2NheUJTMVJ2bzlWcmhDTWJiZzY3bGhWdVRxRXJ1a0o2M21Kbko1?=
 =?utf-8?B?OTl0QzFvb01YYzlGNVpkQnVwUk9STjU5Q0QzK09ITGF0SUp6SG9lVDdEeEpl?=
 =?utf-8?B?ZmxhK04wY1FOS1FFMVJnazdET29UbzZ4eStSUHo1NDZaOTJTMTFRZGpHaVVI?=
 =?utf-8?B?TG5ZNW5YeDRyMEJmSUVPRG9EbjR2UWttVXlhZXl6dnQ1MkxKdHFMY1QzMDMw?=
 =?utf-8?B?UXp2anVGN1VZMno5ZFViZGlLRU5RaHkyQ2NxOFJIUnBGSmdUYVlnQTdmTGRO?=
 =?utf-8?B?dGloek43aTAvOXVoZmpHdFp6UmhKWlVRaFFGSTBZaU5jZ2dJSE1YV2dyMzVC?=
 =?utf-8?B?K0l2UDFCeE9ZUzhlb2pscFlpdnptamZ2OUhuTzdUYTlpUVZSVlhVMXRHRzgy?=
 =?utf-8?B?Y0JWSXVlQzVNeWVZbGtta25LdkMxODNGZTlPN2p1cUVadGdhcW9jdURIL0hY?=
 =?utf-8?B?a2d1VGNYYXhGc0poOGxJMXV3N2FTRysrVWQxdm0yWlc5S0VNU1lkZzJyM0sx?=
 =?utf-8?B?UmRmaGtJUHRZVmw0bGVwMHljQmlOZVR6SzFEYmtiSnRKSzBmRmg4aFRQZmQx?=
 =?utf-8?B?QWZMbm1DWU1QNkllNHJ6RG5GSVh4eXY4WjBLNWxUbmxIRHVMMjhwcVlGbWho?=
 =?utf-8?B?T3RKR29sUzlsZEFoRXdacUFHNjAxZitYMUhUSEhicy9HTXM3ZnVOalhtSDd5?=
 =?utf-8?B?QXNMQUNiTUFkVVpNOFV5cmdpcWZhSlgyVzJxSy9xYUVqb2w4SURUM2g1OGxS?=
 =?utf-8?B?Vm9xU05YdnVCMHFSMUozd2JuMnRQcG0yaG1pdHNsVXhFZUwwTnA4K21mYk1Q?=
 =?utf-8?Q?JFOA=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(376014)(7416014)(35042699022)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 16:05:56.7935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0a54ab-f1b5-43ea-5355-08de494fa5f8
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7325

When connecting RJ45 SFP modules to Linux an ethernet phy is expected -
and probed on the i2c bus when possible. Once the PHY probed, phylib
populates the supported link modes for the netdev based on bmsr
register bits set at the time (see phy_device.c: phy_probe).

Marvell phy driver probe function only allocates memory, leaving actual
configuration for config_init callback.
This means the supported link modes of the netdev depend entirely on the
power-on status of the phy bmsr register.

Certain Cisco SFP modules such as GLC-T and GLC-TE have invalid
configuration at power-on: MII_M1111_HWCFG_MODE_COPPER_1000X_AN
This means fiber with automatic negotiation to copper. As the module
exhibits a physical RJ45 connector this configuration is wrong.
As a consequence after power-on the bmsr does not set bits for 10/100
modes.

During config_init marvell phy driver identifies the correct intended
MII_M1111_HWCFG_MODE_SGMII_NO_CLK which means sgmii with automatic
negotiation to copper, and configures the phy accordingly.

At this point the bmsr register correctly indicates support for 10/100
link modes - however the netedev supported modes bitmask is never
updated.

Hence the netdev fails to negotiate or link-up at 10/100
speeds, limiting to 1000 links only.

Explicitly define features for 88e1111 phy to ensure that all supported
modes are available at runtime even when phy power-on configuration was
invalid.

[1] known functional 1Gbps RJ45 SFP module with 88E1111 PHY
[   75.117858] sfp c2-at-sfp: module LINKTEL          LX1801CNR        rev 1.0  sn 1172623934       dc 170628
[   75.127723] drivers/net/phy/sfp-bus.c:284: sfp_parse_support: 1000baseT_Half
[   75.134779] drivers/net/phy/sfp-bus.c:285: sfp_parse_support: 1000baseT_Full
[   75.141831] phylink_sfp_module_insert: sfp_may_have_phy - delaying phylink_sfp_config
[   75.204100] drivers/net/phy/phy_device.c:2942: phy_probe
[   75.212828] drivers/net/phy/phy_device.c:2961: phy_probe: phydev->drv->probe
[   75.228017] drivers/net/phy/phy_device.c:2983: phy_probe: genphy_read_abilities
[   75.246019] drivers/net/phy/phy_device.c:2502: genphy_read_abilities: MII_MARVELL_PHY_PAGE: 0x00
[   75.263045] drivers/net/phy/phy_device.c:2507: genphy_read_abilities: MII_BMSR: 0x7949
[   75.279282] sfp_add_phy
[   75.287150] phylink_sfp_connect_phy: calling phylink_sfp_config with phy settings
[   75.302778] drivers/net/phy/sfp-bus.c:445: sfp_select_interface: PHY_INTERFACE_MODE_SGMII
[   75.302778]
[   75.320600] m88e1111_config_init
[   75.334333] drivers/net/phy/marvell.c:905: m88e1111_config_init: MII_M1111_PHY_EXT_SR: 0x8084
[   75.348694] m88e1111_config_init: sgmii
[   75.364329] drivers/net/phy/marvell.c:787: m88e1111_config_init_hwcfg_mode: MII_M1111_PHY_EXT_SR: 0x8084
[   75.450737] fsl_dpaa2_eth dpni.0 eth0: PHY [i2c:c2-at-sfp:16] driver [Marvell 88E1111] (irq=POLL)
[   75.461329] sfp_sm_probe_for_phy: tried to probe clause 22 phy: 0
[   75.461333] phy detected after 0 retries
Settings for eth0:
        Supported ports: [ TP MII FIBRE ]
        Supported link modes:   10baseT/Full
                                100baseT/Full
                                1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Full
                                100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
[   77.445537] sfp c2-at-sfp: module removed

[2] problematic 1Gbps RJ45 SFP module with 88E1111 PHY before this patch
[   84.463372] sfp c2-at-sfp: module CISCO-AVAGO      ABCU-5710RZ-CS2  rev      sn AGM1131246C      dc 070803
[   84.473218] drivers/net/phy/sfp-bus.c:284: sfp_parse_support: 1000baseT_Half
[   84.480267] drivers/net/phy/sfp-bus.c:285: sfp_parse_support: 1000baseT_Full
[   84.487314] sfp c2-at-sfp: Unknown/unsupported extended compliance code: 0x01
[   84.487316] phylink_sfp_module_insert: sfp_may_have_phy - delaying phylink_sfp_config
[   84.548557] drivers/net/phy/phy_device.c:2942: phy_probe
[   84.557011] drivers/net/phy/phy_device.c:2961: phy_probe: phydev->drv->probe
[   84.572223] drivers/net/phy/phy_device.c:2983: phy_probe: genphy_read_abilities
[   84.589831] drivers/net/phy/phy_device.c:2502: genphy_read_abilities: MII_MARVELL_PHY_PAGE: 0x00
[   84.606107] drivers/net/phy/phy_device.c:2507: genphy_read_abilities: MII_BMSR: 0x149
[   84.622177] sfp_add_phy
[   84.631256] phylink_sfp_connect_phy: calling phylink_sfp_config with phy settings
[   84.631261] drivers/net/phy/sfp-bus.c:445: sfp_select_interface: PHY_INTERFACE_MODE_SGMII
[   84.631261]
[   84.650011] m88e1111_config_init
[   84.667424] drivers/net/phy/marvell.c:905: m88e1111_config_init: MII_M1111_PHY_EXT_SR: 0x9088
[   84.676137] m88e1111_config_init: sgmii
[   84.697088] drivers/net/phy/marvell.c:787: m88e1111_config_init_hwcfg_mode: MII_M1111_PHY_EXT_SR: 0x9084
[   84.794983] fsl_dpaa2_eth dpni.0 eth0: PHY [i2c:c2-at-sfp:16] driver [Marvell 88E1111] (irq=POLL)
[   84.805537] sfp_sm_probe_for_phy: tried to probe clause 22 phy: 0
[   84.819781] phy detected after 0 retries
Settings for eth4:
       Supported ports: [ TP MII ]
       Supported link modes:   1000baseT/Full
                               1000baseX/Full
       Supports auto-negotiation: Yes
       Advertised link modes:  1000baseT/Full
                               1000baseX/Full
[   86.149536] sfp c2-at-sfp: module removed

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/net/phy/marvell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index c248c90510ae..6be2e2eb0be0 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -3752,7 +3752,7 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id = MARVELL_PHY_ID_88E1111,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1111",
-		/* PHY_GBIT_FEATURES */
+		.features = PHY_GBIT_FIBRE_FEATURES,
 		.flags = PHY_POLL_CABLE_TEST,
 		.probe = marvell_probe,
 		.inband_caps = m88e1111_inband_caps,

-- 
2.43.0



