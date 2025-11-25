Return-Path: <netdev+bounces-241607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AACC86C33
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 442C4353712
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654343328EA;
	Tue, 25 Nov 2025 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="0YIAgp0p";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="gcVjMTVO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C252868BD;
	Tue, 25 Nov 2025 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098328; cv=fail; b=nZ+ahgyaCp9u8e9zDimDMmUVTwBf9xxhj2+OBWpgZkL5mPX7QKhA2nan06TfigzsOR60O/t1Y0sjjaZMOymbbDqcRVYMQT/+rTJu3R0gIslYoB1tNC+olMYygEoLwEV+s6z434kpvvbwKGCWjRX6DVQZHx5HZSSu2Z2Kyp/Tqf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098328; c=relaxed/simple;
	bh=KF43coBV+kFp0JeAPLpu3vH438DR6h1SYrLQCQqPS0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7hgODbyXqAco2r7DKlfX3jCXGdelZZYgu0fDs3IXJJ2y6QJCflAEFAKoSsJLo6Vbno9o6Ugfl8055zatAYoBawowmR2PQYtFuQ0innhSKWnhbxVWvz9QJm54789y0a2wUcdlYprbYe34KBMTIfkaGyZpHyyCpcUeXMdPZywXQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=0YIAgp0p; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=gcVjMTVO; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APGKZKD2183761;
	Tue, 25 Nov 2025 11:18:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=NwMUXK86QwFWTQM3B1pRJ7FbWh2g6/vBSa14PwW3h
	8o=; b=0YIAgp0pm3l1JvyjkdoUBSGTpPBPy6sEMGBA+JarV3EZOmot2MYz0WdLy
	nTfsagphujqrrilP9vqhiBgSOM8JA9qDaxswxnHtLZEWIvERG+v905nWYJ3MlvYb
	v0/hn6P7V1StBulW4h2bQvWQPrZUxYDDmLS4X4Ti5fpXSYXEU4I96oVQ3XfuM36N
	BcRgZyRr1W6JG5Gwt04Pgij6DzJIEvhiSD9e9BVKsVVPD36nn4v7TcdcdCH6HzAs
	IOEM4oZLnW327BljFqAvVL1XeSQQNR9ULhWU3fZdoERu3i3swMycv0ymUcHgMMAS
	thf9gvb2Odd+IdgL5ceyniK/kZRHg==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022075.outbound.protection.outlook.com [40.107.200.75])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4anfw40cv3-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:18:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGpBcDbkTeDfknMDPvPf9fKyn65YYOGewOpvlpx46Y9/EvKFnjJu35Hhxxwam5ywibN6y1t1b5uj1vepFAMQeIyfCdqzofnsNlWWACCqmER9a/bS09nQ9m10ZSs0O02iOAAkYc6xsIvROYdHwNbOQc5MB1JAIu5CPgCUzTgYdoLvNxbleGpzeECy8E3Ne6wyr9quihIgA3sCoFKZp2r26vrR3Tn6wiDFiCrt7AjrWOiuLObjsbnex9LL04+jZqG+k5z997C1YHCUVaFmaatpcz727IukBgsIcNqXyRWw/o19bIg/b/aB523DfS1mbIvXtKgaAeQfD+yUNsdRUKRaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwMUXK86QwFWTQM3B1pRJ7FbWh2g6/vBSa14PwW3h8o=;
 b=Iz1rUiVVwg/mAOVeJIBrwS6KAwJZLtjEPF5Otpf5KVR9gjXwdI/r6+Cel8brH+nflH0xmmbd496HxG4Gqp/6JExf67fIgBRvv4veHh6eVesp6RLQEZCfJKxyG0zqfu0uWHzmwUUwB4M+kfA0DcPiA2OAxGZTPhDzmoESaPnjtk2Y+WW9qDIhILKyJiYhvADlAoS0EOq+GtS+0boJwM7IxQAf6NPASDQPV9qQ6JCkW87Q4mhWEPyWle9mbTnZdQqVQQyi5+wtCtbaxkkwiMLDcuZrV8jAGXLmDRVKeya6gTpur5IssIXFxwluG2tibSO71LzGpEe3CjAFd9S9JDl9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwMUXK86QwFWTQM3B1pRJ7FbWh2g6/vBSa14PwW3h8o=;
 b=gcVjMTVOk/pGvIjHJa7ozLCyTlJTglcgqI/gbwV7YTAHA8KSkTWrckr9kJKW/us20xvhj+8JA/sqVVGw1ISwRU2XK6ez+5a6g5bgHNdVcTUauK/SpgCKjJw4sSQcBkU1R/D8iRjIeQ1Z3j73TGDmXnPZCQRqMUni0nYqdvg7536Y/46MK8G8FMAbPyc5+KFKYlsJjzllKNwdUZrL6oel6zfl75yl7eT32Parq51RTnEWMSCyUddDzY9jsqVlxm3j0ipYOu5oQBKKPu4aGWMUhXNn2+RwO9uy0oR/N4Uts2gY9XA29IIJ5IZvs9Xf/f2R4V1Qp+G/1tCxQ+LOVXQWCQ==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by PH0PR02MB7557.namprd02.prod.outlook.com
 (2603:10b6:510:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 19:18:34 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:18:34 +0000
From: Jon Kohler <jon@nutanix.com>
To: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Cc: Jon Kohler <jon@nutanix.com>, Nick Hudson <nhudson@akamai.com>
Subject: [PATCH net-next v2 7/9] tun: use napi_consume_skb() in tun_put_user
Date: Tue, 25 Nov 2025 13:00:34 -0700
Message-ID: <20251125200041.1565663-8-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125200041.1565663-1-jon@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0128.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::15) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 701ee1ed-2551-4852-0b5e-08de2c576d7d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l7U37a6+98w9piV27GCC4QXFHXj4wA7jrb0Erkv+XzEGgyqSSFeNifVudL/X?=
 =?us-ascii?Q?g5lLGH7NnON4chdmlgaSrV4fNJ2Z/3VTJcZCvJjxMDTmhcTCDCIrQQatbJLp?=
 =?us-ascii?Q?jHjwkJ1WLPyjwqI2LukOBKBlSApLO+N+0SOnE+5teuyp4wU8oZ0YsNv1Fyyl?=
 =?us-ascii?Q?YxwJkFJ6HGSS2iXWwSQM656J7Do5Cad1HAp31UFbmY+xt0rbAW47mabHvRgU?=
 =?us-ascii?Q?W7cRG6muS2ZTFeFhQ4x9PdW7HGv0tfU1ilypdWyIbposCK3edKCFF7mXb8yo?=
 =?us-ascii?Q?SYmLtjkZRm+dm7bqKL7+8TGEmnJEZt4mKCuOEgSw5OiGiKmDmPeeq8/K/R9t?=
 =?us-ascii?Q?jy2x+Fdi6Rfr2zJ2Y4G3BtvzvGl2EZT+zF6T5qR1dQ1ohpTfyVALHfAUrgQ9?=
 =?us-ascii?Q?+THsG7GyN+E+Hubu2r2SWV97s8os0KUzH1T1XSJZVYF0a+y2x7jjET9hahqY?=
 =?us-ascii?Q?dHgMfTQAMEAgXIkpbbiVRZpon5G57EnFtlsJIh2P31Myr6wkeR4IfpOtWbxa?=
 =?us-ascii?Q?HTrnmThHxlCObZow5yhzRjRbHkCZV1gTe8FlBtnXE9WqwyKcMwtL68cGGfqV?=
 =?us-ascii?Q?KLTge1WU2kqD4vTKKzGUEKrFIGlPD7VZF4sPzSvTTlVV4rwO0jpCuc6otbBV?=
 =?us-ascii?Q?mcphAujTLQkh25va2zwvLiH+c4XbpQ8xR2dwBYEX+1N70WO09dfzkcmwCT9H?=
 =?us-ascii?Q?XG57xLkaVgBv+gKLzMSOijJdMAM98tTwiNx0H4yI8Pli+rD3W9fYNDIEkokQ?=
 =?us-ascii?Q?8Vbnjdh4u526fHl+swiSd98I6Dur0ix8Os5YoANel16o+2PbMqdEQQQkjQTb?=
 =?us-ascii?Q?mOlS5rdaguS7A8KJtB+IcvPEGstxi3oQRArDqK9rCM9C7yYg/qbSD8ojuaQZ?=
 =?us-ascii?Q?0/myXrrKCEv0SETKWspA/HKWPK0jk3nJexJGlHsL/qPaQDhrqQkG7wSVJJdQ?=
 =?us-ascii?Q?lOpmyz974zxLW4AP/D+NWRyrVvWu7V5GW/2nQ2fNpsyUlY762r4knvc+0UeY?=
 =?us-ascii?Q?igwG62hIYY/MTDnnbuKlJyPHvu2xvfQmZ1rS0livsAIx8mp09kPGRjaDRG2t?=
 =?us-ascii?Q?xD8/NOnwohV2y/61lp+WUr9H54R0abBQ64i2mSID6mjCDAOah/cbPya7XnGa?=
 =?us-ascii?Q?1+TI/tX2a/SSCpZh0zzbumbjQCOZvxOku6BYWWGwWVNYNF/j1+jqPApqyAU0?=
 =?us-ascii?Q?H+m9jkvYcYoBfO6MuIHGv/un0iT6pzViuVcfahZyjsMkBRwLnG9j6IjUqUMi?=
 =?us-ascii?Q?f8vaczd9qD1ElhIzL4vfvkbc6f1aboPWZ0t+U+APKnPC4HW4ec5ThE/wyv36?=
 =?us-ascii?Q?IbNbeR8zOeMUzlyH8AQACF9KfrLq4jkhtZJtPZyO5Bsmq2XaEQ2iYHIjJhoR?=
 =?us-ascii?Q?8JIs2FIqRlV+KRlkubK2a/Uz/HRKXh8yfc432FaSJ1WUrbfsr108XI+ktscf?=
 =?us-ascii?Q?rvRxRpfjIOaaAY4aA4627EpfQEjaEuFgQuANcQQ60pYZeIwGTbty/4/iSN3/?=
 =?us-ascii?Q?F2VyKSJQANDyWm9s1B/47LNKlZVtm/Xns4MG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SHXnngBDAUIIiZ493MvdNPlOZzq6wI+jVMjJx2I6TN0d3KPVHVxJWS+Bsu3f?=
 =?us-ascii?Q?b5LrKUb+rcCG3095xOnFK+VhlD1/gH4nY7Dm7l3CrIQCtalHZmaREx6Uycmx?=
 =?us-ascii?Q?sBRDp/kguS6xmxPyTRg5yRwrW1XOvIQT5l+CEXuBIUqFaFW7r9e1NqJhJAyQ?=
 =?us-ascii?Q?pc4oQHeuonMiyrDHj11SQUeb6kszXo9DacbE8xNpbYeG5PIB1wDyRzqTsutL?=
 =?us-ascii?Q?2EtTdDY7icTJXnHrSbR5utSLLo/YIRomQ6ygGrLdro3fn6vo0iagJBhhYgsw?=
 =?us-ascii?Q?VdNYZTfxMzGewJed+IWfxu5WpKdQBov5IOQ4UUpOfsmU3nhZdpGacKibryee?=
 =?us-ascii?Q?zfFjfopyJncxnbMIVm0EezEzf2RU5aATA1M+YET2IjQGBCVDtDKwwix1M+Az?=
 =?us-ascii?Q?6V/6uVPDFmBYrw1LWpSM0oM4CPKIP4JB2S4GIIrQcZgNf0SCHZFtL5zdgwHN?=
 =?us-ascii?Q?5aVR2NNlaGoZXdE6Q9w84NIeiJ4a7CtoIZS1QVYW7aFTvz1koD0tGxwYHezZ?=
 =?us-ascii?Q?Gj9BdTPYz1ti2tuLqTgtcGHZ4ddDq1XYCGm19j7wm0HoAPFVG/jGgS/7JvKO?=
 =?us-ascii?Q?yyCbW6NulCRzxWJW5QSD/YX1Zxke6c8atWXhpUbHO/nYlas4r3hn7ZEekkwM?=
 =?us-ascii?Q?jjEmD73E77C4vvkBNr/762RiLYl7WSvcP4yllP9ZsC9VOPQdr9eAsSgJbUkV?=
 =?us-ascii?Q?ma0cHXCbIYNRvt2mwVfZXHKFLbmCkQhlSYCqr9aizyiZYX0H93yWzD5U/mOO?=
 =?us-ascii?Q?TODtibbBE7nGoVVli3baWNS93Iu4Z/chwJrrdMiBkYZDlFgSmBNST0kQCwAx?=
 =?us-ascii?Q?XZqit+35mlYxROrSOd+lWgDqBPNl24JtgZfkKiOLQeDiWi4Bpa8/ZTu2AJFD?=
 =?us-ascii?Q?5gaLpaa+LMFCXtetbrhcviveBYxl32vqKOQhyTtuDhgnqHuG2KGDHfB3i3aW?=
 =?us-ascii?Q?jxN0WCsBSQq2JyMGrfJA/APkQuIzCsXNgCSOW4N+etAECnya86WOHT2/dURl?=
 =?us-ascii?Q?aiifnIYLydGIxT5Csc0C8oQbdpxZ95tLm7qk7krbiH4svlk7ZiuRoEg30EJH?=
 =?us-ascii?Q?p2KmqBEkCpsDs9/HvN+Tyv4PJZh6ntY7GaoaccUaxStpd2JC3fCu/0lnSs9D?=
 =?us-ascii?Q?LdUVWCUZhkzvSOn1myAVufk4OqoxmYDBaLWv1cEKcInB7bCaDka+2ZUckeCA?=
 =?us-ascii?Q?Z+Jo32XVxis8qhbOzuQ42xt+UXa1ABXqXPTZziKt1VzqGGXJzk8H90tlZ+kW?=
 =?us-ascii?Q?462zSWvEf1KtTJuXu2qXGRcoBGhGWj2Rsq8D8QMjKBcZpcFx4T7K56O1qa/5?=
 =?us-ascii?Q?+OxbWEyBStT6mHIThtSnoKJpTR6IZewD4xQLYxUNwyIIJQ9WDLRpRfuNdMC1?=
 =?us-ascii?Q?GQZb2GY3o5XX2SyGfs+nhtuyCTiHqzInDgwppWREwBxpOkuB3jVCYmQhi58v?=
 =?us-ascii?Q?i5N7E3BSU9CdtTZ55qeZuxRzT7gOxFQBrVXZ4sbzVDD7IZy3l9PVYz1+MhrC?=
 =?us-ascii?Q?y8wzluOuJuH9dafA/8OvBpdXdUeZ0Tt5IVC+RcPRF6Jf7Ktg14G6C7BzC9S+?=
 =?us-ascii?Q?9afYpRy/8gQq1JnadwZoQbX7xglV3xwkkPDVtHn86TcFaX5nKpnynzsqOZxP?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701ee1ed-2551-4852-0b5e-08de2c576d7d
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:18:34.5405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiAbxl0MfqcDJ3SfaC0JyKZo9D3flDGiMf5add04X6CWNuP7eFSBtykoIs9PLoUYhbWLw/f8HvtzNogOSIAUXdD4i+uzg+xRBerPEY+oxwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-GUID: fKN-chR5Ou8XSrSlDF5mfKcdkW6sTWru
X-Authority-Analysis: v=2.4 cv=NfzrFmD4 c=1 sm=1 tr=0 ts=6926010b cx=c_pps
 a=5czeKszRpWsvzRcawb/TzA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1XWaLZrsAAAA:8 a=X7Ea-ya5AAAA:8 a=64Cc0HZtAAAA:8
 a=7i-fQD_1egICQMaxoKgA:9
