Return-Path: <netdev+bounces-269909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PMvMLNHvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:12:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 798C42DAC34
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32BE13042615
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2E83B8BC3;
	Fri, 20 Mar 2026 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I9JANnOW"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AEC3B8BC6;
	Fri, 20 Mar 2026 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012331; cv=fail; b=QPHGQpqDc6dPhEMJ8adTRALtvO1caT6NvKY4QR9xiWA5FuP82KCxsA3Zs43c8TmewPU0ywd6qvkEmW4iwDmvVcOa4zYKT7Y6RF3c30sDpO8Fj9ly2/TBJYPs834kb9HypDtVU38evjqLt7R3N6xaY79iYel6unoFNhAZla7t6iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012331; c=relaxed/simple;
	bh=XBN0dnGkJE9XOQrye6Q/Pgje+y8vILERCDnQy+EWySc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RxZVYPHr6A7ZDrjNndas1DHj2lPA4TWWHmDJYou2bnbXDpoQZ6hlCSp+WhiRjpbn0zdircVZZY1zzJDT9mJdcAV4mSorclhdVqZ5j6VV/QCruQO3kEd8GZSaKMDrUaYtGQTnagzRkn74OTarCsiADvu0Mh3K+sK2dXDM0PBMY30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I9JANnOW; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf8ULlO2W2B91Po/04W10su9BUtL/n+cvjLSUn/vtqVEET9YVCA/t9UDAH/FKvqhZc52DZ6AXv21e8ICtyUdNi9RbRtDDVXG+5lqGVwCUJElTox+4E13eIbeaFUbXJ+EFH8+oBjoojd8YYSuxIEzPGkGjnRVXlQieTm64v32DgaDjCc50+UZ/vxWdjT+BRkd1ETiraWYgZNVrk6Pfcktu5DuWelQYTsxQ3xUS3/MXd9bzbYzZapmWZMMKmiJy/ZnTdILxdg1WlBTbkaIrWm0FXxMADvvThdpquhDn7xw0xC4KFcLUr/ys+fGj1L4Tc2XL8fpV/Tvo/hTfqQpw8B/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmHVGxW2UpC16UohjMdD/f5KpFHemQNK+W1kTCt5tQc=;
 b=gM/Ol1zRPv+sRHORWyd7Z+mWCm2Ls2cQTFh6fUc7eEwC+V0Hg1p4X7uDPrJgLDXJ6Q/eXyz71Xla+/DD7TOpi8CLM1KeYwMuuMvp6+FLGBOSBMmc9yyiunJoqDWLHfm9g4aqZBQuz6jJDxnT8jI5uSaKj0PIV7swpF2khPhYXGMpGRmdiHuPwTkA83HYAhE5y3XHV3L2Mu/mllwTQmiaxLDwBA2uLU9+k75jBEJ4v8JtAQXnOmGfSUCSq1dfrJgh+S1DH/iHrxxlVkjwoB48lCcpNlppBYc/UM1tOYfX78BjrnYBDE+EwCzQbSnDDgj9BrtCmbZv/FpYCkG5K+pTPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmHVGxW2UpC16UohjMdD/f5KpFHemQNK+W1kTCt5tQc=;
 b=I9JANnOW5rrPs0kwboZaRgenvryj4TJEEMwVx2YVE4FEJ0Mj3LUNRdM8Yek3HW/zplYRzDg3CNZBJmD2aIYkRc5QUNiivh15LDWPe1aDOFInpJeXlWRDbE/kJnGA+enGDpa1hOkPn9tbzogC4TAu/8seqICNxcnXkeVhKA6+s+43ZAB1puIT4VmaWzw+o6UCXe4beC7nQOG4b+9gvygQ8/CgCusmbSXnGVnYaXghy8A3Rh3C/mf1Jd/AgfllHEze/FQNnY9eqmk6S4gLdbzRRWzxLZgQsnoDlYVQr4BCug745u3Bj99VjQSanhw/XtXwdbKVVsNzdJf1zx1npNdNOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 13:11:56 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 13:12:05 +0000
Date: Fri, 20 Mar 2026 15:12:02 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, willemb@google.com
Subject: Re: [PATCH net-next v3 2/9] selftests: net: add helpers for running
 a command on other targets
