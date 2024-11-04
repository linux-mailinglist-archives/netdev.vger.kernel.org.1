Return-Path: <netdev+bounces-141422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AEF9BADA4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBDF1F223D4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2D21A0B1A;
	Mon,  4 Nov 2024 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="K1/1Kcg5"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDCB19D07C
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707519; cv=fail; b=HzzHr6chAUtvq7Z6eo0/1mizwXnjgEKW4sY0YMXNv0UmIQPP+ycyR8hDnKIFMPeUVqOrAWgSt5P3Us9nbIYS4+3nRIJ4nAuJXAw9hOcbKjsZH/NUhWYAqZxbtJtu8sJaIO9oFU96n+284O4XIz4bg5LFTBaHG8E+/2Z33bXE4Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707519; c=relaxed/simple;
	bh=ZHqYrq/ylBS/wdiLLl4FqAPc2N74jNahCdb8pqEyB1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bfywpuaY2mArQuNg00wWauEEZBm0xStRvXOIDMnzZ015ENmLnh1HOhkRe8Lczp59GA13DP5qXHlPiVzT27kwbBTu+jsmCMaquE7hS/lIfz2ebL2SIG15FtLAOdh2PffZ+d62eWufS7UXaVaSKGBCiapOyNXT5Aqobj/gOojWApg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=K1/1Kcg5; arc=fail smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 93161341213
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:05:10 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 943F5C005B;
	Mon,  4 Nov 2024 08:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nM0Vq2JYYpChcokmdOgG7OC+hKboVqM3arpjJ8aAlChDRarLHWN9kAT8YryHe8y2MK4AuYcgCmLPUvdnsk+lqjozAw40kLxoIWnC/g7moC6RUc9c1gk1fw6LPgMGioOcXepJl3SjFhUMw24+jT/O0nktLGZ0wUSasewb3C0cx6sHPx5pcwmMfo5Q5KHh0+MsHn4m0k1Rl8wi4wmIs+2UYMPyfoSEg0WqclG8EmXnZPv3h94kaZJ850mWy+3U0wx6eI9VrEYOpmQoeDqnTvyM3ImviOzXLuPTZ//exAReK1ciFmLu9XLkP7rKqFWqeyQIlfVGe7dP1J5WYpBpX1t18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpycxAzXwTYk3lcYeL9ldk5kHhn5p+dwhvL8dP72kDs=;
 b=d4cPxO/OjB0fsaFlmf7MrMX7rztOubXviqqBiX3Go9dBiGY3rCf31JSylNWQUZB7ns+ZzcgrIyVJNjW8LVKFH4TGrCkRss/tFghHL4xP39lCDqO27X/aW7acJ1R3AB7HG1ItbCuGTZmE0lk3eQTkUNzsn/+pXvLnPSvSk/fW3lJ6FGQ7SZFtkT0ZmQYAbsOgc7RybzEu/8R/yzStZaCKvP73AeEQyxQbFnuCVUfEeoWPUy2ce9WG5SIZRDFKrBBFcFloHR+ByoWRJFhlcjjFcqipi5jmgZ8+MMlJGYwg8heBLpDxW/98QKZRW2kBpmBmUpFq55dx0OXDraICzUTpeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpycxAzXwTYk3lcYeL9ldk5kHhn5p+dwhvL8dP72kDs=;
 b=K1/1Kcg5qy1Y8d2l136Os5pNl+05yfj/WHNs1jjp0yRNzd5B9snyII5pVuGHcWVi66H2uzlByM1TCMEUFpkJvzblZBa8UGcG8Zjpg4dk06JCWYpMzMHMoP9pQvon7zZSllkt98sWGWl/YeO4y5PWS53Gx1rz+yNjoEfDqtYKTwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM8PR08MB5553.eurprd08.prod.outlook.com (2603:10a6:20b:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:05:01 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:05:01 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v8 6/6] neighbour: Create netdev->neighbour association
