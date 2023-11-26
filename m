Return-Path: <netdev+bounces-51126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A57F944F
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 17:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02933B20D4A
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5EBDDC2;
	Sun, 26 Nov 2023 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="dXyICEha"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2023.outbound.protection.outlook.com [40.92.46.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957CCFB
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 08:58:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=No9bv9FCzxipICgfgh95Ya7hLXtAFhYhVxxDRsUTQzjpLziuHrlTEKBgg0YaXoHkwFxc3KgBWDMooH2vu0xnXeldewstEkNtVMYOGROY+S8+hAWl4px+b0tU9Q4GVJwTihYwp5PKdeRIat8onyD388EcO4K/4sNuquaHSKlTIxjsibli5BcbRZzdWnKjn9mnyeSUh49lFaCp+q5XqBu/mCqatvITBj6vmNygqz9q+pJ8nrOeG3LOv0CKYHYn3rb4sBfokRtuLXNUbpJTVKa2LrCAJyIQoC4s/2rADoC6kPAJ67RaZOBQQEMR5Y16H37BF9tHRhb7oPb0rgti8iGltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5B+V89D7XbrdGH798MQC5xaAdTAJ3JjMNHQNhhoMo0=;
 b=M9K2NY3e7WFx3i9jMvWd0y/5u6AzA9R/I2BRXxqyjJ1+4v8Uo5OKuxVHxlpgphSAqFQHT2i7P/bBBW+GLGQ8FIX48SKCGk7jdt19QW8I3RzRsUPMd0F0EXn7buitxDoj6kCRYR6a2OGOIxIXfYQf+KhXxBzHHmcVWZMuZ/WD/ejnWV+4O5a64HzZ/B77lFzX4ORsEKqMESf3w8q1mnj6fPOwQKKvk5hcn6XpDnBKyw/x73e6/nqo+FpSCwC85w7o+Zk9i3C87QvHBvLQwUp9jeNO3TSZ5WnxaYzZwo/LtI3dl7VaeHeXmTqSGNn76xGbYEQVowxXgPm0PMlDGZO7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5B+V89D7XbrdGH798MQC5xaAdTAJ3JjMNHQNhhoMo0=;
 b=dXyICEhaXzZlzWcNkAzDI7ZdUSRuv6g/kY3vd4yZWWYstCyLdiilYGOWPteUN9PhMu978NWEnnKk3LWjuyujZz/z7PwWRc+vprP6fe5YKMM13Z7pRvDVOEFQ/5H04oKhpQe5/Dz1WlYpklXH0Dmn3/NIX6iVCe6gryn5HNOCHPi8GZ65nAvuZtnR1bs/yS3u3S8fpfSko0YEoQ6FWgaBObDeOgqGN+WF5KTTc8v4TT5PSuqx+p754aWOjauUZK4EmJLMZ/d8p/otfJxAr015VzbnwWzOTVSWUatwLq5ej/Fxd5eYRe0tnFLlrJ8Fxglu8FA5uRLD2FiurFjJT32Fug==
Received: from DM4P220MB0843.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:6f::15) by
 CH3P220MB1705.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1c5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.27; Sun, 26 Nov 2023 16:58:48 +0000
