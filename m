Return-Path: <netdev+bounces-119995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E578E957CB8
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 07:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F91EB20FBE
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 05:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4260F5EE97;
	Tue, 20 Aug 2024 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="LUJLo8sO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B336B0D;
	Tue, 20 Aug 2024 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724131488; cv=fail; b=p4vIBjC48sQRpPvqBaap3jB4C4KdYX23uUBSBfAFQZshggEusGa4aVQ5FYbqxnInaYBG0W0KV2gRA/vbt8XDo35tlyWNE70CeNHXl+L+idPTbiyeEMkFeXoruK6JekKQALV2hHzy4reWuwRBdb/m/4PV+qiWp0YOvUaQSj4R1gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724131488; c=relaxed/simple;
	bh=/iX+bpKcn9jZRRnRDYJo3DjKyKSvxvDeMPD4y8ZFonc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pikiRByYHTSqsf2ue7aKm5ppvZfY9mEUByjnCa9OpRVARnUAFQTG2zD41P+jkViyD2JZc8WErDThBwJJkTcU90hlMK1A6ne/+mLdcYG4n4t0zEH9pYsYLn6HmyBXOXLaFA5dWEa+GsFeo00NivnYDwj7DgA0i90/4H3SL57lTsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=LUJLo8sO; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K10TpH012346;
	Mon, 19 Aug 2024 22:24:39 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 414h3u0ns9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 22:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kw2cK5iQhbNLrnqPTc/kbrlVFxdu7qfr3GqyWtluHdTwO9egEsb0L/1LjS3s31VgCuN+bFhdTVy68E0v7BEv0dTBlNjkWjBdxE1Vae3MEJpsz0s1GyODiQzskNiohhNu0kGd9knTYoHmVYkzZzP8sOHVDuZLicHBsdILCs+z1WHSIyDz0+GA07//GIKCMZOsCI3SFrRYIivRAvgkHFaS5IySzSqir8SRNQFkg206tqUdK9eA3FzcpLvNJdu7FS0LGuXD8nCSNPEXFrsU2wkGFWRY/28pfNIPd4dLYdXygoK/9orJSbnZGHe9OwGim0UVPTnFLG7DE5vZNwFM9I1s4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iX+bpKcn9jZRRnRDYJo3DjKyKSvxvDeMPD4y8ZFonc=;
 b=tNsulsqYUzPlnO3K3uJru8q4WyVaToAU8MEu0GP0UWMUhZsIPCooYZmnMzLv3BrfiI4qIZO9QkPd3oLi4CQyvefAB2wGWZC8Lp46qXPe0BAxsfQyrwM34yVmAwbyrwajfnGWMG3HcA53NoXWvoyvxCjeOcvDFzNbVeuZ11Ahs4AZOl6sehvs60KW5a9AMjOV9rGbH//vm4fdcs0DVHOPpTANf/o/piDUbVeVmQBUI37S/lhSu88NlcwxjlR4RHfAHsk9C03SIzJjyIRZtM3Yi7CYROWaW0xIQhNLIsDz6B3IcTNcewyp/ohtLBHrVHwPl5FipQ3c+w6/5yIdPmc2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iX+bpKcn9jZRRnRDYJo3DjKyKSvxvDeMPD4y8ZFonc=;
 b=LUJLo8sOfKmah8h7uV5a2s9XaNegpdQNeKBm9q6NHqNkfn/pYvmV8Zcp+g0YwZxGEXX4x8NjHVYVUeiT7SSPdYGGBntjMOWvaaHRBIlFL5Unm3G4f0LcH+JjWdowoSbX44edx7xj6P0qM1mrJH/qR6eHJSxJv9o29dUpN0moJvE=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SN7PR18MB3936.namprd18.prod.outlook.com (2603:10b6:806:f4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 05:24:36 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 05:24:36 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v10 01/11] octeontx2-pf:
 Refactoring RVU driver
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v10 01/11] octeontx2-pf:
 Refactoring RVU driver
