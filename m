Return-Path: <netdev+bounces-232812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A344BC090A2
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291871B24F15
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 13:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E732E2877FC;
	Sat, 25 Oct 2025 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Him1q17a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525E01C5486
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761397839; cv=fail; b=AlohiOXDzWrifzpT6jzW/xncE60HXIBLn5xCClRpijj8HjVgVO2UhhQ3GfidlRGUgtEPtgR84kCTX5KJoCJ7B4/1m3/cjdqWkaVkzML1WYjyFEUvQcvRDjS7PFGjSxM1BY/tn8riNU4nKoQqXzOQuL4VyTgTfgtklzJydTa2GOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761397839; c=relaxed/simple;
	bh=ePs73FUcp2katKKv4QK58Cnv5p43j+4N0IHUsyRQX9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KHzhOtUULaVUyjlHsJuaxR1icfwOH15u4ktQHYz+lV/q7CR75PhdjpBGHax01Xaspdn4us4YEVvMD/F9DQeabdn9ItlsdC9HBBFHbOAezNg/1+sDPGnWLWD8C3SPnJZ44f/cFUnAfQZ8tvp8jkOMtHnxNKQHgfH6gO0N2m98KIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Him1q17a; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59PCTx771130124;
	Sat, 25 Oct 2025 06:10:34 -0700
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020108.outbound.protection.outlook.com [52.101.61.108])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a0nev8rts-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 25 Oct 2025 06:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StF9a+ZQDZ9Expycm7Suh6kImtg9nZ4wL3vWGFpn8H4DP4Q04P8c2l1rhsNx9J+sRjg99401myXZNl0B7mB5RL+sAi09jfuXwLiCWL3Wo+Eu4dmIRD3a475qgj7K+0FSAHA8VMzZNTpvTiRearZvpPPA2C3WPtDMr8nICMwklscFk3FSDmqUAFxduWddp4xMz95dSuEfPVgboPTqXTJgKhYfdrCxxVr1wkLtcGlVgHiQWdtT8kQML81QwZtucSAaFVw3kUAcAzoS5x/9kYzrdDAX9dFI8j3kZzpwljcL6WkDtgfsqGLMwuWo+4FyXkmSUnueeoL0eHqBXSivWDavyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePs73FUcp2katKKv4QK58Cnv5p43j+4N0IHUsyRQX9Y=;
 b=rD5WUKtE5LhUSzSp7FAfTayWCIT6d27/ypIHIBgcjiVYHkyJ+1IJK8eZ+yvs5nIduknABaYq8r6GX7/Cn42jO93kIi/5r25YGmh1ppbWB1VqTtX58fpZdhRayL1maiK2NUv/g1RAAw91790kHAlq1HON+JEvdXvB+rOq8+3dZhliZdwaEnz03kVwhubZoQ9YkFmRqu4bS+8SUoEVjFtFO9vWnoK1qyZpf3VmNwJPHYkZyB+sUd4WeWWRAzIU161JfQEx6/SPacI1ULLNAFznY+XHUZszwxhLAgwQp0h8MDdRBVeioXdNdo6wlngsnWWNuXWNC9vnoiqBhoHPnW3Zhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePs73FUcp2katKKv4QK58Cnv5p43j+4N0IHUsyRQX9Y=;
 b=Him1q17aTb/1QgCRgOudHycZANrPELAOw2Fnipg9q1yPhRXepQxkAhnTIAUBRgQWXOXG8v0HjYvE1a1JuMCvimNjnSAnAjH59iDo79zCXf4uImqUEk/Wn05jOROM4TlzUCuSm1U41PJXtl2DrfqzrRY8CeyQLsENzPDdiFfpxd8=
Received: from MN0PR18MB5847.namprd18.prod.outlook.com (2603:10b6:208:4c4::12)
 by BY3PR18MB4722.namprd18.prod.outlook.com (2603:10b6:a03:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Sat, 25 Oct
 2025 13:10:31 +0000
Received: from MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0]) by MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0%5]) with mapi id 15.20.9253.013; Sat, 25 Oct 2025
 13:10:30 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Netdev <netdev@vger.kernel.org>
