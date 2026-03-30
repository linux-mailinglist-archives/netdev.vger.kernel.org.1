Return-Path: <netdev+bounces-273141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOp+LGtjymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:50:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD2035A896
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCA23300BCB6
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179AA3C9442;
	Mon, 30 Mar 2026 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k/k0GIbE"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2853C5555;
	Mon, 30 Mar 2026 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871188; cv=fail; b=Je360EMz4EjsxFnWQhtIvbSKJ9/tJM3Kdxb2k52Ftks4dR9dFGLxgxnnTyxrxfkZo6YnuDhXTQGXOrHD9HuwMCj+Mx97gFL9cliBmoh7HU+giZE9dcc/wu6yrQ77k9aUtGjG7efaAQHGiwgMqZdr0bTRFCFYcrI4g4T8761ScYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871188; c=relaxed/simple;
	bh=IKqzTwIjnf0oAN/+Ea/LGSO8CchS0oVsb17lg0LIh2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oDqrwlg7u+ejritC6S2vXicnGh5phflEgXm0BiMiUpvS4+zD8G+7ReCyZHFqNG/UqocbKTVVdRbNzdZCmrT8S29+OFfO8BiS73uwe8pVm0ZWLMZa+6vlBkvy9S0Nu2GHgHXoe3OtxofGhw3eKopBGCwinHv+Slh8pa9CtOhuPzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k/k0GIbE; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oF6ltUX4IIQgwyQHCN0vQ1e+/jp1FlUtnEcGTuLAfzFpcZSAIyq3jA6FYuJdfK4/5or8n5IACS6KZhFNUlpz0yW5B2EYdHWVzPZX751sAEmJBSjFlUb2JCJj4ZaaqoKf4h3IeQYPFvjR90xNTUrCwWPp7hNKwBhq3DrUijXmtlCVNeKNt6XrgguhnIrd7eD4fG5SP9lFCzM6rdoMb/nSigqde5rV5R3nm0xw2lTRtxH9MA1W4aEda4IrGydOkFf4zWp+w2mjZIrVuaP7udc2uC5jkWmVmd4lpQPnLg7YjypDT8fNUX2uUz0WgHSn1czk8hZowpfnvwDFidwqsY7lKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fj6ITh1IAT4NXFjhx7MZS5cWsaUT05KqkEuAnTR2Y8=;
 b=vEyKY6o4wvKNhxy5RHn2msa67sQYzuetvOVAViqAhgOjrTEclQ8Ys+rhVsA7+nvu2gS7oLGv3qxnMeGGT4/3t5lZOQBlsBLklLqUeKF4UT0gkhqhHznmxjRAihRbLBCJDEpt55DniBCpeLWZTn5FJxjlD9W8wSYCGqZvCDevS5W9H8vJS0A8ZRyUlVy3NEnZsmj7q3jusV1dAMdJ24pFkMzsCAXSJNcpWRPpu2iJ0HO1cyfUHY4ha1/oaVNvgF4JH5doony1FSgs/6ic6oR9YhKhFiDnnohHWWMjxUm6uHu2ofoUHYRo73+QjVfg2MAIwUdk1UNAt5vsLVOLRndTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fj6ITh1IAT4NXFjhx7MZS5cWsaUT05KqkEuAnTR2Y8=;
 b=k/k0GIbEb+DSdxJPdKUt7PQabk4GLylTw1piZjpWb2+Aq5q5z49swxWboES/AzMxzpzaKyeUASpfTMqO/TRYbuXWcKH8S45QDbYs3PibVGC17Kkx2CEa0zQ37FhdAxjUsGezViplRs2RnWQRZuMTSoUVu1HI5YAqoxXjQPwyL2SwV+xHGmNdgEEycI5l2LjY13u5HnYWREiBr/4HhaMxu6KDz0OcILTwPcUJ5NcBSKK0d5ybIfI92u09mVx+ErSFt8Q1R1xjgDGA8SQjYn3SKYcevtnm7YUgrdWJGQqbuuT00eIfVrN28rafoM+CH6M5uv+9e0fzn7UM55hfD0fR9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DU4PR04MB11815.eurprd04.prod.outlook.com (2603:10a6:10:622::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:46:23 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 11:46:23 +0000
Date: Mon, 30 Mar 2026 14:46:20 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH phy-next 0/3] Lynx 28G: better init(), exit(),
 power_on(), power_off()
