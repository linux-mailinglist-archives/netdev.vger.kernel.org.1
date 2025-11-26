Return-Path: <netdev+bounces-241997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB8DC8B82C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C553B8CC6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F4E311960;
	Wed, 26 Nov 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="u11j0Rn+";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="YJaP78sa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B213271469;
	Wed, 26 Nov 2025 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183638; cv=fail; b=QpGcOfQaNqHK7FhexAIXupxKWxxMZW5II77VEwws/ckQ6SihMOkOgizaE7IiiW6p5JW/8NQNZmsKW/rw8UvaaioRTsTT/pSg7IMN35R8uSeykmFkvG58vQAf+NjrJU8DKPNPma9ZwFxoVeSHIO4xU+DqC9lREi/oURzaPxCNb94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183638; c=relaxed/simple;
	bh=YGujCyv0V5g2PGkJy7d4M5w86NAyvNMKp4ewpjF+dk8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HR1DbkxGn70H2SddVSkydPVskIrjQ+uNd5PXkSyGk1tljbAMGamtj+bg4wCjI8wCv4aAsrp904WwLXrJoqaYUqKBD50zpelyqPcqnvBRcDJ1PQsLG0Hwii7CR/nRBEAEDPsGIZt6NnXb2C2PjnGGJfh5AubfsTLIR7xAbZmkidY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=u11j0Rn+; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=YJaP78sa; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQErQrT1609670;
	Wed, 26 Nov 2025 11:00:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=YGujCyv0V5g2PGkJy7d4M5w86NAyvNMKp4ewpjF+d
	k8=; b=u11j0Rn+dx/J2ntNAHkjEyn8Zl2YqyxEsggwr591SVd3Dd040cg8br1bn
	ENTWskJjOw0h23RTbckmzM3t2QfehfQXLWEwjukZgDrijaG16aw+7ZkpgwX2DDUk
	+ElHP1DCpIyYUdhvBSGh9r1m6k20lkze4uCA1R8kqGbL7AxJcqQCjHpzOY7/NasQ
	wyVqKZYLiX9WXY+TPV2liegvHtKlcVSl5QUR64RLvdoZduirC6Wd8okDlch03d12
	xqffk58lmwdhefiV4TXg9YSwfEi99BcP1tLGMBErdA1xT3XuY74fogw9s8i2Wrwc
	JmZ1vXc53QF4VY3sVOPEdTGdtLTkQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022117.outbound.protection.outlook.com [52.101.48.117])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ap3q2gg35-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 11:00:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbyNEtAO1TxckSp5wWEEiCm0LKXzctQTplUwXCDEFgYBve1uo3ga6riohqgrdSe6IpdgcRBoEeewfxM1WImpAdMq+pJT3RMiNfgXvQZwbaoxpesBIKqGwwsZgXHIYEwB1YQVraZ+LO6cwgj2NfuKrekCwF6CAClKBDDjcOliJFgpD0FSLjVz8B9QIKu2v3IFd+3lYyPV0yUOvM73LhkspRb8U8gPcTVd4PORWmuymLn3EHaJB/1EQWvQRVn3jp+ozEw/4T5kIKq+5gvVU2XroUjfTo99uxYCeX3WtYY/yJ6vOFrRlHp6VN2kwIfMAdJUXlRnpjNXXpBrxE/ji+G4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGujCyv0V5g2PGkJy7d4M5w86NAyvNMKp4ewpjF+dk8=;
 b=r5fxg+qYy/jywWsH8DOPBMoW+zrPErbzZOD/uKg6YFEsNjoSgy55urIfK9B1p7fXH9AJt9jSY14ORiIFTqzsACXkrEKTj+x7o+h/kIht8j2H4tz0QdmBqiWLmAI8Q+AsBE+0iYIIUUXQXj5AH6OkYHdJX9RX7oFbOYgdfn6w8a+FBpy1K6qRWhoXlrPAtKxzWhbBMkC3ouzjiEX65g+1rJlhH8TJMBcvhWXeoATlpWAEgbOOE05lqszrPBdMuqGk/MHiSyzQ//EOWNKm19vc1yaOs0quqR4IU92Sw7WOv+U9Td3mXe7dVFDw8xq35e19E8HaSjhYKngxH0tD+NxBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGujCyv0V5g2PGkJy7d4M5w86NAyvNMKp4ewpjF+dk8=;
 b=YJaP78saYMoQ4bHiXm7LhvuZJu4OcV97EKyp4aX7QcjEaC6KBdw7zHD7zOuaVmnII+JZ4FkMCK/zPt+YI60tYDhz8pKuxZWizIVUOCb+gMckWHeSfeBpRzWWTu4ERhYi9n19qrETxNI3t09PmGOVe9IWTyHowvHpJUKj5eds+o1V4l7IgXY44ypwfh511TqPq2g/dp1hnhDDfu22PVwnRgDIG0N/yE/pSJlteLfOwVpJR+xXguW7GRplwXIKXMjJNeGFITYHhPV0j0dznfmKK6XdZI4KLS4Frdi0v152FJTyxdb264w/eurBWPCOvo0+H2SZ/0+t6QEv0Sz2vIzDAQ==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by DS0PR02MB9431.namprd02.prod.outlook.com
 (2603:10b6:8:df::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 19:00:22 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 19:00:21 +0000
From: Jon Kohler <jon@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
Thread-Topic: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
Thread-Index: AQHcXi4zHSZXDxRn7E2vwL8pjtv0WLUDramAgAAiWACAAP/7AIAAFJoAgABs1YA=
Date: Wed, 26 Nov 2025 19:00:21 +0000
Message-ID: <51614B7F-2C1C-43D5-A969-BC41FE6E821B@nutanix.com>
References: <20251125175117.995179-1-jon@nutanix.com>
 <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
 <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>
 <abb04d29-1cd8-4bff-879d-116798487263@redhat.com>
 <20251126073008-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251126073008-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|DS0PR02MB9431:EE_
x-ms-office365-filtering-correlation-id: fc586d9b-1701-446e-c088-08de2d1e0c80
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K0RSTXBwdjZXRHA4SVg5MSszbGtnZGNySGh4ZmxxM3Rpc0FGVEdXRHFFb3NP?=
 =?utf-8?B?VVNrdHNPNzZnZkhtWG9NL051VjhqOGRDNVkvRUg4Y0FGSU1EZXdNVVJ6UG80?=
 =?utf-8?B?c0dLRHFRTDQvT1YvZVZZMW9LUlNsY2JDM1hxZnZBU1IvTmppY1J5Uno3NnJZ?=
 =?utf-8?B?clFZbk9WeGt6ZEpaK05sMGowSzlZaktpeVRNN0Y5TlJCdzNxbTVnUUt1ajRk?=
 =?utf-8?B?eE9EWUVtL1NuRFhZR3dOWFhYdUxiVTBFdUd6cEkyYmo5ZHkvZmZTaVM3T3Rp?=
 =?utf-8?B?bE9HejRYYmFkblF0NGEyTUVNVTlENFEzRXBJNWRjVjZTVlVacm1TSVdDWEw3?=
 =?utf-8?B?Qkl3UjZDYXJoVGVoaVJrMmEzY3hTam1LVHBnL1k5SUxKbCs0MENSOFdtalZw?=
 =?utf-8?B?RHc0eGl6SGIrWXZYeHVrc3E0OFEzdXdYRzJTVlN2NW9kUjI3eEFGelBIelJW?=
 =?utf-8?B?bm5LVTRWajAzMXUrN2xPMVRuY2luMXlTYnozNUl6OGljVm5CY0Y4QzFWTDBl?=
 =?utf-8?B?d3c3aHoxczhaTk0zMDJYTnFweldsMGRPYUwxQWg3Zy9FTjNSWTNUMFMvU2Ro?=
 =?utf-8?B?YWg4eVNzME4yRTk2TDYxcWloalRtT2JHQSttVUwrK3FXRWlib3NvMDU5dTB1?=
 =?utf-8?B?b1pnd0ZZY2VuWFJEYmVvRUZMTUM2Z2c5dlBwVENvOVdLdjV4b2ZjRkR1STlK?=
 =?utf-8?B?NUQ1MkNDdll6dDQwM2o4MnBORFN0cUxveE1ma1l0Tnd6elRuTWpXSTFicU1r?=
 =?utf-8?B?SGFLV05nSUZDcUhHNjBVWlI1Ri82eG4zQXZ3R0cwWTZzQm5aTWFCSXF5UWND?=
 =?utf-8?B?eTd3bFkrcnYvcHhVUnAyakFOS29EU2c5cWUvN09JZHBTeTZmZGl5VVZBaVRW?=
 =?utf-8?B?d0RFa1lrMzVaLzNyNnVNdUdCQWtZeHdsUWhHazYwRFlnc2pvRENhK3JVd1lV?=
 =?utf-8?B?bytmVTVDNGxweHh0ZXJtMVhkbC9lemVUTXYvS3Nma2YxeUZGcFVWakhwQm1O?=
 =?utf-8?B?YjBkUmpFL00wdDhxZFVmc1ZrL2FObXMzN2V4Q0dTUytsbVZGVEZsUnBxOTdr?=
 =?utf-8?B?UGNvbzh3QStZN2gvdERTZktyYzJtWEpaQ3lDSDJRWXFkalJiNEl3QXY5bGpX?=
 =?utf-8?B?VFlZckQwUkxUNTZCSzc2d2hXbTM1c0JvbHZ0L1NqR2t2S0VVS2tQd0dHcExY?=
 =?utf-8?B?V1NCbjM5K3pwWVRJck5NSGxsbE9hMC9seHY2WXA1ZktvMExaVWMxTFgyNkxp?=
 =?utf-8?B?TE9vMmNvbkIzR21GVityZjlrUFV6TzdzRWtZaWthdnVsWDdwZnpGTm5lNlFl?=
 =?utf-8?B?UERwazhGdkpqSmhET0JjRjlyUkppRDFRNmVtVlFaZjVqRVNOYjNDc0RWdCtx?=
 =?utf-8?B?d3UwUnkwK1B6S3lzSXNtTHdacitPcWI5R0hLQXdkOVIrNDJCMjg4UkZiN0dk?=
 =?utf-8?B?ZXczaGMxNmZQeTdJQnhJc2ptb0hXUE45Qm83VmJsa2ZBZ1hxd25vRG9YcVRP?=
 =?utf-8?B?aE10WFp1N3FuVVdEaFp5QjJyc2kvd1UwcUpuMzBrRmNYdXBETmtBMjVOeU1s?=
 =?utf-8?B?eW5uR0VoVmJYc0llQjV2LzlwYzF0cWhycG1LS3h1Y1B1K3dqZVl4VXZVMnZx?=
 =?utf-8?B?Y3d5VXF2dk5IaHFHTmhteTZDWFhKNEppZlpSN1VySmFMVEFNeldMSWZlQkRv?=
 =?utf-8?B?RWs0QkI1aFdqZVB1VWhlczlRay9ydE1XREVmemF4TGw3ZHlMeDJLWlF6aWd2?=
 =?utf-8?B?VE9Cb1VidjBnN1NLZkhtZUFHdjJRWG1rRVFoMUF0WVNEK3NsRjMzYTdKbTRE?=
 =?utf-8?B?cTBpV21OSUpybDhYb1Zvd0ZMS3lqMDNvVGxwUG9zdnBsMGs3MFEyK2NrR1JC?=
 =?utf-8?B?Z0ZqTU1jNndCT1AzUjBXa0NwTGlYWk94WFpRUGY2YVpRQjVkUzlJWkRvL3R0?=
 =?utf-8?B?RTAzVDhVWTM4Yko5MWhXYXU5bkorRU5ka09WYS9qK2tSYjRXWGE0SEEyYTl6?=
 =?utf-8?B?SHZEKzJpVGgrWWRyMnNxYWZtTHA5K244T1J1TXhvL2RpQ2YvYjdCcGE3SkFF?=
 =?utf-8?Q?A6aCgC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUhIcUNNNDdTSi9TdHdGMnh6Q0tna2Zla1lBWEZnekhPTm1Pb3UyUkJ3Rk94?=
 =?utf-8?B?bXA3anA0YUExMXl3R21WNWZkQ1RLOUtIMmEvNHFYMHZObEVXKzE0Q2h0UlZ1?=
 =?utf-8?B?Uld2K3NlWklKc05maUdHWkxXaFg5TTBjUzQvR3FrOTJwekRhdW5uTzR5MDZN?=
 =?utf-8?B?Y1dNMVdTRWo1aGRlSUdKZHM1TS9nT3Z2Q1FsYzEwK3U4U0Q5T0s5VWlBTS96?=
 =?utf-8?B?bzduYTlDdi9jY0ZUbmtnR2NNZ3B3bnZ3dFBIRm1rUnFSYzhRL3VuUHpYSmM5?=
 =?utf-8?B?cWhJQ1NkZzZYUHRBdzVwM0JoVGYxZ2VEdFhxVEo1Z2NET0hqTXNzeHY5bXhC?=
 =?utf-8?B?SnBpbTkrWnkzUkhXVTdETklLYUZ4TGREUFBOZ3BhOWZYTlFVTVhtQ0hsakI2?=
 =?utf-8?B?OVJlZk9qYmlhbHlTSFNoNU5XQnJ1b0N4V3VZUE1lenhNRStUNGpsVHRMd1hi?=
 =?utf-8?B?c0JmWkM4ZHN1bS9rdVNWaXlPWHpERHVPa2NxdUxpdG5PTlp6bXNHVjUrRmIw?=
 =?utf-8?B?aitvbm5QMTFXbGI4ZXNBVlRUTHdGc3dreTV6WW8yei81QUZaWFBHZDAvaXRi?=
 =?utf-8?B?OXowRVR5VHRhOHFhWEY2TDc4ZnVGOEtkMnRCNUlSb1JaczFrcWI4VGN5L2oy?=
 =?utf-8?B?bjFmMEtNNHd4VnJrNmtQNjNMM0lxNkZmTmh1V1RFTmtJREFOM0llWDZiRW5x?=
 =?utf-8?B?aWFTajVWNGhiemlPbTRwbFRNN0hwcnZ0enZMWFFoNGxjQzAzVGVFREliMTFQ?=
 =?utf-8?B?enlrbDVTb2xqTFZtTXNSaW9qM21SNGQ5WEUvdHcwcjVoNXV0NldoK1c0aU0z?=
 =?utf-8?B?bnBFblJ0VWlUVUtSUHRweEhrbzZJckQwc1R0ZVZqcWhxTlpoOStCYjZ4elBJ?=
 =?utf-8?B?Q2tZVmU2VU1GS3FJbUxPblgvVk04NlNHYUxwYjRFUFR4bGVlSTRsc0lFQ1ZH?=
 =?utf-8?B?QTZUZkp1b0ptenNkTnF2aGtwRElrUld3Y0ZUMXhCQlBOUDdZK3Vhd3R6TXVo?=
 =?utf-8?B?VHRnMlRGTE8yVVRzVzRRVnEzZTYvaEVJbWF5SHFiOTdQY0tEc25zODhvY3FL?=
 =?utf-8?B?WDZaRm5WUS9Ca2NheS9kU25VSG1VaXFQR3NITUhXZVM3M2t3WVVzSXdpQndw?=
 =?utf-8?B?MjYxRmVOR3JLb1NxZlVKMHJZc2RuKytUS0pxNmExc1llRElMeCtSNmhXN3Fs?=
 =?utf-8?B?bEU3L0xvNUJmdk1wMVQ2c3pGNU8xdm9kZndtcVZSL2lwQ0ZCOURZVFdoamVr?=
 =?utf-8?B?UFM2R0dmVzY4R2RiWUpKSi91MEpVOEZteWpUZytrS21iRWJHbitydFdwaTJs?=
 =?utf-8?B?emwwNHNTd1pWbWNnK3NXYTdXN0dWNEZMWmwzZHR6MHNST1B3ZkdMaVUxbk5o?=
 =?utf-8?B?NWN2dWVPeExXYzZOaDA4NmFxdDFZcHZ2S0JPMmdGRmJRMzFJRlAyV0h6bzFJ?=
 =?utf-8?B?MExaYWdwc0xGb2VLa1BjZTR1SFN1UXQyUGRHb0JtaUtzNkhTa2tzLy81ZFo4?=
 =?utf-8?B?cWI1OUJVSUpwU29xNkl5dmRJSUpyanpSbjdyWFp1cnlMRGZYTzNRN0lSemJ1?=
 =?utf-8?B?czVIWnQ0WHN4WmtCTGNuRGg0U0p6engxNG1QQWYvdXh2Nllpc3V3b21hVzl6?=
 =?utf-8?B?TitkbmEraEJZQjVNU0UvdWVMNktVZGpJYW45QnMwaFdPTmczbWx1ZWcyamFG?=
 =?utf-8?B?WU5WM0RvbTNZd3ZaQTFUOEdYdzByTGVtL055alRSQ0puSmR4c25OTWdHOW91?=
 =?utf-8?B?UGZnSHFUd3FJVEVWVGhiSkRWaHJBR0huZlliMWE4UkdYN1VEZGJLK3ZKaUlT?=
 =?utf-8?B?TnlMZGpwZlFSZnEreHlXanNQWVA4SGQvNTB3ckR2M0h1eFVaSk15TURoeEdU?=
 =?utf-8?B?bFJOc2gzeVUrbWxIbUVjZzkwM2xBUEZuYlBSNFhqQzdoNW11R3lTVktGcnBM?=
 =?utf-8?B?ZFpLNi9pZyt1eTVkR3JjTnQyMWorcG5MYncyU0dTRWhtZzRuMHo1VGx4MWRZ?=
 =?utf-8?B?UUtjaEowd2did0dUcmRqa3NaVDdhbVNpOE5nMmF1dnl5NHVxN091c2MzV3NY?=
 =?utf-8?B?eFJYR1hxd2RWN2o0S0NoTExHUU1aK1NQOWgrVmY1RWkzTDhLYnA1ZjRqNkZC?=
 =?utf-8?B?QUdUSDFTOW5PNWNyaGRCR3lYR2dCUVBvcnAybW4wVHhRQVZzSk4zWUV6c1lJ?=
 =?utf-8?B?NFU1NVkyMi9xZ0p4cjAyenRuL21Wa3J4WG9FT2QxRjJQdmZGTHZjOUplejgx?=
 =?utf-8?B?Ym9TUkJzRVRiTlhYTkR2T082VFFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7858C85A9847040AB7AD03D2C169AA2@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc586d9b-1701-446e-c088-08de2d1e0c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 19:00:21.4974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezC2yjGeuy556GjD7g6yRmJp17Y4MRhD4pXDsXNPKd3+ccWpCQuuEkjTa6d5xo/fr/Tnr4P+SbdRF5oXsPXk+telwHoSI3TUwcY/7go51BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9431
X-Proofpoint-ORIG-GUID: klme6A1PGAbpIx4NpWYFQs6ocBF8br4z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE1NCBTYWx0ZWRfX2lhuoj8Fst5T
 B8/ePhaj+f5BqHyj3lDNHI1GnvzvSa44HXvq5143C2tWm2VbdnvNK4L0dxjDZ7deqmOp6p6ym17
 7bS2Boe8sIAT9BwMLa9d2Itjw+P1U0VK4AJEvd52PpuFIA+4Is2VPG8wRJyIufBKbLs/Rm42bJO
 7I/OE6LRANrkKL9SNEDdxtXts33cOUuaUs/+2+Dk2CC3YzT50URAOg0lJEb5W9MqCNFFEmJJ85D
 tkDSkF4GFLRq/RQqTux/1GuS3dYuWs9h9oD1bY35HEiA4lthnYo6yUiGa1DvwBiQ2KlduPApIzQ
 Pr4qNoHRXVHaM60POgXvjkX3od6AmNpU3VxCNTnHCpqCJVk9UWSmFSq75zksVaVIYTcBCEufuL3
 xiIhF8uSUjLhBggCdP07dwFbNolj0A==
X-Proofpoint-GUID: klme6A1PGAbpIx4NpWYFQs6ocBF8br4z
X-Authority-Analysis: v=2.4 cv=aoW/yCZV c=1 sm=1 tr=0 ts=69274e4b cx=c_pps
 a=9EuSt69D/BPrFzR0fd2wnQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=rxWlj5PKuf2-wocvYvsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDI2LCAyMDI1LCBhdCA3OjMw4oCvQU0sIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBOb3YgMjYsIDIwMjUgYXQgMTI6
MTY6NTZQTSArMDEwMCwgUGFvbG8gQWJlbmkgd3JvdGU6DQo+PiBPbiAxMS8yNS8yNSA5OjAwIFBN
LCBKb24gS29obGVyIHdyb3RlOg0KPj4+PiBPbiBOb3YgMjUsIDIwMjUsIGF0IDEyOjU34oCvUE0s
IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBDQyBu
ZXRkZXYNCj4+PiANCj4+PiBUaGF0cyBvZGQsIEkgdXNlZCBnaXQgc2VuZC1lbWFpbCAtLXRvLWNt
ZD0nLi9zY3JpcHRzL2dldF9tYWludGFpbmVyLnBsLA0KPj4+IGJ1dCBpdCBsb29rcyBsaWtlIGlu
IE1BSU5UQUlORVJTLCB0aGF0IG9ubHkgd291bGQgaGF2ZSBoaXQNCj4+PiBWSVJUSU8gQ09SRSBB
TkQgTkVUIERSSVZFUlMsDQo+PiANCj4+ID8hPyBub3QgaGVyZToNCj4+IA0KPj4gLi9zY3JpcHRz
L2dldF9tYWludGFpbmVyLnBsIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYw0KPiANCj4geWVzIGJ1
dCBub3QgaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmgNCg0KSW5kZWVkISBUaGlzIGZlbGwgdGhy
dSBhIHZlcnkgc21hbGwgZ2FwLCB3aWxsIGJlIGZpeGVkIG5vdyBpbg0KdGhlIE1BSU5UQUlORVJT
IHVwZGF0ZSBJIHNlbnQuDQoNClNtYWxsIHNpZGUgbm90ZTogdGhlIHZpcnRpb19ibGsuYyBpcyBh
IGR1cGxpY2F0ZSB3aXRoaW4gY29yZSwNCml0IGlzbuKAmXQgaHVydGluZyBhbnl0aGluZywgYnV0
IGNvdWxkIGJlIGNsZWFuZWQgdXAuIEkgbGVmdCBpdA0KYXMtaXMgZm9yIG5vdy4NCg0KDQo=

