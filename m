Return-Path: <netdev+bounces-283273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJKuK/D79GnFGwIAu9opvQ
	(envelope-from <netdev+bounces-283273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 21:16:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3AE4AF17C
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 21:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02967301ECF4
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 19:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003DC413225;
	Fri,  1 May 2026 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="Rp7q4TfE"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3D313E03
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662929; cv=none; b=Foo5e6ZWBKPLPAVUBZZxJoYgtjYAUU/zPCRtKVJAfiL5V8gwWme80vDxda6M2jIaF42txDfD0Mhi9Dv4h3rTFMi9lSrV9Z01A2gXSvFQY9UsOBXScXIZzgVFZ5onL8lOlLTM9BqaQ8OTxOgA1xS3oDj6GsW71yYZbUJUKQ4RW6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662929; c=relaxed/simple;
	bh=qHSNIJ9cYlXbzAMXZ5mTRowu6vXbMWvdA8ZRuYcwsT4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LqjTysOjkG2ymia3FW/F+aPy0lCfvwhbCH/y9vveWTLLJf+3P1qQjKs6JgsXpDZJKCQwMy14eWyKwpCHatmNgdZxbI7TmFlc6YxQRLQ5j0a8FvjOpAl9sfHVFQ0awiSnWzJICRCMTHgK/j+sIRmU2dDWQTrDoiN77vMqZDiulSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Rp7q4TfE; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777662928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qHSNIJ9cYlXbzAMXZ5mTRowu6vXbMWvdA8ZRuYcwsT4=;
	b=Rp7q4TfEE8iSAAJAz4trllf1YLenDJT5tKwdhOL+f9Rx6g0pI/4skdOa2SFzN2eg5gCTW4
	md9eUXPozsg82hm8Qpv4+mrUyayDP/4wXPnNGNPJyONUgfhvYsIb0N00FXd1dEZCS6S2eE
	bEMjNZAL9e5LNKy678ouhrvozYhs25hMJLUKv/lvsHj7q0mE4bDeFDRL6Ilz4PXF7nV1H5
	qpdZtv+RigrpIf99CP/6HbUAXbzI7YCgSkLAjhsLJMQCEc24x13zqnxfdAtN+m5BvGLaVJ
	kZw7OP3TlXCwMB/yZ9z7n/YB/e3vKooXd/KgcBmZBugSdvKAk2wma2RdUOFoPQ==
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010024.outbound.protection.outlook.com
 [52.101.193.24]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-70-KhvN51g4M32ZRNWY5lzbYw-1; Fri, 01 May 2026 12:15:21 -0700
X-MC-Unique: KhvN51g4M32ZRNWY5lzbYw-1
X-Mimecast-MFC-AGG-ID: KhvN51g4M32ZRNWY5lzbYw_1777662919
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SJ0PR02MB8595.namprd02.prod.outlook.com (2603:10b6:a03:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 19:15:18 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 19:15:17 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/5] dt-bindings: net: add onsemi's TS2500/NCN26010
 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
Thread-Index: AdzZlV5WH2ywWnNEREiWlMiVKhqFig==
Date: Fri, 1 May 2026 19:15:17 +0000
Message-ID: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Enabled=True;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_SiteId=04e1674b-7af5-4d13-a082-64fc6e42384c;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_SetDate=2026-05-01T18:44:27.0000000Z;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Name=Public
 Information;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_ContentBits=3;MSIP_Label_1dcb4cab-3db0-412f-be97-4e57888824a6_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SJ0PR02MB8595:EE_
x-ms-office365-filtering-correlation-id: bd2c65c3-4c77-47c3-a804-08dea7b5fb04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020|56012099003|18002099003
x-microsoft-antispam-message-info: qefDpnvc5A//BiKTNe/yYpduA9DZTaXR2nKlKShDObyDM1BEBs4dfZwfrDO99H8yMV1xwA1kMAgczY0txPm/NdaTvBVWP5N28Q11xqE+HXLqjKFRF1bC0Y0nKzpM5ml0wPA/hvYh4JyULk+juZ++e/ATsDWcwGt3+vjCRWP99g24bjAsyr9L5GKCjIKmqYAyU8oO4uvYLLJ2VOaZl66HH98Fsp8dY9RVI8OHPnBvU0vBYe3mCcfg+Asvh30a7+ft+4jb1UYe5k4y5Xyqm4hm5147yaE6GghGC5iFWVwDb/dzCGIMBVo7mN5XPJNJWkCCihsm66b44CflTdZ7orLfNnMpfl2sO242kVY2QcEHXe9vzkVCPvTULHlzh6zCe6msSY05W1VMAYd4MmC0/iCAPXn+w3lVrAZUf/HdzXIc72inIS8EjTdZ1nEUDyqv/mVP+IiOQZ6mimNkQ2SRkpvuUMy7KGyDvOdfig16q2cD0LhU0WI1VLiYKa9jNIGUAUNiuO9Wex/yFDRLQqalOy+aNQ1xWxdaGTOrmJBx0ta3rzP1kVXbzhaHkw3bzh44VdEzA7+WMP5OeKtFcuvD7kpFWgMt3roj5+qyNEgcT1feaqaoa5Kie4IukvRTvSehvZ5buZuVTWmb1EG51Cqun185NPgVFTSzdArekv6Wa4cp58Qjxokf+uLtIqamGiQeuVePWPSLzOefOfuag3oLQHTFqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnljL3FyOXllUG1jT3kvWWVXMk5vcFZRY1cyWk50RnNXWisvaDBHclI1Si8v?=
 =?utf-8?B?aVp6VUg1VEVMSUROdW1Dc0JDUy81eUQ3YkhFWnd0eHZ2MHRSd2tCeEJPMHVC?=
 =?utf-8?B?am16MVp2eFYyRU1yeThYZWhUcjc2ZEZ2TkRPQkhiUnJMZlNIVG9mYWpQeUVl?=
 =?utf-8?B?RVV2b2N3U09qUWw5ckJGeWNqaVV0d0NVMlN2UFk0cFcydkdBTjc0K05aVkZQ?=
 =?utf-8?B?M3IzaGxMK2MvVGN0TUVwNDkwdmVoT1B3VE1pL0Z5Qm8xSnN6VFE1T0s5djh6?=
 =?utf-8?B?SHdKVkF3REdWcTJvcmthRHpiQ2dzdURPWk5kcU9QNXBSTEpwbFNxdW1BL2dF?=
 =?utf-8?B?cm1xeXpYalF6cGJnK1hRU3lBeDYrQkJtZnR4WnZDZ3pnd21ocTh0NU1MUGt5?=
 =?utf-8?B?cVloQkFJMjQ1QkRGQndEVllkdmhTOExhNklPK0Q2Zk1QZjltY2RlUVc3VUxt?=
 =?utf-8?B?QmphMUE2WEZhbmU0RmdZdTZBWnlXaStnTG5sbTRVaVZ1cHN5cVQrV2l0bTBr?=
 =?utf-8?B?LzIrVmRPVlRkVjJFWVpmOHBjSzdHU1NQVEppMm5HREs1MzFRY1BJV3QxYzdH?=
 =?utf-8?B?cWU3VlJZSG1acGdYQTZDOGRjdG02N1g5eTUzdFN3NjBWUk9RRks0MUtHWDZ0?=
 =?utf-8?B?NGJlNU1kYnF1aytxZWEyZStxV3N1Zkt5UmMwL0UwV0ppaW5YTExON3BWOEI0?=
 =?utf-8?B?L0Y5SVhOUE4wWTlMZjllbUlVMmJHZmFleWkyMXZzZi9JbWNtSFRUNFFvQTBu?=
 =?utf-8?B?aFVJQWFMclRkQ1phSVBNM2JvRmhBNC9pUWJ5eGVEK0dJK05sQjF2YTh2RFIw?=
 =?utf-8?B?cGhvUUlTZ0dzcmZydVdiTjgwL2xFaDVQOEF3dmtEUGIxK0dtM2w5d2hlZEZH?=
 =?utf-8?B?ZjdYTXFRb2YxNlZVSmQ4MWxXN2tGOEJJV2k1Tm5nN2hLek1FR1Y2eGFuTEc3?=
 =?utf-8?B?QmtKYU5ZcEcvSm9aSWtzTU5HZjBsWTNKamFqWERUSlVPbmRUMjlZNlllUmJ6?=
 =?utf-8?B?VHc3R29MTjRPbzJHVGFvR3VMYkVJYXN6NlBXdTBnaDRoTkp4WkZCUzRPQnpF?=
 =?utf-8?B?QkVIM0liSVVNZTBrQ2RHRHR5RG9HQUtTaFA4YTVPa3dQOXo4QWlrK1JqNFBP?=
 =?utf-8?B?VGVQWHRWQ09TWDZvWVBmV0xuMmZaV0dJbUwyWW0wRkR2ZHR2QzdGdVBBUnNy?=
 =?utf-8?B?S21QV21iS1JmZUoxZGwvd2k3TmMxOEpjRHNZMnBtcmp5a3JGOUJRM2hQb0g2?=
 =?utf-8?B?MkZ2TE01V1VUU3hSdFZuVXlQZEpNTFNzMTZUYVJMUy9FMmVwWkRWRjZhck1O?=
 =?utf-8?B?dHFaMUwwdmhMb0ZNK0g3cDA4WDRSeEI3dW5PT0ZPVXFYRzBnaE9lWDlvNnBS?=
 =?utf-8?B?V1MrUmpvdVpHVVpRTGFCQVIrQ1ZGY2x1b2tEUDhhNzB6OW1JUDVNS293UzZM?=
 =?utf-8?B?dXVwbkRqUkZuSGVWbGZQMzZJaERBM0lXVHgrc2h4Y21SWFJMY0NpelRhakZQ?=
 =?utf-8?B?TzMyOFRaYUJ5c25yUG04YXcrTlZqc3JKd0VmYVorcVAzN2g1eHd2RTVSb3N5?=
 =?utf-8?B?bUJNdkpjWnR1UDNyQVE5MHJwbjgvMVdsbWVtU25Bcm1IaUkzbm5OZ2VhbFZT?=
 =?utf-8?B?Qm5hTGZGVmI2aFBFd0FGTVJPT0p0aXIrc3hYOTN3MzloakdUL09FUlBuQlZC?=
 =?utf-8?B?YWExNm14SWtuZzVmR2p4ek82TmFFcVBiNmZHTW15d05FU1hINGV0R1ZKOW95?=
 =?utf-8?B?ZlZCSEtBZHZOMDBZY2Q4dzFaVHhHZmhURGRuQjRHUmdiN0h2M2xjNFI3OVR3?=
 =?utf-8?B?VGNpR2M5ZGJHRjJKR1I0STRUWGhXTTN0RE40NHA4dlkyTUdEMmlCSUJpa0Fy?=
 =?utf-8?B?N0o5Q3drbjRtcGJFSnBHUXFab1JMMlZhMWlOL09GbVB4bDlVciswc2srcFpz?=
 =?utf-8?B?OXBuZyt0QTl3cm1mVXBxdHUxYllyWlU2dXpzRUxab3gvbEhIdUxKdVFlTW5w?=
 =?utf-8?B?enJnMmc5RUdFU1B5b09tbnJxd1lDQ1prY0REb2Q5Z1dWVWRuNEkyY1djbnhW?=
 =?utf-8?B?RWw1dm5WY3hhMjNIU2lxNlFEaU1SRk5RSEE0WGMzNm1VT2RZNkRGQUhweHFm?=
 =?utf-8?B?SXVlVkFabHY4TmhTMnNWaVRXeFVjOTY2VlNrNFBYTUFhWXl3bnZCMVJMYlM5?=
 =?utf-8?B?RHdVNWo1aVFIZGRKUGo4aDNzUWRQd2gwMjlwL1AvTGo3aVVYbTFSeUNRWGx0?=
 =?utf-8?B?VEw3alYzTkdSWDNNRU0zZVM5ODJkcjJHVXFYVVpMRUZ0MCtVRXRKUjFYbkN2?=
 =?utf-8?B?QnQxRVBJN2ZSek9qd29lWFM4ajVkRnRvQ05UWlk0c2I2Rm9vQ1ZLZz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GiwF83o0V7yVCOwdEYDQ+xVcCiHQiqloP2pVgfTUeTCtg2Jy3Jg+GeZfCCi6d9F2eAx2jYxxenj05zXjxAw3OeOuJFW/xXarf800EUJMrRA0P+EYUMYZXmKfuvXgnnv0pvMtbpkfxrbvtzLZvxJox59rjoU6v+Rr6rmeMxCuQtmJc6GwRxfDut8L+xM967F2UDcbKU1teogPwdjZC5IxNqayP7cXC0NWnfjpxsiApi2ximCPj47fwBZ2mSy5tX6ljHJ2ksW7LqzDui9dC4ixpHRuZyY149LtLZcTBjYqPlojZP5KpZ1CdrpqDMk7m9u+7yVUVm4iPbtXrN+hD6GAGg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2c65c3-4c77-47c3-a804-08dea7b5fb04
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 19:15:17.4852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9loZm9gC/v6kiKgUDAZFaoI+aHNXgIJQZlO9cvEHu+ALlSwnHtEsia3Sz655fmSv3YU6aCaEs2nhna7puT00NcaiT0d1WjVosBdo09QOc5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8595
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6hXzptmsq2Yov1kIsGpV6rBC7PoXeCCLgIluTDMSfN8_1777662919
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 0D3AE4AF17C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.94 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-283273-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[onsemi.com:s=mimecast20250127];
	DMARC_POLICY_ALLOW(0.00)[onsemi.com,reject];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[onsemi.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.455];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CY8PR02MB9249.namprd02.prod.outlook.com:mid,onsemi.com:email,onsemi.com:dkim,onsemi.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email,devicetree.org:url]

