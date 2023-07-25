Return-Path: <netdev+bounces-20835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EE4761805
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A448280D6C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA81F927;
	Tue, 25 Jul 2023 12:05:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAE21F922
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:05:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2137.outbound.protection.outlook.com [40.107.92.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D86A3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRLczdCqFJdZXUS+lHuZvo0q0eeYL6rgpJoYpObmrY37/FOlelD+YvzAb46bpZG/VrZ07zxKvEH7sKmDmrDZNbK5dbc5MmG/63nmCd9/KkbsjyPmscJCX7knvLyLV4zaaaB/CUb5kc2tKriXfcdslRhn54osonVBr05tAZsPuW8sqqRX/H4HkCyYPVepVLfx09CcwZRThpNvnSBZ8GmhxLV0q/0XWoLnnyN75BrEC9fFTAiZFA0Xkzo8TBxNXUGcT9VGIGz33eLkIXoQy0G3qasgAwLMDpQeZlENSlrMQpAmAx4W4duF382twuXfZya73LhkAh+aa9KVri74JlFnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4um2UiA0eBQyQgVrg1w1KeD81R/mOyhPxfklJJ6haJM=;
 b=Q92cMCwR+bQIqGlZH0ugyUDcP4w9RIFulBezc96JCA8CVEGN6Fha0X0VOMter+J4FuQxS4W3b+ihTqou5zWuL+k3qTF4zxATe9NUyXMZ+GsfdfKCc1i7pRdVTb9qsfS3o4roo7gUT5NfnEFSy79o4m49vEHPPLgLum8Qg3IgZIIYFOKLgejlDxk5UdcdMGqSn3LDykkOLzFw6+F+IUwxKTyYwHmT4E14BgjO3qzXBFnJwMFDf0cLJwV9r89/mv+LNCKnndXoY+TDSJO/B9M2ZhZgwg9ZSMiS454i3HFlB0Ufq2wXtq7zpG1FYPdFv6vMbx5A6Xi9UyfzuCkhwQ27KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4um2UiA0eBQyQgVrg1w1KeD81R/mOyhPxfklJJ6haJM=;
 b=T6bDneKiBHw4q7bbQN1S4QU/zTx8D365zElZvMcI6BQ+eiAeAxeh1yTJm0XVSElccshw3PLIPoGob1YJotU6HeOUYOIr3unBCtbnHWQd2Zp6IUMD9OFEzZSPZCf35TwfB7nzl+WWIwihe2g6goaNPEwNnqgyoH6LU7e8cVJSS80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW5PR13MB5971.namprd13.prod.outlook.com (2603:10b6:303:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 12:05:42 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 12:05:42 +0000
Date: Tue, 25 Jul 2023 14:05:36 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 2/2] net: phy: add keep_data_connection to
 struct phydev
Message-ID: <ZL+6kMqETdYL7QNF@corigine.com>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
 <20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
X-ClientProxiedBy: AM0PR03CA0093.eurprd03.prod.outlook.com
 (2603:10a6:208:69::34) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW5PR13MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ed6279-6e73-4318-7473-08db8d0777e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zhb8TsHmhUK0QtcLnHxh11RTEnbpwNmTHoY24F1T74QTJWnvoKd6WBJDc6NK1W/y95ZmQXrHLkt/1855lvByPj4UYW0xG3uYBmmwdefFS2dvnPhxONJrcL7FcQ5jDQeaA7DRp82zm5KdRiEE2n2Wk2Ad9vIDxugZ3jtstPjP2/+rPxpfuaEyIOIwtGOi9i9wVSFgEsg8PNU9/pwlLqfkEJpJj03J7S39oMXtc3yx1H7Wk4bUU0Yei0FlIxuT9SPwb+nl6eRFJYt+bHpr6sf2g8/olHd3m7Dtzr4DX0BIbxkvivcJrDQNrpkD81G1ZVIdPhQ6QiPM4C/5dbkEyoRJxZv/ng2sxJW5UU2JrksZ7wU93G+CHAKgsPm2xh1UhUOh3imm261etl9Dh/Iw/flDg8FHBWU+n+2ExyFswV8nmoOmmeJWOaggF9Y11Bukt7g656PdTVHrCYsTg+y0sMDnlQhVc17eKtMGKVYF5BYTk5iGaVS6fihSInsXljEqMRiFIRvTDArJImH+Xqpsv4Jrx9MGhxMbo7+mk54hxRXcj+lFlWgc2AWvJEnlUZKOuBPCWi2xVMzX+apru2NVcpFxEkykDkQldwjaIpXObBk8gWD9rNZrNSfW9XULkYrxAvzfq97x5XYbopD7IPmCZbDbdGVFogByCDUH/fuemds48J8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(136003)(396003)(346002)(366004)(376002)(451199021)(6486002)(86362001)(38100700002)(478600001)(6666004)(66476007)(66556008)(66946007)(54906003)(4326008)(6916009)(316002)(6512007)(41300700001)(36756003)(83380400001)(2906002)(2616005)(8676002)(8936002)(186003)(44832011)(6506007)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FgLj7dt7rZaRidTF4OV+ZmjOxPYBUtoE3baM16APzpADcAuh7M4xzkRVoWfc?=
 =?us-ascii?Q?Sw9bdIA7PbUzCL2lx/0/4nH92H2KsJQ1Mj7MUwl+tu3fBzOFrFfm1q6aYRtX?=
 =?us-ascii?Q?9BQKNpXy2cP/k+7rA5AgyLp8vMFfXrg/KiFtQmuCeXKatSPUM/l4KIF7sO5w?=
 =?us-ascii?Q?zh5UVbP4I/Gn3lghx4q2ggJhsgmebW0372A7p+kLVMq38/u/RT4cfiWQn4oE?=
 =?us-ascii?Q?6L0ONSI/uRgp2JyLW1fSibbFBEbKm+0LFK55uoA7FFsafXSKiw4+r3NdSWuc?=
 =?us-ascii?Q?fY8N+LrIR152o78m2FkvM7mPNKApJ1mBWdJTHczJU99EXOGtQkUA0UfKs8fi?=
 =?us-ascii?Q?G51WxW08r+bV3anf5Ld75S1pbZyBIhuqODq/5LiaoByrmQknHGzKwF4RAfjO?=
 =?us-ascii?Q?Dmo5nIkRCF1b/ZB3n8VN7chGONlvt7ygyeISczYQt3BIjTa3GWdylDQYm2Us?=
 =?us-ascii?Q?KE2Qi3BgZrJZJfx7tXMgJb0LplAbo2pCkqMkustbBokOguZ3QMvtCsiUv/TZ?=
 =?us-ascii?Q?7spRaggRlmFEbegPHiWzh28L1kMTwIpDSxSyqmGv7ZM8KxXWxF84q47OcFEN?=
 =?us-ascii?Q?BHNPh86FCmX3sWyHeU72x8ewaHWp4ooHR0qCcLsMwiOsP6bUVEI179iD6Vrq?=
 =?us-ascii?Q?RvVRfqR3UCN3aB8r7HyJE32gNQpq2gqpiPMfDDU5gPm2q0v6U4nFcP77B7LZ?=
 =?us-ascii?Q?1d2vex8bDOqckzK90TLornyetRvO1vIaJEk+6aKwopxt/gPopyxsOwIU6Jcp?=
 =?us-ascii?Q?gSrTQMagGreunDY1UPfdkHfaZfVNQP2onpeVijvc/yrPxtaPuHY2pt/ftOZb?=
 =?us-ascii?Q?G1S+iJpYqT9kAWd9tkMHSp8CzZIZS7SWVGqSuBQlKEk67UkyY1khAFgF3dVU?=
 =?us-ascii?Q?GQlENZTit39BWJZ2DM20/yqdiwOpkNJw9zBXa60AvUHlpnwJl3XaL7Eohdl1?=
 =?us-ascii?Q?zaoz/+rjzNvwsXxCMrmUm/DeFXnbfxX14fItEG61x0tyRbyzcIYreeAOsIWB?=
 =?us-ascii?Q?CPbN3iTA6nznfZrUFEuKnf5CBSBkHiqkUIoUn1VcubjiCqdBavGDkgBvxKEh?=
 =?us-ascii?Q?xTBWQdKeM7xfSXTj1laAzUKbJLaLFGqZkg7DuB1/P9vgLuOfQ4wMtFzm43xt?=
 =?us-ascii?Q?EP9Qq4cndNDzTcZ+GjteAjGEXsklL5kifIRICtuAr6llZH87q/lsBfNDZeEY?=
 =?us-ascii?Q?mCHCS0zNxfxcIwwveVnQeuL+Mr2oNQATEWpAtbKbbDqjM5miaBBBdnqLPzor?=
 =?us-ascii?Q?pVfgCM+MY8gq8kAv3oknQEMXf1E3ghLv1iXvHZl0U7yNpC8SQUt9imzxdKs5?=
 =?us-ascii?Q?GrzuYNRnrMw/BljcjcORG8xYQfpUu2bGp0lFHxCtNWBHGevgA/wlq0QfEIdt?=
 =?us-ascii?Q?fBukrmT4uTbw1klXKtapWOqN0d8B7p+U+gaqui9bXVvsU1Zc31F7UIfgzW29?=
 =?us-ascii?Q?erzVRF7M7ndZOPLNqUI69VK6PHjcUq/W2p2QV3BxjI1rhrgrgEfZt8t2dGVR?=
 =?us-ascii?Q?6y038OG3Bm8BRA4Kr7E98ELp+uPHfctS0o6DuMtT8jaiG7SUk/7ZCxBJZy0V?=
 =?us-ascii?Q?EvLwnWIkOXwB2My5UCnC+f299aq8+r9tSHj/jJMDdpWBf4UeJE4ONGrDrZHI?=
 =?us-ascii?Q?78DLJFhuCgE1MyaAzX9UqrupJGU7krjYJ685cedquuTfkOMIr/yP1whwnsyO?=
 =?us-ascii?Q?ZYv2/A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ed6279-6e73-4318-7473-08db8d0777e2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 12:05:41.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIq1+SCKgegSBgWuBi7fC+sDzRc1yN3VRmrODBijR37MB8S63089Lj3fgE2/6oYhbWf2O4jtZ/psHYS0lsy7vQIqd3IXsPWadf/8S7xNlk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5971
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+ Jakub Kicinski, "Russell King (Oracle)", "David S. Miller", Paolo Abeni,
  Eric Dumazet, Heiner Kallweit, Andrew Lunn

On Mon, Jul 24, 2023 at 05:24:59PM +0800, Mengyuan Lou wrote:
> Add flag keep_data_connection to struct phydev indicating whether
> phy need to keep data connection.
> Phy_suspend() will use it to decide whether PHY can be suspended
> or not.

This feels like a bug fix.
What is the behaviour of the system without this change?

> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/phy/phy_device.c | 6 ++++--
>  include/linux/phy.h          | 3 +++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 0c2014accba7..4fe26660458e 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1860,8 +1860,10 @@ int phy_suspend(struct phy_device *phydev)
>  
>  	phy_ethtool_get_wol(phydev, &wol);
>  	phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
> -	/* If the device has WOL enabled, we cannot suspend the PHY */
> -	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
> +	phydev->keep_data_connection = phydev->wol_enabled ||
> +				       (netdev && netdev->ncsi_enabled);
> +	/* We cannot suspend the PHY, when phy and mac need to receive packets. */
> +	if (phydev->keep_data_connection && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))

As it stands, it seems that keep_data_connection is only used in this
function. Could it be a local variable rather than field of struct
phy_device.

That said, I think Russell and Andrew will likely have a deeper insight here.

>  		return -EBUSY;
>  
>  	if (!phydrv || !phydrv->suspend)
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 11c1e91563d4..bda646e7cc23 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -554,6 +554,8 @@ struct macsec_ops;
>   * @mac_managed_pm: Set true if MAC driver takes of suspending/resuming PHY
>   * @wol_enabled: Set to true if the PHY or the attached MAC have Wake-on-LAN
>   * 		 enabled.
> + * @keep_data_connection: Set to true if the PHY or the attached MAC need
> + *                        physical connection to receive packets.
>   * @state: State of the PHY for management purposes
>   * @dev_flags: Device-specific flags used by the PHY driver.
>   *
> @@ -651,6 +653,7 @@ struct phy_device {
>  	unsigned is_on_sfp_module:1;
>  	unsigned mac_managed_pm:1;
>  	unsigned wol_enabled:1;
> +	unsigned keep_data_connection:1;
>  
>  	unsigned autoneg:1;
>  	/* The most recently read link state */
> -- 
> 2.41.0
> 
> 

