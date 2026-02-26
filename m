Return-Path: <netdev+bounces-261483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MgeB4KCoGn/kQQAu9opvQ
	(envelope-from <netdev+bounces-261483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:27:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B5D1AC605
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6946358058A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC126423A8B;
	Thu, 26 Feb 2026 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l85JMgvF"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557D1A317D
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123421; cv=fail; b=OToV8YXzMK1QE/tEXfk/7FaLBEGiRS8tofKyoAJ/Fli63yp+V0fhCfLntGYuffuvcTfMQLUQQF+EgQIajj2qNRVL634vmktC8lTelC+2s9tzux1/+jOuPqhkDpySlEY5CVaFplRsC2F4TL7UPGnMz++DEfzzdrURs5Fazrj/o2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123421; c=relaxed/simple;
	bh=AYBbnvNxVkWmHk3UaU8YWLI+uDmKbTaTXIjgrBZgNwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b2pvsCLkgxDwRs0Pmju77eCKdxWrbZ0+bH+lg//gdbVB+NL8RJWMBS6Y1Js/SRJ2vqvSxQk9NJ/yQq/hZ/EzEZiGHOSHprccaGMi1mWKP1toy0r/RRvJCYTK6e3CwArYoD6wP+BqvxEe+JQ3wmHt+JqQ3HPk1mgUfFuG9g6D52U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l85JMgvF; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVfxNZDQiE9UkKe7x2bMWaU4THtCyPfnw7x0yzGCw1h1dGVodHsfLEoGTuY4ujQG8uY8E7xKg9aFy9S3g6GPfhoiCh7PLeJ14PqcwsN7F5pgNMnbNoHEgOUzg1FBOM840Yi9rpHI5YQmPSx3E+cnXYGKd8stgTImwO0vMLpjHjXhf55XtPn6hXOxgjimgRuoYlEzhfz+AgusxP5CaucpHu0i+/uxMOh5j3ggHqhBtVSfXN3eDcY/pYKMOwMEgaerab7djXdS3Jx/gnYoZ6l70JWyvStjxwAZ6z5nsCc3FgIdwBnBWkThnmdQyHXGN2Q1raa/Ena5T35jpN8Xi56vYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PSMK3uf+rNtWQG+DmCdWw9mnzJOkhbvuaBmkDcO/NA=;
 b=aMp1eMpx58JS7EoHa0GO4Rw9G4Qz1anLx08DMeDnEmznEVMnRM6IigIKish75Izz8z+yWGQZF79s7wPr1MyOLpyM52hp/u6RS86TdrQhOjtJeaMvl/SSqtKh+1MXnWeFI22NDWKMMP7OPKt/Z9AJOWQ0dp0V15KAKqUqqiE6WCtou8PX0vZ2bomLqsaZ44a6hvjpYqL8e46m/Qop8pxOiO0mlj30ujvWOPfO+lyg/5iMftoxcgQxVEoHQNB87QuIhwkY/wNEO3FTtxi+05u1mjVm0+pdQ1pLxcDgcFbCkZuRRwoD1ZX4Y1A+ctgmy13SfyKjWsJjsDmlagoKE0ADRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PSMK3uf+rNtWQG+DmCdWw9mnzJOkhbvuaBmkDcO/NA=;
 b=l85JMgvF2k/7CoK2NaYLjtc10ihAPlQCrV4Hl8PSoNtkJtK14bujVrgHnmi6vBq4bRNeWYnkYIPoGXeMZ7t+2jakZao3qZOmseeLtpiXUJQ8u0vt9DNJ6pOwK2/frbw/b3mK1TgcvdBnPTnzH5zD//iLgoDESj2s4/xMY6j9KGLY7JzGA0Rs8L2XooI2JxpkZYPE3H+FTsssNOTUiLib+vRLYgW9JZQ2Lt1pLE8JA4c+ptn7CeeReGOYMNOQ4v1I45uzHIH7fGQrHgkke3e70gKqo1+jLM4y1ABHnMELAXZxcLWWUBH8SQVg0X8QydjW76UhUJQAEGM6ZmpX6WUouw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7830.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 16:30:17 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 16:30:17 +0000
Date: Thu, 26 Feb 2026 18:30:14 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Patryk <pbiel7@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: 10G-QXGMII phy no autonegotiation on LS1028A
Message-ID: <20260226163014.byxmgisp3aluv6cf@skbuf>
References: <CA+DkFDaW_wJ5p9_P7pMpz-8iE6xeKkdF-MQcd2m2GcyVUE3S4Q@mail.gmail.com>
 <5bbafc78-9dbb-448f-a86e-c5e94618f2f8@lunn.ch>
 <20260226123647.kvv7zbu5ijkbn6jb@skbuf>
 <CA+DkFDZfJ4kD0=6O6XB5=azeFukiGxou4T0mM30qVktQCB8-1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+DkFDZfJ4kD0=6O6XB5=azeFukiGxou4T0mM30qVktQCB8-1w@mail.gmail.com>
X-ClientProxiedBy: VI1P195CA0060.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::49) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a272dea-fe6d-4ad8-dba7-08de755453c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	N2xA0CrjL22XQLCjJ3FQvStBQ6WpywN+NUxP+9N4+VrHKgsg+uxMwMqCWsqeitnPh+OmPn5Yv50Fep5QuwF1i9XVA1CBcCB8AWqeINh/Snoa9eE69VogedED5/pjxI/8RIb1mY+uQQWG/lU2gXo6dhpEAXEb1is0YJv7zI7HgqNp32KxhFa+xLwN3Z1Eg2QaCyVHCZD2XtNcX4NzuocY4Sj1q5/KfS45TpzXV48X6x5o7HowmV8L/zXHTZkuMNnkEo4sNWhrZS6/SYhRVDKfaFzQoD12pLhmWWARaQ7VF8zUQ7afB78YjTCU98XETEuqBJkp8WZqh2vwet9+JDtLNoztwXA0SzYJQ9VE4Uo3qIGpEwnoEiGvuuIhAR5+ff8JOxTnjGRlYYg1dpCcAhNudp+R3Y+zmzP5qd3IBe/W0Qxt+OmkOHFKPGZM8cvE8ritmK5Ncg9pGJyX0bhDFaTyUEVvItnEGJydNuLwmDTVE3/krxK90QKT+j+0716l80G+AvqdnOwWobkXzJ9qZzhC4DflGA5pxTTKPMeuvU1CYFFAy0X0l6vKOOdQdXj/a7m71lOr+iJaG8Rs9AMBOhCOPVUhccZS3sOl5wT9LWxNovImDL8HewRv3bFVG+7DZVXXsQjHs2OXNoYmHrbdhIm5FbELPnq0BYKOcidEy4GiuJ2mEOWqjTKuoEiMf6MXlGf1W6pizHXSg7A4RXw02fRyceKZ0Fttxn3iKBc2oS/Motk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW0yTXpCYjBvOHJBT3pCbmZVRkUzeUJiZ0lLZUUvdDdYYWZPcEtpb0Zxd2Y1?=
 =?utf-8?B?MGRtVWhiUGZRN0ZhWlRwUEZjaUlXMlVmUUxUeEJYVE40d0NvUkJ0RlZqU0sr?=
 =?utf-8?B?UTRqWWRLY1d6cFhzR0NGRHExRzF5MzJlRXMxZHZtWTI3UHcrS2RtTHFNaTVM?=
 =?utf-8?B?cUNQK3NFb0twc05ZU29OWVV0dDduQ0ducVBUcmdXREZKbDVKSmFhNHhpN05Q?=
 =?utf-8?B?ZlFROUlFdzhyS2VZWGJmZTN2OHJFVFlNRjYwMk92ejZnK0lkejBXV1NPano5?=
 =?utf-8?B?U0FnTTZMR29XMlp3OWlOWE5XUlhoTGZVdU1YeWVGU2tKdVFvazdxdHJCUWl4?=
 =?utf-8?B?OVIyWnMyM2tNb2M5UlRBZmE4WnpHeU03KzNyVm9DY3V4cDNBQW9UTCthQmN2?=
 =?utf-8?B?VzZlc0FjZEFNaWowSnVIQTBIbW9nV0xVUXVlU25QNUlpSUtnTnlHaFBWVlBj?=
 =?utf-8?B?ckxDVnZOTmZTRjRxWHRja2hxRHhrR2VRSTREcllORCtMRnR4bTRzZmtNcEJl?=
 =?utf-8?B?b0FjbnR6Sm5rK2lwTWkvN3JMTVpLRmFXam4xSEpRSUwzQmgxMkF6cDdVbk52?=
 =?utf-8?B?NzdiQ2FJUlNwR0oyeUd4c2JrYzRyTkJJcGtIYkFxNHI3RXlvMnR0L0ZGN1cy?=
 =?utf-8?B?NWpqeG9teXZmQS90Sk4wa0cwd2pVUDZzL2k4akJrWXRSQXpJcHVKTjJ3UWlV?=
 =?utf-8?B?WklwK0N4OXRIOHpWTDZsMzZrR3piNVo5djBldEdUY0JkNkYwdnhXZDk4VFdp?=
 =?utf-8?B?RnZFd0dIb0JaWG14b2drSVRiZ2N1U3RWVDVDQ0I2MzVqSWc3NnQ3WUpmTnFX?=
 =?utf-8?B?MUZsVUJTL0hxWlVneEdYR2NYWmtYV2h6bll0VE1JRjJ1QW9JYjJHam1Yd2Iz?=
 =?utf-8?B?ODc5aWV2NHpaUThhdTZ2S2I0cnk2MzR3ZXJHNk9hRjlYMndSMUJWYVgwUUpM?=
 =?utf-8?B?L2l3SDdGTk83NVFFeDJlaDBwUFBtNE1QcW8vUHlTQ0NrblFLVFhLaHMxVkZV?=
 =?utf-8?B?Q3Y1SVZIN3pJMDRGaWFiNThiVkEreWcxenBHWkJoY3hKMzZYa0lNTm1HTzdU?=
 =?utf-8?B?a0RtK2ZtZzhGSzlWa25SUmZJdWRZNENib3pHZjhPdWROSjUzdys3K1h0WGla?=
 =?utf-8?B?ZGtnaE9xMVNUWWoxdGppQTkrMDZCd3ZNQUhla1dZUWwxZ3VzTU1oUTdjc0cv?=
 =?utf-8?B?ejFRYllUZmgxMzZlc29qT2NFTzA5RDdxQ3Z1WUQvOVlhaTdEQlVZRUl0eW1n?=
 =?utf-8?B?Y1I2NFc5b3pGRkNteTE5d01ETXFGa0s2eFhybFEwRzRsaXFTeE11eWhTcTVY?=
 =?utf-8?B?b2lNcXV3eFNBQi9zL1c5M3liSlJPN053RFFUQ29GY2JoNFhYWFlmcllDN0Rw?=
 =?utf-8?B?ZTUrYXJCL1IxVkl4QTBUbTNVdnhCdE1sVDE0aVhzSWliaEFESHpoYjIwWC90?=
 =?utf-8?B?K2E1UWpXcDNSMlVDTW1SbklydWRIeTFjdzdtSTNpOC9POGNNd3lXZ3ZUc3NT?=
 =?utf-8?B?elZXVnhrNU93T1VRYU5QbFhtWEs1MWYzZFNOc0xTN1YrdlkvNzdEK2hTSDhV?=
 =?utf-8?B?TmlsenVGOVpwQTB6RGV4V0crZEVYaWxydjdPK2FFb05Pem5LWWZYTEVrUjAz?=
 =?utf-8?B?N252akRBamVUMHRWNU52ZjV3VnBBSnRkNmo5NGVWWmRncEUwb1pvSytKZmxm?=
 =?utf-8?B?N0F3KzZhNnVWQXB4K2VIUm5zZVFUaHF5eVRrWUJXU05qenRwQVNsVjNtMVpZ?=
 =?utf-8?B?b0FSWlVQbEp3Q0w1c2IrcHdGSHpTSnB3RGNPVlFtV2Y5SG1TeWZLZG1VcjR6?=
 =?utf-8?B?aG1RVWNNekJYa3ZVOTF2aTFRUTVvdDlqbnVoT2FwaGhLTmw2VWVXUXdPMjR1?=
 =?utf-8?B?OXBkU3Zjdmd6ak43Wk1vWnRKQUsrWGJrQVB1YVhHTUp6TFp6bkVJeDR5YVlJ?=
 =?utf-8?B?eFFqa1lDVDhJdDFuZkVnYkxXb0dXMGdIMHJQbHM2TENiT0tlcHEyTHhpU2Fn?=
 =?utf-8?B?Z3h4dmpvQ3JjZUx4eEg1WDdqRldKd04rbUNoWUxDN1hFYUt1RWR6QStrWXIy?=
 =?utf-8?B?TVhLdlJReWdaRDFNc1RMQnpYbVN2aG16MmRQclNGVUFOemZnUmwxbEJMVEN1?=
 =?utf-8?B?K3BzbzRmMkl2U0ZUQWRRbXlOTlpLMFUyb3pzNm1jNUhvSWtJaTM3TUlIdFkv?=
 =?utf-8?B?bnc1aVN0b2x6M1pjTVhta2E4NGxYRXhkb2tMeXZKV2FpMVRncmcrd3NQczNS?=
 =?utf-8?B?VytxMmFUb3JzZFBqNjBFb2ViU3ZkaFVPVjF2M01Kc08rUWNsYjZvcTlKZXdG?=
 =?utf-8?B?U0g4R2tQcnpZUWl0OVdienJkM0NmSG54bWpPY1lDKy9wTkVyN3NZR2xYd2VK?=
 =?utf-8?Q?zcT7uufMUQDfGkP9U7Wo7WyFPmlRpDG1sYUyOIabkFUvU?=
