Return-Path: <netdev+bounces-273475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ0QAYtiy2nCHAYAu9opvQ
	(envelope-from <netdev+bounces-273475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:58:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6668D36449B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B92F308013B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1A37104E;
	Tue, 31 Mar 2026 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hzm6uOtd"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4A371CE5
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936613; cv=fail; b=PipohTrk0Ls35rmQ0drbYuQM1YuyRlpZiiO/XVCHYmCUh4h4T8RaplA6GjGLzTkjy5xdqmESSHQIBAHetz4gowKSDHs/+CmK8AG7e8j56bk/bimlm+6y52k6dBQrnmHtrCFYgFQcsduydKfo0wUM8YTUKNMbhhjUxIq3pnqlW/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936613; c=relaxed/simple;
	bh=MaOag7fOdPZa4PdG6WFjWpvfQWe8Ch6wtre+fmBM/YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbuDv6MCDLUD0o5c33L66uZulWR71NnCBU0YMWSXDmLVaDn3dWcb6tWrwjQtBN+XfF8rZWlclK1g/fpqM5oiRG041xjD3HC+2KuMK4+0Y4MtC3LUMU4tTj0W+2m2btyw5HStxW/WL5/iCHWUyQhW521aY4h1fXX7sdLtavOEHy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hzm6uOtd; arc=fail smtp.client-ip=40.107.209.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUGnGcHPERk81++o/hxUviBfq7k1WxQxEwh+mxNkMZ5jNKFAkGSt9ntSsaX9WFvE/hL4T/L3fL79FTlJDuLwtfDwmSnPHIx5Ld/T7Crkv/rdYbRgPIBUjHofV6FjUG4YuljfECUYpyOh9wxCECbcx705Y6LZlmOzsRp+3yAGruO5EW4W9NtVUf7VC3AfesDuaEe1BpZYBJhNAB/lYQgX3YaHViNa+8lWTKgeL/qoUBAzbldqVN6E8sbT+bGCZSnHQMF80XwrjKKswxjp5kzR6gGS9dzoEw7vf/1EmAJtwLgfpuCFNi/3lMhrA4u2jLB2p3Hl8KgtCzvi6kPpTwUHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEk1gulzBnwlih+zeeEjR3tJsIG9tYAexRnrp8b/bA4=;
 b=lTH8DD/R/n+QqaU7lBCbNkK5Ny2lrcGVZXwUIgP0J+Ds7bg3ibMhWvSJIcfO4nSMNupjLO1pxH3J9cz4uBapY9gLktRDAUUM/rQ/RfGglOwU9GOisgB8wYC4gDW8WRxKGM8kiBceODCYUlL3KRh/LZeg8GG3h+CWIFonYZTjpuRJ5KK4x7xTfQxDev+xrC1uyhHQ00cFJHx1Ss1YrCwoq2W7Bn+WZTALJNm62CaIsaQg4Fyso75vSmaf8ILubSHPAwFJ+6X0qZRaDvuAdzquBmgditWUBOvrcYixLMJXJk14SP3YtTER/y2dSQhl8PKZL3UyzP5mf47VHBmpjLZuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEk1gulzBnwlih+zeeEjR3tJsIG9tYAexRnrp8b/bA4=;
 b=Hzm6uOtdEyn7Tfa/UJHFKBjII0D0Cq59KEWmcowh6VXhP/IuZFfsRMORXIGTojLZWWHkIIFhOXLJegtUZrsYz18JNjtzW4RqfawVHFdpM3nHTrOTiK3yaGnVAq+T9QZmfAisyI3K399pgRhL/KIHUxDwYMeLoW4epejcLMzmwEYaeusCHaxWA35sfYoiexzhaXREabP4GBUgZZwl+rMD8Xqw43G8ke+t1H5FpTNIUyl+MDbjKg+NFzc2dCLgQAkw0DQ8Ybgr7ZXpb+tgRT1kdgVWrvQqJOc60f7ePKNJduD5trSDdZfPlf2NytYsuR4snZ0mGF4QnfZ65OIqv7bShQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 05:56:46 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 05:56:46 +0000
Date: Tue, 31 Mar 2026 08:56:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, sdf@fomichev.me, petrm@nvidia.com,
	razor@blackwall.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next] net: vxlan: check ipv6_mod_enabled() on
 neigh_reduce()
