Return-Path: <netdev+bounces-24513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDA17706CB
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 19:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00211C218E1
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4432D1AA75;
	Fri,  4 Aug 2023 17:10:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313161AA6B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 17:10:45 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2062.outbound.protection.outlook.com [40.107.241.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B09249F0
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gABEkSX4FmHiAWJBDx0aNh6SZaMOkT4MtYSaSqw2DsIoyN+PIFvmDEocpPyO8jhKDlPLR4t7eJZ6Kkq7oQ6rYzgJR5DbQEQJDf+m+v+JAq7/jBLjYZVJ1e0UbfeOQuSotZgo2S+n4GliHeJZYybT+x7uGhaBQ+L0t/bUx00tWtMnISNB23YkuwWW8Js0qavk1s01o6yuJzbFpW1B3kHALDF5xt2XEqA6MY+VSOQeMSQTiKusbP4tp3dUz8cXHlJILLaAy2ZVn+rCeTzQN8h0MoPyTa5J3AV3o/p/nuSF0TPCO4ruOLibID/o7kkfp97hQIyirVo+8G0rZOkZuTmHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TwwGRlJH5EO5vyndjqYD2t3sw1yhAunWfM20bp7Twg=;
 b=kNy1DoBo4d42SNlQ5psUf9ZaWT/Ii4SXoq3vBUmbKWd95NennYdFFKoQCCc5D1PTqtiSU1xQoOgwNbUsYozFRfx10cQxZlgOyBO3fAcJ4IZe1FeYpMLLiddUStqBfyJw/QFEEyVWIxgdvdSW9tFeExtaIYotHpIHJpfB7J8l87jTBTYD11vArlNMiTzaWXKzZ1qJKOHjY8PBv/kMFx9mqxmd4uQOMvn4f1eEmdGTTyjyEe0TFvQZPGUvhDseOOTv+Qmfi/ewLweO+PCouU0agbVtjKf10Nn8dM5jDTd+ybofx6P6nHryHs0MSyNqeQladBGDpHprNzgHlEZKSkpRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TwwGRlJH5EO5vyndjqYD2t3sw1yhAunWfM20bp7Twg=;
 b=J6WnIoVmdIwcTLufcESJvx8opjxIFP+DmWWDWQNMFRUtHU7Q7m2zNYPQ3m7YVmYi5gw7ECWs1mGUxet6PSWFCozGW6sElvZElb8wG793bFhJnicvKQ5Uf4rDUOrs4PuWJrzgt4y3BmmW5LpUDz+3dgxbezBR8Dd+ZS9ziNkbQz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB6769.eurprd04.prod.outlook.com (2603:10a6:208:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 17:10:02 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 17:10:02 +0000
Date: Fri, 4 Aug 2023 20:09:58 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Colin Foster <colin.foster@in-advantage.com>
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
Message-ID: <20230804170958.nru6iafu5jrfxhqh@skbuf>
References: <20230803134253.2711124-1-vladimir.oltean@nxp.com>
 <ZM0hVTA7nHuRCSXa@euler>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM0hVTA7nHuRCSXa@euler>
X-ClientProxiedBy: AM4PR05CA0003.eurprd05.prod.outlook.com (2603:10a6:205::16)
 To AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 41afc0c0-69fe-49c9-bbc2-08db950da3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vK1QUM5u/lKfWWN+oGJMqTKXVrVW859pMbg/Z5nZtLM2c7jaNi82PyqgqBLEejI5pl0cmGnquzucr5Ax5wDfZBfaUglks3KOD/v3knmZmRx9ZqZGwCVrq+R2MixioqtAke67pjAZkal9Hkq9zIRaF+Wh+6rWNcbnHQXdGtZXRSPeaGUtWkUyzbo57v8WRvm1CKQBgB/z+GhppdBlXya1ccTp5xcVeUt6t9OXjZCpTPeQg80nu2pf4Z4DChGK3Q8k4ELwy9AOb/s7J3Ca9hqDIlJoiT767z+K53Odhb+5lXvTarPEfCX/55UGUbAR7J49g2fnJyF6oJWe0Ka7NSGiGtXuZ0Id0YK0N0H3ntteFh22svwy9vN2vmsLFDj3lx4O0+ZFffaC3Hpmj613gAjA0DmzjgdMAHPTvPDiIJeyvMLJM97MOBt7sIvLrPTOWxquisVtsDJguu93b+XqmGdi48zIechLXXeAbPYgjeUAyn4WnmkaT4XYXOlwJQHQohOOKzwVJNm4P+giDaSZdAQnRoY9d4iVhKsSmLzfdORk2z0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(1800799003)(186006)(83380400001)(316002)(66476007)(33716001)(66946007)(4326008)(66556008)(38100700002)(6506007)(44832011)(26005)(8936002)(8676002)(1076003)(7416002)(41300700001)(5660300002)(6666004)(6916009)(6486002)(45080400002)(6512007)(9686003)(966005)(86362001)(478600001)(54906003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g1hnuGIJMT8aDTOXKylNm97yK5yH5sAADMv6QLY1yQiXQFttLnvusIftMlUQ?=
 =?us-ascii?Q?TCrc4dfaDdRlVxTrA0bT6VZPvVRB+ArLzux4Uhr4L+I2LhI0/WjcnkTPEcOP?=
 =?us-ascii?Q?34/iXtE47vG/fBRjPy9NXscq+G1A2bjlpk5kDxjvLX/YkuUFpW5YyaixRN+W?=
 =?us-ascii?Q?40w11zjFtrK6nyOhh7JPJ1VN8iSrAtAzU8xo3aQo1YAi2Ax5Br5gdumhZyhg?=
 =?us-ascii?Q?W2zQRKQM7lUil9HUO5K3qsyW5JD0jkbdZ6oqbnVZ0+nEmnd4XYL2gpZMOX8e?=
 =?us-ascii?Q?bGbFAfOxG2uuDB+ZSM6e09ALTDxNxoEOoo7dT0OW7ND2m/VMOO+4wdzxiGus?=
 =?us-ascii?Q?iQwS7iJFgEWWHVgKGutSEG7g/jvoGgSNJzN5aHPlYWwOtfNylA6uY/P6fROe?=
 =?us-ascii?Q?0Yrxl+L7nbvrwLsmpbv1Wa5qI+Y4UOs3AWg9LWSxGcGBgB95ABxQeeSkKaZb?=
 =?us-ascii?Q?ZOpJUqjMVmL4QPlhqN/ZhYS82883thLgRVNwwDQgibpS7TgZWctImR4BfCj6?=
 =?us-ascii?Q?3GZeTcIzaUKhCcmWzBF0QBe9BVxI5vC55+KxkEmwtopCfpEL9xBd2ROlJeAf?=
 =?us-ascii?Q?flrRT3NG+XDFM5tddVP6H4NByzLn/OJZ694L3y/IUnEhaeMJOe8LafzhlwkN?=
 =?us-ascii?Q?acEHS/u9yhoVdaGQz14pqtjbhCityRB9tjNdW78v0VqsoLM6M1vKxwtYC7f7?=
 =?us-ascii?Q?iIVvgorvIlngyLP54/JA6fhzDMjIhKN42ge7GM8AL1ABX0x2I66hGYoTOtzL?=
 =?us-ascii?Q?7i5CIc1MJL/yjhSS8EbEb1Sod8ys/cYTwo+z7BvkgZfwqOCfDjYvDULwZJF7?=
 =?us-ascii?Q?yQKhw95BTVCxtT42euudE9k5mULnDWEJslse5ceGn9N3gA6TLgtKjdufsLN/?=
 =?us-ascii?Q?Ee/f/gvEQTxH9E8Nzia/m2ZGWvDS9H3aBUTgSN89FojYvtjFGEAvMmGKmoId?=
 =?us-ascii?Q?LS7SnXbngIyDUbUEqFiEgj0n6z6Vsd63ZWK9bx0PJpatED1mBN8F1MQxy8N1?=
 =?us-ascii?Q?zcLfY0mYNvRRYMY2Gz39H6yB83Oild7Sj3LgjXuzjCc1p/q+Kzc/k5xS6pTI?=
 =?us-ascii?Q?b0U93W1OlVub0pINTQOXErJLRAfb5aQGg7rZJgZgpyJ/tqvmTDVz77G5xg7V?=
 =?us-ascii?Q?rPq3SEa3tnnHKbtDmOSmIIDZvPYNd+YnrIl7NYNUGXxdTZyyPiKo5PIFnrBx?=
 =?us-ascii?Q?1mOKa10QWCQtpicf7bPYb8j7sqYgnpyfCIsgB89iO9T3bXC1Dbn7FvefRRi/?=
 =?us-ascii?Q?4L1LFxS+hHQ8tUrzpUW7U93gOUtriZmCoAka4UBs5dVV9mK87FYcsE771u34?=
 =?us-ascii?Q?gvBs/6lPmNk1ZSUI6db9kqXMd+koT9jHfmUYQzR4FJA/fDmg9Ij6nkzQn0rn?=
 =?us-ascii?Q?ndJdzL01Py7rId6QqArNj18/f/ARTcLFc0V8XtfcwKNyIJX+8yGIQzmCl3gX?=
 =?us-ascii?Q?gy10sfj+mvhIvlmM5XC+YciS1WCFfRe7xu79qwzxSTW1MTBcZ4PazWjNX0HW?=
 =?us-ascii?Q?XwXnUqDfS4IeHmVCASZPSDk6Jqs9kdNy66VSSWlMUS9e2Hvpao445RUWwrvN?=
 =?us-ascii?Q?COX8J/pi+0SWeV1gEtxy3yYNkwlsrVlUFpZuhGaoShKJKRkAjJXSnYBHWc9r?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41afc0c0-69fe-49c9-bbc2-08db950da3bc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 17:10:01.8971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pUjd19CzlYug8wFyMDqinvR0+90CyoGePcnlfH8VPMUE18onvsAVTJy9gTi8D1r5NOj6J6k5eeuClflPPpl1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6769
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Colin,

On Fri, Aug 04, 2023 at 09:03:33AM -0700, Colin Foster wrote:
> On Thu, Aug 03, 2023 at 04:42:53PM +0300, Vladimir Oltean wrote:
> I ran this unbind test (with just ocelot tagging) on my currently
> running system (6.5.1-rc1 + 8). This doesn't include your patch, but I
> suspect this is entirely different because I'm not using ocelot-8021q.
> 
> # echo spi0.0 > /sys/bus/spi/drivers/ocelot-soc/unbind
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 157 at net/dsa/dsa.c:1490 dsa_switch_release_ports+0x104/0x12c
> Modules linked in:
> CPU: 0 PID: 157 Comm: bash Not tainted 6.5.0-rc1-00008-ga5ed09af118a #1324
> Hardware name: Generic AM33XX (Flattened Device Tree)
> Backtrace:
>  __warn from warn_slowpath_fmt+0xe4/0x1e0
>  warn_slowpath_fmt from dsa_switch_release_ports+0x104/0x12c
>  dsa_switch_release_ports from dsa_unregister_switch+0x38/0x18c
>  dsa_unregister_switch from ocelot_ext_remove+0x28/0x40
>  ocelot_ext_remove from platform_remove+0x50/0x6c
>  platform_remove from device_remove+0x50/0x74
>  device_remove from device_release_driver_internal+0x190/0x204
>  device_release_driver_internal from device_release_driver+0x20/0x24
>  device_release_driver from bus_remove_device+0xd0/0xf4
>  bus_remove_device from device_del+0x164/0x454
>  device_del from platform_device_del.part.0+0x20/0x84
>  platform_device_del.part.0 from platform_device_unregister+0x28/0x34
>  platform_device_unregister from mfd_remove_devices_fn+0xe8/0xf4
>  mfd_remove_devices_fn from device_for_each_child_reverse+0x80/0xc8
>  device_for_each_child_reverse from devm_mfd_dev_release+0x40/0x68
>  devm_mfd_dev_release from release_nodes+0x78/0x104
>  release_nodes from devres_release_all+0x90/0xe0
>  devres_release_all from device_unbind_cleanup+0x1c/0x70
>  device_unbind_cleanup from device_release_driver_internal+0x1c0/0x204
>  device_release_driver_internal from device_driver_detach+0x20/0x24
>  device_driver_detach from unbind_store+0x64/0xa0
>  unbind_store from drv_attr_store+0x34/0x40
>  drv_attr_store from sysfs_kf_write+0x48/0x54
>  sysfs_kf_write from kernfs_fop_write_iter+0x11c/0x1dc
>  kernfs_fop_write_iter from vfs_write+0x2d0/0x41c
>  vfs_write from ksys_write+0x70/0xf4
>  ksys_write from sys_write+0x18/0x1c
>  sys_write from ret_fast_syscall+0x0/0x1c
> Exception stack(0xe0c55fa8 to 0xe0c55ff0)
> 5fa0:                   00000007 005c9ef8 00000001 005c9ef8 00000007 00000000
> 5fc0: 00000007 005c9ef8 b6fad550 00000004 00000007 00000001 00000000 be8e4a6c
> 5fe0: 00000004 be8e49c8 b6e56767 b6de1e06
> ---[ end trace 0000000000000000 ]---
> gpio_stub_drv gpiochip6: REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED
> BUG: scheduling while atomic: bash/157/0x00000002
> Modules linked in:
> Preemption disabled at:
> [<c03b8f98>] __wake_up_klogd.part.0+0x20/0xb4
> CPU: 0 PID: 157 Comm: bash Tainted: G        W          6.5.0-rc1-00008-ga5ed09af118a #1324
> Hardware name: Generic AM33XX (Flattened Device Tree)
> Backtrace:
>  __schedule_bug from __schedule+0x8fc/0xc48
>  __schedule from schedule+0x60/0xf4
>  schedule from schedule_timeout+0xd8/0x190
>  schedule_timeout from wait_for_completion+0xa0/0x124
>  wait_for_completion from devtmpfs_submit_req+0x70/0x80
>  devtmpfs_submit_req from devtmpfs_delete_node+0x84/0xb4
>  devtmpfs_delete_node from device_del+0x3b8/0x454
>  device_del from cdev_device_del+0x24/0x54
>  cdev_device_del from gpiolib_cdev_unregister+0x20/0x24
>  gpiolib_cdev_unregister from gpiochip_remove+0x100/0x130
>  gpiochip_remove from devm_gpio_chip_release+0x18/0x1c
>  devm_gpio_chip_release from devm_action_release+0x1c/0x20
>  devm_action_release from release_nodes+0x78/0x104
>  release_nodes from devres_release_all+0x90/0xe0
>  devres_release_all from device_unbind_cleanup+0x1c/0x70
>  device_unbind_cleanup from device_release_driver_internal+0x1c0/0x204
>  device_release_driver_internal from device_release_driver+0x20/0x24
>  device_release_driver from bus_remove_device+0xd0/0xf4
>  bus_remove_device from device_del+0x164/0x454
>  device_del from platform_device_del.part.0+0x20/0x84
>  platform_device_del.part.0 from platform_device_unregister+0x28/0x34
>  platform_device_unregister from mfd_remove_devices_fn+0xe8/0xf4
>  mfd_remove_devices_fn from device_for_each_child_reverse+0x80/0xc8
>  device_for_each_child_reverse from devm_mfd_dev_release+0x40/0x68
>  devm_mfd_dev_release from release_nodes+0x78/0x104
>  release_nodes from devres_release_all+0x90/0xe0
>  devres_release_all from device_unbind_cleanup+0x1c/0x70
>  device_unbind_cleanup from device_release_driver_internal+0x1c0/0x204
>  device_release_driver_internal from device_driver_detach+0x20/0x24
>  device_driver_detach from unbind_store+0x64/0xa0
>  unbind_store from drv_attr_store+0x34/0x40
>  drv_attr_store from sysfs_kf_write+0x48/0x54
>  sysfs_kf_write from kernfs_fop_write_iter+0x11c/0x1dc
>  kernfs_fop_write_iter from vfs_write+0x2d0/0x41c
>  vfs_write from ksys_write+0x70/0xf4
>  ksys_write from sys_write+0x18/0x1c
>  sys_write from ret_fast_syscall+0x0/0x1c
> Exception stack(0xe0c55fa8 to 0xe0c55ff0)
> 5fa0:                   00000007 005c9ef8 00000001 005c9ef8 00000007 00000000
> 5fc0: 00000007 005c9ef8 b6fad550 00000004 00000007 00000001 00000000 be8e4a6c
> 5fe0: 00000004 be8e49c8 b6e56767 b6de1e06
> cpsw-switch 4a100000.switch eth0: Link is Down
> 
> 
> It looks to me like I have some things to fix :)
> 
> 
> Is it worth me still trying to recreate / test? I haven't used
> ocelot-8021q really at all.

The WARN_ON() in dsa_switch_release_ports() is different, and I tried to fix it here:
https://patchwork.kernel.org/project/netdevbpf/patch/20230411144955.1604591-1-vladimir.oltean@nxp.com/
but judging by the fact that that was in April and now we're in August,
obviously I didn't succeed.

What's worse is the other one, the "scheduling while atomic" bug in the
gpiochip removal path from ocelot-pinctrl.c. I'm not sure, at first glance,
what causes the calling context to be atomic. Presumably some kind of
spinlock which should be tracked down.

Unfortunately I'm not very good with kernel debugging the way it should
be done, so what I would advise you to do is to walk the stack trace
down, from device_del() or so, and sprinkle a few might_sleep() calls
until you figure out who's forcing atomic context and why.

Otherwise, can't you just unbind the driver from the ethernet-switch
child of the SPI device, rather than the entire SPI device? That should
avoid the gpiochip/pinctrl bug. And the other one is ignorable for the
intents and purposes here (that is, unless you want to take care of it,
of course).

