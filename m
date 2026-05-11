Return-Path: <netdev+bounces-286591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFw8IZqtAWrXiAEAu9opvQ
	(envelope-from <netdev+bounces-286591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:21:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2839650BCF4
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9D093010649
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4767A3CA4B6;
	Mon, 11 May 2026 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dRY+vpaI"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC713C9ED5;
	Mon, 11 May 2026 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494467; cv=fail; b=OBOQnEHNqwTUxk9c8Z1c4Gn0tqMC+58UlZbkHShtYtI4LJIGww80F/UjkGUvVbaQB8RERVpZ9Z7VqkjH0nYBt8OuUSQEIa88p8GScxfCq+FKpDebWsxMNjcLN1mHd9uM0dcoTH3F+4WCFHH7wH8WwXy6oFqw0LEhJh4zIDqvfZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494467; c=relaxed/simple;
	bh=b7hPG4P8Szj1lkVdcV0Kc1CQCrNw+MkKdGuUL/2M+T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B0galMyRIdSCUIDzdDk4fBcAlJ04BnQzLo2uc9fe8GNOOP0K9k2rFgNstOs9Hpti1nP2OMEHASsNsk/kyg3on0sz+0nAC3uee4CfZaghXDTUtpq/A9VTCgfDCOGHli9JEeaKlW/ukbaSTwPLow/dwMdt8A/dBYf4kMGRTA4KO4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dRY+vpaI reason="signature verification failed"; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z07H3lHOVK6Gr2GAHV9jYhczHAACPLamB1bCuKwT8aZv2ScMUDAqd+qjgbBmoMXn1WregpfC/xn/Wiyvb33HA1hWR0JjmB/zf/Cynvog1c96dNlV+vLQXvAR8LSaXs93DDZqgDMN2nCdXfYO6wjRl0HHOSlmszRx88/pZfn1vJBuz3wl4X83ZlkSGGPkbIsY5B5TP7tZIXUTX71wURJQpnfb+ehULuBXZJN11C9/M/0CrNYY2zbN04WoP11O6W79bXx0pvITZP8iVYH4y1I25Yvz+/LmhdCXhWdPtii8mCuozbvnBPguJ6OCBflodTfVISbL4vGKBNuOeNCNKvUPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiJFMhUedcqeuCHJ/P1rjNJzeETpd6regquYXVIxiHk=;
 b=k5xXeev00egEv2nPk/QAXvgn0QpxcTKdFtNqPFmyKIcpZG3uUPwtgJhXkWYKbD1D1DcZvqoY7UvWzZoZXtoWZMH680kTljwLFWztiSsj/ABc6Z3ePMBSpn0RnmbgFV1ua+1GG7NFENqCsk2V5K/dtHiUKCWvd57zJToC8GeuX+OMX/vMPuCHw9sjENmAtNfe61m9074rIwC5hbuX+Z4odN3+7cfc7CKrMN++UgnD6WSYuRGy5/V4Kxwg4aMhSS0fApUNUkyXL6uE12O8leZjIgkZerc3VR2Fwm/1rbGO6jg6haIievugdsOZux55aiF+S8xbDTF0WwQWKbOSzse3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiJFMhUedcqeuCHJ/P1rjNJzeETpd6regquYXVIxiHk=;
 b=dRY+vpaI8jxC+zTBDfN+ulVIz1lhdFs/IEusmIU1tk0siMCDREaHkaCPZx2mTKNi74FWxVzudEiFpmyelraWQdsm6/ebD6zvadwKc7ry/SaeAcZl0Flc0AHLyqA3Q8BXOsBG1zicVyrZWTvW3mDYN2dFItToZEO/XNfQukYnw7lElPOvuNMpniK7kQfPlgGS947wnLC08dvDY2aLGLKaHKdhym3nwkEGZE6zSxatuy1Jshk76P40Vgr86m5tq0/p7e9H1qRGt9Gd0PhSueGGON3LFcVx8xisoPU93qoa/hTH5js72/bEkz5P5SSV++g3Kpm6DF1ieoH586ytEc6RRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 10:14:21 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 10:14:20 +0000
Date: Mon, 11 May 2026 18:14:16 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH net-next 2/5] net: ti: icssg-stats: Move long delayed
 work on system_dfl_long_wq
Message-ID: <agGrm-v3Bs5h4dAm@MWDK4CY14F>
References: <20260511092846.120141-1-marco.crivellari@suse.com>
 <20260511092846.120141-3-marco.crivellari@suse.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511092846.120141-3-marco.crivellari@suse.com>
