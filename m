Return-Path: <netdev+bounces-240848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C3C7B238
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57FBE35AED7
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E1134DB5C;
	Fri, 21 Nov 2025 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hyDp1yaJ";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hrYYFEOT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B234F254
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747555; cv=fail; b=mTP22H5Vz8tHmGzhkfjEQS7totTsKBb3LSwa/+uVtva2IfjKnbpxsAhXC9NiB+5N2Kq/kQe8RuN/BSvqXkYiLuoVB1zcRlTatk+Z6Jadjh/rdEuaEgILFqPG5LiQ5xjSxooit/7fEZr10zmJJ7H5qBCYZgZX1uZYUi1tOLRXtr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747555; c=relaxed/simple;
	bh=Yk/0BzXwWAORQKdPke+6H/I8nL43uRLsjk3mapFqfLE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kUufcatLPy7ztJOOIGXdtYbTnyO1jM98FRsieEds3XcCeZiX5dBFFXeGqDDU1jxseMIzTj3oEreTy8FFiSFeftHpUAsgtodLYeePvEULyHiRtaSDHoOwcTibm13KJrtQOpfsItyLFO0VLz3s4xcpUXQzTYI0+KB4qCYEfvj8ek4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=hyDp1yaJ; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=hrYYFEOT; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALHSGE2149120
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:52:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=proofpoint20171006; bh=Yk
	/0BzXwWAORQKdPke+6H/I8nL43uRLsjk3mapFqfLE=; b=hyDp1yaJERn3LMubAn
	+tlamZUsf7rfoNkez+HiYLCzF3jClUV2ykOn3be8QuI2ATR1x3GJmsyoMX01pp4n
	ZG9XlfkMbfvoUE7X8lIkDtJrH7DUsYvEsxdi5qauXqoCSn3apan05k8qlDu8C9HT
	eGIDWmcqCYVut+NQMtI0MeLv6vwMQu9JNrTUzN40FmBPbS0iIOvagRzfgZY455Mp
	ikv9LtzH0x/JGt75kkYIfnIEIuD7avj0kn9PMms5DSwxMO4ntlbICqbgWhq5O7Ob
	Fe1uiQmQeE022dlHhdNh3rXE3VB5FE9UABcQID+5N4J01ugpKrrqGCaDJmZ7JLVD
	+pCA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022114.outbound.protection.outlook.com [52.101.48.114])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4aj73etssu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:52:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLyYSV/pX2zH2KchujJesY6Oy+OPOVdiV9S5KLND/qGN1IJB6tHV5m/oO4iGp+rGX7gGnRWCN1bHUOoolQCtfYDYHbGdySwdEnbVvXdwPS8om5ZKncsR+5owwIu0GdOApLpf4TwplMpBVh+NHkTghBYH13YMvivM5rEq2CYa+lgK71vCaRtpDul7IZWrqeZE67my7htBIS4q1Jy+joDIwznRajCnnGTR1C4LEEEnBbCS5sf9+9VP0caTnMeR2DTLz7tZ7OEIMD8U1elqKFKNcAVriUORUgqDiIA/+clExPh8piR2ymCqqePzJpA/8H+2biSwYO4bIrz4C5U9YZk4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk/0BzXwWAORQKdPke+6H/I8nL43uRLsjk3mapFqfLE=;
 b=RpPDQFWb2vl7p6wgnOmXEWsgkM6zBK+NB6p5RxqeGHvBNFiUdEC9Jcjv2sbmwvv8vUMVZqKrvYSuzwJqV0Fc/EyCAJCiJE4fBKa/M5rREBQ/4CobYC9D42BIy+tSWatY8LCZ/LBFo5pryUwejyPnFnZkOqdCVG8irapXSWKnWsVSnvl82WzizpCCBZYgRAENpu+ydOs1/QUcqGo0kTL0fLtd979E1VOTeXTvLt7VEaBVozBhxzq/agFOTnhGJ64eyT8z7sy1k1aiq8hwoGlnAsau6USic5qy/2pi9s6lVGkXNkTipYzA0Osg7KDYw7GgYqAak64mvHZlMf7EwjqUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk/0BzXwWAORQKdPke+6H/I8nL43uRLsjk3mapFqfLE=;
 b=hrYYFEOTiM64/hD24AjHMuVNot1wiHJdHXFOYg5g1uFg5p4ShiZHgCTBbvJ4mz6MkekINDpGXrPDgslv1+Pb87CrduxGvBDK/Yyfv2T4ctuZNlB/sfo3V4v/vZdFhE7AIZ7by8Qk5/VJ0/0JhM24YXtmx5sDm4aWdh9iVA9f4z2L4HbWIaDXdx0ohiDAcW9ldJHAScmR5TvjV5dN4sa6hh385Ug6AHBScQLqk32QtDu7gfygCx6C5Aa2boX/24ezR+UHEI0RC6Mmb5TGaxojr6IAmZIvokH06hIpJj9D5QEPu3KF8SjczGL45mjOprryIa0EpDlpTBHTKkznub+3ww==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BN0PR02MB8176.namprd02.prod.outlook.com
 (2603:10b6:408:16e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 17:52:19 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 17:52:19 +0000
From: Jon Kohler <jon@nutanix.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Investigating masked_flow_lookup and skb_get_hash overheads
Thread-Topic: Investigating masked_flow_lookup and skb_get_hash overheads
Thread-Index: AQHcWw+VvqumOYTl2UWcyYy7ZN6Frg==
Date: Fri, 21 Nov 2025 17:52:19 +0000
Message-ID: <166BBD38-24D4-491C-BA62-1E41BE8C2F84@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|BN0PR02MB8176:EE_
x-ms-office365-filtering-correlation-id: 53fa5dea-6cb8-49a4-99ff-08de2926b794
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHQ3akp6cWNYS3hiRk9zZ0FkL2l1TERlUm1BOFpZYzdjWDI3U2ZEVFNocnQw?=
 =?utf-8?B?Umk0WUIyVnRnNU9oRGxuTmovQ0hRbFMyRWxlUGhaL1JNc0tvU0NVU1NySEZZ?=
 =?utf-8?B?dThQYkxCYU9XM0pESzZKT2o1emVaVzVkYXlKcDFYTVVidUxBSTBjbGtuYVow?=
 =?utf-8?B?MFlrNEFIbThLMXFLWHVTSEJFTkZBbUFWeW9FTk1WcE5SL3NyZGNiWGZWSmk4?=
 =?utf-8?B?NGNDSFRmUEQxQTZnWmZTS2ZZTzhlYlJVOTErcEQ1dVpCUWdaVmpwSnhwVVE3?=
 =?utf-8?B?Rkx4VjhWZVZkemQyVy80dXc2cGF1MDMwY3JHcUZjaXlXVFhnbzhOZVRxYmhi?=
 =?utf-8?B?OXZIaXAra2lYT1poN0JFNjh5WTZEWFcxYVBaK2JnOCt5L256Vkl4LzlvNHFn?=
 =?utf-8?B?OHVUZDlCR1NnZHhuUml2TDEwMnEzSHJwNWZxdG1pZW83Z1VKemMwN01mbEJq?=
 =?utf-8?B?dzRxdkMwZjM1Uno1bkdjTGhVbDhxemJkMERSVFZqRFd1QUNwNHQ0SW1kK2Vj?=
 =?utf-8?B?dHcrU2xCKzRRZTNZTHgyWm5sZFI3UDNHbitRZGN3WnRYM0Y3Z2RxejlqekNX?=
 =?utf-8?B?K0xwa1VEeDdwMzNqQ2JUelJaRUt1WjM1QUJQOVVwVU5tQlVjS1lUTG1UTldB?=
 =?utf-8?B?YjhkdUs4WWpqUlB3Lzg4eFB3USt2YjU0Y0lXbFpFS0FnbkYyWXowT3J3d3RQ?=
 =?utf-8?B?YS8xdkFUZnN3eDZTSTBuL1A0SDJhc1pRWndHTFM4RXFicFRVRkZQK2ExeFpR?=
 =?utf-8?B?di9XUCtJL0dPY3JraGM1WFFrMHdBUkpHN0NrTG5IT0c2aHNoMHhUN25KekJJ?=
 =?utf-8?B?d0ZaRGN1WlNnUW1iSkEyMXVhOFQ0RStUczZySndhQjRNTlB6YzlYVUNSRTRC?=
 =?utf-8?B?MU9CcVB2dDh4UXdxOHVNam9uSWpvUGRNeFl2MTkxZmhUREMzeG5STFpCdVNY?=
 =?utf-8?B?enZVMUovdzFOTGFtbGgwd0E4NmJ6WE56UW1VekxtaWhVdlF2bDZWMi9CMURK?=
 =?utf-8?B?cHdiMEJKeEwvN3VYc2tibmZLRXBaMlFQS0VvTW4vM2ZLSHRmV3ZyN3B2dFRo?=
 =?utf-8?B?MEpIMXFISTRCNERxaVN6RWFEc3hTdndiSlhVMjU0SXlTblE0aVpLZldpSENQ?=
 =?utf-8?B?cVFZeGRTR1RwQWhLRWlGVlVlQ011R2VzbWgzSFlvTkJOUzdWalZ3TVdqTVox?=
 =?utf-8?B?eEtCUG41SE5ab2pDUnlaMlBsMlJwNnYwQ2ppcXhublRJcWFUYkIyTWlRZVg5?=
 =?utf-8?B?a1ZBSTdqdmZwMnJSY3E5V3RNTUphYkFYeHZsa1cwSVhRRHU0MjRqZjN6c2Y0?=
 =?utf-8?B?aVRJcjVVZmxIQitodUhVZjVTUVpjeWF2dHUybHo2Z25VZ0VWSTIrcFJMZkFa?=
 =?utf-8?B?MGoyZmZqMmdzY2t5dmphNHlmeERNSnY0eUxqSmpYblU1YllDc09wZTFkeWtR?=
 =?utf-8?B?cEo4UG50UFZTMjlXYXFpbXQzN0VpTkVMbzdReWttZEVyNWxaazF3bXRSQ3g3?=
 =?utf-8?B?bnNJT0JLR05BdWI4TUJ6OG1VWEpHVk96NWNYd2RwUzZKWGNjdUtTRmdqZklJ?=
 =?utf-8?B?alNOL1RMUHBWeGtXeTZCUHpTLzVvYm5oQjB5TUtYcGV1Y0M0MU5meEZsMGd5?=
 =?utf-8?B?M2MzbzBPVEV2SjFIcktER1Jxc0VpVGJ5Rmlwb1YyblgvNmcvMzhEbkZGU2RQ?=
 =?utf-8?B?ejhzZEdkQ2wvbTVlblAySFNSUXlMZ1lQSnR3QmsyT3JWa1pMdThDU1lKN0VF?=
 =?utf-8?B?Z0lYZGNrQkh0SHEzeFFuWFJsQ2JITURycGQ3dWRFTUdrSlZwa2Q2aTExSVJ1?=
 =?utf-8?B?R09SU3RtSENVMDhjbjdRKzlVeXp1S05TdklOdGVVTmYyYVIyUEF3enAwa2pK?=
 =?utf-8?B?aE5PbVVJMEVuSWFtQlZyVjVCakp1dEsvMTY2WUxrWEtsR2tPSy9XdEpxK0cz?=
 =?utf-8?B?TEV1WWRFd3hqVjlIWW9yZU5yQmVjZXdvREJmKzZnd2pqOWxZYVdiU3dlM28x?=
 =?utf-8?B?dThpamRKUC9HbndmL2pwMFlJQm5EVGd5dkpqQm5jN1gwZGNFMGp6MHhDU2hu?=
 =?utf-8?Q?OCW//7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3dveitQS3BVcTJacklUcEtSakw3cnc3ZnVrNU9wRjM5WVlxMGgxTEpxYmpO?=
 =?utf-8?B?dVI1VDJBQUJiZWRXN2hOZFk1bXNWdmxQYkxpQjZpemgxdFR4cXBNZU1LYjNT?=
 =?utf-8?B?MWtsaERvYW8rK1NwakdQT044YWhxMWF3TERIejB6Y3BzVlB2bEoydFFyOWZv?=
 =?utf-8?B?TVh6NUNEYjAwNXZVSU5qdzJMaWVKUkgyMmdNbUlndW9xbVVjQmVzS044cjlZ?=
 =?utf-8?B?MlZ6alpva2h3M1huSXdXWSt0OUtDNzBkQ29PR1QyRmVHdDUwKy9kKzMxeXNz?=
 =?utf-8?B?Sncza21panprR1NQYWRqcVRsYy9IaWlFQjA5OGFPc0RZUUV3R3FuY21ZNTh4?=
 =?utf-8?B?c2VkZ1g4NVg1RXpRWmtkZWQ1SHF2aXZ4WVJFWkFNM0xMU0ZJZ0lWTGtHY0gy?=
 =?utf-8?B?S1pvMEowQTNKTkIzVTBJSzVjNWs3L0lSc3F4c3hpblAyRUxKYkgyMjVERWxm?=
 =?utf-8?B?cGJHUkI3SWhqVi9XNUI2UjBNM3c3dWk1UFdRaDM2Sml0QTlVR1cvQlhUQ0xR?=
 =?utf-8?B?QjdEUHJ2L1RzV2xWY0dXaFkxL0gzTTliVTkwWElGUHBKU3dBS29nT3lvK0lP?=
 =?utf-8?B?eFh5c3lJSjNnYUl4ZmlrcWRzN2FXaUswQVpwM01IS3hFcWZudE1BZGVBWlFL?=
 =?utf-8?B?bmozL2VqY0p3MG9uczVYWnpFc3dLcDhkZWlJdmw3aUhoQms2eFd6M2p0dk54?=
 =?utf-8?B?LzEzRkRBL08ySjVjSU9XYlBzYk9Nd2swY01OTEtLT1lTeXg0dy9XRVZtQkZM?=
 =?utf-8?B?eFpsb3ByQXFUaUZWT0pnbDhPU3J4Sk9pZnQwd1grNWZabVVSNTh4ck42bnc4?=
 =?utf-8?B?OU1LR3NYOHNVc2IvNysyVFlJN2xwK3R4S0J4SVVIZnVyS1czQ3R3SWhQU3FL?=
 =?utf-8?B?YXV4M2dyRlQ2cm5uTnlGRG4rSHg0emJDcnlMOTRXbHUxeTAzRUdtUFZ5Y25G?=
 =?utf-8?B?Nm1OOWptbzh2bGtvZkhDQ2FXeEk0S1FGNGFRWjVKMWpUWTFvdnRWUTZpT0NO?=
 =?utf-8?B?ck1SbjdzakZjWmU0dHZqWDQzcld2QmRya3BNNWN2S1gycmVwMzdVb05qN3Vn?=
 =?utf-8?B?bExWVDVJeHR4dXJaMlNJSURjUktLNlBPRUdaSWgxcFkxTDFqUGpCSERabmVT?=
 =?utf-8?B?OXJ2U2VMUTM1UDgzVFlqU0NmeHVLWWxwK0RaUmdTM1hKdWYwQlcrS2hjVnFC?=
 =?utf-8?B?dG5LK2NJR280WEVVV0NYbHhzdG9KY2NnOWMvcW56dDR3SXBpZVVTMEI0WUdD?=
 =?utf-8?B?NHVObmYyUEtZWFZDMGNtSUFZenRBZitXb3NJZm5mQlc5NXg3dVZOYWNWa3U2?=
 =?utf-8?B?Q25LRzhLeXZRSG1xemJZMWtaQWVIRmZOMVdJZ2lrU2s5SWdRT3VNUlN5eTE3?=
 =?utf-8?B?RWNGU0JDbmxnNmhUVEo2RllxekJKNUhvanF3eEdmM1BTQlRNZkMza1U1UE10?=
 =?utf-8?B?Y01nVXhuRnEvY0JSZ0NsQlZWQ3l4UHNQcWNxc1V2RXE5eFBYM3VlVUYrZzdR?=
 =?utf-8?B?Wlk1ZUlHMkttRTdic3VvWmlkSlpTVm00L29uTUgxMzNiK0toeEZFSFNpdEhY?=
 =?utf-8?B?d3lUb1c0eDF0aTR0eTBSUWJuZW96VVFKMk5hOVU3aHhncjhTUGk0cEV2bk1i?=
 =?utf-8?B?TWhGTG1lYTV5aWlYc3QwNHNPNjQzZ1h0RkluNGxnQ09JNGlKRklsMnVvemlD?=
 =?utf-8?B?b3JKQU9abDM2NFNWbm9HK1I4OXBra0hlY2ZXdFVkRTc3RTF4STBoZXgzVE9M?=
 =?utf-8?B?ZE02aC9UR3ZvR05CZ2Mzd2l2dlRwcjVpektjcXd4UXhCZ0pYcHU4VXRGZTYy?=
 =?utf-8?B?QzNuUzdUdXdKNWkrUkZkQ1MzLzdFOUEybkNiNWRIeTBZMHU2Skw3OHloWmZm?=
 =?utf-8?B?SmFEdTVQai9VVTdvRkVGTTlVcnNndGJCNlBtOTFrdUlNM204NmZYenF2dUlL?=
 =?utf-8?B?bFJuWmZUSVRrbURaVTB3ZUNlMjE4dlo0dDh2ZjFiYUFkb3FqR1BPUDd0cnNz?=
 =?utf-8?B?V0ViNWtCUC9odGRLdlp1MklQZjhiZlM4REVmU0NzUzJJSGJsK2oxQTZIQjNm?=
 =?utf-8?B?VU1mNlJvbDYweGI2ejJnUE1wdkpYRWNSOTdQZ0tvSEc4di82dTExTnIxakYr?=
 =?utf-8?B?UkdwZUdBcTliN2xQaXoxOWdyVGVuajlIRE8zQ1BRR0lxSGxQaG9yeW12U3V3?=
 =?utf-8?B?Yng2MXoyaHV3cWlKdHpSWVFSamRKcTl1UlRGQ3Y5SHJhd2plbk5PU3l6c1lR?=
 =?utf-8?B?R29JbHBETGM0RDBEQzlGcm5LUlZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9614566CF8CCF345B58BC7155BD9FD4A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fa5dea-6cb8-49a4-99ff-08de2926b794
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 17:52:19.7683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZ/1ZfsUmub51xYxTkE66K1l6n6Ae/ZOI63MDFbgiEYC0CBRItFs1f6cHed5ITouc/0AllpJwlsLuRAK2qNzlugSFz8zOJm67iBtJUNGezc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8176
X-Authority-Analysis: v=2.4 cv=LYMxKzfi c=1 sm=1 tr=0 ts=6920a6d6 cx=c_pps
 a=5LyF95Caz1MJpeKVvSEBBw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=441jZvzBxDChYLby7vUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDEzNCBTYWx0ZWRfX24h6nO2Psk7Z
 M2DBnXKBldStXYYHA66f0kfoxHHFUZOdKH6x52TtD8EtYd4s1EDkKH9hrcWIz41aYrhG6DzEdNy
 g2Vim9f53KHZuQlMNWPbpEnJiIgngqRFJnPNvzJjGRPIebrkuyiwaKAx9B16UEPWfQWQKJHkBdb
 PsKjAkbnVBc5o6hXO+6fQSFCxZeNku128lHpkd/rOuHwVAT22obzy82tcAXW6yHouoL+eQwt1GW
 tKo0uiAVQZHYYgmL38ORO2PDJOG7YwJlKUXjvyyJU2X7zd/Ww/oOtSfknb2NiBBsitzM/QO25jf
 Brwec672Mbh0cfIsRd2cDRg+OPU/mZdn7EsUAF+26fiU97CG7RaZ+QO9qVtx2ADEeQ4X6QybMEj
 cLK0VhMcl8TMCMT0WfwflnLpuZ5Anw==
X-Proofpoint-ORIG-GUID: t2FkUm-ZDMiHdjW6dsfq_wzQLtFMX03z
X-Proofpoint-GUID: t2FkUm-ZDMiHdjW6dsfq_wzQLtFMX03z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

SGkgbmV0ZGV2LA0KTG9va2luZyBmb3Igc29tZSBhZHZpY2Ugb24gb24gdHdvIG92ZXJoZWFkcyB0
aGF0IEkgbm90aWNlZCB3aGlsZSB1c2luZw0KdHVuIG9uIHRvcCBvZiB2aG9zdC1uZXQgaW4gYSBV
RFAgVFggaGVhdnkgd29ya2xvYWQuDQoNCjEpIG9wZW52c3dpdGNoIG1hc2tlZF9mbG93X2xvb2t1
cA0KMikgZmlndXJpbmcgb3V0IHRoZSBTS0IgaGFzaCBmb3IgdHVuIHByb2R1Y2VkIFNLQnMgKHNp
cGhhc2gpDQoNClRoZSByZXByb2R1Y3Rpb24gaXMgcXVpdGUgYmFzaWMsIHdpdGggdHdvIFVidW50
dSAyNS4xMCAoNi4xNykgZ3Vlc3RzIG9uDQphIGhvc3QgcnVubmluZyA2LjE4IHJjNiwgd2l0aCBv
bmUgVk0gZG9pbmcgaXBlcmYzIFRYIGFuZCB0aGUgb3RoZXIgZG9pbmcNClJYLiBUaGVyZSBhcmUg
bm8gb3RoZXIgVk0ncy9lbmRwb2ludHMgZG9pbmcgYW55IGFwcHJlY2lhYmxlIHRyYWZmaWMNCmR1
cmluZyB0aGUgdGVzdC4gRWFjaCBndWVzdCBoYXMgYSBzaW5nbGUgdmlydGlvLW5ldCBkZXZpY2Us
IHJlcHJlc2VudGluZw0Kb25lIHNpbmdsZSBOSUMgcXVldWUuDQoNClRoZSBUWCBWTSBpcyBkb2lu
ZyBhIGZhaXIgYW1vdW50IG9mIHRyYWZmaWMsIHdpdGggNi4zOSBHYml0cy9zZWMgYW5kDQo1NTE3
MDcgVURQIGRhdGFncmFtcyBwZXIgc2Vjb25kLiBUaGUgdmhvc3Qgd29ya2VyIHRocmVhZCB0aGF0
IGJhY2tzIHRoaXMNCnZpcnRpby1uZXQgZGV2aWNlIGlzIGF0IDEwMCUgQ1BVIGR1cmluZyB0aGUg
dGVzdC4NCg0KRm9yIHBvaW50IDEgKG1hc2tlZF9mbG93X2xvb2t1cCk6DQpJJ3ZlIGNyZWF0ZWQg
YSBHaXRIdWIgZ2lzdCB0aGF0IGhhcyB0aGUgc2NyZWVuc2hvdCBvZiBhIGZsYW1lZ3JhcGggZnJv
bQ0KdGhlIHZob3N0LW5ldCB3b3JrZXIgdGhyZWFkIG9uIHRoZSBUWCBzaWRlLCBhbmQgdGhlIGRp
c2Fzc2VtYmx5IG9mDQptYXNrZWRfZmxvd19sb29rdXAgZnJvbSB0aGUgcGVyZiB0b3AgcGVyc3Bl
Y3RpdmU6DQpodHRwczovL2dpc3QuZ2l0aHViLmNvbS9Kb25Lb2hsZXIvMDJlZjJjNDlhMTc2ZGMz
MGJlYTc1ZjY4OTg4N2RhMTYNCg0KRXZlbiB0aG91Z2ggcGVyZiB0b3AncyB2aWV3IGlzIG11Y2gg
c21hbGxlciB0aGFuIGxldHMgc2F5IG1lbWNweSwgYm90aA0KbWFza2VkX2Zsb3dfbG9va3VwIGFu
ZCB0aGUgc2lwIGhhc2ggd29yayBhcmUgZGlyZWN0bHkgaW4gdGhlIGNyaXRpY2FsDQpwYXRoIGZv
ciBuZXRpZl9yZWNlaXZlX3NrYiwgYW5kIGFyZSBvY2N1cmluZyBwcmlvciB0byB0aGUgdHVuX25l
dF94bWl0DQpjYWxsLCBzbyBvcHRpbWl6aW5nIHRoZW0gc2hvdWxkIHByb2R1Y2Ugc29tZSBub24t
emVybyBnYWlucyBJIHN1c3BlY3QuDQoNCk91dHB1dCBvZiBwZXJmIHRvcCAtdCAodmhvc3QtbmV0
LXRocmVhZCkNClNhbXBsZXM6IDgxSyBvZiBldmVudCAnY3ljbGVzOlAnLCA0MDAwIEh6LCBFdmVu
dCBjb3VudCAoYXBwcm94Lik6IDMyNTcxMDM1MjE2IGxvc3Q6IDAvMCBkcm9wOiAwLzANCk92ZXJo
ZWFkICBTaGFyZWQgT2JqZWN0ICAgICBTeW1ib2wNCiAgMzEuMDQlICBba2VybmVsXSAgICAgICAg
ICBba10gX2NvcHlfZnJvbV9pdGVyICAgICAgICAgICAgICAgICAgIA0KICAgNi43MyUgIFtrZXJu
ZWxdICAgICAgICAgIFtrXSBfX2dldF91c2VyX25vY2hlY2tfMiAgICAgICAgICAgICAgDQogICA0
LjkyJSAgW3Zob3N0XSAgICAgICAgICAgW2tdIHZob3N0X2NvcHlfZnJvbV91c2VyLmNvbnN0cHJv
cC4wICANCiAgIDQuOTElICBba2VybmVsXSAgICAgICAgICBba10gbWVtY3B5ICAgICAgICAgICAN
CiAgIDMuNTklICBba2VybmVsXSAgICAgICAgICBba10gX19zaXBoYXNoX3VuYWxpZ25lZCAgICAg
ICAgICAgICAgIA0KICAgMy40MSUgIFtvcGVudnN3aXRjaF0gICAgIFtrXSBtYXNrZWRfZmxvd19s
b29rdXANCiAgIA0KbWFza2VkX2Zsb3dfbG9va3VwIHJ1bnMgYXMgcGFydCBvZiB0aGUgZm9sbG93
aW5nIGNhbGwgY2hhaW46DQpvdnNfZHBfcHJvY2Vzc19wYWNrZXQNCiAgb3ZzX2Zsb3dfdGJsX2xv
b2t1cF9zdGF0cw0KICAgIGZsb3dfbG9va3VwDQogICAgICBtYXNrZWRfZmxvd19sb29rdXANCg0K
VGhlIGtleSBjb21wYXJpc29ucyBmZWVsIGZhaXJseSBvcHRpbWl6ZWQgYXQgZmlyc3QgYmx1c2gs
IHNvIEkgZmVlbA0KbGlrZSBJJ20gbWlzc2luZyBzb21ldGhpbmcgYnJvYWRlci4gDQoNCkZvciBw
b2ludCAyICh0dW4gY3JlYXRlZCBTS0IgaGFzaCk6DQpJIGRvbid0IHNlZSBhIGNvcnJlY3RuZXNz
IGlzc3VlIGhlcmUsIGJ1dCBJJ20gd29uZGVyaW5nIGlmIHRoZXJlIGlzIGENCndheSB0byBnZW5l
cmF0ZSBhIGhhc2ggZm9yIHRoZSBTS0IgdGhhdCBpcyBjaGVhcGVyIHRoYW4gbGV2ZXJhZ2luZw0K
dGhlIGRlZmF1bHQgc2lwaGFzaCB0aGF0IGhhcHBlbnMgd2hlbiB0aGUgY29kZSBoaXRzIHNrYl9n
ZXRfaGFzaCBoZXJlOg0KCW92c19kcF9wcm9jZXNzX3BhY2tldCAtPiANCglmbG93ID0gb3ZzX2Zs
b3dfdGJsX2xvb2t1cF9zdGF0cygmZHAtPnRhYmxlLCBrZXksIHNrYl9nZXRfaGFzaChza2IpLA0K
CQkJCQkgJm5fbWFza19oaXQsICZuX2NhY2hlX2hpdCk7DQoNCkluIG15IHJlcHJvZHVjdGlvbiwg
dGhlcmUgaXMgYSBzaW5nbGUgcXVldWUsIHNvIHRoZSB0eXBpY2FsIGhhc2hpbmcNCnN0dWZmIGlu
IHR1biAoZm9yIHJ4aGFzaCkgZG9lc24ndCBnZXQgaGl0IGJ5IGRlZmF1bHQuDQoNCknigJltIGN1
cmlvdXMgaWYsIGluIHRoZSBzaW5nbGUgcXVldWUgY2FzZSwgd2UgY291bGQgdXNlIGEgY2hlYXBl
ciBoYXNoDQpnZW5lcmF0aW9uIG1ldGhvZCBvZiBzb21lIHNvcnQ/DQoNCldvdWxkIGFwcHJlY2lh
dGUgYW55IGhlbHAgSSBjYW4gZ2V0IGhlcmUsIGhhcHB5IHRvIGNvbGxhYm9yYXRlIQ0KDQpDaGVl
cnMsDQpKb24=