Date: Mon,  4 Nov 2024 08:04:34 +0000
Message-ID: <20241104080437.103-7-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104080437.103-1-gnaaman@drivenets.com>
References: <20241104080437.103-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0206.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM8PR08MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0ddf24-3d07-4150-b14f-08dcfca761bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i/7gdRMliAi8UrlUyhWFPNh5GmurVnv0p5T1IA1g8kQPCNp4q0CibIywywCK?=
 =?us-ascii?Q?cVHIqFseeo9SMeos8kyN7vwH0gh4sKIfc1nNm8cjWfQzjq722ULjpwGjkoyW?=
 =?us-ascii?Q?yK1PvwJkFYO5oMDzLzTp6oBIic+hVH8LbG7F9pKdVsdo8KrUkClnaKquEXPs?=
 =?us-ascii?Q?2YCS3tC3ObPwYcg4273UwxfmK0jQbLIsV+CsjPyUg6hulNxRaD1PacvhntjF?=
 =?us-ascii?Q?xsAJ9Gu8qo8JW5jTeou0xkxl0RZSyP2Fj1PfqWy3KDapSe2EFr3Ka2dJb7or?=
 =?us-ascii?Q?Oee9/kcjAPETZDBABSqCQOwG553i8XPcP67ekqZc9rYyHx2ohDp3gwI4VzBA?=
 =?us-ascii?Q?hoNjdM+xUjmXN9lffJeqXUGCorqYIYnvK78KrN6gfRrmtBjLOUvyDhphQVDZ?=
 =?us-ascii?Q?+6O1dNan1MsuJ1Y2FB67YFPfAimKNMTNPw3a/gikjrYYmcTq7GSQRmZkKAeh?=
 =?us-ascii?Q?ZHU4nb34q0PZk8RFmODqanoHIK7wtuI8R4+qaKaHMbVsxuPfujr5R/yMazOo?=
 =?us-ascii?Q?kea17NMd6ZP11jh9a3569Ns/zeCruQmswZP+OhF7L0FLU1BY+fY3PHxJjhyl?=
 =?us-ascii?Q?eEP+7C8mjPciwybT+yu1GDIFDurYW0oyZe8Ipg5vj4RIQBIlO55tdHQumKmM?=
 =?us-ascii?Q?ECm2Xo5X+IT8w0rkx0kD9FAZiasB+KGC6RnNO2e712sjBbnhylMWF36G+aU+?=
 =?us-ascii?Q?nQCj7GicufEeaqAq+f1kbnpACRds3Ya2EKCaxdk+myj0hHz1anr/vUwSf7i8?=
 =?us-ascii?Q?Hi3RoI7jaystp6hO6EQGjIUSooTp+DmbpUHbnIrtvgTeWkDeESWw+t/8SZvq?=
 =?us-ascii?Q?v5zlgsbDfPm3orisAvQjhonWZ7VpYh4G+doKLG09lmOugcc8G3E4rlWLkir2?=
 =?us-ascii?Q?xdkkeDeUVwjMCqjPi6VypiLbzkoKqDOWq12svHX6ieq+S/pt4ELNRm1Uoq3D?=
 =?us-ascii?Q?cFXgOijzPFxUg432qlPeB3CxoobpP9G9lqnc+X1JDr+cCznRIB411o1fne+O?=
 =?us-ascii?Q?6savOn/WbvtfctSCl3Q08gvg43MsQpRwxhJjZ0+ULvjMy1nYEjSoPg1Kq4mv?=
 =?us-ascii?Q?Oh4zTPe68JaSbMYupg2MeAMIb6LwSoCj1hz+vxCSFkgreb/7NeewaGlsi7T3?=
 =?us-ascii?Q?vsqcLc7Di1ZiOp/YioznhboEzfGzlgsrfKspXh8amADozj5DMZ+x71bc0Mp5?=
 =?us-ascii?Q?PKUj+OwdwBTgUT6jl0LPS2AtQsCWwbpbvHdti7O7khckmoVtq0oOneJult67?=
 =?us-ascii?Q?e+beYm07wPTF4qdNX46WPOEidDMWVLEm82YcuWA5yAEBagFfGQCkstLZmmzz?=
 =?us-ascii?Q?2x9lpA86+QFVgkeYTZolKyuAUrTwfEYIQZCQX6gLwCDE4oT+5Ah/se+Y5vgC?=
 =?us-ascii?Q?2aY2Mmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2xOTv7h43CtNQHatC6n03QN4oa5s/cxYrWkFoKmvOI+erI8XsQ5OFpx67OBb?=
 =?us-ascii?Q?bONGy0/MaBOni878P6Bq7fPOd/NjGb6E1ofvwUkHWp2Ee64YslhxpXXyMvSR?=
 =?us-ascii?Q?t61NWZle95iekw8MrQWPyWOIURvuqmlvHaC44YQWLqqPxufj53i1FrG0LuoH?=
 =?us-ascii?Q?Naac8Z2QKX+VNSffxp9cL2kXRyVxE2PwWiWm782tBvD+08FHwnjJSHnMlK5v?=
 =?us-ascii?Q?ndWekHrezLwhl/h4mDwPId+HWsB9fNvjPrDs2mdddfDcmc5HDDBhK88YTzQs?=
 =?us-ascii?Q?eKGxOEiPj+1Lqa77ax3hRZnt94fJghkGP7Q7l7ueIpByYpaAiGO5GA1q9TB3?=
 =?us-ascii?Q?jOgOsMlZkRcyupPQM9NLhlUeY6Cp6TavP6dsJ2xA1SK0M6SsfzZjpdhTWO48?=
 =?us-ascii?Q?XPCh8XHC+AyQowQdB0v/VrvFQIMcVYjGukz3qprBDH0WmtwgqZh/Gu0wssxj?=
 =?us-ascii?Q?FxdCFrn1N/lnP+UaqBpHSJAXlZajB0orsDmhbNF/CdZYjXJ/FRKBw7XTvX9T?=
 =?us-ascii?Q?HWw0qJfXqC/IP7CyZWRzAhuV3IOM7mL/3FGlrJmtfWdjPqVc51yNpZTXj8dH?=
 =?us-ascii?Q?N1ldJhp8xgYkdRlSWJD6pYPEEZglvxGFfV7ZWlztXIYZNlTzaaNIWf6y6Tbj?=
 =?us-ascii?Q?zEnd8wIgklCC3omAtiQ/Bkpi/R0Bhlu5amhy6yisgvSrfEa/7QJDRyNkvrVz?=
 =?us-ascii?Q?dx+ifNtQI9K139tKPLiNypEWRYqcWM2w26MLNtefw2RAyZWUyVaO4lRm/DSg?=
 =?us-ascii?Q?3XB7IpsTYYkJWdgUB+7Hv0OBIfXpo122Cy7Sx4aY1FoGrlFSb2L0j2YqTyT+?=
 =?us-ascii?Q?cCL6HzpdCVFPP3qXPW+p/Vy+5Y2z1siUCgof3XGzzpXZI4+vOnTOYd7vixHq?=
 =?us-ascii?Q?YCWIJvyrLT7cwRc7IAzJPwhLbygzIGhl6hO7CZccDVHVUMIkxjTRJSxC2jzq?=
 =?us-ascii?Q?78zAnlqHlIepJRLuO3EdMOVnk9+781x4jUJKWfm/uEi2KMswth9MhmIsqT4t?=
 =?us-ascii?Q?JrWNId4RHLaHRY5Uh6QdT/yHQiWxcncHC4kfAttNQjhOZ6xqZX6Oa+JETI4t?=
 =?us-ascii?Q?vPFzNpwGrA2f5MeyGLx8Foa2jjAW2v+sqdftsJMl3hu4N8xmw5ULfx6qhuRB?=
 =?us-ascii?Q?WkKrP37vDjxkDJ1z1cFznSd2d2KZNa5AsjoLwVstYAMDL13V/KNoZ4QwM2zK?=
 =?us-ascii?Q?GyD1HmNGkl+5noRaYBKgaL7C2GBFlRBF0iFFxBNfbwid+qlGMyiOVG5Xv+Hn?=
 =?us-ascii?Q?1M+u3WhyAC638n5VKq7wI0BX9brFBh1YilaoBUDBuuiXUiGP272Ofq74D+7v?=
 =?us-ascii?Q?3WI+fgdTvY0t8wbqzBducT8FFCTPgW3YjGAwBbRItD+w73JGGY3yUUQYXwHo?=
 =?us-ascii?Q?KLNXLciW9MFnDWWv2o5Dn+DDTZbUibRE61LyfVkbpSai0sO7jhNm15vpwKYI?=
 =?us-ascii?Q?shBXqHrSckQ6K42UVGFHdSQX8ZeadHmqFCll/AAFbOGgPUiQNDMvLBAj52oh?=
 =?us-ascii?Q?D6yuHFFXMSYAa5Z92KgchH6hJEYGB9MoTAhTadiB+Lmq6zvQNBdgbE2O81nx?=
 =?us-ascii?Q?m5/ZGk/57CBB1oOxULS2HnJcIsUK6uXRm8JnyLcdt9eBUETkLljOKkRBq35/?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vmCYXuWIIZ+wgme5FnrTvlP3jQV4G9L19u8C3rda+jMigkeqRs674vczOAEM1LU/yNlJJ4H33RQy8RPfhhrSkiuG1T/bHQaQ36B+buBHyZO/VhknjuBLffl9rnCJF9HurNZE/1nXofdaXHOjM0oQJdeQVcFFTigiHQrQgosVi6dZ7V9zyibDFpqzOQvfzFZ5Ldna1x2ust1ed8VWsr9+E8phLyN6Q4uPAb7ncvTj+HnJX5sBjdqDtYjkQoZB+cHGpFz1B/04sTCV+5HQNdz/xvgDHrGgfc68eGDZzfSVJuWLcRjuVTmjSj1Dp/7uaS+o/hqvMyg15hxMc/R2kORFvhvNBAx+3pxQJnEqbvjClR8HaoEBveAraGe7ecaUwbNbDuJiGIAcZglFGAJ6lNHP2uGaumEyeQjXQ46dklbZkMda1YsAQIh4sYY6NsLIjLoCBfsPajznMqIggS/hsV/YY4mvpjGZirjEtVfhuSoTjoDtoKq02c91pedhm8ermh6Pw77tn/U10oGrLvMEPgEGC89CLmwFZXDRH5TM2/6298gKDXb9iqV6k1jSCAk90wgraqGGC2zycuKs/M3WtvEy1F6A1tOR6w55ijiVTSFAjJeykO3MXQR5IotlUfi1K1ux
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0ddf24-3d07-4150-b14f-08dcfca761bd
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:05:01.0902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRjygNqop6t2kdSNFOwAORH6fHC53CEF+3M9aJBER4rUzr3lPwceUaTUL341EWYDVJs1L7OJIEPe0VluF21tPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5553
X-MDID: 1730707503-ay1-1s-gy4fc
X-MDID-O:
 eu1;fra;1730707503;ay1-1s-gy4fc;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Create a mapping between a netdev and its neighoburs,
