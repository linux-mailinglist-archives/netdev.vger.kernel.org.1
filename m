Return-Path: <netdev+bounces-268610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MC8G/JbuWnYAgIAu9opvQ
	(envelope-from <netdev+bounces-268610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:49:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E84A52AB3B5
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3839D307651A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3476313551;
	Tue, 17 Mar 2026 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="FbY8DUkv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC72D877C;
	Tue, 17 Mar 2026 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773755286; cv=fail; b=ea09qLnZbZVTQWD2rhVTR0z3tqJbeec4FkVwU2wG8Rdq+9nlD5fLC9rKYpeqcEFENPUcrDdU3lTLMPaagnyTjmZFjxvgojXwX+1zN/4IW6Wn364bRxli1eTdCIicByUtz1jJygEGaVxK0XF5NoEiU9hQ9v32ZlTRa7uAQ7TWjw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773755286; c=relaxed/simple;
	bh=+KmPEIzjtXMzFsOcXc8neOM2nwYFf8xUi5jyXEKqj9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iB7H5TK4HUa7SrYT13elZk9D8QXWeYRbNtajyk7n9fmWMLB/iJ0wddgLM+PYlaBhPLQa2rIB2ZV7meIHm768zCob0AqR+UiZXwm2wZj1qYr6RTN7oDUDisdqiSM1/rBHljBQhMKktixodbm+yrOqKoRzj5IP5dLTCf2sPg1/yKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=FbY8DUkv; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HBrhpv3743301;
	Tue, 17 Mar 2026 13:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=rpJjjYgWBkUOHjJHvsKb43
	t0NAYUiZpb+IUYFheJSNM=; b=FbY8DUkvoW3JxMqBUNF63UiGplfHvZ8nOu8aXr
	BRrx1LpUiJSlAmnE6pxm+/YayRNLxPfkYVHAkJUYd4A7J1mZCf3UDKbF9RwiYm8A
	eIVrCuX6iwH6GEPzUspq64Z/EX48Se9ANIE66qca48aRNRel84HFaFp60RE4722C
	FXBWS/kFeCyKouNCwOz0otzFaqoUPOQPcV8zfvevVZfMBa3qbUPLBPxiHW5/cgXf
	0ekKwK2Ep+hT2hcd2b9aZ9p0XJLi7kNFmCfa23LskMomJrSOosNRgfW1Qu/Tug7m
	fFGX9RKEeQFU22p0SjncSqKE8vTLABQvmPFe4L0TEUYblXyA==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4cw06wsc43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 13:47:33 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62HDY6SA009111;
	Tue, 17 Mar 2026 09:47:32 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.21])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTPS id 4cw30x3cgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 09:47:32 -0400 (EDT)
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 17 Mar 2026 09:47:31 -0400
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 17 Mar 2026 09:47:31 -0400
Received: from BL0PR07CU001.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 17 Mar 2026 09:47:31 -0400
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by BY5PR17MB3745.namprd17.prod.outlook.com (2603:10b6:a03:233::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 13:47:28 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55%6]) with mapi id 15.20.9700.013; Tue, 17 Mar 2026
 13:47:28 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Tottenham, Max"
	<mtottenh@akamai.com>,
        "Glasgall, Anna" <aglasgal@akamai.com>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] bpf: add helper masks for ADJ_ROOM decap flags
Thread-Topic: [PATCH v1 3/5] bpf: add helper masks for ADJ_ROOM decap flags
Thread-Index: AQHctge3tmNfE6fQrU2N8OsijYPkqLWyt5MAgAAFgIA=
Date: Tue, 17 Mar 2026 13:47:28 +0000
Message-ID: <39BDB245-4486-4487-9985-0D4FDBCB382B@akamai.com>
References: <20260317121429.2399539-1-nhudson@akamai.com>
 <20260317121429.2399539-4-nhudson@akamai.com>
 <willemdebruijn.kernel.3102df56d5f64@gmail.com>
