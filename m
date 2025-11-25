Return-Path: <netdev+bounces-241596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4F5C863ED
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70173B69C7
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F50632AAD3;
	Tue, 25 Nov 2025 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="uC33mvsz";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="SvGvOQ9j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EE18FDBE;
	Tue, 25 Nov 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092254; cv=fail; b=iecPGBxhOlZML8fJyzmKnme6fhQYuiMINm27bNP9Ur/QbObhVwj4VY6HalJQACDor0wxAWrZS5npS1hSeygOnCzxLkI1aN0O//5yncvyuo8JMDcvOsK9F0L7rgwmtSZuyGqHGuadKIFl+vQTEgztvI0K1deG2u5boOqfs219Hh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092254; c=relaxed/simple;
	bh=U7NPw9YTLm8Pn0dIW1Hb/TU5c2nxaRKkKKmpg2R1kgQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Btq4qwCyH0tLVwbfysqbA+Yyv4rx4mKxXYPYIl9NAV6PdVzhHDo9poHDtNyRLLZYIesbWfn1x5dqKAK95MJ/GIcYlvrYderh/THCV0yJHm80aMhDoK7v1WucjNziHTF6Px0nR4FMqm5hAh7wHCVf6NPpkxExRBgI5Pi7cpteQfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=uC33mvsz; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=SvGvOQ9j; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APGKYVp2183742;
	Tue, 25 Nov 2025 09:37:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=FdS4HgqOvmFwi
	tm+RKHdrT4ha2uP4cIFkIgWNrhHn+I=; b=uC33mvsz4N2wphlkzC2tJvfEd3+xp
	/4THv46anCvZeJUoHRE9VcNSKEfuQ8nUK99eXKQHpyuyJOCDQj/OPfOIraRBn5CX
	5zcg026H5YawWuE/eRu4JRdWBGWFTC2f17JuV26CRGGDOZ3VFIJn+0C9UGWuM1WB
	UpicDidbyIFYNENuuPOqTPL3her/oGlfibk5uechGAh+sXszeRJNBHUdJY1ui3Dq
	Ds0hbQAUnHcjMbV0m5E8FRJC3A8Wr1yzyKJ/+pznA6kO1GDfjxi6kedxXtHt2BOa
	dDnftp6iIktS3WpBqYjauajnmeUZ7tgLk+h7LitV3YIrTXGuRfbkzmt/Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022099.outbound.protection.outlook.com [40.93.195.99])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4anfw405wn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 09:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbBL1PJQHvqVWDvMbvOoKfbaFIzBONDB9fsnU1PoT+KVPd/EZxs3q+BFlsU9e68uo7ba2Ww93TIvw0p+QYWqIu+vAqL3qdJQd5U32V/UyRRvj/4zAG/C8Xrl7R/hOQ8ZlsJuXMRJ0XwMWBVLM31yQ8PRuOtbYei7s0xTxVGYoTPD8MjOwnhCH4WxsmTn3va2GBPHrqHqusDhlU4tkoS2NlRzESo6RCDIDylVOpQz3BKSQD4g+lfklGz05baBO5Fwf1BezYVgHa8cGwMJk6+ADKvCLAdbX01/0I7gr4nW1gy8XqC/GDny0cK0wQARoubOByPlG5qVK6t9YY6npDlDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdS4HgqOvmFwitm+RKHdrT4ha2uP4cIFkIgWNrhHn+I=;
 b=kzQAOxlCRXtWHwyNBbMb81r1QgV2K3W1y0GYboyBEeU4wZXkkyvURlOAinlqPpI+BNlxKKYMWLm/XkiyB8zEXZqBIc4a7TJ54jyME2+4TbOQe5Pbh/LORzAfWb6A3QRmrw0oJRAQ/eYHTLchYfX0phAs46DASyTsnHJR+zBiX9VOzWyByg4i6ZHhqlWocWEnVfH89EIgfw2OYvjkyjZmoYcwEV3pYswhuLH5hIHD/5tlaj/Y87+ctOxy31SF1jvp3hYHt/bfoVxzjHD/gAU9VgjbQXbMTNfHYnPCLepImzQ6yZcf8fdOGyZM6IHmwWeCTN/3FZAL7EVxdsBmryoABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdS4HgqOvmFwitm+RKHdrT4ha2uP4cIFkIgWNrhHn+I=;
 b=SvGvOQ9jY3tvFaQ3rHdyHUjcKJe16xm2Uk+oG25YY0/rYXKx+cskY+QrCflV6D6H9OWlZh0MV8ZZ1taYkjfPaahGlUp4QOhMbwjOQRPu8LB9cVp8Rq2YS4vmm1y+ROnKgNub2t7+UETykwXSoUB6A1jnlWJ86RQE8h8dKKzf64cmrrSwb/EVaEs2JvLSbD+qCtND+0Rx+nU/gDrhm+Hxn6HylWtojurxnsy+8I8C02YYywGvtf2Bjh1BvB5Ynj2Vu3PIEHOPy6he6qmUFmhO4tRHKKy2E5hsgYvs5sZAnXYPLZQ7SFEZFIq+H6l+02qdiT5Kx/epAeKCysnOEOVe5w==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SA3PR02MB10926.namprd02.prod.outlook.com
 (2603:10b6:806:47f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 17:37:14 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 17:37:14 +0000
From: Jon Kohler <jon@nutanix.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jon Kohler <jon@nutanix.com>, Ido Schimmel <idosch@nvidia.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] flow_dissector: save computed hash in __skb_get_hash_symmetric_net()
Date: Tue, 25 Nov 2025 11:19:27 -0700
Message-ID: <20251125181930.1192165-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:5::7) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|SA3PR02MB10926:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d770b5-7660-49e2-33b8-08de2c49455b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gEwLCt9uasL06qZzBVqULMaG7FUb8hs1rekc3u4oWuHmE7egjL8RNuzOcY0w?=
 =?us-ascii?Q?AKFJnniKGvDZ3k6O1kSqd1vjb79VN8jYUWfjhTmRw0ciRmdrR8J7tcrYZUqg?=
 =?us-ascii?Q?ZYJJWSz4/GtHmOHDqSLuvZD7EzoF9oWZNM+CZ5c/v/QtXItRqsm393hNsSUD?=
 =?us-ascii?Q?Z2kCKkzLxjog0504x0Ubnc5mmI749RQf7NraQdLt6WkdRK6kmL1II2+wEPx9?=
 =?us-ascii?Q?IWrfWY2myoLKGcg5X5aKzUV/YR8fY2F8iFoGHBraB23uWGOha4RUq6d8snoz?=
 =?us-ascii?Q?NRW0+SW4UBvb4JbO6YIz6CNW2ADhhRVLbjjwTWsJ/K2pfCro76iYbkbMu7UD?=
 =?us-ascii?Q?1SCgc8nnztMLgUs8CabIwbAcjWuqpV287BfgeKz8Yah2iqDjGYpX3ujhXuup?=
 =?us-ascii?Q?duhoL32Sup8LECQwTqCB+OK8UfM0FnJKDrI/5GQjNlsN9XycWigOZ7mCJnEL?=
 =?us-ascii?Q?MFzmU2RNHMSeINU4X41GPeCP71SOjOzvGXUyB0WvpgRcy+eC/VTyojB+XwA+?=
 =?us-ascii?Q?gDBu3NDUu6zsLEBY6YSggb6V32hjafzJtZKlHIuntmJe9ERZomAUaBod+dLI?=
 =?us-ascii?Q?KUiysFIocbFlL4Ol4KS8mo6iVSJGX5dC1w+0+rIaLJH6KJTuU71fa99cUW2b?=
 =?us-ascii?Q?XJCqJ/6bxCWVgqeU1FXg4D4Y5eIaL3naPsuYbA8pFSY0SPiT4/ub7UjDitef?=
 =?us-ascii?Q?SvzTYvIgf5pjuepWwzXJ6DRzBUvmI4rpPR6y3VM9/qRXCYrWzMgKrxoE5FXc?=
 =?us-ascii?Q?X5YzrqAY0kQ/ilL/MbLM3211sJiJeYnj2qGn/8RFxFtXtunnGrQACQ9sNgBB?=
 =?us-ascii?Q?OGMckRILh21SYo5E58BlXjtdnqA/cKJ2KSUz2xm9SC2eXw/jwZ8mgcyz+jBZ?=
 =?us-ascii?Q?PekLLi80EnkZwOzfno3o5DM2w+wFSEtnsOVWB7UfpkqEyAAt0URunJdmcH+6?=
 =?us-ascii?Q?HRZBisJGE9/sbAZAqB3oEm+sxCDNfBZVgwm/IL9x/gyWEbWmOLWHw3gcZAWu?=
 =?us-ascii?Q?M0aps/SRpHwL7a2z3/oV2R8p+AhvHztApfwCYI/s4v5zP+4ObNJQnt/yfYbU?=
 =?us-ascii?Q?mt0V9A4x/Yt/sYbdoOMXcJh6YbMj/wW2VrROEtP78RBRKILUa+AH/3DptD/N?=
 =?us-ascii?Q?ay4sre3Tuh/4AYXhBGSyDIHvMr9sBLEFVu+ILGSqkxAVlJL/cZchpT3nA2X7?=
 =?us-ascii?Q?pDZSeCF+4SIsAfPGpffkq/kmY5KQPRaTRdGqwpbVGRdGEpu5sDT932mB4/lM?=
 =?us-ascii?Q?TbeQ9PFJA9byiZCyfXCzFagbhJl0pe+VWmIGx47e2fR8uRhCqE1nRaea95bf?=
 =?us-ascii?Q?eulvdlkol4AslNjD5fy/ew+cTRWQHTDWY8AWVXX6fXELfJzWPb+3XrXNFwvM?=
 =?us-ascii?Q?6Wr3Zee4SaFVXeNOsW56OlL6cadNcuAZldYONr6ja/qAB6m5a4QLLVy7vKDc?=
 =?us-ascii?Q?wGdf0Thb3+qTKLRoeAz4WNVBqgUrQYbyT4xs2eooy/KHHmtGmA+SUQQ++hm2?=
 =?us-ascii?Q?2KaQ7yGtPbg+rrOEb0q/3gGnxusS7XEGUp/xL6rERYrJuLDQO/r7WMtTpQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6KWdy6PmqP4RHNZelpbbwAQw1wRycMic2mPAtsj6Z0mZ8Gfe97uIb5kdZBgv?=
 =?us-ascii?Q?gq4/OrkUgzDikRqzneM8EjiAOqBsfRniQgPwlAHOIdZqZjMSXZ4DGOWwdln4?=
 =?us-ascii?Q?dkaQmTA8qJFIRJc4HD62qa2KokrL8OgjG/Q7RdVBVWjRsE8uCjznCchbNRJa?=
 =?us-ascii?Q?od7Gr9Ofq0y0YY8zRgrGE93cQA3s8QpUqbcVm77LSNiFjz9/67QurI9Oxw8T?=
 =?us-ascii?Q?28Hldu1VBxgUWQOYgI1Sbb67dvPDgZfMfSz907l/Dc32ZI5guzgWSE1jNH5l?=
 =?us-ascii?Q?egLFG8RjN+W2/26p+8eElbTIia4DoZsjdiJqXbQ+HSQloFR31tlksBo4oMW6?=
 =?us-ascii?Q?5LTUxP90bGS/GbIPW2HQjIFbuwT9pj4SwGaZO8/nSxSLz/hdweKq29xceFDz?=
 =?us-ascii?Q?lFRI3/1rfajcTs8Uwp9zZLrA1tQyaJx+JyaE3Wz5NiEl2EqzEy42ibyi0phi?=
 =?us-ascii?Q?poyCwT0pEtw+3MKbgsKwTSuvK+A7ydQIoiIGmu+/A2ebBMmxPuEROVd8WuIX?=
 =?us-ascii?Q?47PRrhMH+mLL3no2qlT09bISCyB1qNCjNn3wELwIJYkJkwdjumvsG6JpFo91?=
 =?us-ascii?Q?++M4aK1DRmQyjZLjV6ut4lGJ0ZNh53V+BYIFheJ79586vfLYDIaKx/OvP5S6?=
 =?us-ascii?Q?GAfHjNqSzB0g2uhzmu2466yNoZnZ+ZEh1h/YKELqteIH4r/ErtxwfV+/b2q/?=
 =?us-ascii?Q?yskwibQRBsDMGyt4Hx8W3m402p1V9KQaiE67ZcFUziT1jZSgzu/Osm+3puu3?=
 =?us-ascii?Q?wJ9Kn5N4aPhnp6o558tUkwpDep2G6se6zI+epkmV7lsoPHzIN20Nv5Q6WuyM?=
 =?us-ascii?Q?Ptgi3SELlHgRaLmd/J79nhP9Vp8+hX4GKynRSJDXHq2+rOmZWdwtEeUtGAEs?=
 =?us-ascii?Q?TMszhxfXCDa6Ac2gWKJl4r074usaUEx+RzZhixjtUI+t/1VqSt3MndQEGkfx?=
 =?us-ascii?Q?/+po43BOD/y1yhQKmIsgqz2Jp1TgccXOGfm7IOpwqUuNhwya2Frv+0kPtu3Z?=
 =?us-ascii?Q?pdY5asEb6o7ciCg36OZjSIdLVgU6uGhfil1BaJtSKOjZ4ELLpCLhE3v/utQD?=
 =?us-ascii?Q?0QhRgabFkxZ36dJJYC4TXqE1WNXyxcaW1WSEAfSXVGQ/mCoEzSlhpGTsRw18?=
 =?us-ascii?Q?HrjA72QHjv1PxN0i74bNlbmw3YIMnGfONhVdr19SLbWwboBxBcHcweBItPKa?=
 =?us-ascii?Q?zD3jB84OYQNDsOzJzcLimqhbR8WGA1CUrP0dHCfHXdIyua0T0pno3WRogmwR?=
 =?us-ascii?Q?e0Otzu5eCyGKVNH3b0ZCW0NZ0e3WI542KIsn5ouIJsK+tWLiLtHp58C0buc7?=
 =?us-ascii?Q?szL9Jzr9LiUcVohjeoluBCm57l8InJ/3s25WVgzryQmlc3ZMavH028/ASM5N?=
 =?us-ascii?Q?9jM1BOVpxLKkTll4Ye+oubr1fYwwaMMeOFEen9T/sEKqB4u82lluolYigFX+?=
 =?us-ascii?Q?HE7zQyzeJ9Ucs17iIllS6xqVmwdX3ZrU/S6nkghfL4zG1mQlS14wGfyGJLfo?=
 =?us-ascii?Q?NYRONkC4LQiH3LNx119R4eJ1GQFQRBZwdxrUaDmVvLHLZhKK8MjElwHNulq/?=
 =?us-ascii?Q?cOKdxhCQL65/aZ9oKwvl1jaFyaQP3/1SKCnWIXJxUJixyP1WCTfbDwKtBEbV?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d770b5-7660-49e2-33b8-08de2c49455b
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:37:14.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Rp0FUS26DQyHozjn3Vid4C3X3v87xUOrNrUHgPFCyH7ghX08jtLShbn/Vzzm+wqi3ZI9S6FG/WxaZhPBkAuDzDrW1c5IF2eLXP7NwurjOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10926
X-Proofpoint-GUID: NL2-NvmxZdUNcG4YNh2A_ajDSVZjF_ee
X-Authority-Analysis: v=2.4 cv=NfzrFmD4 c=1 sm=1 tr=0 ts=6925e94c cx=c_pps
 a=QfAu5cRUQmedtNjS8psswA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=ruzGN110qosAd2R3pxoA:9
