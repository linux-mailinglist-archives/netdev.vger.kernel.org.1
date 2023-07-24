Return-Path: <netdev+bounces-20313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD21175F0A0
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637A1280633
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04E3746A;
	Mon, 24 Jul 2023 09:50:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBCD8BEC
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:50:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F074C1E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niMDcHl35wfPvLsOGaZheTzxWkVdYUP/f9yksYJdZnrKgylmN3QHdQVmuhykU/cl2/0dzEkmHr/4ZL8/yPj23+DJnOdAGbg7IZlXX3ubmx4ARcabb4zGi+AhMYJ71mvlCc0jDRD6+rmOoRsaV7wFO9ZsLEOm6VrtfKlRR1l5YYH5SqIzqfLMYsoXgJYq18GAPWas7qNb+SKTSGXsQZ2RX+2n/hJpswJ5Gjes2jF6+JVbXG95Lb79/kuKe2mkvoMTntcgSzB7gyAJ9zZ9lzipiH+cdotIVGjgJrCnv5RlKynUW6iXxbZ7rrurwYALlyPIzMTIqJ7lz2FJPAfSii4V7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FZVL/j4FDj/1aP7aR7UQG9bAUo5CX//evLuUIhhCyI=;
 b=l912HaU7vvBFb4NIDYRmX8INvZvVYfUfDO+u4XDsXBx0usndbkeKs6twwuBo6N6z57TTkZgVuVESftDBJAOvLkr0C854D7EcDbw0bmpYqQkeDj1Tzzy0GdZsVHvq6OElStBvl/mQoNRH+6kjeniC7N9/vTR4eoK5VcbvlsOvCrZNqCyt6K3fNwHQIzZznpVX1ErXKnnQARrNiMfXFcxV2bEzSlbZ5ovjc7NF/nO4IA2vY2CTJu/aHJEjfYqAmf9kBS5FS28zY//hhFcFqCsfWjdq3+gbuUYlNZLqL2QK/9wERNZQWO12ChoxH/20HeR+aotJC0poxzWb/ct9oDabxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FZVL/j4FDj/1aP7aR7UQG9bAUo5CX//evLuUIhhCyI=;
 b=OoIv/0PITsYU9v85SMBGS12DBW40roUdNOedY2oOALTlj5wJkza2akkls5ItX4QeManpJFP2T6T7Vk8I1b0JWrpF9W5Q/mZVDNZF7D00by/0SrSEcoGskzE2Glhl/VutL2MMH+gjz/aEUw1/h4vhEXPc8CiwU24HkxIR+5gCjyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:49:01 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:49:01 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 03/12] nfp: change application firmware loading flow in multi-PF setup