allowing for much cheaper flushes.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  7 ++
 include/net/neighbour.h                       |  9 +-
 include/net/neighbour_tables.h                | 12 +++
 net/core/neighbour.c                          | 96 +++++++++++--------
 5 files changed, 80 insertions(+), 45 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index ade50d4e67cf..15e31ece675f 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -188,4 +188,5 @@ u64                                 max_pacing_offload_horizon
 struct_napi_config*                 napi_config
 unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
+struct hlist_head                   neighbours[2]
 =================================== =========================== =================== =================== ===================================================================================
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3c552b648b27..df4483598628 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -52,6 +52,7 @@
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/neighbour_tables.h>
 
 struct netpoll_info;
 struct device;
@@ -2032,6 +2033,9 @@ enum netdev_reg_state {
  *	@napi_defer_hard_irqs:	If not zero, provides a counter that would
  *				allow to avoid NIC hard IRQ, on busy queues.
  *
+ *	@neighbours:	List heads pointing to this device's neighbours'
+ *			dev_list, one per address-family.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2440,6 +2444,9 @@ struct net_device {
 	 */
 	struct net_shaper_hierarchy *net_shaper_hierarchy;
 #endif
+
+	struct hlist_head neighbours[NEIGH_NR_TABLES];
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 0244fbd22a1f..bb345ce8bbf8 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/workqueue.h>
 #include <net/rtnetlink.h>
+#include <net/neighbour_tables.h>
 
 /*
  * NUD stands for "neighbor unreachability detection"
@@ -136,6 +137,7 @@ struct neigh_statistics {
 
 struct neighbour {
 	struct hlist_node	hash;
+	struct hlist_node	dev_list;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -236,13 +238,6 @@ struct neigh_table {
 	struct pneigh_entry	**phash_buckets;
 };
 
-enum {
-	NEIGH_ARP_TABLE = 0,
-	NEIGH_ND_TABLE = 1,
-	NEIGH_NR_TABLES,
-	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
-};
-
 static inline int neigh_parms_family(struct neigh_parms *p)
 {
 	return p->tbl->family;
diff --git a/include/net/neighbour_tables.h b/include/net/neighbour_tables.h
new file mode 100644
index 000000000000..bcffbe8f7601
--- /dev/null
+++ b/include/net/neighbour_tables.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NET_NEIGHBOUR_TABLES_H
+#define _NET_NEIGHBOUR_TABLES_H
+
+enum {
+	NEIGH_ARP_TABLE = 0,
+	NEIGH_ND_TABLE = 1,
+	NEIGH_NR_TABLES,
+	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
+};
+
+#endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index a379b80a22c5..6135ae2001d6 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -60,6 +60,25 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
+static struct hlist_head *neigh_get_dev_table(struct net_device *dev, int family)
+{
+	int i;
+
+	switch (family) {
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		fallthrough; /* to avoid panic by null-ptr-deref */
+	case AF_INET:
+		i = NEIGH_ARP_TABLE;
+		break;
+	case AF_INET6:
+		i = NEIGH_ND_TABLE;
+		break;
+	}
+
+	return &dev->neighbours[i];
+}
+
 /*
    Neighbour hash table buckets are protected with rwlock tbl->lock.
 
@@ -211,6 +230,7 @@ bool neigh_remove_one(struct neighbour *n)
 	write_lock(&n->lock);
 	if (refcount_read(&n->refcnt) == 1) {
 		hlist_del_rcu(&n->hash);
+		hlist_del_rcu(&n->dev_list);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -351,48 +371,42 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
 static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			    bool skip_perm)
 {
-	int i;
-	struct neigh_hash_table *nht;
-
-	nht = rcu_dereference_protected(tbl->nht,
-					lockdep_is_held(&tbl->lock));
+	struct hlist_head *dev_head;
+	struct hlist_node *tmp;
+	struct neighbour *n;
 
-	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct hlist_node *tmp;
-		struct neighbour *n;
+	dev_head = neigh_get_dev_table(dev, tbl->family);
 
-		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
-			if (dev && n->dev != dev)
-				continue;
-			if (skip_perm && n->nud_state & NUD_PERMANENT)
-				continue;
+	hlist_for_each_entry_safe(n, tmp, dev_head, dev_list) {
+		if (skip_perm && n->nud_state & NUD_PERMANENT)
+			continue;
 
-			hlist_del_rcu(&n->hash);
-			write_lock(&n->lock);
-			neigh_del_timer(n);
-			neigh_mark_dead(n);
-			if (refcount_read(&n->refcnt) != 1) {
-				/* The most unpleasant situation.
-				   We must destroy neighbour entry,
-				   but someone still uses it.
-
-				   The destroy will be delayed until
-				   the last user releases us, but
-				   we must kill timers etc. and move
-				   it to safe state.
-				 */
-				__skb_queue_purge(&n->arp_queue);
-				n->arp_queue_len_bytes = 0;
-				WRITE_ONCE(n->output, neigh_blackhole);
-				if (n->nud_state & NUD_VALID)
-					n->nud_state = NUD_NOARP;
-				else
-					n->nud_state = NUD_NONE;
-				neigh_dbg(2, "neigh %p is stray\n", n);
-			}
-			write_unlock(&n->lock);
-			neigh_cleanup_and_release(n);
+		hlist_del_rcu(&n->hash);
+		hlist_del_rcu(&n->dev_list);
+		write_lock(&n->lock);
+		neigh_del_timer(n);
+		neigh_mark_dead(n);
+		if (refcount_read(&n->refcnt) != 1) {
+			/* The most unpleasant situation.
+			 * We must destroy neighbour entry,
+			 * but someone still uses it.
+			 *
+			 * The destroy will be delayed until
+			 * the last user releases us, but
+			 * we must kill timers etc. and move
+			 * it to safe state.
+			 */
+			__skb_queue_purge(&n->arp_queue);
+			n->arp_queue_len_bytes = 0;
+			WRITE_ONCE(n->output, neigh_blackhole);
+			if (n->nud_state & NUD_VALID)
+				n->nud_state = NUD_NOARP;
+			else
+				n->nud_state = NUD_NONE;
+			neigh_dbg(2, "neigh %p is stray\n", n);
 		}
+		write_unlock(&n->lock);
+		neigh_cleanup_and_release(n);
 	}
 }
 
@@ -655,6 +669,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	if (want_ref)
 		neigh_hold(n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
+
+	hlist_add_head_rcu(&n->dev_list,
+			   neigh_get_dev_table(dev, tbl->family));
+
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -935,6 +953,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
 				hlist_del_rcu(&n->hash);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3054,6 +3073,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 			release = cb(n);
 			if (release) {
 				hlist_del_rcu(&n->hash);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 			}
 			write_unlock(&n->lock);
-- 
2.34.1


