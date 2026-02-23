Return-Path: <netdev+bounces-260111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCqNOhmCnGnIIgQAu9opvQ
	(envelope-from <netdev+bounces-260111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:36:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C7E179E59
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 581413062673
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7E313E05;
	Mon, 23 Feb 2026 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JvQ0IX4O"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013034.outbound.protection.outlook.com [52.101.83.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E2230ACE6;
	Mon, 23 Feb 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864359; cv=fail; b=GRIoi6ZkKYD8vCaCNVF5pteJ/Jyy+O1idGdW0McmQmOhjcd/518MfaPx67StCQ30gyEyROkSvrbmjT7RDj2Bjme7g2T5CT+MlG+GpZh46mkIa2hmMtG0EvAE+bmhT9b7NQKbxw5nqeZFra3ShGxw5IzbwBibPQ11isQJfeft43E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864359; c=relaxed/simple;
	bh=tV7W4XRPScZym0jf08WsC6N0LXLID7tRvyGrw5fgC+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cvg660HUqmtnQEwrjO4E2tDzg/JX+5kcDfJtRdGn2MlS8rQ7h5HxNKu6jDv1chQCnfFhvx6+Abvy/f9z0mz+s6SuhV0/FreJF5YlaDUg9nNYdZ2xR6Bx3OjDQrDxefmcJCkQ3JehOhc0q9NJ+ZehtTT/C/o90Eu7Sj+ZNsNcngY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JvQ0IX4O; arc=fail smtp.client-ip=52.101.83.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyRkwX3IxJOwIr8AH/qHLLMrl4NcCzK0yKBfNKY9pBwxIfhWJLfciJs01KXscQ6s/l0zBxUTrzSU9iT4U4804nYx/y21HvcPusI/xrszTLtb3B1cqS2Qt1k2VL8zemJHPdLVZo7PchJSgF1tzxd9orXpfYse9tmB+5EyAwCPT0Z96RzKP/bD3gzjOfWx7v43TGEG9VWPdJUTWcbbyMDYPvEDfJTXr6FikrNb8bbrmXJurRf3n3VYsZQuMHUmUWLV6CL9VV8EndWWmvpdq85LwiL7NylheXRnrxAcT82Qio9wkXBeu3rsetaLIBck5+ojnRgcCRXMyOC6JAhfAmtI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsxbE4wHtfprczJ9qwBPyJpidGnmdL8CNbLm227ALEE=;
 b=ClQByZUcWw5F/fPjqrFB06cRWsT9hgXOJq71bj14WHYa+jXKMVTQN3L0YBMpTdcdBz/kK1yeZnJDFGNnwL/txTem6GjryxrrsH0s+ex6abqU0E6zNg91BokZnTTD3XfiqZktRFMpXKjwC3HevFs22QcWZVLbgu9DK+THf/yR8EcudcQzgSqTbbrS+Teto80oJcEo05H5l2bOBqybPpw9/ztB9smeVN1KMkvpCldofnCLaHsFSg0w3O9X5FRKrC91f9LAdCtOai5xrfqKQlbWWcnONgwtvQHe5vvm/LHtWvAWYQyraEW+byQ612cor4jpxOzp0DeyD7euIN3CJBOt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsxbE4wHtfprczJ9qwBPyJpidGnmdL8CNbLm227ALEE=;
 b=JvQ0IX4OTwLZkavpw//gnxB+c86dHu+rwuw3k6EEG0i22F1Wmn02Oj3YsYTjs6dvlWgvAjj7X7ashOwJhD73vPIDIy69cb478XBfYrk2+2BH8s+xznlQQoTfH2vKM+DS86kM06ZggaUoBEdKvGnSnw8/8oVL6AgQinHuRzahlIPBkEmb6w7BvRzry/2G88PJydMCLAACtUTAVAFJNhTkVSGrbIU8Ae8kkXzC9ztAqUzxrnxZVjkuiqTaApJ4ZhBysp9QAJF+hHQM5DB18qgooQrQQwDbX6xVhsGwX+iFZZ4wHogTmHaKTmtvng76CPHYFENBUGRiYsjhsCkY1xM+2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Mon, 23 Feb
 2026 16:32:31 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 16:32:31 +0000
Date: Mon, 23 Feb 2026 18:32:27 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Zefir Kurtisi <zefir.kurtisi@gmail.com>
Cc: claudiu.manoil@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>
Subject: Re: [PATCH] net: enetc: fix sirq-storm by clearing IDR registers
Message-ID: <20260223163227.y3yzzpncyf5a7klq@skbuf>
References: <20260220132930.2521155-1-zefir.kurtisi@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220132930.2521155-1-zefir.kurtisi@gmail.com>
X-ClientProxiedBy: VI1PR0102CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::23) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS4PR04MB9362:EE_
X-MS-Office365-Filtering-Correlation-Id: 4364c844-d6d0-4218-0810-08de72f923d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|19092799006|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2mkX98c3yAqAoYzhMxs/ENclfrqGO3xrmiXWEKuO0eCHcqKsRR+8tuYQm4XZ?=
 =?us-ascii?Q?GhKekPrNMxIqaV4Or0ttDIFVEOjbhHn5uf7PGOFdiwQEoGlPC/oqh9tfOrzw?=
 =?us-ascii?Q?S7bRt1c//0ouJ3Y07eJsswGUbA3r0kSZ6Y1+AMEEeBcwNcI3a+qhX4j+ohed?=
 =?us-ascii?Q?bGwF+DcaAW4dVocDjjEW5TfKA2paK5cdPdc0vj7P7mAWHsom2Q9vvbTIuMrc?=
 =?us-ascii?Q?draymStrEClr3J8lk/a7es5b2XkeF/U/nG4rJqZvCQclSAVhnfpOwvOOtID2?=
 =?us-ascii?Q?StsMOliwIBvRNfYrYzb5NutiwYPur6z2lx636nnYAX7OqHNryxmECcPzgOVb?=
 =?us-ascii?Q?pcEX/6oXaYbvs1jDH4zVOY3/gk4fmjL2QVpQcQEghm4z2HePoyno5FncjsK8?=
 =?us-ascii?Q?jxIAUGfeXXO8P7hlUWYMvntaoktKhVLxslyvyF6sMzDsPb6+Jq7hrp8XWv2k?=
 =?us-ascii?Q?/An9LhuBcxbVeZKLwsKsAVHGBK3q63IynlU22BRurUm19nSHSKYDG5I8GhLh?=
 =?us-ascii?Q?P957hKjxD4lHkMtt/Qn/RxdRoh+XNYGD4gsmAq/RE1K3DbxyEddHNE3asgLw?=
 =?us-ascii?Q?78ep1BbFvBILW1LRUc4fljMwWAmdX4L7FXVyI7AWEyIRDblS5ATnUhu60vxK?=
 =?us-ascii?Q?q4y9PpGQOYHp8+gDXVOw51bj2yg+udjxWN7Gkqf+873PvS1VgZ0ikx4xS5Od?=
 =?us-ascii?Q?7q3/rSPVPrrIDUH/dQ7121uDP9C90g3TKUou0f4zPVZW7tLua1m/K8uKDD9E?=
 =?us-ascii?Q?6gOBULC3C70zWVNTF+ecxyMLjgymzHBT927eKI3K2kj/ofQSj3J4I65taDTw?=
 =?us-ascii?Q?HDYc1Hmxs8/boQG0m+cOtJLsoCvMx90t9tWYMpV6HxTxKte8hxLUMLt7zHwY?=
 =?us-ascii?Q?JbDGlxRzqfAo494yHgB9llO+bJT2FVUzGvrKn6zKijU3oNc40TCEJNDE+cDt?=
 =?us-ascii?Q?9Ha5UCjBvrwLf+noTcHdiy7Otm+kPx+it/9H4yd5rSd0+pcxQSipicUrT2xL?=
 =?us-ascii?Q?/EL39eYFDsE4Tcct0dUWkVejBUaGlTlaY2SP3gdrFB3G4X8Bwqv9Fq5+JzbX?=
 =?us-ascii?Q?Ob0XDPxCfMAs88gFGngh4UhJ2t10/fZ9u5wx6jwDTBP+ehtUXxuExvUjUsON?=
 =?us-ascii?Q?jWVsgpZqNGahXlYxuVoUmd3N95vikSPEdYNQpWgkXfUmIE+e6JHXcNnbCvPe?=
 =?us-ascii?Q?lG12Yb2+NgKoua5WgKcGR7ln1NZtNISGUnUD04qRP+AFn+W1d/sNyLGIMzfX?=
 =?us-ascii?Q?qLVP7pF9negEvwWxznt4U5ChzIUVGjqJ2VkEHhRD7Pq0RoC8tHm3SbNhaTAE?=
 =?us-ascii?Q?PYPU+Jy3L9kEMVhbQcAEiabwsnZGZ5cYJGo8ZnMHQRTTaRgjwB3PbnP8jwUL?=
 =?us-ascii?Q?2PXYMHtmDazUFaP/ur1McftAZzV2sPN27XXjPj3M68dfCb+cmTvDaXjfL+WI?=
 =?us-ascii?Q?MRhzlr1k4YxZbj73ELNgEZRcekgPyzUbUnJWnXWqOqu1/2rMPvsPpFMcSZ1h?=
 =?us-ascii?Q?pN6UegFLf9lh79v/HJh35pSabkDP0GETbdENe9LWcRishAr0pbNLFCriZWmw?=
 =?us-ascii?Q?+gCOZO3ZCwaRKzmgT4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(19092799006)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NdEPgRzCDNr3dLifGmdvDWmpQtoryPb3ppKCYQ9u0VkF0/uldy/01HPehiQS?=
 =?us-ascii?Q?VxqM74KZN10vz8AoSCfWjG0L9XKanhfoMqeRsHEa5N+FmClRmFNuEoKCpoKB?=
 =?us-ascii?Q?qzUa9Yx5EwsS3vxVV1ZjVNC0M/dp0+U/lYW+u8HKg0yTD5ZvXdZ87fjRhZvC?=
 =?us-ascii?Q?SttOM69AJl/ctyof28khNh9dDHB8nFD40KI2TiXBYgfIQEGCSzqNhaCebrC2?=
 =?us-ascii?Q?NUAkBppcRwwE35f3RfQyA+wvsQZ30bZj1G/PNWHJZadrflzazXCjQBy0Zbh5?=
 =?us-ascii?Q?Ry54prHsseOhjes4CjIxkCyo027H3TT5ZvSvNtmPVd6uVWcCUdv9ClS4KElt?=
 =?us-ascii?Q?mmae+I+ia/1oJrYymxq0AANQ3y+rrdawtBfAbyWQR0Jn+3acQxJ4Nx8anzzN?=
 =?us-ascii?Q?aBIxIfT3ywDPBOLZ9D9CSbRFa/G2l/ZuqJeBip/OQ+9iFFAmbP/nqVV5MppT?=
 =?us-ascii?Q?gUyTBPqhNaGWwQuL5aEex0X0ouuQmU6pDqNOCZ7Lvq9nxy9xf4uwj7tbHTuC?=
 =?us-ascii?Q?IhdT2DM/ZmK2gs5q9VWFaatIh3fipxSjVG5puay1z9hg2c8nm8OmPRYQdY5z?=
 =?us-ascii?Q?WDDW3JVoN1u7fBsQaPCeXxmex4jyLt89YsM7ylG3wlrXbKeWUpDKTJSTJi0B?=
 =?us-ascii?Q?1ezSUGnZBtjMSk+Es2hWVwM8WX/hWATVUCnVA9ic2GsgZi9earyr8zg6/y8q?=
 =?us-ascii?Q?rqLxOShZln+oZmPw8bsWoyswuq03HcP2xuPWCAJgZokhIF4UpcBaiHGN7+kJ?=
 =?us-ascii?Q?r/Ckhw6sTCF3IyoPLdwTfn46a8oqGwgjB1mG4J9SUS7T4g6gwac85sApi/XB?=
 =?us-ascii?Q?PxSa4RsyuA7UHLEfXC4+jxvoi3dEBVcZDTOYM3EP0SzM1CUwKGdfQp9IpSd/?=
 =?us-ascii?Q?fXqC+YAUz7iCYqEagnQNFalvpviWWez55GmN9UepRVXFqdvkOFMi4LPWEeMh?=
 =?us-ascii?Q?/j3JhlquQEA+xRFCMi4pAAMDXRtLYYrESw5Lf56uuTg2w5PbANJRE7CX/IcB?=
 =?us-ascii?Q?y0KCzhNVuTT2HoAH0k0Vp1LU/YbcQf4EYQUK+avF3n162to5pZf+GHye1voz?=
 =?us-ascii?Q?Yok/rSkFN2GWpn5Cefb53QVOu/iigtTx4gzyepLNnlV6n04t1UI07Gs3YPQp?=
 =?us-ascii?Q?3gima1I1RxyakTM+jKjnIbxlNcgOgI9mjPHt85sJDgBih5lfHgO6q3k7JG/Z?=
 =?us-ascii?Q?YqTzNVpnfR0+GCBV3hlzMFEz3na2a1Ur4T9WpKma3hqtC76VUBORDO8wtxo3?=
 =?us-ascii?Q?sBG8wRp7CWx6VcI4c/Tozh0vhb/BlOYK8oIJNy/Js24HqSCDfuwvjdBtJI6E?=
 =?us-ascii?Q?X2tgWtcyy+9LC7cOCsKgjdocpTaRlFamIdkQEFJt8VTVag3+IjnmMSJC380l?=
 =?us-ascii?Q?f1W5fdJbX3DDhag0SrgnfOsEuLFLUbjOFKm8Wvg/9ZRbOqE8M+ANb4g6T6O4?=
 =?us-ascii?Q?3ZYvkqLc2KWaEQj1I/bVXbKmls0zdXkj/cEaTRrjnk+Em/GcRCxDxzSuHL6K?=
 =?us-ascii?Q?y0op5+Xhy9VIKhXs+y1lpFL8vw0/03pbJDH51dIdHqrF943YMnlMUZ84T5sq?=
 =?us-ascii?Q?lrDRZal1tziytbNEAG9MTx+gvJh5PHKsJtnBlHUwwSwJkMl5ZhSmeprjSuan?=
 =?us-ascii?Q?D3uULZsamrwuGQjCe1/RZBkLGWn6GT7C0nfiRXTDs96R3alRXOt9vNGZDQ67?=
 =?us-ascii?Q?b4TQ/Y5apWc8a5zDPpBHVkJZU/a5s0QmoAhXOvjah3xlsnoeRoz2DBDTUxdt?=
 =?us-ascii?Q?c4hDZg+td2dxvUuEm5OrK6E2F/gM+tDjdUCVgS4swFkaif1nUMHSCxU14Ore?=
