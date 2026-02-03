Return-Path: <netdev+bounces-256136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H6lBeaIgWnuGwMAu9opvQ
	(envelope-from <netdev+bounces-256136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:34:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62304D4BDB
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B2EA315FBD6
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D5836A037;
	Tue,  3 Feb 2026 05:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jS4rOc9G"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB864369961;
	Tue,  3 Feb 2026 05:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096184; cv=fail; b=GfpqU2aKySOp6zvXvaFisIMkb9cyVCtogym1PAChJuTQighFesNrD4zD7SfYVMtOloMPcHOsh9cdQrwSHzxyDd+2k0+bcjkK3hBTYr4sx7DclxMvEq5x9rPLp4M0F1Y43uRhLKjj/Pg8Qu/kRwMtyt605j/qK/pt4YMRrIZNEqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096184; c=relaxed/simple;
	bh=8i3LPInxHq+0UtpWg0zcqHSko5pxIce0PvKQwcsqLx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oXyGk9L7PSSwYuVdAWUhx9rktOxIPOUKvdqHxx7WKGCGRdL6nDeCvMnNuuysQJAkguEwVcPPdj9t7Ny5mudrEML0UBCBKdLe6wcb4gsf87nXVsxTQ09RqqennFUukEOeJn1s/PYbj5Cg8s7RNmJPFd9KldCcy9YFLITlcDLyYyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jS4rOc9G; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiKKkeYwYqXw3KcbGC18m+OBGQKaUk8EMeBKMhL8s46u8Nb889EYWnxA7mI0saj9elCtpNoIbOnd31SnX4hUwUiRi15lxXPduCRCJHnH2Txv334r/JirNOEVaa1FOkOjVqnVjQomyrGY1KqpTzRwjcARf9ZeesaG1Ld1BSP//x3YkgWn8pxpYF5Y4eLc6GjEv+kCYQ5nl7oNIG4XvNZKLulbpT3G2jz9tqF48UYOvydWJJ/f7ENjZTniRWq5Dg+Vc+BKC0uZD0PbnK+vH94d8HGvDeeEMpWvEzD/c+qVRqspcAEYTkfDP0oB+WNiPOHWuImxI6DwKdeEfzKc4LqbAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeMpnFWY8ZXYWzQzZ/KeeSF0Oe4jebpvFz0TwAu0mhU=;
 b=Hs5WvduPXD3xLsaQh8pS2pS0wWsZx7IqG62oKQxL63cC49S8CplhwVs1OdhY8M/3og1izTRFBI2NdDGn1f3XfZpgJ/Xj82trIfj/XJVu32TeWxxnuu+DaniewUbIrMiuPU1RxWA20wyv5x9nHYJfWp6ycKg4EoAMwCHzlZe+4L5Av5RecKhlvFaGO8JUFbJd7Al+p9i880mRPlp9zv/bUO/sW77RindCXqX62Vo0hhatNyeG0dWHMpwekMW+kn2uTd8K6pGMJQ5WxwFc7P06PFyLSdWIRCwecJ+suUZ401rVEwNC3+WB5y+9FXaAtfGBd4VRTK15GOrBNoPVM/f/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeMpnFWY8ZXYWzQzZ/KeeSF0Oe4jebpvFz0TwAu0mhU=;
 b=jS4rOc9G3FPy5Pp6/i8TjA3GzAy8Ejclsjm3f5b4AiAjv5WpRilDnqOPvLbHVcCRo7kjaMqm38nyAX4gcR4FAfkpSg8wcfxGcS7YiJn64Y4eta86uirOs8DP2EmCiDCI1ulDDzpn8C08UeWf2lqWzh07Ap97FiLoMVkeG9eSChgSO7kP7VV6hVZWgARZ0pMXBeLHUdCZCIRC3b1zOUsDbHLw3GZGOnEryW7FXni7Pdit7/PsObqsDwcqdqZc2o4FAS7R/a7BNRGgCc9DhmXEiETPnnDxNoMSYwUMx2bCWP3kkO9Ztm+0OuZ4NZofLwZ2vVFyHCzA4Z4VwWO8lqtoPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:23:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:23:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v6 net-next 09/15] net: fec: remove unnecessary NULL pointer check when clearing TX BD ring
