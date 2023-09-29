Return-Path: <netdev+bounces-36993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E1C7B2DDF
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 10:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A579C282D5B
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA90EEBE;
	Fri, 29 Sep 2023 08:33:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD5630
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 08:33:28 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2095.outbound.protection.outlook.com [40.107.20.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857F21A8
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 01:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGUXXxhbOdBNpxcEw7wAr/v+nLjespljm9luCGkIViNUyl9HQJTsGD+TjHnnBBemUQfVabboVqulrDsfLX5UUrLyyExx6SKzBj4x2ck9NZoOwVu8UVcWFTT5rDpznisBtv2ZreemQHJUNlkc9+xv/R3NhAXWgC1AKxFllznHMnQ3QA0JzyjSuTXxwmVMnb5s4vKwYqByCNPSL0INpelYLQWc3J06VB6NrT+9hXguHRPZ6YpJvtYgJmZ6z+drksnpTOUCkpvBIXj/v/K1mmzIhHzDoIBS2OxEzqK7I9gc04PW2OTb0MkYAbd14sPzpgh1+O9oZIBw9/jL42jniQNV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B6o32ePB2y8vzBNSDgtKW7AlBBAbw/CmGsTGEm4Ec8=;
 b=Et3nks8K6pwtEPJEsVcMIUbznxI3LNXV4iQS5nwpjVRy3ANiJTp3S1QFqGudRhjBMjiNxzNRVs/4mPbibacWc0JRYj5VLhHNEE5hFALNN1kMBC9vBIQKghPUftSKRFPZXhRNu1hdau6LFgCzh1R80WxotdScmkDyEZXbYpqy837GInTbfOjAHP1ZIE0uWz2v1w3tIlY8w2/giiXqPhxMoJTXP5oUBGRleZa7yW0SrZ4HvOqptvJN+2BzfSD/212MSTF7svIs00go/TpJTE5eMCfCw1gAKX3+vSV6B9mBFHNIc3xIOhmrQwuqTwCnvIf0ZckPLgunvKdENIDYYZBiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B6o32ePB2y8vzBNSDgtKW7AlBBAbw/CmGsTGEm4Ec8=;
 b=imFjolIfjNKcXYx0HtUtUI5z9s7Tzr7+PUImo1RW7i8uRzLpmBUDOt1Q6ix/i/Qd7d+9qHya2ijLicHW0Yzkn9fqOTEdiFWEI7pI82L1LNWLcw7dSjSVersErV5nf4hixiHE5A7kWpdaEJqlaHivprh5NKJNafo20RYAFl3YvFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com (2603:10a6:20b:438::20)
 by PR3PR05MB7130.eurprd05.prod.outlook.com (2603:10a6:102:6e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 08:33:20 +0000
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1]) by AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1%6]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 08:33:20 +0000
Date: Fri, 29 Sep 2023 10:33:17 +0200
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>, "brouer@redhat.com" <brouer@redhat.com>, 
	"Paulo.DaSilva@kyberna.com" <Paulo.DaSilva@kyberna.com>
Subject: Re: [PATCH] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <6jfs2tmreeu2jzqlbnz3zqlgpy2tfcdwsbkpjwk3vvnwogkbk3@5xwpsqm5fmrg>
References: <lagygwdvtqwndmqzx6bccs5wixyl2dvt4cdnkzbh7o5idt3lks@2ytjspavah6n>
 <ZRaCMwdFfC2ZOgAW@lore-desk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRaCMwdFfC2ZOgAW@lore-desk>
