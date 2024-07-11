Return-Path: <netdev+bounces-110819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4103292E6AF
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DB51C233FA
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693516DEAF;
	Thu, 11 Jul 2024 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="usEEdAnN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F6716DEAD;
	Thu, 11 Jul 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697115; cv=fail; b=JdDIfkNZ0O0zVePcgyNk8OI9SPOQQMOk11K3/D9lDN2NwgPNTl3l1J1ty8F+o5Jx5GIml8sSLmUE7PSlBjpIjc7lsvJ0eTstzQ79xIJ7RoSoWzX+FSHNA4YUaQkW8N+669FEX8VqK7pVAiLCQJ+p24/AxKz2Zxn+dHUmW/pZFHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697115; c=relaxed/simple;
	bh=kcL0oPLw4ZCEerTKTgJVedoK1CiwlVhqDegjHBz+bzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NQZ8/e/jXtIYXcP7Qbk9mB81f7uRFvZHPmqoLReNbWr8JIagAAn0fw4TKtQUdL4tRSRDPoVCgUGf2jCHgwiCKxWQyAPn5VQEEZ28HgQya1rC+YHxF9P/9ktoSg2+B7peaytkcmlfaRyUmXttdR8/y6H84KOCQc17CEkaZq9mp/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=usEEdAnN; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B2UDY2017195;
	Thu, 11 Jul 2024 04:25:06 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 409wmdcc7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 04:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWQgJ8t+BsCRs/gPvwm/aZbS0H0zuhsHkE3v5NIm3FiX03CgL22p/od/kau5qRhF5lBJikZFfAFeeQ0zHWXDb0L4bPdCvfv3BobzWFyJ5cm9dU/lLYXzghB9PrR3np9xUx1VYk2jmv8CtSpAw+GGKsRXQB1Uazz5gIjsn3suSrNHtSIciWNplE/VgFg1DGCL+F25TeSxRlPGV5xoQ9AjqSHYIE+cPjkBnUx8he3j5smsdQiNakNVLZ0u6PQ/u+bys8c1Xz0o4C2UKJGQ9gIrHyGOOgKrD6/hAZ5kYtwgVq7lG3KCwYsTSmovggM4kKp1ePCs8S9eKsAOueJvSnM3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcL0oPLw4ZCEerTKTgJVedoK1CiwlVhqDegjHBz+bzo=;
 b=Nl/7kDvXCuA5Frk+db8UZpmRtzVAcwWdoRwqQFkPc/kB1BRYHVbDdGxDL8UmofBM5kegnN5sKZ5MEi5zxN+5Z8UYPvjo7PgbfHkxM0GmQrAgiqJ7pRXAlAqN8hBizi6+JC5l1kIuQwOIZNLGZN/Rsi5xYCJXiRo9PPwfldnFec0eMkwYKzpwcDc7eQwnVgETxjUchQpBdrlQrv8Im6cEtt6yRkmtC0P4zq/vXR1u8Uw8JhUiIWkq48pSA5CFsO9vUZRHdncHmLf0tQLbZyK2N409IH+28PHQm89Q0hzWfU2qPg35bY48raKnRslLRpTOXWeQKUeUxlVPcOzKRaoQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcL0oPLw4ZCEerTKTgJVedoK1CiwlVhqDegjHBz+bzo=;
 b=usEEdAnNxqc5QoKXg/ck51DqLcA1pdAsF4BPntF9TOE0zZe6HehoeaJcWxx0r5szXqPLulQ2EEjy5iGKDPNBuTqASgkW0/q/gtsanWi8klq+cADt2bliWOedxJsdorESfZ2qsYRt17LJWsUQgDaBH/9unUwx2RLV1ewqQ5S7TU8=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by LV3PR18MB6205.namprd18.prod.outlook.com (2603:10b6:408:27b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 11:25:03 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 11:25:03 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v8 03/11] octeontx2-pf: Create
 representor netdev
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v8 03/11] octeontx2-pf: Create
 representor netdev
Thread-Index: AQHazsRrH0Kj1fJcF0GZtWbGkMdHrLHtxAiAgAOoEWA=
Date: Thu, 11 Jul 2024 11:25:03 +0000
Message-ID: 
 <CH0PR18MB4339535C4E61F8ACA36EDE19CDA52@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240705101618.18415-1-gakula@marvell.com>
	<20240705101618.18415-4-gakula@marvell.com>
 <20240708203337.0e20c444@kernel.org>
