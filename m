Return-Path: <netdev+bounces-286811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DLZKDoyAmrSowEAu9opvQ
	(envelope-from <netdev+bounces-286811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:47:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BDF5153CB
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F5F03046FA2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94434D2ED8;
	Mon, 11 May 2026 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="Nz+xmkDU"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E01318EDF
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528669; cv=none; b=FcnUmF/aS7Gr7kg+039vZEpg47upWb4d4tZQah5Bx8GDMjRymp4aj7KRrXHpU2atuNVx8eJwemlhxwIIORAQoHuIEjul3KNJjskaXhSxcuNoj4772haLOoyud2ieKNFFEDCNcxYD7Fkdfu8apJX/lHBZuI65EEQvRi6o/X58/dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528669; c=relaxed/simple;
	bh=YPPZZuLkil1U3K/2Fdi8RZbeqohx/8j7B6TBaYA96Ts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=fYSO3Ej0zuQp486trKijzaw32/BNuR+NJZRbZnBzPELqhvcWLuXvnw77uhanXqHbzYknAE0/k2mAlIT29YxHrKlCVVH+rRBL/bOcrNIcmeLnnhugfUhhOVWfVjOK5AwbZkhd1WVJUp4C1U85DbgcINBb8XvjOgCcTLmxDth9KO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Nz+xmkDU; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778528667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPPZZuLkil1U3K/2Fdi8RZbeqohx/8j7B6TBaYA96Ts=;
	b=Nz+xmkDU48E6rA6ROspuiwFuc3N1jf6ExQqz0smqjCkJfMvzmV72vwfqHRezQUJpUXHbvG
	Cwe+gStZAoBIZ47pbkjKxqo0PMufzlldgZp8GKR7zJj6hy9d4JlZkPX1HSJtldRAaTMjsP
	u7zK7et7kv114M6ynDSdMJpuh37yVkZE09o1SmUKutySa9OdxeK8jBsDsD5VuvovzN4Bhc
	AWl0aPYyvq/1pj6jpagdS4QnTVhVhTuX3ntUobi0BDXw26ZkURfzUO1u+EJsjpEuY0VIgz
	XumBY5XOIRqrDR6cfH2aLw/YDzEmCD64B/5HLhi3wOYZSYGE4bGXJ4zOrKw1tQ==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-43-0iE02MK1N1KACsp5xXcppA-1; Mon,
 11 May 2026 12:44:24 -0700
X-MC-Unique: 0iE02MK1N1KACsp5xXcppA-1
X-Mimecast-MFC-AGG-ID: 0iE02MK1N1KACsp5xXcppA_1778528660
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by PH7PR02MB9992.namprd02.prod.outlook.com (2603:10b6:510:2f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 19:44:17 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 19:44:17 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 3/9] net: phy: ncn26000: Added PHY loopback
 and read/write MMD callbacks
Thread-Topic: [PATCH net-next v2 3/9] net: phy: ncn26000: Added PHY loopback
 and read/write MMD callbacks
Thread-Index: AdzhcLiQPfhdO8TWRI6R6+3XYqpw1wACu2kAAACM4QA=
Date: Mon, 11 May 2026 19:44:17 +0000
Message-ID: <CY8PR02MB9249943F50B421C972FAEDE283382@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249CDA8F2C560FDD0F662D883382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <774d54e2-235c-4685-a582-f9714132923a@lunn.ch>
In-Reply-To: <774d54e2-235c-4685-a582-f9714132923a@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|PH7PR02MB9992:EE_
x-ms-office365-filtering-correlation-id: c680fd4e-6a7c-4248-512e-08deaf95b01e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|11063799003|38070700021|56012099003|22082099003
x-microsoft-antispam-message-info: ELmfIdDbVYJtOeaPTdNOFVRzmige9QsNfl2z7R/F08P+3ksD5jCcdSqYCpj/nVQSpMQlN3IVt7RMmMTu3y3KpWwLKV2nlPLgIZ78/Bi5aXiugOgO2NsO4L0sN+8Js6+DCQGGvbFIfqpCLe/5GBGJA8QZpoouPatDIZfKdyM8x5wWa6Vjtfu6M/NpToIpqSbxMp6oO1c7gq9ADnf6IX2Q/p/yT2Z9Vvn2iJdgv/iuLX+mic5T68trmbhAlV7TgVgEZ1M/FX4JOGrYJsFgEcYD4UEJBQXOQ2cyA7e29wnuoei5Dxwk/CcxPu+rRtGPdL7DfVfRt0plWUdID+ChodeD9Si5X4blGZ2l5SWmIXNDKwvYuu2RxBjqFcykZILwY98idiubQYeA2BgNXh+SJqhd+b8azwSlISi8XOA5KlxSvMCcKhM+Wxkk8AU5Uell+6yKapMv/0xqDVzNqdseaPYkz5C7hmd7blOd6AVUonN+IXqjxMR9GPISoKiJ4+/VlaLYPBNin0L8lRFHATwGKn9OOmIv0ev4Ek2Rc5JmWBI4Zm+S1n5YRFCU1Qa4lWhCNPIRly8+2WZ+9433Lm7hqP5T+xpBPmPFKGcSskNcH7YGlPy0ObpJRrLCuHYSvA39s5dixtL2mg2O1y+9+Fmfo4C/4amUbqsXMYc7U7aHOcdAyhXiie2tYBCAV5IWK345XQ6CeLao87jlc/UMM43TuK0IFDkQX9TFm21CHKC4GLDscutl8SwGFSBfRHvNzKw4vT5O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(11063799003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFdmWnQ2c0UrenNxRkluN2Jscmd0NFNnS1k4SHUrNVlIMS9kamtDcmVGaHhu?=
 =?utf-8?B?KzRqTzEzRjV1R0hETXNUMUc0WXNKOTBNZmZGNGxXcU1DeTc5UnlLUmtDNk5t?=
 =?utf-8?B?b1RQa2t3dmVDMEdVMG15NG9NUVYvVytDdElBSmJFY3BRUW9ycURjNTVFbnNr?=
 =?utf-8?B?MGN5Z3JrcEVYQTNLemNxVHh2YS9idE5DMHp2MG4zTUtOcE9hS2ZGMVRIOENl?=
 =?utf-8?B?ZXRSa2dQV2ZOUGgrUjdjc2lzSnZTOHphNlpCZ09LTWlaUmIzd21sbE9iejJt?=
 =?utf-8?B?UHIwelduaVRodGFSY0hNNzZOWUhuOW5qd0lMeDJLMjdORzRkNFB6YXVjTXpN?=
 =?utf-8?B?dUQyYWhHQThkREx5bGI1RXdsRklhL1lpTW1aM0tDUkUyM1VrTHhDRVpLdm83?=
 =?utf-8?B?eE4yQUlVWkRTNXpoMmE3ajhGdUFLQUdzQmxEQWF3TVAyRGJaNFNWWU5Mamsx?=
 =?utf-8?B?SWlLK1gwQmoxNkdBSllSV3NhL05zaWNUZmoxUTdDU0oydkswOVVLL0RPN1Fv?=
 =?utf-8?B?R3h0Z0c5blZXcno4cUVhaXJPTHhZQ1lhM1ZOK3Z5L2ZpeFdUcHFuZDhpUTh2?=
 =?utf-8?B?ZkZOWmlFUGxxMkdtL3ZaQjcwMnBXOGFDYmZkQ01VZVFSSlZ3SnFoNjZOOGNU?=
 =?utf-8?B?TjVIOTlRaUtTOEgxWXlvcy9JRkY0cTVTZXp5L01NbFMzOWJTc2IrbXpOcEM2?=
 =?utf-8?B?WFc0dVhNVkRiOWs0QXVRZmI1TkU2dXRza3plT3gvNDg0cWowZmJzTDEvUlpO?=
 =?utf-8?B?YlFqemlqekJzOVZoV3NNNzFndDA0bjZpVmFVWG1vcDYzYS83VXBjTWxSR1VW?=
 =?utf-8?B?aXBuVDRyT2E3M3ZBNG1JMjJiQnZiRVdNaGRzUXJNR1E4enZJN3FsZXhWNWF5?=
 =?utf-8?B?WlJ2K25vSk5XT0hkTDZRRkI3MFpGU1NkWFlwb0ZpKzMxUGdlZndoRC9HZTUr?=
 =?utf-8?B?LzRGWDI3TFp6Z2luNmJIMXNhODIrZGFCTkJJUEJ4WWpLeDh6VXZRMG5MY3oz?=
 =?utf-8?B?UWRiM1lnbDdTOWQxdGZKVmVvRVFveEpMV1VycHZwU3JaVlFOWjBkTzJITXhL?=
 =?utf-8?B?dFJwaHVoTkwzSlNLTXhRdkRmSHh4VVd3eWJySWRoQk9WQ1haMkJ4ZW1xOE5Q?=
 =?utf-8?B?MlJQaWVOZHZmb3B6UTNpUzQvNWwxUWllUEhQTVp0NHdjdDdFWlR3bW1pOHgy?=
 =?utf-8?B?WkFmZ3gwU1V6bStuTCtzeUNBTFhoY25GR2FtcUFvR2RRY2dXMXZXYmtjZTRK?=
 =?utf-8?B?WlFZYXlsd0pDelhsL3JoalZkOGxqSXNleFpBOGErMTQxR2liZkd3UUYwUHE3?=
 =?utf-8?B?WlRqbk4zZkc4dmdOZ0JDM2RmbCt0VzV1aG1kSHRLc0pLSjB0NjRLWGlsUHgv?=
 =?utf-8?B?ZEFkT2NSN2Y4KzUzTFlQLytEbDgyTjRPdEEvQVQ2aUwzdjNsQXZqaFhNa1Uw?=
 =?utf-8?B?MUxFcTR6NkhtSEFFNTJBOVJmc3YrVWo0cG9EYWREaHhZWFJTd2t1Tk1SWDFz?=
 =?utf-8?B?MWVoMWNFUmYyQTNkSFJlQThjTVFpUC9HU2RaWnZkNCs0OCtxcjJiN0E2TGxs?=
 =?utf-8?B?TXNFUURNYWFrM21oOXB1RDJUQndaZnpvYm9YdlRkSFMyMkt2MkdwS0N1Z09i?=
 =?utf-8?B?YWZNbDdOVlBDQUVUeitVVXV5QTJNRHdUY3dmd052YVo3aERhZWtvYmtZeU5O?=
 =?utf-8?B?RmJhZ2pZQ0w3NWRUWHBuekJyajRBTEVnQmlLWUY2U2hjNGlvdXY3UG9saUhH?=
 =?utf-8?B?QzRpTWZISUVhY3ZadFBuYmZhUmFpYmhtSlRwVFY1MTExRmpKRCtxZTh4dldP?=
 =?utf-8?B?QmhSTmE0bk5xUUcxNnhONmR5cGZxdU9HaWNSbXN1TEVmb0VMc2h2TTYwbThX?=
 =?utf-8?B?UjVITDZkR1RyNWo3dUxEU0J1Y2dXTWJBUW84Rjl5a2M1YzVjK2xUTC96dmh3?=
 =?utf-8?B?aUZvRThIRzJlYkJZb056LzkvdFQ2ZUNMQ1lWUXhzczZ0ZE9Rem01MCswQW91?=
 =?utf-8?B?WE82RCtCOVVqTEJkemk4UnNKRGhPeW1rNEZJbk85dGYwNEEzTGQxTGFVdEhh?=
 =?utf-8?B?T1EreEZRckZBZ1pJRGljK2x1MXJldjVqbHJKTHdWMUloN0hBT0RZcXoxMjBh?=
 =?utf-8?B?TUNTcFVIVS9URXJ1b2dSY2JaWGo0NTlVV244dHZncTdTOEc4bC9UL1ZoV1k1?=
 =?utf-8?B?VHQxUWpBeGVybDY0bHpxUmhaNTI0MCtYa2VaRjhKeVNrMGJReDNVSDlZb2U4?=
 =?utf-8?B?RGJDWDFab0c4MU9OU0RVYXNxN3ZuYjZNZk0yTlFLSmJwbVhFbjQrM2lKMmJI?=
 =?utf-8?B?bm1kcE9uK1RnT0ZVVktYanNqVW9pTElIV3JUcE5YK0JmMytMeTdJWExLTTli?=
 =?utf-8?Q?Ntth9EIgDtzIqG44=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ECgKhbJjMmuKsFYGNAvFRgEP8KxmuZP2aHjb7o+YqKEfPDL4c33K1JQjBjHvtrQDjGVq6QM9q5h2ZzbW3X9opHj65q8JzHFDLcF0cS1/PXPAXt6AqXP9vSmX51huZ7cr+qEIWB1YxdyTFnLkLTHXUgw3hV7hEyGl1I8nTrNmJ9neWHDd2gxWkCetfVKPGd97x72KKl4QSO1V1CZrixFuFKVFui9kfWrqGkuGrNQ2RNvsupUgA7K3nO/1nnuHOinici/6V9Wwm9SWVVWyQT7z+4cJtNfmvjeYnQm1lyWO2b5rEyokmJY+d7GEFV4pBhPGituCCB4EJPm76iRQ+BWRnQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c680fd4e-6a7c-4248-512e-08deaf95b01e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 19:44:17.2770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6vaf7AfEArHsLGelNAhuhAA8HaNLYWdxEKH1YFg//C7OudrnNB0fo1FIn7cNUGiWx5huAZPutUs3Mn2mGmWlwQeCt9QIoNBfvm9iC/ZktE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9992
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2RP9C-KHAhMd1G37mj39-r1onWR59wGWSDgSW0YFFik_1778528660
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 23BDF5153CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286811-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,onsemi.com:email,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

Wy4uXQ0KDQo+IA0KPiBPbiBNb24sIE1heSAxMSwgMjAyNiBhdCAwNjoxOToxMVBNICswMDAwLCBT
ZWx2YW1hbmkgUmFqYWdvcGFsIHdyb3RlOg0KPiA+IC0gUEhZIGxvb3BiYWNrIGhhcyB0byBzZXQg
b25seSBCTUNSX0xPT1BCQUNLIGJpdC4gQXMgYSByZXN1bHQsIHdlIGNhbid0DQo+ID4gdXNlIGdl
bmVyaWMsIGdlbnBoeV9sb29wYmFjay4NCj4gPiAtIERpcmVjdCBNTUQgY2FsbHMgdmlhIENsYXVz
ZSA0NSByZWFkL3dyaXRlIGF2b2lkcyBpbmRpcmVjdCBjYWxscy4NCj4gDQo+IFRoZSB0aHJlYWRp
bmcgb2YgdGhlIHBhdGNoIGFwcGVhcnMgdG8gYmUgYnJva2VuLg0KDQpJIGFtIG5vdCBjbGVhci4g
SSBkaWQgYXBwbHkgYWxsIHRoZSBwYXRjaGVzIGluIHNlcXVlbmNlIG9uIGEgZnJlc2ggc291cmNl
IHRyZWUuIEl0IGFwcGxpZWQgY2xlYW5seS4gV2hhdCBraW5kIG9mIGlzc3VlcyBJIHNob3VsZCB3
YXRjaCBvdXQgZm9yLCBmb3IgdGhlIGlzc3VlIG9mICJ0aHJlYWRpbmcgaXMgYnJva2VuIi4NCg0K
PiANCj4gQWxzbywgb25lIHBhdGNoLCBvbmUgdHlwZSBvZiBjaGFuZ2UuDQo+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNlbHZhbWFuaSBSYWphZ29wYWwgPFNlbHZhbWFuaS5SYWphZ29wYWxAb25zZW1p
LmNvbT4NCj4gPiAtLS0NCj4gPiBkcml2ZXJzL25ldC9waHkvbmNuMjYwMDAuYyB8IDM2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+IDEgZmlsZSBjaGFuZ2VkLCAzNiBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGh5L25jbjI2
MDAwLmMgYi9kcml2ZXJzL25ldC9waHkvbmNuMjYwMDAuYw0KPiA+IGluZGV4IDY4YjBlNDY0Ny4u
ZDMwMmUwNGM4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9uY24yNjAwMC5jDQo+
ID4gKysrIGIvZHJpdmVycy9uZXQvcGh5L25jbjI2MDAwLmMNCj4gPiBAQCAtMTYyLDYgKzE2Miwz
OSBAQCBzdGF0aWMgaW50IG5jbjI2MDAwX2NvbmZpZ19pbnRyKHN0cnVjdCBwaHlfZGV2aWNlICpw
aHlkZXYpDQo+ID4gcmV0dXJuIDA7DQo+ID4gfQ0KPiA+DQo+ID4gKy8qIERpcmVjdGx5IGFjY2Vz
c2luZyB2aWEgQ2xhdXNlIDQ1IHJlYWQgYXZvaWRzIHRoZSBleHRyYQ0KPiA+ICsgKiBTUEkgYWNj
ZXNzZXMgcmVxdWlyZWQgYnkgaW5kaXJlY3QgYWNjZXNzLg0KPiA+ICsgKi8NCj4gPiArc3RhdGlj
IGludCBuY24yNjAwMF9yZWFkX21tZChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LCBpbnQgZGV2
LCB1MTYgcmVnKQ0KPiA+ICt7DQo+ID4gKyBzdHJ1Y3QgbWlpX2J1cyAqYnVzID0gcGh5ZGV2LT5t
ZGlvLmJ1czsNCj4gPiArIGludCBhZGRyID0gcGh5ZGV2LT5tZGlvLmFkZHI7DQo+ID4gKw0KPiA+
ICsgcmV0dXJuIF9fbWRpb2J1c19jNDVfcmVhZChidXMsIGFkZHIsIGRldiwgcmVnKTsNCj4gPiAr
fQ0KPiANCj4gVGhpcyBuZWVkcyBtb3JlIGV4cGxhbmF0aW9uLiBNYXliZSB5b3UgbmVlZCB0byBs
b29rIGludG8NCj4gcGh5ZGV2LT5pc19jNDUuDQoNCkkganVzdCBmb2xsb3dlZCB3aGF0IGlzIGlu
IHRoZSBleGlzdGluZywgc2ltaWxhciAxMGJhc2UtdDFzIHBoeSBjb2RlLCBtaWNyb2NoaXBfdDFz
LmMuIA0KQ2VydGFpbmx5LCBJIHdpbGwgaW52ZXN0aWdhdGUgaXNfYzQ1IGZsYWcuDQoNCj4gDQo+
IEFuZHJldw0KDQo=