Subject: Re:  Re: ynl newbie question
Thread-Topic: Re: ynl newbie question
Thread-Index: AQHcRbC9dlu4wvCkAU6bg2004geX5g==
Date: Sat, 25 Oct 2025 13:10:30 +0000
Message-ID:
 <MN0PR18MB58478446CEBD0532BB7CD453D3FEA@MN0PR18MB5847.namprd18.prod.outlook.com>
References:
 <MN0PR18MB5847A875201DF2889543A61DD3F1A@MN0PR18MB5847.namprd18.prod.outlook.com>
 <20251024080959.55e7679d@kernel.org>
In-Reply-To: <20251024080959.55e7679d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR18MB5847:EE_|BY3PR18MB4722:EE_
x-ms-office365-filtering-correlation-id: fa3ec91c-7b66-43d3-3180-08de13c7dfd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUFBbXRibWxZZC9XVmVQekROT3RDZDNWd3dOdlJHTExSUC9SY0JBMmVITG1R?=
 =?utf-8?B?bnBxaHhNYXRvVkEyclE0b21pSlV5RDd2a1lmZExFS2c0OGdBeGdZOGRnMjFS?=
 =?utf-8?B?WXVsTURoeG12L2VJaE9HZzVJSUlVN1pObWc3WWVEVlkxcTBvTHpkS3FxcGxp?=
 =?utf-8?B?bzQ5MUJEdFFONWZ3UFBERGdObUg0cGZSaHFVY3ZNUUp4Y3FlNW9uQndnUXUr?=
 =?utf-8?B?K3gwVlplNDlMNHhrZUxsUlhXdVJNMFhvSVRFUEhTZGZWKzhhSjhnbUF3YVd6?=
 =?utf-8?B?SFkrcHNGR1Bub0pNVVRWU2FVZDNOMTNnRytXRWhheFlrS3ppZC9hQnIvZVpW?=
 =?utf-8?B?OFdsY2ZnRk9VTHhITkF3eXRrQ3pPc3EyRFN0eDhZWmYwcVgrZm9WV0hNODlD?=
 =?utf-8?B?VEF2RzJZQXQ4c2tuMzU4MFF5UjByQ0xpS1p2MDBYY3AvSG9JMit1dWpNQlpD?=
 =?utf-8?B?dWtnV2NJTXNoa3VGTTZRMkZrUU8rT0k0cW9yNGNBUmhmdk1YcENjSFo2aUtz?=
 =?utf-8?B?dWlWekZQZEo1bit6L0tyWjlpazFqMCthcmpEWXdOUjVVUTVUbjk5bmZybHNm?=
 =?utf-8?B?Mi9qeFlTZHJpd1FoNTJUckRqWTBPOEcrY0xRSW1yc0hBZUdndDJJNStseWVL?=
 =?utf-8?B?eEQ5aE9kMkR5UnFMUHVDT0hDbThSbVlXSkxnMzlqaGxTR0lGbFFkR0ZZODFD?=
 =?utf-8?B?S0FUTEFROTQ0N0RwSUtFSE1iMTRkelFESFlNc1JuRUcxT2JiVWZLbDViWUs5?=
 =?utf-8?B?N3I5MlpEVmVYdE1kWXdPTHE3Ulgrb0NYbEtqbHVOcXkvaVc3MTlwcWlmNFJs?=
 =?utf-8?B?ZUlFa2JadWhBeU80c3g0R2d6bmFRNWJyaW10amMwZGhuRmhjWWFHcmV4NkdS?=
 =?utf-8?B?WkJ0SENzY0ZZN29LTkIrdlNESWQ0dC9VSjJMclRnSUp4d2NYcGwyN1JLa3JS?=
 =?utf-8?B?bVBscGhRZXJ3ZUNGNVdOQTN6QjF2dHJrT2t0Y09pa3dJQTVEa3FVcWd4TGtI?=
 =?utf-8?B?VGZ6Q0ZFaDlmUldDOG1INHBRaURIajF4cEk1MEl6WlhsZFZaUDNmQXpsTUZk?=
 =?utf-8?B?RGhaMXB4NXhHQ0FHdkhnVld3T2lBcEduYlRTZzlIRXJhK1RRQm9hUVc2dVV1?=
 =?utf-8?B?cWlpU1VQUTJGTFB2VjhrRnNYZE14TVlHcHFuNi9uOEd3bGhnNkJScDg4Ynd1?=
 =?utf-8?B?Z0dWUnRMRWJzV01YUDNIdVA4WnZGSWJ0cWdRMVdjVjFNcU9wWWYxcjR3emFB?=
 =?utf-8?B?MFcxeUdJUExhWitPSnFMOGg2ZURLd2RuNmVDbElMY1RSOFhQckRGY1M2M1Bt?=
 =?utf-8?B?bVR4MkNMckNUek1YdFRKZnhDWjAwZzZHR1BXWUZZY3dsbDBhTmxYcEdkQnlu?=
 =?utf-8?B?UVFjNkl0VDNJNi9DNWw1NFRyaEhIWGxsT05ZQ3lFRFo5MHVmZ3J3bjhkR0Rm?=
 =?utf-8?B?aXpvNVA3UEJRLzNJdHMyRS9rN3FZZjRubGh4MG5tWFdKdWFCU3hzdmlvSytr?=
 =?utf-8?B?WkdVVGZreHlTcHZxUjVRYXFsSjJYZWJRTXVwSjV0Q293c0M0Z1QxUEVrcUVN?=
 =?utf-8?B?TlVrQW5ubElTb01MZmR3R2h5QlFuVHhVRkRvNkNnMmhZWVo2WGVkTk5lbUVs?=
 =?utf-8?B?VkRPcUpmQVYxcG4rZ3ViMFR3OVg0MnlWNUpEeWNsb2llTDhzR3Y4Z0x2dW5u?=
 =?utf-8?B?RGxqUkJZUmk3eDZTT1ZCSkpwL1oyZmYyR1BLbWQ4aXpyVkRvajU1TzVVYW1H?=
 =?utf-8?B?NTlMMHpFampkcVdsZlQ5TE1Xc2NINVN2N3lTL25Pc1l4UE5HcUppVGNTVUFm?=
 =?utf-8?B?bjhtM21ZS1ROa085VzBiZW45eUNQRzRKaWt2MU51Q0JDSUdzZG9JVW5ZWWpQ?=
 =?utf-8?B?em0zZXpOd0FBN1o5NWxFNHpRcGhYcWNJeHpHTlRKUDJLVzdiM2JPbmRwUnVT?=
 =?utf-8?B?UHB4dGVVRXpaR3JkZWJEWktXWUlvdWdsQXdjd1NmaitBK2lsQVcxbkdvOU8x?=
 =?utf-8?B?QS9SVFZjcTdTUXJqR2xSbDdSQlFZVnIrd0FzdGIxR2VLRDVvQ0QzQXk3RGF0?=
 =?utf-8?Q?kXUvqB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR18MB5847.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUZUSWZnNVduVDE0QXRYY3RnVS9GMWhoVlBxQTZHaWh1NmtHSzkzcVpjYjlY?=
 =?utf-8?B?TjE2eDh1Y1FVdUxodGVtbUFrbFRlaXlNK2psRlpWZGRsQWIzZFZ4TzlKd3BK?=
 =?utf-8?B?Q1pmZEFrRDlNckNUa09lWmtmTEVZMkJBQ0dzdjVXYjVPaTE2VzcrZk9IblB5?=
 =?utf-8?B?VHJoUGxjYTdndWpiQkdqbUVFeVlFa2g0UTJqT1VJaC90YTdUb0NDT2U1QVd0?=
 =?utf-8?B?d09ZUTUvVXJocjd2MGxwdXU2dTQ1R1YveUVXeXR1VGwxZE9qUkxnRm1YUmFW?=
 =?utf-8?B?WUU3K0EwWFRGVVNTUDZDNE1GRzdrWFRtZjF1eWRES0dUcnBmN2ZZYWk5MVp4?=
 =?utf-8?B?VmhFRCszakdvc1dHRzlrYm9mZG4zK1V4Z25uTGkxNkRDQXgyTlR2QzdNSUYx?=
 =?utf-8?B?VzJBbk4yVysvVXUvUmhZeVVQLzR2TitBM0JNb0xCYjFnK3RFQ2FoN0FrWExt?=
 =?utf-8?B?YlFhblJDVGtCNWdkY3N2VzJtY0RoTXo1ck9JTjdEMlRqbHc0UExYVFZGcHJ5?=
 =?utf-8?B?YzhsdTJPV0dNdUQ1aGxVSXBaRjNtdmdHT3FjbncyUW9XQno1NDBKUnE0cGNR?=
 =?utf-8?B?NDd4cWtmd2t5dFNycnRaS3FtdmY2Q1lNMVJQSDVQdW5tb01ZbXFZSElGV05Z?=
 =?utf-8?B?SWl1dlJkVEhxTGk4Z3phL3pKUEF6aEZseWtQUmNRbk8xU3RsVVpwbmtQUzZE?=
 =?utf-8?B?OVRYZTlEeVZ1azhzaFh6RkJZYzNSRHM1cmFwVUtvREkyVExuZ0FVaWtCcmVk?=
 =?utf-8?B?a08yWSt5SXlKOUxmWGkrWENBUFdwSU5rcUEvUnp0bDdFa2RJK3NHTTJxcHI1?=
 =?utf-8?B?b09pV2R2UmlvcVRQWVNiaFh3Wkw0bUlCa1pJb3RmWmZRZDJjSU1pcC9wWW1z?=
 =?utf-8?B?ejQySFc5Z3l4Q1Qrcm9JRk44ZmdTR3ArTXdCeGhGRnl3dDRxbElPcko4NVNX?=
 =?utf-8?B?Skd0MmpNeFdPaDhza1BLNXZjWjlOdUJFUWx4ZU84UmlubFAveE5hM2pLTUg3?=
 =?utf-8?B?TUdia05BMXZmZmI2Rm5rQ05JbVRmSktzelVFcXN5SEJGRUtLUTVkelNyQlF2?=
 =?utf-8?B?L0lmWlRhcTNRcXJVN3h3dVpCUDRnU0xBVzltLzVZeEFERHNjK2h4c0h1Kysr?=
 =?utf-8?B?SlZCVHRUSDBUcXNybDVUVmFpczV0azk0ZGVheStSVVlSbkhCSzh1dWo4VGd5?=
 =?utf-8?B?VGo3cXEvK0VZZGRIZU5VNVY1UWJ4QTVXMi8zOGZ6Z280M2xlQ2lCd0Jra2pj?=
 =?utf-8?B?RHE0YUFPZzhOUFRHVFJXdytBRVpyeVluVkxwNTFhN0p1YWhKaFpKWFBoeG8y?=
 =?utf-8?B?VUV5S1RaaUFjUjNJMlVSOTAwbE5jSGx6eUcvMWJYTXMzSk5vaGJ6d2ZwUFZ1?=
 =?utf-8?B?cDV0TGFscnVXNThNTzQ0WkZkMWEvd3VNTG5EVkd3MG1YWVU2bWlqeG1KVFBs?=
 =?utf-8?B?WFc2cW1rcjBvdW5pcTRQMWE5SG9PNW9HL0wybFpURjVyOHBmM2pDQ0d0ZW9S?=
 =?utf-8?B?TGhSRUplUUYrSWNRVEthZFZJY09WbUZ1d1dCdzNnT0ZUa0lyS2szNXRkM0dw?=
 =?utf-8?B?UnRsOVQya2NxODdxaldEMDZEN1pBbVRtWjVWSVZyOEFtS0RXekJ5ZWMxRlV3?=
 =?utf-8?B?NWxmV3llUU92UjBYYTZodUt4WFk4UExjUlFhT1JBQjRxSkt1aFBQeUVhOEhU?=
 =?utf-8?B?cHRWVDZtQ2o0eWw0SVMyWm5qR0V5ekljUzgzK29kR1pmSjkyRkczUk5SVHN3?=
 =?utf-8?B?QU02WHBzcDRPMmhlV20wNVhkTkhEajFGOWZMZ1BqVmgvaG9vNjhDNVphU3JT?=
 =?utf-8?B?bXB0Q2syRXBVNWJqd3dtUENSb0lEcDBiWjZEYzVNa3B6SnU0UkZab1NHWUh2?=
 =?utf-8?B?K29iOGdKOVRLalVETFBITTdHTloxcmp2aXZJRFdqd1RzbjQ0UTVoTkFYUUti?=
 =?utf-8?B?T0ZxOWl5MjBEd3d3UXRXcVB4WlRHYnQ1MXorUVpiWmV4K1UvMitYTHVSQ2RR?=
 =?utf-8?B?UmhpS0lRSzJjQU5zY0I5ZVR3dU4xSzA0akNDYWhTSjJLc1RhWmtUYk5oekVu?=
 =?utf-8?B?cktISGZoKzRMREVuT2ZDY2VsTEhwT2JNaTcvRWM3YTl4REFRdmExU0Z3Y1Z0?=
 =?utf-8?Q?zYv2j6NuWH/1VXwo28sJaCHnY?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR18MB5847.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3ec91c-7b66-43d3-3180-08de13c7dfd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2025 13:10:30.7790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+7IymMNhqCyrUlooUsPfSUtGuVs7lXE0rIYXvwxfXDOoEFO4wlE/xDS37f2vtU2HqtEeXRGj2ePW4kUuNHriw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4722
