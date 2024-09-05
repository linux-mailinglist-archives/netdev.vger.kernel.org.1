Return-Path: <netdev+bounces-125660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A455196E2B9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317CC1F292FB
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79DD17BECA;
	Thu,  5 Sep 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IwdL0kAj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q7jZAppS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26945027;
	Thu,  5 Sep 2024 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563237; cv=fail; b=rRTA2pdmhN3zpdO3P7LKGR2dg1ZDUwzf3b8qi8jbzg5EMwTujusgg8gADSgBen0T4peXQ8fG444wL6fSJvvepO5Jgsi3C5GTPKdLOZRYXPxOPGXEL0qP63w0KXmqFmslTkZnrPyYNZGQA8Z65F02rLU58tcpXjQcrlCJXqK0nzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563237; c=relaxed/simple;
	bh=HFqmfcuDj8AmwNM1lxelC8aFjiulieQcwi+rYfYsU+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q9JztvFfnJiy2TRhzCAWUIiM+ck3QjZOmFObk3yMcEj4sMdoALVIRoskjPQSjmGHOxeualUJixb3Ok23vaYZ05KIWRSDiVRmQlvA9SceW8ZZQk5YXAE1hesmmNeFnnzcRfGfqWYiNA/mm39IwpXCDUA6QYAxDm3ugrt79tIiYKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IwdL0kAj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q7jZAppS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IXT3N022914;
	Thu, 5 Sep 2024 19:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=sGmd3ClanJ7ikoKdO4ZK1W5qyxW89+kvbor94xCB/9Y=; b=
	IwdL0kAjtl+sgOpmJ/0fzo0apBCbfQrJPUPa16CqTnMp2n8FUcsabfAHQElncMNF
	jd3kOJR9Xk/u8JxUjkg0QkvCPfXif14BFjaqwHfNZK9OJ8N7l/V9nIRkMI79k2nj
	DUXQ9jMoSjTlJB7AKuHp1ofjtlBMNptXB/mOBDLrN+fROAOz8iv6jQQ5KgL4v3+3
	6OP1p89dy0u2v6OmONd/bqP9QK4qLWpiVJlsxUsRqj429Xh31mj8R5+UGvYIKOua
	OpJp1xFld+V7iqRovilDPsaEFNaOfFT/ICSr29wf/y8JFdLNquETjs7KIIux9zJw
	IH+NzInvsp3BHUuzhOyFzg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwnr2t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 19:07:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 485ISwVM003280;
	Thu, 5 Sep 2024 19:07:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41fhya9x77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 19:07:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzql7oRu6DUMzQL6X19Om+s5tpqsYtqHjQnu6YhBYs8d4rCeixNvUCenIEzz4hQBg5+lqvjBXL2qilU/e7JlluCQLyAscKfrsR/q7n0Y2BdI1Jv9x/FPUQTVriWh/eF1x0pHI09avvVlC9gNx1kXgoyPtvR1omeXdwB/AbQdKxHNSl0PlKXeon1cqgGMRg2sIy19UdTEr2ZaqrckRMU0IREafI8a/IU7NT+Mzi1wBfwaBehN4B8SxFKchOGK9iK+FuwekmMJi+rV8UJ3GQeKUi2QsuyKhT+Y8cXSp16KHGuPLXsEVJaHe63IvTCIl94Ti/3WI3fNHvEYsp3GjUSx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGmd3ClanJ7ikoKdO4ZK1W5qyxW89+kvbor94xCB/9Y=;
 b=iBd9vrPiMxaGOgkmfYsmaHsvjlHx+Pcig2gXHPYb92Fz0ErPHjsftjypdvVoeJauzPQH9prnZPuJSQCXwjp0yFXZgPtVWjkP7Ji58HsvqN4QbrxLSkposawKJee2SSBoQYwD958/J3hUiEEkdGAKMO+5IqXpWFEVn6UbUWxSOB5+yrS6zv27MHTQLeAQNIZfSN1tefzGeuV4I+nbIfDxiv7gMDLpNkjYmPYkx4Nz5awYCmEyyZ3Pg8+nQosASbIevqACVn4zjC9b77lI5Go29x/ZmOvevol3q60EywZQgu9C28Eo9qk466CC0EzUnYT2Jrevo9XBAvcBInPGbTepaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGmd3ClanJ7ikoKdO4ZK1W5qyxW89+kvbor94xCB/9Y=;
 b=q7jZAppSAycMrliJAMTUphTOJZLakpGkQxJa74uxt6NiLeJUXlaQ7vVGJ2vYs+VRs8WyOvWgzyTr/bWQtJ9MnQtlbWnc0Exb4O1gBdkwXF7wc7rH7VANeP29Ot+lf9UeQ+e/Wevdz0davPLMEWMMfo1ZEkTzaFoDhTN7eobgwNs=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Thu, 5 Sep
 2024 19:06:55 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Thu, 5 Sep 2024
 19:06:55 +0000
