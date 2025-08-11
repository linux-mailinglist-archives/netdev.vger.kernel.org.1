Return-Path: <netdev+bounces-212394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DDFB1FD80
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 03:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564403B5BCB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 01:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB57C1A23A6;
	Mon, 11 Aug 2025 01:29:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80DC2B9B9;
	Mon, 11 Aug 2025 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754875788; cv=fail; b=ickKo/duKpu6F58staZyDqfyk/MMWGvkZcxHr04hZYs9LrvZirrRWcUfE0/JgG/a3zvFepRuaEZYEg9r0BGUjWBoGS7Zkmp20TYKWAInBbasZHctRTCRE3OH+X3K9R0obF3Wc7B//We2mQTQoePxLgKHjWI1Qw2/xWs+yUVd9nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754875788; c=relaxed/simple;
	bh=Gjs2ohOaPMmq9/7BWyTndqGUbol6m7jZ75EiXvx6IOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0WQN7qjpRPBTCEb9/c+dKNNO9xytCMyVAMJt97N+DzGMNIv7Nh1/OloPdXAhHtPuUFCbBnRZiihBBJvnO8bspYr47Bzg4U2TIK2atfsQ8wep26F+KP6pVWgwRlMxensb5/vxMFeZDZf1QAbk9q6l3qpQuar4xdvgo/EKgGfXac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 57B1JCGl1565319;
	Mon, 11 Aug 2025 01:29:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48duj2h5qv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 01:29:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpvdXWsP9s77AXPl2IBeJxQU1S6et5vUEReEep3vdilsqqHE4QDZIGNkcL7VwUBUYrg32xK5HQQ9eP5B0rZkvbndU+On5eFRpG9VzDKxT9qh6NEa0qXPgRwMQMXImZ0cKSM9SZacK7t0Ts9h1nJjqwDTY4MiGaJzwypBKBoJd39ogd2W9VEmDrNNu4jKUQFpa93gYC8nDZzVVRwhefshKOzh+R7ze4PJGnM2RPbO98aoSIt1r3xRtlyoR1arwG6SM9ltEqL9bH4gMAr2Yd6L+tYPwKpuPiZvYJzZEcnnpMeJNenpqVLJSEWhKIZplSNL/mp4a+2irhFaByvjEtZ+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTvNhwzM3ERecq8uV/5TpRX0zLVX0WtK3E/wkgDAsbs=;
 b=GphHArDUxOlVdgAuSeR6TxWTvcwHc0cYSB72EbdaUBgSpGETjlqGgZPAuRvxQgbTJRazIZeeBzGrHZUyiURQvuLXZSFZWMsBjju9NhmnxgVcW69wgBayPGzW1GkjzvvbxT/epmbobquiFTi+zrOobdWgG+/PLIWvitBADLfblAbYE4pj8768WJlsKlWnIXpWGPGnNbQj78kNzQj+CTVAY1VnpHmG+xFNwN1ShV/YVYe3hgIZr34Ou2/8lzPLb50Vc8vIPjXG5dYSCeQDZw0Dm7uHHHikL0vDA/gZr+sJSigU7LkL8PSr02HjsLFDQ13yoj+yLNu/8S5lfKcVfYuUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21)
 by PH7PR11MB6403.namprd11.prod.outlook.com (2603:10b6:510:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 01:29:18 +0000
Received: from CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::813a:3211:c8fd:1f86]) by CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::813a:3211:c8fd:1f86%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 01:29:18 +0000
From: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Lion Ackermann <nnamrec@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ovs-discuss@openvswitch.org"
	<ovs-discuss@openvswitch.org>
Subject: Re: [netdev] htb_qlen_notify warning triggered after
 qdisc_tree_reduce_backlog change
Thread-Topic: [netdev] htb_qlen_notify warning triggered after
 qdisc_tree_reduce_backlog change
Thread-Index: AQHcBqwnVxttHlrD2k2Y5Jexvx5xm7RZON6AgAN2HL8=
Date: Mon, 11 Aug 2025 01:29:17 +0000
Message-ID:
 <CO6PR11MB55863B0140027E0CB77E5792CD28A@CO6PR11MB5586.namprd11.prod.outlook.com>
References:
 <CO6PR11MB5586DF80BE9D06569A79ECB2CD2DA@CO6PR11MB5586.namprd11.prod.outlook.com>
 <20250808132915.7f6c8678@kernel.org>
