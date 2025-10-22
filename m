Return-Path: <netdev+bounces-231897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7963CBFE5DD
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0121A4E8B39
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3F72FF14F;
	Wed, 22 Oct 2025 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jmzP7zn/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RJCiBNO+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B91DF75C
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170666; cv=fail; b=Sdsi3wiUd63cmzFTMXh30bXChYNRMa6QWHyASXfl0Xia3N06RlTGNkDS6GAAtBxsZyqLF7QI7DEsPFND5P1MVaqhq2z4QT/zEAlI9G/UHB/kwbqNxsphBnWRZj6CuMlJQlMSHhGWn+31bfthj/Az19gKtVdvtaRxDFqjUIEX6q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170666; c=relaxed/simple;
	bh=YN62uGVsREjxRZzIW/ocQF9+yEfUAUYMW2B4mwdmV1c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C/ucE0BCyy7OhmVDVQ1dHgsY7nhU1Vy0ibvueRG4J8K/aHfNvffATqe0puenOBNwsOdpCbQmgZEB09ZZxVTTpsrx5HV0pqg9cQqCFwYn6uago/9BcWjFP5tnYghF3XjzdeKDtVAa9fggZhjSc6ITKogj4EnZASETJ/k6I1Pkxpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jmzP7zn/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RJCiBNO+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MI0FCH015833;
	Wed, 22 Oct 2025 22:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YN62uGVsREjxRZzIW/ocQF9+yEfUAUYMW2B4mwdmV1c=; b=
	jmzP7zn/YOLtxMXGimfBlmcSCpQcMoIFumO6HrRm4yK/bKhNr0iyql46QmkFu1EZ
	5GnfNTMCAP4gsx7u1cno6i8yoUum5MdJq1lW9/mlOxS6DtLjcA2zXn9Pj/Y2SpD0
	xjHe6ItFr/3l+45bguUq1XD/7QndPoFFUPxxmEq+ymdVkEengjHhFeiGq7xffSlM
	AmAIEybSZzRT54FLF14/Ee1yVJYUTKASV8eV4ECecIvract4xpc3Q48o7Bcf1igz
	ZubqAkQ6yN07Ms6xVXWet0G3Z/KR3RT124U7tVUK3lKHByogE+EP1gZVIj5mQ5nl
	BqChD5wk/lL4pDmjgRrb0g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49w1vdqt6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 22:04:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59MK93Dm012474;
	Wed, 22 Oct 2025 22:04:19 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bdsc4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 22:04:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNUJIR5in0fikvIueV1j8tCQDCVNUJdkDBm9U9RzKTlE0GmVJ2ChMiQgZ4J1QefS6Qu0E80vFifpNPfens25rn/BLeH/hOl6Y8ilp4hGGGslCdrw7mBJXmGklYCob2x5vtjlgRA8esYTCHJttuuTLgmNLhcTzR2rhkWIXcaFP9QfmscdOC7VbF3/ANnSrONoKsnj10vSc37ZP61zXMfAFA2Wn4LSS2Hzq0BUXHckcYlMtmugOSgzWdJ2oAwgqNTRb6y3r4PYFGmfZz6JPTJjLsySGlg43shXD/MunUbavaEAd/CCyKVDw62H2XNfs8vVlcQMO85jdmmFOrrLZFsn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YN62uGVsREjxRZzIW/ocQF9+yEfUAUYMW2B4mwdmV1c=;
 b=EWm+U3HbU/hcSBZjGi+wN/b7phUT5VXE0l50V+eLSWvFeMnEZt4KaQtBAontoCsF1c4G71qgXbSIKzsYrAwqI9OHjjqSQUZw7TxYT33ngkbNZExqOJwzLJ3C+Iwjh1ife+t5sf/OwQVCo4jlZJPHmJKcgxiv7Rl6qd6GojuIhltkUVSuX1l0RSC2jemka8LDNo8pVVklUUlSnH6wCXvMEIDZ5xFFsts3R6rDUW9yf+sA0kFdtds9Z5e7Lvfoqj9zbp0oI3HLxcgMW9uzEL0aL8aMsJ1Q1/QrCSYuduRBJjLSu426o0QBWyCzbENAlSoc7fdgq8+p0xWMN5ddIxxTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN62uGVsREjxRZzIW/ocQF9+yEfUAUYMW2B4mwdmV1c=;
 b=RJCiBNO+SekzYvULQunf4BydZmgqy8jnvx/x2AFSbPlTba86JVAgVd+MUs4zWDegYE33KLaldhEa1SBFq/krtsDCEJlk0bww32aQ5ehT7OZkMoVZBSuGhWV3nWbpIzCGCfGT0GwJWoVdvSmgYYI3nLbmyCjAsfuKSaz0BH/ME30=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 SJ5PPFCC6481C4C.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 22:04:16 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%7]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 22:04:15 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "achender@kernel.org" <achender@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [RFC 00/15] net/rds: RDS-TCP bug fix collection
