Return-Path: <netdev+bounces-137416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E6C9A62B1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477941F216B6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D31E47A5;
	Mon, 21 Oct 2024 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="WgCWGnEL"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801BC16F27E
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506283; cv=fail; b=X5pkFojZxBsAyCzWk1YBbZFUa3AS9BEa0pr4NjyzGLj0gadZNlW6EX+KoT5DKOB32HDgaKczASCUKtH9Bv4EmGJmNIhva16zqD2sQ+I3WkuHkR0Zgz8qRaMkQs3R9Qz4TdKRb8snCzsUhmuAfaJKtC/V2SalLmCi3iOmnQtMlmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506283; c=relaxed/simple;
	bh=T+HLM7kYBiNhj32OMoMaS2Ud/Ymy2vZaxhbfZbD09JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qRgwC/nGoZT1u6FLZ9OaWbTilNE9AcLoRMVC0lc//nZixtXhjlCz9X4y3rIRtC6UpEVj8AUPh/SbOAxy6LC7iDxs5OSWV9SarmeJLAPzoN7fkHUaWQmFN+vFbwMbPRugyLpp7JIU+HDEeqtV3iZ8Udhwwhnr86bp2u2wpJ8+d4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=WgCWGnEL; arc=fail smtp.client-ip=185.132.181.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 86F1FC005A;
	Mon, 21 Oct 2024 10:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKIoQYgffWAtapp/tBAeWaD7KJR4bmF8GWYX319+9NVqp8dwCJF3G59h1PpCaXPqgMYU5NKXYDUQIjayiV9FR3UY4UIqFn5Gdl4KftQU7d1K1FdSWm7o/6NEDA/Ta/2QbZeMfq0wheoaBRBmFWBD82NONJ/ADMgmx1EDulQCZebCgSkRQH/e9VEwuHdDKotUmg9QiffxtCVauO72tDJMUT3DfK+G7KgCwTdmNjjok4ZjyixSK5I4IGJGJhNu6rijQvev1sDjqUhFmg4m8+MrbToG07j5ikw/uiZQGI1Z813iBWNWzfY3ANtIiFRgbU0GIExs9O5smPZ88oVZ8xJkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIfnBpyQ3DQM/afkECK6Vaqlj2HbGYLTwLExlShUpBg=;
 b=NDfTZmyGUZ/GdsWzHh0AycaXfsi3ywDlVuXwTV5Dq0YknpJcjxJM9b7cwCVYOQfLmP82u91MvkI4JH1rR2gewgDiL2Ma3Dud159lI+yDC5TPyTAjIS8MZDRLDB5RHMzE0v0yCSATPfA3mCgF+VldJlyP5T3x9EeLKu5sPwun/cyqpcR6+NguRlT3GggDmzDgvRkadHyMpRxMaBNhJjMvclXI5Bi5d0hsphxhlFeqcEokTKYb0jWGJd0Hz1qnIvrvvLMy79ZV/8M3YlMC0r/D+XA+LZimP2jRhF5iVTuAmMISk55s5ej6k/5ndQxlyDYuB3TmS1r0yydWdYkgmzx12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIfnBpyQ3DQM/afkECK6Vaqlj2HbGYLTwLExlShUpBg=;
 b=WgCWGnEL1PM6HbyM86Lwxk4QVQ2MePkzlWczECyMCuRI99PqNx/ZrynumltXwbpu+vzd6JMD81pOBSJpZ3sQfXifPwwJdxqYNgNYfe/jK/x5YEzbaxTumzdhC4wjscKMlVYYZgOoZnqYK3rlJ/4WkDCAg3TPgEy3mtTrueMkOlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB9051.eurprd08.prod.outlook.com (2603:10a6:10:470::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:24:32 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:24:32 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v6 1/6] neighbour: Add hlist_node to struct neighbour
