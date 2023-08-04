Return-Path: <netdev+bounces-24491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C40770585
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 18:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5E11C218EE
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D91988A;
	Fri,  4 Aug 2023 16:03:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A083C14A
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 16:03:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2101.outbound.protection.outlook.com [40.107.94.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C336A5245
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjerIN3fJWNVfM+8kfTAp5qyP3+5FtcGH6E+slIzZUSXbd2H5xvwj5MXMVpX8Z9DcaBPaxJIMs3SfGoAGjUTCzAmwS7U7P87m5/DCXj14S7r66O9mPt/FyaPGHIA77WmVE8D216TRFIfHH681JYnIAdHk1ZhrrBdNax+lL6EOXX2xBjyEGXUw0CWJocT9YZS1imMc8AIpmh3pektP5EMShD996Sw/PdUAVxzKiCpPP+wYl9V6eKl5ZWJXME8L+sRakgRM+AWrzyHlHwdYim5r5S/ChgFZnVRRkaxO6TCbOi5IPwklGuFH2YOn1Fd+9PStmnvH2/b1sxo/r7hm9bxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAWkZMgxcwTq65Hoze9ur32O29uuWzivrdgefCqvL54=;
 b=QpJddJjklH4ivF0CbjtQFekAHYn2MUEiZGwPjO0Ok2+n4jIK1VacW4N1Ip1+Q8lM7IXUK9GHg4HN1uAjINSGucCCwOgg+J2HAXiYDJhJZ1x/3uXgc6xV8ksGzYhGJlPXcjnu+xDseoQtx1JiSYWT8rPNnxpzdNQWc/56ZO4LvD/83VJsF96TGJHbf8v6qjbd+CVYIRPqZPtQfHARWXsNpyGbrA3iUPAycCj6ZBNKH+SGpXNZWk5CQyOpbRfp573YpdCFgiv+OZzxPg8esw0yfEAVe1cuJeova7TMoVYg7BkTVGopvQWg+AKV+lzMKIHtmhkB+pBu+uH0xbf14uSTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAWkZMgxcwTq65Hoze9ur32O29uuWzivrdgefCqvL54=;
 b=w73FwBBYbe70Dp98hnnrtX0QJRiQpm9q5FGgjECrGsQTKXsfZGqWShB/BSzV0RoXfT5ZTINhkkbpmImVLeJRSvyRKczMQUTu+0Ndct2b9iaVHt6vL5Oy0P6/O+xjvMmG/ZyX5H05LuPou09qhUSWxzcnz1oiEup5GokY2JkzJFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by IA1PR10MB5947.namprd10.prod.outlook.com
 (2603:10b6:208:3d5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 16:03:37 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::5ff7:e83d:39df:dacb]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::5ff7:e83d:39df:dacb%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 16:03:37 +0000
Date: Fri, 4 Aug 2023 09:03:33 -0700
From: Colin Foster <colin.foster@in-advantage.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net] net: dsa: ocelot: call dsa_tag_8021q_unregister()
 under rtnl_lock() on driver remove
