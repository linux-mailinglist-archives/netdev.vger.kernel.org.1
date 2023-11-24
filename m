Return-Path: <netdev+bounces-50777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA747F7166
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 11:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501F71C20ED5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD9C19BD1;
	Fri, 24 Nov 2023 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qMF8rF/j"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC41B6
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 02:28:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7gjoTDIUO88n88ULgZxhQpgkZYSLTxGzrnTH2EMl70BKw7rGMzlmGegqfn7GDlsgtErqZRTSL+sHrm7UV4Ceo59lQDF3W5sbjGvYLQbaIJAITMOy07iXkCxCHGM7PrcvTMOUuEAgn/lzI67YilWmXh+/dfpxbqeBrgGagk4J5GqLDvZGRdZ091mRekK/0I56+jY0rqFvttail7GSkldBhl43bezoNSAWDRCgAegIFlzqZuQxUF5LwVPFk0o8xpjz5+1S2rOYSBp6wUFLcGCPWgIIhfI8sIWjMHmMsnhyMLR2VfErctOuA62uyaniNbwLISNqLjktP36C8EgrvX2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmSMA/EVv93KJfmF8lrOZLwVdQZyB5RC+o/iViiPK+A=;
 b=L0w2A22HLp3hNIHOl6I2nE3dS+TXI2XNtXSM/7MOYDoSzR6nonpNH0AM2MDuQo1/ZfLWDHp62NbWYrYHo5woJfKSSLXQN1eURr2xGV7vktoPa5FgjRFUxbF6p4DPFJoQkKwzuCQ52z4ZJQxiiroZjpKILPmKJkOp6pSQsAQFvFGV+j8+ULIgXdXBjmW5M0qFVPhyrF0maeWHi+t5rNfnW7nOPREak+tapDk6YKjR/iuWq3d3O2xyXoimgrTK3/qesMFkhJj1tFf3NDAA85j1kjuxHPzi/UZ81SnlKi2WTaW3gwAqboahDeJJuYCggE32WKNAfOCOiEkRa4Vu93Fl6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmSMA/EVv93KJfmF8lrOZLwVdQZyB5RC+o/iViiPK+A=;
 b=qMF8rF/jQ4Z97umifATppXqgN1AuOpF9FNJnJ3vMBIczw0Ujax/h8S8uIGEsnOqELtHJhb0V+UxqeC2XjJ0KGSMSjr6aNXRoBJKpZH2b9cTMc90fccOvKAXCJRtfT8AVSLfl6F05DsUhwYS2du1irU/qs3L3s4aLmAQ/0xE8x/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS5PR04MB9856.eurprd04.prod.outlook.com (2603:10a6:20b:678::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.12; Fri, 24 Nov
 2023 10:28:17 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7046.012; Fri, 24 Nov 2023
 10:28:17 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew@lunn.ch,
	netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 net 2/2] dpaa2-eth: recycle the RX buffer only after all processing done
