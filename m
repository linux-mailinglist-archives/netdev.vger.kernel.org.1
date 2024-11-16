Return-Path: <netdev+bounces-145586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A139D000D
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 18:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E811FB21A1B
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B318755C;
	Sat, 16 Nov 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ypk11mhD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEB80B;
	Sat, 16 Nov 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731777743; cv=fail; b=j81IMdTQXSIBZZcPn5XDGipQN5evyUS295Kz0232dkhneUbEek73cNrG+KFyr6bgZLnfsD4T70jx53+2iU3YU8GmyRTgM3OvSjVwr6sJLUuefHBcxokSsdVpmVN5dwV/jEQu3vf4ziDtldHufvNLgSW9kGscrKoEb8uQAw3UyK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731777743; c=relaxed/simple;
	bh=A0RtAFrOafMjWWn7fzruMeeb04JXU5IKLXsq/67JgIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GOg70jW1DcMvuhYlD1n40qF/CY2z0TREHc5E2Ce9/iaPRDZSrSpG9wRMXhmKGPpn7Nqdyf/iWP/R+aDuF5BLdPWj8ptfAY48YYtdP9hddoR5pNUqvEhw2DQfuWgBEnZ8dOIddokrmTj2jwFeVhceRXaVwqeVIiXfGMrA+dyuwhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ypk11mhD; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGGqE65028559;
	Sat, 16 Nov 2024 09:21:54 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42xsmqrbnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 09:21:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6hHu01J614Z6L7X0OIC4Iorc+lEqw2CHT3FQQV7/DdVvj+SByO+Bt2/1xwMqztz+LTeHR7EoZG7hdmsNAhfsYJFPLoWPEmcGH7LMTWrGs15oI8YhwkqaA6tz/Jm+GIink7zUC1QU2ahTxObKSgPebl65K+wmJ9xqHXAxlTAhGd+vuBOv5BXWfsWWMsiD0KtpWcTTMzvvvxAnGrv3hfTCeMz9Eh4NhuJUFobE/tiTYzui4w8rAEMVMWclxNM1kZX+kXdRfXjOc+N13ApaO4wJapo+lUK0+cvpvHiyhkNCrPkEWTBxaF/Ixi4+2jxC2hJ0Ngs2t9QMF7L1YtJ93edkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0RtAFrOafMjWWn7fzruMeeb04JXU5IKLXsq/67JgIc=;
 b=PyYuUh507Qp1lC+EHgy0bnKUNfr3LLE7tKrq0Y4qEktHmChXUdZWVCBpiI//2ja179WQgWAld5V7wHUbdxyZ7A0js+FhCaAzMOZVX3aicM3TSf4FoVnyLyYcL1Y53lpzCLf3u0StHcytPlEea6VEfaubanQkdc5yN272qoetvkJ59gOT02ida7E/jfS3/c5qPjYDca7UuOET+xapkInAxqNdKwFmDEYco73ZKCe3yU37GNOiFjy37730NYOWB/xV7CLJv9ZtLo6eitR127uxndOHS9ldsG/KDutKqHoz+C7aRGC5cPDN2BIgxf5tOMzKdV3/KzrgWbCd7MW4UBm6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0RtAFrOafMjWWn7fzruMeeb04JXU5IKLXsq/67JgIc=;
 b=Ypk11mhDL3NuHDVZifB51E1QnWjlwpgwi4efbMsyfWyCduDLO89lwrEc8Eyq+ZkMhMX/v2HLfnO6po5MplEDTHBADlEz0QGYwu1e0c8grhZepPc1HRFRIiluIF6v1x/8RlWAxJZBCnTH+p2WUFW1gZdR3K31yBn+iR+UNQa6eak=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by PH7PR18MB5648.namprd18.prod.outlook.com (2603:10b6:510:2f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Sat, 16 Nov
 2024 17:21:51 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd%3]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 17:21:51 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar
	<vimleshk@marvell.com>,
        "thaller@redhat.com" <thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "einstein.xue@synaxg.com" <einstein.xue@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2] octeon_ep: add ndo ops for VFs
 in PF driver
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2] octeon_ep: add ndo ops for
 VFs in PF driver
