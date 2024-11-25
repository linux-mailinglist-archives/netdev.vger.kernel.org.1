Return-Path: <netdev+bounces-147195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47E9D82AB
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13FA2824AA
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2494E1917D7;
	Mon, 25 Nov 2024 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="tQga0QCl"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A618C92F
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527562; cv=fail; b=VLjSuPelPE2FusE4Ks3eFHmT5ad4JprKE5Wrrs20vqVOUxWAXvUk/4l6W4PPNesaddBbhpgDDOQ+OutNME7aZQIh/6QeThHrkQIC8is5etQ2lLcP2yR2AQLjDcWB/wK7nfiMRs01AoabWBK9Xi8qbqk486mQdyXxO38V9YjbZ+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527562; c=relaxed/simple;
	bh=ZV0208b5mC5WJf5eMQhrTqm+FYhc+bIClLLL2D5jIvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GOzw5vPgHP/Viz6ApWDCrrkuN1x0EWpErWIOwBuPAR8shyoA4uW41o0IRZ0my0aCDyfxCnjfq/L22Zbn+GOOGxzT5UNLHj3Nh/s/9nm1SLvu9kdKUJayYGuOCp0kxaRzJPpaCjS1v88cUh0QJPN2O2WUM+tTDd2vD0r5xyU7Uz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=tQga0QCl; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6267081ED0
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 09:31:23 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02lp2235.outbound.protection.outlook.com [104.47.11.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6183C1C005D;
	Mon, 25 Nov 2024 09:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZdgJuYPukr0qarHa8HvFWuow1Q6mSX2pE3gDTTH7R7XGSMHBx9wBjHvRoQ6FyVJdfEvWR76PmdGs4k54NX+b6UvFsVOt32EXbAYhjpmQPsb5hsrPk/GfyA0ESFSyqXpL/AoasSbCy0H1K7w5dw5PH99TUN69i1C/wna6/KeVBMrSs7a61zSENrmv3OWVKYZ0E2koUnjqbsJSqt2fwy8sbKZOT2N0myFXoU7m1oTSv6adaKyXs4HGpRYREJ/8UHCM+AddtZbff6IypYiim3id0qH8/4L6Ao2yT+y4LrUEvZ0j/NdKNEvAmVAyv2fZoLthXscyyfBqrvihRHl2awaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMLxCGHZ4JQ2BMjZTZNVM3+bzUd7NN1aLj29DsF1oMs=;
 b=kD3jqx3nQyQfMpYwObYAmFaL8JN43EIF06R2cz60WV38jh6Z4q0DELpk3ps4tmfEqIYMON3Ah17yP7a3aAeKMpcrREtE3LbjaBdLSA0EcoVSmR+VdzQWyTqZkXGslmaLjvoJia9j8u8eXsmuCOjI559PFagjm3h8Coye3bGKSiqqm1hst0k81awedk/IaVhAkk92n62afOeVJFsvXYsYJHtUkutC7Jk3JW6PPVpWopd64G9FZqFRsjJz75+6XU4/mrKt54DSdFU0waX2AKuBcW9DzNfbZVqdWlzWJqxCVh8yMIatyK5+MUtVOc17jefYZNjfGcurTHrRHgxOO6jecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMLxCGHZ4JQ2BMjZTZNVM3+bzUd7NN1aLj29DsF1oMs=;
 b=tQga0QCl2r3rfs4Q6iBGiIC07Wb3dGRCLSx6mTYXCGOuFzHA7CPy0VFzezoY/cVecd7mU4l0QxKz+hld18h/DRcWy6B8AUmFlM3KMkoY9ISBFZB6w2CUVBP/UU6T1qOj4+cTMVDIm3FTLuBGsdDsAgdHCrm1dVR0iASVAlvroBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by VI1PR08MB10148.eurprd08.prod.outlook.com (2603:10a6:800:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 09:31:11 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 09:31:11 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: Avoid invoking addrconf_verify_rtnl unnecessarily
Date: Mon, 25 Nov 2024 09:30:54 +0000
Message-Id: <20241125093054.3014390-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118182004.5d38fac2@kernel.org>
References: <20241118182004.5d38fac2@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::11) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|VI1PR08MB10148:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d0148d-27a8-4559-a9ca-08dd0d33e5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VdeHkcvJAyFHPBUs38Yy0zhkgmowXPZqkllrSTdndKXwvVUShP+NApUmJfsp?=
 =?us-ascii?Q?7Sxa7fqCXeyGSuMNqE43wxiiMxUDG3yvJmk0CQHvCud0Conz0GDAqEAPZkAl?=
 =?us-ascii?Q?V/TB/VMXOfS281WtCiIUrWFzd52f3LJ/wkpzsCb9nrORhsqz4+HF5xfRAJWm?=
 =?us-ascii?Q?In9F2o5m8fKOvrIU/g5xAousIo8+vbuMKuw4dyYCGDheVUi3SS0XmUhLPgLM?=
 =?us-ascii?Q?YIOsg8YRhnqbmDLh6MKjxt+oIxaOujMce6Bpln1XRXPRm1XI5pM7PfNHamfZ?=
 =?us-ascii?Q?L5NbFWGApqtgwQ0/BSSKxs0P8M5a2jaAVtZmQDLouWsRgeohcr2R8/qzIhwA?=
 =?us-ascii?Q?s/Pn/QY6YPmAyneutUY/kNCVKDNMW+Z8ZKhvyaRXEO+3heDCCrE4TxqTRDxm?=
 =?us-ascii?Q?QlbTbfr1bseKkjrrjgmAexVWumeSr2jotzFBHIkesRkDF40ffFYKlfpMw6MN?=
 =?us-ascii?Q?Q32irNaoJ7A7xJPchx6uZmvQQJKYkCixPP71Bi8+FHNJcKZBWQPSSC9QRKcS?=
 =?us-ascii?Q?9oz3eUO3YmNx6sNApU3mnkKSAAa5hGHnQoUTrnyNH+HQ7KzRw8IcM2YxmOec?=
 =?us-ascii?Q?6ZX96n0myDjlAOKwiXxK3ow4n0UVJe7nRWK3vV1+Pm1PWn7bpo3qC6lYMWMO?=
 =?us-ascii?Q?+kcZC7t7wgbhFFm3YhtGLjVEDMzxxnGTXDPRUfBeCI7kO/6CJpepfBket+oB?=
 =?us-ascii?Q?FmBjRxcdTZYXsuBhy6I1L17EfkUiPgL0X8XwWLs9RisdoqssOgtlfUvn+ySI?=
 =?us-ascii?Q?oSssp/EAW1DBXF0NaeOYMsVFSbnqKdJLJSI4evvqXvGJfE6C+b+TTWf8yAH5?=
 =?us-ascii?Q?XLjC6tE5tvNgKaUWtLsz/PET8ODiVMHx2ZVkjFHc8e8GvbQY7vHIzX9Mwnpf?=
 =?us-ascii?Q?n2IZRZYaQPxe1lEldw7pG9ro/tfqseaMIKqECxOhSanVpFEwszgAcPNV+ZyA?=
 =?us-ascii?Q?aeCQJSTs7Dql/K3F5VciOivK7JL8+csl3/KvFw+tUszq44k9SDxRCYTARz2g?=
 =?us-ascii?Q?uPDhPNhbC0tuFrMJTgiQOUiLvN8WSy7ulwzx7Fz0UP2Mr2FvsbgpA7WcMSSe?=
 =?us-ascii?Q?uC5f+JATOZNyUiDDiXc14uXhFq+fsQBSZcKZLyHrI/DDXHgz2a6pEhlZ1O6L?=
 =?us-ascii?Q?sliAJVT32JwKiAVwNf2tDm+NoU1rHYzCFg+eStLr7TzUj83tynwXEmcE+hDy?=
 =?us-ascii?Q?V42SuevIH9KJRhv1OZSigZrPPIiIaVlKpP5xCnDf4GwVCiF8GDTsYKqt6ixS?=
 =?us-ascii?Q?MAZH26dZiJc/1IALr7MoOisjUFQytwHbguyUzu1qeB4DfgM9jo5Y5jW7vFoA?=
 =?us-ascii?Q?tJG7TBOLNaNuUi3HGxiOXlPsPxwJI/8UXmeozGA0EYleiJucxYzHbmniLgZO?=
 =?us-ascii?Q?XLZB6J4gVlVc5EMNpWvoA+j1wiMvfuFIRZxsViPNphADJrKAHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r+JxyIyiQHLi008zCChJ+4G0YYWozq4w0oPca+5fiCMsTNj4nmlT9WCg28GW?=
 =?us-ascii?Q?sB/uV/tJZHbmUP/b7xGfG0zybbxqGbWA+yz7psc9ES71JEEAJmiDSDXb6KpJ?=
 =?us-ascii?Q?BdrFa+WpLbd9StsTT+I/2sxwTDsRyMGch10AUEE19xjNrAoyq1vNHH8uKLN4?=
 =?us-ascii?Q?a+gWY2GKYpFAmpXf5uEc52HSpkSr9sMvaYlAIpx764aJ7inHVGnBwCYLVGGg?=
 =?us-ascii?Q?Y6nuWhDaW9b3e2kLQ2aZzpEFhpejuiL4ki5XjjL7rUJ5L07lFxbE7HrrAKz1?=
 =?us-ascii?Q?dCF7JEi2eruimdvpBTYbWXETFX/mR2V0h7rzWAGutcn+GiNo8A9yWzTBxJ+b?=
 =?us-ascii?Q?BDFn2zNp9kTxYaGAQBfX2aoLslfQY2f0uOKASm688n+kxmlezP8zQM6JbmV/?=
 =?us-ascii?Q?6xNsjEc/TnowDEpAe0zfAmyhvJGtNv+GWHCvF2qh7TMGZfVSHJjN8343n0j3?=
 =?us-ascii?Q?r1nKv7TF2mI5eL5ZA+44S8C0dF+R3fA2qlyLa5ZEx1dgw+jgEyxTabPMBcnh?=
 =?us-ascii?Q?3kFyn8R5WzahIu/w9x+9/3XbsyPLfVUbXANK2Bf4SiLk2rGgSK+cluErj1Hw?=
 =?us-ascii?Q?6UvlV1OZqpc3mBaJW8w2cE/nLG0EJVTe00MmBE/yLTEK5eFBauUpFWIfKfBR?=
 =?us-ascii?Q?3ZSyAk30FvQWQwx9jySg3TTFkt0V5EKxhLO+ENTiK42AVSVAqQLDMd71ZYHT?=
 =?us-ascii?Q?FFds/iBesoHo4acokRQ9ELJMuWJiHgsqNW4nlkdbyKpIPrPosjlfcH36jg/3?=
 =?us-ascii?Q?r5zxrhSw7tOjccbAVbgoiaIox0zuUnvh3DKDKlL2SN3hlW/G0DPE436PqNfz?=
 =?us-ascii?Q?c9lbyUk23ZsgOCPA4PfcRjSzfw2w6F7nP1Dr1YrUjEny+RPa74Ve6mnXRloV?=
 =?us-ascii?Q?V+4oQnbBtZUxm4cp3DbvL45zcMW25ExX2wgBLF6LJAZLukihAe1aF21e0VaN?=
 =?us-ascii?Q?qhJJ4qGK7vN6XaEcgOU0wOGHIEXbbF25VD/YtC6Moa88Y323TXoE94s/yB/c?=
 =?us-ascii?Q?tAeiR2CaKKgTIja9BeeFEam0g5BOHlG8sJp/Gq82rcvaoVxDjKIxFZkPQhDC?=
 =?us-ascii?Q?ljk+yuV4NCSyFKaBbOY+kviXEqPe7Oj233sVNQ+DksWhKa3BhYrXPwmf/U70?=
 =?us-ascii?Q?XTuccfDJMjLaH/ttKQC6P1hoa28wA1F4fUHPHSP7l6Eqfvcr92O4Hqm7IwLr?=
 =?us-ascii?Q?LzQsG/6RWrJsXEA+6EXGH6Jvuru2IKjiBvW6VZ8hc533BOt0NhhKWIE8gRb0?=
 =?us-ascii?Q?qyfNIZAtDtz4icyEy5pDp6e8I7IqoLuAq8lK0KcPESB2MeQReE6paJS0MauV?=
 =?us-ascii?Q?Wf6LPCMX2GP1+sLprUW5HKTeMLUXC4POgaew7HJlIM0Wdf8ytkMbPflMrCuL?=
 =?us-ascii?Q?55ZAydKnBj6Lq2UutPpJUBMSPgsgz94C7+Lsg4zA17RSUyJaBj5RP6IC0bXA?=
 =?us-ascii?Q?qH+3Aewj/p6HhNgGR2ab50dY/lLQOQGaLi+j74/egEfZvL0wRlIxBbMYT2TA?=
 =?us-ascii?Q?IcDWks4ZI7P2+K4JDlvo8fysTp/rpRHxekjZ2U7yHzeN2CvivUxG2KdQtvc3?=
 =?us-ascii?Q?qZpNhx51nMipGxXPaj0K6RSc8mT+vJB0ZHUu50/jkBK0Jcl7IhnOwv2l7PFh?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cI9Bnk30eaoOIEj4JkXf0ZsanVDcNWismUbWfQKd/lZihmTYRIE94nbOa4RZ939wyEYqErq9ncFT78X386AthPC5ec64u6WzQz8wWeaDOLYWJxkAghbezYCINH3BhOM2HO/f0jDaqf34aOHzAY+U+EfIcBgZl3GylxKrw3Sl0LcC8+TWJrr/T8ZWT3wPjbQ9tnc/PGRa6dcBSIJOwZabpPPwCBySF+mIwBu5dBihxK/hFNN4YP5UPCB32r7mbMbtQd43J5HlS4dH1vO1JIFGB3wNznzVLC45QDt3qe3wOkonLw8hyQG5J6y94QRBAi9al0A7hLXwp0+YThxEy78X3GkFW/45WM+YnjvOse5rRdyfWHw/GfNZZkaJ8PNS0lpCh2M85wJDXSt5KBJhJM9jhYbg9bF7soL7A/Mjp5DUjYk9h4XSPl0NCJeflo/fHef58Y+fqR/yt869iEo2RKY4ZgbCeslrxdhUJvqTvhHm2JmFVJVpHaXG0EsZ88JEGEQ5q9a9eQYCV6rcyrtK6rgmUwX0+Prtt2RyOYOEjvnEYDBm1yKFmEXAtfQZQiu6X/vtunUBvtGb63Dnwv8EYTDuZ8ZzdyeIsmOrMmfTQecsT5rEnwyRMMl+AL6WI7kzGiwL
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d0148d-27a8-4559-a9ca-08dd0d33e5eb
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 09:31:11.0150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3KJiCGOMlLJxLRteJC49RjqOYTnbJUavfJzpEAHeg/w9O2kjcEfJimTMtoyOtegY5syGVgXA8vNxQ9zNt8Myw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10148
X-MDID: 1732527076-ap0yRC0XAHzZ
X-MDID-O:
 eu1;ams;1732527076;ap0yRC0XAHzZ;<gnaaman@drivenets.com>;734049c21285abfbb55dd56ad4f9dd58
X-PPE-TRUSTED: V=1;DIR=OUT;

> On Mon, 11 Nov 2024 17:16:07 +0000 Gilad Naaman wrote:
> > Do not invoke costly `addrconf_verify_rtnl` if the added address
> > wouldn't need it, or affect the delayed_work timer.
> > 
> > Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> > ---
> > addrconf_verify_rtnl() deals with either management/temporary (Security)
> > addresses, or with addresses that have some kind of lifetime.
> > 
> > This patches makes it so that ops on addresses that are permanent would
> > not trigger this function.
> > 
> > This does wonders in our use-case of modifying a lot of (~24K) static
> > addresses, since it turns the addition or deletion of addresses to an
> > amortized O(1), instead of O(N).
> > 
> > Modification of management addresses or "non-permanent" (not sure what
> > is the correct jargon) addresses are still slow.
> > 
> > We can improve those in the future, depending on the case:
> > 
> > If the function is called only to handle cases where the scheduled work should
> > be called earlier, I think this would be better served by saving the next
> > expiration and equating to it, since it would save iteration of the
> > table.
> > 
> > If some upkeep *is* needed (e.g. creating a temporary address)
> > I Think it is possible in theory make these modifications faster as
> > well, if we only iterate `idev->if_addrs` as a response for a
> > modification, since it doesn't seem to me like there are any
> > cross-device effects.
> > 
> > I opted to keep this patch simple and not solve this, on the assumption
> > that there aren't many users that need this scale.
> 
> I'd rather you put too much in the commit message than too little.
> Move more (all?) of this above the --- please.

No problem, will do :)
I thought that most of the text is a bit speculative and describes
changes I didn't end up making, but I see the value in including it.