In-Reply-To: <20250808132915.7f6c8678@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-08-11T01:29:33.639Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5586:EE_|PH7PR11MB6403:EE_
x-ms-office365-filtering-correlation-id: a8abfbf2-4a88-4fd1-d150-08ddd8767d7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Fv3AAVDFUBCFvPI42VOMEdlDqIW5M/0qaqHOl3BkN/LgxiDYV6lr7R1TzYb3?=
 =?us-ascii?Q?GeJTJZoJYZtAl9hnTufAqUzpeBvbwsWu9lgXFevovcf237xe/lOXaIoGLJw9?=
 =?us-ascii?Q?pq31bvWwE5+alWN1Eys1t8EmVGZzpVqi7WjaA3Lzm6MJ0pNEyKOhze8GtA/R?=
 =?us-ascii?Q?lJsMAcmj9n6DsNMlCMCmfP7hAVpcCMQC1CWW0WBOnCwjXhmRyYPzmBMbgKZ8?=
 =?us-ascii?Q?9N9ZBl5evpt2k55IBktEbnQcvBQGF5xHAZ2p4/6Onp0F+hgB/xDe2frfOD9l?=
 =?us-ascii?Q?cqLqoIf0B+Axvs7otPQczdjozcB5UUbObBLNEvF7puGqqcroi1/V+5xqvnbd?=
 =?us-ascii?Q?yUlXDUxm3Y5egYoU1Zhwo468MFMAo0B1/6xgqU3TPDTZXyL90wOeeHwedymn?=
 =?us-ascii?Q?D+qh4cJgilkZJjEKeHmm4prWBDqCwxJ9Lrnw4lW4EAjhA4o+owJ+2XHg3VVP?=
 =?us-ascii?Q?z4l0dM94ana5pAJQlO31lVeqDCIfq/Cm7F7G3nFHa2YJBghhhNCUhNAUE5gv?=
 =?us-ascii?Q?CmafXvvk+WA/rCHQE6+V9Ywm2l6f2F1LvI7i87Hurm8iY1I67quH6m+SaRNA?=
 =?us-ascii?Q?+acBIlHUFMAyR2dRMBJ4H9QWXe5GroegWljl2H/nMGJAjydUtWReWnUN63vi?=
 =?us-ascii?Q?hAckrd5IZvquGETqM19GLOjpQSILxzLe8UyZf+3d3xz8mG1DtPO6rGfK49tA?=
 =?us-ascii?Q?+zGsuVyKDP/t1YEyItvMlKf0R/Hr1lBGI2cnnIHb4b0McS/bgkYe1CgSTezT?=
 =?us-ascii?Q?RCaMb4awZ5woiBY6n1zo31MZqAZ4uaMaQnfLfbgM5xhoTXyJqxjKELatz09A?=
 =?us-ascii?Q?X725/KBIjwMk4CeCgKH0Sef9aU/TvSkIxMFVIObrOBSSNyoelBx/KZTtj90G?=
 =?us-ascii?Q?rsYOcqbC7w8mQgLpqN51XCxU2nOLprrBSh8RYspTaoqerdawwnrz9jo7d/O7?=
 =?us-ascii?Q?ahGBnvc9MBiOO98UeWpnzgRITgGhuGFHVIRUsdcSBGEyoZvnOimLiVJyDkaT?=
 =?us-ascii?Q?rF+jWricyhZfQukpS4TGO2Vqb6K8H6v6/bWTZ4CZkJTjldeUUGdR+YPlO8/r?=
 =?us-ascii?Q?WyLSR5JM3ZtJ80XWFmLUlawViqe5udR5CIqS2cb4Y43qig9jMfUO+ljHx5oE?=
 =?us-ascii?Q?azlDSA0eYafVCpzdNPckmAyUSN89ICZi/PDtLcJKRSYJH7MYf2YTzPrzaeCQ?=
 =?us-ascii?Q?PXVD/hPXnTl25WBpdKWzEKeRYqYhxLslgnmAuGmAqUqMI6WG4Yq2wsu/YBWc?=
 =?us-ascii?Q?q4IIsc1KieA51GoiPjKNs0A2ZyEguDGla5KS7GFV3hINbXiK1Ycdtc4G9TQk?=
 =?us-ascii?Q?Xeq99we72woxLUnb1bmLXRXvqq5ozf3PznTm6ue5geRj4l6C6GUzWrOpg+7T?=
 =?us-ascii?Q?wr3IHVv4hf6z6ESbgGxw6aXfhbTDOuC8weAIUaAF/iDIlxJ2FVJs2TrgLtr6?=
 =?us-ascii?Q?9d5vulVNkt57qhM3LkNiZ0zlRhAs7JbV7k6vkjT2GjfGsUcuKHn+EQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z2sCUk7TvZPaq+2tTCShp2TKgoHH7Z76jBVPQc2HoppcC0/QEeHJlJs64x65?=
 =?us-ascii?Q?xqYLDv0ZazkgUwdNpYqTIXJnbWHZSSCcRau5UmYrVFX5RWYA5UbAMxZfhs85?=
 =?us-ascii?Q?gd/7qn2LFa2Q9Ih/4cY/SL8/XrKI/y/HvoHRAEKannOdl6GMkFxwdr2qKQky?=
 =?us-ascii?Q?LlFfuD7aDTjBrLdN0RvtA5tIqdN9n1kaf81Zm6L5DX7fy0N631sKoUQ6lHMz?=
 =?us-ascii?Q?K/8OpRxM+WeDU9u2VPCGGeK4yjUqhmd+4xfw9VUCEBXmU2Cpi6udmul6MAbQ?=
 =?us-ascii?Q?Mti6921vmczPwDqe0WhZ4zbz0jgOlB3xXDXtItIUKNhS4xF4cURZWRpj0N0M?=
 =?us-ascii?Q?EY7fmO+HQcZRNH6QcKA+9sUbVcr6ZzFL+CIx6O2FszD+W3V0ol7NwWiIb7S5?=
 =?us-ascii?Q?z/0bmch/24cjt7C/JLEeEvC8Eb5lHQnTkx7cbEBrsAxIZ+hweP270+u/kSkx?=
 =?us-ascii?Q?yLRkon+yUKeh7QtvwSJHWIsdFDNIW8kXE2WT9/yI5dBo54OXUXxr0hps8cuX?=
 =?us-ascii?Q?kY8OVKpA6rz/yyEq7vV2gMeV6qMY0Vl/OOQl/G7K9b5LFIXDUisabh9x3XTx?=
 =?us-ascii?Q?+XheUyOCzTirlD0qElgS+GjbnHJtrctDyoeubEk2jpoUBg6emzidI2RhOcqQ?=
 =?us-ascii?Q?DVu+sssfB7jHJJ8T5bXMdvYbsXN06Xevu2gKYUFqbQFG6WOu8QAbXsjpDw+M?=
 =?us-ascii?Q?318qggVqpRo5uAa5tP4sv+MmyLJWmPer7wu5m611VhzC3Jhj1a97yRRS1sln?=
 =?us-ascii?Q?VtblMKMZf/CZLA0JoNAGTiSCcVwJQG1kYtFzaYK55WaxSo77/pZxQOVzI95y?=
 =?us-ascii?Q?mKvdgPXj/kpPWHChD8pOr1djM6ymJnWUpukoOcPKW+qclFUwOa8vXQKlj06N?=
 =?us-ascii?Q?gVi2o92C1OSLtUr9Ns3/xph/GcGyAO5b6AZMr12iyxYI8OBARvtlBpqSE4c3?=
 =?us-ascii?Q?dtC8EC8aw3UyDuAHVI1S3lQ6pua658xJTV/rafKc7/LExfCIg+MQaAo9x2ys?=
 =?us-ascii?Q?lluUsANVgJdDmZ0QTHa0kCc4jCpybjPCE6QD5ULImO2p5IgJPNz5E8YcOB1P?=
 =?us-ascii?Q?YJ7d0/KmkXkyZAFh2/AXTE8YC3uylWd0kXQg/NzQCJLqt9byag2BfOTf9GRm?=
 =?us-ascii?Q?SAvaOd4uXBkZ9ziwT/+xBA4elK3yKnvWmZCCo0QEBQwChvWVKxnWZybZ9w23?=
 =?us-ascii?Q?f7t6uVqqLi36dBLe2TbsAKe9laCVGtys++Bg5WjA8Fg3LsL3I21gE7R/+CrA?=
 =?us-ascii?Q?tybxtFJlDJG5gg01fk2Qadv4+KMp3QycKNmU/EM8PpZMeCMAnnDxyBsz6by2?=
 =?us-ascii?Q?2coztk72Dt7nbBaK5KIkM8DNWn/2fiXu0nbYufR9Msgl6xLfgyWypcpjzTgH?=
 =?us-ascii?Q?Bwy06kl+oyMcTRSrx7fdTJFjFBIGmyEkEXgT3MuD2pp9kFNQW1+LgfyHa2yB?=
 =?us-ascii?Q?GnImHepjyP6z7WfOBN9jr0ZDPaS3mPfWjIqT55qlFFGofg1h2U6wfezxzoCJ?=
 =?us-ascii?Q?d7gfRJ2TOM02g53zA1C+BWN0ECcM0QiwieEfC7gZvSXt5u9kftNUjm2Ui6SM?=
 =?us-ascii?Q?COf/ZD8/ElU9uwqANQ9vYM0r61/zD7T6dI5+IH3a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8abfbf2-4a88-4fd1-d150-08ddd8767d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 01:29:17.9156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2PMHK24FnAnKdPUzWcATs5gi8YEuI3XC0muSDktonDt0vk4pA6E8Kp7YJxglrY+M1FQv7dFdzbOYOzxHAiAqauMpVBVCI2hag6A/EMaZPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6403
