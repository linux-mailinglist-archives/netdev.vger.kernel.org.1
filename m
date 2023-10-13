Return-Path: <netdev+bounces-40744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB727C8924
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD6AB209C1
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81701BDEF;
	Fri, 13 Oct 2023 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JWBMe3XX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41911CBC
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:52:12 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B8BB
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNNYd17INGOiSDWopSMKGgbUqFqg4YfLjUmtu/MubqdwuFmFaKdGwcMz74IZp7fHCU8q/7BZejVBIWcX3CBErnOq/44cDTeMA4fhpjEPVH5VUQuRMGcqfAMclxI8lR1DkPbfD1NEELzYR92Yu1I4EJHj349s5SlJ5e5RQiUTPuO9CvwIV0r4vtxhx+ao4AOlaqSl25Y5CWcKLyKqWGjKNI+ZMJ2YJh9AEq/FmVb1RGkFm25w4lqr9gbr2IA3tyNuFrwS2+gutxZEzRmhm2ZNWaoKpQb98PLb4etD73yv51JvbUZHBoLHoa2fYWp79OjSPHZyuhpVtMG90TTPu1zwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BAgRscS8kzjk97e40AkWblCSBzhLwZABfrs0YFeWU0=;
 b=GYoMyrwgbFNd913f0a1qz0XUpoLf61GCs6Vga4pPSAJin3z8BiE4NhPYXBQdXsqncqOMUB+/HlVC+C59iDqnCi72p9IiYwJa1IoBw4cONg0cFlhVL7g8lFqEIqxoWDvZZ8asRzRueXNIABufuONddf9pJEEnjn/F/yvfUohzjxJX4O7BX4ACUhVm81ajhDi2W0G8BK2J9W5Gphs5HjClTtMDwk4VHYkmXMo6zb6f7UrW01VBK6ySBIrIJzqbFMiP7s4QvWcNHbfgLCR1UROSN6a2GCzAnZYqv4xiTid5JR8+y5pdoiN62WwqA2Avhfn4fEC293/5Ma9ADAgndpFx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BAgRscS8kzjk97e40AkWblCSBzhLwZABfrs0YFeWU0=;
 b=JWBMe3XXT+laQKFUQipKKOSGCNa9tOISxebp8fKXWpU8yJH1met7in36BqYkSKmjenAm6sDEhEYTbeVAXW7RmlgNsD0r2VM0NS8S0MGVIDXQy2SSbFUPQX1GogQXvUIi0vlwEUcp0ssXRnEHGm1zV0myvuOaiQSSJIninvQ2qcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by PAXPR04MB8798.eurprd04.prod.outlook.com (2603:10a6:102:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 15:52:07 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::b5bf:66cb:33a6:3345]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::b5bf:66cb:33a6:3345%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 15:52:07 +0000
Date: Fri, 13 Oct 2023 18:52:03 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Daniel Klauer <daniel.klauer@gin.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [bug] dpaa2-eth: "Wrong SWA type" and null deref in
 dpaa2_eth_free_tx_fd()
Message-ID: <20231013155203.kib4nowqvhtcv5ak@LXL00007.wbi.nxp.com>
References: <30428046-fe1a-be57-1df6-2830bd33a385@gin.de>
 <20231004155048.ttllicuerlk5lroc@LXL00007.wbi.nxp.com>
 <aa784d0c-85eb-4e5d-968b-c8f74fa86be6@gin.de>
