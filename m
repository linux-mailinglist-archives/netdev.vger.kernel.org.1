Return-Path: <netdev+bounces-106031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC191454E
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88511F23AAB
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 08:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B016A33C;
	Mon, 24 Jun 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="UwujRacY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246E12BF1B;
	Mon, 24 Jun 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218985; cv=fail; b=auIeNKBgEgU/1FGMkGjJJts6KcudodDE8GD4ELCCCbIDAN5leXQdVGPgK54010Bu4wTwbNUpwhY+oC90+2jkGPVZ2VQI/q8uA4sXX5es4oklqD2meCBH75gGeQYCRaEu4RlLiSLsfNI6TKU+7zK6Cf+PvoQSkSvcmU6J4QQPR0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218985; c=relaxed/simple;
	bh=7UqsEDRTJWqcN+cNBCeHP4Jjcxsesf1i09jaJBke5G4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hNXDrtD04qRuOYq7lY/N/i7N6bvuXkLY476HEI5IQty9Oyb1FTkaN8TKD+8eAKE+D3ehk/3Ox3rGDAKcL2gbgkLS8IF0k/Y9SULcsFkaVc/8lOhHiAgrRmpH/FkuaPA4bYDOBgW2P2O6kr0sEuWUiuHhi1SfMnUlpgVwXlYGptA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=UwujRacY; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NLvlxE014517;
	Mon, 24 Jun 2024 01:49:23 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yxcgtjtj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 01:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmVwnMbIlkYVGwAkTKdzJvnwKR3/MvXiPfqfZ7PCGrXzWbhXbwJTbG4Nuch8FmjR1bg4W9CVUjiZSB1VJJsr/Ft6SZZ8n44RHHK+8cVMgA3HkNRpa+x0lidlL59VoIQvCGAVhhFd+OGowB2P8eWjGeY9SJShMBSd7MLlJvKYWTNEnuS1RdJXq4+R8eKqMy8T7+N2Njb1UZ3ehwdLJrjMrapuM8D4FJR/Bg3xbLHTnOlHpqXdgjCwrZ9hcJv9qBjAjlr0pPP85T9+/TaAB7dOo6HvjhNxjoeiqwsu3pGRKah2CCIPQt0dBS9s5xuM1k4B0MolfQen790mCzFlx5KchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UqsEDRTJWqcN+cNBCeHP4Jjcxsesf1i09jaJBke5G4=;
 b=fW1zFcbcLAtvl5rTBeP++mDgPrHOJAMQWjZvAgAxI7KANFcMfEVVnDgORM4ekai4TTPmhucB6rrXro+FPQLagyB5w1LKO9fYQM+fahpniyaV50tulPR+7y8IDD1unPPqg5iVy0yiz6L+MuHe5R2vGDEEwYezcbs6o09S9788XkqjRS9Z6fvKXCp6/zIDi1V99Ud713hMxgpQ+aaNeB7GuqWIsYKEikQWSqni1yMWkGq4cN75UeLzOYFVrvzrStV8RLfH8rx2eFGThFGXYifrtIY7c2Z0A32wB05AcPdlVYsbgEn3sz8BdeWAJD4N0GODFFNQ7XB3toPt0yh9ZaDrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UqsEDRTJWqcN+cNBCeHP4Jjcxsesf1i09jaJBke5G4=;
 b=UwujRacYwTxBJZg9tvdCzvYh9iQFp/WoK/zKv12zl5PxvzSLu0DhuHwCQBG0DsRjb7Dpl+ZpjC512MXZ9SNNjgCciVZ1FLZVk+lbzKkMlHlN80ls43vIBvWNz20MIrdB7kL3TqTQQa/EcAkEzFw8e/TwZdnMHg+3Y52QY2177xY=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by CO3PR18MB4846.namprd18.prod.outlook.com (2603:10b6:303:172::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 08:49:21 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 08:49:21 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [net-next PATCH v5 03/10] octeontx2-pf: Create representor netdev
Thread-Topic: [net-next PATCH v5 03/10] octeontx2-pf: Create representor
 netdev
Thread-Index: AQHaxhNn5j5hcb8xAEyFeoxvUdwGKA==
Date: Mon, 24 Jun 2024 08:49:20 +0000
Message-ID: 
 <CH0PR18MB4339400F88392B69B8191ADBCDD42@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-4-gakula@marvell.com>
 <20240618082528.GD8447@kernel.org>
In-Reply-To: <20240618082528.GD8447@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|CO3PR18MB4846:EE_
x-ms-office365-filtering-correlation-id: fb3c3076-ff11-4703-a8c9-08dc942a8a52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZmFPT1J0STd5RTNDOWIrWFg2M0tSWm9WbnU1K0owdzVKY2t5ekhrVEhBL1JK?=
 =?utf-8?B?ZzNjZm8vcFphMWZWZDVCWWhPbzJUbmZ2Nk40a2h6SjhQMFpBQXlrYVhUdk5k?=
 =?utf-8?B?WFpnMElYUURRbnc2NTVqL2MyWkJMTnJWN1pvbkJEOVNOTDhBbkUzTGlWTnN2?=
 =?utf-8?B?S0lEMXlXWlYyOHBieCtjRVZRNVgzR2NuekdmWk1TMWZUSkVaVVAzaDk3UmhY?=
 =?utf-8?B?aStpME8yOWhZTnNZUUdldlNEQWRiYUQwUlZDUFo1L0ZyeHR5RDV0dFBLczFZ?=
 =?utf-8?B?ZldmajdOUWlXd3NZR215SXNmY1pHWW5sZkNqcnhRaklyZXMxVENvRFlDTmUx?=
 =?utf-8?B?eHBWRW9JQ0RWd3k2TkVYV0ZKdGxIU1ltRmx2bmRVWVBBM1p1SHRQTHY0dzdh?=
 =?utf-8?B?dlloQ0xqR1RwM0NsZ1hUTm1XUm42UmRvNVdBaW5ESGtwcUxRQUdJUmpRSnpC?=
 =?utf-8?B?d2o3aUk5QUUxMHIyZWZHRGp3THQ1RXM2Tlp2bnhGOWkwRmVSRkJTUWZOYmlq?=
 =?utf-8?B?L05abkxtczlGK0hNSU0vaXhMNEpuOFNURHNPcHF6eEJpMzgzOFRYWDNjV0FH?=
 =?utf-8?B?ek82K1RPK2pVNGlndVNBL21ZWWRrTksrWVlleXdtZ3VaVnZZeDN1eURUVUZE?=
 =?utf-8?B?M2JmWWVRTDM1UFNhYkdzRWI2RCtzL3BWVlRnMys3dkFKK0Y2MXZSaHpYTG85?=
 =?utf-8?B?b0JzRVVMekVVT3E3WUxJZllYeUlPT1pkM1FWNTRpNzVmdWpJOXRhelY3c1dM?=
 =?utf-8?B?N28vdVZWeG50YzlzUjdUYVVreVJuelgzblEzckhTRENPd0dGS05uNmV5MXEz?=
 =?utf-8?B?K0hodDh6QXlySENGeDR6a1hqZkZmK21mT2ZPTjVTWW8rb3JtQXFiQVdJWDZ4?=
 =?utf-8?B?YVZHbHZOSkorNDJiSVkxVldhUnpaSUlITzBKcS9peXhHVU55WnFOcFFIZTkw?=
 =?utf-8?B?RVdNOUNuaGpIanBnSUFaSVI1cDd2c3Y4MHB6NmhPdkNxeCtIUmVkT2dkZVc0?=
 =?utf-8?B?VCtIbVJ4VUJvVUx1ZUVraE9Ja2VnUUlRK3lhVk5kK0FhdGhLYjVCN1EwcUxF?=
 =?utf-8?B?VFJJbzZwSERHckpLVzZUdGxidWs3dXNJa0hrSXhrd2JnU2srVXNWU2RhWlM4?=
 =?utf-8?B?SmJTS0U3WjVhMGw0T2JIWE5jNVZZQ2cyVUp4RFZoZHVPTmI5ZnFWazBrQlRv?=
 =?utf-8?B?UFVlUHB6ZmtBS0doK29uUEJnSlpOa0UrUTFoVmhsT1ZaaUNFYlk3ZFFTMnJG?=
 =?utf-8?B?R0tpSmxDMG1KZDJQbzBQRDJ6Y1V1eVE3ZWZMcE1INGtVV1JEOUlXL2k0NWRq?=
 =?utf-8?B?dFpQd29mMW11Q3BodVlrZGluYkNUVXVPWnJLV1ptaVNwNVY2Q2s2aDI5Qzhm?=
 =?utf-8?B?MjRwS0l5bWFKeG9YeXFvaVhJblVyU1g3ZXVkOHBiZ2NTMVJ4VnJ4Z2t0MUcw?=
 =?utf-8?B?eW9DSkRDNFFzalZ2UXg4MEdjMlh6WjM0UThhcW1oNlJsOXc0L2ppSTVTTmlz?=
 =?utf-8?B?YnVtaHNvZkF2b1VYeG1DZEVFMER0c3lIV20ydTNVRE1YRnZxMklsYWFwUGJ3?=
 =?utf-8?B?eUM2VVRlRFZEcVNXalplaUpVL01TUXRPaFMxQ25mV0plM04xNURHU0RvYWFR?=
 =?utf-8?B?VktXTTdaVVdNckJaQ0NSd2thU2UyY1p3bVIvMFRKelFkT0YrbEIrY1pKYUh5?=
 =?utf-8?B?dnp6YWN0S3hRSC9GMlhMd3M1Y3RnUmM1THdJUTdGWDNNMEtUNHVibktYeHhn?=
 =?utf-8?B?bGdEeWRyNlBnaDZDdFh5a3IwZXR1QVpOY3dUVXZSK3hvSGZVczNrZ0J3TDAr?=
 =?utf-8?Q?0Zl3vuF3os+KBw3B15gyRdGYb3t0zbOq17zkU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N25kSVZEZzYrRFVxamZHU1FWUTBGNTlUN2dNRW9uUXJEaUVHN29jZmxkVmtE?=
 =?utf-8?B?dEhQS2xubjdHVmpQaTFkT2RFS1c5akNoYVhxVS80VzA2S2FqUmJoYVJpZ3U1?=
 =?utf-8?B?YXRpbnNHVHFKeTRzLzhETmNrUFVoYWlwMXdPZ0dGdFl3VmpxWER5a3NZeGFX?=
 =?utf-8?B?RUlyWGxZZ1NEcWZEWUVUdjdORVY1Z0JINXhUQkV0U3IvSjl2Zk0zNHdxL3dO?=
 =?utf-8?B?Q3VrUytrUzVlaDZBTnJ5VGorcUhVMGR3bHUzNHJuUithb09mNnVEeWk1Y0t0?=
 =?utf-8?B?YzVMWGVyUlNRQ0h3b29wbUM2ajNNNEs2anE2ajR2U0E0Z1VteDByeHQxZS9C?=
 =?utf-8?B?aVd1WHAxTzJncS9mS3JCemFiaG52NHNOcDJpM2RERStTVDYvbjljN2dQNkl3?=
 =?utf-8?B?Z0N0eVIwYThQbmFpUk9jd0p4MllwRGZuclFEMkd5TlE4Qkp4aWE4OXFFUTl5?=
 =?utf-8?B?TDhnNHN6eTNJMDJIZUlEUjMwM2haSERRZE1FU2JIOURJZExzYnBpOVdNeFZv?=
 =?utf-8?B?Q0RkUEppQWhWZDJRV3U3R3pHVHZOZWJlV0NyQWpPZDhBM21RbXFQTzVncGc1?=
 =?utf-8?B?UnBLckVKZXFCUjV2R2s5UTB5cjVCZTROYmxsK3NCQmRvMEZ1anJQMWpXcU5s?=
 =?utf-8?B?RVJmQk4rZTJNdUdDT0d1WUFDTjhVOWFrTmpkM1IvVzlucHVOdDNUWDJSY2Vz?=
 =?utf-8?B?QWVJaVFjN2s0YTBEL1N3MDRnOUNDZmJvVDBKUkR2RDYvRld6dHRIY2RUdUlQ?=
 =?utf-8?B?U0tKTEpCWFhVODFVSWRsb1d4NGZldFNpd1ZjREsrOUdOdXAzdlA2bXdJNmNG?=
 =?utf-8?B?WGVWN1ZZdmdhcGJNNjhMcnN4Rm5jQ0tQQkFHd2lyNEZsRWhXNVc3cHJEK0x6?=
 =?utf-8?B?RHE5Z09zcHVLNHpIQmNZV3JjRTJHY1dkdXNTR0ZuMHE0UW9GeG5GK05PNGZn?=
 =?utf-8?B?bUl0NGUwNHpjNTJQbmdxcXByajBFMXZiSDRsSHBtZ0RJRURiQWxmUEc5T0Zm?=
 =?utf-8?B?eXBRdHJnb2NpZHI3blF4L01rUVFVM2phQW45eUxtUWZWaHZDSWtsWndqOXhP?=
 =?utf-8?B?RytCd3hEbjY5akFBb25mdkZaN1ljYytDdEs0U29iYm5BcmNNQzgzUGdVb3R5?=
 =?utf-8?B?YjFxaTEvcWh3NUt5bVBhVTJhY1ZqeGxYNVAzWXZkWTJHU05XZXN3cW9HTFRQ?=
 =?utf-8?B?RFNYYmpKcG5kZGZ3bjliKzBocUh5Ulk4emtiSEtJYjlRUmMzT29XclJlQ2RM?=
 =?utf-8?B?Wk5pS0ZOcWZwQVRUU0dBVTFjWnhKZTB3NHBiOE12bmYwOVl6bndFalR4UDc1?=
 =?utf-8?B?TEZlU1gvSUV2Rmw1MmdZamZMQjVOdnNIVEd4SDM5K1NKUjlTY21mM0VkcUs5?=
 =?utf-8?B?bVZSWWZZb2hZR0M3dk9JSWhjMUtEUUdvYzZRMVQyQ1BQL1NxN2R2Vzd4NXZP?=
 =?utf-8?B?QXNyS2NZeXZyM3p0eTRjdmdiUlk2VS8xeDhHaXkvODZpa05CNlIzV0dJOW9J?=
 =?utf-8?B?NmNmY0dPYXc4MTNUWnZGZWw2Ri9lMExsOHdFWnlkY09OaW1KWE0yYmptbXhj?=
 =?utf-8?B?c1VrNFNzMkF1WDdiSWM4aHFWNVlueXRaMFh4akIwUHJxa0o5TVNwa0dMMWRN?=
 =?utf-8?B?bkE0OXRjZjRaWjRNSUx3elBQemlTYThPZkdTQmFBc01ueFFNZnd2c08rbVQ5?=
 =?utf-8?B?TC95WjFWbzBIOTJJaVk0akZ0L2gwNkQ3MytrM2ZoWDFkTVVvZlpweWZmUytO?=
 =?utf-8?B?UHdRbUtoUUQrb3pFN2hta2hLK044T3NZbkNNanZjeld5R01HSFJqRktjSzNp?=
 =?utf-8?B?TFQ3eTE2OGcyMnN1ZnJLc0orZ3AxdlR1ZmN2K2ZXUmh5Nm56QjY1SnpXUjF5?=
 =?utf-8?B?VnJkTjRJZGVaV3BnS292czNFT210Zytub0pWbGpITG5ldm12VnQxekp0ZHlq?=
 =?utf-8?B?TTJBejkrVUJrbFh0Q2dFWmxZMXhrbnZ3VWtKK2xqQmtscVJUZ2R6T1VEWHVB?=
 =?utf-8?B?OFZ4RDNZeTg1eGEwdWhZcmxqQjlaakNNMWpXUGtoWnE2UnhxWmhReWNYaUs3?=
 =?utf-8?B?am5FS0RVN1BDRFByMkRORjN5NGVMc2hCNStiNXVMVzdROWVKMHhPZlRqdjNh?=
 =?utf-8?Q?5kRU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3c3076-ff11-4703-a8c9-08dc942a8a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 08:49:20.9892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkbDq68MOYbvmZGgPs3GLPI3UWR6UN1xBw+vDu1FTdVnASRQc0WE/JfvtYzTnv+i3A5I/MVG+L1P2qp3c8BB2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR18MB4846
X-Proofpoint-GUID: kp1PAV2nZ5nKe1Fi9wLL_UILfL3cQYH_
X-Proofpoint-ORIG-GUID: kp1PAV2nZ5nKe1Fi9wLL_UILfL3cQYH_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_08,2024-06-21_01,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNpbW9uIEhvcm1hbiA8aG9y
bXNAa2VybmVsLm9yZz4NCj5TZW50OiBUdWVzZGF5LCBKdW5lIDE4LCAyMDI0IDE6NTUgUE0NCj5U
bzogR2VldGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj5DYzogbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga3ViYUBrZXJu
ZWwub3JnOw0KPmRhdmVtQGRhdmVtbG9mdC5uZXQ7IHBhYmVuaUByZWRoYXQuY29tOyBlZHVtYXpl
dEBnb29nbGUuY29tOyBTdW5pbA0KPktvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5j
b20+OyBTdWJiYXJheWEgU3VuZGVlcCBCaGF0dGENCj48c2JoYXR0YUBtYXJ2ZWxsLmNvbT47IEhh
cmlwcmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxsLmNvbT4NCj5TdWJqZWN0OiBbRVhURVJOQUxd
IFJlOiBbbmV0LW5leHQgUEFUQ0ggdjUgMDMvMTBdIG9jdGVvbnR4Mi1wZjogQ3JlYXRlDQo+cmVw
cmVzZW50b3IgbmV0ZGV2DQo+DQo+T24gVHVlLCBKdW4gMTEsIDIwMjQgYXQgMDk6NTI6MDZQTSAr
MDUzMCwgR2VldGhhIHNvd2phbnlhIHdyb3RlOg0KPj4gQWRkcyBpbml0aWFsIGRldmxpbmsgc3Vw
cG9ydCB0byBzZXQvZ2V0IHRoZSBzd2l0Y2hkZXYgbW9kZS4NCj4+IFJlcHJlc2VudG9yIG5ldGRl
dnMgYXJlIGNyZWF0ZWQgZm9yIGVhY2ggcnZ1IGRldmljZXMgd2hlbiB0aGUgc3dpdGNoDQo+PiBt
b2RlIGlzIHNldCB0byAnc3dpdGNoZGV2Jy4gVGhlc2UgbmV0ZGV2cyBhcmUgYmUgdXNlZCB0byBj
b250cm9sIGFuZA0KPj4gY29uZmlndXJlIFZGcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBHZWV0
aGEgc293amFueWEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj4NCj4uLi4NCj4NCj4+ICt2b2lkIHJ2
dV9yZXBfZGVzdHJveShzdHJ1Y3Qgb3R4Ml9uaWMgKnByaXYpIHsNCj4+ICsJc3RydWN0IHJlcF9k
ZXYgKnJlcDsNCj4+ICsJaW50IHJlcF9pZDsNCj4+ICsNCj4+ICsJcnZ1X3JlcF9mcmVlX2NxX3Jz
cmMocHJpdik7DQo+PiArCWZvciAocmVwX2lkID0gMDsgcmVwX2lkIDwgcHJpdi0+cmVwX2NudDsg
cmVwX2lkKyspIHsNCj4+ICsJCXJlcCA9IHByaXYtPnJlcHNbcmVwX2lkXTsNCj4+ICsJCXVucmVn
aXN0ZXJfbmV0ZGV2KHJlcC0+bmV0ZGV2KTsNCj4+ICsJCWZyZWVfbmV0ZGV2KHJlcC0+bmV0ZGV2
KTsNCj4+ICsJfQ0KPj4gKwlrZnJlZShwcml2LT5yZXBzKTsNCj4+ICt9DQo+PiArDQo+PiAraW50
IHJ2dV9yZXBfY3JlYXRlKHN0cnVjdCBvdHgyX25pYyAqcHJpdiwgc3RydWN0IG5ldGxpbmtfZXh0
X2Fjaw0KPj4gKypleHRhY2spIHsNCj4+ICsJaW50IHJlcF9jbnQgPSBwcml2LT5yZXBfY250Ow0K
Pj4gKwlzdHJ1Y3QgbmV0X2RldmljZSAqbmRldjsNCj4+ICsJc3RydWN0IHJlcF9kZXYgKnJlcDsN
Cj4+ICsJaW50IHJlcF9pZCwgZXJyOw0KPj4gKwl1MTYgcGNpZnVuYzsNCj4+ICsNCj4+ICsJcHJp
di0+cmVwcyA9IGtjYWxsb2MocmVwX2NudCwgc2l6ZW9mKHN0cnVjdCByZXBfZGV2ICopLCBHRlBf
S0VSTkVMKTsNCj4+ICsJaWYgKCFwcml2LT5yZXBzKQ0KPj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+
PiArDQo+PiArCWZvciAocmVwX2lkID0gMDsgcmVwX2lkIDwgcmVwX2NudDsgcmVwX2lkKyspIHsN
Cj4+ICsJCW5kZXYgPSBhbGxvY19ldGhlcmRldihzaXplb2YoKnJlcCkpOw0KPj4gKwkJaWYgKCFu
ZGV2KSB7DQo+PiArCQkJTkxfU0VUX0VSUl9NU0dfRk1UX01PRChleHRhY2ssDQo+PiArCQkJCQkg
ICAgICAgIlBGVkYgcmVwcmVzZW50b3I6JWQgY3JlYXRpb24NCj5mYWlsZWQiLA0KPj4gKwkJCQkJ
ICAgICAgIHJlcF9pZCk7DQo+PiArCQkJZXJyID0gLUVOT01FTTsNCj4+ICsJCQlnb3RvIGV4aXQ7
DQo+PiArCQl9DQo+PiArDQo+PiArCQlyZXAgPSBuZXRkZXZfcHJpdihuZGV2KTsNCj4+ICsJCXBy
aXYtPnJlcHNbcmVwX2lkXSA9IHJlcDsNCj4+ICsJCXJlcC0+bWRldiA9IHByaXY7DQo+PiArCQly
ZXAtPm5ldGRldiA9IG5kZXY7DQo+PiArCQlyZXAtPnJlcF9pZCA9IHJlcF9pZDsNCj4+ICsNCj4+
ICsJCW5kZXYtPm1pbl9tdHUgPSBPVFgyX01JTl9NVFU7DQo+PiArCQluZGV2LT5tYXhfbXR1ID0g
cHJpdi0+aHcubWF4X210dTsNCj4+ICsJCXBjaWZ1bmMgPSBwcml2LT5yZXBfcGZfbWFwW3JlcF9p
ZF07DQo+PiArCQlyZXAtPnBjaWZ1bmMgPSBwY2lmdW5jOw0KPj4gKw0KPj4gKwkJc25wcmludGYo
bmRldi0+bmFtZSwgc2l6ZW9mKG5kZXYtPm5hbWUpLCAiciVkcCVkIiwgcmVwX2lkLA0KPj4gKwkJ
CSBydnVfZ2V0X3BmKHBjaWZ1bmMpKTsNCj4+ICsNCj4+ICsJCWV0aF9od19hZGRyX3JhbmRvbShu
ZGV2KTsNCj4+ICsJCWVyciA9IHJlZ2lzdGVyX25ldGRldihuZGV2KTsNCj4+ICsJCWlmIChlcnIp
IHsNCj4+ICsJCQlOTF9TRVRfRVJSX01TR19NT0QoZXh0YWNrLA0KPj4gKwkJCQkJICAgIlBGVkYg
cmVwcmVudGF0b3IgcmVnaXN0cmF0aW9uDQo+ZmFpbGVkIik7DQo+DQo+SGkgR2VldGhhLA0KPg0K
PihUaGUgbW9zdCByZWNlbnRseSBhbGxvY2F0ZWQpIG5kZXYgYXBwZWFycyB0byBiZSBsZWFrZWQg
aGVyZS4NCj4NCj5JIHRoaW5rIHRoYXQgb25lIHdheSB0byBhZGRyZXNzIHRoaXMgY291bGQgYmUg
dG8gbW92aW5nIHRoZSBjb250ZW50cyBvZiB0aGlzDQo+bG9vcCBpbnRvIGEgc2VwYXJhdGUgZnVu
Y3Rpb24gdGhhdCB1bndpbmRzIHRoZSBtb3N0IHJlY2VudCBhbGxvY2F0aW9uIG9uIGVycm9yLg0K
Pg0KPkhpZ2hsaWdodGVkIGJ5IFNtYXRjaCAoYWx0aG91Z2ggaXQgc2VlbXMgYSBiaXQgY29uZnVz
ZWQgaGVyZSkuDQo+DQo+IC4uLi9yZXAuYzoxODQgcnZ1X3JlcF9jcmVhdGUoKSB3YXJuOiAnbmRl
dicgZnJvbSBhbGxvY19ldGhlcmRldl9tcXMoKSBub3QNCj5yZWxlYXNlZCBvbiBsaW5lczogMTg0
Lg0KPiAuLi4vcmVwLmM6MTg0IHJ2dV9yZXBfY3JlYXRlKCkgd2FybjogJ25kZXYnIGZyb20gcmVn
aXN0ZXJfbmV0ZGV2KCkgbm90DQo+cmVsZWFzZWQgb24gbGluZXM6IDE4NC4NCj4NCj5Tb3JyeSBm
b3Igbm90IGJyaW5naW5nIHRoaXMgdXAgZWFybGllcjogaXQgaXMgYXQgbGVhc3QgdGhlIHRoaXJk
IHRpbWUgSSBoYXZlIGxvb2tlZA0KPm92ZXIgdGhpcywgYW5kIGZvciBzb21lIHJlYXNvbiBJIGRp
ZG4ndCBub3RpY2UgdGhpcyB0aGUgb3RoZXIgdGltZXMuDQo+DQpPayB3aWxsIHJlY2hlY2sgYW5k
IGZpeCB0aGUgaXNzdWUgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+PiArCQkJZ290byBleGl0Ow0KPj4g
KwkJfQ0KPj4gKwl9DQo+PiArCWVyciA9IHJ2dV9yZXBfbmFwaV9pbml0KHByaXYsIGV4dGFjayk7
DQo+PiArCWlmIChlcnIpDQo+PiArCQlnb3RvIGV4aXQ7DQo+PiArDQo+PiArCXJldHVybiAwOw0K
Pj4gK2V4aXQ6DQo+PiArCXdoaWxlICgtLXJlcF9pZCA+PSAwKSB7DQo+PiArCQlyZXAgPSBwcml2
LT5yZXBzW3JlcF9pZF07DQo+PiArCQl1bnJlZ2lzdGVyX25ldGRldihyZXAtPm5ldGRldik7DQo+
PiArCQlmcmVlX25ldGRldihyZXAtPm5ldGRldik7DQo+PiArCX0NCj4+ICsJa2ZyZWUocHJpdi0+
cmVwcyk7DQo+PiArCXJldHVybiBlcnI7DQo+PiArfQ0KPj4gKw0KPj4gIHN0YXRpYyBpbnQgcnZ1
X3JlcF9yc3JjX2ZyZWUoc3RydWN0IG90eDJfbmljICpwcml2KSAgew0KPj4gIAlzdHJ1Y3Qgb3R4
Ml9xc2V0ICpxc2V0ID0gJnByaXYtPnFzZXQ7DQo+DQo+Li4uDQo=

