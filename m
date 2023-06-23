Return-Path: <netdev+bounces-13296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ABD73B220
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C0E1C20C1B
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD9717FD;
	Fri, 23 Jun 2023 07:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFFD17D3
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:52:31 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2090.outbound.protection.outlook.com [40.107.96.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BDBAC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 00:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mp+5Dg+h66mj9SApfjE9v9KLkmtcBDZGTqQfexnQKXLojX/3cZU10IP6a8+n/chJ78dPOevu7z2Bj+BQCYy6CzrQGUK5ghUM8ultfu/CHSmSUgZ4Dq0atONiMDOzE9S7Ega1/DM/WmSDFsZP479/+7TfFRN/RPrvLebjPxVnwb4PaoWwqUfpsyuvmgJux+XxQ7xovxTJMjgak9UGM05bFW1Qq0KhsxtDE0NgBEM/evRebEoG92xF56NIFwM67ezCIjkZPx6mB67sVm6qgT3tfGYuNqVqPlZM/JviEUL6NLa2G1TZGWyopiOhZYhE60gpDJcpo2DOFMKCfXFL8wCQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbh/7ARggbalW2zYQV/0fOyrNbEwHnLGk3YDUSzJP7U=;
 b=Al517e3InM+eTiRRGCl+ZPYZzZpXsTKHnrI3CZ/fqvRo0JkaI99IHxyRMVFes0QrpwqgzU/kkCaJN8V7eK4gii8ezefZuIfHzXROivvlbmEdWtVPzPU+RWdnjbutSKd2EhZLfFEL3fuF4JatjMJs20qxWUA+oe5Aw3fXEGLxIk3w2Urh/ZOzcN5tZDuIfwJIz3H11yGHTN0dtcIloqF/ecB0wscfXzJPZjd4v+/wbov4HuN1rNNqubRhi+s/4aHq+iWCd0pSVovL0yXkgfizNj3okYwLZDPajpGngC9vQqvoAbFy47Cr3T1jKTzR9VWtj51Bt5KOzhLDvn+1Hjotgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbh/7ARggbalW2zYQV/0fOyrNbEwHnLGk3YDUSzJP7U=;
 b=ZyyStviTrA7P6FB3qhYgHwx3+h21xJIWQciwkyBrJYxPIdnX4Xvns033JZCLjbtwlAcVbOiWDSfcHYY+JrccDiaQmNu+XYbbWQAjiPhQzhYRpggrPVZMZ7LGxNfErGIuY2H2qMhN7RA0mR3YzslW5/k599fazjLpGa97A1Onets=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5788.namprd13.prod.outlook.com (2603:10b6:a03:3eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Fri, 23 Jun
 2023 07:52:26 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 07:52:26 +0000
Date: Fri, 23 Jun 2023 09:52:19 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com
Subject: Re: [PATCH net] ibmvnic: Do not reset dql stats on NON_FATAL err
Message-ID: <ZJVPMyO/gBkk1OT0@corigine.com>
References: <20230622190332.29223-1-nnac123@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622190332.29223-1-nnac123@linux.ibm.com>
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 46cedcf5-a752-459d-7f34-08db73bec928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ITIKFJZgX0b7SBxJP2HlFqX75wQM0Z+uQ1OevixnLeQiunV471W2EayLTOT5R1Cz0bjUBnyOkp1aigF5u2PoubGrUVZDApGJrMBPIWHh5GO7Nk6leqi1UCQexzQEHW6zfPq6eqvGzlLQb/uiJUsJSxYN1Yn+c5lA1//sonxc41z5iF+rLshPnbFY/rUQImQ+auBGXplsINW+aMunwVBo50yAleH24jT5VGd64xtSO7RgCEQp9uOXjnGM7ec95sIDycMZvNL+JrZoidhB0lCsVVowvYQ586cIwWe50gZxa/P3xmLTp6q7aaJ4A/WBvXj+6XTBlgXd+P7T1n6Dxcvci5LxQGZwUGW/DrYZlkof5foUR3rz8P90e/SiY8JPuV2j9ErF98hkw050zriCWD5eTAcby/bZ7FnlatahmNjaxTZKl+03Fg92RZXSUtYkD+r7DDfx2mzqYpYgjdT8eoTL8et60qFpyQHxSUOj/NBVTQf/j7L6mFN4P9hX5Lt1BXcrlXC9u/M2UxHAVuaaqoX/730KfI8DWLCFCqs5Sps5F/1A4wYlQTZXd4/dBmm3uSe/ai4d7HI6pYPQmtJbDMj8d5Up3haXAKLwuBXPgqazwu0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(366004)(346002)(136003)(376002)(451199021)(38100700002)(83380400001)(186003)(478600001)(6506007)(6512007)(2616005)(8936002)(6666004)(86362001)(44832011)(6916009)(6486002)(36756003)(5660300002)(316002)(66556008)(4326008)(2906002)(66476007)(41300700001)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PC38RDJn5NmpsC5jt8S5w6CG9M3Kj/NN5N89yGGlHtDv8vCVhL+doNJJyQM3?=
 =?us-ascii?Q?e5TowJdC4zQtBAcaXKSYIuD3NzECaxrcigtMoxMQLxWi0XnVFB2s1FtB8ERG?=
 =?us-ascii?Q?ZIsDHvc9d0ZTEQ41cACbRyo56HO2PrxWkP579FcyVp0I7RcAt9X3mD227XzE?=
 =?us-ascii?Q?i+D/QGlM6vEu6XCqTwz4CmxFGSUtj366sAGwxXuD10MxVVJsA4PQIacLJDYL?=
 =?us-ascii?Q?/bg6hLgHD13ntv0g2X6HBCvO0DBfA29HKrNjZOxcR15X7wQ4xlRuylvB97yg?=
 =?us-ascii?Q?bP2p8X2nreCr0wDe6XIAceIEGLi455H5n+kfuWBzGbQgnPSdj5Tp//CcwOiF?=
 =?us-ascii?Q?ttfQtuJEPMIzuJ6E5Oz4BQB6kaq6D+WlZ5J0fcFaWJhQUTm081ifF9TrkGr7?=
 =?us-ascii?Q?TlXWGk4C3iwT3y+nVx9K1ZCScy1XoTSDofym+TF4n1nMqKLAM4Gnj31limN6?=
 =?us-ascii?Q?vU0wZxHb+vh8YZhFW4v/0h5ynfWe5hx6CC+fEB7mOY02Ttr56abhcbAhU3mM?=
 =?us-ascii?Q?rBU3aVD6/g2N6f1o4EKhgxTbqSLLr9DCxU0j9KZ5OWfMVYA0cehcrLqBpvq6?=
 =?us-ascii?Q?/XD4h0cnRcyEmynxgEZik6d9ZXO4bl+5/y+hzkE6CytSQg5RtALGA/OQaBuM?=
 =?us-ascii?Q?T9zom6TIhyT1b+LHkFovExO8TgT8iA4AIIKeZt/SDWy0SrW5KTC5AlzSQayZ?=
 =?us-ascii?Q?7XsuxQoonmzj+XoEtnM2hBynbwZi3T+RQOmaRE1TRvZe6k56LYZhYm7pMyou?=
 =?us-ascii?Q?0BSlNQnOBTMJoeosAaDHWmNrWOWalK6B/ZN2iFHshrDFkdViI8Mi3sDna6Dm?=
 =?us-ascii?Q?qf+uHeGUVSEGJKX/P56fziGTFP66AhmVrU5wATwbLGMdop/Om8rMJXFZvp9v?=
 =?us-ascii?Q?wWh4pL/MdsezpnvXjcgy0gKQEuvQgzw+99xFAmT3aMy751M3tWTywB6cou2f?=
 =?us-ascii?Q?Y0LFXkPQPDFRjiP0EiD0hJV/RRjLQvk7T6odZdpNGOMEXeEFtetUo8tVetwM?=
 =?us-ascii?Q?mdCQCvMKXfqSRVaQvzlthzsA0fMuk3cRM1cCzLCZ8TZZY0N/XFNczwC3EgS4?=
 =?us-ascii?Q?/VqkhVuTHtRtJY/HnXbRqF6Ez3jVBOlWoct22CRQttzSBP+M6aR+QSJtvurw?=
 =?us-ascii?Q?EvsrZ7aOnNEzv7NRkhNTv86ro915JHL4/i+2G+a2yhkjM6rrJ6Y+4z0l7eOt?=
 =?us-ascii?Q?Xc8XEYVqVVBkrVVPaOGVCi0C22mvGrFm800VbEJD5cAvrjrN2TbmgjKcHj5P?=
 =?us-ascii?Q?9XXfn0zHpnVEGZ+EwBV6rII/WgpQBLBU1G4fNa61sBIKTDupBPWLqWpzyQ0W?=
 =?us-ascii?Q?Ep5xkoDZqvgmQQMKg3IhzBdZOytM5eLSLE9MnurEhwgHSLPT71hFCfTBrbND?=
 =?us-ascii?Q?ZZHuwMF2qarGYTboSKIwDQKNoTTSVglJJBsPk4RS/Wp9GuqpQj1a3sEuKpVY?=
 =?us-ascii?Q?QCRYfAlfxvBeqEUx7pH9zugxorhKwMmF6PXmhmpPLRzrXWnqAwNvtErW+FeG?=
 =?us-ascii?Q?DEq3bmDFU18In88NmoND4Hg2fENul5/RAbA8/OsRmwJa57MVRdRiagiI1nH7?=
 =?us-ascii?Q?HQwmBcRM7lZGE79Zc5XLzhV6CaqmeBQVnBUQmAKDohb6srEbOiWUd9no2vwr?=
 =?us-ascii?Q?QajddqC5lj4wNisRy7V4bIuINy/KXJz/r43KKDvaogAG4cdpSjVdK5Abc5LY?=
 =?us-ascii?Q?XTXYIg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cedcf5-a752-459d-7f34-08db73bec928
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:52:25.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcIvchH9hlgle88UafMf+7BUNoqsX318obS2Oa8Yt15lEuJF30DW0ww+DfVb3oISTLXHNG/bkZs/Bj7NeSBQsbNrEAzDDAOJLwveZGoju5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5788
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+ maintainers and blamed authors

On Thu, Jun 22, 2023 at 02:03:32PM -0500, Nick Child wrote:
> All ibmvnic resets, make a call to netdev_tx_reset_queue() when
> re-opening the device. netdev_tx_reset_queue() resets the num_queued
> and num_completed byte counters. These stats are used in Byte Queue
> Limit (BQL) algorithms. The difference between these two stats tracks
> the number of bytes currently sitting on the physical NIC. ibmvnic
> increases the number of queued bytes though calls to
> netdev_tx_sent_queue() in the drivers xmit function. When, VIOS reports
> that it is done transmitting bytes, the ibmvnic device increases the
> number of completed bytes through calls to netdev_tx_completed_queue().
> It is important to note that the driver batches its transmit calls and
> num_queued is increased every time that an skb is added to the next
> batch, not necessarily when the batch is sent to VIOS for transmission.
> 
> Unlike other reset types, a NON FATAL reset will not flush the sub crq
> tx buffers. Therefore, it is possible for the batched skb array to be
> partially full. So if there is call to netdev_tx_reset_queue() when
> re-opening the device, the value of num_queued (0) would not account
> for the skb's that are currently batched. Eventually, when the batch
> is sent to VIOS, the call to netdev_tx_completed_queue() would increase
> num_completed to a value greater than the num_queued. This causes a
> BUG_ON crash:
> 
> ibmvnic 30000002: Firmware reports error, cause: adapter problem.
> Starting recovery...
> ibmvnic 30000002: tx error 600
> ibmvnic 30000002: tx error 600
> ibmvnic 30000002: tx error 600
> ibmvnic 30000002: tx error 600
> ------------[ cut here ]------------
> kernel BUG at lib/dynamic_queue_limits.c:27!
> Oops: Exception in kernel mode, sig: 5
> [....]
> NIP dql_completed+0x28/0x1c0
> LR ibmvnic_complete_tx.isra.0+0x23c/0x420 [ibmvnic]
> Call Trace:
> ibmvnic_complete_tx.isra.0+0x3f8/0x420 [ibmvnic] (unreliable)
> ibmvnic_interrupt_tx+0x40/0x70 [ibmvnic]
> __handle_irq_event_percpu+0x98/0x270
> ---[ end trace ]---
> 
> Therefore, do not reset the dql stats when performing a NON_FATAL reset.
> Simply clearing the queues off bit is sufficient.
> 
> Fixes: 0d973388185d ("ibmvnic: Introduce xmit_more support using batched subCRQ hcalls")
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index c63d3ec9d328..5523ab52ff2b 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -1816,7 +1816,18 @@ static int __ibmvnic_open(struct net_device *netdev)
>  		if (prev_state == VNIC_CLOSED)
>  			enable_irq(adapter->tx_scrq[i]->irq);
>  		enable_scrq_irq(adapter, adapter->tx_scrq[i]);
> -		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, i));
> +		/* netdev_tx_reset_queue will reset dql stats and set the stacks
> +		 * flag for queue status. During NON_FATAL resets, just
> +		 * clear the bit, don't reset the stats because there could
> +		 * be batched skb's waiting to be sent. If we reset dql stats,
> +		 * we risk num_completed being greater than num_queued.
> +		 * This will cause a BUG_ON in dql_completed().
> +		 */
> +		if (adapter->reset_reason == VNIC_RESET_NON_FATAL)
> +			clear_bit(__QUEUE_STATE_STACK_XOFF,
> +				  &netdev_get_tx_queue(netdev, i)->state);
> +		else
> +			netdev_tx_reset_queue(netdev_get_tx_queue(netdev, i));
>  	}
>  
>  	rc = set_link_state(adapter, IBMVNIC_LOGICAL_LNK_UP);
> -- 
> 2.31.1
> 
> 

