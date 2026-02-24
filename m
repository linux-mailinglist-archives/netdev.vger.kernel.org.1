Return-Path: <netdev+bounces-260564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CTOL4rEnWnsRwQAu9opvQ
	(envelope-from <netdev+bounces-260564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:32:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 160D61890AC
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DAAE31B5938
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF103A4F31;
	Tue, 24 Feb 2026 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oUXVBP+X"
X-Original-To: netdev@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021102.outbound.protection.outlook.com [52.101.125.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A42D3A1E81;
	Tue, 24 Feb 2026 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946900; cv=fail; b=AgsgfldLIdzAwVrXnCStImRxN67Rq8QZzsmFN1y0kJPkp/wQ/QXUuJa+PW6+aQ92inLuC4gFFs2sblP6yc6JTjI1P67e+n7v0cy400oXOaUa/n1wg9/dnhoohBbu+SvB+4kA2SobNbakAB2EB0GZjVfZSqudddmspXkqfp8O4Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946900; c=relaxed/simple;
	bh=Y6q2cKIxrlJP2Q+2gEAWccuDV8Qj+0kQ3LlwHDOW/EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fka5B45YsNXsMkUQul4ek+pcU4yATJiUA+ZDc3Hvl3FaJ5/vxkQOslYtKbiAlrm7cSOMzjDY0ilC1BlSaPHqqvsV5ToDTwyhweL+P/2B+pmxV9mjWfoJ4Ng5D8U9G5C02pB6oq/TPOFupILh3pufe2/IbX3hAyfoQMrebOZHvMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oUXVBP+X; arc=fail smtp.client-ip=52.101.125.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAFdMn/pK02/FR5pyaSHPFzX2aROSYZIdPnWzK3h5FGJXUFYhuYVCG7E9ku1nAwmwAuw0yHUywfPRx6xKn78N/HnsAEkKvczth9I4WRcjhOAR5ptAcGE04r93mmmpiJ4yuv6a5vAnfy0ATiBzHd6qKiBtfhrgM0vNeehNhD9MCc+UDYF0QBHfzcRc3q0gC+SWZlmGre77LQj08CrTU7oZc+w4a+d3dbaMoMp6SaUYYLLbUvLvYf6T0v0VVX7mHiXV4k0BGZGs7vyWqst5hPZuP/YtjWMT0DBcKiKmCpsDk29HU1Za166MxwjUN2FBDTBcsyc07dGCDQ+IO99X0V9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oblD4ebdjPE66qy2PiMJWLNOTP09pxZR/qWy18JkVbE=;
 b=Ocx3bQLZIjDQoj4NepsGUIyxHmR3woCL/pfptfd3yb3tVKzVaALBhr7uU94uz3+Dwo0jzU2scswdU9mj8ifvXQa6vev0KEvVgkKCaD3EcOY5NCUTXyG3fuv/2MngTbMaPQzPhZhGzUzixWerMkR7UABhpM1xcQ+5cHT/Nav+g7GZWfDApmk26u5u/BeISbC9uSuSwOMgtyZpvk6Xaeu42DGFTPsH5CmRC0Y9lcPs96Zq8/EzTCt6O7DAfW148zD2FhtSOzjIh/wAHB2cS3zzHMNfzWVPdYaEl4xP5ftBwoOI6+NePGk4lZuw95xDyEvmSok+/GQOmVo8uJ1NoyZ2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oblD4ebdjPE66qy2PiMJWLNOTP09pxZR/qWy18JkVbE=;
 b=oUXVBP+XBWhqrTGxtFmgmZtDrJVQ++wPKuxsVKJ9bsokgTuZaswB0p3MUz0+Eat2a3/S944zkBnZpOwBwz2BVMvaJEfH+9lW/Zl/EfgayeTCYmQQrbrjY4UZ78U5odKiZ01R/4U0wgPpvRri1reE9/OeeC6RAdNbWs9qmYJMdIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6904.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:418::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:28:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 15:28:13 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] net: ntb_netdev: Make queue pair count configurable
Date: Wed, 25 Feb 2026 00:28:08 +0900
Message-ID: <20260224152809.1799199-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224152809.1799199-1-den@valinux.co.jp>
References: <20260224152809.1799199-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0195.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: ead3721c-e04f-4099-52fb-08de73b952d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pb9PoQvnqm0yIs/3KvCMr0QslKUKpu5zd1Zkzi5Artb36rkhg1GXgUoa4wTl?=
 =?us-ascii?Q?oxnsaPvS8VourZ+RzwNt2Y+5dCZENBU8GeArXSUuiQLk7pQ4G7Lt0OiuKHcX?=
 =?us-ascii?Q?4tgDAMoVbCvwpa8DNdRhmRsahmHuOnh/LkDdRI8bsKmE52FUTc1Feg/osVAX?=
 =?us-ascii?Q?QvqQsRi8y6RPdWjgJeU4OAmR2QulmlrS8HaQmlXDp0KGCMbYSB+MoNp0O58x?=
 =?us-ascii?Q?NLQVmBv9kBfN9Q/AcqPT8Nq4ZrDgPVKGqvm3a23SbAGFazPinOxUerl8Y/PL?=
 =?us-ascii?Q?oGXDUU7q6byPd9ivOAVuhxSaXA1XuSQDCfK6zHfUWqDRu0aQ2cNoCnr7jG4h?=
 =?us-ascii?Q?JGrnCDvYCgFyOzOyoEqJCGvknuvIbYIeq3AARaKQTB6WoLOyamjDYQn1x3Kt?=
 =?us-ascii?Q?VfWjT1O458/41I9ZlUTScU5a3zmDXuziGjeXKLPskKOlU+rOkaBqVwvXc5Up?=
 =?us-ascii?Q?s8DC5aml0FiQzCXGUDv2IYtSJVH/kRKuNdAeKYt0Ix6Rb+fyuM/LXFID7iKz?=
 =?us-ascii?Q?WIW2ce0cChL7woaYB4jFhoOKAqgVdnb/Hyjhy27SyCtk7kl4vl5yBgXUTk1A?=
 =?us-ascii?Q?5nS3Pe3kzvRpSffPaJzqdoydFWYr2YT+4azD6LPJM4cdqq2AsaLMbEM9SqYf?=
 =?us-ascii?Q?J7PMc5Lg7t+CqFT3W4OMEj40nXwwk7ShLzGONV2Fkx46KolOxMh7Qjij0Cts?=
 =?us-ascii?Q?/7q2Tz/DEtC1/S+Q96WlSZ6zWQr+ZwbprEZb9Cuvnv5XCZqDNPk2X+3BxRW4?=
 =?us-ascii?Q?RcKGfJmlDWgk7WTGQa4hcUisFxTxcrKyqbgACH9SJXFEd61kZe9ti0dKTHIA?=
 =?us-ascii?Q?dt4tAt4xE07RJyML5AN6jsNOPDSW06nDsHi/xPLaYIsQl7JTpw87i8gAFrCy?=
 =?us-ascii?Q?BF5jQepdrJaYbz6MaIMM1VdCzDthNhIc7Oppe0Iz9a4CMceymDtp0In098E8?=
 =?us-ascii?Q?x0XBNDj4aTy2FTmZ1LRrnMd1Tqw1ZdBax8EM3zOcLdvaPUGJr5BUrwuStXqV?=
 =?us-ascii?Q?q/vXgstS65ic24qQ7IDIwAqVQUwN4ot/Wr4VoPHs1wiwoq9RNBwFpyxSdXgo?=
 =?us-ascii?Q?RTGQayIQGwdjY6mVDHZpHbcKJpxxAo3zbjbQ9qOm8jSe1ZOI+KeCqEvDD0BS?=
 =?us-ascii?Q?HUhI9jseIHg3SwWAIQzqcHfpPAKJu7vLwsfhGj+u4a7IA+Dn7Pfd4I46jURn?=
 =?us-ascii?Q?a2GAUcRvT668wLlkcTAwm/qZ+6lti7wlOIQF+pLKhwvOrqF7obSBWVqMXifI?=
 =?us-ascii?Q?MVCwdjbNfSHVK3le0OaLaa8QGkx2Y3lIAewPvqhh/+hBZzMjMQg2098g2DIG?=
 =?us-ascii?Q?MYo7nhCsgz/7Vs/2ABSEPHD86rW/uXNFQ1/RsN7FKxGMcwOvAq1G1LWoTxJ9?=
 =?us-ascii?Q?a+1e/U7mD711lSd4/ujWvSi1iktGAArTnyrwvmqDyzm20p1qxb1UBRSc/07t?=
 =?us-ascii?Q?eq5tmkneal6o+N2KVqf2v/pm2Il/l1QwV0Y9Ss/smPbgrFTq/Rv0UNGUFzTU?=
 =?us-ascii?Q?5L2VMTdKytXy7nF0LJXgQwxUXIrpa4aBlFmJ7X26eU3e+oIMKOAJrl8wXzAa?=
 =?us-ascii?Q?l+l/ovQ00cm6Y8q92ac=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CwUoDjKEez6TUWvVunyAsT902IqccsmxQxoL0EXEr2Ay11xHN9OxSm7tVcpb?=
 =?us-ascii?Q?roN11LGzr9bcC5/JxJliCRoyLp6Ru/m8ecaD8quH63oK/zG7kRBz6Ju/MCSy?=
 =?us-ascii?Q?nsijr8N2dJ1F9X58M0nIyRrMV976yOc66sYMrSCG4BAe2jrcFJsY6ron2g9u?=
 =?us-ascii?Q?TSI+9XIMCvzoaokp71zWEjB+Igva7ObjnsAYj2krZ/9OFRP/JUmziwXNLbgR?=
 =?us-ascii?Q?eC48237MqmlBdxWQBYBzb050yTller8PzC3lC9D/JeHWtDZ7/hWO2BQsYoZp?=
 =?us-ascii?Q?q5rQ0YUy1ST/me51y+891RRgKzjT28UxBXoNHN/DrOAyJydrfJiARA/kguBf?=
 =?us-ascii?Q?h48M62SPDIZDirhINYkGxkGu5F4SJQQ+AwIii7bvtiSEi65XU4h3ZornxD0U?=
 =?us-ascii?Q?dTeMzR6wrDtfEVN/ppPFkML53cRIlX7t1k//6IWD9xzH4cvD+A4rAIyunDAa?=
 =?us-ascii?Q?fDlFz1pfn1vsDoAb5zx6n039P3WCEGVaB9r66iyXBMVSjAizm+4RYpbGClap?=
 =?us-ascii?Q?KqICoBAJifJd73JxGGk0ieproD8rTDAA2XAC/IVjo3m1Bu09d0790nXyH1sQ?=
 =?us-ascii?Q?as5moI1SlQgQANudFftIflWRrfb1+zvrEcNUJQ8wz5YOCJBo6OFN9cIpro8B?=
 =?us-ascii?Q?gbN+J/jQA5IYfIItC5vcAkDl1EtRWtKWWEFKtCjQ4pdWme/kHG4XKBMhxl9Z?=
 =?us-ascii?Q?tyCAr5Yq79Oz0psZDgxrJf4Ja3s0h+SCV1KGvAr9w3PXFJZ/bVL4DFE6CkDj?=
 =?us-ascii?Q?3PKfXyL+HqG2muiP7TrZvOhS/MpFrJv2/vVKy+jpBwZBhZAe1LC5Le+D4qOx?=
 =?us-ascii?Q?GGr0JOFPkptXsxRFfEGyX+g+UjBr6rnlYfAQZ1Mxj/t/Bakf8i9G1JP2OaDh?=
 =?us-ascii?Q?R9WkNxEGLghp9DWpBQB02AT8AwD2J+R3+wo33+5JMm5U4l1lnuGEXYnoe1Ev?=
 =?us-ascii?Q?poQWR4CMGC6PLN9AzL3uXE0eASztSYn+rGlRmqhm1BQQnoyLqprraLB62mfe?=
 =?us-ascii?Q?J0gDHHRESfYsHgl9TU+5h5CuNNoO9wkme3Vjiauo6O4gu4ItKpbbbZQqpyVt?=
 =?us-ascii?Q?S6fhFuRsLCkgdmGlhSGbW9nz40cSTLyAyJSbp7eSFx6embuyvmDqVL8BOSWY?=
 =?us-ascii?Q?X3AjGFr82T1CuXC5ehYSSjV5NS8dR9Y5AbBXqj9oBtdX1lNSoyQDsar1axbi?=
 =?us-ascii?Q?v4V5zOZvqkcn52tYdv+LpXLmgmEQ45nkBjgfINIzvHIPlbZWi/3GrqDMesFA?=
 =?us-ascii?Q?Rww0YHQEGuYiGOm9ZWP6LZqY6Nx5fyDjG0UtYlLy2M/hv2f02zz67prRVORW?=
 =?us-ascii?Q?jnqh/jpAEXFuuWJQMS3pIYSI+U8AowShZw8nMg0X3tpWyeHELDEHGwt/7nsQ?=
 =?us-ascii?Q?ZKOkBB570aGdYL/YHvrmSA732b/a7isZueFxGx8gyqMpDd4IqtSA76bF3Uwv?=
 =?us-ascii?Q?olAfnLw3FQ3KYqODgloQUwHZiFaZzBSQ+36U6kygS/qSeK0KNJpvnq6+gYTW?=
 =?us-ascii?Q?VoaH1H4BEvSXNdhNwyjHLyrR9F1QlVWq5MqvhDv0zwnnZ2WiRWGCVB7MzU/5?=
 =?us-ascii?Q?AYyWRFG4BmeRu+AHw5Y8jc2mJ9Mkf3RbeBTbt2afgAbh9Mq47xW1x8IiBXm8?=
 =?us-ascii?Q?PlhL+XXhsPIhjaqlP9hQO0rTU2wXQSU8Ih26KVDosHETuBcTjdMGFuttDGeX?=
 =?us-ascii?Q?9cT/isLO0qmCVTbsrL22XhMZqh1SCqbRxoeg5vR3mS2ew6Ttiv6aLLzDkuF1?=
 =?us-ascii?Q?oauiR9iNDb9hSlTOZc9n1+yU3YfPrXilxBCaKvstywLFMC+cRFMt?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ead3721c-e04f-4099-52fb-08de73b952d0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:28:12.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNa0MCWZ+6Q7vVh9CYJUpSCF6RTM3MXjr5Mhwegdzj0PgLuaafH2/QZl6Lyyh9tE5K5AVSdMiRGa2v225l0UYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6904
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-260564-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:mid,valinux.co.jp:dkim,valinux.co.jp:email]
X-Rspamd-Queue-Id: 160D61890AC
X-Rspamd-Action: no action

Expose ntb_num_queues as a module parameter so users can request more
than one NTB transport queue pair.

The value is clamped to a reasonable range (1..64) to avoid unbounded
allocations. The default remains 1. Since we don't support changing the
value at runtime yet, permission is intentionally set 0444.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index d8734dfc2eee..837a2e95f06e 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -71,7 +71,25 @@ static unsigned int tx_start = 10;
 /* Number of descriptors still available before stop upper layer tx */
 static unsigned int tx_stop = 5;
 
+/*
+ * This is an arbitrary safety cap to avoid unbounded allocations.
+ */
+#define NTB_NETDEV_MAX_QUEUES	64
+
+static int ntb_num_queues_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 1, NTB_NETDEV_MAX_QUEUES);
+}
+
+static const struct kernel_param_ops ntb_num_queues_ops = {
+	.set = ntb_num_queues_set,
+	.get = param_get_uint,
+};
+
 static unsigned int ntb_num_queues = 1;
+module_param_cb(ntb_num_queues, &ntb_num_queues_ops, &ntb_num_queues, 0444);
+MODULE_PARM_DESC(ntb_num_queues,
+		 "Number of NTB netdev queue pairs to use (1 by default)");
 
 struct ntb_netdev;
 
-- 
2.51.0


