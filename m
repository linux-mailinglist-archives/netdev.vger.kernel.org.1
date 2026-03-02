Return-Path: <netdev+bounces-262670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAeNFaSdpWlvCAAAu9opvQ
	(envelope-from <netdev+bounces-262670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:24:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AF91DABA0
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E213305BF6E
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94528401489;
	Mon,  2 Mar 2026 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HtOJ4bLn"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013018.outbound.protection.outlook.com [52.101.72.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FDE3FB060;
	Mon,  2 Mar 2026 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460934; cv=fail; b=hsB9jycZQAgZ7Q2Cah/RqTOtYbJot4K4zBVOyqd0HHVWSwQeLGkTBlltDA7+Ou0WNp2VsIdYiKI+G1scCC9Ixx/UI2derKkDuQY+lC63covqWAEivnfTUMznqepvoJSml5vdFxqWekB7grp+ji6B48sydNNG5mTRb4nli2TscaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460934; c=relaxed/simple;
	bh=SfN2P0epQulc366Vs6SABcfeP3l95fMuYM3EQlkYhG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RViDpFCwwhC5kKy06HAMR6Ael3UtgHolefeGc6SIU2hAOIFMrdb8lhBv7x0qC9D0t2/OVH6QxBOUSqq8iF37cyE+FkXkwrk6QDUf1ZFa+Djfn/QGfjY1rf404jiIs4Yof4Gu+eq3n7yNzKE6tx8jXih6qDWca8jalChQGbeVfg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HtOJ4bLn; arc=fail smtp.client-ip=52.101.72.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqsQ8X/xnQNodp80wXfdDYQo+XsJuqukHik6K91EV1KijAHZQhSwaEm0g89EJXfznAW6P7J14kGYvvqnz6dChEbMDDx6J/fUpNrZs4r28rW5HLpD7lnGTMu9CsiwK+B8iGALQq7HuoYTP5/xYsl//58uN7QdVC8eOGRhgV7Vfe1vLaTWjVtbbhUEVag4HNfgzHmXg3ofUj0KVXMSupEdbkuUCA6zUc1izAlOnlZoRbY/NIjtWGPt/2yb89CrQGotbOazldH9P07le0K0VtI4DrnNK17+EqvG1WQmHQ4VHMW1v8Yl/hRvTE+cs2LHDeV3EyBqgiUqXYFiS8sXQoETNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=238EWjoP5UFA/aRhcokYEeF3cTt3y4Vm4sNdFW3SS0g=;
 b=sPWRxVsU//zsL8iTxZFt0Z6PlbiQDboEZ7MIZZKkUp/0WeagkxcIVg7voqST00Gr/lceFEkmANutkZYx+24gKIjmzmF0Cva1qyHI0gOUKxAOEnp5pRXh+MgpWJYfV47cHssGCcX4mdke9WXrv9W+XZXCkk3NbKMsftDnSm6unmQcQ5ZLdh40bKOLHvg7N/oAMV+OshPqfqcrLuol0SJPYFDjmIi+fyNyzyjhLH130lXQAPPdKDA1DIHMw7P/sTULQlG5V4OLuqpL5gBpJe+N7GdEjovM9/Fwd/NjkfxCMCQuU5H8HMGsmEzhVPCbYZ0aj/qlh2bD1PRQsXPHABPkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=238EWjoP5UFA/aRhcokYEeF3cTt3y4Vm4sNdFW3SS0g=;
 b=HtOJ4bLnvLIlNj3F1XXuWYQ4f9eZhjfS1pGzUZwie441mLZLBdZPbcio+oOXxxKJZorLy7wnrWIOI7AJFgZFFasS6G/XGSDY7PZYMCeXihIbIHYU0gnPE5EuNtXm6LHBJ7dYWkr5suXNc+5aNvX+sNcpM/yEhmw1hUh7frc98pQJxhIBIYG7iXWPR8CctBmBQQYgfaTRA+Jpzi4L6fyLY+yCKRevshdQ6MHzqteIdbt05yzhNwUVoUUJpcr9L1T2X5z+q8mnhTFUarwYzfDked+/NCr/oxSvYuNclX0lVTQBukqSunl40AsmyfBSBWAWgMt0DEhYV7vBYN4aNdMriA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PA2PR04MB10333.eurprd04.prod.outlook.com (2603:10a6:102:41a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 14:15:29 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:15:29 +0000
Date: Mon, 2 Mar 2026 16:15:25 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <skvfdukic45r43yqw5wzzubqslrfdepcnghbspwvp7jtmjp2zx@6bqapqyjcpe7>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
 <87fr6mf8gb.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fr6mf8gb.fsf@nvidia.com>
X-ClientProxiedBy: AM5PR0101CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::40) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PA2PR04MB10333:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1fd648-0f01-464c-f391-08de7866285e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	tqsxUdaPyKdjeQJYvvqEEh7EyIEQrzGmIyEerYayc5tJjKYlD3uAn97OyGniaCjaDEMEMFWjQXLVEm9RBr+lHgdSN3AcuSBFde90W4Z6OiK6xTE0xpjfUwfQHyvHGB7JMgNOGIvNXlPmoSqEb/5CVwkyPlqKyXCaLks0fBQH8ILxFEj+UnxxxwaAgVnaEr3Uav3vFC1Q64RFbP1lR4WanxvwjhjY1ca8zNSSCkKiBXDU/DGQvdzvBd1hLtwT5FakDHUiSmzYnFv7WCosM46a9S7C+EOp/77fJ0tHJ0UFJoqksmC7JPzK1PQqepchuuKzFSprVznaBZa20ASER8R1EFmcV1RtJ32/jg5r+mlicXRBn4wZ+YXtrkpRHNMtVls1pIb7OkGdgcVI6NMK9iWTpH1LSDgpD2X6VaKI3v7ikNRct6l/XqvM45zojsIFTBZgXvAtVXulrCYeX/7+aVlc7lK4e1kKBaioWcaxTSTywPUI2izK9IvtdnBW2DVHZnfcNqLFLuBk5ptnW9LOqWpH+8TBsq15JoSHsf7UkdKZ8U7FnlXjb4fyUE9blaliKrWnhrVSdvGV8JDkP1mv3BNO6q9+pYlKdWyWqVieZdnsdpWBVihbH394u3qZSzO8LiJ6ro94osNYqNgeLD9GQxbRd1PpqqYg680sUTzyRmwEt07vA3su4XRGMkXGdmNLTPvzzmkwh/eEvIZ8c7TUzNPvX4uvJ6Xawo1de/Xk/Br1BlU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wsHIpGSJKVWS1Oe/a2M+9ngcHzRoK1F774SV9T12/9ZoUFbKKhHOLKP0l5KU?=
 =?us-ascii?Q?G6g9zwJlay/px0zlHLMAGmbifBnauhncmB7xrENt/Em0iKHiZS6BeC1MD+Vi?=
 =?us-ascii?Q?bwqOcfCz62I+44VABXEytdp8LeHQ5TbruDFydE7eX4atxwCe2W+uDygxfZYT?=
 =?us-ascii?Q?mQ0VL3l/r2QkF/nvQlWiwRCM5HS4FW1485+HCzrwaI25Zuzrpk680q3+1ZKD?=
 =?us-ascii?Q?L7EBbPRuWSVcxFkOznFbwLdq7q+KzWgtkRRzke/xWDavLEKxTclXpSttgCt5?=
 =?us-ascii?Q?54djCDXBf83tX7fzaqzC3ajGEKr9Duu9Fo+pQYcrTfhcXBf6DUnF3E855GCp?=
 =?us-ascii?Q?C9TQIYnLFgDDi0O8R6UNp5ZiyDnL84Rq1RXp9l9d4cO9pBvQBr2SCh/uD9Tn?=
 =?us-ascii?Q?BdNeGL8nUPZ554UHy5d1QVUYP6XZu7s+gX0KiQjhHybsxoZlOrD/7OUaMj7Y?=
 =?us-ascii?Q?jEg84AH5i24GwbiRLChsUMmTZ53dniqbxKtg59pJpWv7QrB7QSwTUAFjdTOF?=
 =?us-ascii?Q?7m4okbrWMCPA7N1+b/0tnhr7ANzZpech/YQ/oOuDCekS+Sh8udUWtTUTlKM2?=
 =?us-ascii?Q?+iztdTMmMefPX1qtoXd9YrWIadA4mpo5jrP3qggm0teWlav/ohoB+IQa/aVR?=
 =?us-ascii?Q?xHPiZYTR1FXBAblwU1C0w6u4Vvf3qaU3beU5zQNCT+7wNmjroEtPjBOSLWfh?=
 =?us-ascii?Q?2AnVFkEu8CLRQl6XvB6TXaLaqoR4AYqOOFi7grp/ci32YdnGu39xu4q0hvDb?=
 =?us-ascii?Q?N4JAIzTZQRvgT/sgAiAB1W9/UFzl5ejZh8Y8sQnu3ECraLKFom54GqVeXE/9?=
 =?us-ascii?Q?+na+biWdbDniu5qAAnQfEvz8GX8S4EGmXFsSSNhNwZYSegE+NyEqDbjRXxSr?=
 =?us-ascii?Q?dGRq4gTumX0Zj1FplhxlrMwM0/8x5obk6sX888PnBhuQ9y1j0cTDojtH9la7?=
 =?us-ascii?Q?Zl1wgIbXm9Xhzy1IXEgYBFyZXVNvNcUYV3DC8Nl32v/8wBOMGn+ovdimnqzH?=
 =?us-ascii?Q?akFouwnz5A5lHVSlMg9OvEP4aVOGokHmAe8d1Cr5LW+rYeuObzKglKzbLsKm?=
 =?us-ascii?Q?jWwnl+dBQWz9q/4/P+eIzH6UsGxXPL2nSf7w2qN0w3grh3Wqa2LZsNEnz6H5?=
 =?us-ascii?Q?V2jjw8NG+RJXHNZh3ziltq7ZKSqwHVvzU+EnXnQa8X8ur+mJsfPHuJnOhjyh?=
 =?us-ascii?Q?o8ZnszEQcZPuJaNlCrvoAdgULc27cR46SuMqzM2hleqzcT0X4Rr36SmYicqm?=
 =?us-ascii?Q?FRb5ozLeN9LAK+nxaBaXtQdhXUMx2wfCwi+Or+Ck0HrIeey2xzaBgBI4uJUO?=
 =?us-ascii?Q?uB5FlQ9FbqVgngdC7Ml+MoXxDojucop2YVQfUTqlCfv2HfPMAhs/6MxzM2SM?=
 =?us-ascii?Q?olRUd1NXUtkoiUESjTH4fAcWWVMxMyGa8vFSCld5MHFxLH2D5nveedbxbUMk?=
 =?us-ascii?Q?EX4qcqvUfiNaQxYPcsEKw7mGJS9ZWJKXySjubPN+AVsDfdMlHlJvfNgO4xnI?=
 =?us-ascii?Q?Okh7LIiwSdIUXLaGZ9DT8rKNvKbWM8eq3hPsMNXbpWU0sMl+TTfP5iRK3vs5?=
 =?us-ascii?Q?zQg2Gh8OhSCPQu03EjT4YQw2xQkqmB5aMznFJEuqtiVnW2E2yu9pUQNV2qgk?=
 =?us-ascii?Q?pz0AyP57gbPaQ+/gsq/frS0Df++h2zQGMMo6JkFmTu61TAL0/EYt83E+DQE5?=
 =?us-ascii?Q?j22GCRwIEYa1oUjUEgSvntsqKBREAcNcsjN2QgtbiPcgMP+BEbWEkzjfnrpa?=
 =?us-ascii?Q?rCjnD8XHMA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1fd648-0f01-464c-f391-08de7866285e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:15:29.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyopPITo+ITfFIm00Sf1Yd4G5qTXU3aJgr1offnaO+29qzSUonvb70Y2dmFU4hRjTi07zZC1gva0iS9atfRjQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10333
X-Rspamd-Queue-Id: E8AF91DABA0
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
	TAGGED_FROM(0.00)[bounces-262670-lists,netdev=lfdr.de];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[172.105.105.114:from];
	DKIM_TRACE(0.00)[nxp.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.105.105.114:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DNSWL_BLOCKED(0.00)[100.90.174.1:received,2603:10a6:102:1bf::7:received,52.101.72.18:received,172.105.105.114:from];
	DWL_DNSWL_BLOCKED(0.00)[nxp.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[52.101.72.18:received,2603:10a6:102:1bf::7:received,100.90.174.1:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool_rmon.sh:url,hw_stats_l3.sh:url,ethtool_std_stats.sh:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,ethtool_extended_state.sh:url]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 04:45:47PM +0100, Petr Machata wrote:
> 
> Ioana Ciornei <ioana.ciornei@nxp.com> writes:
> 
> > Add a new selftest - ethtool_std_stats.sh - which validates the
> > eth-ctrl, eth-mac and pause standard statistics exported by an
> > interface. Not all counters can be validated in software, especially
> > those that are keeping track of errors. Counters such as
> > SingleCollisionFrames, FrameCheckSequenceErrors etc are not tested nor
> > included in this new selftest.
> >
> > The central part of this patch is the traffic_test() function which
> > gathers the 'before' counter values, sends a batch of traffic and then
> > interrogates again the same counters in order to determine if the delta
> > is on target. The function receives an array through which the caller
> > can request what counters to be interrogated and, for each of them, what
> > is their target delta value.
> >
> > The output from this selftest looks as follows on a LX2160ARDB board:
> >
> > $ ./ethtool_std_stats.sh eth0 eth1
> > TEST: eth-ctrl tx on eth0 (MACControlFramesTransmitted on eth0)     [ OK ]
> > TEST: eth-ctrl tx on eth0 (MACControlFramesReceived on eth1)        [ OK ]
> > TEST: eth-ctrl tx on eth1 (MACControlFramesTransmitted on eth1)     [ OK ]
> > TEST: eth-ctrl tx on eth1 (MACControlFramesReceived on eth0)        [ OK ]
> > TEST: eth-mac bcast tx on eth0 (BroadcastFramesXmittedOK on eth0)   [ OK ]
> > TEST: eth-mac bcast tx on eth0 (FramesTransmittedOK on eth0)        [ OK ]
> > TEST: eth-mac bcast tx on eth0 (OctetsTransmittedOK on eth0)        [ OK ]
> > TEST: eth-mac bcast tx on eth0 (MulticastFramesXmittedOK on eth0)   [ OK ]
> > TEST: eth-mac bcast tx on eth0 (BroadcastFramesReceivedOK on eth1)  [ OK ]
> > TEST: eth-mac bcast tx on eth0 (FramesReceivedOK on eth1)           [ OK ]
> > TEST: eth-mac bcast tx on eth0 (OctetsReceivedOK on eth1)           [ OK ]
> > TEST: eth-mac bcast tx on eth0 (MulticastFramesReceivedOK on eth1)  [ OK ]
> > TEST: eth-mac mcast tx on eth0 (BroadcastFramesXmittedOK on eth0)   [ OK ]
> > TEST: eth-mac mcast tx on eth0 (FramesTransmittedOK on eth0)        [ OK ]
> > TEST: eth-mac mcast tx on eth0 (OctetsTransmittedOK on eth0)        [ OK ]
> > TEST: eth-mac mcast tx on eth0 (MulticastFramesXmittedOK on eth0)   [ OK ]
> > TEST: eth-mac mcast tx on eth0 (BroadcastFramesReceivedOK on eth1)  [ OK ]
> > TEST: eth-mac mcast tx on eth0 (FramesReceivedOK on eth1)           [ OK ]
> > TEST: eth-mac mcast tx on eth0 (OctetsReceivedOK on eth1)           [ OK ]
> > TEST: eth-mac mcast tx on eth0 (MulticastFramesReceivedOK on eth1)  [ OK ]
> > TEST: eth-mac ucast tx on eth0 (BroadcastFramesXmittedOK on eth0)   [ OK ]
> > TEST: eth-mac ucast tx on eth0 (FramesTransmittedOK on eth0)        [ OK ]
> > TEST: eth-mac ucast tx on eth0 (OctetsTransmittedOK on eth0)        [ OK ]
> > TEST: eth-mac ucast tx on eth0 (MulticastFramesXmittedOK on eth0)   [ OK ]
> > TEST: eth-mac ucast tx on eth0 (BroadcastFramesReceivedOK on eth1)  [ OK ]
> > TEST: eth-mac ucast tx on eth0 (FramesReceivedOK on eth1)           [ OK ]
> > TEST: eth-mac ucast tx on eth0 (OctetsReceivedOK on eth1)           [ OK ]
> > TEST: eth-mac ucast tx on eth0 (MulticastFramesReceivedOK on eth1)  [ OK ]
> > TEST: pause tx on eth0 (tx_pause_frames on eth0)                    [ OK ]
> > TEST: pause tx on eth0 (rx_pause_frames on eth1)                    [ OK ]
> > TEST: pause tx on eth1 (tx_pause_frames on eth1)                    [ OK ]
> > TEST: pause tx on eth1 (rx_pause_frames on eth0)                    [ OK ]
> >
> > Please note that not all MACs are counting the software injected pause
> > frames as real Tx pause. For example, on a LS1028ARDB the selftest
> > output will reflect the fact that neither the ENETC MAC, nor the Felix
> > switch MAC are able to detect Tx pause frames injected by software.
> >
> > $ ./ethtool_std_stats.sh eno0 swp0
> > (...)
> > TEST: Not all MACs detect injected pause frames                     [XFAIL]
> > TEST: pause tx on eno0 (rx_pause_frames on swp0)                    [ OK ]
> > TEST: Not all MACs detect injected pause frames                     [XFAIL]
> > TEST: pause tx on swp0 (rx_pause_frames on eno0)                    [ OK ]
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  .../testing/selftests/drivers/net/hw/Makefile |   1 +
> >  .../drivers/net/hw/ethtool_std_stats.sh       | 192 ++++++++++++++++++
> >  2 files changed, 193 insertions(+)
> >  create mode 100755 tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> > index a64140333a46..d447813a14b2 100644
> > --- a/tools/testing/selftests/drivers/net/hw/Makefile
> > +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> > @@ -26,6 +26,7 @@ TEST_PROGS = \
> >  	ethtool_extended_state.sh \
> >  	ethtool_mm.sh \
> >  	ethtool_rmon.sh \
> > +	ethtool_std_stats.sh \
> >  	hw_stats_l3.sh \
> >  	hw_stats_l3_gre.sh \
> >  	iou-zcrx.py \
> > diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh b/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
> > new file mode 100755
> > index 000000000000..4ce8f140a18c
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
> > @@ -0,0 +1,192 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#shellcheck disable=SC2034 # SC does not see the global variables
> > +
> > +ALL_TESTS="
> > +	test_eth_ctrl_stats
> > +	test_eth_mac_stats
> > +	test_pause_stats
> > +"
> > +STABLE_MAC_ADDRS=yes
> > +NUM_NETIFS=2
> > +lib_dir=$(dirname "$0")
> > +# shellcheck source=./../../../net/forwarding/lib.sh
> > +source "$lib_dir"/../../../net/forwarding/lib.sh
> > +
> > +traffic_test()
> > +{
> > +	local iface=$1; shift
> > +	local neigh=$1; shift
> > +	local num_tx=$1; shift
> > +	local pkt_format="$1"; shift
> > +	local title="$1"; shift
> > +	declare -a counters=( "${@:2:$1}" ); shift "$(( $1 + 1 ))"
> 
> Please make this local -a. declare inside a function also introduces a
> local variable, so the effect is the same, but using local is more
> obvious.

Ok.

> 
> BTW, just a suggestion, personally I'd just make the counters a pure
> "rest" argument:
> 
> 	local -a counters=("$@")
> 
> simply because functions usually don't need more than one, and it's
> easier to use on call site, and easier to understand what's going on.

Why I had this overly complicated retrieval of the array is because I
started out with multiple arrays and then restructured but forgot about
this. Will change to just retrieve the "rest".

> > +	local before after delta target_high extra
> > +	local int grp counter target unit
> > +	local num_rx=$((num_tx * 2))
> > +	local xfail_message
> > +	local src="aggregate"
> 
> And local i.

Sure.

> 
> > +
> > +	for i in "${!counters[@]}"; do
> > +		read -r int grp counter target unit xfail_message <<< "${counters[$i]}"
> > +		before[i]=$(ethtool_std_stats_get "$int" "$grp" "$counter" "$src")
> > +	done
> > +
> > +	# shellcheck disable=SC2086 # needs split options
> > +	$MZ "$iface" -q -c "$num_tx" $pkt_format
> > +
> > +	# shellcheck disable=SC2086 # needs split options
> > +	$MZ "$neigh" -q -c "$num_rx" $pkt_format
> > +
> > +	for i in "${!counters[@]}"; do
> 
> There should be a RET=0 here, so that the check_err below gets a clean slate.

You want me to move the RET=0 from some lines below to here, right?

> 
> > +		read -r int grp counter target unit xfail_message<<< "${counters[$i]}"
> > +
> > +		after[i]=$(ethtool_std_stats_get "$int" "$grp" "$counter" "$src")
> > +		if [[ "${after[$i]}" == "null" ]]; then
> > +			log_test_skip "$int does not support $grp-$counter"
> > +			continue;
> > +		fi
> > +
> > +		delta=$((after[i] - before[i]))
> > +
> > +		# Allow an extra 1% tolerance for random packets sent by the stack
> > +		extra=$((num_pkts * unit / 100))
> > +		target_high=$((target + extra))
> > +
> > +		RET=0
> > +		[ "$delta" -ge "$target" ] && [ "$delta" -le "$target_high" ]
> > +		err="$?"
> > +		if [[ $err != 0  ]] && [[ -n $xfail_message ]]; then
> > +			log_test_xfail "$xfail_message"
> 
> I think this should mention the $title as well. I think that the
> xfail_message could be the log_test's opt_str, so:
> 
>                         log_test_xfail "$title" "$xfail_message"

Good point.

> 
> A bit annoying that log_test_xfail clears the retmsg. It does so so that
> messages from previous runs do not show up, which is desirable in
> general, but here it would be handy.
> 
> > +			continue;
> > +		fi
> > +		check_err "$err" "$grp-$counter is not valid on $int (expected $target, got $delta)"
> > +		log_test "$title" "$counter on $int"
> > +	done
> > +}
> > +
> > +test_eth_ctrl_stats()
> > +{
> > +	local pkt_format="-a own -b bcast 88:08 -p 64"
> > +	local num_pkts=1000
> > +	local counters
> 
> local -a
> 
> (Though yeah, bash doesn't care.)

Ok.

> 
> > +
> > +	counters=("$h1 eth-ctrl MACControlFramesTransmitted $num_pkts 1"
> > +		  "$h2 eth-ctrl MACControlFramesReceived $num_pkts 1")
> > +	traffic_test "$h1" "$h2" "$num_pkts" "$pkt_format" \
> > +		"eth-ctrl tx on $h1" \
> > +		"${#counters[@]}" "${counters[@]}"
> > +
> > +	counters=("$h2 eth-ctrl MACControlFramesTransmitted $num_pkts 1"
> > +		  "$h1 eth-ctrl MACControlFramesReceived $num_pkts 1")
> > +	traffic_test "$h2" "$h1" "$num_pkts" "$pkt_format" \
> > +		"eth-ctrl tx on $h2" \
> > +		"${#counters[@]}" "${counters[@]}"
> > +}
> > +
> > +test_eth_mac_stats()
> > +{
> > +	local pkt_size=100
> > +	local pkt_size_fcs=$((pkt_size + 4))
> > +	local bcast_pkt_format="-a own -b bcast -p $pkt_size"
> > +	local mcast_pkt_format="-a own -b -b 01:00:5E:00:00:01 -p $pkt_size"
> > +	local ucast_pkt_format="-a own -b $h2_mac -p $pkt_size"
> > +	local num_pkts=2000
> > +	local octets=$((pkt_size_fcs * num_pkts))
> > +	local counters
> 
> local -a

Ok.

> 
> > +
> > +	counters=("$h1 eth-mac BroadcastFramesXmittedOK $num_pkts 1"
> > +		  "$h1 eth-mac FramesTransmittedOK $num_pkts 1"
> > +		  "$h1 eth-mac OctetsTransmittedOK $octets $pkt_size_fcs"
> > +		  "$h1 eth-mac MulticastFramesXmittedOK 0 1"
> > +		  "$h2 eth-mac BroadcastFramesReceivedOK $num_pkts 1"
> > +		  "$h2 eth-mac FramesReceivedOK $num_pkts 1"
> > +		  "$h2 eth-mac OctetsReceivedOK $octets $pkt_size_fcs"
> > +		  "$h2 eth-mac MulticastFramesReceivedOK 0 1")
> > +	traffic_test "$h1" "$h2" "$num_pkts" "$bcast_pkt_format" \
> > +		"eth-mac bcast tx on $h1" \
> > +		"${#counters[@]}" "${counters[@]}"
> > +
> > +	counters=("$h1 eth-mac BroadcastFramesXmittedOK 0 1"
> > +		  "$h1 eth-mac FramesTransmittedOK $num_pkts 1"
> > +		  "$h1 eth-mac OctetsTransmittedOK $octets $pkt_size_fcs"
> > +		  "$h1 eth-mac MulticastFramesXmittedOK $num_pkts 1"
> > +		  "$h2 eth-mac BroadcastFramesReceivedOK 0 1"
> > +		  "$h2 eth-mac FramesReceivedOK $num_pkts 1"
> > +		  "$h2 eth-mac OctetsReceivedOK $octets $pkt_size_fcs"
> > +		  "$h2 eth-mac MulticastFramesReceivedOK $num_pkts 1")
> > +	traffic_test "$h1" "$h2" "$num_pkts" "$mcast_pkt_format" \
> > +		"eth-mac mcast tx on $h1" \
> > +		"${#counters[@]}" "${counters[@]}"
> > +
> > +	counters=("$h1 eth-mac BroadcastFramesXmittedOK 0 1"
> > +		  "$h1 eth-mac FramesTransmittedOK $num_pkts 1"
> > +		  "$h1 eth-mac OctetsTransmittedOK $octets $pkt_size_fcs"
> > +		  "$h1 eth-mac MulticastFramesXmittedOK 0 1"
> > +		  "$h2 eth-mac BroadcastFramesReceivedOK 0 1"
> > +		  "$h2 eth-mac FramesReceivedOK $num_pkts 1"
> > +		  "$h2 eth-mac OctetsReceivedOK $octets $pkt_size_fcs"
> > +		  "$h2 eth-mac MulticastFramesReceivedOK 0 1")
> > +	traffic_test "$h1" "$h2" "$num_pkts" "$ucast_pkt_format" \
> > +		"eth-mac ucast tx on $h1" \
> > +		"${#counters[@]}" "${counters[@]}"
> > +}
> > +
> > +test_pause_stats()
> > +{
> > +	local pkt_format="-a own -b 01:80:c2:00:00:01 88:08:00:01:00:01"
> > +	local xfail_message="Not all MACs detect injected pause frames"
> > +	local num_pkts=2000
> > +	local counters i
> 
> counters should be declared local -a

Ok.

> 
> > +
> > +	# Check that there is pause frame support
> > +	for ((i = 1; i <= NUM_NETIFS; ++i)); do
> > +		if ! ethtool -I --json -a "${NETIFS[p$i]}" > /dev/null 2>&1; then
> > +			log_test_skip "No support for pause frames, skip tests"
> > +			exit
> > +		fi
> > +	done
> > +
> > +	counters=("$h1 pause tx_pause_frames $num_pkts 1 $xfail_message"
> > +		  "$h2 pause rx_pause_frames $num_pkts 1")
> > +	traffic_test "$h1" "$h2" "$num_pkts" "$pkt_format" \
> > +		"pause tx on $h1" \
> > +		"${#counters[@]}" "${counters[@]}"
> > +
> > +	counters=("$h2 pause tx_pause_frames $num_pkts 1 $xfail_message"
> > +		  "$h1 pause rx_pause_frames $num_pkts 1")
> > +	traffic_test "$h2" "$h1" "$num_pkts" "$pkt_format" \
> > +		"pause tx on $h2" \
> > +		"${#counters[@]}" "${counters[@]}"
> > +}
> > +
> > +setup_prepare()
> > +{
> > +	h1=${NETIFS[p1]}
> > +	h2=${NETIFS[p2]}
> > +
> > +	h2_mac=$(mac_get "$h2")
> > +
> > +	for iface in $h1 $h2; do
> 
> These should be quoted.
> iface should be local.

Ok.

> > +		ip link set dev "$iface" up
> 
> Plesae use defer:
> 
> 		ip link set dev "$iface" up
> 		defer ip link set dev "$iface" down
> 
> Then drop the hand-rolled cleanup() altogether. Retain the "trap cleanup
> EXIT" -- it will pick up forwarding/lib.sh's cleanup(), which calls
> pre_cleanup and defer_scopes_cleanup().

Sure! Thanks.

