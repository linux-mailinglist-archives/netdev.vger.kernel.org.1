Return-Path: <netdev+bounces-95835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C36C8C39EA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 03:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8651C20E41
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 01:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA25F9EB;
	Mon, 13 May 2024 01:45:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46D12E55;
	Mon, 13 May 2024 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715564704; cv=fail; b=oR2E9qs1ky1dzzEGkyUZ5LKAodSE0Htt92kUFiP+QvYW3gQNPgQ42Mz8pBBH+Z1a0D3iKeV/SHcWyLf+ssNF/rrbZu0UnOEgwqv42IMQ23ReycgijLKyc/vZVonmILuL7QPMSD0jlZOVg/2RuYsFQ+ug5338al8D1sUy+558ftA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715564704; c=relaxed/simple;
	bh=PAg/X4b61UlQHD8MyY3IxfUkO68tvS5iWLqwbk1/AxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bINU5/0MeUgh2gkVMt3858ejj96UqgWR0JVDhpptiAdySXYWW5sx3Vt2TVOEB37H7GB1s+T/ND5JetesQJt1SEc52VRugEffkSb6aCl8PfcPW/j5T1UCNRo9hRDf2dxWBYc829Y0HGMbccbi9u9pycrl13SqW9/2sn7q+FEBJpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D1I3p7007561;
	Sun, 12 May 2024 18:44:13 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y286frxrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 18:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cvt3G2CJKpFJ3Qs6IqYkHIU7Mu4AgrVPCfLQ23tQ/HG2+1hzDAd7C/Pamkn1lJqZvnGzMCK97Xt6wyYU0mFsaDKQcgZt200igGZvenyw8Xbpo2wYqWmc6Ct2fOPma8mgG6rMAB/gnc5d2jexZxz1/bDK2YUoZ39nPLBrz/WOW2wJGscAh/e6r7B0enoPv4Sp28RAcy/J5Gr3dBZJT2R5SQ4DtvraKUDi7qKP1kFfIHz64MykDB/2UPrAcYPF8fqiXlBJzy2dA57Bwdi0aShOHBSUJ9I5tIu5dLyMLthtr7jGYnsKvXCurGOl5kx0V2pA0LOmkBWs+vbC7g0nTpMyUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKQjpWelJfiyRl3khevQ47FUgq+6Y/NrA0zNeMMSYhk=;
 b=kC973UlUkRAg7X9c4GK9pFknoqSLOHxOIcplH56IhNKe/5JnGF3omNQDdwLUt0uIP6ZeVROCaQTXA3xv7ACYsTbHwNx8kNwqKV+r2N1LJu/o5dblkzZFKPTTXAg6U0j0KHOTJbbNi+yqX/tdsxA+vDJuMN4LlB+SwFzNzlu8hLsi3wLKdHTydPLDYTjDpzv9Uc0RSIwxFHL4O4sagaiYuWGnTbn6i92qeXWuo24FTClf6aznuGsU/+xfSVFY1c2DcA6snRJfrChetIWhzpxDHEVxQLXN8B4bzctfb766X5K+bjlRIbfb+nJS4LpybJOMNdBzglKkeuTbWdX/wCzrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8)
 by PH7PR11MB7477.namprd11.prod.outlook.com (2603:10b6:510:279::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 01:44:11 +0000
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::4ebe:8375:ccb:b4ad]) by SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::4ebe:8375:ccb:b4ad%5]) with mapi id 15.20.7544.046; Mon, 13 May 2024
 01:44:11 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        bartosz.golaszewski@linaro.org, horms@kernel.org,
        rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk,
        fancer.lancer@gmail.com, ahalaney@redhat.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [net PATCH v6 1/2] net: stmmac: move the EST lock to struct stmmac_priv
