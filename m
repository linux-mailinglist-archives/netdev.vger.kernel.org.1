Return-Path: <netdev+bounces-186603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77163A9FDB0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E7A464923
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870C3212F94;
	Mon, 28 Apr 2025 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aLMr/E7A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PkwdnrIx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A2D210184
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 23:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745882730; cv=fail; b=DjxWBaIqmTsnj0vfncTZVIfhPmYGsCknRtD5hqW4jOdmEDxIekJZu7D3K27d96oyBhbB2yQlUD8Yv/tCycTpE5Y3B1BCnnY0yuczXKBb2mgjH5Yf061/ZUy5YVzBl7ODTnma9CV8hSC7DlpclF/pGt2MbHj4z2XAJcbEyQW0Tic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745882730; c=relaxed/simple;
	bh=TatMQmOsgBzzPVfaTaPl3Tcneu9OnXjsy4ulzO03/bI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MgiZkVqcGCD2nvB3Stg5y63wfFTrIPYRTozO6s/URWw+pItrNRgGcZPjDDs2X5+9b1zSjJ7adzofZvBwnPDUGoX+sZkCEhMpeuMH/gzhl1EEAWR2gWEhawJ7k5YEiwYZEtWLfGg7mXCMU2dk9eQekR+hIg/MYRIBA7BEWazaxGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aLMr/E7A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PkwdnrIx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SMlSmP025784;
	Mon, 28 Apr 2025 23:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TatMQmOsgBzzPVfaTaPl3Tcneu9OnXjsy4ulzO03/bI=; b=
	aLMr/E7AHwVuWEPaUCxfjIaUZl3t4M4t6bsFIWUTbOvv8ElBmffU/8epPFb+OpdR
	IhXiGmtcqMj8bZgs8C3mzUua3MC7hMJgD45IVatFO1k0HxjF4AVmW5e4XTRtu23S
	XKTIO+6EPpldxf02e0BTtixrvtWxUJMvAzcdT9i41QhoG/pQI+GjVRE0DOOJTnev
	EZvsb95F4qjBPNRMRAcK+SDdt0iS5NrpnRehVJdrfexrdRyzscpOe4HYjHldSQ9b
	KSH5bYgGbhLbqxbWItOqIYQWCbupTGUCE9oK8JmKejOaNJXdTK6aMgELBoGaScHA
	JdxYjD6C1u/N+JuJop9rBw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ajs8g112-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 23:25:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SMBx6W011452;
	Mon, 28 Apr 2025 23:25:19 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012051.outbound.protection.outlook.com [40.93.20.51])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx9khqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 23:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INS8aFIFNiS/zR31MfWKo8oARWh6Qsqd/TWEyqHo8wS8QwW3ETXx/a5csrA2ksQ7G2OmgZzvNAVgI0xa/7hi8GYJF0BaqtQLY+vi/E3mZOIvtBziiQhtyEbnmo/1W0oovNZYd1B2Lw8X/vYT8wngbIOengSwDbOvQBI5OZ8igMNq+aFvGTKbR6A1B94Sjx+W2nia7pPe0UQ/LyPu7Xsu8GxtmuU6DSJDfMkwHXJvv1JvWcHENarQtMvwUh/+si+v1eS8Y29pResVR0F0ci1/JyHMS/rY44p/zpqbzQ9PT8tn9ZF0XHXjfBS0d9KrQGi4yulXLKtR1yCOCERA2gaeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TatMQmOsgBzzPVfaTaPl3Tcneu9OnXjsy4ulzO03/bI=;
 b=F6o+TL1mWquncHpKzQBoOQCh1roRY59fLGd2dM9n8PjKdbjd6T9nedtTnnEX+85Nh66AvKaF/2l4HC/oTCM6vPCySzaI5fKJBzrsKCr4phIrMFwegHRfR8EaPv0MLIcBibU6ElrnawX3r/5G0n8+ai41K2DFZnmGd0ejgNsWqJqertdsAgVLNZIG3QpDACCQ6UoB2h1O60I8/okEJ2FzCsFJs2wjflGGp/88y42BDomdxkpaIqqt+ONo30SNYwGnJQW+/wTd5JBKkihETEdrG/50YCk8sKskKBPIwtpOf+qAXbbZUeywwsJR0ZcSVdmeRBKptcQZmkoXTb651A0Ofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TatMQmOsgBzzPVfaTaPl3Tcneu9OnXjsy4ulzO03/bI=;
 b=PkwdnrIxxVTz3ZQZg+s4OHmWbAd9zlFyI6z3H15RXa9FZtFvTbuGqLZrv3Qyg0xy7GEw80CmqoY1gowr6KCUSqOpRidPxHhCuNhNikI8SnxQs5uwsRazSvLewjFrXJ90SR1HD15EnnA6GtFHEMOuH82F9BO5I1sRhA+W2utKCmU=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by DM6PR10MB4267.namprd10.prod.outlook.com (2603:10b6:5:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 23:25:16 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%3]) with mapi id 15.20.8678.027; Mon, 28 Apr 2025
 23:25:16 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "shankari.ak0208@gmail.com" <shankari.ak0208@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "horms@kernel.org" <horms@kernel.org>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: rds: Replace strncpy with strscpy in connection
 setup
