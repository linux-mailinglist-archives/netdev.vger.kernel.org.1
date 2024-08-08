Return-Path: <netdev+bounces-116806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A77F94BC49
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF261C20B29
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9AA15534B;
	Thu,  8 Aug 2024 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="LSM1/aCO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE218D651;
	Thu,  8 Aug 2024 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116655; cv=fail; b=EcnbyYtv7y7i0wUjEp3yEUfodIPYInadVBhBKD6vJy1S3T2ckqyflwgVKpULwRZozSD+C3fGzdH0bIsmx+jtrD0gO0H6sgIhus8Qicr1UnlqjZFyzDtBKU6cejPtOt+8whcjPoFUNLsV3lsmjqpnaz4+6ESZCniCZvKhqfF7U8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116655; c=relaxed/simple;
	bh=NecCh77U3jFSiWUDikw51Gpoi7aET9CYVDgcelecvqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DK/H9RBpcLYkFCJlxSlnyZtKyW8U/8JBkQ9S1T5cxigLEs2droVsAK8J9Qja8fDqfM2gGXeKpAfsQ9f/zrhSj7Ak+xdCkvcwzAmZrTYnFVbVlXYqVBPSiZYe+l3+JGbap8MDSfDDzTU2yNphjuMTscdv6mN4W541cGu1iE6PysU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=LSM1/aCO; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4788jv9N003125;
	Thu, 8 Aug 2024 04:30:34 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40vtssgfwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 04:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkZWBYA0akJvtjAubwvb8a4vN43bsEbp4TrEyqseamounIozmEb7sQGB02TS4mhMBq6+pHv/vUm3D0jTy409caB22wNxdxY64qZufK7RmSPUppaaJx6b3vy53tAn90qk94UNXF8uhfZMUOXJjd7mj4mE33dmTqe/3ex1U7LMhno8pHz3lz/mmzzTclcyltbpXY8pT3ytJYZQW2rUCLMmtcsO+oIiyqv3P4sg134mxsiTX77ZwB0pcfa0eGT45Ez/5EriqLnb2GwCbuQK3cPDhDWi+Anu4oabz7EgCcf/9DwAuN0auOKQ2AXKIMIgsuab+pF0sWw6IP3pcGQ+9zdChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NecCh77U3jFSiWUDikw51Gpoi7aET9CYVDgcelecvqA=;
 b=oPf0r0y0t91ftfaMq3X/tAswpY+HTCEsp3Yetnue6MDTLFMoVPT018wNwMGJsA1nzfNeFmYhzODlQdShOckqc1gY5zMZAOo8gYd+6+PygBVFTlKohrcB66ibbkS70gTZYtXw/ADFAmMnbgrgf1rDiUzH8ukQLQdcLvYe0+48KZVyFKCyzBN5duZB6t4vZcsdrlz0+z3GyvpcdUkdYjWOcHVPctYGXkuGkQMWFGx7khR42b6ba5/m/oVSEkadEC/79tIFHfOX3gIblN8MMcLQd1kAchhbxcMD9h6c1UW2WPbhJru9lOB2bTQ30tedScArp+D838v8Snt4SVUZjcFxnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NecCh77U3jFSiWUDikw51Gpoi7aET9CYVDgcelecvqA=;
 b=LSM1/aCOhHhI5M7Ij9zageNunXSS7FUtHIpEkLEpS2S6+WIe7Jj8+8xa+OXyHhXrygnK80EeEJhs7RX8rI5sOYYVqbeLlx17unfHv5hhdQABLaQSVgQLajyFyjlvaF70B+Mv1kqvP7uARZsBTW7YW2lADUqRyrht1VlBVVnXimw=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by PH0PR18MB4427.namprd18.prod.outlook.com (2603:10b6:510:d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 11:30:29 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 11:30:29 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v10 00/11] Introduce RVU
 representors
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v10 00/11] Introduce RVU
 representors
Thread-Index: AQHa6T08IPC5BXJp7020zkbaPAtMLbIdJnKQ
Date: Thu, 8 Aug 2024 11:30:29 +0000
Message-ID:
 <BY3PR18MB473740348BD4FF7241E79C27C6B92@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240805131815.7588-1-gakula@marvell.com>
 <20240807194647.1dc92a9e@kernel.org>
