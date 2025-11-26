Return-Path: <netdev+bounces-241995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7DDC8B81C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA3F3B7360
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B433DEC2;
	Wed, 26 Nov 2025 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="BYeL+KwT";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Vx4ln1kL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C3533D6F6;
	Wed, 26 Nov 2025 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183542; cv=fail; b=uVo8e9cMC7rumYqCiTFDlp4SbL9lH4l0sZ5xf0rGmrCg7RES/I0PU6XcFh+iA8bTt9ILwCpG2gGQhdVxwUUdinNJFm9cVIREPa9Qy0APIhphDRX3C+acViC9RRysvAhQkHRZS1gMnugbc4N7a6ubpE1IuOxRSvuuMijXydonGv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183542; c=relaxed/simple;
	bh=VHI9QQt+P8hkuHmxvgHy9l+lTNSsl3ZtyoI7bebGlhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lIXYgnA0IzlfVasS7QrdmSjbRKso0S8wjOcog2UME1p9H1PBaiAqZNvWG2Cb5UPyKhAR1+MfPMlTqWUoLDanGiU1CoPG+j7RfLMzbj3A8iVOSQjT/cG6ThxhTbHsLSZoTUirIrJxNEdaU02iMgKafmmq+xFsBsMF0Ziy5upEvn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=BYeL+KwT; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Vx4ln1kL; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQErE281609269;
	Wed, 26 Nov 2025 10:58:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=VHI9QQt+P8hkuHmxvgHy9l+lTNSsl3ZtyoI7bebGl
	hE=; b=BYeL+KwTuF0PqiKcWKshBrE8UBxBKN20AFItw+PNC8oP/Oi4CWzYNBKOl
	NdT7lUzmMo782kfwUxFR7ymBnrUIGSO4CRSR8x0M56NuxR9dY+IfKcR8ej6hbRcW
	NfK5tjpHGA7ibkyKnDlgTN674DS2gSSd5WupiHGKdyKiRBjtlWLYl4uekGmWg5zL
	gwFmogRWWjXrU2fLAuknBhCMpjgujm25CwCkmcCvWADXVkMTU8KHvtcxUalG0xjv
	dPvE62MmwO0GQBcjPZrF6ApBhp4+ESeFvY6ti4c9UA3/1yT/UqhtmH3LiRxJpbPj
	+1jpIhM5bMsbrGx/3j/DhT3MKk7Nw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020104.outbound.protection.outlook.com [40.93.198.104])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ap3q2gg03-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 10:58:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiyTDMzDDB0LhmOI8eX9BfwNfjOjtBpRiSay17rU76/mZ1An9G3x4jMAnScSpbDqQ4dV8WGTQtBzs5fR8fHWTzSjiZwjl9jK0RSOK9CyXX32NR3VcX4qwiZCLAGnZwPiZHY22UMMesZTz8qvOP6iEqc47TouAHfk857k6QS/KCQiAVWeLJkME3sPIsLD02gj9F4rJA/o3yFyXAypKaYlMtnKaM4N86kSvVTJ40Sm+FSKy0oOoECDVoBooaPAyd0KlMs8pdNaMgAP2Vig12lEfH/+pzM3+wat56RDs92wbyrpet2j9Pg++9sYoiYzHHg2fXxZeuce8zrzPtksAacYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHI9QQt+P8hkuHmxvgHy9l+lTNSsl3ZtyoI7bebGlhE=;
 b=hrR2f4sAIJN66geq07cNWKGPYGNeCBOMGfVe7iKdSceRbUcEHskR5udScQ/Xq8vDrQIrqPmm7zk6ipb69q8v+C+E/Nx2QzE5oYT/Fxh2t/+ILAudCVjPa0aFcnLlrLiBEytIWEpniMTbZy3QP69XtJ+7yGVqwj8bWp8hNwjf1/dFQTtHKHnOgdm+ZP8MWwQIjmnGQH9W+2ytrwl2gMqmiZEmC6hPfeJQ4jyWy/MDECFKnryJmyDM3VZ0APeOD48IK/ptU+xNT0cIIbQFdiYp7er64squMD2sW1JInDvHjKHd+GVftLRFwUTxO/kzMUfA07tjHLDesdNPkUO2w68V0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHI9QQt+P8hkuHmxvgHy9l+lTNSsl3ZtyoI7bebGlhE=;
 b=Vx4ln1kL/1xJRVWD8f98treWs33U0pr47c/QFk+B+V1CHuye651VKtRCn9cHScYjmFDo3k1M/5vKaUO3jXMWLuarmqqFfnM7t0AarN8jCdQDLvv39GI15V0xUOTSb41jMg5xLPxZgiogoROibiHf1H4dVM1ZaqwPq+LtSyzKQFBzEtde20kotdzhivJr2KFJXnIs0RHpP8KxeYzT+gCYeWJxCfTv16cGLzzI8m2KPrTNtvn5nhD7WsUJrV32su3R/vSJSiveG70oc1KzAnTi9/m9FkrdE4q2bSa7lTDHVGOUCmI17OSP5ZH5AV3Q2bHzsvSqnf6f5FnJDDJReC7tXg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SJ0PR02MB7743.namprd02.prod.outlook.com
 (2603:10b6:a03:321::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 18:58:46 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 18:58:46 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
Thread-Index: AQHcXi4zHSZXDxRn7E2vwL8pjtv0WLUDramAgAAiWACAAP/7AIAAgPyA
Date: Wed, 26 Nov 2025 18:58:45 +0000
Message-ID: <5BA1686C-519F-4252-8D13-4A542A300B85@nutanix.com>
References: <20251125175117.995179-1-jon@nutanix.com>
 <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
 <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>
 <abb04d29-1cd8-4bff-879d-116798487263@redhat.com>
In-Reply-To: <abb04d29-1cd8-4bff-879d-116798487263@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|SJ0PR02MB7743:EE_
x-ms-office365-filtering-correlation-id: 869af4de-c1d9-450d-afe2-08de2d1dd38f
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkovMnpXaVFVWGJzR0V0RER2YXNrREN4VVE5clFhYmxydzl0dlBuZFhwbVQw?=
 =?utf-8?B?ZVZrRHIrZ0wwa3lLQkdITk1JZVlyZzRsZzJyTG1pMEk0SFNXMDJibzJJWDM3?=
 =?utf-8?B?ek45dTdSeGRxM25acytVU0JoUVErSFNMOXliVkV3TFJ6d1Z2OWFJK0dYVVBC?=
 =?utf-8?B?NWw1elBKeXhPajEvQVdJLy9wamtKZTN4UWZZdlNPOEJjS2NpR1ErKzhKbWR2?=
 =?utf-8?B?NEsza0VOcWdhNkhyc3h5RkdWK3hUUUpxd2MzdE1wMElKZi9oSXYra3FvdXZv?=
 =?utf-8?B?TXRtSHBjd254NWx4eklHNitiK0dBWjRpR3pka0pkYm5hdTh1cEpWMlBSSFJx?=
 =?utf-8?B?bmNWZ3VDV1ZvbUI0UlA2TGhIdU0zN0lwUVlCeEcwS09iN3hwQTArT2dNdWFR?=
 =?utf-8?B?bE5CYXNNUzNiUVoxMmFFNDFJdmU0S2xvWmNvWWJSTkVieWpBYW5lU2Q1TkVm?=
 =?utf-8?B?S3pUdU1zMzVreFp6TDUvMk1FdWlObHNWd3V0VlVWVmRsSWNJZ2lzakhmY3E4?=
 =?utf-8?B?N2Jpd3d4d3o3Ti8vcXdGQzVIdyt5VHYxYmVoMGZEamQ5NkNzY0N5Ry9ISE5W?=
 =?utf-8?B?dmtYM1dZZ0phUHAwQnd3K2FRVENOVzRsN3d4TzdJZzB5eFUxZlJ6bUF1LzVl?=
 =?utf-8?B?RUVXYkd1T2VTU1pXR3hOd015TGt4ZnA5d2hpcHhDaUJCYXNSVGttV3ViU1Vy?=
 =?utf-8?B?UWExTHpia3JxRGFuM21jZWhhY21Ub2xqMnpFVFVacklOcTJIejNWSTFGYW4y?=
 =?utf-8?B?a2ZtR29CcmJ6a3F5NVU5TzRwVmNYaWg2c3pNYUtOVnNGblp5STJubkxUdUhm?=
 =?utf-8?B?ZmowK2dnZ1VxTEtEMkh5cTQrbU1TZUdkbW9EM2E5VzgvU3o1a09QdUh6KzV5?=
 =?utf-8?B?VkVkVUE1dzVNaWpuemJHMWlJQ0Q4MWVFaVRMR2VwbjRyOFRaUjdPa0VpTDZU?=
 =?utf-8?B?L0Z3VERsalFQOHVSY29HbVM1cUxwbjdpYkVyVDE4YmtlNzd0SHNQRmxIamd3?=
 =?utf-8?B?RWxjZnh6VGFnN2xtWko2QUlRTHJCZ0hxK1MvYU1WdkJlWkVuTlpkTWZTSjBx?=
 =?utf-8?B?VHM2bzd0aTFYaUtzL3ZIZ21SK29wYWN3cTBzbkQ0czAzamRSWS9jakd3UXRu?=
 =?utf-8?B?UUM3OXZDWFdydGRFcW9wdm5ZcUkvRzJSamdkZmlLUlgydWt1TjgvM0tkRHk0?=
 =?utf-8?B?Ym1JYUEyZGlqM3JBSlNMSTJRUFpqUCsyYjhDaDFTY0h1R2hSNkU5YW5FeVVP?=
 =?utf-8?B?Q0NQKzZidGpRK0FqcGphVWNkTHJkN1dVU3VNRmhiRGlGMFE0dENhcVRXVGdz?=
 =?utf-8?B?SmdPMGFtUUhlYnNyeEs2UHlFRU8vWERKZ1dDMDhXZGNUSk82OW5KalFPK1cz?=
 =?utf-8?B?WnBUMk0xa2RlMmtKelQvM1dZOFcwNFk3blZCOGdQQmk3QVRWbjhUM3dsVU9p?=
 =?utf-8?B?U0IybWFRcDJpOUxWWm1hT0NEbXpCZHVhRDhwTzk5QTZ1ajdMWHJjbERLZWFk?=
 =?utf-8?B?OWxlMUo3anBPZkwvakNRQURrWE93ZFhnc0NUQlVRSVE3OEdhaVg2UGNOc1R6?=
 =?utf-8?B?M0p5dFJGRWZFN3hQSXBEdmNZWENGN3N2ZDRGOTVzWm9SdGFpOW5OTmJLc0Z4?=
 =?utf-8?B?S2Q4cmtpby9wN0R2RzMvdFhEejFpdkR0akJySGZOSldrWm5PTC9UZGtnR01n?=
 =?utf-8?B?RkhZdkNCaC82b2Vpd2xjSjUrby9TVE9DVzUrbGdzVkdQUi9BZmlCOXFVbWhD?=
 =?utf-8?B?K1RwbitVTkVDZ3lXRkpDUnZHVnNra3lyNnlaYjNpSHQrNDV0d3lXc1lTYVJx?=
 =?utf-8?B?SENURTlnbVVkaWlDK21QZTBhZlp0cDVnRkJxRnZqdllzbGhDamg2dE1UWFlY?=
 =?utf-8?B?ZkhMQldnclZGZFpGNEVLM0I3UGQ1NEN5UUl4eWthb2QxekhmVk1RcHRCL1VY?=
 =?utf-8?B?dEFHL001MDkvSWJEckdlYllkSVk5VExFcE9YeHUxOFFIQmNHVVh6ZEt5UVVh?=
 =?utf-8?B?R2V6UjFaTjhyYmhEZlVVN2pQRnRGUmZpY09yWFlPMTc2M1Q5Q2Q3NVdMNDl6?=
 =?utf-8?Q?1tCjUU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUxwa1F4SmJUaXp4SEFlZENtelNvdUhOZDZwc0tLSENPd200QTJwWXc1MEdR?=
 =?utf-8?B?bXZmbDlSekRXdnVraGorTHhnTFM2R2JFVzZxcVhFT1doYTA5VEpRWm5EQjVM?=
 =?utf-8?B?dVBqaC8yTG1nclpmMldoNnBsdnQwcm5tVUp1V3Yyd2wySWw5Uy9odnhmeWkw?=
 =?utf-8?B?dW8yNWVSbnRjUTJMNUxsSXN1ZFlTK2g3NXVQZHRCVDFCalpSV3JSTzcxb2M3?=
 =?utf-8?B?bkNkQy9MNWxkT0RLQnBtbTROOUUxOC9kQ2xzMGZjMVVPcyt3ck5WWEUwdlhj?=
 =?utf-8?B?NWN6eG9BdFEzSTBZbTZINDY1NU43ZjRzUnRsRDU4UDRrdlZkc1hrOXhha3FO?=
 =?utf-8?B?cC8wNyt3ME5Td0gvd2g0ZDkxVk9VMGN4d0ZkUDRnSWY1MXpweVpONzNYcXRq?=
 =?utf-8?B?VUZ3UyswaEFqVDRFSE8ydW1XYzMyUEZEcHNrZlJJZlFqa1JxWUU2U3Z2RGNq?=
 =?utf-8?B?anhBak1MczhvUVJyYS9wcmtpS3RpUFNzSi9DS0JFcWNEVGJOdTB5cWM0VGY5?=
 =?utf-8?B?eHFQcGxHckVickVoNk5yV2pRWVlmQWNCVjhnYkNFTVQ0Y0FuSE5UVjVldjZO?=
 =?utf-8?B?RWxISDhKOTBvSDFKWXppcVVreUhwaE5EK3VaOFRqTXRQNVg2VXhZaHhrUmky?=
 =?utf-8?B?cSs5Z1M2bzNCVkhSdVg0OXd6N1Jvb2NQRStvaFpndEM1N09PaDJUS3FxMGpO?=
 =?utf-8?B?a01BOU95cGIrQ2JNMkZsbVN5QkIvenh1ZmNhM1phQ29jaW1uWUlJUkR0K1Vu?=
 =?utf-8?B?YzA2amM0T2pLVDFOaWwvSkJIOVFwZWVwbldidE02R1k1L1JMYTQ3UzV1d0tG?=
 =?utf-8?B?dlFDeStkWVlyM0xyTHdwZ3poWVVCQWtYSG1Dbzl3dzZTTTVSY0J5U3BSM0xU?=
 =?utf-8?B?SXVwYU5BZXY0bXJKSXRKSzNsMDNLK2pRRGVZM1p5QzNPZDljczJIemJrNm9t?=
 =?utf-8?B?Si94UElPL0VZWmJXbjVnUHY0emdHUklwV3RyanE2T2pvYWpKakxydjMyTG1L?=
 =?utf-8?B?djVmN1BQK3hJblYvdVlQN0tleGxVdU5BT2ZZWVFlRVBad01lQzhkeHNaMFZq?=
 =?utf-8?B?YzdpcUs1R1dzbjdIMEh1WE5wMzhmakhDNktESFY4ciswNzZpQmRIamlnN04r?=
 =?utf-8?B?ZHFhengyamlQS3lYRW5VcUZyczFXM0pCNi9FQkZkQWJsZDg4Um8wZVB4bmN0?=
 =?utf-8?B?cllQV2NXSFpUK3E3UjFqYXpRajZTYndBcmVwMUNnb1EzdDN2ZGZaQXJUZ0JX?=
 =?utf-8?B?eWlSWFNxSDAxOHFBNWRnbEdCL29QRlhLVllVVFFlejZPcy9sd1Z1RkdXS0g1?=
 =?utf-8?B?TUJhYzNFY0M3dTVGaUZqQ3gxTWJjelo5elo2SHovU3BHSGE3QTBVWldSZnI0?=
 =?utf-8?B?TlRNYkYyYlNPL3NxNWYzWFBDS2RMc3hISFFvVC9VQXVVdG9NQjExNlVQOU1a?=
 =?utf-8?B?Qnk1TlMxMS84eEp0ZENZMmVzS3dRemhWbTFRT1ZMN0RpRFB5VGtSY3EwcW90?=
 =?utf-8?B?WEdEYnVld0FFOUJCUVZFNjJnZzMyVVRnK0FOd0o3M1l3QWc2TWlkaGxORWc3?=
 =?utf-8?B?QVJ2UU15MTF5WTdZMXlXMk5LdnVmNDB4TkN4VW1peEZaNzF1c1lOeGxaelB2?=
 =?utf-8?B?N1JzV3ZlZSs5ZHVWNFZhLy9ydTFJVlBiRFNMVys0OS9YSVpzOVp2VXdxUHpN?=
 =?utf-8?B?WmU3cTFaRDJscFF6UU1TZkgyMVBxSzJSb3lnbVBUNWRlaHo3UEczMU95eTM4?=
 =?utf-8?B?bHpZM1BHd1ZTQ1RZMTBIRzJmOTd0RlY5dnRFay8rZUdWazBiamJSejJDL2g5?=
 =?utf-8?B?dWxUSTFaWUxhcExsSWtTSmFXRDRlcFNDNm9TaW1ZRmthVVZOeG1wWWNKVVNP?=
 =?utf-8?B?RnNCRVlRQWVGSERoUHZDUXpoejV0dTZBNll4UjhMblBDd0FLd1BMMXZuYURO?=
 =?utf-8?B?SzJvYms0Wjk5OWZDZW44OUZFMWVyRENVMVZwL1FnRFMrUUloTVk4OFVvRzQz?=
 =?utf-8?B?a3lDQ0JqdnNOamtkNGNXRGpYYWowT0EwalZkSnQvM1g3d1pIQ2hoUTZOS1d4?=
 =?utf-8?B?ZTJpdW5zbWgwUCtobjErMXZaWmVJUU1kMkVIK1RmeExkVk5TclR4V1BuVmtG?=
 =?utf-8?B?MHM4SVMwWktOQk51NWMxcU8reDhOdmdsRzdiRVBUV1p0NE13ZkJkWUZVaGZr?=
 =?utf-8?B?L20zbVdUL0JPWnQxVEgxMVFrenZrKzFROEpTSUN3ejA5RzFTNmsyTHlhNTI4?=
 =?utf-8?B?anZlbmgrU3F5V1FHbjcvZXVQN2J3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B11C8D3692777340B7DF8E7F54F2B96E@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 869af4de-c1d9-450d-afe2-08de2d1dd38f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 18:58:45.9289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7le/uZn9XSa6cM1cmCYkRZhZ0XIbhNbl/CtrxychJMDUQ3MLTP23twYlHEK+VdVI6S0XqPzexMjMxo3yyXTS+lnJlTxQQbke3VMK8FsJbTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7743
X-Proofpoint-ORIG-GUID: h6DOvnfbG-X21JyQER9yxGk4RriRTrza
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE1NCBTYWx0ZWRfXxclSvOMdxOW+
 aQwHfRuTI+IbWhVoYBlnRQz4cdiIqq0JeuM49MiPt3oJ+a0cXSvr8BTMp23fjN4BwisODbEPSk8
 v5inOa/mYYHRPcGpmW/mmso5zOPOAmP1p6t0w1LGz//d4GZEE73uI6Zg350XEFq3YpV+56Awd4Y
 j2IJrMCNwM6hSB5bD3GIY5ww6TsvzEtLIhhPCIvDJr7ATrVloo6COgKbxxL6kd+/lQ5ihIw5GjP
 Y2fGJdHxdgPl7wla/A7MlZr4dpBqDRt3i1OLI/ed9YDJrpziVmj8v7Y7bXbPzkZ+/TwxZUjekHY
 9JMhntZEiJ3mQG2F2NnxIMTcKPWTcVy663FagoTbTMC1lVsn9plqTzW5kdEkR7Q+DWl7qCvzwxM
 39dYlG4hH4EIpFh53XycbkEKPTo8TQ==
X-Proofpoint-GUID: h6DOvnfbG-X21JyQER9yxGk4RriRTrza
X-Authority-Analysis: v=2.4 cv=aoW/yCZV c=1 sm=1 tr=0 ts=69274de8 cx=c_pps
 a=/l2LzaSN5HZ5zNViGO9i2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=SRrdq9N9AAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=nYhPBz_uwt14NN-kInkA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDI2LCAyMDI1LCBhdCA2OjE24oCvQU0sIFBhb2xvIEFiZW5pIDxwYWJlbmlA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxMS8yNS8yNSA5OjAwIFBNLCBKb24gS29obGVy
IHdyb3RlOg0KPj4+IE9uIE5vdiAyNSwgMjAyNSwgYXQgMTI6NTfigK9QTSwgUGFvbG8gQWJlbmkg
PHBhYmVuaUByZWRoYXQuY29tPiB3cm90ZToNCj4+PiANCj4+PiBDQyBuZXRkZXYNCj4+IA0KPj4g
VGhhdHMgb2RkLCBJIHVzZWQgZ2l0IHNlbmQtZW1haWwgLS10by1jbWQ9Jy4vc2NyaXB0cy9nZXRf
bWFpbnRhaW5lci5wbCwNCj4+IGJ1dCBpdCBsb29rcyBsaWtlIGluIE1BSU5UQUlORVJTLCB0aGF0
IG9ubHkgd291bGQgaGF2ZSBoaXQNCj4+IFZJUlRJTyBDT1JFIEFORCBORVQgRFJJVkVSUywNCj4g
DQo+ID8hPyBub3QgaGVyZToNCj4gDQo+IC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCBkcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMNCj4gIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQu
Y29tPiAobWFpbnRhaW5lcjpWSVJUSU8gQ09SRSBBTkQgTkVUDQo+IERSSVZFUlMpDQo+IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IChtYWludGFpbmVyOlZJUlRJTyBDT1JFIEFORCBO
RVQgRFJJVkVSUykNCj4gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gKHJl
dmlld2VyOlZJUlRJTyBDT1JFIEFORCBORVQNCj4gRFJJVkVSUykNCj4gIkV1Z2VuaW8gUMOpcmV6
IiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4gKHJldmlld2VyOlZJUlRJTyBDT1JFIEFORCBORVQgRFJJ
VkVSUykNCj4gQW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD4gKG1haW50YWluZXI6
TkVUV09SS0lORyBEUklWRVJTKQ0KPiAiRGF2aWQgUy4gTWlsbGVyIiA8ZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldD4gKG1haW50YWluZXI6TkVUV09SS0lORyBEUklWRVJTKQ0KPiBFcmljIER1bWF6ZXQgPGVk
dW1hemV0QGdvb2dsZS5jb20+IChtYWludGFpbmVyOk5FVFdPUktJTkcgRFJJVkVSUykNCj4gSmFr
dWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4gKG1haW50YWluZXI6TkVUV09SS0lORyBEUklW
RVJTKQ0KPiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+IChtYWludGFpbmVyOk5FVFdP
UktJTkcgRFJJVkVSUykNCj4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXguZGV2IChvcGVuIGxp
c3Q6VklSVElPIENPUkUgQU5EIE5FVCBEUklWRVJTKQ0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
IChvcGVuIGxpc3Q6TkVUV09SS0lORyBEUklWRVJTKQ0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnIChvcGVuIGxpc3QpDQo+IA0KPiBUaGUgIk5FVFdPUktJTkcgRFJJVkVSIiBlbnRyeSBz
aG91bGQgY2F0Y2ggZXZlbiB2aXJ0aW9fbmV0LiBTb21ldGhpbmcNCj4gb2RkIGluIHlvdXIgc2V0
dXA/IT8NCg0KTGl0ZXJhbGx5IGFsbCBJ4oCZdmUgZ290IGlzIGEgY2xvbmUgb2YgbmV0LW5leHQg
YW5kIHVzaW5nIGdldF9tYWludGFpbmVyLnBsDQpidXQgeWVhIHRoZSBpc3N1ZSBpcyB0aGUgaGVh
ZGVyLW9ubHkgY2hhbmdlLiBJIGhhdmUgYSBrbmFjayBmb3IgZmFsbGluZw0KZXhhY3RseSBpbnRv
IHRoZXNlIHNvcnRzIG9mIHByb2Nlc3MgaG9sZXMgOikgSXTigJlsbCBiZSBhIGdvb2QgY2xlYW51
cA0KYW55aG93DQoNCj4gDQo+IEJUVywgdGhpcyBpcyBhIGJpdCB0b28gbGF0ZSwgYnV0IHlvdSBz
aG91bGQgd2FpdCBhdCBsZWFzdCAyNGggYmVmb3JlDQo+IHJlcG9zdGluZyBvbiBuZXRkZXY6DQoN
ClRoYW5rcyBmb3IgdGhlIGd1aWRhbmNlIGFnYWluLCBJ4oCZbGwgYmUgc3VyZSB0byBwYWNlDQp0
aGluZ3Mgb3V0IGlmL3doZW4gSSBmaW5kIG15c2VsZiBpbiB0aGlzIHNpdHVhdGlvbg0KYWdhaW4h
IEkgYXBwcmVjaWF0ZSB0aGUgaGVscA0KDQo=

