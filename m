Return-Path: <netdev+bounces-288833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B2ZIlmCCmqv2AQAu9opvQ
	(envelope-from <netdev+bounces-288833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:07:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D2E565508
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B4C630421C4
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C835381AFC;
	Mon, 18 May 2026 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BSXl7C10"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473BB380FDA;
	Mon, 18 May 2026 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073417; cv=fail; b=vFZVrAeVjEPdIJZzLer2lqCDPgbz4vZiHl5AKw5rIq3ep0gztABb38kMlQ3HCbgcIZfwniRXobTLO56braeFN0uN1jgkSG5gCBXuSFYUhgh2Eq0+/T64aGgfPaqLS39A862AyrD7v7UoDbQamg4yWg8u7S/U1Z7mrSxfa4zrJqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073417; c=relaxed/simple;
	bh=WE6iJafBiusR3LY99chhahS9ko0WQ5gRi+95vboOm7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LL8JTgxRCVHdYDFHPl8diPLlSDEViOCiDMAoBiYke+nwOZdsCOf+usOkcptPK2UREnugvVGFUEb/odHI9yLmB9dSis9+kCewNIDBgF0suQ9OH8P6jYG/7qrSzXuOlQmn+KgLtvnEI87hIQ6sjBdorfZsHs22GX6acbhteNzcO1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BSXl7C10; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACsYhEoB3xqh+ALsz83tMc84/Q/fAYEz9tpXaUpbY4wKYFSm4b4VmtjksVyWQY1VDSZOhbB6ldIX4OFjxPJ+qyO2s150BzcPAXqfvsLOhMtWU/sfECIboHQcqvbUDeXpimDznOWjqTLaUSC+NPfRs3CiE3XejbGHe+pyIxFIz6zcQBppCNLndjj/7gngK+9anDM717+n7aeO9RvOuaadZ5e7bwe6MBZHxIx19Gyzv+IloHzLhgGlVHvrqMoWJLFc4bqKx3YKQwJQQa9VO3ivT7QadzL6lCP2D2LnQrF2CkmuaL3mf59mnWyPY1X5a2ZvTvZs0YtvRNnoi/Pq/jEH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DB4nGfWo/Zb50+RwNjO0dDJAaf7y3yEWbphL3fzw4JE=;
 b=vOsTLlN1uCrkoLbthQ5AWO1xWfJ2q+/s1RfebArY2JB4/BVokW3MCvbab+9bye1EunvWC6eA4HbPTDTXz9vIiWJ15LOGTOrq6SbfXERdrHRdgI47UvKEZ84LbBhIKc6tLDHjibHc/g92p7Arg6BAKfbHTqs3zFnOQvH9vkniz3NwiYNZAyz7qCxT60QASNKa4xsQqL7K4mh4/Dh9TdWmmn5QWZTzAi4K/UNk31SaJF8RSeIigodMMNixXgzgoYng9OPD4g9AJftuGu7iV4yLoo38bR49Fgd7oy0K7chs8TbCeO4PLE2LXz0RCltumU9VL3kDwplNXInSaTswErKh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DB4nGfWo/Zb50+RwNjO0dDJAaf7y3yEWbphL3fzw4JE=;
 b=BSXl7C10vd1QZxR3YohCJTpCno6leXLog9wsK7KxVaejD/6wNXatXZPUom+gMw0QDfc18C+yygpcSznp6yxVZBtCYgYtZr8RNRco5+bW+uTMVq5xWLex7lAMH6Kph9Bms5KYu3oNuLNjRHQ5PKDRqGRgeKp9ORxW7izEwnDyqBKpXzSZJgVhnAF/nJdrZELFFxDAHknWcM/iV990xWWWWqO28Z1+tE01tqx034yPcvkNGA5dTwrxH6OEWrpjNkJwP/W25/4/x2KCjYCzLtWVt8A3OpfmP7UHhQHeYgj+fgcfnFNMC5Qsx5QgUBdd+6GiJl5dm98yRoX10aBBtI47Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA3PR04MB11180.eurprd04.prod.outlook.com (2603:10a6:102:4b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 03:03:24 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 03:03:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v2 net 6/9] net: enetc: fix DMA write to freed memory in enetc_msg_free_mbx()
Date: Mon, 18 May 2026 11:05:32 +0800
Message-Id: <20260518030535.1057228-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518030535.1057228-1-wei.fang@nxp.com>
References: <20260518030535.1057228-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA3PR04MB11180:EE_
X-MS-Office365-Filtering-Correlation-Id: c6162507-ee88-4ed2-539a-08deb48a06c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	6mJy9CI2unz8jnnUL91L9Wu9BLGh/1h6ASKYJUp+jY7E2X//pJEtRWRxX8F848GvB44rVXl7zbfM5bxIWTe6HLvgRj65UZ9dF/SgLYyXiycoklSCFT28f9iWouqa9IgsfAwoC2bX+W+07MnhBrbG/4V9y9YVgZbJ2RQtAPm8h8HqITgSyCjdgwumkyT9fKwOhMi4mZOvx7ZnFN3KdypwXKLciwkJcJHBk3bM6ZN/77UqGMYqjRoAZK9ivkinbvlD9wYFhuzMkJ0YB4nrcWFHzT7mjbYvLHGPK7XwQm0C3s0V5E+DZ/G/2WwiMlYfaB6ERTdf9GujcYW5w5ToIjuVSN8dMN6pCLcKxYP4y0F8w2J3GpLdWeTAU7ox8nqRDbLyy5okHawZYbdr/Ui2uvy+Q5Lcm1eMW8ckdVfc6Ovp+aSuJcW5oeBHr3Uhlc8Ady3lIoItNFwas9oa2e7UOFeS7P1t/IzL3kgQmeQil5sBRgt5Ev85PGKQuSYFAWh6rwgiT5EUISC0X1xGvLpxkjeLjrPhoXh0FWf0/61BaWUs7JGqz5JPh5E5sjlbcDjOmQpWndjCdVhzeCrrA+pmTMVgmgzYSEunAFo1c5OOzXWPBtS3bTLRPevPcK0MM/vvpKvomi61nhkNu4APgpysnDMTbD1DSmBZntZ0WkKNYb3W9Kby6AvOmepyoA6c8RO6CeForrE8UCfCiBPPQcMThKY2SQZRJnxGkoai0iz1BBanh3zcOo2XcEAEkczjP54kK43+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7LjjWgxwizyRMirOHu6djmHxmUj6fpCYEhZQRlGklzjmS07he1jnvVaLEDA?=
 =?us-ascii?Q?NUdtKrv+AnzdBSRZP1EbZGnCE2mtRCwQ+PSYyfwFybDRpvVPshSzNpmx1Qww?=
 =?us-ascii?Q?pfzI3A6eOfXT0Wq9mTjpdWBxEq6pn4X7Q1P/eBLjCcIVZzVL6jhaaYf3gKJy?=
 =?us-ascii?Q?CwKWpn+9HN9jxotH1Xf/SPj4khacfVQkhF+k0DkUtEY3b6+nciOgDeZX5+wo?=
 =?us-ascii?Q?oKiNzDa6T/mIV9TFl7E8hIzVXeB9TFMa4fTeQKzn79Sv6rTJAyUc91pRmH2d?=
 =?us-ascii?Q?M8YFQRPXiEzjoCiVjLm8ZnSSLbf6nNwW+VjKlX6H6Jljw3TNRnxSzglvQP7b?=
 =?us-ascii?Q?M/YPPNGmYcxrAdRJ6/bpKd1hkjB4Ogz6eW+kl7sgsvS0Nem9psu8cPN5PDf+?=
 =?us-ascii?Q?IbfnqA0arJ1fm8cra4R1Cw9TznE8au6pRVf/u0CvbyjfJx7tryy+2v+bEvN5?=
 =?us-ascii?Q?4BXwst34Ve748r2uZLzZ6WaJmtYXMNYVOMoaEBAL3NB5OYcTclO03l69wxYS?=
 =?us-ascii?Q?UUzXJh5zfyTpP2eYsuqDDvHuE+2v+TT31EFnC5Sd4eetUQ2f0lX6YW0eCGvU?=
 =?us-ascii?Q?77MuVK/o4GGVIjLTrtWra2pcvQ4Po7AJlJZdjUiD1Hl+wWQ5sABLxOa6GULN?=
 =?us-ascii?Q?iItbjQ46wrPf2Jj1IExnToK2n7DhWsDTztBpZe6I/dqD8ErabH/nVyCRjaX1?=
 =?us-ascii?Q?c/zsG8kZa4gYovdGpxyQ7QJ4LoLagBHepHEfDSKC2RA2JMJSsTLwmawWHHZ6?=
 =?us-ascii?Q?/snAXZ9vp7ndkZjwWf1xHK0Dh30TQAkbrQvqiE9x/moOQEMON+5lksjFR5jD?=
 =?us-ascii?Q?fkJuRRAbAc3o/d1j5wALZ65nR3sTBOgz906XtK6BA5p1Mcqo6OELkD3IdktZ?=
 =?us-ascii?Q?Oi4vJGRMWb8djyQWscYuBdFSJ9+c/KLL6dC9acuDzYyBr6nZGpx3NApCJvvM?=
 =?us-ascii?Q?8zbOXMfiqmPkjY13tAhLAYvZrMPK/Uon9sko9J34ITyyXdeEGywvIj/lDwt0?=
 =?us-ascii?Q?FRSpXXbdDAZCrneEXikRgc1Wa0qaU+BN78dQwF9RWBpG+iz7G+Y6FR/0tbkD?=
 =?us-ascii?Q?hJnNYsZorRHpROMi+mqKjlnQ8NHfjRHotgvZR7Xz4DNElI8DZqAMXEgpGdql?=
 =?us-ascii?Q?EYNyIMNCZcKX+p+L6wcczjABQRzx6vq+qwcJ/RhJpj8dTaKC+r7Xj2+JrRoM?=
 =?us-ascii?Q?0NszEs57pfxd7xL3PXJe5oAKDQYR63odJ/bSVyIrd45UMbzl4tqDKeS7SrhP?=
 =?us-ascii?Q?cU3XpXc4jsy8hdlCwQ3rQTKJhLSPkuhNHcI4mwEel7hNf1RcDx9MoRelWCrw?=
 =?us-ascii?Q?UvuWBng8YllxnEgOJmTwIB8KTUT+O6S+1gTNtQLkqjNUcghMxS1HPZI/fOUO?=
 =?us-ascii?Q?mjb/qsDOvkhNbNLcfGrKpkKMEboL8WMVcrCtA3Mf/7Zq2DCENgjjZp6QA8O/?=
 =?us-ascii?Q?jiIbTmNSEuKqlQcsPqsxONMeyMVUpA2vPCnZ66xT+L9xFaOpbtrcCbDKgXGS?=
 =?us-ascii?Q?Fgbxv2+Gux/zO5utx3a85xZF5J4F/ZMXGoKaEM9MTWoIMs0f5V+ubIhKiQGj?=
 =?us-ascii?Q?TY48O37/i4yIwVgQ+fNzdOp3Iw05pTmI/QKPhe2DM7Cy7nHCnDB6Kp01qrL8?=
 =?us-ascii?Q?dWO/xKC+boj8W4gNyPW338P5Id+6391qEit5/1geL7BVCX6ddJrQqnBvYbar?=
 =?us-ascii?Q?YSfVJRCN6Y0mObbtWmCSnJ16rEuQkHbsrMxPOEulslViMrbP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6162507-ee88-4ed2-539a-08deb48a06c7
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:03:24.8128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2CoSeqv1GJPAIgQ0JKz2nfunj9Huxu2V41mmevq7+esCCDP2uH07lDfnvtS/w+Gy4Kbe6cnipAtL+U9BjcN5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11180
X-Rspamd-Queue-Id: 08D2E565508
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288833-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

The teardown sequence in enetc_msg_psi_free() frees the DMA buffer before
clearing the device's DMA address registers. If a VF sends a message or a
pending DMA transfer completes within this window, the hardware will
perform a DMA write into the kernel memory that has already been returned
to the allocator.

The result is silent memory corruption that can affect arbitrary kernel
data structures. Therefore, clear the DMA address registers before the
DMA buffer is freed.

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_msg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 40d22ebe9224..b4d7457097e6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -96,12 +96,12 @@ static void enetc_msg_free_mbx(struct enetc_si *si, int idx)
 	struct enetc_hw *hw = &si->hw;
 	struct enetc_msg_swbd *msg;
 
+	enetc_wr(hw, ENETC_PSIVMSGRCVAR0(idx), 0);
+	enetc_wr(hw, ENETC_PSIVMSGRCVAR1(idx), 0);
+
 	msg = &pf->rxmsg[idx];
 	dma_free_coherent(&si->pdev->dev, msg->size, msg->vaddr, msg->dma);
 	memset(msg, 0, sizeof(*msg));
-
-	enetc_wr(hw, ENETC_PSIVMSGRCVAR0(idx), 0);
-	enetc_wr(hw, ENETC_PSIVMSGRCVAR1(idx), 0);
 }
 
 int enetc_msg_psi_init(struct enetc_pf *pf)
-- 
2.34.1


