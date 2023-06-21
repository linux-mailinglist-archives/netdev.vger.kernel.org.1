Return-Path: <netdev+bounces-12646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C127C738577
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2541C280A16
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B475E17AB8;
	Wed, 21 Jun 2023 13:37:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702217747
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:37:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2131.outbound.protection.outlook.com [40.107.243.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3CA191
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYwm8X/zh/SdXOnfBnZV5AM1B5SdJ2w5jRBf3/m4s1FpIz9/ElClt//p6u7BP8V+Iy4x5Wp6vVzDpz6mFiD9kkkoc2O9TXMXfkPFmdJwgKvKfNgmJeSRf4tNQ2bgHfAyqSHnDIhTlzHh9rjuZibgbfRERIAjHtvUrgQVVs/RvUyyvsMSuk9BuxKmFv4eZ3KqT6hRdOvzQCTZPyCZP15xAxPy6/URN1VjFAZo0Ye1gnJXpqK0qjDcmKk329mm9FxjefqEZgQhbh5VnKLCzGpkDkoIfLQ1BBNSYcki5kxqcf+C1Qow2MY3VayOVUN2fVG0F7Ahjj54OeT7TbxsV6y6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JERUHW+GVBKwe2sueT7P+TrMtJ2zdC4MKwKdbFbpUD4=;
 b=NJ5CF/7YaQ90bFCei5Dw9FIelJ52UiXuL69qQizH7y4ZE8CAValTZWuBCyPBXh2wj34qzBJQA3YOuyC0/N6yA8pjjk++dNqffgojxDAQ77hR/IL7Igu4bcg8YhuipUweXN6rJ2v3jXjM2NNBV8EnQMEwAI53YUM/xm1HBSK7SIW+pDUyMFKBJsU0O+IDEAtP+E6TJwrEaPP7ogYDat/BbzGmDNAHCys2T+X3pn/f6CuhKcITeF8tIH70VPyCSm+Y4+iusoLIez7xGrpqRuQMbeQHoNpufYzBOjzsi/UD3QB2rM2RKmf+PO2b+8oF7VpPjOJ0wrIHkCLjL1nr51aEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JERUHW+GVBKwe2sueT7P+TrMtJ2zdC4MKwKdbFbpUD4=;
 b=WR+iGthT5gkYfc/0UEucWwC1j1J2iep0nQ7V59ZPmr/V3kX7+NzH4IlDC3AHWeGbawkDcVeNvDjSiId+FBk9Zhq57o79wlV5kFmK3tRYmztPFg0vUp9zLvXrYU6N3j6gKd4eTin2WJ7DPQF1wO4Qgn1k/bp5o4uSJ+rDiY7hlm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY3PR13MB5041.namprd13.prod.outlook.com (2603:10b6:a03:36b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 13:37:46 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 13:37:44 +0000
Date: Wed, 21 Jun 2023 15:37:39 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next v1 1/3] led: trig: netdev: Fix requesting
 offload device
Message-ID: <ZJL9I5rQlYFUZWPp@corigine.com>
References: <20230619215703.4038619-1-andrew@lunn.ch>
 <20230619215703.4038619-2-andrew@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619215703.4038619-2-andrew@lunn.ch>
X-ClientProxiedBy: AM8P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::33) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY3PR13MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: 97414c70-299d-4204-6283-08db725cb1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nl8cgL2FQ5Xv2WII6opScxAG94e88gFtZy8Z/hf26Q3Jcq8NWuUWYlbicZWZFeKudp/vl+jV3MutOzhdz7mVH8WUx5v6SibrVRn5nB3WzrFiSlxpUSzHVjmvCFWGqURIG12cQlkkp+jBDyrBkW4Idq0cz9RIfzMa8hBO8vy6LBcZXwgHmsCjJGxFe1yl9X1bVYtvbcHHq/ndGCGOaEsYfH0Vgkio2wZGbRwD8aLMcXVyTqkj7m4lJNclYjwjAmvgDTEL30ZatfFGlPyV+xuAFTyQSD3XPSYNo+fQt58EJj7bufTSaNyYDXvGrnvwbF4tyPZvlGz1+DLaAe3tGKb2Z4WXih7wpT9iDeusz4iOgbh1GwaF5x/qwFHV0zwpFAPbClwEIDQt/kqMcEqj0YDwLKQCXB68vPjnbJMWmJSQwtxqPfNwYiCe/xJkg/3WUJoYf05HAHyypH0ZZXaDqfmEQKUXQFT644nhFJqps9dci9WOSfW5mX+pSt7I1VvAA1orcMSFZD9whPUjjPUhgVciSVKYQE+9bjEriM21Qe653irzztI5b/pVUQUM/BDpgXae0jch4wayRu7Eo6AztOiA03fiAIr9g8s001HilO7Nosc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(136003)(346002)(396003)(366004)(451199021)(478600001)(6486002)(83380400001)(54906003)(6666004)(186003)(2906002)(2616005)(6512007)(6506007)(5660300002)(44832011)(36756003)(6916009)(38100700002)(4326008)(316002)(66946007)(66476007)(86362001)(8936002)(8676002)(41300700001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SQ/5NfTW7DuJ1JlwgrVgPgjYsmmXeCgh4Lieoid6LX8UmLWPadfFBzGeyaUG?=
 =?us-ascii?Q?z17DnYBoEZh4NdCmjeshQ2EVWnG+SDuXx6s/+XYuaBc4Vz2nesV6Xm6lMzPo?=
 =?us-ascii?Q?O5KkUFjVjuGuPsmDKQZR9jmR1c9K44nWCKfO7EpgZCUd1HtAeTbCus3NK+2Z?=
 =?us-ascii?Q?wsnPCl/RwH/sbTkIIFBYj1pi/0m180vYXmhKvcA3jp4zuQYaPfbexOFaxHjr?=
 =?us-ascii?Q?ED86427d3hWAlOByvdSbA96iz6yP7zhWem5zgWWCIF3EU/+UM6d+2foLPVQG?=
 =?us-ascii?Q?QwEsNQAvWD38Ve6ril8AjF2LfhtCAmD0Xw53i3vLDNzCU5pLStIwV0ewXjas?=
 =?us-ascii?Q?KFyvh7hhBrsW91GII1MK8gXpcEhXXuE/ONi2WvkyhZty7uEOfGXr4joSc9De?=
 =?us-ascii?Q?8r9Vlwc6DYSiIfefBie71HBjpHiWViJCXylrbEw7JS/VuuymcypS1ss+qV5Z?=
 =?us-ascii?Q?mzK2L4zaIY03GdlUWB9hQ/uaU+Wt+TZZVsb6zleleQTkED8618Obk6SqhctM?=
 =?us-ascii?Q?ybNTTtITATFY750cSATb/CQc283Yn50fFS1T4dHMpS0Euynk2h9crIk1xm+R?=
 =?us-ascii?Q?636WFskAbTBY6uqZoWpodfzCN52h3o4hTtIjkFTOALj/DCn/2a5AZcYkPmyr?=
 =?us-ascii?Q?Oaj7XO/rRDKlc7k/P3Vc3aWXpv2g+G27UBBXPRb61aQhybckBUHun5C4BtFd?=
 =?us-ascii?Q?G3Kbvl536GnLJEXoGgD/krI81NBxT5MdR2v9COUR8N/+XpjfaePEaVHQqW9C?=
 =?us-ascii?Q?pfu+v146b/q93oOj+CkejNTsJG6X45UO9yJ5D1CpKTqohIj6m5lriNzMrdXv?=
 =?us-ascii?Q?sCE3ZF9JMQY9cS1fgvX0n53VZGzOEWeeK2VVJc3uJRn6FVFmeV1Io83w7BNE?=
 =?us-ascii?Q?P6ntZHZ4UB2zVexdWJHqEzFy0j888I53PNtduORRnaPE7SKuiLF8aSlh9Zz+?=
 =?us-ascii?Q?RfEdBZYKlzWyWudB9YZhCFRzvGtr/9nB1/+XIaMkqSXGGlx5k+ZEYZLMzMCQ?=
 =?us-ascii?Q?/+/jRYqn36cRmgYGnzvFDs+Wx+lWFGWeh3ctc6GtXhamGdFED0fJBMAw7B2k?=
 =?us-ascii?Q?L8x9Oy5gGZg/XjffmbMtkPxku0v03DQfW+HhlQ6xaLGCdTawfSbNtZeYJbmA?=
 =?us-ascii?Q?EYIW40oipt/bzlV9BrPe+lN4u7Di450tJOJbKbpnhZRxxBrrIVCr0wp3pDK2?=
 =?us-ascii?Q?qcB4kYWX7VfhlydhJSCOClnmARLjjM52hdNM9HPqKU8cPI1YZpzK8k3GE/Ag?=
 =?us-ascii?Q?r9nO3cVDXsVTEtwvyYQpqhXFSp6eJPS3DzSK9VobUyKQJ1+OATeomCPiO0kc?=
 =?us-ascii?Q?NYXQmIRaab8tcTSAYpywYvcG+YH6H2FmePXlL06HR4AelU88KTeKovSJxQPj?=
 =?us-ascii?Q?yRGrcDTi1wk4HmgdxlUGKk3Dfr47wH+6HsnJt9xji/WyW5Eyuw4QGjDJWs/m?=
 =?us-ascii?Q?SYDTd6o9aD/qGr8iZG8iTA384QOdshEb0R/X+58Q/PJnwvUU61//i1TlEbYP?=
 =?us-ascii?Q?pGJp/aZmWv6ibH7nVX8y0Ia0l/o7EjZJAyn45KBCfa/LNOpDl3K55NyzcXl0?=
 =?us-ascii?Q?kX9BcZDxT7gS6A0V3AhzEtTaTb3QRdSJsmCGvKXx/oRU7JSPj9XRNx4b4Pe7?=
 =?us-ascii?Q?yOh8ZV27LtkUTfjmgnebj/LJiuWw3I3arPagiPq4HQyeCtgoJCORGfXG3NHn?=
 =?us-ascii?Q?dP56OQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97414c70-299d-4204-6283-08db725cb1b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:37:44.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJhFFNVNqbP4vgMYyrv3pI7YvPL9l6tZ7SNVnuh7LA10WKRmqoHiQcpFb8W4lHUJNrJM1CvWksjy7GA+XsLyOOS2d9qsdmkmiOYXUU4DLrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB5041
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 11:57:01PM +0200, Andrew Lunn wrote:
> When the netdev trigger is activates, it tries to determine what
> device the LED blinks for, and what the current blink mode is.
> 
> The documentation for hw_control_get() says:
> 
> 	 * Return 0 on success, a negative error number on failing parsing the
> 	 * initial mode. Error from this function is NOT FATAL as the device
> 	 * may be in a not supported initial state by the attached LED trigger.
> 	 */
> 
> For the Marvell PHY and the Armada 370-rd board, the initial LED blink
> mode is not supported by the trigger, so it returns an error. This
> resulted in not getting the device the LED is blinking for. As a
> result, the device is unknown and offloaded is never performed.
> 
> Change to condition to always get the device if offloading is
> supported, and reduce the scope of testing for an error from
> hw_control_get() to skip setting trigger internal state if there is an
> error.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
> index 2311dae7f070..df61977f1fa2 100644
> --- a/drivers/leds/trigger/ledtrig-netdev.c
> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> @@ -471,15 +471,17 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
>  	/* Check if hw control is active by default on the LED.
>  	 * Init already enabled mode in hw control.
>  	 */
> -	if (supports_hw_control(led_cdev) &&
> -	    !led_cdev->hw_control_get(led_cdev, &mode)) {
> +	if (supports_hw_control(led_cdev)) {
>  		dev = led_cdev->hw_control_get_device(led_cdev);

Hi Andrew,

Not related, and perhaps not important: I think the scope of dev could be
reduced to this block.

>  		if (dev) {
>  			const char *name = dev_name(dev);

More related, but also not important: I think the scope of mode could
be reduced tho this block.

>  
>  			set_device_name(trigger_data, name, strlen(name));
>  			trigger_data->hw_control = true;
> -			trigger_data->mode = mode;
> +
> +			rc = led_cdev->hw_control_get(led_cdev, &mode);
> +			if (!rc)
> +				trigger_data->mode = mode;

Is the case where trigger_data->hw_control is set to true
but trigger_data->mode is not set ok?

I understand that is the whole point is not to return an error in this case.
But I'm concerned about the value of trigger_data->mode.

Probably it is ok.
But I feel that it is worth asking.

>  		}
>  	}
>  
> -- 
> 2.40.1
> 