Message-ID: <ZM0hVTA7nHuRCSXa@euler>
References: <20230803134253.2711124-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803134253.2711124-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|IA1PR10MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f56d171-a98d-406f-d03f-08db95045cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	186P33JJmm5kAbC2AGVV7ICReOVfg1xdeLXGy7FgsFz0IFs0eX+7S1AjLaTEWEKBFB17YbC+OtjILUXbbxIFfrelrqB+Ys11XZOESbt+tFuayvcGvf8LDdKOYXUlLEzTDYStJWMeAzeanAU5FUWwkS4qKbxLQewadbEK3woArLrM1MUHDBznky5urEHklQmuwzfBaob1lkoabBH2yIwEvTJ8/dcHD8EcOyLECE30KSPVYp589Pnpk1XSAtG/Qqtlrd49epVu3cxvJXj0GW9Qb4bbH8oJ7GKnP6Poxhn1HJt1r1BrVvGWoKayjTr/buv98pi13SqxV7rFXUWqdLt7yccx7CaBQmMA1IjUA72KyxmCwYE6wchQBgLXLI3QC9NJ627LwOY9EVjvwbIQTbKTCwB/iVPAC2gkF9+oCXaVIwwYoTDrI5WGNfuwa9ObrHrXJmlDASxqR3HG3+Ys4HiGpUXDTMyfd96l9Y1bJAlZhroAGbB1zKLQF6H4/itqnTcrSYMeECWBqSQk695qsXsPd/MPrYEXFnBasJSZ083IdyaSM61LXFAYKjF9si6DVZxx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39830400003)(346002)(366004)(376002)(396003)(186006)(1800799003)(451199021)(83380400001)(6506007)(26005)(4326008)(66476007)(6916009)(30864003)(2906002)(44832011)(316002)(7416002)(66556008)(5660300002)(66946007)(8676002)(8936002)(9686003)(41300700001)(6666004)(6486002)(6512007)(45080400002)(54906003)(478600001)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/8mRW/jrjF0xPMTUfRqlvXp50qSNLLSrwXSTGoLNe3EzW9Ba8/q1Zz/T8oC7?=
 =?us-ascii?Q?Ti0TQwulrxHkSHnaWVDUoOCHmfLkOj+joUsKHUssnojZb5zpPGdEWaBY3g9e?=
 =?us-ascii?Q?XCd7tkxMuEbELzDINBGuRghNddgRpKCaz9suuDDvwaTrc5uDK9ZWJAKqR22X?=
 =?us-ascii?Q?MFJxhomO4O1v9Rqx7MvGCP6132FvBY5Cmtg2e9CPJQs3iUTwzIqTBLuNq+LX?=
 =?us-ascii?Q?/YUT/uiHgSeWUl+XfONIkknJl8hqFsUfuKPwYqXcMcpBVK0gy2LLsRatMCsd?=
 =?us-ascii?Q?KdICCEaLWUHyVeMpqJeU50mGbJADYc4kUBGyeGrv8Uwl1HceHZwKA5W3KyQg?=
 =?us-ascii?Q?5rqpm7hozJBGm2xizxnKFqHQ5AhO6N1EF55jg571Kl9OOo++2WKyDjkVRsD3?=
 =?us-ascii?Q?9SLBW7hxfR827PvEjovyhWwopUSntOHCIb5xG1TcJhtU1HwUjki059SZq5+l?=
 =?us-ascii?Q?dUG8zwfq/zI+Tf98hPG9thw4inj6l0X+HEUbMB4uz1nGt7RXq92BrUyscese?=
 =?us-ascii?Q?guLZnFZmgwIqzJYj9YdbI8ibz1eV74xyDt8owB+RPAD8NElzap6+RMpDFl09?=
 =?us-ascii?Q?9YUxi33JhH6GwEwvx7D2gm6GYq2F8aPGuWph2DcvNgTA7KrTo5nZihWjUI1k?=
 =?us-ascii?Q?8A5nn6P0Gqe1xFRywitAKQpfd1X9d2pyfruIFPFyegPjrbnXu7iG4Ve2kbw4?=
 =?us-ascii?Q?aAnUUQh7uxIAD7ivhiPpHpyVXI1JdeIHg3Yf3BHHq0neTpzajd+QwTfTuwri?=
 =?us-ascii?Q?MpgH8wxDUsESBbj7YyRshTZztZk7AvRdfC2RAdeDZfa/TO0lUEvF7bNOvB3W?=
 =?us-ascii?Q?07aPaAds9Ki6RhmcEK46MBL58KNLNJ8DiHn+2PDOFOedanwcD7564wM2kpMn?=
 =?us-ascii?Q?3RoaIv+RB2oPE+M6MWhqMq5Z6OXbacEDtNJeuYUxwpG3toG3LvyUzFsP5Nu6?=
 =?us-ascii?Q?T3f6QXWIQZXsnwxrATjfV8vauBZK9ynvCMhv8TfrJb42FGQ5/+VtMXUQcimK?=
 =?us-ascii?Q?fRfUicH6z9ODcJRSXt0cPi6MHeA5z1J2L0fKkysdkqaQ5601E6WyXYk95dR2?=
 =?us-ascii?Q?PDGNNFs7698rI5gYqcJ78EZz1x+Sz/SuYCwUXjy6Jfj6wMr6MF1jAec/qcN6?=
 =?us-ascii?Q?PUINZ2YUsM7MZBYRiCTJq+XwJhLehbhqxZ5qY6C1P8iIyLnlD7Vi1v1KLXiO?=
 =?us-ascii?Q?AJ/g64Ppbmd6AtwrHyMTx0eAHVwT78FqnFO1tpt6h+AGwXgvBJpQLZeL/deA?=
 =?us-ascii?Q?9t9Mkr5tHdIK8h7HsfVUN5PObemRCC77wdXlhdLY3ODm56TMJFs4IRQcPFjz?=
 =?us-ascii?Q?Cg++ZM0JOILXp0JPLLFnvBBRP2xvGjXk6eABZimd4vj8etBzJmepbRHOg6EQ?=
 =?us-ascii?Q?sHtEHMYlwieNYtjt3cL/gsAxOi1iiUed+Nosn3A+xFyR4pv2iav8aomuNKe2?=
 =?us-ascii?Q?GO8eQkGqUpUdyN75FevXNeqoaQladAiV8TmY+wqbWLmw0cLtgmav8JL7X/Jb?=
 =?us-ascii?Q?upnEu4/BJSbd9Cg44mYEQf/Z2C1SQ27KU9Z+Cfow4S0DUYkq997RnaKURQmo?=
 =?us-ascii?Q?G94lHD8BsQyamSYMWqIteefcTcrA+bzO6eMVJIwkyWbjyIfnYF1EdyuiDbI3?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f56d171-a98d-406f-d03f-08db95045cc6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 16:03:37.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44c8OUhhkvd+plAoPXOjrYpFiiiR8AZZnhethfa/LA052ABCs8RrVIG6MkE62jUDGg0xlXXwYYDc8LDwkgfMXG/hiFUkPWy60tX2EkhyEsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5947
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Vladimir,

