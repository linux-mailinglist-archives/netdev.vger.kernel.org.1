Return-Path: <netdev+bounces-286405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F2yI5X8AGrIPQEAu9opvQ
	(envelope-from <netdev+bounces-286405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 23:45:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5075068D6
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 23:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85323300566A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50A332B981;
	Sun, 10 May 2026 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="YsR2+Gxb"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E628C854;
	Sun, 10 May 2026 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778449554; cv=fail; b=RgWZYeBUG48NtxTVrdbDkE9J5jNZnA+hjdca34G9TtELn6S7R+63Szj93ziktKvkoxyKGnam8nlzLkGlB6YTfme1vZOR0JWgqkyBEALzTQa2TmohHZ/U7N2lVzcl+OxHhlplk1+rT1VE0Rc5nnlJWeJ9tIwxp+izT1upF7JDf28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778449554; c=relaxed/simple;
	bh=r6GqMz98yy33RK7RpKUFTaG9rx2ShHKgSKsplT2ewrE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teDK6qJxSWhlRPzQajaSNPsX92QHxf8c3uIkJaX2JHI1haucXL+PUdh+Qa0Pd0qEFCD91ZI4uw1avKmyHGljUXXm+EUuqhrDnRmCjF6WSEQzFhFa7LWu/f2fpSL9YpkfFu7eRvwP5Lb7r6iu/jDenWQNNjkZM2PLnrzDaPC5f6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=YsR2+Gxb; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIT7HTVEprRP4WlI59q26RDKV5SixFQIToiR/NSfCh/AF4efFbMTX5+ZKAyTMYBn8cFjygEJwA+3xyrGERoLack2wC8QCIW/Qk75tDcD16xz5JOVVLlBaZBJJ2zJgm+A14O/BWEXMYtqq1lc+kvjtYWBtyXPNvwf+8PC5ElOCvtxf8e/pcrMLJNYLwTrS7XrVp5NcgCm7Cp2jDX0q9SHB8yng9bRcx226AslyOTURseutRMkTErRvxMrO1yR9j5l0tj07gYbbx35gqAG3HxeLkqXCp7IyG3tm1DpaHGW1bdPjSanyb3SWxjT2kThVlj4etdLwJ/hIPH35q6fIO7IHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qthZ/2PdiNxc0mlRiDlMuDWCsQMLw4F39hdBFGLwKMI=;
 b=JmsNP1nJjGFknuFk8p/1oO4dfL67ja1ZumZlYzwzkAOL8z271fr4GGby1iEqbIhjmUoLl270DLlMvFUx1OJT9h68KR/W5DVj7xfq/ViWmk3YnJ/dkc0pD6GSFT6W+W6F4E2t6Wn/qdZYm+ECLABLhY38sljPJebKeAkk3obl+lo/3REtgGu14zTzhUbkMY3Jcy14DZzJTCMbpt5HoBMU+7cx2kq4Yd2Kl5EbLDKVwjGLbiMjOiQFqCwJqzfk3OFv++4bGsfw+sUtthKgVLZKEGOnkuYlkU/sENKuK6AOh7HejBxKacl7IEOe5uN83FOJeEl39DUT1zxJGMN+eMFh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qthZ/2PdiNxc0mlRiDlMuDWCsQMLw4F39hdBFGLwKMI=;
 b=YsR2+GxbEWqSGF25mR9KGlBOxbVrABYE1c/9oPvebbP2sNfOASvVCAkW/5ujYF2mSmAspHoyAbb8TdnV+pAc4yFd0Fw19yiEeSXe0xkDE4Cp+xA75E/pg7hDx2tP/yQIJX4j9fNrr0WoEtCw3iQH0RpYNJqpxQ77fQ3GJ3ukxwPJ0t6358RgeCfS+xVvya1wK7+QesU1bmq6p1nqWJwBWr2k/MUyldaAJpg2OoEepIexLX1+BjKeZJEegFbqni3mD3IkWjRUFZAjawW4huMoJ6aS+uX3yhb3yB7LJjmllPye3+aas9/4ofEImqU12XtUjJfJ9It+yfJPHuLeIt+l1w==
Received: from CWLP265CA0485.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18a::9)
 by PA3PR07MB10666.eurprd07.prod.outlook.com (2603:10a6:102:4d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 21:45:49 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:400:18a:cafe::33) by CWLP265CA0485.outlook.office365.com
 (2603:10a6:400:18a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 21:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 21:45:47 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 10 May 2026 23:45:47 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id ADC5F4020B4A;
	Sun, 10 May 2026 23:45:46 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 97FCE1005D6A; Sun, 10 May 2026 23:45:46 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>, <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <fidan.aliyeva.ext@ericsson.com>
Subject: Re: [RFC PATCH 1/1] mv88e6xxx: Cache scratch config of 6352 in setup
Date: Sun, 10 May 2026 23:45:18 +0200
Message-ID: <20260510214518.2064192-1-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com>
References: <20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9F:EE_|PA3PR07MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: f186d094-b580-4d2c-a548-08deaedd7f1a
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ia3DahyoLnzrmtFvRtHx8A8XU8xbMeiWSSaNX9H3OcAhwGz5o1rUIAPhShrPQiFFaNJFh1sbda7y8EX3hKz+AFufJr+DW1O5xSamw5zwvS86m/n5SgizKdB7sngoyZAc7FEP5qpwjSUPPhO9am/4uBwed3YL2IwqyH8MLeCGaXqvphMm3pUPyGi3qpRdISur83VSuHzlZ1sB/7jUkn/9fvxih6KvdHWkIkM8DHqcvCWsNR5uYB9ngec99LLNG/YEL3efxApcfOEqnxGcS4m5FWMl3n2LwKw5WjUgIMx6+D2y6v3yYzXfMAzPB7Fr/8gyocpMZmwGsEbcBSHRPA3pM0fpuxEu4o7pt6XRrgbqERDNjNoDB9MMgh8KFR9lDujggIBCwEpkkv504I+QIuEVhtxm/TbfL6nvfr7SSmQiiapgJ7+uu2nixSy7HYzZUJpdbX2czridGIJLQLL4DG4qOjw0gKuUeUwMR49D14xo8BurJMDWHnnuBLSXfTRNA6baZTWcYAUWOnUT6/iIMeg28wCbP1sHOtbrB9zQkO23n4S0vsJsZqiKd3YKocqM/MZp1bTB4pAaqnhcOOA4nJcMGp1rJfl+1n/gJ/N5WXbZ23RxGYcwHHp+Utkv5e0GDM9eyQI1uG/UqvmrW48ZHve/Gend71j7UCp9u4zdgczw2nWyhNFbXHtm9e6Cs6ch8VtLM3/V7wLQ59aBtjt/Xev8lRdfWUnRBfK7x62qb9TE6Uc=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tK6XoV2n34iRB3xycHIcoaRP5kUiWneFTYNmmx01fpAEuOkf2YaAuYHHv8GgHdFUyqHm00m2Qo9+aOWij2MVng2JNfnWuE13BGNr8gr+DPhMMoQ6X6yLl9aVFeSwVjYo8Gr80KHPMFG1Oyz0E6wYa0uV3GV1m/fUSf3A3TGd5HNf9wL6ji34SFe3EgIE4H0R1o8sWd5C7laexxIkUY18LgQHvDAnMwMPFiX1jLGAlkddA0iKuU0bVIYHfQ77RvWvCGczER4nS2wQlqhO/f78pHvkyTq9PxD5Z53+270fXHwPfdqCSKsTU4F5r/Jjus4QQ64wBgbnL48drFOaM9gCnI2smhJc8vN0wV4+DJLLqmkN5TGZA4fNmPF2T4mLKLtkhIkyu/WLUYenXWZiwnZaUEVxRtXD3tkPbMByTRHe9pilzcB434iuUxTdk54gw+OT
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 21:45:47.6086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f186d094-b580-4d2c-a548-08deaedd7f1a
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR07MB10666
X-Rspamd-Queue-Id: 0C5075068D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ericsson.com:mid,ericsson.com:dkim];
	TAGGED_FROM(0.00)[bounces-286405-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

>
> In mv88e6352 scratch register in Global Control 2 set of registers
> returns which port is attached to SERDES. This value is set and
> stays constant after the switch is released from reset; thus, it
> can be cached during chip setup instead of reading the register
> everytime when SERDES config is needed.
> 
> 1. Add setup_chip_specific member to mv88e6xxx_ops and
> g2_scratch_config3 member to mv88e6xxx_chip.
> 2. Add mv88e6352_g2_cache_global_scratch_config3 function as
> .setup_chip_specific which reads the CONFIG3 value from the scratch
> register and caches it.
> 3. Call .setup_chip_specific during chip setup.
> 

Can we actually use setup_errata for this instead of adding a new member
to mv88e6xxx_ops?

Thank you for your reviews in advance.

Best,
Fidan

