Return-Path: <netdev+bounces-185436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C9EA9A59F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B44D1B83C6F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2CB20B7E1;
	Thu, 24 Apr 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WfzEBDEq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r4MJRWhK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F8A203706;
	Thu, 24 Apr 2025 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482689; cv=fail; b=gV2BlyUln7J1eEEIhMYvtOEkh3WLCk02+6dp0r0UckLajMQ6b5YYvt3K8euzbQpEPoWtjs2q7njBnPDIRhy552CgS0xhOmA6R/yKs2WIactveZkCxcQpBFnL6QKuaVFdIG1vl2ijWBH+B/bnm7MNggqpTjCNgsSF6wiEJQX+j00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482689; c=relaxed/simple;
	bh=OwODhzF+asfaSqN2WiaXeROexOyz+VqoCrSQr4qcvzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MuYXtyGhoIWjMew5Enn9dY7CQoPDFWpS5N9VLkpKzgODSVSmRXeyJJimtSjM8KYnxO6TBu/bptX8276fJWkV/EDRNKbIrsPk+vJ9oSD3GbGXXeuyxt7gEkivDMIDzSjTUSsETrgf1sdKrqu8R+o7MAB2c8w0QZxOqvwLJqAtKmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WfzEBDEq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r4MJRWhK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O6upZ0009041;
	Thu, 24 Apr 2025 08:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5Yrwh0GKU9wwDZWTrcd2hh/yg+nh7z44xkDhcXHLrzU=; b=
	WfzEBDEqhyh/QMWv/tSGrNS/VvQvxxW8WRvGlZtSeMM5EFu1BRP7h4CZLhnEX8bp
	xhJhxzEPRQGOxMMptfpyL2AYaN7DWA+jauWE1NuGWQKrFBd1WZaQZ3zSp3QW0VFs
	DeXelX0Uk0XfNoKyY4+cyP0twBN13FiZJCZrMabpJm1Tn5ZdGieph3HeKArA9Cav
	2xQ0kGSSAjQw0Z1rBr6KUexB+V5A9J3nXqNz/V17GoHJ1cbMj5hMHsejgco+rLYR
	b41rTZqX+8Rljm+Neli3ebzHNpPGbm1HwmkOfX2bbhLXhvpEq2CiXfezkC6zKD5X
	R9LhuKJau41jJrDqMdZhdA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467fw2g65p-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:17:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8832c030957;
	Thu, 24 Apr 2025 08:08:34 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012050.outbound.protection.outlook.com [40.93.20.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k06xrde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:08:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVWYE8kMK6r38Z0Rqz/dIiiXPazxguVHP7p0ysd5QA3/w8FDrUmXhbkSzTBT97Mb0BCk8Pv2uydYYEoFcDonHlKDToYPBulhlugBa+VGeIJqqEGYklbXPuxBHz3/OoPIZK0k4KYFyeXSI7hQoyvZlPS1MbR7zWW4hGqkHgSYx5R5lnm4PX+kBoLa/eGpI+iZs5KW1stONABL/ThpOcVdIgW8t+Kv3Oy1BDhv8aEU/DsxXDvB9Z5Q3scRXiaS/m+X5O3xrMXWm/0pQOzcoMXPn4z1B0blhMWAPllKpLcs0s6oxTQbOfQXESL/T2LHMPRanyuO2F++qHUkA8HLRsHZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Yrwh0GKU9wwDZWTrcd2hh/yg+nh7z44xkDhcXHLrzU=;
 b=ZmiOuY9H87g8WZAXTVymC4oAhHrByvMrR0W1Gh7U0Wf9efK9/TspXHB+rv8H3VqwiMNpLji5kxKcWexEVeUYSvSb3KnZvzwswLAjjdl9iXyRncktTXEUgBYpDP+UOLu5QplN5wg9p73hMEFAdvuZLY1gwfP/LD2RY+RV/a72qzsamm5m9Qnt7jUBUvagDAHizfWtMph1xCW34MgTNVyit4BUe+rK9IbXIeZqfaUCurQjmcErjXFjezjY81i4nTRZ87nggLQBHD2XoL5w8xus+8xMgrkiC3BPqyBIVBkyYMRyGFOgtYF9PpSesDdhNKyPMd/T76JKOWBiMQxiWcu4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Yrwh0GKU9wwDZWTrcd2hh/yg+nh7z44xkDhcXHLrzU=;
 b=r4MJRWhKMuO+mHeCNQtENJEzXu60uf+SpSBVJDpMjRWxcbzEMvVJAY5xknyLdMT2ubBZIg+Lu00SgsCun4KL1YYXZjmPAy9aCnAa1A30+qWLiG2jZv9WCdZyN56xqDXzOpVwqG++7OXtslvgxd5oJAliBP+3WaBYw5/Dl92xcWU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB8156.namprd10.prod.outlook.com (2603:10b6:408:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 08:08:10 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:08:10 +0000
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
Subject: [RFC PATCH 1/7] mm/slab: refactor freelist shuffle
Date: Thu, 24 Apr 2025 17:07:49 +0900
Message-ID: <20250424080755.272925-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424080755.272925-1-harry.yoo@oracle.com>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0032.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: dcac63c2-63c8-4319-b216-08dd83072767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZW85AqIFgf6pjP4eBZjAGEAxzdxP+I0WOTS7TQcFrR3rPf3YeOI7/7aAH4W7?=
 =?us-ascii?Q?aW9qiXgltU6ME1de5BVoKm5zbEYwVUf+CIP7C6z7KkziVPIZ5aCeKAy0oRdn?=
 =?us-ascii?Q?m0XSzQP7L3pidXux3eULoYMzLCQSZldbdIvh7USElGN6Suri33ZSbBLbcIu3?=
 =?us-ascii?Q?mgpjIU18w9B1I/CwPsT902AweCGqAPgTCua/rtvo/lXO1dqqfhtwTu07+jMI?=
 =?us-ascii?Q?FF5xbxHHQmr3Y7jdonAwMgJzOm+xAg1ZojgmrteFoFhlnmY/awbZkwTZVZtN?=
 =?us-ascii?Q?TitO5MTGqB0IqPpN5vJ9GFIR9EE8Twr2247GVrKx0fIWSQIc8LastU1hdLEX?=
 =?us-ascii?Q?x+V4GNytO+ZLC/HBZUzGnR3VCHvkeYsygLruhAixaTIx54jT20ACo8PxBPZl?=
 =?us-ascii?Q?/bRrEWQz0Zd9cuGC0l/gAv3wvR8hRUxAQWMHF6+AlJQ9J4YLIcy2OTXl862y?=
 =?us-ascii?Q?mWkNBoT2raY17PCdkn57n5o8Tgdwxun7NeqJL/6NT89eVo8cO6K7plt9xGzJ?=
 =?us-ascii?Q?0Cro68ycqnuQ1DHrBgpoyPek6/BZNC5LaiHCE/MNdMpmn/g4D+fTUZjxukq8?=
 =?us-ascii?Q?q1u7uQXrMlgjnHgLnvqLqstTkmA9gz0ZOt/t5D7941OE04Ijd9h4TIUP1POR?=
 =?us-ascii?Q?0fsFL/2X5y2g2F0ivKN1zJmU2PHEMnKoUOaE/dni5IrZn53zg2g9YqGwJOSG?=
 =?us-ascii?Q?aRCG9xDINvkbXo9Hb8aLwdZ/Qt+w+FGt0Rs7BFIlduX5lO83m9AeF8FZktfe?=
 =?us-ascii?Q?+TDzQCgNu/wMtI45kq7GUQzEFX3FvYRl8T47+m3HNgAv1vu5afHPVm6AGuIf?=
 =?us-ascii?Q?ipLHtW5H0c4itwZqamrYy+8pCuNV8o+4MV5k5ZYccichfjs+ZfCVfrC1ObOV?=
 =?us-ascii?Q?5t23Cg+prdhYIGcbJ+YpZE+SQYWwrsbp+3MhaiI9QZNw0UAeS/KeLE5eiWnX?=
 =?us-ascii?Q?oInRX98sXq7/xt31gWXUfq5UPC4vfiFbXSMtSoNkg0P+rNWoqvdmfoqBuD3A?=
 =?us-ascii?Q?eMTsSm/mHhERm/nEc/u7Gb/RoGo10PNiAaVILPMByHT8NVWAlq26ghMQZbKl?=
 =?us-ascii?Q?3WdpmUvc3DgFLSGHv97EN+wkXevQbvyfrsX2BaFDKTliig95+UyETz1Fv1yH?=
 =?us-ascii?Q?k0eZPjEA5C1B734MzNFFqB+MW0iZ+yas/rwt1l78l80ypO9bNiGpkAZvbxvO?=
 =?us-ascii?Q?lAdvf2oHgQ5jw43pJ2E3+6vTRJuP+vdmbe+LDnlqeLFWnpxOxdsIR2biGQah?=
 =?us-ascii?Q?rBjBRP2hNxkyfdt4VhDPAq5ib8a36ghkLt/PVHNgTnac7mlfSef+DlHl3cuk?=
 =?us-ascii?Q?LdPlo7i4IrNYXht8DdKcth7rCKJB8/Iz+7seLQ7qbt6UHoOsSqtxYXecDz55?=
 =?us-ascii?Q?5z380ewKB4l5tKJKriATWuyvtrNSz6m7NUJhfXyVtn8OrcyJ0Ljm/G5mrSI4?=
 =?us-ascii?Q?7iB4cnk5vPY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZbfMTB5WPGibyN5A5HniRlCyZ4AhUFG2HCbjvvpHRCp8mVhaif1EfHjvviFd?=
 =?us-ascii?Q?O2uM/AIr87lMAxsVzuImyQFFe2f/RxNDnIhdVeFFhECCyoZ/1Vi94FMKB84t?=
 =?us-ascii?Q?nXYgfRk4Ti9C5RI6e71Pvr1uhxBQvSbHBAdxua6wy33Dx7Qgmlmw3TzhdKv/?=
 =?us-ascii?Q?tX8Cbek24d4lCSMD+IA4WKAlVTCzTASfp20bxiRzdF50PZcXaIB32oI8K7Z9?=
 =?us-ascii?Q?3JAp05IfZyOkb68yGftfZF8nwEYQZny5Hf3+C4+UguvVQ70U5IhfEsr7X4SA?=
 =?us-ascii?Q?PC46tKXdUQP/uWAGZioCH5CiQy8kehrqt7dY/ZqNx032NnYDCEJvFtLfsDaL?=
 =?us-ascii?Q?Ure55sUWZha3sd0GsXxdNShl5F9fSa9x6zPhnGBjsggWHkOShx3H0AXrnKB1?=
 =?us-ascii?Q?/OmI4GM1kIt43WYymdPwCfRU0EWVxufEMwBt9vO4s/acnbqkjsZ0I1oQ7lv9?=
 =?us-ascii?Q?pQyVHfyXavjL7cxOrotoOiGH6Y3orSeLrgXXP/uN7Vuv2kQV6n3uOdCauhtr?=
 =?us-ascii?Q?EzH3r59AyM2cnIiLS0wFuUYlBS608I4MuObfq7VTab9kTm0pRjxYA8GS6zqf?=
 =?us-ascii?Q?cxjFZvqGyTzHsOuex9GsRB6XUMKsl7Qx+iYhidYTO9AKKYITBABRerEY1VWx?=
 =?us-ascii?Q?GYJ5NljxSkcdY1jzP91kFvRWJdHAq+eGA03hNwp2q9WViN9jfWmu/fgnIf8S?=
 =?us-ascii?Q?fWvG9TyYH21VtQFJ3t1TPUWrE7CUpVKDoIDszkF+1l3k7JMg8krgqMDty74u?=
 =?us-ascii?Q?Zp9Kd4SrqLnDuGC3NeYVxG6o58WYyKWUWg+cuMmtSzgtgDrnKbDSF63+Hi9c?=
 =?us-ascii?Q?iyuj/U0WLALyPJUI2CgtUnsoaYUtcnn9jzWOpqxxNkhhbe6TwDwTnsAFEjoa?=
 =?us-ascii?Q?pImJjtBEXYvLjyKGip0JqzcIXTnwLXCogYLmgIyspfmc6kVfKXmsd5QhnpIp?=
 =?us-ascii?Q?6Vlw0K4nqMtzGuHklLYMjar2VaL7BpN38J7R4QclNz2yyfyqaiGHFil14Y82?=
 =?us-ascii?Q?/eKxXzaaW4CmMd427Z/lZZhNi4c2bh+GjwiabvsbTTtrNzJIKF9w+6iZkjAt?=
 =?us-ascii?Q?JNis9CV9BHeqfv/FBoTLEwo5iwLOog6gkVT21Kn3e8HSdZrstB5P7sfxbZyH?=
 =?us-ascii?Q?Dp8My+q5fqf6yy62O6iRpCrytozRYQP2yyPAM5n9bud+xJYTUBcaB43PHc8/?=
 =?us-ascii?Q?JkXd/xX22wxwmiJXwCB4fp+JET8YI867aNICEHlcc/5CO/k6dwD7JSNNowHa?=
 =?us-ascii?Q?vmImrp63WyYTvO4D0MBVoJunpYDN38l4qon9cemgwQrxy1NBMO769JsJbDah?=
 =?us-ascii?Q?O9nzaYL8Nz/iY7uwpDWdOHHmICTqV1wknb+QqFrYblEB7u1VDGC48ggtMWaz?=
 =?us-ascii?Q?0y8OYGpCxEvxUpx40ikhlcUJwS65AYgiyEcQVGj6yZUCLNzThUgRNIoeT98d?=
 =?us-ascii?Q?aMoT/xv62omCgfKRWBsbcz2svPaYFbRlbvE3v2L8Iq0i59y3TNEU4HfcCKmd?=
 =?us-ascii?Q?K+SZ0fOH2xxVB/ze5kZAzztOkPZRtOnEoAM0GINNMheXlk9AqDgEOfXGoD9c?=
 =?us-ascii?Q?BlwRmHuFWO2OWCHSYF8nVvkq66KJU7YMlDFjpzO+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HzqiUNidfw/Wd91rCXleJoIbrOKBEPeYaApDuwBifmaXM3ntzZhky2P6eUS+GPRhLa5Q5vDnTLyatsvjbl5H/mgAIrH7GpMU1KDh+QgH2uPk+AYOpj9LW4/MfPcUmBgpT2aPk8CnZARJWqz9PyHw7NUYFLZv/8MtsPpTS5PzUY9d345Hx3V0laxChwkikHcBMg+7d3zvSWWIFNgylyXj6nZCKizl9Ml4FmSfogmllFZ+5UoEc6xbgUPjETQfIqjH5D3QrQueM3fDpTuDKi4HjJKNbZs49Z4bYGbVMbOtkvoE/C18sM8dcbDni/4Be+nA+08Yvk3G4y1pgJ5dVNJQp8dlnZldJVFHB3HGHrZ+YhDNvWRA+Frpw48VQILhZMuEb2nQbFW/TZyA2C2u/FLuE5epi7YXtxa62YpKbHOhQSF3wMqGSb1fYzD4DJG4978lyd8UICxN3oIaLlbCZYG+w7AXt642U9UH++fDoXiF4c2q2TiEqsuosZ29CBRr/LxTSoM7ozum+7c+8cOYfjI/q32+f+VknS+aM1v6Nqwww1MDVyV2R1H9quwS4RPLUofpIvjFlUOvd9pzv0tn3CCgoTbfB5g4Hfq47xwhRwTlFZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcac63c2-63c8-4319-b216-08dd83072767
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:08:10.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulBd3QA/UiMPlVIqCrgk9Vvm+FwksXAjhX3hZBg9+DJn7ubGVlH6V/ySCOs0waUwx2i5LZbm7wsjlTwVjy0EGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240053
X-Proofpoint-GUID: sHpwQcPhtBb7vzqUiYIfLq6dI8xa-RFx
X-Proofpoint-ORIG-GUID: sHpwQcPhtBb7vzqUiYIfLq6dI8xa-RFx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1NCBTYWx0ZWRfX17C0lQO6SPPL Lc/TutA5z4h7okrIO9F/fzuNoin1//QiFc8Chzbox2u7TYWA5zVLdxGeihkDMaRdC10fyrT/oQb sK3ySiDBLCo07HklIbhQQSaGctgU/ZriAEC2HBFHRwJDFeV6vLIet8PHuXKSsssjn+aCrLCrj9+
 4wmxC3sW3klcL6kpnzRBsus7Rm+7xWplRshmF05PvASBoDfyCzHdzD3nhaJskX7D4I0NpATfV4n ze4VM+BOCR4Y+6WD02UMKjlV8Fc+PAivmBywMTWcLZWU5gesLujZ1MKYov0pJGznLptA8rOEga3 xc/ZfdvtP/8+QDiVAYXrfHUfvH5x0TmqQngx6NoukR5yAWKN1UoWC2Q1ax+CLNkFoHcXq2e8aYP DfAcC8WK

shuffle_freelist() function returns false when 1) it can't shuffle
the freelist due to lack of a random sequence or,
2) when there is a single object.

