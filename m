Return-Path: <netdev+bounces-107446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2244F91B024
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB311284FC6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039EE19D071;
	Thu, 27 Jun 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="YKHweb+I";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="E75XuDLc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3519CCF9;
	Thu, 27 Jun 2024 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519030; cv=fail; b=J3coRvnjKtnaeTILFGzGjB92tWKRY5gRUaVdBWQtTQJT9CcSXMLiolYBxl2dftX2m7GtccQB0cOzuFj0g+7eYukHI7x4f6Qgco/Y7zReERDGWJDpioh7GDq0xbrYXp3HBaxMfLgnjSTQ1CpSPC4XeYBM8u5Kf2CMW0I9FS2twBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519030; c=relaxed/simple;
	bh=INFbhVDmoh9eWSjxaKVjBo3T+TcauqCpizSHpjtKazU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tYvkrLRgtY+PROaThnpRE4OB+WUeySgevSJseYiBC+Hp5QbJDwQQFF78x0HNTZQXDTy19HCw2S04Tg2KcELW03Nx9X5DiZirZ4xXklEWE44jSKVx8k2COGJCIOu2mUt96Hz7sTWuhaz3BhQAlEpQmLmiwng2J8q5Q3X3pESQYJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=YKHweb+I; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=E75XuDLc; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RJ0Qnb017158;
	Thu, 27 Jun 2024 13:10:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=INFbhVDmoh9eWSjxaKVjBo3T+TcauqCpizSHpjtKa
	zU=; b=YKHweb+Iu70+t/cKit5cC8PEaaJbZrpKApUXfMYXy+mXy8SZbGtzmgbt2
	ZjVLiXEWYkl68vhep6B6e9601aE8/5cPSO+H+TSAY5sjEkqMQdE5HTL4yBaKJZ57
	NIb4/+MFud6Dlm+H6ozIU3LfnAAz7ukUrOoQDYJ3FwsV7yMQBuUJgyJuwh3kf+6o
	z4HoAt52IwBE74V3GlzP0u+pDGS8QZmZ2ZSFcC+ugVht1yUfXh/W1du5+bWP+gtz
	sN5hdEE1Gan0a7c8tD8oBrUJWOinfhmdKq8c9Kq99Okqfeb5IB3l0ojSAmK1zwIi
	qVb8rKQowz9hjd89WXzWTeUls9cXg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 401dux04wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 13:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3fOVLPxRXhkF7ku0+fgEPlI/+teW5i7Ylui1Y7ShVzR+vls2EyaCNjHFMEC0ghIMqaVwzWFZ20i9beUSAqJL4E2AcxGwOU0XpAKnPMp3MbEg55dieKkq+1wb8ndeWBYS0kQxs4FEk46ncWmeNC9Kewrzd3L/Nk6/qVVDwsqhwtJbs6heu+SmdXZ5GZf8CCVe2s+xMiK08NQtt7z2L/Qjh0/zo1aOwir0A2JNkJUjvBabpqTVtJoKDL0g8Zt/zEDJM1KHmkaBsglCWt+k+ljHfiaM3f25v7MDOkNIi+6d7UBGvy98BK+5696jasNGdkCNOwbbuY+/gubCtWyGJyJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INFbhVDmoh9eWSjxaKVjBo3T+TcauqCpizSHpjtKazU=;
 b=dG9QV6H2j4Pa4sDnebNsbU+AhKeAd8xwQvqx570oKJR3cnlwkoDvoECtTcQDfz4HgMgMOj4CdAfpEJJ63Ji88weGhGAd+aDtZwAgbEBbDGyA1q+N6xwN+3e1ddoY13dRnaKnNTgBHW+iTRfb/UUuDm+wN6oco7dcMjM60fwpanfX3GjtNj/5+Vxt6sNEi9JDGDTJz6I08J7LwXwvZR8gxQdZDddEbJc1k0t2qbDFSQ1p4RTtotxz6vU7BeQQe7SghBGTNcVayZHO6yhPpRUAPTiUr646shzA222dPiZSZ3UDWxLnIxl2byfJLTMaHOqn8IAVYMb0NjlTnshndoxCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INFbhVDmoh9eWSjxaKVjBo3T+TcauqCpizSHpjtKazU=;
 b=E75XuDLcvAhOEgtu+b+OMzo7c5LGd1311UHaRYz1E3Pqs34et7sW3gZIG1oKRaAdlAnO88fd2LS8UpmXRlW58jZ+y9jpWImfKFCaRwZ+aNQ/oGahtS82ZwfUEFaxGftCYRKCaKBNimDCrXZ7vv88u+VLNr9hi/UQ1+xu/FrTS+XXohPSn/fBn4NRYY3wRi/QIjWTeHWuBW9gpNCOPzQIwd2hvVqh+fLjl+mAp8asOKJ50tVLB8aroC2rwPQ9DCvZ5/S7eLtx6FRgFl2HCUS+jNsBg+/NcAKG6lmBTj59rbCYAR9pawIzF10tP+6orPU6JrgFhWkkxJQNVZOSJRhC5g==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by CH2PR02MB7047.namprd02.prod.outlook.com
 (2603:10b6:610:85::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 20:10:04 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%3]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 20:10:04 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] enic: add ethtool get_channel support
