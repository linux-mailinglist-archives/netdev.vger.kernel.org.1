Return-Path: <netdev+bounces-245172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD5BCC8659
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 16:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8195B3063C1B
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E589337101;
	Wed, 17 Dec 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ezH/7BJw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qsjaAH7B"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73215ADB4;
	Wed, 17 Dec 2025 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765983745; cv=fail; b=aZ7H6PGsKmvyh4mj0nNulGlRDA3gN6VjseFTgLB07HKK0XY3dDvYqWINEzIY9lpHhKm0TNOmjOvlhMg4j0d0XXDWXRAu7StKvijssWygAn4y1uIxouWtzpfLmTP2b4l+mkRAlKGEQjXq9gVEnJyYWY1qIWTn8lzvbJOjO9QNo9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765983745; c=relaxed/simple;
	bh=FhnjEwTPcdJji2oqg2gJhij9YkfRtdzI+TW2Wx/PZgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f7jeMNJhbvZJRlbIdiaiyjh1D9dCnnzW4eNiJVSCg+SDGeIx3QfNhRB/yoatmsnisSqU++2Ap6u9V30LO19DcIF4MHBmgxvlnMB7wrhd8BCAigf7drchj2EvWDty+AySN0h3OkyQjQKM+hlEuUOVwNbmPGEu75pIUrf3R/NM5ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ezH/7BJw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qsjaAH7B; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH6Nd3h2183654;
	Wed, 17 Dec 2025 15:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JNQbhP0qZ0RZeQUoEO6hdp+btpLg1C1wc97WGvI04Uc=; b=
	ezH/7BJwQqohOq5kByjInuGv99MnB3kiIxAoYNzfZhtT4sC6OxPVESpNhZl/l/eD
	pHxjq+i+YF/s+0tzeewfawk55aOU9qPf6dJ3esZGxsRJzKBy+6bFbviRrW4YbOyC
	ltGJ2InC7W/Z1sDH0LCkTNwMY7Oj9qWsZNentLdX14fpC8yT4m8/t2Hj11jXsp4w
	lnpKS/itx0iVrz3xWKERd09I5IAlunZ7x0wt9wE2qrXaIuUbOfVyNBkBfkM3qQR/
	i4/ZeoKqZecsdIEc7srVIOE4oTxfLQ/sqJpeDtMLOqtl5S00orwswUOlJA/IMb98
	VH9YJKVeGp+zuAoyR7ehuw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015x0jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 15:02:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHDUY3H016413;
	Wed, 17 Dec 2025 15:02:09 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkn5ptn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 15:02:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odv7YfNB2mE23WGpCByZEakRHfJgh2/W2NlGRdY/WdvExEsNZ1uJWW/8qpLvJsUDjT17Ayra96kGZ59jqZMrabsDUoryYVYOr4DRuYP8LdBKja20GpvJDc/xrf8CX4LsH402/p8SudyxaOap9Vp5WiqlGUPWPfb4LmA6BJ6jLPaKnvurNjwPdJ3buelnUJWPhopjtWLz2PaHoDTiezGCu6j/EQ8htIi9Ynj+5JNRoEl/N6GB5ZtDKDm2/AuehVnPv8c57kR1DMZPsSNcLGzmMg+gMfpcvCLrMT6j0ETNKGeuxsMEP0/31vKn8BA5o0QKhz+zJm7YG2ZXYGFk5kmZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNQbhP0qZ0RZeQUoEO6hdp+btpLg1C1wc97WGvI04Uc=;
 b=SBC3z/I/l/gMCPKlOMQt27zEIaLeZ3ptXDdY9whvwECQ6zWaBmpIqwNG7HgLJneSNmg/FIZ9f+p2Gk5ciuzcVnQuK24ef+8TjJoXFp4OGiXcxkr7cVAVpJKEENWAFGC4WbmKdMNLFlT3XZijePnvuzSDf0E6/3tBbYFJlvHNUqd3ajkqVorOQwagKH/7pEPkCTYd6DQdl4dcG68unkp4ZeALsBojkcGhZjQgtuk/JYbt6lYK+71hfjLwVKoSweEmIC9+zMl54gA1+46lM3OGDHop76zKoh69OQ7/xDMWYAbZuhRqzITFDRrCpEOXZ8riZdxr3jT94yw9YPc/4wSuVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNQbhP0qZ0RZeQUoEO6hdp+btpLg1C1wc97WGvI04Uc=;
 b=qsjaAH7BF+hRXEMoEBrpfW7BQ+fB1eT/ZQ/rccAe9mSZo1OWpLJ33OKrD+9/7FCQNBk5o4Daa1+0PT1RF/7XzhYSIZBqK5GalD57VkbPPiUjikYkkyHDO5OIfXSEzQI71EvYOqKrZYMNuDbkkDlRSMNiNzzL8oL+Ljz5i2fF+gk=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CY8PR10MB6467.namprd10.prod.outlook.com (2603:10b6:930:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:02:03 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:02:03 +0000
Message-ID: <6d508d6a-6d4f-4b78-96e0-65e5dfe4e8f0@oracle.com>
Date: Wed, 17 Dec 2025 20:31:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [REPORT] Null pointer deref in net/core/dev.c on
 PowerPC
To: Eric Dumazet <edumazet@google.com>, Aditya Gupta <adityag@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <q3j7p3zkhipxleesykpfrfhznasqnn6mnfqlcphponzvsyavxf@a6ko6obdpso3>
 <CANn89i+8hX9SjbhR2GOe+RfEkeksKCtPbkz-6pQhCA=pjnr5zg@mail.gmail.com>
 <CANn89iKUQXmR6uaxVJDi=c3iTgtHbVaTQfRZ_w-YsPywS-fHaw@mail.gmail.com>
 <CANn89iJj_Vyt2g6QewwaNAXAZ+0iso=4yj0t3U11V_nuUk4ThQ@mail.gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <CANn89iJj_Vyt2g6QewwaNAXAZ+0iso=4yj0t3U11V_nuUk4ThQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0275.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CY8PR10MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bfb5e9-07b1-4dbc-6a6c-08de3d7d3ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFp2YW42c2N5ZlpDbVU2VDZYc2VhSllrbEdPK0JLQkZLcjkrMW50ZEJHKzB1?=
 =?utf-8?B?d3U3MEJtM3NkZmgydGh4L05zMStvZE5RWTdOWGtadSswSCtzcWFuNUt3bkdq?=
 =?utf-8?B?TjhXdnlsRlVaSUE0cmp4YVBsL3NpTm95MDVVMHkvYXNXUS9CMWoraGZ0MitK?=
 =?utf-8?B?YVBmMENNL0lJcHN6U05wdnFZQ1ZTVFY0bTBQVTFGeGJWa0wwTGVrTHYwT2tK?=
 =?utf-8?B?cFl5cVlTclJGSDZ5UFR6UWZsZnlxZlRVZTdIUUZHb3k1eW5MRWNwN3k2bE9P?=
 =?utf-8?B?ZGllUDBHdElrVVBxMDA2WXFqOEtQcWNFZlY4andoeVNUdExNaVo0bjAvbDdZ?=
 =?utf-8?B?VEwrY0FvVTJNTlNOclliVnVVQW1nV3RtaVBrRnZRTWF3RDZTRVl3RDM2NFk0?=
 =?utf-8?B?SzVvRTdIRGxIM1JVMWtCMkUwVXlLUDVkTE9YaE94NUtLaWJtVEtFTEtnOFhC?=
 =?utf-8?B?S1NCVE9KWWl6L3ZTcitLTURlUktIdnBBbitOOTRaTzBrNTBtZTFrT1RwZ2Ex?=
 =?utf-8?B?LzhGOS9zQnJRSi9kbStKVTM2aStjNzNxTUx6Zmw0V0wvdEdWYTZ6bS9TcC82?=
 =?utf-8?B?dUt5NVVvdUd6ZzErQy93aFRYeFkvMEZDR1JUTHM5b2h1Njd4YURPSGpKbjhF?=
 =?utf-8?B?azNBNEVSTWVWeUlqNzBVSkY3UWRQWlliK2VVUjNZWEw1Wm12SXpiTTk0SHdR?=
 =?utf-8?B?Ti92c2MzTGpXMWFIRWpHeVJpWkg4bmRuRUdwbStIMHh2cXZvQUhzSEk2a3JY?=
 =?utf-8?B?NkxzNjQ5aElVL3JmYnZBMzl0NldiMHJYbHgvMjV0cE4rd2lDS3oyL1RyR0Vs?=
 =?utf-8?B?SXRjYnNCQnpYTTZKMUovL2RqVlhlczA0bFpXVUdXeGROWlplR2dKVDh4bGtZ?=
 =?utf-8?B?QXpwRnpvbW4vUHpCbWNlSkpxMXhEN3lmdVNSNnV0ZjY1bXZoYUdhKzIvQzE4?=
 =?utf-8?B?c1creTRDZEE1bHEzamFCSHMrWkJuZk1Gb0Jjd2dVNGlIWmlaTC9BKytLQVln?=
 =?utf-8?B?L3I2VXBrQmRRWnBvTktmdDlRWmNGTlQwa2tNWm1EcTNrZjZHNGNRcEVOcENL?=
 =?utf-8?B?NmV4YXBvS0NhV1FNRElpRE9ZYndFb003UG80TzFVbEgzRVFxdVV1RlZPYTJ2?=
 =?utf-8?B?OTRQOGl5WWs5eGFLeWc2OE15ZHNGS1VuM3NkYnVkZWdIMW5UdW52NjBQREtP?=
 =?utf-8?B?M0JWeGZYYzJQU2FMdXFvdGJqNkNmMVFWNkJwZ05ob3FOTldtZXBFZTlPVWZ3?=
 =?utf-8?B?cVZaelFpVkxvem1Idk5jbUxVTkhNSDVZRlJBbmtkeDAycUt4ZHZlNXJZOVR1?=
 =?utf-8?B?dnZ6cmdFM0tEamM0Z1RKeTc4NzRQM1BvTFJSNERxYVFqVmRBWTN0MGR1UGV1?=
 =?utf-8?B?Yjc4ZGtvS2JWV0NMVUh6bzZNMzZvOHA5bUJ0YkdrT1JJR21MN3l1Z0JPd3dY?=
 =?utf-8?B?aEk2cUFIOC9Nd2Z6NzFLUTJmeERxd1J5VTJkRmZSajIzbmxkdjlkSmNMYWw1?=
 =?utf-8?B?VWVMbDZ0cXNOVGNOK0Jvc0llQ1FqQzk5bkt0dWlLTmpMM0MxSk9CVEZRZTQv?=
 =?utf-8?B?NTI0UnRNZlcxRTd3TmxrMFByTjMwTkRPc0V2TFhHd1V0QmNMd0F3bTJKZ3Fh?=
 =?utf-8?B?aGJtOWVGNm11cWdzUENObHNqS1RIK1B0azFweWk3cDBpUmZzQTd2VUFSWklD?=
 =?utf-8?B?b2JsSlU1U1VCWFNCdk9HZWk5NlEwV1ZMRjUvUzNHT3o1Q3FEclZKRXBNeDJL?=
 =?utf-8?B?eHBzM3gzYUdaODFOV0tXU1VENWx2MlNrT0doSVFEekI2OWRoeWZTaXV1Vk5T?=
 =?utf-8?B?NGJKR0lxOVI4b3M3T3dPTEE1ZUlZaEEramZBbXJYK1BDMlhZNkhIZk8wRjBu?=
 =?utf-8?B?UmExYnRJaEJXeVZGeDA4NktER3ZkY3lrMHNpbmxFYkVWL1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0pta3JrZEtscjZFbVcwU1VVcXF2a0hzelNmdjlFM055ekd5eVQ1N1I2QWJ3?=
 =?utf-8?B?NXp4RnNqbmo0bEw1NDVtSCtoQjdOWDN4Nm5qcG9GZk1lSjkxdnUrRTZ1K0FF?=
 =?utf-8?B?YnU3NndieGYzZEY0VTMwU3BzdFppYkluY2NuL3FrbDRMQ1JlcDRVdHJPRklI?=
 =?utf-8?B?UUd5WVVDR3FMNUNJSzNlR2tGRlBpT3VaeTZ1djBiVFFpSDlPbktNY1RQbTFT?=
 =?utf-8?B?dkJXdDg0RFNQRUtET0REeWQ2dm16N2FyNlVVUW55N01YUzAvbWt0YU1XdFNa?=
 =?utf-8?B?OGJDaGtiSEJUcnZWekVnSXl2Z3VjK1RSUVJlbnN4cWYremsvY3lWWlFYUnQ0?=
 =?utf-8?B?YkNzWWtLbjRIMnV6SHNsRkU2dlNQd0thSmozbEJab2xhVVFnTW9JenRURWVt?=
 =?utf-8?B?L201NXJ6ZFV2U3VydllRYVNzM3IwTmpJZ3FVTCtlNWRmUDBZb2dsMTZzcEta?=
 =?utf-8?B?SG5IcDZuOFZNOGl6RFJ0dVdRUjNycFhmV0duell2YmlUbVJMTUpjWFpMekZt?=
 =?utf-8?B?NzJFNmtRQkdvSlpjUFR4aUQyNDVyMTBpRVQwZFRqVDl1SEx5RDBLRi9oRmlu?=
 =?utf-8?B?Z1NMc1pUbThZbENjN3lrcFhqVVRlSTF3VmZZblJqVFdtdzhFYjF3YnI5Y3di?=
 =?utf-8?B?a083b3ZBUHRYLzAzKzRqSnJqU0RtbG9VVG9Yczc5T2dFT1RJa2J2SVMvbkRa?=
 =?utf-8?B?RTM3ellKMS9VK3ZobUFRNlZMbXFRczBCY3pOdWJhRTVNcEw2QWlZZGdDRWxl?=
 =?utf-8?B?SGorWHp4OWNLNGZ3S0V5T0ZNMXFKYUh4RTZmYzVBQlF6eFBmQ0JDVFhKenBr?=
 =?utf-8?B?ZVA0cEpkWWh1UHlRejlhcjBJeEJ1THJ4c05xWHFoL2h3dFM0RzZoc2NKTjc1?=
 =?utf-8?B?SDVtVTBoVS90WjhyeUwvZ3hvV0Q5WU1kb0NCd3hxNldhQzZVOTRyOG1tOEJx?=
 =?utf-8?B?aEoyWlJGR29GZDc2V0dnaUYvR1pvbFJVOEJyMW92WjF0YTNBQnhYUEpLbW9j?=
 =?utf-8?B?cy9CZFFQZEtHcXBhVHJVVHVaaE5ncy9BaU0wNExwbi9kcUEwZUxuWCtVTjJB?=
 =?utf-8?B?eXVYVnhPeVAwcnI0bTc0eklOWlB3ZXNQOE5ibjFNVUNzYzJQOW5DenQrZzRM?=
 =?utf-8?B?QjNPeTRmZFU0dTgreHM4T0VyRVRzVVFDbVNpb0w5NXpjR3gyNzlTVjNoL1Vh?=
 =?utf-8?B?MnB3a1lwMm5PRnpGM3R5eGJkMHc5UU93Z0hFUVd2Ykxkc25QcXhNN3pxWERM?=
 =?utf-8?B?aGhCREhieElTb05LWmdWZ3ZKMmNJa0hBR2ZOcHFwWWdyQ1NXUUNEQkxhRjV3?=
 =?utf-8?B?bzc0TU15VG5DbkxTRFlWT05Qdk0weHhka2Y5UjNDSlFsVDJJY2xxNm1ZVm84?=
 =?utf-8?B?anRkRkNwWHAvMWJIbDRDejl4ZkxObk1UdGQrb05NZGR4a0ZscEg2ZjA3WWxx?=
 =?utf-8?B?UUkrbDg3a3dXaFNzb01GRS9saTIvc3RNaGtiUk5PSk9tcHFKQTdVV3pEblpH?=
 =?utf-8?B?dFRBM3dvZHh3OTRqUDc0WHBIVkw2VGlVKzVpc0EvVVVJM0dnM21xKytRRlBD?=
 =?utf-8?B?dnp1UmNPTnpYYy9kR2RPbWNGeExwZE5hY3dLS0Z2TUVTdGM4YmE1c1lsZkI5?=
 =?utf-8?B?RzVkRzUycEJJb2RyQkVhN3RuSkpYTnBiNnNPWm1RZnZGaFlaaUJqR1pvMFlP?=
 =?utf-8?B?L29KZE1zYjRIK0lYdXpMK1dXamhVU09pNWtvR0lwOFM1TzFxY0U1MkdOVCtn?=
 =?utf-8?B?Yzc0WDFYYTA0U0tYREtpOTVxS0tvN3dNSXNEK3JzY2xDbzN3UzZvM1hLZ014?=
 =?utf-8?B?b2RtaWQvaURFVFJGVHFRWGhmcEJuUGl1UU92emJ2am5uNkdObHVwMHBLS1ZE?=
 =?utf-8?B?MkQ0UUkzV08zNVFGQTRvTGE4TS9XNmFNQzhKTTQwamVtb1dLMTEyNjVZaFVy?=
 =?utf-8?B?M0loU0Vwcmdhcno3UDE5RUpjWThWZTFrcTZRbTY1UW5HZG14VUVoTnR6QmNi?=
 =?utf-8?B?aXAySlJHdjRQVjFyWHRWemdVRkh3TmJEc2Y2cDdmUU9tMTdyUUE3OXJxNGRK?=
 =?utf-8?B?SExscmVFTy9lVkMwcmtHMmI4emQ1cWNuM2ZCR3F4NDNIcExjU0p5bGN1NGty?=
 =?utf-8?B?MUpuTkpEci9SOEVhM0c0S0NlR2tQMmp5NW9vTzVYWVduSnl0M2lxQVFTR2Iz?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6BZoJ7XybqvtNQBH8DSWknv6wcRqH6sXTaQ+nddzj+jCZj2i4/C2K13Yh0/QAit3pbgZ9lvrxLyTqqBrFdUdQQs4WzaHpBUuDnQX7sZ5uRX/Hq4h0OId/i2vtq+gXyHrMAXj+XCISsUzi6ZfSUPe6zjxBfxttSxo7B8a1QMUr4y3pItLGECq/Y9intZgvv6WSUnfwHoljZ5+Xs04OdTQ1oDsplEkfDN73kt5Q6MHbIFVafNzU8zZEukH25NcZMxx8ODS47uu6Ar9NFeOs0Do+RJpICV0aZkwcTQeDN2kI78Yd85ZE+BFyxpfTtA08KjVXhuQ5NOnUHnnXsJTKADTY6Ld+mGpwUq0efC9kHg+xNWgeQNeKDXBtDvrMWiZaRsG/8IBfkRT6YEC5aGkc/4IFi3zWCHwx391EO+f8ZxUUw24KjwcKbkE4XUbdfLiHTtzFVZJm5jOsjcGxj6zvOx1eDdOdvYbvg/XhpVuw2Zm4oclvozJNWpfDO67CCapd82V6hfvszHuoGkKsYT1pqqhAGHTAwauDUVTLvTegwyuGtchOSbe3ejRz0FK1infdcgipS3K6JXEcFjZH89PMo5kT5tybJa8Ytecy6i8tUBT9LQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bfb5e9-07b1-4dbc-6a6c-08de3d7d3ccf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:02:03.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOpqLrN4bETHcbJn+51LNyEzfow0sIadEYHi8kK/YkyVSxrssCJefXN2a/Fe/V7zytTmpRrI3WzAnuroWMGt8Y7uLmfG1IXIKCdkyQEtBdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6467
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_02,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170117
X-Proofpoint-GUID: Q-eGUF9Slv2a5YZkeL9P_MDvhvUddTWF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDExOCBTYWx0ZWRfX7wba+yoVIs/o
 ROsVZd9th05I3WUpmPSgu4wvzLE3SBkVR88v7lp3tji2TxXcU2eyP9B67MsICR5WOHhQp/Pw2vg
 AeswhODeHdjJfh4P7Hm8NjtBbAUscCk2KTV+qf/LPw9OhV8RgXGO2TNQSFYSGA43MmacIokLDp0
 A1uvYmWWZDh6P3Tb6rHzqWkrJqBXZIyDaUCsfMKKv+Qj5kQmLkW1nmvewv/SxqrPNxTvdMyHtj4
 wwqLuWz5rN0fkvfawOQV4/tkX3y+4TI3eUmI5GcMq7ebhUPL83ZmsivY7KouA4Vb1Hr4N3FnRPp
 WO2z4zYPzMgNiHgKrTxWEArhtmkWLON7Dox9xTt6Ctd+A429LI6AZUfW5hjZ6AsWIDNC60vc8Yu
 JBsbeILtT1e72+yaFMA+2ALbfrEprHveWm7xUcZz5jqV0+9JqaQ=
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=6942c5f2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DeCs8sHeAAAA:20 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=km0P1Smguf672J0ZGYAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12110
X-Proofpoint-ORIG-GUID: Q-eGUF9Slv2a5YZkeL9P_MDvhvUddTWF



On 12/17/2025 8:11 PM, Eric Dumazet wrote:
> On Wed, Dec 17, 2025 at 2:58 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Wed, Dec 17, 2025 at 2:49 PM Eric Dumazet <edumazet@google.com> wrote:
>>>
>>> On Wed, Dec 17, 2025 at 1:10 PM Aditya Gupta <adityag@linux.ibm.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> I see a null pointer dereference in 'net/core/dev.c', with 6.19.0-rc1,
>>>> when using e1000e device in qemu.
>>>>
>>>> I am able to reproduce the issue on PowerNV and PSeries machines on Power
>>>> architecture, though this might be possible on other architectures also.
>>>>
>>>> Console log
>>>> -----------
>>>>
>>>>          ...
>>>>          Starting network: udhcpc: started, v1.35.0
>>>>          udhcpc: broadcasting discover
>>>>          [    6.389648] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
>>>>          [    6.394166] BUG: Kernel NULL pointer dereference on read at 0x00000000
>>>>          [    6.394262] Faulting instruction address: 0xc00000000166e080
>>>>          [    6.395253] Oops: Kernel access of bad area, sig: 11 [#1]
>>>>          [    6.398372] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA pSeries
>>>>          [    6.398647] Modules linked in:
>>>>          [    6.399553] CPU: 0 UID: 0 PID: 203 Comm: udhcpc Not tainted 6.19.0-rc1+ #3 PREEMPT(voluntary)
>>>>          [    6.399757] Hardware name: IBM pSeries (emulated by qemu) POWER9 (architected) 0x4e1202 0xf000005 of:SLOF,git-6b6c16 pSeries
>>>>          [    6.400002] NIP:  c00000000166e080 LR: c00000000166e080 CTR: 0000000000000000
>>>>          [    6.400148] REGS: c00000000c67b4f0 TRAP: 0300   Not tainted  (6.19.0-rc1+)
>>>>          [    6.400275] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44022860  XER: 20040147
>>>>          [    6.400544] CFAR: c00000000165ef0c DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0
>>>>          [    6.400544] GPR00: c00000000166e080 c00000000c67b790 c0000000028ca300 0000000000000002
>>>>          [    6.400544] GPR04: c00000000324a568 000000000001a560 0000000000000020 0000000000000000
>>>>          [    6.400544] GPR08: 0000000000000000 0000000000000000 0000000000000201 0000000028022862
>>>>          [    6.400544] GPR12: 0000000000000001 c0000000041a0000 0000000000000000 0000000000000000
>>>>          [    6.400544] GPR16: 0000000000000000 0000000000000010 0000000000000148 0000000000000148
>>>>          [    6.400544] GPR20: 0000000000000000 0000000000000008 00000000000005dc c000000003ea5e98
>>>>          [    6.400544] GPR24: c000000003ea5e94 0000000000000000 c000000005b7e200 0000000000000001
>>>>          [    6.400544] GPR28: 0000000000000000 0000000000000000 0000000000000000 c000000003ea5d80
>>>>          [    6.401178] NIP [c00000000166e080] __dev_xmit_skb+0x484/0xb88
>>>>          [    6.401697] LR [c00000000166e080] __dev_xmit_skb+0x484/0xb88
>>>>          [    6.401843] Call Trace:
>>>>          [    6.401938] [c00000000c67b790] [c00000000166e080] __dev_xmit_skb+0x484/0xb88 (unreliable)
>>>>          [    6.402060] [c00000000c67b810] [c0000000016738a4] __dev_queue_xmit+0x4b4/0xa94
>>>>          [    6.402122] [c00000000c67b970] [c00000000192748c] packet_xmit+0x10c/0x1b0
>>>>          [    6.402190] [c00000000c67b9f0] [c00000000192af6c] packet_snd+0x784/0xa04
>>>>          [    6.402278] [c00000000c67bad0] [c00000000162a91c] __sys_sendto+0x1dc/0x250
>>>>          [    6.402340] [c00000000c67bc20] [c00000000162a9c4] sys_sendto+0x34/0x44
>>>>          [    6.402400] [c00000000c67bc40] [c000000000031870] system_call_exception+0x170/0x360
>>>>          [    6.402468] [c00000000c67be50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
>>>>          ...
>>>>
>>>> Git Blame
>>>> ---------
>>>>
>>>> Debugging with GDB points to this code in 'net/core/dev.c':
>>>>
>>>>          static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
>>>>                                           struct net_device *dev,
>>>>                                           struct netdev_queue *txq)
>>>>          {
>>>>          ...
>>>>                          llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
>>>>                                  prefetch(next);
>>>>                                  prefetch(&next->priority);                                              <----------
>>>>                                  skb_mark_not_on_list(skb);
>>>>                                  rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
>>>>                                  count++;
>>>>                          }
>>>>
>>>> Git blame points to this commit which introduced the use of 'next->priority':
>>>>
>>>>          commit b2e9821cff6c3c9ac107fce5327070f4462bf8a7
>>>>          Date:   Fri Nov 21 08:32:52 2025 +0000
>>>>
>>>>              net: prefech skb->priority in __dev_xmit_skb()
>>>>
>>>> Reproducing the issue
>>>> ---------------------
>>>>
>>>> To reproduce the issue:
>>>> 1. Attaching config as attachment
>>>> 2. Kernel commit I built: 'commit 40fbbd64bba6 ("Merge tag 'pull-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")'
>>>> 3. Initramfs (it's buildroot): https://urldefense.com/v3/__https://ibm.box.com/s/x70ducx9cxl9tz4abh97d9b508ildync__;!!ACWV5N9M2RV99hQ!JFK4bRaMJqtwI1HPrt0RUtQ-Ti5RfIOMf_XvhccLjHCtWhOgpn4WF1qglGxo1Z0nXM_TcGB7PehRPosqE_4L$
>>>> 4. QEMU command line: 'qemu-system-ppc64 -M pseries -m 10G -kernel ~/some-path/zImage -append "init=/bin/sh noreboot debug" -nographic -initrd ~/some-path/rootfs-with-ssh.cpio -netdev user,id=net0 -device e1000e,netdev=net0
>>>>
>>>> Thanks,
>>>> - Aditya G
>>>>
>>>
>>> This seems to be a platform issue.
>>>
>>> prefetch(NULL) (or prefetch (amount < PAGE_SIZE)) is not supposed to fault.
>>
>> Special casing of NULL was added in :
>>
>> commit e63f8f439de010b6227c0c9c6f56e2c44dbe5dae
>> Author: Olof Johansson <olof@austin.ibm.com>
>> Date:   Sat Apr 16 15:24:38 2005 -0700
>>
>>      [PATCH] ppc64: no prefetch for NULL pointers
> 
> I will send the following fix, thanks.
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9094c0fb8c68..36dc5199037e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4241,9 +4241,11 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>                  int count = 0;
> 
>                  llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
> -                       prefetch(next);
> -                       prefetch(&next->priority);
> -                       skb_mark_not_on_list(skb);
> +                       if (next) {
> +                               prefetch(next);
> +                               prefetch(&next->priority);
> +                               skb_mark_not_on_list(skb);
> +                       }
>                          rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
>                          count++;
>                  }
> 

why not only ?
if (likely(next)) {
     prefetch(next);
     prefetch(&next->priority);
}

Thanks,
Alok



