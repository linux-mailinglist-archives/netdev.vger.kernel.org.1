Return-Path: <netdev+bounces-274456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEnNJ6NDzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:23:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0195F387A94
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07409300BC87
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5E93A6EE7;
	Thu,  2 Apr 2026 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lsflcwyc"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8CC3191BB;
	Thu,  2 Apr 2026 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125132; cv=fail; b=DVUYBeUeUCakdXimF7gyLQC/ABmtMzTpN5tLN12bsNHY0E1ADnOS2nWiCLD02olLtKHqm0rxSg7xz8qkqIDDsXEovy6TW1Q3J1gcWh4wFyroFzcyrvkrxnTviiVLem6/5lr7NgDpVoJbnkP0peWorIh1CYIUdzE8YslFX51lCjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125132; c=relaxed/simple;
	bh=SHTbRDa6A9jLCJ8WmcfNSSUiUM9RKcfeyrRDzEk/RXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fc8h97OBBdi1dbx5LeTq+zbq4+pyj35Gp6dEytZxBcmmJqT+OCiZcd4EiIFLT2TYzrX5GngVUqY4DmcS5q41gB/Ps46tnijNaP2hzs9tS4+WfTgHaPm+FviMFYbGoOsVbARtNVDJamkUVMA3ncs2SaXqO3EyTAqX+zbDb9T9FdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lsflcwyc; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXIpo95XM9sKJoQd3xOh1n6Gesn6sQYPd7Lnsf7wqMGZVQoGsr8ixK4nWZRQsv2YHU+0UR1/Vcx+k0WG5xbUbOTgI6FZS3GhB8vPf1Eh+Bau9eUoxgaYwgC0BwPvqUzIqu6svQB4oNl5gFyeVjXds4VAR3exKnuIFrTmfGrZvYi/t1u9Ap1fIKSC93vy9hQLOW5nUE276LmL2KFGGYY3KyXEHjThr2EMBJzFn5D6n5HjqiozgwGzBtnP/V2amMvhT4hcl7sTfLoNWbg9xrJ0FUE1YsU8zNbn0VWaII7q+w486XIg/Ckj4Tb3k7vlU0XPicElgxtTRSciv1JRUcX2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MT8TqbOLWh5WLpr2ltVBkjJdJk+C9SOgyhrqvhsJa40=;
 b=B3vOWDeFZrTRkhTcASWQh4d8fmU4QELuPRMulvKwsPFuAy/JcU9NDI0tCF75sxUAe6KbRkGnMsXT2YcWqAOERA8jD02InUoaX+OgZenZWuGpeh1/uhes+ccvGutzFKBS9KcweCMDy7/9k56/ufwaB6ZgESFb8qGLt+gLjbrwMFdJNNVttqpUJgI44QdOYdkuMa//IOJXc6KK6nWJlDd25t68iD0POuMqXSrLxDdRhoLzI35oFXVhI2w3kshWntGR5fJ5qJnfdEgtS0NfjY/vIcPP5aSAtS76/4Pg4EfyLgERFmPnD3l4YwNtOsowbtKxOKnBgHPW8TSc29xkCxfK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT8TqbOLWh5WLpr2ltVBkjJdJk+C9SOgyhrqvhsJa40=;
 b=LsflcwycybiAPpfQDV2TqjyfDmYY47kJAPA9p6gTX0kKdNvK4SKi95JNUd3HZ5URVw3uwdA4usFhJp3j00O8XoNTB0ebmzd6cls7GCfytXbfy+0izUkZN0O3wTZqd9EzBhEDUOIV9NkiefggzG1N52/TFzjnpOppFb6/r8NjBVnz9obAaCq8f4UVjZa82hWhs7VKshFNVHmpvVzm8YoJN4e5fbQ1eqXz1vurCDpGfyZ3eVCaSQNO9mswhaWy0t+kFHHx8T27BHWkWZbCLBTQHHq20qwdgqUoJZsOdDdSVv+KPbSusHBPTYQ0ZynV1jtE7fFH/VORwk1Qc+81m95BbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS8PR04MB9207.eurprd04.prod.outlook.com (2603:10a6:20b:44e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 10:18:48 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 10:18:48 +0000
Date: Thu, 2 Apr 2026 13:18:44 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	petrm@nvidia.com, willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 7/9] selftests: drivers: hw: move to KTAP
 output
