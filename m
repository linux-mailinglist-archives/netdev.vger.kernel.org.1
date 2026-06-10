Return-Path: <netdev+bounces-297633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6bfNK5JFKWqjTQMAu9opvQ
	(envelope-from <netdev+bounces-297633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:08:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A3F668975
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:08:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=selector1 header.b=HWWlBIjL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297633-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297633-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C131331B32CB
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450093F7AAC;
	Wed, 10 Jun 2026 11:02:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1C3EA97E;
	Wed, 10 Jun 2026 11:02:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089343; cv=fail; b=U62iu1qE/lQot8EuOvhNp9HmM53Fs291RGeTJG5FhbV8ncWaELINtaaqwI8flZzNWNOMfRxcm5V7NT+vvr1eoqo0H4FAUX0NI0xdubqeD3V+DblZv8P2yE27EnFSfB5zFtVMtOyi/qJjNOmZJZq76pbZ5qwWa/TwrTH3hp39e30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089343; c=relaxed/simple;
	bh=x+MHwisDZgE6ttiVf70AedySvgWeEphoqC6zI3gEtrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gtVXpS3RLKMP5OZiPFaUwfUDhlGv2Awv1xtWtr7kbFnvgIjNqwMYJz2sul7EoW20J6gWxn45S/49EGe48Pe6tMqUzBXagmcC8uQCSkfKJCjOVU3XuPyylUPHWwDi9Rlj8kPQQfB5X1mD1pzvyMmKIqkKoxtMMkZTgE3mUdKHMRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=HWWlBIjL; arc=fail smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7kDRK3125410;
	Wed, 10 Jun 2026 04:02:04 -0700
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020109.outbound.protection.outlook.com [52.101.46.109])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epex1n39q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 04:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nT5CfM35M8CODQ9c+df7jp0uONZBkyUbaPsXpTYONJ8bajXxOaw5/D2sEHIFAEysCWd9UfyYSpLy08+VtsiloTsIQvKAVabNiYWSUmijwtMRdNwSinSoh51zjSR1rHkesmyfvwJnSzsDld8v8DShDX9KxeZMOvw7Wf/iLwiwox43zxLzO9qSl65hZveMQZgOwkPr2rjCaG1ZgJI9sfTfK3+AT6yHccWsLCPK1UpKKDVQSKzmOPGsej9+pqssy+6K4oWxd/ggYQKrmXbDes+aUk6ZroxU64Mk1yMOgqxLMuSAwU3mQeQGXtMwQyEaKL/hJMzHQ73Z4HmV3bDLecPkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfgKYrmt7nSMUoIvlfhY2h+oeSnPucsJ3wCJROADG7s=;
 b=dn3ogfVSTNd+dvP8yEGEBq/UCnBdONJFu+txG1fM/a2dnomo9Ro/B+FXkcx1FRqholGtllAZRPECXkMhJDQHheBTExHf+JQZqF9yA+s4lopvfe0eXsuEiKOHlRI9pB6i76cutEvhNKy6LJfLsXqyqKQSdwaDeUehnP9cvmqTI0g12tsJHQhU/51/YYxrEqVgwkQ8oIY99/49v/+A6wUtPMn3YAmI0t8au7Gq5DKCIq/L83cpsGydmV4IaiDOCoFj6qofzUfaa43FxCkkYod8JuUCUIbK6i3lQ6pAgxZN1icuJlnqAv+TwKZEHv27knHBuIIrhIYZHSvy3jfThz4beQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfgKYrmt7nSMUoIvlfhY2h+oeSnPucsJ3wCJROADG7s=;
 b=HWWlBIjLDAIxLfFXDV1uLMNE6SK5tIf7X45w0bXwVjNYARxSqLsPuI/x4/BhlfQPV7gXYm/xQNiptYM5Itnq+mXChoQ4uuD+Hzd/ZHGmky2tEN5n9qZDXt6RLlpyuBrnHgNthTGwo0uFSmCkFpCMk2hZAjBII8XXgN5w/iXtRf8=
Received: from CO1PR18MB4603.namprd18.prod.outlook.com (2603:10b6:303:e2::19)
 by IA0PPF2F6A693E3.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 11:02:00 +0000
