Return-Path: <netdev+bounces-211303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD942B17CA3
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 07:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A56164A85
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 05:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A771EE01A;
	Fri,  1 Aug 2025 05:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="SP+BzZzp";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="ehlJ4gXN"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03D1E5714;
	Fri,  1 Aug 2025 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754027618; cv=fail; b=AtGVk7abBen2ErkGxK1MGG7FUV5K81S3V7i57lEZNyc9gnKPRtCCxf82ug1Ci28yDyjukSksCZ1QTpbDk3bWJBZ81j+Bjd8WEUH0733ZKQ+0hWUWtyS8WsL1+yLbOpf5C2TO9/d810yFz1i/LuUY6/PZyrV+8rO7z+QR5cQ/3SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754027618; c=relaxed/simple;
	bh=mP06ySbOkL0vk5cW0c/BhzmmJcEQKs/xAWooP1MMkmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VZZCoq/jl4iMxJkPLeB40r4tlXk2xJKLX5VC+8mK9ApxOkc7sGDl3t0P8PQwaTe/JY8rwUBxS9Ty+rp30u7KTb/WO57qp9/aR3FhhhipsxgwMC/2CvmgYNDtMIMFVdt2JBb1vBRWUE3BDqmWyGnLvUbNwwJnbHw5Gf3A7uay9cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=SP+BzZzp; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=ehlJ4gXN; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5714hkLp2526608;
	Fri, 1 Aug 2025 07:53:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	5QlBfGzg+kjyHSw9NHIlHl8t4aDHOtDy4Br5R1GWIrI=; b=SP+BzZzpcajCyK5M
	nKFU3US6RW6VF98DmBwinu6S5QHJjvwjfqCqnCQmep7mtdSVmj3U4NKZ+AFafoLf
	lzRP1RIJZd5VOXrt7eLO0hQzDVL67BNig0SpdP+tHgiccQHd+SLu+Ii+mR7RJIzQ
	ukgl2L1XQCK4qYJpDvb8SKNh8eCs9eskZK2/wtGzU7UNJ7wVFYPtPWJhuUHw+azi
	6dDY+fR6Tn8e/deGfxTz1cIKVrcseGtVIev44TU64O9WVr09n5+m2l0mm07jyu/q
	HgS7bWQigdIal+uJhUgqc2mFhS6AvIbcFVzV2PsAVhgCQbBOzRZfSfx6GP6AdV/L
	rZ13wQ==
Received: from eur03-vi1-obe.outbound.protection.outlook.com (mail-vi1eur03on2118.outbound.protection.outlook.com [40.107.103.118])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 488c9crdce-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 07:53:22 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X72ObECAoTQmog9+2vxKqz0g3/MGMOssNELHTtyStfQnd3uXrh6zci7p8arP5/MD44woJzpk5a9kk0ZzI31V3kN9MVon8zHsqf24Q0bK/CRVItROt7c+vEIEChslHfUffj+NTbdVezBpPSu7sTv65nx+ywLcws8nz1u/aLzwpzb3oxXl4VhHx6x1bjcsg0H4QwB+O1lr1bIHeOLP/raJYpU/5wCYwwxKlLK9RbC+YTBvmpPYtMMUSvNRte6DEW0gkc2tDJ+pw5FCDWmCLBvJZBhLN1wbf8YBybVk0nrMxlxegWcUja+Gq2cRaqpmGRSB0uWvtXgkegsAfFZ/rlgxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QlBfGzg+kjyHSw9NHIlHl8t4aDHOtDy4Br5R1GWIrI=;
 b=WNmZHTaDrr72Crx42UBkstnB/B+vy+SbHBIfJSrxbwGr1fDZ5+AzftvEBDlIlVpvnk+9bLj2wLw3l3CV8VWgVvGKvNN0ra/Kg0fb21sD4Yuj8/q0PaWV/CBV2sLhMHEp/2Dgh2Ei3HURLOBV4f1VNqVHzfyaxl6MD1+4G3jrxzDyuHONo/ZWu3B+Ynp91W+ifVWRRlQjAoLK0lRVFHI3TIoc3GI4PD/zQDu969ILUJsDRHGJXxCPvEffsOA5AvblXsn1axr/Py1RYBAtwKDZ/bNUKdT4HEbAQOsD23EqKHfisCX7Tf9/agDkRRS9g5YXmUJnu9RMA0jgc+D+3xHEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QlBfGzg+kjyHSw9NHIlHl8t4aDHOtDy4Br5R1GWIrI=;
 b=ehlJ4gXN30q/Ze1h6j6OOx1qdW/MpTBnJ33hxzC5PPDBAKcZim44mMJuwrlgNN5hCVFN5d+f7m0NsOLIUyXN1FjiGJtk2i80w7S3HIxZI6BELZ+tliahgmmpJxgHRXqfoCI6SaI4up5chWzu2ZmIl9pOcxB8L8HGIHA5wkNj9Ks=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PAVP192MB2064.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.4; Fri, 1 Aug
 2025 05:53:20 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 05:53:20 +0000
