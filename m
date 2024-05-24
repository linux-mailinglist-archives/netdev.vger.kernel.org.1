Return-Path: <netdev+bounces-98044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B09008CEBE5
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 23:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F00928291F
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7F7350E;
	Fri, 24 May 2024 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="bjyv30UI";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="2qw+CjQU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00183b01.pphosted.com (mx0a-00183b01.pphosted.com [67.231.149.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A97494;
	Fri, 24 May 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587165; cv=fail; b=Rfuek8J869MAocQ9vaEjz19s9hEnCcADjQHEQyn37Qxh8Kpivhgprz/KDIVoZyF9wCZHhQ4whPOAJGmGeeJXQ8VnEXpUiBTC8KEqh3AmTz6A/IjFVWurbUoK8u+tSgQi2XTTJhlbyDw8xk/o7Z1+SaNR3VaBDAfdXhWIo3+hJcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587165; c=relaxed/simple;
	bh=se2Msg9wcHPRTrMqpd4IV/AD5xcvlOlMgPXi+S9Jk+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eRYM4cEp4TWvC7OvagNWFIBOAuBepAZnwqHQoBpY38TFBsgrYgSVYQt3pAelj0kMhno8LWtmIvJ7+pei+YmpjYkuL/Alz31QaeqE7e24qB4exOa34cjZytH7g3Jzud3XjNU7G4bZ3mLyQ/+t+LBtKsqlYFqknitVHv6xX2RT7P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=bjyv30UI; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=2qw+CjQU; arc=fail smtp.client-ip=67.231.149.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
	by mx0a-00183b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O7ght6011239;
	Fri, 24 May 2024 15:45:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pphosted-onsemi; bh=se2Msg9wcHPRTrMqpd4IV/AD5xcvlOlMgPXi+S9Jk+Q=; b=
	bjyv30UIpULw3tnqbwGioZWkzKmCNQRdz58g3YJOIMaa905tWltIjEo12BT1Cgvs
	5G8OjaeqHqG48N8TCZv8k9jIO5EroRHgXRhQknnHGZngzD6KyuC3jeSa99sQchwY
	bXwyyOhk22j/nUhzhzktjjOSXYJCbnkklT0e/5+K9N6TxGyiBmllhjZ4GgFnyFZ1
	juyxzrtmCJ9AkbPaYfIrzUK0J0YNMmTRerrofWFxh562sojZ4PELc/VHfMsPlGj2
	J64n/0Se8IrjWSTE0BDJ/j4E87iJL+nZ9syoETLJHRNdqoGYqDaQHWIXSpYcMIDe
	7DiXBrlMkTf3lR7Zj1HzMg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-00183b01.pphosted.com (PPS) with ESMTPS id 3yaa9vu04q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 15:45:26 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vma2UaYq56EAWoJPuEfzW1iFrLCH++jsXfbq67c4Ii2h6TXXNGd4DDaEuwmrVgPSlISdTzt08flxj5XLESXrtYGCCOTxQADgw4P0EQC52yxxHVNqekbNDdGwu2dd6NaBrDbam9LtMNaz+okbFdJN0AigWvNgKQG1XMkP5byie16w6RZB2+IWIUfPQjFsd1MSeCxRupwfztmtO0p72FTPvVr1q4bOrxjeWo45qshaYzbcFZRKJE3YCJB0LY3HydK4/rztURrMvExljkDYBMA+0Ujr5fyiz+zCxglGdUVaoBqB/zAbsrulRLn/8bziEKcf3K3VECII4/L9uMnWZ26HDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se2Msg9wcHPRTrMqpd4IV/AD5xcvlOlMgPXi+S9Jk+Q=;
 b=W2e4g55hnsWzl9pwy6s0XG5IfxFyW594f3dBiazc/Dtoln4JrOJO3QraTG0QWc5FEQC6rwJPesezZSDOM28eGQfoYU3G3TQxjaNXiF4xaAVRM7+5E125Nt8kOsglyDkuTuHUxwS3yY4VkOOwBA6PnkrbXgJWvocC3ddb+J/3nSeoWmodYN+oymE68bmJV+UkIlGcxX5ALoOONgycpjnkrbCOORF7PaN8u3MFGU9LLBYC9O/UpYj9YyAIosb6bAtstEiN7H3O4nuppwQ6KsrYl0nSirjDPLp2X2JvNCWTczSTC5YTggoqQrqsZ6gexh16hdYXdwAAlEzueU7we3sOvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se2Msg9wcHPRTrMqpd4IV/AD5xcvlOlMgPXi+S9Jk+Q=;
 b=2qw+CjQUl/edKU4cagvVAwUzDUyb/+hxCPhxOF08mn1L0hew8/0rij6/HypeUWtQIw4tGAR1UifEdGHIX0XLb2odfwQw8QTd9MTRRk8DYf35YqGpUwPn2Hf/zP8Dg9m713Muttl0SGr+KU49GALiiRyW2ZUTjdoTTglHJmmFP+c=
