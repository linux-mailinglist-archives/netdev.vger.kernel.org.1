Return-Path: <netdev+bounces-110222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA30892B606
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F509280E13
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D64156F4A;
	Tue,  9 Jul 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="IBlx18Vm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B261EB44;
	Tue,  9 Jul 2024 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720522590; cv=fail; b=YENtE7VPId5/Inx2U35fBmcwR/iqKCzE6x8al2KD+pP5rULBFshqHNTRf6ZFIHN8M20fyGBVT/AwNJ1GswU1QHDCgGL3wuEZ0rjAITIt2ZJheyhTHJ+E4dXQvclZpFBBlP+7TE0SFGVRfumswPAIFdF5rQPAqOO3leUHJf3hb/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720522590; c=relaxed/simple;
	bh=BhFBaD/rR2VWXDXr58qXrAmzaAU1/X5VIB7MWkP/qYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lq7Oh6CoedHdCJVtSlBI7s0QEmdc2yru6TK1Hn8aKgoqcLN3sP7uZrz6kGih8lq4hgf0PGidBQmgmTzhzOqKbC02obixGjQGYcxQLguE1y/6PlWzE8E1anJSWwnHape6nH9Q14Rq2VDfFWIb6gQMLcE7n86I9jvBbGvptuHqHD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=IBlx18Vm; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697V1mH018575;
	Tue, 9 Jul 2024 03:56:16 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 408mhjaygm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 03:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OanWaGVG1OOpa8tLyFwb5e90gR/AYHnzol0FtCbQxfyNPUWd3zmlZz9naibv69leYohz/010Em4XbUqkpj8eo91OglwFPdeq9mgMoXW6WqiMk5JEzMM2goBxl1e5dvIU4bzkGQcTOPfrqTHC5pF9yLP5xyTijrse0/+OJxvv6XM7mxoNcBG0Vd2zMwZ3NOvpLFlEtaD2Si3RHPLwaCLmSzEha52yKKwrePY+M50RckRN5a6i3GIhoS7jXzfFSTMSjA87Qf8xZ9Pg34WO0sd1up2cuxXcIOhxrSF+fjj9JjhZYJuv+egPXCMTGB5uIMMbMHjtj4v3+Hvrtk6/jYTWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhFBaD/rR2VWXDXr58qXrAmzaAU1/X5VIB7MWkP/qYk=;
 b=g4WOKysK0wLxOTE7PxBdIEFdn+cDg0NAOU1LkFuN5W6G+vHARF4k0f6KS/voo0z0SdtZw3TNld8AmWddcwHvTLh3LMHYNFhndhkmEqw5PtdMUCAaQcIIhf6U0POgyQ1bOYa4aStYT55yf1MTsXdTq0cOTp7Qgrb9WIMCtpcjlcjZEH9EtHFrhI7849j0Lud8QiqTCAWzZG6UlGEpZ3xPAjCvxfbQp3VRhmn5yPXkPoA4WNeTmjcVrLPOEGFgHbJgjcCl1o/kBtNEOqLFd9ApWwW2hxIrEVHx6OS+KzsA8EczTtTcGPwWpThtPqrbxZhl1lt2qGtXvBz0QZwekO1UgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhFBaD/rR2VWXDXr58qXrAmzaAU1/X5VIB7MWkP/qYk=;
 b=IBlx18VmqCuWOiriuUv6sJh0kDuPh+wXsC+UQl7/+dLWE9NtFNgBUPe79sgdiPjFdtVYr8q5DSyGySfr+9sSZxCniG5NFQl3V7uf3NmhjWQqkFENe2eE4O1Gk2hlbKPCGofm/bOtXLnJp+lKYSdpn/oFZ383lfdhO0zkeB6lHXE=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by DM4PR18MB4207.namprd18.prod.outlook.com (2603:10b6:5:392::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 10:56:14 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac%5]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 10:56:13 +0000
From: Srujana Challa <schalla@marvell.com>
To: Michal Kubiak <michal.kubiak@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net,1/6] octeontx2-af: replace cpt slot
 with lf id on reg write
