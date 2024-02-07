Return-Path: <netdev+bounces-69780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4F984C90C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 11:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47721F21571
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D6D1757E;
	Wed,  7 Feb 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="iFQt6ht9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0A175A6
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303422; cv=fail; b=G5po6SuX2S7FqViG7gTMLVCbL2BCd66X9trUSaJUKn6vbfFCdg3/OVrFmH6BXHJ3I4fJP8so2Xr0VeGuxAK9GvdBbs5T4HLxrkhDcthStWYF8g4uOKfWR9FrkcHBMl7u82ZWuhrE0bZ+O3zPfNodeqrc8VKIrDWTACfdkeFtZnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303422; c=relaxed/simple;
	bh=p9NnZ2s3Tlc82S2CFFGipsgTHZdKIsUtRA2ZuO1a27I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ea6Ay1wKao+FElUCkrM3vvtbvo4nGOYC6WUu12Hy5eopou6RFyiI9iqZ3SVG6hrit/9uT3X/AmPjqQ8E8axCOrqZLkJAAIcOc733vzUXlcBKT44jtM3sjUNVotdUEyn0PTII8xlL2PAUErHYJAUusIgxMvyOUVXeSrad5yAz7ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=iFQt6ht9; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4178gKfT005264;
	Wed, 7 Feb 2024 02:56:56 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w46k7rd41-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 02:56:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAiLKD/5nX0XwtTt+lcAjQ928G3YIGwZ7WnQGeeJQ+doQ2bgLks6mwlhbxyfbLuVGt+C64fE9B/FjQNrdnA5eKxPUSDpDR5icOjWZb/mRpVqpLFJaWsgQ/nIe+Bvtb58lkiwBTnDwi0q3ArVEftLNIYBNLFtyjLwChR3WDm91YOX/9dbawuHy2zPz8wHYfALUhl+QyiWNaacAMFKdqnIWr03D3fZPK6pFLjtIpN+I7UWkCVVq5ki1ZXuS+Cl+DE9ddVLA5GwKlO5PQE8Tt2R2H9BILcTDDDIor1nViAY25WgSB0b0agEEM+XCpY/dVKRL15sSYmeWKvd9TGepmOitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9NnZ2s3Tlc82S2CFFGipsgTHZdKIsUtRA2ZuO1a27I=;
 b=ntanhby0pkQMHLlqVzjAt1ob6/tYHEE7nrrdYBCAsvdsaVAvP5k9ceQ+iNjZ0f0qrDy8TVSZPAFsFEcBJBLGw0kMBdToiLW8cK30G8jZMhwl6RrE5q1bVyS51HAlHx0X0aqCvR29GjuiiSSwjUJY1+DTM+/5C/Z8e9HY7griCRkkpyM+b0X4E5cgMVY4M+0NRfVAYFEc8VlkQbyL2FtCJG7Wf57Gx+LjtDXd4dWLJcFhJFlzJKIWa1XQPLTFEiZcFLoVMyWMKg3mspMR6fId4wqQ2A23WLyyQJLRfJumz3txgi45vhgOu6TxtkA0aqDHlU2WuNQ0xLwlVcnQhb30LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9NnZ2s3Tlc82S2CFFGipsgTHZdKIsUtRA2ZuO1a27I=;
 b=iFQt6ht94Ay30hRpBG4Emnz0Svzb2MmRJ2h7KsnORYAi2/CFXShCQBCiRqaXhNXrOmgIjKO+2VjRUA2gjEY+ezfdxNm7zYAFYHfR2IdoAZx+r/3y2/uiR/DOX7w1XOyCDcI2JwLoQlDExbl1TYQyjbxzltdZUjD4OAlcaJ9DAc0=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by PH0PR18MB4875.namprd18.prod.outlook.com (2603:10b6:510:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 7 Feb
 2024 10:56:30 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::9b7a:456c:8794:2cae]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::9b7a:456c:8794:2cae%4]) with mapi id 15.20.7249.038; Wed, 7 Feb 2024
 10:56:29 +0000
From: Elad Nachman <enachman@marvell.com>
To: =?utf-8?B?S8O2cnkgTWFpbmNlbnQ=?= <kory.maincent@bootlin.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Taras Chornyi
	<taras.chornyi@plvision.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: RE: [EXT] Prestera driver fail to probe twice