X-Proofpoint-ORIG-GUID: NL2-NvmxZdUNcG4YNh2A_ajDSVZjF_ee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE0NyBTYWx0ZWRfX4qf0gRwvbtlj
 hAUrpBa/Md2jU1JqHRMx6CG0MdrN68XnFceC+tVffR/4tDVr9sETSaA0zGWq9r9qQdZVxcJ3zJr
 6t1aB4ZAnYO7UHZD2bSnRU/Sg2Jz1gmwLp0Wo/Tyb7y0b1yOnAalObMabhHkt2r4GRgrmMQm2f7
 c+N6QyyKVxHnEi459VBx6QlQWrgolf5rIHaooav9fX7+SZ577egALZZKseIennIr0rTFJoPXyR9
 JoLaZcAXm2pd/0V2iRi3VOQ08CFf8TyF7/JhFD6vOWNsuaqytyah6A3ucuEOwD36O7MBuFdRIeY
 y8bJ0QkXeZpG/tFVWKDWsU4GZFj0cdC+QggbjeJZ0+QgzqlOn26NvCdwHH2dkZfb/5I0IuJNYiX
 LGhwC6kwIJAnQ1ti/ItWczD9AYEY9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

tun.c changed from skb_get_hash() to __skb_get_hash_symmetric() on
commit feec084a7cf4 ("tun: use symmetric hash"), which exposes an
overhead for OVS datapath, where ovs_dp_process_packet() has to
calculate the hash again because __skb_get_hash_symmetric() does not
retain the hash that it calculates.

