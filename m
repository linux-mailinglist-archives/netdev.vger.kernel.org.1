Return-Path: <netdev+bounces-262108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADa5M7PLomnz5QQAu9opvQ
	(envelope-from <netdev+bounces-262108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:04:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 205CC1C26EC
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E47B30293ED
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1A42884C;
	Sat, 28 Feb 2026 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gMOUzh0w"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013052.outbound.protection.outlook.com [40.107.162.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94D42B740;
	Sat, 28 Feb 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276589; cv=fail; b=KqH6azxr5dPn81xBpC3gIc6AaZSxJ16TsDSb57S2j6EbOb8h/E4GVfEANFuJBUjk/yG9qMQbOo5QCO+5myj5Q3GjyoroEISuu9ldRMJsUNeZ1A6ax//0dmTrFoeDY+XMdeaUaElgo3GzU5ewY/xWwwPsFQJQjqs6mMmIqxyiE/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276589; c=relaxed/simple;
	bh=kK7OiEQpQFWqRKNPlO0s5M/a/rUen1TVW2x3cj5b2hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GQh2tdEBBEN1uTYLcWmO2m/n6enjUu+k3Ccj+OBtv2UNquuGnD9xR4spXSIFg3PGRsBHHFYMJulPny74vtkwNPa+nhFtxoafffg73hmCUihaA6fJc3lmU0IthzHsaOgom2yQDZAGLy1KYH/jrnuruhuuD2+/puy2+c/hQubLYyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gMOUzh0w; arc=fail smtp.client-ip=40.107.162.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpBZXl2wCEyNJQ8IMnDpJKPSA1CYavx2LJblm9HUXrs9YDKJooRP74+BKBPLCfGegc+irxYL4tnm6aib3IhCPFlAJLb1Ap06gIycN609dGkB1j1tiQlQM67CVXdR8u+aq1ufkhsBEnrLGWpXuQQJfCfx70lvIb3krCYAPqlJDR8ef5YGk9sFFNKbxq3rV0j136KSo8sOPdZCYY++LzFPenI2727EaBitF87CHxEYS2cAYp58ohEiTI3hihcnnAG+ozKjqvitXZp+xSwFdN3XnI2smxRontGiLYEyN+s5vUTcGXDrMsl+mTFMcnM4ngiIsZ63wbd6/QIZFHkmGKHc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHuIfO4iBzwwv4UTH3mr2IP+xFrE++PpzjOZSRAq0zM=;
 b=Xhi36IsK1YQQU4JIyMNGnnZhvj+b62uD9TYYSHBFulDlmkUAUfydW5gZ6J5GokeCQlOxRm4wgLtW9+Uj85LQYoBMctAAes8UytYiEV3UOH4+moJrzTLYxn51ViCFLw3ioesY8KJVgygX0Z97Ydecn1vVYdCjTH5dyNAgwd+ecgHOaHVkSTF4JuurAI0uD93I63FMHcERdhxONOGJi3eN2BM20q+Qk7ZQfTLG5bbOq+ZJ7sXvjpwZMztEl/tpVuo/IGxluN2+9P6H/GitWKhChM6n6r6X4RnSLZSrdq2xqBavHMukRa01aR8Oguh7+fm44CUGNiTJHe0rDpx5KYDggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHuIfO4iBzwwv4UTH3mr2IP+xFrE++PpzjOZSRAq0zM=;
 b=gMOUzh0wimBjyZLjMNAg2JzmVmOZvqxpl48uoyfCLTjBa10H8fsXFtWT394PIxKzZoJLJaU3EqeFzEdnSpZRrHjAYTsgoobBfNw0bVh9ZZcRbmy4gLXGt4YFBNgOhxzKGsTNJOiSLDfHPVqdzdhEm3Ct8jiV0VuXyYazQmyItXFljQdDjIA1UHH/Ldg1fuLvfqnMFSBkhyn1cU5YApOZsDcLvUUP3Gp3pMkYRIMyealA94WzI0OA71NBUcipTYHLcQi8zqe1SlSc7CqiMA3j+UISfWdxOc5FI9SJje+D0+GuNL2ci+qjs5Kb5VsOYYC/eDZOlscVBc50pPI05JOG+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB8149.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 11:03:01 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 11:03:01 +0000
Date: Sat, 28 Feb 2026 13:02:57 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ivan Galkin <ivan.galkin@axis.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [net-next,PATCH v3 3/3] net: phy: realtek: Add property to
 enable SSC
Message-ID: <20260228110257.bowskqkl3ujv3ri6@skbuf>
References: <20251218173718.12878-1-marek.vasut@mailbox.org>
 <20251218173718.12878-3-marek.vasut@mailbox.org>
 <a37be87a-e1aa-443a-9005-da62e4f51d63@mailbox.org>
 <d6c83860-85ba-4a99-b2ab-486ad040ea55@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6c83860-85ba-4a99-b2ab-486ad040ea55@mailbox.org>
X-ClientProxiedBy: VI1PR0102CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d7e811-5078-4aab-1256-08de76b8f018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|19092799006|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	lSEhj79q9WD7kaLgTZgsSokpzHFqOVbgTg9+Es0WKhUOERqf70EhxqQXGtZoosb52GR//ikdJKz5C1/Nqp/Kq9DDkv0uSO67RCt9/UZByDZzoLnoolMvrdCK9RatqOotnx1tUNTy3S++Gv4bSCWxjdsEFP87Aq2ne+ZqSeJ9n/RkSilidqizTmchQtPnayUNEayYbaG+xJNO+tf2fG2EJyEniAp0v24K2YLBlPvV1aDVFvq4+IDR1uki7gk1TPjpVtEyHix1cjpPlm9JMv9fkanK0c/gpP6ceafqXhsYv93G1gE/foxsFxv8LGHT+04o/JhWk0TqTdBIoRBUrfg4shzmyh0UMyPR4FtLF3Ra461aU0cf4eiSt7a9W5NG4uE9HBOlcY7Sr21WXPy6IagKfHZqtnB9UXLyksaMSq3+4ywBkoS6rK6wrAf6T9HMe1x4yw3MLiit14QNDK90ErZPXA/WkAkEAch282YNQ4/588h7UkabsDvA6J6M7J0qnRKHD2mWMZ3CMP0urrOQsxGfI8w1Kdhnvf/pPsMp2C761WpBDSmnkvJebDEixAiJ2WFcA0jHzDnbIRnhgiYF6QUx4sX8v1g2LR+xGHktVU5fvKxW1y2qV9lljUX7Tquzh39l+/OH4XnU9e0WH+UuxpWpT6QsSa/4s/yqp8nHlRHfxHcDFwcrj8WbPwBYNlcSveRD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(19092799006)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJahRmVJALv5xbvIU1CQsItT3IYZ3+NGU8Qm78P38ZzbdfJ0o+YcGuktJG/+?=
 =?us-ascii?Q?PPX2cYSDm6FCFK7cj8H1jNtbXZTCft4xAMfVOd2yC2zJn4mBj2JL4xZ/9wJ4?=
 =?us-ascii?Q?oYeMoZ4Szb5NEwVmF67EP5yRef9lHMy7ZvRIMOFJfcS2vmOw6NRI04RDi+L5?=
 =?us-ascii?Q?RyEEilchpvH8efwm/t5bhxef+Xntt13KmGwJ50UwXCYlL21ZNpZsYuXNZNnG?=
 =?us-ascii?Q?WZW7480v3tp0taSVB4x7yKIHA9n52Ounswkng7ILWIp54gsY44YKQkejW/l2?=
 =?us-ascii?Q?OTvlmA69ijEy//u4NgaUfJ45GRRsywPjtKEgLTf2JaucXjCCiQ41QSn4IZ+z?=
 =?us-ascii?Q?VcDvEyNJgrwdDbyZQ1DFwhtJih3ZqFukPKrf+RRdubRUk625LdR4UHyOHP7c?=
 =?us-ascii?Q?p4ZUFER/AirvOG5yTk9kIBLswHdScTeCpGgqFFylmSMK+eeY7gqN0Mt215If?=
 =?us-ascii?Q?ohyeh0MM1JSGdk4YlZXk3sAaloztKoYAuputUItIHw6fInugNsjY+LBPrcuQ?=
 =?us-ascii?Q?uICDjQ52cI0QVFC1V/puEaE8Co2ZWjx67bCH36I47idb4w/UT3XrhobtkSBo?=
 =?us-ascii?Q?kd2ETMEyc7sZ2RGGu5i1OV2mewS/f5F5W+UAB6lfAgvi2E9/zcPMRRw/hHzs?=
 =?us-ascii?Q?NfL4l1lmtKf52K4lqnSbjj1ZOYcQtXFiXL/q12y59bVIhNvfSn1oW9zPA7Mr?=
 =?us-ascii?Q?mz4oH47wBpLc8UglNytnr+FOlMJscFMzxiob5lERaq7rplUXHRxf/I1Y11ce?=
 =?us-ascii?Q?6TovX1tiHjcEH02aD7Tql1s4Qfvf8oNSwNxobGDloH+HZsik9ODH77dj07e8?=
 =?us-ascii?Q?mGd74dsoGQD4HKnLh60qzItRkZ6CgO1CLSu1ncem9+F17dxRSOlJKOvF2rVb?=
 =?us-ascii?Q?3QtARq+9LKls6M0mccc183Vae9eFGdNfYUjVCCxPBq7WOPHsPllPj7U1qteD?=
 =?us-ascii?Q?u67IsR5FcBuDvYiDmIsg4Aj/Pn4DdTTqS/m3OEbqmnFrM9rU91/D+9y7ddKp?=
 =?us-ascii?Q?N/a0HTWGnIUwDMbJqSkdcGKJD4Ahka5H7REqoM85riPe8rpYRlDYsf31VSiI?=
 =?us-ascii?Q?IMB+F5LnH1xRiGQH8OUdL9BRCLLYIY0rsRvKI15QCvM2/kiNwt1ZtMYqZYWn?=
 =?us-ascii?Q?VqGlwjYayAeVFE0+/BM/G6kCl60lZ8Zp/kNK0z+o3GIH8yx9XHXl9EMPAMuL?=
 =?us-ascii?Q?5fyvjnYm9LG7pDFa2PoT6F0QnjPyy9i+stZ+3qCVK/qtiA122JjFGnsLHMkg?=
 =?us-ascii?Q?kfAODr/C3QD/OTUNunWuQoRzEPlxInf4VmlBLhVMb9mMg6wOWHUWHb++RfhD?=
 =?us-ascii?Q?hkSQdYKzDojaPpOkp76+YvU86Sh4OpvakqWAHC/z5ZDMz55JrI2HJHPXeLr5?=
 =?us-ascii?Q?SbGEvxw9Q+jdKWSqVZo76xyN1kdGmOP7YnXlfkbr3d6J6qLFtvVyWaxkA043?=
 =?us-ascii?Q?eTpUuW7EtjkJD40Z2OdnakSS9UAEP3Wz/8/BgQPLYM65I4ZPfNfsXNBWoIxl?=
 =?us-ascii?Q?pY6y4H7/hyRIgTPo0tyP+D8eGfbh0P9FebowzAnzvDg/pipyz6nRP3MJrnae?=
 =?us-ascii?Q?k3VNLgaaFjQQmAUepICw3AMVNDEHdk8zfIrrPkKBuJe4M7/qRLeI/c7yuH9j?=
 =?us-ascii?Q?nWR6Aah7ADkYoYKJtu7BRWdewR3/qgNYW7/CBzG6IU26/sckLGfsJxI/5+yP?=
 =?us-ascii?Q?xR5/GqCzsm9ynlH+/Z6IEDGgR3e+DKnVTIsQEhbf9BDHmaB3IVt28h/UXKYh?=
 =?us-ascii?Q?WWZ+liJc35Pq+esyxwwWkxiLVG14KIgis0gEHqCToDOARcUHz0ZEQkppcXz8?=
X-MS-Exchange-AntiSpam-MessageData-1: rsLO0Unz0eI8JFzIxdJKGnf+4SDHNmwJXj0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d7e811-5078-4aab-1256-08de76b8f018
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 11:03:01.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHk1DJpZEFxkKktzbZDvKFafU5qnifbdNPG9pBHm7uR5R9X0OqAf1ojrUECn7/bYsf5MuyRxqgsWQMVf2nGsoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262108-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,wp.pl,lunn.ch,kernel.org,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:email]
X-Rspamd-Queue-Id: 205CC1C26EC
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 04:57:25AM +0100, Marek Vasut wrote:
> On 2/4/26 3:25 PM, Marek Vasut wrote:
> > On 12/18/25 6:36 PM, Marek Vasut wrote:
> > > Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
> > > RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
> > > follows EMI improvement application note Rev. 1.2 for these PHYs.
> > > 
> > > The current implementation enables SSC for both RXC and SYSCLK clock
> > > signals. Introduce DT properties 'realtek,clkout-ssc-enable',
> > > 'realtek,rxc-ssc-enable' and 'realtek,sysclk-ssc-enable' which control
> > > CLKOUT, RXC and SYSCLK SSC spread spectrum clocking enablement on these
> > > signals.
> > > 
> > > Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> > Is there anything that should be adjusted in these patches ?
> 
> How can we proceed here ?

The state in Patchwork is Deferred. You were told that you submitted the
series in the merge window.
https://patchwork.kernel.org/project/netdevbpf/patch/20251218173718.12878-1-marek.vasut@mailbox.org/

It won't be applied as is (needs to be build-tested again on v7.0-rc...),
so please resend.

