Return-Path: <netdev+bounces-79060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A40877A83
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 06:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778CA281A93
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 05:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C9279F6;
	Mon, 11 Mar 2024 05:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ATQUPW2a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165732572;
	Mon, 11 Mar 2024 05:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710133768; cv=fail; b=LRkPbGRjElRRYXq+ITC11ueOIgy+wRnfWlklvA9WtukKpS5myrW1qUEIzKDqygAkOBi2hHzSO07Ka8yUqxWrZfajwpRgNlypoQ1h4oO7eIeTkZaGUWCD56hFGTZrPBMf6xn+V9ZQyyylzM7fRwMF+4BZFLuQ7pHNJJgVVS5Pu+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710133768; c=relaxed/simple;
	bh=LL5OYpFOokEf9Orsmdj7GoAywFgzj56JUM+OR9Tir0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mll3hFMvlry25qm6ZBNSZaCo+wv+SrbaO6+LoFST/CxZOyA5nA3n59/pVtGXh9ohllQrSnSQcXWuYpbN3lY2Q36JxBrTVXwoWag9h4DJWYpJ8bxy9gK24/IzSV0DIPTv40ovjLv3Wpe5WUsQIuXm0sO3hmAs2sz3JjQEdtyIO0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ATQUPW2a; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B4DFNj026726;
	Sun, 10 Mar 2024 22:09:04 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wstqrr3js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Mar 2024 22:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEt5hIGbjN520uXAP37rcOGwdvRGM6U4lVMSEduvgW4jbJE9YleFuTIt9UAGXN0egIFUhNKa/07946asyInqeWOLHO/EPl9Xm5MhUtCD9cgJgMCWPo+g4XTZkNybrEZwctSmKRJyasumv/Yuvc9rweeAE+zTsUMeQf3P9Oj4i2IWMNRaOAPbvseGSNAflrHU/FBoEE5DbDbfcF+owk2kenn59IujU5f6Jrfk7b7EzohQfuYpRcKXBKbLbUCUncdEGAa5Qp9BYcFzqxHPfr6poU38x7G4v8IQKyCLodDhuCy00GVUEG8w8ON/nz47ZFegg1kC6ViTkCEXZ2VDf+cW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL5OYpFOokEf9Orsmdj7GoAywFgzj56JUM+OR9Tir0s=;
 b=lI08D4Co792xI+v6CniM0a7qRgrGkAF6EWOE5slk5XJi8pY4jouN8hBpm1g5+gdcbLW0xju6h/3JJXPPtsOrMO3/nD+81wSIQXXX4vi1oM98YSaAyw93N3g+ESu2mPzLGSEugpNf64AKG/pYTkVTgVYK4vFyNgcOzQKX5k6cC5qjqb7vtdvgQZx5UE0BvOelZD5q1s/FfPy/0VYbvTfx0X4dBWLjrm8yD0GkZ7RIJn3G7ar2fTETyQCY+o3mEW5mZkWqi/eEfcIQKiH//ZIqr46czOmFavXeAkgh7qT/TRpckkD4GtkNA5mw+5yVi7SMnYDv0OpyvEpiRB7VqSdtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL5OYpFOokEf9Orsmdj7GoAywFgzj56JUM+OR9Tir0s=;
 b=ATQUPW2aibI6Dj4utDqgfuv1S7aeI3tqvhQHvla8OnzuWljlnXDkYmfjOE0pvNFFnO0bXka6/lA14l1pDkBk5MxxgOT4HnZu4+6WI3iXrdLlgPAy0uY2iRPmp7E4bX8Wn0n1Ziw5Chsd6803yq9oT7EQhuXq4YdQiARjxirIwTs=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by CO6PR18MB3844.namprd18.prod.outlook.com
 (2603:10b6:5:340::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 05:09:02 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::89ce:35b4:c4b0:c7ad]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::89ce:35b4:c4b0:c7ad%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 05:09:01 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: "edumazet@google.com" <edumazet@google.com>,
        "mhiramat@kernel.org"
	<mhiramat@kernel.org>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 2/2] trace: tcp: fully support
 trace_tcp_send_reset
