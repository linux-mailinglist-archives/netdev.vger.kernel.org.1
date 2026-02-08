Return-Path: <netdev+bounces-257819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LYAyG8B4iGk3pwQAu9opvQ
	(envelope-from <netdev+bounces-257819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 12:51:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0BB108929
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 12:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0DF30086C6
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328A9346AC0;
	Sun,  8 Feb 2026 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pGwK0qtk"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762C1DFFD;
	Sun,  8 Feb 2026 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770550894; cv=fail; b=BcTPQ+76igPyC4Jno33ozHqAsmlpU5aYd6VLk09ZXaT9e9DOU0k+izijeYwE419B1Xwn9+Rr8P/R+yyqOHKG66XL7vSBTaP1UujzQYbK+08KVqRx8cYWAJfyQvi123I6K1FRRslqf2gYaIUQ17nVWWnU3MOVhwLWlLGFaLFbJy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770550894; c=relaxed/simple;
	bh=uayoeRWEUU3sHmEOQP+gI3zXsi9NLnsQCqNRRBoLb8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dJnI4AER82dGPqhq+s7Q6mmz2DCgwvg8Th+FOInE3LWPAF7yYVsv+8P9XkQdZUYfckBvdy7tGQu9nBuXe4nQ+i9GBfs1s8UW/kBOL+rOEYamV1QWEg/7LDgWHfbJDKm754vkt/6hIqkorMwfDslZGLmx0CijElN7LFsA7crzbMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pGwK0qtk reason="signature verification failed"; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6CE7Bi7oQiNTFXS2CyIZhAOkEh7KIcaKPxa1ZYkPOv23Fj/3kNbl08gk0e3K85CxNaHebBjtKYItRu+cGDRqJXnuB6XqLfpRNyd/kJ+Sp6dvcH+VKF1YXCtFik2w/ROPYnAOQm6WUmL38hoghDa7Asd/EIEXGb04ygM3Y+Amqc7S6a7Hkps5M8teqizlX/3QUCaOO2mvcCzE4ql9Hmp6H1MufvG5DfBU8VYSDEFcY1f1G5DA7f/EMa/2iIQfQr9cwBtNZsqBHjAiemaCzlQUVSBNv/U66RX90G1uyvjCfkjDcq5RyyPx5fp+R7ZWHOE7iFJsK3V1nGSCDg6GkizCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wlRd5PlJyt/XD+7X9WWXHP4PgrOkxLL1IZ++pC2S/c=;
 b=psfapc1h0Q2qMfACVXNrc53Xbvm0gGNbJ3hWh6Ti+B931G/riAEXVIfibOBP3otkwxaP0yn8cuouBGJ2ssTECLXbL/oNr7kUPrnrXOdNt0N+Wx6fifD/zas6KPCDIzDOewsKkjeR73o7P5eaWhLIEqR6W/tyno6hDjenGFRlYC6Z8WeEAjcKTuivRK0wKd884ajzmY+gxhwjaJEJcs8H9/nQzMXi7n4SlfZpJNmExUaCxPeiz045BDUHAkI+E0vf/3yEr1d1dyDOF7+5f87x10JZuwGl91uwvWJnSoV0k9WtMMd8nbH3OrdeobcEIqIATKc3NozIoUjkkeC6NUe+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wlRd5PlJyt/XD+7X9WWXHP4PgrOkxLL1IZ++pC2S/c=;
 b=pGwK0qtkpkr3J/L96V1wrSSQhBS2Hfj0LvGkxtn+cPdQU6kWy9AEZx4whd8xtFiGpHwijYY29oClHBRcypqEqKXgnO0KbYomNXLW2QXlIIAdIwaFUIHMi4BH7uw7ngeFMzkEF35OEofO/XXZGY2tCPAQaYZORhClqOj1e1P89hRt9ManBDr1L3yVJEbm6E1gc6+p8eAxZVvYUhJr5iPsnwhkSe7a4o2/FOZS02xRg0jBVoo4lx1bRu77JdeAqbh54WT1KpwvqGF3Bfec1deqyQqM/Z48A8P6mR2i6CMmZAiTgwazGLJtg5FqydXdI4ecAQ7CEDSk35Y3WftziBd35g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ5PPF0529573EF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::987) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sun, 8 Feb
 2026 11:41:30 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 11:41:29 +0000
