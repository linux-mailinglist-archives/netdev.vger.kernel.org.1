Return-Path: <netdev+bounces-100048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E75F98D7AC5
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7801F21C11
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 04:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F8101F4;
	Mon,  3 Jun 2024 04:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="aZk9IUpU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828FB17C;
	Mon,  3 Jun 2024 04:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717389236; cv=fail; b=lgKjVoWQoZW7dI5PmP8eElqjzRBOh2eEIr0nO2kLzyU7va4jeOGsO05iKB4k8kkHbNrGXz5OOTMEF5ZMNMzEKjjwSp1joL8tgK3w1/HnlCmTiO6terhjQFNe34Xj3sXdMvNCuF4bLdy/VTGf8zztKkGeuy6uowK+CxxNId1VdtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717389236; c=relaxed/simple;
	bh=gA7/OdTFC6AgU5mbqmG44lyl9N8qg8r7mD5jpMuExuA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f/VmsBVFcb+azSqKJt1+uooz0y4ocfkL1AwB5wbIUrML+lyVMLMz6mZCeOnClaOwXzs83oYzj7E9iyvU79elCTXTxHmdv3V2PhtH7Z2F4owXaR43MjuNHosREk+zox0CltqcUeAz+EkUXxAFkmapzPVe2X8xq3rUgwJzD4Y7o9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=aZk9IUpU; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452Mj1lW026052;
	Sun, 2 Jun 2024 21:33:34 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yg35hbjjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 21:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DM052N6UhpCNN5gsikqDmuvaHGB2AzAH72LFr+SqjBFGrheHTeo1jCQ8r6c8F7z4QKmaMUU2gfmcshPr4T1a50LaidE//XNISAd/TAHlaLbYlYUtjUhSHJFGPLRZdfgy8nOaQ0sF9Pq2SYtbBp4gpBqp1pg0sosJMZWBwnDxXXMD187sLY8aFMijAfxHG7q+lw4ce+ku+ihHkxxqEqdipvw2ojxyCzdpwh6odLLRs5a5kJ8nYeg3FuZXA2sWGUrVT7IqQm5Bsj01NAcsY465iOJmfpB5OT9uMBMYCjujR0Pr+4QQaTD9czmyvt4PPLhhEACWCgyM/I8VxqlQYlBl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fu25R/3sRJwAZ2TzBA6bHk87Ffcngydqc5APoHSQOKU=;
 b=OQFgLLs8JeEG7uxH9jC9Gi6BL5FKoSFjdGTvhoC6KZd5xI7gsb/g/TCfjmAi/Oh1LCN/O1gIKpQNQ6oV5geWjNseDpaX2XogTys6E3zAVIuSPZTnUitvB1PPZCL5oeGOL8etn8lGmXW0zt8iC7XzQvIUFitQcUWZEzl14y6RNJaa1m86o9waaOD5V8/M4fWP62Jne36oPkQnwp2aDMWQKoafTKtb7kHAwrFK+wOwCbLGAF0lu1PuLwCwsxbUH68AJDHqJAz4+lYLXrudnEcnzrdf58FGGOB8gkkG494n1G6cxyYeAhWlPhNs6J7oz22plxAgXhJQwTkEfeHJmQLJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fu25R/3sRJwAZ2TzBA6bHk87Ffcngydqc5APoHSQOKU=;
 b=aZk9IUpUCtpVzbvFfeH3JaFPmY4EL2nc11U6+luszUzoE+xhgfBXc7Ro3iVBUEo/dpCFPGOxGT0DAOOnIYxsjK+30HSGza4fXIp0SW1ViNKIx+LejixBuT7qaXhC7eL4SHSDEyN94A38BE1K3DRfmbzjWZXzCn6AqW0Z2B+yYtA=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by LV8PR18MB6200.namprd18.prod.outlook.com (2603:10b6:408:269::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 04:33:31 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 04:33:31 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Leon Romanovsky <leon@kernel.org>, Bharat Bhushan <bbhushan2@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geethasowjanya
 Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Jerin Jacob <jerinj@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>
Subject: RE: [EXTERNAL] Re: [net-next,v3 6/8] cn10k-ipsec: Process inline
 ipsec transmit offload
Thread-Topic: [EXTERNAL] Re: [net-next,v3 6/8] cn10k-ipsec: Process inline
 ipsec transmit offload
Thread-Index: AQHasQaTGOI655GPbkyOq/WYx7AM5rG0EIWAgAFrXoA=
Date: Mon, 3 Jun 2024 04:33:30 +0000
Message-ID: 
 <BY3PR18MB4737F1C148F2C230A4ABC49CC6FF2@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240528135349.932669-1-bbhushan2@marvell.com>
 <20240528135349.932669-7-bbhushan2@marvell.com>
 <20240602065125.GH3884@unreal>
In-Reply-To: <20240602065125.GH3884@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|LV8PR18MB6200:EE_
x-ms-office365-filtering-correlation-id: 0fb4beb3-6d73-4902-3010-08dc83865259
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?8/zq4amJAS3Q/NBcPFMtLh+zUjGAtrti4BT0PbcjtqEBTdK0rwg0I4yU4zNr?=
 =?us-ascii?Q?VHYZ21lCJ1j1ZbAa/3hYHTuILhREtf/2Aq7s6a3jglNXsyYuDw0gL54YSRsu?=
 =?us-ascii?Q?8756arPmWHTub4lCKb2N11PBjHFtKRbC7vM16SGihnLMukmFqlH4pR1OCQXu?=
 =?us-ascii?Q?tYDcXxJfFZcU4NOTOuj4r09Y89vG1GCVY0WI9llDmn0lMoTODs9440XuX904?=
 =?us-ascii?Q?29QdawBAJm12TjI8tjl243OR1CKlUf+Sh7wPEY8ZN4O308A83JVmP9QSdkeM?=
 =?us-ascii?Q?/C2ZvM4rN2LC/62ezf3HTNIHNzm+eCH5dCSmLwY+BzW1PEi9zekP3AtcBB0Y?=
 =?us-ascii?Q?fFb3HLb05ibv3P7Q0gPw+2AjSA4aMa26BgtrpQ5+skOO2Ew3JLM4BRQMuZ45?=
 =?us-ascii?Q?OnNfyrOJHE/CAtjjkt2aMkxdTdBTtRTaRLjagn+hDR4iTODkqD1zwLkxUYtv?=
 =?us-ascii?Q?6J9qDmyENaFUSkye7GcI+qNQ3ArlJG6hRnCgESlH6YTxJtJ836K+IdSD1vUO?=
 =?us-ascii?Q?+v+mibpJH7BujihNHicRfdGHIs9Tm5PLySSvfR1otg1yK97k4zLK8k+lkB9X?=
 =?us-ascii?Q?VAd5Jy1V21lFc7YA9CFRb3b4a2UCgsEI7GE/vsAsos5/B99gouUhnk9wOCQB?=
 =?us-ascii?Q?tE+jpr0avbKCDvVcazV20krzj4ukjo6/msEGjHQOrPVPmb26BOyT4BPvyuhB?=
 =?us-ascii?Q?eIanozkDyy0EONLf/fxkLL+6R0wMSRo+xVaa99IKoMFRD8VtkydT2D5vFipx?=
 =?us-ascii?Q?eBF97kpSpD5HY7IsUcOI2PvmGc+t617eAijM44Dj84FMuoqnUqjUXFE1fp1R?=
 =?us-ascii?Q?5p/rVXGZGDiUJaCriOz2EFagIpcPa3qttvAKY0FvLedv0RteDSAGmN7hnDKS?=
 =?us-ascii?Q?fByP4lwutaPxFbMLm4QpFt/1cx8if+Jb1uYXnHfVA1qgMZSVmaUjT+PX4nZf?=
 =?us-ascii?Q?teVBqptU6mHzwl91MK+FTDZ/Ea0O4rYHpS3CHLJAeBRCxnvZ8+d7iYlfA9oG?=
 =?us-ascii?Q?aK/AIgChXZS+5S7GJQnLQKLjSSF+ZlFZ0NJhhzRqf7KRhFnOLxxaGLLlVIR4?=
 =?us-ascii?Q?zcFaJiU9OdrTdOLe5P81pfDVbgRy8LHWblZ0hjyXVzfpE12QuQvf9EjPDYPt?=
 =?us-ascii?Q?rqRzGRpOo2kYgx/4FDHhGFYIpTo4XlMj8VLO+Uk3eHlS2LvBgQoT9Pf2ePCN?=
 =?us-ascii?Q?vkNn7pzIXuKtXqgcQJ0/FVaTrkUmBJBSHXkFaDuEA7fomfgVHoX66qu+dYsH?=
 =?us-ascii?Q?hJqHaNxdl4VjUQToNZKxvRfP0xvPmDB2O4DDPafv8pM2CifFzzlrtSNfuCJi?=
 =?us-ascii?Q?vD0BSIjttwtVIFR6cSXGLwx51w+lNolKe19uR9U7DC6dqg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?XcOdWirqd9fw+kmX0+P9aBYfNU3t+V4ZXyozWUS9jSRo9yB3RVRXsF8d7UUj?=
 =?us-ascii?Q?2j+aF+jj+yjiCIAhI4eRQb1Q38LNmlfRjNko+Bi/SQUm5f9OC5FdE0AYhUK0?=
 =?us-ascii?Q?HArFFN3bYeEA6W71+sHvgZ1CiN4dUMUDLtcMtAXW8WzMIa10lbEL6cNsDxBi?=
 =?us-ascii?Q?DXvBeCsWKBau4Vr9oEYy2F0lEi4di1dzYV9Q8hjBYS/LLZB+2aNtnAGRZ80K?=
 =?us-ascii?Q?jqMJCLRpZ2zZChLBL/1bnd69e8LasXsUM7DsIZIV7uK/FO/jIBSM0C4N8c32?=
 =?us-ascii?Q?luAAyvAW7k2PhzhCJMEHgp3x/aVWs7F3vpKz10Z68vv8d1llZQK7obhDO3Bt?=
 =?us-ascii?Q?zNOM6iu6EvkJ1aG3qO8WvKOeaCxzzSem/YRY+40YIot1dKTjBkubrxyfv8Zj?=
 =?us-ascii?Q?x03cmXBtIrOnywwdc0j6eStM845PuLwh80cbRubkkmFBDLwFvPGIfIZ7PSXl?=
 =?us-ascii?Q?iUWRC6e746gfwoZnIC5hBDcXc1ExWWjDntd/k9T/JaHCewAzfCuODJ0NZFyh?=
 =?us-ascii?Q?xUTXW5cGy3Y+63cNkYq/Pd5cxcy9zBDgYwEFUyIogkwVYZMIwsnLsWB48pdg?=
 =?us-ascii?Q?jNYR38q22BvSBFvqrf4L8TBx6Cv041r/Ws4xvUWRqHZmvumELHV/bGJ0gnBj?=
 =?us-ascii?Q?Rwakkg5FGJLW1f4BTm92zR2H3QVGlDQ1J7sEhJrA+qne57YBfgGH/MyzDVyX?=
 =?us-ascii?Q?7/DAA4WnfoGW0+WEZk2D5aljJmmAFtvTQ5nJoX4GnpjnlT5OXyduwDrsKgV8?=
 =?us-ascii?Q?bm0SyDOMUkAMKAOBlcQ6B46mmy8TMwScgP31lNFmveV8TD5yQuNsgEo3hP6x?=
 =?us-ascii?Q?BPkapCUIt4GdYWWBRjYeXTEMj4m2lP75lFbnjn1Zg3/xnGQkoHIfzDpRGmDJ?=
 =?us-ascii?Q?Yf0CmVKzr3ner+3YeY/IdJSjYfzQJtGB6q455v5nxgpWHLgUgfEQFh1LvnMd?=
 =?us-ascii?Q?jQyDVx6F+gKaGAPV3lp6+UjeFqa20BvvSdzTEmmnu1vnIsX3+Z0Npoxax7Di?=
 =?us-ascii?Q?OYBkgOaS/DGRjh4RwbibBTi62Dhcze2DYCf+objlJ/pyYUQg6qufm7lYkHK9?=
 =?us-ascii?Q?r3384LTGllkNYUCWNmz5RVLkZ0C7/4Vw6RBWNvqBrw0gyKUcaS6bAdamxGnx?=
 =?us-ascii?Q?vFPrEf5KO3BT1x71RE3jQ2v+AqzMW2x025v77N9QZNUzatbXFYv02vztkmZV?=
 =?us-ascii?Q?qIVlOlYkfyzXiDyXSTcrXJ1AeXdnelKU9OqKDHMpHb3uqNQiv/pvcR0LtYVu?=
 =?us-ascii?Q?43HuApIW7ooZYSFwFujrF9NSbXvnOH+H5k2rVdtIGjDWCQW8C7keK/5g27ZD?=
 =?us-ascii?Q?lwePnTpRT9cubYcgqdDjwe8xjsIi7M1IYHba6Bo5h8xb9xeQAvuxZdx3lsgJ?=
 =?us-ascii?Q?//uOjvMlRABX3JNlsix5/Eq4GdxuGOJRA+58NnxHRzdKEwktlFmJVUImYXU/?=
 =?us-ascii?Q?XJ+4T3RhMeLJnlxaWRrSKW+rgldzJomYf5YBDNt/5NvUiW0xhU1sysvd5f+O?=
 =?us-ascii?Q?30D4VsTAhndm5VhCOtKIh6TNdkQp745txoMhtoMV8MZ34vd3OT+wqtRryDoy?=
 =?us-ascii?Q?V/84dzkMgH/Mosbl9ktKYk43BYTis16WB/wzLcgJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb4beb3-6d73-4902-3010-08dc83865259
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 04:33:30.9737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iz0jpL6p2y06I03qngaH6jT8zrlWdjZ+hvZKw8iiBelT0EYw9Ep0GlajchD+mbyjbsGZ7mUwTxoYgOaPj0xLEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6200
X-Proofpoint-GUID: jE4dma4M42yd-JXu5hVcsSpGxGF7RkiT
X-Proofpoint-ORIG-GUID: jE4dma4M42yd-JXu5hVcsSpGxGF7RkiT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01



>-----Original Message-----
>From: Leon Romanovsky <leon@kernel.org>
>Sent: Sunday, June 2, 2024 12:21 PM
>To: Bharat Bhushan <bbhushan2@marvell.com>
>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
>Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
><gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
>Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jerin Jacob
><jerinj@marvell.com>; Linu Cherian <lcherian@marvell.com>;
>richardcochran@gmail.com
>Subject: [EXTERNAL] Re: [net-next,v3 6/8] cn10k-ipsec: Process inline ipse=
c
>transmit offload
>
>Prioritize security for external emails: Confirm sender and content safety=
 before
>clicking links or opening attachments
>
>----------------------------------------------------------------------
>On Tue, May 28, 2024 at 07:23:47PM +0530, Bharat Bhushan wrote:
>> Prepare and submit crypto hardware (CPT) instruction for outbound
>> inline ipsec crypto mode offload. The CPT instruction have
>> authentication offset, IV offset and encapsulation offset in input
>> packet. Also provide SA context pointer which have details about algo,
>> keys, salt etc. Crypto hardware encrypt, authenticate and provide the
>> ESP packet to networking hardware.
>>
>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>> ---
>>  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 224 ++++++++++++++++++
>>  .../marvell/octeontx2/nic/cn10k_ipsec.h       |  40 ++++
>>  .../marvell/octeontx2/nic/otx2_common.c       |  23 ++
>>  .../marvell/octeontx2/nic/otx2_common.h       |   3 +
>>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   2 +
>>  .../marvell/octeontx2/nic/otx2_txrx.c         |  33 ++-
>>  .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +
>>  7 files changed, 325 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
>> b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
>> index 136aebe2a007..1974fda2e0d3 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
>> @@ -7,8 +7,11 @@
>>  #include <net/xfrm.h>
>>  #include <linux/netdevice.h>
>>  #include <linux/bitfield.h>
>> +#include <crypto/aead.h>
>> +#include <crypto/gcm.h>
>>
>>  #include "otx2_common.h"
>> +#include "otx2_struct.h"
>>  #include "cn10k_ipsec.h"
>>
>>  static bool is_dev_support_inline_ipsec(struct pci_dev *pdev) @@
>> -843,3 +846,224 @@ void cn10k_ipsec_clean(struct otx2_nic *pf)
>>  	cn10k_outb_cpt_clean(pf);
>>  }
>>  EXPORT_SYMBOL(cn10k_ipsec_clean);
>
><...>
>
>> +bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *txq=
,
>> +			  struct otx2_snd_queue *sq, struct sk_buff *skb,
>> +			  int num_segs, int size)
>> +{
>> +	struct cpt_ctx_info_s *sa_info;
>> +	struct cpt_inst_s inst;
>> +	struct cpt_res_s *res;
>> +	struct xfrm_state *x;
>> +	dma_addr_t dptr_iova;
>> +	struct sec_path *sp;
>> +	u8 encap_offset;
>> +	u8 auth_offset;
>> +	u8 gthr_size;
>> +	u8 iv_offset;
>> +	u16 dlen;
>> +
>> +	/* Check for Inline IPSEC enabled */
>> +	if (!(pf->flags & OTX2_FLAG_INLINE_IPSEC_ENABLED)) {
>> +		netdev_err(pf->netdev, "Ipsec not enabled, drop packet\n");
>
><...>
>
>> +		netdev_err(pf->netdev, "%s: no xfrm state len =3D %d\n",
>> +			   __func__, sp->len);
>
><...>
>
>> +		netdev_err(pf->netdev, "no xfrm_input_state()\n");
>
><...>
>
>> +		netdev_err(pf->netdev, "un supported offload mode %d\n",
>> +			   x->props.mode);
>
><...>
>
>> +		netdev_err(pf->netdev, "Invalid IP header, ip-length zero\n");
>
><...>
>
>> +		netdev_err(pf->netdev, "Invalid SA conext\n");
>
>All these prints are in datapath and can be triggered by network packets. =
These
>and RX prints need to be deleted.
>

Yes, all these error messages in datapath should be under netif_msg_tx_err(=
).

Thanks,
Sunil.

