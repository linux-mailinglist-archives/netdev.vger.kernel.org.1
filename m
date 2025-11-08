Return-Path: <netdev+bounces-236923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20995C423C0
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 02:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BAE3B1925
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 01:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F528467C;
	Sat,  8 Nov 2025 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EknPpAGK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jNoVKkYk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB13283C83
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 01:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762565099; cv=fail; b=TXYnEnGzFafsbZ7Zg464BpgjPgUxXKt9VixNooNS8nXOZ18hAPJ6AWPtjqeKK/xeMS9XTlmr0gekYZtdrnyTU6/9Gceff3xjEqYQrKefxIju/fhqoQbgFaWB5sWZLHsRcOryCgcVcH4D2SGA7hfj9/1RaMnwqoALxa03e4//jyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762565099; c=relaxed/simple;
	bh=3gJWmWaiB0ry0Qd9VmeznEM4HAlpRJQeDJgplb88HIc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZdIdXPvJFMuff00TWZ9rwPFqC0mHsweG+i8o4KUQzhOpSau0hjo1dLePspaQhGNZIwgG4elXti+UNQajoyMIMIC0TBCO1TsRT/WsGPvK1cSEtg6pWWF2GT6qgRlASnIbZOiN2QoYa4XIW8LTCIPo6PRPIqqK78Poy8G8vqotnx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EknPpAGK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jNoVKkYk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A811vYC003943;
	Sat, 8 Nov 2025 01:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3gJWmWaiB0ry0Qd9VmeznEM4HAlpRJQeDJgplb88HIc=; b=
	EknPpAGKqv/1q9SvdGQ810Ihzm33UqGCW3SlCRuSneiLgtiXeVyZboWKRd5PAXqR
	AUVylbvj9M2z75kdq9mEdwBxztGf+RRFkipKP0fxFjrFAqGtzXHnVYE16WlOX/Cq
	HaD7p+ezGLeQP4eCJGH+oL+ZdVXEibvgC1t7mrj3VpHAp7aOfw4SSerOeeTZQTKL
	yRwTNb6rJfdTvDEDFIZ9PHOw0V8BuEnzNBza/4yh/jrAiU1r5Nybzk8DwvIc/Fdx
	AUzbj6WhuCR6oWAlzZNNAsrG5JV+xbsqpG5Vdx63IA2R8+ikbY5TaZwFLo8Mu4At
	kTVuxiU8gsT6l+OD6n9blA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9s8687fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 01:24:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7N2X1G015095;
	Sat, 8 Nov 2025 01:24:52 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ne87p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 01:24:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTkrC9ns15OCEfgRJ+BSMz7CF/wr6uC82N2VsZz0B8fuPa6YTPonIk6zavH61QI57c4zMP75qCLL4DuaJRT9NMv0vpV4+6HKqLjiPj8U0jL1qztPwmdyDuIWj0OCpcBf+wJlFXP1y0wb67DupoJ0IhOPg6XMtmBoQvNoQm405W9qG0q4Nm3uGy57riadfn+iXhFvBj+JXfpjcA5ktbiVJNLUjiOrwDoWhVkSep1Tke1OC/Mb8cgAZi0iM5YXueteZ/qvHP+ovMUHUIIRdAZAoVIQLHY0+ZizhMMjegrM/7csIaqY5UlTVk6rK9oGx5e5WvJVDCp2mnstesHU06E+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gJWmWaiB0ry0Qd9VmeznEM4HAlpRJQeDJgplb88HIc=;
 b=T0/bOVSzzzx/Dn8hltLrvp1lQLRUc9dp0MnfUtjpquQz4fq/6lVWEelkVQnon8CDkB/pnYsuqurZHxYJFInkQxYmJJHE0t24s9ew+CYH7HP9kozWleFj/2Pd1L+1x+PL+SiNY5Dwb6F0vvXUAgNXLqSyPgPH2WkcfcNWllmBhqgqQc102JR30jlinbLGOTxfa4swQCcebNtVaBOtgt1yDqydmXVbJc69952eq3U7X37RxwMyfeoyGO9Qzd/BG+3UJODwTC9+E5gFuWb+QfKxVn+0rigQvwz7WOIDaWSjXB8LrZNa8t6uC2bg3DoQXDR3PbocdBILvhxYeHlZA35jkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gJWmWaiB0ry0Qd9VmeznEM4HAlpRJQeDJgplb88HIc=;
 b=jNoVKkYkhHG4kJv+MsZ9+PGgrXMxtu81lwi+9kTbazXHHnvzzjxRZ1JUoOwq5L84Lb+weDTmkqb62QUK1iLrXplYRacoI2+IVH4aT4536Sah80stQUKSSBVsohmwG6un36rDWV5RtdOiKOouPPzl815pwlRHRI/mCCko4b7mXMg=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 CH3PR10MB7212.namprd10.prod.outlook.com (2603:10b6:610:120::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Sat, 8 Nov
 2025 01:24:46 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%4]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 01:24:46 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "achender@kernel.org" <achender@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 2/2] net/rds: Give each connection its own
 workqueue