X-ClientProxiedBy: FR4P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::17) To AM9PR05MB8857.eurprd05.prod.outlook.com
 (2603:10a6:20b:438::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR05MB8857:EE_|PR3PR05MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: bca2fa95-d843-4193-bd89-08dbc0c6bc9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vbFpZo1jw35+PYNDMtJE5yqRYn5Xd55oBaRnnCR18NS3hmRT+DWU1ODUYb4EUHUSFvhz0ldefFicDuyykgB8GVKQQ8+R+fskuSmkAsB2zQd+GdRlZPTDBn4Wt6fA/kRpXCFpU/Ly+fLc1VFMbjFM0D6SwQW6KMVanhIc8RNrtWLELW6cLNtKxHMgCUUZSZ4qVlFM9KEO4q2zOTXHFuQp40Eet/pa7CEAlT0ONnVEWYJ8yfst+Olf2LBw/m4Y+bw6qr0C/vB+15PkoAUNvWK3rSmCAl/QRxzRYICT9fnEVlGBrc3SnmehYelWjddssXh6NVuqZ9HIfLOGOjiM4+TlS+aQt1sWcFr52RYlV01R/GRN1Se4jXJDx0n8ldHcGkG5Oy4lJ8qZzf424zqvHY8cJpsgO9Bc5x/RBDXy9hv5Ahk6LJiK12XdyqsKDoacytNjQDjZ1w+7RLTfeHdubQ/Nl1ZcomqRkc9nunoYvpCppmL/nW76sMkLhGrMrQzcwDFQPfu8jZw5NpL12VOtYrb83/bpAEe58T1Dpr7koKMTpUTTP7yBCbQ921BQtiaRc3za
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR05MB8857.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39830400003)(346002)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(6916009)(41300700001)(316002)(44832011)(5660300002)(8676002)(8936002)(4326008)(66946007)(54906003)(66556008)(86362001)(33716001)(6666004)(6486002)(6506007)(6512007)(9686003)(26005)(38100700002)(66476007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UzAL8FfpuB0pP3AMC1y9xvq+FtPjNXR2hZs4A0SNipl1MXBhMRX0V4jbpUeP?=
 =?us-ascii?Q?PgLl2yqQmc8DT+lD5RLOYQ+/RMW/aL9gl0SWPqk6dUSKuuM8x8bk8ZKGsn/K?=
 =?us-ascii?Q?fRL2uyYg14oJCv0HhM/2U6Do+RVLOd1X+JHm/7YhEEvzsve9YuqiYySx53Cl?=
 =?us-ascii?Q?FH7qnpSfBDq3CiEGrwaRH/dAzV5gHJvqLryyc+KZPcxpcVy2ZN1kmMJoTmte?=
 =?us-ascii?Q?D47a8FdbBB6jQFIFmECK1ORJJWm4838meoN6nnFSOVt0U6bqErMVXhg3qebb?=
 =?us-ascii?Q?9rx06AmQ+RV6sRDUgyjTfHx0eyr8DlNPBd1lslknNGPEpBttn2ix7eoNrqc7?=
 =?us-ascii?Q?WyZVnefvx8d8D1PqgHs3C3dxvwQ99rI+crLFzbAqrgbsAILp3NbHenJMJZca?=
 =?us-ascii?Q?v8HGH80Lzl0sTWIMM3wRcsvCqGifBBGlkAPupYiXUV+7YYS5JOFUF4/J/0yY?=
 =?us-ascii?Q?nFUbj5Jcb9TW48+KmlzhpOH+umWg1xzEO9r+EFdeMJ9D0mHa89F6IbBYHoP0?=
 =?us-ascii?Q?nvMO2xXDRxVjpsIsbMO0BYlQNh4/hilMz44gLPonIIvVQypvSon20VyL0lZd?=
 =?us-ascii?Q?iwSMk+3aP+6J05qkIho520yeubohjYd8KjbcB2ynNoGhIaOuMZwnAAPCJHMI?=
 =?us-ascii?Q?ZrZQutOTjH588/gZZyn8HlJmJ3cqMxiU2gYRYae5pRwZyBRf9dKcVbvmStUg?=
 =?us-ascii?Q?qUKVEKf9ottuAtWaIfmKqeJ3VJ4b0td478stohF+cpNAnWqQxngAbcVr8I8d?=
 =?us-ascii?Q?bjb/XmosKoUwk05Vhy9s1x5PQJIJzOtorXNifruQRCwCvtbqM5UbxoRnNF6i?=
 =?us-ascii?Q?ScXBISeRehYFQvWmb16g81wSEx/r5hAAT3LgY1wNSUCMom7YwuPM1SG8/jd8?=
 =?us-ascii?Q?mxWNZFc7Wk3Y03njBsI90MNUijGmv4DgmXJ15eKAvg/+zMAFo02PCT3iwkfB?=
 =?us-ascii?Q?cpqJMJoVgogBkVC8sc8+qJUXhVK+3nNWhsVXjAmCi7y+5d9Vr9SHGMpeJask?=
 =?us-ascii?Q?q6L8v2EbFSi8HpkRa+iQfEWOV4S2TEkm823yADLlFn0YCOms0dHMxra0G4xV?=
 =?us-ascii?Q?dJjWtkm1dig0ztKawwlEdDw3tPAariaRvYZSmPMF1jmKJrhhHC3QTM+VehPW?=
 =?us-ascii?Q?8TRutvmTUY2Jkm/FTgHSPYgRQ3YSKhfedsTZcjYF3lSPwxlmGFZJ7Gp/P5Vd?=
 =?us-ascii?Q?XbA46nJ2rfWDVri2aTlC+pjargl/YRj6XJpCMgwqn9fpRQAeA4hGhQsOuWbf?=
 =?us-ascii?Q?swxDAIV3DuiFtHrnPh2Jz9c5JhpP2mCtFE1YEZ3pKH8Nv5G95LPNDM9KDhEF?=
 =?us-ascii?Q?mPWTDtTqqo24YLN+VwDweG5h+K6jybLOBP75dzCngaJl36GdeqXvy8E4IZfd?=
 =?us-ascii?Q?JX2Eswxhi0dOIM8Tu+eSCvcpdYafIO+8HceeHbdtdleB9KOZrPW4aIVB/dJX?=
 =?us-ascii?Q?c9Mvu6sXBLFXpYd8ltQ5+zUub3bqxSGCVTQZtA1njB4qzp4Dkyr3pkkYNgc3?=
 =?us-ascii?Q?AV+3gxn0iAVeiDMWra2tPS/vfJLNIXrJQyMiP8R6U79LmsKO/f06mYKzcF+J?=
 =?us-ascii?Q?kTxGIDEW0lRTdoBKdPdHWUo/v2vW+yWbgXp0tiD4fIDosAanY6b6L7hX8uLd?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bca2fa95-d843-4193-bd89-08dbc0c6bc9a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR05MB8857.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 08:33:20.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBksesW45mJXoVTx1d8MvhOQzsU2N4ljPOy5+V1UFIcL3YGAgv+anp2lWmFTYqQv8hcNv6oY7if08/cjBy95i/j/cuZU2J1C5u/kY5/Gygk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR05MB7130
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 09:52:19AM +0200, Lorenzo Bianconi wrote:
> > 
> > This commit adds the proper checks before calling page_pool_get_stats.
> > 
> > Fixes: b3fc792 ("net: mvneta: add support for page_pool_get_stats")
> > Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> > Reported-by: Paulo Da Silva <paulo.dasilva@kyberna.com>
> 
> Hi Sven,
> 
> thx for fixing this issue, just a minor comment inline.
> 
> Regards,
> Lorenzo
> 
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> > index d50ac1fc288a..6331f284dc97 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -4734,13 +4734,16 @@ static void mvneta_ethtool_get_strings(struct net_device *netdev, u32 sset,
> >  {
> >  	if (sset == ETH_SS_STATS) {
> >  		int i;
> > +		struct mvneta_port *pp = netdev_priv(netdev);
> >  
> >  		for (i = 0; i < ARRAY_SIZE(mvneta_statistics); i++)
> >  			memcpy(data + i * ETH_GSTRING_LEN,
> >  			       mvneta_statistics[i].name, ETH_GSTRING_LEN);
> >  
> > -		data += ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
> > -		page_pool_ethtool_stats_get_strings(data);
> > +		if (!pp->bm_priv) {
> > +			data += ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
> > +			page_pool_ethtool_stats_get_strings(data);
> > +		}
> >  	}
> >  }
> >  
> > @@ -4858,8 +4861,10 @@ static void mvneta_ethtool_pp_stats(struct mvneta_port *pp, u64 *data)
> >  	struct page_pool_stats stats = {};
> >  	int i;
> >  
> > -	for (i = 0; i < rxq_number; i++)
> > -		page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
> > +	for (i = 0; i < rxq_number; i++) {
> > +		if (pp->rxqs[i].page_pool)
> > +			page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
> 
> We could move this check inside page_pool_get_stats(), what do you think? I
> guess it would be beneficial even for other consumers.

Hi Lorenzo,

that might be a good idea in general.
Let me send a new patch set and move the pool check
to the page_pool_get_stats function.

Best
Sven

> 
> > +	}
> >  
> >  	page_pool_ethtool_stats_get(data, &stats);
> >  }
> > @@ -4875,14 +4880,21 @@ static void mvneta_ethtool_get_stats(struct net_device *dev,
> >  	for (i = 0; i < ARRAY_SIZE(mvneta_statistics); i++)
> >  		*data++ = pp->ethtool_stats[i];
> >  
> > -	mvneta_ethtool_pp_stats(pp, data);
> > +	if (!pp->bm_priv && !pp->is_stopped)
> > +		mvneta_ethtool_pp_stats(pp, data);
> >  }
> >  
> >  static int mvneta_ethtool_get_sset_count(struct net_device *dev, int sset)
> >  {
> > -	if (sset == ETH_SS_STATS)
> > -		return ARRAY_SIZE(mvneta_statistics) +
> > -		       page_pool_ethtool_stats_get_count();
> > +	if (sset == ETH_SS_STATS) {
> > +		int count = ARRAY_SIZE(mvneta_statistics);
> > +		struct mvneta_port *pp = netdev_priv(dev);
> > +
> > +		if (!pp->bm_priv)
> > +			count += page_pool_ethtool_stats_get_count();
> > +
> > +		return count;
> > +	}
> >  
> >  	return -EOPNOTSUPP;
> >  }
> > -- 
> > 2.33.1
> > 



