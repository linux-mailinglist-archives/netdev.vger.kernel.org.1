Return-Path: <netdev+bounces-269890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NLqDKkuvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:25:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC272D9807
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F741301A428
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E105372EDC;
	Fri, 20 Mar 2026 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mokOOiGM"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB252E9730;
	Fri, 20 Mar 2026 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005915; cv=fail; b=kewxvAoaenhMCB4MMjVy/HO3XkBvMlsUrp6wKImw2qfF7/hCYwAqxFvQ1P4fh9gjGOPOS0WQWEcg1YIp/IYQAHhkS0aFK/szPZlQFLCIwtnznZk5JKtEzaaJQ2zSIEa47NVDaqjIden5myNH7+YnU7joiudhIypvZBL+7AroFE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005915; c=relaxed/simple;
	bh=EIoS+bISZNCh7kFx0cVuY8tl/c3eoSW7mFAUI9snk3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X53MECXRSsLltwMXvcxwCc3+4FOrGiGoufwwfbMyWtDXQlDdNByz8tcGlS78Y3kIicgilSjbuVgiuGQ9k2/3Dkk44qxlBIjeIOqBmqMWz4JBbGWHLkEuy8iw7ONB77rd2nNphSSstrkwOqjIjJp/5caaceiMZrpLqryZ9VfWWAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mokOOiGM; arc=fail smtp.client-ip=52.101.84.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIceJKGAaWmI17pY6W9FPXZPsruigORdBW+EgULqUcNEGNjv2AcMimp6FrIKchuzcK76Efr1+aRrIpN8dN1VByuIOV2kEHedmYWgIXnshbfrMadqCywB/A9YyXLaBBC8BPMV0kzdseJiF6kPC00sKym0FhYcerzWsOVK5NR8vsLUzIr069/4TW5CSXXy6D6ZsvvZ99cvvo3uVq09Q8GtUM/u5r1X1upXqE2ap8101wdrRakX65u1XGC59/IWMvLzIsprnezrSznO0eInQXb78k3gYXB7aNupW65nhaoieNEdVgwVyjPKVCmENHMQ3u9LI+fGq+oVmsKLkTX/4x3gmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUFZQLRPIcWlkWC2+sWo3+U0YcDZIFtL6p7FlMC1JxI=;
 b=uj8aFuD1xPgkK/htSk9ahIqg3YCB9Clc8TlASpDrDm8WpNKuEewl3gdLjJG1dx7O4lKSWV0x1zAmDY84pLaAhumWEBqB9ggNpBvW0uMKxd/eXFmq9OKf4LWdmcb35F5jRElqbzi95EN21mkR6j5RFNl+zUls2UQTzu28pYHfCyjmFqTpVZfTyCdPBPO0DUZDBh+tQrmQ+9b92IfUbSov5g2YVrjCKb1jCyYnoGVxc2CgBP1FlDC5FhJodSoqTbL9kBgL/8uk2R4MpMqG1RoOlD7VAyFdvrCsvdQB06nHEDeFj6LSSmASqIsTXiOhMdJuzhJgobiis+Vrxk8ZYkDn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUFZQLRPIcWlkWC2+sWo3+U0YcDZIFtL6p7FlMC1JxI=;
 b=mokOOiGMeV45HVTMzqpEqUFtBWnKdfLUv4702onrGQTyO9/8fyfHHo4kGnbyWvFdKolWic5usv9mPs4O07Fh0nmgRnE/N2FQJvN68UiXHEaMIc/sGMJ7CEH96Qz5cIZTZLfd3q4kVLXQu7+ktxcZ3tIbr0iKBjxAw6xhIZl0fHDToq+WIyXVpxc6UlZGCx827fPIvXY/wc3MVPLICGcRTbnvheosL2YtRzu5IVtz0ufBoHUDmpDJMsinKY8JHWiHOWOudh9MTaFUoohxw3UyysDN7iFNvPZOPQW+LnBrxEhaFs5c1cGWzc16p12LrN/7ZcdkhfxjSI6GMSuHYxofFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM7PR04MB7191.eurprd04.prod.outlook.com (2603:10a6:20b:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Fri, 20 Mar
 2026 11:25:01 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 11:25:11 +0000
Date: Fri, 20 Mar 2026 13:25:07 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, willemb@google.com
Subject: Re: [PATCH net-next v3 1/9] selftests: forwarding: extend
 ethtool_std_stats_get with pause statistics
Message-ID: <aaezxb75dtazcjjorf6aarzcgsg6nr3nxld7dm4ptmtisdvt35@6xrsyn4cwz3t>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-2-ioana.ciornei@nxp.com>
 <87tsua9276.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsua9276.fsf@nvidia.com>
X-ClientProxiedBy: FR4P281CA0418.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::13) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM7PR04MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6b36fe-122d-45b0-3daf-08de86735961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|19092799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1CccpPaOhfiiPT6YneocxlD7a3ZHOooc6tJtcVnfIQkdJwUhnxegiBK1kffJyp62u1LB/SM+LIk6YhbrTDhM9R0xoo8smrAWsK19lxZv0+PNksQq2eNNYs2sJ1vvDgVQNFcq0rrTVV3egrrF6o8Gwe+wEh4VJxC8ovwDG+QwkorbZ+YIehQcaMaXTKwXJNSh5gq9lbx9DvR60ECgYcmkuPq9cRoovvVbpeyrw0KtVQRUtwktjUqWwCT7EjEtHHRSrmpDh8pa0hVqQl65iM7lEB0D+gjc3OCmpW5moUXWxGa6w0cJ0Y+KGswHoAgwcqb3yn14J261l5iRT/647xcJ+Lv7X2cBKxow0epqY9/rfd2STtvba5cPWzwXRXSIRhsAmcd3NZ4NrNlSA664zxGGZtcDPxfZwaQDUk9ZCf+9ayshXuwiw5nW9XtiCHC4+YS2iS8E3i8DepN9SibTesXRGlGxHFScxJrBFZNfnipSMaxeM3mDRyW36KK+sJ2ZnLuubNPUQP0rFEIKbXcHhml9sJHKUp5Vgnh/R7LJntdMiZDGTjRVet1aMA9CG+pNDTAbPgKX+/9yptpgAGRugsh1UUz2s650dJa8POVEoiZZZVi8+XrFPETScDEUNUXV0WGPxY4y1P60Kk5fBRIJWIP8Q2q2WC16juOWnepPtw+9jmCv7epUxfqAvRD3wqDFjyOZtsTOVHzdQ/Arw8uXEElgOmNuJL7UqjIZSO+1Tr0GhL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eK50JaOskj5hqPHIGF45szZS6ITRz1bN6f3ZkUwWH89sTWRFMCcYUKTLjaQF?=
 =?us-ascii?Q?K1sf8OG4wac4+xAZUn3Ayoe2i44AdIKDMGy03e88W9yPnBydx7dIhpD5QcTF?=
 =?us-ascii?Q?cFrAGLJmfMsXQ4CoMGflv7LVKuIcTw6Khyir112YHIUkNQUL2k2idk3F34gl?=
 =?us-ascii?Q?0byzSp4tOBXY7VZy3ZmHs0Ghc+zkXVw4m9gVXUJb8y5Dnn2qxgib7PxF1VJh?=
 =?us-ascii?Q?3692YoueE5Fhr7g5GcO0SIekf/e+1Qqp0d6T46ZPuysxG8qD8XiU0gIMio02?=
 =?us-ascii?Q?YMEOuywhSdG6Ayc2ESjPaE05rYNpJjDqVm8xQ9GesEeKhYaEeVU5c+DYyeBS?=
 =?us-ascii?Q?LEC9Vqj4yrt4PnRgaPkclnkHAphM/qPRLFfSgskb0xIwuZWoUDG+IvpGeT9f?=
 =?us-ascii?Q?kp/a/Ku3w0M1lxt8GaC2jfwT3vkCvW6y4RbjybUY9NCxWPGF/E48BKQelksl?=
 =?us-ascii?Q?zqQCHgSttcbPM9gGgojovIyD6rWLJcB7I+jO7YwoWTgRgeiT4ghkJ4EXwoAA?=
 =?us-ascii?Q?x2//JFAxGZYVq3s0LGuMDyjzl3DE2zp01zZcS04lTND/pbI9cNpCASro/r64?=
 =?us-ascii?Q?nawHvM9RWf8qOWZPrd152ZOoY3u22LnY9huOZenzhqlNVb3QpI6tqwfXff5I?=
 =?us-ascii?Q?IywI01QAe2i4EthhbQhriGS08SmZ9BciJDXNwgPcaInHXncILe5sa3pMtxJh?=
 =?us-ascii?Q?gYrJg7FB+QcbifGOmttAgcAlc+gHE2c8QMSkXFBHd/yyuLKfYQHUynu32wDd?=
 =?us-ascii?Q?Jw2UC9XN/MDQzV0D2E7TfpCP8pAg2yId1BwZIcsSyqA+W1xgrM+8fkG5LXUl?=
 =?us-ascii?Q?8OBh/YS4aM6uUoiu5UP/phoidPO7iDxqNGy0TS5iQH49dYHVJRDMbZbfDcGl?=
 =?us-ascii?Q?Tu0EBXCYgSREiX98wKqchS0LNFv9Ov2Cwf5cK3UQdXkE6Z30OWE6Z4bIZBtr?=
 =?us-ascii?Q?bgGCmPP2CBzjH5hfzSjz7ekbjjoTwXuQxhNuOMiMN6TP3kL2xMCrhDFOFwJg?=
 =?us-ascii?Q?PLj5OY/r53Yp3wunOZbhLYfLIjKqvPLR2/UnVoQSiP9bfpuD6TlEbcr5meu9?=
 =?us-ascii?Q?Jhy73a1z40USinu1bT6CNvfoncuRa8cxgy9JP+TwHO7SCoL9JycYjmGZx9Uq?=
 =?us-ascii?Q?9x1UPI68/ksX9EL9mGE/JyfrS9RA8m31j+8MtPQMFGg8a/dwn3uh4uEfM8yX?=
 =?us-ascii?Q?RFoU61dF1LHRw3JXmuh07SBw/jSALh6eN/gJuFNL9p7dmvDi3ha/sKtKhZNm?=
 =?us-ascii?Q?rIpd/L5AvjpXjl/01N48c1fXAz1gK6KayhbA3gBr7Q1DqGoMmF7uL8AuS56M?=
 =?us-ascii?Q?Ky+OBzEoamDGOfEsjojKESaUXAyl9EDFlpPZBGP/fwVhmrVuUYBTpR18SZNz?=
 =?us-ascii?Q?qXqr+ycxRTLXrEpqS40Cez+kuTEZZSf4ztIKc6S6HKvB/6U6TAxj5p4XiCLI?=
 =?us-ascii?Q?RU+6y4fEYSkKdptDWnrko1hUOSwHfUpZXHYtnUYZHy5piyAthCeVX7vzqqej?=
 =?us-ascii?Q?oYSKgAoAWrY+nCssr5zRypa3/qKNVoSN+jAX9oAO8QpPI58nltTtJVnwrqm0?=
 =?us-ascii?Q?bPATAwW6vptphhcnmfzANUOYGy2TxCVIcQZojMtuqRR5hvgj1p1JzzPkjL5U?=
 =?us-ascii?Q?oHbWXEfGR1bLRaqWlgWDpL96psRiWdw+fxKxUyzpCOwtvOQ58dOYQwyEcNlI?=
 =?us-ascii?Q?5MiAPIkP+xwNhIDpWjAVF4S1Dc10rGm6rnm79sCkkJUkkMvdtSANaP40zjC9?=
 =?us-ascii?Q?ZsYp5jC3Fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6b36fe-122d-45b0-3daf-08de86735961
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:25:11.6784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oW5V4zp1sw7pnsB+IC6l9PcqWQq4mI5fhoCVBHNqEKFRIjw0GRkyxULi24X5BeOdQakN/jIlZizveh9sc+liBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7191
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
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269890-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9FC272D9807
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:20:01PM +0100, Petr Machata wrote:
> 
> Ioana Ciornei <ioana.ciornei@nxp.com> writes:
> 
> > Even though pause frame statistics are not exported through the same
> > ethtool command, there is no point in adding another helper just for
> > them. Extent the ethtool_std_stats_get() function so that we are able to
> > interrogate using the same helper all the standard statistics.
> >
> > And since we are touching the else case, convert that as well to the jq
> > --arg form in order to be easier to read.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> > Changes in v3:
> > - none
> > Changes in v2:
> > - convert jq to the --arg usage form
> >
> >  tools/testing/selftests/net/forwarding/lib.sh | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > index a9034f0bb58b..cf40cb766c68 100644
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -831,8 +831,12 @@ ethtool_std_stats_get()
> >  	local name=$1; shift
> >  	local src=$1; shift
> >  
> > -	ethtool --json -S $dev --groups $grp -- --src $src | \
> > -		jq '.[]."'"$grp"'"."'$name'"'
> > +	if [[ "$grp" == "pause" ]]; then
> > +		ethtool -I --json -a "$dev" | jq --arg name "$name" '.[].statistics[$name]'
> 
> I missed this overlong line. Fold it, please. The R-b applies with this change.

Ok. Will fold it.
I also realised that I should have passed --src "$src" to this ethtool
call.

