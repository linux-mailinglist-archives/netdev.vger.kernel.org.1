Return-Path: <netdev+bounces-275732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCVpL2gb1GnHrAcAu9opvQ
	(envelope-from <netdev+bounces-275732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:45:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E113A74B5
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1360308CF69
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D46230F55B;
	Mon,  6 Apr 2026 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d7WNn35j"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5146E2C11E7;
	Mon,  6 Apr 2026 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508116; cv=fail; b=X2g7r/AK5i6J38l1lxKB1fTeO/ii60Lb4Echnm+aWx/YZJBpo3PqJPZ+jXSguX8jJpbzzr69R6XQhRgOkv2qXuR5R0uPjiej3Smp7M+M4JCkAGiImmD5MKj93sW0B8Mil5PTfjJyZQS/5UQm8eW3iKRNjXGIT2JclTYk3XCPNeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508116; c=relaxed/simple;
	bh=ZhHWAytwR0ubCUgf0LTwsz3S85AIRevfns2yZJmeBU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J11phk+lsN447uUCGCDSZsH7tdnOJdv0moCCnP8nKfGUMxd40Eg9dxoeieeAHmwT8fEbwCiHg/SxIcnYzJz5hPIJIDxa/obHB4TPfwltBEnPt7no7e38YCL3uemyQb0Jv+/7insR8Xhg5sXfmbvu+tcYgS4bC7baeCWKNcy8T6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d7WNn35j; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb6yEnNwBXFi+XxyRziDjfBdC91wwgpPraWHCwl+7p61hgOcJyEj8LSzhM2s402O8EfYivviQPJDWkukJ5fR1yo2t08QUAovO+KCYp1cbYbUTiMNRsrXEAlVF+B586IUXHOc8OS13Ww85tkYKLWxQAWpr+JSFiPLmHtZBtoAElpFAZvB+CJtevZGCdef/eN5zKVG4atNRWCGDQXWjLFvCDEu7AEwhb6RrJKBTb5rHR0USYuX2Z+Rd6hb7mO6qi4SinPwtjZu9HrR6hRKzGqBOlRRKaW4G4HT7g7DCFZOXZ778MTxKhA1HzdV5Bnk+0MssJhvqk3iK2pqEPBnyoynWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GevJqQ3FyRixkTsSfoR+g+laWsQI6lBTA3GelCi2mc=;
 b=mDxd/3f0Zkv7+UOG6dVzsd/+KGcXv6xwQidi5RSg3YVs5HsxFd4dgMt4yfkRpQVCxmXoOnnb/UBXMJFWxnNmmO++MTHrhIa/ZLE1sAvIAX8hU3G8e9nSKD/SLwbxt0DwjxwWBkIn2mzRZ4DlXtBNMQte/PJdI88v0xlv16z79Ruyk7i0qFmCV/Ja0YB/nbudQIMw5PaHVdz9yLBgOw3AKgL0/ndn5ZkLlI+Gl8PP/rLEfBKOoUCKqQ7wAvr4jlrm4ijyQ7vUlyICe3kCIx3sev/4Lrfdxhy6DP7xZOmEh6gO33+Bi10ZMcMeRKePSgHPIqxlnyztw6bqA9URJdTC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GevJqQ3FyRixkTsSfoR+g+laWsQI6lBTA3GelCi2mc=;
 b=d7WNn35jZTRhSPojj2IpMKCyVNjPHKatMwijypOjqxINvUWedeBjSEFYGJIb5mlSgtTFxy9wKiqS0j/EwFtHE9mSDoihye+7mBth6eS7aImA/nlrhfT4GnCgcnsFPELFyhYHCP1XjvGZkc8EvXhEpS4+AIBL84MfAYOBPy20YlAl1BLvtCSUVoWJbUbFurCu0TP5voIp7CqQ4UcrwPNC8EOWgziujuv8xiKRm9QLd0x0iQslpjF7CAlJt48JpfVCgHH7HN+HOHRbfCfPoxxFCHIzZAnkT8J8sNCc0rPAmJBFszBYfUxFgPXrs16km3UP93fhWRFNz6PatnAW5aPTMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8347.eurprd04.prod.outlook.com (2603:10a6:10:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Mon, 6 Apr
 2026 20:41:41 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 20:41:41 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 5/6] net: enetc: pad short frames in software
Date: Mon,  6 Apr 2026 23:41:21 +0300
Message-ID: <20260406204122.167237-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406204122.167237-1-vladimir.oltean@nxp.com>
References: <20260406204122.167237-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::26) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e08a1e6-149e-4807-16df-08de941ce871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	H5FDKB8pGTRvDWo73CKzk7KL9AGDIagkDLjITaMt4x2BU4aywiOVH4fduS+MDAg1eTh9toFfGf8tpTVRJV2UeauzjCkSfqK+SBNuOQVrh2Xk1uqKIJbo7whgY4JpIf9pkE6TSu4yF4nGWtJY2zpGT3SIOZTZHwzrtZt73nj8NT5hqsY1XuruLMgUksOL+FFJLoPEKXkC8SPJuknoFMw+SZ+JOqF7GtNmR8QGEZAx2RSi76TjPmXd7Hg+wYM9BPqhVt2ISDj8tOqhLisKoxz6jT7bcrjn7ib7OkG98q6R6gOgZlBmeefOjHQ0TiS8iOIrodKX39MQ1fi1oa022/adc09yyUxhgTNkilGRrmNPqKwmq/iu0iEXjomO3IaB/gxQvXIZyvH5y4+bQs+HGjxS501gOfpqO9Ce7pODb/VT/FpJIFdU6FZSsSWS0BouGmnULkjfEQPI8IMmoBGOTnKZpQb9bix6i8mDF3iiHFNsOyn1NlngPnxYAlcm7rATtD45tBZ5ZllLhlMoWsLSLcUtrsJhBcPu+/YhBcKqlvNhdmXt0MRkifTzMJJuOjEOC6F81swnkqVFkJHFGOKL5w4Mld8LxqL7rB72sY723J+BTZpzHukY2p2In/neuWrBPd69us8uY8ySLZZT9Ezm836EQLJYvhnl4ENP0YI99cCnt2ujlk14A5dLerx2rASGR1Hx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QpeV24DyecPBB23sR8Nbwzg079mwIocjYp3lia2oa8eFk43i0+Z6Tm55CiBP?=
 =?us-ascii?Q?4RgY1e1eA2shZ8jIPTTlVdmulwk9+S17JNvzJZC+V7Prr9KAXGBYD7k/EqQ/?=
 =?us-ascii?Q?IYqLlhSq2D+rsZWnTPfmWzJStM5c6EzOt2tw3pDK2UfhWU+Kiooi3MOntNuh?=
 =?us-ascii?Q?trUupcffCF8NXY+J1T3E5Khl2RpF3aKa4QNYBDS1EHJobv83alMQ79V1O73f?=
 =?us-ascii?Q?rB3Lfz9caCU0/+z0vFWO2UssYK+IpVQJc9mMh4TeB7BpuwouWTHUld88wsId?=
 =?us-ascii?Q?ez1ds8mAQtydwYnXyY6C+mg/hySvEiyq1+OiyDU23EaR/JK7B4nbS7pg9PSu?=
 =?us-ascii?Q?lv5/guGpiu2FVfGA+yj/Aw991hL9VagEVMcJPK434KqdIyk3X9bVucidWiiH?=
 =?us-ascii?Q?nLt3MEyF3S1JyqHaUoK7cLyyZHzDZljRMpvJxWpFkNXcEs/IkfTQa2J3/7cl?=
 =?us-ascii?Q?+b7cq2K8cMcHeO92KVKIkMqVoVYKPhVD7TdeBdW5YY2TRzu9uw9fRbaDUxbt?=
 =?us-ascii?Q?Xr9bQ75PXZwgNBYqH5hpCgici8nO9eMHfJTwpLW1maCQhE4os55v/2RO/fcG?=
 =?us-ascii?Q?G4E6gtH+tPdNAImFL1NKbqbPlWHanm5aFCx5W3wM+4A+pitE+8wVpGkaYxzs?=
 =?us-ascii?Q?YLAEV7zQ5ksHovMMe83hq6b2b+NqY59P7EMFK2v+2gjuzV9jGRfSEmGSH0/4?=
 =?us-ascii?Q?43zNSaJBg0ZERCXMTeApR7VLiRtcLKw9joqoDYxZ/cVAiQtrTkMiM/K7N/UB?=
 =?us-ascii?Q?rG4VxU/AYOri/XPb616m9uvp4ycvXaUBAI/fHsIPZswR4J6bWwe8QvpKLMog?=
 =?us-ascii?Q?xfH5Cv+DzuoZLTMQMjxlxFII8uk7226ibrpT484pmYPnunHi7S6QSrRKZ9Q+?=
 =?us-ascii?Q?MF38Ll/RafzoB/rpIfAtXOngdOLF6TfokM2nxEsefpTi3tpffeMR7XYggF9x?=
 =?us-ascii?Q?pst8QvIoq1N0vXMnGaMq+kUCCUclObmPU1TPrccxAlSzNgGvmYNgfQm/KQEe?=
 =?us-ascii?Q?lsfFlLEETIZopFUSkJq55KquLfki6UCfSDwx1GBpmT3iXmwDHvJ0LCWfTS8e?=
 =?us-ascii?Q?kdsNfqgoVxYKNtISWUAa2yJSN9CBhMTrKqgTwQb73CA34iZtYx5fuvk3+s6b?=
 =?us-ascii?Q?alkIGRUgeG07f+Mr4A1PigLQlY/jW8hks+0sLLbZp6cxrXbINRN+2HHFxuS/?=
 =?us-ascii?Q?6C9z69CjAaFqE9rUv71hLXf1Z0tuDPKlDVv8f+jUmT7Zp1umsIECrkVshBfS?=
 =?us-ascii?Q?Lg1VIs2K9cNQrQuaJyuNDlFZnUO23y3Wew67vaNfrzBl5pI7mscuU66CauE7?=
 =?us-ascii?Q?1bqrM5Vm3U4PQwRVqQhTLaqN4LVi6+FsYsb/vjARWA1VUtAR7CceL5Blts8I?=
 =?us-ascii?Q?JhOknDhLxkHeMLmfBeVMiifc70DHwCeg1JWBaY1ZjSm/ottXHoDewyrcAbgz?=
 =?us-ascii?Q?V0vDyWv5bx10Y8dnc7QmKbUi3ia/FVwBofcbb2Fu016LQJrSxQ/BOM+lPymj?=
 =?us-ascii?Q?45AukQXsTslxrKm9LvFYIqM0qQqVQIL4DeLe2ThkbyaW8vMxJuixI3hZd36N?=
 =?us-ascii?Q?6DjX1MrhjBshwFD3uKVTMKNN9DbCNjCLl4evLf57DIKDHcOQ0PJO+148iOIa?=
 =?us-ascii?Q?oFwLkaKz9tX+RLMKt0VkmSqiFGVYV7lJ91h5dB310lmtr9BkVpTUnzJv1ccS?=
 =?us-ascii?Q?ai4T4bW7z4fE05d/LLz5K90jVsWdXisoTPo/sse6jVCeFRfPCLHV/7wCtIbw?=
 =?us-ascii?Q?1/BNSb1ygXyrfx4N1YOWifV0GKZc5OQUs68X/a0z3Kf0k+p+Kj7b0JPpRtqa?=
