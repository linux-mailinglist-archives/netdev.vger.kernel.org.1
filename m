Return-Path: <netdev+bounces-171871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 184EBA4F2E4
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0F63AAB35
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8544B3FBB3;
	Wed,  5 Mar 2025 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mqD40agU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BIGTXvs7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6726F099;
	Wed,  5 Mar 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135423; cv=fail; b=h8yeYrXcCR5xI0F+dX9tPrngC6M8y0T/ReOZOP5cFWPFkSwQHu6ZYum+H5nlzuT20gsiG3cKq5fEIBrf6feTkmZOIWzgJL7q5pK1pnxPJnJVFyCYVvxijtYVfVY5nGMH+L4b6YTQS2xkjhhMvLaTLq+eb22VOvaunBCUkhAQ5xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135423; c=relaxed/simple;
	bh=097E/OdVcV3CgNV2CKUS1Gb7kjdUBnpZ3zf/uLafU7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PiRAbtxRwzCq2pD96nIlRTqJluBW7kpRoKbFxsktbEYefNiZaf3IR4K8ohxdDfyRORsv2wV/K6r7bkTccSt3HnDKTGc0L0U+Trz1M66CW1Irc1rilPLYJZ2E6rSybnB8XjB6ZLJJL5EYqwKVKEbfIQaR2aiPSd41975ojRrZjp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mqD40agU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BIGTXvs7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524NuBF5021555;
	Wed, 5 Mar 2025 00:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=097E/OdVcV3CgNV2CKUS1Gb7kjdUBnpZ3zf/uLafU7A=; b=
	mqD40agUu51ejLxExE5qEvgrLWmY16ASBXtIGU3Yqj2+pjlwBm1iBS5ndVqUqgQO
	/OvP1qezcV79pm+23vnktFU/tsE9Y37WTKe0xOVoQXhmAieoz4Z0iw2Oshd68rdj
	EyNUbiCyNvJSQ4OChh89xCdhz2Pn/UQWFBxaFf3cI/h5J8nlLEzoBwA3Q/jkGu0o
	TWIay2T3LH9ew5xkUYfos2yueWCvBg+w47UMxqERp38HHoSGiWSTA9ZtICWcGBLK
	2C51AeOLVpoSBYOfMG7bsS1uD/TuL6NZK/ZuU9QcDM9i4zb8itugEe2oXYynlVs+
	QEEiYnHtF6tIEaN4S2GikA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qeg2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 00:43:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524NmQLC003130;
	Wed, 5 Mar 2025 00:43:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp9qnga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 00:43:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkF3N8NZZIRHBoZJwtGYF38gjYHwfL0/tQ8203hatc16rigsyFAUl4P+UqOq2qq1gqXsn05IVJyoQ3tO1ClNZRH4GE0QpDjCf/rIWlJVz/cSJGsXRJcpE3GMv5XaC26u0JR0rwfZVCE/dhFJ3KL+6hqs/zJsb6/0O4CPGfKA+ffXD4ytmOX2YaubK8P00H0j1CHmEha6JMVfg6+4WxBoqz3DguNK5dTE2RZYRuasQZN8XgCdMW+v7j4lksRznf2eh2OaLjDIK4ffvG5nmGzdEtJaGiXjXwwpERWg29X65WUHLEQztBQZvrR5Ih+72CzPLW9aUkZntTSawCGkpVyd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=097E/OdVcV3CgNV2CKUS1Gb7kjdUBnpZ3zf/uLafU7A=;
 b=NIPDVOuG2gOTXzNClwhx2NywtZzGSlmiT7bdGL06zE3H+Oueql9E6XirfnuSHlciHr6T1E23Ju3nn1y5S5vSrkpxPyu28ZvjSGyTIVryJtLQF+JvWLHK2j7P4WrmMPEF+jI61zzt4GcS5m7ug3UcT+NAJQZS6eI7ZfE9nMcbqlB17NCX99Xy9nMGP6OJ/5YKwvEC5Yxudp51R0xhaJCPFaglVjAKtJ2xsG5eg/EWw8u/kpnpLUVOZAwQfHbNERi+nMdAjPZGI/steRhZrtHf9GGDaWJuNn4s92Tl8KRV53hx7rFrVlftiNoXIN/U/xo5Kh/leQbgdzqyFKInyohB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=097E/OdVcV3CgNV2CKUS1Gb7kjdUBnpZ3zf/uLafU7A=;
 b=BIGTXvs76LiHKWF3GgloYUG7w/GokVzUDYN9Tr2cngLRB6C6AtQx5CwVofEG4qR+S5CZl8NLmj4VzcJxTiEasbr8IRSoaupM2b0E7XHSIF7idn8dRjcZurcOzNtWqEUnki44u16X4StZbtX/G94r5JUqX+mgPMhZDoS23HfacfA=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CH0PR10MB5036.namprd10.prod.outlook.com (2603:10b6:610:dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 00:43:34 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 00:43:34 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "lkp@intel.com"
	<lkp@intel.com>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 5/6] net/rds: rds_tcp_accept_one ought to not discard
 messages