Thread-Topic: [PATCH net-next 2/2] trace: tcp: fully support
 trace_tcp_send_reset
Thread-Index: AQHac3I7s77BGs2LKEGLBLC0WLJwaw==
Date: Mon, 11 Mar 2024 05:09:01 +0000
Message-ID: 
 <MWHPR1801MB19180D70AC03B66598F56B20D3242@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240311024104.67522-1-kerneljasonxing@gmail.com>
 <20240311024104.67522-3-kerneljasonxing@gmail.com>
 <20240311032717.GB1241282@maili.marvell.com>
 <CAL+tcoD-2g2BTYOXfWEfrJ5DYh3PQcUn=Sk8_Zr6ZZLj6Pokzg@mail.gmail.com>
In-Reply-To: 
 <CAL+tcoD-2g2BTYOXfWEfrJ5DYh3PQcUn=Sk8_Zr6ZZLj6Pokzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|CO6PR18MB3844:EE_
x-ms-office365-filtering-correlation-id: 1e5f4e40-f9fd-4d73-2e54-08dc41895dae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IQ0eN8jQ6Cw8HEOxF1IQ+qYETUl06FSS/s+HuZlSqdbsTgXCpfaJTOazwNk5GOCClJTvR9Z3vsyr2/ZJ772R0H3I2jZ7kUSfD7/7Oy/bNjrVSFxtfHzBwdyeafdOvkxodwO2p+Ft9Nxo7bN4YEd/GibqTN+ck7MNRZr8tDZzMMadJg2Hb9lhiKPWxNrvb2DQWuJNmXshqg1IbroJHkRcJEMR0boW4CjbzWbo8HWczsVSYY+N6YbRlY7RfHzKC3gl+dHoCLHrkeXSEERrGIpFqoOciszlQM2Fe87Ett8o29tBJa2ot3HbD9GoJJI20vWUgXk9/ASCw3SCNERfBFaqvFfdncO2RRwNuWu5bA5TcsN+tIpgrw6lvNWqoNoYFgPTFkVJxleHmHNp50kFsbSHnjwlPJYOMnfe7iscrH0nrwhFnLLgFcg68Ky86Tx6aZU6GHx8hwrntq77cT316kkYZ+yQ/clJC9zkl213KUvShwhvTHoL/UFzRkROdw0DQ7DX+DejWx0CNituhPk9JK/mxvp2fpEkwENW2zzIBB/cOgIenJ4j5JqQ2hMjJaXpqyUC462Jmsb9qYJc7EZa3jmh0mdebLrxvykp6sVdgsMV4zcgfpDBijFAv4vVcYZgKpKw7vlY1u5KPerKD3vXn3Zd8Xb80UUVoXnlDVz2IV375thO/SYpDtW/Dv92tSIR0M8Wrf3hzRmjNNEwZdf1yZvZ/w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QUduVmFVeHBHZzl0MlkxdmdpbXhid2U2NDdQWUpaOElDV3E0RWtLWEE4UEhw?=
 =?utf-8?B?alFGTnhBSUlhVGFxZ25DZnJtV0dNemVnQy9RT3BjbnJueUZkWkhkdzJKRjJx?=
 =?utf-8?B?Y1JDVnlzYSt4SWd0R0V3OGx0clphazNXK1FEZXZ6T1V3TytERG80Q1ltSTlZ?=
 =?utf-8?B?SnVHV29GT21hV21xcU00b3Yza0dsc1JiS09xYzJWYjdvMjBoYU52MzJwWXhC?=
 =?utf-8?B?VWZvM1p4WHhMMFJwaWpNMmJHQnRDZEtYdmdaVXZNZVVUMyttdXAvUExlRmk0?=
 =?utf-8?B?MytuaFNoUHRXSXJOOGZZM1hCR3duNzZHVzQ1VnpxSDNTVzJrdHQwK3M4MWV2?=
 =?utf-8?B?b0Z4bG5uS0FxSkUyc1VOeHJ0bGkwUVZOeks3YURBUldQeTFlYWNHMXE3cldG?=
 =?utf-8?B?MFFoblBCZ3lCejgvN0lkR1pEZkluRUxoU2dNZ1ViWDd4aTFFODRwdEJjVTFq?=
 =?utf-8?B?c3ZoMHRmNHlJVHRuckJPTDY3dTJ6dXpBekVxL3lWbThsbEw2NW0raDdqVVlo?=
 =?utf-8?B?dVBUY3p5L2JmRklEa3g2cTRxNU5VQXFjUTEzTmcxeWZmTnBScEFOY0Q3WEg5?=
 =?utf-8?B?em9scWZ2UEFsTzc3aFZVV1U0U1M0UVJqL1dUcmptN0tiV3NTamJqOXBaMHU4?=
 =?utf-8?B?d3M2ZE1DOXNka25xUW52TFBBUUtCdytYN2RlSXc5U2w4dVhtSDIxMEc4M1Iw?=
 =?utf-8?B?QWgxUUdZbHQva1A1cVUvdEdQY1BDN0J0amxPdmVKUTkxNzF4R01iN3NodGdV?=
 =?utf-8?B?Z3hIaWw1REtZTEE3MkZNMFkzdjRLOWtaYnhOOWZ0T2xxc0ZxRHVhZ2FCZzhL?=
 =?utf-8?B?K1kvNEMyUStnaCtQcnRkRjBta3FWNlBNcDl5RkJkd2p1V1U2amRNMzNBZUxM?=
 =?utf-8?B?MWpyVmNBczNEM0F0R1VYU3VmWEFSOVZnOWdXZHJ5ZFZ0NlFHNEw0dDB1NVlq?=
 =?utf-8?B?c2pzOVZid1FFVjMrZ2lSYklMWFlrTnJWRlIrcnJDREJwVE5ZZkkvdGtyWkxR?=
 =?utf-8?B?d2hSdFE0b2xxSnFIN1NlN2VGM3RDWE52UTh3c2ZlbEgrYjBlM2Q5VzNsdHc5?=
 =?utf-8?B?YXVUOVE1RjdRaGVsZHlxN1hQeXd6N1RQTG56ZlBpUzBVeDZXSWFYVXVldVlI?=
 =?utf-8?B?Rkg2aHI0OUtkeTdHNFZ1OFRDaEpvaE1Ndjlzci9mcTNhZks2VWdxckRjV3JX?=
 =?utf-8?B?Nkh5RzQzcXVVVnBrQW0rWEZ4TnNFbi9FUmZzSHV0UFJ0Zmlna0RFeUJhSWVZ?=
 =?utf-8?B?WGhlR283d1pZM2ZuVGt3T0pTd2pPNUY0L1ZYeVdweE9hZW9XMzQvYzJJQW5n?=
 =?utf-8?B?ZDBWZy9QVDhWR3gvMjVDeUo2TWJ1eWNzVm5xNmhQVmF2WVNUbk5Ua3YyYjBC?=
 =?utf-8?B?cDhpTE9BamNUVTY0L3VvS1QyNFduQllxT2NpRWxLK0FFQlJ6NkU4RHRwRjVN?=
 =?utf-8?B?QWwxQmFzQjN3OXdNWWM4dGNBNEVVc0Ztb2N1Rk0wSllPMWdCRm0va0U4TW8v?=
 =?utf-8?B?NkhtaWZuck01M3VaUWxsWFl3Smx3R3hiYk1XNS9LTnFSSEsvUUh5NEFUQUpt?=
 =?utf-8?B?Y3gvUnJpZnoxVmZlaGp3ZkFWWk0xMHppdnluVG95bmczbEVtZFVlbkhROU85?=
 =?utf-8?B?eFNZSlVJOE55ZG5wMzNhTVM2RlFFVmhJUmhlOWIrcHpwZzA4MzJyV1B1eDFm?=
 =?utf-8?B?eVNFZWxuVks4UHlVMSsyaWc0Q2VuY1pXRFc4YktodUttUkhWaWFjNkNRTXps?=
 =?utf-8?B?QmdkakxEdUtaWlh2MGIwUGNoM1hsSFM2ZVJJS0JPanVYWGxtVUFHbU1Fb1hw?=
 =?utf-8?B?eUFQU2pGNnBvQmVNdVo3VkpNS29nTmRlMlZWYW10NkFmYk1VdjlBOXRXSWxQ?=
 =?utf-8?B?NFNLalRZU3RXUEpZNStOZkdJZzNKNGt5bGZRbE9sNEdCQURTTWh6SkUxK0Fu?=
 =?utf-8?B?RUFZSFlIZDhhSk04dHNGZzJQbW5xNXVNcDBDQWhyZU4vUjNnOVcrWWR5ekVj?=
 =?utf-8?B?WmxpY1diYlNnOUFURW9aT2hDQ2xIS2xtQ3N4YUhpZ2RlZWVPazhrckdZcVBv?=
 =?utf-8?B?NEwrc2g5RC9Fakt3L21YcTRKWnhObENFM1RDc0FvN0w3Sk9qd3BZSHFaQkdZ?=
 =?utf-8?Q?qj/fqty2exE6ZpWh8iMeENaen?=
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
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1801MB1918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5f4e40-f9fd-4d73-2e54-08dc41895dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 05:09:01.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bJiKCUxgUurtEVuBi+RwyInEXcC8Z6TIBYi0kFdj42wQ9vlSGbcerEH9e8DS1RIkN3vY5J14vzyfXESRUdb0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3844
X-Proofpoint-ORIG-GUID: tjwmDar5PYqLV4hBZ1RChyF_qZ4pUv00
X-Proofpoint-GUID: tjwmDar5PYqLV4hBZ1RChyF_qZ4pUv00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_02,2024-03-06_01,2023-05-22_02