> 
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index d0a99710d65d..12fdabb1deba 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -3072,8 +3072,7 @@ static int inet6_addr_add(struct net *net, int ifindex,
> >  		 */
> >  		if (!(ifp->flags & (IFA_F_OPTIMISTIC | IFA_F_NODAD)))
> >  			ipv6_ifa_notify(0, ifp);
> > -		/*
> > -		 * Note that section 3.1 of RFC 4429 indicates
> > +		/* Note that section 3.1 of RFC 4429 indicates
> >  		 * that the Optimistic flag should not be set for
> >  		 * manually configured addresses
> >  		 */
> > @@ -3082,7 +3081,15 @@ static int inet6_addr_add(struct net *net, int ifindex,
> >  			manage_tempaddrs(idev, ifp, cfg->valid_lft,
> >  					 cfg->preferred_lft, true, jiffies);
> >  		in6_ifa_put(ifp);
> > -		addrconf_verify_rtnl(net);
> > +
> > +		/* Verify only if this address is perishable or has temporary
> > +		 * offshoots, as this function is too expansive.
> > +		 */
> > +		if ((cfg->ifa_flags & IFA_F_MANAGETEMPADDR) ||
> > +		    !(cfg->ifa_flags & IFA_F_PERMANENT) ||
> > +		    cfg->preferred_lft != INFINITY_LIFE_TIME)
> 
> Would be very useful for readability to extract the condition into 
> some helper. If addrconf_verify_rtnl() also used that same helper
> reviewing this patch would be trivial..

Good idea.

> > +			addrconf_verify_rtnl(net);
> > +
> >  		return 0;
> >  	} else if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
> >  		ipv6_mc_config(net->ipv6.mc_autojoin_sk, false,
> > @@ -3099,6 +3106,7 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
> >  	struct inet6_ifaddr *ifp;
> >  	struct inet6_dev *idev;
> >  	struct net_device *dev;
> > +	int is_mgmt_tmp;
> 
> The flag naming isn't super clear, but it's manageD, not manageMENT,
> as in "managed by the kernel".

Oh, whoopse, MANAGEDTEMP tricked me.
Thank you.

> >  
> >  	if (plen > 128) {
> >  		NL_SET_ERR_MSG_MOD(extack, "Invalid prefix length");
> 
> I think this change will need to wait until after the merge window
> (Dec 2nd), sorry nobody reviewed it in time for 6.13 :(

No problem, thank you for time!
I'll resend a polished patch next week.


