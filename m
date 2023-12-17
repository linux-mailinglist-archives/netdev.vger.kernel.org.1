Return-Path: <netdev+bounces-58348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F8E815EEB
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 13:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056011C20F2D
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCA432C6C;
	Sun, 17 Dec 2023 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omEf4GZ4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F6B32C67
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2HtlueEfQNBNE+sBAn9E3UFXZ0Vv8RWKY5XHyVd2xiFggzQSRYG9/HWXELtHp5R+K1wldwxA41xHeU7bgeroUJKtA9u8G5nvM+TSIcTesYKA8qBjojVN1rMVh21uwXkBXF8704+tYpZxOysEhMLL4aJwtxjLmIKO6Eq5qeyJgBRxGbI9IRyDnIV96hYL01+O6mefm1rUZPPzSAdH+o1a52N9VABnURJOida3i1jtc7x/PjVmRowxTgV/BdnHfecK4cNLrzI9o/3jGQTl8bfnrFzxxqs1nMz1dh51ULDw0Ss/Rv0xeZGUXbGyDW2dv1QkjMJT84LfPkWtDa84psnpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nF93jxAx6x89U/+ek5T6gu40EAk6X8wLuv4VYrRGgf8=;
 b=bvdvJsWq4lWG7oqsQeEVblmFgszdAa8MKloxm1Ja1eT33bFLcXm3OAzRemEuvf9JQkyQMOyg2+/8VsvC/g80JOg5A3NzMnujB/Tba3KL2IA5BGSGtWNwCoiPRDe+gSFY/MC7B1xuUpaASXld/Xd9G6aUZ79RvelyesD1k1fb/WQVIvFbHiHMtsfUnXwJr7pjWNZZlrzriL7HUBhFFYJYltR+Wz74xWB+gzSdGnVdkIDvjxexBRWhOkBq/onbHYNzvcXLEiX14tX+PF+ReJPVqgBmvHOGj0zHRglh0yNr4uOTx0tAm+Tc/UI0jCBb1CY3A2Q0PSey8cVbfZRrooE3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF93jxAx6x89U/+ek5T6gu40EAk6X8wLuv4VYrRGgf8=;
 b=omEf4GZ43IrQQX70ObU/dLanISPUhEGDqpcUbp2jPANOFVE18skwDMwdYh04PBWVcRkEcLYfjWENvJtAHH+AYQsRh/9Ybb/hjAoK26BIFddN0dE3GzCZjJoUhHThmFn0sUsH8jgJnjatyXI8nWKHk5lX705hHZG+R/gkbPmRQ9PmP+6hmpM6WFHh7q+LC4RBVdWOn/pVow/Z+t/eJw04piEksBRNRY5MgVngLts+NiCHHdzGPLubEc1PCb6eH2Qi9rOa8SBdK5Pj+JXfAcZqXUdKg7siCNG8E4zXGpo+swnixEUDtWMCbP5UoZWtOKASN8XZ5a0JwOgfXxi9ZIk3+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 12:18:13 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f%5]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 12:18:13 +0000
Date: Sun, 17 Dec 2023 14:18:07 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jiri@resnulli.us, jhs@mojatatu.com, victor@mojatatu.com,
	martin@strongswan.org, razor@blackwall.org, lucien.xin@gmail.com,
	edwin.peer@broadcom.com, amcohen@nvidia.com
Subject: Re: [PATCH net-next 2/2] net: rtnl: use rcu_replace_pointer_rtnl in
 rtnl_unregister_*
Message-ID: <ZX7m/0oALY6XxhsH@shredder>
References: <20231215175711.323784-1-pctammela@mojatatu.com>
 <20231215175711.323784-3-pctammela@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215175711.323784-3-pctammela@mojatatu.com>