Date: Mon, 21 Oct 2024 10:20:53 +0000
Message-ID: <20241021102102.2560279-2-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241021102102.2560279-1-gnaaman@drivenets.com>
References: <20241021102102.2560279-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0010.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::18) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DU0PR08MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fffea36-50d4-43e9-803f-08dcf1ba8d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OKzoiVjN5cHY+VAaf/XLIsn1h+7Cw/g2JYP3Lz6tLOWBjUOJjxffu9zrXwnQ?=
 =?us-ascii?Q?VUzQ0v9yxu1VtpxgfoPJccvTyV8jVF+7M3OdSXrSiOXppYEjszQnQvWTFB0h?=
 =?us-ascii?Q?jXeQYlaY7fNntgf5nkUF5PMZfQb1pEZ+e3yt8cQNRxO0QmsPlOtH2tiXYJgo?=
 =?us-ascii?Q?r+QsIXL3ogkqp2FEF4F9gzLZw8eOgrNiGM+21fyVZKZfMD1K3tPoZEh6K2Lz?=
 =?us-ascii?Q?1GqHewOvj3RktkxfkQbONEFgPlYeF4gHxSnlIaE1kI7me9+tc7Tz5iYoTjQk?=
 =?us-ascii?Q?ncV6mPqU08amWheCywNBTSV1fGQ1tEMu7WUKmijL4VC2B+q6PQgQus/JTAs7?=
 =?us-ascii?Q?DFIetWQnUj5oV3qoi62nvFNr9ETWY1ORQdGfE3l7I032XE6ozyJBe8vYP1jt?=
 =?us-ascii?Q?szc/PYz4vF73iZdLwqPncGqC4/6BQNSVGWue/vW+R0c+gh/ujYb8n3aM2pQS?=
 =?us-ascii?Q?mZojvK7KKLnIt98AYASGmsi5NB6vTgkOLOlqbO8rI0jQMWsR9XNR7D6GERso?=
 =?us-ascii?Q?BKB36Rz9KMsKRFvUby/Ly02LT/cNCB5ymrWr4fYDpd4IwmQeXGtNheptdMW3?=
 =?us-ascii?Q?8W1f9VagDuNjNa/dpKuC/qSf6FTzoiMbNIx0CXS9ceExTD3mp0kS3s+J4Bkm?=
 =?us-ascii?Q?E8mY5BRu1zjZUaQChnuVNfI0eIk7pEm2zsO2InQLtoPu7R1ZK2RhjvZuvW27?=
 =?us-ascii?Q?ziIWApol4AG/9D/YdfJDKKgM1a48UqUnd+x6BvST5wYyaB43L6iGLwopHGBA?=
 =?us-ascii?Q?hdY1S6e/VDn8bchpbd4Vc5qV3QbQMuwojpqScfPpEhrp+PT7m032HHV5tGdE?=
 =?us-ascii?Q?Vl1oaDGBeggNaNjKWmwhk6k4QrfTFmtMKzFkb81e9dHLsvkoeWowBwNHwbIn?=
 =?us-ascii?Q?SQUgwJUxAoC11p32dd4uHJlPlYzYRChsPL/kMpC4danmhvFxnh+klbeMrwtb?=
 =?us-ascii?Q?A6CtyPkBfUr+vTV3bfIzv4apB1BKt/s+1HeFGV79olIh5A1UxQZVdyn0tPYG?=
 =?us-ascii?Q?DAh0AbJifvrcqNwUgPjehgB5YCltj3gz+1uzvjNPfVQyT3IpIjkcKNfI56EO?=
 =?us-ascii?Q?UYJOkRCuCtNJTtxrbT2jhmgUBsaZqEfS2vGkHBuQV4LrgQj3Iieu8ZFM3P36?=
 =?us-ascii?Q?dF9C/SY/7Cr7b+1xi652LJiDU2jwEwO5jp8M73BW2u2aVQ1JFggvCeQsR+cS?=
 =?us-ascii?Q?Wc6pg0kUrVfjMBiJJP6Teq4u7Ddcg84dhJTJREAMc+NoVCO7r/jujAB8KUgk?=
 =?us-ascii?Q?MWXpMxKwwlqrwTUiECy0MVqnNsNplzJCPFThe8rbWIEvpHeLPZLe+yZg7tDb?=
 =?us-ascii?Q?c1dYhh9YFr3MiYFyCt8aYSVrKUXKrKaat1/6fm4MVxLz4PbtBEhVnvlO0+ii?=
 =?us-ascii?Q?vY4k1kc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A3pejwYp1uJC5CP112Ga/+IA7ctCC0haylJs2VoVEWRJ5JwjigyaKXUot9Hq?=
 =?us-ascii?Q?uRy15o+WOyECtvaLuWpb4lgOOHV8uAkbm7lcnwKpeTPHw19mYN3u5yExQcd3?=
 =?us-ascii?Q?7ZsUOrOqJ4va2ETaIYmmgw5OIxjpiysHzs6GSQfyUEW8pmVc/cAKbaW6o8Zw?=
 =?us-ascii?Q?tY/QHTpVEZVyyK/gSbJH0yt3l07Dm+yaxQv5o5Yw3PkMWxERdJ2xj8C98lQS?=
 =?us-ascii?Q?9GujPT6P0UDRB5+TfsBNSk96iGmNfjwctGeBD4zYlA1K8ITqi7rVMyGpzAT8?=
 =?us-ascii?Q?akopazVKlycGHIeYzJZ4XEguqxqXO1Ft2g8jDXJ5yZrEQE/lZu479OSIo1Ob?=
 =?us-ascii?Q?3NrL/3ZFYZUk3iYo1SF/UvEu++VQa7agpdeJSuH5T8o05Tl2p28pg5l+/bYf?=
 =?us-ascii?Q?n7W41prDUYYeUr9BKbmgqk1z1PACGmdhvuDOItG7X+LtsiZMqFStUmQ1PqMC?=
 =?us-ascii?Q?Ia9HQ3fV5MDwmw0EEIdes9F9WnMMUTs6nhHx22nNYeqTCLe32d+g/Rjasylc?=
 =?us-ascii?Q?eVrHEJgUEJpm1VbN2BW3k/frwVuDWv/i+Y6gI7bilYoJPA0HvhEXmnVLOqLd?=
 =?us-ascii?Q?4hniyyEzymZO40ermOStjeRpit66L6fmMTkWUZoslKVoQHib56ygc+KJ+wSF?=
 =?us-ascii?Q?TcSqs00OeOyl+lUxv4ut5MCcs0qjg53bz7P15b9SUvNv60ZNZtE0kTMOfKyH?=
 =?us-ascii?Q?4W1W8XD96/ACAsPavmpFqOjbORjoW5fchkxhXn2gbaWOVrKWh46mWi7wlTcZ?=
 =?us-ascii?Q?4U5/3M9Z9sRZuNz9TIQ4X6VUGFIIurjcVeGEhjQq4BB3eeFz82Ld9OrHZDTC?=
 =?us-ascii?Q?eKLohNin2eYO1eh6wTTyiy60a7LilOHCDrlPy4FOgUIKYzRdQnxSD+MNJgDs?=
 =?us-ascii?Q?BPKUy/yvhgq8qGwbQMndJEHM9M76iVT9q766dD+z6Jo9L1Jv5ID4X4OX6c33?=
 =?us-ascii?Q?MODvf7olGeAlVNoZOedrxor5dtfXB71s7WKg4YVDwGkxXh+780HauZsoXFmP?=
 =?us-ascii?Q?uQBacVsdRsqna2FO99L/llT5mBDpUYSSAp7n6YfXNgGl8OUrNRbarJNUrTQK?=
 =?us-ascii?Q?9oC65OfjJ5ggc/GayvVdIJUU+/BYu9l45JxTLnNscLFs53tBk8McntsvCxF6?=
 =?us-ascii?Q?yCEjaDX5FepEYGOxmNA3TpatmnPLIRo+4SaRLGiF/aRgJXq1AHfdppuwCSBX?=
 =?us-ascii?Q?blTg/yHeRN7n+FPSNEuZakqB/Spql90pYML1Js5+T89YSuwF/cnShyVWQz4K?=
 =?us-ascii?Q?rf1YrO5PP6G/bU3ZdKfgn3iQRpBL7BNKqU3q0KlK13rF9E5L4QkWKSlL3bo2?=
 =?us-ascii?Q?PIGbIFW4Cq1JI+FQ+T/jmYkLb6fDZVXiJDNTrEMbZpiwqbin7LTauGkmeWOm?=
 =?us-ascii?Q?6moJqEN8YZ/J/Qdop6KUz5clnN1pBNCX6iaM+3ehU6MAEZJHbaGPbjJ8/VYn?=
 =?us-ascii?Q?8hmlL/saZv4hOIostmB1/X3Yg46M7yxFaxFEfH+/vSTGvgVqHZdOQXQxpvwd?=
 =?us-ascii?Q?LZu55l8XPm3f6r6jdi3l8Q04C2FXWohpBOqTImXt4eyon34CWuCMoXL+843R?=
 =?us-ascii?Q?TWMrHYoFcmtGdJYDUwe3FnfiGzoCsXXy+MNLrVYmZl1WlOVJP3DaB1tdBDzm?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	93YTaa8R0iUCgBKG0SQkVdVVf4CClukH6UfpkIwJIzQ+GMGc0yCDX06G7iaKUBv/FvyYQrjDy5YPqtAK5YffUzwiq7boHgywZLQh7o/ky1m3K3s2IRHKgcyj2DxMgH2ceqX+Tv3DCvDcXsbHISwiSve61yqAOOBF9IyLUSXwG0xYetVtsuFS2fblOspRzlMmKiw9GE9TWMt39DKXfuOhQObbyLm4K7NhLcLg2FRTlEcIVGIxYtFakOTbP//MtoqolDhhLKOOHDyXcLkWm5TI/crx5c+90YpYLTziUSQcr2riz6lcSLHYJCSS62MqDxyZb59FTVgWayGl3zUkNXVPlfuc1slRtwH5z/huF16BJOytsETPMIs25ljAgv2nikgHEJJNNBMc/CL77Orhz9ngKHOHUwZA9SlXborVL7IqoG2ZqhxcYRLknAOf73p/24Huhl3EZKF+0R2l8TkNXkF8JFDjomfWWJ9/0Yy7tqNVtRSAizsYk9IsQdT4YzD+bFvG1S7wavjUGIv6ItrvNPeglCB2eH87V3nE+LsWH9WizlVTZzqelJXBoZ0TZYKGrHmHrAv6gAbjdq/1eqbSCzxNwX+WMPDJP90emwQyX0fvaqjsIjmEomo2cVTwLQI1Wgt2
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fffea36-50d4-43e9-803f-08dcf1ba8d71
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:24:32.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1opCJiPH802TyeTqn15y/jGNeA5ppjVTf37SQrSjsJjY05CKo0D0B1g88MREHew3jjXpoDAXsJfAMLV3G0XoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9051
X-MDID: 1729506274-C2XmVRV_hHaj
X-MDID-O:
 eu1;fra;1729506274;C2XmVRV_hHaj;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a doubly-linked node to neighbours, so that they
