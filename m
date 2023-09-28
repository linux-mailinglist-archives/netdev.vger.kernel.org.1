Return-Path: <netdev+bounces-36803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 057EE7B1D7E
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id EC8ABB20C2D
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FA638F92;
	Thu, 28 Sep 2023 13:18:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4FF328B0
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 13:18:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F1AF5;
	Thu, 28 Sep 2023 06:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adi2eUBMEJ+iV/0/Ds3khzkeaHgSNIj+Awki878KIZ8KI9Pz5JIDB1awSKZhoHRi0eGG+PJDp2+nZsc5yZ5iImQr6UYurkxyuqLUeagn90EBWSIPSkBU5nhii15PkHIE35+v92npzbbg/eg5yFUvbN8z1rk/Mx7YeLDKSr99Gnxhjo6Q3qxqcEmxEjtRsMXiSnjV03chgRnRnFjY1ehPKrJF9Ux1DwzxmMPFcpdWfkYQSBf39TipvHpHlaKmaRggtFwOMYFvZVk8oTJVQTQK9l3dQQ+ljXJ+mDs7526uVDSDpuZztHb2esnUuYyY5iYJCXGTCfyFLo8+TpKxp+CPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voHo+QBZ9AXV3pbtkeQZBLgzvQCvKHMKGXq6joJbavY=;
 b=k6/DmoD3IT14cpArxzYUcoT3v7MwWFVFUb+F9n0EmhFdwKZVkqV8Uy10ofSvLCainfPuctVKkuK0Oi+AxmaFrYF9n1tpVBHYpihI+yvung7Nq4XXFiaIg1EFd19dpR4tdcozZoqFs6qFsRmdbzyYVnzK4OtUQojmFAbWn0Rdg90HyxiWAmahT5xI29l3BpYKL9dgfXUZQmElgmxmZAxHwwBjJjQdX/FP/cVRkI8RT1cWnR68chvQzRSSyOI+mIWbifHhFCbndehjrgQwE4KT23hKxbZiXS3qM4f5t6k/pQwISCQO5P5LKQTGT7w+YFJz3gQ/jesgOk4LsH1KoWZfGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voHo+QBZ9AXV3pbtkeQZBLgzvQCvKHMKGXq6joJbavY=;
 b=gVkIqyWTgE1KVC4elAd0sHyajGM1QrT3htoq8umAqeL7NfhsxbYQXM+ngTPdkTNPBcmxQPf/gkV5aIzViAfvIUb1kTLREz9+qv9Ahd0ZpTqRbgsKYOdK0OzoCVUWvRplJgk6J6wrB5r+lgKxDUJk/Dafe+A6+CzDoX5A5yPDF9b21ri8m8YUHFF8ak5opNog02xhE7JjiXda8dkvYebVHSUmwyYmVYymqf9RVRYuXUZRc4mj80BF5ywwG/mJqykOO6Wt87NgW4+rm2mA95gkSKamK6zLYvK6F0UFIPsSPrM91KnTeL5CX3uMgf4q7rIy1OjM5UPY+C29y5+oLiu+aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Thu, 28 Sep 2023 13:18:14 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::c470:9f69:8412:7414]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::c470:9f69:8412:7414%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 13:18:13 +0000
Date: Thu, 28 Sep 2023 09:18:08 -0400
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Simon Horman <horms@kernel.org>
Cc: Liang Chen <liangchen.linux@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org, keescook@chromium.org, Jason@zx2c4.com,
	djwong@kernel.org, jack@suse.cz, linyunsheng@huawei.com,
	ulf.hansson@linaro.org
Subject: Re: [PATCH net-next v5 1/2] pktgen: Automate flag enumeration for
 unknown flag handling
Message-ID: <ZRV9EO8JauF3O8tx@d3>
References: <20230920125658.46978-1-liangchen.linux@gmail.com>
 <20230928112108.GE24230@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928112108.GE24230@kernel.org>
