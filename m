Return-Path: <netdev+bounces-138085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D969ABDB5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858AF1C22B1F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 05:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F066053E23;
	Wed, 23 Oct 2024 05:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="VSWOU/Vd"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192704A3E
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729660596; cv=fail; b=OrM7sse5CgwMZcHP9bTq4KRj+BRb0NZF3Hp4V46dX+HvsYWNzmOhPtmLsqqz1co2y03I3NenI/BDS59jqFtXCCjZCYeftSBcKGt/ndANzbqki2dbU57+E6Vkjsgdsh/Van8N67/BKbJovBoieDiqjJtF4tzuvWqcaHDEyuYMgl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729660596; c=relaxed/simple;
	bh=jAJ77AuWeFjC2DM4GszpBQCKcGfKSbJ6Q/Q1jxQamcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DkP7qSU+BL1iyAMsL4jWUD/Abgs7g5jFpopPUI/d/UMjb/cch4Z0vLFWWGtI1Yvo0AWbNQAHE5tAa56R5FxN3g7OtDMP68w6j4tbjPEzb4xM8FBgk+SxoK3ab3ifjg0luV8xSYcNgDhQDcfw8njvvMWTOd66RREq8vn91jQQA8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=VSWOU/Vd; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02lp2235.outbound.protection.outlook.com [104.47.11.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4EEB21C0064;
	Wed, 23 Oct 2024 05:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmjRp0pUcCoOafADrl77ddVXTh7EgSx3IGLm3UCcntkH5MJWFfm5SdtcLfafZlVyKnE5QAMSOAvpFpOxorB2I99nuTno/rGAYoeL2wO5nF0Cte4dGwKDvZ6YmarmlqXcKdgkG5+zJt3sXV3CaCbC5RQfDiR4DsT92JEXWJtZK+7JC0ETvN+AvRw35PRnMKt7CJLZYbC+URWf9+kd5hEf42f+X/S0Bub7cP/MqGKrMYcQIW602YIYJc8fDqrmrz7MogKLY3tAt/xPOz43qYC3MAxzHS8NrztjppxyYSncwJptYyhbQGFCo645NqmN8MGofBfth0jUSOtwtS/TY7w/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAJ77AuWeFjC2DM4GszpBQCKcGfKSbJ6Q/Q1jxQamcY=;
 b=Dl6OHbMzqJc9D5a53uEeUsb7ZD7M82WrtRpKEYW2Ip886onkQJYCh2QViqAcy6Os4RwAP/BrGLnUBrObA3sfcwE9DCV8gEylC1uDKCVpYhzuQgFdXuLEnQ06EG9F+VKQC03Kadw9HQRdrC8n3iDDqaH/AGvDQz1h+68rwrIxKsrdv+p6lLcCbuewh3YR9rC18I6JTLAScPotf5epvTGSYxxVsKGH9Fw1MIjZ0heGMydcGmAb6E+lV4Wg1qCl+rpUhztv7Cl27YmDEtzLqBcVE1L0hxuU6mdErzp3Vu77IFcTbsirev96uSUsD8+nPRDuYLt6sfpbOE61ZJXSU4zFkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAJ77AuWeFjC2DM4GszpBQCKcGfKSbJ6Q/Q1jxQamcY=;
 b=VSWOU/VdGSfeAkxjplAf9AYnguV6U+SBZGsewfJkEYIbV2BcWhXH/twUXsJJYAhc9Pxw3/1rLZ0kFSM0Bb3Y1TMDkFuB5Ju0waaA8Ajy/OI75Fp7+BdT4Cz+T5vzGkcUA/KE5KlZXb+Yr3a002ig1WegzdZOzRUhk9hDew1pAGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DB9PR08MB7721.eurprd08.prod.outlook.com (2603:10a6:10:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 05:16:30 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 05:16:30 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	gnaaman@drivenets.com,
	kuba@kernel.org,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v7 1/6] neighbour: Add hlist_node to struct neighbour
Date: Wed, 23 Oct 2024 05:16:23 +0000
Message-ID: <20241023051623.3514732-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CANn89iKGa9TWnGZJJZAL-B-onmJ7gRXQsWxy=7FvwJr+Y2DuCg@mail.gmail.com>
References: <CANn89iKGa9TWnGZJJZAL-B-onmJ7gRXQsWxy=7FvwJr+Y2DuCg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0684.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::17) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DB9PR08MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 449e470e-750c-47d3-8196-08dcf321da56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mbIGmpIUnZaGYPSS5Jq0Rol+5ZMPqhbENHIrGsmz6IPMpMpoWHTFNZ7MLVcO?=
 =?us-ascii?Q?Fe06i8MhLyxDMIAuFrYW+XUnXbOUiZsxN7TXsoDslO8WUkDp6atCgbNKR8Ro?=
 =?us-ascii?Q?LaxNQuiKlOcqym2CCj1DxwuiCCY5Nm/E9INw6K+GdQT1auTm2wIKkSwTladJ?=
 =?us-ascii?Q?oR1Lt23PSReaKSdCkw+f5aMSyDTr8cm5JSasm8x4O1kpSkerIrc+sq18i8mj?=
 =?us-ascii?Q?Sq4vwAkXRqngHm2HQxroscJMwI7n91Pq7Qx4K2HM43nDxzE1tB6WWiuVmrVW?=
 =?us-ascii?Q?T7PquhNXnyW6jDp6V9dkzXUaRmrBlNztxirpNGvLfhc63FKcs7e+lsXQ5cOP?=
 =?us-ascii?Q?o4WxWv0HxGFrFFMj9f8Q2niFprcefTaFOoIiWkda/nNgS0eCstasG8kYdszk?=
 =?us-ascii?Q?vnk/JGEehiiwiNk7lKUspmLQcmjKdfHoC6hua9hHWi3PLVeEb85WgRsfeXel?=
 =?us-ascii?Q?LxWw3QlZH9+H9scNRQaJbPe1JJx4d0/AnD6FKcCqgN3NHulFmCWgVKbhjX39?=
 =?us-ascii?Q?ynzkcARCRM3P1+e0FOXUHiGhEbd41R4hjqwTf8mH55niQk5+izAl3Jsotem7?=
 =?us-ascii?Q?Crse4s01Uw4e+XMrF16iFbBcdIxw/Xi0eQYiHHkDqhnyPu+PnYmDbVtsaJ1P?=
 =?us-ascii?Q?k6DkGjozJxP5u1frYHYj9sN9gjJB64rBvj9a3PjcJ+ZjPyinRjc1w38n3njT?=
 =?us-ascii?Q?JasOyxSNi046VRuZk12Q+hLLT4sTL0LxMMzzdMpMOTYWjz7/9L41hF5yurTJ?=
 =?us-ascii?Q?FMTxb66AGlvmIoTelAvTKeeLH5haMC1Snvl9wwXddRSW1KU6mPornNrctUkd?=
 =?us-ascii?Q?S8hm0SFGexYai4aY+HarRQuX4DXRaIk2ZuV4s49daNkyg/psAXUMZ9PKmd3e?=
 =?us-ascii?Q?3Ub1FoLdmNovS10Xehe5Fr1c8YMOpr2IFUcsXx1JdWfkjVskKNuVy8IeSL5b?=
 =?us-ascii?Q?gMLDhb2Sslsr78xNEZfocxGiyM9cB/HXazRINJv/eptCvFUt2vKIxAMCifhs?=
 =?us-ascii?Q?v9pCtB0qDL1IrQKrVjF90Yv9adFfPIsI59jbjF2Dpp1PdI87iyT7eNzmGOJD?=
 =?us-ascii?Q?7hAED+IgX2kDhuZav1rBPQulA50L2CYdoSovwFHdsEI70RnchQPtH2NVENIf?=
 =?us-ascii?Q?zvfIjSZvYdzAaa+miUl46avZxzOR4sl6k8tH3Kv6sbFhfpzDds/BANxj3sB+?=
 =?us-ascii?Q?ZB2cG0AKxnHIVCBryds6qTKdqFkFXcXPOr+5G6gFF+cgckmZtieCqVbrLCIn?=
 =?us-ascii?Q?7BbEEA0zQv6iqPA5jy3kGzDDUbBZum6lImZ9QFL69qlCCqgEIrZmr3ezeiWY?=
 =?us-ascii?Q?nUfR7vRLJKAvMA10FywLL42Z5x/+pyia174lPWXr0Dh0l5G/qb+OQU6EZMKy?=
 =?us-ascii?Q?vebNstc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E7DkvEPuAg+bwYptcyVS+Grw6Am6Znr4i3ta9Ceut0VlX89M55uZU1exZopA?=
 =?us-ascii?Q?A1wVfK/WQR01/mpyiMf+LLraeiFtzyPJdPT1RdLq84rlh54T9mogTMxme5lb?=
 =?us-ascii?Q?/N+YV+1MefutIEEgDcVWlRLdxAx+1e9LsEpM3n+B5DgzetWpt9bfMC0xwn3e?=
 =?us-ascii?Q?yC/B211LU8ZElzSiwSOubA9NFsXt1KlTQ2T68kdhsT56fqJnhkn4+3gi0IRt?=
 =?us-ascii?Q?6c/0YrSkaPG5EFETOpEr/AIy3UB46JbFan20zfptKNl0IPx9YPb0/i+DOEC8?=
 =?us-ascii?Q?q9y6CX0bLCCHJtzT1C+VFep8QxYQlC/IjOI56g4T7rr5QP+xFI+mvCO2b8XE?=
 =?us-ascii?Q?qEp10a2tS0r/wlmaqmFJBqTzG0Kq64tU0nqXJU81p5oRYhCcSBOiXMWjr/iv?=
 =?us-ascii?Q?gHugt0TDxrFqx9pd9ALvTAIglt24uJpJPRNFtUYvp2diY1vWQlksS5Kb1HvJ?=
 =?us-ascii?Q?odWkqguV8ctZ8XamQ9Qk5E+cv8BX8GcexSdpXuk11KKBGVYRzyky2PVYC3fp?=
 =?us-ascii?Q?knWCsQXeOEYsdNvLsd5uTXrvO7zk3xJKUcjaSYVpRZKOuS15J1bNiJWokI8u?=
 =?us-ascii?Q?qClpqDiL6SFc81mXmr+VEMmrs+U/AgWsJwjgAZy6+qmevI8lFMk88+5kNxkS?=
 =?us-ascii?Q?WXE1bZjSFRK2EcaSOd/NrxJZ65q77Lf+JFpwdxLEPEcF5A7nOHVdaucDCyRK?=
 =?us-ascii?Q?DUQpDSFKglDbNQErWLn3fYjTjcPkBQDQWhtIP475DNBxZzQEVDFdV73YlF61?=
 =?us-ascii?Q?7IJXmt3HjwkFMpZuKHEaR0A+y3D+fRP9dXWsRottEiPZC8MxzeUcyH8WC5eF?=
 =?us-ascii?Q?3p2jySffHQwMLhBcAgbt+UFMpt5fvWsczvfW4Nb6lDnhayQ6ihYz4Ur01Eik?=
 =?us-ascii?Q?rpIc6PcmjuBveWpCkD2yorhrM7WmSSgRBRYT0FosQMkLxwJQUGul4Z8F9KhJ?=
 =?us-ascii?Q?a3fsRTr+jqE90/S2M6GV1MzM6+GR0RKQIqrr01IRvdByiDKsUp/uqc3uH2wV?=
 =?us-ascii?Q?yePG6gga1rr3KnNfchZyeDmRCIenkrIt6BvUTeY113OqYFecsNqbCSoaYqMZ?=
 =?us-ascii?Q?NSDZJUsvjddJNnTYyPisvhgjrCOYEE3E4ma400RKdaQq2d2/BdQlnMWkD2cK?=
 =?us-ascii?Q?cA4ust3hk4IDBpbbj4p4XfE/MQsgyrdtgxBs2/kHnGaqWLk0gpHy/aJidNbd?=
 =?us-ascii?Q?umcrRzSRA8Fym1mYXSlvyGJjfYIkyVPpHNSoTX9EDbwx8ewuzT+5BX98o1/h?=
 =?us-ascii?Q?m4J053ExqDw8Stu4Tg3/vaerDzM8/uQnuZD8UkeN0SbO28fabwxWZc+YquMH?=
 =?us-ascii?Q?BZDTuzJHURvL3DVTIKkL5K6H0FZ52402Mu4tYDq6HutmSABMzCbZ0KV6qYNL?=
 =?us-ascii?Q?0RZL++Ej9GtQAueugMLHxuO3hb97wEAs7h0Xz3bLWn5ItdepbCsWQYpcNzaC?=
 =?us-ascii?Q?ZrIw+UlD1TfX1GnepVHGHvyPSMUgmroiNZD7Ju0lyKQ8OSuFE3a22ivqQ3kr?=
 =?us-ascii?Q?i5uqrSzRijeOy2SRGoTTJsjb2Fs8PSqC8rWQ+W6Op0T4ZYOLalRdWVFFmf2A?=
 =?us-ascii?Q?I068RcOlhLUAJJEObRRhm8hJ6L252uIsECFOrVrHEea0wxm7QhJN01pXgT3B?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fwkMp/nIiF1RoamBMNmFuAcPle39glrfOGhWMbHuIJIGddAbL3zYX3sIaxskFgD79UBiDWBFQa3omUIR6fmVbHo42jzdSdNFtiFg/QvN+nRp1Fo9av9SYT8dED4vr44PnJHlO2mlFPcKtae+UiOu2iqBf4nTsqdU+MTtn81HAjoz0bRFwjAfgGdZ7H5+lYdNwMfvQTO2oWLEQsg2PnVEmvkQk9u3JLrbTXhCusWPuDan0JRI2fn9WwyctZmeIA09ULhqtMz+PQFZdj8aa/v87P/OzASybf2xyJIHYEiqyIXlCjXlrBe5sudcMGXBHiAb46D/26zxqt9Dpdn7iM6Ebj6CVebSKn2hVMbJxOrb58PQwoW9sDjziaGmVXMq1DJyD9EOi2PpSFMYYRgFjj+jUhfCvaUMSeb6/l3qzthG4KrMkfofXjiAqnaL5wCD8CbNYSfk7bpABdlKPjz55XrLk8bLkqjpj9xTxx56m24dWYQkt8/8PgLAtjsj3rRKRiGnqDORG9V7/2VOjIBeFcHs3cgQua+vGbvlAB1WMjKF9gHUGyGy38P9xG4qVSPI1IUuiuiuB5rAP2Gyw4rNVKFH5134VgXnE0hj1CICitoE6OMzVyU8YAgDlHM9vpkleJgb
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449e470e-750c-47d3-8196-08dcf321da56
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 05:16:30.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ms1QzjoLwfonIvV4Kzj4ikXRAQmiXCZQadmv+3T5h9FR3D4Luufc7kWIvhkdtnIjpWo/xOBauurQfkepVN+PIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7721
X-MDID: 1729660593-olTLF5huz2ao
X-MDID-O:
 eu1;ams;1729660593;olTLF5huz2ao;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;


> Oh well, I strongly suggest we first switch to kvzalloc() and
> kvfree(), instead of copy/pasting old work arounds...

Hey, thank you for going over this.
I see you've posted a patch that changes this, I'll rebase and absorb it.