Thread-Topic: [EXTERNAL] Re: [PATCH net,1/6] octeontx2-af: replace cpt slot
 with lf id on reg write
Thread-Index: AQHay5Yw91wh90ZrNU6455ds9JIQ77HjZsoAgArarqA=
Date: Tue, 9 Jul 2024 10:56:13 +0000
Message-ID: 
 <DS0PR18MB5368AB102893ADAA1C5FA0FDA0DB2@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240701090746.2171565-1-schalla@marvell.com>
 <20240701090746.2171565-2-schalla@marvell.com>
 <ZoP4iG30sr9lZohg@localhost.localdomain>
In-Reply-To: <ZoP4iG30sr9lZohg@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|DM4PR18MB4207:EE_
x-ms-office365-filtering-correlation-id: 87a5fdf6-168c-4887-0c91-08dca005c023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WHhOL2k0cUI2aG41WVhaMmlWQUs1VGFabVNBWThITUhoNUZ4OVpJWTMrV1Rx?=
 =?utf-8?B?Vkdqc2lQT1Rydjk4d3FhdDBqWjViVEtYTndrazRZRTB2UUsvbWNnN1Z5dUN0?=
 =?utf-8?B?QUw1dTduZ3U4OHd2UG9LZW9oTGU3OGE1VlFqMTJ5TTdWb0hSbUhSMnhtSHVu?=
 =?utf-8?B?RG51SW1CK0cxQm1sOWZkdWVIblRVbnVCZnJXdGYvaS9CcG5nbVF1QUpiVW95?=
 =?utf-8?B?YnhkSnQrZUJPa0RWVWFEMUczTzBYM2xld0JQU0h2T014L1VsK3JEUDFlRHp6?=
 =?utf-8?B?dks1dWltYng3YWRPM2pJc0JJTCtxT29Oa2dPU0pVWFluejNRbUhGeHdtN1Vr?=
 =?utf-8?B?cUhFdXZTRlhISzNpUnlYY2N2Y21scW9TWmdoZm5YSzdIekkvajBETEUvbjNv?=
 =?utf-8?B?VE55YnV1S29PRWJBRlBwQnNEUm0yNWhIc0hadkdWMzZGdDVQZ2hHZmFvdGtF?=
 =?utf-8?B?bEgvZmQ5cFZuamhKSnIvbEpBbUJrQVFmUTBLQ0RISFI5OTU1V2loaTl6UDRr?=
 =?utf-8?B?Y01CNVBqUkFON1R1SnFrVHFOV0NUV1NQbXZYR2pBNWViM2tYbnVLYXpRdEtJ?=
 =?utf-8?B?VTluZVZNVWMxTW93SEZmMXluWlZJN1RGMTE3RjI4NERVaVdjYTRIMkhhalRP?=
 =?utf-8?B?U25qellFQWxvd3g3ZkNNM0loV3JLU3dYWG95N21HK0R1cFpoZmpqSW14NDY1?=
 =?utf-8?B?dUpRYXF0RncxOGNkOW16aC9kZExsZkFnQU1zNXhwd3dpRDE2Q1NLZW1oZS9U?=
 =?utf-8?B?SGNRZUpaVHlvOXFUN0FOYndpNDlaTnpuNVo1UFM5NEZaQlZBR1dGMStmb1hY?=
 =?utf-8?B?OU52NkE0SDV1SW9hdWUyaWdacmQvdXo2YzdsR2hML1E2ZWxOL1VqdENtR2Rx?=
 =?utf-8?B?ak9vUFpkY21ZN0NTYzRjTEFOMGhXaHR1RHkxWklBa2l5S2FUNGNyNVlvV1V6?=
 =?utf-8?B?UnlvZ3pKUGVVOVhOdTR0QngxRGp5WDY0UFdvcXFCVHF5ZmtHcWd2YVJwenYz?=
 =?utf-8?B?Sk9YWW41SWNqK3JtOERXRUVCTEpBQi84aWlodkRrYTVJYXdVQkZtRnNMVHlN?=
 =?utf-8?B?MFRCQk9hSHlrUDNodWl3TmtOWjVyZEFJVFBla1Mzb001L1FJQUl5dDg1bzNZ?=
 =?utf-8?B?RWpxUXFnUEhVY05nMVlOMDhFanlxbFZKWDhpOWs4ZVNjNGVCUWowYVl6b25N?=
 =?utf-8?B?emxiaHBlbHZNMWhHaDR3enQwTUY2MFZTVmlKWXhIcFBHRjlrSXZ4cG5ySEdP?=
 =?utf-8?B?OXdtTDR6ZllmT0J2VGFqRURWWlg0R3k4ZzRzOWFMYVhtbkl4aUVTR04zWkJt?=
 =?utf-8?B?SmpoalRreXVOb1R3WmFFcWc1Nkc0OVplV2RUczRZaVNnR3BlbFpyWUtseDlQ?=
 =?utf-8?B?M3JLbTUvSjJVcGliMG5raU5oS0ZNMExVbFZwRElWMWRkdUNrRWlUNVZlb0Zl?=
 =?utf-8?B?aWNrVElJYnU0VGNQWDFzZStiRGY4cWZpVG8xTXE5ZXZyUHRkV2dCeGZhQzQ5?=
 =?utf-8?B?YkpFSG1vNUFrNkJIYlVSNFBycTFwd0UzNVI0RitFZ3F0aTJ4NDJJUnNjcGgz?=
 =?utf-8?B?ajMyMytxdWhzeGd4LzBtbHV4aEEvZllZMUJyTUg2WHYvbXpnVU5wTENGV1gy?=
 =?utf-8?B?NlFwU0ZwYVdJY1RUR1daZFFGbmsxTlJGcVowdnV3K1BzVDkySThuTVk0MGpD?=
 =?utf-8?B?RFp1NVMyVElSMWRhMFg5ZEhXVktiRVRQNDZ2cTEzQjFwdm5WRVZUMDRoS0M2?=
 =?utf-8?B?K1dYK2llaUlGdGFEcDAxdWhONytkMnRpYnQ5LzIwMnZrQmczcVJIb1A3aTZY?=
 =?utf-8?B?WWJkdkJOY3JVTllFYXFRVzVSdWRwUXhySks4VUh6dzkvRWh5dytIYitUeUJC?=
 =?utf-8?B?cCtWQzJhTW94eTJwcEdPR0R3ZTMzUDg1RFhtanJ6bm1oZ0E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NVlwejNlWHFhUmg0ejRvQmszVWkwc2pocVArNm00OHFmWFdieWE3L0RQc3Bn?=
 =?utf-8?B?WCtJN2VkdjlZL3Bva2VTUnZrKytpVmk0aFZiVXB5Uy96d2hqbEowazFMcmdL?=
 =?utf-8?B?VkRLZFVRb1BNZ3VzTXQxOG1EYXRDUGdnMCtSTjlzeTFkSHIyR1FOdmFrbTVK?=
 =?utf-8?B?UjdzbytIVDhpUlQ4ZVRlYVMwZnBXL0JxbkloZk1ZUzNPRitqRHRwWHZSaVlC?=
 =?utf-8?B?aE5CTm9McVZWWmRaOXhkRFUvQkpmcTNIeTBRVHM4T3FwdG5YVHNtRFZyczF5?=
 =?utf-8?B?SXh2SVA0RGVGVk9Ib2J6TnRZRUl4MnZJeERoUG0vekh2YXlNSVQ3dEVlbzdM?=
 =?utf-8?B?ZDQ4TmZNTE5MUHpKYWkrdGZrNDlLMlJZT3Y5aEZNbVU5bk04MktQK3pzUWNv?=
 =?utf-8?B?M2dGQVRZTEdUVno0WWJFMVc2SzQwUzByN1dHNXEvWjZnSFI3YmhJV0lJbGkw?=
 =?utf-8?B?UjQ4YytaeS95VHFvL244RU9ZT20rdUlGcnVVSWpXMllEaGNaUXBMS3JPL3ZX?=
 =?utf-8?B?aTVwNldZRG5oUHM0MjlobG9QVjBtNFVNQ1MyRDZ3UDUvV25NaG93clNQelZJ?=
 =?utf-8?B?MVJuWEJUTC9RMGpZNkhKTTZCOXZIeVBJSHVNaHBtek05Zlp0QktxRmpSZTZo?=
 =?utf-8?B?akxnTCtLeEhBV1owZVFzSnhzdTZFMFlqWGFkSHdRcnpTbnNUUVRHZ2VlSDA5?=
 =?utf-8?B?dm5qdzVRakU4SHZOMW1tcUVTZ2dIS2U3UlppZ0IydW1BZU9rRmc1QStIYm5i?=
 =?utf-8?B?NjVXcHcvUXNyOU5vN01iNUI1RFZFWkR0eUNBSWJzOS9KcDIxQUZhRk9Gakh4?=
 =?utf-8?B?RFg1N0pyYUUwK0NLeFdpNXo1ODRYZzUzYkc2S21ETEo1SWhSL3l1d3hzVC8w?=
 =?utf-8?B?bUdZSDBsMEdGSUlZbW1UY2c1dkpOM20rQ2pDK0I5bW55a3JCZkRqaTJ5Q0Vh?=
 =?utf-8?B?TUJXQ2NCQm1Kb3BsZWkvZW51VkJ0WjVZcGo4L2RWWlhESFRVcGV3SlFHRVpJ?=
 =?utf-8?B?OFRtTVF6SE03c0pLUFhBdkkwM3B3V0RiQVBpQ29xRko4UVJhbHJ4V1MrNU1C?=
 =?utf-8?B?eUtRL2pJUUE5VDYycHVZQnF6bmQwY2RBNWJ0Nml6Mm5vOGRmRVlGVnp4V2tK?=
 =?utf-8?B?SlV4ZVUvdnEwd2lsSXJoQjRJK1l0Y0hITWJ4NllZZHhGVXNIUDVZVVBjazRQ?=
 =?utf-8?B?WFc5K0dvL0liaEd6SzlZRElyTm05cUpWTDl1SzdEbmp6SDhGOWx5UDJQend1?=
 =?utf-8?B?emdDMHhlZEJnL0h1bnFWNlliUGtvZFhlRFNXTVlBWVd0RnNCeEJDQlltL1ZS?=
 =?utf-8?B?OVozdWkwbEh4TlVCNHJGUk85cFZKaWQ1VUpEVElwUDgzYnZqSkF2RXoySGsx?=
 =?utf-8?B?Z1hWWUpVYnNlcmZkcUo2ekVMcUZpVlR4YXlMTFY0bFM0VmZNMlk0blZGNkpW?=
 =?utf-8?B?RjRwckN0OGNkWDBEdlh1bDVFOFpiblB1dzRneUNKU1JCTkFLMkFVWXB6bUR5?=
 =?utf-8?B?dWlUMk9TMHpNS2pmM0VQSmE0SlYzcG5mWHBDTnhqWmMyTUtxVVR2RSsyL1Jy?=
 =?utf-8?B?MGp3RUFqNFgrQzZPWjAvL1l2dFd0M1Flb3V3cW5jWEVaL0F1dUpPeHZ2NFpr?=
 =?utf-8?B?UXpLNjUwYis4cXBCY2Z4UkZCOXFWRi9ZTUNoNDJOVk1oOTdRdTFYZEdYdXEr?=
 =?utf-8?B?aGhIUU9jR0pNaTZUV0NaUUJqVHNaS2ljR2NnUmMvR1c1VXRicUxjUk5xT1Rr?=
 =?utf-8?B?VVhOSWJzZ1NMd0FLb1VPcmxhWUcyR24ralVrM2syNFZqQmR5YWhnKzQzcHJ1?=
 =?utf-8?B?NDVTd0hMUTR0YzVBRTJpRnhiUndsSE94anE2bUVlWFNicTJmc2FtNlg3MDFF?=
 =?utf-8?B?dWkzbzZiT3hFTEF2U0RCeXR5bnk4OW15U2FiVkFrUnNCWml3VmQzc1cyL0N2?=
 =?utf-8?B?SjlieDZGMnJKSU1kR1ptd085SXF5Q0QyOHk2aE16cyt2U2UwVjIxQ041STZ4?=
 =?utf-8?B?M2ZoanowZXc2RGRRWUJMUVovSGFQWlFLTUFHMVZPbWxHU2NXSXFSNjAyTGI5?=
 =?utf-8?B?bnV3MUcrcTQvcXJoQzU4Nll6QThSVWJ3dHVWZnFhbjMvMGJpN1F2QklBbFJM?=
 =?utf-8?Q?qI9oqO1m8XkKTtG+R7pKTjql6?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a5fdf6-168c-4887-0c91-08dca005c023
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 10:56:13.8112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiXlGMKm5M0mcczIXTEyvFCFWrRNyFa+WIJBtmsk2hbDps8Ai07yjglpJ0oOVnIAVF6bVMKZfad3v1Jsxb8u4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4207
X-Proofpoint-GUID: sLx6MMgkcgzzpmKtCTXfJ5W9qSd1nnpS
X-Proofpoint-ORIG-GUID: sLx6MMgkcgzzpmKtCTXfJ5W9qSd1nnpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01