X-ClientProxiedBy: TP0P295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b83f46b-0136-4221-1b3d-08deaf461152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MfjlO4SlwAEtGe7WlLkwkAfagmhKKqAzEt/V6c+rj9+OC5Lmn3m1aYUGtxlPSDzvtt/esfIw4M+2eEDbUuCRgfgpEc/QnP3t5sY26rnkuI7qimHd7If3s9vZDef7/EP+ZytqRhmLVreDFFGPiysMhNkQYlAlYU47tIe0nmbxnnyIbgjLtpd3uCEqOP7V5pAFHY5z/ZqCVoeNrPefbvrycjxYGtNIKD4hdPuBOuD1LEOTdWScBhbGtJ+aA4d+8l+NUsxiQ/PX0Ar6FTsVtgWpFKSCH/VIy0omUXEeKf1wZfeuW/1Z+yT1L+l4uvQMPM2DeYdxntOIsrdWVNV8lN4FKlWvYsX1Atew43sZGyJWLl3LOlK7FLBtm71QjtXB0ehxhFNANhDgmldLTq9uB9weM7MjYCGaC7HsgtMSppoWmwb8GKfhVSwAVwAbFq1jnKWpjh/hK+ORt6iSnkt3dCuGEsgtKCrtYJ1J9p8KpYO/vMeVwl7rsJdB/lDaQII7wzAIvvNpwwDpDWsk7glbBwQvVqsTgeqyvt1CfZK0bsdWBUX6VIAORDa1FqTK/Dp842ejCIa3qJ6L2oPjxI935A2aaOP3KU57SSyJ/lHN5ipBT+h509MMrOAIMzLFwEgLVxDJnrobjS5iwJ953qdcjFiZ4nsYZg9Mq9pgC78StC3lrjD/jW1LGxiUZbqB9oOhzULI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?09ypXf1JTBYkICNyx3evOZrKv/OcWCnz9p14FksofCtP40QpR+AfM9ebOn?=
 =?iso-8859-1?Q?eUhMOLz8BQatePKJA3LhNdXuqYuWLBWx07SFWpmBpojayIdDNWJaNm6ZVW?=
 =?iso-8859-1?Q?GGLX5JLRvuHS9aSxKfAtKEpsLLl/Mb/WFF286LgyRQ4PfEIWjLXDdhNjsR?=
 =?iso-8859-1?Q?z0Czp9RCAaMNJWjgzOo/NK2ZGaH4lqra2yCIkfGs/Qukt7kRkREQEvLrmT?=
 =?iso-8859-1?Q?OLRRgeYKea+MDhB/iBWFGjG+PBLVEsOY3ftUxVIU4ZRz4x1fRrz/lY7Nkr?=
 =?iso-8859-1?Q?LDl1PfSMCXSkaCybxQQ88JuDjk8w1a7Z55RpVEdiI0jNcfQXUKsRDcirK8?=
 =?iso-8859-1?Q?zM8bQlXJmggCuI1732hVAhbeHTq17Mt8JxKOqZcwIhrQrF1RD3+LGO0hBn?=
 =?iso-8859-1?Q?B+R7evGe6UlFlk62YNj/ulxVNDnDyYNo2HRHanCm8HNTYN7EiPSnhWytWw?=
 =?iso-8859-1?Q?wUfe0CM6OLJrnDIwpFlpH18sJzWK4adgXCs41eKIZfJjMFDUeAIDtwm9EC?=
 =?iso-8859-1?Q?1LtqEX+Qn7ORa+XyS08CFgG9Evg6QQvcRk/mTBL0UwQg81UpuupObENkl6?=
 =?iso-8859-1?Q?VnxCofXJg1kI4OnIO+/E328YS7oQ3UXYYjqg+GisDQaNhxNQPJYkey63Hq?=
 =?iso-8859-1?Q?j9BaVvD/uzdsqvRKKlx/dz/15pIXu0RxJuRmlV9ceFtXwRbw2Xg2cRgImf?=
 =?iso-8859-1?Q?wqdHtYL5QmCmlph6CcX4K/6D0u/QqH3TYfTb+PAz5bXDcvaakavwEVp6gl?=
 =?iso-8859-1?Q?2PPFrQpSSAVSA7ipU8bXvGsUHUa1yCTYrDfdoWUipCj841Fa9l/CeyXqE9?=
 =?iso-8859-1?Q?vlODqQSTn2a5oBJ3GBEabAC64aTX6Lg2h1WFGHpiLO08YH/FygzlRoFC7N?=
 =?iso-8859-1?Q?bRzGQw68tvsoHqKiYmC0Pai2g+GDPMyhq5XBCeqvicKbZuJGkPDCXndtaV?=
 =?iso-8859-1?Q?IwLYWyP6BYEi8Wf6xRjjkShGxkpZdypGolktLjdgyGEKYqz+bRC+QJBV5S?=
 =?iso-8859-1?Q?nB+oCRDivaEX+F13oJ0jd7U836l2B7PqTuKBZuqtb9JVU3nh87S5+t/85E?=
 =?iso-8859-1?Q?hkJjbu37/HH9HOV/eAw7UCC2ZhbFzvNzH4FyJXKAved8AggtJ7A+ud60py?=
 =?iso-8859-1?Q?/WZznQsL/MJpa2Ekb8x7lebARq66ztnOUUJtNaWK/lPrkIlBbHV0l39UEo?=
 =?iso-8859-1?Q?V3X9Nz0Ngcy7D40Ct8VEvkf5mxzmJcibihs6wWntLxyAddkhEGwkjBIqut?=
 =?iso-8859-1?Q?0BR4FKps1ftJIJ2Go2dOFLFO8KRDrFvPaV2NsNOSw0rX1tSdh3w7ViiB/P?=
 =?iso-8859-1?Q?z+u3HZJvmSTK77WJAnpeUpjBNeFHNf3tBu7J0t9dWTzvXy/JZ67qORxpgq?=
 =?iso-8859-1?Q?QiMNvI51gHT6u2NyScezO1BVnlIf6YCyPscToTbSNKO9znknDu99ocNLH7?=
 =?iso-8859-1?Q?tuj2gRg26D7h6vcM+gsQXh7cwRh8S+b2c2h2M5gqNzOxSBSJj6dZH8CeB3?=
 =?iso-8859-1?Q?KyHVeBM07rMsDKjc+AnFusAia1kaCGzQfrTccmkGbcWOpJim+9Zosa7AxA?=
 =?iso-8859-1?Q?CWcP5oULsqgnKKx/KESP7v90FrtYfCdfjsEY2yhPkpUIkpR3SUs1W6I991?=
 =?iso-8859-1?Q?sIViQO0yyFdgalekihYcfHheDfhH9SxamcdUkVz6z/dQLiaCMudzfssShZ?=
 =?iso-8859-1?Q?/pRpZfGRTDy/9lSU55pk6Rw1vT3DLMw4AjRUpr+5YRfmEd7ktgp7y2Ab5K?=
 =?iso-8859-1?Q?ze1VnhLjXEhS2VMZp1ex9EA8f1O7EttLp/HW1YQubxoyLnStkUJwpF+rbn?=
 =?iso-8859-1?Q?x9U3FBLZmw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b83f46b-0136-4221-1b3d-08deaf461152
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:14:20.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYVJ+cLK8HlnK7WZxs5lL440v/KIykvIjqsDqI9+lBL+MMY68GGjk7lzzPS2EgBX6VlcqxERnXu15aky6z6qhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
X-Rspamd-Queue-Id: 2839650BCF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-286591-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,lunn.ch,davemloft.net,google.com,redhat.com,ti.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[icheng@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.823];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,stats_work.work:url,suse.com:email,infradead.org:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 11:28:37AM +0800, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
> 
> The function(s) end up calling __queue_delayed_work(), which set a global
> timer that could fire anywhere, enqueuing the work where the timer fired.
> 
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a single
> CPU.
> 
> Recently, a new unbound workqueue specific for long running work has
> been added:
> 
>     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
> 
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit from
> scheduler task placement.
> 
> Cc: MD Danish Anwar <danishanwar@ti.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> index 7159baa0155c..7d6d6692d819 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> @@ -69,7 +69,7 @@ void icssg_stats_work_handler(struct work_struct *work)
>  						stats_work.work);
>  	emac_update_hardware_stats(emac);
>  
> -	queue_delayed_work(system_long_wq, &emac->stats_work,
> +	queue_delayed_work(system_dfl_long_wq, &emac->stats_work,
>  			   msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS * 1000) / emac->speed));
>  }
>  EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
> -- 
> 2.54.0
> 
>

LGTM,
Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng. 

