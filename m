Return-Path: <netdev+bounces-143684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7039C39DB
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 09:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8AA282271
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 08:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AA516CD1D;
	Mon, 11 Nov 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Otgn6DCg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDAD16DC0E;
	Mon, 11 Nov 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314554; cv=fail; b=BYdN60UAeV1P5J3Rxja1CM6WBZWUxyjtkUMhc8cDW24lsoGgRgZxBI2wuJPErM3YbXX+VC+qyGRcG0gfq1wLy1stDcnvlL166+k7/MywjeHqOKYjzTfEUKGZNY5jBeVePOY0iLoteFFz1Owf6Opw9zjIK0ot4L07jNewFzJksZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314554; c=relaxed/simple;
	bh=bvoKACIyR31Af7q/XXSKGa9GwlFZsGBDeKy4YOS0HWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VXas5ew8gM9OcGx+W82XmcynVX+5OhK41cMmjeLEZLD3UEphnosnWArUlhcg0w80x4gCIM8Ik05/KshKBOfdYFSjHLp0CosAHia/CpM0rEz1mE45H8at4CVkDsv19587oCignXcx/idwYHXNHZPuzint3OlXkNqY0aHAlYVOobY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Otgn6DCg; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAM2QGo020174;
	Mon, 11 Nov 2024 00:42:24 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42tvvc1awx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 00:42:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXaUXMNXDLMwhtnf5dDdNBEFE31Xae16oPioDRapaFResb+QxCQzHIuDxVa/4ht8Rcqmt6yoHbJrrkkf7AQp6WcDFnNlWxIyyB9lPQ8OEs0g4FLwPziHY6g1mcwUxqRWiGJRUmNLNjIm/mP/U6SvILq648vHkrXwm024eTTfZYG6hyiA0lSK59IE6vektPloNNsRklU4dz6c9+NkcffSmSU6vIysorYHFUEAeF+ULY1977ixsxdQNiw4YKpd1KCZLQqh+gRmNaydoGPoP6vDUnjBVwDNnyzr0BVxnTsQzWrGfTlmFI/N5IzBY74Ux3+pBJpzzaup7lEbYW0y+Vq20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvoKACIyR31Af7q/XXSKGa9GwlFZsGBDeKy4YOS0HWI=;
 b=Rmy3xGWKvAMSd6lY67VtW8YTmQxFdXPaq/2zvIPXeJwUSJ0lSI4Fuh5LSazkDizB5Gppyuztwi12FK+EUY7btQJbFlpTCA1UaUdd9oEV6D0a3iF/SBb5PldA8aVLWxt+En8QOVxqJp6W1Mwqw88TByYjeutVXhgAKigHs5oqoZ02mqjnvh3lowl0XMSD7UhkX0Urp/Kw7VNtrsxMs55M4dH/H7GPsCE++jbu5bpWhyt8axeBH8w15UNOBBN5o1q65G23f9WaS65Y8qcHivrb1AhxDUpgBQhhFqM1fVtfvzuvXw7e6NtLDBYxKtwPBwQ9py9D5eEGjpjXMWiupqRqNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvoKACIyR31Af7q/XXSKGa9GwlFZsGBDeKy4YOS0HWI=;
 b=Otgn6DCgJlncODUg+w2zTt33Qrp/rTtp5o8V3wcshpGGU+rb7d+vnwlXAktrtrQTKjdMcs6yf/uNidB49iXijC4BNH6GqGpg/60OWJ8eJ/+FsI06lMRYTpLhdHTiLZAu4hYsU9ZYrvIJXYE+Ke9beIx/m4VmLxZq8gMqhJZa1Jo=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by SN7PR18MB3901.namprd18.prod.outlook.com (2603:10b6:806:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 08:42:21 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%5]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 08:42:21 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v2 3/6] octeontx2-af: CN20k mbox to support AF
 REQ/ACK functionality
