Return-Path: <netdev+bounces-258205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIQqDE0ujGl8iwAAu9opvQ
	(envelope-from <netdev+bounces-258205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:22:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B20121D8D
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6EEB3032F7F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 07:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F5930BB91;
	Wed, 11 Feb 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="oeXaFhHK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FF2C0F69
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770794563; cv=fail; b=Dc64c74M8roHX17r5JOKAIyeXNgwjFNSWP+6ROsYbBKIKftoOZSPryl1Z1E5EDA5J45YsPhQQ6F68HbJJLSkmX5DPtPE3SbkMiXkoZFqEgk8XWjMBfRqzrpNZKLioiesqr7IZMbHsJZ9yjUKoI8hQtKFeBraLHNP3xOiDfUp/X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770794563; c=relaxed/simple;
	bh=OT1o++rHQEQR/SrYfI4VHzLrgJdKc1OSvNVk05URY4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tm0WSOOCpDAltfwaF0gpDeT/ug1ry8sy9EMrqXtdmdgAb5piLW9JS/TT1LUNuG5nkttom1JbOr0n2873FhopzC+rZ8gSEZLICBrqWlhCTL9RbFmKVXzuKhLTrZ2AR8s5fIERyB9qXEgnrWyb/LTjaKOsXhn+Z/DSG5wp+pR68QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=oeXaFhHK; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B5p9KQ3998074;
	Tue, 10 Feb 2026 23:22:24 -0800
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023134.outbound.protection.outlook.com [40.93.201.134])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c7s9cbwbu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 23:22:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7xujFUeqOmeNtKTiwfQEZIO7vjYn/ug4ZGjyRKFG6vZs6aK/V8noqHn3G5wdpjT0L5Z2vckcujHaig4D/A09LcQs+cRoollWUzSTH/Fd3dRaH/d7Dz19uxutjAqHwFawGBk6tYyDU/yPCqW3pSr0yKXvH8ZtGBWDxDR2UHHu/ECLb2ujpzsPYOCM3vifX5ptweOx/rPTRScd3OVPRZjn7U1fFtdH3FK4cxAy7Pr3wpBF82v4uSOP9aabpi8CEf6fNauOwCqu39wYopsozsKb/CzhoiwcUh5FF0BYigEcWAo4cjxDsrrBg67OnajXxgL/ZJ0RZJ8LtmjhPEPGgoQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OT1o++rHQEQR/SrYfI4VHzLrgJdKc1OSvNVk05URY4s=;
 b=VNVBm16PDXgRIz54GpBYcG1AcLwO4oSDaN3QxEOQIQwWOSwVg/UWYfYfxI00CTIJJVDC+EAHZuATPx7imRH7t0mgHh0LzX3w8NwsY+nyus+aIqNsrNud0dZ36NELUIkWwMRpyhjcyy3RDT6P1Xo9sHt6NZsCUvNtgWdg1FxMLA12csb5ybDfStIXjHqqjZkMQHUzMLOl3Ra+13mCN+4mEpGMkO/HbaMRZ3VFcPcJR5RpB20f4uEelhrqnGMY4RQUnFMSt0y6HdBGCQ3rkPJ0f7gcx0Rt5kZfIcSOUAPUdzbEE09nSPtFMjl6zkIngd1rHbbk2dqygiWT9IklgOKVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT1o++rHQEQR/SrYfI4VHzLrgJdKc1OSvNVk05URY4s=;
 b=oeXaFhHKopAow2iTFQGnISesGpvjMj/uMhYdcu9HoIJcvP3bDzWiNpwH7uI/5864BXYq639+Fv+OZlP73uwPIlUEQveh9gZUM2HpF6bks5MAsOJmpbLMPzVNY/T0ZYOWCEFPFk+MT1CRwQ8vOMGIgG7SoGh1gA0nQekYelhn1uY=
Received: from CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13)
 by MN6PR18MB5466.namprd18.prod.outlook.com (2603:10b6:208:470::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 07:22:22 +0000
Received: from CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::a4a5:2144:64cb:7fac]) by CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::a4a5:2144:64cb:7fac%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 07:22:21 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Nithin Kumar
 Dabilpuram <ndabilpuram@marvell.com>,
        Shiva Shankar Kommula
	<kshankar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 net-next] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH v2 net-next] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Index: AQHcl2Bnnph4NcKMQkKIjFDXE6aND7V1xIuAgAdZ0PA=
