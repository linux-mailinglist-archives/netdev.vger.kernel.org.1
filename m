Return-Path: <netdev+bounces-305463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kX3SFXYATWowtQEAu9opvQ
	(envelope-from <netdev+bounces-305463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:34:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D61971BF6C
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:34:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=RCPt9OSG;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305463-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305463-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E150302AD16
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1FC41736F;
	Tue,  7 Jul 2026 13:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44503414DCD;
	Tue,  7 Jul 2026 13:29:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430985; cv=fail; b=ccS7OhpHs+2mCZsYJHM/RL7zGUf6vR2HDGV/AojpvPEekuSICkLJ2LlNc8MAtCIoc5p4APDGGPshAa+/u06iin6C5Hh7xKKDVyBUk9cRT2MdvAN0Yjkp+F9n5xxTlp/UUbonsviPIwQ2H92Z0ISahevcliByCz3+qP0EJtg6cCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430985; c=relaxed/simple;
	bh=hF/gBs/s6E4ffgPBIYrziQK8gsG+bD1I8gLybbv3JhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tHAguJZSSpdeUtHRyrFPksI5Q4MfcRr/GPq6UA680QxBvOZ/kYMJMjA7+pJ2xEJTyjG6DMWRX1sueZN6xG4SJKzZXWokAa51LvOMMocl0ZDC1iokpDXrbuVd6ouWdMC5sF+9/E06zJWmbl/ryr+ZVfDaDkmleQGcs9k/LJ6R8xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=RCPt9OSG; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5zvVXpuLuAq4/H7epdSkcAfHbcjZXYMzyRmuM/u/kuhI439jYmFWZX4Om5cGdX+unOAk82W1yo+HUh2UQZ6lnr/g2uF2uppqXznnrt1Cqvhq+VfTTeh9VY09tQbLubIz7BrhTbOHAIuh3YDe1Wf5cE8GwT09G8o8HeFuszkFsb89JUUwUolND+t/38xg1kRr09LqBlfgfjbq/+WCZ3K7avjWmhJehIYMRZBbg23giBwT53EHp7vAGeD18h4NgercBW0W43IpA8WkB3q/HWHxL1Z3awVKlqkQUZfjD6wUA7mP8SP5/EftfzYvFzrx4YAoOcQV1I7yoqXzn6R91nN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF/gBs/s6E4ffgPBIYrziQK8gsG+bD1I8gLybbv3JhQ=;
 b=kh5OJZu1T41auWS8CcskdvOgbe+TvG3IjynHgG/msVdemHsK0WNu8MnkUG8fQuUkrTHz+0+fFTqeLuwBslI7tAYT+yejlnMb3fqYO/QKRzYF5S5sdc6WWYmu0fIoJmLf8bUfw432h68NOqM3ecL1KG9NbzJI38lothloDyQ97haYb2Ry1jjGVm2JcMxvhKmdKwxdwld8E9lGN4pyjmce5NmEVDdUutHurNb4jFFpe3QR35US5LQYjmcI9yWa6mqQ4BnvNLVCNKNRUALnOALmVT1AZj2rcvGf4r2UpbCENLkHXWGKtepNtsvzFKWCKDdLUw8VICKr62fkHCorcqADlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF/gBs/s6E4ffgPBIYrziQK8gsG+bD1I8gLybbv3JhQ=;
 b=RCPt9OSG7XBwcEJjsj2zq0vnwyLl+hyNlQagOWiNt7uNmjdK0B518T3zz463/X42p14rQb2saOBvmNfkH65gwqR2qmtwdyNb0oeHSIJ+mVCv3iktw6dtkRHS7P/EFJeGl/irmVCkHpgLtrw60xy/AJ2oBDu4XYsCUODHhs4Sdi7IeGSGy+u43znKm847iSQmcAsCTvg733DgOqBJXi9JKRcrkwRvruhMBlY76rRvyxFauiGvJg7QNZU0+FJZTUyC28vfWle9GUO/SJt4QZLKHU+2aawRby8DSqhLfKM8CPCIAixQzs+G6Mk/rmSSQr1MB6uEXLfjNLbGJoB3Mu3buw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PR3P189MB1066.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:29::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.9; Tue, 7 Jul 2026 13:29:41 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 13:29:41 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Cen Zhang <blbllhy@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "AutonomousCodeSecurity@microsoft.com"
	<AutonomousCodeSecurity@microsoft.com>, "tgopinath@linux.microsoft.com"
	<tgopinath@linux.microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net] tipc: fix u16 MTU truncation in media and bearer MTU
 validation