Date: Fri, 1 Aug 2025 07:53:16 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aIxWTIln+zs69w3n@FUE-ALEWI-WINX>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731171642.2jxmhvrlb554mejz@skbuf>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: HE1PR0402CA0027.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::16) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PAVP192MB2064:EE_
X-MS-Office365-Filtering-Correlation-Id: 0065e8cd-1630-4f60-83eb-08ddd0bfb7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXUvR0RZNEloUys1QngzQWlpM1QwVkMyT09LVSt1M3F3QXBhZUJVcDlJVU9m?=
 =?utf-8?B?NTM0VTJjMjh3TG9DanNmREhtZEllemdlcktyM0hUWk1yKzdLMGZUam04eUJZ?=
 =?utf-8?B?MFFmZXkzTkkyOU5uRmcwU2ZlcWRFUnR3V1N6b0JmNTlpdlFZZjA3Vjh5R3Nz?=
 =?utf-8?B?RnpoWXpIWWRJMnlkOGdpTWdXY3UyU3YzdVZCTkpjdWRsanh5T0syVGZOL1R6?=
 =?utf-8?B?T3dKTnNMWktFclExTktHQnRRcjV2eHVIaXcyOVJEYkhxRit3Sm8yTnBNenpG?=
 =?utf-8?B?UlltZ3hkZHVLT0liN3YvckpiTTVHZTlZTXl4dEordUlYREdFYVU0R1VGUHZG?=
 =?utf-8?B?YmFmaFU3bnpoc05CYlpXS3pydnpLcmhYakpKZVVPdmhDUWtrMllWSzZNZVhz?=
 =?utf-8?B?c093dnJhMnJuZXh3UzZhRnVyRkE2V3pHVGdhNDVJQlVON1FrRis3b01vOStr?=
 =?utf-8?B?aWIrSytSOVNaZ1V4aGdQZU4rRkNqTHo1MVViQ1FRSVBFYUlBcGhSNTNldnYr?=
 =?utf-8?B?NWk2emlvaXBMU1hndzNHR3JicDA1NlppVTg2NndQU3piQnNhRXo3K2dZSXR3?=
 =?utf-8?B?Z0tFMHErVXJ1RjEzcVdvamRJYTZJenNDR1Q1dDhyOTFrVndsN2dYMFROS2p3?=
 =?utf-8?B?Ujh3YU5jc1VJd0hsb0JaNXR4UkpvMzZBUTZuZnBiOS9US0lCQzNLN3BYVkFQ?=
 =?utf-8?B?Y25YdjRuUmZEeDJWV3E1aE1YY0VmUFJnTXpqMGxZUWl5U3pRUmwvU0x5bCt4?=
 =?utf-8?B?S0VBQ2JGczRIWjRRNXU3MjREaTVQT213ZEQ3b2lIa0hUekRNQzN6OE1PUExz?=
 =?utf-8?B?YmxWSjBkeEVxM0FrN0ErOFZyZ3IyT09jODFLeVNKNFFwZnhtZmhlMnRpTFgx?=
 =?utf-8?B?bHQra2JKZkFuejd0L280a2h3SWozd2dqVHJJb29sY0RLOFY5T2hISHp4YWJS?=
 =?utf-8?B?b0tKSmlmbzNFbEwvVWExWFFmeEUxclVpMENnQm5CdDBxZFZHR01oVG1LSUVS?=
 =?utf-8?B?blVjQnBhelFja2paNmU5Ti80dWdhUEw4d1p1TUE4b2M0aWU2eEdaMHRZazlY?=
 =?utf-8?B?LzdjcW9KbmtqY0c4WTNLSmlSdHB4eFcvZnU3b0tKUk9KakpTaTc3RmZ5MWx2?=
 =?utf-8?B?RTRhcUJ3VzA4cE9GcUJGQTZwT1plcW9xV0lzTHJ4RUY5QnZJeEN3SUdWd1o3?=
 =?utf-8?B?N09RcEFyV0VSMXplUTg5aVBKUTVmVStQa2Fsd1FZYUxacTcweEtzK29DamlI?=
 =?utf-8?B?MEI5enNuNUt2NWhuajlwZjM1ZmhlMkJQdDhvZzJXQU1aVHhjcDlxMTlVelhQ?=
 =?utf-8?B?VWRjdGdsK2t0T2g3MjZaVHVUbHE2d2t5Q1ZIcmVsc0o1ZmZ6QkhHOGdTN0lj?=
 =?utf-8?B?M29JT0h5VjJuYnVGNUxEODJmbmFZLytocDVDdHNpMUNETVd0U2FMUFVaUTJL?=
 =?utf-8?B?QnE3WW82LzE3bjlXa0tWV0VkTE40ZWxVdnpSN3dNeGh5MnBMUy9nSVB0dDFJ?=
 =?utf-8?B?Vmh4MEVFc0xRcGpkQjV2OUFEWS9hdmZYR0ZxR1V4TGdiTStrakc2TEdkM0k4?=
 =?utf-8?B?TTl0YnFEcDVxZmNJWG9nWFJWakZqTEUxdW91MTFBOUgwWFd6bk9kM21Ic1Vi?=
 =?utf-8?B?MlEwajg2b3MyTUlJcjk3WjA5RnZLdm9CWnlSbXVML0ZQLy9vYWhPMGtxRUwr?=
 =?utf-8?B?SW9vd2lrS1RIYlJLMDFFMjU0ZzVnRzJXYkl1WmtrMklMbFRTeDdVVGNtWXRw?=
 =?utf-8?B?cXR5aFVtRkQ2RUVXaHZIQUtYSlpUMmFtczJoaldXSmdXZmNxNUpUZnZMY3NV?=
 =?utf-8?B?TEEycEV2RHhKdGxtWkJ6QVIvc2lVcElXNWpnWCtNZVJjUlpDYVNJQ2UvUG4w?=
 =?utf-8?B?NHE1RU9qRFlMUEVBSVlOQ3ZSdzdoMkUvNzhYSEluQlNqVHNvak5WQ0FDbWxR?=
 =?utf-8?Q?v8Fj7HE7qI4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUQzRzZwZDh3T2hPZm1YRE5pcWdSd3FFUjVtcmlvelNUZENLSUVXMFJ5YjRZ?=
 =?utf-8?B?SHpRYWhOZHlycmYxbXhpSDRWYjZDbnhWU282TGU3NHdWbkN6aWt6ZUhFWS9p?=
 =?utf-8?B?dWI3VDlpcTlmZGhqbkl4QTdSZGRpcDByQnJoNU5xWjVRak1QWVQ3NkVZSU1I?=
 =?utf-8?B?RVEveFh6c0wxN1NIMVRFNVYyVVR1a0FDZHRJTFhRMThqeGF5cEJVa291NWFO?=
 =?utf-8?B?b3hTN1EwaGhQdG5MaDJueGg3dXBLODg3QXhkdUdEZ204c2ZuR2QyR242NEY4?=
 =?utf-8?B?U015cGhuOEUrdmtCUDMyZXpveTlJbEJEZitGSHVFQ3Q3eG84cEoxYUZmYmlR?=
 =?utf-8?B?TlZPUDhtcDJKSktHODZFWGlvenloQmtXWmppRDYzWmRTWmNPMkNvTnB5QVlB?=
 =?utf-8?B?dXJQN1YzQzdHRWowKzI1bU9BN1ByMTI2ZWxjQVU3Y2RmNTdFV1lwcENEZHgz?=
 =?utf-8?B?ckJseXFScEFpRGtWa3hhUkdpQ0JzUjdWRS9la3ZEcW5Mam1kd3NaTGlXbTA0?=
 =?utf-8?B?c2xBazJBSmhMUVh4MUxmeTA2UDhhVTl3bVR0bncwVG9ZdERJV2VINTNJNXkv?=
 =?utf-8?B?Q2daZjBQSmNxanVzZ2hLTEZkaisrMUlzenhRMnl4c0tMdVVOMVAvRWhhcUlO?=
 =?utf-8?B?czVYY0ZqenpFWXBHUkg3QjlTL1VkaFhpSkVMN3V5dmx6UWJ3WGdheFA3L2J1?=
 =?utf-8?B?TTJIbWZpbnFPZ254UmJHejE4TXAwME9zdlo1S1I0VUNiRm5HdHpiSUVDVE1q?=
 =?utf-8?B?cXZ0UFk5UHdCWVFVcmMzRmtmMVhTZWEwbzJSYnZXVW5NMEVuQ1lWeG9mdmli?=
 =?utf-8?B?RFRVcFJGSHp4WEdwdUhveUxubDFxc2NDVHdoN1ZpUjl4S3o1b1hQT1VEMjNK?=
 =?utf-8?B?dUEyUDJ3OUx5Ui90bzczNTFnZVh3L1B5eWpnRTFwbTJ2SDR3aGxNci91SUlq?=
 =?utf-8?B?d0dEVEs3aDY2U1g5SG5GUEFacURpdjBEUmpTUjVCTnpuR2lkcnJ0RlpMUTBv?=
 =?utf-8?B?MVAwWHNteTF5Rmo3c25PQWRBTjhVTDZNWStzU0tRbWxBVzdxSlp3QTVzd0RD?=
 =?utf-8?B?RUFrLzYxdUF6WHhoVU82V0wwQUlMVGRzMU9CVHVQNXlnK1gxcjJJWjZ1OWJJ?=
 =?utf-8?B?ZjBlOTZSc2VxMmNrdnVkOU5Od3N1azd3c0tWZGpIU0x2NE0vMUpHUnZXRTRM?=
 =?utf-8?B?bm5NL0IrYjVnUjBrWWtiMGVTeHF0SnVzeUtnbWJjTkRRUXBIQ04yOTYvYy9h?=
 =?utf-8?B?SHNhbVd3dXlTQWhDYndDQ2JnOVY4dFlTQ3ZoNE1NWEd3Z2xlbURhcTM2Kzdo?=
 =?utf-8?B?SDJtRSsxWlpkRmpnaFd1TXpsbWFqTm5XUzMydmgwWDk3WlhoSCsxMVlWZXlD?=
 =?utf-8?B?aUpkOEo4SUFVczRPdGFGbE9aVjA4a0NHYi9ZN3pEVDUrTTVqYTBIVnhDdWk2?=
 =?utf-8?B?RW1aWHJkYVhKV1BXWWN2N0NNUHlWak1kcFg2K2FCQlJQUEppUS9HYkFIVWlo?=
 =?utf-8?B?VWhnMGNqMXVtaSthaFdWdDRXOFJRQzMyd3NGWHRLOTA4SjR6cWppYVNtUUNX?=
 =?utf-8?B?eXlVMExveVk3OWZpNGc2TWVNNVpRSW9RSU1aakpIZkpRT2xoYUx6cW9hWEJa?=
 =?utf-8?B?bVN1QTN4RGtQSTJXTDMvWlN1czFNZnF6NEM0cnhpeEZQa1IxaTlaa01PYmR6?=
 =?utf-8?B?Z0FSUzBreE1TRXhySEQ3WmVHa2RlUUtSc3QrYy82REQ3UnovNDI0YXVVRW1s?=
 =?utf-8?B?bkNBYVdmSXBvcEJiV2RrRTY4S0NXVUhjemN5cVVnM2JURlZsaHU4elhqOG9y?=
 =?utf-8?B?ejMvaWhBWWhHby9pdUw0bDRJb2FDYVU5ZEc3WTFiNEhDZUFwRFFYSk52Y2Rv?=
 =?utf-8?B?OHVyR0piK2o0ZnM1Y2NLZmRwVUlyWGtOUmE5U202MlVlUHRBWGJwalVGVUtM?=
 =?utf-8?B?SWZmWjUxLzFROExvZUJvaVRxTUlObkluNy90K1E2aWVpM0RyODEranZibGZC?=
 =?utf-8?B?ZFp0RDk4UndyazFBU3duVXhQWjFYa0VkUlJ1Z3Y2MHBXcHphdkxYdkUwaEdz?=
 =?utf-8?B?eWNDYjIrOWZMcnU0ZlA5eVljN2sxdTJkcnRTdjh1cWd6Zlg2V2VzbC94Ynd2?=
 =?utf-8?Q?lBET9DdB/y8wwn6gejZmwmC9y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eGulsEZlHt6o4Gv9Ddeqw1QBHXN3pOhmP7PLfPkh3B9UCtn3RfRrR6ItKDlXU028ai4FrSvD65QEA8idjdUFzTXMgDEy085Qs21UY5xEDm5C7ZFWlbUGBVBJ2j91ybT4hHhqOuRhP9k4bZHBEcaG1NR9FRM8IfYYadIR1cdJFHqIeU6BA71lX0L6thp0Rjqcdi/8lzxNEkH0Cy1Vkwju6LUbXTwol6xxZrVtkswmS+Qb0CHkLbQhx0x/8EGIdL8B3gkIrsrHv1cmOdkPf4u/uKsmXayooZ17GTggcvlJqOLo+ycsTQ2X09BtFMFJ2L4vJ4I+2ZePy6r7iQVJBhBjbApQqTDJiqI2ZDYMAIpEtru/UdmwdRzojunceO2RMfdCfRTF9EdkXvgNGf/wt39shnD+YEEJSgMQw1j/29XGwCSYXdHrOQzaWG9elK+7GAC9sx0LvbPYhN7H1zOn8NmS9WgqJZxygFEHmrvfU/F+e4wcF6sXCeyVPX7tejE8xgUgAhOj2u8mGccGybsWdWXbRf9b6YeJffVkyq0LNu6+VW39omnqY+bg5RiF05iZhYE1QHclZWtwNQVUSDTKPjiBGA9JD2GVgH1pFZysjokzfGPoFKHMWlD50m2ydY2RLcfh
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0065e8cd-1630-4f60-83eb-08ddd0bfb7ef
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 05:53:20.0246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vqLuX5PFvDuG96dADPegNm8UsmCnukCzjlzQSgNGc1VSkfZBQsIQH6M0acMcLT6a/xZc8P0aVeYSBweDv19hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP192MB2064
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: PAVP192MB2064.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: FMCLI-L6bAUlE8GvFzydK-Wfow5d7ZUX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAzOCBTYWx0ZWRfX1KwVpnMN6ano
 RPkdqWhrVn0vWOSvkMOwnuUKXQxjc0kF0Eg+9T+jP3t2jq9QjMyk0cVIkuFt3IB3Z98aHfclPE2
 bK8czu2UDeO/AEgDJHMbkjRYEwKDs2t6s6QD1IphQs8BQ8fDreNB8rdAcrPUoy3hhqgGq3LPOyP
 rEUO5yuqUMaeRlh2tluZhAl0piM958bjxlSr2sWcwpMa8h9NkKR6GBkDmcBAAHycBTkm10Pg5yI
 6R9cwmvpC09lOTjV72ilZ9CSmecvNXIkxbpmfGuxZtLJCRNuV7liLii4QbAAHeLRC4rg1VQN9Lj
 8E9Dz8LeqE6xA0lCghybSsOHQU3Kq8RXljY8EgwbGLSMqoMVM6YJ1S+FpjhNQA=