Date: Fri, 24 Nov 2023 12:28:05 +0200
Message-Id: <20231124102805.587303-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124102805.587303-1-ioana.ciornei@nxp.com>
References: <20231124102805.587303-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::16) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS5PR04MB9856:EE_
X-MS-Office365-Filtering-Correlation-Id: 4048a154-653b-42e2-0312-08dbecd81263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8NpJ0i0WlJsm/qkijIcYdcgvQBWMKfD7EJF30xJML+m0a3wjU/iZAr1ekM2L+bc+mstw09JW9Iy+b9SwA8sAMU1tDFRj3gbQZPtsjOfSEdnjp5mphznS9OaT7WBy38w2qEh0QmWF9vJAlBgoiD/vtGJa4htsSvQneui+6a47d3G+1XsyrqvgNcJVbpaYZf1L3LCJw5CbrclSJ6M9/eHBRg4pI6t8Ur0Gn6oH6HBYnT6BeuvNW5cf8cujFittqzqGj269mALPoy0WZyEKbUa/YYmpGz9mRbbAHI015ndXio+lLxmfKgxB0tEEMfA39LCjjWHkuVm5yPtSMwcHD+y571d9cTr0q6xNE73R0D64BMEQ8paKEqtJ0w0HtdnepdoFbZbAI2CAooKZIGe4usQckBHXWlJ9i0gEpb5ve7Ch7r0iqYUA8vThnqhO18ddk4g/E0bY2bSq3W48xIaFD9Z6eSNByEznrlRGWGSjnOPJsSjDZotqXMMNMOGnQMRGYIhZ/BSAjBqITcJk629T6GHIHdWqZiQqqiZXSI8AGX0Nhr8mwwCG5JCVETAdP0QACAc/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66556008)(316002)(5660300002)(66476007)(8676002)(44832011)(8936002)(4326008)(2616005)(1076003)(26005)(2906002)(478600001)(6486002)(6666004)(6506007)(83380400001)(66946007)(41300700001)(6512007)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+yoitIHTRV04lscdPn8s3GfddCPdf2mSvQtG4lz/OdmvQehd0F7IB3pT6WzE?=
 =?us-ascii?Q?GsAPm8Sx/ZqUYPCOxT35DsuiMKASpRAE8znF3keu1fgC6Bd8otd1LqiWUYn+?=
 =?us-ascii?Q?TzcHjeXLsqUXNtlkT8C3QQuHXyn1qhL+U0ZXe3yb9AplljVBHfTkaxSyBEP6?=
 =?us-ascii?Q?u+fAwRl0BsqqqMilOJCAHB1LwyqEz2YoAlqpyWNhUvtjj+wZgRKy732P8sVW?=
 =?us-ascii?Q?8vYGH3dXn8ehYMCqXpQFskZxDVTNaXZsNidLNfjWW+Rq8c4BBLe8kKT0KZVG?=
 =?us-ascii?Q?49DRnJVgGUK6Da5pCa4Z/zCWqGWa3tocL2bs7MbLG0hK25dEMXrRwj/dU9bR?=
 =?us-ascii?Q?oI2oxePHkkwLU0OlO2Bue5/tnuA5EZm4KLzwBRfEv0SxcWHo95J7Irl0Dyrc?=
 =?us-ascii?Q?P1o9tSVe/gnbLcQdYzBUtHf7675k2/w1f7g6cfaFA/i5DnYh1ZpCjpk3SCit?=
 =?us-ascii?Q?jesocdJqCvi0XIXPzpULT2octKKMaoNNnAEerpd55noecXGormgYS7m3SKGE?=
 =?us-ascii?Q?hNBPl2qR+MsyKZoHRNdPC2lTcGi8igQcPNforILQYE/734O2IBdrnGfT0FRc?=
 =?us-ascii?Q?6KPYmSlVTy5wbrPIif0b8LhkZ6dAvi9NfZTprDbn3QcIs7xpcAgx24JlXHdC?=
 =?us-ascii?Q?5YmfA8PLSeGw7oLpJdmWm8TtCaRtA155NIS2MNNmFBPpR3MF/3g2W6G/FiFp?=
 =?us-ascii?Q?/idsFCb0otjBDx029q+RZ2UC5+2UA8u5ndCyCvDiBHdGF/+MJQkoTmbyHiw5?=
 =?us-ascii?Q?YIxWK0NosIh8SBULtTHkCAduvMWlXTyUvs56hlsuH2SIXCrht7T7rrL+3VU2?=
 =?us-ascii?Q?sW+WSNgYWxlvs4xyr4f8J1ztHMOdsQUoJ4wAwiPx+TQDHAd1PQXL/UulhfrB?=
 =?us-ascii?Q?h/DxDfzSMbqaHl72MNO9tcjn5GgFbGCwBzkswD8MUR7iSpi/A0c4Us1jY9Lq?=
 =?us-ascii?Q?eHzOVyIac7/1okzUOUGd0bHVnl+DdAxM6qnf9On5u6r0wqxKFEph1lezkE7+?=
 =?us-ascii?Q?k6sOHuAUOaXQm+VpuTFruptmi8pnFxg0ed9W1AFLq2OG82Lwlo6cUdbvMMGZ?=
 =?us-ascii?Q?uGoq1lilPhTXm2UA/De7Kf+m0wCEqHyt81G5hn6ceLcnE6hwF2PlGBlylIgF?=
 =?us-ascii?Q?fMRkt7s6ETO71Lb/B17fQp6EfopicvD1U7KZ1iUq1kc1SAk9bq9uLd87FpQW?=
 =?us-ascii?Q?PAdu5VQcM4Hz+/NcGR4QjCTGRZdVhFcXfkDV5Cm1LEzkVRPFH7U94tRQr4aX?=
 =?us-ascii?Q?NRk+OfToov9ftwxDq+1RcK6nnNK9ImuwM112QjaPwdVFqdQviAEi61ADATOX?=
 =?us-ascii?Q?UimmMo/v0MMXpkEZf24K69MAS3HrXlKB6xP9qMhcqpE7RYYH8j0Jm2U98PET?=
 =?us-ascii?Q?sxZkRd35aDMZA3tQiI47TsbVk8J7XcKB/s7BSoJfHlS784/E89hHRV0KRaLG?=
 =?us-ascii?Q?/ktykOB4u49rHi6bA+rp20RSZwjS/VfrhV6293aCCPtxKpIgJS/+z6ArNeNy?=
 =?us-ascii?Q?RQEC6sthfC4+zWLYEQo5KYNC+iszi5QXD6NDonGk8bB7beDuJiBLZslWmAkF?=
 =?us-ascii?Q?0OP7zlUtlr31X4u9oap8+WV6W1gO6kiXcC9jCQCE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4048a154-653b-42e2-0312-08dbecd81263
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 10:28:17.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyEQs/fDpOkWozJ5ziImbtk72A6ExE+A8Hq1CYWsomGvIcAsbbdXgHT8x+/zq3txcJ9NC+WiDLh1+lbb7qVqrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9856