Date: Mon, 13 May 2024 09:43:45 +0800
Message-Id: <20240513014346.1718740-2-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513014346.1718740-1-xiaolei.wang@windriver.com>
References: <20240513014346.1718740-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0189.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::15) To SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5769:EE_|PH7PR11MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4e0987-283c-46c8-0523-08dc72ee2fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|376005|366007|7416005|1800799015|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Jt9gx061/Lv9QmoFats90pQZdqzzOmMssh0MK2GKX3ulnxYECX3+e2d1juKT?=
 =?us-ascii?Q?av8dW2Q9j1L+4/kXofyAp6B6YkS1cOcb3kEWFx0obeGK80b5PWFS3Y1MfPPc?=
 =?us-ascii?Q?QomEB6McHPEx9FtKwb6OFCCEFNCUxShM1HcY224+nrcz+3cONG8xYr/fOGdU?=
 =?us-ascii?Q?9Vl55/ikrMQHYEkdi0rcpOCGKfvJR1MHZe8SSTFpEx9PwJvVzmnqqIK381fI?=
 =?us-ascii?Q?x2XrWq2B963+jlTha/Vz2BWRW5RAnQdcGKiz4xcpLbstrE2JvbAFaHOuNJ2X?=
 =?us-ascii?Q?goAR9COv7fvsDEM2vSZCVNjSj+R9Y/F/poKRFJy4CVw5NiQrFJR6M443zfxL?=
 =?us-ascii?Q?peupM6zrWGNpIOvxsdBhjE+vYd1wLYJFkGDwca51BWKwKtx0F0qgIGiZ3WII?=
 =?us-ascii?Q?0YBG9KEVumNI2cxjN3PgkxUvRm3sUw5NtDR6XO/9YE/X7DhdUsxhExMB5AWQ?=
 =?us-ascii?Q?QKpywrWw0J6WwihbnjYY6dJ30TEBrsOpcecE4kpR8ZwhOnmbx2NevW2qadrB?=
 =?us-ascii?Q?vS4QqErP3d1eeFN3mmDbzmFoG4JBiRCuEvnIU2wgbxjmk0eKu7ZJknSO0qR0?=
 =?us-ascii?Q?goOuK8IygpwFRxub1a+SpLU4yDGV1afreeSSQroUh5V5HNiPPAPCQzPOCwEY?=
 =?us-ascii?Q?daj2dMrnMR66JKmE+VwcBDI5dEX2P/zinYR3+PBeEZPojYIfv63LIs/zqK/a?=
 =?us-ascii?Q?2dRXj40LvpJwvfnBr9934TDE/J/WvKXtXSRrf2yn232/YEzIx57j7iQdyTyL?=
 =?us-ascii?Q?W6hvmFlHdHW/tGvPd58XKCACTtndwNfZ1v9Q2+16DO6wRu4oL+CCLtgKSCeX?=
 =?us-ascii?Q?fHynzh5t8VZ6h4VyFGXbrX7iwi2um19cIe3CHq33roCCemr9cshyXPU3JHmu?=
 =?us-ascii?Q?7RHbaFhogx/I3yLfiIRF7PwUyMeVV0B+r3+yk/pReQ+y1NkxGI82dU6Cr1cj?=
 =?us-ascii?Q?z6QzocM7CWtneld8IBLLx2k+X1guHllypAqslDXsqMm/q5f+3x0peFa5l/RQ?=
 =?us-ascii?Q?7UHOy07aGn7cjX5zGBBM5pGDpKrOmmbvIfTFbCMQt9yiy9L42A40mvknbOPu?=
 =?us-ascii?Q?4JlCoi4tLdQs8S+bpqTSwCoNM3aaACtvn5yONatCDEqnGf9cq9uwOqiukJry?=
 =?us-ascii?Q?1n8v9t2EjGST6AFeADzCOoSGl6GK9oE8FoNhw0iVpfaX726kvGByAVvEPwGw?=
 =?us-ascii?Q?ZUAXqy6Der/0Ak59SEzp8jZolpJGjdWFP3mJIk3ty6kKOe8ITFLRzAmTfj98?=
 =?us-ascii?Q?ZjTjpHxsJ5whUqiurzvRx6g5Zo0KrcFzHRXbMFFdHyoMpQ9Rfu/sdttmCcKg?=
 =?us-ascii?Q?xUnK7SpqYnpzbTsSyF8Gd7z+PF6UZ2sDdT+mcMxU7DjY55jTfzpPm1wLUoTy?=
 =?us-ascii?Q?ofoVqVM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wL+H2GVDqwK5pBnlhD8Z6xbIR6F2W6Eo3ZkcnnOkSgTo8345/MO3s7AK+DCX?=
 =?us-ascii?Q?DutTB1xrJ4ZqK56HcpZHT3P3pAaMLC0JL6qb412kKc97sH3wfEeSz46lM7sg?=
 =?us-ascii?Q?3pVOswfXtrgFL5w74R54oCBRtxU7kmVGZ4cD1OEYs7Me6nuVN3zAW78QRKca?=
 =?us-ascii?Q?DLqQ5c5WUvbKH1gqzCYa5sLwZ64NB8wJQYwgadPSpWyDbNpwvog3mmJuudP/?=
 =?us-ascii?Q?ZnH3q7Abw5DopyI8PuFLZesjmey0ieDqDi8Gs2dCKCdcVMT9KdqVNfWsoL2W?=
 =?us-ascii?Q?iMwv1iG6UKY9rMiL77HG9ZL/NuuqmKD6/8O0Mz2E5FmPqM+ipUZp7X9p1rD6?=
 =?us-ascii?Q?stfhKKH8vHlM7gHCXFnSJVYNNUbsVaCVxHZrN/d1BNsKvouHXC6sW/RgDbnu?=
 =?us-ascii?Q?Y8worg81eOio1tgFscq+DUwzriuZp3MUX+OdHS7XAw4CAK6X9nnfOWb35Afx?=
 =?us-ascii?Q?KzHTwcllK8o0I7Z6fQV2P31dGqh+h8mER7Z1godV6DJKX+k3yd2j3FHDsgyF?=
 =?us-ascii?Q?PxqLCLDyjLTiZOf+4tvER3y69sOsom7P5Q6rKJA+hQhFTDGHY5Xbke8KWj/m?=
 =?us-ascii?Q?GRzhoWw4lzAUPmcdhKBUATDcLtn6q85brSdojvQbnjK3i5MO91Vvgs4ILLrl?=
 =?us-ascii?Q?FX/XF+jOyApK0XBw8klql1bo0EBr/F3SnvSe9HUxkUrwnAAhSynVROV5pj7f?=
 =?us-ascii?Q?ldhJDxQrTwVNNsb2QmQoW43LEkRJDjLrC65gkOoxonsvzEVou2JTYhC7eR/o?=
 =?us-ascii?Q?snWHolRbqQ1K+m5vMRH6Xej3xT4ApO2VPx8wWp0x5ISeFke9KbGJBKxh4hgL?=
 =?us-ascii?Q?6KSHiqiQubLAompnXwOpCj93ScbG0m5MsbV659/mKDbAHB/bJ1nL9+hTdmKT?=
 =?us-ascii?Q?SVY3XRgUuLHa0UaBdotsZRJQ8gn5DRCGaetwqAvvVRR0G0p+59UNC6341SPz?=
 =?us-ascii?Q?biBMIh/sBKoG3z7Wj9oy20CxtLVYmG6kxFV1JkH/5jRDtd/tMUQZiDgcv8Ph?=
 =?us-ascii?Q?2zsPPN3av9cXTTSe/Wv+g5PSOQ8rhXDkVgiCuxZbvUzz94RnNWJPXFh2bsS4?=
 =?us-ascii?Q?Dpd7hUTwBIL306Kg2M5wh6HXScxGLhNC+S0PtL0J+We3JbogFPJmHI4dai0i?=
 =?us-ascii?Q?P2vLWcBuXHHBaSAIxWT097JivtNMX5pOpZu5srlJEKaIpSUfNpQ47hg7eBeE?=
 =?us-ascii?Q?uBw/czNyz2/bs7+AcRnenD82DD1gq0SmPdWoYv4y0dqB2biOngnLs8dQfnZD?=
 =?us-ascii?Q?F4L1SAp9z1rrc3jaNVMJVJ9TGk/Yz/JUzV0iLOvtkh6ti9w942XoQdECNo5A?=
 =?us-ascii?Q?oQYjDzAQzea8XxN05YXYJO/nDA1kSM8d03INCsoWdunjFng8KTTSSQvfoCFK?=
 =?us-ascii?Q?ZTuiJogJmpUjCvPdFyHSIpbrnt6CYCY3wot0lYrgnUnqrnxQN0J5uVhVR/5i?=
 =?us-ascii?Q?M1fM/VpVKmGRxO8EcyQ347/dDU5ISy8Xm3DbwqfOtmJ9IdLMwMobBK0Nu1ti?=
 =?us-ascii?Q?OsQwwedDpA/Z74x3Q/Gkx1VNixKN2s1/W2AR3q3aFpXFwpgPEqp8RMyw6Bwf?=
 =?us-ascii?Q?d1yoXyNzo2pIY37bL9f1XTr9+oQC+K0Sw0ayFQw4XXTNpJfsKb3zKGz+pHsz?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4e0987-283c-46c8-0523-08dc72ee2fc7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 01:44:11.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZrHk6eT3Ba8pMiq+OSNvqRLLL7LiX5UyRAGZ25qBj3jJvaLYBtJmm17RV4IE+u8XuK+q69ETHlfKvbF+TKcNKD8RD44ngmI2WT4C5m1oTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7477
X-Proofpoint-ORIG-GUID: Xd0s_4vy8BRFGN5w6SR-pJBShbYBQdfI
X-Proofpoint-GUID: Xd0s_4vy8BRFGN5w6SR-pJBShbYBQdfI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_15,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405130010

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
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
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


