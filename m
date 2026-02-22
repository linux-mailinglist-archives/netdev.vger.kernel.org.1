Return-Path: <netdev+bounces-259881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UXApKI0hm2mStQMAu9opvQ
	(envelope-from <netdev+bounces-259881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 16:32:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C7C16F884
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 16:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADF19300B553
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2E16F288;
	Sun, 22 Feb 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jKr2DQXw"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF2322A
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771774344; cv=fail; b=XgXEL7tbCw2bzAESBzSSdgb7KsJjqHsOqOC+kOT3WxEk8wvyZ6iTFJ5/otq07rKz509da6fXKhNBvFkrESYmjB2JiCdVNYLE0yt1wpddLK8plf4OpIqBexI/jfzAbQeLjH8MYo6DcQ/cxhbUlVYsfxfHXei+mEIp4ECR4jQFNEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771774344; c=relaxed/simple;
	bh=q8exRB0CEUrIIBshgNXmCzc2xSrKWwJSqQFBTQ3rNiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GEmckgL760TVoBk/85/d9o5Xt/dzCcCqAR8VJ51yf09bB3HkQIMlELiWw8VRMRwmJ+YjimNl/boTOobJf83130QDPPcTafJGAb7yH+dp933hqc8TyTvfjQU872gnd3hh8/4g43XxkVJ5dRYdBzNToBYchU46fWcwuwes++vKOsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jKr2DQXw; arc=fail smtp.client-ip=40.93.195.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKHWWTIdkfsf/IuHLeE/Uf9fXhQUh6lkMflbwQY7FH2pnCTXR4xy/GjM1Nc3hUZMaZOrhhLqqqO6PQPGfBEsfSC6BdPMjy3aGor+Y4vsk85Yv1Gl6qrV9mC74mQjFDo9RBDdIkfz5fQF6dEVKxtETwSojfZ7HyQer6gV/4/t9GahlhZ5fF5VeCASFb+8oWXnCPerhl7dUzDF0Hu9itMpaNNwnWWT6QQbWH7w+1D0iBYmxcT0coe743xvP53Ib0Y/mKCvLysSrlxHphiipt7FGnXmNBQDlCkFOlYY0T29AiqMIxNEqluzqH+FNS/wuuGBexG4M+7HKWW3PcqLS6SWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOpbHAevvBbk2BMgMuBhr15W+p88xWBJ42Up6v93MEs=;
 b=bu5K56LcqdSe3RALkwoW/lZ7zUI6392RXL1AvYoCK+K+/n46CFKedac0BuuhADMZBPRNZ1eMXbccblzDOZouG13o1C472tFWEnPUYcXWKZKrpJSWUH21e0oPwZeTPQTdJl7jWEsm7UeWeUx6+At70kyk7j5rUDUbgl87gxfIz5RjABkoe/XKbOQjT8/6TnEkqtCKw8VxfLNbcy/2/OA1vXsNKRS66GnckZtQdoNeAQLtPR7kXuk3IErb2NGfrN5xrx3xxEU36qxX253pNGepk8I9AGdyQkvbaHMYYiSGMSTXoRcSWT2x2OLxeQHnSDU/fY4GDYQKAtEOks+zBqvn8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOpbHAevvBbk2BMgMuBhr15W+p88xWBJ42Up6v93MEs=;
 b=jKr2DQXwDy2LzKZ6jd8TKBzXRNUHV+5iYWCC31NZK/6eSKxsTCjEb8aqoQE1JeQ6eEiR/VRqCJMW/+SVD4P3KZ4cz9dRNlirNt0HyGMnJfPio0gtxbBaNedCrI94/TQcqHofdNlZfcwd6xoXGq1CnxxL/Dihzat7ulyY1E8WjqLZYBLjr1V19TQa9Imd8QLuKZewp8ETeYn6PmB4k6U2lXflaNFyqrhANn7nl/bm4jEQ1klhGAVI8b7A6i9/9/3QSZjYeA4OCn2E6TOxgS0FewqZ8qaFfw/Q2m/aNigNIZSTeD8UGv7ZuWHV2LlKYS3BlN1sC/dL4UiTRFd5aFeyHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Sun, 22 Feb
 2026 15:32:19 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Sun, 22 Feb 2026
 15:32:19 +0000
Date: Sun, 22 Feb 2026 17:32:09 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Network Development <netdev@vger.kernel.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v2] selftests/net: team: add team unregister test
Message-ID: <20260222153209.GA68096@shredder>
References: <4d69abe1-ca8d-4f0b-bcf8-13899b211e57@I-love.SAKURA.ne.jp>
 <aXl_MwhS9AJXTYi4@mini-arch>
 <20260129191243.767e3005@kernel.org>
 <14ed1845-370f-4b28-83e2-d8424db3ab36@I-love.SAKURA.ne.jp>
 <20260222093413.GA30085@shredder>
 <43ab8835-83af-43b5-8317-37fd2b25e1c1@I-love.SAKURA.ne.jp>
 <8ea7a69f-e5cf-4330-b911-7f49d8ff2aa8@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea7a69f-e5cf-4330-b911-7f49d8ff2aa8@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f87cf6-70ed-432f-87a3-08de722790d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U/sGAurZmtIVnw9hPibDQCAv7inMWIev904RBKaMWXeiSxSlA/c55eOBiHQY?=
 =?us-ascii?Q?F+DD5xCcWfTkAAXcRwM/P0IZRUhXfW2I++n+Ob5EnxDhJhtfsFKYIo++cHo6?=
 =?us-ascii?Q?RKQds3IVR8DUbAkEhgb6ZXqmAVku/2yycjYFm64N+aU8wJ/2YG8jrcqU1VEH?=
 =?us-ascii?Q?2/zDYI/GgJix4uhFu0HpdP9yfS4X5Nitz3QBronDj5ahwkyiTWhGx3ukhR3c?=
 =?us-ascii?Q?I/nWjb1hMCyVvgNUWO/R3DFWPeXoeUWZlvdHiKEPQd7ypMmXQcqQ3SaZZ55F?=
 =?us-ascii?Q?NlybARjg4NlnVDuw2vxXEVsrrZQUd+C2Lls5mUYyWjSljMqVGfEpJuzAckiy?=
 =?us-ascii?Q?iwIwuVERoJ8OtfgrhoddQWnnhD6ZKLIisE2QC1nwiqUfqcddeTNiQ22LTHs+?=
 =?us-ascii?Q?RAh8SBFXOSvmT1Oc4KSxZAX9+5IQ8dZmxQsGbOZ0JjezVpOpjtTprxInZmSQ?=
 =?us-ascii?Q?D/hv9iCc3t2wVbCA1Ux/vkzKfr2JdVD6ncHsVKKR92sN7iaRsbdOPq42j6ET?=
 =?us-ascii?Q?Tm6NR+Q3z4AjujVOPshbbDFMfPHY1hSk4u0gLt2XtTiD4FG3h5KIfVRV4Gbf?=
 =?us-ascii?Q?brTPbDk9Qsg1K5Tz7pNAxltMHpj39LQ+ZBSiRIBTlJQnBB0QMzY9bNPgbfx8?=
 =?us-ascii?Q?6q9xWjYIbnGxPWlE+aiqv9SH83yQIfTwZHEXsnIAewk3n+X7E2ztq4SPKZHs?=
 =?us-ascii?Q?idStp/qonQ5dhVo+SlOAj3g/SePu+8sm1Df9sdOrbC3IcucfYNyL0C4IE1Aj?=
 =?us-ascii?Q?btt4Bw8+SmAvS3z2258GGOUXgWz7qJY4/kjJ6sQffQFsQiriYqMu5V5M3w2c?=
 =?us-ascii?Q?yvy4V5p3SZmTgc7nySONK03mhuzL6uNLz0a/XvjZzQ7unY4XujgE+s7w7Jg1?=
 =?us-ascii?Q?Vax+7O3AWG/RVoLUXCI6NEm+Kgwv4NSE48DnbkdxO7HbjDdguINJ3PT3m/Qz?=
 =?us-ascii?Q?Kt3rbZ92CZ4WFROKPVZm6Pzv1z0xUHa2rhctev6U0/R+PVDKyS6g2UHhaxai?=
 =?us-ascii?Q?TchpiSscEEyg1VJs4ErYQIyChRITrdHR0o14F85+eskspv65k6FSiqBD4Ncv?=
 =?us-ascii?Q?Pp1xGsSeO/dI69axcgJ3NERlZ7kF5mZy5CmCGSa3YSdjfxRFkk4SARmot3JM?=
 =?us-ascii?Q?eeESZplgU4anpgw2Tz6PJMYHNdct2qx61eeM13idkj9KC2zstQiIBU2h1XJ9?=
 =?us-ascii?Q?LObujgK66hx+SVU6zXy1IZdwW/C8VSb33puIo4cUuuQBZE65Elcy4WAysQdr?=
 =?us-ascii?Q?pXNJpbwVUTZsZpta37ODNDLWEfGTiaQMqpsj4QHKEndJdsxM+v5ZBjWCQKYb?=
 =?us-ascii?Q?y3D3rwUG0yynNQbQ2MdAupY5GorrXpPjzXWFgLp5uhUgDN04ZV+TAEcX8yMP?=
 =?us-ascii?Q?5wWzf4ev0ISnePDbUiWRIyXUWBvRoOza4fPkqfYxaBaQ4wxbMNcVCcyVCA5D?=
 =?us-ascii?Q?3JU7N0ODtti2C6RHyTMzM4rm8IxHFtRqCmdLigVrXmPjg7p7UCUl79zyTnqF?=
 =?us-ascii?Q?UQswgJJbd/HZpPhfd9RoYG4RY8I8z9TQ54G7evlvx9fjMnJNoH2NNnA0guRo?=
 =?us-ascii?Q?mcA/IwcmMLZMXD+pstI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JH0loWl4l3+j7uR8iN0aiqKroFuKqkYej/fzZCjKPeeYX9EC4zAj4GzuZ8Go?=
 =?us-ascii?Q?yLYmIDlcXU9qg+fhuhxuCUjfym7KgdcBEQydmQyjA2qUNSpoyJlSo6oV7PaR?=
 =?us-ascii?Q?kDKaqIGGGuOBmOGrHWYTXj3IecUKYM+BvWqOVEXRHPFhdGq9W0xdhpEkWrg0?=
 =?us-ascii?Q?dzi7ttNf43G78wCx16oQs96LVV2Fz3usBSyZNueIA0Ys/sS1L9vRohvlZQdr?=
 =?us-ascii?Q?QM87I8l05PYmtvYaj3dJ4hssf6H5g53hlA7BfTnutCReqYmcGlRWHDgKhVRc?=
 =?us-ascii?Q?KnpgmAldfgHcB5e3m6NZadmQvFkfoScYb/iqYRhuUSOpFejZNuJlGaoOz4b/?=
 =?us-ascii?Q?R8qy4qLcZaj6ocvu4ioAxv/UeK9kOvUM1c7VZbWSRdiA3Tg4n2h/IthGrAAC?=
 =?us-ascii?Q?yScOVirKbPZnABJ37UTpr+6cGfOA/kj/1uzfyCf8llWgN7LfqIV69iTO6M6i?=
 =?us-ascii?Q?41MWhWa8UcVsWInPgsDuRC/Krr3iNu6OlayjOshYwoxq+sYoB8yhDgsM8zv5?=
 =?us-ascii?Q?pNcG3njxI0mjH5RDIBFNqZ2DWqUQNUoxg49/KMFC1Us4TdD+qLgXwQKgiLtV?=
 =?us-ascii?Q?LO7T1D+k0i7uGnEYfG5IhEPDsfwhW1tUYrPWEqlVkJ69EXOxAqJpl1lGib5s?=
 =?us-ascii?Q?gp1Xyl/bLTQ8Fqb1vT/coBQEJ9mJU9OUupju0ett6Tnw9GCOMN1X+uCV9UEa?=
 =?us-ascii?Q?BsXFcUe9pMnoyokLPV1DuDLH4JI+HZ7aQ6TCtYGfkgcX6XWU0NG6HgN4CY8X?=
 =?us-ascii?Q?LrjZmsXoRxxS6TylFu5ZqNglrxRHZavUSyt/XKZBqBEeGpRhFypowpDqKRBu?=
 =?us-ascii?Q?vts3vIszSX0PKL0tKv/yLLdKvpGUOzyrgXNFrBQ598iKTwygZFpEIXYaLywy?=
 =?us-ascii?Q?FcAYsBfTAqBHgtvFIT3lxHoEEbBl26AHw1H41wiBk44O0Eri7GVUwh/TYMF+?=
 =?us-ascii?Q?1FdBtigspLEn5zNgN1cFcrnwiBzG8u2CfUckHh3wWoV3gHDsD1rXl9yg2Ix+?=
 =?us-ascii?Q?WB1YC5VB39ye2qWuo7sXknm8JeM8E19nfrKoMk8/ZwffJW/y6PzxhbPXH/lJ?=
 =?us-ascii?Q?f7BuKnlsivcwrA22c3t7Gn8NSX5e3lXD/lNrZ4z8UWKVpb2D5du92zwzqo8a?=
 =?us-ascii?Q?MhDbj9JwPyohfDPHUjGO3KJ43BEo0ChnAlqfnYioYLSiDh8SM04DWtEfZvMw?=
 =?us-ascii?Q?toGZkYxn5XuWom8VEQfxCJHYdClOy+WjbuIZ/sWT/QhV8HhpK+vwK3ydU3bN?=
 =?us-ascii?Q?Ui5HIMGpgcnF/pZAh0jWZ0ZmcjmvVtWMxR6/wFbHvmwjuHnAeFl4BHJxhVdb?=
 =?us-ascii?Q?AJbKhQEBTUIe4ewce05sK/UpqMyou9A80X5bF0DlEwwEeDBiLZIsGBemfDxd?=
 =?us-ascii?Q?IQTvNQnICXKCAb7/ntmYtBYNRRNqQVB3FNgUiE6/TdqGcBonviLP4Hi5UFGw?=
 =?us-ascii?Q?3NcWIw8TsOnksMoblcrzC6KdinyZxpv3df6Qw6UPeiuLMRB6US23V6dr3uZ2?=
 =?us-ascii?Q?FqGqcwQEMmKU+opczOgQtJQItGjNHlkQU/WQtp/rzftgDjp61UKrg+nl7JzE?=
 =?us-ascii?Q?Tl6KghOHQEdRKDnB90oHHJ/PlU3UKEguZhXG8e4KrkzD8i/Hxcyg4QPCY0sV?=
 =?us-ascii?Q?Mt+Ezb+QbStLaDzy1ujP5PlUizztiNuNFqx4gGnP91+ZrKUV3g4qemVw0lQf?=
 =?us-ascii?Q?u1oZZDJO7OpKCU10F/w7oNYIS5pGSkwLkJSxrFeit7fcZypH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f87cf6-70ed-432f-87a3-08de722790d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 15:32:19.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDbrATZXK5TtuKgKUj4JLZI6TKLK6+jCPW1imxEuc2skHArQ12sq/TblRs3SdTnUrD14oy5Ov8koriDVSMLPqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259881-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,nvidia.com];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: 07C7C16F884
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 10:17:42PM +0900, Tetsuo Handa wrote:
> Add selftest for "team: avoid NETDEV_CHANGEMTU event when unregistering
> slave" patch.

