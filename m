Return-Path: <netdev+bounces-257845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOdsMg24iGkrvAQAu9opvQ
	(envelope-from <netdev+bounces-257845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:21:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1F10969E
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99E583003356
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70B834DCC4;
	Sun,  8 Feb 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NtIiX9af"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9634B669;
	Sun,  8 Feb 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567097; cv=fail; b=T9ilpJ81SQszYgiK8H244HCTjJDKZ5Iac6WzpcNhw2uRhwMrJPSob3YKyxnhxV7ilXZXPJ+ekW3gM5nOwKvSMWQwYQQZoeeC0y29ofsU9cMB5m0fXteMbIwgQ15jmaFIBpzxKMI/epJ2/VIdkHRMYV6EVwiR9eCbQ70dAfFjyU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567097; c=relaxed/simple;
	bh=1h5Ud3nT47SurfX7CT4xXkUYwH364tER1h+fl/Ry3jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KwC8HWf7lN8dq1uiJ39jt89RDfAp1dujS4rFKSY4BhOAI97YlhGAMg+gg7Nk5lcAhGE7Db5JwyrUTV4c9ycHF0322yyRXWwRWg7DcgSLNnbI6w0IWqCX7ijAFbdIelD+2ipiMQP7P0qRkduMpxysvTZLF8JGYdoXLRY1DdJiIHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NtIiX9af reason="signature verification failed"; arc=fail smtp.client-ip=52.101.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kov02B7v3CnPKIx7gVZKvkiNJmRc9LbdO3SxWnD9JaYeCjOCUlwVxvSP12xrOfwB5JI1V63Tt3LpRNQ9bs3Vj7dKMu5u4XA0BWp03bgyYDy+957Km43HOxMaGOZBQB0LaLey+0ExC4/dc057T48bgcKUGPHXmyqvBBdRsi6Pp/Czg3hVCSKbpixn2pjPXQR1Tj8wuGskazb+85X8WW+VurMjg63coLz3I7vKrULePafbHIQdNTDMCL42n1tKC2mXumNJiouo1d3K4OF3Vdu1XXgTIv0s8/ipgOmUF3QmCNrn0Cw3JmjRZD7CnfUqGY5jfkUsCcTCWcoHdiZr3M9Yeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J/lfvsdDpjD7+6IKyKkM7J2TKxJe/VHQO9A9Mc63j8=;
 b=G08sygbU8zCLDaVT9taGsW7hIy2o7SdFoufLNBfa4b8vHR6tA6sKVpOlV3mv7ct+WosehxoV2WsbjFwT/TArLAsEQMMU4JdYcOVQz5B43bsNqX1ehywZ5ChkvcgXj7A4ee9VoVwhHtZPWVAS5oNQuor924mOIe7D+ydUWRa4SLWKep/vRubM6cBra8rHqwVg1IiYCdx6k6ngnbbBImgVHumiUNQvCwpFFcPyUsBdP2bxtD4lFMsMnGJ8jh2kGdAkjO2qdVgW8GUZ4IPIbL2vuNQk2ZDzNBCtUUinKyoFzJpNX7A3oIKmxTywQvh2fgjZf/C2OJWD1rfM/x4pZbX2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J/lfvsdDpjD7+6IKyKkM7J2TKxJe/VHQO9A9Mc63j8=;
 b=NtIiX9af0hsImOLo6J95kk6LKRtRi2sKX2AiDgFBbBgkC+FGMfNdXdb4yqcLDLRwF+qucF8RS+y1crAEnw2JUZvomTwfBmK6BAOIHXzWNW5dsp151OJLhhnGceurSVYScsOMr378mVF+19pZctTBklcvkMSJ4o79yjjBIf0UdF7RvVhpvNrMl5GXhkNSpeeru628Ok7UmDNWhB5V0miC87gEUZT9SN/I+sRadTxwgANuQxiTGnLwKeDwrqnrYR7Nhrh8iZgFLAxjHQO9XRXt7/yecYah9vqjrDomkf1GG5BNo1SoxIw31HFGBK246Nvw1q2nYvXcZ5hDzmu9p/2+jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:11:35 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:11:35 +0000
Date: Sun, 8 Feb 2026 18:11:26 +0200
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
Subject: Re: [PATCH net-next v2 11/14] net: bridge: mcast: track active
 state, prepare for outside lock reads
Message-ID: <20260208161126.GK154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-12-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-12-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 6299221c-8136-40a3-e9c3-08de672cbb42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?naltr+sA8z/U0RLKXX+99fj0PG+GK7Mj3xAV6XTk0URFWk9ckwKaG4Jc/b?=
 =?iso-8859-1?Q?ek//a6fCa9KS5V/i7nnwMNNhP63Ffcgl9eQN5fpne7EWvzxRLO5dLiXx1Z?=
 =?iso-8859-1?Q?PjtU0TjuHO/oYNV7Anb8wEZvHF0Yo5ZnB7Vi9vLxcajRY/lDZckOApiO7B?=
 =?iso-8859-1?Q?/alg4k0pZLl1dPPqfPEdkgiHtVT/DD4Oit1RThS+ci4WqNiltssnvXpNah?=
 =?iso-8859-1?Q?2bspAvI8Ap6hBDZs7wcZV1kNwXp4Ilp4DryPW6jP5RfLn+05IoJt5bN5Dz?=
 =?iso-8859-1?Q?wh1BXtyORU/x6pPBeLE9N3xsoIurSCvZ6SjJDzg8KP2+KqeWJk8rTX/L0t?=
 =?iso-8859-1?Q?IC1Pl6pGOynRwWjFGcGhEwPG+3a1QFSmQFwlx+CYLaPBWVwfJydc04oSfA?=
 =?iso-8859-1?Q?oW5cWonvnWFF4gadcZcYlEHbdDw/eQ42F3al36K5QLQsPpzy1lGcz2jgY4?=
 =?iso-8859-1?Q?7cN0fLvc6Qns6QZff8en3SMaj5zmyVn6eoSEgDuF6GLZ4V7PC0dsK4/RPn?=
 =?iso-8859-1?Q?m7/l7BfV887FL5e91vEHmn+hH2UwYLIKEzlMguvk4B1YRwaV9wg6MvxASm?=
 =?iso-8859-1?Q?X39HZhuZ0MXvGMaHQzsoOj97pSJYTEJA6rlmEjsT6srr0bnRBVWK56FWub?=
 =?iso-8859-1?Q?iHI/em1/auqjs1Y7WZ0lkNuNXwSAjTJYLWSMMsxZHdi3+mtj/dPLsRaRm7?=
 =?iso-8859-1?Q?mM3TKCepky8VsGxJeCE+VkNOM62dhC61ygn37If36FOELWZZvgy2X43KnW?=
 =?iso-8859-1?Q?WWC8FIGsGs0JL1x8VgdTiaZWjQ7kmkztrT4YHQcs1wCggz2k7i25PM/y7n?=
 =?iso-8859-1?Q?AzfxQkKKVlgPVDVnv05HBCRj6wHmlXT8SHRCMkMuzPRoOnf2pyi/Z0K8jE?=
 =?iso-8859-1?Q?CQ45FrAoRSaTOWj+K4q+i70JD0y2G1TZmoac/ePP5MtjM1q8yHF2OVYHGG?=
 =?iso-8859-1?Q?nYgd4Ty1JO6TCm4cFafbZdnqv2QNWQTG/diNzJ+4scfz5j3eE5RkE+Dy1e?=
 =?iso-8859-1?Q?v9gKJ8+EH7zyFdUmSOO9tpHkE/3wCFsCFKUyJAleV83Q9pUbS8asWkJ8f3?=
 =?iso-8859-1?Q?S+Z/t2vWR0Kgnxa5ETlw9P5B2QrL4bVWhu86mGTZ/a8bRg4V1l5rwdR85u?=
 =?iso-8859-1?Q?PmQTmO8G+0hErNBjj+SNXnAwAjI4gKNsQEwyseB0q3WPPROV/RPXRV4CTi?=
 =?iso-8859-1?Q?wMR+fvtvdhTdcyl15J5LHoT2a7EH0C60jI96s+auBMnnDSMuqZqZbIeoOU?=
 =?iso-8859-1?Q?SyM6U+GnwBSk6MSz25Grv4oU9hTZnlrjiN6Vpmm1U9zt39R6dopp8GVgAS?=
 =?iso-8859-1?Q?j1hURn9IswiMlXezz+nRLuicn9ligBkQynZmfNuxY9ZfOgSUbafs3Dwarp?=
 =?iso-8859-1?Q?k52knkro8NOiu7izPHYc4ozsdqD38XuT001ROElU127mjQgSM9TkGBHmVR?=
 =?iso-8859-1?Q?MQ0vaA0Cq/VFXIbcnKzkxWkx/oeMU+6VqyfTCBiuXU6lD1rtNvw+dNT3CT?=
 =?iso-8859-1?Q?p9gKnt9980EpVb+CuVqSR5t4+pNFpiSWP4ykFWqWrUvyLoLm+J/8aX99Sf?=
 =?iso-8859-1?Q?NMgkznEjPZJ1Q+Z7YAh2R33USy0lJiGmCGuj1GYNhtLmwPxsNB0kpaSE8J?=
 =?iso-8859-1?Q?YRhLJSH1aYr84=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?3oRB311ZNUO+xvRA7RLS/PIFG3jO8wasRxkKwdp2xTPYQzJU+ZkqYzVaRz?=
 =?iso-8859-1?Q?Z4KzKwcf3IknNAM7UFOEko6fIfsmcWSM/LFEys28i52I8fB9QIbm9UkHT3?=
 =?iso-8859-1?Q?vgsE4e6mPEder1jvdOKhYx3Q/IOtLIJIvSHsj1lirW0O0+xjSLvAnwduUW?=
 =?iso-8859-1?Q?hbzCjfd5yJPS+Ou1mnRAUED5WAbeVfcMHNx8QVNd3uY2o3f+fqcM5ODEgn?=
 =?iso-8859-1?Q?azDB4g9UexT4S6ptenA286lqbln4TIed2dhn/+aOqBElrbR+XrKrVz2WZ4?=
 =?iso-8859-1?Q?x1P12dpKSztJA6YSsM7V7bo/Q8xopWmShKz+6GVqXNaknX4cWos21rqUfa?=
 =?iso-8859-1?Q?8wtPM/KhAeI8BGdBAHrLj6utbQLB/nZvxS32VzshYxB20S1QTNxK8tLxKl?=
 =?iso-8859-1?Q?GC3j56hTYW6L/RE3Xzit2orLCjiwUE27IF7vVovHllIGOlgC9wRJMjenI7?=
 =?iso-8859-1?Q?G53LYjmnmvW0bm3dijvt1SQL0y/xwrCRH2dTPhrUdYcToyyV8u16l6pSwd?=
 =?iso-8859-1?Q?jKg1zXckpIxz7kMSwy5gMIHlRbVNx0MHW6gGXaaZQ+2mOUGH0D44SB80sA?=
 =?iso-8859-1?Q?Ajc8SnEmWgtY4VVVavmO1CQ+ad+TqzB3HXlqQDvMT9r2zPhZDJi5YA0vcH?=
 =?iso-8859-1?Q?7Ruiblxj6wJq8mEwSupeh48rWD4vG9YGazybPiAUBQwpZMPdJ0oWoT5bD4?=
 =?iso-8859-1?Q?XfMUy9TBE8r/G0JtyaIn614atMuGzRfijINKXmep1fGDyaUtYkfo4GLDtm?=
 =?iso-8859-1?Q?4j4krU589NfLZmxSgjnBNqYPJZmyhEPwZYJUs77FcUSOppYtDH3NcaXyrZ?=
 =?iso-8859-1?Q?mZOGId8pzbpxEFt4BAF+rLWP620+SshtJjvqYXE4apFRlY9wBHiE6PSEfz?=
 =?iso-8859-1?Q?glmVVRma/r5pS+jeAcNRbN9usGFus3BsIgdzKWRkk8Aka897jgmscdljLH?=
 =?iso-8859-1?Q?m5bQLcymb1ivaIpbFXkNFg8AZBEhozfnwJz9mJdzShatUzVwHVURlENl1x?=
 =?iso-8859-1?Q?A8Hk5IBjW7uIqNk3UyhFEaMiy7aIARhsjQ8KV6dzqAL+rj+f4Swe8qQpEl?=
 =?iso-8859-1?Q?aR17th4tmD5fIoYi4pYHnEFte8ZM2dTBKEa0eUsd+CP8zgQJ7UBla4I5Bc?=
 =?iso-8859-1?Q?tnfSfpxWPQ6BBpUEwOX0JrNA3Q3cdjXArvrmRhQLpCvGa/gGzKXXprJgC4?=
 =?iso-8859-1?Q?mNMeN4oX9jVf8WTt7XITNF4B4AY+QyaT/Wpx5QXsFz0J6ellPcgzFKKJWJ?=
 =?iso-8859-1?Q?t6/TzMd+Et/gMgaU7OSKhbG2Bg2XGt4Txoo8EA/AtTwlTkOzSNyFwH7mYF?=
 =?iso-8859-1?Q?4U9JbEn2c/xKgSMMZwrnJZO/qz8l1tPMI887xJVnWfq0Uxl5sCmt3VrmEc?=
 =?iso-8859-1?Q?zSk7rtJc7u02AISORhrQO35S/jMAyJUyBgQNWZS2MIO5fIQcfV0+J+o3PG?=
 =?iso-8859-1?Q?zVt9JnmR9On1rdAOR7S9VxY9sgX3lMcdB9qUZ+2+aZvn55s7veYPb7uBMv?=
 =?iso-8859-1?Q?1ElVV4xOOrPesqwpVNBkm/SUhNuCB+pqRXZgZXg2w8xMW00elV78NS+jkS?=
 =?iso-8859-1?Q?XduuHhc18ubH7NEdeDEL7OyjxvTLkJjvL7mLZOtIpCJHrTI2x6wecwwO9X?=
 =?iso-8859-1?Q?Xm7d1UNgzTa9rm4TrVBC4eBrErLCcnqUqsQw/kIRWsGLaWNq10vFseH2BG?=
 =?iso-8859-1?Q?eq42SA37h8c54llbMv1mbMdMlRdVhpvZBWBs30cUTyBt2KBHNsedPXH7eO?=
 =?iso-8859-1?Q?PjFd42brYliD7CailJ000BEWVk4qjpw6ZnxHr9u3oFnW8D+sqF/no8Z2vL?=
 =?iso-8859-1?Q?PiMSNe8oYw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6299221c-8136-40a3-e9c3-08de672cbb42
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:11:35.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llVHTECYj7bYgkTP7jb74dJYgAgYL3fAk3sPV2g0w1h0g98dJzBuF/FeLdE1o4zzlAy/KS3yJypW3atREmjfIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257845-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 70B1F10969E
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:17AM +0100, Linus Lüssing wrote:
> @@ -1095,23 +1095,25 @@ static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
>  	if (force_inactive)
> -		brmctx->ip6_active = false;
> +		WRITE_ONCE(brmctx->ip6_active, false);
>  	else
> -		brmctx->ip6_active = br_ip6_multicast_querier_exists(brmctx);
> +		WRITE_ONCE(brmctx->ip6_active, br_ip6_multicast_querier_exists(brmctx));
>  #endif
>  }
>  
>  static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
>  				       bool ip4_active_old, bool ip6_active_old)
>  {
> -	if (brmctx->ip4_active == ip4_active_old &&
> -	    brmctx->ip6_active == ip6_active_old)
> +	int ip4_active = READ_ONCE(brmctx->ip4_active);
> +	int ip6_active = READ_ONCE(brmctx->ip6_active);

I believe that this is unnecessary since we are holding the lock and it
will confuse people reading the code. We only need the READ_ONCE() later
on in the data path

> +
> +	if (ip4_active == ip4_active_old &&
> +	    ip6_active == ip6_active_old)
>  		return;
>  
>  	br_info(brmctx->br, "mc_active changed, vid: %i: v4: %i->%i, v6: %i->%i\n",
>  		brmctx->vlan ? brmctx->vlan->vid : -1,
> -		ip4_active_old, brmctx->ip4_active,
> -		ip6_active_old, brmctx->ip6_active);
> +		ip4_active_old, ip4_active, ip6_active_old, ip6_active);
>  }
>  
>  /**
> @@ -1136,7 +1138,8 @@ static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
>   */
>  static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
>  {
> -	bool ip4_active_old = brmctx->ip4_active, ip6_active_old = brmctx->ip6_active;
> +	bool ip4_active_old = READ_ONCE(brmctx->ip4_active);
> +	bool ip6_active_old = READ_ONCE(brmctx->ip6_active);

Same

>  	bool force_inactive = false;
>  
>  	lockdep_assert_held_once(&brmctx->br->multicast_lock);
> @@ -4266,13 +4269,13 @@ void br_multicast_ctx_init(struct net_bridge *br,
>  	brmctx->multicast_membership_interval = 260 * HZ;
>  
>  	brmctx->ip4_querier.port_ifidx = 0;
> -	brmctx->ip4_active = 0;
> +	WRITE_ONCE(brmctx->ip4_active, 0);
>  	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
>  	brmctx->multicast_igmp_version = 2;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	brmctx->multicast_mld_version = 1;
>  	brmctx->ip6_querier.port_ifidx = 0;
> -	brmctx->ip6_active = 0;
> +	WRITE_ONCE(brmctx->ip6_active, 0);
>  	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
>  #endif
>  
> -- 
> 2.51.0
> 