Thread-Topic: [net-next PATCH v2 3/6] octeontx2-af: CN20k mbox to support AF
 REQ/ACK functionality
Thread-Index: AQHbNBWfJ4JD2xK6P0y0T6RucbX0NQ==
Date: Mon, 11 Nov 2024 08:42:20 +0000
Message-ID:
 <BY3PR18MB4707779CBE1065D62246F490A0582@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20241022185410.4036100-1-saikrishnag@marvell.com>
 <20241022185410.4036100-4-saikrishnag@marvell.com>
 <20241101101848.GD1838431@kernel.org>
In-Reply-To: <20241101101848.GD1838431@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|SN7PR18MB3901:EE_
x-ms-office365-filtering-correlation-id: 8740abaf-222b-44fd-184c-08dd022cc1d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkhXZUwrS2xxbU5HbGovWFdZNUI2UmVoMnhaMGFrUTR5WHN6UnZIY2p5NDlD?=
 =?utf-8?B?YW91T2NLRzg4eVo4cFhIZXcxOXlTaStmL2JIY2FMSUUvd3lac1oyVDd1ZUZE?=
 =?utf-8?B?MHFnNUtieE4zcHpvWmRlbU9Tb1NZVFNpTjMzekJWVHN1NjVUcEY4dVQxWkVh?=
 =?utf-8?B?ZThSSm1SWEhuZUtGZUIvazYvWmhlRWNaNnNsTnQ4SmxnMjJlSllCbnJqWjZM?=
 =?utf-8?B?c2ozWHdmRjF2Z1I1NTRzejRnb3BYNGhZZTI3QTFNd0hja0ZsL3VEeVVzUkxD?=
 =?utf-8?B?THRUM0RQRFpaV3FkWDA5MFF1MVQ1eVdQcE5GWHl5a2FmS2tQL0VJUExFemFj?=
 =?utf-8?B?RDhPRDhvallvckVrZEEzbW54c3Zsd0pOYmtEWHJqM05HM0RDKzdvSHlBeDBh?=
 =?utf-8?B?VjFOK01NbEQrREE0N1ByRXZnY1dYbTM4eHVwLzYwYjRDdFJHS3JSNU9LL3g1?=
 =?utf-8?B?eXN1OUxVUWZRT0Vlek9DTjUrRk5hU0s2Y1VkaUIvcnlvTjlsV1VCejVBTENT?=
 =?utf-8?B?ci9WTU9FMklqUXJNWXkwWE0rMURGUXRKU0x2dGR4ZzZQdFVZd0w1WUtOMmNQ?=
 =?utf-8?B?U1JFRVNmOSs0cmJyM0wxRDB5VE5YaWljZ0VpbExuQU9GUzVBU0NrMnJ1OXh1?=
 =?utf-8?B?V1ZMdjM5OXRnOVJnclBqRTFSeVVNVUpWQ1I3b0V3MDZpbjZFL1dnTmpYVUdT?=
 =?utf-8?B?alBaa3FxdTh5N1pRU3ltdUp2WVM5RXRmRGhOY1cyTW5mQnBxdkNoY0pyZ3lu?=
 =?utf-8?B?UmNudVhHL3hVNVk2cXlUU2diUysxZ0owdnJsL2M4bGtYanVtc3RlNkdsZFFY?=
 =?utf-8?B?eTNOcHZsZGhZR3l2NFc3WnR0dnBtRjVmZVdYSjZaZXVFS0Jnb2t3SCs2L2tw?=
 =?utf-8?B?c2N0b0hFMjlsMHdpcndPck1PcFlaVEduQ3RTQWtXbzZtakloTW5JRFY1a3kz?=
 =?utf-8?B?ZTJ2dHo0ZkU4OExBMVlEZFZwdzFibHdZV2c2M3prZ25IdXFXcXN3TVVLdElj?=
 =?utf-8?B?cmNUK21oZm1aa1BMYlZTUUxaZnpzamNWRlFPdzA2Y0ZQOE4rc2NuWkkxMkdn?=
 =?utf-8?B?ZHZiOUc0WCt4Qy9pSjlZWnN5QVA1VnZRbkU0d1luY1NsYjd6bWhRVFdxUXBx?=
 =?utf-8?B?ajd0RS9Nc2I5d0h3UTBiNFVqbDhuMTE5cTFwNGZZOEI2Z0lQN1ZqUUFhR25B?=
 =?utf-8?B?ZVVWazlYZEpxL2NvOWgwR091dFllV0VTWE9xb2xBZ0RLVE8xeWc3cDRuamlK?=
 =?utf-8?B?d3ZqeE5TNTJsUFpha3o0enFuenFta2I5TXVEb3lCZEFxbXh3Z2lRSG0vSXBv?=
 =?utf-8?B?ajZQZnhmamRtS24vaU1oZXJNanlIY2QxRU8xbU5jL2c5UzNKN3JZcTlFdEdJ?=
 =?utf-8?B?a295bU8waS9GejJzYUpBcUdEdUhIMTFXUWlORFlVM0tQb25kd05STzh3dGJ0?=
 =?utf-8?B?ZHJLMCtDWm5IR1VYMDhTSTJZQjE5SExJNitSc3ovd25sTmQzZ0g5Z2pOL1Nx?=
 =?utf-8?B?bjhwRGZ3TFdZdkc3RFM0bUJhRmZYTkExeUZ1Q2J0MjFsZDVkSjZYZ0NHalYv?=
 =?utf-8?B?RlVDK0VGR2s5SDlnWlBxTnFZcEI2QVZsSm9BaWhyQ2pmV0VnNlBwR2ViQzJy?=
 =?utf-8?B?dzhCMnIreXBBeTBjb2R4VDAvUlVCTUlyMUtNeE1oVnV2b0pGK0hnc3JSeWVl?=
 =?utf-8?B?dCtOWm5LL1RvNkl4enhEZ0IrV0NrenJhcnM2eXlxcmlMYVQ0dy8zeWhDVWFL?=
 =?utf-8?B?UjNPNkxoYmphMGcrbzJpYWZmL3hnSkEyWFJmSDcvV3RjZkZ3Y0dERWJTWkpV?=
 =?utf-8?Q?7zQAzMN7xfDtHi8sFvN3gtyvrg2gkbyq7e3NU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFN3azBuSWdET25zS1VyaFl2ZlFlS01MbStBdVRtZjdsMUJuTEo5UVRzUllr?=
 =?utf-8?B?VjRDREdMNG9zSlpsM2FMM21ONk5TTU9hWGdHeEIwR0hYL21NRWE3b1pxQzFO?=
 =?utf-8?B?QUIzbWg0SXVMaGljK3N1UmlqeTBSaDNxdXFtTVBIalZPRHVwUkxsSmxWZDJC?=
 =?utf-8?B?MG9RTFp3dzVNUEVWdmtvYXRUSzNlTjZodlZ3aVdCNG5RTlJEcld2UVhENHdr?=
 =?utf-8?B?c3NraDF4b0ppMTFMMXhqRUk2K0JHV1plOXJJcENBSDhnWGpzWW1FOGJuSUd1?=
 =?utf-8?B?WjRzU2x1aUlFL2hUNmRrMnJITWxzUDYvZjhJMldSV1hha3YwS0cwSmpNQVNP?=
 =?utf-8?B?eUpNaThVb0RIYU0yTnIyYldONzBNaGNSVlM0NmIyMENvdlpGaXZnYXU4MS92?=
 =?utf-8?B?L1hocitGSmN2MHNJcGVNQXBLaHRENkZ2ZXdLdFF1T1hpelEyVDc2UjRvWmdh?=
 =?utf-8?B?YW9LYy9CTHRRU0hHTW1TK0RIdWh4R1krMkZpUUd2ZkROdEM1NStWQkt3Qm10?=
 =?utf-8?B?NS8rZGJ5NzBTTURJam9sNDdTSEU3K3hMOVFnZXJXL0YyK21IWVNXQVMxcURR?=
 =?utf-8?B?Ty9GTzNHcmF0SEJyVXhCK2VpTEpDVU0yaDc5RnhUZDJISDA2VldOamxSamN6?=
 =?utf-8?B?UHczazErT0FmeXR1bGt1c0VjOVp5cXo3ZUNMNFhteXVOK3VyL0piSkpFc0dB?=
 =?utf-8?B?VlAzMDdGdHFLeWFsZXRzSENZZUN4WFJzOHFMQk5CWDdHU2g0djNkdXIwdEhl?=
 =?utf-8?B?bG5MSEJkMG13WjM3NlptRFkyWUVzQXh6ZnBPeWdtVmFwOWpBWFlEN0x4YUpE?=
 =?utf-8?B?MlRtNVVuKzVzcjA3NTFPM1BBcjBPYUJ4M21ucVJSZ21nejNyNi9FYjI3dEdR?=
 =?utf-8?B?SFpWWmpwOXRjZExSWnBETjNsdVBmY3lmVDJTYkdic0hPTDNhUjdZSXU5K2FS?=
 =?utf-8?B?V0pvcGR5MFFiSG1vSDhQV2xCWEQ0M1NkV3VrdndqV1ZHeUo2dHc1VFQ5L3RX?=
 =?utf-8?B?R2Q0RWxBc0JIeWRtRXNGTWpjMUt2N2dzeTVPVTlhTDZJT3VCd3QrUlBzWWxW?=
 =?utf-8?B?SzdpVHdGY0ZHYVBueit5MWIzVk4xejFMa0sxRU91cFRFWk1XYUJSM1Z1TGJx?=
 =?utf-8?B?Y0I5a3dnV3RTN2huL1k3U0VRRGN5MWVTNEJ2WCtvSDgzRW1VdzJNWXpubk5B?=
 =?utf-8?B?U1lEWUc3SHZPRmtnTk91TlFSTWo0TFluTWVKSm9ITjlScFk3L0dCYkk5WEZD?=
 =?utf-8?B?TDU3Wm9hbkFSSitoYnVJZ1VTeXlCWGo1czRreEZSbEZ5M043U1c5YTlhSER5?=
 =?utf-8?B?a1JJYTNQcVBLangyeHpHeDJ6SzhwVUgwMnNWVERsLytCQkxZbU81UGc2bmRF?=
 =?utf-8?B?NlV6dDRVR2VQd1Aydng5OWt5alFHTS8rZGVjTXFpUGZ0cTlyVWcvbVdsTXly?=
 =?utf-8?B?Qml0NXJHUDlqbkxYaXZzOUZxL2RlSEZVSGdLNG5RM2dnZWYyOXlsSTRkYUtl?=
 =?utf-8?B?djhaQlNNM3V2TTRSOE9UUStvZnBFcTc0anBycU1QNmZCcnFFc042dis1d3dU?=
 =?utf-8?B?bXc1bVQ0dmRHZ29XZ25DMUFXbFl3SSt0YVQ0SFFZVTZqZmFpWkFPNnYxeVZO?=
 =?utf-8?B?aUlVNUJUQXpOSXJUTHI4enUrbEZNZEsydUxrWER2TmhZRmtnVTIwVHJVRFJk?=
 =?utf-8?B?Uy9zcDQ1bThCRnNSbUVaYnYvaWJqdVZzM2NoOEY1dmc5THZDTU1NK2xlTktB?=
 =?utf-8?B?WW9MNWhKek1lRWM4bXE0Lyt5RXVYZThJbHlRYUtvYUUva0IrQ09TU1BoNFZ2?=
 =?utf-8?B?SlBITEtHWHl6Skc0clVLNVpSUmEwWitIOEJNc214cmVQeU5JZ01pbWpkY0ds?=
 =?utf-8?B?d0paaUVFYm9nbjFybXFiQ05jd0ZKejdxcytCdXVmMVpSZHRtU3NLYW9PRHRj?=
 =?utf-8?B?eUQvekRjL29jaTExeFdPY082MDJkNE8rc012andsNnNEQkc3dm5XTERKS0xJ?=
 =?utf-8?B?VlVCdlRaNGUxdElFa0luSVdNNG5WbnlxMTRlMFFjU3Q1L1dXaFFTUXFyV1gv?=
 =?utf-8?B?djNTb2k1YVI0MjNTMWl5YnN6OUNYZlh4dnNYc0ZwZTAxeWltaWxOWmIySWl5?=
 =?utf-8?Q?nXtLSdrlGh9WEr10Xfb+kpm5o?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8740abaf-222b-44fd-184c-08dd022cc1d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 08:42:20.9432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1lwhfA1ffl3jq9fBD20ZoHmswoQ3OhSp8Y++x3wtfV1CGPBroCK4UZutfM7IN5MoSyHVOh53xz+CpiBz85oSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3901