Thread-Index: AQHa5z16bLt3siVov02ZB0iTBLEH/bIdhGaAgAxb6aCAAB1RgIAFtYPQ
Date: Tue, 20 Aug 2024 05:24:36 +0000
Message-ID:
 <CH0PR18MB43391B819ED95FEEFF6B9538CD8D2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240805131815.7588-1-gakula@marvell.com>
 <20240805131815.7588-2-gakula@marvell.com>
 <ZrTnK78ITIGU-7qj@nanopsycho.orion>
 <CH0PR18MB4339720BC03E2E4E6FAC0251CD812@CH0PR18MB4339.namprd18.prod.outlook.com>
 <Zr9d18M31WsT1mgf@nanopsycho.orion>
In-Reply-To: <Zr9d18M31WsT1mgf@nanopsycho.orion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SN7PR18MB3936:EE_
x-ms-office365-filtering-correlation-id: 10c7494b-61a1-42c4-0cfd-08dcc0d861e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?em80T3dUcmVycXpOcU5hOGlNNXdua1FvRURjZHNaZWNhWERqVS9kTGZ0SVlh?=
 =?utf-8?B?ZmlJMHl1dFcvUUt0LzlPc1NwV3pibTRhallZM1BzK1N4ZDJjUjVKWjZYTGVp?=
 =?utf-8?B?L2M3R2h3Yk1QTkdKd0V6VThTTmxDVFpRME9qTUdmU1o3VGNFMTRpdS9uYk9R?=
 =?utf-8?B?RVE2Yjd3WDZoVmpaZGhxWmtnL2dxc1k4NnN1MjFFb21XTmRxS1hQd0o4QUwv?=
 =?utf-8?B?S0FaZFM3clVPZ2pkamJmSEt5T2dhNk9IYWsvR0JRdVB2SUF1emtwd1R4bkNq?=
 =?utf-8?B?ZjFyRHNWaW9aR0pwL0JqcUdOT1hURWR3TlJhVmtSdWM1V0wrZXNpTk5wOHhD?=
 =?utf-8?B?T281UGRoQVVWMFc3ZFV6Ny9mZE5lMTNmNHEwQlhjeW8vVFFybTdkYjNvQzFi?=
 =?utf-8?B?NnFQV2RlVUxzaTdPck5wS0NXZHc0ckJrMitXOGlrMEVXemlNaEJqQlhlMGFV?=
 =?utf-8?B?cEZ3T2RKVE1sL1luY0xpTm82ZlBiaklVQzR4WHhxcVArY1NDUmdwclBSaWtO?=
 =?utf-8?B?OFhTQkpOY0djMHlJclM1elY3d05FZFJwb01MY0l5V2lvSFNYNnUvckZqaE9O?=
 =?utf-8?B?MUpyWDNzV290NjNSbXRUcU1wTWFVOTZZRG9ub2VKMWdqeWczNVRqc1ZzRmFH?=
 =?utf-8?B?bWVaa29GYlFDYmwxSmk3TFpDQWNaU0QxQmo4OURkOW0wcWFFc1NEb21DVk5F?=
 =?utf-8?B?OFVRZm90eGhCRmd3dnRZMXFRVklEdzR1T1FZNW9ubVBUQzRDTzJEK1ZoRnd3?=
 =?utf-8?B?aFV6b1lsSGZWaW5SK2dWTGZ2Nkpyc3YwYlk2ZWxOVi8rMUE0d293eDM4ZW1q?=
 =?utf-8?B?akxXbHB3aXNKM2xnYUVLemV2KzRLcFdPVzlVdi9WUVRaTFVxQTBkMzZ6SXZE?=
 =?utf-8?B?RWMwM2FvUzBQQ0VIdVN4Y2FFTjVtaTQrTCt1Q09maFROYXRwTGJNRUdDVkJU?=
 =?utf-8?B?OUloVGRWZTRmYXRiNnlPRlFlbWZoN1BId2g2WHZ0MXU5eG92TmoxQWdpZERC?=
 =?utf-8?B?eUx6WnljZm1zWlk2ekJXTmFxZ0VFbkw1d3dNZ0hPQithVFZmUE9QTGJlQjc0?=
 =?utf-8?B?czROS0RPbzVhaUtCSWpITUxZdkExaWhjNStKQ1M4ZUVPQ0FWOVhzKzJFTDIw?=
 =?utf-8?B?aXc4cy9JNXpHaXFSbEJXYi85ajNQS3djRkxZMHV6YW9McDZKcE0xbkl2R0pS?=
 =?utf-8?B?MmdRQ1hiNS92NnV5OGZwaVNjSUh4cHc1ZGNrcXpISXhFQlhndTJaQnVnMERV?=
 =?utf-8?B?WWVDR25ITnJRelFUU0VxakFSRnVvdWIwY214eThTNzFXUmlQajd3ZXRnWVF6?=
 =?utf-8?B?bmQ1OThiM0RtV1VyTStkdU1Sek40UXJqdXUwREZvR3dwc1pObUhaYlA0bFI2?=
 =?utf-8?B?N09WTXIxV054VThJTnNvTHNPL2hCZTBYZGZsS3Y0Q05ZYnRCYnM4S3JoRjc3?=
 =?utf-8?B?QlFxMy94M0laVzdUQ0p2RXBiVldIMmRKNFlwQmV6aGt3Tm5FVWY5b1laVjhW?=
 =?utf-8?B?amYrTk5SOHlQeVY2WmVlV1NDWVVzVFRUQisxcDdndGFTWE5RUnhPLzZ0QklQ?=
 =?utf-8?B?NlhRMFBmc2s2RWhMMldOS1JOOFlORk8vMVk0dElYN2diK1ROTXBJMEtSZkp2?=
 =?utf-8?B?dFQxYmVLUCtJOTgvRk5pblY1T1gyQU9vL0pQQUVBUEo5d0EyZkRUY1QxWHFk?=
 =?utf-8?B?UEp3L0U5b2RkY1paY1VSRmdINDI2Q3pXc2NTWlBkZkJTM0UrMDNWbVdaTkI5?=
 =?utf-8?B?TjlqUG1RdVAraDRONEhJOE1uQzZyTWJza01yL09NdEpmRXJjZUZqZ20zREdk?=
 =?utf-8?B?RDgrNmxWZllvblZqZU9UcHVsQ3RjRkdEOEtTcWU5dEhIR2I0QmVkWjQ1ZnFt?=
 =?utf-8?B?dG82bERmT3Jnamw2R21RWU1ldjI2UUZVQkZlZkRpTFFxU0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGhuQkhmRGdZZzRyRzJnL0lRendKc09kTExiRjM3TzA2ckhQQlBHcm1OcWZQ?=
 =?utf-8?B?eHpHczdiaDhmWGZBb0F5cEdtQ3NxNWIvSXlGZzh5cXNKTFZIU2ZtaERRR2p6?=
 =?utf-8?B?Sk16QjlueHMvMnAxL0U2VVB3UVV1VllhanR4amxPeWYrTjZzOUJmM3d3bW5C?=
 =?utf-8?B?SWJuV3dFRG45Um1wUldqek4zeWRjQ1M2QklDU24wcVNRTzBZZ2FaLy9hUlVB?=
 =?utf-8?B?UCtiYzNmVGswU3lIZHpBRjM0RnRFVCtkczNMU0tFWjZZNzk2VzIxVTRZSTJM?=
 =?utf-8?B?TVlUWk5BVU43b04zQTV6MlFGQWVyWUVWbTUvQWFGaGZiT1pNZ3pCZ3NiNERB?=
 =?utf-8?B?YTV6cGV6SEsxeXVYWVQ4TUtvdXplZGtTK2p5R3pFeGQ5djRQTzBTeTh5YXV5?=
 =?utf-8?B?Y1RYdWNKaG8yQ0lUWGFndnBKaERML2JoSDRNYXNTamREZHlBMVZSU0tMK2pO?=
 =?utf-8?B?bmxyTkdDQUs3a1NxOC9TS1UySURtUndMSncyVVJxa2ptelJxZzdTUWk3MlBO?=
 =?utf-8?B?M3BVcmRtSmloaVdhY3ByTE1LQURWR3k2emFleDFaK2ZzaUFTTW13ejkwUXZE?=
 =?utf-8?B?anJQWC93b0RxS1ZJZ0FHY3VtTHMxZjVzRUhMMVg4WWUxTjhITmxjQStuVTlS?=
 =?utf-8?B?SWl6NjdPMGZ3L25sTzc5bElkZXRWajdCbVZ3d1YxcWxmZUkyQVZXWndyTXl5?=
 =?utf-8?B?WXQvWTlKNm5Vcmc0bmMySFdoVDVLR3JvcGdMVlhBOW9DaXk1NmhHUmlhbWUw?=
 =?utf-8?B?QzZ5NW1xOWtrV210Qk1RSzdPSFZOQlZOQXdFNnZEUTNlSGtmNjF5NVNFTXNF?=
 =?utf-8?B?NDB3TWg2WmlOeXhTRk4xdmhwcGc5Z2xQVzAwa3lscVF3VFRCTkdxNTNERERx?=
 =?utf-8?B?Y1dJNDVialQ2dkR2amhucHIrQ2hQRmwySUkrZ2FTVVJHVTd0TzBSRENEQ09K?=
 =?utf-8?B?WkpRaDRHazVleVpzUlNoaC82UjhqUk5oOE1ZSVJkVmo1SG9pUVZOcVNyU0RT?=
 =?utf-8?B?d1FQWktveTJrZUltSWtUaWUrT1IwcysxQ3lKWVoyOGlNUWpkUHJyMVo2NndZ?=
 =?utf-8?B?Z1VnQklRRWc5dEZ3MkhVM016N3lIZXdjNzRuZXp5cWd5Z281aUdXcnV3RjlS?=
 =?utf-8?B?ZitLTDlBRFVwRE1KZFpyVVZlRlBlbyszSFZvMlppcnVrMUNabmxGNWgyUEJC?=
 =?utf-8?B?dlZIR2I4N3RNTUdhNnRtS3NVYWZsN01VdVNUVE12aEpYbnZ5VXNZS2VqM3g3?=
 =?utf-8?B?M3A1MnUxYTNybERSK1k4dnErYVlkc2ZYdG1QNllYb2FaNG5TSGNrYU05NzAv?=
 =?utf-8?B?UDJWQk1zMlIrS1RXOHQvQ0FQbk9jS1huZW9Fb0NidE9HNm5Hc3Z6ejJFNjBJ?=
 =?utf-8?B?VWxtOVVkTFh1Y25GRmpYb0VmT0VRYzkvcm9kcDl4MnJNemtXL1ViSVhIbTJa?=
 =?utf-8?B?c3EvNC9uRWJBSGRhc2s0ckt3OHR2aXJqLzQ3WVIvZkwydjFtMkhEYkgzcG1R?=
 =?utf-8?B?blkyYjIrRDIxY1BnMkxmUFpQT0ZpQ3Z1S1A2NFVDNnRmV0g5V0RUTCtueW1r?=
 =?utf-8?B?TnF1bHVQOTBtYzAzdndqQ0JsWHgzcEw3SDFmTHZUOGRiTkJudUkrUG9TOUZm?=
 =?utf-8?B?SStCeEFVZllBVUR0dEdZcjY3bmdGYVVVVFo4cFg0STBvYXJ2ZEI1a3pwWHIz?=
 =?utf-8?B?MXNsNUxxS0tnNEtxUGdkN0o0VEh4UTZROWNsQ1Jtb0JtbVc3MU50MXJ1enlR?=
 =?utf-8?B?Mk83UGU3SVRJcDlqRTRpZlM4b29pcHJySlVCeVpvQkpJSDZEa3hMT2Q1R0N6?=
 =?utf-8?B?aU5lMnVxWXBDUitJSmY2NEZCMUZweEFYelYza0J1YUREVnJNSlc3V0IvQXQy?=
 =?utf-8?B?OWxiWWhRSVN5YS9xdmpwV2Q3dUVkT3d6emN5dVVuTzltMVIzYTVXbVJjYWh6?=
 =?utf-8?B?bnd0V1MzYWYyWE1oY0tGYmZJdmd4bW9aTzNFZ3ZZYXdzRlRNT3MzK1prMFN2?=
 =?utf-8?B?VXQ1VDJiK1pGYnFvQkNEYmh5N0Q2dmorVXZzM0gzbExVM05EMitoSVhkcWcy?=
 =?utf-8?B?WFhaR09HUWt2aFc4ZFpiakZnZ3pINFF5T1drdktndXhSTnVHVzBwUEFIeGdB?=
 =?utf-8?B?KzhvY3Q3TGlqQ1Y0aUlUR3U4QUhwS3kyQ0Z0VEs2dHpoem43TG5WZ0V3Rkkx?=
 =?utf-8?Q?ciLBPAtRiYivxgBs91eKuSU+rhlWegvjv0fPPkwf+FXt?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c7494b-61a1-42c4-0cfd-08dcc0d861e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 05:24:36.6992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f91xNxxmxDMtwsL0AJMmCx/V0X6nFjjESVMa4GGNF001D59wkcwKrK+cjgkBjs641H0lLmC8FjpyPlNhYgLs0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3936
