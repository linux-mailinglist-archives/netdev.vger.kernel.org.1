Return-Path: <netdev+bounces-256599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMKeOmzzgmmwfgMAu9opvQ
	(envelope-from <netdev+bounces-256599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:21:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D7E2A73
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C1BA308E52C
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 07:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44ED389E17;
	Wed,  4 Feb 2026 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bSO4dtsG"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37737F8B3
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189504; cv=fail; b=TA0VJ3GBvC83TQgEyaObGeWUdNaUiNrfVuv4af3gHgBkJ0W7kZRu3J5gLGZBPRtMBuWGnZXFuPLDUHD2VGBqTJX0GR8e023PNW2/HGpVQJMF/Zu29UCp8izrm3Za7wg28cPfjrFps7vfhj4xB2Y2lF/GIHfgu/evOU7f/B5pwM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189504; c=relaxed/simple;
	bh=lNPQPjwCzMRsTJOGeh5lxm+q8ge0kLkqhZMia22VR50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pMK+HBV3nlRkJdxb/gnK5U83lPLysoGD8MudX6m+KOPOE/fOLi1dXB3O42eMqo2fIRcTNv7WUd6hjEYQtbDyk8g8UDnpjussZ15neRblAhMGHpvRhThIQ7vstKdhrPlMaKKoJWnmmF2ztJwYmooa6+WRWLwfGKg/iDQ1MzT13ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bSO4dtsG; arc=fail smtp.client-ip=52.101.46.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEUl5jmV0WxDOUUC3jfXFBAYzmQ77zYEvoh1WRJRm9IDCYUT8Z4cTKM0hO3bfCmpQtdfsJuTJuGqNklxImg3DL7mccJB0Yi/cchVAxGT6uQ1Ukcq/K394lRE9qr8PyH1fK/zuhXKcvsM82WqT3vgAwUmJVm9t99viir9JiQUpDWkIpZMwfx5S4hfHp3O7XBVL/bUIJTLZnJL7J4hYWpnt6IhjZO2ks4CJS+hofzliOOYb0DTHIGMrxi2ty+Fpw4yBaWjKo9M4hNNkaYXjV/ShzoK1b6/fXk/g7VjppHp3V9URgaABVL3jS8b9H/Kkc2u1sfUj/uCE6PezKMIRYpVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f8IGTzOat5WgU2vd6I10woGe1Ud03W4korxP6MOhU4=;
 b=sMaNipvnPPVtwiDKch+fH2sFcE4u72YZs/PNn/ydxhs6Sahg1R+sE0Ga/AoisIyvldNCg5WdtSYpAVMDYjyHMARaipXrAEx9WQbcw6S9KPmforKrjGbQ31x6yUVWWlXynfP4ahVozU/5RTsM7IVVDKT/0fXmtQCIZzXKpR1pxIRl8841+SCl8E7VyvpXdZ9v5AcW9EJf15b++tPUkg4J7oT2bnE2PyZcmry1JU+1pnR/i+y+cFymqGua66kJY70Kofr94ZKnkFWMu1ODMsMeqTK77XSbvfecDGPNRV9QMjjnF7BdxYl+c/5fN30Vus0N7iLEPHgYJzGrh7zpjGhcPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f8IGTzOat5WgU2vd6I10woGe1Ud03W4korxP6MOhU4=;
 b=bSO4dtsG0+itwEBU1xoN/lqqHU/mFFR5FYsv4XiI4XWOgst5G9Xq7/KU18eiC7Zw+bj+wQLMzXZwACdp8Mglc6L+wkkuw4ybdXl4w+QXxcin0zZjOsoMgxXIZzizkIjKghk4LWfXBdIqWmuB/xDnJ/XdnA8NENVd1hjmjnVD06lfpgHuOXvJu1bjYMWoL/EwRGIchsvK2XwnR1pucaFYk7Eass7g3kpq3DPMXUxy180Vozxwk6xop7VvqJEM1XXFN4lXofa1CNTf/3Rf9CCKbgBPCW42GlgLwIYekwI8QqjOXPmJrknYKnqjH7y9VWOjv856qUZmB7v3GQEMgJ/YQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 07:18:20 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 07:18:20 +0000
Date: Wed, 4 Feb 2026 09:18:09 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net] inet: RAW sockets using IPPROTO_RAW MUST drop
 incoming ICMP
