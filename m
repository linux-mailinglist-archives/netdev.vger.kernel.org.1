Return-Path: <netdev+bounces-140930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBA29B8AC3
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 06:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4265B212C5
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 05:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5811487E9;
	Fri,  1 Nov 2024 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="JbsC+iuM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1454142623;
	Fri,  1 Nov 2024 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730440221; cv=fail; b=tVONEX6hE7PnbhZ76BNnrLUFYbjg/e/nvPu1LzsDhUiNYqC3SEIq3//VipjRrROjjZeoI74GMp4O+VgWsgseQDP3T7dEmq1fXIrkgEBO0tg7VOoqxSPWDBAa7YXHx2O1kaHLYSEAyCRzG4dIr7255nKSWt9z/rWYFoUstykMIXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730440221; c=relaxed/simple;
	bh=ZPX8wGGO/viy1UjD0k9BM6Ghl8QgCf2ytqaFJMXK3hI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/MP2aZZASecQprU8afXJdQmBbav3JPXn8B5W8v9e3YzsmZPKqxSL3JeZLF3XCg/ASBqfSYQVqy/T8NZb8fT6qC2UzIrxdhiIJsVJ2KPVlH8TgddI5h2rvlQU0wFCQilec5XmLnfm+WBoZdrw0q0CkBM0Jhw/fy0PLMAjOriYJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=JbsC+iuM; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A14UbEt030451;
	Thu, 31 Oct 2024 22:50:09 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42kfwh5q7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 22:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G17CybM6Yzs47cGgs/Wc9V2+/PsdM2GX+ATkMgDWWWhy04GAv1nhbUIAG1ipmrNKKGIDRImwx00FsG95eizRhxlFQA3bGjPuA+VQj5/m+BVTBZ1VKZmIsMFIHq2Ccbusv2x0/hUwhhgpoMMnqLXE2cMj8vRQZLk4JSB+QWS8xACROaEHmNzPYl1n/PUdAwWmYOX744msbN0RSlJoO71MQ+z5CZHTuOUfIynv+j9iYtZe7ZbvQaRyAKyTXxNuC9p5CbtcdcQqumkPgRaOf3RixFFH17Du05lbuXuVZ5eo8xiYGz7L/B5Bb97/JMuUOve4RKdHhrNkV0X86xIelRueKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPX8wGGO/viy1UjD0k9BM6Ghl8QgCf2ytqaFJMXK3hI=;
 b=DVk23WlERk9R1beYZVM4TT60EyrBq2eKN5RpzVM7ZBPf9y1IMWTUkX+0Sw1keRgdY1qcC7Ty1upIu3n8ptKjMOp7UlbyxMXEyFo7IWKlZo4e3uKyRVfWxgAVC/08UTkUyvx/eay4eSiIVKNdFPSjyh1+ocgQV+FgC0H4HfvZp30MwusWvJff7Esj8ogzX+T3wZVUfAZmBiklTG9WIYE8v1GmBHi6avrXcljDWJGyrIS17352nyvINA6GaqghzVYzKWiar3gJdHtMymG4sisPMpDNcoN8dQrCwBCgh/kump8QSY3CvJVX/Tjt+s9eck4SybSGkeW42k+7cUoZEtPRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPX8wGGO/viy1UjD0k9BM6Ghl8QgCf2ytqaFJMXK3hI=;
 b=JbsC+iuMPGBZvHI++XnyCPErlWvKch3D+muWQySVl5By1+ioYHWtfIMHNVz0xD5YBxiqkyHGvi9advkGOYoX+xl2aXieyqOCmgBEtunUpDwPB9udgPld7I0QSubZxNsigetk7GA1/kV557L/VeUhmH+jQhDEmp2PygmP/Lf2Kvk=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by BY1PR18MB5950.namprd18.prod.outlook.com (2603:10b6:a03:4b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 05:50:06 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%7]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 05:50:06 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian <lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        "kalesh-anakkur.purayil@broadcom.com"
	<kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v2 4/6] octeontx2-pf: CN20K mbox REQ/ACK
 implementation for NIC PF
Thread-Topic: [net-next PATCH v2 4/6] octeontx2-pf: CN20K mbox REQ/ACK
 implementation for NIC PF
Thread-Index: AQHbLCHnGUGpHUe38kOcXZcq7CxoJw==
Date: Fri, 1 Nov 2024 05:50:06 +0000
Message-ID:
 <BY3PR18MB47073B021828F4F4C8E38BC7A0562@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20241022185410.4036100-1-saikrishnag@marvell.com>
	<20241022185410.4036100-5-saikrishnag@marvell.com>
 <20241029160657.2a0a2c91@kernel.org>