Thread-Topic: [PATCH v2] net: rds: Replace strncpy with strscpy in connection
 setup
Thread-Index: AQHbtuB0vv1h9xZgZUG5V4OmipRVqrO5u9aA
Date: Mon, 28 Apr 2025 23:25:16 +0000
Message-ID: <da04f02a3a94dee1d5a84f409245a56a358c566d.camel@oracle.com>
References: <20250424183634.02c51156@kernel.org>
	 <20250426192113.47012-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250426192113.47012-1-shankari.ak0208@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHOBBMB
 CgA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAme1o
 KoACgkQyD6kYDBH6bO6PQv/S0JX125/DVO+mI3GXj00Bsbb5XD+tPUwo7qtMfSg5X80mG6GKao9hL
 ZP22dNlYdQJidNRoVew3pYLKLFcsm1qbiLHBbNVSynGaJuLDbC5sqfsGDmSBrLznefRW+XcKfyvCC
 sG2/fomT4Dnc+8n2XkDYN40ptOTy5/HyVHZzC9aocoXKVGegPwhnz70la3oZfzCKR3tY2Pt368xyx
 jbUOCHx41RHNGBKDyqmzcOKKxK2y8S69k1X+Cx/z+647qaTgEZjGCNvVfQj+DpIef/w6x+y3DoACY
 CfI3lEyFKX6yOy/enjqRXnqz7IXXjVJrLlDvIAApEm0yT25dTIjOegvr0H6y3wJqz10jbjmIKkHRX
 oltd2lIXs2VL419qFAgYIItuBFQ3XpKKMvnO45Nbey1zXF8upDw0s9r9rNDykG7Am2LDUi7CQtKeq
 p9Hjoueq8wWOsPDIzZ5LeRanH/UNYEzYt+MilFukg9btNGoxDCo9rwipAHMx6VGgNER6bVDER
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|DM6PR10MB4267:EE_
x-ms-office365-filtering-correlation-id: e2dfa2b3-2dfe-4f42-d713-08dd86abef1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1VtQjhhbkE4aU1UeEYxQU83VXBMSnNWK1RqVzFnSG82T2xiN2UyR20vUmJC?=
 =?utf-8?B?NXN5Tm9Gc2RDRExMZlE3VGFBczk5ZmlVQWpQbjdqL0lnNjZ3UWdzV0FENTRQ?=
 =?utf-8?B?aUJ6TzE2MkpkNWZWbi9MMEpORzB6dlJDZzROaGxxeGhoQ1B2Tzc5dUxIVkJL?=
 =?utf-8?B?WHJBdnJZNGU1UmltbFB1dU80c0VSZ0VDYzVJV25SS0Q1eTlkTmVvNURSY01G?=
 =?utf-8?B?R2pCSUpRK1BtZW1rT010SzE5Vm0wZmllU0pDN1dXVFNScVJHZlpOdkpjV1cv?=
 =?utf-8?B?SjhEdUUzOWpXb0JIRGQybEFFOU44M0ZSU0N5eDhxRjQ2b3oySUpBVmoyZklK?=
 =?utf-8?B?RVFNSmZnYXlDdTNWWVpzb1lUeHFyclVFVDFUNXRqR0lvM0lTdlM3QWVxWmlK?=
 =?utf-8?B?WDVjeXoxY3QwRm9UU1Y1czc2OFJtdWRNSkE0NVhmMkxmRlF1VXVRWGlJYVg5?=
 =?utf-8?B?M1BLd2Y4bitmNGhLRlRPWlhiQytFWlNnWFJhUzNwQ0J0WE51ek5VT2hQaEpD?=
 =?utf-8?B?WnV1NmZtaGlXeXNjODNLU3l3M0dZaml0dlhZZnZDajNkVDBMZ25GcXBKeG9r?=
 =?utf-8?B?SGVHMzNUY2lvSWxZUkgrVGtVWHF1T2Vva2p6RFQ5WDBWRkwyWVpNL0dQMVhw?=
 =?utf-8?B?NDRTeXl6Ky9FMFdwRDhZODdrWUhVUlczYlBoTitsT3oyZjhYM3RjaHNJbzha?=
 =?utf-8?B?Witza3I2S0piNWExaXE4REo4VHBacFBkLzNaZEtWaittRnMrTmp0QUtBTHdr?=
 =?utf-8?B?TDcvc2hTQlR4Y0d6VlQ1WVRnWFRaSGZiS3NIbTMySHJCTTBKTE9rVUFnSWVl?=
 =?utf-8?B?U1NJbmVHazFhZTZMM0hLQ09tRVpKNnVpWnNpVFhnODFrT1h2WHoyeWVHUzlj?=
 =?utf-8?B?UW1JRFNiSUZhL1JqR1k1d21JT3dtQWowRkc3dHg4aWRxZzA0WG5JYUU5RkNB?=
 =?utf-8?B?cXJjdzlHUzdDSzRNb0MzdGdpaXZob3F0R1pTU3pDSVNUdkRUYXROSHNQNGRX?=
 =?utf-8?B?Y0x3eFg3cDFFNU5mOG1ibEdGNUc4d2NiVXNlWm1XaXpSNE5PZ3I0NWRncHZx?=
 =?utf-8?B?VytPc1VTMVNlK1Bac2dXWC9sbTVZZTZDakEyYnJrN1dGdnF5ajk0L1VXdXVQ?=
 =?utf-8?B?R1ZJMTR5SDlrbG1GNjF0dnRMUktMcGVQN3JZMmRRaTNmYnl5Z0JVUUVKc29U?=
 =?utf-8?B?TDlPNUVhOWMxNXBVRWs5bi9YaTZuRk5icFdTZXRnb1VDNlJIM3FtYUl2RzFm?=
 =?utf-8?B?UGppK01qanVwNFBtN0tOS1VXVXVGakl0eXFUNVk5N3B0R2twMHh0TmdUYmI3?=
 =?utf-8?B?V2g5VG82cGo5eWMwQnYzMlN0c05TNEZ4Q09mRFIyM3hPemlnZmsxNkhONjhq?=
 =?utf-8?B?RnVMekM1RklXbHlYb2FqaE95UkxRTWdKUGxmRm5iT1JaVUNRS3ArNVkyV1o4?=
 =?utf-8?B?WUdUUStOSjRLRnpzdXRFSzFHa1Zxb0ROdTFNaGhaVys1QkR2ZVJGUHJNNlhX?=
 =?utf-8?B?c0RqWEJRZkVJYlB3STRrbCtEbmZJVHFtU3dDdk9WQ3hRWk5SMFIyck8wb2RW?=
 =?utf-8?B?QmxjV01uZm9jeHBESXpKUWNjMDU0YXlOVzdSYllacTMrMURMdHpWTXE1aFVD?=
 =?utf-8?B?QVYrcXJoTzdwQ0pjQnBTeG1jNTRTakJBUVV3NFN4dlZpbnN3TStWOTFPZ1dD?=
 =?utf-8?B?NnNrOExVUFV6MlRjSjhvb3cyV0FNdlk1RENMeVdzYUE2VS8yZVpWTkw3MU9v?=
 =?utf-8?B?SUV6QVM3U3hJaE1UREVWRDM5eWJoT2NibmQzOGFpdU1telRNNEFhMHhJS0Iy?=
 =?utf-8?B?SmJVTHp2K2lsVFBKWGQzaVUvdFF5a2tvd0NhOTVWNTVXa01Icmw0MHNBZ1Nm?=
 =?utf-8?B?WDZFUXZVSnU2Z0dPVStqMjJ6TlYrRHdVeWlQSDU2M0plMzVUazZGRXRBTXNT?=
 =?utf-8?Q?GzInypgFwS8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnZneng1NXNIb3dFVWZuZTdQREJrZHNEYURoVmVIOUtPcDRRaWtCcEptY3FN?=
 =?utf-8?B?RGJtYWFlWm5SQ0tHRnFKejQwVlZDZE1WbW1BWGRwV0FrZWYwdjF0TGZJYUxB?=
 =?utf-8?B?TmRybEE0bkVhOUk3bkMrb3JjQUwzVkkxbGFIWnpwdjE4Y1puOTUyMUl2YmJS?=
 =?utf-8?B?S3FLcW1RSVd0c2N2eDhXWU1sWTZFcmdteE50YmpBdG0zeW9wRmhlV2NxaXNB?=
 =?utf-8?B?bHgyMjVjQmhhM3hSaWlTbTkxVCtIb0IrTVVKWmtpYm5VNUJlQlpPOHh0eE5K?=
 =?utf-8?B?RkVpU2N4eXFwNFpsOWxmdDhqcHNBV3pZVTZETUsya2M0cVBrSnliZ3hDWlJ2?=
 =?utf-8?B?QWU5NGNiTEdrTUM4ZzBkV3dQMnJybTNZaEdUOVIxaFBtRDI4K2t0ZENhS2I2?=
 =?utf-8?B?R0lNZ0MrSUxTb2ZTTWQ0ZEhOL00vYTRORGxLcDdOeE1wL2FJYVVyVmpmamUx?=
 =?utf-8?B?UWkraUdOcldlbngrQkxUNlZ2NkYyWms2OUZqUEsyTFkyVWYyOW9DVnpKWGdk?=
 =?utf-8?B?bTg4U0QxRUdmNHc5V0paWVpHSythaG03ZnNIVmN2NGp4Y0J3bytLS0YzM2Jh?=
 =?utf-8?B?RUNXRjh6WkFuZjg1WlR5SE41WWVMRVJmSWN2bkJ3SG1sZXlXSlBNQVJ4NE5m?=
 =?utf-8?B?RHZpWUtSSU93NGUrbW05Q3VhL0hKcjFHTEpaby83WWNNZ045TFhlaGxEcXgr?=
 =?utf-8?B?NG9TaThwN0lWV0JLSTZIUGgxU0JCZVQzYXZZNVB0Y3dQVEIwM0xhTEtLbHl5?=
 =?utf-8?B?WmVYNVVuRWtwNE44bkZFOGJMWlBjYTUrN0dlVjhQNVNXWko0NFlTMDdtK3B2?=
 =?utf-8?B?SnNEVzlZZi80VGNmcFNMbFJYb2JUUW1aL2kycGM2SnNBTUNYeVE0VWVsVWZh?=
 =?utf-8?B?bDdOT3lld1lyNXF6S2djclFJNDZmdkFBRndFd0ZHQ3RpbTRrYnFJWFUvcWRy?=
 =?utf-8?B?enVLRVpNVm1VemhDRVhyTkNQQ1JzOUhsTG5YZkI4MlA3ekw4dTA1VU5KdzdY?=
 =?utf-8?B?VWt0ejlka25GeFkrSURnWEtkZW5qay9ScGV6QlRsUTVzYnMxUmZTSnhucWha?=
 =?utf-8?B?eFZhSXY2emVZeG8zNWRSZzV0N3R5SHB0dFVYUDFmanM3M0tPakZleHNxV2dp?=
 =?utf-8?B?S0M5cFdmRjdnWjYyS1F1ang0Q0VpMlRQeVhndldMYXp5eFo5QlhnWGp4elZX?=
 =?utf-8?B?Wjd2bzJ1eldCWTZmaXl6T2lLRFJIQjFQdnVIdFVRUmVIZU9MbXFKbzJJS21B?=
 =?utf-8?B?a0xtR1F0VHhVdGR0RUcyOFd5bkhya0txMVFSRGd1QVdRYm5sN0twcGpBRVA5?=
 =?utf-8?B?NVRXMWpuV29LRytDaXpkSUtaNUM3MmMyRVpoTUl0YW9FdU1MdG1uZ2Zyc201?=
 =?utf-8?B?MUVmVjlYbjRzL0ZtOTUxUUlMQUFWMnVWZm1BRzNoT3hZbUdlRXl5ZlU0VXh0?=
 =?utf-8?B?QWgvbHJKSXNlQURXY2IwOEg3aHdxMFNIaFRYTUdLa2pPUkVFdFp5MEdmdlVR?=
 =?utf-8?B?SFFSYnI4NjZWODRoTzhpeWI0OFozNVZNV3YxK0RGQ2ZSUExOb1k1UzYvbldV?=
 =?utf-8?B?T1NnNm9zc1FPbEtSSCthUnRqOUZIckc1MnkrU25iVXFiUk53SjVETExhRWhH?=
 =?utf-8?B?ZE1GWk1mQ3JGcDQrTUVpZWxxT0g0OVhhZEZmeVJDWU81Y21nY1hhamRYbTJw?=
 =?utf-8?B?M2trd0NYdTVTREpHNHAzV2dqOFBFY2FteVlFQVVFQXIyUGZNa0pwT0d1ZSti?=
 =?utf-8?B?MjI0aGVBYmdnbDBnb0RRTWZZSGpsZ05KMzFzZG03YUo4aExwMXQ1WkNsbE4v?=
 =?utf-8?B?Y041YTZBUDBBRUw5ZjNRNkg5T1E0aC9RbktMT2Z0K3ZTMnJyVG1RSnFJSVJ1?=
 =?utf-8?B?MFJNL2FPWHorcU1sMEdjNmRaMkRocStrU3BVNWpMUlFrNkJhTSsxcEd4bnRx?=
 =?utf-8?B?KzBCTVF5SzNQdHpSRXZtY3JpSGFKQWpDR0JGSDUzNTNiU0NNNUUvbk9aQWxT?=
 =?utf-8?B?WGZkS0VDUDAzTzlRRlFVcGNaZ2M1WTRKcXJHZXpFYkZnSlRWcU1kQWVUU2ht?=
 =?utf-8?B?WVh0cmZES005a1lqRWlUVjdjTk5VeS9NVmFnZisvbVp1RFpnanBOSkhOOTVj?=
 =?utf-8?B?dlpzVzRjbFBKWmt0VW1UQ0p5NlFRcGx4SUY5bkhZYlcvMUp0RjV3TDFPcWVK?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D3130DA2AD6ED4780A426A0F8AE5777@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3jIB3DT/txKaYsAAWv0dBHBmR+8SwJwoudVlpywMkaOTHieMWaoxIEF1NBPnXXQw4Z/ohNBKs3GwP+TDT9BEAMqyNstxxyDYI6KU5vKdCiwrrT7y6SXwSZ/wwkkz0Tg30n8CfgEjfAtRGkDNMDRoews+f1DuUZMxCh4gc4XRzcPF/FOGAsoZf5oGtxoqOvt7ve3bD2vaBbzpszdqyskOtf7HzKIjtwb0Xi1hPMajOs+2dgL7P4XndHeNps56VtlfL5qJVH5HeL1lOm7c7h4SWzOij4v8jdzMiqocEAegaExqR8T016ETOA/5GmfRuq+ugMOXOSvDgZQhh59mC72uPOnT2RrP4njdraCbHUMUu017gS5ajuhVZEcChAMilnN1KGTxYQ6mbanKF5dsMQjO4nFpTlLTQztIDhyyQyTgDyA+fwd2IrgC+0dO2dR4DcqhnFnPObZuWz2nAkIkJpDilzdx2911ZvBwK3nznzRo4NMZaJkZEcRuTJxOlpJuV9O/R+6DwhzQ+MvmRjBLmzdKf9G48NT/wd6dUauTa+gziiNaxyZNAxuBi8lKD2SMK765iyTqyxJthBW2bxLfRH4FAKZg9sRA0zrdn/AvpMrLB8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dfa2b3-2dfe-4f42-d713-08dd86abef1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 23:25:16.5443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbaOjEpb4xyv7bI2ulzZf77SGZviY1X+Ep7KHM0SnSJ1FNeUGOy+zlL6pEPYPupvEk+VHq2kUYUzC11YhsId0seUtgK5l0GMeUaF7aQyF+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280187