Date: Mon, 24 Jul 2023 11:48:12 +0200
Message-Id: <20230724094821.14295-4-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9bd6115b-4860-4371-363a-08db8c2b352f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yR0qyq40KzfbuXzRF/SrQZ6CGb49xDRD/m/dHCqBswdeTCm+umU7maCQTyhQtyfjJ0heMT6eTB3B6u5e0sV8Fj9MO6mCEKWEb094XBR4INoMXCTcQ14Tq/iie5s0R7oTU78RovkPMLVIKtEOfaFb/G/usyPeZWQxGG5OjDnLmX1MRV0Lmy9iaZAvfBEsODFsx+5H6iU/SaDtn743PBRwhKkdJSf94LRYpZwbE55tUU4sPM8rLkDT42RyCoAWV4spBEx8VX0wqBSGWOEyriKWhm9vLgHQznoqM0Wq/5lN/t+Mpqz0j/qpgxbQJhnrFgpnSshwxGDS9U/Hq/nbz38DO6AvwP6NjY7+UAl43oMKTNzys3vM77k27ISt7rsj6Rn86WQQkzbBauCLR9rLgLXvDHkdVjO9PAScCAPXOeBgutHl0sg2+n3gMZVyeGllxYesCfePw0GDtx8GeHIPgnYIUbwWO1cxpjR9ntcLZE4ki0/KTCx3skRE9kL/BZguVXIYf0s5S1il6KgyLrfApwMeUi7DJuKJ2wFWlrDwirlMhyIHUOd4hkDllRtHjYdWGzkzLrAOOD1AysAJmqo9/k1pfAQK66dYwG3Y9X3AwDKZv3Ib/cGtBHra+0W1Mla+7mdtGY9ibNjNq8qOY/9FimlJybORXM6hhg2cjjuC0fd34Qg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(6666004)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(66574015)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDJnaVRMbFVLbk9RMFVwR0NJNmw4QUJTdDQvRjJGaDdoc09heU9mbTdYdzJV?=
 =?utf-8?B?cno4bXFtTDZZNmJLVzZnZFRoYXoydXlXV0l6cWd0M0xlai9vMnh5S0YxbDNT?=
 =?utf-8?B?RUtVNE5tbGhBcEtBKzdkM1dRMnNtUHcwa01DVDhtbVRMMmU2WG91VEhxUjE1?=
 =?utf-8?B?THZYQmlXQmxjbnZuS0VJbE95UDlwY2g1bHNKVklscTlnbXcvdkZkOGcvZXBP?=
 =?utf-8?B?S0JrOUZxQ1labVNRUGl2a3pRMHk4Q2hGV3hCZEcxNzQzL1gxZ1FuWnNVaTUr?=
 =?utf-8?B?QWIyOWptUGFZQTR5a20ya2tzc0ovSmJzVlVTbmQrQVhNNG9aTVMwOCtTSUJI?=
 =?utf-8?B?eTJhSUNIVXJFbUkwRnd4dTBsdkJxNWM4dkhRREt3TjB4VGltU3pwYXNqZkJY?=
 =?utf-8?B?eWFscllMb2g4K1dlbzhha29BOVpaMENSR29lZmNQVVppdFpoRC9kcDRteGk4?=
 =?utf-8?B?Z0hqd0c5R1JuOHd3RFZZekVxclBHbjQ3blUrdEhaWkIxelJXVldHMFNicGdj?=
 =?utf-8?B?M1U0NFptZDN6STFJYVNsbXc5eERVTXVIRDJkSEFuRnpGdGkyZ1QwWEZuSFUy?=
 =?utf-8?B?WlFwMWVHZ0ZFdUxxWU5BSXRLaEQ0NFNGVzVSUVpLd0orU0diQmVldTByblBD?=
 =?utf-8?B?N2tZYzdFUkRqdGI4SkYxVUNnRCtTNWd4Mm9SaXhmalZScjRBMjVlUHFjU1N3?=
 =?utf-8?B?Q0JZcXAwMkxVSjdtOFFEQjZ1VzdRd1laa3k5NFJ3TlVnN2RqWFhrWFh5eS8w?=
 =?utf-8?B?ak90bHhNNVhaei8wMGM3bWE1TklsQit3cFRLMVdvTHowbi9NSitpc2xDNk1l?=
 =?utf-8?B?U1JCdk9FVVZhaHYwQStQR3pJMGZiOElSbUZVS1lPSUVEY0JldjBzQjdQNkQv?=
 =?utf-8?B?S0pYa1FaSWNtS1NXL2RHSDJ1QkppWDA4dmp1RnpkL0lGenJuV1BHWGQ0MG13?=
 =?utf-8?B?NkJvRkNzcUdDQlhXb2hxcXJrc0NKbXV5c0dld2k5QzVEei8wbG5VYytCdDNQ?=
 =?utf-8?B?d2c2WUxvcnFRMmJqTE9udjlpTW1MOWdJOGk5T1JMb1hTcmVWL3dPb0pVSnZo?=
 =?utf-8?B?RngwUWRNaWxZQ1lmc2ZTdG9vK0dYbTc3Z011b0xueGVKQ05zQ2R3QWtBMXYr?=
 =?utf-8?B?Vkd6TG5RdTNVVzVYUlFwZldVZHY5b3BEZWN6d2tybXRDWDlGbnZxTlI1Y2xQ?=
 =?utf-8?B?SUplamUvUHFnOGNuT05VM1VYTDl2bGFaSnc5S05vY0hwbnBxaTBEVlA1SWZG?=
 =?utf-8?B?YjNxUGpCajAyMVhnYkp2KzgvZlpVdUNHUTRrZUJaYVBkUFc4MXBTcXN5WnhJ?=
 =?utf-8?B?bWdwSVBjQkdJL2ZSWTZFZzJVUTZtZ0V5KzJHNVEyZEFPWHY5TXZKSlQwajJO?=
 =?utf-8?B?cUhUWFRRcC9qeWRHcmhHWTZweDVPa2JBMTV6VVpGR0xCSzB0NytMWWFDellY?=
 =?utf-8?B?STczSW9QSkkxTkoxQWFyM1ZvN3ROZ2kxRDk2TUI0SDF4VG1rOUcvM09kcEZC?=
 =?utf-8?B?YzNtN1VidTB1dEIxWHdhNzZHWVdJN1FJRTdCVXQ1MlI1VmdHdkRad3ZCdVkz?=
 =?utf-8?B?dDBTRTlDL0tJeE43dkN6cENpSkFCeWQ5dzZHd1VtZ2dMNXB3NzlsSVd5a1Aw?=
 =?utf-8?B?Ym5yc0hmcTNMRFRJNmlJZjJ1bWhNby82QTBxVXFNb0FKSjVNM1JySldYcFVC?=
 =?utf-8?B?TENkT2s3SVpMOEdOTzJ0RjJza3NTL1ZrbElLYjlONVNIMm5iVGx1TEpsVG5k?=
 =?utf-8?B?MVdONGxSOEdlTzIxaXhadFpYSG9GV2F3aHJzMkVTK1ZsaWRGZ1lNRDNHR3Bi?=
 =?utf-8?B?K1BBOXZzQXBENmpCNXB5L3Arb1Z1eUlaMFp5a0NYaGg4SXFQZngwNTRudlBa?=
 =?utf-8?B?WFhpUmhxSFJOeS9TUGwzZEpoeEl2ck5ObTlxV0NKd3ZDYlA3VXp0OGdMcUhH?=
 =?utf-8?B?Z2Z4djlDclpHZXFMSW9rMFRMLzJEUVpQTThKTEMrOUk2UEFVQnZudXZWU25i?=
 =?utf-8?B?YkJSUEtzV1B6VmhFSXIwRW1Qc211SE81dTZwRnF6NXBZeXpMb0NPMm5tQndK?=
 =?utf-8?B?VEVsV3VlSm53VnVrR2c1bmdNRkpHUUpLQmRWcjlaRGFjdkI4cFF6SXZsN3pw?=
 =?utf-8?B?UVZjQmlBellFcjdmaldHbW9qLzhYcjJvSjZXbThMMkFMeG1lMUhIb1BjaUlH?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd6115b-4860-4371-363a-08db8c2b352f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:49:01.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJlcYUUr+gRH9KVR9EarUsrllbmtAXg/fszkQASDVpCnq07OBOmA9ECYizmuiidwwD4b8SrMxtJjO6T6olGZl/kqaFwZ3lS8B8196BViPfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yinjun Zhang <yinjun.zhang@corigine.com>