Message-ID: <20260330114620.7uvdlxgfgmmmuugt@skbuf>
References: <20260321011451.1557091-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321011451.1557091-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DU4PR04MB11815:EE_
X-MS-Office365-Filtering-Correlation-Id: 52dcf873-3afb-4f1a-5dba-08de8e51f7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7ZJ2DxYRy1jXsJgbkWcizW+awfAMCSoSfNabvk/g57lIsecYF+bCsOKfryjJ0RHOIWSJPj3mModci6HQ0uoeqiY9YpaHocGlBYIHO8lZSUGjrk2cW7RJh0IwBjPfC1T1Q03WQHPt5Tmxu2DpsSUPib94/pTbNIAENTziHgX3O/Bf/onSEinWh2kwsMLf6eh7CqzDRHjX6jLIn7Qb0/or4Mph8dldx7jfro9PrJ2CjAE0fdc5DWzFZ0KUKH17zce7iQnTAjgH3qagnk8Nnum/g8N0SZo+ZoI0D5VKys5wgziNPg6ePPB+VMPaVIhP+txd5O7Y1dDk3ayKPAUryGkMeN8vWcjzB2sXTofuiPkOC/MstMJIEKZ/YuIPV1fRfku1mKfwMWGTe7Q2Cy3SVkaL2f+ZkzOmrl+YQXtfJHQ9vzaJ67LrcV6uWIaxbVyEFMk/OvQQ+S4HYGkr5E8DMLn1ToLflB9+89yn+fJ2UFoFi47hmcMEeeO7SgFaJQSTRdHvSKdv4xtMVXG7ntq66ZjpMzBKM5A8S7UvOgt4A6IxIPZry9W9swO9n5jujlFdITucKkU3QRqFW37BHMfjXa4Kr8nsSVUDs3Eh+o8SV95zj0pi0Rk5zmdEGSjbgHlHXmjyGqk3tznBUE9tSOaFTs5Q4eMaQA82NnDtXAHz3se2mQ4ZU7sGPwbpE6kRK4mpMoz9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5YBDRfSZ4JGbRXLwpjrnU0g2K9YVxk2W01mv7iFvPbPBaZMQaYg4GHdKBD0Y?=
 =?us-ascii?Q?l5YyOc+4scD0Uj0lHyBtyPfcyVZoes8M3qrYo/btsE9xeckZHyg4S7IanMyF?=
 =?us-ascii?Q?LrBZDWPfmveByPyQWKQp4PYx1fUOeYsgUpTMomKl5vVGhvjnYTOG5ooVha7n?=
 =?us-ascii?Q?jBE0IwuSgfLnFXMBRJ90rO5gEA2XsKDxmCc56VBX2KuurxPeF8kkCa0UW0Re?=
 =?us-ascii?Q?xHxNlNxZ3ONSKnsR3Axf4uoKJqFt50Ppr+U8dNJl91RLfFIdRiwJ7aUuStL2?=
 =?us-ascii?Q?7rrH0But7BfKThkM3fEoLMEixqT/jroeRhgEMM8az64Cpu1jsYblge++8lNI?=
 =?us-ascii?Q?50UTAEkDxik8N/suwqFGKhRfKtwK9OyTJ1QXNCCQUpqmr5+pucRJw8bFZold?=
 =?us-ascii?Q?pFPRmTCEqoNGhnSTSO64Q1fiMD3/bouphsICG3cCXLs1kXS2GFt3sFIcV3Xo?=
 =?us-ascii?Q?kJoYrXXoyLRBtio9N9NjkQodJ+RFPvURDO7kZZfVUnbokNSN7xWzh0pNzgzF?=
 =?us-ascii?Q?339aiunTznhnQxcu41I2ZNtXU01qSFFS3MXVsuCSrfyEoxWPFApveSCo4JUf?=
 =?us-ascii?Q?PnnkC5J/v3PTEzeEFM+JMAD7PKMduhEmTuqDWe/+Sa6Oz3h5PhZcSlw6p372?=
 =?us-ascii?Q?7BLNPz9Ehewh38gnq4X5D23JXyRcuOz1F09zPW1y1rYknu28LbdKeWS+3cQf?=
 =?us-ascii?Q?hwLSQvEyzrqo8MvpIQnhB3SlSFXr5pPXxG2zrFpzHe5iQubO7f/EIDhMaVt1?=
 =?us-ascii?Q?tpEejcAIwEe5YaHYkbjQwFE0hURPv3qiAQcQOw0/dtg2n2ZIjpE5MF61bExn?=
 =?us-ascii?Q?i2m9fKxrNBGIEvMzKKp0Y34Qb7gHTdvx1Nqbf3S5FTzzO5KnnWyKQOQ08XkC?=
 =?us-ascii?Q?s5iOQ7uZvbX39+RaFMlgWQEH9nlPUklGhZOdq4RKn0FEhXOoNkq7YILqwXqb?=
 =?us-ascii?Q?y0H21rcXpLfebuKIHL2Q0tfCu4sCkyTwTevp5zivlKyHeYiN5nweG1k2Akm4?=
 =?us-ascii?Q?xrdB5zKBFZ4u7PXY4+AuTR4U3ofE+9I06OOmRgfSl5p6KE1XIEx8DI6tQSTX?=
 =?us-ascii?Q?pRiIpCozLm3Fvwn0y5TKSLRUNcjGqkcUz6/xFzmBIGG0ONRx0hfabdzInRwy?=
 =?us-ascii?Q?FsJjVdux3MFHZjqV1geq5oz8NqPvIUdFVBEli1Ua3bcMRvhpP+sMSo7G+5VY?=
 =?us-ascii?Q?EoLZp6JWaW+p4AmigyncwPW01g7uCMC1fqR4YjSKviuoQWNdQdn2b3NZ7KWV?=
 =?us-ascii?Q?DzRiYkcfDlA7g4/kzBHqkZX5QSIbRQku0RT8BPA7zwlc5Tv9VnWSL4qM52i7?=
 =?us-ascii?Q?T5OOdXEaBFsfPPj2DGtUxxdgTR4tdtLuz/yLxqFj97bF7f798qZyykfVq374?=
 =?us-ascii?Q?8q+dEetO6NgALTwAGJKYbIpsYS5q545N5urK9hIc75reH/t7VG6SpiENNSe0?=
 =?us-ascii?Q?wpvKlIfzCM0fPbhFWdFexNSdRHxRy6MZrBTuc7YHg4qwastffLAi0MBJ3IlF?=
 =?us-ascii?Q?tgQTE8rX5W9uh8MecmYTQSK+kKN9MWg2N3Z7wGwACwCywTJqjDh9dkzO9IQ3?=
 =?us-ascii?Q?/dvRNGT9z+WpQfI6+JZPui3f+uVuDOgMYEEnSY0HOL5ir5wC2RkKHr4EYA3m?=
 =?us-ascii?Q?7KXiiEOLPWsVepoZEtFiVn56j+PJpcgjiXamWtkcky2y10kH4uE/31HP+BVa?=
 =?us-ascii?Q?TlG1G+YnxX6a0R7UZw1YRHuGONjfRu497c3YU/6Yqp1WspZJDScvptIoEAIk?=
 =?us-ascii?Q?7SuvIe9r+Bolvp6cXUbgthzmFQGYn3FSXi7ko1mdhvz36+LuXUP+4ZWEIeOs?=
