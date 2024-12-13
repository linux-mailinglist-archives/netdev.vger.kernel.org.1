Return-Path: <netdev+bounces-151814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C7B9F10B9
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 16:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46C5161DB7
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187E71DFE08;
	Fri, 13 Dec 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="AuktoJSy"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E117B500
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103176; cv=fail; b=ZqV1EsIQSWOyb9hFQiNRd49Czc/nkHklhwQMhT/GWahMIoZU2EtL35BoOr/bQtunXmH1+p8t5ACtoAiF0jGnztCm8i9UjdvVbIv22TAjKcQi7vIgr4BAEmo7m1q4eTcn9yzqsQNaJ3RXNgfnqfum/BW4hYtewQj2OBEy7REGQUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103176; c=relaxed/simple;
	bh=IGHXXX6rP0DvcegjCZ+gN3052oChyizPoyQgfaXB1jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qp9KiKd2LKyMvp0O0ta2oLCqMepNsGn96GCxXMHiIfMDfndN8lpkSwv8M6Hl3d79UXNzDJIQyLiFHWNS9w8U+aTTAGv4Gs5vEtxP7E/DzL44gyHDJOS/KkiRqr8oLWTIcBcHSK2UW6TPtzmiMVMk3uvMdziHJY4nEVdPain0Vn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=AuktoJSy; arc=fail smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 32F9E244671
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:14:07 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03lp2237.outbound.protection.outlook.com [104.47.51.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 81DB3B00064;
	Fri, 13 Dec 2024 15:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDkmGe8waCwFGqRuS86pCq2IhsPACWilHgZxvzFWu46XHxe/aZ1jaKKbRc30IcDvN2dZQFq4xXq04BIr3eFmaq5r0mZtagQmq5EGlt3Wl2hL6cWD0z9aXnISUh+TKl5poirZD06vydtLRg8buLkVE4NG/mWazDhAdgdH6czVh8+9Ad1pxnK+P/ye/U38vA4OLCKBWNbSdDC6gH9vdEDyzLvP2QE5l7k71+e7iWNzwyBp4gkI6fBds5UEwwBCW5dQFqslYHjLPvbLEYjfrTcqose2lo0NxuhouUdffBYDtdm1Bz94q7KmcokfWnoQrDz+obfI9I2N6mZG9OhZ/ViJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwBTG7zKL4sL5SkjbSnbPnoaGp3lzcVWKE5Sb5+kYq0=;
 b=eeqHyTwK9egS/7neiCuc9BEriY2xczj60xoF3Gpz0ACCNlGwv0Ly5eogbK104UnnUlkUlOh2Deb08uImoD0wjqqdOyr82ViLPvGIGqI6B/go54iuyKw9DiatGoM74b8YgdjPbviBWbB++r7NEX368Ll3TJrARO54y7f2Y/IQON+ic/EemscQpHu75qo14+XqgWnXsFzFsIwN3AT63QSkHBZbIHRhm4VelPONNY1dReExYQ+Er929jR6c7nQnz6clRZrae8Xy7jJJpMjT7nn6T6sFwnHGRKDN87gVJ5/6s7uVESRdRaGGlkc8zq9pm6e/Q3vBQel+Xwlcra50GMo/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwBTG7zKL4sL5SkjbSnbPnoaGp3lzcVWKE5Sb5+kYq0=;
 b=AuktoJSyufFIuvgxgKOU/9x+VuuQqScea0JrXUXoBHNW1vZuJlFwVlhzPi6rVfABlGaWXr0rj/p9jYYoaFqxUns5mHSZHJcYi0ibBcAJ9y3eS2GKZgtOKMshJdUpU3+SbqvZQeSfLD03V1u64DCYyZl+kCukBM/d+5kcE5GosKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from AM0PR08MB5377.eurprd08.prod.outlook.com (2603:10a6:208:181::11)
 by PA4PR08MB6142.eurprd08.prod.outlook.com (2603:10a6:102:ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 15:13:55 +0000
Received: from AM0PR08MB5377.eurprd08.prod.outlook.com
 ([fe80::10ab:8d1e:a130:a8a8]) by AM0PR08MB5377.eurprd08.prod.outlook.com
 ([fe80::10ab:8d1e:a130:a8a8%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:13:55 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	gnaaman@drivenets.com,
	horms@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] Do not invoke addrconf_verify_rtnl unnecessarily
Date: Fri, 13 Dec 2024 15:13:42 +0000
Message-Id: <20241213151342.3614753-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c67e10cf-ae33-4974-93c6-aaa111171635@redhat.com>
References: <c67e10cf-ae33-4974-93c6-aaa111171635@redhat.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0208.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::28) To AM0PR08MB5377.eurprd08.prod.outlook.com
 (2603:10a6:208:181::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB5377:EE_|PA4PR08MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 81de28e8-628b-401e-5623-08dd1b88c28a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KIfmu/rIqTlBwa9mu8SKwjemehLCHZmDEMtwJG+S/g5jm9TgFPuYrlnbKefq?=
 =?us-ascii?Q?wOJdhkOF7+S91fXFMq+CAgANuP3xfeToRpSOy3XY2oNhGq25Uku7g1N6vWwo?=
 =?us-ascii?Q?V1dWUrz7DwWHxz4dMMvl6b9CLhG1ZQdHs959nRGg1Tu5zz9W955/qmpMhwwN?=
 =?us-ascii?Q?DxcXa1A6kE5HGMMHaWzrvc9vSp4RYXDdCYmpGrzA9NkvBq66Qz9v4O3xd8OL?=
 =?us-ascii?Q?KcN3iKPjqVYcqz3kMBXG9mI6+Ktvv7Bhm2my5Sd5JY7lUTsCKKtBO0wFck/H?=
 =?us-ascii?Q?rykbNEk1Li3GNixzt9X+HhuslXv4iIRTTxRshrQHjHmqywykKGQ7FqJkBw/x?=
 =?us-ascii?Q?/2y2WlhqEYb3chO3rsXxCJD1LxV2YqHCaIZog2NrranpOyEk8PoFxSyzTijS?=
 =?us-ascii?Q?XpvOwffXdITlYy/5lL7KSFUFFd6Riqe0Gt/b3iykTEvap2l1p68UcSeyp3Mt?=
 =?us-ascii?Q?OcS6iA2jmpqk3XndMbuAAWhPOIZE4f43zSJWpIAPUrLNtHMYQIxnwmk+12VM?=
 =?us-ascii?Q?HgMBUwW9STxZRXXiJ6Qx/CWjkH6ATZmhvgR66NDivZmnS8TmNMjKyMoQjRNH?=
 =?us-ascii?Q?3pUf8y5+/4vg7NsnDnvYdg5tTL8CH7VjBaJMhe0cbZ7HI5jgKoAjdgHZWmsr?=
 =?us-ascii?Q?h0b9smI5TzO5pf3R2ZGOUxipRiAvO4Njrl//ByBnVu/+qcSISYMkpiC90dHj?=
 =?us-ascii?Q?aLtiql/laQ9FC4zF+09dg09BjKFfYDo+w+Ivxzti/ufMM4u/VP2ev/LwvpUq?=
 =?us-ascii?Q?H75C6vPIJDUOVRKAMwQdgonRsPGbRVuYlKjCfWKPQryfTA1Ll39wjDuZ5Cvq?=
 =?us-ascii?Q?Qx65GEgmJ8ZSToFcw8emLXKMhZIkyasAy619U7+RIHmHih91bFR3EvLANs44?=
 =?us-ascii?Q?h89Ussw352BNCsQm9XoLB4jsAINh/f2cG3+W9SJgrUQy/hIC8tXepTDwu8fl?=
 =?us-ascii?Q?TA0zIcfOxLlZB7tfvqNjFAL01GoCfStzpY1g5XMSBisYI3nddrmt8zWR00sJ?=
 =?us-ascii?Q?bpZPsh//qBd8R6oKEdlwmdUfyR7PrPYkbq+xHS9UflNuwgmeNTZb5YTjI5U7?=
 =?us-ascii?Q?U11mtPlG6E7WpFMpLt0u3vBI7CMUVfxLNHLx20tToa8QgMxYE8VSKq3e0jlx?=
 =?us-ascii?Q?6viiB5T2P4ZJrticFPQI6sD+Vqo7khy8yivCoUac6dm48K3wRQSTu1liVWM0?=
 =?us-ascii?Q?u/c9WY1zxxN6wPVBqdpqH47uSMrebi9OUhzkRjtQ6prBUI+YAD0iCxZ58K7o?=
 =?us-ascii?Q?t0W7u+nix81RqLoc+KuZ/RgTCzK5yGymKMGhZB+3Lc8NGVi/ZJldBoVapQXY?=
 =?us-ascii?Q?7/SPuszKnTwxTf+xWGR5GqILBm3bGUzEyDTV8NmbqfwRemswFEvJBMcsLy1I?=
 =?us-ascii?Q?vIeUHvuMCsBkUBOG6U3d0WLIym4FKQl9HXaF+C0pq0gMRDkaxoSyACaXmx6Z?=
 =?us-ascii?Q?cOupBNaoZ0g2Wg/8RFbwzZ5YeOfRDn3B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5377.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GN2psppvjyx3oNZYFaBmPJIekdDdBwA7rRassJSogExEEup0mYx+C0lu4xqX?=
 =?us-ascii?Q?ssXtOhFK0ChxW1MEGcFQLEMeupK0GkwM3b1cC0yUxPhB413Bp861aqjf8Tgk?=
 =?us-ascii?Q?qm6QIeygZ7Z9d57YoSGeWI/E3bdh1WTvSFqJ8YTpps79SrnHoVxVLRszkuPh?=
 =?us-ascii?Q?r6R61Mtm8fauNRUj5SVPUsTTj3rpUIjKlYeGJ7zNH1HTEhum7j4QWbTor9IN?=
 =?us-ascii?Q?k4I2oe3mxExy4ycR/CQ8Cd42LaBLVlF3WiCW77+0cRYMzlUUa8uSGOnfkjGy?=
 =?us-ascii?Q?iEA67/nvz97blJTmHBjllrQpAn4IBoGzO9tZH+yLokvbKdE9fmcG9p52qRZT?=
 =?us-ascii?Q?bDbZSddeXDUeyCtGtGGhV14xA6pzLu7wq17qi7gxt7AGFcatWru0J4vsU+NN?=
 =?us-ascii?Q?5L8tQ0nvX/okALXT36NHfJjTaJUcxdzt57aSNyNhXo93H4PgG+wKvVvnSSwb?=
 =?us-ascii?Q?OJfGRx8OcUtpZgI4iggZnmIDbgFjZ8gXuxh8Aa3CIwoCBRBZFR/2eHFueS6C?=
 =?us-ascii?Q?OmqmR978LiV0Kx6B/it6kG5o+m2umItPwCjWbLyEIbEf/ybur5caHooU45mc?=
 =?us-ascii?Q?jXKkKz/eHQ4/MShPyJyMo66h1DXh9kCXMnSymXgL1UQ9Gmon2ifFibbmfmXN?=
 =?us-ascii?Q?pF9W+EwWrmyTDbRNgTkRrEAwd4NqwxLHCaJr+cW0beYrOD6ORAPEAUBXEuGX?=
 =?us-ascii?Q?m8eG22GJB2xVCgkhzMFq4Dx9utkhFHN1uYD+PtXJFc8z96X5D+NEBNshh/Xk?=
 =?us-ascii?Q?h8fl3Gs2TnRCveaIavi34m2en5obQxBq86Vb5yVwX55+E2c1tDGHIbV3a3Ft?=
 =?us-ascii?Q?7JN/BRtKK5d0iFZemRlj55JdIRYUyOyUbXpG7kvaClvPooLm6cFRTQdMDItn?=
 =?us-ascii?Q?S8CLkHyCb/KWr8h2bcvQFhgjmXevSFHYq24w58bAVI7OIknWF+4OXzh2Tb6r?=
 =?us-ascii?Q?8nRtwWU7EV5xYSN90KXWHOt2XW68kxDzHeWYcoSPCPPOmP8Hvr3f63cWNE5C?=
 =?us-ascii?Q?UPO4pe4F9OgW8iNFNs2Mgow/iZHVk56Hn7Fqu0SapHzN2B6wcI6+dAzLzuiI?=
 =?us-ascii?Q?0YSGR8OLwaQSlrSEyN0IvypmWS+NK68cV0zgjUFjySDFUaMpQ122EokW6PUp?=
 =?us-ascii?Q?JqAZb6Fb4LmAGPWlkf59WNhksLuiM4o8l6uhMviW/saSFz3xmSH7wkg0eO8T?=
 =?us-ascii?Q?weks/G/6Fp6v9TnLlkQKGyaIBUG/rjecL1WpqVn/Dleu3XE547IKExVAR/Qf?=
 =?us-ascii?Q?nTMUnrIcHiDUW2/3okRoH3GlsTVvt5gnF5k0Fbbemux2Y/4YsGazezb4uXR2?=
 =?us-ascii?Q?AraegVS4x4MT8xkhxh/DpgRKARyAXkjvs4Tc2NNubuj41b8xaiUUbzJNkXMv?=
 =?us-ascii?Q?jjwinUik7NUlMl9GBVbT+Fur0dNSwpHlzZXxVJKPaQ7esbNUyrO8vJYmtPRK?=
 =?us-ascii?Q?wiwo/29ZDssngzChAFZ23u8JHmC/TmHfm+pRguJa7NxRzNo3UqXt0hfB27dJ?=
 =?us-ascii?Q?juCgEjYsVQdeAfxYfVq9vel6863NSD8wK8mWYHWAsc8glpHCT2zbscPvSWOB?=
 =?us-ascii?Q?MrGtAmI0xserKn3iuFLZ5INrA8zXrT+c9CjCPMPD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RHzscsy2XMkY06duMAf3FInt9CQtok+zY+7YpDJGEQrVOI6s1VkkEWXAIv10SQE4WwAdGN9yR/z6vxGJp0G1xTmPmGwq0Ap07tYPvRIE0Wo+7gwMX8VwzzGgvr2mb7GceLylw56Id2+LY4ezJ2YvSH9XKqCvAVBP1XNsC6wlu2CloBtL0QeZg2C2176dg4QGhA1zh2eN/sZqoBvWAq9/zKDCKim69SZinxd8G4ZrFmCB99Allb0aLEXX985cztxI+K1RRKtPDc3B+JiNB7sZ3jpDHsXgpMzO3kr5ZwS2+tznLCoc3AGc2I8OZnXG4cjA5KL+rgzAJGMnx6RUmNhEBcE9HaI1IztUk1WIcBuknBUXfDDM5bwpBOON3x7MJcqSARb9OQ/2bODL1ihRghjWgvPLK1TVQNL+CmCwdWJHE3IS4cfXUtskOuLwYPqTkZmvBlmKWLTVnwEuiJRu6+OlpvxVNVtwWYHQpv8DLtWu8oS6LGfbwVPWJRJY6Bayp6O+IUG4K6m9t+ZDvbH71neRCMwTu1Hc0WHUPEMotubqwnhDgYmN8HNHrOaqnn83L0qOw0BOvKqhtMnjnRUWAPzG/P0akHyJVcXzwbOLrU4HUWlMK7wyJxl8vUfbaqzbkgK8
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81de28e8-628b-401e-5623-08dd1b88c28a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB5377.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:13:55.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZI53vVDstlY8zmWjlzNRYSmB95rM35DBMTeLSrJ1pQbnZT7oR6AYW3877wsJV/+GSoQlFMNX6kyUl3+elbUPAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6142
X-MDID: 1734102838-9Gftjcp6ZSib
X-MDID-O:
 eu1;fra;1734102838;9Gftjcp6ZSib;<gnaaman@drivenets.com>;489d0494e21146abff88c0d96984588f
X-PPE-TRUSTED: V=1;DIR=OUT;

> > If the address IS perishable, and IS the soonest-to-be-expired address,
> > calling or not-calling "verify" for a single address deletion is
> > equivalent in cost.
> 
> This last statement is not obvious to me, could you please expand the
> reasoning?

Sorry, it does seem a bit vague when I am re-reading it now.

What I meant is that calling addrconf_verify_rtnl when no upkeep needs to be
done has some cost K (in seconds) which is roughly a function of the
total amount of addresses.

Let's say you've configured some addresses, 4 of which are perishable:

	   |                
	T0-+- <---We are here
	   |                
	   |                
	T1-+- A <---Timer      
	   |                
	   |                
	   |                
	T2-+- B              
	   |                
	   |                
	   |                
	T3-+- C              
	   |                
	   |                
	   |                
	T4-+- D              
	   |                
	   |                
	   |                
	   v                

The timer is scheduled to expire in T1, because this is when address A
perishes.

If you delete a non-perishable address, running addrconf_verify_rtnl is
redundant, since it won't change the fact that the timer expires in T1.

If you delete A specifically, which is the cause of scheduling the timer
to T1, you have 2 options:

 1. Pay K now, in T0, to reschedule the timer to T2
 2. Pay nothing now, let the timer expire, pay the K in T1, and then reschedule

If we're talking about a deleting A, it seems equivalent in cost and result.
Either way, exactly one K is paid, and the time eventually gets rescheduled to T2.

If we're talking about deleting an arbitrary address, using option 2 is
better, since you do not lose functionaility, but you might be saving some
Ks. (If you deleted B, the timer won't be rescheduled anyway)

If we're talking about deleting multiple/many address in a short time,
option 2 is greatly preferable, since paying K for each address can get
costly as the hash-table grows.

> > 
> > But calling "verify" immediately will result in a performance hit when
> > deleting many addresses.
> 
> Since this is about (control plane) performances, please include the
> relevant test details (or even better, please add a small/fast self-test
> covering the use-case).

Is it common to add scale-test to selftests?
From my limited experience these tend to fail in automation for no good reason,
though I feel I may have misunderstood the text in parens.
I've added a link to the benchmark below.

Regarding the original test case:

We're developing a core-router and trying to scale-up to around 12K VLANs.
Considering GUA+LLA this means 24K address in this table.
In practice it's a bit more than that, due to other interfaces in the same
namespace.

This makes addrconf_verify_rtnl very very very expensive for us.
When initially setting the system up after boot, or when applying big
configuration changes,
adding addresses quickly slows down, as each added address has to pay
for its predecesors. (all of our addresses are static)

On the reverse, when the VLANs' parent link goes down, the VLANs
go down with it, causing us to pay for a lot of addrconf_verify_rtnl calls,
during which rtnl_lock is held for a single long stretch of time.

I've ran some perf on an upatched kernel to demonstrate it:

	https://github.com/gnaaman-dn/perf-addrconf-verify-rtnl

Turned out to be 13% of time when creating static addresses, and 18%
when flushing them.

(In our original bug the VLANs were deleted, it is just easier to perf
one iproute command if it's a flush)


> > @@ -3148,7 +3164,6 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
> >  			    (ifp->flags & IFA_F_MANAGETEMPADDR))
> >  				delete_tempaddrs(idev, ifp);
> >  
> > -			addrconf_verify_rtnl(net);
> 
> With an additional 'addrconf_perishable' check here protecting the (here
> removed) addrconf_verify_rtnl(), the patch will be IMHO much less prone
> to unintended side-effects.

I hope my explanation will be convincing that that is not needed.
(or just coherent enough to point out a mistake in my understanding)

If not, I will send V3 with this condition added, as in practice most
of our addresses are static.

Thank you for review,
Gilad