In-Reply-To: <20241029160657.2a0a2c91@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|BY1PR18MB5950:EE_
x-ms-office365-filtering-correlation-id: 5882a6d6-e319-4a69-a0de-08dcfa390a0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vk9HSGdPNmZVQk9yRWw0ZEV5ZTlML3pPdy8ybDYrRW5iaEhxcXFVU1ZMMExO?=
 =?utf-8?B?QXV4dm00SnVsZjVZRTN0N2tsVFVvYWJNUnlhdDk4anBiWFVQdndzSU5hV1pC?=
 =?utf-8?B?TFFwUjUxK1k1Vy9jbDVweXBqWFQ2cU5jYlNnMElxUEFIWi9uUVg4L0Z2d1c2?=
 =?utf-8?B?bEhqalB6MllhaEhodW4wK2QxdllQTmFmaHU1a1VWNmYzVUZDajZUYUQ5czBs?=
 =?utf-8?B?TnN2REFaK3dQUVJzYk80cXBwSFV5c1llQXNaTkM4VVl3TXErSHhPWFhnU2Mv?=
 =?utf-8?B?czYzeVhPakM3ejRYZ1dKMllvK2l4QUtKMUhNT05mVlVJVFFMSTgwTnFtV01Y?=
 =?utf-8?B?cjdTZ1Nub2c5SU52d0h1L0VSaGU4WHBSeXZxWUV4ZlhKSXpSL3RiU0dsNTJQ?=
 =?utf-8?B?SWdiQVQ4SnRYd1V1SHkyNm56U3AzK1EvQU9IWHR5b2Frbi9qS1paQVVkYnRC?=
 =?utf-8?B?SlNkaUozdExwa25iMWlHQStFZnZ2NzN6WlMwcldueGx3eDdyeWlZS2RFYXNN?=
 =?utf-8?B?YUtMRmlqVjY2RWo2UGdBRytQb3Ixa3RCOGVjS2FxR2R0REVNbEZaeGQ4VmJX?=
 =?utf-8?B?WHJSYjhRanIvZWVCNUx0SkxzU24rYlB6MUZVMDFTckNvOElxZkdhOGw1dVJy?=
 =?utf-8?B?aEJzWGRYT1NHM0VWbnltTEVpSmhUdUh6T2tPYnFEUzRYSXcrdG5hd1FtejJo?=
 =?utf-8?B?VlVTdkdzV0xuT3BSQk50YkhVcHhHQms0eUMxd0Flbkw1aEFndXJHNHpXdnhZ?=
 =?utf-8?B?L0VBcjU1eXpZOUJia29ydDlvWVRVck13ZUtMQnAwL05ZaDQwWFAzaFFMV2Nl?=
 =?utf-8?B?eEk5WjVTUXI0Rlo5dkQyM0FGblVRQWw0em44bmtmdDg3U2g4VFhSWTNldVp1?=
 =?utf-8?B?S0I2cGwzOXRLVnc5N3NiKzFmZlhxai8wbHg0aUxqMDlqZ2M2YlBJR0FxSkZE?=
 =?utf-8?B?TDBpUDhia3I3aWptd0VDWS9BWHA5bHZwcTh0Q3NwSC9UalpMWVZDVmJwbzZu?=
 =?utf-8?B?dDQrUkM5NFNkVEZJdUJTeWE0cnV3aEFkejJ6QSsySnVyTmcrczlQMDVMb21C?=
 =?utf-8?B?Q0xxZVZ4MVZRMFhMaVRDR2pZdGc1SVIxeHZtUURLSFVrdUdjVDZDMGNzQlVI?=
 =?utf-8?B?NVJBOFBHdFYvR1BaaTR2NXYrdksvdkdVcncra2pIZ3lSWW9qVDY2RmNzZzRu?=
 =?utf-8?B?QkRZcDR5S2JGcEh4U0ZHUTV3eVBXZWZTT1cxNEprTDcxYWM0VmdKUGFySHE5?=
 =?utf-8?B?T0xDemRPY2xWbndRT09qR0dhS05XWjlZWW56UzVYaGZwSTAyWkdlNlQrMHN3?=
 =?utf-8?B?VlVMbU1PL2hONHI5ZjQ0V1dSUFBnQTIwNVIzT1VwQTFnaUdNRjZOT3A0WWlO?=
 =?utf-8?B?MlZndmhqczZoY2Y4dVlPSVdoeC81b0o0TCtmcFlVdjZBN3BYcVBubGtBeEd3?=
 =?utf-8?B?SFFlbERhbUN5b1BONTdLbktjSW91cFVTYTdnMGlqZzhMUnFOOXBPVUpERm03?=
 =?utf-8?B?RCtBU1EvQlNteGZGUi9oNmhpTlAvNlp4RUhVWDZuQ3B5Wk5NTXNEczZjWWFX?=
 =?utf-8?B?TVBGQVRuZW4raDJQSnRDR3BBWWJDNkc5cXZWZXVnYW94VGlLV3lxWVVObmdB?=
 =?utf-8?B?Si9xMWlsR3RHcVFOcHBKL2NwaitoSkwweG11MzJDbGxRVjVLREQ4aGNJVmNJ?=
 =?utf-8?B?NTRFbEdqQ0JmQWdxWVc4SFRJK3VmY0hDM0VGeE1iUTc1WDg3dFUwYW1lV29u?=
 =?utf-8?B?alVIcURoR3daUXA5a1d0NGtxaVl1ZE5zL3JIaG93R2U5UkdnSkxiN1FYL2ly?=
 =?utf-8?Q?d1osK78ziMvXDDRu7Q517SmzPROif1YfWzZw4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFVuQkZ5MFo3TEZXNk1OS1ZCSUFZeXpja21IY3JyS1lkK0lEb0dPblZqd3Er?=
 =?utf-8?B?SWloWFlZOThSczNBS09HL1VJeUp2aVFWTnUyMTd4bGl6VHFlc3V4WG9GRkgv?=
 =?utf-8?B?MWZCa2hONWYrWWs5UE5ZM3RMZHc1RGhyeTBwaGdqV1Q1K1VLeWVud3JkaG9O?=
 =?utf-8?B?Q2Ntc0laOFNiOFo1ZnMvWE80SnJ0OXpzeFVZL2d2VlE4SkxzQ2o1RUd1VFRW?=
 =?utf-8?B?SkxGaWNIbEs4SDN4S0F0OGJrb0hqem1kRmJ2SmpBM2xzeEZxVi8ybkNtUHZp?=
 =?utf-8?B?T3NFeFU5RDdkUmlKbk1wNjZ6RE9WZUNINGJXWHZ4Smg5c3ZNOFh0dExyZjlx?=
 =?utf-8?B?ZEFZMEZTQ013WTFhdWpTZDJsTTFzMFJZbjFuWXR2MTdSWnl0Q0lYOGpDWDVl?=
 =?utf-8?B?K3FjRGNrTVgzWXNFQStDMkZRbWxsaDlub2t2WVhEeXUybjlTaVZFbG5VVjB3?=
 =?utf-8?B?MWU5Z004SHdSRnJmd3QyVC9wRXRNTHNsTkhWcVJTVEdLUVRhSWptUUllNEUx?=
 =?utf-8?B?Y1BvSkU0TjUvK2xVcldXZEZBMDRMa1QzSDNtRzVJbkFpYkxpZnBzS1ZzSDA4?=
 =?utf-8?B?dU4vVkxBWDhWelVicURMcHJWRDExeGxNdW1IcUdxWWNabnlJYXg2RGxjVXpM?=
 =?utf-8?B?UHFWMnBZNE4rZlVzaFFqU2FpbFBwNWdPSHFFRDBaTnV0b0c4V0VpZXBQWko3?=
 =?utf-8?B?enMxbWdlMUVvd0NkbUpYbld1Z0tzTW1ySVB6MGFTYkFSdnRaRlB5UnRZQk1F?=
 =?utf-8?B?Z2NOeTVkSzBpQ3RyTTlRSGhkVkJaU3JjRDZSMGVnL1JqcFpHZnV0ajFWK3ZY?=
 =?utf-8?B?Q0VxM1cxUFZqRTVwNjEyUHlFTytGMzRORjZIQ0ZjdTNzbDhhUGlPSmJyMk1S?=
 =?utf-8?B?OG90bTJWTmRDaWd5RDlIQ2FRc3pjaHpOMjdqSkVmVlBKVXBxb2t0R0M5R1ZQ?=
 =?utf-8?B?WnNMNm5EMFZvMklkalYzVWZXRFBRaUgveWN3TzIxYjB2WHdFeisweUhPc3ha?=
 =?utf-8?B?ZkdCTThHRHh2aVBYQ0ovTzE3dFN5NFduR2RGS3dCTHl0bUZQcFh3UTlKa1FV?=
 =?utf-8?B?YzE4SE9TQlNZZ2tPMmhvNTAyd0NLUC8zOHJzbU9pSGJSTUtoeGFRUXc2Y3Iy?=
 =?utf-8?B?N1I0RlVGWFMrY2QwYkJJV1BDd2ZhQVF0L29UbFp2ZWl3NktKK1J3TDVtaGZE?=
 =?utf-8?B?NFBZa1ZMaGlGSTZtNG1oYkVJMHdmbnNiMWhTS0Rmb3g2Vml6UFUrc1R0eXFi?=
 =?utf-8?B?a0hSZnpTZTgyTUJWeFphLy9DYUw0c05tMWpUNjJPNlZadVNzaWN5OUl6S2t2?=
 =?utf-8?B?ckd5c2oxZnJnYmV0ZDRNczFheFNnNUIvb1RsVVZSUVJicU1ucWVOR3A2NGVm?=
 =?utf-8?B?MDFpdHlLNVMycm1yelhJdFdQZnozejR4Z3ZZQnljbTdxYnRzSVRRMnNLK2hZ?=
 =?utf-8?B?cTdMSks0aDFuM3p1dnNBanh6dVBHOGZVTTNOaTdJNjRlWjgvczNFR1Bua3Fy?=
 =?utf-8?B?OTlTQkhQZGFuRWRkVU44Rm5tKzh4bFJKYUNMY1RkZU9ZN01ocllzMTdlM0w5?=
 =?utf-8?B?MGhnekFVTDQvamVaakFHeXpRU3JEalY2QkMvU3VqRFRRWVh5NmdpR3ZIckJ2?=
 =?utf-8?B?KzJKZERVOTdwZG5pQ2Z6R2ZEWDlUbjVLUzFxTkhVMlBNVm9QMEZWM2Rzck00?=
 =?utf-8?B?bUM5aEh2dVpGdnVMd3dodzlIRHBlM2pDVGpwc2gwcUhlVFlPUkllcXBXNU9k?=
 =?utf-8?B?T28zWUxtaFo2ZGl0NHgxTjFuR2JiNC9TRlBSRG1BM25qSk9HSTV4eGVGVm1j?=
 =?utf-8?B?MXFkaDh1Q1c4VVR1UkVjODRKK2l4eFpLL0ZvSHJRNzBnVnpIT2ZGZkZTdlV4?=
 =?utf-8?B?RlpuS1NJMUpHZnQ5bGNrSVlZYXhDWGFSZ3lKZjFrdmRld1ZGbzNnVDZiYXdL?=
 =?utf-8?B?ZjA2MkZKM1Rhb1I1RURudVpJS2RjblJZQ2NmN2RhVFY1dHd1SVl1L3pYdjYw?=
 =?utf-8?B?QjRYZTl5d2w0ZVp0N3d0YUp0Q2NYZmNjQTJWdXh2bTRhV095NG1qSzN4SnRI?=
 =?utf-8?B?NFFEYlo3RTVoOE1kSUZDZWlNSzdCd09CL2VyeXFlNVBVMmZ6Smc4ZkRyVFRa?=
 =?utf-8?Q?O85PNQR66+j0zOSx6yBm+PUjN?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5882a6d6-e319-4a69-a0de-08dcfa390a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 05:50:06.7836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uo1ay71H2LxCLxYF9w+U5bPniICbgtXrIWipaktVvlg9QWlVm5veRxkwoo7oL/aRN/iSnSMUiN2fmoEYmRrJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5950