X-MS-Exchange-AntiSpam-MessageData-1: JSqwlddShgvFpwF5oqno2nG/CerCdbnwcwY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dcf873-3afb-4f1a-5dba-08de8e51f7be
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:46:23.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmc2gsrwLLBEAPGdvhp1nHRL0EI68/q1ge7RDlk6k+EtIfDn4lg3xcfLiRSf/pChdOjLclzfvHU/qC5v/RIADQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11815
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273141-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail,sashiko.dev:server fail,nxp.com:server fail];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 9CD2035A896
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 03:14:48AM +0200, Vladimir Oltean wrote:
> This is a set of 3 improvements to the 28G Lynx SerDes driver as found
> on NXP Layerscape:
> - avoid kernel hangs if lane resets/halts fail due to other bugs
> - actually have phy_power_down() cut power from lanes, not just halt them
> - allow consumers to call phy_exit(), to balance the phy->init_count
> 
> Especially change 3 will allow further development of the dpaa2-eth
> consumer. To permit phy_exit() and other patches in net-next to be
> submitted in this development cycle without functionally breaking
> networking, please apply this change on top of v7.0-rc1 and provide
> it as a stable tag to be pulled in netdev.
> 
> Vladimir Oltean (3):
>   phy: lynx-28g: use timeouts when waiting for lane halt and reset
>   phy: lynx-28g: truly power the lanes up or down
>   phy: lynx-28g: implement phy_exit() operation
> 
>  drivers/phy/freescale/phy-fsl-lynx-28g.c | 190 +++++++++++++++++++----
>  1 file changed, 157 insertions(+), 33 deletions(-)
> 
> -- 
> 2.34.1
>

I've analyzed the AI review output from
https://sashiko.dev/#/patchset/20260321011451.1557091-1-vladimir.oltean%40nxp.com
and I don't consider anything from it to be actionable.