Date: Wed, 11 Feb 2026 07:22:21 +0000
Message-ID:
 <CH3PR18MB6379345BBFBBB72FCEDB81DBA063A@CH3PR18MB6379.namprd18.prod.outlook.com>
References: <20260206120154.2548079-1-schalla@marvell.com>
 <20260206095859-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260206095859-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR18MB6379:EE_|MN6PR18MB5466:EE_
x-ms-office365-filtering-correlation-id: e752057a-d3c3-41fb-a70e-08de693e4c0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?elhvclpRMVRHUHFhVURHbEJlVk9mdGp5bTlITTl2b2VwWWd5OHZEVUdJWjVS?=
 =?utf-8?B?bFdWK0Uvc1JFR3B4b1lYOThkZG5acWdFbUVqZ2JDaFhYdnJ2bThWVGhoUy9U?=
 =?utf-8?B?WDJyL2IxLzNHek9NRTk4ekVtZWpuVzMwbGlnZWVGbldGbGdNSEZRZmNBVjJP?=
 =?utf-8?B?M3Vya0ZjQTcydnRUVm1rNXpTWmVOZUJVQmRjZm81cmhYMGVUUFdnOG0yUG11?=
 =?utf-8?B?S011Y28waEVqM1lvNXZIUW9xM0lCdnN1YlE0SUtKYUFqZUkyend5b2tCYldI?=
 =?utf-8?B?K2JDOVhmdkJTNWR2TVVTNVF3ZkFUM21Eb1BjREtzTlNqNzA4bElDRmxjTlNv?=
 =?utf-8?B?S0wyemdZS0tvV3ZxQTRDdVNMZEZjQmNid09FY2kvMUdrMTlnL2xKQWZ0clo2?=
 =?utf-8?B?cWd4dEV1T0NXYnlod3ZHaENjSk9kK3BxRWxBMi9RRlFLalIxTzVmVnhLaE5i?=
 =?utf-8?B?ZG5PaHZYd0N5OEwrM09zdUNtNzIyTmN5bXg0QnhTMWRpLy9FSy9pKzFBQWFM?=
 =?utf-8?B?VVpEOGdUZmV4WUdtS2NPdGtjN2pwZCtWQUcyME5Dd1lUdHQrL1FwQ0hUYzRT?=
 =?utf-8?B?QWEvNzVwZk5kU0NXeVNNaWRiQ21QbmdqWTg3OXYyZVFjM2hGRUJaWlQ3WnU1?=
 =?utf-8?B?VXR3M3RYazQ4S1FyaHF4cmtHM1NhQkFud25PelVKRWs4VkEreFp5TWJGS1VV?=
 =?utf-8?B?cG1FTlV4MzdtenlUK3owaUk5dzQzN0Mvc0hSS1ppNGtHSDJscWpEOExqODZ1?=
 =?utf-8?B?ckUxWWJITjNlYk9pbjZvd0MvbUpoUDFhRmQrTzMyWjZXbjNRVm5MU0tHSWdy?=
 =?utf-8?B?SG1nZ1AyNEpmZEI1ZmZGWlM0QWlGN1hNL2ZJZk9kWjRVOGVxMXRqNWg2akho?=
 =?utf-8?B?SHZMUGJ2cFlVM2k5emM1dEJ4dUZFeDJ6Tit4eUZVTGVnUDhJY05iakdwM2tv?=
 =?utf-8?B?ZTcxUkM5aDNRN1p1QjlWRlNhREMvbHZDc2ttdXBzamNVSFpEc1RkLzYwZVhs?=
 =?utf-8?B?YlJuNUlMMHhWOVIxMFdtTStGbCtrVlp3NitVTkFCVzV0Z3h1SzZBeHV4NG91?=
 =?utf-8?B?dzc5S0MyRVJKMFlaUWVUSk5RZHJRR1R5cnZmUGNzVkpRZExma0lrY3JlcWVP?=
 =?utf-8?B?Wk5ISmxEVk5HM0lwa29tTzF5aE5RUkl1MWhTck1OQWJwK1pveis4Z0xEVDNU?=
 =?utf-8?B?dHhKL21UM0YwY0ZMTjdaY2Ezb0pJUG1aeU5sdXU0TG9Kb21CNXFxN2lnYStB?=
 =?utf-8?B?bEV1VzREMmRoUlppSkdGd1JnQ1R1UysvOStvbU5reXF2Q1NxYzhJeDZ2WVVQ?=
 =?utf-8?B?ZWJsTWtISmUvU29CTUY1aEVadWRpWEhUT25GWG5UNUxnREQxa2laM2VTWGts?=
 =?utf-8?B?anQ4enhjTWRjQzFLdW0zNm5wNC9zdU4raGRLcmxKekNYcUI4ZzYwK0tkVThw?=
 =?utf-8?B?RGkycUtLYS9tM3dWUkEvOGdHSDBRZ3o3NnY3eVFVcHpGa0hsVjJHa1UrcGox?=
 =?utf-8?B?Ri9JTXcrWnlmUkpleU5id2dWS0lEdkM3WTlQdEd4Yjg2WFo4Q3BMVHBtaWIx?=
 =?utf-8?B?VXliUUlybTEwVFFsSzRkZTl6NkpPTGNPTzBrM3lLVGhhWDRuY3pBYVJ0cXJP?=
 =?utf-8?B?Rnh4R0VMVnYva1FZc1N1OEJYem9XREN2a0FqMU93MmhvbFpHdlRSNGdIc2Zo?=
 =?utf-8?B?ZkVlSXJIait3RlpTSllrUFhPTHdkLzJlbGx0UWhHZDNYV3RnbzVubFNLQzM3?=
 =?utf-8?B?YVpldm5kclJUbGlsdlZqa3hnVVNKWlQ5dGY4RzJHWGg4N0VyYkVQclc4dmpB?=
 =?utf-8?B?RnVDcDQ3b040Y29uTFJwNGVoOVhPdlVvcHFGRmdOQnk2djZtODRPai9FQnBS?=
 =?utf-8?B?eG5JSmFZZCtFOUdtZmJBcFV6cjZuWWhyUDVXWmtsYk1OL3JPNE11U3JTb3FD?=
 =?utf-8?B?d21ZbWR3T1Nod3NIMlNrVzZSUWxEUHdEaDRzVzYyRXpyMUkrZzdKMTdaOGt5?=
 =?utf-8?B?blZlU04zZWFzakRHN0RTQUVIU09SVlNuRnFkN042dnZKdWJxTDA0cjErVkpp?=
 =?utf-8?B?VXpRNS9SMEE2UGoyTDRJN0dicXF4eGNwTGJHaHc2WlkrUlA2bGJ2Wm1hNDZJ?=
 =?utf-8?B?R3MrNU8vMTUxVkxWcjc5NnRrbnJRYXMrMkNHUjcwcklsaE5pNGhLUTBTN0pj?=
 =?utf-8?Q?UhhaMGS2U6oWwJQVpipyCPo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR18MB6379.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDJXaFBLSGxFZUtSS1N6S1N4TlpuSGZ0R2FMSEF6NWNsc1p1eE5nalpuQnNJ?=
 =?utf-8?B?cS9KSzhCVzFhWVkrU1RnMEdBSEtDbi9UU1VjL3NpOTBmNlFoMzVJbVcvTnJa?=
 =?utf-8?B?a1djNVJEdGtQK1I5R0J2NE9qNVpMazArUUJsemxHV2gwckdxempVbUhOWllH?=
 =?utf-8?B?QXFCcmhkVmhLVC9GRmlvdkNRdnliMXVYNVpPQm5zVFFoRWQ3MWEzR2t6cnZv?=
 =?utf-8?B?VGlVVVlGVGtIRDZrMi9XSnpQQ3k5Y2x0dUpNa0RjSzJST002bGRkMmNFZi9G?=
 =?utf-8?B?UE4xQjh0cmN5Sm5lUWVldHl2MksyVmtlUlViVU14RDFyS1hZbjhJeGtqUjU0?=
 =?utf-8?B?OXltczN0L2Q0b1NRM3pNWFltazBDWmJpbFBsa1pyU2hMNkRiNFcxTUxDUVQ4?=
 =?utf-8?B?Y004TnZqRk5VWE1uSExKZzgwY1Y5KzdsZ2h3VUs4MTlXblQxTGRNZVdMODBW?=
 =?utf-8?B?d1BiL1pvZlRnLzFhdDJSWDZFRHJUNndwaVpqeGcrWENpTDU4SnA2WmNGTWVl?=
 =?utf-8?B?QWN5WS9zVmtMaC9id2h3Q0dTalZ4STN2clA4MjI4WFFpeXppblhrYlhBWlFx?=
 =?utf-8?B?RTRNQ0Q0UGlPQU1hRU1LaDh2OEx2YlNXUjRsZ0VnNERTYTd5bkhPU2hOSjli?=
 =?utf-8?B?akFpUDV6TTh4bm95Sll4d0hOSlZnbWlnWkdoYkRQRzdKL0xTR3crendhTmZm?=
 =?utf-8?B?bFpHejQ2ZGtvTGRJa0g4azF2ZWx5ODVENFo1and6R0FVOElzOEJSN05LOC9r?=
 =?utf-8?B?bzEvUGt1VWxNWlA3dExmTXNBOEwwRXBxbjZsYThZbm9lcVk5cFdCTXJOeXJk?=
 =?utf-8?B?d0tqcUx1SXFpTHI1MU9BblNPNXV0cEE2aUVvaTBJZm5JZUU4QWd3NjV3MldW?=
 =?utf-8?B?em9Dc0NKU0Rlbnd2d2RzOUxpVHVsOWs2Z2Z4Nzg0cDYya1hZWktmeUZmTUZT?=
 =?utf-8?B?emUxWTBwaCtKWDg5NXZWVDdxUVlWRW1yMFVWNFEzQVhTQ2pydTcwaGwwMlg0?=
 =?utf-8?B?d0xWbjlvWGpDWUdoOWx0TlQ1Wi9jM0hPdVpZbHVUN2RIRUkrdVA1WjVrV29t?=
 =?utf-8?B?RUd2V2NWaWV2bjlEMTZvd0JvNUZnbXBIS3FremtKUVVSdkRNZ2FaU2JKOXRJ?=
 =?utf-8?B?ZEVBbjFRblVDekFYejhnQkZUd0J6Y2VQd1ljNFMxRW1FMU8rZjdUMVNKT0FK?=
 =?utf-8?B?RTlEcDJxUk9MWExFK1hSV05jZXI4UjlOOEwyVUk4d0MyMGV4dkVRMGlmaldh?=
 =?utf-8?B?TVJrNHBTTGxDbzlZODhtTmxWL2djdEtZZW9DT1ZxaG9hYzUxMXNkSk5ueE1U?=
 =?utf-8?B?OEdCTGNKSU03RmpDaHhTS0M4RVFPSDhGSFBxK3laOWRtVXp3WWMwZFYwTjRY?=
 =?utf-8?B?VmtkK3hscHpZVWNjRFdUWHBYakZvUlVYbURPTHQxQU9EK25ib3VyeDgxSTlX?=
 =?utf-8?B?TFlsd1p0YTNxS3VzTmdtVDlTMGFOZGc0M1N4blNNSlVWQlhoaWtCdmJSaGkx?=
 =?utf-8?B?aWlxOVVEMFVYRUZyR2tJd29NZHR4YW5oRW9LdzIwSnVjUHc5UlFkTU02OXdh?=
 =?utf-8?B?V0RpdnF5NWk0SlErSDRJTzlGcHZQekgzV1hTOUlKRzZaQXhZdXJ5TjhUZjlu?=
 =?utf-8?B?UjFGR0t6ZkkycUNIRmh2UWY0RSs0d2hUL1RGVWtIRnlSUUk3NXVnckRMVFBw?=
 =?utf-8?B?VCsrMk5YNXd1aU5wUlZEQjlWMjhaOGxTaUcxd05PMlNoUkFFNzhZcFB0cXA5?=
 =?utf-8?B?ZEUxbXJKdmltZVQ2aWcrZUxYV0lLRDg5a25vR2N0VHNHUzJ5T2ZJZjkrVWkz?=
 =?utf-8?B?ZXM3UUF6SDRQcjU2aTVTa0VtNENRelM1OGVERzhLU3BwdTJRcW5uVXNOTUQz?=
 =?utf-8?B?QkVoRytOMUJwZisvYmdGdXRzRzcwQ3k5cXFCVWVqOVcrc1F0SVZwa3Iwc0lH?=
 =?utf-8?B?bTJOQXJpQitMdjNBbUxHTlVKVEZ1Y1h2QWM4YWRIRTRrL0wyeCtCYzdNZnNq?=
 =?utf-8?B?RThVT3ZuTEZJNzdRcVhDU09DaTgyeDFSL2JHS0RhSXlTb3ExYUw2UEt4cWxs?=
 =?utf-8?B?VE1tVlF0S1NXUlphV2VSdzFPTDFOWmJaRkRTeTJhSVE3R0ZOb3lNeU40NWZF?=
 =?utf-8?B?L3lFTmN6b2dBWnNoWkw5OWM1MS9qcG05RGdpVGZvQytoTnVEK2tBY1dnelk4?=
 =?utf-8?B?NmxPMUp4dmNmZCtwY0tlNWZueWdTelI0dnEwak9WZ1RTZWNpak9VczBxd01B?=
 =?utf-8?B?WGk2eWQ0ZExCSDNFdlZWbkdOczFJT0hVNVp3QWJZU1NPNHNNdTVic2dML2hE?=
 =?utf-8?Q?1lu5gAhecCX+aaHfr4?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR18MB6379.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e752057a-d3c3-41fb-a70e-08de693e4c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 07:22:21.7590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k62U4iKyOknBuOKaIvP3dluRfsF5XjSoYVUiiJjUUZo9xWta7XuXSMwj3FKk4F3Q3zRkXSPWDdEAcMhkX4pewA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR18MB5466
