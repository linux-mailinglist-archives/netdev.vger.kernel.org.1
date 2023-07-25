Return-Path: <netdev+bounces-20836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E3D76180F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5F41C20E61
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B86F1F168;
	Tue, 25 Jul 2023 12:13:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECC08F4F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:13:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0199EE47
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYuhPv9sb+kVxgKm+m1ajwNDV3nZnItAYEkTKHt5CHMAQREzNzUGI93lJCgiB0E7yy1TH438DUpMUCdUGqfa6orX0t0Chh/XuRR0OWICgrhZqtwQmVmJCAmgKGPx6mh9ksYgTR/zTBLeS/n8B0w6fTWk9vvGsmxc4QCCFT8xqLxHP6uuy9bQfUmDCRsnSszFdRcxl3Ly+rEf1wU2JWTzkmbqukh4zOsaGHwvmkLN/9yi6/cW3wFZawaI8aWbYMk4REryU/z9f3sBROVW1bSMVCJV3pZ9aO15nsC17SFYr+ZAi7pt9Hqw/7Tc2vOZlJob60bNWb0ATFGnWudEsnjjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwC+niVCRI8oNmcmdtceQVJV5gYbGoMnKgd11yRgJkQ=;
 b=nAV3wbyTb3ieybIkFiAMexBtU8DhpmcWJZ2bR5nGUMSmcJsbuauKBj0dAiqdDSlQ2f9/N7D3ib/Gd2zsoyoRfojzV64ZNsUv7DeL7Eqj6XXGQTdqBwN2PGpbpF2YK5H+YN06Ldw/6r9uIhyi0ja0bxo+LI3DtNPPaixjgYJVFzOvD4PTnaEH8+pJ6tkGRj2QQnXZ6Ef3afdD54lf3irpBsQhTIE8CrE1l6wmMFYwLnx5CB/KLR2q6RXw4mcOWrR3oeEIslXXzFiitctMRZ5q75LrVjHZ6EiEnS3/272L/T6E+v7B0R7p2fzniaSYuMV4d75JY2H1GAJZboB/BoeRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwC+niVCRI8oNmcmdtceQVJV5gYbGoMnKgd11yRgJkQ=;
 b=VRgZrrPELLV7EwOoYk6086JkyLWbpr9sPqyb7BjgcZbeW78jhUQffSuTDwSy0W3w5LvwQDgccyGqBXu6hOM0H0L8TJhKbVZrIv/mvj4nv7BnpJIk1179kNQXpQAy8SHrm8LFQqvKAd205Es3c2PJ0hS/2lSxZ3vHS9wpGC/P4uY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by LV3PR13MB6405.namprd13.prod.outlook.com (2603:10b6:408:19f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 12:13:46 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 12:13:46 +0000
Date: Tue, 25 Jul 2023 14:13:41 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH net-next 1/2] net: ngbe: add ncsi_enable flag for wangxun
 nics
