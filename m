Return-Path: <netdev+bounces-275728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKvkEoka1GnHrAcAu9opvQ
	(envelope-from <netdev+bounces-275728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:41:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC43A743B
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16D593014FDA
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1230AAA6;
	Mon,  6 Apr 2026 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H3kgUEAo"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569983101C8;
	Mon,  6 Apr 2026 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508098; cv=fail; b=ERb6FxClHtyfWXixfAxTX2JLsejEU5E05wlkUwsG1vi1VDzsLqK/xc8u7w1zomgtjnuze+tR7PYUmTd/SAdwLV4pl0UmCkPPPeKukaRQo3y3LfJpbVMyih0+QzQ2RQpvpOrOUXu7r/TX/s333MMClg6a7f2yoQ8YI7cOzMsGlXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508098; c=relaxed/simple;
	bh=ohFb/TMTIBVDdqjQHmTB4EC3d/crqW81zxzMTXM+hWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XMRdFCVnU9KHWr8VD7jHEbNrROHgs2zK1BtJY2ko59juCl7AtH9kabl7tN2lbMnRyqr2MAOt9mSxTjIGfoyQAret1hgNim3iLnb4Pm/s4gNks1ToKw6Hx9Ts7mFLYdMHFfXX5y8clBEwtuVMenh/WB4uA8ebPAiKIRfAOP0QxxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H3kgUEAo; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyJJghGkcgsfCxsY+G0yiy2y/NBl9/cV6PzyRwv2xVnpMm2WQwbWGP7m9kNzU21jhAr4vf91R7lID/l19O/6HBAIegalowLXBZZuZhTtwx5s2BzpWc2MiK4qHb2eXsDJamR5OuRpvfA+Wbl9VfKOAQoSuVDks9WRGRns6pmqgQFseg2oqP+BbqZe/jPtHiqE1ytqYK70XRV5GwVBtaczM6Nuh3BVyEqF/LK5TQfhZhcbyPitIRSvpa0PE62bnv10PL2+z8jCNckNXq/vby2Qa1eLNVspVeTYA3kZUJYjmAwkWlO2SIVe7E2v5bRQco3eRbFDIP8lCbM0Yx5aoJXxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVVgWCf1zqsO2J90L3RX6QB6aXKH80eO8ECMvjE00Es=;
 b=oyYDMwRBcQBoer3v9lcRIK8vyZ2oe+qi9DHpmF2WN0TtaMexYHqhCZAa8+7xLXRK3v7P6PJPUabKjQ13htozKdgGheBNX+0ENLlGQXCCthAu8BOaC2tSkOXFuhXdFx0T7Yd1Yx/eXkhzTBLk5pY2DZKUW2WQ+ounE8HcRlFQn/ZL/6AOxd+Rhf/wI6aYR9x3xbB3HOo/nQSWRJ1EuZ+G8ir41ZVxv2ICL2IcrM6qS0QNZTe4amNjV1HFBTbr7/R/Ybj41s4H3oE6l7qR52LaxiEaO6rjEwV+6DyFtlQBpF0scf8Wpmi0WTKetRETsdIo854nn1lNVEr0t8+Kzhbaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVVgWCf1zqsO2J90L3RX6QB6aXKH80eO8ECMvjE00Es=;
 b=H3kgUEAoLtQJkOslp2Bv9TRdhmArK3tfNwdley2bBRuK1ZsPqQsXqh2N50a/+thtmu5CUlSJ4fvyA0DS9dzvOarDjMHE7B9EJOCtp3QbJxHaqSr0vK9IzwL91kqG+0fycLeyVru8kud7SMwCLWbmnhj42Nqvm63Vs/r+wyk6DzOTH73ShD0OsuBJFtSsF4QBesueBanu005UyJ12nuwX64E/s+chtp0TFoqhMURABneMny6eJ6L5tP+I/4eAcfqbl8CEdLhw9cP1y57VrSA/ADNoSf7oPBum6L6MLmYGYm+tSUMfBFW2MwcPOKqmnN95mR4zu9n7301HQ8PxA7YDfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8347.eurprd04.prod.outlook.com (2603:10a6:10:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Mon, 6 Apr
 2026 20:41:33 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 20:41:33 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 1/6] net: enetc: increment error counter in enetc_xdp_xmit() on DMA mapping errors
Date: Mon,  6 Apr 2026 23:41:17 +0300
Message-ID: <20260406204122.167237-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406204122.167237-1-vladimir.oltean@nxp.com>
References: <20260406204122.167237-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0026.eurprd03.prod.outlook.com
 (2603:10a6:803:118::15) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8ffb4a-8f74-4f47-b596-08de941ce382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	n6JWQ/qZg7Aw3hh5KtroT6oHr+9UAolhi4klm1x7obzBkKeyp9z+gtu/5hC3I+vrMMTNMs+wGD/Y6rBgMiq91f4C0xmCOwqJwykOQ+G6iCyPbhOnPu5e68U9EyhA4+wbTSAyCDfpSy4UjaLVEm8eVFJcfO0wDWJAOtFjX5lzAuUJIZqiPulrF7h3JmktCM9eyKv0+ADpEiUk43uWYV0DYG49xbfKlV5Ugo1P2PAWaKdGksQjXKiJfpObWSNrVK8cWJaVdSiJm4OViYzXAQeCKBbs/0JtO3ljYKT1GUJRJ+8mIQBMQR7gn7MsaEAWX2ncBAGjd6UYpzY0Jjkb29sNQmM92zwrkfAWixrTL9I2Zmdtk2f5EzETNbs4h/y5j8S96jlffQIUY6pZZIHrdnwewHwuAW+zntMtSXERAr0CTY8+Mtf7eiPks6O0ZVpZsY05ZffQhoTCVwwX3MweAsoFdD5980qih9ggrcYAV3y1r9EJpNKsLel+ZRXsldmkkJ8FkHPDCWc9yn/pFhcozKWa5YorVSBfBL5ehc/GMPabDj1j6i8C8/9PUJeFNNBGcjZArjcwW9tBGq9GbvGi5vUEHtHl4BNuue5XXg6zjehJ8XovYIX5GAmPUL25ObrrF+H8BNMO8cn9P+BFpbFZtuQT4KFqVNWlcnyWSb9pYPRGldjhxklhbhNNRFC0Qtbq+2TPhUylnB0qwsYaNZkOhc+kGEVGwPlS7mXZhczV5bv5d28=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q7L6XMZA+Za1FMHxjuL+JO2hnLsXrFZPeb1njQi6VcwgT5PU+1DKkq4OO3vG?=
 =?us-ascii?Q?4LzbNY8tR7329Ox7qdp0bb5w3z378mnMTHnzyEO/UAi1OH/FHyAU7rbbumIQ?=
 =?us-ascii?Q?YRCZ/BVzJVeNCbg9ppLwDODHjMD9bKWL7XDBYs8YHTuok2WQMtgmlW8ODpm4?=
 =?us-ascii?Q?TXAe304rds5XiM9RRY5r6iFqy/qt7SayK8PPDT9vqu4TeRtn5ObvdQsKWiop?=
 =?us-ascii?Q?5WgX6YvboAJJIWoR+UAtn5iWn67i6x4kSMyYk/xfoy0cHG3QSp0zdEa8yCYR?=
 =?us-ascii?Q?f7WTFajm61JU+PLSJ8UabvVmk5NYNufY1xkHIKS6MRZNtRGojih9RKv6mfLl?=
 =?us-ascii?Q?8Mh7g3NMVENhj8Ki6AlELmfgDzuEMjqjqloHshs7VMdSeLeLNJ+Vc3oOpHdl?=
 =?us-ascii?Q?cq4Wun4qfsDLX5DuKhnChzMQ7nu73H49Fx2lZNoismbh3pOs/JyX6z7Dzke5?=
 =?us-ascii?Q?1s5AJSamRKRZvt/9ldZWIE7l0BhoUzJGnoN+J3Ea40oaumUQrGhvmVUUJA9U?=
 =?us-ascii?Q?EnVAqPOSDkWrLHP9p2qTR4LxUtAVXhQz8PZhwpqWo6WuqED3/RAXzHc/nJY7?=
 =?us-ascii?Q?KvfrE2q+Q2/lmOio9HsWzVj2urNUxILp4QrDNPJWuX+KE8gr31TGntEpwnP3?=
 =?us-ascii?Q?/lpZ35phYrrXJYijMwtszVct9rf3nKvI9R8NW5M/om8W+YsTX7jj0oyiDgeI?=
 =?us-ascii?Q?KBu4mYNe5OXgJt/y8fMklh/fXr2FKjzAz+dn4JSbC5FM06703IeyjEdEa8Gf?=
 =?us-ascii?Q?/lw2HAv6JKpETYpab6zkOmtVrw+ETnJRA7Uzss9fhU6WZEJQ+EGP+8LN/7vB?=
 =?us-ascii?Q?v4HYTl0TzqqzxE9hXkLL9MdOo0tXu494Kn043Xdm71IIoLAcjgAhWzq5Oeju?=
 =?us-ascii?Q?DVGM8PgIXV4M6DEetpvuUTthrcoOZ1QIg+UYX0kJcYGfHRNh5cAmkk8i0pGl?=
 =?us-ascii?Q?ITMv/oYDIk+ima8F48doa355/qtX/nBpUH3qRxcEg8nUDrm82o4mjhWqAmR7?=
 =?us-ascii?Q?S4M3+nJpoYye2RDF1TPWbyAX2vZbkNcBNB1PrDP6iBVp22iubeU7XZcHUecw?=
 =?us-ascii?Q?aea5TT2NbdgA91vG8VV9oAnTR1U12paX+93H87tnrPEl8XO6xM+noit6GsZN?=
 =?us-ascii?Q?OQZT7VrXjoRDaCngBbsNZaRRAyVGkJdwnIdTEniiy8eYVZKUqQ+ONVFLZR1+?=
 =?us-ascii?Q?8tgZjXWEQdGi0yIlWogZIaMiblh2vpn6SCEP8o26kAXevnVJuBt/kCvbPgMM?=
 =?us-ascii?Q?cYF/WAh+KgCFj1ooh/h3ST14QIbyxN/ovCAJ6mb5yCSxAW5tmpn06JCBteZ0?=
 =?us-ascii?Q?D+OWELi2PmXfns+yP63np5RbuohJIoLbLwPfBC7B0Klktizi6hbkcK1n9phW?=
 =?us-ascii?Q?kNq0gNzBK36ITVpXerviWpnQdywFsVl05Ai/ltUT4QtVadeZGxUvFnwPXzpT?=
 =?us-ascii?Q?hB68Pu+ETvAQYSQLoG56M5VmXYPwQWXep+8/zSoxEELnHurx92WuR76i84Mq?=
 =?us-ascii?Q?gN6J6PWkSHaRFOX4zcoj2ID8Y5XxvNEkZp08wuHyRsYT4yQWdgcLbmol94qQ?=
 =?us-ascii?Q?7hXxNlEt0e63xqtVSxzokqn5xQdVlcuo3UWEVuO7u3b73bS3ycK+YBZ4+sM8?=
 =?us-ascii?Q?Mx1+axrBuJpUDDEBeMZUO/9azKZg1GkoB02AdLwdpDRSq4MerTIOIwThVzyh?=
 =?us-ascii?Q?FLrbW0z5xRs2InV4ew5hEMqOWOI3TDX5+oCelO3yJYXR9i6UJ92RxfcspY+R?=
 =?us-ascii?Q?AdPxqWuuztDsIdvf7BOsJVv2Kv6TXt90NDRO7le63/rVu8Qcq3tG5A2vdA+U?=
X-MS-Exchange-AntiSpam-MessageData-1: ATEgBCXDyl9xd3Dk07IYtGr1+wN0Eie+DHc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8ffb4a-8f74-4f47-b596-08de941ce382
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 20:41:33.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnUd+nULFhCWJBTngNNANpC0yycN63wa8H5xz8J01vTWU46UqXxfmzmqR2owd9OTUJZo3Kq0olSS7adV7DXqkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275728-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CAC43A743B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Failures in enetc_xdp_frame_to_xdp_tx_swbd() should cause a bump in the
XDP TX drop counters, like failures of enetc_xdp_tx() do below.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index aa8a87124b10..ece10a58d44e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1801,8 +1801,10 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 		xdp_tx_bd_cnt = enetc_xdp_frame_to_xdp_tx_swbd(tx_ring,
 							       xdp_redirect_arr,
 							       frames[k]);
-		if (unlikely(xdp_tx_bd_cnt < 0))
+		if (unlikely(xdp_tx_bd_cnt < 0)) {
+			tx_ring->stats.xdp_tx_drops++;
 			break;
+		}
 
 		if (unlikely(!enetc_xdp_tx(tx_ring, xdp_redirect_arr,
 					   xdp_tx_bd_cnt))) {
-- 
2.43.0