X-Proofpoint-ORIG-GUID: nWnDzzAq56RgRYKBr9_SLgMuNhj_c1ON
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDAwNyBTYWx0ZWRfX8dSo8P/IcA/V
 dRWhOax85akX6xy3N2OtEQbslLWqHXqzFLffCHrkCwNbpQVxP1yBWxAyh584RBmAq3aSSf1mHgG
 fd453sFo1V4i9pql86RcAdHqd5YyjmhHz/CU2Z9tca9vrDHxnZPfR5yAxuhkucPqs8MmOQi3Cei
 QLha1FYKP8+jxVt+36sleWrE7FlMtf/XbWgNbJU9kzFggjWJr3lPibGiaFsu84GLvOechEoA2RE
 iJB18cqIfr1aoOXTuevaE8EAjI28S7i50jWxDDJPBaS3q+79aqjRDj9FwUmYIey3t4qaMK5GrIP
 JtFWft/AjdCo7aHm8SH2vEuv2Z2RAsBhVreLrIB35zBbPNvQicmnDAxGhI57FY=
X-Authority-Analysis: v=2.4 cv=ZKTXmW7b c=1 sm=1 tr=0 ts=68994772 cx=c_pps
 a=F4q/CHviOwOXtz23f/c62g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=SGADynmgAAAA:8 a=wvPkM9v7g1_ikmSEda4A:9
 a=CjuIK1q_8ugA:10 a=zIHXHKGEX091kyoLcxqF:22