Thread-Topic: [PATCH net-next v3] enic: add ethtool get_channel support
Thread-Index: AQHax2GUQxuaxfUwGUKTuKegLvYAzLHa34cAgAEtqAA=
Date: Thu, 27 Jun 2024 20:10:04 +0000
Message-ID: <EC0094DD-107B-4251-A4A6-AB0C77D6367D@nutanix.com>
References: <20240626005339.649168-1-jon@nutanix.com>
 <20240626191014.25b9b352@kernel.org>
In-Reply-To: <20240626191014.25b9b352@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|CH2PR02MB7047:EE_
x-ms-office365-filtering-correlation-id: 7ef3aedf-d166-4a3b-477a-08dc96e52242
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cXNWWDRmY01tR2V3RFl6Tkx0OG1ESEtTcUlWMEhWV2VlZVlMZlFJYXllY3Qv?=
 =?utf-8?B?TXFTcXFFa0VDeHhSUms3aEk3UzZ3QVlncUxPdWtOS2M5a21SWFkveTFYSUcz?=
 =?utf-8?B?VXpwM3ExSlRGb2o1N2EzV0dPbGZUV3IxNnRmeHRIQmRBcGxHQ3owZnBSVXFv?=
 =?utf-8?B?YWlYcTh4bSt0WmpWZGlrSEhDMGlpVktKREpyZTdnK3MwelZCZzNsRzVJTkNq?=
 =?utf-8?B?MnMyNC9UZGJVWStaUzdCam9idjgwT3hmbFpPc2ovbERhUUYrTlA3R1hDcnlJ?=
 =?utf-8?B?djJTQkplV052M0FTcys5cUR6TUhFVGozc0M5cG00bkh5Z1N6RVlaNHFmd2c4?=
 =?utf-8?B?bkI3WUdBQjFqbWx4djlhVzY2c05wMFVKcy9yWUQ1WThEUUdpNXUxeitqd2N0?=
 =?utf-8?B?UEdUcWFIaVJGeTZBYk1DNWRkR1E1VFRySFpRZXlCcUZyMk9uRlJKMDhtQ3Uv?=
 =?utf-8?B?eWlEeWdsZDluS0FWaXg2Z1dOdGVwN0pLcTlZVkIzUmlOdGZrUmlMR045N0dy?=
 =?utf-8?B?L2dCVXVIeHh2QzBsaGJFRkxrdUpMNHpnMk90V2lKSlRmTUlkTURwdno0YzhR?=
 =?utf-8?B?d1ZlNHFIZ21HSTBOVHZsL1k2bkQvWTlWS2hSeS9xeC81dXN6YU54ZlVJMEln?=
 =?utf-8?B?RVhtL1JmMEZOQ3dCTjFRVFdNakd3dmhMbFZoN1ArWW1RNGxiU09JRDhsbmhY?=
 =?utf-8?B?b3FwM01sWE5LcUhHR3RHY05RMXpCQzdyV2NiL0FZdVpwNzRhZXNBNDBTNjFD?=
 =?utf-8?B?WjIxOUF3Y3g2UUNhVlpPNGYvUE5MaDQvZFZjNURVck5qK0tSR2ptbmFBRy9C?=
 =?utf-8?B?eWgxTkRNTC9PR3ozRG9tZ1lKM09scXpTWUpuLzk4UG5WQ1RpUlJyMkhuREdH?=
 =?utf-8?B?V2xrK00zalY1ZDhDWmdwSHkrQS84azJVaHFGU0sxTnZLcDNLTWFTMHc0NDVK?=
 =?utf-8?B?YWd3dEpmTGYwWlVzcDQ1cjYrRURMS1M4K3E3K2tQWjlERG9NVVM3Z2dPazBN?=
 =?utf-8?B?YVN3Q0JRU3JkWDFkYUYvK2UwbEJRa0tlQjVVRkRtRnp4bHN4TTE5YTAwMkE0?=
 =?utf-8?B?ZkQxV2JNNFFObkNLbmJBYkhiZk1jRjExb0o0RGdTK1hvSXB5dVQwZEZ3cUR1?=
 =?utf-8?B?bU9FSjM4QTJWSHh6KzJsRFhoU0tXQzg0WHQrNlAyaHRBZGZYUFluQ2l2NWx4?=
 =?utf-8?B?YUhRKzlseEE0bWNlSklBZTY3VlQrR1AyeEwvc1RDeEF1ZXRrbUdqOERWaENw?=
 =?utf-8?B?R1VkOGl5Q1c3MGlnWWs4UWFLdWd1WTIxSXhnUDBtRlFlVndDNGRZSTFLcXBV?=
 =?utf-8?B?K0xObEJzeWlpY2tvNThiRTBMYUhxeUMrcWZad2ZtYnJURCt0dFpkUlYvYnNm?=
 =?utf-8?B?THprUE5mNjJjOWhkdER5OUJDUXIrbmp2WGgrVVFNdkIxVTVzVE9TSG51Y3Ey?=
 =?utf-8?B?VXljLythMFpzczRaOEl4V241L055d1g0WWpYOFZsVUt3Q09VSXJyc3NQNGNa?=
 =?utf-8?B?Y1lMVG4zWDJQS1pLck1SN1NNajdsSk53eWFTOWhwUVFuMmNNcTVzYjBBbE9s?=
 =?utf-8?B?OEpjTU5tQ1NWNGpHUGVKMjBraGpaNmtNNnRJditZS2laeURxbjMyY3Q2bytC?=
 =?utf-8?B?Rmx4Wm9mOGRSTDBkbFRNMlhTem42Umo2VEV3MHZRenJReVZoeXZlNXA5enhk?=
 =?utf-8?B?YzhONEsvT2lxSEVuL2lOMDZJUnNCRjNlZW5aYmRVK1VkMnl1ZDIvRnZXOWVh?=
 =?utf-8?B?Y0tELytBMmNXQ1RVdWt2LzhsTkJOQVh5RklUR0tBMklRUWI1QmRIZjNVMEJN?=
 =?utf-8?B?L2hPcTJ1Ny9wN3RiSVM1eFZMNEovV3NRcDFzZm9wMlJjQWMvdHJGeE9vcExZ?=
 =?utf-8?B?eDFMRGpHQVBydjhhNjFUT2RuKzJncVN1V0xBT0Q5anEyYVE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QzhWcllxSUczeWtkSGswZm1mWGVHc0ZJMXU3UHR2cVVJcERnR1diWGNBeXpI?=
 =?utf-8?B?YjVqQ2NMOUdndFB3aG9vMm1lV1BNQ0IvaVlpcVhTRTR1eHJ1aURXS215aHhC?=
 =?utf-8?B?clo0TUlOUmY0UzBRK0lKaE1jb3pmTGdzRGFhYW4yQThDM1p6L2pHUFliNnpK?=
 =?utf-8?B?cGNkNkthREFWVUs1bkRobjBvMTRRZ1NNeDVFVUh5MldZbXBZSDJqeUVsMC8r?=
 =?utf-8?B?ajBiSGg5OVVYWHNoSGxBRUNDMUVianJXWnVLZmhpVExodVNPaGxGNHQ3VnI2?=
 =?utf-8?B?d05wUVR1dFRORlZRdUpabE5LZ0htWnN0TGlBYlFwWThqYjI4VlV1QWlrV1JS?=
 =?utf-8?B?bmswTC93aGxUVUVtVkN2ZTBvcWNxUnkvWEdtbmwxbVdLcHp3N1JBNXdBd2RF?=
 =?utf-8?B?UTJTKy96Tkw4OE90NzFBVmRRdjdFbzMwWldoTlhDRUJTOWx6cHFIOU9YVG45?=
 =?utf-8?B?eFlDa3U0dGI4QVZydWdhTHZZZ0Qxemp6NEZBRGpRWURkZ3p4UUZXajBSOUE1?=
 =?utf-8?B?VWZOdVdmSnJxMzhrVkhvNHl4d0V6WkN6cmlBdVVXMGp2TWJGcmtuSVJVVUVQ?=
 =?utf-8?B?TUdXQS9QYncrVVc5SCtjc2xqMUJoNmpwMnBrREh5YUN2eEgyTllDc2czOGFC?=
 =?utf-8?B?OGFKRlhuMXRHSk4xc2pCWi9odnBiTG9mNDhrSXBHMlFIUTJIMEI0Z3duTjVP?=
 =?utf-8?B?MnEzS3FMOXpYOGU5TGxaUHJjTkxKYW9JWjJjL1JKRWhKWjhOS0hkeVZaZGtJ?=
 =?utf-8?B?ZWpxUGxRRTF2cTcwdHB3N1JxM1VRRkU5cWM1ajF2dFMrTVZYeCtEcVVVYVlK?=
 =?utf-8?B?T25ZOVlQTlNvTFhyS2xRWGRpZUh2QXQyUEdTcENiVFBEbXFSemlpVnlGeEYv?=
 =?utf-8?B?SGlzeFVPcW9hZjhzYnFXWk9zYndyUVhyTnc5WkdjSFpuM3lWUEJMYVRmZ1ky?=
 =?utf-8?B?aThBaE42RjV2T3RuR2N6amc1OHpMTmp5UFdTeDBteWNINHNkVU53bHN3cEta?=
 =?utf-8?B?MG9Jc2lhUjkrR0R0OFZ0WXlpemlqWlRYQVJjaUlkTEZ4UTBNOEdsN1FoWUM0?=
 =?utf-8?B?T3dlMDZGK0dVamJCcEdJM2wyYW1TWjQ3WERZL3FyeWtGaWgzNm4xS3N0aFp0?=
 =?utf-8?B?RmFNRHFRS21HdXdtdXk4YXRkNmRvdDZSRDhDQkthd2dmTkJpNUZLSjNzNTFZ?=
 =?utf-8?B?RU9za2hXeDVJUW1lU2c3TVJOcFo2OUZFKys2MDZBSDk2OC9ZZUcwdlh1S3J6?=
 =?utf-8?B?SXZCN1RxVUxjWEtQaXE4Ynk2T0NIMjJqay9JZ1RzZGZnZldvTUx6ejNEM1FK?=
 =?utf-8?B?VDVjMDExSXN3V1FOcGxaUmFhTXlUamN1elYxZWh3MWthZWJ3R1V3cjFuc2Ju?=
 =?utf-8?B?R1RYRjZrMmFlQ1lDTWE3c2F1Y1FrYy92R2tReWZCUWdjTFV4am5WQnNVZ1Y3?=
 =?utf-8?B?a21zWTRzWXFLYW1QaUN1RVRXaWRxaHJRZDI0VUptSGh2YVNqb2VWeWNYV2ps?=
 =?utf-8?B?TERaWEpVZEp3N3lwTGs1WlBzdDdhMGRVYUVqUS9ka2UzR3gvZ0E1NmVqV1hJ?=
 =?utf-8?B?UzJtcnlVVkRKaERkNnZJUXVDTmlXTEw2RTg5emw0YzVZRFZZTm5hU3lnZnFR?=
 =?utf-8?B?T0JCNkdIVlJpZG5uaVZQVlNNejdWWW1sM2YrWUJaZ1Y4ekZoa0FNZVRhVXND?=
 =?utf-8?B?M3MyRHdxUlBHSGM4dFE1NHFaRlpUU050WDVvekg3V2lHNStKTGpLN1hlWU9B?=
 =?utf-8?B?SFFPOEdmNEFrZTZibHJZb25IQ3R1NTREaFI2T3ZEYzcrT3lVYTJ5bEtLcEVa?=
 =?utf-8?B?YjFLNU1RWjNBL0t6SFFiUjBkTDNDb2M4ZDR1eTB4emkrZXpJNVo4Y045dTRN?=
 =?utf-8?B?cGtGYXJqVXFnQzkrNC8wc25hM2I4eUlkbWk4L1VoMFNtVVNqUGk0T1FHcXFQ?=
 =?utf-8?B?MU1ieWExQ3F1bmlKK3E5VjlMUGxpWUN0OTJhN3NHanR4MExaN2ltZCtLVXJQ?=
 =?utf-8?B?aWpLSjUvcGRyRnFLTk11UjNJd095WDZTQWZrZTU5NXUxWWhNV25pMVZMb3VE?=
 =?utf-8?B?VnV4dmhqK0JKRlJncU5jQ3NKUXc3bVVMQjlyQjhzSExXd2JWMmt4MlJ6RVlw?=
 =?utf-8?B?M0tyc1hmR0xpZytXYXI5ZVNnbFpUaXowS2dNRjBTRjlzWGRSMFBtTkJGUWIz?=
 =?utf-8?B?eDcyVDRaamk2SkxJSU9SLzdMd0E5bkhrUkF1YW54TEgyc1lDcGRBMmVkSnNE?=
 =?utf-8?B?c2tSRFQ5dU9xWEFiMkdYbG1RV0ZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7BD8F840B1F784E9DE8C66E5D9A7AF2@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef3aedf-d166-4a3b-477a-08dc96e52242
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 20:10:04.5710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcPYYr3VcyUQT3C1GOiYjCXxbgVEypl6Pm9yliLwdf3q3s9r/EunAdu/6ytEYGnm2b6G1jOl9D5FgDkdOaqSOIPB/u2Y9fj1tvN5qxLN5W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7047
X-Proofpoint-GUID: I2hM6hzVhI9fiI33VXYxnNPPPARKltNB
X-Proofpoint-ORIG-GUID: I2hM6hzVhI9fiI33VXYxnNPPPARKltNB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gSnVuIDI2LCAyMDI0LCBhdCAxMDoxMOKAr1BNLCBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjUgSnVuIDIwMjQgMTc6NTM6Mzgg
LTA3MDAgSm9uIEtvaGxlciB3cm90ZToNCj4+ICsgY2hhbm5lbHMtPmNvbWJpbmVkX2NvdW50ID0g
MTsNCj4gDQo+IGNsYW5nIGNvbXBsYWlucyBhYm91dCB0aGUgbGFjayBvZiBicmVhayBvciBmYWxs
dGhyb3VnaCBoZXJlLA0KPiBhcyBhbm5veWluZyBhbmQgcG9pbnRsZXNzIG9mIGEgd2FybmluZyBh
cyBpdCBpcyA6KA0KDQpBaCwgcmlnaHQgLSBmaXhlZCBpbiB2NCBqdXN0IG5vdw0KDQo+IA0KPiBk
cml2ZXJzL25ldC9ldGhlcm5ldC9jaXNjby9lbmljL2VuaWNfZXRodG9vbC5jOjYyNzoyOiBub3Rl
OiBpbnNlcnQgJ2JyZWFrOycgdG8gYXZvaWQgZmFsbC10aHJvdWdoDQo+ICA2MjcgfCAgICAgICAg
IGRlZmF1bHQ6DQo+ICAgICAgfCAgICAgICAgIF4NCj4gICAgICB8ICAgICAgICAgYnJlYWs7IA0K
PiANCj4+ICsgZGVmYXVsdDoNCj4+ICsgYnJlYWs7DQo+IC0tIA0KPiBwdy1ib3Q6IGNyDQoNCg==

