Return-Path: <netdev+bounces-117426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C0C94DDCC
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 19:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A677CB21714
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 17:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E7116B75C;
	Sat, 10 Aug 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="B3aadK9T"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466E160796;
	Sat, 10 Aug 2024 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723311855; cv=fail; b=HM4q1ZhesR2gv6BkuT0tx4fhGQUdTe4+QvoRvFMFM5GZTEr/fGjfZXX5VZ+ao5WjhwvRFzYmJ5mFVNCUsT5zbiQ5YTRsHj2ieIHJ8RlJPs1OzoITnG+c7MDWBA0a1l3gkTmf4Kh7ICq1WjTDUu1FU5Z23kR3WymgO5yMuKPyQLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723311855; c=relaxed/simple;
	bh=/CeDHuyPDdkIr7nWvd1GaEKCzYLm0TM2OWIuQggSFEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zt6UTKG6XBeICeD5fxx3yVK7dIvq8s6ap21Jqc06VCNMFfeO037Mh9qgJ0pCN3wNCUUyMg95t+6JbL5zCnbPrCzxcrOnc9b3uGwi+OtTFcku2jaGtyUIItwFtLH0NVFZ+O85qBcH8q1Wakr4f4XbPRMN4B2wnk/VmEp6Q2J9qW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=B3aadK9T; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47AHcugr032134;
	Sat, 10 Aug 2024 10:43:47 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40xcs2008e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Aug 2024 10:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvLUq7KeMUHdqOefmr+bcbH/vZ27hPjvB/Z2c4tlk4Pvz7HPWTGZC6fInHe9g35066o/7h6sBCGK8u1u4cZVX4Yn6CORuFPwmPYlLmgFdqR5nv0qxb3IJ575QQ6KUDg697C2S9VG7i7vAce4paDIocRf4zZLddj/wGoMr5jPYJFhoQnVrTt0EhHletcWk7YjIK5tHqWZKH9UA0b4pQgokz7AHlMb79FUr2v1PMq/+Mb/MEc3471vUbpnCiiKx3my3p9ipfe6z2Aw46DvRUhD3qsXC0o/4LsvRS3Y4iIVFJS2Whi76q3lVLe9Nmknzg+R7+oynUWqQYSqEwzE/35grg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CeDHuyPDdkIr7nWvd1GaEKCzYLm0TM2OWIuQggSFEs=;
 b=PuGweh3bEPjYAi3egDTLLumzPFM/yTmx1n2DZl3cjSokqv2CPLoUClWDuSL3lEFTaVXt0LzexpQjWomlSQ2GGORfaWoS00ThSFinDgjr7zmuZCk9SJNKg0KfmKlFD6UqYaR1CN+FPAc1zUJgXEoOiJizKvHCmka2muyWiC/5lAL16pt1Cdtoec8K5+pleD00UeVw+dvwQ1+lLzGKI2R/7R5vpcibSdcLRe51aj+TEIOhADXQAT6vv5aZ+xXzsHE3zdxTIlBxbjRB7ZHzIitqbbtObIFtN81M6xrU3JER1aZb9g2Dq2RkKTbP76QR1b1WpkTpbt/t0YvyFSIWFZzjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CeDHuyPDdkIr7nWvd1GaEKCzYLm0TM2OWIuQggSFEs=;
 b=B3aadK9TGT+LYG+yLooraV1oPZcb7W1KWI7JgJoXy0bTAG7I+115Xl82AP4qrNNDoCuhdfbpwr2nWyiNuJo1lTVM0MZHO+vm8HMf9qyIY2N8iWlPWC6S+hQf0RbzqZYTqgvRNgW1VmbsNpMjzbrjwbfwvfYoYVbHuu+0ZmmCNF8=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by SN7PR18MB3888.namprd18.prod.outlook.com (2603:10b6:806:f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Sat, 10 Aug
 2024 17:43:43 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%6]) with mapi id 15.20.7849.018; Sat, 10 Aug 2024
 17:43:43 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: "Tristram.Ha@microchip.com" <Tristram.Ha@microchip.com>,
        Woojung Huh
	<woojung.huh@microchip.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 3/4] net: dsa: microchip: handle most interrupts
 in KSZ9477/KSZ9893 switch families
Thread-Topic: [PATCH net-next 3/4] net: dsa: microchip: handle most interrupts
 in KSZ9477/KSZ9893 switch families
Thread-Index: AQHa60zXJwlKEjAiA02ZU8Mr08nQTA==
Date: Sat, 10 Aug 2024 17:43:42 +0000
Message-ID:
 <BY3PR18MB470734EF7A771EB15621648CA0BB2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-4-Tristram.Ha@microchip.com>
