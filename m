Return-Path: <netdev+bounces-129293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC6A97EB92
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D03C1F21B62
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A661714DF;
	Mon, 23 Sep 2024 12:35:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01E1E502
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094938; cv=fail; b=GbP9IXcz5D+U10SbALAAXI2THcj9fgSCLV41D8TMZ+bkDSqMA8bjK7Q62nxKejZ7IVRSn69bNyJTOSr7U3T0C+FoJLsjah7shzhM0WapP+Y/9WI2m6er/wbiJ8C76JpEpO4u3Jxx7Wbo+hb9goDoxbRKUsEYcivg9VKsaRFbNZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094938; c=relaxed/simple;
	bh=Dq/Ea3my0wJy6i+RL9CMFSS6Eh4DgcVO1TGDYA604xM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B+gDT3mzGRUbCMSjqqMvd3ifTv7OaUzGkn6YCUYcvFuPY0OquSzcjg35BGqehTaaE0EnXJ7Kb+n+LE39TQAqvUnrGN6mJkuTIH+ZR10AngLQ8v7AkkPRhHghUe9fHkM6BSw+Wwug6yGUQZdTAbHHDoLNGpLUSw1GKZTEgclQuv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=educatalysthub.tech; spf=pass smtp.mailfrom=educatalysthub.tech; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=educatalysthub.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=educatalysthub.tech
X-Virus-Scanned: Proofpoint Essentials engine
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01lp2177.outbound.protection.outlook.com [104.47.74.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 44B5E94007F
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 12:35:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDMHia79trG0n49nU3uLwwwCXMnF+9rWr2nmWU1WOwPNyl8Zdl8gv0B92ld+5LM0RdpHqhtiUhyYa5XuTP78p00ejMdVxbCoil6aHFvFHhaZu/b/+pDLh3PH1OElEQgwikRV1ZPZJ7xUp6NWzgj4ZGVGrutwGCurYxzAfE2zRTwF/uebz6nhP9nqIG4X1YQUH4fEeaeswe5OTwFF1qGzeS+uOti3V+XbjBc37yDB38z14G5yeWuFudT+mC4cMnZFgAC8w5stS/PL2trr5pVPHnDTmzF0EIAd1jHMYXbRMeXAZUD31P4FVc5VH8VJ9vNHRVgLiua2T3lQbzvJmIq7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSusEUBMhKGx0wHye1aQchXQ6ve4FHMwcnwKqPfdPL4=;
 b=gvB2q2S+T49wZagzFMIlvKtCzzMZKGUfjKH7D8WFUnM9bphqR8FdY9eRyEjSAVbOifjB5OxblxtYvZ09CEBisJgOkkTAo/Rk8O2UFRnV+5mhmv7vdYM+b4CDts8B2EthtdimY4MY8UkHjhp3Yi3HNo5p37br+JESdX4s7K9+FED3OdnBjW+m5BAwESPEmw2ngrcRZAD6fCHa26m6u/4E7usBIyKvm0WisxeRBN29FQsCKs8Fidz5ko9bi/UJLkkg+g5RFYEOlSlS/T/sFe4jLLwNpWpV0NHknAss1GOkiXtmnBWRCRtZs5Ky+RBqE+hXrW6aoPxKSrDO9HCOUwyrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=educatalysthub.tech; dmarc=pass action=none
 header.from=educatalysthub.tech; dkim=pass header.d=educatalysthub.tech;
 arc=none
Received: from PN3P287MB2845.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:20f::13)
 by PN3P287MB1135.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:35:21 +0000
