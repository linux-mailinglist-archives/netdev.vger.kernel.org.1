Return-Path: <netdev+bounces-21902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D614F765325
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5BD1C2164F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AB81642E;
	Thu, 27 Jul 2023 12:03:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878DDE56E
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 12:03:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2113.outbound.protection.outlook.com [40.107.94.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A06926A8
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWQTRgUCx2ukKqltednA+EynGHE8uyuV0ZD5fqG/vBtgZgZ8OVnYx/cAtnriOIVwCteIzch6wOx9Z3o1AJ0AQzGO5l+RNyyM74ah2MG5Viq+S4HJ2BcmIk7cLzWwO/ZZy7UoxNn+E3RaeXeCS/tsvz4/AOBbTzuVuCCZ66t6AvBL0JSF+opJrSXBQJc8MXh1ARoD6uT0TyVvfaUpahDBUBPi7CqwA4W00a41gvEnojHzTU88w6DmTMEwbc5nu0CCwi13VvmYeFT9Rq4WQhryzDzhqguEpoTg1UNZOsUklGwBRNv2qQ7+TMge3ZJ59TRJt7yNelgr52zS+Wo8FmmTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX0le6woNgztLmGPoRZ4jTcbnnPUWt3vSJX7mlsi7a4=;
 b=bTHAHoZXeaPdKZHXam0vHjEYHUNu8V8UvQhwLFPARnx+oGnHrlVtmHzJXkE05VB3ed8mvdg3i5pI+s+kQ16dueiKu/V/z1IgLIogCyjX6h1YXrZa+j/jBOFrozR+372hsMECfVa8/fl2/qhaAXI1nm3AZ+/SnJPBxBZ0hf1EsW3bqtTPcjVMY9URYGGFl8OpDSaM857/kAQ4SLqGWGd+eX1TWKRrSSsa8w5f98z7TDH5Ebp7640Eqo6g1lPZGFncS9oI5sZNhzjyYf0j4KR5qhmAzgL9RMhKQArIi4PD37V4y00Kh1TY2VaL0u/inaDDqape/Cp6joqnba3s6j7eSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX0le6woNgztLmGPoRZ4jTcbnnPUWt3vSJX7mlsi7a4=;
 b=QfMXJv5Gc8D2OjRH2cifeiLX9FxJK1Ez62+c81OWE/lfgavl9rWZXDuXqG45P8y1bsMAgFmsEVpt+gsnpuzX45o0a4KQ+7L9GIjwupQHDa6CnHR4GdBvOF4kZXgRwxYhSpUx4kJKTmPNdHy3M3hjOBFHAGfmKI7mw7iOJB5B+7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB5098.namprd13.prod.outlook.com (2603:10b6:610:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 12:03:07 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 12:03:06 +0000
Date: Thu, 27 Jul 2023 14:02:57 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>, daniel.machon@microchip.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 06/10] ice: Flesh out implementation of support
 for SRIOV on bonded interface
Message-ID: <ZMJc8VeEogsI8aRF@corigine.com>
References: <20230726182141.3797928-1-anthony.l.nguyen@intel.com>
 <20230726182141.3797928-7-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726182141.3797928-7-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AM0P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: 447e62aa-f496-4082-941e-08db8e996fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8kP/fJiJ8RpZCzTikdtKZHtUpSI7F2QTxN9hHDrzUjGHTsBPZ9AujjDTPf8xnOyIdbQKLtwoM13L6Sm/o1iLVJVSzorQut/GxPc2tIPcG+Q23ofMGCDFewbwu+zh94pa/KKlGQ3nr1UClIrqJpBVGAorgBpUom2bQkD9Seps5rNx9ZQ+do4MQHA5lDz/AtAcYhmi6/vcRhLY1CvJ/xS/v2la8kZM63BcymI3A8EHyxdOD5ERXmIYrKjH9CG1ks3yb04tfHU3S0N8w5mPdFdzISEvhrFir1rK/11WyG5gY7iLUPAKW+GuGcMo5g64oNhu/uluSnbZGBk0CLxav3PsMUtdpzKdThUQSqxtFM4dqC/lNl+Vs/WS/B+WfZw5YgVONGe0Ltbl7LMkZmP0n7TQU1KUgZ+CQe+LzZSZ07w0UxXlJ7UdEhAFcnYp13Kpb04vy9lMoaZzXdDI+XTb4w6kqTxd9eBVs2xqqd8FsL42MYz/h8E/l8mWnUfu44500gAVJet+wSkJpoQTgHr5tx9/ShdU1gWecwoULBFXctSsGoUq4Bl6AiVxWM7ecm7l6FCy8fLVtmd8Uc5I2t96zi4+JQXbDIoT0Wr+MgT1gsFRkIQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39840400004)(376002)(346002)(451199021)(6666004)(6486002)(478600001)(83380400001)(6506007)(6512007)(6916009)(4326008)(54906003)(66946007)(66476007)(66556008)(2616005)(38100700002)(186003)(44832011)(8936002)(8676002)(5660300002)(316002)(41300700001)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0og+PPmVYBn2mA12zKyUcxy1KazN43MFwZpnB4N10qn2uDXugD3DMEs8+U+z?=
 =?us-ascii?Q?eEo5nsOfEpn6Er+v+mJcZbPz1838ddtYErEWnbCVBEtptB0Espmr6dLB+4mk?=
 =?us-ascii?Q?WIWbzTrt5Q7a57AszaxoCpM7DBbrYy8ejUqwK+twdJaa2XKA/PH2S7xNOWQQ?=
 =?us-ascii?Q?+97Mwfhj0cfjEul3a55z+kaAKjGAzqpChRvmgj5JsVMThPbreAqbeqy+oBzx?=
 =?us-ascii?Q?b9XES6JXXEzqMHcKtpyH9PTHGRFxX8B4nJaRrRkIkrhXqLW6qdR1f51ueWr1?=
 =?us-ascii?Q?HwRLfvOxDr8StwEwjL7nsO9u+uCrak7y/YQvMsgnTnqBK8K1P+6HNjzAKaru?=
 =?us-ascii?Q?dMql5c6fEYoumbsN5vkXK1Q4gzH+BoXfgGJXn4N56zIF52KH7K4tk5AbdXk0?=
 =?us-ascii?Q?APBzWOAJ5iCgXpoOYWGwAsp7IQKm/aQw5ePcFiBILW7Hv1Vj+RZp6eBUYVFC?=
 =?us-ascii?Q?2ma3ccFuAEJJmiithxxWB97zq9eQS98tcPkskxCmH8T/wBl2Ifu4rE7cHBQK?=
 =?us-ascii?Q?upd4SUzmQUFZm+HHfJYXs1MtAxl6Gu1CuV1YaaFnWcwNnzAB9NBv2EgUoU4+?=
 =?us-ascii?Q?WqvJ4q0mKh01XFwat4XglnLYmR1e38DZHfsEhoj1H7kEZvJL4IgxVh8ahZt4?=
 =?us-ascii?Q?AalLffR/JAiXmY7MHQXpsB5s4O0jHyi0lIAQFS0NE29Yy4lHU1d6gG30b9mA?=
 =?us-ascii?Q?9tVRlYd1rqnKcXxjqDxP1/KStZf0v1bMYKLhLZES1IEzCA1CUANWf4kpt9wQ?=
 =?us-ascii?Q?fvdkZ5Uweg1bhqG4dulNJ5Mk+AxIduCjZVfmyE5Lins21cqzp+DiSJKuD47q?=
 =?us-ascii?Q?fCavQNyYRr86TEUxr8PpkPKj+8+JexPV3cMgwQpTyj12aCuqF3OhYtdScuc9?=
 =?us-ascii?Q?8Y04QJzp6GhP/prDmZFzidxtlwzN77x5mg9dGUw0iPFqRazDi8fm8p9CcCYZ?=
 =?us-ascii?Q?gY5dTZSnpmFtapVDCQwhePdjZiIULis9Om/XcY4TmIrfMExQewwL5+tx+O9z?=
 =?us-ascii?Q?ogK+yVsOrKenrgr/yql1wGSHHdVp/9UkQ6dwxb004MV9mALNevHrSaS08F10?=
 =?us-ascii?Q?CQ12e51y1RPzgCuu5GHYaCb3cllKLbT7zJQ1afC1uTZQnYCeyUbMnACoZOI6?=
 =?us-ascii?Q?FsvO0pfq8ZP7pavxzKkW9qyD/HjTG4zgMMDgvEd6QoS3MSzUQpgMc32MPH54?=
 =?us-ascii?Q?nal4ySm8lO7fF1bikqUi2JwRr3qAUHsII7qtdgkt1tbASeFclXWax1oyG6H+?=
 =?us-ascii?Q?NPhNTVdNWAspmOpZ1jpbj5G1vLis6P14GmXYBIVBou0pIsF4ufxiock5idKs?=
 =?us-ascii?Q?Gja61elgJEAcyxUA7igRrsrRxH/gyAhuEGC9h8yZVjhZAJPxb7o6VwCtD+N7?=
 =?us-ascii?Q?JoX609ty6/BWjDNOYkwPn/lrqXWv3jLvKCyUh7j8Df7Nj8p/DCXCdDtbg2Mv?=
 =?us-ascii?Q?/j0Mez/dTnjqc7az0YQ8BwL7X+rzxWNxtxU8u48tuHGtjR/8z4/RSBWPSEwD?=
 =?us-ascii?Q?FMNauvvt/WcUaBvNKEdvtZWeznYpc9yfl35T4UeugNuUma6PLjKnMfpbwwlM?=
 =?us-ascii?Q?ns6d5QTNzmQ7S5pcgGSH4bndCmRRDay8gAl++lD+sR7ft2RydIbmH/eNYKZZ?=
 =?us-ascii?Q?zZ6Pprhq+0/zSJ/Tr9Fo8ErV43T8tDV4KYT74Kit1CC0BfEWmO38ODPLf6lv?=
 =?us-ascii?Q?ee+6Yw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447e62aa-f496-4082-941e-08db8e996fb8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 12:03:06.1376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rc1E5U3a276kUiFwOXcBeB9eJULz/ZKUosM6hM/EOCqrXK0Fee1wQqDT7robT2l27dVWTAWUKZb2fnQ/8p+PLWltu2U3/dYEkkDeF6NnYPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5098
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 11:21:37AM -0700, Tony Nguyen wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Add in the functions that will allow a VF created on the primary interface
> of a bond to "fail-over" to another PF interface in the bond and continue
> to Tx and Rx.
> 
> Add in an ordered take-down path for the bonded interface.
> 
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 822 ++++++++++++++++++++++-
>  1 file changed, 812 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c