X-MS-Exchange-AntiSpam-MessageData-1: kpJ6/SWsHo7LnBe/yBBmQcCynYhB/atJY7A=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e08a1e6-149e-4807-16df-08de941ce871
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 20:41:41.4451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYn6b4AgmAxvc+zUyiA8nMh7zLrflNoX6ivCvwQEC2apPbPfFPrqHEL+fcDWVMp1LSjEidhfaAxrs7LEisDV5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275732-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,westermo.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21E113A74B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ENETC does not support BUF_LEN or FRM_LEN in TX buffer descriptors
less than 16. This is written in the reference manual of all SoCs
supported by the driver: LS1028A, i.MX943, i.MX95 etc.

  Frames must not have a FRM_LEN that is less than 16 bytes. Frames of
  0-15 bytes are not supported.
  (...)
  The first descriptor in a chain must not have a BUFF_LEN that is less
  than 16 bytes.

I don't think proper attention was paid to this during development, we
found the text at the end of a bug investigation. Therefore, the driver
does not enforce this.

But the frame length is out of the driver's control, and the network
stack can actually send packets with skb->len smaller than that. The
result is unpleasant, as will be explained below, so for simplicity
sake, we just pad anything shorter than ETH_ZLEN.

Zefir Kurtisi found a case where transmitting L2 WNM keep-alive frames
through ENETC would soft-lockup the host through an IRQ storm. He later
distilled this into a small enetc-killer.c user space program which
sends a packet with MAC DA, MAC SA and EtherType IPv4 (14 octets in
length) through an AF_PACKET raw socket.

