Return-Path: <netdev+bounces-124408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE869694FD
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D979B248AA
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2FB1CE71A;
	Tue,  3 Sep 2024 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="INn86HGQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94511A4E7F;
	Tue,  3 Sep 2024 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347781; cv=fail; b=Ekii1nXGT2NodR9eYJZ9d2971cHxyZ2bFEyUUdNc5fdvlBwCuS/BgKczduEkT+8zUrETgC3DmXw0XNXrrMlQC51OejHaby3jeoUi1OYkH4mNQ5vUGNUMQBFn05RrLZBNthzNDhxQRc/aptzPqQ2P4c+VC/8lZcjHlFwMm6CNqvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347781; c=relaxed/simple;
	bh=1IMoXx9XurW92ATEsgb38HSy5Siu/vkB477w6wyW+7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GvKUbGinHGfKzVw0dYuyJ3F8Nzqe5pkDmn76tbTgY8IRmcC5EOjwe2wo7dn7Vj/yzDYW8DUQBIf0fHCbzZHvcyb4p8J+GSMl6t2DtC26RLtIkgJZWZ1pxyI/BVRJI9ev9l2GtyBJP0c0CaIXSSYbKG/Zv+PYkAvaj5F68Yzs42k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=INn86HGQ; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4831bC7P015271;
	Tue, 3 Sep 2024 00:15:59 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41drxwrv15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 00:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abK72q/yWGdw7s2wq4RupGH29YlziOBPMcdq7aABGYz5Z3ZJO5iaSsyCdqg36YFvF5GwdSZrqjQvh9xlH5erxA89C2/izG/lvGqyjf+g7zvMVXmg1xE86TMGyHDrHykjhvSSqeGrUTy1RD3Ti52KPodIqxETdufMoR0bCG+SbdE8CI+XKRDtrQ3dDnsbhbhkQPLyqaBl6GL+WYMIFTURd7l/zKViNdpf3KxwyHHA5xvBURkNlfmM7+xFcVfV35NgHvLZbYanLxU3d3QCX5mtnI2hmhPlWrrgiw25rmU52R6cyGSGXWUNGb7f0uhaUpFHQj2yykjZjv+XKuBeN02S5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IMoXx9XurW92ATEsgb38HSy5Siu/vkB477w6wyW+7M=;
 b=pvz7ZaS90u58oKlUUWVpcO6ysGfWwnO9m+PGVgFnWBvlnA3NXKwOGaGAYYEXyZzFERNOODtWrE5DjsyG1H1lkcPecLa6+dp67iBPr4Mp9UVRlWItUTCCacxjf4W1oXnSLRkDdYbmuqIs2Cj9sl2qu6wMC0VXLN0q8I/yWY77XdCEL1XGPMu9NuX0AGuDmE+cebbco4GYNnmhj2jzPtQPxkB/Qv/4B687Xn3sDhfxDHhpOgsN6aAYDmyWZOg/nz0p39MCg80d0gIdc1OkGkD7PSxOYIMHC4O21iCXUZtTa8FWowOOU9tL99YRAfnIbHrfj4xgkQxlr8/p4MUEaqtIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IMoXx9XurW92ATEsgb38HSy5Siu/vkB477w6wyW+7M=;
 b=INn86HGQdzBrCjHs1RSLlACFa1M64F6VhNsr6mxa8eC0v5Xzdxi55dWXYemUFbvhBOMQ+cwHcaR/O+mtfBR1/UdYy3XD9I033AK6X43rcdABuxcz/m+ZB8LoGyAho7cngX/K3r2i6VsCJo0uVXeZ9Q1UW9cckIpJ2SBXfqH05i8=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by SN7PR18MB4046.namprd18.prod.outlook.com (2603:10b6:806:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:15:55 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:15:54 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Frank Sae <Frank.Sae@motor-comm.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuanlai.cui@motor-comm.com" <yuanlai.cui@motor-comm.com>,
        "hua.sun@motor-comm.com" <hua.sun@motor-comm.com>,
        "xiaoyong.li@motor-comm.com" <xiaoyong.li@motor-comm.com>,
        "suting.hu@motor-comm.com" <suting.hu@motor-comm.com>,
        "jie.han@motor-comm.com" <jie.han@motor-comm.com>
Subject: RE: [PATCH net-next v5 2/2] net: phy: Add driver for Motorcomm yt8821
 2.5G ethernet phy
Thread-Topic: [PATCH net-next v5 2/2] net: phy: Add driver for Motorcomm
 yt8821 2.5G ethernet phy
Thread-Index: AQHa/dEd+O1XAZjofEyk2qQy6CRnmg==
Date: Tue, 3 Sep 2024 07:15:53 +0000
Message-ID:
 <BY3PR18MB4707F518B01F4DC0DEC99014A0932@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240901083526.163784-1-Frank.Sae@motor-comm.com>
 <20240901083526.163784-3-Frank.Sae@motor-comm.com>
In-Reply-To: <20240901083526.163784-3-Frank.Sae@motor-comm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|SN7PR18MB4046:EE_
x-ms-office365-filtering-correlation-id: 97f8e5be-0cb5-412d-26bc-08dccbe83f9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1l6RHNaSU05cGZyRUt1aWhBZk5nT2JRb0JQM1lSLzdVQ0xBNXphdFl1YWNK?=
 =?utf-8?B?TEFOYUV1b1lVb1hPQzh6U1J5RUtyZy9OamJNYkFsaXBuYUFESDdwUGs3WFkv?=
 =?utf-8?B?K2U1czdLRWpIN2twZWhJb0FBeGRXNWg5UUU1UUp4SWZPNlBGT3ZDUEtZdlk2?=
 =?utf-8?B?V1ZMdkJWOTEzYVJ4ZnExZ2N4RWpYeEVGYi8zMDJVakNpdGFLbXprSEpWN1B4?=
 =?utf-8?B?QVdYZVI5SDFIOFc5STRNaUVuS3FndjlpRDY1dkJyL2lIODh1Y2huSmk1VVo3?=
 =?utf-8?B?MkhMSG0zNEVheWVYRkdPU0d0VE1XNGxqNHBUVHJ6RittK0Y2N3QwSDJsMGto?=
 =?utf-8?B?ZEpFM0VYcCtrV2FjRSs3ci9ISFFMNUE4bi9zTGQ5L3NDanFsRjlsa1ZSQWJ6?=
 =?utf-8?B?anJhSDJ6VDVNdFV3TmY1YWhLNkgzV0QxcFVleFBKWXhyUFY5b1h5UjkrMThp?=
 =?utf-8?B?ZXdubUhXVEdWU1p2dGRPMUNDdGJyZWxBdlQyZ2h4Tmg4S1p5Mkl5bDZZbkEy?=
 =?utf-8?B?TWNXZGtKK3dGRVJYTVVqWjhHRWtONHljOGxXZWw5elBmOGpydkg2N2ZjbFo4?=
 =?utf-8?B?UGpQV0Q2TTFSaGFKYktIdHpSYnJ4ZWtTUXkvQ05mdjg5NXlaNElzMmRSaldW?=
 =?utf-8?B?cVlMenQ0VjIxSys0V0xLcFluQTNRZzEzVkpySDNmTVJadld6ajdDajg0SXQ1?=
 =?utf-8?B?M0xKVDZHc0NSUVAxZkFXRWNqYVF5clcrS3loNWxrWldXSHdZdVBKYmM5MkpP?=
 =?utf-8?B?c3N0ZFNoRWtSUUZ5T2h2dmIvWUhlVVhkek0zMUs2S2dYZ2ZzYmhMOWJlcUNR?=
 =?utf-8?B?cjdVQkl4bWpnV1dLRkVsWGpkYXQ5Zld4RGRDUG9TcUZYSHFzcXRicTcvWnBR?=
 =?utf-8?B?UHZhUW9BWlZiMU1wLzhacTNZRXA1ODg3dy9SUXVCYmRHNWNuZEdGZUNNM2dR?=
 =?utf-8?B?eGkyWDhvcGxINkRKMEM2SHUxKzBDa2ZrY1U3T1QwSlJsZEJLMWtxT2MrU3Zx?=
 =?utf-8?B?ejhrNVBjVEZBeEpyclkrNFBHcCtoMGpWY3lYK0FKUTYrR2g5Nm1NMWpnVU1r?=
 =?utf-8?B?YTd3dG0wdVVvcHNOOXZYYnZ4Qk9xMUJ1UUlzdk91TVpreVFMeHdGZDNTUEpt?=
 =?utf-8?B?M0IvTk01WGRIM29Na2tZQ0ZGYzdxSHdYZ3QrcTQ1aUQ0MzFRZllReDlsaWVL?=
 =?utf-8?B?NUxuN1VYNm1RYTFrOHNXbzhlUU41THpjbXlZaG1jUVVqRFlaQXVuZ0lRRXZI?=
 =?utf-8?B?RFpVL1lCWWRaeUoyMlNiekFaWC92YjV1d0NCMklzRVdQcHBYdFBPRTREd0Ja?=
 =?utf-8?B?RTlEd0I1ZzdWMm90TDNIYWtJZkx3Wm1JN05VVWhPV1FyTy9CSXFKUnBGQjBs?=
 =?utf-8?B?TURaeUQvVHBuQVF1WHlLMnBHcmlaVjExcmV2SEpaOEhHYUVHUDdFcTJiN2xE?=
 =?utf-8?B?ZmxBcG94cDVTTzdhQkRGUnNFeHY5K01kbTN5cERrUGhudDV0MFhmWk1Eazl5?=
 =?utf-8?B?QU1Gem01WTBuYjl3QjFTQzJFNWYwV05LQy9YM08xQmV0Y25jTHJsQVFpd055?=
 =?utf-8?B?OEdoMkdaVkU2dGRWcG1uQ0VjdDN0bUtkeUFTblowWVNmUjF1ZDlEb3BPanRr?=
 =?utf-8?B?V1d2cG9EVkxVeEorVWJPUVpwL3VkZTVaUEV3dFVaSm9MaU93ZkNDQ00zMWJ0?=
 =?utf-8?B?d3Z3akZrbmNteUxRTlg1c0c2Qyt3Z0FMdk5kWWZUdURVUnRyNUVRR2lwTll4?=
 =?utf-8?B?czAvWjc4Y0NxeTY2M2l3OHJ6MytQZDkrTlk2bzQ1SFZyc0JydHZSZSszZ3Qz?=
 =?utf-8?Q?LvNsAu4XHHDRn3GFx6/rjX50pdOTBMxNKOs08=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFdXNzRCd0IzZHlpKzloMWF3ZFc1NkNDOFgrRDRMNTA4d2h4T3hvc2V0V09z?=
 =?utf-8?B?TzQvY3gzQ0xFWXlsdlpxT0VHZks2cnpucUpOV2Rxb3NlNm9ibllVVnNjWVZr?=
 =?utf-8?B?MllheGVqNVR1eEhZUWRPMGdBaGtVVnlaWndzbWxEM1FYSERZY2tmMGkxczl0?=
 =?utf-8?B?WEhxWjBmS1JlSXZPclQxM3VQa1RUNHNtRmhGeDZtU2gzOU1UejJoTUJURUc2?=
 =?utf-8?B?MnFMSFh6dXVjcXQvQ1NlbE8vSWJESkR3ZTJ1M3BrOUg4YUl5Yng0ckxjUE11?=
 =?utf-8?B?WGxKVmpTTnc3cG1wRHRzUmZTdkdlK0JHQnVJYXBmZ0JiWW9Gd0g3RG9LbnR5?=
 =?utf-8?B?czBmT09BVTBxUGtTTGpMeVpybU9IQXNnbGZxNFpvTG0vQ2xsUS9WZXB3Z01D?=
 =?utf-8?B?Vk9nMzUrTG9oUVBETDVsL1ZCam1qVEE1T3hUM2xJc2h2ZEpJa3NhdEpOcDFs?=
 =?utf-8?B?MVZlN25tR1pVWE82TkVKSzRLNGs5TC9jTmhCN0JFK25QTERJNU5FR1BTWVhZ?=
 =?utf-8?B?RHdJQThZNjhaS3k4QTVDK1RMdzUrU3VlM241NDJCc1c5eXlUUDlsTm5DcFdX?=
 =?utf-8?B?V1d2c09YVEVEMGF1UmhOR2ZzVE5teWFPY0xlbHVKTE5UajBZbzQrbzh1azZw?=
 =?utf-8?B?eHB1UE4yenVUSkdvdEdvZlp0aUpxbGJiOEMzVGZObW8zWkhhMzN1KysrakN6?=
 =?utf-8?B?a201WHNVdTJwZkc0K3BOVlhrVlV5Q0l5RWU0L1RqNTduU1FmUndzekE0MFZL?=
 =?utf-8?B?RmFKOEtSQVFaVDlsdDNEWTJoUkV2bnAzQTJHanZXZTFuZElvemlaYmR4d2xU?=
 =?utf-8?B?S1crYzk2RzdNaUMxaTJ6K3lKajdtLzBULzY4dmVCTEl0TWtpUXpRK1dTQ0hQ?=
 =?utf-8?B?bVdHa1kvRlQwQVpaSlAxdmh3MndlbnNrUUtOckNVZFNzK25uSjI5cTRLK2Rt?=
 =?utf-8?B?dXNYcDZYZU1RZGppeTIzbU1qOHBGdStrY0dIUWtXeXI3NHRKK1V0YTZhaHlW?=
 =?utf-8?B?OFV1RUd2ajIxczlsTWlHN241MUJNQUdBODhzMHdDNFd0SC84T2gxVlVWUXA2?=
 =?utf-8?B?OWRxUjcwbUp0WXpGQmExMnVPcG5JNmoxcXRHYUpOT2V5TnR6VHczU0ZzQmkx?=
 =?utf-8?B?ajRkQ0x2U3JNUmMzNldOMTMzNHBVcjg3OFVOMzhaVW0yTXcvTVE3NjJRYjFm?=
 =?utf-8?B?dHFyWml6eGtPRzI3Z3AzbFNieUpwSC9vVTZqR1F5ZytWWlVGeTVZNTNiMnRS?=
 =?utf-8?B?Y1VwVlhFem84SFJBb01XSjZ0QnR5emZGYmxNMkw3YnZtaGVSdGhxZlg2REs4?=
 =?utf-8?B?K1dSTXJsNFRxUDdNMjBlUHdNVzV4NjlsZStTbnA0aHRWMXNMQlJzdm9oSW91?=
 =?utf-8?B?d2w3ckpDaEhpSkRLaVRnOUZNTmVlYjhjbE1uQmp2N28ycUdOSzFtMmRpWUlB?=
 =?utf-8?B?ZzJ0U0xSRktpRUFpZ09TWDlvcjdNbEQ4bWpiWkdyR2V4Vi9mSzRQbVY2cVVP?=
 =?utf-8?B?WDYwdGJIY1ZWVkRQaTdjNUJubHYvMjkzTlpnTjFMTHNZbkdEQ1dMYXM5YXJz?=
 =?utf-8?B?NmhZQmp2L3JVQVRjcUxFZThoaENmQlQ5R0VoaUgxUHA3OCsveW51QlduVHJY?=
 =?utf-8?B?OVRxZitZaVNEMUlzQVQyU2xteXZyYXZaVmg0SEhWbzEyR3ZVZFRSVmtQVWJx?=
 =?utf-8?B?eloxenlaQ3RiVkkwZmhPS3R1c3A5M0ZxS0x1aUc0bWdVeUxNaHg5bTdGZzNk?=
 =?utf-8?B?OFltZ0ZTakJReTUxQ3RqOGgzSmJOUXIrcXpuY3lDenh3RlBremVMYU1PYW1s?=
 =?utf-8?B?K1ROTktqb3kxODd6bU1PUVQ1VDExQ0tobnh1dFFkTUlwY3ZLS3Rqb2dVZDMz?=
 =?utf-8?B?cVNWZFhOQ2VkeU5UNytQY0JTY2RDN0ZoeHl4c1g1TDljZjFzb240MUFtcHhr?=
 =?utf-8?B?ekpZNENUYVdCdFE3R3NLcE9QTE5GSS8rRkpjRk4xa3lZdU9BVXJIVEFVOVdj?=
 =?utf-8?B?Y3ViendtS1lEdFNCU2IzY3dXRVF6UnJuYk0zTEl5RFRJQ0VRZytyZzZUV3lS?=
 =?utf-8?B?K0E1c2djQ1I4aVJzRW9XSFc2OU5LZUVIVjY0cEp2aHpBbzR4NWg3L0N5WUdw?=
 =?utf-8?Q?BAbceisN2iFjKIeuszsYziCTa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f8e5be-0cb5-412d-26bc-08dccbe83f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 07:15:53.9648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSaf20JRJgNtcLlER0UakJtU4mIC+kHmdAGSwKB0ynBbg6HY1SF1WTSUrq5U6Em+CQyKBqZgc3Oo+g9PztcZhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4046
X-Proofpoint-ORIG-GUID: el3Rk8xhMSybzkmR-6puzBw7X6ziTKP4
X-Proofpoint-GUID: el3Rk8xhMSybzkmR-6puzBw7X6ziTKP4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-02_01,2024-09-02_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIFNhZSA8RnJhbmsu
U2FlQG1vdG9yLWNvbW0uY29tPg0KPiBTZW50OiBTdW5kYXksIFNlcHRlbWJlciAxLCAyMDI0IDI6
MDUgUE0NCj4gVG86IEZyYW5rLlNhZUBtb3Rvci1jb21tLmNvbTsgYW5kcmV3QGx1bm4uY2g7IGhr
YWxsd2VpdDFAZ21haWwuY29tOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyBsaW51eEBhcm1s
aW51eC5vcmcudWsNCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IHl1YW5sYWkuY3VpQG1vdG9yLWNvbW0uY29tOyBodWEuc3VuQG1v
dG9yLWNvbW0uY29tOw0KPiB4aWFveW9uZy5saUBtb3Rvci1jb21tLmNvbTsgc3V0aW5nLmh1QG1v
dG9yLWNvbW0uY29tOw0KPiBqaWUuaGFuQG1vdG9yLWNvbW0uY29tDQo+IFN1YmplY3Q6IFtQQVRD
SCBuZXQtbmV4dCB2NSAyLzJdIG5ldDogcGh5OiBBZGQgZHJpdmVyIGZvcg0KPiBNb3RvcmNvbW0g
eXQ4ODIxIDIuNUcgZXRoZXJuZXQgcGh5DQo+IA0KPiBBZGQgYSBkcml2ZXIgZm9yIHRoZSBtb3Rv
cmNvbW0geXQ4ODIxIDIu4oCKNUcgZXRoZXJuZXQgcGh5LiBWZXJpZmllZCB0aGUNCj4gZHJpdmVy
IG9uIEJQSS1SMyh3aXRoIE1lZGlhVGVrIE1UNzk4NihGaWxvZ2ljIDgzMCkgU29DKSBkZXZlbG9w
bWVudA0KPiBib2FyZCwgd2hpY2ggaXMgZGV2ZWxvcGVkIGJ5IEd1YW5nZG9uZyBCaXBhaSBUZWNo
bm9sb2d5IENvLuKAiiwgTHRkLuKAii4geXQ4ODIxDQo+IDIu4oCKNUcgZXRoZXJuZXQgcGh5IHdv
cmtzIGluIEFVVE9fQlgyNTAwX1NHTUlJIA0KPiBBZGQgYSBkcml2ZXIgZm9yIHRoZSBtb3RvcmNv
bW0geXQ4ODIxIDIuNUcgZXRoZXJuZXQgcGh5LiBWZXJpZmllZCB0aGUgZHJpdmVyDQo+IG9uIEJQ
SS1SMyh3aXRoIE1lZGlhVGVrIE1UNzk4NihGaWxvZ2ljIDgzMCkgU29DKSBkZXZlbG9wbWVudCBi
b2FyZCwNCj4gd2hpY2ggaXMgZGV2ZWxvcGVkIGJ5IEd1YW5nZG9uZyBCaXBhaSBUZWNobm9sb2d5
IENvLiwgTHRkLi4NCj4gDQo+IHl0ODgyMSAyLjVHIGV0aGVybmV0IHBoeSB3b3JrcyBpbiBBVVRP
X0JYMjUwMF9TR01JSSBvciBGT1JDRV9CWDI1MDANCj4gaW50ZXJmYWNlLCBzdXBwb3J0cyAyLjVH
LzEwMDBNLzEwME0vMTBNIHNwZWVkcywgYW5kIHdvbChtYWdpYyBwYWNrYWdlKS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEZyYW5rIFNhZSA8RnJhbmsuU2FlQG1vdG9yLWNvbW0uY29tPg0KPiAtLS0N
Cj4gdjU6DQo+ICAgLSBhZGRlZCBkZWJ1ZyBsb2cgd2hlbiBwaHlfc2VsZWN0X3BhZ2UoKSByZXR1
cm5zIGFuIGVycm9yLg0KPiB2NDoNCj4gICAtIHJlbW92ZWQgYWxsIHRoZXNlIHBvaW50bGVzcyBn
b3RvIGVycl9yZXN0b3JlX3BhZ2U7DQo+IHYzOg0KPiAgIC0gdXNlZCBleGlzdGluZyBBUEkgZ2Vu
cGh5X2M0NV9wbWFfcmVhZF9leHRfYWJpbGl0aWVzKCkgdG8gbWFrZSBzb3VyY2UNCj4gICAgIGNv
ZGUgbW9yZSBjb25jaXNlIGluIHl0ODgyMV9nZXRfZmVhdHVyZXMoKS4NCj4gICAtIHVzZWQgZXhp
c3RpbmcgQVBJIGdlbnBoeV9jNDVfcmVhZF9scGEoKSB0byBtYWtlIHNvdXJjZSBjb2RlIG1vcmUN
Cj4gICAgIGNvbmNpc2UgaW4geXQ4ODIxX3JlYWRfc3RhdHVzKCkuDQo+ICAgLSB1cGRhdGVkIHRv
IHJldHVybiB5dDg1MjFfYW5lZ19kb25lX3BhZ2VkKCkgaW4geXQ4ODIxX2FuZWdfZG9uZSgpOw0K
PiAgIC0gbW92ZWQgX19zZXRfYml0KFBIWV9JTlRFUkZBQ0VfTU9ERV8yNTAwQkFTRVgsDQo+ICAg
ICBwaHlkZXYtPnBvc3NpYmxlX2ludGVyZmFjZXMpOyBvdXQgb2YgdGhlc2UgaWYoKSBzdGF0ZW1l
bnRzLg0KPiB2MjoNCj4gICAtIHJlbW92ZWQgbW90b3Jjb21tLGNoaXAtbW9kZSBwcm9wZXJ0eSBp
biBEVC4NCj4gICAtIG1vZGlmaWVkIHRoZSBtYWdpYyBudW1iZXJzIG9mIF9TRVRUSU5HIG1hY3Jv
Lg0KPiAgIC0gYWRkZWQgIjoiIGFmdGVyIHJldHVybnMgaW4gZnVuY3Rpb24ncyBET0MuDQo+ICAg
LSB1cGRhdGVkIFlUUEhZX1NTUl9TUEVFRF8yNTAwTSB2YWwgZnJvbSAweDQgKCgweDAgPDwgMTQp
IHwgQklUKDkpKS4NCj4gICAtIHl0ODgyMWdlbl9pbml0X3BhZ2VkKHBoeWRldiwgWVQ4NTIxX1JT
U1JfRklCRVJfU1BBQ0UpIGFuZA0KPiAgICAgeXQ4ODIxZ2VuX2luaXRfcGFnZWQocGh5ZGV2LCBZ
VDg1MjFfUlNTUl9VVFBfU1BBQ0UpIHVwZGF0ZWQgdG8NCj4gICAgIHl0ODgyMV9zZXJkZXNfaW5p
dCgpIGFuZCB5dDg4MjFfdXRwX2luaXQoKS4NCj4gICAtIHJlbW92ZWQgcGh5ZGV2LT5pcnEgPSBQ
SFlfUE9MTDsgaW4geXQ4ODIxX2NvbmZpZ19pbml0KCkuDQo+ICAgLSBpbnN0ZWFkIG9mIHBoeWRl
dl9pbmZvKCksIHBoeWRldl9kYmcoKSB1c2VkIGluIHl0ODgyMV9yZWFkX3N0YXR1cygpLg0KPiAg
IC0gaW5zdGVhZCBvZiBfX2Fzc2lnbl9iaXQoKSwgX19zZXRfYml0KCkgdXNlZC4NCj4gdjE6DQo+
ICAgLSBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtDQo+
IDNBX19sb3JlLmtlcm5lbC5vcmdfbmV0ZGV2XzIwMjQwNzI3MDkxOTA2LjExMDg1ODgtMkQxLTJE
RnJhbmsuU2FlLQ0KPiA0MG1vdG9yLQ0KPiAyRGNvbW0uY29tXyZkPUR3SURBZyZjPW5LaldlYzJi
NlIwbU95UGF6N3h0ZlEmcj1jM01zZ3JSLVUtDQo+IEhGaG1GZDZSNE1XUlpHLThRZWlrSm41UGtq
cU1UcEJTZyZtPWswWnNFMWktDQo+IFh1MHBvbmwzRVJSZ3dhRjBPdU1COURpWXJxbXpWVVRsWk13
bUlwdk1ld25nOS0NCj4gVmNBc1JEZE1rNCZzPURVM1h3SUVyR2NJaER5Ujk3bDBIRlZ0Y2luSFlj
VGxiQ2pkakhOelJVZWcmZT0NCj4gICAtIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNv
bS92Mi91cmw/dT1odHRwcy0NCj4gM0FfX2xvcmUua2VybmVsLm9yZ19uZXRkZXZfMjAyNDA3Mjcw
OTIwMDkuMTEwODY0MC0yRDEtMkRGcmFuay5TYWUtDQo+IDQwbW90b3ItDQo+IDJEY29tbS5jb21f
JmQ9RHdJREFnJmM9bktqV2VjMmI2UjBtT3lQYXo3eHRmUSZyPWMzTXNnclItVS0NCj4gSEZobUZk
NlI0TVdSWkctOFFlaWtKbjVQa2pxTVRwQlNnJm09azBac0UxaS0NCj4gWHUwcG9ubDNFUlJnd2FG
ME91TUI5RGlZcnFtelZVVGxaTXdtSXB2TWV3bmc5LQ0KPiBWY0FzUkRkTWs0JnM9dm13cVcyaVV2
SGpQRVhHeHRVZmEtTmRDUVZXM2lCbXFiOHJxRU82WDJjSSZlPQ0KPiAgIC0gaHR0cHM6Ly91cmxk
ZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fbG9yZS5rZXJuZWwu
b3JnX25ldGRldl8yMDI0MDcyNzA5MjAzMS4xMTA4NjkwLTJEMS0yREZyYW5rLlNhZS0NCj4gNDBt
b3Rvci0NCj4gMkRjb21tLmNvbV8mZD1Ed0lEQWcmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9
YzNNc2dyUi1VLQ0KPiBIRmhtRmQ2UjRNV1JaRy04UWVpa0puNVBranFNVHBCU2cmbT1rMFpzRTFp
LQ0KPiBYdTBwb25sM0VSUmd3YUYwT3VNQjlEaVlycW16VlVUbFpNd21JcHZNZXduZzktDQo+IFZj
QXNSRGRNazQmcz1wSjAwWUZwNURJTHNpLUpyNFRkUUJBNGVZMVVuZGI3elFIdk43YXQySThrJmU9
DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvcGh5L21vdG9yY29tbS5jIHwgNjcxDQo+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDY2NyBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3BoeS9tb3RvcmNvbW0uYyBiL2RyaXZlcnMvbmV0L3BoeS9tb3RvcmNvbW0uYw0KPiBpbmRleCBm
ZTBhYWJlMTI2MjIuLjBlOTFmNWQxYTRmZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5
L21vdG9yY29tbS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9tb3RvcmNvbW0uYw0KPiBAQCAt
MSw2ICsxLDYgQEANCj4gIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiAg
LyoNCj4gLSAqIE1vdG9yY29tbSA4NTExLzg1MjEvODUzMS84NTMxUyBQSFkgZHJpdmVyLg0KPiAr
ICogTW90b3Jjb21tIDg1MTEvODUyMS84NTMxLzg1MzFTLzg4MjEgUEhZIGRyaXZlci4NCj4gICAq
DQo+ICAgKiBBdXRob3I6IFBldGVyIEdlaXMgPHBnd2lwZW91dEBnbWFpbC5jb20+DQo+ICAgKiBB
dXRob3I6IEZyYW5rIDxGcmFuay5TYWVAbW90b3ItY29tbS5jb20+IEBAIC0xNiw4ICsxNiw4IEBA
DQo+ICAjZGVmaW5lIFBIWV9JRF9ZVDg1MjEJCTB4MDAwMDAxMWENCj4gICNkZWZpbmUgUEhZX0lE
X1lUODUzMQkJMHg0ZjUxZTkxYg0KPiAgI2RlZmluZSBQSFlfSURfWVQ4NTMxUwkJMHg0ZjUxZTkx
YQ0KPiAtDQo+IC0vKiBZVDg1MjEvWVQ4NTMxUyBSZWdpc3RlciBPdmVydmlldw0KPiArI2RlZmlu
ZSBQSFlfSURfWVQ4ODIxCQkweDRmNTFlYTE5DQo+ICsvKiBZVDg1MjEvWVQ4NTMxUy9ZVDg4MjEg
UmVnaXN0ZXIgT3ZlcnZpZXcNCj4gICAqCVVUUCBSZWdpc3RlciBzcGFjZQl8CUZJQkVSIFJlZ2lz
dGVyIHNwYWNlDQo+ICAgKiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgKiB8CVVUUCBNSUkJCQl8CUZJQkVSIE1JSQkJfA0K
DQouLi4NCg0KPiArLyoqDQo+ICsgKiB5dDg4MjFfdXRwX2luaXQoKSAtIHV0cCBpbml0DQo+ICsg
KiBAcGh5ZGV2OiBhIHBvaW50ZXIgdG8gYSAmc3RydWN0IHBoeV9kZXZpY2UNCj4gKyAqDQo+ICsg
KiBSZXR1cm5zOiAwIG9yIG5lZ2F0aXZlIGVycm5vIGNvZGUNCj4gKyAqLw0KPiArc3RhdGljIGlu
dCB5dDg4MjFfdXRwX2luaXQoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikgew0KPiArCWludCBv
bGRfcGFnZTsNCj4gKwlpbnQgcmV0ID0gMDsNCj4gKwl1MTYgbWFzazsNCj4gKwl1MTYgc2F2ZTsN
Cj4gKwl1MTYgc2V0Ow0KPiArDQo+ICsJb2xkX3BhZ2UgPSBwaHlfc2VsZWN0X3BhZ2UocGh5ZGV2
LCBZVDg1MjFfUlNTUl9VVFBfU1BBQ0UpOw0KPiArCWlmIChvbGRfcGFnZSA8IDApIHsNCj4gKwkJ
cGh5ZGV2X2VycihwaHlkZXYsICJGYWlsZWQgdG8gc2VsZWN0IHBhZ2U6ICVkXG4iLA0KPiArCQkJ
ICAgb2xkX3BhZ2UpOw0KPiArCQlnb3RvIGVycl9yZXN0b3JlX3BhZ2U7DQo+ICsJfQ0KPiArDQo+
ICsJbWFzayA9IFlUODgyMV9VVFBfRVhUX1JQRE5fQlBfRkZFX0xOR18yNTAwIHwNCj4gKwkJWVQ4
ODIxX1VUUF9FWFRfUlBETl9CUF9GRkVfU0hUXzI1MDAgfA0KPiArCQlZVDg4MjFfVVRQX0VYVF9S
UEROX0lQUl9TSFRfMjUwMDsNCj4gKwlzZXQgPSBZVDg4MjFfVVRQX0VYVF9SUEROX0JQX0ZGRV9M
TkdfMjUwMCB8DQo+ICsJCVlUODgyMV9VVFBfRVhUX1JQRE5fQlBfRkZFX1NIVF8yNTAwOw0KPiAr
CXJldCA9IHl0cGh5X21vZGlmeV9leHQocGh5ZGV2LCBZVDg4MjFfVVRQX0VYVF9SUEROX0NUUkxf
UkVHLA0KDQouLi4NCg0KPiANCj4gIG1vZHVsZV9waHlfZHJpdmVyKG1vdG9yY29tbV9waHlfZHJ2
cyk7DQo+IA0KPiAtTU9EVUxFX0RFU0NSSVBUSU9OKCJNb3RvcmNvbW0gODUxMS84NTIxLzg1MzEv
ODUzMVMgUEhZIGRyaXZlciIpOw0KPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJNb3RvcmNvbW0gODUx
MS84NTIxLzg1MzEvODUzMVMvODgyMSBQSFkNCj4gZHJpdmVyIik7DQo+ICBNT0RVTEVfQVVUSE9S
KCJQZXRlciBHZWlzIik7DQo+ICBNT0RVTEVfQVVUSE9SKCJGcmFuayIpOw0KPiAgTU9EVUxFX0xJ
Q0VOU0UoIkdQTCIpOw0KPiBAQCAtMjMxOCw2ICsyOTgwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBtZGlvX2RldmljZV9pZA0KPiBfX21heWJlX3VudXNlZCBtb3RvcmNvbW1fdGJsW10gPSB7DQo+
ICAJeyBQSFlfSURfTUFUQ0hfRVhBQ1QoUEhZX0lEX1lUODUyMSkgfSwNCj4gIAl7IFBIWV9JRF9N
QVRDSF9FWEFDVChQSFlfSURfWVQ4NTMxKSB9LA0KPiAgCXsgUEhZX0lEX01BVENIX0VYQUNUKFBI
WV9JRF9ZVDg1MzFTKSB9LA0KPiArCXsgUEhZX0lEX01BVENIX0VYQUNUKFBIWV9JRF9ZVDg4MjEp
IH0sDQo+ICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+ICB9Ow0KPiANCj4gLS0NCj4gMi4zNC4xDQo+
IA0KUmV2aWV3ZWQtYnk6IFNhaSBLcmlzaG5hIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCg==

