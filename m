Return-Path: <netdev+bounces-20329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E7A75F16A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C38C1C20AD4
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C994EAF3;
	Mon, 24 Jul 2023 09:51:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65979E3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:51:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CC3527E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYR2gcC4fRZLyx/Vwz/khGAC+iRYNt0LX3ROcxVHuEEo5eM2adFenIFosbCH51nyZdYijFTQxdmOP5oqxTJa91XO6TPgsSex+D6Gv9CwZHnIRTHceYX8sJzcvltoFMhdxRwfX1IKz5dTTNdKHVOme5zlZOx6/xyV4A9DsCqQBoczNxSmMCbfICT42D82zzoHuzDePHEUdYnFBOPDr6KYeVsQBbFCJ1A116qhGVgbXt7vEELe3qyG+6J3w5GATwfX+0FrA6ZRxEWYbgYJa0J2S112hpiUxHXxx70YKHefg8UEi+wtAoZaO5X/PB6BOTgp+YPDhV286EjZjvLSbXE+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uusrKWNjPd2rs5/75cR2smhvHy8SOvmHJq/TbJD29E=;
 b=hLU7TXoRnM0GpztiSMwpXfqs5bxsXsLpFW1KoCfdVKA+lDeUfRjMswx0YEPxbG1F6iINSTHfigABM29ERMgrs63kp2dLD1sGSMI62X+RCVQ3vV4glNXnwV8Rr8eKVT2JALrYBxNCzJhr5bn8zXj4agMS97KSvQa8khMd9HpU8B2KdIvacT39N4fVjKKbJANX2MiWFpEDafCM0/VmSmT7u+Ur3zWQ9s+ZH8pt2NKW3cf1EhZrdws4BQKrc0g7ZmjJ9To+e4fqGnXhSKZzbHWBr85bEPv9feogTaXjjrNEJSoErTvHYONqBoZktXoWvCetuvQnuRj9XsD06SSZhH0XzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uusrKWNjPd2rs5/75cR2smhvHy8SOvmHJq/TbJD29E=;
 b=lcTF2bl3QQk7taJm6bDlkmOBu0gZprct4/BJbk+ROKKeNvXwDgS0oBGtnyQwI9yKS0Dubvl5Nws7EHfY/d08N50/dU4xUX8ta0aVFCp7WnwWga/UBXV3oQtyXxC+lsr3xXrJmt4xqb8bY9Zu+CBmCaPOFZ2FSvnr+nxQyWmpZg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:49:27 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:49:26 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 10/12] nfp: configure VF total count for each PF
