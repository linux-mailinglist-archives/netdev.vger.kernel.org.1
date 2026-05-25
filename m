Return-Path: <netdev+bounces-291344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHIQNHlfFGqgMwcAu9opvQ
	(envelope-from <netdev+bounces-291344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:40:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 210165CBCF6
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD603012E94
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB23AE703;
	Mon, 25 May 2026 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PtNZmnta"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4F3770B;
	Mon, 25 May 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720054; cv=fail; b=DcMOUvXx0b2WWyELFlqZWbCD2+9B5iKGZ0aMBr9jC6VpX2PqrmgrhYnqPaN/qhA61/m4xtvbBspmnioJk8Zj8TLhl+QtGh0A6FhE8/FbwmL6sQ8iK4ElfXMRNzJKipibxN2a00OI3GpU5rpkfXK+2j480TEx/g6nyftI9lzE5l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720054; c=relaxed/simple;
	bh=xf4ZKn3AXv8tFFLj7vxS7FFnBfn95Trj7s9Q19BzCLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dpwJm+k7aj/EOq1L5ccOdnALm5zSsW7/pwAzby9Lum7i+rLWe04wdc4ewg+xINifWQZws1xWnUXvUOOnQHP2Q8rwqfp/QYt8vDuAgc9vLejYhU+EY6kaN/eaPPoag5EBm4wv4+Ejb3rXAXW2zFGshFw3a1InCWzanZwkpEC4Fng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PtNZmnta; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9Mobncb4twAY4W6u4MvPswBk/pPP0gMFMnwkGIA/cjhpl7uG+x+fCfv4mrnpbtzFrD7uwVaeZCxR3UHM5N2r3aHr7HpP5jgog33qU0bcKk3Tn+Mk5HmTmEhSjlkrCybuxKzMyh+a5pseanUlmyZHZWrYACuTz1tmzs295/2n9UHwbaXMR61SGj7Vw0n6+suxgjwcoQao60ohaYfx7CdavP9anY6tqpld7EhdwZUjt0BtLmlS+NeluVPOajKp0nOGF1FnfqseUmW3zPE0uZfUhr8HeNaqrU0/qJSQTIuZlUFMlAsGZg2SiQu53kfjIzxAs8/T397P8nIhtf8PT8ZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Upap8QOdh/JORNNUVXEj5l8cNgEThnxDjCpSPX0JZLE=;
 b=DkgKxX4kiQYCreo+t0CyJ9KK6oC9R2hw+Sofbc9Gey1Am83Vb3kCIEMmvVsisLx+gcvcIG0AnSet2tnEvMTztR1xGGn8cqdRYgfY2Jw5psufIX3neu4NY2SSbxResSY5sf47j/qwJhCVbnxmQ1xEMGPzmdU3A79i69Mq6GhRjJIxoN/0fVb6Rwy8sKtNNl1c6qvrz4Uusk2Paw5zt5pL2QidWMcO/yP6zCD7wa5pW7NQxaaYJNZCImaLszPPrzO/tHd26RTx9irL5Idq8FGPgtjHOpR8HT/HOdHIAhkhkNg8voMxH98BwdS/kGUGaZzKPrVvY91cHCmBbKCCioZo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Upap8QOdh/JORNNUVXEj5l8cNgEThnxDjCpSPX0JZLE=;
 b=PtNZmntavFRiOOsy+B4Q6iQYro94yyyGEwZcGBM48ukKHe7c26BmwFfQtU09QfVXpl8EsCCOiiAKVU4njpRZNhUpqBZbbJCQ7rizdhNPrHu0Td7WVPUw3THSkgtNqVqrCcu5CoZFB2GmxirxQwV+pVi0T3kE0A67/0tEFxLmJbnQLu/3KRXZ4H40Xue+N/5vO2ye66fqjgMeIbpJ1NU05Ck9ni2ao83ZadM6bO5dhsYzY6Zws7nz6AYAiKHrJNwgVM+TrUsYlpvbsh2IfUiPg1O8/NNpTG/9N1DTywvPK+wpcUyiquT1m5AAhwu5dlwW09stg4kemHMj1WQvl2AeMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16)
 by DB5PR04MB11254.eurprd04.prod.outlook.com (2603:10a6:10:5e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 14:40:50 +0000
Received: from PR3PR04MB7402.eurprd04.prod.outlook.com
 ([fe80::4129:7aed:b5cb:b13d]) by PR3PR04MB7402.eurprd04.prod.outlook.com
 ([fe80::4129:7aed:b5cb:b13d%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 14:40:50 +0000
Date: Mon, 25 May 2026 17:40:46 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Len Bao <len.bao@gmx.us>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eth: dpaa2: constify dpaa2_ethtool_stats and
 dpaa2_ethtool_extras
Message-ID: <ct5fwlsotsgvfjazc3vp4djj7hyi5ix7kreyqf4hohi5537plb@ehqkkzl22vcf>
References: <20260523150737.36988-1-len.bao@gmx.us>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523150737.36988-1-len.bao@gmx.us>
X-ClientProxiedBy: AM0P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::21) To PR3PR04MB7402.eurprd04.prod.outlook.com
 (2603:10a6:102:89::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR04MB7402:EE_|DB5PR04MB11254:EE_
X-MS-Office365-Filtering-Correlation-Id: e20386cc-250a-4c1c-d86d-08deba6b9d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	27tsTZldhnvk2+qDnsKyGXVkNGyUfEfExc0ipxFpCc+UEQ7Xn9vA+l84fNePV127Cf5cbj2uyhlnG0Xd6Vxh/+ZSrVqnHxhuatJ4brYvRISItHxxgr0EeOtWaiJXtWrW/PgXzR3ZcOTZ7fFDaiSCY6xbiGG0+Iifv68/byJe9eLv3lxPlFqfk/qefybYOVTZmAkVFuPkg3MJc0o1uu1569XawijtYJBSj13jQAISMuUBGSJo+XqMzc8nqd892g8a7QMWNgXDp6EmNxZqG5FHjRDHi22L+6tC7C0K5o3t1K+pW0wm7e+zMwxicxsjI6bJjPAox6QAKV/fwfe/gQ0SmA7vXoBeaG7f/M0Iexn8rY5O0mV8M8ilWWYzLdTofyo+hUMRz2OmJcH7gr64KkjkIRauetP1UXkKDCBHlDoTwLDtI0yY4WuRj+E+BuXOczbNPvSeMFKXJHTK/34PO0nJHQSvtJAGABHMoJLfsq3z9nb/LITjexs4OjuNgSRlVp1UAa/rO83daf8Gcs5LdL7a8mEmIbwZFHNsf9iHnyMv+Fp2PoJTrF+cvJ1vk17Ab7JiCNKQFXv43VAhr+3KDZD0pzns6txJ0gSjFqLl8mc6h5uCVeEM7jlv3+H77d4dW4ujgGwbLkc0BV2+rxc33BX0HxVgtd6BhUh7+8v6R9/omHmXAZ8dR6jQQxB2zY2XfLS7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7402.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rhw/TDbpwoaIYwRdYN+G2SyDje6fj0h156weV4HI2Ps+ODfjQk7Z+ObFqd4J?=
 =?us-ascii?Q?3aBo2kinEEpw5dqWFmWEqA9kjFIHWpEZIzpjVj7oLIeiQdXwO4TiZGwSv0Ro?=
 =?us-ascii?Q?VDAvO388w8Bgxatq1UkkIWJhzifi2jEbaSoPfPAaUhj4vLuwqHxTBEdWdqWG?=
 =?us-ascii?Q?UPL6ehHqt4MtcgUlOhCmWWviqg2Qx33/u9UaH0TA4JFumnSC61iQJcuOAGdN?=
 =?us-ascii?Q?aKDl4TfNwxaXNwz8bA+Y0nABcSX360/CLjo/r4Q7GyPVa1+itGCXCudcnOCe?=
 =?us-ascii?Q?qIjrCxuZGjgLMXYcqSANKISlQrIOyLeisodwLi1qtQl8b6vCVyl0pNl9M0DW?=
 =?us-ascii?Q?k+sg6IscZXOOilqANtW9E09OsxNtV+N9cjF6FJQ7sjz0ffpMHb0PAzwUex7n?=
 =?us-ascii?Q?z0rwrc/irgxA65b4jFzRvwF6QIhDuLZas00nfLhdYESVfrhfCYNkJcf8q75n?=
 =?us-ascii?Q?ONt2ZaCT/6AnbbYBYTVu/SkBbxHlvAeTX3DLylAlXxbFFGuT5uvhXE4PvGST?=
 =?us-ascii?Q?pBZh7tX6nfxSAfHjcVMDeT+2cgNqEEVGHT+/vfVKTCeSTLjBA+AKIbPzeTNQ?=
 =?us-ascii?Q?PmEVsJnVWahqksXn+wsLyBGE8G1MXwbB6YRencjqZ8KRweiEOTIcGDaNH20V?=
 =?us-ascii?Q?xyYafnc5eGkA4J0u5ZMmRs6Sb4+vEAl68XWQlY20M+ZGW4ll0slo1SmUBmp7?=
 =?us-ascii?Q?0XnYPJCxUncsOtKV06QHBkLDtCXeubHx69GZ8jhs2sA4xPkVZpEDq0PX7jzz?=
 =?us-ascii?Q?ZNQnJAH8Qg54+DDq9lwi2rXbanAyLMmaJQyJuihu27tuBapIbKAFyy+I/3DW?=
 =?us-ascii?Q?ysufdWRVMGc53kDjeFCbbjBkwWNr/WqlmkessW8EPI7eLzA5Iy0Aj7BtAUKn?=
 =?us-ascii?Q?oYI1Yf41PRU5xhHSspxKMU4vby2zrcnt2xu9yuWhqfJ+q8tXGc55eZiYTQ1t?=
 =?us-ascii?Q?gAZKufVcO13at9qF7ZIuVsM1+0t8RCGyvSFXUJCfp6iuOO9vqpMFnzI9Zpml?=
 =?us-ascii?Q?kq1/Hfd0i0wep5oBVaWEkZ3hSNRBR+fsmrwnvY2z3dP3juVJpZpAROdoBVkd?=
 =?us-ascii?Q?W+Fab3ffAPIT1TlkvFh4M+jqdN3pFFJefONeMVMYBNPRAa4oTQv6YJW++GrZ?=
 =?us-ascii?Q?PCPjMRV31BGcC8aZVECO1ldUbUyXa5aXclhPZ0TOphQP+vhVwZGK12tMGI8t?=
 =?us-ascii?Q?+2hqiN5bdY8HvV/lmrCw8Ee4nNVK235+LEg1ozWQGUGanLCvo+HHiyXiVYCL?=
 =?us-ascii?Q?qXdcX37MXGttCOTEluoPZempv2D6Tq9JVuhoJI42liby92IJf013A5x4XS8q?=
 =?us-ascii?Q?04853hHVkcbyHqn876r4u/vpv6ohj5Lb1EdB8Qa4cF6UD9o3kPrZZr0su3fE?=
 =?us-ascii?Q?BURJ0Rfn28vS5cCvgPih+L6uqsnNu9BBb1k0b77oXVEw/7G3AR6fOZRxhmVK?=
 =?us-ascii?Q?9UGdCEXSfHT0409c4vv/QLNjxeYlZtTKyBtPLLVYfjCGUqfT9Q1wTlvJKg6Y?=
 =?us-ascii?Q?5zi+Bfv8LC8GTQqxygZba4H6Jj1l9WI5+wsFB9/KGcNeKOKRnN/+GYc6TBwA?=
 =?us-ascii?Q?hrQRbgIaDaORKbfcjvT9/k1oQHnc/09fqyF3vx43ujrBw5FB59ZCLSFSY916?=
 =?us-ascii?Q?JfD/TxxJY18ZdvLODoXpCFDZtWYdECUmV6Uox0/js1YpwHiO2mtrC5W4m48q?=
 =?us-ascii?Q?qKrlFV349/I4VwHz0wpGzuqppnMM0HoBY7BW9yOW4GvqIKrKE7x9bOe0b2BA?=
 =?us-ascii?Q?s8hfu9LJEA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20386cc-250a-4c1c-d86d-08deba6b9d76
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7402.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:40:50.0736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scnbQXSYM7b2sS9go8N6G+ArzlXMlRLg8CKEbfLQErx0c+2PTyowhmcs/j9PC73iVo/SEv6aSQhMvFJT7rF51w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB11254
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
	TAGGED_FROM(0.00)[bounces-291344-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.us];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 210165CBCF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 03:07:35PM +0000, Len Bao wrote:
> The 'dpaa2_ethtool_stats' and 'dpaa2_ethtool_extras' structures are
> initialized in their declarations and never changed. So, constify them
> to reduce the attack surface.
> 
> Before the patch (size dpaa2-ethtool.o):
> 
>    text	   data	    bss	    dec	    hex
>   33433	   5992	      0	  39425	   9a01
> 
> After the patch (size dpaa2-ethtool.o):
> 
>    text	   data	    bss	    dec	    hex
>   34937	   4488	      0	  39425	   9a01
> 
> Signed-off-by: Len Bao <len.bao@gmx.us>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Next time, please mention the target tree name in the subject prefix. In
this case, it would have been net-next.