Received: from DM4P220MB0843.NAMP220.PROD.OUTLOOK.COM
 ([fe80::35a0:4243:48f:163a]) by DM4P220MB0843.NAMP220.PROD.OUTLOOK.COM
 ([fe80::35a0:4243:48f:163a%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 16:58:48 +0000
Message-ID:
 <DM4P220MB0843AC6F4426191B50320B01D2BEA@DM4P220MB0843.NAMP220.PROD.OUTLOOK.COM>
Subject: Re: [BUG] r8169: deadlock when NetworkManager brings link up
From: Ian Chen <free122448@hotmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Date: Mon, 27 Nov 2023 00:58:40 +0800
In-Reply-To: <da9ddec6-ab6d-4ab0-95a7-142af7f0786d@gmail.com>
References:
 <LV2P220MB08459B430FFD8830782201B4D2BFA@LV2P220MB0845.NAMP220.PROD.OUTLOOK.COM>
	 <da9ddec6-ab6d-4ab0-95a7-142af7f0786d@gmail.com>
Autocrypt: addr=free122448@hotmail.com; prefer-encrypt=mutual;
 keydata=mDMEXtBrbxYJKwYBBAHaRw8BAQdAa9gvMh14krPTOqHsW73dssLoBAYfuWEpKz7cKVuv8zO0MUlhbiBDaGVuIChkYXRhYmFzZTY0MTI4KSA8ZnJlZTEyMjQ0OEBob3RtYWlsLmNvbT6IlgQTFggAPhYhBE3O0V40bikjuTHW9xyidUa+24sBBQJe0GtvAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEByidUa+24sByXgBAIYklSutJ41f+6oqk+toGtRZ+7We0kLhn33X+Yxy3onFAP9SJwxJCGwaT4cU18KUgFmE0r1rED5HWmiKeBwWdCjaArg4BF7Qa28SCisGAQQBl1UBBQEBB0BmbIGmAxHZohxVw/4NKyrbBq6HAT13Y9RDHJv7jgVaNwMBCAeIfgQYFggAJhYhBE3O0V40bikjuTHW9xyidUa+24sBBQJe0GtvAhsMBQkJZgGAAAoJEByidUa+24sBnsUA/2Ktsgvi8U0eE2xme+89TaDQ3o4n6O7Ewsnf4j6eGdq4AP9ucLlz7H3TTHb1OYLpz1swgcqREn++72H5xG9XvYNuCQ==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-2E/A2tGxUzDOSpSlIgF/"
User-Agent: Evolution 3.50.1 
X-TMN:
 [UjuUFIA041GhqBAi5VajmHhexRz6rW8gXnwwxa2estTPZYXgergBIymQx5f2y5kgJmeqmHdmjc0=]
X-ClientProxiedBy: PH8PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::28) To DM4P220MB0843.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:6f::15)
X-Microsoft-Original-Message-ID:
 <fb067598861d14f6f1391c47d764069395c15fff.camel@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4P220MB0843:EE_|CH3P220MB1705:EE_
