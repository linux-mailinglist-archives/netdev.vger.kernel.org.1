Return-Path: <netdev+bounces-99644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9144A8D59C0
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 07:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BE91C22AD6
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 05:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9D44C64;
	Fri, 31 May 2024 05:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="PL+YEmFB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95D5695;
	Fri, 31 May 2024 05:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717132350; cv=fail; b=I+hYOCKV7Sn7Y1n671LLE4nSe3hlRTIOynwjdCfPaLBBxec/YGSZ9kGgCCPyxhqxBHjzYQyHkaA0sRPLr4ArC22lLlB/FkSCsoOkMj0n8wKZESa+7XhFadXxKeXIAGPOW39+Qpf3eg6EbBZdSBcAu2LAfW9y35y/f1DuKUWrctM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717132350; c=relaxed/simple;
	bh=FAS99x0tpJlmo+M2Wd95ENJlZZwqJdVpjawUywm2r4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SeKqb2sKdFetAB7/qYokTJ4BFi65ktEgOFy3Kq9aHT55l+EWF4UbemITZ9Oxqp66FgM8B+Bxh6LoR3seSS8m0y8X5fTy2qDmzrn4nEh5GOZJi+TP6C5Eu4MMTAfMOX3K8ABe2FhMXIQCbTzJE1PKQhjpy8RtFKu/G6VYoLoXX1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=PL+YEmFB; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UIqSrA025798;
	Thu, 30 May 2024 22:12:13 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yegkn51xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 22:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve112VsJhtkFtkK3aJ0AfymSkJiUim91ESENE/rBwre6qoeywstxTSR2P55A0CbPGRIzJq3kF+RdRn3RI3tz7bf+KHRDQev39XBDZa7HNa+eEGParcjgYtbimPNi8dej8cz93AZEHHlzQ0B1nspbJxvTqYbVtNi5wFsMVw77R40p5hMTG4HuuTU4TyOVt9pJXsNZVzGscd4duViQ/GOp0Nxpoh1ve07gGxeDnLsq6Y56YWmxrfllq8LR8aMU2KG0SxSdYF5HGXdLS1avlNtXLvhTLr7LwZizbqtdX5xmPt2WiP8/czcfnYemWQR3CY4kxovX1VOerHSiQ0wMvED1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAS99x0tpJlmo+M2Wd95ENJlZZwqJdVpjawUywm2r4s=;
 b=OnL3P/ohr35HNFZSwvD+ejkvCHVQFovi191cqH4y8aBA74NogiIfqL1JLGumLlGEwqgUt/UVzQwEjRvYXxG1BCA4qLGRQBhQyIbhEvqTuAPioo3KDrYNJWqGOjzMF/7UtXGzg/HIhJEEbfbBO7uHRd7AR28b72bWteyphrimBgx4BSCYlkgOfgYpA21VmXgWuc2QlsGGabJteXBkR3NMLvxi0EZ9JAQROP1baC83xUqVJgRGbkeb9D8sUQYIDwneeUMw9IDCVG3VooCR4galhpBMshOZcsHvESoBAElL6cNzkIE0qi9AoLDamGjqasPD/b7c6mOx27tKF5CmDW6ACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAS99x0tpJlmo+M2Wd95ENJlZZwqJdVpjawUywm2r4s=;
 b=PL+YEmFB8y+Hujm7e9MF901dZJLitRmn/nJcabYicB9qxDXfZhioni4upD7TUtAGLVVcY3BrX/V4GsWaH1wQVjJiTAuSp/c/h19E3MdBLznnAfEbgD/oE8we20evbBfYiLio6rpYVB8ZZHL3EEcfFuRLtwoOxLdNBDFdBBAkIxo=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by CH0PR18MB4307.namprd18.prod.outlook.com (2603:10b6:610:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 05:12:10 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 05:12:10 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Diogo Ivo <diogo.ivo@siemens.com>, MD Danish Anwar <danishanwar@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jan
 Kiszka <jan.kiszka@siemens.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 2/3] net: ti: icss-iep: Enable compare events
Thread-Topic: [EXTERNAL] [PATCH 2/3] net: ti: icss-iep: Enable compare events
Thread-Index: AQHaseI1A9kWSojA80W9JDmkZ74RRrGwzapw
Date: Fri, 31 May 2024 05:12:10 +0000
Message-ID: 
 <BY3PR18MB47377FBF88724DD5A4814BCEC6FC2@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240529-iep-v1-0-7273c07592d3@siemens.com>
 <20240529-iep-v1-2-7273c07592d3@siemens.com>