In-Reply-To: <willemdebruijn.kernel.3102df56d5f64@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|BY5PR17MB3745:EE_
x-ms-office365-filtering-correlation-id: e4ad3ec1-a57d-4bd5-ce49-08de842bbaa6
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|6049299003|376014|10070799003|1800799024|56012099003|22082099003|18002099003|38070700021|4053099003;
x-microsoft-antispam-message-info: zGT+bdh6kApNlQV//XB+RzECQH+0YOToDa9jhvY+dqiDvtI3mKzzlX7KOs6gp/bfipjmv21wkh/Nc1qZK+5XapP6Gjv+3mLRDJhNJtYgyhAdK9ST2Re83vaUx5WQc1al01eZKMrJ+r+2FfVnvUZM6X1lbIsWYj/6xMq3rNDjv23PTfLtAwCDrKr/ldXvYERz36a1kPwHj8TxksHte7H3cFE4tT4YAsd7fEYQTXTO0+/f3+wSXzF3joeUZSyxfG2egLnnYWxWIwcPmYdftZeYoURq1XwbNSmEA3Knc4TGtn3yIbupyIpxneS/+w7G2P+hPxH4Z39Ne99L9lkjEKIvwF16MxX2Jv+oS+9+Hop0SPwE+x7Z947ysMwxgcfVZD4cH5RiwfENiRcW9vUj71o1we4zKm4czovR6AHsgbw7JVhLJTL6hroVbv9LU7Kf2l7HRpOIi5/YWtCTR5/dJh5tYPqGmfaqoMF1s25sxMFJJT4JVcbI7xZZL77zT1VC2iE4BGgx024bW9ylckObLpgwzeO13KXBIOTb5KP/r2js+urb3ojYwduGsNJ0VTNFSNzOyQwJaFO8Hh1wLHY9aXHcOK5aRBGB80fdwD6pLmSg7aQ34oEC62Gk61LNAAPQwLR+UgDf9nDZxwu+xC8puffqd/qr+YtbU8yvWwn5leAuIYXo+TKWZaHEJgyphB/WchXSr9vWZNkCN75j+iJVKJeWkAOe125RQQMdxtVA+EMUCJd1yAwg7+/kmN0hGTXvW2DML2NsWgxSkngyciJflx4kIE9aSdzk/FHYwG7KzCDtGSo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(6049299003)(376014)(10070799003)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmpsanJTTmZvcXJCa1dRWE1oNXNUWFFUVHIrU1BWSEV0NW1iMEhtOTdwTU9C?=
 =?utf-8?B?YXY2NU04L2x5ZkVpckIyOGF3ckVvNENrWGZ6aHlEKzc5a0QwSzFkVmZVMDBF?=
 =?utf-8?B?bGhFRGJOR2dieUlMUUk5SVNpN0JwQWEwTUxhL3VSdmozS3ZGTENMaDV3Umh0?=
 =?utf-8?B?alg2U3FWa2kwUnhPVWZLdFJPUzhzb2g4YXpaZUlmZlpoTVpoWjgxQy9yWWZp?=
 =?utf-8?B?N3RaR252a2g5dDFHZXNBTVVDMWk3MERQbkczVHRSNDlkY3E1RXlhd0RQb0U1?=
 =?utf-8?B?NHd1bktod2M0cGNRVnVHTG9jOFloU2lwMDF6VXQ2YkhISWMxdjBLc2JpY0Qy?=
 =?utf-8?B?NlR1OVlBSUpMd2xSQlYwTVVJRlZyRXRhZGhoQ0h0WGpoL2U1N2dtcm80MWQ2?=
 =?utf-8?B?ZFFkWmlHQk9vSHU3eC9UbmlLNytDZUxZSXdzODdZR1VySmU3NjJSQ3VwYWt1?=
 =?utf-8?B?ZW1UWTNHRmZ1aW51a3Q2WTMxdzNWQWFxS3VpanBCSmtsb2NRdWdPTDViblVa?=
 =?utf-8?B?WWQrSVRVRXNVeUh0VzVGdVZENU40RjUrR2NhdE1MK3BqK3lTNUFQYTNjSnZO?=
 =?utf-8?B?QmJwbXVFZHl2UHR0azBFVEVRVnZaenpWcWxHbXVCRkNTMEdmVTdjMGFIdUdQ?=
 =?utf-8?B?M0lVZ1d0V0FYL0FpVWVFVDJ3d0wySDZqSC8rMnpRR3ZsTUlsdGtUbWY1RWk3?=
 =?utf-8?B?QVJsMnBLdkdzclpuQ05BVzcvU3hIY0lWaHlKczVNN1A3S3RXa3oyMHhjWjRL?=
 =?utf-8?B?L0tpcFVoTjJHclNRSm1zbno2RkhWOXpiWlRjQXZwSFhIbjNOSEJxdEQ4ekhF?=
 =?utf-8?B?SmFvTm0wNHF5OU1QZER3bHhYL05kc2ppTlROU01kUzdOWGIxZzlkSDRieFZn?=
 =?utf-8?B?VVJmQXNhVFJXZmxzTHNoM3JaRFhTSlQ1SHo2NTNoS1RzTDVWbExMUVoxdFFy?=
 =?utf-8?B?S2wrbG45WUJ6L1J4eXQyeFQwTDJLc1FvRVh5VWxwWTNtK25XYnBENlZ5VXlS?=
 =?utf-8?B?eXl3Ymx2VzZzOVkrV1lFMXpjd0dvN1ZQRmxjV0pycDFreGlLbUVwMmFMdU02?=
 =?utf-8?B?RzJWNTcvREVMZUhrdmM4VGx0ZWwrcHlhRWVvRjdVbnhZZ2VhVDJuQVp3ZVNM?=
 =?utf-8?B?UUJzTDNCQzdhKzhxT0xnZGYvZVptUVBtTStHTGthamU1aEo2dE96T2dsUG11?=
 =?utf-8?B?YS9CM1BZanZhYitPZktyWC9VR1gyem91SjdTMWVJS3pmTklzY0lJTWZTNWxM?=
 =?utf-8?B?MGFSOG1xL0swUFU0UHdjbVRyVHZaZndhUkZOZDJZZHBWQUQrOTRmN1pQOFBW?=
 =?utf-8?B?QjUyNVlKdERIRHZRWFpUTUlFK2NEWHpYam9EZk14aWl2dkVkNnVKQU1yM3BN?=
 =?utf-8?B?N09nM0NFMnd5cXgwM1IvSWdmbDEwOHJVMkwrTkRBd0c4RjZYSzFDWWdlMWh4?=
 =?utf-8?B?a3hFWW5UbWN0ektzUkp1UGZDaW5wUHQwZTdzY3JvZmFyaG9iZCtFVnVlK1gv?=
 =?utf-8?B?cUdKS0toRjFYKzN1VUNkVnVxcS95Ry9JYUMxRWpxV3l0OXpaK0ZadU9zdE1x?=
 =?utf-8?B?eUovMmoxcmt1WDNEcFcyUU84TlNhQnBNM3ZoUURiWEZRcEJnU1NaRzV5VzV4?=
 =?utf-8?B?U1FsSGdMR2ZXNER1ZXh1bC90b3djYVZUWHo0blBrelRUaXl5T1V2cXc0emhw?=
 =?utf-8?B?QjA1VDNsNVVDSS81aEZWTWZ3Y3RLSXJjWVpjY0xmSy9LcEc5cFg1eHh5Sm9Y?=
 =?utf-8?B?NHFOOWtjVkc4VFU5WUt0ai84TWhiS0pYaWZleGhXYkp5YmdCZUVZZ3h1bitX?=
 =?utf-8?B?Ym14MW5kRUhMcFRFYng2Wk9oRFdLYWE1dkg4dW4vWE5lZWR2RnMrSXU3R21y?=
 =?utf-8?B?NkZicVNJWlRFR1Mxa1NtK1BKSEsrKzMwVXEwMzJhQTVGSnB0bVdJVDNQRlZ1?=
 =?utf-8?B?enpBRVdPY2RFQ2h1cTNKajBkR3B4aGpVbFlCSm9NNGJZcm5BakNkbi9ZL2N1?=
 =?utf-8?B?V29VOEIyZkRsU2lIMkR1NUdTMzg1TnRwMHQ0YUhRVmp5eG5OVWtpNFpvUHRX?=
 =?utf-8?B?MlgwMWNyNHlpSmltL281bERCZ0o0SkdKQlFjVWphc0l6eHFMVm1sNTVubGRI?=
 =?utf-8?B?U2VMV2Z5NUZFUllYQW0zZnZUMjczVkZzVGV5Zms2WmMzVlMvTm1CUENKUEdE?=
 =?utf-8?B?N0VxOHpiUFRCWEVlVzlrNk1GUlZhU1UyWHVJTFcycDI5MjdEczNaSGJFMGJ5?=
 =?utf-8?B?OWxZTnNNcEtBYTFnSy9lMnAwY0pjNFJwczYzcm5qT0htTUVvY3lEUVhaNnQ1?=
 =?utf-8?B?am4yUnRSRjlrUkJHSXFGeXRuQ3hhTTFOZmpUUktpYms4WWVTdko0REtIQ1h4?=
 =?utf-8?Q?t68391UjEfyJtmCn42Ht2qjnZkszC5lF+bmYck/xY+B2j?=