The IRQ storm is actually a curious effect of a chain of events.

The hardware behaviour, when an invalid BD is put in its TX ring, is
that it would transmit the packet as normal, update counters, raise
completion interrupt as normal, but it would just not advance the
consumer index of the ring (TBaCIR) to signify that the BD has been
consumed and is available for software to free. The ring will also get
its TBaSR[BUSY] bit persistently set to 1 afterwards.

It deserves an explanation why the behaviour above would lead to an
IRQ storm, since ENETC interrupts are message-based (MSI-X), and an
unhandled interrupt would typically just be lost rather than retrigger
itself as a wired interrupt would.

NAPI processing in ENETC has 3 steps:

I. the enetc_msix() hardirq handler disables RBaIER, TBaIER and sets
   softirq processing to the 'pending' state.

II. the enetc_poll() softirq handler for the IRQ vector walks through
    the TX rings affine to that vector, checks which ones have a TBCIR
    updated since last time - enetc_bd_ready_count() - processes those
    completed frames, and clears pending interrupts in these updated TX
    rings by writing to TBaIDR. (I've excluded RX processing due to it
    being irrelevant).

III. After the softirq handler does its round of checking all RX and TX
     rings for updates, it re-enables all interrupts in RBaIER and
     TBaIER that were previously disabled by the hardirq handler, and
     exits.

