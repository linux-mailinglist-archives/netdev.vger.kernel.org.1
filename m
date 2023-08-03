Return-Path: <netdev+bounces-24137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9095976EED5
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47962282242
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0C024169;
	Thu,  3 Aug 2023 15:59:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA4E182C8
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:58:59 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B98A115
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC4ot31wwrWWnhdPOQ/UJzjwZhS/kbqkvVTLFcunN665YSN1Y76JPjaoJtkHHWXJQuAdaFLUX04CLpbHr7wuADylxK5RRBOtmVb4HpEYcz4nGxsgslIA2shnE6TMa3+bEUi9DL9lIwAU7jHMhRG/bIFOyTuaSKrjz4r0czygTSDwUpbDG3qDJSWJgUPfeQS5WqxMZCKU6Pe6Rn2nWbEOrnXE+2rFTTq6tPg6iN9WqgapjA3imMdqnQ3w2UhOeN6klBJL8OvXZFW2gTsHqO3+1UdMe//0X49Z0NakJsG85TiOhvTktWytHDwpc4p+8q8nY1wBjxa0WIcHRVcUBmAmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnQzDuhc1reLK+fbefdF+D5p80ARwjzuaaRLIEPPYUY=;
 b=Cyz2tvLj6HbCfYB0xbi/ijjPyGc3Fsxiv+WfOu6GLlHyHZvE4xE2oddJ4cojJ5I81n7PdTowwXL0xd4b08coKq121fxCltAi5FPe/yh5B+6GIs9hYzzob3HKFkIJBETPUI8I01sm90DeWSxzPnxORULrB9UWM9lCV5vVur0YMsRqNfGWVQhGOD4qqwmKSTZtfypOgQgUyRUFH1DWsIoUrPFGRNNPwx4/jumYY14gMBTt9mU29aoHKUo9lr44eJLEvFsgwWhxiM51YYKyc81CdfhY/QVddDVgKJCEfQUPZBGORMOBIeiLKCfx/AHcXryoADeM9JiDdKe4cw4Fq+QzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnQzDuhc1reLK+fbefdF+D5p80ARwjzuaaRLIEPPYUY=;
 b=Lj9UBIiaA9yDMWDMb0ZpmkPiOoRKiJ67cdbJfgXunkzeYAjv/NV6yzDBtVr2YeTUl++93q0qAOdtGaMPLIQNsrw+P6lT+hHR/Pa7tE77FLqAZE7ZD6L7vSkdypUnm1Gs6/aRZMK/fm7chbxtrZsEuyLC0C7oRSgN3kmBavZQiSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM8PR04MB7219.eurprd04.prod.outlook.com (2603:10a6:20b:1d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 15:58:55 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:58:55 +0000
Date: Thu, 3 Aug 2023 18:58:52 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@idosch.org>,
	Vlad Buslov <vladbu@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 2/7] ice: Support untagged VLAN traffic in br
 offload