Thread-Topic: [PATCH 5/6] net/rds: rds_tcp_accept_one ought to not discard
 messages
Thread-Index: AQHbiM/RTgDvu1dJ7E+uwv3Eh6wCe7Ne8AOAgATNm4A=
Date: Wed, 5 Mar 2025 00:43:34 +0000
Message-ID: <cb0cf353ec927f21a8f12830605834709b1ee338.camel@oracle.com>
References: <20250227042638.82553-6-allison.henderson@oracle.com>
	 <202503020739.xWWyG7zO-lkp@intel.com>
In-Reply-To: <202503020739.xWWyG7zO-lkp@intel.com>
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
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CH0PR10MB5036:EE_
x-ms-office365-filtering-correlation-id: 76070f21-66b5-4c81-e7d7-08dd5b7ec29b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDVUaDBoeGpHdG5udnFZZ1ZYVDdLYjhuNFlNZSt1ZVJmc29kd3dmYUVkMUsz?=
 =?utf-8?B?SEM3RWRLVTYvcFkyS1JYQ0pGWEpERWRGZUtlMHJybTI3VFQ0RGxQd1JhbkNi?=
 =?utf-8?B?QTRXRzZLc2xtdjM0dEVCN21EbHhTV3hUTUpNOTlGL0RnZHNXWjVBWGZMejIr?=
 =?utf-8?B?NFFxN040b1ZQRE9GZ1Rmbkx2TXJLTXhIbEhrRkc5TmZuT0FzSDlLcFEyVU5B?=
 =?utf-8?B?YVFXcEcwNlk1TG5oVDczYlZtVGl2azVOdHMzb2c3amNsTVBkT1BZM290U1Jz?=
 =?utf-8?B?aUZJWDM2bU5sS29MSk1BY1JNYnZZaTVSNndPTmtFR2RSZnVyR1ZmR3lGNVJr?=
 =?utf-8?B?OElDUEVNbDJBK3g2aHZOK3h5VDMwU1hnbmdheFlwZFZOZWNrUFVjWWtEakRs?=
 =?utf-8?B?N28ycXFxcE5VdEU3aG9nUEpWd3Z1VGRyajJaaVJ3S0lpSzYvbFFUaTMxVFJD?=
 =?utf-8?B?TUhVaVlsQ3VzRUtvZE8zU2FXYkY3V1Z6WkI4cE1kWTV3QUhJTHBwMW13MWp5?=
 =?utf-8?B?aTExY0p3ZnpmWHd3V0MyNFFwbTF0RnJrd3Z1bzBkSWxDYThXUExwano5SEo5?=
 =?utf-8?B?TjBVdnNYcXFOcUJlRS9GOXJPcUpYaDhsMkhuYWduUFgzRExhU00vTXFwRFRP?=
 =?utf-8?B?VEtnc2VMV0FsU2lMQ1dpQmkvekFtTlJXc1BtbkNreWFlaSs4V3F4S3NjNTYz?=
 =?utf-8?B?Y2s1UHZhbEtEK2c4emNvRi9haGcvcERwcGVlUmkwV0JiSnBZd1BhWGFxcDQv?=
 =?utf-8?B?YkFIbCt0V01ZK2VKRjkzZm0wcGJmTy9FZWExMTlTelVVUUlrQmo4a1hlVnhs?=
 =?utf-8?B?Q0o3QWJCem5jbGozdmlKRHdzd085dkNidWhoRmtBZ2o0NEw5NWV0dThyUE55?=
 =?utf-8?B?OUZvOWpnVmxjSzlRa240YTZHRkx4dC9tQzhaZjNhQmR4YnBXZmJUaWgvR242?=
 =?utf-8?B?S2tneGNEVjN1RFlvWXFna0x5K08vQ2tIVCtvR0pGL1FsTXAvL0pQbTNhdnlO?=
 =?utf-8?B?M29MWFBkUFVmMUtRVHkwWDJZMFJxZEZVMXRTQWVORVhtK3NpUk1JakhUSnhj?=
 =?utf-8?B?N1FKeXN6NjdRNiszaUl3WHpXcnNseEQrczFKaERRajRweU9XZmFIMW90eFdz?=
 =?utf-8?B?UENLMitwb2JZQ253ZmpTK3hBQkY5SXZKY2JuenRGS2J3ZVlRVUpqcDIrUkx4?=
 =?utf-8?B?UVB0RFR2UVk4RDh5VE9oUHZaOGpQTDBxY1NGZFphM1lCVUNQRjd6ekRnRkxx?=
 =?utf-8?B?S3VMdDNDQjZ0T2JzNHR1NmFxUldNckdhRzlhTFVPUjQ2WGpBZGZIZXF0M0p6?=
 =?utf-8?B?ZUFEOStJeWlxL21sL2VjRWNUWjFrMFJ2SW1xbHA1R21yVXhISDY3Q2tUTmJ0?=
 =?utf-8?B?SHhDVmdJUkpCWnhDaFZiYjBhcWdTWmJkcDE0ZUZCd0d1WUcrWEVsZUliMUVs?=
 =?utf-8?B?UEpzZEdPbGJhc0x4cXE2THY1SkpDWUN5VnkwOTkzdy9oVFFROXl2emx5S2RL?=
 =?utf-8?B?ZEZMR21KK0xhc0xkTFI5dlhWOFg2Z2xrNFQyNHBnVWNOYytpVVdZaUtKQ3Vk?=
 =?utf-8?B?ZGpxcUlYTEVTdXp0NVRCZ1dyQmtyWFVyb0ZpMmx2N0taZldndzJ1L1RCdGdJ?=
 =?utf-8?B?Rm4xMUhlRzJnYnMzU3hFa2NmY2tYY285YTlQM0lWbmlsbW0zT0Z5NkkyOVkx?=
 =?utf-8?B?MVkxcDEzUGZPdVh4bTdIUDBqb1k5dWx2WWNhUkw0MTRCSnBqOWtUdm9CTG9J?=
 =?utf-8?B?NWNkUnRRNGdDNitBZ09ucVhRQmlraTFvVVRhVzNDQzlrcXJTSWZQK2NrbDNK?=
 =?utf-8?B?aytwUit1MHhVcUdBS1B2bjVlckhyVUpMSTNLb2dIMmEvalIvZWY2SWJ0aHU1?=
 =?utf-8?B?RUVCbHRJNHRkQml5VERXQnpLUXZVb2I0NVJZQy80aXkwL1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2hKbENWb1FoUDd1a1lQOURyZmxpSk9KOHJKQkVvQ01vaXBlZDlBTlMyVHpY?=
 =?utf-8?B?SVN3dDlKZWhCRzB6Rmx1d0wxUEkxS2JhMlBjYnhVZ0R2cERCYjlUNTZUZVlw?=
 =?utf-8?B?ZnJkdDAxTzdyRnF3UXkrQ0t4SlFDSm1UeE9rZ2VkcmE3cFFKNit5RS9RY2pn?=
 =?utf-8?B?cVU4OWdtSDRxcFFZNXl3TVQrdERyVFY3OVU4OUVjVzdvTDdmWW9Tc2FtN1hi?=
 =?utf-8?B?QXlvVFM5ZzJBUllnbmhqbGxYbVpMNXozdUhHUThvZzgycTdnZUJEUU9wc2ZS?=
 =?utf-8?B?Skd6dmRGdExaRkk2NElXN3FFL3V0Mlh0a2RaTVhEenBUVmwydTNDQUFzK2s0?=
 =?utf-8?B?YkpaalZWQnA3NUFnU2hZTUVWc2NmQzdVRXZ3c040aDhmTkkwRFFYKzhjOHRk?=
 =?utf-8?B?eXdqVUlnQUNKeDBqbEk5RXAxUC9iWDV3RG1GcFRoa1RLOW9EalVYWHlmSU1P?=
 =?utf-8?B?eFdjQTFNZXp4NjFJakhUMWY5TCtTOXVQWnlrdHEzYmtNaTdpZXgxM05rcFND?=
 =?utf-8?B?eFMyTDlWbmVFUjVwSGMrdVlBb2l1WG1WSUU0NWNvd0dsOW9qSXowejYyUnAr?=
 =?utf-8?B?VjRmRzd2Zm1xVGFFRnpzQU1XZ2ZWYzRLSFpuVktYakxOQXBxSEt6NXB3SWRp?=
 =?utf-8?B?TVl4WkJ5THJ1b0NPS1M5c1pNU092WDM3eGs2VU5IL1VtclUzZm1IR01VS1J4?=
 =?utf-8?B?bDZ1Vmw1azNGeUNYOFQ2WjNXdnpRa0RjclVGKzUrS20wQVUrLzlqdTQrK1Rp?=
 =?utf-8?B?Z1BhbDdFMTJpOTFKVzlBNWpHcDEvTmtJWklCSWNMdEZmZ3RVa0F0djd6NHdB?=
 =?utf-8?B?d0J6a2IvWGlvb0Iwc0dNTUlWNHFEdDREVnBkeWlOTVpGVnhRN0Rnc3lEOGpH?=
 =?utf-8?B?dFFJS2dvVmZjS25OR1IyOFl4WTNRWEVaOEEwdWZ1WVFBQndVV0tTVEE4R2RB?=
 =?utf-8?B?aEZ6V2VvcmhLTEVlRmV3Tkx4UXN3WFhGWGY2bDNVZUdCNmE3c3pwRm1kdEVm?=
 =?utf-8?B?WmpqYjZWbzh6NzBWSmRSTUtmbDU1UXN3K3BUVzhXd1RIK2Z6NlZsanJEcHk5?=
 =?utf-8?B?eEM1cnRTQ0RyK0sydkV5QW13YkU5WmpQS0hBdnRnaEVQTGpmcmdvYitSZlh4?=
 =?utf-8?B?T1NqTnRlNHkwbHZ0V2pJcFdWUXFPb1VXNEFzTkx4T3RlNklEcUhyVzMxQzBC?=
 =?utf-8?B?SlRRUmZrVy9PMWVnOEMrVU5wWmxZdVBDZ3doMTVLazcybkJsVXNnOW1zUDFG?=
 =?utf-8?B?ZmVpSTBaYkJNTEwxbHFETHdpbW5uU3J2WlBXWXM0WjllYmNGR1pTdzFCSGsr?=
 =?utf-8?B?WmFEbEFkdSs2K0FabHh0K2RrSk5BcjQ5bzdVa3lPNkVoQzFTQlN5SDRQYTlj?=
 =?utf-8?B?L3padzQxRmZSUEI3VTJud1dFNnBaekwzSG8zZFBGcVl1d1lUZTY4Q2pMSTd2?=
 =?utf-8?B?Wkc1ejZqUEtjMjRhRmEySHA4Nkk4T2ZLd25GeWVqM25QWWNGdStVZE0wS09o?=
 =?utf-8?B?b2ovdE1ISlBFZ3NOZGdvbk01TzdzM3YzalowemFHaWdiMUVRV0hXVUd5RFIw?=
 =?utf-8?B?U1RTZ3IrZFB1bjNvVUJ0L0Nmcm5CK1ozMndVZGJuaThBNDJoTG9Qbk4vRTZM?=
 =?utf-8?B?Q2M2ZHdUcCs4VTZmNU9WamhoOXVaMERoTkRZYTVBNTNQNUg4QzFLSjRTaWYx?=
 =?utf-8?B?dWw3SUwxWDF3R2NmaW1PS1lXeUdxeVl1NkljOTZwbnJBTkVwWFFST3J4cnN6?=
 =?utf-8?B?a3YwK1oyTkxXNlBpSXdRZnlUYk5LMW81eHlTR2lnOFRSWFBYblRGWHZNODZj?=
 =?utf-8?B?VW1WaG52bnE5VXl5Wkx0T1VhQ280bUY5cjN1VzJpZ1V5VUVRKzNQbnJjTWkr?=
 =?utf-8?B?RlRuSnZKckNlcndGeEJYMWMxM3hJbi96bG5SNXlXekdMRGNmTW5iNU1lcmtL?=
 =?utf-8?B?eWZKVk9yV2FTUnc1d3EyMEEzL2R5RHlCcTQ3T1J1elppa0p5NVVNcDZHanlP?=
 =?utf-8?B?ZkJqSzM5L2lQNFZQVFhzR3NHVko0R1lDUmZjMFFRd1ZmY0tKZ05pUS9vWXBw?=
 =?utf-8?B?aTd3OVVWb3FwNDZDVE5mL3FCdUZPbHZQM21hSS9GWFVYM1k1L2FhV0psVjdz?=
 =?utf-8?B?eDRkY1AzdzY3Vm5OaG90U1Ixcjh5SW9FR3RmS2d0akN2MkUwYVgvSHZWc2lx?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <704AF50D12ED3742859B841272D511E4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gRXQNDkHUwoI/NwSaSqroM6WMAd5uaCdmJGlvz6gGhdZfWfYI0JPn8jEcG+NXTUH+WyfHWX4k2fjp7hDF8T+M8YtjNiWYxBsNwFj0fjAb7Sa92zTXHK5y1NReUJtYGX9PigOsZyTj4poq90GGLEVvhkld4ojIXdpR4FQVZvzg5sG0xIYRbcWrEWcXTUaMKhbSZAiBRSnFFDJ0Vi5YR8UDJY/ZOpnyFYws7cwC0n3C4G3gUgsj/wh/Wn3wxAnnbiZwIZKarS50yCkVRHCkFeUbe8xN5F/Npc4cJxp0a/ASjnsozEnYmN1CMEPr4x+yuRI4Urs2rUf64O59+9EBAQw5/9UohBbR/lhebTwl3KMtrY2qD3k86+7Zw/7mHiCdgYPWsnjYwCI8/dMkAeXP3gRYazvTFbpzWWlv8y+sahsMp665JAhpfQ5quQ90Ac4J/H58OY/+UR1OaobURypUXud630VdLOArUgym1nme9anA/45SKzFETD/AX46ruMfHE41yXxQ2QTLoBu2JVZOp/guzgJcYochjASE9bbV94i7zix5kmatQ3mN8uuxAgoSqHDQLnKfPpgUucEKD6RV0k5XDdatyMtXhk1nVNkciaH/bPU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76070f21-66b5-4c81-e7d7-08dd5b7ec29b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 00:43:34.5172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5Ai56GqqD9QqG7PktqyP4bl5NXwJ2U1roWzLGsSDWiA8OviI439afOpeh58ZVrP7quBMINDzEsWUNzzEreUo4C0s4JtG1t8CPpa8I+LpIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050003