X-ClientProxiedBy: LNXP123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::31) To IA1PR12MB6163.namprd12.prod.outlook.com
 (2603:10b6:208:3e9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|IA1PR12MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: cba0e60e-1e07-41c1-1ba0-08dbfefa3cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E/szuYKI4jjCZQS24YFjWdFj3TCfM2/Beo4A7umhuMtHnraWUYK0hwBpoB9Krcy313vQ1XH3WMiEKbyw3GQLmkAvD60ld40/ZxcFKDaJGHt1yhjVkSi4LMjBNrh4NAZNkk9YNS0o0gbBhqTeUi+mgkywB8UUpH59OUjKFCkLzkUm99ew41/ak55dbZs+4UulmDQS6L58Q5qB50w+xNmGV0oXO23HkNkV2DDV7oXrxA3pk0pL2aMaO8aoehg+syq1T8+KOTBeX4efhW3d+6gT2SLHB/u72qJHfb5hbjxR5vyiNei0Kc3lEaTjfRboGpU1YcCX1BDZJ4QAlivBjl/EBEJfiSqfod3n8I3qIE+VCuJ/7NTFlpJZ5ej0mW4Za1Tlmx7dYPahwXpJyhPPHaUmFqwOBOhpPF2EEQde1LsD4B+BFvAB75DjwObk5um0kWPqYY0jcb27JtP7cui9oIxJL2BY120Ha/QFQ6zCA802J1F9G9sc93EI0Yzp/PP0ybsvJOmsfugGFTU19LRfMpKSDMqur18LqWj9TqN1wjY9r5pT1RdVKsws0Pn0VwtYfTQK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(376002)(396003)(39850400004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(4744005)(2906002)(7416002)(5660300002)(41300700001)(86362001)(33716001)(38100700002)(26005)(6486002)(107886003)(66946007)(66556008)(6916009)(478600001)(316002)(66476007)(6506007)(6512007)(6666004)(9686003)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5qoRhJp40SyCO3sxhnWzbwlD66xqt9iu0imFvaR0eJezDA2UZVII+LrlpRDX?=
 =?us-ascii?Q?cIk51CoT81O9fhfxMDZKvksn0IN9DLMfJ6vVvck/quJkTLCCDj3aHGr62VgH?=
 =?us-ascii?Q?a/6GdqNyYSRVuhmKB+pBjvPpuYq3+FlH9Yj2ZMue3Fv59U6sqaJ+ANuVJvVB?=
 =?us-ascii?Q?/VMckM7YoA5sdzJvIC7Z7mDZ+qdmELYGKDCLeFTp89/RWa17kdIT+Jrjy/eD?=
 =?us-ascii?Q?5pkEI8HressJjy+8y6SOCmBtsZF+SAEMSDF4UgVN9SqU9RicAKGulUO1dZEB?=
 =?us-ascii?Q?uQuAhVu+u4qlYA3jX6cHgJwvau7ygfLQ6JDDyVIbr7Ak8ME2S//WWVxNTlJ1?=
 =?us-ascii?Q?Y0UwwB+8CT3ELQ5BnauTCfay92rcYvXVBu/0B7QTo23c8+M626D9J2fthNma?=
 =?us-ascii?Q?Z91Oq9ovkOFScFaQz85jvwCk2zQ5JZT8AxQUzq5JhK+lAl2qMaywnQMBvCiL?=
 =?us-ascii?Q?G6yg55EWGJtsieFHtLPg3hFXHiO/FR9wpnPqE53EX9SF3IlPLyScDwSG8xgg?=
 =?us-ascii?Q?J+0i/UMVc5tTSsPm7xdhozj/fTSvu8msC0MHKhjGvpzjUns/lSm226GiQBLN?=
 =?us-ascii?Q?UrNaAEYk6mZFEyGdgvoRwkHeZFhFklJOEKJBljmrzlfvirIeLmZQkjLhUllA?=
 =?us-ascii?Q?+juvlH7QEDAod32oGkvo+CeHtlbcTcWRS0XgqDrSi8aQ5qOa0Lh+UoGtWBtd?=
 =?us-ascii?Q?x0ERFS/s92MSReLWnnq7E+C7cn4kdtyOEGQfsIc74GoQPQiearuPbrgTnLBX?=
 =?us-ascii?Q?EAqeSe4lUJsSqJfN+sGAYWo0rQ1QuMOs6EoHOkxcNZ+jZRct2wHwVlZZ9Kcy?=
 =?us-ascii?Q?TteNNFzsxHViwGnbtnqEPu79thGcvk7vUhk47xk0Bqp2ArZ3JeyPE0sRD6Dq?=
 =?us-ascii?Q?Fviv/567gzLkiVZQChlk7YC/ooI+E1CQZpI6soXTYZVoKzR/TaWOydWVtNe1?=
 =?us-ascii?Q?9zBm+dOO8pdVQ7hiq4QakXb4XcT7A4kzFp/C93YlGhSuCkDgJxH42GHn0VCq?=
 =?us-ascii?Q?uCaplsS4zWliyp7aNOCGfTKEZluCqSWx7lianUksnwkl5QzbnX8nJcAAaqQy?=
 =?us-ascii?Q?nMufWroxniCKyQjI2Oi+ZgTPGkhKZTsgLJF7nlJfcl0tHfi5B+Ejk4eAFVSG?=
 =?us-ascii?Q?E4oOx1h5LMMhZGxg8VX968ZOx+lc35ME8UKvY+Ic4xarCWx31Usgwf1xq1wv?=
 =?us-ascii?Q?Y6hLnv/g4PlkeSi8pT+Gk8uDiPefgr/0hYRoHSt94+oVjT+jkI1zCsezVd3d?=
 =?us-ascii?Q?yEn2VKknUHmD6m6/nKVtuCHLjL4u2syEFAqTvUpjbpAyzdt4T2+qMHcAQt8B?=
 =?us-ascii?Q?BeSwBlOyybTfgBRTMi777jcfWhVnnlJdv5ULZLWELc841vrxXf4PNhqnWqbJ?=
 =?us-ascii?Q?nTJv2ibs+0M4ogiTh1+9OhRWBfUsmKnqXbfPNuZkDO3aYsdUbyr6vh47hVMI?=
 =?us-ascii?Q?Yd1ncPVavjIw+2EW75u3FFAP7bmBYOI14mm8rTqBUVNwLuzDo4qEOCW8oeJQ?=
 =?us-ascii?Q?GJkFeMh2H5n9tono246rNMRbDnSY7pOB4ZwIBnkikylL1O3Fw96GDWNSwRnG?=
 =?us-ascii?Q?Z0QlD6tv8OKQfLf60eCVNtLxRt3GTmAWu0O1VqZ0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba0e60e-1e07-41c1-1ba0-08dbfefa3cc2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 12:18:13.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pOTGAJuRaTrintzoJySyDhGjhvJoDYKOQsCb6/5+wxpxIIMEuOLih1ha/V+NVxzgwKfQARzmrAOKbLRyKP3lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224

On Fri, Dec 15, 2023 at 02:57:11PM -0300, Pedro Tammela wrote:
> With the introduction of the rcu_replace_pointer_rtnl helper,
> cleanup the rtnl_unregister_* functions to use the helper instead
> of open coding it.
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