In-Reply-To: <20240807194647.1dc92a9e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|PH0PR18MB4427:EE_
x-ms-office365-filtering-correlation-id: 358a2872-3f5a-45d9-defa-08dcb79d819a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SThqMVhxRDFTVHFGcnYxdm80aHZTZDVkYVB6THZUaXBCTmJoQ1ZpbWxZRWFp?=
 =?utf-8?B?WDdFaEZDbnMxNmY0VzhOOXV5WFF6a2FxeUtNaUQ3VWt1RWpNU1FadlF2TjJL?=
 =?utf-8?B?RXc4ZHd1ZGRMQVlJRFhJTFM1RzF3cDBXTTdJc0lnRFIzYmxwMU5INThnM2pF?=
 =?utf-8?B?MUhZYVd2Uno5Vnpqa09Jb3RjL3h3SDlkSlhyaXVteTd6U1NSMEhwTGJYbVJS?=
 =?utf-8?B?SUE4NU9VSFJqSU80Tk5QQ2wyOWdDUkx3TkhMTWIrMklLUXpEdXkwVUdRc20y?=
 =?utf-8?B?WUYya1BOSyt0Y1IvNFZQbTVLUCtKSG1aemU1Qm1zWnRveDZQWDFBcFMxaGlW?=
 =?utf-8?B?d3c4TjFMNWxtdy9vY2xuTmpsTTloWUNqYjRlT01oMmI5K3pRNGZmenBiWkds?=
 =?utf-8?B?NW5yR25iM1VBSjR5ck50eW5mZ2FwVmxta21lRjFSbVlidzVrQ2hpUU5pL3ll?=
 =?utf-8?B?dG8xWVBIU1ozcm9XaStPT2JrRm9UcFdqYlVKQ2I4WGFMOFVTallWZzNsRzVZ?=
 =?utf-8?B?SEFCVFpnRVRIbzNsNkdncU4xSVluOXRDWmFUMlU0UzNFWnJ3YUVMOVVnWFVX?=
 =?utf-8?B?aUl2NmN2RlFqa2NOc3dCeWl6NjhnakFFcmRuSXkrdC9mTG1CMTlERHQzTXJ0?=
 =?utf-8?B?WkhRd2Y5VCtEWFNHTklHRWZvc2VsOHpyaDVkWDFxMUtZMjloV3VrUHNUQklk?=
 =?utf-8?B?RlZoWE0yakRGVVNxVHdlQlRmUjh6Tk9yc0RJdkFmWWZ1MTlEZktIVnpGKzh6?=
 =?utf-8?B?SmJLVWhUVnhjOXVyT3dNZ21aVW1lR3NMdUVEd1JiUElyN09QdEQ5d2FSelV3?=
 =?utf-8?B?RTBnL1FJeWk0S0kxcGlHeUIwRnNKZFcxdmZ2andreERjUGlsZ0JRSGNkQVp1?=
 =?utf-8?B?MkF2TDZlVzdMcTBGZXd0Zlg3ejN5cWVKWnR2YTVad0hVVWI5MUlyQzA2ckxy?=
 =?utf-8?B?dHB3V3J5UE1aWWV6QmZMMnNPVjhvWk1WZkFIOCtzNTluRFpGOHpzaUZmaHdh?=
 =?utf-8?B?VHQ1VlFXOHB1SG02Q2xEMnhPc1ZCdjhvai96ZnExM2grUHJaVWxzRk1haHFa?=
 =?utf-8?B?dFdTOEJLVW1vSlhVMzhlajM1YWc2OXk4RUxJVnZCR01sRFNBcmhpWDd6MGt6?=
 =?utf-8?B?eE9BSGxyc3huQzBRV2tLWjdVc2JpeDNVcU81YjRyek5vTGZuZGRWS2hOd1VO?=
 =?utf-8?B?bmNxL2dJTmdLYVVNanE2dXB1bEpZaHlkREhYQUZ5SUQyek5KbngwSGhmdThk?=
 =?utf-8?B?VFBVMFpxOWFUSkhaVFRrbHp0eGJDd1M1S1U0cXgzMGhHdm9vWTFrV2lwSlVL?=
 =?utf-8?B?L2p5K3RMS3BRRDZwQlR4NUYzaUlGMW93VTE3bHBoQWxSTEo2aFpuSkN2NVA4?=
 =?utf-8?B?VGRoR0ZYN3VNcmZpeUhnaXpmbVpHQUw1K3VUOUxvc01GUmVUZFg1Vmp2UHlR?=
 =?utf-8?B?ZVgralRKT2lhN3FRUDliU3V0bUtEUnlrOFgzRUljemU4TTVKY2cvRVJETW9F?=
 =?utf-8?B?aUwyWkV6Y1V1RWZsSHpHRkR6eFJFVWJoeTM3N1Bmd2xIMUlHcmJuMDJhaVh0?=
 =?utf-8?B?cHlkdlpqNDRUZzV5Q1NVekZzTEw5QkNka2pOVjd0eGFSKy90dDBmOUVPWENp?=
 =?utf-8?B?ZW5Wc0lRVDZxOFdZMkRQeWd6Nm5oRUl2cERKNGVNMHhQQ203UVhMc29OWWhv?=
 =?utf-8?B?STA3UmpOcjJ6TGxyQ3Qrenhkb09DdHJEVDNGV2tGSnFpZisxc014dkhMY2Ra?=
 =?utf-8?B?QkZ3UWwxUExxbGtENTZ4b2UvVERKNGgyYmxqODVaZlRDaDhLR1pGbFpuY0p4?=
 =?utf-8?B?cEZtNWJ0WnJzcnZOcHBJek5aOE53SzlPK3d1NjE1SGZmUE5ld0hFWXN3NXhk?=
 =?utf-8?B?aEpxZUJWVG1teXRJbkUzTlVGMjZudUhNNXFNTmFUbjBjK0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFBIdFNqR0VOVC9IYlNIZ3JiMEZaOUpzQVptOWNJN0lxcWY2RmZKMWpHL1Av?=
 =?utf-8?B?dHVhTzFsV1oxQitSZUhzOFNld0pXSUppQUx0L0FqTTd3WTZkc3J0K05sRVJ1?=
 =?utf-8?B?ZmF0b2ZDNytUTjFlWGovUEM2blMyMjkxYWt1M1MyOWllSGdMUk1YaTBzSEVB?=
 =?utf-8?B?akltSDc4T3E1TnBPUkl2eTBCVmduSnowOGthUkJRYUtWWUVOMWZjYTBSYlUr?=
 =?utf-8?B?OThrZ0puWW9xRmNQekhxWTZ6T1lhSzJ2TEZzM2tFbnh4TlJpU05SRkNnM0I5?=
 =?utf-8?B?UTJBaGJteW1BMDZMa3c0bUpiYnFiclpYT2NCS1NOdmpZY3pFTC9NRjNsMkpC?=
 =?utf-8?B?R2VDaEhjd1ZTblpWNEZpeXI1R3d0NjJxS3FjUDNFT0QyOXNTSFRDNkhFL1la?=
 =?utf-8?B?VHcyYzR2MjlTOE52Y2xqN3BSTk4yUFdEeGx5bE5vSDlucndSTE5NMTFLdlo5?=
 =?utf-8?B?bDB3eTc0NFQ1T3AxNWp5MURDRUova21aSFNqWE01ZzZSN3BqWG8wZk1yUlJN?=
 =?utf-8?B?cEZIbnpjOWRqWHlWVmV3ejk5RW9GL2xYU1hMQjVZK0kzdWppdGY1YXM5K3V4?=
 =?utf-8?B?d3EwS1Nqc2xsdS9EUTdCVEdBaktiMElxNUxXb3ZnQSt1bklPcklzN2p0V3F6?=
 =?utf-8?B?T3UyZFFPaHBZVVVuK2QwcmVFbTA3aFEvNnNWVHNiRUE2VGNBa0ZOa3RYV1Bh?=
 =?utf-8?B?UXoxV2ZSRXlZUy9XMFI1ZXdqeldDZHB0T2pBMHQvS0Y2c2hHaUM5TDJqYVc3?=
 =?utf-8?B?MncvdEh1bDhQSlhzTW94VW56SElZSkgxZ0pqRTIzcUJ3Ui9vT05JMlZMOXNh?=
 =?utf-8?B?VVJNVm5tczJtSFZQSHpGKzNqR2FjaHVtdnAzOGlyR0pFR0taY0VsUjBvQmNB?=
 =?utf-8?B?SnhJbDlRSk1vZSsvTlFoc3JScXpkdVl6eTZZc0xnNVc4cHVtek1SSlRqcytC?=
 =?utf-8?B?dUVzRlE4S3BxWVc3VGF0dGYydTdHMkxDTzFQTWVOS0hsVG83WnNPbjNZM0s4?=
 =?utf-8?B?czIzS3hWTDhXZ1hWTmJveWt6dURQVnJKRSs3VHJLcmp3YitRODM0V21oRk5U?=
 =?utf-8?B?UVpWNjdzbklSaURqa3FsNjlSYU40WjBtU1FYR1V2R2FyNzMyT3AwV3FxVVpI?=
 =?utf-8?B?WVVHNmJEa1oxT0tLdm92SFpMVnY2NVk2T0duY051NjB6TTROZXpXVWJXMEI0?=
 =?utf-8?B?R1NyRVJKOHR1SzRBTURiN2R0ZlFWS1dTWlJmZGVmdjkvZVRkSGw4RUF5N0JF?=
 =?utf-8?B?ZEJ6dktEWlp1M0NoK2hyVkhiUEJ2ampjeHhyWjRNQWNJOFo1dEtEYjdDKzNP?=
 =?utf-8?B?c2hQY2piaFNwS1RJbTBnM2J4RGdMZ0xtN3ljSm1uTncyVklyK3I1RFE4Vjlv?=
 =?utf-8?B?RW9IeUJsK1BBamU0NVNsN01DY01iK3hNMnovY2dYN05qaUhZcWVnVFNMenNs?=
 =?utf-8?B?eDRodXRIZ3VMbk96M09mNVdRS3BBRzg1a3BlT2t3eE9pTlRmK0NrLzNxVzhQ?=
 =?utf-8?B?M3pFeWFsSnZQbHBweE1HaitOTFBIS2lVY0RiSnRlTVl4WXROdmhnT0ZiNXVw?=
 =?utf-8?B?V3RITUFHNmE0dkdTYmJ4OHVlV2lSM1RlVDNSd1pCdm53eEkrRXhCUVM0dUQ0?=
 =?utf-8?B?NDZiaEVKSFo0OE1EYlEvZ2RlamFNaHNabzVOYTVFeVBFYkhTQllQU0t1Nm5L?=
 =?utf-8?B?aDJnYTFZNXZaQmxzQ1JNWHZ5WlcyUWVVeEF1bmJ2ZWRGWTl3UERVTENYV0xn?=
 =?utf-8?B?N0NqUkJzUkFQUkQ5VGE2QXBqWjFYV0pRdmQ0SWV3SElyMXc2cCsyRm14ZmJ0?=
 =?utf-8?B?SFB0SHJnRDI3S0R0cVl6allIbFFJM2FlZW9iME1DRWlvQjFnQVNsRWJtSUFh?=
 =?utf-8?B?Y0FuTUhNMlR0YjBaRVFVOGtpeVlZRm5rRlE0RGNFdVVrZG51cFgxeVE4OFlp?=
 =?utf-8?B?ZjJTZHBraDFQMVpqbkdXMGJvelkyaUNuMmg5S2YzWHNOYzI0R0c0ZWZjVVUr?=
 =?utf-8?B?VDlOcU52N1ZEZW5DdHVrK0FjbmRSVXFhbWhWclJqS3pNN1ZYbnJxVGw5QkY5?=
 =?utf-8?B?TzJWTGQ4ZlMwSEEyb0RZRExHVUJkZk5kdUdidGpTQmtRZURoeU1QMzNFTnFJ?=
 =?utf-8?Q?zQd4fHep7Xs/VNg9xraDEKuSL?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358a2872-3f5a-45d9-defa-08dcb79d819a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 11:30:29.1608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oFwQeasFpA1YsFNUMrOVvOsRQXdO/5RvTkcCr6+H/G9vK+vSsyoCMYEVQyhHYWf9JrfklnhW4I23SE1D4LSsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4427
