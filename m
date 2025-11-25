Return-Path: <netdev+bounces-241643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3336DC87124
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4C614E4C11
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3D20E03F;
	Tue, 25 Nov 2025 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="bzfOJY5v";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="eSnVvIg+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64871E505;
	Tue, 25 Nov 2025 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102744; cv=fail; b=WZT4gdu1tLBOfuXWhLvOjcTIFw2pS9k3KdH8DQcjzBO4dJdHspXPxLEJT45vw6g9wdGem3Ar2vpJXYEzfS2my4WndrjjjLKbfgKE1PVwrUd7qOwvjBXB/5pCKqXvvRgngqtloED4Eno+4dSjvTaxvQ0hahee67tdmFx0LGxccqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102744; c=relaxed/simple;
	bh=HkVJkcog7WF++KJBnQyS5WtIrHgRMixD7pD+y3H9eew=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VAsmesIOOUGNKJdhJMdBzOmcJgaRMSPt0j8oeoLJIAC0o/JOU7h9tt36bVIaVAkA3rVgstRlaQkAWLnr3MTJI5Yzjjl6N+axHqlp4Nnl/aNcBLcoVoZe3FpBSLBOQ72ECjQVLYkhaQn0gj7BgSty2Cmqyry7H1dUFtSAv39Hjx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=bzfOJY5v; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=eSnVvIg+; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APHWufe1890194;
	Tue, 25 Nov 2025 12:32:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=Emrdei+dWg3dx
	Xz5iN2B7X95CmPBUAAG+SRVfChXlN8=; b=bzfOJY5vpCK32ZWEfIwQtaRiWfbKH
	Scfmb/vSPoloGC3BnDGuNm5RscgOB8ejFxv/ubvRM5WTo4FWD284zkpHOZWevHoi
	caXfxrMB/ZgPC/60XVsbwBEWYFF8kY4C4AWDyF1yRi4+Eb9fbsY1/YMHA7vYFQkb
	KVHU5ZXYVeFnBhav5yPMDVLKktpZjQfsa26rCDlcVtJKfHvSaPM0CbAn/myBJACM
	OOZ2ymTL0c1n1llWfllut+PNlAASMr+pDlTbQjSAZA74c1Mrg1Lkh1WFlIxeCLqF
	lPjVpSw+G5edPMUCpXXsqGHd77kEuZfTTtc16nFXkSX2vmov+TOaHdvYA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022096.outbound.protection.outlook.com [52.101.43.96])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4angxyrbej-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 12:32:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwo0WfpGBQwY6j4Wl6CVsH7Zz/okol6EHIBgTY3gcPiboALQhCCaJlDi8H8v5H0PO3vv5X2/7aASn6pXMuY6fb1FRv2Ndm9vLfz1hsZ1p7m46JEABbk54HoT+izI8eeL5k8tu04j46uLv2WORd0xgw5GZVGXw8Vi54ZkFeub6UzZXkN+g5i6bEVzA2Hg8fC0zHsH0n6Sne52sltrAnb4Nh/CsWH12ZhDq6F5Mr1k59qpnyyhZiFxaONkerIrM65wAIKtIhiGcEbotiiIO9kiw8GW+wAybvshTEZAzPYr/JEKk6N/+cwFGlEaEA7fkOBOYPntJImJwJqCiRb48TZ2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Emrdei+dWg3dxXz5iN2B7X95CmPBUAAG+SRVfChXlN8=;
 b=OVL6dERJkVxEcTrp2SdKzhdVTwQkc7sfcK0yM6g74FFJRs80eAQ/ZvDI9DhdNTpgbx1gxjNaBHJqFt5IElHWaF9VlI+hK/FiUWz7uRx9Hbhhy/pFjsVvNidZa5jrUF/CFj2Pqa0nRPzrHuQOOATGlToxugoQO5ICijbF+k2vKiYzTNsEyITtFFGAncTRpeHrD+lPBm7FnQ/SDXdHr1nTmsTGLZ0q6zpnVztilwo0JbJ8bIc/wMzPi75YdGwXJ3LErsszPwblVWaE71FD+0nawB9dzYvO1M9bn9dj32K/Gor+1GoYH6qIR/yoQYpD+iON4I8FG39w8p4FvawsPA1Xaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Emrdei+dWg3dxXz5iN2B7X95CmPBUAAG+SRVfChXlN8=;
 b=eSnVvIg+1kzFxm1CZUnuNIseiQjQJc4cHZVBe7R0ft+Ym1vqxu/95wxnyfy6Gqn5GnfqMNkS2DGDdWylZLPocflZSBDU3uxqZ+sK1ukgil31xnRADNOKOPBHDihKcpumNpiDv5Ea85zu/f+Jn8aF3z6+TPjw2Sz4rtlNYxtcA4d/5+aiM9CWHWBvG1nDphEedBdkv+EfZUH+CXhYBx9S9vMZyzcv6YLFhenpjPghVvG9ySn2EG1w3rTBvQqzh9TRz+wLdFFhgGBMUHEznwQS1ZnBghNZRA/dUwIXkHWBF8uiwn2c8LdDk0t7rapQbKEGiLhMCKUlyfEXnd5nTZD+7A==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SA2PR02MB7689.namprd02.prod.outlook.com
 (2603:10b6:806:143::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Tue, 25 Nov
 2025 20:32:00 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 20:32:00 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH v2] virtio-net: avoid unnecessary checksum calculation on guest RX