X-Proofpoint-GUID: nWnDzzAq56RgRYKBr9_SLgMuNhj_c1ON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun


Jakub Kicinski:

> Is the issue easily reproducible ?

   Yes, 100% reproducible when with the kernel commit of .
   it caused by the kernel commit of e269f29e9395527bc00c213c6b15da04ebb350=
70
   when I revert this commit, it is ok.

> Could you try your reproducer on the latest upstream kernel ?

    for 5.15 kernel , 5.15.189 is the latest upstream, this commit is intro=
duced in 5.15.187.


I don't know if OVS should be updated according to the updating of commit e=
269f29e9395527bc00c213c6b15da04ebb35070
or the commit of kernel have some issue itself ?


________________________________________
From: Jakub Kicinski <kuba@kernel.org>
Sent: Saturday, August 9, 2025 4:29 AM
To: He, Guocai (CN)
Cc: Lion Ackermann; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; o=
vs-discuss@openvswitch.org
Subject: Re: [netdev] htb_qlen_notify warning triggered after qdisc_tree_re=
duce_backlog change

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

On Wed, 6 Aug 2025 08:29:34 +0000 He, Guocai (CN) wrote:
> ### Environment
> - Kernel version: 5.15.189-rt76-yocto-preempt-rt
> - Open vSwitch version: 2.17.9

> ### Issue
> After applying the QoS configuration, the following warning appears in dm=
esg:
> [73591.168117] WARNING: CPU: 6 PID: 61296 at net/sched/sch_htb.c:609 htb_=
qlen_notify+0x3a/0x40 [sch_htb]

Is the issue easily reproducible ?
Could you try your reproducer on the latest upstream kernel ?

