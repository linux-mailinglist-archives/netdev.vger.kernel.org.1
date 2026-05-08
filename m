Return-Path: <netdev+bounces-285855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HWBETPq/WkPkgAAu9opvQ
	(envelope-from <netdev+bounces-285855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:50:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B374F75C9
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF092300F62E
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C335D3502A9;
	Fri,  8 May 2026 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SMhzCgJk"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013023.outbound.protection.outlook.com [52.101.83.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F74B288AD;
	Fri,  8 May 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248213; cv=fail; b=HzXK4hs87meOpUw42nET35+OGHZn3r3Hie6Vt5CwEnbNKLSxcGH37JAQ6E7h27unb57MrzOdT0/Q6x23cUQiW/rgYlXqEJWmUnSvKCQGoBI6r3QWoPtpd0qmqIt+PWQu6lxO5Zkxqzy3mWTGssBV2N2v7n3E7LF+CoMAcWRZs78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248213; c=relaxed/simple;
	bh=cZHe/bbIaSukV8YYdR9VTSpQG2hNM7U5AIVl/5pjj7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z/70LqiSaK64jp1Zw6X4UcTjxCP9ZRk2EzeZ1f/8Roi5V2rmVpZ0UQ+TmtRKDBclIM78AqfYNyi0ZRW/PphqnGG141Biue6mCDp23HcBYp96p+B5Uouu7bM30UgeOiDbiwqXXTVekkUbfnXTVSFDNFrn7yFgUJjyVWOKqNSkUHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SMhzCgJk; arc=fail smtp.client-ip=52.101.83.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPgYpxWkiFQ+6YSzV/VBbIti0hR0f5uHdyoif2BBvDiLuMan5uj4bjtoGX7X+GOimDujRqpZDJ/gEJs6lWKfMxCEsCNP9ICO3mhBVru8NCWfS4a4Vdx7/yDIni6+a2RhKEekGWl7FO0Q/dW6c2b9aNoH4LXSf25orvNSTbHOi8A5s+YCHi69p7JkWQ0/Vt0zKMkZ5MiBuSaEscDwnKDnUqFSNsvwgt93mi0PmT/7pu0Fa1pedLjbxnIBAy/P9Hm/TtmFfcnaC61ZgJZXz22/c9CQG8CwhT/ViFI2/p6esmVPQwGh0eFz6M1CETar5D4RsrKMC/TJsQzQ1D9KNlKyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKyb8oc22Lc4x7qV/EtudqcEZ025DMh44mPZpjSNn1c=;
 b=gMU5AYs5GQ2qZb7pttYyAsG0LasNDGlXgf6Z26pkcQeZqX9GrQElM18vZEWKFEdTmD2Nd94Ho8jkuI0GfZi6bQdsro2iGmuqHgv/dnzCse8EFrvTiamgk0qBzmwRNrL394PJ8hWkYEN9s38eSLJ/wo3KdbYBOJZH5Eojm1CzGdhFsQpFLy13vNGazo4/L0wwuIfTuWwJAZJUndcSFlOfhJr39i+z4dLnMgPHIlSX/zzWID0DVTBi/wUB7fq05GsIhFHDRiCbL3pJgcLDVJfvW1LTaS3Gg5r3vwKHh5VCqqJklPD5SH/1nM2W0zyd4FZFp7KqSFPyW63UksqFSHB59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKyb8oc22Lc4x7qV/EtudqcEZ025DMh44mPZpjSNn1c=;
 b=SMhzCgJkvyR3K4+/xuMFDiQ/ogJ0KbuZaNfe9gUkiEpp0WPlD7xHHncCwuOOrHyLM2fiz3SWOpXuwLkQd2+BXHB4CDo8in9zIRH8WPstPaJU8kyrszgmv6gmwqTBBiYO7C4Ux/oO1C5SAOVCijfKSfMij/g4uIs+6ZIj5iZ9N48xzbGX5CCsYkMLVHR+LcrDLj0KqBr6DWv1TfB6daCGj73UApUIWcDprfIcDXnH1DdTTw37h3uKjCLbFAj6ED2XvlJPGBlvMZzfS9lzn4G0j2E+piS1TsxHK6Vma52xfEyoOHjnz5t3UaF/ea/z6fBtRZSePLaoCD6tkcZvQ6d8PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 13:50:08 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 13:50:08 +0000
Date: Fri, 8 May 2026 16:50:04 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 04/13] dpaa2-switch: extend
 dpaa2_switch_port_set_fdb() to cover bond scenarios