Message-ID: <ZL+8dXjEmw9gyiBB@corigine.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
X-ClientProxiedBy: AM0PR06CA0107.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::48) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|LV3PR13MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fceeff8-2b2b-494e-3b11-08db8d0898d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5KeJl7DD1uOw1pYYxTDp/wRwBbvbjd01wXrDsxI77qn75+SRAeMZ4KUEatnvwYF57OaonPmeYSW6YOhikqkWkkIAGYU5qI5yMYZUYYEG3NiuzNLA37dYLPLOExY5LWYe9XzUB5UzikFla1bXFKiHTQyolj3a965Hxcj4fwQO36sXMcm2lPLifi187ulyvp7GrFBmwAPMDkC1DrJlOES2d7yha/ACa+En8c+JoM4p00+IX2/AvVjW02xf35SCAKNuqw1r7pj3Gz1AFzbjl/Ra9ajBaBUnAXWADpd4e7KLEKwdnZpHlxpYMAvfPMw+2AwPgmuqvrwdE4FzEVqs1ljJCRfhWylqHTHHWmbMuli/+pC3j0H0GynsEssDqDpZoISV0AqezmqsSJufPKLxLayfymxOTcAY8nRCWlTh1rsx8mrRJkZNgfmsF9NCNMzygAOsY+W7iR7u5Rf+quDDJFAukLU02grcSC7Y0rDA9eqVh7OTKhSINKCFTygs1AyyBpdkOJnAlIclmLGoeWWEVfoWhVN5BSk6Y7allMPIG1zveBtEivIbJMuzi2t6r9AW+WAE//kbhOb8Awp9/X0a942YvWtf9wjZjwKut+pilTPZl56QAcms3s8xKX1JXuNwgUh5QbThi85vgwBGcZIZ1/NsLL6r3nNpO7iRNUY4dYde6sE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(346002)(366004)(376002)(136003)(451199021)(2906002)(2616005)(83380400001)(478600001)(36756003)(8676002)(8936002)(6666004)(54906003)(6486002)(86362001)(316002)(66556008)(41300700001)(66476007)(66946007)(6916009)(6512007)(4326008)(44832011)(186003)(38100700002)(6506007)(5660300002)(7416002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QR7qnkmz3FINODf63MKKmRCRaG3mZo4+4uE5dbMdyZW/kQPfqFa8s5x2psF0?=
 =?us-ascii?Q?steh5DETx9TmXb6g+qJ5mrB1xy3/H8xRvMdRmzravbSchFvkrF6FjSQGfrdu?=
 =?us-ascii?Q?MK1R6evIECBJqOLc0sOVMc+8OjNCLAR4ER2GfwILcLAfVxr1cb1o0Dgq5eke?=
 =?us-ascii?Q?Dv6muGGsEysPzQo1agXIcib/mLlGZLuDXrj6svLtHxznnTmHJ7aFh9PZ38n4?=
 =?us-ascii?Q?u6/q99G7G+fRo2XWfuxJEgKWYxjswo+TcnYARutgSB8pflNfDpyRu8VLQVIf?=
 =?us-ascii?Q?c5LiHsca8wJSoktvcH+qys13PHIUCXkgzvs3xybfA6+b9VE72OKLJzPpx0t7?=
 =?us-ascii?Q?aqXM6Z8eggx63sVu1uxGiZ9MDQcPSgW5f8UV3ORggVv5/VduBcMB7kkRd/gR?=
 =?us-ascii?Q?H6HAUFVg15/KEtzjhlFRIT9dMbWHKg5EnYWBVr6OEINmKHoY1LQc/lB6mWTS?=
 =?us-ascii?Q?Vhssimv9kHajkZjATOQvVi34+lau/I5p0th4uBvtPTya9Y9IB+eDSo4ghxXB?=
 =?us-ascii?Q?7RdLOgovgUP1zpgAS8jjkuZYKJkkD3kjYWOLZjITpt/S0kwv8ccKYVpU3e93?=
 =?us-ascii?Q?83U2kktCCI4uNWiHKpNLFalpZtNdSsl3qE3B1fVGgz3Fr7K3byyeKIFzhuOp?=
 =?us-ascii?Q?NtK71t/gwf0kc7VhN54ohE7VSQJvSImV0SPcQj0CWvkq4wZ7KN3JX698W6CT?=
 =?us-ascii?Q?Oxt5LI07W0lbt6vNjajnl2XzOHSB2qiKrK6EtXtQQhTDDGNkaiBu03oWajdz?=
 =?us-ascii?Q?sph/3YEGoofgwXEZGKOGQNcVz75FeMeysvJklDnIiHZ0br9SRjSIJiLjLRgZ?=
 =?us-ascii?Q?yNa9jR2QFeba5oM+np1PkRw/YEVr+I/oREaNrpyEOWfLXq0QcRjJt27439WK?=
 =?us-ascii?Q?+DxFWsJk7azYdphky/8JP9Nzh+1VKStkHUg7Bqa7t7oSzwyjF9+99QsRM86b?=
 =?us-ascii?Q?ZGEuNTsHHpXE33b3G/nOYyIEHkHMxPp6O14w435wK/wt+h8Do+J/gcfOyrnf?=
 =?us-ascii?Q?p5Dh5LN3gdyvVODUNBWtTAmSyAbv1jw16TfNpsGYnx8a5Ps9KbzzVxLBItTn?=
 =?us-ascii?Q?IRkbtvPXwyHkKWtevvn1G7038zifuc1ecQfrMOt2EG4BzPpDRdJPb6Ase/lB?=
 =?us-ascii?Q?lLp/BnJzvrJH1WO1p0ZOrdClLpDRwc7nlaROW5GKr2XK8VFTWPwPEdCadsBb?=
 =?us-ascii?Q?iqGU33fzjeKN1EXeTlR33VEgt1+gDFDoEiv6UnTqBL4zM5iSChAho0uhz+ik?=
 =?us-ascii?Q?KZMoZ971twUtZqfuHG8E4m/3QsvPrq3YOlMyz8Gt5FlWl0sdfWj66d4xP16A?=
 =?us-ascii?Q?S8EI0bRnEJ/z9DBJaYZm1vPGl67A58x4mqhR/NAee3allllhURC7g6ODtw8X?=
 =?us-ascii?Q?iCuVDR8huEW4+JtZnvU9Dn7nntvMummmUqhnG1NebQAKf0gbGGaMji1mvgFg?=
 =?us-ascii?Q?x9kFMln/GPxR50z+9f58yF2HnqhekDZkpsfBWnPDebos++5oJWa6+TbUdlmC?=
 =?us-ascii?Q?aT7GzE+DrAQjzfpVd4gVZcJWAHjLjqZUb8+Z+OmqttcOLc1Zp7o58GIZW8UQ?=
 =?us-ascii?Q?+OPdBAz8Vu6dnLhThzI9FNo7oM7RqsGIFKtr9+ZIBYwJUiM7ov9pquqlDgqm?=
 =?us-ascii?Q?LfC4N8R3X2zx/PX1+qXzrjYyzZPjcgK6cLcHwDiG0xxGcutRufworUYbEHjd?=
 =?us-ascii?Q?rQZhPA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fceeff8-2b2b-494e-3b11-08db8d0898d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 12:13:46.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZvyxkOPgB2SkZ5EuzksuMU7wFYHCzTM6CQF2bClJjyGU9o3TWIRMC2WMSS9rGaPvek+MzT/l5jvb11VolCBG+0wfoKPq/ALDEjV3MCK1+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6405
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 05:24:59PM +0800, Mengyuan Lou wrote:

