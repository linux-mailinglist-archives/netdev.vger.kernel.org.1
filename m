Return-Path: <netdev+bounces-251835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL1eIVKmcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:11:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FC254FD8
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F2B08C9EE3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7567E480DDB;
	Wed, 21 Jan 2026 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="I57N7kZ3";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="I57N7kZ3"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021079.outbound.protection.outlook.com [52.101.65.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01F480DD7;
	Wed, 21 Jan 2026 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.79
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989191; cv=fail; b=pg5Qk1lGTp5qBouSbsYN2m99rNm3m3P2cQd/owey42zsJY4zr1UySXpZ+TzOaKZJBbHUG/QRZIN5M+w/5dUpT8o5eSZOpvhy/UqDZMIXDrHLDb+LTn8viHwjMoFjgozr2ebD6R2sJzuJgwnO3yD2jqz1iKDWnkaSmj/eFhh61X4=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989191; c=relaxed/simple;
	bh=iirljrbja+Ioe0PmEXoHlI6NpuqIkmAnRBUx9Si+Koc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r1yY4D9jQMVnW9cfa1QEIeiw7pP9aVSStj4y3KTUf/fRe2Fu6tXwRLydxCdFAQuvyYP0TNdOFO+6ef3fdcKotZwa0oO1SJMDkAA5ahQt3qRGdzMXpFfK4xOQ0u6HQ09tMln804h2tyzTovPyr+/eRduMHehFei/snhaZ7XduO6c=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=I57N7kZ3; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=I57N7kZ3; arc=fail smtp.client-ip=52.101.65.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tDOMjffjIikk2ItwyZ0kK0U90TTtdX5HSYd8dz8JWbaam4pZrCw0olcZeoaVi3NKQa5u2szv2NEBqz8kzSbRH68bRe8fX3YQLDj/yJMFGfeFoXYHRiuMvqb90uBvMCdVVyn3LX6DIutRzH3jQFHWNksCNe0XnkfOtda0msLhLMKsB6c1BHLp5DF3EH3TmYoX/dxUcvVACllSiuKC5vrKinpr1gmba/LGZeBkPhfp7EEhZ9ZLdLo018fokylN6G/xJ+M/DcDjggAJtXOnE91hH/yEpX1z4rJtnwKpRzAqg7uvtMdJa3TGVq321gfzhWrDQqZ5sGn4XSFWs7TMxcsruA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iirljrbja+Ioe0PmEXoHlI6NpuqIkmAnRBUx9Si+Koc=;
 b=ljq5qXSTV0ivv+6TFz0hlD6fuiJxtkoBS5o8r3/SkNvpdslBcbaOQIaS/veyq6tIBvMdV07GxJR/iVZ2eUam7AIkI6y7VuQ3ArilQ0esRrXaa1Mgp+2yZdOQgcfKgb1p0muNbtplwqP9GY16nqGtGOjzaaFBZyzN0onify3gPtsYBvQisiTp7/748ydbJdLrDeLgUwVX2QQQR1gcQ6hJw7IfDiSH4Erk1uJfhTIQjhzmX2V92c3WhI8I586/ycTtQUw94vDoF+/w9ZNLoT07TxYp7JOb2r26W8B0gf7RsuR1YB5EiKZGSUTHGf945vzkJWMF+Yu/mwn45xl5jTk0iQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iirljrbja+Ioe0PmEXoHlI6NpuqIkmAnRBUx9Si+Koc=;
 b=I57N7kZ3Ar8YkndhICcdPkEz0hYHN3koyqZLseM79KUxnfe7cBGoW5IaIQCGvP7348gpKA5XnXIjZSfBGDnCd/5y5HBlNTfOege+vjuws7m56MuJ6uwNdWQHX5b+4SoC/8WWZVSXalxNBOmSFVdVFOEm/OPuAPqdMvyINKQPn2g=
Received: from CWLP265CA0537.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18d::6)
 by AM8PR04MB7761.eurprd04.prod.outlook.com (2603:10a6:20b:248::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:53:05 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:400:18d:cafe::d2) by CWLP265CA0537.outlook.office365.com
 (2603:10a6:400:18d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 09:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 09:53:05 +0000
Received: from emails-521812-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-21.eu-west-1.compute.internal [10.20.5.21])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 2ABB27FFF0;
	Wed, 21 Jan 2026 09:53:05 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768989185; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=iirljrbja+Ioe0PmEXoHlI6NpuqIkmAnRBUx9Si+Koc=;
 b=nHjoSgmeROuzIvxT4ZBsVhj8/cECkStLjuALH6kYlg3HFonHqV7oAdjIZ81Fbf9ITMEeM
 /Nx+r02S1XRAxyq5COjQHH1PLSBk123SG76S4FHIPHWruC+lkyDFW3rGLUH15sK3oJ4f7xL
 Cf6NAQwYtYcF/Z1AjUjrgJFfV/wXEZc=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768989185;
 b=acllH9noWSxgR5EKl48aoaI3YBuCSaG/+MrnggkGpwdt0LXhkhpCCyT+0UHkMBXN4frZm
 RrbRMENrFlNZl3vwDfU008BLoq7ndmkjSWvUIIXFYQxM3fEse4+lbKqEpoyLovQd7Bit3g3
 ZjBX5gDw/q2OCwt9HjOdwjE8BjSH6d0=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R98NUqfYlPTOJdbbT8vJCviWygRsqz9HmrkRsZrHtPXXmuIjQjd7pS/Kyp+eCUqvG2Woz76egS92RLltTqJqTIan+87JIr+SFKm4NuzT1KNOWYU6oIc3APyF/QW5f8SnaWW2UReBE30Y/MTGdh/yOiCp6SdNo946uaOqSEooo5pXngLHTat3DRg+hJbw+5LIMv6mTiRRpKTt1DltJ8FR6z3SQd9wMjegEqwnhLR+MRt7iQ7L7isdie1Ki1CaGB8zbYfY625G9rOC6QwTrhn40QQF9v3nhUddLoDblWaUT/1YxsIoZjIP96G+awey/C/5rEUqNNQT6Jvu3P+iYydAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iirljrbja+Ioe0PmEXoHlI6NpuqIkmAnRBUx9Si+Koc=;
 b=UzMcrntFCAQRHWCdA7VS6+ecpBOWqx50N570UmuQW+sTL+B64UoDHOlIo2PlXoGxXlVlBzVzk7K2Vf1XyRDlTbrJtkz0L+b6+2e7nTB3PmjwEzHmMJsH6R6M3ZgQjLAi65KGpNTu3U1wSUOavIP1Dwmf8EuizeSljuJCkGRYo4et5Kam8eTW9bH4p6Cfa0b03aXuxRC+EDOiIBr3x08DuvLLu2uDjQB4A0jC4agqgo/EdSV58h3iYixWaqrN4jqJIMVBPKmYWTk6bsMUfSjRAL2rJXWCdToVS/5oR6Pe+lSfaeOzXitc0YEBmPJmJYhUOCzbRc5ggH6kZJFGX07StA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iirljrbja+Ioe0PmEXoHlI6NpuqIkmAnRBUx9Si+Koc=;
 b=I57N7kZ3Ar8YkndhICcdPkEz0hYHN3koyqZLseM79KUxnfe7cBGoW5IaIQCGvP7348gpKA5XnXIjZSfBGDnCd/5y5HBlNTfOege+vjuws7m56MuJ6uwNdWQHX5b+4SoC/8WWZVSXalxNBOmSFVdVFOEm/OPuAPqdMvyINKQPn2g=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS8PR04MB8296.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 09:52:56 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:52:54 +0000
