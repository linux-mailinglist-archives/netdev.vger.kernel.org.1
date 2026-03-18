Return-Path: <netdev+bounces-269208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAf9DMssu2mRgAIAu9opvQ
	(envelope-from <netdev+bounces-269208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:52:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF252C3A6E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EBF9302D08D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721943016E2;
	Wed, 18 Mar 2026 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TwZDSBT9"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7B2DCBF8;
	Wed, 18 Mar 2026 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773874373; cv=fail; b=GMe/8JAMEtcPUSaipboEOE1W2xnUfTjdJop8jdRFb1hUYD7sxp4s83VB5Qd4UvQutI0XRKhAmbm1wcy7aa3PJSjDeiS0H1Zp4cXVtEytmQr5dAF5/EbxEDhukLRGPrlViph2++0YjQF8kNpB/YQ2+cY3a4VXSYmm5cRPzTu4O1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773874373; c=relaxed/simple;
	bh=6cum19OyoeG9XQfCGka8TfpDtU/cmlNP3olDnd7PZxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7e8ScDKlARRzQfIOMxZZx7yfNn/AF2Wg7NaQ8fNHuymDBvRTtPOTbg3X/U6ZPEd3oS2911IzMR7djnLx55wRIYbRRBZpyAY7mYIS/LKMZ0RPVRAt4KLS7iK63W9dwuCK2WdORFF5U/QQJ1r3d/09t1gpw5K44h9NSjvcPqQkNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TwZDSBT9; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUYkvIn0mvr75qCJ3k+GB0/EDycMgKZ12/5qll/LyveDq0zIsetBr1VruDnxdGM63lUw8K2hxouiX8zAdPD/K+6ERoQcxyN9ROf9UeDsGc6umo8tsxIaiGzqzJfQmGyO+pdDCLv8yYv8RugTQyGiljzIZnH/RHwfpQlhn8tmIdRGoH/Ky0vESWHsOzWWdsb3tR4CH1dXhRZgiUEhfaYcMW5wNfGmhmdWH94ZeGnYuQLgiFbrR0jMMOJV2DBbtIj4xQRpINiKzVDwHBRHS8sjE92SJI6moE0q7Ub/p4Nlj2VTbV5P3fy79g2QrnLix7TYfUch1oDg/KKEEmhCxc6EaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1yMMPiir5g8B4m0x4xrMMd4qY5UYJx79IPgHnTMFdc=;
 b=Z2zAyf/NIBooQtPqeOdwLzVs8VOBM1pjra8PE/mE/bjc/E+HR9eg0DEnMKSJ5lnJcsT1J7MOte5cJTFzZCqSux8TlC+KYKt8IiLirqOeMTKDbMu5IDixwQfkyQV5s66SWfYKbiUi+chYEJ6Wgw4lHegeGvzf1HuMbH0Dle24Z1zL3newj0JK9NOui03CCDJVNHt6xaJuiCakZGDMPD3WAIH6LKKXXerk0Tm3UkgadPNQTpAVm6WXAiFgTtAac6ZNXFuDrad6cM9BflqjAXxwxQWTHyUL0/OTnXsPJ912AwBQkDM8d4MunIJ72aRXRcXty+uKOcU4yeEfO6Fn2xrxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1yMMPiir5g8B4m0x4xrMMd4qY5UYJx79IPgHnTMFdc=;
 b=TwZDSBT9wG3+1B2vhivLrj9fnazZq1UEU8BBO6qZSu+mFUeWFjVzAGzFAQAartnDnnAK4FD0ZS11Rzg244N5Mm5YGat0tsCtuGWJJlah0sl7y5AEN5yQ9Ul9R6vM/4Xj5ms0iNF6XnHZg/Ap1pzcPo0Smwm7zt7gff1c9FOHOfPWostAfc6fUKW2GdFSRx/6CM/97BpO8aOmjPV8gTTOUsUn09sndDkU7fzEuhYTz25ohCT9nfVinpxRLkzs9aXYeIJmQOmTMNXxQ2pNOgCGTDGhRok5cJxwpXgx3kCtD/lCT80sjVoeZpkubXIC3M3RGf/w0wVyQqzwboO5S3ZnYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB8PR04MB6889.eurprd04.prod.outlook.com (2603:10a6:10:11d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 22:52:48 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 22:52:48 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	"Clark Wang" <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Frank Li <Frank.Li@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Li <frank.li@nxp.com>,
	Buday Csaba <buday.csaba@prolan.hu>
Subject: Re: [PATCH net 1/1] net: fec: fix the PTP periodic output sysfs interface
Date: Wed, 18 Mar 2026 18:52:28 -0400
Message-ID: <20260318225231.918993-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e2518c8f932fd9da6754b5ab5cc892ed58a0c1db.1773849293.git.buday.csaba@prolan.hu>
References: <e2518c8f932fd9da6754b5ab5cc892ed58a0c1db.1773849293.git.buday.csaba@prolan.hu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB8PR04MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a62d9d0-ad9a-4a9e-04cf-08de85411387
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|921020|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 b8V7d4cVYSc4EWDS3oLa6WMxuHcEwt6HQwFYCqSz1toy4JW91SVD7en9cFOYnMdbCjJhSdkUK7cVdYALJd4ZTtgS3rGclfO4lg3VITlvsqBbpkw7757GocaNG9JCn5hC98CrxnE0Ygy5irt3/h91QBa2tnFQ8hniXPBKiEVm/4cgujQRwURen54vm6+ILxoAqhKpRSSGDKOOBODwrEsMZAQmjpMHDOWhDJJhlPZ6E/2EC/zKphtiv2GYLoM2pO79jrkI+oDVecqm2xzqFndWvwgwIWVA01m0ZwGu3jRb9wSPIpSBQLffZb+Mlv/a+oIIWDHKAt4vX8f2GdYfCleDUlQggWhQ1jNFs+/YQgwtkIv9XHet+u3ILltpypk3r/ra52ovXlWv0rngVf8CacLHCpv25jMS9jeNoIuF0rfWzU7pmN8d434M1+/0OFlun/AYlpKANwBVRpk56sDNz2gbPSpKPfaDJkzKl+iNtMDnkOsqbDnjch8gb/AyieW2U0jPiibPGykFXcvDnu809Sp9sILGFCtGFh2F7ME1kbzjMyEtbwjCSrFYtkkhPD3I9NDGNFKCevhbZdVXCYugv+FDIAUPLErg2GJrI9kPvUi4rcNN/eZ9Pof6DCOC/unzRst/k9IEEC3qsO1d4MwuqEPbeZr/zywklw+UH8UefkOidfSgu4Ofcm1XFq3DjrnamdJEGDRjYrcfTGjyJge5DHd7mfjMNnsFzkhDVUt7JdNBW97+FR+iskKiSI9OMWkcLxAktOJ/iG8Z5bX5GwuDYu1HYJgA1DB6pFV8377LiutGRhNFNigEfDj3KJfIEoDA4zXC
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(921020)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?ubigIE6MiPCPWooEXbBpQLUPTNCaFVDDUdIj6UjIgdXRizbd4gZaZ1B1DjG0?=
 =?us-ascii?Q?tHHHNG5oA51Bw1vA0bNsmd0MlrcsonlK0p1AtGkkpxvQnZ4IwioYrsSwONtk?=
 =?us-ascii?Q?pbRDcE2LGdP54LtDih9pe0V/J6m/hBysDvi2HVlAjXEHSR6pKKDhbnhpOjtm?=
 =?us-ascii?Q?C9DlJhfiGvtOregnDHDeajgPVUjH7S7HnnEgGVGjwDaEXhMEdjeq6GF0nBx+?=
 =?us-ascii?Q?fBYHA13HVefWsMryatohDEUNE4WcxZBGIhomxqyVrNm/XqDfKxlNRVviVqrm?=
 =?us-ascii?Q?AzUXes8fawolmnBeCywiBncyvXSmi61+HAs21iK4hBnsrCA7kHMkUa4vt9Zm?=
 =?us-ascii?Q?U8mPWRRVzY219/Y0HUn1lgDHW8hDuxxMCBXZjIOoB/IFwg9+k7iiVtP58T0n?=
 =?us-ascii?Q?OJ+bcSwsLdA2yh/Kff2zSwGoF5uRNiqJQV95jA/TFHt0kj7iaZQQbH3MzJf/?=
 =?us-ascii?Q?8k0ZcwJ2vcscla4jIyDW9krPG3M0z5OWRhTWT8UbW7G+xWy02nluNflFWgkl?=
 =?us-ascii?Q?8SVXBBWub8zhYwHrdgq+biLrnkpP5m1IoC5yoEHLHQH3wuS4HUhdQv3D+mtm?=
 =?us-ascii?Q?Njc/0uss4Wq8SXDdi6+gT+Qn3uNUIAjD69/Z7bgCmS2DEjlma61tsAUlgSsA?=
 =?us-ascii?Q?VLNEbVHk+vguJM7I9Hpa9yabRwzyEJ0DxADrjItj9ebrwR1B4EBn2cSWMkbq?=
 =?us-ascii?Q?ZqtDCX+X0r9FKSVhRJdBbg/LMPVJCt2lb0yRw2s/roes3sx8GrgisyNh0ENH?=
 =?us-ascii?Q?imthmIFVjSeVwZ57INxU9lq4VzJkIGwkPBc18qHxDractpyRabGcwHPBSwwR?=
 =?us-ascii?Q?7NkoJsnpyoVfZFUR5wc48W6Plw2LP2PM4/HVYGL3ojV4lR1xs9m/BeSf2MtK?=
 =?us-ascii?Q?Hhy1YC5JILJwFb/v9UGDZjiq2os1vPbmKmgsBNBnx7q6E5+jrF+uyGFnt9Ac?=
 =?us-ascii?Q?saB7lTbY+VA/9VpiMsYP3NHKy3/PwGgKMr51tmpNpu3UjRiH32tDQztU3T+W?=
 =?us-ascii?Q?VW5WDWgx+bDd3yuUTcgGNKtQV8/VGIy9+duUwbygFYLXQDOIowmGG784TO5z?=
 =?us-ascii?Q?nZ/xuavAyTUSRI1L8eS1D0qXNq1hTqbE7JlaAJi4HNrxAzAWt1q3/YUHdBDU?=
 =?us-ascii?Q?JbrCHrqL8Lke12kyXVE9oD9FdbKt9nIAxr8V6DdoeL1VTp5Aenshh1aR4L7n?=
 =?us-ascii?Q?+ghUlzSRF3CBw11KxktehrlXvWbX5+BW2Ksa6f/s18GYZB/7hv2OXJVmrBR2?=
 =?us-ascii?Q?/q4BCmp7KkHfHDZ7pvvnBxcYGwLpi1fBYBJdi+SYhrricDAkFZWhV4pY2Vda?=
 =?us-ascii?Q?G/J26SDzGEIi+chK/2TJ9z/rlGJC7GJ/ygv9okXoua6gVZlh7jnzpdsTNlaa?=
 =?us-ascii?Q?hRgpRu0FyJRUqU7CzG+G76IxKChnfA6eIqGCJM3zaVBWUL5pmw/mw67saBi8?=
 =?us-ascii?Q?/Cdl5UGqhgZib9SP8pSJzADauaLOUa9hwQG2fZtGT/4CynliHcYluXtJVFzC?=
 =?us-ascii?Q?7REfpok+WfXAtW/cpfnVxyvx2oZhkQZj7HgL92zly7J1JrXXTFCp9NLz3QhB?=
 =?us-ascii?Q?kGwvpzcSxeUmR5zaGLeOho9C3MlLrbuWgaXOTbKBD4E/92manTHGlkVDGjAE?=
 =?us-ascii?Q?fxooc1uFIQhv56HRGC1ZKm6M17lpMrrEnWME5ftJNKfMrzXgR2kzHg2g/mY8?=
 =?us-ascii?Q?vuRozP96MoCAxAGOeckWjlXlsR9soYmKjhjqNv51/1SAhaATo3UKOM4+edY6?=
 =?us-ascii?Q?vjAXQWlzeA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a62d9d0-ad9a-4a9e-04cf-08de85411387
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 22:52:48.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EeAbhHnROq9IS/XDqcna7zi54rjdbwRNmiKGOBSxRKTJqKjryGjsnolz8bzTzInYYUjTR9LxEr81Ms3jdV0kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6889
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,prolan.hu,toradex.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269208-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FF252C3A6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li (AI-BOT) <frank.li@nxp.com>


> The PPS channel selection was incorrectly implemented in the orginal
                                                           ^^^^^^^
AI: Typo: "orginal" should be "original"

Frank

