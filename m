Return-Path: <netdev+bounces-95445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB778C24B8
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0071C21AC6
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB9C16F267;
	Fri, 10 May 2024 12:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B716E894;
	Fri, 10 May 2024 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343770; cv=fail; b=hDfQBcYPK7dQFm0DA9IerMzUG9NIBbpTBWxW0ldpam6YbAmYlb/bqx0CPVsYF1nNttY4ndjGhh+eZa+SqfFGP14fwv9q1uLLbTs6nwzh7GOpMWyX6nR1Igu/RDi/nbeou5NhLiTYnsyJLylTll/wIAA+FzYa3iwCgdU2vgRhDcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343770; c=relaxed/simple;
	bh=+RFZ4K1/cey4VA55HnAnhGWL/CH0ng1brGHyMcWKlvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DURV11cKcD8mrwefk0KkeBIj41NrugQaoXQFKuNrogpFtIMON9kK03wf+wnxXIVxMBEisVA+5jYVrdlMaf4TrxcoLA6NyEyTzR03ENVFQit4sr+teoMW+3kdxcFniDCBnpFNpCwPSKuOcvg6o/8C+LtBk4DoS7v6eaA5djIRUNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A8KSap005494;
	Fri, 10 May 2024 05:22:19 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y16yhggt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 05:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKXeukEvBFonBJP13jKTbV2OuFb/P6AOFXWZNPEgD+dGb2UDKoBIXD7jAA2bAlw+j690s3zIz4WHoXX37Z/qqXJ1RuEU5dwSBCIQc6GvzCf8Y26lLpUHUTC/Gkr7/eAkEWaUkvRspjv0q0245e6LjlFMM5MNvSJ3EfhexivjDFtXgsqts0jo9M08/Y23D7xDXmTdKGmLWay5OSe3KDDkqxLDOCkibmmMNd7K9sV8evKKiuYh+E4wKds1JjUYDY+dRSdloy+Jtqs8a1WOFjpNHHk6/reTuOG9q9HwjdXv3S+GmAJBtsjEDBDbIIF3RXgjICaDUVSIS5rGLl4W1/g0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3b4MWhPPVFoiIh25qTAjOR/KiilTVYA59uBuLKu7EM=;
 b=i93UlIwuSsidSzCyo84aoZa5darGoyHkWHuHSg5t9uWkVUp4KrvZJtLPxxMgo2Ll9ethRG1IbAm+udM7hVD+GDafdvkm3djOEi0FQy0xoTsjCCzeYZTy7ZLGfnL7xfNl0wVnzPi27o9D1+Oqa0IiJ+jgJ6w/xgZXoZtjQi/vJm6EzONYtMJliZ3wCBnMNeKcsJDm9p7oY6OecFB1ajo/Jx47n/zddBlLYg1JtH0QF8+uy3jjqZOku/qMH6+tGPWKZkLZ7q/PrtWFNc6WXXDJl8mfiW2PPEqc0EOthWlaZf9nd+KWxlIduPCarf/ly3GQvJBJF9FdStUMEewofDFcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 12:22:16 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7544.041; Fri, 10 May 2024
 12:22:16 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        bartosz.golaszewski@linaro.org, horms@kernel.org,
        rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk,
        fancer.lancer@gmail.com, ahalaney@redhat.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [net PATCH v5 1/2] net: stmmac: move the EST lock to struct stmmac_priv