X-Authority-Analysis: v=2.4 cv=CNQnnBrD c=1 sm=1 tr=0 ts=68fccc4a cx=c_pps
 a=W/yVf4yN/6DpLKuKUOvioQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=7myVgaFzZH1XrTnNCHcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDExOSBTYWx0ZWRfX+rdHBUdKXKNV
 QseNZXIfXL/bltqvaJXNP0eKH7j2INDqeqyH2K7K3YXIxdJ8sHQklF+74FgG34Cp9ITElWy2FI9
 P5FLycSTeVRIsJv+ZfQzNnRmfl7HgVi3Ese+fP1KZshYOMo5s/IntcOHtYbdNQznxhnevWfrzGf
 dRK9MWOacI/jUfIxBuOb4FhOyHnEtIhJ67PPyBO+wPUDGLX9geKT2AEbut+Ta7vpBkRl4TKplp5
 5dHWD5lbRgJyBTaJhDu9zD5GLcoxz05yO149aNSXRNsuUanbI2Im2Qi6PRt7VHkwt4OaQYLQZYm
 eI20bc/eKPLd0ypVj46ysFoJor4OzSCelJSLML3JjbUOngJZC1H8gSGc8mXl0LAA4J9qWMS8+3P
 nWL3kbh//ziQgbJ8or3FRWvi6z/mmA==
