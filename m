Return-Path: <netdev+bounces-275056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFmeGdjEz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:47:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CBD394AA6
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5660130233C7
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD7E281357;
	Fri,  3 Apr 2026 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JoHz5t9v"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16360282F18;
	Fri,  3 Apr 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224008; cv=fail; b=Z/WsGnIVUyAHr0PyZeuvVuAfqn5wWzemup/ENNVQ6OJu6+DTTM5FzTQjuxdDl8gNnMuPW5v+1YQKoSEnrG/rTZdc8pJt81Si5H72gqENc6Fme0UWxWsKEObeXMaSWHtclm+aKD7Kw5T2XqmtQlLvDshu9TQafQKGonTbLuyicuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224008; c=relaxed/simple;
	bh=Af0lAlbGki6K89aUTvvZ/bel54XT5TR6z26exg9Rmk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=czLCLX3Q5SUZHX3HkVvqP1mugW8H2BOh60bwq/a/ychMJ+22En08bHPCl/l6CFPpp1RXpgO5N+NAv51MMWFi4YSb3hJ700CxzlZDq33840YUTGYS0QBbPOjJpbKI3FcZofbsqCWta339739gJYCpFG9Kc2izwvYrr+72MCkZmng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JoHz5t9v; arc=fail smtp.client-ip=52.101.84.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Skm2G9KzQa53HAv+lqhCckAvqCekvAsERO7RiZniRMPtG9P/73IfQeMps2NrvxofJSDceWMUQEP1yG6G3/s+VvwkVGo7OPoTYKI/k+vbiC3sxnV50bJ2xFDGYvHCV5WVmtWBHb0W2FKvNOVwSuvcCAJVeEh3ttZkdPO+smMgD3TUaNCUlrAc4ls0GBestNVWn6iErQPukPZXSrSCvXbqgs6e/21hchXDlMz1hi1OqrZ+nY3sCF0euUE7QqTYdmWisn5RthaiuKzoxwsVd9ejrnbXoNyXQt24sAI5DAt0zpE4u/e/lvYTqLQ8KS/GEXoYeuJMagBo3ePT/YWfyMBiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ktiv+CWSfOYsBYPa7wXf8t0n9fiafvilTVH23DDiTUE=;
 b=gzPZZvXDPzEakbIN/xcOJp/kn74wGV58qO32aXDnFfm8jbnkMZcfJhiZJnF0RWDoLGISpeT7LmTkTfRkbpkrM0uVKBgBuutVnyvVFXCClRQPkIyX4JP05MldKEjSLKO1zM0UrutU68VUIl51KeH9mM9D6eO5fbHJ8AHDlh1VQTqVvTjQmDnyuCl1+WSxPAD/imCn4DrT7namyWsDaJ4jahXIDgk67BNTS+JlRhOyxeZV5aFkYhEbt20SemPlcVIknCI8RDQwMOu8RnD7Py0wvx+kxd3+YiUwP/EQ4S4y1qJe+FL+lxhU1EccRyAr1r0e5BUFiJXMDNRXO6Kh1LDj3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ktiv+CWSfOYsBYPa7wXf8t0n9fiafvilTVH23DDiTUE=;
 b=JoHz5t9vBf+Z2M2R5oZ2mCqsMQxoAFkhillYbOQxEzVl0VpYJb35YJrB1GvHwr3yTUHmJPj1DCFihTWZay9rg2mNLikS4vWn/yMcjgAhcdSDHN6aDfJi6944QKbt0F9Bhisz4V5OoL1f6NeqkPwKcHue0IfnK51rvsuV7iNOFi07kj7+2/oE4lCei+FBRbvZ9m09tQv7phG5/cXit3Bu3oiRpEyvAQvwPGFU3O/yr+gUcz2XmYuBUtYw3w0byw+K07JsWwYx73yEQU2ma8awAduZGtepWi8Ob1HZvOl3pWoohnx184Lg/zUOmf45Zat8Jm9deArn3kbR8UYAWyCSIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 13:46:43 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 13:46:43 +0000
Date: Fri, 3 Apr 2026 16:46:39 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	petrm@nvidia.com, willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 7/9] selftests: drivers: hw: move to KTAP
 output
Message-ID: <o5ph5xfbyhumdklhf5hamb3bkogumvx5n3hptsufaae2wdozrj@x5aevcvc34c5>
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
 <20260330152933.2195885-8-ioana.ciornei@nxp.com>
 <5b7faeab-77b5-4a3c-a717-5a80f5e76a31@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7faeab-77b5-4a3c-a717-5a80f5e76a31@redhat.com>
