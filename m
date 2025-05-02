Return-Path: <netdev+bounces-187521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1E4AA7A98
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 22:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCA93B3EDA
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 20:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7931F5859;
	Fri,  2 May 2025 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cXYW4I+f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VMbabmyU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F917A2FC;
	Fri,  2 May 2025 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216665; cv=fail; b=s0GOF1i1RHSBugHA709XcnfIt2axVNip6u1w9Z2c0+tjH21SGtSNj8xKwaL2FMeC3C6mMeyumhucoKE0cIt2ezXts3X5PRZz04EmiQpVQOmRWpFy7yA2Ny9+yf2web+4TazcjuAJf2208yx3u+U2RClB2X9wO0wmkxbBbaJzwbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216665; c=relaxed/simple;
	bh=NlJITODSCV2CTtFymG6wxKnZBj2Dj9fUZris2Eu5GWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oa8yH2dWB/3Tk8+Vuj5ptd23WqM9ldB0PT19Yi2NElJ2SSfbH9Ps9JsblHZHPZn0XSCDkcYhPbRswZVOzJP+ne2wuWsG+vLevv0TdCZSXIqQ6RZHNR6cK8zMUVJZ7XpQCLvYULR4dPTLtkWcraxP4a/ECxryNvf3aYdwIDqI6Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cXYW4I+f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VMbabmyU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542JiJVG002702;
	Fri, 2 May 2025 20:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SKra8xWrCKknsSrn5ZkNCtPetL7FDOZl4TsqKvFFe6I=; b=
	cXYW4I+fYKU7anAXi7E+Nrc0J9BBl/9rRPs39AinJ6bV8CXPy6s2edJ6BF0Horr1
	RX9n3Py7Isf5hyK3tnuk1Msv1iFfe4Gl1CARr65iJdSQayiWA1j9ZLUTppIoKs9h
	PgjsC4VSIbqnHJU5NBnZu4a5+53AB+GEdCP43jJIHYRBivN53t03F/tMcQSAItHK
	vR2bYV1ptr4kMPtv/oV9AE9u8sw4HLSX/wJ9o+FCvcV3xR8bu9TOUiu6NfHkyYPG
	jk4+j6XK4tLKxdguUgMRNVPte7AAemYy65n9/QhCRJZ1y+15XNRm4ZXvD4lxoc16
	lT59EVo07Xdt1IUeolP8mw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukp1m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 20:08:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 542IY2Bh013901;
	Fri, 2 May 2025 20:08:29 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxe6c5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 20:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgCipfuvd7l0HcY3lycmBS2onHttlxXlXgGK65I0LTl3U05JZuTJ1/tq+NzvJtraeNBaMjAOTOVbkeO/YMH0wzBGPoJh0aSeSb+8YmpsvknSjhYBBE4g40zSZ7m+VvelcDp0+mYCd/o9IkP0LzjzmW998ktm+YjCq05fN6r4Vyj84vCJtxJxVEIKhNW5IFAsE1WJc216XmjdAX1spgv+DHyJ7D7VVxnz8ts0FIFl5Pn3rcyOz/Yxv0uhDz5DMfbKX8b6JC2ZQA83/WCtevPY4QEAKjfozm3dUBdFiHdWreEbNUSSd7BmPkhV6olWADIS53qi8FCki7GHvjiMLIGQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKra8xWrCKknsSrn5ZkNCtPetL7FDOZl4TsqKvFFe6I=;
 b=ehh0eRHRPzniSHIJ/9dT22p2P5J3q1D8863QSuf34w/xP8ES7dY7sTtXLgbxfuVCYA5aad8/PJh4WFUVUQ64czAhCkpMmvqwcIgqCbgmlGShPM8M+xSUCAjZlq98kfxRvzc8ct+su+ibuyG/7hUwgewEYW37Ls9meenteMxYOG8XlNbDUJzlH6Ka0zdPV5Hgn+QeqDPFpTbUSoUiYcioNWo3/Jp9yZZxzZKT/Icz6hYyMN72h2xJhQ0LAnU3+ozZBwa1q0MXuEQnw4VCWR84Catq3BAwYKWdPp8OCHY/k/ZbY6pA2xTMe41DWHri1SYRGb2UkrBLeFrW1IOZu1hKqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKra8xWrCKknsSrn5ZkNCtPetL7FDOZl4TsqKvFFe6I=;
 b=VMbabmyUFD8IldN/AzM1sOgE5Vd9+6h7heE0eqbmlOCA9Y+huSBADwqq5x7BfY1S5nY1C3JzenhRDj9m+LqmtBZOT2wpUwELQZZ5vl4GRpQq2J0nkOLUDv+LWZPg4USWF91ZWsablcXmd/y1k8ySqD+ByCF/GF+7cbgbc3o1Yn0=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BL3PR10MB6067.namprd10.prod.outlook.com (2603:10b6:208:3b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 20:08:23 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 20:08:23 +0000
Message-ID: <d6473f85-4d2f-4979-804a-0ef5c4f3cb69@oracle.com>
Date: Sat, 3 May 2025 01:38:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 01/11] dt-bindings: net: ti: Adds DUAL-EMAC
 mode support on PRU-ICSS2 for AM57xx, AM43xx and AM33xx SOCs