X-Proofpoint-ORIG-GUID: DRYKpBM73TLxmKF7iGJQokTc9A6dlrok
X-Proofpoint-GUID: DRYKpBM73TLxmKF7iGJQokTc9A6dlrok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_04,2025-10-22_01,2025-03-28_01

RnJvbTogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4gDQpTdWJqZWN0OiBbRVhURVJO
QUxdIFJlOiB5bmwgbmV3YmllIHF1ZXN0aW9uDQoNCj5JIHRoaW5rIHlvdSB0cmltbWVkIHRoZSBz
dGFjayB0cmFjZSBhIGxpdHRsZSB0b28gbXVjaD8NCg0KQmVsb3cgaXMgdGhlIGZ1bGwgb3V0cHV0
Lg0KDQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0Kcm9vdEBsb2Nh
bGhvc3Q6fi9saW51eCMgLi90b29scy9uZXQveW5sL3B5eW5sL2NsaS5weSAtLXNwZWMgRG9jdW1l
bnRhdGlvbi9uZXRsaW5rL3NwZWNzL2V0aHRvb2wueWFtbCAgICAgICAtLWRvIHJpbmdzLWdldCAg
ICAgICAtLWpzb24gJ3siaGVhZGVyIjp7ImRldi1pbmRleCI6IDE4fX0nDQogIEZpbGUgIi4vdG9v
bHMvbmV0L3lubC9weXlubC9jbGkucHkiLCBsaW5lIDIzDQogICAgcmFpc2UgRXhjZXB0aW9uKGYi
U2NoZW1hIGRpcmVjdG9yeSB7c2NoZW1hX2Rpcn0gZG9lcyBub3QgZXhpc3QiKQ0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Xg0KU3ludGF4RXJyb3I6IGludmFsaWQgc3ludGF4DQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMNCg0KDQo+QnV0IG15IGd1ZXNzIGlmIHlvdSdyZSBoYXZpbmcgaXNzdWVzIHdpdGgg
dGhlIHNjaGVtYSBpcyBQeXRob24gc3VwcG9ydA0KPmZvciBqc29uc2NoZW1hLg0KSSBhZ3JlZS4g
QnV0IG5vdCBnZXR0aW5nIGFueSBjbHVlIGZyb20gdGhlIG91dHB1dCBlcnJvci4NCg0KSSBzZWUg
dGhpcyBpc3N1ZSBpbiBhICByb290ZnMgd2hpY2ggaXMgY3JlYXRlZCBvdXQgb2YgIHVidW51dHUg
eGVuaWFsLiAgSSBoYXZlIGluc3RhbGxlZCBqc29uc2NoZW1hIGhlcmUuDQpJIGRvbuKAmXQgdGhp
bmsgaXQgaXMgYW4gaXNzdWUgd2l0aCB1YnVudHUgYXMgSSBjb3VsZCBleGVjdXRlIGNvbW1hbmQg
b24gbXkgd29ya3N0YXRpb24gKFdoaWNoIGlzIHJ1bm5pbmcgdWJ1bnR1IG5vYmxlLCBzZWUgb3V0
cHV0KS4NCg0KIyMjIyMjIyMjIyMjIyMjIyMNCnJrYW5ub3RoQHJrYW5ub3RoLU9wdGlQbGV4LTcw
OTA6L21udCQgc3VkbyAuL3VidW50dS1yb290ZnMvcm9vdC9saW51eC8uL3Rvb2xzL25ldC95bmwv
cHl5bmwvY2xpLnB5IC0tc3BlYyAuL3VidW50dS1yb290ZnMvcm9vdC9saW51eC9Eb2N1bWVudGF0
aW9uL25ldGxpbmsvc3BlY3MvZXRodG9vbC55YW1sICAgICAgIC0tZG8gcmluZ3MtZ2V0ICAgICAg
IC0tanNvbiAneyJoZWFkZXIiOnsiZGV2LWluZGV4IjoNCiAxOH19Jw0KTmV0bGluayBlcnJvcjog
Tm8gc3VjaCBkZXZpY2UNCm5sX2xlbiA9IDc2ICg2MCkgbmxfZmxhZ3MgPSAweDMwMCBubF90eXBl
ID0gMg0KICAgICAgICBlcnJvcjogLTE5DQogICAgICAgIGV4dGFjazogeydtc2cnOiAnbm8gZGV2
aWNlIG1hdGNoZXMgaWZpbmRleCcsICdiYWQtYXR0cic6ICcuaGVhZGVyLmRldi1pbmRleCd9DQoN
CiMjIyMjIyMjIyMjIyMjIyMjDQoNCi1SYXRoZWVzaA0KDQoNCg0K