In a later patch, I'd like to return an error in shuffle_freelist() when
setup_object() fails. But with current code, it'll be hard to determine
whether it should initialize the objects anyway or let allocate_slab()
return an error.

To address this, decouple the shuffle eligibility checks into
should_shuffle_freelist() function and call it before shuffle_freelist().
Change the return type of shuffle_freelist() to void for now.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index dac149df1be1..95a9f04b5904 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2534,17 +2534,21 @@ static void *next_freelist_entry(struct kmem_cache *s,
 	return (char *)start + idx;
 }
 
+static bool should_shuffle_freelist(struct kmem_cache *s, struct slab *slab)
+{
+	if (slab->objects < 2 || !s->random_seq)
+		return false;
+	return true;
+}
+
 /* Shuffle the single linked freelist based on a random pre-computed sequence */
-static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
+static void shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 {
 	void *start;
 	void *cur;
 	void *next;
 	unsigned long idx, pos, page_limit, freelist_count;
 
-	if (slab->objects < 2 || !s->random_seq)
-		return false;
-
 	freelist_count = oo_objects(s->oo);
 	pos = get_random_u32_below(freelist_count);
 
@@ -2564,8 +2568,6 @@ static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 		cur = next;
 	}
 	set_freepointer(s, cur, NULL);
