Return-Path: <netdev+bounces-185431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B46A9A55A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5350B46091B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D30207A2A;
	Thu, 24 Apr 2025 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G9arMVap";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zuHrtalb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20015E552;
	Thu, 24 Apr 2025 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482155; cv=fail; b=gOJKMfQaKw512C68qAp7vOe8RfzlbnQjsRPLnEn7OAZwYYaEFHH1RcSnWOuPHYou7OZfRxVZbWi4Pp6Xnf5tx900uIBDpZ1STcIO2w+kLHMp+xkeO8U5gSM0ARbVMh22KCJv3ZHmwTV6EgJqzk45uTFJsm6pV4TvuiwsdbGtgcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482155; c=relaxed/simple;
	bh=dBAwtnAdflK0IWe6lp8h0TS3oHrP+Mk9jpYwENp1RXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FRcm7Qhan6I8fMUTsQfjnzKdJtk+hSZOOjHtMlPRuKrinzVxPTfsZYFBw14xFH+R6bw/naQYi+BFP2JgeOmUooWinVVZUmrkLsMHtmzExXQTZkScOuQ8gfABtbPqr3+lEvXRzeLTnVzZi1q+PNygT9cdtJTEkH0fUBydeMzWLYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G9arMVap; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zuHrtalb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O6twkk013986;
	Thu, 24 Apr 2025 08:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=umMv2cMz5y5y2+1ty2nqRMvnWPK7cWwZf91YYkODtsM=; b=
	G9arMVapbpLnx+Jc37ccC6vxqheYmATg4xuPJmqelXU7EWnjEmeZE26PqfiXCjcJ
	Ghy2pUs+nM1OFdTJfwDNGA1A5tSZ7IuWJXAhoQhDFKVxpKHtsz1Vc30pz6mxavKP
	WR3HjeXQ9EWPcrOHHMFyWi1vRjPMgVJaeBxfiYo+258wRPXgSxlGJZfmpKSa0EkK
	6OykL7xp4rLIrLLX2GXCI9YAC67oyBRZ/2bpgadSKatf6hQq749Ll8POFCUwmv4L
	nvB3bofwXOZ9K6VmjUShYIWu0zUscfuslp4vOs9DpIaxEG0crXGxSuUntJM+qSCN
	hd6LYWPtGRPuJYp4K9RCOA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467eghr8ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:08:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O60Aiv028507;
	Thu, 24 Apr 2025 08:08:54 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013058.outbound.protection.outlook.com [40.93.20.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx76xaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:08:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhydKng0h8F80lQN0sXVShcJJZil3gTN25Tor4FGWkOaiQ2jywuo7c4EOg9SadCkxfVrxwY7svQSvHCuzMyD+2h/Fe8RjeYhM7fDBDvH6h3t++QOcJrhSztBGNWt7tfR3CSwzrm2g7Z41HH+N1hTDJ3EI2JBk/Lvia3haj2/WTuQO24nxciHF231fKBgFPK5OYmEjcPyXnSRcGGw47aK3SxEocUStudasg7DKs0rgs22Kqgv90UQnMwAzBYvx46VttdKFoUQCnGTblnlyZSFwSSfgKvM8WUilQxKKVN+wLVtmTeSDLjH6uhCSwuRcMdINvmBmfIXo+mxdrImITDetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umMv2cMz5y5y2+1ty2nqRMvnWPK7cWwZf91YYkODtsM=;
 b=YHDAbJDYgjiLraH23QpXRJ3jkCh1GezFLzZ6VO9NiwxDX/j/MP9lMiCdHAsMXGb52X5fFtkO0q4XPf380FayNcPXx7lvKz7gtI36nXBhyCjkvn6RVeC0o3z1jljXcWKO0YlH86RPPayqbMhfd56/j1QkFXKOdauT5yveHRKbpq33kJoF690DHD/aiQZSkk8D3aRHNWBojzFKum3nKpPGWS8U632u/eExNw6XulpGKPKgmQ5YdaV1SRyljFOuHV96LysdlWjxRvBEr9p2EJArq4fsN+rdPhNYnf30Zxq6vj7OSC8lsCux4EZVOwNDW/rbYJpjwX1Ps4edhZ+O6eOKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umMv2cMz5y5y2+1ty2nqRMvnWPK7cWwZf91YYkODtsM=;
 b=zuHrtalbdwfPgwTgkSqSyIwJ9tjKtOq5MS7D4IV8yzdAveY81pZRBwAnfxQYXa5o6Nu/8yRoYwvli3g5QS9Zm5f7npn82SV4mJvpYSqbed4Ujbxgx6Xf07qZ4/niaAqNouEt8F1lfy2Ivn4YtudNvUB8BMwoKBdLBoe5y/L8fxg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 08:08:45 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:08:45 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Vlad Buslov <vladbu@nvidia.com>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [RFC PATCH 7/7] kernel/fork: improve exec() throughput with slab ctor/dtor pair
Date: Thu, 24 Apr 2025 17:07:55 +0900
Message-ID: <20250424080755.272925-8-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424080755.272925-1-harry.yoo@oracle.com>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0005.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bcedd3-ecc0-4395-576a-08dd83073c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3G96c8pHpCTXVXXoJIklQxwiYJHQ5YGiSndK6AkFmSHgjgG2R38ObFp59RzX?=
 =?us-ascii?Q?uSkAUNxbvzKrFUZpzCNgshh8ddyKnx4+DwHSrEkl9JtHJ2qVHG5gSRSggrfK?=
 =?us-ascii?Q?Uvwi5oGvmKoYVznECLB4s+9+v/M0O5YNxSEgJRDcUe8m+ZGszBrStZwXeQ3x?=
 =?us-ascii?Q?lS8XqzDJJx9B07zHDLdsSw8+E/Yc8Et8S6ntg+9vm0fPkjb1PiF/JaJRJM0c?=
 =?us-ascii?Q?vUYfyFSKc3ZuQcHkzRBFqOFyIovXjeQDMAh7Q/tS1et8U324NsKzru3Pe865?=
 =?us-ascii?Q?H1qikVezk+YUh1FYFp3UjYHWumvJZlShChPfH57NLlZ9e97BQ4Ogh/eABTwf?=
 =?us-ascii?Q?r0nbgo1jzJflY60VnUUsztqdc+leY6vHwXDfnPgDTSDPdG4sBHkpEjOslU5C?=
 =?us-ascii?Q?ojJicQQDQSTmne+HMFveJi7MkbGJanJueo37MKl8nqwfHBmFBE2T8HD/YcCm?=
 =?us-ascii?Q?WigB5ebCNdnZapWCrINBd+svECszBEZx28BExpyO5EWmG7LceMHKGDF/Yrzd?=
 =?us-ascii?Q?1ltUYcgnrJ3A2plGPcbnn4Pbw+u/w37l0an4pxxmrAswDTlsX8XNoUCFqi+8?=
 =?us-ascii?Q?Hf+Dgy2qSJF09Y15bHBD7K46GF8osx2RnvZNe67YecLYAH+HoZ30IuRO95aO?=
 =?us-ascii?Q?oICxDkbn7cmHrhZdv9Dok2Z5TvTj6m3e7n0vo3OKNFhHl8zQOnv5BFx8iEV2?=
 =?us-ascii?Q?Jruv3z5LXfh+hV/lWGjJLUtZgGKsLetSQC3uirCvCGo3LC1Bi2vDhqjgar7f?=
 =?us-ascii?Q?XZjO+UmUYYSk1CKl0HZLGfuNzyU9+t8iuwJIYaJAj847xLTO6a5qbqNQ8KFB?=
 =?us-ascii?Q?dN8Y3ClpQ7+jThk38utEiJlVzXMEgHRnzzOiS/PYOlm/21CCYwNThQxk1QjO?=
 =?us-ascii?Q?RjKixH8vPmujgcyKZOlxBv9q+ek7HM1/qBrwegD23MFVTUuhpk70wVFg26iB?=
 =?us-ascii?Q?+vd6sNxujwftHfDfz26INupPftZ6m+ziIj/vz7W0iUo3ggadSQj2imxODe+L?=
 =?us-ascii?Q?naVGzuB5rS/oSbnm1VaaznmGHcQnbIY4melKxBwcinHb7DyPTGRqWFqpxU/o?=
 =?us-ascii?Q?DeFnDM+FcgBtexu0j/9hw8ICsMwfCe34aENM6FSkLbR1poQ6kvoO2OKXcmCU?=
 =?us-ascii?Q?sjLwUIuKyPGe+IZt6OH3njTpxBENUW9eWhAiJOx5fJZDzNwFmTV8sozVPX5K?=
 =?us-ascii?Q?AsXTjD3kIV39FrvdeVkBIGvnc8/e+5TBrWRd/3JPTUz5kF+VeKqY6WFf80MK?=
 =?us-ascii?Q?NBDG2uIkaZURx7V8L2fkY5laGRxfNyN/9Z4PyWeEis24Ah6CnYPwAmHDYKzZ?=
 =?us-ascii?Q?nrR/1KktA58mwWCl50+1zEsGD0zCjl5Xk2Z3iPdm73k3zvZTf+QNDIBY36F/?=
 =?us-ascii?Q?aV3F61E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?43UBPa+lueESDSdVgECp11SH17Ci94RNEuAHDNJAW+H5KPd331+IHpYUWcoE?=
 =?us-ascii?Q?QEBaPsKNKXpsnS0qTJxSVOQV16tlwNO8Lu5pc3+fcygm5WaSILeo5mNwbisC?=
 =?us-ascii?Q?WW7JBjOvujj/F2TdPlsHe7a51BOma9zf4V6zNOuek8ZNdi6XL+jl7gveevG2?=
 =?us-ascii?Q?bp6lP3frEKIyQBDKjgO9NO+VMDZDHCO9n5LpKnI1bCkrKX38q/E4a0I5O9Fn?=
 =?us-ascii?Q?2Aqvy5GCPst365uIYWBBdzzVzpukOAnSLfvPdylaESIdiFqEfFiog6MyCfsL?=
 =?us-ascii?Q?bC3VRZiGZf3MUCoTY+R0Eavko/MxmAvSA7N/6ZQL3ubvjdloENxk5TJ/rbaN?=
 =?us-ascii?Q?STJ3uzbff4+5XlFMFq2tOfEMAukpWq8yyrpfq1GjMT64kgNWbG49CG/3Vm89?=
 =?us-ascii?Q?YTm8pbtEbxHTezGackJveTeIt0h7OmvMCbkHrjAVvfcVIKTbJw/PXCiyW4Xq?=
 =?us-ascii?Q?Tq9ozT9nmbdzfGpM83Mt2RO+tkZAH59fapeEvvr802kHdqDbT4Hc6N3lkUE8?=
 =?us-ascii?Q?X0z/xybj8imyeWJ2amKkE70lZCyTZ5sgYeYP+QZrYt1hN3PXTR/TshO6+Rep?=
 =?us-ascii?Q?jseM8aj0Z/LeUd2NVWg9x70dDQSt9wTxEjDNXZQmGhzSVTRkGUr5fdqvtfCi?=
 =?us-ascii?Q?DbVHxHVUecIBtSvImSa05EsuY7PxIBbZzCN9yZWjuF8C44gKeaGBagoabzEX?=
 =?us-ascii?Q?GoAmZSZJ2o/LPBAuhzQ2B3G34xZtx0Lf+NCDOVmjsvdkiG3fpVYBGANito/5?=
 =?us-ascii?Q?+aDJ/UV1Wi7c1NzR2aE/iZ/5bSLfuL5YQidCD7nOnOX22MAW1nF/Incnzbar?=
 =?us-ascii?Q?Z0Rr7YCNCBJRipRopMWhLH02mAoZmuSvJLsT+FflxPlCNtqiEX/hkUcxsHJU?=
 =?us-ascii?Q?4BjOEbCoQ0wDm9Pq9UTTBpLln8dZ+C7H0y7JMDsAibsOGxwKQ80pgG5DxSMU?=
 =?us-ascii?Q?55GawHdu7J+s9Mdakiv+UBcKMbWkkKm61j12NoK3a3wEb1CN8WHSpfKmyMyN?=
 =?us-ascii?Q?BKQHhissLqFH30VsLCdLEdL72EOzfkh1Ob6hbjIqr8f/4SeN/6l2vVCIokPj?=
 =?us-ascii?Q?hnoJ+byuPg3e7mOmjyyybib7QLOuHKIhn4ghcfCR+NSJrY3oOxh+nK1+0KKH?=
 =?us-ascii?Q?GZ0DZ2XQj7Cmsem5jTdZXCc0KjCtYxmdFaOH8Ja+M8WWEc/IzYUY+wp6KeJs?=
 =?us-ascii?Q?NYnl7//CJWHe4Wxr9YPuVSABDhMMPsLT6YzWqz5v/88d8eC+k6OiMv4R52t5?=
 =?us-ascii?Q?UyKjvUYf/JQ3N1elqL4sXkqiFSXMQKZCIxkCKkPcSTIElsGbsd07m/MmkVuV?=
 =?us-ascii?Q?3FRWpvYyqJ+EVrPm5dHqAVILf2xfPA2tji4Sjm7K5j87+5dPAL4vzXid+39H?=
 =?us-ascii?Q?CCGhCbiGXh/0EtM11Iu1kuzu85wPb5VxasqurRYlsM5cz6uwCsTM6RNPhylE?=
 =?us-ascii?Q?a9nh70MVc1eNMqpTL+goVdvglD4ReSfF08+7cHzF3/NdBb+b0PDlxAvbqg0w?=
 =?us-ascii?Q?m+qHLNGsjjzUFrWyuJBukcSPHkoAwgpLe9U4o5FBbipXCfi3WLI4oIwl9OgX?=
 =?us-ascii?Q?hp3saiB8C/BDDlomAoCXEjG1smaM+8AiHekBVzW0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AwMvr9tbnK2w2wtdCAFhRQ519u8/zRZh/X4H2Mrhb7Dxa7Z9SGW7h9nGNNFTPD1pKoroKrk7RsA7pQLXPO0qUd51e21SGgGn8rGr9xxpK7Ub8qEsNZzZrCiKjeQuh1j+bphvXcWyb8VbH+RS23Rd9ZJle3tZ8HThbNReg/Uwqe2s8SN2fivX5YuoBpLkgHD24TkIHBhUznVHXjplyJWwZDt4OQAVH2MKazJtmtvxAjGU0Pr+TNW2iR6WbF8YQr5bQ+XwsCryxRHBbJ2lYkkjcjvxqL1J4nIu7dBy+vf+wA1xtEBYluaIPto8qNbfuXLaCN2cKV58sEHsGLYk7Cggy8QJtpbhWwItHw0f0Htv/+eXrLMIOiafIV2Phpvu1CYlbjOvixMEOUZC/ngmM+/vTujBf+kQkMLHbxdh1VIQqU6AWBCrJX5qre6E2IyhlrIlm43C7HM+gax1PZKfYeIP/Hm54EYypfo0zdUvmDuq4a3YSmWW81ZE8b0hMsWtLKz70cA3EGMhX+nNZSND1ZBWlKASMme7bhOWQOGEtJjwj+ZWFbquADsY5dQsfV4yslGe7GvMIG5M9FePiOWiaAs/IEUlFZJ7cQvJB463dgo8xuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bcedd3-ecc0-4395-576a-08dd83073c1a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:08:45.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FGewwUUJFX70P3RGHG7febemAHooAv6+lGnoR3Eiey8mjoGXjWUSK0XSWM6m1rKR32ZL6cfRKvSTp4aF+T7Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240053
X-Proofpoint-GUID: Hn3Zr6g6TBTcvKJzhUWOXGm53UDAuChD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1MyBTYWx0ZWRfXwf69TNGJ1ImM puS++nViVxfoyGD7zKj0dI5SA6nrPd61LDDLVMfh/zMuEtZRsLo57RoP3BS2p8KuCogQ8ONzEZv ZwsixvlWsWUFvV+QF0fAnZ3x28KrppwRvyivboyGNPm8oR1E4G4A9w4yyh4lNKeJ2SKCJHrj2eO
 UaKbNUw4zTftF3gpci3EbUYUAB2TtFmyIxlAew4xm8leAjBD+joTcSmHvX1X1ZC6Yj/Y6zqNUci 2wuzglzz4fr8Hs50/w0qmpqm7K2uJvUElJVbI1MMj/SOoPZm4D/JFvR7rDQmb6/Bur17EVVZ7GN gCbLbltwrbOKRn9unAI+I2uI7Zrrgld8jHETZGRICOVAV1Lx4nv2xNBJ4cwRXu43y5EQi0VxD49 I3uVKZmZ
X-Proofpoint-ORIG-GUID: Hn3Zr6g6TBTcvKJzhUWOXGm53UDAuChD

When initializing newly allocated mm_struct, mm_init() allocate
two chunks of percpu memory (pcpu_cid and rss_stat). Because percpu
memory allocator uses a global mutex (pcpu_alloc_mutex), it becomes
a global serialization point for exec().

Use slab ctor/dtor pair to allocate and free percpu memory (pcpu_cid,
rss_stat) for mm_struct. mm_init_cid() is moved to mm_init(), and rss_stat
percpu counter is charged in mm_init() and uncharged in __mmdrop().

As rss_stat and pcpu_cid fields should not be overwritten during
memset() by mm_init() and memcy() by dup_mm(), move those fields to the
end of mm_struct. Any field defined after 'ctor_fields_offset' won't be
overwritten by these helpers.

On the other hand, while cpu_bitmap[] is not initialized by
the constructor, it should always be at the end of mm_struct.
However, as cpu_bitmap[] is always initialized by mm_init(),
not calling memset() and memcpy() for this field does not affect its
current behavior.

Note that check_mm() validates whether any rss counter is nonzero
and reports an error if any nonzero value is found. In other words,
under normal conditions, the counters should always be zero when
an mm_struct is freed. Therefore is not necessary to reset the counters
in mm_init() once they have been initialized by the constructor.

To measure the performance impact, I ran the exec() benchmark [1], which
launches one process per CPU and each proess repeatedly invokes exec().

On a desktop with 12 cores (24 hardware threads), it raises
exec() throughput by an average of 4.56%. Even in a single-threaded run
I see roughly a 4% gain, showing that the cost of acquiring and releasing
pcpu_alloc_mutex is significant even when it is uncontended.

On a dual-socket server with 192 cores the mutex becomes a contention
hotpot; mitigating that contention boosts exec() throughput by 33%.

Link: http://apollo.backplane.com/DFlyMisc/doexec.c [1]
Link: https://lore.kernel.org/linux-mm/CAGudoHFc+Km-3usiy4Wdm1JkM+YjCgD9A8dDKQ06pZP070f1ig@mail.gmail.com
Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/mm_types.h | 40 +++++++++++++++++---------
 kernel/fork.c            | 62 +++++++++++++++++++++++++++-------------
 2 files changed, 69 insertions(+), 33 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 56d07edd01f9..3000ca47b8ba 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -946,14 +946,6 @@ struct mm_struct {
 		atomic_t mm_users;
 
 #ifdef CONFIG_SCHED_MM_CID
-		/**
-		 * @pcpu_cid: Per-cpu current cid.
-		 *
-		 * Keep track of the currently allocated mm_cid for each cpu.
-		 * The per-cpu mm_cid values are serialized by their respective
-		 * runqueue locks.
-		 */
-		struct mm_cid __percpu *pcpu_cid;
 		/*
 		 * @mm_cid_next_scan: Next mm_cid scan (in jiffies).
 		 *
@@ -982,6 +974,7 @@ struct mm_struct {
 		 * mm nr_cpus_allowed updates.
 		 */
 		raw_spinlock_t cpus_allowed_lock;
+		unsigned long _padding; /* for optimal offset of mmap_lock */
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -1059,8 +1052,6 @@ struct mm_struct {
 
 		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
-		struct percpu_counter rss_stat[NR_MM_COUNTERS];
-
 		struct linux_binfmt *binfmt;
 
 		/* Architecture-specific MM context */
@@ -1169,6 +1160,30 @@ struct mm_struct {
 #endif /* CONFIG_MM_ID */
 	} __randomize_layout;
 
+	/*
+	 * The fields below are not initialized by memset() or copied
+	 * by memcpy(), in order to avoid overwriting values that are
+	 * initialized by the slab constructor.
+	 *
+	 * The last field, cpu_bitmap, is an exception. This field is not
+	 * initialized by the constructor and is always initialized by
+	 * the mm_init() function.
+	 */
+	union {
+		unsigned long ctor_fields_offset;
+		struct percpu_counter rss_stat[NR_MM_COUNTERS];
+	};
+#ifdef CONFIG_SCHED_MM_CID
+	/**
+	 * @pcpu_cid: Per-cpu current cid.
+	 *
+	 * Keep track of the currently allocated mm_cid for each cpu.
+	 * The per-cpu mm_cid values are serialized by their respective
+	 * runqueue locks.
+	 */
+	struct mm_cid __percpu *pcpu_cid;
+#endif
+
 	/*
 	 * The mm_cpumask needs to be at the end of mm_struct, because it
 	 * is dynamically sized based on nr_cpu_ids.
@@ -1348,12 +1363,11 @@ static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
 	cpumask_clear(mm_cidmask(mm));
 }
 
-static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
+static inline int mm_alloc_cid_noprof(struct mm_struct *mm)
 {
 	mm->pcpu_cid = alloc_percpu_noprof(struct mm_cid);
 	if (!mm->pcpu_cid)
 		return -ENOMEM;
-	mm_init_cid(mm, p);
 	return 0;
 }
 #define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
@@ -1383,7 +1397,7 @@ static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumas
 }
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) { }
-static inline int mm_alloc_cid(struct mm_struct *mm, struct task_struct *p) { return 0; }
+static inline int mm_alloc_cid(struct mm_struct *mm) { return 0; }
 static inline void mm_destroy_cid(struct mm_struct *mm) { }
 
 static inline unsigned int mm_cid_size(void)
diff --git a/kernel/fork.c b/kernel/fork.c
index 7966b0876dc3..5940cf37379c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -943,8 +943,7 @@ void __mmdrop(struct mm_struct *mm)
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
-	mm_destroy_cid(mm);
-	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
+	percpu_counter_uncharge_many(mm->rss_stat, NR_MM_COUNTERS);
 
 	free_mm(mm);
 }
@@ -1295,7 +1294,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm->map_count = 0;
 	mm->locked_vm = 0;
 	atomic64_set(&mm->pinned_vm, 0);
-	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
 	spin_lock_init(&mm->page_table_lock);
 	spin_lock_init(&mm->arg_lock);
 	mm_init_cpumask(mm);
@@ -1328,21 +1326,17 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
-	if (mm_alloc_cid(mm, p))
-		goto fail_cid;
-
-	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
-				     NR_MM_COUNTERS))
-		goto fail_pcpu;
+	if (!percpu_counter_charge_many(mm->rss_stat, GFP_KERNEL_ACCOUNT,
+					NR_MM_COUNTERS))
+		goto failed_charge;
 
+	mm_init_cid(mm, p);
 	mm->user_ns = get_user_ns(user_ns);
 	lru_gen_init_mm(mm);
 	return mm;
 
-fail_pcpu:
+failed_charge:
 	mm_destroy_cid(mm);
-fail_cid:
-	destroy_context(mm);
 fail_nocontext:
 	mm_free_id(mm);
 fail_noid:
@@ -1363,7 +1357,7 @@ struct mm_struct *mm_alloc(void)
 	if (!mm)
 		return NULL;
 
-	memset(mm, 0, sizeof(*mm));
+	memset(mm, 0, offsetof(struct mm_struct, ctor_fields_offset));
 	return mm_init(mm, current, current_user_ns());
 }
 EXPORT_SYMBOL_IF_KUNIT(mm_alloc);
@@ -1725,7 +1719,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	if (!mm)
 		goto fail_nomem;
 
-	memcpy(mm, oldmm, sizeof(*mm));
+	memcpy(mm, oldmm, offsetof(struct mm_struct, ctor_fields_offset));
 
 	if (!mm_init(mm, tsk, mm->user_ns))
 		goto fail_nomem;
@@ -3193,9 +3187,40 @@ static int sighand_ctor(void *data)
 	return 0;
 }
 
+static int mm_struct_ctor(void *object)
+{
+	struct mm_struct *mm = object;
+
+	if (mm_alloc_cid(mm))
+		return -ENOMEM;
+
+	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL,
+				     NR_MM_COUNTERS)) {
+		mm_destroy_cid(mm);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void mm_struct_dtor(void *object)
+{
+	struct mm_struct *mm = object;
+
+	mm_destroy_cid(mm);
+	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
+}
+
 void __init mm_cache_init(void)
 {
 	unsigned int mm_size;
+	struct kmem_cache_args kmem_args = {
+		.align = ARCH_MIN_MMSTRUCT_ALIGN,
+		.useroffset = offsetof(struct mm_struct, saved_auxv),
+		.usersize = sizeof_field(struct mm_struct, saved_auxv),
+		.ctor = mm_struct_ctor,
+		.dtor = mm_struct_dtor,
+	};
 
 	/*
 	 * The mm_cpumask is located at the end of mm_struct, and is
@@ -3204,12 +3229,9 @@ void __init mm_cache_init(void)
 	 */
 	mm_size = sizeof(struct mm_struct) + cpumask_size() + mm_cid_size();
 
-	mm_cachep = kmem_cache_create_usercopy("mm_struct",
-			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
-			offsetof(struct mm_struct, saved_auxv),
-			sizeof_field(struct mm_struct, saved_auxv),
-			NULL);
+	mm_cachep = kmem_cache_create("mm_struct", mm_size, &kmem_args,
+				      SLAB_HWCACHE_ALIGN|SLAB_PANIC|
+				      SLAB_ACCOUNT);
 }
 
 void __init proc_caches_init(void)
-- 
2.43.0