X-Proofpoint-ORIG-GUID: VwJCa9DVQEMkfduEHJOS1eBWJmfYvluY
X-Proofpoint-GUID: VwJCa9DVQEMkfduEHJOS1eBWJmfYvluY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMSwgMjAyNCAzOjQ5IFBNDQo+
IFRvOiBTYWkgS3Jpc2huYSBHYWp1bGEgPHNhaWtyaXNobmFnQG1hcnZlbGwuY29tPg0KPiBDYzog
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3Jn
Ow0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gU3VuaWwgS292dnVyaSBHb3V0aGFtIDxzZ291dGhhbUBt
YXJ2ZWxsLmNvbT47IEdlZXRoYXNvd2phbnlhIEFrdWxhDQo+IDxnYWt1bGFAbWFydmVsbC5jb20+
OyBMaW51IENoZXJpYW4gPGxjaGVyaWFuQG1hcnZlbGwuY29tPjsgSmVyaW4gSmFjb2INCj4gPGpl
cmluakBtYXJ2ZWxsLmNvbT47IEhhcmlwcmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxsLmNvbT47
IFN1YmJhcmF5YQ0KPiBTdW5kZWVwIEJoYXR0YSA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT47IGthbGVz
aC0NCj4gYW5ha2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbQ0KPiBTdWJqZWN0OiBSZTogW25ldC1u
ZXh0IFBBVENIIHYyIDMvNl0gb2N0ZW9udHgyLWFmOiBDTjIwayBtYm94DQo+IHRvIHN1cHBvcnQg
QUYgUkVRL0FDSyBmdW5jdGlvbmFsaXR5DQo+IA0KPiBPbiBXZWQsIE9jdCAyMywgMjAyNCBhdCAx
MjrigIoyNDrigIowN0FNICswNTMwLCBTYWkgS3Jpc2huYSB3cm90ZTogPiBUaGlzDQo+IGltcGxl
bWVudGF0aW9uIHVzZXMgc2VwYXJhdGUgdHJpZ2dlciBpbnRlcnJ1cHRzIGZvciByZXF1ZXN0LCA+
IHJlc3BvbnNlIE1CT1gNCj4gbWVzc2FnZXMgYWdhaW5zdCB1c2luZyB0cmlnZ2VyIG1lc3NhZ2Ug
ZGF0YSBpbiBDTjEwSy4gPiBUaGlzIHBhdGNoIGFkZHMNCj4gc3VwcG9ydCBmb3IgYmFzaWMgDQo+
IE9uIFdlZCwgT2N0IDIzLCAyMDI0IGF0IDEyOjI0OjA3QU0gKzA1MzAsIFNhaSBLcmlzaG5hIHdy
b3RlOg0KPiA+IFRoaXMgaW1wbGVtZW50YXRpb24gdXNlcyBzZXBhcmF0ZSB0cmlnZ2VyIGludGVy
cnVwdHMgZm9yIHJlcXVlc3QsDQo+ID4gcmVzcG9uc2UgTUJPWCBtZXNzYWdlcyBhZ2FpbnN0IHVz
aW5nIHRyaWdnZXIgbWVzc2FnZSBkYXRhIGluIENOMTBLLg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBz
dXBwb3J0IGZvciBiYXNpYyBtYm94IGltcGxlbWVudGF0aW9uIGZvciBDTjIwSyBmcm9tDQo+ID4g
QUYgc2lkZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN1bmlsIEtvdnZ1cmkgR291dGhhbSA8
c2dvdXRoYW1AbWFydmVsbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FpIEtyaXNobmEgPHNh
aWtyaXNobmFnQG1hcnZlbGwuY29tPg0KPiANCj4gLi4uDQo+IA0KPiA+ICAjZW5kaWYgLyogQ04y
MEtfQVBJX0ggKi8NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
YXJ2ZWxsL29jdGVvbnR4Mi9hZi9jbjIway9tYm94X2luaXQuYw0KPiA+IGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvY24yMGsvbWJveF9pbml0LmMNCj4gPiBpbmRl
eCAwZTEyODAxM2EwM2YuLjBjMWVhNjkyMzA0MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9jbjIway9tYm94X2luaXQuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL2NuMjBrL21ib3hf
aW5pdC5jDQo+ID4gQEAgLTEzLDYgKzEzLDEzNyBAQA0KPiA+ICAjaW5jbHVkZSAicmVnLmgiDQo+
ID4gICNpbmNsdWRlICJhcGkuaCINCj4gPg0KPiA+ICsvKiBDTjIwSyBtYm94IFBGeCA9PiBBRiBp
cnEgaGFuZGxlciAqLyBzdGF0aWMgaXJxcmV0dXJuX3QNCj4gPiArY24yMGtfbWJveF9wZl9jb21t
b25faW50cl9oYW5kbGVyKGludCBpcnEsIHZvaWQgKnJ2dV9pcnEpIHsNCj4gPiArCXN0cnVjdCBy
dnVfaXJxX2RhdGEgKnJ2dV9pcnFfZGF0YSA9IChzdHJ1Y3QgcnZ1X2lycV9kYXRhICopcnZ1X2ly
cTsNCj4gDQo+IEhpIFN1bmlsIGFuZCBTYWksDQo+IA0KPiBBIG1pbm9yIG5pdCBmcm9tIG15IHNp
ZGU6IEkgZ2VuZXJhbCB0aGVyZSBpcyBubyBuZWVkIHRvIGV4cGxpY2l0bHkgY2FzdCBhIHBvaW50
ZXINCj4gdG8gb3IgZnJvbSB2b2lkICosIGFuZCBpbiBOZXR3b3JraW5nIGNvZGUgaXQgaXMgcHJl
ZmVycmVkIG5vdCB0by4NCg0KQWNrLCB3aWxsIHN1Ym1pdCBWMyBwYXRjaCB3aXRoIHRoZSBzdWdn
ZXN0ZWQgY2hhbmdlcy4gQXBvbG9naWVzIGZvciB0aGUgZGVsYXkgaW4gcmVzcG9uc2UuDQoNCj4g
DQo+IAlzdHJ1Y3QgcnZ1X2lycV9kYXRhICpydnVfaXJxX2RhdGEgPSBydnVfaXJxOw0KPiANCj4g
PiArCXN0cnVjdCBydnUgKnJ2dSA9IHJ2dV9pcnFfZGF0YS0+cnZ1Ow0KPiA+ICsJdTY0IGludHI7
DQo+ID4gKw0KPiANCj4gLi4uDQoNCg==

