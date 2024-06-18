Return-Path: <netdev+bounces-104598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8F190D807
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5131C23604
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5DB4D5BF;
	Tue, 18 Jun 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="AOn+F/H6";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vxXA5NOS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66350A6C;
	Tue, 18 Jun 2024 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726555; cv=fail; b=upwbimshUoh6GXz9mTCWrD7DcriLqBQ54iUg+Cf3iFOyllNJLwEh0cxLytmexMIPS9ktQ5VOFyiFj1vj7ZxqhMFsqij4bccyzOEhKEn/93Vz+Uy6s1Hp6I2kezjE9uwz1Ky4cTJHcKPy6S91yHH9cGZlQf8xwJIo86eTZzMjFI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726555; c=relaxed/simple;
	bh=sKTVWb4P5oKjthcfvLm7VnCCbC/PU+mQ1+FuyUcATuE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gykMVZeeqlaMVxAgBWeYSRpjg6ukWD8b8QiXT9bwmIOWC1xuSudPZkIsv5Lj98Ry3QEtNcLR2omLs5DJXmOAZuKhruyJDGOculJoPTALlxBCJPQIXkI8hGV7E/12DqkPgDHN0+CgUCtI0VBjt5+/ucOCmpnCZWotrBh4WrJWjVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=AOn+F/H6; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=vxXA5NOS; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I8TI3J029255;
	Tue, 18 Jun 2024 08:50:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=D+e5uPxdV9Tpb
	8jFJfepOxqQXLXrdWLvtZw8XDm/fa8=; b=AOn+F/H6Ufz3bPF437OxP9CbjJ++E
	GBqWhjdDTixvG5KJgDJRE2sFzsDOW2/IGa9hWJQ22ek15OMMrUU4K5u3HvHO3qyN
	Z6mlTaD0v1cSrfRmls1Pmp4FuXNqp3J4tzdRH5XtMNmqI3ap3G0ogdOxHFaBME61
	QuBWKBiQxmaUHITG7s0v+noQNVEW7jCU617Yu5NdYbhVGDwOhqMI34D3r06Nh+jc
	vQ3IgZpuco/Vp+uHXR+NtEdp7ulNCxpoBzo25KnyEGfF1wLS4CUDiR2cC08N01fN
	5U/FQWKOdcxdxplXo6mMQVUJJF/xZJdPwLLulLjJ6zYKx6sYW/Z7n6OmA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ysagv5pg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 08:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpqqGF1KKoTGJ3bfGOBuis+8c/4/cw3xdy+fgqEl+vbuOzvtQWoqfXa6LMxaNzFUBLtDTULi9qefUNX4waFTKdgt9CPdSHfYy0S4JVopY0+oOD3qqtGW/4dqRnH6Rww+x0CAi8R5nXkYtYDYpERLsWk7AodjCYIwoAo1i1Yq1xdt6MErSLkfa4zkOkbuB0uCfNdYN645UX/p5/INc0CKQsE2oUxc/nT3hEEi2orNdxImCEKc1C+HOEfhqrMM6RglSzAXqLP/emrfEXg0l5UYyihmhZmfIyCpMGl7siZk3m2mTtT3wt5k2Or3NtdX58hpwXKvsnCfpQP91LAOqpCzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+e5uPxdV9Tpb8jFJfepOxqQXLXrdWLvtZw8XDm/fa8=;
 b=OBrJXRGigEgVhTh/WZpLntqd9PPx1V3pn6ZYEVJKjo3+ljxu3xcy/GhKeOkKEthVTXObY5CvG0QqfrOlsRAKzrGhTyZMY+i8enCMSiuZY90eXKiLDWupkqMwFBL8y79EPqnS+EZNebbhjG6svVJHn9nJzqRAJ6jVsUj2gKlWq2hKJWTGfvoyurw8h1VGT1+2kA8w4uMZHXX9zJwoYLqQJEAKxUmzCLKpF8P4Z1w7tjBZn7/ixyJuE/x4PjR6X2o/Z4zZgwb928H1jZuCYQwHdSUo2gMCEyqoSzGDUr2wtR6YlbkFTcz34zAWDTo3Ei9KZ1H/ZIWY4azp/VGN6njRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+e5uPxdV9Tpb8jFJfepOxqQXLXrdWLvtZw8XDm/fa8=;
 b=vxXA5NOSHnfK9IgdIG+AE1YKxPkNx0Ai4J5b11nASLOCp6iLzUynVyIKBBsF/yafiZMEYK0K/R7vHgU58qLUGUvJjp11wmL7MChUgx4pBwiigUAN4WygNpV+MVmfqfu/NzpyswZwdSDP65+vr8MMBTggMaL4uNYA8L7gIScwdCxnjH6YrdYibJUuMydQBpD+tGCjabTLaHe4n2xVI11Yx/luZnVI2Rec37CQ4ioJrsx/BL8Xk/PTX6vVTMXBfYIrbGhMApRf7o8Bg/j3Gv86VE5mIfj0lvkUq68dUb3OkqGWqt0dt7ch6vKbHejojYlZn698ZKhBlfZtm5+8Y1JM+g==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by DS0PR02MB9353.namprd02.prod.outlook.com
 (2603:10b6:8:153::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 15:49:57 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:49:57 +0000
From: Jon Kohler <jon@nutanix.com>
To: Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH] enic: add ethtool get_channel support
Date: Tue, 18 Jun 2024 09:01:46 -0700
Message-ID: <20240618160146.3900470-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::17) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|DS0PR02MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: a358bd07-d1b4-4241-aacc-08dc8fae4db1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230037|1800799021|52116011|366013|376011|38350700011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?urCigmfFE0I/YtjHgIgq3i86HclZl8gZoW2WXPWXjAYlL4D4X/PLeNbZECfu?=
 =?us-ascii?Q?wQbeR578vT8ZnXGLvLGxCdPqg+I8MKtYaI5qqxBH70b1303wXYWlLrRBGo/w?=
 =?us-ascii?Q?xUTvNgpSlW+RCgstUFcp8eBCUydKYBP5IvpL3G+y5uKaOWes4a4yzpXuCuyX?=
 =?us-ascii?Q?9clqON9cFlGrlwC1z7WIzng97LBIFBSu6KbODRs+QJm+StA9Sgee4SDfNYMm?=
 =?us-ascii?Q?n2h1HpK9a/j4E/S4zv46PBwtGqil4TMJ1x1UyTFq9AgwEHL2lWKa43sM3kvz?=
 =?us-ascii?Q?p5cSYhaS5EN9iglX/AqeOI0HSuuyyhwsok+Cko51a7LvNDlZR5VNF1fhszqc?=
 =?us-ascii?Q?O963YnkvFAls84ocCq2qO4YD97IG3a1M05Hz2WB9gbgSCrKrUnjY2kUOjcD/?=
 =?us-ascii?Q?No0zzMIFnedDSC8oaQ2vj+lGM8/Stou0XOaALHyfuhLsL5129zGqM3WTL+1G?=
 =?us-ascii?Q?zNfUguZl8RoAxT9tnepmLF15Jtd0zVV3Pusx0yVw8XZAa95yN7foSkJL5lVf?=
 =?us-ascii?Q?+/eY6f4KCPoDBlVdjtKmUWarHF3+yNrFAkDl2n4jFM5Ks3JCWs/Lqz1DQOff?=
 =?us-ascii?Q?Nbf9e23XM/dYVAwKrDvlxvEPZdkv/1MJYHbwLA5fEFYQQ3HItG3cG6u8JODo?=
 =?us-ascii?Q?7Go1pIghxQYV+AN//Asm61+BymaWgrxZYOoyVBoyq/mjChqO7hfXmUo3GUOT?=
 =?us-ascii?Q?EbQHXphgPoD9d3eQThHTM2fK9xgMcvXHX2x7uQfAH4yPf+aykslWLIUmd94j?=
 =?us-ascii?Q?vIB02r4aW/hFm3EeIspGbwlV0CWTLo5T2C5r0SCk5mEQrjPvQNUu4NGjGShK?=
 =?us-ascii?Q?Pp+KpCxooNpvbDwveAf+iTdM8f0tZIRrjNObczSPw+9dxoc8nGA6okPYuBwt?=
 =?us-ascii?Q?tg2B4KOwrIfbUjn0b51EwxCtZk2fvxxdYxBhwKSdBYN7kqJMH1n33fL2T75N?=
 =?us-ascii?Q?JPrzszq+mlAGu5SzGvuL1E5jSXLRmvWHp1Qb3Nz/twC+cVf06lFl+exJwmJg?=
 =?us-ascii?Q?4gtuvSbOTHtuSo1Km0HHQEwjA8q9qGQvr89hZEdsIuVuDudNZDBdrZvXuAB1?=
 =?us-ascii?Q?qTWsWIp++8YphzCMy09ABOEOkinu2D5jdWtURIX9ZnLn36odmVz0eejCkAKe?=
 =?us-ascii?Q?YzbdR5hbJR4fIKlVBMsI6GA2BMlXeDdPQ+Oatf4u7wK752zQWd8jTpyTACYj?=
 =?us-ascii?Q?mI5/JvegFNlCsISGQG2L9ftrjg0sAmMqkhLFBT2TJ0j7/jCYqx51ExMDPN8Q?=
 =?us-ascii?Q?iEkm7xswK5Stp9rnV3WFV+yh3j/V7bkmDux93MJgPr6kIrlE27kSIQJnyc8W?=
 =?us-ascii?Q?eQmRnxuIRLB+nGkhEOfzlwKcaDXKg5fXk3pzI+jEXcED1FHXwoTz6b3aYp61?=
 =?us-ascii?Q?5N/1F5g=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(366013)(376011)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kTEpUmYePBeXX3zCRQvit0U8nKYRcSQQEuOrWSLnzB7JMdRfwhGM3wimGfeT?=
 =?us-ascii?Q?hWF+QVqx8ysob4qwqxwOAtlQhpVrAvzhXi5Ap7COZF2UcRXqU1arBhY7bIk2?=
 =?us-ascii?Q?YWAq392mty2/+Fk/Dp+h0vuA+YQm/cNzdZO+jUiMRg5HC4Ucl0zlve3K2Iq3?=
 =?us-ascii?Q?FKcuA4R6IAKy4pghhRsZq8v1osqdMKjx0XUJFvq4lN688CuW7dP14qkuQcOu?=
 =?us-ascii?Q?nk0sJPgUnizw2/u4R7hpNOp/bNnljqwInDkZnl+2Jo+rnA6Lhiv3pd9QrN+X?=
 =?us-ascii?Q?L+LhNRX0yWvZtLkKfNMlEylncKQ/oH+3sQnHJT+kWqbzdDU+rQ7wUk5iFVyO?=
 =?us-ascii?Q?7VEkj7820ipkiwjKEb1MD+AAcgVMXieysLr5cyHO2gOBZQx0At2qSV583Isb?=
 =?us-ascii?Q?EdZC1Pg9oLf2QFsxcqKHDNiB25ghWC0lFnZhGzXaBtQmIYQiCDsy3U7183Po?=
 =?us-ascii?Q?e/Hnwy5NPXbxfFdmu6p1fzPI43pbjmNC43lKDo8Z87JKSZ3JPo+4GiUXuIME?=
 =?us-ascii?Q?dMAsVB9HEtwv5eKL0xje8htOS6+XfMBDwKhBT8HU62gnm0zX2cCnGQ5jAqoq?=
 =?us-ascii?Q?NEoyo23A9DkmnP1wyY7VUV9o6nEW1m5wDQ2zX6DbnE86bHEvy3hiT8aX21K3?=
 =?us-ascii?Q?Oj91HF4W+08nJPDqUnjE4CQ7Q++zswvSz6C/QK8uHIZMIsQwA2fmbVDLeetx?=
 =?us-ascii?Q?1KbcaOR60JeCPbVe+yMhfWtZA3sVrkEvP7mPvM/Y/A91ROtu/0lCxNXQdZOn?=
 =?us-ascii?Q?TOaoZgVgp6WPs30UFCA1p1ZXscg97KhkwXLA5xX1ICsJQrk1GlDRXExy4Hi3?=
 =?us-ascii?Q?jbEBGubzMnQvCyBUzSCGn/bMe+Dp2liesEKwi2QFMiy9S5vVVRa3VXhhzKR5?=
 =?us-ascii?Q?4oVS+BqP+qCQet+jSBJvk+MXcSQ4yW7W7MRO/iuJ++HvDL/3GagbtynvV0NY?=
 =?us-ascii?Q?kzMCngRoA47q+DwwdOnnFzJ6sVZKyYmuSIwGRBJOnNlgqyTwkmlm2Ra3lAOB?=
 =?us-ascii?Q?tYKcpTxM/uoD9JVMpUFpM3BUYHWYQZxvdn6RL0p8zmi/4pmWxYsKo9Pg2o1+?=
 =?us-ascii?Q?dF6DGs+YsugjZMuZGODVkwcVMa0ZtsKaJUiyYGd/weJhBrZDHM4Ku+aF7VE0?=
 =?us-ascii?Q?kuni1uMug69oyDlyzIQc8LePCR9BWeh6w0VKaKkazbySG5cdm5466QaTdflS?=
 =?us-ascii?Q?tjhDV7b71KNUuoKH0AY8RlPbuZYm8vzeKLxlAcA9hxk5gDSYonXfYID4WjOM?=
 =?us-ascii?Q?c+jZwyLX3g9csSJ1v72+yuQDAiJq+HuSyVTQkVa/r9VYfPIDMWwlL6T5Ryb6?=
 =?us-ascii?Q?Y8ALGHq+VIJWpIpHQEgeAvke5tXszfDkSYIw7RpJIsN8VDl8jDfocB+cnFxd?=
 =?us-ascii?Q?K2ASF48wbj09Vvs9cquHgtYrmbkmFvgjeJVDQEpNAR+6l02Ajb4aNX3UyMxj?=
 =?us-ascii?Q?AqutTxZl1lYPEek2Bhx2d7ZpULunInkex9deESZjy+R7kHW5X3i5hiJlIcgY?=
 =?us-ascii?Q?jTSK2RX/CvQvn3B8UwhkfYRw6HA9YtefB5erVgctEfibjW3gu1M4fXqnD/z/?=
 =?us-ascii?Q?VtTI0EcbYKnJ3k2T8mPw2tH1vDfgHVfS3l3zjSUuH9I4eYelP1MEuO38blVM?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a358bd07-d1b4-4241-aacc-08dc8fae4db1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:49:57.1342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXLcKyirceXPHX7VA1T+VEPbhL7nJlpZQAPBuy8QWVRRhRQ8xkRSl7JOO1dMSWdwlVxtYgZctcnEOjfcoA+G8A8/44CWRtAjlJE4gl9+GGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9353