Content-Type: multipart/mixed; boundary="7ryje6qlgtjpbxiw"
Content-Disposition: inline
In-Reply-To: <aa784d0c-85eb-4e5d-968b-c8f74fa86be6@gin.de>
X-ClientProxiedBy: VI1P195CA0087.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::40) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|PAXPR04MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 35138045-f952-4ce6-dc7a-08dbcc045a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NU5tMdVFTf6xhsA1nVNCP/GxrbxESbC/rCvlt6ZwSb4t8m/LYSlUUUqmtWFHtnQ8/6w9Xl/+A9jMzvrYsFb6CQCH1pDi121ZZR9e4NZLk1kHbCf4V5eJenCpN5Io2o916qV+OkEPFJw5IrvnvJ9Xehjo1EHKZDvUQorfEuzgIIWv7YAp6w3r2dVP2o3b0jKvKGhJFZC83YTqHVBwVQbramhcAvbZNnP6SoBjAP9uFPjn42ZwtRHk1jKwWqmNcO1isQdsOrxQvQO2yvcONgv7XRTktUTNvfoDtHWS8epuAOJXfnCZNBhMwGIm4Dqxmhof5/gJKKuCTHaQQnviTS7nmoihLEHXH9NSxnS2LGbyAQDi0zI/SqlYH+FuhBfMkBJ3I+uY38lHKe/YWNZbWQdFthUKp9OjQ3uBWFujwQGSjdVHG6EXZ4ZS774XqmW1CW9qdprHMj/zZPijxtX/6wh6QAi8KPXI8QAAaym8d6e1CjsBpL2pOetr3f6QvM3mDfwbNZUntwXo+FhLYAow91ScqPFw7EmzSbK41B6szVb1KJ/4l6GJ9gW5twfbTbOyGbuIXiUF3Ju0HawXzy4NdmWKE/5Xw5Jo0voHbnPzu7FxvejppOwLm2v+H3bc5jINLGfA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(41300700001)(83380400001)(44144004)(38100700002)(53546011)(1076003)(86362001)(6512007)(6506007)(6666004)(2906002)(235185007)(44832011)(5660300002)(6916009)(66476007)(66946007)(316002)(66556008)(6486002)(478600001)(8936002)(4326008)(8676002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ieh29Us/c0r3nqGVD45JyEU/WgxLNgHa9lilDVtW+Z/blPyp9jMYbjHxqgQE?=
 =?us-ascii?Q?4q6ew5XLQa5OZLYZvXc8pQSrfoizSsr2NOauoGbtqSonSibGiv1CE2KHJvdJ?=
 =?us-ascii?Q?TJ4suIH24irTrA1xM53AhGsKRqqka2UvkNSKY3pTUwy9eDBaR+Sd1YFFg+h0?=
 =?us-ascii?Q?yGGAGse8fqHcp30AlpNVLqsRqzFS4xzVWeuEWsQmtGWoWufV/vw6OvGfi9Mz?=
 =?us-ascii?Q?OHh/ZlupwiwgsNJbXc3F2mhPiaAt0NNXCZA6mJclgtsLVWm4PfRHOVgwatLv?=
 =?us-ascii?Q?O2Dq77pmTCYORA7H1lcq5AuaDSEZ76Oz1s/MCIRgX7s7MXNkV9mfYIcZJWQD?=
 =?us-ascii?Q?jizUaMQHKQTzkxpYAweU1KzCQ5EkwNTAMc+4JucpC7gbB/XIi8rOkOJDVNGF?=
 =?us-ascii?Q?u23KLjPmkIIpzB/191wPDoZx2e+9JsBRo2DB6k3rwOsuK1irVHwL9L4RZmLy?=
 =?us-ascii?Q?SXnQTXYD74Ks0xyzSDxusORJcaXKU7wOdOBNsS3n1kgbWvAonDUG3fjJDzov?=
 =?us-ascii?Q?h4H6lLxaUqXzmieXltWU1VMJCTZ6qlheQQcEvH2dBl0Xp5BNppo6zD7UDLta?=
 =?us-ascii?Q?z8lkFyCUJDKddvsLsjct1CTqe8Xo5J6Wn5yCjJsvA9QufkGG1wJN4qTz8hJU?=
 =?us-ascii?Q?58U+eeEOfubO9ILlWZi6OvBaY9u9gGHPiz10bZ52SiEzKvj3Z8unwL0Xi/KZ?=
 =?us-ascii?Q?jRuas6GlFEyWDg/ag2rZ0LKh+qpzQMkWVo422vDfAMdrkhXfAUJ3M+f+nZHa?=
 =?us-ascii?Q?EZBvdSvPwIFlB9M2KcAWFgcfyjBj0P7WsLPojrCDn7SBooT1/5dQfkvovuP7?=
 =?us-ascii?Q?IUdgZTdxi7CRGPyLvucwY0rU/ptIWGuhegSPdrtQZrXT3bktQ6H0pMNvysCD?=
 =?us-ascii?Q?7KtfvcZwWoKwqIQqm3OjwWXjyuQgpfYuoLJQu0YWnM8ciPjoSFMcoE22CTKY?=
 =?us-ascii?Q?B6LCm4ULKLYHV88dObRH9k5Gidov2vdez9H7LHqoMQXxXmYSJjfKdQp4SvTZ?=
 =?us-ascii?Q?lhqq8vtU57q4dVhgjW0wyG/AobGtCZrA8pEMKcCQ+cNu4Yd3W81FCj3krKKe?=
 =?us-ascii?Q?BzHuaAxu4nswfzo5ADcrN9BKksqt0SVDc13fXURk4w484mKZ+VFf05R7HIs8?=
 =?us-ascii?Q?0VEFesjNAQCuRCWQNNzFyHDBtC9eOVQ2HVVWvPSwdCP8yGwuoh1+2VJVqsD9?=
 =?us-ascii?Q?t4sYIaWRO+MeDA+37fSKsx0sc89Qzb8Xh92uKjKPmtRlGB1q37GedGBbIzsw?=
 =?us-ascii?Q?6nGAoAsMhJv6uQCttnaAJXz2f9Th3KUgnCh+8Q/04fo9ihIefdFez7/CX6SA?=
 =?us-ascii?Q?BRmvzYY+cC03C6pU93VgtrB9LV77BTg+25OtkomI6288/RmuDW6R2kvIiuiF?=
 =?us-ascii?Q?WxPgE0/HdFhZLpv4p4E0+DRikkfq5RBsxqT0/RzYs32sAQM1rvF/a20lp7IL?=
 =?us-ascii?Q?zAegKqIcBL6nupJfLvT1Ytns3yv1NE+ugoaczBzK8e4drXpt6/C+J0zn/54s?=
 =?us-ascii?Q?E/j/bU0LhNiNhPjQta3QKP9aGs7shXJM2sg3AEcRXaS0SndEfFJ8P8Lb2NLI?=
 =?us-ascii?Q?wZqVj7LRI4NUkrRpz4HSO8RxNAmsHB/rU2xfOFht?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35138045-f952-4ce6-dc7a-08dbcc045a31
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:52:07.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hv4ZbktIPaQtNRGPW+wSuyVEvPwBIIRxLU/hCCZUy5Y3juhxGCdt/ZQg6ZZHlbeomi8UHn+wj44POrqwXi2TKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--7ryje6qlgtjpbxiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 06, 2023 at 04:03:19PM +0200, Daniel Klauer wrote:
> On 04.10.23 17:50, Ioana Ciornei wrote:
> > On Wed, Aug 30, 2023 at 07:10:05PM +0200, Daniel Klauer wrote:
> >> Hi,
> >>
> 
(...)

> > 
> >> It's 100% reproducible here, however it seems to depend on the data
> >> rate/load: Once it happened after receiving the first 80 frames,
> >> another time after the first 300 frames, etc., and if I only send 5
> >> frames per second, it does not happen at all.
> >>
> >> Please let me know if I should provide more info or do more tests. I
> >> can provide a test program if needed.
> >>
> > 
> > If you can provide a test program, that would be great. It would help in
> > reproducing and debugging the issue on my side.
> 
> OK, I've attached a test program, send_and_recv.c, reduced as far as I could get it. If I run it:
> 
> ip link set up dev eth6
> ip link set mtu 9000 dev eth6
> ./send_and_recv eth6
> 

Thanks for the test program! I was able to reproduce the issue fairly easily.

I still do not know the root cause but it seems to always happen with
frames which are not 64 bytes aligned. I am afraid that the memory is
somehow corrupted between Tx and Tx conf.

The driver already has a PTR_ALIGN call in dpaa2_eth_build_single_fd()
but if there is not enough space in the skb's headroom then it will just
go ahead without it.

Attached you will find 2 patches which make the 64 bytes alignment a
must. With these patches applied onto net-next I do not see the issue
anymore.

Could you please also test on your side?

In the meantime, I will search internally for some more information on
the Tx alignment restrictions in DPAA2 and whether or not they are only
"nice to have" as the comment below suggests.

	/* If there's enough room to align the FD address, do it.
	 * It will help hardware optimize accesses.
	 */

Ioana

--7ryje6qlgtjpbxiw
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-dpaa2-eth-increase-the-needed-headroom-to-account-fo.patch"

From a8574f7e8e9aa01047f0e72a960209534a8257e8 Mon Sep 17 00:00:00 2001
From: Ioana Ciornei <ioana.ciornei@nxp.com>
Date: Fri, 13 Oct 2023 17:19:31 +0300
Subject: [PATCH 1/2] dpaa2-eth: increase the needed headroom to account for
 alignment

Increase the needed headroom to account for a 64 byte alignment
restriction which, with this patch, we make mandatory on the Tx path.

The case in which the amount of headroom needed is not available is
already handled by the driver which instead sends the a S/G frame with
the first buffer only holding the SW and HW annotation areas.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 15bab41cee48..5442d0e5fd66 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1081,6 +1081,8 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
 				  DPAA2_ETH_TX_BUF_ALIGN);
 	if (aligned_start >= skb->head)
 		buffer_start = aligned_start;
