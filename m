Return-Path: <netdev+bounces-250885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B981CD39690
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B141630010FF
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CCC3321CA;
	Sun, 18 Jan 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="S4ks6KhH";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="S4ks6KhH"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023087.outbound.protection.outlook.com [40.107.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53B32AAD2;
	Sun, 18 Jan 2026 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.87
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768745292; cv=fail; b=hXazNWyWglbPa+cdxYrQjv5Pibd1CssHVGnMNNMAOAYMO0em7tndhb32aLzoT6KIcQsFGwkfuA3M+yqPXGNTgHgY7TJvWzKz96wwur+ldx18kT/og1973CVfwmqI6vKX2K3oUkNKVE3WGjxhWZc0/5CKOEGLzT5EgMJuhCcLd2s=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768745292; c=relaxed/simple;
	bh=e3BFqZ10CoGBlbUxfZZnO9jQsd/JTuZoDdf7iSldHG0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sx8B7PUpIEkn0KFl9JTPl9Gf2mVVpCDynN4R4LlaniUDkpyuO9g6jLT6CoIfFshEtvJ0+kX8RLpzRoY/TxZsUDfAwtv2/uEysWM6v2Ee+BTgilabOy0XYc639DDi3OOmsCm+6aO71CRXL/d0OfvmhiBLEYpKOtdXxB5dM+QJVXo=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=S4ks6KhH; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=S4ks6KhH; arc=fail smtp.client-ip=40.107.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PyPmejKtvr1FoQOk6vGPUIeLdJZCqB7Z3Kx4r7guWszy4DFFg9JSNc1swH5h9TkCU2QdaSd0KHmAd7KnSgsBZaJCfAE3e3A/YZbeTy6U7+qiwdKLZLmnsDZqU6DpQ5wqZfFcCrEhjTtfkLPG0wyk7nFVaIeXVK5zlJREidsaUhJlVzPoPbg2oCO7L2z7pGyvgQj5F4GrUFaYhHQ9ma9NhjTi1KRWOxOH4NDGsVhc2Epq2wuUkPSNTZQPoQ9Enxaw2u2ASzngCWfsmdb6V1jgLgnf224B6rvBzsTe9DmoYoEjVmbrSWlzZlnD61ym/odnF38qWmdSGUSnzWmuDlmdpg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YyXqUlcoBvY67dESOdvDTtY0BYatUZWYYbU4fEZTWk=;
 b=kEThSBa5luTtqSwQ6CPxkpmODFIgp9A1ppOqfmtOY8o6ZHMkbYiUMlpr0OxnkItg8SK3ClxlwldkNB/A0BUGSOKHMLBSkyWY+HKG4U44FJzLWNBPYoW3InGvPylw6RD+0N+RabsgieJtmlgFHLmpxhp5hACkyD7VS8j4M1SMsMTOQVO7yatNfb5D7s31A1j3JsAkBKcaJUMfbwtQn6CMmEWFrAxsecsPoSj6Pnvi/n2mKBeLKXvOQZGKqrsRX5iWUomZlJU0vTJUPlVMGaicsJxoFWBm/DrtiyUdebecMG7dRCRG8GoY4TJYMZM1OSkFNNMhKjxvwGeOunJ/ZLe3Xg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YyXqUlcoBvY67dESOdvDTtY0BYatUZWYYbU4fEZTWk=;
 b=S4ks6KhHTW8Cu+nDyP8qnzHGjzS+1BHTbYbail+a49jJbysGMkihUF1Cxjn4WBbi/EBnQRQcW5sHaVs2JXREFTUO28bpvQIHr09vQ8XbTs2nIx6J7xEhVZOQK2sPzwiQzA10Vt9JzF3lZiw2aPNHvdtajY+bhXPWu/9xo3UcXq0=
Received: from DUZP191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::7) by
 DUZPR04MB9948.eurprd04.prod.outlook.com (2603:10a6:10:4dd::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.10; Sun, 18 Jan 2026 14:08:07 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::ac) by DUZP191CA0026.outlook.office365.com
 (2603:10a6:10:4f8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Sun,
 18 Jan 2026 14:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (10.167.8.69) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via
 Frontend Transport; Sun, 18 Jan 2026 14:08:07 +0000
Received: from emails-8521323-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-103.eu-west-1.compute.internal [10.20.5.103])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 2BE237FF28;
	Sun, 18 Jan 2026 14:08:07 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768745287; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=9YyXqUlcoBvY67dESOdvDTtY0BYatUZWYYbU4fEZTWk=;
 b=nZopKp8vdAYJPVzQnQJp1uYiwagG91pyfNlpO56hqzUfD8m9mxyiR5j/mWYem48khzwkc
 Gw4Jjdz6qOSRqKBy9z7+cpPmJ2mMeNjnkeB9HA0QbF9i5/3vCPg6dObCVvkORSuOFTC0HbT
 Gngl8s/OJFPV/C3C8fgl4qYWeaaOs1s=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768745287;
 b=Ro+3FX3nSBw+kn/tIeoEbkU65qHWBk+RLuZUGKoXGAIP5zqu+YO5IeMhgq3aon46ucSbl
 +MyzNDBuPqJzn+K7WiI/TNaHr00XvhziPOBFgRt0/Ows2UkA5R7Knxr4dpHxUIvVCnCbEOK
 uwyZoPvfgXGZx8cCfWBTm/Ejnn9FkGw=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3eWMDoRWuMJJgzfTWLHIXFRopUsp+bHAf/y3aaM1Q9EkfmUd/Dhq9gLkgXKjkHZc2mhLUw/Ta1OaJjzPku7+1Liza1P0g7lY36OA5oXGYdxdIHai7PZEvJFa7OtpWd1TWAtNAYwjapuG4CvaZHnxtneWHOQ7DXguj5zKageDGr+x3OCWf7j5BU5FwNKhvPTkjwKhr3i+W3a2q6gHLWSkMWHeoJPyw/a6MqGYOWiwjM9T5zXR080+ozROt1Rild/gKeU9hRzSOC7mKDJpQiSYjy8l5nWX6H2nAhB6c7e7HJFUV0fjK4tFYb0Fcq+z7wtI/1f/5e5sQC6XteqPbLxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YyXqUlcoBvY67dESOdvDTtY0BYatUZWYYbU4fEZTWk=;
 b=UK3nY1tz8YkoZpv+iTTZoIGyXmZa2H0ipcftIyrXAKOQrILX7N/sevcmnmHXxCxeOtRqsjByVmaUVBYOGI8TVmrndowTVFFWsPrjtz24Oyt2qAtRNuLGldcf4KOq9XCaBXGtlagltgCOJ9S21dzC5vx/f2Xb3py7Su9Vih91l+AwcmoGe+jFWmjwKW7uYLse0ucTX6HXv4s4GQJVfMOATOzOTmMmebeh0mRt0WLjcHouNZKnYEloElHbiUtehEsItrqUqE6jqtZJlc0hcY/q9Shc4ymIYOVjaOuNhIP+haDpV3dMw9K+zx+8xZFMbae5LarfmRXGU8R5yPLOU2JeVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YyXqUlcoBvY67dESOdvDTtY0BYatUZWYYbU4fEZTWk=;
 b=S4ks6KhHTW8Cu+nDyP8qnzHGjzS+1BHTbYbail+a49jJbysGMkihUF1Cxjn4WBbi/EBnQRQcW5sHaVs2JXREFTUO28bpvQIHr09vQ8XbTs2nIx6J7xEhVZOQK2sPzwiQzA10Vt9JzF3lZiw2aPNHvdtajY+bhXPWu/9xo3UcXq0=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI2PR04MB10977.eurprd04.prod.outlook.com (2603:10a6:800:271::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 14:07:58 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9520.005; Sun, 18 Jan 2026
 14:07:58 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 18 Jan 2026 16:07:38 +0200
Subject: [PATCH 2/2] net: sfp: support 25G long-range modules (extended
 compliance code 0x3)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-sfp-25g-lr-v1-2-2daf48ffae7f@solid-run.com>
References: <20260118-sfp-25g-lr-v1-0-2daf48ffae7f@solid-run.com>
In-Reply-To: <20260118-sfp-25g-lr-v1-0-2daf48ffae7f@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Rabeeh Khoury <rabeeh@solid-run.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|VI2PR04MB10977:EE_|DU2PEPF0001E9C0:EE_|DUZPR04MB9948:EE_
X-MS-Office365-Filtering-Correlation-Id: d3629c67-7aab-49cd-db42-08de569b012a
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|18082099003;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MWliV0QwUEtjOUhLZzNNWnhhRkVKZzMyZGtZS3FyaW51eG1qRTByRGptNHF6?=
 =?utf-8?B?a1F3SFpaTkxNRTVwUnFaNjJGZGhpY3hOOHREWGhMQ3FoallxM0pHREN3dkF4?=
 =?utf-8?B?V2tnWmt3RDZrWlJxNzFSMUR2RDh6czVYRVMvRTZIblJBTDFudmkvdDhzQ2Ir?=
 =?utf-8?B?c3h2N3ZuRFFnYVhJaUFHZ0pvZmxBdGpDRE0vdi80Z3JvdWRUbjdONVdXVlJz?=
 =?utf-8?B?NnV0cVN5dFdRTE1NZWhyY3cxbG03NS90L3lWSEhPZDNvejRaSnpLOUZkSEU3?=
 =?utf-8?B?Z21XaU5NZXRPSDI5ZUFZbS9GZENpNEFrOVBZRDBvZFJlTFdLZHljelR1NDU4?=
 =?utf-8?B?S3cwRjVaYzZWT1lwdm1ZZTc3WlVtTFJ5c2ZGcXZGQ3Y4eloyWmF5bmFpaTV3?=
 =?utf-8?B?aFJXeFB2ODI3SVpiaEF1dEVXNGgzS3B1aXFwY3htM3hpRmc5MnNKekN2cU5X?=
 =?utf-8?B?a3J4a3Z1MTZ6UkxwNmJNM0FPYk51ZGFtTWMwd3dBajIrRVZWQUllS3NRRGN6?=
 =?utf-8?B?MFFlTjdMa0g0V3VZNjA1eTU5bHBNVVlPcStEYkYzdHkxcmRnY2M1M0NjeXpv?=
 =?utf-8?B?eUwyNTlrMXUrOUowUWtUTzZPMlQ3V3BkeU1yN1B4RUdZWXg4M3RSOTFwTGpm?=
 =?utf-8?B?NmlSMXh3eWRXdmN4cmk1UHI5ZFBQWXA3TDMyeDRyZjlncG9jam5LRDdCbEcx?=
 =?utf-8?B?dU44STJJbmRuMWdUT3dadjNSZ3QwZ0VVRzZvMTA4djc0VFVqZnF6TXlmWWw5?=
 =?utf-8?B?V3d3M2NDbjVGNmZwKzI0Vm5Zd3VyRFhDdlg4cVFXMlRYb0RUM3pCcmZzS0po?=
 =?utf-8?B?V3hQdnZYZmE5c0tGRml3SlVIdXVpdC9peDJoSkVyeENZTGc1MzVId2tCYmZL?=
 =?utf-8?B?V1FxSkFvcnVBazNuZTlheThLRmZEcFJWRUNtWWhWcmpjL1RoYmRabnVKTm5t?=
 =?utf-8?B?UjVmWU52UVRxNGlheVh6WHl4b3BVdThhNzlBTEtSN2RLZGdWNWV0VHNpT3ds?=
 =?utf-8?B?NjJGQStyc2RuT1VXLzJHVFp3NVNNRmZNRnhqNTN6Witjc0U4VHo5U20vblY1?=
 =?utf-8?B?SWdLeCs0c0lDSW9UblZvMnlIVjFPbC9ZS0dWOU9PVlY5U3hPRUh2MElDZ1cr?=
 =?utf-8?B?UEZDWS91RXYzOHJ3VjRkaUhyTWw4dVZncE8waVdpZjBnejBKSmJwVU43VU1r?=
 =?utf-8?B?UnEyTnlNRS9CdERvS0g3WE9aelVybnVJQlZzcDhZTExNbm52endSMDRodEF2?=
 =?utf-8?B?b3VEK1hBcEdaTWJydm92R3Jvc0N5MWk1eUhnM2xuOEpFK21LYWNhMTVGT3Ez?=
 =?utf-8?B?dmp1YkpqZERHUlM2a3dtSTRqU1UyVzdvQWI0NDdia2lISWVBUHkzaXZpRlVZ?=
 =?utf-8?B?V1RyYjlCeVZBaGhEbTJ3cjBJTEhFSWxVVGlqeUNtdWFuNVJsbko4Qm9vVWZx?=
 =?utf-8?B?bmRMYXJpT0FycUNrYVRIR0VyOW0xNjRsTGNONERnS0VtanB2UmhFU1ZMVldJ?=
 =?utf-8?B?UVRDUDM0ZSt2QTk2VkpDWXRmaVkyTEJpTFQ3M0s0UlpaZGVoS1ltUjgwQ2Qr?=
 =?utf-8?B?Mkh6NXpUZ1JkN2VPalUrK0V6UUE4SXM4MWlHV2tBUk1iYzNPdGN0RHpBRDBi?=
 =?utf-8?B?bEpIL05WWGpvWHFGc1FydWR6RjVEYnI4L3pIU3dxQ1BSbEZyVGpaeHVMQzRE?=
 =?utf-8?B?TTQrN1AwYjFNRSs3ZjVVL0J6VFZ3T3RwRDBmclY1ZkdMUkIzUjh3ZjZxTlBV?=
 =?utf-8?B?VEd4S09jOXUzYTlLczE0SFdHdHhtWHNyQzkxMXdJYzFXV0l3ckdtaW9FcGww?=
 =?utf-8?B?bFZaZHlqWnJOTGNiOHhrSDZQQXRSSGRLSzZtRGdqbzRJU2NEdytwNndOL1VT?=
 =?utf-8?B?dHd1bXJZdzJYZ0FDT3B2K2xEME1PNWQ1cS94Y0ZPSERaTlBzUjNJSG9pUEs5?=
 =?utf-8?B?cWxZUVpRczRGb1RHcmNKWFY5VCt4bCtjaTd5UGE3ay9JdUFiVVUyMHlKTHFa?=
 =?utf-8?B?bVdFbllVZXJEdDhMaW41RzYrS3ZaTFVFRmFtamdFYTFiUXZsc1k4MEg2SGNX?=
 =?utf-8?B?cktuWUtXakhHWXVTbTlXeXVrZkZLU1JhU1hsaTBXWnZqczE5Q1kzRS9kSDhq?=
 =?utf-8?B?cEN2djJoc2p6d1Y0NitWZFh0a2V1L2o3UDJibGJ0QXg1aU1ZeWtzZmptY1Iv?=
 =?utf-8?Q?QJq8PsDByzSe15YXZChnfpY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(18082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10977
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 6c46659288b848e9b86bfec171638baf:solidrun,office365_emails,sent,inline:49edc22648e717370c50bbc2ad127be7
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e8b0ff1f-f819-4d20-238c-08de569af91a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|14060799003|82310400026|35042699022|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUg0U1pRcXc1aXEvZDdHcllBOGpDVFBva21QcU8yUGpFQVRtWDkwc0tvVWFs?=
 =?utf-8?B?S0VTb2VRdXlRdk11OTdQdTA2NkcvM0JnbzBnSkhJK25BRkptaDJCeE9ETmtJ?=
 =?utf-8?B?Ry94ckNCbDZncVowaS81UVhhYnh4eHpnYkcrcGZ1L2toUWlwYXE2UjhrTERF?=
 =?utf-8?B?bWNQQ0VMdWprNjJmZGNUVXZ3TE9tRW9pN0RlTHQ4K3ZaTDgwYVR0M09LV3E0?=
 =?utf-8?B?Q1R0KytVbU5RNnFzaFA3R0t6a0ZXdkEySitpaTF1aUNSMUZkOFNtYW9YOVNl?=
 =?utf-8?B?WHJRLy9Fb0l2ZHZwaUhVNHlzVVNtVUVJeE00aEd4Mm91RWdYeDYrV0kvM3Zy?=
 =?utf-8?B?OFZ0TzRoSUxCK3ZJcG10UkViNUsxZTFTd0hCUGtUdGpoWExDMjE1eUhMbHZK?=
 =?utf-8?B?ejRNbWZqL0huVVpxeXMvVnR0NTBnUUlJSXp3ZTdNMm5RTFlpY0NTQnR2aWdq?=
 =?utf-8?B?ODZnRndSd29aZFBkb0tSdW9vM1grTFBmWjdIeVVhUnBQOSsvaVh0WFltWGRY?=
 =?utf-8?B?K3k3dDVnakY0NjhvOXBxd1Z2RHhTeEsyYS9ybkZlMFNLRjYwUnFCc2xKSG4y?=
 =?utf-8?B?ZjlWQUplN0ZTTlZTRi9JTVlkKytKWUtrYldyTFZRYnZmZTNQdkZrYmJ1RkZY?=
 =?utf-8?B?emYwdDRiMjl4ci9YWEJTckhkdW53OFh5enV4M3lZanl6aHpyakE4MXk1ZkFo?=
 =?utf-8?B?RmxRbzlwMWd5azJaUXJTQWFYRlBrN0N4ZTFDKzZWRER4UnFoMFE3cEdzbEsr?=
 =?utf-8?B?aHgwemVkb1RzdWNjQytPdlF6LzlnMHpFRTFvamJsL3lhQVBpbEwrcFM1U1pj?=
 =?utf-8?B?aWhDWlVyUXU4RWtFb3N4cnVWQkxkNEl0bXRsNktXeVNINjRLcEVwUGN5R2Fy?=
 =?utf-8?B?aGNEZllmWHNOZjVJeS9GYUdxMy9pNnoyRmtvbXVORTFhWkRyZmRLYXd3S25n?=
 =?utf-8?B?TVhSb21vekFJdlpQT1prVzdibkVNOVF5VDRpbmg5V1d2Vk1Yb1ZOVjRoMVgy?=
 =?utf-8?B?SXI3ZVl4NnFGajZ0YzFYS2RsUFVPZWJvKzRlMldRNkxDaFVrTmN4QzFLa09S?=
 =?utf-8?B?d1gxWGx6dVROZHFpMVplQXVwTVRSNUMvR3hLa3BSZTROcEhjOE5hY3JKVnBP?=
 =?utf-8?B?bGJRcTRtYUl0OFhPS2Z0RXgwTFQ1dENwb3prVUVPNkY3MzdERGVzTG9JRDBp?=
 =?utf-8?B?TGZueXBWMS9xYTdxc0k3L3hmRDUvbGFONHpYeC95VHJyRi9jem8wdzV4ejhH?=
 =?utf-8?B?MkVuY01IdG1UMmk3WFZYd0F3ZHRPSExXUFBVQndCWm93Vzl6SlZXNklsZitI?=
 =?utf-8?B?cXVQektrSC9Nb0ZWdW9maVBieGJueUtmVUg5bE43REExWHVQTnhKMUhFT240?=
 =?utf-8?B?em43bGluY3VMdTJFN2U2WG9xcnFleklEUmwwNEpXZnFEbmoxOWdFNkNCY2p2?=
 =?utf-8?B?aGZtM01VSStULzI4RDFmQXM2RHdQRmprV3R5WnlsVk9lcEdaNzFZdjJlZHI0?=
 =?utf-8?B?cEZxbmZXLzV5cEFwQmROYms4RmpjYXZHd3RTYXdDUERkWWZOQTNVamJ0TVQz?=
 =?utf-8?B?V0lxUGp2R3N0R2JNa1V2NDB4a043amViWEJHdFRTVEFWNlFJT2lBMG1Lbllh?=
 =?utf-8?B?dHJRNTAxeTRuaVNLdkV4bGtnM0l5WkJCQlFjb1hpSVV3eEk5emRPM0JMVzNZ?=
 =?utf-8?B?WVl3WlYzeVRTd2Q5NjA3Qkp3V0JIMUNxVkl6Mnk3WVE2VGhzMldNUFpLM2I5?=
 =?utf-8?B?TXZGYWJPUXRjM01BdlUzZDZUSWhvTGR5VTFjRyswOXVGeHM5OG9DeW1EeWsz?=
 =?utf-8?B?MTN5dWk0Sm8vSnRVdmNCeUUyMUtoeC9uUC9vQldHYXE1bW5IYUhQbEttcFVM?=
 =?utf-8?B?ZFdHM2YzWWl6UkZTK3VtMU9kaTBSRHA0R3ZvVjR4U3pVMTJ2NnJJUGhIR3hS?=
 =?utf-8?B?ZGlocml5OFpPN0VURWVWYUYxendqZVRDUHlUODJkcHB1SE5GbmhCUWpQcUpz?=
 =?utf-8?B?WWRscmlXZ1VDSVQvZy9TNU5xd3RKazRTRlQzUms3SjJkZERvLzFJaytEY2xC?=
 =?utf-8?B?RmFrRTI3a3ZmVnRaNkFxM0lDcThSek53ZDhHRDg3ZlpuTituODc0QzZaRWdj?=
 =?utf-8?B?WUh2bVVkR2JQR0lwVURUQ0w2elNGWkxBaU1qV21mVkVXVWU3SmViclNscVht?=
 =?utf-8?B?enJVRU8vVEpnUzhvRjZoOEVaQzRTaVROSEp1ZUVjODl3Y25DRkIzQW0rdVdW?=
 =?utf-8?B?NWs0bmo5UStKazFFVzNxdFcwdHFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(14060799003)(82310400026)(35042699022)(18082099003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 14:08:07.2270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3629c67-7aab-49cd-db42-08de569b012a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9948

The extended compliance code value SFF8024_ECC_100GBASE_ER4_25GBASE_ER
(0x3) means either 4-lane 100G or single lane 25G.

Set 25000baseLR_Full mode supported in addition to the already set
100000baseLR4_ER4_Full, and handle it in sfp_select_interface.

This fixes detection of 25G capability for two SFP fiber modules:

- GigaLight GSS-SPO250-LRT
- FS SFP-25G23-BX20-I

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/net/phy/sfp-bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index b945d75966d5..2caa0e0c4ec8 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -247,6 +247,7 @@ static void sfp_module_parse_support(struct sfp_bus *bus,
 	case SFF8024_ECC_100GBASE_LR4_25GBASE_LR:
 	case SFF8024_ECC_100GBASE_ER4_25GBASE_ER:
 		phylink_set(modes, 100000baseLR4_ER4_Full);
+		phylink_set(modes, 25000baseLR_Full);
 		break;
 	case SFF8024_ECC_100GBASE_CR4:
 		phylink_set(modes, 100000baseCR4_Full);
@@ -342,7 +343,8 @@ phy_interface_t sfp_select_interface(struct sfp_bus *bus,
 {
 	if (phylink_test(link_modes, 25000baseCR_Full) ||
 	    phylink_test(link_modes, 25000baseKR_Full) ||
-	    phylink_test(link_modes, 25000baseSR_Full))
+	    phylink_test(link_modes, 25000baseSR_Full) ||
+	    phylink_test(link_modes, 25000baseLR_Full))
 		return PHY_INTERFACE_MODE_25GBASER;
 
 	if (phylink_test(link_modes, 10000baseCR_Full) ||

-- 
2.43.0