In-Reply-To: <20240529-iep-v1-2-7273c07592d3@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|CH0PR18MB4307:EE_
x-ms-office365-filtering-correlation-id: c9fa39bc-886e-4ff6-ef10-08dc813039b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|7416005|366007|921011|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UVBlN3pSSmRYdUlGazlhbjdzNTJrN2pJaWFlMUdYUzdCb2FwNDErYmdWVGFW?=
 =?utf-8?B?K3d3dmtValNzWUY0dWZqRGsrdlErUkwvbzBiSTBLbVZCQlhhOW1FdVNYeHVo?=
 =?utf-8?B?alJLalE1dldseDE4bDdyWkprejZCNmdwREd4WjY2aTVEWFE1ejl4RzVhSE55?=
 =?utf-8?B?RGdKcU1aaG9ISGh3dzQ3M25QenRTNjlYallibU1TbzR1K3VjeEN5Qk1jOGpz?=
 =?utf-8?B?L1hHNXpIRkIxYkZLN01HZEdIZllMUzdWdi9IMjduMEhGNjE3N3dpQUJFRVNE?=
 =?utf-8?B?dGNWdnA5cDdyV0RRR1d5TE55TWF3dUc4YW5wUWIxbWY4VXJxcEhZUEVxbDdP?=
 =?utf-8?B?MFBhakk3MDVyeFB2dlJoMFNtL3lUMVM1N2hnNUpsYVNSZStWaUx6TFV2STh3?=
 =?utf-8?B?bmZkWlNoZVlUOXRwbDVVM0hMMU9sT2RnUUxJVFRtZHpvQmlBbEdlbHlXODgx?=
 =?utf-8?B?VFRPMmM5NHFWV2VhKzQ1S2xwMDJQOU1ZN0lSeWNXMkJiSG1pem5MZ1llQmRv?=
 =?utf-8?B?c1lUQ28zRzBwa1JwMXExZHBUbmV1Sng2amtVNUNzLzB1ZVlXTGJEUzIvZFNo?=
 =?utf-8?B?MU90dDBIODFmVy8rb1BhZXl3U3lld1pBZVBxN0NXVmZqVnl6aVA2L0U5WFcx?=
 =?utf-8?B?MThSMFZvNmtyckZzTU5PNzVuMUtzZXpqQ2o5Y1FYd0V4UkFjRTloaytKUGtV?=
 =?utf-8?B?YlZpUWpTMDNsNWswWWxIL3VYelQzSkFqMWV0QkptQXd1cHMvZFliSFBxY1pj?=
 =?utf-8?B?cEJrTFdKbUV3blRuL0RSeU8xQnNjNmpncHZEMjB2aHcwYXNIYWpiWFBqN1p4?=
 =?utf-8?B?RHJmbTBHc2hiZHNwTHRNTTc4UVB5YW9zb3hSN0Q0NTIvclhoY3JmMkdMQzRk?=
 =?utf-8?B?YlArQmNEZndFYkpNbFpuOGpIVW03WnJZdm16djlJbEdUaXNNRjZJNjBEdkp3?=
 =?utf-8?B?Tmk3VVhSTUl3ckl4MUZjTlRsaEJ5UTVIZzVzRjkzOXdjSWI5OExRYjlnVEly?=
 =?utf-8?B?cDVURVhML3VLL0VBK1QvdWExRU5FcHlNR2tTNlI5RThGUnVEK2xEVVB0K3dQ?=
 =?utf-8?B?a3kwVTZNd3N5WDlGWXVMNWo0QkNYOXovNGtIZDhjc1M2R25vQ1JpRXQyNUpl?=
 =?utf-8?B?REYyanl1bXA0M0lGRjFQenBQcGtHaEFxdWhWb1VvQTMvaDJ0YVA3c3J3dGIz?=
 =?utf-8?B?Z2FmNFJwSFBPVHMvOUUrcU9JTSs0cWdxa3RhbGs1emRmRWJBSW8xS2NHeDFB?=
 =?utf-8?B?ZnEwZUtmMHJtWFhHYjVFWU56VmFPY1lzZXNqMGltTWVVTFdXK1IzclJpOS93?=
 =?utf-8?B?R3FYRFJ4bkUxRzhFMnhWSlpXa1NaUWF4eHVJaHpZa1FHWmNkRHdwMGp3RGZU?=
 =?utf-8?B?MlY4VkpqSXlNakZGYkxSUCtTMFJucERTUXpZNzBOejY1aFZKclVpc2QrZ1hh?=
 =?utf-8?B?M0pQaEc3NHo5Z3dDTUIyZStKdklDZ2NuMXIrZmNyL21NdDdzZjRTYVRuZmRR?=
 =?utf-8?B?ZmE5V0QzYVU0ZE1oTEhBQ3p2ZFRBL1hNaFlJNE9zKzMrMzcxWEdVMnppVnQ5?=
 =?utf-8?B?UldCK0txUndlU1lObE5VMEdKL2pROUEvM3dpM25KWHI5WUJSaHB5Y2R5SW00?=
 =?utf-8?B?YVJlNHdDRlN4M0J3ZkJTd2ZZR0I0Q2hIWExWVm9CU3J5UzluU1g3TzhKcmFF?=
 =?utf-8?B?YkxoMGl3MUNSNzMwUThLSk9YalJsTDV2ZjZtRm11YVRUVlhTVnFiVzNJdmNF?=
 =?utf-8?B?Z3ZYWDV4Q2FMMEdaOUFuUVZqQ1BpWCtkQkptbW5tQzU4WWNPNnJ0enlYcUJn?=
 =?utf-8?Q?EEu/A4+iakgYFor09DkgdUfnggWbdN9R5CJwM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U3lrRTBtU01rS0hJRllaTUFCdENNM1pZU2FyRXhrNGRGbndHd3kwSGNWRzQ1?=
 =?utf-8?B?bld6dDdZRTBLMThZYkJKdExjNFBDVGhyMlA0OWlmRkVYemNtWTdUOHk3WDBw?=
 =?utf-8?B?dHV3TmRiUno5amgrMSsvZ3ZYSXJ0aXVETGVNa0FKR1pFRTNaS3VzRm5uUHpH?=
 =?utf-8?B?ZWNQbHJzWnVUV1M4cEFQMjZUSjIwenl0dnk4bENmOC8vT1VXTWoycnM2SWwv?=
 =?utf-8?B?TTNxMVNwYmJyQ01jdHhvZTJEVjFkVVRkL09LOGd6QlB5OVhBYkRDUS9uVHQ0?=
 =?utf-8?B?ZGhwR3U4c1EvWEYrU3QwU3loKzdZMFJrUkx3NHpEUGN0YWNubXI2UmR1RE8x?=
 =?utf-8?B?dEIxeVUrK0tPb3lGOGRwdWpkUExPWjVGcTVNci9UK1I1RWZKQXZ1Rlg2dFRD?=
 =?utf-8?B?US94bEVHOC9hOVRJaFZYNGFXc0ltZTNscllMMDR0MEszbEdBZlc3eW9HNk51?=
 =?utf-8?B?T1VpQWZiWDEyLzhTc0hRYVRBd0kwd0dyeGZoZTdGY21Ldnd0S295Tk1YemhZ?=
 =?utf-8?B?MGZkRTlnWjVFKzRCeFJqTnNEZkFuK0x1TStSSHFwclpCNVNDSG1yUEg0cHdR?=
 =?utf-8?B?RHZMK0IrYjFieDh5QkNuMXplRFhxbGtLaUZRdWpnVldYL0JHYnZBRnE2d09j?=
 =?utf-8?B?b1JGbmZFUDJHeXRKU25iY3F1MFBTUU4vdzZQclhubjJ6R2dEckZrTVdzWEtV?=
 =?utf-8?B?WCtxcWhzRVFCNGFvRHBxenFOYWcrU21PemhkOHVLZW9RWWYxNFdlbDhISmd5?=
 =?utf-8?B?VE4wcSs1TWo4Qlp0ZHBtRkJnQjZxVk1FQkVjTzczNkN4dHl1c3JTNFNUU1ZL?=
 =?utf-8?B?bG16QVJUSDd6RTgyZk52dVlTeU9hbWZ6ZlJJcDFjVUppU1hmcGo2MXYvdE84?=
 =?utf-8?B?c3dDczcrMUc4R3VHQVcvT2ZGVjBsN1lYc3d2M3lIWHdkaXhPa3BRdmhOL1dI?=
 =?utf-8?B?VjNQWmJSZ3loKzdiZjVLRzhUeUkyeTZOeTR2TXZRSThTSFRQUVNGNXhqNFln?=
 =?utf-8?B?eHhPVS95Y2xuRTR2QWRyM3NmaVcvOFpnQ0ZVc3hFUVRyOWRidi9kZ1o4K291?=
 =?utf-8?B?Z2Jjd1FYQXdoMytaRkxpbDVvMWo3ZVlDUGtxcEg3ZHZEdkNNNGpIUGRWaWp5?=
 =?utf-8?B?TlhPOVFQTnRobEIvZmI1OTlSN0tnVGZTMDF6WDQ2L3dEU09XSnovNzRXT1ZH?=
 =?utf-8?B?UmpPVXpJV3lNZTl0aTJTVFduR0d1Q3FCNTNCVi85ck4rSE9zYzRiU293c21O?=
 =?utf-8?B?ZHFJMURvN1poUWRMTjdZZmNRVDdNZ3NxaU9lR3VHR1RpOVc1OXloWHBmTHRw?=
 =?utf-8?B?a3FXa05PKzBTYTh2R295R0NIbm02OVBVWnJDNGRDejB1bllsYkVqNUEyeVps?=
 =?utf-8?B?YmtqdEllQTBpbVkzK0VycmFSanhHZjkzaUFjL0xUZEMxUkYrcmdQajhkcnc2?=
 =?utf-8?B?aXdtYi9lVktPMEpCYjRnT25hWTRvRTNNelVwRGxiTWtEamxiZ3JsWXZaRmlj?=
 =?utf-8?B?dkhhYnU4YTJOaXRnek1LQXpCK1RFV0xXYlhFOEpWV1JSZDBCVFIxZVM4OVZP?=
 =?utf-8?B?YUlhSVlmaXdpamhYS0FCS3dIVWxETlI4QzYxU0d4bUNiSi9YdTN0YzREaUZj?=
 =?utf-8?B?UkViNVBJN293QWZGZUl3TUZvNU1HWEx6Q3JwaTBaT2ZaU3YwTmVlb0xTYndB?=
 =?utf-8?B?dW1wMnc1TUExeEQvVzdRTk9yY2g3M3I0ancxVnRNK2o1emFvL0l5UkFqc3Rn?=
 =?utf-8?B?NEpVMTRDQSswSzJnQWNsNjRBcmo5MW1yM0RGYkJwL1JaeTNwcEU1WlEzbnl5?=
 =?utf-8?B?MDV4SlFSQVNCa3FEbVB2WlNuZEIyakg0cFdsd0Rtd1dMU0tWQWRrMVpDMitP?=
 =?utf-8?B?KytFS3NrQlI1SldTQXJjbC9SZm9kV2wvWlhPYkQ4cnBsOEhLUzBuSWxZL0Jl?=
 =?utf-8?B?M3ovSHVaSmlNWDBhMmlDa0QzaVRmNWw0UlREQUltVExhQ3h6ZFk0OGNpOHFN?=
 =?utf-8?B?b2tnclFoaVZ3N1Z0aWxtZnh5cHp2QkIwY3dpM3BWMmVOdHhWOC9LWGNGcjZk?=
 =?utf-8?B?R2JGUm1VL2xza2h2a2c5VGNVeS9rMWtlVUEwRUNEV3k0b2JJUDVKTDQvVGJx?=
 =?utf-8?Q?zR6poDo+CIi++XVDBLVpNHKmz?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fa39bc-886e-4ff6-ef10-08dc813039b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 05:12:10.6186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CjDZe9hSFc3Lxdx9jL7IakKKrdPCIiXKtWKk39UzG08kc46fJGeAuzyxm8yWhRp2PuQjabuHZaU0nzfUZeuAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4307