X-Proofpoint-ORIG-GUID: fKN-chR5Ou8XSrSlDF5mfKcdkW6sTWru
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2MSBTYWx0ZWRfX28PPpa8Up5XZ
 xnMylx5+3VVog9rQfa8dvZHS3EuPVWKFOhnL7KAAbVgX4s+uzoN8cHw1d4aTp3tZ9hT71uOeuuW
 fBrxQ8tV4p+lvGbuKO5szz3GmGAlige5yKJqPwPCWHeNaEyHxUo/B64ws9cnK9OPElrtMwvNkA7
 c0//SP5z54C0GxUJXBDuiKbpGk7hvd9At9TCm/OzrjPsFYgPDoVGn4yStG00i33tPTPdqv0uNrD
 X+ko94DXreAeXf+freFjV4rKCUuAdgRq8NLRg+9pGAV2lXpchPu/Sh6cwYYD3JBRZ0dI1PsJSW8
 iNp5RCcSHm6Dg6R6MuBv6bfakkczic7rsxw5buupHthIOXlNkw3rXydW1z+8A6ga/heX7uKa0s+
 05Jqx39QQFG1jQey+f6aDknCgjGpLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

With build_skb paths now utilizing the local NAPI SKB cache, switch to
using napi_consume_skb() in tun_put_user. This ensures the local SKB
cache is refilled on read, improving memory locality and performance,
especially when RX and TX run on the same worker thread (e.g., vhost
workers). As napi_consume_skb() also performs deferred SKB freeing,
SKBs allocated on different CPUs benefit as well.

Cc: Eric Dumazet <edumazet@google.com>
Cc: Nick Hudson <nhudson@akamai.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 27c502786a04..b48a66b39e0a 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2155,7 +2155,9 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	dev_sw_netstats_tx_add(tun->dev, 1, skb->len + vlan_hlen);
 	preempt_enable();
 
-	consume_skb(skb);
+	local_bh_disable();
+	napi_consume_skb(skb, 1);
+	local_bh_enable();
 
 	return total;
 
-- 
2.43.0


