Return-Path: <netdev+bounces-55865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2EA80C928
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F09281E5C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926733984E;
	Mon, 11 Dec 2023 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n3ZI8Y8z"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A84AD5
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:12:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3iBuyugaeFe7mNF+nbV+3JePIe+/iykVZIH0b05bL2mWPfIdZ1rOJmPuMV+SgAklDZV8yXGY/LxPAVgQh7EI3CcRDRWSs8uNWWFKmr/EWfJa4AVjitH49dv52+/9+B7DDk4F1sVuDTXP9ikIPacoM4oKrlBq1hlb4jzHxFbCqwToK50r9nRuId1cC0lTHmYxL3of2fQf+YS29/hJPAtoiHillLL8f29nSKeGGV3O19wlLO8Nut5+4hDpr1kTPkdHe/bqwcM6XjCXtgJ16QePZPBLAcLtaEseMg/sf8COBo3wzylHN4Cbsh6mBdopj/eZ/CN4i5qWZsumTZLwekbtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAgx2LAsnlTOhyXeAa5JbleKaAY5/h9PzGD1mSgn0Nw=;
 b=midWu6V3C04FUlN2h26mK3lD8U5hkKdMXAmb2J3tnlv+gbeotTLFrAgARUaVGxa7JxKlG/4dfzacmtac78iZKg+nBvPrrtRM2V/aXsd2mE0EHpX7QYUKtiKbGaFPRMoTjv1FMFxidW/qJvt1nXsFrIgLOHvK2/prUx/YKb93J+HkMBY9HU6ILAoC/dDQEYt3dlzOz5rv/3NSPRt9VGvk62V3+sHWypBzKCZvTVpcXU4rlJfMVVa2u+GpcTyyMuxdgda+o2OMP2IFmMz2s59phx+QRxbNPofuC8vW92sKZ8521XI7vBergqsOQV/9hppXAUw+aCeIz04oda7V/Faz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAgx2LAsnlTOhyXeAa5JbleKaAY5/h9PzGD1mSgn0Nw=;
 b=n3ZI8Y8zrQCfm0pFHDyly6zxowcYxOd1hMBRb3ZvzQNfIgxR3kEF4PePAu4PVKuE7zgBaFsDjO2mLMuGJhXIN+08uWIpvulljP01GJio74JQer82M/HLz+oY+CXRz5qG8SzezE+off75lnCaNKHU45oJM5islIl8xGHYvzP66fE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:12:44 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 12:12:44 +0000
Date: Mon, 11 Dec 2023 14:12:40 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
	vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 net-next 6/8] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231211121240.ooufyapz6rswyrbn@skbuf>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
 <20231204123531.tpjbt7byzdnrhs7f@skbuf>
 <8caf8252-4068-4d17-b919-12adfef074e5@kernel.org>
 <7d8fb848-a491-414b-adb8-d26a16a499a4@kernel.org>
 <c6ca2492-20a9-47b9-a6ea-3feb6f3cb2d8@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ca2492-20a9-47b9-a6ea-3feb6f3cb2d8@kernel.org>
