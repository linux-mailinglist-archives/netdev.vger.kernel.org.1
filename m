Return-Path: <netdev+bounces-69867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE69584CDA4
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 641B2B237B1
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F32B250F3;
	Wed,  7 Feb 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="U1hFDIjV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506937E762
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318422; cv=fail; b=gNliFH3CUn29y/gQXE0FFhEddDAXssDpOO9ujeFBuwFUSDj4+tM8ZMkms3nHM9wSlWbDXbM385d8VQhLC6POta5+psoZZtap9dnlC00s5gjbk/qbOB0+jwQ7205+h6VwUbV8RKyJCvoGeFbG3WeDyBSKvK99mOR0jmcv2tm0xzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318422; c=relaxed/simple;
	bh=aVItEUHLqWLnwmAnhbX03BbwCqaDnt8BTasyi/xpYnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aO8/y2nqgaWl+Q5uW8Oe6edcPF0dw6qDUkzQkcZmMnTbq2g4Wh8Miyi9HlgeY7Gk0zRpxL3p9Nd6w/snj8ybR2V5gM2KhyAmEOMDYaMyalw+08aMcpbBydUxmZqrlwfh4mIMA6lcVaFr4kNafNY9kjotbRKcbPm+3CKfqn9RKVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=U1hFDIjV; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417Bq75p001478;
	Wed, 7 Feb 2024 07:06:57 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w46k7sasq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 07:06:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYS2ri8osBx3SIVv+h5fZ2HOaytmvJhp7ZhVZtSiyewgANy7l1ydErWQabzJYxzFvg2Ov9wbowdlR61x3oQ/uIp3xoM0/adE28WspKlaTM0TqSYeYc/YJWXENSB1x0mcj9mleOHX8TPmgInRwGnZ5e9y9WCQd6c1mt5838gVK9OoLIRdm2IxiyPKzL7bzBU+6cXLEyYj500YdlLXeHDJZ2zJEj+Nfn9eQYR7I1/wJHkdrRuEn8LAApvIcXZJ+TpxdwyGkwDvcRfAM3mJT9uLiX3j8NetUBHuVJzpDkuZlmur/f0WVVDUGZdMjcioorikejH/FgPDnUa2wCUFtrrnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVItEUHLqWLnwmAnhbX03BbwCqaDnt8BTasyi/xpYnw=;
 b=nDRFtvP0/imIMjwox8aZLxIyYcory9nYHAY5uKai6XNCBpR/XcmFQ6ejPj8xf8lzvTWzvX87XM+BQAGueyiI6faO2qeT/j3njV0H6MWYLHB+FCmraHi29GkxVIGzgQbffWRZ6Ls6fFfvBoviOdk7Sz4FXIWxNG+HV+C6F116Yn2ZpqKcpvT2ux/JV0NMHXTbTbF7WUUlpqXWC/aISSNTaibfNRxTet/8bCBo5eeIjNqXh416ZvYNFa6Z8zCWzGhJDzV1NrLvjbLqbqaOWiPRQgEYg+Bd/OgeJ8fqtCmtUdzLyP4KEe/ed4Uci9+Px7JRXvpmH4AY40ZVkxrBzpRkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVItEUHLqWLnwmAnhbX03BbwCqaDnt8BTasyi/xpYnw=;
 b=U1hFDIjVQXJPpkihnu71KXH5U0nyAxcGQudALfjt1LK8BW6mec/Zxg3AE72Ve6mNsDi+B3sDHNP/n4tjHH344tyEcDkd24PKbUQRGTmXNgiz91jgH7hmHSTkU12mmGELHyeTTBvNARIYwxttcvKpBYr/FMX8greS2vSMu5+MnR4=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by CH3PR18MB6027.namprd18.prod.outlook.com (2603:10b6:610:1e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 15:06:34 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::9b7a:456c:8794:2cae]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::9b7a:456c:8794:2cae%4]) with mapi id 15.20.7249.038; Wed, 7 Feb 2024
 15:06:34 +0000