Date: Tue, 25 Nov 2025 14:14:17 -0700
Message-ID: <20251125211418.1707482-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:510:325::8) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|SA2PR02MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef39a93-a671-46f0-ab52-08de2c61afb3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bMjlxy+iYEjnJBUCvoa/7w8hDeOXhMU+pKhplRDn8xHJ+se2rRfyPIEffZo7?=
 =?us-ascii?Q?yAbB6+85Sbnqh2VPv1Yduo2mwdMIwm+NPBtpZZ/K/zuYRnwSLCS6+5RXs1fE?=
 =?us-ascii?Q?zGYJ/EbLbuTrE86YhkaF2HJ0PokY2MVtPkYtCerqeU7p57NdBBTTFVPRp2r1?=
 =?us-ascii?Q?U41zs+b3N56qBptrqZujjbIozA5hsVKQGtapFWjJ2PdO6c38XTstguzsNHEP?=
 =?us-ascii?Q?CmJB2g4HkZw7XJTevd78b9KHp5aDgSNnTY6dKi0vIljTDthBXOcggUtqBERj?=
 =?us-ascii?Q?DLC340t2/OHxMB65UtcbodURBO2W6+RsGtDHb1OAeIC237Z3fUFppNcfXixZ?=
 =?us-ascii?Q?0iVmKab+fqll0/Rh++3yFjvE23zOux6bdxto+kDJU7Bd/rJ87Du8Pe8zwdEs?=
 =?us-ascii?Q?3Q6TfCdMVIObLONhSyZtYN1f/c7kF7GuBhISf2x/MtydE0tafgXpiW+CxqaO?=
 =?us-ascii?Q?R8E/Kw5BJcrAsiDYaQE6vCyYfmXO3YF8iM0PRF0QUik+b28tb4IsyjXyus4y?=
 =?us-ascii?Q?jrxcxdnFNnTIETIsaHK+k61CbKgPK/wxnRURohJjGPVR1I9/9PTLxPuzm7VZ?=
 =?us-ascii?Q?owI9bW4skiqG2zx0PqYZaKdBuSh0taZcMONjQXX5a+LHatwG2huamdLNoal/?=
 =?us-ascii?Q?GS+XGQHLEHIfdRKXwNFxEoQRVzRMZiOYoKOovvtWMl+u3qnLNyo0904htP8P?=
 =?us-ascii?Q?x7O+Gz6WG4zmrlTLuTqkpN/Xu+sWL7DpvgXfMaJsRKBW4J6bZKM240pGTwvV?=
 =?us-ascii?Q?TgOgaEFtB5oDFm5+uS8tv4zmlY6Sn36qbSNEODjjXpVWxXHn+xQVT5B2GoOn?=
 =?us-ascii?Q?axhytzO8SDiLIxW1Lj20XdVnZEGjrrpNFQnq05TJxatEwgSf4gWrj70h5RLe?=
 =?us-ascii?Q?wIjlmSusj50b1o88/UzZBAjwzlv8NghvmGQRF/cAuJTVL1MyxuIFu++/2gO7?=
 =?us-ascii?Q?mrjb28thjrXwFVGhUf8PWtqu7qlZZw1LzFIuFNsQepxLx3FYBQjl9KBzxEpP?=
 =?us-ascii?Q?t3BnCWsdCjLPRo/3I4FKKin3m0YduDfigpsTy/BeJ3bUoYq3I6x/8ysanVo+?=
 =?us-ascii?Q?OjLbW9w/fQffjuSy0R+aCVLebRTrnVdQm1TPR47DN2UCgfo7Wz/xqCDrsjgI?=
 =?us-ascii?Q?Q356G6LVui+MjGuLvM1QadKPHbUtGvhA5TOOktv0EVmIbbpYGrHB6XB/rYQx?=
 =?us-ascii?Q?GmWabx8iIc4Yu/mhZjA9VbGk2gF2lgpas6Hxw0CdpgtKZbr5KzKnJU/MrGvA?=
 =?us-ascii?Q?K9OSXF5UaWHz1p35AB1ThOE1JwvxYQXPFNEeMZX5Fa7DBB9JZa+lk6GGyRFy?=
 =?us-ascii?Q?4fMW6vS3qzZ5aYJ17FGsFZOJqZLik96WpmVGYu9ujwAZyFfYPegJjazVeuYt?=
 =?us-ascii?Q?3Rvl1KuZ4iTf9Ape8opIGshGlOhhHjrTh2rPtIrW/x8ObTF3e3nwwp3aaPoN?=
 =?us-ascii?Q?cypzmxQlt+SmszHYD9oB8HOm9WRURJJF456Dkxy+LRQWGuTU4GpkGJfOCY2D?=
 =?us-ascii?Q?q6fLz+1mqvIEsupMsmWV3vm9eqAW5ObOvk8MQJbZBcxYYrAk3bypVmg5Uw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SEpSk/lVUanh9/aQJ7akqogdm3ZrWjzQMlSy4xhjjzrnan4X1BstMNXof7ua?=
 =?us-ascii?Q?a1cFVE9m1fEpMnR5/5d9COKOAK7ZvoYjA+mM5fMkw+IWbUKN2LqcFNRmrBdc?=
 =?us-ascii?Q?ZQaoqG1r1ktgbj+A4WRoMbQFziOeJTpgOklI1H+/qkYuuDW2lOenyCh9orso?=
 =?us-ascii?Q?57UA1aVStmnABPu80ED6YGLwwIqbfmqPHsfSep3B79ghlNPtBfTrrhAIg06v?=
 =?us-ascii?Q?AspO7490JN5FnV3/0HPbjJMb/a/K//jylkdq3O5477/En2f7KRAy52EdXZjj?=
 =?us-ascii?Q?mlS59QlehxBzk+NWsZQ5ugKgSfBgHqRjfh+J4X2nuPSG+3rFbnkV3hn9wUaj?=
 =?us-ascii?Q?kIJNKyEkunVB1NeYqBF2qlFevSu6gTsFs/+dNJflxgFVJM0Q3+Yk4B7RrHje?=
 =?us-ascii?Q?WYrrHxL9wTbU7KlwQwVsyOvo7TDCGkEO5bNShf1H23zrDZTTuDb7fbE2MkPh?=
 =?us-ascii?Q?/vzzx2t4+93bgxwcypFv1ZIIcpKmcemNPQWB2IrUaLN8/ftgJ/yxbfND5c2i?=
 =?us-ascii?Q?TTQe6qMv9LX6H4b1BOkqfkn3LFcQm9vPMgiNcZdZ+zdnGMF6sKZxv6A485C9?=
 =?us-ascii?Q?YlZh8NJbDi1+aXv2KPZxqLmywXag2KXtdzFwPSd1G9tpSxIRDwik7K4jGUpv?=
 =?us-ascii?Q?681hKVoT2nozu6OsY3G7ejxXvU0ozOpmcUUGA0G19LLy7ggKHgT6vTkgzXMt?=
 =?us-ascii?Q?SPm4+l8TJ7cgMB7i6h/49z7pP7ILGLOepKanVZlmPUmgeTCMuPhFFFwfx6oq?=
 =?us-ascii?Q?uEyKPCURziW77y9ZwPiab+gXSwT0lLDWpIopXuGOR3osG5BZ5XqOIX+YMZYy?=
 =?us-ascii?Q?jOdEJDoy0aSRIMgxeVOr6mv4W747hbem6CBPtrc3EYIgigRwumYwUQs2E/6S?=
 =?us-ascii?Q?KlsIEETFNj47aWOORsXg2ceTa3FY9MX5E8WtSipzMX5hZ1FvUN5/6/NqPmyQ?=
 =?us-ascii?Q?mvE8FRY8VknOHZKhZ6JpbDiGl7eHpfhQLnCsmelvR1txhepms5b80gmbdnSs?=
 =?us-ascii?Q?vIH71VRyF0GnzZyQb715PCfLuX+Lrq/Fd0L0Mk1jPvHlDe3mxhfgCt6+XaKp?=
 =?us-ascii?Q?Vk0J0MhaNIqtIO1gZ/jJq7x5i7IofcNQ8Z/VUImdleziiPZuYjQPrk09xcjg?=
 =?us-ascii?Q?nfFEAoPZDmPfUO2+ShER93M/WHu82jiu3dfTV8UqiTx5IPCHEqtfKGfQLEiD?=
 =?us-ascii?Q?RRQBd2IB4Vnw1gNh4F6zH+0gscgmpevoudfoJbLV5+tg9XmDByXHcYVaPV83?=
 =?us-ascii?Q?ZcPCDXUfGQUeaOaJbN5qLlkOJCPQNQjEhRoSnxF647pwUK6v9v7hz3tpR4TZ?=
 =?us-ascii?Q?d0sc9ABzC+za1Wv8ViBrSKsvGYVGuLQ6jEsFeY6MtZ+l05nu4JQmzaUn21yl?=
 =?us-ascii?Q?cFcMb18AbdtA+g54++88vN/10nPlbWI2YAk4CsDN77RsWHgtfR+Gz8hT0cxC?=
 =?us-ascii?Q?qWIOMCyedr4HTaBfS8pbOE1v9R04FYVxf7x1QooX7nv3xGMoO//B5crtv1Fv?=
 =?us-ascii?Q?1FTmyCBFRZwB+MxtG13bUGpsdbb83oy4NKhd3yOTrAAy/JaqIwssNNO+NkKs?=
 =?us-ascii?Q?iApiL57cL0tSWcF3JskBgxFKL/wi7b8GZ0hhcqd1mR+bT5i38kpEzvPEQCJw?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef39a93-a671-46f0-ab52-08de2c61afb3
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:32:00.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atv7+fwJK9S5Lx3TffW+f/ESDbTLg1ryNFkGNkCrdfQkYbF+2i3U1SsCq2Tl8450zYEOAPr6b9x4P3yB29/HINjfGhix3gUxbsT2VelqTug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7689
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE3MSBTYWx0ZWRfX7OVYsuOGU69O
 TUmTfm7GP3GX1dnI/zelmiew7QJSQ0e5qy6wkrvcR6YcrnhwWHDHosZdliqYsDaBJ6NUCON15Nk
 aEF7mDUCi8BpJkJzqKy/MgHHF9UKT2HqK7ozSoRpVtdwIWXy6LbxsBqJYtpeYA9bLexEcl/m18l
 pB/jC1EBbulBWyuREPBY+6o7tEwvnP+aj/xzyzSE3QC9fUsXzN5Bm+58X6KUBHeE3o5TANwoO6C
 Vyh7HRLdlRGe9+BlHWRObhQqzfbw1Fbz5ezl1NhjjSsA8GAdVo86VHQNRumsr+2YEa6BuMJRP+/
 4EYp10GGxJxee+6Q7LcK2m4AHQWdXC3HodtRHF6/IcsG/pgHJHmcDx29/uPejRRAjMLDE0AvGgH
 awqmMWLKSUvVbl+2YwBs9uSYoMBROw==
