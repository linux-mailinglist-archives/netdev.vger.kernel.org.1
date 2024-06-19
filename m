Return-Path: <netdev+bounces-104846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D882C90EAA2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C703C1C2195C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24113F439;
	Wed, 19 Jun 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="AxNVuiNr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBE79950;
	Wed, 19 Jun 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799374; cv=fail; b=r5nhzGGm3KXPQI/SkeC+vXRddEX+OYhb9swJwIlpA+Us4+O+uqLvATueONf/Ki6fip3OQnUd3X1G2/Qkmo7tfxZRY1Sw+wK1/Ztac+H9A52y8umOiW+omjFeLCdFjpBdTSKt2amfKH6pAIkvT1nbRUEZDWgPEeTthHw2Yy06fOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799374; c=relaxed/simple;
	bh=YFxjHORVS+kZr72k6DSe6AiacEj2A4nvsFgO5rCIWfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ddCX2rD4hGEv7BpZOtzzayw4IhU0VS9q0MjzSW/25mjGvixadbDhwQAjx5qiT4emaLue5juoR11V6/GGKuTtahaKmUeHm97T9v7B5rLXPigSFFs7yXcV9DG6xIRTotbWp0hzgkYEelTdIcXayK87pVrF70HOpDy3VAMKQc9thms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=AxNVuiNr; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9lNJJ012356;
	Wed, 19 Jun 2024 05:16:06 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yuw0jrexn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 05:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWRvqrti5beCqs8TtMmstSykiuxwakjavFn+226rAIewJMZKo518Yu8VUHypxCf7RYSkJnhsFoyl8hfcW45zw5lmJ7HefjlvNcfd0QEmWC1erLgmzY8xgID1yGLhf6pk30qMa16zN1agv7Z/q5wLhKlSlW6xK7ImjbuQWPZpw6Bk9sqz1lDrjtzBCwkLRQMhLU8fr1fl5V8WzGhrZoCbpYaBkRULYnsXdpMDcfPft5n93d7eiV7Tfe3+D/8vIAH5EDzdB0/XGnSAdaLS2h2OdLmWBeBmREv5wO0uvv56R7e0QF9mD5D7VAjoubJjKiAfB0Ccl9XmgwX9lKHF2i50kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFxjHORVS+kZr72k6DSe6AiacEj2A4nvsFgO5rCIWfk=;
 b=lJz+/kQ974uj/40gP77sQcbpdwep5nA/99CfJUw0XpZwtxIzjfUcaMtf08MZ4SHowklOSC+1dYyEWCQfNJQtkDAkMP/soSHyfE9P6W5ph5mJ52R4ma3c2QCD0BQE7Fp7rGYKB0pvGgPe1cWvmZCNReB4g6w4ggWYvRn/XYVf2CB9kiM4oFfxKI9dqrl2areE7CfrbEBVW9zhQORqPuNvtmOgZO7moONUCldxOjy2WLcbWEjWCKwcyrXL+2sivP/DCSlSwdfcodnL6tb0wYBYk6tkRJ1yCKK1r0MXpo3suOaXGOIrj77f9X+awIOHKcREDSIPYKX1RCZYmncdcL7Evg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFxjHORVS+kZr72k6DSe6AiacEj2A4nvsFgO5rCIWfk=;
 b=AxNVuiNr56xgNhR7B/s9F2U3dNLZ6NkdNVVKzBjr8hX0dItbrVVuSIvSr5ENMVw1Fu/aXB9hN52hwJRDfpAppFxceM9GuDfErFdvO8JdMF+q59NX1gqyJ2KtyHrv+fhSFTljDjqVaVnsm0EFrDMTtnC67Mbogf0k7WVgicsBfYU=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH7PR18MB5058.namprd18.prod.outlook.com (2603:10b6:510:15d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 12:16:03 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 12:16:03 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Simon Horman <horms@kernel.org>
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v5 05/10] octeontx2-af: Add packet
 path between representor and VF
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v5 05/10] octeontx2-af: Add
 packet path between representor and VF
Thread-Index: AQHavBuTWN+nHIvjKEWvGupW3SJIKLHNPZ6AgAHNiRA=
Date: Wed, 19 Jun 2024 12:16:02 +0000
Message-ID: 
 <CH0PR18MB433918F2923190BCF090FAB7CDCF2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-6-gakula@marvell.com>
 <20240618083839.GE8447@kernel.org>
