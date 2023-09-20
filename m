Return-Path: <netdev+bounces-35164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9698A7A76D3
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4FD28169D
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C96C1172A;
	Wed, 20 Sep 2023 09:05:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA0F9E7
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 09:05:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE8E9E
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 02:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqPQeu2cvpPFax0MQQThKi20D/QKWLfbjwXXWytT8MjHXavey4qMU4tBnLx4lPwS9HcCGDb2zgVv/V8NUYKH0/iAyhDgSyZvVm5HKBr5myYg4z+v240Qii92S/ZXlTrGSdrlqZAJwp2X0Tup1h7FjVqa/uip0TQ43gVNzz62HFwhuhXjRFl2ef6bhygE/6K5jbDVzQUbSOw33gnHQQWM+v58ddvoOu1t2nUdWh97k4fqLORlWDOyfcLYX61WDPJuPqzI3zLlpJMTi7SvoUlryZ3A6tfPAn1xGJ41xtlVvqvnBFM0M+S+4n+1AgXG38hJGFwf5FTvCE5bKSzAEffNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8syPgr9VA22oqCkt3QvEfNrbRRycWK3DYdvniAf9pc=;
 b=MmfjhBPAI2gre58vCADI2skIlukxLx98TlHe9M8shANR/c1PYWrpTlpxsYDavh7/QrSrmgRCmAAH8OEn8UIc0B3JVfqVMJ+UE872gCKcwuHVjliQaARR1LsDoJAWyKx3RMrxLc76Dtve3wfETxQbIATjcFustNvoXO9qQburD20Q2mukTS4QjiQ67dKYGHy74ODGPAuG8i6mLmT+XVnSBKE7yfYkNcCAc9lMO60RMJvOOh6b0YwDv+Ujcvp2zKahsgcDIwGWBYDrXN3YUMFkWDBEJtm9ygAcK8exlEkuDI1vSGXjFYUbmlcOxk6/3yfgFUUVVV33B2lfvI6KFe9OKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8syPgr9VA22oqCkt3QvEfNrbRRycWK3DYdvniAf9pc=;
 b=WwfsDYUWUNWvnzgCV/SI5qJmwuTV8Ye6vSecFxdCxWbWPC8zi9aaROOufvvcSvJks1oVdR9ZH0cfFXfPN5+lynz/n7EshyxlnN9b3T0zG4Xd0UHH2RRWlOl6olFQEzeepemq1JbRgkefHNwIRJPyqjxn3vLqxnRf+kwf+IyIEPw=
Received: from MW4PR02CA0017.namprd02.prod.outlook.com (2603:10b6:303:16d::24)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 09:05:43 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::d1) by MW4PR02CA0017.outlook.office365.com
 (2603:10b6:303:16d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 09:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 09:05:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 04:05:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 04:05:17 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 20 Sep 2023 04:05:17 -0500
Date: Wed, 20 Sep 2023 10:05:16 +0100
From: Martin Habets <martin.habets@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>
CC: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <habetsm.xilinx@gmail.com>,
	<sudheer.mogilappagari@intel.com>, <jdamato@fastly.com>, <andrew@lunn.ch>,
	<mw@semihalf.com>, <linux@armlinux.org.uk>, <sgoutham@marvell.com>,
	<gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
	<saeedm@nvidia.com>, <leon@kernel.org>
Subject: Re: [RFC PATCH v3 net-next 4/7] net: ethtool: let the core choose
 RSS context IDs
Message-ID: <20230920090516.GA25285@xcbmartinh41x.xilinx.com>
Mail-Followup-To: Edward Cree <ecree.xilinx@gmail.com>, edward.cree@amd.com,
	linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
	jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com,
	linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com,
	leon@kernel.org
References: <cover.1694443665.git.ecree.xilinx@gmail.com>
 <b0de802241f4484d44379f9a990e69d67782948e.1694443665.git.ecree.xilinx@gmail.com>
 <20230919111038.GA25721@xcbmartinh41x.xilinx.com>
 <f0ecc83c-13c7-9cb8-ee2c-8b8e1cba7db1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f0ecc83c-13c7-9cb8-ee2c-8b8e1cba7db1@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 90aadb90-a031-4b09-8f84-08dbb9b8c4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/yCOt/13OW2wtnDlxJL89kcOupJj2fLnntz5zt/fZPuXI6wd5xkhV2f5b9I5EIuwltDWYuopLtRuBkF4i4QfVTSHguoCYBxuz43R6fH36IY+86sseF6MINtxEAOWvBKK8JUitJq2TT24k0H8TWf1bHBmYXu/QfyqMU6a1n0UkrEQOEj2sFrYd6ISjo0Amb90FAm12EO0BDCrKqRCCooyj4EjMhNGPxFz43FTygCbGLsqaBxwa+Q5J6fOGr+gClhBabp/x/qgisSxFWE9LInMsK0EdnwDRG+Cu1CGNj43Jh4suP6glkWemivKVgpeeBFaVTwBMJUgd9YsnnQ+5gzoIra+wlF4vVoor0sxV+SB/vXz7DlR1ixIb6Y62Mfn9Ou0o06m0HG16QRDXR5JrQoH3bvvH1w4OBnZkE5iptcfkFd3Wjz97EF6L7VKLWTY0FuBB3gA+1p1JOSSvUQXhk9mRdqdNbvm/HF+kt/1dtj4ZJe+QUmlYXIqvbFBVTGLOZ4SAAQJYoeDRyDjDF7LFLcumQwq+37vyHu+61CzyaehqlP5W+8jjV+oU2UnCJEZUpr8RncKWDq/yG7gH8MR40aKjNLvSd9dS8cd6jC/FlYxdfvfT/ti8QssCshYAHW8pcmFQb8qXOL69fDh+3nHUO6R+mfQFqyaq4Mchu4WMA1+3Yv53EGW7XS77pBxlZrelGTaLx+0JyIg0egUnKWBDYATIJ7waSXutZh50cnNNR5GfS6dHlBVASzniUCF5swDWTGhDCc40Ggjnt8O4uZ2PuFh/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(356005)(26005)(81166007)(82740400003)(36860700001)(8676002)(8936002)(4326008)(40460700003)(7416002)(1076003)(83380400001)(33656002)(2906002)(426003)(4744005)(40480700001)(336012)(47076005)(44832011)(86362001)(53546011)(5660300002)(6916009)(478600001)(316002)(54906003)(70586007)(70206006)(41300700001)(9686003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 09:05:43.0281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90aadb90-a031-4b09-8f84-08dbb9b8c4e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 03:36:30PM +0100, Edward Cree wrote:
> 
> On 19/09/2023 12:10, Martin Habets wrote:
> > On Tue, Sep 12, 2023 at 03:21:39PM +0100, edward.cree@amd.com wrote:
> >> +	int	(*create_rxfh_context)(struct net_device *,
> >> +				       struct ethtool_rxfh_context *ctx,
> >> +				       const u32 *indir, const u8 *key,
> >> +				       const u8 hfunc, u32 rss_context);
> > 
> > To return the rss_context this creates shouldn't it use a pointer to
> > rss_context here?
> 
> No, the whole point of this new API is that the core, not the
>  driver, chooses the value of rss_context.  Does the commit
>  message not explain that sufficiently?

Your commit describes it correct, but I had my brain wired the wrong
way around. My mistake.

Martin

> (If you look at Patch #7 you'll see that sfc doesn't even use the
>  value, though other drivers might if their HW has a fixed set of
>  slots for RSS configs.)
> 
> -ed