Date: Tue,  3 Feb 2026 13:23:23 +0800
Message-Id: <20260203052329.1085444-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203052329.1085444-1-wei.fang@nxp.com>
References: <20260203052329.1085444-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f01a5a-fb17-4b91-7712-08de62e44be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3XE/bcHtWB9CTLy4K6ixtAVbzk+s2rMY/FocejfXl3hakp+5UY2Y3sdlJ0QZ?=
 =?us-ascii?Q?d4xFv/K1Rsy6iW0dEomi5DR+LsiXJ5GKhi202suhwkMLcb3JKvj4MPy2d7Cm?=
 =?us-ascii?Q?9WJFfe75P7SwdJbTRb1FfoaLeMfC7o2083AEkg7+Qnosy9RBnger+lX5EiNu?=
 =?us-ascii?Q?OnFDjeBElOFX0/spTr6OXtvwpQjfffdwmqqwWaPfcfcbf5d5JpWxf2TQIC3i?=
 =?us-ascii?Q?hzlZ5de7k6IwS5+V1aZnS/Zndrdbo/AjWgQL2GF3pzu98ceEoZNSEI/O/eH1?=
 =?us-ascii?Q?seD97P3Z/f7EzXqr0FT3vhAnBrN0MxXJ8+9PpKKVHwKCHNfY6zz1eQpBPHYs?=
 =?us-ascii?Q?/2CMqCIhdivoW+wvkj1E/xAWn/pHvZ3YuJhGszD6jeClTNqMbOKYapaz3zKX?=
 =?us-ascii?Q?JaaUfXB0xySy0Ph7nO0y/OlaTTO+gyxlSPhwZEyNFkGnwN43e5YW9ZtfKpBy?=
 =?us-ascii?Q?1PReWq9myvc1b6tEADelXVMdFoE4GJmzTuhFZrz+7rYpV+YrkGbAbDxjVLGy?=
 =?us-ascii?Q?YKPzAj9SWHy9Phu3I44sxozAJrHTJ6lareuh/FnWQAYJhTPAKlvSIu7sWdxS?=
 =?us-ascii?Q?hBKLPwFt/6v0dnrmIvElU7duZfXAuMJOChT4vJUFHq30c5GpKQO7bmaka4Af?=
 =?us-ascii?Q?urndHwIBgM9vnWpA6o6mOnd8fjuhISDzE/DbHJKk9/u/a4q99vDMIUXqZM8w?=
 =?us-ascii?Q?c3aG3GFyt6wdrJ/z8jK2htDWYBcNVf28RV3rwCLFWtWHVB8o0lB4xAxxbzIP?=
 =?us-ascii?Q?qw0NqfZBv5JtFZ1qORZAcelXU0HcNKHFCGkGfXEE+pW16fJHCyW3wDuZM7jC?=
 =?us-ascii?Q?RGXs2rIBL2ECjpRmPPnsPQ1H5xQOFbUPkL/526qzrhwOhBEVLyGAiZOjVE6s?=
 =?us-ascii?Q?srs5lBp04agUi8V8XNJpkBojSbcC9gY4hnMoQbdEeM6LGTeV+pp4/mwGeghY?=
 =?us-ascii?Q?uUYW7+Bb7mw3hiXCK8HfVxElTZRrCAEbehxKvc4NzBfZ5pJckD5ZNCGmUVXi?=
 =?us-ascii?Q?qgj2ExHOyO2yz//BqHiSfJNEfdAzXzdvbSn15b3lmSbUTGdwx1l+o1kXba0K?=
 =?us-ascii?Q?oh0K8CdZ7li55oLQnd3EK9FdXfllvo4HQKS4jrKzRLytZwH2lpSMsoujVx5J?=
 =?us-ascii?Q?kOeUMSYMUy5s1WFLRrjupaHuqhGggLq20+28s8/Dazj/teSILADgwRtObkOP?=
 =?us-ascii?Q?NM8Sdh5tzJRs9KE5rP7zCsIcBhDlUzp4cH9HNJsNlMMs0P6RA0neos0TEsWT?=
 =?us-ascii?Q?iFGeyw8m6nzGpjKs2whp+SS8eWODFuGaV1ZB2v1/8cLatrvvhPTD4oBEkQLR?=
 =?us-ascii?Q?r8Gd4MjoqbxkqopFKfMJ4FG/85I7w1uAhkmTBzwr0knjPKbWtQ7nbJgAXqPf?=
 =?us-ascii?Q?zbx4yugNOpCfjjqVVY9F59VVCHvWpZd21mn7bw/X5MKw9gl4gKh+qT+buGEy?=
 =?us-ascii?Q?xiqnvcEwTQgcQOcelnS50OjLkngxpxVSmSuNTrow4tweUIp7xHEsZ1/sSzij?=
 =?us-ascii?Q?ZjKLDjnxdZI6Rb4TXSuZ4fZ4TjfEl0ZcyALGthdewoSZsXaxBfHA8vwD/h65?=
 =?us-ascii?Q?BYm+rgWDPrtuSeXrEQohVkVIeYCxxyAPX5nIpHHQy9qF9eZCNGwfEVOFuOnW?=
 =?us-ascii?Q?cWPqFtHLS2iBPUn8bNuIyGI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o8lcDFJ33dmeHzgBc4y8eC3aW9F2eLZ2uis9oBw9FHiL1WuPU002y1ZfBjm5?=
 =?us-ascii?Q?2kYu7qi2EI3h/YX5G22eOafp0i1S1J9L1Iy/CLTntUfyD9Eh1mRcdwyTFGce?=
 =?us-ascii?Q?Xv9Njhl9dyMr+unzM74QEpKiMU4jPsjv/CXV+uo0H8qnFby2yLZiA0eHS8Bm?=
 =?us-ascii?Q?Yr5Y3rtW21EgFycubQmcXWVRrWa0xCqSz5IvhMyE0pi4JMbKVs1Upbdkx87Z?=
 =?us-ascii?Q?e6+Q8gk9wee95zKTOzRIAfoziQFFtvmx8KsnPTcM4TO4ghbEq0fpdTyOiFl3?=
 =?us-ascii?Q?MrnCnopmqEkmWqMy2bIF4w29MacwRTg7czVHPg2pBk6S6v12ufLcXiL0PB9Q?=
 =?us-ascii?Q?zWt9hcN+AS+TFN+7jAE8Iso0emLpiDW5pEIkHgVASCtTOaEw3xlKIOWEabz9?=
 =?us-ascii?Q?E0qLf/fuJ7iQ1I4Rz+8J9dror4l25E/7yAzza+ieoe9Xis9qFmoVpYPbyV6s?=
 =?us-ascii?Q?0rHx9/rttDcPvZlKkUnLawp4u2s5KZmE7oB4qdiyDnGYN+0svXSVF/e0Yddh?=
 =?us-ascii?Q?pcZaEc8yYqgggPICJotzd4Cf6cb7x9nlqUS44Ew0UZvRTQ3UiL7kQHg1Ehjj?=
 =?us-ascii?Q?Wp77XsU4H/rIfq6XyTdTRdUz06QF6F71s9/WzHqBS6/4aDJITUe3h18XotH7?=
 =?us-ascii?Q?9zOtITvnl1Z7mWxdRUuHusy6bPKJhwnfxpQxPAae2ouv6YS9gixeUhHLRoWW?=
 =?us-ascii?Q?cMayyQtKH6yhtAwYNAX77K7ZWk975rJbVSJCjXsvKmh4c5JXpP6yBpYa1m7w?=
 =?us-ascii?Q?+7ZgRNJ41bxW3Wi72+kQO5N31mqPQkk0ETrl0mK1xMILYupnINVcvxjbjnQk?=
 =?us-ascii?Q?AvE68lxn8lRcofQ/69cYfheQbBj74VI+/e6IxarvOSTs2MCMdCUoq/vAFasX?=
 =?us-ascii?Q?mDm5Rsl5mXnikx6aEBiLwATEax43pq0QjwqW6rcnf83XlT9q0XmwL7mneNEx?=
 =?us-ascii?Q?+aJ/JxN9k40o10H1ggkvDfp4m78r6WFR2zeO9qRXNJv+3wzjQIjToFedq9PZ?=
 =?us-ascii?Q?FRLDIDCiUeYJ1fIYaWYL1Bp8dLD2IiKPpkpu4jx+VFMIkmS+RoIwyltcb1r5?=
 =?us-ascii?Q?fMU8MR8OfL0POuJNYTI39vQiH+rLMNVtvOCO7BQpcz26s9iMweBEViHwF+dN?=
 =?us-ascii?Q?FS2Dz0jPGE5O0XLR69KJvjxJRwdxDTB2BpmYQCkLzVLQr97UQ9X75oYmi5zN?=
 =?us-ascii?Q?y8lvEyp15rSVCblnTPxlBAgTJNrmtrau6bebg6+Z+3qzSiV7qENT5OQ9ybfK?=
 =?us-ascii?Q?mbygpDfkzYGQR+3oeaH4NjzkAVARzicYsl+QWQP0iHNMVEstmUh6bgjpqidN?=
 =?us-ascii?Q?tI7jB3mXM/d0tDB4geBzIJS7Xe1F7o1Jcsm6otviEKfGt7kdTFTxbllLoCck?=
 =?us-ascii?Q?AXyD2UCnANr5rWG5CNx1oQuo6rbinZoUwWS3FhsE5dWphNLD70qLCqw/+76+?=
 =?us-ascii?Q?SRVmhPhrWabQgIibtiTdDKhLb4wjceXkUv1BcvHqr2/IywhxOrs6vdQ1dw5w?=
 =?us-ascii?Q?kSSsURAqCtFWSgsh83rom9lBXPkhTdNSMqGu61elGC59PsueCQHV5SvuQ/5F?=
 =?us-ascii?Q?MQXdAdpW9r0uMuKpZaNmg5BB6ZDK9CWjZEu/VGEru+kn4+1EuT5pkk/YZIl5?=
 =?us-ascii?Q?XIiUq+CQpyojLPPrn42GXbMHNhrhcZsaeMDGPNpZjh5uCQuFlLEAb9HvAmrD?=
 =?us-ascii?Q?EZS6A8hmBBALc5VA1Kctn/f/SrxWzuKVsjIbN0YAIjIJWMk38mLouoEXj6p1?=
 =?us-ascii?Q?501X/6bTcw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f01a5a-fb17-4b91-7712-08de62e44be3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:23:00.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvjnHRPg+RzXmDQ+1EOM8mTUovPn/Ymx2KY2JmLSDyv5R+1WCHlYcQZshM6fbNVO3A4JK5DvpL2YhofNXQn0uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256136-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62304D4BDB