+ Jakub Kicinski, "Russell King (Oracle)", "David S. Miller", Paolo Abeni,
  Eric Dumazet, Heiner Kallweit, Andrew Lunn, Jiawen Wu

  Please use ./scripts/get_maintainer.pl --git-min-percent 25 this.patch
  to determine the CC list for Networking patches

> Add ncsi_enabled flag to struct netdev to indicate wangxun
> nics which support NCSI.

This patch adds ncsi_enabled to struct net_device.
Which does raise the question of if other NICs support NCSI,
and if so how they do so without this field.

This patch also renames an existing field in struct wx.
This is not reflected in the patch description.

> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  | 2 +-
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 5 +++--
>  include/linux/netdevice.h                     | 3 +++
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 1de88a33a698..1b932e66044e 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -851,7 +851,7 @@ struct wx {
>  	struct phy_device *phydev;
>  
>  	bool wol_hw_supported;
> -	bool ncsi_enabled;
> +	bool ncsi_hw_supported;
>  	bool gpio_ctrl;
>  	raw_spinlock_t gpio_lock;
>  
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 2b431db6085a..e42e4dd26700 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -63,8 +63,8 @@ static void ngbe_init_type_code(struct wx *wx)
>  		       em_mac_type_mdi;
>  
>  	wx->wol_hw_supported = (wol_mask == NGBE_WOL_SUP) ? 1 : 0;
> -	wx->ncsi_enabled = (ncsi_mask == NGBE_NCSI_MASK ||
> -			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
> +	wx->ncsi_hw_supported = (ncsi_mask == NGBE_NCSI_MASK ||
> +				 type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
>  
>  	switch (type_mask) {
>  	case NGBE_SUBID_LY_YT8521S_SFP:
> @@ -639,6 +639,7 @@ static int ngbe_probe(struct pci_dev *pdev,
>  	netdev->wol_enabled = !!(wx->wol);
>  	wr32(wx, NGBE_PSR_WKUP_CTL, wx->wol);
>  	device_set_wakeup_enable(&pdev->dev, wx->wol);
> +	netdev->ncsi_enabled = wx->ncsi_hw_supported;
>  
>  	/* Save off EEPROM version number and Option Rom version which
>  	 * together make a unique identify for the eeprom
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index b828c7a75be2..dfa14e4c8e95 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2024,6 +2024,8 @@ enum netdev_ml_priv_type {
>   *
>   *	@wol_enabled:	Wake-on-LAN is enabled
>   *
> + *	@ncsi_enabled:	NCSI is enabled.
> + *
>   *	@threaded:	napi threaded mode is enabled
>   *
>   *	@net_notifier_list:	List of per-net netdev notifier block
> @@ -2393,6 +2395,7 @@ struct net_device {
>  	struct lock_class_key	*qdisc_tx_busylock;
>  	bool			proto_down;
>  	unsigned		wol_enabled:1;
> +	unsigned		ncsi_enabled:1;
>  	unsigned		threaded:1;
>  
>  	struct list_head	net_notifier_list;
> -- 
> 2.41.0
> 
> 