Because the TX ring with the short frame is skipped at step II (TBCIR
wasn't updated as part of HW malfunction), its pending IRQ is not
cleared in TBaIDR by enetc_clean_tx_ring().

But because enetc_msix() disables TBaIER at step I and re-enables it at
step III, another MSI will be fired upon re-enabling it. This is what
completes the cycle and the driver goes back to step I.

So the driver misinterprets the mixed signals it's getting from the
hardware, and ends up causing a software-amplified IRQ storm.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Reported-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Closes: https://lore.kernel.org/netdev/b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com/
Tested-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: handle the BUF_LEN limitation too, independently of FRM_LEN
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 13 +++++++++++++
 drivers/net/ethernet/freescale/enetc/enetc.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index a48ee3040b80..c70df45422e0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1050,6 +1050,19 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
 	u8 udp, msgtype, twostep;
 	u16 offset1, offset2;
 
+	/* Hardware does not support transmit buffer descriptors with a total
+	 * length of less than 16 bytes, or a first buffer size of less than
+	 * 16 bytes.
+	 */
+	if (unlikely(skb_headlen(skb) < ENETC_MIN_BUFF_SIZE &&
+		     skb_linearize(skb))) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	if (eth_skb_pad(skb))
+		return NETDEV_TX_OK;
+
 	/* Mark tx timestamp type on enetc_cb->flag if requires */
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index aecd40aeef9c..819e643538b1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -21,6 +21,8 @@
 #define ENETC_MAX_MTU		(ENETC_MAC_MAXFRM_SIZE - \
 				(ETH_FCS_LEN + ETH_HLEN + VLAN_HLEN))
 
+#define ENETC_MIN_BUFF_SIZE	16
+
 #define ENETC_CBD_DATA_MEM_ALIGN 64
 
 #define ENETC_MADDR_HASH_TBL_SZ	64
-- 
2.43.0


