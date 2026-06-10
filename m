Return-Path: <netdev+bounces-297590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z6rZHQI6KWqVSgMAu9opvQ
	(envelope-from <netdev+bounces-297590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:18:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3237668301
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:18:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=hvvsC4m9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297590-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297590-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53757300AB28
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDABD3DCD97;
	Wed, 10 Jun 2026 10:13:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105053DE434
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:13:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086409; cv=fail; b=rk7UqkNx5ceNz9h3LsXKlOKD70CUXMHdL3bXf9aU9hDFe5dRbsavoQrD4vvHSebmhdJAIa2b3kbh3qhVURWDFu0YLnv2mZa2jG7hgrw0PKWJvTRyZiXDqH+WqcMYF6+R+XfZCq3Ah7OVmUE6Uf9FUwRQHw9vA68PdLxqfNeZbMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086409; c=relaxed/simple;
	bh=SCf0gjm9Brm+6f5nuIPgd6MLO2KEFGjqMgjNVhzfKcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MnuT7X9GiXoK1feJgt5ByOotQUFloosTOYOt6U+tskAeBpo3hBuqhWlm+j0OpDN20Xz0jh+PSjJZf0bgN/+SgIe1+cklCdpQ4UgL5pk/rxyZ0a+zszMCvIpo5s5GOKDgDOL+ANYlEsJ5RxER/TvkH+GiECn9NdvYwviutFrm7nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hvvsC4m9; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7hHKvyTfN1gRo84+bZrgBg60IJkacmVmO1naDd8n3LHPzmbDCW0V3zbtjxy21glOxX4J8Ui5c0G40RGjNIWa9zhD7afW5l8g7/OhIDnGzIqHEnJNw8bITkCkI2R9BPXajDyV07CXG03UpvQkCwJ7E04gqG1s99SfY0Ibit1aIvOQsvOQILI0JXHGujbc1TAjd9X141JpQRr+8wZoJEv5OhVVALtO4k4SvbUC6efkxdaR91nSp2Mhyk4jHbUMcHvIdigvPEpl1v2Z7d2QKCZFAPYnBAU4PSLuA3jVVPDk/6ieQvbe+7fFaTJTNepV9L7fCI0Zm3fci0HR8uzmDvMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCf0gjm9Brm+6f5nuIPgd6MLO2KEFGjqMgjNVhzfKcE=;
 b=Svymy9MdS+n7CjXvvNrni0yJO67DGwOH2tRLAUeSPlSliPYcahuAlyQSJw1KlbVnKm7QS6h62d/Ecni46/N0ZtwYXp8ACkYCJ9jF8RB8mdkzoIB3N7pSYu4B01WrZpSe7cz2KxZ7ecJvbFLUHalI/uwxLmjkk/26X0MCxvTkuus7NNspGGhSjVUTmZDCwVH5LhOk7f+iV/ZYTnZyBgP6Semq0NuALC/8CixscvHoicClt2bGaXxNluHxfUwSzqnFdmzxAIBXm+tfO7A5o04l9WpdYjuVFpZNT5TRGcqCyfTUSl9CcZeHnbUi+K9BXLEbHm+qYeu9Iz2DRxFzqYbzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCf0gjm9Brm+6f5nuIPgd6MLO2KEFGjqMgjNVhzfKcE=;
 b=hvvsC4m9DBOWavxjW2vsy48WjGNKuPwSYu9BB7IGKFfqkJBG0UDRN5E6dZko1f78SeBMC8mL895bAsQo7oGWI+YlATJr6ccQyFZClI2wo5fLwgz89gInruhs6+OXXV/TDyb4ggm1NQV1uBphD9Efx4cJOw4M01nkO14DkTghJZNNfZaFX49Bvwy5rvXqlp7hVrICQdspFbw3P4nL7B5WYyevfz3Vl74UMJ1wxMSO/vgtHxzCHXNihdZd98XLpP/vi1e0hiIT2XC/Ka+i9QaoE17fsQtsqH/UI5n95kOXwY+jf4Yvdw/bEwu6oNvHYIdouT61EH9P92ArhsghsNV0Gw==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by DU4PR04MB11030.eurprd04.prod.outlook.com (2603:10a6:10:593::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Wed, 10 Jun
 2026 10:13:21 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 10:13:21 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v4 net-next 5/9] net: dsa: netc: initialize the group
 bitmap of ETT and ECT
Thread-Topic: [PATCH v4 net-next 5/9] net: dsa: netc: initialize the group
 bitmap of ETT and ECT
Thread-Index: AQHc97/mLNuYQ8KoE0eAZZEekplxrLY3IsWAgABxP2A=
Date: Wed, 10 Jun 2026 10:13:21 +0000
Message-ID:
 <DU2PR04MB86291549B9C1DA3827ED90A1881A2@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260609032955.2066089-6-wei.fang@oss.nxp.com>
 <20260610032759.A09281F00898@smtp.kernel.org>
In-Reply-To: <20260610032759.A09281F00898@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|DU4PR04MB11030:EE_
x-ms-office365-filtering-correlation-id: 220a3e7a-ddcd-424d-1032-08dec6d8e670
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|38070700021|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info:
 Gv3BAjQlyundbbqehJ6Zk03QMIHiDUWp+xGMTUnstMMW7g0CrnY37y6CRvNXEiWnaUlxKzPT9UzdnPqAfjy7xSZmrt6PHnlEzwFr6HBfF/033iVdU+pmHWB6qM25gOi9bfa+0YbvlNcjgd5fLgtbPTGNhNg8siL7eNdgC1/hUhCtYEpGdJeLHFhGoJiHPH7ES08ske0/lsuPsqIfHLqX2eOJVtnKVw58gxQMf2AF+nWqydcwp5r1hRcJTb3gcvw/s3q+KMMv5YCHTuiffyAdo3XCWEQgWHl59dXb/5itk6fEpTvAv7dZOwqT5WB9XXzitt8QXQNFuhQd/JrkrBDoqGbSmac45/CmtgIvRn1lYP71rbvTGmCg2vQheWhHg/2ClLhkrbv3bkic0U+su4/O/31MdmPq0z8N6XOhBBVwq3fB7YBkDgdYHWMxV6GRKwRa0EEEx1Y+ry3hxqukjgWR7gA4r5pE77OQjxlwoFf+3li4t0EJFnEBRbgfN8WkjqTZZPGZTPPCpa+DooigkOO/oQmw8UvB1ObIxD4n98GfmF3boqu/k4/cEIsuAi5d3u0YiwrUINOAU3W/8lSHnpNVPzZpNUkilPjH62hetHwbdPORFQ0rrzDF1ucICxSWRmP6EU9iGcC0BSKEutNpJj6j/+oNTRz2Rhj4ypxYehRJRGlA3ksWAvdgqRVRTBaLwOKU3eYNN1dSG8IkwqEIYZ3F8PI8ZrbK50Jfvc+mACbr+Rb6BaOT6nL3sp7TK+ZAkcaj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(38070700021)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qkswb2EwdGVxRTZxdXAvTW53Y0N6dnR3UUR0QUgxeEIxS0NBVGxjWjk4WHM1?=
 =?utf-8?B?clEwdVMyczFoNkszSC9NNnREUTZkV0pydlVVdjdVWjZockRmb0ZZTzcrTXVx?=
 =?utf-8?B?UDhwb3JSN2krbU1yK0g1UGdoRDlLRkJjNUhqeGRFQ0tPMU1jYXduTzhhZnpC?=
 =?utf-8?B?aWtmUDdaVjdnUjlXQ29YQUNRYUJWM3B0WTlLOWRqY2RWN0ZucmZiOFZBQVNX?=
 =?utf-8?B?aGt1ckE2RXNOSHk1UHZ5dEZIUm00SW9hV2VjTXAzMDRxRVM2bFJSd2kzMkpN?=
 =?utf-8?B?MWpZcFM1d3BoaUgyV0ZJTExiNWtWV0NweWV1WmZEcVYxK2tFT2JFVWZKSU5X?=
 =?utf-8?B?Yjg3YmtRcWRsQjkrWUpLQWtvcHh4K0dRcmlOazVLWjN0TFJjL1ZreWY2OTgr?=
 =?utf-8?B?Ulp3bTF1WnplNW1QTDNmQkxjT28rdlBQdWlITis4eW1BOStScEdsUjNGN2d2?=
 =?utf-8?B?UWFZT3FlZkp4Q001Mm0wczRBcVB1WTRqZjdTVUVHZUY1cEVBeUFmNFozWHhP?=
 =?utf-8?B?RWg0cXJxdTd4TituRjhWVGpNMnRxMlh1TUZ1TFpHZzdKSjhIc0dPMHM3R3Az?=
 =?utf-8?B?cnUrL3AwQWRmdm82OEZkLy83d1VkL2dTeVJRbGJZNXJqZjhBd0NwQS9peFdq?=
 =?utf-8?B?eTk3UnNaOWwxSVFYdmhoM0FjZStLS3VQL3BmbngyckVkQTdEWkEzWXp1c2Jw?=
 =?utf-8?B?TGsyVEYvUVFheFlZYyt4Y3d5eFdhc0Z2eWc5a0pPTlJqa3Awd2lwMytGOTdC?=
 =?utf-8?B?SEM1RSs2dnJiaWpnZTNGVjRpcDZNR25XUTJXQ1kvYmYxa2d6Zk5CMnZSSFgr?=
 =?utf-8?B?MSszT1dQU0ZaM1hJeGVXbXhhM1JFR3ZQVSsyYVNhOFhtRVJsTGxHZW1EeTRm?=
 =?utf-8?B?Mm9FVkRlZWNTd1c4WmRBbUVIOU9LZnRNMDd3RDJ3S0Zya3IwVENtQS9QdTdx?=
 =?utf-8?B?NVdLQllQTXJGZ2Z4WnpMSVo5N0pzTVhhU2x4NXlPRWtMdHNqSjZEb3IweWw1?=
 =?utf-8?B?K2lJTGhranpWWWRzdUZDVVFlVWdJZHFETmhkMnpNY3F6NU5RemcwYWdjUlg1?=
 =?utf-8?B?dDFKbEYwZ1RyTW5aZzYya3JMWG9XdEpkZkhaVmpMK09Cc0JoRGhsZ1NHTG5a?=
 =?utf-8?B?VCtCUDhid3ZzMDc4dWs3MmNiazBrUm1DWllOajNRcURUQjNmTmRhOUdpRnEz?=
 =?utf-8?B?VDl3RUNJSGdmaWQ1bnVVSVY0eFVpMm8zeEx3ZGN5d1dsOWE4UDdMNTgzNXF0?=
 =?utf-8?B?c3lsTmZsek5RbUdoTWlWak0yZWZFR3A2ejZOaGRpQ3lpRmhsd2hqZGFGUlBn?=
 =?utf-8?B?a2haY0ZrUnlJK1l5eWFNblFxeDlSV3htVU44MzdKMjdWYlFJR0dQUS9tSVl1?=
 =?utf-8?B?UUdrV002dGhUcHZqWlBYWWdQajdJQzZyUmJSS1grTjJnRWk4cFJpWEx3NllR?=
 =?utf-8?B?UmFkekVEUkEwbDNSNWxVUEhxQzZYU0hsdHJ6MXo5M0VLUGN2ajNDZ3M5U2xl?=
 =?utf-8?B?WUpyNTlxdmsyVnI1ZXpqY21lSkhKekh4U3o3amtGaHdwZnprNDJrUURLa1Ro?=
 =?utf-8?B?N0lsT2NEdlJRSWVEa21RNnROdzFpWUxtZFd5Wnk4TmFaUUQ1SkJRbmFWSGRu?=
 =?utf-8?B?cThoc3N1MFhzWDN2Z3RhZkxSUWhtdzhVN3NYREN1dVAzci80NHZ1MHZ5ZENM?=
 =?utf-8?B?eDNDTUJ0QTk1RFM2TGxPdURFSFNrdHZON2dEVVVuT2xrK25HajFnQ2RxTmpJ?=
 =?utf-8?B?bFIvM3ErNWNTMVBjVGhJUks3SDc3MDRvMTlRZk1mYjJqWUQwQmZKd3VNVEJQ?=
 =?utf-8?B?Z1dDTFp1MHJwV2YrdzUzR3pncjcvbUc2d21OVFFpd1NNaDRVcTB0dFI1dXFt?=
 =?utf-8?B?aENKRDNaZUViaEl2c3B1OUtrVHk1MGR2ZUNONzFDQUVPeWxaWm1Rb2RRYWRX?=
 =?utf-8?B?d00zZVVWSWJ4SWxEcHN3bU1aSzhDNXlvSXVnRTBnTDJMRjQyVmVSS0MvNUdl?=
 =?utf-8?B?K1dHMTJmOVNZWmp2ZW1nakJwSDhnV3ZveVp6R1d6Wi9jcHBqSVNOVllvZ2Jp?=
 =?utf-8?B?RXlzVlA0MkJNaTFRdW5iTmljdTJpZUZudTROLzBYRDZrZ3c0WWRTWTg4TGIv?=
 =?utf-8?B?R3Z0L1htRWZOcXZGbXhhWHFFU0Zvd29XM3VyZ0pRbTFLek8rV0ZHQmhoSXpi?=
 =?utf-8?B?V1pET1ppcHFURFprckw2eXhWYzFhQUk0VmFiOVVhV0VsdWE5VWRJWCtsdFBj?=
 =?utf-8?B?Q05SUmd2M2JlVENQQVdqV2VtWDhzdUY5SVB6STVJTHFIQ1RBUVVMbFpMeW81?=
 =?utf-8?Q?ej5ils13EVSurtVdNa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220a3e7a-ddcd-424d-1032-08dec6d8e670
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 10:13:21.4086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1gLXFi/1w9WXW8grL+wH/Xwpb11BAi9PRUx8eWJWOMCKuFflYkVXAuezLrfiyIjibmq05gTBNB8EjjYCXW0/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11030
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297590-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,DU2PR04MB8629.eurprd04.prod.outlook.com:mid,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3237668301

PiBjb21taXQgODY2NzJhNTkzY2FlNjE1NmI0N2QwMmYwZDJlYWQzOGNmYTUzOTUzYg0KPiBBdXRo
b3I6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiANCj4gbmV0OiBkc2E6IG5ldGM6IGlu
aXRpYWxpemUgdGhlIGdyb3VwIGJpdG1hcCBvZiBFVFQgYW5kIEVDVA0KPiANCj4gVGhpcyBjb21t
aXQgY2FsY3VsYXRlcyBhbmQgYWxsb2NhdGVzIGluZGV4IGJpdG1hcHMgZm9yIHRoZSBFZ3Jlc3Mg
VHJlYXRtZW50DQo+IFRhYmxlIChFVFQpIGFuZCBFZ3Jlc3MgQ291bnQgVGFibGUgKEVDVCkgYmFz
ZWQgb24gaGFyZHdhcmUgY2FwYWJpbGl0aWVzLiBUaGUNCj4gYml0bWFwIHNpemVzIGFyZSBjYWxj
dWxhdGVkIGJ5IGRpdmlkaW5nIHRoZSB0b3RhbCBoYXJkd2FyZSBlbnRyaWVzIGJ5IHRoZQ0KPiBu
dW1iZXIgb2YgYXZhaWxhYmxlIHBvcnRzLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvZHNhL25ldGMvbmV0Y19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9kc2EvbmV0Yy9uZXRjX21h
aW4uYw0KPiA+IGluZGV4IGZhN2RkMzA3Y2UxMzAuLmQ0NDc1YWQ3ZWQ2YzIgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9uZXQvZHNhL25ldGMvbmV0Y19tYWluLmMNCj4gPiArKysgYi9kcml2ZXJz
L25ldC9kc2EvbmV0Yy9uZXRjX21haW4uYw0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPiArc3RhdGlj
IGludCBuZXRjX2luaXRfbnRtcF9iaXRtYXBfc2l6ZXMoc3RydWN0IG5ldGNfc3dpdGNoICpwcml2
KQ0KPiA+ICt7DQo+ID4gKwl1MzIgbnVtX3BvcnRzID0gbmV0Y19udW1fYXZhaWxhYmxlX3BvcnRz
KHByaXYpOw0KPiA+ICsJc3RydWN0IG5ldGNfc3dpdGNoX3JlZ3MgKnJlZ3MgPSAmcHJpdi0+cmVn
czsNCj4gPiArCXN0cnVjdCBudG1wX3VzZXIgKm50bXAgPSAmcHJpdi0+bnRtcDsNCj4gPiArCXUz
MiB2YWw7DQo+ID4gKw0KPiA+ICsJaWYgKCFudW1fcG9ydHMpDQo+ID4gKwkJcmV0dXJuIC1FSU5W
QUw7DQo+ID4gKw0KPiA+ICsJdmFsID0gbmV0Y19iYXNlX3JkKHJlZ3MsIE5FVENfRVRUQ0FQUik7
DQo+ID4gKwludG1wLT5ldHRfYml0bWFwX3NpemUgPSBORVRDX0dFVF9OVU1fRU5UUklFUyh2YWwp
IC8gbnVtX3BvcnRzOw0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBDb3VsZCBjYWxjdWxhdGlu
ZyB0aGUgYml0bWFwIHNpemUgdXNpbmcgdGhlIG51bWJlciBvZiBhdmFpbGFibGUgcG9ydHMgbGVh
ZCB0bw0KPiBvdXQtb2YtYm91bmRzIGFjY2Vzc2VzIGJ5IHRoZSBoYXJkd2FyZT8NCj4gDQo+IElm
IGFueSBwaHlzaWNhbCBwb3J0cyBhcmUgZGlzYWJsZWQgaW4gdGhlIGRldmljZSB0cmVlLCB0aGUg
YXZhaWxhYmxlIHBvcnQNCj4gY291bnQgd2lsbCBiZSBzdHJpY3RseSBsZXNzIHRoYW4gdGhlIGhh
cmR3YXJlJ3MgYWN0dWFsIHBoeXNpY2FsIHBvcnQgY291bnQuDQo+IA0KPiBXaGVuIHRoZSBoYXJk
d2FyZSBwZXJmb3JtcyBhbiBlZ3Jlc3MgbG9va3VwLCBpdCBhZGRzIHRoZSBwaHlzaWNhbCBwb3J0
IGluZGV4DQo+IHRvIHRoZSBiYXNlIEVUVCBvciBFQ1QgZW50cnkgSUQuIEJlY2F1c2UgdGhlIGdy
b3VwIHNpemUgaXMgY29tcHJlc3NlZCBoZXJlDQo+IGJhc2VkIG9ubHkgb24gYXZhaWxhYmxlIHBv
cnRzLCBpdCBhcHBlYXJzIHRoZSBoYXJkd2FyZSBjb3VsZCBhY2Nlc3MgYW4gZW50cnkNCj4gb3V0
c2lkZSBvZiB0aGUgaW50ZW5kZWQgZ3JvdXAuIEZvciB0aGUgaGlnaGVzdCBhbGxvY2F0ZWQgZ3Jv
dXAgaW5kaWNlcywNCj4gd291bGQgdGhpcyBhZGRpdGlvbiBleGNlZWQgdGhlIGJvdW5kYXJpZXMg
b2YgdGhlIGVudGlyZSBFVFQvRUNUIHRhYmxlPw0KDQpUaGlzIGlzIGEgZmFsc2UgcG9zaXRpdmUu
ICJpdCBhZGRzIHRoZSBwaHlzaWNhbCBwb3J0IGluZGV4IHRvIHRoZSBiYXNlIEVUVCBvciBFQ1QN
CmVudHJ5IElEIiBpcyBhIHdyb25nIHN0YXRlbWVudCwgYWN0dWFsbHksIGl0IGlzIG5vdCBwaHlz
aWNhbCBwb3J0IGluZGV4LCBidXQgcmF0aGVyDQp0aGUgcG9ydCdzIG9mZnNldCB3aXRoaW4gdGhl
IGdyb3VwLg0KDQo=