Received: from BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 by SJ0PR02MB7261.namprd02.prod.outlook.com (2603:10b6:a03:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 21:45:22 +0000
Received: from BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47]) by BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47%3]) with mapi id 15.20.7611.025; Fri, 24 May 2024
 21:45:22 +0000
From: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>,
        Selvamani Rajagopal
	<Selvamani.Rajagopal@onsemi.com>
CC: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "saeedm@nvidia.com"
	<saeedm@nvidia.com>,
        "anthony.l.nguyen@intel.com"
	<anthony.l.nguyen@intel.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "Horatiu.Vultur@microchip.com"
	<Horatiu.Vultur@microchip.com>,
        "ruanjinjie@huawei.com"
	<ruanjinjie@huawei.com>,
        "Steen.Hegelund@microchip.com"
	<Steen.Hegelund@microchip.com>,
        "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "Thorsten.Kummermehr@microchip.com"
	<Thorsten.Kummermehr@microchip.com>,
        "Nicolas.Ferre@microchip.com"
	<Nicolas.Ferre@microchip.com>,
        "benjamin.bigler@bernformulastudent.ch"
	<benjamin.bigler@bernformulastudent.ch>
Subject: RE: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: 
 AQHakZAxosrycArunkaHEujJo3A4abF0voeAgAA2YYCAGHiwAIAAQuMAgAFPWgCAAH78AIAA9q2AgBaf7QCAAAnBAIAAAr5g
Date: Fri, 24 May 2024 21:45:22 +0000
Message-ID: 
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
 <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
 <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
 <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