To: Parvathi Pudi <parvathi@couthit.com>, danishanwar@ti.com,
        rogerq@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
        ssantosh@kernel.org, tony@atomide.com, richardcochran@gmail.com,
        glaroque@baylibre.com, schnelle@linux.ibm.com, m-karicheri2@ti.com,
        s.hauer@pengutronix.de, rdunlap@infradead.org, diogo.ivo@siemens.com,
        basharath@couthit.com, horms@kernel.org, jacob.e.keller@intel.com,
        m-malladi@ti.com, javier.carrasco.cruz@gmail.com, afd@ti.com,
        s-anna@ti.com
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, praneeth@ti.com,
        srk@ti.com, rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com,
        mohan@couthit.com
References: <20250423060707.145166-1-parvathi@couthit.com>
 <20250423060707.145166-2-parvathi@couthit.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250423060707.145166-2-parvathi@couthit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::21) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BL3PR10MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 793215d0-71c7-4ce7-a84d-08dd89b5172f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3RMd1hGMVk2YTQyQWRvVDJqWWtqVXppNHM2QW5FQlhzc0pkVFJMVGswY00y?=
 =?utf-8?B?NktBd0lWSlM5b1RIS0s5Q09JWU5BMVlGZXFjR2lQR2JDV0lYQ1hUWGx1SFg0?=
 =?utf-8?B?Tmwvck5yeU9xRW1PM3dadFdEb0tTcS9sa09JL0tUVWE0UWo5aVJ0UTdGV29m?=
 =?utf-8?B?ZjUxMHpUUW5QMGZQRjhqYXJCQmVTcFhjdVFmUVhaYVZwbHd2bXV1Q2U4V0Np?=
 =?utf-8?B?TXZsZlExYmJubTRPdUhIYy9qcVJlb3dBWkpsQTAxN1VTL2JRQ2lCU3ZxbDBT?=
 =?utf-8?B?ZldtV3hOOEVpenJ3RlRPNDdrSXl4NkJuWnVYdWM2cDh2SWp3QzdSQlNJbldQ?=
 =?utf-8?B?SjJoRjJ4Z1pybS9sZHBQRisxcWl2NGkvRVNsRmsrSWdRVjhhNzVjSTFZQlRw?=
 =?utf-8?B?RjN0YzFHNE4xUnJUYlR2VjRXdXh5d1NpZ0F6amxVbGRnRnpXTmRnR0thZDdJ?=
 =?utf-8?B?OTNZRmJTb0g5dmtBT21TYitxejFBNEpXZU9YVk1ES2tRemxOWUxBUTZyWHhG?=
 =?utf-8?B?bS9NYUZOZXNRaUtZQXoveklZZGRnaERwYThNYUIyRStrbDhBQWxSZmtxaWhX?=
 =?utf-8?B?Qlo1RTd5Wi9DbDFEdnJ4NkdvZGRtTmZZcktWL2psNlpQNVNNaGhIZmVBV1Q4?=
 =?utf-8?B?S0I4ZlVNeG9zY3Z4OGtta053WWNtazJSTm5JMWF3aE8vVFN0NmxJck1rUG5E?=
 =?utf-8?B?QVF3QXJGTEtyU3FaWm5BZ3RWRlpkTDhWbXNUK1dzRDlKZHdsejEzYnR4Z0JF?=
 =?utf-8?B?b2RWUzE0WnVSVlRNYmZQbWJoQ1FEcXpSV2ZUWXZjYm9DWk04WlREN0o4b0F6?=
 =?utf-8?B?SlZjRzMxYk9EeGcxTXVaTHFIMlpTbllnNy9pelV6TmpWQU1vOUJObnYxaFQ3?=
 =?utf-8?B?R1lKZkNLRHBsTEpzckg1THg5VDBBemFac0pKQ2JmMWlzQkVEZkliQm1kWEFQ?=
 =?utf-8?B?c1ZHZWJlV2p2ellRYlJlbUJCa2NnVmZQQWttbWlZK1FxZXgvVlc4c0RUcGlY?=
 =?utf-8?B?NXhpTDh0SWw2Qzh5T2dCckE1VVpaSzB0UkwxS25ENW5TYjBpVVU2aXJwWE9H?=
 =?utf-8?B?V1E1UUhpd3J4OGNTbjFxbG1VRnpjV2JnVUttbm52ZE5xaVpEL0JtK3U4RnRr?=
 =?utf-8?B?SE8vYVBIUmdScDVwSWpTTkNrRUlCM3NmQ2lLT1lKOGtsYzM1MSsvK0lQRXBD?=
 =?utf-8?B?QUsySnc4Z21hd0syOUpuNDR2YTZvU0lYSTBycnlqMVkzRGlOdndhTlNjaWQr?=
 =?utf-8?B?TWZVQ0psR3JEdGc1Y1AxcUxTSzRld3EzYnVodEVuenN6RVR6aGRRS0xWYTg2?=
 =?utf-8?B?WU9GeWJ4ZC9PeWt2T082d2RXNS9hVnhvbWpRbDJVVGxXMld0QmlsREVtT2Nt?=
 =?utf-8?B?N2ZJZngrRXhXYVNzMVVYSlRLNEhtQXU3K2FEeGlISmFUeG1HUmhvRkk2Y0J5?=
 =?utf-8?B?MEtvbEp1OHpzdVJDWFBXM1d2Q2k5eTdsNW9NajVUWFAvenRmVDFsc2h0Mkp5?=
 =?utf-8?B?cXRsRHhSNlBXd3pCVUxOdnBoNFZwTHZJU1ZHV09LYTZmTGprNmxPZHE5NDc5?=
 =?utf-8?B?U3djbmpOSXkzc204WHNJVmgwdkk5UmFCaStLQ29YNWdBTkZBS0F3UmNMMVdZ?=
 =?utf-8?B?NUV5M1lkZzBSbFRmeFVJWHF1MFJYZTlsZUdGWFFHYzA4Nmh4WlJueDlrRjRP?=
 =?utf-8?B?TUtsK0RpZWplWGpSck9MNEx4akR0ajFreU5ybndTZU9JN1E1Qk5XeUJ4SnNR?=
 =?utf-8?B?MTk0RFR3SG1TQVh5ekUvS0VVVVNkQnJEQjhyN014aHNrVlV2YjlRYXREK0Vy?=
 =?utf-8?B?MkhKN25Na21tdElyVGVmc1k4UEY2Q1IzV2NYWUtVbnpWcDE1cldKWnFraEVk?=
 =?utf-8?B?NzJZcENMYWdJcmlJajRRU2htSGovR0hGZlVVdGJzQU03azlab1RMbWlyWW9J?=
 =?utf-8?B?RXJNMndnemRLR0gwYXdjRTRpMnc1U0NYUlNoTFM3azlDaDFSMWxhcldRWUxB?=
 =?utf-8?B?YjlwVXhtdlNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUNRcG1MWEl3TERGSnE4SHU3QXozajdETlViUkdOTGw5TVJTNXUrUEVpOGVT?=
 =?utf-8?B?ck04U0craGlkRnlIUVBUQ2E1N1JzUHZhbVJIN0FTQTYzd2pxNEEwd2pLaUhu?=
 =?utf-8?B?Z0NDQno2cVdLUitxczM3VS9TN2V5WG9yWEFHdnBGWitCdTF4dlpNamhRMHNu?=
 =?utf-8?B?Z1Nta1YrczlqMisrYzkvczMxYW1pY3B6YTdHRXlmSzkvYVpFWkpKMFJpUmZy?=
 =?utf-8?B?YmRiQnZSczA0ZHFORmJCL01iUHArUXpRNFB1M0d5VHF4bURoTXBnUUl6d0lX?=
 =?utf-8?B?TUJRa3ZvajZJUFNyanRIRmRBeUtPV0xSZWtCTjJIYy82VmdmamxhZ2tuUWcx?=
 =?utf-8?B?V2JmMGlwb2RldmdRM1I4WlJQT3FENTZzSXB2YjlUSTFkNElQSmRpbDNqQkdH?=
 =?utf-8?B?M2tQcGJzOTVwbGJMSnNnQmV2LzJDMkJhUzFVbU1XbnVnajJHdGRSaUowanU2?=
 =?utf-8?B?Z0lOR2dxYVhaL3NlaXdON3dJbEo4c0Fzc0U3OGs0RXFOd2JnUk1sNkVPd1U3?=
 =?utf-8?B?N0xoOEUxVXdta09weVJhdlExenQ1RCtuck5obktyZnJoTFJscjZ5WjVsWE1T?=
 =?utf-8?B?S2RLSExmR3kyb3lPem04V0JMZkEvREcvcFNVNU9RczVuaUlqNHFiVWxQSG5K?=
 =?utf-8?B?cjFRVmVORnh3WUJHemlwYXAyVk81bUFoOVU1VXNBOS9vSDZhL1lhcmJLSmtN?=
 =?utf-8?B?NFFjUWNvRnVNcUVSZS9DTHMvR3EyWTZ4UFd5TGZVNElOTVhkUjVJQktOMjhU?=
 =?utf-8?B?am1GYWJBNDd1M3lSVWFNLzdKNEFYZmoxa0xkcjJDNld2VDRra21qeTQvRmFQ?=
 =?utf-8?B?RjRVUGFOTVpBVzhYRU9la2ZML2hzc050dGhENWhqT2U5TmlrWGJsUGsxaFF5?=
 =?utf-8?B?UVJ5ZDhkeXdJVjhIMGxPS3ErNm9KUml4dEtUaXgyOWE5ZDYwU045akMzY3RP?=
 =?utf-8?B?ZFZIVlhOcElNOTFLMVZZMUJseUREdW0zUjdQRVQvOXdyV3hWbFVlYTFoMjAr?=
 =?utf-8?B?eUY2cUt4WkQvYkJvMjQ1ODlIcEtrSENqYzJsM2dKQ2YzY1JjOTJ3MkxGbkxY?=
 =?utf-8?B?ckthTHZxL095MjJUQytJMlVmL0F1N01ta3c3aFRiL1BIM3VQQkZXL0J0V0Qz?=
 =?utf-8?B?dlJjeTlCd2xHMTRYZ1pHM1hCVHgvRnZWQkRya3J5M0FsZWFGTmdveCtnVER3?=
 =?utf-8?B?TkpvT1dJcW5VU0J6b3VNUkdkZzBRbk5kNUdvODY3bjV0Tk10ZTFCc2VIcXBs?=
 =?utf-8?B?NllxMnRDOGExTW1TRmM3SjVJaHlIQ1kwL0t1eHFSR0YxSSs3RXdHSFlTRE42?=
 =?utf-8?B?SWdmbjd2NlRFbCtlVVV1ZUhGWGhJai8zQkIyUE4wa2d6QzRlN3UrN013Ym9S?=
 =?utf-8?B?czlMei9LQko1OStCZkxadGFyaU9aUFJvYklkTUs1QnJNTFoyeTZXQ1lwUG05?=
 =?utf-8?B?b2w5WEJvZVczVnFXNTVJM2NSV3B4Y3lXSTZ4ZTkrQ29HeTZvalRRb0VxSTVV?=
 =?utf-8?B?UWxmdy9HaTk0bVVPUEJ3aW5oQWVpUFFZZDUzZlR5aHhOVTRXejl4Qml0NDlz?=
 =?utf-8?B?M0UvZUxtaVB4MWdkQ1JqWHZyZEZKT2dlaTBLbGtibjJqVkVXYzdxYjVSL1BH?=
 =?utf-8?B?SzJBUGp5ZG93VGVhQVJDSWtsQ2Z6SGpoL2taaWVoMkFiK1Y1cC9yUExsSmhu?=
 =?utf-8?B?L2FRVzVYUlZiWmg4UC9ySU9pME8vYTZPWm1RU0FCZ2cwWTl4VnpQK2lHbGJN?=
 =?utf-8?B?ck9POVhpTU9hQ3hlRk83TWZZWDJDVlk3STN3OTgzRG5TOFluWFRNRU11eW5n?=
 =?utf-8?B?dmFBSlR3OHd2RU4zK214N0RQemZPdTE1WmFjbHZpaEUzcjVwZWVpcHFGSXFS?=
 =?utf-8?B?bWVXSC9BTVJCdmZCK3RuQncyandpK3lFV2lndUwwQkp0M3JvZjM5MWNEUkJO?=
 =?utf-8?B?bzJ3bmlPenl5MlE4OFdBcWE4bEZuNTVVUlZEYk5BYVE0Z3VESW1xSG1CRVBk?=
 =?utf-8?B?dEZxVi8wb0FVeHpRazBBSUdOaUo0WHJFRGFYdUdDY2ZJTXZYNVBQUUZ3Mm4y?=
 =?utf-8?B?VmhDVVFBcUdVZUUrazZEM2ZHZGRYT2xBVjNrU1Brc3hUazdac3FZUlk0dkdw?=
 =?utf-8?Q?iPcGVm8KgVpU79oY5c8mIc7ms?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z1Aq6EPaJkG/bxSDCg3vJ9qc1KsriR9bb6RjXFox6D/NXwezTZ+sbgQVKN4a2jAjobTisp1nH54p7oJXlAFgA4V2Xcp3wN5QcLq0qIFc4f/q3kiTu1bKF/PMd8vq0pYnyNTNXqnroMGYZmaPLaTNpDbngygmw5tCYXinhAvT+hscIOeRaeLitw8DRgdWnIGLb4YVQXICY+j7ZHpnM9K6B0Qv4lWRSyYCA4BP6R3EmvpK0RTyKl/tSpASgpi1EHu163AtUIODoUwpwrt+tIbA01JC+weIFfAvfH9mKHT3JS8tJvo+Uvp3sh8kx5p5s9BL65Oz7S3IzeEafCtSRGbUEgY3PXwIEJPrYQ19uhYDIDh+aBg0hSda+8v/0sAptC2HM9O6g86sxkUiGeTKrg5kAF9jTlRaNkowoZWtYQUx6z5iyXNchkq95ti/IjCLOpMEMU0yk5GjpLEv+BQTflfF8+1sLgD+hyRV4/qJiCev3SDPkON+GNLjlhbL/0QPFZakwgmoU8VDmdgQ4Rsm7vmD/+LH1yy/H7XaiLWONChA5HeNGPWgE5tQUnJBMzYb1DHhHnwBkiBb4qE/ywMWuqLxbQsW2JTOVTrh1Kajn4QJ6kM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793215d0-71c7-4ce7-a84d-08dd89b5172f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 20:08:23.1862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkStcm5j0XYps5Z5/GutzKZdogWEn6GxXbeMn2CY967ZMVMZaF+bcxf3twJDfVLU7mlB4eHcFNW6Ut3TSgLaztQ9l6+eLWfHXZZ7gbtFO6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505020162
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=6815263e b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=jxZJpUkXbe-8BzyzFWQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: okglN0PQQsDBUanMmycJMPC1BbrIh7Eh
X-Proofpoint-ORIG-GUID: okglN0PQQsDBUanMmycJMPC1BbrIh7Eh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDE2MiBTYWx0ZWRfX/M6CavN69iaf gUR4S43Xf7xdD16VVn/9xB0x8sypTwIIo5sAV7euI5Z3SZzknsZaA62J91M/oJENItJdDG8ZHq0 lj73JNli/ypujg2OE9S4ylKcykBvNGy/Y7JJZA+h987DcdoDyKYj0RM31U7TJN4ci0e954d6+L+
 C6LQegmRcP1wR7MnAUr/h08htLNOlSodjavtFrhM3yaZYqAst6k2oTTbu+DNsDvVtcoT37lF95D ImCDGYWyCVi02cqb1RzzpRtacX7KxmARuOjJ9cSCA/tYpW5dWeBXqnQ93KJfaYYXLadZzm+sG/P bYtj6u2Qend2Dvt4TDYIumUqUrOK0rgQ/xFaHWu3eb6KYJn1F8/TVwG1WWpTMYSUn8grUsqSRDM
 r5pv7VGTrYo5ejiNHfAdpyhVXnHAYBwF8YFqkMS3sHbq3iN7PqsWQjVLEF/ULhqyeO6HdtqP



On 23-04-2025 11:36, Parvathi Pudi wrote:
> +    description:
> +      PRU-ICSS has a Enhanced Capture (eCAP) event module which can generate
> +      and capture periodic timer based events which will be used for features
> +      like RX Pacing to rise interrupt when the timer event has occurred.
> +      Each PRU-ICSS instance has one eCAP modeule irrespective of SOCs.

typo modeule -> module

> +
> +    type: object
> +
>     mii-rt@[a-f0-9]+$:
>       description: |
>         Real-Time Ethernet to support multiple industrial communication protocols.

Thanks,
Alok