Date: Fri, 10 May 2024 20:21:54 +0800
Message-Id: <20240510122155.3394723-2-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510122155.3394723-1-xiaolei.wang@windriver.com>
References: <20240510122155.3394723-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::6) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|IA1PR11MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 4237ef41-ca55-4cbd-d29a-08dc70ebd461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|7416005|376005|1800799015|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xcUC2+rLDvof5/lhY4MxoYUOCfIDaYhgCideckki+PoSHryBdO2R4dslEUVD?=
 =?us-ascii?Q?6VglJsMWQMmjBvpFzy2qKCEyM4RW7toWyOyUsTRT2C+AISKEtFwwHUAhhhG8?=
 =?us-ascii?Q?UZi44giW8DWVNPFn6Nsdy/XirfjDuzFfCsPotk6x29j4TnK5fm1zoMptkWsE?=
 =?us-ascii?Q?oG64hR0IS6Q2cGLHyGCFBsBjSiwlNoLRHS4TyUkWRZShLBrjZ2FHefBy2chZ?=
 =?us-ascii?Q?i2bZGVdP+mSc3ilMbto0sU8f84mWaFFfXKyRBo69xEQpBUqpnx43m8iOAse1?=
 =?us-ascii?Q?mYckwGcN2RJ/QRQjc91fcBskVb8MxBN2HmbdJAa+O0ADcJFalFpIi0C/W1XY?=
 =?us-ascii?Q?s7WVEgGQ4yL9HVRodK8xBiZSw2X0hRfmNmR4nSNk4lOprbm6vtMJv2N9YdY8?=
 =?us-ascii?Q?N/5sTmm6bl3ud+r8yQoneSqMstUREdvPyLO6heyjyhMUh2rrb/DMPCWOuut/?=
 =?us-ascii?Q?tLzBlZHMmF8Y1yzZGtPitUVe0Ix4MQRV58xK0Nen0VEvw/x6tcqJgbF0yctq?=
 =?us-ascii?Q?Gf+BAP8sOkA3vMCiHGXwTGcqiU9qAhY1S6tVammuNMb4pl+QaLkFqWuR0kBt?=
 =?us-ascii?Q?BS8lLRonhte9rEyYj21Ch8WLSvcATW5l8Aui37bV2N51hZHAJ8G7wQOkpo6l?=
 =?us-ascii?Q?wS1MdAQ7TkMYvTjZPPxiSy533NL+awJ++pJsNa6KC4qNPkKp1LLg+zg1gUek?=
 =?us-ascii?Q?0Ppb8PI/fKB+wH6v50WnpEDZF/tN4nKnlHS4rZf+yrFIYjHBnD0xaY+7CW34?=
 =?us-ascii?Q?gQlXVXQlS+XJ9P3kH2WGBRbGm7CMeGZAw1xAI0rll263DrY3jZN34OLJK+AR?=
 =?us-ascii?Q?+79lGMHMtwfl1yH+RejRq6ozeGKjh8UTwo5XgEmTgFULsy0G4u2sgrSoaf0U?=
 =?us-ascii?Q?k3lhGDZxvzFd3tROJ2wrj0UL++ERNC+o++poGgW+lHwFPBfljGaj0KEgGV3L?=
 =?us-ascii?Q?BNjmUrURq2fnwPq1PXTpo7YzJyMb1ClPg+KPPVUQvSRctpOydHF/gQzrynBu?=
 =?us-ascii?Q?lD2EmnQVpnGx7WbE0DgK07JAaT90osB23D2BTvgwmaYOaait8ip7A0AsDkQG?=
 =?us-ascii?Q?fi/Zu54KxsGVbAuUU5ZNt8SuDOFAf2IjfcDw03hsWqEoPfWqWO+W7N4wLWh+?=
 =?us-ascii?Q?us3ILJ8U+p653/SFnS+NsXiDYxsU6511Aj6G9T73JjmrJPNytTSHhl6YCdgA?=
 =?us-ascii?Q?xZANZ9eqBq8DNJCTHjfgTIbD2jZZZHdPNQtNjv97qDxtmEpGmwVwVYy3fKTw?=
 =?us-ascii?Q?KxaLEgAL/mKJl21r2DNPEAXxtoONUIRiLQDucSRjz+m55CIzNRpZ83gBYiHS?=
 =?us-ascii?Q?G3MylGtRxTekPBVTPmMpQiKCW6RikCPBi3FkXOBAY6ignBIx+lK8R/8Nuqos?=
 =?us-ascii?Q?PgTYdu0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9G08cW1vZ2OGf+8Wxm2Z74Z60aCBF4KwtB0cO6+tQLX/w9L3iQgg3dA+LwPd?=
 =?us-ascii?Q?0KeXIUNHhg//NT8No5vz7vGeXyt1xqcnqav7einW2w0Jl5kdRA3Ahx4f3P6R?=
 =?us-ascii?Q?N4hh85cvZlnjMsGURZJkFfYvFKTJvNigpE51ag4OaNW+L9uDCDfkqQ699CLl?=
 =?us-ascii?Q?pzpRuEsUWDGlgcTvIkDR8n/pVWbqL4Fmj9L1rcCx3CSkeYHbEB+Il3S5S7jW?=
 =?us-ascii?Q?juNOpxUAlWAW/7gXJHIJBwglgufjarD78wpA9kxh+YD+IYaIB+U2SPxOmu83?=
 =?us-ascii?Q?d5sv85J1e+ZarYraap9Rt+w482P7p8CorZ0t1cNrg01PrUJlVJ4qUODJPubM?=
 =?us-ascii?Q?mV2VAu4HQoP+/bBIrk8w6L6Wb4HnITvGZeGX5JzX6UfYvTUXMXf2CwxTGvFZ?=
 =?us-ascii?Q?Qx7iU/Ze8G6mUSdlQEyj5yPtWa6lfE0hB3QkK6LWeFOoA+4EW8a0FhxCcUPE?=
 =?us-ascii?Q?eZx0rzGUVl7le8cerEnqC1Q/YkTmiU8lCzau7zSdJcblGXIxMoAzos5oX/Y8?=
 =?us-ascii?Q?p1tgMctx8f0hykJKug0FotZtO1Q8hocbLzvZJesWxsLnlVlqUCDG1xMGVBnN?=
 =?us-ascii?Q?GYIobuftPEjwynrnhs70dHPhjrsXMguCuFSkSkEzDz/WbM6gKVIZg8uRHLSu?=
 =?us-ascii?Q?OT6wreD2UDfsYZEyHeCtKnQ5ytHDV+wJTjoKC57rMc5yi9Y2Ybtwn8Fa3HBu?=
 =?us-ascii?Q?AyNxSjX2W0/ladJx+3STSomhH+/fAg6igYC0dckK4lZfIikL6r+ttoovp2bU?=
 =?us-ascii?Q?cQXpfOInHi/kF/uh8gKj6ma57U9jvXHtFhEzx3odJpssgTe8TximFG+qCS4f?=
 =?us-ascii?Q?HOI6Q8uOYa+PPBewDy8n6FbUJaaVhq3GNPSFkgLQBjo79KPxLZM8SsWcGsWm?=
 =?us-ascii?Q?8SpsnFEW+syhpY3OJGoD0jVOb/B1TbAtsNpRs2WA+Bm1oSDr3XKF2hwr2Dbq?=
 =?us-ascii?Q?kH6nIREwvuH6GaUb1nlg20TTkH7LkKh1HrBR7h0qYZYajOzAnaF30YSWdRrX?=
 =?us-ascii?Q?XJBalrYA28pPMM/loK1L6rJ60osatNa9U9lIBZqN43ZD2UpB1mVNEbP5xs4x?=
 =?us-ascii?Q?pZXGtPuCQNEj20OEYt4v3IY/6b1KvVyedl98bDr31s3DQsQt2wu7Ve8ALhYD?=
 =?us-ascii?Q?6UtzwxxMvT/8ZBqyrTV9PE+HugTXkutqLihaD60/xCjB/MW6/gURiPQDIPxT?=
 =?us-ascii?Q?gYwZ8K9oMEI34Icu4PUyc2ldzGUgWJmeTOx/J1FY7GKV8EAd1Q6usDjKWH/X?=
 =?us-ascii?Q?c+LmEoTnmE/9cI3Yh/wadlb3udix3ARZNKg0g/Nz72Gy2LzL9aCI3GPwJ3M3?=
 =?us-ascii?Q?0jUrw3v8o6x2oA96J+2PY1nuu99EAb83EBoSA49k0Cp2r1TfgZHeM0u7x0MD?=
 =?us-ascii?Q?D47ln0/cvlahp3wPJqEWLKjrp8LineDl9rdQOSKizYEj6zX0LBlyTdkXDbUa?=
 =?us-ascii?Q?4Gyq/cI29oBTv7O2cvkwnCjZM9TvJwQdfy/yHkhS4z9b9Bj+sCxPj8dMAKR0?=
 =?us-ascii?Q?MkRh1KRtHrlwelkPomjr19rEB4COBZISe6fAwstHVnflca+vaLPT3sYfJlUx?=
 =?us-ascii?Q?8jeTRJYBkyAKFZFaQZuEVNqxtMrDnp0STlb+K0og6lTPGhGbrUPGjMnvIags?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4237ef41-ca55-4cbd-d29a-08dc70ebd461
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 12:22:16.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bx8wgdxhoN7ttQrTpnT/nE6IGZld9GaVf8Cr9C4mGmU1vuMUNPIrNBHtkPVHQBoZ7KkO3RIeYP4jKw5SGJcBnTJuCezYn3+KtvJZ8+Gi+xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7869
X-Proofpoint-ORIG-GUID: zozIIIdGqf7soqehAPXACFbpzC9HxNnv
X-Proofpoint-GUID: zozIIIdGqf7soqehAPXACFbpzC9HxNnv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_08,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405100088