X-Proofpoint-ORIG-GUID: yDyDzc9KeKz8z1F8196NympBrytPT_dR
X-Proofpoint-GUID: yDyDzc9KeKz8z1F8196NympBrytPT_dR

T24gU3VuLCAyMDI1LTAzLTAyIGF0IDA3OjIyICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gSGksDQo+IA0KPiBrZXJuZWwgdGVzdCByb2JvdCBub3RpY2VkIHRoZSBmb2xsb3dpbmcg
YnVpbGQgd2FybmluZ3M6DQo+IA0KPiBbYXV0byBidWlsZCB0ZXN0IFdBUk5JTkcgb24gbmV0L21h
aW5dDQo+IFthbHNvIGJ1aWxkIHRlc3QgV0FSTklORyBvbiBuZXQtbmV4dC9tYWluIGxpbnVzL21h
c3RlciB2Ni4xNC1yYzQgbmV4dC0yMDI1MDIyOF0NCj4gW0lmIHlvdXIgcGF0Y2ggaXMgYXBwbGll
ZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIGtpbmRseSBkcm9wIHVzIGEgbm90ZS4NCj4gQW5kIHdo
ZW4gc3VibWl0dGluZyBwYXRjaCwgd2Ugc3VnZ2VzdCB0byB1c2UgJy0tYmFzZScgYXMgZG9jdW1l
bnRlZCBpbg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXQtc2NtLmNv
bS9kb2NzL2dpdC1mb3JtYXQtcGF0Y2gqX2Jhc2VfdHJlZV9pbmZvcm1hdGlvbl9fO0l3ISFBQ1dW
NU45TTJSVjk5aFEhTjNmaFF6azNXQS1PQWJLVWJGcVpvMkpSZ1ZKQ1NQWDIyVWpTRURyaWdSVlE4
UXZGT280NzlsakdhWjRYa2RpZzVlNEFYem4tQzh2b1dNUSQgXQ0KPiANCj4gdXJsOiAgICBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1sa3Av
bGludXgvY29tbWl0cy9hbGxpc29uLWhlbmRlcnNvbi1vcmFjbGUtY29tL25ldC1yZHMtQXZvaWQt
cXVldWluZy1zdXBlcmZsdW91cy1zZW5kLWFuZC1yZWN2LXdvcmsvMjAyNTAyMjctMTIzMDM4X187
ISFBQ1dWNU45TTJSVjk5aFEhTjNmaFF6azNXQS1PQWJLVWJGcVpvMkpSZ1ZKQ1NQWDIyVWpTRURy
aWdSVlE4UXZGT280NzlsakdhWjRYa2RpZzVlNEFYem4tWUV2YThZcyQgDQo+IGJhc2U6ICAgbmV0
L21haW4NCj4gcGF0Y2ggbGluazogICAgaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAyMjcwNDI2MzguODI1NTMtNi1hbGxpc29uLmhlbmRl
cnNvbio0MG9yYWNsZS5jb21fXztKUSEhQUNXVjVOOU0yUlY5OWhRIU4zZmhRemszV0EtT0FiS1Vi
RnFabzJKUmdWSkNTUFgyMlVqU0VEcmlnUlZROFF2Rk9vNDc5bGpHYVo0WGtkaWc1ZTRBWHpuLU8w
azVtdTAkIA0KPiBwYXRjaCBzdWJqZWN0OiBbUEFUQ0ggNS82XSBuZXQvcmRzOiByZHNfdGNwX2Fj
Y2VwdF9vbmUgb3VnaHQgdG8gbm90IGRpc2NhcmQgbWVzc2FnZXMNCj4gY29uZmlnOiByaXNjdi1y
YW5kY29uZmlnLTAwMi0yMDI1MDMwMiAoaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDI1MDMwMi8yMDI1MDMwMjA3Mzku
eFdXeUc3ek8tbGtwQGludGVsLmNvbS9jb25maWdfXzshIUFDV1Y1TjlNMlJWOTloUSFOM2ZoUXpr
M1dBLU9BYktVYkZxWm8ySlJnVkpDU1BYMjJValNFRHJpZ1JWUThRdkZPbzQ3OWxqR2FaNFhrZGln
NWU0QVh6bi00UDZLZmp3JCApDQo+IGNvbXBpbGVyOiBjbGFuZyB2ZXJzaW9uIDE2LjAuNiAoaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0aHViLmNvbS9sbHZtL2xsdm0tcHJv
amVjdF9fOyEhQUNXVjVOOU0yUlY5OWhRIU4zZmhRemszV0EtT0FiS1ViRnFabzJKUmdWSkNTUFgy
MlVqU0VEcmlnUlZROFF2Rk9vNDc5bGpHYVo0WGtkaWc1ZTRBWHpuLXA0UktaZlUkICA3Y2JmMWEy
NTkxNTIwYzI0OTFhYTM1MzM5ZjIyNzc3NWY0ZDNhZGY2KQ0KPiByZXByb2R1Y2UgKHRoaXMgaXMg
YSBXPTEgYnVpbGQpOiAoaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZG93bmxv
YWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDI1MDMwMi8yMDI1MDMwMjA3MzkueFdXeUc3ek8t
bGtwQGludGVsLmNvbS9yZXByb2R1Y2VfXzshIUFDV1Y1TjlNMlJWOTloUSFOM2ZoUXprM1dBLU9B
YktVYkZxWm8ySlJnVkpDU1BYMjJValNFRHJpZ1JWUThRdkZPbzQ3OWxqR2FaNFhrZGlnNWU0QVh6
bi0zdFRRTGp3JCApDQo+IA0KPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSBpbiBhIHNlcGFyYXRlIHBh
dGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhIG5ldyB2ZXJzaW9uIG9mDQo+IHRoZSBzYW1lIHBh
dGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZ3MNCj4gPiBSZXBvcnRlZC1ieTog
a2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4gQ2xvc2VzOiBodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8y
MDI1MDMwMjA3MzkueFdXeUc3ek8tbGtwQGludGVsLmNvbS9fXzshIUFDV1Y1TjlNMlJWOTloUSFO
M2ZoUXprM1dBLU9BYktVYkZxWm8ySlJnVkpDU1BYMjJValNFRHJpZ1JWUThRdkZPbzQ3OWxqR2Fa
NFhrZGlnNWU0QVh6bi1ncjNrVjdJJCANCj4gDQo+IEFsbCB3YXJuaW5ncyAobmV3IG9uZXMgcHJl
Zml4ZWQgYnkgPj4pOg0KPiANCj4gPiA+IG5ldC9yZHMvdGNwX2xpc3Rlbi5jOjEzNzo2OiB3YXJu
aW5nOiB2YXJpYWJsZSAnaW5ldCcgaXMgdXNlZCB1bmluaXRpYWxpemVkIHdoZW5ldmVyICdpZicg
Y29uZGl0aW9uIGlzIGZhbHNlIFstV3NvbWV0aW1lcy11bmluaXRpYWxpemVkXQ0KPiAgICAgICAg
ICAgIGlmICghbmV3X3NvY2spIHsNCj4gICAgICAgICAgICAgICAgXn5+fn5+fn5+DQo+ICAgIG5l
dC9yZHMvdGNwX2xpc3Rlbi5jOjE3OToxOTogbm90ZTogdW5pbml0aWFsaXplZCB1c2Ugb2NjdXJz
IGhlcmUNCj4gICAgICAgICAgICAgICAgICAgICBteV9hZGRyLCBudG9ocyhpbmV0LT5pbmV0X3Nw
b3J0KSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+DQo+ICAgIGlu
Y2x1ZGUvbGludXgvYnl0ZW9yZGVyL2dlbmVyaWMuaDoxNDI6Mjc6IG5vdGU6IGV4cGFuZGVkIGZy
b20gbWFjcm8gJ250b2hzJw0KPiAgICAjZGVmaW5lIG50b2hzKHgpIF9fX250b2hzKHgpDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgICBpbmNsdWRlL2xpbnV4L2J5dGVvcmRl
ci9nZW5lcmljLmg6MTM3OjM1OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdfX19udG9ocycN
Cj4gICAgI2RlZmluZSBfX19udG9ocyh4KSBfX2JlMTZfdG9fY3B1KHgpDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+ICAgIGluY2x1ZGUvdWFwaS9saW51eC9ieXRl
b3JkZXIvbGl0dGxlX2VuZGlhbi5oOjQzOjU5OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdf
X2JlMTZfdG9fY3B1Jw0KPiAgICAjZGVmaW5lIF9fYmUxNl90b19jcHUoeCkgX19zd2FiMTYoKF9f
Zm9yY2UgX191MTYpKF9fYmUxNikoeCkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+ICAgIGluY2x1ZGUvdWFwaS9saW51
eC9zd2FiLmg6MTA1OjMxOiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdfX3N3YWIxNicNCj4g
ICAgICAgICAgICAoX191MTYpKF9fYnVpbHRpbl9jb25zdGFudF9wKHgpID8gICAgICAgXA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgICBuZXQvcmRzL3Rj
cF9saXN0ZW4uYzoxMzc6Mjogbm90ZTogcmVtb3ZlIHRoZSAnaWYnIGlmIGl0cyBjb25kaXRpb24g
aXMgYWx3YXlzIHRydWUNCj4gICAgICAgICAgICBpZiAoIW5ld19zb2NrKSB7DQo+ICAgICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+DQo+ICAgIG5ldC9yZHMvdGNwX2xpc3Rlbi5jOjExNToyNDogbm90
ZTogaW5pdGlhbGl6ZSB0aGUgdmFyaWFibGUgJ2luZXQnIHRvIHNpbGVuY2UgdGhpcyB3YXJuaW5n
DQo+ICAgICAgICAgICAgc3RydWN0IGluZXRfc29jayAqaW5ldDsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
PSBOVUxMDQo+ICAgIDEgd2FybmluZyBnZW5lcmF0ZWQuDQo+IA0KPiANCj4gdmltICsxMzcgbmV0
L3Jkcy90Y3BfbGlzdGVuLmMNCj4gDQo+ICAgIDEwOAkNCj4gICAgMTA5CWludCByZHNfdGNwX2Fj
Y2VwdF9vbmUoc3RydWN0IHJkc190Y3BfbmV0ICpydG4pDQo+ICAgIDExMAl7DQo+ICAgIDExMQkJ
c3RydWN0IHNvY2tldCAqbGlzdGVuX3NvY2sgPSBydG4tPnJkc190Y3BfbGlzdGVuX3NvY2s7DQo+
ICAgIDExMgkJc3RydWN0IHNvY2tldCAqbmV3X3NvY2sgPSBOVUxMOw0KPiAgICAxMTMJCXN0cnVj
dCByZHNfY29ubmVjdGlvbiAqY29ubjsNCj4gICAgMTE0CQlpbnQgcmV0Ow0KPiAgICAxMTUJCXN0
cnVjdCBpbmV0X3NvY2sgKmluZXQ7DQo+ICAgIDExNgkJc3RydWN0IHJkc190Y3BfY29ubmVjdGlv
biAqcnNfdGNwID0gTlVMTDsNCj4gICAgMTE3CQlpbnQgY29ubl9zdGF0ZTsNCj4gICAgMTE4CQlz
dHJ1Y3QgcmRzX2Nvbm5fcGF0aCAqY3A7DQo+ICAgIDExOQkJc3RydWN0IGluNl9hZGRyICpteV9h
ZGRyLCAqcGVlcl9hZGRyOw0KPiAgICAxMjAJCXN0cnVjdCBwcm90b19hY2NlcHRfYXJnIGFyZyA9
IHsNCj4gICAgMTIxCQkJLmZsYWdzID0gT19OT05CTE9DSywNCj4gICAgMTIyCQkJLmtlcm4gPSB0
cnVlLA0KPiAgICAxMjMJCX07DQo+ICAgIDEyNAkjaWYgIUlTX0VOQUJMRUQoQ09ORklHX0lQVjYp
DQo+ICAgIDEyNQkJc3RydWN0IGluNl9hZGRyIHNhZGRyLCBkYWRkcjsNCj4gICAgMTI2CSNlbmRp
Zg0KPiAgICAxMjcJCWludCBkZXZfaWYgPSAwOw0KPiAgICAxMjgJDQo+ICAgIDEyOQkJbXV0ZXhf
bG9jaygmcnRuLT5yZHNfdGNwX2FjY2VwdF9sb2NrKTsNCj4gICAgMTMwCQ0KPiAgICAxMzEJCWlm
ICghbGlzdGVuX3NvY2spDQo+ICAgIDEzMgkJCXJldHVybiAtRU5FVFVOUkVBQ0g7DQo+ICAgIDEz
MwkNCj4gICAgMTM0CQluZXdfc29jayA9IHJ0bi0+cmRzX3RjcF9hY2NlcHRlZF9zb2NrOw0KPiAg
ICAxMzUJCXJ0bi0+cmRzX3RjcF9hY2NlcHRlZF9zb2NrID0gTlVMTDsNCj4gICAgMTM2CQ0KPiAg
PiAxMzcJCWlmICghbmV3X3NvY2spIHsNCj4gICAgMTM4CQkJcmV0ID0gc29ja19jcmVhdGVfbGl0
ZShsaXN0ZW5fc29jay0+c2stPnNrX2ZhbWlseSwNCj4gICAgMTM5CQkJCQkgICAgICAgbGlzdGVu
X3NvY2stPnNrLT5za190eXBlLA0KPiAgICAxNDAJCQkJCSAgICAgICBsaXN0ZW5fc29jay0+c2st
PnNrX3Byb3RvY29sLA0KPiAgICAxNDEJCQkJCSAgICAgICAmbmV3X3NvY2spOw0KPiAgICAxNDIJ
CQlpZiAocmV0KQ0KPiAgICAxNDMJCQkJZ290byBvdXQ7DQo+ICAgIDE0NAkNCj4gICAgMTQ1CQkJ
cmV0ID0gbGlzdGVuX3NvY2stPm9wcy0+YWNjZXB0KGxpc3Rlbl9zb2NrLCBuZXdfc29jaywgJmFy
Zyk7DQo+ICAgIDE0NgkJCWlmIChyZXQgPCAwKQ0KPiAgICAxNDcJCQkJZ290byBvdXQ7DQo+ICAg
IDE0OAkNCj4gICAgMTQ5CQkJLyogc29ja19jcmVhdGVfbGl0ZSgpIGRvZXMgbm90IGdldCBhIGhv
bGQgb24gdGhlIG93bmVyIG1vZHVsZSBzbyB3ZQ0KPiAgICAxNTAJCQkgKiBuZWVkIHRvIGRvIGl0
IGhlcmUuICBOb3RlIHRoYXQgc29ja19yZWxlYXNlKCkgdXNlcyBzb2NrLT5vcHMgdG8NCj4gICAg
MTUxCQkJICogZGV0ZXJtaW5lIGlmIGl0IG5lZWRzIHRvIGRlY3JlbWVudCB0aGUgcmVmZXJlbmNl
IGNvdW50LiAgU28gc2V0DQo+ICAgIDE1MgkJCSAqIHNvY2stPm9wcyBhZnRlciBjYWxsaW5nIGFj
Y2VwdCgpIGluIGNhc2UgdGhhdCBmYWlscy4gIEFuZCB0aGVyZSdzDQo+ICAgIDE1MwkJCSAqIG5v
IG5lZWQgdG8gZG8gdHJ5X21vZHVsZV9nZXQoKSBhcyB0aGUgbGlzdGVuZXIgc2hvdWxkIGhhdmUg
YSBob2xkDQo+ICAgIDE1NAkJCSAqIGFscmVhZHkuDQo+ICAgIDE1NQkJCSAqLw0KPiAgICAxNTYJ
CQluZXdfc29jay0+b3BzID0gbGlzdGVuX3NvY2stPm9wczsNCj4gICAgMTU3CQkJX19tb2R1bGVf
Z2V0KG5ld19zb2NrLT5vcHMtPm93bmVyKTsNCj4gICAgMTU4CQ0KPiAgICAxNTkJCQlyZHNfdGNw
X2tlZXBhbGl2ZShuZXdfc29jayk7DQo+ICAgIDE2MAkJCWlmICghcmRzX3RjcF90dW5lKG5ld19z
b2NrKSkgew0KPiAgICAxNjEJCQkJcmV0ID0gLUVJTlZBTDsNCj4gICAgMTYyCQkJCWdvdG8gb3V0
Ow0KPiAgICAxNjMJCQl9DQo+ICAgIDE2NAkNCj4gICAgMTY1CQkJaW5ldCA9IGluZXRfc2sobmV3
X3NvY2stPnNrKTsNCj4gICAgMTY2CQl9DQpJIHRoaW5rIGp1c3QgbW92aW5nIHRoZSBpbmV0IGFz
c2lnbm1lbnQgYmVsb3cgdGhlIGxhc3QgYnJhY2tldCBoZXJlIHNob3VsZCBjb3JyZWN0IHRoaXMg
d2FybmluZy4gIFdpbGwgZml4IDotKQ0KDQpUaGFua3MhDQpBbGxpc29uDQoNCj4gICAgMTY3CQ0K
PiANCg0K