+	else
+		return -ENOMEM;
 
 	/* Store a backpointer to the skb at the beginning of the buffer
 	 * (in the private data area) such that we can release it
@@ -1412,7 +1414,7 @@ static netdev_tx_t __dpaa2_eth_tx(struct sk_buff *skb,
 	percpu_extras = this_cpu_ptr(priv->percpu_extras);
 	fd = (this_cpu_ptr(priv->fd))->array;
 
-	needed_headroom = dpaa2_eth_needed_headroom(skb);
+	needed_headroom = dpaa2_eth_needed_headroom(skb) + DPAA2_ETH_TX_BUF_ALIGN;
 
 	/* We'll be holding a back-reference to the skb until Tx Confirmation;
 	 * we don't want that overwritten by a concurrent Tx with a cloned skb.
-- 
2.25.1


--7ryje6qlgtjpbxiw
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-dpaa2-eth-set-needed_headroom-to-the-maximum-value-n.patch"

From 2eb596d0486adc5954f6d9263f153afddb3e470b Mon Sep 17 00:00:00 2001
From: Ioana Ciornei <ioana.ciornei@nxp.com>
Date: Fri, 13 Oct 2023 17:37:23 +0300
Subject: [PATCH 2/2] dpaa2-eth: set needed_headroom to the maximum value
 needed

Set the needed_headroom net device field to the maximum value that the
driver would need on the Tx path:
	- 64 bytes for the software annotation area
	- 64 bytes for the hardware annotation area
	- 64 bytes to account for a 64 byte aligned buffer address

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 5442d0e5fd66..9f029f3fe909 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4969,6 +4969,8 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	if (err)
 		goto err_dl_port_add;
 
+	net_dev->needed_headroom = DPAA2_ETH_SWA_SIZE + DPAA2_ETH_TX_HWA_SIZE + DPAA2_ETH_TX_BUF_ALIGN;
+
 	err = register_netdev(net_dev);
 	if (err < 0) {
 		dev_err(dev, "register_netdev() failed\n");
-- 
2.25.1


--7ryje6qlgtjpbxiw--