Message-ID: <15a6ed05-8f11-4118-ae32-4cb7622ce19b@oracle.com>
Date: Thu, 5 Sep 2024 12:06:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <00000000000083b05a06214c9ddc@google.com>
 <CANn89iKt9Z7rOecB_6SgcqHOMOqhAen6_+eE0=Sc9873rrqXzg@mail.gmail.com>
 <f6443f4c-c3ab-478e-ba1d-aedecdcb353f@oracle.com>
 <13a58eb5-d756-46a3-81f0-aba96184b266@oracle.com>
 <CANn89iLfdNpdibU=kWZKgHPAeMSpekePovmBNbaox4d=Zyr+OA@mail.gmail.com>
Content-Language: en-US
From: Shoaib Rao <rao.shoaib@oracle.com>
In-Reply-To: <CANn89iLfdNpdibU=kWZKgHPAeMSpekePovmBNbaox4d=Zyr+OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:180::37) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|SJ0PR10MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 1675c9d2-21c0-4a85-fde2-08dccddde8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEdtQkJFWWhRT1YydC9hRFEvU0x6Znk4dHJxc0VocDNqb1BTSzlHbDc3WGlC?=
 =?utf-8?B?dG5xeVE2eVJQSkJHMjRPdFJiR3ZMWHl0bldqUXFGWGVIN3BMa2xBN0hwWVNF?=
 =?utf-8?B?TktrSGhnOE80Q2o2LzZXeVNmcEFNbFlCWlFrOXp4K05XV3Nob0cxVHlBeEhO?=
 =?utf-8?B?SUJBZzlSNk1SV1NlcEEybWw5bGNLaGJNeDBZQUQ1eVAzUkl1aEZNOWRKbGFJ?=
 =?utf-8?B?ekY3Q0ZLWDRmVExJV0cxRVhjclMrbTU4U0xzSjVjd1lWVFRDaWRORkk1UkVi?=
 =?utf-8?B?S3lHN1lwSXcvaEt5cW5OcWx0OXVPT2x3UEtwSk1LU0Y0dEs2NFRNK2hJamxs?=
 =?utf-8?B?MG15U2lrZFRpSTlvTHZOOEJUMEtsN3lyc0ZJU2t2NXBBVnBuU090SzZVZE9C?=
 =?utf-8?B?aExNTVhvOFZ4bmZJZDB4aUd5anBZUTlzZk9VVEpmdzNTSWRhckNRVmoyRHVD?=
 =?utf-8?B?c2xpSjV4ZWpxZnpVR2NML3AvbVd1Nkk2VmFzTVVrUGdFcFd5NklTWnV6U2hC?=
 =?utf-8?B?QnNKdFdjL0thTmt0UVByZGkrdkdwb1RSQXZNUzEyZ01qTXFqWml4NnpUWmJT?=
 =?utf-8?B?UE8yVDV3YTIwUFh6OTZLdWpDeXMwWTdYdjZINFpSNFVCVGtwcGNvblVFQXNP?=
 =?utf-8?B?c2o5aURYZTgzOGFJUXNpejNCMnRrRkgyQ2hEcFlibDMxWWorNzZlbm9vM2FY?=
 =?utf-8?B?QUpXTFJvVUh3SUNsWFB3eXdSeXU1Slh3bHFQUHk5UlRKcXM2ZG9NVW9kaWNy?=
 =?utf-8?B?cDJzRmlHaURTZFRBMkJqMjcveER1Uzc2cm1XMVAzNjJVQnFrWG0wWHZhOVo1?=
 =?utf-8?B?eDhJN0JYaVZCQVp6dDNzUGpPanVjZVVVMTFJa2JRdGhnWkpaRjd1TVRrYVVO?=
 =?utf-8?B?NHlWa0wzL3hzT1JVSzRZRUg4RHNvanphdkdESnlUVHpwbnlrS1ZTMkttVGpH?=
 =?utf-8?B?QTVVY3VSYWROMzBJOENXam1LaWVyT2lHc2xEcEtQaVhZMU0wS2kwS1lWcFgy?=
 =?utf-8?B?d2dpWjdaZjhMUnhjbjh0cTQ2VktqMUFDWXpWaW1ZT2pYVkgwUDVGRjlHMGQy?=
 =?utf-8?B?WUE5OTh2WDE5RDE2UHNTb1hVN1JXa0RjQlo3UUNjN2dzT3VFcFBHaDdueGlB?=
 =?utf-8?B?V0NTTWthZ0MwWEx6Uys0cEptUjdzbS8xc2YySzFVWTNYajBEaDNNdlFSRUVt?=
 =?utf-8?B?UkZrcmRhelVxVm5FM0s1dHYvamVic2tXZG9GSVhDZklBV0JIQUg1TTdVSHpM?=
 =?utf-8?B?cE9sdmhzWGhFaFgzcUJCMEI3N0MzYllZNlhKM1FMd3U3YkdGL1pZUEpMd3Zj?=
 =?utf-8?B?WHFUOElKV25vZU5Ia1RycU1Oc0xwejJoQllKa1hqcVJIckZQTjFFaVBMQnhS?=
 =?utf-8?B?N1NKeEllUzVwUjNNbDFnNGRNa2t1bjhVSGh6Z2JsTzJ0TUc3RjNFY3oxa0wx?=
 =?utf-8?B?VFFlN0pvMzFQb1pIV2lOalFTbDE0eTNUbnJrelNIYkhmTnJCTlBvVWRiSjFp?=
 =?utf-8?B?ZnczbXdSUWRHWGRkam90Y0tjV3V2a01vTWdHK3B0WjE5Z1RyRFdBalZaZUto?=
 =?utf-8?B?azBoN0pHQkYxMjh2M0dkUHQ2SENBRWlyT1BXdHR2WGVMTENwZFVMNCtOeDFv?=
 =?utf-8?B?d3JHOTg0WHVCcFVqWUdZQ2N2SlB0MEpBK3RqRmQ5eW9wU214Z1I5R2NTRDFi?=
 =?utf-8?B?UE9PbW1kRkQyekhxdWxWNThuU1FzTTh3V3plVHFQSmJad0ErMVNZdmtvMEl4?=
 =?utf-8?B?TldRbWlFWngwa2hDbUVKWTNNSDMvelplelp2OVkzOVh1MUJia2Y1M0U3dWUy?=
 =?utf-8?B?ZDVJRkRTSlQ4L3VSSXBuZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkhpN3JMUGlyQUd1d0d3ZjBCVDZya2ZaL2JzRzU5STFjQ21VTkNlRW43Z2JF?=
 =?utf-8?B?TVFhRTZickpvZmlWdHBLNUFST3RtQXhGY0Fib0tydXlXQms0VFBXdEpaMktG?=
 =?utf-8?B?U3N2NmZIcUp4dnRYUGN2dUF4ZUdWc0ZXVVZONnNsSDFIaVNNTlVyMWxOL2d3?=
 =?utf-8?B?aW0rb1A1ajk1NGRlUk0yaVRxdUdDaHkwRnVSM2JJeTY1NkZKUzFGSGxUVkd0?=
 =?utf-8?B?NGFKUVV3aUN4S0RFcjdIMXRDem5McHRyODJ6QVhJMUxjWVpaVE9pREgzeE9C?=
 =?utf-8?B?YmZRY2pmT1ZUQUw0NzcyMUlCc0thTVA5RlM1ZldYV0ptbjB3UFpUTlhGSGxD?=
 =?utf-8?B?ZFpTbGFYMXVHVm9iSmsrTnhaamlIczdGVlNILzFPelNPc2NKT1BQTVlYUEVO?=
 =?utf-8?B?azYvYmJSekdaT2d1czJ2bmZnN1B4d2Y4YnJBTXA1VXFXYU1Xbzd3djFZNmJW?=
 =?utf-8?B?M1FFeFJuOGQ3UlBpUHZHZ0pub1BWQXJOVzVIRWRlLzhNVE9JLzE1NFFlTFJX?=
 =?utf-8?B?bGxyakFRS2gxcjNRZ245d09EVnliTFI3S0lPZUVaMzljam1SVjRoUnU3TUJy?=
 =?utf-8?B?NWpmVUJhWWNsczNnTThrYmFVVW5EcWtvdWNQUWdDWXN4MElYMGJidXJIK0Fi?=
 =?utf-8?B?VmJsRjFFQzVOdTg4ZU5YZWlFL1p1UDRHRmxud2RmaldMNG1rL0FlOVlTWEpS?=
 =?utf-8?B?OE1mNGlsRS9DWGJFQnlEUHZQVDlPZVF1U3hVdjV1dkFsUXNuYkJQSzNqalFr?=
 =?utf-8?B?Tm91SmFlODQwQ2M2WitOanJzRjNLY0g5R0pJTExEbjBTQ3RXY21yMW51M0hi?=
 =?utf-8?B?VmpsVjB4b0h4VktxT2R5dHovZVdXMmZsdVNLdjZodmNIcGNYRE1kREUyMVdQ?=
 =?utf-8?B?V3ZyeU9VeXRDY0lKNWVEZ0NpL1FJa2pGUDhrZ3dqbkdWN0tVeTNCdGYzaUFK?=
 =?utf-8?B?dGZ1WXZWbnZ0Ym5SamVxdFg3NUlVd1B4Y3piWEorQmEwd3FYMGZhRUNnSkdR?=
 =?utf-8?B?cWZCTjZONmUxUEozY0dNa3ZQclZCMmNiRkc3U2xSTDNpcUN6TnFCYVd6R0d5?=
 =?utf-8?B?MkZzOWdtRTlDWWJxTzV2cGc3S2JVTXBhVTE4WWNlOTk5eGM1ekdVMXdwUndw?=
 =?utf-8?B?cU1FTTg0bTZRWWplNmpFYnBNUE9US2dTMHlTZVJTeWNSNld4VEVPRXpUSHJU?=
 =?utf-8?B?TG1jRkQwQnNwSVV1UFg3dlg2Zkgycm43djFLK2R5RHNoWWpjbmkrbFlUSm55?=
 =?utf-8?B?bHFqb2JCTncrOTdSTUxiVGNNRVRmVDMwZWNxeHVzVE8rZUt2WmM1QVZXNzRp?=
 =?utf-8?B?YlBLY05oZ1FZSlI5RTV4SXZqbGVaOFVtenFZSm9ONElEaG11YmN1RDBLUDFa?=
 =?utf-8?B?OGdJbFp1dW9QQi9FWmMvSmVRdW50ckw4SWlydWZleTlzcDU1a1UzSVJhN3FW?=
 =?utf-8?B?dVZqODMzb0hKU0tiVlB5bEdYOHV4QzZ1Sm5oTjlKYkd5VHM2S0VIWGg5cHVF?=
 =?utf-8?B?c1JWL1owa3NlZ1VZck9ZVG1wclFNTVBzajFTVmV1UGMvLzBjR2FsUEdEZ0hh?=
 =?utf-8?B?U1Z3TzdCalBwRm1aNXRCZ0czQ2dkanM4NU9qaHJnTStPSUkwcG9abE4zM0hh?=
 =?utf-8?B?b0ovSTJjWXcwaEQ5ellVc0o4R2ZJUkNLSitqYVI3eWswUnNxY29zbENyNUJl?=
 =?utf-8?B?VnN2ZTJwOHdtZnlZKzg2alI3TStoN0N6N05VRnNhbFc2Z05wNkl3d051dHox?=
 =?utf-8?B?SU9KZXVDVCtZQWZjYndLbGswMlRTY29vQU1KVXQ3NWxsWGh3bStlWHJRdjJk?=
 =?utf-8?B?em44TWViajc2YmVsc0pCNTEzNlNJb2ZOU0lLdW8yS3hjY1M5ZzJKVzlOM01y?=
 =?utf-8?B?ZFYyeHphMzdWcnVMSmgxL0lkS3RzT25NQmlUamJFMzhEbG5Yb0J3WExxYTN6?=
 =?utf-8?B?TTY0ZDhWdjNXbmwrYTdNQlg2bkVsZktLVmtjVEt6YlczSVJIdExtY0hjU3BZ?=
 =?utf-8?B?c2dLRkFCdDIyVHJIUkJmajRYNktiT3cxTk9lazNXVVdDZ21EUE9JbEdaazBE?=
 =?utf-8?B?Z0R1NVA5ZytBOFVHZ1BRQUpNOFZoY09VaU1qMHM5T0hheWlDOWg5cUREb0FJ?=
 =?utf-8?B?aWFNSmtmMzJ1cXg3elphWDgzVzVlclg5MXhrbTh6K3J6Mmp5L29kRXNBbVR0?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O6zFQLc0+DbSfgBpXMPRbW3Rf1HPohf9W2ymbg72hkvfmjKsYCgYI3ZRNPftMLicfrytfAsly4rKUsD03EcSUrFFUQin4PYUeT0+nR5alONxi+2ZsA5MbG6+nqD4s1jt1sakVJZM/nYt5sfcn2jVa8fsSIP1seuiMcCRVhJUOGA723Am8hZElyiK4QUPMsikQNNVI2LJjiGqFp80nBWt6cvCHx5j6oPzvWOYhwfmidyJcEZ8MSV/YNhbdxTum1UXHoEzDaqXWp5WTMVE+ts8Rf1dIC1nAwxQ591Qgy7OV/Gslm6DtuEjfMU4yrxZGoCjQtV8Z3kKFrmELpOruiJJb62mFxnZRTZHgwHFKOlmvewk92N87E2xEPhvODvzuQBgvgX/WRLpSl53BM2ZwZVsIzfJkEn5lZBbv1oQis0rMjll0spay76AqNJ02lE8woJ6BQy3BrFftDGOj4TFTMnlOlDyBpavu3Aa5G0YQ0Id1flIk4AUDAPMBWtqLPdVukA2WdpLHtCAKuEIDVgaofaeIDSUTi75+Zyf20xzOWK9dEkWSyLHyXwYqSkM6HTieF/cpjAY7LPMmfHOpoce35TmuAejzWdUHeFCVPZvp+9qCtc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1675c9d2-21c0-4a85-fde2-08dccddde8bb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 19:06:55.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOI5jPloImoEyfcxILNM6ytwCVWNfy9f/1ButeY5FfI+Bk30O3sL1CFTOdjDLaakd9BLRf67wUYT8Ez8tvjHCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_13,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409050142
