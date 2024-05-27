Return-Path: <netdev+bounces-98179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577938CFF38
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 13:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE83EB223FC
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85DA15DBDD;
	Mon, 27 May 2024 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XA5Fxjwa";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lBbPhLeZ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3202715DBB9;
	Mon, 27 May 2024 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810182; cv=fail; b=Xui0dAxGyriVKdb/R5MgaFPdF7WH58bcNFaX/d1aU9/TuLrs8qGGnyCP66SwOaTxlesQtDh1noY/5xrepC6EfXPhin6GM3ada+dSdOHNb/MltYYl1IttgpeAcrndb4aMJyIp5RiEI8ZkUrztZL68JXlKcY2Wy+aNOT5XdAc0PP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810182; c=relaxed/simple;
	bh=zgGgPJ/nYMZMxqKD3rGx+eiufC+G1h7xzmu1YqCp8Ow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Npt7GcyS8fEoVRWNxdYItZjvdXRC2hbegWnFKkBvPpbHxdsjjpw8aKJ1tr1jZcle7j20gaZKa1x1NTSPuldadeRv8MpVhHH7G7r2eOH9gO3arSG+2oD2Ab4VYbpCOjl3mWAQd8UquESxfmgMjNgxcEMdURiH/WR6tx7tsdWiwx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XA5Fxjwa; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lBbPhLeZ; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716810180; x=1748346180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zgGgPJ/nYMZMxqKD3rGx+eiufC+G1h7xzmu1YqCp8Ow=;
  b=XA5FxjwaZDmxgitUhpLDmCnNDsYt78G6WdO49OllFev2ttsceJwUMsXj
   yK4sEHVDG9CAlu9C8C1f6A4q2lso6+feFXVRnvJ2a9ROCSsPMzaCU57BF
   xe3haFPUgD3gAcifbK0xWyUwRNIY51WxMd6HeLgg0VqbEe9N3kCnDkIut
   838taTQOYeVoHwPZKMgy+r3Afk96/ZbjTPbjTJdUrrupiUBY+klfw2a2f
   bdokxwqeu4OmJfWgG5OzIpWm73G3tVU0buMrbnlIfSegrLT7MgpEHkqNv
   9UyCKgnb7quyepvqk3YNyc/rk2u6G2P+x0j+X5/CaQFwH3XhkZjV5/lk1
   w==;
X-CSE-ConnectionGUID: 0kwzTLCjQ56MWYVd4DvJTA==
X-CSE-MsgGUID: osVXv0BHRiWetXLBNBkP2A==
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="193785023"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2024 04:42:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 May 2024 04:42:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 27 May 2024 04:42:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9YLC9Tz4/Y5KShg0ayY0677GeRR75TmVdPdzyaLcq55R51I1TiQ6r6/CAp6k8q9NamWTFtp7HW8nesd7v0F6pHTBe/gnCEELeRSGypbGnKtTGMLrZM37Ulg3UuQwu3Evmd7DgDIto52tFF4P/3/bU9tYj98eWf7CJTU9P2yHgMMBKv3gHpJwd58CiI/7hacF1pNv5rPsghstBmtxlbDckq7DhiYd1JTqNAld8RLr2awRV5GdWdil+S08IDOxcsweAzS5KsMu3DsuiQFdLGrwDuBAlJ+Qj/husQGsuqE4CNWjqhSI24UTNbdRmd6w0QK6pOspGlNWazZjqjNMl6xng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgGgPJ/nYMZMxqKD3rGx+eiufC+G1h7xzmu1YqCp8Ow=;
 b=ROw3aQztJpRyw1tDxHT0tsnv0aJ7XOXkingmD9uggWiQUaFjGBA+MaQsrOJEXAuLY2XAWmNf4IMbnFIFHH711kop69zHCTSN3ivTtF4c9JYhuXzlYElsgHCChuh64iYwlFLNNAnf5bfUGdVTbKSELRD9rRcjs4Cc2EbK2P4vVB+TFBo+EymWzqOYoHmeAcitQ99PBoT8+R3Qday5KU8uVRDRHXQt7NvD7HhX5T48KJkroiRdumDPEFBFlVEuj2nG9CAFHBcX2YkQ0WYrzys8fL+QqYSLx7E6Z3fgxX5cFS9N53GMbFazLJiOgAel5QZBjlvq5noMFX/v4tR5hYJmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgGgPJ/nYMZMxqKD3rGx+eiufC+G1h7xzmu1YqCp8Ow=;
 b=lBbPhLeZyWle4kpAJxACaoAU13z8S2WHy5UAVuWnve30q3pWOR2pqI6uNYfItaj9VuPv5hH7aKzwFWQXAj9IO3hqE4bYYR0kCJIuu48NmUcqa3qpy1ckylg20Afx0Oe569WUOCVHdBKUT0gxohrYJa0Szzq3Ee6JK500Ijypwx4FWylkhoaLpHZ923A4/suMODSUEu8E1EYOLS3STSAypoc5fZAfLPUZ5UbPmqbyG9pdg5TWKYq3HVieNwQXegOVpKo9YyTxdmn9vQpOvBldoR5RHyRA/OLnCDNJaPwX4X7uPh9J5I5SaZP7v/AnETbFvAAcO7rbRFA9i8TO1Nqfsw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 11:42:45 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Mon, 27 May 2024
 11:42:45 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <oneukum@suse.com>, <steve.glendinning@shawell.net>,
	<UNGLinuxDriver@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Thread-Topic: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Thread-Index: AQHarFGdKs4gtKjRMUij/lf1SheVtbGqxwCAgAA2TQA=