PiBGcm9tOiBKYXNvbiBYaW5nIDxrZXJuZWxqYXNvbnhpbmdAZ21haWwuY29tPg0KPiBTZW50OiBN
b25kYXksIE1hcmNoIDExLCAyMDI0IDEwOjMwIEFNDQo+IFRvOiBSYXRoZWVzaCBLYW5ub3RoIDxy
a2Fubm90aEBtYXJ2ZWxsLmNvbT4NCj4gQ2M6IGVkdW1hemV0QGdvb2dsZS5jb207IG1oaXJhbWF0
QGtlcm5lbC5vcmc7DQo+IG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbTsgcm9zdGVkdEBn
b29kbWlzLm9yZzsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHRyYWNlLWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEphc29uIFhpbmcgPGtlcm5lbHhpbmdAdGVuY2VudC5jb20+
DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBuZXQtbmV4dCAyLzJdIHRyYWNlOiB0
Y3A6IGZ1bGx5IHN1cHBvcnQNCj4gdHJhY2VfdGNwX3NlbmRfcmVzZXQNCj4gDQo+ID4gPiArICAg
ICApLA0KPiA+ID4gKw0KPiA+ID4gKyAgICAgVFBfcHJpbnRrKCJza2JhZGRyPSVwIHNrYWRkcj0l
cCBzcmM9JXBJU3BjIGRlc3Q9JXBJU3BjDQo+ID4gPiArIHN0YXRlPSVzIiwNCj4gPiBDb3VsZCB5
b3UgY29uc2lkZXIgdXNpbmcgJXB4ID8gaXMgaXQgcGVybWl0dGVkID8gaXQgd2lsbCBiZSBlYXN5
IHRvIHRyYWNrIHNrYi4NCj4gDQo+IEkgcHJlZmVyIG5vdCB0byB1c2UgJXB4IGJlY2F1c2Ugd2Ug
Y2Fubm90IG1ha2UgdXNlIG9mIHRoZSByZWFsIGFkZHJlc3Mgb2YNCj4gc2tiLiBCZXNpZGVzLCB1
c2luZyAlcHggd291bGQgbGVhayBrZXJuZWwgYWRkcmVzc2VzLg0KPiANCj4gSGVyZSBpcyB0aGUg
RG9jdW1lbnRhdGlvbiAoc2VlIERvY3VtZW50YXRpb24vY29yZS1hcGkvcHJpbnRrLWZvcm1hdHMu
cnN0KToNCj4gIlBvaW50ZXJzIHByaW50ZWQgd2l0aG91dCBhIHNwZWNpZmllciBleHRlbnNpb24g
KGkuZSB1bmFkb3JuZWQgJXApIGFyZQ0KPiBoYXNoZWQgdG8gZ2l2ZSBhIHVuaXF1ZSBpZGVudGlm
aWVyIHdpdGhvdXQgbGVha2luZyBrZXJuZWwgYWRkcmVzc2VzIHRvIHVzZXINCj4gc3BhY2UuIg0K
PiANCj4gUGVyaGFwcywgdGhhdCdzIHRoZSByZWFzb24gd2h5IGFsbCB0aGUgdHJhY2Vwb2ludHMg
ZGlkbid0IHByaW50IGluICVweCBmb3JtYXQ6KQ0KPiANCkFDSywgSSB1bmRlcnN0YW5kIHRoYXQu
ICBJbiBvZmZsb2FkIGNhc2VzLCBvciBpbiBtb3N0bHkgaW4gSU9WQSBzcGFjZSwgd2Ugb2Z0ZW4g
ZW5kIHVwIGNoYW5naW5nIHRoaXMgbG9jYWxseSB0byAlcHggdG8gZGVidWcgYW5kIHRyYWNrIHNr
Yi4gDQpUaGF0IGlzIHdoeSBJIGFza2VkIHRoZSBxdWVzdGlvbi4gDQogDQo+IFRoYW5rcywNCj4g
SmFzb24NCj4gDQo+ID4NCj4gPiA+ICsgICAgICAgICAgICAgICBfX2VudHJ5LT5za2JhZGRyLCBf
X2VudHJ5LT5za2FkZHIsDQo+ID4gPiArICAgICAgICAgICAgICAgX19lbnRyeS0+c2FkZHIsIF9f
ZW50cnktPmRhZGRyLA0KPiA+ID4gKyAgICAgICAgICAgICAgIF9fZW50cnktPnN0YXRlID8gc2hv
d190Y3Bfc3RhdGVfbmFtZShfX2VudHJ5LT5zdGF0ZSkNCj4gPiA+ICsgOiAiVU5LTk9XTiIpDQo+
ID4gPiAgKTsNCj4gPiA+DQo+ID4gPiAgLyoNCj4gPiA+IGRpZmYgLS1naXQgYS9uZXQvaXB2NC90
Y3BfaXB2NC5jIGIvbmV0L2lwdjQvdGNwX2lwdjQuYyBpbmRleA0KPiA+ID4gYTIyZWU1ODM4NzUx
Li5kNWM0YTk2OWMwNjYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9uZXQvaXB2NC90Y3BfaXB2NC5jDQo+
ID4gPiArKysgYi9uZXQvaXB2NC90Y3BfaXB2NC5jDQo+ID4gPiBAQCAtODY4LDEwICs4NjgsMTAg
QEAgc3RhdGljIHZvaWQgdGNwX3Y0X3NlbmRfcmVzZXQoY29uc3Qgc3RydWN0IHNvY2sNCj4gKnNr
LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+ID4gICAgICAgICovDQo+ID4gPiAgICAgICBpZiAo
c2spIHsNCj4gPiA+ICAgICAgICAgICAgICAgYXJnLmJvdW5kX2Rldl9pZiA9IHNrLT5za19ib3Vu
ZF9kZXZfaWY7DQo+ID4gPiAtICAgICAgICAgICAgIGlmIChza19mdWxsc29jayhzaykpDQo+ID4g
PiAtICAgICAgICAgICAgICAgICAgICAgdHJhY2VfdGNwX3NlbmRfcmVzZXQoc2ssIHNrYik7DQo+
ID4gPiAgICAgICB9DQo+ID4gPg0KPiA+ID4gKyAgICAgdHJhY2VfdGNwX3NlbmRfcmVzZXQoc2ss
IHNrYik7DQo+ID4gPiArDQo+ID4gPiAgICAgICBCVUlMRF9CVUdfT04ob2Zmc2V0b2Yoc3RydWN0
IHNvY2ssIHNrX2JvdW5kX2Rldl9pZikgIT0NCj4gPiA+ICAgICAgICAgICAgICAgICAgICBvZmZz
ZXRvZihzdHJ1Y3QgaW5ldF90aW1ld2FpdF9zb2NrLA0KPiA+ID4gdHdfYm91bmRfZGV2X2lmKSk7
DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9pcHY2L3RjcF9pcHY2LmMgYi9uZXQvaXB2
Ni90Y3BfaXB2Ni5jIGluZGV4DQo+ID4gPiAzZjRjYmE0OWU5ZWUuLjhlOWM1OWI2YzAwYyAxMDA2
NDQNCj4gPiA+IC0tLSBhL25ldC9pcHY2L3RjcF9pcHY2LmMNCj4gPiA+ICsrKyBiL25ldC9pcHY2
L3RjcF9pcHY2LmMNCj4gPiA+IEBAIC0xMTEzLDcgKzExMTMsNiBAQCBzdGF0aWMgdm9pZCB0Y3Bf
djZfc2VuZF9yZXNldChjb25zdCBzdHJ1Y3Qgc29jaw0KPiAqc2ssIHN0cnVjdCBza19idWZmICpz
a2IpDQo+ID4gPiAgICAgICBpZiAoc2spIHsNCj4gPiA+ICAgICAgICAgICAgICAgb2lmID0gc2st
PnNrX2JvdW5kX2Rldl9pZjsNCj4gPiA+ICAgICAgICAgICAgICAgaWYgKHNrX2Z1bGxzb2NrKHNr
KSkgew0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgIHRyYWNlX3RjcF9zZW5kX3Jlc2V0KHNr
LCBza2IpOw0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIGlmIChpbmV0Nl90ZXN0X2JpdChS
RVBGTE9XLCBzaykpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsYWJlbCA9
IGlwNl9mbG93bGFiZWwoaXB2NmgpOw0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHByaW9y
aXR5ID0gUkVBRF9PTkNFKHNrLT5za19wcmlvcml0eSk7IEBADQo+ID4gPiAtMTEyOSw2ICsxMTI4
LDggQEAgc3RhdGljIHZvaWQgdGNwX3Y2X3NlbmRfcmVzZXQoY29uc3Qgc3RydWN0IHNvY2sgKnNr
LA0KPiBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIGxh
YmVsID0gaXA2X2Zsb3dsYWJlbChpcHY2aCk7DQo+ID4gPiAgICAgICB9DQo+ID4gPg0KPiA+ID4g
KyAgICAgdHJhY2VfdGNwX3NlbmRfcmVzZXQoc2ssIHNrYik7DQo+ID4gPiArDQo+ID4gPiAgICAg
ICB0Y3BfdjZfc2VuZF9yZXNwb25zZShzaywgc2tiLCBzZXEsIGFja19zZXEsIDAsIDAsIDAsIG9p
ZiwgMSwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlwdjZfZ2V0X2RzZmllbGQo
aXB2NmgpLCBsYWJlbCwgcHJpb3JpdHksIHR4aGFzaCwNCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZrZXkpOw0KPiA+ID4gLS0NCj4gPiA+IDIuMzcuMw0KPiA+ID4NCg==