Message-ID: <umivrsfdmjqey665jmqqi332mqul4kf774gjjhxq7f5l73ondz@r57mjfcfjdw2>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
 <20260506151540.1242997-5-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506151540.1242997-5-ioana.ciornei@nxp.com>
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|DB9PR04MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: f695ea27-bff2-44ec-703b-08dead08b75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	v398jS18skOP39d0NTGu9p2qCIgm3YeO8a7pQC4FfST5O3ofH2+xF8UC1k+7ZYFp3NwgiTcmE+iuLemSIMxHefAfYtx88MlljxK8tmi6dQzL5X2UMdqODXLU0OxGmnzbu5FZlK+S9PzbSqapbn8OiEHMWQfDCMOESQ8u63QF6ESyyHOu6rSx85ixWDs2L1pcuCHsB0fERSztBetmaTnf5O/eT3Em+QOX1bF5p1RKhZQAlnJr9P/k4XOyjRp9yLn4J4OrUcq6iXwysqp9k8K8u+7Tvv5mUvSdLECFBh26PD6Sd9RxFn/hAN/JLr1sdc4aC7Km/47FKvEy9IxIC9Cc5Y3tZwpJOp74I2tgpsJmdXUiMA5gn19B8MhRfMuglUxqcx75N3+MATX640/Aj6J9mU9FWEVVLzcM3Zav7R4U+d2UISr0zlj9GNmpZ80VMqPM3Ca5lzkIOp1HzJomd/JHIAinW2uVrz3tQlSFW56ghQLke4cQfif6sW3bp8XzZGKMAFcCPnKKAgRqd/lsW2G+5Q4iicA5ve92JkXHUX9AAzVNzDmJTY6trjaEFQBtHdOIVYl3nOGXYOeVtj7XEaEUUCl1su3oRR13Z2miuucNlLvufthCprVaY8Gs6xeRhsys/hN3FOEdSpYWRnO2vAAhNNjeSMh5hgBGqnqzozZXet04W+rw2h1Co/xgVHu0HEOS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dt63ZHHoze+wxNHXGxWFNRKd4TizH6GLHjAgF5R8dSFMQxfDSPCIBebfTiUU?=
 =?us-ascii?Q?e7S/RSM/7kJBXGLMxKE549f5bs1pvdSYw1EaYLSmeRkcmwZEQFj5L8Ob/eLq?=
 =?us-ascii?Q?cg5Zw6fr9QuucBUwWYyzbFn3LhdOHVxKdvgSkIA0KehyTaKTywiDCSZ+OdM2?=
 =?us-ascii?Q?UmIpV3whVMFbemOoS52xWCnDMrO7R7MBdq6L/7kwCl5PedgZMBTNj1Zl1eql?=
 =?us-ascii?Q?u9RkDE2NKu4kNLh/Lm13h1tDiqBu4rE4kMjtAbvoydTOGXYp6TjHm0r+XFZO?=
 =?us-ascii?Q?9bj4AzRi8WcLOvRtjaQtiIERLRedBO1IM5UL0t/8WT22jyGRp/ULDOzcO5Y4?=
 =?us-ascii?Q?vIdyuJANW8q6Kz78B8ghtov/hKNdUGsQRysO0tfVLJq+iKPwp2ylA808/VKA?=
 =?us-ascii?Q?SfftFQy8TrDBela2kDo9b7orOz9hlnTneUHu2hHanz1DRQgf/AMmknBokwvH?=
 =?us-ascii?Q?Vq2PKUt4yt1U/lZLKO+f2yj686frgrLaxNQOs2zOvo8R2QmwteEaXYydU01D?=
 =?us-ascii?Q?6EPmpvTtjGNfbsvY0JVxJU4mrZ6yr2CUaGRUileCPBMTZDA2hhoy+5T3Xc/S?=
 =?us-ascii?Q?MwmZeat2TeNzjTGdwubw4osYqQeFvPOBby8IbB0+eq4j4G2w+hV6Ej7Dsb9g?=
 =?us-ascii?Q?vE14cCUUxjb+3xIXs6o7BnQG60ur2qRKSlzzKZO6eb1oMuudDXG0XGbroJ6N?=
 =?us-ascii?Q?B895LLWmekx0g77puToXCQYtBfMXeFds+RWU1JcGMnpnklK78DWKPkdZERfD?=
 =?us-ascii?Q?7dGBikqO+QvjRs6mselK9J27X2C46//8SEw/a2Qibv61pq/9j34xTpO0ieYP?=
 =?us-ascii?Q?fDoTI9Dpn1GlOG+EDCoHE5D0EDlPUmUI5Up9Ju7VWkhpgz0FXZjcTi8KffNp?=
 =?us-ascii?Q?G+RXIMU9S3Dde/57PQ1AaffKspvanAeOLnwR/+t+J9CegwDcV0u7ViD01fzX?=
 =?us-ascii?Q?Sf06fDa44eoneBZPWfIWoadhdZ5LFug3kHOO0oC0bHZKeYLFpZh0t9L095BU?=
 =?us-ascii?Q?J1l/8HYpnPqUWKOLpz3ASUVn3+G2Q80nLzOvNeWAOryyxo8X0E9VrlqtZZXZ?=
 =?us-ascii?Q?56q7A6SBjAuTy8VSXs+lQZ+HdB0g33eTpRRfGhBlMsjUSop7cmiVA1g0AMVI?=
 =?us-ascii?Q?cY41jzFUsAXg0W4BZEBP086GSAqY2G8DO31KZjI0YIW5Cgiynqw9r91NaN5M?=
 =?us-ascii?Q?uVdZLf33cI4NQqY10zxpbIwNe+LzNzYQvPaIZBf1ZvHspf6hRq6mcMoT13rd?=
 =?us-ascii?Q?hFSP/tj68btP8rY8RIi/w302gpmD54bjRbKSSULObBW8PDmgKVckBPTY9S+0?=
 =?us-ascii?Q?TTMAYIoxZbcDloXS16LW5/Vy6y1+bETJ2ZGl0oWiipCw4m2QtrSYzVcwk5TV?=
 =?us-ascii?Q?m3Tc681/1tqIoO+zHwaKcoNdcgjO9P9/GqnKkPnZ/GJVtlL8njrgbk2kDoXh?=
 =?us-ascii?Q?FkmpFcO5P2W6j4IJcFP+ZB1pOnOoo3T6f5VZmHq20AsTuyAdPn9AqnCJkuXi?=
 =?us-ascii?Q?oSCtc7cYemBJ/vCOnlm5u5mtMTaB4PuU+hTcKrCIGR0GRZvu+L+R1tawcBh3?=
 =?us-ascii?Q?Xy4D4fSiAAU21yBO05P5R65cG40y9JZaRPqpa6JN+00rnG9qXPx8fM3mZ0RG?=
 =?us-ascii?Q?Qs0wzu/16Dz7v4v8Eld1tvVhgxbuurV/rG5KVp6keWqN2j9LXwi2Cfod9s1i?=
 =?us-ascii?Q?YKyPccjnCOfNN/pHYoL5T69yqn0cyG/BUELqupWfWs7QsJkHlrTS9EQEmh/n?=
 =?us-ascii?Q?96DHzCtl0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f695ea27-bff2-44ec-703b-08dead08b75a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:50:08.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mbst0Ztig4Gns8VsPnHfnQrn0d331ejIl3GJSV1nOFHJ3L5qF3UTMNJqMcMhtrzO/miZAfqFf8TxbmMVQD06Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8429
