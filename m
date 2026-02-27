Return-Path: <netdev+bounces-261830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O8eB4mHoWmTuAQAu9opvQ
	(envelope-from <netdev+bounces-261830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:01:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9208B1B6E1F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1616311580C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1E0333438;
	Fri, 27 Feb 2026 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W+fFvGf7"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FE329E7D;
	Fri, 27 Feb 2026 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772193438; cv=fail; b=eW/GSal4PALlj7B8u/ICBmdvExbrJgw9fN2C7MbTofTUm53vnDwUB/HtuNwP8AvEd9raVVbFSajR1DtwBCzhKhFa/05yPRUMUgTPpniFmldKKa6idsOWV6L7xnihTDv/D8ZyeZsfA6KftHAtkZiIrBd9lYXIXTlUB/EBYyEiMAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772193438; c=relaxed/simple;
	bh=wdLwh3nFPVKIH3TUzO74QT6YvXbvTXVSw1UgTx7HFpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pbcZpxbZJK1irWuMIyiNaabrMusWRUKfqRuyveAS8oM3P2GmmXX6jo7LEZIa0Ate+2VYuSm9VJIS8k/x9V/Wbbqa7HQllZzG5L0BlmIEHyN85kNQg3MhB9UnKrNFxSc+WXr38ZaFqB+1xmSLK20RoP9mmio3g+e+BLuhfKUCvE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W+fFvGf7; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KE8wRQpDHZmTZxOHEkZ/l3JADoF4VSNxZHVigxMfoUoS0Q9/djGSMt8PDLxRk7/XIVmKIl2igN0m7lD19xDliEv8ats2MfzmtrQYHezb66a588+NSLAXQDoDgOXEujsCiuqvZ/jnQFyvlAF4IGyn5IH1ux8dHKk2gGttBQppqjkQoROTrRs2yrilUda9D02dXLFf2eg8ksvGLeE07cS5UyYMKTzc1cRUdbr93/0TIvLyvXpQdDo4TEEFzdhi5weBZmv+FEW7V+XO0cwl9FaMfaFZpvG56ht5oowTd10SgUn775JjVlAd9s+iOzdpvu32pieVVI7eV0gp7ehhK+PPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdLwh3nFPVKIH3TUzO74QT6YvXbvTXVSw1UgTx7HFpc=;
 b=j2/CKeefLn89CQhC85HJc5UcdVGfa0Qw7AWFTkNtxSGP5EXhE2aTNXuVqm5sL8aprK7NdanXkL4FVjXkuksDXeEgzxXwm2VOnVwI7I1MvvfuvF8fVXnVZqyhe9Te7ohpb1OEGEwyAlnLsf7t9/qP3vwS1I1AeJ4zxLxqcjTG98uG5zhpiXLBa2N9SAndzzSJHu4E+MPMw3ACZpIVcP345g3pf6Mo2sLYYEFfwDNFGxKu7ly8aP8u8RYNHeg+cP8uf04cpbsIwTXDBLWH2NS+945obO8IsnowkVZ0PrSN/Gz5pAoV3EXiDaynR3e8nHfOQDsKqCQpVR0IAvQo0X/Opg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdLwh3nFPVKIH3TUzO74QT6YvXbvTXVSw1UgTx7HFpc=;
 b=W+fFvGf7TtRND4F3fvv6h5UtWbnHJV84zZhys1rIHCa/Ntd4UB7PDXOCS4I5b6TQvuO6YISNdE0J87OmukVcfHJ7GQB1AvgLzOwQoExCx1ZhOPfshB6y2GKnl099wVWErmAJ7xqKx7wzameucSbOGbHhXwniag6DevqZM+rRJnKN2TsHR8RysQ7mrhT3VEFW+XWjU7j/qRIr9ixuycoYtlZaJVlnMgmyW/SmFjlxiwSkn+xlXYdeY3Vs4SmYRDeSLys1BcxF7c1uloQ6vX5K91rAFC9uktDdsC9HoMf76j3Sa65uuPp9ftwYCjiSrAW+ZR0AmGhtbP/HTr1dHeqqvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7697.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 11:57:11 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 11:57:11 +0000
Date: Fri, 27 Feb 2026 13:57:08 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Zefir Kurtisi <zefir.kurtisi@gmail.com>
Cc: claudiu.manoil@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>
Subject: Re: [PATCH] net: enetc: fix sirq-storm by clearing IDR registers
Message-ID: <20260227115708.lkpbea3b24ztdsgl@skbuf>
References: <20260220132930.2521155-1-zefir.kurtisi@gmail.com>
 <20260223163227.y3yzzpncyf5a7klq@skbuf>
 <b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com>
 <20260226195158.sagjq3hgs6l64w2u@skbuf>
 <20260220132930.2521155-1-zefir.kurtisi@gmail.com>
 <20260223163227.y3yzzpncyf5a7klq@skbuf>
 <b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com>
 <20260226195158.sagjq3hgs6l64w2u@skbuf>
 <786338e0-0a6b-4b7b-9e22-8253bb655aec@gmail.com>
 <786338e0-0a6b-4b7b-9e22-8253bb655aec@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786338e0-0a6b-4b7b-9e22-8253bb655aec@gmail.com>
 <786338e0-0a6b-4b7b-9e22-8253bb655aec@gmail.com>
X-ClientProxiedBy: VI1PR07CA0214.eurprd07.prod.outlook.com
 (2603:10a6:802:58::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a785595-82da-472a-7415-08de75f756e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	b2wSmRQvyPZpC8CzmJlemLr4OOTsVZB0hOZKSenijCTJjdCG49PeW9PvuanZxhMqv+WjoYEWios2sDSzXmsCDOBE0P2GNq2v22XuEEUt3J3Gn4vaY0ZYSt+o1fQ587Ujjp7FSM9+M7/4hMH3TXA3PClUxPpiih6tp+NX4vDDAzpHN+O3bLQPBwprYPCe4TrpvGSpoRdaKBj9SAg2a9Eqx9Z66mI9QWx/nRCfwhH6/dzOwylolubc1onzSI7PL3sbiKRvSV7s0UnwAYUivibDyyNAeyk9j+q9M2+0jkXw3XxmtldGl0Z92am6GyiNECZNIioc6FToHAiCsScMWbVTDJIU4KJDnC5F7WiP02IS9e7sFHS/hjhj/xioUgISKdrULEoWouFViuu/KlWA+CFzP2ba70LZczPLCkayooqnr6ohxym1TYfl1f14F50/nozcs6DJkSNs4Rxmdrt7K9KCokLTiHQwjniQwjwrgb1ExRjeBwf0kVrRFHc0uz7hcmUr9Rx9hXWuIGWC8Atm6i41bamjDCC5nIPktWd3LAu/xidJqbuP8tTRyTOqMzwYhyXJaMkRHCWS3NiTB7iXGZQ6Gp75uOz/NHsQ2b4fxI2LrQ8Bx0Wi/bl6nZK/oJmpgdnr1L2YOzS+5PCD4BI2CZeOUdDC0hZ60C/5lK+DlYIKjTUwXL1Xh223PiivjNqqWEvmv+UhqKKPpPYW5BXhqZ6gssUq2jPTB90+nOvq3Fb/LD4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?99PT6/v4O1HAVFrc7t4nhaw7NfVu3SYJ+HWqvYIDcBDqQ/lX9cIvdL/P4xk8?=
 =?us-ascii?Q?oXo+O2rQD1tewSgUR3mvhXjrmMyO2EIFrR4FbsNEpwBY0K4H/7Ym/vjZeJ+N?=
 =?us-ascii?Q?6tyao/973APeCok9j8nVK65qt5wAyBu0Zn0NzjJRuZdqJwQ/CrbqOgbZljvd?=
 =?us-ascii?Q?4Hov3Ww03YhVc85Cgo3rh3Iwmb1UsHQ4CcC6ooeXXrxOA6NOtKjxd42gh/HH?=
 =?us-ascii?Q?Uui7jWS/f3INnLYpMpG+TWhySM+OWNAx1AwpMBPWJNvjvslD78b8hTnzUHNS?=
 =?us-ascii?Q?afvesqgpZS4XeKVoDje5CgF9cU0OocE/mV/PHIkQTfFpm5YtK2ieHyDF+Rjn?=
 =?us-ascii?Q?l4laoGCaDu4sToz+aMqboQLV7PbJ1Vs5tfQW7Qktt91p2KwK9lOBbmiMVV6F?=
 =?us-ascii?Q?ePbdmS8QxqE/QiAxjxInTsfeI3W+5VqqL1I970w8sAlxGJhd75Kk19B4SBLB?=
 =?us-ascii?Q?yv08fllbUDT0Y7D7XjUzBO1meCxMZHwDStTflyS5hiHwpkacXlyEE7P6RdSe?=
 =?us-ascii?Q?7e8R6nVcbQH/SR4X3yERqON9jdqCNYZi3+DnIzblpYcaz2fbDzNWQPUszlYD?=
 =?us-ascii?Q?5GTnlTAlbv1UYbKZxT5wxwf14tVU/o2ZjvRH7g4MMxftnZry8G1ZvhVjT3tC?=
 =?us-ascii?Q?ZzF+v0kBepF+BBWT62qOfv0nsExUTsB+7d37yFwIIQaal/6lGHG13P70gpkN?=
 =?us-ascii?Q?7uE1a+OLDdX7ebjnlH8tUGYnW/MOGDl+El0KiaplnBWIIpN+iCLQe+l885ww?=
 =?us-ascii?Q?ZcZzZULbuT7Zgl+LSfoQWBbPyZQvOnKekJHAx/FDeApPTFHJSdtIbDo/r3Wr?=
 =?us-ascii?Q?MnjAYsUv/A1AYfm1ezoQpZD53T/S+KvP8s0ZlzJwJDPHUCvP7ZFdu9oh60wi?=
 =?us-ascii?Q?xlKZU7gTTwSQOGIqovOTPzU+M/WD//MyJobwtnJtwiw4093t/9YUUrYuk0u7?=
 =?us-ascii?Q?BeZZv1BAyDq0KwOOaMxuaV8fnDCl0JDWj4Qbf5cjx/yuJePfGJmhK1o2bzcV?=
 =?us-ascii?Q?pV8HfBCBDspwRmK/aNVRnPFoxiHDmro2ZE7ocRLTkuSN+0F9tRmCxJaWX6DU?=
 =?us-ascii?Q?YpODwlOPMdthYW0gkKMM60X7Q9+P6hQeeCChvZKdO9wbcvqO6hwEJprf5rg2?=
 =?us-ascii?Q?kOWVhSdK8Zua5XarliLYVQ8kgTUKYpY2MWNx6HXE5aoZkZAfxm1rpK0Fj92F?=
 =?us-ascii?Q?rQmD8Oe115sBd3r4SZjt5K3fz7DfPpE5PoNVV/3frb4937M9ehAdD4nRC/Yn?=
 =?us-ascii?Q?mkIZcr8IjdxqFo9DJ4Th72LENBBhjzJ6pMqUMixyfsODwsl5FsaawejEef0r?=
 =?us-ascii?Q?yLMGXab5vqexGtQrn1P2daZ7puyNtF5qIJ99MbN67aO0d2Zbo+34WGxrdSfv?=
 =?us-ascii?Q?hep1BVrMgBHfICqTJrB6AQbuLu4rqk3LoFUZnCWBqvd2LovpwXLk7ILTZ7aE?=
 =?us-ascii?Q?2Euz0Vxk5zsU+/dlszUeKnevlC5mUsHLUo7GCeC9L/n9tP7/riPCxB9aGg1E?=
 =?us-ascii?Q?EHKyan6W2yFlWwHWRRqHP1AJqfoxn5Wk7DLv3Xv5zfXNUz8PERWK/DgGIVpI?=
 =?us-ascii?Q?X+2mayj3SSMykNOBOp0wEpRXKlFLOFRnX+WYigt48OgnauQs5zg7YU45LOD7?=
 =?us-ascii?Q?gHDDMPVTb5aDOQqhARDuL28FuDQfOYG4jpK+CpcX0vSv5xkGsLImFSJCeEpe?=
 =?us-ascii?Q?UDzf1ekvD3dsvws+pHn2KGBBUgorCa3rwR+Yb9b3PyvzyPm4dhbl6PkPxy6f?=
 =?us-ascii?Q?3547on5BfiOSFVz6RBscfL2bQJmgqU/JNq3CQStGjH9itMcuOAQIdR9XamJz?=
X-MS-Exchange-AntiSpam-MessageData-1: u2hfqS5kvDTPhvxkKKPi2mm24uXxGNLiXqU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a785595-82da-472a-7415-08de75f756e8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 11:57:11.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o83eInF+89wfgEo+lPH9KaN+hw7WyAe+Wbj9pIM230vPZqD8SrmrCGu57+7Rd1XCzsvn+OTREYM9M2YJP/sgfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7697
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261830-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9208B1B6E1F
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 12:28:17PM +0100, Zefir Kurtisi wrote:
> While I was debugging the issue I extended enetc with features that still
> might be useful; the first change was to selectively process only the
> pending BDs instead of looping over all available, saving a significant
> number of unneeded calls to enetc_clean_rx/tx_ring(); the second adds a
> fail-safe mechanism for potentially other issues taking the same code path
> based on the fact that now a BD is only processed when its IDR is active,
> which means there must be BDs available to process.

We'll perform our own investigation of what is happening when
transmitting short frames. It will take some time.

But I'm not sure I understand what you mean about processing a BD ring
when its interrupt is active. NAPI (Documentation/networking/napi.rst)
works on the basic premise that a single hardirq is sufficient to process
a very large batch of frames, and keeping hardirqs enabled is detrimential
to performance. Instead, NAPI (re-)schedules softirqs until there are no
further frames to process, and only then re-enables the hardirq.

Perhaps I didn't understand very well what you mean, but it sounds like
you want to circumvent NAPI, essentially. When enetc_poll() is called,
you seem to assume it's the first time it's been called after enetc_msix()
has called napi_schedule(). But it's not. It can also reschedule itself,
when the work done is equal to the NAPI budget (complete==false), with
the hardirq _still_ masked.

The correct NAPI behaviour _is_ for the hardirq to be masked for a very
long while, when subject to continuous streams of traffic.

