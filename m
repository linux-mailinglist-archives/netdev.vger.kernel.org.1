Return-Path: <netdev+bounces-290172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLa5BR1UDmrJ9wUAu9opvQ
	(envelope-from <netdev+bounces-290172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE159D58E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 707ED305635E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FC1225788;
	Thu, 21 May 2026 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PvbLFH0/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MeZ6tRB5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466823E330;
	Thu, 21 May 2026 00:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323904; cv=fail; b=J+gUc2q/wkm/o2SdY15T8UqYDflk35FOMQg3w28k5DhWIaas3uXDRW11SaL8l8FHRkm3RCFKwnAiYzoc0io04KQCFxEfpgYG5FENVNYGIn1QvQ6n4GAsPCtlDCaBtiwPR94x1K/ZmTZ/Doh+6xdLlbEhbMOptfTx1dJzIyJepwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323904; c=relaxed/simple;
	bh=B3FDU8jmrOtyY854LGoTm7H5C5fPA+m+273OlJmBjpI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jVantZZQSXvFuZ+fDvpM3OFHFj6Rbo7LKafx21kOCmHbDBdKUGLdbjr290r8O76/+umnc5rcfn1Vtl3mbGKDllqdCVj6ORRzZ6vRmSv7ROfOVt/PcrmIt/W4M5JT7sJ4rWxPYlxEz6weGomc+ifCgY2rsujHygrk0+jfRZOCQaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PvbLFH0/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MeZ6tRB5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KNum414097335;
	Thu, 21 May 2026 00:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NbUrgrlrpcF1dhwKlGU8EHYBpbutL2BQjWz/8xgjxdg=; b=
	PvbLFH0/Z2QBP34mItLOuS/tUZ/Ir8qLCVcBL+haddjM4Eks+keYVw72H+MJyp6i
	2KsPL2x7Wt/hrb26nbp0nJi3dM/Wb20WwEc4V8o7IhUdyITvjQ4m+HWKNgcTxbsr
	jj5q8k2hoZFy4FGNdvIeixij03bhuC779T+UXrpRJrXmYO8cCknezozGsCoaWFk0
	DgNz8KeIb1vGe7EYeUZebKGYDZa7i6lVsC6ha3BsD6lvxBa8gOMVt6F1jYfQTAQq
	mS30biLCh9xs2sSmVosDcbqcxIPERCd5Bv5Tews4kPTL3wcbkHMPReY+GjlUVFIP
	/n3kyOZDHH1fDQVuTl4ONQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gyx8e45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 00:38:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64L0ThB9019543;
	Thu, 21 May 2026 00:38:04 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1cvus8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 00:38:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cF1wh/q8lNtzPhYZMweshuXIJIkw3TFjUSZBh4oZDnxAbu7FsKvEuro8loXEMaabeguceg4IMpL+Qa3gK/BzDf1Gouvey75kjp1USkivxkS1/j1B/0DEskNHORGk9tUCq//E7MA3NCERnGW8nRMCFhCqZ9hkDj/Z4ni8vNJPzgwwLFhgrl9o41vlwNcDoU4HRsI8n+zoC8OTUBS9UC406n3Jn3WmBz38lhj7JoSFrtMHteSfei65jZpvIxBlHRwFvsf7WzWAxSV4BQ7WO1YZ4kqpe6K0vAIrRPIZzCponIpMXFqly5sB3gymkzUWEV+zmznbNR/p5CvO4CF3WTExDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbUrgrlrpcF1dhwKlGU8EHYBpbutL2BQjWz/8xgjxdg=;
 b=TgDPk4kOIsx640U4FPPTcowTZdeGBZMWZGdR1Qfn93MaAWwio4Ac58ASiVtSjx7PqKtrCAFX4y9bhDEah/DX5W6NUaPVFs1eeyBvYUSuiHpjrovr7MLt8qWAu5ELaSh2wdENeoJhl10BT905Es+cb5BLjgGJOFLs7q4PtDajKVPgmA8LU4YFwmhbws3ZjowEJ+D57mzcJvqmDA9EdBbsYSiRMSs+DaBmgyMtQ5RT3Tms71B9xdvHEirQQdW7q0wlJmV+DqA4BCzpkZz9LO7z1zM+pd4JaRMO06v5pBrqfLbxjQAZHIuUZe4UfrWA+MtoDFq6RHrCI81SAMm4GQI+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbUrgrlrpcF1dhwKlGU8EHYBpbutL2BQjWz/8xgjxdg=;
 b=MeZ6tRB536fqwccU2Zs97IFzU90+FgbSrUfwZI92XcsWA1BMKIQMEDcE1vW/nOQHKiZP29OGHBCNoN09FXcE78Kka83mDc4g3Jityi1RnpO9lQh6T5GXA9+I8M0hwZjxwCPe4y85iw/me0w0kKYFc7q9J+t1QRSe+obD+fXr1IE=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by PH7PR10MB5877.namprd10.prod.outlook.com (2603:10b6:510:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 00:38:00 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 00:38:00 +0000
Message-ID: <3f4460b0-fd07-40f6-a9c6-827dd0ce2ff8@oracle.com>
Date: Wed, 20 May 2026 17:37:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tun: free page on short-frame rejection in
 tun_xdp_one()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Weiming Shi <bestswngs@gmail.com>, netdev@vger.kernel.org
Cc: jasowang@redhat.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, xmei5@asu.edu, linux-kernel@vger.kernel.org,
        Si-Wei Liu <si-wei.liu@oracle.com>
References: <20260520160020.375349-2-bestswngs@gmail.com>
 <willemdebruijn.kernel.28580e8a2708a@gmail.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <willemdebruijn.kernel.28580e8a2708a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|PH7PR10MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a88fa9-e65a-43e2-8b3f-08deb6d135e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	8Fi9hk1H49vcUPiU9K5AR/PBhSTNgRPZ43/x7VvpucAFdohBAv5iWD47PU8jQEQYBOCGpQpuEkhOqymWSIGHQzcZmn+R9ksdJVzj1lvblrHE4sJtahLY5sYAk38mVqtTj6+s8lfJykPLzLBntc1xL2r/YhmV6G0/qnyjnln2UPRG5DpthMfjLJ4FL6TxeTaWxTtlKLE/eHoHXO+zM4VhMb3KpXt7QPCEfvpaq229sOgD1zX3Cjw4zTSYGmYd7K/VQrqFKYVXls84aSdc0mKjGoXdz05BuuPDnaX65qzdOI7PxYlhFkHYT9GMhbn22E6C1T82FYSX2/VaDGHccbksMUcA+PgSWT6kkvPcDeIJJugQOTWznLzA+MwUd2598jWL8GNW8V3ChjZURFRK4X+fGz6dmgaVWFE9KDksy7PMqCoq1VGuEDO1QLwSFEMVmr6iC9pQJ20rCl0Yh8kCwxbOfjJfqaC4eBOGDzckijngIWgDaJZ994zfciP/1D50GvJpEg1i0U2Ttt7Mu++1hmz596xLmIZQirhVCZ2+UJOP7vkcKoxGmQRj84+Gdt2PO2UWusoyO2iBMTLqUC0SU/G+Elo49pGRMHz/RMO2desrYlkEu1ZAOEPYfg0zwaXyudfG8nd3TZo7JfSCOzndSNOnZ8cSePDaG9mR9EZxJ66kbfRKNAiMkTiDcQjvRo1EV/q4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDZKZ2NRaXY2TEwyR3RTWTNJTlI3bEtqeUhaM2NmbG5pdDU5Y053QU5Dempi?=
 =?utf-8?B?Z3RQVzVCSE5uS0Y5T04wRTRHc3ByUEJHVEtQVkJaY08yUlpzZWdvaFZTVDU0?=
 =?utf-8?B?N3EyckJrMDJSNWZRRFVTYkE4eEo2VGdHYXI1R2Ixb0djeVJaOVdZRXdPYkFw?=
 =?utf-8?B?bWJNZWN3UVhwc2ZlR1BTeU5xcHZZN2FFOHRob2hNQTM1T092K2VKVjIxcllv?=
 =?utf-8?B?Rm1BdXhaZ1VpdTVYUFkzNENGbzFQcDhTRmpyNTRtNkNjL2NtWFZJVk5JWCtE?=
 =?utf-8?B?ZldkRFdVTW9kbWwyN1VVUXJpblRrcHdPaXVyU0VLb0ZlSEowbjE3Mkd2ai9L?=
 =?utf-8?B?L01CY0drVFVoUUFjeFQ2MThRVUllUnJ2cVpoRC96bGlEcFJnSkdoaFFGcll6?=
 =?utf-8?B?SUlCSWN0TEJacS9abjNSTUZqU0hMbW9qZm5DZ0FaZUtwUXdtL1ZVbzNTM25h?=
 =?utf-8?B?Y2VSOCsyWVhlK0RrNWZSei9KNjFoL1dqRzU2WTMweWUzbzg3bGxiaTlHRWVP?=
 =?utf-8?B?RVVKK0l4MFhkUmJVV0hETWpJSVllWWhNY3VlaVYvZ0tzMTdwQXR2QkhUOFVt?=
 =?utf-8?B?UkRCa28rVUo2YjdraWZXeVlQZlUwWmZuNEFQWXBmK0dKTGhxbGUxanQ1Y1FR?=
 =?utf-8?B?TEZ2N0hKTk53YTlVMlVnS0tlTWpkRmJmUlFZemYvdXp6bXpWZzFZcDdqWXFF?=
 =?utf-8?B?Mjh5T3ZBbkE3dENrbUF0ejFmQWROcXNJUmJ4SXdUN2t2cWluQ05odXlrYnlU?=
 =?utf-8?B?aGVIeEZHQ2tHL1BOSVlmNDZGOFp3SnlCTlZDSHRvRTE4NFpZWTNXTGpxVW5j?=
 =?utf-8?B?RGw3Sk1jZnd6MkxVNjBLZE1qclpPY3VKaFZaU25aRVZodC9DeFRrREk5aUZ0?=
 =?utf-8?B?MktSRVljLzRkZVlyajEybyt6VW5JL1dqOHlFdnFnU2pjY0s0UWl3VVArWk1J?=
 =?utf-8?B?TzBxeEw0OS9veVRpeVh4MVVUTU4zbE4zT1Q2Q1NyK2NwL1dEQUtsWUVzNlJG?=
 =?utf-8?B?SXVRMGRINWxhZG9TQnF1ZkxCU253UGd5SlRtUU95alQ1S1ZiS0JDMEVxOXRT?=
 =?utf-8?B?WkFDRUdydS93NFIvdzFrR2ZrZlVuN3oyMS9pcmdaMDdFT2xDbDNtNXpOcjhC?=
 =?utf-8?B?cVgzaTRhdVl5d0N2cWdtVG56VHVsWThaLzFSUTVyQ3dKdERqQmVlUENCSnRp?=
 =?utf-8?B?M1lhR2RCcFpGRTJvMnhiYjBHeWY2djZBWFhDRVN2MEg0WE5EVlZ1U01Qb29I?=
 =?utf-8?B?eW1oTGVZZ3EvMDRocSt5bUpIY2sraC9YT3EvN1JGWklENFVkeHlGRDZyK2dh?=
 =?utf-8?B?d2VxM3VrYTgyVzI4SW00UHhYZDFaS2YxN0dwSjJiRTJwNzJqMEpIdGVxSjdo?=
 =?utf-8?B?Q2dNakZtUDlLZy9tUDVpdkY0Uzl4NVdMSHozeHdUa2w0NHBjYS9qNmdQMWl4?=
 =?utf-8?B?TXJ2VWRMMkNwZm1TM1dSZnpwSk92ZGhOa05VWHIwaWM5bVgyN0E2VzVwbXVj?=
 =?utf-8?B?OW9KZDRINWl2V2duWTV6L1FmcThjRmhSazdlWWw3bmEwTStEK2JMY3ZUQ0Vs?=
 =?utf-8?B?MkMwbUlESUVmM1pWcDI0M1Mvc2phcjBOZGtLUG9PbmUvUk51bmxKL2RXZVZq?=
 =?utf-8?B?OGZpVFZSMEh0RUltMXV6NUJKMjRzbDdxQURuMzFVeHNja1p4OHNLWFYrNjZh?=
 =?utf-8?B?SVE3S1lvaDNwbjFUMUJxamZDSWlTY3ZWdzlNcnJKaG1YTCtXd0dUMnRubGNi?=
 =?utf-8?B?ejcvdUhBdVFMMnFMTmFXM1J3L29EdU5abmxkb09OWGs2c3dPcGZsdklvREZT?=
 =?utf-8?B?Z2cvdEduNndCQ05DNjEvd1cvTmJVem92TWVVUHV2WGg3cjJpMldFMmU1VkV6?=
 =?utf-8?B?RDRlZlkxT2dhb0ZmZzVKSGRTbmRPK0Q4cFZPa2duazd0YXZFb0kwYldiR2JJ?=
 =?utf-8?B?SW10S3pWby9rUW1LWG5DNVBkeENDSWZMdlRkVERFRlZzWDVzMlhINFpRQ2Zq?=
 =?utf-8?B?OCswNEp3S1kzRThIZmVLL3lYNWN3V3FkaWRYZzQvWVdNZzVVeFhnNVhoTUMv?=
 =?utf-8?B?bytEbXhMRnN3QXRZMEQzWEVheGVNeGZCU3F1RmVCeG1jbFN6L2dIekRQV2Jo?=
 =?utf-8?B?dmc2b3YxNnBMbDJJZHhBZW94Zld4VEJGMkZIankyWExRSWc3ODVxVVhtQk84?=
 =?utf-8?B?Z09wUzRCL3RtYnlEWERPcXR0ZjZKUTZ0ZnFjeTZSTERaeFBObmxpREVpZDVa?=
 =?utf-8?B?enZkbEtKWC9TY3RDUnkwOWM5Z1VKUjBIWkpZTDZhc0d5djJFWkVnTEV0dlZC?=
 =?utf-8?B?c1FBUFErVDNLcEU2ZTluclF1WFR4cE9KM0JYT2JVRER6dU96cE9Edz09?=
X-Exchange-RoutingPolicyChecked:
	AOEk/l4SgFwABvL1TfnMmrFMKBj53SrvKsgu9OELM9A44d+YN4+HDUjF6vYDSvSuu58VocBi+em990MMpoilMUg3YuVDv/1nAYNSeBMaTB1PR4qZ6vYMpHGsnT3u3xriVPFXpcKly3PaIzR/oHOggLsKoVTuIFFJ4x73T/ajIjSGBOmLTtOKrw0rwVsPsYC8azzu10hR0TQ2ntwfB0LG7aXKgij1FFe1W2r4fY43kvdcqlZe7xh9eRRHhg29ypZXkuMxRv0SRQfmTTHedwebcakXKkwf08oN7luynUjdFdhpQyKFgYlxtJHzsRbdACD+Oaqg1MIZsrs3M3yN6zCq4g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4jtiKgWI8lQ5iF6s8aKsYw1cRlu1r4gn/G/ZDPerIjYDQ5xhH+xnqgGrS1GX4OTj5RmoaT9O10Zoki6viSSyu3TOHm0bTR0I0EAf4SRTTl3Jc84NtA11B7QyU9lNaEvZuxBt5NKKNu8LnJqRrHeLbNiWyKJEHAlcoamrrIskJ3PIRxtuREi8yBccW9eV56PRdPcu6NA+mecwABo6dERLIk1eIvelNOKtGmV0SI9fcfNVTej1xDVKqIwt5/KwP/7Zuaw2BmtB7E7AX53hTc737Jt05pF3mwsLIEUsZqP6SeDcbxgeJEiADNDYnsh8rD/svNMYlqr7OnLITY9m5OInaGqYJfvrlYfhQUepYdg7vwzrLg1MOq233tgcZd0ifnlnDT3Nfr3iR0Oco7KEqp7RnW5rzw2EKL8Uc9zUCcK9H+oKZm72Li4cIqsGWeNDiMci/RqMkVDF7Ft7NF7CERcbThmZyRsgwyNJMLrVTDDyv7P1WQFccCTwaAGAcZHsBnrlMLd999s99QzTtR1vqbQIM2eWk53ZtofVLhTlBSVhDIe9oUB70xRoLUHNIVihu+2fxrs/vp0cV5Az2XeS6PJCr9FNQnkJQf7+XLHfgFdhr4Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a88fa9-e65a-43e2-8b3f-08deb6d135e7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 00:38:00.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3CXMxBZatAwS1OJ0u/gTWElWAmzUABl+b+mbfNU27J1T3Ccyls6grj8oS+S1iY/bNcQwJBqQciWn4H76lT4tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605210003
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAwMyBTYWx0ZWRfX8gjHNgoPBDTV
 lP1NObJlaCsLqAVHp4Xk59934cKYkjmiUmPb12rs+znwitaTLmrg9/UMYS4psjN++aEt7AA513I
 ivdk3GGJrthaiVzo8LxMk/bYfBFBa/DUhPBxdQOz8WOBKLqUYjvdIuhsv6Oh1+x63kMDexHSB/P
 vrPB/CXE8Zf6o43SArcQTiB1U9LVZJBvHobLO7HBJHTI98Hw3WlWZbhniB6l2JxdTgYBGyKqd5N
 8aXbOlQvWIIEfRZH/vpuYtwEUe5SWL4L1tIEYYTmcszhxGkaZdZWZYFB4l3vd3R/THXa+tzeRSg
 qBChc5uw36I9yOJLzY75Dg9Lq4HTaXP6HsF9kWFSQHfge/74HH18ver1MOUnSHv9nrgJIteT9OO
 8niFAGCm4UCmgwI3eYhEq0WFS21k1DFRawkq0tuoXjCK8gOsgnunIg8mLUdzHqiSmxw0DMf46Ne
 Hg47xemZpMGvPGAoF0A==
X-Authority-Analysis: v=2.4 cv=Ls2iDHdc c=1 sm=1 tr=0 ts=6a0e53ec cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=pGLkceISAAAA:8
 a=rzmVX9KthHfreSARo5MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _FeLHCV5xg0vVtDuED_QK2Ic1uOvJLMj
X-Proofpoint-GUID: _FeLHCV5xg0vVtDuED_QK2Ic1uOvJLMj
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290172-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:mid,oracle.com:dkim,asu.edu:email];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongli.zhang@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 81DE159D58E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026-05-20 5:05 PM, Willem de Bruijn wrote:
> Weiming Shi wrote:
>> tun_xdp_one() returns -EINVAL on a frame shorter than ETH_HLEN without
>> freeing the page that vhost_net_build_xdp() allocated for it.
>> tun_sendmsg() discards that -EINVAL and still returns total_len, so
>> vhost_tx_batch() takes the success path and never frees the page; each
>> short frame in a batch leaks one page-frag chunk.
>>
>> A local process that can open /dev/net/tun and /dev/vhost-net can hit
>> this path: it attaches a tun/tap device as the vhost-net backend and
>> feeds TX descriptors whose length minus the virtio-net header is below
>> ETH_HLEN. Each kick leaks the page-frag chunks for that batch, and a
>> tight submission loop exhausts host memory and triggers an OOM panic.
>> Free the page before returning -EINVAL, matching the XDP-program error
>> path in the same function.
>>
>> Fixes: 049584807f1d ("tun: add missing verification for short frame")
>> Reported-by: Xiang Mei <xmei5@asu.edu>
>> Assisted-by: Claude:claude-opus-4-7
>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>> ---
>>  drivers/net/tun.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index b183189f1853..f594360d66d6 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -2394,8 +2394,10 @@ static int tun_xdp_one(struct tun_struct *tun,
>>  	bool skb_xdp = false;
>>  	struct page *page;
>>  
>> -	if (unlikely(datasize < ETH_HLEN))
>> +	if (unlikely(datasize < ETH_HLEN)) {
>> +		put_page(virt_to_head_page(xdp->data));
>>  		return -EINVAL;
>> +	}
> 
> Make sense, thanks.
> 
> The error path from tun_xdp_act does the same. And the default: label
> used to too, before a batching optimization was introduced.
> 
> Is the same then also missing if build_skb fails?
> 

I also agree that we may need to handle build_skb() failure.

In addition, I think we may need this fix for tap_get_user_xdp() as well.

Thank you very much!

Dongli Zhang