X-ClientProxiedBy: FR4P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::6) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS4PR04MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: a4122ff9-2669-4d38-40dc-08de9187708f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OxV5bVh6dEtwJaRV1fKh0XoLMF8qnQfFcQNjKmYR8p7a1v8lcx0a3VRKESKMHr9GDZCpXFnNDYE1o5Fuf/SWsoYc4hkHvBHM5iUaa3+H+LR61+13t2rVN4qqi2++GE+d2ntcOXMECQtsHb+vYit+jqdICIkPOLSoYUTHsTzZQ2SlACiAnyGXdFuoCyWnQBWPaRx/FcycBCxJMdYo2Mqp/3UUEj/gnS5lsvlyjVHN/byYvFOZSz5tKjMvtd8KZafZkqL+gR+Vso6EHaGZ4jDEVKGlywxDigzBUfFw/rrDLm/qRKQxuzJ7NjDDJX5KfWp6bwOXKpX/4xgjCE5aysAdcFEKTl9cxo3TUB8CB1HSn6eB1GASJNt3JdtK8SatTmWZA1F5P1qQXJmClAZZM7jY8nSnGwVYftnbRrNIoI2ahj3+40N7dMYESaAoofbYjgAARTRvVPG99MI7GWs8ZTiGhwm5wexZlFa5Z6miTbnYWSRoO8i6ZIbkOCh/DvjCfWSB+sm3/4W2m4uCDCXuyE2+cYOjbLswZv3sgqXlziDreDkU7j1iyor0FO9aDuyg8w+DCTm2N/hV6ZgYKegb8iSQ5LO1t4HtEZKtMzuiF3HcN6ND+D0JQhSkpVIqX1E8jtfPg5rTIIdE8Z9oc7HTOMD3FHs9djPkfOZyYUXHmAJe/EjYiuylpiUeUTukZ1SdmkA+ZWtBK5uhONT5hZAELLDQrbJ942awbMLg4m2JGYUVA60=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j+vJL8bnEaHy/coBajPFDgdPlVx4LGM86Cf2CgiOGLyHXp3sJy0SlA4k4Jtl?=
 =?us-ascii?Q?FnANmal1SLfYSh97tb3OA7WnO7cDDPGbCtEjoDH7tmO+cdYHTKuB/Er82Lis?=
 =?us-ascii?Q?dua8nWUyS9dXKq16T5dhAuni/LOjEPIGC06NjVrcmcP2BpSkejLcYGRSbm1T?=
 =?us-ascii?Q?z4WfC4FiPRqMu2CbyHmlWNYAPofWgIc1alKkc2x14ReS/nRitwbkFcFPkKFY?=
 =?us-ascii?Q?9G8JGRIX+2dGlrdS3/koDkTpBsYel68yJKAvSQxdrYmEBg22Cc8/DcElX3OI?=
 =?us-ascii?Q?pY5/t84z58nQyJDucA36nIERoah/OMK/TGtLDkKN79uDTd6ktkRQ2kI/Iaan?=
 =?us-ascii?Q?vOupNa3cgJkIkyevGLs7aTgDNG80K2H6NkMTo3Jvcw4z+eCURF9Qaj6hgqTE?=
 =?us-ascii?Q?4z7Oyxlua4KT3nd5NgZsGVatuNLIpOMrZLQhMYdJsje7vZnjeSuMeWKavTT5?=
 =?us-ascii?Q?xQ9GpFTzMmvcvJ9CJqY5M/mHbwnV1Zy/hYiMknM1g07YJoFVb4rMGa15rEsC?=
 =?us-ascii?Q?+x7pu3h7hdmTJk2xDseolT4rEw+tXTfXx0TRqaLnjGIp/GiwEPjV67JaEK5O?=
 =?us-ascii?Q?Wc48RQ3+xny6Xt4y30pgcYJ2BQ/PWCzSlXkjZCf3WLPhru2KHHj2zW42MnsR?=
 =?us-ascii?Q?NNgKtYxkdpsPIglTFPHLUi0rzbLjBaJBaE9E9Vn0/rtkHAEjpKJ5gyARwMwC?=
 =?us-ascii?Q?dqWlTbrRKpQ6aHdV+mgG2FmZn5pyYmF9ExsUz1mVJKNcw0evPELb5nriB8XK?=
 =?us-ascii?Q?zzHrhwLpq9NOLO1+qudc8Bj+EG6NpH881J/1IawLfLQAAUL1pMb0gGRKAxjT?=
 =?us-ascii?Q?7szj3B5VF9nYEEoQy840W5MVsnnVszyYmW7zUHKa714vhZsJx3TSbE4/27Sb?=
 =?us-ascii?Q?EzeeIjVzWB/2vFQyr2lOEUw5FN6JWza1tdiosj6uM80JZ04+ZfEFM32lrj82?=
 =?us-ascii?Q?o5XBozClDbbg+PY6cSnbcTtjlTrhvQaZD7CE3KWMLLopCSNOsmgUwnBAG5zP?=
 =?us-ascii?Q?PSlzlNR4NhF0moWnag5MCVdsHLbANJUt+jmcG9qucjhiLFRNNJUptT6jFs6M?=
 =?us-ascii?Q?G+YAQ7PLeV/flryZkDOje28h/Er6+0ZE3tDcwYeXsmX3CTSg3LmWarJJQOWW?=
 =?us-ascii?Q?7hOf9zuISq98k9hFCnbZHqQgSM/Jq30zzxagJqtdz2m1fS8oSBs1VwF+lJic?=
 =?us-ascii?Q?JKjquzBB+H+TMYKeT2hecopSR/YkxrqRnSXoKPgC0XJyJuwREA+nod61+3ob?=
 =?us-ascii?Q?D1C7TsVEJ6K57GhISaB0d657X473axQE3y9ixI2shiZLSjUkDmR9aF9FPCIZ?=
 =?us-ascii?Q?ipT69vG2sxUF7lMjFNT4/r8D/DpTDQgvX0btmluS/2Fc2WJO4KsnQ8S+B5Vz?=
 =?us-ascii?Q?qsKtCVeSxk5cHfHaS0hqhmkOUCFt+paYkdyYg0F1WFclYwyYX4X1/KsT6XJh?=
 =?us-ascii?Q?ZiIE3auxOSJNC6VmAQJi5rNRhREINSU53wR/VZI4m+YOrkqhWlTWrTTqfVs1?=
 =?us-ascii?Q?GcN8ZmKEZB9U8YIGp0zjST/uc8gd56DekXI9ZfyBhJKSYfffV/KFrmZhSpks?=
 =?us-ascii?Q?3JcI4/he99OT6szPDTX1NWE3sAUzi/qs8G2TJa+nEM29Ss0VxbdRhso0OtcR?=
 =?us-ascii?Q?uvOmwlc/pFY5U8r5M0hlY84EQxIPo9l6rgPbW+bh2KWt9jMTW/5oUy/QhV2b?=
 =?us-ascii?Q?8KPs0FUh8tQf3HCRfrwz18+PWbpIZo4Oi+b9Mox87/QIYiOHKoe5LvBlbspB?=
 =?us-ascii?Q?m6OvzTPPlg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4122ff9-2669-4d38-40dc-08de9187708f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 13:46:43.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdFNqx6RUjzuzfW8kP+ksgq5FjNcvdIukSvn3yPJqoIeRxoBmHkRoeU2zt2hzY2J2rY0AROr7hdvCC3Yfy9F0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9436
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275056-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D4CBD394AA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 12:10:09PM +0200, Paolo Abeni wrote:
> On 3/30/26 5:29 PM, Ioana Ciornei wrote:
> > diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
> > index f290ce1832f1..ed81bdc33536 100755
> > --- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
> > +++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
> > @@ -11,10 +11,12 @@ ALL_TESTS="
> >  NUM_NETIFS=2
> >  lib_dir=$(dirname "$0")
> >  source "$lib_dir"/../../../net/forwarding/lib.sh
> > +source "$lib_dir"/../../../kselftest/ktap_helpers.sh
> 
> AI review noted:
> ---
> Will this test work correctly after installation? The test sources
> ktap_helpers.sh but the file doesn't appear to be included in the
> Makefile's TEST_INCLUDES variable.
> 
> Looking at tools/testing/selftests/drivers/net/hw/Makefile, when
> 'make install' is run, only files listed in TEST_PROGS, TEST_FILES,
> and TEST_INCLUDES are copied to the installation directory. Files
> referenced via 'source' need to be in TEST_INCLUDES to be available
> at runtime.
> 
> Without adding '../../../kselftest/ktap_helpers.sh' to TEST_INCLUDES,
> the test will fail with 'No such file or directory' when run from an
> installed location.

Now that I actually looked at this, I don't think that adding
ktap_helpers.sh in TEST_INCLUDES is actually needed.

tools/testing/selftests/Makefile installs ktap_helpers.sh irrespective
of it being included in any TEST_INCLUDES.

	install: all
	ifdef INSTALL_PATH
		@# Ask all targets to install their files
		mkdir -p $(INSTALL_PATH)/kselftest
		install -m 744 kselftest/module.sh $(INSTALL_PATH)/kselftest/
		install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
		install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
		install -m 744 kselftest/ktap_helpers.sh $(INSTALL_PATH)/kselftest/

I tested this and even if I only install drivers/net/hw I still get
ktap_helpers.sh in the install path.

Ioana