Date: Sun, 8 Feb 2026 13:41:05 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] net: bridge: mcast: avoid sleeping on
 bridge-down
Message-ID: <20260208114105.GA134356@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-4-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-4-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR4P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ5PPF0529573EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 417919c3-ad67-4a06-e4d4-08de67070004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?fEmi5OBBmh9YN4izHlyRYfRT9RsbbO/Ffo4dqgq/cVMPnOObl48UXSQLtH?=
 =?iso-8859-1?Q?b+cZbfCmPRV6MT+fGKAWx/A2DI68d9lqSQZjrZqp9AOEDKLNLrWHdwrpB0?=
 =?iso-8859-1?Q?YYJouoQs016NJatEykcVWO5lJWex0HK6sG4/isUV+DnBIK/JR5A6EHjm1P?=
 =?iso-8859-1?Q?1wXwfQMo1UX58YH9iLXRJZyUDuJ9FTIdbDRcFPUr735c3K60c2qVKCpvjm?=
 =?iso-8859-1?Q?Wx/HXek7hbVFahY8XwotmmWmH1K0dsqzSYW6kod+coj91AR8clN4kmUVYX?=
 =?iso-8859-1?Q?e2twUhI73A0p43esD8e9klh8Em2oFoz2mM+2UfTRdnq9jW1RGINQydt/ym?=
 =?iso-8859-1?Q?8zi5mJmi0hsE5DsRdap/U+SBex3LE1rGzacg6QPGBsyLe6Hb04ymF2n6vr?=
 =?iso-8859-1?Q?CNSMja+iDa149ZbJHUGrrhKfiY8LMs910EB2Dq/RV1g6WeL/zkD5XEZKR2?=
 =?iso-8859-1?Q?QfZdEJ9bR7tVkjhFZcV+YHdbuQWs2r3drojj6o6KdEtGdPPXgA/VLdsxgP?=
 =?iso-8859-1?Q?rhnezdSaNxGUlN7jKc/gVcpZrv+ex8QIEJRh6jyyOaphvk+SfinITzEjHO?=
 =?iso-8859-1?Q?wjUNX76W/yVyJeD8m+/IMCuP8L9iHbG7xAyFO7z5J5fPmVLQlRPQT6kfhF?=
 =?iso-8859-1?Q?LsPOvwdARrGx2jNVjLIkzog3Ta+6g/Zu/s0vsujl1I/lnt8syxB62aYpIE?=
 =?iso-8859-1?Q?IQPCeX4LRv+hHP96CjzrfSJ3qqs/rim+aNJkpfYyh9rNo3qAX+bckk345v?=
 =?iso-8859-1?Q?4J3fwuOFlY1MXrnncMvI0H8O1lkLSdHf1ycZWXv2KrX/8M9hRF78F1AaV5?=
 =?iso-8859-1?Q?UVrbWF4g0M5NCHE3oMJtyHQogy7NHvkANEzTB34mLBVWjJZM/SdXNWfnDq?=
 =?iso-8859-1?Q?n0mGSnwbQYzvwcEdNCBI4sVVEuaHcPZgff5B8lHa7LkSpFa3VkP9Bzf0vc?=
 =?iso-8859-1?Q?STpZnlSOhBQKBaqIWXhTD8VXLOnwCBoIlwS9qP7+jKuT26pLCvVcdcVvQw?=
 =?iso-8859-1?Q?7c0Wk2bTCDdXJZLPSBoMFRIYIz+O0jAyAlep/XEh+i4QLXZZ8OuKT144n6?=
 =?iso-8859-1?Q?OwpZ9npXXKaa73y8qf/gIt4pGG5bdqt31gjlft8fUQzEv7+eT31G8XZ5BT?=
 =?iso-8859-1?Q?Gkp70H7O79G5BrZwPm8s3d5+Krih0Sp9DzDMiqSCCwgvZMa5S2GKxVze1h?=
 =?iso-8859-1?Q?ROPAiIWvMfIlnIbgAnq6NtQpmAuIeshGxKIxibE0T+4KPOX64mj2sgxe8h?=
 =?iso-8859-1?Q?U8EFA2jbCvzIC0/xwGtjaRARbVxOagAfHlR8IJAbB+EldHCAErRUqncHEV?=
 =?iso-8859-1?Q?MKuTWbpDncmYvPbWbrtdGBW6G9qYWUZWx5+Xh0A0FwPUgpT7IniABvENsy?=
 =?iso-8859-1?Q?yIU7cLaR2y/nRRbtvh48FN3oyb9+74fZQUBqMo5xuv4vQbcvsICP4Ck55l?=
 =?iso-8859-1?Q?2X44F3RX0QAcwmOP4+zGlEPceXlZ23RAPHUjwZLdIJ+xlDWLVEtqDdu100?=
 =?iso-8859-1?Q?gxDzzu2+ZUH2d8BykvwFFy53hi5fBN6cA6zh0bCrXVk1+kQRNCkiObQWbA?=
 =?iso-8859-1?Q?oW0O+5v6r7MC9UD7bm8pB9oOFJ7PBgkH+nsg9tmyTZ/2I8aAz0ZLRTwvY8?=
 =?iso-8859-1?Q?Y0VieyhQ13/Ag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?hIsYjQD6b/k12XjCFC5QnfsQDo0VRU2BhaDPFZxCsrzbfDgX5ogQ56Z0QP?=
 =?iso-8859-1?Q?RJpuAfOt2UspPxtpZ6dpwBbGd+3okhRUNzs+NG6zpkjV4GQmvbMvdt/lEp?=
 =?iso-8859-1?Q?9T07WOePZ22JV+3CBLAlMqTPuvnGAFO/wwxQQ+nFDVAQ1FkkBFn82/XRP+?=
 =?iso-8859-1?Q?yeJiK4g64MxBqSV1oYyHvzBvCgDiv9icxO1S6qTl1n4SWUQStIOP1XrD0Z?=
 =?iso-8859-1?Q?UNq6Q2WCnzajipPrLXoJGg2/LyeucfcnW82dNjyFlCuP77RGUSji8FMefr?=
 =?iso-8859-1?Q?rXgAK8oog/qP0/G7brlKjEOvbe7tJjQdW7p6XEK6mW0bIxcnOC22AgqFd9?=
 =?iso-8859-1?Q?guvwj7w3S7aT/IH3sOAPe9XMythwaBp2fXLJfOa6HriEku8i0pMufhDMwE?=
 =?iso-8859-1?Q?hro2N5zodL52LopJLEEN2hZtGP/meOI3jSlAKgtAuHWJfhOTEOKoV8xkRI?=
 =?iso-8859-1?Q?AmJXJ6N2+9fbk1YCQbHbIvN2WQnWgEVbDYx/TN6a7AasjFebhhQLbgxGnG?=
 =?iso-8859-1?Q?2wq49sUxjNAZvL7m2NJUq+6Ri8EpwFvYLmaAm2u8TQw7/C8Uj5vAacawNu?=
 =?iso-8859-1?Q?0dRRZN47/q6H2btG5WPTbuaW1WBSdm9GMDQpPxjHt/+PNir9n2VZwJPnct?=
 =?iso-8859-1?Q?gBiA/AzcLN6bP7zWiRzm2x2S+dIIpfM/ZzmLXmuq+0mOZwthSYn/1XylKP?=
 =?iso-8859-1?Q?eK+IrUgBObbsgk/X7fgSXnpDm6GRl6SpqmbE0DOh79BEQc651FeqQyof9B?=
 =?iso-8859-1?Q?fIwxd/tON4A5PtF5fqOsBmbBIBdFcbY5KYQqKPFVituBPgUmO5FMYfit1u?=
 =?iso-8859-1?Q?zgjlm4+4LjXkuF4Q5GFeWvUlrqYGh+aiSaa//L+kFEhphUP7XUVI7zpjSN?=
 =?iso-8859-1?Q?kXZH+HejSrROCGZ/YaJpw/JKezQKfTWcHzFbIhNWGYt+gK+ditWvBvrv7c?=
 =?iso-8859-1?Q?8Zk0XcDdSyeXevcqO/H0B5KmtGHhnAalWVFBeo8aChek2T7HMJArC3qvJ3?=
 =?iso-8859-1?Q?MPjw66ovwgkHFYj+pJwlGnH/Hg2LSKpwVZU7EPqCNfzW4VHmISxttALMKi?=
 =?iso-8859-1?Q?QDOADT+ct/wX/AMy2vhr8zXe30FlSQjmmuu2k5nFRdKx0jiGJW1WJr4tyl?=
 =?iso-8859-1?Q?05xVZMGYeHwm/ivBVyHEO6WHW7CMoles8/+xJ3y4iQ/7pSJ1ShX+9TCILa?=
 =?iso-8859-1?Q?6yjZ9ibs1M3sVCOmpevSpzzyLdVCTG1NifM+itaWi25HyEF3WUVo3NtNe4?=
 =?iso-8859-1?Q?YuAFgS6es1fVxrqFoWrZx0XlyF/mcJ0srnGk2fJ4FDjK4/LHjsQSsNQebY?=
 =?iso-8859-1?Q?tCEbIhiUDrpPW25sBFhP1K95tCNAFLXZgMJ2t6ze3O+rHAO65BY4gnFutN?=
 =?iso-8859-1?Q?cGnEAA5qtdxijmBniMcXLQEOpZLqxkKP8p7XrV7wAEk8eAI9BDwKUp+0p5?=
 =?iso-8859-1?Q?5mq53WeYPbCRYF5MYCc2iz608mw8dXBzNeQcuU/1QgfFXF3fLyIwwAmqM4?=
 =?iso-8859-1?Q?iL48JxLhmcbAi4dCTp7hIb7fsKn8EzCyvtt/6FDwzWiYnJd0cA7jLTgcrs?=
 =?iso-8859-1?Q?7ORp93ihB8vKesRu+pY7dusu9i0+fUNloomXfhEiKr5uhdm9chSsxK/qrQ?=
 =?iso-8859-1?Q?9QD2K/UUzKuBkTlYVJygN2R9kB771OYyVw14IJ62ctb6beMLWH9PBbIsMy?=
 =?iso-8859-1?Q?zUs4mlCOK1yJTMQ9ZIVbZ8qFeOWU/VKo1fInuUdcDDASPVZgvKC3TfWXBi?=
 =?iso-8859-1?Q?4DSs99Ov1dfE0sBt1QdZsxtcjPi5mVTL4dYXuQHMoR+B1/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417919c3-ad67-4a06-e4d4-08de67070004
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 11:41:29.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2NbJL3QWK7HWmRy4PFMzOpnsf/W29EF8DcBhzqXVW/rW0VvVZQSCz2105Z3aZhquL4jkColXWrEFJaHPPhe1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257819-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.973];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA0BB108929
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:09AM +0100, Linus Lüssing wrote:
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index a818fdc22da9..d9d1227d5708 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -168,7 +168,9 @@ static int br_dev_open(struct net_device *dev)
>  	netdev_update_features(dev);
>  	netif_start_queue(dev);
>  	br_stp_enable_bridge(br);
> +	spin_lock_bh(&br->multicast_lock);

This wouldn't work when CONFIG_BRIDGE_IGMP_SNOOPING is not set

>  	br_multicast_open(br);
> +	spin_unlock_bh(&br->multicast_lock);
>  
>  	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
>  		br_multicast_join_snoopers(br);

