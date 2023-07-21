Return-Path: <netdev+bounces-19740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D46E75BF1C
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 08:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22515282186
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 06:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D96280D;
	Fri, 21 Jul 2023 06:53:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915B7FB
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:53:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2128.outbound.protection.outlook.com [40.107.220.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9562709
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 23:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glwdQKwVsyk0g9A2Z+AnePjZmYgzdECb6KFTeXB8HBF8KVDeE3uvIyT/GtcacUe2iPuqhlg6FfJBuYRbUHUR90QTeSRg9NrvmssucbPuAiA/9ZOWEFZkSqr/dufH5n1QdM2U84biq26BUkXJtpq/dqQusydl42sDFZ69HRqoUdJZqAOUVMhLbE3S/V0zSiFhRkkmeJU+NyaTZ84evgD12gehHAzx8+oCE1itPy9SJpAWEXDdh+gocmpnDpZTYAwA6lvZkvzirX1QSKwKkcx42VRqAEf+P23P+x1WSovC8mDsfWBvPkG6K8rE9QnGecICLpHu93i745wPG9c/ilzDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaX9PJvuC8SjZPNNGOnHO/QFTMCsz6YOZkcDTkc/haY=;
 b=GH/h5Gci8MZOTdNggKz93U1MBj7E+8acJ9uz+3l+58p0376luvUNWuT5PiLy7D5/5ekiDSG06er0RkD0K/4d6PPNdcO1HckWUeQKvnT/7Giay7+55swExaxtOxhj9s5ygsLYCS0mMCi8JkcO16RJpQroenHsP3iupXoyfuBo+gLCvjKIZE77Bw/1tTX6DzuIwcfNTI78XD1uaJk+KWseqIg6Ve1GPgY3PTKvfWFSF63mQq5hCeyUF/v4N5gKj3+xoCjzRUuTISmKZJn4nlTwQT0s9clVyRZGN0z5YEQqO/XTuOpZXPTB8DdBUopnOhU3Xo8GI5znM619YgZMAL8rjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaX9PJvuC8SjZPNNGOnHO/QFTMCsz6YOZkcDTkc/haY=;
 b=OwC0kVjw/LsOxwEbxwRNMb+2aw4LLUyNdK+oYRPB1cPPQBI8QhHycRNWvXdhfhjrOX5BMmxxDheGOhXmoBEvGk9jU9T8zmRrdwHmr9zcqpxwFr4vbHfj+xMZ+FreIAxL7GwgetiTvREmjhYWluDXh696RMvEz3AMOQS/1cV7nxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB4474.namprd13.prod.outlook.com (2603:10b6:610:6d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 06:53:00 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 06:53:00 +0000
Date: Fri, 21 Jul 2023 07:52:51 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name, john@phrozen.org,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi@redhat.com, daniel@makrotopia.org
Subject: Re: [PATCH net-next] net: ethernet: mtk_ppe: add
 MTK_FOE_ENTRY_V{1,2}_SIZE macros
Message-ID: <ZLorQxf958WaB4Hw@corigine.com>
References: <725aa4b427e8ae2384ff1c8a32111fb24ceda231.1689762482.git.lorenzo@kernel.org>
 <ZLl1Le1JiuoC8DIc@corigine.com>
 <ZLmefyZCTwbXtZ/i@lore-desk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLmefyZCTwbXtZ/i@lore-desk>
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb2f09a-0f26-4732-c483-08db89b71f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fww+iy1Ak3NbXsaLqkzl5ouaGWiwzlSrcZkta0smL3GakISuXQ0WJ4TEv8Kk9RizTA9PKMlZC79jmziZkQL6mzVQIY0F4lbX6nPnR9NwD7ADFI5lROv3E+Rbz2+99BHdex/ftr8haEjtWCDIIzVaquJk6fZkyyRa6tT/tdLHnfIPI9jX/YWXiLTsCFjRCgL0glVZjdTQNXEdmXRDOnYTd6UREMTRtkTNGygFJJ7Zoiix5gOH6SrPTlp4i3z8gj9n0/SUAkPTFz2bHA3cbb4hW3bn2nu3mTpJ4rLV232ywp1LyCOR7Ngolp8iz5imPSDjJ8Nzjb0Owgtu307guHtTxU5TuQoCEcqtJtA8Plj9vayFsbQxlh01IGqshTjimYkwEW77anu2oPReftW31s7EZuVql5kGOxwK6znjz8kAjG8l0ghsFUeRh2YzvMJezx3hb+eklkODxOgPqnxzrfrQXaqr34gyKO7Zq/3VmvHAW9G68UcptC4PDk6QHt7rkicjVDTFYY3TvSiVgAGPkj7rcqxsCEwLJMg6NjXwPmAD6bR5jlTM9QyxbRGQdoiBUQQXJdQ+PVG87oPYaIn7JV+PpcP6l/RuFDoZEUdkpyzNdLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39830400003)(376002)(366004)(346002)(451199021)(6666004)(6486002)(6512007)(66946007)(41300700001)(478600001)(5660300002)(8676002)(8936002)(38100700002)(6916009)(4326008)(66556008)(66476007)(2616005)(316002)(186003)(83380400001)(55236004)(6506007)(26005)(2906002)(44832011)(86362001)(7416002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gPMy0x+3leEKtJNo9rmYqIMbE3R5Gun2WiZB2iKqAYulX6qFk8zSPqLxGDTY?=
 =?us-ascii?Q?TGG91EpbQK9vkJ16BNl/I3TSTDxbWBDUXO+JaiE51s9+P86bfLo5b/ywhuko?=
 =?us-ascii?Q?hQiXeziDKaK4wu03bOsksMCKvCqH10wzIBDVVos//+nptFJzGwgT/+e7zA/D?=
 =?us-ascii?Q?GKnQDOAlw3rPDG6ofVjG1LZoOcVFUzONTsyMSI9g7oow4Y/E6joTlMjuegt/?=
 =?us-ascii?Q?xBTrSTREg8ArZiEiI9j5Vp604ot2X5Uip4eZtsT56r1m/lsKhSh4EB69Tquy?=
 =?us-ascii?Q?q1N8e+LDR3EyZppKT9XjJasmHfBKsFtVoOC6NTxpR1VKqL/0Ya71c1AKdPjl?=
 =?us-ascii?Q?zHxvFMcAFjgcTAVBmca+nYurQJyaP1BKLtJGJ2MdxXAYaWf4c3EZC7vgR5Cj?=
 =?us-ascii?Q?XakFrHGAGE8kI+DgaKEihyPPmRA78qdgDmty//+UnluMQVqrZdfpaNq0xxJm?=
 =?us-ascii?Q?5bPqv9Y1JGrDxfyswlEIX+JAiYPwDx7gsXOs519H0QepMY9FO4Ot/Heso/Fj?=
 =?us-ascii?Q?2++Ry/9sXqc479lFL0tk9bp512JdDFXp7UAFw/AHqPdvQjhLiKMffdue2e5n?=
 =?us-ascii?Q?SbIPF2mcnScTUFaYa01re0XAXX10LUCc/UZ/tBWS+DTN8YKEfJaVoQpoYQlU?=
 =?us-ascii?Q?yLLEOT+SCqqE9nznIzoAMhwmQC/Y7/6aX688jIIhcxrPCxENnAG4rMIej3tY?=
 =?us-ascii?Q?tN8UC/pjPvSyAe6/Tn4jQk7SkEW4YhtepQCDVu4bnwZlgR/dusdmz6SLMLop?=
 =?us-ascii?Q?0165DIR/3gWuf+jPMt8gYz4N/lNwGzccGOkb+0N5ynYwWmmUx8/nlYsM+p5X?=
 =?us-ascii?Q?yF5WSRDHM1YreXdqL8pl4OMFl7vkoM+MEwalgGjESWVCv4pv28Ve7e+nMi74?=
 =?us-ascii?Q?T2PuzH3zpcObqu1I7+hLqQvlOmHwSagi/183QMEr7yHf7HLDB+PZz97dGe2f?=
 =?us-ascii?Q?/DMJTqF3KiJvtSM+RWO9SKmqAQsuVNZ6mr6l0hPkA+ifv2/aN68tBmOPL5HT?=
 =?us-ascii?Q?2mjFsdcA/8Ayvc88WGZ0ppeaHyhCq4XfYQ/8jVlp629I2+yudMwWseo/Eq2q?=
 =?us-ascii?Q?m3s7bb+xmEt+ZmH5y2rg4EMC0H7YKcVJu4HV0y3acj0Q65/U3rO3QjHSQiE4?=
 =?us-ascii?Q?TStIB3ZGCLLHWQVVi4EVcO+exPzCh5VM0Lafxup00AXmLydZXRk0qNMxx76K?=
 =?us-ascii?Q?0RRHroHD4LH3Ye0gJYFaP6sqdAmG4T9tAXyaohaJYPF6SrvOnPuijRWG69up?=
 =?us-ascii?Q?sO3JIKY31ZrR72BAy/BYT+QHbcwP0gfBKp5RtPbh2ZuRVkm9Qo8xoHo8nPrp?=
 =?us-ascii?Q?LbWnHO3LeMFDleaYahcoeRi5gBAN6bVzTz55kVTPFjTGXQVhl2KWuEBBdYhX?=
 =?us-ascii?Q?EfxV9u6xEJmMah4zkG2G9BBBksOyoKzXO8fRa/hD3Hx2llm08byUXZa2eFFb?=
 =?us-ascii?Q?XTu/SdPrJtuhK+aL70te3X0SzYJF2ND/KGa07vOEyM1w0yINPqN6FQKV59Yc?=
 =?us-ascii?Q?MJFWXxNMtSqrbisGF9GPHWzp7PTXBLnpkODA4KV1EkiDZmHWtXZsDSDgadbz?=
 =?us-ascii?Q?S11kobx30FC6vMVLoHPPed/1Z54jlIfoKymiewQEyRVl+ruqnYRNJnj+nOi7?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb2f09a-0f26-4732-c483-08db89b71f20
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 06:52:59.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpbwbw0BS8Sh0mZkSH+oe8OT5hUVZ8AT5XEVWbOunSsHx65i8TC3mleKuhzAAGoWGDk2nERQfeLio7cizTQz5KezFvKvI54FM+eE+hWtNjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4474
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 10:52:15PM +0200, Lorenzo Bianconi wrote:
> > On Wed, Jul 19, 2023 at 12:29:49PM +0200, Lorenzo Bianconi wrote:
> > > Introduce MTK_FOE_ENTRY_V{1,2}_SIZE macros in order to make more
> > > explicit foe_entry size for different chipset revisions.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 +++++-----
> > >  drivers/net/ethernet/mediatek/mtk_ppe.h     |  3 +++
> > >  2 files changed, 8 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > index 834c644b67db..7f9e23ddb3c4 100644
> > > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > @@ -4811,7 +4811,7 @@ static const struct mtk_soc_data mt7621_data = {
> > >  	.required_pctl = false,
> > >  	.offload_version = 1,
> > >  	.hash_offset = 2,
> > > -	.foe_entry_size = sizeof(struct mtk_foe_entry) - 16,
> > > +	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
> > >  	.txrx = {
> > >  		.txd_size = sizeof(struct mtk_tx_dma),
> > >  		.rxd_size = sizeof(struct mtk_rx_dma),
> > 
> > ...
> > 
> > > @@ -4889,8 +4889,8 @@ static const struct mtk_soc_data mt7981_data = {
> > >  	.required_pctl = false,
> > >  	.offload_version = 2,
> > >  	.hash_offset = 4,
> > > -	.foe_entry_size = sizeof(struct mtk_foe_entry),
> > >  	.has_accounting = true,
> > > +	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
> > >  	.txrx = {
> > >  		.txd_size = sizeof(struct mtk_tx_dma_v2),
> > >  		.rxd_size = sizeof(struct mtk_rx_dma_v2),
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.h b/drivers/net/ethernet/mediatek/mtk_ppe.h
> > > index e51de31a52ec..fb6bf58172d9 100644
> > > --- a/drivers/net/ethernet/mediatek/mtk_ppe.h
> > > +++ b/drivers/net/ethernet/mediatek/mtk_ppe.h
> > > @@ -216,6 +216,9 @@ struct mtk_foe_ipv6_6rd {
> > >  	struct mtk_foe_mac_info l2;
> > >  };
> > >  
> > > +#define MTK_FOE_ENTRY_V1_SIZE	80
> > > +#define MTK_FOE_ENTRY_V2_SIZE	96
> > 
> > Hi Lorenzo,
> > 
> > Would it make sense to define these in terms of sizeof(struct mtk_foe_entry) ?
> > 
> 
> Hi Simon,
> 
> I was discussing with Felix to have something like:
> 
> struct mtk_foe_entry_v1 {
> 	u32 data[19];
> };
> 
> struct mtk_foe_entry_v2 {
> 	u32 data[23];
> };
> 
> struct mtk_foe_entry {
> 	u32 ib1;
> 
> 	union {
> 		...
> 		struct mtk_foe_entry_v1 e;
> 		struct mtk_foe_entry_v2 e2;
> 	};
> };
> 
> and then relying on sizeof of struct mtk_foe_entry_v1/mtk_foe_entry_v2
> but then we decided to have a simpler approach. What do you think?

Hi Lorenzo,

I do see some value in something like what you have above.
But I also appreciate the value of simplicity.

So I have no objections if you prefer the patch in it's current form.

Reviewed-by: Simon Horman <simon.horman@corigine.com>