1. Repost the entire series (fix + selftest).
2. Tag as "[PATCH net vX]".
3. Wait 24h before reposting.
4. Post as a new thread instead of as a reply to an existing thread.

See more info here:

https://docs.kernel.org/process/maintainer-netdev.html

> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> v2:
>  - Removed unexpectedly-copied Copyright line.
> 
>  tools/testing/selftests/net/team/Makefile     |  7 ++++++
>  .../selftests/net/team/team_unregister.sh     | 23 +++++++++++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 tools/testing/selftests/net/team/Makefile
>  create mode 100755 tools/testing/selftests/net/team/team_unregister.sh

The team selftests are under tools/testing/selftests/drivers/net/team/,
so this one should be added there as well

> 
> diff --git a/tools/testing/selftests/net/team/Makefile b/tools/testing/selftests/net/team/Makefile
> new file mode 100644
> index 000000000000..aa8ef0590022
> --- /dev/null
> +++ b/tools/testing/selftests/net/team/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +top_srcdir = ../../../../..
> +
> +TEST_PROGS := team_unregister.sh
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/net/team/team_unregister.sh b/tools/testing/selftests/net/team/team_unregister.sh
> new file mode 100755
> index 000000000000..cfa710237d8b
> --- /dev/null
> +++ b/tools/testing/selftests/net/team/team_unregister.sh
> @@ -0,0 +1,23 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source ../lib.sh
> +
> +NS_NAME="ns-"$RANDOM
> +TEAM_NAME="team-"$RANDOM
> +DUMMY_NAME="dummy-"$RANDOM