X-ClientProxiedBy: FR5P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::12) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d6b20b-fec3-4e6d-ab08-08dbfa427af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3zt/AIr5dJiddViC7Au/7iQZjKEOVXIQLxjYpcgZz111GSccx5H60h5eHOEVoN1SLVRE6gIj1UOPNvyY3I/NnQfoiXbY7fguOyWp8ogUFNrMbph6x6lEJB7RvKAe1r3vNNcaE6IQAHtlBKb0Y51HKYd/Fd4sMXkkReVUwic12aJdJRhPGscNxAFNN5wjwAW4+ky5sXIcKeVSpAOk56p/JuraxUsTgZ8niRxigzWrYPtau2/sMcWpDZrBnsnLJZQpQeyefj3spgTNVpBH8xNrsN6IgTmDrPWSF0R8rNnnB+PKCFmsLppC12HmUrGdqqaG0zR+zI3r2n1UuaV+SFItM2toU1lB48kcPyMmTYv8BW5JX07SNl+mv7GgrfFEAUWJ2lbbsTDwsI50CHRflomST0i0ysvEWzjRp3NovwrbpXhb0VKcmr2o8uHWFjmGdjaGvQ0vA70hSjq5nRW80wFtqO8kZ8zeJNirNhmF0hVHYd8ip4lkATyZ/qlyEI7MIX0gMuvKklkE/UZotFqzqa09H8AxfMa/6IKrD/7fiL/1dYoyYQ3GUZOcdeZFN8a/aebV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(1076003)(26005)(38100700002)(86362001)(83380400001)(7416002)(5660300002)(9686003)(6512007)(6666004)(6506007)(8936002)(8676002)(66556008)(66946007)(6486002)(4326008)(316002)(66476007)(44832011)(6916009)(2906002)(41300700001)(33716001)(4744005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?29vw9GX78ayxHVV6Ahd0ABVpDeRJKw14U/ta9xj82ls6+58mZjfpOgLh4qyw?=
 =?us-ascii?Q?e8M4kaQhdQDghkrAbSSItFj7k1qE8/fCBZJEqXE5BAgeeVbjrlEMUa/hYmqS?=
 =?us-ascii?Q?1+hetTPzUgaCwEfTVMHJzoqqMJH5TC0L8ETghe0YTRsKsBuu2JEgMeBCwFwb?=
 =?us-ascii?Q?A4zkm18PBM3FBaQw+/ophIMZXPiv1PdIJNHZ4Jai1ydA9f220rJ8gVCvQ1Di?=
 =?us-ascii?Q?HbpEHiqJ5ODAZo4e1LtNSp0Ve99wKSRiLxrFzbgyo0gqxWx0qXCyzpTM0179?=
 =?us-ascii?Q?LBzeAevNPBgXBd2h7MZ/xc362t9Gi0+W8Wc3YFkDEh+qmZ9YPlhZ4YPfO5TL?=
 =?us-ascii?Q?AqU+dQCr1qdLLTN9mtDfkM7WWXyov5DjL6wYrpLUstoAP5tJ/qgatp4nRfyV?=
 =?us-ascii?Q?VlTCmpezW+w+VD4wY9EJmjKowT+YXywdrHRJx9/7uWNv3XbVxZdRGBLBJqxU?=
 =?us-ascii?Q?YKV1rVZaGzfqSsEGwikr/RaFFnYuiF1VOCkNmvQID1nafGvBHKJb0Hh2sJ7U?=
 =?us-ascii?Q?M4JcwpZQss5bZJ78jv+dRyROnqV9meOGvFHa27mg6ySazJ2mQjSC8YuuO2vs?=
 =?us-ascii?Q?JiepuIeQu6vt7JOqBYGHQMCnaQQ68in2IC4OoPBas/ThUrtUP1Z07pLmLURm?=
 =?us-ascii?Q?rQvbwY3W+mO9X8SBIDv9TD5dd9G2M38JyYJsrCGkmLxukokgZVWqKkB45t8R?=
 =?us-ascii?Q?errIkwXz7DU1lxam0vX4OuFwAvxzZLSYRznroDvEEttta3LU7TAoIy7CgLBI?=
 =?us-ascii?Q?RgHc184lG1mIEPee2FZOCah5/az4hPurD1uVKL0m7bj6NGLTbXy7X/HfNeOw?=
 =?us-ascii?Q?IXUgvZlQBUFsmHJL0NJQ/qBUkWThPRL/qLSqm2Eok8Un+wpQNt6tm+h/afUT?=
 =?us-ascii?Q?rhXZ7M86m6xjNswrav9Hdxsaejn/7KqzMY5lJ+Nx1ItRK1MF+kh0JqVfYNLW?=
 =?us-ascii?Q?I1O+IbgcgkASTvfh4srXaNvhhJncqKMUhoemNEkgQR9y+htTvhVMLA35SGrT?=
 =?us-ascii?Q?/agQBNn+iduv6PDuogtr5Rhpu9RYKK4cx51Oi4r48gtT3EzWS1BM9z2W2V5O?=
 =?us-ascii?Q?6iYlwBNzo3TTDqB9ApKECBNu1B/KOJVGooVO+R46xtCB8O/DNOrKto/tEeby?=
 =?us-ascii?Q?R/96K8UFoDKSVFBiHXQAPUGTP7AwAx+/guSxNyelRg75tyrRlQ6kc+7Es2Ca?=
 =?us-ascii?Q?9KBxAusX3ae6kovuukqKQaUZOMJ1kv0foMwaM5I+CV/S98vhm+yuffXTpZsA?=
 =?us-ascii?Q?AcZZ6k6Fkmas5Yi2qGS5HbldyjrGEAE74Hvq4dECmkvA27uPm24XLa56w+q2?=
 =?us-ascii?Q?8n3rJkZb3Fqydw+RAGc9z0AH/hTzz703JmK41fyfobRw4dwPp1MkeZpGLjRl?=
 =?us-ascii?Q?o4V+oDE0pyUhu/ynxtdXTgkFN5BQ/64HE8iPbZhfRNC4vmXiqhNT7zU6R0l5?=
 =?us-ascii?Q?hkH7Eo98DphRoKJ4s8S7oZ05BZYFcNKLcUlEz4NxR6Q+hCyfLaWhzCK2UoRK?=
 =?us-ascii?Q?Wb2KnsNr+k6RH8Mz5XDhKgVw5v/9a6Vi41MmtyvHVlTGsZP2kZAqJ+8+9Z6l?=
 =?us-ascii?Q?Eg0UYmeomaMdk35qax0YmrTZYMsWS63qfj6JQxW71itp89hVzMgEIGYAcTE1?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d6b20b-fec3-4e6d-ab08-08dbfa427af0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:12:44.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AucRTB5il2Uhe2vyhPSy21fT0/uNnzUj6dztq2PVwXVt4RHexZ/HOhtkRJB4NKMQH91DNjLmNlvBUtWVru7VoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592

On Fri, Dec 08, 2023 at 02:33:00PM +0200, Roger Quadros wrote:
> But,
> 
> bool __ethtool_dev_mm_supported(struct net_device *dev)
> {
> 	const struct ethtool_ops *ops = dev->ethtool_ops;
> 	struct ethtool_mm_state state = {};
> 	int ret = -EOPNOTSUPP;
> 
> 	if (ops && ops->get_mm)
> 		ret = ops->get_mm(dev, &state);
> 
> 	return !ret;
> }
> 
> So looks like it is better to not define get_mm/set_mm if CONFIG_TI_AM65_CPSW_TAS is disabled.

Why not? __ethtool_dev_mm_supported() returns true if os->get_mm() is
implemented and returns 0. You return -EOPNOTSUPP, and that's different
from 0.

