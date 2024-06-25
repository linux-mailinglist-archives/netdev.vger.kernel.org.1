Return-Path: <netdev+bounces-106621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01720917052
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DBA284B9B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173EE175567;
	Tue, 25 Jun 2024 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="d7EUlfqp";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="poqhu0N8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F84132127;
	Tue, 25 Jun 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340375; cv=fail; b=TqhcXQ1LSY7gHwIIT0Ql99POZSWSxK5lvLaUQUsyfyDiP/zNZUTIIQX0lftLeK+VNsqtaiLXr4smfmLgpN1uitDCVS/1Z87VIdqLvbMyjXFsN79yrwV/bSOPwt/EABN6I351x7840i+5iasZ0YAUt6vqX1I4WBuJbQSsSuhSUVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340375; c=relaxed/simple;
	bh=0yQfcfV4i2kCQOtmhkk7faRb1yPy1srLDNAsNx+VuKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iC23ds4aNbzKIZDSgnuli7Z2csTaXX2bb6NJIvB1UZLP5v2oIrjZZfGbKS0ZqPjmgc/lCVJfTpAhZs12Kqw1f3Jw4jmGjJsn66YkZp1O5GUDes2DLXS1xGRttYnqXShQOttjdKBCJlrFA1YBDpRbDbS3spvrJVV12emMfqmR/c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=d7EUlfqp; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=poqhu0N8; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PDqlqS008221;
	Tue, 25 Jun 2024 11:11:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=0yQfcfV4i2kCQOtmhkk7faRb1yPy1srLDNAsNx+Vu
	KU=; b=d7EUlfqpJN6cO7tbH2AuyF2Qbfjs9iBNE9NOnFiPqC1rBEqxsgf5T0ik8
	gwC2hA54El8bcXgcaV+FNtgn2FsanYLmQU0MWqWCMkazIyb0Nta17uWJjUDEnSN7
	zO1NHkdFAYfZnVQHO6atRPGK5G8/15dXdPQ+cddOJIMdfe9rg9yDDS+qHPFwMOsz
	sL5lzhO6ga0du0znmv6l2FvzPfw4SHuZy+MkRjyi4A1JkhoRui6/CZOhN2kECpIY
	DKMsxy+NkASV4fodfe+wFtEeitxzR71o/6LJJHoD6YwYXksRCtOIVm5en5/UAUAz
	orUsrBEzsgNW7pzEVM38sEODXIrqA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3ywvqfxjb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 11:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBVZp5+Co3oSDw4iFUyH3M5TYuLIt00IU/+t8E1Q4IRlZmVwrDjAtqJozrORtXbcPDC8HYEImBNi9JPXfRORMFfWfB5QsTBalP/2fB4eaufNXFPvp0mTXLXygY+PprfAKz3FAcLd8cTbPPja9QPQfZyVASc6BcwMp/zzNsnZtEkkEP71+v7/y9dVPcKj3cQN5KNusOwfUfhELYkFPzEGO+DI8Tujhoew7xgTwxyhfbe53Vv9MfBBn7SiWTR0guaUFryqbybiLLEvfJTzvIbhQf3JV89wka384p2SNNxhilt1wYSXERrPjYlATu0OxpUij+eRuzF85RNtOnsF0seNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yQfcfV4i2kCQOtmhkk7faRb1yPy1srLDNAsNx+VuKU=;
 b=iWNUa/+YLdXPMI9LumIiQkxSnFTGnUzIgPNADuEMFM/nCf1z7KUGRwvIecoyNj0qvd88qgNXYjOyCaTnnUCOpbmmbbJAyJj2705YN3hwj48MrwEw+mnW+7Oo/v9iss5IJh73Ik0Catoinbed4RwQwckAXg2d9wIddwfnM2BjQO4b3pCC0FJ+KxSghzfxnJjXLOQ3dsm2VXhkR0TWbGRpe5FjZUIq8zVoqp8dLCsWnBmZyfLKXHCViy1vEd/O8vf6y+CfN6M+lkDaBPBvEWbVt0uEC3SpfbvbNlTGIpgsAFaUs4a0ABmeIuawAyFkPTHZ3lxFq++8OIuIpPbYlL+DrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yQfcfV4i2kCQOtmhkk7faRb1yPy1srLDNAsNx+VuKU=;
 b=poqhu0N8Jsoo26s5a/C/hAE4PO4WaqKvqZXxLqJ2I1YwFQrQasGjzP8iS8m8BYwVHiNlRWueeQpiziSUe45fSRK+eJ3fTo5jCN8cNnx+GrHZbk+bEg9felDhWwm1/FG29j+6WPyKWuQ5ptQcvVIcNLsOqaaIQGR7dE+eE1zZI1bMlrZy/A4gLEVQeFJZSkF1hFHU+vUPGf+vhpPtnUz2kd8cuXNzgmiPby0GRtzPMDYZTgucG5hMbItAC811ol4KF/GZzRoFYEz1gTGreZNrV8rfzh+8AxRFDcRP7axZdrcy73/yH/pWsJnIYndLfMVzEN+ZTdaPKq72coLnC4mIxA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SJ0PR02MB7311.namprd02.prod.outlook.com
 (2603:10b6:a03:29f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 18:11:15 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 18:11:15 +0000
From: Jon Kohler <jon@nutanix.com>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
CC: Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] enic: add ethtool get_channel support
Thread-Topic: [PATCH v2] enic: add ethtool get_channel support
Thread-Index: AQHaxmV3ZX4ZExSXTk6BP3fPqsGVjrHYweAAgAAHagA=
Date: Tue, 25 Jun 2024 18:11:14 +0000
Message-ID: <DD0B95A6-128F-4DFC-9B69-B252A5ADBFFF@nutanix.com>
References: <20240624184900.3998084-1-jon@nutanix.com>
 <BY3PR18MB4707C45665890659CE11220EA0D52@BY3PR18MB4707.namprd18.prod.outlook.com>