From: Elad Nachman <enachman@marvell.com>
To: =?utf-8?B?S8O2cnkgTWFpbmNlbnQ=?= <kory.maincent@bootlin.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Taras Chornyi
	<taras.chornyi@plvision.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: RE: [EXT] Prestera driver fail to probe twice
Thread-Topic: [EXT] Prestera driver fail to probe twice
Thread-Index: 
 AQHaWRTVYbeYsqk58kW66MDvCmD52rD9oddwgAELHICAAAjz0IAACYYAgAAPF/CAACQIAIAACMZg
Date: Wed, 7 Feb 2024 15:06:34 +0000
Message-ID: 
 <BN9PR18MB42516CB6F1DA53D8BAD47B17DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240206165406.24008997@kmaincent-XPS-13-7390>
	<BN9PR18MB42519830967969DEA4E329EFDB462@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207112231.2d555d3e@kmaincent-XPS-13-7390>
	<BN9PR18MB42510F2EA6F4091E5CA3B409DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207122838.382fd1b2@kmaincent-XPS-13-7390>
	<BN9PR18MB4251F1904C5C56381FE976C4DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20240207153136.761ef376@kmaincent-XPS-13-7390>
In-Reply-To: <20240207153136.761ef376@kmaincent-XPS-13-7390>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|CH3PR18MB6027:EE_
x-ms-office365-filtering-correlation-id: 3a4f45b0-9121-4f15-5dec-08dc27ee5fdc
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OMYWUr4QdSaOXXXA5nuktXqcLDAxoxNCjVxILJ9VNgWPX26csDhbFKvkijgPFTxNSZD7KVm9ygacer4IhI2Qo/wewa7076IfTOseWsDUs11Xcyc+P2Z9ORsM5Vg/v4jHHZFxr8VSW7kWcHyBuAkde0iZYCejeSq+8v/A8qLDbVtJcOYOgg3V7WPcWiKkFQ4di0ungdZp0SZE1bLxS0940WeMC8dmtS44LLq1hCxUCHkLhZjGbo4uzt3skVodKKznE8f+BSMQnrw1oIKR0LsOd37YnLzjbjytcQTiXpTSLYntOUeMTV00KGn7OTxx1rrYuFcBKVY1+bwg+lD67qaTBVuk7Oa8DyEat9Oyuq2H9oBp9IyYRFM6r5qa9KAS5rIUEm6aGsD1CuviEAcb1lpdofabIG5qK/s6mSnLS80FZ48Kh6vtegi4m++W3hxk/CfLDyzFZaJw2+VdRTzIkiuy5N2ckrG1BR+ychzNbwQhPmO65V3yw2wkKtsddHJ9NktpaNA6GTxL+6JrZUOrOijEJopBP92qVxG/SGmVYXFOOvJEfijlXB9r+ZOiuTz8fcAtmQq3S1nVFurm+tfQQDWyicWNnXOQCKMiEdwTyKCOewk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(5660300002)(52536014)(55016003)(41300700001)(83380400001)(26005)(122000001)(38100700002)(66574015)(86362001)(6506007)(7696005)(53546011)(33656002)(316002)(9686003)(8936002)(66446008)(478600001)(71200400001)(66556008)(966005)(54906003)(64756008)(66476007)(6916009)(19627235002)(66946007)(76116006)(8676002)(4326008)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TmN2TDR3NGRaL1B0MWlnWGJBMU1SQ3hhTS81UmlWQjF0RGkzWXhET2E1MGcy?=
 =?utf-8?B?dGtjV2VqamFEQ0dxV25OUUFKUU9vdlpBclBZTzVINmtndUswMGlDb0k5MmVI?=
 =?utf-8?B?a1d1ODFJdFM4RnlKMjdUbUw3eVRhM1g5UDlqQW5xVm9IK3EySkRjSE5ndDM3?=
 =?utf-8?B?dGpCZkxhNnYwRnJLWkJYWStXTTRHbVJNM2FCZnVtZXNIdDJyaWk4d0R1bzQx?=
 =?utf-8?B?K1dYUS9mS2tjTUhFeEczQm1tSjhFalQ4SjZzL0x3V3pkMUMzUmtlQVdCRGI4?=
 =?utf-8?B?aGo4MXFkU0EyYkQ3aWFKQlBGbjdObDZ0VUNvdGhQcWVpUm1KZFlOb2ZzanFI?=
 =?utf-8?B?U1hDdGZNaGdqWk9jYUJuZlZRK3ZHSjV0ZnR3bEtjOVJYKzF6aEdqWmNkVU9n?=
 =?utf-8?B?ZEl4dHJCZ3FyOWpOOFNsL3NCSDN0QWovbkFUWG1DKzUvTkVkbkN2ZVVEaW9R?=
 =?utf-8?B?SzgwNUhUd2xJbXI0U0x5Vm5TVkFjZ0Q3S2xQVXBaWHBrd3dvOFExR1dmcGlV?=
 =?utf-8?B?a2czSWlBZHRkZGh3S2hKQ0pwTS83QnNpNDdpUnh6enFoTnhxbWM0djJPdTFm?=
 =?utf-8?B?bDRyOUFodDcwNjg4ZnladHZnOWN1aEpGcHJ1TTJnMmY1bDUzOGgvTDhWNVNw?=
 =?utf-8?B?Z3lReTJzVElpaEo0UEdKY2dTVHh0NlJXdGtLZWNaekRJcjdKeUdQS0RhZE1R?=
 =?utf-8?B?ZDI5NDRmWk9ldU5ac2V3NHhBWHl4ZW5VZVVZdWlLT3g2VFlZVE03ckJLUFc1?=
 =?utf-8?B?cVgwNDBBbGZGMWVyeEpEbU1QbXBHTXhsRXduK0dYQWhtME81Z01GbGxqOXNP?=
 =?utf-8?B?T3pVb0kvTE5STFhiUzlZOEtUWExReEh1amFtYXJjcmwzNHoxeHVEaW8yWjRX?=
 =?utf-8?B?NitOdGFYUTJZT21OZWlLbENjUE1WTXQ2aFJSajVGRmFCTXNaVWNWVS9paEZv?=
 =?utf-8?B?VTljSlBoLzAwS280Qm84OVhlTFNZTjFYdG43OXJ6RzV4dVZQc1NpM2NHeWNR?=
 =?utf-8?B?MHpJRGJaaU5PNlpaWnhaSnc5ckVBamp4MnQ1WSsxSUFQdWEva1oxNDFtZXF4?=
 =?utf-8?B?SEJzMnlCWjV3SEdjR0FSQXg3dkEyOVg4TVFJRFhORFZUNG1QcnBFRzR3OUtG?=
 =?utf-8?B?K0hTbUt3dHlnRG1BRTlQSjBDWlVwQ3ZTdEl5OTZGeHN2L2RyQ1VPdkhzcFl6?=
 =?utf-8?B?bGQ3YmNrZWg3MWxXV3dXQ2dVQWc5Q2NBTWFNeWJUellBU3BiVngvYUd0WW9u?=
 =?utf-8?B?WFJWRDBsaHRZVE5kZ0NWanhoRjR2V05NQVFGNmZjU2FVZzh2MVZIUDdRYVJK?=
 =?utf-8?B?SUREVjlRNW9xenBYV0szWDFqNkk3SFAwdExsbGZrYWdXdFFxL0ZqQjVYbTFr?=
 =?utf-8?B?WnY1NmZUR205N2VSK0xEY3h1MjlRZ1AvQlhNOU9OWUU2d0JwZ2FwRE1aUzBl?=
 =?utf-8?B?MlUvalFEUlh3aG1mdGErWndHVFVIY1JMZUI3T3dCakVRUVl3b2dIQmxKRmZG?=
 =?utf-8?B?b2dUSzlJNUVJTXpMQ2VSYndEOEhBYzJHcHhOQkExN3U2cjlTbXFxUlVmb0hi?=
 =?utf-8?B?VGFkZSsrOTA3Unh0T0xRUlpLL3BEQ21NSis2OHRDa2RjaUhuTi9jRnV0SjM3?=
 =?utf-8?B?a3VVYnZQSmpmOHpiK1VTS2NJSE01bEJCVUtVa1ZKZDNJNVVpSU1jY3kxaUpN?=
 =?utf-8?B?ZElrVG5xQmE0YmZQeTRFVHhEaXdsVFI4U1hJNzhhaHZpT2xoYXRBTkROMkFO?=
 =?utf-8?B?OWQxRGFVV0ovNEhoK3dVdlRpRnF6N0V0L0QzNmFqRjdCTldRNStIR0Jzc2Vt?=
 =?utf-8?B?bEFUbjQ4MHZtVlRMVmh6b1FhUnBGODdmOC9zQTJ0cjU1UHZNN29jK2JPL0Ft?=
 =?utf-8?B?NmxEamFmcGE1cGQva0NRLzZQNUFOUEdCeHZBbzJ0Qi9ZUmRWOW9NdHVEKzJS?=
 =?utf-8?B?WkRMZGFPMk1WOU5vL3pWMXkyRG10bmkraGR2OE1JTEZTSFpUcWVlaTI4cXFK?=
 =?utf-8?B?bCtBUjBLOHpsaWhmVmtEclZnYTVkMXE3TzJFU1VkOHFMS0hvRHJsTERJTWtq?=
 =?utf-8?B?cmVzQUpsMENtR3J5eDdaU2ZXWTQ3S1VueXVDVDJ3Zk45UnY0ak9Qb256eFR6?=
 =?utf-8?Q?F6KPbhh6KLa45jbMZJHTwakRf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4f45b0-9121-4f15-5dec-08dc27ee5fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 15:06:34.3327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/IHT1PIeV+igSzi+kEEUAoNo0QEKUlqKf2uSSdFD5bsmAMxHKZal9YX3KYRK6iOEhGJ3xjjPnfYRd+ch4Ozsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB6027