Date: Mon, 27 May 2024 11:42:45 +0000
Message-ID: <677474fd-746c-4b27-a65e-3bff6daa0b01@microchip.com>
References: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
 <a6c93527-fc78-4182-9341-97e2fe0d1ace@suse.com>
In-Reply-To: <a6c93527-fc78-4182-9341-97e2fe0d1ace@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CH3PR11MB7177:EE_
x-ms-office365-filtering-correlation-id: 3b3fa231-66f3-4518-067b-08dc7e42202a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cFFIQXdCQkJKQlZkbjl4ZVhVMWZUWGNscnZBeGNYYzYzNlFLZTQ4Z21YOUIz?=
 =?utf-8?B?VUxUcXNkdXMrREVjd3AvT2t3N2w1TnRvRzhpSVQ2azhmKzZ5dTdWdkFmZlRv?=
 =?utf-8?B?aU5BM1VwSXJZKytkb0k5ZDZoTWhXeXl5aCtyMG9GZDFCNVJPOUlNS3M4aDNC?=
 =?utf-8?B?c2pTK3c4UlE4aWpsVmc3bVErNlFGV0h6TklwalRqb3E4ZlNvWWROZHJySndK?=
 =?utf-8?B?VGd3czlaVzJWQUc0c0Iyc01sQlMvNnZ2K1pteEMwUE1aRjlzcEhHYmhaTG92?=
 =?utf-8?B?YnlyWFVRNWljdWphaUg3b2dROVo1OFE0OEdqeDYzZW5uRS9LOXc1M0FzOFZ1?=
 =?utf-8?B?aUhBZDRlbzdOZHBqNlFWRzlWT3dMQnNhTkl4SVlUWmd3Mmx1NHM0d0hpZEds?=
 =?utf-8?B?NHJLMU1sQkpMKzBXdTA1bFVwWUNZNU1hRGNSWEUwWCtLQzhZOFUyYjVhQ1hP?=
 =?utf-8?B?S0lZVFRCMjd6am84UkYrcGhLMGZibUJHYXlLRmw5M2RzRW9WSUZ0eHpDUnBw?=
 =?utf-8?B?aExpaDFXZ0hyaVZCMW1KdnhTTitEQ2ZpSU5GWUxiOGwwUk4xVlFMcHZEcE9q?=
 =?utf-8?B?bkZMMnVWR2c5dFpHTTRNSWxKcVJ1Wk9uN1FieUhST1hVVXlTZW15SURZWjBB?=
 =?utf-8?B?b1VKaGpoQ2txbjBDNUNnVVBuUzhwbzI3dXBqNUliaEM5OWtPWHV6RGJrVVZs?=
 =?utf-8?B?OGtLcUJYQWxWQm5QV1ZtM1lwekJFcHRwQVh6eXBYYTJUT0VxMC9xd1l5OHNX?=
 =?utf-8?B?QTZSTVBKekJtV3ptTEpseU5GMkZuRWJZU3dzTk9kYnNFSWlDZjMrRlpMV3pq?=
 =?utf-8?B?ejZaSEpMVmdzMWVYZkV4RTA5cHBVL1ZBeFgvd2xQV2paNWZGcGhLUWtnRXJF?=
 =?utf-8?B?K0JqWmwydWxNUVZHTE5oUXpKbDZ2ZWtRdU5OUGR6VGtVdUtjSW1WRmR1cDYv?=
 =?utf-8?B?RHpNczdZbmJGSGpoOUZMeStJczNrczlIUnRVT29GaW4zTmUvTi9HYWFOaFdi?=
 =?utf-8?B?VGNDRHl0bFowUlFEMVQybEQvKzVqR3VlTm50TW9UVWRvbDhsWmVlUUl6SldM?=
 =?utf-8?B?M09TRDlmZDg2RFNmYTdwWloyUkRaMnpnelBSTzNBVndsZS9rWkEwTldvZnkv?=
 =?utf-8?B?WjU1NnRkM2xLYzRxZVZpU3ZCcjRjQXE4OHRwcGVFRTFkalJySjNyazQvSEFJ?=
 =?utf-8?B?Zm9YaG0zdTZHTWdacXowYWZHOUZyVmtXZVFHT1RCakgzZlhoYkpya3F0Undq?=
 =?utf-8?B?dUhFa2VrWnhRVDYvVGNveFNqbGI3RVovK3ZxVGtia01mQkllL20xRVVGaHV6?=
 =?utf-8?B?NTJMWEM1ei93V0FLZThpNE9tcG1xaWh3a3ZidHdrTnBOZFhmbnRFVm93T3Bk?=
 =?utf-8?B?cFZrNi9FRHAxbEZabW1SWHhMbXZqNXhLYjY3V050dURXeXlKSkVybU1WQ3lB?=
 =?utf-8?B?YXJZWjd0bm1PZEtvMWZMWEFOMTdmZnFrQU1MNmhPZUpSZy9LamJoVUwvM3Fn?=
 =?utf-8?B?TkVyN1IxNE5RR240RWJyRThFenBabFZ5R0U4TVN0bHlYaXVhbDlkUnc2ZUJi?=
 =?utf-8?B?MGdTeWdwTGVMQzJxUWxjc3NNN1M0SktYeC9NQzIzN1kwa0ZEL2tTYndyYUV3?=
 =?utf-8?B?UzZ5QVJXOE9PODVVQWx5YnlYbno0TzJSN2dUQ2ZSZ0VxekZLUW5XaC9Ceno3?=
 =?utf-8?B?eXZlSTlKS1MrRENkZUU3cVkzTXJ5ZjhCV0hpbXZ5dys4cG9EQWxvTzlKbW5i?=
 =?utf-8?Q?5NnyC4AdydSK9uBbwM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alZtNWExTG1sS2Z3TXlPbHNoanUySC8wMWFiYXNyL2NMYVM3d0VZMGEwUm95?=
 =?utf-8?B?M3VHdmZlWnVtdC9YL3VvK0xCS0JqRmRzWnRCTGNZemFMS1B2bVAxNitDSWVh?=
 =?utf-8?B?OHQ5ZEw0aWlNeHEzdlB4QmhBRUtVdG5iUjlVV2tyNG5jRDM5dEh4OWRsVXZa?=
 =?utf-8?B?Z1hRTlNGUTJyNkxpbnZmblF0VkhJbTJFN0JYcDlRVTdIZzFLbnRmT3pyeEli?=
 =?utf-8?B?TEQ1N1RiNlcwOUU0MkZEQ0JCMFNsbm41bjVxRDJMNjJHV1lyWWQ3UythbVNB?=
 =?utf-8?B?SCtsbHFxRHZ3NkRVVHRGSCtGMDJVbHE2dzk3NFRoSlU1MEI1eTQ4a3piVXFl?=
 =?utf-8?B?aXhDa1J4ODRvVWltODByRTA5ZXVnSEVwMzR6M0dFZ0VqeklkNldvaW81dVR4?=
 =?utf-8?B?N3N5NXF1WlpjOHJoQjVCbDY4MGpUZE9oS3o4L1F2d3l6Y3hMYXplUm8xZXZO?=
 =?utf-8?B?djZHM2JMdWxUWjAwUVhNZGxMb1NkNWIxVWhPZVd1M0hNNTkraVlFQ08rQkxk?=
 =?utf-8?B?K2p4TjRGNTNRVTR0UEd1UXJpUTdyaFBsTzBGVUFyNlZub25oRUdJZndUQXAv?=
 =?utf-8?B?NXdKUTNuWVFKQjdjS2dsakVjUzV4OHprZ0hFRkJpQmlhSVdNNnh0RkpjcWl5?=
 =?utf-8?B?eG9ZTGhvckhZT3B2NmY3dG5ZNVY1OEQ2bDc1djd3T3E0OTFPS2ozN0pGTG5w?=
 =?utf-8?B?dlgydDRxNkhTT3pPMXFuYzFMQUw2M2xOUFhleE1mOWltSWZOTU12a0xCdFFM?=
 =?utf-8?B?NDBEb3B0V2RZT1dEYnhvZWgxemNGM0g1Tmo0TnIwUzcrQWhhYW9ManlzenJ5?=
 =?utf-8?B?VEU1dGtoYWtDaklteWpIekJHWjBDQlNJT1d0UXZJVVNOank5K0dqVDFpaGh1?=
 =?utf-8?B?Sk9HOUZUZlFXc3FSVWxqZnRnTXU2RlRqRGpleVNVcUF1alB4ZlloajRHM0xt?=
 =?utf-8?B?WURUbXlIRERwdmVlZzFYVG5FZ25KdVpKMlRDWXZlZFN1MVo5NTZLSmp2WXNq?=
 =?utf-8?B?WThUT053TENtdHNMVmhvNnpSL3l2ZkFkcVlFRC9hYjBSalJVLy9hSzBCM3ly?=
 =?utf-8?B?QW5oQ1JBNEtMVmtKS2xxOUpMR28zU3VKL1RBOU85eVBYZXRuaEZ5ajhZWnVS?=
 =?utf-8?B?QjhlS3pnSkthc2hNM1JEQTdkODMyMURIaktkUE9mNFl3KzU2NmVQM0JUUUZT?=
 =?utf-8?B?WFc4RjVyeWF6L2FDOFdoY0pneDY0bFB4d0VGVXVZZFpMZ2ZjVkVCV1Q0eVAw?=
 =?utf-8?B?VXp3Q2ZWTWc1Wm5JM1B0S2Nad1pWNmcvMnd2dFVibDhPTko2TlBZMmUvdFJj?=
 =?utf-8?B?TXhhTVVkZEhuMy9EMGR1NHNKcTd2eXdyVHFuN2ZaRUs4RTZic2tFbURFMi9q?=
 =?utf-8?B?UWFZS2F2YUdMZnlpRjhTK01TeENocDdGNDlEUyszZFpZWWxwTkJGTWcvU2Ey?=
 =?utf-8?B?V2I3aUI5MkVjZHdoYW9OSWRleEVIaHpuVlNCaFNKcXFQMVc4bThsMWZMd3Y4?=
 =?utf-8?B?ZEtjd0hqUnpEUzU0NEZxWTMwSHhHWGdGR3RnRHVnNjI2MEM4SlVqS2dXOG56?=
 =?utf-8?B?VjdFcVVReTlZbGxHRjdvUE5kVWNuRFJra0NRaGF3Z1N4RC96cUdUekxRdjRs?=
 =?utf-8?B?dldZbVptRWw0TnVvL21wRS9zV2V3NGk0amtzN3EwWmQ4emViUWxzZ0dQUENZ?=
 =?utf-8?B?YXEzVjhDNmo2ZS9BUDlGN2ZCNjVwL0oybDkxMHNWekwyQi8xQkZoZEZ6OEhI?=
 =?utf-8?B?YVlXSmw4VERreDQyTExQdjRic2h2TVRiTlJ4V2o3bzVzQ0NiZW94VmlNRFBx?=
 =?utf-8?B?ZldCcWt1d09zV0paVGdqNzhZMTFxMVZLeVh4b0M4V3F1TDlFNmN4clFFMEht?=
 =?utf-8?B?bkRTbk1DdEpTL2t1SkNPVWh2UkRKc0UyQnZBV3VYQjZYalE2eEhpS3NTMEJ1?=
 =?utf-8?B?NGJXc2JtbzBCRU9EVURFN1RFV3hvUFlqV2ZLSVJVWklyUCtmOE8xTThINDZS?=
 =?utf-8?B?WDZSaDZFRSs0OWkrem5ONFFUbndROTBuZFBOOXRzcXJ5MllVVDZZK2V6ZGRG?=
 =?utf-8?B?R0xTWU0zWDlFdXpRR3ArVi9mUFFRSGhBY21WeTdnUEpEQWJvZUVQNmRxLzZK?=
 =?utf-8?B?TnhEOTRZa1FkRWdFRitrVG0rZWR5eUhCOTQ5RkhoNlI2bHM2dUs4aU9nRzIv?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <099C419B3B21BD4882906934914A4863@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3fa231-66f3-4518-067b-08dc7e42202a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 11:42:45.1987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xw1jjtlFC2VqnAVOef8pw0Dn+NCUQ5MA2pHfoCeC1sBP27VFgjKHWM3uNWtE47F1+r+hKSxH9lV13LLvbeexZNtsbLUv+Dt8Nus+rWnZzlUnwGdBowD/VtzN0eEOod0v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7177

