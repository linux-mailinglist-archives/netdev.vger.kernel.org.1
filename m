Return-Path: <netdev+bounces-28112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D3877E403
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4660281A82
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F76125CF;
	Wed, 16 Aug 2023 14:40:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0E3168A4
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2138.outbound.protection.outlook.com [40.107.223.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CE826BD
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIoYswT3alKUlfEZp0oe8WunEXw+Bued8/4KITK5zOw8sPf7pQ5W3Ol0YIC+GrMSMcBmxUzS3hUxPg5h1VPmPHnEvubt3qiPYuC6PGN4aymi9/pB/FOggU8SVGPJ8mCI5DQT+BzyhK6KJ8Xh3rwh0dGHX5FW7uNPX0Lh8mCRPCRJez3r+pjjKPa9vkD1dAhtkPo2lLqvHS4nLh3exnshPdFSpuuJlsaP3yztVT6STXI7vxXkP22Opq7h6gJDE1ox8UavLuMjxIIHy2jfprI8bqn7WpgWoNTfg2JVXyfQ70A2h0pItJbiBJJQFR3yN/iHTS/eu722BmXBQm9Z43aVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uusrKWNjPd2rs5/75cR2smhvHy8SOvmHJq/TbJD29E=;
 b=CnIEepDPVeiTATlu1aMuCRts+YHFIilz+hJUDfCRetc5BsIGIJze4/a08CqAnKjkrQBOiQdxtV/wu7bdpIlBzNeYc+b+B2XJtZ+w4xmFJWCCImEQEVfrIDqssjL0r6e8pJn84tqRRixCzadVveAzoejWhH80iK0g2/bcTaGNRq3nmJ+UZauYJsT0FKGrw57EJg3zLU26a9Pm88BDd331n+j5LfHc7F4Npdgd5xx0VRXVsZ09C2HsgeEilXB0quWkDPP+5F42XfKEWN0ph4/l2RCexcjWu4MZBRKygEmNVayf/UPuYBcesU5H9JEmYV5pr1CbvjZw3i4rwUD4fw40+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uusrKWNjPd2rs5/75cR2smhvHy8SOvmHJq/TbJD29E=;
 b=su6MrdHN765uzYjzzkL+q7bVS9EtGR5wElsAD92uVGfUY6ldyWHaqUtXGhBbBeYsi5au8/IMwRxme1Ucbk1J7dR1d4l9P3tEtMf+qZtvE85lTI4RFzyjHbPvkK93AHpeIt+yMleboLGaglid7IwTAZ/JefiT/IsRYWYx32MwV7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB5004.namprd13.prod.outlook.com (2603:10b6:510:7b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Wed, 16 Aug 2023 14:40:32 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:40:32 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 11/13] nfp: configure VF total count for each PF
Date: Wed, 16 Aug 2023 16:39:10 +0200
Message-Id: <20230816143912.34540-12-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816143912.34540-1-louis.peens@corigine.com>
References: <20230816143912.34540-1-louis.peens@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|PH0PR13MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5460ae-78f6-4cd7-6ddd-08db9e66be38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MVJCJN3vhBJCgyxKxgolKnGoD0mdcHABMhXU4gWs4vc6T15cTMBdutyteAoiTMkc1xdiCJDEIGy3QcPRhoOg86RUJE0+/+eRtTA3jlKRpuxNrlQBuAsGnbRQdbsNpzpnTaOXfXTyZO4MJR6V3RmpPJcq4T//C8kdy5jM6c884AtpwTlYEQwt5OcNDInK9xXRWoqc5KRubIL/x64UstcjMbrUt5ZdP0vMWonhOg5C+OLlodb5bTDaLqpz5gKYS54ggzSnGNbnB+EumkgGzhktWRdkhgylF5/ovehE6L/6pVFEoBFvjrx34LK5SbkgH3KxpDew9K4rM6VxpKmmXFFgbvp9PrMn2t4VPxnfY3PMwzVe9OSn+otG6WiuxN7ivWsxAk+MJ0jydcq1lGOEBy21UtKlZckzoOIba1TiYrKAkvUnaj3nN5xS8lBRrC3BwITtLwMeo1cTtVwmh1ZaFs8NIc9BxC8UIck9IZ+rmL7Ix++7aH8NOKKS4K4QZYz0rQ33SCSTK0v/4uVlr6wFiwglwjvZm1/Tu8/b0tCVfiJLj0velJFUXqDN6ZiNRzQ38uAvkPqijCtw5Y/mzdqph4p5o3nUuu4I53LsDYs6ogfyWGUqfn85e0Ws5Rwh1ZKZok6bLgoAZlk/rJ5Ot595X/KajXndXZXjII1i/YRqNoyEPy7zvSZB6Xg3K/4Q0ASdAUkf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39840400004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(66574015)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(6666004)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmdvRkltNlZhOFcvRFpOSzJwT1ZCRUovd2lNaU1OOVQrVXNMMW12OGVwSStp?=
 =?utf-8?B?YlA2cTJEdnZXRHNZNC9qQUV0VXNiOW5SNnRjMHhnRXRGYWUxaHlqRmhPZld1?=
 =?utf-8?B?RWUwVWp5QmYvNVNKbGVhN2RJb3lJaW1ZTDFYblZhSGoyRmptSUtWaXRPNUND?=
 =?utf-8?B?Qm9KQldwWmpVY2xmcmJlc05xNEdIRDEzeEk0cmxZNWpWRTl1NGdid3pwKytw?=
 =?utf-8?B?ZHc0bTlQbFd3WGx3dUtQUmpQcUhSeFZGMTBPT3RVMzlGZkl0b3VuNUpmTTFE?=
 =?utf-8?B?bkh3cDJZZWhIWTNsTUlCWGprV1dBSDNwMUNraUdlek9hL21hL3ArQmU4cy9m?=
 =?utf-8?B?NnE2OGpMb09McjBtUlFidy9MYk9wWGpJNy9tWlBzMjRxOVp3ZzJaaExkVm9M?=
 =?utf-8?B?TWxURjF3NXNvaGd3WEMwZGZnT3VHNTNVSzlKc3NKanZpVVAyT1o0dWpzb2gr?=
 =?utf-8?B?YjJlTElLWU03d0dObUhxNm9iUDZrYTZ2N0tXdWd1bTRxY0Iwb3VxVEpYdGwx?=
 =?utf-8?B?SkhWaHlwMWRhVksyem5jNi82VTZmQnZGYk5PT1pMcnJ0M3QvUks0cEJmNi9X?=
 =?utf-8?B?ZGk1YzQxSEs3QndoSDdJdURUTnBXSDZCQ0hzd1FWRExuRDJHbFozYk84WDF0?=
 =?utf-8?B?UEJBNWphcmwvUzFLMUlpa1RreDkweWVuZHlHbHZ0UDJPNXJud1JHWkNZc3Zh?=
 =?utf-8?B?ZWJCTzlzZkRyVmhmVkhyRnppY1p6dzlkZHRDN0pwR2c1RnI5V1N0QzZOWFZ3?=
 =?utf-8?B?NWNlZ215cnY3RnBaZmJudU1UOW9Wd2tTbGFnNXkwdlhFazFOWFpOY1VYTTRv?=
 =?utf-8?B?OWVvbUpkTk84MnpIclBDeGRiSHY4N0Y4TFArREQyVU1rbUV0VllSVy9McWdw?=
 =?utf-8?B?RFMyMXJ1RkVVRzJXRHJTK1N5TUdvN1puRnc4Q0xWNW1Eb1ArZnU5QjZWenBM?=
 =?utf-8?B?TGdwdnljTFNGalNUY080VEd1Tm1adUtXRkdtem1Wc25rUXJxTit1MmFUNXZp?=
 =?utf-8?B?aFcwMFhXZlBLaUdiaVhLNFJyYUZVc0pBVk1YbVEwNFJyTHhEbmh5VzJHSVVQ?=
 =?utf-8?B?YVNjR3B1NU92cWtpSXBOaUJBaTJlRmVSN1A0ZEVadWR1SnQ2SG9Ma3lvMFFo?=
 =?utf-8?B?Ykd4Tm1MWHlIakM1bkVjd3hFRkJqSndpRStKUW51VXkyNXJob0wxdytUbE51?=
 =?utf-8?B?TWY2anRacEVPT0dpU3dkbUIvekFBNnRzSmc4N1kwdjVFRHMxQ05RME1JV2hC?=
 =?utf-8?B?b0FzTk9HWnVFdXErVVpTUG11bUY5dHY0ajB4SGJhOTVVazVNck13VXN5NmZY?=
 =?utf-8?B?TkJtVGFTeUs5bmVpZDI3cjlhQlpNMG1WVzIxQjhlZTNjMUdubkdDRnBsS1RE?=
 =?utf-8?B?SlpicmdJbkpOK2htUlJtUEtGZk9WYko3aHpVMWRZL2EvVk1kejJQWkFsZTFM?=
 =?utf-8?B?eUVSZGRNNjlJMjEwaWZGVTYwcWt6KzhrQ0NQcFpCR3c0N1N1ZzdsL2g0N2w5?=
 =?utf-8?B?VHZmMTB5WXFKRDRTdWI5KzhDMkY0ZE1mMnRRZEQxNGdJVzZEV3l6RlNwUGxC?=
 =?utf-8?B?S2pXeDRiOGQvZm56ODZkWDFGMFpWOXZRM1ZpZ0JaZjlkUzdCbnU2My9XQzFP?=
 =?utf-8?B?YW9IdmlwOFhZVXFma1RrK2FOWWw5SSt4bzZDZFg1bE44MTBKakJXWWYxN2ZY?=
 =?utf-8?B?WkxJaW1XSEFISWlSY0YwMnU1YUludzBCbmdKQk1tSzBxa1F4SjF4T3RGbU1Z?=
 =?utf-8?B?WTlubFJJMHdmNHVRWjNJaDJFdFRrUTlrNWtsMFVacFdTR2NlNjFXYWFORWlF?=
 =?utf-8?B?bFhiL20wamV2ZmJwYjRLelpSZ1Z0QTBhZzZZUDYrZmJMQUYwUXppMTE2RXQv?=
 =?utf-8?B?ODBIVy81YzlJNWRiUEJ4NHI3dW9ENFJ3eUZYM3dDdmxYb0srVDQyd0xRUzAz?=
 =?utf-8?B?eUpUNGJNMk9TZ2tqQjdvb2Izd3o3WHBaMWs0Mm45eFlJdE9WdXdKNFVXQzRG?=
 =?utf-8?B?Q3BBeDltVWpkS0N3L0xCSnMvNWsvNXRoOS9JMlJKVVNDdHc0ZXJIVTBheUhL?=
 =?utf-8?B?WVo2d3lUaTgwRU9tUWxxMTNjeGl0c3RpaGY2eTZoSlNEbjlDUmRBQUNiTCtE?=
 =?utf-8?B?WXRJQmVkVk8zdmUwRk12cFltL3VBb05XQzF0UDJKMll3WUd3Sk5hYzJON3I4?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5460ae-78f6-4cd7-6ddd-08db9e66be38
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:40:31.9797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/A80S5PD5SA2wU0APzakvpbKB2Dn9AP2+wC0Fr+tr5wY9SUfoPlgVZjMLdNL7kcOFaOAJaIjhySc0PTjm83bWcsgdn8+7wxk3YZsvVx9ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5004
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
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


