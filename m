Return-Path: <netdev+bounces-171866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E87BA4F2D3
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F163A4F84
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8F01CD3F;
	Wed,  5 Mar 2025 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZcJAZVLd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cQC3tqKs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE83A1CD
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 00:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135129; cv=fail; b=jNYeT78pRV210gRGSFNTZIOFSY+uP/S3we/uhujhzwDQ/4wbCQlHRS864F9EsxDIL/qK4iFB4SfEUJJP7qa7YECtbyt2hbnX9qwtweyzDM2RbDCSMv4yNBNKe5/jx0tcRanYYagc3b1mL37qAfhjAvKyStcIJelLvwtGnExSMT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135129; c=relaxed/simple;
	bh=TcxupnYw2SlByI2NPnVnIRKBX5r8AWMPR36Vkm3zxTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dKbD92487BVuxa6vsL1vc2V+Qu81puLzGWQs2TLJLCAwdD8QSkRTH5OPKiJhzSv1KFL3sGl0qXBuuZsBI2rfUEhgakzis2eHiDjvEY/dq7XFfnY20PDagmg5KVsm0qwag9N50L3H9jTcg+bld6wrpKaAEScWSvaQZzy2Z/KCzzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZcJAZVLd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cQC3tqKs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524NuENw004727;
	Wed, 5 Mar 2025 00:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TcxupnYw2SlByI2NPnVnIRKBX5r8AWMPR36Vkm3zxTk=; b=
	ZcJAZVLdM6o2rvIKbrPRPcRQFjYnR4U64BcLISsyNU1FcsOwbb5JxgAV7/1dVV5b
	uPOFa8dkkOcBkJ+vaAfT/0wIFPrakns3tWb9F/hAAltlAwDblq6BsWoDuCg/1GK/
	vKz81xdvjQlrfZ8P4MlaEtMdGdP1KyodGDBGU+TxfO3pn++t+Z5WX84ZeBdb4zly
	7Zqt3sx6TlZ1uK64eHBfJurls1Y2D/sE+MyzxPq5YT1n6HF2TFgDampIDcQ0F7yF
	ZQvH/twpdUCWVzHo4qigsnXAU5qHdsu+sf5SFNlMj6EaPTGtEroUUZH4B3OXctXb
	/9cXVNh8tM7Ceo/5RrN19Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub76e9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 00:38:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524Mn7YF011042;
	Wed, 5 Mar 2025 00:38:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpb8cv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 00:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQkWaCBin+md5d/0U5ZX+CRfUi7H39mZjruz/VmxyCBN86TRBycIH2IlwE02tNEyzzLbg2h3LRP8wavy3T8Fcp30TsocGFVGna1gBNxLme0FoBhtoFxkuZ1rec79FVdofm4IquAgr95uJbRlYlxwL5K38j223uBT/+4HVNtQHU+2Yg93xIQF0e5wGivAj+H68OD2wT4eiqhqUbUeXw89AWvk2YUr+gYZQMPwnXu8FAuHcT/3k0vhglaqfx5Msl8GVgy2wFDWfP482i0i9wtfFVudNNvqYz6/lezBYc7qgd6y4Mully4dMxip/qUTXMW/IjDeNFaANZlD4j09tAhxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcxupnYw2SlByI2NPnVnIRKBX5r8AWMPR36Vkm3zxTk=;
 b=jXHuBME0CXV3P1uLyKCG+EjVxiKFWvcXZzfdlrKeF1vTO0Ex9GbwnIEMGAwSzAN/JW0Rzm+rL6SM+/2wReV5jKAlZVg5UoDkblJyrTixsMOuknniGOOIsJXYyl2tsHxtv4TbKOtzFrKuMWuIX8jJHTVjaAGSsplUpHBiLdl3hr152p+MbL0bFYUlYmtCcGHLKmPw6nVX0t7VOMcvliuMnkYWso3RD/wAsgMhjZEYQaEjHTKUok6XQ1Wo5RedaopKMOsq4kM0xzBIjWat3NN0doKa6Y24Z5ht5DcPhPRj/vTS/Ro0RVNO/eXmu16YYcDMINQqMTG6W5VxII9LqpFJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcxupnYw2SlByI2NPnVnIRKBX5r8AWMPR36Vkm3zxTk=;
 b=cQC3tqKsQ499s8AnscECM3W0rOVPP9DElmYnaq/4JZh63hXqfajzJ658izvD4W2GP+eEjvOrcpa0UCCtI3Jx9CyPoXTP/+ypcgwU3n+AB+iO1YIF9UYBgXcX7UwhUWMVcAA83gY7AMyOGt3wgm5oQCfy2UidOqnismseoXmhQWo=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CH0PR10MB5036.namprd10.prod.outlook.com (2603:10b6:610:dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 00:38:41 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 00:38:41 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv work
Thread-Topic: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv
 work
Thread-Index: AQHbiM/MqlxGuKFhJ0mhR9ncavILwbNdbXkAgAZOyAA=
Date: Wed, 5 Mar 2025 00:38:41 +0000
Message-ID: <b3f771fbc3cb987cd2bd476b845fdd1f901c7730.camel@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	 <20250227042638.82553-2-allison.henderson@oracle.com>
	 <20250228161908.3d7c997c@kernel.org>
In-Reply-To: <20250228161908.3d7c997c@kernel.org>
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
x-ms-office365-filtering-correlation-id: 2275c0b9-443d-4f3f-354a-08dd5b7e13c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?REljSkFLUjFXVSsyUTg2d0lSSDAyaXdzQ1pBZmR4aGhQZGltV1pOTWJNSTZK?=
 =?utf-8?B?SnlkTGxibGVYT1Zma3JTeVE2ZFAvNGUyNGNNWjBrZEVIeEpwcTJKTDd0NHdw?=
 =?utf-8?B?VkV3dEl3S016NUt0RXlYS3ozNTA3RDQ2ZHJNVFNQOTNxaUhnVENkQ3J3NlhS?=
 =?utf-8?B?elRKZlZoSEdDaDBRcU1UZkpxVUQ2UStHOFR4VFFUMlZQd2MwKzRta3NFN0Zr?=
 =?utf-8?B?RG9GaHgreFRrWVVwOXlUeEwyMWtkVW1YeTVJMU1qRjhMdmhISHBQWkxRS0Ix?=
 =?utf-8?B?Y2lXQktyUXNTMzQ3YzczVXpjYTU0WHZTNTJjR3RmU3JHU1UrNDZtRTJiTWYx?=
 =?utf-8?B?RTI4TkxYNVpMRVhRYVJHa3E1T0VhODRZUFJKZXdodGFyVmhyczdoT3hnNUFo?=
 =?utf-8?B?MmtlUGgvTDM5VlJYVkpnV3dLQVZWMmRqUjhLSjVtV3U1MFVjOE0vV2VBT0FH?=
 =?utf-8?B?L2VKVjV5REFJVDRlSVg1SVMzRktVUXdRS3F5UHVIU1RNM29XTnpCNEVlL21o?=
 =?utf-8?B?TTRHbGhOdGc2ZmtUTGFBTkY4U0hQVjhFa01wRzJiTnprU2ozWCtVWExmaGly?=
 =?utf-8?B?RlUyVEpHYXNJdW9VWHVLNGx3anE4MVd5L2RoQTcza2c2dksxcTgzNzVwSzRh?=
 =?utf-8?B?cEp3d2s5VVZkNFl2VFd3eEc2WVBsWUk0d1JFaUFhaDZSV25qRmR5cFp4SEFm?=
 =?utf-8?B?MTN1K2JSSjF0dlgrclQwQi9XRXNRcURPMk5MMjdiZHdIUUIrSENiODZoZ1dJ?=
 =?utf-8?B?SmJGbnhRU3hzbGdHaUNuaVhna081OVM0NlFEbDkzcmMrV2t6Yy90ejJvUVFN?=
 =?utf-8?B?VUJqTVh3MGMrdDR5ZCtUUDFRZWVIbVl1QWhseFhBb0dZWUpmSDJORUFKWTBx?=
 =?utf-8?B?dE43dWZOMGQ5YktrVFEvSm5oZFdpTmZqaXJnRDJhZGg1ZkFuWldIbEc5THZy?=
 =?utf-8?B?dG1Za1kyRzFPTnZkMlVhVDdJNVdGWWd0MitHeGxjM3EybnhYSjZFVnFoaXpo?=
 =?utf-8?B?R1lDdGk1dWhrUkFDZm0wamtrRmFRUk95dkYyb0xYK1FremM4TUhiU2gyS25p?=
 =?utf-8?B?c24rN2FMU21YbmRmKzhkUWRKSGFQWjI1dEJJRnV4NG9FSmxWdjh2UGNLa3lH?=
 =?utf-8?B?a1J0ZzZ3RlpqQlcrRHhJTXJ3NlBrNnVVMTIybVlFSW03U1d3NWM1OUpFODFa?=
 =?utf-8?B?ZElFZTVvS0NOUkIxRnVoc2djV0VkV2RVNDRVNmF0MkRsL1BaNlNrRW9PSm5t?=
 =?utf-8?B?Ymx5NzVNWG96aGlVblI3RUlxL0xFVFE0WEc4RWhFb2k0SWJTR0ZmaEpvR1Rl?=
 =?utf-8?B?MEpWTkpmK1RJUExsU3Y1QTkyU2tpeU1Zbk1zSXd4N1hHclVMNmdqSk45aGFW?=
 =?utf-8?B?Q2lzbThLL2hGNW5QMXNWODd4WXkrRXdSVTZBLzNaWlhleDhuVUdYU3JVVk1E?=
 =?utf-8?B?blA0a2p4MG41eFdFZlYrRU9ZMEhXaGdneFN4ZTNmYVNYWXl1dUR1STYra0N6?=
 =?utf-8?B?K3lnWExGRnlUMDhva1ZZQm1RTTFMeU9hbWx3c3N2RDUyNFJyeFBUa25oa3VF?=
 =?utf-8?B?OUVFTW0xaEsxVjFOSGZNckV4bmVodlhMMm52UUJHT0J0d1RCU2V0MHhDOTVz?=
 =?utf-8?B?UXkyMUZib21yc3BsWWY0ZFNMMmQvQzA2dkhpZ3RwUUhiSWR1WWZyUWZtMk1m?=
 =?utf-8?B?N1hBaUpsQ2FCNUdLWkovOXdyclhYVTA4OW5ZNm5hTDFiNUgvWkxxTmtucUlW?=
 =?utf-8?B?b1FwamxobkQxcVB5elIwN1crTzJudTUrbGNReWxrSkx3K2J5SlZFQnJDbHRN?=
 =?utf-8?B?U0xqbXZPNXA1WHBCZkU1Y3BKMXYrSkQ0U29aMGxFM3pJZVVvSTVCeXR2bUY2?=
 =?utf-8?B?bWpXMS9LSDV5TGpaL2ZMamRsaDRwOE5zdnF0TnpMaW12RmdVQlo2NjZWMU5t?=
 =?utf-8?Q?6r0ZciyfiEAtkcV2hkP/jqZ+d1DL1r45?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGVNZ3JwdTJmcGNhdStBSFZSMGRvUys1dXpiTHc4azA0ZDErY01mbVh4RDhk?=
 =?utf-8?B?UUcvNWhhUkovUzN6L3VMeFAyTmRvZWZYa0JjVitUYVlxbTNYWk5QNXF2UlIv?=
 =?utf-8?B?eGxxekN2VUhWTWlzM2NwbXNPdnNMdWUxLytkYU05TkREWVhlWjRRcGNiRitH?=
 =?utf-8?B?dlBrTVBkZmxjTmJvQ251ZWFiR3dzY3FZTms0ZXBJUzRzSFhWZ2srSnlKUDUv?=
 =?utf-8?B?TDh1Rk8zY0I0TlY1aXFMd1BZOHFqQ3ZQczhWZlRyUkNjQjc0TEd6cm9HMy96?=
 =?utf-8?B?NlNnNnlMdmp2TTlaNEpncXBTTlBMM2h6WnIycmwyUWVmUGYwOGREcWgwU1Mr?=
 =?utf-8?B?SGFhZkpSKzV0V1F6czdJejRVZkJwTFo1UWpyK041OVpQWEs5bG1MMnRPTWhw?=
 =?utf-8?B?YThsRGVJRTJQbTNrK2JSZDlEVmRXanZuSDVUK1hNNVl4ZCtENHVOK3JMY3NN?=
 =?utf-8?B?VysrVWN2aTRrWE9QVzNYV0d4eERFMk0zZmsxQW50and1NTFYNFkzOVMyZFEz?=
 =?utf-8?B?NmZGTU5lVVB4TlBzNjczNFBsVlJONW9SVlBDMEIwc0QwTElGSjdOZzdCUmdM?=
 =?utf-8?B?bklGYjRMcU5vU25uYTh3cHBCWHgvNTdVL0xDTXFnK2xiWDYrRmx6T0daRkF2?=
 =?utf-8?B?eEhxM2l3UEs0TUdzZUNhK0tTZldvNXJ6RzgzUWhrOWx1eDRVV3NZamhhUWRM?=
 =?utf-8?B?Mnl3ekF0dGk4WFVNVHJ3SDVDeGFrS2xLRDRiN2xiRHR0YlVoc0daUDlSR3N4?=
 =?utf-8?B?UmxHd1F6UHVncUtJaFVDYXhxUm9VTU1UMThyeFVWaFh0U3hEQjh1cUo1NWJB?=
 =?utf-8?B?MUJCSjdYM3ZDMUNrVjgxTE1HUU1kdTlobWZKTjdCNFp3SWUzVE5RcUU0aFFR?=
 =?utf-8?B?dzRTNjNaOE5zbnZjVXVpWSs1NE1IRTBZbzVESkJaWVQvREphcVdEdndVL1No?=
 =?utf-8?B?SEp0QTFMam9PTklVdmZSVGoxbHdObGhQMFRvb2lCUHRVQVJhbHdDbktQRjkw?=
 =?utf-8?B?SGVKV09kdjdCMkkydFlnRDMzUmo5UXFMVFRDeVRQVit5TFVFYkM2NFVUUUx6?=
 =?utf-8?B?cWttYXNaT3ZEd3ZLNi9ZVndBOWV0OHFNRkxMRHE3Sm1hVDgyQXdXVDlqTzdi?=
 =?utf-8?B?Y1V2K2VoTnZjaTJZMHBUWVB6QWpobk1Tb2kvSDBkcmhEeGlxZERIaDRReUpq?=
 =?utf-8?B?REtCMU5za1QrSW9lRkFqZjNzM3hsUjFIcGRIQTN1RFRrTkI3T0JpUm5hNER2?=
 =?utf-8?B?S2VpT1hrZURKK1FsNGhVclFQNXBITnlOdzAyYnVMaHNBMHZ3bjU3WkFDc0Rn?=
 =?utf-8?B?aCtxQ3V4NCtYSzgyT2ZJNWtYZ1dMcDJKaXNSMmM3YXYzZjdUZWpyVUFJTStV?=
 =?utf-8?B?RFdEREllUVFSU0xKRDJzV0lSWG9SbU8zM2FjaEk4UDVBVjlVL0dvTDEyakpG?=
 =?utf-8?B?U3dSd3hBRGR5aER3a2JHOG9NYWZjbzF5aDFZVGdlUHdNK1hZcDIzbEtVL3VV?=
 =?utf-8?B?d3FyRmxvNzA2VHVNMVROTlBIMFhPMS83amFhcmc2OVhJdkNTdG1oQ1VRMHJj?=
 =?utf-8?B?V2FmOWFWOERqZHVQRkdDZ3cvQi96QmExRmdLVnlaUUdINW1wbnhRd0t6c3li?=
 =?utf-8?B?UDZCUzNSblZhU3lLRDNPaXJadlJEVTJZTmY1NHBvYTA2SUVtZ1dKLzJXUERi?=
 =?utf-8?B?bDU4NnpqUnJja2xUOEdCZy9DQmdXYkc0MkdTM0d6YllwVkIrMFI1U3plQkc2?=
 =?utf-8?B?YVJzNzZpbzJQbW0rWDdDUWJKUTRJUDV3THo0VVdNdjgwdDY1cFg1em5MVFBP?=
 =?utf-8?B?cWh3djgvOVlPMlJJODdVemdGVE4ybmJkVWdXWkk3aXpOaFZIOW9NVitsejUr?=
 =?utf-8?B?MWlyQXBNRUNUYWRzNkR0QUp5ZmxuY2xINmhxV1Zha0ltbjdBN3BZc3JVQU9L?=
 =?utf-8?B?aHJRcFErR1VWeXYzQTNIUWU3WkhNUVVMR0FsRlFxQk12YWtJcWZaUENvZmJj?=
 =?utf-8?B?MUx1dGR4aXk1KzN2dnQyMVR0TGs2Z0doTmNjYUZlcHYzVUhGQ0hnM3BGTUtU?=
 =?utf-8?B?QTZzMTZFNitZK3JMQ2lIRlZzTTFpazlQTG81V3FTd0p4R1hYN1RVbi9vbE5y?=
 =?utf-8?B?TVc3Y3pwdTQ5ZkFtdnp4NWI4bC9vMFFudnFwZlg4S0RoeHpGNDNkWFV1eW9v?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB3B75AF6E4F0D45930437BFB10B34EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MIGz+CNm3OqL8IMtkCayiSoglT2oHUofBNJCfTlghLVcvhEnEymMn1FpIB2kD4wPelzAW3IGMqKy1dSqj8+WQ/anxF6tt4eu/UR6v4tCUTIAJRnfWJTkVyQ9M7FTtDuYl+PqITZYFHrJ/3xOe74HMI8p2o4cmzcqi5UiJQXmzXUqho864lO6uNwZjEFHwDEk6sAYatGrzMniflcj4FzwcSxf/8KJdUIgzGwGsTTWq95Cf/Ls+OnD5CFKgHTN7vE2YNNdxiU6V7rLXDQqhLyalHuktsTbSHgwf8wgyFtAf87G7o5giocmgaUYsZtho5NyUkLrSV6iVx98dx4W3gGY77lH9td559xS0pL7EUHS1wx5Zn3Gdpa8t1xtxF5OJds9sineq9g38rrhtevr+oa5j2yV9AQwB8zwUjlvb8cvlHg/SW0GBRL7xtmSDPO2WirWBjZQqKeRZ7kwuGcEDBpaG9aE62s5zWaTtFClPa3H8/YzeZzStc8Dtk4IJ2zlkej5IGw/dEFheS9EkzGkCwiOLM+TG+Nw8Ki6zI4dbPv4tQCJF2hCIQZ0i903QdyU4BL/45sSQGGT4h4A4UuQvrWqXhqrJs5+4WYpI6+8upLX0Vk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2275c0b9-443d-4f3f-354a-08dd5b7e13c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 00:38:41.1470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWjCACCl90o9wrqkzIHkk3thK0m//FwWgwE2fV/QQFvhFmCKMZse1Q9ya2vhBkAjr7SWCx1n+X0jjuLVM3dtgd9aWcJIzXuEP6OB9YDiG0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050002
X-Proofpoint-GUID: ZtIiKIVuqlfsm6FvCMYDsKd6wrMSgoGl
X-Proofpoint-ORIG-GUID: ZtIiKIVuqlfsm6FvCMYDsKd6wrMSgoGl

T24gRnJpLCAyMDI1LTAyLTI4IGF0IDE2OjE5IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCAyNiBGZWIgMjAyNSAyMToyNjozMyAtMDcwMCBhbGxpc29uLmhlbmRlcnNvbkBv
cmFjbGUuY29tIHdyb3RlOg0KPiA+ICsJLyogY2xlYXJfYml0KCkgZG9lcyBub3QgaW1wbHkgYSBt
ZW1vcnkgYmFycmllciAqLw0KPiA+ICsJc21wX21iX19iZWZvcmVfYXRvbWljKCk7DQo+ID4gKwlj
bGVhcl9iaXQoUkRTX1NFTkRfV09SS19RVUVVRUQsICZjcC0+Y3BfZmxhZ3MpOw0KPiA+ICsJLyog
Y2xlYXJfYml0KCkgZG9lcyBub3QgaW1wbHkgYSBtZW1vcnkgYmFycmllciAqLw0KPiA+ICsJc21w
X21iX19hZnRlcl9hdG9taWMoKTsNCj4gDQo+IEknbSBndWVzc2luZyB0aGUgY29tbWVudHMgd2Vy
ZSBhZGRlZCBiZWNhdXNlIGNoZWNrcGF0Y2ggYXNrZWQgZm9yIHRoZW0uDQo+IFRoZSBjb21tZW50
cyBhcmUgc3VwcG9zZWQgdG8gaW5kaWNhdGUgd2hhdCB0aGlzIGJhcnJpZXIgcGFpcnMgd2l0aC4N
Cj4gSSBkb24ndCBzZWUgdGhlIHB1cnBvc2Ugb2YgdGhlc2UgYmFycmllcnMsIHBsZWFzZSBkb2N1
bWVudC4uDQoNCkhpIEpha29iLA0KDQpJIHRoaW5rIHRoZSBjb21tZW50cyBtZWFudCB0byByZWZl
ciB0byB0aGUgaW1wbGljaXQgbWVtb3J5IGJhcnJpZXIgaW4gInRlc3RfYW5kX3NldF9iaXQiLiAg
SXQgbG9va3MgbGlrZSBpdCBoYXMgYXNzZW1ibHkNCmNvZGUgdG8gc2V0IHRoZSBiYXJyaWVyIGlm
IENPTkZJR19TTVAgaXMgc2V0LiAgSG93IGFib3V0IHdlIGNoYW5nZSB0aGUgY29tbWVudHMgdG86
ICJwYWlycyB3aXRoIGltcGxpY2l0IG1lbW9yeSBiYXJyaWVyDQppbiB0ZXN0X2FuZF9zZXRfYml0
KCkiID8gIExldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rLg0KDQpUaGFua3MhDQpBbGxpc29uDQo=