X-Proofpoint-ORIG-GUID: w1XcHDEjA3KNIMRHtW-g7-QLHg5JJvtK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA1OCBTYWx0ZWRfX1XTJi9ur3cCb
 Hd1gzS0y+zOas4fco/zl9Kee/PO83Vyzcwoqyp5ZvQV+YsKkCz/DTELPuBWl587gIhNdsNJtF0R
 UlfGCmJ5rfYCYvwLd8F58U2/6bBS3/Szl5dOFs5VpolYnOjC9rsNVYqjGN/ZNZaziygnUMPP0dK
 VnDMkaaKaVu5Oa4U7SLBOhOIaX1/ydmChzn5ZgG/DuAv5X5NmF/E3IUx1B1MAsRoDfidfLO60ph
 xXMPAj3U3Lsi9A9wQlUEwnYy+NyjEuTSqxt7g/Vrs3tXjf5uKj7cOzEHRgklmUCgyaZBsW95UAj
 n6+6ZJwjWd+b551usv4zMcJz/cT0gEctgE1Dc71E0KnWirmZLW65Z562qMCp45urF92vb9d5Yn+
 aqVoyDJQzuiDsiQQCIbFrmADnKoNBw==
X-Proofpoint-GUID: w1XcHDEjA3KNIMRHtW-g7-QLHg5JJvtK
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=698c2e30 cx=c_pps
 a=kguG1nR2ma0GTtLk2h9wKQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8
 a=8HSx3qUl58l0xsFJnJMA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258205-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,CH3PR18MB6379.namprd18.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 98B20121D8D