X-Rspamd-Action: no action

The tx_buf pointer will not NULL when its type is FEC_TXBUF_T_XDP_NDO or
FEC_TXBUF_T_XDP_TX. If the type is FEC_TXBUF_T_SKB, dev_kfree_skb_any()
will do NULL pointer check. So it is unnecessary to do NULL pointer check
in fec_enet_bd_init() and fec_enet_tx_queue().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++---------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e0cea2efb6da..d71615352a62 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1032,24 +1032,19 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
-				if (txq->tx_buf[i].buf_p)
-					dev_kfree_skb_any(txq->tx_buf[i].buf_p);
+				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
 			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
 
-				if (txq->tx_buf[i].buf_p)
-					xdp_return_frame(txq->tx_buf[i].buf_p);
+				xdp_return_frame(txq->tx_buf[i].buf_p);
 			} else {
 				struct page *page = txq->tx_buf[i].buf_p;
 
-				if (page)
-					page_pool_put_page(pp_page_to_nmdesc(page)->pp,
-							   page, 0,
-							   false);
+				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
+						   page, 0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1538,21 +1533,15 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
 				xdpf = txq->tx_buf[index].buf_p;
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
 			} else {
 				page = txq->tx_buf[index].buf_p;
 			}
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			if (unlikely(!txq->tx_buf[index].buf_p)) {
-				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
-				goto tx_buf_done;
-			}
-
 			frame_len = fec16_to_cpu(bdp->cbd_datlen);
 		}
 
-- 
2.34.1


