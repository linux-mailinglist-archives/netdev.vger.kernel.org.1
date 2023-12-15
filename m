Return-Path: <netdev+bounces-57914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 510E78147AF
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 13:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC20B22048
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A238E24B31;
	Fri, 15 Dec 2023 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DuleNE0Y"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419D2D021
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgKHmFginLdMgSUAQ0FJpXCPVhYW6s2lfeKymwzl5GI/eSOhLAX5fe7NLWTYIv/FAD/pHxISYCkK4Ga5b9+UVN5I3UOMA7WI6J+4jfZX7bHs9ZNC3Je5eyy1lHYHb79k/L6Bi58VE3/NpYI80COhkcGNym2l3A7WzuYggvjF79e+tbhqN62smzTfRIzYMkuPynchYJZbwthDwXJ9NKZYAl4AXRA9PVopMX7dPwCdpnTHk4vOdhUEwK7SAMpnuEPja6xx5fxMfhZpdxEy4K3siWf6yDyxxfPa22eqvqZ/p4UvtgJdDvMh/4pVJ3Aq4RMeNXFZmx3VMc+IajEQJGp8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu6djjC3cVZPx5Hb9Q8T0EP6XdOmihxvsIJH5DcNozA=;
 b=kfc9gl0auEJQ0dXnuodi9FXWOfQyRJPKvtA/pwHeAoIZ/3frDu4fMRBJewlQQ6/U0eqaFCjesvRMIisUNi532gs7yOoAm5BV2+BJAPNvjGHihH20pr3yepT2EWw46LHPQNEf/12sO85O7OHUvj4wPqadGkvL94bnFqi7fl9zZZ7UpMWMOnHcaE+Q3f2ZXS/ZEk2t7yvWxU9Ql7thrg5dPokxCq/SgnIml1qIJx7N1+J0F73/HHRbW+Ukw1aXNq5D0AUb17YRt0ZN69wyYZ7nirGvtE472b5kSsENoRbo5AqnSNuHve5ONXKTKMZGDcZM1rVTUBdrw2KSo6cPAENhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu6djjC3cVZPx5Hb9Q8T0EP6XdOmihxvsIJH5DcNozA=;
 b=DuleNE0YjxcErriaQCKfg6wN/xTR/CeOLH7eE/12w5GguC1fpnEGfSYsKQ0XzN4FLDgty5Oiuuw7t5SIunHJvL+Udi9S97icnDI7kW7WMe4zdoR6ctguUOdR5Yi7kcYMLfu54EPOn7gTnv9RKJ3c911VdyTR/LhnGTSiTbzatvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM9PR04MB8569.eurprd04.prod.outlook.com (2603:10a6:20b:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 12:08:54 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 12:08:54 +0000
Date: Fri, 15 Dec 2023 14:08:51 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/8] dpaa2-switch: reorganize the
 [pre]changeupper events
Message-ID: <tkskehfowdrohukyhqu4ae6t56ceuwp6p2mm7r2tfzihladl6t@vxeggsm2ppte>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
 <20231213121411.3091597-7-ioana.ciornei@nxp.com>
 <20231215114939.GB6288@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215114939.GB6288@kernel.org>