Thread-Topic: [PATCH net-next v1 2/2] net/rds: Give each connection its own
 workqueue
Thread-Index: AQHcSPvuwmtUpoPbYkKh0q6G3DbkeLTipLGAgABr7ICAAnQwgIAChimA
Date: Sat, 8 Nov 2025 01:24:45 +0000
Message-ID: <d2b270014a2c6343ffc50fd18700fa53040b5203.camel@oracle.com>
References: <20251029174609.33778-1-achender@kernel.org>
	 <20251029174609.33778-3-achender@kernel.org>
	 <0bee7457-eddc-493f-bdb9-a438347958f9@redhat.com>
	 <68454b958581aa1d085678b3b6926318ee5754dc.camel@oracle.com>
	 <4133dc32-d639-40a9-b49a-d893caae1821@redhat.com>
In-Reply-To: <4133dc32-d639-40a9-b49a-d893caae1821@redhat.com>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|CH3PR10MB7212:EE_
x-ms-office365-filtering-correlation-id: 4761e235-cd12-4b13-7ddb-08de1e659a79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VTMyVFg5U3ZkcnJJYW5BV0R0WDBITTE4cjI4TUVRSzdLS05zRHN0Mis0WjVG?=
 =?utf-8?B?ZmgxWTlrTktnYXFPSG44ZTg5VUszejdqRmJhaUZVeTEzSDFtM3ZIc0p3NWYx?=
 =?utf-8?B?aFo1QmF2NDRpQVJGWkhEczlBaitUcVpTMHlDbnpNaWo3MHJaTjM2TlVQNHR2?=
 =?utf-8?B?UGhlRW5qNllEZGpscllmNlF6WFp1Y3orKzQ3bzJuQnNtSWVSNXBvSnM0U0lj?=
 =?utf-8?B?WWt6YzVDMmlGYnN2TkJQK1plNWtYOWNQTVdTTkYwNDJqcVIySmd0S1VWc2Z4?=
 =?utf-8?B?ZU1mNkpWK25Xb1Nkejd6SkFDKzlLM2hES0krUlA3ai9zcHkzZ1VTT0RqM3N3?=
 =?utf-8?B?WWZyc29ESU93ZHdEaStrNkV6R0RCd2NpMldTSjNzNU1HTnBPSjNuL1Bxckpn?=
 =?utf-8?B?SkRIU2UxZXQ4dm85NDV3WGF0akVkMGFqQ1NtYUF3RlhUbGpiRWdvV2JaL2VQ?=
 =?utf-8?B?NlY4RG02c05aajN5bXd5ZHNNNjR5VkZGV3dvUjJnMThGYzM0bTdlRFlEZzRZ?=
 =?utf-8?B?M3grZ0Z4d1hReGQ3RzNMT3YvaE1WSXIzUWJSSjRCd2M5VXZnZ2NGRTZYMVFU?=
 =?utf-8?B?UG8zaGQ4K2gzaUVaSmw1VklKemswZkowdjhIcnd5UmpNM2x6M0JFODUyTXBV?=
 =?utf-8?B?NTc4dlRZOGFoT1l1MlFuK0FFYThCQ09BbUgvcDlPOUVKYzRHQTNOVW84NGVy?=
 =?utf-8?B?VVllT2lQdW9TWlNaWmt2d3hwenZJekwrQXdCQ1lKL3ZpTm9tamdsQlMrOGhk?=
 =?utf-8?B?dzZ1bEJUcXgzb3d0MWc4dGZRa1o3OVRKZlM4bUw3cjFmQ3dXbmVTZEQzeitz?=
 =?utf-8?B?ejdzdFltbHhTQ2p3UmdReGNhQVhPMjdULzJDbDIxcFJER1lHdjhCMnNqcFdI?=
 =?utf-8?B?MW90VjVnVzY0N0lvV0RIM2JKcHNTMnYwOGdVaUcvell4TUZYblZHSTlVU2R3?=
 =?utf-8?B?UG1hcGJSQ21aekxNOXVNWWFhckloTDlSd3kwbmtCK2FmUkhVUnhEWDY3QUhQ?=
 =?utf-8?B?SDJZT3VqMFRGdEgyNjFDRStZQkxhZ2t6L3poT1U2bzRTcjNQMkoxOUtBdUt6?=
 =?utf-8?B?MTR3aUJDNmR2d2RRa0pzK01uZG9XaE5Cd2tiNUJqQzVVaTRxWUsrUTd0WW02?=
 =?utf-8?B?VzdEbW8yUFNSYWtmT2UzMURreXRpM3d2ZEMzclpieXBPNzR2Tno2OE5Ed0Y3?=
 =?utf-8?B?NmRISEhmK2c0SnNDS3ZVZldHNFhCZFRPaG04NFprODA5bDJTV3VkTFpTVUZZ?=
 =?utf-8?B?UTdYQ2h5bHQ1MXZiald0a0RlUXRXQXc3OUg0ZVMrZzRkSGRsWUlCclNUU2s5?=
 =?utf-8?B?N1k3UURmWnNqcHp5NGlmdXRVWk9tRmduLzdtblRrSTQyTGpwL1dqQUlTUExz?=
 =?utf-8?B?RFRheEM1YTFubjhKWTZXWFRseUVaVWgyaWNkdVRkcWRNU2Y4aFlOWTJNTFBm?=
 =?utf-8?B?d0tXOUxCa1pjeEV1dlBESnhGS0Mrdk5qMEtFckhwb3B2OXBPaG03ODd4bEhw?=
 =?utf-8?B?Zys1cG8xdkxyMFhDK3E2Yll3SkExRlNlaU45RkFvdUx1QUdqTUdLaVBoYWl4?=
 =?utf-8?B?WFJpRHpGc2s0blc2V3hRTmJjZkx0WGNpOW9kOElqZXE0K3ZqaFhETGp6YXVm?=
 =?utf-8?B?K2hlUitBSG9jTTFZTk9NWUxLU283aC9ESERhWE0yd2h2ODJ3RFNWZC84dnFy?=
 =?utf-8?B?WXlxWnBhaUFjYnhWZUNia3Rhc1I0SmJ3czJDTUY5bXd3UmlhM1RIZk1KeThR?=
 =?utf-8?B?d3lkaGdxTHVYa2tEZXkyeEdHa1VhbWZVQWNnWTBDZC8wL3ozYkhRWUJ5WE42?=
 =?utf-8?B?OVl0SXRoR0oxY0luV2h3MUozM1VqUWRTcTAxem9wNzZtcXpDUzZkcTFmdVpG?=
 =?utf-8?B?SVlrOHlzS2Q3eHU2QmNYVUhmQ1NaUXJncCszaDJ2aGRETFN5NmYxc1htcnYw?=
 =?utf-8?B?bkdud3ZBRDYzbGxoRnBVQWJ1NEJ1WHk3ZFhDVFk3Rm1wcU8wUVVXWFg4Y3pl?=
 =?utf-8?B?RThjRExkQ2NnMzJ2RWJtUFQzaHcxa09oampVUnRsbkFaR1ozemFqSmJCZlp5?=
 =?utf-8?Q?UQRHXF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXZ6WmFPaUw3T2xCZWJneXVjT0dUblFGa2pWWnBrWFk2d1JYRzArZ2h6MU1y?=
 =?utf-8?B?bU11QVhjcXlWdlRWaEIvSkw4MjdnbVJVL0NkUlRjbFZ1VW5SNXNiUmk4bnVE?=
 =?utf-8?B?M3VMeUgwWnhRY1JDRjdZd2IzcDRPVmdVak85ZHNVVzMwWnZiVEo4VGU1cVRa?=
 =?utf-8?B?TlRCL0N0eWdDaFFWUDJSL3hNMkJKczdJYi9Jb0lvVDBlOWM1SjBLOWZLNkFB?=
 =?utf-8?B?QzNVN3VzdG4yeUpQSVFVWHVyalQ3Z1d0MlozWWsvWmNzZGVuTml4L0pUclJ0?=
 =?utf-8?B?NSsvNmdoa3E4eTZsdENyczlTbm13M3RvSDlybHJMNFVTbjI0ZFJmUkdycWdy?=
 =?utf-8?B?NzdQRUVmdFZyUUZjNngyTGVqSWtrTG5HQ0dGY0dNVWJWa3paeGtlOXlLcFFG?=
 =?utf-8?B?aHdjNC9idWVPRUN1Ym5zNW92akNZaVpyaWxoUXkyM0JFd0hJb3JtV0hVNktN?=
 =?utf-8?B?S1JnL0RKR0pPWmxJa3JXb09HMTVLaDNoZEY5QzRReGgwUTR5OEE1WGhnQnNz?=
 =?utf-8?B?S1gvZkpQaStHR0JDbmZRdjV0dG5vZ2ZDUlNBQ2NPaFJFUERmYmI3ZTBCN3Ry?=
 =?utf-8?B?RHNjdHVZcVFmNXoxcmExUzE3bEJXelkwNzBjNW04Z0wrMEJRV2d3bjlLRWt3?=
 =?utf-8?B?a0I1SVVmdVo3b0VFcmNBYUVaeU5MU2I1VXRxdk1zOTIxMTYrRzh4cGwyUWhC?=
 =?utf-8?B?Sy9Zd0c3U1ZFWkdENFdMekdQWENlbWFSNlpDejR6MG9XSG05V3F1VVh2ZGtQ?=
 =?utf-8?B?WkgrcW5ROXhkQUsvOThSMFdrcFR4ZkxwK01waVEvZTN1S2F0bXBDUC9NbXFs?=
 =?utf-8?B?akFRdnRVSmtPV0hsZGk3ZWtwWGJqK05qcUIvSWVGT3pJSTMrUlZHMW4rY295?=
 =?utf-8?B?a0x3OFplVTdKRWR1RGlTdEZnMmoyWFdFV3lOckZBdzBWaVVrR0tqMDNMNU1M?=
 =?utf-8?B?ZWpzT2l3VWtiTkJ2U2FWdmJsdUQwYXYrcVQvc1A2TVBnTXVKV0l4Q0lZNmhJ?=
 =?utf-8?B?Snd2Y3JLdXVra3paZEhFSjBjTUF5VnN1RnZzSzJQeUc2NTZMa2dSeVpEZGVv?=
 =?utf-8?B?M1BSWFlaUlZjMEdIS0tkaStOeW1lQXR4YXY2dkQ3L2pSZkdjNjRHSWI3TUJG?=
 =?utf-8?B?WkRlWFV6cTRudmNnYzdySVI0a2ZRWXpXS3k0ZnJlUVdVek01Q2x1K3V3MlZS?=
 =?utf-8?B?U1o0bytsV01QbVJQRzYrclZwcjJ0dU82aC9GaklDanE4aiswVng3OEFZa1dE?=
 =?utf-8?B?eDhtTVMwRDcrcWdncDc3QXA4N2R2bG95NUsyK3RnNzZUTnI4cWc2WmJJTXk1?=
 =?utf-8?B?bklaY1NRemwwMU9EMEQzeFdjT0d5b2xwck1BN2Zhb3ZhaEFJRHVubm80ZTZI?=
 =?utf-8?B?aGNFT2pXU3B0R2d0eU0rYWFQVXlycHhzWEtQLzVMaTZqS01VcTBOUlZYekpZ?=
 =?utf-8?B?M0NKZ1FZU2o2MlZsZVNSWDZDOUFDTm5rU25aMmNIaUdWQmNGUmZkcTlhV3Z3?=
 =?utf-8?B?VUxndUhjQUxVUE5OWjU0bmMzdlprcUdoSnhjV3BqQVp4eVVUbGt1R2Juc0Vv?=
 =?utf-8?B?K3U0bE44aEJuckVmN0hjNzR6REMrSWtCVUQ5cDlHZFY5VnJncGFFRVU3MmU3?=
 =?utf-8?B?eENhWktzVkxEdGNWNlVRZWxFNk1rZmZPeDdLak1BZHg3eU5weHN3MU5NSVFF?=
 =?utf-8?B?OUs0bEZNZUlTcmJLN0E0LzBOTVZBKzcvWjdSOTVuTThWRnpsSldObnJnVkJ0?=
 =?utf-8?B?aGFZNklvcWEwdEVEOGh1UVBMc3lqdXEyanF1b0t5Wks2MU1wMWd1SVpIRXFn?=
 =?utf-8?B?eUdxNEtuQmp2Uy85NjBSWlVYK2ZDMFNnQjZKMWV0ZVc4TGRHcGN2WUQ2N0Z2?=
 =?utf-8?B?RllMdE11S2t1bk9NVXJuV25lYU5ZeS9wV0tZVzdkWm8vKzNFMHgwZGh6YWJ5?=
 =?utf-8?B?TUhQZ0ZzOS9NRi9ETGliNldvbVNjbWoyNzd5ZVBxZTQ3clYxWUQ4Q1IycFpQ?=
 =?utf-8?B?UmM4MW9ZSVpCeWF0YjdlT0dpdmx0MHZiZ3pMR01RNjZyZGpaOTY0NkJYODMx?=
 =?utf-8?B?Mm5BTFhyOGNxd244N21kejAxb1lIQzQwR3RYcGZ1WkREb2FCL1JFNlA4ZXRD?=
 =?utf-8?B?VUZaSmJ2cnFraUdMdmZXM1NRTCsxWnozNEVxNUF0dHRjR0NXVEQ1WFhEUFdy?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB00257D87035F44800123545F48D265@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	noNsIh+F2inlt+qj1f0Ds3ksqVNcrP3v6W4z+XJB4bVOp66JmL/Cnw0p9bLBL5jfWFgfrC0180VoWVitjcyqs8QKT3OL4ShbJmvjgA/9CqZdKjHkC7/AP8v12XEJySNoxJOcWayhQDgL7HX6853eHx/6jhkgdzrH1XVpS8/+t2wHwZps2MwbbW4CUj7s1CK4scUNJSk+Ku/zb/eRkoxUeOkBahELEF1MfEWTM0oc8x1pJpImLlTWzhCfwTezUxdkmjH/+LZgTw5j3Y0RILgA8yXFT08k6g/envVnQmX5YuSa29zfkmBaWZaw2jerSOyJ7LGXYQtCwieVb1NSkMQ2noBF19CALcZrvELleCf9nXxvzdbO+7Ant4lNm7Iunugd4/oSR6AXWS2UD7qdJm0eTTZAaXOBPk35S/nWAIC/wksAYHoRYMDLgBI+QsSN1W5oCq3UvzE4zmzfVbBeTz5x9UVByVVaiSJmK6yVsWxQyTvJmlFAmN42tiI6lCNjQVCt1bIklus44wfn4BJM1I+ow4Z0qBjVoF3IuXEMxhkBDWmr6PtGK1UQzVVf9pedR/ioIcbYw7oEs/JwWLHNK5EYcsEHBt/JUvkbCoR6HROE6Zg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4761e235-cd12-4b13-7ddb-08de1e659a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2025 01:24:46.4891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CpzA0vv8luuuwif5kkOHE0LX6TLXLw81T1s9Nwzce+9EpxxNDUZRYIPqGV2BftDYvlu2sDCw9glqnatt/mdrsf9MkbSreF6JVQec9Uigq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080010
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDE4MyBTYWx0ZWRfX8TMeRDNOL/uv
 1pmPX8Qbob2EvXbG//+6DvBASUUAMcn/ebhpI4uhoer0lN2j5OJNKbxMUUuGq7spDFe+GxT1NqC
 njVeCA83RFKVHmnzGU+MsUpKYej2DL7bYckm4GMjlyO71MQvNV7WcTiR1C4xO/BYsRsGnp0xc3v
 WRK451MJ8YYMSgUtLAw6M2DGkGIjFytE8NAZUu5s1AJ2Ai+n6x9m0QIpZ7+6GuBf3Z9GKEUIGkg
 gU1/rGgs+nUevo9jKdNyDn0oSRNztLX3htAxR03GNNkqFT/ofr3fvayZlz4fuRpQUSGW4xsgnBT
 3Gt4gvDDg/KrboZqAmm57zTu96meyIKCm13lAaAjlzcNqhNrGB2px1zqaCuLxDknVhc3SrJC/3P
 tkYof2rrfbMG9OaOM0k94BUtxr7jXg==