On Thu, Aug 03, 2023 at 04:42:53PM +0300, Vladimir Oltean wrote:
> When the tagging protocol in current use is "ocelot-8021q" and we unbind
> the driver, we see this splat:
> 
> $ echo '0000:00:00.2' > /sys/bus/pci/drivers/fsl_enetc/unbind
> mscc_felix 0000:00:00.5 swp0: left promiscuous mode
> sja1105 spi2.0: Link is Down
> DSA: tree 1 torn down
> mscc_felix 0000:00:00.5 swp2: left promiscuous mode
> sja1105 spi2.2: Link is Down
> DSA: tree 3 torn down
> fsl_enetc 0000:00:00.2 eno2: left promiscuous mode
> mscc_felix 0000:00:00.5: Link is Down
> ------------[ cut here ]------------
> RTNL: assertion failed at net/dsa/tag_8021q.c (409)
> WARNING: CPU: 1 PID: 329 at net/dsa/tag_8021q.c:409 dsa_tag_8021q_unregister+0x12c/0x1a0
> Modules linked in:
> CPU: 1 PID: 329 Comm: bash Not tainted 6.5.0-rc3+ #771
> pc : dsa_tag_8021q_unregister+0x12c/0x1a0
> lr : dsa_tag_8021q_unregister+0x12c/0x1a0
> Call trace:
>  dsa_tag_8021q_unregister+0x12c/0x1a0
>  felix_tag_8021q_teardown+0x130/0x150
>  felix_teardown+0x3c/0xd8
>  dsa_tree_teardown_switches+0xbc/0xe0
>  dsa_unregister_switch+0x168/0x260
>  felix_pci_remove+0x30/0x60
>  pci_device_remove+0x4c/0x100
>  device_release_driver_internal+0x188/0x288
>  device_links_unbind_consumers+0xfc/0x138
>  device_release_driver_internal+0xe0/0x288
>  device_driver_detach+0x24/0x38
>  unbind_store+0xd8/0x108
>  drv_attr_store+0x30/0x50
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> RTNL: assertion failed at net/8021q/vlan_core.c (376)
> WARNING: CPU: 1 PID: 329 at net/8021q/vlan_core.c:376 vlan_vid_del+0x1b8/0x1f0
> CPU: 1 PID: 329 Comm: bash Tainted: G        W          6.5.0-rc3+ #771
> pc : vlan_vid_del+0x1b8/0x1f0
> lr : vlan_vid_del+0x1b8/0x1f0
>  dsa_tag_8021q_unregister+0x8c/0x1a0
>  felix_tag_8021q_teardown+0x130/0x150
>  felix_teardown+0x3c/0xd8
>  dsa_tree_teardown_switches+0xbc/0xe0
>  dsa_unregister_switch+0x168/0x260
>  felix_pci_remove+0x30/0x60
>  pci_device_remove+0x4c/0x100
>  device_release_driver_internal+0x188/0x288
>  device_links_unbind_consumers+0xfc/0x138
>  device_release_driver_internal+0xe0/0x288
>  device_driver_detach+0x24/0x38
>  unbind_store+0xd8/0x108
>  drv_attr_store+0x30/0x50
> DSA: tree 0 torn down
> 
> This was somewhat not so easy to spot, because "ocelot-8021q" is not the
> default tagging protocol, and thus, not everyone who tests the unbinding
> path may have switched to it beforehand. The default
> felix_tag_npi_teardown() does not require rtnl_lock() to be held.

