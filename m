Return-Path: <netdev+bounces-78625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BB6875EAB
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1BD1C21E6E
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886994F1FB;
	Fri,  8 Mar 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="nw+j7LBa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF34F1F1
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883559; cv=fail; b=kNOIQH790t8d72wNv0jjqAQDaTFurDEXyJmLXifha/Y6iNRi1QhRVI9B25kZej0BB91FpT5m3BoSqDPRohemXIYwgNOBUfiCWbO8OkmZVskSYQcFTbQ7RA65lJsJqBldyzqJ5pbQfyDJv+++ohf+NRK7JrNVkkbzvcEY8wbjqmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883559; c=relaxed/simple;
	bh=vLcmsjQtAdNPXjxYLk7Q0gKgg1b0IFtotxCt6MfPXz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fQRTuZ7UyZoXtCHZZjURJw9GfCOdZnenwz1qwskJ8GYyP3oCyv/kGuas3wzg2nrxf5r9XgQZK5EA8QhnEcScEExX5zhIBVQ9hsVe+e6rD9W5nrH3DIdgfdiXDaGYWzBf/o9NIzwV8yBYnG9JBttyHbxqrozEWT2mCenKuZIGrL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=nw+j7LBa; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427JDiRi020956;
	Thu, 7 Mar 2024 23:39:03 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wqkj5sxp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 23:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPDGamZ0cHKLDlH3jbHp+H77Kh6stEJAXyDz3iFOnPUDHMqH4LsU48cwPW2JOFkZl358vNEsdp8CI8mWHU/KFEEqbzJKPuVmEE+z1LHtIy/6T8ph9MFdbD2By7VJXMA+ZUJbHMUvtZRV9/e3SrQyFMgmUBHAp4YjFIIBXn7sKKzmyMwYE2CZML7kaMdL3sUbACOpjR5tPgZVYMY6aOXR+f/Bmf4jvIX48xu93Pr/uDQAk+diRTTPb44ED4RF3fKXwlO+m3MN6nYdwhjAywfMyVraycrM3jvQHnYorWht2/N1JyyXOw2lOeC160mQvwA0p56o7/ebMZ1qzReOP1wM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLcmsjQtAdNPXjxYLk7Q0gKgg1b0IFtotxCt6MfPXz8=;
 b=emAlOjQZD/RuQ8e0FBaoTUINaBLBDuEVmZAZRLfPWjcCotridASut9ddueDuuLsxDtUjpGfcVSj3YBo9ELgJbxFrRXuJpF3SWliAHTqILRKcqiQ/xlxqS/VLzw9ItjJ3aDGrIGwDO+bflPjsCeYFSvoCLZarHUvNTsgF2Mmc0hOqZrv4Xd4gdw58AMKbtRXWYlPLp5IrO6MPPhaHRU7aDZmvVc+2hgAXPiV0kHe70hU5tJ4uxfBe9bbo8Y6DfK5WwKjBTeHnlYo5ToA78+nkpbGIRe1ynBafoyZa5nO1z8T+zWqiVUGbGd7YozAzs+CECNwOf8JIQKaFoKj4dBNeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLcmsjQtAdNPXjxYLk7Q0gKgg1b0IFtotxCt6MfPXz8=;
 b=nw+j7LBazwC1iYGFEhO4TrifVGtnc4XCNdoNwFsmWzm7tHFKp5GJY6DySCpof+SDBP6bemLqgkZ2ZY4pXc/EVDOkiOsSVTSsoVCKQKl1FMRPTjnzSFu94CAiK+WR/XNvx9zb8adknv4qSnYdUWb8b0Cj3Go2zA1tPBY7MPiAK5o=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by SA1PR18MB5968.namprd18.prod.outlook.com (2603:10b6:806:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 07:39:01 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::d8da:f765:b92b:b3a7]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::d8da:f765:b92b:b3a7%3]) with mapi id 15.20.7362.028; Fri, 8 Mar 2024
 07:39:01 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King - ARM Linux
	<linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni
	<pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next] net: phy: simplify a check in
 phy_check_link_status
Thread-Topic: [EXTERNAL] [PATCH net-next] net: phy: simplify a check in
 phy_check_link_status
Thread-Index: AQHacNTPwqbAAJj3DUaVr1UEERamorEtdZzA
Date: Fri, 8 Mar 2024 07:39:00 +0000
Message-ID: 
 <SJ0PR18MB52169094F65B708F8AA40240DB272@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <de37bf30-61dd-49f9-b645-2d8ea11ddb5d@gmail.com>