X-MS-Office365-Filtering-Correlation-Id: 46927b14-19ba-4ad5-985a-08dbeea0f515
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	77nsx3fhFsq6M522YLb8M28/+yk+XAjAxkwxxbcqyG1zDLNEUr32aUwBBIEHK+8zzAxDl89jpVCxu0uHtmOtC7vUQ1n0nJ0EXw1zbcZPlfB/My5+G0vqsNswp5ZRCrdzvgZ1zIOv54Bv37mlIiyCH5FP3RmZ6w1UhhICb6zSIn6U0zlh6B24H7pF5PpD2Zc/c9PaYKVotWvyk/twkPHtdOcdfN7iEVlXWlKUIhKF/NFj5Kw7Z7XnNLwNQPf5pRS8qwQadkf35pFVXdiBd3AeACSBnLyBwpXrsqUC1w2Df7tjF7GeN/PnlOD9FBDZzWLFKnk7wsEuDzctoVUD5E1aTC440hS6+bH0SDleB41gKMttgiQLR8PEaSjVZtPb623NQk01Kg8dUl+mRO+abksKaN0nMJhIf9FIn5YMBC/pAl4HiN7TqnKJ/pf/5MfT/xU1n+TEWukaadwfSrbrjYyKYG+N29dXddohc1cRuKBIS4XC/xk0cZa+cY80KUE9HnTPrOiI223omI5h6FHJFJ8RD+T46xbtQob+Q716i4BuP+oDR/WzFKA5/1dJj/Jo6JI1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3UvTVU2Rlcvc0JSc0NyK2JsVk53VnlyNGRnV3lrbmRZM3VEQ3lpa0VmcmdU?=
 =?utf-8?B?blU4VC9TQ3BDVXBNOTVxakZ1WFl3dVBTTlVMUW0ycmNuNk8rRS9DWWZaNVF6?=
 =?utf-8?B?NzV3a2RhVFdnWE5HRk15bExEQXZoeUFmWjVvV0NqUU9Nc2RscnB5Yk1SajVX?=
 =?utf-8?B?WkJFTTlWbSs3VnhRK1dJMkNyaEJlbDdORDByOHJNd0RmYkR5QmV1a1NOejdt?=
 =?utf-8?B?ZVllRXhLRHN0czJheS9mUU5iaXUvRG1hVzQrSUpSaDBHYkVaV0hrM1o5Mk9n?=
 =?utf-8?B?L3d0QWJqekgwRVpIb0dvWUcxeW80Rm52ak9rVG5VeFhINTdna3l2L3pXSjVV?=
 =?utf-8?B?S2RIT1FZbEc1S1hMaUllNFg2TXhVcGs2UzBiSFdTV083cFBlRE0wSVVLbDYy?=
 =?utf-8?B?dmR5dTVLN1AzdU1zRTROdkRyTlplSExUVlJteWovbDJGOGtlQnZ6eWJmWVNC?=
 =?utf-8?B?N0gyNk5NMHVTQXRpS2g4UlljNkY3RURJeWNVcVRCWXpSeHNkY2F1R2ZqVzNN?=
 =?utf-8?B?Q1FmWEkwbnZYaGY2Q0VHZ0tvV3FHcHNrRTUxZzRuV0pqYTRubGJrKzY3OHEx?=
 =?utf-8?B?L2lQN3piUW0ydlExYkxLUG52TUg1cTY3bGtsK3FUNXhOa3J2NURYYVhFYno1?=
 =?utf-8?B?b3VMT2ZRK3U5MzUzdnFBNm9rbVlnSjhtRWtSTGlLNUtsdktreWlsQmFJdW12?=
 =?utf-8?B?cVhwZXNvZ05zTmowOXBSQitLbzZZNWhqa3h4WUNralRIQWs3OFphckJYejRa?=
 =?utf-8?B?RWN2emZPNzdQdUx4MDY1M0FWUzdsMlJKeFBlQ3lydUNnaFgvcElQbzlnWTh6?=
 =?utf-8?B?cVdZNnVXY3ZhYVpWSXB5T0t4TUNFTS85SkVvRjVnalVzVUhnOXY3cmthNEsz?=
 =?utf-8?B?aG1qTlN6MkxERVhUODIwb1BpSlJDMXV0SEZCSE1oRkduZ1pMbU5nZnlTaWsx?=
 =?utf-8?B?dk9rY2R4NGgxcVhINmlZZzFCdWVhaFdYRzJzMTRma0J6eVJKWTBPRUlmTWIz?=
 =?utf-8?B?Wktka3grZS8yVUs5cGo0TS9YZWJlaGhjK2g1UlhlcEpaQnBKNTk0L3VvKzd3?=
 =?utf-8?B?aGl1YXVia3ArVDZabVdoVGlkbE9MbEI2MWRKL01IRW50am1OY2t4NWpXU3Q4?=
 =?utf-8?B?ZXFGdUo4U3hLTTF4dTNXK1lkVm9YenJJTUlNVTUwdEx6VXQ0UWhMUkQ2WHJV?=
 =?utf-8?B?RGFaSmlwb3g1QnRwV0RUQUZvMTQzTWhNRXFlcVpFT2ZaTzlpeDNBZ0Jndmxy?=
 =?utf-8?B?UWdVaHpkRysyUWk2RS9PNGRoZG5yZ0FDQXpGb0ZNUTJiblViQlpHZ25lYkpt?=
 =?utf-8?B?NjcvTFZ0VDV5RGZjanBpZytEbVJKM1FrRThzaTRqSUZRMUJzczJKT2VJOGtK?=
 =?utf-8?B?UnRiaU9JbERXVnBmVmg5bjJBS25HTFNrRlVROGlhcm5IMS83bW1vNmJ4WGEr?=
 =?utf-8?B?S2lEc2ZyODhpaytrc0lxTUsrK1lNOGlUcmNsekVFU2tiald2cUQxY2JLcnM2?=
 =?utf-8?B?Z1dsRVNva0pWUzA0NGs2UEdoQUQ3YnoxOGhhMVFTSkw3cVR0SFlnSWprNzF0?=
 =?utf-8?B?VllkUlpXTFJJOXZNalcrUGNSRXA2TVBRYThOV3lMOGplRTR3VjhSQWtydXFz?=
 =?utf-8?B?N1dEdE5GSDhaRGJvRkg0a3dtUlBhZFNYOFlCZUFtdWtSQnl5YWQrRlFsOGQ2?=
 =?utf-8?B?eHU1c3Zsbm1yTnBETi84VlE1aDdBa0JQTVpWYjZUUVZpaDFOQ2FGcWRJVUI5?=
 =?utf-8?Q?pAkqYhvkEtp/14esXU=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 46927b14-19ba-4ad5-985a-08dbeea0f515