X-Proofpoint-ORIG-GUID: WXZp3rkLNJc15apWdTTyIqS1GHig8rWX
X-Proofpoint-GUID: WXZp3rkLNJc15apWdTTyIqS1GHig8rWX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_06,2024-01-31_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS8O2cnkgTWFpbmNlbnQg
PGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkg
NywgMjAyNCA0OjMyIFBNDQo+IFRvOiBFbGFkIE5hY2htYW4gPGVuYWNobWFuQG1hcnZlbGwuY29t
Pg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgVGFyYXMgQ2hvcm55aSA8dGFyYXMuY2hv
cm55aUBwbHZpc2lvbi5ldT47DQo+IFRob21hcyBQZXRhenpvbmkgPHRob21hcy5wZXRhenpvbmlA
Ym9vdGxpbi5jb20+OyBNaXF1ZWwgUmF5bmFsDQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29t
Pg0KPiBTdWJqZWN0OiBSZTogW0VYVF0gUHJlc3RlcmEgZHJpdmVyIGZhaWwgdG8gcHJvYmUgdHdp
Y2UNCj4gDQo+IE9uIFdlZCwgNyBGZWIgMjAyNCAxMjoyNDoxNiArMDAwMA0KPiBFbGFkIE5hY2ht
YW4gPGVuYWNobWFuQG1hcnZlbGwuY29tPiB3cm90ZToNCj4gDQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogS8O2cnkgTWFpbmNlbnQgPGtvcnkubWFpbmNlbnRA
Ym9vdGxpbi5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDcsIDIwMjQgMToy
OSBQTQ0KPiA+ID4gVG86IEVsYWQgTmFjaG1hbiA8ZW5hY2htYW5AbWFydmVsbC5jb20+DQo+ID4g
PiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgVGFyYXMgQ2hvcm55aQ0KPiA+ID4gPHRhcmFz
LmNob3JueWlAcGx2aXNpb24uZXU+OyBUaG9tYXMgUGV0YXp6b25pDQo+ID4gPiA8dGhvbWFzLnBl
dGF6em9uaUBib290bGluLmNvbT47IE1pcXVlbCBSYXluYWwNCj4gPiA+IDxtaXF1ZWwucmF5bmFs
QGJvb3RsaW4uY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtFWFRdIFByZXN0ZXJhIGRyaXZlciBm
YWlsIHRvIHByb2JlIHR3aWNlDQo+ID4gPg0KPiA+ID4gT24gV2VkLCA3IEZlYiAyMDI0IDEwOjU2
OjI5ICswMDAwDQo+ID4gPiBFbGFkIE5hY2htYW4gPGVuYWNobWFuQG1hcnZlbGwuY29tPiB3cm90
ZToNCj4gPiA+DQo+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4g
PiBGcm9tOiBLw7ZyeSBNYWluY2VudCA8a29yeS5tYWluY2VudEBib290bGluLmNvbT4NCj4gPiA+
ID4gPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDcsIDIwMjQgMTI6MjMgUE0NCj4gPiA+ID4g
PiBUbzogRWxhZCBOYWNobWFuIDxlbmFjaG1hbkBtYXJ2ZWxsLmNvbT4NCj4gPiA+ID4gPiBDYzog
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgVGFyYXMgQ2hvcm55aQ0KPiA+ID4gPiA+IDx0YXJhcy5j
aG9ybnlpQHBsdmlzaW9uLmV1PjsgVGhvbWFzIFBldGF6em9uaQ0KPiA+ID4gPiA+IDx0aG9tYXMu
cGV0YXp6b25pQGJvb3RsaW4uY29tPjsgTWlxdWVsIFJheW5hbA0KPiA+ID4gPiA+IDxtaXF1ZWwu
cmF5bmFsQGJvb3RsaW4uY29tPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbRVhUXSBQcmVzdGVy
YSBkcml2ZXIgZmFpbCB0byBwcm9iZSB0d2ljZQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gVHVl
LCA2IEZlYiAyMDI0IDE4OjMwOjMzICswMDAwIEVsYWQgTmFjaG1hbg0KPiA+ID4gPiA+IDxlbmFj
aG1hbkBtYXJ2ZWxsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNvcnJ5LCB0
aGF0J3Mgbm90IGhvdyB0aGlzIHdvcmtzLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoZSBm
aXJtd2FyZSBDUFUgbG9hZGVyIHdpbGwgb25seSByZWxvYWQgaWYgdGhlIGZpcm13YXJlDQo+ID4g
PiA+ID4gPiBjcmFzaGVkIG9yIGV4aXQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSGVuY2Us
IGluc21vZCBvbiB0aGUgaG9zdCBzaWRlIHdpbGwgZmFpbCwgYXMgdGhlIGZpcm13YXJlIHNpZGUN
Cj4gPiA+ID4gPiA+IGxvYWRlciBpcyBub3Qgd2FpdGluZyBGb3IgdGhlIGhvc3QgdG8gc2VuZCBh
IG5ldyBmaXJtd2FyZSwgYnV0DQo+ID4gPiA+ID4gPiBmaXJzdCBmb3IgdGhlIGV4aXN0aW5nIGZp
cm13YXJlIHRvIGV4aXQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaXRoIHRoZSBjdXJyZW50IGlt
cGxlbWVudGF0aW9uIHdlIGNhbid0IHJtbW9kL2luc21vZCB0aGUgZHJpdmVyLg0KPiA+ID4gPiA+
IEFsc28sIGluIGNhc2Ugb2YgZGVmZXJyaW5nIHByb2JlIHRoZSBzYW1lIHByb2JsZW0gYXBwZWFy
cyBhbmQNCj4gPiA+ID4gPiB0aGUgZHJpdmVyIHdpbGwgbmV2ZXIgcHJvYmUuIEkgZG9uJ3QgdGhp
bmsgdGhpcyBpcyBhIGdvb2QgYmVoYXZpb3IuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJc24ndCBp
dCBwb3NzaWJsZSB0byB2ZXJpZnkgdGhhdCB0aGUgZmlybXdhcmUgaGFzIGFscmVhZHkgYmVlbg0K
PiA+ID4gPiA+IHNlbnQgYW5kIGlzIHdvcmtpbmcgd2VsbCBhdCB0aGUgcHJvYmUgdGltZT8gVGhl
biB3ZSB3b3VsZG4ndCB0cnkNCj4gPiA+ID4gPiB0byBmbGFzaCBpdC4NCj4gPiA+ID4NCj4gPiA+
ID4gRXZlcnl0aGluZyBpcyBwb3NzaWJsZSwgYnV0IHRoYXQgaXMgdGhlIHdheSB0aGUgZmlybXdh
cmUgaW50ZXJmYWNlDQo+ID4gPiA+IHdhcyBpbml0aWFsbHkgZGVzaWduZWQuIENoYW5naW5nIHRo
aXMgd2lsbCBicmVhayBjb21wYXRpYmlsaXR5DQo+ID4gPiA+IHdpdGggYm9hcmQgYWxyZWFkeSBk
ZXBsb3llZCBpbiB0aGUgZmllbGQuDQo+ID4gPg0KPiA+ID4gSSBkb24ndCB1bmRlcnN0YW5kLCB3
aHkgZml4aW5nIHRoZSBwcm9iZSBieSBub3QgZmxhc2hpbmcgdGhlDQo+ID4gPiBmaXJtd2FyZSBp
ZiBpdCBpcyBhbHJlYWR5IGZsYXNoZWQsIHdpbGwgYnJlYWsgY29tcGF0aWJpbGl0eT8NCj4gPiA+
IERvIEkgbWlzcyBzb21ldGhpbmc/DQo+ID4NCj4gPiBGaXJzdCwgZmlybXdhcmUgaXMgbG9hZGVk
IHRvIFJBTSBhbmQgbm90IGZsYXNoZWQuDQo+ID4gU2Vjb25kLCB0aGVyZSBpcyBhIGNlcnRhaW4g
Y29udHJvbCBsb29wIHdoaWNoIGRpY3RhdGVzIHdoZW4gdGhlDQo+ID4gZmlybXdhcmUgbG9hZGVy
IGV4cGVjdHMgbmV3IGZpcm13YXJlIGJ5IEFCSSwgYW5kIHRoYXQgY2FuIG9ubHkgaGFwcGVuDQo+
ID4gd2hlbiB0aGUgcHJldmlvdXMgZmlybXdhcmUgY29kZSBoYXMgdGVybWluYXRlZC4NCj4gDQo+
IEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgaXQgd2lsbCBicmVhayB0aGUgY29tcGF0aWJp
bGl0eS4NCg0KUGxlYXNlIHJlYWQgYmVsb3cgcmVnYXJkaW5nIHlvdXIgY29kZSBhc3N1bXB0aW9u
cy4NClRoZXJlIGlzIGEgY29tcGxleCBzdGF0ZSBtYWNoaW5lIHByZXNlbnQgdG9kYXksIGFuZCB5
b3VyIGNoYW5nZXMgd2lsbCBicmVhayBpdCBmb3IgZXhpc3RpbmcgYm9hcmRzLg0KDQo+IFlvdSBu
ZXZlciBlbnRlcmVkIHRoZSBzZWNvbmQgdGltZXMgcHJvYmUgYXMgeW91IHdvdWxkIGhhdmUgZmFj
ZWQgdGhpcw0KPiBpc3N1ZS4NCj4gDQo+IEkgaGF2ZW4ndCB0ZXN0ZWQgaXQgeWV0IGJ1dCB3b3Vs
ZG4ndCB0aGlzIGRvIHRoZSBqb2I6DQo+IA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
YXJ2ZWxsL3ByZXN0ZXJhL3ByZXN0ZXJhX3BjaS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21hcnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFfcGNpLmMNCj4gQEAgLTQ1NywxNiArNDU3LDIx
IEBAIHN0YXRpYyBpbnQgcHJlc3RlcmFfZndfaW5pdChzdHJ1Y3QgcHJlc3RlcmFfZncgKmZ3KQ0K
PiAgICAgICAgIGZ3LT5kZXYuc2VuZF9yZXEgPSBwcmVzdGVyYV9md19zZW5kX3JlcTsNCj4gICAg
ICAgICBmdy0+bGRyX3JlZ3MgPSBmdy0+ZGV2LmN0bF9yZWdzOw0KPiANCj4gLSAgICAgICBlcnIg
PSBwcmVzdGVyYV9md19sb2FkKGZ3KTsNCj4gLSAgICAgICBpZiAoZXJyKQ0KPiAtICAgICAgICAg
ICAgICAgcmV0dXJuIGVycjsNCj4gLQ0KPiAgICAgICAgIGVyciA9IHByZXN0ZXJhX2Z3X3dhaXRf
cmVnMzIoZncsIFBSRVNURVJBX0ZXX1JFQURZX1JFRywNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFBSRVNURVJBX0ZXX1JFQURZX01BR0lDLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgUFJFU1RFUkFfRldfUkVBRFlfV0FJVF9NUyk7DQoNClRo
aXMgYXNzdW1lcyB3cm9uZ2x5IHRoYXQgdGhlIE1BR0lDIGlzIGNvcnJlY3Qgd2hlbiB0aGUgZmly
bXdhcmUgaXMgcnVubmluZy4NCg0KPiAgICAgICAgIGlmIChlcnIpIHsNCj4gLSAgICAgICAgICAg
ICAgIGRldl9lcnIoZnctPmRldi5kZXYsICJGVyBmYWlsZWQgdG8gc3RhcnRcbiIpOw0KPiAtICAg
ICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gKyAgICAgICAgICAgICAgIGVyciA9IHByZXN0ZXJh
X2Z3X2xvYWQoZncpOw0KPiArICAgICAgICAgICAgICAgaWYgKGVycikNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gKw0KPiArICAgICAgICAgICAgICAgZXJyID0gcHJl
c3RlcmFfZndfd2FpdF9yZWczMihmdywgUFJFU1RFUkFfRldfUkVBRFlfUkVHLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQUkVTVEVSQV9GV19SRUFEWV9N
QUdJQywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUFJF
U1RFUkFfRldfUkVBRFlfV0FJVF9NUyk7DQo+ICsgICAgICAgICAgICAgICBpZiAoZXJyKSB7DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZnctPmRldi5kZXYsICJGVyBmYWlsZWQg
dG8gc3RhcnRcbiIpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiAr
ICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgIH0NCg0KTUFHSUMgdmFsdWUgaXMgY2xlYXJlZCBh
ZnRlciBGVyBpcyBkb3dubG9hZGVkIHRvIFJBTSwganVzdCBiZWZvcmUgaXQgaXMgZXhlY3V0ZWQu
DQpTbyBjaGVja2luZyB0aGUgTUFHSUMgdmFsdWUgdG8gZGV0ZXJtaW5lIGlmIHRoZSBmaXJtd2Fy
ZSBpcyBydW5uaW5nIGlzIHVzZWxlc3MuDQoNCllvdSB3aWxsIGdldCB0aGUgTUFHSUMgdmFsdWUg
cmVhZCBjb3JyZWN0bHkgb25seSB3aGVuIGZpcm13YXJlIGlzIGR1cmluZyB0aGUgZG93bmxvYWQg
cHJvY2Vzcywgd2hpY2ggZG9lcyBub3QgaGVscCB5b3UgaW1wbGVtZW50aW5nIHRoZSBsb2dpYyB5
b3Ugd2FudC4NCg0KPiANCj4gDQo+IFJlZ2FyZHMsDQo+IC0tDQo+IEvDtnJ5IE1haW5jZW50LCBC
b290bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBrZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6
Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fYm9vdGxp
bi5jb20mZD1Ed0lGYVEmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9ZVRlTlRMRUs1LQ0KPiBU
eFhjempPY0tQaEFOSUZ0bEI5cFA0bHE5cWhkbEZyd1EmbT1ub05oSGFrbmtVcmQ2RDdTQUN5Zm91
ZkE2YTVVDQo+IFJKenlpWnRZOWUxVzVhSHFVSEhDYTViYUVueUV0Wk1RVTBBcSZzPU9GVEgtDQo+
IHhvZUJGR3UwMnVWQ2RhSFNXY0dkS1g5ZGJ1OTUwanhhTzVyak9jJmU9DQo=

