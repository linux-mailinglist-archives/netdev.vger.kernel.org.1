Return-Path: <netdev+bounces-293197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHuYAKXgGWpmzggAu9opvQ
	(envelope-from <netdev+bounces-293197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:53:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 527346078AD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 305A7307AF3F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B69943CECB;
	Fri, 29 May 2026 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="ZTCU3bSp"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8CC426692
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079981; cv=none; b=rX2Fs7nq9/e8AuDpl7riTGVWVkBdF2wWG4zuazikkSzKgiB101pyYt6bPgAEc4gfVHKWBnW9OfEVxhDblhn82b+IJGWMGXz9zEaKV32VUMwTKhw0/DOGAVeyRbfgEKagMykn7InvBryeAqPKjCh02VVAEYu/r5hCKpgyXy8eluU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079981; c=relaxed/simple;
	bh=xhGHBRCvD1SQHCzUGtAZcikv1eEQqxaVk8PhT20ePU4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R+A+Cbj5cTYsgjbB6XTxDFd+OXNa+fX5U6zdYIf2TmZ7k2D8F8szhsvuFQGAXZ9R8AyMjg182tuQSN8A1JluhY95XLu6V2L0ieYpxUdVMkg2XlW5nTq6LVovxydgFyFWTzb+Dtsf4gF60ej+c/QbHFxLDnC2Pr99Kp7yKJvq3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=ZTCU3bSp; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780079972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xhGHBRCvD1SQHCzUGtAZcikv1eEQqxaVk8PhT20ePU4=;
	b=ZTCU3bSpWegba+78dIzSU1IGjbX5EsGTZf2jFcDZTMftiv3s3jcpYGE0h2QXc3I9bzxz3u
	PSe0nlVYl+LFZ8MAdYlHkmH1RXvIgGD5ehcj/wYACGRiLI/u863qh1HSxjq+GdyrZW4Xa/
	J2qtGqmG8yLzAOFgBS1uD8gOlriI/DaEb6sA67tsGuVFDImM7I3uQcV+Edaks2ZD1oZqkf
	/iaC+MKQ/n0JmjFtEjMiioU/nQyPaFYdXfQ0tJ15yCYpcluyycA61FQ55Ra89UcsRHw8fg
	LpcW33DyNbcRj1g5uexjTuyAu5Agypzyb4Bg6i4xqjzPB75dlzalZXlaDr46CQ==
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013013.outbound.protection.outlook.com
 [40.93.196.13]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-23-KjLLG1oRPb2GCP2wdM-b1A-1; Fri, 29 May 2026 11:39:29 -0700
X-MC-Unique: KjLLG1oRPb2GCP2wdM-b1A-1
X-Mimecast-MFC-AGG-ID: KjLLG1oRPb2GCP2wdM-b1A_1780079968
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DS0PR02MB9046.namprd02.prod.outlook.com (2603:10b6:8:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 18:39:25 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:39:25 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 01/14] net: phy: Helper to read and write through
 C45 without lock
Thread-Topic: [PATCH net-next v3 01/14] net: phy: Helper to read and write
 through C45 without lock
Thread-Index: Adzvl7kSA8f2NEwwReeTXXC5ZXjyZw==
Date: Fri, 29 May 2026 18:39:25 +0000
Message-ID: <CY8PR02MB92499C9080614FA3CEB8CD0483162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DS0PR02MB9046:EE_
x-ms-office365-filtering-correlation-id: ff946680-ce4e-4578-1d53-08debdb19bec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020|38070700021|18002099003|6133799003|3023799007|56012099006|11063799006
x-microsoft-antispam-message-info: mz6l1FVgGUt7zm1G12blsVg7FfZX02NLGTLsQH99zziKYC38K9ZMn92eSAjjgKtRGVBDWSpOy5FxLK8F+2F8ZWVuFD3pVdEwdBVONC51GILo6WhhkK0Kg3ybVRFnnxBznFDM/EfEIPT036tDeLrJU+PFNdpfnM93prBt/jeDoczoDwYPTziVnEkL9elCC3Y69dKVvP9K3ozJwLwv7fnzeT7TERPusKJZlNYf6kA8ix2DxSAvR07uUNFiW8HDhtEz2nkzZfhU81P3Fa+ifnAqPLj7qSNtz+s/xiqSxlTygNpUdfIi5HufbCPQteqftYEjRBLevsM2IpepAlpV6P/swbOQ+jyEb6fHz3fXWHzgiapl3CPTzs+vB8tgNjOtVja+PlQOdYX49LEc1Gp+Dyz7ykNrOADFnhOsvUBZ7G48K4VXwtYg/ST62CMKQg30rXwSe6ZPb+1Vu0ohwvP/0XqDxgKv830GHEuA/02qt0b0MLo3xe8zya1clIew4qxHPvT+BAxtTTq+c2r4Ccuo/QfNy2Vs+Mz/Pe1LIGZ+rfLwDS85xgP9H3B/lwNyQp9lJa+9fwCr7e+k6/Kl6Ee4Hq5SGC0asQqWyPvfCVhxmxJa13NuttgeGmw+ell4Nx+kj+884/CsD7zEv+QYalwXima0nvW++7vku4Ebwy7QHD2j3ZTiFWHBqRkUT79iNXYdfYxlQyykt5YNuemKxCK5+d7aRdzT6I+nh7iLhY9tOfwtZah+sfhn5cJHHiLhMuWnDkgeLDGc8VKoP/wo1Ba4//HIxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700021)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXd0bDgyYVRKTm5zMThzaVI5Vlhrb2dUSnhlUU1hWDQ2WHNtdlRUdGNTVlhH?=
 =?utf-8?B?Wks5WE0vOXB5bVZ0Q0gyZGFTSExPcWk5NlgwcnF2dXV1NjU1OS9VTDJpYUpl?=
 =?utf-8?B?T2dLcm5IOFpvY0l2WklwMncvajRlUWFQeXhvbGtvNTNBR092VDhWVHdIYmdn?=
 =?utf-8?B?MVV4VlNoL2pTdmtvMkF2QjRQa1VLL0lINFd2N3YvV1QzSGtjbFZBSjZxYzRY?=
 =?utf-8?B?ZmhlZkdjN3NvRmRYTk9PalplYkxBeUVuV1lqTDdMenVySUljc3dxNzB0eHp5?=
 =?utf-8?B?RituL0djZjh5bEJNdXo4dmJhOHJ1MHdkS2JGUmUyd1RIQjFUaEdxaCsvV3M3?=
 =?utf-8?B?SUc1Zk9ZQk0zUUpLWDJiV1A1MFFGRXZBeDF0TThEelJtZnlkY29zSTYzVjlv?=
 =?utf-8?B?OUFDUXVSenRuajg3TUhrZkcwZVFCcUwzMDNkRUVyTTFvTytFelBBeS8wazhZ?=
 =?utf-8?B?Vm5kcHUzNitOeHJKcXhsVlZrVlUwMUpuQk9zUGFKdDVDSDhMRU1SaSsyVTJK?=
 =?utf-8?B?SjBHRFd1VmdwQXhKZ2E1c1dVbmNtVkE3OEZlbW5aZkpDOHBsSStJTVVhU0Vm?=
 =?utf-8?B?Qzh4M2FYWWhtZ2x6cjlnWUtITkoxMm16K0RDZnhwMzR4WVBRQnZMcGF6cDQv?=
 =?utf-8?B?YTBsSG5CS3lSSkVSQXRJWlNCMndQVDFKclZZTGRGWjlKSGxTZC92QS9KLzRZ?=
 =?utf-8?B?Nmo2clNHZTlvM1FkR1dQTGNrNUo4YllqSkprRzZoNzBnY3A4aWJRNmRHNWxz?=
 =?utf-8?B?anQvRWJUOEFndUY2NVRVQ3Y1RHBzVktxbG5NWXJvYm5zMGw0SW0vM1BXcVJp?=
 =?utf-8?B?QVVuUFo2cmlUWHl2SE95VW5uYXBFOTE4Y2ZDdENLclhHWTFIaHJtcXhlSy9x?=
 =?utf-8?B?OWdrNEoyWWZxRWczZStLaUx0R1FNMDRSZUVFeVorQVkrYVBrZ21ndnNpWG1n?=
 =?utf-8?B?ZUJvekhCL2VjR2xQZ2MxL2dURzNzL1FiZGxLWFAyWmdDa3NSUGloTTVMbTlj?=
 =?utf-8?B?SGpaU2ZWWEsyZXFrSzNFMldLdkxveEtzcEVVL0M3SjF5ZlBjWDgwblNNMC81?=
 =?utf-8?B?d0VLdGE1dTBHRGcyQzFTSjNidERQNDhzYXVTVlZjQ00yZ1hKVlMyUWVKQTZh?=
 =?utf-8?B?RUpXcndUZWZCSHlYY3NKUmtGZG5HbytFcHpJSDQrZ1ZMQUVpNUpnQlJ5b2hw?=
 =?utf-8?B?WDBVOUYvS2E4K21jbHVNOE9zQzZUYXJwTmkwbWJTaXA4MTFBMlQ3eWFRMTMz?=
 =?utf-8?B?WVA1SmdOanJvYzVONGF2OHBtazZrdFp1R2tZcVVPNVNXaWd0VEhNVkhlM3FJ?=
 =?utf-8?B?UjlCQ1p5dHM4MHQrc2ZDb2lQOHlFK2NxMmRtMmtTRVU4bm5sS0NHUndtdExT?=
 =?utf-8?B?a00zNFpreTNybjhnU3lNNXRUbTFVd21aZnFBWUZhTnlCMzJScGhDQ0xIak50?=
 =?utf-8?B?cTFmeE5sSDdWaFJBRjNUajhoaHd2T2xxMVBCNzlsMURQSllPWVh1THg0Q0Jw?=
 =?utf-8?B?N09obmhXV1FSbkgzWG9RNFVVUkRXaUQ3VkpqQUFqdkdEWFdwSzlYNHY3Z0NB?=
 =?utf-8?B?bDlhQkNVTjFGaUc4VVNPZnJ0N0JIeUhNNEM5VVZIdXBvVmpZNUhQUXY2VFZw?=
 =?utf-8?B?WnBiNmt0KzNjWHhxWmJ0d0htWGJoQVh5K09OSnNlZ01abklTaXRJU0tadHI0?=
 =?utf-8?B?SXBtbjNpVkpseERseDhPaWFqbWVzUzFrN09nL3NKZTA4dUxWTFFmTTZtazkr?=
 =?utf-8?B?blZ0eTBIa0lDS3FDVXZPbEcrY0RDSjRQUjNxaTd3N25RVjljcys2U21RaW1k?=
 =?utf-8?B?U0kyc2xSWFdaZ1hpY0NxWnVmTE53cHRUUU0wZCtzSDBIK3hTMXZUZzhDSUJF?=
 =?utf-8?B?clYraXJpVGtvS2NGYVhoYzJIQ0F1UXFoVTlnblVzRnU1WFZ5ZlRnUklrazZl?=
 =?utf-8?B?b1kxRDYwazF3cGVqUTU4M05ITTVmS2cydTlpQlVDY1ZqVGtYMXczVVBwaXVO?=
 =?utf-8?B?UVgvamhWbDZFNmZCU2hRdVFWUkdPSkpXb0ZXbHpCUW1ZeEZDZk9wTFdobEdx?=
 =?utf-8?B?azBjemV6dzVkTDRrK2FwVy9iQzJUU0VicDQzcllsT2ZlMDRmUWNCZ0E4TkFW?=
 =?utf-8?B?MEUrSENiN0NYdkIxL2ZYdmNpUWQyTzI1U0tBVHFPMnJVRURIQ3ozMGtwQ1ht?=
 =?utf-8?B?RElmUjFzTmNMUlVUaktWUHBkTUhGaGYrS00xemhVc3NJeEI1RVAwUWJVUVRp?=
 =?utf-8?B?bjhYSkZtV2R0a3VWM3lWbUZ3Y2ltdTNvNlczMWg4ZExENGM4RmRRZEhVdnkr?=
 =?utf-8?B?d2V3T205cVhOZVdqUUhjcXR2TXU3R2Iyd1hhODduZmdadytLOHpNM3ZxdVAy?=
 =?utf-8?Q?yrOw9oJQDib4s3LA=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QoU968m68zjsGKtUCMhrvZuNw/k8YggyCmfNGb2he3gmbZ/l4MN+U6onVq6FVdA8wav16L0ZUYS730LGDO2oiHt8HqWYxoDEUOQnMwMbZldPshqOGCtHv4ZnEeefUYsUnmhIpAvYSzNsAS0eO4XhFjzdCp/YzVuLij7WMCPdb3/z5TZFZy4A2qVMXX2IJ03LYw+SeKCUIjEwLtxh7IU0rwkZglZxbc4jaHvB5l2ha5LblxE6f9Spr3QrdCQ6h6U4oQS/Z3LEnV4muLpyKH/TSwIh01yulaOgQFH2ZJXUWuo/jiJ4cw6sIgbcvFxEON1p7Q8W80lQLLeS8TEzH+YtNg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff946680-ce4e-4578-1d53-08debdb19bec
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:39:25.5571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KG9XxQZBRHAImhOkAOsAiRuZayx+LlDfW9rWrHYqsSazKOkatWISHzjv5Ue5UyMh3LBLxhLzoXcTtQ28zvGggKOESOpLEIiyVAe0Ngw2e5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9046
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yo2IB1_rc25onhsk_az0bZMNCx-w0yKzGoI2pKE9-m8_1780079968
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293197-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[onsemi.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid,onsemi.com:email,onsemi.com:dkim]
X-Rspamd-Queue-Id: 527346078AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

R2VuZXJpYyBoZWxwZXIgZnVuY3Rpb24gdG8gaW5pdGlhdGUgcmVhZCBhbmQgd3JpdGUgdGhyb3Vn
aCBDNDUgYnVzDQpwcm90b2NvbCB3aXRob3V0IG1kaW8gYnVzIGxvY2suIFRoaXMgd2lsbCBoZWxw
IFBIWXMgdG8gYXZvaWQgaW5kaXJlY3QgQzIyDQpBUEkgY2FsbHMgZm9yIEM0NSBidXMgcHJvdG9j
b2wgd2hpY2ggbWF5IG5vdCBiZSBzdXBwb3J0ZWQgYnkgdGhlIFBIWS4NCg0KU2lnbmVkLW9mZi1i
eTogU2VsdmFtYW5pIFJhamFnb3BhbCA8U2VsdmFtYW5pLlJhamFnb3BhbEBvbnNlbWkuY29tPg0K
LS0tDQogZHJpdmVycy9uZXQvcGh5L3BoeV9kZXZpY2UuYyB8IDQ5ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvcGh5LmggICAgICAgICAgfCAgNCAr
KysNCiAyIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3BoeS9waHlfZGV2aWNlLmMgYi9kcml2ZXJzL25ldC9waHkvcGh5X2RldmljZS5j
DQppbmRleCAzMzcwZWI4MjIwMTcuLmJhZDY2N2RiYjk5YiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
bmV0L3BoeS9waHlfZGV2aWNlLmMNCisrKyBiL2RyaXZlcnMvbmV0L3BoeS9waHlfZGV2aWNlLmMN
CkBAIC0yNzgxLDYgKzI3ODEsNTUgQEAgaW50IGdlbnBoeV93cml0ZV9tbWRfdW5zdXBwb3J0ZWQo
c3RydWN0IHBoeV9kZXZpY2UgKnBoZGV2LCBpbnQgZGV2bnVtLA0KIH0NCiBFWFBPUlRfU1lNQk9M
KGdlbnBoeV93cml0ZV9tbWRfdW5zdXBwb3J0ZWQpOw0KIA0KKy8qKg0KKyAqIGdlbnBoeV9waHlf
cmVhZF9tbWQgLSBIZWxwZXIgZm9yIHJlYWRpbmcgYSByZWdpc3RlciB3aXRob3V0IGxvY2sNCisg
KiBmcm9tIHRoZSBnaXZlbiBNTUQgYW5kIFBIWS4NCisgKiBAcGh5ZGV2OiBUaGUgcGh5X2Rldmlj
ZSBzdHJ1Y3QNCisgKiBAZGV2bnVtOiBUaGUgTU1EIHRvIHJlYWQgZnJvbQ0KKyAqIEByZWdudW06
IFRoZSByZWdpc3RlciBvbiB0aGUgTU1EIHRvIHJlYWQNCisgKg0KKyAqIERlc2NyaXB0aW9uOiBQ
SFlzIGNhbiBoYXZlIGJvdGggQzIyIGFuZCBDNDUgcmVnaXN0ZXJzIHNwYWNlLiBPbmNlIFBIWQ0K
KyAqIGlzIGRpc2NvdmVyZWQgdmlhIEMyMiBidXMgcHJvdG9jb2wsIGl0IHVzZXMgQzIyIGluZGly
ZWN0IGFjY2VzcyB0bw0KKyAqIGFjY2VzcyBDNDUgcmVnaXN0ZXJzLiBTb21lIFBIWXMsIGxpa2Ug
MTBCYXNlLVQxUyBQSFlzIGRlZmluZWQgYnkgT1BFTg0KKyAqIEFsbGlhbmNlIDEwQkFTReKAkVQx
eCwgc3VwcG9ydCBvbmx5IGRpcmVjdCBhY2Nlc3MuDQorICoNCisgKiBJZiBQSFkgaW5kaWNhdGVz
IEM0NSBzdXBwb3J0IHRocm91Z2ggRFRTIGVudHJ5LCBpdCBhdm9pZCBDMjIgQVBJcw0KKyAqIGVu
dGlyZWx5IGFuZCB0aGVyZWZvcmUgZ2VuZXJpYyBNRElPIHJlZ2lzdGVycyBhcmUgaW5hY2Nlc3Np
YmxlLg0KKyAqDQorICogTURJTyBidXMgaXNuJ3QgbG9ja2VkIGhlcmUgYmVjYXVzZSB3aGVuIGNh
bGxlZCB0aHJvdWdoIHJlYWRfbW1kDQorICogY2FsbGJhY2sgb2YgcGh5X2RyaXZlciwgY2FsbGVy
IGlzIGV4cGVjdGVkIHRvIGxvY2sgdGhlIGJ1cyBhcw0KKyAqIGltcGxlbWVudGVkIGluIHBoeV9y
ZWFkX21tZC4NCisgKi8NCitpbnQgZ2VucGh5X3BoeV9yZWFkX21tZChzdHJ1Y3QgcGh5X2Rldmlj
ZSAqcGh5ZGV2LCBpbnQgZGV2bnVtLA0KKwkJCXUxNiByZWdudW0pDQorew0KKwlzdHJ1Y3QgbWlp
X2J1cyAqYnVzID0gcGh5ZGV2LT5tZGlvLmJ1czsNCisJaW50IGFkZHIgPSBwaHlkZXYtPm1kaW8u
YWRkcjsNCisNCisJcmV0dXJuIF9fbWRpb2J1c19jNDVfcmVhZChidXMsIGFkZHIsIGRldm51bSwg
cmVnbnVtKTsNCit9DQorRVhQT1JUX1NZTUJPTChnZW5waHlfcGh5X3JlYWRfbW1kKTsNCisNCisv
KioNCisgKiBnZW5waHlfcGh5X3dyaXRlX21tZCAtIEhlbHBlciBmb3Igd3JpdGluZyBhIHJlZ2lz
dGVyIHdpdGhvdXQgbG9jaw0KKyAqIHRvIHRoZSBnaXZlbiBNTUQgYW5kIFBIWS4NCisgKiBAcGh5
ZGV2OiBUaGUgcGh5X2RldmljZSBzdHJ1Y3QNCisgKiBAZGV2bnVtOiBUaGUgTU1EIHRvIHdyaXRl
IHRvDQorICogQHJlZ251bTogVGhlIHJlZ2lzdGVyIG9uIHRoZSBNTUQgdG8gd3JpdGUNCisgKiBA
dmFsOiAgICBWYWx1ZSB0byB3cml0ZQ0KKyAqDQorICogRGVzY3JpcHRpb246IFNpbWlsYXIgdG8g
Z2VucGh5X3BoeV9yZWFkX21tZA0KKyAqLw0KK2ludCBnZW5waHlfcGh5X3dyaXRlX21tZChzdHJ1
Y3QgcGh5X2RldmljZSAqcGh5ZGV2LCBpbnQgZGV2bnVtLA0KKwkJCSB1MTYgcmVnbnVtLCB1MTYg
dmFsKQ0KK3sNCisJc3RydWN0IG1paV9idXMgKmJ1cyA9IHBoeWRldi0+bWRpby5idXM7DQorCWlu
dCBhZGRyID0gcGh5ZGV2LT5tZGlvLmFkZHI7DQorDQorCXJldHVybiBfX21kaW9idXNfYzQ1X3dy
aXRlKGJ1cywgYWRkciwgZGV2bnVtLCByZWdudW0sIHZhbCk7DQorfQ0KK0VYUE9SVF9TWU1CT0wo
Z2VucGh5X3BoeV93cml0ZV9tbWQpOw0KKw0KIGludCBnZW5waHlfc3VzcGVuZChzdHJ1Y3QgcGh5
X2RldmljZSAqcGh5ZGV2KQ0KIHsNCiAJcmV0dXJuIHBoeV9zZXRfYml0cyhwaHlkZXYsIE1JSV9C
TUNSLCBCTUNSX1BET1dOKTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BoeS5oIGIvaW5j
bHVkZS9saW51eC9waHkuaA0KaW5kZXggMTk5YTdhYWEzNDFiLi44MjY2ZGQ0YThkYmUgMTAwNjQ0
DQotLS0gYS9pbmNsdWRlL2xpbnV4L3BoeS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3BoeS5oDQpA
QCAtMjMwMSw2ICsyMzAxLDEwIEBAIGludCBnZW5waHlfcmVhZF9tbWRfdW5zdXBwb3J0ZWQoc3Ry
dWN0IHBoeV9kZXZpY2UgKnBoZGV2LCBpbnQgZGV2YWQsDQogCQkJCXUxNiByZWdudW0pOw0KIGlu
dCBnZW5waHlfd3JpdGVfbW1kX3Vuc3VwcG9ydGVkKHN0cnVjdCBwaHlfZGV2aWNlICpwaGRldiwg
aW50IGRldm51bSwNCiAJCQkJIHUxNiByZWdudW0sIHUxNiB2YWwpOw0KK2ludCBnZW5waHlfcGh5
X3dyaXRlX21tZChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LCBpbnQgZGV2bnVtLA0KKwkJCSB1
MTYgcmVnbnVtLCB1MTYgdmFsKTsNCitpbnQgZ2VucGh5X3BoeV9yZWFkX21tZChzdHJ1Y3QgcGh5
X2RldmljZSAqcGh5ZGV2LCBpbnQgZGV2bnVtLA0KKwkJCXUxNiByZWdudW0pOw0KIA0KIC8qIENs
YXVzZSAzNyAqLw0KIGludCBnZW5waHlfYzM3X2NvbmZpZ19hbmVnKHN0cnVjdCBwaHlfZGV2aWNl
ICpwaHlkZXYpOw0KLS0gDQoyLjQzLjANCg0K