In-Reply-To: <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6786:EE_|SJ0PR02MB7261:EE_
x-ms-office365-filtering-correlation-id: d538e8bf-fbf0-468b-7f86-08dc7c3ad04d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aXdXK2NTbmEzNEVSY3Npdk1MazhQemFIK1ZkanMvQm90UDFXNk1HSnZ2Q1Ay?=
 =?utf-8?B?ZHl1T3U3em50V2JhcElmOWVyMFpZdnJIdFBHOHRVMENFNG96OHNYaHQ2cmFs?=
 =?utf-8?B?d3JJcm9OaFNDVFliWjl0RUJ4RUc1bVdGUFpRMlRXRk8yVTJEWEprcllWaDFi?=
 =?utf-8?B?TW03dHJldExhRVJ5aW05Sm8vRHN3WEkwdmZ2bm42MjFTL3cxNFNrN2JHUFVo?=
 =?utf-8?B?SVkxOEJyOEk0Z1UyTkJ0UGRiUFRMWUJ6WU5lRFhXVFNBV3JiakpXWFpkZjFs?=
 =?utf-8?B?VDduU0R1UlVncnhvZ3poOGVEdUJteGNGd3RsYndzQ3BlZ1VsdW1saWFkMUFB?=
 =?utf-8?B?SjRnSk1GR1RUb1hlRWd2WloxYmdkTFNLZWpDa3BIT1M3cnkyeENsakYyNWg5?=
 =?utf-8?B?bmE4VS85N0NpdjBvSFVrZ2lqWWdJUTBFNnoweGd3ejNVZWpYZlppL0JTeE9J?=
 =?utf-8?B?VHp5Z2xhLzRyVm84Y1NpVzVMYTg5UlBnL2RMenoxaXJhU1AwVGVRS3k5Nm85?=
 =?utf-8?B?cjUwUEFhWDBYR09rTng0eWs5OGtPbXdoWEVXLzdUT0tBNjVIZkh4Y1l1cmha?=
 =?utf-8?B?SDhNNzNFNTNKRVpjWXI0WHk3V01FZWd3a2IyandTbzZ6dnRNaElLS1kvaG9h?=
 =?utf-8?B?WENjM0pUWFBvNW9zenJid3k4ZGRZYXFsR2JpMUJuWGhSM0F2NDZoUkU2Ny9m?=
 =?utf-8?B?REl3OGlmZk5rWTJPdnVvZHN1M0RUd0ZmY1FkNnV6OWNrM2xUdjl2Q1g0dnhn?=
 =?utf-8?B?SUhHQkZBQ1Z6MnNuczBmbnJGSkpLSGNtNTgxRi9sRlhNb0VtYTVtUm9vVi8x?=
 =?utf-8?B?RGpzM3VyWHlaVmhYaVc2c2pXWU10QUFkQU9ubjdRNU9RaytlQ01YbTM0Smdl?=
 =?utf-8?B?WHlUc1IxczI0NW1PLytGSG9sU0d0OEJVOVp1enErWjhRcktmSDlQU29HQ3Ev?=
 =?utf-8?B?OEt3bUpmRDlzT0pOZkMrZytXOFFNRnFxd1VnNEZETTN1WW54YXdsSkZZSXB3?=
 =?utf-8?B?MmVXczQrVnNSRys0WXJxek9UN0J0SC9IenVaWWR4bVh6bGxBVmgwbVZKVFRo?=
 =?utf-8?B?SXQ4V0svMmtRM1NRS1Nzd0RNV3JqNXZhV200ZjRaR2NRdnFCZi8wemthTkQz?=
 =?utf-8?B?UkJaSk5jMTlvZ1BBRVlna3FIcnNBZjdGd0pwb3B4S2RpRWQybDV4bCtPZlNM?=
 =?utf-8?B?bndoMTFKWGl1cTE1SDVna2hNWVVBaEgwR2F6K2JwUUk2ei8wNmhubWtXQnhw?=
 =?utf-8?B?amlVSWZjdVF0b29mSzlqaG5qditsaGlha05BT2h2MEM0eWJRR1RHVmFiRVlz?=
 =?utf-8?B?akozbVdlWEwrbi9nMU4xeFBlNC9iQmw2WGpNR0hPSGFqL3YxWDVpV2p4eGdr?=
 =?utf-8?B?YUVxZVNuWkxROWFqNnRkTEE2dTdoRlkxTzlzdUQ2K3pxWWpHV1I0OHBjc1Uy?=
 =?utf-8?B?Z0hDblJkc0FCQXJTWTV2VXBUSUZqQW9Rb1RYMm9YMXFZdjdWRnNybWpQbEF2?=
 =?utf-8?B?Z1NCWGFQWlBtWkp3MHZocVcyRkdJaWg4cFVjcHFQOVhSYWU0cmRhZVpselNB?=
 =?utf-8?B?UjF4aWNxWnNQbmNRZkd6cU5hYm9kRmZKUFhnaFgvR0lGZm9UeWtENlJqQ3Fq?=
 =?utf-8?B?T2FkV1BxTHY0cVQreSt1MmJ4L09CS0hOajB4Z1dYaEhxVHBNd0VZZ2VhZitY?=
 =?utf-8?B?a0tqcUhobWNOb1dkVmQ4VGhVclpyL3l3dlFpMTY1czFsUTBsbUJyZ0ZCS3Rk?=
 =?utf-8?B?MXJSMmVPcHFJOE9KRGZtS1VxSjFsaEpDOVN2R2xOOUZMMFZCZ0VzYUs4aFA4?=
 =?utf-8?B?TE9QRGJqdUtzNmd6d1RTdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6786.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N29BbXlwVWxDM09NZEZCL2F3cGJFUlNYK2w1bElIVDFNTGZubW1nSVEyYUhJ?=
 =?utf-8?B?MUdRK1F4Zkd6ZnpsdVdwbXU2Z1pVd3UzeTZiOHEybXBxRGdQb2JTUldjc3pE?=
 =?utf-8?B?SHV4RGVJdmJ0akZDbFBEQ2QxZnZ4cG9nNWx1RGJveHgrTmVEcGo2N0thK1Fy?=
 =?utf-8?B?a0wvZ01BSDlBSjJOTXZBeG0weHNaRkdxM0NOSlFsaWhlZVFueFlFUmRDSlR0?=
 =?utf-8?B?WGRGU3Uyb1VwQUNGdTVKM0Q2czJWdldOZUVyWnlta1ptcXVtdFhBRnJqcXNu?=
 =?utf-8?B?VWJGaTJhNjlBOWc5KzdXVVN2b0FJZ3lES04vb0hnYlpZMnhBSnp2Uk5aL3Zr?=
 =?utf-8?B?SGVaT0w5a1lWd05NTU0yUTJvRVd0ZDd4UVdiOVBtcWhYTlVSWW40cEkxUWVW?=
 =?utf-8?B?Y1daa3NHVFFrS2tCdjNxSFQvd0NabCs2Zk0vQnh1QzNJZE4xeFZQcTRIekQ5?=
 =?utf-8?B?VTVXc2lWSW5qUCtFeHdnNVByd29NRkY2TWpBZnM0MnRFaHdDRitvSGJUV1Q3?=
 =?utf-8?B?TzZSSnZXQnc5T3JRMHFQaisyMHFmaHlhREhLT2JXL1dEWHJheHh2UVk1VVNF?=
 =?utf-8?B?ZU93QnJXWmxsRGF5N0VOMlhma2Z2VWRyaUxKTDc2Ym1JRG9kMXZVOTB3a0E5?=
 =?utf-8?B?UlBhQnNWd0lYb1N1UGg2eDZUMXJjYU1tamsxRmtpY1Q2TEd6WEt1cko4d1lO?=
 =?utf-8?B?SUhjM1FjbXJuWVlZSEF4VGtMTmNNdmpxL0NPc21KdlRjc2JVeXFJbWhZbHB3?=
 =?utf-8?B?Qjl3NHlySGo4dlZzaUU0cWJJR2pTVkdHOEpCaFhJbjdIWFhzMkI1U2V6Vmhi?=
 =?utf-8?B?V2kvRTAvSkd4Rk9CdU9FSzBSeWM2eFRmTUlPRUJsQmpBZVFCUk5HQTNNaXhu?=
 =?utf-8?B?eiswOWloUytQVzJWbXpIWEI4OXF0T3JYSUpKNEZ4UVBsSk5pTnJ4ZWRXR09J?=
 =?utf-8?B?UmdVK3AxZU5TbE1WeVV5ZFR5OEtJSVExZkhDZ3c1dWhDdnR3LzMyamZxSDl2?=
 =?utf-8?B?dHA5T2I2eUVMVFpoRUw3bEppS2xxOHFJV0hvNDk4VG9TNTN4cGtNY3hKZG9n?=
 =?utf-8?B?NEFDOFNRaDRzRmpSY25tOVhHZ0lMV0MvWEd5RW1FV3RrWHBIRVVNbndab2ZP?=
 =?utf-8?B?N2M4SEhUb2VFcmEycC9FLzYxcHd6QmxpQU5SR0hjZUI3Z1lDellVdGw5MXNr?=
 =?utf-8?B?S0huQkZpY3ErcjhyNTJyMmllaEpBaktkSjNPNFRZTU9PSzNzeEkya2lSQk43?=
 =?utf-8?B?SUR2d1Exb0dWZXBBM05CSmJTd254UW45Qmp3dUVJVTF2dEdtQVNqeVdtM05K?=
 =?utf-8?B?RVpJOXlzVUplcmZia2VSWHNFQmw5SnRHUk50SUhuRGFYQUZyL3FyaUx0UVNr?=
 =?utf-8?B?T211cUpaVHp5cWRrWWNUWTZJTzJRNmRlOVkraTBHK2x3UFA4YWtaYmRJWG1G?=
 =?utf-8?B?ZUNGT0ZIVkhOY1J4RnliL3h6TkZQcXRDYkp3VWc2NG5OWTh1MVZXVkhldE1J?=
 =?utf-8?B?eVQ3Rldxc1VkL05kTnpsUk9pTnNpRm9MVFc1S0RPSzgwS2pKTlR1MzNyWWFX?=
 =?utf-8?B?TEx5R2pCUHZod1FrRERZRVpnZmVBbFBsaVMyZmREOXVMazlYblZiblZjZ05q?=
 =?utf-8?B?cTB0aUpaenF6b2IrN3MyVzBsd01HSXAxenlSQlJ1UGcvRVhUSlJLODZWeENi?=
 =?utf-8?B?OC8ySVpETVg0TTFxWE5QWTloREhNWi9OQTlGODY5NzV6QUVmb3pIUHlJYVNB?=
 =?utf-8?B?ZGRzSlQvSloyOEl1N2ltQkZyQTB6VjBXU1Y2K2lQRktDZDFKRnlKVjBGd1Jr?=
 =?utf-8?B?bWNCQXFzdVBhLytUQUx4U2lUZW9GVGFJbmtVZW5VK0hCZVY0Z1ZGZ0RXTmw3?=
 =?utf-8?B?czlVNmF6ZWtkQlpZdjd1NEl0RDMrZ0NycnlMUUNRTXJ5eVFPVk5nVlJuQVRh?=
 =?utf-8?B?djNVTDVMQ1pQNnc5NkllWnduWkxSMUhXRE8rSEhveUJVaTVNK21DOFFrZ1pN?=
 =?utf-8?B?MDZwZHNPRWRkUUk4M0U5SHJiLzR1L2cxY1JTZkxvNFA1SlFsT25GdmwzbzlW?=
 =?utf-8?B?NnM0VXFOUTZ2TnluQ1Y3c3VYV0JIZVhHMXBkS0owa1pLQkJKblFJS2lqZlpp?=
 =?utf-8?Q?EsWrRDR0TILu8Mqasb8oUFi+I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6786.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d538e8bf-fbf0-468b-7f86-08dc7c3ad04d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 21:45:22.3838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVuP4GzqSh0wqkOnBWFUJL8ut/HOQ6p7cJ+NJPe2Qx6MVGfMh+qFFluohTkkmRE4tsw7z0Wa9r6JI58Sm+tSiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7261