> > @@ -1065,7 +1097,7 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
> >  	struct lynx_28g_priv *priv = work_to_lynx(work);
> >  	struct lynx_28g_lane *lane;
> >  	u32 rrstctl;
> > -	int i;
> > +	int err, i;
> >
> >  	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
> >  		lane = &priv->lane[i];
> Can this dereference a NULL pointer for unpopulated lanes?
> If the device tree contains available child nodes, lynx_28g_probe_lane()
> is only called for lanes explicitly defined by the "reg" property, leaving
> lane->phy as NULL for the rest.
> Since the loop unconditionally iterates over all LYNX_28G_NUM_LANE (8) lanes:
> 	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
> 		lane = &priv->lane[i];
> 		mutex_lock(&lane->phy->mutex);
> 		if (!lane->init || !lane->powered_up) {
> Would it crash on mutex_lock(&lane->phy->mutex) before checking
> if the lane is initialized?

This is fixed as of commit
https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?id=a258d843a3e4cb687da19437f8f81fee55ad7d35
not present in linux-phy/next.

> > @@ -1081,9 +1113,17 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
> >  		if (!(rrstctl & LNaRRSTCTL_CDR_LOCK)) {
> >  			lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_RST_REQ,
> >  					  LNaRRSTCTL_RST_REQ);
> > -			do {
> > -				rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
> > -			} while (!(rrstctl & LNaRRSTCTL_RST_DONE));
> > +
> > +			err = read_poll_timeout(lynx_28g_lane_read, rrstctl,
> > +						!!(rrstctl & LNaRRSTCTL_RST_DONE),
> > +						LYNX_28G_LANE_RESET_SLEEP_US,
> > +						LYNX_28G_LANE_RESET_TIMEOUT_US,
> > +						false, lane, LNaRRSTCTL);
> > +			if (err) {
> > +				dev_warn_once(&lane->phy->dev,
> > +					      "Lane %c receiver reset failed: %pe\n",
> > +					      'A' + lane->id, ERR_PTR(err));
> > +			}
> Since dev_warn_once() uses a static boolean flag that is evaluated per call
> site rather than per lane, will this mask errors for subsequent lanes?
> If a receiver reset times out on any lane, the warning is printed and the
> static flag is set to true. If any other lane subsequently fails the reset,
> the warning will be silently suppressed.
> Would a per-lane state tracking mechanism or dev_warn_ratelimited() be more
> appropriate here to ensure multi-lane failures can be diagnosed?

Unjustified complexity for an error case that should never really trigger
in production environments.

> > diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> > --- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
> > +++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> [ ... ]
> > +static int lynx_28g_power_on(struct phy *phy)
> > +{
> > +	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
> > +	int err;
> > +
> > +	if (lane->powered_up)
> > +		return 0;
> > +
> > +	/* Power up the RX and TX portions of the lane */
> > +	lynx_28g_lane_rmw(lane, LNaRRSTCTL, 0, LNaRRSTCTL_DIS);
> > +	lynx_28g_lane_rmw(lane, LNaTRSTCTL, 0, LNaTRSTCTL_DIS);
> > +
> > +	err = lynx_28g_lane_reset(phy);
> > +	if (err)
> > +		return err;
> If lynx_28g_lane_reset() returns an error, the function returns immediately
> without setting lane->powered_up to true. Does this leave the hardware
> powered up while the software state considers it powered off?
> If a subsequent cleanup calls lynx_28g_power_off(), it will check
> if (!lane->powered_up) and return 0 immediately, leaving the DIS bits
> cleared permanently. Should the error path restore the DIS bits before
> returning?

Same. If lynx_28g_lane_reset() times out, there is really no way to keep
the software state in sync no matter whether lane->powered_up is true or
false. The lane is broken regardless.

> > @@ -1007,7 +1074,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> >
> >  out:
> >  	if (powered_up)
> > -		lynx_28g_power_on(phy);
> > +		lynx_28g_lane_reset(phy);
> >
> >  	return err;
> >  }
> If lynx_28g_lane_reset() fails during the success path where err is 0,
> the return value of the reset call is discarded and the function still
> returns 0.
> Can this hide a hardware failure from the caller, misleading the MAC driver
> into thinking the link is successfully brought back up? Should err be
> updated with the return value of lynx_28g_lane_reset() here if err is
> currently 0?

As explained in the commit message, handling and propagating the
lynx_28g_lane_reset() error to the caller isn't really any better.
The caller would think that lynx_28g_set_mode() failed, thus that the
mode wasn't changed. But it was changed.

I do not plan to send a v2 to address any of the change suggestions above.