X-Proofpoint-ORIG-GUID: Fy91BnoDv4gEASQOVL5lGgwTC0pOI5ue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE4NiBTYWx0ZWRfXx4nfU+UyC3Hd uqQFrFbrjlgNroVVmeymehpYB3KrLMyO7m7Whn8RnY+LIyw5c37rdLY1TGdClNrwO+YFL3XKSLO wqCqHHID+VAXgn0wU8D5OCVaSDCdjn8JKbxnRCbpXyNIC+7j3w1rMByvzxWpwok8gpBTQ4/a2pe
 uNK8AZG/nFespm4V/fdt2VEjZZso0VkjJaCO0QgtmOnjMkz4dXx8keKqk+BwrkJ6lFFxNFvRYgz iDrv+yTpZVZxNOhdIK+eZ7CE3YKDjgHcRi1OJoj2+7VuWrY235JHLvVxcMAvApgVJYCqn2eo+g0 lJ6A4LSuUOdUlRAVrujiiKMr/Ceby9mYbi8ZMX0Z88+hYa7XKH2XwB95RXQqFSZi8Lxa+8VxAfB 8DuehSDx
X-Proofpoint-GUID: Fy91BnoDv4gEASQOVL5lGgwTC0pOI5ue

T24gU3VuLCAyMDI1LTA0LTI3IGF0IDAwOjUxICswNTMwLCBTaGFua2FyaSBBbmFuZCB3cm90ZToN
Cj4gRnJvbTogU2hhbmthcmkwMiA8c2hhbmthcmkuYWswMjA4QGdtYWlsLmNvbT4NCj4gDQo+IFRo
aXMgcGF0Y2ggcmVwbGFjZXMgc3RybmNweSgpIHdpdGggc3Ryc2NweSgpLCB3aGljaCBpcyB0aGUg
cHJlZmVycmVkLCBzYWZlcg0KPiBhbHRlcm5hdGl2ZSBmb3IgYm91bmRlZCBzdHJpbmcgY29weWlu
ZyBpbiB0aGUgTGludXgga2VybmVsLiBzdHJzY3B5KCkgZ3VhcmFudGVlcw0KPiBudWxsLXRlcm1p
bmF0aW9uIGFzIGxvbmcgYXMgdGhlIGRlc3RpbmF0aW9uIGJ1ZmZlciBpcyBub24temVybyBpbiBz
aXplIGFuZCBwcm92aWRlcw0KPiBhIHJldHVybiB2YWx1ZSB0byBkZXRlY3QgdHJ1bmNhdGlvbi4N
Cj4gDQo+IFBhZGRpbmcgb2YgdGhlICd0cmFuc3BvcnQnIGZpZWxkIGlzIG5vdCBuZWNlc3Nhcnkg
YmVjYXVzZSBpdCBpcyB0cmVhdGVkIHB1cmVseQ0KPiBhcyBhIG51bGwtdGVybWluYXRlZCBzdHJp
bmcgYW5kIGlzIG5vdCB1c2VkIGZvciBiaW5hcnkgY29tcGFyaXNvbnMgb3IgZGlyZWN0DQo+IG1l
bW9yeSBvcGVyYXRpb25zIHRoYXQgd291bGQgcmVseSBvbiBwYWRkaW5nLiBUaGVyZWZvcmUsIHN3
aXRjaGluZyB0byBzdHJzY3B5KCkNCj4gaXMgc2FmZSBhbmQgYXBwcm9wcmlhdGUgaGVyZS4NCj4g
DQo+IFRoaXMgY2hhbmdlIGlzIG1hZGUgaW4gYWNjb3JkYW5jZSB3aXRoIHRoZSBMaW51eCBrZXJu
ZWwgZG9jdW1lbnRhdGlvbiwgd2hpY2gNCj4gbWFya3Mgc3RybmNweSgpIGFzIGRlcHJlY2F0ZWQg
Zm9yIGJvdW5kZWQgc3RyaW5nIG9wZXJhdGlvbnM6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL2RlcHJl
Y2F0ZWQuaHRtbCpzdHJjcHlfXztJdyEhQUNXVjVOOU0yUlY5OWhRIUpRM0ZobktQeGxHdlFrcU54
T3RIUkpmVk5tR0ZUYlpWMlZYMEdBcGpBU3JoQ1hGZmUwSV9XMjdsMDhCQ0lhdmNiSFdhaVdaQmJP
QThKZU1lVmlldVB1VWdsbDRPWEUwJCANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoYW5rYXJpIEFu
YW5kIDxzaGFua2FyaS5hazAyMDhAZ21haWwuY29tPg0KVGhpcyBsb29rcyBmaW5lIHRvIG1lLiAg
VGhhbmtzIFNoYW5rYXJpIQ0KDQpSZXZpZXdlZC1ieTogQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlz
b24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiAgbmV0L3Jkcy9jb25uZWN0aW9uLmMg
fCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy9jb25uZWN0aW9uLmMgYi9uZXQvcmRzL2Nv
bm5lY3Rpb24uYw0KPiBpbmRleCBjNzQ5YzU1MjViNDAuLmZiMmYxNGExMjc5YSAxMDA2NDQNCj4g
LS0tIGEvbmV0L3Jkcy9jb25uZWN0aW9uLmMNCj4gKysrIGIvbmV0L3Jkcy9jb25uZWN0aW9uLmMN
Cj4gQEAgLTc0OSw3ICs3NDksNyBAQCBzdGF0aWMgaW50IHJkc19jb25uX2luZm9fdmlzaXRvcihz
dHJ1Y3QgcmRzX2Nvbm5fcGF0aCAqY3AsIHZvaWQgKmJ1ZmZlcikNCj4gIAljaW5mby0+bGFkZHIg
PSBjb25uLT5jX2xhZGRyLnM2X2FkZHIzMlszXTsNCj4gIAljaW5mby0+ZmFkZHIgPSBjb25uLT5j
X2ZhZGRyLnM2X2FkZHIzMlszXTsNCj4gIAljaW5mby0+dG9zID0gY29ubi0+Y190b3M7DQo+IC0J
c3RybmNweShjaW5mby0+dHJhbnNwb3J0LCBjb25uLT5jX3RyYW5zLT50X25hbWUsDQo+ICsJc3Ry
c2NweShjaW5mby0+dHJhbnNwb3J0LCBjb25uLT5jX3RyYW5zLT50X25hbWUsDQo+ICAJCXNpemVv
ZihjaW5mby0+dHJhbnNwb3J0KSk7DQo+ICAJY2luZm8tPmZsYWdzID0gMDsNCj4gIA0KPiBAQCAt
Nzc1LDcgKzc3NSw3IEBAIHN0YXRpYyBpbnQgcmRzNl9jb25uX2luZm9fdmlzaXRvcihzdHJ1Y3Qg
cmRzX2Nvbm5fcGF0aCAqY3AsIHZvaWQgKmJ1ZmZlcikNCj4gIAljaW5mbzYtPm5leHRfcnhfc2Vx
ID0gY3AtPmNwX25leHRfcnhfc2VxOw0KPiAgCWNpbmZvNi0+bGFkZHIgPSBjb25uLT5jX2xhZGRy
Ow0KPiAgCWNpbmZvNi0+ZmFkZHIgPSBjb25uLT5jX2ZhZGRyOw0KPiAtCXN0cm5jcHkoY2luZm82
LT50cmFuc3BvcnQsIGNvbm4tPmNfdHJhbnMtPnRfbmFtZSwNCj4gKwlzdHJzY3B5KGNpbmZvNi0+
dHJhbnNwb3J0LCBjb25uLT5jX3RyYW5zLT50X25hbWUsDQo+ICAJCXNpemVvZihjaW5mbzYtPnRy
YW5zcG9ydCkpOw0KPiAgCWNpbmZvNi0+ZmxhZ3MgPSAwOw0KPiAgDQoNCg==