In-Reply-To: <20240618083839.GE8447@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH7PR18MB5058:EE_
x-ms-office365-filtering-correlation-id: de332bbb-1be1-4dd0-598d-08dc9059966c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZmJ6UG9NNEl3SEllWGp2eGRJM2gxWVlLTEJwUy8wM0l4TnA2YWptSmhrZ3E5?=
 =?utf-8?B?c3JTR0tWRXlvQlB3bCtjV2kvVlBMTW5WM3BHUjFnS0M3cTg4Q1BzRFRTWjhS?=
 =?utf-8?B?alJGbHJFNGlJRitheG14TUxtRERHQmFtK0F2a2EzOFdJZElkUnArT2pUNFdu?=
 =?utf-8?B?VUk4U2lrTHJEaVZLZFRuemNNNktLZ3FnWTdJbTlOQ2VNR1BzTjNhNFVrcTQx?=
 =?utf-8?B?MDdGUEl2TkFCcDRYTmRjWENndUlFazduYUQrcnpKa1hGNk1rZ1hSRU1TbUpM?=
 =?utf-8?B?TjZZMFVrNUNnemRTNTFoa3Q1ckhBaHJNLzM4SUlQWVdhU3h3dkZublIyMkN6?=
 =?utf-8?B?cE85bEhFbzFOSUtGRG5Gb0J2V2RlNm9ablhYZ05CREFkdWxBR3ErSkdxSGJZ?=
 =?utf-8?B?QWQ5VmswL09WVGdXTVNuQkJyL3o5aGh5SVFFUzZsWDNiYmQ0MUJXZDRUb2RJ?=
 =?utf-8?B?OTZ1Y1cyRkgzUTM5bUFFZytKZnVqMi9CUDhkRjZtYndLcUxiN3RuRDhtS2tK?=
 =?utf-8?B?V1pLVGRTb3doWS9FSXVnOC9hNVpHWTlHUVZXRnh5SEJTS2tmUUJmMlVHR3BS?=
 =?utf-8?B?UXlGaUNqaE9NTWQ4bTJZTnN2TzRDWVpWT2NHWGlBN1FabGRXd054ZWJLUzNS?=
 =?utf-8?B?ZUlqN1lPWFplNm5PK0FyNnd2b0NreTVCQ3Y3QXlLWTNzek54dHVmblViVkky?=
 =?utf-8?B?ZnNmcTdLazhYWVVnYUpGV3pBVUdzYUorVmlyMDZRd2NIMG44ZHBGWmpzdWJo?=
 =?utf-8?B?bnVjbFpUNVZheVA2VXFmUjc4NGVxUEZzWTR1YU5LZHh0SEZIZ0NyeEtPT1I0?=
 =?utf-8?B?YWN1c0NqU1NzWSsySnpicjJQVGtmZE5waVFzOW4zV0c2WWQ1OUpQaFp2OXV4?=
 =?utf-8?B?WHo4MnVvY1c5cXVOanU3dno3OFpORk8zc0pGNThqM09taUwvQXV0aHdxWjNh?=
 =?utf-8?B?VTQyNFNOTjlRZ0kyS1VHQW9VamJBY3FUR2ZPc2VZUXZwZzRFR3ZKUXNhc01j?=
 =?utf-8?B?N2JKMUcrby83RStHQmkyQzhWcEFrNm1qaUtEdXVFcEtxQmFLTXlqQXI1ak5i?=
 =?utf-8?B?VXpYQ2FHSVJVOG1LQUVqd2lrMjJCWDlBUS82Mldmc204VG8wdFpSRC81TlZp?=
 =?utf-8?B?Rlo2WnNmUnJWVGlYUCt2dVNQelBWMWFrSTkvS1hIYktDRE5CVXB1bmpjUXVn?=
 =?utf-8?B?OFlnLzB2QkVBd3FRMEM0UlYvSzBnV2ZDUkJEdXZxWlY3azdWaVlpWGN6aldC?=
 =?utf-8?B?U3NDQ3l4V2EzMTlUTDNCU0lyYVErTjVHVUpmek5OQzNVTkJvR3JSZ2VoUisw?=
 =?utf-8?B?ZjhUVVZuYkVEK1NZdTJIZ21aOHAvbUpid3RqMWtQUEg4N2Z6UnZrTkRmYytx?=
 =?utf-8?B?Ymx2QWNHbDVaUjB3UmtVT295VDJOMDhmZnp1OGxSejE1QWg5VGpSd1ZGZ2F4?=
 =?utf-8?B?R3VqdjdYejN3dlN3MDlJY280RTVtWGxNZTljc3BxN0hYQzBsZDBJMWRoaW9E?=
 =?utf-8?B?K3ZHbjRINUNFdmxFejNwZVkrcEpRU0dES0hiTzFadTFFRVV5ODFKUURkSG1W?=
 =?utf-8?B?VnlJcGlvSzNTUDhISGkyNHl4eW93QXJiaE9mQkRMVVhrckJhNnpWRzk2N3ZP?=
 =?utf-8?B?S3M5VjgzdW0wU09WekhkV2l3bDdPcTl6dEk2eEhoYVVFS0IzZTBockdobXNF?=
 =?utf-8?B?OVRqbEVrSFNtSS9KczA1WmdMYTFjWkREbG5uMnpLK3lVTnBKRE4vN2FMNEYx?=
 =?utf-8?Q?TSxvZuDPe/zEN2UGWqADjIh7atfvWQCBWoc0uu3?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MUl4MlA2dnhxa2VIcHR5NXNjWG1tWnp5TzJLcmozZC85VVZsTFA3ZHFHRkJU?=
 =?utf-8?B?ZVR4V3VFQjBwOG50WjVqR2IveXVrbXE1c2tLOHVpTHZZc1ZSbjNnb2NiWXJN?=
 =?utf-8?B?Tlp6bEZUSHdwU1doaFRNL1hnYS9ybjRzOWtHQ0dBVFZiNTB5cXpJdkErSkU2?=
 =?utf-8?B?M3dmS2EzUU9kRjBZendIL0Nldi8zeWxVeCttVmFwYkNNVFREL1M0Z0NIOGFr?=
 =?utf-8?B?Z1RCQzBxR0Vja0dZU0pCWWZyTldxRSs3dU5kaEN0N2pKZlRhSU1EeXB2WjJm?=
 =?utf-8?B?ZUxkUjAxNmVvaE5hUHJ1R3g2N09IS0FycHJTV203Vk1EeTJKRDFRWGFkZE1p?=
 =?utf-8?B?TFhZSWc2VFJ0SWxZbm9qM0lXNlMzS3I0NndmTTV5VE1nK1QxMmdsQktRLzRx?=
 =?utf-8?B?elo2a3FIMi9MeXdUcTN2WDcrV2EzLzExUkQvTFNGaExkTDNJQTN3TW5mdVJs?=
 =?utf-8?B?ZG16d1FibkVaL091S2lMbHM4OExyN0JjWFlQVHRrN3Vib2hTTS9RK2xaV2dB?=
 =?utf-8?B?NmVmK2pYbWZaNXowdGIvUmxLMTNDTlZ1bFJNSFhacDBHWFRjYzYxdmxoOG5a?=
 =?utf-8?B?MmtlWWF0TFVtU0FVVEwrbjF4R0thcC9iclRTWFY3WEEyVWZEWVBDbXdVRkVr?=
 =?utf-8?B?OHRvTDc1M3JKSWE4YnNZZjZSU1dMaG5iSE5ZR0VqSGlaaGxKSUgyOTdmNEQ1?=
 =?utf-8?B?bmJrWlBpZGlRZ0FBdTZQamdDUC9pK25MSDBIRHlub21mT2JjQVpKTjN4WEtm?=
 =?utf-8?B?a2hUN3pVZEp3c3BZVGlxeGEvZWF0bk5WcnduMVprMzlSVEx6a0ZUbFg3aDVQ?=
 =?utf-8?B?aDVqVFF1MHRNZ3YzZ3RaS1Y4UzJXdllEUittZDIrYVNiVGlEUXhFQVh3VkdJ?=
 =?utf-8?B?MXRydGNiWEUxS0psajRSQXlVMzlFV2wzZkVqUnlyOXJwWmJBTzE1Tk05TWpo?=
 =?utf-8?B?d0hmZzd3a0lNNHFjQ2V4NUsvUE5nVTJ2L2hsMmFxWkNPSHhaRitXc0ZyWVNL?=
 =?utf-8?B?YU0va3dyZ04vdUFrZHUxUE1obnpVY2JKaW9DZDc5dzJQWWRRZ3R2c0FYNGlh?=
 =?utf-8?B?YTdwS3hWWi9tbUZBdXBmblNUTGhxb2xoTG5vSzZwNWNraXZmRGIwejR4SlRE?=
 =?utf-8?B?YWdVMmw4ZVlpVHpjS252YUhMZU1KLzkvUDlZSk9LNXZjUGptMTNyaHpZUXZL?=
 =?utf-8?B?eUcvUEJEbDBYSDFLTUlEV243d3daV2dKN1VYaVMwbHBRVzZuVEVaVFdUVXll?=
 =?utf-8?B?Zm1iN3Iwc3RKb08xMi94aEtkNmVIYUlaQkxVUXovMm9FTFZKVTV4U1BLankr?=
 =?utf-8?B?ZDhaMURyckptZWQ3Wk1uSFo4THByUnNzcXpIRFVpaTNnUU1vTWRnaU9nVHhB?=
 =?utf-8?B?bi9oQ3NJY2NqK0NEdEluV1I4aVNKUlIrV2p5K2ZKN3BpYjZKSWhsOWxEOFFl?=
 =?utf-8?B?alRXZ0hhdUVnK3c2SXd1MVBLWlJVVmRXeW51aGllS2FWVDNCVHQyUlpodTBv?=
 =?utf-8?B?NWxLZUNqSDdCSklRMUtYM0kydUtpblc3SW9selhrMHZOaTQyWGc3WG5wcWcr?=
 =?utf-8?B?a3FONjkrbmVvVDZZN3JTTEVXNmRvbUgxdzBxenVqZFg3VG52bG1saC9YVVdu?=
 =?utf-8?B?aUVBVkVvaUV0amNyVmpuOCtQYWE4M0VrYTF4dTdpYmdOTXBiVElrTmVWZXZB?=
 =?utf-8?B?aEwxOVM1WFptd1VWTFROY1BrbnowOHUwL0xOTE5hVGEzM0Yrb3FPUVVlRm5W?=
 =?utf-8?B?UlE5MFI1Q3Q2MXZ6eGRlbzNTR0VmbE5waFYrdkhuODdKNllUVUpFSXQ2ZFlJ?=
 =?utf-8?B?QjV6NXRtaGNGNVVqenBQSjVLTHF3aDhJVGYxR2prUkM3Q0oyUlNCM0dxd0Z2?=
 =?utf-8?B?bFVJdkhWN1l1Z2Vnc1B0YjdmQmZobW1NR1hycE56ZWlsSmRVdXhmVjRjWVJo?=
 =?utf-8?B?bUtrbG1MUHp5WUZCYXRIU0h2b3AyeUM5d09oNkIwTkJ2WThXSld1b1pvOUdS?=
 =?utf-8?B?N2YvVkNscnFCV0t1K0M5V1VHc2M4eUdIblkxaTVZMXNnc0huMXFZRVJubFdO?=
 =?utf-8?B?amkyNnFGNC9GbGlOcCt4MmRoQVh5VEtibHF3dnB1M1BRNDd2aDNkWjJFRnJk?=
 =?utf-8?Q?obgg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de332bbb-1be1-4dd0-598d-08dc9059966c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 12:16:02.9831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0rzi7qUKnwl02QI3jjopvgFl0HzduLf/pQEOmCyoPakfBDOEG2OpXerdMB2OdgRLhUMzACw+4pxKezmIXS5ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5058
