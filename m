Return-Path: <netdev+bounces-21365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAD8763607
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534E91C2124D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E63BC146;
	Wed, 26 Jul 2023 12:15:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088ACA41
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:15:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2129.outbound.protection.outlook.com [40.107.244.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A811996
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPkNyXXDtbRUP+oY/Vnz5rd3yzwUFcZQh3SIOObNj6hXWr5nmByOquisRTe9b33HNUXxiuhF+dYJkS2k/2qM978bBlpY1ZXJUvgM2hFCRTebcHEnJ6AO9oBoxSWSKLlnltGNXp4z0vB2/jjGWAjEQg0tuekKWujlOBqJPB+R6z3MFwI+zJEhv5UoaT6McM7c/1OrfCIBfUyQiSfqSdxjFVFByTqrd4DU/65MdMJ1vlZo9QQWJa96NsCp1xaF6jpvFx+iWT0uSqtbDheM94vWEfX0OAK3Jks8LINv6BkughLtnbqA/GO3O3OTELd+vxJCIS2CL3apVt9ka7qgfVSprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b4UyllMg6WZjW863xgxcu/Kex3a9sfuwNzio01D57w=;
 b=SNhJk7xXeu2MLs39RFiCjZ5QnULXPhgzUqqLyVd3rxXpQ0azlB7bkY0sXwMwxRJ7KkMC8G/OI4AX0Xfk84UxcediYCPWo5V0XZkA0mWvzdzZYPiGBOUR+v6cY5CcajS//26+fQu4+sTNXKiiR7Ols+nWgDOY+ODQqbZQHXO/+PcsqExDcxmVBrmdrDR6tOTTxB7qLN/77SQNQP1ME7M+iRYr3tQ3ydn/fPGejJjqryF1nXUlriISC9eao95MqdwrmOPqitnXeNkv4dQwgWW+jGcjWpVzbIbOAhBIP49m2a2FKJcDy1EyZQxppGVk/dFP3tVBMm/78n69zFT14DnPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b4UyllMg6WZjW863xgxcu/Kex3a9sfuwNzio01D57w=;
 b=u17TVb6VZGsUp1kTPTfk6dNnRwrxwptFNfZ3Wdhnez6rNp3KnpO4P3xmJ6OqOH3BhbT+UJEcPC4s9CX/yMX8g4zMywxJQOpHpd3JOyd1zNDOCXDFz3G0WRVoccWSEzbhJmBTV2l/TyMMio+u80mZtCGwm49YkzN/m3nFnyM0OTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5710.namprd13.prod.outlook.com (2603:10b6:806:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 12:15:39 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 12:15:38 +0000
Date: Wed, 26 Jul 2023 14:15:32 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, Jose.Abreu@synopsys.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 6/7] net: txgbe: support copper NIC with
 external PHY
Message-ID: <ZMEOZP++xAnpKjEz@corigine.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-7-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724102341.10401-7-jiawenwu@trustnetic.com>
X-ClientProxiedBy: AM9P192CA0023.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::28) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 042f54b6-e530-42cf-9c56-08db8dd20604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9WoSwXNvZmsn60hEN2TfgSTqRYDfvunnBZZeZnGvDe+ZvqE3dC1g69LrEtomMzom57Iv+Nj1MnqBq5a5xDYpHXznt3P0al/HD3fye/7spf0e39M8iUunIJj8ioqqLmzammZxzKmjDqf7CnTXFFNr3yFVM6srk5d7OubNrfHETFDnn0piVVIuBcGLtffnn/j0cWcMqc5VtyRw2/ncc/qmtLHsIS6aPnoejaA4qetVZwZQpUo2QXq87X5GeSVpgnU6xuGG1NqlfVaOjzuELqoSMHxRA752ZvIMbghKKxA4iUhOOfleEnSdS2OpIvohlYeqV4YpFLVx4+PRcsFzrhGeBy8XAiZZ3ZpgXnZl05dgC+0cZ2YRKPV2HLqRnj/jdeD5ybO5WFD578IbijLHeZT0d/5ufykdnkflG//As/EHGXN8uvP30okRruVc+9C1bMUAJ6LQNDNjmCl3QDoQHWHF4s58/D3vZ9VOb1O7xUU7BsAiU5K+Nmxji+bZXDCrpwAryQXBYZ0ZWo9M7U4La/f4ojvn61SsLjV3/jZNaAd9rQ2KNk/bX1UnLf5O7wh+hbm2m+rqvf14CxECZ+1+1eacI07R7ZvGbbKKN5NSLZQjE7w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(136003)(376002)(366004)(396003)(451199021)(4744005)(8676002)(8936002)(44832011)(5660300002)(2906002)(38100700002)(478600001)(2616005)(36756003)(6666004)(6486002)(6506007)(6512007)(186003)(316002)(86362001)(41300700001)(66946007)(4326008)(66556008)(66476007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nk0WACJOcApqCO4Z9I2+xEKwHpwDSHcvOcNqRd7V7jaMfnNR65REJqQYc2pe?=
 =?us-ascii?Q?yC7en7wWZso+nimRtJicHn5YRQLAgwgCadkRBqR5CdvimTZYvtORwZGOp6rC?=
 =?us-ascii?Q?DsNpWLFeffRzr/jfU/hDdefOghelGwr3NAZdZkWzkqHm9OPWdbMOa1nt/l7/?=
 =?us-ascii?Q?pK8CUdVDOl0htiVZ4j3ZJ0Sb3FI+2LkRfzfjlP3NHN4wghuWZjpD8grz0iQS?=
 =?us-ascii?Q?/zilaFzL0FHKr84rwiG0l9BcqAIVpWJ+LWg0g8dZszAXLYAE398TMZRTS+5S?=
 =?us-ascii?Q?xLqusF4lYpUow6rzJ4PIlnmwbiaUCdaDnt3XIlk91Ej8rdF0e0GfTilE/Sq6?=
 =?us-ascii?Q?gT5amlmYeECRSwTJGvdVbhckjNROhtrbzhIIcZmB1Sb7AHax7SRYpchGjOJs?=
 =?us-ascii?Q?A4/bRxfIApBa7UP2C2CBKfbHeAVgJkM8YHDr40M01hlVMOWEGLAjA3SLnl44?=
 =?us-ascii?Q?lJXTgxZCSWyR5E7sVW1V6q50r+pqJUossn4vShDGRZguEtg2wJpCPdhB0fFf?=
 =?us-ascii?Q?lb+E0krz/CPUBz8Dk7TLeHFCmwEpejBWVgnjnJ6je6bgZQ/IgvdznxUhSZwN?=
 =?us-ascii?Q?ZR2iLONOapnjduRG4p5uGrBAM1wMgYjWDlV0wMEIKCtVfNrcEYfmjBxtnqXJ?=
 =?us-ascii?Q?XwGL8fRfw1/9ST/68SNOXJ75KfoQvHfxksm3ARIjMG+fFd4KeqgUJ4rfIzj0?=
 =?us-ascii?Q?Ydns0WxXgLa7vQTKzhCMQmewIBhMZFFQ5zVmiVX5WdV6lepSgrro/btunW65?=
 =?us-ascii?Q?b6vaP+pU5tTGWrVNqzI9tvFKwfqTXpo58odQJ7fJs1OieamSAgEgosIjHn0s?=
 =?us-ascii?Q?B25z0d14PKycrvO2NyKEls6RpVdpOnMf8jGT9ZWmMhT3BjW7tNKTMoYSe51j?=
 =?us-ascii?Q?Dqft99UNedir+f9SKCDjkSuXusXg9kpS5kIGXigtjD9wje8/b5nKhYi+qrlt?=
 =?us-ascii?Q?Ua+GUl9/K3KfUcWKHsXuyhtZ3rWN5LD6cjf1kotvT/Z3PMJD+T9T06i2XfI7?=
 =?us-ascii?Q?18nCwoZeT0Mn2bHZkvZKApZZSS0+uhMaTUuLjvNdBDEW8g2k92+Enb+7Lu4Q?=
 =?us-ascii?Q?QrE+RYsAQ34pKAsPd0yolrgQPQdudtYUo72Wlk5LcowktFq2C4cL3QGBYYGX?=
 =?us-ascii?Q?BhXQd4+2zKxxM0YiL0htyi11D3KyYatAS4NJ5nk9mFBoc2lZdECG/05PxUt9?=
 =?us-ascii?Q?fb5MQRoLP9OPRvbKMCLMFVnSwTkNAc4wzBTBM2x1ry0vHByUfTvg27SN/w7n?=
 =?us-ascii?Q?Jim1aILG0xZbHgkr5QRiMO3T36pZbEQDPPRMPmFJVlnPnBsi4oarDkqn4D6K?=
 =?us-ascii?Q?PKQ3RTfO4trh/SO6Ve7pt97lSn2KPiEaYQfUpd+unjq3TNEUhsD5cQQjL6eR?=
 =?us-ascii?Q?FSkTc/1XnjZhNPSjBCzQolJJarl/cUAT/1UvN9jo78koMcXYmWTdxHfJU5yY?=
 =?us-ascii?Q?sa1/CurZAmiWEaMCiSjh8djXdnEDuKxjF+rmJZhaHN929q0+NWCBqmFf+lfc?=
 =?us-ascii?Q?lGu2uixxznRvlfRv7SK8KOu9H4fk2HY2qwCGGeiG/jOiDbLSxRF9zyDd6tff?=
 =?us-ascii?Q?63knlmxOaYVPy3PSHS4jXLPnh8OSQfoVV3RIUY/KYY77gHnNHe2rJK5sJRJ1?=
 =?us-ascii?Q?xPF06/2lyRs1KQGHZrq9HpzdpTHgOTHCWAXmvFXGYqP5jx2cS4Vz8lCqKOr7?=
 =?us-ascii?Q?uHG+IA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042f54b6-e530-42cf-9c56-08db8dd20604
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:15:38.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5TmQD8m41GWVWX8V5nqAaMu58XnZCe2aIXg6RxUfvN5YuOyGpg/1D1YY0G8antsQZF/U52aRYGQV0BxjS5QhFEJRJ6FwzZifZxsnz0uGUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5710
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 06:23:40PM +0800, Jiawen Wu wrote:

...

Hi Jiawen Wu,

a minor nit from my side.

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c

...

> +
> +	/* remove unsupport link mode */

nit: unsupport -> unsupported

> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);

...