x-ms-exchange-antispam-messagedata-1: TgNJkX7eqOhTTw==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOYnewRt2CnRGIIBv2lM29lfCld7Ay9FR9WQcQj0OTQE5lQfn3aXTeWG59PqgsfoA7yQ9QOhoaAR322FoLAJmv7APb/oj1+LTfdVzer+F9ArH9P3TYS2EcW/HxAFHJ6p7OVmim4VysSAc74D3S/Of2u9KBrSNeL+uY4ok99LRvoFh0GyTyiZ5+hj11ZYMwCyOmTzxCZGQ/71z7iuxbbqYXLNo9myXJzRm9YLIj6xT7QFGWQQmDveYHQNdhvomk/mzq+qSf+Nm4FGb4HX7/G6H00TNCafqv8cM9IqZt4Qg5mI1moD9LqDq8oEO/IOtTb4L63zqFTHpjnS9OLIp1vAwQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0Ned+zAs/2ZRGU3POX0FPRsvENYSDuyRCb8LwB8byY=;
 b=ed8533VBCMLV70JZ6LlYkMD656GM7Js+UazIt+EdkHxcjHFIePzAqzzhD7c1DQ5VnGd3t3eE/MTD0Xx/gbXHBJHHPbPMihiZQIogVO9YgXqfKP2NODqC8mfuexFmgvjW83pkc/dR0rL5kGmbNWOUUA7P4JswU53rjJV8mhGZXagA1IkD9XYQKE9QNQvwCeAORawLSJjO6C5RkGjy6rDSW/PlOuQdvsgUlz7wSvIdas/e9poWXioVzzPSaIOPoFaYJeMsBVpc87fpHheOlDbvkBnWn0LwWcuziF+b8iOg9JIMGZ9fBT42mxIh0uiV/YTAQKHYRJfuuljfASAKsIY/yQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: myvuzG47ZGwAST2wGAtKCGnWa5vjzoOSNfZEZczNLOXifnOvSYqxEwdbaw56Xo54yOen9xseEGmI0vjqwVjPX7SuMHjhCB1DGV+S50Oi5e+yY4iKK8MDasbhEhlvK2kl1jtWrCzfWgX+HRP1qK/9VOHxnahvuBaZw+No3MkRrFjgJtLUV8qIEl8fpAC2nairH1u8czdEO1zr3Uvf5jtOaJIctLoH/NPy1Bmi8FOB/ASSi+DwvyD4l4FoGP9pgOnuY08tnMjm5ruCTA+YaJBbbWgxDBP9il+EvmgZNyZ4dGUv++ukc1CtQGaRAUG3qpivs4hv595kDMjV/PGMSlbGZA==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: e4ad3ec1-a57d-4bd5-ce49-08de842bbaa6