Save the computed hash in __skb_get_hash_symmetric_net() so that the
calcuation work does not go to waste.

Fixes: feec084a7cf4 ("tun: use symmetric hash")
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 include/linux/skbuff.h    | 4 ++--
 net/core/flow_dissector.c | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ff90281ddf90..f58afa49a50e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1568,9 +1568,9 @@ __skb_set_sw_hash(struct sk_buff *skb, __u32 hash, bool is_l4)
 	__skb_set_hash(skb, hash, true, is_l4);
 }
 
-u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb);
+u32 __skb_get_hash_symmetric_net(const struct net *net, struct sk_buff *skb);
 
-static inline u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
+static inline u32 __skb_get_hash_symmetric(struct sk_buff *skb)
 {
 	return __skb_get_hash_symmetric_net(NULL, skb);
 }
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1b61bb25ba0e..4a74dcc4799c 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1864,9 +1864,10 @@ EXPORT_SYMBOL(make_flow_keys_digest);
 
 static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
 
-u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
+u32 __skb_get_hash_symmetric_net(const struct net *net, struct sk_buff *skb)
 {
 	struct flow_keys keys;
+	u32 flow_hash;
 
 	__flow_hash_secret_init();
 
@@ -1874,7 +1875,9 @@ u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *sk
 	__skb_flow_dissect(net, skb, &flow_keys_dissector_symmetric,
 			   &keys, NULL, 0, 0, 0, 0);
 
-	return __flow_hash_from_keys(&keys, &hashrnd);
+	flow_hash = __flow_hash_from_keys(&keys, &hashrnd);
+	__skb_set_sw_hash(skb, flow_hash, flow_keys_have_l4(&keys));
+	return flow_hash;
 }
 EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric_net);
 
-- 
2.43.0