X-Rspamd-Action: no action

PiBPbiBGcmksIEZlYiAwNiwgMjAyNiBhdCAwNTozMTo1NFBNICswNTMwLCBTcnVqYW5hIENoYWxs
YSB3cm90ZToNCj4gPiBSZXBsYWNlIGhhcmRjb2RlZCBSU1MgbWF4IGtleSBzaXplIGxpbWl0IHdp
dGggTkVUREVWX1JTU19LRVlfTEVOIHRvDQo+ID4gYWxpZ24gd2l0aCBrZXJuZWwncyBzdGFuZGFy
ZCBSU1Mga2V5IGxlbmd0aC4gQWRkIHZhbGlkYXRpb24gZm9yIFJTUw0KPiA+IGtleSBzaXplIGFn
YWluc3Qgc3BlYyBtaW5pbXVtICg0MCBieXRlcykgYW5kIGRyaXZlciBtYXhpbXVtLiBXaGVuDQo+
ID4gdmFsaWRhdGlvbiBmYWlscywgZ3JhY2VmdWxseSBkaXNhYmxlIFJTUyBmZWF0dXJlcyBhbmQg
Y29udGludWUNCj4gPiBpbml0aWFsaXphdGlvbiByYXRoZXIgdGhhbiBmYWlsaW5nIGNvbXBsZXRl
bHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTcnVqYW5hIENoYWxsYSA8c2NoYWxsYUBtYXJ2
ZWxsLmNvbT4NCj4gDQo+IEknZCBDQyBzdGFibGUgb24gdGhpcyBhY3R1YWxseS4gZmFpbGluZyB3
aGVuIGRldmljZSBpcyBtb3JlIGNhcGFibGUgd2FzIGEgYmFkDQo+IGlkZWEuDQo+IGNhbiB5b3Ug
YWRkIGEgRml4ZXM6IHRhZywgdG9vPyBUaGFua3MhDQpTdXJlLg0KDQo+IA0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA2Mg0KPiA+ICsrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMo
KyksIDI2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBpbmRleA0KPiA+IGRiODhkY2Fl
ZmIyMC4uMWZhNDE5N2RmZmMzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYw0KPiA+IEBAIC0zODEsNyAr
MzgxLDggQEAgc3RydWN0IHJlY2VpdmVfcXVldWUgew0KPiA+ICAJc3RydWN0IHhkcF9idWZmICoq
eHNrX2J1ZmZzOw0KPiA+ICB9Ow0KPiA+DQo+ID4gLSNkZWZpbmUgVklSVElPX05FVF9SU1NfTUFY
X0tFWV9TSVpFICAgICA0MA0KPiA+ICsjZGVmaW5lIFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0la
RSAgICAgTkVUREVWX1JTU19LRVlfTEVODQo+ID4gKyNkZWZpbmUgVklSVElPX05FVF9SU1NfTUlO
X0tFWV9TSVpFICAgICA0MA0KPiA+DQo+ID4gIC8qIENvbnRyb2wgVlEgYnVmZmVyczogcHJvdGVj
dGVkIGJ5IHRoZSBydG5sIGxvY2sgKi8gIHN0cnVjdA0KPiA+IGNvbnRyb2xfYnVmIHsgQEAgLTY4
MjMsMzggKzY4MjQsNDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdA0KPiA+IHZp
cnRpb19kZXZpY2UgKnZkZXYpDQo+ID4gIAlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJ
UlRJT19ORVRfRl9IQVNIX1JFUE9SVCkpDQo+ID4gIAkJdmktPmhhc19yc3NfaGFzaF9yZXBvcnQg
PSB0cnVlOw0KPiA+DQo+ID4gLQlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19O
RVRfRl9SU1MpKSB7DQo+ID4gKwlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19O
RVRfRl9SU1MpKQ0KPiA+ICAJCXZpLT5oYXNfcnNzID0gdHJ1ZTsNCj4gPg0KPiA+IC0JCXZpLT5y
c3NfaW5kaXJfdGFibGVfc2l6ZSA9DQo+ID4gLQkJCXZpcnRpb19jcmVhZDE2KHZkZXYsIG9mZnNl
dG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywNCj4gPiAtCQkJCXJzc19tYXhfaW5kaXJlY3Rp
b25fdGFibGVfbGVuZ3RoKSk7DQo+ID4gLQl9DQo+ID4gLQl2aS0+cnNzX2hkciA9IGRldm1fa3ph
bGxvYygmdmRldi0+ZGV2LCB2aXJ0bmV0X3Jzc19oZHJfc2l6ZSh2aSksDQo+IEdGUF9LRVJORUwp
Ow0KPiA+IC0JaWYgKCF2aS0+cnNzX2hkcikgew0KPiA+IC0JCWVyciA9IC1FTk9NRU07DQo+ID4g
LQkJZ290byBmcmVlOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAgCWlmICh2aS0+aGFzX3JzcyB8fCB2
aS0+aGFzX3Jzc19oYXNoX3JlcG9ydCkgew0KPiA+ICAJCXZpLT5yc3Nfa2V5X3NpemUgPQ0KPiA+
ICAJCQl2aXJ0aW9fY3JlYWQ4KHZkZXYsIG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZp
ZywNCj4gcnNzX21heF9rZXlfc2l6ZSkpOw0KPiA+IC0JCWlmICh2aS0+cnNzX2tleV9zaXplID4g
VklSVElPX05FVF9SU1NfTUFYX0tFWV9TSVpFKSB7DQo+ID4gLQkJCWRldl9lcnIoJnZkZXYtPmRl
diwgInJzc19tYXhfa2V5X3NpemU9JXUgZXhjZWVkcw0KPiB0aGUgbGltaXQgJXUuXG4iLA0KPiA+
IC0JCQkJdmktPnJzc19rZXlfc2l6ZSwNCj4gVklSVElPX05FVF9SU1NfTUFYX0tFWV9TSVpFKTsN
Cj4gPiAtCQkJZXJyID0gLUVJTlZBTDsNCj4gPiAtCQkJZ290byBmcmVlOw0KPiA+IC0JCX0NCj4g
Pg0KPiA+IC0JCXZpLT5yc3NfaGFzaF90eXBlc19zdXBwb3J0ZWQgPQ0KPiA+IC0JCSAgICB2aXJ0
aW9fY3JlYWQzMih2ZGV2LCBvZmZzZXRvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsDQo+IHN1
cHBvcnRlZF9oYXNoX3R5cGVzKSk7DQo+ID4gLQkJdmktPnJzc19oYXNoX3R5cGVzX3N1cHBvcnRl
ZCAmPQ0KPiA+IC0JCQkJfihWSVJUSU9fTkVUX1JTU19IQVNIX1RZUEVfSVBfRVggfA0KPiA+IC0J
CQkJICBWSVJUSU9fTkVUX1JTU19IQVNIX1RZUEVfVENQX0VYIHwNCj4gPiAtCQkJCSAgVklSVElP
X05FVF9SU1NfSEFTSF9UWVBFX1VEUF9FWCk7DQo+ID4gKwkJLyogU3BlYyByZXF1aXJlcyBhdCBs
ZWFzdCA0MCBieXRlcyAqLw0KPiA+ICsJCWlmICh2aS0+cnNzX2tleV9zaXplIDwgVklSVElPX05F
VF9SU1NfTUlOX0tFWV9TSVpFKSB7DQo+ID4gKwkJCWRldl93YXJuKCZ2ZGV2LT5kZXYsDQo+ID4g
KwkJCQkgInJzc19tYXhfa2V5X3NpemU9JXUgaXMgbGVzcyB0aGFuIHNwZWMNCj4gbWluaW11bSAl
dSwgZGlzYWJsaW5nIFJTU1xuIiwNCj4gPiArCQkJCSB2aS0+cnNzX2tleV9zaXplLA0KPiBWSVJU
SU9fTkVUX1JTU19NSU5fS0VZX1NJWkUpOw0KPiA+ICsJCQl2aS0+aGFzX3JzcyA9IGZhbHNlOw0K
PiA+ICsJCQl2aS0+aGFzX3Jzc19oYXNoX3JlcG9ydCA9IGZhbHNlOw0KPiA+ICsJCX0gZWxzZSBp
ZiAodmktPnJzc19rZXlfc2l6ZSA+IFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSkgew0KPiA+
ICsJCQlkZXZfd2FybigmdmRldi0+ZGV2LA0KPiA+ICsJCQkJICJyc3NfbWF4X2tleV9zaXplPSV1
IGV4Y2VlZHMgZHJpdmVyIGxpbWl0DQo+ICV1LCBkaXNhYmxpbmcgUlNTXG4iLA0KPiA+ICsJCQkJ
IHZpLT5yc3Nfa2V5X3NpemUsDQo+IFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSk7DQo+ID4g
KwkJCXZpLT5oYXNfcnNzID0gZmFsc2U7DQo+ID4gKwkJCXZpLT5oYXNfcnNzX2hhc2hfcmVwb3J0
ID0gZmFsc2U7DQo+ID4gKwkJfSBlbHNlIHsNCj4gPiArCQkJdmktPnJzc19pbmRpcl90YWJsZV9z
aXplID0NCj4gPiArCQkJCXZpcnRpb19jcmVhZDE2KHZkZXYsIG9mZnNldG9mKHN0cnVjdA0KPiB2
aXJ0aW9fbmV0X2NvbmZpZywNCj4gPiArDQo+IHJzc19tYXhfaW5kaXJlY3Rpb25fdGFibGVfbGVu
Z3RoKSk7DQo+ID4gKwkJCXZpLT5yc3NfaGFzaF90eXBlc19zdXBwb3J0ZWQgPQ0KPiA+ICsJCQkg
ICAgdmlydGlvX2NyZWFkMzIodmRldiwgb2Zmc2V0b2Yoc3RydWN0DQo+IHZpcnRpb19uZXRfY29u
ZmlnLA0KPiA+ICsNCj4gc3VwcG9ydGVkX2hhc2hfdHlwZXMpKTsNCj4gPiArCQkJdmktPnJzc19o
YXNoX3R5cGVzX3N1cHBvcnRlZCAmPQ0KPiA+ICsNCj4gCX4oVklSVElPX05FVF9SU1NfSEFTSF9U
WVBFX0lQX0VYIHwNCj4gPiArDQo+IFZJUlRJT19ORVRfUlNTX0hBU0hfVFlQRV9UQ1BfRVggfA0K
PiA+ICsNCj4gVklSVElPX05FVF9SU1NfSEFTSF9UWVBFX1VEUF9FWCk7DQo+ID4gKw0KPiA+ICsJ
CQlkZXYtPmh3X2ZlYXR1cmVzIHw9IE5FVElGX0ZfUlhIQVNIOw0KPiA+ICsJCQlkZXYtPnhkcF9t
ZXRhZGF0YV9vcHMgPQ0KPiAmdmlydG5ldF94ZHBfbWV0YWRhdGFfb3BzOw0KPiA+ICsJCX0NCj4g
PiArCX0NCj4gPg0KPiA+IC0JCWRldi0+aHdfZmVhdHVyZXMgfD0gTkVUSUZfRl9SWEhBU0g7DQo+
ID4gLQkJZGV2LT54ZHBfbWV0YWRhdGFfb3BzID0gJnZpcnRuZXRfeGRwX21ldGFkYXRhX29wczsN
Cj4gPiArCXZpLT5yc3NfaGRyID0gZGV2bV9remFsbG9jKCZ2ZGV2LT5kZXYsIHZpcnRuZXRfcnNz
X2hkcl9zaXplKHZpKSwNCj4gR0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoIXZpLT5yc3NfaGRyKSB7
DQo+ID4gKwkJZXJyID0gLUVOT01FTTsNCj4gPiArCQlnb3RvIGZyZWU7DQo+ID4gIAl9DQo+IA0K
PiBJIGZlZWwgdGhlc2UgY2hlY2tzIGJlbG9uZyBpbiB2aXJ0bmV0X3ZhbGlkYXRlLiBUaGVuIHdl
IGNhbiBkaXNhYmxlIGZlYXR1cmVzIGUuZy4NCj4gYnkgY2xlYXJpbmcgVklSVElPX05FVF9GX1JT
UyBhbmQgaG9zdCB3aWxsIGhhdmUgc29tZSB2aXNpYmlsaXR5IHRoYXQgUlNTIGNhbid0DQo+IGJl
IHVzZWQuDQpTdXJlLCB3aWxsIG1vdmUgdG8gdmlydG5ldF92YWxpZGF0ZSgpIGFuZCBjbGVhciBm
ZWF0dXJlIGJpdHMuDQpUaGFua3MhDQo+IA0KPiANCj4gDQo+ID4NCj4gPiAgCWlmICh2aXJ0aW9f
aGFzX2ZlYXR1cmUodmRldiwNCj4gVklSVElPX05FVF9GX0dVRVNUX1VEUF9UVU5ORUxfR1NPKSB8
fA0KPiA+IC0tDQo+ID4gMi4yNS4xDQoNCg==

