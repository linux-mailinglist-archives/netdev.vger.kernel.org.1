Return-Path: <netdev+bounces-295734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 34M/DrmTImrLaQEAu9opvQ
	(envelope-from <netdev+bounces-295734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:15:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7CF646C45
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:15:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=wibbTZjh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295734-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295734-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBF1930553CA
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2F84BCAB1;
	Fri,  5 Jun 2026 09:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D124F4BC02E;
	Fri,  5 Jun 2026 09:01:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650085; cv=fail; b=TU92HiHpJtKYJhl+de1LGKmu+9m+fmpGFyCA1RXXdptyoFxSkKldA3G1dUJvaFV4rABHvgiupLw1fxB0q0EE+vdRnu1y2YA6vUYa77bnAfChBMdIJQufab0GVpR6Rmpk/s5JsXkG38xaz/Jne9tIOAsvk5rtXVt0DK2f/JGLrxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650085; c=relaxed/simple;
	bh=v9dxslsTPqb3WtvX0rHFQRbfj3DDkbQiXwf6feW8Nbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iy+W4oroypleyL8u7srffWzhn8MdTKeOsS1IvjVS6UtIM54Z6UFWdZzwns47aL0HQMANeAszonGqToRIgraHGl2pDhPmUeetI5u4EdHWsHuWHeOshDyhXpXnbbJjJ8LNitRJG/zPisGS1f6R+MJYEeBVxLBAtZsZw023wXA6l8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=wibbTZjh; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kh1VunW0oL7g0XPr1KSn99nGDpav3XI3yy/vit1COvJu5I7sErH2tJAONdkdNTET97MCQdAB1i12edC0WG3JXHSvoYEOKlJM9gjc9XmNzegGL1fj2TdSlY/yHOlUQB17pXPK93lfU66/SB3HyNat82ufxUJJXGtNZL0pn31CEBTcnyNOLaaP7JXoEbjbt9NRkSKsHWQGVxRiE6pFcTVjtMdbn/ch6MzhRMd/BUO1eQredjziJ4K+8bFYSfMpZUbvDdeIWwW5AmKulXZXZpH8Lam8k5OiXXTG4FBOvSH1YJDTvWnkCRR74CUryuo4RfbKx7YZDII0DhJf6xLwvDdfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flVCSC3XhnE/xZQW47yl0FUFr3syt3vux5Zpr+2qRc8=;
 b=L2ZBKHB5CDgVm5hnXjyZs0AK0eZBCjGKnqrUnznAakdHnyvK3K7lvflyNwJmXJX9RvIqWWL2DHHh9XwOs/uXlXGgBFqe6VTwYigaGGSx4eFy0Jff5AvIJsYvecYdTxZgg3fZEp0UW4ut5HGDzSD2GbGI6QMYJv7nDyhYuq89wuPB3VWup/UuJ8oSE1PK0RsA0g3gmftc/9yVDrjQtzECdFqK72an0vzel2jctmP6Wulk1k3YOuZcvKIASKUxo2fnGwEz3lnM/xZOyhjktAFDsVpgk8wGrC6w0VVaiQZXQEhickTDoalJSS1wCuTiajWVpibocEAxy9lTHy3WYFTQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flVCSC3XhnE/xZQW47yl0FUFr3syt3vux5Zpr+2qRc8=;
 b=wibbTZjh7OmeSFcmPC3H5mOmSh2Qcay6vMOtTM7Go+3bNo3YphzVMsSTwQ8Ho1tV17nF4AZRvPOJIXzdCUHEGzVyyHB8zsN+C9lvN9C/8mUcQZgIdhDpTQbOI752ir+1wse0BJr+a/mZP+tTagBnIBk5J0DkEhJ+yme1b999M/6ezV4mmguG/MoyE2+SqRY9lLaPBTyU9v8HdE1zCqiwGSgdU8lEUCCpK2idVp6nM9a8+e+QgXOeKUFemegmu9SzcZOSCph6z+i6kYWwRWMWXruISI7qbeXt2yGqRG0YtD/kr6mpypQxBfF30qSp3Ve4LBEqO/40+fWw5DBgy9DBqw==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS4PR03MB8472.namprd03.prod.outlook.com (2603:10b6:8:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 09:01:18 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 09:01:18 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] net: stmmac: reset residual action in L3L4 filters on delete
Date: Fri,  5 Jun 2026 02:01:14 -0700
Message-ID: <20260605090114.16028-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605090114.16028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260605090114.16028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DS4PR03MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c5b3c8-c71f-4f98-e01e-08dec2e10184
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|6133799003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	2+0T6rctBPibPJK1p5Yv8+coQaOFVnFmXqEHMCCXE/LQlf5F2UbO0RPwBVSNnzHg1AF9xU9zyGeOs4qms+iQh/AY7A11qMqPU9b1bMbC16T2aA+OTC7N2nsqGizl4/zCadmo3qVDI0ZQBIw2IJR8Ibig/AiQ0jSqyh0EwnNIaeX2XMiOoGs1Gd5AmrO+UVcwHBg6GKGfmby05nT6stMIvnTJiDFVBha9aovP05p5EgZN8UAWrvy81AkVKSNY25kZ8A9sTQmfGe69/4KnOwFuSwuuhk+Nd7U5wU3uGfkCgljOM7XpoK4Trao3RxuVpY3N0np6MLhBhQXgyIHk39eP7OlH0xVLUZYY9NpLMedu0EwHkP/snbWadCy9s8k1Z536ZAaRKCqfyja+yquY0pqEn6NaE0GZzNkBD+XlrpGbgMJejU8xK5FmytgTKJc+2qxd3rVG/C4mdcoKLHSYTtrkawZpXho06loCAoZ05j85DDY5m+ATQjw+os9nTz9tjoLLnJ/rlrZZGAmojrXPltVJIBIc/8CIpnr5893E5QusHHj/FCuMMpR2KcduQoSmslkZerxiuNG9zfdycDmMGXcL5dkm5f9UlIa5wt4Hl30C05Z9XLWks1hoTHjWUYDw9aH3tqRLh2Yg3bRl1zGNtvuaL8fL3ayCUXKUXem4DT33J6QSeRwNcWqw0aXezgUQg+39
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(6133799003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YBH1bw2js+oPKpmKXI3IiU3ld5KpM4Z3wji/ykRqZAX3mHdtD6sL+XW6Owaq?=
 =?us-ascii?Q?9PaLNNgNxpucl4jU4tGwKUCNgSDu3j3zI5YAtzEaNx5TkT62gjMktWHXv9qQ?=
 =?us-ascii?Q?czbKLV2rshYHDX28tZD+4R/igh1+/ZhVnlhA17f3yoOwood5yxg6RsC41tbU?=
 =?us-ascii?Q?v0X2b7isoCg34ehJiBAq9CuMWMNSC6OkKrB9Lrfz2KIR49RKqNQIm2Q03uAV?=
 =?us-ascii?Q?qEBW2y8S9EZP0B8sIaPq7LXAjSpHgCw75XndsTrWFTyAnNpfVCP//14W2IGb?=
 =?us-ascii?Q?pdL2X5D6g/n5aiOyfPL/9+Eqrey8foZrbycnaUCwQ3gd2a+n1pkIC92Mx0o8?=
 =?us-ascii?Q?Lo3ubT1Qe/bdBSaXT7dp2Tpip0UG1v0cTexKKKAQakNER1mQnjfZCdtrtRUG?=
 =?us-ascii?Q?za5SzJ61w6OJ1NMdpLIc0NPUTbso3kR3TZ6m2euy+ef0g1Bd2Zg4w09NYlcg?=
 =?us-ascii?Q?ZjGPWc0ehM+xdn6mHBuW5qy4zTc2Twyzbg0kckwlNzmyn+L/YIK3M3/3Yj6h?=
 =?us-ascii?Q?KunHY/F8uav6oG8hjUYeIOcMFmBpwVzjT6FXzjX8Swl5FwxRX7JX+e3TRbRB?=
 =?us-ascii?Q?P58GGd1HdArpzr7/WE7IBqHB1+tkBf5ZgSmwfKYkT2BxQyp7ifdwkvkuAlYT?=
 =?us-ascii?Q?Y4p/OYKNY475OE5BR1ZS6cHUHlkuukC/XqxIlujN7J4dU59iW/eOvWfD9pCN?=
 =?us-ascii?Q?Lm7U7154m/AWEuAXkY6gX2EHcrM1j+r//KK6EPUFjWeVpycYDsNEyXXDda3C?=
 =?us-ascii?Q?YX9Xt2fyl1G24uWlcWdSt0Z2Ud/bQQY9JI++FEgDq6zWL85I+V9LBE85k7PA?=
 =?us-ascii?Q?KrUkdN495kZ79cMuFNF+FMsxv5IWaVRqccRGV/7NzLlSVyb6l6Rb+lN4+bqL?=
 =?us-ascii?Q?/7qYbMm6FkoPmtl2DE5vnkVaIBtUiFhEsVZdNh+sbIeUlBRG/T2WtKElE5eU?=
 =?us-ascii?Q?QAnwRwkkG7JczxUpKSH08y7RMzdVU9xHjbnawZOd6npIoIF1ZgQPiv4W7rH4?=
 =?us-ascii?Q?YwIoznK2ZNxACsCk3gUeLU8+L6DSzvRiPvg5T/Lvd1LW4+2kP6JiZKnh2UTe?=
 =?us-ascii?Q?vmGq5kNTwxHkNDRRhqGRTmCsEIDRS+261fGyxixGv9nZo2cfBQXvOMLQPVpm?=
 =?us-ascii?Q?m3eA42eGTuZ/54rdIIAOMTnag8JfZ6AZ0Fu3J6Pl4DiB5JMq3HxgyiXognmQ?=
 =?us-ascii?Q?fVvzr1oHXK9aY/vpGIfRk8sWMYlCGDvqZqKSahk80vZMELjbCsI2cx/Nk6Sl?=
 =?us-ascii?Q?Q9ZKyMMC7QZvHHwOKjuHvpmpYQlJ3jRzlS/POgiQWtJ1/1FgC1qc0iGluVLZ?=
 =?us-ascii?Q?l6gv3gmSfPVDoGVapr3MsJ5b7KB4U8O4LvDPbQwcA69DB3WrBlwo11W9aUlh?=
 =?us-ascii?Q?rNBQNMnvK6FOV8xNZDr8j3kH8TuO0lCBLsKha9rGAotje7dKXOq3PPIiWP/K?=
 =?us-ascii?Q?CzgCqLNzpKPBhPpiGWH8envKbD5GL+X1qythxqwpmk/sgcAI6yPJAVfuNbWn?=
 =?us-ascii?Q?odLItNnp8fH11BXTcqsRfPDNuIFCQp2DNgHNRROb/ssYGNZLNDgu58Wc2eSk?=
 =?us-ascii?Q?MgUQxnKNGnAQXj2AnFrXDRisfWzooeUC+mLujqLrJP7xFOPCqHNxxmsJjyF+?=
 =?us-ascii?Q?nH4MEl9q/MDGOV955a/9ngMWOZqOCLnja/5ee1CYx8on124Ms5/vEpmVKWTq?=
 =?us-ascii?Q?3u/PZngrqaR1cgtxQ2allbWI2OyLnU3XJcDYrLpPpf7L1x7sY5v2619iO51B?=
 =?us-ascii?Q?fkXPbJ8gVf4q7hN4ltuabcuxTdqaQVIxRpesg303eaz9mVOaa2a6ikeejs+P?=
X-MS-Exchange-AntiSpam-MessageData-1: 7LzJQoe2I9hPPg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c5b3c8-c71f-4f98-e01e-08dec2e10184
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:01:18.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXelpaCIzAF7SubCjtyqMeS7AMnqo7fOyYiDeCuc5KFUEjLhR6D8Fmpd6OmlLyMa3+2k+bAUdy5Ra5Vx8MOLLDPB6skep+tV3CKTbs/nwwGwVCDIVndAHeHGT2FWITmPaF8cqjLRlF99V7oaHBzVsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8472
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295734-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[altera.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2603:10b6:a03:432::18:received,100.90.174.1:received,40.107.201.2:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D7CF646C45

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

When deleting an L3/L4 flower filter entry, the action field is not
reset. If a filter was previously configured with a drop action, that
action may persist and affect subsequent filter configurations
unintentionally.

Clear the action field when the filter entry is deleted.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 869f84756ca5..4f9758eeb86f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -653,6 +653,7 @@ static int tc_del_flow(struct stmmac_priv *priv,
 	entry->in_use = false;
 	entry->cookie = 0;
 	entry->is_l4 = false;
+	entry->action = 0;
 	return ret;
 }
 
-- 
2.43.7