From: Josua Mayer <josua@solid-run.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next v2 1/2] net: phy: marvell: 88e1111: define
 gigabit features
Thread-Topic: [PATCH RFC net-next v2 1/2] net: phy: marvell: 88e1111: define
 gigabit features
Thread-Index: AQHcezh9IJ4bsKzbBUi5qFtzpIf787U+1VwAgBp/9wCAAyupAA==
Date: Wed, 21 Jan 2026 09:52:54 +0000
Message-ID: <2f83f4ee-4655-4d0d-a655-55ced2af190d@solid-run.com>
References:
 <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
 <20260101-cisco-1g-sfp-phy-features-v2-1-47781d9e7747@solid-run.com>
 <aVe-SlqC0DfGS6O5@shell.armlinux.org.uk>
 <b8cafe50-c87b-4bd4-a47e-d11c11c16f7c@bootlin.com>
In-Reply-To: <b8cafe50-c87b-4bd4-a47e-d11c11c16f7c@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|AS8PR04MB8296:EE_|AMS0EPF00000191:EE_|AM8PR04MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 4973c040-10a9-4230-2d0d-08de58d2dfe4
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TXNKWEZob2VUREVxdzdLcjE1OWx1cDdCSjNINDFDS0ZCRGRya0FuN2NLTDVw?=
 =?utf-8?B?bFZ4NmVudFlXRGhxbXBjemx6MDIyQjZ6UjJ2Rk9iYytOKzFpVDRYR1kvME53?=
 =?utf-8?B?NjN5L3hWY014Z1paY0k5SkdEZmd2cDNoM0dzVlVsOGtWS0N2YThHUzVDcjln?=
 =?utf-8?B?bHF0eWNwcjArS0xuVzNLNmIyMWhBenVwMmE5KzdSd3RXdmRHWnNBUzYvK3VE?=
 =?utf-8?B?VHpYUjUvT2NUY2thQnExci9abEVGUGZqTVl2VDlJTHRBOU9qdmJLUU1nNWto?=
 =?utf-8?B?ck1HTXk0bld5ZUZSZktJMWlTd0lKSUoyamhsdDl5UHdkbm1MdEtpN3V4QUFG?=
 =?utf-8?B?aElOZjB1RkVPSUpZR0dIT3M0YUdEYU1LYVc5RmlsSW9nWHFrMjBNc3RvV2NS?=
 =?utf-8?B?S3RQSXB0RnByYTBHZmZyaXE4NFBJUXk2ZVlkV3hIcW02RFVxZmdFbWQ3ZG4y?=
 =?utf-8?B?NkxVMjlSOEt3ckdOMlpURURiWHJlbHhBeXhCNzc5akl1cnhTT08rbWhuVkhM?=
 =?utf-8?B?NDZEZmFSbndTSkpmbjd2TUc4ZmpQTXJiMkdHM25tL3dKaDNDM2M3SmZXZStl?=
 =?utf-8?B?aU5rNlZkZE1XQW8reUowSzNScjRydmZRd0hibEVXU2FybkdwYnU1dkRYK3dB?=
 =?utf-8?B?Y2VnQkxlS05sTWhJaGlnTjBadHZJMSs5dkFTaTN0QzVUcS9pQ28wSzBsVlJL?=
 =?utf-8?B?UlBQQUJVWkhOZ3RsbW8xSEdLNklIY0NsNXhzblRPWVZZWU5Za3BXYmNPS3V1?=
 =?utf-8?B?clBuZGdZQm9HcTFWQUMxN29COXk4ZUxXV0ZjdlZvVVlQcy9qK3hsV2JORHJJ?=
 =?utf-8?B?cWlCMXZLK0lJT2dvNHZHbi9jTm1TSHk4TVhMQWZYUzdpMTM4Uk1hUHBPSkhR?=
 =?utf-8?B?dTM0YitMNTY3OTdqOG5zWXcxQ0tpU1g4WWtJQjMyT1RRQmVzbGh3Umd2SWV6?=
 =?utf-8?B?Lzh2a2cxV2FzcUhuOHZLMmROdk5UKzJqbWQ2QU1yaUEwOGdLR01SMFJ5MjU0?=
 =?utf-8?B?azdnUkJ3OWxWbU90amI0WDRNMmI1dlRPWjhXdFVMdnI3Y2s1dFBIbERadHM4?=
 =?utf-8?B?eUJXUWQwOGRPRzJ0eWhkODBXdEZlekVYeUJFcHhrTzhrd21wNnFSNmNrRHpZ?=
 =?utf-8?B?UzkyREpNemNPMjRxOUVIMTI2T21LdXhRWnowdFdjVWhSV2dwQllQR2dlckJs?=
 =?utf-8?B?dTVpa0thQ1RVMFRqcXE0V0RWVmNJSEpGWjRXd0ZNa1dRd2dBR1QwS1BVTXc2?=
 =?utf-8?B?NVlqK2hRMVBEbTljMk9WN3kzQ0tTaFBEaFhvbmZoNWFSQW5rNW0yb21iMXZJ?=
 =?utf-8?B?RytBeVJsNUpQNGVtY3pkN2Zna25hUzU2ZmRYM2p6aVRVbDVxdzViQ0k2T1oz?=
 =?utf-8?B?bkZ5TUhEVlZHZmhtSDY1MEUrd2tWdEJITFdGcUczYXd2U2pVZzdVR2Y3Zlg3?=
 =?utf-8?B?eDNlY0pVUDJCck5haVE3ZnFBZktrRkY0TDFHbTdMWHBmd01FRlIxVWZ0M2Rw?=
 =?utf-8?B?OGtaTWZpSjE2czc4aE1BMHZBUUw0aVYvbnI2YlpVa1g5RmJZTWNWaVFCT0hW?=
 =?utf-8?B?ek83VFdDbk5Va3loMS9PRzQ5ZzFSRUxlanpQSnZNODlxSWRiVVIva2Y0QjZo?=
 =?utf-8?B?ZDRtMEZzN3U1eXM1akd2VGVyUVhSd3hERUthcjNZMFhHUjlVQkR0YkZnc3cx?=
 =?utf-8?B?TnNjWDdWdjIwNFFZa3BsZ1BiTTl5dnZTWmlBSEFpOGs2ZlVBd0Rub3JVTUJ0?=
 =?utf-8?B?cDdtT2ZIREt3a295NmJJYmZZMkFTaDBvajhKSlk5Y1RKZDI4YmpqRUpaNU1F?=
 =?utf-8?B?ZmNCVnBoSGlYTmpTZ1lMMmpMNk1LVFI3djRBeTJTOWI2bTVoYVJEaHNzVDVM?=
 =?utf-8?B?VllwbE8yK3czTlQramZzVFQwSE83MnYrUURjWUJJS0JPOEY2UTFjMVhHNVQy?=
 =?utf-8?B?aUNMRldvaEdXN05zaVhOYk53NDUyYkpBRG9sMFdDTDU2blF0MTNieVNEbGV6?=
 =?utf-8?B?T0JrSzhOL2VCblhjRkRzZmxGMEF0OGUremlEZFVkQ1RVcldFVnY5cTZaR1pY?=
 =?utf-8?B?MkpLWXlKeFdLNWJsYkRhY0UrTWw1cFZJR0xBbTdhZHAwTDgvNUxmbW5EWjVG?=
 =?utf-8?B?YThJdjdJM2FMQ21RTm9POTZpT2Q3andQMEVIaGpQWUY2djFxTDM1TThLc1JN?=
 =?utf-8?Q?LxQUKemg6C1UFTbpSC6zTlQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E362869573AB948AB321D8F0FC43AE9@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8296
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 675f238ba90e4278b5d4419e4fa84063:solidrun,office365_emails,sent,inline:6fd6095686a65a9ab03b9322b250c195
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	810f8930-cca4-4e91-b856-08de58d2d936
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|14060799003|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THo4T0puMGpnWGdLRVdYdlN6OGJJVVV6bUEyZllKZy8xVy9MWWlMdUtFMUsr?=
 =?utf-8?B?QkcwNnc2V0hiQTZ0a3lNY1VPYnJGN080U24vS3pBTjQvUW81ckNRMFNVNW1W?=
 =?utf-8?B?L2Q4L3pmSHFEeURITjZCZ0htNUw5S21DVXNuNlV3bC8yZEtKYWlGWDZreDFI?=
 =?utf-8?B?ZzhKTnR2SUJ5Lzg4RG4xS1JUa2NtZllESE5hMEdpNC9RVEQ2VTlaZlZkajRK?=
 =?utf-8?B?cWxkQmNtUkdyVC9IU1JWWkx6M2RxbFIzOXFaU1I4TWtEcHBTZG9ZU1hJNSs1?=
 =?utf-8?B?ZkpQalo5L3pVRjJqeWJTeVpIaWtZN1N3Z3RSdWJScHd1K2w1dEUvdGNiSDQ5?=
 =?utf-8?B?c2ZDWWRNZndQMUhvZWVCK080SFRRc040YWt0dlhwYVZISnNYaVFnL1pCYkNH?=
 =?utf-8?B?elhOWm5hTW14RHRkcEx2YnNvclpWdyt2TXIvdTBScG1ZNjdrV25QSytkcjYv?=
 =?utf-8?B?Y0hSaVJRdUdvZGlLN0twZkpTTldXTUozVFc5a2dyVDBzTGk0RmlyNjlXaC82?=
 =?utf-8?B?VytWS2E4SmpoU2J4c3NOcC9kd2xjak9ZbzBTMUlMUjFKbVVKenlQRkY3Q2hu?=
 =?utf-8?B?d29BZUdodXBMZ01CR2l0bGMvNFpFT0dEUExXRlRJZjZ3WXkwVDZmZFZsc2tU?=
 =?utf-8?B?aGY4Z2VGQk1kSzBwb2NhOWNYM0R3WUdBYWN3MG1NSDRyRXBLb3RLbGRDQ1JO?=
 =?utf-8?B?NmlQVFZkNThkRUtpNXhxMTZUT0pOQzRnNm9XYnpQaXJGUTVQbUVkV2ZET1U5?=
 =?utf-8?B?eUx0NnlaeXV4UXNhS053NHJLR0Roa29rWFdWeUZNNmJZTmZqcEhyYjl0ejVY?=
 =?utf-8?B?OXM4QlorVktZaE1GY2NEMHhLMWM5bW93U05PQW8rSG5IcWJWOGd2YjNGQ0tx?=
 =?utf-8?B?YUhnaDJ2K1lIWGFZNmZuK0Q2TDBNTndzeHYwRFhwUDY0TlBYYi9aR3IrUEZW?=
 =?utf-8?B?ellSZ1kzVjFuZ2JTZ0VmSjdDZndRQlgra2MwYkE0dDZVZmEvRDdpOTdkWjg0?=
 =?utf-8?B?eCtjVndHKzFIb0F2b0w2ZmtuUzQrN21VanhVL2owN2poTHd3WGN6TjdSeGZF?=
 =?utf-8?B?cmFwTmxsVkorb3U1YmlnUmc3bC9qUWpVMTdrNUsraGRiQzVxdWhiNDgrQ2hM?=
 =?utf-8?B?MkNZbitCbzRYTi9Ddm5MMDZOWFV5WnNWS3R1KzBmMWhGWUNQSzV2eEVtM28y?=
 =?utf-8?B?bTdZdXNNcmxSOVVNbXNXMGY2R0kxZEJRek5jZHhOZ3kxaUp4V1lPdnBmY2Zv?=
 =?utf-8?B?Z1IwNG9lVVgwYTZpZkRCaHVmNUZVTWdOcGZOVkVVeXJsU2JrREhGVG43ZkxE?=
 =?utf-8?B?RkpNWmJKWHpER25HL0E1eG1IVTdsei9wRi9Cc0taTjV2Zy95RThrQkV4SGkv?=
 =?utf-8?B?NUdwQ1VHdjZLUzB4ZTdueEkyVlNiU2hLUzZlMTRVSi9ab1p3UW4rRzdLcWo2?=
 =?utf-8?B?eWllV2xwTkhpcFFiNm80Z25jaytFVGx0RjdjU3NsTjZtU2E4b1FNTUxOMG5m?=
 =?utf-8?B?S28veXhZR3NISkVySGh0WWFHdWpjUXhoNG1GZkpDcUZHanNXSWlYOTJqaWo0?=
 =?utf-8?B?cFdqWlV3ME93ZU9EY0R0WjZwUjdaMmZiUzU5OGl6SSs3eUF1QlNXQVFFN29Q?=
 =?utf-8?B?dWtMM000UTlUYStJeUVXbzM5NUtBUThUSi9vUmVVWis2WWpyeGoxRkttS2k2?=
 =?utf-8?B?K1ZBV005VnpYNTlIb1pvUDlFL2tjY3ZXMHJMOGNQN053WEh3VG45VHR1bDUz?=
 =?utf-8?B?amxhVlNHUTZFNWloR2VHQWU2YWtLcCsxWXhpcVlGN2NscEF3QXhmeVgrSk9W?=
 =?utf-8?B?SzVmekI5bEpkQTY2cWx3aWdkaFpGSytBd3Q3WFJYTHdaQTBDS1dXME5VbDNT?=
 =?utf-8?B?STErdnRUOVFubm5TS1gyMXppUXdJOTczVS94cWpJNzFOMGVMaTZpR0M5bVBi?=
 =?utf-8?B?Y0FMc2J5VVBmUllKTGRxQll2RVg4NDdIOXhXaEdQcTRTZWVodVRlUFd6L1Mr?=
 =?utf-8?B?OUx0YnBDbUQ5NzBjNFNYdytEYkZXYUtFK2VpWDBlWHFuWmIvMktkVEtrWndq?=
 =?utf-8?B?K1dpT0EycWFrVzhFOHJJQ2RHTW1USUJ2bXF3ZS8xc2ZJZ3JMdjkzdHFnUlZ0?=
 =?utf-8?B?VytZSUZ2T2wxM3cxcFh2N0VDZWVCRDJQbWxLZCt3UlVzR01La25DbDJJV3Q1?=
 =?utf-8?B?UEtSQmZDTXhzTzRQTnUybUxwTW9xRjVxTU1YeGtFc0xaaXhzVTdZNUJCdmZy?=
 =?utf-8?B?ODltb0FZc2VWYXgzSFRZY1UzcDd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(14060799003)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:53:05.4825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4973c040-10a9-4230-2d0d-08de58d2dfe4
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7761
X-Spamd-Result: default: False [1.74 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251835-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,solidrn.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E7FC254FD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMTkvMDEvMjAyNiAxMToyNywgTWF4aW1lIENoZXZhbGxpZXIgd3JvdGU6DQo+IEhpIFJ1c3Nl
bGwsIEpvc3VhLA0KPg0KPiBPbiAwMi8wMS8yMDI2IDEzOjQ3LCBSdXNzZWxsIEtpbmcgKE9yYWNs
ZSkgd3JvdGU6DQo+DQo+PiBJZiB0aGUgb3BlcmF0aW9uYWwgbW9kZSBvZiB0aGUgUEhZIGlzIHJl
Y29uZmlndXJlZCBhdCBydW50aW1lLCB0aGVuIEkNCj4+IHRoaW5rIGl0IHdvdWxkIGJlIHJlYXNv
bmFibGUgdG8gcmUtcmVhZCB0aGUgc3VwcG9ydGVkIGxpbmttb2Rlcy4NCj4+IEhvd2V2ZXIsIEkg
dGhpbmsgdGhpcyB3aWxsIGNhdXNlIGlzc3VlcyBmb3IgcGh5bGluaywgYXMgY3VycmVudGx5IGl0
DQo+PiB3YW50cyB0byBrbm93IHRoZSBsaW5rIG1vZGVzIHRoYXQgYXJlIHN1cHBvcnRlZCBzbyBp
dCBjYW4gY2hvb3NlIGFuDQo+PiBhcHByb3ByaWF0ZSBpbnRlcmZhY2UgbW9kZS4NCj4gUnVzc2Vs
bCwgSSBhZ3JlZSB0aGF0IHlvdXIgcGF0Y2hlcyBmb3IgcGh5ZGV2LT5zdXBwb3J0ZWRfaW50ZXJm
YWNlcw0KPiBhcmUgcmVxdWlyZWQsIGJ1dCBJIGFsc28gdGhpbmsgd2UgbmVlZCBhbm90aGVyIHBp
ZWNlIG9mIHRoZSBwdXp6bGUgdG8NCj4gc29sdmUgSm9zdWEncyBpc3N1ZS4NCj4NCj4gIEZyb20g
d2hhdCBJIGdldCwgaXQncyBpbXBvc3NpYmxlIGZyb20gdGhlIFBIWSBkcml2ZXIncyBwZXJzcGVj
dGl2ZSBvbmx5LA0KPiB0byBrbm93IHdoaWNoIGNvbmZpZ3VyYXRpb24gdGhlIFBIWSBpcyBpbiwg
aS5lLiBpcyBpdCBpbiA6DQo+DQo+ICAgMTAwMFggdG8gMTAwMFQNCj4gICBTR01JSSB0byAxMDAw
VA0KPiAgIFNHTUlJIHRvIHNvbWV0aGluZyBlbHNlID8NClRoZSBQSFkgZHJpdmVyIGNhbm5vdCBr
bm93IHdoYXQgdGhlIG1lZGlhIHNpZGUgaXMsDQphbmQgaXQgY2Fubm90IHRydXN0IHRoZSBzdGF0
ZSBhZnRlciBpbml0aWFsIHBvd2VyLW9uLg0KDQpJbiBwYXJ0aWN1bGFyIGJlY2F1c2UgaGFyZHdh
cmUgZW5naW5lZXJzIHdpbGwgcmVmdXNlIHRvIGNoYW5nZSBQQ0INCmp1c3QgYmVjYXVzZSBzb21l
IGJvb3RzdHJhcCBzaWduYWxzIHdlcmUgKHVuLSlpbnRlbnRpb25hbGx5IHdyb25nLA0Kd2hlbiBp
biBmYWN0IHRoZSBwaHkgY2FuIGJlIHJlY29uZmlndXJlZCBhdCBydW50aW1lLg0KDQpCdXQgdGhl
IGhvc3Qgc2lkZSBjYW4gYmUgbmVnb3RpYXRlZCB3aXRoIHRoZSBNQUMuDQo+IFRoaXMgaXMgb25l
IG9mIHRoZSBpc3N1ZXMgSSB3YXMgZmFjaW5nIHdpdGggdGhlIFNHTUlJIHRvIDEwMEZYIGFkYXB0
ZXJzLg0KPg0KPiBTZWxlY3RpbmcgdGhlIHJpZ2h0IHBoeV9pbnRlcmZhY2UsIGlzIG9uZSB0aGlu
ZywgYnV0IGl0IGRvZXNuJ3QgYWRkcmVzcw0KPiB0aGUgZmFjdCB0aGF0IHdoZSBkb24ndCBrbm93
IHdoaWNoIGxpbmttb2RlcyB0byBwdXQgaW4gcGh5ZGV2LT5zdXBwb3J0ZWQuDQo+DQo+IFRoZSBh
cHByb2FjaCBJIHRvb2sgdG8gYWRkcmVzcyB0aGF0IGlzIGluIHBhdGNoIDMgb2YgdGhpcyBzZXJp
ZXMgWzFdIDoNCj4NCj4gICAtIFRoZSBTRlAncyBlZXByb20gc2hvdWxkIGlkZWFsbHkgc3RvcmUg
aW5mb3JtYXRpb24gYWJvdXQgdGhlIE1ESSBvZiB0aGUNCj4gICAgbW9kdWxlLCBpcyBpdCBvdXRw
dXRpbmcgZmliZXIgYXQgMUcsIGF0IDEwME0sIGlzIGl0IEJhc2VULCBldGMuDQo+DQo+ICAgLSBp
biBzZnBfc21fcHJvYmVfcGh5KCksIHdlIGhhdmUgdGhlIHNmcF9tb2R1bGVfY2FwcyBmdWxseSBw
YXJzZWQsIHdpdGgNCj4gICAgIGZpeHVwcyBhbmQgcXVpcmtzIGFwcGxpZWQsIHNvIHdoYXQgSSBk
byBpcyBzdG9yZSBhIHBvaW50ZXIgdG8gdGhvc2UgaW4NCj4gICAgIHN0cnVjdCBwaHlfZGV2aWNl
DQo+DQo+ICAgLSBUaGUgUEhZIGRyaXZlciBjYW4gdGhlbiB1c2UgdGhhdCBpbiBpdHMgLmdldF9m
ZWF0dXJlcygpIHRvIHJlcG9ydCB0aGUNCj4gICAgIHByb3BlciBsaW5rbW9kZXMuDQo+DQo+IE9m
IGNvdXJzZSwgdGhpcyBtYXkgbm90IGJlIHRoZSByaWdodCBhcHByb2FjaC4gV2hhdCBkbyB3ZSB0
cnVzdCBtb3JlLCB0aGUgU0ZQDQo+IGVlcHJvbSwgb3IgdGhlIFBIWSdzIHJlcG9ydGVkIGxpbmtt
b2RlcyB0aHJvdWdoIGZlYXR1cmVzIGRpc2NvdmVyeSA/DQpGb3IgdGhlIHR5cGUgb2YgbWVkaWEg
SSB3b3VsZCB0cnVzdCB0aGUgY29tYmluYXRpb24gb2Ygc2ZwIGVlcHJvbSArIHF1aXJrcw0KbW9y
ZSB0aGFuIHRoZSBwb3dlci1vbi1yZXNldCBzdGF0ZSBvZiBwaHkgaW5zaWRlIHNmcC4NCg0KQnV0
IGZvciB0aGUgYXZhaWxhYmxlIGxpbmsgbW9kZXMvc3BlZWRzIEkgd291bGQgdHJ1c3QgdGhlIFBI
WS4NCg0KPg0KPiBJTU8gcmVseWluZyBvbiB0aGUgU0ZQIHN1YnN5c3RlbSB0byBidWlsZCBhIHBy
b3BlciBsaXN0IG9mIGxpbmttb2RlcyB3ZSBjYW4NCj4gYWNoaWV2ZSBvbiB0aGUgbW9kdWxlIGlz
IGEgYml0IGJldHRlciwgYXMgd2UgaGF2ZSB0aGUgb3Bwb3J0dW5pdHkgdG8gYXBwbHkNCj4gZml4
dXBzIGFuZCBxdWlya3MuDQo+DQo+IE1heGltZQ0KPg0KPiBbMV0gOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyNjAxMTQyMjU3MzEuODExOTkzLTEtbWF4aW1lLmNoZXZhbGxpZXJAYm9v
dGxpbi5jb20vI3QNCj4NCg0K