X-Proofpoint-ORIG-GUID: ucUYn4Q3pYZkv05S2mqha56_IhLYgm8w
X-Proofpoint-GUID: ucUYn4Q3pYZkv05S2mqha56_IhLYgm8w
X-Authority-Analysis: v=2.4 cv=BeXVE7t2 c=1 sm=1 tr=0 ts=69261245 cx=c_pps
 a=bS5nqbbZ4iEfIErZCQfsMg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=CJVaotp78blY4fChFuAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
GSO tunneling.") inadvertently altered checksum offload behavior
for guests not using UDP GSO tunneling.

Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
has_data_valid = true to virtio_net_hdr_from_skb.

After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
which passes has_data_valid = false into both call sites.

This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
for SKBs where skb->ip_summed == CHECKSUM_UNNECESSARY. As a result,
guests are forced to recalculate checksums unnecessarily.

Restore the previous behavior by ensuring has_data_valid = true is
passed in the !tnl_gso_type case, but only from tun side, as
virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.

Cc: Paolo Abeni <pabeni@redhat.com>
Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
v1-v2: Add arg to avoid conflict from driver (Paolo) and send to net
       instead of net-next.

 drivers/net/tun_vnet.h     | 2 +-
 drivers/net/virtio_net.c   | 3 ++-
 include/linux/virtio_net.h | 7 ++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 81662328b2c7..a5f93b6c4482 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
 
 	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
 					tun_vnet_is_little_endian(flags),
-					vlan_hlen)) {
+					vlan_hlen, true)) {
 		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cfa006b88688..96f2d2a59003 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3339,7 +3339,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
 
 	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
-					virtio_is_little_endian(vi->vdev), 0))
+					virtio_is_little_endian(vi->vdev), 0,
+					false))
 		return -EPROTO;
 
 	if (vi->mergeable_rx_bufs)
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index b673c31569f3..75dabb763c65 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -384,7 +384,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
 			    bool tnl_hdr_negotiated,
 			    bool little_endian,
-			    int vlan_hlen)
+			    int vlan_hlen,
+			    bool has_data_valid)
 {
 	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
 	unsigned int inner_nh, outer_th;
@@ -394,8 +395,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
 						    SKB_GSO_UDP_TUNNEL_CSUM);
 	if (!tnl_gso_type)
-		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
-					       vlan_hlen);
+		return virtio_net_hdr_from_skb(skb, hdr, little_endian,
+					       has_data_valid, vlan_hlen);
 
 	/* Tunnel support not negotiated but skb ask for it. */
 	if (!tnl_hdr_negotiated)
-- 
2.43.0