Received: from CO1PR18MB4603.namprd18.prod.outlook.com
 ([fe80::cb22:ffae:1f3a:af35]) by CO1PR18MB4603.namprd18.prod.outlook.com
 ([fe80::cb22:ffae:1f3a:af35%2]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 11:02:00 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v4 11/12] net: atlantic: add
 AQC113 TX timestamp polling and PTP TX classification
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v4 11/12] net: atlantic: add
 AQC113 TX timestamp polling and PTP TX classification
Thread-Index: AQHc8peYaU6EaxVGjkmchutaiO0KGLYvQ6WAgAcFRoA=
Date: Wed, 10 Jun 2026 11:02:00 +0000
Message-ID:
 <CO1PR18MB46034D1845BD0F64579511DABA1A2@CO1PR18MB4603.namprd18.prod.outlook.com>
References: <20260602135452.516-12-sukhdeeps@marvell.com>
 <20260605023839.3629209-1-kuba@kernel.org>
In-Reply-To: <20260605023839.3629209-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4603:EE_|IA0PPF2F6A693E3:EE_
x-ms-office365-filtering-correlation-id: fd6c91c1-d41e-4bc3-16c9-08dec6dfb265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|18002099003|22082099003|6133799003|56012099006|5023799004|11063799006|4143699003;
x-microsoft-antispam-message-info:
 hUBkQakXU8x5RH+7ts/X1N7jtKBrfnf8AZ9Os3OTamsSVwv9fVJCBoXJKODiQcY1mW+WjQJW4saWxal9AXFAyHQVuggkUqFw/I8TeMOF6pwGZC962tdnwSGRiv4I/uWed5ltuoUFynLv9EWAOJoURbpzvZ7P33eDQ90Zbm3GJyviz9VYgiXnP2k4w5FD0F48pRfytQ9aYKuK/xdLqruLMvuOoc40AhVQu6H00YKeIHTzviP1pd2mFVfRVq3QfVTsxKmus83+TGNAi/mpOhi+8jwqG5+XuxdHTyMg0KK2EEWbkIwn/pThlfAVy1lxJDJYqELtj4oF//HappY8uSv1xUGf7EifOpL4xF9f9zuZ11e/6kIzE7vSswzpLsY3VVPNwULQXYBA9gOGMxVwVFQavHpwspVOitLzyGe6HcAHdTBFUCyi32urNwMV1UW6S6UTpNyQcFX31GDUTS4B7EyrNGZB5sUx62ip/xf0C7azMR1RecENXQ7v5T0Wft+8IvEgWoOVaN/MldbWdUx9Lqw9VZr5NagqX8oACpe/fSR69qj855BbzoLHtvLWOpLf+5uzgkWRrNJCQrjzKsPL8n5rn6ifE9N+m6nIF9GETg/4JKkHO2+vZonI2YjXH8JZb5eMu7zxGqmceQ+nCwMUt07UZ+wrsez5OBkaFr7am70uf7COZK5qd1Orv4/xPm98zmuoeS0L3OF+Fw1rgcBw0EPkT9axGaGUJceyBda7pJLb42DBc3QkWm7xt3k1RcQR5y61
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4603.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3A+qWU8n/4kODWxTzwNHtS+Ga9555Oue9n/nzM7tB443avRMr/tbZlbtSe?=
 =?iso-8859-1?Q?oR9yCObIVTZCLVgLi+bTqOn2Af0O/e78Zip7iKNui/MVEYprJfBm165u5H?=
 =?iso-8859-1?Q?zg08Pqj2izX0P0CuV/9qAPDwnrHMlYgKpsCQCDvxrB4kU355MBxz4/Ro7G?=
 =?iso-8859-1?Q?1bfxaQEeG6Ric+eIUo0Ze8xQ8wovT9AfNdKYSLEK0ZGNsb8dwBWJRMf/1K?=
 =?iso-8859-1?Q?kKr5+j7Dt5u6Rxk4U1Y3p2fz2qh1zduifHW4PsvND69QNM1IOmrJyxU7YF?=
 =?iso-8859-1?Q?RkIbmYuUgNbSmsAFMShTmmEUlDMHp+l3VkSaQKBGMPtoCBT3MCql6eUGyY?=
 =?iso-8859-1?Q?3Y1Zhf0eziBoLqcpt4DnTVbMIdchozuOZ5I1d4t6OYFZzJ2p8GkfxBj5dI?=
 =?iso-8859-1?Q?O5nhjcGTBHOoOyJBPTA+wEwYyzZ+5nWMnV6YHTkpN2Ze0lQqtyfTH/VEKQ?=
 =?iso-8859-1?Q?ml/uTYs0sRecvvf/klkamh1+JPh1Imu7bDuFYBNotbp15l0Py+D5sDyYAA?=
 =?iso-8859-1?Q?VLLCunz0GJ50TJOJ4yOSbLKQuK1iqZL3+GlNhq22f8snWhcuTv/wVomOuf?=
 =?iso-8859-1?Q?YjwvRpjcRWjn9fydl4n+wJcEi5pPRuBvgGJxiCLrgySNciVN9LDSmovs0x?=
 =?iso-8859-1?Q?LEgTBSPx0ynNhIHaXBVNLM1l/X9upK6EdhykiSNFPdEkzI+9dNxmN1aLfW?=
 =?iso-8859-1?Q?Vu+2Ci5hcJlFrgh8A+dv8qeYpcyBrFMrFTCJu54yXVWXAl/Febo+CnHRO9?=
 =?iso-8859-1?Q?qCsWDiQQbP4K+Swdbtzr0KgYOcSHohhTKXalTgQFzJiSfCeuUEeQG8OeSQ?=
 =?iso-8859-1?Q?KARfP1GZR373WToD1MpH+rAYvF0zHga3nCvBN4cLr2qF3yjnTB+ISyTeN/?=
 =?iso-8859-1?Q?yvJvk7cLbdg+wy22hjAQnnr7pVfybrfUcAOUg7IrjLm6p8Dxq+nVnaubTD?=
 =?iso-8859-1?Q?3iL5zWI7IECH0OdyRniN4quN649EAqkYBLY+xlRXSZV33RMRfqVdb3RS32?=
 =?iso-8859-1?Q?nM8fz3VvvU17SYXkSd7nN9bqthPhbPA2RAcXI/hHLMlV0yON0zUa6fLSVy?=
 =?iso-8859-1?Q?pNz+pxKCW696z2guiEOxWkwOodpQjq7qxns64CSBGYhbfQgFtTMIUIoN91?=
 =?iso-8859-1?Q?pHgQubRY5pZ6rZeYbKDaJS+NkcH2WiO+1u7++nztiV3/3kokCJF4iXJh1x?=
 =?iso-8859-1?Q?bajJ+piRLXHyRFk8V/Z714bkXtwfs6NSJ3A9iAYnYK6UwZkHcOnMf9z0PA?=
 =?iso-8859-1?Q?HVPnMvMEFpc06FDyAacRpigptug2jdzYuRXbAp5z1Hf7iDieFx9aeb+DXZ?=
 =?iso-8859-1?Q?JKBP4UHujl0gm7riI4c6A8K2lZ7KOebvUgj2/ou6a5GbOBCRZcQ5kxGKuL?=
 =?iso-8859-1?Q?QZ5LPu/xsZHyFkC/zT2U/tCO6niChstNDPO7HZrY1flrcTMJ0rljYTonLh?=
 =?iso-8859-1?Q?2Ch5lDy8gGCrJUfNSz23v3N5m6yUSHoF0CMe2ERH/x2Pr+hQRElRDBUUIs?=
 =?iso-8859-1?Q?0qibQBRyacjzXUdw7q0ajleQxPpGygnC7YuBoIT0jMARpzlqsegzmuBmL1?=
 =?iso-8859-1?Q?rp46UBVmqQEJIRKkkLKItK2bhqBfAOnpznzAYpm7u69M9pcGtRIrVQ5mIE?=
 =?iso-8859-1?Q?jIwUfnThdrQmflkb86KInc2g2UQi1ZHNjEpsvuzaiGy/UhGHKoEowVdglJ?=
 =?iso-8859-1?Q?rVaGg1lPE3x91w/GRTPe6iLLaZcI+j6sVkbRE1Eq4WGJMQf+zFt5dWQs0K?=
 =?iso-8859-1?Q?3dnVOarSeBpjn4xV8r1J6KZxYP9mApfGkKZRP/TWKxBfeZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	b2yLJXQQqjfZj4mtHKwSceYoAmVMgHIVqEuV+HKgn41zHnmvMh8GwYyS4jPpWOVeecODUZopJKio2X8vLaZLHYe8TkDmsv4KegjcgxF5F6JJ8HQFGYGsZKdRfZjRTCr/uT4GThfSKiyvy6oWJKnEg6J2qFSrGD8+SuJ42NXskiTpcewAj1v1dcKdV9o2mzG0YeYSMT4bWwKQ7swtSpYcDQfp9HrhCFB3blfxDFsjAtFEKlreF8qk40datWje0PSaIo92ThCK1YcBYqeh7G1oI7mliSC6mMsMYofhdTA2iAR9CzCVxv4mLZjhyDKzxBucbOLzrU6+lFp7MAhMAZBWQg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4603.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6c91c1-d41e-4bc3-16c9-08dec6dfb265
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 11:02:00.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woEq1mL7PObmSfTk1Elszya83X+vGFKCYJpVQBSCTBWLPQ02sEAOTQs5tJvudnzRbrgiWmTiRepilpjNLTCrRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF2F6A693E3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwNSBTYWx0ZWRfX0A6yclhfj0An
 S3JXhrD3PT2YIR5SB/Dta4miRA5TU/D6dz6H7DuN3ffcoL+LRQ0pUX19mz+fK0H/gTfFrawegX8
 lKci1vkHVH5ldtuqrxfRZ2JfaWF0cY+CGej/IZ+4JcDUzoazANNjcuw1NFomzrbkvEaV5qbaQpf
 XpVN8FI4y3uu2K+1lx/g/jy/Feakiahla/c4NtFYhNlfjKMs8xI+nYyr+kWSPPdl4lMEfqQ/4L2
 Zy/srT1/w+BfPX7Qt6hUrEQhJJ2dPEy0AWxuVqgvrtUDs2nIWH8/LFcevJVflttQpC121L+Enum
 BioFNqnWuWc6HHv3YnM06Ypp8f2YFG25Vg4hg+u+V7fXhzE42enbdZylepvYpsgkYp1IigrdW+G
 94MUpB23bsCx5Linv1I6T6Eh9i0rq6OEsJqKsaPRCgPl4yRM6L/vbfobre2ny+bINwppLJd08f0
 80vCiK5fFsbzcEt8Ipw==