X-Proofpoint-GUID: sLOMDMEkOWZsIxgq7n5Vk2vERskH2kZo
X-Proofpoint-ORIG-GUID: sLOMDMEkOWZsIxgq7n5Vk2vERskH2kZo


On 9/5/2024 1:04 AM, Eric Dumazet wrote:
> On Thu, Sep 5, 2024 at 9:35 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>> Hi All,
>>
>> I am not able to reproduce the issue. I have run the C program at least
>> 100 times in a loop. In the I do get an EFAULT, not sure if that is
>> intentional or not but no panic. Should I be doing something
>> differently? The kernel version I am using is
>> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.
>
> Have you selected ASAN in your kernel build ?
>
> CONFIG_KASAN=y
> CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
> CONFIG_KASAN_GENERIC=y
> CONFIG_KASAN_INLINE=y
> CONFIG_KASAN_STACK=y
> CONFIG_KASAN_VMALLOC=y
>
>> [rshoaib@turbo-2 debug_pnic]$ gcc cause_panic.c -o panic_sys
>> [rshoaib@turbo-2 debug_pnic]$ strace -f ./panic_sys
>> execve("./panic_sys", ["./panic_sys"], 0x7ffe7d271d38 /* 63 vars */) = 0
>> brk(NULL)                               = 0x18104000

Hi Eric,

Yes. The config is

[rshoaib@turbo-2 ~]$ grep KASAN /boot/config-`uname -r`
++ uname -r
+ grep --color=auto KASAN /boot/config-6.11.0-rao-rc6-gc763c4339688-dirty
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y

The only config missing is

CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX

I do not have that option.

Shoaib