X-Proofpoint-ORIG-GUID: qc8d070T10jSoh-JxXa8aUwaaE9qA--Z
X-Proofpoint-GUID: qc8d070T10jSoh-JxXa8aUwaaE9qA--Z
X-Authority-Analysis: v=2.4 cv=SdT6t/Ru c=1 sm=1 tr=0 ts=690e9be4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=rrlhXhF5VNpDSH-f3IkA:9
 a=QEXdDO2ut3YA:10

T24gVGh1LCAyMDI1LTExLTA2IGF0IDExOjUyICswMTAwLCBQYW9sbyBBYmVuaSB3cm90ZToNCj4g
T24gMTEvNC8yNSAxMDoyMyBQTSwgQWxsaXNvbiBIZW5kZXJzb24gd3JvdGU6DQo+ID4gT24gVHVl
LCAyMDI1LTExLTA0IGF0IDE1OjU3ICswMTAwLCBQYW9sbyBBYmVuaSB3cm90ZToNCj4gPiA+IE9u
IDEwLzI5LzI1IDY6NDYgUE0sIEFsbGlzb24gSGVuZGVyc29uIHdyb3RlOg0KPiA+ID4gPiBGcm9t
OiBBbGxpc29uIEhlbmRlcnNvbiA8YWxsaXNvbi5oZW5kZXJzb25Ab3JhY2xlLmNvbT4NCj4gPiA+
ID4gDQo+ID4gPiA+IFJEUyB3YXMgd3JpdHRlbiB0byByZXF1aXJlIG9yZGVyZWQgd29ya3F1ZXVl
cyBmb3IgImNwLT5jcF93cSI6DQo+ID4gPiA+IFdvcmsgaXMgZXhlY3V0ZWQgaW4gdGhlIG9yZGVy
IHNjaGVkdWxlZCwgb25lIGl0ZW0gYXQgYSB0aW1lLg0KPiA+ID4gPiANCj4gPiA+ID4gSWYgdGhl
c2Ugd29ya3F1ZXVlcyBhcmUgc2hhcmVkIGFjcm9zcyBjb25uZWN0aW9ucywNCj4gPiA+ID4gdGhl
biB3b3JrIGV4ZWN1dGVkIG9uIGJlaGFsZiBvZiBvbmUgY29ubmVjdGlvbiBibG9ja3Mgd29yaw0K
PiA+ID4gPiBzY2hlZHVsZWQgZm9yIGEgZGlmZmVyZW50IGFuZCB1bnJlbGF0ZWQgY29ubmVjdGlv
bi4NCj4gPiA+ID4gDQo+ID4gPiA+IEx1Y2tpbHkgd2UgZG9uJ3QgbmVlZCB0byBzaGFyZSB0aGVz
ZSB3b3JrcXVldWVzLg0KPiA+ID4gPiBXaGlsZSBpdCBvYnZpb3VzbHkgbWFrZXMgc2Vuc2UgdG8g
bGltaXQgdGhlIG51bWJlciBvZg0KPiA+ID4gPiB3b3JrZXJzIChwcm9jZXNzZXMpIHRoYXQgb3Vn
aHQgdG8gYmUgYWxsb2NhdGVkIG9uIGEgc3lzdGVtLA0KPiA+ID4gPiBhIHdvcmtxdWV1ZSB0aGF0
IGRvZXNuJ3QgaGF2ZSBhIHJlc2N1ZSB3b3JrZXIgYXR0YWNoZWQsDQo+ID4gPiA+IGhhcyBhIHRp
bnkgZm9vdHByaW50IGNvbXBhcmVkIHRvIHRoZSBjb25uZWN0aW9uIGFzIGEgd2hvbGU6DQo+ID4g
PiA+IEEgd29ya3F1ZXVlIGNvc3RzIH44MDAgYnl0ZXMsIHdoaWxlIGFuIFJEUy9JQiBjb25uZWN0
aW9uDQo+ID4gPiA+IHRvdGFscyB+NSBNQnl0ZXMuDQo+ID4gPiANCj4gPiA+IFN0aWxsIGEgd29y
a3F1ZXVlIHBlciBjb25uZWN0aW9uIGZlZWxzIG92ZXJraWxsLiBIYXZlIHlvdSBjb25zaWRlcmVk
DQo+ID4gPiBtb3ZpbmcgdG8gV1FfUEVSQ1BVIGZvciByZHNfd3E/IFdoeSBkb2VzIG5vdCBmaXQ/
DQo+ID4gPiANCj4gPiA+IFRoYW5rcywNCj4gPiA+IA0KPiA+ID4gUGFvbG8NCj4gPiA+IA0KPiA+
IEhpIFBhb2xvDQo+ID4gDQo+ID4gSSBoYWRudCB0aG91Z2h0IG9mIFdRX1BFUkNQVSBiZWZvcmUs
IHNvIEkgZGlkIHNvbWUgZGlnZ2luZyBvbiBpdC4gIEluIG91ciBjYXNlIHRob3VnaCwgd2UgbmVl
ZCBGSUZPIGJlaGF2aW9yIHBlci0NCj4gPiBjb25uZWN0aW9uLCBzbyBpZiB3ZSBzd2l0Y2hlZCB0
byBxdWV1ZXMgcGVyIGNwdSwgd2UnZCBoYXZlIHRvIHBpbiBhIENQVSB0byBhIGNvbm5lY3Rpb24g
dG8gZ2V0IHRoZSByaWdodCBiZWhhdmlvci4gIEFuZA0KPiA+IHRoZW4gdGhhdCBicmluZ3MgYmFj
ayBoZWFkIG9mIHRoZSBsaW5lIGJsb2NraW5nIHNpbmNlIG5vdyBhbGwgdGhlIGl0ZW1zIG9uIHRo
YXQgcXVldWUgaGF2ZSB0byBzaGFyZSB0aGF0IENQVSBldmVuIGlmIHRoZQ0KPiA+IG90aGVyIENQ
VXMgYXJlIGlkbGUuICBTbyBpdCB3b3VsZG4ndCBxdWl0ZSBiZSBhIHN5bm9ueW1vdXMgc29sdXRp
b24gZm9yIHdoYXQgd2UncmUgdHJ5aW5nIHRvIGRvIGluIHRoaXMgY2FzZS4gIEkgaG9wZQ0KPiA+
IHRoYXQgbWFkZSBzZW5zZT8gIExldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rLg0KPiANCj4gU3Rp
bGwgdGhlIHdvcmtxdWV1ZSBwZXIgY29ubmVjdGlvbiBnaXZlcyBzaWduaWZpY2FudCBtb3JlIG92
ZXJoZWFkIHRoYW4NCj4geW91ciBlc3RpbWF0ZSBhYm92ZS4gSSBndWVzcyB+ODAwIGJ5dGVzIGlz
IHNpemVvZihzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCk/DQo+IA0KPiBQbGVhc2Ugbm90ZSB0aGF0
IHN1Y2ggc3RydWN0IGNvbnRhaW5zIHNldmVyYWwgZHluYW1pY2FsbHkgYWxsb2NhdGVkDQo+IHBv
aW50ZXJzLCBhbW9uZyB0aGVtIHBlcl9jcHUgb25lczogdGhlIG92ZXJhbGwgYW1vdW50IG9mIG1l
bW9yeSB1c2VkIGlzDQo+IHNpZ25pZmljYW50bHkgZ3JlYXRlciB0aGFuIHlvdXIgZXN0aW1hdGUu
IFlvdSBzaG91bGQgcHJvdmlkZSBhIG1vcmUNCj4gYWNjdXJhdGUgb25lLg0KPiANCg0KU3VyZSwg
SSd2ZSBkb25lIHNvbWUgZGlnZ2luZyBhcm91bmQgd2l0aCB0aGUgd29ya3F1ZXVlcyBhbmQgYWxs
b2NhdGlvbiBjb2RlIGZvciB1czoNCg0KU28gZmlyc3QsIGhlcmUncyB0aGUgc2l6ZSBvZiB3b3Jr
cXVldWVfc3RydWN0IChhYm91dCAzMjAgYnl0ZXMpOg0KYWNoZW5kZXJAd29ya2JveDp+L21udC9u
ZXQtbmV4dF9jb3ZlcmFnZSQgcGFob2xlIC1DIHdvcmtxdWV1ZV9zdHJ1Y3Qgdm1saW51eCB8IGdy
ZXAgc2l6ZQ0KCS8qIHNpemU6IDMyMCwgY2FjaGVsaW5lczogNSwgbWVtYmVyczogMjQgKi8NCg0K
VGhlbiB0aGF0IHBsdXMgb3RoZXIgbWVtYmVycyB0aGF0IGdldCBhbGxvY2F0ZWQ6DQphY2hlbmRl
ckB3b3JrYm94On4vbW50L25ldC1uZXh0X2NvdmVyYWdlJCBwYWhvbGUgLUMgcG9vbF93b3JrcXVl
dWUgIHZtbGludXggfCBncmVwIHNpemUNCgkvKiBzaXplOiA1MTIsIGNhY2hlbGluZXM6IDgsIG1l
bWJlcnM6IDE1ICovDQoNCmFjaGVuZGVyQHdvcmtib3g6fi9tbnQvbmV0LW5leHRfY292ZXJhZ2Uk
IHBhaG9sZSAtQyB3b3JrcXVldWVfYXR0cnMgfCBncmVwIHNpemUNCgkvKiBzaXplOiAyNCwgY2Fj
aGVsaW5lczogMSwgbWVtYmVyczogMyAqLw0KCQ0KYWNoZW5kZXJAd29ya2JveDp+L21udC9uZXQt
bmV4dF9jb3ZlcmFnZSQgcGFob2xlIC1DIHdxX25vZGVfbnJfYWN0aXZlIHZtbGludXggIHwgZ3Jl
cCBzaXplDQoJLyogc2l6ZTogMzIsIGNhY2hlbGluZXM6IDEsIG1lbWJlcnM6IDQgKi8NCg0KQWxz
byBhdCBsZWFzdCBvbmUgOCBieXRlIHBvaW50ZXIgaW4gdGhlIG5vZGVfbnJfYWN0aXZlIGZsZXgg
YXJyYXkgYXQgdGhlIGJvdHRvbSBvZiB0aGUgd29ya3F1ZXVlX3N0cnVjdC4NCg0KU28gdGhhdCBi
cmluZ3MgdXMgdXAgdG8gODk2IGJ5dGVzIGZvciBhIHNpbmdsZSBub2RlIHg4Nl82NCBzeXN0ZW0u
ICBUaGUgbm9kZV9ucl9hY3RpdmUgZmxleCBhcnJheSBpcyBhcyBsYXJnZSBhcyB0aGUNCm51bWJl
ciBvZiBub2Rlcy4gIFNvIGluIGEgbXVsdGkgbm9kZSBlbnZpcm9ubWVudCB0aGF0IG9uZSB3aWxs
IGluY3JlYXNlIGJ5IGEgZmFjdG9yIG9mICgzMis4KSpOIG5vZGVzLiAgU28gdGhlIDgwMCBieXRl
DQpoYW5kIHdhdmUgaXMgYSBsaXR0bGUgbG93LiAgSWYgeW91IGFncmVlIHdpdGggdGhlIGFib3Zl
IGFjY291bnRpbmcgd2UgY2FuIGluY2x1ZGUgdGhlIGJyZWFrIGRvd24gaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlLA0Kb3IganVzdCBidW1wIHVwIHRoZSBiYWxscGFyayBmaWd1cmUgaWYgdGhhdCdzIHRv
byB3b3JkeS4NCg0KPiBNdWNoIG1vcmUgaW1wb3J0YW50bHksIHVzaW5nIGEgd29ya3F1ZXVlIHBl
ciBjb25uZWN0aW9uIHByb3ZpZGVzDQo+IHNjYWxpYmlsaXR5IGdhaW4gb25seSBpbiB0aGUgbWVh
c3VyZSB0aGF0IGVhY2ggd29ya3F1ZXVlIHVzZXMgYQ0KPiBkaWZmZXJlbnQgcG9vbCBhbmQgdGh1
cyBjcmVhdGVzIGFkZGl0aW9uYWwga3RocmVhZChzKS4gSSdtIGhhdmVuJ3QgZGl2ZWQNCj4gaW50
byB0aGUgd29ya3F1ZXVlIGltcGxlbWVudGF0aW9uIGJ1dCBJIHRoaW5rIHRoaXMgaXMgbm90IHRo
ZSBjYXNlLiBNeQ0KPiBjdXJyZW50IGd1ZXN0aW1hdGUgaXMgdGhhdCB5b3UgbWVhc3VyZSBzb21l
IGdhaW4gYmVjYXVzZSB0aGUgcGVyDQo+IGNvbm5lY3Rpb24gV0sgYWN0dWFsbHkgY3JlYXRlcyAo
b3IganVzdCB1c2UpIGEgc2luZ2xlIHBvb2wgZGlmZmVyZW50DQo+IGZyb20gcmRzX3dxJ3Mgb25l
Lg0KPiANCj4gUGxlYXNlIGRvdWJsZSBjaGVjayB0aGUgYWJvdmUuDQoNClN1cmUsIHNvIEkgZG9u
dCB0aGluayB0aGV5IGdldCB0aGVpciBvd24gcG9vbCwgYnV0IHRoZXkgYXJlIGFsbG9jYXRlZCBw
YXJ0IG9mIGEgc2hhcmVkIGEgcGFydCBvZiBhIHBvb2wuICBJbg0KX19yZHNfY29ubl9jcmVhdGUs
IHdlIGhhdmUgdGhpcyBjYWxsIHN0YWNrIHdoZXJlIHRoZSBwb29sX3dvcmtxdWV1ZSBnZXRzIGxp
bmtlZCB0byB0aGUgcXVldWU6IA0KX19yZHNfY29ubl9jcmVhdGUgLT4gX19hbGxvY193b3JrcXVl
dWUgLT4gYWxsb2NfYW5kX2xpbmtfcHdxcyAtPiBrbWVtX2NhY2hlX2FsbG9jX25vZGUNCg0KVGhl
eSBkbyBob3dldmVyLCBnZXQgdGhlaXIgb3duIGt3b3JrZXIuICBJZiB3ZSBsb29rIGF0IGFsbG9j
X29yZGVyZWRfd29ya3F1ZXVlIGluIHdvcmtxdWV1ZS5oLCB3ZSBnZXQgdGhpczoNCg0KI2RlZmlu
ZSBhbGxvY19vcmRlcmVkX3dvcmtxdWV1ZShmbXQsIGZsYWdzLCBhcmdzLi4uKSAgICAgICAgICAg
ICAgICAgICAgXA0KICAgICAgICBhbGxvY193b3JrcXVldWUoZm10LCBXUV9VTkJPVU5EIHwgX19X
UV9PUkRFUkVEIHwgKGZsYWdzKSwgMSwgIyNhcmdzKQ0KDQpTbywgdGhlIHF1ZXVlcyBhcmUgdW5i
b3VuZCBhbmQgb3JkZXJlZCwgYW5kIHRoZSAxIGlzIG1heF9hY3RpdmUgd29ya2Vycy4gIFNvLCB0
aGV5IGFyZSBhbGxvd2VkIHRvIHNwYXduIGF0IG1vc3Qgb25lDQprd29ya2VyIGZvciB0aGF0IHF1
ZXVlLiANCg0KPiANCj4gT3V0IG9mIHNoZWVyIGlnbm9yYW5jZSBJIHN1c3BlY3QvaG9wZSB0aGF0
IHJlcGxhY2luZyB0aGUgY3VycmVudA0KPiB3b3JrcXVldWUgd2l0aCBhbGxvY19vcmRlcmVkX3dv
cmtxdWV1ZSgpIChwb3NzaWJseSBVTkJPVU5EPyE/KSB3aWxsIGdpdmUNCj4gdGhlIHNhbWUgc2Nh
bGFiaWxpdHkgaW1wcm92ZW1lbnQgd2l0aCBubyBjb3N0Lg0KPiANCj4gL1ANCj4gDQoNCk5vIHdv
cnJpZXMsIGZyb20gbG9va2luZyBhdCB0aGUgYWxsb2Nfb3JkZXJlZF93b3JrcXVldWUgbWFjcm8s
IGl0IGxvb2tzIGxpa2UgdGhlIHF1ZXVlcyBhcmUgdW5ib3VuZCBieSBkZWZhdWx0LiAgQnV0IGlm
DQp3ZSBoYWQgb25seSBvbmUgdW5ib3VuZGVkIHF1ZXVlIHdpdGggb25lIHdvcmtlciwgdGhlbiB3
ZSBzdGlsbCBoYXZlIHRoZSBoZWFkIG9mIHRoZSBsaW5lIGJsb2NraW5nIGxpa2Ugd2UgZGlkIGJl
Zm9yZS4gDQpJdCBsb29rcyB0byBtZSBsaWtlIG9yZGVyZWQgd29yayBxdWV1ZXMgaW1wbHkgaGF2
aW5nIG9ubHkgb25lIHdvcmtlciAodHJ5aW5nIHRvIHNldCBtb3JlIHRoYW4gdGhhdCBvbiBhbiBv
cmRlcmVkIHF1ZXVlDQp3aWxsIGp1c3QgZXJyb3Igb3V0IGluIHdvcmtxdWV1ZV9zZXRfbWF4X2Fj
dGl2ZSkuICBBbmQgd2l0aG91dCB0aGUgb3JkZXJpbmcsIHdlIGxvb3NlIHRoZSBmaWZvIGJlaGF2
aW9yIHdlIG5lZWQuICBJDQp0aGluayB0aGUgcGVyZm9ybWFuY2UgYnVtcCB3ZSBhcmUgc2VlaW5n
IGlzbid0IHNvIG11Y2ggZnJvbSBtb3JlIHdvcmtlcnMgb3IgcG9vbHMsIGl0cyBqdXN0IGdldHRp
bmcgYXdheSBmcm9tIHRoZSBjcm9zcy0NCmNvbm5lY3Rpb24gc2VyaWFsaXphdGlvbi4NCg0KSSBo
b3BlIHRoYXQgaGVscHM/ICBMZXQgbWUga25vdyBpZiBJIG1pc3NlZCBhbnl0aGluZyBvciBpZiB5
b3UgdGhpbmsgdGhlIGNvbW1pdCBtZXNzYWdlIHNob3VsZCBiZSBhbWVuZGVkIGluIGFueXdheS4g
IA0KDQpUaGFuayB5b3UhDQpBbGxpc29uDQoNCg==

