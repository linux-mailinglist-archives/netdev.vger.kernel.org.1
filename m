Return-Path: <netdev+bounces-126019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05CD96F98B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 18:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29881C217F0
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850481CCB57;
	Fri,  6 Sep 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cmxkH+PA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bK/42YcX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AF43AB7;
	Fri,  6 Sep 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725641377; cv=fail; b=lDZ8i9BwifY0QUpkxvTnmJqY+dEIZNyib5+pxf4HMmulqtvqslGDlImm6IwJREOktdYwj3Lzd3PGAamRbpcBD7nZbIJ7Nc5Zw6TKaZmcM666A2MiRcC1SsujJRstep1lnCV0r4klLb4POU7ls1662pOsoonJxKuqBMRfC+OOzf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725641377; c=relaxed/simple;
	bh=+xR9ZShxgI8zSBsciByeYnpL1sPz16w87ktV0Srh3Wc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FnBn4nGBAM+5j7SeKcQCP207ggo5oyFHy9RT7FxHoX+vLhaAjMSxfQlHFEbWdY0cRCQz5XITyT/HzU/mFNg6rJvIFHwGx+WSpim/1ed1nxZNR1TYRNEIX2aKeoZlxmw0fyOZwVZLR++69mwsdJlQk8Hf3v6vDfk/cwgM0dnIfiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cmxkH+PA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bK/42YcX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486FtqsW006613;
	Fri, 6 Sep 2024 16:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=M0pi+Wb5D/qBuR+ApxECYHr6l/z1AvHEBcjqbOdOVRk=; b=
	cmxkH+PALberzJuZFNMSHNwmwISuicS7Abz8+CxDHsCNblMXYM/y3Att2yOALA41
	UUf/nxP5JNoc0p6+jkwCoEhl2EhxiYKAYYtEkIYZJESXIpo7eYD92B0aC9QsvIrJ
	/nvyI7GCljG9+iGgXLd1wC0XPjHslFAcqMixWWsb6DjE2y0RNp04okxiTaKGjU48
	f5Z1U+Fylw5cehdgsejJxu46pKNkfFUqR5d0vcc/sX52hine6X/6GKpqUukaLJn4
	IJOn8sNxcMAtXpknWOIMD32h3ppUQyItxMIHbazDBPrPxjv78MDvpVBcqQAleulb
	pR+Nz3HpfF1EzKWvPItyCQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwqj1br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 16:49:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 486FFWbX017908;
	Fri, 6 Sep 2024 16:49:09 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41fhyh6e12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 16:49:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXHHtFaNp4SW8rMAIid3VTz02q7msjG+M0jskTYExA/fpyRu5MH3GQH+UUBOWYssI7otfQ5U/r/IyXq//sTYbdc15OWL1/JZ23d682M7PRBlI2dHk4v2Ev6SQiODo6KNpL/0IsVSQ03qbBcdg7oLzziLqSUPlCFp4SAsKkkD6PEAU/EIVJWtrdIg0vXG3TGiDq3W2PcX7plGo5l3GNEGjBWnUa0fnMVbvrstVQrnEjQWR6PR7tZhN9GpRPThpPBEZLUqjgU+SzL2aWnTJQIMdg6RDSGvd9iJ1Sv/1tGt0grAsj///hN5C4I21wX2vYW3zMIe/8gQBnqKKnlJJSDUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0pi+Wb5D/qBuR+ApxECYHr6l/z1AvHEBcjqbOdOVRk=;
 b=MfZ8tSDcgUsyQUrEjwWxKzgVEpklTGta1PylSWZEnDASXU7wHQpkVlav6uAAOYZrMbkjm76wPaO+w/jpuuRh0ZU3MTzIrkgQLtY1PBGwNjNcN8uqs+B2LhxXzU8erKMXZhIUyWoZr8cqloAKICioGHS4o5uPwPr8Bc3GO1ZS4ekwDr2o7iknaSEyNngxsj2c+fEZrX6rjy8ZTgxwjCGum3goV7ZmWXcS7io/P2vDw/L46qR4P5rl3UO9gX0BPbkAckfR1+ui9hrMZn4N2YsYTV2FaGtGEIUTvBI8KloEpDhat2bIT2gYYABEZHbS3bbMIJh14z4JHcFY6kzkIyyIAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0pi+Wb5D/qBuR+ApxECYHr6l/z1AvHEBcjqbOdOVRk=;
 b=bK/42YcXlN1d+QrPiaA+MinKuO8UfSk49UG9sjYejIDWEaHKJkVtJbSIA2jdlS3stYOoNg7gHgC5se/+mkUZSDHwjEeYn1xmmtyL9tEgVbQwJV+ebNBpIH8ZF7ruB/7HJ1FOX8fLISN/8WXVETZWQL4+4d2PaLOivmu1tu53uQg=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by CY8PR10MB6467.namprd10.prod.outlook.com (2603:10b6:930:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Fri, 6 Sep
 2024 16:48:04 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Fri, 6 Sep 2024
 16:48:04 +0000
Message-ID: <c45d66d7-64fc-4fa8-8c38-ab2e9ca65635@oracle.com>
Date: Fri, 6 Sep 2024 09:48:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <e500b808-d0a6-4517-a4ae-c5c31f466115@oracle.com>
 <20240905203525.26121-1-kuniyu@amazon.com>
 <19ce4e18-f1e0-44c4-b006-83001eb6ae24@oracle.com>
 <CANn89iK0F6W2CGCAz5HWWSzpLzV_iMvJYz0=qp3ZyrpDhjws2Q@mail.gmail.com>
Content-Language: en-US
From: Shoaib Rao <rao.shoaib@oracle.com>
In-Reply-To: <CANn89iK0F6W2CGCAz5HWWSzpLzV_iMvJYz0=qp3ZyrpDhjws2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0019.prod.exchangelabs.com (2603:10b6:a02:80::32)
 To CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|CY8PR10MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0b5e68-cf32-4e15-fcf4-08dcce93ad87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzFZVzYrRmVtam1PU0lkRUdib3RwbStZNWJkY2cybUM5aDhMWjNuWjBBS0Zw?=
 =?utf-8?B?dVkvd3Q4L3R0WmNhdlI2aFlwcDk0R2Q3TVQvUXZiRUNkaGx6aUF0M1BOZ2Fo?=
 =?utf-8?B?NzZnTXo1K2M5d0d2TUZmSThkWTFrenVIS0U1SVlaRmFCUWFmUWFZR050cTdw?=
 =?utf-8?B?ZG5KcVNmcFBHTjJubXQxT2VEdFZoN09VQkNYYzB2TVA3dm5BdFdXazB3OG9O?=
 =?utf-8?B?c3g1YmRzeEJKaXZzSUF5WE5POFNWMVNialVNMVA5QXlaUzJyN2ZTZnUxMENs?=
 =?utf-8?B?dWViUU5nODZhUUYrVnprNTg0UEhPUkhTcnlLMWh1SG9UeGNSUkgvaHduZDYy?=
 =?utf-8?B?RnY3SzJQblVDbE4xMHZtWWdEMWp5R3JwSWIwdDZuRTRZaG95Yzljb2xCZFVu?=
 =?utf-8?B?OGVTME81MUNwVjhOWXVMUS9kR09OMmJFTkdhM0o5cWVTL2NPK0IzVXJicWoz?=
 =?utf-8?B?cytBdDFRZVhxTzQ5RFZwTFV4bWhJVGEybzVaSU1MczMwK3BCVi9GT2IzWktt?=
 =?utf-8?B?enU5WVhEUm9xenVPNUlyNHRwWG1pN2hsa0E4dHhmb1Ftc2U5cEtxakRvVGVB?=
 =?utf-8?B?OVZDb1phaUNXVWFHU2hQa1JQRk5oSjB0SHJ4TGkvVllYMXhHTEpnbWV0K2I1?=
 =?utf-8?B?d2E4RG83NE1nSzJnQytCaXBKVXFINExQRkdIa1BQUzJXRjBZejRvcG5ReTNW?=
 =?utf-8?B?eitaQnVnOTdhb1lNVnhPQ0ZJaTVObFhuN3NNSmVyWUVLZmtzSzBGZkhlT2M5?=
 =?utf-8?B?TW8yYkljR01LRkdCdk96VTFScG9zcHcvTzJxRVpwNUU3QUV1MjFXaXRMYys1?=
 =?utf-8?B?Q1Y5c2ZXQ0lNRUUzcWVNTElHUUNVUjd4M243V1J5WmpFVjl4SXN5ZGhmOUZ3?=
 =?utf-8?B?WWtnaG55Wm9qMytWejdBa3VkUXJwTi9ONFB3bTNkTGtNMzAxMjVCZTVQaVJV?=
 =?utf-8?B?aEhnVmVZcjlvWGc0VldoUnBHeUVpdWJHUVcwcFNsaVN4dElnd3lLMzVUQkVa?=
 =?utf-8?B?SE9DU0ZjYTlsUlJrMTE5Tjl0d0VtdUs3R0QxRHoxak10RzkwRStRanYvS1Nu?=
 =?utf-8?B?QWhOMUtQL21yWnRIT0pwdnMzOTZjb0lDd05YSU00VitRQnRVM1JMdVd6UXVZ?=
 =?utf-8?B?RUtvcjlRbElQM0xzdmp1a2piUnpUQ3p5ajBHRElnNlA3Rll5bW80S3ZmRHpY?=
 =?utf-8?B?UEF0aG9rUVZIN2VlZ0UwbXNSMDltWWpVaGVETThBV2tHMVd5UUlyeVFqeHM2?=
 =?utf-8?B?RFV5a3c3b0ZhbnhZaFlFdTYrZVNqcEpUQUR6UG1Ja2JSalR5MktoWmdFVUNE?=
 =?utf-8?B?RjVML2FvaDF2LzFtRmwvSUNQdG0wbUhlZEdEVTBNNzdHV0JrS1B6SkRxSXFu?=
 =?utf-8?B?azl2RjRIeW8xLzZkYmRwbEtDR29NN21NbXh6eW5QeDNEZ3pockJHNFIxZi9N?=
 =?utf-8?B?aEVHN005bnhjb2lMNnJMOWJ6RUtxV0JscDZNaXBWTGlEWEdtdHNXUXBiMWNM?=
 =?utf-8?B?Z1l3N0xLQStYR0hFVWJQcExwK0h0M0RnbmFxR0E3RnZPNllmeVhUaVBnMURL?=
 =?utf-8?B?a3VMZE5hd2xXQUNydkZpa1BnWFg0ZDlMWStucnNFemQzWlM5V1pZeW1ndUpS?=
 =?utf-8?B?Vjc1dGwrWXJRUkNHNzIwV3Q0UlFSc3p0aVNlU2YzK1JLdjcxVnpJUDVnNnNa?=
 =?utf-8?B?aDVaM2MwRGh3M29OalBxL0s0bWw1czQwNEpGV0tBR1doRGVGQVpVMUJGdFB6?=
 =?utf-8?B?VHpPODk0V054NmhQMEJoMFhQTEtTR1JxRk5kNFVzVWNGK2FwV1NiZ1ljNWNY?=
 =?utf-8?B?bllTdjFXbmowZ3VNdmlEdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGIxMFZFdVJtSnc0M3JxelJ0bTJrTVYwUnVVYlExVXNBd3FSeEpJZXprRjIr?=
 =?utf-8?B?TWxGcXFrdXRsQUZ0ZjI0dTN1cGZSMTI4S0RsU1RMYjVYVFJTbUp3cDZnSm5S?=
 =?utf-8?B?b21DZVhPcnQ2dmRKMEV1bXhndE84SE0vYkxxQkRXbUdFY2VTc3U1My81a1BI?=
 =?utf-8?B?M1hnS2dLcEQxdVUxdmtyazJSdDBNWjc3VlpHdW43V0JpMDBnUWE4T1F6eTBK?=
 =?utf-8?B?by9keThpNGRBdzFrSUlOZ0hUYkpZZi9FbVVObEk4WjhwSERVeHpPUmxZVkpD?=
 =?utf-8?B?bTU3WFZLVlA2c2IwVHF6V1FncHhnZGtXZldKRERwZWErR05lcFlad2ZNUWRD?=
 =?utf-8?B?UENoK2ZmK1ZqeGZYd1BJTCs3Um43eGsrektiWDZXSlZDeEtsdHNML1FkZmdH?=
 =?utf-8?B?Wm44bVptK2kzeHBDd2JqUUMvK2Q4SThTTFFhYXVFcGhGWW9GaGwxam1zSG5I?=
 =?utf-8?B?b2F4bUdCSlgvWURibUljNmRjQW5tTDBvYWhsQTBnNllRcnc2eThIODFtd1F0?=
 =?utf-8?B?eXoxZUZyYUhrWWFXVHlNcnFyRHVxck9RZG9XbXBoZWRLaTdGQ052MWdkb3BM?=
 =?utf-8?B?aXlaVWV1MEcrdFZadGZEY3lOQzRNdXJWOEpSVFVjQXJyZTRVR29HZzdOWlF3?=
 =?utf-8?B?UDRLMllicEVOcXZqYThpU29OMmZrelRIZ1NrdzkzTTBQdnBMd2g3ODlFWDlp?=
 =?utf-8?B?ZjVpdHZxOVcvbTBWcEkyUUxxQVdKVFdWSnE4ZFNzTFpXNjVhejl3Z3RwaU5R?=
 =?utf-8?B?cDczNldkUjdJN1d3Uy9ESW5kQVFpVG5aZUlHNXBsQkRQc3BBOElSM2RhaGgy?=
 =?utf-8?B?LzNZeEpsUWZPM3hiVkJ2dTRReUJQN0tEdHJtMGkwSXc5MGE3U3pIdHptbVpx?=
 =?utf-8?B?eDNiSXFoNFhlWXR3ei8xdVBBOXVOQVNiY2lyYisrbDRTNkR4Y2ZFUFhXcDRR?=
 =?utf-8?B?dDl6WW9BM09XeWhqQ0toSW4rckFpcTZ0aDExanA0TEVJUFp0TUtVb1JVQW8w?=
 =?utf-8?B?UUlNck9RTXhPOG9nSVNFVnBad1ZZK0c5ck14M1BFMFJUb3ppV1FQbkh5UWNk?=
 =?utf-8?B?RGZWcWZSMThJcmd3bmRmdjlnSGRxR1lacTBvTEJ4ZWZDc2hrM2FwU2syemlF?=
 =?utf-8?B?TC95bXFGWTVVUlZIVHVlODJwdzRlaHUyYzQ2Q0tJeklHc3BheEVTTm5VVlhJ?=
 =?utf-8?B?cDdMR3h6ZkxmU0laM0F1aktmZzYvdTdXMzAzelQ2TkFGQzlWYWRYWG9oU25Z?=
 =?utf-8?B?b1oxcVF3aXo2cHgyNTNMZHdseUQ4ZisxVC9MUURJUG9ydzdNTjhTaXZQTkNx?=
 =?utf-8?B?algzTXpGRFo1ZWpWbFdqZHdaNFlhMm9PVXQxT080Mjltc2VTZlpkdWdId0ZN?=
 =?utf-8?B?dytXNHlKWTdGRkkvQnlRZXpPMmJLSHpSQ1YvdVVNSTdUclJBUCtTcFhKYkJW?=
 =?utf-8?B?SHdEOWh2UC80YjE4OG9Yb3FOZGdTTUZpQ2tyak1sUHEzZE4yNFpZNXExWnBK?=
 =?utf-8?B?a0c2RGJVSDN4UVhYT2hFWENSQ0cwV0k4T2hFY3oxNzlURk9UNkE5MzRLTk9U?=
 =?utf-8?B?Wnl4VlQ2eDdYUjNBRkE2aE5jR3Vub2ttV2doRExkd3l3MkJKV3dlK2U0WTha?=
 =?utf-8?B?UkJuUVBqamgwaE1tTmRnR3M4cW5NNExHZW5HK2FzL3dZRFlUMTEvb2x0d092?=
 =?utf-8?B?WW40MUNlOGRNcGVXcGdsemZ2d3VMWEQ0TmFOcjltS3BFRElXNjNVZXk2Qjlv?=
 =?utf-8?B?K1RucUp0TEs3bTJDUjlhcDVGczRLV2FLSTR3Z3VZRDZNRWs2enhUZFc2bXZl?=
 =?utf-8?B?QTlONm1uNWlFZHpXZW8xZElTNnJjVlN2MUZ2R0lab1M2Ull3UDJDRVlSWFAw?=
 =?utf-8?B?RytwSFlJZklVSVZ1ekNqSGlTdEQ2c09mVDVvUktRL2R1dTVwRU9KVHkrVWlk?=
 =?utf-8?B?bTRETG9iN3RmVVpWY3ZuanlTRGFZaHhicUc0ek1ZV3pEeWxQWjVjWCs3SWNO?=
 =?utf-8?B?N2JOU0pFSWZSTS9NMEEwTkljTVQxOU9oQ3VRQUMxc1g3ZTloVU0rVmtTYm5s?=
 =?utf-8?B?ZlZLZ1FhamVzT21vdURITlg4Mk5JWmhvMkNVQjJyWTRpUytBbGg3cmlQcFFr?=
 =?utf-8?B?RTZQUE04dk0ybjVSVGZpUkJMcXFGQVlXdGJWZVRrYkNPOGtjNnpkN0h6bnRZ?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4adMpoquTi7Y2YUawwheHbvVP15g2ydbkhLhnmgX+sXepSOiN8lwMSH+9o2I+4WvkT06xPdFXSToiaFkc+ymVvH+6fvmOLINgPoxan1fd+Wds2FiS2PVtzbzGRuYu32wUfvYXGTb/uf3M2X58ICiSgVFunnWWMtricgI8IsljzQj+1uWoLWJ41SIH5AKoAG2v8WhRWdDCRM2aN48X9bruqr56AguUdforw4Mz9yVDmzeLpPEvGRn0bCb2Gtwleez/CTZ6IXFwZE8Yi2Yh2gTKjyakEmw33jiPxb4Nf6jk2Mvnw+pqaF8cAARPILSimlCMUDfP555N+dPa22zrBDDhdkMOFTeCh/VU8qYg/69C5HyomQVweeFRGCiN1GFObyu4sJZlxQE/KmkulkAvFcEYmnj7Qi3q5IR8zxAgBLqs9bWC2GV7hU6cloIsfxwRhbvCOeoFO76j1Qgv3T8i+a7AzEcWNa48cWBOfkiwsDde6l6hG62k6pZYJHRTVCiNEwzldTB0msxNefIGfMnVunYPSVrNVuIS8ddn0W7BXRX9JPBoefLPFuXppqnih3QLukmaO7RnH5gq+bPckVgyr0hM4EFaBS2VjJsoCf+Ys+jRWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0b5e68-cf32-4e15-fcf4-08dcce93ad87
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 16:48:04.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ErqWIrwmkjdlXi5i1+sojFa5cyxhPEEOTkuDWx98DZkaBVvj4n2q9Z8neocTw/+l+ovHWyG2gZZJkPrsO9Zdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6467
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_03,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409060123
X-Proofpoint-ORIG-GUID: NlquDNtB6LMtLhGbem8wmkBnVykjp0n7
X-Proofpoint-GUID: NlquDNtB6LMtLhGbem8wmkBnVykjp0n7


On 9/6/2024 5:37 AM, Eric Dumazet wrote:
> On Thu, Sep 5, 2024 at 10:48 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>>
>> On 9/5/2024 1:35 PM, Kuniyuki Iwashima wrote:
>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>> Date: Thu, 5 Sep 2024 13:15:18 -0700
>>>> On 9/5/2024 12:46 PM, Kuniyuki Iwashima wrote:
>>>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>>>> Date: Thu, 5 Sep 2024 00:35:35 -0700
>>>>>> Hi All,
>>>>>>
>>>>>> I am not able to reproduce the issue. I have run the C program at least
>>>>>> 100 times in a loop. In the I do get an EFAULT, not sure if that is
>>>>>> intentional or not but no panic. Should I be doing something
>>>>>> differently? The kernel version I am using is
>>>>>> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.
>>>>> The -EFAULT is the bug meaning that we were trying to read an consumed skb.
>>>>>
>>>>> But the first bug is in recvfrom() that shouldn't be able to read OOB skb
>>>>> without MSG_OOB, which doesn't clear unix_sk(sk)->oob_skb, and later
>>>>> something bad happens.
>>>>>
>>>>>      socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
>>>>>      sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT) = 1
>>>>>      recvmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, MSG_OOB|MSG_WAITFORONE) = 1
>>>>>      sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE) = 1
>>>>>> recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC|MSG_DONTWAIT, NULL, NULL) = 1
>>>>>      recvmsg(3, {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 EFAULT (Bad address)
>>>>>
>>>>> I posted a fix officially:
>>>>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/20240905193240.17565-5-kuniyu@amazon.com/__;!!ACWV5N9M2RV99hQ!IJeFvLdaXIRN2ABsMFVaKOEjI3oZb2kUr6ld6ZRJCPAVum4vuyyYwUP6_5ZH9mGZiJDn6vrbxBAOqYI$
>>>> Thanks that is great. Isn't EFAULT,  normally indicative of an issue
>>>> with the user provided address of the buffer, not the kernel buffer.
>>> Normally, it's used when copy_to_user() or copy_from_user() or
>>> something similar failed.
>>>
>>> But this time, if you turn KASAN off, you'll see the last recvmsg()
>>> returns 1-byte garbage instead of -EFAULT, so actually KASAN worked
>>> on your host, I guess.
>> No it did not work. As soon as KASAN detected read after free it should
>> have paniced as it did in the report and I have been running the
>> syzbot's C program in a continuous loop. I would like to reproduce the
>> issue before we can accept the fix -- If that is alright with you. I
>> will try your new test case later and report back. Thanks for the patch
>> though.
> KASAN does not panic unless you request it.
>
> Documentation/dev-tools/kasan.rst
>
> KASAN is affected by the generic ``panic_on_warn`` command line parameter.
> When it is enabled, KASAN panics the kernel after printing a bug report.
>
> By default, KASAN prints a bug report only for the first invalid memory access.
> With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
> effectively disables ``panic_on_warn`` for KASAN reports.
>
> Alternatively, independent of ``panic_on_warn``, the ``kasan.fault=`` boot
> parameter can be used to control panic and reporting behaviour:
>
> - ``kasan.fault=report``, ``=panic``, or ``=panic_on_write`` controls whether
>    to only print a KASAN report, panic the kernel, or panic the kernel on
>    invalid writes only (default: ``report``). The panic happens even if
>    ``kasan_multi_shot`` is enabled. Note that when using asynchronous mode of
>    Hardware Tag-Based KASAN, ``kasan.fault=panic_on_write`` always panics on
>    asynchronously checked accesses (including reads).

Hi Eric,

Thanks for the update. I forgot to mention that I I did set 
/proc/sys/kernel/panic_on_warn to 1. I ran the program over night in two 
separate windows, there are no reports and no panic. I first try to 
reproduce the issue, because if I can not, how can I be sure that I have 
fixed that bug? I may find another issue and fix it but not the one that 
I was trying to. Please be assured that I am not done, I continue to 
investigate the issue.

If someone has a way of reproducing the failure please kindly let me know.

Kind regards,

Shoaib