Message-ID: <20260331055637.GA1497954@shredder>
References: <20260330121033.4479-1-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330121033.4479-1-fmancera@suse.de>
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f4835ac-55e9-4cf6-783b-08de8eea4ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wtYGItjlTxWEHDrPB9n9ODhGI5m6PSFzscy814omlew50MHChfXKoVaPu0mV6cmyM3lMQCPLS14hiT8ysKjC0w+45dAXCeI4Hq3y+iOOUYHL4J+yeLqHInK3r1CrdKuviA9co7Fr9e/OhieuXWYyKBfBLHH95CZzuEuhR+xFryhbEQ1/v1dOz4D8lswLXldw+rP1zwbkM/UD8kYFRV21Qm+ry5PAXrXtcdwsjiSQDH8Or4qEnAblm1ioXz+dv6eOQr1idCMFsgXTXHEQX84xE0fzR/BxLNIGYeLbrhaUw/ZsWV33CvHgcYwLJpPXc0q8tXEQlJ16L1tzpXU1UALwAW8DxcIUVuCUZDrI6gEFMN7iuoIO1yuTM2Fxat5W5Pr3u0PE6YE9RpZ/Mx6qRiLZFaWJBDBLQ80IC8ETdkJDwHS6xlBi31UXI2GxpOrHRFWtxDS5tyNnYwL7y75VkDDPFRZxKfmtBMBqgKfdeJP8gxIM15QtFIq0NEEHAQq+iNMjRVzPX2yXGz4yjk2tP4hQu8Nw0RHm/1+GlO0xNl08ptnV330pve4vQZCb3G+zL1vNS9fXpORLVPVNG+BLkdsr6010r4WdxYTFgZduasQ2RSf5ngtVUGQMtEoXHAtIRi4e8Sw1eFM0QaEbJaYvef6yDoqupX6SgZhdOY3b/mD/mVFXEteLd7NLWfk1F+oKVjrAl13M4xV2d3d+m4mhmEfD2uwizVm2UTCPzMEQoS4Zonc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ALUKoljUFeSva+TOf5RFTl/gdLmPVAlOcA2G0h+iz9GmTDbqedrtghhG5TsO?=
 =?us-ascii?Q?Y+7RvUEx6/BXf5HWdyFIhIMUrCYgbPg+o6hjt1BPCcUtg1QbUGs+IhWWU4jH?=
 =?us-ascii?Q?lLu+YEAXBM0CBbOCg7EXC+X64E7v5P2W36JEQ8630iBLKi+NANZvHkRsO2xK?=
 =?us-ascii?Q?dfcB+E2DUt3XNwLo1KoHmh42dIhn8oNmnOYDly9Yf29BSLezWA0PeH4rQpNa?=
 =?us-ascii?Q?AaFSye2X/FlRWAYJQ1Ynh0n9vaLaYOP0rEwguouzP/+LCCTNAwAKhtzk5Gfb?=
 =?us-ascii?Q?LhzaksKr7X8eOGxzaENUkj/ZTS+PS4HAa9zXaPL/bMZdlw6fzQCovWuzQr22?=
 =?us-ascii?Q?ny9Aqwzhmawrac3Hmw2ofKH0sp5MNbmvBRUGw+aQJKJDFVN8PRR2xdSsj/jI?=
 =?us-ascii?Q?KFi2Xe9X4Y02ApzzZIEIt26PHdb440+ZdF2HTy0kuxqvilGLMFGgukyKNx0Q?=
 =?us-ascii?Q?CGnCoqw/O80aNoPqWtfrhQhUL6lqMRqY8qD1QPOB5zQy8H/Wx2u3ZlTHyOju?=
 =?us-ascii?Q?NBbn0oVW3XBKgYDUyZTlMbCqI2dq3SMC4tTAphyJh4ofVEgGqgj0bEoHJptP?=
 =?us-ascii?Q?HoCQ4JldNdeYZSNkZH9Hxt/+CzsKmc686EvkxEiBkr7U02MPMPPBQaQTwW9a?=
 =?us-ascii?Q?wDrGwho4kUsQ8gnEDJfR+8iEpQAgaMXTHDGkphv+IcvIXF+jwm08raPd0TXI?=
 =?us-ascii?Q?8RPzPAg95Jz3tZiYMyw0Wn3oQ9J9ceE3fc/0SHYFwPEpEBWfpQf6XzhFBEar?=
 =?us-ascii?Q?NTKmhr80aFfxKanTftpkX3cPhSR3/+NJmV/vdVzpA37Vc5Aatbcd9cEHUtnz?=
 =?us-ascii?Q?YSe1ZC6Ams/icZE2nCSsb0NuveFYxnrHuAQCTWxUT+2b8ZgUWPBdL0pOKeFI?=
 =?us-ascii?Q?2QU9G92WecO40ztp8emURk/cd2Iau6aueLY7bXFHUwAARZGdvEeBwYZsfFyN?=
 =?us-ascii?Q?ZLrx0igbNZ5aES2AFUZv0K29heo4zhkR/aCAlXDVwSnNq98kYXeN7JXb3AS0?=
 =?us-ascii?Q?5xQOU1G0gZbejDVJ1GHDNHBDozcGppYExBkaAZaKht6CKUXvNtbfWDbjXEK9?=
 =?us-ascii?Q?a7ktoW/q6jElRlsM1kh1RabwTtZyGEeygOoWe0PD3Xui8bzJxtrjezcumojX?=
 =?us-ascii?Q?Mrhit6KiGMKO28yAPiHtz9j9y2ptG2XGvUKTA6eLtlh/wv81fsmo5p7bZIWZ?=
 =?us-ascii?Q?aqHZVsMsxbb4Hbs8vzirXUQg212lx43+2Ndxlw95WzH5/YmczFPK6Ge74j/9?=
 =?us-ascii?Q?CAakj4py57gvJPAjIqhVnfW4qlQGcjO3Q58gFi52eIyfWARntsal2Iu/C8KY?=
 =?us-ascii?Q?efTmKnB3oAEIrCfnvq7MQMd76efJ+JNEeZ6/qM6s8ejwyNLf1HaB6hbF+Tql?=
 =?us-ascii?Q?wgXrOu3pYtp+2eZqdN39yDdjuv7+uonyC2Y+fP1qzV06TZ9J/7xHEilcMgur?=
 =?us-ascii?Q?XDUyoMMZGV4V4yV8vm6AyX+HNZxp1leT4Y0HqMui5qJhVfqti09AJmqvI+mc?=
 =?us-ascii?Q?+8jRnLnAYgTNBr9V8dgSWhzYZGO+RyRVNwpHbZcarsBT6svz8v/AwiHbv8ut?=
 =?us-ascii?Q?FlpAZEZHIwVitGR9WS5BVrEtskO/zIb7BeulOjrb/GtAo5c6nsyJrUwW/PvJ?=
 =?us-ascii?Q?iND1CnaVNTpRu3ANsB5MSvqMk1u14AZFzzXWRATZhx9Xtr9LGGCte8Ppo4aF?=
 =?us-ascii?Q?E2mSqyNCqHOm3W3o/qK9ntgT1ZN+vIKr4M46nPDY/XaZjukH63QCDcK6TbL0?=
 =?us-ascii?Q?juUfKjTOBQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4835ac-55e9-4cf6-783b-08de8eea4ac9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 05:56:46.2443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqI4YGeEqPa4GVDiEcnqCzXoYfc6yI/tHtrIzX1BRS7/CTW90Jt3zVIG1B66PeZ1IUe1gFICqyNz2X/77JDvfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273475-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 6668D36449B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 02:10:33PM +0200, Fernando Fernandez Mancera wrote:
> IPv6 must be enabled or otherwise neigh_reduce() might cause a kernel
> panic. This was prevented by a check on in6_dev. Use ipv6_mod_enabled()
> instead as it is cleaner and also consistent with the code at
> route_shortcircuit().
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

I believe the RCU read-side critical section could be reduced a bit, but
it's not critical, so:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