In-Reply-To: <20240708203337.0e20c444@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|LV3PR18MB6205:EE_
x-ms-office365-filtering-correlation-id: f336b5d2-455b-4d42-f5eb-08dca19c1bbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UGVYN3JIaG9jbGZ5VlNiQ21kMkJiZUpjYXhHSmxBam02cnlBcEp2R01PZW1Z?=
 =?utf-8?B?VzgzS2pDRkZzNWdJalNCcFI2TmNnQk9abDhzQU53V1RqczZEM0pGZlVlSnFn?=
 =?utf-8?B?QklOeFFlMGRseFRnUXdrVlRXTDRoL21KRUpvWEF3QjBqVVBWRXpuTVJxTS84?=
 =?utf-8?B?eWlIQnlvcnJuZE0wRmRoRVhpUVA5TnBrVlZqWVpHc0prN00yNy92OVloZ1NL?=
 =?utf-8?B?Tk1QVVhYWDZ4cUVxQ1Q3L0YzUWpxU1hhRk9LNmlVZWppMWVYaGE4bFJVUndj?=
 =?utf-8?B?ckFGRzF3c0p6cW0rc0tEaHpOcjV2UXBlWnZpMUVIeFVIS3hBakgvQjFNZEM3?=
 =?utf-8?B?MEZ1Ty9QTUdVM2RyT3hNaVFXbk54YjZCMmt4OWRyK0xXQnozNk5oeStEcXBL?=
 =?utf-8?B?NmJudWpvMUQwZnJNYjdUNVFVRjlvUVJZV1dyU01VSG1WSFZQeFdwMG92LytT?=
 =?utf-8?B?RUhPY3lPeUhDMnpQbHc4VHNTbmdDdk5PZzF2UE1sTDF4OHAxalZUd1ZTY3lJ?=
 =?utf-8?B?TmJxcmV4RmxyaGwyV3ZadFRCWE55ODZ5YmdtckpCTndnZkdWOE03QzJ3TTZG?=
 =?utf-8?B?ckZMczVJOHRLUWV6cHI3VnVzVHNabGQ3V3NkL3FUTEJWYSt6SkNmQWhmdXZ4?=
 =?utf-8?B?ZzF1eXJDQUtwZ2lrSk5WQUlvSEVIYlBHTlNPSERzaHp1ZWIvZHJhVXdGUWZh?=
 =?utf-8?B?ZmFrWExYM3NpZ3lKRHdoUU9WQlNXaFVKUGtIZ2xXd2hHaE5UR2ZycXFVV0Zk?=
 =?utf-8?B?cG5Md3hCSkIyV3FtcHBWUXpVdUNXYnNnaUgwb2hMRXhSVzNNclFUY0dDM0dH?=
 =?utf-8?B?L0RRRUxLS3kyRXB6UW91TWpKWVVqR3VPSlQ0VFVRSUw2OVREblB1N0Y3bEtm?=
 =?utf-8?B?TWR0eWI4ZWFPQ2FTYU1idzZlRDVIazZDMFlLc0grbGxOdjhucUJNVTNEbFJE?=
 =?utf-8?B?VFlJSjVsZENZRjRaNWxSNkVxdmtwenIwVDBRbXIzcXRnUngvNW1la3pzV2Q4?=
 =?utf-8?B?ekVITFdEZG5CT1RnZldTQ29vV1pkM28xR3c1RTU0d0MySTgwRkJEbDFRWUNk?=
 =?utf-8?B?ckdqODkrL3laMGpabDhGc09oQ3ZubmZyaUpnRXVXc0FLOU44Nk4wVmVvaktH?=
 =?utf-8?B?a00zMXAveXVNb3JZL2F3b04xcXhCZTdLNkVrMEJidkhYYjh3d2N2czR6SWhF?=
 =?utf-8?B?ZUFZc2FLR0VnQ0NnVC9sKzNPa1hFKzlYSEVCcXFrQTJyMmNVcmFENEsrTm1n?=
 =?utf-8?B?M3o1enNkbWtzUVZVUjdBWFcvY0V2alV6RUxYUVVGaFJSUU9JdDBkczBFdVJu?=
 =?utf-8?B?My9YS0ZuYUx4YzJPNm0wL1dvZjkzZUxWNFUwck9hdUtYYXZjUDBLSVplU2RX?=
 =?utf-8?B?dFVaT3g4Q3kxSTBuWEZxdGpkYVh3Qm5UdEtHOUVtcnptUlZ3S2k0Sk13ekpP?=
 =?utf-8?B?Nks4eHBqdHkrcC9QOUdVVENEQVozVFhCYnhCbGNYMEtEVS91YityZ1JKQ3I0?=
 =?utf-8?B?cUx4Vk5yMjdkZmkyN1dFMGt4akI4Wm4vUjVqUUg0OVZEWHpvb0JmcmxXdldO?=
 =?utf-8?B?U1pNa25pREgxNmpCV1pwaVpqdnI0QXQ4czRWNnF4Vk5rekF5L3pCeFcrVk1N?=
 =?utf-8?B?cnhZVGlydTFkRUl3M1dmTWpPbC9UZDJBTUErOE9VWGdVanZoOHhhTXZUVUhy?=
 =?utf-8?B?aDliM0RHT2NoUFRFVXJKQjM0amZHYnlUQUFsbi9XQ1ZPaE5ta1lRS1UrbUMw?=
 =?utf-8?B?K0F0L2M1L3g4cWJUSVh4LzFzSlNNeVZudWlqZk5oTm5xRFV3WkVoM0ZMNXVP?=
 =?utf-8?B?SDlxdGR1QUFuQlFMTVRlUllHcndzTlJFRWUzemhUYUJZcjBNVm5Fc1YxQ3lm?=
 =?utf-8?B?UjdUcEY4Nkdpc1RYWUdrajhBOWE5TzV0OElNa1o5bldSYUE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q3FZeGNiRFptN3NweTQ2cWZ5QjNUQ3R5SFZIMWIxeWhkL1QzN0tSSVlITzEy?=
 =?utf-8?B?S3VFcCtZcGh0bjVWMm9HQlVZU2sycTNETXZRdTZuaGN0QjhacThiNjIzRVBF?=
 =?utf-8?B?ZENuMjVNRVRuT3EzWnRqOHl4ek4yTzF3b2ZXRWN0Mk9DQ3FKN3ZES1JxOGFS?=
 =?utf-8?B?VzJ4b0tMVFFGeFhpOG00dEVMbkg1cDZHWVZLWEczdjBoaURZNWhEUHY4RUg1?=
 =?utf-8?B?M29FWUFPU0lkUzM1Q2VhWGdYbW1XUmZOa0lpcHBnT3lKdjA4N0laSUVGRGxk?=
 =?utf-8?B?RFVHUGw5dkExTWo5dTFQYzg2VWxHMitFSTBRTmpianJTUlRaajVPUG9Od3dI?=
 =?utf-8?B?Ty94TmF4R2t6YnR0YVJaaGZWL2NxTHRHVU9BSWdMdHl4aTkzSStCMmRsWTRX?=
 =?utf-8?B?S0k5d2pGa1Z6NVNrK3pldllESTFYMjJVKzE5R1lDb1pOYTNJSG94YnZTMGth?=
 =?utf-8?B?dlc2RkdNNTB5YVpmOWxld2tZUTZJc0tRbVRlbXF2VCtWV0J3UmNKbFhYcnE2?=
 =?utf-8?B?UkJhUmFiYkx3ZXpub3ZWbU5Yb09JODRvbmJ1TDVkYVErdlJWYVBMM2R3SUVv?=
 =?utf-8?B?STdZY204dDZrTWhUM2JnbXZPQWF6U1ptV2svL3JqRTNqZ2g0eTFPQk04Y2c5?=
 =?utf-8?B?MzF2WDY5bHlWUWVxMExtTWdKYVl4Y2h3bndJL1BMWFdIWmZkWG02YlJnSURn?=
 =?utf-8?B?VkVqbzNnMU9SQlBRNDZpYm1pVkhDeXFxOWFNZ0ZYZjdRMlZDYmJkemRrcmMv?=
 =?utf-8?B?WlpHTkdKa2JhNTJpSnppb2crNGtGNjN4UDd2dFl6MmUyVmtIN1NwcWJsa1g5?=
 =?utf-8?B?Tmp2eFJ6alBPRmlja3ZsdkFMbWFrOWZxZUdMVXhHcUpTbEo1Ujl4Sm1hRnpy?=
 =?utf-8?B?ZzQvZ1haV29MQ1h6WFQ0TjIxcXBtTklGcWZuejdEQXpJOUpzdXM3WEt5VDkz?=
 =?utf-8?B?Y3BmY1BBeTZwYTRXeDhJQkMrZ2dxYjJET0MycnR1MU81TytVNGhyQnRVRmc0?=
 =?utf-8?B?S3JhaHBQYkVNK2RqY29HV0NybTZSNzlDNXpiZmplVzVjcU9qUFFCWUt1cGZj?=
 =?utf-8?B?WWNxRGtvTUdPcDVBQWw3UlQ0cjBXRXY1TC9abjJBL21CRVZXWUxKQkxMWHFy?=
 =?utf-8?B?YVNiaml4NHVLVU1zd2lYbFpFeEMxUkxvQis3cStQTExiM0JyQ3NlWFllM1d0?=
 =?utf-8?B?a0xJL0FRSEZ0bjh4NisxbndGUjYyTjFkSVNBays0UzZGNFlkaDVRZEhYbzJ1?=
 =?utf-8?B?bXVPRDBaUEVEdjV6M0NPRStVOWVnVFdXV1VMMm91ZEh3SGhCdldEOXk1djVN?=
 =?utf-8?B?WFE2MzdFMXhxRTluUXJka2hEdVk1dGkyZVZNK1p4SHVwelFQSE9BSkxiVjRF?=
 =?utf-8?B?RHdhMHZMdkJIMEc5QitrNjJRZEpwaFBLVUtNaEhqRGhIRTA4KzBFbkgvbXZ2?=
 =?utf-8?B?SjBDVmY4NTJNUlVrRHNzbDBBRWRHQUhnUk1URk9ac2dJNzZLbGdYQThFd09n?=
 =?utf-8?B?ZEZyMy9iT05HQ3JJL3grOExac2ZqS1U5TDNneXk2TDZOU2V2NDQ0b0RsaU5t?=
 =?utf-8?B?KytpelZzUUVGeHZUdHFFTmxDb25OLzJCVVlXL0VVUFQwcFdTL2o5cG1BSDYy?=
 =?utf-8?B?a2x5S1Y4Q1p6blQ0ZUlwV3l0T0p5eGFPY0ZhbVFQNU50ek9JZXJEUldyKzB1?=
 =?utf-8?B?VVg5cjdEbThDOTlPdERmTlMvSXlYdFhmRzhwQzBQRlh5VUw3b3ZvdnNwalRW?=
 =?utf-8?B?M2RkeEhIZlV4R3VJT2NiR0xhN3BkTFdrclg4NkFyR0dOS1pPRnpvODZOeGVV?=
 =?utf-8?B?NDhQMkMxdW5hQXhaNnBxclpBTW0xTExTNE5WdEpvSmlzZHEyUDNOWlJKMEti?=
 =?utf-8?B?MmtoR1BYRUlUaWpQRnViU3kvMzIvMi9JSTlJSVBZekJMbHdXNEZJSzV4c1RZ?=
 =?utf-8?B?bThGRWc4TU1NZ2xDUG5SdGU3N0dqL0hlTmFEbzAzWTJ0TnRUUWpjMUdiK0xI?=
 =?utf-8?B?WlhMMDhNT0kyUTNPbGhYRFVmUDhBa1pzOTJlQnBlQmNSSjIzZWxLbjN5dWlo?=
 =?utf-8?B?dXM4S0RqWTR4VjAzNzh3WnZkdUxyZ2JTV000YURjR1c5K2UxWTVnaDVpTDM5?=
 =?utf-8?B?aVRCdVdVMVdDWVlKYzdmTjBZQXpMaW00MmQ0MXRuRzBCdzBmUXA0S0xNZHds?=
 =?utf-8?Q?oi99KGW0MOh96jSMZv9zJnw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f336b5d2-455b-4d42-f5eb-08dca19c1bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 11:25:03.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zcLMHxffUxF+xjnvdWtQTthzAS49w3DuIjcoRNqNTa0z3lVox59Z8aXxyHGgKjEtQyQTrteckJ0VtCQ00B09Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6205