QWRkIFlBTUwgZGV2aWNlIHRyZWUgYmluZGluZyBmb3IgdGhlIG9uc2VtaSBOQ04yNjAxMCBhbmQg
VFMyNTAwDQpJRUVFIDgwMi4zY2cgY29tcGxpYW50IEV0aGVybmV0IHRyYW5zY2VpdmVyIGRldmlj
ZXMuDQoNClNpZ25lZC1vZmYtYnk6IFNlbHZhbWFuaSBSYWphZ29wYWwgPFNlbHZhbWFuaS5SYWph
Z29wYWxAb25zZW1pLmNvbT4NCi0tLQ0KIC4uLi9iaW5kaW5ncy9uZXQvb25ubixuY24yNjB4eC55
YW1sICAgICAgICAgICB8IDcxICsrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwg
NzEgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L29ubm4sbmNuMjYweHgueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9vbm5uLG5jbjI2MHh4LnlhbWwgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L29ubm4sbmNuMjYweHgueWFtbA0K
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMC4uMTk4Y2Q3ZTlkDQotLS0gL2Rl
di9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L29ubm4s
bmNuMjYweHgueWFtbA0KQEAgLTAsMCArMSw3MSBAQA0KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRp
ZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0L29ubm4sbmNuMjYweHgueWFtbCMN
Ciskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMN
CisNCit0aXRsZTogb25zZW1pIE5DTjI2MDEwL1RTMjUwMCAxMEJBU0UtVDFTIE1BQ1BIWSBFdGhl
cm5ldCBDb250cm9sbGVycw0KKw0KK21haW50YWluZXJzOg0KKyAgLSBQaWVyZ2lvcmdpbyBCZXJ1
dG8gPFBpZXIuQmVydXRvQG9uc2VtaS5jb20+DQorICAtIFNlbHZhIFJhamFnb3BhbCA8U2VsdmFt
YW5pLlJhamFnb3BhbEBvbnNlbWkuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOiB8DQorICBUaGUgTkNO
MjYwMTAgYW5kIFRTMjUwMCBjb21iaW5lIGEgTWVkaWEgQWNjZXNzIENvbnRyb2xsZXIgKE1BQykg
YW5kIGFuDQorICBFdGhlcm5ldCBQSFkgdG8gZW5hYmxlIDEwQkFTReKAkVQxUyBuZXR3b3Jrcy4g
VGhlIEV0aGVybmV0IE1lZGlhIEFjY2Vzcw0KKyAgQ29udHJvbGxlciAoTUFDKSBtb2R1bGUgaW1w
bGVtZW50cyBhIDEwIE1icHMgaGFsZiBkdXBsZXggRXRoZXJuZXQgTUFDLA0KKyAgY29tcGF0aWJs
ZSB3aXRoIHRoZSBJRUVFIDgwMi4zIHN0YW5kYXJkIGFuZCBhIDEwQkFTRS1UMVMgcGh5c2ljYWwg
bGF5ZXINCisgIHRyYW5zY2VpdmVyIGludGVncmF0ZWQgaW50byB0aGUgTkNOMjYwMTAuIFRoZSBj
b21tdW5pY2F0aW9uIGJldHdlZW4NCisgIHRoZSBob3N0IGFuZCB0aGUgTUFDLVBIWSBpcyBzcGVj
aWZpZWQgaW4gdGhlIE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeA0KKyAgTUFDUEhZIFNlcmlhbCBJ
bnRlcmZhY2UgKFRDNikuDQorDQorICBTcGVjaWZpY2F0aW9ucyBhYm91dCB0aGUgTkNOMjYwMTAg
Y2FuIGJlIGZvdW5kIGF0Og0KKyAgICBodHRwczovL3d3dy5vbnNlbWkuY29tL2Rvd25sb2FkL2Rh
dGEtc2hlZXQvcGRmL25jbjI2MDEwLWQucGRmDQorICAgIGh0dHBzOi8vd3d3Lm9uc2VtaS5jb20v
cHJvZHVjdHMvaW50ZXJmYWNlcy9ldGhlcm5ldC1jb250cm9sbGVycy90MzBobTF0czI1MDANCisN
CithbGxPZjoNCisgIC0gJHJlZjogL3NjaGVtYXMvbmV0L2V0aGVybmV0LWNvbnRyb2xsZXIueWFt
bCMNCisgIC0gJHJlZjogL3NjaGVtYXMvc3BpL3NwaS1wZXJpcGhlcmFsLXByb3BzLnlhbWwjDQor
DQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGNvbnN0OiBvbm5uLG5jbjI2MHh4
DQorDQorICByZWc6DQorICAgIG1heEl0ZW1zOiAxDQorDQorICBpbnRlcnJ1cHRzOg0KKyAgICBk
ZXNjcmlwdGlvbjogfA0KKyAgICAgIEludGVycnVwdCBmcm9tIE1BQy1QSFkgYXNzZXJ0ZWQgaW4g
dGhlIGV2ZW50IG9mIFJlY2VpdmUgQ2h1bmtzDQorICAgICAgQXZhaWxhYmxlLCBUcmFuc21pdCBD
aHVuayBDcmVkaXRzIEF2YWlsYWJsZSBhbmQgRXh0ZW5kZWQgU3RhdHVzDQorICAgICAgRXZlbnQu
DQorICAgIG1heEl0ZW1zOiAxDQorDQorICBzcGktbWF4LWZyZXF1ZW5jeToNCisgICAgbWluaW11
bTogMTUwMDAwMDANCisgICAgbWF4aW11bTogMjUwMDAwMDANCisNCityZXF1aXJlZDoNCisgIC0g
Y29tcGF0aWJsZQ0KKyAgLSByZWcNCisgIC0gaW50ZXJydXB0cw0KKyAgLSBzcGktbWF4LWZyZXF1
ZW5jeQ0KKw0KK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4YW1wbGVzOg0KKyAg
LSB8DQorICAgIHNwaSB7DQorICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorICAgICAgI3Np
emUtY2VsbHMgPSA8MD47DQorDQorICAgICAgZXRoZXJuZXRAMCB7DQorICAgICAgICBjb21wYXRp
YmxlID0gIm9ubm4sbmNuMjYweHgiOw0KKyAgICAgICAgcmVnID0gPDA+Ow0KKyAgICAgICAgcGlu
Y3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCisgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8Jmdw
aW8+Ow0KKyAgICAgICAgaW50ZXJydXB0cyA9IDwyNSAyPjsNCisgICAgICAgIHN0YXR1cyA9ICJv
a2F5IjsNCisgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDI1MDAwMDAwPjsNCisgICAgICB9
Ow0KKyAgICB9Ow0KLS0NCjIuNDMuMA0KDQoNClB1YmxpYyBJbmZvcm1hdGlvbg0K