Message-ID: <vp4rs7xouynftjwck3cvet26hbdxzi22nr3xdr7ynfi64rmbcj@se3hdxhudpp6>
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
 <20260330152933.2195885-8-ioana.ciornei@nxp.com>
 <5b7faeab-77b5-4a3c-a717-5a80f5e76a31@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7faeab-77b5-4a3c-a717-5a80f5e76a31@redhat.com>
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS8PR04MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 5311160d-7f63-4c8b-df48-08de90a13a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OqZZbxSbjzZYDNBk4cyS/JATy0OVYp7dAFwU5pmL4ssqQx9kpR6zcSCT8RuN1w1ghnz9t/OVZMhHlxhAZf2U6aOlzuNcIV5H6r8l3+z0oYjAIvZQrYI3VZwxa7Lajl7xpuc4avbUK5F4Mr46WUjr2NyIqJ8y6iUWJf90jiYGtUu2FapWROA1D7ZszYXaGj0xi/4aGTQHSTTRQqhR6LNZ4yh6YJc7OOcNIebXI9sQPh/d8ucXoDYRyxz2qIRyBK6Qk2mcxGDUis8EjoaweLOkO0f0xn4xu626J4yYX5Gn3tMCJ9BNrMCGUo1/hwhKLxLEhnuBLqZTKnI+dgY3+xPBM/JAcRExfTYPCgdzTesMM3t7PY8y7pDujmYuDpXxw0vObevATDVlowsf1EP3rUE0tZOmuK9KaiUq7k794JbYIJvJ9vDM2xj1KwWoIai9NfQSlTm3+43TZm5Kf2iNsFFQ/rzQiQ3Gay13M9+pfUhCPGAkutFUoBrjil+MpM6vkpmLKU8XkS3hbonxRR2UrWh2E/i+236KbU6HuQFMd4yODv6VvuI5ED0IopFTd7eGKxJHXUji6SL0SlnJXEThSGsnVAXJ1E0Ud4r29E8uJHk+n2MUL+nXGGTHMLYCzIGe35ku7hwzLlXjRbg9Bk2+RHvtkp88YYIwGq6cvJo+sm/I6TT0gFsYwvIIK1Apt/X3FvUUNqpjijnPXLHmdE9v5yvdS0kqVW1o2SWjTgM5C93uCFE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZEBJS7MA4Y74JlEoEux70hhh1OglTim7QSqAnCOTGG/eolJcwKyxBvzS7iEe?=
 =?us-ascii?Q?sC6wgeuPIdjVrcHVXABg81JY/BP/j2rxfzW/OqlE497axDXxy0eNKdrtFmU6?=
 =?us-ascii?Q?aGYcaUFZZRyXm+TIBUOlkOOJ5CRj1/GptA6mjy1TYhaosus52XGVNajrEDey?=
 =?us-ascii?Q?ac6wjn0a6ZLzBbmKSNTTHJr4SrsT7lj97hrin7EeyXGUxTnGYgO713AVnfDM?=
 =?us-ascii?Q?bn1O3PHb3ZImI/zPmypxIqEKH+TksA4mBhSIACQoah2HtJNfJzeVrvRwkRm4?=
 =?us-ascii?Q?cAEePOikhSx/1ArUdx+qO7bMoRDkDMYf5GlOC9+JqsGiyZX8LPHRI0/s6Oyr?=
 =?us-ascii?Q?hOKomkMXF447KCnry+4UWLMEmtLimpkTX3PguogH+KYfnCouTikTCKqnYtmo?=
 =?us-ascii?Q?VRWOmWz0XY45XaiaWfQQuK84XHMcznv6QqLke1O8xOGjSGuRfmJZj5KPQsN5?=
 =?us-ascii?Q?AFCsZEGIuGSVoQ9APorJpMbrPoLh8iEmyA/QlWgudEnlB1T2lvjwqiY/s8RS?=
 =?us-ascii?Q?vKtaau+0H/EqfCOIjEsn5JWU8+g4cI5hhbL57rH1mtR3s53xXDJQTE/D+Z2D?=
 =?us-ascii?Q?4N9/91ckQWQRs2yKWEcxFqnQEzThGHZvDeAIaZG9CUKzAjymMtdJiX7WTnr5?=
 =?us-ascii?Q?E5MEr5n4/jl041ysRLfc6qjbVBkx/BdhKIwX4LlWa1R9kIaquPV83HL9+O2G?=
 =?us-ascii?Q?nlqG0ZeyGFgewIWPfUi6EkVmbz6FVxH5vB/ogFJOJD2pC2lpDrVNX0FQMfLY?=
 =?us-ascii?Q?AVqrrw8H3TSPy9DXOfumsA9+/NgWV0CTcf3+CwAhzOGeFUetMaeV9snvScr/?=
 =?us-ascii?Q?aQMHjfgHg8Fr5Tq71XZYOtDzHjIdT+RwzYcD1axPJEoUabQPDBhoIW4xLNsE?=
 =?us-ascii?Q?/3JUA9ZndvaUUsNO4AZXvnc4m2/8OcJSoVUqb5/EEPDW7dayz6F0ipL5XJgW?=
 =?us-ascii?Q?j/1wLvNzJa/6wBdEysQo7OnVAtOwhQvRc5pNpxBm2sTzLqKvWgq0WKApAlcN?=
 =?us-ascii?Q?aWYLNogbkoEw3Zx89bm49/wvAqNt1khiRq0Nyn2LlZSENru0kRkHpLkGU5bQ?=
 =?us-ascii?Q?7QWlXEH/uy6ZXDGPqmaWjPBYQsUEt2Wsk7VTwTzbmtvNc3Ssv9VhKT4/GNwq?=
 =?us-ascii?Q?WSXhmA3qTXN0FXtgnIMdcPn8TkHMf6ucY7RRgzZ/5PAXab2lBBhBY/zcH0fH?=
 =?us-ascii?Q?Z+K+jtDh3a6rULGR8NTdCUVU9gAc7tGNZJR/KoWKVbdcKBBzxM2beWMMZSYw?=
 =?us-ascii?Q?unYYpo3JT1McTuFrtVcuGjBaxWqzwaf6JKe665TPR+M3BJG7cCUvreV1GBsV?=
 =?us-ascii?Q?hj3wHNMGn0Hs9AgwDYnsmBJul+JYIgrmdvUQqkN3JH1kdZIyMrZyCp5IBIsU?=
 =?us-ascii?Q?+PieqY+buMFr5ezd3hbN3uqLmmKdCSvlII3YG4z40fc3A1yetR10D/cg/HID?=
 =?us-ascii?Q?N7k9WusJif0H4EIizVeW+p5R8J23J+tVVXxR06BdHTKhkkWT5RrH7sbiEIhq?=
 =?us-ascii?Q?S3lsjqyZUMRr1AjyF6BHLNYCs9nN/tSQsqEbyCA1NBbeFn/BCupRhzVU7/G6?=
 =?us-ascii?Q?aHyhLEbqoXO6z8J8ZPn9l435+fm14UkHshYxi73ekd7y4+HCpfsA69ZoIz05?=
 =?us-ascii?Q?W29dedX6w4E1MKyDuy+W002eka7tabJ09nnSMqiFla5K4xrEYx5tXaMw1DBG?=
 =?us-ascii?Q?XgqKyNyF/gXPsI7m6NoeRIux1U+8OdCg5qHIYLACqxb6ZJFx3uvQ/lrFvXJ+?=
 =?us-ascii?Q?/hVkXBzYDw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5311160d-7f63-4c8b-df48-08de90a13a97
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:18:48.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0UF5f1CcxmQKyWUMQ2o0b67/WziOrr2UFQRwu6IVE0oGJM71B8ftlol5cq3EIkTQlKRHLbUuUxk1Gf1/LOysA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9207
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
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274456-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0195F387A94
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
> ---
> 
> IMHO this is better handled with a follow-up as opposed to a repost.
> While at that, please also take care of Petr's comment on 2/9.

Sure. I can submit a follow-up with these small fixes.

Thanks,
Ioana