Date: Mon, 24 Jul 2023 11:48:19 +0200
Message-Id: <20230724094821.14295-11-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724094821.14295-1-louis.peens@corigine.com>
References: <20230724094821.14295-1-louis.peens@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|PH0PR13MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: edd16a6a-32c6-4721-546f-08db8c2b4483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uqvE+HCA/sZEd2mJCs6R5SP+cp1IkO5c0WFbv7O4Ev3rK34piPw+qBlx8HNN0gyc7nA2imEAr+xcmUVfGPsZNd1U+ASO75pWm62JpmONHIm7edQMr4PHgXu0lEogifDvilJpWKN6uvHZhlLYRE732hUKgrRy+t7oJVHmllSw4zgtto0V0NcQOuEJLSYXOahOyo+TjjyfWkbsJHYBs3jZdxgEoN7p1uT0VzniJUdHSRS9HUugF+M/2MLrzTqLOFrGkvkquu98sxpwwrwVySMJ1fwoCtSx+XnZcBJVDnQYlKZEam80n5kAekYdifVKk16jyas6s4MYGVmJko6N/UnL1ppmYhMk3v/2vv7zOWydT19tvMVxTa40GHFivoy0dMVHxSK0FQO4Z52h2MYvm+1Nq4xVkjp55H5e7djmFayrqU4y/WiXopa4BpdRXMkI80JplYx8bv1o1TVdihzmYszjrhBGfsfu/R2yX0ihZXNHx04D7oHmfQArZXDw2o1HcEuyTgCaFbW+Ik+yleVYdjHK13bYoq5k8pPZqAWUdqjrVoTXKAI+LpzWbNkZPy0Ad83j9SIjkv6rYkK5ekxQ6uJ+pyAjT2GRAHWX/s42ORairpqVUCUCibNm45A1Tg1i+3AFKmAsXlpyumwyWGkm0SgRLpwQNiGkw4PMidTDdNtElG4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(6666004)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(66574015)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UytDN2pEZ0NDV2dnUlUyNGlFSTZBbmU4Q1Viam45c1dUNHE5d3hrcThRL1NW?=
 =?utf-8?B?K0s4ZjZuTVIzem1Dd3cxOStVbG5ybnFaeEk1T0IvVFMxbU5aV0wrOHFjNUpo?=
 =?utf-8?B?SWlkbUE0QmF3YU50Snp4YXhBRnRrTEZjYXpFazl1eWhNVTlvbTF0Y0UwU1BN?=
 =?utf-8?B?dlBTUVcxcXdoNFVWZVVENFhrL0RLWGxmYy83K0FyLzdpWFR1dWJTempmRkRu?=
 =?utf-8?B?ME93RnY1a0M3RDk4aGdWTmlNOEhVNGNEZXJld1FFL2g4MDdjOVhvUmkwRldy?=
 =?utf-8?B?RjIxdkN2MVo2dm9PeUplZk9NcXBLT1BBaDFhbjBCTjlJYkkyZHpUYmIwU3Bz?=
 =?utf-8?B?UnRoVXk0QUVUbVM4V2pTaG5ydmx2RWJySVQ0R1NmYnhUSlBkK1V1eVJjNHR6?=
 =?utf-8?B?VUpiZE50aFova2tUWmttMlJHam4yU0VIUTFmOHF2b0tmZHlQMTk1OUZMMUxq?=
 =?utf-8?B?MTVMb1JnS29MbDVrZ2NKNGdhNEZBN0ltTkFaajR2OE1MZzB4eGQrOWkwODlR?=
 =?utf-8?B?eXFXbzhmaGczdE1LT2g1RFFSNXlWQkpMeWVRNXJPQnVmeUFPMjlmVGJVNzZm?=
 =?utf-8?B?cmNxY1I2TisrZjVOMmFvVG9IdEF4Zzl1R0thYXNaWnRFcDBYd0cydS9VaGo1?=
 =?utf-8?B?QmwrTDBJUkJxRVNmNDNQZGFTY3ZFalFIcUJVY29QMFpPUFJGSEVMaC9WNmp2?=
 =?utf-8?B?SnhXSUNkd01KUkIzRzVlUlJEbXE3OGRUZmZ6SmFGMFJpT0gvM1EyRDVNTkFE?=
 =?utf-8?B?dWlnNkloK2VvUzR3RlhBZ3FQdUJ6OXZNL1RSR2Qwby9wOVFzVTNqU2FsU0Ri?=
 =?utf-8?B?b1Z4c3BvcTUvNFZlS1FaUFRkQ1lZZWdJVmdRMTZVZXV3OUdUNmdJOEcyS2Fu?=
 =?utf-8?B?TUVMVi9ELzQ1eldDcnNGbDJzdTRNTXBpUlZHY2Z5V3dhaXJrUlgwYmNFWjlF?=
 =?utf-8?B?OEVHWjBOMEdWZUZHdVpDZW1tRG1WQVZpczcrZFFQNGZndjNmSTh2eUV4U2V1?=
 =?utf-8?B?NzUxdTE3QUE1aXYyYWVLNTVZZGpaSFJRZzl2ODBDb3YrOEVYRDhRRXNlRXcz?=
 =?utf-8?B?Z0VFSEtjT0szbmlPZlNlaDErUXR4bndKWlorM3ZSVkxJcVNoNWE1TjBNQmhD?=
 =?utf-8?B?NDZNdjhDOVZqSmxKMTZrbmlqTEFGNXpZcy82RWp6ZC9pUnZBc3I0TkVXSzFz?=
 =?utf-8?B?UWRjYk9uS0pVRjdsTHMxRDMrV3ArRWYza1JiMGZtTmtaY0JuSzJta1plM0lX?=
 =?utf-8?B?cDFTRlRFdUY3S09BNGFpaDUzQmlyMHc1Q1VwRHZBNjhsNzMzSTFKU2lBOE9U?=
 =?utf-8?B?VnFqNTlmTkU2QmRpNmg3UnV3TEZtQXUwU3VpbVVtQ2taNE1sMTY2MnB5NzRI?=
 =?utf-8?B?bFN2S0h3eEJmWnNWbkJXU29RQnJxYUZMQ3poYjZuejE5RmNZUjZtR0RtNlI4?=
 =?utf-8?B?U1VVMkkxK1lSTmZBUTgrNUVaQWNDeXl3c2dpeGE0SHFPV1VBZEh2cmdwUUsz?=
 =?utf-8?B?dVJTRGFPVnZlaFJsR0p0bS9jd09YWFJyTEc4K0o1aCtSaDl2UVdzL0lrYTdV?=
 =?utf-8?B?cnluSmVJWE5SbVhOTUs4SWhrL2hhcjhJVVlVNFp3bzIyb3NSVEE4NmxxTXN2?=
 =?utf-8?B?Mmp3VUt0S3pMcTBvYjJEeTZLNDEybHlCZUNnWmlyTzh2STV4TldoWGIwOXZa?=
 =?utf-8?B?cEl4cFRKUnI0YWhOMGR1TGxlQWI3Y2IzcUpzZldIeGYwVmRrOU1naDZFWmVX?=
 =?utf-8?B?QkZ0WVhGWTlvRWtzUUMxR2hUNGFKYUY3UzM3K1Z2RGhJNm53bHFDLzlHcGsw?=
 =?utf-8?B?WFFWL2dITWF3RUFnNVBQMzBKRmZYazI4Y1J1OFRoZktZeERObHJ5bFg1QlRz?=
 =?utf-8?B?S0NZeklUdVVHcFBvYWF5RjZZd0gvM3VaOTBLa0Q0WERERkl4bEpXRk9SbStG?=
 =?utf-8?B?b0FYdzNpRlY4YVNQUzFOcmNVNWlsK0VKYklGTGRzd2xOQ2x2TG13WjQ2WXMw?=
 =?utf-8?B?MzVnWTllVDllMVZ6andaUnBxVTF6VnFsWWYyTkpQTTNMUUNFbnZ6ZjlhM0xt?=
 =?utf-8?B?NE9sSk91TFhnM3A4elowYmd3elNyc0FUMlNEemFBWU5FdWYvSTBUN2hKSGMv?=
 =?utf-8?B?aUsrWnBtVU5mUmhFMWNRTm16U25KMGxhaHNibWg5ZFJyZ1BpZmRTUmc0V1Er?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd16a6a-32c6-4721-546f-08db8c2b4483
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:49:26.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/ypq4hhuL/+OznDl8I5GhXJ+kU5EnxRaqbGk+kqMzx6Q0NbffcmUM+3E7d+Jnt3Ab2uxDTj9bbqH2OULDinipiFCg+yu46IoHTyazIx+QY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tianyu Yuan <tianyu.yuan@corigine.com>