Reinitialize the whole EST structure would also reset the mutex
lock which is embedded in the EST structure, and then trigger
the following warning. To address this, move the lock to struct
stmmac_priv. We also need to reacquire the mutex lock when doing
this initialization.

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 3 PID: 505 at kernel/locking/mutex.c:587 __mutex_lock+0xd84/0x1068
 Modules linked in:
 CPU: 3 PID: 505 Comm: tc Not tainted 6.9.0-rc6-00053-g0106679839f7-dirty #29
 Hardware name: NXP i.MX8MPlus EVK board (DT)
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __mutex_lock+0xd84/0x1068
 lr : __mutex_lock+0xd84/0x1068
 sp : ffffffc0864e3570
 x29: ffffffc0864e3570 x28: ffffffc0817bdc78 x27: 0000000000000003
 x26: ffffff80c54f1808 x25: ffffff80c9164080 x24: ffffffc080d723ac
 x23: 0000000000000000 x22: 0000000000000002 x21: 0000000000000000
 x20: 0000000000000000 x19: ffffffc083bc3000 x18: ffffffffffffffff
 x17: ffffffc08117b080 x16: 0000000000000002 x15: ffffff80d2d40000
 x14: 00000000000002da x13: ffffff80d2d404b8 x12: ffffffc082b5a5c8
 x11: ffffffc082bca680 x10: ffffffc082bb2640 x9 : ffffffc082bb2698
 x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
 x5 : ffffff8178fe0d48 x4 : 0000000000000000 x3 : 0000000000000027
 x2 : ffffff8178fe0d50 x1 : 0000000000000000 x0 : 0000000000000000
 Call trace:
  __mutex_lock+0xd84/0x1068
  mutex_lock_nested+0x28/0x34
  tc_setup_taprio+0x118/0x68c
  stmmac_setup_tc+0x50/0xf0
  taprio_change+0x868/0xc9c