In-Reply-To: <de37bf30-61dd-49f9-b645-2d8ea11ddb5d@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|SA1PR18MB5968:EE_
x-ms-office365-filtering-correlation-id: 02aee7af-25c7-48b2-d64b-08dc3f42d207
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 F7wEx2bikuoBwnLQUPvb3/B8y2Rr9yMNbd6yGpMBsBlns2IX6dXp9C+oQiwN0i/VZZkLw4orKEn12l791EnMbVmA/qeUacGsG0SPA0L46SGp3aDIvG1vs1jeH1eze0XSOhB7EudhaprdIF75lbhHqE46w0s0LN3syz5gSm/i7ypjk76psX1eNyU4AKH9ejO+5HdMbcDoRJ1XWsD7iRd/LNogxQDIknWrvRWoM5ltUrNwC48Iy6vJWiMYgeJumFgIcGaifVAATv+XR54ZKfWQ3mYESW33AyvWl/nFZXRDZ0TxXq5/NDltxw+cHqhy1u4mDrZ8o9ze4UQiGZ2Nr69I6yMU390LkBG9SyOoPqo9F/Q1qk11s+OF+r4IBKVRVk2dhJm3DZ4sgOaSFv5UVFHcSp9xP4+OtJx4/nciC0qQTlXRcgxqfBv10IHTh1pbBdjwL04nj56NNoWxJtjgZ+IF5BWCUNyuG6VrCsWCOdSrXBsxydLoXYdglyOmvzWzEdwnJqO9tN8P3ZztpgjZOwGP3ufwV5Y5N8fpbjc/WVonlp3f+3fMMYGQMLgPucTTfjnOEFOULNU1kDFJ/p//YoNnYySG8F2BylLEKz4JIjiaSkgZq4T2jpFlDrVJjmjD4aBUutohRzQE4BaSuJuMx0moFZV03qa64Kc7nXsJJTW8poUKWPEFZjFX1EWjBe8Dz5ykEtW+/ggvXhlk1WepFzrvdw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dVpVLzM5VkpzbWFWVklwTzcxbzVqSStuN0tod2ZHaC91TDhrbXJEZWQwOU5T?=
 =?utf-8?B?TG5XYS9UUGQyM3NZSXlNVjB6WWV5TzVsYzh4eEJhSlVQZTVCMGtGbTJrNDA3?=
 =?utf-8?B?blh6bU5RMnNaZHdSRWUzSEFSaXBkRGFmWUdZQ2Q0UXlUQ2RaSUs3M0hDR01z?=
 =?utf-8?B?dUF6VkdRbm5KdXN3RjZheURXQTBoUkpZMGU0NmZkY09DUlN2QlpTTmlrQUU3?=
 =?utf-8?B?c3NpN1Y2ZEhidWlzeGphVmEydXNOMExHUGZEbFU1YWNud3l4ZTk4SVJUcjJn?=
 =?utf-8?B?S2dFSTR5VmNEUmJidkpUanc0T1pMS3hGRzFIOG5LelN0YXI5cXV3Z3N4ZnBN?=
 =?utf-8?B?OXpOSVdOd0MyWVpMdGwvV3N0Y1krUzJxSGtsNXZGTldWVzFKR3Ztam1IUFI5?=
 =?utf-8?B?QVkwYzdTODdKU0RXcCtPcnVEZDZqWm90ajNoTjlaMDZiZ3ZPeVJNeHBwMldQ?=
 =?utf-8?B?OUQ0WHgwY0hicnNQRzd0UnhNR2JWSEl4R3RRRnpmUTZYOTFvcDJQbW1sL01X?=
 =?utf-8?B?cVdpRjcrMVE3VXN3YStmNkl3dkRScFJWc0hCY0NaY0Rqc1JXYXNNSU1BVjlS?=
 =?utf-8?B?MjNqSDRuTTJyc01yVWFKZUZCTzF2ODcxNi85blpzYW1SZnJYMHl0WEM2S29t?=
 =?utf-8?B?TTdPNksrb0l4YkxER0hqZ244Zlk3TlJXUEpENVYzR25PS000STN2UzFYU3FB?=
 =?utf-8?B?NFhyT0lBK1Y0TzZPY3Z4ekZBdHdXM1doYUdKMUx1eUFVNUkxWWE4akZNZkd6?=
 =?utf-8?B?ZjFUNWl5cE1VbmltR0JJRGowNU9PTkRuOWs1LzN0aU5ONEltdUtoTjdwQ1F5?=
 =?utf-8?B?V0FNTGFUdnQ1VkY5ZGRMS01uZXppV2RtYWRHNnBXZ0dCQjZNYmsvTjVHL1lQ?=
 =?utf-8?B?N0lSNURXb1ZzWmF4dnFvUlhwL2NTYkJOeWtyY2FaTlNDd1BaeTVkSVRpaU1O?=
 =?utf-8?B?MmFtZm9XdGpTMGtvQWtNY2ZibmhwelhPNXllb0dFeWtGZUdSR0Mxam55MXVZ?=
 =?utf-8?B?dDlqeDdvRFBjNlhCMXd6M2xDNTUrb2dsbHBKeTFHNUR2QS9mMVN5aFBEQVlt?=
 =?utf-8?B?WjRZY2VCODJxQzBBeFZTWDRkZ3lDTi81a0VtUVNXdmtkbnlWWmdmbEpKNUlq?=
 =?utf-8?B?OXNvYllIWDNXeEhGSHE4RGliZTF4K1paUnlUU0tZMWxuVCt1NGNoZkVrODU1?=
 =?utf-8?B?dzFRMG1Nbm94K21rRjkzTGE5SFFkNVFVNERhN29GanNVUkV3eVVqS1ZWUGlC?=
 =?utf-8?B?alordmlhZVhJNWRtRkh3elFRSEl2bVczSHBIbmM3c3llSUorbGlhdTd6NFJk?=
 =?utf-8?B?OXl5VUhkbHVzZDVSNGpxUFhwY0tCclpJSm5Ob2tTZFlFcnhBSXU0YjRCKzhP?=
 =?utf-8?B?SDNRTlF6aFNwbjFFM3BZaFZHTlBPQWgxRTNXV1NvV0NYdmZCYU8rNXgyaVYz?=
 =?utf-8?B?Qk5RQlJEaW1veUhlNURvS1h3VW9jdVQ2MjFFNUUzdTg2YWxSKzVRODBKQ0oz?=
 =?utf-8?B?dGJYeU9wUVBhejZCOWhYcFRFU2RxUnZDZk1aRXFjOHdtaUI4TVFSbHhBcDZp?=
 =?utf-8?B?UW5ZRkYrT3pqeC9hazFyYnB5VTdQeEtSbG1GaWZlbzV5MU1MK3lTdHJUNWpK?=
 =?utf-8?B?UGFBWVQrQ0J2MytCbWkvMVE0MmozNzI3NEhEdyt0aVZZWFZ6aTNuY05BSE53?=
 =?utf-8?B?dUZDTHNHSVA3a3FpQkFGNndsd0xGU084cElUWFYzVVRtcE9SY3ZKTXczSlM2?=
 =?utf-8?B?eTd1ZzVtOFZ1TTRLWk84VC9GNTBPeThjclBNTGM2T3NUdHRMUERtRHM5MWs5?=
 =?utf-8?B?MUlOQXowdk1qZk5iUDFtSmNBNDJqcG1VRnNYUUV5VGV1NTNwaTNsUmYzWm5v?=
 =?utf-8?B?U0NKM2VJQ3RvQXdwaHlYcTU4dzZabVlQQmRIWUcvZnVDQUxpVzNRdFVWR0g3?=
 =?utf-8?B?eHZTUDRvZHlacll6bStiVkJMQk9rUG1vOS9nZUdHMkpWOUhEaExMSnM1Nkk1?=
 =?utf-8?B?OGhaOHptMWZsSnFad3pJS1N5cEVWOXl3ODd3OXd1RmVGZlV3Szl4SUZ1c0hY?=
 =?utf-8?B?MXVUWXl0Nkwxbm1lcVlFcVA0YWxzTFliNzZPd1lYbjZXb0x1UURaTkh2MTVt?=
 =?utf-8?Q?jzKzHO2vf4uXnpTYgV96mLnKg?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02aee7af-25c7-48b2-d64b-08dc3f42d207
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:39:00.3681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2N7Ta1SKS6jg8m7yNiT1IwqNRc3hSay+64WP3D8ePRaqRUiD9roq8zRDBIzM1qfTHWSHOkxVhSrenKypGHyYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5968
X-Proofpoint-GUID: VUdwTKpgtoaeNQ5seMOsUAtzioPr2u5p
X-Proofpoint-ORIG-GUID: VUdwTKpgtoaeNQ5seMOsUAtzioPr2u5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_06,2024-03-06_01,2023-05-22_02

