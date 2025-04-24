Return-Path: <netdev+bounces-185435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC368A9A59C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC65D3B9694
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9369320D517;
	Thu, 24 Apr 2025 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hYbU/Hhc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O0SkN7mD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456D20ADD6;
	Thu, 24 Apr 2025 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482674; cv=fail; b=uHx4vb+rci7QV5EnCX1x2dQdZImF9rnZ3io4bgsskCJVTFbKLjHuu98RLRY1osW0qjTTCFj60bQ/QzGdvegqVcGXlgxim/jbWNWLH2WIeAneEoPZZOs1qS/b5xwweBN0d+OO/J1XSEa5m/b0pCX4qcLQKcxDb7f559fEGzM4iB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482674; c=relaxed/simple;
	bh=jISeOmo4VG4oEnl/prP0K9oZO06XbRY5I7WDfhjFmUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=duvMJ2VNE1Gw/CtTWTTx/Xj5hhj4Ne7uY4EZd9bf7uFHqHtNgb1hfoKpO0hpJPzw2oC4HaguHzGTwnU4Rg7t9bFmsYqkiuoYbbwI+Y6OB74DpoEK3+fCcJAgYTGeHJ0RwgxGUYGGsKjawXdNRLkJkYIHMvar3VatiC6R32E5XJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hYbU/Hhc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O0SkN7mD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O6ttQW005503;
	Thu, 24 Apr 2025 08:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UHXVQICH9CKjOW2c0wTbDGV4qijQ2xd9nAtxR1Xijsk=; b=
	hYbU/HhcCFVDg6SCmQHmySoakvg2sz84XzDmIGqkYu0tWRCOBtyxDmWncoVznQKp
	WUwsbbTYAcMEQfxMJhi/JAaZX62l47RCftr7KvLQtvmICLcwivOvWQ8AvNTpUv8Y
	gQLcGQhDk1EPTFcmKeFfLmd/INfGZQJKp4CnM5RAUU8MeWWnTvQwQFdKNnRZ6qpF
	65DnYufk5bmNhkoOAsIuTxfLthHrFsWjBRyZaMfIt+yXq6bhxNz7X5a8lKGR6djY
	KQVNKHAWgmvSU+f6sTRWK18wXp4DVBf308Q97PbuaznQ7U1/KDNEwZ49Q2jBG23X
	o6X73jztCLzyP7ZNS+4zrw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467fmk86pj-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:17:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8832e030957;
	Thu, 24 Apr 2025 08:08:35 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012050.outbound.protection.outlook.com [40.93.20.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k06xrde-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQ477F5hLcVpGZwXr9vhizc1HypOKgDqNXtmsMzcQUF0t87YkGOGTTgD1r35PhLA7zOQV/7eJhu3hDdNWR+b7KR1jUHXtl/W0hCmXT3sUqq4JsKmoBqmXug0om7xFrCULk4UwK71MM89B/UDjOD5U26T7fq3IiKKGmxncUHvF0xSUQTvv41HpdaZOyQlYRqo5ZjupRI5FIYQTcWv3f5VdhFiF18DYLg+81sTBvppd+I6rIw4IW6pexmsUxQ+QXE48dVklGIFyjavEKMRL1WhnAmt+ZpgVttR4GI3BFg5MCkFjhMCWl05h/6siN/lE6p7wDayBtwY032BlCFU/ss3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHXVQICH9CKjOW2c0wTbDGV4qijQ2xd9nAtxR1Xijsk=;
 b=Nj4H42VMUK/1kWSeoNVW68MnylvmcuBy8rCFFgEmolOpnkbXWDqp3Z28s4hlkNLtgS7k0oBDBgjsnQXOQSDSVFFoqps9N1qN0A27imNh/7FKHRcZCIn8Uu/4Pfyca5b3RlnX4DQr1FR7TSOXnW7f67vk/jm9cl3dN8lhlifvq3pcl8mrOHozacmwYn3GMOJnbyAkYYOa3HMhDAT2X3PmwdgHP4fo1XyLWccULjOmcRyjCrvVmR8T1vCj9QELtGIprGZDIfUCZsykDaoYt/MxMme6lDBCdUpcAQT5gYScaWb0qBXNcUbTPwyzzV5X5JVDGcOHh/JrNRaSQjpgVMR+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHXVQICH9CKjOW2c0wTbDGV4qijQ2xd9nAtxR1Xijsk=;
 b=O0SkN7mDETOEZkKMQOMUzVbuSVT1vrUjZUW+2deAn2Cdxb6KoQvR1GheNZPALaRUhcnRZuFcw+QE291KwGaoqxl+ctKEl9Hi5G+L2ZYHsm2lq6r2Ars1YgTKEKG+wG6XMkKd1M8u6Ebdd0HEEmcxVjqPgjnqG6Z68TWpjtLhtuQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB8156.namprd10.prod.outlook.com (2603:10b6:408:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 08:08:16 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:08:15 +0000
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
Subject: [RFC PATCH 2/7] treewide, slab: allow slab constructor to return an error
Date: Thu, 24 Apr 2025 17:07:50 +0900
Message-ID: <20250424080755.272925-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424080755.272925-1-harry.yoo@oracle.com>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0043.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 2911013c-3806-44e4-8781-08dd83072a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jAwt8NVV6cLVjtazlqAqY1kOnUs7wjtMtDQgBEicwD9Kd9pxGUhbzjuk6Nk7?=
 =?us-ascii?Q?kEJVSQPHjC4unI5Xj1TZzvVhz5QEVP8lQaqo9euPnzlwC/Ht6q/dObWGHSMk?=
 =?us-ascii?Q?XjdCuPyidEKy3hLEElb90nftfREu6sf71AXq8Wf5vScZP68gJQ95lWJ/yKCJ?=
 =?us-ascii?Q?iS6JLeCTxd3bo7rMad363pIrd1fk9lYtPRbuSR9csALZiHeMNGzmAc0HnF9J?=
 =?us-ascii?Q?9wpukegY7+8FLqmU3kgaNQdjGGYQfDWq0FaNVDkRft60CicYSqMODuYYDU9R?=
 =?us-ascii?Q?bVn80E37Ir3H8smW1p7zvYf8uz6HV6pYzYRNQiSdL5s1uIUG0F5ni/GgJLCi?=
 =?us-ascii?Q?SjN8GeEyW94rYw80cnZ/NsTDk5l9UCivTG0RMcybGZTXACP7h9FVV6lymi60?=
 =?us-ascii?Q?ulOUYYRZQwsG2L2LGDbArUxb3/a/7qmH1YJl1sKKdxBuxAVEUJreRl/QOE0X?=
 =?us-ascii?Q?kl1oLpHYaO2ScVdEDvsrEPemRxaEqR0NZSYgsviMOxZP7zMBjHjMJCxL63rQ?=
 =?us-ascii?Q?wGE7DnFe5pfTa8lfIWQhpCwHJg/Fvf38CP14x6H1E9EfzE5yeJ0FcellivUW?=
 =?us-ascii?Q?AWpb96tmGuaE00/GWP/vTCxVNpATkS6gQgzkEDaOkKexyFyIOEyYSBXgDRvl?=
 =?us-ascii?Q?CAH6vMcPO1bGcQWMFxnfa6yTaaqWBb2XzkhG7IjLpGoJixybpuXusbe7wI9l?=
 =?us-ascii?Q?0b/H9HYQ6gKNHxc+OKGG3GwP7A3SbvILSXc0cimTF/nhnb6ZTcgwY+hiFFtK?=
 =?us-ascii?Q?0sRQn9OEZrJ5xizpM5eciz4B1YIhJ1LTvkZ8JIKTb9kSkJPrjIz4mvG3MGSr?=
 =?us-ascii?Q?F6cM20v3ENTZoFOQIOUNqBnLDVYl+vp2epbPdzAZPfbIcBMmu8WiQpLHVBlx?=
 =?us-ascii?Q?sdzzXVQC2hMBXk5aa4RzElihja4iYsSabM2du9MRFn0bM22esBYc5IAydaBU?=
 =?us-ascii?Q?xAkMCWzBFPekEiyHG5NXu8wlZW6/Qjiw4eyZlNpBv52o/jwO94+UWu0q8CAA?=
 =?us-ascii?Q?4JaKWhaGdz6J/dCn27vYmoz+1lvgUH5xRf8dR7B2k8etMxf46ctfJtyvaH61?=
 =?us-ascii?Q?ibHvf2KiY2yO6jzpSu5DdlIX+oWUw53b5Zwh9g7hLQOdfS0B3NhLVWtTB87s?=
 =?us-ascii?Q?Mw6v5SOsNsLSmGfV4JZ4VKcy3JrKiq31zXwoa4lfrrBB2pDiCwynEQELXRY7?=
 =?us-ascii?Q?ELk9PQ4mjqtnVtrDc548E5OM1jVaw/W4GAri6D6al8nAZVHmKN/gjOGvKxxQ?=
 =?us-ascii?Q?zZLnat8HOvELCb5NUUJWaVXSDDZu4cLxSkUa2dU5fcayW0ucdhGjzBGOiG3Q?=
 =?us-ascii?Q?DDX1c2FBu1I1zU1x0rAdq91ZthW4sIvXvSspXxFODgM1+YsLjv7XqaMj3CAE?=
 =?us-ascii?Q?mV3HHdXQDgtwD1SESwUxcd1TMUEXPPVfbe1hyuzD5l/GQOWxL3PIahu36JRy?=
 =?us-ascii?Q?gzL2nYHAGas=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1nE71jcw8CneZIni8Xhk115i/Q/NiwjJsO815K4/MjsJj5gE1Cto7iScwf/?=
 =?us-ascii?Q?0E6+SBku/rpDmWi7Nk6fQOmo2MwduzxlmoOOXfQl10d+SYE+bSeF6RSROUEs?=
 =?us-ascii?Q?J4ctg3kVIzsF5+aEBhJBChx+GUgFg/g5/7AjU/JOJ1tQyUg4CFnEWwhwz9Ox?=
 =?us-ascii?Q?Ni2RvlJq5GF2OFrylXKBCnSgfIF5ES1jMDIzTJfjTtPYxqYoiEJiPtrliXWZ?=
 =?us-ascii?Q?ct1HMEsIstfLytYG1h7+GT8Q8aodBVHq35V4SHZ9aCHF2uu/Q/JwDJZngNcc?=
 =?us-ascii?Q?SHvUQhfHRL1oxS/zZcnb75fkOMHeVzBexhnHWJ/TkbzT3J7QNIz8gWLsESW5?=
 =?us-ascii?Q?N2SEVdyqNrGB7C17fVSOGRoalNz7NYHw4cMcZpCG6fwUuiq+97jiTmHuo6xQ?=
 =?us-ascii?Q?rqdvs7zHP8gmXYXccczA5S6R1atLeafTVetqAtAGdMRvdu5pjw7xmBOEQPC5?=
 =?us-ascii?Q?FV042PmCwjkG4Z15S3JG+Car0fX57iwwMQHqbW3tj5la40Fm2tIzULYVM6a1?=
 =?us-ascii?Q?Oa+hfH/DkVLeAZM+HaUbnAgjdtXx56irHNTaBihRqRvpr/DyYDGvDJP1GM5a?=
 =?us-ascii?Q?ph70hevpx4tm+O7+5C+l6I3dCQwCWokIGgQnrXiAEu+mjVje4Z/ku2RrsyvZ?=
 =?us-ascii?Q?n6AMFci6H43Hard/ZFpNHSwQhwmY7S2W8hTIDGPLGiV1BY0BpB3rOv4WxwQZ?=
 =?us-ascii?Q?6jVtc2Txbg+RuxQbvHG6BGUy4rsK/UzCdojFd6nr5QCaIhlapXyYHpSIPIOU?=
 =?us-ascii?Q?8yw0aiBYUpHfdFHlKLpr9bqniFXPMp0W8xHuo8T/Geuqfmu0NWnbc57Axuek?=
 =?us-ascii?Q?9ZuipxfClrVGIAfmvq1IZc8M/wf6q9I0Fsm7akG2jOH5V0e5Wjb4mczl2Wcd?=
 =?us-ascii?Q?00hRvpBPc80xOVu3Ptlu1cT9ZR1aM2KoHUrJDKAkda5E89DAMHeYrFFabmtD?=
 =?us-ascii?Q?pQ8ffYcIsu03h2zPf5DenFZ/8S9InpdGZ5pKhv3d/fWx5KYe0P1buNQc6XxV?=
 =?us-ascii?Q?pQdhqJfdeZaq80mBmq6DqgsI5NC11y5P3rNUJ+nVULB/QB+zws4O6AMyCtRn?=
 =?us-ascii?Q?bD2QpM37sWwbsP5iIyoGuDecdFVQi4nUyeoKOP7HAycGwBXJas0vwJu7s9PS?=
 =?us-ascii?Q?tTXdujMoXBQuGAfxCUz8Z36zOyXm1er/aHKPSevA65mDdOkvnN3S/UIAvimN?=
 =?us-ascii?Q?qK98EG6HVvDl2HsoTcvFG119d7LiTEwELUNMglo2gr9ZCXYto0qlSXLQtls8?=
 =?us-ascii?Q?D/sCqc3jr4y/pwvqDHfb2fTn4is5roqnoCb8o0TaWeFf4+JYS/Lygq2sxzJA?=
 =?us-ascii?Q?GtEqR3ZDznCmXOtfKKo9AX7qxL00As3Kk6WUmDsVJ6ausz2oVBdvbf230LhB?=
 =?us-ascii?Q?6Yxy0Ml4Itv3Aleqlrw7+KdV2KtHRX0rDiajd6LihLReszz3bpxBXq+pKQGs?=
 =?us-ascii?Q?21flOJgdplz86MwFnivy0PPauF1VHvECLpa/R5hc4/uJjOsJklyU7wQDzFxp?=
 =?us-ascii?Q?hh8Rksl4I8RlUCKyES2+sJfxu3UdwkzAx/PfBEsXsJyXADMo6IjWkyM9+wTm?=
 =?us-ascii?Q?FmpzCCKwLhgzV+MqXlg3bAIoAWmZX8vYdcfYKGH3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MOrZeyTrShSLKDCE5Xl0maLpDMf/tDqxRRjO+Gyhq6GFGi3+xOj3d4YIpbme8NiGfuMaf6WAYHiq8vV2KuAFJGLrOxJILYejYUzFBF0D/jYXZ/gopg+UC0DpXnASeczucFwgG2+Or3oZOfYBXeLsu78Fnm7sUnETTmNzRamTvgW9LDbzLnvfI2eT/o5hLTuElng8FmSS/ehVZNRxob52D0Jc21U67cGqNz1zuliOCa7OFnTMWwI4S7BRrYgp5reGfYuXSdSNkUl48UD7Ym3fESFp2iiWkxuNZRkloOeL79vGTHc89l3VH9U/MPFtU77PjPplyegPigHC0BMlJXY5HeQrDapB+gAInhuCWi2NoodRTJ8SKpNnPbarD0P76HOvN8jMjbYWV1nRj6GC+T3QTUasBPtZmI2926o1rQsdhYD00sRU89Xnl0cakaJ/OqoAQEr3bkH/DtInP+cD+rPwy6fZeKQHnWfZEaUmjMBDUaTGMnwhHdhlj8Oqljsx6RspvYXv8+OMc6M1YBsRLBqOSohXiF/rksvM429+aTi/94oE+fwoceYD7DW/JkSwpQFWjeiWpgFRf0gBQK74Y+2fjTfUmSWFHHjH1Is0ZArWJQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2911013c-3806-44e4-8781-08dd83072a65
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:08:15.8928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Fx6ksrV9iIMhu3U6NmFGYmklF+xshzzCoR/x1HaKrPiivANE8hTLvJQBSovWV6HsuvUwQLaVbUb3/SdjnuPLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240053
X-Proofpoint-GUID: OrV1V0ZkBouvSwZOt9AxxYegwrLuqCSH
X-Proofpoint-ORIG-GUID: OrV1V0ZkBouvSwZOt9AxxYegwrLuqCSH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1MyBTYWx0ZWRfXxmc7+8mB4iYY ic5HQm1eKDPVI35eO0MYgKZn5UfqyRd1jQsMFwyxPNvJLaQS/iPitXYc19+9JBkDkx8MWWBUxic Ag5TU6H9Ox3pJEZ1tdZSy9IXbdFG2p3G+fBpf21qzRQ0hPGf76qWUZPeuRf4pjqYVE7U3GXLC8h
 ExCshZsGlpwvSfT3DP7AE5Anj7yZDRJgkf6/CyM7hLStjaJ/Notfzdahkhdknj34WrPADXZd2qV tZtl3ZRyXe502cw7JHr+yJyxCifYAb78VgNmeWJJDYSg6HI2XRKQAJ23W/s1TJ5q2aTou3JyZsi PFny3EidpUqznqlQnQgzN9cU1+STIQGSNuXDeHn2EVNsgxVEr3TaL37MhVxRfwb9BNUm72Ud8YA tIVbj9Rc

From the beginning of slab and until now, slab allocator has not allowed
constructors to fail. It made sense because operations like spinlock
initialization, list initialization, and memset() do not fail.

However, Mateusz Guzik explains [1] that allocating and freeing percpu
memory for each slab object's lifetime suffers from the global
serialization point of the percpu allocator.

That said, allocating & freeing percpu memory in ctor/dtor pair can
significantly reduce the contention. As a first step to that, allow
constructors to fail and update all users of the constructor feature
to return zero (no error).

When a constructor fails, allocate_slab() returns an error.

[1] https://lore.kernel.org/linux-mm/CAGudoHFc+Km-3usiy4Wdm1JkM+YjCgD9A8dDKQ06pZP070f1ig@mail.gmail.com

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 arch/powerpc/include/asm/svm.h            |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c    |  3 +-
 arch/powerpc/mm/init-common.c             |  3 +-
 arch/powerpc/platforms/cell/spufs/inode.c |  3 +-
 arch/powerpc/platforms/pseries/setup.c    |  2 +-
 arch/powerpc/platforms/pseries/svm.c      |  4 +-
 arch/sh/mm/pgtable.c                      |  3 +-
 arch/sparc/mm/tsb.c                       |  8 ++-
 block/bdev.c                              |  3 +-
 drivers/dax/super.c                       |  3 +-
 drivers/gpu/drm/i915/i915_request.c       |  3 +-
 drivers/misc/lkdtm/heap.c                 | 12 ++--
 drivers/usb/mon/mon_text.c                |  5 +-
 fs/9p/v9fs.c                              |  3 +-
 fs/adfs/super.c                           |  3 +-
 fs/affs/super.c                           |  3 +-
 fs/afs/super.c                            |  5 +-
 fs/befs/linuxvfs.c                        |  3 +-
 fs/bfs/inode.c                            |  3 +-
 fs/btrfs/inode.c                          |  3 +-
 fs/ceph/super.c                           |  3 +-
 fs/coda/inode.c                           |  3 +-
 fs/debugfs/inode.c                        |  3 +-
 fs/dlm/lowcomms.c                         |  3 +-
 fs/ecryptfs/main.c                        |  5 +-
 fs/efs/super.c                            |  3 +-
 fs/erofs/super.c                          |  3 +-
 fs/exfat/cache.c                          |  3 +-
 fs/exfat/super.c                          |  3 +-
 fs/ext2/super.c                           |  3 +-
 fs/ext4/super.c                           |  3 +-
 fs/fat/cache.c                            |  3 +-
 fs/fat/inode.c                            |  3 +-
 fs/fuse/inode.c                           |  3 +-
 fs/gfs2/main.c                            |  9 ++-
 fs/hfs/super.c                            |  3 +-
 fs/hfsplus/super.c                        |  3 +-
 fs/hpfs/super.c                           |  3 +-
 fs/hugetlbfs/inode.c                      |  3 +-
 fs/inode.c                                |  3 +-
 fs/isofs/inode.c                          |  3 +-
 fs/jffs2/super.c                          |  3 +-
 fs/jfs/super.c                            |  3 +-
 fs/minix/inode.c                          |  3 +-
 fs/nfs/inode.c                            |  3 +-
 fs/nfs/nfs42xattr.c                       |  3 +-
 fs/nilfs2/super.c                         |  6 +-
 fs/ntfs3/super.c                          |  3 +-
 fs/ocfs2/dlmfs/dlmfs.c                    |  3 +-
 fs/ocfs2/super.c                          |  3 +-
 fs/openpromfs/inode.c                     |  3 +-
 fs/orangefs/super.c                       |  3 +-
 fs/overlayfs/super.c                      |  3 +-
 fs/pidfs.c                                |  3 +-
 fs/proc/inode.c                           |  3 +-
 fs/qnx4/inode.c                           |  3 +-
 fs/qnx6/inode.c                           |  3 +-
 fs/romfs/super.c                          |  3 +-
 fs/smb/client/cifsfs.c                    |  3 +-
 fs/squashfs/super.c                       |  3 +-
 fs/tracefs/inode.c                        |  3 +-
 fs/ubifs/super.c                          |  3 +-
 fs/udf/super.c                            |  3 +-
 fs/ufs/super.c                            |  3 +-
 fs/userfaultfd.c                          |  3 +-
 fs/vboxsf/super.c                         |  3 +-
 fs/xfs/xfs_super.c                        |  3 +-
 include/linux/slab.h                      | 11 ++--
 ipc/mqueue.c                              |  3 +-
 kernel/fork.c                             |  3 +-
 kernel/rcu/refscale.c                     |  3 +-
 lib/radix-tree.c                          |  3 +-
 lib/test_meminit.c                        |  3 +-
 mm/kfence/kfence_test.c                   |  5 +-
 mm/rmap.c                                 |  3 +-
 mm/shmem.c                                |  3 +-
 mm/slab.h                                 |  6 +-
 mm/slab_common.c                          |  4 +-
 mm/slub.c                                 | 68 ++++++++++++++++-------
 net/socket.c                              |  3 +-
 net/sunrpc/rpc_pipe.c                     |  3 +-
 security/integrity/ima/ima_iint.c         |  3 +-
 82 files changed, 233 insertions(+), 120 deletions(-)

diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
index a02bd54b8948..0ebfbcd212cb 100644
--- a/arch/powerpc/include/asm/svm.h
+++ b/arch/powerpc/include/asm/svm.h
@@ -17,7 +17,7 @@ static inline bool is_secure_guest(void)
 	return mfmsr() & MSR_S;
 }
 
-void dtl_cache_ctor(void *addr);
+int dtl_cache_ctor(void *addr);
 #define get_dtl_cache_ctor()	(is_secure_guest() ? dtl_cache_ctor : NULL)
 
 #else /* CONFIG_PPC_SVM */
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index b3e6e73d6a08..9d6171d6db65 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -1230,9 +1230,10 @@ int kvmppc_init_vm_radix(struct kvm *kvm)
 	return 0;
 }
 
