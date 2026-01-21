Return-Path: <netdev+bounces-251864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FB4F6nMcGkOaAAAu9opvQ
	(envelope-from <netdev+bounces-251864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:55:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF24457236
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5158B9EA9AC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60837481FA6;
	Wed, 21 Jan 2026 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BqHUjIvj"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6820481FA3;
	Wed, 21 Jan 2026 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999616; cv=fail; b=ITw0Xnxdw2cQCZbqQop6NjUBbgDtnnKaEmAqTkpO4EFL4qpnTLQjc82PMI7X1xzmWhA3Xq6Dfh6V5KEgKDDnxHUKZUmz1upG9iawZS1NJDkVhGYq1SGQ2d2VpnLKYndc3n03C48uqahbbj98udibFvOqCx9T5R4GMbGLIrdIAmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999616; c=relaxed/simple;
	bh=oaZ8G9xDz1pg+LzzacK9/v0+q9C7ONGpDKbm+YDFMhc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FoZFcipxIlpdZHtiBroWTXDnX78HRQ1UJVo+QhRV59wBFIgfRYgBTWmRy6YEtz5tmAtkcFVxJMue63sxzIxr5ehnU+tkgev8WjKdxoQ7iPLqd0EbXuHaStq+zap5go3EJlEHYGM4RfZs2RXFa355sRSrdC+1qdbO8r6IK27hTt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BqHUjIvj; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErJ+Yux8jxaQlglBPC9VNSeVk2fvIAzLDZiiY1K7W1szDE1PGW+1gcaozdrfzjRh8fJu7B9z5DD+rAWDCPNM6O5ao6rtQKyVwa2VIHTDCGF+mp22lF1F2zoij/aefHzuGmc632gekq3O/1z+4zC9PHv41EkPKDO+rCj6Uh7Hq925HY8eIR2tNAMEZ0WjBB+DwAo3Y5rRQThk3mYeiqJh5RNzHeIkeIkoWjPSVLN8mi5zKBsbMcE1FESzmQCutQk1FlqR3ZcrzwkC9uL/K/yymQMVRZ7lrX8ZgtqJsIUdFS6bPdWAt6n0cH8BtCXfglbMkJa5te4lGU258lHoPn4TNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaZ8G9xDz1pg+LzzacK9/v0+q9C7ONGpDKbm+YDFMhc=;
 b=Ge8UFb7kKTZH/zaSqC0q20oulsc6J/0slLvX4B3yZsEgdreww0GI6NZ+F7tHUw+N6bLx0ptEElVxPUDIg8kkBCKL90KxbR12WeKIV0mi9P1Y/nG4bETBrGBrEc22rJ7I13g7AdmHsR33WZSKn+lHcl1YIX0VSWR8dkFtLSQT+/uwIpHeu2SI4Wwi7oxLqXM0krs92X5havuhHaCE6APIcI5ZSx2BNXCkwGzyggO2Oqdw3zC3eaAjdmswmrOJHdBuKGyNttG8Or3Tb+kBBYZgxJPRNBnWrDxU0dos5+SClyDJoARCBoNb5ff2aEACU/MFT2TmZTv9WrY0MVT7GMv/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaZ8G9xDz1pg+LzzacK9/v0+q9C7ONGpDKbm+YDFMhc=;
 b=BqHUjIvjCWh7bs62BflBeiNDALaifseGkTgDLUqOcVX6EJpHp/+QjxpOmy1HHJAfSHT9ygI/2B9s4tkZp5BiF33PQhUo+YplICGbgMk2aTFEu9olXgF3aW2Ahc5QitJIGrMA4DDWOrJifD4UsC7+ezlhlcSdtzztSLnex9imaNkwGECPA9rLebjbJuBsZIQ1VDElsX/Q2ztVdZwAljhPFU/R1MB4mtwJplgJXtxOPWPn0ptfe50R5jOd+9PdgNtirRr7J3tsmFSsgnOzUJhije7I+B+QNzi3fXY8R0z3QCADg1oaQ3ernqG7jZ+aK/v3fENoP8x2k38lvRuB301PiQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AM7PR07MB6659.eurprd07.prod.outlook.com (2603:10a6:20b:1ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:46:50 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Wed, 21 Jan 2026
 12:46:50 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v9 net-next 15/15] selftests/net: packetdrill: add TCP
 Accurate ECN cases
Thread-Topic: [PATCH v9 net-next 15/15] selftests/net: packetdrill: add TCP
 Accurate ECN cases
Thread-Index: AQHciXXC2NtMObJHy0OBNMx5eLHLsrVbaVEAgAALmwCAAR9vkA==
Date: Wed, 21 Jan 2026 12:46:50 +0000
Message-ID:
 <PAXPR07MB7984C358C10A5B9C16F1AAEDA396A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
 <20260119185852.11168-16-chia-yu.chang@nokia-bell-labs.com>
 <20260120105352.423ea3cd@kernel.org>
 <CADVnQykJZhYQZMtqg+Cm4BnuVeaBjPi+VWseNK+K7Y4eZRq_-w@mail.gmail.com>
In-Reply-To:
 <CADVnQykJZhYQZMtqg+Cm4BnuVeaBjPi+VWseNK+K7Y4eZRq_-w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AM7PR07MB6659:EE_
x-ms-office365-filtering-correlation-id: b6627c91-1a21-4e47-c7ac-08de58eb2586
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b1ArQTl4VTUxaVY0dko1aERXRisvVkpLZHF4Q2lLSVdnWndhSnhCTEVrRGhp?=
 =?utf-8?B?QWFXdFB5V2ZYc2x5OXNVRG54aTZRNnJUN3ppZzJaUG9hbzlCbDVzZ3pPUi8r?=
 =?utf-8?B?ODlHd2Zkc09OYmFtUWJuaGpBQm5QdjZ4NnJZL3gwK3ZtcDZhZDR4bXZ3WlFR?=
 =?utf-8?B?c21GVFhmczVISG9abDd5T2dpREhlYW9INGVUekY3dEJhUFBjK2pZRnNKVGRr?=
 =?utf-8?B?WTBxQXM2NUFjWjNESmxvOG53TDBMT2lmV1VVQjIvUElncGJmSFpaUXFyZHBv?=
 =?utf-8?B?OVdWR0tScTJYbWIyMys1SHAwWjFyMG1WU2xncmxNZlFYTWVXTU00QmZBanAy?=
 =?utf-8?B?LzgrWUQ4cXVzckRzbFR1TWVGZm94YjJMa0FRejFiVHRXaTEveDQ1djN0NzFM?=
 =?utf-8?B?alZoOHhsZ2x4RTUvbzd5K29pUFY2aDEvU3MxRGl2RW95QTdGa3NUTzRWRVdY?=
 =?utf-8?B?djY0YWJyc2lLdURKL2doYXpMOEVhOXhJL1FtUXl2b0h3VzYzOW1CWmFkVDlN?=
 =?utf-8?B?STA4SDFaS25XNkVRZ2ZtVWJtTlVoU0puN0pBRTJQWXlORUQ3NGxsZmI3UVVl?=
 =?utf-8?B?NXB0enBxQTdkOGNzUm02cFpOTldnQXN0azJad0tMYXg3R0RaSTI5dlVJUWUz?=
 =?utf-8?B?OU5hME1YY2poTjE2YmlKQlR0eldEbWhGNlBoZXBqcnR2d3BGUHZZU045YXlt?=
 =?utf-8?B?MlBCUGNqSTlHd0F6RFduVDZ5ZUlBSGNNQWxLNmZ1VzdVdWZucVlxeWJWclV0?=
 =?utf-8?B?QUFFcnZvQ0ZZdnFJdUhEWHVVZFFxMXUrV29DajdiM0JVTXdhTnZkbklMajlD?=
 =?utf-8?B?bjJ1TDVYMnA2U1FBdjVPVU92RnBnbmtGRG5TL0ttV0VuYkdVdlk4MjhDQzZL?=
 =?utf-8?B?RkVuamVFM2RUYTFvc0kra2dnNkIxWmFJUEdOdHdjRXhmaUUxMnRFNnlQdGxn?=
 =?utf-8?B?R0ZVTnBaYkdzM0NNeGZIYjFEWUV4WlhyYzlZYThzREFWbmtTY0VhNVlFbFNj?=
 =?utf-8?B?cE1zcEdxU0lIUE5rQlBMZEZiRkRFNkhhbW84U0FnaG1jTG5GWnNRaXdWdC9J?=
 =?utf-8?B?RmlUT3lodXp5ZVJKbVkwdFVqMmxQRWc2WVNuRlkxRXQ3TXlCMTRXVHJyRUY3?=
 =?utf-8?B?TFBsdGt4KzZ3Z0FFWGJGb29Ra2t3ejJVeHhZaVBTYVdnVlpOL3NaVVFjSGI2?=
 =?utf-8?B?OGF3UXU4U20yTHBDdnpBUTVJRDE3QUxqY0xWdm1SR3RCMzhBdW5BZXRVSnlX?=
 =?utf-8?B?cjgrYjRpSUh0NG1BRUZMekVUdU9iaWsrVnZQN0F5TlRPTVhxV0RLT1V4REJO?=
 =?utf-8?B?M3F6a0ZGVVFDMm5wb1RPQVVFRVdtbHhiRnBlb1NDdENpY2pXcUlCNWZsNnR4?=
 =?utf-8?B?QmoyYXJjQk56UmZ0ZkFIRU5xSmtiMmI1UnFUbkMxaFdxVFBjQ0pLRGxyZmVn?=
 =?utf-8?B?Y3MzTnJ5TE9LRG1Gd1drSXpGZ0RsMTMvS1NTbGFlRkFqckFJS2JDMC9uK0Jv?=
 =?utf-8?B?cDdIaFhXbVg3MG9waUN5YUtVdDRXNTVPMHpiZHVUQjNBaFZHWWx3Tkl0aUww?=
 =?utf-8?B?SGNUR0hpOWdhUWVNeW03Z001cFVQZ1pTd3ptcnA5dTVldFh4ejFpOHhEWEpE?=
 =?utf-8?B?OFUzclh2dDdTVUZ3VE0yekcxNWJMMS9pV29GMDB1ellrWEJqNTM3dy81UStV?=
 =?utf-8?B?SVpWUkNKWE14dEprUXJaZ2RoWjBNUHNFYWxORlJYNWRnY1lTNkFYNmdvTnNY?=
 =?utf-8?B?a01QWTBoMEFMT1EzRUZDc3l4cS9vbGdDc1pmbitJZXhOaldTMFkyQjJqZE9t?=
 =?utf-8?B?TlFFSWg5TTc5U3d5alc0M2xmU2hCaG5mSmg3YjByVmdwTHRPZCtURGZRbG9z?=
 =?utf-8?B?WGZ6M1duYmZ3a3U1TnFwUWRpUmtZOVVVNjNIYVlJWkdNdExkVVpOdDYrUGRz?=
 =?utf-8?B?bkFzdFJ1eDYxVlV2dm1zb0tlaVRnNytYNmFLdVE5ZUhSUEc0SW9EdjN5Tnhq?=
 =?utf-8?B?d1g0TnFuNUh4bkN1RTAvSktEV3p5NXQrK1ZFcE5walFqZmd0YmVqU2kwZ0Jv?=
 =?utf-8?B?Y2tia25nSkZGQ2RXTnVHMlpqSUE0a0VHbEJPb0VYeUdqOEdwcHVzNndCNFJm?=
 =?utf-8?B?cEhaci9xeGw3RmZKNWU5MHhldG1mUkxwMFJCM2JDNGd4ZE1rUU0yd0pxRHlv?=
 =?utf-8?Q?GXqPp4pfJK8ETYN0s/LU5jI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUlyRThDL05wVy9EVHJMSkdGa0QxQ2R5d1Z4VCtJbEpnTkhhMXF5WGVnMkph?=
 =?utf-8?B?SUl2WGpZb0ZvcVFySVMyWjVxQ3JSdnI5Sm9EbUhOaEgxOGpGWjdJNzg1c0N0?=
 =?utf-8?B?NTJ5VGQrN2dPSTFKUXNtOWZRSnpiQmcrWUlDbzFVVVVQNXB4ZS82Wlc5UlNP?=
 =?utf-8?B?cml0b1NqRk9NcUJ5a1dYSWpkSk5JcnVCSDdqUVEweWd2ZEFtVFgzZk13RHIr?=
 =?utf-8?B?ZlRLYjVjY3dEVzc2cnBVVm5yS2dnOStnRjZFYThKUitlNS90ck1xKzdzQmF2?=
 =?utf-8?B?ME1iVU1SWnZTTXhCUEZtUCs0a2V0NkJEVmRGL3NzQmRNVXFqZUdXeGhZaWlN?=
 =?utf-8?B?N2twR3BKcEZpMVVuOXJjUzAxd1BWQUpJdFYydGNKOTZJa2hNdm8yTmpyYUhT?=
 =?utf-8?B?MVdCK1FrSVpQZklMbjNHakErVTNZZ3dKcXpET29sK3ZaWmZuWHROQVQxTWZk?=
 =?utf-8?B?Rjl2a1BHcktqUm5SbWxWaU4ySXdrY2FVbHdpT2N0QVhxMHZiRmxXNlVDUDJN?=
 =?utf-8?B?aEV6aWtmMlBXSE9rMDVKRG1tb1k2eHgxbHhUb0VIS3Vpd2kxTHZnSEdNaGFp?=
 =?utf-8?B?T2VScStwSjkweXcrcW5aYWh3eXFDeEFrVEZ2ZkRzOFBYM2dCYXYrV0o4QXJM?=
 =?utf-8?B?QUp5bGYyN2RJN3lnM0wvSVRjTmpoUTBaODhvS2tZQTFvZHI1R0J6SnZGL1lr?=
 =?utf-8?B?WmcybGVnK0VTK295UThqdVpBWEhUd05MZjg3MjQ2TERpVXU5b1VvTFNPbHMw?=
 =?utf-8?B?RHJsV3pYR0JWbEVHRUp1cWNYOEhCUGM4UW40dkJBNjduQ2ZRcTdUaUJmTEdt?=
 =?utf-8?B?ZTRDYUNsaEdTUENCcExHK05obGo0ZUtHT200S3FaQUcxcnBUemx4bzgvVzg5?=
 =?utf-8?B?MytBQ1VGNkZUaXMvL0RuVHJiMzVHdUdEUlE5QURnNDdMOG1yMVd0cndid2tq?=
 =?utf-8?B?MjBUWFpCdWp5cjl2NEE3eUlpTWJBZmFKcU5QekVWcXpqWmFQU21CU1VnVU9C?=
 =?utf-8?B?MGlmcFpEMlUwTHI3T253S090Y1VGYkhSSGlhWS9LN2dCWGFoVFh3Q1JaYS9a?=
 =?utf-8?B?QzNEYnFQcW05Ri84VVhjeHdKZmFlVktxandlN0xsUGFOQWxxUEZtZHpudTdL?=
 =?utf-8?B?M2xiaFJYT1Y2eko4cGpqVkFwOWRUVTJZM3RFRzZlOFRqVnlUT0VlRSsyV0ZE?=
 =?utf-8?B?ekxkWlpxRXgyMXdhUG9qdndYVVNwNlpXeEF5aUU1dXJaMFl2M0tlRnpJQm1P?=
 =?utf-8?B?dUpsMWJNNWpmMTB4WVI1aVNzaE5kdUVSejN0RkpobEducDVhbVBkVW9xNEY2?=
 =?utf-8?B?dmJaQ2FtckhTMGpHQWd4NmY2c2ErRXF6SDdGVzEvdUxCZ1IrL2F2YjRMY1k4?=
 =?utf-8?B?QTFRZ0xmckVuV1gvZ2hGcWZaN2hnNXNBcVRJQkM4eGtCenpFNS9oeXRGbUlE?=
 =?utf-8?B?TkppN05TaXlXeEwydEFDbEYxRHo5Qk8yMGdNak8vV3FJN2MvMEYvTVZqTFhu?=
 =?utf-8?B?SmJtZzZNdytaVVRRVS9mODg1d2lma1NKN2w1ZUxWNGNkL2grZ2J0R3dqaDdP?=
 =?utf-8?B?TEZZZ2VwdVJpQi94QlRaNUgxMG1tMytDQnBjL3dJVDFNWjR6SmsyaXFJZDAr?=
 =?utf-8?B?b3dqUVZrODEyZjNVOWF1bmxZUkhrSG9sVEMxVDJBT1FEbHJCUXRvOUxJTlg4?=
 =?utf-8?B?TW5kNTNpREFNQWpyYkgrZ2J6Nk55RmRCRUY1WUhVaFpsVWhtMTY1YnJDN2pt?=
 =?utf-8?B?bUUwczJ6YmJRRUp1NGdHOXJZVFJxWU10RjRLajhBU2RWNVgremxwcXdSTEVj?=
 =?utf-8?B?Y0hoRTR1MHNxV3NvWVdRdWN1U29FWnQ3WGJSQkc3OTJrdnozUitGcFQvcmRT?=
 =?utf-8?B?eU5FcmQwVXR2WGQ2Mzh3VUxyOVp1N0NXWEd1WEl5cURVMWR2TkNtYVZKVUY5?=
 =?utf-8?B?SEFxTnlkNDV6b1NrUGhVbi9TcFk3MDVqbTlPc2U4Ulc2NTVjaW5VeWNqNlhY?=
 =?utf-8?B?SUlWM3pCMStEd2wrakhVSGQ1NzkzZXhvVUZKRjBYOEJyVVJMRXpzRnpENnVa?=
 =?utf-8?B?cnFGWVp6RmVQQ1dLVitJZW9pZXROUXZkUkpzRTJveGNmR1ZZcHlYcC9HNGpD?=
 =?utf-8?B?bGIxV0Raa2hIWU16SXBqNVFZTExrbGhiVUNSYVIzazhzRTl3WUxaYm5Bay9t?=
 =?utf-8?B?YTNJeW9FVHl0RWZaZDQ2alRWRzlibUZzNVZ3eFhJeXVtQVBkSENBN2JQUEEy?=
 =?utf-8?B?L2gybkkyc1ZVS1RTS05XdmxlWEdmT3Z2ak9SZUIvMlFqT3c1RE5HZnVvaW00?=
 =?utf-8?B?SFdQc0labDREdnAzMVhoVXZ1Z2JjNzE1T2hmM2I2ZmZtTnEzNExaVUhBSitX?=
 =?utf-8?Q?XC5ObJqbWErqvaH0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6627c91-1a21-4e47-c7ac-08de58eb2586
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 12:46:50.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6xixF9KYrzZjnNmcRRo5RwT9uAK+mEKoE9Dw1PA5WHKYKiizkmwfChxFcaWal9gGD7QlNN6rpMNaqGkBXXxYe8GtMcLp0HyELxPaY7G8iO7a3AuzwBJEJAnZdkuPbqm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6659
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251864-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: EF24457236
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2Fy
ZHdlbGxAZ29vZ2xlLmNvbT4gDQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjAsIDIwMjYgODoz
NSBQTQ0KPiBUbzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4NCj4gQ2M6IENoaWEt
WXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPjsgcGFi
ZW5pQHJlZGhhdC5jb207IGVkdW1hemV0QGdvb2dsZS5jb207IHBhcmF2QG52aWRpYS5jb207IGxp
bnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0OyBob3Jtc0BrZXJuZWwub3Jn
OyBkc2FoZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBnb29nbGUuY29tOyBicGZAdmdlci5rZXJuZWwu
b3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlLnRhaHRAZ21haWwuY29tOyBqaHNAbW9q
YXRhdHUuY29tOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgeGl5b3Uud2FuZ2NvbmdAZ21h
aWwuY29tOyBqaXJpQHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBhbmRyZXcrbmV0
ZGV2QGx1bm4uY2g7IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBhc3RAZmliZXJieS5uZXQ7IGxp
dWhhbmdiaW5AZ21haWwuY29tOyBzaHVhaEBrZXJuZWwub3JnOyBsaW51eC1rc2VsZnRlc3RAdmdl
ci5rZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyBLb2VuIERlIFNjaGVwcGVyIChOb2tpYSkgPGtv
ZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNvbT47IGcud2hpdGVAY2FibGVsYWJzLmNv
bTsgaW5nZW1hci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJp
Y3Nzb24uY29tOyBjaGVzaGlyZSA8Y2hlc2hpcmVAYXBwbGUuY29tPjsgcnMuaWV0ZkBnbXguYXQ7
IEphc29uX0xpdmluZ29vZEBjb21jYXN0LmNvbTsgVmlkaGkgR29lbCA8dmlkaGlfZ29lbEBhcHBs
ZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgbmV0LW5leHQgMTUvMTVdIHNlbGZ0ZXN0
cy9uZXQ6IHBhY2tldGRyaWxsOiBhZGQgVENQIEFjY3VyYXRlIEVDTiBjYXNlcw0KPiANCj4gDQo+
IENBVVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVm
dWwgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVS
TCBub2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBP
biBUdWUsIEphbiAyMCwgMjAyNiBhdCAxOjUz4oCvUE0gSmFrdWIgS2ljaW5za2kgPGt1YmFAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBNb24sIDE5IEphbiAyMDI2IDE5OjU4OjUyICsw
MTAwIGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbQ0KPiA+IHdyb3RlOg0KPiA+ID4g
TGludXggQWNjdXJhdGUgRUNOIHRlc3Qgc2V0cyB1c2luZyBBQ0UgY291bnRlcnMgYW5kIEFjY0VD
TiBvcHRpb25zIA0KPiA+ID4gdG8gY292ZXIgc2V2ZXJhbCBzY2VuYXJpb3M6IENvbm5lY3Rpb24g
dGVhcmRvd24sIGRpZmZlcmVudCBBQ0sgDQo+ID4gPiBjb25kaXRpb25zLCBjb3VudGVyIHdyYXBw
aW5nLCBTQUNLIHNwYWNlIGdyYWJiaW5nLCBmYWxsYmFjayBzY2hlbWVzLCANCj4gPiA+IG5lZ290
aWF0aW9uIHJldHJhbnNtaXNzaW9uL3Jlb3JkZXIvbG9zcywgQWNjRUNOIG9wdGlvbiBkcm9wL2xv
c3MsIA0KPiA+ID4gZGlmZmVyZW50IGhhbmRzaGFrZSByZWZsZWN0b3JzLCBkYXRhIHdpdGggbWFy
a2luZywgYW5kIGRpZmZlcmVudCBzeXNjdGwgdmFsdWVzLg0KPiA+DQo+ID4gVGhhbmsgeW91IGZv
ciBjbG9zaW5nIHRoZSBwYWNrZXRkcmlsbCBzaWRlLCBhbmQgYmlnIHRoYW5rcyB0byBOZWFsIGZv
ciANCj4gPiBwcmlvcml0aXppbmcgZ2V0dGluZyBpdCByZXZpZXdlZCBhbmQgbWVyZ2VkIQ0KPiA+
DQo+ID4gSSB1cGRhdGVkIHRoZSBwYWNrZXRkcmlsbCBidWlsZCBpbiBuZXRkZXYgQ0kgYW5kIGxv
b2tzIGxpa2Ugb25lIG9mIHRoZSANCj4gPiBjYXNlcyBpcyBmbGFraW5nIGEgbGl0dGxlLiBTaW5j
ZSBpdCBsb29rcyBsaWtlIHlvdSdsbCBoYXZlIHRvIHJlc3BpbiwgDQo+ID4gcGxlYXNlIHRyeSB0
byBmaXg6DQo+ID4NCj4gPiAjIDEuLjINCj4gPiAjIHRjcF9hY2NlY25fY2xpZW50X2FjY2Vjbl9v
cHRpb25zX2xvc3QucGt0OjMyOiBlcnJvciBoYW5kbGluZyBwYWNrZXQ6IA0KPiA+IHRpbWluZyBl
cnJvcjogZXhwZWN0ZWQgb3V0Ym91bmQgcGFja2V0IGluIHJlbGF0aXZlIHRpbWUgcmFuZ2UgDQo+
ID4gKzAuMDIwMDAwfiswLjUwMDAwMCBzZWMgYnV0IGhhcHBlbmVkIGF0ICswLjAxNTgxNiBzZWMg
IyBzY3JpcHQgcGFja2V0OiAgDQo+ID4gMC4xODE5MzYgLjUgMToxMDEzKDEwMTIpIGFjayAxIDxF
Q04gZTFiIDEgY2ViIDAgZTBiIDEsbm9wPiAjIGFjdHVhbCANCj4gPiBwYWNrZXQ6ICAwLjE3Nzc1
MiAuRUEgMToxMDEzKDEwMTIpIGFjayAxIHdpbiAxMDUwIDxFQ04gZTFiIDEgY2ViIDAgZTBiIA0K
PiA+IDEsbm9wPiAjIG5vdCBvayAxIGlwdjQgIyB0Y3BfYWNjZWNuX2NsaWVudF9hY2NlY25fb3B0
aW9uc19sb3N0LnBrdDozMjogDQo+ID4gZXJyb3IgaGFuZGxpbmcgcGFja2V0OiB0aW1pbmcgZXJy
b3I6IGV4cGVjdGVkIG91dGJvdW5kIHBhY2tldCBpbiANCj4gPiByZWxhdGl2ZSB0aW1lIHJhbmdl
ICswLjAyMDAwMH4rMC41MDAwMDAgc2VjIGJ1dCBoYXBwZW5lZCBhdCArMC4wMTU4MDAgDQo+ID4g
c2VjICMgc2NyaXB0IHBhY2tldDogIDAuMTgxOTUyIC41IDE6MTAxMygxMDEyKSBhY2sgMSA8RUNO
IGUxYiAxIGNlYiAwIA0KPiA+IGUwYiAxLG5vcD4gIyBhY3R1YWwgcGFja2V0OiAgMC4xNzc3NTIg
LkVBIDE6MTAxMygxMDEyKSBhY2sgMSB3aW4gMTA1MCANCj4gPiA8RUNOIGUxYiAxIGNlYiAwIGUw
YiAxLG5vcD4gIyBub3Qgb2sgMiBpcHY2ICMgIyBUb3RhbHM6IHBhc3M6MCBmYWlsOjIgDQo+ID4g
eGZhaWw6MCB4cGFzczowIHNraXA6MCBlcnJvcjowDQo+ID4NCj4gPiBodHRwczovL2V1cjAzLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZuZXRkDQo+
ID4gZXYtY3RybC5ib3RzLmxpbnV4LmRldiUyRmxvZ3MlMkZ2bWtzZnQlMkZwYWNrZXRkcmlsbCUy
RnJlc3VsdHMlMkY0ODIyMA0KPiA+IDElMkYxMTUtdGNwLWFjY2Vjbi1jbGllbnQtYWNjZWNuLW9w
dGlvbnMtbG9zdC1wa3QlMkZzdGRvdXQmZGF0YT0wNSU3QzANCj4gPiAyJTdDY2hpYS15dS5jaGFu
ZyU0MG5va2lhLWJlbGwtbGFicy5jb20lN0NmMTI1Y2NhZmM3MTM0YjYyMGJhZDA4ZGU1ODViDQo+
ID4gMWEzNSU3QzVkNDcxNzUxOTY3NTQyOGQ5MTdiNzBmNDRmOTYzMGIwJTdDMCU3QzAlN0M2Mzkw
NDUzNDU0NTk3NTgyNTglNw0KPiA+IENVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFo
Y0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEENCj4gPiBpT2lKWGFXNHpNaUlzSWtG
T0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPWtuM1BiDQo+
ID4gVlh3JTJCa3pubmY3VmFZendQJTJGTDNJTzJMWUdZUXpaT1dTM0hSWjZ3JTNEJnJlc2VydmVk
PTANCj4gDQo+IFByb2JhYmx5IHRoaXMgaXMgaGFwcGVuaW5nIGJlY2F1c2UgdGhlIFNSVFQgaXMg
YXJvdW5kIDU2bXM6DQo+IA0KPiAuMDUwICogNy84ICsgMS84ICogLjEgPSAuMDU2MjUgc2VjDQo+
IA0KPiBTbyB0aGUgUkFDSyBmYXN0IHJlY292ZXJ5IHN0YXJ0cyBhZnRlIHJhYm91dCAxNW1zIGR1
ZSB0byAuMjUgKiBzcnR0IGJlaW5nIGFib3V0IDE0bXM6DQo+ICguMDUwICogNy84ICsgMS84ICog
LjEpICogLjI1ID0gLjAxNDA2MjUgc2VjDQo+IA0KPiBJZiB3ZSBtYWtlIHRoZSBTUlRUIDEwMG1z
IHRoZW4gdGhlIGZhc3QgcmV0cmFuc21pdCBzaG91bGQgYmUgYXJvdW5kOg0KPiANCj4gKC4xICog
Ny84ICsgMS84ICogLjEpICogLjI1ID0gLjAyNSBzZWMNCj4gDQo+IFNvIEknZCBzdWdnZXN0IGNo
YW5naW5nIHRoZSB0aW1pbmcgb2YgdGhlIFNZTkFDSyBmcm9tIDUwbXMgdG8gMTAwbXM6DQo+IA0K
PiBvbGQ6DQo+ICswLjA1IDwgW2VjdDBdIFNXLiAwOjAoMCkgYWNrIDEgd2luIDMyNzY3IDxtc3Mg
MTAyNCxFQ04gZTBiIDEgY2ViIDANCj4gZTFiIDEsbm9wLG5vcCxub3Asc2Fja09LLG5vcCx3c2Nh
bGUgOD4NCj4gDQo+IG5ldzoNCj4gKy4xIDwgW2VjdDBdIFNXLiAwOjAoMCkgYWNrIDEgd2luIDMy
NzY3IDxtc3MgMTAyNCxFQ04gZTBiIDEgY2ViIDAgZTFiDQo+IDEsbm9wLG5vcCxub3Asc2Fja09L
LG5vcCx3c2NhbGUgOD4NCj4gDQo+IG5lYWwNCg0KVGhhbmtzIE5lYWwgYW5kIEVyaWMsIEkndmUg
Zml4ZWQgdGhpcyBpc3N1ZSBhcyB3ZWxsIGFzIHRoZSBjb25jZXJuZWQgcmFpc2VkIGluIHBhdGNo
IDEwIG9mIGxpc3RlbiBzb2NrZXQuDQpBbGwgQWNjRUNOIHBhY2tldGRyaWxsIHN0aWxsIHBhc3Mg
ZnJvbSBteSBlbmQsIHNvIEkgd2lsbCBzdWJtaXQgdjEwLg0KDQpUaGFua3MuDQpDaGFpLVl1DQo=