Thread-Index: AQHbNTRT7wyQ9TM+tUqhITRYt5+/G7K3rzQAgAJ8sgA=
Date: Sat, 16 Nov 2024 17:21:51 +0000
Message-ID:
 <PH0PR18MB47344F6BCCD1B629AC012065C7252@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20241112185432.1152541-1-srasheed@marvell.com>
 <20241114191648.34410e79@kernel.org>
In-Reply-To: <20241114191648.34410e79@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|PH7PR18MB5648:EE_
x-ms-office365-filtering-correlation-id: bed67a61-483c-418e-5764-08dd066328b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWV4WW42akFLSzFFN3I0QW9NTzI1T0dpOWJTR29VOGl4aEtQd1ora2doWTZo?=
 =?utf-8?B?VjVnRGVHeGdVcHhCKzBqR3ZqZmMzajFQMW94ZHI5bi84U1Mza0JCOENRNitn?=
 =?utf-8?B?blFFOVRWKzg1TkFvNXZ1dVM1ZGFxT2pKbGd5bjRQNWg2a21PUWhuaWh4S1pU?=
 =?utf-8?B?dWMzZk5XdWQwK2d1aFBPU0xDTkpISDlYYkNmeFFZSTFOSUtQSkZlM2RzVllX?=
 =?utf-8?B?S0ViQUNBZHgrVVp1ZkdMQ092UjI4bkcxYWJoY1E3SDJ1M2JOSnhkUEpLRXI2?=
 =?utf-8?B?YVhYQ3o2TXRjcGZTZVViQUovTWVybXA3dW0zNGtLN3dvS1RsQlg5NmdTS1Nw?=
 =?utf-8?B?R05aNVlHMXhKSC9QZm80dlprNXovUm5sK1dKQ3ZsZnliRVpqblpTc1BmOTl1?=
 =?utf-8?B?ZHhiVlVieXcyRnpSNncyRkhuMnNpVWczRXg1a045TWZVTldVY3d0Y1ZaSi9o?=
 =?utf-8?B?SzNPQTVjMzYwRTlYV2NIM0FGVGYxY3Vuay9tOHhDWHp1WWRhcjJsRmRMeEZi?=
 =?utf-8?B?OGU3UDV6TXY5ZHgrcjM0dk9QNUJaQUFST2gwa3d1aDVlaGxPbEZucTB0b0hx?=
 =?utf-8?B?MFo2NnI2UCs1RmxrNEtHTmljVm5Rd01RTjl5SFY0dlBkRDdnYTNpWU5FUFVx?=
 =?utf-8?B?QTIyY2VXSTkzRTdwbnlndmhqczZ4WnE3MHNEaFAwZFhNR2RlRXMzK1gyaDc2?=
 =?utf-8?B?dG5mNlVqNHFFdC85anJYNVFIQ1BtazF5RFhZU0YzbnZhamVPTXlTVWdVcytr?=
 =?utf-8?B?cDFwcisxZTliRlluUUx1MDJSWGVaaVB1dUhURDV5STlDVTBONEJnWEhqaExO?=
 =?utf-8?B?UWdXZ1ZKU3lnMTJTMEFoR2hjZFFqbm0rS3laSm1ySzY0MmZqOFNGZjRMeE1G?=
 =?utf-8?B?Y3ZwSSsyMmxpTkM3ajhxckJJVUhaMGNNcGt4Ymd1WUlRWXI2eWo3cmhTbVV4?=
 =?utf-8?B?Tkp4THR1dXlVdmQxRi9VMHJIUGRaRHJ3UFdOdjcvNjZONnZrVlNNMVVvK0tv?=
 =?utf-8?B?ZjA2WlpWWnMraXV2OGZHTjd6NzlZN2IxVTVQVlNCdWNFV1BqZ2JkNXZPa0pn?=
 =?utf-8?B?VTIvbXpsMTA0OEx4QkhzRGc1c01yQU9BM0IrUm1ZdDNrbEpBVmp5OWFSRElF?=
 =?utf-8?B?SFNRVTV2Sk9LQnlqVEkzUzRYaXEvN00wa2RDcStRMGpYSHdJS0xid3FwaHB1?=
 =?utf-8?B?K3JwUjNTSmpvZCtGUVJtelUvQ1B0Z0V2SHNTbmtJbDIzTzM0UDQ3emdOSUw0?=
 =?utf-8?B?ZnpKZnBDRUY3VUNESGNvN3hYMWpIclNDRGF0amJITmo0MkVrNVNzVGRqa0o5?=
 =?utf-8?B?azkrRFlTYzRRR3pWSXNZekovNzdKVjVRRkJuZnMxRmtreGpyQVBBZHRrVVZZ?=
 =?utf-8?B?bjJPVGtnSkVlNldHT1o2ZHUxWW5Ka3VyVEhMNEZtcERYUVAyYnYvOXppbitq?=
 =?utf-8?B?YnR3UStZYndpeFdsZU9KWG84cmo2ZmhseVd1bEpsQ2hBL0JveEhJUHFNVlNr?=
 =?utf-8?B?T3VNUEU1eWlEcHdkM2VaeUQreGVzeVhHOFhSakZqZTZDLzErelNPbWVGZEFj?=
 =?utf-8?B?ODNjaVpiMm5kcDZIZTdzNXFrektKMnF1b2JGRkh3MXpwMVNjeFNjSGNZcUxJ?=
 =?utf-8?B?eXJxK1FtaXE5TVpvVHZxTzVBSXBJZWxHRnR2QmdFaWIzY0NPY2REc2ZCU3gz?=
 =?utf-8?B?UlR1bkd3QytnVktmWlM0Y3NOUS9MTnAvSGk2ZElwcXo4WW80SU1KRDNKRE42?=
 =?utf-8?B?UEt1MlI0WnlLM3RWdUVSdFkycGhwU1RObVJSUUpaemVZWjVycmZvMkw0SnlG?=
 =?utf-8?Q?cB28AOeVbKsNox7G3Xota+507t4Zrrzk/H/WM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXNmYmEwWFl2aGZ5dFFOUmlWK24rY29XaVNUMThpNW1OR3lOL0R5KzRQcGZF?=
 =?utf-8?B?V2RjWjhRRUpVV0hTdzI1RVhIWWQvSC91WS9YdUJqazB4bldzV0U4VWRoREdH?=
 =?utf-8?B?aFNGT0xkTWtNZUljRjhXbi9QcDFBb3Zjd3ZXTUpGeERDcExadzNrb2lqRWU0?=
 =?utf-8?B?OGxxOUltSlRqdWRGRTMyRDZWalo4U2J5TnlzK3hTU0Y4YnpIZ1lCeXc2TWZN?=
 =?utf-8?B?SFlKSEJlMFJhZGFqaXMvRFhSYW01cENiS2Z4cCtpL01QL1RubU1laTdTY3hX?=
 =?utf-8?B?djZ3eXlBRlgxdWdIMHhRSnBFVy9SaVB4MHhiZXBsL1NTRE9NUFU2UHg2WVNh?=
 =?utf-8?B?aHdwQkpmRVBYY1RFQXdsYUs4NDZlWnlYTnBwanc2QS9pRW9qM09UVUI2Nnlw?=
 =?utf-8?B?akRZTThaeGF5RWlsaDI4akJCcUo0OFBVNVhyb2ZPQ3JvOU14bWQrNCs0Qmdv?=
 =?utf-8?B?aGNucTk1M0lNTkJpc3pxazEvREhYZkd5YWpjaTNNREo2MzlqYytiN2pKOTU5?=
 =?utf-8?B?azdTUGIyL0owMWtnNHZ1YURIMmpuU1ZHRXBmSUxpSUNzL0hsNWN2QUpvR1dJ?=
 =?utf-8?B?cmxRVkFFbUk0eXROWHBjTU11SWlJcUhUbE56bkhiN3dhYUdPNFlSSi8reWM3?=
 =?utf-8?B?N00wSkVya0pHdkk1V1FlZEFTMmFKUEpPY2NGWDdMd3JqNjZWRFlrZk44aFRw?=
 =?utf-8?B?aWVCMDBvL3FJNnJnZHJFZVpLNmk5N1hDM0hhSUhueEhpNDdWcHRsb2YwUW9i?=
 =?utf-8?B?MXBYQWwrT0dQcHk1aU1vcTA2bXZ1RVcyN0ZUWllRdXZEQjFDUkc3aVlQMkow?=
 =?utf-8?B?UC9qNVpiT3hWUEVvaExaV1BoS3diWTZ6VXFTZHM5TVg5YU4yNk84dUdqN2ls?=
 =?utf-8?B?SkRHLzJwTHFWUzl1dkV2TE9BVEpSaE1CSWNLb3R2Tzc1NGY1RXhpTlhQaXVM?=
 =?utf-8?B?TXJSZ1BKeUh6aW04MVMzc3lzS1MwU3JtUGhOVEhDUU8yWkZRRCt3cnJualJK?=
 =?utf-8?B?bGV5K0U2MFliSXR3NmFqQWQ4K2ltcUZsUTFsbVZFNWZ6UHJ2V214U1AzSW0z?=
 =?utf-8?B?VDQ1UlErR0Q1bzNMUStrVGdTVE5jTlJNRnl1RE5hY1QxaXNoVXM4ci9HVlVv?=
 =?utf-8?B?UDBORFNkcnhralZ6OEZPbjZPdEtJQWNybWpEM0pPUkRrYW5BK1RkcTV4ZU1q?=
 =?utf-8?B?SVhKazB4ZDZvYUNZZ2VzL2UvRHUvaS9kUis5dUE5dnpIL0lRM09TRWM1eHhv?=
 =?utf-8?B?UkU1YlFzb0g5c25tbXlmWEtsZFRKeVU4SDFUWGc4SHNZMVl2dGZpbDJsMjFG?=
 =?utf-8?B?Y2pwY0N6ZFEyWmx5Y1M2bHNUUm92cmJuVUJFL2h0N3BaT1NWamhzVVVNanU3?=
 =?utf-8?B?bXd2M29SY0NUczMyM2g2UnU0ckliYUNvS2hKZy8vVjd4ZFJuUHRLNXFDVWRt?=
 =?utf-8?B?TlNsVUpIZy9MVXE5YTA1ekkyMTZvakFYSWF0d2xtZWJYb3F2ekxQUUFTZ3JR?=
 =?utf-8?B?K0JWblZucFRIbEZ3N0FxM2lyYWNvYkhodDFmRnV4d2UrZGZvZnU1eHhtZ3hV?=
 =?utf-8?B?MTBMZThvUUUwVldkNjZwY2drMlIyWjlYZlUzUVBhS08wZWJ5VG5YOGhrbVJl?=
 =?utf-8?B?cTQ5QVFqT3NNNEZhWXRlazE5WmlleVNybDBKbDhHUU5MY1ovMU5aaTViZ2ZN?=
 =?utf-8?B?aDJGZE9lWDFwZXZPc3l3dGtCbVpaeHV4M0ZXRFJ4YnpIRnhqeHpmdDIxZStK?=
 =?utf-8?B?eHVLbG8wSDNnSkxZd1BXSXRQN2UwMDREejFFU3ZZbTNrUTZlSksrMkxIcWcw?=
 =?utf-8?B?K2RpZU1adlowbFpERm8xVWdwSWc1TDlrVXQvU3Z0NDdldE50STgwRG5hOVJp?=
 =?utf-8?B?VTBiOTY2Mndkd1NKckc4clc0cTJ0aTNmTWg2RERYQ2IwSjVEdUU2VEdDYWxB?=
 =?utf-8?B?WVZHVlRDQnAzYWNHK3MxR2NBNk9uVlBqTGlMQ096TjZQelZ1MHNKcEFXL1NT?=
 =?utf-8?B?V3BwQi9FUjhqQ3crdlYxK291V0d0UExwT21VbjRGdnUwbDFqK2FqOGFkMFBZ?=
 =?utf-8?B?WmZORW9rV2RkZE10VnpiRlZwQ3kxYW1jenFDeWhEMm1pQWVTa1hCYUJzM1Bq?=
 =?utf-8?Q?VieI8tboZFB89o8C7TpwJM03Q?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed67a61-483c-418e-5764-08dd066328b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2024 17:21:51.0929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QNt/dnzEsq8WjvTekZy1D9NHSIdwnNJNvN+vyX7/UsuotHY2jTqyglmrJgusMb1OUDrVJo9gNop5iA03p4vyKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5648
