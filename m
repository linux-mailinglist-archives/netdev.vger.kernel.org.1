Return-Path: <netdev+bounces-274563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOYgDcZ0zmk6nwYAu9opvQ
	(envelope-from <netdev+bounces-274563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:53:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F9838A0F9
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEC753012B40
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61DD3E1204;
	Thu,  2 Apr 2026 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lyD0s33l"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A03A169F;
	Thu,  2 Apr 2026 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137978; cv=fail; b=rLFDdFIJh/FCkTBdfUt8yqRSE8RP28/nGi9MkNGhjchWKwhcJIG7JzQ/0f/tAcCsQGHxtXRQaYUjh/R1RTu0UUp1F3+Ylmfk6Rsh2YGpOx/UC9OndeqjudCQKg9K56ULYqsGJPkn2XFU//FmjbLWIO8HGi4uqzIdX+Jd3YrRM18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137978; c=relaxed/simple;
	bh=8WloEHaPsYvyseIzmc5yZBTNQlC99Kg02xbT+Y6SIus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hzo/Jc+PFFuTFpmSGKjaSvpcBdSgFCiRaNhjOmZDUAsy40mANV1FuyiOxWQfTyN/qKYR+ZeXRa7G3UGAO7EYg/83pNwlp98upw+f2l/4R5+owU3v40kZ5dhg6RvjfIMndicg0OtDBrHUE9GnmQjbz0LKCbRVoZeCJpwUpZ9oSyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lyD0s33l; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHzaQC0wWYdXwjsX3REBYPhNwWsFZWzouRJDeI8KcRaPVtyitf7eHkl0DD2AfCRRw2SIea1eMslSgaQh+ZT2iWhRFNnFlFD0o9N9JIDRGsufECqtI8LNEF4VDbLE3OQJwLMZWk/OgBNhaJbO10mOesQt/LnAmYVmfrvOLmo7ZvyCEyByDSLBKNMjbmcSrnkr3rDu3QkFVSfo41SVDSRRdJmJJFPKhc57uoHPrrsz61eFOg7vDTeTE0caRISOGuCZ5G/ubHmG4FKNzKZDnWOfjHhtt9z0bSaINTEo4MrAX4xm6ut0vgmjPfVMOgavSZ5cSm2JcRgVC/s3Ofw9rzJTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sgHGLOEHejbP9u3MpO+dBmyTeS8MFVR7lH0Mmv6Zwc=;
 b=JG/++ajmGTSO5/d+yD4fTvK9d6oWh8USFkqI3gZ+AOL60CkBhMdV/T3kztibD1VlEq0kfE4gDqyVGCTdEXpcTZf82S4mOdc5ZcPfDoXEX/0ZxxdNoElsjKFLJhBPohx0/gK3jNKtKl7A5JdwfIptXl5e3h7XzmLmDuo62u9fPSDKdFEBc2NyH9Cc/Izr13VQ+mEmWOwY2S81QucrweaJmxdjS37npJqdbYGz+UE73RbReqxPQxVO9OpwZmtIbmB3BrTBLcApXl639EuYQY1WUrkaA34wTW7Q9cLWwJLvLdG3JN4bEepmQgyGyMOuqmffCnR+8yBA61nkl+cTJsUpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sgHGLOEHejbP9u3MpO+dBmyTeS8MFVR7lH0Mmv6Zwc=;
 b=lyD0s33lKbdkSYfoiLKvRhPrS0FFIqSrngbMtCfeKaVpBlF4/gDzpI354OHgFaonlB73aCEhexH2KNyduN9CJGS7SAX2sAMsRDyymUBXvMzKUgtsQb1uHK3zajr9FdGr32dvpt2d1vhZqi+4Z138holIVMZWFNwX2Ytd+a8c9yn0hctnleKgF85cnBFssZLwFD0JGZmAmHEEj2c8v62GzG6a319tHQ24luC82+ZMr50vRDih994NAObDd4S8vQjGXL9taeNvQy+jrBOYOlWmjgZDGi/Ygq9X0yRLLc4wkJzvUilqIsYm790TgJK1eSko5FiTcZT3pkF1mp120HbJoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 13:52:52 +0000
Received: from CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9]) by CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9%4]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 13:52:52 +0000
Date: Thu, 2 Apr 2026 09:52:49 -0400
From: Yury Norov <ynorov@nvidia.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 04/10] bitfield.h: add FIELD_WIDTH()
Message-ID: <ac50sX3MZAcVSNJo@yury>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-4-44fb63033b7e@gmail.com>
 <acx_1dOF3EjvGt4B@yury>
 <CAJq09z7+cA9_1fWzkrJebutJD0b1BGhrC1sUyoqqb=ddKCAXcw@mail.gmail.com>
 <20260402102717.5eb48393@pumpkin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402102717.5eb48393@pumpkin>