X-ClientProxiedBy: AS4P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::17) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM9PR04MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c50c59c-535e-44b5-5852-08dbfd669b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sNiPOqrMF3IbuBZpjrcpBedPku9dQuQnJg2YqoqxP+o9r5/A2/MxorMMUoYfsjy95hgEIIK4jbOTbSVKJtNRjHKdt9M3GvBrMi6Nj6gIowqnYBpKQvaq8gnrUodyni2AKqIkSD3pNxcPsER/issDpqMhMUEii84gcRdgjmXVfN4/3MakrAb1N1qNhSm5p3+RAl5MD9v7tChGOZiUybH6ZAHTHjXLtlYoUdQVvXMFQjzJkQ5UJOEAwgUsB3O6EsuDHX4Abr2CwviYL3ZojG4HHM0K65CGIaIVVRe77cjMYyPXG05JxDe/pwlwATqhqkaOg6TnmIm9G/jqZv38pXHfOo9l+e+Xv0VaSuDRsHAv8r26fJRKH6t6IVtzN9xbOgw5Q/tgK7ek1scI3pyzGJ8YBxwETl3Rd376KkkvLaeUB7d8Z6DOgXWenWj1s5iJLBPqiEwA5MsaW0/aF0iX3TG0ftA6ZgEBoavwTAwhVpntd74Fv06hnLev6gURWE0Vf3WABybrsPJjJjIer0/bW4u4vTbMpL8cxkag82TO+YH9ZghL9pulgvMxBXC+8CADlDvc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(26005)(38100700002)(86362001)(83380400001)(44832011)(5660300002)(9686003)(6512007)(6506007)(6666004)(8936002)(8676002)(4326008)(66556008)(66946007)(6486002)(316002)(66476007)(6916009)(41300700001)(2906002)(33716001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0hK4YXcTAdIlWozrp48xHofjUPhzjMUYtDKp2wZzBx/0dSWnJao8lAPzL0Us?=
 =?us-ascii?Q?s9Y/kR7SZThDeARdmwSeobx3cwbXcdJjnqu8LuItVs+BgZQQUK7LIXqo4wUC?=
 =?us-ascii?Q?zn50fWZFSh8gk5ILEoIkHBIKojiHwS59B2s3FCk84GXXCMJASj2r0j2idqg0?=
 =?us-ascii?Q?0yMybLSnx3Wcy+aYLtELRGWcHOBXRSypF6/+LYxj0UaT2hmIX7jb3BigpvXR?=
 =?us-ascii?Q?MlHo07NRssab2BScnkv0wJgxfBP8v1NIZImMTxS7ukl16zJWgRGfbB1oVJTR?=
 =?us-ascii?Q?JX8JkXiOaiQFMPP8MntHsN5ZB1ptv4n7tS34E8C2RViHysdpBxU1kNxgGRfc?=
 =?us-ascii?Q?QaWO4ZT1QvgAd6n29eyzZUxfpo8cInUGLTzvCNphASfdGaOV2/DRhzY6+vs8?=
 =?us-ascii?Q?j5M1Gy4IlMg301AnN58HpBOY7qtPCy2zVnfqQt1g4kHpD3cBR2jdHvPbQK4T?=
 =?us-ascii?Q?yXWcW21p1FojT4SyMZ6UrtCzuIdV0XZrYQi9+sufKGiFbFPeDnCcTUDfNw6+?=
 =?us-ascii?Q?IGa77WIprizMB6EDo8BohkZ+42QFBIHlOb4uMqQuRc3qaJTkzO/oF+GMiC8s?=
 =?us-ascii?Q?rIKFfaVyCg/ms9GdzH2RqPbv7QIpc9FkDuFU9O8ooJrgEcT0Og4FwoYBA2Om?=
 =?us-ascii?Q?uBuUVhxIOvsOqey0cG4O+1HiS7CpMBZ/SPcSH1HxDxi2d3m0VSgeH7xd7zrH?=
 =?us-ascii?Q?0Zqz70rSFYXHTRCZtLB/pb5v34lFeQ0sAWUyyszC7yAUOBfYNBIf9pVka0Z2?=
 =?us-ascii?Q?uXFRkAcOHk7LbZ7sx+7AFVcWjMOn72PIZy7LRfiSmG3iRa6rnIckxNWuZHdM?=
 =?us-ascii?Q?Ghzzuu0nybgLz9ZXJoy/AT8CVTCJVjxMEzHYaMKhhk6Be+voANNyzVET1Owl?=
 =?us-ascii?Q?jSTe3Pj4eehZ8RJDJW1gC7uX3m30ca+v8nCoG6txzUPAb0sYHy36kNLsk2dU?=
 =?us-ascii?Q?88p7Y0rXAePMdmy02cQn8/dB1SoOAhB33qlsoseX7d4+68vpRan1VUe7I7pA?=
 =?us-ascii?Q?JxNbsL13+5Pc1AXfnD3K+vZX9kqG1wJgjzLdzxj1/DJBgUay8AefIgR8+SMS?=
 =?us-ascii?Q?cGEcEqmdz8gL+mtdBKLL31z71lSdX0qktI1EH4kw3EJ6GF4pkQZccxAw641b?=
 =?us-ascii?Q?+1ZWG+h4rRUfYGJBJUDmXDMjOjCwN2OsnshgbCCmLkOAcYIx8uZBHy3lCXHt?=
 =?us-ascii?Q?5Zn+5eLKOh2bi4EuDdz6/80zdnCYPqcuSo2nPGD1wULwgZGj/ot+kU04QLPE?=
 =?us-ascii?Q?AMdQ7sXBGZmlfBG8ufyvnJkpaujE6A2rmFPzBHSkqxayy4Y8jxfx+7ED+Y0a?=
 =?us-ascii?Q?InPrOB0g+/Acl4LE9C1975u2qgeLsDLbv3TksqQ7kqaMpei+DkaqjqnmVzI4?=
 =?us-ascii?Q?wJpSZxPJ/9bvwJI2IrdqXL220ZnfoorHkD3mnvwTnAYZyMd8Pq2n9xgJxjYF?=
 =?us-ascii?Q?2xztMdMzNgM1e5xvbKaba3ReKCqndy08jyypdUO5MBQpYX1hTxTqlXJO0RRv?=
 =?us-ascii?Q?h1QJ+E5O3hftUr2I6soyAvKvxNUpNgOQOjqy7SqH3llDw52UWl2iN54o5GXS?=
 =?us-ascii?Q?IfzsGGsj544HRBoJ6eBa+VNZVnK1inYtCaowieQh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c50c59c-535e-44b5-5852-08dbfd669b7d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 12:08:54.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eil2bQb5V+MxueEVEyvyT5mHfIRri4J6hwDYVeqbxn/49eog3IHf4QUe/9RQhfBNIYO89Tw4mrD3vfJ2pXrFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8569

On Fri, Dec 15, 2023 at 11:49:39AM +0000, Simon Horman wrote:
> On Wed, Dec 13, 2023 at 02:14:09PM +0200, Ioana Ciornei wrote:
> > Create separate functions, dpaa2_switch_port_prechangeupper and
> > dpaa2_switch_port_changeupper, to be called directly when a DPSW port
> > changes its upper device.
> > 
> > This way we are not open-coding everything in the main event callback
> > and we can easily extent when necessary.
> > 
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> > Changes in v2:
> > - none
> > 
> >  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 76 +++++++++++++------
> >  1 file changed, 52 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > index d9906573f71f..58c0baee2d61 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > @@ -2180,51 +2180,79 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
> >  	return 0;
> >  }
> >  
> > -static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
> > -					     unsigned long event, void *ptr)
> > +static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
> > +					    struct netdev_notifier_changeupper_info *info)
> >  {
> > -	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
> > -	struct netdev_notifier_changeupper_info *info = ptr;
> >  	struct netlink_ext_ack *extack;
> >  	struct net_device *upper_dev;
> >  	int err = 0;
> 
> nit: I don't think that err needs to be initialised here.
> 

Ok.

> >  
> >  	if (!dpaa2_switch_port_dev_check(netdev))
> > -		return NOTIFY_DONE;
> > +		return 0;
> >  
> >  	extack = netdev_notifier_info_to_extack(&info->info);
> > -
> > -	switch (event) {
> > -	case NETDEV_PRECHANGEUPPER:
> > -		upper_dev = info->upper_dev;
> > -		if (!netif_is_bridge_master(upper_dev))
> > -			break;
> > -
> > +	upper_dev = info->upper_dev;
> > +	if (netif_is_bridge_master(upper_dev)) {
> >  		err = dpaa2_switch_prechangeupper_sanity_checks(netdev,
> >  								upper_dev,
> >  								extack);
> >  		if (err)
> > -			goto out;
> > +			return err;
> >  
> >  		if (!info->linking)
> >  			dpaa2_switch_port_pre_bridge_leave(netdev);
> > +	}
> 
> FWIIW, I think that a more idomatic flow would be to return if
> netif_is_bridge_master() is false. Something like this (completely untested!):
> 
> 	if (!netif_is_bridge_master(upper_dev))
> 		return 0;
> 
> 	err = dpaa2_switch_prechangeupper_sanity_checks(netdev, upper_dev,
> 							extack);
> 	if (err)
> 		return err;
> 
> 	if (!info->linking)
> 		dpaa2_switch_port_pre_bridge_leave(netdev);
> 

It looks better but I don't think this it's easily extensible.

I am planning to add support for LAG offloading which would mean that I
would have to revert to the initial flow and extend it to something
like:

	if (netif_is_bridge_master(upper_dev)) {
		...
	} else if (netif_is_lag_master(upper_dev)) {
		...
	}

The same thing applies to the dpaa2_switch_port_changeupper() function
below.

> > +
> > +	return 0;
> > +}
> > +
> > +static int dpaa2_switch_port_changeupper(struct net_device *netdev,
> > +					 struct netdev_notifier_changeupper_info *info)
> > +{
> > +	struct netlink_ext_ack *extack;
> > +	struct net_device *upper_dev;
> > +	int err = 0;
> 
> nit: I don't think err is needed in this function it's value never changes.
> 

Yes, indeed. I'll remove it.