-
-	return true;
 }
 #else
 static inline int init_cache_random_seq(struct kmem_cache *s)
@@ -2573,10 +2575,13 @@ static inline int init_cache_random_seq(struct kmem_cache *s)
 	return 0;
 }
 static inline void init_freelist_randomization(void) { }
-static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
+static inline bool should_shuffle_freelist(struct kmem_cache *s,
+					   struct slab *slab)
 {
 	return false;
 }
+static inline void shuffle_freelist(struct kmem_cache *s, struct slab *slab)
+{ }
 #endif /* CONFIG_SLAB_FREELIST_RANDOM */
 
 static __always_inline void account_slab(struct slab *slab, int order,
@@ -2606,7 +2611,6 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	gfp_t alloc_gfp;
 	void *start, *p, *next;
 	int idx;
-	bool shuffle;
 
 	flags &= gfp_allowed_mask;
 
@@ -2648,9 +2652,9 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 	setup_slab_debug(s, slab, start);
 
-	shuffle = shuffle_freelist(s, slab);
-
-	if (!shuffle) {
+	if (should_shuffle_freelist(s, slab)) {
+		shuffle_freelist(s, slab);
+	} else {
 		start = fixup_red_left(s, start);
 		start = setup_object(s, start);
 		slab->freelist = start;
-- 
2.43.0


