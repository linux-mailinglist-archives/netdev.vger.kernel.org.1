Return-Path: <netdev+bounces-28102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CED77E3DF
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC07E281AC0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D50A134B1;
	Wed, 16 Aug 2023 14:40:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B197134A8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2133.outbound.protection.outlook.com [40.107.244.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65A326A1
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrpDnhLGp0oetX1Z9QESlJY1UDWY2NUFWijmuZHN9cK8n+3oMpd7lNmCWx/UktlLBjNoXTgX8Zi5HP56ni6kzY9468f7+e6ZWlvN/WIEpngnsp8PDRgz9aLrOEefWQ+MpusUk3YsjT/pPsaT0es5DeEdiji1LopCDsUHWpEc3kHFa9fR6mU2OQHS8vs/YBrfjyXWsufpQZlsySmZBV2XXqJvXGvsAIUUmMzysckwf9GHHmLcD72LTNgqoksHELa2cJyEdBZ3m5ZzX2QXGJgvp8lTjyOakk77P8uUavUybsjbrjndlpo1VRcwhqoBWxyGeWgJY497as5J2PbvYcc7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hky2hlzBaIrna72eQV+HsK0TOoTlRixOijN6JZRYRs4=;
 b=KvV+5lfaIgqN7goRxzCatfkvaVN+j/ySwvHElSLOy4NcUg0tzdQXT1wXAfVPNVux/6hugXVydD8rxgqqnSbaeV8Td3EBW5zSSh8nJIS2bDm5x+XSEbiTeFZbNHjCQTgJzx72vXkP2WMPtmrlbwGwXJVUMmMRH5QF84P1h1TWsvI9m9cjtjw84eAjmW6hmeTYI3zOn9Rob6j9ox+TmLJXFaompP4pMsK98WadWHUUCwNLutKtU9cWjiOF8iA/UmVSObUYf44jtl9lcdFNu7YBDigUCbj5vqvwYjonZd7evwXH8f08quLkTwsS2cjOCJK2kecOKaqMVu8IWWkIKmJtCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hky2hlzBaIrna72eQV+HsK0TOoTlRixOijN6JZRYRs4=;
 b=CDlUZzIVpC6BOz4GTHXw8mGxQ0URLwG4aAFBY+ILTfvNJRHKzlhxBgV28ie88tcNqAaGkHmHbIcJ+BPZ90up4wa13yOdfTufGjaZRsrZWBwYdIB99R0179kBuh+P/7b05ibhi36IE6slLr7EoeefRo30XgZ5kReU8ATzOWqdgZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 DM6PR13MB4097.namprd13.prod.outlook.com (2603:10b6:5:2a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 14:40:00 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:40:00 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 02/13] nfp: bump the nsp major version to support multi-PF
Date: Wed, 16 Aug 2023 16:39:01 +0200
Message-Id: <20230816143912.34540-3-louis.peens@corigine.com>
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
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|DM6PR13MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0df09b-37db-42a1-3f02-08db9e66aaf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nSjSPdCSXjNIzeeNNWNepPJXtV/V46QysyIF39oZeRxSp0b7Q5EAqtwyQi6FAoXdbvR1+ha+9eiGm9JWhymHxYTz9W9rPsTFUAhCEnfGHux/tT/CT+f11Vo8r3gMCLIlTJonFQdt2xXyhz9ySUXCDp2lTkedNXYqWAF70hOquMoOh37VAv6dOJWa90SElaUptb5B94cwFG2E6LZIkynAk0pAy5WeRUvhyXKrQ9//+e1zOlZWVEZp1AGuWemqWIFs1+1nmRf6rd1q2v3mdeaVvPoMFJ/B02hxreogM+nCaK9lRfAcrvvr4dWI71HD0opDH3rp5yyKYK2D7rgnJxLvRERSGFUjtmweuiFfLSH5vkvCLQaBfFjoTf2uPyt91YECoYdfNvYOCQZO5Am7nuDr2pFQRhsv0qfuL0TL1KPo5FJk8PJEDqp2G3JFBnJhmpxiTbts2gL1n3Bmuax+XOlUcCbCWYXC4PzfRw19BGVBrZUQnz2avboNCrmE/h0MYNVYMS7CmSOOTkLr8FHp7bkCjceJZGujutObkH6Ss4R8MkUmMpTTn7zG06P+BU7O6QKuETgbVHFfWeVaN/ecvs46MHjedWurlEJTJ000SGzOIVtJL/l+cPBZuOlrXgsB9VJj9RPMv7TaG8ahSsYjSlLvWksuhVaWXdsOiL+AeMfkHKUgV0A1lmDLJtKfftC6QsttXCMhBPSRj0UkEh/X9oupCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39830400003)(136003)(396003)(346002)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(66574015)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFpIWlNtc2RzZUF0Y3p6NFhBMlhqd3FaZzh2TWVjRXlqVmhxZHZ1KzJTbFBQ?=
 =?utf-8?B?dGhoZit4d05RT3hRWjREY1dYbXV5a3BVSjI3UnRpZGRJZ2NFaWR4MHRsMmJ6?=
 =?utf-8?B?Z3ZQeG5EKzRIdWI2OXp4SkE0YzduZ3ZCTllkRE84OEhKNE1ieng4Q0poeSt3?=
 =?utf-8?B?MS9STlVyQTdINjRHbm9QTy92M3JNNVNNRFJ6aUQ3NzBwUURXeGVmUU83d3d6?=
 =?utf-8?B?bTVieXkzUEV2aGZkWHhOMnh4ZUNHVnhLZkdIZ2RDTjdDNFc1a085N1FyaWFj?=
 =?utf-8?B?eldqeUY3cEFmaHQrUkhTMWRSaUlXZzhtQUI3MHgzMnN4bzEwWXV4elE2WnE3?=
 =?utf-8?B?T2V5OHFlMGY2SjMydUlCdjNtVjlxK1AyMlc0Mk13WHJrVWhKTVp6WnAzKzI3?=
 =?utf-8?B?QWNZY1JyTjg3Sk8xV2Y2c1MvY2c2Q091S29PbGlnNmNTeHcwb3V3WUlxYVJO?=
 =?utf-8?B?d2EyejBabXpsbkRjY3hXaVVSdVd3MEU3eVRFUEVtRExCMTB1RE1xVUF1MTBi?=
 =?utf-8?B?aEZwRTVSV3dzYVE5RTJha3QyL1RLazdvUWxHODZyT0U5bEgvalBwS29yQUxF?=
 =?utf-8?B?cDZrTWJBRUt5T2crYTJRQjR5Y1dTTXFNazZhaVdwM0QxdWV2TzUzUXd0SnJ6?=
 =?utf-8?B?Y0cvcCtQeVNIdTJJUXFxQVB5TGpLblhETjl0OGVYSC9sVUgzWTc4Tm1UM2wz?=
 =?utf-8?B?eSsvdHR2SUVQeTZGL0tBbXlmWlhwMkpZdWNJZ1A1ZW42YStveTFWc1dWMXdD?=
 =?utf-8?B?ajFrL0FUNHI2V0NlUGJOWkt0V0p5bEpLNHpNUDFJM2k1ZEduRDl3b0dZNWdB?=
 =?utf-8?B?NlBxTEVTdGRmYUlQcHNQV2NscjRXOExxV05FRTBzYzNuaFVsRlp5ZXl2cVBL?=
 =?utf-8?B?Wkw5Rm9tRnl3WncxQ3BmYmVjYjN4aVUzdUNpMnV1MThQWnVBMnNwWCs5dmlj?=
 =?utf-8?B?cm5tKzVwTDJheDhuL0lrOHUvVjE2Vy95SjQ0YTlVWllqUG1qWkRWY0l0TmNH?=
 =?utf-8?B?ZC9UQms4MGk3WEdaamRXUW9jaVVPbStFd3ZGOGdCYlFqbzd2VEo3SCtJUUJ3?=
 =?utf-8?B?b1J0clV4KzI0YjFHK1pDZTZCTkdaVlhjNzhXd0pzSHM4M2RxaHpoSmRCRjlN?=
 =?utf-8?B?T1pxYlhLTmF4OU14S0hYWjd2ZjM4Q3RjTmFWMURldFVLU2tDajkwZXp1RzIx?=
 =?utf-8?B?eW5iS29meG1QQ0FTQzVjN212M2lQbjRxNlJWL0RCcWpqRm15bmZXQmxhc3BY?=
 =?utf-8?B?WlhaV1JUa2tOWVdDZ1h0U0dMR2JiUnJoRFNXYWZaaitNbnhOUmNETHBvNUlB?=
 =?utf-8?B?UmMwaUFpZ29TL3VXZ05NT01HM05PaUtETkZEOStra0ZxS0svSHNWMWxEdHRa?=
 =?utf-8?B?bXNlSUJBakFmOGFONUYvVG9NeFE0ckRGUkZRdytkOXQ1R0g3aDJtUExmd0tx?=
 =?utf-8?B?a25rYTZJWDExYUJ6dFlJNU50Ny9YZUdBZ2x4bVl1UzF1ZEY2aTVBZUtjR2pi?=
 =?utf-8?B?YTRzZXVodjA4YktMa1AwWTBvbEJLVW5OZlBXZ3hQSlF3bmZsNXJHUTdrL1la?=
 =?utf-8?B?amtlaUlTaEpUL1Q3MHlrTlQyTUtEdVRjZE90bHVaVnllMTNDWG4yMUJkb2lF?=
 =?utf-8?B?cnl2SVBGRWE5NzdrMVdDNHRFTitPVUpRaHVEK1BiU01pNmVwS2lCeFVkbitO?=
 =?utf-8?B?Uy9iTVpVNmUzUDR0Z0pIQ29uSVFxM05SbHoraEROem52ZlNKMkYrdXFUWEJ2?=
 =?utf-8?B?cDRVOHBnNytVYVhmcURpWFAzR3dSV1p4ZjJPSHdpdE9CN0ZhdjBDV2Y3cStp?=
 =?utf-8?B?MzJQN09xTHkrd2hwT2lhZXdxVW0za1ZRMDIyYnR5YTBkRXJ6VXI3a3FYL0ty?=
 =?utf-8?B?amREWVorL0pRenVXWGY0Unl6WExZRkd0YUtOYzFjSWt3QlcvNmdiNjUzODVs?=
 =?utf-8?B?VTlXOG1VVFpqQXpkck1zZUVxdmFRRkJ4VzZwN3BUbTdiQ2RXa29ZT0tXL1ZE?=
 =?utf-8?B?MlZnNGFKdU5MM1FEWnd2MkQzVmJFQ0tSaXl4NjZNOERwVTIrREN0bXFuT1Zw?=
 =?utf-8?B?OTFVUHN5ZWxBZk9GRkpTODhpTHJSSVNVUFFxQXN1UGdwYVRpa0UrOWdrbS80?=
 =?utf-8?B?RmozZW9UaEE0QVh6dXNBT2sxdk5uMjhGWnBOb0czQ3pvOGZJc2pNUHF5dElM?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0df09b-37db-42a1-3f02-08db9e66aaf6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:39:59.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaskNWxVWoBmYja990Rb/d6H5R4LbjclFCPRHPyjqUhQOzfY9ngnPKT5CKBxrcUQfGL9sjhKBMbcMyYy569TIMaj3NJEaHdQy6NqgcmwOgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4097
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tianyu Yuan <tianyu.yuan@corigine.com>

Currently NFP NICs implement single PF with multiple ports
instantiated. While NFP3800 can support multiple PFs and
one port per PF is more up-to-date, the management firmware
will start to support multi-PF. Since it's incompatible with
current implementation, the ABI major version is bumped.

A new flag is also introduced to indicate whether it's
multi-PF setup or single-PF setup.

Signed-off-by: Tianyu Yuan <tianyu.yuan@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c      |  3 +++
 drivers/net/ethernet/netronome/nfp/nfp_main.h      |  6 ++++++
 .../net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c   | 14 ++++++++++----
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 71301dbd8fb5..39c1327625fa 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -625,6 +625,9 @@ static int nfp_nsp_init(struct pci_dev *pdev, struct nfp_pf *pf)
 		return err;
 	}
 
