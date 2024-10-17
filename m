Return-Path: <netdev+bounces-136425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AC09A1B48
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD7D1F27563
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19EC1C1AC0;
	Thu, 17 Oct 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="tDdvFHWp"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E011C2448
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148711; cv=fail; b=b2GgXccHzySm6MmPvXHENxm71AqrKVybAMjXxRJv4PekKAFhW41Jb5ZyZmc5+bZ981MmUjA5m5sLwHcjrVXvRKAbbR0MdSUAnHVuWR6WoDs3S6UowIxqHlOjq6lW1DiJHyFyf+hmwhctXQ1711eAKDTqrF0etfjCPEJ5pF6WvX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148711; c=relaxed/simple;
	bh=2nvz6Gt2jetXL4OGsyajI1dWDOsqb56ZjkAz3pR2kBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BVQA/yEiNpccZfsm9CySc6H9qyV7UVGCaKVSODhKt6SV8vANUDE+xzcHlOxMDOy7wMTBpN9dRQC+TsxzNzWs0VSFcN811OHMbQpzNGruSN0Cdp8iLGBIa0uOgNvPPCPlod4UY1F36JyrKKtisRdf5cuiCjw7aF5X/BZ5k5YlGqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=tDdvFHWp; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DFF1E740051;
	Thu, 17 Oct 2024 07:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9x3Wc4b9AuqMC4YI/4CNaHWKusw1Ui4+iE09zz13/5lVCjE6Aa0JmWKdUOZcjHvp0cumeiSHlSO4FXRQd/+U/PMtn5sdILdp3lYkao/wM8EIzHReuGOm7XwLs/0Y0QSIrLqPq2eff+HSlA11z6Q2ZxbIPtuVQ72yGOLKyXWdao6RnnJgXeXwvMbpZH1JwAf26qbESWKC+cpd29ZUoobVaB1fZLfD/vsNeihUPdF63wORzgV+UAO87e+12EPFpxE2BqQtAbFfTRn6C/O1UgNz5xX91ilxYOKwX0lp6leFuRXMpP6fGFYpwZUSvZtDBj19PNERur4rQHSlH079fAHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+UV91uQGAw0ZbvSSc4XSgE9poaYb8rDLZ6NwnGx8uk=;
 b=RVVpyENpwKx9VUN2xFq//bsM2WrJ0C92vxcs6o02VeAwG69iSDtoMjaCLm1qEdBx0gWMNSKuCE2IcD9vr7LtuLMH57s7ZF5+gGQTyuu6FI9FNq3QJPhfRdNRxUZDlLEgoHPpgJ9VdrHia+5Ver/S9c7/RdTeDYm/vOwSdV4pNP8akitZmY3iVFfikzTeS6DnC/3oSYOQhZTQHqz5GAaLw06jLnONB45F09zvp+t6wsPqG7uc1knuRa4W7GAuM4PxRhgCmy3oBJ9mU/WeTni9vMr8Rm3VLnjULBpIFVqrhvMhgIjBBkt8kh1i92JPy1gWO3hGcDfNg5QE7gmkmZl6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+UV91uQGAw0ZbvSSc4XSgE9poaYb8rDLZ6NwnGx8uk=;
 b=tDdvFHWp0OZl77TIcWXl7Wl1pVg5DiR6toc4mUxWd9CrZBV2U6md94WEkCfoPtgYKxJF0+mfc8WUU1LUheikwHm1wsdnC3r0hTaIAyrmB8/mCE/dPQStVR1m2i74Yn6fOSyM9OFSTUSLx+i+y0Plf7ud2NP/3ByuZPBrIfccOdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM0PR08MB5363.eurprd08.prod.outlook.com (2603:10a6:208:188::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 07:05:04 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 07:05:04 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH net-next v5 6/6] Create netdev->neighbour association
