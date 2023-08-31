Return-Path: <netdev+bounces-31627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54E378F196
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 18:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E4C1C20B01
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3600418C21;
	Thu, 31 Aug 2023 16:59:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE48F57
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 16:59:13 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB18F
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsH34fydANe1D5ewZpURkDVhzDpnj3MOgNyaj3wI8NlaG7U1Im0uDe8zuGMHhP+WJbABzqFdIkb9mJSMg/jbAo/tNtlCCunOyC0S87tUZe8WGA60zqOF/5g0KWMjOjjKQQ+eSrchO8YEbujCiFn2mrdxw2PjHwjjAP7/HMaiYYd4t8X519DvRDtBHALqM5A5O+IxRBOm0nkdWjWPX3hNVb+Nl8bCS6WBv0CwjXcCMksquumRCmRWEORkaYLy1L2SKoHQQatJOFxPkaH12JNQMKi1UsiKZousRJkTez+oPXNen1E2/ouecmtYMHiffHAjurF+46cJyjtfHbzjyD7DEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2M+6FuvC+e600aBNTmD1KotH3+29WWCz0fWh/9s722s=;
 b=QgHxsiCR4LXUYbR6nN3z4qsXERqFF29dybOLqmPgnkVSFJE/t34VkCuHN07I6EhelZZWCR9xiLnTX/BmAvG/6CksPrI6EKWQLFSOuqm4kZY2be44VG345RJQRdLVFTDDFFymvzvK3qBelYFRm14+7pEswWXepV32uv7FyxBaHK3U9yP4U4xpIyMsL+oN/hbCWL3leRv0N2rgKSt+3G3kOjmJQRfJUOFGwNDxNSOkGxTn6rS/E2PqMzlM3Uks037f8EJwL4Qlc86RP4hhQZWSpJDifjV+z8FyseE7KDrM43GpU68Oc2N6tzFoWjyvJI20SAJ/3L8zHClKC+XIsmjuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M+6FuvC+e600aBNTmD1KotH3+29WWCz0fWh/9s722s=;
 b=ubOAJbEsCaXCFwWZCM3t1bASl0sff3A3r88fWPsYBiwd3r1YyLP+wBMZKhzm25FlEH9FY+mLziI86y10zLHrsemweLncoLZ1h5xg0oP2FiylcI9JKpuT/3PPdcq+txdPPseMJBwS7+QWHKcl/uy46vnn4N/UGU0e+GPQqbzSI+M=