X-Proofpoint-ORIG-GUID: _4FcLzOKPtRUSTPM6ZkzbT5ffDDGhUDn
X-Proofpoint-GUID: _4FcLzOKPtRUSTPM6ZkzbT5ffDDGhUDn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_08,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405240156

SGkgQW5kcmV3LA0KSW4gcmVhbGl0eSwgaXQgaXMgbm90IHRoZSBQSFkgaGF2aW5nIHJlZ2lzdGVy
IGluIE1NUzEyLCBhbmQgbm90IGV2ZW4gdGhlIE1BQy4gVGhlc2UgYXJlIHJlYWxseSAiY2hpcC1z
cGVjaWZpYyIgcmVnaXN0ZXJzLCB1bnJlbGF0ZWQgdG8gbmV0d29ya2luZyAoZS5nLiwgR1BJT3Ms
IEhXIGRpYWdub3N0aWNzLCBldGMuKS4NClRoZXkgYXJlIGluIE1NUzEyIGV4YWN0bHkgYmVjYXVz
ZSB0aGV5IGNhbm5vdCBiZSBjb25zaWRlcmVkIFBIWSBmdW5jdGlvbnMsIG5vciBNQUMgZnVuY3Rp
b25zLg0KQW5kIHdlIGhhdmUgUEhZIHNwZWNpZmljIHJlZ2lzdGVycyBpbiBNTVM0LCBqdXN0IGFz
IHlvdSBzYWlkLg0KDQpBbHRob3VnaCwgSSB0aGluayBpdCBpcyBhIGdvb2QgaWRlYSBhbnl3YXkg
dG8gYWxsb3cgdGhlIE1BQ1BIWSBkcml2ZXJzIHRvIGhvb2sgaW50byAvIGV4dGVuZCB0aGUgTURJ
TyBhY2Nlc3MgZnVuY3Rpb25zLg0KSWYgYW55dGhpbmcsIGJlY2F1c2Ugb2YgdGhlIGhhY2tzIHlv
dSBtZW50aW9uZWQuIEJ1dCBhbHNvIHRvIGFsbG93IHZlbmRvci1zcGVjaWZpYyBleHRlbnNpb25z
Lg0KDQpNYWtlcyBzZW5zZT8NCg0KVGhhbmtzLA0KUGllcmdpb3JnaW8NCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4gDQpTZW50
OiAyNCBNYXksIDIwMjQgMjM6MjcNClRvOiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmku
UmFqYWdvcGFsQG9uc2VtaS5jb20+DQpDYzogUGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hp
cC5jb207IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2Vy
bmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGhvcm1zQGtlcm5lbC5vcmc7IHNhZWVkbUBudmlk
aWEuY29tOyBhbnRob255Lmwubmd1eWVuQGludGVsLmNvbTsgbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgY29yYmV0QGx3bi5uZXQ7IGxpbnV4LWRv
Y0B2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3Nr
aStkdEBsaW5hcm8ub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgSG9yYXRpdS5WdWx0dXJAbWljcm9jaGlwLmNvbTsgcnVhbmppbmppZUBodWF3ZWku
Y29tOyBTdGVlbi5IZWdlbHVuZEBtaWNyb2NoaXAuY29tOyB2bGFkaW1pci5vbHRlYW5AbnhwLmNv
bTsgVU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbTsgVGhvcnN0ZW4uS3VtbWVybWVockBtaWNy
b2NoaXAuY29tOyBQaWVyZ2lvcmdpbyBCZXJ1dG8gPFBpZXIuQmVydXRvQG9uc2VtaS5jb20+OyBO
aWNvbGFzLkZlcnJlQG1pY3JvY2hpcC5jb207IGJlbmphbWluLmJpZ2xlckBiZXJuZm9ybXVsYXN0
dWRlbnQuY2gNClN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjQgMDAvMTJdIEFkZCBzdXBw
b3J0IGZvciBPUEVOIEFsbGlhbmNlIDEwQkFTRS1UMXggTUFDUEhZIFNlcmlhbCBJbnRlcmZhY2UN
Cg0KW0V4dGVybmFsIEVtYWlsXTogVGhpcyBlbWFpbCBhcnJpdmVkIGZyb20gYW4gZXh0ZXJuYWwg
c291cmNlIC0gUGxlYXNlIGV4ZXJjaXNlIGNhdXRpb24gd2hlbiBvcGVuaW5nIGFueSBhdHRhY2ht
ZW50cyBvciBjbGlja2luZyBvbiBsaW5rcy4NCg0KPiBJbiBvdXIgTURJTyBmdW5jdGlvbnMsIHdl
IGRvIGNlcnRhaW4gdGhpbmdzIGJhc2VkIG9uIFBIWSBJRCwgYWxzbyBvdXIgDQo+IGRyaXZlciBk
ZWFsIHdpdGggdmVuZG9yIHNwZWNpZmljIHJlZ2lzdGVyLCBNTVMgMTIgKHJlZmVyIFRhYmxlIDYg
aW4gDQo+IHNlY3Rpb24gOS4xDQoNClRoYXQgaXMgYSBiYWQgZGVzaWduLiBWZW5kb3Igc3BlY2lm
aWMgUEhZIHJlZ2lzdGVycyBzaG91bGQgYmUgaW4gTU1TIDQgd2hpY2ggaXMgTU1EIDMxLCB3aGVy
ZSB0aGUgUEhZIGRyaXZlciBjYW4gYWNjZXNzIHRoZW0uIFRhYmxlIDYgc2F5czoNCiJQSFkg4oCT
IFZlbmRvciBTcGVjaWZpYyIgZm9yIE1NUyA0LCBzbyBjbGVhcmx5IHRoYXQgaXMgd2hlcmUgdGhl
IHN0YW5kYXJkcyBjb21taXR0ZWUgZXhwZWN0ZWQgUEhZIHZlbmRvciByZWdpc3RlcnMgdG8gYmUu
DQoNCkFueXdheSwgZG9lcyB0aGUgUEhZIGRyaXZlciBhY3R1YWxseSBuZWVkIHRvIGFjY2VzcyBN
TVMgMTI/IE9yIGNhbiB0aGUgTUFDIGRyaXZlciBkbyBpdD8gVGhhdCBpcyB0aGUgc2FtZSBxdWVz
dGlvbiBpIGFza2VkIFJhbcOzbiBhYm91dCB0aGUgTWljcm9jaGlwIHBhcnQuIFdlIHJlYWxseSBz
aG91bGQgYXZvaWQgbGF5ZXJpbmcgdmlvbGF0aW9ucyBhcyBtdWNoIGFzIHdlIGNhbiwgYW5kIHdl
IHNob3VsZCBub3QgaGF2ZSB0aGUgZnJhbWV3b3JrIG1ha2UgaXQgZWFzeSB0byB2aW9sYXRlIGxh
eWVyaW5nLiBXZSB3YW50IGFsbCBzdWNoIGhvcnJpYmxlIGhhY2tzIGhpZGRlbiBpbiB0aGUgTUFD
IGRyaXZlciB3aGljaCBuZWVkcyBzdWNoIGhvcnJpYmxlIGhhY2tzIGJlY2F1c2Ugb2YgYmFkIGRl
c2lnbi4NCg0KCUFuZHJldw0KDQo=