X-Authority-Analysis: v=2.4 cv=IaeHWXqa c=1 sm=1 tr=0 ts=688c5652 cx=c_pps
 a=gp7YNd5uNe1aOejwC4tjbw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=nG1opYKqXYC8NxJh6-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FMCLI-L6bAUlE8GvFzydK-Wfow5d7ZUX

Am Thu, Jul 31, 2025 at 08:16:42PM +0300 schrieb Vladimir Oltean:
> Hi Alexander,
> 
> On Thu, Jul 31, 2025 at 04:59:09PM +0200, Alexander Wilhelm wrote:
> > Hello devs,
> > 
> > I'm fairly new to Ethernet PHY drivers and would appreciate your help. I'm
> > working with the Aquantia AQR115 PHY. The existing driver already supports the
> > AQR115C, so I reused that code for the AQR115, assuming minimal differences. My
> > goal is to enable 2.5G link speed. The PHY supports OCSGMII mode, which seems to
> > be non-standard.
> > 
> > * Is it possible to use this mode with the current driver?
> > * If yes, what would be the correct DTS entry?
> > * If not, I’d be willing to implement support. Could you suggest a good starting point?
> > 
> > Any hints or guidance would be greatly appreciated.
> > 
> > 
> > Best regards
> > Alexander Wilhelm
> > 
> 
> In addition to what Andrew and Russell said:
> 
> The Aquantia PHY driver is a bit unlike other PHY drivers, in that it
> prefers not to change the hardware configuration, and work with the
> provisioning of the firmware.
> 
> Do you know that the PHY firmware was built for OCSGMII, or do you just
> intend to use OCSGMII knowing that the hardware capability is there?
> Because the driver reads the VEND1_GLOBAL_CFG registers in
> aqr107_fill_interface_modes(). These registers tell Linux what host
> interface mode to use for each negotiated link speed on the media side.
> 
> If you haven't already,
> 
> [ and I guess you haven't, because you can find there this translation
>   which clearly shows that OCSGMII corresponds to what Linux treats as
>   2500base-x:
> 
> 		case VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII:
> 			interface = PHY_INTERFACE_MODE_2500BASEX;
> 			break;
> 
> ]
> 
> then you can instrument this function and see what host interface mode
> it detects as configured for VEND1_GLOBAL_CFG_2_5G.

Thank you, Vladimir. I already saw the function in source code, but wasn't realy
sure how DTS need to be configured. Now I see see that 2500BASEX should be used.
I'll check how PHY registers are configured and will look further to what the
MAC driver is doing.


Best regards
Alexander Wilhelm

