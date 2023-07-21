Return-Path: <netdev+bounces-19812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FAA75C717
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDFD281B86
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 12:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C602316428;
	Fri, 21 Jul 2023 12:47:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6429AB
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:47:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2103.outbound.protection.outlook.com [40.107.220.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82573A81
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 05:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VunabkO+2CzhZ/qKBII2ZKu8wCMedpHWkNg2MqPB/jhDVpaIoX3j9q7naK5f3cfK9hVFjb5GWKAqqyZ9jTXcNKD/vtW1yL6z1AJwgG1bW7OrE0TWyta40PuyizYTmU37cXkUdA73akMr9Kt9fHwkDr7HaH15C8ddVjEsemE0D9x1A9PpPhIIyPefMNO62PWpirgfH8IqsNGhzo4J8GkknRhDYVQ78SUouKOS6YKBbuHzzAT2iwddVwFXSr13DwGHq1yx5m1LPmGMAoI4UB5eyYtR6V+PqOaz7NvA1MgBbrGuUdsGr79E4opwnN+E8M5frOKZlZ9AlUX85e54EI1o3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb0prWglH7ndJQDridO7IaS7sMk7T96C7OoHMBDx/Wk=;
 b=L1F69zVQ3onOwjy/2dj+/R7LY7X1pGebLlXMF+YmiEuAhucsX7HfdJtg9jQQRNcUUqvLjb+3ujOK6GJBRf/6af0yh1iIPoU9Vft6a6bXSoPJV0sGTumy3znsdIRqoylYHFjCEa7GfMI3rZ0kH/9HBaFyaZ0q7Y2w6mu/4nHKMqJQAhUhsmi6sjboHg5dcDybY+n2bH+folyuxNu1lmqJLGopqRZnA54YSV/3VcHI8oM3oiVgOpPoAGe91g6kscpNfJvWzKUcrCsZBaA3kYeOZeoV+3s1H4Yv+UoAMg5raMdRV4w1GwyDXdT18+WeQTZtCjHOv+mrKAVw65U+wI6VPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb0prWglH7ndJQDridO7IaS7sMk7T96C7OoHMBDx/Wk=;
 b=W4aGWSu2Jui91qDnG1xWAHm7hwZibTgxIjW1E1yI39EzTRk4L7HU+iLyP45hSr96NYhmEU2UY8i/RjPEcuklHVvlS96c643kVmC47NLW6/agZSDzH33N7L1C1f3AjNrU/T0/Hz3qlDpxbHsczZoyHGu4z94cGBjmkronppAE8kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH8PR13MB6271.namprd13.prod.outlook.com (2603:10b6:510:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 21 Jul
 2023 12:47:09 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 12:47:09 +0000
Date: Fri, 21 Jul 2023 13:46:56 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Jiri Benc <jbenc@redhat.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH net v2] vxlan: calculate correct header length for GPE
Message-ID: <ZLp+QOjOrwTgmOCe@corigine.com>
References: <544e8c6d0f48af2be49809877c05c0445c0b0c0b.1689843872.git.jbenc@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544e8c6d0f48af2be49809877c05c0445c0b0c0b.1689843872.git.jbenc@redhat.com>
X-ClientProxiedBy: LO2P265CA0282.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::30) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH8PR13MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: c1426e59-75a9-411c-fde4-08db89e898af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wcJQ7fdMjldQwnwlVFlW15XVzmIq16eIwRSiWPNiDnzD6TWvEK5DVSqgdfaGbdnsd1zM9pcEWpG4QwnZ9z0OAcXsNqAdhzSK/UumNj1frD+Ceyzt0Y5SbdP6mZnD0lWupmeTTC4no5p/fwbU9qpLNLu3qPCLxWGuBWVVI6YQ952i82eHNSjYEOoMIhoObnfQIdUQLZ5zDMpBq1oINwzBsqfGjT3QHk4/9PKWok8i3ZnzDfMPdyGQc2waQh471GJkr+FbmFSk/pHg82ig8doGS9GNeGYzOgAZQ8fVRZqXIDyoBXzhHkkT2cEZ5jyFZTw3SI8W/Hm5uCEIaKKEJSEOcwqcjzMMprf76LP5Yg34tibkv6PrWTbuadzhpdNfWxtNenCYvXEZn3ACpLs0Nsvq7O5+AAkGmwQMmCdwIsrneaPBQDaZfLCaTxnTsrcpLV3i7PtPalTDS4XmbeBNTbuoIeNRD/mJmTTF/mLQsATY/z2l/nPSM90Z9aJ4l0RbLZ8CR4SoMl4ILk4D03ibkC6PGRMoY4tYvfAFcueNDx24p91AAlT3RDWVKMfW8HQDlw72fqZvbQIwV1Eb0S7M8lQ6M9Osz3mHPpk/lAlSSX8C3cdwo/EDtB0eYD8Jx9wB7twwAVHeSnqtrmg5Yh/Gn4uaFkMiwMCv73Qj2NKBiSd0GUw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39830400003)(136003)(396003)(366004)(346002)(451199021)(6486002)(6512007)(6666004)(2616005)(83380400001)(55236004)(186003)(36756003)(38100700002)(6506007)(86362001)(26005)(66556008)(6916009)(4326008)(66946007)(2906002)(41300700001)(316002)(44832011)(66476007)(8676002)(8936002)(54906003)(5660300002)(478600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0PIrkbrqdnVqgmjrcG1etnfOs/vCwgxnDpV2E8QL3ufAg/G4wVzMXzsfZrO3?=
 =?us-ascii?Q?rFai7gjmuyJ/d0N1Ilar7C2+ujeK8FMWQ8rjN0+5NQuiSJom7nh/Rxdqa1uT?=
 =?us-ascii?Q?pMQQQYrpsjZpKi4ADRyEWYSQoflrnHQxgqV5cfOeaW998kqBw0i2nl1asJJU?=
 =?us-ascii?Q?10/67SXyjNYRa8JZVaD2iH8LWd50XrcUqo1Ig9TKrBi2Ys+FMraOZ8NoWmeB?=
 =?us-ascii?Q?Fy9Wj9SbmQeW1+vSKxvYwWemwnnxkK0zloLwaXuZhEGFO3wFu4Twb/TyEGNM?=
 =?us-ascii?Q?qNuCpuPDRZg2gPCLJ+WZag5ia827Mrq5/bQuCwVDOrjpYnpWtRevdLEbuA2H?=
 =?us-ascii?Q?2yOBAcVQ3K7Q8EgrveAP2Y36hSlBb5RfBqIQYmctKpTWafqpxO90l9rz6w7+?=
 =?us-ascii?Q?hdRbHEI+u4of4gWQYc7ll5aACSVJu3Vw7mxHmihblnQ5GCJsOC8a0CmQxslV?=
 =?us-ascii?Q?8hWDJUiFW6GlmaVi88+avPsowtsho0OBIIEdIE/KJvn2HbVePnypbbuxEPxq?=
 =?us-ascii?Q?jzdqKAVeOhyRa0C/F65tBVHIL050EZpmak+aC6IEkl/FISbb0CNuGK5b5nLO?=
 =?us-ascii?Q?ggcyLie+c6LLjdqq/Cv2O87WkbcMFyJiIECQNykVKp/CsiI8s7l/ywYhnUwU?=
 =?us-ascii?Q?SlZD6LNzTtZ3BQai6XQsby6sJ9phFkdffGlgXYvhya/QKowLXsNzyhu1vg+a?=
 =?us-ascii?Q?HS76ycTUEwAPrAoZHPkcxkoCG4wClJhP9nYNkzfKa/efbRFCIWeY8tIXWRZX?=
 =?us-ascii?Q?I7GfwB3gfQVrAKLq6y0XNYAPAF4AMQjC1YBZyEa7s9AIfSps09ZaajJE9tXi?=
 =?us-ascii?Q?5zxK7s5APfxH1uZ9ryFypmIfysWCKxyEHlpXihTDW2jPWZvX2sGq+LEn/qHK?=
 =?us-ascii?Q?MyWlC5b36qP5nVcuk+6UQJ80bJwhEn411frCtQ7EK9oNCkK+vq3tRNxuSGFF?=
 =?us-ascii?Q?5b304GpidcWVHmQmSr0CGzS3HPMmO2poI+/ThZAf3JeGl7LvtdEfMYA9JwAY?=
 =?us-ascii?Q?/peBwOCxoYdO4n5Zul53/Mh1x7iKX0ufO55qM/kMO+5g+rP56yi5DQwRPou/?=
 =?us-ascii?Q?HFO6H+6BhVFfD9akfz5HRqvqy0SZw/G3UD3MBfx7CPaWbNZ3oHLWB9dJj8wa?=
 =?us-ascii?Q?ZPyxX7WrWPb0po6vGMSuXQtGR/4FYvSIU1uYSL747GAC7Zx+Ym7hpG7g0art?=
 =?us-ascii?Q?q8sOA0H+Ge64z6L2qwqvVU6U9966Wd8R4Goq47WmWi4HUsw6oij2GrhXtQps?=
 =?us-ascii?Q?dduBQQYA3cG73lWrjIYwYLjsfWIF2ULXEYko13Xulj8tgBqu+PCVoyHsGIVl?=
 =?us-ascii?Q?9AqpYvjkD5ILACjNGdrbLAUGWtWn9ymu4YHBZMNzM+BneQr1EeAPliePSfQO?=
 =?us-ascii?Q?NF4jCD2AdpmGsNz0Krq5OkzJjf0BrcSvyhmHt4gzDkzP/B0IMQMIsc171Z6o?=
 =?us-ascii?Q?pvtZra2K2RvbrTzdz39V4Vqy7JNjy8NB4Lh4PmZsp1Y4HVGFyq2fXfIXwKAc?=
 =?us-ascii?Q?L63RQSY0CLnqDiMYUBRf+JQ7woU28nwUWj4GgbCk1x+BIrhrQz+T8oZdaFqf?=
 =?us-ascii?Q?euMNny/TIk2WDqeUUiZnFr3u6Ga7de+vj5GlWB/zpyLh0mG6Pr58rwv7aDLy?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1426e59-75a9-411c-fde4-08db89e898af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 12:47:09.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRs3G/vFLrzkMIraHvF3HD1KN+rl4fH9Ds3ZgF1yiYuPTHXbI1papvsK1wLmEpxfddemwidcm3lzo1M+u19hxe4wvC5hWE0PluIgKSz3g/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR13MB6271
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 11:05:56AM +0200, Jiri Benc wrote:
> VXLAN-GPE does not add an extra inner Ethernet header. Take that into
> account when calculating header length.
> 
> This causes problems in skb_tunnel_check_pmtu, where incorrect PMTU is
> cached.
> 
> In the collect_md mode (which is the only mode that VXLAN-GPE
> supports), there's no magic auto-setting of the tunnel interface MTU.
> It can't be, since the destination and thus the underlying interface
> may be different for each packet.
> 
> So, the administrator is responsible for setting the correct tunnel
> interface MTU. Apparently, the administrators are capable enough to
> calculate that the maximum MTU for VXLAN-GPE is (their_lower_MTU - 36).
> They set the tunnel interface MTU to 1464. If you run a TCP stream over
> such interface, it's then segmented according to the MTU 1464, i.e.
> producing 1514 bytes frames. Which is okay, this still fits the lower
> MTU.
> 
> However, skb_tunnel_check_pmtu (called from vxlan_xmit_one) uses 50 as
> the header size and thus incorrectly calculates the frame size to be
> 1528. This leads to ICMP too big message being generated (locally),
> PMTU of 1450 to be cached and the TCP stream to be resegmented.
> 
> The fix is to use the correct actual header size, especially for
> skb_tunnel_check_pmtu calculation.
> 
> Fixes: e1e5314de08ba ("vxlan: implement GPE")
> Signed-off-by: Jiri Benc <jbenc@redhat.com>
> ---
> v2: more verbose patch description

Reviewed-by: Simon Horman <simon.horman@corigine.com>