In-Reply-To: <20240809233840.59953-4-Tristram.Ha@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|SN7PR18MB3888:EE_
x-ms-office365-filtering-correlation-id: 2f83cc5c-fe63-40bb-8dcc-08dcb963fa25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2FmZHVxSFZGVGRjR3VDaUZuTHQrQWhYVmFGbTNIeU5TYTFOVDU3K0dPMXI1?=
 =?utf-8?B?by9odnJaYlkzTkgrckpOcGNwclh0d3k5amRzYW4yMmVUZmJFMmVhbGtqVVZi?=
 =?utf-8?B?UzJIeXhib09MUjRERXA2a1FWcUFOY2cwRUoyUWl1QUNkWjc2MVFtSE9UeEJs?=
 =?utf-8?B?VGk1aVdaMGUzVVRJNUp4RGlpdkpLYnZ0Sis3U1M0blVkTW5WalpMcGJDRU4y?=
 =?utf-8?B?NFRVb21BaW5qaG8xS2ZLRlhyUmxQeFU1NDdZWElHUDdCL0dZb3E4K3NuOFhR?=
 =?utf-8?B?RHQyUFUzZmEyKzFZQXdmenZucHN1Nm1KMjgwak9uVkNHc2wweWt1MW9RT1ZW?=
 =?utf-8?B?Qkc4dzc1dXZLc042Ny8yUit1cStSSndMMEh0a2JiNm8zUzBWOXB2Y1JCUTVK?=
 =?utf-8?B?Q2hJcWNCZkE2YWZWNEdGdjB0UmlmS2lCcGN3U280OEN5UzVsaFd5em43Z2Z6?=
 =?utf-8?B?Z0ZDSmIzLzVqZmJBMHBTUzlWM0pDUU10cnRDRytpVkNkRHRYbllRaHVNVVZF?=
 =?utf-8?B?Nm5zRVpHMDBMSno3NkRaZ3dxa3NyT1NkT0pNK0Yxdm9FU1BTbkVqOUVoVzZM?=
 =?utf-8?B?ZWd4eDdCdGlyVzJmNzRrR0c1TDNoL2F6UTZXZFI3dEFIRzdBNUtzOWk0Q2FY?=
 =?utf-8?B?VUl2YVlRM1hnN1VkVW4ydkEvb1VCSXFXYTNPZTdHaHIvUy9VM3RZeXhBazJo?=
 =?utf-8?B?bFVhQmxDcTFTb1JZdFBZazlBaE1YZk1JSEQ0WlJiaWh6SkV4ckxMMm9kcmdX?=
 =?utf-8?B?cGxjcFpxdEhRb241VjdMZGpjaytVUklrT3Q0aUxkZEdPK1orRm5pWGJXZTdD?=
 =?utf-8?B?MVZkOW80T2xhdkIydUYwV1VGcDhxRlgxcXhvSzRQNktsOUJ2Nm11WU9ndVlY?=
 =?utf-8?B?L0NHQmY4azR1bzVlcG81c2xlRmZEa2ZrVFBta3R3UXErMWFhR21pNkR0N2lv?=
 =?utf-8?B?dld4U3dkU3c3TmFFNVFqSXgwZnowK1lSUEJjYTZsNTdpRVN1Z2RHWU5RMjZK?=
 =?utf-8?B?TjJJMGxyUFVFdGVDaVRmN1hOR1JGVCtFS21meUFERzVQU2NPeE1OcnpWVk4x?=
 =?utf-8?B?bnk2TTYweXpTditqWWM1ME5sekZGQndVUXNZRXBiY01tYW1mNWRVQWdtY3BC?=
 =?utf-8?B?eCtzRkppdzBDbzdRbFRud3FxMi9qM2pxQzhOSDR5VVM5QVpvQjU2R1ZDd01N?=
 =?utf-8?B?QTEwWWFEcllwS1BCTmdKbERnN3QzdkErbkU2a25PMDYrTEViM1k4aWk2dkt2?=
 =?utf-8?B?dE5La2Q3NHo0djhET0t2OG5vYXdaSEk0bWxuMTFjZ2RDTDVsSjNJVnU2akN5?=
 =?utf-8?B?VmQ0VkdDMVFVNWsreE1GVGxPUXRqeUJENUZqVHlReHFLYjFxRnVFZlFWOHhL?=
 =?utf-8?B?d2RjWjl4TC9GZWNmT0NVbUYvTERoUktnQkJiL1o5bTdUSGlJQnpxWlNjT0w2?=
 =?utf-8?B?Q1hkVG1CT01UcDhIVlFtVGgycXlub2VETEQ1djV1TWlVa2JsaTNWRFNNK3JP?=
 =?utf-8?B?OWprTmFrTDJKZW8zaDlVQUdtSExsQkRwR1FHYXZQQjhabmxSR1plZzhoMGgv?=
 =?utf-8?B?alBKMkdLK3orMzVYSGZveDN6ZWxLY2M5THUxOWl6cXpYOHF3ZTZRbGZieFlw?=
 =?utf-8?B?OGxUdCt3OXFSdU5sbXpyeHNkNmcrUUpsQzRBTkFNZ0ZCR0JJa1BPM3hCUkYr?=
 =?utf-8?B?Mk1XOUVpaXdSeWw1ME5ySWhqak8rTWxudnBpY3EzSXVNQzdIdmVVTmdnb21O?=
 =?utf-8?B?QXZlSDFUeXJFckJ3bFFNdzMxdXBxZ2lTVXh1R0lmTlVvSlhCTmRkcU9UcGpv?=
 =?utf-8?B?NlpGek1BSXY4a2xSYXVwMDZNTTJZUm9MaGlWU2lJSzZnWjVEWXBpMjA4ZlIv?=
 =?utf-8?B?NnNlZUxTSkQ2QVpWRExwU0ZGZlh1UHZLd0Z1K0VGVzZONnFmSWhPUzV5OTE2?=
 =?utf-8?Q?Epud+U3Ue2E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K245ejF0YkgvVzdRN051dms5dXhUMkRESStVZTBLTVIrWkJaZWY2RnBQQVFG?=
 =?utf-8?B?NWRNYXNJdUV3d1BpWGR0YTNyOHJTUmlleXVmb3Y5Si9GUk9jaWQvaEZ6UUYy?=
 =?utf-8?B?TXV0aTY4ODFsK2lvWDFHSmovUktUOWlrMUF4citFL3E5TkxqYmpvdVhoelBs?=
 =?utf-8?B?UHVlY01CdXJRdnhTL1djK0luV0hGOWQ5ZVNMaUU0Vm5TQU9pcVlYTUNvaVAz?=
 =?utf-8?B?TzV0eVoxdURvWmZtdzBIMWJNYS9ySitOMlBQK1ZwNkZWek1SM3dpeTdyc1dW?=
 =?utf-8?B?MVYvRjBaUVFUTnBCSnNzVGxJYjFuVllMeXV5Z1lzdUw1aUtYalhTUlNxSVBn?=
 =?utf-8?B?c3o5dno3UDVuOEpFbmR0SmtpR1lueWZxYW1TaXZTYUk0VWMvc0ROTjBvVUV2?=
 =?utf-8?B?NVRvWHNPUEJYUy9HQjZrUW5BYTZ4ZEpmSnpTYW00UlBGbEJvd242Tnh3Ums5?=
 =?utf-8?B?cE9oRWVSZUw1Sm9UdmNmMHZidTZyT0xVRnV4YjFNREc2bDRUaWkyeW9MK1RE?=
 =?utf-8?B?V1ZiUU5zbER1Mkg1Wlk1RzFjaVZBemZVZkFkeW1HbCtidkFwUUEwU0JETkZW?=
 =?utf-8?B?RjN2YWNrREpicit0bDJIamtZYnQ4T3MrTEQxWGp2dzlUTlZTV29iblEvM1Ny?=
 =?utf-8?B?OGVwcU51bngxYk5JR3NVRDhhVDJ5QVNtWHRERjBkUk9NWGJUSU5zRC94MXF5?=
 =?utf-8?B?RTRsSVlkdEt0bkZNZVdMNDB5NFo4UXRTM0hzWEZTaXJpcU9TNzJtR1IzVk1i?=
 =?utf-8?B?QWkrczFzZU55ekRMbmJ3d25HSlNYY1I4czBTS20yaXY2UVNXanErbzV4SjdG?=
 =?utf-8?B?RnRTOUNGM0RMcjJWRkZtckhRWGFUNVR2a2J5NmNqbjVRQ3ZwWlIvck9hWWg2?=
 =?utf-8?B?WUNHTzNxTVJNaGFWS1ZPU2ZsZ3lRSlo5aUJLTTFTYzhRWmRaREFLZjRwWWRu?=
 =?utf-8?B?cUV6cE5vU2dkVzVHWVJRZ2lxdGs5Y0V5OGVVQURCQ3c3SWJSdnhQZWdacWpY?=
 =?utf-8?B?UkFGb0FmYWtkM3dsY09SeW85b3BwWkZpaWJmenN0blpWeUg5SDFuTHlLa2tp?=
 =?utf-8?B?RnVsVWFyQ1kzWkc3R08rVnY0RXBJSlIvY2wyVUYrOWp2MFc5QXMrbFFmYXcr?=
 =?utf-8?B?S1ZJWkFIdjJvR2M4QS9mdmx5OXlRYWlydXVGN1dBckJucXZKdlRzTDZMS2Vr?=
 =?utf-8?B?NkFUVkwwbk9rc1kzSG9CZ25DREQzNXIrTTdUVmRVVUx4MVNsc0VsbGJNSVl5?=
 =?utf-8?B?dWhNbHB1QmFWSTI5cGVBanpIb2hXWnBPNjROZ0xabUIwTnlkK3JGYWw2SXdV?=
 =?utf-8?B?K0lQaFpCUHh4UDlDcGc2NTU5aGlIcWc3bzZWRFFxRnNUaWZBMzJTR1FyWXk1?=
 =?utf-8?B?dDlYTjg2aTBXOGFQMmt0Q00rNkRMSCt0bDVMbFhTNU1BZFlseDRYM2FxRTJF?=
 =?utf-8?B?WUlVRVFOME40MWlic01ybVZsa29pMEM5NzRsTkowY285QVZkOE1nZzFSeTlt?=
 =?utf-8?B?OEhFenpBR3B5VzQxVGlIVEV4YnZ4WENuU2ZQZFYySGtIZDFnY2dFaS96Snhi?=
 =?utf-8?B?cElNYzhIdEV2ZWY5L3FDSHdiQXJaUHl0WEZDakVjdktWblc0QjBWbDJGT1Ry?=
 =?utf-8?B?d25tNkpvSVZraEVLd3NXVkl5K3Rtakp6RzZEUXhvKzArT3hyb3NqT1dtNXlp?=
 =?utf-8?B?Rm9kbkxEMmFUbUhCWjYyRnVNQWRsdHd6VEZtbWNiQ0c2cWZ2L1ovZDl1THAw?=
 =?utf-8?B?amwxcE9nYjdhNXhjQWUrZlRUbjBWVndlYjYzMU9uUHVuckUxOWJGSHdYZ2hk?=
 =?utf-8?B?NHBvQURzS2FwWjFpMlpiTFRWVkVUaE5FTWhidEIwRzNLLytZSHBQM25xWG5E?=
 =?utf-8?B?OGQ0eFpUYWFsSVVtMHBFUVhmR2Qza21idXNrUG55RUlLbmlRUDBlWE43eXZE?=
 =?utf-8?B?VkR5dU1iRm9XNVdrYUtPM2hvUVIzWWsxc0hrTjFFV3dlMnAxVDluakFtMUlz?=
 =?utf-8?B?V2FDYnRjeDVtdWd4UUN0TnVtUlM3OWtMcDVydjB1VWFpSmpSVVM3REJkclFF?=
 =?utf-8?B?QW8wVFNMUGdERzNMTWZEUFFDcTRwVU5xa3V5UmdSWDNIOG9aRkhvUEtOdSt3?=
 =?utf-8?Q?qAyY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f83cc5c-fe63-40bb-8dcc-08dcb963fa25
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2024 17:43:42.8837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dq89Rgg3AeBa0+cej1ACE9o7ePIXNH2BuOYsEdnoqUulzu6E1BlGPXqBexBGLx0IVB84ZavBIOgY5Sj77tNkWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3888
X-Proofpoint-GUID: yO-f-3goJGJIv7QuokUoK3zQI1_rkIgC
X-Proofpoint-ORIG-GUID: yO-f-3goJGJIv7QuokUoK3zQI1_rkIgC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-10_15,2024-08-07_01,2024-05-17_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRyaXN0cmFtLkhhQG1pY3Jv
Y2hpcC5jb20gPFRyaXN0cmFtLkhhQG1pY3JvY2hpcC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBB
dWd1c3QgMTAsIDIwMjQgNTowOSBBTQ0KPiBUbzogV29vanVuZyBIdWggPHdvb2p1bmcuaHVoQG1p
Y3JvY2hpcC5jb20+Ow0KPiBVTkdMaW51eERyaXZlckBtaWNyb2NoaXAuY29tOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgQW5kcmV3IEx1bm4NCj4gPGFuZHJld0BsdW5uLmNoPjsgRmxvcmlh
biBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+OyBWbGFkaW1pciBPbHRlYW4NCj4gPG9s
dGVhbnZAZ21haWwuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRv
ZiBLb3psb3dza2kNCj4gPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3Ir
ZHRAa2VybmVsLm9yZz4NCj4gQ2M6IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dD47IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tp
IDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5jb20+OyBN
YXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRyaXN0cmFtIEhhDQo+IDx0cmlzdHJhbS5oYUBt
aWNyb2NoaXAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHQgMy80XSBuZXQ6IGRzYTog
bWljcm9jaGlwOiBoYW5kbGUgbW9zdA0KPiBpbnRlcnJ1cHRzIGluIEtTWjk0NzcvS1NaOTg5MyBz
d2l0Y2ggZmFtaWxpZXMNCj4gDQo+IEZyb206IFRyaXN0cmFtIEhhIDx0cmlzdHJhbS7igIpoYUDi
gIptaWNyb2NoaXAu4oCKY29tPiBUaGUgS1NaOTQ3NyBzd2l0Y2ggZHJpdmVyDQo+IGNhbiBoYW5k
bGUgbW9zdCBpbnRlcnJ1cHRzLiBJdCBlbmFibGVzIGFkZHJlc3MgbGVhcm5pbmcgZmFpbCBpbnRl
cnJ1cHQgYXMgU1FBDQo+IHdvdWxkIGxpa2UgdG8gc2VlIHN1Y2ggbm90aWZpY2F0aW9uIGR1cmlu
ZyB0ZXN0aW5nLiBJbnB1dCB0aW1lc3RhbXAgaW50ZXJydXB0IGlzDQo+IG5vdCANCj4gRnJvbTog
VHJpc3RyYW0gSGEgPHRyaXN0cmFtLmhhQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBUaGUgS1NaOTQ3
NyBzd2l0Y2ggZHJpdmVyIGNhbiBoYW5kbGUgbW9zdCBpbnRlcnJ1cHRzLiAgSXQgZW5hYmxlcyBh
ZGRyZXNzDQo+IGxlYXJuaW5nIGZhaWwgaW50ZXJydXB0IGFzIFNRQSB3b3VsZCBsaWtlIHRvIHNl
ZSBzdWNoIG5vdGlmaWNhdGlvbiBkdXJpbmcNCj4gdGVzdGluZy4NCj4gDQo+IElucHV0IHRpbWVz
dGFtcCBpbnRlcnJ1cHQgaXMgbm90IGltcGxlbWVudGVkIHlldCBhcyB0aGF0IGludGVycnVwdCBp
cyByZWxhdGVkDQo+IHRvIFBUUCBvcGVyYXRpb24gYW5kIHNvIHdpbGwgYmUgaGFuZGxlZCBieSB0
aGUgUFRQIGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRyaXN0cmFtIEhhIDx0cmlzdHJh
bS5oYUBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAv
a3N6OTQ3Ny5jICAgICB8IDY0ICsrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIGRyaXZlcnMv
bmV0L2RzYS9taWNyb2NoaXAva3N6OTQ3Ny5oICAgICB8ICA0ICstDQo+ICBkcml2ZXJzL25ldC9k
c2EvbWljcm9jaGlwL2tzejk0NzdfcmVnLmggfCAgNSArLQ0KPiBkcml2ZXJzL25ldC9kc2EvbWlj
cm9jaGlwL2tzel9jb21tb24uYyAgfCAgMiArDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDcxIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZHNhL21pY3JvY2hpcC9rc3o5NDc3LmMNCj4gYi9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tz
ejk0NzcuYw0KPiBpbmRleCA0MjVlMjBkYWYxZTkuLjUxOGJhNGExZTM0YiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o5NDc3LmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvZHNhL21pY3JvY2hpcC9rc3o5NDc3LmMNCj4gQEAgLTIsNyArMiw3IEBADQo+ICAvKg0KPiAg
ICogTWljcm9jaGlwIEtTWjk0Nzcgc3dpdGNoIGRyaXZlciBtYWluIGxvZ2ljDQo+ICAgKg0KPiAt
ICogQ29weXJpZ2h0IChDKSAyMDE3LTIwMTkgTWljcm9jaGlwIFRlY2hub2xvZ3kgSW5jLg0KPiAr
ICogQ29weXJpZ2h0IChDKSAyMDE3LTIwMjQgTWljcm9jaGlwIFRlY2hub2xvZ3kgSW5jLg0KPiAg
ICovDQo+IA0KPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiBAQCAtMTQ4Nyw2ICsxNDg3
LDY4IEBAIHZvaWQga3N6OTQ3N19zd2l0Y2hfZXhpdChzdHJ1Y3Qga3N6X2RldmljZSAqZGV2KQ0K
PiAgCWtzejk0NzdfcmVzZXRfc3dpdGNoKGRldik7DQo+ICB9DQo+IA0KPiArc3RhdGljIGlycXJl
dHVybl90IGtzejk0NzdfaGFuZGxlX3BvcnRfaXJxKHN0cnVjdCBrc3pfZGV2aWNlICpkZXYsIHU4
IHBvcnQsDQo+ICsJCQkJCSAgIHU4ICpkYXRhKQ0KPiArew0KPiArCXN0cnVjdCBkc2Ffc3dpdGNo
ICpkcyA9IGRldi0+ZHM7DQo+ICsJc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldjsNCj4gKwlpbnQg
Y250ID0gMDsNCj4gKw0KPiArCXBoeWRldiA9IG1kaW9idXNfZ2V0X3BoeShkcy0+dXNlcl9taWlf
YnVzLCBwb3J0KTsNCj4gKwlpZiAoKmRhdGEgJiBQT1JUX1BIWV9JTlQpIHsNCj4gKwkJLyogSGFu
ZGxlIHRoZSBpbnRlcnJ1cHQgaWYgdGhlcmUgaXMgbm8gUEhZIGRldmljZSBvciBpdHMNCj4gKwkJ
ICogaW50ZXJydXB0IGlzIG5vdCByZWdpc3RlcmVkIHlldC4NCj4gKwkJICovDQo+ICsJCWlmICgh
cGh5ZGV2IHx8IHBoeWRldi0+aW50ZXJydXB0cyAhPQ0KPiBQSFlfSU5URVJSVVBUX0VOQUJMRUQp
IHsNCj4gKwkJCXU4IHBoeV9zdGF0dXM7DQo+ICsNCj4gKwkJCWtzel9wcmVhZDgoZGV2LCBwb3J0
LCBSRUdfUE9SVF9QSFlfSU5UX1NUQVRVUywNCj4gKwkJCQkgICAmcGh5X3N0YXR1cyk7DQo+ICsJ
CQlpZiAocGh5ZGV2KQ0KPiArCQkJCXBoeV90cmlnZ2VyX21hY2hpbmUocGh5ZGV2KTsNCj4gKwkJ
CSsrY250Ow0KPiArCQkJKmRhdGEgJj0gflBPUlRfUEhZX0lOVDsNCj4gKwkJfQ0KPiArCX0NCj4g
KwlpZiAoKmRhdGEgJiBQT1JUX0FDTF9JTlQpIHsNCj4gKwkJa3N6X3B3cml0ZTgoZGV2LCBwb3J0
LCBSRUdfUE9SVF9JTlRfU1RBVFVTLA0KPiBQT1JUX0FDTF9JTlQpOw0KPiArCQkrK2NudDsNCj4g
KwkJKmRhdGEgJj0gflBPUlRfQUNMX0lOVDsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gKGNudCA+
IDApID8gSVJRX0hBTkRMRUQgOiBJUlFfTk9ORTsgfQ0KDQpVbnRpbCB1bmxlc3MgdGhlcmUgaXMg
YSBuZWVkIHRvIHNlcnZpY2UgYm90aCBQSFksIEFDTCBpbnRlcnJ1cHRzIHNpbXVsdGFuZW91c2x5
LCAiY250IiBpbmNyZW1lbnQgb3BlcmF0aW9ucyBjYW4gYmUgYXZvaWRlZCBsaWtlIHRoaXMgdG8g
cmVkdWNlIHByb2Nlc3NpbmcgdGltZS4NCg0KaWYgKCpkYXRhICYgUE9SVF9QSFlfSU5UKSB7DQog
ICAgLy8gSGFuZGxlIFBPUlRfUEhZX0lOVA0KICAgIHJldHVybiBJUlFfSEFORExFRDsNCn0NCg0K
aWYgKCpkYXRhICYgUE9SVF9BQ0xfSU5UKSB7DQogICAgLy8gSGFuZGxlIFBPUlRfQUNMX0lOVA0K
ICAgIHJldHVybiBJUlFfSEFORExFRDsNCn0NCg0KcmV0dXJuIElSUV9OT05FOw0KIA0KPiArDQo+
ICt2b2lkIGtzejk0NzdfZW5hYmxlX2lycShzdHJ1Y3Qga3N6X2RldmljZSAqZGV2KSB7DQo+ICsJ
cmVnbWFwX3VwZGF0ZV9iaXRzKGtzel9yZWdtYXBfMzIoZGV2KSwgUkVHX1NXX0lOVF9NQVNLX180
LA0KPiBMVUVfSU5ULCAwKTsNCj4gKwlrc3pfd3JpdGU4KGRldiwgUkVHX1NXX0xVRV9JTlRfRU5B
QkxFLCBMRUFSTl9GQUlMX0lOVCB8DQo+ICtXUklURV9GQUlMX0lOVCk7IH0NCj4gKw0KPiAraXJx
cmV0dXJuX3Qga3N6OTQ3N19oYW5kbGVfaXJxKHN0cnVjdCBrc3pfZGV2aWNlICpkZXYsIHU4IHBv
cnQsIHU4DQo+ICsqZGF0YSkgew0KPiArCWlycXJldHVybl90IHJldCA9IElSUV9OT05FOw0KPiAr
CXUzMiBkYXRhMzI7DQo+ICsNCj4gKwlpZiAocG9ydCA+IDApDQo+ICsJCXJldHVybiBrc3o5NDc3
X2hhbmRsZV9wb3J0X2lycShkZXYsIHBvcnQgLSAxLCBkYXRhKTsNCj4gKw0KPiArCWtzel9yZWFk
MzIoZGV2LCBSRUdfU1dfSU5UX1NUQVRVU19fNCwgJmRhdGEzMik7DQo+ICsJaWYgKGRhdGEzMiAm
IExVRV9JTlQpIHsNCj4gKwkJdTggbHVlOw0KPiArDQo+ICsJCWtzel9yZWFkOChkZXYsIFJFR19T
V19MVUVfSU5UX1NUQVRVUywgJmx1ZSk7DQo+ICsJCWtzel93cml0ZTgoZGV2LCBSRUdfU1dfTFVF
X0lOVF9TVEFUVVMsIGx1ZSk7DQo+ICsJCWlmIChsdWUgJiBMRUFSTl9GQUlMX0lOVCkNCj4gKwkJ
CWRldl9pbmZvX3JhdGVsaW1pdGVkKGRldi0+ZGV2LCAibHVlIGxlYXJuIGZhaWxcbiIpOw0KPiAr
CQlpZiAobHVlICYgV1JJVEVfRkFJTF9JTlQpDQo+ICsJCQlkZXZfaW5mb19yYXRlbGltaXRlZChk
ZXYtPmRldiwgImx1ZSB3cml0ZSBmYWlsXG4iKTsNCj4gKwkJcmV0ID0gSVJRX0hBTkRMRUQ7DQo+
ICsJfQ0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgTU9EVUxFX0FVVEhPUigi
V29vanVuZyBIdWggPFdvb2p1bmcuSHVoQG1pY3JvY2hpcC5jb20+Iik7DQo+IE1PRFVMRV9ERVND
UklQVElPTigiTWljcm9jaGlwIEtTWjk0NzcgU2VyaWVzIFN3aXRjaCBEU0EgRHJpdmVyIik7DQo+
IE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9taWNy
b2NoaXAva3N6OTQ3Ny5oDQo+IGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o5NDc3LmgN
Cj4gaW5kZXggMjM5YTI4MWRhMTBiLi41MTI1MmQwZDA3NzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OTQ3Ny5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9t
aWNyb2NoaXAva3N6OTQ3Ny5oDQo+IEBAIC0yLDcgKzIsNyBAQA0KPiAgLyoNCj4gICAqIE1pY3Jv
Y2hpcCBLU1o5NDc3IHNlcmllcyBIZWFkZXIgZmlsZQ0KPiAgICoNCj4gLSAqIENvcHlyaWdodCAo
QykgMjAxNy0yMDIyIE1pY3JvY2hpcCBUZWNobm9sb2d5IEluYy4NCj4gKyAqIENvcHlyaWdodCAo
QykgMjAxNy0yMDI0IE1pY3JvY2hpcCBUZWNobm9sb2d5IEluYy4NCj4gICAqLw0KPiANCj4gICNp
Zm5kZWYgX19LU1o5NDc3X0gNCj4gQEAgLTU4LDYgKzU4LDggQEAgaW50IGtzejk0NzdfcmVzZXRf
c3dpdGNoKHN0cnVjdCBrc3pfZGV2aWNlICpkZXYpOyAgaW50DQo+IGtzejk0Nzdfc3dpdGNoX2lu
aXQoc3RydWN0IGtzel9kZXZpY2UgKmRldik7ICB2b2lkIGtzejk0Nzdfc3dpdGNoX2V4aXQoc3Ry
dWN0DQo+IGtzel9kZXZpY2UgKmRldik7ICB2b2lkIGtzejk0NzdfcG9ydF9xdWV1ZV9zcGxpdChz
dHJ1Y3Qga3N6X2RldmljZSAqZGV2LCBpbnQNCj4gcG9ydCk7DQo+ICt2b2lkIGtzejk0NzdfZW5h
YmxlX2lycShzdHJ1Y3Qga3N6X2RldmljZSAqZGV2KTsgaXJxcmV0dXJuX3QNCj4gK2tzejk0Nzdf
aGFuZGxlX2lycShzdHJ1Y3Qga3N6X2RldmljZSAqZGV2LCB1OCBwb3J0LCB1OCAqZGF0YSk7DQo+
ICB2b2lkIGtzejk0NzdfaHNyX2pvaW4oc3RydWN0IGRzYV9zd2l0Y2ggKmRzLCBpbnQgcG9ydCwg
c3RydWN0IG5ldF9kZXZpY2UgKmhzcik7DQo+IHZvaWQga3N6OTQ3N19oc3JfbGVhdmUoc3RydWN0
IGRzYV9zd2l0Y2ggKmRzLCBpbnQgcG9ydCwgc3RydWN0IG5ldF9kZXZpY2UNCj4gKmhzcik7ICB2
b2lkIGtzejk0NzdfZ2V0X3dvbChzdHJ1Y3Qga3N6X2RldmljZSAqZGV2LCBpbnQgcG9ydCwgZGlm
ZiAtLWdpdA0KPiBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OTQ3N19yZWcuaA0KPiBi
L2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OTQ3N19yZWcuaA0KPiBpbmRleCBkNTM1NGM2
MDBlYTEuLmRhNGVmM2ViOTdjNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZHNhL21pY3Jv
Y2hpcC9rc3o5NDc3X3JlZy5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6
OTQ3N19yZWcuaA0KPiBAQCAtMiw3ICsyLDcgQEANCj4gIC8qDQo+ICAgKiBNaWNyb2NoaXAgS1Na
OTQ3NyByZWdpc3RlciBkZWZpbml0aW9ucw0KPiAgICoNCj4gLSAqIENvcHlyaWdodCAoQykgMjAx
Ny0yMDE4IE1pY3JvY2hpcCBUZWNobm9sb2d5IEluYy4NCj4gKyAqIENvcHlyaWdodCAoQykgMjAx
Ny0yMDI0IE1pY3JvY2hpcCBUZWNobm9sb2d5IEluYy4NCj4gICAqLw0KPiANCj4gICNpZm5kZWYg
X19LU1o5NDc3X1JFR1NfSA0KPiBAQCAtNzUsNyArNzUsOCBAQA0KPiAgI2RlZmluZSBUUklHX1RT
X0lOVAkJCUJJVCgzMCkNCj4gICNkZWZpbmUgQVBCX1RJTUVPVVRfSU5UCQkJQklUKDI5KQ0KPiAN
Cj4gLSNkZWZpbmUgU1dJVENIX0lOVF9NQVNLCQkJKFRSSUdfVFNfSU5UIHwNCj4gQVBCX1RJTUVP
VVRfSU5UKQ0KPiArI2RlZmluZSBTV0lUQ0hfSU5UX01BU0sJCQlcDQo+ICsJKExVRV9JTlQgfCBU
UklHX1RTX0lOVCB8IEFQQl9USU1FT1VUX0lOVCkNCj4gDQo+ICAjZGVmaW5lIFJFR19TV19QT1JU
X0lOVF9TVEFUVVNfXzQJMHgwMDE4DQo+ICAjZGVmaW5lIFJFR19TV19QT1JUX0lOVF9NQVNLX180
CQkweDAwMUMNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2Nv
bW1vbi5jDQo+IGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmMNCj4gaW5k
ZXggZjMyOGM5N2YyN2QxLi43ZGI3NGUwMzZjM2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L2RzYS9taWNyb2NoaXAva3N6X2NvbW1vbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9taWNy
b2NoaXAva3N6X2NvbW1vbi5jDQo+IEBAIC0zNTcsNiArMzU3LDggQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBrc3pfZGV2X29wcyBrc3o5NDc3X2Rldl9vcHMgPSB7DQo+ICAJLnJlc2V0ID0ga3N6OTQ3
N19yZXNldF9zd2l0Y2gsDQo+ICAJLmluaXQgPSBrc3o5NDc3X3N3aXRjaF9pbml0LA0KPiAgCS5l
eGl0ID0ga3N6OTQ3N19zd2l0Y2hfZXhpdCwNCj4gKwkuZW5hYmxlX2lycSA9IGtzejk0NzdfZW5h
YmxlX2lycSwNCj4gKwkuaGFuZGxlX2lycSA9IGtzejk0NzdfaGFuZGxlX2lycSwNCj4gIH07DQo+
IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBwaHlsaW5rX21hY19vcHMgbGFuOTM3eF9waHlsaW5r
X21hY19vcHMgPSB7DQo+IC0tDQo+IDIuMzQuMQ0KPiANCg0K