In-Reply-To: 
 <BY3PR18MB4707C45665890659CE11220EA0D52@BY3PR18MB4707.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SJ0PR02MB7311:EE_
x-ms-office365-filtering-correlation-id: aed8ca4a-5c79-46aa-0e16-08dc954233db
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|376012|38070700016;
x-microsoft-antispam-message-info: 
 =?utf-8?B?U1g3ekwybHh6QkJSWWh3bjBJbmVRdUdHS1ZQMVZGa3J3d3UzcFVLSlVWZlRR?=
 =?utf-8?B?S25DbzlzamRCS2w1N3FGUGpiOEZKQkUyYVZNaVFvclhQTysxZEh5T1d4czVo?=
 =?utf-8?B?TDJ4ZlJtY0ZOSkxJTlR1QnVmcUw5NWhXcE96UmsrSGhvaFJ1K0FmUUxzUkRV?=
 =?utf-8?B?Yk56R2tRcnh0enFSVVlyeGcwWEMzQ3pqN3pnQWRHdWd6VGVNY2YwTUpyT0VE?=
 =?utf-8?B?Sk1rWHQ4VkVlQkFhdWFYSDE5WjRsck05dHQwaG50SmNONGFCaytzWTRya0J3?=
 =?utf-8?B?KzR4N29MVERFVGxXVHNxdEJSRE16VDRwYjBXb2pFbUk1OUZmRUJldkFOenY5?=
 =?utf-8?B?NjRBbkJMNlU4NzI4aHZPeS9RRlV6Z1hKQjhWZDJuaTlIcmc4YWY5NlVnWmtS?=
 =?utf-8?B?aHlhdk1meTNkUEdDREVzMVQ3NXRHNnAyODZvSExNT0hCMTNIZGFxckRZR3M4?=
 =?utf-8?B?ZU4zMElncmFDQThDQkpaeVRQQktEVlRFYnBXWElRMnRvZldnbjNNMENPc2w1?=
 =?utf-8?B?TUF5dE9tMTlrWXpzTHU2WUlRVzlFOWJheHRHRjBxWmFFVS9zZUlGWUVkYkhN?=
 =?utf-8?B?ZWlkMUp6QkYreHRTdW8xQ05icVAvMmJpTlVsZGhCV3hqL3RCdE5qd0tXOVhB?=
 =?utf-8?B?RmVFYWN2RDdwWFJ6SE1jUWEvcmhFcWttc0d6THN3amUxQW4xc1FjTEd0VUts?=
 =?utf-8?B?ZTFwaXpvNDl5TVBRbkNqWDJwWHRabVVRcUlnSTA0c2JpdGRYQWRHSll5QUpM?=
 =?utf-8?B?Z3lUR2l2SVN4bWhkNkNENlpwRlhLa3hLa3BwemdMTWZwYURrc0VHR2MyTkN2?=
 =?utf-8?B?VFdDcGJIM3BaK2RtZVU4TWVIcnZDVzVVTkc3VEtWbVh6YkRrV2lVdThlL2Nj?=
 =?utf-8?B?YnBtUldFR1ltUDc3bE9yMFJ2UTRzZ25xbXVYTlgxbnRSVFQyM0JnZTZpc0R4?=
 =?utf-8?B?ZW5ObGhleW4xbnFFZjJhSElHTTJwU2JWdHNzeENQMFk1Vm0vQ3JpSkpmTTFx?=
 =?utf-8?B?TEVFMC95WGFVS0t4SE05eWJYUXRSMWNQcFVDV3IvSkJMcGF3aWNYc2V0aWEx?=
 =?utf-8?B?eUxKSVdoYlJjM2NiVzBxVTZhQXZra2d2cElmSEwwUkFvb25WWVdwUUFTM3BZ?=
 =?utf-8?B?U1VLYWRDakM1SGpYQ3BoejRkcnY3dlNLMFR4TXVFTEI4ZGpzdUY5R25MVU9D?=
 =?utf-8?B?UXkrRjVOUUlmdTVld0xvd1dFMXcrMlJtdzBlTFU3UmVGNE8zanFFTUpUNzF4?=
 =?utf-8?B?REFLQUsrdW1senhlaFFpaUxtYzhPc0xQbHFpYk1VZjZMd3d2TFJVQTc1WElN?=
 =?utf-8?B?S0xyTmx3Y2VMRnNvbGxzR3lVNVRpK2V0VUxtL3dSQ2hBelRFUXNsUmlaYkxa?=
 =?utf-8?B?dzZYaFlKSTZyUUM5TmtCQiswdWVDSVdseFV0VnIvc01qYjlBSjZ4Zm9LOHVq?=
 =?utf-8?B?R2NMTUhmTWc2azlSNW9tWWJWeUJCdGFNMzVTU3NTdW00d2ZUZDVDRXhuTFBm?=
 =?utf-8?B?REFQNmkyS0N2NFgyM1Jad3pwZjZCQjZjOXEwSW4wMUlaU3F0U1QzQ1JCTk5D?=
 =?utf-8?B?QXM0TVorRSs4VHk5bWxWNFFjdkNWQ1poVkdhR0VzVkVHcWpud1hRcHFjd0VG?=
 =?utf-8?B?NjNKd0RIT1ZqQXB0V2RWSUFQZWhHYmRwTE14YTNjRWN3TjZuaHJHY2Z5L20z?=
 =?utf-8?B?VWx1Ym5tUkxrQjBBSEQ2UDJlSHpJQm00OVh1SExXbjdieHZPaCtGMW8rNDRq?=
 =?utf-8?B?UHlodys5MWc4MDVRVUZzYjJyb1pWaldKUmkzSlJ3U0hmVWhqdzR4U3VxYTFs?=
 =?utf-8?Q?Q2CZZ12dgRxkJS0Q6DriGNi3EEuJ4nUH3rQyM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(38070700016);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OWtiMnhMRHgzTVh1Y05jRFk3U3Rua3JqZ3FXcWg0bkk4aFRqeXVKQ0lxTktO?=
 =?utf-8?B?a2YzSUJpcGhoOTRXUE9ncHFSUGthSTR6TS85Wm5yeU95U1kyOGV2UU5sdTg4?=
 =?utf-8?B?eGNOZTNnbk9BRCthbm1aUWYrejJUNFZzeTBjY01hd3JQTGpsRFJKaDljTmpS?=
 =?utf-8?B?RWFuVXhYM002d0NVL3lGSExEaVFYbGxSRU9sNFVCQUZlOERITHJVQnFodTBw?=
 =?utf-8?B?SFVHdi9lZnAyZDBLVWx2ZjcxVDVDMkYyY0UvRUtDUUV5SWZCT0kxaHZEZnE1?=
 =?utf-8?B?bWtzam1pSjFYZWQ3Z0xvRFlJam9rd2lIS3VxanBQUDY4ajZCUm9GNmpHdDRa?=
 =?utf-8?B?cEpsMFFxakd3c0hYUkIrK3ZHMC91VjJpN2FsZDVjNG5JSTVVZHdLSG4wMWVV?=
 =?utf-8?B?Rmh2K01JMDh1RFdMUTVXallleDVlcGhyRGp0M2lSeGUwaW9lTEFNemp0NzFn?=
 =?utf-8?B?RldGRUpvdmtMelloT3plZGhianNLWHdFMFpLWXhPcG5wbE40M1BPZ1NkN3Bx?=
 =?utf-8?B?bzBaWm1qQytFRmsxZEM3MzYxK3ErYlVnVnk4WjUyaGJJZ3ZEOVJLOW5mcTNB?=
 =?utf-8?B?L1pYK0kxMS9TWHFMMmRyMU5aZTlhbTlpaktLeTlaNnJVUVNDakJvcWpzcXFG?=
 =?utf-8?B?NzhieE1VbHlvbGdQZHVtQmhHQ1FybGgySDdraFIvM3F3Q0pxN1AzVGhRNVht?=
 =?utf-8?B?L1ROOFF3Zy9nRzRQZVRVanJrbktpQSsvTFJMYzdVVWlDLy8ybDBVMjF3S0tI?=
 =?utf-8?B?c2E0S0pOMHA1R3FNTkZVN2owdGxPSVptcUk4aWNRdmsxWUR6MmNLS2k0TUdx?=
 =?utf-8?B?M1c1eUFnamZjaUFqbmF1c2EzUWlhWFNISkFsWnRoKytqSjFoV2lBYVM2dTJy?=
 =?utf-8?B?Qnd2MWUwRmRaUWx4dzJ4Lyt3WjA4RHl1c3pLVDRpSWVTcVI4WnVmT2NrcUw1?=
 =?utf-8?B?Y0drbWY3NEZTSGRPcktoVFBPZTBiZGFZYk4zQ0RoZjcvd1BzL2ZjRUpIQzB6?=
 =?utf-8?B?a29kV1FtSWEzU1BQS0I5dnpJRjJzZDNQN1hRNWtEVmNpb04zZnh3Qi9aeWJ0?=
 =?utf-8?B?bVE4cmtDc01kRld1L25pM2xyMEVWKzZuUDMwaGcxdW85KzRQV1RNdVAvdUxs?=
 =?utf-8?B?eTFEbzFiV3lXc09BaVVsZTYydDhGUVVINlFpcThoQnBQcjljOWpybk5YRDZm?=
 =?utf-8?B?S1A5ZnhkZWY0bXd5ZnpjWjMvQUZhM0VuRzlsUzJZSkVCcHgwSFlnbyt3YVFE?=
 =?utf-8?B?TXVLNUxoMzZGaGRzMm13dTNMMmdKaHAvTmJnWThrNkpIZjZYNURFWUd5SjVB?=
 =?utf-8?B?ZVIwZHZ2OTJDN29BTktsWFl6U2lrNGg5VU9pV29PWXZCaXFKY281ZXhPeDF3?=
 =?utf-8?B?UisydHF5K3ZMK2JENVhNRXBQbTNzUFVwRzVYRkRVbHEwNVQ2ZnBLdEVqTkt2?=
 =?utf-8?B?L25QRUZvOGE1Q0djTi9UQ05rTEY4aHYxVlZBTUNLMGFtRndSNGF4Y0RFV2JP?=
 =?utf-8?B?djBJMlBWRnNWRHJCYlViSmtMYjJFenYzWE1DNE4vZytlRmJpd0szVEZVOWhj?=
 =?utf-8?B?Q0Q4NmJMRlZSMUNpSE9URXkzQ3Bza2N3b3pQVEE1L1gvbEhKL21nMmJmeVlT?=
 =?utf-8?B?QjJZaVBHMWRBZWo3K2ZyV1JwbEhHYWZvNjJ6TWh5VGFpRi9UWHMvZFc0c0Iz?=
 =?utf-8?B?eDN3NkZybnZNcm02eEFWT002Nkc3NDFNVWpQekhMdkRCSGNTbk1jVGV4T011?=
 =?utf-8?B?VmxNK01oempreEJJbllEaTVCU1hGNzc1OHpUai80NXBkSUV3YUdjbWtwMUNh?=
 =?utf-8?B?NVVXOC9USlMycWQrNXpVZ1Vhem9nQ1lRdE9jMk1XNXkzK0xad0I5MStEY3ha?=
 =?utf-8?B?cWRsUUZWMXBtQXFkWHo4cDR0aWsrenQ5S056Q295ZkExb0tDdjZLOHRKdm1C?=
 =?utf-8?B?bllzZGp4VVVFbDZ4TWg2ZzBBcUNReG5HNUtNRHFrSCszS2thMWZSeXJIUi9H?=
 =?utf-8?B?dlVsRHlhZ2gyZWZIcG1ybktVL2UzU0xqaUl6Sy9YT3U2SVdqU2g4VytrckU3?=
 =?utf-8?B?UUhsTjhVMHh1WXF1M0lnUXZrQUpKckNSSFZTWFdKWXdUdWlxZi9HMzVnM1Nx?=
 =?utf-8?B?amN0cTJUOVJvN0ZrcGpucmNjeERQMWgyalpsdXJhbEU5ZzZCdTBTbjF2QXp3?=
 =?utf-8?B?dXlERC9mVU8zVTNuK1lJZ3lZN0pBWlhPdkZlM3ZzWU5xNDNBWnl1NlhBOUpB?=
 =?utf-8?B?NHY0TnNsRGc5cEg5V1I1MjBibWlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A75FC8708478C64A9D549CB85F1CBEC1@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed8ca4a-5c79-46aa-0e16-08dc954233db
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 18:11:14.9566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9PTXJ5sSDbVHikzJCI2RUTAJg5oZn4cmZA2OUxbRZoxBLQu5kMXx21Mj7lEga28caz4maVsQhlBGsA4+tYaaD9E1a0OB7HxnWzz188CCaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7311
X-Proofpoint-ORIG-GUID: ZPS6LZxC-vGj_dMqyoSjanRcM8fKoxcM
X-Proofpoint-GUID: ZPS6LZxC-vGj_dMqyoSjanRcM8fKoxcM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_13,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gSnVuIDI1LCAyMDI0LCBhdCAxOjQ04oCvUE0sIFNhaSBLcmlzaG5hIEdhanVsYSA8
c2Fpa3Jpc2huYWdAbWFydmVsbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+ICBD
QVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNv
bT4NCj4+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjUsIDIwMjQgMTI6MTkgQU0NCj4+IFRvOiBDaHJp
c3RpYW4gQmVudmVudXRpIDxiZW52ZUBjaXNjby5jb20+OyBTYXRpc2ggS2hhcmF0DQo+PiA8c2F0
aXNoa2hAY2lzY28uY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pjsg
RXJpYw0KPj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+OyBQYW9sbw0KPj4gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
PiBDYzogSm9uIEtvaGxlciA8am9uQG51dGFuaXguY29tPg0KPj4gU3ViamVjdDogW1BBVENIIHYy
XSBlbmljOiBhZGQgZXRodG9vbCBnZXRfY2hhbm5lbCBzdXBwb3J0DQo+IA0KPiBJdCBpcyBiZXR0
ZXIgdG8gaW5kaWNhdGUgdGhlIHBhdGNoIGlzIGZvciBORVQgb3IgTkVULU5FWFQgZXg6IFsgUEFU
Q0ggbmV0LW5leHQgdjJdLiANCg0KVGhhbmtzIGZvciB0aGUgUmV2aWV3ZWQtQnkgYW5kIHRoZSB0
aXAgaGVyZS4gRG8geW91IHN1Z2dlc3QgSSBzZW5kIG91dCBhIHYzDQp3aXRoIGFuIHVwZGF0ZWQg
dGFnPyBNeSBhcG9sb2dpZXMgZm9yIHRoZSBjb25mdXNpb24uDQoNCj4gDQo+PiANCj4+IEFkZCAu
Z2V0X2NoYW5uZWwgdG8gZW5pY19ldGh0b29sX29wcyB0byBlbmFibGUgYmFzaWMgZXRodG9vbCAt
bCBzdXBwb3J0IHRvDQo+PiBnZXQgdGhlIGN1cnJlbnQgY2hhbm5lbCBjb25maWd1cmF0aW9uLiBO
b3RlIHRoYXQgdGhlIGRyaXZlciBkb2VzIG5vdCBzdXBwb3J0DQo+PiBkeW5hbWljYWxseSBjaGFu
Z2luZyBxdWV1ZSBjb25maWd1cmF0aW9uLCBzbyAuc2V0X2NoYW5uZWwgaXMgaW50ZW50aW9uYWxs
eQ0KPj4gdW51c2VkLiBJbnN0ZWFkLCANCj4+IEFkZCAuZ2V0X2NoYW5uZWwgdG8gZW5pY19ldGh0
b29sX29wcyB0byBlbmFibGUgYmFzaWMgZXRodG9vbCAtbCBzdXBwb3J0IHRvDQo+PiBnZXQgdGhl
IGN1cnJlbnQgY2hhbm5lbCBjb25maWd1cmF0aW9uLg0KPj4gDQo+PiBOb3RlIHRoYXQgdGhlIGRy
aXZlciBkb2VzIG5vdCBzdXBwb3J0IGR5bmFtaWNhbGx5IGNoYW5naW5nIHF1ZXVlDQo+PiBjb25m
aWd1cmF0aW9uLCBzbyAuc2V0X2NoYW5uZWwgaXMgaW50ZW50aW9uYWxseSB1bnVzZWQuIEluc3Rl
YWQsIHVzZXJzIHNob3VsZA0KPj4gdXNlIENpc2NvJ3MgaGFyZHdhcmUgbWFuYWdlbWVudCB0b29s
cyAoVUNTTS9JTUMpIHRvIG1vZGlmeSB2aXJ0dWFsDQo+PiBpbnRlcmZhY2UgY2FyZCBjb25maWd1
cmF0aW9uIG91dCBvZiBiYW5kLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxq
b25AbnV0YW5peC5jb20+DQo+PiAtLS0NCj4+IHYxDQo+PiAtIGh0dHBzOi8vdXJsZGVmZW5zZS5w
cm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0NCj4+IDNBX19sb3JlLmtlcm5lbC5vcmdfbmV0
ZGV2XzIwMjQwNjE4MTYwMTQ2LjM5MDA0NzAtMkQxLTJEam9uLQ0KPj4gNDBudXRhbml4LmNvbV9U
Xy0NCj4+IDIzdSZkPUR3SURBZyZjPW5LaldlYzJiNlIwbU95UGF6N3h0ZlEmcj1jM01zZ3JSLVUt
DQo+PiBIRmhtRmQ2UjRNV1JaRy04UWVpa0puNVBranFNVHBCU2cmbT1JSVdjcWszRS0NCj4+IGFK
OGc0RXRwaklDOUpnXzJUMzdPcG5jZVk4bXdBSXVXRUJteUdHOXRIS2FRcDFyQWdENV9fMksmcz1o
VFJZDQo+PiBmVEFRQjlUbGktM0RiS29UUWtySjJPeFRCYWItUnFjS0lKVWpRVGMmZT0NCj4+IHYx
IC0+IHYyOg0KPj4gLSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBQcnplbWVrIGFuZCBKYWt1Yg0K
Pj4gLS0tDQo+PiAuLi4vbmV0L2V0aGVybmV0L2Npc2NvL2VuaWMvZW5pY19ldGh0b29sLmMgICAg
fCAyNyArKysrKysrKysrKysrKysrKysrDQo+PiAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9u
cygrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2lzY28vZW5p
Yy9lbmljX2V0aHRvb2wuYw0KPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jaXNjby9lbmljL2Vu
aWNfZXRodG9vbC5jDQo+PiBpbmRleCAyNDE5MDY2OTcwMTkuLjU0ZjU0MjIzOGI0ZSAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Npc2NvL2VuaWMvZW5pY19ldGh0b29sLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Npc2NvL2VuaWMvZW5pY19ldGh0b29sLmMN
Cj4+IEBAIC02MDgsNiArNjA4LDMyIEBAIHN0YXRpYyBpbnQgZW5pY19nZXRfdHNfaW5mbyhzdHJ1
Y3QgbmV0X2RldmljZSAqbmV0ZGV2LA0KPj4gcmV0dXJuIDA7DQo+PiB9DQo+PiANCj4+ICtzdGF0
aWMgdm9pZCBlbmljX2dldF9jaGFubmVscyhzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2LA0KPj4g
KyAgICAgICBzdHJ1Y3QgZXRodG9vbF9jaGFubmVscyAqY2hhbm5lbHMpIHsNCj4+ICsgc3RydWN0
IGVuaWMgKmVuaWMgPSBuZXRkZXZfcHJpdihuZXRkZXYpOw0KPj4gKw0KPj4gKyBzd2l0Y2ggKHZu
aWNfZGV2X2dldF9pbnRyX21vZGUoZW5pYy0+dmRldikpIHsNCj4+ICsgY2FzZSBWTklDX0RFVl9J
TlRSX01PREVfTVNJWDoNCj4+ICsgY2hhbm5lbHMtPm1heF9yeCA9IEVOSUNfUlFfTUFYOw0KPj4g
KyBjaGFubmVscy0+bWF4X3R4ID0gRU5JQ19XUV9NQVg7DQo+PiArIGNoYW5uZWxzLT5yeF9jb3Vu
dCA9IGVuaWMtPnJxX2NvdW50Ow0KPj4gKyBjaGFubmVscy0+dHhfY291bnQgPSBlbmljLT53cV9j
b3VudDsNCj4+ICsgYnJlYWs7DQo+PiArIGNhc2UgVk5JQ19ERVZfSU5UUl9NT0RFX01TSToNCj4+
ICsgY2hhbm5lbHMtPm1heF9yeCA9IDE7DQo+PiArIGNoYW5uZWxzLT5tYXhfdHggPSAxOw0KPj4g
KyBjaGFubmVscy0+cnhfY291bnQgPSAxOw0KPj4gKyBjaGFubmVscy0+dHhfY291bnQgPSAxOw0K
Pj4gKyBicmVhazsNCj4+ICsgY2FzZSBWTklDX0RFVl9JTlRSX01PREVfSU5UWDoNCj4+ICsgY2hh
bm5lbHMtPm1heF9jb21iaW5lZCA9IDE7DQo+PiArIGNoYW5uZWxzLT5jb21iaW5lZF9jb3VudCA9
IDE7DQo+PiArIGRlZmF1bHQ6DQo+PiArIGJyZWFrOw0KPj4gKyB9DQo+PiArfQ0KPj4gKw0KPj4g
c3RhdGljIGNvbnN0IHN0cnVjdCBldGh0b29sX29wcyBlbmljX2V0aHRvb2xfb3BzID0gew0KPj4g
LnN1cHBvcnRlZF9jb2FsZXNjZV9wYXJhbXMgPSBFVEhUT09MX0NPQUxFU0NFX1VTRUNTIHwNCj4+
ICAgICAgRVRIVE9PTF9DT0FMRVNDRV9VU0VfQURBUFRJVkVfUlggfA0KPj4gQEAgLTYzMiw2ICs2
NTgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGV0aHRvb2xfb3BzIGVuaWNfZXRodG9vbF9vcHMg
PSB7DQo+PiAuc2V0X3J4ZmggPSBlbmljX3NldF9yeGZoLA0KPj4gLmdldF9saW5rX2tzZXR0aW5n
cyA9IGVuaWNfZ2V0X2tzZXR0aW5ncywNCj4+IC5nZXRfdHNfaW5mbyA9IGVuaWNfZ2V0X3RzX2lu
Zm8sDQo+PiArIC5nZXRfY2hhbm5lbHMgPSBlbmljX2dldF9jaGFubmVscywNCj4+IH07DQo+PiAN
Cj4+IHZvaWQgZW5pY19zZXRfZXRodG9vbF9vcHMoc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldikN
Cj4+IC0tDQo+PiAyLjQzLjANCj4+IA0KPiBSZXZpZXdlZC1ieTogU2FpIEtyaXNobmEgPHNhaWty
aXNobmFnQG1hcnZlbGwuY29tPg0KDQoNCg==

