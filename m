Return-Path: <netdev+bounces-255696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MHYMR0IgGkq1wIAu9opvQ
	(envelope-from <netdev+bounces-255696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 03:12:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F14D7C7DA5
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 03:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5843B300107D
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 02:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11DC20010A;
	Mon,  2 Feb 2026 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dgWoad7X"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B3181334
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769998359; cv=fail; b=VjPd/faN1gJnMcIm3n50Hei+jVMRHjcro3tUNeGwnI7/6y+Q7MFtDXeOn1p7IHZRxhoO2Hy4KfgDnLCoDt5IRn6Q4CLjqLpryIlp+UC0f7VBY8CVYlvliK2vY3CJh2iB0sCxVWtiUO/weAPUqMBDiyek8ew5/OKhg4JJYLggdrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769998359; c=relaxed/simple;
	bh=/K2O/XffiM1JnuWr9MQYqQ1kg1lDdVjU33j68YK6CXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PyD3Gx2eKurYm+NM1zr7PMsALPalRz5u1EPrOb9j2pmuIPAEr3JtMlAf+EqF+RpLRs9DqjAFboKSptBM/5RWR9CHO5JibNxrE4L455qHwGehY6bxmyeWpFEs82RlIObnckRGunnHJHZqesTj5FfVb3BzScC65HeR8b8X0iRmoQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dgWoad7X; arc=fail smtp.client-ip=40.107.130.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wq+ZqFz9snXW9J9sx9VlCRZXy90I/LoZNmCsBLufASrwtaIPyGO+NRFq+judSQcW1HmfWqnmQlKS/mxgE2EZIqaIQtGE+c/eRG+45Ue9sNrMoLc/WmJk0jlhqtN1bmCxgVXrKIt+ME6SFXv9RSTsHSKJNFvkGSQcNCFhnvEjeU2UhpIcuyaFVzH7OqySjuqYWO0FulQDteQUva++msqNbra4EjfF0ZI8xRReTSZV6ufo/Ed1M2lYSpMKJVQIkFJnBeHplbARBtAU2Xleroji3Wm5eHeIeQZs8KU5IvRLf/MbrZ0YhypFphweI7DUgX8MOfgIa9g/kgmv2CwJyEN6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K2O/XffiM1JnuWr9MQYqQ1kg1lDdVjU33j68YK6CXI=;
 b=tezjIEoeVQf9IxbGDo6EEZl9aBAA4bw7BfYxz3cDdytm4kNng6I6u1el2xcyME/6yXpXSYA7SoJFLwPKsVkC6Odrd39l1ldApN8wihlSRoMH9Zps4q4woP89LVKX6VO2bifbdXftrf0okUIuXYV5W16pDw+vtyX2joq0x+3D5pr0DA77DUKnoNYLb+hy0Dgt418njtG3baH79rmFxIhYl5v0D2N+jo1t0/oo45f8cAig452reB9DSFsguPf9U5obSYIsDM+H/QLq7OcIzMuyUWR0YzrwWIroSr9mgzvr0BmKKe4o7/LNJOszzAMBZXGHwlWoRmlAiRDyCGxP2W57AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K2O/XffiM1JnuWr9MQYqQ1kg1lDdVjU33j68YK6CXI=;
 b=dgWoad7XoncjKEefzq+8mceBSm2Hv7yIYAHdfGojpAGW6RSQ5ncOqK0ykRJrc0qIiWgbCHzkPIxItZGlhmXRMet5UoyJ4HvExntaM2S4W2hhzn6pSEkGR14oEpKdfsQfXog/+jmj9WDTRex34k0BwDZnTtClSvNrVh5IT+hnzVLetjoIp2ZOmB5JkC5U4bfU/92RBdVbujNtNdDAgtVJTvfOCfC+tMiJ37jxXAla6hGcplmRHkUAAWzvGLs5BNJKLJ+ufrtH8TgZiA10qpXhn1M9DccErc8/PS+QQ+zkCFrojDGGwml88755BJ/ocWSqKxk5KhMXFFcMVSOy+IN5+Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10601.eurprd04.prod.outlook.com (2603:10a6:102:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Mon, 2 Feb
 2026 02:12:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Mon, 2 Feb 2026
 02:12:35 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net 4/4] net: enetc: Convert 16-bit register reads to
 32-bit for ENETC v4
Thread-Topic: [PATCH net 4/4] net: enetc: Convert 16-bit register reads to
 32-bit for ENETC v4
Thread-Index: AQHckfI4V0ujB7l2nU600KxnMacAtbVurtUw
Date: Mon, 2 Feb 2026 02:12:35 +0000
Message-ID:
 <PAXPR04MB851016775EDD86BE9AD60CE4889AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260130141035.272471-1-claudiu.manoil@nxp.com>
 <20260130141035.272471-5-claudiu.manoil@nxp.com>
In-Reply-To: <20260130141035.272471-5-claudiu.manoil@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10601:EE_
x-ms-office365-filtering-correlation-id: 15861f52-0dd0-4eb7-d8c3-08de62008813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q29iRDExQi9wbWlQbzlaSDZsbGpZU093WHhCZDNkWStRcnZub21NZnRuNzBZ?=
 =?utf-8?B?ZEFiVUp3dnQrcjVobzZncUU1RmhxcEFBcEFFK1E2TzNqaUxzMUpKNXlETGVv?=
 =?utf-8?B?cGpGNTVmZmx6N0J2bDJkS0NDb3lnVG5DSi9LWlg3dVNQV21VU0UwU0hNekVV?=
 =?utf-8?B?QlpzOVVRelBTWjNxUUZtb0d3RWpmcFpNc0xxOGtMKzdVZ0RxeG9yemMwSFIy?=
 =?utf-8?B?bGRxdVZaQVU0bWJCTFIyRHExUnNPdGlCSVBZY2RQTGlYREpXbXhpcHczUjdh?=
 =?utf-8?B?WFlYNmJzN3RkTzlianNXTEMvTkZRWDdYS3dyWm11YlNQVTNxcmNKdkJvMlFo?=
 =?utf-8?B?eStXMVpUaFp4anZNOHpjd0FlanVHZElMRUl1VVd1b0h1WUNqNDVYZkZWVWxw?=
 =?utf-8?B?WGJscWhVa2lFQk9oZlFxVFA1c3dXMXlXaTI2SGgvNG5PbXo4eUZYTk1CUlU1?=
 =?utf-8?B?bGR3K1FlZmVoYUh6aGRMR2tsM0Jqd3EvZXNacjlGK1haSjhOZm9OWE9UdGM0?=
 =?utf-8?B?czlJNnVMandEM1FUMXFWZUJuSTNUTUlzTStNUG5ZWk50Y0lCZ3JrSlByTDll?=
 =?utf-8?B?bTNwb0lsOG5hOFJvTnFWa0ZLaHA4TWVZZU5QSlNQM2NaY1dBK0ZQdzNNQkNZ?=
 =?utf-8?B?TXdaakVUSGN5MzNRQmYxSHFKbGM3WmZRSzBES241TnU3Uyt0ZEtYdE83OHpC?=
 =?utf-8?B?SnRZZ0RVbXY4WkhFNFpsOFVpdk8xZmJoT2hWYjg2RHZBaDFTLzdyNmMvUzlr?=
 =?utf-8?B?amhLSHhMZ3MwbVIreEd6SUVmUE4rOG1Va29pNlZpZmIvWnN5SVJteE15SzJt?=
 =?utf-8?B?Y1JGdUJFNHE4Q055U3FQMDVOb2FpVnJJTzIzWnN5THJEYVY1WTVCOWhIWTh3?=
 =?utf-8?B?S25ZTmtxelRPV25TWDdEbG1NbGRYWDNBaFVLTGRHb2VFZzM5TlFHOWs5amJm?=
 =?utf-8?B?RTZlRm9XWUUzWmcxcDFCTHJrNnBOUzJiaGMxaHZYemhlRzVLcE1rUTVYZmZt?=
 =?utf-8?B?SGo2c0w2T0xpME5KbFVNN3FLcDZQVzhyZkNUNUxUSHdTVmFYUXZrS1BycmpU?=
 =?utf-8?B?enZ2VlRLUVJKbWp5TVRHZkRRYWhUWmRrWDQ4UFBkbWxFVUtmVXp1enorWVFj?=
 =?utf-8?B?UzJNTkNLcjhMeWpZc0IvQnB2aEFSTjkyZVBleXFmbDVsSTlrb2Z2UmVlSlhH?=
 =?utf-8?B?Q0prWWRIRVV2aVVhY2cvd3JUZ1N5N1BwUUU0VlQycFFvSENRYWh1ck9XVWFm?=
 =?utf-8?B?QmtRR092azRPS1hxaUNWWVpreVFsMFRWMHVBN0FQZnFlK1YyZ2JadnpFTHVO?=
 =?utf-8?B?SjE3YmhTSDZ2aWljTllld3Y0SFhWU2dqeWlDcFIwL2lxbTV4VVRqQlJuWnh0?=
 =?utf-8?B?WFZZcDVqNWNsMVROc0hteTZLNkVWYmR5WXIwaVprbU9wZ0YxNjJqNWZ2KzI0?=
 =?utf-8?B?UVNqU1JmYnh2Zi9vSi9pWjl6OWE4VHM1NDczMVJDZk9NMzdJNEdpemFGaHUz?=
 =?utf-8?B?cjlEV3gwbTZBMXA4VFdLZExhMzlYMzg2WHJHNWdlaWY4bG1tSHNORXdEQWFW?=
 =?utf-8?B?Vm1oT0NuRjd4UGdrN2RsVmhrL1Q0UlQ5ZTBKYVh0bEl2TDVzblRDZ0dqY1dE?=
 =?utf-8?B?Z2VSdXJFSVRTNTJnM21wL3JCVTAzKzJNYmFJOEhXSks1WTcyY3A2UlYzbjRZ?=
 =?utf-8?B?MTNObnVqaFhEL1QzWktHd1JYMk1sYStUbjQxbFhqekp0Ym00enlraWRrNmh6?=
 =?utf-8?B?UzQwKzZoa01KYkxYY0ZkcWkxaTBXcyt1Q1VQbWZ3elFGOHV3eXdKM3dNT0RH?=
 =?utf-8?B?OHJ5a0U3dDJMWmFuWW1tV2FpN05IelZpdDRHMTIvL1d2aFkyRWZTbHNIWlZo?=
 =?utf-8?B?MTVyU3BSTURkN0s1a3dKajF4VXd3bFlzczZhOTJlaG1uejJJYmthM1NIMVFR?=
 =?utf-8?B?em0vYmpGa2JNUmg4UEZqR055aWp4TjVQUEZocDFsWU9mbkJneDRrS3pEZThk?=
 =?utf-8?B?UFRHR1p5M2dQMFRyUUFHakh3Lzd6K2lKaFRVWFQ3Tk5kYnI2Z0FGendKYU0r?=
 =?utf-8?B?elpIUGJnWlM0YWdNNGJXVWcwRmJ5bzEwMFZmSnc4YjQ5eHdLL0ZYQU1udmdG?=
 =?utf-8?B?VkdTbmtxekMzNGNWemxQTDlGejNxdVV2Wm1ISWJPUWpHRXM1Skl1WUVyc1Q4?=
 =?utf-8?Q?qRf1CeYU59Fl/2VBKqGNH/4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDVLRTRscXRXOUZBQmN5WitSNFhJdWRKc0dQUWxiQU9RV2dQY0FSeGhKZ1Fj?=
 =?utf-8?B?a0pSYUZFakw2YTN2YnQ1Rk1Jb1JiaTFPRlRrdDEzeDE5Uk40UUtzWXhKTDYr?=
 =?utf-8?B?ZDhRRG1RT2ltYjlrZVladDRXUXpvbkNCaG1uWDJqR2M4YmR5TkZhL0t1K0dl?=
 =?utf-8?B?b3hQZFUrOEh6RG0zUktTby8yc0t2K0JZV2ZBKzFrbnp4UVZVM1YxLzB2N2x5?=
 =?utf-8?B?ZWFpbkp0TUZVRkFuUm9mcW5mUmFYcktQRWFZZ09icjhkaXNlNW9jeTNDNGpU?=
 =?utf-8?B?ai9kRGV2VGY3MHBNT2hGM3IwRUt1K0cycVFjQUZUcWNIUkwzdmRJdk5xbVl3?=
 =?utf-8?B?d1lIOCtqM2ZBdEZpMlJ4bmh5SHlqQjRMOElRSmoxbUp0TzZSM3lIQk1sNnpX?=
 =?utf-8?B?bERGeGlkK2NaL1ZlOXZLck9keHcwNXdaYjVQZ2JFNUFKVnFCVlczcUNrNkdJ?=
 =?utf-8?B?M3F4d1A3QzgycndZM1VCMmNUcSs1RDFzR1c3NnM0aGRoaU9vaEZ4RGJFQjMr?=
 =?utf-8?B?WW96QjJlMlM3VThpQ0hiSDl6VWVXMWU2VEpXT0NOZHlkeEZrTFR2RnJxc1FT?=
 =?utf-8?B?amJqMG40b2I5cGIyWldlaC9YOW9OVWNNSGliN05XVTc1Qld1YkwvSlZZSDNS?=
 =?utf-8?B?R1Rzc250d2FLZGU4TmJVaW9oRUd4aC9JTWhzRjR2NjlzcTh5MHhsOEk4VVVH?=
 =?utf-8?B?TnAxU2tiZ0VORFFld0NrTm9LY1lOMjc2U2VvK1BRRjY2ZXI2U1Zma3NqbVI5?=
 =?utf-8?B?cThtSC9PNkRGaVhsMm9zVEZoNGJQaWU4STJYLzIrdXRFNWp6bXhQeDM1NFoy?=
 =?utf-8?B?MWllcS9CWDFjcmx6R3hNUDUwNTg1R1daWnZEWFgzWXk0dWR4NlhDQ0VpYlNC?=
 =?utf-8?B?L041RkVJbkpJYzlicmNoSy9ET0FBZWxsRXQvUmpOU1BMK1F4L1ZjNWNYZUts?=
 =?utf-8?B?N3RnK1Uzc3c5bGVQeDI3cDk1b2I2bFhFNmU1RlB0Tk9VSEtxbkR6dHRFdDd4?=
 =?utf-8?B?ZUN1d050SThsYkhkTXN5VHNyOG9wc1RyNEFOOUx2YTBOL08zMStWZ0MzTVhk?=
 =?utf-8?B?U0FSa1llZ1d4dXVzYkxzUnBMbHBDa1d5dUhMZWZtQlJMR0NXekNkLzhCUHVp?=
 =?utf-8?B?VFhGazM1VFRkS2FhRFQyUzI3cjdnYm81OUlqTUwxM2FhNkQ0bktnK1dCbkFv?=
 =?utf-8?B?UGlaWS8wRXNoWkxHZVZyVjNWbWxTU0FZa2pJL3NTSmhQTW03Q0pGcE5DdGJs?=
 =?utf-8?B?UFB4ZTEwNGJOVmwxeGFZdG5vWUl6Tk84RlM2Nm9wc2gxRFBadU5nbitCejZI?=
 =?utf-8?B?Tmx6TUwrMGpqZjk3clo3SFAvWHFpSDNRRllYVlRPd3Yxb1JCVG9aM0JEM2lv?=
 =?utf-8?B?UHZpUzRCbTJGSjlkVHV5UXgwWEt0SzZGeWFWNmtZajJyUUNwQlhQa0FmMkpT?=
 =?utf-8?B?a3pMT3dZS2IrUDZVbEZvOG1CL2VXNDd2TUkrTlVFYnhsUzl2TTRXWmZJeEMv?=
 =?utf-8?B?ZHV3MlpqWDVkaXF2bUFRZHJjYllydzhQQlRTVVVURzM5czJnS1k4ZmoyTTY4?=
 =?utf-8?B?NG9FUWpCWGdTNW1IS3pxOXlVWVJCYVVrQXRBQndRc24zRUs2ZXBQSW56RWJW?=
 =?utf-8?B?MnVoZmt4ZmRlTll3bVUwMHd2aysyU0dDL3dPeTBKQWhvOXBnbkkzYjF3YUlZ?=
 =?utf-8?B?WTh3WU9xaTlRTWJzVnZ3UnJRNGt2TmxtdzB1Ykp1dlU3ZW5QNmZTQzB1SkNv?=
 =?utf-8?B?ZHhqZk9yaGc0eXV3OWVIMFFEb3ZueUluSlFiblNhV2dlYTlaazk5UWc5NkZj?=
 =?utf-8?B?MTVKVG9DSVNzWWllNnc0NHhSczBiUFJiV2Q0WEFod2UvQWpHdk0wYzV1a3E0?=
 =?utf-8?B?NUlrVFp1eHMxaHNsVk1LZjlMUDd5N0gwcWU5NFhEWTRxQVRwQ2ptOHpxRVNu?=
 =?utf-8?B?dE1DUHJQb3lMRTBDeUgxVWl0aXNOUmhQOCtCb25ZbDBMYkZXSStBVlFpc29Z?=
 =?utf-8?B?a2I3RWxVVkJGT2pSMnU5THFjbFdmSGExcU54WGVoSHlwaGJrTWMwRC9zdUZ1?=
 =?utf-8?B?MEpoNEZjVXpNbFZMSThudXVtRGd4bjMrNHdyWXprUmpWVUZUQ3h4WldFNmE0?=
 =?utf-8?B?Z3lqa0M4dnQzeXhFanRWSnpMbGpPVjhMU1Q4NExEZ3dwWlY2c3M2ZVVCWU1D?=
 =?utf-8?B?cy9TMEw4R3hKMWQ2S3hicVpPTURHNzdiU3lLRWVqa0dZM0hTd3ZNSlRLN3Q3?=
 =?utf-8?B?M0hGWjJNRFJmTmhJU2lpaVNhQmVwUkR3dUFXNWhUdUs5UldYcTlrRUdrOHFv?=
 =?utf-8?Q?jVhTFKwgsvqmTWlvVV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15861f52-0dd0-4eb7-d8c3-08de62008813
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 02:12:35.4669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOsBt0aK1rM5cPIXT5ukIjMwV6elTj45wtBE12riqMcXSYOLFv28c1BqtppoeLaui0Lcl+AEZxqrooPHNB4Zjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10601
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255696-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F14D7C7DA5
X-Rspamd-Action: no action

PiBJdCBpcyBub3QgcmVjb21tZW5kZWQgdG8gYWNjZXNzIHRoZSAzMuKAkWJpdCByZWdpc3RlcnMg
b2YgdGhpcyBoYXJkd2FyZSBJUA0KPiB1c2luZyBsb3dlcuKAkXdpZHRoIGFjY2Vzc29ycyAoaS5l
LiAxNuKAkWJpdCksIGFuZCB0aGUgb25seSBleGNlcHRpb24gdG8NCj4gdGhpcyBydWxlIHdhcyBp
bnRyb2R1Y2VkIGluIHRoZSBpbml0aWFsIEVORVRDIHYxIGRyaXZlciBmb3IgdGhlIFBNQVIxDQo+
IHJlZ2lzdGVyLCB3aGljaCBob2xkcyB0aGUgbG93ZXIgMTYgYml0cyBvZiB0aGUgcHJpbWFyeSBN
QUMgYWRkcmVzcyBvZg0KPiBhbiBTSS4gTWVhbndoaWxlLCB0aGlzIGV4Y2VwdGlvbiBoYXMgYmVl
biByZXBsaWNhdGVkIGluIHRoZSB2NCBkcml2ZXINCj4gY29kZSBhcyB3ZWxsLg0KPiANCj4gU2lu
Y2UgTFMxMDI4ICh0aGUgb25seSBTb0Mgd2l0aCBFTkVUQyB2MSkgaXMgbm90IGFmZmVjdGVkIGJ5
IHRoaXMgaXNzdWUsDQo+IHRoZSBjdXJyZW50IHBhdGNoIGNvbnZlcnRzIHRoZSAxNuKAkWJpdCBy
ZWFkcyBmcm9tIFBNQVIxIHN0YXJ0aW5nIHdpdGgNCj4gRU5FVEMgdjQuDQo+IA0KPiBGaXhlczog
OTkxMDBkMGQ5OTIyICgibmV0OiBlbmV0YzogYWRkIHByZWxpbWluYXJ5IHN1cHBvcnQgZm9yIGku
TVg5NSBFTkVUQw0KPiBQRiIpDQo+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgTWFub2lsIDxjbGF1
ZGl1Lm1hbm9pbEBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54
cC5jb20+DQoNCg==