Message-ID: <20260204071809.GA171428@shredder>
References: <20260203192509.682208-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203192509.682208-1-edumazet@google.com>
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 19524659-91e7-4736-7df1-08de63bd9326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AyYvCU9wJylcUhTRjqTDApN7J7dNbzWlNA5MTKQNEpbnGNhoA+w1osE2Xwxo?=
 =?us-ascii?Q?dR9KkLykf0cNxHBQb/aT5ViT9Sgo1t0Blqp/ie8JCz9/TRv4GP1RXDmhwQQ/?=
 =?us-ascii?Q?lshk3wfD9eDvxKUGlZhddR4PE+2PivMkRXViuR92prRGG9YHzAxdDodESOLE?=
 =?us-ascii?Q?11kMpMSfRuMCOgJCrGUSVYGGM15gVStksDeoQEG4r2GxbyrqCLwI1yfw2hoi?=
 =?us-ascii?Q?YnIbwr7fDknIrddeaUX6DAXTvRCaljYYc+t+Y8tSgyN2Fdk0cJ9sSCxFE1In?=
 =?us-ascii?Q?Q1OlnuSf8FpzV8KwHMJuXHZL6ogVU/rzNPXbXv9+nkzkkB+25i62zt9zvLkl?=
 =?us-ascii?Q?qvV73XUSMPPuC79IlPaxFFPOLG4hhJ1WU8bdDyyPbkf38YoWQCl/7aDe1c8Y?=
 =?us-ascii?Q?/RQhbpRNjYsDU8gY/Q1um078QAGcCtSZEDGncK7EqsRW9FzEtTzJZjySXnmv?=
 =?us-ascii?Q?PxtPimdsD2DD116MPEi+JjJ5arHK0WrXNshKl+3XTVz1OsI/eYVqoALonM89?=
 =?us-ascii?Q?JVTEZHosvkPXaftD0SAudkMJhWQpmeYEPfbO0FqWxXOesbUa2pffwwyxfLqM?=
 =?us-ascii?Q?xa11nL0sI1Cc+CT6QhGj1jBkmg4bU4aC0Y07eNw34OpwJ+tS5IAFXxVKsn1o?=
 =?us-ascii?Q?ra219U3gLX5Ct+0oODbE+lbiJaqCGiyX5kCCyx5BNXvIXDati6X8LEOpmwWG?=
 =?us-ascii?Q?ZmBDz5eOrbCzjo+0wjDRnOVTXEjmfNVTxUrLx9wJ9qGd3bdRi5u69rYWOzds?=
 =?us-ascii?Q?p7RLHhYbMdYDwugOSaa5m9pIK1OdPhi/nPMHFgfoN6ELaqUNG351Tm7duJ1g?=
 =?us-ascii?Q?4MmsKOhd2t2AXFRW9H3FQlyETiHEAelQUEQg2QWrtVv9bUpL8kEK3e8Oqyh+?=
 =?us-ascii?Q?HseOsjkMdCa5aQdrqju/Y+mD1Z3eeFjOg+wFR+7Lnkb5izvxmlulCDVLZ3jG?=
 =?us-ascii?Q?fcC6OMHDmGHkJ79JyKhExWR1ICGzI6QtqvhgvjeBPQmMWeDCpQhRlNIk/G5i?=
 =?us-ascii?Q?4q3nLK9v+RuK4WB3jVgTHztJPqQQ+6mgh8haiEKobZ+e3YoY1WsAkzal3By6?=
 =?us-ascii?Q?ngidSrFlRUjmLuJJOfmMaDcs2R196Wd32nowmNxwPmlBmCLSx+JypKMg8pDo?=
 =?us-ascii?Q?OYhD/b9jwPFxjiaWyvxtm8kcnCnzQ06Z9k8J8Daz6Yx5+DSLjB0b7IWKGV3w?=
 =?us-ascii?Q?LOOd20tSXcI2nnDkF7Kt8PieqlHaRpCeZ8hcdIMs7TU4Wk/0D4SUmFc4sEWk?=
 =?us-ascii?Q?CFuBkm3HPSSoiqX+dNzOZAE7z+2KdzFrYu511qo4TQZkYcorhyVSptqGZE7C?=
 =?us-ascii?Q?+ScJ+MMPzwOV9c/FrQa5FjTP08EJBCM6S6CUxseKp72S1N61PkybW2Ga86VN?=
 =?us-ascii?Q?Vj9XV0fCK/miPO0UvIXxke1XPTSj8B718SHscQrLPoiGI4ZXoAH6PVu1r/zF?=
 =?us-ascii?Q?FtZwhnS9rVcZRfyh5evDOPavzkq6HXQ0Ymr91bfHS25NOGbv4QqCW6esCMpj?=
 =?us-ascii?Q?JQNE4uvlbrYWPqSKEDU4dZMMDSkfwjaEHX3Ai4FkSc8A246q/9aLNO+L0LXD?=
 =?us-ascii?Q?dKtOXUlyWgnAEBC9+og=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/kQaVVJ65xpfqATdn9mcp2iVB16RDAMwdGx2P40jil8nkPx1QwBX5WPla8uy?=
 =?us-ascii?Q?OhJJlyjkek8p6jRvDyEnFu1CMoFgNq7eUTs01RfeCJ7MtYwrZaRdSM7Y00Rc?=
 =?us-ascii?Q?zEhIIRC4aGu4cujaUquy6DyRbB/9mmA3dohK4TL97KceynDDJfcaCx8ciwKb?=
 =?us-ascii?Q?PUZfuuDQ0+bJQ5fPVxM58rIYo+IGddIdY+R3GfPhm4xCnr4PpVPZC7k1VF0C?=
 =?us-ascii?Q?VE11BPyiOsrRNHr+zVOVtAYuE5XkOaJvaR0kasnTMCWJbkFfXZd60Wv55Sat?=
 =?us-ascii?Q?iIwQvtJS5bp3Wq7Z7dBQlerAjNrUqFwOJfcoCSWibL37yJTB6+G3Guh/E6+h?=
 =?us-ascii?Q?C2zgx2TIq8RstIeweYq1dVFsKcAlUjwX3b0h6P8Pe9ZjBfaUPN9T2Zeeq9+i?=
 =?us-ascii?Q?mHN2f2d6rk6dMIbq61wFpDEOAOwl6HYYJQ7xfS+Ihz1n7Dv5TjEVxB0bsc+1?=
 =?us-ascii?Q?tJLVhZHYfSbkQshISEPFPlihAf3YtqdMbBNOHALEst5NMYQCxRVMK/24pBO8?=
 =?us-ascii?Q?tjgxP3GNVUTZWF/2Rl3wCuoz5FitTCbn0njCb6kbjgl7IZbsMqd/f+YbZ8rq?=
 =?us-ascii?Q?4pxGV3vl6LsnlXqFNs/S5qE6KXqWzuzT7q6egPM8NkOxzxpwDkvF7JdwubE/?=
 =?us-ascii?Q?T1D1XQY8KhF3kf+b2oLJTDfTTgK2SoygX5PtmMt2d0jbSgl4NDcPERWYM6rp?=
 =?us-ascii?Q?U0IduFItHaHCX/nNNW3M/lTeldOVaA0sdvexEplSuy7w4seo6CAowKY4F3TH?=
 =?us-ascii?Q?p8xjbwwFusCFxWPauwjQKGGpd3hZq0hM7M3HfEbFJanjgkybxKiE2RkLJeHm?=
 =?us-ascii?Q?yMog2z1VDWtK5aptMP/QTGMIVmw2ZZIIceh4kW5YTkP0AJrcf+nALxBkGVhN?=
 =?us-ascii?Q?wP9cX9dEQpUzaew516m0MXJwXguGP0ZCPTTHWqJ1eSWd62i9Iq7NpvQzgHsm?=
 =?us-ascii?Q?A4rn78PQ4SUj+ffatjXuXg6z6yvnWb14UgPbrOpkRAuy3uGCtBjy9H4JFMqA?=
 =?us-ascii?Q?F6kOiIKiNs8bmd3HV+WUZXn5vP2Zgu3PahjRC4Uj3aJcLy/C7+pO3vf2hrgZ?=
 =?us-ascii?Q?TJ+pBkompLOjyuVpTO+JOX1KypQhZL6AsDGLDUI/eCBCY2LinytIaF4ktL2m?=
 =?us-ascii?Q?qrdoOhG4BisuGSWGGOJgdf4t1Jk4Dt8w5r87nhnj9SRl7D/xArGi7fX6gw8X?=
 =?us-ascii?Q?xNXSYPSTv/pkg0t0wOOJTqF8wEsq5IILmeHIZyGil7IMylsxZk8DIzlu6bZb?=
 =?us-ascii?Q?09Oxjc/dnDsOlc3beMgEyR1MBgNaBKToQ+qB0wurBdA9IifF8MogiZWnsIYc?=
 =?us-ascii?Q?TaAp/JOJ+4CvsF1ZlYvslVoxl/i+dPVtYXOEEfXBB4fC2vbZg0MFe6cLQfqY?=
 =?us-ascii?Q?DCRYlFCRMK3iol8F8oew06TTAgXFsQCxvuqLXI0sYGVvKYFuSiKd943y9zoi?=
 =?us-ascii?Q?jSWSrTEohw51AgWA1Ip3XfTmWZp5lWS9SGU+a8Ri8qwHGjQW8jjfdeLAjIdP?=
 =?us-ascii?Q?EA/fAcsv0VNrQf4YhaEYEcY3Rd0rygANxNVDy3F6CkmE4TP0Ulg3mYlBN1OL?=
 =?us-ascii?Q?dxVPOGcvUjzQOhfo4dHRVdAO5dqlB39enuJyOWnt08nBTO13oUlT41b7YNEq?=
 =?us-ascii?Q?4sFM+sGkXOaD0eZBmP9mpXlM3zBof4wB1v0t/dHU1pR6hso7p9R9/nD8aMLr?=
 =?us-ascii?Q?ujzjcEdHGGwHhD2PDibFKtb1dKLxWn+aV+f+kIlYzFrxP9aP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19524659-91e7-4736-7df1-08de63bd9326
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 07:18:20.3479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBYlTRAKsslj4Z1eRxjWV9SW/OpOCQYH6a4rjFytSGutPKbc+87WhupxOziLSaYJHFf0GrpcvcuAFgtlzpDL3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256599-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,mails.tsinghua.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 4F2D7E2A73
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 07:25:09PM +0000, Eric Dumazet wrote:
> Yizhou Zhao reported that simply having one RAW socket on protocol
> IPPROTO_RAW (255) was dangerous.
> 
>   socket(AF_INET, SOCK_RAW, 255);
> 
> A malicious incoming ICMP packet can set the protocol field to 255
> and match this socket, leading to FNHE cache changes.
> 
> inner = IP(src="192.168.2.1", dst="8.8.8.8", proto=255)/Raw("TEST")
> pkt = IP(src="192.168.1.1", dst="192.168.2.1")/ICMP(type=3, code=4, nexthopmtu=576)/inner
> 
> "man 7 raw" states:
> 
>   A protocol of IPPROTO_RAW implies enabled IP_HDRINCL and is able
>   to send any IP protocol that is specified in the passed header.
>   Receiving of all IP protocols via IPPROTO_RAW is not possible
>   using raw sockets.
> 
> Make sure we drop these malicious packets.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Link: https://lore.kernel.org/netdev/20251109134600.292125-1-zhaoyz24@mails.tsinghua.edu.cn/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