Date: Thu, 17 Oct 2024 07:04:41 +0000
Message-ID: <20241017070445.4013745-7-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017070445.4013745-1-gnaaman@drivenets.com>
References: <20241017070445.4013745-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::29) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM0PR08MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d292b5-168b-4566-568e-08dcee7a06c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pzhNJtSLBdj+QZNcHm7gsI2ZZ91pBljPqob02OMiKVKnjqPTsrherFtLyDSD?=
 =?us-ascii?Q?mVnnpvtcuQ7WcId8helvM/2Y+zkxWflniNnY5ALULz4Xg6HQ3KfJP/3xAAQx?=
 =?us-ascii?Q?CtPP2mMIeCgFBX+BoHUao9VgdsNZC1+UDGMEGXGHYskaxFUcBQZwsYea00/I?=
 =?us-ascii?Q?cZKFwkP8iDtlRZd1VnXmi5fJaDbfvpdZxWxgyP+9yWAaF5LoW0IZZdabwva0?=
 =?us-ascii?Q?dP0dEP8zNFG2V6basB0pQPtBMlree0626BdxRtJEMwdk91Z7q5aqHSb7gEBs?=
 =?us-ascii?Q?cK6W+/nbckVQrJPBhZJa81FVN5NOHBwpiP0FVbJdV1tRawiPJ0jcV4itPme2?=
 =?us-ascii?Q?EK5mLBAEinLVuXakzukjGaOVPORwCUOQF+ydALUJuvOEQ4eRls/A3a6EA2vb?=
 =?us-ascii?Q?nfcuBUgn6ptjbxIVJeQeWD8T7AzDkm72l58LIcv+PciXFofw0/6mgjdKpC0W?=
 =?us-ascii?Q?hwwhHDG23dc32kLTG876B//8LHGWssbd8eab7f50bnUDaGOX+pr36XG28+LZ?=
 =?us-ascii?Q?Eckr0oFm5rznN9x2X7g2gDk/83wV5FJffF1nt6lQuRvFVLQ2LHeUIiQn/1I+?=
 =?us-ascii?Q?AXBk+qMNFYtok9MDfxxPj1obOGkzAbJG+n1QQq9GQm1vEXeCfym4jsL4fx8l?=
 =?us-ascii?Q?kLUDLDQk8/+lc1VZc0Gurk6KmUdWy+K+WSgIYTEJy5NXl4EJ+MKpesvtdvEc?=
 =?us-ascii?Q?zv2i1TXkrsWVW6Tqu8PC7r717dHdngbPlT4ucJKDCbIgfKHrEN8/Up4yLNMP?=
 =?us-ascii?Q?Ukx1k3mrM0N3zOjf0deL6ICFzAjQZc83cjr7F0PANqHGgtGqhCELu/jkrp1W?=
 =?us-ascii?Q?4kWnIEhreRGrhbpURbwU7P5fL1mlDvb7ssQchT90Ye/LzNT99ixhdjT/KWNw?=
 =?us-ascii?Q?fesfs73oXdn3rCY50uc1rG3hU/TJFTqmPG0pzJl5+kP00pl7Xk2gUIx+aJDz?=
 =?us-ascii?Q?+ysu+VRdWv3Q39h5x/KPgrcrfSoIgYTgVp5ZLrJ2SClU87Ff/UlnxyuvRhGL?=
 =?us-ascii?Q?H3x5TCK1zfUzHmFUF9z3SeNtV6DXevKpweUzKcOITFeBwTx5wrwqlav9kuHs?=
 =?us-ascii?Q?2cIybiGS0BEyB1BSrcl7zHEj3fsWFfot3v1iIg4YRxb+8DZT3dMcYTRI7WxB?=
 =?us-ascii?Q?labYG6g+OfOKA3hiO7AZkv71bFywHSTk0qZdkZqn98fHA3dhGfdlyYoKJ8e2?=
 =?us-ascii?Q?FTD406kweSV6StULb6yZbWoPvR8WisqI5XDfWmyM2RuwuOrvEg+cpnS4AZ71?=
 =?us-ascii?Q?r5L0W8TW7W+6UxYmdGUML4eJDIot1BuXONQ5a24yH9XNlIrbICmeM9Ln2gcN?=
 =?us-ascii?Q?Czu7jj1PPMSZdhITcfQUADIxBlWWxzQtsIcjw/w2zBA05uf+aeWLQWRQD4gM?=
 =?us-ascii?Q?o/ssHaw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X85Rmsq6hW6z9W9f28en1okY+bOb417SjlvzzD4wAp9PPrfXP/q2dQNuaGe3?=
 =?us-ascii?Q?O0Uf9dnonUqyOh5Rw3iorflBAG9HH80LpNz7bbOiszgicbRtTyYf4AqaxScX?=
 =?us-ascii?Q?jWmQlJgHqBjz2iCXsOOCYajZ5hAhRU9m46BPkuSnOe6ZUNsTsaqACsu3JOkx?=
 =?us-ascii?Q?uwGHBLruqAkf7wSPKNw2dL6aKBG2V3rbcD3du3GHPEfGRqe9a/+lhkNmkY9V?=
 =?us-ascii?Q?iaVqplC25RB2Z35U8MVItJO91yEp5s5G+mGLV5WPCBy4aE/dN3/f0fhfNTof?=
 =?us-ascii?Q?b+HXzUQIa+2pey+NSsMzKgsUOH8qJVsmYY++cxPykFU4H+DzTH6a4DpaF99I?=
 =?us-ascii?Q?7CF6sSRgg63mwY3subICUShag2oCqxQXfGi9Rw3Rw2iTfifS0kAWieAtAFQM?=
 =?us-ascii?Q?PUTFHwSILesUHBLlPdT7waucXK2UvFKCaAvDw8e4tDO3/Oi/iC4mxLtTNS0F?=
 =?us-ascii?Q?AKVmjncbSZ5WQvZOSMT316KAXkHQQsicNP14nsUeXGZCkkUn/m30HlTlmHrT?=
 =?us-ascii?Q?uiAjuIl2X/cMuoMRX8q2q0TQd00t2myZhjdWPmT4pQoR2H7sP26LB70X1D/U?=
 =?us-ascii?Q?am1v3l3JLK0MpDUvTtAEJo5L6JPVCybvs+aJ/KD1n4EACnHtkJRqumRgPoeD?=
 =?us-ascii?Q?sctiVd8qkaoUzekMTfDnQmuDQHeezxHP2sBsZG4Jay9UocXlzKacp2vUI6F5?=
 =?us-ascii?Q?gwm5ee3WSSzcXowlbA9ZcURK9caJlZAh/qv5ftcm+kNCmFEXs8BnrRn8ww3W?=
 =?us-ascii?Q?FGuYJB2hwsGGbGjjYvOEPV93O4GMQ4CEjbob7z8usTHewxCTEHi5LvRx3GCt?=
 =?us-ascii?Q?fxB1uEQ0w6MycHIgpfjExGCPtGXW7vsPgW/HYH6XMsYQ8kTnNJje7dJAUZO2?=
 =?us-ascii?Q?dKwZpPj16MH3JwxTNuT3zkM3CLJXwRgbHs5540RFUo6u6gwZ30591hYNPcf8?=
 =?us-ascii?Q?AXTeD6xFc7fU/f9vYQ0lbZF306DeZQIulDchCHZRLO1lyuzv0Zt1x2dWqioE?=
 =?us-ascii?Q?kuTtiEsZ8Nhazjuu2Z04PAiUMVadtneTmxQiGUNO1FEn/vGXAtKmXPHSikRS?=
 =?us-ascii?Q?KcRAbiMSqMJdiUfb0gvduGrzuF0FwtiyIKMjLFV/uvvGYzpATKTvoX9OqDQt?=
 =?us-ascii?Q?Fda566PzGGdgkrjqYibSTegS2L+xrCgmLkz9Z7RjBQSY1PVOMrXaOcOLxJky?=
 =?us-ascii?Q?wXd5WSAmtoXOlZuLroRE8/9HOCVkqUuZ8Wk4qkuRAMhCR/TbzfjPTMrUqOZn?=
 =?us-ascii?Q?SdzfTRaI670Kp5rY/GqH2hlnXHf/Yqq62ECfiH7oVrWlGnp7x2hD4POwwFoU?=
 =?us-ascii?Q?C7y8P/tjr1iR6fqtfHF0xw6kUwkfOf1/INADKx7vzHcEMg/sEQF5UefzIIOq?=
 =?us-ascii?Q?Hu3xwojAFJ7bWSxLCnngcvabqs+F568H+kETZTAyTbbe9WgrRF1q4lavlIjy?=
 =?us-ascii?Q?GfXyZgGo72ie1nndqPAAIhiVmGoIX9R4rLNesyxFXlA8dKie2EhIiMu6gQST?=
 =?us-ascii?Q?+vKDHXOzhdIerPsYcNGKpuiegGa0UKwC9e4aje73r6XVHxMCW3YhWLQpoKt5?=
 =?us-ascii?Q?Br0jhDNrLekqJnG3i2TEcRWEcnNV/t/FJjZxRLxw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nBJ29tcPWFECbfYykDFkNNamytZMJX0o0MzH43pcWUrctcfzmpRRkrqYYJsli9kshlMMrKHgzC+jaR8gVurjs9r6SAJOf80C2tXzKI/yTukotcidTlNIqRqPNyvHkT5JA7I+Zjaqnx2IV5OdZMw0MPJg7i+DRX7Zu6tBHXNrdoIoSMenZzCncxfx9FrVkox2YNIRt82kCxJ4dSan2vBQE0RQLCDudFU+ljCSO3rxt7dG9+0lmufy80sQgY6EVyrBVKs1n9PdoOa0IpHzx/j6O/xxVAk7zl5Av8bE7NnsAGSuPC7mK3Ym9UYpUgGOTmYwWf98ZpSSHki8o+6RgKoL7PqvFy1tT0uQ93QNkPPRS4nRu5jZiEkTMGrKqdj6bKufKAX0+yB/jB0TQpAI0eFb8v61V00hYP0pjamGQJuu8uptzEnwXjOpTaLP4e1Wv7fyTr58w+tLZUCLZ1BhFXf8FAjhWZWo9LJutQ4A5DTXZBQthEQBFeqQoU7eK4HnxjUpo3C6YFIQq1CilZKYfWxCy5bYLNIAbUNfiLEbDo2I/bmzCfzk7zZkTJn422+S7+ZZztpHQSPguSYhRK4FFsDShSAw36cjVnanafw+FtezdD0IQyHf8VD0MC+bt0KD6PTL
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d292b5-168b-4566-568e-08dcee7a06c5
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:05:04.8075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8trmRHluVw9lvh2rc0Hmj9r9mGHWGsV/fQ+HuZK+z7ZFbea6VMLWKWNwmauuL1O31SIQe4tds2QOFsJDmAMF7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5363
X-MDID: 1729148706-bUWKCgVCvL3p
X-MDID-O:
 eu1;fra;1729148706;bUWKCgVCvL3p;<gnaaman@drivenets.com>;3e2ef0aab6a0ad8a3f1c1b41b7049f4c
