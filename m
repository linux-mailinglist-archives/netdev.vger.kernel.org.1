Return-Path: <netdev+bounces-287212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJiDMulBA2pV2QEAu9opvQ
	(envelope-from <netdev+bounces-287212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:06:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA8A52345F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CE8E3067EFB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B137DAD4;
	Tue, 12 May 2026 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GRtAvhej"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011051.outbound.protection.outlook.com [40.107.130.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA8B2F90C9;
	Tue, 12 May 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598143; cv=fail; b=G/pV4La0jKD8l66Fz+HwJsjhDZ12mM+FK99o/Fs6zEbyVMrQeSk7GrD91zKsMIT0/rEj//o141eOh8hl+VBp2WHyqYqYDgZJN7GQQK927D/qCO1R92Eb4pxCYtuif69WbSQQfIhr8RN2bR6Q5oITSoDcqA+4JvqJ9RDUknr/ivo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598143; c=relaxed/simple;
	bh=zIZ1WoKpzI1urqc/846gEctkuF2NhR9ULEXQPL23Pkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kp+i1OblBFX0wf+DmVsArU7drdJx+3P+X4E5enBizdCY610Nsgr6BVKtD6/pvwfKWXCUr8/g5As7t83qDQmAJIFMOK1MNWJ/Nv6j4kWLr7CPgcpJJHL6VRDraf7WzrGjx+yV8xhgav1ECDUMTE/E/jjcQOLW9Bb6EaSQ8ru5rOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GRtAvhej; arc=fail smtp.client-ip=40.107.130.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtgoR8i3LmkmOv1iRCSALKmhlBtmkhGbfAj3SWSBzUaXh17PB1tH2ddJgblqw9sdsZUE8klUoXlZtbtEFiqAAG4/i158AmXE6d5Zg6kbiqaAzKtcFl7qn7KgFL+UEayWtHd4n0N6iUdOgK9eZX+A5kXlXUNanJpsatEZ8XsQZqEKjdRmq1RALR9G8esNGddGYqRlyRTZJEfJmEDZ0bZEuED7R1rivtzI15h8/t3zcI6pZ58ixmGiGGAlpkqz9e+rXd0f3nkuJi9JyiT2IfDBLdWOTsey67uR2z5KDndiq+Us1kSTpMdpooGkj152Rs53+gxLC+FP2WDe3+72yg9rcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11HriuruqBh4gOha/zfmJQefvr6TfRgVKUGZZ9kmfdI=;
 b=ro7mkGjdhQI3yIXnKpxvqkq3Q/c3PGRbCnLyOd+ePzkJqZCKB4pdvblkcfXWYbL5bkYIn8tXSyECZ5QET+curWsXSykjNIXSCCQCPpO5OTNcUIJ3p1bCrmXq/6II0dFu8of09i1ywln6t/coFhJ8NkIPG6eGbpObzKfGViSAIqnwWb5hYKTd7VMcFkXz6o0dRiAeL8IIOvsntshx+xfXzzbHFvAl4I0JWwWJ/McYRjJAZCb0HQUSRYkqrLR+fo/xjAp/gMdo0e5QSjiMg/ok6V2BdtZzhugoKJiU2rFyJi0fPDDkAHs9DxuLILbSMG7NMK2+G60qDzejABzbJ+Qs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11HriuruqBh4gOha/zfmJQefvr6TfRgVKUGZZ9kmfdI=;
 b=GRtAvhejhzq+KFPVenT7gq5gQ3CuL42ixSsPugr969IkeEEOjJKWPPY/+L4zSoUA7cEYcDHCuhPzmi9AUG3XTK2dr7xzocwgG7H86Nn/kxuW89XPuiGZdL4H4tfIWaE2dTLDlWTEsLuwujzNMr/Ig+KtfP/qSqqb96xl6enqpX9rGnWfzCENbdun+Ge0xg70M122f6JaGnZL/rRlaF1Hu7M/++8niKxU7e8ErxWm270T0hufsAabNnrLLkN6gde5A8SrrRrBIax2kc3Flg9iwZ472wwESRJLt3m8IxxncVX4Jbno1x+SbfZPJjRNCu0qQNWpmWSbxPPNEMcs7rfzBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by VI2PR04MB11074.eurprd04.prod.outlook.com
 (2603:10a6:800:277::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 15:02:17 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 15:02:17 +0000
Date: Tue, 12 May 2026 18:02:07 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH phy-next 4/5] phy: lynx-28g: probe on per-SoC and
 per-instance compatible strings
Message-ID: <vwtqexaxle7ohkpjfzq6sq7d6mb6h4vuvy2porpx5wi42jwym4@z5zhbczerwx4>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
 <20260511150023.1903577-5-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511150023.1903577-5-vladimir.oltean@nxp.com>
X-ClientProxiedBy: FR4P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::7) To GV1PR04MB11516.eurprd04.prod.outlook.com
 (2603:10a6:150:284::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|VI2PR04MB11074:EE_
X-MS-Office365-Filtering-Correlation-Id: ae81f7a7-0b51-4856-194e-08deb03774ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|22082099003|18002099003|56012099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info:
	g5ds4NBjzUaTVDcC6vgAkKF6wddAHBg7Phi4T3RsspSBE4b4VJKve2qP2QnZP/R3UorP9zBWdydnskXJ9sCNqNddPH5VCAzuTXYirkDJVVOIabQCaWARWQ6yd5+xP+0JQ6UZoODU7ZJHC5preC/I7WzLDL8mZotfnCqWGJ5JHiPMGkvdEjK8YpNJ+XWSbhe9hd5BUAwDnKORcnqTcLf5rz9lilDKYj+C8YYyFbt9gr0pnH7F7JIXcT/RPCGqO3/yin0Pu0w9cbVbHTYdk4uu5I/fZGboHz0IZBiLOleLYdoyK79VsdPQf2fnXN5fSlB3TDH1NLX5I1C9S/o0y89wibG2JAjVkL4uACxnnT7xlbZ+6O+XSauE20KsUYA+IehgEqvsWiAHpLyy77hWCTJTbhV4SyY3635d395X+ens4ehEoTH4zvUykXSBxyp9cOsGOS/CC0ziz0lN9AdQuNXLXB4iDGJdmo+4gxkfzg/2SaEu4c48I17D/0OdcfWc1jKzcQsFjoCiKRzv8hhTaeLx4xDoLG/3DVum24ROu1VbxuyqK5T3W1IaTVBCKS56hUu3n5RgAFMQv7AbWQjWFfEmmdf36niDDsYKr4vEp0DLibgDybMitNg5d/WS/va73eThhrTEb7Vgmq98A22/f880ZAFm0UppFTOtzccZBv7/Bvdv8Up9yDQ8XlcOBLTVCCu/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gSaeaBf7st9J1KwUAU7O5giXNRysr+tg+l6uYvCf6ZNs3468vSMRbLqxY2pX?=
 =?us-ascii?Q?bHUfupr2ukTVBUEOl+N8oDGZfbDKDKUN1/XIBqjtoVaCT2/gcpthZozqdQ5z?=
 =?us-ascii?Q?rH/3tpAv+UZ5/ZrVBHOtPSO6lyvWKhRSM+Hh74VOJXBvQ1bQ8ha8HbNwJuy3?=
 =?us-ascii?Q?Y9BJFtZvoMnYImRMbOwc/sQMnOw5fnx7IrwrZs0+09exFIkZ+tk42Hwq6EZu?=
 =?us-ascii?Q?Ygub025SDoLdUZg90YjbhO2Ezcn5nIAh1sSAb0b68SHMOtVQxXXZE7Jnk0Mu?=
 =?us-ascii?Q?RJyQtQSsdv6x4BitG7AV4e2wF+N9GwYyxqsqWyzF+WBkT0fXHz0HtMH+AydL?=
 =?us-ascii?Q?HQynL5e89oiKraT0bDkmBK8t5hhfH5/8iuFv2ECmf1qBpiLh8qiDZLVPgkw1?=
 =?us-ascii?Q?CUGRouYrDNa1a6ULIh+OCCAWM6ymER6xUdBghI1lqNphJ2OrUu3qmTV58XXS?=
 =?us-ascii?Q?Jg6h4pK0wLbkxzsmYqIoTZPGDXxg6sJo15wWMeUFJVRHWRj4i1F9elfCmJXr?=
 =?us-ascii?Q?JtfgI9T47cM4jscnFqd73G4UeBVGG7LdCq9WdoalBEXM5Rhl8ml/sXK/W/L4?=
 =?us-ascii?Q?aP9/k1X3N78UyVSWKzooXCvcQQXaZw01Md06FL07wcBHIZCBnWxQUlxxnWKM?=
 =?us-ascii?Q?OHH2yu07ndMSuMbNrgwAJrNrplvYBVdWiAZNi+qk2KKnjjKJBfTRe5Whv0BJ?=
 =?us-ascii?Q?Jr+QEnZJre3nHy4rH9SjAjxPa9PGXUgT2X2HpN14tN1/3AMfwtxYtEXfN0d3?=
 =?us-ascii?Q?BdA+u29JMuJePZEsSE9VPL0k+LWXrA/G5PERRE1wY2tZlBT+bGGQsrg6aBuQ?=
 =?us-ascii?Q?L5nvVyd81mQdIoSOp6afkZ2PkG4mZc/YriuzgV+eUy3M/kr7l+K9Y1tjb2G4?=
 =?us-ascii?Q?BsM879Gb6wGRvaQBhTFVezlVt/jdw82xBwdIxLS3e+5QE1CZ9HFxaxOflNwX?=
 =?us-ascii?Q?erZkCvRNtyd+AlJj9oY5OQUFteZMu1ienJDxmVng1V2iFl7ioVWYpqYl8ptc?=
 =?us-ascii?Q?594vh4GMfcmxlSkasYUc9wCLiTxp+PVSLokgIhp4d8FVHu4i+6VlME8APW0K?=
 =?us-ascii?Q?YkCk2EPWWTxsrek4Zj88WVVYkOlj5yIor4wc6RuSxDSTTEiKOG5QG1XmFajs?=
 =?us-ascii?Q?W4utk/5hIDD0jZ6IXGXWRB6+L3z6W0KSRtrOB2bDU9cUpemIXMqTZsBon6ns?=
 =?us-ascii?Q?JUW+EJZzgpn3ZOzpRX/daPQmg4vmVoHaLKQ/fXinzytlnl30ipgPeOGCisLM?=
 =?us-ascii?Q?M04CiVsvnfAKLJBWIHhn9kqwPuB9nBHIqx91JebDGtulkL+xgzyvvVfNu86P?=
 =?us-ascii?Q?/xEcR4YTHMGQCEotZRDEmY0U3ZAdf9cZgPHqDvBya6YQL3r8rYg8Lwso+e+t?=
 =?us-ascii?Q?3PGLfBSH5+bS4Ia0LexToWQxzAyQRvJFuC4W5BtPzue5IuAjG5r+lDSFW0MY?=
 =?us-ascii?Q?wRklzR23lNJbXW1L5EXpRqnn6nlerjyT+uJ3S7Ws1sblEi3/Z6FPfdX+J2yR?=
 =?us-ascii?Q?ec0r2bUzQ6xgJYPFrRsAxgKRQt+WqK1zZ0AyYUBEWr9dPoehd2UBuPva8cKV?=
 =?us-ascii?Q?/COqBaev7Jz3y1udJbNRfZ9pOx7o90tkts+kjxFSm+45Ko9wnlOykJ7opsby?=
 =?us-ascii?Q?O+0weV+0HUL88f7qNw9DrMSEa7XDVB7gpBBYlHHn3Og+hqNKeoSCmiwdWVOo?=
 =?us-ascii?Q?OXVpe4+0SEVyZSE/czrotWiNXTushhDzW/juFAsMVv4e8jwn1pJOXA0oQouc?=
 =?us-ascii?Q?XMcSNePmTA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae81f7a7-0b51-4856-194e-08deb03774ab
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB11516.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:02:17.5672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l81yN2gPZBH1ZbuwRr6D7wj2DLUZflC+n+8iv78lkCHwoYKmvIswHbJSlBSotzV44UFl3/yGv18VryJ9NEukLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11074
X-Rspamd-Queue-Id: 8EA8A52345F
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-287212-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 06:00:22PM +0300, Vladimir Oltean wrote:
> Add driver support for probing on the new, per-instance and per-SoC
> bindings, which provide the main benefit that they allow rejecting
> unsupported protocols per lane (10GbE on SerDes 2 lanes 0-5), but they
> also allow avoiding the creation of PHYs for lanes that don't exist
> (LX2162A lanes 0-3).
> 
> For old device trees with just "fsl,lynx-28g", the only things that
> change are:
> 
> - a probe time warning/encouragement to update the device tree. This is
>   warranted by the fact that using "fsl,lynx-28g" may already provide
>   incorrect behaviour (undetected absent 10GbE support on LX2160A
>   SerDes 2 lanes 0-5). But we retain bug compatibility nonetheless.
> 
> - the feature set is frozen in time (e.g. no 25GbE). Since we cannot
>   guarantee that this protocol will work on a lane, just err on the safe
>   side and don't offer it (and require a device tree update to get it).
> 
> In terms of code, the lynx_28g_supports_lane_mode() function prototype
> changes. It was a SerDes-global function and now becomes per lane, to
> reflect the specific capabilities each instance may have. The
> implementation goes through priv->info->lane_supports_mode().
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>


