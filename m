Return-Path: <netdev+bounces-206508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF57B03534
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFB11894B0B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07511E501C;
	Mon, 14 Jul 2025 04:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b2SMA/mW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uxZLDyq+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D34501A
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752467805; cv=fail; b=qu+pi8a/Y89yNjyZmPfWa/Zi42Mu94PDt7WP3KP2PVGuuEdZJ9ve+h4LuAPmQfCvQ9B1CnN7GWIQwisyn3rawH9lJWX0R6eWIMBFmjcoQohEMbIARzymUaamD80XrGbo2sx+QTwRBXOx1Jn2rTx+CFmvwvausWDomXfF1YlTE2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752467805; c=relaxed/simple;
	bh=mttDDeqpogMz77el2pesjiofTjA0dlcrpr1Kf5874+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajKp2PhYeRWfCEIvERcNOnybDRW7kEQCcFd3+ltuR+jpHGJMsHNGxslw/F2jxqtnMEMOQnNxOGB4x7CXUd6FZ5PUnFXMM9RaVQwTr7c2yZgtoKt9SOqU8sRl9TrAdVDUdHSZ1IZ/C2jUCXpLVgA9CDCaC+ZYvg3h/HfpbIgomV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b2SMA/mW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uxZLDyq+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DLW6sq007691;
	Mon, 14 Jul 2025 04:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mttDDeqpogMz77el2pesjiofTjA0dlcrpr1Kf5874+0=; b=
	b2SMA/mWz83x5atm1KRqPM86j97leYc4UvcJdZIQXSkegU5UN1bxqAE24MqbHbYd
	Cw1cqbe3mHfKfAaiONetsLfp9Ho1/NpaBdVyEqjAqQWIgWm/yyKoVMaIL0vhdmAE
	e5iVrR+lUrY+A+4Ac3k8fqY0g2dlLKKqovDAcKSWEGBDj/hkEp/UnN+yHnyDCMLf
	m1P8ASVPePpjC7MvNT8ddx17iRpiJzCbW9/1zIf4TgpoEH3fIZJqZUz3PHY4t4vS
	XPqdt2VBIxW0+XBOTqEaHrh/btJPEgbKgDepr36sLqs7gOeY8tPFWh2NRxOqGTed
	NxoVSwmSryhFp6GOM24DSA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1aubub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 04:36:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56E2Wwtk023985;
	Mon, 14 Jul 2025 04:36:41 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazon11013048.outbound.protection.outlook.com [52.101.44.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue583e64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 04:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9znFxwNzVKoe27I9uYLljdjfZw2yW95Vr8gOYT8kXb/b8CI9C8S6g3AIR+mqWf/n5OkZb0xaub0/l53USulfLFoGNpPh2LwOCVX6j+HpbV9N0Y2EM/t8BwO6mEp9urjznaIR8OkvlFm9MZSjv7auOw/MNiE/a/b7zKAHmTW5n05NXw2fzbs7WfNkmUs+w1RulegYRZQ2LIXUQECOl6YQkAbGgH/xxw4pdzHRO1otFiFr0u9SuR7zXs444ibSWAgNeWcumrLQnt93Nz+Win6GTd0kKkaXRecKvoO4Xk5OlvHqghwQEeC9iXwS18T7ALyChAzrZN4w0jgWjYBeZtnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mttDDeqpogMz77el2pesjiofTjA0dlcrpr1Kf5874+0=;
 b=OIbTSvZccrMT68oVjdm9Qb0eGELgAvVCpYRYYNbGDaCP2MCSDps16lcgW8EXahj5SJup5pr0PB+eRTrdmZt7TzUyQkArqziEmNbO9OnfusdHczkiiWN3Twa0xWogm0tbO5yyManQ0NXujTOdNmilCfjPiczHiXN9sdGwbk/a407UA2SU3TuYQ8JW8f3r8iTYpiPyIyxDHXnsXv/g7OP7lzVxvwVsmma4+wKogadaw6QuR0/naQYJVpxoZLONzkn8cYSYYYi64BZ7jnI3DMhGYiUCbrlESZI3RtlLRHMxBwzNWzw/xcRAW0lPfpevFE2NPewsEpwHVNgX6Kj9sPmRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mttDDeqpogMz77el2pesjiofTjA0dlcrpr1Kf5874+0=;
 b=uxZLDyq++MWK8MJHrbqR3mnrarjXOcbpSiJfveH8FAiRZDtqGwm1m6vufC4w1p3/tSNKpRvRV9Sx9ywbZst68drHtdPC21Vb0Xd2oxGsV+sDr9lwgcv55xsbQzPXXc4u/0nkVLOTafsLLKvuIZ2a6c5VEwVs/wRY8ExebywHrK0=
Received: from IA1PR10MB7417.namprd10.prod.outlook.com (2603:10b6:208:448::15)
 by DM3PR10MB7925.namprd10.prod.outlook.com (2603:10b6:0:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Mon, 14 Jul
 2025 04:36:33 +0000
Received: from IA1PR10MB7417.namprd10.prod.outlook.com
 ([fe80::4970:7ab6:8d74:aaf9]) by IA1PR10MB7417.namprd10.prod.outlook.com
 ([fe80::4970:7ab6:8d74:aaf9%4]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 04:36:33 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC][PATCH] don't open-code kernel_accept() in
 rds_tcp_accept_one()
Thread-Topic: [RFC][PATCH] don't open-code kernel_accept() in
 rds_tcp_accept_one()
Thread-Index: AQHb9CA2QLpUxMoCe0CMXsyeXGlURLQxCX2A
Date: Mon, 14 Jul 2025 04:36:32 +0000
Message-ID: <2eb0df2c5dd8b16b5103f0e2859690519c4f2dad.camel@oracle.com>
References: <20250713180134.GC1880847@ZenIV>
In-Reply-To: <20250713180134.GC1880847@ZenIV>
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
x-ms-traffictypediagnostic: IA1PR10MB7417:EE_|DM3PR10MB7925:EE_
x-ms-office365-filtering-correlation-id: 3b6df3c5-57ce-44d5-f4e8-08ddc29002af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1ZHcHhvRnFFcGREWFRqQXF1ejZMY0c2MjRBR0I1dVQrOWcyRlZ6eTZBTC9U?=
 =?utf-8?B?UE5BRzczMForUzhDaktXZ0xSWjUzWGsyT2xBNURVZkoxbjVkTEIyMVkwTXRs?=
 =?utf-8?B?OWlBZDBGOE40bUgzVDNMd3c2MFpkYVo2cUU1WU94OHBLcEVtT0x2RGxFUC9h?=
 =?utf-8?B?VTI3T3Y2dXdjcmVBMXpuakJJeUhKbTZLU0l1QXFrQTluNStyczdIbHEvbTNV?=
 =?utf-8?B?SGh5ZEJHOXpqN0RSUlpqcGVRbXFOU0ZYTWhNeVdQZU5aNzAyeWFKeERQN25x?=
 =?utf-8?B?WkJ4NlcydW1nNms4MnNudDRvVlZDcThpbnZ5TnU3TDZUbmVLbFE0MGk3amNw?=
 =?utf-8?B?SWVFc2VPYWRibGRYMUhsVjAzQklRLzNnODBvM2lxaTVoQ0dWdmlBMWc5T3Q4?=
 =?utf-8?B?SGlpNGVjYmdwRmRhSXkzMGpZcTI4UE5DUHdMSktxMVdyaCtLd0xhNEpsQTVx?=
 =?utf-8?B?eENYbGg0ZVN1K09pcEZxMXVTK1loVmdYMUVrZGRURVBiWnhBODlKUFlWUVpw?=
 =?utf-8?B?UnZSWVNlNFZYeSttL2ltb2Y4MEZST1RGck1kNndCZ2R1dUNuTjdHNE9PQ2Rn?=
 =?utf-8?B?RE8vTklPVjA4ZUJ3Y2x0eGxGbVlnSnVvVFkwWjY2R1YwTFV0UW9kbnpVaE1J?=
 =?utf-8?B?bFVtZStONUxVZ0FWVmhrRC9hNnF4TEN6SFRFTytNTUM4NUFKK2RUVmFlTUs4?=
 =?utf-8?B?NjJDeFNEc0pSZFozanRwbHNaSUVYQm13eGU1aVpGZEgvckNQc3liUlpzdW1t?=
 =?utf-8?B?QnlwUHM1TUdzWGJiUlFMNjlaNmw5TUU4dGlaUkV4U2luaU05SG1IZXNKNXho?=
 =?utf-8?B?TURlN1BCNmhnbWo3YWhXRThMTk1NN3JHbTdVcUthSFJTc2ZTeFhRZDJqa1E5?=
 =?utf-8?B?RVJ4NGR3WTRVQTBWN21kL0szanZOSjlmWmpBQndBVVdBTlI3dFFZS0x1azhp?=
 =?utf-8?B?MkJ6VWlHbUxLb01MSDFpZHlGbUZjNTdEeEVhRnZjeVp6QWVOTVNYNHZnQ1JC?=
 =?utf-8?B?VUxidjhiUTBBdlZMdXJDeEV2SmtLKzBpM0pwNnUxMGNnYUxzZDdjZGtnZGk3?=
 =?utf-8?B?RzdEdjd1MlFZN2JFbTlOblpmc1pFSHp6cHdVeEFVTm1mU3B1SDRiVSt2SjRP?=
 =?utf-8?B?TGNISVlNQmh1dXlVazc3YmRzMFZJV2NqRGxXRHJWU2prV2hXVjBiMkpMN2pm?=
 =?utf-8?B?eG5ZWitUZitBMzJtRG90SGRhcXpkRFU3ako0QzNoa3I2bzhpWXlHeGR1QW5J?=
 =?utf-8?B?SkFDOU5BUHVyNGgwK3lqcGNhTUJZVE9BZFl0R1BDNVpXL3pZd3Rzd3YzQzl4?=
 =?utf-8?B?Z214dnNtQnlzVDEzVEtBT0VEUkNYNFc1L3czcGRHYXBqYm8yTk9rYmNibnBP?=
 =?utf-8?B?S2hoejI2SnFEMGdFeDF4Sm9kR3JQUnVJQjRaMUJoSHpwVml4Zm1OT1JiVDdj?=
 =?utf-8?B?ZlBlNDRSeXBNYXlsYU9relpxNGpGei8rYUliL1QxckxpQWNmVkFPbmRxMWQy?=
 =?utf-8?B?TlRrd09LOHQ5MHMwd3RhQUIyd0ltVWdkSWpjbi81cDRVK3YyLytsZXVsUWV1?=
 =?utf-8?B?ckZXM2twWWVXMjFKRFp6NmdnY1pUeU1JUmJFUXVYTUxQVFIraDFIN1BROXor?=
 =?utf-8?B?eDZuZHorSDlac21WKzd5NFV5dlQ4Z2s0M2lTQmhab1p1Z0RsUFZCbWxsSG9O?=
 =?utf-8?B?K0xDYnplNU5HNXJhSFhoMHdDV2t2TitMTWo1YTRvRWVpRnhEeFFLSEJrQ3ls?=
 =?utf-8?B?LzRvcWdCbWhwQTBIb1BBL252ZWhiR1FybW11b0o5M1BwQTI0cHBEQ092NGhK?=
 =?utf-8?B?SjlZWldGeVgzZ3BBdms2MWxncVB2YkFsZnZXcHBzTjcvc2FVekxuWW1SbTRs?=
 =?utf-8?B?d3J6RXBvejFSOGVKd1N5a1hDeWIyZTk0SXFkZHNwcWRBN1h2bnJYM2dhc21S?=
 =?utf-8?B?VFJEajQxM2Y4QkZPQVhBbi9FWjdTNEgyZ09DTFRVb2xsTTRnbTdQMlBVUFdr?=
 =?utf-8?B?RW1kWlV4QTNBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7417.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmdDZFhyMkRTVmxUcHJCZ2loUFY0Sm90djlVblVXV1RiUExaZmhOakNzb1Q4?=
 =?utf-8?B?Mk9KOEoxMXBvenhpUm1WQ2kxazE5bEJZaTlGeUJlc3VtbkhYQUkwbXYxZDdl?=
 =?utf-8?B?V29jeUNuT1lHSi9sWjcreGdJdUc4RUIyRFNiTlZvRWROSHVGSW5KWU9OMGo5?=
 =?utf-8?B?M2psN2dvM2dKR2FoQjI5RkFuL3F6dStmMFlqUDlPbS9IOG0zL1FwWE9Gck84?=
 =?utf-8?B?dUswSmlRbnJIcU1GRnA0WG5QYW84RERZT05heVMrdWovcHVWTnBudzV1ZlZI?=
 =?utf-8?B?T1A5TG8vOUkwaWx0ZlIrbklPQ1VqaUlsSyt4Z3c3WG5KdE5EeHJZbFlRV0Zp?=
 =?utf-8?B?SHcwc2dXODI1YWkzSkR2YWgrUnpGU0NjUWxjblRKdGh3QXQ2ZGpBNXZYcWdQ?=
 =?utf-8?B?U0M3dUNaUk5iZXNzaTA0MTRnNlA0VThVNkVpM3F1TFRQd0YwTms5bE1RRU5y?=
 =?utf-8?B?dGRaWkxjemFKUk1TcC84L2Rsb0U3OEwrRFMvUWFEWkZGWHJhM2tiYVRtcjZN?=
 =?utf-8?B?UzhEMkZkQkZ0akMzSWorWWZSZFgyRVU4Q3ZWSjluQ0l6RVNpM0NFSmJKdE1Z?=
 =?utf-8?B?R2M3aDNCTzkzNXNHWkJEZjNwRUJKTWN4VVBiQm1jOG1IU0VpMXIyRWUxd09G?=
 =?utf-8?B?WitxNVcwanhnenp4SDhpTTB4RmlZZG1hVFhTbWIrWTVyMmxwM1BmMkJCbjJq?=
 =?utf-8?B?SlV6VzdTb0JCU3JSR2V5aUljc29hYUdvVkl3OVpiVFlwNGVjd3BqWFRnTnlp?=
 =?utf-8?B?YjFYaDZiMTlaRDRqUXBIOXh4VmJlTDZubHFwNngxNFdmN0xFMkFOdnFvVE1s?=
 =?utf-8?B?bHlVWjM2clY3YzQvS05ESW5pV3pDN0ozRUMxMlJETXZhMVFTKy9EL1RQYmlO?=
 =?utf-8?B?ajRpME1wa1g3YWtMbHZHUlJndUJZZ2FPZ1B6YWE4Rm5CeWYySkN3OS9SR2VU?=
 =?utf-8?B?RXVHQWRtL0tWY29kQjVycGF4aGpMekRMQ1B4QlI4bldYdVR5a2RBRVFoQ1VM?=
 =?utf-8?B?YWRaRUttaEl5QXpqVW92NmV6Sm4zelp5d3pvdXBOTm5IQXFGWXpkM09uVnZh?=
 =?utf-8?B?NDJ2eUllRExSR0Y5NysyalJnOVhGY1VpOHNNWWJRUER2elg1Qmh2cklqMFlu?=
 =?utf-8?B?R013ckpkQzFPSmthZi96dXcybEFwNnRCcEwwTDBuZDJtSUNxMm1VSUNPTUFa?=
 =?utf-8?B?bFhpd2ZpbEpsbXdsSlU2cTdKMnNIckR5bmNqckQxajFEeTN2Z1hQY1h5K0RW?=
 =?utf-8?B?NEhlOU13dm9DR05zZDNtd284VkVRYlk1MEY3K205bTVsYVBiM0RTd2xLZFM4?=
 =?utf-8?B?dHpPQW5mL09WMFNOVzRuWXhHZ0ZNbEZsL05yWW1teW1uOTFiZDJOT3VINGpZ?=
 =?utf-8?B?ZmdLVGMzbC9XY0dsZ0pUeHE2SFNueFhhQUh0TGxxVmx6WU1laU5SQWV6cy9Q?=
 =?utf-8?B?U0dqdGxNSE9WR1BPRy9TbUxRMVpBdkVQYy9NWWFhd3d6MDV0RkxTN2E0REZW?=
 =?utf-8?B?dTFXMVBMY0w4bjVxWXN0OFZLNGNxVzladWFkRE16a2RlUng0eVgvaEVXNCtj?=
 =?utf-8?B?WmladERTMDUwRFkxenovakNEYlNiTFVLMUVCNVB2TnQvTkxwYzd3a3B6cnBo?=
 =?utf-8?B?ODNGWlV4RWdwUjVReTh1U0FVZzlzUEZHUFQ5Y0NnUG5zQWxWRHZxdkNJN090?=
 =?utf-8?B?OVBUZmhCQllVWXRrajQ2NFJSakU3QWQ0NnVxc2VwVjZsZFJTOEpNZlQ5LzZY?=
 =?utf-8?B?eTdabE5SY1dPODJoa1NvZjgzaWlPaUxENkFFczN3RDhQZGZJUFlmTTFKQUJr?=
 =?utf-8?B?b0xvMURIcVVrWVpSZm1tb0oyOU5XQW1xZ0RVTWNheHJ3RkVLNThtNHZJRHJV?=
 =?utf-8?B?WFhueWtldmI3R0hoZU1reXoydU1vNFZERWtXSnUvSFUxc0RMZ3Z1YVFKNVVU?=
 =?utf-8?B?VmVPRkdZNmRNRld4eWNHaXMvV25hcFJ6N3IyTXdOTjdTenEyazMwcXFFQk9Y?=
 =?utf-8?B?QWVYTkhHQ1NBemp0eHAxZmx4YUpjVTRFNE53VThkbnhRazBMSDRWWDA4VGk4?=
 =?utf-8?B?Q3RQRVpWdmpNNzljKzdHUEh3L1ZtU0sxdGtRV3puamZpWjVqMlZIc3ZwL3M1?=
 =?utf-8?B?dmlnNDI0OThxdzVSMWptRDhYcHZWZGM0cmhvQ0dUbU1JNmY0VXdMMGNjMGdI?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12B356F71489FC46BDB2189786D378F8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NzL90ta6sQhARXERKjvYJB+YrcR/Ir4eDWUIDfI6LdbUDUMYQCEX3g8QPvGakzbDISBElicLIAnXky48j3PMOWTfow6rIUP4Zp/PooMoriQ0zLNv9Jb2v6r4AqztlJb7X70twYbpm/gQwXbxDOBh3zeBheioycg2fLdE7QM7eQv+Z5/wTTC6ypn4Haeq6fMyj9sBpySoeBfbJB2PTMM/OqSz6ty1qX6nAo/414+5QzByTOkYD4XbkdT47cEwxPm2rCG0Bc0owv3zpLwZbEhvcAIKEjV4nHbHxOkVvGSkVQQcYtlbkKVU9JNKfSI5hbNTr9y1cwyiEVUoWOiUdK+cLNPKjhT8Pnaw8cJVCudfO+0LQAmDBg6IHAkcDmoMNRI+nio+RdCdXEawUOs6BUHS+CZ+t5xO262JL0AxWXvTVVUeO1TvyadJHQ/u30UGjTn8rZ5vG+YS5pBKTs2fPdjmLVJHnXWR9QiM/SYDGTt5St1rTWWzTp4WPpvdF9xVvivofIKqwPg405O23HguOmzgX4Wa7mThWljfhtW7xWBAZs9iX4NXYuwk+X9Q9iVeS9mwDqaUPH1kmFUPMQBfHRbFMDMZLhd6cc9HGu/x5P2/6ZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7417.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6df3c5-57ce-44d5-f4e8-08ddc29002af
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 04:36:33.2394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1Gw9YU82hUvdZgIJKNcMS28UiaXsaDPjjDYRnAjSdsjyN6lBVxjff2+VbnsdIQ52GERUDxUuGj2dtrFw/F9Yy+u28Fxkz5yLxLYpxMVpuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140024
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAyNCBTYWx0ZWRfXxC5/QbawOdn0 JKCX9L2t4QgAPES7VXHDYiQ2VrY2j4Ivu+zPJFvBaI9VgSkgzX6NqeeqexYF0y3q+JP0xVYK4p7 5SJH+CFPWVrONy3Qe/SoA+jJBAMXZEe7Xetf5sWCgLeEfQchHzhq7vtOCkYC2qKcpS1YXHKJsCL
 I9Sbz0YMjs9VhDOdW5lSfxeV70PUmhz36XKxZVUZ7RikOci+CIbmmAY/6VrzjuCdej0wYSmxVgd RidIo77NVDOOpyb7JO9qDltb+gxiPo/yzH80NDkfv1awKYR85nVKT/AsXvFMm/BJBAk378pidQw w5wvixm7qWDHK1GBkPbtCjEGh+Iqcdp8sm0pKhQlopm2EuqC21XsY/V/aUaBVR/5c+OgC/IjRxY
 ZJ5dmM66/mfYDE+7stCoe2PnJoRT5GjQvHXP6j5+yGMGQMxwdxH2H1RDbbnFyBQ5/tiPUgw+
X-Proofpoint-GUID: 3-Qx_C4hPazKADtir2cGKPCBrVoxmL_D
X-Proofpoint-ORIG-GUID: 3-Qx_C4hPazKADtir2cGKPCBrVoxmL_D
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=6874895a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=drOt6m5kAAAA:8 a=lg7cvda2CWqSLD4-RrwA:9 a=QEXdDO2ut3YA:10 a=RMMjzBEyIzXRtoq5n5K6:22

T24gU3VuLCAyMDI1LTA3LTEzIGF0IDE5OjAxICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiAJcmRz
X3RjcF9hY2NlcHRfb25lKCkgc3RhcnRzIHdpdGggYSBwcmV0dHkgbXVjaCB2ZXJiYXRpbQ0KPiBj
b3B5IG9mIGtlcm5lbF9hY2NlcHQoKS4gIE1pZ2h0IGFzIHdlbGwgdXNlIHRoZSByZWFsIHRoaW5n
Li4uDQo+IA0KPiAJVGhhdCBjb2RlIHdlbnQgaW50byBtYWlubGluZSBpbiAyMDA5LCBrZXJuZWxf
YWNjZXB0KCkNCj4gaGFkIGJlZW4gYWRkZWQgaW4gQXVnIDIwMDYsIHRoZSBjb3B5cmlnaHQgb24g
cmRzL3RjcF9saXN0ZW4uYw0KPiBpcyAiQ29weXJpZ2h0IChjKSAyMDA2IE9yYWNsZSIsIHNvIGl0
J3MgZW50aXJlbHkgcG9zc2libGUNCj4gdGhhdCBpdCBwcmVkYXRlcyB0aGUgaW50cm9kdWN0aW9u
IG9mIGtlcm5lbF9hY2NlcHQoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsIFZpcm8gPHZpcm9A
emVuaXYubGludXgub3JnLnVrPg0KPiAtLS0NCj4gZGlmZiAtLWdpdCBhL25ldC9yZHMvdGNwX2xp
c3Rlbi5jIGIvbmV0L3Jkcy90Y3BfbGlzdGVuLmMNCj4gaW5kZXggZDg5YmQ4ZDBjMzU0Li5hZjM2
ZjViZjg2NDkgMTAwNjQ0DQo+IC0tLSBhL25ldC9yZHMvdGNwX2xpc3Rlbi5jDQo+ICsrKyBiL25l
dC9yZHMvdGNwX2xpc3Rlbi5jDQo+IEBAIC0xMDUsMTAgKzEwNSw2IEBAIGludCByZHNfdGNwX2Fj
Y2VwdF9vbmUoc3RydWN0IHNvY2tldCAqc29jaykNCj4gIAlpbnQgY29ubl9zdGF0ZTsNCj4gIAlz
dHJ1Y3QgcmRzX2Nvbm5fcGF0aCAqY3A7DQo+ICAJc3RydWN0IGluNl9hZGRyICpteV9hZGRyLCAq
cGVlcl9hZGRyOw0KPiAtCXN0cnVjdCBwcm90b19hY2NlcHRfYXJnIGFyZyA9IHsNCj4gLQkJLmZs
YWdzID0gT19OT05CTE9DSywNCj4gLQkJLmtlcm4gPSB0cnVlLA0KPiAtCX07DQo+ICAjaWYgIUlT
X0VOQUJMRUQoQ09ORklHX0lQVjYpDQo+ICAJc3RydWN0IGluNl9hZGRyIHNhZGRyLCBkYWRkcjsN
Cj4gICNlbmRpZg0KPiBAQCAtMTE3LDI1ICsxMTMsOSBAQCBpbnQgcmRzX3RjcF9hY2NlcHRfb25l
KHN0cnVjdCBzb2NrZXQgKnNvY2spDQo+ICAJaWYgKCFzb2NrKSAvKiBtb2R1bGUgdW5sb2FkIG9y
IG5ldG5zIGRlbGV0ZSBpbiBwcm9ncmVzcyAqLw0KPiAgCQlyZXR1cm4gLUVORVRVTlJFQUNIOw0K
PiAgDQo+IC0JcmV0ID0gc29ja19jcmVhdGVfbGl0ZShzb2NrLT5zay0+c2tfZmFtaWx5LA0KPiAt
CQkJICAgICAgIHNvY2stPnNrLT5za190eXBlLCBzb2NrLT5zay0+c2tfcHJvdG9jb2wsDQo+IC0J
CQkgICAgICAgJm5ld19zb2NrKTsNCj4gKwlyZXQgPSBrZXJuZWxfYWNjZXB0KHNvY2ssICZuZXdf
c29jaywgT19OT05CTE9DSyk7DQo+ICAJaWYgKHJldCkNCj4gLQkJZ290byBvdXQ7DQo+IC0NCj4g
LQlyZXQgPSBzb2NrLT5vcHMtPmFjY2VwdChzb2NrLCBuZXdfc29jaywgJmFyZyk7DQo+IC0JaWYg
KHJldCA8IDApDQo+IC0JCWdvdG8gb3V0Ow0KPiAtDQo+IC0JLyogc29ja19jcmVhdGVfbGl0ZSgp
IGRvZXMgbm90IGdldCBhIGhvbGQgb24gdGhlIG93bmVyIG1vZHVsZSBzbyB3ZQ0KPiAtCSAqIG5l
ZWQgdG8gZG8gaXQgaGVyZS4gIE5vdGUgdGhhdCBzb2NrX3JlbGVhc2UoKSB1c2VzIHNvY2stPm9w
cyB0bw0KPiAtCSAqIGRldGVybWluZSBpZiBpdCBuZWVkcyB0byBkZWNyZW1lbnQgdGhlIHJlZmVy
ZW5jZSBjb3VudC4gIFNvIHNldA0KPiAtCSAqIHNvY2stPm9wcyBhZnRlciBjYWxsaW5nIGFjY2Vw
dCgpIGluIGNhc2UgdGhhdCBmYWlscy4gIEFuZCB0aGVyZSdzDQo+IC0JICogbm8gbmVlZCB0byBk
byB0cnlfbW9kdWxlX2dldCgpIGFzIHRoZSBsaXN0ZW5lciBzaG91bGQgaGF2ZSBhIGhvbGQNCj4g
LQkgKiBhbHJlYWR5Lg0KPiAtCSAqLw0KPiAtCW5ld19zb2NrLT5vcHMgPSBzb2NrLT5vcHM7DQo+
IC0JX19tb2R1bGVfZ2V0KG5ld19zb2NrLT5vcHMtPm93bmVyKTsNCj4gKwkJcmV0dXJuIHJldDsN
CkkgdGhpbmsgd2UgbmVlZCB0aGUgImdvdG8gb3V0IiBoZXJlLCBvciB3ZSB3aWxsIG1pc3MgdGhl
IG11dGV4IHVubG9jay4gIE90aGVyd2lzZSBrZXJuZWxfYWNjZXB0IGxvb2tzIGxpa2UgYSBwcmV0
dHkNCnN5bm9ueW1vdXMgd3JhcHBlci4NCg0KVGhhbmtzIQ0KQWxsaXNvbg0KDQo+ICANCj4gIAly
ZHNfdGNwX2tlZXBhbGl2ZShuZXdfc29jayk7DQo+ICAJaWYgKCFyZHNfdGNwX3R1bmUobmV3X3Nv
Y2spKSB7DQoNCg==