Thread-Topic: [RFC 00/15] net/rds: RDS-TCP bug fix collection
Thread-Index: AQHcQ4iCvjuHkFFkqUiTjV3oxGWEhLTOuIkA
Date: Wed, 22 Oct 2025 22:04:15 +0000
Message-ID: <9f725c08246638a1a840d01d2aa0fed7847de5c6.camel@oracle.com>
References: <20251022191715.157755-1-achender@kernel.org>
In-Reply-To: <20251022191715.157755-1-achender@kernel.org>
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
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHUBBMB
 CgA+AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAmiSe
 HYFCQkpljAACgkQyD6kYDBH6bOHnAv8C3/OEAAJtZcvJ7OVhwzq0Qq60hWPXFBf5dCEtPxiXTJQHk
 SDl0ShPJ6LW1WzRSnaPl/qVSAqM1/xDxRe6xk0gpSsSPc27pcMryJ5NHPZF8lfDY80bYcGvi1rIdy
 KD0/HUmh6+ccB6FVBtWTYuA5PAlVOvwvo3uJ6aQiGPwcGO48jZnIBth96uqLIyOF+UFBvpDj6qbfF
 WlJ8ejX8lmC7XiY8ZKYZOFfI7BRTQxrmsJS2M+3kRTmGgsb6bbPhaIVNn68Su6/JSE85BvuJshZT0
 BmNdWOwui6NbXrHgyee0brVKbngCfE4+RZIzleoydbHP2GnBtaF2okhnUWS/pNKsOYBa3k8IXdygc
 CbiXmjs3fIf+8HIm0Vzmgjbi5auS4d+tB+8M22/HWdxmdAB0sHUFMtC8weYpVxvnpGAsPvy166nR5
 YpVdigugCZkaObALjkJzNXGcC4fuHcqZ2LVHh9FsjyQaemcj8Y6jlm4xUXgyiz7hkTNsWJZDUz5kV
 axLm
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|SJ5PPFCC6481C4C:EE_
x-ms-office365-filtering-correlation-id: 52055ca5-cbb9-4275-7e87-08de11b6f101
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVVoRGVSczVyRGhaMFNWcDkyL3hjN0E1cjZYRWlEUVF0RCtEbmFsYWlSWGR0?=
 =?utf-8?B?WGV3UTdYSDVRaU91SVNVc2ticzhDYzAvZENScWUvYVF6Y0Q0VldEckR1c3BE?=
 =?utf-8?B?YmZRM1BvQjhva1Y2S05hMzVwY2ZRNEVlU3UxaXZTV29naGlyb1ZReUYvV21t?=
 =?utf-8?B?a2hZZEVnVGNSV1llRjJYcis5cDNwUTRzbTJYUjhHd2hRZ25QazlBUmw4M0Z4?=
 =?utf-8?B?UGtIK1owS2FxUWFoNVlKWDA5MEIrY0grMWpISTh0eHdMZGttdDRyVjNvVHQ1?=
 =?utf-8?B?aEZVSWlDR29LTHFpN0cwVkJzUVdFbU14STJVeDhpN0xVSWtSY2hodzQxWU8w?=
 =?utf-8?B?WHZvSlhoZGNuRzRKT203aFlsU0NsTTd4RVNjem56a1ZJS25objZ4RG56S3FL?=
 =?utf-8?B?NUoxT0dNVmJoczZKbkJYRXBHNWtWZkxiWVhxR1Z6bDFGMTdjeEpuYUhjN0Rm?=
 =?utf-8?B?aU1EV2ZDY2cvekxNMEhCN2t0enYyNFI1OVNDb292US9UeWNqcThOc3ZTWldK?=
 =?utf-8?B?U1BqcjlLaWFRMkd2NW1hb1pEdjM3cENlMWIrV2xkUnA3SXh1bkljQStrdjVq?=
 =?utf-8?B?WlpDaGRoUUU4cVJ4TDNxcDNzSUhtNGdqWXdpUG5waGc0TkR0ajJ3OWFWUXgv?=
 =?utf-8?B?RVlkQmFvSDZEUVgzRWZPYVp5NG8wOHV3QUxBdVlXT1NTclNhd080Rlc2Q2Y4?=
 =?utf-8?B?dWk3N3VuWXkxSnlMODM0aDdxMGg4S2Jic2prMGt3amNVbVlpYnpndWw2RUc1?=
 =?utf-8?B?WlVsK3Z4REZuREo1cUVGUURtRjhaQmdQcXRnRjRpSzVSNml6R25rWndSaC9E?=
 =?utf-8?B?QXJxQ0VkaW5tK3AxeFlrbno4TjArenJ1NTR5OWo0VUlkbFpyMlZvR0x1cS83?=
 =?utf-8?B?Q1h1YnkwTVBOaTVDTmtuY3lXcVhRZ2trZmhxWlJxQkFadXEvc2VmTENDSGJM?=
 =?utf-8?B?dmRsTkl1WUpzSVhjbkU0QTVQdnNZRGlTYmFlRWR4RWh4aUxRekhPakIvYkp1?=
 =?utf-8?B?RllkeDdzT3ZZdFhSUFZOSWhnUDZXemM5ZGFNT3NnOTBtQWJ5OGRENGdpS3dP?=
 =?utf-8?B?bVNDTFVlSTV4OWFZZm1OWG53L2dTZW9Ua0QxZEw3R0p5UG5uV0FEMWpKdnpO?=
 =?utf-8?B?NzdnUkZNbDdCOHVmZExlVVI5ZThaeW1Wb2Nyb005cVVmeVBza2U2SjJsRmtV?=
 =?utf-8?B?T2Y3VnN2eFdDU25LV3lyZW8wbnlkZm1vSmN6OXA2dkhFZEsyWmY3T0RrMXJJ?=
 =?utf-8?B?TnBUVDQvSGN3MGNTTkNJZ2k3NFZmR05qd0dPTG9qaElSaHZSQ1NocXpBR2Nw?=
 =?utf-8?B?OXVTeHM3K1JHOHVwejdoeGFORVdjYTdYMCswR1pqdnozeWhlclFXc2JINHFa?=
 =?utf-8?B?YjZYNDRWY1NPSlpZWis2cHF4eDBLQnJrOFloNTkrMEU0bngrWUJLVWRuUkZ4?=
 =?utf-8?B?bzNob0pPaXFodjcyR0VXQ2wveUhNVHNTQWNFZnNuRWNEVWtMSithTUpyZjdJ?=
 =?utf-8?B?YWVURmlPTXkwWmQ1T3hMVzdWWUxiSW5oZWkyMGV5aVd2MHMxeXdldkUyNVAw?=
 =?utf-8?B?a2JvL20vWGFGaFhVQ1Vva241cVE2OFQyWk5IdEkwSzdBbmVPeTRVdVB3amVt?=
 =?utf-8?B?c204QzlFQlREeFo1THhRUkc1OXVncVhGb0VYaHRZbU5yNVZiZjgrYUZLVW1s?=
 =?utf-8?B?OFY5aUhaQzZFT3FmcW4vTGJnaFhIbTJPdFdwY2E4aFM0akFnY0E5U1hKNHQ4?=
 =?utf-8?B?b0pqV2gzRDdJQkdXWUxnc3g4azNLSktRVDFuZDVDK1NoUHp0a3dzbHEzRkEr?=
 =?utf-8?B?R2FYVUFOQUk3NGkrajkwc2xzZXlOeGtudnJTZ2pFLzJYN3J2TURZZks0TFg2?=
 =?utf-8?B?dGFtMVdoeDVqQkpOallCZjRLZ1YvRHBRV3pvUlRNMUo3bVJVcVRVQmZVQ0gv?=
 =?utf-8?B?ekRYbWtmT1RBZytXbTd4d29LVC9MNGRLQi9rWlYwT3l6Q0VyeWdEbllHUXFD?=
 =?utf-8?B?NGRXZGwyRTNJaEwzSjlhdkRnYm1YTUNLWllJRzdKQjEva0VXbUhTY0NCT054?=
 =?utf-8?Q?lp6GF2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEJwK2x5NXpTVUgvUUJRbUZiWDczSHdqQzFqeDI3dENJVHpvTG03bzhGQ2pi?=
 =?utf-8?B?RG5zK2lmNnZoa1Z6dUt5ZWQyaUErenYrNUhlTGY2TVlJSVBTL3pPSmNheUlP?=
 =?utf-8?B?b0hXRGJWVFpCRS80REJKMVE2d2lLOWNlcElYaHZjbGlLOTFSNFhRdEh4R3lt?=
 =?utf-8?B?YWk4U3BSM3VyOUQyd2lYMTRsMXJidmlsOUFXYUZMeWsvb0pIaTVDTkwzT2Vj?=
 =?utf-8?B?cHhDQ2t4WHdUT3V0amtLM2MwVDExOFBsQ0VwNXVnR2FLRHZzdGlQTm13Rmk2?=
 =?utf-8?B?WnNsbVJQYlRGRmJWZEk1R21sRUI0ZGJ6MEZ4K1czUDJHMGRRNXpVczN5VytL?=
 =?utf-8?B?dURhTlk4b0xUQjVaMFdjV1pKUjRYV1dVUzJkSVhJc2lSQThaYy9zZm1PNUtZ?=
 =?utf-8?B?U2JEMHVvQjBvNTV0cW9oeFR3VVVub3ppRUpzbFV4SWdFUkhyc2hUeldPNVVh?=
 =?utf-8?B?bFdXb1JlcHA0ekF3TWp1OFNEYTVvSEdialIvVCtWZTRmVFUwT3ZqT1RBSlVl?=
 =?utf-8?B?Uk10NitBS0F3b1RYQWlHaDU4STBSN0s5K3VNNDQwWGtVSkFMODFFZXVDQWtP?=
 =?utf-8?B?N0JCZ01xNzh1S1VmSTVVNjYrbld1VUZWQWZ1Y2NHTTkvMDhoMC82ZTJTckFK?=
 =?utf-8?B?Y1NKZDhTbFVBcEF2SVAzODdXYTBWcmZERHVBN3VwZnpwRWJPLzJOSEoyK0NR?=
 =?utf-8?B?S3dPbHBrVkVYSVJpeFQ2RmJHVVd2V1B2QUFINVZYdmFsbENTK3h3d1dJNkhY?=
 =?utf-8?B?eVBOL0lkdzlGczFwaHFSbFZHbnhyenFCQ0dIbkEwQTdqSEEvR3BpbUY3SFpp?=
 =?utf-8?B?Qk5WeUpBZFZBV2M3a0tDdDJQNFpDNFhzek4zZkR1THI4RHRjYnpVQ0c5a29z?=
 =?utf-8?B?ODkvMGRtblBBaWJkMFMrY1JZUjU4YU5DN3V5TzRuQmV4SWd5bytvUTNkVGp4?=
 =?utf-8?B?ejFMTHI3Z3pSUXBReXJwNXV2T2tOQkdQTUYwSldhTmd3REVOMXFPWWlkbVgr?=
 =?utf-8?B?TktrY2p1VDU0ZUEwNElBWnBXZUNnRXJsNVdXNjdrbGdaQ0MxZHJDUlhSQUZj?=
 =?utf-8?B?ZC95RXgzZ1p2SS9rcmV6Qkl2MCt1Qm5wbDFwTm5OYnlRS2Fpc3JsMTd5MEJD?=
 =?utf-8?B?WncyWlFUYUJQZmJjT3RmWFdEZHhMdlhIU3NTZ0tHWEkrNmhvRVpZMmNBc1Ar?=
 =?utf-8?B?NnMwQ1ZXQmlMay9QbVlHQW5pYnkwN3lLZUd2MUVMR0JyeDBrQlZrd2xKRmJp?=
 =?utf-8?B?WHFsbXVUR2RHYVJFTkFSeVdGSDhqUUtNRnRycW05SmYvYWo4SkMydC83K1ZV?=
 =?utf-8?B?TmtxSFhyUWpKWVdCUUtJTjJJTnVDSG1qOE9oNk02UGdtc0NzcktURFE2V0pP?=
 =?utf-8?B?dUNINi9TdkJIZ0ZxWFBNOXIvbUhkRVhRQU9KeHRWdUhCVkdNMXpRVFBzWWVK?=
 =?utf-8?B?UDVoSzJEM2l2eW9kUG1RV1VUU3hVRGlMVVcwS09yL2pwM3ZjTlBxeGx4QjU2?=
 =?utf-8?B?UkxvdGc4VXVuTm15dmV2MUdacUkvRy9sU2RDSlBjZjFqYzQrVW9nSVZhbUpj?=
 =?utf-8?B?dUQrTEFOVFJoQ0FReS9zc2lJbzJxdkN0MFBQZW1KUTkzTWZBYm1HcllVOFp5?=
 =?utf-8?B?cEM2NEh2WTR1Y2VYc1B3U1RYY044SlVKOXJRRmVXU2lyRkEvRWtINjE2THEv?=
 =?utf-8?B?Q3liY3pzWG9tdUpTdUwrTWxRTlZCNWUyY0JxcCtnZG5VSThROWdFdXZhQm8v?=
 =?utf-8?B?OWhFbXdkM2NnZUplRFYrUnRnNnRLN0F3K29kQ25FVTdOLzVhckNoRzFyb0Uy?=
 =?utf-8?B?K3gvdWZJYlZOUlJCdnQ4bjhRZkMvMVU4UlVBMlhTblFsK01rcEo3YVh3SDh2?=
 =?utf-8?B?dDdJRnJpMkxSVy9McmJwcHlzZUkzVWM3YURrMzZlTHRoVTRSMUJkbW13aFBN?=
 =?utf-8?B?VEJ0LzZMNUR1WXhrb1R0TDZzQWQyTGpNODBSV3FicGgvK0s3bE9YN3FYQ21r?=
 =?utf-8?B?bXRnb0F4YWQvdkhQQk00Mkg5OGJKbVRldTZCeEFjWnlqdkJsWUhHMitKZC93?=
 =?utf-8?B?UE9LTlRLS3lPODQvOGsyYUt3K2k0WHRWOXBZeWtxYXR3cDNjS2gyWGlhZjFE?=
 =?utf-8?B?U3RqTnJhVW9BVk0zUkt5eVgrYlZaMEl1TWJKL2dvNys5a2JjSUdxbnVjTEpH?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F495A2A0E7C3734CAF601F4CCC050DE0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w119NGIbGQffDkKOnCRU1PaLaY6L1uP8NJBgOAMRTiJbHUIhbZu7q+kRjNQDVl6fTE9XBX7pvis5hd5kpftsAT3/ZnTTM3QDaxYewd8eUGpKFkvDpAIxvbwXQYMPa2xGqzF8yvmWD+09Wr1wBN2t9ILcDYzfdFth/J2ssqCoKkdibLlhlmqTb0cANshmiiUiBIOR12ghqcC55DKpfQIuQP+pul0/tNvlZmSoWG6g7PnWZnNMguac5ZlImSyBLqfMPouVQCLXIGSRZYUmKjh7R3T2LlqQr8bg55kycZfgHoSQGaL5eObgmttAOg9LDq/gofkC8/Z7Yf/D4Arb8Ex31hyPBUsFJBwpfGkS+U6dUr9xbH4mVx98IeiLvXclaYEfyMiiA4+aZ1TDNM/tKgLIo3lzS5lByGnYqCnL+XqtTb4n6olM2mYmMzL4BkFXrUsduUT3e1knxJISwU/TYf1q6WfXzXS5jCgUUtGvjEk4kWQeW1W7zuspGObhIlfmkHi/8Zep/C0Vqmk+2ArEUpjN77bE2SsDUvEi3MdxO/6jThvLJl2aUxBYlMDC/iFkf0dasYCrzJTfCpGM6AoZ/VdNzSynK791ai3mZw+xJnwYhcE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52055ca5-cbb9-4275-7e87-08de11b6f101
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 22:04:15.7992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxJGixWxbe1ejPAq+nWOgQwNVRJN7ACkrCp4yyTcdNjrcgkEnR4Xk2bOOhoSVSeDOEFoDIsRmMqImOQkEl7aE4BIX2nGs2dfUreY5iDktSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCC6481C4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510220184
X-Proofpoint-GUID: n8TuiefEYhVuholO9tdoOWtLbeTNDaVZ
X-Proofpoint-ORIG-GUID: n8TuiefEYhVuholO9tdoOWtLbeTNDaVZ
X-Authority-Analysis: v=2.4 cv=WaEBqkhX c=1 sm=1 tr=0 ts=68f954e4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=wIxPImWkt_9mroCB1I4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDEwNSBTYWx0ZWRfX7ckZiRCDflhS
 /W/nhdWAzc/dRMdh+JkAU/6CB4QihydF4DxwCr2+ToDY+KDeRY+IC5HAsEEaDFNe+QGJlMrAssj
 By8lLdyT8IY9q8sfhEv2YfRZyCA9S0JWvK0mEURQ042HJv/riYJfsCEo/liLNpuIkfnxFccOqMU
 9QTPPmSp6yheASiwYWT2SkEhzBh3/Tn9BLeE0H0+MvcJo02oOvWyvz1RzV30y/otI52Urqt6pph
 IuVivN2gB1OSGakUQUmBBTTt/KinZDLay64a8LE+VwHl9+hMX50VQ6A3udfBlaEeBho91tprLYk
 rXXMpGKX5YT2ncBh8bh9MDOT2iifG6D5iYYoI3NGl86F2syXhIse2o0L08U889dJ8rP+3vim9XM
 T6h3O2hjVVH7LcBwp6nZvlt4+lNRJQ==

