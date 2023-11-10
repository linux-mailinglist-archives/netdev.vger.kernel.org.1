Return-Path: <netdev+bounces-46996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 687937E790C
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 07:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993FD1C20C9A
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 06:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169D15230;
	Fri, 10 Nov 2023 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="JgL//8xe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7216105
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 06:14:36 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2130.outbound.protection.outlook.com [40.107.21.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0BF526D
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 22:14:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og3vrZxNjn/6rDqWTJ/LJoJt6K0y0yV2bEGXtpMDQs1/55lpZrZ6iiK6wuZCVMhswEYBjE3wpAQ6zQbcU9d21K1eAmKf3g+jh6m9KrSTkIXIkasDC2WSLzVDUYAwm0in29uSTkRAa7Hnvsb1wfT4l/6xd72pElD5BykeSvrGkSU1Ry4QlddfgHWJzrIi2UamH32TY3LTNoMcJXdwsptyQLSGDMSbocNYoUMhnD3xOkKFfd5FY9UI+DWR+hkw1S2L70kgXChSf8YqeJ5z/5k8CpgS7n8lBY+S58yD3DhPQkwtuo5aekGshj8pJ1SBr0iITs/RARTdIywBjgYbc6l9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eU59XNs6Qj67bcONDCRT7H3ASvHLt8Cr7TvV1Pcl7+w=;
 b=F0D2txkUUcSRRxg3McEl35F3O5YR19VgLzHxQHOuk2LzGc/2QDMJLwt1i1JxuoVVaWE6TxWUGomvsItnUIEmu1ey9ORuMk9w68bbSqUdFCLaJgmGwOJ1nN2MmLRvoj8MRUFZmWJB2VQrWG6C9sR/CDvTbtPJQqdWviAogHndGPAErxzuCgKnUxSkUnIUaCwMVsv7Ta0rfi7wmwFJt9aZfmIvtp+RbTUc42llITSuuhZMdqIBP4C+Jtrj86/W/3z5zButA6sLYoYMxlR69pofsjqBRFY1dQdPVlqR1tgkDbIIRUT7gY9E3a2SZVrtarHgwX7EuQjwWQ1GkpplYK9hfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU59XNs6Qj67bcONDCRT7H3ASvHLt8Cr7TvV1Pcl7+w=;
 b=JgL//8xesoqMPeReO1+UfTU0XXbHUC0MJBPXcOAwG4yhMDxt58ti/riVVzeMAe/c007E93Kw4wqDNz0yX8ypqhaTMIjnQm/JN0C1srIAd8gqheY4RFHLCb2mDBG/ae//i50bw6TJ3X2sX9pabRMwKgQeyi5o/YZlI44QVA028UI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AS8PR05MB10778.eurprd05.prod.outlook.com
 (2603:10a6:20b:632::13) by PA4PR05MB7647.eurprd05.prod.outlook.com
 (2603:10a6:102:fb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 04:22:48 +0000
Received: from AS8PR05MB10778.eurprd05.prod.outlook.com
 ([fe80::c38e:cf18:a498:7925]) by AS8PR05MB10778.eurprd05.prod.outlook.com
 ([fe80::c38e:cf18:a498:7925%6]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 04:22:48 +0000
Date: Fri, 10 Nov 2023 05:22:44 +0100
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>, "brouer@redhat.com" <brouer@redhat.com>, 
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "mcroce@microsoft.com" <mcroce@microsoft.com>, 
	"leon@kernel.org" <leon@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v4] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <belurnyearlc7kcqyhct5nm4nx5oznid7s5qakzjhe7x6t66z2@ezzdmjkirvtv>
References: <4wba22pa6sxknqfxve42xevswz4wfu637p5gyyeq546tmzudzu@4z3kphfrpm64>
 <ZUyOsB7p6j21e42c@lore-desk>
 <4fxnidhi7gfpzmeels363loksphtifgsan6w64n5y7dxzi7dyx@jwbe4gp37mwy>
 <ZUzDIV2SQ4U/rhzI@lore-desk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUzDIV2SQ4U/rhzI@lore-desk>
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To AS8PR05MB10778.eurprd05.prod.outlook.com
 (2603:10a6:20b:632::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB10778:EE_|PA4PR05MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ff77a6-8379-4e43-64d4-08dbe1a4b1c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bGL9w181XxwGcbz9YrbDaBl8S4438jnDw99+aECK4MrocMXm0+3EAv9iZ7oagbhGJU5k1U5PpQ9wi9GBnUaNeBdZq3u2EpHrfSRmwIuggqnZa3dEsyDqKQkr+Ob8JpVDiphlfFLrgyXwkCztqZDFzKKNoNbHhkdBPcIzzXbxUHi6rFfizg2+j2El/WrbCLct5p+6q0rHU+k76JLPhWMwAmXntqvhfiHYT3dDOhRIA5Q2vIrdDZDGz3F6U4rVUb5uNdZ9fv/WPT0i7uyI71C0LfJ2OZD3UgNgSHmqxYWbj7Yd3VSIXwBNQBA8kMk1o0g7PgT1hLr9bF+nj9/RwT90zhuYR6aEG6cJeT19gUXq2Wo7Q5W1Rn7TTiPTddecMVRf9e0y0DlxxRRK28pA1W/Pga1Riq5GPdgNX/u7ryYVJ3+fgiOYuZxbj8mIKUO4YwBSBfcDCU+/pxpc/m8ppqC1AYXgsHXNL2lCkazRhHEYv+spQyP+FD9CZIwQor58Bu6FVIhkIm/O13RLQcmUYTRZQNHbonRAlP8+gG/cJiWt5SCNeziHtHiK3gZdv6qUy/6uTZovsDI46r5KSE36R27y0M4bTntMobJBBBgkBnMQH+VxuQWxQki7CZBGL0yfAkDj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB10778.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(136003)(39830400003)(346002)(451199024)(64100799003)(186009)(1800799009)(6506007)(8936002)(83380400001)(8676002)(4326008)(9686003)(6512007)(66476007)(316002)(6486002)(6666004)(26005)(44832011)(478600001)(54906003)(66946007)(6916009)(66556008)(5660300002)(38100700002)(41300700001)(66899024)(2906002)(33716001)(86362001)(27256005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Ny+M8FLmBcNvJNNm7K0gH/7vdWBMdDpvSGycI8xSS6lBJvwqh3EkSeVvHEN?=
 =?us-ascii?Q?oosOekjJu2rlPsLygDERso+ZgSqAb+useGJ+XeaJvR1AXTjUqQC8IJHxYz+s?=
 =?us-ascii?Q?eI8fz67SRo2ukEBgM95pjPWj/+gNslAlmNHYb6/jTTR83Ddcy2fr521GS2NE?=
 =?us-ascii?Q?kPIqyy1IASp47SiLRqj1xwj3hq2Tf9FKRBiCEKNQbf928a76XabIYK4UHWAE?=
 =?us-ascii?Q?63S4RkVUbK1OLEoGsBVtHCT8uAvEMBb1MRNO9wEVNIV3t+f5GQ5lOhrfDOtp?=
 =?us-ascii?Q?keR2phQZ8eZ9av8LPxgJy51f/QYi0r8FJhbP2SVLiI3NMcqVl/BO6vJgzM9M?=
 =?us-ascii?Q?QrAr4iM6ExfKzWtg+RT3BgybV2/9PbqNlG7dgdpaXTpAAemIyxIP1rZIM45a?=
 =?us-ascii?Q?oxv8XNgDxI3ZNjkq7Y4N8nRCv8dq3oXi0ecd3Mnbf6nhmcrbAMaUymuZqOIG?=
 =?us-ascii?Q?MV2c0M6x42t2YmZdE6bsH3+s+8YzN5QYnSMaTf4gxjhO/2vVYQLnT9UkRj3w?=
 =?us-ascii?Q?W8oYOO1MVgFTZrUE+QlwbPJrfv+m6ZXSYuMytUX8hcUbmFbJsTfhc13kS/O6?=
 =?us-ascii?Q?zG1xyEc9HwP4OIQDlmN0syYfjurJBGuXHMnQntkkPUmTgB9rPMyH2rJCkPkE?=
 =?us-ascii?Q?Ywkpdpz3I/GicB25vjm6tvuQDvX+YNvUrn1fxM8G5qqvOKePkebCGf4FCo/Y?=
 =?us-ascii?Q?mFb+CWOOvOBUPR6TzEMS7lxlAuYpBf84S+TW2H2bVXgYr248btKNYqdCKByN?=
 =?us-ascii?Q?Wv3jCVR/oortk9Vkib7vEIBGe8uiO6WW9uoeReUBDmdWAfVAcvxi6dQ9yHub?=
 =?us-ascii?Q?wV3Ptj27z0Fsmmq61vMNClCD9pVS62yuI5TMgbPJYyzDRWKuGSdqKxOMBTGP?=
 =?us-ascii?Q?ehtO02NCqpy7F/UvsZqtjhRK/IEjmswmVFRJzpcutw5NVTHK0A6x5Sr/igR0?=
 =?us-ascii?Q?xOVx5GnvBN+BmXSB9K1GIiYc93jp/HFCAjRvP+4pEYAV43GEHv9XGRORQQSj?=
 =?us-ascii?Q?tT4s5ihHqMZuz2CGwmos7rBjYYR2/yGd+nelrZu/Tx24oGio8F3NZsuM1OBT?=
 =?us-ascii?Q?vYL9XtNVWQhq8e2vM7OMrOg0ooznhVG93Vif7W5PGUYGPJW0rPxRqcLXPvWg?=
 =?us-ascii?Q?QoSI+PUi6Wfq4j/sKiJnrPqjk6GB2+983pw5S6lKyJWwJa5EpIPwHK9I1Rxm?=
 =?us-ascii?Q?ElUIukiObMd+/1pv9npC2iR9uROJagyS/gKBwIhJCN7B2d9vB6QLzAKizdUS?=
 =?us-ascii?Q?h0iKPnofx6BZ6bAAYwhidc2Ae43hLeUyYpeBSggYYqBy4we1cvMBnLc7+DNX?=
 =?us-ascii?Q?77WOMbTvDYuo9IQULY6bjtLlLXRG+tO5xbyyPHOGVH/ErDbt710osK/3wv4o?=
 =?us-ascii?Q?5Up+Rrde9vd/dfX31XAkMEdFak/AZ7BI1Ayq9md6rr8+ugvqRKbZqM9J1LOQ?=
 =?us-ascii?Q?nvCqmuOmWuYOE8Q1VVBpqP539nmle5mcipyu1ZtxI8Uxtf9UHxA/C/YirD89?=
 =?us-ascii?Q?jRzT0BerqqIg3KNTxV0DaJ1QLE9ySDR6dmpz+ixHw3kYP6Ba7m4oD13pDwPx?=
 =?us-ascii?Q?gLW3ygAgpOAsk5VFjn804ssWOexvNkRpNrdS9pmDNCo/Tg+w1dxEH3w0Avy+?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ff77a6-8379-4e43-64d4-08dbe1a4b1c8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB10778.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 04:22:47.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jC6KYc+Qk2TKeZuOP4HzgO3PCBIFms39mSEfgJzWxp2tjwYFtZZDAfD4+PXSpSrEb3XJUltuBpBDqrw9UnBxoxS6AEwTiKJAu2syquhR7NA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR05MB7647

On Thu, Nov 09, 2023 at 12:31:45PM +0100, Lorenzo Bianconi wrote:
> [...]
> > > 
> > > do we need to check pp->is_stopped here? (we already check if page_pool
> > > pointer is NULL in mvneta_ethtool_pp_stats).
> > > Moreover in mvneta_ethtool_get_sset_count() and in mvneta_ethtool_get_strings()
> > > we just check pp->bm_priv pointer. Are the stats disaligned in this case?
> > 
> > Hi Lorenzo,
> > 
> > so the buffer manager (bm) does not support the page pool.
> > If this mode is used we can skip any page pool references.
> > 
> > The question is do we end up with a race condition when we skip the is_stopped check
> > as the variable is set to true just before the page pools are
> > deallocated on suspend or interface stop calls.
> 
> Do we really have a race here? e.g. both ndo_stop and ethtool_get_stats() run under rtnl.
> Moreover it seems is_stopped is not set for armada-3700 devices (e.g. my
> espressobin). Do we have the issue for this kind of devices?
> 
> Regards,
> Lorenzo

We are fine then if ethtool get stats is under rntl.
I am testing on a clearfog base so is_stopped is set on my device.

Let me remove the check and also fix the variable order
and send a new version.

Best
Sven

> 
> > 
> > Best
> > Sven
> > 
> > > 
> > > > +		mvneta_ethtool_pp_stats(pp, data);
> > > >  }
> > > >  
> > > >  static int mvneta_ethtool_get_sset_count(struct net_device *dev, int sset)
> > > >  {
> > > > -	if (sset == ETH_SS_STATS)
> > > > -		return ARRAY_SIZE(mvneta_statistics) +
> > > > -		       page_pool_ethtool_stats_get_count();
> > > > +	if (sset == ETH_SS_STATS) {
> > > > +		int count = ARRAY_SIZE(mvneta_statistics);
> > > > +		struct mvneta_port *pp = netdev_priv(dev);
> > > > +
> > > > +		if (!pp->bm_priv)
> > > > +			count += page_pool_ethtool_stats_get_count();
> > > > +
> > > > +		return count;
> > > > +	}
> > > >  
> > > >  	return -EOPNOTSUPP;
> > > >  }
> > > > -- 
> > > > 2.42.0
> > > > 
> > 
> > 