-static void pte_ctor(void *addr)
+static int pte_ctor(void *addr)
 {
 	memset(addr, 0, RADIX_PTE_TABLE_SIZE);
+	return 0;
 }
 
 static void pmd_ctor(void *addr)
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 745097554bea..4eb2cc44fa86 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -72,9 +72,10 @@ void setup_kup(void)
 	setup_kuep(disable_kuep);
 }
 
-#define CTOR(shift) static void ctor_##shift(void *addr) \
+#define CTOR(shift) static int ctor_##shift(void *addr) \
 {							\
 	memset(addr, 0, sizeof(pgd_t) << (shift));	\
+	return 0;					\
 }
 
 CTOR(0); CTOR(1); CTOR(2); CTOR(3); CTOR(4); CTOR(5); CTOR(6); CTOR(7);
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 9f9e4b871627..c654e95431fa 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -65,12 +65,13 @@ static void spufs_free_inode(struct inode *inode)
 	kmem_cache_free(spufs_inode_cache, SPUFS_I(inode));
 }
 
-static void
+static int
 spufs_init_once(void *p)
 {
 	struct spufs_inode_info *ei = p;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static struct inode *
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index b10a25325238..61f07df96f99 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -341,7 +341,7 @@ static inline int alloc_dispatch_logs(void)
 
 static int alloc_dispatch_log_kmem_cache(void)
 {
-	void (*ctor)(void *) = get_dtl_cache_ctor();
+	int (*ctor)(void *) = get_dtl_cache_ctor();
 
 	dtl_cache = kmem_cache_create_usercopy("dtl", DISPATCH_LOG_BYTES,
 						DISPATCH_LOG_BYTES, 0, 0, DISPATCH_LOG_BYTES, ctor);
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 384c9dc1899a..06af254bdec7 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -81,7 +81,7 @@ static bool is_dtl_page_shared(struct page *page)
 	return false;
 }
 
-void dtl_cache_ctor(void *addr)
+int dtl_cache_ctor(void *addr)
 {
 	unsigned long pfn = PHYS_PFN(__pa(addr));
 	struct page *page = pfn_to_page(pfn);
@@ -92,4 +92,6 @@ void dtl_cache_ctor(void *addr)
 		WARN_ON(dtl_nr_pages >= NR_DTL_PAGE);
 		uv_share_page(pfn, 1);
 	}
+
+	return 0;
 }
diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index 3a4085ea0161..ec3ea909b3bd 100644
--- a/arch/sh/mm/pgtable.c
+++ b/arch/sh/mm/pgtable.c
@@ -9,7 +9,7 @@ static struct kmem_cache *pgd_cachep;
 static struct kmem_cache *pmd_cachep;
 #endif
 
-static void pgd_ctor(void *x)
+static int pgd_ctor(void *x)
 {
 	pgd_t *pgd = x;
 
@@ -17,6 +17,7 @@ static void pgd_ctor(void *x)
 	memcpy(pgd + USER_PTRS_PER_PGD,
 	       swapper_pg_dir + USER_PTRS_PER_PGD,
 	       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	return 0;
 }
 
 void pgtable_cache_init(void)
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 5fe52a64c7e7..53b555ee9f7e 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -338,6 +338,12 @@ static const char *tsb_cache_names[8] = {
 	"tsb_1MB",
 };
 
+static inline int pgtable_ctor(void *objp)
+{
+	_clear_page(objp);
+	return 0;
+}
+
 void __init pgtable_cache_init(void)
 {
 	unsigned long i;
@@ -345,7 +351,7 @@ void __init pgtable_cache_init(void)
 	pgtable_cache = kmem_cache_create("pgtable_cache",
 					  PAGE_SIZE, PAGE_SIZE,
 					  0,
-					  _clear_page);
+					  pgtable_ctor);
 	if (!pgtable_cache) {
 		prom_printf("pgtable_cache_init(): Could not create!\n");
 		prom_halt();
diff --git a/block/bdev.c b/block/bdev.c
index 4844d1e27b6f..de4c231fbb04 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -356,11 +356,12 @@ static void bdev_free_inode(struct inode *inode)
 	kmem_cache_free(bdev_cachep, BDEV_I(inode));
 }
 
-static void init_once(void *data)
+static int init_once(void *data)
 {
 	struct bdev_inode *ei = data;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static void bdev_evict_inode(struct inode *inode)
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e16d1d40d773..3b3bf03d10cf 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -532,13 +532,14 @@ void *dax_get_private(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(dax_get_private);
 
-static void init_once(void *_dax_dev)
+static int init_once(void *_dax_dev)
 {
 	struct dax_device *dax_dev = _dax_dev;
 	struct inode *inode = &dax_dev->inode;
 
 	memset(dax_dev, 0, sizeof(*dax_dev));
 	inode_init_once(inode);
+	return 0;
 }
 
 static int dax_fs_init(void)
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index c3d27eadc0a7..70fbd2b34240 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -869,7 +869,7 @@ request_alloc_slow(struct intel_timeline *tl,
 	return kmem_cache_alloc(slab_requests, gfp);
 }
 
-static void __i915_request_ctor(void *arg)
+static int __i915_request_ctor(void *arg)
 {
 	struct i915_request *rq = arg;
 
@@ -882,6 +882,7 @@ static void __i915_request_ctor(void *arg)
 	rq->batch_res = NULL;
 
 	init_llist_head(&rq->execute_cb);
+	return 0;
 }
 
 #if IS_ENABLED(CONFIG_DRM_I915_SELFTEST)
diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index b1b316f99703..0a821503bb31 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -359,12 +359,12 @@ static void lkdtm_SLAB_FREE_PAGE(void)
  * We have constructors to keep the caches distinctly separated without
  * needing to boot with "slab_nomerge".
  */
-static void ctor_double_free(void *region)
-{ }
-static void ctor_a(void *region)
-{ }
-static void ctor_b(void *region)
-{ }
+static int ctor_double_free(void *region)
+{ return 0; }
+static int ctor_a(void *region)
+{ return 0; }
+static int ctor_b(void *region)
+{ return 0; }
 
 void __init lkdtm_heap_init(void)
 {
diff --git a/drivers/usb/mon/mon_text.c b/drivers/usb/mon/mon_text.c
index 68b9b2b41189..ef754be94b18 100644
--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -95,7 +95,7 @@ struct mon_reader_text {
 
 static struct dentry *mon_dir;		/* Usually /sys/kernel/debug/usbmon */
 
-static void mon_text_ctor(void *);
+static int mon_text_ctor(void *);
 
 struct mon_text_ptr {
 	int cnt, limit;
@@ -732,13 +732,14 @@ void mon_text_del(struct mon_bus *mbus)
 /*
  * Slab interface: constructor.
  */
-static void mon_text_ctor(void *mem)
+static int mon_text_ctor(void *mem)
 {
 	/*
 	 * Nothing to initialize. No, really!
 	 * So, we fill it with garbage to emulate a reused object.
 	 */
 	memset(mem, 0xe5, sizeof(struct mon_event_text));
+	return 0;
 }
 
 int __init mon_text_init(void)
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 77e9c4387c1d..a11a39d369c5 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -620,12 +620,13 @@ static void v9fs_sysfs_cleanup(void)
 	kobject_put(v9fs_kobj);
 }
 
-static void v9fs_inode_init_once(void *foo)
+static int v9fs_inode_init_once(void *foo)
 {
 	struct v9fs_inode *v9inode = (struct v9fs_inode *)foo;
 
 	memset(&v9inode->qid, 0, sizeof(v9inode->qid));
 	inode_init_once(&v9inode->netfs.inode);
+	return 0;
 }
 
 /**
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 017c48a80203..8b9df1dbfed5 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -212,11 +212,12 @@ static int adfs_drop_inode(struct inode *inode)
 	return !IS_ENABLED(CONFIG_ADFS_FS_RW) || IS_RDONLY(inode);
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct adfs_inode_info *ei = (struct adfs_inode_info *) foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int __init init_inodecache(void)
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 2fa40337776d..8cff0659d8f1 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -117,13 +117,14 @@ static void affs_free_inode(struct inode *inode)
 	kmem_cache_free(affs_inode_cachep, AFFS_I(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct affs_inode_info *ei = (struct affs_inode_info *) foo;
 
 	mutex_init(&ei->i_link_lock);
 	mutex_init(&ei->i_ext_lock);
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int __init init_inodecache(void)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 25b306db6992..e6a4473cf113 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -29,7 +29,7 @@
 #include <net/net_namespace.h>
 #include "internal.h"
 
-static void afs_i_init_once(void *foo);
+static int afs_i_init_once(void *foo);
 static void afs_kill_super(struct super_block *sb);
 static struct inode *afs_alloc_inode(struct super_block *sb);
 static void afs_destroy_inode(struct inode *inode);
@@ -646,7 +646,7 @@ static int afs_init_fs_context(struct fs_context *fc)
  * afs_alloc_inode() *must* reset anything that could incorrectly leak from one
  * inode to another.
  */
-static void afs_i_init_once(void *_vnode)
+static int afs_i_init_once(void *_vnode)
 {
 	struct afs_vnode *vnode = _vnode;
 
@@ -662,6 +662,7 @@ static void afs_i_init_once(void *_vnode)
 	INIT_DELAYED_WORK(&vnode->lock_work, afs_lock_work);
 	INIT_LIST_HEAD(&vnode->cb_mmap_link);
 	seqlock_init(&vnode->cb_lock);
+	return 0;
 }
 
 /*
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 8f430ff8e445..bb94680b0ca8 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -287,11 +287,12 @@ static void befs_free_inode(struct inode *inode)
 	kmem_cache_free(befs_inode_cachep, BEFS_I(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct befs_inode_info *bi = (struct befs_inode_info *) foo;
 
 	inode_init_once(&bi->vfs_inode);
+	return 0;
 }
 
 static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index db81570c9637..c8eaf9d36507 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -247,11 +247,12 @@ static void bfs_free_inode(struct inode *inode)
 	kmem_cache_free(bfs_inode_cachep, BFS_I(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct bfs_inode_info *bi = foo;
 
 	inode_init_once(&bi->vfs_inode);
+	return 0;
 }
 
 static int __init init_inodecache(void)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cc67d1a2d611..dc17d60ec78d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7871,11 +7871,12 @@ int btrfs_drop_inode(struct inode *inode)
 		return generic_drop_inode(inode);
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct btrfs_inode *ei = foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 void __cold btrfs_destroy_cachep(void)
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index f3951253e393..e627c5f975c4 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -926,10 +926,11 @@ struct kmem_cache *ceph_dir_file_cachep;
 struct kmem_cache *ceph_mds_request_cachep;
 mempool_t *ceph_wb_pagevec_pool;
 
-static void ceph_inode_init_once(void *foo)
+static int ceph_inode_init_once(void *foo)
 {
 	struct ceph_inode_info *ci = foo;
 	inode_init_once(&ci->netfs.inode);
+	return 0;
 }
 
 static int __init init_caches(void)
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 6896fce122e1..4580ea6ae053 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -61,11 +61,12 @@ static void coda_free_inode(struct inode *inode)
 	kmem_cache_free(coda_inode_cachep, ITOC(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct coda_inode_info *ei = (struct coda_inode_info *) foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 int __init coda_init_inodecache(void)
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 75715d8877ee..b96b74b624ec 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -210,10 +210,11 @@ static int debugfs_show_options(struct seq_file *m, struct dentry *root)
 
 static struct kmem_cache *debugfs_inode_cachep __ro_after_init;
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct debugfs_inode_info *info = foo;
 	inode_init_once(&info->vfs_inode);
+	return 0;
 }
 
 static struct inode *debugfs_alloc_inode(struct super_block *sb)
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 70abd4da17a6..6a4f7a68f34c 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -232,11 +232,12 @@ static void lowcomms_queue_rwork(struct connection *con)
 		queue_work(io_workqueue, &con->rwork);
 }
 
-static void writequeue_entry_ctor(void *data)
+static int writequeue_entry_ctor(void *data)
 {
 	struct writequeue_entry *entry = data;
 
 	INIT_LIST_HEAD(&entry->msgs);
+	return 0;
 }
 
 struct kmem_cache *dlm_lowcomms_writequeue_cache_create(void)
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 8dd1d7189c3b..7afc008774e7 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -641,12 +641,13 @@ MODULE_ALIAS_FS("ecryptfs");
  *
  * Initializes the ecryptfs_inode_info_cache when it is created
  */
-static void
+static int
 inode_info_init_once(void *vptr)
 {
 	struct ecryptfs_inode_info *ei = (struct ecryptfs_inode_info *)vptr;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static struct ecryptfs_cache_info {
@@ -654,7 +655,7 @@ static struct ecryptfs_cache_info {
 	const char *name;
 	size_t size;
 	slab_flags_t flags;
-	void (*ctor)(void *obj);
+	int (*ctor)(void *obj);
 } ecryptfs_cache_infos[] = {
 	{
 		.cache = &ecryptfs_auth_tok_list_item_cache,
diff --git a/fs/efs/super.c b/fs/efs/super.c
index c59086b7eabf..09d4f5e0710b 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -76,11 +76,12 @@ static void efs_free_inode(struct inode *inode)
 	kmem_cache_free(efs_inode_cachep, INODE_INFO(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct efs_inode_info *ei = (struct efs_inode_info *) foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int __init init_inodecache(void)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cadec6b1b554..09b84a549c64 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -56,11 +56,12 @@ static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
 	return -EBADMSG;
 }
 
-static void erofs_inode_init_once(void *ptr)
+static int erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
 
 	inode_init_once(&vi->vfs_inode);
+	return 0;
 }
 
 static struct inode *erofs_alloc_inode(struct super_block *sb)
diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index d5ce0ae660ba..e8b2fffc60b4 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -35,11 +35,12 @@ struct exfat_cache_id {
 
 static struct kmem_cache *exfat_cachep;
 
-static void exfat_cache_init_once(void *c)
+static int exfat_cache_init_once(void *c)
 {
 	struct exfat_cache *cache = (struct exfat_cache *)c;
 
 	INIT_LIST_HEAD(&cache->cache_list);
+	return 0;
 }
 
 int exfat_cache_init(void)
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8465033a6cf0..946b50e72aea 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -818,7 +818,7 @@ static struct file_system_type exfat_fs_type = {
 	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 
-static void exfat_inode_init_once(void *foo)
+static int exfat_inode_init_once(void *foo)
 {
 	struct exfat_inode_info *ei = (struct exfat_inode_info *)foo;
 
@@ -828,6 +828,7 @@ static void exfat_inode_init_once(void *foo)
 	INIT_LIST_HEAD(&ei->cache_lru);
 	INIT_HLIST_NODE(&ei->i_hash_fat);
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int __init init_exfat_fs(void)
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 28ff47ec4be6..7a4a6d6c069b 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -224,7 +224,7 @@ static void ext2_free_in_core_inode(struct inode *inode)
 	kmem_cache_free(ext2_inode_cachep, EXT2_I(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct ext2_inode_info *ei = (struct ext2_inode_info *) foo;
 
@@ -234,6 +234,7 @@ static void init_once(void *foo)
 #endif
 	mutex_init(&ei->truncate_mutex);
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int __init init_inodecache(void)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 181934499624..7616ab697cdf 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1465,7 +1465,7 @@ static void ext4_shutdown(struct super_block *sb)
        ext4_force_shutdown(sb, EXT4_GOING_FLAGS_NOLOGFLUSH);
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct ext4_inode_info *ei = foo;
 
@@ -1474,6 +1474,7 @@ static void init_once(void *foo)
 	init_rwsem(&ei->i_data_sem);
 	inode_init_once(&ei->vfs_inode);
 	ext4_fc_init_inode(&ei->vfs_inode);
+	return 0;
 }
 
 static int __init init_inodecache(void)
diff --git a/fs/fat/cache.c b/fs/fat/cache.c
index 2af424e200b3..9478c8ca35e8 100644
--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -36,11 +36,12 @@ static inline int fat_max_cache(struct inode *inode)
 
 static struct kmem_cache *fat_cache_cachep;
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct fat_cache *cache = (struct fat_cache *)foo;
 
 	INIT_LIST_HEAD(&cache->cache_list);
+	return 0;
 }
 
 int __init fat_cache_init(void)
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 3852bb66358c..0576d7cda07d 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -767,7 +767,7 @@ static void fat_free_inode(struct inode *inode)
 	kmem_cache_free(fat_inode_cachep, MSDOS_I(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct msdos_inode_info *ei = (struct msdos_inode_info *)foo;
 
@@ -778,6 +778,7 @@ static void init_once(void *foo)
 	INIT_HLIST_NODE(&ei->i_fat_hash);
 	INIT_HLIST_NODE(&ei->i_dir_hash);
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int __init fat_init_inodecache(void)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd48e8d37f2e..358f47f091c1 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2131,11 +2131,12 @@ static inline void unregister_fuseblk(void)
 }
 #endif
 
-static void fuse_inode_init_once(void *foo)
+static int fuse_inode_init_once(void *foo)
 {
 	struct inode *inode = foo;
 
 	inode_init_once(inode);
+	return 0;
 }
 
 static int __init fuse_fs_init(void)
diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 0727f60ad028..0923a091d926 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -31,7 +31,7 @@
 
 struct workqueue_struct *gfs2_control_wq;
 
-static void gfs2_init_inode_once(void *foo)
+static int gfs2_init_inode_once(void *foo)
 {
 	struct gfs2_inode *ip = foo;
 
@@ -45,9 +45,10 @@ static void gfs2_init_inode_once(void *foo)
 	RB_CLEAR_NODE(&ip->i_res.rs_node);
 	ip->i_hash_cache = NULL;
 	gfs2_holder_mark_uninitialized(&ip->i_iopen_gh);
+	return 0;
 }
 
-static void gfs2_init_glock_once(void *foo)
+static int gfs2_init_glock_once(void *foo)
 {
 	struct gfs2_glock *gl = foo;
 
@@ -56,14 +57,16 @@ static void gfs2_init_glock_once(void *foo)
 	INIT_LIST_HEAD(&gl->gl_ail_list);
 	atomic_set(&gl->gl_ail_count, 0);
 	atomic_set(&gl->gl_revokes, 0);
+	return 0;
 }
 
-static void gfs2_init_gl_aspace_once(void *foo)
+static int gfs2_init_gl_aspace_once(void *foo)
 {
 	struct gfs2_glock_aspace *gla = foo;
 
 	gfs2_init_glock_once(&gla->glock);
 	address_space_init_once(&gla->mapping);
+	return 0;
 }
 
 /**
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index fe09c2093a93..ab8bd6c895c1 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -436,11 +436,12 @@ static struct file_system_type hfs_fs_type = {
 };
 MODULE_ALIAS_FS("hfs");
 
-static void hfs_init_once(void *p)
+static int hfs_init_once(void *p)
 {
 	struct hfs_inode_info *i = p;
 
 	inode_init_once(&i->vfs_inode);
+	return 0;
 }
 
 static int __init init_hfs_fs(void)
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 948b8aaee33e..b390381e837f 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -678,11 +678,12 @@ static struct file_system_type hfsplus_fs_type = {
 };
 MODULE_ALIAS_FS("hfsplus");
 
-static void hfsplus_init_once(void *p)
+static int hfsplus_init_once(void *p)
 {
 	struct hfsplus_inode_info *i = p;
 
 	inode_init_once(&i->vfs_inode);
+	return 0;
 }
 
 static int __init init_hfsplus_fs(void)
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 27567920abe4..1af5a9f5f931 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -244,11 +244,12 @@ static void hpfs_free_inode(struct inode *inode)
 	kmem_cache_free(hpfs_inode_cachep, hpfs_i(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct hpfs_inode_info *ei = (struct hpfs_inode_info *) foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int init_inodecache(void)
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e4de5425838d..c0513bb7ed88 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1225,11 +1225,12 @@ static const struct address_space_operations hugetlbfs_aops = {
 };
 
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct hugetlbfs_inode_info *ei = foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static const struct file_operations hugetlbfs_file_operations = {
diff --git a/fs/inode.c b/fs/inode.c
index 99318b157a9a..d1b73cbda4f5 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -514,11 +514,12 @@ void inode_init_once(struct inode *inode)
 }
 EXPORT_SYMBOL(inode_init_once);
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct inode *inode = (struct inode *) foo;
 
 	inode_init_once(inode);
+	return 0;
 }
 
 /*
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 47038e660812..0251eefdb18f 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -82,11 +82,12 @@ static void isofs_free_inode(struct inode *inode)
 	kmem_cache_free(isofs_inode_cachep, ISOFS_I(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct iso_inode_info *ei = foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int __init init_inodecache(void)
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 4545f885c41e..7249f6ad5b0a 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -53,13 +53,14 @@ static void jffs2_free_inode(struct inode *inode)
 	kmem_cache_free(jffs2_inode_cachep, f);
 }
 
-static void jffs2_i_init_once(void *foo)
+static int jffs2_i_init_once(void *foo)
 {
 	struct jffs2_inode_info *f = foo;
 
 	mutex_init(&f->sem);
 	f->target = NULL;
 	inode_init_once(&f->vfs_inode);
+	return 0;
 }
 
 static const char *jffs2_compr_name(unsigned int compr)
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 10368c188c5e..f9bae8adfc18 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -934,7 +934,7 @@ static struct file_system_type jfs_fs_type = {
 };
 MODULE_ALIAS_FS("jfs");
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct jfs_inode_info *jfs_ip = (struct jfs_inode_info *) foo;
 
@@ -946,6 +946,7 @@ static void init_once(void *foo)
 	spin_lock_init(&jfs_ip->ag_lock);
 	jfs_ip->active_ag = -1;
 	inode_init_once(&jfs_ip->vfs_inode);
+	return 0;
 }
 
 static int __init init_jfs_fs(void)
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index f007e389d5d2..dc13b652754b 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -75,11 +75,12 @@ static void minix_free_in_core_inode(struct inode *inode)
 	kmem_cache_free(minix_inode_cachep, minix_i(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct minix_inode_info *ei = (struct minix_inode_info *) foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int __init init_inodecache(void)
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 119e447758b9..274cdad1c13e 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2456,7 +2456,7 @@ static inline void nfs4_init_once(struct nfs_inode *nfsi)
 #endif
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct nfs_inode *nfsi = foo;
 
@@ -2465,6 +2465,7 @@ static void init_once(void *foo)
 	INIT_LIST_HEAD(&nfsi->access_cache_entry_lru);
 	INIT_LIST_HEAD(&nfsi->access_cache_inode_lru);
 	nfs4_init_once(nfsi);
+	return 0;
 }
 
 static int __init nfs_init_inodecache(void)
diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 37d79400e5f4..22e5e9751656 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -960,7 +960,7 @@ nfs4_xattr_entry_count(struct shrinker *shrink, struct shrink_control *sc)
 }
 
 
-static void nfs4_xattr_cache_init_once(void *p)
+static int nfs4_xattr_cache_init_once(void *p)
 {
 	struct nfs4_xattr_cache *cache = p;
 
@@ -970,6 +970,7 @@ static void nfs4_xattr_cache_init_once(void *p)
 	cache->listxattr = NULL;
 	INIT_LIST_HEAD(&cache->lru);
 	INIT_LIST_HEAD(&cache->dispose);
+	return 0;
 }
 
 typedef unsigned long (*count_objects_cb)(struct shrinker *s,
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index badc2cbc895e..415381d9e5f9 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1313,7 +1313,7 @@ struct file_system_type nilfs_fs_type = {
 };
 MODULE_ALIAS_FS("nilfs2");
 
-static void nilfs_inode_init_once(void *obj)
+static int nilfs_inode_init_once(void *obj)
 {
 	struct nilfs_inode_info *ii = obj;
 
@@ -1322,11 +1322,13 @@ static void nilfs_inode_init_once(void *obj)
 	init_rwsem(&ii->xattr_sem);
 #endif
 	inode_init_once(&ii->vfs_inode);
+	return 0;
 }
 
-static void nilfs_segbuf_init_once(void *obj)
+static int nilfs_segbuf_init_once(void *obj)
 {
 	memset(obj, 0, sizeof(struct nilfs_segment_buffer));
+	return 0;
 }
 
 static void nilfs_destroy_cachep(void)
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 920a1ab47b63..8dcfe06ba996 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -628,11 +628,12 @@ static void ntfs_free_inode(struct inode *inode)
 	kmem_cache_free(ntfs_inode_cachep, ni);
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct ntfs_inode *ni = foo;
 
 	inode_init_once(&ni->vfs_inode);
+	return 0;
 }
 
 /*
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 5130ec44e5e1..3c044f94970f 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -265,7 +265,7 @@ static ssize_t dlmfs_file_write(struct file *filp,
 	return count;
 }
 
-static void dlmfs_init_once(void *foo)
+static int dlmfs_init_once(void *foo)
 {
 	struct dlmfs_inode_private *ip =
 		(struct dlmfs_inode_private *) foo;
@@ -274,6 +274,7 @@ static void dlmfs_init_once(void *foo)
 	ip->ip_parent = NULL;
 
 	inode_init_once(&ip->ip_vfs_inode);
+	return 0;
 }
 
 static struct inode *dlmfs_alloc_inode(struct super_block *sb)
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 8bb5022f3082..b33185567db9 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1614,7 +1614,7 @@ static int ocfs2_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return status;
 }
 
-static void ocfs2_inode_init_once(void *data)
+static int ocfs2_inode_init_once(void *data)
 {
 	struct ocfs2_inode_info *oi = data;
 
@@ -1643,6 +1643,7 @@ static void ocfs2_inode_init_once(void *data)
 				  &ocfs2_inode_caching_ops);
 
 	inode_init_once(&oi->vfs_inode);
+	return 0;
 }
 
 static int ocfs2_initialize_mem_caches(void)
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 26ecda0e4d19..5f40a4e0dd55 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -431,11 +431,12 @@ static struct file_system_type openprom_fs_type = {
 };
 MODULE_ALIAS_FS("openpromfs");
 
-static void op_inode_init_once(void *data)
+static int op_inode_init_once(void *data)
 {
 	struct op_inode_info *oi = (struct op_inode_info *) data;
 
 	inode_init_once(&oi->vfs_inode);
+	return 0;
 }
 
 static int __init init_openprom_fs(void)
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index eba3e357192e..9521452dea13 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -95,12 +95,13 @@ static int parse_mount_options(struct super_block *sb, char *options,
 	return -EINVAL;
 }
 
-static void orangefs_inode_cache_ctor(void *req)
+static int orangefs_inode_cache_ctor(void *req)
 {
 	struct orangefs_inode_s *orangefs_inode = req;
 
 	inode_init_once(&orangefs_inode->vfs_inode);
 	init_rwsem(&orangefs_inode->xattr_sem);
+	return 0;
 }
 
 static struct inode *orangefs_alloc_inode(struct super_block *sb)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b63474d1b064..d46d4ea30f66 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1516,11 +1516,12 @@ struct file_system_type ovl_fs_type = {
 };
 MODULE_ALIAS_FS("overlay");
 
-static void ovl_inode_init_once(void *foo)
+static int ovl_inode_init_once(void *foo)
 {
 	struct ovl_inode *oi = foo;
 
 	inode_init_once(&oi->vfs_inode);
+	return 0;
 }
 
 static int __init ovl_init(void)
diff --git a/fs/pidfs.c b/fs/pidfs.c
index d64a4cbeb0da..efc9aac05446 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -896,11 +896,12 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	return pidfd_file;
 }
 
-static void pidfs_inode_init_once(void *data)
+static int pidfs_inode_init_once(void *data)
 {
 	struct pidfs_inode *pi = data;
 
 	inode_init_once(&pi->vfs_inode);
+	return 0;
 }
 
 void __init pidfs_init(void)
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index a3eb3b740f76..f1bf32900389 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -80,11 +80,12 @@ static void proc_free_inode(struct inode *inode)
 	kmem_cache_free(proc_inode_cachep, PROC_I(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct proc_inode *ei = (struct proc_inode *) foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 void __init proc_init_kmemcache(void)
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e399e2dd3a12..624911ffc8a8 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -366,11 +366,12 @@ static void qnx4_free_inode(struct inode *inode)
 	kmem_cache_free(qnx4_inode_cachep, qnx4_i(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct qnx4_inode_info *ei = (struct qnx4_inode_info *) foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int init_inodecache(void)
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 3310d1ad4d0e..196b4fafcc46 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -595,11 +595,12 @@ static void qnx6_free_inode(struct inode *inode)
 	kmem_cache_free(qnx6_inode_cachep, QNX6_I(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct qnx6_inode_info *ei = (struct qnx6_inode_info *) foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int init_inodecache(void)
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 0addcc849ff2..622a388dfc8f 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -601,11 +601,12 @@ MODULE_ALIAS_FS("romfs");
 /*
  * inode storage initialiser
  */
-static void romfs_i_init_once(void *_inode)
+static int romfs_i_init_once(void *_inode)
 {
 	struct romfs_inode_info *inode = _inode;
 
 	inode_init_once(&inode->vfs_inode);
+	return 0;
 }
 
 /*
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index a08c42363ffc..4e16806552ba 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1641,13 +1641,14 @@ const struct file_operations cifs_dir_ops = {
 	.fsync = cifs_dir_fsync,
 };
 
-static void
+static int
 cifs_init_once(void *inode)
 {
 	struct cifsInodeInfo *cifsi = inode;
 
 	inode_init_once(&cifsi->netfs.inode);
 	init_rwsem(&cifsi->lock_sem);
+	return 0;
 }
 
 static int __init
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 67c55fe32ce8..0764d52ecc2c 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -606,11 +606,12 @@ static void squashfs_put_super(struct super_block *sb)
 static struct kmem_cache *squashfs_inode_cachep;
 
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct squashfs_inode_info *ei = foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index cb1af30b49f5..87cc889e47d8 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -792,7 +792,7 @@ bool tracefs_initialized(void)
 	return tracefs_registered;
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct tracefs_inode *ti = (struct tracefs_inode *) foo;
 
@@ -801,6 +801,7 @@ static void init_once(void *foo)
 
 	/* Zero out the rest */
 	memset_after(ti, 0, vfs_inode);
+	return 0;
 }
 
 static int __init tracefs_init(void)
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f3e3b2068608..3591397d7df7 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2376,10 +2376,11 @@ MODULE_ALIAS_FS("ubifs");
 /*
  * Inode slab cache constructor.
  */
-static void inode_slab_ctor(void *obj)
+static int inode_slab_ctor(void *obj)
 {
 	struct ubifs_inode *ui = obj;
 	inode_init_once(&ui->vfs_inode);
+	return 0;
 }
 
 static int __init ubifs_init(void)
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 1c8a736b3309..8fdf6efc7953 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -175,12 +175,13 @@ static void udf_free_in_core_inode(struct inode *inode)
 	kmem_cache_free(udf_inode_cachep, UDF_I(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct udf_inode_info *ei = foo;
 
 	ei->i_data = NULL;
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int __init init_inodecache(void)
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 762699c1bcf6..b188ebe93939 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1444,11 +1444,12 @@ static void ufs_free_in_core_inode(struct inode *inode)
 	kmem_cache_free(ufs_inode_cachep, UFS_I(inode));
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct ufs_inode_info *ei = (struct ufs_inode_info *) foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int __init init_inodecache(void)
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index d80f94346199..53d59a94983c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2073,7 +2073,7 @@ static const struct file_operations userfaultfd_fops = {
 	.llseek		= noop_llseek,
 };
 
-static void init_once_userfaultfd_ctx(void *mem)
+static int init_once_userfaultfd_ctx(void *mem)
 {
 	struct userfaultfd_ctx *ctx = (struct userfaultfd_ctx *) mem;
 
@@ -2082,6 +2082,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 	init_waitqueue_head(&ctx->event_wqh);
 	init_waitqueue_head(&ctx->fd_wqh);
 	seqcount_spinlock_init(&ctx->refile_seq, &ctx->fault_pending_wqh.lock);
+	return 0;
 }
 
 static int new_userfaultfd(int flags)
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 0bc96ab6580b..f4fc1cb03014 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -222,12 +222,13 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 	return err;
 }
 
-static void vboxsf_inode_init_once(void *data)
+static int vboxsf_inode_init_once(void *data)
 {
 	struct vboxsf_inode *sf_i = data;
 
 	mutex_init(&sf_i->handle_list_mutex);
 	inode_init_once(&sf_i->vfs_inode);
+	return 0;
 }
 
 static struct inode *vboxsf_alloc_inode(struct super_block *sb)
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf509..2eaab19c1fc5 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -725,7 +725,7 @@ xfs_fs_dirty_inode(
  * fields in the xfs inode that left in the initialise state
  * when freeing the inode.
  */
-STATIC void
+STATIC int
 xfs_fs_inode_init_once(
 	void			*inode)
 {
@@ -740,6 +740,7 @@ xfs_fs_inode_init_once(
 	atomic_set(&ip->i_pincount, 0);
 	spin_lock_init(&ip->i_flags_lock);
 	init_rwsem(&ip->i_lock);
+	return 0;
 }
 
 /*
diff --git a/include/linux/slab.h b/include/linux/slab.h
index d5a8ab98035c..1ef6d5384f0b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -330,11 +330,12 @@ struct kmem_cache_args {
 	 * page. It is the cache user's responsibility to free object in the
 	 * same state as after calling the constructor, or deal appropriately
 	 * with any differences between a freshly constructed and a reallocated
-	 * object.
+	 * object. If ctor returns a nonzero value, indicating an error, slab
+	 * allocation fails.
 	 *
 	 * %NULL means no constructor.
 	 */
-	void (*ctor)(void *);
+	int (*ctor)(void *);
 };
 
 struct kmem_cache *__kmem_cache_create_args(const char *name,
@@ -343,7 +344,7 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 					    slab_flags_t flags);
 static inline struct kmem_cache *
 __kmem_cache_create(const char *name, unsigned int size, unsigned int align,
-		    slab_flags_t flags, void (*ctor)(void *))
+		    slab_flags_t flags, int (*ctor)(void *))
 {
 	struct kmem_cache_args kmem_args = {
 		.align	= align,
@@ -375,7 +376,7 @@ static inline struct kmem_cache *
 kmem_cache_create_usercopy(const char *name, unsigned int size,
 			   unsigned int align, slab_flags_t flags,
 			   unsigned int useroffset, unsigned int usersize,
-			   void (*ctor)(void *))
+			   int (*ctor)(void *))
 {
 	struct kmem_cache_args kmem_args = {
 		.align		= align,
@@ -775,7 +776,7 @@ void kmem_cache_free(struct kmem_cache *s, void *objp);
 
 kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 				  unsigned int useroffset, unsigned int usersize,
-				  void (*ctor)(void *));
+				  int (*ctor)(void *));
 
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 35b4f8659904..4e331e39f980 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -487,11 +487,12 @@ static struct vfsmount *mq_create_mount(struct ipc_namespace *ns)
 	return mnt;
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct mqueue_inode_info *p = foo;
 
 	inode_init_once(&p->vfs_inode);
+	return 0;
 }
 
 static struct inode *mqueue_alloc_inode(struct super_block *sb)
diff --git a/kernel/fork.c b/kernel/fork.c
index c4b26cd8998b..7966b0876dc3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3184,12 +3184,13 @@ void walk_process_tree(struct task_struct *top, proc_visitor visitor, void *data
 #define ARCH_MIN_MMSTRUCT_ALIGN 0
 #endif
 
-static void sighand_ctor(void *data)
+static int sighand_ctor(void *data)
 {
 	struct sighand_struct *sighand = data;
 
 	spin_lock_init(&sighand->siglock);
 	init_waitqueue_head(&sighand->signalfd_wqh);
+	return 0;
 }
 
 void __init mm_cache_init(void)
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index f11a7c2af778..8ed7e3d4ca30 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -792,7 +792,7 @@ static struct refscale_typesafe *typesafe_alloc_one(void)
 
 // Slab-allocator constructor for refscale_typesafe structures created
 // out of a new slab of system memory.
-static void refscale_typesafe_ctor(void *rtsp_in)
+static int refscale_typesafe_ctor(void *rtsp_in)
 {
 	struct refscale_typesafe *rtsp = rtsp_in;
 
@@ -801,6 +801,7 @@ static void refscale_typesafe_ctor(void *rtsp_in)
 	preempt_disable();
 	rtsp->a = torture_random(this_cpu_ptr(&refscale_rand));
 	preempt_enable();
+	return 0;
 }
 
 static const struct ref_scale_ops typesafe_ref_ops;
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 976b9bd02a1b..0e0f83ca9175 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1566,13 +1566,14 @@ void idr_destroy(struct idr *idr)
 }
 EXPORT_SYMBOL(idr_destroy);
 
-static void
+static int
 radix_tree_node_ctor(void *arg)
 {
 	struct radix_tree_node *node = arg;
 
 	memset(node, 0, sizeof(*node));
 	INIT_LIST_HEAD(&node->private_list);
+	return 0;
 }
 
 static int radix_tree_cpu_dead(unsigned int cpu)
diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index 6298f66c964b..4697a2aedee2 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -169,9 +169,10 @@ static int __init test_kvmalloc(int *total_failures)
 #define CTOR_BYTES (sizeof(unsigned int))
 #define CTOR_PATTERN (0x41414141)
 /* Initialize the first 4 bytes of the object. */
-static void test_ctor(void *obj)
+static int test_ctor(void *obj)
 {
 	*(unsigned int *)obj = CTOR_PATTERN;
+	return 0;
 }
 
 /*
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 00034e37bc9f..451760e8d1f4 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -184,7 +184,7 @@ static bool report_matches(const struct expect_report *r)
 static struct kmem_cache *test_cache;
 
 static size_t setup_test_cache(struct kunit *test, size_t size, slab_flags_t flags,
-			       void (*ctor)(void *))
+			       int (*ctor)(void *))
 {
 	if (test->priv != TEST_PRIV_WANT_MEMCACHE)
 		return size;
@@ -539,10 +539,11 @@ static void test_shrink_memcache(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, report_available());
 }
 
-static void ctor_set_x(void *obj)
+static int ctor_set_x(void *obj)
 {
 	/* Every object has at least 8 bytes. */
 	memset(obj, 'x', 8);
+	return 0;
 }
 
 /* Ensure that SL*B does not modify KFENCE objects on bulk free. */
diff --git a/mm/rmap.c b/mm/rmap.c
index 67bb273dfb80..f2b45caa5acb 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -448,13 +448,14 @@ void unlink_anon_vmas(struct vm_area_struct *vma)
 	}
 }
 
-static void anon_vma_ctor(void *data)
+static int anon_vma_ctor(void *data)
 {
 	struct anon_vma *anon_vma = data;
 
 	init_rwsem(&anon_vma->rwsem);
 	atomic_set(&anon_vma->refcount, 0);
 	anon_vma->rb_root = RB_ROOT_CACHED;
+	return 0;
 }
 
 void __init anon_vma_init(void)
diff --git a/mm/shmem.c b/mm/shmem.c
index 99327c30507c..50ac15dfaff8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5165,10 +5165,11 @@ static void shmem_destroy_inode(struct inode *inode)
 		simple_offset_destroy(shmem_get_offset_ctx(inode));
 }
 
-static void shmem_init_inode(void *foo)
+static int shmem_init_inode(void *foo)
 {
 	struct shmem_inode_info *info = foo;
 	inode_init_once(&info->vfs_inode);
+	return 0;
 }
 
 static void __init shmem_init_inodecache(void)
diff --git a/mm/slab.h b/mm/slab.h
index 05a21dc796e0..30603907d936 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -278,7 +278,7 @@ struct kmem_cache {
 	struct kmem_cache_order_objects min;
 	gfp_t allocflags;		/* gfp flags to use on each alloc */
 	int refcount;			/* Refcount for slab cache destroy */
-	void (*ctor)(void *object);	/* Object constructor */
+	int (*ctor)(void *object);	/* Object constructor */
 	unsigned int inuse;		/* Offset to metadata */
 	unsigned int align;		/* Alignment */
 	unsigned int red_left_pad;	/* Left redzone padding size */
@@ -438,10 +438,10 @@ extern void create_boot_cache(struct kmem_cache *, const char *name,
 
 int slab_unmergeable(struct kmem_cache *s);
 struct kmem_cache *find_mergeable(unsigned size, unsigned align,
-		slab_flags_t flags, const char *name, void (*ctor)(void *));
+		slab_flags_t flags, const char *name, int (*ctor)(void *));
 struct kmem_cache *
 __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
-		   slab_flags_t flags, void (*ctor)(void *));
+		   slab_flags_t flags, int (*ctor)(void *));
 
 slab_flags_t kmem_cache_flags(slab_flags_t flags, const char *name);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 5be257e03c7c..59938e44a8c2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -173,7 +173,7 @@ int slab_unmergeable(struct kmem_cache *s)
 }
 
 struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
-		slab_flags_t flags, const char *name, void (*ctor)(void *))
+		slab_flags_t flags, const char *name, int (*ctor)(void *))
 {
 	struct kmem_cache *s;
 
@@ -382,7 +382,7 @@ static struct kmem_cache *kmem_buckets_cache __ro_after_init;
 kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 				  unsigned int useroffset,
 				  unsigned int usersize,
-				  void (*ctor)(void *))
+				  int (*ctor)(void *))
 {
 	unsigned long mask = 0;
 	unsigned int idx;
diff --git a/mm/slub.c b/mm/slub.c
index 95a9f04b5904..10b9c87792b7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2439,7 +2439,8 @@ static void *setup_object(struct kmem_cache *s, void *object)
 	object = kasan_init_slab_obj(s, object);
 	if (unlikely(s->ctor)) {
 		kasan_unpoison_new_object(s, object);
-		s->ctor(object);
+		if (s->ctor(object))
+			return NULL;
 		kasan_poison_new_object(s, object);
 	}
 	return object;
@@ -2542,7 +2543,7 @@ static bool should_shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 }
 
 /* Shuffle the single linked freelist based on a random pre-computed sequence */
-static void shuffle_freelist(struct kmem_cache *s, struct slab *slab)
+static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 {
 	void *start;
 	void *cur;
@@ -2559,15 +2560,29 @@ static void shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 	cur = next_freelist_entry(s, &pos, start, page_limit, freelist_count);
 	cur = setup_object(s, cur);
 	slab->freelist = cur;
+	if (!cur) {
+		return false;
+	}
 
 	for (idx = 1; idx < slab->objects; idx++) {
 		next = next_freelist_entry(s, &pos, start, page_limit,
 			freelist_count);
 		next = setup_object(s, next);
+		if (!next) {
+			/*
+			 * This is necessary because later we need to call
+			 * the destructor for objects that the constructor
+			 * successfully initialized.
+			 */
+			set_freepointer(s, cur, NULL);
+			return false;
+		}
 		set_freepointer(s, cur, next);
 		cur = next;
 	}
 	set_freepointer(s, cur, NULL);
+
+	return true;
 }
 #else
 static inline int init_cache_random_seq(struct kmem_cache *s)
@@ -2580,8 +2595,10 @@ static inline bool should_shuffle_freelist(struct kmem_cache *s,
 {
 	return false;
 }
-static inline void shuffle_freelist(struct kmem_cache *s, struct slab *slab)
-{ }
+static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
+{
+	return false;
+}
 #endif /* CONFIG_SLAB_FREELIST_RANDOM */
 
 static __always_inline void account_slab(struct slab *slab, int order,
@@ -2604,6 +2621,20 @@ static __always_inline void unaccount_slab(struct slab *slab, int order,
 			    -(PAGE_SIZE << order));
 }
 
+static void __free_slab(struct kmem_cache *s, struct slab *slab)
+{
+	struct folio *folio = slab_folio(slab);
+	int order = folio_order(folio);
+	int pages = 1 << order;
+
+	__slab_clear_pfmemalloc(slab);
+	folio->mapping = NULL;
+	__folio_clear_slab(folio);
+	mm_account_reclaimed_pages(pages);
+	unaccount_slab(slab, order, s);
+	free_frozen_pages(&folio->page, order);
+}
+
 static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
 	struct slab *slab;
@@ -2653,14 +2684,22 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	setup_slab_debug(s, slab, start);
 
 	if (should_shuffle_freelist(s, slab)) {
-		shuffle_freelist(s, slab);
+		if (!shuffle_freelist(s, slab))
+			goto err;
 	} else {
 		start = fixup_red_left(s, start);
 		start = setup_object(s, start);
 		slab->freelist = start;
+		if (!start)
+			goto err;
 		for (idx = 0, p = start; idx < slab->objects - 1; idx++) {
 			next = p + s->size;
 			next = setup_object(s, next);
+			if (!next) {
+				/* See comment in shuffle_freelist() */
+				set_freepointer(s, p, NULL);
+				goto err;
+			}
 			set_freepointer(s, p, next);
 			p = next;
 		}
@@ -2668,6 +2707,9 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	}
 
 	return slab;
+err:
+	__free_slab(s, slab);
+	return NULL;
 }
 
 static struct slab *new_slab(struct kmem_cache *s, gfp_t flags, int node)
@@ -2681,20 +2723,6 @@ static struct slab *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
 }
 
-static void __free_slab(struct kmem_cache *s, struct slab *slab)
-{
-	struct folio *folio = slab_folio(slab);
-	int order = folio_order(folio);
-	int pages = 1 << order;
-
-	__slab_clear_pfmemalloc(slab);
-	folio->mapping = NULL;
-	__folio_clear_slab(folio);
-	mm_account_reclaimed_pages(pages);
-	unaccount_slab(slab, order, s);
-	free_frozen_pages(&folio->page, order);
-}
-
 static void rcu_free_slab(struct rcu_head *h)
 {
 	struct slab *slab = container_of(h, struct slab, rcu_head);
@@ -6377,7 +6405,7 @@ void __init kmem_cache_init_late(void)
 
 struct kmem_cache *
 __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
-		   slab_flags_t flags, void (*ctor)(void *))
+		   slab_flags_t flags, int (*ctor)(void *))
 {
 	struct kmem_cache *s;
 
diff --git a/net/socket.c b/net/socket.c
index 9a0e720f0859..d5843d9c6ab4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -330,11 +330,12 @@ static void sock_free_inode(struct inode *inode)
 	kmem_cache_free(sock_inode_cachep, ei);
 }
 
-static void init_once(void *foo)
+static int init_once(void *foo)
 {
 	struct socket_alloc *ei = (struct socket_alloc *)foo;
 
 	inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static void init_inodecache(void)
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index eadc00410ebc..d90d5f9b2fd7 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1467,7 +1467,7 @@ static struct file_system_type rpc_pipe_fs_type = {
 MODULE_ALIAS_FS("rpc_pipefs");
 MODULE_ALIAS("rpc_pipefs");
 
-static void
+static int
 init_once(void *foo)
 {
 	struct rpc_inode *rpci = (struct rpc_inode *) foo;
@@ -1476,6 +1476,7 @@ init_once(void *foo)
 	rpci->private = NULL;
 	rpci->pipe = NULL;
 	init_waitqueue_head(&rpci->waitq);
+	return 0;
 }
 
 int register_rpc_pipefs(void)
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index 00b249101f98..f2af2ee91481 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -123,11 +123,12 @@ void ima_inode_free_rcu(void *inode_security)
 		ima_iint_free(*iint_p);
 }
 
-static void ima_iint_init_once(void *foo)
+static int ima_iint_init_once(void *foo)
 {
 	struct ima_iint_cache *iint = (struct ima_iint_cache *)foo;
 
 	memset(iint, 0, sizeof(*iint));
+	return 0;
 }
 
 void __init ima_iintcache_init(void)
-- 
2.43.0