X-MS-Exchange-AntiSpam-MessageData-1: DLov5Shhqhw/K08WmIOGclouDKQYJTkwskA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a272dea-fe6d-4ad8-dba7-08de755453c5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:30:17.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EubCsJtMw2b3bU1/WjUOOSkDxagYdtcGVyGNsv1I/eokK9a2535nA7FJYR6lxSKsYaq+fxVV9chUEQVD1rNSdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7830
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261483-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 92B5D1AC605
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 05:09:59PM +0100, Patryk wrote:
> As for the phy... I'm aware that this isn't ideal for community
> visibility, but the PHY I'm working with has not been upstreamed yet
> and is currently under a strict NDA. Unfortunately, I cannot disclose
> the specific model at this stage. This is a constraint I'm bound by,
> as I'm working with vendor-supplied sources. I can however patch the
> vendor supplied sources adding modification you suggested so I guess
> the phy will be working as expected.

That's OK. If you can still test on your side with the PHY driver
implementing the inband caps API for both enabled and disabled, and
specify that you did that, I think we can operate on good faith in that
case. I may be able to hack up a PHY-less test rig to double check just
in case, and leave a Tested-by: tag. I can also do a regression test
with in-band autoneg enabled on AQR412C.

> > How do you wish we proceed? Is the above context enough for you to
> > submit patches, or do you need assistance?
> 
> Of course I’ll gladly prepare patches. Just to summarize what needs to be done:
> - in lynx_pcs_config_usxgmii the constraint about in-band only
> supported mode should be removed
> - if neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED then the vendor
> specific registers to enable and restart autoneg (similarly like in
> u-boot) should be configured
> - additionally it should also work without in-band-status defined in
> the device tree
> 
> Is this what you're suggesting? I'll proceed with this unless you have
> any objections.

Yep, sounds good. Don't forget to modify lynx_pcs_inband_caps() to make
PHY_INTERFACE_MODE_USXGMII and PHY_INTERFACE_MODE_10G_QXGMII to be
treated like the PHY_INTERFACE_MODE_1000BASEX family (aka report both
LINK_INBAND_DISABLE | LINK_INBAND_ENABLE).

Thanks!