The blamed commit added support for Rx copybreak. This meant that for
certain frame sizes, a new skb was allocated and the initial data buffer
was recycled. Instead of waiting to recycle the Rx buffer only after all
processing was done on it (like accessing the parse results or timestamp
information), the code path just went ahead and re-used the buffer right
away.

This sometimes lead to corrupted HW and SW annotation areas.
Fix this by delaying the moment when the buffer is recycled.

Fixes: 50f826999a80 ("dpaa2-eth: add rx copybreak support")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none

 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 774377db0b4b..888509cf1f21 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -516,8 +516,6 @@ struct sk_buff *dpaa2_eth_alloc_skb(struct dpaa2_eth_priv *priv,
 
 	memcpy(skb->data, fd_vaddr + fd_offset, fd_length);
 
-	dpaa2_eth_recycle_buf(priv, ch, dpaa2_fd_get_addr(fd));
-
 	return skb;
 }
 
@@ -589,6 +587,7 @@ void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 	struct rtnl_link_stats64 *percpu_stats;
 	struct dpaa2_eth_drv_stats *percpu_extras;
 	struct device *dev = priv->net_dev->dev.parent;
+	bool recycle_rx_buf = false;
 	void *buf_data;
 	u32 xdp_act;
 
@@ -618,6 +617,8 @@ void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 			dma_unmap_page(dev, addr, priv->rx_buf_size,
 				       DMA_BIDIRECTIONAL);
 			skb = dpaa2_eth_build_linear_skb(ch, fd, vaddr);
+		} else {
+			recycle_rx_buf = true;
 		}
 	} else if (fd_format == dpaa2_fd_sg) {
 		WARN_ON(priv->xdp_prog);
@@ -637,6 +638,9 @@ void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 		goto err_build_skb;
 
 	dpaa2_eth_receive_skb(priv, ch, fd, vaddr, fq, percpu_stats, skb);
+
+	if (recycle_rx_buf)
+		dpaa2_eth_recycle_buf(priv, ch, dpaa2_fd_get_addr(fd));
 	return;
 
 err_build_skb:
-- 
2.25.1