...

> @@ -233,6 +303,119 @@ static void ice_display_lag_info(struct ice_lag *lag)
>  		upper, role, primary);
>  }
>  
> +/**
> + * ice_lag_qbuf_recfg - generate a buffer of queues for a reconfigure command
> + * @hw: HW struct that contains the queue contexts
> + * @qbuf: pointer to buffer to populate
> + * @vsi_num: index of the VSI in PF space
> + * @numq: number of queues to search for
> + * @tc: traffic class that contains the queues
> + *
> + * function returns the number of valid queues in buffer
> + */
> +static u16
> +ice_lag_qbuf_recfg(struct ice_hw *hw, struct ice_aqc_cfg_txqs_buf *qbuf,
> +		   u16 vsi_num, u16 numq, u8 tc)
> +{
> +	struct ice_q_ctx *q_ctx;
> +	u16 qid, count = 0;
> +	struct ice_pf *pf;
> +	int i;
> +
> +	pf = hw->back;
> +	for (i = 0; i < numq; i++) {
> +		q_ctx = ice_get_lan_q_ctx(hw, vsi_num, tc, i);
> +		if (q_ctx->q_teid == ICE_INVAL_TEID) {

Hi Tony and Dave,

sorry for not noticing this earlier.

Here q_ctx is dereferenced...

> +			dev_dbg(ice_hw_to_dev(hw), "%s queue %d INVAL TEID\n",
> +				__func__, i);
> +			continue;
> +		}
> +
> +		if (!q_ctx || q_ctx->q_handle == ICE_INVAL_Q_HANDLE) {

...but here it is assumed that q_ctx may be NULL.

Flagged by Smatch.

> +			dev_dbg(ice_hw_to_dev(hw), "%s queue %d %s\n", __func__,
> +				i, q_ctx ? "INVAL Q HANDLE" : "NO Q CONTEXT");
> +			continue;
> +		}
> +
> +		qid = pf->vsi[vsi_num]->txq_map[q_ctx->q_handle];
> +		qbuf->queue_info[count].q_handle = cpu_to_le16(qid);
> +		qbuf->queue_info[count].tc = tc;
> +		qbuf->queue_info[count].q_teid = cpu_to_le32(q_ctx->q_teid);
> +		count++;
> +	}
> +
> +	return count;
> +}

...