Received: from PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
 ([fe80::568c:6557:ed67:d933]) by PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
 ([fe80::568c:6557:ed67:d933%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 12:35:21 +0000
From: Lily Green <lily.green@educatalysthub.tech>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re_School Contacts List 2024
Thread-Topic: Re_School Contacts List 2024
Thread-Index: AdsNryrb9vJwxliXgk6yqrGN3Fo48Q==
Disposition-Notification-To: Lily Green <lily.green@educatalysthub.tech>
Date: Mon, 23 Sep 2024 12:35:21 +0000
Message-ID:
 <PN3P287MB28459CEF653D6FB5B691B310856F2@PN3P287MB2845.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=educatalysthub.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB2845:EE_|PN3P287MB1135:EE_
x-ms-office365-filtering-correlation-id: 257f9619-8bfc-4557-00ac-08dcdbcc3098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F4RB3AdDb+TKaQ9VPKcwfPilL3v665qy4EUmS9Qzaq5OPYEIhqpay80DRRKp?=
 =?us-ascii?Q?QuNzDhryA56KAgk8QboaxsyBB6qA3w8SHMIu/lPKpmOwsY2uCMbuJbWXC6XI?=
 =?us-ascii?Q?DkQbV5q3peK9bJf760M1kOoDbIQYcpxJNGDmHcbuimfzuUbRXU/XHj+EWqbh?=
 =?us-ascii?Q?FzbYm3O5J4xdLfRk2uorpTz1YT3dD3w3cYlg69r1e1fdSaRGsnbzdKK59xdm?=
 =?us-ascii?Q?g0dpygiBI9Xv0M/24CzXK3L2EoKqp9GM8f7WNcDayPy4WhKzAnmWOLMieKi4?=
 =?us-ascii?Q?sMB8OyAZxZYOtdjTEgGM2tRKkREDG1Mg+8+hiNdmzk5QZ/Ct5CCSb5pJopMH?=
 =?us-ascii?Q?AXwwh9Yef7xJjXOwSs/mIPaJ2c6PHSTksk7p6ANOcHrQl7BJq17iGxbDhHgQ?=
 =?us-ascii?Q?bFtJeBpij204AvJzzoVDhvC9TquN4IJGtr2QQIbHAr1FUIjZRdvpOFsCWvwn?=
 =?us-ascii?Q?WVvJ5d3diBiJWa8g9x6WDg9GU+2s+fgUsAELTcb+NoRznS/Bawcsb9wiwC7q?=
 =?us-ascii?Q?R77dM5+5oZ0spOqKy8iiISsMkumJFKMpWBB363OpVc+eFi4HWmcGrm/ce4DE?=
 =?us-ascii?Q?mfGtlTTembrb3ztJsbRPg2fAoRQcLFX0Mp52ke++/nL0b0yRpbajqMPTY6Hn?=
 =?us-ascii?Q?jpmocrBUxKbSxdXIzFKcM+hEFSKU5Szx6YuSoiy7c12lA8o4pQeAeXER1g52?=
 =?us-ascii?Q?TApKeDfbMmEGUuaRHy0lMvYXk+gYV577mp3Gx3MDfYXaxeryC6le9ySxbUnr?=
 =?us-ascii?Q?51q9GCaNHdVIe/++XK+wcd3hX9wSf8GeZFdaYXSCD91TP9oWaoqfb+ouClgj?=
 =?us-ascii?Q?bm6Os4SXScBrXlxUE1zHfDo+AVfN1JFTMthRYDuMgUZ7YP+X78BYVN+Y8ISK?=
 =?us-ascii?Q?GlkNvO7nhyX5hY46p/S5Xn5ykcD8j8FghwaDnErJDLsMB1Cq8ZCgCOCEsl+W?=
 =?us-ascii?Q?LphYQy0RxhSZ7nN0qh0ayxo+28NjgXN9IK7FXggEq3nFHXttuQ+N2HrHeQkt?=
 =?us-ascii?Q?oXm5oIHm3NjYVS7/e2k5E0YxzKvctvakP0yWcwnrh48jKJaajOhRoxUidnOd?=
 =?us-ascii?Q?ypom4QxyWy/LobTLkOYg4NJHVcrXJ8bvz//kEaQ1bBO8DX8QN28xeKWI+zT7?=
 =?us-ascii?Q?LORwqszupkH7ZfcjaxGjRA2T+Cp+kFo8Ax0PtKqcnBC95QBbg9PFXt3Dq/7i?=
 =?us-ascii?Q?d0yi3uVoqseorMTRaRgD+ThWeZ2W8SWQxs/2PYfH3hVpLrRN2Bjx0JOCVVDg?=
 =?us-ascii?Q?au/Uc8XqQ1zFenccLP06mrXmYirFNRkuNyWfKwjKVR/F2DOSKTLOPYMP/VTj?=
 =?us-ascii?Q?nNABECBvv5bBVQhTlc4gOMX+QyLgB9KAM0KQXNyh/kLsSA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB2845.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Uc4cM8rjWSJMs3xTWgXFZaSMyTLvOxoxa/vM/zxqczVtud59hZgFM3r+wwQD?=
 =?us-ascii?Q?QngbMcrmhEkqoWa9k2fR4izNUnKkrOYD2WmE6i6N8qKhMnm8D02mLrUQjxy9?=
 =?us-ascii?Q?ad53Qfw2RCYcgsmdSDseEbQ6b3gRjOUZ5RnKCNwLXnId9KvvS2n/m46ankAD?=
 =?us-ascii?Q?uTiFBLapcqA9OUBbpZCBYSi3ND1LMneFZY7B169ndqei7FxMOfDCSb6pV0IR?=
 =?us-ascii?Q?ozoH1+hQ7H4IgPeZ10GWVZpkRsaWjwpbdhJ565GlO+DlFSKSKYF3eXuw3JrC?=
 =?us-ascii?Q?/9bse+a+bmlYDVh94h+eHzs39giYK1H51ez5FmTetk9VuX+vYmeZdyCsB7Fq?=
 =?us-ascii?Q?rOx0JUyI7GzCnHj0QwMtjzar4Dm3iJnJbsdby47F5oaxA3jCWzuau4SzfQzK?=
 =?us-ascii?Q?05tmLX7cOROqFj7zQqdb7w5EVWudw/jTiGKCN1jvtq04TR0iEeAVmiVP3DIN?=
 =?us-ascii?Q?W4Xyke/yrk+tbOem5aHLSyID8xId7hNcAkTfY/MSVT3N16EhpwmXMz/imChU?=
 =?us-ascii?Q?YV1RgUJNfrl3Rc1A5q8IulSXjdrdlwqmpkgM+7IlhD9cAnu3K9nOBT6RygUv?=
 =?us-ascii?Q?FRhJsqeADggQrxvjoMdCtOGljUaP5oOLM+JJ7U58v1x01OjlVWWtgCNuGyjD?=
 =?us-ascii?Q?b15bYNw8kj/U0dOj0jwJhyPQXSi76UDl10sICxBwyvf1su0L9AXZLgNYLP/B?=
 =?us-ascii?Q?1tDYqnp4MW92fDXJLKcz0zD7G+DCgU89KZXuk43fIvmzAx3FOqH6Y3DDuKgi?=
 =?us-ascii?Q?mO3nVkHoF76MctUzqExJhzDNxtqmWYcIQnW9l8XijHRI+9NQXN3Pf5PRThTR?=
 =?us-ascii?Q?WAvMjkeWZFzrPIvK++tJPZkGa+8zOwVC/R+xfXeHYC1zaTFepeniSetZVktc?=
 =?us-ascii?Q?tOVUaG+48gaBUfEpQ2MQbszpwFv4l1ohv+A2zl9E+fyFCd7hAjlE43n93Pz/?=
 =?us-ascii?Q?131dDF0IJwUzNcZNNm85ojZdCdaQBTPkJjl8vgbMiKUOTCx9l6QzJGXLV/5Z?=
 =?us-ascii?Q?HpkSPmN0vX5M8AyG+81N4GVLqjYJ5FXhH5h2ewXruGfA6pBZYJN398cyW0Da?=
 =?us-ascii?Q?Z8HvKd9RsMb4Z7CDI+IOkOSkcl3OukWKtY6FRC906RN7rh1T6cBCxsNSzbrK?=
 =?us-ascii?Q?ONcQjo7Nwlb5xROpBQfM4QuTra6QI6fl5+8NFbOzB6SJsOb5LtCwHl7/pLf2?=
 =?us-ascii?Q?FEygkPOCATMNeBm1DlCY0CDFqxw5U6vhc6W1S2+CB79MKi+iW3pfBoEmDoTF?=
 =?us-ascii?Q?Es6x6uDQXVfBquGtpqHLXQGxz2TiInGpaFfpY4n5yPcQksAahIAX5d+o/X6X?=
 =?us-ascii?Q?BxNFPxh1pt93epa1jdzT5MjEmZFdvQAaWBPQ7K7oTKPxGgZuTXyDku8HzQGG?=
 =?us-ascii?Q?aZE/bXdDC/8TTh6g39Jio4oC2+KyWn5CHD795cCmQ4l4jd5QL0byfihb64Y/?=
 =?us-ascii?Q?JmaZ7PKknIzdLDnoEAqK6srop1b8DwLs8vu51aEEtONrqwmwjdxiet7LIWTl?=
 =?us-ascii?Q?I1RX8vj+pz6T0CSgYK5+VP/DFlkIq3aGFm/1MnMk6t/zGRvmVu0vJXtfLK59?=
 =?us-ascii?Q?0D53GbwCpeqFi5ZEOEWc+uhQWwA+iR1v2PuN6Yl27ZbBiEvakHHN2kK6Zxu+?=
 =?us-ascii?Q?JmB2ZsWIxyTd/D+VRrtvzphi5dFKKTYq/H0xuP4qE5DIW4OtAMwOPq6C/teB?=
 =?us-ascii?Q?UhXWPA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cjXPstuZOLlHOUfB+FgojWEgTpTnNeUl1USXYvGvs6z1v3WxEVh3XVVzIu5r0qYojb4R3R9/9qgQa2fKBuZbkC12MQlBmLw7eN8kAiWUrcxH6w3FAptIZk+ebQF4GpU2yFzVs4SzgZLf8TQ2r3zpEtqbamSI8AxjNiIQQWmxOmWWKBGt0ldRublEDPU4/5uIkgKuGUJA8ntBWUoPYKQcDDHSl9m6pdj5uXca9ZvpODfeJd4ih5xAzKb+PXGyDZcFMEoZ/BaX3aLBF8wkMwfxNUJmI6aqcHrtA/J4yiCZAaWnDVPGR1DlKfKjDGp/lzfH+mD3QMYnppE4ITivqHmf777mFMwXFzfq+/K2mwYi7oGEpsS8OTkDUh6+x6f7w8MhgsHPpgkoyGJe6s56bFaUK90TJC4rNNfJCp68lhTtoU0ss2oVHGCnnjjzLT9+41i9siJo1blimFIBpS72S8ytrWtnsv7OG93c3KEJ+fzteoaSADTDIg4lOhYcKxkDSGMNI/ZCUwj8/35dro4wm/Mj8o5F8a7y+fux5fJoG4NReW384m5oHfdfyxee5ES9gFzSRaFqcT6zMow6CUwodqVwnaiTlS6xlF4V8OiDfhfAIVs=
X-OriginatorOrg: educatalysthub.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 257f9619-8bfc-4557-00ac-08dcdbcc3098
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 12:35:21.4256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e365ff34-85ca-4d9e-869a-17889878f5ae
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UqkbPmcYDD8bMcIKHFPWMLatENLX6v4RMZXpXZbhorJ6vZsYl8hTN8XVSZv/rrzSTHlUVqNMiUEYN3drfQlIGmREtf2+uHjJojrRRWMjy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1135
X-MDID: 1727094930-nrU3W2SA-Zc8
X-MDID-O:
 us4;at1;1727094930;nrU3W2SA-Zc8;<lily.green@educatalysthub.tech>;0590461a9946a11a9d6965a08c2b2857

Hi there,
=20
Want to expand your outreach to K-12 schools, colleges, universities? Our e=
mail list of principals, superintendents, and key decision-makers is ideal =
for you!=20
=20
Our List Includes:
=20
*	Principals
*	Superintendents
*	Board Members
*	Department Heads
=20
List Contains:- First Name, Last Name, Title, Email, Company Name, Phone Nu=
mbers, etc. in an Excel sheet..
=20
If you're interested, we would be happy to provide you with relevant counts=
, cost and a test file based on your specific requirements.
=20
Looking forward to hearing from you.
=20
Best regards,
Lily Green
=20
To remove yourself from this mailing list, please reply with the subject li=
ne "LEAVE US."
=20
=20