X-PPE-TRUSTED: V=1;DIR=OUT;

Create a mapping between a netdev and its neighoburs,
allowing for much cheaper flushes.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  7 ++
 include/net/neighbour.h                       |  9 +-
 include/net/neighbour_tables.h                | 12 +++
 net/core/neighbour.c                          | 95 +++++++++++--------
 5 files changed, 80 insertions(+), 44 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index db6192b2bb50..2edb6ac1cab4 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -189,4 +189,5 @@ u64                                 max_pacing_offload_horizon
 struct_napi_config*                 napi_config
 unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
+struct hlist_head                   neighbours[2]
 =================================== =========================== =================== =================== ===================================================================================
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8feaca12655e..80bde95cc302 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -52,6 +52,7 @@
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/neighbour_tables.h>
 
 struct netpoll_info;
 struct device;
@@ -2034,6 +2035,9 @@ enum netdev_reg_state {
  *	@napi_defer_hard_irqs:	If not zero, provides a counter that would
  *				allow to avoid NIC hard IRQ, on busy queues.
  *
+ *	@neighbours:	List heads pointing to this device's neighbours'
+ *			dev_list, one per address-family.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2443,6 +2447,9 @@ struct net_device {
 	 */
 	struct net_shaper_hierarchy *net_shaper_hierarchy;
 #endif
+
+	struct hlist_head neighbours[NEIGH_NR_TABLES];
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 61c85f5e1235..ecff9297c116 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/workqueue.h>
 #include <net/rtnetlink.h>
+#include <net/neighbour_tables.h>
 
 /*
  * NUD stands for "neighbor unreachability detection"
@@ -136,6 +137,7 @@ struct neigh_statistics {
 
 struct neighbour {
 	struct hlist_node	hash;
+	struct hlist_node	dev_list;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -236,13 +238,6 @@ struct neigh_table {
 	struct pneigh_entry	**phash_buckets;
 };
 
-enum {
-	NEIGH_ARP_TABLE = 0,
-	NEIGH_ND_TABLE = 1,
-	NEIGH_NR_TABLES,
-	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
-};
-
 static inline int neigh_parms_family(struct neigh_parms *p)
 {
 	return p->tbl->family;
diff --git a/include/net/neighbour_tables.h b/include/net/neighbour_tables.h
new file mode 100644
index 000000000000..bcffbe8f7601
--- /dev/null
+++ b/include/net/neighbour_tables.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NET_NEIGHBOUR_TABLES_H
+#define _NET_NEIGHBOUR_TABLES_H
+
+enum {
+	NEIGH_ARP_TABLE = 0,
+	NEIGH_ND_TABLE = 1,
+	NEIGH_NR_TABLES,
+	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
+};
+
+#endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1c49515b850b..2683fb68f5b5 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -61,6 +61,25 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
+static struct hlist_head *neigh_get_dev_table(struct net_device *dev, int family)
+{
+	int i;
+
+	switch (family) {
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		fallthrough; /* to avoid panic by null-ptr-deref */
+	case AF_INET:
+		i = NEIGH_ARP_TABLE;
+		break;
+	case AF_INET6:
+		i = NEIGH_ND_TABLE;
+		break;
+	}
+
+	return &dev->neighbours[i];
+}
+
 /*
    Neighbour hash table buckets are protected with rwlock tbl->lock.
 
@@ -216,6 +235,7 @@ bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
 	write_lock(&ndel->lock);
 	if (refcount_read(&ndel->refcnt) == 1) {
 		hlist_del_rcu(&ndel->hash);
+		hlist_del_rcu(&ndel->dev_list);
 		neigh_mark_dead(ndel);
 		retval = true;
 	}
@@ -356,47 +376,42 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
 static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			    bool skip_perm)
 {
-	int i;
-	struct neigh_hash_table *nht;
-
-	nht = rcu_dereference_protected(tbl->nht,
-					lockdep_is_held(&tbl->lock));
+	struct hlist_head *dev_head;
+	struct hlist_node *tmp;
+	struct neighbour *n;
 
-	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct neighbour *n;
+	dev_head = neigh_get_dev_table(dev, tbl->family);
 
-		neigh_for_each(n, &nht->hash_heads[i]) {
-			if (dev && n->dev != dev)
-				continue;
-			if (skip_perm && n->nud_state & NUD_PERMANENT)
-				continue;
+	hlist_for_each_entry_safe(n, tmp, dev_head, dev_list) {
+		if (skip_perm && n->nud_state & NUD_PERMANENT)
+			continue;
 
-			hlist_del_rcu(&n->hash);
-			write_lock(&n->lock);
-			neigh_del_timer(n);
-			neigh_mark_dead(n);
-			if (refcount_read(&n->refcnt) != 1) {
-				/* The most unpleasant situation.
-				   We must destroy neighbour entry,
-				   but someone still uses it.
-
-				   The destroy will be delayed until
-				   the last user releases us, but
-				   we must kill timers etc. and move
-				   it to safe state.
-				 */
-				__skb_queue_purge(&n->arp_queue);
-				n->arp_queue_len_bytes = 0;
-				WRITE_ONCE(n->output, neigh_blackhole);
-				if (n->nud_state & NUD_VALID)
-					n->nud_state = NUD_NOARP;
-				else
-					n->nud_state = NUD_NONE;
-				neigh_dbg(2, "neigh %p is stray\n", n);
-			}
-			write_unlock(&n->lock);
-			neigh_cleanup_and_release(n);
+		hlist_del_rcu(&n->hash);
+		hlist_del_rcu(&n->dev_list);
+		write_lock(&n->lock);
+		neigh_del_timer(n);
+		neigh_mark_dead(n);
+		if (refcount_read(&n->refcnt) != 1) {
+			/* The most unpleasant situation.
+			 * We must destroy neighbour entry,
+			 * but someone still uses it.
+			 *
+			 * The destroy will be delayed until
+			 * the last user releases us, but
+			 * we must kill timers etc. and move
+			 * it to safe state.
+			 */
+			__skb_queue_purge(&n->arp_queue);
+			n->arp_queue_len_bytes = 0;
+			WRITE_ONCE(n->output, neigh_blackhole);
+			if (n->nud_state & NUD_VALID)
+				n->nud_state = NUD_NOARP;
+			else
+				n->nud_state = NUD_NONE;
+			neigh_dbg(2, "neigh %p is stray\n", n);
 		}
+		write_unlock(&n->lock);
+		neigh_cleanup_and_release(n);
 	}
 }
 
@@ -674,6 +689,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	if (want_ref)
 		neigh_hold(n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
+
+	hlist_add_head_rcu(&n->dev_list,
+			   neigh_get_dev_table(dev, tbl->family));
+
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -955,6 +974,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
 				hlist_del_rcu(&n->hash);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3054,6 +3074,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 			release = cb(n);
 			if (release) {
 				hlist_del_rcu(&n->hash);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 			}
 			write_unlock(&n->lock);
-- 
2.46.0


