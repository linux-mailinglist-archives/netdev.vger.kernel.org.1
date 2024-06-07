Return-Path: <netdev+bounces-101914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF73E900957
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31782B22C04
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B862198A24;
	Fri,  7 Jun 2024 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z3c30He7";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I0ZfX4FS"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2A198E9D
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774775; cv=fail; b=OyvK1QWsjQotJnlcpdzszGzj83eZ/UGmnEinr3WF5W2A2HyBEtkVTtQULGTu5DVitfrfXep8+Z8VxMCKmhIAgC+7SKehTYOwX9EwUeDCD/BqeBasousYD5Pe6yZQcvukScAwsQ6XWBY4J3A5MRmuEkBPhadUvT4vU7OJJAbjpkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774775; c=relaxed/simple;
	bh=dKebTh4J412dToml4AO1QG6jAEj1aLrrsFfuQ8iWwAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e6NUhO4CoJAxvPZBjkJZEBAfyLr8YT5chhPhO/vAK9vQL2zshm35wos+h+8P9BEhnYCxbCu2NK19A4ptq7rWi0kLOMQwB2v6tAIAF9x+vwjBODdtYztAGBNSWsWQHnAosZWT/Z14x5bz4yRLWgu+V7X5ZdlFa6AOr4OIKNTyBIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z3c30He7; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I0ZfX4FS; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717774772; x=1749310772;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dKebTh4J412dToml4AO1QG6jAEj1aLrrsFfuQ8iWwAM=;
  b=z3c30He74dD8uuosfTGfHCBJparL7Qy8hApDW2s+a4nruU7fSlTm47sg
   WjQe2Rq/J5Bfi8TFWffNsKGA+/gzk8d7F/pI8qxvIh15/8qzkcdE0bzCK
   Mm9TzMLg7SzDSpCfqCNQARxNvhvbvwTLhDCp7TS2VBfci38mRmIFKPxWU
   Jfp31la/cjJ1vPN9AOnRelvNPhXdH0A1sLy1ueB794X1VsdKx4lhfcefj
   iowdA+XBQi93+BZqaOPLRn7ov1+QTbYjDxrL/B8nPt9soXkWdvacgwzXk
   nkA+94FpuzH+H1NNtm6CdA/pRoPlJo5MzOixOng9pSYNrU8M+oYJJZQv+
   Q==;
