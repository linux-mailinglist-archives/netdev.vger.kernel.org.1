Return-Path: <netdev+bounces-127089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C934974100
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBEA1C250D7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF9F19B3D8;
	Tue, 10 Sep 2024 17:47:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB98757EB
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990460; cv=fail; b=c0fxEgx25eBi99AUdX2305FSepAiDuEygguNo/iAyOx3pPPF6ed3avtVjU7/IoDvzkIop5Ph5xbOfdZOYGcyxg26a/xCwJUGSHx3JqQmH/YNxvfTXn9+Znyio3cMbx5I8kTKGHHMs4a7I4Nrc+Kq0onuIaZyCbQgowDr1ELI23s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990460; c=relaxed/simple;
	bh=Dq/Ea3my0wJy6i+RL9CMFSS6Eh4DgcVO1TGDYA604xM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KymCA5QnftkI3PC4X4vNWpTW0iWRLnZhQHsmVIQXjyzFgavexpDHrc79Y0j44CWG0L1UwRZDnhkTzacUa3pvKFggHuLGe2v6yyZoNxCu+8y9lmLAw+ES6ZjZY3YA3XdSR1OZVfjS2TC/Nmm95DDh4wE1QBLzey//xSEMcSdqEXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=educatalysthub.tech; spf=pass smtp.mailfrom=educatalysthub.tech; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=educatalysthub.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=educatalysthub.tech
X-Virus-Scanned: Proofpoint Essentials engine
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01lp2169.outbound.protection.outlook.com [104.47.74.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1C3B6C40066
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 17:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPAnW6GpyXA3t0tfXDTh0bgL1f4AAO/BsHSqI6mEyqi9L46G35PXdO6w4TsmuzHigZBFiri8hfrSSmWcvL9KU++RNmixsgNJlg5/BU7CBurVBH5Bsoz+Db/YC4n15xAh5pvz9p4ZQCFVlkuOHBcDDgLkNFFf6iZFkTWSbtiJkJ07DqpJWMXqvv9u0Zrd6aPbganxL7OJP5XGdsQ3YxmSKLjntnDCgywffVuNE04jd/xRo1yk2BFFSzDR/7T16W14L8rNwiSL/23qcnSR6ivuNva/Ggy46sH56Ump/R0qKYSQbolGplR6nAH2fZyTwa28l/6p0paNg9ZL1N2uOKxtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSusEUBMhKGx0wHye1aQchXQ6ve4FHMwcnwKqPfdPL4=;
 b=xf5OsHT6UJvjU09ZdqUY7yrtRBAI79jY785AFZajoJQK7ZavQM+dwh5FS1I4SmGDTg+O/HoLoSlp3wymc4KRSWmUUUfA1m+R4xVVZ0TFWrDKeVasHUqCtPoTR18JQ1xyBhy+S0KxVdtKU3P+kpTQsrjALPWeLIAPGo6qfMb9HouRnPBegR4bM5XfT4cdHC5Aj9lelTSMKn6Op5cpYviCbAHrUoGs5SNX5ARw3oliyOfDvt9jo81Pxavfral1yyQnXAIajsMoXGeThlqrFnt4znvW5KwWcSet9eYx3N6ECT9cbWG9ExGiVbZGTSMHendb8kJXgWeDbad/gp8mPJUE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=educatalysthub.tech; dmarc=pass action=none
 header.from=educatalysthub.tech; dkim=pass header.d=educatalysthub.tech;
 arc=none
Received: from PN1P287MB2834.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:216::6)
 by PN3P287MB0305.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 17:47:32 +0000