PiA+IEZyb206IE5pdGhpbiBEYWJpbHB1cmFtIDxuZGFiaWxwdXJhbUBtYXJ2ZWxsLmNvbT4NCj4g
Pg0KPiA+IFJlcGxhY2UgY3B0IHNsb3QgaWQgd2l0aCBsZiBpZCBvbiByZWcgcmVhZC93cml0ZSBh
cyBDUFRQRi9WRiBkcml2ZXINCj4gPiB3b3VsZCBzZW5kIHNsb3QgbnVtYmVyIGluc3RlYWQgb2Yg
bGYgaWQgaW4gdGhlIHJlZyBvZmZzZXQuDQo+ID4NCj4gPiBGaXhlczogYWU0NTQwODZlM2MyICgi
b2N0ZW9udHgyLWFmOiBhZGQgbWFpbGJveCBpbnRlcmZhY2UgZm9yIENQVCIpDQo+ID4gU2lnbmVk
LW9mZi1ieTogTml0aGluIERhYmlscHVyYW0gPG5kYWJpbHB1cmFtQG1hcnZlbGwuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVf
Y3B0LmMgfCA3ICsrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfY3B0LmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9jcHQuYw0KPiA+IGluZGV4IGYwNDcxODVmMzhl
MC4uOTg0NDBhMDI0MWEyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21h
cnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9jcHQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9jcHQuYw0KPiA+IEBAIC02NjMsNiArNjYzLDgg
QEAgc3RhdGljIGJvb2wgaXNfdmFsaWRfb2Zmc2V0KHN0cnVjdCBydnUgKnJ2dSwgc3RydWN0DQo+
IGNwdF9yZF93cl9yZWdfbXNnICpyZXEpDQo+ID4gIAkJaWYgKGxmIDwgMCkNCj4gPiAgCQkJcmV0
dXJuIGZhbHNlOw0KPiA+DQo+ID4gKwkJcmVxLT5yZWdfb2Zmc2V0ICY9IDB4RkYwMDA7DQo+ID4g
KwkJcmVxLT5yZWdfb2Zmc2V0ICs9IGxmIDw8IDM7DQo+IA0KPiBJIHRoaW5rIGl0J3Mgbm90IGdy
ZWF0IHRvIG1vZGlmeSBhbiBpbnB1dCBwYXJhbWV0ZXIgZnJvbSB0aGUgZnVuY3Rpb24gbmFtZWQN
Cj4gbGlrZSAiaXNfdmFsaWRfb2Zmc2V0KCkiLiBGcm9tIHRoZSBmdW5jdGlvbiBsaWtlIHRoYXQg
SSB3b3VsZCByYXRoZXIgZXhwZWN0IGRvaW5nDQo+IGp1c3QgYSBzaW1wbGUgY2hlY2sgaWYgdGhl
IHBhcmFtZXRlciBpcyBjb3JyZWN0Lg0KPiBJdCBzZWVtcyBjYWxsaW5nIHRoYXQgZnVuY3Rpb24g
ZnJvbSBhIGRpZmZlcmVudCBjb250ZXh0IGNhbiBiZSByaXNreSBub3cuDQpJ4oCZbGwgbWFrZSB0
aGUgbmVjZXNzYXJ5IGNoYW5nZXMgdG8gdGhlIGNvZGUgdG8gZW5zdXJlIHRoYXQgd2UgYXZvaWQg
bW9kaWZ5aW5nDQp0aGUgaW5wdXQgcGFyYW1ldGVyIHdpdGhpbiB0aGUgaXNfdmFsaWRfb2Zmc2V0
KCkgZnVuY3Rpb24gaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiA+ICAJCXJldHVybiB0cnVlOw0K
PiA+ICAJfSBlbHNlIGlmICghKHJlcS0+aGRyLnBjaWZ1bmMgJiBSVlVfUEZWRl9GVU5DX01BU0sp
KSB7DQo+ID4gIAkJLyogUmVnaXN0ZXJzIHRoYXQgY2FuIGJlIGFjY2Vzc2VkIGZyb20gUEYgKi8g
QEAgLTcwNywxMg0KPiArNzA5LDEzIEBADQo+ID4gaW50IHJ2dV9tYm94X2hhbmRsZXJfY3B0X3Jk
X3dyX3JlZ2lzdGVyKHN0cnVjdCBydnUgKnJ2dSwNCj4gPiAgCSAgICAhaXNfY3B0X3ZmKHJ2dSwg
cmVxLT5oZHIucGNpZnVuYykpDQo+ID4gIAkJcmV0dXJuIENQVF9BRl9FUlJfQUNDRVNTX0RFTklF
RDsNCj4gPg0KPiA+ICsJaWYgKCFpc192YWxpZF9vZmZzZXQocnZ1LCByZXEpKQ0KPiA+ICsJCXJl
dHVybiBDUFRfQUZfRVJSX0FDQ0VTU19ERU5JRUQ7DQo+ID4gKw0KPiA+ICAJcnNwLT5yZWdfb2Zm
c2V0ID0gcmVxLT5yZWdfb2Zmc2V0Ow0KPiA+ICAJcnNwLT5yZXRfdmFsID0gcmVxLT5yZXRfdmFs
Ow0KPiA+ICAJcnNwLT5pc193cml0ZSA9IHJlcS0+aXNfd3JpdGU7DQo+ID4NCj4gPiAtCWlmICgh
aXNfdmFsaWRfb2Zmc2V0KHJ2dSwgcmVxKSkNCj4gPiAtCQlyZXR1cm4gQ1BUX0FGX0VSUl9BQ0NF
U1NfREVOSUVEOw0KPiANCj4gSXMgbW92aW5nIHRoYXQgY2FsbCBhbHNvIGEgbmVjZXNzYXJ5IHBh
cnQgb2YgdGhlIGZpeD8gT3IgaXMgaXQganVzdCBhbiBleHRyYQ0KPiBpbXByb3ZlbWVudD8NCj4g
TWF5YmUgaXQncyB3b3J0aCBtZW50aW9uaW5nIGluIHRoZSBjb21taXQgbWVzc2FnZT8NCmlzX3Zh
bGlkX29mZnNldCgpIGNhbGwgaXMgbW92ZWQgdG8gZW5zdXJlIHRoYXQgcnNwLT5yZWdfb2Zmc2V0
IGlzIGNvcnJlY3RseSB1cGRhdGVkDQp3aXRoIHRoZSBtb2RpZmllZCByZXEtPnJlZ19vZmZzZXQu
DQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KPiANCj4gPg0KPiA+ICAJaWYgKHJlcS0+aXNf
d3JpdGUpDQo+ID4gIAkJcnZ1X3dyaXRlNjQocnZ1LCBibGthZGRyLCByZXEtPnJlZ19vZmZzZXQs
IHJlcS0+dmFsKTsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo+ID4NCj4gDQo+IA0KPiBUaGFu
a3MsDQo+IE1pY2hhbA0K