X-CSE-ConnectionGUID: 2YdZ3nETQGOdSHA/xUN2YQ==
X-CSE-MsgGUID: KrNIjbzJQcGfH4owlt7H8g==
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="27137207"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2024 08:39:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 7 Jun 2024 08:39:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 7 Jun 2024 08:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBaKL7tMRC8PqAzHD5uIu72SffMFSdZL5YqiDDXIWzJUDjSUdJrm+6h5LOYYXjFXNS5oRIuuiKtjIQyNk9S+7YFDaD+G4v1GWN2WoM9R1/ygCHjIwcnuX6Gs/CdnD1q1P7uYbUguwmEe1iozw2EgQNbvPL1DccGLLESzvRn84cyNcO4Us/RePU0cEO9a9YgKymQg6/9+dA/4kqAP0pG6XSdo5ke4pHrLbmD1EJvb64oOoj2elRsy/0j2EAzeM+9z9eZaUalaC8MQjECNdZ1cdEpxvkLCvgfwGH4H/1/KgnRtwxjj8fox5MrzpuAzucKfJoIxnT8miWcE1DfqC98xDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKebTh4J412dToml4AO1QG6jAEj1aLrrsFfuQ8iWwAM=;
 b=hAGaFHOBLYHLzrcMWdug8WKx6r1+0BOVtJF0KMTp6zyjUONuuJWaO9wbpUXSICHKWobdx2WJ+GUqrxbaze5CaxPknqssHDl+V5XoR3YE7KopHziErcqGKKHLPkgAwKt95g2IFIvGQqy67ZgHU9c06FADCOaVWIKoxuuHXaLnA4P9cb+gEnGRUOo0p+YOXwbus/1lX8qhOxfcUPfz55sCQOHDbc1K62opNwkbeZM2tuJM7cQ6SBJ+mlOlI6dJeRat5ZXXJ+Rq4U8r0ZLWsoIQ6ZT4PpxUm0WAQ92IycfA6wb4pXR+EAk7jv7zy82tuv1sf90vhD8Dum91lG14QXsY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKebTh4J412dToml4AO1QG6jAEj1aLrrsFfuQ8iWwAM=;
 b=I0ZfX4FSyj/4C98UBgtWWRb/wB8VzfbDkZa589x3SEHHB1w78xTsmrr2uWtcOJC8lmZG8OObIVnI+XmypTek7xEdfDSkRxpWrCCJpfPJg/3WC/HTEU3RW1ygFCC0WwS3JgSNK1idNjM1xA2uN4u8sFB+oev/HA1B7XSx3QwubsBNUb0CMCsKNeBUpx0hKk7DASVdBd2OrOTNAraOX6qqiHbaI7qEGlSWtyBAB31Dfm9399tTw244VpyZoyuOqwuLRFeu7hKvME84ewPhqlkCNpAZYHApc2wWltEWjXnA+nfe5Xb8Xv8GumUNeKy6Ixf2AtF75kbtiDb3gKaDdflKBQ==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by PH0PR11MB4950.namprd11.prod.outlook.com (2603:10b6:510:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 15:39:19 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 15:39:18 +0000
From: <Woojung.Huh@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>
CC: <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>
Subject: RE: KSZ9897 RMII ports support
Thread-Topic: KSZ9897 RMII ports support
Thread-Index: AQHauOKWABCBqyY9kUOyhBXqEndhr7G8YIUg
Date: Fri, 7 Jun 2024 15:39:18 +0000
Message-ID: <BL0PR11MB291351263F7C03607F84F965E7FB2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <21cd1015-dae8-414e-84d3-a250247a0b51@savoirfairelinux.com>
In-Reply-To: <21cd1015-dae8-414e-84d3-a250247a0b51@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|PH0PR11MB4950:EE_
x-ms-office365-filtering-correlation-id: 243ae756-af77-4138-fcca-08dc8707fed0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RGNqQTZtYWV4ZmgzRlJ3YTFuWEIyTWhqVHNrOWVCUVNqR3EvbTRLY3JLMmJN?=
 =?utf-8?B?MGJoVHNoRmp1T1JFSHIwcnMrZFpSTDhqVk4rb0ZNNEp3bTdhMDFJNDZBak1h?=
 =?utf-8?B?cmdsbHYrSThlSk1Db3ZzTkpvZlRXSnRkT2ZiSUlZYk16UERNTjkwMTMvbFZ2?=
 =?utf-8?B?dzFzOUpBd3kxb2JmTEpsbGR2STF2akFFaHFmM0RWalBUK0dSY3E5cDlldGZL?=
 =?utf-8?B?dE1IRkdHV1RGWnpYWUtjdW9pcE96UUJZN2JvWkozVGZGNlBGUE9pdlBFRU5p?=
 =?utf-8?B?ZzkzZm9oY3FtYnZ6bWk2Y1owaS9uTVpheW02VEpTSFVzWGk4MUxPZzR4V3NE?=
 =?utf-8?B?VWZnMFNIR0lJcEdzZUtUTSs4ZEdFcjlObVdpek4zN2ZZQ1oyS0doOXpVVWxh?=
 =?utf-8?B?WVJGbURqYXNzY0xNY3FTSGxvTkJJT2VjN0J3VlRjSVFjVk9jOHl5ZVYyeHRI?=
 =?utf-8?B?djFlQjJNQVJDNDFRWjV6YTV4MGxRNWphOG9ZaUJXMDgybU1Ia0grbitWNU56?=
 =?utf-8?B?amtHbkNBdmh6QUFHblJWcnVDMmRxQWxyVVllMlBkVDhPKzlscGVzNGxQMHps?=
 =?utf-8?B?eW9rSlZnYnRnWWpybkQ4bk5qYTN2VWdZMCtrOVJOR3lUTUx4Q3lqbU9kVkdY?=
 =?utf-8?B?RG50WjFYWHkzcHZUMStDQ2s0WUpHODJGNXdIZXNMZ00vaTZTalJTeEVvWldB?=
 =?utf-8?B?WStqQ01KRVYyNVNnOU9QN2xiQnlzaDJCOVgwODJyeElMUWx1eDJmQmpmVWt1?=
 =?utf-8?B?Y2NNM3B1eVo0K1ZBYVlDKzRZWmlrcjhha3NyS0RTQ0s2SG04dldqUjRkOW5C?=
 =?utf-8?B?a3J6bmlJeFRsck5mL1J1ZHJjTDlkMkFha0MvTm9PcEVlSWVrRGZQUEZKVVZx?=
 =?utf-8?B?bTFMTEswT2liVGFhdkhSZWNpZkZ4OHppYmlaNTRVRDJiSmRWT0d4SmJPOWhO?=
 =?utf-8?B?YjdRUDFNWkEzUE1USmd5bHhjelB6ZTdoeUR6aStkdmFuZjFlV2tITFAzeWN4?=
 =?utf-8?B?dVFIVG5XVXpvRlJTM3JjTFlNOXp6aUNaRXdQbVpXajlDMDFCNEpUTGZsdGN0?=
 =?utf-8?B?U0tFMlB5V0NFTmszRGVpSGJHOXNuMGJKcFJPYlErdUhYRnVpUzBJRFFxc3k2?=
 =?utf-8?B?K3ZqKzVoU3YrcWJZb292TW10ZDRuZGZuTmZuVll5V2hMSmY5S3cvTTlEMWZs?=
 =?utf-8?B?Uk82bjNWZ2tqVDkvWFIrWTd1Zlk3amd3bTJBT1lNM29taFhRdzRVbGsvTnd5?=
 =?utf-8?B?WDJCR0hIY29BMWdab0RoL3A3U0hiS1dDMU5NaE93MGNDa3c3ZHFrSFBDaSt4?=
 =?utf-8?B?M2EzeVNxVU1WNThJdmN4QlJKTkpyQTgzTTRtMTdTTTFVdXRBVXE2RmF0aVFJ?=
 =?utf-8?B?N3hWaUFqdEsxOG5UQXR1TlJwa3F3YWlRV2g3RTgrQ0YwdWpGOVRFbExnR0Za?=
 =?utf-8?B?TE1qcVE4U3ZjRWd5anFBSGlXMHFqbjFaRXlNODRGTnhiWFdqVGErZFhXR29i?=
 =?utf-8?B?dmhQTmJMTThzQ0orKzlOeE90MHFJUW44ZXdRT3JuUWZlUnpmSEs3OFpZSG9z?=
 =?utf-8?B?ejVTVERyNGRoaEl4RmFrQkh3cGd4RjY0aUNuaGZ4UkhHZThCeGFpdTF4RGU4?=
 =?utf-8?B?cC9LSXJPa2xzcEVPTDkvRGdlbGkxc1JtWHJVUGhGVXdtQWF5SGRMYlo1N2tN?=
 =?utf-8?B?dUNQOVViME1OYjJENlhjVjZqWUVjc2owSkx5dW8zZVc3NUxwRUhHSE1jcEpl?=
 =?utf-8?Q?tZUrWlCJICRafQg4Yc4Z+aBYySG8OEPjNjkXEq6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1NhSStDOTFRd3hGTy9seGxpTzBXRllwc1hKd2RYU2l6T1BZNXlsMWh3Y3Nw?=
 =?utf-8?B?ZzRlVzFDTXFDSnNrZlJ4WUdrNHpUNzFvb0hWMzdpRzZpWTJrelRnYUxYeWpy?=
 =?utf-8?B?WVdqYjVNUkhRaHY0d0oyb2puelNWWGYzMGl3M2RDbEQ3SjhWVnI5eGkrakJ3?=
 =?utf-8?B?SUVUbElvdTdEaFFuTElQbUNiQ2lQWXJOeVQ2cEdFVjl2TUhWQVBqY1ZESHV0?=
 =?utf-8?B?eXVBK1Y4dEEwdEdUMnNObHNEeWtGTlZ3dmJpWFQ5eUE0c2s1S3R4VVluQ1Vh?=
 =?utf-8?B?MnNlWVZHZWo4L29oUjFHVC83YzYrejZZR0FRb01jK2ZBcyt1Ykd6UU5hbXE4?=
 =?utf-8?B?U2FlczJ4NXBpNWdIRDZxVmRNcEhERjA1YnMwUy8wUTQySTgxYXVpOGRKK2hZ?=
 =?utf-8?B?dzBJZ0RSek5aQzQwQUNzNXQ4SDZqUkN4VzJTYTF3MFNzNDFad2pVYXN5QzlV?=
 =?utf-8?B?T1p0WkgyQVI5eWlybm8wV0V6TmcrSkZ0WDBKY1Z2cXlZdVErQXBVbmIvWFVx?=
 =?utf-8?B?NWhXOXBlM2tRaFYrUHJaUFhHVGVqR2VWN1k3eVRsT1B5dzFydHZUY0F2SllI?=
 =?utf-8?B?a3RCZ1ptb3FRNnBxQmE2T1YyT0M5dWZ5eUNGV3RCeHVuZmFKMVEyekRGQVRq?=
 =?utf-8?B?VXEzelB1cDdGOFBkWWhOaU5CR0tOQVNLYldkY25WZXZ1dVovNXRCSXk1bkZj?=
 =?utf-8?B?dFZTZko2KzZmM0hnVHowSHNGL3pvTXdOaXZjY3dOcTBEeHY3UklQSm1CdnNB?=
 =?utf-8?B?NUdqMWpJVjdyMnVRcGlyNnFUV1owektmTEtpZlA3RzZ5ZzlXaXZ5VHJtbEJo?=
 =?utf-8?B?T1lob1FLZktUS0tqajA2VVVYN2pyUDl0dzFXdHF2eVVhbGxNSFhzNWdJbjYw?=
 =?utf-8?B?RzJrT20rU3JURnh3MmdvMmpCZE52SVJ6TldKS1VtK3FocXBjVThZOHloN3Y5?=
 =?utf-8?B?NkFkWStzcmQ4OUlDT1hNb2FQbGYvRW9ocjFFdDdpLzhNUmFqNEVha1czNUlP?=
 =?utf-8?B?ZHU1NXNkVWxVVW02TmwxUVhXQlU3NHlDZmVycEdIYlFOalgycjlFcFk3VStj?=
 =?utf-8?B?by9rbGNyL3lGbHRZSXZ4WVpjMlhXOXl6TmE5dkdtbXV5N3JuaStVT3NZTHlh?=
 =?utf-8?B?YTI2Ym9UcG0vUU42blBGYWlacm9OdjQ3TElFc0ZPNnhhK2MrdnBzSnRmREdQ?=
 =?utf-8?B?RzVqR0c2ekdiRDgxV1h3bDlNM1g3VVZNdlVXS3RYSzNhT3lsZmZDQjBGb1Rh?=
 =?utf-8?B?ZFRidzFKbGtDRGhIWWM4bTh6T2tFUDRsbjNoVFhManlYaUtMZkluS214Y2k4?=
 =?utf-8?B?WVl0eWI0Y3JkOXNPUG40ZXUyYWNrc1AvRjdOSkpZNnhENEJNOXVRN3RTcVlt?=
 =?utf-8?B?YnpiMituWkNVeDRLaEpRZUNNWDRGY3g5UTJBbWtiRW9IK0Y5N1R5WGtwY09S?=
 =?utf-8?B?ZWN2MnVnMXN6M2o5OVp2dC95bkt6N2NYazhxZER0SHZYVjV0RHBrL1pNTWd0?=
 =?utf-8?B?SXliRVRmNy9kRmtwajNYUXV5Y3Y0bGU3SHFrVlR2QnpSQ2ZnUmk1VFJ4cDQv?=
 =?utf-8?B?ZitEVFgxVExEb3FjS05HcE00QUtlV1dTZFBtSUY1d2JkNTdGR0d4enJqWEZR?=
 =?utf-8?B?RGx1alI5UDE0TFl6R0c1cy8zNWRrZFVQWG1kenA3K0F5YmVpU0JKS2UvcVdJ?=
 =?utf-8?B?SG16N1FpY0xCOFJWRXB1eEVOMWxMS1BvQ2VmMTI3SWNGbXpKVEZycWd5T0Jm?=
 =?utf-8?B?M0JJWEFneXhpNU5FRGNCZkRXZ3BmNnp3cGhycHZobE15bUM5aHB6bGs3QzJU?=
 =?utf-8?B?cmRYWUhtWUZHdENHMHArQjY4YnYxc1NQakg3YUg1TldacG1Kbm0zcWxSS0NN?=
 =?utf-8?B?T0VnaVN6bjRnNWxIM25TVGF2SUVuNk9idzE3SkVmSWZVNUIxK3p2ekJwMFM1?=
 =?utf-8?B?NEd4bWdDUnAydDZ6L2h6WjF4NmVkbytJRnRVZ0QzQ0cyamh4V3FpYmFrTDlq?=
 =?utf-8?B?ZUp2M2txcDZwa0luNTZMNDczaU43UVZmY25lQ1cvQUdmOHFQdnZ0ZTNnR1Mw?=
 =?utf-8?B?bG1yNTZzbWowclFTWktXNnVmaFFHUnZDa1ROWm43UVl5V0grVUhqbExQVTFt?=
 =?utf-8?Q?CGb0tkrWZ6NaUTkEWZsBPgR5N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243ae756-af77-4138-fcca-08dc8707fed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 15:39:18.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jqR68WMmrxbQhLX9JAkyFUhwS4tnm72VzB4jPdHbWou0vbxUofkuAyOkIV4//dpMwNvygzFDkHQ4VyaF70yQPPPjJ1zQxtVnOPSHY88mSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4950

SGkgRW5ndWVycmFuZCwNCg0KVGhhbmtzIGZvciBjcmVhdGluZyBuZXcgdGhyZWFkLiBDb250aW51
ZSBmcm9tIFsxXS4NCg0KWW91IGNhbiBjaGVjayBTQU1BNSArIEtTWjk0NzcgRVZCIERUUy4NClsy
XSBpcyBob3N0IE1BQyBzaWRlIHNldHRpbmcgYW5kIA0KWzNdIGlzIGhvc3QgcG9ydCBzZXR0aW5n
IG9mIEtTWiBzd2l0Y2ggc2lkZS4NCg0KWW91ciBldGhlcm5ldEAyMGI0MDAwIGhhcyBwaHktaGFu
ZGxlIHdoaWNoIGlzIG5vdCBpbiBbMl0uDQoicGh5LWhhbmRsZSA9IDwweDE1PiIgc3BlY2lmaWVz
IHRvICJrc3o5ODk3cG9ydDVAMSIgdW5kZXIgIm1kaW8iLg0KSSB0aGluayB0aGlzIGlzIHNldHRp
bmcgeW91IGRvbid0IG5lZWQgdG8gc3BlY2lmeS4NCg0KImZpeGVkLWxpbmsiIHVuZGVyICJldGhl
cm5ldEAyMGI0MDAwIiBhbHJlYWR5IHNwZWNpZmllZA0KdGhlcmUgaXMgbm8gUEhZIChmaXhlZCBw
aHkpIGZvciAiZXRoZXJuZXRAMjBiNDAwMCIgYW5kIGl0IGlzIGVub3VnaC4NCg0KS1NaOTg5NyBz
aGFyZXMgYSBwaW4gb24gU0RJL1NEQS9NRElPLCBubyBNRElPIGlzIGFjdGl2ZSBpbiB5b3VyIHNl
dHVwIGJlY2F1c2UNClNQSSBpcyBlbmFibGUgZm9yIEtTWiBzd2l0Y2ggY29udHJvbCBhY2Nlc3Mu
DQpJIGd1ZXNzICJrc3o5ODk3cG9ydDVAMSIgdW5kZXIgIm1kaW8iIGNhdXNlcyBwaHkgc2Nhbm5p
bmcgb24gaG9zdCBNRElPIGJ1cywNCmFuZCBhc3N1bWUgdGhhdCB0aGVyZSBpcyBLU1o4MDgxIFBI
WSBvbiB0aGUgaG9zdCBzeXN0ZW0gKHByb2JhYmx5IG9uIE5FVDE/KQ0KDQpQbGVhc2UgbGV0IG1l
IGtub3cgbXkgYXNzZXNzbWVudCBpcyBub3QgY29ycmVjdC4gV2UgY2FuIGNvbnRpbnVlIHRvIGRl
YnVnIHRoaXMgaXNzdWUuDQoNCj4gYGBgYw0KPiBldGhlcm5ldEAyMGI0MDAwIHsNCj4gICAgICBj
b21wYXRpYmxlID0gImZzbCxpbXg2dWwtZmVjXDBmc2wsaW14NnEtZmVjIjsNCj4gICAgICAuLi4N
Cj4gICAgICBwaHktbW9kZSA9ICJybWlpIjsNCj4gICAgICBwaHktaGFuZGxlID0gPDB4MTU+Ow0K
PiAgICAgIGZpeGVkLWxpbmsgew0KPiAgICAgICAgICBzcGVlZCA9IDwweDY0PjsNCj4gICAgICAg
ICAgZnVsbC1kdXBsZXg7DQo+ICAgICAgfTsNCj4gfTsNCj4NCj4gLy8gTURJTyBidXMgaXMgb25s
eSBkZWZpbmVkIG9uIGV0aDEgYnV0IHNoYXJlZCB3aXRoIGV0aDINCj4gZXRoZXJuZXRAMjE4ODAw
MCB7DQo+ICAgICAgICAgIC4uLg0KPiAgICAgIG1kaW8gew0KPiAgICAgICAgICAgICAgICAgIC4u
Lg0KPiAgICAgICAgICBrc3o5ODk3cG9ydDVAMSB7DQo+ICAgICAgICAgICAgICBjb21wYXRpYmxl
ID0gImV0aGVybmV0LXBoeS1pZWVlODAyLjMtYzIyIjsNCj4gICAgICAgICAgICAgIC4uLg0KPiAg
ICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAicm1paS1yZWYiOw0KPiAgICAgICAgICAgICAgcGhh
bmRsZSA9IDwweDE1PjsNCj4gICAgICAgICAgfTsNCj4gfTsNCj4NCj4gc3BpQDIwMTAwMDAgew0K
PiAgICAgICAgICAuLi4NCj4gICAgICBrc3o5ODk3QDAgew0KPiAgICAgICAgICBjb21wYXRpYmxl
ID0gIm1pY3JvY2hpcCxrc3o5ODk3IjsNCj4gICAgICAgICAgLi4uDQo+ICAgICAgICAgIHBvcnRz
IHsNCj4gICAgICAgICAgICAgIC4uLg0KPiAgICAgICAgICAgICAgLy8gR01BQzYNCj4gICAgICAg
ICAgICAgIHBvcnRANSB7DQo+ICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MDU+Ow0KPiAgICAg
ICAgICAgICAgICAgIGxhYmVsID0gImNwdSI7DQo+ICAgICAgICAgICAgICAgICAgZXRoZXJuZXQg
PSA8MHgwYz47DQo+ICAgICAgICAgICAgICAgICAgcGh5LW1vZGUgPSAicm1paSI7DQo+ICAgICAg
ICAgICAgICAgICAgcngtaW50ZXJuYWwtZGVsYXktcHMgPSA8MHg1ZGM+Ow0KPiAgICAgICAgICAg
ICAgICAgIGZpeGVkLWxpbmsgew0KPiAgICAgICAgICAgICAgICAgICAgICBzcGVlZCA9IDwweDY0
PjsNCj4gICAgICAgICAgICAgICAgICAgICAgZnVsbC1kdXBsZXg7DQo+ICAgICAgICAgICAgICAg
ICAgfTsNCj4gICAgICAgICAgICAgIH07DQo+ICAgICAgICAgIH07DQo+ICAgICAgfTsNCj4gfTsN
Cj4gYGBgDQoNCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9CTDBQUjExTUIy
OTEzQkFCQjEzMERBQjFFNzY4ODEwRUZFN0ZCMkBCTDBQUjExTUIyOTEzLm5hbXByZDExLnByb2Qu
b3V0bG9vay5jb20vDQpbMl0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvbmV0ZGV2L25ldC1uZXh0LmdpdC90cmVlL2FyY2gvYXJtL2Jvb3QvZHRzL21pY3Jv
Y2hpcC9hdDkxLXNhbWE1ZDNfa3N6OTQ3N19ldmIuZHRzI241MA0KWzNdIGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25ldGRldi9uZXQtbmV4dC5naXQvdHJl
ZS9hcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAvYXQ5MS1zYW1hNWQzX2tzejk0NzdfZXZiLmR0
cyNuMTUwDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRW5ndWVycmFu
ZCBkZSBSaWJhdWNvdXJ0IDxlbmd1ZXJyYW5kLmRlLQ0KPiByaWJhdWNvdXJ0QHNhdm9pcmZhaXJl
bGludXguY29tPg0KPiBTZW50OiBGcmlkYXksIEp1bmUgNywgMjAyNCA5OjU3IEFNDQo+IFRvOiBX
b29qdW5nIEh1aCAtIEMyMTY5OSA8V29vanVuZy5IdWhAbWljcm9jaGlwLmNvbT47IG5ldGRldg0K
PiA8bmV0ZGV2QHZnZXIua2VybmVsLm9yZz4NCj4gQ2M6IFVOR0xpbnV4RHJpdmVyIDxVTkdMaW51
eERyaXZlckBtaWNyb2NoaXAuY29tPg0KPiBTdWJqZWN0OiBLU1o5ODk3IFJNSUkgcG9ydHMgc3Vw
cG9ydA0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBI
ZWxsbywgdGhpcyBpcyBhIGZvbGxvdyB1cCB0bzoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL25ldGRldi9CTDBQUjExTUIyOTEzQkFCQjEzMERBQjFFNzY4ODEwRUZFN0ZCMkBCTDBQUjEN
Cj4gMU1CMjkxMy5uYW1wcmQxMS5wcm9kLm91dGxvb2suY29tLw0KPiANCj4gSSBoYXZlIHN1Ym1p
dHRlZCBwYXRjaGVzIHRvIHN1cHBvcnQgdGhlIEtTWjk4OTcgUk1JSSBwb3J0IChHTUFDNikNCj4g
Y29ubmVjdGVkIHRvIGFuIGkuTVg2VUxMIChTZWUgYWJvdmUgZGlzY3Vzc2lvbikuIFRoZSBjdXJy
ZW50IHBhdGNoDQo+IGltcGxlbWVudHMgYSBwc2V1ZG8gUEhZLUlEIGJlY2F1c2UgdGhlIG9uZSBl
bWl0dGVkIGJ5IEtTWjk4OTdSIGNvbGxpZGVzDQo+IHdpdGggS1NaODA4MS4NCj4gDQo+IEFyZSB0
aGVyZSBvdGhlciB3YXlzIHRvIHN1cHBvcnQgdGhpcyBSTUlJIGNvbm5lY3Rpb24gdGhhdCB3ZSB3
YW50IHRvDQo+IGV4cGxvcmU/DQo+IA0KPiBCZXN0IFJlZ2FyZHMsDQo+IA0KPiBFbmd1ZXJyYW5k
IGRlIFJpYmF1Y291cnQNCg==