By default, PFs share the total 64 VFs equally, i.e., 32 VFs
for each PF in two port NIC, which is initialized in each
PF’s SR-IOV capability register by management firmware.

And a new hwinfo `abi_total_vf` is introduced to make each
PF’s VF total count configurable. Management firmware reads the
hwinfo and configures it in SR-IOV capability register during
boot process. So reboot is required to make the configuration
take effect. This is not touched in driver code.

Driver then modifies each PF’s `sriov_totalvf` according to
maximum VF count supported by the loaded application firmware.
Here we apply the rule that the PF with smaller id is satisfied
first if total configured count exceeds the limitation.

Signed-off-by: Tianyu Yuan <tianyu.yuan@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 49 +++++++++++++++++--
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 74767729e542..b15b5fe0c1c9 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -224,11 +224,48 @@ static int nfp_pf_board_state_wait(struct nfp_pf *pf)
 	return 0;
 }
 
+static unsigned int nfp_pf_get_limit_vfs(struct nfp_pf *pf,
+					 unsigned int limit_vfs_rtsym)
+{
+	u16 pos, offset, total;
+
+	if (!pf->multi_pf.en || !limit_vfs_rtsym)
+		return limit_vfs_rtsym;
+
+	pos = pci_find_ext_capability(pf->pdev, PCI_EXT_CAP_ID_SRIOV);
+	if (!pos)
+		return 0;
+
+	/* Management firmware ensures that SR-IOV capability registers
+	 * are initialized correctly.
+	 */
+	pci_read_config_word(pf->pdev, pos + PCI_SRIOV_VF_OFFSET, &offset);
+	pci_read_config_word(pf->pdev, pos + PCI_SRIOV_TOTAL_VF, &total);
+	if (!total)
+		return 0;
+
+	/* Offset of first VF is relative to its PF. */
+	offset += pf->multi_pf.id;
+	if (offset < pf->dev_info->pf_num_per_unit)
+		return 0;
+
+	/* For multi-PF device, VF is numbered from max PF count. */
+	offset -= pf->dev_info->pf_num_per_unit;
+	if (offset >= limit_vfs_rtsym)
+		return 0;
+
+	if (offset + total > limit_vfs_rtsym)
+		return limit_vfs_rtsym - offset;
+
+	return total;
+}
+
 static int nfp_pcie_sriov_read_nfd_limit(struct nfp_pf *pf)
 {
+	unsigned int limit_vfs_rtsym;
 	int err;
 
-	pf->limit_vfs = nfp_rtsym_read_le(pf->rtbl, "nfd_vf_cfg_max_vfs", &err);
+	limit_vfs_rtsym = nfp_rtsym_read_le(pf->rtbl, "nfd_vf_cfg_max_vfs", &err);
 	if (err) {
 		/* For backwards compatibility if symbol not found allow all */
 		pf->limit_vfs = ~0;
@@ -239,9 +276,13 @@ static int nfp_pcie_sriov_read_nfd_limit(struct nfp_pf *pf)
 		return err;
 	}
 
-	err = pci_sriov_set_totalvfs(pf->pdev, pf->limit_vfs);
-	if (err)
-		nfp_warn(pf->cpp, "Failed to set VF count in sysfs: %d\n", err);
+	pf->limit_vfs = nfp_pf_get_limit_vfs(pf, limit_vfs_rtsym);
+	if (pci_sriov_get_totalvfs(pf->pdev) != pf->limit_vfs) {
+		err = pci_sriov_set_totalvfs(pf->pdev, pf->limit_vfs);
+		if (err)
+			nfp_warn(pf->cpp, "Failed to set VF count in sysfs: %d\n", err);
+	}
+
 	return 0;
 }
 
-- 
2.34.1