x-ms-exchange-crosstenant-originalarrivaltime: 17 Mar 2026 13:47:28.2740 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: HusqE5P6EuFLB0/V/YgjClvJrYOJO/O6kDmiAf0QsuOTINcLuwIlvzPzCrhsBgHUSnHHKnG2QbTwDh5anT6Hbw==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR17MB3745
Content-Type: multipart/signed;
	boundary="Apple-Mail=_5E480A4D-D9B9-44B6-BB42-F741293A96D4";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603170120
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyMiBTYWx0ZWRfX7JSb9cjuiiMX
 xOjYHZ0gFEn5pJSBC3l8N15WI5q/qf7bkaN4CcdoqXUqCFUMpbGh6OUSoptO9bM9CcoAnZTWI4i
 jykQccoqm68WUlKXpYYpYqbA+e1h/D+kMU8hjafqdopdmfPuNm24CWp1aKtI5yu+7LikDrtxyqq
 TowCTMGVLJOevM2zIQuX6HPfaKi+MRSgYYNd60lxG4JZhng1L3ZSMen9dd12b2UyCtl9lLqF9um
 V+MT0zSrAHkBd7m8TqYpboNiqtO7SB3CC+xYMUu57sCc7JM+h9GGN9pfj8N0wr9Dh2NXVgwO9KQ
 woNeeWsKpf78TN4z/caGR8NlrOqC9gVnFlQISkYIACVd4+uLLnBj2r57JZjWDTqtG8KwV+ofVm1
 KcLrwJsaRgP2A/EI+Fgd5tCYAMENovNU8/GuPacKOACUwnFZmasNS+tI9jF7jPvr6H1yqtNgvCW
 LtNrUnYP41XfWbe+utQ==