can be deleted without iterating the entire bucket they're in.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |  2 ++
 net/core/neighbour.c    | 40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 3887ed9e5026..0402447854c7 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -136,6 +136,7 @@ struct neigh_statistics {
 
 struct neighbour {
 	struct neighbour __rcu	*next;
+	struct hlist_node	hash;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -191,6 +192,7 @@ struct pneigh_entry {
 
 struct neigh_hash_table {
 	struct neighbour __rcu	**hash_buckets;
+	struct hlist_head	*hash_heads;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
 	struct rcu_head		rcu;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 395ae1626eef..45c8df801dfb 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -217,6 +217,7 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 		neigh = rcu_dereference_protected(n->next,
 						  lockdep_is_held(&tbl->lock));
 		rcu_assign_pointer(*np, neigh);
+		hlist_del_rcu(&n->hash);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -403,6 +404,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			rcu_assign_pointer(*np,
 				   rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+			hlist_del_rcu(&n->hash);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
 			neigh_mark_dead(n);
@@ -530,27 +532,47 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
+	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
 	size_t size = (1 << shift) * sizeof(struct neighbour *);
-	struct neigh_hash_table *ret;
 	struct neighbour __rcu **buckets;
+	struct hlist_head *hash_heads;
+	struct neigh_hash_table *ret;
 	int i;
 
+	hash_heads = NULL;
+
 	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
 	if (!ret)
 		return NULL;
 	if (size <= PAGE_SIZE) {
 		buckets = kzalloc(size, GFP_ATOMIC);
+
+		if (buckets) {
+			hash_heads = kzalloc(hash_heads_size, GFP_ATOMIC);
+			if (!hash_heads)
+				kfree(buckets);
+		}
 	} else {
 		buckets = (struct neighbour __rcu **)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					   get_order(size));
 		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
+
+		if (buckets) {
+			hash_heads = (struct hlist_head *)
+				__get_free_pages(GFP_ATOMIC | __GFP_ZERO,
+						 get_order(hash_heads_size));
+			kmemleak_alloc(hash_heads, hash_heads_size, 1, GFP_ATOMIC);
+			if (!hash_heads)
+				free_pages((unsigned long)buckets, get_order(size));
+		}
 	}
-	if (!buckets) {
+	if (!buckets || !hash_heads) {
 		kfree(ret);
 		return NULL;
 	}
 	ret->hash_buckets = buckets;
+	ret->hash_heads = hash_heads;
 	ret->hash_shift = shift;
 	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
 		neigh_get_hash_rnd(&ret->hash_rnd[i]);
@@ -564,6 +586,8 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 						    rcu);
 	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
 	struct neighbour __rcu **buckets = nht->hash_buckets;
+	size_t hash_heads_size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
+	struct hlist_head *hash_heads = nht->hash_heads;
 
 	if (size <= PAGE_SIZE) {
 		kfree(buckets);
@@ -571,6 +595,13 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 		kmemleak_free(buckets);
 		free_pages((unsigned long)buckets, get_order(size));
 	}
+
+	if (hash_heads_size < PAGE_SIZE) {
+		kfree(hash_heads);
+	} else {
+		kmemleak_free(hash_heads);
+		free_pages((unsigned long)hash_heads, get_order(hash_heads_size));
+	}
 	kfree(nht);
 }
 
@@ -607,6 +638,8 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 						new_nht->hash_buckets[hash],
 						lockdep_is_held(&tbl->lock)));
 			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
+			hlist_del_rcu(&n->hash);
+			hlist_add_head_rcu(&n->hash, &new_nht->hash_heads[hash]);
 		}
 	}
 
@@ -717,6 +750,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 			   rcu_dereference_protected(nht->hash_buckets[hash_val],
 						     lockdep_is_held(&tbl->lock)));
 	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
+	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -1002,6 +1036,7 @@ static void neigh_periodic_work(struct work_struct *work)
 				rcu_assign_pointer(*np,
 					rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3131,6 +3166,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 				rcu_assign_pointer(*np,
 					rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 			} else
 				np = &n->next;
-- 
2.46.0