X-MS-Exchange-AntiSpam-MessageData-1: 1yM50bs46R4V7Bw/fqDZtoqF4qwdmiCPB84=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4364c844-d6d0-4218-0810-08de72f923d0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 16:32:30.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 190WYzGheQTBMyXW1FkjqZ6Gr5t/MY0b3qVNmZ6li28DPw8bNCmTyMavfQh3O4QJi3Lf6w4dGBq/K2tsTm9jqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260111-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: A2C7E179E59
X-Rspamd-Action: no action

Hi Zefir,

On Fri, Feb 20, 2026 at 02:29:30PM +0100, Zefir Kurtisi wrote:
> From: Zefir Kurtisi <zefir.kurtisi@westermo.com>
> 
> The fsl_enetc driver experiences soft-IRQ storms on LS1028A systems
> where up to 500k interrupts/sec are generated, completely saturating
> one CPU core. When running with a single core, this causes watchdog
> timeouts and system reboots.
> 
> Root cause:
> The driver was writing to SITXIDR/SIRXIDR (Station Interface summary
> registers) to acknowledge interrupts, but these are W1C registers that
> only provide a summary view. According to the LS1028A Reference Manual
> (Rev. 0, Chapter 16.3):
> 
> - TBaIDR/RBaIDR (per-ring, offset 0xa4): RO, "Reading will
>   automatically clear all events"
> - SITXIDR/SIRXIDR (summary, offset 0xa18/0xa28): W1C, "provides a
>   non-destructive read access"
> 
> The actual interrupt sources are the per-ring TBaIDR/RBaIDR registers.
> The summary registers merely reflect their combined state. Writing to
> SITXIDR/SIRXIDR does not clear the underlying per-ring sources, causing
> the hardware to immediately re-assert the interrupt.
> 
> Fix:
> 1. Point ring->idr to per-ring TBaIDR/RBaIDR instead of summary
>    registers
> 2. Remove per-packet writes to SITXIDR/SIRXIDR from packet processing
> 3. Read TBaIDR/RBaIDR once per NAPI poll (in enetc_poll) before
>    re-enabling interrupts
> 
> This properly acknowledges interrupts at the hardware level and
> eliminates the interrupt storm. The optimization of clearing once per
> NAPI poll rather than per packet also reduces register access overhead.
> 
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
> Tested-on: LS1028A (NXP Layerscape), Linux 6.6.93
> Signed-off-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
> ---

Thank you for your patch and for debugging.

I am not sure whether your interpretation of the documentation is
correct. I have asked a colleague familiar with the hardware design and
will come back when I am 100% sure.

Superficially, I believe you may have mixed up the documentation for
SITXIDR/SIRXIDR with PSIIDR/VSIIDR. There, indeed, it says "Summary of
detected interrupts for all transmit rings belonging to the SI (...)
Read only, clear using SITXIDR."

I wonder whether it's possible you are looking at a different issue
instead, completely unrelated to hardirq masking. I notice that stable
tag v6.6.93 is lacking this commit:
https://github.com/torvalds/linux/commit/50bd33f6b392
which is high on my list of suspiciously similar issues in terms of behaviour.

(note: when submitting a patch to mainline net.git main branch, it's a
good idea to also test *on* the net.git main branch, aka
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/)

I also note that I have put prints each time the driver clears the
interrupts by writing to SITXIDR/SIRXIDR, and with various workloads on
eno0/eno2/eno3, not once have I noticed the interrupt to still be pending
in TBaIDR/RBaIDR.

Is there something special about your setup? What interfaces and traffic
pattern are you using?

This patch should be put on hold until it is clear to everybody what is
going on.