Message-ID: <20230803155852.glz4rqvrhx55ke3m@skbuf>
References: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
 <20230801173112.3625977-3-anthony.l.nguyen@intel.com>
 <20230802193142.59fe5bf3@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802193142.59fe5bf3@kernel.org>
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM8PR04MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: e0bfd112-0543-4276-cbfe-08db943a8a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qulalSEUeX0a7AuyOwI4tXh8Pa/m+vnxGCkrNL+RbQcDLomJXCwLIUmlP10AM3xG9dR7deqapQJxp7ffmFHxywkS89yOzRa7Ggqm0Y8l43BRa0MrXMcNpdJ1qVw77UcHVw39b2zYCHuqFRIu4kbIGJh3UNG3a6OWh+nHuYRRQbaKCbvpN8DDBo19DV+WA87mk55vXHNV4X2skdlvfRv/DFEMVwPoBN7H3osvmto6RO9PfluZM2MGl4wIB4toh/098UaFjjChjJ3U67vjJPn/c5/b9P0RAw9o/oA/jLTkqYcaIunCTYgI3ZPwdrAkvadFhW1wEZA8awxql6DYgAAnEel+sbjWq1w5PsD0iqtUr3i5ASn9R90PBEL9r916ru+YyertLbe91hzOzQsyFGvxp1EGI5I3A4P9Wx2DncIyzi6d8pQKfsPecDFypY3t3Er9/wDNNVKd2CmabPeWlNtmZUbg4OdQ1GpiaSEEmtUfd5XgMjUiNgcp3gHg0zAs61+262XqWQlb4cPL6+VjXw787q8WZd7Ra5r/DcYSYKSWAr1IN1ZE/ypBUvu8eKr8unCE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199021)(66476007)(66556008)(54906003)(66946007)(41300700001)(2906002)(316002)(6916009)(4326008)(44832011)(8676002)(8936002)(5660300002)(38100700002)(6506007)(26005)(1076003)(186003)(83380400001)(86362001)(33716001)(478600001)(6512007)(9686003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WHqAIgiNZUT21g6LqWydTigPUVnIL91KvHTDSpg8OP1DON0pqLBXNbH6aP1l?=
 =?us-ascii?Q?IlH5VH/RJysI5bcT6zZbZ0/TKMAGXbgW8dc6ma2y9ch6J1ugLK70WPaHliOF?=
 =?us-ascii?Q?FF07ILenxeM0xov7bs08EvKx7RyTc25YKG5UYrC59Itl6WpVnkqN4kIMPeYa?=
 =?us-ascii?Q?dfnFx8PIB4WN/T+04fs24H/gkUvD5LAhoXHtUAdeMW7hNKjXcCKGoZ7ck+J9?=
 =?us-ascii?Q?znoLw6sEq9uIz8tjHXq6yqAEpM0SJFdZqyGPexVtjtJKpkgPP7o14Bk0Jfam?=
 =?us-ascii?Q?LB8ls74IPbyg4YSuFOn2aZUXoao+A9xXWYZqbtCdjLO1ey3s8hDgmUF75yIl?=
 =?us-ascii?Q?v7QAgc4IfJhZ02JJyIELv9lfMxMPvg0oB6k9xT+kPlm8Pih67j+7yqQSZbrP?=
 =?us-ascii?Q?1z1UNWC2A2bWcrsiD/zDsIZtP9drOJcMI+Xafl3Zk3T8k5pKRdxxJ+s8yp9D?=
 =?us-ascii?Q?MsrRBfT8jmojdyJpUqMomKj5N3krmo9lBn2FHTc+gW7KEGqo0JA3uGWh5oew?=
 =?us-ascii?Q?vWqIgPkkVPs+Bvig5kQESMPc+z6dvMh5eIulK2fZ70qwbIvGMgIVGI8criWp?=
 =?us-ascii?Q?9V0phlEQb6js5nKpOLUyCFOVcdSUD4YmPqUFLppuTZugnLTLjfWgpPQeayCq?=
 =?us-ascii?Q?hbgI4AuD4p+Sxo8r3klftfLqgSXBdNQrVoJmVqWlKadWrepkutPwuu11amZ1?=
 =?us-ascii?Q?3Szl4/9sDxMW4DrGh42KJsV/2xbFXKRdUtH+FRUkCr91Ere9rNWf3MyJiM2d?=
 =?us-ascii?Q?gSlIXoH9ljlDJgx/aOxfGVdfI9RCH3HSSCsF/bYZ/xaEjaUaERcawl6C8Ncj?=
 =?us-ascii?Q?1y/gq0KKRZxVUfvFLXZJuywXUhWbMI+XgGTL2DJq86qnx44Iz/+577vcEVl2?=
 =?us-ascii?Q?MtwoHzZCGPdk8FPoxN9vVL9HjbBk1z1uuksVVLgQjXP9ZY2gSTvuoPzgvbgI?=
 =?us-ascii?Q?PfFqeBt1vP8OAkFWEvifxonRMqUEQJr9pf40TwyK4/aO8ehVH5nf6Pl9C+aT?=
 =?us-ascii?Q?leBjeVoK5Th7H2WHpIKh+kvx8/WTBuAn38ObiHzXEglUOcYcErX1hnBPPYuh?=
 =?us-ascii?Q?AUth6RbDDVmR+wD7xDaPKpd8epWN1X47TpffWSdUn5wYMe8hUzdmVsZC8eXL?=
 =?us-ascii?Q?70MvemNb3HF1CG/ekOU6C0JggmuZC8vTVBFl9s2mYlBgomfJ1wQ4t6jP9Z/t?=
 =?us-ascii?Q?RYPiO7RWdn+D7/74gty8/mOn8uaUK4CLdijY4rtOKyj9C3usOqsYoyP5geHA?=
 =?us-ascii?Q?ia/eItYrYIC9BTHNhwOCaqBV71ZcDjWjKoJZGx4ztgG6QRvKJ5irJ9KAPSL9?=
 =?us-ascii?Q?6vcAHnJFku3QDxyz2Pn6lJBB4V0mM3Dt1GfHkxKDp9Y9VgIIxFftAOpF13Jf?=
 =?us-ascii?Q?RAN+XgYoMjIGt35rhP/WgJYv8gYD9+6ZOZtVX2IatylVEFpdgTbg9ZmT9tux?=
 =?us-ascii?Q?I9Gnz7oR47wB/kJzXuqvDcMWzfkjVm8xHYBGVcalo7rvwZCD/YB8VpcPnwDq?=
 =?us-ascii?Q?UJt85WUlWIn8Z1vCvzZVPeDyJl1Sj22+s7kER5ATCCkKTZpjCgAiwFN5riJG?=
 =?us-ascii?Q?OCbD2A5drcYw3errr46e302BN3kqn+Wvr2MeANOpLgutcczQ/ZKSLAw1Oq7l?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bfd112-0543-4276-cbfe-08db943a8a85
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:58:55.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NncXck14W4d4woe4n64vbX6I8o6TxtBonLYrBUTvXFX7Bqh1e0eI0BwMwTYmQNp6gZgaEeKtxVLa8Bfj7VWF6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 07:31:42PM -0700, Jakub Kicinski wrote:
> On Tue,  1 Aug 2023 10:31:07 -0700 Tony Nguyen wrote:
> > From: Wojciech Drewek <wojciech.drewek@intel.com>
> > 
> > When driver receives SWITCHDEV_FDB_ADD_TO_DEVICE notification
> > with vid = 1, it means that we have to offload untagged traffic.
> > This is achieved by adding vlan metadata lookup.
> 
> Paul already asked about this behavior but it's unclear to me from the
> answer whether this is a local custom or legit switchdev behavior.
> Could someone with switchdev knowledge glance over this?

The only special vid is vid=0 (and that implies a VLAN-unaware FDB entry).
vid=1 is not special. Packets match on an FDB entry with vid=1 if they
are classified to VID 1 (obviously). That can happen if the bridge port
is VLAN-aware (bridge vlan_filtering=1) and:
- packet was untagged and pvid of the ingress port was 1, or
- packet was VLAN-tagged and the VID in the packet was 1
If the bridge has vlan_filtering=0, the rules are different, and packets
should only match FDB entries with vid=0. Both the (bridge) pvid of the
port and the VLAN header from the packet are to be ignored.