Thread-Topic: [EXT] Prestera driver fail to probe twice
Thread-Index: AQHaWRTVYbeYsqk58kW66MDvCmD52rD9oddwgAELHICAAAjz0A==
Date: Wed, 7 Feb 2024 10:56:29 +0000
Message-ID: 
 <BN9PR18MB42510F2EA6F4091E5CA3B409DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240206165406.24008997@kmaincent-XPS-13-7390>
	<BN9PR18MB42519830967969DEA4E329EFDB462@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20240207112231.2d555d3e@kmaincent-XPS-13-7390>
In-Reply-To: <20240207112231.2d555d3e@kmaincent-XPS-13-7390>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|PH0PR18MB4875:EE_
x-ms-office365-filtering-correlation-id: 1a115632-17db-4c31-c363-08dc27cb7082
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 z9JrOi0UWSddvW94ufYMBir9p84o4g3akm3+4fbSCQnDvHshgzQIIfCNkcmKUUrIZifT8T5Aa5icDYr4lP02ztobEqGVZsLYVIJbaUt+ANjnhQhOXZ4XR7/yK5h1VOSvyXwZa56wL9YrdgE6ZKERbGwDQ0uU8GuzmBZ+tJ/j/yaoBvJXcS31yGylta5SF90XDIPHZxRHrMj9NwWphG0bLGdD+hIGF4rgXYOBzvZvbxCif8nVI8+6BaOwD7zEmp3CcwgPvkB3DJRcQmdkc0it53AP8XKrfSxPz+QLH8yWWzk18bsg8JNrRpPRq0LqY4fNrm+BLRTKDnMgfl2bktv5s/wTlXMDNutEVrXpthNEFRfmf8uyTBJL+FEQq3KcFSAm4EfgGPqATimOcmyOS39/jVsYBk/LNmP2IdZgLnu9E+J7+CdFQJFfMfY24jevliSA++u1mEIZAWx4sDjrsb6+mPJSpyQWuoGB0YWMNFxokRki1dzUuqFfETRM1nIyaEWB82UxZG6JI237P0bt49ZnXIIR44xxgdspD+k9J0w3ohPEYgWb2RtRCUm43DPB2xS+8g2+iqpP6m6mdrkcRksdSJ/Ml8axXcJ/1fmcqbeDuS8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(966005)(76116006)(66946007)(64756008)(54906003)(6916009)(66556008)(7696005)(53546011)(6506007)(9686003)(66476007)(478600001)(71200400001)(66446008)(316002)(33656002)(8936002)(8676002)(4326008)(38070700009)(122000001)(38100700002)(26005)(86362001)(66574015)(83380400001)(5660300002)(52536014)(2906002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SXErQUFVLzVCNEF5bHFwQVlmVk13eVp3VTJheDNKV2JGUlVTek03dXIzK3Fp?=
 =?utf-8?B?c3l6UlFQWnROMXRFUmhHSEhZSzd2dWJVT2d5T3dKVWtnOEM1c1lLaHMxb3ZY?=
 =?utf-8?B?bVZmT2krSTBrU1NSdEdIeGxzbllPNlBNNkNyTWpNZVFGZm0vcXhxZDA5UUJ5?=
 =?utf-8?B?RjRBSlJuT3ZndmlWM3JJSkdjSUhsQmNTRzFyVXdYdWdxU2VTUlZLcU41b0I0?=
 =?utf-8?B?dnVlOVJlbE1UTjVDaHU1cWdSOEgxNTFuV0FicmJsVW1WR0lOME11VDdCKzU0?=
 =?utf-8?B?M3V5dm43UjlQaU8vWERqWWdHeTNNenpLWFBHOUJJZ0NudUFaZnVBMmp1aVli?=
 =?utf-8?B?ZFFYNmlpdkI5endnUEJpVHBETlhxRjhrWmhhbU5MVkdrRnZTZWdaSG5ieERL?=
 =?utf-8?B?bEt5TGtkdXB1SFJGUHVSTmJld0tLQ0FjazJGc0ZseDl1NWJ3KzFvZ3BIYVhG?=
 =?utf-8?B?SjZ4NEJxbC9VYTl6RTR6eTVmN3Evc3FhVVlnUDZOY2NjSFlTUEJTU2VheEk4?=
 =?utf-8?B?Y3FwaVFRVXpqRitPRHQ0U1JEZkpSc0FQWThUNlNlck5jWVRyZ2FQL2pJRCti?=
 =?utf-8?B?RG9BdmxIVlZpWnJnSTR3WWk2WnRCVXNtcVc4eWIzUFQzUG41cmJIUmlUcmdk?=
 =?utf-8?B?K3BwMlA4bGp6MDNwZjcyMWlueGlQVGMzb08yMlZXUnlKbU1mZFNnS1lveU9k?=
 =?utf-8?B?bFpTRzRsbmJRUHV5Tzc1ZUhRazRQdnRPRVRmSGdMT0Z5QVRJNENNK2hCM1l4?=
 =?utf-8?B?dHFtSmRVV3ZmaTF1WG1UWm91OVZTM29ob095enVLL1JTUk9GNGkvcWNlcUJ6?=
 =?utf-8?B?ano1ZG1jZ1ZoWm5MMS9DOGo5djQwa1oxT293a1pPVmFWSXBOdHVLTkxpMzhZ?=
 =?utf-8?B?MHQxcWR6ZXVSQ1dHdnhKdHNTRHVzRnVxejVpYzVJRkdVY2JjVFdkdVphZlpT?=
 =?utf-8?B?dWsrR1lIdzFicXp2eFhqdmZqaFdvcFhyUkgvcjJjV2ZyeHlEamhLYWVnOGI4?=
 =?utf-8?B?a3c2TEFqNnc2czR3TnRYcWp5ZjR0UjlGWFdUcGNtREhrOU9lVlVKWFBLR3d3?=
 =?utf-8?B?Q29zSDI3Rm0xK1VnaUQwZXJFRFhIRklPckRXUVhiZFRJOWhKeG1jd0R0cVZP?=
 =?utf-8?B?QkVxU3BJYXlXVVB2eWdnOGVzM3pKQm9HZGJybEJnYXl3N1JMTER5WElUaVl2?=
 =?utf-8?B?SE4xWkkxZisySGVIY3h2SHZhN3R1bjFhZ3ErVyswaVZmNmZWTFluaDMvQUJ6?=
 =?utf-8?B?Yk1XZ3p4eXpjMHl4RHNrWGFMakw5QVZTczFNVDl3blZCS0h0dFFlNTlPT1B4?=
 =?utf-8?B?RHl2MElsekJZSlJxNFROVE43RS9pdGUwOS9EMTAxd1RDQjJMRWlOU1VYcklG?=
 =?utf-8?B?a0lZeDU0Y2ZSZEt3R0NvRDUyYWIwN0paQU8vczdLMlpZbUVOZUdZaWhaWjhH?=
 =?utf-8?B?Vk42U1RkTGN4NDBpWS9kZ2pGWm1TNGxaZ1orTk1YNG1aaXgvRytwZkNwVXBJ?=
 =?utf-8?B?TmNBeWlEVDBOM04rWExBV1hKeUQ3UjZJOWJvOFRiODA0Q2FQSm9sczNyTUZa?=
 =?utf-8?B?ZVh5OTFSd1RMM1loYnFTSHZ3QVV3dXJwOWVDakN0WXQyeUZiZ0RRcW13Qmc3?=
 =?utf-8?B?Y2lDTm9iemNadS9IelVQSm1nWUhqQ2c1bklwTDBNUGZObnJHTWFmdUxQQi80?=
 =?utf-8?B?MENJVXVyLzlyZzFMWGdCSjA2TEM2aDhsN0djSWlkaFdZTHBnSWxBeHpMR1Yy?=
 =?utf-8?B?andWRzJpeFpZdEthK3JEbFh6enJVR2dmdWVET1pmMUE3WHRMWVZRSTc1a1dC?=
 =?utf-8?B?NG9FSXZlZ3dEbFZ4djhtdE5XSWF5aWoyMVMyc0dJS3hQVVRsemJBaEJjbHVD?=
 =?utf-8?B?czRHQTVWditsd0hqOFV4NGcxaTJBWGdQRUNpdDNTTW1ya1Jrb2gyczg4MFpl?=
 =?utf-8?B?eFpsVUxqNGhsL3lnaCt6RDd6VVJxUEFsd0YyYWF2VC9yNk5reG1Cd2xieDZ0?=
 =?utf-8?B?KzZnRERWWEd4L3M4Zm55SlJ5VG1yLzVFbzhBWlB0UlBDcWcvNG9UQ1piWito?=
 =?utf-8?B?MlJVVlBoaDBoRkNwZHVEalRPM2c2U3BKbnkwdjNkc2F4bkZ2R2VtZkkvU1ly?=
 =?utf-8?Q?ZXEtzL79ryW/pHBQ43A/BNVFj?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a115632-17db-4c31-c363-08dc27cb7082
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 10:56:29.8741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6j5mg1OG+gR3MyyLMXd5lr8luunLcz6oPARa0ur/XzkgD+QXw2P6R6MpiKJdzSQHAl9aOz9MWHnSQysYlY3c9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4875
X-Proofpoint-ORIG-GUID: D2Ic7dZq1N2_azRhDWoPZ2gELEf-ixVK
X-Proofpoint-GUID: D2Ic7dZq1N2_azRhDWoPZ2gELEf-ixVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS8O2cnkgTWFpbmNlbnQg
PGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkg
NywgMjAyNCAxMjoyMyBQTQ0KPiBUbzogRWxhZCBOYWNobWFuIDxlbmFjaG1hbkBtYXJ2ZWxsLmNv
bT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IFRhcmFzIENob3JueWkgPHRhcmFzLmNo
b3JueWlAcGx2aXNpb24uZXU+Ow0KPiBUaG9tYXMgUGV0YXp6b25pIDx0aG9tYXMucGV0YXp6b25p
QGJvb3RsaW4uY29tPjsgTWlxdWVsIFJheW5hbA0KPiA8bWlxdWVsLnJheW5hbEBib290bGluLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtFWFRdIFByZXN0ZXJhIGRyaXZlciBmYWlsIHRvIHByb2JlIHR3
aWNlDQo+IA0KPiBPbiBUdWUsIDYgRmViIDIwMjQgMTg6MzA6MzMgKzAwMDANCj4gRWxhZCBOYWNo
bWFuIDxlbmFjaG1hbkBtYXJ2ZWxsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFNvcnJ5LCB0aGF0J3Mg
bm90IGhvdyB0aGlzIHdvcmtzLg0KPiA+DQo+ID4gVGhlIGZpcm13YXJlIENQVSBsb2FkZXIgd2ls
bCBvbmx5IHJlbG9hZCBpZiB0aGUgZmlybXdhcmUgY3Jhc2hlZCBvciBleGl0Lg0KPiA+DQo+ID4g
SGVuY2UsIGluc21vZCBvbiB0aGUgaG9zdCBzaWRlIHdpbGwgZmFpbCwgYXMgdGhlIGZpcm13YXJl
IHNpZGUgbG9hZGVyDQo+ID4gaXMgbm90IHdhaXRpbmcgRm9yIHRoZSBob3N0IHRvIHNlbmQgYSBu
ZXcgZmlybXdhcmUsIGJ1dCBmaXJzdCBmb3IgdGhlDQo+ID4gZXhpc3RpbmcgZmlybXdhcmUgdG8g
ZXhpdC4NCj4gDQo+IFdpdGggdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gd2UgY2FuJ3Qgcm1t
b2QvaW5zbW9kIHRoZSBkcml2ZXIuDQo+IEFsc28sIGluIGNhc2Ugb2YgZGVmZXJyaW5nIHByb2Jl
IHRoZSBzYW1lIHByb2JsZW0gYXBwZWFycyBhbmQgdGhlIGRyaXZlciB3aWxsDQo+IG5ldmVyIHBy
b2JlLiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgYSBnb29kIGJlaGF2aW9yLg0KPiANCj4gSXNuJ3Qg
aXQgcG9zc2libGUgdG8gdmVyaWZ5IHRoYXQgdGhlIGZpcm13YXJlIGhhcyBhbHJlYWR5IGJlZW4g
c2VudCBhbmQgaXMNCj4gd29ya2luZyB3ZWxsIGF0IHRoZSBwcm9iZSB0aW1lPyBUaGVuIHdlIHdv
dWxkbid0IHRyeSB0byBmbGFzaCBpdC4NCg0KRXZlcnl0aGluZyBpcyBwb3NzaWJsZSwgYnV0IHRo
YXQgaXMgdGhlIHdheSB0aGUgZmlybXdhcmUgaW50ZXJmYWNlIHdhcyBpbml0aWFsbHkgZGVzaWdu
ZWQuDQpDaGFuZ2luZyB0aGlzIHdpbGwgYnJlYWsgY29tcGF0aWJpbGl0eSB3aXRoIGJvYXJkIGFs
cmVhZHkgZGVwbG95ZWQgaW4gdGhlIGZpZWxkLg0KDQo+IA0KPiBPciBzdG9wIHRoZSBmaXJtd2Fy
ZSBhdCByZW1vdmUgdGltZSBhbmQgaW4gY2FzZSBvZiBwcm9iZSBkZWZlci4NCj4gDQo+ID4gQnkg
ZGVzaWduLCB0aGUgd2F5IHRvIGxvYWQgbmV3IGZpcm13YXJlIGlzIGJ5IHJlc2V0dGluZyBib3Ro
IENQVXMNCj4gPiAodGhpcyBzaG91bGQgYmUgY292ZXJlZCBieSBDUExEKS4NCj4gDQo+IEFyZSB5
b3Ugc2F5aW5nIHRoZSBvbmx5IHdheSB0byBzdG9wIHRoZSBmaXJtd2FyZSBpcyB0byBzaHV0ZG93
biB0aGUgQ1BVPw0KDQpZZXMsIHRoYXQgaXMgdGhlIGN1cnJlbnQgZGVzaWduLg0KDQo+IEFzIGFz
ayBhYm92ZSwgY2FuJ3Qgd2Uga25vdyBpZiB0aGUgZmlybXdhcmUgaGFzIGFscmVhZHkgYmVlbiBs
b2FkPw0KDQpPbmNlIGFnYWluLCB0aGlzIHdpbGwgYnJlYWsgY29tcGF0aWJpbGl0eSB3aXRoIGJv
YXJkcyBkZXBsb3llZCBvbiB0aGUgZmllbGQuDQoNCj4gDQo+ID4gQ2FuIHlvdSBwbGVhc2UgZXhw
bGFpbjoNCj4gPg0KPiA+IDEuIFdoYXQga2luZCBvZiBIVyAvIGJvYXJkIGFyZSB5b3UgdHJ5aW5n
IHRoaXMgb24/DQo+ID4gMi4gV2hvIGlzIHRoZSBjdXN0b21lciByZXF1ZXN0aW5nICB0aGlzPw0K
PiA+IDMuIFdoYXQgaXMgdGhlIGRlc2lnbiBwdXJwb3NlIG9mIHRoaXMgY2hhbmdlPw0KPiANCj4g
SSBoYXZlIG5vIHBhcnRpY3VsYXIgcmVxdWVzdCBmb3IgdGhhdC4NCj4gSSB3YXMgZGVidWdnaW5n
IGEgUG9FIGNvbnRyb2xsZXIgZHJpdmVyIHRoYXQgdGhlIHByZXN0ZXJhIHdhcyBkZXBlbmRpbmcg
b24sIEkNCj4gd2FzIHBsYXlpbmcgd2l0aCB0aGVzZSBpbiBhIG1vZHVsZSBzdGF0ZSB0byB2ZXJp
ZnkgdGhlIGtyZWYgZnJlZS4NCj4gDQo+IFJlZ2FyZHMsDQo+IC0tDQo+IEvDtnJ5IE1haW5jZW50
LCBCb290bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBrZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0
cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fYm9v
dGxpbi5jb20mZD1Ed0lGYVEmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9ZVRlTlRMRUs1LQ0K
PiBUeFhjempPY0tQaEFOSUZ0bEI5cFA0bHE5cWhkbEZyd1EmbT1waVdoNEZUX2VoT1NCaDY2LQ0K
PiBXUG9veXRvdWhLV3N6Tm1oY21abnRDV3BYU04tDQo+IGJVUUs4UnRzMWZMVGFzYnFGbHUmcz1G
NExlN1RPS0tsZVpNT1lKV1F0VmJVT1psWFJoOVRlSzlKUF9oTEREbG4NCj4gYyZlPQ0K

