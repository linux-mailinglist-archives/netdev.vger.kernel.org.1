Return-Path: <netdev+bounces-124909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B296B5EF
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C641F21011
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBDC146A71;
	Wed,  4 Sep 2024 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="qP8cyEud"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712F198A2F
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440735; cv=fail; b=a+SlFbGRjr5EiZ3VlYYdBY9WYtcXAK1+j2Co2nqqoUeCH/FFjzwQUI9CXckrsBx37Cl3nvaQ38sd776r4hRcCB3ev7HI2cEHH1vK3OIr3Qh180fINqf97R9fFT3doDUIVL+9OHFwu7zxedErUAZUJwBmY4c86g7Ei76GTy+XxC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440735; c=relaxed/simple;
	bh=iU+1eR2w8TdMdejNOW5jpsAtB8uGgdlVl+kFVERyPX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cY41/EYFM8gENqWsGgnQzSxygobC/d+FMsyu+j//TopbVaFzSJn1vUgP7UPqD4K0ibWz2tKOkktR6z+W2tAfkOP5egoair6Rau8AEfrC9ppm+jvcK1rbhFwZQnyWUkhMLe35ig77vzc6yl43M0oZvoJmgq4bQKbAMqN40dsv57k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=qP8cyEud; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48481Dv6016669;
	Wed, 4 Sep 2024 02:05:23 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41e3bsc7nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 02:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDIZ1iNMz7Rmj6dlUXi6BJvoF7ouZfMQqm94fxkncKBmtbCkM8H6Duskfov0I+3dHsUzcsQz0eq+znz8iUyzF/2aeJ+p8QoHmLjoO02rocpvKFYMncH4kVLB+Qo4N10nRvgBGYcJxhwb4xRW+AqKxMzGecDfWao/uVJfVN9Qi4CUtfySjhOoVIyiaomX/3e1utTdkRJlTyM2ssCBBnkhIftQ14HGEgedvUev95c7T0jCxdfKOD9ZrLezppNqxfCTyFdVkwPCeVyCIVRWEruhMl+MP1QCJDk6nezVS0FrLNb3nxV0aw3E0bphrDg0OrEyx/JsnIV0zQgz4tC88sHPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU+1eR2w8TdMdejNOW5jpsAtB8uGgdlVl+kFVERyPX4=;
 b=IQpdjEvR9NpYxKm2qe4DH721dPECqjTI0oPe1P/r/e1gg5f3shjomn1eVvgNVAvuyP8R9RuLxFABbPe71J9KpLGw3SppoF37QRUGyRsYRfycQ3YMXaK51MaU79Z84aPJ74ILUD0XkhUmSRGofCo1zFbNTZUE8rScgMqmDvFvGTk1UkjCZ2wNlALxA25C5T74viEUWFYJ2f3Jctm/q2A0h4arRCn1EqbQhxtbgjFpq9B7FICzcWU0cwNtBhYllN//8SsWs27/PZX/ymKybH2WdcbIH5dYHevy15V85je3el++D37+vLRY7A36580fA8MVSY5UhnPQRY/ip57G0PIZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU+1eR2w8TdMdejNOW5jpsAtB8uGgdlVl+kFVERyPX4=;
 b=qP8cyEudZUYSWFkU2pxBwETPs7CPdL/3OCw1W0cjc8E2nvKBOfHMZs1PzOq4cUJqJptj9rxxn5NMMSFcnt2YwcUmcAhNVA9deCbNmJxIShjAVS8OOqrpSaFX/D9FN1vaupUwbOW1vjMdVhnT0NX96Z/aKwZixLWq+VlgRfXSnWo=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by LV3PR18MB5616.namprd18.prod.outlook.com (2603:10b6:408:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 09:05:19 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%2]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:05:19 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Simon Horman <horms@kernel.org>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>, Jerin Jacob
	<jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers
	<ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt
	<justinstitt@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [EXTERNAL] [PATCH net-next 2/2] octeontx2-pf: Make iplen __be16
 in otx2_sqe_add_ext()