X-Proofpoint-ORIG-GUID: PuNP60Rqu1jIC6h6fsDsIFKvs18rP7Yf
X-Proofpoint-GUID: PuNP60Rqu1jIC6h6fsDsIFKvs18rP7Yf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMzAsIDIwMjQgNDozNyBB
TQ0KPiBUbzogU2FpIEtyaXNobmEgR2FqdWxhIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCj4g
Q2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IHBhYmVuaUByZWRo
YXQuY29tOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBTdW5pbCBLb3Z2dXJpDQo+IEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsg
R2VldGhhc293amFueWEgQWt1bGENCj4gPGdha3VsYUBtYXJ2ZWxsLmNvbT47IExpbnUgQ2hlcmlh
biA8bGNoZXJpYW5AbWFydmVsbC5jb20+OyBKZXJpbiBKYWNvYg0KPiA8amVyaW5qQG1hcnZlbGwu
Y29tPjsgSGFyaXByYXNhZCBLZWxhbSA8aGtlbGFtQG1hcnZlbGwuY29tPjsgU3ViYmFyYXlhDQo+
IFN1bmRlZXAgQmhhdHRhIDxzYmhhdHRhQG1hcnZlbGwuY29tPjsga2FsZXNoLQ0KPiBhbmFra3Vy
LnB1cmF5aWxAYnJvYWRjb20uY29tDQo+IFN1YmplY3Q6IFJlOiBbbmV0LW5leHQgUEFUQ0ggdjIg
NC82XSBvY3Rlb250eDItcGY6IENOMjBLIG1ib3gNCj4gUkVRL0FDSyBpbXBsZW1lbnRhdGlvbiBm
b3IgTklDIFBGDQo+IA0KPiBPbiBXZWQsIDIzIE9jdCAyMDI0IDAwOuKAijI0OuKAijA4ICswNTMw
IFNhaSBLcmlzaG5hIHdyb3RlOiA+ICsvKiogPiArICogQ04yMGsNCj4gUlZVIFBGIE1CT1ggSW50
ZXJydXB0IFZlY3RvciBFbnVtZXJhdGlvbiA+ICsgKiA+ICsgKiBWZWN0b3JzIDAgLSAzIGFyZQ0K
PiBjb21wYXRpYmxlIHdpdGggcHJlIGNuMjBrIGFuZCBoZW5jZSA+ICsgKiBleGlzdGluZyBtYWNy
b3MgYXJlIGJlaW5nIHJldXNlZC4NCj4gPiArDQo+IE9uIFdlZCwgMjMgT2N0IDIwMjQgMDA6MjQ6
MDggKzA1MzAgU2FpIEtyaXNobmEgd3JvdGU6DQo+ID4gKy8qKg0KPiA+ICsgKiBDTjIwayBSVlUg
UEYgTUJPWCBJbnRlcnJ1cHQgVmVjdG9yIEVudW1lcmF0aW9uDQo+ID4gKyAqDQo+ID4gKyAqIFZl
Y3RvcnMgMCAtIDMgYXJlIGNvbXBhdGlibGUgd2l0aCBwcmUgY24yMGsgYW5kIGhlbmNlDQo+ID4g
KyAqIGV4aXN0aW5nIG1hY3JvcyBhcmUgYmVpbmcgcmV1c2VkLg0KPiA+ICsgKi8NCj4gDQo+IFBs
ZWFzZSBkb24ndCB1c2UgLyoqIHVubGVzcyB0aGUgY29tbWVudCBpcyBpbiBrZXJuZWwtZG9jIGZv
cm1hdC4NCj4gSXQgY2F1c2VzIHdhcm5pbmdzIGZvciBkb2N1bWVudGF0aW9uIGV4dHJhY3RvcnM6
DQoNCkFjaywgIFdpbGwgc3VibWl0IFYzIHBhdGNoIHdpdGggY29ycmVjdGluZyB0aGUgZXJyb3Iu
DQoNCj4gDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9jbjIw
ay9zdHJ1Y3QuaDoxMjogd2FybmluZzogVGhpcw0KPiBjb21tZW50IHN0YXJ0cyB3aXRoICcvKion
LCBidXQgaXNuJ3QgYSBrZXJuZWwtZG9jIGNvbW1lbnQuIFJlZmVyDQo+IERvY3VtZW50YXRpb24v
ZG9jLWd1aWRlL2tlcm5lbC1kb2MucnN0DQo+ICAgKiBDTjIwayBSVlUgUEYgTUJPWCBJbnRlcnJ1
cHQgVmVjdG9yIEVudW1lcmF0aW9uDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29j
dGVvbnR4Mi9hZi9jbjIway9zdHJ1Y3QuaDoxMjogd2FybmluZzoNCj4gbWlzc2luZyBpbml0aWFs
IHNob3J0IGRlc2NyaXB0aW9uIG9uIGxpbmU6DQo+ICAgKiBDTjIwayBSVlUgUEYgTUJPWCBJbnRl
cnJ1cHQgVmVjdG9yIEVudW1lcmF0aW9uDQo+IC0tDQo+IHB3LWJvdDogY3INCg0KVGhhbmtzLA0K
U2FpDQo=