X-ClientProxiedBy: YQZPR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::7) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 9585326d-17b5-4dfd-3580-08dbc0255e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z1DgOlmluQlZzrAdWhkv8vNVXTsoE0XGYmzxcm+Q9FMilBVHQyt7rELSouAenAfccATno1LLgmxCDat7iZcpiH4WW6YEUHHap6xahdGv1uwxV+ViIKO8xkQTz4qnu9GohTw24/jWoo9Wc6ecp0QfkTwNJqMSMXxGeWmJaz6kYQo3OVOaGDz/j1zQYYXhrwdusTyBxcXyBM/jNcy9ph8ccQopj18qGP93myIFazUyFcvTFwRxk2yyKdhK/o+p4zdfsL6sdIkJ7jATqGkWNs/XN4vEGXlfFm35h3uNRP2dqzIHkbkYgDqaTE1dda9HGEjPpdxMW6F2oBb/PgshhQA61/k+2jnJMoZ2A7Z6FepIKz8orKsgBH/EgzPQPetFeURcMwXfTyUJgafRHnl7W+lWbgmI83YB502bTOqYsp2zxmTcYOnTbP75pFzophNDaVgoBnQ0tEXJ3RfTIwHxaM0iQ7lzPMZV9njaVY2aFtY+t3YA3qJnIZrY8MDCloVsX9ObHo3js1+CABz1wAuIQk3enPejvT5Dcp7F6/CXEDKpNcvEG8nmmIu/K4PmIVp+rHj3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6506007)(38100700002)(2906002)(7416002)(83380400001)(6486002)(66946007)(41300700001)(6512007)(66476007)(478600001)(66556008)(4326008)(8676002)(6666004)(9686003)(8936002)(5660300002)(53546011)(316002)(26005)(86362001)(33716001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/WEai2KrM96Zy3MdTTjfGMnxSeYxdNmdRlQdotCjYCt2Oo6QQY8WJ0oGyDs?=
 =?us-ascii?Q?AUcBEASMu1rQ8sO+ftNSV3mxQLLZgXxCEFi5hgl813lcE+pmlkUPU5vC0X2q?=
 =?us-ascii?Q?gFyhT4UgHaWPtPTTKeWfILflcCQpXtE2zkfjZBXZSRPyL1MTCCBSDGK8Jm7J?=
 =?us-ascii?Q?jKA9TzTMjT9CiMUCwWz+Ld+RimPpqvn8MEt3FJeCAXZkKQt/pvKskU3kCM7/?=
 =?us-ascii?Q?yyyK+WTGsr2pgOfGjOfvWXsk1zdi8BIX9TgIchBJHlomCmUXExSqiOCQ6a3d?=
 =?us-ascii?Q?Oy1p9unsxbk2MffNFGiHHstJxRk+RfxcLeLvZP8qPDg30YRX6BeaYq/EgucR?=
 =?us-ascii?Q?UpQvtDVkBEPH556SMO3Cjsly+3UicdAO8AwEtjAVckPZCeLCsFkn3+tJl41l?=
 =?us-ascii?Q?rU9/Bs5hb6En5SWMi6QLWAH0/1FVzJ1bn/jJEpynXBvzbV3exV8aGBt20FBX?=
 =?us-ascii?Q?P7bj8aVJ+kqnUpxhitD0sDYaQWEfggUuEzyVLb85DV16NW8LvE1G9MqU0PBK?=
 =?us-ascii?Q?Ua7yTsXGHeXfjjhBKq/pElp/SxgrDiE5IjJlpEa22HjTt4IV6/p9n11jtHq0?=
 =?us-ascii?Q?jlJeQtDa/IqhDjwz6yn/UDto8AeIRgHfWmSyG9MOLZjLE0iH1FbFVW/MZnmi?=
 =?us-ascii?Q?ZwYTFEA+ooYXPNhPnUH3oxi6g0ax2/0xjjEn2XbOovNf/gG1DjFMKugzAyiv?=
 =?us-ascii?Q?+sCdz/0aOfFgKv1bc1xOCtqY1BadY8TXKhEuzDXCv8Jlgdrij6JClYoYrc3H?=
 =?us-ascii?Q?B+a/w0Vie9/i+BGMT0ChmfI1g0RVA1IWdKlQ9YD/0k9mtrlN+V4EwQ+n8r0L?=
 =?us-ascii?Q?S22CBD/kxZR+v0EbwA+Qb6Pd0HmKl9OPIxYPkVomE+KQC9AcSUXLrocss683?=
 =?us-ascii?Q?Hdb7sJ+4mTGHEm5QwMJ4Kmq4tzEQRNYWQvwXzxwRXXggjq0tJAJIeL46MU4I?=
 =?us-ascii?Q?2Sinp8dJRUfAClLfnmtNm1m+UZH+vEDxsvEzOPjTkqGbmAu8njjJumQI1LYD?=
 =?us-ascii?Q?Gnd4lktsVr9+Jk82kDmi/MZKDVXWW2QGPBvDNtaC9Dk7uTaeEIFLT640B7zM?=
 =?us-ascii?Q?IJ6eNq8tU+2Udme3S09vIpokbpcokBwWVcsloarNFGXt5fT0GGyJLUIZWTJm?=
 =?us-ascii?Q?r19p7EXnHnibnsd4CIH3ZMy0IGX3YNHULKrIuKVBFnGrik8k5499ewCORlsm?=
 =?us-ascii?Q?6QaYPRJg8chH8tkrfGQRf2WyeydyVamXr0IC8XCSSr7EqHElR/FpcLwNsZaZ?=
 =?us-ascii?Q?+16ldy8ejTGLBzhDASEOhgHMnnBdF+tigi7qtLh98ae2DiH/MTSaSuSkFRvs?=
 =?us-ascii?Q?0Bfn+EsTGHbv3y+AZUWE9oWcCpMuBjhqxKr/yBAuHS+PFKPkAawyFAHZuZbw?=
 =?us-ascii?Q?EpdnPQtLKu7GvKm8/3kBlX44BGqpLVWOdXlfjJPIoZIw9E3zg+6AwCZH2FYg?=
 =?us-ascii?Q?VQazt7kTObobFKBqfX8CKHQlBs27MccswcKivlOXWhMs4N5G3jfu2H1fb2qS?=
 =?us-ascii?Q?xjJH4Zl+SuwtA+K3L9bvQ49LjI83suEV2pKCLMjN5ot0sjEs7B1jQ4cw3qXx?=
 =?us-ascii?Q?zQDlIyyEUhpkxvFVgb7Uu7Z8TTOoqwJZvRS/QfVW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9585326d-17b5-4dfd-3580-08dbc0255e58
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 13:18:13.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieRvXb/wQ3RrJG/3ShguJNpbZc2r1kmiPfy5+3/mP74QfIrn6UBKInz9mRC/SLB5eo8V+wcR/UfxyfP4uoOCqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-28 13:21 +0200, Simon Horman wrote:
> On Wed, Sep 20, 2023 at 08:56:57PM +0800, Liang Chen wrote:
> > When specifying an unknown flag, it will print all available flags.
> > Currently, these flags are provided as fixed strings, which requires
> > manual updates when flags change. Replacing it with automated flag
> > enumeration.
> > 
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> > ---
> >  Changes from v3:
> > - check "n == IPSEC_SHIFT" instead of string comparison
> > - use snprintf and check that the result does not overrun pkg_dev->result[]
> > - avoid double '\n' at the end

      ^

[...]

> > -		} else {
> > -			sprintf(pg_result,
> > -				"Flag -:%s:- unknown\nAvailable flags, (prepend ! to un-set flag):\n%s",
> > -				f,
> > -				"IPSRC_RND, IPDST_RND, UDPSRC_RND, UDPDST_RND, "
> > -				"MACSRC_RND, MACDST_RND, TXSIZE_RND, IPV6, "
> > -				"MPLS_RND, VID_RND, SVID_RND, FLOW_SEQ, "
> > -				"QUEUE_MAP_RND, QUEUE_MAP_CPU, UDPCSUM, "
> > -				"NO_TIMESTAMP, "
> > -#ifdef CONFIG_XFRM
> > -				"IPSEC, "
> > -#endif
> > -				"NODE_ALLOC\n");
> > +
> > +			sprintf(pg_result, "OK: flags=0x%x", pkt_dev->flags);
> >  			return count;
> >  		}
> > -		sprintf(pg_result, "OK: flags=0x%x", pkt_dev->flags);
> > +
> > +		/* Unknown flag */
> > +		end = pkt_dev->result + sizeof(pkt_dev->result);
> > +		pg_result += sprintf(pg_result,
> > +			"Flag -:%s:- unknown\n"
> > +			"Available flags, (prepend ! to un-set flag):\n", f);
> > +
> > +		for (int n = 0; n < NR_PKT_FLAGS && pg_result < end; n++) {
> > +			if (!IS_ENABLED(CONFIG_XFRM) && n == IPSEC_SHIFT)
> > +				continue;
> > +			pg_result += snprintf(pg_result, end - pg_result,
> > +					      "%s, ", pkt_flag_names[n]);
> > +		}
> > +		if (!WARN_ON_ONCE(pg_result >= end)) {
> > +			/* Remove the comma and whitespace at the end */
> > +			*(pg_result - 2) = '\0';
> 
> Hi Liang Chen,
> 
> Should the string have a trailing '\n' in keeping with the current formatting?

A '\n' is already added when the string is output by pktgen_if_show() so
if the string above has a trailing '\n', it leads to an empty line in
the output.

If my count is correct, before this patch there are 56 cases that output
to pkt_dev->result/pg_result in pktgen_if_write() and only 3 of them
include a trailing '\n', arguably by mistake.

So, I think it's better to remove the empty line than to keep the
current formatting.