X-Proofpoint-ORIG-GUID: Ye9z2n6YGk96_qBJKdVfSmJRs_mU1mp2
X-Proofpoint-GUID: Ye9z2n6YGk96_qBJKdVfSmJRs_mU1mp2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

Add .get_channel to enic_ethtool_ops to enable basic ethtool -l
support to get the current channel configuration.

Note that the driver does not support dynamically changing queue
configuration, so .set_channel is intentionally unused. Instead, users
should use Cisco's hardware management tools (UCSM/IMC) to modify
virtual interface card configuration out of band.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/ethernet/cisco/enic/enic_ethtool.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index 241906697019..efbc0715b10e 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -608,6 +608,23 @@ static int enic_get_ts_info(struct net_device *netdev,
 	return 0;
 }
 
+static void enic_get_channels(struct net_device *netdev,
+			      struct ethtool_channels *channels)
+{
+	struct enic *enic = netdev_priv(netdev);
+
+	channels->max_rx = ENIC_RQ_MAX;
+	channels->max_tx = ENIC_WQ_MAX;
+	channels->rx_count = enic->rq_count;
+	channels->tx_count = enic->wq_count;
+
+	/* enic doesn't use other channels or combined channels */
+	channels->combined_count = 0;
+	channels->max_combined = 0;
+	channels->max_other = 0;
+	channels->other_count = 0;
+}
+
 static const struct ethtool_ops enic_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
@@ -632,6 +649,7 @@ static const struct ethtool_ops enic_ethtool_ops = {
 	.set_rxfh = enic_set_rxfh,
 	.get_link_ksettings = enic_get_ksettings,
 	.get_ts_info = enic_get_ts_info,
+	.get_channels = enic_get_channels,
 };
 
 void enic_set_ethtool_ops(struct net_device *netdev)
-- 
2.43.0


