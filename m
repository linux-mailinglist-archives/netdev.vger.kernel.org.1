Return-Path: <netdev+bounces-257847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCWdGBy4iGkrvAQAu9opvQ
	(envelope-from <netdev+bounces-257847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:21:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 762341096AC
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57B8E3002D30
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F1A36D51F;
	Sun,  8 Feb 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rLBImkuk"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF03491C8;
	Sun,  8 Feb 2026 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567160; cv=fail; b=EasKseCOX/2qsTY2F56ArkmMqyGbWjSpyMIghL8vX3k6Rrb5CK4PtTROyn3ZXyfU+cxt/yIQtTqthfUkYiseD8VRHkshc0G4xDb9Er6DEOPgJOuAHEni2ITfTnMBF5dO2xkzdriAVCL8XKM9g11fjVn9woZN/tfiHGjvfuoqbXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567160; c=relaxed/simple;
	bh=ZkfadyVv43pWyrU1vD68unUdytTRhx+Js2W4kUjOxrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ev8PtG9Vfp2mcKMqiZw8FzuatWnDKTaf231Q+GAL3BOmtPXHdl0MCX7kPOUChM8UOb+ZAtWMyQ7A0DtrNxjsEHqRYUU9byqt8mEMyivSriQRJD2jLpFvEgC3w+PnpuZW5wyjge5toLyAm6yUPNhDqaJtnHIMwgcpb3MPcZXvJVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rLBImkuk reason="signature verification failed"; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyVZhcvxTj/CU+YwPiP/4VT0apnMHEPTcQFjALwJRBKtrGx0Uu4Vr2gVh5s1rsEpdfVVuW6KpKPMxVb8ia4moHnPtUzGhp01Pg9d4x6kCYQvnBR4GHml84PNNjaLPbBxdAVgSjNC4bIXqCaVqDmw/Gn5XOl5TpGt1MsVwT0cHo7Aj6Ih+nvqts1iEuv+HMFX+3cOoP+CcLF+qPayXJHpPsU+NyfyOdZ7GYJ90xxGQ9lghe+L7SIIny59V/hS+3c8r7VqHBk8lK1hsqSTPwezdmwVKowyN/Xtyx1WGKMJGrECPgT1hEINcurhGSToxVZocCVoCnkMIsCnpEueF/uR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3wQ4BiFeRYaoDcg5241T2ubDJjc8+q2WzRXcibq1yc=;
 b=OSxB7FZBy129nnxOW3f8hSGZZZ7O/KQPBYQLragDQ17Mf3RFKn44ghMJIQF++D33L3JZKd80NYsxjWXzvsQnEaboaRz2Rfs1nR9EOG8DBp/AZhkT71+x9pUHnaLDRkIegibI0UREas/RzhTvGCyDkJEzyicAp7d23Rkg1WR5xZVm/2Nyxahj4YNXXuqaECBc7XCqDhUj2DkHEIb3ULBJpajStJJ+KC7a48DTrWWbtVOv/zDEkx79XGwCnKFwSmq3pQbFsii5bcBBDunLfFDPJz84/dU4BvB03QIJm79E+IJJww5jF7ZgKluopv0tan9i9Hmur5X1A6U7SyP3zGbx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3wQ4BiFeRYaoDcg5241T2ubDJjc8+q2WzRXcibq1yc=;
 b=rLBImkukdulP2KsvDj49ptf0xIVHOo+Oy1xhA1Xj4PJXLRohzDwTrFVhZ4StSw2kalDSrTrj83d3nqIVakbJCqbqBBs46mgyo4kRSBwofylxMojnObZe1z07EvIYzLR06WJnreBdzJt3pWPaH5NwG/Jk7DWyfItkLL6yNnzSHysC8Pj0iB0nSvlM+C9qnhVhsqqFrFyYXeyhOGgPxEAnCL1IifLP59F32glnfngIHeV3jmkhBi7zeOwRYWeOCtX/ZtNGLyzgMxcyH/CZcrSIisgC3yT2v+6aOpEDQ3bWWH0ujKPxlYMjkApRr7pdSGzP7S9/w7BgruxkqMh+M6BpQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:12:37 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:12:37 +0000
Date: Sun, 8 Feb 2026 18:12:28 +0200
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
Subject: Re: [PATCH net-next v2 13/14] net: bridge: mcast: use combined
 active state in fast/data path
Message-ID: <20260208161228.GM154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-14-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-14-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR4P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f407f3-8735-4b42-fcee-08de672ce08b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?cmt743trdsA4SWGPovFLojEX7Ft2O+IHK1I96kV5ZRBAwekYIHyDX76JN5?=
 =?iso-8859-1?Q?gCBXjZ8dnOXlTEwNVwueaDTaquETqGIj0iTFLTL6ZNAu/Fp39tkCFbgfQH?=
 =?iso-8859-1?Q?6w6Knz2Eue1USrI5ONd9y7/5rKQmFDd2+R14NcecU6JsKYM1OhFKpA2fAW?=
 =?iso-8859-1?Q?45fKNR2HbjAPAZMXuPzL/UB05xd6t8zsbtohq0aqSRjUXQ4IQwaDdM5ftQ?=
 =?iso-8859-1?Q?BNeG1Ftb8T9W7CdY9trM9dof29BEP0wimhqkxVnDDgL/7Sxmwh8hyI0qDZ?=
 =?iso-8859-1?Q?HT2zvSoCebl79F8baZjLylxvqaAkdiPj43L6Ul4ZSVFEzI67/MIYN0Ibca?=
 =?iso-8859-1?Q?X5OMGZvVp5cSrz7T8LcT9xFtPWI038erZluiCUjW6CxmHQ2IyxAQR3sM/v?=
 =?iso-8859-1?Q?EBsRbvp9vNG5Z7mGAQ8CLuyelt90dcwt1N4TZQ/IGKhxHSvAG7ZlRECCJZ?=
 =?iso-8859-1?Q?28+CzCyS2wblFBFQ9syXudkw7FqgB5qLtjZhfl+dIPNhTZN1Z3PtLq1Lx8?=
 =?iso-8859-1?Q?ww/YRH2ac+1XQPzEvCk6Ml640Yii95WS9Jwg/T3vi2hNlToAD2pjra0498?=
 =?iso-8859-1?Q?J47vzmuzDeMop71y4cK3DSB9clPppBd6Q9HRHc1Z0a5PhbV+hQftuUKYTR?=
 =?iso-8859-1?Q?sQXS92ux6KOJZYrBlzPYuSD2ZLt6jBkABLTA/qXPBPF22uOsPFWsBYcnSL?=
 =?iso-8859-1?Q?wbjq39Uc3d0ONQhXUV3CM+MLajt8fnyr/cYT6EFovGj1cuiPlTqU8rP8IS?=
 =?iso-8859-1?Q?NNVnl05XdQbRaNZNhWT0X7bsIf7LqSAfShInyY1I8LB2NjvohDj/3VP8WA?=
 =?iso-8859-1?Q?43StRxheYDgH2T48XLQo0kluWKEMIZeE98cSAXzSX1lx8Nxn9G+ZN3DL9W?=
 =?iso-8859-1?Q?qGEU1k4vuBaHYXbBR8SiWqZ0NwTC9nIFxz6Sv/T00tdGl5DLomklWDqyST?=
 =?iso-8859-1?Q?+E1n8SItaffemVvQPzrA7sbmkevWQ44Jr6YfRvrBVx9W3nd4bAlAyAqX87?=
 =?iso-8859-1?Q?l6tWV6CCRZkZ7MZ2K/iYR4qFjndjGnGXw3q1kvCDUDZ7lH+dN9UfOm1i3k?=
 =?iso-8859-1?Q?2Qs9ZBibbJPrn+8XwOPjb8tyyzRZ0BApjbROfLxmAMTVd9foNq2Th7gM4H?=
 =?iso-8859-1?Q?bxuetsIZ4fqrpiAzEjnLYxiviFF3DJZF8zVMnuZxscL1dOuWvaiPZeMeDg?=
 =?iso-8859-1?Q?czN5KCqbDWH2KTBgCbgsNg5d617cTp85WHIz59JhTHH6q2YDH0Nh/DPIqd?=
 =?iso-8859-1?Q?tEReq/nvNHuXIaPhbJux69MxHBnT6i9D+r76dUhDjbxttJt3HLJ9Nsb2mU?=
 =?iso-8859-1?Q?+Cizp2awS1sga0+8MOJwNqI1dvXJcRAAbqhsetQxceQA275WoRimTCviKF?=
 =?iso-8859-1?Q?qhaxEOraSktHkp/LxggKGNDeQ6xPOoe3QbuCcVnSCqA1KfsebPX5OP9fdN?=
 =?iso-8859-1?Q?/is5Bvi6EWQOhe6fMZ9Libe71D3ckS1aok80dWOWM2bwD80rwggIJBoIkU?=
 =?iso-8859-1?Q?MwSFh8YKaWwFov3rHFGnuK1y19KOY8SvBKeBDhBTqx/fxk0IOcbgJwe6Gz?=
 =?iso-8859-1?Q?OQokzyjFzT8QgnahFCnIpeisWckJZJUCwabdkbOxC6g9RNO6qFbEZLv1Wb?=
 =?iso-8859-1?Q?o36blxZarSoUA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?TdOLPeAxiGkUxFwNAmJCtoCmQy/KnLJ53pVpNLSYrgsYfGsN8bk9c/Vksu?=
 =?iso-8859-1?Q?126O1Fpcqy4vymGfg/H1U1Xw0mY40wKzENN6tpNa2aQwzoTzb480dECn2Q?=
 =?iso-8859-1?Q?2tsZ6Z9nIQUJ57RqWKbILm7RYqhaKxEz8H092cd701wV9eik1YPgQQNiWm?=
 =?iso-8859-1?Q?WA59dJ0ZNs6+pOkdCz4gTrG3Gr614FkRhA6L8r11/FMsDhkhuEsANArdwx?=
 =?iso-8859-1?Q?cO5Yv1sOe4FINP7Ea0WJkFXqrMtvWEAsE5sZblz2JgSHyyq72Sx22sIY44?=
 =?iso-8859-1?Q?eR5idMHjhCA5fFmwGcKA4Gn8tPD4cKeKYomgC3gzvR+y+aXyutTwHiDD8i?=
 =?iso-8859-1?Q?Epp8IB8h7mNLXq79UkYXhMb7k8pKkLctu2og6yYyzrd0EJOS/aG/jyrzPm?=
 =?iso-8859-1?Q?aDnNvlyiI4Ocm4F3o52xsNC5FlW5XFS42bSjV5lip1EOXJMjftn5gR9aen?=
 =?iso-8859-1?Q?8E1yQJCLMzUE2R+kaJ4GnPWp7t2cLDFXAsSMGAEcSLcMumRYWiotSYZ+9n?=
 =?iso-8859-1?Q?rnobSH4igZURvE0r/Ft4oKyK0jYKr/b2ACMDIgkd5ogEJ0CHQltmLsMCjr?=
 =?iso-8859-1?Q?acd64QFmd8IO33t/CFQAsFoFiD94b7ydWkYp/NyLoOS4SBSVl7e/AIhdw/?=
 =?iso-8859-1?Q?DYaxeBtm/KuBk6t/itIBljMA2nUPTnd3uv6HsG52xmh+fCi+ab0a5tq7OD?=
 =?iso-8859-1?Q?H2WZ/HYptaOC5AYmeJstKUhpIQSUyBh1mukTC9+GyEhz18i7I9bIaUwPB3?=
 =?iso-8859-1?Q?qD741Q12yKKMqtvl8x3LeyzN/ABWIGfIGV9FHU+ZnVSYUReP0yjsdTMHAO?=
 =?iso-8859-1?Q?4ucBiyeISKxwTQGzv3aCVc/5y3MlaA7qsxFs7ApYzGGIhSvo3+OaXj4dYg?=
 =?iso-8859-1?Q?WGE+oiD6pq5ij/T+i4mO+A1N3gWa6jespPrDZlbU+Rcrp3tEzRhnA0EG2X?=
 =?iso-8859-1?Q?y3kkGs0mPaqrEx9kRAuUvZYlSdFaDnzGnjxr/e/f793CHZt4ecttH2Cp2G?=
 =?iso-8859-1?Q?mcagyRNqLGJxJrO2TgzjcFmln+oHqyUkvssKm21UjMh1LB8JhUujoEgSuI?=
 =?iso-8859-1?Q?8UkoAgWqUvomESzPdN6FDE7GORqGW8Ak6OyDuiDrSeuYVrguxYowBc5R2Y?=
 =?iso-8859-1?Q?2eOqsP2W9qOC+oga66fnds3DuCgXUGYHpuSiG9K2kF9w+KK5lSf/QKfKy6?=
 =?iso-8859-1?Q?B2VCCzXGOoeEoTfIUGsWxAtk3+t+l1rcWCkBVhxKRu2EEhQAYpbghagGGK?=
 =?iso-8859-1?Q?n7N2g6QTDqObv/ww3zK1vX/1FH2h1Og07c8L3e4flPwvtLxhYixbS6/zjv?=
 =?iso-8859-1?Q?sYKHDMapvU6Dqfa4clQbmWKfVxFRGbmfEgdg7yc4GiWe9JO+vwp762QieL?=
 =?iso-8859-1?Q?kpjMxIPta3ihMWDQFynDhLjWwp4EMLmoym7107EFKh01zx5vCHqb+oOF28?=
 =?iso-8859-1?Q?6izG+Cp7NqviI7+Yun9qT8jkPbmXvU/UwQvhsiK6/TDmXEFiuq0sBXitcW?=
 =?iso-8859-1?Q?lZc3RvDWQ9A/9JlbkNS4avRcFlRyH9Vqb1H7na82xpufJsKznz+ENZQEo3?=
 =?iso-8859-1?Q?BKYklAN12spiE/veF3EWwZHoJX3NHxPk3V945JFYVHo8pJBYYMkBrsPwao?=
 =?iso-8859-1?Q?e+lHrVKKEoNkGIg+ThlSjnpOZsIOVxzITke21LfMxjhYU9yV0xnHME60Ze?=
 =?iso-8859-1?Q?tGU1pCFXtfusZEaTWDhJOjPl0UaqSqWaVgz5Rt6cqlDXz8fkC3GOW6PIW8?=
 =?iso-8859-1?Q?KgW2Ph1bx+ZNUv68o5tvz9YC3k0iOCAyYUopcF/oYJXacBQ7T8cFGPpIhV?=
 =?iso-8859-1?Q?mpqjNvDBAw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f407f3-8735-4b42-fcee-08de672ce08b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:12:37.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsnMSYKEV/MnvDabcOXAHrA4LAP9ihWitlC/E2yw1W70KdBJfeNaVARk0aQpjDTwXkkE164EcKlwSsaIBqLM/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257847-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 762341096AC
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:19AM +0100, Linus Lüssing wrote:
> @@ -1081,6 +1101,20 @@ static bool br_ip6_multicast_querier_exists(struct net_bridge_mcast *brmctx)
>  }
>  #endif
>  
> +static bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx, int proto)

Nit: Can you change this to 'u16 proto'

> +{
> +	switch (proto) {
> +	case (ETH_P_IP):

And drop the parentheses?

> +		return br_ip4_multicast_querier_exists(brmctx);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case (ETH_P_IPV6):
> +		return br_ip6_multicast_querier_exists(brmctx);
> +#endif
> +	default:
> +		return false;
> +	}
> +}