X-Proofpoint-GUID: 4W7sd_R1CXNzO7p0nbFS--bk0ZJSfciR
X-Proofpoint-ORIG-GUID: 4W7sd_R1CXNzO7p0nbFS--bk0ZJSfciR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_06,2024-07-11_01,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+DQo+U2VudDogVHVlc2RheSwgSnVseSA5LCAyMDI0IDk6MDQgQU0NCj5U
bzogR2VldGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj5DYzogbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj5kYXZlbUBk
YXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgU3Vu
aWwNCj5Lb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgU3ViYmFyYXlhIFN1
bmRlZXAgQmhhdHRhDQo+PHNiaGF0dGFAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtIDxo
a2VsYW1AbWFydmVsbC5jb20+DQo+U3ViamVjdDogW0VYVEVSTkFMXSBSZTogW25ldC1uZXh0IFBB
VENIIHY4IDAzLzExXSBvY3Rlb250eDItcGY6IENyZWF0ZQ0KPnJlcHJlc2VudG9yIG5ldGRldg0K
Pg0KPk9uIEZyaSwgNSBKdWwgMjAyNCAxNTo0NjoxMCArMDUzMCBHZWV0aGEgc293amFueWEgd3Jv
dGU6DQo+PiAgLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyLnJzdCAgICAgICAgICAgIHwg
IDQ5ICsrKysrKw0KPg0KPllvdXIgZG9jdW1lbnRhdGlvbiBpcyBpbnN1ZmZpY2llbnQuDQpXaWxs
IGFkZCBtb3JlIGRldGFpbHMgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpHZWV0aGEuDQo+
LS0NCj5wdy1ib3Q6IGNyDQo=