X-Proofpoint-ORIG-GUID: FUz-WnkzQN4mt-5cl0as42q8O9MXwtUD
X-Proofpoint-GUID: FUz-WnkzQN4mt-5cl0as42q8O9MXwtUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

SGkgSmFrdWIsDQoNCj4gT24gVHVlLCAxMiBOb3YgMjAyNCAxMDo1NDozMSAtMDgwMCBTaGluYXMg
UmFzaGVlZCB3cm90ZToNCj4gPiBUaGVzZSBBUElzIGFyZSBuZWVkZWQgdG8gc3VwcG9ydCBhcHBs
aWNhdGlvbnMgdGhhdCB1c2UgbmV0bGluayB0byBnZXQgVkYNCj4gPiBpbmZvcm1hdGlvbiBmcm9t
IGEgUEYgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hpbmFzIFJhc2hlZWQgPHNy
YXNoZWVkQG1hcnZlbGwuY29tPg0KPiANCj4gPiArc3RhdGljIGludCBvY3RlcF9nZXRfdmZfY29u
ZmlnKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGludCB2Ziwgc3RydWN0DQo+IGlmbGFfdmZfaW5m
byAqaXZpKQ0KPiANCj4gUGxlYXNlIGRvbid0IGdvIG92ZXIgODAgY2hhcnMgZm9yIG5vIGdvb2Qg
cmVhc29uLg0KPiB1c2UgY2hlY2twYXRjaCB3aXRoIC0tc3RyaWN0IC0tbWF4LWxpbmUtbGVuZ3Ro
PTgwDQo+IA0KQUNLDQoNCj4gPiArew0KPiA+ICsJc3RydWN0IG9jdGVwX2RldmljZSAqb2N0ID0g
bmV0ZGV2X3ByaXYoZGV2KTsNCj4gPiArDQo+ID4gKwlpdmktPnZmID0gdmY7DQo+ID4gKwlldGhl
cl9hZGRyX2NvcHkoaXZpLT5tYWMsIG9jdC0+dmZfaW5mb1t2Zl0ubWFjX2FkZHIpOw0KPiA+ICsJ
aXZpLT52bGFuID0gMDsNCj4gPiArCWl2aS0+cW9zID0gMDsNCj4gDQo+IG5vIG5lZWQgdG8gY2xl
YXIgdGhlc2UgZmllbGRzDQo+IA0KQUNLDQoNCj4gPiArCWl2aS0+c3Bvb2ZjaGsgPSAwOw0KPiA+
ICsJaXZpLT5saW5rc3RhdGUgPSBJRkxBX1ZGX0xJTktfU1RBVEVfRU5BQkxFOw0KPiA+ICsJaXZp
LT50cnVzdGVkID0gdHJ1ZTsNCj4gDQo+IHNvIHlvdSBzZXQgc3Bvb2ZjaGsgdG8gMCBhbmQgdHJ1
c3RlZCB0byB0cnVlLCBpbmRpY2F0aW5nIG5vDQo+IGVuZm9yY2VtZW50IFsxXQ0KPiANCldpbGwg
Zml4IHRoaXMgaW4gbmV4dCBwYXRjaA0KDQo+ID4gKwlpdmktPm1heF90eF9yYXRlID0gMTAwMDA7
DQo+ID4gKwlpdmktPm1pbl90eF9yYXRlID0gMDsNCj4gDQo+IFdoeSBhcmUgeW91IHNldHRpbmcg
bWF4IHJhdGUgdG8gYSBmaXhlZCB2YWx1ZT8NCj4gDQoNClRoaXMgaXMgdGhlIG1heCB0eCByYXRl
IHdlIG9mZmVyIGZvciBWRnMNCg0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgaW50IG9jdGVwX3NldF92Zl9tYWMoc3RydWN0IG5ldF9kZXZpY2UgKmRl
diwgaW50IHZmLCB1OCAqbWFjKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qgb2N0ZXBfZGV2aWNlICpv
Y3QgPSBuZXRkZXZfcHJpdihkZXYpOw0KPiA+ICsJaW50IGVycjsNCj4gPiArDQo+ID4gKwlpZiAo
IWlzX3ZhbGlkX2V0aGVyX2FkZHIobWFjKSkgew0KPiA+ICsJCWRldl9lcnIoJm9jdC0+cGRldi0+
ZGV2LCAiSW52YWxpZCAgTUFDIEFkZHJlc3MgJXBNXG4iLA0KPiBtYWMpOw0KPiA+ICsJCXJldHVy
biAtRUFERFJOT1RBVkFJTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlkZXZfZGJnKCZvY3QtPnBk
ZXYtPmRldiwgInNldCB2Zi0lZCBtYWMgdG8gJXBNXG4iLCB2ZiwgbWFjKTsNCj4gPiArCWV0aGVy
X2FkZHJfY29weShvY3QtPnZmX2luZm9bdmZdLm1hY19hZGRyLCBtYWMpOw0KPiA+ICsJb2N0LT52
Zl9pbmZvW3ZmXS5mbGFncyB8PSAgT0NURU9OX1BGVkZfRkxBR19NQUNfU0VUX0JZX1BGOw0KPiAN
Cj4gZG91YmxlIHNwYWNlDQo+IA0KDQpBQ0sNCg0KPiA+ICsNCj4gPiArCWVyciA9IG9jdGVwX2N0
cmxfbmV0X3NldF9tYWNfYWRkcihvY3QsIHZmLCBtYWMsIHRydWUpOw0KPiA+ICsJaWYgKGVycikN
Cj4gPiArCQlkZXZfZXJyKCZvY3QtPnBkZXYtPmRldiwgIlNldCBWRiVkIE1BQyBhZGRyZXNzIGZh
aWxlZCB2aWENCj4gaG9zdCBjb250cm9sIE1ib3hcbiIsIHZmKTsNCj4gPiArDQo+ID4gKwlyZXR1
cm4gZXJyOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG5ldF9kZXZp
Y2Vfb3BzIG9jdGVwX25ldGRldl9vcHMgPSB7DQo+ID4gIAkubmRvX29wZW4gICAgICAgICAgICAg
ICAgPSBvY3RlcF9vcGVuLA0KPiA+ICAJLm5kb19zdG9wICAgICAgICAgICAgICAgID0gb2N0ZXBf
c3RvcCwNCj4gPiBAQCAtMTE0Niw2ICsxMTg0LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBuZXRf
ZGV2aWNlX29wcw0KPiBvY3RlcF9uZXRkZXZfb3BzID0gew0KPiA+ICAJLm5kb19zZXRfbWFjX2Fk
ZHJlc3MgICAgID0gb2N0ZXBfc2V0X21hYywNCj4gPiAgCS5uZG9fY2hhbmdlX210dSAgICAgICAg
ICA9IG9jdGVwX2NoYW5nZV9tdHUsDQo+ID4gIAkubmRvX3NldF9mZWF0dXJlcyAgICAgICAgPSBv
Y3RlcF9zZXRfZmVhdHVyZXMsDQo+ID4gKwkvKiBmb3IgVkZzICovDQo+IA0KPiB3aGF0IGRvZXMg
dGhpcyBjb21tZW50IGFjaGlldmU/DQo+IA0KDQpXaWxsIHJlbW92ZQ0KDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVwX3BmdmZfbWJv
eC5oDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAvb2N0ZXBfcGZ2
Zl9tYm94LmgNCj4gPiBpbmRleCAwZGM2ZWVhZDI5MmEuLjMzOTk3N2M3MTMxYSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9wZnZm
X21ib3guaA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2Vw
L29jdGVwX3BmdmZfbWJveC5oDQo+ID4gQEAgLTIzLDYgKzIzLDkgQEAgZW51bSBvY3RlcF9wZnZm
X21ib3hfdmVyc2lvbiB7DQo+ID4NCj4gPiAgI2RlZmluZSBPQ1RFUF9QRlZGX01CT1hfVkVSU0lP
Tl9DVVJSRU5UDQo+IAlPQ1RFUF9QRlZGX01CT1hfVkVSU0lPTl9WMg0KPiA+DQo+ID4gKy8qIFZG
IGZsYWdzICovDQo+ID4gKyNkZWZpbmUgT0NURU9OX1BGVkZfRkxBR19NQUNfU0VUX0JZX1BGICBC
SVRfVUxMKDApIC8qIFBGIGhhcyBzZXQgVkYNCj4gTUFDIGFkZHJlc3MgKi8NCj4gDQo+IFsyXSBi
dXQgdGhlIGJpdCBkZWZpbml0aW9uIHVzZXMgVUxMID8NCj4gDQoNCldpbGwgZml4IGluIG5leHQg
cGF0Y2gNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMNCg==