In multi-PF setup, all PFs share the single application firmware.
Each PF is treated equally, and first-come-first-served. So the
first step is to check firmware is loaded or not. And also loading
firmware from disk and flash are treated consistently, both
propagating the failure and setting `fw_loaded` flag. At last,
firmware shouldn't be unloaded in this setup. The following commit
will introduce a keepalive mechanism to let management firmware
manage unloading.

The flow is not changed in non-multi-PF setup.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 33 +++++++++++++++----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 39c1327625fa..c81784a626a6 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -528,6 +528,10 @@ nfp_fw_load(struct pci_dev *pdev, struct nfp_pf *pf, struct nfp_nsp *nsp)
 	if (err)
 		return err;
 
+	/* Skip firmware loading in multi-PF setup if firmware is loaded. */
+	if (pf->multi_pf.en && nfp_nsp_fw_loaded(nsp))
+		return 1;
+
 	fw = nfp_net_fw_find(pdev, pf);
 	do_reset = reset == NFP_NSP_DRV_RESET_ALWAYS ||
 		   (fw && reset == NFP_NSP_DRV_RESET_DISK);
@@ -556,16 +560,30 @@ nfp_fw_load(struct pci_dev *pdev, struct nfp_pf *pf, struct nfp_nsp *nsp)
 		fw_loaded = true;
 	} else if (policy != NFP_NSP_APP_FW_LOAD_DISK &&
 		   nfp_nsp_has_stored_fw_load(nsp)) {
+		err = nfp_nsp_load_stored_fw(nsp);
 
-		/* Don't propagate this error to stick with legacy driver
+		/* For single-PF setup:
+		 * Don't propagate this error to stick with legacy driver
 		 * behavior, failure will be detected later during init.
+		 * Don't flag the fw_loaded in this case since other devices
+		 * may reuse the firmware when configured this way.
+		 *
+		 * For multi-PF setup:
+		 * We only reach here when firmware is freshly loaded from
+		 * flash, so need propagate the error and flow the fw_loaded
+		 * as it does when loading firmware from disk.
 		 */
-		if (!nfp_nsp_load_stored_fw(nsp))
+		if (!err) {
 			dev_info(&pdev->dev, "Finished loading stored FW image\n");
 
-		/* Don't flag the fw_loaded in this case since other devices
-		 * may reuse the firmware when configured this way
-		 */
+			if (pf->multi_pf.en)
+				fw_loaded = true;
+		} else {
+			if (pf->multi_pf.en)
+				dev_err(&pdev->dev, "Stored FW loading failed: %d\n", err);
+			else
+				err = 0;
+		}
 	} else {
 		dev_warn(&pdev->dev, "Didn't load firmware, please update flash or reconfigure card\n");
 	}
@@ -575,9 +593,10 @@ nfp_fw_load(struct pci_dev *pdev, struct nfp_pf *pf, struct nfp_nsp *nsp)
 
 	/* We don't want to unload firmware when other devices may still be
 	 * dependent on it, which could be the case if there are multiple
-	 * devices that could load firmware.
+	 * devices that could load firmware or the case multiple PFs are
+	 * running.
 	 */
-	if (fw_loaded && ifcs == 1)
+	if (fw_loaded && ifcs == 1 && !pf->multi_pf.en)
 		pf->unload_fw_on_remove = true;
 
 	return err < 0 ? err : fw_loaded;
-- 
2.34.1