No need for "$RANDOM" if you use setup_ns() to create namespaces with a
randomized name.

> +
> +cleanup() {
> +    cleanup_ns $NS_NAME

Quote variables to avoid shellcheck warnings

> +    ip link del $TEAM_NAME
> +}
> +
> +trap cleanup EXIT
> +ip link add name $TEAM_NAME type team
> +ip link add name $DUMMY_NAME mtu 1499 master $TEAM_NAME type dummy
> +ip netns add $NS_NAME
> +echo "Setting $DUMMY_NAME to $NS_NAME"
> +ip link set dev $DUMMY_NAME netns $NS_NAME
> +echo "Deleting $DUMMY_NAME from $NS_NAME"
> +ip -n $NS_NAME link del dev $DUMMY_NAME
> +echo "Test completed successfully."

This patch [1] works for me (hangs without the fix):

# make -C tools/testing/selftests TARGETS="drivers/net/team" TEST_PROGS=refleak.sh TEST_GEN_PROGS="" run_tests
make: Entering directory '/home/idosch/code/linux/tools/testing/selftests'
make[1]: Nothing to be done for 'all'.
TAP version 13
1..1
# timeout set to 45
# selftests: drivers/net/team: refleak.sh
ok 1 selftests: drivers/net/team: refleak.sh

[1]
diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 1340b3df9c31..45a3e7ad3dcb 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -5,6 +5,7 @@ TEST_PROGS := \
 	dev_addr_lists.sh \
 	options.sh \
 	propagation.sh \
+	refleak.sh \
 # end of TEST_PROGS
 
 TEST_INCLUDES := \
diff --git a/tools/testing/selftests/drivers/net/team/refleak.sh b/tools/testing/selftests/drivers/net/team/refleak.sh
new file mode 100755
index 000000000000..53675be04965
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/refleak.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/lib.sh
+
+trap cleanup_all_ns EXIT
+
+# Test that there is no reference count leak and that dummy1 can be deleted.
+# https://lore.kernel.org/netdev/4d69abe1-ca8d-4f0b-bcf8-13899b211e57@I-love.SAKURA.ne.jp/
+setup_ns ns1 ns2
+ip -n "$ns1" link add name team1 type team
+ip -n "$ns1" link add name dummy1 mtu 1499 type dummy
+ip -n "$ns1" link set dev dummy1 master team1
+ip -n "$ns1" link set dev dummy1 netns "$ns2"
+ip -n "$ns2" link del dev dummy1