X-ClientProxiedBy: LV3P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::28) To CY8PR12MB7171.namprd12.prod.outlook.com
 (2603:10b6:930:5c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7171:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fd7e1b-ac01-4438-1300-08de90bf2226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kcbP3JTWHDps2dTMTp5k7M0aLOxTUYtiLARMbjauKkveL6b1JpYlOUIlIRCLWoRxaH0+8evSxFM+TBV8jgtXAKAaiMNlf412TapxVzav9CA3dLSXobeIZ33HsUC15t/DIE/KstLHDeh4OY2TC8RBL8VBY3TvrFKhqFebJ8jyhL+1qUoOKyYSbmtHu/lh4M5y8vWLpC7mPWMUMEh6kktjiWyWdDxp88Otl2IYGywhGs4ckiIqeoVv9KdsXqUvk3MjwLlZTpskw5ANXQ7txmWFEkoIr3q4KdVZ5w4FIqUw+0zB/VoCx3JzS35qDydqVCqDyJqO3xb1Y+uTmHD3qG53HmUy5KbmomFQrRb4WTfsNRmIcM4UAlpRmSvTpbTasIV6UJK7J+FUwVZ11zOS7VxKIrcZTUCJLQEH/HwSp+Fivk+gkIMqEJevIVvo4NxUGtutReA8TPlXGY7zUUfGmvtYm506DbnrCMIjm+8j3v3nHctfGT08dfgFnLw1h6wknKAr8JZfxzRrAo1f1Kj+bR6oZ1gsO4q1MIkH1u26oN+9/nm6W7NG+8LlE3PxcjvVBzWp36ueDo3Um3APPz59mk+H+F6ecM7QVRaDaYXmVrOaZylVwpvLxgcre8FCSlszRjbuzZu5e2OD9yaDrigySsa0mK5IxbeW2r4dQg4EdrFagEnN7gEpF4Km7347ebfjksQ2i4zWSnxgmaPs5A9elnSqFeoIoy34ZOSpL9KDqgMkYX8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?993JrBBVdf8kGRIOyEXoBiNddkKxfNM2hgVPc/96QTpOulMlgOAR/2u/7+Pg?=
 =?us-ascii?Q?+bwhupFpbOJlzR1GZtP4f6GSvsHAX1hFzI1+9D1CJphwcKkrstaPB9N6gQVR?=
 =?us-ascii?Q?f54tjips6FaHOOBE0UFREod8AQrWQmBk3wSk6qYCrO3sn3ROTiZ8HViKE7Yh?=
 =?us-ascii?Q?IMkNqUbOkgY1Cf2WgfW4wYdoFfTTiDqaWlkifSOnG0C7eWOog7/2Rv6ppdpi?=
 =?us-ascii?Q?fzCtygOaR7P4HUjsCu6wETatW+rqwKhtifXlBMNCKjnTCVw5ZgSL2zZgyToV?=
 =?us-ascii?Q?V4IHQC93TSJKaAW6Kc0yyL8dSK6VZoTgL8GHAhG/oWK93zHb7P/mqwKDJiqG?=
 =?us-ascii?Q?eGLGR3ay078aT4919k9vC9SqMcy/QzTkocxVUrjEgQqPWmctUj4HjXUZstc/?=
 =?us-ascii?Q?iMiY1PlpT1KQ6sUhPKzX6cWtur9Tk1fuHeAc3r/gRCFkZRZ1Yl5Y6MU6UW64?=
 =?us-ascii?Q?s8AF5goGRKg0rmo7LYmy5YWSJlhOW5hBES19trDBeILYKf2YBarCVC73MF7J?=
 =?us-ascii?Q?keD/qpfBm4A2yGvAzkngYaMai88Ezs5WzJr5kS61vvmb1PYhmpCptP5Uqe6D?=
 =?us-ascii?Q?B8uNJU8/aqK5t8kFhplOZ4SAy1K0isdVY26uulR9QZrXQiPVNiNDg2MWQy7i?=
 =?us-ascii?Q?hP4O74RNNovbWqkfinGtAUZL8fl2u4fi6a5g/GegFv3nrXr36lgRhkMq21nv?=
 =?us-ascii?Q?qQipjb6ZYswZFxmglw72xZPcUODOc1V2eD2LggAGjhAw2U9rcIs68zNo7Bfn?=
 =?us-ascii?Q?ydCwydgMeDHWHDdMoK3l3zBjb6NfLrSs5lSqkrekBU8Um+QH7R8iJPzeiLLa?=
 =?us-ascii?Q?+FlkRLiYGE4BDXuEX/yQnMP4AVnWJVK3QZUy/WdEX7k7tK9BmEgOFN6Vvzne?=
 =?us-ascii?Q?cl0wNzHFfzeYA/K6WAJv29x9tLx7OTPFzq2NlrefsRPPuzyFqg2Stw9xvevf?=
 =?us-ascii?Q?dhLg2edfUDFOA4+OS+g4Xf1mzNluoerjaJJCYnr12eQAngfr2qpetSJnSnFt?=
 =?us-ascii?Q?WXEjR0QhQLj6kUAx+PCOq5CVSciOsphJLzAU17qhDrtC6/ManKWr0HW71CB3?=
 =?us-ascii?Q?OkGIhGKtNSn91ZYQ6QfUhS2EOomFiyP50Ry5LIWH2bKED4nxZJPVQ1cd+zNb?=
 =?us-ascii?Q?QW1Jd7bJJoceKyEv7dD4g2rInuzwbKFGY3saIWiNY5JWI1SRJ0xnN+v6H7P3?=
 =?us-ascii?Q?X0sPm60tWkQtT5H8mYs9yg37rxOvBOvdtPhAhCT1tReCW8W6vjMkgXp33xNd?=
 =?us-ascii?Q?FDeU1hKVrbyH5uxkpiQxsJ5tgNP3OGijjVCRRZntQnW8pYaleSwTst5E4s88?=
 =?us-ascii?Q?FOlr4+kKDTYeEBn2PGp8oyQp1v7365EtPI/eyAGfqJH9YiArGPLNi3951U9V?=
 =?us-ascii?Q?9lbSK7vFftGthHCMtxkswC0YrcIYXiMCUOkSPDylON74wVPc5WD4knpMB22m?=
 =?us-ascii?Q?WxxPyKHFm5Y6wKxKFONFX4l4KqlhTRGLe/0vShAtH07U8W/Cuwp8VYb3Nb8R?=
 =?us-ascii?Q?sHyR6Dvy9VctHj7s9qnW5HAsC91DVUsqcUtWxjv5FYotrfSTlFHG7aTGZISx?=
 =?us-ascii?Q?h2Ll0+h/Rbx6+83Y5AoE330njJxSqJfaCMh1e2O5ca5zU5h0gy9NZTUYUhuD?=
 =?us-ascii?Q?1DJCKaoDh1Q0SdjrmeSWR1jfxPH6cdsGer7dUI8cU2O9RpPUAch/N/1ASClh?=
 =?us-ascii?Q?aA1Fo/lcR7TdwAbj2LRi5Qa9KXtnCp1e4UEoY2j2bD4l8EFVJuDF3WGq8vju?=
 =?us-ascii?Q?co+5TSoZLz78t9FAJ6LkCdn3KNl/9bfEZA1CxRe0+VnYIpdusidw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fd7e1b-ac01-4438-1300-08de90bf2226
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 13:52:52.0393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4watDC8Pesxe5XVJefWtngGUi4MgPMdufikeiF0UurTw6TXS1JHWU7qKeAdptgPqj6LX/z0CzwCszUNgnnYAkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274563-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: C7F9838A0F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 10:27:17AM +0100, David Laight wrote:
> On Thu, 2 Apr 2026 01:00:20 -0300
> Luiz Angelo Daros de Luca <luizluca@gmail.com> wrote:
> 
> > > > +/**
> > > > + * FIELD_WIDTH() - return the width of a bitfield
> > > > + * @_mask: shifted mask defining the field's length and position
> > > > + *
> > > > + * Returns the number of contiguous bits covered by @_mask.
> > > > + * This corresponds to the bit width of FIELD_MAX(@_mask).
> > > > + */
> > > > +#define FIELD_WIDTH(_mask)                                           \  
> > >
> > > Please no underscored names unless necessary.  
> > 
> > I used _mask to maintain consistency with the existing public macros
> > in this file, such as FIELD_GET, FIELD_PREP, FIELD_MAX, and FIELD_FIT.
> > All of them use the underscore prefix for parameters. Should I diverge
> > from them?
> > 
> > > > +     ({                                                              \
> > > > +             __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_WIDTH: ");   \
> > > > +             __bf_shf(~FIELD_MAX(_mask));                            \
> > > > +     })  
> > >
> > > I believe, this should be:
> > >
> > >   #define FIELD_WIDTH(mask) ({                                  \
> > >         __BF_FIELD_CHECK_MASK(mask, 0ULL, "FIELD_WIDTH: ");     \
> > >         HWEIGHT(mask);                                          \
> > >   })  
> > 
> > HWEIGHT() is indeed much cleaner. However, to keep bitfield.h
> > self-contained and avoid adding more includes, I'll try
> > __builtin_popcountll() in a similar way __builtin_ffsll is already
> > used.
> > 
> > I also noticed the suggestion to use __BF_FIELD_CHECK_MASK instead of
> > __BF_FIELD_CHECK. Both FIELD_MAX and FIELD_FIT currently use the full
> > __BF_FIELD_CHECK with 0ULL as a dummy register to ensure the mask fits
> > within the header's supported limits. If __BF_FIELD_CHECK_MASK is
> > preferred for FIELD_WIDTH, I can certainly use it, but should we also
> > update FIELD_MAX and FIELD_FIT for consistency?
> 
> All of the calls with the 0ULL placeholder (especially for the register)
> should really be removed.
> Last time I looked there where some calls that only had placeholders.
> They just bloat the pre-processor output and slow down compilation.

Have you any numbers? Can you send a patch?

> > I intend to send a v2 with the following implementation:
> > 
> > #define __bf_shf(x) (__builtin_ffsll(x) - 1)
> > +#define __bf_hweight(x) __builtin_popcountll(x)
> > 
> > #define __scalar_type_to_unsigned_cases(type)                          \
> >                unsigned type:  (unsigned type)0,                       \
> > @@ -111,6 +112,19 @@
> >                (typeof(_mask))((_mask) >> __bf_shf(_mask));            \
> >        })
> > 
> > +/**
> > + * FIELD_WIDTH() - return the width of a bitfield
> > + * @_mask: shifted mask defining the field's length and position
> > + *
> > + * Returns the number of contiguous bits covered by @_mask.
> > + * This corresponds to the bit width of FIELD_MAX(@_mask).
> > + */
> > +#define FIELD_WIDTH(_mask)                                             \
> > +       ({                                                              \
> 
> You ought to have:
> 		auto _fw_mask = mask;
> here. While _mask has to be a constant, if it comes from GENMASK()
> it is very long.

Yes, but what this _fw means? Here it could be just auto __mask = mask.
That is what the underscores are used.

> > +               __BF_FIELD_CHECK_MASK(_mask, 0ULL, "FIELD_WIDTH: ");   \
> > +               (typeof(_mask))__bf_hweight(_mask);                     \
> 
> Why the cast of the result?
> They are everywhere in that file, and many are pointless.
> But there is no point adding another one.
> 
> I'm not even sure you need the extra define.
> Just use __builtin_popcountll().

For __BF_FIELD_CHECK_MASK() check, I guess.