+	pf->multi_pf.en = pdev->multifunction;
+	dev_info(&pdev->dev, "%s-PF detected\n", pf->multi_pf.en ? "Multi" : "Single");
+
 	err = nfp_nsp_wait(nsp);
 	if (err < 0)
 		goto exit_close_nsp;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.h b/drivers/net/ethernet/netronome/nfp/nfp_main.h
index 14a751bfe1fe..72ea3b83d313 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.h
@@ -84,6 +84,8 @@ struct nfp_dumpspec {
  * @port_refresh_work:	Work entry for taking netdevs out
  * @shared_bufs:	Array of shared buffer structures if FW has any SBs
  * @num_shared_bufs:	Number of elements in @shared_bufs
+ * @multi_pf:		Used in multi-PF setup
+ * @multi_pf.en:	True if it's a NIC with multiple PFs
  *
  * Fields which may change after proble are protected by devlink instance lock.
  */
@@ -141,6 +143,10 @@ struct nfp_pf {
 
 	struct nfp_shared_buf *shared_bufs;
 	unsigned int num_shared_bufs;
+
+	struct {
+		bool en;
+	} multi_pf;
 };
 
 extern struct pci_driver nfp_netvf_pci_driver;
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
index ee934663c6d9..3098a9e52138 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
@@ -59,7 +59,13 @@
 #define NFP_CAP_CMD_DMA_SG	0x28
 
 #define NSP_MAGIC		0xab10
-#define NSP_MAJOR		0
+/* ABI major version is bumped separately without resetting minor
+ * version when the change in NSP is not compatible to old driver.
+ */
+#define NSP_MAJOR		1
+/* ABI minor version is bumped when new feature is introduced
+ * while old driver can still work without this new feature.
+ */
 #define NSP_MINOR		8
 
 #define NSP_CODE_MAJOR		GENMASK(15, 12)
@@ -248,14 +254,14 @@ static int nfp_nsp_check(struct nfp_nsp *state)
 	state->ver.major = FIELD_GET(NSP_STATUS_MAJOR, reg);
 	state->ver.minor = FIELD_GET(NSP_STATUS_MINOR, reg);
 
-	if (state->ver.major != NSP_MAJOR) {
+	if (state->ver.major > NSP_MAJOR) {
 		nfp_err(cpp, "Unsupported ABI %hu.%hu\n",
 			state->ver.major, state->ver.minor);
 		return -EINVAL;
 	}
 	if (state->ver.minor < NSP_MINOR) {
-		nfp_err(cpp, "ABI too old to support NIC operation (%u.%hu < %u.%u), please update the management FW on the flash\n",
-			NSP_MAJOR, state->ver.minor, NSP_MAJOR, NSP_MINOR);
+		nfp_err(cpp, "ABI too old to support NIC operation (x.%u < x.%u), please update the management FW on the flash\n",
+			state->ver.minor, NSP_MINOR);
 		return -EINVAL;
 	}
 
-- 
2.34.1