X-Rspamd-Queue-Id: 43B374F75C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285855-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 06:15:31PM +0300, Ioana Ciornei wrote:
> The dpaa2_switch_port_set_fdb() function is responsible with determining
> what FDB should be used by a port as a consequence of changing its upper
> device. This patch extends the function to also cover the circumstances
> in which a DPAA2 switch port offloads a bond device.
> 
> This will allow us, for example, to setup the same FDB on all DPAA2
> switch ports which are under the same bridge, even though not directly
> but rather through an upper bond device which is bridged. How the
> function does this is by first determining a DPAA2 port is already under
> the same bridge and if so, choosing its FDB. To cover the entire
> hierarchy in depth, we add an extra walk through all the lowers of a
> bridged bond device.
> 
> When leaving an upper device, the DPAA2 switch port must find a new FDB
> to use. If before it just searched for an unused FDB to go along with
> its new standalone status, now it first checks if the port is still part
> of a LAG and then uses the FDB of any port that already left the same
> bridge.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 102 +++++++++++++-----
>  1 file changed, 78 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index f1b4c24b8a47..9d3a0aef1568 100644

(...)

> -		if (!fdb) {
> -			port_priv->fdb->bridge_dev = NULL;
> -			return;
> +		/* Try to get hold of an unused FDB to use */
> +		if (!fdb)
> +			fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);

Sashiko notes:

	Does this sequence introduce a resource leak of FDB entries?
	When a bridged bond leaves the bridge, the first port acquires
	an unused FDB.  Subsequent ports in the bond bypass the unused
	pool and directly copy the first port's FDB, leaving surplus
	FDBs in the pool.

That is not the correct understanding at all. The FDBs are there as a
means to correctly setup the forwarding domains in a switch, there is no
such thing as "surplus FDBs in the pool"

> +
> +		if (fdb) {
> +			port_priv->fdb = fdb;
> +			port_priv->fdb->in_use = true;
>  		}
>  
> -		port_priv->fdb = fdb;
> -		port_priv->fdb->in_use = true;
> -		port_priv->fdb->bridge_dev = NULL;
> +		if (netif_is_bridge_master(upper_dev))
> +			port_priv->fdb->bridge_dev = NULL;
> +
> +		/* In case all FDBs are already in use, we must be the last
> +		 * port that becomes standalone. We can just keep the FDB that
> +		 * we already have. Nothing more to do in this case.
> +		 */
>  		return;

Sashiko notes:

	When the final port in the bridge (e.g., a standalone port)
	subsequently leaves, it will find these surplus FDBs and
	successfully acquire one. The original bridge FDB is then
	completely abandoned, but since its in_use flag is never
	explicitly set to false in this path, the FDB is leaked.

	If a bond and a standalone port repeatedly join and leave a
	bridge, could this exhaust the hardware FDB pool? Once
	exhausted, it seems subsequent standalone ports would fail to
	acquire exclusive FDBs and might silently share existing FDBs
	with other networks.

Not correct at all. The FDBs cannot be "leaked". There is an array
holding them per ethsw_data.

Also, it's ok not to have all FDBs used at a moment in time. In this
exemple above, after an offloaded bond device and a dpaa2 switch port
leave a bridge, it's expected for all the switch ports under the same
bond to use the same FDB, thus leaving unused FDBs.