Received: from PN1P287MB2834.INDP287.PROD.OUTLOOK.COM
 ([fe80::e9e2:a454:fd31:f28]) by PN1P287MB2834.INDP287.PROD.OUTLOOK.COM
 ([fe80::e9e2:a454:fd31:f28%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 17:47:32 +0000
From: Lily Green <lily.green@educatalysthub.tech>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re_School Contacts List 2024
Thread-Topic: Re_School Contacts List 2024
Thread-Index: AdsDZlrSP1Ccmnudmk+EJfr+acklNw==
Disposition-Notification-To: Lily Green <lily.green@educatalysthub.tech>
Date: Tue, 10 Sep 2024 17:47:32 +0000
Message-ID:
 <PN1P287MB28342A2F055DE6DA7E2EC441859A2@PN1P287MB2834.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=educatalysthub.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN1P287MB2834:EE_|PN3P287MB0305:EE_
x-ms-office365-filtering-correlation-id: 9fd13453-9933-4cef-e8bb-08dcd1c0a600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b0nidgAmYPLva6T5BSppKh4mi5YNgdjSoMgrAmPZPunxygoGTEKLvsnv/fv5?=
 =?us-ascii?Q?KPu5X15nzifxFtmkt2suA20uaBPCkwMHbFNIyLCs6aQ0Xl6qEYxefL9N79wj?=
 =?us-ascii?Q?/EKGOvp04/q8dqD2oREC3cwv9W7LLXKMEhdi+rWR+6F9+ncJ4Drot3NRfOrm?=
 =?us-ascii?Q?xN5Ch5u8C/wA/oWIf0rGQPzsXgUAZMsbjTsVfCxIJpbDRCe0oKtJHDXHJ5Rq?=
 =?us-ascii?Q?RpVjgb9cm2wOO3DWoKT4YgLmaNhsRO6z3agEnbofAjZ1oEEDVtV43Zce3EW9?=
 =?us-ascii?Q?rHYfVW6nyfcXzfoncPJXYQ9KB66JM9Mou2QQhZLP3jXM049w/DSLBE0RT/uA?=
 =?us-ascii?Q?q/3grY9BnNRPxS3f1CoxFpzIK58QwIXRTzqqKUVX8Y+gwChwfBExrJChSusg?=
 =?us-ascii?Q?2vyTnsr0HdbK6e7KQ9XyfTZYrzsFLi8M2VZADgVB0PSpHklV4fSQE8l0WUNa?=
 =?us-ascii?Q?aL4ssBr8qUtivdofuG3FZy+MdmMqRJbnnQfUyFm/CTZ8K9UqKHPDoEAf6gKs?=
 =?us-ascii?Q?kSqA62Yx2U0slL3xwxcRJB3IPeiH8AM3yeV5LGqyJQe73F/ZvawZXVeo57ix?=
 =?us-ascii?Q?3qmUUAOnh6pp8eptsAxs/U9jLRRiTF8MzAocJKECoP5C9Wdt0BjDQU0viQ+C?=
 =?us-ascii?Q?RsdkPrU+eu7K1njM8adsrk3Bn5deWrYZcxo8RF35Y/NfhZa3VC5UVuVMORBd?=
 =?us-ascii?Q?eTeiCg4J7IB1uTtIkJpNTIA5+9s7bpNzG8RJ1yQrmB7jkB/KQLzcGSXQpuQp?=
 =?us-ascii?Q?OJgp5SHf81blDPnzzGalSqFgnyuBE+2BrqvMQxIAsirMhHwrLzQIpXxKeAwo?=
 =?us-ascii?Q?Q1xpWlXm00+dtxNjDupQxB8yfuR06TuzLD94ae9kHS1dI0CGOSnGxnsK4CY4?=
 =?us-ascii?Q?jttM0XbaiKdTPWDsj4hTn3KQJNyEERB9ALgQkciawMSwhAKEeoVWY5uPW+wp?=
 =?us-ascii?Q?2sPYgW/2F/icOBHnrBa0WyEfLlVJkoLQbSjGmy6pdH9u631CeC8wlEMV0A2t?=
 =?us-ascii?Q?Kb1zFnzDpxDvK7dnsAafPsk9CohmE8YlXEnUNGRyZbLwy2+gw6REpAKbU6Wj?=
 =?us-ascii?Q?9w9qQNItcUcX/QFjbOFU6H+2PtW0yhB1gwbphG50CctFNRAKkmZSJ0cE4vVv?=
 =?us-ascii?Q?2jIxsRUAq3wAhyK12RXKRbZk/fPbsce/dibOnrHsGxYRwJ19H5Fb6Y9bXMWz?=
 =?us-ascii?Q?qBjZ861PtQ2OjlKRVhTIgL4I2oz9WbGSVZNkBjQ8LcvIomxd629FTIsCRtSf?=
 =?us-ascii?Q?gQ7ptyfUidBgBF7JxdOfMG4CujCF2ad2mbx3gAvLCZh7WYbUOMWSxGahpS7j?=
 =?us-ascii?Q?5hsDdWmkBWrYtU9xn7E2AHEFnhZ9JEEs8SPyxZH87m7yUEWyzlZeVoE9YeY3?=
 =?us-ascii?Q?/Wy+aeAKY3hfiTHjh9sRsRpJ1rA+EREjmJO2MExp1DPubCshIQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN1P287MB2834.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Sz3Bzrr6UazU9IncWtbzSTeeSprM+v5DOHCYpNC+buvxrNHWDVJsCNpM3oM1?=
 =?us-ascii?Q?bJH6O2tY0forIH/ICZOLgspJyD6Iy4ewyxLxtb0ZSezDNffdzUC2De8gAiTG?=
 =?us-ascii?Q?MAfC4YmjgjeIUMAXcWf3LtCH7QQG18TxBM0qouLyHYaAZE/kKL2bRdBDvf5q?=
 =?us-ascii?Q?ztVd8Cuq8K9kltuLSeUK5r9ZW+xxuYgZf3fPgvSrl6Wfc5+zh0xhAl16GRUR?=
 =?us-ascii?Q?7pVTL6l1XuP0nh33ADeXh1g8R3irmfFxnlcGLKOGyxSjJ0OWOb1AHFhcLxFl?=
 =?us-ascii?Q?tDBu/QyFZ2p/SIGBFoobmgKnqtRidsYo6YiSYTbz5hXq3BAnTd9NgHCbimnY?=
 =?us-ascii?Q?/51KgCWsBD5OVLRlyuwB4TucPgOhwFg5tebrNq2DJosx5DuPZrGt76xCagR4?=
 =?us-ascii?Q?hAPT6xix+sA+Lk9gI8asYJC4QswFDMLJwXngSSGq21RdrPwgytbFo/e0+9yV?=
 =?us-ascii?Q?kHo6MDMklb4b/nBWtAIMOnkezqi5orMnfswlFH7EvX78ni8B3kgW/P2Cwzxc?=
 =?us-ascii?Q?uMcLntUd2n1LIG95WV3/RR2Fcg5JhTWX2JISwVFtIqt+NqW4wCTRL5ua9/G5?=
 =?us-ascii?Q?e99ROhvXnvqIH6e+gu3ugK5evi8wqW4WIfD/x0bAH2N2/gzd6RxpjvJToRXI?=
 =?us-ascii?Q?jE6PMPMiJIJTvB5fTlw7OYxA0gnp6795WUpUA0RFbEc7cvThwGU/8r8r9+Hy?=
 =?us-ascii?Q?lJKNbYzT/qcgBwss2xfFfHbeTkiq8peLeExriaaD0l1peTZv/IMNlI4jbHeL?=
 =?us-ascii?Q?CTjX7hesdDTQAN4A5w+hoFUENY5Dmi48+1FPPxq6wCLFI04Sp/c6PPK2HZvS?=
 =?us-ascii?Q?v72woTeYYuEQUfwXMe3R/MlFemlphgNu+vGUu0s0T0pu8BQH0XmnYnkYEW79?=
 =?us-ascii?Q?YcdayrcOTEWbHVaQIZ8unDIaw2U2vQuUwVr/UHTNgUcOVKuV2kyeonxLR19/?=
 =?us-ascii?Q?bmNBFT0ms9IKqqq21TnN5ckwITxdW/GC3tvGO2q2GBijv2Ex3FdK5SV0xOgN?=
 =?us-ascii?Q?JBxxTw6aiRbEV/lNPlACdNI6HJmQ1OVMUA2XvLVI73wkhmi6g2NYgHiws1ab?=
 =?us-ascii?Q?KxutatlIJY64cLW9F8yPMnPXOpcR34xtykD8EIAEnTm7ChE34MMPT3ZEUw+M?=
 =?us-ascii?Q?06wL4Y7t7gr+ekkjkgKUGooK6y2qC/JkFZwmULHCbt5WHhjScquMHqTGV1qh?=
 =?us-ascii?Q?H6HeGc3D3EK0n83oTn7RORudykWSaVqWa8rfm3d0Np+xqI1oS3Jf/QaOVNCi?=
 =?us-ascii?Q?iZ6oyn4PKO/AxVilUn4RwqM15BxVmgUw6WQhZAZszQxj3VpK9krPK2JcDRHr?=
 =?us-ascii?Q?qApC4L6XnGcvTIZjvCFcoz5oKQEVJeN6jPfX7nAhLk/d78Xj4TNk51rzIDj6?=
 =?us-ascii?Q?fsoN5ByXtUy1k9PMh62fShRrq4YA4aHJJKIPcdq+mtZg3RoCxOG/k/6Tr5Mu?=
 =?us-ascii?Q?1XB0NjRxO6gBNPLlgnrz3Vomov1eOEbcx6IHD9bvX7gt3siOnrx7pRFO31Xw?=
 =?us-ascii?Q?9zBkQvpC/H3ta9/VU4899V2fyLFLz9CFC8AhSMfYNWBrcHajnHgSf83ohhqP?=
 =?us-ascii?Q?1aiiZnuzDhTHA2H8zJd0nWMRxIte9ufepCPMObySvNTXU7/C1Kz2xA0tQm/Y?=
 =?us-ascii?Q?3bJ0diSWUhSyaQZtvI9fC0HCZrF43nLhBHK+u0FeBxfCTGL58+my3aTHKhvf?=
 =?us-ascii?Q?VitVRQ=3D=3D?=
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
	koQKG+PlST5fiKT7FnPN7IRAbLwb35mv8Js1Hk31uflrxZJr5uCErY2TDAdTYgZUSv1tTLMsybOp3DQ+PSYzwlv5UyJH26e1RAcJTNvglWHtYOzkjJ2lmk/jIwTYq2jRNkLJWjTGLBlrpiunhLh7gZO/uccOEgDviQKLcloB/wFc2zR6qXjlWiaX3qiPDDui/eoHUmOSGv5fjC+EoMotRHR6LXoE+f8smWNSuUq3B8r7izNfmnRbrCh3edFpkegq4e+hA13c8lK/ly+I3EEJe+xiNGV87mQ0Qfwj0BSQLR9l4jT3VR2u5d18mfm1jxBMCWAxGRKWqwJljwGH/dAR9F03mKExt2gZjAryGtnFWUvGoEOyNKiu1THUUbJWlOruiAJHqmR/JzqhUdsXl1+PW6TUsIluNxRLoFlkqm17vQnsRE4pX4TtSeAuNrJ4SW+S9X9lEAPxmzqbmp3tFqCxjkJl5WOvRNOdPtZ//P4w6QPiYyP5afb3ZgqkDj+bDy+yhI/4v43VTU6y8xWEiYPzh9YekUye/QlrAUMTdSHa9wH9pggyV8PS28zvdvD3kg3CnuTM1sisOjqYf4XnWcrDOOUtC6z2MK71cac6WFUgUO0=
X-OriginatorOrg: educatalysthub.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN1P287MB2834.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd13453-9933-4cef-e8bb-08dcd1c0a600
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 17:47:32.8512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e365ff34-85ca-4d9e-869a-17889878f5ae
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2orFaKF4ago9kWobABPSN3IJ1DudXYGzFIY1HuRFDWedqyxLe3TjM8gHZjOnGpquRo+CzWrT42miYMcdveYNJcsyBRGVcKD+flZMg3iXYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0305
X-MDID: 1725990457-Oe0AsGIg97Jj
X-MDID-O:
 us4;ut7;1725990457;Oe0AsGIg97Jj;<lily.green@educatalysthub.tech>;0590461a9946a11a9d6965a08c2b2857

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