Thread-Topic: [PATCH net] tipc: fix u16 MTU truncation in media and bearer MTU
 validation
Thread-Index: AQHdDYNs7P45zs38MkOIv+OeM49grrZiDZWw
Date: Tue, 7 Jul 2026 13:29:40 +0000
Message-ID:
 <GV1P189MB198837B4F3A78F2A11C9614CC6F02@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com>
In-Reply-To:
 <CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PR3P189MB1066:EE_
x-ms-office365-filtering-correlation-id: 9d2b8f4b-027d-44d9-0db1-08dedc2bccbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|38070700021|6133799003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 O6tbZB5/Q6xo+9sun+w9cRqEbM25TdnVFeQ8VLqZ3+w0JXla6ws1vQ/eDQ11d8OGhuTSvJCGYXVcfX+J6rZHDRBgqPRQquLAIJyTEfyg8T2G9kTge6WD2ZOyd+5wEEGTklcFnPIvofoDKkVXIF0NzOOmIZ/+4oDVzEO4oRPR3N8jLtzBAdyeV3g80tUYFqJiLVU80BMx87kjrCYV2e4qngfWRewvs69+cDMjfA+3XG76u0T865PTP8Yy6Q0Ga5fozE1Qrf7kYwzahtscAlHrnjTWsXdwyj4S62jKJ9RtPAhUVyOjhM3hgCch25LqrSL73hBOZd+/ZNaj+n9Bxg8vHq5681+kpk9+hxJEcs9/is4SZuOlZT1KX+zuPRaiGe8QxLrvoSQS+J3+Quutg5d36Xu0QpB8cEJA0zPdNOI5m2q4DI9KXK23ON5/Q99/Kdhlz7c5llZ1oLjxaOMT6mwkjOYwZLoj7DNAj93ovLox+uTTZZTT7xFdUw7vTBu5DShceDmvxstagCEc0l0xZTxbo5TaC74ixtN/hZJqc/L2kqm/0Aaz6V5vkG43dqzQyGJ9bYC+82Mzyej/cP4e2qb9Lnl2NbccWLzf5ZwGaVGZIcJwR22ZwyyH3taUy4xAJaz9qD+UnB1M6B7WZjRV0OJeg7M+oGpV2nyG8CH6BgqxJ+dJINuT4KzHU+t/qyWG7SVdiVhyzzJPhHI//z3kDk4CwtLL0NfIPnvZaNMfTwVV+Pg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(38070700021)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzdhMXlXWStJNERTSjZtbzhtMVpSMHZVRHBKYk9IeWJtL3NUUDhmRnFiMHVU?=
 =?utf-8?B?ZU5PRUczNWlUQmp4OTk1YXpXTDRsWjdEZktpY2lnS3Bvb2s5em4wK0tGUWJo?=
 =?utf-8?B?ZFpxZDNFRmw2c0s1UkpUQ3h0MHNnVWE0Nk45TTZQYWtiRmZOOGdhNGU5dmpz?=
 =?utf-8?B?Y21MSW9WUnN5ZnlOdCtlakE1RGlnSlFtbEhXRnN5TTNBckc4SWUrUXpsVEdL?=
 =?utf-8?B?TTEyaWVJRXZETi9xSENXcDhpbWl6VDNqMHBTVm90U05wTG5nUHdrWFY4V3lQ?=
 =?utf-8?B?U3JpMEhudENmTjlxeko0U1ZrZnRyNWZmOUVPWE9UbWRpb3Bya0Q5Wkx5MUVT?=
 =?utf-8?B?NEZCQ2w3ZnBSeVR4c1dYQTJrckRsOE9ZRVBrak05aDdaUEFkazZrTDR4VjY5?=
 =?utf-8?B?aHd6a0o4UnJPdTZaL3ZybW1KZEtaMVNyU3pUWW4xbzU2TCtTbUhsemcvcHpy?=
 =?utf-8?B?cm9MYU1xSklDZTNMeVlQSFZYazZZQWs0aGZIUEtjK2tvaHQ4QXNJMVYwNlJo?=
 =?utf-8?B?b1pGMU5vZ3ZCNHVUMTRmdkJJTTRSWWlYczRmSjd3YmpabEVqa1FYck5NS2ZI?=
 =?utf-8?B?cGdPN2pkdm9jeWJTcjdCUndZUzdBUzREbkZBUHJpb0UvTEttcWU5a1BjQmtQ?=
 =?utf-8?B?VEo4OXkyR1JhVll0dFZWZTNVdmhwTFZmSWUrdFlib0UrdEpIMDdyd2dlcFZI?=
 =?utf-8?B?Zm9JTi9QQnhrQUtwdFFqMjhPdkNteDFIWDNhWDk0TUZObVRYK3FQTEoyY0hh?=
 =?utf-8?B?TVBrWU5GOWRkTC9EVXg4OUxHRkJqK0pYWUJmZ1dMZ2JYSUZyNGFzbXYrbkpz?=
 =?utf-8?B?bjduM2M1R2MzcU5lSnJuUEhJZmRWUUUzWEs5bVB5NzFKMHBNUHZmWVdkemlC?=
 =?utf-8?B?WVV5VnlUb2dNdEMzUGF2L1FaT1ZuR1ZBMVJXallyRDZzRGZnT20rZEVvVWRv?=
 =?utf-8?B?aWhZNVJ2ZktoWEVtd3BCR1NVd1pXR1VqQzB4eTdrZXVjd0FyOGZuT2xPYjRu?=
 =?utf-8?B?eXhrWHdBejMxZ1J6clNEYzl4Y0lIMHdvcitobUp2UkZISTJ5dW9sMWhNc2tK?=
 =?utf-8?B?bkpXUXc3L0RKUXVVVGpqSEI1SVd3U1hCbUpsMDFnRngvaE15ZmplaUZNeEhY?=
 =?utf-8?B?b3RaU05wQnAvUDVXb1BUcGphSTMvVmZTTnY5MnNma2w5S1lQbkNMWkJ5MFd5?=
 =?utf-8?B?QXRuNFBhZEdMdUdQVWZMNTlzSjhGTlFKbnZZek1FaWdmaC9xZFdLZ244Ymw3?=
 =?utf-8?B?YTFBcm9OMytPeWVyZTd5RTNQWUsvMGc4Y0luMXV6UmlkWEUzcXQvT1pvd0do?=
 =?utf-8?B?dzZ0QlFBUVVuTFN3STZnNWh4QnFNT0swQ1VoaVYyTHRFNEtjV3RlajNVMkdw?=
 =?utf-8?B?d2Z1RlgzVVhUbVduQWtWR2lKZHBYTDJ4NUJ4RWFscmk3eXI3TU5ERWFzeCsr?=
 =?utf-8?B?Q3FKck81ZUpZRTRBTmlYMCtjOEgwT2Z4d2twQVp1dDkwa1I5bG5nTVU5akZa?=
 =?utf-8?B?dUJCU0JiL1N3eWlOb0FtNlRGSTZsbDY2VE50K3RLMzJTUVlvU0NnY2E2MStS?=
 =?utf-8?B?aHZBT1hoaUluOXp4bTdNcE5MaXB5NmkwV3pLRDZyNUthMXU0NGNFbUVlZ2tC?=
 =?utf-8?B?VlhJTGwxVHhpeTU1UW1XN3RFckc2T2RBWDY1QWFHTUNPYXFxYldWdThucGlI?=
 =?utf-8?B?dEZ0RHpMNTlETU56aXdoRGtKRW9MQkgxdEQrNXdFTTZzS3dBU0tSTXluTlc5?=
 =?utf-8?B?S0xsczBneVM4M1Q3bGozOWI5TFpETUs4N3FSYXd5YnJyNzNEbjNHWjBrYW1n?=
 =?utf-8?B?amR0VW9oS01VZkxVMTd3MzNRQXdWZXZzM21UTzVMMktJeXNRandYM1oyeTRp?=
 =?utf-8?B?alI0UWpXaTJkVXR1Wlo5akJEMEVuZ2grVFRxL2JvL05ObDVYNElwaHNBaWpZ?=
 =?utf-8?B?aXFNMmdiaHEyMTRYdVUrRHE2VEZLT0FLTDNydFcydjJraHhYbUIvSmdzSHN3?=
 =?utf-8?B?VUhNOHczWTN1Mi85cENZMlh0alFBaG9aeFo4OVZ5ZDBzblZZcmdKWVM0WG9Z?=
 =?utf-8?B?amxSTVdtRXhOL0wwVjEzcGxSZG04T1FQTEU5UjByU0VxbEpObXJ6S2h3NDZI?=
 =?utf-8?B?eXZoQ2l2dkx5dmlKOGtEQ21BQkhmRG4rUGpnOTRKS1lQOTNsa0pZb2tDZTh6?=
 =?utf-8?B?Vm8rRGQ1R0p2aTVjTWdWME03MjZhdlkvRWVlaHhGa2V0STBlb3doc2JuTFFG?=
 =?utf-8?B?SGlBZ2YxWDB6dVJOc0ZZa0J3WFBySmJ2Z2Qyb3hnWlNWY0dkODRCbHptNkZW?=
 =?utf-8?B?MEp2RHgrVWs4Q1pvRDdyRVptcUJMczFJNXV3c0liem94T1BQMnN2UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2b8f4b-027d-44d9-0db1-08dedc2bccbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 13:29:40.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qiuHqEyx0tFtOYx/1ap6UC7yIeSk3ntala1oqoLnCxZ7bZXDyQnhwydunKOqNMkQJ65udjPD0KCZaLDJvY0z87UFdsc9lVzTy5MrjqcFoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB1066
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:blbllhy@gmail.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[est.tech];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305463-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[est.tech:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,est.tech:from_mime,est.tech:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D61971BF6C

PlN1YmplY3Q6IFtQQVRDSCBuZXRdIHRpcGM6IGZpeCB1MTYgTVRVIHRydW5jYXRpb24gaW4gbWVk
aWEgYW5kIGJlYXJlciBNVFUNCj52YWxpZGF0aW9uDQo+DQoNCllvdXIgcGF0Y2ggY2Fubm90IGJl
IGFwcGxpZWQgY2xlYW5seSB0byBuZXQgdHJlZS4gSSBjYW5ub3QgYnVpbGQgYW5kIHJ1biB0ZXN0
Lg0KUGxlYXNlIHJlYmFzZSB5b3UgcGF0Y2ggYmVmb3JlIEkgcmV2aWV3IGl0Lg0KDQo+Qm90aCBU
SVBDX05MX01FRElBX1NFVCBhbmQgVElQQ19OTF9CRUFSRVJfU0VUIGFjY2VwdCB1c2VyLXN1cHBs
aWVkDQo+TVRVIHZhbHVlcyBidXQgb25seSBlbmZvcmNlIGEgbWluaW11bSBib3VuZCwgbm90IGEg
bWF4aW11bS4gV2hlbiBhIHVzZXINCj5zZXRzIHRoZSBNVFUgdG8gYSB2YWx1ZSBleGNlZWRpbmcg
VTE2X01BWCAoNjU1MzUpLCBpdCBwYXNzZXMgdmFsaWRhdGlvbiBidXQgaXMNCj5zaWxlbnRseSB0
cnVuY2F0ZWQgd2hlbiBhc3NpZ25lZCB0byB1MTYgZmllbGRzIGwtPm10dSBhbmQNCj5sLT5hZHZl
cnRpc2VkX210dSBpbiB0aXBjX2xpbmtfY3JlYXRlKCkuIFZhbHVlcyBsaWtlIDY1NTM2ICgweDEw
MDAwKQ0KPnRydW5jYXRlIHRvIDAsIGNhdXNpbmcgYSBkaXZpc2lvbiBieSB6ZXJvIGluIHRpcGNf
bGlua19zZXRfcXVldWVfbGltaXRzKCkgd2hpY2gNCj5jb21wdXRlcyBUSVBDX01BWF9QVUJMIC8g
KGwtPm10dSAvIElURU1fU0laRSkuIE90aGVyIG92ZXJmbG93aW5nIHZhbHVlcw0KPihlLmcuIDY1
NTM3LTEzMTA3MSkgcHJvZHVjZSBzbWFsbCBpbmNvcnJlY3QgTVRVIHZhbHVlcywgcmVzdWx0aW5n
IGluIGxpbmsNCj5tYWxmdW5jdGlvbiBiZWhhdmlvcnMuDQo+DQo+Q3Jhc2ggc3RhY2sgKHRyaWdn
ZXJlZCBhcyB1bnByaXZpbGVnZWQgdXNlcik6DQo+DQo+ICB0aXBjX2xpbmtfc2V0X3F1ZXVlX2xp
bWl0cyAgbmV0L3RpcGMvbGluay5jOjI1MzENCj4gIHRpcGNfbGlua19jcmVhdGUgICAgICAgICAg
ICBuZXQvdGlwYy9saW5rLmM6NTIwDQo+ICB0aXBjX25vZGVfY2hlY2tfZGVzdCAgICAgICAgbmV0
L3RpcGMvbm9kZS5jOjEyNzkNCj4gIHRpcGNfZGlzY19yY3YgICAgICAgICAgICAgICBuZXQvdGlw
Yy9kaXNjb3Zlci5jOjI1Mg0KPiAgdGlwY19yY3YgICAgICAgICAgICAgICAgICAgIG5ldC90aXBj
L25vZGUuYzoyMTI5DQo+ICB0aXBjX3VkcF9yZWN2ICAgICAgICAgICAgICAgbmV0L3RpcGMvdWRw
X21lZGlhLmM6MzkyDQo+DQo+VHdvIGluZGVwZW5kZW50IHBhdGhzIGxhY2sgdGhlIHVwcGVyIGJv
dW5kIGNoZWNrOg0KPjEuIHRpcGNfdWRwX210dV9iYWQoKSAtLSBjYWxsZWQgZnJvbSBfX3RpcGNf
bmxfbWVkaWFfc2V0KCkgKE1FRElBX1NFVCkgMi4NCj5pbmxpbmUgY2hlY2sgaW4gX190aXBjX25s
X2JlYXJlcl9zZXQoKSBhdCBiZWFyZXIuYzoxMTYwIChCRUFSRVJfU0VUKQ0KPg0KPkZpeCBib3Ro
IGJ5IHJlamVjdGluZyBNVFUgdmFsdWVzIGFib3ZlIFUxNl9NQVguDQo+DQo+Rml4ZXM6IDkwMTI3
MWUwNDAzYSAoInRpcGM6IGltcGxlbWVudCBjb25maWd1cmF0aW9uIG9mIFVEUCBtZWRpYSBNVFUi
KQ0KPlJlcG9ydGVkLWJ5OiBBdXRvbm9tb3VzQ29kZVNlY3VyaXR5QG1pY3Jvc29mdC5jb20NCj5T
aWduZWQtb2ZmLWJ5OiBDZW4gWmhhbmcgKE1pY3Jvc29mdCkgPGJsYmxsaHlAZ21haWwuY29tPg0K
Pi0tLQ0KPiBuZXQvdGlwYy9iZWFyZXIuYyAgICB8IDYgKysrKysrDQo+IG5ldC90aXBjL3VkcF9t
ZWRpYS5oIHwgNSArKysrKw0KPiAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4N
Cj5kaWZmIC0tZ2l0IGEvbmV0L3RpcGMvYmVhcmVyLmMgYi9uZXQvdGlwYy9iZWFyZXIuYyBpbmRl
eCAwNWRjZDJmOWUuLjA5MjY2OTJkZA0KPjEwMDY0NA0KPi0tLSBhL25ldC90aXBjL2JlYXJlci5j
DQo+KysrIGIvbmV0L3RpcGMvYmVhcmVyLmMNCj5AQCAtMTE2Myw2ICsxMTYzLDEyIEBAIGludCBf
X3RpcGNfbmxfYmVhcmVyX3NldChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QNCj5nZW5sX2lu
Zm8gKmluZm8pDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAiTVRVIHZhbHVlIGlzIG91dC1vZi1yYW5nZSIpOw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPisg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChubGFfZ2V0X3UzMihwcm9wc1tUSVBDX05MQV9QUk9Q
X01UVV0pID4NCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgVTE2X01BWCkgew0KPisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgTkxfU0VUX0VSUl9NU0coaW5mby0+ZXh0YWNrLA0K
PisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIk1UVSB2YWx1
ZSBpcyBvdXQtb2YtcmFuZ2UiKTsNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPisgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAg
ICAgICAgICAgICBiLT5tdHUgPSBubGFfZ2V0X3UzMihwcm9wc1tUSVBDX05MQV9QUk9QX01UVV0p
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgIHRpcGNfbm9kZV9hcHBseV9wcm9wZXJ0eShuZXQs
IGIsIFRJUENfTkxBX1BST1BfTVRVKTsgICNlbmRpZg0KPmRpZmYgLS1naXQgYS9uZXQvdGlwYy91
ZHBfbWVkaWEuaCBiL25ldC90aXBjL3VkcF9tZWRpYS5oIGluZGV4DQo+ZTc0NTVjYzczLi4wZDYy
YTU3YzggMTAwNjQ0DQo+LS0tIGEvbmV0L3RpcGMvdWRwX21lZGlhLmgNCj4rKysgYi9uZXQvdGlw
Yy91ZHBfbWVkaWEuaA0KPkBAIC00OCw2ICs0OCwxMSBAQCBpbnQgdGlwY191ZHBfbmxfZHVtcF9y
ZW1vdGVpcChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPnN0cnVjdCBuZXRsaW5rX2NhbGxiYWNrICpj
Yik7DQo+IC8qIGNoZWNrIGlmIGNvbmZpZ3VyZWQgTVRVIGlzIHRvbyBsb3cgZm9yIHRpcGMgaGVh
ZGVycyAqLyAgc3RhdGljIGlubGluZSBib29sDQo+dGlwY191ZHBfbXR1X2JhZCh1MzIgbXR1KSAg
ew0KPisgICAgICAgaWYgKG10dSA+IFUxNl9NQVgpIHsNCj4rICAgICAgICAgICAgICAgcHJfd2Fy
bigiTVRVIHRvbyBsYXJnZSBmb3IgdGlwYyBiZWFyZXJcbiIpOw0KPisgICAgICAgICAgICAgICBy
ZXR1cm4gdHJ1ZTsNCj4rICAgICAgIH0NCj4rDQo+ICAgICAgICBpZiAobXR1ID49IChUSVBDX01J
Tl9CRUFSRVJfTVRVICsgc2l6ZW9mKHN0cnVjdCBpcGhkcikgKw0KPiAgICAgICAgICAgIHNpemVv
ZihzdHJ1Y3QgdWRwaGRyKSkpDQo+ICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4tLQ0K
PjIuNDMuMA0KDQo=

