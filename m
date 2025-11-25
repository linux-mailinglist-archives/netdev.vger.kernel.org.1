Return-Path: <netdev+bounces-241619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E0CC86E16
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 550854EAC13
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6937D33CEA5;
	Tue, 25 Nov 2025 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="YA/meb7x";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="tBanY22S"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170733B6E8;
	Tue, 25 Nov 2025 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100255; cv=fail; b=oovCr0ZysQs5y8I5JO6oyURoLHn9vZOPWJ0zRTaguFquyBm8Ld55W4qqfwc6LI/RybfKHKR6UhISI0ApWG/lNes8A3nuFE3SJX2jA1UaxFGYsnq9+CtMdmH+CqaxYoLaxx07RsANd4Jwpy0zTFU+8UV1QX/AGfFlWUXdwzIkRos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100255; c=relaxed/simple;
	bh=Jht9ebitUImyocrJ4spV+gjdrPYC4EofPcybg7lklyk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KLRZvVNycGmPyPZ1ftJKE5p3BDs9JG8A8CHvp6TPLPZDuZgGqgxOtvicwXrPn0gpeZ/aV8qJhTJVaQeUxzqdFaWut5z089Fa0Hq7JhQ8tcmfSICaHWMOLecqrru5xs1O7083TYbt+NH9X5xnpPImvUEKXDiG8d8HAJASl9rumZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=YA/meb7x; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=tBanY22S; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APFtYO83499637;
	Tue, 25 Nov 2025 11:50:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=Jht9ebitUImyocrJ4spV+gjdrPYC4EofPcybg7lkl
	yk=; b=YA/meb7xVOPi7RirNpY4+FMV6XKdK+/STW8KH/4dqg33TnElcrydBD0I9
	yKYo0E7QX2Vl1zbVMBbvboptHXrt6QSAPMYQLeXa+prZ6HW6pci5VRXsaBhZppv/
	6QqrTppeijre20UO5gbEKwPicJeDZOaiLznZspVX+cznt8FfCcRdNoqYqru5sFJC
	ykvQXkpQL/P6kcx43eoT96teTqlStuTUKPRX3D1OzSbupA1xheNkyfArN5kVarE8
	xY70vv2oa5DK0V1NEZ3dLuLi5PDqU0w6b0yy3kJdhWQNkQuyWYU1QJzpvUgsn0HH
	P6E8ggylNJGpnymt2m9fcpI56W6Kw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023094.outbound.protection.outlook.com [40.93.201.94])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4amu4jk1yd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:50:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyytAA3RLvhRwEeUr8p6TbSgioIuB73SbCX5istTg0etX/VKp5XFAFrruhSJTDVNBIg2/0XZfwv0kHc5FYGX0eI/wDikdUNfTubown8SxpgJMFn26LNPCdfd4Wk/D17Xmod8/miwgzh4X63s2CNFN5NId3dg0FztrswoaLqJAlP4U8ZtQcYxccTNb5UKnkIkHygWCVVREER9TVy6w+Ou6O0tmujSV+FKKoOgECpG4XiCHryKFg6fTPebgo6qoVir3ACQeXmQzqCxc7FSduUGJYXl9VTQsuiOKjRLIAaPq00/clr6Q2Yt+RSRO3rBLWtz73gu4Jfmctt0LmzrECN1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jht9ebitUImyocrJ4spV+gjdrPYC4EofPcybg7lklyk=;
 b=wDnGAGl2cQHTU+pttpMawB7rIyhoSNUlF0/vHBrxT1vDW6tzw/DXk+D/nAkZBC2U8BkyFou+zSe7a3631TWvrj3CNIhZs8AmiSxNBDgX6L+vDW4c/kiB5QrGyNhPNcRJTeO44pL5tNvakgxDFmGlEQMb/CiGib98GIP8iZLmzifpJlpec96m2sM5r5EnUlJ3OH8/Htt0aEuzXbSMIEzC3f1tA2JNbafZh4gQoPyeg44AHbNc9J+pix9t8oEWNOfaso6sXGtJ9IxGwyjt4a4T5FGgZxXwQzvKYxWn2koTzgweHCY5JWe/ujyUESJJ+zW98vj4u5HkwCKcfykzmMcsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jht9ebitUImyocrJ4spV+gjdrPYC4EofPcybg7lklyk=;
 b=tBanY22SbxnwAItyGfGE37QR7BtPvb6Xi+AJUt9hXIpzgOpnYal3qYiXPCacKduAhPaP7esVGgeygeRuuJKi8rYy0RHyZwVhW/5kR+Pc6DVfQyochxNDuU5j1zYIcSVUPal1QZq9WUXljMu6/Ny+L/tS6XybV+h9KBjIkH06oiKFbyuMsjTq/WGntOpgE7OTD8NKL5VWeB2tIYloRoYSVfmKOjSnHi8+CPhR+v1cnkiHHV5FqeKr92ZJhviIJZMBNN4KJcgyJIxr1YBDtdgAmoWdIWdqxz2303pA3qxV7quxbkdGqbnAQcFm1FYfSsqY+q6tvJo/NeCfWdVPCg2S1Q==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by IA0PR02MB9461.namprd02.prod.outlook.com
 (2603:10b6:208:401::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 19:50:33 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:50:33 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jon Kohler <jonmkohler@icloud.com>
CC: Eric Dumazet <edumazet@google.com>, "Hudson, Nick" <nhudson@akamai.com>,
        Jason Wang <jasowang@redhat.com>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
Thread-Topic: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
Thread-Index: AQHcWcFhUQqtBOkli0a3kVsOu9uBaLT7FV8AgAjAlgA=
Date: Tue, 25 Nov 2025 19:50:33 +0000
Message-ID: <BFCA022D-C87E-4113-BE5A-5CE5E945395F@nutanix.com>
References: <20251106155008.879042-1-nhudson@akamai.com>
 <CACGkMEt1xybppvu2W42qWfabbsvRdH=1iycoQBOxJ3-+frFW6Q@mail.gmail.com>
 <5DBF230C-4383-4066-A4FB-56B80B42954E@akamai.com>
 <CANn89iK_v3CWvf7=QakbB3dwvJEOxuVjEn14rjmONaa1rKVWKw@mail.gmail.com>
 <7D7750CA-4637-4D4A-970C-CB1260E3ADBC@akamai.com>
 <CANn89iKr4LUSaXk_5p-cot6rxDngLJ8G6_F1eouF3mGRXdHhUg@mail.gmail.com>
 <AD5D3F27-9E32-4B18-97D8-762F0C3A9285@icloud.com>
 <CB96779A-3AFF-4374-B354-0420123D368E@nutanix.com>
 <56FA5DD5-B2AD-4C3C-916E-6E703010DA9C@nutanix.com>
In-Reply-To: <56FA5DD5-B2AD-4C3C-916E-6E703010DA9C@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|IA0PR02MB9461:EE_
x-ms-office365-filtering-correlation-id: 89ff8299-aaec-4495-6f7d-08de2c5be539
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3o5dGlEVEFYTWpjRGVvQUp5RG9kN0hvV1hrU3BxenJIVmVncTdhQjFDUEJJ?=
 =?utf-8?B?ejFRNjJMQ0g1Q1RkTnRhZzk0WWZ6cUdyM3puV3cvcVd0WlFmTVR1d05HeWdR?=
 =?utf-8?B?RXpvNWJoY3E5RGZFL09wVVdBL0hIRisybFVnQUhPMW9qcEM0M3hnZVhZN0Ja?=
 =?utf-8?B?R3BnQ1dud05PN1d3R0MxeWYzMDVhbVgzYjZnMXFBR0FzK2ZLQXpYNE96dFRW?=
 =?utf-8?B?aHNXL2hYaFlqSWZiWlIvbjhVQ0Z1RWxzaTgxZVhrOGpadjRCbzc2K05UNjY5?=
 =?utf-8?B?OFl1YkxseS9wWnNVcnl1d2JnZTNvdVJtbTNpUUZBQUdqcGh1aGZHSTllaGFC?=
 =?utf-8?B?SDJiWlQ0eXUrUkNvd0JnV210ZGxEUTd4YjZxSGFCQ0RnT1VXNng0SW9PbTFB?=
 =?utf-8?B?NlloRjlEVzBlekpLZ3U4cWgzZVoyZGNtOXphdDIwTlFGUXh2L01VbUpOdE9N?=
 =?utf-8?B?SlJMNUxGL3dHS25FVnM4U2N2YnROSDFrTUEzRzhRa2Z1a3BBU2NUajk4NkFr?=
 =?utf-8?B?MFJFU284S2w4QmEvSWowbWJWK1dLT0lRWG5yZnd1ckRXZERMYTQ2dld5RTVx?=
 =?utf-8?B?Y1JtUitGLzNCdzg3a3h3QWJ2TW9WYkVvUTBBaFBGS1FZSFpkOGZnRjJNUE9r?=
 =?utf-8?B?WGZMTGV3MU5pc1hKMjdnWEQ2VkVuQkdZOTk2aHBZaWZHV29WRzdQYVR6TUFk?=
 =?utf-8?B?WEFmbWdaS1U1dEZIQ2UrR01ZNG80WFFPemNwMVE0NkZuUm1YalNGTGlQbTU1?=
 =?utf-8?B?WUxiUXZLcEpiVmtoS0lUeE5lRkh4b3ZVajBrSnV0Qzg5WUlyVUlud1dSZlNT?=
 =?utf-8?B?VDRHTVFDaUVqRk94WUJQT2dSRFNNQXRaTjhDOGNleFpFQXYvNllkdTNDNGlz?=
 =?utf-8?B?anBWSTNoZUZUYzBHcVluRHJDWVVlYlZkLzRacUFORTl2cUQwWUd5dG15cnph?=
 =?utf-8?B?VGNuU0NRN1hwcHdPN2ZZNnJDNmF1MWhmb3JCY0dieXJuLzYyTk1HanBrVVZ2?=
 =?utf-8?B?Zno0UnJzL3VWUGwvZFkzNnl4UktpdnJ0RWZMS2pnb0FEM1pQVXk4czhJNHpO?=
 =?utf-8?B?MXFtZlBncjNRdE85c2s4MzJMMUN1VVo1MkF4Y0pKTDh3ZlN1bkNySllvOVAy?=
 =?utf-8?B?cFVtZVZIWnFucDNwclU0b0lmU1B6aHNtbTh1ald3WkkyelJ3aGFyWjFWTnA5?=
 =?utf-8?B?RjVNNU5HUklmQ2RuN25wNHl5ZFduWmlJenBrdS9jNHl1NkVDT2Y1SGtUNDFS?=
 =?utf-8?B?NVRmbHpONVZNWDdFYkFwdDFMcFBpNHdUVytqNFpERWZEMW9NMEFvdW5HMU5D?=
 =?utf-8?B?VXZac3BoSXV6bzN3cE1QbEY2QlRKMDlKY1VzeUUvODBxQS82aWxjSysxWXpv?=
 =?utf-8?B?eGhGQlo0K2c2c3YzOXdGY3dGNktUSEtSTTQ3RXo2WFVjNWxjdFIvU1Q3RGl2?=
 =?utf-8?B?eGorQ0hrcmg2Sjh2dGlnRjRtbHhXTDdwZ09QeEtUaDJCUStYUHFDdmRZaXBo?=
 =?utf-8?B?NEZsdk5MRlNUODY3SHFRRFhEL1R4NjVpeUNtOXRRTUJnM1ltOEFCcy9qd2Fh?=
 =?utf-8?B?TjAvL2Z0OHJqNlFVTGJ4Wi9vazVseUdodjlhYzhjZHdDZkZ2MFdXN1pXaWow?=
 =?utf-8?B?NzNNSDV3d3QzYStnajhBMnIrc2Rmc3d3YUtUb0MycE14UCtsQVArS0QwcCtq?=
 =?utf-8?B?cWRGQzcvTVRLQkNpTUsybTdnSXRJWEo1TDhCN3RKQU5Nc2N1dVZJbEJ0NXlF?=
 =?utf-8?B?am1ZWGI0cHNra0d5WHNmZTRJVmkzb1FNQ25saEZ4SCtrUVlrTnhuZG50NEJZ?=
 =?utf-8?B?RnhrU1g2U2JNYzRyeWE1UTBZcThOVkJ6dDY0NEo2NXU0UjQxYUxRMnZpYS9L?=
 =?utf-8?B?b2wxSzFhUFR5aWNGaC90U1RhZXM2SVlqU0NKQUNBOWFnbGRUYldFVkRReFZ4?=
 =?utf-8?B?YU9HSUxUTUQyZ05GcXdCc25GUjJndWNpYW14MzdCS3llbHRqbklWbGVVWWVR?=
 =?utf-8?B?RDUxbVI4QVVYUXE0T2FwNEowcFRaYlpjOXdjaVR6blBjSWpTb3A2c29HQUNG?=
 =?utf-8?Q?kP5ne1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RW04dkJER0ZPZ1RGUlJlKzVVVUVWeEp4V1REV3p1WE83TFdBY0ZtVUw2cGIr?=
 =?utf-8?B?OGw3djh1Y2hBbUNEOVdYcGoxTnpnTGxzSjh6MGhyNHhKK1FZWWxPZjZPWHls?=
 =?utf-8?B?UlU3TGdycU1tK2ZpOUJOR0EvTEhYUkZkYzh2dnF4MXlQRkc1ZDR4cUVOQ2VD?=
 =?utf-8?B?Nk1UTCtxT3BkdlYzRUpCcmdFQzNsQm8wYzFLUUNwYVVQNjliWTRud2duOW4r?=
 =?utf-8?B?emxYSE1ZTWg0UFhUSEI5anEvQ2FtR1d3YjRMT1BIdlplVXpTUHhpQTFrakhO?=
 =?utf-8?B?M3B5eHpEUDNxZ0RZNDRMSEIyRnRMSUlqcitkdDB2U2lEcUxlYUlwZ0YwR2dw?=
 =?utf-8?B?N2Jsais2RWJVTk1uUkFsQTB5amVUbXhJQTRmSFlraERIUmVJUzhKQmJEcTk4?=
 =?utf-8?B?emdMWHZJVkpqaEhGUUhBcEtLODVCbXZtY2N0T2w4eDNxQWY0SzRpZEN5eEta?=
 =?utf-8?B?T3l3T092dTlncGZUN1kzWFNBWXQweURkTm1NazJTLzdwQ2phK0lEMUxuazlQ?=
 =?utf-8?B?K2xoMk0zb3dJaUhwT1BBYTBYNTZoNGZzNUNmRHhobHlodjIzTlhreGZjRGtL?=
 =?utf-8?B?dzZKN3p0NVZnYTQ0anBId1o0UWhvMzMxeEltaXNKS2NBc00xQTdkSFBnTFNm?=
 =?utf-8?B?Z2hiek95d291V3ZmWWNpMHkxWksrbWFOWFZWbWR6Q25yZXBLSENOblhuN2hG?=
 =?utf-8?B?YXhIR1dsbHQralBrOGF0T2d4SHQ3S0dWM2hMaklmamkreVNzajVOMlZEUzl0?=
 =?utf-8?B?elBoUkhBVkFHWWpUbjRlemR1SytJczRpWk5tOTlkSFVnUTc1cWRjbnZBcjk0?=
 =?utf-8?B?RTRqMklvRkR3ejFERDFlUVVvdVd2WU90bjVNdUtvbVBGWXo1WW5semxtQUhp?=
 =?utf-8?B?dThOaEljRzU3OTFleU50b2N3YVVFdm03YTJCVDRPN1M4TXlXMmMwYUFVbXph?=
 =?utf-8?B?YXVmanZyaW5YTkx2N0tSQ05JekFpeFp2SGRFUFBVTFFZeVhVOW1lTVNDV1NG?=
 =?utf-8?B?QmVJSkFkUXYxMk5ORUpObi8xN2VQZ2NqMFp1VFcwRlBaRWYxU25sU0pTMkQy?=
 =?utf-8?B?ajN2TU5lVGFXUXVEM0xVdmpqVjBuSXlNdTlWUWFWK29tQWJkOTY5MG54QW90?=
 =?utf-8?B?WUdqWUZUR2tzY0VDaUs0MGwyZ3RUakI2WTJWY2dUaFdkR3hhbC9NUU14U25l?=
 =?utf-8?B?c3FDK2QvRFR1Wno3QUtiVmY1d0RlUTVHM2pDMzM0TmM0MnYzL3RQQ2sxajdC?=
 =?utf-8?B?Nkg4b3NFR0wzMDVVUUhZakNGbmpUNGZObXNici9IVUNRZSszSmVxMEY4NmJu?=
 =?utf-8?B?VnNuSmh5K05lUlFWdlUwM25MVVZGZ2lQb3V5c3phV0NFdGNBUnF0Y2hDTWRq?=
 =?utf-8?B?NzVSZ21ZMmw2N3NZV0FGSHpKK1h2Q0RvblU4UUxBMHBJdmZQMUdGRmU1Vmov?=
 =?utf-8?B?em1aTUNUWkNCd0tUalRzTHNpYzVEZHFFTXhlbHFoQ0VJb3lMSzdmYWVQTmhR?=
 =?utf-8?B?Tm9Cc2xwNXJpNUdJUHpWNmIxTjZPb055UEFYZGdnL1hvN216bWhyaFdVN0FS?=
 =?utf-8?B?VmE1RjM1MXhwQmgxL3RIMGdwU0xRVm8zL1gzSXdRT0Vva0h2c2RrODFWcWNw?=
 =?utf-8?B?NFcrU3p5VGdtcDIrWlhOU0Z2QlppTUhabCsremRza2FTcE81NXZvR2RERnk0?=
 =?utf-8?B?MHNNZjFMNlBPd3dkWDZBYmpiR042TFM1WjdobUpTWFFOc1V0YityaExzak9l?=
 =?utf-8?B?VTBzcStvTWE3eTdxd2g1QW4wOHZzRVhId1hpbjNzUkIxcTI0VEQrQ0Zrdmtu?=
 =?utf-8?B?cTZsYjRyTkFuZUhuTFlvQWo4eC90M3o5MHIvd0QveHFTTFhGVFFuMElHeVYx?=
 =?utf-8?B?bG9rbEhtZ25mUVo0NWJyWUk1YjE3b1pnVXV5VUlLOWdRcTk5MVUrVHpFYUVv?=
 =?utf-8?B?U0srejgxUzAzU3dRWTBJNUxSaXdzSzJJZjNTL3V5YTRPeTRMUU5QNGNiM2RW?=
 =?utf-8?B?T3J0Y2hZbGZUZDhScHRMSXExbnJpbWxtcXdoM3BlSXlBRDBKVlJsTjU3R1RL?=
 =?utf-8?B?U3N2UWJubFNKL1p2dnpvTFl4REtQMnNOR0VIOHVOZmdSU3ZFVFBwaDV2aWtI?=
 =?utf-8?B?YUxOVjRxREpvWFhOMnlodUNjaFZieXBIWkV1ckRIaGxZczZuQ2ovcWV6SHhT?=
 =?utf-8?B?MXhEYStaM3B6VlNrOFZIRVVSOXoraSs3R0N5RzhyaGlPY29jT2xINzViTTk3?=
 =?utf-8?B?ODhxQlFOaXg2dkdjdUJ6clJ4TENnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81EEC3DD92C0DB4B8896DECED8E9638E@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ff8299-aaec-4495-6f7d-08de2c5be539
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 19:50:33.2343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZsALXEIMN1pO0CHwkvy3oXnv05W2mMvQ0o4rRxfdt2CkTFgd85/Om928GFWd2snBZ4nx9DMBTDuFh7gNIHRtzvAqUKoEvDH5BsApEN+LXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9461
X-Proofpoint-GUID: 0hx_k4bGVlf35TicIXo6WKnPTHsh6Cll
X-Authority-Analysis: v=2.4 cv=YOaSCBGx c=1 sm=1 tr=0 ts=6926088e cx=c_pps
 a=MX41ehtHJXReCjFqbJPviQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=v3ZZPjhaAAAA:8 a=1XWaLZrsAAAA:8
 a=X7Ea-ya5AAAA:8 a=20KFwNOVAAAA:8 a=brtQwP6Ytt1gJRUEcjQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0hx_k4bGVlf35TicIXo6WKnPTHsh6Cll
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2NSBTYWx0ZWRfX9llG+F+CWt5i
 ywnEpItlvENpY0O3FJyFjIjhDsoM5zNJiy+VBcC3tXP+wjny09FweT8YPc3XMxCCu2iwfEU6pdg
 Uo4QA10GWCE1JlvJOu0nPIMfHwqyUbdFSdxaiAVJTGV0HRJKoRnhIpAqRPtC3AfK19eB784tPSG
 87YZwlLPeLNmmNUMMK5c0s386LkxXV7P3NtHxLOuF1exW+9xUBmVcP+pyGOTip6sG4oMAFUjeQm
 ms12+tL2fhxMh88m1s7tYuZAWP9rzeJzB1F5WkNYH+j+9YKJxZpkHtgga8CMBvGytDaBHbFm5Tt
 LVEyALPZ7jzi+sWYnspxCvlfcKj2DQISuioDaGNvAQtDrjF+vEoLmcLLK+CvoslYRq5s9srwm3S
 xY/1exF8ZHjZioVwmySzsexiAATTRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDIwLCAyMDI1LCBhdCAxOjEx4oCvQU0sIEpvbiBLb2hsZXIgPGpvbkBudXRh
bml4LmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBOb3YgMTksIDIwMjUsIGF0IDk6MDDi
gK9QTSwgSm9uIEtvaGxlciA8am9uQG51dGFuaXguY29tPiB3cm90ZToNCj4+IA0KPj4gDQo+PiAN
Cj4+PiBPbiBOb3YgMTksIDIwMjUsIGF0IDg6NDnigK9QTSwgSm9uIEtvaGxlciA8am9ubWtvaGxl
ckBpY2xvdWQuY29tPiB3cm90ZToNCj4+PiANCj4+PiANCj4+Pj4gT24gTm92IDcsIDIwMjUsIGF0
IDQ6MTnigK9BTSwgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPiB3cm90ZToNCj4+
Pj4gDQo+Pj4+IE9uIEZyaSwgTm92IDcsIDIwMjUgYXQgMToxNuKAr0FNIEh1ZHNvbiwgTmljayA8
bmh1ZHNvbkBha2FtYWkuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+PiANCj4+Pj4+
PiBPbiA3IE5vdiAyMDI1LCBhdCAwOToxMSwgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUu
Y29tPiB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+PiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4+Pj4+PiBUaGlzIE1l
c3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXINCj4+Pj4+PiBUaGlzIG1lc3NhZ2UgY2Ft
ZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uDQo+Pj4+Pj4gfC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+
Pj4+Pj4gDQo+Pj4+Pj4gT24gRnJpLCBOb3YgNywgMjAyNSBhdCAxMjo0MeKAr0FNIEh1ZHNvbiwg
TmljayA8bmh1ZHNvbkBha2FtYWkuY29tPiB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IA0KPj4+
Pj4+PiANCj4+Pj4+Pj4+IE9uIDcgTm92IDIwMjUsIGF0IDAyOjIxLCBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gIS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18
DQo+Pj4+Pj4+PiBUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXINCj4+Pj4+
Pj4+IFRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4NCj4+
Pj4+Pj4+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tIQ0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBPbiBUaHUsIE5vdiA2LCAy
MDI1IGF0IDExOjUx4oCvUE0gTmljayBIdWRzb24gPG5odWRzb25AYWthbWFpLmNvbT4gd3JvdGU6
DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gT24gYSA2NDAgQ1BVIHN5c3RlbSBydW5uaW5nIHZpcnRp
by1uZXQgVk1zIHdpdGggdGhlIHZob3N0LW5ldCBkcml2ZXIsIGFuZA0KPj4+Pj4+Pj4+IG11bHRp
cXVldWUgKDY0KSB0YXAgZGV2aWNlcyB0ZXN0aW5nIGhhcyBzaG93biBjb250ZW50aW9uIG9uIHRo
ZSB6b25lIGxvY2sNCj4+Pj4+Pj4+PiBvZiB0aGUgcGFnZSBhbGxvY2F0b3IuDQo+Pj4+Pj4+Pj4g
DQo+Pj4+Pj4+Pj4gQSAncGVyZiByZWNvcmQgLUY5OSAtZyBzbGVlcCA1JyBvZiB0aGUgQ1BVcyB3
aGVyZSB0aGUgdmhvc3Qgd29ya2VyIHRocmVhZHMgcnVuIHNob3dzDQo+Pj4+Pj4+Pj4gDQo+Pj4+
Pj4+Pj4gIyBwZXJmIHJlcG9ydCAtaSBwZXJmLmRhdGEudmhvc3QgLS1zdGRpbyAtLXNvcnQgb3Zl
cmhlYWQgIC0tbm8tY2hpbGRyZW4gfCBoZWFkIC0yMg0KPj4+Pj4+Pj4+IC4uLg0KPj4+Pj4+Pj4+
ICMNCj4+Pj4+Pj4+PiAgMTAwLjAwJQ0KPj4+Pj4+Pj4+ICAgICAgICAgICB8DQo+Pj4+Pj4+Pj4g
ICAgICAgICAgIHwtLTkuNDclLS1xdWV1ZWRfc3Bpbl9sb2NrX3Nsb3dwYXRoDQo+Pj4+Pj4+Pj4g
ICAgICAgICAgIHwgICAgICAgICAgfA0KPj4+Pj4+Pj4+ICAgICAgICAgICB8ICAgICAgICAgICAt
LTkuMzclLS1fcmF3X3NwaW5fbG9ja19pcnFzYXZlDQo+Pj4+Pj4+Pj4gICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICB8DQo+Pj4+Pj4+Pj4gICAgICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICB8LS01LjAwJS0tX19ybXF1ZXVlX3BjcGxpc3QNCj4+Pj4+Pj4+PiAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgZ2V0X3BhZ2VfZnJvbV9mcmVlbGlzdA0KPj4+
Pj4+Pj4+ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICBfX2FsbG9j
X3BhZ2VzX25vcHJvZg0KPj4+Pj4+Pj4+ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
fCAgICAgICAgICB8DQo+Pj4+Pj4+Pj4gICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICB8
ICAgICAgICAgIHwtLTMuMzQlLS1uYXBpX2FsbG9jX3NrYg0KPj4+Pj4+Pj4+ICMNCj4+Pj4+Pj4+
PiANCj4+Pj4+Pj4+PiBUaGF0IGlzLCBmb3IgUnggcGFja2V0cw0KPj4+Pj4+Pj4+IC0ga3NvZnRp
cnFkIHRocmVhZHMgcGlubmVkIDE6MSB0byBDUFVzIGRvIFNLQiBhbGxvY2F0aW9uLg0KPj4+Pj4+
Pj4+IC0gdmhvc3QtbmV0IHRocmVhZHMgZmxvYXQgYWNyb3NzIENQVXMgZG8gU0tCIGZyZWUuDQo+
Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gT25lIG1ldGhvZCB0byBhdm9pZCB0aGlzIGNvbnRlbnRpb24g
aXMgdG8gZnJlZSBTS0IgYWxsb2NhdGlvbnMgb24gdGhlIHNhbWUNCj4+Pj4+Pj4+PiBDUFUgYXMg
dGhleSB3ZXJlIGFsbG9jYXRlZCBvbi4gVGhpcyBhbGxvd3MgZnJlZWQgcGFnZXMgdG8gYmUgcGxh
Y2VkIG9uIHRoZQ0KPj4+Pj4+Pj4+IHBlci1jcHUgcGFnZSAoUENQKSBsaXN0cyBzbyB0aGF0IGFu
eSBuZXcgYWxsb2NhdGlvbnMgY2FuIGJlIHRha2VuIGRpcmVjdGx5DQo+Pj4+Pj4+Pj4gZnJvbSB0
aGUgUENQIGxpc3QgcmF0aGVyIHRoYW4gaGF2aW5nIHRvIHJlcXVlc3QgbmV3IHBhZ2VzIGZyb20g
dGhlIHBhZ2UNCj4+Pj4+Pj4+PiBhbGxvY2F0b3IgKGFuZCB0YWtpbmcgdGhlIHpvbmUgbG9jayku
DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gRm9ydHVuYXRlbHksIHByZXZpb3VzIHdvcmsgaGFzIHBy
b3ZpZGVkIGFsbCB0aGUgaW5mcmFzdHJ1Y3R1cmUgdG8gZG8gdGhpcw0KPj4+Pj4+Pj4+IHZpYSB0
aGUgc2tiX2F0dGVtcHRfZGVmZXJfZnJlZSBjYWxsIHdoaWNoIHRoaXMgY2hhbmdlIHVzZXMgaW5z
dGVhZCBvZg0KPj4+Pj4+Pj4+IGNvbnN1bWVfc2tiIGluIHR1bl9kb19yZWFkLg0KPj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4+IFRlc3RpbmcgZG9uZSB3aXRoIGEgNi4xMiBiYXNlZCBrZXJuZWwgYW5kIHRo
ZSBwYXRjaCBwb3J0ZWQgZm9yd2FyZC4NCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBTZXJ2ZXIgaXMg
RHVhbCBTb2NrZXQgQU1EIFNQNSAtIDJ4IEFNRCBTUDUgOTg0NSAoVHVyaW4pIHdpdGggMiBWTXMN
Cj4+Pj4+Pj4+PiBMb2FkIGdlbmVyYXRvcjogaVBlcmYyIHggMTIwMCBjbGllbnRzIE1TUz00MDAN
Cj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBCZWZvcmU6DQo+Pj4+Pj4+Pj4gTWF4aW11bSB0cmFmZmlj
IHJhdGU6IDU1R2Jwcw0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IEFmdGVyOg0KPj4+Pj4+Pj4+IE1h
eGltdW0gdHJhZmZpYyByYXRlIDExMEdicHMNCj4+Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4+PiBkcml2
ZXJzL25ldC90dW4uYyB8IDIgKy0NCj4+Pj4+Pj4+PiBuZXQvY29yZS9za2J1ZmYuYyB8IDIgKysN
Cj4+Pj4+Pj4+PiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90dW4uYyBi
L2RyaXZlcnMvbmV0L3R1bi5jDQo+Pj4+Pj4+Pj4gaW5kZXggODE5Mjc0MDM1N2EwLi4zODhmM2Zm
YzY2NTcgMTAwNjQ0DQo+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdHVuLmMNCj4+Pj4+Pj4+
PiArKysgYi9kcml2ZXJzL25ldC90dW4uYw0KPj4+Pj4+Pj4+IEBAIC0yMTg1LDcgKzIxODUsNyBA
QCBzdGF0aWMgc3NpemVfdCB0dW5fZG9fcmVhZChzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLCBzdHJ1
Y3QgdHVuX2ZpbGUgKnRmaWxlLA0KPj4+Pj4+Pj4+ICAgICAgICAgICBpZiAodW5saWtlbHkocmV0
IDwgMCkpDQo+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAga2ZyZWVfc2tiKHNrYik7DQo+Pj4+
Pj4+Pj4gICAgICAgICAgIGVsc2UNCj4+Pj4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBj
b25zdW1lX3NrYihza2IpOw0KPj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHNrYl9h
dHRlbXB0X2RlZmVyX2ZyZWUoc2tiKTsNCj4+Pj4+Pj4+PiAgIH0NCj4+Pj4+Pj4+PiANCj4+Pj4+
Pj4+PiAgIHJldHVybiByZXQ7DQo+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL25ldC9jb3JlL3NrYnVm
Zi5jIGIvbmV0L2NvcmUvc2tidWZmLmMNCj4+Pj4+Pj4+PiBpbmRleCA2YmUwMTQ1NGYyNjIuLjg5
MjE3YzQzYzYzOSAxMDA2NDQNCj4+Pj4+Pj4+PiAtLS0gYS9uZXQvY29yZS9za2J1ZmYuYw0KPj4+
Pj4+Pj4+ICsrKyBiL25ldC9jb3JlL3NrYnVmZi5jDQo+Pj4+Pj4+Pj4gQEAgLTcyMDEsNiArNzIw
MSw3IEBAIG5vZGVmZXI6ICBrZnJlZV9za2JfbmFwaV9jYWNoZShza2IpOw0KPj4+Pj4+Pj4+ICAg
REVCVUdfTkVUX1dBUk5fT05fT05DRShza2JfZHN0KHNrYikpOw0KPj4+Pj4+Pj4+ICAgREVCVUdf
TkVUX1dBUk5fT05fT05DRShza2ItPmRlc3RydWN0b3IpOw0KPj4+Pj4+Pj4+ICAgREVCVUdfTkVU
X1dBUk5fT05fT05DRShza2JfbmZjdChza2IpKTsNCj4+Pj4+Pj4+PiArICAgICAgIERFQlVHX05F
VF9XQVJOX09OX09OQ0Uoc2tiX3NoYXJlZChza2IpKTsNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gSSBt
YXkgbWlzcyBzb21ldGhpbmcgYnV0IGl0IGxvb2tzIHRoZXJlJ3Mgbm8gZ3VhcmFudGVlIHRoYXQg
dGhlIHBhY2tldA0KPj4+Pj4+Pj4gc2VudCB0byBUQVAgaXMgbm90IHNoYXJlZC4NCj4+Pj4+Pj4g
DQo+Pj4+Pj4+IFllcywgSSBkaWQgd29uZGVyLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gSG93IGFib3V0
IHNvbWV0aGluZyBsaWtlDQo+Pj4+Pj4+IA0KPj4+Pj4+PiAvKioNCj4+Pj4+Pj4gKiBjb25zdW1l
X3NrYl9hdHRlbXB0X2RlZmVyIC0gZnJlZSBhbiBza2J1ZmYNCj4+Pj4+Pj4gKiBAc2tiOiBidWZm
ZXIgdG8gZnJlZQ0KPj4+Pj4+PiAqDQo+Pj4+Pj4+ICogRHJvcCBhIHJlZiB0byB0aGUgYnVmZmVy
IGFuZCBhdHRlbXB0IHRvIGRlZmVyIGZyZWUgaXQgaWYgdGhlIHVzYWdlIGNvdW50DQo+Pj4+Pj4+
ICogaGFzIGhpdCB6ZXJvLg0KPj4+Pj4+PiAqLw0KPj4+Pj4+PiB2b2lkIGNvbnN1bWVfc2tiX2F0
dGVtcHRfZGVmZXIoc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4+Pj4+Pj4gew0KPj4+Pj4+PiBpZiAo
IXNrYl91bnJlZihza2IpKQ0KPj4+Pj4+PiByZXR1cm47DQo+Pj4+Pj4+IA0KPj4+Pj4+PiB0cmFj
ZV9jb25zdW1lX3NrYihza2IsIF9fYnVpbHRpbl9yZXR1cm5fYWRkcmVzcygwKSk7DQo+Pj4+Pj4+
IA0KPj4+Pj4+PiBza2JfYXR0ZW1wdF9kZWZlcl9mcmVlKHNrYik7DQo+Pj4+Pj4+IH0NCj4+Pj4+
Pj4gRVhQT1JUX1NZTUJPTChjb25zdW1lX3NrYl9hdHRlbXB0X2RlZmVyKTsNCj4+Pj4+Pj4gDQo+
Pj4+Pj4+IGFuZCBhbiBpbmxpbmUgdmVyc2lvbiBmb3IgdGhlICFDT05GSUdfVFJBQ0VQT0lOVFMg
Y2FzZQ0KPj4+Pj4+IA0KPj4+Pj4+IEkgd2lsbCB0YWtlIGNhcmUgb2YgdGhlIGNoYW5nZXMsIGhh
dmUgeW91IHNlZW4gbXkgcmVjZW50IHNlcmllcyA/DQo+Pj4+PiANCj4+Pj4+IEdyZWF0LCB0aGFu
a3MuIEkgZGlkIHNlZSB5b3VyIHNlcmllcyBhbmQgd2lsbCBldmFsdWF0ZSB0aGUgaW1wcm92ZW1l
bnQgaW4gb3VyIHRlc3Qgc2V0dXAuDQo+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+PiBJ
IHRoaW5rIHlvdSBhcmUgbWlzc2luZyBhIGZldyBwb2ludHPigKYuDQo+Pj4+PiANCj4+Pj4+IFN1
cmUsIHN0aWxsIGxlYXJuaW5nLg0KPj4+PiANCj4+Pj4gU3VyZSAhDQo+Pj4+IA0KPj4+PiBNYWtl
IHN1cmUgdG8gYWRkIGluIHlvdXIgZGV2IC5jb25maWcgOiBDT05GSUdfREVCVUdfTkVUPXkNCj4+
Pj4gDQo+Pj4gDQo+Pj4gSGV5IE5pY2ssDQo+Pj4gVGhhbmtzIGZvciBzZW5kaW5nIHRoaXMgb3V0
LCBhbmQgZnVubnkgZW5vdWdoLCBJIGhhZCBhbG1vc3QgdGhpcw0KPj4+IGV4YWN0IHNhbWUgc2Vy
aWVzIG9mIHRob3VnaHRzIGJhY2sgaW4gTWF5LCBidXQgZW5kZWQgdXAgZ2V0dGluZw0KPj4+IHN1
Y2tlZCBpbnRvIGEgcmFiYml0IGhvbGUgdGhlIHNpemUgb2YgVGV4YXMgYW5kIG5ldmVyIGNpcmNs
ZWQNCj4+PiBiYWNrIHRvIGZpbmlzaCB1cCB0aGUgc2VyaWVzLg0KPj4+IA0KPj4+IENoZWNrIG91
dCBteSBzZXJpZXMgaGVyZTogDQo+Pj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L25ldGRldmJwZi9wYXRjaC8yMDI1MDUwNjE0NTUzMC4yODc3MjI5LTUtam9uQG51dGFuaXgu
Y29tLw0KPj4+IA0KPj4+IEkgd2FzIGFsc28gbW9ua2V5aW5nIGFyb3VuZCB3aXRoIGRlZmVyIGZy
ZWUgaW4gdGhpcyBleGFjdCBzcG90LA0KPj4+IGJ1dCBpdCB0b28gZ290IGxvc3QgaW4gdGhlIHJh
YmJpdCBob2xlLCBzbyBJ4oCZbSBnbGFkIEkgc3R1bWJsZWQNCj4+PiB1cG9uIHRoaXMgYWdhaW4g
dG9uaWdodC4NCj4+PiANCj4+PiBMZXQgbWUgZHVzdCB0aGlzIGJhYnkgb2ZmIGFuZCBzZW5kIGEg
djIgb24gdG9wIG9mIEVyaWPigJlzDQo+Pj4gbmFwaV9jb25zdW1lX3NrYigpIHNlcmllcywgYXMg
dGhlIGNvbWJpbmF0aW9uIG9mIHRoZSB0d28NCj4+PiBvZiB0aGVtIHNob3VsZCBuZXQgb3V0IHBv
c2l0aXZlbHkgZm9yIHlvdQ0KPj4+IA0KPj4+IEpvbg0KPj4+IA0KPiANCj4gRGlkIHNvbWUgdGVz
dGluZyBvbiB0aGlzLCBpdCBkb2VzIHdvcmsgd2VsbC4gVGhlIG9ubHkgZG93bnNpZGUgaXMgdGhh
dA0KPiB3aGVuIHRlc3RpbmcgYSB2ZXJ5IGhlYXZ5IFVEUCBUWCB3b3JrbG9hZCwgdGhlIFRYIHZo
b3N0IHRocmVhZA0KPiBnZXRzIElQSeKAmWQgaGVhdmlseSB0byBwcm9jZXNzIHRoZSBkZWZlcnJl
ZCBsaXN0LiBJ4oCZbSBnb2luZyB0byB0cnkgdG8NCj4gc2VlIGlmIHRhY3RpY2FsbHkgY2FsbGlu
ZyBza2JfZGVmZXJfZnJlZV9mbHVzaCBpbW1lZGlhdGVseSBiZWZvcmUgDQo+IG5hcGlfc2tiX2Nh
Y2hlX2dldF9idWxrIGluIG15IHBhdGNoIHNldCBoZWxwcyByZXNvbHZlIHRoYXQuIFdpbGwgY2hl
Y2sNCj4gdGhhdCBvdXQgdG9tb3Jyb3cgYW5kIHJlcG9ydCBiYWNrLg0KDQpIZXkgTmljayAtIEni
gJl2ZSBwb3N0ZWQgYSB2MiBvZiBteSBzZXJpZXMsIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBleWVz
DQppZiB5b3XigJl2ZSBnb3QgdGltZSB0byBnaXZlIGl0IGEgcG9rZSBhbmQgc2VlIGhvdyBpdCBo
ZWxwcyB5b3VyIHVzZSBjYXNlPw0KV291bGQgbG92ZSB0byBzZWUgaG93IGl0IGZhaXJzIGluIHlv
dXIgaGlnaCBzY2FsZSB0ZXN0LiANCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L25ldGRldmJwZi9jb3Zlci8yMDI1MTEyNTIwMDA0MS4xNTY1NjYzLTEtam9uQG51dGFuaXgu
Y29tLw0KDQpUaGFua3MsDQpKb24=

