Return-Path: <netdev+bounces-271571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMlKG23sw2kAvAQAu9opvQ
	(envelope-from <netdev+bounces-271571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:08:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C85326750
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43733146489
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87EF3D647E;
	Wed, 25 Mar 2026 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C/Y7Ht1Q"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7A3D6CC8;
	Wed, 25 Mar 2026 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446457; cv=fail; b=kfCAy/AzO7RhMaNlcS4TgLFvzxnBKT1IlYJhMYbBCn3Kf3Zv6oZOtv/huOgdJZVoOmDpmrTMWSFzn0WvsJ95tcL4hx5kpHD8BDUhxi2JreRX3JrwEYzP+WPfs87c7aL+xEbKcdxHHedUp0UOeDle0Hs39Yh2OGY7ygpgMHvAAzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446457; c=relaxed/simple;
	bh=ya5C+YyAINPE9aYJgmszNzF2ejzBQBrT2/G2VmsQJqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AWwZKfmDM/G1i6AH0sHpuzKOChSRBfjfojYzQ8+QL7FFRoc26UIaWJlUjwVFzvquSXvC6dWyq2rRDdeF6VpHJR4kh2tywlYD+PIq59gnZdqtkzHj5M1bxHt6j0m9uPJKBkBhqzmzE9xU4lanIL9k2HSB8gGwmAZw14TECqiXkIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C/Y7Ht1Q; arc=fail smtp.client-ip=52.101.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xn7psNnuowpP7H98gO2UEiYz/Qydzg4/xy+tZgOCBvZZinmnrLQSmc9KPbBtylvXc8dd1OZoHs4DD/w9YRsSLADtcWjUeRpe6kVrLgCpcBru0G1ctuRTRDBSDQmlvxnEjalwhRPYHa1Z0oJO0gf5m2lwgWFas9WTWqapLSuMS0wMRNT1AIcqwntnXJt0Jr3nFrXC9gbTmgFKF453Xvn1uFY7HCo8WhHsQkWbbvPlrE0xxLN0CKUn7qFFeIbbNcoNch4pxb6mo6XYkbhzfW2pgq01uLWa1QYSDh2IXXC/pc9sOdDZnVxcfdxthgRiQN+ZQi4dBIeQK9l3tfzBN+8IKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opp+k1cuUQUgjMyx10BNSQ/I6OGmNEL3cqSEkRbxmb8=;
 b=N2CfbldazLoFbVoGSlPRCFUIRlFs5kpP9uybzSDd4Dk8yzoGsVO4gVJ/JA16mKtHAXOJuMSI9rEHWMsXiyACP7X+QX6lX4xsvSOZj7hvCNmEVXg2BM9nN7JejyaxVTSU2gzUoXquQkyrkZk8Yy6ExLSKh38eTnCP7Cmn1QO29U3QYkVBsc9eKkHItXVU6LOcGnrIMhKCqB4nFbT3oRUWkm4hnzbJHqjqGsW77dq7tT57drw1XEEju87wnxuC7yTbgOTZ4DWD3Yyso+3iAAF/X/g13OwQ0/f1RDd0KzqosB4UaRItx6M3PY6HwvqbGzXBnaD6YLdEg5hF4LJ8T6oPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opp+k1cuUQUgjMyx10BNSQ/I6OGmNEL3cqSEkRbxmb8=;
 b=C/Y7Ht1QFwoMcUEti9AdgdYlXdZ7orGH1ut3INZdQ9DmDEi2F/aBn1WJfSN+Q+7Ugt2YY+lraxkL8mRlkmAgYxCz0PRgPK6/ZZfCGtmdIjibldyQ2J4VTaSF2h3Yuku0RdTtYGYcbJd54+Ju73cckUwrNmcrsI1EBSbAzM1nFr5BHp/0c7BiC6FRS0T8WstEk02YBicLfH8zJIWTJk9scuK77Bdd1fR8KAIZB2sTUVvueZV+sx7VU32rXrxc/Qc+IbU6cN9TXqcFu+fwvDn2aSHLBmuktFXDomDsDM8OV38hseU0STC23yyySS733CBofpuRuDUcAiAEaGkz4WjQ5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DU4PR04MB10482.eurprd04.prod.outlook.com (2603:10a6:10:562::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 13:47:27 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 13:47:27 +0000
Date: Wed, 25 Mar 2026 15:47:23 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/3] net: dpaa2-mac: export standard
 statistics
Message-ID: <ak725sqoa46ip5kzm4hbkf2rqxbdaldudvudl66r33i3c3dvgk@kb4mq5dhiwpb>
References: <20260323115039.3932600-1-ioana.ciornei@nxp.com>
 <20260323115039.3932600-4-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323115039.3932600-4-ioana.ciornei@nxp.com>
X-ClientProxiedBy: AS8P189CA0054.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:458::26) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DU4PR04MB10482:EE_
X-MS-Office365-Filtering-Correlation-Id: 19823417-84c7-4837-5942-08de8a750d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TW4fbD/blk3U5KAlYk5OzHhUKUwoSLCKpajSCsN0jeOG1YotMs7ZWg1hPyv2Cn4g/ZFB/gVl9w2i0zEMIcozYWLm3Or9e4DLvIkXJQh6zgN0/J10Qm6IxeRyruODZ3/SpoZSRShQRVQhjbF+tFozVy43ElF5oy/8RVkavTYVSChsFSavafFaPTTeZWMzKCV2rKGoiEavLtBIPY4YoKqZfr86WzrRKVLKXklR7T6HPUKxciSYP7P2gu0/Ac74yPLjt8wLBx0SpTEwHL3hSLpOBR03gmtsR710hwpI0bUa228XQr9kNmL7lEcJkYAn8CFyKX1+99BK+qKJ0IeuThbd4LxLhAqhJLFXC3ogqNzz06Qo4/Xzx7MEhTOVY/6Fz9iC60JaI9N0XNJvRFwEWds2J9v/lgNyN3Ahz6ukhfsvhAr0/6yfES5BioMvetnv7CHd2T3tzxD7LmLEaz3emPwjm/JaoC77ioXPIMyeMKX5rDLZF7cSarZp5uSPlQvf7HpbvJHAM4fCCjRKe03Zmb/YQ06gtkApl9szuUdPvRuNSVh4ymp9aUYgcpZae609AVtopoPSG6G6NCva0glsHaubl6c0e78bvmPH+yWSOV9CFoW7ugQbLUYz5Glvk2Vgu1F9WwEtLwaKzFnYlWD7Veo44sR/1XAFjupdg6jkCvOKsxzgZEKSBGeCaQJ3Ph/+kJKHIIL58lsfUDvURtYO74pjZwlKqZtnOBppXNOpa2Gb9Gbxvw7UD/4sM9c1oKFgSQyP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7gW9iqGI22XFTF5x/f8AGLKhsCGfQ4BBLdItqJ33WsKz4q/KUbExcQii9ZJS?=
 =?us-ascii?Q?vMVVG+mbqtfdbE7uqaI4Kv02/vrvpeWNXudzIWluGcHRHLV5fKjxod7HsQ+i?=
 =?us-ascii?Q?NFl130RrbZhpgYOwSR5Nokq8JSad+4DWPcNFSU+IeXVx3S5ip5xZ40oiMWyu?=
 =?us-ascii?Q?SBsuakPvN0m4UI+1gDqsJbk40XETvGfcOGpT56H2NdefrwNPSyTTYeXmC/g9?=
 =?us-ascii?Q?teGz2/fUqVjY1GLqcwLt551Suy7DcgA4XHk1DlW/YNlhtIcgoeL8iZIquzB8?=
 =?us-ascii?Q?gjvf4uPsIe5LEKIo9lSibnIu+kZDCihl8qV5V20nUHQXuFsF/+KUOo+D/dWd?=
 =?us-ascii?Q?CtA+VU4IAx5id+qNWa1NenhHCNrjDZTIY9Y4yM4tVzgdf9/j6EHw3l65x4aV?=
 =?us-ascii?Q?pdRoeRcOSr37Yh4X29c079ytkwsY6acI9OgfquHD4G4C1kzCNM3iZsEz6ZM5?=
 =?us-ascii?Q?/U/2ZdLT25lkydGMnYOnaG3HgJNekHqOZWQDd6foMNNI28XT1eVuJv0ZlTTP?=
 =?us-ascii?Q?3Jwvi7qsc1+GqDQxCQpwmZVpF11LznG5bUytNwsLRtffK3tQF6SS7/vpxvYJ?=
 =?us-ascii?Q?A5XAllVJcI+ExtThmAWRcuDyC2+wlG5sfu6ri4zR7wo/GG3oTiN5y17QJ1yp?=
 =?us-ascii?Q?TpLsKZAj+UJqo6GyUN2WiH43S4LyFxKBaTxJN0wTwGrQLsUPkyPByBBETAMv?=
 =?us-ascii?Q?0o6W7Y7TS54JzFTECVn1F7H57g6ov8eFEuIGk65qN51jX2o57bUTVErEmomH?=
 =?us-ascii?Q?FnL1tUrxDmKh9LX9w7J86TkQgLBNCLKpFrgisp4hURqGkNUndVwQiJ5uO1GP?=
 =?us-ascii?Q?Rvb/NTYIgLR3qiHSyqdMSrwLFZgZkXwl9raG7q6ictk8Un+Z8txM8wlTasyK?=
 =?us-ascii?Q?bmiXrNUyt4LXzGR7CSjk1KaxpiWaFFDa5cEYsJnZd3gm723sy3/ey8vNV5k/?=
 =?us-ascii?Q?3+i3K5zwqU80V0Xwlq6DBzUDOm9KZdz4jLNeD+0HL0Oz5auTW+ObF3o6LAgk?=
 =?us-ascii?Q?BkgPRO/p996440HUWr90TnWWc+vC4mUL5IlrXmYG1ePe5sw7af5By3P86MYQ?=
 =?us-ascii?Q?CLMk5aayDXUTOl06eBtpYw3fOwDNyJDyzuM3in+Z+z1rm7PX9CRFmZ+Lvees?=
 =?us-ascii?Q?4WYhrFrH7Tariur6MApfywYI+VuRSiO8FkS7btxH8hDKFrAm07EG3k1uRCpZ?=
 =?us-ascii?Q?vXYAQhxV5MTWc48wvNYfzEXHn3dglcGTcgLOVV+OOmTWvd5tyzbPqnfN5nme?=
 =?us-ascii?Q?+bfz74C5n1UVudej/rBMEgVVBMaVqBeOb2TQ92Zo6YWYGcH0GfAvYE4Htlu9?=
 =?us-ascii?Q?18T7KsjeIYg7eW5nC5cSFw3K7fhjLtofJf6uXdJ4E5MU4CZRUtum3JbbjiN/?=
 =?us-ascii?Q?BEsNsjNTOwVBo4igEKWJGO+Wlyiq5xjMduAn14xVWsAVgVnXcJBl6NSJfNcA?=
 =?us-ascii?Q?jwD3B+wGnT1j7F3+w5bxbnBgkli4sb+y/xruJwlaGtbOqp3R6+GLAA5bSrH+?=
 =?us-ascii?Q?8OGKLOD1la8q4TDKJQv6EQrLLJXWg/USCsjCxeZpEyfZWxAx5EitmxwDnypy?=
 =?us-ascii?Q?nZazT5wwO6nEX+V5jLCz3lfYEx3rsc7sUpqKgE+YR6xHZUpGIMw4rc5BXFJu?=
 =?us-ascii?Q?gqj4YMxS0ydD5oHl73Wr3V1H61irDrP8FYh2Jiy00trdO0vEnZOrtSONLtD3?=
 =?us-ascii?Q?fGngsffOkW5+FZ2QNZRlKD7pZv0QttXpkcBy5NYQEiaSXSOanM8VWHFiLBhK?=
 =?us-ascii?Q?MypUpyZyPg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19823417-84c7-4837-5942-08de8a750d6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:47:27.5884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEJyxiO35LkXSrA+BhCsybvCpDg0LkAVV353R4xfa7HHKY9jS8zO1iyOcd6WYeGSm1M5YkFVAOx1exGXJO9IBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10482
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271571-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: E1C85326750
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 01:50:39PM +0200, Ioana Ciornei wrote:
> Take advantage of all the newly added MAC counters available through the
> MC API and export them through the standard statistics structures -
> rmon, eth-ctrl, eth-mac and pause.
> 
> A new version based feature is added into dpaa2-mac -
> DPAA2_MAC_FEATURE_STANDARD_STATS - and based on the two memory zones
> needed for gathering the MAC counters are setup for each statistics
> group.
> 
> The dpmac_counter structure is extended with a new field - size_t offset
> - which is being used to instruct the dpaa2_mac_transfer_stats()
> function where exactly to store a counter value inside the standard
> statistics structure.
> 
> The newly added support is used both in the dpaa2-eth driver as well as
> the dpaa2-switch one.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v5:
> - use DPMAC_CNT_ING_UNDERSIZED for the rmon etherStatsUndersizePkts
>   counter
> Changes in v4:
> - add dma_sync_single_for_device before calling the MC API
> Changes in v3:
> - reduce the number of lines that have more than 80 chars
> Changes in v2:
> - none
> 
>  .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  |  61 ++++-
>  .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 214 ++++++++++++++++++
>  .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  17 ++
>  .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  48 +++-
>  4 files changed, 338 insertions(+), 2 deletions(-)
> 

