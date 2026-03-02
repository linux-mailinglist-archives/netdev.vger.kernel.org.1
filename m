Return-Path: <netdev+bounces-262659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOEaGRyZpWnxEgYAu9opvQ
	(envelope-from <netdev+bounces-262659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:05:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B781DA589
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0052230333BD
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD83FD127;
	Mon,  2 Mar 2026 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jlEIRmNR"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011064.outbound.protection.outlook.com [40.107.130.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF133FB06D;
	Mon,  2 Mar 2026 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459876; cv=fail; b=YW78CKPisvi6l2Zta2n185xEE9B/Hm75XzgqG7Gj/c/EBDJV8YoKxVCyl9kyxrIr5nVA+5yTKLuusx4D0q5JCmHP7/nnwPdS4h4veTBu8QP2hr9a9M8mv5klz3LeJ/A+hIjnLjUJ23OCEjWsT06+U9KIsN6AgKg/LH31m1H4wxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459876; c=relaxed/simple;
	bh=Nf2cfuflraSPIPWDRaG8yomviMw3yiH6Fz8wRGC+lXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JL1ZyPqtwfgjQgZuYMOY0qENcfFMYqsZ2ATE2RMVB2sseiK3ljspxSF2jjiG/82vOq5lVngCz+/cS5y+TUEb/HaINy4tRtU1KQosW39jPUffanx+sYeb5Hf5M5TmB00dZ9M+ipauL8WMoqIkLOr3N5imGa4UHQhXBO14rq7ynXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jlEIRmNR; arc=fail smtp.client-ip=40.107.130.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjrLvzIFLnM7TMGdfbMUXLeq4p2Qvogn0cfSaGdpFrOgTtvXwgL08ivk3C3SKk7X8i9wILUWZ7XzB8lv4UF/MXoFutfe3c30BuTg2PVUX72dCoI8TNlhtBXBX1woLFmD3DKBdKpRzp1isjTiIY75XKIBofNKvJP9I3HPXm9Wi+npQyRiO7egutagj9l4+Q1P7HaPKcpOUjao8eDwxNg01AUtYjU+PdtRAiFO4XkMxxhR2jpDUnbOIBTnaKhRvPxT9GQJ+5Xzs1G/M0ZfrAREgriGuOGiuutE2ymVedabshGHQf6rSOEi48QhUkKtjjXjA/EdcOCcljAYqCSIWQPE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlXtyCiom48NqFKtbi26x96U3DdRQOGW3HSKTZgaVIw=;
 b=XoX4eMC/1kGnmONT9MMVK19SLYmx6tWBXgzngSIz3SjEwGZV7V8nhFFX6B1Iu2dbRqOHJyQcwnJXYbcnUn4IMFeAcXqL2adPSbxLqys+jcvMSLi0S0ZUWDQ4PFJpq+jw7PnxROiL1aEEp+9Zr8YvOi0PtK/jkAjU3cxtDSyreIUYpcT8yMfXwernrza5m4PKR6mAvHyYrR/6t7vG0rbf+4VYqbT3r1/zjSWxdo1d6dkbQsBTvCiLzgeg0UMCz0IercMsntRa1RqfIGoQhFsj0U5ebX6jcji0/GfKeSqor44TLb8sI8deY0KgSM1zL0pgga0MZXVQtJXwVCrJ0XA2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlXtyCiom48NqFKtbi26x96U3DdRQOGW3HSKTZgaVIw=;
 b=jlEIRmNRqgddU+uzLTcf7LSHFV7XADXDe4TC7k3W1SZFgPzdBZ+gEH7+vYuSxSYcC9ob5TKzBtmv4mwLtOyGB3EwDWW6FLJzWU/rpwD+JuHoV3Gnr01m5lyVoDrH+nXiwkjbyw5+3HauU8ZE8cwcTBfkMsKkAqpQF2XXzj15ZKkF/3Sh8P5gqLfKfHOWdzWErhEs5hVrBkokmET/R9fH5EPPY5AHBRXOBtOskEyxWqw0e6GkTAh4u2SLFs5pRMft3OJ95RdaF+z45JMsD/ZgUw89AgJb4T25HrVDKUW6Vweyf9cvwb1I6zHTjsMJU8ORJ9wliW+tiEpab9SspMhppQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DB9PR04MB9556.eurprd04.prod.outlook.com (2603:10a6:10:304::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 13:57:51 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 13:57:51 +0000
Date: Mon, 2 Mar 2026 15:57:47 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] selftests: forwarding: extend
 ethtool_std_stats_get with pause statistics
Message-ID: <ffbxeysgshogwmtraatgh6vtrwo742fpzbgaiyjnmqwxxbzzua@mhsfkhmuiu45>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-5-ioana.ciornei@nxp.com>
 <87bjhaf7d6.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjhaf7d6.fsf@nvidia.com>
X-ClientProxiedBy: AS4P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::27) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DB9PR04MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c41c88-dfd1-41e3-edcc-08de7863b1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	J/zPIoqCL8qCnA1TSKAjG5aB2ze8EMnPM+cJ8NAUhisz86ZzAQRv6rZL2ZwbHhHcUrmv07i/qZukBH3o+l//sS6FhS4owWwHTSC2sPP+3KoPi7Hwvw8DEdTTcm+RrXYn49PYlBCXOqcmk+MmUsB5gjUBpvyvSNYL/0w/SihZBNCQHy1ydrGHHQHguRVWmZXSAMtCEXLTVWTQ+5Mw9NTulXGlAFZTE7smbhXk1PsqsTbO8F5A0YM37ZYl5w7kBjW7NmXFizIMbYp6HeZLY4PtOJc0XrIf0PebKMH9swHVv+lad3bx4QdAlsqiHvyO/xiQ1/AJcm2ZEByTqzjNqn2n8G682xYMBB8GDrXyzfo/tyCJsyOOCZWSuQ6PxzecgrTWMXoxBbfAxKzhIIrzrRSkfwL36UlLbW5Ylse7iHRVXXltQ2yWDGC89Tfl9wwk3ce9Q8xCRXrKrqgx3FJiPB18NanIhBsK22N2zxD/JTEEMrVNVu3cGURreZpbmEg1yTxKUzp6u/9/pLX/jyyrLVp1tvtewAq3Ae2FcGBaiktkckC6gEPJrLT9VUHNL12TfhwpfM/XvWkQpm0gUESfhwz9MrWRGjL3Rr52CZ/vBxsLvFdeFhcPU5ktVsBFDsGV3AabChWVdD1QUn+EAy4kgXj66VUD0leAoqWXxfcWGQxdMjlCOZFTGMRqZusprwyHmZWsV9xyghFLxoyJWALLoAxe/yDOvUrKBPaofFYAD3iONTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ir+QtTHybQJlv+7eYE/cKOf1tBLWPny1cM8Ud9sWyB2cUdEj9G1e5ECZQjQM?=
 =?us-ascii?Q?PGnSiUPTEjEv2HMTIk48sYSUZFfhBa/PlKMN2NLihYHP3BxlkzAlqxnwf0oo?=
 =?us-ascii?Q?M8uuRJx8AvnDWuqCsTjyKhqpOT9JF1S7C/CmDHMO39L0PcyY2PQO7cixacUs?=
 =?us-ascii?Q?sAmThuAG5MG0Ggo/lMlC6ZwVk9BPAmqgzbfpTb3SBsDxteY54eht8oybftq9?=
 =?us-ascii?Q?hj6m+6XjmetfL73Qx+A2dgsSa8RxTpudQwrWQra0DNCB5wgucvAncOtGWSkm?=
 =?us-ascii?Q?pGmdLfwXtIIr+EtegCyjazjJM65mHLIQO9F/3yZqjtEe/N3NqzlF4+ry6iri?=
 =?us-ascii?Q?qpr2TS1kQa9nJvnb2o5QOBDWmmq5Rl8VTxOowVH/b/BEo0YveeYGzospy9rk?=
 =?us-ascii?Q?qdGizHossnxwp01Aow5mEsoffU7VGQSVK9CAQvcsnzPHJijqdo6TbJ6cgsxq?=
 =?us-ascii?Q?IY/Kxjs5EMi54xQ7eDAWdbYD56LdVueOUh0K9uEnO/xl2BA6FLOJmxjfB/5j?=
 =?us-ascii?Q?+n7eVqrITHQ2Ael9uhNlrohZgukVXvh/dEX1kYJlJnLBV3f0IpdQEpNVqZEg?=
 =?us-ascii?Q?nm6mxAmb4O0S7YBnpVtVVmwNQZTrInf/DezkMQYpiB/Ao6YiwZYJFtQdwof3?=
 =?us-ascii?Q?NOzEkADx4Z+Zo4O34ylKv3XmAchWeJ4CKXF4Gc/kLz1LTG2tIJnn7HMR3PpJ?=
 =?us-ascii?Q?4MCdSBJPiEQ7saLA57gbV59ls3+WU8mnUYpgwfKwhPnzhCeO6izd+e4i22Gg?=
 =?us-ascii?Q?tN7hQ0BotgBNTnz282iUO7akN1rq5QVInkev2VCb4Ntag62rDjGSxBs1obmr?=
 =?us-ascii?Q?Dbh5cJCoTpWHO8WE5xku4lRH14S7SegcJOWLR0Wz8Zlql1eEV9babUhTNZaX?=
 =?us-ascii?Q?hMeywa76Cgh32DyThtM8He7U0r5hOFh45sjOls32zrIl7s0TqWavnyLnYWkK?=
 =?us-ascii?Q?c4xqPIQGg8exqNQqlwgREZjkx+bqkUYuyvcMligmf/is9SmGEOlUAMtK2QQA?=
 =?us-ascii?Q?HqMlCXv6Z1AbBNW4j3J28TgrGH8Cpc0MiSrRP9KoSL3hjJSHur+QXn4S4npC?=
 =?us-ascii?Q?5eqcUrnxaJ2FglXwiJ7CoiHl+AP3On1N4pkFBOUxelYnzdxir/169akUsc+n?=
 =?us-ascii?Q?CSJDusSFWxZpk9lW8yrAC6TSQDtedVsdLeT3Oii8jOtl62RFUtB7n1ZmeBAW?=
 =?us-ascii?Q?zAn6RZIXkosG/fPMljYFfk4XKYUO93o82PuvBoxu1/BKF2FlNvDcwj2QmPEq?=
 =?us-ascii?Q?rkdYeXeNC0lGCSkVYaBXCPFd3kOVWGiGaBOxQBPEaxIt0jxX8N8LrrSVNoLj?=
 =?us-ascii?Q?LEHBmsjJBEcsNnahziZ2m7mJ+hHhOFcpJ3DtSjBWDn35EankMyBgOZu2abzw?=
 =?us-ascii?Q?TkONth706JO0gy8mtEetRQhQZMI8Fma+RaodkEnPn7+OFhVLflGPFp5PS1VZ?=
 =?us-ascii?Q?pSjtIluroq1E+/HFFGBRLStgxkqAEoJlnX2jZBdkUmcffslJwgapZBNf1gEi?=
 =?us-ascii?Q?RURSZpzEyFIm6+eWf5c+9aDSMgPkMq8vZs5QqkmY5Mj2lbxIPR1SV8N0Btsp?=
 =?us-ascii?Q?rxE9l3COk71s22QXiqLVeHBoKVJ8ow6ggJ4xyZUikwj0X137HG5eHgjGKq0T?=
 =?us-ascii?Q?7M6YJHJ5J3uuUxRDdLTy+e8PlzFacj3vzSivMCKMxlpWadaSBZ7QF+Q44Iu5?=
 =?us-ascii?Q?vZoUTxyI7jiJp7+bwxqU1hTd9O10O/GMPhW/Ersw2tY4/4Iy5kdM2srO5ctD?=
 =?us-ascii?Q?pK3MwJOnpg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c41c88-dfd1-41e3-edcc-08de7863b1dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:57:51.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qb3ukmKf4rg2R/80hrWEP4ZhRBWn19w7P3XuLIiwTLDsGrVIdNNNhhEpK5XU0AuZH0sK2DgloKH2NV41OO+6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9556
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262659-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: D8B781DA589
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 05:38:40PM +0100, Petr Machata wrote:
> 
> Ioana Ciornei <ioana.ciornei@nxp.com> writes:
> 
> > Even though pause frame statistics are not exported through the same
> > ethtool command, there is no point in adding another helper just for
> > them. Extent the ethtool_std_stats_get() function so that we are able to
> > interrogate using the same helper all the standard statistics.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  tools/testing/selftests/net/forwarding/lib.sh | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > index a9034f0bb58b..efd236ae1c28 100644
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -831,8 +831,12 @@ ethtool_std_stats_get()
> >  	local name=$1; shift
> >  	local src=$1; shift
> >  
> > -	ethtool --json -S $dev --groups $grp -- --src $src | \
> > -		jq '.[]."'"$grp"'"."'$name'"'
> > +	if [[ "$grp" == "pause" ]]; then
> > +		ethtool -I --json -a $dev | jq '.[].statistics.'$name
> 
> I think name needs to be quoted here? In fact, unless the pause group is
> highly unlikely to ever get a key that contains a dash,

I would expect that the pause group is pretty much set and will not get
new counters but, sure, I can add the quotes just to be on the safe
side.

> it should either
> be quoted in the horrible way the else branch does it, or do this much
> more readable thing instead:
> 
>         jq --arg name "$name" '.[].statistics[$name]'
> 

Thanks! Wasn't aware of this type of jq variable usage but indeed it
looks better.

> > +	else
> > +		ethtool --json -S $dev --groups $grp -- --src $src | \
> 
> Since you are touching this line -- can you fix the missing quoting,
> please?

Sure, I will add them.

> 
> > +			jq '.[]."'"$grp"'"."'$name'"'

And I think $name above needs double quoting as well.

Ioana