X-MS-Exchange-CrossTenant-AuthSource: DM4P220MB0843.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 16:58:48.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3P220MB1705

--=-2E/A2tGxUzDOSpSlIgF/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2023-11-25 at 18:36 +0100, Heiner Kallweit wrote:
> Could you please test whether the following fixes the issue for you?
>=20
> ---
> =C2=A0drivers/net/ethernet/realtek/r8169_main.c | 7 +++++--
> =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
> b/drivers/net/ethernet/realtek/r8169_main.c
> index 0aed99a20..e32cc3279 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -575,6 +575,7 @@ struct rtl8169_tc_offsets {
> =C2=A0enum rtl_flag {
> =C2=A0	RTL_FLAG_TASK_ENABLED =3D 0,
> =C2=A0	RTL_FLAG_TASK_RESET_PENDING,
> +	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
> =C2=A0	RTL_FLAG_TASK_TX_TIMEOUT,
> =C2=A0	RTL_FLAG_MAX
> =C2=A0};
> @@ -4494,6 +4495,8 @@ static void rtl_task(struct work_struct *work)
> =C2=A0reset:
> =C2=A0		rtl_reset_work(tp);
> =C2=A0		netif_wake_queue(tp->dev);
> +	} else if
> (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags))
> {
> +		rtl_reset_work(tp);
> =C2=A0	}
> =C2=A0out_unlock:
> =C2=A0	rtnl_unlock();
> @@ -4527,7 +4530,7 @@ static void r8169_phylink_handler(struct
> net_device *ndev)
> =C2=A0	} else {
> =C2=A0		/* In few cases rx is broken after link-down
> otherwise */
> =C2=A0		if (rtl_is_8125(tp))
> -			rtl_reset_work(tp);
> +			rtl_schedule_task(tp,
> RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
> =C2=A0		pm_runtime_idle(d);
> =C2=A0	}
> =C2=A0
> @@ -4603,7 +4606,7 @@ static int rtl8169_close(struct net_device
> *dev)
> =C2=A0	rtl8169_down(tp);
> =C2=A0	rtl8169_rx_clear(tp);
> =C2=A0
> -	cancel_work_sync(&tp->wk.work);
> +	cancel_work(&tp->wk.work);
> =C2=A0
> =C2=A0	free_irq(tp->irq, tp);
> =C2=A0

I can confirm that this patch fixes the issue for me, thanks!

> Are you using a jumbo mtu?

Yes, I configured the network interface to use 9000 as the MTU.

--=-2E/A2tGxUzDOSpSlIgF/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRNztFeNG4pI7kx1vcconVGvtuLAQUCZWN5QQAKCRAconVGvtuL
AYYOAQCTQ3vn9y01KwnPnD70x9vEbYAWT+V1hdPnMuS4/ODaVQEAt9GyoMSKDbdO
Npt8Dq+ZN+95QnqV/WpodMylIwmIIA4=
=Lhhz
-----END PGP SIGNATURE-----

--=-2E/A2tGxUzDOSpSlIgF/--