I ran this unbind test (with just ocelot tagging) on my currently
running system (6.5.1-rc1 + 8). This doesn't include your patch, but I
suspect this is entirely different because I'm not using ocelot-8021q.

# echo spi0.0 > /sys/bus/spi/drivers/ocelot-soc/unbind
br0: port 1(swp1) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp1 (unregistering): left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp1 (unregistering): left promiscuous mode
br0: port 1(swp1) entered disabled state
br0: port 2(swp2) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp2 (unregistering): left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp2 (unregistering): left promiscuous mode
br0: port 2(swp2) entered disabled state
br0: port 3(swp3) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp3 (unregistering): left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp3 (unregistering): left promiscuous mode
br0: port 3(swp3) entered disabled state
br0: port 4(swp4) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp4 (unregistering): left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp4 (unregistering): left promiscuous mode
br0: port 4(swp4) entered disabled state
br0: port 5(swp5) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp5 (unregistering): left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp5 (unregistering): left promiscuous mode
br0: port 5(swp5) entered disabled state
br0: port 6(swp6) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp6 (unregistering): left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp6 (unregistering): left promiscuous mode
br0: port 6(swp6) entered disabled state
br0: port 7(swp7) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp7 (unregistering): left allmulticast mode
cpsw-switch 4a100000.switch eth0: left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp7 (unregistering): left promiscuous mode
cpsw-switch 4a100000.switch eth0: left promiscuous mode
br0: port 7(swp7) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto: Link is Down
DSA: tree 0 torn down
------------[ cut here ]------------
WARNING: CPU: 0 PID: 157 at net/dsa/dsa.c:1490 dsa_switch_release_ports+0x104/0x12c
Modules linked in:
CPU: 0 PID: 157 Comm: bash Not tainted 6.5.0-rc1-00008-ga5ed09af118a #1324
Hardware name: Generic AM33XX (Flattened Device Tree)
Backtrace:
 dump_backtrace from show_stack+0x20/0x24
 r7:00000009 r6:00000000 r5:c18c0a8c r4:000e0113
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 r7:00000009 r6:c1186e10 r5:000005d2 r4:c1a06270
 dump_stack from __warn+0x88/0x160
 __warn from warn_slowpath_fmt+0xe4/0x1e0
 r8:00000009 r7:000005d2 r6:c1a06270 r5:c1d05590 r4:c1c978a4
 warn_slowpath_fmt from dsa_switch_release_ports+0x104/0x12c
 r10:c1ea8b7c r9:c4290da8 r8:00000100 r7:c1a06270 r6:c4288380 r5:c427f800
 r4:c427f600
 dsa_switch_release_ports from dsa_unregister_switch+0x38/0x18c
 r9:c4290da8 r8:00000044 r7:c4255c54 r6:c4290db0 r5:c4290d80 r4:c4288380
 dsa_unregister_switch from ocelot_ext_remove+0x28/0x40
 r9:c1f6ec1c r8:00000044 r7:c4255c54 r6:c1ec5454 r5:00000000 r4:c26db800
 ocelot_ext_remove from platform_remove+0x50/0x6c
 r5:00000000 r4:c4255c10
 platform_remove from device_remove+0x50/0x74
 r5:00000000 r4:c4255c10
 device_remove from device_release_driver_internal+0x190/0x204
 r5:00000000 r4:c4255c10
 device_release_driver_internal from device_release_driver+0x20/0x24
 r9:c1f6ec1c r8:c2146940 r7:c2146938 r6:c214690c r5:c4255c10 r4:c2146930
 device_release_driver from bus_remove_device+0xd0/0xf4
 bus_remove_device from device_del+0x164/0x454
 r9:c1f6ec1c r8:c424d800 r7:c47b4700 r6:00000000 r5:c4255c10 r4:c4255c54
 device_del from platform_device_del.part.0+0x20/0x84
 r10:c1ea8b7c r9:c4292e80 r8:00000100 r7:00000122 r6:c4255c00 r5:c4255c00
 r4:c4255c00
 platform_device_del.part.0 from platform_device_unregister+0x28/0x34
 r5:c4255c10 r4:c4255c00
 platform_device_unregister from mfd_remove_devices_fn+0xe8/0xf4
 r5:c4255c10 r4:c1ea8b7c
 mfd_remove_devices_fn from device_for_each_child_reverse+0x80/0xc8
 r10:c47b4700 r9:c1d04d5c r8:c1f099a8 r7:c424d800 r6:c0a98f74 r5:e0c55d78
 r4:00000000 r3:00000001
 device_for_each_child_reverse from devm_mfd_dev_release+0x40/0x68
 r6:e0c55dd4 r5:c4270e00 r4:c4270f00
 devm_mfd_dev_release from release_nodes+0x78/0x104
 release_nodes from devres_release_all+0x90/0xe0
 r10:c4b05b10 r9:00000000 r8:c424d444 r7:c424d9b0 r6:80030013 r5:00000039
 r4:c424d800
 devres_release_all from device_unbind_cleanup+0x1c/0x70
 r7:c424d844 r6:c1ea8b94 r5:c424d400 r4:c424d800
 device_unbind_cleanup from device_release_driver_internal+0x1c0/0x204
 r5:c424d400 r4:c424d800
 device_release_driver_internal from device_driver_detach+0x20/0x24
 r9:00000000 r8:00000000 r7:c1ea8b94 r6:00000007 r5:c424d800 r4:c1eb9108
 device_driver_detach from unbind_store+0x64/0xa0
 unbind_store from drv_attr_store+0x34/0x40
 r7:e0c55f08 r6:c4b05b00 r5:c471d040 r4:c0a53410
 drv_attr_store from sysfs_kf_write+0x48/0x54
 r5:c471d040 r4:c0a5266c
 sysfs_kf_write from kernfs_fop_write_iter+0x11c/0x1dc
 r5:c471d040 r4:00000007
 kernfs_fop_write_iter from vfs_write+0x2d0/0x41c
 r10:00000000 r9:00004004 r8:00000000 r7:00000007 r6:005c9ef8 r5:e0c55f68
 r4:c4958cc0
 vfs_write from ksys_write+0x70/0xf4
 r10:00000004 r9:c47b4700 r8:c03002f4 r7:00000000 r6:00000000 r5:c4958cc0
 r4:c4958cc0
 ksys_write from sys_write+0x18/0x1c
 r7:00000004 r6:b6fad550 r5:005c9ef8 r4:00000007
 sys_write from ret_fast_syscall+0x0/0x1c