SGkgT2xpdmVyLA0KDQpPbiAyNy8wNS8yNCAxOjU4IHBtLCBPbGl2ZXIgTmV1a3VtIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IA0KPiB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyMi4wNS4y
NCAxNjowOCwgUGFydGhpYmFuIFZlZXJhc29vcmFuIHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiBo
b3dldmVyIHlvdSBzb2x2ZSB0aGlzLCB0aGUgZGVzY3JpcHRvcnMgYXJlIHN0b3JlZCBpbiB3aXJl
IG9yZGVyLg0KPiANCj4+ICvCoMKgwqDCoCBpZiAoZGV2LT51ZGV2LT5kZXNjcmlwdG9yLmlkVmVu
ZG9yID09IDB4MTg0RiAmJg0KPj4gK8KgwqDCoMKgwqDCoMKgwqAgZGV2LT51ZGV2LT5kZXNjcmlw
dG9yLmlkUHJvZHVjdCA9PSAweDAwNTEpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdy
aXRlX2J1ZiB8PSBMRURfR1BJT19DRkdfTEVEX1NFTDsNCj4gDQo+IFRoaXMgbmVlZHMgdG8gYmUN
Cj4gDQo+IGlmIChkZXYtPnVkZXYtPmRlc2NyaXB0b3IuaWRWZW5kb3IgPT0gY3B1X3RvX2xlMTYo
MHgxODRGKSAmJg0KPiAgwqDCoMKgwqDCoMKgIGRldi0+dWRldi0+ZGVzY3JpcHRvci5pZFByb2R1
Y3QgPT0gY3B1X3RvX2xlMTYoMHgwMDUxKSkNCj4gDQo+ICDCoMKgwqDCoMKgwqAgSFRIDQo+ICDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9saXZlcg0KVGhhbmtzIGZvciByZXZpZXdpbmcg
dGhlIHBhdGNoLiBUaGlzIG9uZSB3YXMgYWxyZWFkeSBwb2ludGVkIG91dCBieSANClNpbW9uIEhv
cm1hbiBhbmQga2VybmVsIHRlc3Qgcm9ib3QuIEkgYWdyZWVkIHRoYXQgYnV0IHVuZm9ydHVuYXRl
bHkgDQp0aGVyZSB3YXMgYW4gYW5vdGhlciBwcm9wb3NhbCBieSBXb29qdW5nIHdpdGggRUVQUk9N
LiBTbyBJIGFza2VkIHRvIA0KZGlzY2FyZCB0aGlzIHBhdGNoIHByb2NlZWRpbmcgZnVydGhlciBh
bmQgc2VudCBvdXQgYW5vdGhlciBmaXggcGF0Y2ggZm9yIA0Kc3VwcG9ydGluZyB3aXRoIFdvb2p1
bmcncyBFRVBST00gcHJvcG9zYWwuDQoNCk15IHJlcXVlc3QgdG8gZGlzY2FyZCB0aGlzIHBhdGNo
Og0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9uZXRkZXYvM2UyYjJiMTgtNGRkOS00YjIyLTk2OTAtMDFlMWJkZDQ0ODI4QG1pY3JvY2hp
cC5jb20vDQoNCk15IHJlcXVlc3QgdG8gcmV2aWV3IHRoZSBvdGhlci9uZXcgcGF0Y2g6DQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbmV0ZGV2LzIwMjQwNTIzMDg1MzE0LjE2NzY1MC0xLVBhcnRoaWJhbi5WZWVyYXNvb3Jh
bkBtaWNyb2NoaXAuY29tLw0KDQpUaGUgYWJvdmUgcGF0Y2ggaGFzIGJlZW4gYWxyZWFkeSByZXZp
ZXdlZCBieSBib3RoIFdvb2p1bmcgYW5kIFNpbW9uOg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL25ldGRldi8yMDI0MDUyMzE0NDA1Ni5HTzg4MzcyMkBrZXJuZWwub3JnLw0K
DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvQkwwUFIxMU1CMjkxM0NFODFBRkMwOEYy
RDYxOUMzQjZDRTdGNDJAQkwwUFIxMU1CMjkxMy5uYW1wcmQxMS5wcm9kLm91dGxvb2suY29tLw0K
DQpIb3BlIHRoaXMgY2xhcmlmaWVzLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0K