X-Proofpoint-ORIG-GUID: fceeXdeTN1oD7sp47ybRh9QR-Gy-2NUX
X-Authority-Analysis: v=2.4 cv=Aa2B2XXG c=1 sm=1 tr=0 ts=6a29442b cx=c_pps
 a=3q9HTB70WFixjSQkLUrcaQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=xKeIC68JieMOgPxuGyIA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: fceeXdeTN1oD7sp47ybRh9QR-Gy-2NUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297633-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CO1PR18MB4603.namprd18.prod.outlook.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:dkim,marvell.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04A3F668975

On 4 Jun 2026, Jakub Kicinski wrote:

> net: atlantic: add AQC113 TX timestamp polling and PTP TX classification
>
> This patch wires PTP TX timestamp polling into aq_ring_tx_clean(), adds
> IPv6 PTP packet classification in aq_ndev_start_xmit(), and moves the
> RX-flow and VLAN filter reapply calls from aq_ndev_open() into
> aq_nic_start().
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_main.c
> index 4ef4fe64b8ac..1da14786fe5c 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> @@ -68,14 +70,6 @@ int aq_ndev_open(struct net_device *ndev)
>  	if (err < 0)
>  		goto err_exit;
> =20
> -	err =3D aq_reapply_rxnfc_all_rules(aq_nic);
> -	if (err < 0)
> -		goto err_exit;
> -
> -	err =3D aq_filters_vlans_update(aq_nic);
> -	if (err < 0)
> -		goto err_exit;
> -
>  	err =3D aq_nic_start(aq_nic);
>
> [Low]
> The commit message bullet says:
>
>    Remove stale aq_ndev_open() PTP call that was moved to aq_nic_start().
>
> The lines actually removed from aq_ndev_open() are
> aq_reapply_rxnfc_all_rules() and aq_filters_vlans_update(), which are
> RX-flow-classifier and VLAN-filter helpers rather than PTP calls.  Should
> this bullet be reworded to describe the filter helpers that were actually
> moved?
>
> Also, aq_nic_start() is invoked from atl_resume_common() in aq_pci_func.c
> in addition to aq_ndev_open().  Moving these helpers into aq_nic_start()
> means RX-flow and VLAN filters will now be reapplied on every PM resume,
> which is a behavioral change beyond plain deduplication.  Should the
> changelog call this resume-path side effect out explicitly?
>
> [ ... ]