SGkgSGVpbmVyLA0KDQpUbyBtZSBpdCBsb29rcyBsaWtlIGJvdGggcGF0Y2hlcywNCnI4MTY5OiBz
d2l0Y2ggdG8gbmV3IGZ1bmN0aW9uIHBoeV9zdXBwb3J0X2VlZSBhbmQgbmV0OiBwaHk6IHNpbXBs
aWZ5IGEgY2hlY2sgaW4gcGh5X2NoZWNrX2xpbmtfc3RhdHVzIGlzIHJlbGF0ZWQgYW5kIGNhbiBi
ZSBwdXNoZWQgYXMgYSBzZXJpZXMuIFRoaXMgd2lsbCBtYWtlIGNoYW5nZSBtb3JlIGhhcm1vbmlj
LiBCZWNhdXNlLCB5b3UgYXJlIG1vdmluZyBzZXR0aW5nIG9mIGVuYWJsZV90eF9scGkgaW4gb25l
IHBhdGNoIGFuZCByZW1vdmluZyBmcm9tIHRoZSBvdGhlciBvbmUuDQoNClJlZ2FyZHMsDQpTdW1h
bg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBIZWluZXIgS2FsbHdlaXQg
PGhrYWxsd2VpdDFAZ21haWwuY29tPg0KPlNlbnQ6IEZyaWRheSwgTWFyY2ggOCwgMjAyNCAyOjQ2
IEFNDQo+VG86IFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCA8bGludXhAYXJtbGludXgub3JnLnVr
PjsgQW5kcmV3IEx1bm4NCj48YW5kcmV3QGx1bm4uY2g+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJl
ZGhhdC5jb20+OyBFcmljIER1bWF6ZXQNCj48ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IERhdmlkIE1p
bGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEpha3ViDQo+S2ljaW5za2kgPGt1YmFAa2VybmVs
Lm9yZz4NCj5DYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFtFWFRFUk5BTF0g
W1BBVENIIG5ldC1uZXh0XSBuZXQ6IHBoeTogc2ltcGxpZnkgYSBjaGVjayBpbg0KPnBoeV9jaGVj
a19saW5rX3N0YXR1cw0KPg0KPkhhbmRsaW5nIGNhc2UgZXJyID09IDAgaW4gdGhlIG90aGVyIGJy
YW5jaCBhbGxvd3MgdG8gc2ltcGxpZnkgdGhlIGNvZGUuDQo+SW4gYWRkaXRpb24gSSBhc3N1bWUg
aW4gImVyciAmIHBoeWRldi0+ZWVlX2NmZy50eF9scGlfZW5hYmxlZCINCj5pdCBzaG91bGQgaGF2
ZSBiZWVuIGEgbG9naWNhbCBhbmQgb3BlcmF0b3IuIEl0IHdvcmtzIGFzIGV4cGVjdGVkIGFsc28N
Cj53aXRoIHRoZSBiaXR3aXNlIGFuZCwgYnV0IHVzaW5nIGEgYml0d2lzZSBhbmQgd2l0aCBhIGJv
b2wgdmFsdWUgbG9va3MNCj51Z2x5IHRvIG1lLg0KPg0KPlNpZ25lZC1vZmYtYnk6IEhlaW5lciBL
YWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+DQo+LS0tDQo+IGRyaXZlcnMvbmV0L3BoeS9w
aHkuYyB8IDQgKystLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvcGh5LmMgYi9kcml2ZXJz
L25ldC9waHkvcGh5LmMgaW5kZXgNCj5jM2EwYTVlZTUuLmM0MjM2NTY0YyAxMDA2NDQNCj4tLS0g
YS9kcml2ZXJzL25ldC9waHkvcGh5LmMNCj4rKysgYi9kcml2ZXJzL25ldC9waHkvcGh5LmMNCj5A
QCAtOTg1LDEwICs5ODUsMTAgQEAgc3RhdGljIGludCBwaHlfY2hlY2tfbGlua19zdGF0dXMoc3Ry
dWN0IHBoeV9kZXZpY2UNCj4qcGh5ZGV2KQ0KPiAJCXBoeWRldi0+c3RhdGUgPSBQSFlfUlVOTklO
RzsNCj4gCQllcnIgPSBnZW5waHlfYzQ1X2VlZV9pc19hY3RpdmUocGh5ZGV2LA0KPiAJCQkJCSAg
ICAgICBOVUxMLCBOVUxMLCBOVUxMKTsNCj4tCQlpZiAoZXJyIDwgMCkNCj4rCQlpZiAoZXJyIDw9
IDApDQo+IAkJCXBoeWRldi0+ZW5hYmxlX3R4X2xwaSA9IGZhbHNlOw0KPiAJCWVsc2UNCj4tCQkJ
cGh5ZGV2LT5lbmFibGVfdHhfbHBpID0gKGVyciAmIHBoeWRldi0NCj4+ZWVlX2NmZy50eF9scGlf
ZW5hYmxlZCk7DQo+KwkJCXBoeWRldi0+ZW5hYmxlX3R4X2xwaSA9IHBoeWRldi0+ZWVlX2NmZy50
eF9scGlfZW5hYmxlZDsNCj4NCj4gCQlwaHlfbGlua191cChwaHlkZXYpOw0KPiAJfSBlbHNlIGlm
ICghcGh5ZGV2LT5saW5rICYmIHBoeWRldi0+c3RhdGUgIT0gUEhZX05PTElOSykgew0KPi0tDQo+
Mi40NC4wDQo+DQoNCg==