(...)

> +static const struct dpmac_counter dpaa2_mac_rmon_stats[] = {
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_64, hist[0]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_127, hist[1]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_255, hist[2]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_511, hist[3]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_1023, hist[4]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_1518, hist[5]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_1519_MAX, hist[6]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_64, hist_tx[0]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_127, hist_tx[1]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_255, hist_tx[2]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_511, hist_tx[3]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_1023, hist_tx[4]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_1518, hist_tx[5]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_1519_MAX, hist_tx[6]),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_UNDERSIZED, undersize_pkts),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_OVERSIZED, oversize_pkts),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAG, fragments),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_JABBER, jabbers),
> +};

The AI still gives here the following feedback:

	According to RFC 2819, the etherStatsUndersizePkts counter tracks the
	number of undersized packets received. Should this map to an ingress
	counter rather than the egress counter DPMAC_CNT_EGR_UNDERSIZED used
	here?

	Jakub Kicinski raised this concern in v4 review (Fri, 20 Mar 2026):
	https://lore.kernel.org/netdev/20260320191943.2325cf38@kernel.org/

As it can be seen above, in v5 I changed the counter used to be the one
for the ingress side. This is not an issue, from my point of view.

(...)

>  const struct ethtool_ops dpaa2_switch_port_ethtool_ops = {
>  	.get_drvinfo		= dpaa2_switch_get_drvinfo,
>  	.get_link		= ethtool_op_get_link,
> @@ -218,4 +261,7 @@ const struct ethtool_ops dpaa2_switch_port_ethtool_ops = {
>  	.get_strings		= dpaa2_switch_ethtool_get_strings,
>  	.get_ethtool_stats	= dpaa2_switch_ethtool_get_stats,
>  	.get_sset_count		= dpaa2_switch_ethtool_get_sset_count,
> +	.get_rmon_stats		= dpaa2_switch_get_rmon_stats,
> +	.get_eth_ctrl_stats	= dpaa2_switch_get_ctrl_stats,
> +	.get_eth_mac_stats	= dpaa2_switch_get_eth_mac_stats,
>  };

I know that the AI complains about the lack of the .get_pause_stats()
callback in the dpaa2-switch driver and the fact that memory is
alocated for the pause statistics is not actually used.

Since the dpaa2-switch does not currently expose pause configuration, I
also didn't expose the pause statistics. I also didn't want to pollute
this set by adding more unrelated changes to the dpaa2-switch. Hope
that's ok.

Ioana