X-Proofpoint-GUID: a15ZqLm3UtLoujCTKodFo1qU6HgtDGe9
X-Proofpoint-ORIG-GUID: a15ZqLm3UtLoujCTKodFo1qU6HgtDGe9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEppcmkgUGlya28gPGppcmlA
cmVzbnVsbGkudXM+DQo+U2VudDogRnJpZGF5LCBBdWd1c3QgMTYsIDIwMjQgNzo0MSBQTQ0KPlRv
OiBHZWV0aGFzb3dqYW55YSBBa3VsYSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0KPkNjOiBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrdWJhQGtlcm5l
bC5vcmc7DQo+ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgcGFiZW5pQHJlZGhhdC5jb207IGVkdW1hemV0
QGdvb2dsZS5jb207IFN1bmlsDQo+S292dnVyaSBHb3V0aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNv
bT47IFN1YmJhcmF5YSBTdW5kZWVwIEJoYXR0YQ0KPjxzYmhhdHRhQG1hcnZlbGwuY29tPjsgSGFy
aXByYXNhZCBLZWxhbSA8aGtlbGFtQG1hcnZlbGwuY29tPg0KPlN1YmplY3Q6IFJlOiBbRVhURVJO
QUxdIFJlOiBbbmV0LW5leHQgUEFUQ0ggdjEwIDAxLzExXSBvY3Rlb250eDItcGY6DQo+UmVmYWN0
b3JpbmcgUlZVIGRyaXZlcg0KPj4+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PkZyb206
IEppcmkgUGlya28gPGppcmlAcmVzbnVsbGkudXM+DQo+Pj5TZW50OiBUaHVyc2RheSwgQXVndXN0
IDgsIDIwMjQgOToxMiBQTQ0KPj4+VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFy
dmVsbC5jb20+DQo+Pj5DYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4+Pmt1YmFAa2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsg
cGFiZW5pQHJlZGhhdC5jb207DQo+Pj5lZHVtYXpldEBnb29nbGUuY29tOyBTdW5pbCBLb3Z2dXJp
IEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsNCj4+PlN1YmJhcmF5YSBTdW5kZWVwIEJo
YXR0YSA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT47IEhhcmlwcmFzYWQgS2VsYW0NCj4+Pjxoa2VsYW1A
bWFydmVsbC5jb20+DQo+Pj5TdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbbmV0LW5leHQgUEFUQ0gg
djEwIDAxLzExXSBvY3Rlb250eDItcGY6DQo+Pj5SZWZhY3RvcmluZyBSVlUgZHJpdmVyDQo+Pj4N
Cj4+Pk1vbiwgQXVnIDA1LCAyMDI0IGF0IDAzOjE4OjA1UE0gQ0VTVCwgZ2FrdWxhQG1hcnZlbGwu
Y29tIHdyb3RlOg0KPj4+PlJlZmFjdG9yaW5nIGFuZCBleHBvcnQgbGlzdCBvZiBzaGFyZWQgZnVu
Y3Rpb25zIHN1Y2ggdGhhdCB0aGV5IGNhbiBiZQ0KPj4+PnVzZWQgYnkgYm90aCBSVlUgTklDIGFu
ZCByZXByZXNlbnRvciBkcml2ZXIuDQo+Pj4+DQo+Pj4+U2lnbmVkLW9mZi1ieTogR2VldGhhIHNv
d2phbnlhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+Pj4+UmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1h
biA8aG9ybXNAa2VybmVsLm9yZz4NCj4+Pj4tLS0NCj4+Pj4gLi4uL2V0aGVybmV0L21hcnZlbGwv
b2N0ZW9udHgyL2FmL2NvbW1vbi5oICAgIHwgICAyICsNCj4+Pj4gLi4uL25ldC9ldGhlcm5ldC9t
YXJ2ZWxsL29jdGVvbnR4Mi9hZi9tYm94LmggIHwgICAyICsNCj4+Pj4gLi4uL25ldC9ldGhlcm5l
dC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ucGMuaCAgIHwgICAxICsNCj4+Pj4gLi4uL25ldC9ldGhl
cm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnUuYyAgIHwgIDExICsNCj4+Pj4gLi4uL25ldC9l
dGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnUuaCAgIHwgICAxICsNCj4+Pj4gLi4uL21h
cnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9kZWJ1Z2ZzLmMgICAgICAgIHwgIDI3IC0tDQo+Pj4+IC4u
Li9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbml4LmMgICB8ICA0NyArKy0tDQo+
Pj4+IC4uLi9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbnBjX2ZzLmMgICAgICAgICB8ICAgNSAr
DQo+Pj4+IC4uLi9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfcmVnLmggICB8ICAg
NCArDQo+Pj4+IC4uLi9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfc3RydWN0LmggICAgICAgICB8
ICAyNiArKw0KPj4+PiAuLi4vbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X3N3aXRjaC5jICAgICAg
ICAgfCAgIDIgKy0NCj4+Pj4gLi4uL21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX2NvbW1vbi5j
ICAgICAgIHwgICA2ICstDQo+Pj4+IC4uLi9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9jb21t
b24uaCAgICAgICB8ICA0MyArKy0tDQo+Pj4+IC4uLi9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4
Mi9uaWMvb3R4Ml9wZi5jICB8IDI0MCArKysrKysrKysrKy0tLS0tLS0NCj4+Pj4gLi4uL21hcnZl
bGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYyAgICAgICAgIHwgIDE3ICstDQo+Pj4+IC4uLi9t
YXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90eHJ4LmggICAgICAgICB8ICAgMyArLQ0KPj4+PiAu
Li4vZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdmYuYyAgfCAgIDcgKy0NCj4+
Pj4gMTcgZmlsZXMgY2hhbmdlZCwgMjY2IGluc2VydGlvbnMoKyksIDE3OCBkZWxldGlvbnMoLSkN
Cj4+Pg0KPj4+SG93IGNhbiBhbnlvbmUgcmV2aWV3IHRoaXM/DQo+Pj4NCj4+PklmIHlvdSBuZWVk
IHRvIHJlZmFjdG9yIHRoZSBjb2RlIGluIHByZXBhcmF0aW9uIGZvciBhIGZlYXR1cmUsIHlvdSBj
YW4NCj4+PmRvIGluIGluIGEgc2VwYXJhdGUgcGF0Y2hzZXQgc2VudCBiZWZvcmUgdGhlIGZlYXR1
cmUgYXBwZWFycy4gVGhpcw0KPj4+cGF0Y2ggc2hvdWxkIGJlIHNwbGl0IGludG8gWCBwYXRjaGVz
LiBPbmUgbG9naWNhbCBjaGFuZ2UgcGVyIHBhdGNoLg0KPj5JZiB0aGVzZSBjaGFuZ2VzIGFyZSBt
b3ZlZCBpbnRvIGEgc2VwYXJhdGUgcGF0Y2hzZXQuICBIb3cgY2FuIHNvbWVvbmUNCj4+dW5kZXJz
dGFuZCBhbmQgcmV2aWV3IHRoZW0gd2l0aG91dCBrbm93aW5nIHdoZXJlIHRoZXkgZ2V0IHJldXNl
ZC4NCj4NCj5EZXNjcmliZSBpdCB0aGVuLiBObyBwcm9ibGVtLg0KT2sgd2lsbCBwcm92aWRlIGRl
dGFpbCBkZXNjcmlwdGlvbiBpbiBjb21taXQgbWVzc2FnZS4NCg==