X-Proofpoint-ORIG-GUID: NrWhWHFWVqBIYlzDrIbk32CrYWDp2LQf
X-Proofpoint-GUID: NrWhWHFWVqBIYlzDrIbk32CrYWDp2LQf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_02,2024-05-30_01,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERpb2dvIEl2byA8ZGlvZ28u
aXZvQHNpZW1lbnMuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgTWF5IDI5LCAyMDI0IDk6MzUgUE0N
Cj5UbzogTUQgRGFuaXNoIEFud2FyIDxkYW5pc2hhbndhckB0aS5jb20+OyBSb2dlciBRdWFkcm9z
DQo+PHJvZ2VycUBrZXJuZWwub3JnPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQu
bmV0PjsgRXJpYyBEdW1hemV0DQo+PGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkNCj48cGFiZW5pQHJlZGhhdC5jb20+OyBS
aWNoYXJkIENvY2hyYW4gPHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbT47DQo+TmlzaGFudGggTWVu
b24gPG5tQHRpLmNvbT47IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT47DQo+
VGVybyBLcmlzdG8gPGtyaXN0b0BrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVs
Lm9yZz47IEtyenlzenRvZg0KPktvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3Ig
RG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgSmFuDQo+S2lzemthIDxqYW4ua2lzemthQHNp
ZW1lbnMuY29tPg0KPkNjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBEaW9nbyBJdm8NCj48ZGlvZ28uaXZvQHNpZW1lbnMu
Y29tPg0KPlN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDIvM10gbmV0OiB0aTogaWNzcy1pZXA6
IEVuYWJsZSBjb21wYXJlIGV2ZW50cw0KPg0KPlRoZSBJRVAgbW9kdWxlIHN1cHBvcnRzIGNvbXBh
cmUgZXZlbnRzLCBpbiB3aGljaCBhIHZhbHVlIGlzIHdyaXR0ZW4gdG8gYQ0KPmhhcmR3YXJlIHJl
Z2lzdGVyIGFuZCB3aGVuIHRoZSBJRVAgY291bnRlciByZWFjaGVzIHRoZSB3cml0dGVuIHZhbHVl
IGFuDQo+aW50ZXJydXB0IGlzIGdlbmVyYXRlZC4gQWRkIGhhbmRsaW5nIGZvciB0aGlzIGludGVy
cnVwdCBpbiBvcmRlciB0byBzdXBwb3J0IFBQUw0KPmV2ZW50cy4NCj4NCj5TaWduZWQtb2ZmLWJ5
OiBEaW9nbyBJdm8gPGRpb2dvLml2b0BzaWVtZW5zLmNvbT4NCj4tLS0NCj4gCWllcCA9IGRldm1f
a3phbGxvYyhkZXYsIHNpemVvZigqaWVwKSwgR0ZQX0tFUk5FTCk7DQo+IAlpZiAoIWllcCkNCj5A
QCAtODI3LDYgKzg4MywyMSBAQCBzdGF0aWMgaW50IGljc3NfaWVwX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UNCj4qcGRldikNCj4gCWlmIChJU19FUlIoaWVwLT5iYXNlKSkNCj4gCQlyZXR1
cm4gLUVOT0RFVjsNCj4NCj4rCWllcC0+Y2FwX2NtcF9pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5
bmFtZV9vcHRpb25hbChwZGV2LA0KPiJpZXBfY2FwX2NtcCIpOw0KPisJaWYgKGllcC0+Y2FwX2Nt
cF9pcnEgPCAwKSB7DQo+KwkJaWYgKGllcC0+Y2FwX2NtcF9pcnEgPT0gLUVQUk9CRV9ERUZFUikN
Cj4rCQkJcmV0dXJuIGllcC0+Y2FwX2NtcF9pcnE7DQoNClRoaXMgaW5mbyBpcyBjb21pbmcgZnJv
bSBEVCwgaXMgUFJPQkVfRElGRkVSIGVycm9yIHJldHVybiB2YWx1ZSBwb3NzaWJsZSA/DQoNCj4r
CQlpZXAtPmNhcF9jbXBfaXJxID0gMDsNCj4rCX0gZWxzZSB7DQo+KwkJcmV0ID0gZGV2bV9yZXF1
ZXN0X2lycShkZXYsIGllcC0+Y2FwX2NtcF9pcnEsDQo+KwkJCQkgICAgICAgaWNzc19pZXBfY2Fw
X2NtcF9pcnEsDQo+SVJRRl9UUklHR0VSX0hJR0gsDQo+KwkJCQkgICAgICAgImllcF9jYXBfY21w
IiwgaWVwKTsNCj4rCQlpZiAocmV0KQ0KPisJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShpZXAtPmRl
diwgcmV0LA0KPisJCQkJCSAgICAgIlJlcXVlc3QgaXJxIGZhaWxlZCBmb3IgY2FwX2NtcFxuIik7
DQoNCkNhbid0IHRoaXMgZHJpdmVyIGxpdmUgd2l0aG91dCB0aGlzIGZlYXR1cmUgPw0KDQo+KwkJ
SU5JVF9XT1JLKCZpZXAtPndvcmssIGljc3NfaWVwX2NhcF9jbXBfd29yayk7DQo+Kwl9DQo+Kw0K
DQo=

