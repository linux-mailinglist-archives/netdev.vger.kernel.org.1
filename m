Return-Path: <netdev+bounces-24358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0C076FF3B
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 13:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055502824FD
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD08AAD43;
	Fri,  4 Aug 2023 11:10:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E8A5250
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 11:10:53 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FC6AC
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 04:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltncyftWeuyo6zCxVDEW0Qp4uQJXl24GsYo7WO/08ERXh4Udm/C3CnE/A6/UnmM8CeP305Xuv3y3xp8lI3q0KB/B9qrJUQ/GRQ7hmp5i4uBPpXDarXiSWtMTp1zMPoUr9Kiax+Juv/+MRymDaFYzGCGHMFauJcIHYRLpVShVfZSxsLPWD5MvtLrC1CxBfrKjBfsEnfcbz/qD+KeZg842ihtZdj1okTsfR9VrLvf2/hq+DFAbFlxjCRMljUGwNuYSiPP3mpbAjpxc/k3kzX9mg+dKZOS6l8yMrqlTs1zJJNaVnSJHtSwVm0PSvSYpSXE0MlkVgOO8nlBBuNZaaZ74/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjGLSNh0wi7PoQjxVUIdj9wLNeSBKKwgUmFHjT7rQ0Y=;
 b=MDlTZxBi2L4BwdcGDTdL+X/crJRLh+gEoWwp68v3vVB81vKEX5RxZmQxMOzxKpIOI2qnVdV3JYAdebloSUbAd9LhVYxw8X2G0jyIxZLEd6yy5LTREMUVCtCW7H5xR5tQn0YY11onLFE4zdsB5iA7ysPhC3KgNTqTMn3tfG5ktPMvL3JtWTnNqsS9ZBJD8kKQEvPQ70EEDC/GAAFqfUobZR7wWeOY/YDpsq4x55TtnO/ft0WmDm97EOkvJdNXQIjTqvlHnp7w2L1q8W1Sm2V8aMcQy9f6tTXZaxPw/OECqpbfv8Vxcby3fJZWqg3Xhay19aeXEtqGs3UHw6HWZKnwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjGLSNh0wi7PoQjxVUIdj9wLNeSBKKwgUmFHjT7rQ0Y=;
 b=S+4Bj7USKn7aX3vtmn3PHAlt8RMuJdiLbsJCSUS6pJc3xgHh5YuxUHmEQ8ieUZ5eJeIhx044FsyQhzSWSJMaAY9TSswlSguAKSp7qzJOpiwoeVsh33PZDWfeUTkhVsJsDTB088utpbj8om31oemaQF/ruMYmCIZt25K8xhxq2WM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GVXPR04MB10021.eurprd04.prod.outlook.com (2603:10a6:150:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 11:10:49 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 11:10:49 +0000
Date: Fri, 4 Aug 2023 14:10:45 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Colin Foster <colin.foster@in-advantage.com>
Subject: Re: [PATCH net] net: dsa: ocelot: call dsa_tag_8021q_unregister()
 under rtnl_lock() on driver remove
Message-ID: <20230804111045.rk3yvo5xb4wxyvoa@skbuf>
References: <20230803134253.2711124-1-vladimir.oltean@nxp.com>
 <ZMwAImhL8nH+6KLf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMwAImhL8nH+6KLf@kernel.org>
X-ClientProxiedBy: BE1P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::15) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GVXPR04MB10021:EE_
X-MS-Office365-Filtering-Correlation-Id: 48703f30-7bd7-4198-731e-08db94db7571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sCJFjTMaSZFLr74+RY0AtjzeAM6SVy5ezJiw6Lp07sn+0CE8tYm0helbwcxkphR/cVLoLX20sBl2FNA18T5cdnL3aI1NWuynhTumCLZLP+tprw0N8+8nEPtGWP6qOqzxpNmTc6L+yG9ekZYXYeJB2oF8Y0fhvnTbm4PTxZMDNTwgVW0XEyNd5/RukBc6BfzT1nDExrp9yaCeFpEp+fzRGqEE6PL2z26l7rpDscNV9xLgv6gB5qK3qaBUgvxcTlKkSlbX2h6VtUE5LrI5JjRvDTPBYyI6zQnRKOtdDCT3WodprYWURl/Dgys869haBwsThAAiLHkumZRVdzn99H2jRvlAGiy9RGGZFWpq6oenWOjpmkuawtWoKSpUk9u4WuuvWBKQwmkAy1UHypaM53fk3Y3/JwW5uPsCPtqEFYindoq6Mn5EkmlK/gzRGTsuMpPOQiJrHJS1mHpHX3Y4bY6TuMQVCOFjLyKx45f3Cfnhn8RG5jkCywn2vxX+mIudrdakOvRWLziABOqBExDBSskWlOQ2CS7dhKpJ1/aDB7JfjoaYE5JDgUnbe//fZYqDxnkU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(1800799003)(186006)(41300700001)(8936002)(8676002)(83380400001)(26005)(6506007)(1076003)(33716001)(38100700002)(86362001)(316002)(6916009)(478600001)(9686003)(6486002)(6512007)(54906003)(66556008)(66476007)(4326008)(6666004)(2906002)(5660300002)(66946007)(44832011)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Br5FJvy9Szkc35wx32lHMxmTIEBz4rQwpBIdr+7y8jt9BKzVe5c2ZIgIH9K/?=
 =?us-ascii?Q?3ZaPpaX4KRDQH9zUmTYdkzsHyRacH3YUQxLZANJbxIqqNdlkZgn1NxGoH+qJ?=
 =?us-ascii?Q?889V64CMJq3O+jm8CHkelFCTmPxONS64Vm8mkwG6O8/vOGXvzIyzEbEPScU/?=
 =?us-ascii?Q?vsT5Msw8FkCz8UuH4C+0LVp+1caZQM89LeJBVH2bYIqZvjRWBUZ25cHfo8Jq?=
 =?us-ascii?Q?N51S65VDh41SDuyAAmRNJNNTOpAzViU7TE/AHaEyZYUrKCZXLxvAL9jxO8QT?=
 =?us-ascii?Q?izGbwtFYmCwHD/zVoUp5pUrmj+NX+DqcxnpfQD77wEuQSXyhuexh6E7apt+P?=
 =?us-ascii?Q?HBYYmVH5nt233Tzu6/fCBgWiGrlrcKNa98qIFwY3NcFxziGUqwmq7nrJHSN4?=
 =?us-ascii?Q?wywobnS5qYUcW2L3hs4nsLd9DHnrdG/gORw3UUkfUUO1t9jL2gAkFMoEGo0i?=
 =?us-ascii?Q?J71BFhaA/1bYDm2RYk9vxatKvZ07yzadN7QsW2pHpE3PqP58LjvA73mLikgb?=
 =?us-ascii?Q?BalTjbTz8TIcGLj6tNu0M7EgHkhjS3iIXIf3MloVHhMH71MlAf5CoWaGP13i?=
 =?us-ascii?Q?8APIc6D96uzGq/vl773ntnykS2RendqRvONE5KCKVCDNrIkT3EK1OH1cOc0j?=
 =?us-ascii?Q?nwvhZUJXZlSv6SMqu/9C7FAVS9f+JCM8i2zMzcwCoHZfIO7DIAeOcxcQIc01?=
 =?us-ascii?Q?7FCSESp6q3c9MptPemb+2ivFR4uUHijpIMlHxt9UtWzr7mr/2iPlg+BlI52x?=
 =?us-ascii?Q?5L0BujvWDDyX5ERbxkscSPKHL3EZiB2dfSuFcLod7xhNZ0cHVIOFdGJ5GzIO?=
 =?us-ascii?Q?63engtRCeUbhyRUyyG4fh2ixpB63wGhFPft7xVXsseTdtG5KKSlyO5AsPEUT?=
 =?us-ascii?Q?dbWSDCKjm4Ca+jUqwDkA0ZYTozCpQA4mHV8E11E31FgxLby+MxNL7N4dkgsS?=
 =?us-ascii?Q?nC1IzazRdgLcKSh6zS6exsDlJWZ9Bywk5pAfITJhe733IcuDTPD2hGxU81mV?=
 =?us-ascii?Q?w7yOGpxGA4H00bSvVDMT9x1OvhggAofvkrdhLJPWzx6eLxi+le8DK4DXoWWX?=
 =?us-ascii?Q?p6zURaiWuCVrpUvMTbOmtxEthPzPN1JRUXpFcW9lUHfX5iboTznczQoU8l3D?=
 =?us-ascii?Q?ODF856WvgM33gHI/Pj5YYh2FgP43GGBxWYEbvq0gOyXDdiH6iiiIuYuYhdkn?=
 =?us-ascii?Q?fnla6negXwNX5I82Zr4xpJFFWvkKHRaFR8i1h500GQ2gA2UTnub1G+8+Eoua?=
 =?us-ascii?Q?co+EBiKVb4gIuk9tjJaR+PSbAdAPsPdM6z5TMUlouUI4hca4bbP/NRJChvbX?=
 =?us-ascii?Q?OAam8v8+uxHPYPLLRfCHgLkLTz6XRjgBIQnVrT6Nr66bOB4zeJuI7Kuis/1+?=
 =?us-ascii?Q?iJUckGPE6ZwAR+hLp+a4kbDPq7xNtx+eQjmOvQDKo1d4BZGXyfcgw7Nb0EdV?=
 =?us-ascii?Q?GWc6vdbCh74FamZhY+sIljbeew8t2p5HKNMjIuQGmwmgvTpRQhGSlgi0ylvy?=
 =?us-ascii?Q?+l9c1CDMyBoGvazJj8Xp/RuPlNJIqPads3R6tUPEFTthDvmV0rj+X0qFJh+l?=
 =?us-ascii?Q?s2JVZI5/Jc6KjpWwFwlVnrPHNFudY2ahzpKTn0jd/9qc2N3f/f/l5QwQuRiE?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48703f30-7bd7-4198-731e-08db94db7571
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 11:10:49.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVs/DO/wTCKltxfUqD20T0dAqXZvpClauOpCrSoIbTRSWRvgmz721r7r53aKgPPX2zhr76zSCSB8/oC4WqOzlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 03, 2023 at 09:29:38PM +0200, Simon Horman wrote:
> On Thu, Aug 03, 2023 at 04:42:53PM +0300, Vladimir Oltean wrote:
> > diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
> > index fd7eb4a52918..9a3e5ec16972 100644
> > --- a/drivers/net/dsa/ocelot/felix.c
> > +++ b/drivers/net/dsa/ocelot/felix.c
> > @@ -1619,8 +1619,10 @@ static void felix_teardown(struct dsa_switch *ds)
> >  	struct felix *felix = ocelot_to_felix(ocelot);
> >  	struct dsa_port *dp;
> >  
> > +	rtnl_lock();
> >  	if (felix->tag_proto_ops)
> >  		felix->tag_proto_ops->teardown(ds);
> > +	rtnl_unlock();
> 
> Hi Vladimir,
> 
> I am curious to know if RTNL could be taken in
> felix_tag_8021q_teardown() instead.

Negative. This call path also exists:

dsa_tree_change_tag_proto()
-> rtnl_trylock()
-> dsa_tree_notify(dst, DSA_NOTIFIER_TAG_PROTO, &info)
   -> dsa_switch_change_tag_proto()
      -> ds->ops->change_tag_protocol()
         -> felix_change_tag_protocol()
            -> old_proto_ops->teardown()
               -> felix_tag_8021q_teardown()

where the rtnl_mutex is already held.