T29wcywgdGhpcyBzZXJpZXMgc2hvdWxkIGJlICJSRkMgbmV4dC1uZXh0Ii7CoA0KDQpBcG9sb2dp
ZXMgZm9yIHRoZSBjb25mdXNpb24hDQpBbGxpc29uDQoNCk9uIFdlZCwgMjAyNS0xMC0yMiBhdCAx
MjoxNyAtMDcwMCwgQWxsaXNvbiBIZW5kZXJzb24gd3JvdGU6DQo+IEZyb206IEFsbGlzb24gSGVu
ZGVyc29uIDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPg0KPiANCj4gSGkgYWxsLA0KPiAN
Cj4gVGhpcyBzZXQgaXMgYSBjb2xsZWN0aW9uIG9mICBidWctZml4ZXMgd2UndmUgYmVlbiB3b3Jr
aW5nIG9uIGZvciBSRFMuDQo+IA0KPiBUaGlzIHNlcmllcyB3YXMgbGFzdCBzZWVuIGluIEFwcmls
LCBidXQgZnVydGhlciB0ZXN0aW5nIHR1cm5lZCB1cA0KPiBhZGRpdGlvbmFsIGJ1Z3MgdGhhdCB3
ZSB0aG91Z2h0IGJlc3QgdG8gYWRkcmVzcyBhcyBwYXJ0IG9mIHRoZSBzYW1lDQo+IGVmZm9ydC4g
U28gdGhlIHNlcmllcyBoYXMgZ3Jvd24gYSBiaXQsIGFuZCBJ4oCZdmUgcmVzdGFydGVkIHZlcnNp
b25pbmcNCj4gc2luY2UgdGhlIHNldCBzZW50IGxhc3Qgc3ByaW5nLiBNYW55IG9mIHRoZSBBcHJp
bCBwYXRjaGVzIGFyZSByZXRhaW5lZA0KPiBoZXJlIHRob3VnaC4NCj4gDQo+IFRvIHJlZnJlc2g6
IHVuZGVyIHN0cmVzcyB0ZXN0aW5nLCBSRFMgaGFzIHNob3duIGRyb3BwZWQgb3INCj4gb3V0LW9m
LXNlcXVlbmNlIG1lc3NhZ2UgaXNzdWVzLiBUaGVzZSBwYXRjaGVzIGFkZHJlc3MgdGhvc2UgcHJv
YmxlbXMsDQo+IHRvZ2V0aGVyIHdpdGggYSBiaXQgb2Ygd29yayBxdWV1ZSByZWZhY3RvcmluZy4N
Cj4gDQo+IFNpbmNlIHRoZSBBcHJpbCBwb3N0aW5nLCBwYXRjaGVzIDIsIDMsIDYgYW5kIDEw4oCT
MTYgYXJlIG5ldy4gVG8gZWFzZQ0KPiByZXZpZXdpbmcsIEkgd2FzIHRoaW5raW5nIHdlIGNvdWxk
IHNwbGl0IHRoZSBzZXQgaW50byBzbWFsbGVyIGxvZ2ljYWwNCj4gc3Vic2V0cy4gIE1heWJlIHNv
bWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiBXb3JrcXVldWUgc2NhbGFiaWxpdHkgKHN1YnNldCAx
KQ0KPiBuZXQvcmRzOiBBZGQgcGVyIGNwIHdvcmsgcXVldWUNCj4gbmV0L3JkczogR2l2ZSBlYWNo
IGNvbm5lY3Rpb24gaXRzIG93biB3b3JrcXVldWUNCj4gDQo+IEJ1ZyBmaXhlcyAoc3Vic2V0IDIp
DQo+IG5ldC9yZHM6IENoYW5nZSByZXR1cm4gY29kZSBmcm9tIHJkc19zZW5kX3htaXQoKSB3aGVu
IGxvY2sgaXMgdGFrZW4NCj4gbmV0L3JkczogTm8gc2hvcnRjdXQgb3V0IG9mIFJEU19DT05OX0VS
Uk9SDQo+IG5ldC9yZHM6IHJkc190Y3BfYWNjZXB0X29uZSBvdWdodCB0byBub3QgZGlzY2FyZCBt
ZXNzYWdlcw0KPiANCj4gUHJvdG9jb2wvZXh0ZW5zaW9uIGZpeGVzIChzdWJzZXQgMykNCj4gbmV0
L3JkczogbmV3IGV4dGVuc2lvbiBoZWFkZXI6IHJkbWEgYnl0ZXMNCj4gbmV0L3JkczogRW5jb2Rl
IGNwX2luZGV4IGluIFRDUCBzb3VyY2UgcG9ydA0KPiBuZXQvcmRzOiByZHNfdGNwX2Nvbm5fcGF0
aF9zaHV0ZG93biBtdXN0IG5vdCBkaXNjYXJkIG1lc3NhZ2VzDQo+IG5ldC9yZHM6IEtpY2stc3Rh
cnQgVENQIHJlY2VpdmVyIGFmdGVyIGFjY2VwdA0KPiBuZXQvcmRzOiBDbGVhciByZWNvbm5lY3Qg
cGVuZGluZyBiaXQNCj4gbmV0L3JkczogVXNlIHRoZSBmaXJzdCBsYW5lIHVudGlsIFJEU19FWFRI
RFJfTlBBVEhTIGFycml2ZXMNCj4gbmV0L3JkczogVHJpZ2dlciByZHNfc2VuZF9oc19waW5nKCkg
bW9yZSB0aGFuIG9uY2UNCj4gDQo+IFNlbmQgcGF0aCBhbmQgZmFuLW91dCBmaXhlcyAoc3Vic2V0
IDQpDQo+IG5ldC9yZHM6IERlbGVnYXRlIGZhbi1vdXQgdG8gYSBiYWNrZ3JvdW5kIHdvcmtlcg0K
PiBuZXQvcmRzOiBVc2UgcHJvcGVyIHBlZXIgcG9ydCBudW1iZXIgZXZlbiB3aGVuIG5vdCBjb25u
ZWN0ZWQNCj4gbmV0L3JkczogcmRzX3NlbmRtc2cgc2hvdWxkIG5vdCBkaXNjYXJkIHBheWxvYWRf
bGVuDQo+IA0KPiBJZiB0aGlzIGJyZWFrZG93biBzZWVtcyB1c2VmdWwsIHdlIGNhbiBzdGFydCB3
aXRoIGp1c3QgdGhlIGZpcnN0IHNldA0KPiBhbmQgSSdsbCBrZWVwIHdpdGggYSBicmFuY2ggd2l0
aCB0aGUgZnVsbCBzZXQgYXZhaWxhYmxlIGZvciB0aG9zZSB3aG8NCj4gd2FudCB0byBsb29rIGFo
ZWFkLiAgT3RoZXJ3aXNlIEnigJlsbCBrZWVwIHRoZSBmdWxsIHNldCB0b2dldGhlci4gIExldCBt
ZQ0KPiBrbm93IHdoYXQgd291bGQgYmUgbW9zdCBoZWxwZnVsLg0KPiANCj4gUXVlc3Rpb25zLCBj
b21tZW50cywgZmxhbWVzIGFwcHJlY2lhdGVkIQ0KPiBUaGFua3MsDQo+IEFsbGlzb24NCj4gDQo+
IA0KPiBBbGxpc29uIEhlbmRlcnNvbiAoMik6DQo+ICAgbmV0L3JkczogQWRkIHBlciBjcCB3b3Jr
IHF1ZXVlDQo+ICAgbmV0L3JkczogcmRzX3NlbmRtc2cgc2hvdWxkIG5vdCBkaXNjYXJkIHBheWxv
YWRfbGVuDQo+IA0KPiBHZXJkIFJhdXNjaCAoOCk6DQo+ICAgbmV0L3JkczogTm8gc2hvcnRjdXQg
b3V0IG9mIFJEU19DT05OX0VSUk9SDQo+ICAgbmV0L3JkczogcmRzX3RjcF9hY2NlcHRfb25lIG91
Z2h0IHRvIG5vdCBkaXNjYXJkIG1lc3NhZ2VzDQo+ICAgbmV0L3JkczogRW5jb2RlIGNwX2luZGV4
IGluIFRDUCBzb3VyY2UgcG9ydA0KPiAgIG5ldC9yZHM6IHJkc190Y3BfY29ubl9wYXRoX3NodXRk
b3duIG11c3Qgbm90IGRpc2NhcmQgbWVzc2FnZXMNCj4gICBuZXQvcmRzOiBLaWNrLXN0YXJ0IFRD
UCByZWNlaXZlciBhZnRlciBhY2NlcHQNCj4gICBuZXQvcmRzOiBVc2UgdGhlIGZpcnN0IGxhbmUg
dW50aWwgUkRTX0VYVEhEUl9OUEFUSFMgYXJyaXZlcw0KPiAgIG5ldC9yZHM6IFRyaWdnZXIgcmRz
X3NlbmRfcGluZygpIG1vcmUgdGhhbiBvbmNlDQo+ICAgbmV0L3JkczogRGVsZWdhdGUgZmFuLW91
dCB0byBhIGJhY2tncm91bmQgd29ya2VyDQo+IA0KPiBHcmVnIEp1bXBlciAoMSk6DQo+ICAgbmV0
L3JkczogVXNlIHByb3BlciBwZWVyIHBvcnQgbnVtYmVyIGV2ZW4gd2hlbiBub3QgY29ubmVjdGVk
DQo+IA0KPiBIw6Vrb24gQnVnZ2UgKDMpOg0KPiAgIG5ldC9yZHM6IEdpdmUgZWFjaCBjb25uZWN0
aW9uIGl0cyBvd24gd29ya3F1ZXVlDQo+ICAgbmV0L3JkczogQ2hhbmdlIHJldHVybiBjb2RlIGZy
b20gcmRzX3NlbmRfeG1pdCgpIHdoZW4gbG9jayBpcyB0YWtlbg0KPiAgIG5ldC9yZHM6IENsZWFy
IHJlY29ubmVjdCBwZW5kaW5nIGJpdA0KPiANCj4gU2hhbWlyIFJhYmlub3ZpdGNoICgxKToNCj4g
ICBuZXQvcmRzOiBuZXcgZXh0ZW5zaW9uIGhlYWRlcjogcmRtYSBieXRlcw0KPiANCj4gIG5ldC9y
ZHMvY29ubmVjdGlvbi5jICB8ICAyNSArKysrLQ0KPiAgbmV0L3Jkcy9pYi5jICAgICAgICAgIHwg
ICA1ICsNCj4gIG5ldC9yZHMvaWJfcmVjdi5jICAgICB8ICAgMiArLQ0KPiAgbmV0L3Jkcy9pYl9z
ZW5kLmMgICAgIHwgIDIxICsrKy0NCj4gIG5ldC9yZHMvbWVzc2FnZS5jICAgICB8ICA2NiArKysr
KysrKystLS0NCj4gIG5ldC9yZHMvcmRzLmggICAgICAgICB8ICA5NyArKysrKysrKysrKy0tLS0t
LQ0KPiAgbmV0L3Jkcy9yZWN2LmMgICAgICAgIHwgIDM5ICsrKysrKy0NCj4gIG5ldC9yZHMvc2Vu
ZC5jICAgICAgICB8IDEzNiArKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gIG5ldC9yZHMvc3Rh
dHMuYyAgICAgICB8ICAgMSArDQo+ICBuZXQvcmRzL3RjcC5jICAgICAgICAgfCAgMzEgKysrLS0t
DQo+ICBuZXQvcmRzL3RjcC5oICAgICAgICAgfCAgMzQgKysrKy0tDQo+ICBuZXQvcmRzL3RjcF9j
b25uZWN0LmMgfCAgNzAgKysrKysrKysrKystDQo+ICBuZXQvcmRzL3RjcF9saXN0ZW4uYyAgfCAy
NDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ICBuZXQvcmRz
L3RjcF9yZWN2LmMgICAgfCAgIDYgKy0NCj4gIG5ldC9yZHMvdGNwX3NlbmQuYyAgICB8ICAgNCAr
LQ0KPiAgbmV0L3Jkcy90aHJlYWRzLmMgICAgIHwgIDE3ICstLQ0KPiAgMTYgZmlsZXMgY2hhbmdl
ZCwgNjE4IGluc2VydGlvbnMoKyksIDE3NiBkZWxldGlvbnMoLSkNCj4gDQoNCg==