Received: from MW3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:303:2b::6)
 by MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 16:59:06 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::7) by MW3PR05CA0001.outlook.office365.com
 (2603:10b6:303:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.15 via Frontend
 Transport; Thu, 31 Aug 2023 16:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 16:59:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:59:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 11:59:05 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 11:59:04 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>
Subject: [PATCH net] sfc: check for zero length in EF10 RX prefix
Date: Thu, 31 Aug 2023 17:58:11 +0100
Message-ID: <20230831165811.18061-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|MW4PR12MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddc794a-a22b-41fe-5ba5-08dbaa439675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ySJv20TJnvDuTOzINhDV2EXo1G0oh9DWVvp2WD9aCnSyu5scPHQIH0MUzZJKwu4MWEGF1m7go1DiPAMPnhB1K8lq+0p1B/YcDTIoU7d2VXtPlxNUu/ST6zrT1YtB94igbNKld0LsDJRs2lu0Tq/QSmQbkvbyFn5gAcADGYkWTdw2DIC1fXOzkXE2+99sRdFp2FhytP/r51KCLk5dyIs3U5yLWQRc3zSv5GbBIgf+8hPVmdijBWRcWC5ACXPA572SQQ2c0v3rlmupmKVOq5Xg66ia8pY6+dOVhSEttiiyOCUvt8zQQcNLLloR1GKo9bCTGoZL9lL/d8qpBEPJilPf2bwq6jrdcoeqopNqYAiE0OBL58PJpV+IZmqznaHsLwRipADCnRUJ/ZEiCGzi2d+ec0smUdkwK05xKIc9gz/WJWjejbAEyCtLjmirXsSF0FVwaU+dVr+IGaEtiMECtoiQpOPQsdlNZZPN/49ggpypjY+ArJJhYsBbEjGGj2NXO6saPPaTmuQ4n6InOd1Cmj1qnjB/fAoitR1t8j7GSFHJtDxVUKZ8dkqm5ga5jjgi8ChJq/RT0uMDp/Y5jitSIKpsUrvTYWIVkz1u4Pq7gdzLqFCH1AesUlfBbcm6veX8mSHzmshKrEVMFJj9kRk9mj+PgwLLLTmBmzyDikFGQgeq2s90DmUoVGZLL3YsE44Vm4shhLKz4O1OCFONkOmy/MH+vVP9YX0RZOiK1C0VYQmpq0m6Zz18ZGnlxQaBRdJ8eWaW3nmRedEBpkFBt28pXq8eWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(82740400003)(6666004)(86362001)(40480700001)(1076003)(36756003)(47076005)(36860700001)(81166007)(40460700003)(2616005)(356005)(2876002)(426003)(478600001)(336012)(110136005)(26005)(83380400001)(54906003)(5660300002)(4326008)(8936002)(70206006)(70586007)(2906002)(316002)(41300700001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:59:06.5455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddc794a-a22b-41fe-5ba5-08dbaa439675
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

When EF10 RXDP firmware is operating in cut-through mode, packet length
 is not known at the time the RX prefix is generated, so it is left as
 zero and RX event merging is inhibited to ensure that the length is
 available in the RX event.  However, it has been found that in certain
 circumstances the RX events for these packets still get merged,
 meaning the driver cannot read the length from the RX event, and tries
 to use the length from the prefix.
The resulting zero-length SKBs cause crashes in GRO since commit
 1d11fa696733 ("net-gro: remove GRO_DROP"), so add a check to the driver
 to detect these zero-length RX events and discard the packet.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/rx.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index 2375cef577e4..f77a2d3ef37e 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -359,26 +359,36 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 /* Handle a received packet.  Second half: Touches packet payload. */
 void __efx_rx_packet(struct efx_channel *channel)
 {
+	struct efx_rx_queue *rx_queue = efx_channel_get_rx_queue(channel);
 	struct efx_nic *efx = channel->efx;
 	struct efx_rx_buffer *rx_buf =
-		efx_rx_buffer(&channel->rx_queue, channel->rx_pkt_index);
+		efx_rx_buffer(rx_queue, channel->rx_pkt_index);
 	u8 *eh = efx_rx_buf_va(rx_buf);
 
 	/* Read length from the prefix if necessary.  This already
 	 * excludes the length of the prefix itself.
 	 */
-	if (rx_buf->flags & EFX_RX_PKT_PREFIX_LEN)
+	if (rx_buf->flags & EFX_RX_PKT_PREFIX_LEN) {
 		rx_buf->len = le16_to_cpup((__le16 *)
 					   (eh + efx->rx_packet_len_offset));
+		/* A known issue may prevent this being filled in;
+		 * if that happens, just drop the packet.
+		 * Must do that in the driver since passing a zero-length
+		 * packet up to the stack may cause a crash.
+		 */
+		if (unlikely(!rx_buf->len)) {
+			efx_free_rx_buffers(rx_queue, rx_buf,
+					    channel->rx_pkt_n_frags);
+			channel->n_rx_frm_trunc++;
+			goto out;
+		}
+	}
 
 	/* If we're in loopback test, then pass the packet directly to the
 	 * loopback layer, and free the rx_buf here
 	 */
 	if (unlikely(efx->loopback_selftest)) {
-		struct efx_rx_queue *rx_queue;
-
 		efx_loopback_rx_packet(efx, eh, rx_buf->len);
-		rx_queue = efx_channel_get_rx_queue(channel);
 		efx_free_rx_buffers(rx_queue, rx_buf,
 				    channel->rx_pkt_n_frags);
 		goto out;