Thread-Topic: [EXTERNAL] [PATCH net-next 2/2] octeontx2-pf: Make iplen __be16
 in otx2_sqe_add_ext()
Thread-Index: AQHa/h4l1jbMi/cb0UyQyWJQhozrRbJHVlPA
Date: Wed, 4 Sep 2024 09:05:18 +0000
Message-ID:
 <CH0PR18MB4339D23B80EE8D24113176D3CD9C2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240903-octeontx2-sparse-v1-0-f190309ecb0a@kernel.org>
 <20240903-octeontx2-sparse-v1-2-f190309ecb0a@kernel.org>
In-Reply-To: <20240903-octeontx2-sparse-v1-2-f190309ecb0a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|LV3PR18MB5616:EE_
x-ms-office365-filtering-correlation-id: 48a9c96d-f08e-4c0f-fdd1-08dcccc0b313
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2tIZ0liOHhuNUxKSC95STlTL2RraGV6M29VdnVVcnRhMEltWElSbVFHcHkv?=
 =?utf-8?B?a0QxRkIwSUoyRHhhZERKb0RYeGROWU01THE4Ynk3S016VVptclBzTm1wVVpW?=
 =?utf-8?B?eUdNTDRKTXlialZldTkvd1pYTW1HRmpJNjZwYjNuUDNvUUg1aWJVNGR0bTNJ?=
 =?utf-8?B?M0JMVURsRGJQQzcwUkN2dFFQT2VVMjJRSVFFWlB4cVJldklOdC9vR0Y4Ris5?=
 =?utf-8?B?SS9hN3NReHhXK29sSVB6YWZZQWpmS2trekwwc2dVckllcjNtYzhVWk0wTEVV?=
 =?utf-8?B?dHh6VXhhc2RoR0pMZXVGQnpHQkFWYmtKb2RkQ1hQYTZJQlJHNFlUL0pkSlAx?=
 =?utf-8?B?OHF2ZWdpeUxmbjVIRHhIQUdWT1VTQWNvaTJ3Tm8veGZOdDA1allpYmZzOHk2?=
 =?utf-8?B?R3MwZ21vc0M3N3d3TXdRM1JyWEZTUGFpc09odUliWHphRjRyTlpya2NYSjZH?=
 =?utf-8?B?bEhqcDg3cEIyVWtuUlVxbXc5cTRkOE5qUGVqVHNoZHpzQmRzWmYzTXhMQkx2?=
 =?utf-8?B?N1dkMXE3bnZIaW5aZkt0R1J4Y05LaUVEcVJGbTlyZmlERzFMODZ2U0lFU3hJ?=
 =?utf-8?B?QVRtNzlIL0Y2SnVybVJBSytVM1FWSDVTb0lsTlRYbi9qWDdBTkJpNkdDTUJ4?=
 =?utf-8?B?QjZLb0ZlaDUyODFLUml1cDN3NjBKN2lOcUw4SEQyWTNzK2dRWTdnUERIVjR2?=
 =?utf-8?B?MW5NaGxNazZGL0syVWlCY2FGeVpWMVlmV01XUnVub0paSG9QNUdsTXRzODBP?=
 =?utf-8?B?YTlsbVlHdmM4c0hpcjhlWkg1TERNcDJ3NHpVOXJjNThNNEl5TU5aTjd6NW1Y?=
 =?utf-8?B?cTBWbUlXVXFMSFBFemw3SENnSEIyTUZFNEZUMkVmaTFZU05GdVBOeEZpKzdk?=
 =?utf-8?B?VmloVUFlV2FSYzF6NlpkY0QrVGtCR2pIYmk2cTNjeWZJZ01HMHcrQnc2KzI2?=
 =?utf-8?B?ZFFob3Z5Q3JWbWdLMW9GTFVleXdxVlVoTFdQUUVGK2FFNStTSUhMTmtUU2NJ?=
 =?utf-8?B?ZzFuYTZSQkwvaXNia0dDQXlWL3hEUlF6dDNUZmJkcm5zdzhBZjY2bldzYThk?=
 =?utf-8?B?WGJzV0RXdGEwM09KSVR0Y1k5eU9GSC9OdzN0WTlLT2hDVktqSG5pUk8zRE1M?=
 =?utf-8?B?TmI0N3FwdmdUR3U5ZHprWDBZUG1wNFpkTEFYRUVlemZLQWlpR2YzL2VydHVT?=
 =?utf-8?B?QjJjVG4zZFpjY1M3cHFQMFpzYmhWQXdadlRwSEM2WUVSc1BZeHEwTkovQzNq?=
 =?utf-8?B?UEFjTzNkSVozcHJNbmdwaHV3NWd6VDBrc2tNbVF1U3MvWGl0anBTYm1iWTV6?=
 =?utf-8?B?TmVRd0VUUjdRR1lScG5EMWJsT3RmeXZjRS9FNGpDdnNrV0VZSkxqZE9qWjdM?=
 =?utf-8?B?c1dYN3hoUS9tV2U5RnBmL0dMOW5nY3FGYWkwa2EzVWo5RVNVMWtCQXdFd2dD?=
 =?utf-8?B?d3RiY0VzdWFYN0dueU0rV016ZlkzRGkyUFQzT0xRczBOcHJNNUhGZ2hUQWZa?=
 =?utf-8?B?eW43YnNIa2lya29ZMVU3RnFOV1Rla1ozTHNBOHQ5c2E5alhaMEF6YStpZGwv?=
 =?utf-8?B?MmpQQU8xT1UzVTl5dkNrWEE3WGRkbWNwVjVmQy96aXkxQ0t6NnBWQU5ybDNh?=
 =?utf-8?B?QWlaSkF1M21PeUdoMWVDMVpDQzlhU0p1Yk45Wm5CZnJFc2hsaFQzTGphTVFV?=
 =?utf-8?B?c1ZQYXlCK1B6S2ZuUTRHR0lvK2VYR1AxaXNEU0JKZy9lcVE3dWU1dWhtUEs0?=
 =?utf-8?B?azZ6anBHcTBGNWd4K2FJdUpKVUFtOWtBYi9ZVHpNc1dKdzNEdDdvdE8rWGJx?=
 =?utf-8?B?UXNkMHh3N3RKWDFxTDRKdzllMnAvd2ExREQvZ2xMQTNoRHVnMGJVR1lZc3gw?=
 =?utf-8?B?ZW93dlN4ZHpxVnVkN1owOEREU1Z6Snl0YVBnRjRjME9kaVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajdYRThtenk1dU5rVWVFSHBZaGJ2ei9VNzRkTDVUOHh2SWtsVm1SR3NMR05S?=
 =?utf-8?B?NG5sLzFKTk5rM1l4NDRvYVN3WGlLSWsrOGtuQVlnbTNHSkpJS0RhRXFRVzBj?=
 =?utf-8?B?M2xuMy9NMEliZWtZUkJ2Z1RqUlhyOFBXZStHcG15YjgzaTBmVDJPeXd6cmlp?=
 =?utf-8?B?UU9wQ0dFMGZZcmd2R0hpOUlnZ0phdnArakRHVVJHaXd0cnhhaXJ2S3YrZWJJ?=
 =?utf-8?B?cnNSSFVtcFZNbnl0ZkRCdTlidGEzZ01NMmFUL3pEektUTnFGcDREMTg3S3FF?=
 =?utf-8?B?VWhCanUxZjdLUlNoSjRmMmhMbXMwQklLSHZPczVlcXBaM25Pc0d3aWdaMUdo?=
 =?utf-8?B?NnI3U1craC82VytYM054aW9XUGRSZ1k5d3YxdjBwa3ZoU2JraU5FZUNVVUtG?=
 =?utf-8?B?MTk2WVNSaE05WU9jOURhbVMwSU81Yzg4eVN2YUR5M25pK2t4S1NoSFlHTXhN?=
 =?utf-8?B?eUVaWVUrSm1pdlhZUXlBeWtPZXVuWUxBdmkzTktURWVRK21hRGhSZEVqSWxB?=
 =?utf-8?B?c0UvN2ZObzN2em9yY0NKQXViKzdzQkVMcy9JK21KRmRwY1J5WTRCRkttOTJC?=
 =?utf-8?B?WnFMNnliRG5uUmhlYTZaKzJKVE9xWnV1WFhaeXVsZGJoNENvQlQxRy9BUDRK?=
 =?utf-8?B?c1V2UlFJeit1K0xxVlY2dXM5QU5vSTRzaXFBQktCZnFxZS9DeU5ZOXJ4WU44?=
 =?utf-8?B?RHg2enJXUjBjaTl4OHVzSExoR240aFBVMXpYdzhuUE81ZkY5NXJ5MWpqUTFo?=
 =?utf-8?B?YU5wek1EbWMrS1ZUNkJOb1ozRndqTlRKWEtISUU3V1R3VjBDSExOWHdmUEtR?=
 =?utf-8?B?ZW11aVp4akZMcVIreThCeUU5NjVtNFl1ZWpKVFFiQ1BsK0NLQlJpM1FLMzVH?=
 =?utf-8?B?WGpmb28zRHBaMlJNWXVTYys1anQyeWYrWGhBRXEySThmeWJYRHFZNWxrOXlT?=
 =?utf-8?B?OW5odXZ1V1JyT0JpSjZiVUd3VnV4dVZIYk9adm5qWWhzVzlPQlJ4eFVtZWR6?=
 =?utf-8?B?MkkvMlM4ZlpBaVV3RktFcjNCYjJWN0FQUFZWYjVFcFhpQWxTZEJ2K2RrWjht?=
 =?utf-8?B?Y1kvdm9vSENKZWx4dFJFdi81TUR3dzJWaGNxODg0VFN0cCt1WnlZNkYra0VJ?=
 =?utf-8?B?MFl0RnlKNmFBRExKTDBETHhibWF6YllJemJLanYyRU1JaTAvWUZDZUZTNnl1?=
 =?utf-8?B?V0wwNStQaTFxdU9LU3BFMWsvWHRZZ0FwbWR2MEtPZENyL0Y2ZlJUNTVSUW9a?=
 =?utf-8?B?Y0tDQUhrUjdYaUtScEIzRllEU2ZYYnlFejRad1BtRWtWZ2xqK2tuazhDVU1z?=
 =?utf-8?B?YWU3TEZrUXVCR1YvcndieFZ0amtFRjRieW5lNkp6Y2xBa3puRFBENi9ZMEds?=
 =?utf-8?B?TEV1ekw4MTZBODl6WXFrbkFQUk5CcllqeUhGNGRkUkR6K1ZzQlpJUlFpUk00?=
 =?utf-8?B?bzE1YjFmS2xjUG5qN0k4djFPRmh0WkMyT2lteGJLb3oxZFBsWGQvLzArZk9R?=
 =?utf-8?B?QUs5ZlpvWWxLOFVtcmNORjhnZDVxdWdoazJqcVR4bE05ZFZ2TjZaMUZ6d2xm?=
 =?utf-8?B?cGxLSnpnNWluU3pxdHFkTnlVSlN6cUNWRlh3ZVV5MnNIQnYxejJKajBHL3RQ?=
 =?utf-8?B?NSttOUhpL0xYT0UrMXFNc3V1MTk2Z1VVZ1dCZStXMmRUbFdOQnR2RTFobWY2?=
 =?utf-8?B?dEI0R3JlU0RqaFNydUZ5alk0UjRqTTZLeFFiSnRNLy9BV0QvU1dzUTlabjR3?=
 =?utf-8?B?eHBNc25URElhajFGTFF2YzZ0NWV5eWxxanRoMjJIU1l6aHVPaWRiN1pBSWxL?=
 =?utf-8?B?NFc1VDk4MGlUWnNINkZpR2libkpGM09qdXB1Y1pvWlBoU3RYMlg2YURBa2Jo?=
 =?utf-8?B?RThpT1BFeEhKVkJ2OGsxYnRKUms3dEh4clhNT0NMWkhxSnNKRlhsM1VVSkJS?=
 =?utf-8?B?NXMzTGhLQUhOYTZwNE8wQWFpeDF4VDN0K2lSbDRCUENoOWJidFpyeXZqanlP?=
 =?utf-8?B?M25ZcmV0Q0hQOWpkQjhNR28yNm5mZEk2RFlPU3RZeVMrSWgreXJCRFpsb0p4?=
 =?utf-8?B?ZGNNU1lITzZFQjNFNEljWFh6dHhycGhTbHVSaVE2NTkrcGxVRDBockVUUWY4?=
 =?utf-8?B?U1p2YmxnUm9ZWHBGeDRXUzZRQXFwSmEvUFFyeXhTMmdSQTZjSTBEZzlJbWlI?=
 =?utf-8?Q?hWk8QltjK7FE2v7TPZIWQbyzKCwaM80pq1WANxkCA886?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a9c96d-f08e-4c0f-fdd1-08dcccc0b313
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 09:05:18.9469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRSG0bVe4nx3gvVOGb6AmXuVEIk8IPwa+ZYRIpNIcJ6T+rkgkxr2y6HDF1MO4bQCM2ifyXpJ2gnRv4j5+cWU8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5616
X-Proofpoint-GUID: psLF4oXgzx4lMfxCUSGBg5rYrX2szc43
X-Proofpoint-ORIG-GUID: psLF4oXgzx4lMfxCUSGBg5rYrX2szc43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_07,2024-09-04_01,2024-09-02_01

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+U2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDMsIDIwMjQgOTo1NyBQTQ0K
PlRvOiBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgTGludSBD
aGVyaWFuDQo+PGxjaGVyaWFuQG1hcnZlbGwuY29tPjsgR2VldGhhc293amFueWEgQWt1bGEgPGdh
a3VsYUBtYXJ2ZWxsLmNvbT47DQo+SmVyaW4gSmFjb2IgPGplcmluakBtYXJ2ZWxsLmNvbT47IEhh
cmlwcmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxsLmNvbT47DQo+U3ViYmFyYXlhIFN1bmRlZXAg
QmhhdHRhIDxzYmhhdHRhQG1hcnZlbGwuY29tPg0KPkNjOiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQNCj48ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEph
a3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPjxwYWJlbmlAcmVk
aGF0LmNvbT47IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz47IE5pY2sNCj5E
ZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+OyBCaWxsIFdlbmRsaW5nDQo+PG1v
cmJvQGdvb2dsZS5jb20+OyBKdXN0aW4gU3RpdHQgPGp1c3RpbnN0aXR0QGdvb2dsZS5jb20+Ow0K
Pm5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxsdm1AbGlzdHMubGludXguZGV2DQo+U3ViamVjdDog
W0VYVEVSTkFMXSBbUEFUQ0ggbmV0LW5leHQgMi8yXSBvY3Rlb250eDItcGY6IE1ha2UgaXBsZW4g
X19iZTE2IGluDQo+b3R4Ml9zcWVfYWRkX2V4dCgpDQo+DQo+SW4gb3R4Ml9zcWVfYWRkX2V4dCgp
IGlwbGVuIGlzIHVzZWQgdG8gaG9sZCBhIDE2LWJpdCBiaWctZW5kaWFuIHZhbHVlLCBidXQgaXQn
cw0KPnR5cGUgaXMgdTE2LCBpbmRpY2F0aW5nIGEgaG9zdCBieXRlIG9yZGVyIGludGVnZXIuDQo+
DQo+QWRkcmVzcyB0aGlzIG1pc21hdGNoIGJ5IGNoYW5naW5nIHRoZSB0eXBlIG9mIGlwbGVuIHRv
IF9fYmUxNi4NCj4NCj5GbGFnZ2VkIGJ5IFNwYXJzZSBhczoNCj4NCj4uLi4vb3R4Ml90eHJ4LmM6
Njk5OjMxOiB3YXJuaW5nOiBpbmNvcnJlY3QgdHlwZSBpbiBhc3NpZ25tZW50IChkaWZmZXJlbnQg
YmFzZQ0KPnR5cGVzKQ0KPi4uLi9vdHgyX3R4cnguYzo2OTk6MzE6ICAgIGV4cGVjdGVkIHVuc2ln
bmVkIHNob3J0IFt1c2VydHlwZV0gaXBsZW4NCj4uLi4vb3R4Ml90eHJ4LmM6Njk5OjMxOiAgICBn
b3QgcmVzdHJpY3RlZCBfX2JlMTYgW3VzZXJ0eXBlXQ0KPi4uLi9vdHgyX3R4cnguYzo3MDE6NTQ6
IHdhcm5pbmc6IGluY29ycmVjdCB0eXBlIGluIGFzc2lnbm1lbnQgKGRpZmZlcmVudCBiYXNlDQo+
dHlwZXMpDQo+Li4uL290eDJfdHhyeC5jOjcwMTo1NDogICAgZXhwZWN0ZWQgcmVzdHJpY3RlZCBf
X2JlMTYgW3VzZXJ0eXBlXSB0b3RfbGVuDQo+Li4uL290eDJfdHhyeC5jOjcwMTo1NDogICAgZ290
IHVuc2lnbmVkIHNob3J0IFt1c2VydHlwZV0gaXBsZW4NCj4uLi4vb3R4Ml90eHJ4LmM6NzA0OjYw
OiB3YXJuaW5nOiBpbmNvcnJlY3QgdHlwZSBpbiBhc3NpZ25tZW50IChkaWZmZXJlbnQgYmFzZQ0K
PnR5cGVzKQ0KPi4uLi9vdHgyX3R4cnguYzo3MDQ6NjA6ICAgIGV4cGVjdGVkIHJlc3RyaWN0ZWQg
X19iZTE2IFt1c2VydHlwZV0gcGF5bG9hZF9sZW4NCj4uLi4vb3R4Ml90eHJ4LmM6NzA0OjYwOiAg
ICBnb3QgdW5zaWduZWQgc2hvcnQgW3VzZXJ0eXBlXSBpcGxlbg0KPg0KPkludHJvZHVjZWQgaW4N
Cj5jb21taXQgZGMxYTliZjJjODE2ICgib2N0ZW9udHgyLXBmOiBBZGQgVURQIHNlZ21lbnRhdGlv
biBvZmZsb2FkDQo+c3VwcG9ydCIpDQo+DQo+Tm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQu
DQo+Q29tcGlsZSB0ZXN0ZWQgb25seS4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBTaW1vbiBIb3JtYW4g
PGhvcm1zQGtlcm5lbC5vcmc+DQo+LS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwv
b2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYyB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYw0KPmIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdHhyeC5jDQo+aW5kZXggM2ViODU5
NDk2NzdhLi45MzNlMThiYTJmYjIgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdHhyeC5jDQo+KysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdHhyeC5jDQo+QEAgLTY4Nyw3ICs2ODcs
NyBAQCBzdGF0aWMgdm9pZCBvdHgyX3NxZV9hZGRfZXh0KHN0cnVjdCBvdHgyX25pYyAqcGZ2ZiwN
Cj5zdHJ1Y3Qgb3R4Ml9zbmRfcXVldWUgKnNxLA0KPiAJCX0gZWxzZSBpZiAoc2tiX3NoaW5mbyhz
a2IpLT5nc29fdHlwZSAmIFNLQl9HU09fVURQX0w0KSB7DQo+IAkJCV9fYmUxNiBsM19wcm90byA9
IHZsYW5fZ2V0X3Byb3RvY29sKHNrYik7DQo+IAkJCXN0cnVjdCB1ZHBoZHIgKnVkcGggPSB1ZHBf
aGRyKHNrYik7DQo+LQkJCXUxNiBpcGxlbjsNCj4rCQkJX19iZTE2IGlwbGVuOw0KPg0KPiAJCQll
eHQtPmxzb19zYiA9IHNrYl90cmFuc3BvcnRfb2Zmc2V0KHNrYikgKw0KPiAJCQkJCXNpemVvZihz
dHJ1Y3QgdWRwaGRyKTsNCj4NCj4tLQ0KPjIuNDUuMg0KVGVzdGVkLWJ5OiBHZWV0aGEgc293amFu
eWEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCg==