Exception stack(0xe0c55fa8 to 0xe0c55ff0)
5fa0:                   00000007 005c9ef8 00000001 005c9ef8 00000007 00000000
5fc0: 00000007 005c9ef8 b6fad550 00000004 00000007 00000001 00000000 be8e4a6c
5fe0: 00000004 be8e49c8 b6e56767 b6de1e06
---[ end trace 0000000000000000 ]---
gpio_stub_drv gpiochip6: REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED
BUG: scheduling while atomic: bash/157/0x00000002
Modules linked in:
Preemption disabled at:
[<c03b8f98>] __wake_up_klogd.part.0+0x20/0xb4
CPU: 0 PID: 157 Comm: bash Tainted: G        W          6.5.0-rc1-00008-ga5ed09af118a #1324
Hardware name: Generic AM33XX (Flattened Device Tree)
Backtrace:
 dump_backtrace from show_stack+0x20/0x24
 r7:c47b4700 r6:00000000 r5:c18c0a8c r4:000e0113
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 r7:c47b4700 r6:c47b4700 r5:c03b8f98 r4:c47b4700
 dump_stack from __schedule_bug+0x94/0xa4
 __schedule_bug from __schedule+0x8fc/0xc48
 r5:00000000 r4:df99a400
 __schedule from schedule+0x60/0xf4
 r10:e0c55ab4 r9:00000002 r8:e0c55a3c r7:c47b4700 r6:e0c55ab0 r5:e0c55aac
 r4:c47b4700
 schedule from schedule_timeout+0xd8/0x190
 r5:e0c55aac r4:7fffffff
 schedule_timeout from wait_for_completion+0xa0/0x124
 r8:e0c55a3c r7:c47b4700 r6:e0c55ab0 r5:e0c55aac r4:7fffffff
 wait_for_completion from devtmpfs_submit_req+0x70/0x80
 r10:c47b4700 r9:c1f6ec1c r8:c424e810 r7:00000000 r6:e0c55aac r5:e0c55aa8
 r4:c1f6ed78
 devtmpfs_submit_req from devtmpfs_delete_node+0x84/0xb4
 r7:c47b4700 r6:c4250264 r5:c4250000 r4:00000000
 devtmpfs_delete_node from device_del+0x3b8/0x454
 r5:c4250000 r4:c4250044
 device_del from cdev_device_del+0x24/0x54
 r10:c47b4700 r9:c1d04d5c r8:00000040 r7:c4250234 r6:c4250264 r5:c42501e0
 r4:c4250000
 cdev_device_del from gpiolib_cdev_unregister+0x20/0x24
 r5:c4250000 r4:00000000
 gpiolib_cdev_unregister from gpiochip_remove+0x100/0x130
 gpiochip_remove from devm_gpio_chip_release+0x18/0x1c
 r9:c1d04d5c r8:c1f099a8 r7:c424e810 r6:e0c55bf4 r5:c427e700 r4:c427ea80
 devm_gpio_chip_release from devm_action_release+0x1c/0x20
 devm_action_release from release_nodes+0x78/0x104
 release_nodes from devres_release_all+0x90/0xe0
 r10:c1ea8b7c r9:c1f6ec1c r8:00000044 r7:c424e9c0 r6:800e0113 r5:00000093
 r4:c424e810
 devres_release_all from device_unbind_cleanup+0x1c/0x70
 r7:c424e854 r6:c1dd9a80 r5:00000000 r4:c424e810
 device_unbind_cleanup from device_release_driver_internal+0x1c0/0x204
 r5:00000000 r4:c424e810
 device_release_driver_internal from device_release_driver+0x20/0x24
 r9:c1f6ec1c r8:c2146940 r7:c2146938 r6:c214690c r5:c424e810 r4:c2146930
 device_release_driver from bus_remove_device+0xd0/0xf4
 bus_remove_device from device_del+0x164/0x454
 r9:c1f6ec1c r8:c424d800 r7:c47b4700 r6:00000000 r5:c424e810 r4:c424e854
 device_del from platform_device_del.part.0+0x20/0x84
 r10:c1ea8b7c r9:c4274f00 r8:00000100 r7:00000122 r6:c424e800 r5:c424e800
 r4:c424e800
 platform_device_del.part.0 from platform_device_unregister+0x28/0x34
 r5:c424e810 r4:c424e800
 platform_device_unregister from mfd_remove_devices_fn+0xe8/0xf4
 r5:c424e810 r4:c1ea8b7c
 mfd_remove_devices_fn from device_for_each_child_reverse+0x80/0xc8
 r10:c47b4700 r9:c1d04d5c r8:c1f099a8 r7:c424d800 r6:c0a98f74 r5:e0c55d78
 r4:00000000 r3:00000001
 device_for_each_child_reverse from devm_mfd_dev_release+0x40/0x68
 r6:e0c55dd4 r5:c4270e00 r4:c4270f00
 devm_mfd_dev_release from release_nodes+0x78/0x104
 release_nodes from devres_release_all+0x90/0xe0
 r10:c4b05b10 r9:00000000 r8:c424d444 r7:c424d9b0 r6:80030013 r5:00000039
 r4:c424d800
 devres_release_all from device_unbind_cleanup+0x1c/0x70
 r7:c424d844 r6:c1ea8b94 r5:c424d400 r4:c424d800
 device_unbind_cleanup from device_release_driver_internal+0x1c0/0x204
 r5:c424d400 r4:c424d800
 device_release_driver_internal from device_driver_detach+0x20/0x24
 r9:00000000 r8:00000000 r7:c1ea8b94 r6:00000007 r5:c424d800 r4:c1eb9108
 device_driver_detach from unbind_store+0x64/0xa0
 unbind_store from drv_attr_store+0x34/0x40
 r7:e0c55f08 r6:c4b05b00 r5:c471d040 r4:c0a53410
 drv_attr_store from sysfs_kf_write+0x48/0x54
 r5:c471d040 r4:c0a5266c
 sysfs_kf_write from kernfs_fop_write_iter+0x11c/0x1dc
 r5:c471d040 r4:00000007
 kernfs_fop_write_iter from vfs_write+0x2d0/0x41c
 r10:00000000 r9:00004004 r8:00000000 r7:00000007 r6:005c9ef8 r5:e0c55f68
 r4:c4958cc0
 vfs_write from ksys_write+0x70/0xf4
 r10:00000004 r9:c47b4700 r8:c03002f4 r7:00000000 r6:00000000 r5:c4958cc0
 r4:c4958cc0
 ksys_write from sys_write+0x18/0x1c
 r7:00000004 r6:b6fad550 r5:005c9ef8 r4:00000007
 sys_write from ret_fast_syscall+0x0/0x1c
Exception stack(0xe0c55fa8 to 0xe0c55ff0)
5fa0:                   00000007 005c9ef8 00000001 005c9ef8 00000007 00000000
5fc0: 00000007 005c9ef8 b6fad550 00000004 00000007 00000001 00000000 be8e4a6c
5fe0: 00000004 be8e49c8 b6e56767 b6de1e06
cpsw-switch 4a100000.switch eth0: Link is Down


It looks to me like I have some things to fix :)


Is it worth me still trying to recreate / test? I haven't used
ocelot-8021q really at all.


Colin