Message-ID: <tpycmjloogv5uisvy54nl5k5v222jq272lp4sbsbiq444yrc6x@yf43qc74lag3>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-3-ioana.ciornei@nxp.com>
 <87y0jm92fz.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0jm92fz.fsf@nvidia.com>
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV2PR04MB11799:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b11e94-1288-4e40-cc99-08de86824894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	31XYsWygryolMfuYzsf2EbYvD6akFYaTPO6AJjp3xxrCyrAIRo9tMQif0weEQ6mWxVAXLEKkz7mn/RjAI7uF7yi9/xuNnY9NBq73MxRPFYn/8Qa1kLP5bH0BDIb+p5bVfs4009dGEFNqQQVlq4sYDA5CoDg6gMzVVbOuIRi+KS4HDeoE0n+il4C3nH7p+9ln5NYHcLu7opr+x1Wd/k2dxWxVrVTAg2F07T5zUJ3mbaBd2qdfBcjgKRDbDbJN6c4qEfBvD2f1NFg7tJUoGOMKpdqslmtmelzdIKHHj9hmOKgBuj0DySWfSjwX36GMQAuSiFMPGBjTRsaMrD16Mu0GKuPSUMC7/VU3pMulLI03kBW02r0+SM872P23zemWHkgT0/GqqrWWZtZfytdDotVUCqiVgrNzpsWksal3bwEjHYWavIZ7BvYnqQFLjDOkawUYAjexV6nDh08eKJYup0lTpOteRRDSSNiJC9/Goy0yrADqiFcmYzrsAjm/q+CsXiCVmIZFWrZ6VjTyBZu2/Av0F8aAU88AlTw3SSM/dMnm91AgYcYvgd8vJcsAn0Fi+oDL8nlyGcsTUMhaI1Msf/YjV7fZAylUganw8w1U6eWqjU4PqhciSw7yHVxuJD5um3B8vgGlVSoGrz1mAsQOBPfHs3Xs00dWUiiv1hjL64RU2efcQo5Io9WMzUE/eckmARo527251A1xyfHXf3q5lVyh3rFiClZ3gPjzGEED93Sc3Dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n5zZwSbuAwk8xwAL7Hsf4UO+PPvVLfCwN56sDFuMmNZ4zJeCSUul9DN0Ugro?=
 =?us-ascii?Q?PYcYrWIv9Z29h8t++EaTbrGLPQI3iX3W6qL1NS2eGxniYndnZ+RltNugkRNB?=
 =?us-ascii?Q?Dlgv9p87tbJCluYYP/iVVT9R5+jHJk/5IP5Xlj7yyzPL1eGRjqky5l+llPpp?=
 =?us-ascii?Q?ytcniWO933laFpYbgqbzaJQ1LdNAAJKFBFm0R5RJEC9WimN0EbNJ5aDHdAEX?=
 =?us-ascii?Q?i96MuKDPbcDftn5XPHmgAhRB4V8+iN4UFpCJE+HhIo7MlKBUoNSUT9sqGIor?=
 =?us-ascii?Q?NIifN5gYQGlssYjVQcW7iqlxIkfPBaA/SkgKeQp1SwJ28o30vnp/Fq6RhmCI?=
 =?us-ascii?Q?gkyuToED8WqOOH0xYDxVXUMhB4DXTBQaQq2FlDwC0MKK08T4Dds1COQw3s87?=
 =?us-ascii?Q?QyHrZcSsSg/r5X7uoP2NVWMVo103GwFKYTmWZKdb3DopcTE4adTNS4dmCJds?=
 =?us-ascii?Q?irq+fGorqEpzord0+ORrjaZjnnHFT9hpxWG38UOlxgJ8JSwlwaMLXWQyx5ac?=
 =?us-ascii?Q?d5CfmQ31lqpFNyseFnmUg18GCxskW9CKUHkxh8Xk5D88p/uqDTUCEGDYwmE3?=
 =?us-ascii?Q?sUWufnizMtpJ+9ctj4yCrOdtyAcLu9rwdKQhDcU6u+jHDp6m6rEwE9PQZnsh?=
 =?us-ascii?Q?COf4tjUqhfBRQoeUMW8Wz85EMBl9yMIhXrA1NXNg+k3ZyLt2XJFMsfAhj5gc?=
 =?us-ascii?Q?GSwqSJKhPtUnczEJkp0lh+euDbTyy7CjnhsEufK2AkPnEiq4s3PrvflPPrp3?=
 =?us-ascii?Q?J5df1W386YkdFEP7cfICMwxAP8O5dENKn6kkGNoLkbhNMV06NZDJseq+HuiE?=
 =?us-ascii?Q?owTDJnHy6tPFiRw335pBf7y5ZoFFgvwO+NJYMPx261+VpSVUme65Yn9oJrzv?=
 =?us-ascii?Q?PTVDAZuBq/sz5jF2GrFIUnbYocmTTcKw3BbPup/sN3OnZDyamIbwBXBW7q8Q?=
 =?us-ascii?Q?5azTNtN+v7Spk6t9YEWuiqAECquxMlciQqXmmyIq1XnFLs3oPugCss8M4W7E?=
 =?us-ascii?Q?3AspiMV+ZbhdWJum96CKWF7c09ocjuVmG6INTtNY44FzaG9sU2SB03jLMu/I?=
 =?us-ascii?Q?wlSey9uywW06LE4xkX4zd3nlx1D/q6mMIUdVNT42egODdOtZ1bKMwfiM8APX?=
 =?us-ascii?Q?tGnlo6XcLziydeY1O4ejicqhrrBZYXwWSpimLOlSty6GxONHGGkhGYaQ5Ixo?=
 =?us-ascii?Q?uBCakzxn5Q0OVZY1ihFF+ClHWXqV2xMA7MGJNjsm+Y8ZI9GUsQFwtm3lCney?=
 =?us-ascii?Q?jqa40mTDhwBLyggDwKfQFTUz+0O4f+M5szKhlVKOyVQL8YO3YybEIZEREEuN?=
 =?us-ascii?Q?NnstiBDbFmkno71a6RfxCr1vael6td3+4BrNm2TagOGKG7ogzg4YyF8RbGqX?=
 =?us-ascii?Q?6/pRnLSmiM/927jOL5MeK63nDl7BO7ItvTgmXU/bdgwsVaXN0S4tuv5r8w4N?=
 =?us-ascii?Q?oBUYRNZ4w4l51xWLvqbTxOKVkoXFEAXKmF37ugJoXyb3s+F36Q6ZloG2QSje?=
 =?us-ascii?Q?sbNYcEqARNvOB4K/jW5mfhhroeo78quMAZYGbD68zaMXnd8gLzoKasgusmed?=
 =?us-ascii?Q?PYEZoxF17PQdOZNUzQqT8BR+u/AbmZS31fXj4WP2gH35iNF2JVK63pbBZDme?=
 =?us-ascii?Q?2posv4dKSf3n9xKVeUkmHnzLQ82Xa0RjAOspzZLmqNQx4ArvMLQD3lWrh99+?=
 =?us-ascii?Q?Q2myCywE/KYm2otFDmGWx3Hd+zVqazSGm+ICsTnVrIoElm9uyxpoh6EFnGlP?=
 =?us-ascii?Q?FlM80tpfaw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b11e94-1288-4e40-cc99-08de86824894
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 13:12:05.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXqIn2m/iuaFRCbs/WMnTPbxBoTi5E0Jhv+C1ciZCE9yf1RRyxMkTQYV1HqLMbvDvHoVWFpZ491d5DkFYZ9/mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11799
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
	TAGGED_FROM(0.00)[bounces-269909-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 798C42DAC34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 11:58:42AM +0100, Petr Machata wrote:
> 
> Ioana Ciornei <ioana.ciornei@nxp.com> writes:
> 
> > Add a couple of helpers which can be used by tests which need to run a
> > specific bash command on a different target than the local system, be it
> > either another netns or a remote system accessible through ssh.
> >
> > The run_cmd() function decides where to execute the command passed
> > through $@ based on the env variable TARGET value while run_on() will
> > receive the target through its first argument.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> > Changes in v3:
> > - s/TARGET/CUR_TARGET
> > - always fallback on running a command locally when either TARGETS is
> >   not declared or there is no entry for a specific interface
> > Changes in v2:
> > - patch is new
> >
> >  tools/testing/selftests/net/lib.sh | 39 ++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> > index b40694573f4c..f7c54d05758e 100644
> > --- a/tools/testing/selftests/net/lib.sh
> > +++ b/tools/testing/selftests/net/lib.sh
> > @@ -28,6 +28,10 @@ EXIT_STATUS=0
> >  # Per-test return value. Clear at the beginning of each test.
> >  RET=0
> >  
> > +# If a specific command needs to be executed on another target than local, set
> > +# this appropriately before calling run_cmd
> > +CUR_TARGET="local:"
> > +
> 
> These are new functions, they should just expose these parameters as
> actual function parameters, not as hidden environment. If it is
> desirable that run_cmd() can run local commands, maybe it makes sense to
> make the current run_cmd() a helper like __run_cmd(), which takes the
> remote-config parameter, and have run_cmd() be a wrapper:
> 
> run_cmd()
> {
> 	__run_cmd local: "$@"
> }

Why I chose to also add a function like run_cmd that makes use of an
environment variable is to support cases such as the following.

get_ifname_by_ip()
{
	local ip_addr=$1; shift

	run_cmd ip -j addr show to "$ip_addr" | jq -r '.[].ifname'
}

Helpers such as get_ifname_by_ip() (added in patch #3) that don't have
access to an interface name so that they can directly call run_on.

Do you mean that for any helpers such as the one above that need to be
run both on the local system and the remote it's better just to add a
new parameter to it that it's indeed the target on which it should be
run and get rid of the run_cmd all together?

get_ifname_by_ip()
{
	local target=$1; shift
	local ip_addr=$1; shift

	run_on "$target" ip -j addr show to "$ip_addr" | jq -r '.[].ifname'
}

Ioana