X-Proofpoint-GUID: es_RuLxS0FXUI42Bji4litzJTSEfPTFt
X-Proofpoint-ORIG-GUID: es_RuLxS0FXUI42Bji4litzJTSEfPTFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

DQoNCkZyb206IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4gDQpTZW50OiBUdWVzZGF5
LCBKdW5lIDE4LCAyMDI0IDI6MDkgUE0NClRvOiBHZWV0aGFzb3dqYW55YSBBa3VsYSA8Z2FrdWxh
QG1hcnZlbGwuY29tPg0KQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGt1YmFAa2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgcGFi
ZW5pQHJlZGhhdC5jb207IGVkdW1hemV0QGdvb2dsZS5jb207IFN1bmlsIEtvdnZ1cmkgR291dGhh
bSA8c2dvdXRoYW1AbWFydmVsbC5jb20+OyBTdWJiYXJheWEgU3VuZGVlcCBCaGF0dGEgPHNiaGF0
dGFAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+DQpT
dWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbbmV0LW5leHQgUEFUQ0ggdjUgMDUvMTBdIG9jdGVvbnR4
Mi1hZjogQWRkIHBhY2tldCBwYXRoIGJldHdlZW4gcmVwcmVzZW50b3IgYW5kIFZGDQoNCj4+IEN1
cnJlbnQgSFcsIGRvIG5vdCBzdXBwb3J0IGluLWJ1aWx0IHN3aXRjaCB3aGljaCB3aWxsIGZvcndh
cmQgcGt0cw0KPj4gYmV0d2VlbiByZXByZXNlbnRlZSBhbmQgcmVwcmVzZW50b3IuIFdoZW4gcmVw
cmVzZW50b3IgaXMgcHV0IHVuZGVyDQo+PiBhIGJyaWRnZSBhbmQgcGt0cyBuZWVkcyB0byBiZSBz
ZW50IHRvIHJlcHJlc2VudGVlLCB0aGVuIHBrdHMgZnJvbQ0KPj4gcmVwcmVzZW50b3IgYXJlIHNl
bnQgb24gYSBIVyBpbnRlcm5hbCBsb29wYmFjayBjaGFubmVsLCB3aGljaCBhZ2Fpbg0KPj4gd2ls
bCBiZSBwdW50ZWQgdG8gaW5ncmVzcyBwa3QgcGFyc2VyLiBOb3cgdGhlIHJ1bGVzIHRoYXQgdGhp
cyBwYXRjaA0KPj4gaW5zdGFsbHMgYXJlIHRoZSBNQ0FNIGZpbHRlcnMvcnVsZXMgd2hpY2ggd2ls
bCBtYXRjaCBhZ2FpbnN0IHRoZXNlDQo+PiBwa3RzIGFuZCBmb3J3YXJkIHRoZW0gdG8gcmVwcmVz
ZW50ZWUuDQo+PiBUaGUgcnVsZXMgdGhhdCB0aGlzIHBhdGNoIGluc3RhbGxzIGFyZSBmb3IgYmFz
aWMNCj4+IHJlcHJlc2VudG9yIDw9PiByZXByZXNlbnRlZSBwYXRoIHNpbWlsYXIgdG8gVHVuL1RB
UCBiZXR3ZWVuIFZNIGFuZA0KPj4gSG9zdC4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogR2VldGhh
IHNvd2phbnlhIDxtYWlsdG86Z2FrdWxhQG1hcnZlbGwuY29tPg0KDQouLi4NCg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9yZXAu
YyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9yZXAuYw0K
DQouLi4NCg0KPj4gK3ZvaWQgcnZ1X3JlcF91cGRhdGVfcnVsZXMoc3RydWN0IHJ2dSAqcnZ1LCB1
MTYgcGNpZnVuYywgYm9vbCBlbmEpDQo+PiArew0KPj4gKwlzdHJ1Y3QgcnZ1X3N3aXRjaCAqcnN3
aXRjaCA9ICZydnUtPnJzd2l0Y2g7DQo+PiArCXN0cnVjdCBucGNfbWNhbSAqbWNhbSA9ICZydnUt
Pmh3LT5tY2FtOw0KPj4gKwl1MzIgbWF4ID0gcnN3aXRjaC0+dXNlZF9lbnRyaWVzOw0KPj4gKwlp
bnQgYmxrYWRkcjsNCj4+ICsJdTE2IGVudHJ5Ow0KPj4gKw0KPj4gKwlpZiAoIXJzd2l0Y2gtPnVz
ZWRfZW50cmllcykNCj4+ICsJCXJldHVybjsNCj4+ICsNCj4+ICsJYmxrYWRkciA9IHJ2dV9nZXRf
YmxrYWRkcihydnUsIEJMS1RZUEVfTlBDLCAwKTsNCj4+ICsNCj4+ICsJaWYgKGJsa2FkZHIgPCAw
KQ0KPj4gKwkJcmV0dXJuOw0KPj4gKw0KPj4gKwlydnVfc3dpdGNoX2VuYWJsZV9sYmtfbGluayhy
dnUsIHBjaWZ1bmMsIGVuYSk7DQo+PiArCW11dGV4X2xvY2soJm1jYW0tPmxvY2spOw0KPj4gKwlm
b3IgKGVudHJ5ID0gMDsgZW50cnkgPCBtYXg7IGVudHJ5KyspIHsNCj4+ICsJCWlmIChyc3dpdGNo
LT5lbnRyeTJwY2lmdW5jW2VudHJ5XSA9PSBwY2lmdW5jKQ0KPj4gKwkJCW5wY19lbmFibGVfbWNh
bV9lbnRyeShydnUsIG1jYW0sIGJsa2FkZHIsIGVudHJ5LCBlbmEpOw0KPj4gKwl9DQo+PiArCW11
dGV4X3VubG9jaygmbWNhbS0+bG9jayk7DQo+PiArfQ0KPj4gKw0KPj4gK2ludCBydnVfcmVwX3Bm
X2luaXQoc3RydWN0IHJ2dSAqcnZ1KQ0KPj4gK3sNCj4+ICsJdTE2IHBjaWZ1bmMgPSBydnUtPnJl
cF9wY2lmdW5jOw0KPj4gKwlzdHJ1Y3QgcnZ1X3BmdmYgKnBmdmYgPSBydnVfZ2V0X3BmdmYocnZ1
LCBwY2lmdW5jKTsNCg0KPm5pdDogSXQgd291bGQgYmUgbmljZSB0byBtYWludGFpbiByZXZlcnNl
IHhtYXMgdHJlZSBvcmRlciAtIGxvbmdlc3QgbGluZSB0bw0KPiAgICBzaG9ydGVzdCAtIGZvciBs
b2NhbCB2YXJpYWJsZSBkZWNsYXJhdGlvbnMgaW4gdGhpcyBmaWxlLg0KPg0KPiAgICAgSGVyZSwg
SSB0aGluayB0aGF0IGNvdWxkIGJlIChjb21wbGV0ZWx5IHVudGVzdGVkISk6DQo+DQo+CXUxNiBw
Y2lmdW5jID0gcnZ1LT5yZXBfcGNpZnVuYzsNCj4Jc3RydWN0IHJ2dV9wZnZmICpwZnZmOw0KPg0K
PglwZnZmID0gcnZ1X2dldF9wZnZmKHJ2dSwgcGNpZnVuYyk7DQo+DQpXaWxsIGZpeCBpdCBpbiB0
aGUgbmV4dCB2ZXJzaW9uLiANCg0KPiAgICAgRWR3YXJkIENyZWUncyB0b29sIGlzIHVzZWZ1bCBo
ZXJlOg0KPiAgICAgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0
dHBzLTNBX19naXRodWIuY29tX2VjcmVlLT4yRHNvbGFyZmxhcmVfeG1hc3RyZWUmZD1Ed0lCQWcm
Yz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9VWlFdF9uVWVZRmN0dTdKVkxYVmxYRGhUbXFfRUFm
b29hWkVZSW5mR3VFUSZtPTN0OGFFV0J4MC0+RUU0MEp4Y3ltdWpZZm5yNDM4MVZaMnhyd0t5d1BK
ZEN4aVZFQ3BvUmVkS2l6bmNyel9LRE9QJnM9ZWtFcUxlM2k2ZE1WcW1nMFRRa2JxdjhSX0Mxa0tl
d2lzM0R3Z2h2US1vdyZlPQ0KPg0KPj4gKw0KPj4gKwlzZXRfYml0KE5JWExGX0lOSVRJQUxJWkVE
LCAmcGZ2Zi0+ZmxhZ3MpOw0KPj4gKwlydnVfc3dpdGNoX2VuYWJsZV9sYmtfbGluayhydnUsIHBj
aWZ1bmMsIHRydWUpOw0KPj4gKwlydnVfcmVwX3J4X3ZsYW5fY2ZnKHJ2dSwgcGNpZnVuYyk7DQo+
PiArCXJldHVybiAwOw0KPj4gK30NCg0KLi4uDQo=