Both points are already addressed in the commit message:

 - The bullet correctly names aq_reapply_rxnfc_all_rules()
   and aq_filters_vlans_update() as the calls removed from
   aq_ndev_open() =E2=80=94 no mention of "PTP call".
 - The PM resume side effect is explicitly documented:
   "which also ensures filters are restored correctly after PM resume".

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index e270327e47fd..dd1af3deb2d1 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -311,6 +311,27 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
>  		if (likely(!buff->is_eop))
>  			goto out;
> =20
> +		if (unlikely(buff->request_ts) &&
> +		    self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts) {
> +			u64 ts =3D self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts(self);
> +
> +			if (!ts) {
> +				if (time_after(jiffies,
> +					       self->ptp_ts_deadline)) {
> +					/* Timeout: free skb, unblock ring */
> +					buff->request_ts =3D 0;
> +					dev_kfree_skb_any(buff->skb);
> +					buff->skb =3D NULL;
> +					goto out;
>
> [Medium]
> Can the timeout branch desynchronize aq_ptp->skb_ring from buff_ring?
>
> aq_ptp_xmit() pushes every PTP TX skb into aq_ptp->skb_ring via
> aq_ptp_skb_put() (which holds its own reference via skb_get()), and
> aq_ptp_tx_hwtstamp() consumes them in strict FIFO order:
>
> aq_ptp.c:aq_ptp_tx_hwtstamp() {
>    struct sk_buff *skb =3D aq_ptp_skb_get(&aq_ptp->skb_ring);
>    ...
>    skb_tstamp_tx(skb, &hwtstamp);
>    dev_kfree_skb_any(skb);
> }
>
> The new timeout branch frees buff->skb and advances sw_head, but does not
> dequeue the matching entry from aq_ptp->skb_ring.  After a timeout, the
> stale skb pointer remains at the head of skb_ring while the buff_ring
> moves on.
>
> When the next PTP TX timestamp arrives, would aq_ptp_tx_hwtstamp() pop
> that stale skb and call skb_tstamp_tx() with the timestamp belonging to
> a later, unrelated packet?  Every subsequent PTP packet would then have
> its TX timestamp misattributed by one slot until aq_ptp_tx_timeout_check(=
)
> calls aq_ptp_skb_ring_clean() to fully drain skb_ring (~10s later).
>
> Should the timeout branch also dequeue and drop the head of skb_ring,
> e.g. via aq_ptp_skb_get() followed by dev_kfree_skb_any() of the returned
> skb, to keep skb_ring and buff_ring in lockstep?
>
> +				} else {
> +					buff->is_mapped =3D 0;
> +					buff->pa =3D 0U;
> +					break;
> +				}
> +			}
> +
> +			aq_ptp_tx_hwtstamp(self->aq_nic, ts);
> +		}
>  		if (buff->skb) {
>  			u64_stats_update_begin(&self->stats.tx.syncp);
>  			++self->stats.tx.packets;
>
> [ ... ]

handled - aq_ptp_tx_skb_drop_head() is introduced in this patch precisely
to address this desynchronization. The timeout branch calls it before advan=
cing
sw_head, which calls aq_ptp_skb_get(&aq_ptp->skb_ring) followed by
dev_kfree_skb_any() on the returned skb, keeping skb_ring and buff_ring in
lockstep.