Fixes: b2aae654a479 ("net: stmmac: add mutex lock to protect est parameters")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  8 ++++----
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c    | 18 ++++++++++--------
 include/linux/stmmac.h                         |  1 -
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index dddcaa9220cc..64b21c83e2b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -261,6 +261,8 @@ struct stmmac_priv {
 	struct stmmac_extra_stats xstats ____cacheline_aligned_in_smp;
 	struct stmmac_safety_stats sstats;
 	struct plat_stmmacenet_data *plat;
+	/* Protect est parameters */
+	struct mutex est_lock;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index e04830a3a1fb..0c5aab6dd7a7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -70,11 +70,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	/* If EST is enabled, disabled it before adjust ptp time. */
 	if (priv->plat->est && priv->plat->est->enable) {
 		est_rst = true;
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->plat->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 	}
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
@@ -87,7 +87,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		ktime_t current_time_ns, basetime;
 		u64 cycle_time;
 
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 		current_time_ns = timespec64_to_ktime(current_time);
 		time.tv_nsec = priv->plat->est->btr_reserve[0];
@@ -104,7 +104,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		priv->plat->est->enable = true;
 		ret = stmmac_est_configure(priv, priv, priv->plat->est,
 					   priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 		if (ret)
 			netdev_err(priv->dev, "failed to configure EST\n");
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index cce00719937d..620c16e9be3a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1004,17 +1004,19 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		if (!plat->est)
 			return -ENOMEM;
 
-		mutex_init(&priv->plat->est->lock);
+		mutex_init(&priv->est_lock);
 	} else {
+		mutex_lock(&priv->est_lock);
 		memset(plat->est, 0, sizeof(*plat->est));
+		mutex_unlock(&priv->est_lock);
 	}
 
 	size = qopt->num_entries;
 
-	mutex_lock(&priv->plat->est->lock);
+	mutex_lock(&priv->est_lock);
 	priv->plat->est->gcl_size = size;
 	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_unlock(&priv->est_lock);
 
 	for (i = 0; i < size; i++) {
 		s64 delta_ns = qopt->entries[i].interval;
@@ -1045,7 +1047,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
 	}
 
-	mutex_lock(&priv->plat->est->lock);
+	mutex_lock(&priv->est_lock);
 	/* Adjust for real system time */
 	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 	current_time_ns = timespec64_to_ktime(current_time);
@@ -1068,7 +1070,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
 	if (fpe && !priv->dma_cap.fpesel) {
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 		return -EOPNOTSUPP;
 	}
 
@@ -1079,7 +1081,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	ret = stmmac_est_configure(priv, priv, priv->plat->est,
 				   priv->plat->clk_ptp_rate);
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_unlock(&priv->est_lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
 		goto disable;
@@ -1096,7 +1098,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 disable:
 	if (priv->plat->est) {
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->plat->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
@@ -1105,7 +1107,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			priv->xstats.max_sdu_txq_drop[i] = 0;
 			priv->xstats.mtl_est_txq_hlbf[i] = 0;
 		}
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 	}
 
 	priv->plat->fpe_cfg->enable = false;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dfa1828cd756..c0d74f97fd18 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -117,7 +117,6 @@ struct stmmac_axi {
 
 #define EST_GCL		1024
 struct stmmac_est {
-	struct mutex lock;
 	int enable;
 	u32 btr_reserve[2];
 	u32 btr_offset[2];
-- 
2.25.1