X-Proofpoint-GUID: 4hm9h1BSkMFIUv1pByo1ur3Sk3CXQKqv
X-Proofpoint-ORIG-GUID: 4hm9h1BSkMFIUv1pByo1ur3Sk3CXQKqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_11,2024-08-07_01,2024-05-17_01

LSBQYXRjaCAxMDogQWRkIGRldmxpbmsgcG9ydCBzdXBwb3J0Lg0KPg0KPkkgY2FuJ3QgYnJpbmcg
bXlzZWxmIHRvIGFwcGx5IHRoaXMuDQo+SmlyaSBkbyB5b3UgaGF2ZSBhbiBvcGluaW9uPw0KPlRo
ZSBkZXZpY2UgaXMgYSBOUFUvU21hcnROSUMvRFBVL0lQVSwgaXQgc2hvdWxkIGJlIHZlcnkgZmxl
eGlibGUuDQo+WWV0LCBpbnN0ZWFkIG9mIGp1c3QgaW1wbGVtZW50aW5nIHRoZSByZXByZXNlbnRv
cnMgbGlrZSBldmVyeW9uZSBlbHNlIHlvdSBkbyB5b3VyDQo+b3duIHRoaW5nIGFuZCBjcmVhdGUg
c2VwYXJhdGUgYnVzIGRldmljZXMuDQoNCkNhbiB5b3UgcGxlYXNlIGVsYWJvcmF0ZSB3aGF0IHlv
dSBtZWFuIGJ5ICJjcmVhdGUgc2VwYXJhdGUgYnVzIGRldmljZXMiDQoNCkp1c3QgdG8gY2xhcmlm
eSB3ZSBhcmUgbm90IGNyZWF0aW5nIHNlcGFyYXRlIGJ1cyBkZXZpY2VzIGZvciByZXByZXNlbnRv
cnMgcGVyc2UuDQpPbiBvdXIgSFcsIHRoZXJlIGFyZSBtdWx0aXBsZSBTUklPViBQQ0kgZGV2aWNl
cy4NCldlIGFyZSB1c2luZyBvbmUgb2YgdGhvc2UgUENJIGRldmljZXMgKHBjaS8wMDAyOjFjOjAw
LjApLCB0byBhdHRhY2ggcmVxdWlyZWQgaGFyZHdhcmUgcmVzb3VyY2VzIHRvIGl0LCBmb3IgZG9p
bmcgcGFja2V0IElPDQpCZXR3ZWVuIHJlcHJlc2VudG9ycyBhbmQgdGhlIHJlcHJlc2VudGVlcy4g
T25jZSB0aGUgSFcgcmVzb3VyY2VzIChSeCwgVHggcXVldWVzKSBhcmUgYXR0YWNoZWQgdG8gaXQg
DQp3ZSBhcmUgcmVnaXN0ZXJpbmcgbXVsdGlwbGUgbmV0ZGV2cyBmcm9tIHRoaXMgaWUgb25lIHJ4
L3R4IHF1ZXVlIGZvciBvbmUgcmVwcmVzZW50b3IuDQpCZXlvbmQgdGhhdCB0aGVyZSBhcmUgbm8g
b3RoZXIgYnVzIGRldmljZXMgYmVpbmcgY3JlYXRlZC91c2VkLg0KDQo+Tm90IHN1cmUgaWYgdGhp
cyBicmVha3MgYW55dGhpbmcgdG9kYXksIGJ1dCBpdCBjZXJ0YWlubHkgc3VidmVydHMgdGhlIG1v
ZGVsIHdoZXJlDQo+cmVwcmVzZW50b3JzIHJlcHJlc2VudCBidXMgZGV2aWNlcy4NCj5Zb3UgY2Fu
J3QgcmVwcmVzZW50IGFsbCBidXMgZGV2aWNlcywgYmVjYXVzZSBvZiB0aGUgb2J2aW91cyBjeWNs
ZS4NCj4NCg==