X-Proofpoint-GUID: TA2qZom4FI6y45NgOIqk6S9rvD7GgTXx
X-Proofpoint-ORIG-GUID: TA2qZom4FI6y45NgOIqk6S9rvD7GgTXx
X-Authority-Analysis: v=2.4 cv=c4Gbhx9l c=1 sm=1 tr=0 ts=69b95b76 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=4xFXqd-_BHBjZVyr95gr:22
 a=pGLkceISAAAA:8 a=X7Ea-ya5AAAA:8 a=hzR4zRj0EjpbyL-3-aEA:9 a=QEXdDO2ut3YA:10
 a=wqFnSJPP-FBafd8uH9cA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603170122
X-Spamd-Result: default: False [-0.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268610-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:dkim,akamai.com:email,akamai.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E84A52AB3B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Apple-Mail=_5E480A4D-D9B9-44B6-BB42-F741293A96D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 17 Mar 2026, at 13:27, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> Nick Hudson wrote:
>> Introduce helper masks for bpf_skb_adjust_room() decapsulation flags
>> to simplify validation and keep flag handling readable:
>>=20
>> - BPF_F_ADJ_ROOM_DECAP_L4_MASK
>> - BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK
>> - BPF_F_ADJ_ROOM_ENCAP_MASK
>> - BPF_F_ADJ_ROOM_DECAP_MASK
>>=20
>> Also fold these masks into BPF_F_ADJ_ROOM_MASK and per-path flag
>> validation checks.
>>=20
>> This is a refactoring/plumbing change; functional decapsulation and
>> GSO behavior updates are handled in later patches.
>>=20
>> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
>> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
>> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Nick Hudson <nhudson@akamai.com>
>=20
> Only patches 3 through 5 were sent to the netdev list.

oops.

>=20
> Please resubmit the entire series (after the customary 24 hr min) to
> the full list.

Will do=E2=80=A6 as v2 with patch re-order you mentioned?


--Apple-Mail=_5E480A4D-D9B9-44B6-BB42-F741293A96D4
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCdAw
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJzCCBMyg
AwIBAgITFwALNmsig7+wwzUCkAABAAs2azAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI1MDgyMDEwNDUz
N1oXDTI3MDgyMDEwNDUzN1owUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1lMOTEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAw+xt0nZCcrD8rAKNpeal0GTIwS1cfPfIQXZHKRSOrSlcW9LIeOG4
E9u4ABGfGw+zChN5wtTeySgvvxE1SIwW13aoAscxyAPaS0VuEJGA6lUVsA2o+y/VD7q9pKIZj7X2
OxHykVWBjXBpRcR9XFZ5PV2N60Z2UBlwSdbiVp0KBXzreWMBXnHKkjCSdnbVuvOj3ESrN706h3ff
5Ce7grWg7UWARnS/Jck1QAEDqIHLSxJ3FhgbJZBt6Bqgp28EqkP+dQxzp//vnUDIwxBzpSICAMsk
d9I0nsdVvHV0evJSjqDgLF9gw7/4jjjQGW/ugHBytYSBEjDFuB0HOat0va8SjQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUWgue6rVjEAcBSPcAqJXWGxAZi9gwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
oBkMF25odWRzb25AY29ycC5ha2FtYWkuY29tgRJuaHVkc29uQGFrYW1haS5jb20wHwYDVR0jBBgw
FoAUtjfong1VAIz5spH9WobJYxF5rVwwgYAGA1UdHwR5MHcwdaBzoHGGMWh0dHA6Ly9ha2FtYWlj
cmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRDQSgxKS5jcmyGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3
MDEuY29ycC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybDCByAYIKwYBBQUHAQEEgbsw
gbgwPQYIKwYBBQUHMAKGMWh0dHA6Ly9ha2FtYWljcmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRD
QSgxKS5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3MDEuY29ycC5ha2FtYWku
Y29tL0FrYW1haUNsaWVudENBKDEpLmNydDAtBggrBgEFBQcwAYYhaHR0cDovL2FrYW1haW9jc3Au
YWthbWFpLmNvbS9vY3NwMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCILO5TqHuNQtgYWLB6Lj
IYbSD4FJhaXDEJrVfwIBZAIBUzA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZI
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0kAMEYCIQDg4lvtCdYN
NSoA7BrmrnhzqPrsFhQejDMGHCeY7ECV5AIhAOV93F+CcxakPdapxskTdtiTYz7dbj7AVto5kQkB
66NEMYIB6TCCAeUCAQEwUzA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9naWVzIEluYy4xFzAV
BgNVBAMTDkFrYW1haUNsaWVudENBAhMXAAs2ayKDv7DDNQKQAAEACzZrMA0GCWCGSAFlAwQCAQUA
oGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwMzE3MTM0NzE3
WjAvBgkqhkiG9w0BCQQxIgQgnbjGAVeV01l9w4O1A/HUUv/NQjbSNvWFPC1xsKjRfkkwDQYJKoZI
hvcNAQELBQAEggEAJFQuhD2CLMmX1qa4DoG3vt511E1+USCQFtM/wNVdf3ogTuAz3avC2g0amTll
2leeQl55ftO7K/edCyI1wwdZJ7jVtrRFwjqp/p6agwPqnir5Qd6COEnQH3lyY33MdnGFa9hy+xCv
AVUgyN1YDJZIYombI8UaKGUF3dyawWpNsNjRsRyIzWaEEArJVE+nMj9Vfp6MmexBhndbOcYf9yYV
8PpIAIwZKJ2mSboDWefMnPBmP4i/XYwbgrQlU9HFvK6bfHjYZTohmsaDXM2FpQn3bxd2SIYZDnvR
Chtk0q9GwWKklOxnqwlQUnHsjt8uwy7MiBk3MzHsTd1+Ifh6HsgMuQAAAAAAAA==

--Apple-Mail=_5E480A4D-D9B9-44B6-BB42-F741293A96D4--

